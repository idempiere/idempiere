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

import org.compiere.db.AdempiereDatabase;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MTable;
import org.compiere.model.MTableIndex;
import org.compiere.model.MTablePartition;
import org.compiere.model.MTest;
import org.compiere.model.MTestUU;
import org.compiere.model.MUser;
import org.compiere.model.MViewComponent;
import org.compiere.model.PO;
import org.compiere.model.X_AD_TablePartition;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.idempiere.webservices.model.MWebService;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestInstance;

/**
 * Comprehensive JUnit 5 tests for {@link MTable}.
 * 
 * @author etantg
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MTableTest extends AbstractTestCase {

	private Properties ctx = Env.getCtx();
	private final String testTableName = MUser.Table_Name;
	private final int testTableId = MUser.Table_ID;
	private String testTableUUID;

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Fetch stable AD_Table UUID from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testTableUUID = DB.getSQLValueString(null, "SELECT AD_Table_UU FROM AD_Table WHERE AD_Table_ID=?", testTableId);
		assertNotNull(testTableUUID, "AD_Table_UU should be present for the test table");
	}

	/**
	 * Test the ID-based constructor: MTable(Properties ctx, int AD_Table_ID, String
	 * trxName)
	 */
	@Test
	public void testConstructor_ByID() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertNotNull(tbl, "MTable constructed by ID should not be null");
		assertEquals(testTableId, tbl.getAD_Table_ID(), "Loaded MTable must have expected AD_Table_ID");
	}

	/**
	 * Test the UUID-based constructor: MTable(Properties ctx, String AD_Table_UU,
	 * String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		MTable tblByUUID = new MTable(ctx, testTableUUID, getTrxName());
		assertNotNull(tblByUUID, "MTable constructed by UUID should not be null");
		assertEquals(testTableId, tblByUUID.getAD_Table_ID(), "MTable loaded by UUID should map to same AD_Table_ID");
		
		tblByUUID = new MTable(ctx, MTable.UUID_NEW_RECORD, getTrxName());
		assertNotNull(tblByUUID, "MTable constructed by UUID should not be null");
		assertEquals(MTable.ACCESSLEVEL_SystemOnly, tblByUUID.getAccessLevel());
		assertEquals(MTable.ENTITYTYPE_UserMaintained, tblByUUID.getEntityType());
		assertFalse(tblByUUID.isChangeLog());
		assertFalse(tblByUUID.isDeleteable());
		assertFalse(tblByUUID.isHighVolume());
		assertFalse(tblByUUID.isSecurityEnabled());
		assertFalse(tblByUUID.isView());
		assertEquals(MTable.REPLICATIONTYPE_Local, tblByUUID.getReplicationType());
	}

	/**
	 * Test the ResultSet-based constructor: MTable(Properties ctx, ResultSet rs,
	 * String trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Table WHERE AD_Table_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testTableId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Table");

			MTable tblFromRs = new MTable(ctx, rs, getTrxName());
			assertNotNull(tblFromRs, "MTable constructed from ResultSet should not be null");
			assertEquals(testTableId, tblFromRs.getAD_Table_ID(), "MTable(ResultSet) must have expected AD_Table_ID");
		} finally {
			DB.close(rs, pstmt);
		}
	}

	/**
	 * Test cases for MTable copy constructors.
	 */
	@Test
	public void testConstructor_Copy() {
		String trxName = getTrxName();		
		MTable original = new MTable(ctx, testTableId, trxName);
		
		// Copy using MTable(Properties ctx, MTable copy, String trxName)
		MTable copy = new MTable(ctx, original, trxName);
		assertNotNull(copy, "Copy should not be null");
	    assertNotSame(original, copy, "Copy must be a different instance");
	    assertEquals(original.getTableName(), copy.getTableName(), "TableName must be copied");
	    assertEquals(original.getName(), copy.getName(), "Name must be copied");
	    assertEquals(original.getEntityType(), copy.getEntityType(), "EntityType must be copied");
	
	    // Copy using MTable(MTable copy)
	    MTable copy1 = new MTable(original);
	    assertNotNull(copy1, "Copy1 should not be null");
	    assertNotSame(original, copy1, "Copy1 must be a different instance");
	    assertEquals(original.getTableName(), copy1.getTableName(), "TableName must be copied");
	    assertEquals(original.getName(), copy1.getName(), "Name must be copied");
	    assertEquals(original.getEntityType(), copy1.getEntityType(), "EntityType must be copied");

	    // Copy using MTable(Properties ctx, MTable copy)
	    MTable copy2 = new MTable(ctx, original);
	    assertNotNull(copy2, "Copy2 should not be null");
	    assertNotSame(original, copy2, "Copy2 must be a different instance");
	    assertEquals(original.getTableName(), copy2.getTableName(), "TableName must be copied");
	    assertEquals(original.getName(), copy2.getName(), "Name must be copied");
	    assertEquals(original.getEntityType(), copy2.getEntityType(), "EntityType must be copied");
	    
	    // Copy using MTable(Properties ctx, MTable copy, String trxName)
	    MTable view = MTable.get(ctx, "AD_AllUsers_V");
 		MTable copy3 = new MTable(ctx, view, trxName);
 		assertNotNull(copy3, "Copy should not be null");
 	    assertNotSame(view, copy3, "Copy must be a different instance");
 	    assertEquals(view.getTableName(), copy3.getTableName(), "TableName must be copied");
 	    assertEquals(view.getName(), copy3.getName(), "Name must be copied");
 	    assertEquals(view.getEntityType(), copy3.getEntityType(), "EntityType must be copied");
 	    
 	    MColumn[] oriColumns = view.getColumns(false);
 	    MColumn[] copyColumns = copy3.getColumns(false);
 	    assertNotNull(copyColumns, "Columns should not be null in copy");
 	    assertEquals(oriColumns.length, copyColumns.length, "Column count must match");
 	    for (int i = 0; i < oriColumns.length; i++) {
 	        assertNotSame(oriColumns[i], copyColumns[i], "Columns should be different instances");
 	        assertEquals(oriColumns[i].getColumnName(), copyColumns[i].getColumnName(), "ColumnName must match");
 	    }
 	    
 	    MViewComponent[] oriViewComponents = view.getViewComponent(false);
 	    MViewComponent[] copyViewComponents = copy3.getViewComponent(false);
 	    assertNotNull(copyViewComponents, "ViewComponents should not be null");
 	    assertEquals(oriViewComponents.length, copyViewComponents.length, "ViewComponents count must match");
 	    for (int i = 0; i < oriViewComponents.length; i++) {
 	    	assertNotSame(oriViewComponents[i], copyViewComponents[i], "ViewComponents should be different instances");
 	        assertEquals(oriViewComponents[i].getName(), copyViewComponents[i].getName(), "ViewComponent name must match");
 	    }
	}

	/**
	 * Test columnExistsInDB(String) for existing and non-existing columns.
	 */
	@Test
	public void testColumnExistsInDB() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertTrue(tbl.columnExistsInDB("IsActive"), "AD_Table should have column 'IsActive' in DB");
		assertFalse(tbl.columnExistsInDB("NON_EXISTENT_COLUMN_ABCDE"), "Non-existent column must return false");
	}

	/**
	 * Test columnExistsInDictionary(String) for existing and non-existing columns.
	 */
	@Test
	public void testColumnExistsInDictionary() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertTrue(tbl.columnExistsInDictionary("IsActive"), "AD_Table should have column 'IsActive' in dictionary");
		assertFalse(tbl.columnExistsInDictionary("NON_EXISTENT_COLUMN_ABCDE"), "Non-existent column must return false in dictionary check");
	}

	/**
	 * Test testGetColumn for existing and non-existing columns.
	 */
	@Test
	public void testGetColumn() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		MColumn col = tbl.getColumn("IsActive");
		assertNotNull(col, "Should return IsActive column");
		assertEquals("IsActive", col.getColumnName(), "Must have the expected column name");

		MColumn badCol = tbl.getColumn("NON_EXISTENT_COLUMN_ABCDE");
		assertNull(badCol, "Should return null for non-existent column");
	}

	/**
	 * Test isSingleKey() boolean flag defined by MTable.
	 */
	@Test
	public void testIsSingleKey() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertTrue(tbl.isSingleKey(), "AD_Table is expected to have a single primary key column");
	}

	/**
	 * Test isIDKeyTable() boolean flag defined by MTable.
	 */
	@Test
	public void testIsIDKeyTable() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertTrue(tbl.isIDKeyTable(), "AD_Table should be an ID-key table (primary key ends with _ID)");
	}

	/**
	 * Test isUUIDKeyTable() boolean flag defined by MTable.
	 */
	@Test
	public void testIsUUIDKeyTable() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertFalse(tbl.isUUIDKeyTable(), "AD_Table should not be UUID-key table (primary key does not end with _UU)");
	}

	/**
	 * Test hasUUIDKey() boolean flag defined by MTable.
	 */
	@Test
	public void testHasUUIDKey() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertTrue(tbl.hasUUIDKey(), "AD_Table is expected to have a UUID column (AD_Table_UU)");
	}

	/**
	 * Test hasCustomTree() boolean flag defined by MTable.
	 */
	@Test
	public void testHasCustomTree() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertFalse(tbl.hasCustomTree(), "AD_Table should not have a custom tree by default");
	}

	/**
	 * Test basic getters, setters and getColumns()/getColumn() behaviour.
	 */
	@Test
	public void testGettersSettersAndColumns() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		assertNotNull(tbl.getTableName(), "getTableName() must return a non-null string for AD_Table");

		MColumn[] cols = tbl.getColumns(false);
		assertNotNull(cols, "getColumns(false) should not return null");
		MColumn col = tbl.getColumn("IsActive");
		assertNotNull(col, "getColumn('IsActive') must find the column in AD_Table");
	}

	/**
	 * Test toString() method of MTable.
	 */
	@Test
	public void testToString() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		String s = tbl.toString();
		assertNotNull(s, "toString() must not return null");
		assertTrue(s.length() > 0, "toString() should have content");
		assertTrue(s.contains(tbl.getTableName()), "toString should contain the Table Name");
	}

	/**
	 * Test static cache behaviour: MTable.get(ctx, AD_Table_ID) should return the
	 * same immutable instance.
	 */
	@Test
	public void testStaticCacheBehavior() {
		MTable a = MTable.get(ctx, testTableId);
		MTable b = MTable.get(ctx, testTableId);
		assertSame(a, b, "MTable.get(ctx, id) should return the same cached immutable instance");

		MTable c = MTable.get(ctx, testTableName);
		assertSame(c, a, "MTable.get(ctx, tableName) should return the same cached immutable instance");
	}

	/**
	 * Test mandatory field validation: creating a new MTable without mandatory
	 * fields should not save.
	 */
	@Test
	public void testMandatoryFieldValidation() {
		MTable newTbl = new MTable(ctx, 0, getTrxName());
		assertThrows(Exception.class, () -> {
			newTbl.saveEx();
		}, "Should throw exception when without mandatory fields");
	}

	/**
	 * Test creating a persistent AD_Table record and ensure an ID is assigned.
	 */
	@Test
	public void testCreatePersistentObjectAndCleanup() {
		MTable newTbl = new MTable(ctx, 0, getTrxName());
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		try {
			newTbl.setTableName(tableName);
			newTbl.setName("Test MTable " + uniqueSuffix);
			boolean saved = newTbl.save();
			assertTrue(saved, "New AD_Table record should save when mandatory fields are provided");
			assertTrue(newTbl.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
		} finally {
			rollback();
		}
	}

	/**
	 * Test getPO helpers: getPO(int, trxName) and getUUIDPOInstance
	 */
	@Test
	public void testGetPOHelpers() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());
		PO poNew = tbl.getPO(0, getTrxName());
		assertNotNull(poNew, "getPO(0) should return a PO instance for creating new records");
		assertTrue(poNew.is_new(), "PO instance from getPO(0) should be marked as new");
		assertEquals(0, poNew.get_ID(), "PO instance from getPO(0) should have ID=0");

		PO poByUUID = tbl.getUUIDPOInstance(PO.UUID_NEW_RECORD, getTrxName());
		assertNotNull(poByUUID, "getUUIDPOInstance should return a PO instance for creating new records by UUID");
		assertTrue(poByUUID.is_new(), "PO instance from getUUIDPOInstance should be marked as new");
		assertEquals(PO.UUID_NEW_RECORD, poByUUID.get_UUID(), "PO instance from getUUIDPOInstance(UUID_NEW_RECORD) should have UUID=UUID_NEW_RECORD");
		
	}

	/**
	 * Test getViewComponent(boolean) to verify the view component is returned as
	 * expected.
	 */
	@Test
	public void testGetViewComponent() {
		MTable tbl = MTable.get(ctx, "AD_AllUsers_V");
		assertNotNull(tbl, "MTable instance must not be null");

		Object vc1 = tbl.getViewComponent(true);
		Object vc2 = tbl.getViewComponent(false);
		assertSame(vc1, vc2, "MTable.getViewComponent(reload) should remain consistent");
	}

	/**
	 * Test the static method isZeroIDTable(String).
	 */
	@Test
	public void testIsZeroIDTable() {
		assertFalse(MTable.isZeroIDTable("AD_User"), "AD_User should not be considered a zero-ID table");

		assertTrue(MTable.isZeroIDTable("AD_AllUsers_V"),
				"AD_AllUsers_V is known to be a zero-ID table (no primary key ID)");
	}

	/**
	 * Test getUUIDFromZeroID() behavior for tables with/without UUID keys.
	 */
	@Test
	public void testGetUUIDFromZeroID() {
		MTable tbl = new MTable(ctx, testTableId, getTrxName());

		if (tbl.isUUIDKeyTable()) {
			String uuid = tbl.getUUIDFromZeroID();
			assertNotNull(uuid, "getUUIDFromZeroID should return a UUID for UUID-key tables");
		} else {
			assertNull(tbl.getUUIDFromZeroID(), "getUUIDFromZeroID should return null for non-UUID-key tables");
		}
		
		tbl = new MTable(ctx, MClient.Table_ID, getTrxName());
		assertNotNull(tbl.getUUIDFromZeroID(), "getUUIDFromZeroID should return a UUID for AD_Client");
	}

	/**
	 * Test cases for MTable.getUUIDIndexName(String tableName).
	 */
	@Test
	public void testGetUUIDIndexName() {
		String indexName = MTable.getUUIDIndexName(MUser.Table_Name);
		assertNotNull(indexName, "UUID index name must not be null");
		assertTrue(indexName.length() > 0, "UUID index name must not be empty");
		assertTrue(indexName.toUpperCase().contains("AD_USER"), "UUID index name should contain the table name");

	    String tableName = MTable.Table_Name;
	    String uuidCol = PO.getUUIDColumnName(tableName);
	    String expected = uuidCol + "_idx";
	    String actual = MTable.getUUIDIndexName(tableName);
	    assertEquals(expected, actual, "Normal table name should append '_idx'");

	    // Long table name
	    String longTableName = "ThisIsAVeryLongTableNameExceedingLimitsForIndexNamingPurposes";
	    String longIndexName = MTable.getUUIDIndexName(longTableName);
	    assertTrue(longIndexName.length() <= AdempiereDatabase.MAX_OBJECT_NAME_LENGTH, "Index name must not exceed MAX_OBJECT_NAME_LENGTH");
	    assertTrue(longIndexName.endsWith("uuidx"), "Truncated long table name should end with 'uuidx'");

	    // Edge case: empty table name
	    String emptyIndexName = MTable.getUUIDIndexName("");
	    assertEquals("_UU_idx", emptyIndexName, "Empty table name should return '_UU_idx'");
	}

	/**
	 * Test getWithWindowAccessKeyNamePairs to ensure method executes without
	 * exception.
	 */
	@Test
	public void testGetWithWindowAccessKeyNamePairs() {
		var pairs = MTable.getWithWindowAccessKeyNamePairs(false, getTrxName());
		assertNotNull(pairs, "Returned KeyNamePair[] must not be null");
	}

	/**
	 * Test markImmutable() ensures the object is marked as immutable and cached
	 * properly.
	 */
	@Test
	public void testMarkImmutable() {
		MTable tbl = MTable.get(ctx, testTableId);
		tbl.markImmutable();

		MTable cached = MTable.get(ctx, testTableId);
		try {
			cached.setIsActive(false);
		} catch (Exception e) {}
		assertTrue(cached.isActive(), "IsActive after setIsActive should be active, no change");
		assertSame(tbl, cached, "Cached table must remain consistent after markImmutable");
		
		MColumn[] columns = tbl.getColumns(false);
		MColumn[] cachedColumns = cached.getColumns(false);
		if (cachedColumns.length > 0) {
			try {
				cachedColumns[0].setIsActive(false);
			} catch (Exception e) {}
			assertTrue(cachedColumns[0].isActive(), "IsActive after setIsActive should be active, no change");
			assertSame(columns, cachedColumns, "Cached columns must remain consistent after markImmutable");
		}
	}

	/**
	 * Test cases for MTable.get(int AD_Table_ID).
	 */
	@Test
	public void testGet_ByTableID() {
	    try {
	        // Valid table ID - use an existing core table such as AD_Table
	        MTable existingTable = MTable.get(Env.getCtx(), MTable.Table_Name, getTrxName());
	        assertNotNull(existingTable, "AD_Table must exist in the system");
	        int validTableId = existingTable.getAD_Table_ID();

	        MTable result1 = MTable.get(validTableId);
	        assertNotNull(result1, "Valid AD_Table_ID should return a table");
	        assertEquals(MTable.Table_Name, result1.getTableName(), "Returned table must be AD_Table");

	        // Invalid table ID
	        int invalidTableId = 9999999;
	        MTable result2 = MTable.get(invalidTableId);
	        assertNull(result2, "Invalid table ID should return null");

	        // Zero table ID
	        MTable result3 = MTable.get(0);
	        assertNotNull(result3, "AD_Table_ID=0 should return a table");
	        assertNull(result3.getTableName(), "Should return null for AD_Table_ID=0");
	    } finally {
	        rollback();
	    }
	}
	
	/**
	 * Test cases for MTable.getClass(String tableName).
	 */
	@Test
	public void testGetClass() {
	    try {
	        Class<?> clazz1 = MTable.getClass(MWebService.Table_Name);
	        assertEquals(MWebService.class, clazz1, "Should return class from cached factory");

	        Class<?> clazz2 = MTable.getClass(MWebService.Table_Name);
	        assertEquals(MWebService.class, clazz2, "Should return class from second valid factory");

	        Class<?> clazz3 = MTable.getClass("DoesNotExist");
	        assertNull(clazz3, "Should return null when the table does not exist");
	    } finally {
	        rollback();
	    }
	}
	
	/**
	 * Test cases for MTable.getCopy().
	 */
	@Test
	public void testGetCopy() {
	    try {
	        String trxName = getTrxName();

	        // 1. Create a real AD_Table record to test with
	        MTable original = new MTable(ctx, 0, trxName);
	        original.setTableName("TestCopyTable");
	        original.setName("Test Copy Table");
	        original.setEntityType(MTable.ENTITYTYPE_UserMaintained);
	        assertTrue(original.save(), "Original table should be saved");
	        
	        int tableId = original.getAD_Table_ID();

	        // Test happy path: getCopy() should return a new MTable instance
	        MTable copy = MTable.getCopy(ctx, tableId, trxName);
	        assertNotNull(copy, "Copy should not be null");
	        assertNotSame(original, copy, "Copy must be a different instance");
	        assertEquals(original.getAD_Table_ID(), copy.getAD_Table_ID(), "Copy must reference the same AD_Table_ID");
	        assertEquals(original.getTableName(), copy.getTableName(), "TableName must be copied");
	        assertEquals(original.getName(), copy.getName(), "Name must be copied");

	        // Test null path: invalid table ID
	        MTable missing = MTable.getCopy(ctx, -999999, trxName);
	        assertNull(missing, "Should return null for non-existing table");
	    } finally {
	        rollback();
	    }
	}
	
	/**
	 * Test cases for MTable.getTable_ID(String) and MTable.getTable_ID(String, String).
	 */
	@Test
	public void testGetTableID() {
	    // Known table: AD_Table must always exist in the system
	    int tableId = MTable.getTable_ID(MTable.Table_Name);
	    assertTrue(tableId > 0, "AD_Table should return a valid AD_Table_ID");

	    // Unknown table
	    assertEquals(0, MTable.getTable_ID("UnknownTableXYZ"), "Unknown table should return 0");

	    // Null or empty
	    assertEquals(0, MTable.getTable_ID(null), "Null table name should return 0");
	    assertEquals(0, MTable.getTable_ID(""), "Empty table name should return 0");
	    
	    String trxName = getTrxName();

	    // Known table (AD_Table)
	    tableId = MTable.getTable_ID("AD_Table", trxName);
	    assertTrue(tableId > 0, "AD_Table should return a valid AD_Table_ID");

	    // Unknown table
	    assertEquals(0, MTable.getTable_ID("UnknownTableXYZ", trxName), "Unknown table should return 0");

	    // Should behave same as single-arg version when trxName=null
	    int tableId2 = MTable.getTable_ID("AD_Table", null);
	    assertTrue(tableId2 > 0, "Should still resolve table when trxName=null");
	}
	
	/**
	 * Test cases for MTable.getTableName(Properties ctx, int AD_Table_ID).
	 */
	@Test
	public void testGetTableName() {
	    Properties ctx = Env.getCtx();
	    String trxName = getTrxName();

	    // Valid table: AD_Table
	    MTable table = MTable.get(ctx, MTable.Table_Name, trxName);
	    assertNotNull(table, "AD_Table must exist for test");
	    int validTableId = table.getAD_Table_ID();

	    String tableName = MTable.getTableName(ctx, validTableId);
	    assertEquals("AD_Table", tableName, "Table name should match 'AD_Table'");

	    // Invalid table ID
	    int invalidTableId = -999999;
	    assertThrows(NullPointerException.class,
	            () -> MTable.getTableName(ctx, invalidTableId),
	            "Invalid table ID should throw NullPointerException");

	    // Zero table ID
	    tableName = MTable.getTableName(ctx, 0);
	    assertNull(tableName, "Should return null for AD_Table_ID=0");
	}
	
	/**
	 * Test cases for MTable.getColumnIndex(int AD_Column_ID).
	 */
	@Test
	public void testGetColumnIndex() {
	    MTable table = MTable.get(ctx, testTableId);

	    // Test valid column index
	    MColumn[] columns = table.getColumns(false);
	    for (int i = 0; i < columns.length; i++) {
	    	table.getColumnIndex(columns[i].getAD_Column_ID());
	    	assertEquals(table.getColumnIndex(columns[i].getAD_Column_ID()), i, "ColumnIndex must match");
	    }

	    // Test non-existing column
	    int idxNon = table.getColumnIndex(-99999);
	    assertEquals(-1, idxNon, "Non-existing column should return -1");
	}
	
	/**
	 * Test cases for MTable.getIdentifierColumns()
	 */
	@Test
	public void testGetIdentifierColumns() {
		MTable table = MTable.get(ctx, MUser.Table_Name);
	    String[] result = table.getIdentifierColumns();
	    assertNotNull(result);
	    assertEquals(1, result.length, "Should return only columns with isIdentifier() == true");
	    assertEquals(MUser.COLUMNNAME_Name, result[0]);
	}
	
	/**
	 * Test getPartialPO(ResultSet, String[], String)
	 */
	@Test
	public void testGetPartialPO() throws Exception {
		MUser user = MUser.get(ctx, DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		
		String sql = "SELECT * FROM AD_User WHERE AD_User_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_User");
			
			String[] selectColumns = {MUser.COLUMNNAME_Name, MUser.COLUMNNAME_AD_User_UU};
			MTable table = MTable.get(ctx, MUser.Table_Name);
			PO result = table.getPartialPO(rs, selectColumns, getTrxName());
			assertEquals(result.get_Value(MUser.COLUMNNAME_Name), user.getName(), "Name must matched");
			assertEquals(result.get_Value(MUser.COLUMNNAME_AD_User_UU), user.getAD_User_UU(), "AD_User_UU must matched");
		} finally {
			DB.close(rs, pstmt);
		}
	}
	
	/**
	 * Test getUUIDPOInstance(String uuid, String trxName)
	 */
	@Test
	public void testGetUUIDPOInstance() throws Exception {
		MTable table = MTable.get(ctx, MTestUU.Table_Name);
		String uuid = "4e148b89-bdd9-48a6-8a8a-7609092f965c"; // TestRecordInSystem
	    PO po = table.getUUIDPOInstance(uuid, getTrxName());
	    assertNotNull(po, "GenericPO should be returned when no factory provides PO");
	    assertEquals(uuid, po.get_UUID(), "UUID of GenericPO must match requested UUID");
	}
	
	/**
	 * Test getWindowIDFromMenu()
	 */
	@Test
	public void testGetWindowIDFromMenu() {
		MTable table = MTable.get(ctx, MTest.Table_Name);
		int windowId = table.getWindowIDFromMenu();
	    assertEquals(DictionaryIDs.AD_Window.TEST.id, windowId, "Returned window ID must matched");
	}
	
	/**
	 * Test create table process
	 */
	@Test
	public void testCreateTableProcess() {
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		try {
			MTable table = new MTable(Env.getCtx(), 0, getTrxName());
			table.setTableName(tableName);
			table.setName("Test MTable " + uniqueSuffix);
			assertTrue(table.save(), "New AD_Table record should save when mandatory fields are provided");
			assertTrue(table.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
			
			MProcess process = MProcess.get(DictionaryIDs.AD_Process.CREATE_TABLE.id);
			MPInstance pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			MPInstancePara[] paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("TableName")) {
					para.setP_String(table.getTableName());
					para.saveEx();
				} else if (para.getParameterName().equals("Name")) {
					para.setP_String(table.getName());
					para.saveEx();
				} else if (para.getParameterName().equals("Description")) {
					para.setP_String(table.getDescription());
					para.saveEx();
				} else if (para.getParameterName().equals("AccessLevel")) {
					para.setP_String(table.getAccessLevel());
					para.saveEx();
				} else if (para.getParameterName().equals("EntityType")) {
					para.setP_String(table.getEntityType());
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateKeyColumn")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColValue")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColName")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColDescription")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColHelp")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColAD_User_ID")) {
					para.setP_String("Y");
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
		} finally {
			rollback();
		}
	}
	
	/**
	 * Tests getPartitionName(Properties, String, boolean, String)
	 */
	@Test
	public void testGetPartitionName() {
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		try {
			MTable table = new MTable(Env.getCtx(), 0, getTrxName());
			table.setTableName(tableName);
			table.setName("Test MTable " + uniqueSuffix);
			assertTrue(table.save(), "New AD_Table record should save when mandatory fields are provided");
			assertTrue(table.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
			
			MProcess process = MProcess.get(DictionaryIDs.AD_Process.CREATE_TABLE.id);
			MPInstance pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			MPInstancePara[] paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("TableName")) {
					para.setP_String(table.getTableName());
					para.saveEx();
				} else if (para.getParameterName().equals("Name")) {
					para.setP_String(table.getName());
					para.saveEx();
				} else if (para.getParameterName().equals("Description")) {
					para.setP_String(table.getDescription());
					para.saveEx();
				} else if (para.getParameterName().equals("AccessLevel")) {
					para.setP_String(table.getAccessLevel());
					para.saveEx();
				} else if (para.getParameterName().equals("EntityType")) {
					para.setP_String(table.getEntityType());
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateKeyColumn")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColValue")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColName")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColDescription")) {
					para.setP_String("Y");
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
			
			table.setIsPartition(true);
			assertTrue(table.save());
			
			MColumn[] columns = table.getColumns(false);
			assertNotNull(columns, "Columns should not be null");
			
			// empty tableName
			String partitionName = "";
		    assertEquals(partitionName, MTable.getPartitionName(Env.getCtx(), "", true, getTrxName()), "Empty tableName should return empty string");
		    assertEquals(partitionName, MTable.getPartitionName(Env.getCtx(), null, false, getTrxName()), "Null tableName should return empty string");

		    // no partition columns
		    partitionName = table.getTableName();
		    assertEquals(partitionName, MTable.getPartitionName(Env.getCtx(), table.getTableName(), true, getTrxName()), 
		    		"No partition columns should return tableName only");
		    
		    MColumn column = table.getColumn("AD_Client_ID");
		    column.setIsPartitionKey(true);
		    column.setPartitioningMethod(MColumn.PARTITIONINGMETHOD_List);
		    assertTrue(column.save());
		    
		    column = table.getColumn("AD_Org_ID");
		    column.setIsPartitionKey(true);
		    column.setPartitioningMethod(MColumn.PARTITIONINGMETHOD_List);
		    assertTrue(column.save());
		    
		    // primaryLevelOnly = true
		    partitionName = table.getTableName() + "_AD_Client_ID";
		    assertEquals(partitionName, MTable.getPartitionName(Env.getCtx(), table.getTableName(), true, getTrxName()), 
		    		"Primary level only should append only the first partition column");
		    
		    // primaryLevelOnly = false
		    partitionName = table.getTableName() + "_AD_Client_ID_AD_Org_ID";
		    assertEquals(partitionName, MTable.getPartitionName(Env.getCtx(), table.getTableName(), false, getTrxName()), 
		    		"All partition columns should be appended when primaryLevelOnly is false");
		} finally {
			rollback();
		}
	}
	
	/**
	 * Tests partition related processes
	 */
	@Test
	public void testPartitionRelatedProcesses() {
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_" + uniqueSuffix;
		List<PO> created = new ArrayList<>();
		try {
			MTable table = new MTable(Env.getCtx(), 0, getTrxName());
			table.setTableName(tableName);
			table.setName("Test MTable " + uniqueSuffix);
			assertTrue(table.save(), "New AD_Table record should save when mandatory fields are provided");
			assertTrue(table.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
			created.add(table);
			
			MProcess process = MProcess.get(DictionaryIDs.AD_Process.CREATE_TABLE.id);
			MPInstance pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			MPInstancePara[] paras = pinstance.getParameters();
			for (MPInstancePara para : paras) {
				if (para.getParameterName().equals("TableName")) {
					para.setP_String(table.getTableName());
					para.saveEx();
				} else if (para.getParameterName().equals("Name")) {
					para.setP_String(table.getName());
					para.saveEx();
				} else if (para.getParameterName().equals("Description")) {
					para.setP_String(table.getDescription());
					para.saveEx();
				} else if (para.getParameterName().equals("AccessLevel")) {
					para.setP_String(table.getAccessLevel());
					para.saveEx();
				} else if (para.getParameterName().equals("EntityType")) {
					para.setP_String(table.getEntityType());
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateKeyColumn")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColValue")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColName")) {
					para.setP_String("Y");
					para.saveEx();
				} else if (para.getParameterName().equals("IsCreateColDescription")) {
					para.setP_String("Y");
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
			
			table.setIsPartition(true);
			assertTrue(table.save());
			
			MColumn[] columns = table.getColumns(false);
			assertNotNull(columns, "Columns should not be null");
			for(PO po : columns)
				created.add(po);
			
		    MColumn column = table.getColumn("AD_Client_ID");
		    column.setIsPartitionKey(true);
		    column.setPartitioningMethod(MColumn.PARTITIONINGMETHOD_List);
		    column.setSeqNoPartition(10);
		    assertTrue(column.save());
		    
		    column = table.getColumn("AD_Org_ID");
		    column.setIsPartitionKey(true);
		    column.setPartitioningMethod(MColumn.PARTITIONINGMETHOD_List);
		    column.setSeqNoPartition(20);
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
 			
 			commit();
 			
 			for( MTableIndex index : MTableIndex.get(table)) {
 				created.add(index);
 				for(PO po : index.getColumns(false))
 					created.add(po);
 			}
		    
		    // Create Partition
		    process = MProcess.get(DictionaryIDs.AD_Process.AD_TABLE_CREATE_PARTITION.id);
			pinstance = new MPInstance(process, MTable.Table_ID, table.get_ID(), table.get_UUID());
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(!pi.isError(), pi.getSummary());
			
			List<X_AD_TablePartition> partitions = table.getTablePartitions(false, getTrxName());
			assertTrue(partitions.size() > 0);
			List<String> partitionNames = table.getTablePartitionNames(getTrxName());
			assertEquals(partitions.size(), partitionNames.size());
			for(PO po : partitions)
				created.add(po);
			
			// Detach / Reattach Partition
			process = MProcess.get(DictionaryIDs.AD_Process.DETACH_OR_REATTACH_PARTITION.id);
			pinstance = new MPInstance(process, MTablePartition.Table_ID, partitions.get(0).get_ID(), partitions.get(0).get_UUID());
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
			process.processIt(pi, Trx.get(getTrxName(), false), false);
			assertTrue(pi.isError(), pi.getSummary()); // can't detach or re-attach default partition
		} finally {
			rollback();
			try {
				String sql = "DROP TABLE " + tableName;
				DB.executeUpdateEx(sql, null);
				
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
	 * Test cases for MTable.getPOByUU() and getPO() methods.
	 */
	@Test
	public void testGetPOByUU_GetPO() {
	    String trxName = getTrxName();

	    MTable table = MTable.get(ctx, MClient.Table_Name);
	    assertNotNull(table);
	    String existingUUID = table.getUUIDFromZeroID();
	    assertNotNull(existingUUID);

	    String UUIDColumnName = PO.getUUIDColumnName(MClient.Table_Name);
	    PO po1 = table.getPOByUU(existingUUID, trxName);
	    assertNotNull(po1, "Should load PO by valid UUID");
	    assertEquals(existingUUID, po1.get_Value(UUIDColumnName));

	    PO poNew = table.getPOByUU(PO.UUID_NEW_RECORD, trxName);
	    assertNotNull(poNew, "UUID_NEW_RECORD must return a new PO instance");
	    assertTrue(poNew.get_ID() <= 0, "New PO must not have an assigned ID yet");

	    String fakeUUID = "00000000-0000-0000-0000-000000000000";
	    PO poFake = table.getPOByUU(fakeUUID, trxName);
	    assertNull(poFake, "Non-existent UUID should return null");

	    PO po2 = table.getPO(UUIDColumnName + "=" + DB.TO_STRING(existingUUID), trxName);
	    assertNotNull(po2, "getPO(whereClause) should load object");
	    assertEquals(existingUUID, po2.get_Value(UUIDColumnName));

	    PO po3 = table.getPO(UUIDColumnName + "=?", new Object[]{ existingUUID }, trxName);
	    assertNotNull(po3, "Parameterized getPO should load object");
	    assertEquals(existingUUID, po3.get_Value(UUIDColumnName));

	    assertNull(table.getPO((String) null, trxName), "Null whereClause must return null");
	    assertNull(table.getPO("", trxName), "Empty whereClause must return null");
	}
}
