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
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.LoginDetails;
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
	private final String testTableName = MUser.Table_Name; // AD_User;
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
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException ignored) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException ignored) {}
			}
		}
	}

	/**
	 * Test the copy constructor: MTable(Properties ctx, MTable copy, String
	 * trxName)
	 */
	@Test
	public void testConstructor_Copy() {
		MTable original = new MTable(ctx, testTableId, getTrxName());
		MTable copy = new MTable(ctx, original, getTrxName());
		assertNotNull(copy, "Copy of MTable must not be null");
		assertEquals(original.getTableName(), copy.getTableName(), "Copied MTable should keep the same TableName");
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
	 * Test creating a persistent AD_Table record and ensure an ID is assigned. Uses
	 * try-finally to ensure cleanup via delete(true, trxName).
	 */
	@Test
	public void testCreatePersistentObjectAndCleanup() {
		MTable newTbl = new MTable(ctx, 0, getTrxName());
		String uniqueSuffix = String.valueOf(System.currentTimeMillis());
		String tableName = "T_TEST_MTABLE_" + uniqueSuffix;
		try {
			newTbl.setTableName(tableName);
			newTbl.setName("Test MTable " + uniqueSuffix);
			boolean saved = newTbl.save();
			assertTrue(saved, "New AD_Table record should save when mandatory fields are provided");
			assertTrue(newTbl.get_ID() > 0, "Saved AD_Table must have an assigned AD_Table_ID");
		} finally {
			try {
				if (newTbl.get_ID() > 0) {
					newTbl.delete(true, getTrxName());
				}
			} catch (Exception e) {}
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
	}

	/**
	 * Test getUUIDIndexName(String) produces deterministic non-null output.
	 */
	@Test
	public void testGetUUIDIndexName() {
		String indexName = MTable.getUUIDIndexName("AD_User");

		assertNotNull(indexName, "UUID index name must not be null");
		assertTrue(indexName.length() > 0, "UUID index name must not be empty");

		assertTrue(indexName.toUpperCase().contains("AD_USER"), "UUID index name should contain the table name");
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
	}

}
