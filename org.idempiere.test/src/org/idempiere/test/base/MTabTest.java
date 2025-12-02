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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MField;
import org.compiere.model.MTab;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestInstance;

/**
 * Comprehensive JUnit 5 tests for {@link MTab}.
 * 
 * @author etantg
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MTabTest extends AbstractTestCase {

	private final Properties ctx = Env.getCtx();
	private final int testWindowId = DictionaryIDs.AD_Window.USER.id;
	private final int testTabId = DictionaryIDs.AD_Tab.USER_CONTACT.id;
	private String testTabUUID;

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Fetch stable AD_Tab UUID from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testTabUUID = DB.getSQLValueString(null, "SELECT AD_Tab_UU FROM AD_Tab WHERE AD_Tab_ID=?", testTabId);
		assertNotNull(testTabUUID, "AD_Tab_UU should be present for the test tab");
	}

	/**
	 * Test ID-based constructor: MTab(Properties ctx, int AD_Tab_ID, String
	 * trxName)
	 */
	@Test
	public void testConstructor_ByID() {
		MTab tab = new MTab(ctx, testTabId, getTrxName());
		assertNotNull(tab, "MTab constructed by ID should not be null");
		assertEquals(testTabId, tab.getAD_Tab_ID(), "Loaded MTab must have expected AD_Tab_ID");
	}

	/**
	 * Test UUID-based constructor: MTab(Properties ctx, String AD_Tab_UU, String
	 * trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		MTab tab = new MTab(ctx, testTabUUID, getTrxName());
		assertNotNull(tab, "MTab constructed by UUID should not be null");
		assertEquals(testTabId, tab.getAD_Tab_ID(), "MTab loaded by UUID should map to same AD_Tab_ID");
	}

	/**
	 * Test ResultSet-based constructor: MTab(Properties ctx, ResultSet rs, String
	 * trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Tab WHERE AD_Tab_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testTabId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Tab");

			MTab tab = new MTab(ctx, rs, getTrxName());
			assertNotNull(tab, "MTab constructed from ResultSet should not be null");
			assertEquals(testTabId, tab.getAD_Tab_ID(), "MTab(ResultSet) must have expected AD_Tab_ID");
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ignored) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ignored) {}
		}
	}

	/**
	 * Test copy constructors available in MTab: MTab(ctx, copy) and MTab(ctx, copy,
	 * trxName)
	 */
	@Test
	public void testConstructor_Copy() {
		MTab original = new MTab(ctx, testTabId, getTrxName());
		MTab copy1 = new MTab(ctx, original);
		assertNotNull(copy1, "Copy constructor MTab(ctx, original) should produce an instance");
		assertEquals(original.getName(), copy1.getName(), "Copied MTab should keep the same Name");

		MTab copy2 = new MTab(ctx, original, getTrxName());
		assertNotNull(copy2, "Copy constructor MTab(ctx, original, trxName) should produce an instance");
		assertEquals(original.getAD_Table_ID(), copy2.getAD_Table_ID(), "Copied MTab should keep the same AD_Table_ID");
	}

	/**
	 * Test getFields(reload, trxName) returns an array of MField instances.
	 */
	@Test
	public void testGetFields() {
		MTab tab = new MTab(ctx, testTabId, getTrxName());
		MField[] fields = tab.getFields(false, getTrxName());
		assertNotNull(fields, "getFields(false) should return non-null array (may be empty)");
		assertEquals(testTabId, fields[0].getAD_Tab_ID(), "Field should belong to the requested tab.");

		MField[] fieldsReload = tab.getFields(true, getTrxName());
		assertNotNull(fieldsReload, "getFields(true) should return non-null array after reload");
		assertEquals(testTabId, fieldsReload[0].getAD_Tab_ID(), "Field should belong to the requested tab.");
	}

	/**
	 * Test toString() method of MTab.
	 */
	@Test
	public void testToString() {
		MTab tab = new MTab(ctx, testTabId, getTrxName());
		String s = tab.toString();
		assertNotNull(s, "toString() must not return null");
		assertTrue(s.length() > 0, "toString() should contain content");
		assertTrue(s.contains(tab.getName()), "toString should contain the Name");
	}

	/**
	 * Test static cache behaviour: MTab.get(AD_Tab_ID) should return the same
	 * cached instance.
	 */
	@Test
	public void testStaticCacheBehavior() {
		MTab a = MTab.get(testTabId);
		MTab b = MTab.get(testTabId);
		assertSame(a, b, "MTab.get(id) should return same cached immutable instance");
	}

	/**
	 * Test mandatory field validation: saving a new MTab without mandatory fields
	 * should fail.
	 */
	@Test
	public void testMandatoryFieldValidation() {
		MTab newTab = new MTab(ctx, 0, getTrxName());
		assertThrows(Exception.class, () -> {
			newTab.saveEx();
		}, "Should throw exception when without mandatory fields");
	}

	/**
	 * Test creating a persistent AD_Tab record and cleanup.
	 * <p>
	 * Sets minimal likely mandatory fields (AD_Window_ID, AD_Table_ID, Name, SeqNo)
	 * and attempts to save.
	 */
	@Test
	public void testCreatePersistentObjectAndCleanup() {
		MTab newTab = new MTab(ctx, 0, getTrxName());
		String unique = "T_TEST_TAB_" + System.currentTimeMillis();
		int adTableId = DB.getSQLValue(getTrxName(), "SELECT AD_Table_ID FROM AD_Table WHERE TableName=?", "AD_Table");
		try {
			newTab.setAD_Window_ID(testWindowId);
			newTab.setAD_Table_ID(adTableId);
			newTab.setName("Test Tab " + unique);
			newTab.setSeqNo(10);
			boolean saved = newTab.save();
			assertTrue(saved, "New AD_Tab should save when minimal mandatory fields are provided");
			assertTrue(newTab.get_ID() > 0, "Saved AD_Tab must have assigned AD_Tab_ID");
		} finally {
			try {
				if (newTab.get_ID() > 0)
					newTab.delete(true, getTrxName());
			} catch (Exception e) {}
		}
	}

	/**
	 * Test helper methods: getTab_ID(windowId, tabName) and getParentTabID().
	 */
	@Test
	public void testHelpers() {
		MTab tab = new MTab(ctx, testTabId, getTrxName());
		int byName = MTab.getTab_ID(testWindowId, tab.getName());
		assertEquals(testTabId, byName, "getTab_ID(windowId, tabName) should return expected AD_Tab_ID");

		int parentTabId = tab.getParentTabID();
		assertTrue(parentTabId >= -1, "getParentTabID() should return a valid ID or -1 when no parent");

		MTab marked = tab.markImmutable();
		assertNotNull(marked, "markImmutable() should return an MTab instance");
	}

	/**
	 * Test get(AD_Tab_ID) with a non-existing ID returns null or an empty instance
	 * as per API.
	 */
	@Test
	public void testGetNonExisting() {
		MTab notFound = MTab.get(-999999);
		if (notFound != null) {
			assertTrue(notFound.getAD_Tab_ID() == 0 || notFound.getAD_Tab_ID() == -999999, "Non-existing get() should return null or a placeholder");
		}
	}

}
