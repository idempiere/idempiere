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

import java.awt.Dimension;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MTab;
import org.compiere.model.MWindow;
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
 * Comprehensive JUnit 5 tests for {@link MWindow}.
 * 
 * @author etantg
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MWindowTest extends AbstractTestCase {

	private final Properties ctx = Env.getCtx();
	private final int testWindowId = DictionaryIDs.AD_Window.USER.id;
	private String testWindowUUID;
	private String testWindowName;

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Fetch stable AD_Window UUID and Name from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testWindowUUID = DB.getSQLValueString(null, "SELECT AD_Window_UU FROM AD_Window WHERE AD_Window_ID=?", testWindowId);
		assertNotNull(testWindowUUID, "AD_Window.AD_Window_UU must be present for the test window");

		testWindowName = DB.getSQLValueString(null, "SELECT Name FROM AD_Window WHERE AD_Window_ID=?", testWindowId);
		assertNotNull(testWindowName, "AD_Window.Name must be present for the test window");
	}

	/**
	 * Test ID-based constructor: MWindow(Properties ctx, int AD_Window_ID, String
	 * trxName)
	 */
	@Test
	public void testConstructor_ByID() {
		MWindow w = new MWindow(ctx, testWindowId, getTrxName());
		assertNotNull(w, "MWindow constructed by ID should not be null");
		assertEquals(testWindowId, w.getAD_Window_ID(), "Loaded MWindow must have expected AD_Window_ID");
	}

	/**
	 * Test UUID-based constructor: MWindow(Properties ctx, String AD_Window_UU,
	 * String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		MWindow w = new MWindow(ctx, testWindowUUID, getTrxName());
		assertNotNull(w, "MWindow constructed by UUID should not be null");
		assertEquals(testWindowId, w.getAD_Window_ID(), "MWindow loaded by UUID should map to same AD_Window_ID");
	}

	/**
	 * Test ResultSet-based constructor: MWindow(Properties ctx, ResultSet rs,
	 * String trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Window WHERE AD_Window_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testWindowId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Window");

			MWindow w = new MWindow(ctx, rs, getTrxName());
			assertNotNull(w, "MWindow constructed from ResultSet should not be null");
			assertEquals(testWindowId, w.getAD_Window_ID(), "MWindow(ResultSet) must have expected AD_Window_ID");
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
	 * Test copy constructor: MWindow(Properties ctx, MWindow copy, String trxName)
	 * or MWindow(Properties ctx, MWindow copy)
	 */
	@Test
	public void testConstructor_Copy() {
		MWindow original = new MWindow(ctx, testWindowId, getTrxName());
		MWindow copy = new MWindow(ctx, original, getTrxName());
		assertNotNull(copy, "Copy of MWindow must not be null");
		assertEquals(original.getName(), copy.getName(), "Copied MWindow should keep the same name");
	}

	/**
	 * Test getting tabs for a window via getTabs(reload, trxName).
	 */
	@Test
	public void testGetTabs() {
		MWindow w = new MWindow(ctx, testWindowId, getTrxName());
		MTab[] tabs = w.getTabs(false, getTrxName());
		assertNotNull(tabs, "getTabs(false) should return an array (possibly empty) and not null");

		int dbTabCount = DB.getSQLValue(getTrxName(), "SELECT Count(*) FROM AD_Tab WHERE AD_Window_ID=?", testWindowId);
		assertEquals(dbTabCount, tabs.length, "Array length should match database count");

		if (tabs.length > 0) {
			assertEquals(testWindowId, tabs[0].getAD_Window_ID(), "Child tab should point to parent window.");
		}
	}

	/**
	 * Test toString() method inherited from X_AD_Window/PO.
	 */
	@Test
	public void testToString() {
		MWindow w = new MWindow(ctx, testWindowId, getTrxName());
		String s = w.toString();
		assertNotNull(s, "toString() must not return null");
		assertTrue(s.length() > 0, "toString() should contain content");
		assertTrue(s.contains(w.getName()), "toString should contain the Name");
	}

	/**
	 * Test static cache behavior: MWindow.get(ctx, AD_Window_ID) should return same
	 * cached instance.
	 */
	@Test
	public void testStaticCacheBehavior() {
		MWindow a = MWindow.get(ctx, testWindowId);
		MWindow b = MWindow.get(ctx, testWindowId);
		assertSame(a, b, "MWindow.get(ctx, id) should return the same cached immutable instance");
	}

	/**
	 * Test mandatory field validation: saving a new MWindow without mandatory
	 * fields should fail.
	 */
	@Test
	public void testMandatoryFieldValidation() {
		MWindow w = new MWindow(ctx, 0, getTrxName());
		assertThrows(Exception.class, () -> {
			w.saveEx();
		}, "Should throw exception when without mandatory fields");
	}

	/**
	 * Test creating a persistent AD_Window and cleanup.
	 * <p>
	 * Attempts to provide minimal required fields to persist a window. Real DB
	 * constraints may require additional setup (e.g., Tabs). The test ensures
	 * cleanup using delete(true, trxName).
	 */
	@Test
	public void testCreatePersistentObjectAndCleanup() {
		MWindow newWin = new MWindow(ctx, 0, getTrxName());
		String unique = "T_TEST_WIN_" + System.currentTimeMillis();
		try {
			newWin.setName("Test Window " + unique);
			newWin.setWindowType(MWindow.WINDOWTYPE_Maintain);
			newWin.setIsActive(true);
			boolean saved = newWin.save();
			assertTrue(saved, "New AD_Window should save when minimal mandatory fields are provided (Name, WindowType, IsActive)");
			assertTrue(newWin.get_ID() > 0, "Saved AD_Window must have assigned AD_Window_ID");
		} finally {
			try {
				if (newWin.get_ID() > 0)
					newWin.delete(true, getTrxName());
			} catch (Exception e) {
			}
		}
	}

	/**
	 * Test helper methods: getWindow_ID(String) and get(ctx, uu) by UUID.
	 */
	@Test
	public void testHelpers() {
		int idByName = MWindow.getWindow_ID(testWindowName);
		assertEquals(testWindowId, idByName, "getWindow_ID(name) should return expected AD_Window_ID");

		MWindow wByUUID = MWindow.get(ctx, testWindowUUID);
		assertNotNull(wByUUID, "get(ctx, uuid) should return a window instance");
		assertEquals(testWindowId, wByUUID.getAD_Window_ID(), "Window loaded by UUID must match ID fetched in beforeAll");
	}

	/**
	 * Test markImmutable() and setWindowSize(Dimension) do not throw and behave as
	 * expected.
	 */
	@Test
	public void testMarkImmutableAndSetSize() {
		MWindow w = new MWindow(ctx, testWindowId, getTrxName());
		w.markImmutable();
		try {
			w.setWindowSize(new Dimension(800, 600));
		} catch (Exception e) {}
		assertTrue(w.getWinWidth() == 0, "WinWidth after setWindowSize should be zero, no change");
	}

	/**
	 * Test setWindowSize(Dimension)
	 */
	@Test
	public void testSetWindowSize() {
		MWindow w = new MWindow(ctx, testWindowId, getTrxName());
		w.setWindowSize(new Dimension(800, 600));
		assertTrue(w.getWinWidth() == 800, "WinWidth after setWindowSize should be 800");
		assertTrue(w.getWinHeight() == 600, "WinHeight after setWindowSize should be 600");
	}

	/**
	 * Test getter and setter for WindowType.
	 */
	@Test
	public void testSetAndGetWindowType() {
		MWindow w = new MWindow(ctx, testWindowId, getTrxName());
		w.setWindowType(MWindow.WINDOWTYPE_QueryOnly);
		assertEquals(MWindow.WINDOWTYPE_QueryOnly, w.getWindowType(), "WindowType getter/setter should return the assigned value");
	}

}
