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
 * - d-ruiz                                                            *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.POInfo;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;

/**
 * Tests for {@link POInfo} class.
 * @author d-ruiz
 */
@Execution(ExecutionMode.SAME_THREAD)
public class POInfoTest extends AbstractTestCase {
	
	/**
	 * Test POInfo factory method with valid table ID
	 */
	@Test
	public void testGetPOInfo() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		assertNotNull(info, "POInfo should not be null");
		assertEquals(AD_Table_ID, info.getAD_Table_ID(), "Table ID should match");
		assertEquals("AD_Client", info.getTableName(), "Table name should be AD_Client");
		assertTrue(info.getColumnCount() > 0, "Column count should be greater than 0");
	}
	
	/**
	 * Test POInfo factory method with transaction name
	 */
	@Test
	public void testGetPOInfoWithTrx() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID, getTrxName());
		
		assertNotNull(info, "POInfo should not be null");
		assertEquals(AD_Table_ID, info.getAD_Table_ID(), "Table ID should match");
		assertEquals("AD_Client", info.getTableName(), "Table name should be AD_Client");
	}
	
	/**
	 * Test getAD_Table_ID method
	 */
	@Test
	public void testGetAD_Table_ID() {
		int AD_Table_ID = MTable.getTable_ID("AD_Org");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		assertEquals(AD_Table_ID, info.getAD_Table_ID(), "Table ID should match");
	}
	
	/**
	 * Test getColumnCount method
	 */
	@Test
	public void testGetColumnCount() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int count = info.getColumnCount();
		assertTrue(count > 0, "Column count should be greater than 0");
		assertEquals(count, 33, "AD_Client should have 33 active columns"); 
	}
	
	/**
	 * Test hasKeyColumn method
	 */
	@Test
	public void testHasKeyColumn() {
		// Test table with key column
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		assertTrue(info.hasKeyColumn(), "AD_Client should have a key column");
		
		// Verify key column exists
		int keyIndex = info.getColumnIndex("AD_Client_ID");
		assertTrue(keyIndex >= 0, "Key column should be found");
		assertTrue(info.isKey(keyIndex), "Column should be identified as key");
		
		// Test table with no key column
		AD_Table_ID = MTable.getTable_ID("C_Tax_Acct");
		info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		assertFalse(info.hasKeyColumn(), "C_Tax_Acct should not have a key column");
	}
	
	/**
	 * Test getAccessLevel method
	 */
	@Test
	public void testGetAccessLevel() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		String accessLevel = info.getAccessLevel();
		assertNotNull(accessLevel, "Access level should not be null");
		// AD_Client has System access level (4)
		assertEquals(MTable.ACCESSLEVEL_SystemPlusClient, accessLevel, "AD_Client should have System + Client access level");
	}
	
	/**
	 * Test getColumnIndex by column name
	 */
	@Test
	public void testGetColumnIndexByName() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test existing column
		int index = info.getColumnIndex("Name");
		assertTrue(index >= 0, "Column Name should be found");
		assertEquals("Name", info.getColumnName(index), "Column name should match");
		
		// Test case insensitivity
		int index2 = info.getColumnIndex("name");
		assertEquals(index, index2, "Column search should be case insensitive");
		
		// Test non-existing column
		int badIndex = info.getColumnIndex("NonExistentColumn");
		assertEquals(-1, badIndex, "Non-existent column should return -1");
	}
	
	/**
	 * Test getColumnIndex by AD_Column_ID
	 */
	@Test
	public void testGetColumnIndexByID() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Get AD_Column_ID for Name column
		int AD_Column_ID = MColumn.getColumn_ID("AD_Client", "Name");
		assertTrue(AD_Column_ID > 0, "Column ID should exist");
		
		int index = info.getColumnIndex(AD_Column_ID);
		assertTrue(index >= 0, "Column should be found by ID");
		assertEquals("Name", info.getColumnName(index), "Column name should be Name");
		
		// Test non-existing column ID
		int badIndex = info.getColumnIndex(999999999);
		assertEquals(-1, badIndex, "Non-existent column ID should return -1");
	}
	
	/**
	 * Test getAD_Column_ID method
	 */
	@Test
	public void testGetAD_Column_ID() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int AD_Column_ID = info.getAD_Column_ID("Name");
		assertTrue(AD_Column_ID > 0, "Column ID should be found");
		
		// Verify it matches MColumn result
		int expectedID = MColumn.getColumn_ID("AD_Client", "Name");
		assertEquals(expectedID, AD_Column_ID, "Column ID should match");
		
		// Test case insensitivity
		int AD_Column_ID2 = info.getAD_Column_ID("name");
		assertEquals(AD_Column_ID, AD_Column_ID2, "Search should be case insensitive");
		
		// Test non-existing column
		int badID = info.getAD_Column_ID("NonExistentColumn");
		assertEquals(-1, badID, "Non-existent column should return -1");
	}
	
	/**
	 * Test getColumnName method
	 */
	@Test
	public void testGetColumnName() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int index = info.getColumnIndex("Name");
		String columnName = info.getColumnName(index);
		assertEquals("Name", columnName, "Column name should be Name");
		
		// Test invalid index
		String badName = info.getColumnName(-1);
		assertNull(badName, "Invalid index should return null");
		
		badName = info.getColumnName(999999);
		assertNull(badName, "Out of range index should return null");
	}
	
	/**
	 * Test getColumnSQL method
	 */
	@Test
	public void testGetColumnSQL() {
		int AD_Table_ID = MTable.getTable_ID("M_ProductionLine");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int index = info.getColumnIndex("Description");
		String columnSQL = info.getColumnSQL(index);
		assertEquals("Description", columnSQL, "Column SQL should return column name for non-virtual columns");
		
		//Virtual SQL Find Column
		index = info.getColumnIndex("ProductType");
		columnSQL = info.getColumnSQL(index);
		assertEquals("NULL AS ProductType", columnSQL, "Column SQL should return virtual column SQL as NULL for SQL Find or Virtual UI columns");
		
		// Test invalid index
		String badSQL = info.getColumnSQL(-1);
		assertNull(badSQL, "Invalid index should return null");
		
		//Regular virtual column
		AD_Table_ID = MTable.getTable_ID("M_Cost");
		info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		index = info.getColumnIndex("CostingMethod");
		columnSQL = info.getColumnSQL(index);
		assertTrue(columnSQL.contains("SELECT"), "Column SQL should return proper SQL for virtual columns");
		
	}
	
	/**
	 * Test isVirtualColumn method
	 */
	@Test
	public void testIsVirtualColumn() {
		int AD_Table_ID = MTable.getTable_ID("M_Cost");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int index = info.getColumnIndex("Description");
		assertFalse(info.isVirtualColumn(index), "Description column should not be virtual");
		
		index = info.getColumnIndex("CostingMethod");
		assertTrue(info.isVirtualColumn(index), "CostingMethod column should be virtual");
		
		// Test invalid index returns true (safe default)
		assertTrue(info.isVirtualColumn(-1), "Invalid index should return true");
		assertTrue(info.isVirtualColumn(999999), "Out of range index should return true");
	}
	
	/**
	 * Test isVirtualColumn method
	 */
	@Test
	public void testIsVirtualDBColumn() {
		int AD_Table_ID = MTable.getTable_ID("M_Cost");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int index = info.getColumnIndex("Description");
		assertFalse(info.isVirtualDBColumn(index), "Description column should not be virtual");
		
		index = info.getColumnIndex("CostingMethod");
		assertTrue(info.isVirtualDBColumn(index), "CostingMethod column should be virtual");
		
		// Test invalid index returns true (safe default)
		assertTrue(info.isVirtualDBColumn(-1), "Invalid index should return true");
		assertTrue(info.isVirtualDBColumn(999999), "Out of range index should return true");
		
		AD_Table_ID = MTable.getTable_ID("M_ProductionLine");
		info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		//Virtual SQL Find Column
		index = info.getColumnIndex("QtyAvailable");
		assertFalse(info.isVirtualDBColumn(index), "SQL Find column should not be virtual DB column");
	}
	
	/**
	 * Test getColumnLabel method
	 */
	@Test
	public void testGetColumnLabel() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int index = info.getColumnIndex("Name");
		String label = info.getColumnLabel(index);
		assertNotNull(label, "Column label should not be null");
		
		// Test invalid index
		String badLabel = info.getColumnLabel(-1);
		assertNull(badLabel, "Invalid index should return null");
	}
	
	/**
	 * Test getColumnDescription method
	 */
	@Test
	public void testGetColumnDescription() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int index = info.getColumnIndex("Name");
		// Description may be null or a string
		assertNotNull(info.getColumnDescription(index), "Name description column should exist");
		
		// Test invalid index
		String badDesc = info.getColumnDescription(-1);
		assertNull(badDesc, "Invalid index should return null");
	}
	
	/**
	 * Test getColumnClass method
	 */
	@Test
	public void testGetColumnClass() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test String column
		int nameIndex = info.getColumnIndex("Name");
		Class<?> nameClass = info.getColumnClass(nameIndex);
		assertEquals(String.class, nameClass, "Name column should be String class");
		
		// Test Integer/ID column
		int idIndex = info.getColumnIndex("AD_Client_ID");
		Class<?> idClass = info.getColumnClass(idIndex);
		assertEquals(Integer.class, idClass, "ID column should be Integer class");
		
		// Test Boolean column
		int activeIndex = info.getColumnIndex("IsActive");
		Class<?> activeClass = info.getColumnClass(activeIndex);
		assertEquals(Boolean.class, activeClass, "IsActive should be Boolean class");
		
		// Test invalid index
		Class<?> badClass = info.getColumnClass(-1);
		assertNull(badClass, "Invalid index should return null");
	}
	
	/**
	 * Test getColumnDisplayType method
	 */
	@Test
	public void testGetColumnDisplayType() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test String column
		int nameIndex = info.getColumnIndex("Name");
		int displayType = info.getColumnDisplayType(nameIndex);
		assertEquals(DisplayType.String, displayType, "Name should be String display type");
		
		// Test Boolean column
		int activeIndex = info.getColumnIndex("IsActive");
		displayType = info.getColumnDisplayType(activeIndex);
		assertEquals(DisplayType.YesNo, displayType, "Name should be YesNo display type");
		
		// Test invalid index returns String as default
		int badType = info.getColumnDisplayType(-1);
		assertEquals(DisplayType.String, badType, "Invalid index should return String display type");
	}
	
	/**
	 * Test getDefaultLogic method
	 */
	@Test
	public void testGetDefaultLogic() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int index = info.getColumnIndex("IsActive");
		assertEquals("Y", info.getDefaultLogic(index), "IsActive should have Y as default logic");
		
		index = info.getColumnIndex("AD_Client_ID");
		assertEquals("@#AD_Client_ID@", info.getDefaultLogic(index), "AD_Client_ID should have @#AD_Client_ID@ as default logic");
		
		// Test invalid index
		String badLogic = info.getDefaultLogic(-1);
		assertNull(badLogic, "Invalid index should return null");
	}
	
	/**
	 * Test isColumnMandatory method
	 */
	@Test
	public void testIsColumnMandatory() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		assertTrue(info.isColumnMandatory(nameIndex), "Name column should be mandatory");
		
		// Test invalid index
		assertFalse(info.isColumnMandatory(-1), "Invalid index should return false");
	}
	
	/**
	 * Test isColumnUpdateable method
	 */
	@Test
	public void testIsColumnUpdateable() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		assertTrue(info.isColumnUpdateable(nameIndex), "Name column should be updateable");
		
		nameIndex = info.getColumnIndex("AD_Client_ID");
		assertFalse(info.isColumnUpdateable(nameIndex), "AD_Client_ID column should not be updateable");
		
		// Test invalid index
		assertFalse(info.isColumnUpdateable(-1), "Invalid index should return false");
	}
	
	/**
	 * Test setColumnUpdateable method
	 */
	@Test
	public void testSetColumnUpdateable() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		boolean originalValue = info.isColumnUpdateable(nameIndex);
		
		// Change updateable status
		info.setColumnUpdateable(nameIndex, !originalValue);
		assertEquals(!originalValue, info.isColumnUpdateable(nameIndex), "Updateable status should be changed");
		
		// Restore original value
		info.setColumnUpdateable(nameIndex, originalValue);
		assertEquals(originalValue, info.isColumnUpdateable(nameIndex), "Updateable status should be restored");
	}
	
	/**
	 * Test setUpdateable method
	 */
	@Test
	public void testSetUpdateable() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Set all columns to not updateable
		info.setUpdateable(false);
		
		// Check a few columns
		int nameIndex = info.getColumnIndex("Name");
		assertFalse(info.isColumnUpdateable(nameIndex), "All columns should not be updateable");
		
		// Restore
		info.setUpdateable(true);
		assertTrue(info.isColumnUpdateable(nameIndex), "All columns should be updateable");
	}
	
	/**
	 * Test isKey method
	 */
	@Test
	public void testIsKey() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test key column
		int keyIndex = info.getColumnIndex("AD_Client_ID");
		assertTrue(info.isKey(keyIndex), "AD_Client_ID should be a key column");
		
		// Test non-key column
		int nameIndex = info.getColumnIndex("Name");
		assertFalse(info.isKey(nameIndex), "Name should not be a key column");
		
		// Test invalid index
		assertFalse(info.isKey(-1), "Invalid index should return false");
	}
	
	/**
	 * Test isColumnParent method
	 */
	@Test
	public void testIsColumnParent() {
		int AD_Table_ID = MTable.getTable_ID("C_InvoiceTax");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("IsTaxIncluded");
		assertFalse(info.isColumnParent(nameIndex), "IsTaxIncluded should not be a parent column");
		
		int invoiceIndex = info.getColumnIndex("C_Invoice_ID");
		assertTrue(info.isColumnParent(invoiceIndex), "C_Invoice_ID should be a parent column");
		
		int taxIndex = info.getColumnIndex("C_Tax_ID");
		assertTrue(info.isColumnParent(taxIndex), "C_Tax_ID should be a parent column");
		
		// Test invalid index
		assertFalse(info.isColumnParent(-1), "Invalid index should return false");
	}
	
	/**
	 * Test isColumnTranslated method
	 */
	@Test
	public void testIsColumnTranslated() {
		int AD_Table_ID = MTable.getTable_ID("M_Product");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		assertTrue(info.isColumnTranslated(nameIndex), "Name column should be translated");

		int productTypeIndex = info.getColumnIndex("ProductType");
		assertFalse(info.isColumnTranslated(productTypeIndex), "ProductType column should not be translated");
		
		// Test invalid index
		assertFalse(info.isColumnTranslated(-1), "Invalid index should return false");
	}
	
	/**
	 * Test isTranslated method
	 */
	@Test
	public void testIsTranslated() {
		// Test a table that is typically not translated
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		assertFalse(info.isTranslated(), "AD_Client table should not be translated");

		// Test a table that is typically translated
		AD_Table_ID = MTable.getTable_ID("M_Product");
		info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		assertTrue(info.isTranslated(), "M_Product table should be translated");
	}
	
	/**
	 * Test isEncrypted method
	 */
	@Test
	public void testIsEncrypted() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		assertFalse(info.isEncrypted(nameIndex), "Name column should not be encrypted");
		
		// Test invalid index
		assertFalse(info.isEncrypted(-1), "Invalid index should return false");
	}
	
	/**
	 * Test isAllowLogging method
	 */
	@Test
	public void testIsAllowLogging() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		assertTrue(info.isAllowLogging(nameIndex), "Name column should allow logging");
		
		int pwdIndex = info.getColumnIndex("RequestUserPW");
		assertFalse(info.isAllowLogging(pwdIndex), "RequestUserPW column should not allow logging");
		
		// Test invalid index
		assertFalse(info.isAllowLogging(-1), "Invalid index should return false");
	}
	
	/**
	 * Test isAllowCopy method
	 */
	@Test
	public void testIsAllowCopy() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		assertTrue(info.isAllowCopy(nameIndex), "Name column should allow copy");
		
		int createdByIndex = info.getColumnIndex("CreatedBy");
		assertFalse(info.isAllowCopy(createdByIndex), "CreatedBy column should not allow copy");		
		
		// Test invalid index
		assertFalse(info.isAllowCopy(-1), "Invalid index should return false");
	}
	
	/**
	 * Test getFieldLength method
	 */
	@Test
	public void testGetFieldLength() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test by index
		int nameIndex = info.getColumnIndex("Name");
		int fieldLength = info.getFieldLength(nameIndex);
		assertTrue(fieldLength > 0, "Name field length should be greater than 0");
		
		// Test by column name
		int fieldLength2 = info.getFieldLength("Name");
		assertEquals(fieldLength, fieldLength2, "Field length should match");
		
		// Test invalid index
		assertEquals(0, info.getFieldLength(-1), "Invalid index should return 0");
		
		// Test non-existent column name
		assertEquals(0, info.getFieldLength("NonExistentColumn"), "Non-existent column should return 0");
	}
	
	/**
	 * Test validate method with mandatory field
	 */
	@Test
	public void testValidateMandatory() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		if (info.isColumnMandatory(nameIndex)) {
			// Validate null value on mandatory field
			String error = info.validate(nameIndex, null);
			assertEquals("FillMandatory", error, "Null value on mandatory field should return FillMandatory");
			
			// Validate non-null value on mandatory field
			String error2 = info.validate(nameIndex, "Test Value");
			assertNull(error2, "Valid value on mandatory field should return null");
		}
	}
	
	/**
	 * Test validate method with numeric range
	 */
	@Test
	public void testValidateNumericRange() {
		int AD_Table_ID = MTable.getTable_ID("C_BP_Group");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);

		String error = info.validate(-1, 150);
		assertEquals("RangeError", error, "Invalid column index should return RangeError");
		
		int creditIndex = info.getColumnIndex("CreditWatchPercent");
		error = info.validate(creditIndex, null);
		assertNull(error, "validate should allow null for non-mandatory field");
		
		//Out of range value min
		error = info.validate(creditIndex, -2);
		assertTrue(error.startsWith("LessThanMinValue"), "Out of range value min should return LessThanMinValue");
		
		//Out of range value max
		error = info.validate(creditIndex, 150);
		assertTrue(error.startsWith("MoreThanMaxValue"), "Out of range value max should return MoreThanMaxValue");
	}
	
	/**
	 * Test buildSelect method
	 */
	@Test
	public void testBuildSelect() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		StringBuilder sql = info.buildSelect();
		assertNotNull(sql, "SQL should not be null");
		
		String sqlStr = sql.toString();
		assertTrue(sqlStr.startsWith("SELECT"), "SQL should start with SELECT");
		assertTrue(sqlStr.contains("FROM AD_Client"), "SQL should contain FROM AD_Client");
		assertTrue(sqlStr.contains("AD_Client_ID"), "SQL should contain AD_Client_ID");
		assertTrue(sqlStr.contains("Name"), "SQL should contain Name");
	}
	
	/**
	 * Test buildSelect method with fully qualified columns
	 */
	@Test
	public void testBuildSelectFullyQualified() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		StringBuilder sql = info.buildSelect(true, false);
		assertNotNull(sql, "SQL should not be null");
		
		String sqlStr = sql.toString();
		assertTrue(sqlStr.contains("AD_Client."), "Fully qualified SQL should contain table prefix");
	}
	
	/**
	 * Test buildSelect method with and without virtual columns
	 */
	@Test
	public void testBuildSelectVirtualColumns() {
		int AD_Table_ID = MTable.getTable_ID("M_Cost");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// With virtual columns
		StringBuilder sql = info.buildSelect(false, false);
		assertNotNull(sql, "SQL should not be null");
		String sqlStr = sql.toString();
		assertTrue(sqlStr.startsWith("SELECT"), "SQL should start with SELECT");
		assertTrue(sqlStr.contains("CostingMethod"), "SQL should contain virtual column CostingMethod");
		
		// Without virtual columns
		sql = info.buildSelect(false, true);
		assertNotNull(sql, "SQL should not be null");
		sqlStr = sql.toString();
		assertTrue(sqlStr.startsWith("SELECT"), "SQL should start with SELECT");
		assertFalse(sqlStr.contains("CostingMethod"), "SQL should not contain virtual column CostingMethod");
	}
	
	/**
	 * Test buildSelectForColumns method
	 */
	@Test
	public void testBuildSelectForColumns() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		String[] columns = new String[] {"AD_Client_ID", "Name"};
		StringBuilder sql = info.buildSelectForColumns(false, columns);
		assertNotNull(sql, "SQL should not be null");
		
		String sqlStr = sql.toString();
		assertTrue(sqlStr.startsWith("SELECT"), "SQL should start with SELECT");
		assertTrue(sqlStr.contains("AD_Client_ID"), "SQL should contain AD_Client_ID");
		assertTrue(sqlStr.contains("Name"), "SQL should contain Name");
		assertFalse(sqlStr.contains("Description"), "SQL should not contain Description");
	}
	
	/**
	 * Test toString method
	 */
	@Test
	public void testToString() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		String str = info.toString();
		assertNotNull(str, "toString should not return null");
		assertTrue(str.contains("AD_Client"), "toString should contain table name");
		assertTrue(str.contains("POInfo"), "toString should contain POInfo");
	}
	
	/**
	 * Test toString method with column index
	 */
	@Test
	public void testToStringWithIndex() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int nameIndex = info.getColumnIndex("Name");
		String str = info.toString(nameIndex);
		assertNotNull(str, "toString with index should not return null");
		assertTrue(str.contains("AD_Client"), "toString should contain table name");
		
		// Test invalid index
		String badStr = info.toString(-1);
		assertTrue(badStr.contains("InvalidColumnIndex"), "Invalid index should indicate error");
	}
	
	/**
	 * Test POInfo caching
	 */
	@Test
	public void testPOInfoCaching() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info1 = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		POInfo info2 = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Should return same cached instance
		assertTrue(info1 == info2, "POInfo should be cached and return same instance");
	}
	
	/**
	 * Test isSecure method
	 */
	@Test
	public void testIsSecure() {
		int AD_Table_ID = MTable.getTable_ID("AD_User");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test secure column (Password)
		int pwdIndex = info.getColumnIndex("Password");
		assertTrue(info.isSecure(pwdIndex), "Password column should be secure");
		
		// Test non-secure column
		int nameIndex = info.getColumnIndex("Name");
		assertFalse(info.isSecure(nameIndex), "Name column should not be secure");
		
		// Test invalid index
		assertFalse(info.isSecure(-1), "Invalid index should return false");
		assertFalse(info.isSecure(999999), "Out of range index should return false");
	}
	
	/**
	 * Test isColumnLookup method
	 */
	@Test
	public void testIsColumnLookup() {
		int AD_Table_ID = MTable.getTable_ID("AD_User");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test TableDir lookup column
		int clientIndex = info.getColumnIndex("AD_Client_ID");
		assertTrue(info.isColumnLookup(clientIndex), "AD_Client_ID should be a lookup column");
		
		// Test List lookup column
		int languageIndex = info.getColumnIndex("AD_Language");
		assertFalse(info.isColumnLookup(languageIndex), "AD_Language is String, not lookup");
		
		// Test non-lookup column (String)
		int nameIndex = info.getColumnIndex("Name");
		assertFalse(info.isColumnLookup(nameIndex), "Name should not be a lookup column");
		
		// Test invalid index
		assertFalse(info.isColumnLookup(-1), "Invalid index should return false");
		assertFalse(info.isColumnLookup(999999), "Out of range index should return false");
	}
	
	/**
	 * Test getColumnLookup method with TableDir reference
	 */
	@Test
	public void testGetColumnLookup_TableDir() {
		int AD_Table_ID = MTable.getTable_ID("AD_User");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test TableDir lookup (AD_Client_ID)
		int clientIndex = info.getColumnIndex("AD_Client_ID");
		assertTrue(info.isColumnLookup(clientIndex), "AD_Client_ID should be a lookup column");
		
		org.compiere.model.Lookup lookup = info.getColumnLookup(clientIndex);
		assertNotNull(lookup, "Lookup should not be null for TableDir column");
		
		// Verify lookup can retrieve values
		Object displayValue = lookup.get(GARDEN_WORLD_CLIENT);
		assertNotNull(displayValue, "Lookup should return display value for valid ID");
	}
	
	/**
	 * Test getColumnLookup method with Table reference
	 */
	@Test
	public void testGetColumnLookup_Table() {
		int AD_Table_ID = MTable.getTable_ID("AD_Column");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test Table reference lookup (AD_Reference_Value_ID - references AD_Reference table)
		int refValueIndex = info.getColumnIndex("AD_Reference_Value_ID");
		assertTrue(info.isColumnLookup(refValueIndex), "AD_Reference_Value_ID should be a lookup column");
		
		org.compiere.model.Lookup lookup = info.getColumnLookup(refValueIndex);
		assertNotNull(lookup, "Lookup should not be null for Table reference column");
	}
	
	/**
	 * Test getColumnLookup method with List reference
	 */
	@Test
	public void testGetColumnLookup_List() {
		int AD_Table_ID = MTable.getTable_ID("AD_Table");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test List lookup (AccessLevel)
		int accessLevelIndex = info.getColumnIndex("AccessLevel");
		assertTrue(info.isColumnLookup(accessLevelIndex), "AccessLevel should be a lookup column");
		
		org.compiere.model.Lookup lookup = info.getColumnLookup(accessLevelIndex);
		assertNotNull(lookup, "Lookup should not be null for List reference column");
		
		// Verify lookup can retrieve values
		Object displayValue = lookup.get("4");
		assertNotNull(displayValue, "Lookup should return display value for valid list value");
	}
	
	/**
	 * Test getColumnLookup method for non-lookup column
	 */
	@Test
	public void testGetColumnLookup_NonLookup() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test non-lookup column (String)
		int nameIndex = info.getColumnIndex("Name");
		assertFalse(info.isColumnLookup(nameIndex), "Name should not be a lookup column");
		
		org.compiere.model.Lookup lookup = info.getColumnLookup(nameIndex);
		assertNull(lookup, "Lookup should be null for non-lookup column");
	}
	
	/**
	 * Test getColumnLookup method with invalid index
	 */
	@Test
	public void testGetColumnLookup_InvalidIndex() {
		int AD_Table_ID = MTable.getTable_ID("AD_Client");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test invalid index
		org.compiere.model.Lookup lookup = info.getColumnLookup(-1);
		assertNull(lookup, "Lookup should be null for invalid index");
		
		lookup = info.getColumnLookup(999999);
		assertNull(lookup, "Lookup should be null for out of range index");
	}
	
	/**
	 * Test getColumnLookup with Search reference
	 */
	@Test
	public void testGetColumnLookup_Search() {
		int AD_Table_ID = MTable.getTable_ID("C_Order");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Test Search lookup (C_BPartner_ID uses Search reference)
		int bpartnerIndex = info.getColumnIndex("C_BPartner_ID");
		assertTrue(info.isColumnLookup(bpartnerIndex), "C_BPartner_ID should be a lookup column");
		
		org.compiere.model.Lookup lookup = info.getColumnLookup(bpartnerIndex);
		assertNotNull(lookup, "Lookup should not be null for Search reference column");
	}
	
	/**
	 * Test comprehensive virtual column scenarios
	 */
	@Test
	public void testVirtualColumnScenarios() {
		// Test with M_Cost table which has virtual columns
		int AD_Table_ID = MTable.getTable_ID("M_Cost");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		// Regular virtual DB column
		int costingMethodIndex = info.getColumnIndex("CostingMethod");
		if (costingMethodIndex >= 0) {
			assertTrue(info.isVirtualColumn(costingMethodIndex), "CostingMethod should be virtual");
			assertTrue(info.isVirtualDBColumn(costingMethodIndex), "CostingMethod should be virtual DB column");
			
			String columnSQL = info.getColumnSQL(costingMethodIndex);
			assertTrue(columnSQL.contains("CostingMethod"), "Column SQL should contain column name");
		}
		
		// Test with M_ProductionLine which has virtual search columns
		AD_Table_ID = MTable.getTable_ID("M_ProductionLine");
		info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		
		int qtyAvailableIndex = info.getColumnIndex("QtyAvailable");
		if (qtyAvailableIndex >= 0) {
			assertTrue(info.isVirtualColumn(qtyAvailableIndex), "QtyAvailable should be virtual");
			assertTrue(info.isVirtualSearchColumn(qtyAvailableIndex), "QtyAvailable should be virtual");
			assertFalse(info.isVirtualDBColumn(qtyAvailableIndex), "QtyAvailable should not be virtual DB");
		}
	}
	
	/**
	 * Test isChangeLog method
	 */
	@Test
	public void testIsChangeLog() {
		// Test table with change log enabled
		int AD_Table_ID = MTable.getTable_ID("AD_User");
		POInfo info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		assertTrue(info.isChangeLog(), "AD_User should have change log enabled");
		
		// Test table without change log
		AD_Table_ID = MTable.getTable_ID("M_Cost");
		info = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
		assertFalse(info.isChangeLog(), "Test table should not have change log enabled");
	}
}