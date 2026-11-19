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
 * - Diego Ruiz                                                        *
 **********************************************************************/
package org.idempiere.test.process;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assumptions.assumeTrue;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MColumn;
import org.compiere.model.MProcess;
import org.compiere.model.MTable;
import org.compiere.model.MViewColumn;
import org.compiere.model.MViewComponent;
import org.compiere.model.Query;
import org.compiere.process.DatabaseViewImport;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Tests for {@link DatabaseViewImport}: create the view components of a table from the view in the database
 */
@Isolated
public class DatabaseViewImportTest extends AbstractTestCase {

	private static final String VIEW_NAME = "Test_ViewImport_V";

	private static final String[] COLUMN_NAMES = {"C_BPartner_ID", "AD_Client_ID", "Name", "BPType", "SearchKey"};

	private static final String VIEW_SQL = "SELECT bp.C_BPartner_ID, bp.AD_Client_ID, bp.Name, 'C' AS BPType, COALESCE(bp.Value, 'a,b FROM x') AS SearchKey"
			+ " FROM C_BPartner bp"
			+ " WHERE bp.IsCustomer='Y'"
			+ " UNION ALL"
			+ " SELECT bp.C_BPartner_ID, bp.AD_Client_ID, bp.Name, 'V' AS BPType, COALESCE(bp.Value, '-') AS SearchKey"
			+ " FROM C_BPartner bp"
			+ " WHERE bp.IsVendor='Y'";

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// the process is System only: System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Create the view in the database. DDL can't be part of the test transaction (it is committed in Oracle).
	 */
	@BeforeEach
	public void createView() {
		DB.executeUpdateEx("CREATE OR REPLACE VIEW " + VIEW_NAME + " AS " + VIEW_SQL, null);
	}

	@AfterEach
	public void dropView() {
		// release the locks of the test transaction on the view, otherwise the drop waits forever
		rollback();
		DB.executeUpdateEx("DROP VIEW " + VIEW_NAME, null);
	}

	private MTable createTable(String tableName) {
		MTable table = new MTable(Env.getCtx(), 0, getTrxName());
		table.setTableName(tableName);
		table.setName(tableName);
		table.setIsView(true);
		table.setEntityType(MTable.ENTITYTYPE_UserMaintained);
		table.saveEx();
		return table;
	}

	@Test
	public void testImportView() throws Exception {
		MTable table = createTable(VIEW_NAME);
		DatabaseViewImport.importDatabaseView(Env.getCtx(), table, false, false, true, getTrxName(), null);

		MViewComponent[] components = table.getViewComponent(true);
		assertNotNull(components, "View components");
		assertEquals(2, components.length, "Number of view components");
		assertFalse(components[0].isUnionAll(), "First component has no union");
		assertTrue(components[1].isUnionAll(), "Second component is UNION ALL");
		assertEquals(10, components[0].getSeqNo());
		assertEquals(20, components[1].getSeqNo());
		assertEquals(VIEW_NAME + "-010", components[0].getName());
		assertEquals(MTable.ENTITYTYPE_UserMaintained, components[0].getEntityType(), "Entity type of the table");

		for (MViewComponent component : components) {
			assertFalse(component.isDistinct(), "Component is not distinct");
			assertTrue(component.getFromClause().toUpperCase().startsWith("FROM C_BPARTNER BP"), "From clause: " + component.getFromClause());
			assertTrue(component.getWhereClause().toUpperCase().startsWith("WHERE "), "Where clause: " + component.getWhereClause());
			assertTrue(component.getOtherClause() == null || component.getOtherClause().isEmpty(), "No other clause");

			MViewColumn[] columns = component.getColumns(true);
			assertEquals(COLUMN_NAMES.length, columns.length, "Number of view columns");
			for (int i = 0; i < COLUMN_NAMES.length; i++) {
				assertTrue(COLUMN_NAMES[i].equalsIgnoreCase(columns[i].getColumnName()), "Column " + i + ": " + columns[i].getColumnName());
				assertEquals((i + 1) * 10, columns[i].getSeqNo(), "Sequence of column " + COLUMN_NAMES[i]);
				assertFalse(columns[i].getColumnSQL().contains("::"), "Column SQL without cast: " + columns[i].getColumnSQL());
			}
			assertEquals("C_BPartner_ID", columns[0].getColumnName(), "Column name with the case of the dictionary element");
			assertTrue(columns[0].getColumnSQL().equalsIgnoreCase("bp.C_BPartner_ID"), "Column SQL: " + columns[0].getColumnSQL());
			assertTrue(columns[4].getColumnSQL().toUpperCase().startsWith("COALESCE("), "Column SQL: " + columns[4].getColumnSQL());
		}
		assertTrue(components[0].getWhereClause().toUpperCase().contains("ISCUSTOMER"), "Where clause: " + components[0].getWhereClause());
		assertTrue(components[1].getWhereClause().toUpperCase().contains("ISVENDOR"), "Where clause: " + components[1].getWhereClause());
		assertEquals("'C'", components[0].getColumns(false)[3].getColumnSQL(), "Literal without cast");
		assertEquals("'V'", components[1].getColumns(false)[3].getColumnSQL(), "Literal without cast");

		assertEquals(0, countColumns(table), "Dictionary columns are not created");

		// the select built from the view components must return the same as the view
		StringBuilder sql = new StringBuilder();
		MViewColumn[] firstColumns = components[0].getColumns(false);
		for (int i = 0; i < components.length; i++) {
			if (i > 0) {
				sql.append(" UNION ");
				if (components[i].isUnionAll())
					sql.append(" ALL ");
			}
			sql.append(components[i].getSelect(false, firstColumns));
		}
		int expected = DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM " + VIEW_NAME);
		int expectedVendors = DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM " + VIEW_NAME + " WHERE BPType='V'");
		assertNotEquals(0, expected, "Test view should return records");
		assertEquals(expected, DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM (" + sql + ") t"),
				"Select of view components should return the same records as the view");
		assertEquals(expectedVendors, DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM (" + sql + ") t WHERE BPType='V'"),
				"Select of view components should return the same vendors as the view");
	}

