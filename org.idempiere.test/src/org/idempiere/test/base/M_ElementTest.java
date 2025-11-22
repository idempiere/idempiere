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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.M_Element;
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
 * Comprehensive JUnit 5 tests for {@link M_Element}.
 * 
 * @author etantg
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class M_ElementTest extends AbstractTestCase {

	private final Properties ctx = Env.getCtx();
	private final int testElementId = DictionaryIDs.AD_Element.NAME.id;
	private String testElementUUID;

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Fetch stable AD_Element UUID from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testElementUUID = DB.getSQLValueString(null, "SELECT AD_Element_UU FROM AD_Element WHERE AD_Element_ID=?", testElementId);
		assertNotNull(testElementUUID, "AD_Element_UU must be present for the selected element");
	}

	/**
	 * Test ID-based constructor: M_Element(Properties ctx, int AD_Element_ID,
	 * String trxName)
	 */
	@Test
	public void testConstructor_ByID() {
		M_Element e = new M_Element(ctx, testElementId, getTrxName());
		assertNotNull(e, "M_Element constructed by ID should not be null");
		assertEquals(testElementId, e.getAD_Element_ID(), "Loaded M_Element must have expected AD_Element_ID");
	}

	/**
	 * Test UUID-based constructor: M_Element(Properties ctx, String AD_Element_UU,
	 * String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		M_Element e = new M_Element(ctx, testElementUUID, getTrxName());
		assertNotNull(e, "M_Element constructed by UUID should not be null");
		assertEquals(testElementId, e.getAD_Element_ID(), "M_Element loaded by UUID should map to same AD_Element_ID");
	}

	/**
	 * Test ResultSet-based constructor: M_Element(Properties ctx, ResultSet rs,
	 * String trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Element WHERE AD_Element_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testElementId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Element");

			M_Element e = new M_Element(ctx, rs, getTrxName());
			assertNotNull(e, "M_Element constructed from ResultSet should not be null");
			assertEquals(testElementId, e.getAD_Element_ID(), "M_Element(ResultSet) must have expected AD_Element_ID");
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
	 * Test static get(ctx, columnName) and get(ctx, columnName, trxName) behaviour.
	 */
	@Test
	public void testStaticGetByColumnName() {
		String columnName = DB.getSQLValueString(getTrxName(), "SELECT ColumnName FROM AD_Element WHERE AD_Element_ID=?", testElementId);
		assertNotNull(columnName, "ColumnName must exist for test element");

		M_Element a = M_Element.get(ctx, columnName);
		assertNotNull(a, "M_Element.get(ctx, columnName) should return an instance");
		assertEquals(testElementId, a.getAD_Element_ID(), "M_Element.get(ctx, columnName) must have expected AD_Element_ID");

		M_Element b = M_Element.get(ctx, columnName, getTrxName());
		assertNotNull(b, "M_Element.get(ctx, columnName, trxName) should return an instance");
		assertEquals(testElementId, b.getAD_Element_ID(), "M_Element.get(ctx, columnName, trxName) must have expected AD_Element_ID");

		M_Element bad = M_Element.get(ctx, "NonExistentColumn_" + System.currentTimeMillis());
		assertNull(bad, "Should return null for non-existent element");
	}

	/**
	 * Test getOfColumn(ctx, AD_Column_ID) helper.
	 */
	@Test
	public void testGetOfColumn() {
		int adColumnId = DictionaryIDs.AD_Column.COLUMN_NAME.id;
		M_Element e = M_Element.getOfColumn(ctx, adColumnId);
		assertNotNull(e, "getOfColumn should return an M_Element for a valid AD_Column_ID");
	}

	/**
	 * Test getColumnName(columnName) static helper returns case-sensitive name when
	 * present.
	 */
	@Test
	public void testGetColumnNameHelper() {
		String columnName = DB.getSQLValueString(getTrxName(), "SELECT ColumnName FROM AD_Element WHERE AD_Element_ID=?", testElementId);
		assertNotNull(columnName, "ColumnName must exist for test element");
		String resolved = M_Element.getColumnName(columnName.toUpperCase());
		assertNotNull(resolved, "getColumnName should return a case-sensitive column name when present");
		assertEquals(resolved, columnName, "M_Element.getColumnName(columnName) must have column name");
	}

	/**
	 * Test toString() representation.
	 */
	@Test
	public void testToString() {
		M_Element e = new M_Element(ctx, testElementId, getTrxName());
		String s = e.toString();
		assertNotNull(s, "toString() must not return null");
		assertTrue(s.length() > 0, "toString() should contain content");
		assertTrue(s.contains(e.getColumnName()), "toString should contain the ColumnName");
	}

	/**
	 * Test mandatory field validation for a new M_Element.
	 */
	@Test
	public void testMandatoryFieldValidation() {
		M_Element e = new M_Element(ctx, 0, getTrxName());
		assertThrows(Exception.class, () -> {
			e.saveEx();
		}, "Should throw exception when without mandatory fields");
	}

	/**
	 * Test creating a persistent AD_Element and cleanup.
	 */
	@Test
	public void testCreatePersistentObjectAndCleanup() {
		M_Element e = new M_Element(ctx, 0, getTrxName());
		String unique = "T_TEST_ELEMENT_" + System.currentTimeMillis();
		try {
			e.setColumnName("TEST_COLUMN_" + unique);
			e.setName("Test Element " + unique);
			e.setPrintName("Test Element " + unique);
			boolean saved = e.save();
			assertTrue(saved, "New AD_Element should save when mandatory fields are provided");
			assertTrue(e.get_ID() > 0, "Saved AD_Element must have assigned AD_Element_ID");
		} finally {
			try {
				if (e.get_ID() > 0)
					e.delete(true, getTrxName());
			} catch (Exception ex) {}
		}
	}

}
