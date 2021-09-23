/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.               *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * Copyright (C)                                                              *
 * 2004 Robert KLEIN. robeklein@hotmail.com                                   *
 * Contributor(s): Low Heng Sin hengsin@avantz.com                            *
 *                 Teo Sarca teo.sarca@arhipac.ro, SC ARHIPAC SERVICE SRL     *
 *****************************************************************************/
package org.adempiere.pipo2;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.model.I_AD_EntityType;
import org.compiere.model.I_AD_Form;
import org.compiere.model.I_AD_ImpFormat;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.I_AD_Menu;
import org.compiere.model.I_AD_Message;
import org.compiere.model.I_AD_ModelValidator;
import org.compiere.model.I_AD_PrintFormat;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.I_AD_ReportView;
import org.compiere.model.I_AD_Role;
import org.compiere.model.I_AD_Table;
import org.compiere.model.I_AD_Val_Rule;
import org.compiere.model.I_AD_Window;
import org.compiere.model.I_AD_Workflow;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;

/**
 *	Convert AD to XML
 *
 *  @author Robert Klein
 *  @version $Id: PackOut.java,v 1.0
 *
 * Contributor: William G. Heath - Export of workflows and dynamic validations
 *
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1819315 ] PackOut: fix xml indentation not working
 * 			<li>BF [ 1819319 ] PackOut: use just active AD_Package_Exp_Detail lines
 */

public class PackOutProcess extends SvrProcess
{
	/** Record ID				*/
	private int p_PackOut_ID = 0;

	private MPackageExp packageExp;
	private String packoutDirectory;

    /**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		p_PackOut_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Start the transformation to XML
	 *	@return info
	 *	@throws Exception
	 */

	protected String doIt() throws java.lang.Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("doIt - AD_PACKAGE_EXP_ID=" + p_PackOut_ID);

		if (p_PackOut_ID == 0)
			throw new IllegalArgumentException("No Record");

		int processedCount = 0;
		String exportFile = "";
		try {

			packageExp = new MPackageExp(getCtx(), p_PackOut_ID, get_TrxName());

			if (packageExp.getAD_Package_Exp_ID() == p_PackOut_ID){
				//Create the package documentation
				packoutDirectory = System.getProperty("java.io.tmpdir");
				if (!packoutDirectory.endsWith("/") && !packoutDirectory.endsWith("\\"))
					packoutDirectory+= File.separator;
				packoutDirectory = packoutDirectory + "packout" + Env.getContext(getCtx(), Env.AD_USER_ID) + File.separator;

				//create packout folder if needed
				File packoutDirectoryFile = new File(packoutDirectory);
				if (!packoutDirectoryFile.exists()) {
					boolean success = packoutDirectoryFile.mkdirs();
					if (!success) {
						log.warning("Failed to create target directory. " + packoutDirectory);
					}
				}

				PackoutDocument packoutDocument = new PackoutDocument(packageExp.getName(), packageExp.getPK_Version(), packageExp.getReleaseNo(), packageExp.getVersion(),
						packageExp.getDescription(), packageExp.getInstructions(), packageExp.getUserName(),
						packageExp.getEMail(), packageExp.getCreated(), packageExp.getUpdated());
				List<PackoutItem> packoutItems = new ArrayList<PackoutItem>();
				Query query = new Query(getCtx(), MTable.get(getCtx(), X_AD_Package_Exp_Detail.Table_ID), "AD_Package_Exp_ID = ?", get_TrxName());
				List<MPackageExpDetail> packageExpDetails = query.setOnlyActiveRecords(true)
																 .setOrderBy("Line")
																 .setParameters(new Object[]{p_PackOut_ID})
																 .list();
				for(MPackageExpDetail dtl : packageExpDetails){
					String type = getTypeName(dtl.getType());
					if (log.isLoggable(Level.INFO)) log.info(Integer.toString(dtl.getLine()));
					PackoutItem item = new PackoutItem(type, dtl.getExpRecordId(), getExpProperties(dtl));
					packoutItems.add(item);
				}

				PackOut packOut = new PackOut();
				packOut.setCtx(getCtx());
				Timestamp dateFromValue = packageExp.getDateFrom();
				if (dateFromValue != null) {
					packOut.setFromDate((Timestamp) dateFromValue);
				}
				
				packOut.setExportDictionaryEntity(packageExp.isExportDictionaryEntity());
				packOut.export(packoutDirectory, null, packoutDocument, packoutItems, get_TrxName());
				processedCount = packOut.getExportCount();
				exportFile = packOut.getExportFile();
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE,e.getLocalizedMessage(), e);
			throw e;
		}