	@Test
	public void testExistingViewComponents() throws Exception {
		MTable table = createTable(VIEW_NAME);
		DatabaseViewImport.importDatabaseView(Env.getCtx(), table, false, false, true, getTrxName(), null);
		int firstId = table.getViewComponent(true)[0].getAD_ViewComponent_ID();

		assertThrows(AdempiereException.class,
				() -> DatabaseViewImport.importDatabaseView(Env.getCtx(), table, false, false, true, getTrxName(), null),
				"Should fail when the table has view components and they are not deleted");
		assertEquals(2, table.getViewComponent(true).length, "View components are not changed");

		DatabaseViewImport.importDatabaseView(Env.getCtx(), table, true, false, true, getTrxName(), null);
		MViewComponent[] components = table.getViewComponent(true);
		assertEquals(2, components.length, "View components are replaced, not added");
		assertNotEquals(firstId, components[0].getAD_ViewComponent_ID(), "View component is a new record");
		assertEquals(COLUMN_NAMES.length, components[0].getColumns(true).length, "Number of view columns");
		int oldColumns = new Query(Env.getCtx(), MViewColumn.Table_Name, "AD_ViewComponent_ID=?", getTrxName())
				.setParameters(firstId)
				.count();
		assertEquals(0, oldColumns, "View columns of the deleted component are deleted");
	}

	@Test
	public void testCreateColumns() throws Exception {
		MTable table = createTable(VIEW_NAME);
		DatabaseViewImport.importDatabaseView(Env.getCtx(), table, false, true, true, getTrxName(), null);

		assertEquals(2, table.getViewComponent(true).length, "Number of view components");
		assertEquals(COLUMN_NAMES.length, countColumns(table), "Dictionary columns are created");
		for (String columnName : COLUMN_NAMES) {
			int count = new Query(Env.getCtx(), MColumn.Table_Name, "AD_Table_ID=? AND UPPER(ColumnName)=?", getTrxName())
					.setParameters(table.getAD_Table_ID(), columnName.toUpperCase())
					.count();
			assertEquals(1, count, "Dictionary column " + columnName);
		}
	}

	@Test
	public void testRunProcess() {
		MTable table = createTable(VIEW_NAME);

		ProcessInfo pi = runProcess(table, false, true);
		assertFalse(pi.isError(), pi.getSummary());
		MViewComponent[] components = table.getViewComponent(true);
		assertEquals(2, components.length, "Number of view components");
		assertEquals(COLUMN_NAMES.length, components[0].getColumns(true).length, "Number of view columns");
		assertEquals(COLUMN_NAMES.length, countColumns(table), "Dictionary columns are created");

		pi = runProcess(table, false, false);
		assertTrue(pi.isError(), "Process should fail when the table has view components and DeleteOld=N");

		pi = runProcess(table, true, false);
		assertFalse(pi.isError(), pi.getSummary());
		assertEquals(2, table.getViewComponent(true).length, "View components are replaced, not added");
	}

