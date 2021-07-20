/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Nicolas Micoud (TGI)                                              *
 **********************************************************************/
package org.idempiere.process;

import static org.compiere.model.SystemIDs.REFERENCE_AD_LANGUAGE;
import static org.compiere.model.SystemIDs.REFERENCE_AD_USER;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_BUTTON;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_DATE;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_LIST;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_NUMBER;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_STRING;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_TABLEDIR;
import static org.compiere.model.SystemIDs.REFERENCE_DOCUMENTACTION;
import static org.compiere.model.SystemIDs.REFERENCE_DOCUMENTSTATUS;

import java.util.logging.Level;

import org.compiere.model.MColumn;
import org.compiere.model.MProcess;
import org.compiere.model.MTable;
import org.compiere.model.M_Element;
import org.compiere.model.X_AD_WF_Node;
import org.compiere.model.X_AD_Workflow;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DisplayType;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;

/**
 *	IDEMPIERE-4858 - CreateTable process
 * 	@author 	Nicolas Micoud - TGI
 */
public class CreateTable extends SvrProcess {

	private String	p_tableName = "";
	private String	p_name = "";
	private String	p_description = "";
	private String	p_accessLevel = "";
	private String	p_entityType = "";
	private boolean p_isCreateKeyColumn = false;
	private boolean p_isCreateWorkflow = false;
	private boolean p_isCreateTranslationTable = false;
	private boolean p_isCreateColValue = false;
	private boolean p_isCreateColName = false;
	
