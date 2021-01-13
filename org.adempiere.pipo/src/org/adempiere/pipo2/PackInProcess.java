/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert KLEIN.  robeklein@hotmail.com
 *
 *****************************************************************************/

package org.adempiere.pipo2;

import java.io.File;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.tools.FileUtil;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 * IntPackIn Tool.
 *
 * @author: Robert KLEIN. robeklein@hotmail.com
 */
public class PackInProcess extends SvrProcess {

	/** Logger */
	private static final CLogger log = CLogger.getCLogger(PackInProcess.class);
	//update system maintain dictionary, default to false
	private boolean m_UpdateDictionary = false;
	private String m_packageDirectory = null;
	public int p_PackIn_ID = 0;

	@SuppressWarnings("unused")
	private String packageName = null;
	private String packageVersion = null;

	public PackInProcess() {
		super();
	}

	protected void prepare() {

		p_PackIn_ID = getRecord_ID();
		ProcessInfoParameter[] params = getParameter();
		if (params != null && params.length > 0) {
			for(ProcessInfoParameter param : params) {
				if ("Name".equals(param.getParameterName())) {
					packageName = param.getParameter().toString();
				} else if ("Version".equals(param.getParameterName())) {
					packageVersion = param.getParameter().toString();
				}
			}
		}
	} // prepare

	/**
	 * Doit
	 *
	 * @return ""
	 *
	 */
	protected String doIt() throws Exception {

		X_AD_Package_Imp_Proc adPackageImp = new X_AD_Package_Imp_Proc(getCtx(), p_PackIn_ID, null);  // out of trx

		// Create Target directory if required
		String packageDirectory = adPackageImp.getAD_Package_Dir();
		if (packageDirectory == null || packageDirectory.trim().length() == 0) {
			packageDirectory = System.getProperty("java.io.tmpdir");
		}

		String targetDirName = packageDirectory + File.separator + "packin" + Env.getContext(getCtx(), Env.AD_USER_ID);
		File targetDir = new File(targetDirName);

		if (targetDir.exists()) {
			if (!FileUtil.deleteFolderRecursive(targetDir)) {
				throw new AdempiereSystemError("Could not delete folder " + targetDirName + ", please check permissions");
			}
		}
		if (!targetDir.exists()) {
			boolean success = targetDir.mkdirs();
			if (!success) {
				log.warning("Failed to create target directory. " + targetDirName);
			}
		}

		MAttachment attachment = adPackageImp.getAttachment();
		if (attachment == null) {
			return "Please attach the pack out archive before running the process";
		}
		
		MAttachmentEntry entry = attachment.getEntry(0);
		if (entry == null) {
			return "Please attach the pack out archive before running the process";
		}
				
		// Unzip package
		File zipFilepath = entry.getFile();
		if (log.isLoggable(Level.INFO)) log.info("zipFilepath->" + zipFilepath);
		String parentDir = Zipper.getParentDir(zipFilepath);
		Zipper.unpackFile(zipFilepath, targetDir);

		String dict_file = packageDirectory + File.separator
				+ "packin" + Env.getContext(getCtx(), Env.AD_USER_ID) + File.separator + parentDir + File.separator
				+ "dict" + File.separator + "PackOut.xml";

		if (log.isLoggable(Level.INFO)) log.info("dict file->" + dict_file);

		if (adPackageImp.isAD_Override_Dict() == true)
			m_UpdateDictionary = true;
		else
			m_UpdateDictionary = false;

		m_packageDirectory = packageDirectory + File.separator
				+ "packin" + Env.getContext(getCtx(), Env.AD_USER_ID) + File.separator + parentDir + File.separator;

		PackIn packIn = new PackIn();
		packIn.setPackageDirectory(m_packageDirectory);
		packIn.setPackageName(adPackageImp.getName());
		packIn.setPackageVersion(packageVersion);
		packIn.setUpdateDictionary(m_UpdateDictionary);
		packIn.getNotifier().setFileName(zipFilepath.getName());
		packIn.setAD_Package_Imp_Proc(adPackageImp);

		// call XML Handler
		String msg;
		try {
			msg = packIn.importXML(dict_file, getCtx(), get_TrxName());
			adPackageImp.setDateProcessed(new Timestamp(System.currentTimeMillis()));
			adPackageImp.setP_Msg(msg);
			adPackageImp.saveEx();
			commitEx(); // we need to commit to capture HERE when the deferred validation of foreign keys can fail
		} catch (Exception e) {
			adPackageImp.setP_Msg(e.getLocalizedMessage());
			packIn.getNotifier().addFailureLine(e.getLocalizedMessage());
			packIn.setSuccess(false);
			log.log(Level.SEVERE, "importXML:", e);
			throw e;
		} finally {
			adPackageImp.save(); // ignoring exceptions
			packIn.getNotifier().notifyRecipient();
		}
		return msg;
	} // doIt
} // PackInProcess