	@Test
	public void testRunProcessRemoveCasts() {
		assumeTrue(DB.isPostgreSQL(), "PostgreSQL adds the casts to the view definition");
		MTable table = createTable(VIEW_NAME);

		ProcessInfo pi = runProcess(table, false, false, Boolean.FALSE);
		assertFalse(pi.isError(), pi.getSummary());
		MViewComponent component = table.getViewComponent(true)[0];
		assertTrue(component.getColumns(true)[3].getColumnSQL().contains("::"),
				"IsRemoveCasts=N keeps the cast: " + component.getColumns(true)[3].getColumnSQL());
		assertTrue(component.getWhereClause().contains("::"), "IsRemoveCasts=N keeps the cast: " + component.getWhereClause());

		pi = runProcess(table, true, false, null);
		assertFalse(pi.isError(), pi.getSummary());
		component = table.getViewComponent(true)[0];
		assertEquals("'C'", component.getColumns(true)[3].getColumnSQL(), "Casts are removed when the parameter is not passed");
		assertFalse(component.getWhereClause().contains("::"), "Casts are removed when the parameter is not passed: " + component.getWhereClause());
	}

	private ProcessInfo runProcess(MTable table, boolean deleteOld, boolean createColumns) {
		return runProcess(table, deleteOld, createColumns, Boolean.TRUE);
	}

	/**
	 * @param removeCasts value of IsRemoveCasts, null to not pass the parameter
	 */
	private ProcessInfo runProcess(MTable table, boolean deleteOld, boolean createColumns, Boolean removeCasts) {
		MProcess process = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.DATABASE_VIEW_IMPORT.id);
		ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID(), MTable.Table_ID, table.getAD_Table_ID());
		pi.setClassName(process.getClassname());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setTransactionName(getTrxName());
		List<ProcessInfoParameter> params = new ArrayList<ProcessInfoParameter>();
		params.add(new ProcessInfoParameter("DeleteOld", deleteOld ? "Y" : "N", null, null, null));
		params.add(new ProcessInfoParameter("IsCreateColumns", createColumns ? "Y" : "N", null, null, null));
		if (removeCasts != null)
			params.add(new ProcessInfoParameter("IsRemoveCasts", removeCasts ? "Y" : "N", null, null, null));
		pi.setParameter(params.toArray(new ProcessInfoParameter[0]));
		ServerProcessCtl.process(pi, getTrx(), false);
		return pi;
	}

	@Test
	public void testRemoveCasts() throws Exception {
		assumeTrue(DB.isPostgreSQL(), "PostgreSQL adds the casts to the view definition");
		String viewName = "Test_ViewImportCast_V";
		DB.executeUpdateEx("CREATE OR REPLACE VIEW " + viewName + " AS SELECT bp.C_BPartner_ID, bp.Name || 'x' AS NameX,"
				+ " CAST(NULL AS VARCHAR(10)) AS Note FROM C_BPartner bp WHERE bp.IsCustomer='Y'", null);
		try {
			MTable table = createTable(viewName);
			ProcessInfo pi = new ProcessInfo("Test", 0);
			DatabaseViewImport.importDatabaseView(Env.getCtx(), table, false, false, true, getTrxName(), pi);
			MViewComponent component = table.getViewComponent(true)[0];
			assertFalse(component.getWhereClause().contains("::"), "Where clause without cast: " + component.getWhereClause());
			MViewColumn[] columns = component.getColumns(true);
			for (MViewColumn column : columns)
				assertFalse(column.getColumnSQL().contains("::"), "Column SQL without cast: " + column.getColumnSQL());
			assertEquals("NULL", columns[2].getColumnSQL(), "Typed NULL");
			assertEquals(MViewColumn.DBDATATYPE_CharacterVariable, columns[2].getDBDataType(), "Data type of the typed NULL");
			boolean logged = false;
			for (ProcessInfoLog log : pi.getLogs())
				logged = logged || (log.getP_Msg() != null && log.getP_Msg().startsWith(component.getName() + ": "));
			assertTrue(logged, "Removed casts are logged");

			DatabaseViewImport.importDatabaseView(Env.getCtx(), table, true, false, false, getTrxName(), null);
			component = table.getViewComponent(true)[0];
			assertTrue(component.getWhereClause().contains("::"), "Where clause keeps the cast: " + component.getWhereClause());
			columns = component.getColumns(true);
			assertTrue(columns[2].getColumnSQL().toUpperCase().startsWith("NULL::"), "Typed NULL is kept: " + columns[2].getColumnSQL());
			assertNull(columns[2].getDBDataType(), "No data type when the cast is kept");
		} finally {
			rollback();
			DB.executeUpdateEx("DROP VIEW " + viewName, null);
		}
	}

	@Test
	public void testViewNotInDatabase() {
		MTable table = createTable("Test_ViewImportNone_V");
		assertThrows(AdempiereException.class,
				() -> DatabaseViewImport.importDatabaseView(Env.getCtx(), table, false, false, true, getTrxName(), null),
				"Should fail when the view doesn't exist in the database");
		assertEquals(0, table.getViewComponent(true).length, "No view components are created");
	}

	private int countColumns(MTable table) {
		return new Query(Env.getCtx(), MColumn.Table_Name, "AD_Table_ID=?", getTrxName())
				.setParameters(table.getAD_Table_ID())
				.count();
	}
}
