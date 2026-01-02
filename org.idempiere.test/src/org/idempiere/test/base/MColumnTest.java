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
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNotSame;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MCtxHelpSuggestion;
import org.compiere.model.MLanguage;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProject;
import org.compiere.model.MTable;
import org.compiere.model.MTest;
import org.compiere.model.MTestUU;
import org.compiere.model.MUser;
import org.compiere.model.M_Element;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_TestUUDet;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestInstance;

/**
 * Tests for {@link MColumn} class.
 * @author d-ruiz
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MColumnTest extends AbstractTestCase {

	private final int testColumnId = DictionaryIDs.AD_Column.TEST_NAME.id;
	private String testColumnUUID;
	
	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		//System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, 
				new Timestamp(System.currentTimeMillis()), Language.getLanguage("en_US"));
	}
	
	/**
	 * Fetch stable AD_Column UUID from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testColumnUUID = DB.getSQLValueString(null, "SELECT AD_Column_UU FROM AD_Column WHERE AD_Column_ID=?", testColumnId);
		assertNotNull(testColumnUUID, "AD_Column_UU should be present for the test column");
	}
	
	/**
	 * Test the UUID-based constructor: MColumn(Properties ctx, String AD_Table_UU,
	 * String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		MColumn colByUUID = new MColumn(Env.getCtx(), testColumnUUID, getTrxName());
		assertNotNull(colByUUID, "MColumn constructed by UUID should not be null");
		assertEquals(testColumnId, colByUUID.getAD_Column_ID(), "MColumn loaded by UUID should map to same AD_Column_ID");
	}

	/**
	 * Test the ResultSet-based constructor: MColumn(Properties ctx, ResultSet rs,
	 * String trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Column WHERE AD_Column_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testColumnId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Column");

			MColumn colFromRs = new MColumn(Env.getCtx(), rs, getTrxName());
			assertNotNull(colFromRs, "MColumn constructed from ResultSet should not be null");
			assertEquals(testColumnId, colFromRs.getAD_Column_ID(), "MColumn(ResultSet) must have expected AD_Column_ID");
		} finally {
			DB.close(rs, pstmt);
		}
	}
	
	/**
	 * Test getting MColumn from cache by ID
	 */
	@Test
	public void testGetById() {
		// Get AD_Client.AD_Client_ID column
		int AD_Column_ID = MColumn.getColumn_ID("AD_Client", "AD_Client_ID");
		assertTrue(AD_Column_ID > 0, "Column ID should exist");
		
		MColumn column = MColumn.get(Env.getCtx(), AD_Column_ID);
		
		assertNotNull(column, "Column should not be null");
		assertEquals(AD_Column_ID, column.getAD_Column_ID(), "Column ID should match");
		assertEquals("AD_Client_ID", column.getColumnName(), "Column name should be AD_Client_ID");
	}
	
	/**
	 * Test getting MColumn by table name and column name
	 */
	@Test
	public void testGetByTableAndColumnName() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		
		assertNotNull(column, "Column should not be null");
		assertEquals("AD_Client_ID", column.getColumnName(), "Column name should match");
		assertEquals("AD_Client", column.getAD_Table().getTableName(), "Table name should match");
	}
	
	/**
	 * Test getting column name by ID
	 */
	@Test
	public void testGetColumnName() {
		int AD_Column_ID = MColumn.getColumn_ID("AD_Client", "AD_Client_ID");
		String columnName = MColumn.getColumnName(Env.getCtx(), AD_Column_ID);
		
		assertNotNull(columnName, "Column name should not be null");
		assertEquals("AD_Client_ID", columnName, "Column name should be AD_Client_ID");
		
		columnName = MColumn.getColumnName(Env.getCtx(), 0, getTrxName());
		assertNull(columnName, "Column name should be null when AD_Column_ID=0");
	}
	
	/**
	 * Test isStandardColumn method
	 */
	@Test
	public void testIsStandardColumn() {
		// Test standard columns
		MColumn adClientColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		assertTrue(adClientColumn.isStandardColumn(), "AD_Client_ID should be a standard column");
		
		MColumn adOrgColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Org_ID");
		assertTrue(adOrgColumn.isStandardColumn(), "AD_Org_ID should be a standard column");
		
		MColumn isActiveColumn = MColumn.get(Env.getCtx(), "AD_Client", "IsActive");
		assertTrue(isActiveColumn.isStandardColumn(), "IsActive should be a standard column");
		
		MColumn createdColumn = MColumn.get(Env.getCtx(), "AD_Client", "Created");
		assertTrue(createdColumn.isStandardColumn(), "Created should be a standard column");
		
		MColumn createdByColumn = MColumn.get(Env.getCtx(), "AD_Client", "CreatedBy");
		assertTrue(createdByColumn.isStandardColumn(), "CreatedBy should be a standard column");
		
		MColumn updatedColumn = MColumn.get(Env.getCtx(), "AD_Client", "Updated");
		assertTrue(updatedColumn.isStandardColumn(), "Updated should be a standard column");
		
		MColumn updatedByColumn = MColumn.get(Env.getCtx(), "AD_Client", "UpdatedBy");
		assertTrue(updatedByColumn.isStandardColumn(), "UpdatedBy should be a standard column");
		
		// Test non-standard column
		MColumn nameColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertFalse(nameColumn.isStandardColumn(), "Name should not be a standard column");
	}
	
	/**
	 * Test isUUIDColumn method
	 */
	@Test
	public void testIsUUIDColumn() {
		// Test UUID column
		MColumn uuColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_UU");
		assertTrue(uuColumn.isUUIDColumn(), "AD_Client_UU should be a UUID column");
		
		// Test non-UUID column
		MColumn idColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		assertFalse(idColumn.isUUIDColumn(), "AD_Client_ID should not be a UUID column");
	}
	
	/**
	 * Test isVirtualColumn method
	 */
	@Test
	public void testIsVirtualColumn() {
		// Most columns are not virtual
		MColumn normalColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertFalse(normalColumn.isVirtualColumn(), "Name column should not be virtual");
		
		// Virtual columns have ColumnSQL defined
		MColumn column = MColumn.get(DictionaryIDs.AD_Column.VIRTUALCOLUMN_UPCEAN.id);
		assertTrue(column.isVirtualColumn(), "Column with ColumnSQL should be virtual");
	}
	
	/**
	 * Test isKey method
	 */
	@Test
	public void testIsKey() {
		// Test key column
		MColumn keyColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		assertTrue(keyColumn.isKey(), "AD_Client_ID should be a key column");
		
		// Test non-key column
		MColumn nonKeyColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertFalse(nonKeyColumn.isKey(), "Name should not be a key column");
	}
	
	/**
	 * Test isParent method
	 */
	@Test
	public void testIsParent() {
		// Test parent column - AD_Table_ID in AD_Column is a parent
		MColumn parentColumn = MColumn.get(Env.getCtx(), "AD_Column", "AD_Table_ID");
		assertTrue(parentColumn.isParent(), "AD_Table_ID should be a parent column");
		
		// Test non-parent column
		MColumn nonParentColumn = MColumn.get(Env.getCtx(), "AD_Column", "Name");
		assertFalse(nonParentColumn.isParent(), "Name should not be a parent column");
	}
	
	/**
	 * Test isIdentifier method
	 */
	@Test
	public void testIsIdentifier() {
		// Test identifier column - Name in AD_Client is an identifier
		MColumn identifierColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertTrue(identifierColumn.isIdentifier(), "Name should be an identifier column");
		
		// Test non-identifier column
		MColumn nonIdentifierColumn = MColumn.get(Env.getCtx(), "AD_Client", "Description");
		assertFalse(nonIdentifierColumn.isIdentifier(), "Description should not be an identifier column");
	}
	
	/**
	 * Test isTranslated method
	 */
	@Test
	public void testIsTranslated() {
		// Test translated column - Name in many tables is translated
		MColumn nameColumn = MColumn.get(Env.getCtx(), "AD_Element", "Name");
		assertTrue(nameColumn.isTranslated(), "AD_Element.Name should be translated");
		
		// Test non-translated column
		MColumn nonTranslatedColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		assertFalse(nonTranslatedColumn.isTranslated(), "AD_Client_ID should not be translated");
	}
	
	/**
	 * Test isUpdateable method
	 */
	@Test
	public void testIsUpdateable() {
		// Test updateable column
		MColumn updateableColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertTrue(updateableColumn.isUpdateable(), "Name should be updateable");
		
		// Test non-updateable column (key columns are not updateable)
		MColumn keyColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		assertFalse(keyColumn.isUpdateable(), "Key column should not be updateable");
	}
	
	/**
	 * Test isMandatory method
	 */
	@Test
	public void testIsMandatory() {
		// Test mandatory column
		MColumn mandatoryColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertTrue(mandatoryColumn.isMandatory(), "Name should be mandatory");
		
		// Test non-mandatory column
		MColumn optionalColumn = MColumn.get(Env.getCtx(), "AD_Client", "Description");
		assertFalse(optionalColumn.isMandatory(), "Description should not be mandatory");
	}
	
	/**
	 * Test getSQLDataType method
	 */
	@Test
	public void testGetSQLDataType() {
		// Test String column
		MColumn stringColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		String sqlType = stringColumn.getSQLDataType();
		assertNotNull(sqlType, "SQL data type should not be null");
		assertTrue(sqlType.contains("VARCHAR") || sqlType.contains("CHAR"), 
				"String column should have VARCHAR/CHAR type");
		
		// Test ID column
		MColumn idColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		sqlType = idColumn.getSQLDataType();
		assertNotNull(sqlType, "SQL data type should not be null");
		assertTrue(sqlType.contains("NUMERIC") || sqlType.contains("NUMBER") || sqlType.contains("INTEGER"), 
				"ID column should have numeric type");
	}
	
	/**
	 * Test getCopy method
	 */
	@Test
	public void testGetCopy() {
		int AD_Column_ID = MColumn.getColumn_ID("AD_Client", "AD_Client_ID");
		MColumn originalColumn = MColumn.get(Env.getCtx(), AD_Column_ID);
		MColumn copiedColumn = MColumn.getCopy(Env.getCtx(), AD_Column_ID, getTrxName());
		
		assertNotNull(copiedColumn, "Copied column should not be null");
		assertEquals(originalColumn.getColumnName(), copiedColumn.getColumnName(), 
				"Column name should be the same");
		assertEquals(originalColumn.getAD_Table_ID(), copiedColumn.getAD_Table_ID(), 
				"Table ID should be the same");
		assertEquals(originalColumn.getAD_Reference_ID(), copiedColumn.getAD_Reference_ID(), 
				"Reference ID should be the same");
		
		MColumn anotherCopy = new MColumn(Env.getCtx(), copiedColumn);
		assertNotNull(anotherCopy, "Copy constructor should create a new instance");
		assertEquals(copiedColumn.getColumnName(), anotherCopy.getColumnName(), "Name of the second copy should also match");
	}
	
	/**
	 * Test toString method
	 */
	@Test
	public void testToString() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		String toString = column.toString();
		
		assertNotNull(toString, "toString should not return null");
		assertTrue(toString.contains("MColumn"), "toString should contain class name");
		assertTrue(toString.contains("AD_Client_ID"), "toString should contain column name");
	}
	
	/**
	 * Test getColumn_ID static method
	 */
	@Test
	public void testGetColumn_ID() {
		int columnId = MColumn.getColumn_ID("AD_Client", "AD_Client_ID");
		assertTrue(columnId > 0, "Column ID should be greater than 0");
		
		// Verify by loading the column
		MColumn column = MColumn.get(Env.getCtx(), columnId);
		assertEquals("AD_Client_ID", column.getColumnName(), "Column name should match");
		
		// Non-existing table
		columnId = MColumn.getColumn_ID("NonExistentTable", MTest.COLUMNNAME_Name);
		assertEquals(0, columnId, "Expected 0 for non-existing table");
		
		// Existing table, non-existing column
		columnId = MColumn.getColumn_ID(MTest.Table_Name, "NonExistentColumn");
		assertEquals(0, columnId, "Expected 0 for non-existing column");
	}
	
	/**
	 * Test column with invalid table name
	 */
	@Test
	public void testGetWithInvalidTable() {
		MColumn column = MColumn.get(Env.getCtx(), "INVALID_TABLE_NAME", "ColumnName");
		assertNull(column, "Column should be null for invalid table name");
		
		column = MColumn.get(Env.getCtx(), "INVALID_TABLE_NAME", "ColumnName", getTrxName());
		assertNull(column, "Column should be null for invalid table name");
	}
	
	/**
	 * Test display type specific behavior
	 */
	@Test
	public void testDisplayTypes() {
		// Test YesNo column
		MColumn yesNoColumn = MColumn.get(Env.getCtx(), "AD_Client", "IsActive");
		assertEquals(DisplayType.YesNo, yesNoColumn.getAD_Reference_ID(), 
				"IsActive should be YesNo type");
		
		// Test String column
		MColumn stringColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertEquals(DisplayType.String, stringColumn.getAD_Reference_ID(), 
				"Name should be String type");
	}
	
	/**
	 * Test constraint generation for key column
	 */
	@Test
	public void testGetConstraint() {
		MColumn keyColumn = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		MTable table = MTable.get(Env.getCtx(), "AD_Client");
		String constraint = keyColumn.getConstraint(table);
		
		assertNotNull(constraint, "Constraint should not be null for key column");
		assertTrue(constraint.contains("PRIMARY KEY"), "Key column constraint should contain PRIMARY KEY");
		assertTrue(constraint.contains("AD_Client_ID"), "Constraint should reference the column name");
		
		MColumn uuColumn = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_Test_UU);
		table = MTable.get(Env.getCtx(), MTest.Table_Name);
		constraint = uuColumn.getConstraint(table);
		
		assertNotNull(constraint, "Constraint should not be null for key column");
		assertTrue(constraint.contains("UNIQUE"), "Key column constraint should contain UNIQUE");
		assertTrue(constraint.contains(MTest.COLUMNNAME_Test_UU), "Constraint should reference the column name");
		
		keyColumn = MColumn.get(Env.getCtx(), MTestUU.Table_Name, MTestUU.COLUMNNAME_TestUU_UU);
		table = MTable.get(Env.getCtx(), MTestUU.Table_Name);
		constraint = keyColumn.getConstraint(table);
		
		assertNotNull(constraint, "Constraint should not be null for key column");
		assertTrue(constraint.contains(MTestUU.COLUMNNAME_TestUU_UU), "Constraint should reference the column name");
	}
	
	/**
	 * Test cache functionality
	 */
	@Test
	public void testCache() {
		int AD_Column_ID = MColumn.getColumn_ID("AD_Client", "AD_Client_ID");
		
		// First call - loads from database
		MColumn column1 = MColumn.get(Env.getCtx(), AD_Column_ID);
		assertNotNull(column1, "First call should return column");
		
		// Second call - should return from cache
		MColumn column2 = MColumn.get(Env.getCtx(), AD_Column_ID);
		assertNotNull(column2, "Second call should return column");
		
		// Both should have same data
		assertEquals(column1.getColumnName(), column2.getColumnName(), 
				"Cached column should have same data");
		
		MColumn invalidColumn = MColumn.get(Env.getCtx(), -1, getTrxName());
		assertNull(invalidColumn, "Invalid AD_Column_ID should return null");
	}
	
	/**
	 * Test column field length validation
	 */
	@Test
	public void testFieldLength() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		int fieldLength = column.getFieldLength();
		
		assertTrue(fieldLength > 0, "Field length should be greater than 0");
		assertTrue(fieldLength <= 2000, "Field length should be reasonable");
	}

	/**
	 * Test constructor with parent table
	 */
	@Test
	public void testConstructorWithParent() {
		MTable parentTable = MTable.get(Env.getCtx(), "AD_Client");
		MColumn column = new MColumn(parentTable);
		
		assertNotNull(column, "Column should not be null");
		assertEquals(parentTable.getAD_Table_ID(), column.getAD_Table_ID(), "Table ID should match parent");
		assertEquals(parentTable.getAD_Client_ID(), column.getAD_Client_ID(), "Client ID should match parent");
		assertEquals(parentTable.getAD_Org_ID(), column.getAD_Org_ID(), "Org ID should match parent");
		assertEquals(parentTable.getEntityType(), column.getEntityType(), "Entity Type should match parent");
	}

	/**
	 * Test virtual column types
	 */
	@Test
	public void testVirtualColumnTypes() {
		// Get a virtual column for testing
		MColumn virtualColumn = new MColumn(Env.getCtx(), DictionaryIDs.AD_Column.VIRTUALCOLUMN_UPCEAN.id, getTrxName());
		assertTrue(virtualColumn.isVirtualColumn(), "Column with ColumnSQL should be virtual");
		
		// Test database virtual column
		virtualColumn.setColumnSQL("(SELECT something FROM somewhere)");
		assertTrue(virtualColumn.isVirtualDBColumn(), "Column with DB SQL should be virtual DB column");
		assertFalse(virtualColumn.isVirtualUIColumn(), "DB virtual column should not be UI virtual");
		
		// Test UI virtual column
		virtualColumn.setColumnSQL("@SQL=UI Formula");
		assertTrue(virtualColumn.isVirtualUIColumn(), "Column with @SQL= prefix should be UI virtual");
		assertFalse(virtualColumn.isVirtualDBColumn(), "UI virtual column should not be DB virtual");
		
		// Test search virtual column
		virtualColumn.setColumnSQL("@SQLFIND=SearchFormula");
		assertTrue(virtualColumn.isVirtualSearchColumn(), "Column with @SEARCH= prefix should be search virtual");
		assertFalse(virtualColumn.isVirtualDBColumn(), "Search virtual column should not be DB virtual");
	}

	/**
	 * Test SQL DDL generation
	 */
	@Test
	public void testSQLDDL() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		String ddl = column.getSQLDDL();
		
		assertNotNull(ddl, "DDL should not be null");
		assertTrue(ddl.contains("Name"), "DDL should contain column name");
		assertTrue(ddl.contains("VARCHAR") || ddl.contains("NVARCHAR"), "DDL should contain correct data type");
		
		column = MColumn.get(Env.getCtx(), DictionaryIDs.AD_Column.VIRTUALCOLUMN_UPCEAN.id);
		assertNull(column.getSQLDDL(), "DDL should be null for virtual columns");
	}

	/**
	 * Test SQL ADD statement generation
	 */
	@Test
	public void testSQLAdd() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		MTable table = MTable.get(Env.getCtx(), "AD_Client");
		String addSql = column.getSQLAdd(table);
		
		assertNotNull(addSql, "ADD SQL should not be null");
		assertTrue(addSql.contains("ALTER TABLE"), "ADD SQL should be ALTER TABLE statement");
		assertTrue(addSql.contains("ADD"), "ADD SQL should contain ADD keyword");
		assertTrue(addSql.contains("Name"), "ADD SQL should contain column name");
	}

	/**
	 * Test constraint generation with table name
	 */
	@Test
	public void testGetConstraintWithTableName() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		String constraint = column.getConstraint("AD_Client");
		
		assertNotNull(constraint, "Constraint should not be null");
		assertTrue(constraint.contains("PRIMARY KEY"), "Constraint should be primary key");
		assertTrue(constraint.contains("AD_Client"), "Constraint should contain table name");
	}

	/**
	 * Test getting table ID from column ID
	 */
	@Test
	public void testGetTableID() {
		int columnId = MColumn.getColumn_ID("AD_Client", "AD_Client_ID");
		int tableId = MColumn.getTable_ID(Env.getCtx(), columnId, getTrxName());
		
		assertTrue(tableId > 0, "Table ID should be valid");
		MTable table = MTable.get(Env.getCtx(), tableId);
		assertEquals("AD_Client", table.getTableName(), "Table name should match");
	}

	/**
	 * Test suggestion selection column detection
	 */
	@Test
	public void testIsSuggestSelectionColumn() {
		// Test common suggestion columns
		assertTrue(MColumn.isSuggestSelectionColumn("Name", true), "Name should be suggestion column");
		assertTrue(MColumn.isSuggestSelectionColumn("Value", true), "Value should be suggestion column");
		assertTrue(MColumn.isSuggestSelectionColumn("DocumentNo", true), "DocumentNo should be suggestion column");
		
		// Test case sensitivity
		assertTrue(MColumn.isSuggestSelectionColumn("NAME", false), "NAME should match with case insensitive");
		assertFalse(MColumn.isSuggestSelectionColumn("NAME", true), "NAME should not match with case sensitive");
		
		// Null / Empty
		assertFalse(MColumn.isSuggestSelectionColumn(null, true), "Null should return false");
	    assertFalse(MColumn.isSuggestSelectionColumn("", true), "Empty string should return false");
	    assertFalse(MColumn.isSuggestSelectionColumn("   ", true), "Whitespace should return false");
	    
	    // contains "Name"
	    assertTrue(MColumn.isSuggestSelectionColumn("ContactName", true));
	    assertTrue(MColumn.isSuggestSelectionColumn("customername", false));
	    
	    // does not match
	    assertFalse(MColumn.isSuggestSelectionColumn("Created", true));
	    assertFalse(MColumn.isSuggestSelectionColumn("UpdatedBy", false));
	}

	/**
	 * Test multi-reference table name retrieval
	 */
	@Test
	public void testGetMultiReferenceTableName() {
		// Find a column with AD_Reference_Value_ID set
		MColumn column = MColumn.get(Env.getCtx(), DictionaryIDs.AD_Column.MULTISELECTCOLUMN_SCOPELIST.id);
		String tableName = column.getMultiReferenceTableName();
		
		assertNotNull(tableName, "Multi-reference table name should not be null");
		assertTrue(tableName.length() > 0, "Multi-reference table name should not be empty");
		
		column = MColumn.get(Env.getCtx(), X_TestUUDet.Table_Name, X_TestUUDet.COLUMNNAME_TestUU_UUs);
		tableName = column.getMultiReferenceTableName();
		
		assertNotNull(tableName, "Multi-reference table name should not be null");
		assertTrue(tableName.length() > 0, "Multi-reference table name should not be empty");
	}

	/**
	 * Test setting smart defaults
	 */
	@Test
	public void testSetSmartDefaults() {
		MTable table = MTable.get(Env.getCtx(), "AD_Client");
		MColumn column = new MColumn(table);
		column.setColumnName("Description");
		column.setSmartDefaults();
		
		assertTrue(column.getFieldLength() > 0, "Field length should be set");
		assertEquals(DisplayType.String, column.getAD_Reference_ID(), "Default reference should be String");
		
		MTable newTbl = new MTable(Env.getCtx(), 0, getTrxName());
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		try {
			newTbl.setTableName(tableName);
			newTbl.setName("Test MTable " + uniqueSuffix);
			boolean saved = newTbl.save();
			assertTrue(saved, "New AD_Table record should save when mandatory fields are provided");
			assertTrue(newTbl.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
			
			column = new MColumn(newTbl);
			column.setColumnName(tableName + "_UU");
			column.setSmartDefaults();
			assertTrue(column.getFieldLength() > 0, "Field length should be set");
			assertEquals(DisplayType.String, column.getAD_Reference_ID(), "Default reference should be String");
			assertEquals(column.getFieldLength(), 36, "Default field length should be 36");
			
			column = new MColumn(newTbl);
			column.setColumnName(tableName + "_ID");
			column.setSmartDefaults();
			assertTrue(column.getFieldLength() > 0, "Field length should be set");
			assertEquals(DisplayType.ID, column.getAD_Reference_ID(), "Default reference should be ID");
			assertEquals(column.getFieldLength(), 22, "Default field length should be 36");
			assertTrue(column.isKey(), "Default key should be true");
		} finally {
			rollback();
		}
	}

	/**
	 * Test advanced column flag
	 */
	@Test
	public void testIsAdvanced() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_Client", "AD_Client_ID");
		assertFalse(column.isAdvanced(), "Standard columns should not be advanced by default");
		
		// Test a column that is used in an advanced field
		column = MColumn.get(Env.getCtx(), DictionaryIDs.AD_Column.REPORT_VIEW_ORDERBYCLAUSE.id);
		assertTrue(column.isAdvanced(), "Column should be advanced when field is advanced");
	}

	/**
	 * Test column SQL generation with different conditions
	 */
	@Test
	public void testGetColumnSQL() {
		MColumn column = new MColumn(Env.getCtx(), 0, getTrxName());
		
		// Test null SQL
		assertNull(column.getColumnSQL(true, true), "Null SQL should return null");
		assertNull(column.getColumnSQL(false, false), "Null SQL should return null");
		
		// Test empty SQL
		column.setColumnSQL("");
		assertTrue(Util.isEmpty(column.getColumnSQL(true, true)), "Empty SQL should return null");
		assertTrue(Util.isEmpty(column.getColumnSQL(true, false)), "Empty SQL should return null");
		
		// Test regular SQL (not starting with @SQL= or @SQLFIND=)
		String regularSQL = "(SELECT something FROM somewhere)";
		column.setColumnSQL(regularSQL);
		assertEquals(regularSQL, column.getColumnSQL(true, true), "Regular SQL should return as is");
		assertEquals(regularSQL, column.getColumnSQL(false, false), "Regular SQL should return as is");
		
		// Test UI virtual column (@SQL=)
		String uiSQL = "@SQL=UI Formula";
		column.setColumnSQL(uiSQL);
		assertEquals("NULL", column.getColumnSQL(true), "UI SQL with nullForUI=true should return NULL");
		assertEquals("NULL", column.getColumnSQL(true, true), "UI SQL with nullForUI=true should return NULL");
		assertEquals("UI Formula", column.getColumnSQL(false), "UI SQL with nullForUI=false should return formula");
		assertEquals("UI Formula", column.getColumnSQL(false, true), "UI SQL with nullForUI=false should return formula");
		
		// Test search virtual column (@SQLFIND=)
		String searchSQL = "@SQLFIND=Search Formula";
		column.setColumnSQL(searchSQL);
		assertEquals("NULL", column.getColumnSQL(true, true), "Search SQL with nullForSearch=true should return NULL");
		assertEquals("Search Formula", column.getColumnSQL(true, false), "Search SQL with nullForSearch=false should return formula");
		
		// Test edge cases
		column.setColumnSQL("@SQL=");
		assertEquals("NULL", column.getColumnSQL(true), "Empty UI SQL with nullForUI=true should return NULL");
		assertEquals("NULL", column.getColumnSQL(true, true), "Empty UI SQL with nullForUI=true should return NULL");
		assertEquals("", column.getColumnSQL(false), "Empty UI SQL with nullForUI=false should return empty string");
		assertEquals("", column.getColumnSQL(false, true), "Empty UI SQL with nullForUI=false should return empty string");
		
		column.setColumnSQL("@SQLFIND=");
		assertEquals("NULL", column.getColumnSQL(true, true), "Empty search SQL with nullForSearch=true should return NULL");
		assertEquals("", column.getColumnSQL(true, false), "Empty search SQL with nullForSearch=false should return empty string");
	}
	
	/**
	 * Test getDefaultValue method
	 */
	@Test
	public void testDefaultValue() {
		MTable table = MTable.get(Env.getCtx(), "AD_User");
		MColumn col = table.getColumn("AD_Client_ID");
		assertNotNull(col, "Column 'AD_Client_ID' should exist");

		String defaultValue = col.getDefaultValue();
		assertTrue(defaultValue == null || defaultValue.startsWith("@"), "Default value should be null or start with '@'");
	}

	/**
	 * Test isEncrypted method
	 */
    @Test
	public void testIsEncrypted() {
		MColumn nonEncryptedColumn = MColumn.get(Env.getCtx(), "AD_Client", "Name");
		assertFalse(nonEncryptedColumn.isEncrypted(), "Name should not be encrypted");
	}
    
    /**
	 * Test SQL Modify generation
	 */
	@Test
	public void testSQLModify() {
		MColumn column = MColumn.get(Env.getCtx(), "AD_User", "Name");
		MTable table = MTable.get(Env.getCtx(), "AD_User");
		String modifySql = column.getSQLModify(table, true);

		assertNotNull(modifySql, "getSQLModify() should not be null");
		assertTrue(modifySql.length() > 0, "getSQLModify() should not be empty");
	}
	
	/**
     * Test static cache behaviour: MColumn.get(ctx, AD_Column_ID) should return the same immutable instance.
     */
    @Test
	public void testStaticCacheBehavior() {
		MColumn a = MColumn.get(Env.getCtx(), DictionaryIDs.AD_Column.TEST_NAME.id);
		MColumn b = MColumn.get(Env.getCtx(), DictionaryIDs.AD_Column.TEST_NAME.id);
		assertSame(a, b, "MColumn.get(ctx, id) should return the same cached immutable instance");
	}
	
	/**
     * Test mandatory field validation for new MColumn.
     */
    @Test
	public void testMandatoryValidation() {
		MColumn col = new MColumn(Env.getCtx(), 0, getTrxName());
		assertThrows(Exception.class, () -> {
			col.saveEx();
		}, "Should throw exception when without mandatory fields");
	}
    
    /**
     * Test creating persistent MColumn
     */
    @Test
	public void testCreatePersistentObjectAndCleanup() {
		MTable table = MTable.get(Env.getCtx(), MTest.Table_Name);
		MColumn col = new MColumn(Env.getCtx(), 0, getTrxName());
		M_Element elem = new M_Element(Env.getCtx(), 0, getTrxName());
		String uniqueColumnName = "TestColumnName_" + System.currentTimeMillis();
		try {
			elem.setColumnName(uniqueColumnName);
			elem.setName("Test Column");
			elem.setPrintName("Test Column");
			boolean saved = elem.save();
			assertTrue(saved, "New AD_Element should save when mandatory fields are provided");
			assertTrue(elem.get_ID() > 0, "Saved AD_Element must have assigned AD_Element_ID");

			col.setAD_Table_ID(table.getAD_Table_ID());
			col.setAD_Element_ID(elem.get_ID());
			col.setColumnName(uniqueColumnName);
			col.setName("Test Column");
			col.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
			col.setFieldLength(60);
			saved = col.save();
			assertTrue(saved, "New MColumn should save with mandatory fields");
			assertTrue(col.get_ID() > 0, "Saved MColumn must have assigned AD_Column_ID");
		} finally {
			rollback();
		}
	}

    /**
     * Tests for markImmutable()
     */
    @Test
	public void testMarkImmutable() {
		MColumn c = MColumn.get(Env.getCtx(), "AD_User", "Name");
		c.markImmutable();
		try {
			c.setIsActive(false);
		} catch (Exception e) {}
		assertTrue(c.isActive(), "Active after setIsActive should be true, no change");
	}
    
    /**
     * Tests for the MColumn.get(Properties, String, String, String) method.
     */
    @Test
    public void testGetColumn() {
        String trxName = getTrxName();
        String tableName = "NonExistentTable";
        String columnName = "NonExistentColumn";
        MColumn col = MColumn.get(Env.getCtx(), tableName, columnName, trxName);
        assertNull(col, "Should return null when table does not exist");
        
        tableName = MTest.Table_Name;
        col = MColumn.get(Env.getCtx(), tableName, columnName, trxName);
        assertNull(col, "Should return null when column does not exist in table");
        
        columnName = MTest.COLUMNNAME_Name;
        col = MColumn.get(Env.getCtx(), tableName, columnName, trxName);
        assertNotNull(col, "Should return MColumn when table and column exist");
        assertEquals(columnName, col.getColumnName(), "Returned column should match requested name");
    }
    
    /**
	 * Test the copy constructor {@link MColumn#MColumn(MColumn)} to ensure
	 * that all relevant field values are copied from the source MColumn
	 * instance and that the resulting object is a new persistent instance
	 * (ID = 0, not yet saved).
	 */
	@Test
	public void testCopyConstructor() {
	    try {	        
	    	MColumn source = new MColumn(Env.getCtx(), DictionaryIDs.AD_Column.TEST_NAME.id, getTrxName());
	        MColumn copy = new MColumn(source);
	        assertEquals(source.getColumnName(), copy.getColumnName(), "ColumnName must match");
	        assertEquals(source.getName(), copy.getName(), "Name must match");
	        assertEquals(source.getAD_Table_ID(), copy.getAD_Table_ID(), "AD_Table_ID must match");
	        assertEquals(source.getEntityType(), copy.getEntityType(), "EntityType must match");
	        assertEquals(source.isKey(), copy.isKey(), "isKey must match");
	        assertEquals(source.isUpdateable(), copy.isUpdateable(), "isUpdateable must match");
	        assertEquals(source.isMandatory(), copy.isMandatory(), "isMandatory must match");
	        assertNotSame(source, copy, "Copy must be a different instance");
	    } finally {
	        rollback();
	    }
	}

	/**
	 * Tests the MColumn constructor MColumn(Properties ctx, String AD_Column_UU, String trxName)
	 * Covers the behavior when AD_Column_UU is empty (defaults applied) and when it is set (load existing).
	 */
	@Test
	public void testConstructorWithAD_Column_UU() {
	    MColumn newColumn = null;
	    MColumn loadedColumn = null;
	    try {
	        // Empty AD_Column_UU
	        newColumn = new MColumn(Env.getCtx(), "", getTrxName());
	        assertEquals(0, newColumn.getAD_Column_ID(), "New column with empty UU should have ID 0");
	        assertTrue(newColumn.isUpdateable(), "setInitialDefaults should initialize isUpdateable");
	        assertFalse(newColumn.isAlwaysUpdateable(), "setInitialDefaults should initialize isAlwaysUpdateable");

	        // Valid AD_Column_UU
	        MColumn tempColumn = new MColumn(Env.getCtx(), 0, getTrxName());
	        tempColumn.setAD_Table_ID(MTest.Table_ID);
	        tempColumn.setColumnName("TestColumn_UU");
	        tempColumn.setName("UU Test Column");
	        tempColumn.setEntityType(MColumn.ENTITYTYPE_UserMaintained);
	        tempColumn.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_UUID);
	        tempColumn.setFieldLength(36);
	        assertTrue(tempColumn.save(), "Temp column must save to get AD_Column_UU");
	        
	        String uu = tempColumn.getAD_Column_UU();
	        loadedColumn = new MColumn(Env.getCtx(), uu, getTrxName());
	        assertEquals(tempColumn.getAD_Column_ID(), loadedColumn.getAD_Column_ID(), "Loaded column should match existing AD_Column_ID");
	        assertEquals(tempColumn.getColumnName(), loadedColumn.getColumnName(), "Loaded column name should match");
	    } finally {
	        rollback();
	    }
	}
	
	/**
     * Tests for beforeSave
     */
    @Test
    public void testBeforeSave() {
        try {
            Properties ctx = Env.getCtx();
            String trxName = getTrxName();
            
            MTable table = new MTable(ctx, 0, trxName);
            String uniqueSuffix = String.valueOf(System.currentTimeMillis());
    		String tableName = "T_" + uniqueSuffix;
    		table.setTableName(tableName);
    		table.setName("Test MTable " + uniqueSuffix);
    		assertTrue(table.save());

            // Invalid column name
            MColumn col1 = new MColumn(ctx, 0, trxName);
            col1.setColumnName("123Invalid");
            assertFalse(col1.save(), "Invalid column name should return false");

            // Numeric column default length
            MColumn col2 = new MColumn(ctx, 0, trxName);
            col2.setAD_Table_ID(table.getAD_Table_ID());
            col2.setColumnName("NumericColumn");
            col2.setName("NumericColumn");
            col2.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_INTEGER);
            col2.setFormatPattern("#,###");
            col2.setFieldLength(0);
            assertTrue(col2.save());
            assertEquals(14, col2.getFieldLength(), "Numeric column default length 14");

            // ValueMax < ValueMin
            MColumn col3 = new MColumn(ctx, 0, trxName);
            col3.setColumnName("MinMaxColumn");
            col3.setName("MinMaxColumn");
            col3.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_INTEGER);
            col3.setFieldLength(10);
            col3.setValueMin("10");
            col3.setValueMax("5");
            assertFalse(col3.save(), "ValueMax < ValueMin should fail");

            // Parent/Key column disables updateable
            MColumn col4 = new MColumn(ctx, 0, trxName);
            col4.setAD_Table_ID(table.getAD_Table_ID());
            col4.setColumnName("AD_User_ID");
            col4.setName("ParentColumn");
            col4.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_TABLEDIR);
            col4.setFieldLength(0);
            col4.setIsParent(true);
            col4.setIsUpdateable(true);
            col4.setIsAlwaysUpdateable(true);
            assertTrue(col4.save());
            assertFalse(col4.isUpdateable(), "Parent column updateable must be false");
            assertFalse(col4.isAlwaysUpdateable(), "Parent column always updateable must be false");

            // Virtual column resets flags
            MColumn col5 = new MColumn(ctx, 0, trxName);
            col5.setAD_Table_ID(table.getAD_Table_ID());
            col5.setColumnName("VirtualColumn");
            col5.setName("VirtualColumn");
            col5.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            col5.setFieldLength(60);
            col5.setColumnSQL("@SQL=SELECT 'Virtual Column' FROM dual;");
            col5.setIsMandatory(true);
            col5.setIsUpdateable(true);
            col5.setIsIdentifier(true);
            col5.setIsAllowCopy(true);
            assertTrue(col5.save());
            assertFalse(col5.isMandatory());
            assertFalse(col5.isUpdateable());
            assertFalse(col5.isIdentifier());
            assertFalse(col5.isAllowCopy());

            // UUID column name must end with _UU
            MColumn col6 = new MColumn(ctx, 0, trxName);
            col6.setAD_Table_ID(table.getAD_Table_ID());
            col6.setColumnName("UUIDColumn");
            col6.setName("UUIDColumn");
            col6.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_UUID);
            col6.setFieldLength(36);
            assertFalse(col6.save(), "UUID column must end with _UU");

            // YesNo column default value
            MColumn col7 = new MColumn(ctx, 0, trxName);
            col7.setAD_Table_ID(table.getAD_Table_ID());
            col7.setColumnName("IsActive");
            col7.setName("IsActive");
            col7.setAD_Element_ID(SystemIDs.ELEMENT_ISACTIVE);
            col7.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_YES_NO);
            col7.setFieldLength(1);
            assertTrue(col7.save());
            assertEquals("Y", col7.getDefaultValue());
            
            // JSON column field length
            MColumn col8 = new MColumn(ctx, 0, trxName);
            col8.setAD_Table_ID(table.getAD_Table_ID());
            col8.setColumnName("JsonData");
            col8.setName("JsonData");
            col8.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_JSON);
            col8.setFieldLength(100);
            assertTrue(col8.save());
            assertEquals(0, col8.getFieldLength(), "Field length should be 0");
            
            // Date column field length
            MColumn col9 = new MColumn(ctx, 0, trxName);
            col9.setAD_Table_ID(table.getAD_Table_ID());
            col9.setColumnName("DateTrx");
            col9.setName("DateTrx");
            col9.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_DATE);
            col9.setFormatPattern("dd/MM/yyyy");
            col9.setFieldLength(0);
            assertTrue(col9.save());
            assertEquals(7, col9.getFieldLength(), "Field length should be 7");
            
            // Name column disables encrypted
            MColumn col10 = new MColumn(ctx, 0, trxName);
            col10.setAD_Table_ID(table.getAD_Table_ID());
            col10.setColumnName("Name");
            col10.setName("Name");
            col10.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            col10.setFieldLength(60);
            col10.setIsEncrypted(true);
            assertTrue(col10.save());
            assertFalse(col10.isEncrypted(), "Name should not be encrypted");
            
            // Mandatory FieldLength
            MColumn col11 = new MColumn(ctx, 0, trxName);
            col11.setAD_Table_ID(table.getAD_Table_ID());
            col11.setColumnName("Name2");
            col11.setName("Name2");
            col11.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            assertFalse(col11.save());
            
            // Mandatory AD_Reference_Value_ID
            MColumn col12 = new MColumn(ctx, 0, trxName);
            col12.setAD_Table_ID(table.getAD_Table_ID());
            col12.setColumnName("AD_User_ID");
            col12.setName("AD_User_ID");
            col12.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_TABLE);
            assertFalse(col12.save());
            
            // Invalid numeric format
            MColumn col13 = new MColumn(ctx, 0, trxName);
            col13.setAD_Table_ID(table.getAD_Table_ID());
            col13.setColumnName("NumericColumn");
            col13.setName("NumericColumn");
            col13.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_INTEGER);
            col13.setFormatPattern("##.##.##");
            assertFalse(col13.save());
            
            // Invalid date format
            MColumn col14 = new MColumn(ctx, 0, trxName);
            col14.setAD_Table_ID(table.getAD_Table_ID());
            col14.setColumnName("Date");
            col14.setName("Date");
            col14.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_DATE);
            col14.setFormatPattern("bb-bb-bb");
            assertFalse(col14.save());
            
            // Password column disables encrypted
            MColumn col15 = new MColumn(ctx, 0, trxName);
            col15.setAD_Table_ID(table.getAD_Table_ID());
            col15.setColumnName("Password");
            col15.setName("Password");
            col15.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            col15.setFormatPattern("bb-bb-bb");
            col15.setFieldLength(30);
            col15.setIsEncrypted(true);
            col15.setIsSecure(true);
            col15.setIsAllowLogging(true);
            assertTrue(col15.save());
            assertTrue(col15.isEncrypted(), "Should be encrypted");
            assertFalse(col15.isAllowLogging(), "Should not be allowed logging");
            assertNull(col15.getFormatPattern(), "Format pattern should be null");
            
            // Invalid foreign key constraint name
            MColumn col16 = new MColumn(ctx, 0, trxName);
            col16.setAD_Table_ID(table.getAD_Table_ID());
            col16.setColumnName("C_Payment_ID");
            col16.setName("C_Payment_ID");
            col16.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_PAYMENT);
            col16.setFKConstraintName("Invalid FK Constraint");
            col16.setFieldLength(22);
            assertFalse(col16.save());
            
            // AD_Reference_Value_ID and AD_InfoWindow_ID for payment reference column
            col16.setFKConstraintName(null);
            col16.setAD_InfoWindow_ID(200005); // Payment Info Window
            assertTrue(col16.save());
            assertEquals(SystemIDs.REFERENCE_PAYMENTRULE, col16.getAD_Reference_Value_ID());
            assertEquals(0, col16.getAD_InfoWindow_ID());
            
            // Duplicate SeqNo for identifier column
            MColumn col17 = new MColumn(ctx, 0, trxName);
            col17.setAD_Table_ID(table.getAD_Table_ID());
            col17.setColumnName("Value");
            col17.setName("Value");
            col17.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            col17.setFieldLength(30);
            col17.setIsIdentifier(true);
            col17.setSeqNo(10);
            assertTrue(col17.save());
            
            MColumn col18 = new MColumn(ctx, 0, trxName);
            col18.setAD_Table_ID(table.getAD_Table_ID());
            col18.setColumnName("Key");
            col18.setName("Key");
            col18.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            col18.setFieldLength(30);
            col18.setIsIdentifier(true);
            col18.setSeqNo(10);
            assertFalse(col18.save());
            
            // Disallow having > 1 key column
            MColumn col19 = new MColumn(ctx, 0, trxName);
            col19.setAD_Table_ID(table.getAD_Table_ID());
            col19.setColumnName(table.getTableName()+"_ID");
            col19.setName(table.getName());
            col19.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_ID);
            col19.setFieldLength(22);
            col19.setIsKey(true);
            assertTrue(col19.save());
            
            MColumn col20 = new MColumn(ctx, 0, trxName);
            col20.setAD_Table_ID(table.getAD_Table_ID());
            col20.setColumnName(table.getTableName()+"_UU");
            col20.setName(table.getName());
            col20.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            col20.setFieldLength(22);
            col20.setIsKey(true);
            assertFalse(col20.save());
            
            // AD_Reference_ID for UUID column
            col20.setIsKey(false);
            assertTrue(col20.save());
            assertEquals(SystemIDs.REFERENCE_DATATYPE_UUID, col20.getAD_Reference_ID());
        } finally {
            rollback();
        }
    }
    
    /**
     * Tests for afterSave
     */
    @Test
	public void testAfterSave() {
    	MTable table = new MTable(Env.getCtx(), 0, getTrxName());
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		try {
			table.setTableName(tableName);
			table.setName("Test MTable " + uniqueSuffix);
			assertTrue(table.save(), "New AD_Table record should save when mandatory fields are provided");
			assertTrue(table.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
			
			MTable trlTable = new MTable(Env.getCtx(), 0, getTrxName());
			String trlTableName = table.getTableName() + "_Trl";
			trlTable.setTableName(trlTableName);
			trlTable.setName("Test MTable " + uniqueSuffix);
			assertTrue(trlTable.save(), "New AD_Table record should save when mandatory fields are provided");
			assertTrue(trlTable.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
			
			MColumn column = new MColumn(table);
			column.setColumnName("Name");
			column.setName("Name");
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
			column.setFieldLength(60);
			column.setIsTranslated(true);
			assertTrue(column.save());
			assertTrue(column.isTranslated(), "Translated should be true");
			
			assertNotNull(trlTable, "Translated table should not be null");
			
			MColumn trlColumn = MColumn.get(Env.getCtx(), trlTableName, column.getColumnName());
			assertNull(trlColumn, "Translated column should be null");
		} finally {
			rollback();
		}
	}
    
    /**
     * Tests for getReferenceTableName().
     */
    @Test
    public void testGetReferenceTableName() {
        // TableDir
        MColumn c1 = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_AD_Client_ID);
        assertEquals(MClient.Table_Name, c1.getReferenceTableName());

        // TableDirUU
        MColumn c2 = MColumn.get(Env.getCtx(), X_TestUUDet.Table_Name, X_TestUUDet.COLUMNNAME_TestUU_UU);
        assertEquals(MTestUU.Table_Name, c2.getReferenceTableName());

        // Search with no ref value
        MColumn c3 = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_M_Product_ID);
        assertEquals(MProduct.Table_Name, c3.getReferenceTableName());

        // Table reference (DB lookup)
        MColumn c4 = MColumn.get(Env.getCtx(), MClient.Table_Name, MClient.COLUMNNAME_AD_Language);
        assertEquals(MLanguage.Table_Name, c4.getReferenceTableName());

        // Multiple Selection
        MColumn c5 = MColumn.get(Env.getCtx(), X_TestUUDet.Table_Name, X_TestUUDet.COLUMNNAME_TestUU_UUs);
        assertEquals(MTestUU.Table_Name, c5.getReferenceTableName());

        // Button
        MColumn c6 = MColumn.get(Env.getCtx(), MBPartner.Table_Name, MBPartner.COLUMNNAME_AD_OrgBP_ID);
        assertEquals("AD_Org", c6.getReferenceTableName());

        MColumn c6b = MColumn.get(Env.getCtx(), MProject.Table_Name, MProject.COLUMNNAME_C_ProjectType_ID);
        assertEquals("C_ProjectType", c6b.getReferenceTableName());

        // List
        MColumn c7 = MColumn.get(Env.getCtx(), MUser.Table_Name, MUser.COLUMNNAME_NotificationType);
        assertEquals("AD_Ref_List", c7.getReferenceTableName());

        // Location
        MColumn c8 = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_C_Location_ID);
        assertEquals("C_Location", c8.getReferenceTableName());

        // Account
        MColumn c9 = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_Account_Acct);
        assertEquals("C_ValidCombination", c9.getReferenceTableName());

        // Locator
        MColumn c10 = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_M_Locator_ID);
        assertEquals("M_Locator", c10.getReferenceTableName());

        // PAttribute
        MColumn c11 = MColumn.get(Env.getCtx(), MOrderLine.Table_Name, MOrderLine.COLUMNNAME_M_AttributeSetInstance_ID);
        assertEquals("M_AttributeSetInstance", c11.getReferenceTableName());

        // Assignment
        MColumn c12 = MColumn.get(Env.getCtx(), MOrderLine.Table_Name, MOrderLine.COLUMNNAME_S_ResourceAssignment_ID);
        assertEquals("S_ResourceAssignment", c12.getReferenceTableName());

        // Image (not BinaryData)
        MColumn c13 = MColumn.get(Env.getCtx(), MUser.Table_Name, MUser.COLUMNNAME_AD_Image_ID);
        assertEquals("AD_Image", c13.getReferenceTableName());

        // Chart
        MColumn c14 = MColumn.get(Env.getCtx(), "C_SalesDashboard", "SalesVolume");
        assertEquals("AD_Chart", c14.getReferenceTableName());

        // AD_AllClients_V
        MColumn c15 = MColumn.get(Env.getCtx(), MCtxHelpSuggestion.Table_Name, MCtxHelpSuggestion.COLUMNNAME_AD_UserClient_ID);
        assertEquals("AD_Client", c15.getReferenceTableName());

        // AD_AllUsers_V
        MColumn c16 = MColumn.get(Env.getCtx(), MCtxHelpSuggestion.Table_Name, MCtxHelpSuggestion.COLUMNNAME_AD_User_ID);
        assertEquals("AD_User", c16.getReferenceTableName());
    }
    
    /**
	 * Test Copy Columns from Table process, Synchronize Column process and change DB column name
	 */
	@Test
	public void testColumnRelatedProcesses() {
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		List<PO> created = new ArrayList<>();
		try {
			MTable table = new MTable(Env.getCtx(), 0, getTrxName());
			table.setTableName(tableName);
			table.setName("Test MTable " + uniqueSuffix);
			assertTrue(table.save());
			created.add(table);
			
			// Copy Columns from Table
			MProcess process = MProcess.get(DictionaryIDs.AD_Process.AD_TABLE_COPY_COLUMNS_FROM_TABLE.id);
			MPInstance pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			MPInstancePara[] paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("AD_Table_ID")) {
					para.setP_Number(MTest.Table_ID);
					para.saveEx();
				}
			}
			ProcessInfo pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			table.load(getTrxName());
			MColumn[] columns = table.getColumns(false);
			assertNotNull(columns, "Columns should not be null");
			
			MColumn column = table.getColumn(MTest.COLUMNNAME_C_BPartner_ID);
			column.setFKConstraintType(MColumn.FKCONSTRAINTTYPE_Cascade);
			assertTrue(column.save());
			
			column = table.getColumn(MTest.COLUMNNAME_M_Product_ID);
			column.setFKConstraintType(null);
			assertTrue(column.save());
			
			column = new MColumn(table);
			column.setColumnName(MTestUU.COLUMNNAME_TestUU_UU);
			column.setName("Test");
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_TABLEDIR_UU);
			column.setFieldLength(36);
			column.setFKConstraintType(MColumn.FKCONSTRAINTTYPE_SetNull);
			assertTrue(column.save());
			
			M_Element element = new M_Element(Env.getCtx(), 0, getTrxName());
			String unique = "T_" + System.currentTimeMillis();
			String maxLengthColumnName = "MAX_OBJECT_NAME_LENGTH_012345_TestColumnName_" + unique + "_ID";
			element.setColumnName(maxLengthColumnName);
			element.setName("Test Element " + unique);
			element.setPrintName("Test Element " + unique);
			assertTrue(element.save());
			
			column = new MColumn(table);
			column.setColumnName(element.getColumnName());
			column.setName(element.getName());
			column.setAD_Element_ID(element.get_ID());
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_TABLE);
			column.setAD_Reference_Value_ID(SystemIDs.REFERENCE_AD_USER);
			column.setFieldLength(22);
			assertTrue(column.save());

			// Synchronize Column
			process = MProcess.get(DictionaryIDs.AD_Process.AD_COLUMN_SYNC.id);
			pinstance = new MPInstance(process, MColumn.Table_ID, column.get_ID(), column.get_UUID());
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			// Change DB column name
			String newColumnName = "NewTestColumnName_" + unique + "_ID";
			element.renameDBColumn(newColumnName, null);
			assertEquals(newColumnName, element.getColumnName(), "Element ColumnName must match");
			column.load(getTrxName());
			assertEquals(newColumnName, column.getColumnName(), "Column ColumnName must match");
			
			for(PO po : table.getColumns(true))				
				created.add(po);
			
			// Create a new UU-based table
			table = new MTable(Env.getCtx(), 0, getTrxName());
			table.setTableName(tableName+"0");
			table.setName("Test MTable " + uniqueSuffix);
			assertTrue(table.save());
			created.add(table);
			
			// Copy Columns from Table
			process = MProcess.get(DictionaryIDs.AD_Process.AD_TABLE_COPY_COLUMNS_FROM_TABLE.id);
			pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("AD_Table_ID")) {
					para.setP_Number(X_TestUUDet.Table_ID);
					para.saveEx();
				}
			}
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			table.load(getTrxName());
			columns = table.getColumns(false);
			assertNotNull(columns, "Columns should not be null");
			
			column = table.getColumn(PO.getUUIDColumnName(table.getTableName()));
			column.setIsKey(true);
			assertTrue(column.save());
			
			column = new MColumn(table);
			column.setColumnName(element.getColumnName());
			column.setName(element.getName());
			column.setAD_Element_ID(element.get_ID());
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_ID);
			column.setFieldLength(22);
			assertTrue(column.save());

			// Synchronize Column
			process = MProcess.get(DictionaryIDs.AD_Process.AD_COLUMN_SYNC.id);
			pinstance = new MPInstance(process, MColumn.Table_ID, column.get_ID(), column.get_UUID());
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_TABLE);
			column.setAD_Reference_Value_ID(SystemIDs.REFERENCE_AD_USER);
			column.setFieldLength(22);
			assertTrue(column.save());
			
			for(PO po : table.getColumns(true))				
				created.add(po);
			
			commit();
			
			// Create Foreign Key
			process = MProcess.get(DictionaryIDs.AD_Process.CREATE_FOREIGN_KEY.id);
			pinstance = new MPInstance(process, 0, 0, null);
			paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("AD_Table_ID")) {
					para.setP_Number(table.get_ID());
					para.saveEx();
				} else if (para.getParameterName().equals("AD_Column_ID")) {
					para.setP_Number(column.get_ID());
					para.saveEx();
				}
			}
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			column.load(getTrxName());
			assertNotNull(column.getFKConstraintName(), "FK constraint name should not be null");
		} finally {
			rollback();
			try {
				String sql = "DROP TABLE " + tableName;
				DB.executeUpdateEx(sql, null);				
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				String sql = "DROP TABLE " + tableName + "0";
				DB.executeUpdateEx(sql, null);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			try {
				Collections.reverse(created);
				for(PO po : created) {
					po.set_TrxName(null);
					po.deleteEx(true);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Test Copy Columns from Table process and Synchronize Column process
	 */
	@Test
	public void testColumnRelatedProcessesForUUTable() {
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		List<PO> created = new ArrayList<>();
		try {
			MTable table = new MTable(Env.getCtx(), 0, getTrxName());
			table.setTableName(tableName);
			table.setName("Test MTable " + uniqueSuffix);
			assertTrue(table.save());
			created.add(table);
			
			// Copy Columns from Table
			MProcess process = MProcess.get(DictionaryIDs.AD_Process.AD_TABLE_COPY_COLUMNS_FROM_TABLE.id);
			MPInstance pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			MPInstancePara[] paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("AD_Table_ID")) {
					para.setP_Number(MTestUU.Table_ID);
					para.saveEx();
				}
			}
			ProcessInfo pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			table.load(getTrxName());
			MColumn[] columns = table.getColumns(false);
			assertNotNull(columns, "Columns should not be null");
			
			MColumn column = table.getColumn(PO.getUUIDColumnName(table.getTableName()));
			column.setIsKey(true);
			assertTrue(column.save());
			
			M_Element element = new M_Element(Env.getCtx(), 0, getTrxName());
			String unique = "T_" + System.currentTimeMillis();
			String maxLengthColumnName = "MAX_OBJECT_NAME_LENGTH_012345_TestColumnName_" + unique + "_ID";
			element.setColumnName(maxLengthColumnName);
			element.setName("Test Element " + unique);
			element.setPrintName("Test Element " + unique);
			assertTrue(element.save());
			
			column = new MColumn(table);
			column.setColumnName(element.getColumnName());
			column.setName(element.getName());
			column.setAD_Element_ID(element.get_ID());
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_ID);
			column.setFieldLength(22);
			assertTrue(column.save());

			// Synchronize Column
			process = MProcess.get(DictionaryIDs.AD_Process.AD_COLUMN_SYNC.id);
			pinstance = new MPInstance(process, MColumn.Table_ID, column.get_ID(), column.get_UUID());
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_TABLE);
			column.setAD_Reference_Value_ID(SystemIDs.REFERENCE_AD_USER);
			column.setFieldLength(22);
			assertTrue(column.save());
			
			for(PO po : table.getColumns(true))				
				created.add(po);
			
			commit();
						
			// Create Foreign Key
			process = MProcess.get(DictionaryIDs.AD_Process.CREATE_FOREIGN_KEY.id);
			pinstance = new MPInstance(process, 0, 0, null);
			paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("AD_Table_ID")) {
					para.setP_Number(table.get_ID());
					para.saveEx();
				} else if (para.getParameterName().equals("AD_Column_ID")) {
					para.setP_Number(column.get_ID());
					para.saveEx();
				}
			}
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			column.load(getTrxName());
			assertNotNull(column.getFKConstraintName(), "FK constraint name should not be null");
			
			// Translation table
			table = new MTable(Env.getCtx(), 0, getTrxName());
			table.setTableName(tableName + "_Trl");
			table.setName("Test MTable " + uniqueSuffix + " Trl");
			assertTrue(table.save());
			
			// Copy Columns from Table
			process = MProcess.get(DictionaryIDs.AD_Process.AD_TABLE_COPY_COLUMNS_FROM_TABLE.id);
			pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("AD_Table_ID")) {
					para.setP_Number(200401); // TestUU_Trl
					para.saveEx();
				}
			}
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			table.load(getTrxName());
			columns = table.getColumns(false);
			assertNotNull(columns, "Columns should not be null");
			
			column = table.getColumn("TestUU_UU");
			assertTrue(column.delete(false, getTrxName()));
			
			column = new MColumn(table);
			column.setColumnName(tableName + "_UU");
			column.setName("Test MTable " + uniqueSuffix);
			column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_TABLEDIR_UU);
			column.setFieldLength(36);
			column.setIsParent(true);
			assertTrue(column.save());
			
			// Synchronize Column
			process = MProcess.get(DictionaryIDs.AD_Process.AD_COLUMN_SYNC.id);
			pinstance = new MPInstance(process, MColumn.Table_ID, column.get_ID(), column.get_UUID());
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			column.load(getTrxName());
			assertNotNull(column.getFKConstraintName(), "FK constraint name should not be null");
			
			// Sync column will commit in Oracle, so need to keep it for cleanup
			if (DB.isOracle()) {
				created.add(table);
				for(PO po : table.getColumns(true))				
					created.add(po);
			}
				
		} finally {
			rollback();
			try {
				String sql = "DROP TABLE " + tableName + (DB.isOracle() ? " CASCADE CONSTRAINTS" : " CASCADE");
				DB.executeUpdateEx(sql, null);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			// Sync column will commit in Oracle, so need to drop translation table explicitly
			if (DB.isOracle()) {
				try {
					String sql = "DROP TABLE " + tableName + "_Trl CASCADE CONSTRAINTS";
					DB.executeUpdateEx(sql, null);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			try {
				Collections.reverse(created);
				for(PO po : created) {
					po.set_TrxName(null);
					po.deleteEx(true);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}