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
 * - Carlos Ruiz - globalqss - bxservice                               *
 * Sponsored by FH                                                     *
 **********************************************************************/

package org.idempiere.process;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MChangeLog;
import org.compiere.model.MColumn;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcessPara;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.MVerifyMigration;
import org.compiere.model.MViewColumn;
import org.compiere.model.MViewComponent;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Msg;

@org.adempiere.base.annotation.Process
public class VerifyMigration extends SvrProcess {

	// Process to help verifying after a migration, check if customizations were
	// overwritten

	/* Date To */
	private Timestamp p_DateTo = null;
	/* SeqNo to insert into AD_VerifyMigration stepping 10 */
	private int m_SeqNo = 0;
	/* Counter of records inserted in AD_VerifyMigration */
	int m_cnt = 0;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "DateTo":
				p_DateTo = para.getParameterAsTimestamp();
				break;
			default:
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
				break;
			}
		}
	}

	@Override
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO))
			log.info("DateTo" + p_DateTo);

		verifyCustomizationsInChangeLog();

		verifyCustomViewColumns();

		addLog(getAD_PInstance_ID(), null, null, Msg.getElement(getCtx(), MPInstance.COLUMNNAME_AD_PInstance_ID) + " " + getAD_PInstance_ID(), MPInstance.Table_ID, getAD_PInstance_ID());
		return "@Inserted@ " + m_cnt;
	}

	/**
	 * @return number of records inserted in AD_VerifyMigration
	 */
	private void verifyCustomizationsInChangeLog() {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * ");
		sql.append("FROM   AD_ChangeLog cl ");
		sql.append("WHERE  cl.AD_Client_ID = 0 ");
		sql.append("       AND cl.AD_Table_ID<=").append(MTable.MAX_OFFICIAL_ID);
		sql.append("       AND cl.Record_ID<=").append(MTable.MAX_OFFICIAL_ID);
		sql.append("       AND cl.EventChangeLog = 'U' ");
		sql.append("       AND cl.AD_ChangeLog_ID = (SELECT MAX(clm.AD_ChangeLog_ID) ");
		sql.append("                                 FROM   AD_ChangeLog clm ");
		sql.append("                                 WHERE  cl.AD_Client_ID = clm.AD_Client_ID ");
		sql.append("                                        AND cl.AD_Table_ID = clm.AD_Table_ID ");
		sql.append("                                        AND cl.Record_ID = clm.Record_ID ");
		sql.append("                                        AND cl.AD_Column_ID = clm.AD_Column_ID ");
		sql.append("                                        AND cl.EventChangeLog = clm.EventChangeLog) ");
		sql.append("ORDER  BY cl.AD_Table_ID, ");
		sql.append("          cl.AD_Column_ID, ");
		sql.append("          cl.Record_ID");
		try (PreparedStatement pstmt = DB.prepareStatement(sql.toString(), get_TrxName())) {
			ResultSet rs = pstmt.executeQuery();
			// For each LAST customization change log record (changes to official records in official tables)
			while (rs.next()) {
				MChangeLog cl = new MChangeLog(getCtx(), rs, get_TrxName());
				MTable table = MTable.get(cl.getAD_Table_ID());
				MColumn column = MColumn.get(cl.getAD_Column_ID());
				if (!column.isAllowLogging() || !table.isChangeLog())
					continue; // do not process as the table or column was marked as not logging
				String tabcol = table.getTableName() + "." + column.getColumnName();
				MUser user = MUser.get(cl.getCreatedBy());
				PO po = table.getPO(cl.getRecord_ID(), get_TrxName());
				if (po == null) {
					// the customized record does not exist in the database
					String msg = Msg.getMsg(getCtx(), "VM_CustomizedRecordDoesNotExist",
							// A customized record does not exist in the database.  The column {0} was customized on {1,date,long} by {2} in record {3} that no longer exists
							new Object[] {
									tabcol,
									cl.getCreated(),
									user.getName(),
									cl.getRecord_ID()
							});
					addVerifyMigration(
							cl.getAD_Table_ID(),
							cl.getAD_Column_ID(),
							cl.getRecord_ID(),
							cl.getAD_ChangeLog_ID(),
							msg,
							null,
							null,
							MVerifyMigration.PRIORITYRULE_Medium);
					continue;
				}
				Object currentValue = po.get_Value(column.getColumnName());
				String expectedValue = cl.getNewValue();
				// Report if there is a difference between the actual value in the database and the value changed by customization
				if (   (currentValue == null && expectedValue != null)
					|| (currentValue != null && expectedValue == null)
					|| (currentValue != null && ! currentValue.toString().equals(expectedValue))) {
					if (! MVerifyMigration.isIgnored(cl.getAD_ChangeLog_ID(), cl.getAD_Table_ID(), cl.getAD_Column_ID(), cl.getRecord_ID(), get_TrxName())) {
						String msg = Msg.getMsg(getCtx(), "VM_ExpectedValueDiffersFromCurrentValue",
								// Expected Value differs from Current Value.  The column {0} in record {1} was customized on {2,date,long} by {3}
								new Object[] {
										tabcol,
										po.toString(),
										cl.getCreated(),
										user.getName()
								});
						addVerifyMigration(
								cl.getAD_Table_ID(),
								cl.getAD_Column_ID(),
								cl.getRecord_ID(),
								cl.getAD_ChangeLog_ID(),
								msg,
								currentValue,
								expectedValue,
								MVerifyMigration.PRIORITYRULE_High);
					}
				}
			}
		} catch (SQLException e) {
			throw new DBException(e, sql.toString());
		}
	}

	/**
	 * @return number of records inserted in AD_VerifyMigration
	 * @throws SQLException 
	 */
	private void verifyCustomViewColumns() throws SQLException {
		// custom view columns
		List<MViewColumn> viewColumns = new Query(getCtx(), MViewColumn.Table_Name, "EntityType!='D'", get_TrxName())
				.setOnlyActiveRecords(true)
				.list();
		for (MViewColumn viewColumn : viewColumns) {
			MViewComponent viewComponent = new MViewComponent(getCtx(), viewColumn.getAD_ViewComponent_ID(), get_TrxName());
			MTable table = MTable.get(viewComponent.getAD_Table_ID());
			//	Find Column in Database
			Connection conn = null;
			ResultSet rs = null;
			try {
				conn = DB.getConnection();
				DatabaseMetaData md = conn.getMetaData();
				String catalog = DB.getDatabase().getCatalog();
				String schema = DB.getDatabase().getSchema();
				String tableName = table.getTableName();
				if (md.storesUpperCaseIdentifiers()) {
					tableName = tableName.toUpperCase();
				} else if (md.storesLowerCaseIdentifiers()) {
					tableName = tableName.toLowerCase();
				}
				rs = md.getColumns(catalog, schema, tableName, null);
				boolean found = false;
				while (rs.next()) {
					String columnName = rs.getString ("COLUMN_NAME");
					if (!columnName.equalsIgnoreCase(viewColumn.getColumnName()))
						continue;
					found = true;
				}
				if (!found) {
					if (! MVerifyMigration.isIgnored(-1, MViewColumn.Table_ID, -1, viewColumn.getAD_ViewColumn_ID(), get_TrxName())) {
						String tabcol = table.getTableName() + "." + viewColumn.getColumnName();
						MUser user = MUser.get(viewColumn.getCreatedBy());
						String msg = Msg.getMsg(getCtx(), "VM_CustomViewColumnNotInDB",
								// Column View does not exist in database.  The custom view column {0} was created on {1,date,long} by {2}
								new Object[] {
										tabcol,
										viewColumn.getCreated(),
										user.getName()
								});
						addVerifyMigration(
								MViewColumn.Table_ID,
								-1,
								viewColumn.getAD_ViewColumn_ID(),
								-1,
								msg,
								null,
								null,
								MVerifyMigration.PRIORITYRULE_High);
					}
				}
			} finally {
				DB.close(rs);
				rs = null;
				if (conn != null) {
					try {
						conn.close();
					} catch (Exception e) {}
				}
			}
		}
	}

	/**
	 * Adds a record to verify migration
	 * @param tableId
	 * @param columnId
	 * @param recordId
	 * @param changeLogId
	 * @param msg
	 * @param currentValue
	 * @param expectedValue
	 * @param priorityRule
	 */
	private void addVerifyMigration(int tableId, int columnId, int recordId, int changeLogId, String msg,
			Object currentValue, String expectedValue, String priorityRule) {
		m_SeqNo += 10;
		MVerifyMigration vm = new MVerifyMigration(
				getCtx(),
				getAD_PInstance_ID(),
				tableId,
				columnId,
				recordId,
				changeLogId,
				msg,
				m_SeqNo,
				currentValue,
				expectedValue,
				priorityRule,
				get_TrxName());
		vm.saveEx();
		m_cnt++;
	}

}