	final private static int LENGTH0 = 0;
	final private static int LENGTH1 = 1;
	final private static int LENGTH2 = 2;
	final private static int LENGTH6 = 6;
	final private static int LENGTH7 = 7;
	final private static int LENGTH20 = 20;
	final private static int LENGTH22 = 22;
	final private static int LENGTH30 = 30;
	final private static int LENGTH36 = 36;
	final private static int LENGTH40 = 40;
	final private static int LENGTH60 = 60;
	final private static int WFTRANSITION10 = 10;
	final private static int WFTRANSITION100 = 100;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "TableName":
				p_tableName = para.getParameterAsString();
				break;
			case "Name":
				p_name = para.getParameterAsString();
				break;
			case "Description":
				p_description = para.getParameterAsString();
				break;
			case "AccessLevel":
				p_accessLevel = para.getParameterAsString();
				break;
			case "EntityType":
				p_entityType = para.getParameterAsString();
				break;
			case "IsCreateTranslationTable":
				p_isCreateTranslationTable = para.getParameterAsBoolean();
				break;
			case "IsCreateColValue":
				p_isCreateColValue = para.getParameterAsBoolean();
				break;
			case "IsCreateColName":
				p_isCreateColName = para.getParameterAsBoolean();
				break;
			case "IsCreateWorkflow":
				p_isCreateWorkflow = para.getParameterAsBoolean();
				break;
			case "IsCreateKeyColumn":
				p_isCreateKeyColumn = para.getParameterAsBoolean();
				break;
			default:
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			}
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() {

		if (!p_isCreateKeyColumn && p_isCreateTranslationTable)
			return ("@Error@ Main table must have a key column if you want to handle translations");

		if (Util.isEmpty(p_name))
			p_name = p_tableName;

		MTable table = createTable(false);

		M_Element elementID = M_Element.get(getCtx(), p_tableName + "_ID");
		if (elementID == null && p_isCreateKeyColumn) { // Create Element <TableName> + _ID
			elementID = new M_Element(getCtx(), p_tableName + "_ID", p_entityType, get_TrxName());
			if (!Util.isEmpty(p_name)) {
				elementID.setName(p_name);
				elementID.setPrintName(p_name);
			}
			if (!Util.isEmpty(p_description))
				elementID.setDescription(p_description);
			elementID.saveEx();
		}

		M_Element elementUU = M_Element.get(getCtx(), p_tableName + "_UU");
		if (elementUU == null) { // Create Element <TableName> + _UU
			elementUU = new M_Element(getCtx(), p_tableName + "_UU", p_entityType, get_TrxName());
			elementUU.saveEx();
		}

		if (p_isCreateColValue)
			createColumn(table, "Value");
		if (p_isCreateColName)
			createColumn(table, "Name");

		if (p_isCreateWorkflow) {
			createColumn(table, "C_Currency_ID"); 
			createColumn(table, "DateAcct");
			createColumn(table, "DocAction"); 
			createColumn(table, "DocStatus"); 
			createColumn(table, "DocumentNo"); 
			createColumn(table, "Processed"); 
			createColumn(table, "ProcessedOn"); 
			createColumn(table, "Processing"); 
		}

		if (p_isCreateKeyColumn)
			createColumn(table, elementID.getColumnName());

		createColumn(table, elementUU.getColumnName());

		log(table);

		if (p_isCreateTranslationTable) {
			MTable tableTrl = createTable(true);
			createColumn(tableTrl, "AD_Language"); 
			createColumn(tableTrl, "IsTranslated"); 

			if (p_isCreateColName)
				createColumn(tableTrl, "Name"); 

			if (p_isCreateKeyColumn) {

				M_Element elementTrlUU = M_Element.get(getCtx(), tableTrl.getTableName() + "_UU");
				if (elementTrlUU == null) {
					elementTrlUU = new M_Element(getCtx(), tableTrl.getTableName() + "_UU", p_entityType, get_TrxName());
					elementTrlUU.saveEx();
				}
				createColumn(tableTrl, elementTrlUU.getColumnName()); // <TableName>_Trl_UU
				createColumn(tableTrl, elementID.getColumnName()); // <TableName>_ID (ID of parent table)
			}
			log(tableTrl);
		}

		return "@ProcessOK@";
	}

	void log(MTable table) {
		addLog(table.getAD_Table_ID(), null, null, table.getTableName(), MTable.Table_ID, table.getAD_Table_ID());
	}

	private MTable createTable(boolean trl) {
		MTable table = new MTable(getCtx(), 0, get_TrxName());
		table.setTableName(p_tableName + (trl ? "_Trl" : ""));
		table.setName(p_name + (trl ? " Trl" : ""));
		if (!Util.isEmpty(p_description))
			table.setDescription(p_description + (trl ? " Trl" : ""));
		table.setEntityType(p_entityType);
		table.setAccessLevel(p_accessLevel);
		table.setIsDeleteable(trl ? false : true);
		table.setIsChangeLog(true);
		table.saveEx();

		// Mandatory columns
		createColumn(table, "AD_Client_ID"); 
		createColumn(table, "AD_Org_ID"); 
		createColumn(table, "Created"); 
		createColumn(table, "CreatedBy"); 
		createColumn(table, "IsActive"); 
		createColumn(table, "Updated"); 
		createColumn(table, "UpdatedBy");

		return table;
	}

	void createColumn(MTable table, String columnName) {
		MColumn column = new MColumn(table);

		M_Element element = M_Element.get(getCtx(), columnName, get_TrxName());

		column.setColumnName(element.getColumnName());
		column.setName(element.getName());
		column.setDescription(element.getDescription());
		column.setHelp(element.getHelp());
		column.setAD_Element_ID(element.getAD_Element_ID());

		if (columnName.equals("AD_Client_ID")) {
			column.setAD_Reference_ID(DisplayType.Search);
			column.setDefaultValue("@#AD_Client_ID@");
			column.setIsMandatory(true);
			column.setIsUpdateable(false);
			column.setReadOnlyLogic("1=1");
		}
		else if (columnName.equals("AD_Org_ID")) {
			column.setAD_Reference_ID(DisplayType.TableDir);
			column.setDefaultValue("@AD_Org_ID@");
			column.setIsMandatory(true);
			column.setIsUpdateable(false);
		}
		else if (columnName.equals("Created") || columnName.equals("Updated")) {
			column.setAD_Reference_ID(DisplayType.DateTime);
			column.setIsMandatory(true);
			column.setIsUpdateable(false);
		}
		else if (columnName.equals("CreatedBy") || columnName.equals("UpdatedBy")) {
			column.setAD_Reference_ID(DisplayType.Search);
			column.setAD_Reference_Value_ID(REFERENCE_AD_USER);
			column.setIsMandatory(true);
			column.setIsUpdateable(false);
		}
		else if (columnName.equals("IsActive") || columnName.equals("IsTranslated") || columnName.equals("Processed") || columnName.equals("Processing")) {
			column.setAD_Reference_ID(DisplayType.YesNo);
			column.setIsMandatory(true);
			column.setIsUpdateable(true);
			column.setFieldLength(LENGTH1);
			column.setDefaultValue("N");
			if (columnName.equals("IsActive"))
				column.setDefaultValue("Y");
		}
		else if (columnName.equals("AD_Language")) { 
			column.setAD_Reference_ID(DisplayType.Table);
			column.setAD_Reference_Value_ID(REFERENCE_AD_LANGUAGE);
			column.setIsMandatory(true);
			column.setIsUpdateable(false);
			column.setFieldLength(LENGTH6);
			column.setIsParent(true);
		}
		else if (columnName.equals("Value") || columnName.equals("Name") || columnName.equals("DocumentNo")) {
			column.setAD_Reference_ID(REFERENCE_DATATYPE_STRING);
			column.setIsMandatory(true);
			column.setIsUpdateable(true);
			column.setIsSelectionColumn(true);

			int length = LENGTH0;
			if (columnName.equals("Value"))
				length = LENGTH40;
			else if (columnName.equals("Name")) {
				length = LENGTH60;
				column.setIsIdentifier(true);
				if (p_isCreateTranslationTable && !table.getTableName().toUpperCase().endsWith("_TRL"))
					column.setIsTranslated(true);
			}
			else if (columnName.equals("DocumentNo"))
				length = LENGTH30;
			column.setFieldLength(length);
		}
		else if (columnName.equals("C_Currency_ID")) {
			column.setAD_Reference_ID(REFERENCE_DATATYPE_TABLEDIR);
			column.setIsMandatory(true);
			column.setIsUpdateable(true);
			column.setFieldLength(LENGTH22);
			column.setDefaultValue("@C_Currency_ID@");
		}
		else if (columnName.equals("DateAcct")) { 
			column.setAD_Reference_ID(REFERENCE_DATATYPE_DATE);
			column.setIsMandatory(true);
			column.setIsUpdateable(true);
			column.setFieldLength(LENGTH7);
			column.setDefaultValue("@#Date@");
		}
		else if (columnName.equals("DocAction")) { 

			MWorkflow wf = createWorkflow(table);

			MProcess process = new MProcess(getCtx(), 0, get_TrxName());
			process.setValue(p_tableName + " Process");
			process.setName("Process " + p_name);
			process.setEntityType(p_entityType);
			process.setAccessLevel(p_accessLevel);
			process.setAD_Workflow_ID(wf.getAD_Workflow_ID());
			process.saveEx();

			column.setAD_Reference_ID(REFERENCE_DATATYPE_BUTTON); 
			column.setAD_Reference_Value_ID(REFERENCE_DOCUMENTACTION);
			column.setIsMandatory(true);
			column.setIsUpdateable(true);
			column.setFieldLength(LENGTH2);
			column.setDefaultValue(DocAction.ACTION_Complete);
			column.setAD_Process_ID(process.getAD_Process_ID());
			column.setIsToolbarButton(MColumn.ISTOOLBARBUTTON_Window);
		}
		else if (columnName.equals("DocStatus")) {
			column.setAD_Reference_ID(REFERENCE_DATATYPE_LIST);
			column.setIsMandatory(true);
			column.setIsUpdateable(true);
			column.setFieldLength(LENGTH2);
			column.setAD_Reference_Value_ID(REFERENCE_DOCUMENTSTATUS);
			column.setDefaultValue(DocAction.STATUS_Drafted);
		}
		else if (columnName.equals("ProcessedOn")) { 
			column.setAD_Reference_ID(REFERENCE_DATATYPE_NUMBER);
			column.setFieldLength(LENGTH20);
		}
		else if (element.getColumnName().equalsIgnoreCase(table.getTableName() + "_ID")) { // key column
			column.setIsKey(true);
			column.setAD_Reference_ID(DisplayType.ID);	// ID
			column.setIsMandatory(true);
			column.setFieldLength(LENGTH22);
		}
		else if (element.getColumnName().equalsIgnoreCase(table.getTableName() + "_UU")) { // UUID column
			column.setAD_Reference_ID(REFERENCE_DATATYPE_STRING);
			column.setFieldLength(LENGTH36);
		}
		else if (element.getColumnName().equalsIgnoreCase((table.getTableName().substring(0, table.getTableName().length()-4)) + "_ID")) { // ID of parent table (for translation tables)
			column.setAD_Reference_ID(DisplayType.Search);
			column.setIsParent(true);
			column.setIsMandatory(true);
		}

		column.saveEx();
	}

	MWorkflow createWorkflow(MTable table) {
		MWorkflow wf = new MWorkflow(getCtx(), 0, get_TrxName());
		wf.setValue("Process_" + p_tableName);
		wf.setName("Process_" + p_tableName);
		wf.setWorkflowType(X_AD_Workflow.WORKFLOWTYPE_DocumentProcess);
		wf.setAD_Table_ID(table.getAD_Table_ID());
		wf.setEntityType(p_entityType);
		wf.setAuthor("iDempiere");
		wf.saveEx();

		// Nodes
		MWFNode docAuto = createWorkflowNode(wf, "DocAuto", X_AD_WF_Node.ACTION_DocumentAction, X_AD_WF_Node.DOCACTION_None);
		MWFNode docComplete = createWorkflowNode(wf, "DocComplete", X_AD_WF_Node.ACTION_DocumentAction, X_AD_WF_Node.DOCACTION_Complete);
		MWFNode docPrepare = createWorkflowNode(wf, "DocPrepare", X_AD_WF_Node.ACTION_DocumentAction, X_AD_WF_Node.DOCACTION_Prepare);
		MWFNode start = createWorkflowNode(wf, "Start", X_AD_WF_Node.ACTION_WaitSleep, null);

		// Transitions
		createWorkflowNodeNext(start, docPrepare.getAD_WF_Node_ID(), WFTRANSITION10, "(Standard Approval)", true);
		createWorkflowNodeNext(start, docAuto.getAD_WF_Node_ID(), WFTRANSITION100, "(Standard Transition)", false);
		createWorkflowNodeNext(docPrepare, docComplete.getAD_WF_Node_ID(), WFTRANSITION100, "(Standard Transition)", false);

		wf.setAD_WF_Node_ID(start.getAD_WF_Node_ID());
		wf.saveEx();
		return wf;
	}

	MWFNode createWorkflowNode(MWorkflow wf, String name, String action, String docAction) {
		MWFNode wfn = new MWFNode(wf, "(" + name + ")", "(" + name + ")");
		wfn.setDescription("(Standard Node)");
		wfn.setEntityType(p_entityType);
		wfn.setAction(action);
		wfn.setDocAction(docAction);
		wfn.saveEx();
		return wfn;
	}

	void createWorkflowNodeNext(MWFNode wfn, int nodeNextID, int seq, String description, boolean isStdUserWF) {
		MWFNodeNext wfnn = new MWFNodeNext(wfn, nodeNextID);
		wfnn.setSeqNo(seq);
		wfnn.setDescription(description);
		wfnn.setIsStdUserWorkflow(isStdUserWF);
		wfnn.setEntityType(p_entityType);
		wfnn.saveEx();
	}

}	//	CreateTable
