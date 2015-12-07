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
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
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

	CLogger logger = CLogger.getCLogger(PipoDictionaryService.class.getName());

	private final Semaphore semaphore;
	
	public PipoDictionaryService() {
		super();
		semaphore = new Semaphore(1, true);
	}

	@Override
	public void merge(BundleContext context, File packageFile) throws Exception {
		if (packageFile == null || !packageFile.exists()) {
			logger.info("No PackIn Model found");
			return;
		}
		String trxName = null;
		X_AD_Package_Imp_Proc adPackageImp = null;
		PackIn packIn = null;
		try {
			try {
				semaphore.tryAcquire(120, TimeUnit.SECONDS);
			} catch (InterruptedException e) {
				semaphore.release();
				semaphore.acquire();
			}
			trxName = Trx.createTrxName("PipoDS");
			packIn = new PackIn();
			packIn.setPackageName(context.getBundle().getSymbolicName());
			
			if (Env.getCtx().getProperty("#AD_Client_ID") == null) {
				Env.getCtx().put("#AD_Client_ID", 0);
			}
			//get package version from file name suffix or bundle header
			String packageVersion = null;
			String fileName = packageFile.getName();
			int versionSeparatorPos = fileName.lastIndexOf("_");
			if (versionSeparatorPos > 0) {
				int dotPos = fileName.lastIndexOf(".");
				if (dotPos > 0 && dotPos > versionSeparatorPos) {
					String version = fileName.substring(versionSeparatorPos+1, dotPos);
					if (version.split("[.]").length == 3) {
						packageVersion = version;
					}
				}
			}
			//no version string from file name suffix, get it from bundle header
			if (packageVersion == null)
				packageVersion = (String) context.getBundle().getHeaders().get("Bundle-Version");
			
			packIn.setPackageVersion(packageVersion);
			packIn.setUpdateDictionary(false);
			packIn.getNotifier().setFileName(packageFile.getName());
			packIn.getNotifier().setPluginName(context.getBundle().getSymbolicName() + " v" + packageVersion);

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
			
			Trx.get(trxName, false).commit();
			if (logger.isLoggable(Level.INFO)) logger.info("commit " + trxName);
		} catch (Exception e) {
			adPackageImp.setP_Msg(e.getLocalizedMessage());
			packIn.getNotifier().addStatusLine(e.getLocalizedMessage());
			logger.log(Level.SEVERE, "importXML:", e);
			throw e;
		} finally {
			try {
				Trx.get(trxName, false).close();
			} catch (Exception e) {}
			semaphore.release();
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

}
