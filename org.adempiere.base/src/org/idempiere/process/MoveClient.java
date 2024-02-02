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
 * - Carlos Ruiz - globalqss                                           *
 * Sponsored by FH                                                     *
 **********************************************************************/

package org.idempiere.process;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.db.CConnection;
import org.compiere.model.MColumn;
import org.compiere.model.MProcessPara;
import org.compiere.model.MSequence;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_UUID_Map;
import org.compiere.model.X_A_Asset_Addition;
import org.compiere.model.X_A_Asset_Disposed;
import org.compiere.model.X_A_Asset_Reval;
import org.compiere.model.X_A_Asset_Transfer;
import org.compiere.model.X_A_Depreciation_Entry;
import org.compiere.model.X_A_Depreciation_Exp;
import org.compiere.model.X_C_AllocationHdr;
import org.compiere.model.X_C_AllocationLine;
import org.compiere.model.X_C_BankStatement;
import org.compiere.model.X_C_BankStatementLine;
import org.compiere.model.X_C_Cash;
import org.compiere.model.X_C_CashLine;
import org.compiere.model.X_C_Invoice;
import org.compiere.model.X_C_InvoiceLine;
import org.compiere.model.X_C_Order;
import org.compiere.model.X_C_OrderLine;
import org.compiere.model.X_C_Payment;
import org.compiere.model.X_C_ProjectIssue;
import org.compiere.model.X_GL_Journal;
import org.compiere.model.X_GL_JournalLine;
import org.compiere.model.X_M_InOut;
import org.compiere.model.X_M_InOutLine;
import org.compiere.model.X_M_Inventory;
import org.compiere.model.X_M_InventoryLine;
import org.compiere.model.X_M_MatchInv;
import org.compiere.model.X_M_MatchPO;
import org.compiere.model.X_M_Movement;
import org.compiere.model.X_M_MovementLine;
import org.compiere.model.X_M_Production;
import org.compiere.model.X_M_ProductionLine;
import org.compiere.model.X_M_Requisition;
import org.compiere.model.X_M_RequisitionLine;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Util;

/**
 * Process to move a client from a external database to current, or copy a template in current database
 */
@org.adempiere.base.annotation.Process
public class MoveClient extends SvrProcess {

	/** Define if the process is to copy a template client, or bring from external database */
	private boolean p_IsCopyClient;
	/** JDBC URL of the external database */
	private String p_JDBC_URL;
	/** optional to connect to the JDBC URL, if empty use the same as target */
	private String p_UserName;
	/** optional to connect to the JDBC URL, if empty use the same as target */
	private String p_Password;
	/** optional, comma separated list of tables to exclude */
	private String p_TablesToExclude;
	/** optional, comma separated list, if empty then all clients >= 1000000 will be moved */
	private String p_ClientsToInclude;
	/** optional, comma separated list of clients to exclude */
	private String p_ClientsToExclude;
	/** to do just validation and not execute the process */
	private boolean p_IsValidateOnly;
	/** optional, comma separated list of tables that require to preserve IDs, * for all */
	private String p_TablesToPreserveIDs;
	/** New client name when copying from template */
	private String p_ClientName;
	/** New client value when copying from template */
	private String p_ClientValue;
	/** skip some validations to make the process faster */
	private boolean p_IsSkipSomeValidations;

	final private static String insertConversionId = "INSERT INTO T_MoveClient (AD_PInstance_ID, TableName, Source_Key, Target_Key) VALUES (?, ?, ?, ?)";
	final private static String queryT_MoveClient = "SELECT Target_Key FROM T_MoveClient WHERE AD_PInstance_ID=? AND TableName=? AND Source_Key=?";