		if (processUI != null)
			processUI.download(new File(exportFile));
		
		return "Exported="+processedCount + " File=" + exportFile;
	}	//	doIt

	private String getTypeName(String type) {
		if (X_AD_Package_Exp_Detail.TYPE_ApplicationOrModule.equals(type))
			return I_AD_Menu.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Data.equals(type))
			return IHandlerRegistry.TABLE_GENERIC_HANDLER;
		else if (X_AD_Package_Exp_Detail.TYPE_DataSingle.equals(type))
			return IHandlerRegistry.TABLE_GENERIC_SINGLE_HANDLER;
		else if (X_AD_Package_Exp_Detail.TYPE_DynamicValidationRule.equals(type))
			return I_AD_Val_Rule.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Form.equals(type))
			return I_AD_Form.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ImportFormat.equals(type))
			return I_AD_ImpFormat.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Message.equals(type))
			return I_AD_Message.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_PrintFormat.equals(type))
			return I_AD_PrintFormat.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ProcessReport.equals(type))
			return I_AD_Process.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Reference.equals(type))
			return I_AD_Reference.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ReportView.equals(type))
			return I_AD_ReportView.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Role.equals(type))
			return I_AD_Role.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_SQLStatement.equals(type))
			return "SQLStatement";
		else if (X_AD_Package_Exp_Detail.TYPE_SQLMandatory.equals(type))
			return "SQLMandatory";
		else if (X_AD_Package_Exp_Detail.TYPE_Table.equals(type))
			return I_AD_Table.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Window.equals(type))
			return I_AD_Window.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Workflow.equals(type))
			return I_AD_Workflow.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ModelValidator.equals(type))
			return I_AD_ModelValidator.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_EntityType.equals(type))
			return I_AD_EntityType.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_InfoWindow.equals(type))
			return I_AD_InfoWindow.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ShellScript.equals(type))
			return "ShellScript";
		else if (X_AD_Package_Exp_Detail.TYPE_ScriptJSR223.equals(type))
			return "ScriptJSR223";
		return type;
	}

	private Map<String, Object> getExpProperties(MPackageExpDetail dtl) {
		Map<String, Object> properties = new HashMap<String, Object>();
		String type = dtl.getType();
		if (MPackageExpDetail.TYPE_Data.equals(type) || MPackageExpDetail.TYPE_DataSingle.equals(type)) {
			properties.put(DataElementParameters.AD_TABLE_ID, dtl.getAD_Table_ID());
			properties.put(DataElementParameters.SQL_STATEMENT, dtl.getSQLStatement());
		} else if (MPackageExpDetail.TYPE_SQLStatement.equals(type) || MPackageExpDetail.TYPE_SQLMandatory.equals(type)) {
			properties.put(SQLElementParameters.SQL_STATEMENT, dtl.getSQLStatement());
			properties.put(SQLElementParameters.DB_TYPE, dtl.getDBType());
		} else if (MPackageExpDetail.TYPE_ShellScript.equals(type) || MPackageExpDetail.TYPE_ScriptJSR223.equals(type)) {
			properties.put(MPackageExpDetail.COLUMNNAME_ExecCode, dtl.getExecCode());
		}
		return properties;
	}
}	//	PackOut
