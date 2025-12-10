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
import org.compiere.model.MUser;
import org.compiere.model.MWindow;
import org.compiere.model.PO;
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
	private final int testWindowId = DictionaryIDs.AD_Window.TEST.id;
	private final int testTabId = DictionaryIDs.AD_Tab.TEST_TEST.id;
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
		
		tab = new MTab(ctx, PO.UUID_NEW_RECORD, getTrxName());
		assertNotNull(tab, "MTab constructed by UUID should not be null");
		assertEquals(0, tab.getAD_Tab_ID(), "AD_Tab_ID should be 0 for new record");
		assertEquals(MTab.ENTITYTYPE_UserMaintained, tab.getEntityType());
		assertFalse(tab.isHasTree());
		assertFalse(tab.isReadOnly());
		assertFalse(tab.isSingleRow());
		assertFalse(tab.isSortTab());
		assertFalse(tab.isTranslationTab());
		assertEquals(0, tab.getSeqNo());
		assertEquals(0, tab.getTabLevel());
		assertTrue(tab.isInsertRecord());
		assertFalse(tab.isAdvancedTab());
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
			DB.close(rs, pstmt);
		}
	}

	/**
	 * Test copy constructors available in MTab: MTab(ctx, copy), MTab(ctx, copy, trxName) and MTab(copy)
	 */
	@Test
	public void testConstructor_Copy() {
		MTab original = new MTab(ctx, testTabId, getTrxName());
		MField[] originalFields = original.getFields(false, getTrxName());
		MTab copy = new MTab(ctx, original);
		MField[] copyFields = copy.getFields(false, getTrxName());
		assertNotNull(copy, "Copy constructor MTab(ctx, original) should produce an instance");
		assertEquals(original.getName(), copy.getName(), "Copied MTab should keep the same Name");
		assertEquals(originalFields.length, copyFields.length, "Copied MTab should keep the same number of fields");
		for (int i = 0; i < originalFields.length; i++) 
			assertEquals(originalFields[i].getName(), copyFields[i].getName(), "Copied MTab should keep the same field name");

		copy = new MTab(ctx, original, getTrxName());
		copyFields = copy.getFields(false, getTrxName());
		assertNotNull(copy, "Copy constructor MTab(ctx, original, trxName) should produce an instance");
		assertEquals(original.getAD_Table_ID(), copy.getAD_Table_ID(), "Copied MTab should keep the same AD_Table_ID");
		assertEquals(originalFields.length, copyFields.length, "Copied MTab should keep the same number of fields");
		for (int i = 0; i < originalFields.length; i++) 
			assertEquals(originalFields[i].getName(), copyFields[i].getName(), "Copied MTab should keep the same field name");
		
		copy = new MTab(original);
		copyFields = copy.getFields(false, getTrxName());
		assertNotNull(copy, "Copy constructor MTab(original) should produce an instance");
		assertEquals(original.getAD_Table_ID(), copy.getAD_Table_ID(), "Copied MTab should keep the same AD_Table_ID");
		assertEquals(originalFields.length, copyFields.length, "Copied MTab should keep the same number of fields");
		for (int i = 0; i < originalFields.length; i++) 
			assertEquals(originalFields[i].getName(), copyFields[i].getName(), "Copied MTab should keep the same field name");
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
	 * Test creating a persistent AD_Tab record
	 */
	@Test
	public void testCreatePersistentObjectAndCleanup() {
		try {
			MTab newTab = new MTab(ctx, 0, getTrxName());
			String unique = "T_" + System.currentTimeMillis();
			newTab.setAD_Window_ID(testWindowId);
			newTab.setAD_Table_ID(MUser.Table_ID);
			newTab.setName("Test Tab " + unique);
			newTab.setSeqNo(10);
			boolean saved = newTab.save();
			assertTrue(saved, "New AD_Tab should save when minimal mandatory fields are provided");
			assertTrue(newTab.get_ID() > 0, "Saved AD_Tab must have assigned AD_Tab_ID");
		} finally {
			rollback();
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
	
	/**
	 * Test cases for MTab(MWindow parent) and MTab(MWindow parent, MTab from)
	 */
	@Test
	public void testConstructor_CopyWithParent() {
		try {
			MWindow window = new MWindow(ctx, 0, getTrxName());
			String unique = "T_" + System.currentTimeMillis();
			window.setName("Test Window " + unique);
			window.setWindowType(MWindow.WINDOWTYPE_Maintain);
			assertTrue(window.save());
			
			MTab tab = new MTab(window);
			assertEquals(0, tab.get_ID(), "New tab should be unsaved (ID=0)");
	        assertEquals(window.getAD_Window_ID(), tab.getAD_Window_ID(), "AD_Window_ID should match parent");
	        assertEquals(window.getAD_Client_ID(), tab.getAD_Client_ID(), "Client should match parent");
	        assertEquals(window.getAD_Org_ID(), tab.getAD_Org_ID(), "Org should match parent");
	        assertEquals(window.getEntityType(), tab.getEntityType(), "EntityType should match parent");
	        
	        MWindow parent = new MWindow(ctx, 0, getTrxName());
			unique = "T_" + System.currentTimeMillis();
			parent.setName("Test Window " + unique);
			parent.setWindowType(MWindow.WINDOWTYPE_Maintain);
			assertTrue(parent.save());
	        
	        MTab originalTab = new MTab(ctx, DictionaryIDs.AD_Tab.TEST_TEST.id, getTrxName());
	        MTab copyTab = new MTab(parent, originalTab);
	        assertEquals(originalTab.getName(), copyTab.getName());
	        assertEquals(originalTab.getSeqNo(), copyTab.getSeqNo());
	        assertEquals(parent.getAD_Client_ID(), copyTab.getAD_Client_ID());
	        assertEquals(parent.getAD_Org_ID(), copyTab.getAD_Org_ID());
	        assertEquals(parent.getAD_Window_ID(), copyTab.getAD_Window_ID());
	        assertEquals(parent.getEntityType(), copyTab.getEntityType());
	        assertNotSame(originalTab, copyTab, "Copy should be a new object");
		} finally {
			rollback();
		}
	}
	
	/**
	 * Test cases for MTab.getParentTabID()
	 */
	@Test
	public void testGetParentTabID() {
		MTab rootTab = new MTab(ctx, DictionaryIDs.AD_Tab.USER_CONTACT.id, getTrxName());
		int parentID = rootTab.getParentTabID();
		assertEquals(-1, parentID, "TabLevel=0 should return -1 for parent");
		
		MTab childTab = new MTab(ctx, DictionaryIDs.AD_Tab.USER_USER_MAIL.id, getTrxName());
		parentID = childTab.getParentTabID();
		assertEquals(rootTab.getAD_Tab_ID(), parentID, "Should return parent tab ID");
	}
	
	/**
	 * Test cases for MTab.markImmutable()
	 */
	@Test
	public void testMarkImmutable() {
		MTab tab = new MTab(ctx, DictionaryIDs.AD_Tab.USER_CONTACT.id, getTrxName());
		assertFalse(tab.is_Immutable(), "Tab should initially be mutable");
		
		MTab returned = tab.markImmutable();
        assertSame(tab, returned, "Should return self");
        assertTrue(tab.is_Immutable(), "Tab should be marked immutable");
        
        returned = tab.markImmutable();
        assertSame(tab, returned, "Immutable tab should return self");
        assertTrue(tab.is_Immutable(), "Tab remains immutable");
	}
	
}