	private Connection externalConn;
	private StringBuffer p_excludeTablesWhere = new StringBuffer();
	private StringBuffer p_whereClient = new StringBuffer();
	private List<String> p_errorList = new ArrayList<String>();
	private List<String> p_tablesVerifiedList = new ArrayList<String>();
	private List<String> p_tablesToPreserveIDsList = new ArrayList<String>();
	private List<String> p_tablesToExcludeList = new ArrayList<String>();
	private List<String> p_columnsVerifiedList = new ArrayList<String>();
	private List<String> p_idSystemConversionList = new ArrayList<String>(); // can consume lot of memory but it helps for performance
	private boolean p_isPreserveAll = false;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	@Override
	protected void prepare() {
		// defaults
		p_IsValidateOnly = true;
		//
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("IsCopyClient".equals(name)) {
				p_IsCopyClient  = para.getParameterAsBoolean();
			} else if ("JDBC_URL".equals(name)) {
				p_JDBC_URL  = para.getParameterAsString();
			} else if ("UserName".equals(name)) {
				p_UserName = para.getParameterAsString();
			} else if ("Password".equals(name)) {
				p_Password = para.getParameterAsString();
			} else if ("ClientName".equals(name)) {
				p_ClientName = para.getParameterAsString();
			} else if ("ClientValue".equals(name)) {
				p_ClientValue = para.getParameterAsString();
			} else if ("TablesToExclude".equals(name)) {
				p_TablesToExclude = para.getParameterAsString();
			} else if ("ClientsToInclude".equals(name)) {
				p_ClientsToInclude = para.getParameterAsString();
			} else if ("ClientsToExclude".equals(name)) {
				p_ClientsToExclude = para.getParameterAsString();
			} else if ("IsValidateOnly".equals(name)) {
				p_IsValidateOnly = para.getParameterAsBoolean();
			} else if ("IsPreserveIDs".equals(name)) {
				p_TablesToPreserveIDs = para.getParameterAsString();
			} else if ("IsSkipSomeValidations".equals(name)) {
				p_IsSkipSomeValidations = para.getParameterAsBoolean();
			} else {
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
			}
		}
	}

	/**
	 *  Perform process.
	 *  @return Message (variables are parsed)
	 *  @throws Exception if not successful
	 */
	@Override
	protected String doIt() throws Exception {
		// validate parameters
		if (p_IsCopyClient) {
			if (! Util.isEmpty(p_ClientsToExclude, true))
				throw new AdempiereException("Tenants to exclude must be empty when copying from template");
			if (! Util.isEmpty(p_TablesToPreserveIDs, true))
				throw new AdempiereException("Preserve IDs must be empty when copying from template");
			try {
				Integer.parseInt(p_ClientsToInclude);
			} catch (NumberFormatException e) {
				throw new AdempiereException("Error in parameter Tenants to Include, must be just one integer");
			}
		} else {
			if (Util.isEmpty(p_JDBC_URL, true))
				throw new AdempiereException("Fill mandatory JDBC_URL");
		}
		if (! Util.isEmpty(p_ClientsToInclude, true) && ! Util.isEmpty(p_ClientsToExclude, true))
			throw new AdempiereException("Tenants to exclude and include cannot be used at the same time");
		if (Util.isEmpty(p_UserName, true))
			p_UserName = CConnection.get().getDbUid();
		if (Util.isEmpty(p_Password, true))
			p_Password = CConnection.get().getDbPwd();
		
		// Construct the where clauses
		p_excludeTablesWhere.append("(UPPER(AD_Table.TableName) NOT LIKE 'T|_%' ESCAPE '|'"); // exclude temporary tables
		if (p_IsCopyClient) {
			// exclude always AD_ChangeLog when copying from template client
			p_excludeTablesWhere.append(" AND UPPER(TableName) != 'AD_CHANGELOG'");
		}
		if (Util.isEmpty(p_TablesToExclude, true)) {
			p_excludeTablesWhere.append(")");
		} else {
			p_excludeTablesWhere.append(" AND UPPER(TableName) NOT IN (");
			boolean addComma = false;
			for (String tableName : p_TablesToExclude.split(",")) {
				p_tablesToExcludeList.add(tableName.toUpperCase());
				if (addComma) {
					p_excludeTablesWhere.append(",");
				} else {
					addComma = true;
				}
				p_excludeTablesWhere.append(DB.TO_STRING(tableName.toUpperCase()));
			}
			p_excludeTablesWhere.append("))");
		}

		p_whereClient.append("AD_Client.AD_Client_ID NOT IN (0"); // by default exclude System
		if (! Util.isEmpty(p_ClientsToExclude, true)) {
			for (String clientStr : p_ClientsToExclude.split(",")) {
				p_whereClient.append(",");
				int clientInt;
				try {
					clientInt = Integer.parseInt(clientStr);
				} catch (NumberFormatException e) {
					throw new AdempiereException("Error in parameter Tenants to Exclude, must be a list of integer separated by commas, wrong format: " + clientStr);
				}
				p_whereClient.append(clientInt);
			}
		}
		p_whereClient.append(")");
		if (! Util.isEmpty(p_ClientsToInclude, true)) {
			p_whereClient.append(" AND AD_Client.AD_Client_ID IN (");
			boolean addComma = false;
			for (String clientStr : p_ClientsToInclude.split(",")) {
				if (addComma) {
					p_whereClient.append(",");
				} else {
					addComma = true;
				}
				int clientInt;
				try {
					clientInt = Integer.parseInt(clientStr);
				} catch (NumberFormatException e) {
					throw new AdempiereException("Error in parameter Tenants to Include, must be a list of integer separated by commas, wrong format: " + clientStr);
				}
				p_whereClient.append(clientInt);
			}
			p_whereClient.append(")");
		}

		if (! Util.isEmpty(p_TablesToPreserveIDs, true)) {
			if  ("*".equals(p_TablesToPreserveIDs)) {
				p_isPreserveAll = true;
			} else {
				p_isPreserveAll = false;
				for (String tableName : p_TablesToPreserveIDs.split(",")) {
					p_tablesToPreserveIDsList.add(tableName.toUpperCase());
				}
			}
		}

		// Make the connection to external database - or to the same local when copying template
		externalConn = null;
		try {
			try {
				if (p_IsCopyClient) {
					externalConn = DB.getConnection();
				} else {
					externalConn = DB.getDatabase(p_JDBC_URL).getDriverConnection(p_JDBC_URL, p_UserName, p_Password);
				}
			} catch (Exception e) {
				throw new AdempiereException("Could not get a connection to " + p_JDBC_URL + ",\nCause: " + e.getLocalizedMessage());
			}

			validate();
			if (p_errorList.size() > 0) {
				for (String err : p_errorList) {
					addLog(err);
				}
				return "@Error@";
			}

			if (! p_IsValidateOnly) {
				moveClient();
			}
		} finally {
			if (externalConn != null)
				externalConn.close();
		}

		checkSequences();

		return "@OK@";
	}

	/**
	 * Conduct data validations before proceeding with the actual inserts
	 */
	private void validate() {
		if (p_IsCopyClient) {
			// Validate that the newtenant value/name doesn't exist
			int cntCN = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM AD_Client WHERE Name=?", p_ClientName);
			if (cntCN > 0)
				throw new AdempiereUserError("Tenant with name " + p_ClientName + " already exists in database");
			int cntCV = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM AD_Client WHERE Value=?", p_ClientValue);
			if (cntCV > 0)
				throw new AdempiereUserError("Tenant with search key " + p_ClientValue + " already exists in database");
			int cntCW = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM W_Store WHERE WebContext=?", p_ClientValue.toLowerCase());
			if (cntCW > 0)
				throw new AdempiereUserError("WebStore with context " + p_ClientValue.toLowerCase() + " already exists in database");
		}
		
		// validate there are clients to move, and doesn't exist in target
		StringBuilder sqlValidClientsSB = new StringBuilder()
				.append("SELECT AD_Client_ID, Value, Name, AD_Client_UU FROM AD_Client WHERE ")
				.append(p_whereClient)
				.append(" ORDER BY Value");
		StringBuilder sqlValidateLocalClient = new StringBuilder()
				.append("SELECT COUNT(*) FROM AD_Client WHERE Value=? OR Name=? OR AD_Client_UU=?");
		if (p_isPreserveAll || p_tablesToPreserveIDsList.contains("AD_CLIENT")) {
			sqlValidateLocalClient.append(" OR AD_Client_ID=?");
		}
		String sqlValidClients = DB.getDatabase().convertStatement(sqlValidClientsSB.toString());
		PreparedStatement stmtVC = null;
		ResultSet rsVC = null;
		int noClients = 0;
		try {
			stmtVC = externalConn.prepareStatement(sqlValidClients, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			rsVC = stmtVC.executeQuery();
			while (rsVC.next()) {
				noClients++;
				int clientID = rsVC.getInt(1);
				String clientValue = rsVC.getString(2);
				String clientName = rsVC.getString(3);
				String clientUUID = rsVC.getString(4);
				if (! p_IsCopyClient) {
					int cnt = 0;
					if (p_isPreserveAll || p_tablesToPreserveIDsList.contains("AD_CLIENT")) {
						cnt = DB.getSQLValueEx(get_TrxName(), sqlValidateLocalClient.toString(), clientValue, clientName, clientUUID, clientID);
					} else {
						cnt = DB.getSQLValueEx(get_TrxName(), sqlValidateLocalClient.toString(), clientValue, clientName, clientUUID);
					}
					if (cnt > 0) {
						String msg = "Tenant " + clientValue + "/" + clientName + " already exists.  UUID=" + clientUUID;
						if (p_isPreserveAll || p_tablesToPreserveIDsList.contains("AD_CLIENT")) {
							msg += ", ID=" + clientID;
						}
						p_errorList.add(msg);
					}
				}
			}
		} catch (SQLException e) {
			throw new AdempiereException("Could not execute external query: " + sqlValidClients + "\nCause = " + e.getLocalizedMessage());
		} finally {
			DB.close(rsVC, stmtVC);
		}
		if (noClients <= 0) {
			throw new AdempiereUserError("No tenants to move");
		}
		if (p_errorList.size() > 0) {
			return;
		}

		// validate if there are attachments using external storage provider - inform not implemented yet (blocking)
		if (! p_excludeTablesWhere.toString().contains("'AD_ATTACHMENT'")) {
			statusUpdate("Checking storage for attachments");
			StringBuilder sqlExternalAttachment = new StringBuilder()
					.append("SELECT COUNT(*) FROM AD_Attachment")
					.append(" JOIN AD_Client ON (AD_Attachment.AD_Client_ID=AD_Client.AD_Client_ID)")
					.append(" JOIN AD_ClientInfo ON (AD_Attachment.AD_Client_ID=AD_ClientInfo.AD_Client_ID)")
					.append(" JOIN AD_Table ON (AD_Attachment.AD_Table_ID=AD_Table.AD_Table_ID)")
					.append(" LEFT JOIN AD_StorageProvider ON (AD_StorageProvider.AD_StorageProvider_ID=AD_ClientInfo.AD_StorageProvider_ID)")
					.append(" WHERE AD_StorageProvider.Method IS NOT NULL AND AD_StorageProvider.Method!='DB'")
					.append(" AND ").append(p_whereClient)
					.append(" AND ").append(p_excludeTablesWhere);
			int cntES = countInExternal(sqlExternalAttachment.toString());
			if (cntES > 0) {
				throw new AdempiereUserError("There are attachments using external storage provider - that's not implemented yet");
			}
		}

		// validate if there are archives using external storage provider - inform not implemented yet (blocking)
		if (! p_excludeTablesWhere.toString().contains("'AD_ARCHIVE'")) {
			statusUpdate("Checking storage for archives");
			StringBuilder sqlExternalArchive = new StringBuilder()
					.append("SELECT COUNT(*) FROM AD_Archive")
					.append(" JOIN AD_Client ON (AD_Archive.AD_Client_ID=AD_Client.AD_Client_ID)")
					.append(" JOIN AD_ClientInfo ON (AD_Archive.AD_Client_ID=AD_ClientInfo.AD_Client_ID)")
					.append(" JOIN AD_Table ON (AD_Archive.AD_Table_ID=AD_Table.AD_Table_ID)")
					.append(" LEFT JOIN AD_StorageProvider ON (AD_StorageProvider.AD_StorageProvider_ID=AD_ClientInfo.StorageArchive_ID)")
					.append(" WHERE AD_StorageProvider.Method IS NOT NULL AND AD_StorageProvider.Method!='DB'")
					.append(" AND ").append(p_whereClient)
					.append(" AND ").append(p_excludeTablesWhere);
			int cntEA = countInExternal(sqlExternalArchive.toString());
			if (cntEA > 0) {
				throw new AdempiereUserError("There are archives using external storage provider - that's not implemented yet");
			}
		}

		// create list of tables to ignore
		// validate tables
		// for each source table not excluded
		StringBuilder sqlTablesSB = new StringBuilder()
				.append("SELECT TableName FROM AD_Table WHERE IsActive='Y' AND IsView='N' AND ")
				.append(p_excludeTablesWhere)
				.append(" ORDER BY TableName");

		String sqlRemoteTables = DB.getDatabase().convertStatement(sqlTablesSB.toString());
		PreparedStatement stmtRT = null;
		ResultSet rsRT = null;
		try {
			stmtRT = externalConn.prepareStatement(sqlRemoteTables, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			rsRT = stmtRT.executeQuery();
			while (rsRT.next()) {
				String tableName = rsRT.getString(1);
				validateExternalTable(tableName);
			}
		} catch (SQLException e) {
			throw new AdempiereException("Could not execute external query: " + sqlRemoteTables + "\nCause = " + e.getLocalizedMessage());
		} finally {
			DB.close(rsRT, stmtRT);
		}

		if (! p_IsSkipSomeValidations) {
			for (String tableName : p_tablesVerifiedList) {
				validateOrphan(tableName);
			}
		}

	}

	/**
	 * Conduct validations on a specific table
	 * @param tableName
	 */
	private void validateExternalTable(String tableName) {
		statusUpdate("Validating table " + tableName);

		// if table is not present in target
		// inform blocking as it has client data
		MTable localTable = MTable.get(getCtx(), tableName);
		if (localTable == null || localTable.getAD_Table_ID() <= 0) {
			p_errorList.add("Table " + tableName + " doesn't exist");
			return;
		}

		// if table doesn't have client data (taking into account include/exclude) in the source DB
		// add to the list of tables to ignore
		// ignore and continue with next table
		if (! "AD_Client".equalsIgnoreCase(tableName)) {
			StringBuilder sqlCountData = new StringBuilder()
					.append("SELECT COUNT(*) FROM ").append(tableName);
			if ("AD_Attribute_Value".equalsIgnoreCase(tableName)) {
				sqlCountData.append(" JOIN AD_Attribute ON (AD_Attribute_Value.AD_Attribute_ID=AD_Attribute.AD_Attribute_ID)");
				sqlCountData.append(" JOIN AD_Client ON (AD_Attribute.AD_Client_ID=AD_Client.AD_Client_ID)");
			} else if ("AD_PInstance_Log".equalsIgnoreCase(tableName)) {
				sqlCountData.append(" JOIN AD_PInstance ON (AD_PInstance_Log.AD_PInstance_ID=AD_PInstance.AD_PInstance_ID)");
				sqlCountData.append(" JOIN AD_Client ON (AD_PInstance.AD_Client_ID=AD_Client.AD_Client_ID)");
			} else {
				if (MColumn.get(getCtx(), tableName, "AD_Client_ID") == null) {
					if (log.isLoggable(Level.WARNING)) log.warning("Ignoring " + tableName + ", doesn't have column AD_Client_ID");
					return;
				}
				sqlCountData.append(" JOIN AD_Client ON (").append(tableName).append(".AD_Client_ID=AD_Client.AD_Client_ID)");
			}
			sqlCountData.append(" WHERE ").append(p_whereClient);
			int cntCD = countInExternal(sqlCountData.toString());
			if (cntCD == 0) {
				if (log.isLoggable(Level.INFO)) log.info("Ignoring " + tableName + ", doesn't have tenant data");
				return;
			}
			if (cntCD > 0 && "AD_Attribute_Value".equalsIgnoreCase(tableName)) {
				throw new AdempiereUserError("Table " + tableName + " has data, migration not supported");
			}
		}

		// for each source column
		final String sqlRemoteColumnsST = ""
				+ " SELECT AD_Column.ColumnName, AD_Column.AD_Reference_ID, AD_Column.FieldLength"
				+ " FROM AD_Column"
				+ " JOIN AD_Table ON (AD_Table.AD_Table_ID=AD_Column.AD_Table_ID)"
				+ " WHERE UPPER(AD_Table.TableName)=? AND AD_Column.IsActive='Y' AND AD_Column.ColumnSQL IS NULL"
				+ " ORDER BY AD_Column.ColumnName";
		String sqlRemoteColumns = DB.getDatabase().convertStatement(sqlRemoteColumnsST);
		PreparedStatement stmtRC = null;
		ResultSet rsRC = null;
		try {
			stmtRC = externalConn.prepareStatement(sqlRemoteColumns, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			stmtRC.setString(1, tableName.toUpperCase());
			rsRC = stmtRC.executeQuery();
			while (rsRC.next()) {
				String columnName = rsRC.getString(1);
				int refID = rsRC.getInt(2);
				int length = rsRC.getInt(3);
				if (columnName.equalsIgnoreCase("AD_Client_ID")) {
					p_columnsVerifiedList.add(tableName.toUpperCase() + "." + columnName.toUpperCase());
				} else {
					validateExternalColumn(tableName, columnName, refID, length);
				}
			}
		} catch (SQLException e) {
			throw new AdempiereException("Could not execute external query: " + sqlRemoteColumns + "\nCause = " + e.getLocalizedMessage());
		} finally {
			DB.close(rsRC, stmtRC);
		}
		p_tablesVerifiedList.add(tableName.toUpperCase());
	}

	/**
	 * Conduct validations for a specific column
	 * @param tableName
	 * @param columnName
	 * @param refID
	 * @param length
	 */
	private void validateExternalColumn(String tableName, String columnName, int refID, int length) {
		// inform if column is not present in target (blocking as it has client data)
		// statusUpdate("Validating column " + tableName + "." + columnName);
		MColumn localColumn = MColumn.get(getCtx(), tableName, columnName);
		if (localColumn == null || localColumn.getAD_Column_ID() <= 0) {
			p_errorList.add("Column " + tableName + "." + columnName +  " doesn't exist");
			return;
		}

		// inform if db type is different (blocking as it has client data)
		if (refID <= MTable.MAX_OFFICIAL_ID
				&& localColumn.getAD_Reference_ID() <= MTable.MAX_OFFICIAL_ID 
				&& refID != localColumn.getAD_Reference_ID()) {
			p_errorList.add("Column " + tableName + "." + columnName +  " has different type in dictionary, external: " + refID + ", local: " + localColumn.getAD_Reference_ID());
		}

		// inform blocking if external length is bigger than local
		if (length > localColumn.getFieldLength()) {
			p_errorList.add("Column " + tableName + "." + columnName +  " has different length in dictionary, external: " + length + ", local: " + localColumn.getFieldLength());
		}

		StringBuilder sqlDataNotNullInColumn = new StringBuilder()
				.append("SELECT COUNT(*) FROM ").append(tableName)
				.append(" JOIN AD_Client ON (").append(tableName).append(".AD_Client_ID=AD_Client.AD_Client_ID)")
				.append(" WHERE ").append(tableName).append(".").append(columnName).append(" IS NOT NULL")
				.append(" AND ").append(p_whereClient);
		if (!p_IsSkipSomeValidations && refID > MTable.MAX_OFFICIAL_ID) {
			int cntET = countInExternal(sqlDataNotNullInColumn.toString());
			if (cntET > 0) {
				// TODO: Implement support for non-official data types (must implement how to obtain the foreign table with MColumn.getReferenceTableName)
				throw new AdempiereUserError("There is data in unsupported non-official data type for column " + tableName + "." + columnName);
			}
		}

		// when the column is a foreign key
		String foreignTableName = localColumn.getReferenceTableName();
		if (   foreignTableName != null 
			&& (foreignTableName.equalsIgnoreCase(tableName) || "AD_PInstance_Log".equalsIgnoreCase(tableName))) {
			foreignTableName = "";
		}
		if (! Util.isEmpty(foreignTableName)) {
			// verify all foreign keys pointing to a different client
			// if pointing to a different client non-system
			//   inform cross-client data corruption error
			// if pointing to system
			//   add to list of columns with system foreign keys
			//   inform if the system record is not in target database using uuid - blocking
			String uuidCol = PO.getUUIDColumnName(foreignTableName);
			StringBuilder sqlForeignClientSB = new StringBuilder();
			if ("AD_Ref_List".equalsIgnoreCase(foreignTableName)) {
				sqlForeignClientSB
				.append("SELECT DISTINCT AD_Ref_List.AD_Client_ID, AD_Ref_List.AD_Ref_List_ID, AD_Ref_List.").append(uuidCol)
				.append(" FROM ").append(tableName);
				if (! "AD_Client".equalsIgnoreCase(tableName)) {
					sqlForeignClientSB.append(" JOIN AD_Client ON (").append(tableName).append(".AD_Client_ID=AD_Client.AD_Client_ID)");
				}
				sqlForeignClientSB.append(" JOIN AD_Ref_List ON (").append(tableName).append(".").append(columnName).append("=AD_Ref_List.");
				if ("AD_Ref_List_ID".equalsIgnoreCase(columnName)) {
					sqlForeignClientSB.append("AD_Ref_List_ID");
				} else {
					sqlForeignClientSB.append("Value");
				}
				sqlForeignClientSB.append(" AND AD_Ref_List.AD_Reference_ID=")
				.append(" (SELECT AD_Column.AD_Reference_Value_ID FROM AD_Column")
				.append(" JOIN AD_Table ON (AD_Column.AD_Table_ID=AD_Table.AD_Table_ID)")
				.append(" WHERE UPPER(AD_Table.TableName)='").append(tableName.toUpperCase())
				.append("' AND UPPER(AD_Column.ColumnName)='").append(columnName.toUpperCase()).append("'))")
				.append(" WHERE ").append(p_whereClient)
				.append(" AND ").append(foreignTableName).append(".AD_Client_ID!=").append(tableName).append(".AD_Client_ID")
				.append(" ORDER BY 2");
			} else {
				sqlForeignClientSB.append("SELECT DISTINCT ").append(foreignTableName).append(".AD_Client_ID, ");
				MTable foreignTable = MTable.get(getCtx(), foreignTableName);
				if (foreignTable.isUUIDKeyTable()) {
					sqlForeignClientSB.append(foreignTableName).append(".").append(uuidCol).append(", ");
				} else {
					sqlForeignClientSB.append(foreignTableName).append(".").append(foreignTableName).append("_ID, ");
				}
				sqlForeignClientSB.append(foreignTableName).append(".").append(uuidCol).append(" FROM ").append(tableName);
				if (! "AD_Client".equalsIgnoreCase(tableName)) {
					sqlForeignClientSB.append(" JOIN AD_Client ON (").append(tableName).append(".AD_Client_ID=AD_Client.AD_Client_ID)");
				}
				if ("AD_Client".equalsIgnoreCase(foreignTableName)) { // fix issue with foreign AD_Client_ID like AD_Replication.Remote_Client_ID
					sqlForeignClientSB.append(" JOIN ").append(foreignTableName)
					.append(" c ON (").append(tableName).append(".").append(columnName).append("=c.");
				} else {
					sqlForeignClientSB.append(" JOIN ").append(foreignTableName)
					.append(" ON (").append(tableName).append(".").append(columnName).append("=").append(foreignTableName).append(".");
				}
				if ("AD_Language".equalsIgnoreCase(foreignTableName) && !columnName.equalsIgnoreCase("AD_Language_ID")) {
					sqlForeignClientSB.append("AD_Language");
				} else if ("AD_EntityType".equalsIgnoreCase(foreignTableName) && !columnName.equalsIgnoreCase("AD_EntityType_ID")) {
					sqlForeignClientSB.append("EntityType");
				} else {
					if (foreignTable.isUUIDKeyTable()) {
						sqlForeignClientSB.append(uuidCol);
					} else {
						sqlForeignClientSB.append(foreignTableName).append("_ID");
					}
				}
				sqlForeignClientSB.append(")")
				.append(" WHERE ").append(p_whereClient)
				.append(" AND ").append(foreignTableName).append(".AD_Client_ID!=").append(tableName).append(".AD_Client_ID")
				.append(" ORDER BY 2");
			}
			String sqlForeignClient = DB.getDatabase().convertStatement(sqlForeignClientSB.toString());
			PreparedStatement stmtFC = null;
			ResultSet rsFC = null;
			try {
				stmtFC = externalConn.prepareStatement(sqlForeignClient, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
				rsFC = stmtFC.executeQuery();
				while (rsFC.next()) {
					int clientID = rsFC.getInt(1);
					Object foreignID = rsFC.getObject(2);
					String foreignUU = rsFC.getString(3);
					if (clientID > 0) {
						p_errorList.add("Column " + tableName + "." + columnName +  " has invalid cross-tenant reference to tenant " + clientID + " on ID=" + foreignID);
						continue;
					}
					if (foreignID != null) {
						if (! p_idSystemConversionList.contains(foreignTableName.toUpperCase() + "." + foreignID)) {
							Object localID = getFromUUID(foreignTableName, uuidCol, tableName, columnName, foreignUU, foreignID);
							if (localID == null || (localID instanceof Number && ((Number)localID).intValue() < 0)) {
								continue;
							}
						}
					}
				}
			} catch (SQLException e) {
				throw new AdempiereException("Could not execute external query: " + sqlForeignClient + "\nCause = " + e.getLocalizedMessage());
			} finally {
				DB.close(rsFC, stmtFC);
			}
		}
		// add to the list of verified columns
		p_columnsVerifiedList.add(tableName.toUpperCase() + "." + columnName.toUpperCase());
	}

	/**
	 * Check for orphan records in a table
	 * @param tableName
	 */
	private void validateOrphan(String tableName) {
		MTable table = MTable.get(getCtx(), tableName);
		for (MColumn column : table.getColumns(false)) {
			if (!column.isActive() || column.getColumnSQL() != null) {
				continue;
			}
			String columnName = column.getColumnName();
			if ("AD_Client_ID".equalsIgnoreCase(columnName)) {
				continue;
			}
			String foreignTableName = column.getReferenceTableName();
			if (! Util.isEmpty(foreignTableName) && ! "AD_Ref_List".equalsIgnoreCase(foreignTableName)) {
				MTable tableFK = MTable.get(getCtx(), foreignTableName);
				if (tableFK == null || MTable.ACCESSLEVEL_SystemOnly.equals(tableFK.getAccessLevel())) {
					continue;
				}
				// validate if the table has columns where the constraint is not created in database, like most AD_Org_ID for example
				StringBuilder sqlVerifFKSB = new StringBuilder()
						.append("SELECT COUNT(*) ")
						.append("FROM   AD_Table t ")
						.append("       JOIN AD_Column c ")
						.append("         ON ( c.AD_Table_ID = t.AD_Table_ID ) ")
						.append("WHERE  UPPER(t.TableName)=").append(DB.TO_STRING(tableName.toUpperCase()))
						.append("       AND UPPER(c.ColumnName)=").append(DB.TO_STRING(columnName.toUpperCase()))
						.append("       AND ( c.FKConstraintType IS NULL OR c.FKConstraintType=").append(DB.TO_STRING(MColumn.FKCONSTRAINTTYPE_DoNotCreate_Ignore)).append(")");
				int cntFk = countInExternal(sqlVerifFKSB.toString());
				if (cntFk > 0) {
					statusUpdate("Validating orphans for " + table.getTableName() + "." + columnName);
					// target database has not defined a foreign key, validate orphans
					MTable foreignTable = MTable.get(getCtx(), foreignTableName);
					StringBuilder sqlExternalOrgOrphanSB = new StringBuilder("SELECT COUNT(*) FROM ").append(tableName);
					if (! "AD_Client".equalsIgnoreCase(tableName)) {
						sqlExternalOrgOrphanSB.append(" JOIN AD_Client ON (").append(tableName).append(".AD_Client_ID=AD_Client.AD_Client_ID)");
					}
					sqlExternalOrgOrphanSB.append(" WHERE ").append(tableName).append(".").append(columnName);
					if (foreignTable.isUUIDKeyTable())
						sqlExternalOrgOrphanSB.append(" IS NOT NULL AND ");
					else
						sqlExternalOrgOrphanSB.append(">0 AND ");
					sqlExternalOrgOrphanSB.append(" ").append(tableName).append(".").append(columnName).append(" NOT IN (")
						.append(" SELECT ").append(foreignTableName).append(".").append(foreignTable.getKeyColumns()[0])
						.append(" FROM ").append(foreignTableName)
						.append(" WHERE ").append(foreignTableName).append(".AD_Client_ID IN (0,").append(tableName).append(".AD_Client_ID)")
						.append(")")
						.append(" AND ").append(p_whereClient);
					int cntOr = countInExternal(sqlExternalOrgOrphanSB.toString());
					if (cntOr > 0) {
						p_errorList.add("Column " + tableName + "." + columnName +  " has orphan records in table " + foreignTableName);
					}
				}
			}
		}

	}

	/**
	 * Execute a count query in the external connection and return the count
	 * @param sql
	 * @return
	 */
	private int countInExternal(String sql) {
		int cnt = 0;
		sql = DB.getDatabase().convertStatement(sql);
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = externalConn.prepareStatement(sql, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery();
			if (rs.next())
				cnt = rs.getInt(1);
		} catch (SQLException e) {
			throw new AdempiereException("Could not execute external query: " + sql + "\nCause = " + e.getLocalizedMessage());
		} finally {
			DB.close(rs, stmt);
		}
		return cnt;
	}

	/**
	 * Convert the IDs in table T_MoveClient and then proceed to do the INSERTs of new records
	 */
	private void moveClient() {
		// first do the validation, process cannot be executed if there are blocking situations
		// validation construct the list of tables and columns to process
		// NOTE that the whole process will be done in a single transaction, foreign keys will be validated on commit

		List<MTable> tables = new Query(getCtx(), MTable.Table_Name,
				"IsView='N' AND " + p_excludeTablesWhere,
				get_TrxName())
				.setOnlyActiveRecords(true)
				.setOrderBy("TableName")
				.list();

		// create/verify the ID conversions
		for (MTable table : tables) {
			String tableName = table.getTableName();
			if (! p_tablesVerifiedList.contains(tableName.toUpperCase())) {
				continue;
			}
			String uuidCol = PO.getUUIDColumnName(tableName);
			String keyCol;
			if (table.isUUIDKeyTable())
				keyCol = uuidCol.toUpperCase();
			else
				keyCol = tableName.toUpperCase() + "_ID";
			if (! p_columnsVerifiedList.contains(tableName.toUpperCase() + "." + keyCol))
				continue;
			
			statusUpdate("Converting IDs for table " + tableName);
			StringBuilder selectVerifyIdSB = new StringBuilder()
					.append("SELECT ").append(keyCol).append(" FROM ").append(tableName)
					.append(" WHERE ").append(keyCol).append("=?");
			StringBuilder selectGetIdsSB = new StringBuilder()
					.append("SELECT ").append(tableName).append(".").append(keyCol).append(" FROM ").append(tableName);
			if (! "AD_Client".equalsIgnoreCase(tableName)) {
				selectGetIdsSB.append(" JOIN AD_Client ON (").append(tableName).append(".AD_Client_ID=AD_Client.AD_Client_ID)");
			}
			selectGetIdsSB.append(" WHERE ").append(p_whereClient)
			.append(" ORDER BY ").append(keyCol);
			String selectGetIds = DB.getDatabase().convertStatement(selectGetIdsSB.toString());
			PreparedStatement stmtGI = null;
			ResultSet rsGI = null;
			try {
				stmtGI = externalConn.prepareStatement(selectGetIds, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
				rsGI = stmtGI.executeQuery();
				while (rsGI.next()) {
					Object source_Key = rsGI.getObject(1);
					Object target_Key = null;
					if (p_isPreserveAll || p_tablesToPreserveIDsList.contains(tableName.toUpperCase())) {
						List<Object> list = DB.getSQLValueObjectsEx(get_TrxName(), selectVerifyIdSB.toString(), source_Key);
						Object localID = null;
						if (list != null && list.size() == 1)
							localID = list.get(0);
						if (localID == null || (localID instanceof Number && ((Number)localID).intValue() < 0)) {
							target_Key = source_Key;
						} else {
							throw new AdempiereException("In " + tableName + "." + tableName + "_ID already exist the ID=" + source_Key);
						}
					} else {
						if ("AD_ChangeLog".equalsIgnoreCase(tableName)) {
							// AD_ChangeLog_ID is not really a unique key - validate if it was already converted before
							int clId = DB.getSQLValueEx(get_TrxName(),
									queryT_MoveClient,
									getAD_PInstance_ID(), "AD_CHANGELOG", String.valueOf(source_Key));
							if (clId == -1) {
								target_Key = DB.getNextID(getAD_Client_ID(), tableName, get_TrxName());
							}
						} else {
							if (table.isUUIDKeyTable())
								target_Key = UUID.randomUUID().toString();
							else
								target_Key = DB.getNextID(getAD_Client_ID(), tableName, get_TrxName());
						}
					}
					if (target_Key != null || (target_Key instanceof Number && ((Number)target_Key).intValue() >= 0)) {
						DB.executeUpdateEx(insertConversionId,
								new Object[] {getAD_PInstance_ID(), tableName.toUpperCase(), source_Key, target_Key},
								get_TrxName());
					}
				}
			} catch (SQLException e) {
				throw new AdempiereException("Could not execute external query: " + selectGetIds + "\nCause = " + e.getLocalizedMessage());
			} finally {
				DB.close(rsGI, stmtGI);
			}

		}

		try {
			commitEx(); // commit the T_MoveClient table to analyze potential problems
		} catch (SQLException e1) {
			throw new AdempiereException(e1);
		} 

		int newADClientID = -1;
		String oldClientValue = null;
		if (p_IsCopyClient) {
			int clientInt;
			try {
				clientInt = Integer.parseInt(p_ClientsToInclude);
			} catch (NumberFormatException e) {
				throw new AdempiereException("Error in parameter Tenants to Include, must be just one integer");
			}
			newADClientID = DB.getSQLValueEx(get_TrxName(),
					queryT_MoveClient,
					getAD_PInstance_ID(), "AD_CLIENT", String.valueOf(clientInt));
			oldClientValue = DB.getSQLValueStringEx(get_TrxName(),
					"SELECT Value FROM AD_Client WHERE AD_Client_ID=?", clientInt);
		}

		// get the source data and insert into target converting the IDs
		for (MTable table : tables) {
			String tableName = table.getTableName();
			if (! p_tablesVerifiedList.contains(tableName.toUpperCase())) {
				continue;
			}
			statusUpdate("Inserting data for table " + tableName);
			StringBuilder valuesSB = new StringBuilder();
			StringBuilder columnsSB = new StringBuilder();
			StringBuilder qColumnsSB = new StringBuilder();
			int ncols = 0;
			List<MColumn> columns = new ArrayList<MColumn>();
			for (MColumn column : table.getColumns(false)) {
				if (!column.isActive() || column.getColumnSQL() != null) {
					continue;
				}
				String columnName = column.getColumnName();
				if (! p_columnsVerifiedList.contains(tableName.toUpperCase() + "." + columnName.toUpperCase())) {
					continue;
				}
				if (columnsSB.length() > 0) {
					qColumnsSB.append(",");
					columnsSB.append(",");
					valuesSB.append(",");
				}
				String quoteColumnName = DB.getDatabase().quoteColumnName(columnName);
				qColumnsSB.append(tableName).append(".").append(quoteColumnName);
				columnsSB.append(quoteColumnName);
				valuesSB.append("?");
				columns.add(column);
				ncols++;
			}
			StringBuilder insertSB = new StringBuilder()
					.append("INSERT INTO ").append(tableName).append("(").append(columnsSB).append(") VALUES (").append(valuesSB).append(")");
			StringBuilder selectGetDataSB = new StringBuilder()
					.append("SELECT ").append(qColumnsSB)
					.append(" FROM ").append(tableName);
			if ("AD_PInstance_Log".equalsIgnoreCase(tableName)) {
				selectGetDataSB.append(" JOIN AD_PInstance ON (AD_PInstance_Log.AD_PInstance_ID=AD_PInstance.AD_PInstance_ID)");
				selectGetDataSB.append(" JOIN AD_Client ON (AD_PInstance.AD_Client_ID=AD_Client.AD_Client_ID)");
			} else if (! "AD_Client".equalsIgnoreCase(tableName)) {
				selectGetDataSB.append(" JOIN AD_Client ON (").append(tableName).append(".AD_Client_ID=AD_Client.AD_Client_ID)");
			}
			selectGetDataSB.append(" WHERE ").append(p_whereClient);
			String selectGetData = DB.getDatabase().convertStatement(selectGetDataSB.toString());
			PreparedStatement stmtGD = null;
			ResultSet rsGD = null;
			Object[] parameters = new Object[ncols];
			try {
				stmtGD = externalConn.prepareStatement(selectGetData, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
				rsGD = stmtGD.executeQuery();
				while (rsGD.next()) {
					boolean insertRecord = true;
					for (int i = 0; i < ncols; i++) {
						MColumn column = columns.get(i);
						String columnName = column.getColumnName();

						// Obtain which is the table to convert the ID (the foreign table)
						String convertTable = column.getReferenceTableName();
						if ((tableName + "_ID").equalsIgnoreCase(columnName)) {
							convertTable = tableName;
						} else if (DisplayType.isMultiID(column.getAD_Reference_ID())) {
							convertTable = column.getMultiReferenceTableName();
						} else if (convertTable != null
								&& ("AD_Ref_List".equalsIgnoreCase(convertTable)
										|| "AD_Language".equalsIgnoreCase(columnName)
										|| "EntityType".equalsIgnoreCase(columnName))) {
							convertTable = "";
						} else if (("Record_ID".equalsIgnoreCase(columnName) || "Record_UU".equalsIgnoreCase(columnName)) && table.columnExistsInDB("AD_Table_ID")) {
							// Special case for Record_ID or Record_UU
							int tableId = rsGD.getInt("AD_Table_ID");
							if (tableId > 0) {
								convertTable = getExternalTableName(tableId);
							} else {
								convertTable = "";
							}
						} else if ("Line_ID".equalsIgnoreCase(columnName) && "Fact_Acct".equalsIgnoreCase(tableName)) {
							// Special case for Fact_Acct.Line_ID
							int tableId = rsGD.getInt("AD_Table_ID");
							if (tableId > 0) {
								convertTable = getAcctDetailTableName(tableId);
							} else {
								convertTable = "";
							}
						} else if ("Parent_ID".equalsIgnoreCase(columnName) && "AD_Tree_Favorite_Node".equalsIgnoreCase(tableName)) {
							// Special case for AD_Tree_Favorite_Node.Parent_ID
							convertTable = "AD_Tree_Favorite_Node";
						} else if ("Node_ID".equalsIgnoreCase(columnName) && "AD_TreeBar".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeBar.Node_ID
							convertTable = "AD_Menu";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNodeMM".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNodeMM.Node/Parent_ID
							convertTable = "AD_Menu";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNodeBP".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNodeBP.Node/Parent_ID
							convertTable = "C_BPartner";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNodeCMC".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNodeCMC.Node/Parent_ID
							convertTable = "CM_Container";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNodeCMM".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNodeCMM.Node/Parent_ID
							convertTable = "CM_Media";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNodeCMS".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNodeCMS.Node/Parent_ID
							convertTable = "CM_CStage";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNodeCMT".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNodeCMT.Node/Parent_ID
							convertTable = "CM_Template";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNodePR".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNodePR.Node/Parent_ID
							convertTable = "M_Product";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName)) 
								&& (       "AD_TreeNodeU1".equalsIgnoreCase(tableName)
										|| "AD_TreeNodeU2".equalsIgnoreCase(tableName) 
										|| "AD_TreeNodeU3".equalsIgnoreCase(tableName)
										|| "AD_TreeNodeU4".equalsIgnoreCase(tableName))) {
							// Special case for AD_TreeNodeU*.Node/Parent_ID
							convertTable = "C_ElementValue";
						} else if (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
								&& "AD_TreeNode".equalsIgnoreCase(tableName)) {
							// Special case for AD_TreeNode.Node/Parent_ID - depends on AD_Tree -> TreeType and AD_Table_ID
							int treeId = rsGD.getInt("AD_Tree_ID");
							convertTable = getExternalTableFromTree(treeId);
						} else if ("AD_Preference".equalsIgnoreCase(tableName) && "Value".equalsIgnoreCase(columnName)) {
							// Special case for AD_Preference.Value
							String att = rsGD.getString("Attribute");
							if (att.toUpperCase().endsWith("_ID")) {
								convertTable = att.substring(0, att.length()-3);
								if ("C_DocTypeTarget".equals(convertTable)) {
									convertTable = "C_DocType";
								} else {
									// validate that AD_Preference points to a valid table, ignore otherwise
									if (MTable.getTable_ID(convertTable, get_TrxName()) <= 0) {
										convertTable = "";
									}
								}
							} else {
								convertTable = "";
							}
						}

						// Fill the target value
						if (! Util.isEmpty(convertTable)) {
							// Foreign - potential ID conversion
							Object key = rsGD.getObject(i + 1);
							if (rsGD.wasNull()) {
								parameters[i] = null;
							} else {
								if (   ! (key instanceof Number && ((Number)key).intValue() == 0 && ("Parent_ID".equalsIgnoreCase(columnName) || "Node_ID".equalsIgnoreCase(columnName)))  // Parent_ID/Node_ID=0 is valid
									&& (key instanceof String || (key instanceof Number && ((Number)key).intValue() >= MTable.MAX_OFFICIAL_ID) || p_IsCopyClient)) {
									Object convertedId = null;

									if (DisplayType.isMultiID(column.getAD_Reference_ID())) {
										// multiple IDs or UUIDs separated by commas
										String[] multiKeys = ((String)key).split(",");
										for (String multiKey : multiKeys) {
											Object keyToConvert;
											if (Util.isUUID(multiKey))
												keyToConvert = multiKey;
											else
												keyToConvert = Integer.valueOf(multiKey);
											Object multiConvertedId = getConvertedId(convertTable, keyToConvert, tableName, columnName);
											if (multiConvertedId == null || (multiConvertedId instanceof Number && ((Number)multiConvertedId).intValue() < 0)) {
												if (canIgnoreNullConvertedId(table, tableName, columnName, convertTable)) {
													insertRecord = false;
													break;
												} else {
													throw new AdempiereException("Found orphan record in " + tableName + "." + columnName + ": " + multiKey + " related to table " + convertTable);
												}
											}
											if (convertedId == null) {
												convertedId = "";
											} else {
												convertedId += ",";
											}
											convertedId += String.valueOf(multiConvertedId);
										}
									} else {
										// single ID or UUID to convert
										convertedId = getConvertedId(convertTable, key, tableName, columnName);
										if (convertedId == null || (convertedId instanceof Number && ((Number)convertedId).intValue() < 0)) {
											if (canIgnoreNullConvertedId(table, tableName, columnName, convertTable)) {
												insertRecord = false;
												break;
											} else {
												throw new AdempiereException("Found orphan record in " + tableName + "." + columnName + ": " + key + " related to table " + convertTable);
											}
										}
									}
									key = convertedId instanceof Number ? ((Number)convertedId).intValue() : convertedId.toString();
								}
								if ("AD_Preference".equalsIgnoreCase(tableName) && "Value".equalsIgnoreCase(columnName)) {
									parameters[i] = String.valueOf(key);
								} else {
									if (DisplayType.isText(column.getAD_Reference_ID()))
										parameters[i] = key.toString();
									else
										parameters[i] = Integer.valueOf(key.toString());
								}
							}
						} else {
							parameters[i] = rsGD.getObject(i + 1);
							if (rsGD.wasNull()) {
								parameters[i] = null;
							}
							if (p_IsCopyClient) {
								String uuidCol = PO.getUUIDColumnName(tableName);
								if (columnName.equals(uuidCol)) {
									String oldUUID = (String) parameters[i];
									// it is possible that the UUID has been resolved before because of a foreign key Record_UU, so search in T_MoveClient first
									String newUUID = DB.getSQLValueStringEx(get_TrxName(), queryT_MoveClient, getAD_PInstance_ID(), tableName.toUpperCase(), oldUUID);
									if (newUUID == null) {
										newUUID = UUID.randomUUID().toString();
									}
									parameters[i] = newUUID;
									if (! Util.isEmpty(oldUUID)) {
										X_AD_Package_UUID_Map map = new X_AD_Package_UUID_Map(getCtx(), 0, get_TrxName());
										map.setAD_Table_ID(table.getAD_Table_ID());
										map.set_ValueNoCheck("AD_Client_ID", newADClientID);
										map.setSource_UUID(oldUUID);
										map.setTarget_UUID(newUUID);
										map.saveEx();
									}
								} else if ("AD_Client".equalsIgnoreCase(tableName) && "Value".equalsIgnoreCase(columnName)) {
									parameters[i] = p_ClientValue;
								} else if ("AD_Client".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName)) {
									parameters[i] = p_ClientName;
								} else if (
										   ("W_Store".equalsIgnoreCase(tableName) && "WebContext".equalsIgnoreCase(columnName))
										|| ("AD_User".equalsIgnoreCase(tableName) && "Value".equalsIgnoreCase(columnName))
										) {
									parameters[i] = p_ClientValue.toLowerCase();
								} else if (
										   ("AD_User".equalsIgnoreCase(tableName) && "Password".equalsIgnoreCase(columnName))
										|| ("AD_User".equalsIgnoreCase(tableName) && "Salt".equalsIgnoreCase(columnName))
										) {
									parameters[i] = null; // do not assign passwords to new users, must be managed by SuperUser or plugin
								} else if (
										   ("AD_Org".equalsIgnoreCase(tableName) && "Value".equalsIgnoreCase(columnName))
										|| ("AD_Org".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("AD_Role".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("AD_Tree".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("AD_User".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("AD_User".equalsIgnoreCase(tableName) && "Description".equalsIgnoreCase(columnName))
										|| ("C_AcctProcessor".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("C_AcctSchema".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("C_BPartner".equalsIgnoreCase(tableName) && "Value".equalsIgnoreCase(columnName))
										|| ("C_BPartner".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("C_Calendar".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("C_Element".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("M_CostType".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										|| ("R_RequestProcessor".equalsIgnoreCase(tableName) && "Name".equalsIgnoreCase(columnName))
										) {
									if (parameters[i] != null) {
										String value = parameters[i].toString();
										parameters[i] = value.replaceFirst(oldClientValue, p_ClientValue);
									}
								}
							}
						}
					}
					if (insertRecord) {
						try {
							DB.executeUpdateEx(insertSB.toString(), parameters, get_TrxName());
						} catch (Exception e) {
							throw new AdempiereException("Could not execute: " + insertSB + "\nCause = " + e.getLocalizedMessage());
						}
					}
				}
			} catch (SQLException e) {
				throw new AdempiereException("Could not execute external query: " + selectGetData + "\nCause = " + e.getLocalizedMessage());
			} finally {
				DB.close(rsGD, stmtGD);
			}

		}

		// commit - here it can throw errors because of foreign keys, verify and inform
		statusUpdate("Committing.  Validating foreign keys");
		try {
			commitEx();
		} catch (SQLException e) {
			throw new AdempiereException("Could not commit,\nCause: " + e.getLocalizedMessage());
		}
	}

	/**
	 * Define if is acceptable to ignore a non existing converted ID
	 * @return
	 */
	private boolean canIgnoreNullConvertedId(MTable table, String tableName, String columnName, String convertTable) {
		if (   (("Record_ID".equalsIgnoreCase(columnName) || "Record_UU".equalsIgnoreCase(columnName)) && table.columnExistsInDB("AD_Table_ID"))
			|| ("Line_ID".equalsIgnoreCase(columnName) && "Fact_Acct".equalsIgnoreCase(tableName))
				|| (("Node_ID".equalsIgnoreCase(columnName) || "Parent_ID".equalsIgnoreCase(columnName))
						&& (   "AD_TreeNode".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeMM".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeBP".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeCMC".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeCMM".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeCMS".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeCMT".equalsIgnoreCase(tableName)
								|| "AD_TreeNodePR".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeU1".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeU2".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeU3".equalsIgnoreCase(tableName)
								|| "AD_TreeNodeU4".equalsIgnoreCase(tableName)
								|| "AD_Tree_Favorite_Node".equalsIgnoreCase(tableName)
								|| "AD_TreeBar".equalsIgnoreCase(tableName)))) {
			if (p_tablesToExcludeList.contains(convertTable.toUpperCase())) {
				// record is pointing to a table that is not included, ignore it
				return true;
			}
		}
		if (   "AD_ChangeLog".equalsIgnoreCase(tableName)
			|| "AD_PInstance".equalsIgnoreCase(tableName)
			|| "AD_PInstance_Log".equalsIgnoreCase(tableName)) {
			// skip orphan records in AD_ChangeLog, AD_PInstance and AD_PInstance_Log, can be log of deleted records, skip
			return true;
		}
		return false;
	}

	/**
	 * Return a converted ID
	 * @param convertTable
	 * @param key
	 * @param tableName
	 * @param columnName 
	 * @return
	 */
	private Object getConvertedId(String convertTable, Object key, String tableName, String columnName) {
		Object convertedId = null;
		try {
			List<Object> list = DB.getSQLValueObjectsEx(get_TrxName(), queryT_MoveClient,
					getAD_PInstance_ID(), convertTable.toUpperCase(), String.valueOf(key));
			if (list != null && list.size() == 1)
				convertedId = list.get(0);
		} catch (Exception e) {
			throw new AdempiereException("Could not execute query: " + queryT_MoveClient + "\nCause = " + e.getLocalizedMessage());
		}
		if (convertedId == null || (convertedId instanceof Number && ((Number)convertedId).intValue() < 0)) {
			// when obtaining a UUID for a non-UUID table means to generate and insert the conversion
			// for example AD_Attachment.Record_UU requires the UUID of a still not inserted record in another table
			MTable cTable = MTable.get(getCtx(), convertTable);
			if (key instanceof String && ! cTable.isUUIDKeyTable() && columnName.equals("Record_UU")) {
				convertedId = UUID.randomUUID().toString();
				DB.executeUpdateEx(insertConversionId,
						new Object[] {getAD_PInstance_ID(), convertTable.toUpperCase(), key, convertedId},
						get_TrxName());
			} else {
				// not found in the T_MoveClient table - try to get it again - could be missed in first pass
				convertedId = getLocalKeyFor(convertTable, key, tableName);
			}
		}
		return convertedId;
	}

	/**
	 * Return the table name of the table driving a tree 
	 * @param treeId
	 * @return
	 */
	private String getExternalTableFromTree(int treeId) {
		String tableName = null;
		final String sqlTableTree = ""
				+ "SELECT CASE "
				+ "         WHEN TreeType = 'AY' THEN 'C_Activity' "
				+ "         WHEN TreeType = 'BB' THEN 'M_BOM' "
				+ "         WHEN TreeType = 'BP' THEN 'C_BPartner' "
				+ "         WHEN TreeType = 'CC' THEN 'CM_Container' "
				+ "         WHEN TreeType = 'CM' THEN 'CM_Media' "
				+ "         WHEN TreeType = 'CS' THEN 'CM_CStage' "
				+ "         WHEN TreeType = 'CT' THEN 'CM_Template' "
				+ "         WHEN TreeType = 'EV' THEN 'C_ElementValue' "
				+ "         WHEN TreeType = 'MC' THEN 'C_Campaign' "
				+ "         WHEN TreeType = 'MM' THEN 'AD_Menu' "
				+ "         WHEN TreeType = 'OO' THEN 'AD_Org' "
				+ "         WHEN TreeType = 'PC' THEN 'M_Product_Category' "
				+ "         WHEN TreeType = 'PJ' THEN 'C_Project' "
				+ "         WHEN TreeType = 'PR' THEN 'M_Product' "
				+ "         WHEN TreeType = 'SR' THEN 'C_SalesRegion' "
				+ "         WHEN TreeType = 'U1' THEN 'C_ElementValue' "
				+ "         WHEN TreeType = 'U2' THEN 'C_ElementValue' "
				+ "         WHEN TreeType = 'U3' THEN 'C_ElementValue' "
				+ "         WHEN TreeType = 'U4' THEN 'C_ElementValue' "
				+ "         WHEN TreeType = 'TL' THEN AD_Table.TableName "
				+ "         ELSE NULL "
				+ "       END "
				+ "FROM   AD_Tree "
				+ "       LEFT JOIN AD_Table ON ( AD_Table.AD_Table_ID = AD_Tree.AD_Table_ID ) "
				+ "WHERE  AD_Tree_ID = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = externalConn.prepareStatement(sqlTableTree, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			stmt.setInt(1, treeId);
			rs = stmt.executeQuery();
			if (rs.next())
				tableName = rs.getString(1);
		} catch (SQLException e) {
			throw new AdempiereException("Could not execute external query: " + sqlTableTree + "\nCause = " + e.getLocalizedMessage());
		} finally {
			DB.close(rs, stmt);
		}
		return tableName;
	}

	/**
	 * Get the name of a table based on the AD_Table_ID - executed against the external connection
	 * @param tableId
	 * @return
	 */
	private String getExternalTableName(int tableId) {
		String tableName = null;
		String sql = DB.getDatabase().convertStatement("SELECT TableName FROM AD_Table WHERE AD_Table_ID=?");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = externalConn.prepareStatement(sql, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			stmt.setInt(1, tableId);
			rs = stmt.executeQuery();
			if (rs.next())
				tableName = rs.getString(1);
		} catch (SQLException e) {
			throw new AdempiereException("Could not execute external query: " + sql + "\nCause = " + e.getLocalizedMessage());
		} finally {
			DB.close(rs, stmt);
		}
		return tableName;
	}

	/**
	 * Get the Accounting Detail table based on the document table
	 * @param tableId
	 * @return
	 */
	private String getAcctDetailTableName(int tableId) {
		String detailTableName = "";
		switch (tableId) {
		case X_A_Depreciation_Entry.Table_ID : detailTableName = X_A_Depreciation_Exp.Table_Name  ; break;
		case X_C_AllocationHdr.Table_ID      : detailTableName = X_C_AllocationLine.Table_Name    ; break;
		case X_C_BankStatement.Table_ID      : detailTableName = X_C_BankStatementLine.Table_Name ; break;
		case X_C_Cash.Table_ID               : detailTableName = X_C_CashLine.Table_Name          ; break;
		case X_C_Invoice.Table_ID            : detailTableName = X_C_InvoiceLine.Table_Name       ; break;
		case X_C_Order.Table_ID              : detailTableName = X_C_OrderLine.Table_Name         ; break;
		case X_C_ProjectIssue.Table_ID       : detailTableName = X_C_ProjectIssue.Table_Name      ; break;
		case X_GL_Journal.Table_ID           : detailTableName = X_GL_JournalLine.Table_Name      ; break;
		case X_M_InOut.Table_ID              : detailTableName = X_M_InOutLine.Table_Name         ; break;
		case X_M_Inventory.Table_ID          : detailTableName = X_M_InventoryLine.Table_Name     ; break;
		case X_M_Movement.Table_ID           : detailTableName = X_M_MovementLine.Table_Name      ; break;
		case X_M_Production.Table_ID         : detailTableName = X_M_ProductionLine.Table_Name    ; break;
		case X_M_Requisition.Table_ID        : detailTableName = X_M_RequisitionLine.Table_Name   ; break;
		case X_A_Asset_Addition.Table_ID     : break;
		case X_A_Asset_Disposed.Table_ID     : break;
		case X_A_Asset_Reval.Table_ID        : break;
		case X_A_Asset_Transfer.Table_ID     : break;
		case X_M_MatchInv.Table_ID           : break;
		case X_M_MatchPO.Table_ID            : break;
		case X_C_Payment.Table_ID            : break;
		default: log.warning("Fact_Acct.Line_ID detail table not identified for table ID = " + tableId);
		}
		return detailTableName;
	}

	/**
	 * Check sequence for tables where the IDs must be preserved
	 */
	private void checkSequences() {
		if (p_isPreserveAll) {
			for (String tableName : p_tablesVerifiedList) {
				MSequence seq = MSequence.get(getCtx(), tableName, get_TrxName());
				if (seq != null) {
					seq.validateTableIDValue(); // ignore output messages
				}
			}
		} else {
			for (String tableName : p_tablesToPreserveIDsList) {
				MSequence seq = MSequence.get(getCtx(), tableName, get_TrxName());
				if (seq != null) {
					seq.validateTableIDValue(); // ignore output messages
				}
			}
		}
	}

	/**
	 * Get the local converted ID or UUID for a record
	 * @param tableName
	 * @param foreign_Key
	 * @param tableNameSource
	 * @return
	 */
	private Object getLocalKeyFor(String tableName, Object foreign_Key, String tableNameSource) {
		String uuidCol = PO.getUUIDColumnName(tableName);
		MTable table = MTable.get(getCtx(), tableName);
		String remoteUUID = null;
		if (! table.isIDKeyTable()) {
			remoteUUID = foreign_Key.toString();
		} else {
			StringBuilder sqlRemoteUUSB = new StringBuilder()
					.append("SELECT ").append(uuidCol).append(" FROM ").append(tableName)
					.append(" WHERE ").append(tableName).append("_ID=?");
			String sqlRemoteUU = DB.getDatabase().convertStatement(sqlRemoteUUSB.toString());
			PreparedStatement stmtUU = null;
			ResultSet rs = null;
			try {
				stmtUU = externalConn.prepareStatement(sqlRemoteUU, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
				stmtUU.setObject(1, foreign_Key);
				rs = stmtUU.executeQuery();
				if (rs.next())
					remoteUUID = rs.getString(1);
			} catch (SQLException e) {
				throw new AdempiereException("Could not execute external query for table " + tableNameSource + ": " + sqlRemoteUU + "\nCause = " + e.getLocalizedMessage());
			} finally {
				DB.close(rs, stmtUU);
			}
		}
		Object local_Key = null;
		if (remoteUUID != null) {
			local_Key = getFromUUID(tableName, uuidCol, null, null, remoteUUID, foreign_Key);
		}
		return local_Key;
	}

	/**
	 * Get the local ID or UUID based on a UUID
	 * @param foreignTableName
	 * @param uuidCol
	 * @param tableName
	 * @param columnName
	 * @param foreignUU
	 * @param foreign_Key
	 * @return
	 */
	private Object getFromUUID(String foreignTableName, String uuidCol, String tableName, String columnName, String foreignUU, Object foreign_Key) {
		Object local_Key = null;
		MTable foreignTable = MTable.get(getCtx(), foreignTableName);
		StringBuilder sqlCheckLocalUU = new StringBuilder("SELECT ");
		if (foreignTable.isUUIDKeyTable()) {
			sqlCheckLocalUU.append(PO.getUUIDColumnName(foreignTableName));
		} else {
			sqlCheckLocalUU.append(foreignTableName).append("_ID");
		}
		sqlCheckLocalUU.append(" FROM ").append(foreignTableName).append(" WHERE ").append(uuidCol).append("=?");
		List<Object> list = DB.getSQLValueObjectsEx(get_TrxName(), sqlCheckLocalUU.toString(), foreignUU);
		if (list != null && list.size() == 1)
			local_Key = list.get(0);
		if (local_Key == null || (local_Key instanceof Number && ((Number)local_Key).intValue() < 0)) {
			p_errorList.add("Column " + tableName + "." + columnName +  " has system reference not convertible, "
					+ foreignTableName + "." + uuidCol + "=" + foreignUU);
			return -1;
		}
		DB.executeUpdateEx(insertConversionId,
				new Object[] {getAD_PInstance_ID(), foreignTableName.toUpperCase(), foreign_Key, local_Key},
				get_TrxName());
		p_idSystemConversionList.add(foreignTableName.toUpperCase() + "." + foreign_Key);
		return local_Key;
	}

}
