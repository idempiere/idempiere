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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
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
		MColumn column = MColumn.get(14102); // UPC/EAN
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

}
