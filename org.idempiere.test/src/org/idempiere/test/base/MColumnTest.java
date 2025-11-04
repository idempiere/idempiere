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
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Tests for {@link MColumn} class.
 * @author d-ruiz
 */
public class MColumnTest extends AbstractTestCase {

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
		assertTrue(Util.isEmpty(column.getColumnSQL(true, true)), "Empty SQL should return null");
		
		// Test regular SQL (not starting with @SQL= or @SQLFIND=)
		String regularSQL = "(SELECT something FROM somewhere)";
		column.setColumnSQL(regularSQL);
		assertEquals(regularSQL, column.getColumnSQL(true, true), "Regular SQL should return as is");
		assertEquals(regularSQL, column.getColumnSQL(false, false), "Regular SQL should return as is");
		
		// Test UI virtual column (@SQL=)
		String uiSQL = "@SQL=UI Formula";
		column.setColumnSQL(uiSQL);
		assertEquals("NULL", column.getColumnSQL(true, true), "UI SQL with nullForUI=true should return NULL");
		assertEquals("UI Formula", column.getColumnSQL(false, true), "UI SQL with nullForUI=false should return formula");
		
		// Test search virtual column (@SQLFIND=)
		String searchSQL = "@SQLFIND=Search Formula";
		column.setColumnSQL(searchSQL);
		assertEquals("NULL", column.getColumnSQL(true, true), "Search SQL with nullForSearch=true should return NULL");
		assertEquals("Search Formula", column.getColumnSQL(true, false), "Search SQL with nullForSearch=false should return formula");
		
		// Test edge cases
		column.setColumnSQL("@SQL=");
		assertEquals("NULL", column.getColumnSQL(true, true), "Empty UI SQL with nullForUI=true should return NULL");
		assertEquals("", column.getColumnSQL(false, true), "Empty UI SQL with nullForUI=false should return empty string");
		
		column.setColumnSQL("@SQLFIND=");
		assertEquals("NULL", column.getColumnSQL(true, true), "Empty search SQL with nullForSearch=true should return NULL");
		assertEquals("", column.getColumnSQL(true, false), "Empty search SQL with nullForSearch=false should return empty string");
	}

}