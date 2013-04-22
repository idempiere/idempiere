/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) Trek Global All Rights Reserved.                             *
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
 * @author Juliana Corredor, jcorredor@trekglobal.com                        *
 * @author Carlos Ruiz                                                       *
 *****************************************************************************/
package org.idempiere.fitrecorder;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.logging.Level;

import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.MWarehouse;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;

public class FitRecorder implements ModelValidator {

	private HashMap<Integer, Writer> writersPerSession;

	/** Logger */
	private static CLogger log = CLogger.getCLogger(FitRecorder.class);

	private static ArrayList<String> dontLogTables = new ArrayList<String>(Arrays.asList(
			"AD_ACCESSLOG",
			"AD_SESSION",
			"AD_ALERTPROCESSORLOG",
			"AD_CHANGELOG",
			"AD_DOCUMENT_ACTION_ACCESS",
			"AD_FORM_ACCESS",
			"AD_ISSUE",
			"AD_LDAPPROCESSORLOG",
			"AD_PACKAGE_IMP",
			"AD_PACKAGE_IMP_BACKUP",
			"AD_PACKAGE_IMP_DETAIL",
			"AD_PACKAGE_IMP_INST",
			"AD_PACKAGE_IMP_PROC",
			"AD_PINSTANCE",
			"AD_PINSTANCE_LOG",
			"AD_PINSTANCE_PARA",
			"AD_PROCESS_ACCESS",
			"AD_RECENTITEM",
			"AD_REPLICATION_LOG",
			"AD_SCHEDULERLOG",
			"AD_SESSION",
			"AD_WINDOW_ACCESS",
			"AD_WORKFLOW_ACCESS",
			"AD_WORKFLOWPROCESSORLOG",
			"CM_WEBACCESSLOG",
			"C_ACCTPROCESSORLOG",
			"K_INDEXLOG",
			"R_REQUESTPROCESSORLOG",
			"T_AGING",
			"T_ALTER_COLUMN",
			"T_DISTRIBUTIONRUNDETAIL",
			"T_INVENTORYVALUE",
			"T_INVOICEGL",
			"T_REPLENISH",
			"T_REPORT",
			"T_REPORTSTATEMENT",
			"T_SELECTION",
			"T_SELECTION2",
			"T_SPOOL",
			"T_TRANSACTION",
			"T_TRIALBALANCE"));

	private String ignoreTrx = null;
	
	@Override
	public void initialize(ModelValidationEngine engine, MClient client) {
		writersPerSession=new HashMap<Integer, Writer>();

		try {
			
			String sql = "SELECT ta.TableName"
					+" FROM AD_Table ta"
					+" WHERE ta.IsActive='Y'"
					+" AND ta.IsView='N'"
					+" ORDER BY ta.TableName";

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = DB.prepareStatement(sql, null);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					engine.addModelChange(rs.getString(1), this);
				}
			} catch(Exception e) {
				if (log.isLoggable(Level.INFO)) log.info(e.getLocalizedMessage());
			} finally {
				DB.close(rs, pstmt);
				pstmt = null; rs = null;
			}

			sql = "SELECT ta.TableName"
					+" FROM AD_Table ta"
					+" INNER JOIN AD_Column cl ON (ta.AD_Table_ID = cl.AD_Table_ID)"
					+" WHERE ta.IsActive='Y'"
					+" AND ta.IsView='N'"
					+" AND cl.AD_Element_ID=287"
					+" ORDER BY ta.TableName";

