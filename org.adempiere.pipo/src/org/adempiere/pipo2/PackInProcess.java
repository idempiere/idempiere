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

import org.compiere.Adempiere;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.CLogger;

/**
 * IntPackIn Tool.
 *
 * @author: Robert KLEIN. robeklein@hotmail.com
 */
public class PackInProcess extends SvrProcess {

	/** Logger */
	private CLogger log = CLogger.getCLogger(getClass());
	//update system maintain dictionary, default to false
	private boolean m_UpdateDictionary = false;
	private String m_packageDirectory = null;
	public int p_PackIn_ID = 0;

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

		X_AD_Package_Imp_Proc adPackageImp = new X_AD_Package_Imp_Proc(getCtx(),
				p_PackIn_ID, get_TrxName());

		// Create Target directory if required
		String packageDirectory = adPackageImp.getAD_Package_Dir();
		if (packageDirectory == null || packageDirectory.trim().length() == 0) {
			packageDirectory = Adempiere.getAdempiereHome();
		}

		String targetDirName = packageDirectory + File.separator + "packin";
		File targetDir = new File(targetDirName);

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
		log.info("zipFilepath->" + zipFilepath);
		String parentDir = Zipper.getParentDir(zipFilepath);
		Zipper.unpackFile(zipFilepath, targetDir);

		String dict_file = packageDirectory + File.separator
				+ "packin" + File.separator + parentDir + File.separator
				+ "dict" + File.separator + "PackOut.xml";

		log.info("dict file->" + dict_file);

		if (adPackageImp.isAD_Override_Dict() == true)
			m_UpdateDictionary = true;
		else
			m_UpdateDictionary = false;

		m_packageDirectory = packageDirectory + File.separator
				+ "packin" + File.separator + parentDir + File.separator;

		PackIn packIn = new PackIn();
		packIn.setPackageDirectory(m_packageDirectory);
		packIn.setPackageName(packageName);
		packIn.setPackageVersion(packageVersion);
		packIn.setUpdateDictionary(m_UpdateDictionary);
		
		// call XML Handler
		String msg = packIn.importXML(dict_file, getCtx(), get_TrxName());
		if (adPackageImp.get_ColumnIndex("DateProcessed") > 0) {
			adPackageImp.set_ValueOfColumn("DateProcessed", new Timestamp(System.currentTimeMillis()));
		}
		if (adPackageImp.get_ColumnIndex("P_Msg") > 0)  {
			adPackageImp.set_ValueOfColumn("P_Msg", msg);
		}
		adPackageImp.saveEx();
		
		return msg;
	} // doIt
} // PackInProcess
