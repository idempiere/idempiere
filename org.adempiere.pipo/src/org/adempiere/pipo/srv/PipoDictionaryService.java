/******************************************************************************
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.pipo.srv;

import java.io.File;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.base.IDictionaryService;
import org.adempiere.pipo2.PackIn;
import org.adempiere.pipo2.Zipper;
import org.compiere.model.MAttachment;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.osgi.framework.BundleContext;

public class PipoDictionaryService implements IDictionaryService {

	private static final CLogger logger = CLogger.getCLogger(PipoDictionaryService.class.getName());

	public PipoDictionaryService() {
		super();
	}

	X_AD_Package_Imp_Proc adPackageImp = null;

	@Override
	public void merge(BundleContext context, File packageFile) throws Exception {
		if (packageFile == null || !packageFile.exists()) {
			logger.info("No PackIn Model found");
			return;
		}
		if (! packageFile.canRead()) {
			logger.severe("Cannot read file " + packageFile.getName());
			return;
		}
		String symbolicName = "org.adempiere.pipo";
		if (context != null)
			symbolicName = context.getBundle().getSymbolicName();
		String trxName = null;
		PackIn packIn = null;
		try {
			trxName = Trx.createTrxName("PipoDS");
			Trx.get(trxName, true).setDisplayName(getClass().getName()+"_merge");
			packIn = new PackIn();
			//external files must not start with "2Pack" prefix in order to work correctly
			if ("org.adempiere.pipo".equals(symbolicName)  &&  !packageFile.getName().startsWith("2Pack"))  
				packIn.setPackageName(packageFile.getName());
			else
				packIn.setPackageName(symbolicName);
			
			if (Env.getCtx().getProperty(Env.AD_CLIENT_ID) == null) {
				Env.getCtx().put(Env.AD_CLIENT_ID, 0);
			}
			//get package version from file name suffix or bundle header
			String packageVersion = null;
			String fileName = packageFile.getName();
			int versionSeparatorPos = fileName.lastIndexOf("2Pack_");
			if (versionSeparatorPos > 0) {
				int dotPos = fileName.lastIndexOf(".");
				if (dotPos > 0 && dotPos > versionSeparatorPos) {
					int extraInfoIndex = fileName.indexOf("_", versionSeparatorPos + 6);
					if (extraInfoIndex > 0)
						dotPos=extraInfoIndex;
					
					String version = fileName.substring(versionSeparatorPos+"2Pack_".length(), dotPos);
					if (version.split("[.]").length == 3) {
						packageVersion = version;
					}
				}
			}
			//no version string from file name suffix, get it from bundle header
			if (packageVersion == null && context != null)
				packageVersion = (String) context.getBundle().getHeaders().get("Bundle-Version");
			
			packIn.setPackageVersion(packageVersion);
			packIn.setUpdateDictionary(false);
			packIn.getNotifier().setFileName(packageFile.getName());
			packIn.getNotifier().setPluginName(symbolicName + " v" + packageVersion);

			adPackageImp = new X_AD_Package_Imp_Proc(Env.getCtx(), 0, null);
			if (logger.isLoggable(Level.INFO)) logger.info("zipFilepath->" + packageFile);
			String parentDir = Zipper.getParentDir(packageFile);
			File targetDir = new File(System.getProperty("java.io.tmpdir"));
			Zipper.unpackFile(packageFile, targetDir);

			String dict_file = targetDir + File.separator + parentDir + File.separator
					+ "dict" + File.separator + "PackOut.xml";
			
			packIn.setPackageDirectory(targetDir + File.separator + parentDir);

			if (logger.isLoggable(Level.INFO)) logger.info("dict file->" + dict_file);
			adPackageImp.setName(packIn.getPackageName());
			adPackageImp.setAD_Package_Source_Type("File");
			packIn.setAD_Package_Imp_Proc(adPackageImp); 

			// call XML Handler
			String msg = packIn.importXML(dict_file, Env.getCtx(), trxName);
			adPackageImp.setDateProcessed(new Timestamp(System.currentTimeMillis()));
			adPackageImp.setP_Msg(msg);
			
			Trx.get(trxName, false).commit(true);
			if (logger.isLoggable(Level.INFO)) logger.info("commit " + trxName);
		} catch (Exception e) {
			Trx.get(trxName, false).rollback();
			adPackageImp.setP_Msg(e.getLocalizedMessage());
			packIn.getNotifier().addFailureLine(e.getLocalizedMessage());
			packIn.setSuccess(false);
			logger.log(Level.SEVERE, "importXML:", e);
			throw e;
		} finally {
			try {
				Trx.get(trxName, false).close();
			} catch (Exception e) {}
			
			if (adPackageImp != null)
				adPackageImp.save(); // ignoring exceptions

			if (adPackageImp != null && packIn != null) {
				// Add the attachment to the packin for possible reprocessing
				if (MSysConfig.getBooleanValue(MSysConfig.ATTACH_EMBEDDED_2PACK, true) || ! packIn.isSuccess()) {
					// TODO: This sometimes fails with error No archive storage provider found - because the IAttachmentStore required is still not loaded
					MAttachment attachment = new MAttachment (adPackageImp.getCtx(), X_AD_Package_Imp_Proc.Table_ID, adPackageImp.getAD_Package_Imp_Proc_ID(), null);
					attachment.addEntry(packageFile);
					attachment.save(); // ignoring exceptions
				}
			}
			packIn.getNotifier().notifyRecipient();
		}

	}

	/*
	private String getPackageDir() {

		// Create Target directory if required
		String packageDirectory = Adempiere.getAdempiereHome();
		String result = packageDirectory + File.separator
				+ "packages";
		File docDir = new File( result+File.separator+"doc");

		if (!docDir.exists()) {
			boolean success = docDir.mkdirs();
			if (!success) {
				logger.info("Target directory creation failed");
			}
		}
		return result;
	}*/

	@Override
	public X_AD_Package_Imp_Proc getAD_Package_Imp_Proc() {
		return adPackageImp;
	};

}