			try {
				pstmt = DB.prepareStatement(sql, null);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					engine.addDocValidate(rs.getString(1), this);
				}
			} catch (Exception e) {
				if (log.isLoggable(Level.INFO)) log.info(e.getLocalizedMessage());
			} finally {
				DB.close(rs, pstmt);
				pstmt = null; rs = null;
			}
		} catch (Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.getLocalizedMessage());
		}
	}

	public int getAD_Client_ID() {
		return 0;
	}

	@Override
	public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {

		return null;
	}

	@Override
	public String modelChange(PO po, int type) throws Exception {

		try {
			if (type == TYPE_AFTER_NEW ) {
				
				if (po instanceof MSession) {
					loginFixture(po);
				}
				if (dontLogTables.contains(po.get_TableName().toUpperCase()))
					return null;

				// Ignore records created within a process
				if (po.get_TrxName().startsWith("SvrProcess_"))
					return null;

				// Ignore records created within a workflow process
				if (po.get_TrxName().startsWith("WFP_"))
					return null;

				writeFile("\n");
				writeFile("\n");
				writeFile("CREATE RECORD");
				writeFile("\n");
				writeFile("!");
				writeFile("|Create Record||");
				writeFile("\n");
				writeFile("|*Table*|");
				writeFile(po.get_TableName() + "|");

				MTable table = MTable.get(Env.getCtx(),po.get_Table_ID());
				for(MColumn column : table.getColumns(false)) {
					String colName = column.getColumnName();
					// exclude some columns
					if (   colName.equals("Created")
						|| colName.equals("CreatedBy")
						|| colName.equals("Updated")
						|| colName.equals("UpdatedBy")
						|| colName.equals("AD_Client_ID")
						|| colName.equals(table.getTableName() + "_ID")
						|| colName.equals(PO.getUUIDColumnName(table.getTableName()))
						|| column.getAD_Reference_ID() == DisplayType.Button)
						continue;
					if (po.isActive() && colName.equals("IsActive"))
						continue;
					// TODO: Exclude read-only fields (read-only is marked on window which is not available here)

					String value = po.get_ValueAsString(colName);
					if (value != null && value.length() > 0) {
						writeFile("\n");
						writeFile("|" + colName + "|");
						if (DisplayType.isLookup(column.getAD_Reference_ID()) && DisplayType.List != column.getAD_Reference_ID()) {
							writeFile(resolveValue(po, table, column) + "|");
						} else {
							writeFile(value +"|");
						}
					}
				}
				writeFile("\n");
				writeFile("|*Save*|");
				writeFile("\n");

			}

			if(type == TYPE_AFTER_CHANGE)
			{
				if (po instanceof MPInstance)
				{
					MProcess pro = MProcess.get(Env.getCtx(), po.get_ValueAsInt("AD_Process_ID"));
					MPInstance pint = (MPInstance)po;
					writeFile("\n");
					writeFile("\n");
					writeFile("RUN PROCESS");
					writeFile("\n");
					writeFile("!");
					writeFile("|Run Process|");
					writeFile("\n");
					writeFile("|*ProcessValue*|");
					writeFile(pro.getValue() + "|");
					MPInstancePara[] iparas = pint.getParameters();
					for (MProcessPara para : pro.getParameters()) {
						MPInstancePara ipara = null;
						for (MPInstancePara iparat : iparas) {
							if (iparat.getParameterName().equals(para.getColumnName())) {
								ipara = iparat;
								break;
							}
						}
						if (ipara == null) {
							continue;
						}
						String value = null;
						String valueTo = null;
						if (DisplayType.isDate(para.getAD_Reference_ID())) {
							if (ipara.getP_Date() != null)
								value = ipara.getP_Date().toString();
							if (para.isRange() && ipara.getP_Date_To() != null)
								valueTo = ipara.getP_Date_To().toString();
						} else if (DisplayType.isNumeric(para.getAD_Reference_ID())) {
							if (ipara.getP_Number() != null)
								value = ipara.getP_Number().toString();
							if (para.isRange() && ipara.getP_Number_To() != null)
								valueTo = ipara.getP_Number_To().toString();
						} else if (DisplayType.isLookup(para.getAD_Reference_ID()) && DisplayType.List != para.getAD_Reference_ID()) {
							// TODO: resolve Ref
							if (ipara.get_Value("P_Number") != null)
								value = resolveValuePara(ipara.getP_Number(), para);
							if (para.isRange() && ipara.get_Value("P_Number_To") != null)
								valueTo = resolveValuePara(ipara.getP_Number_To(), para);
						} else {
							if (ipara.getP_String() != null)
								value = ipara.getP_String();
							if (para.isRange() && ipara.getP_String_To() != null)
								valueTo = ipara.getP_String_To();
						}
						if (value != null) {
							writeFile("\n");
							writeFile("|" + para.getColumnName() + "|");
							writeFile(value + "|");
						}
						if (para.isRange() && valueTo != null) {
							writeFile("\n");
							writeFile("|" + para.getColumnName() + "_2|");
							writeFile(valueTo + "|");
						}
					}
					writeFile("\n");
					writeFile("|*Run*|");
					writeFile("\n");					

				} else if (po instanceof MSession) {
					MSession session = (MSession) po;
					if (session.isProcessed()) {
						closefile();
					}
				} else {

					if (dontLogTables.contains(po.get_TableName().toUpperCase()))
						return null;

					// Ignore records created within a process
					if (po.get_TrxName().startsWith("SvrProcess_"))
						return null;

					// Ignore records created within a workflow process
					if (po.get_TrxName().startsWith("WFP_"))
						return null;
					
					MTable table = MTable.get(Env.getCtx(), po.get_Table_ID());

					MColumn[] columns = table.getColumns(true);
					StringBuilder where = new StringBuilder();
					StringBuilder set = new StringBuilder();
					boolean key=false;
					for (int i = 0; i < columns.length; i++) 
					{
						MColumn column = columns[i];
						String colName = column.getColumnName();
						String value=null;
						if (DisplayType.isLookup(column.getAD_Reference_ID()) && DisplayType.List != column.getAD_Reference_ID()) {
						     value = resolveValue(po, table, column);
						}else{
							value=po.get_ValueAsString(colName);
						}
						if (column.isAllowLogging()) 
						{
							if (column.isKey()) 
							{
								if (!key) {
									where.append("| *Where* | ");
									where.append(colName + " = " + value+ " | ");
									key=true;
								} else {
									where.append(" | " + colName + " | ");
									where.append(value + " | ");
								}
							}
							if (po.is_ValueChanged(colName)) {
								if (colName.equals("Created")
										|| colName.equals("CreatedBy")
										|| colName.equals("Updated")
										|| colName.equals("UpdatedBy")
										|| colName.equals("AD_Client_ID")
										|| colName.equals(table.getTableName()+ "_ID")
										|| colName.equals(PO.getUUIDColumnName(table.getTableName()))
										|| column.getAD_Reference_ID() == DisplayType.Button)
									      continue;
								
								if (po.isActive() && colName.equals("IsActive"))
									continue;

								if (value != null && value.length() > 0) {
									set.append("\n");
									set.append("| " + colName + " | ");
								    set.append(value + "|");									
								}

							}
						}

					}// end while columns

					if (where.length() > 0 && set.length() > 0) {
						writeFile("\n");
						writeFile("\n");
						writeFile("UPDATE RECORD");
						writeFile("\n");
						writeFile("!");
						writeFile("| Update Record |");
						writeFile("\n");
						writeFile("| *Table* |  ");
						writeFile(po.get_TableName() + "  |");
						writeFile("\n");
						writeFile(where.toString());
						writeFile("\n");
						writeFile("| *Update*  |");
						writeFile(set.toString());
					}
				}

			}
			
			if (type == TYPE_AFTER_DELETE)
			{
				if (dontLogTables.contains(po.get_TableName().toUpperCase()))
					return null;

				// Ignore records created within a process
				if (po.get_TrxName().startsWith("SvrProcess_"))
					return null;

				// Ignore records created within a workflow process
				if (po.get_TrxName().startsWith("WFP_"))
					return null;

				writeFile("\n");
				writeFile("\n");
				writeFile("DELETE RECORD");
				writeFile("\n");
				writeFile("!");
				writeFile("| Delete Record |");
				writeFile("\n");
				writeFile("| *Table* |  ");
				writeFile(po.get_TableName() + "  |");
				writeFile("\n");
				
				MTable table = MTable.get(Env.getCtx(), po.get_Table_ID());
				MColumn[] columns = table.getColumns(true);
				boolean key=false;
				
				for (int i = 0; i < columns.length; i++) 
				{
					MColumn column = columns[i];
					String colName = column.getColumnName();
					String value=null;
					if (DisplayType.isLookup(column.getAD_Reference_ID()) && DisplayType.List != column.getAD_Reference_ID()) {
					     value = resolveValue(po, table, column);
					} else {
						value=po.get_ValueAsString(colName);
					}
					
					if (column.isAllowLogging()) {
						if (column.isKey()) {
							if (!key) {
								writeFile("| *Where* | ");
								writeFile(colName + " = " + value+ " | ");
								key=true;
							} else {
								writeFile(" | " + colName + " | ");
								writeFile(value + " | ");
							}
						}
					}	
				}//while columns
				
				writeFile("\n");
				writeFile("| *Delete*  |");				
			}

		} catch (Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.getLocalizedMessage());
			return e.getLocalizedMessage();
		}
		return null;
	}

	private String resolveValuePara(BigDecimal p_Number, MProcessPara para) {
		String value = null;
		// resolve to identifier - search for value first, if not search for name - if not use the ID
		String foreignTable = para.getReferenceTableName();
		String foreignColName = null;
		if ( ! ("AD_Language".equals(foreignTable) || "AD_EntityType".equals(foreignTable))) {
			MTable fTable = MTable.get(Env.getCtx(), foreignTable);
			// Hardcoded / do not check for Value on AD_Org, AD_User and AD_Ref_List, must use name for these two tables
			if (! ("AD_Org".equals(foreignTable) || "AD_User".equals(foreignTable) || "AD_Ref_List".equals(foreignTable))
					&& fTable.getColumn("Value") != null) {
				foreignColName = "Value";
			} else if (fTable.getColumn("Name") != null) {
				foreignColName = "Name";
			} else if (fTable.getColumn("DocumentNo") != null) {
				foreignColName = "DocumentNo";
			}
		}

		Object idO = p_Number.intValue();
		if (idO != null && foreignColName != null) {
			int id = (Integer) idO;
			StringBuilder select = new StringBuilder("SELECT ")
			.append(foreignColName).append(" FROM ")
			.append(foreignTable).append(" WHERE ")
			.append(foreignTable).append("_ID=?");
			String foreignValue = DB.getSQLValueStringEx(null, select.toString(), id);
			value = "@Ref=" + foreignTable + "[" + foreignColName + "='" + foreignValue + "']." + foreignTable + "_ID";
		} else {
			value = p_Number.toString();
		}

		return value;
	}

	private String resolveValue(PO po, MTable table, MColumn column) {
		String value = null;
		// resolve to identifier - search for value first, if not search for name - if not use the ID
		String foreignTable = column.getReferenceTableName();
		String foreignColName = null;
		if ( ! ("AD_Language".equals(foreignTable) || "AD_EntityType".equals(foreignTable))) {
			MTable fTable = MTable.get(Env.getCtx(), foreignTable);
			// Hardcoded / do not check for Value on AD_Org, AD_User and AD_Ref_List, must use name for these two tables
			if (! ("AD_Org".equals(foreignTable) || "AD_User".equals(foreignTable) || "AD_Ref_List".equals(foreignTable))
					&& fTable.getColumn("Value") != null) {
				foreignColName = "Value";
			} else if (fTable.getColumn("Name") != null) {
				foreignColName = "Name";
			} else if (fTable.getColumn("DocumentNo") != null) {
				foreignColName = "DocumentNo";
			}
		}

		Object idO = po.get_Value(column.getColumnName());
		if (idO != null && foreignColName != null) {
			int id = (Integer) idO;
			StringBuilder select = new StringBuilder("SELECT ")
			.append(foreignColName).append(" FROM ")
			.append(foreignTable).append(" WHERE ")
			.append(foreignTable).append("_ID=?");
			String foreignValue = DB.getSQLValueStringEx(null, select.toString(), id);
			value = "@Ref=" + foreignTable + "[" + foreignColName + "='" + foreignValue + "']." + foreignTable + "_ID";
		} else {
			value = po.get_ValueAsString(column.getColumnName());
		}

		return value;
	}

	@Override
	public String docValidate(PO po, int timing) {

		try {
			if (   timing == TIMING_BEFORE_PREPARE  || timing == TIMING_BEFORE_VOID
				|| timing == TIMING_BEFORE_CLOSE || timing == TIMING_BEFORE_REACTIVATE || timing == TIMING_BEFORE_REVERSECORRECT
				|| timing == TIMING_BEFORE_REVERSEACCRUAL || timing == TIMING_BEFORE_COMPLETE || timing == TIMING_BEFORE_POST ) {
				
				if (po.get_TrxName().equals(ignoreTrx))
					return null;

				ignoreTrx  = po.get_TrxName();

				String action = po.get_ValueAsString("DocAction");
				if (timing == TIMING_BEFORE_POST)
					action = "PO";
				
				writeFile("\n");
				writeFile("\n");
				if (action.equals("CO")) {
					// run process
					String processValue = DB.getSQLValueString(po.get_TrxName(),
				   "SELECT p.Value FROM AD_Process p JOIN AD_Workflow w ON (p.AD_Workflow_ID=w.AD_Workflow_ID) WHERE w.AD_Table_ID=?", po.get_Table_ID());
					writeFile("RUN PROCESS");
					writeFile("\n");
					writeFile("!");
					writeFile("|Run Process|");
					writeFile("\n");
					writeFile("|*ProcessValue*|");
					writeFile(processValue + "|");
					writeFile("\n");
					writeFile("|*RecordID*|");
					writeFile(resolveValueDoc(po.get_ID(), po.get_TableName()) + "|");
					writeFile("\n");
					writeFile("|*DocAction*|");
					writeFile(action + "|");
					writeFile("\n");
					writeFile("|*Run*|");
				} else {
					// set doc action
					writeFile("SET DOC ACTION");
					writeFile("\n");
					writeFile("!");
					writeFile("|Set DocAction|");
					writeFile("\n");
					writeFile("|*Table*|");
					writeFile(po.get_TableName() + "|");
					writeFile("\n");
					writeFile("|" + po.get_TableName() + "_ID|");
					writeFile(resolveValueDoc(po.get_ID(), po.get_TableName()) + "|");
					writeFile("\n");
					writeFile("|DocAction|");
					writeFile(action + "|");
					writeFile("\n");
					writeFile("|*Save*|");
				}
				writeFile("\n");
			}
		} catch (Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.getLocalizedMessage());
		}
		return null;
	}

	private String resolveValueDoc(int id, String tableName) {
		String value = null;
		// resolve to identifier - search for value first, if not search for name - if not use the ID
		String foreignTable = tableName;
		String foreignColName = null;
		if ( ! ("AD_Language".equals(foreignTable) || "AD_EntityType".equals(foreignTable))) {
			MTable fTable = MTable.get(Env.getCtx(), foreignTable);
			// Hardcoded / do not check for Value on AD_Org, AD_User and AD_Ref_List, must use name for these two tables
			if (! ("AD_Org".equals(foreignTable) || "AD_User".equals(foreignTable) || "AD_Ref_List".equals(foreignTable))
					&& fTable.getColumn("Value") != null) {
				foreignColName = "Value";
			} else if (fTable.getColumn("Name") != null) {
				foreignColName = "Name";
			} else if (fTable.getColumn("DocumentNo") != null) {
				foreignColName = "DocumentNo";
			}
		}

		if (id > 0 && foreignColName != null) {
			StringBuilder select = new StringBuilder("SELECT ")
			.append(foreignColName).append(" FROM ")
			.append(foreignTable).append(" WHERE ")
			.append(foreignTable).append("_ID=?");
			String foreignValue = DB.getSQLValueStringEx(null, select.toString(), id);
			value = "@Ref=" + foreignTable + "[" + foreignColName + "='" + foreignValue + "']." + foreignTable + "_ID";
		} else {
			value = String.valueOf(id);
		}

		return value;
	}
	
	public String loginFixture(PO po){
		String msg=null;
		String preference = Env.getPreference(Env.getCtx(), 0, "FitRecorder", false);
		if (preference.equals("Y")) {			
			int session_ID = po.get_ID();
			int user_ID = Env.getContextAsInt(Env.getCtx(), "#AD_User_ID");
			int org_ID = Env.getContextAsInt(Env.getCtx(), "#AD_Org_ID");
			MUser user = new MUser(Env.getCtx(), user_ID, null);
			String name = Ini.getAdempiereHome() + "/log/fit_test_" + session_ID+ user.getName() + ".txt";
			try {
				File file = new File(name);
				FileOutputStream fos = new FileOutputStream(file, true);
				Writer writer = new BufferedWriter(new OutputStreamWriter(fos, "UTF8"));
				Env.setContext(Env.getCtx(), "#AD_Session_ID", session_ID);
				writersPerSession.put(session_ID, writer);
				writeFile("\n");
				writeFile("\n");
				writeFile("LOGIN");
				writeFile("\n");
				writeFile("!");
				writeFile("|Login|");
				writeFile("\n");
				writeFile("|User|");
				if (MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN,false))
					writeFile(user.getEMail() + "|");
				else if (user.getLDAPUser() != null)
					writeFile(user.getLDAPUser() + "|");
				else
					writeFile(user.getName() + "|");
				writeFile("\n");
				writeFile("|Password|");
				writeFile("                                |");
				writeFile("\n");
				writeFile("|AD_Client_ID|");
				MClient client = MClient.get(Env.getCtx(),Env.getContextAsInt(Env.getCtx(), "#AD_Client_ID"));
				writeFile("@Ref=AD_Client[Name='" + client.getName()	+ "'].AD_Client_ID|");
				writeFile("\n");
				writeFile("|AD_Org_ID|");
				String orgName = DB.getSQLValueString(null,"SELECT Name FROM AD_Org WHERE AD_Org_ID=?", org_ID);
				writeFile("@Ref=AD_Org[Name='" + orgName + "'].AD_Org_ID|");
				writeFile("\n");
				writeFile("|AD_Role_ID|");
				writeFile("@Ref=AD_Role[Name='"+ Env.getContext(Env.getCtx(), "#AD_Role_Name")+ "'].AD_Role_ID|");
				writeFile("\n");
				int warehouseid = Env.getContextAsInt(Env.getCtx(),Env.M_WAREHOUSE_ID);
				if (warehouseid > 0) {
					MWarehouse warehouse = MWarehouse.get(Env.getCtx(),warehouseid);
					writeFile("|M_Warehouse_ID|");
					writeFile("@Ref=M_Warehouse[Name='" + warehouse.getName()+ "'].M_Warehouse_ID|");
					writeFile("\n");
				}
				writeFile("|*Login*|");
				writeFile("\n");
			} catch (Exception e) {
				return e.getLocalizedMessage();
			}
		}
		return msg;
	}
	
	public void writeFile(String msg){
		int session_ID=Env.getContextAsInt(Env.getCtx(), "#AD_Session_ID");
		Writer writer = (Writer) writersPerSession.get(session_ID);
		if (writer != null) {
			try{
				writer.append(msg);
				writer.flush();
			} catch (Exception e) {}				
		}
	}
	
	public void closefile(){
		int Session_ID=Env.getContextAsInt(Env.getCtx(), "#AD_Session_ID");
		Writer writer = (Writer) writersPerSession.get(Session_ID);
		if (writer != null) {
			try {
				writer.close();
				writersPerSession.remove(Session_ID);
			} catch (IOException e) {}		
		}
	}
}
