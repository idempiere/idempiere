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
import java.util.Properties;

import org.compiere.model.MColumn;
import org.compiere.model.MField;
import org.compiere.model.MTab;
import org.compiere.model.MUser;
import org.compiere.model.MWindow;
import org.compiere.model.M_Element;
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
 * Comprehensive JUnit 5 tests for {@link MField}.
 * 
 * @author etantg
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MFieldTest extends AbstractTestCase {

	private final Properties ctx = Env.getCtx();
	private final int testTabId = DictionaryIDs.AD_Tab.TEST_TEST.id;
	private final int testFieldId = DictionaryIDs.AD_Field.TEST_TEST_NAME.id;
	private String testFieldUUID;
	private int testColumnId;

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Fetch stable AD_Field UUID and AD_Column_ID from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testFieldUUID = DB.getSQLValueString(null, "SELECT AD_Field_UU FROM AD_Field WHERE AD_Field_ID=?", testFieldId);
		assertNotNull(testFieldUUID, "AD_Field_UU should be present for the test field");

		testColumnId = DB.getSQLValue(null, "SELECT AD_Column_ID FROM AD_Field WHERE AD_Field_ID=?", testFieldId);
		assertTrue(testColumnId > 0, "Related AD_Column must exist for the test field");
	}

	/**
	 * Test ID-based constructor: MField(Properties ctx, int AD_Field_ID, String trxName)
	 */
	@Test
	public void testConstructor_ByID() {
		MField f = new MField(ctx, testFieldId, getTrxName());
		assertNotNull(f, "MField constructed by ID should not be null");
		assertEquals(testFieldId, f.getAD_Field_ID(), "Loaded MField must have expected AD_Field_ID");
	}

	/**
	 * Test UUID-based constructor: MField(Properties ctx, String AD_Field_UU, String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		MField f = new MField(ctx, testFieldUUID, getTrxName());
		assertNotNull(f, "MField constructed by UUID should not be null");
		assertEquals(testFieldId, f.getAD_Field_ID(), "MField loaded by UUID should map to same AD_Field_ID");
		
		f = new MField(ctx, PO.UUID_NEW_RECORD, getTrxName());
		assertNotNull(f, "MField constructed by UUID should not be null");
		assertEquals(0, f.getAD_Field_ID(), "AD_Field_ID should be 0 for new record");
		assertEquals(MField.ENTITYTYPE_UserMaintained, f.getEntityType());
		assertTrue(f.isCentrallyMaintained());
		assertTrue(f.isDisplayed());
		assertTrue(f.isDisplayedGrid());
		assertFalse(f.isEncrypted());
		assertFalse(f.isFieldOnly());
		assertFalse(f.isHeading());
		assertFalse(f.isReadOnly());
		assertFalse(f.isSameLine());
	}

	/**
	 * Test ResultSet-based constructor: MField(Properties ctx, ResultSet rs, String trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Field WHERE AD_Field_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testFieldId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Field");

			MField f = new MField(ctx, rs, getTrxName());
			assertNotNull(f, "MField constructed from ResultSet should not be null");
			assertEquals(testFieldId, f.getAD_Field_ID(), "MField(ResultSet) must have expected AD_Field_ID");
		} finally {
			DB.close(rs, pstmt);
		}
	}

	/**
	 * Test copy constructor: MField(MField original, int AD_Client_ID, String trxName)
	 */
	@Test
	public void testConstructor_Copy() {
		MField original = new MField(ctx, testFieldId, getTrxName());
		MField copy = new MField(original);
		assertNotNull(copy, "Copy of MField must not be null");
		assertEquals(original.getAD_Column_ID(), copy.getAD_Column_ID(), "Copied MField should keep the same AD_Column_ID");
	}

	/**
	 * Test getters for common properties.
	 */
	@Test
	public void testGetters() {
		MField f = new MField(ctx, testFieldId, getTrxName());
		assertNotNull(f.getName(), "getName() must return a non-null value");
		assertTrue(f.getAD_Column_ID() > 0, "getAD_Column_ID() must return a positive ID");
		assertTrue(f.getAD_Tab_ID() > 0, "getAD_Tab_ID() must return a positive ID");
	}

	/**
	 * Test toString() method.
	 */
	@Test
	public void testToString() {
		MField f = new MField(ctx, testFieldId, getTrxName());
		String s = f.toString();
		assertNotNull(s, "toString() must not return null");
		assertTrue(s.length() > 0, "toString() should have content");
		assertTrue(s.contains(f.getName()), "toString should contain the Name");
	}

	/**
	 * Test static cache behaviour: MField.get(ctx, AD_Field_ID)
	 */
	@Test
	public void testStaticCacheBehavior() {
		MField a = MField.get(ctx, testFieldId);
		MField b = MField.get(ctx, testFieldId);
		assertSame(a, b, "MField.get(ctx, id) should return the same cached instance");
	}

	/**
	 * Test mandatory field validation: creating a new MField without mandatory fields should not save.
	 */
	@Test
	public void testMandatoryFieldValidation() {
		MField f = new MField(ctx, 0, getTrxName());
		assertThrows(Exception.class, () -> {
			f.saveEx();
		}, "Should throw exception when without mandatory fields");
	}

	/**
	 * Test creating a persistent MField
	 */
	@Test
	public void testCreatePersistentObject() {	
		try {
			MTab tab = MTab.get(testTabId);
			MField f = new MField(ctx, 0, getTrxName());
			MColumn col = new MColumn(Env.getCtx(), 0, getTrxName());
			M_Element elem = new M_Element(Env.getCtx(), 0, getTrxName());
			String unique = "T_" + System.currentTimeMillis();
			String uniqueColumnName = "TestColumnName_" + unique;
			
			elem.setColumnName(uniqueColumnName);
			elem.setName("Test Column");
			elem.setPrintName("Test Column");
			boolean saved = elem.save();
			assertTrue(saved, "New AD_Element should save when mandatory fields are provided");
			assertTrue(elem.get_ID() > 0, "Saved AD_Element must have assigned AD_Element_ID");

			col.setAD_Table_ID(tab.getAD_Table_ID());
			col.setAD_Element_ID(elem.get_ID());
			col.setColumnName(uniqueColumnName);
			col.setName("Test Column");
			col.setAD_Reference_ID(10); // String reference for example
			col.setFieldLength(60);
			saved = col.save();
			assertTrue(saved, "New MColumn should save with mandatory fields");
			assertTrue(col.get_ID() > 0, "Saved MColumn must have assigned AD_Column_ID");

			f.setAD_Tab_ID(testTabId);
			f.setAD_Column_ID(col.get_ID());
			f.setName("Test Field " + unique);
			f.setSeqNo(10);
			f.setAD_Reference_ID(10);
			saved = f.save();
			assertTrue(saved, "New AD_Field should save when minimal mandatory fields are provided");
			assertTrue(f.get_ID() > 0, "Saved AD_Field must have assigned AD_Field_ID");
		} finally {
			rollback();
		}
	}
	
	/**
	 * Test cases for MField(MTab parent) and MField(MTab parent, MField from)
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
			tab.setAD_Table_ID(MUser.Table_ID);
			tab.setName("Test Tab " + unique);
			tab.setSeqNo(10);
			assertTrue(tab.save());
			
			MField field = new MField(tab);
			assertEquals(0, field.get_ID(), "New field should be unsaved (ID=0)");
	        assertEquals(tab.getAD_Tab_ID(), field.getAD_Tab_ID(), "AD_Tab_ID should match parent");
	        assertEquals(tab.getAD_Client_ID(), field.getAD_Client_ID(), "Client should match parent");
	        assertEquals(tab.getAD_Org_ID(), field.getAD_Org_ID(), "Org should match parent");
	        
	        window = new MWindow(ctx, 0, getTrxName());
			unique = "T_" + System.currentTimeMillis();
			window.setName("Test Window " + unique);
			window.setWindowType(MWindow.WINDOWTYPE_Maintain);
			assertTrue(window.save());
			
			MTab parent = new MTab(window);
			parent.setAD_Table_ID(MUser.Table_ID);
			parent.setName("Test Tab " + unique);
			parent.setSeqNo(10);
			assertTrue(parent.save());
	        
	        MField originalField = new MField(ctx, DictionaryIDs.AD_Field.TEST_TEST_NAME.id, getTrxName());
	        MField copyField = new MField(parent, originalField);
	        assertEquals(originalField.getName(), copyField.getName());
	        assertEquals(originalField.getSeqNo(), copyField.getSeqNo());
	        assertEquals(parent.getAD_Client_ID(), copyField.getAD_Client_ID());
	        assertEquals(parent.getAD_Org_ID(), copyField.getAD_Org_ID());
	        assertEquals(parent.getAD_Tab_ID(), copyField.getAD_Tab_ID());
	        assertEquals(parent.getEntityType(), copyField.getEntityType());
	        assertNotSame(originalField, copyField, "Copy should be a new object");
		} finally {
			rollback();
		}
	}

	/**
	 * Test cases for MField.markImmutable()
	 */
	@Test
	public void testMarkImmutable() {
		MField field = new MField(ctx, DictionaryIDs.AD_Field.USER_CONTACT_NAME.id, getTrxName());
		assertFalse(field.is_Immutable(), "Field should initially be mutable");
		
		MField returned = field.markImmutable();
        assertSame(field, returned, "Should return self");
        assertTrue(field.is_Immutable(), "Field should be marked immutable");
        
        returned = field.markImmutable();
        assertSame(field, returned, "Immutable tab should return self");
        assertTrue(field.is_Immutable(), "Field remains immutable");
	}
	
	/**
	 * Test cases for MField.get(Properties ctx, int AD_Field_ID) and MField.get(int AD_Field_ID)
	 */
	@Test
	public void testGetById() {
        // Valid ID
        MField firstLoad = MField.get(ctx, testFieldId);
        assertNotNull(firstLoad, "Valid ID should not return null");
        assertEquals(testFieldId, firstLoad.getAD_Field_ID());
        
        MField secondLoad = MField.get(testFieldId);
        assertNotNull(secondLoad, "Valid ID should not return null");
        assertSame(firstLoad, secondLoad, "Cache should return same instance");
        
        // Invalid ID
        MField invalid = MField.get(-1);
        assertNull(invalid, "Invalid ID should return null");
        
        invalid = MField.get(ctx, -99999);
        assertNull(invalid, "Invalid ID must return null");
	}
	
	/**
	 * Test cases for MField.setColumn(MColumn column)
	 */
	@Test
	public void testSetColumn() {
		try {
			MWindow window = new MWindow(ctx, 0, getTrxName());
			String unique = "T_" + System.currentTimeMillis();
			window.setName("Test Window " + unique);
			window.setWindowType(MWindow.WINDOWTYPE_Maintain);
			assertTrue(window.save());
			
			MTab tab = new MTab(window);
			tab.setAD_Table_ID(MUser.Table_ID);
			tab.setName("Test Tab " + unique);
			tab.setSeqNo(10);
			assertTrue(tab.save());
			
			MColumn column = MColumn.get(DictionaryIDs.AD_Column.USER_NAME.id);
			MField field = new MField(tab);
			field.setColumn(column);
			assertEquals(column.getAD_Column_ID(), field.getAD_Column_ID());
	        assertEquals(column.getName(), field.getName());
	        assertEquals(column.getDescription(), field.getDescription());
	        assertEquals(column.getHelp(), field.getHelp());
	        assertEquals(column.getFieldLength(), field.getDisplayLength());
	        assertEquals(column.getEntityType(), field.getEntityType());
	    } finally {
	        rollback();
	    }
	}
	
	/**
	 * Test cases for MField.beforeSave(boolean newRecord)
	 */
	@Test
	public void testBeforeSave() {
	    try {
	    	MWindow window = new MWindow(ctx, 0, getTrxName());
			String unique = "T_" + System.currentTimeMillis();
			window.setName("Test Window " + unique);
			window.setWindowType(MWindow.WINDOWTYPE_Maintain);
			assertTrue(window.save());
			
			MTab tab = new MTab(window);
			tab.setAD_Table_ID(MUser.Table_ID);
			tab.setName("Test Tab " + unique);
			tab.setSeqNo(10);
			assertTrue(tab.save());
			
			MColumn column = MColumn.get(ctx, DictionaryIDs.AD_Column.USER_NAME.id, getTrxName());
			MField field = new MField(tab);
		    field.setAD_Column_ID(column.getAD_Column_ID());
		    field.setIsAllowCopy("Y");
		    field.setAD_Reference_ID(0);
		    field.setIsToolbarButton("Y");
		    field.setIsDisplayed(true);
		    field.setReadOnlyLogic("1=1");
		    field.setDisplayLogic("1=1");
		    field.setMandatoryLogic("1=1");
		    field.setIsActive(true);
	        assertTrue(field.save());
	        
	        M_Element element = M_Element.getOfColumn(ctx, column.getAD_Column_ID());
	        assertEquals(element.getName(), field.getName());
	        assertEquals(element.getDescription(), field.getDescription());
	        assertEquals(element.getHelp(), field.getHelp());

	        // Validate IsAllowCopy reset
	        assertEquals("Y", field.getIsAllowCopy());

	        // Validate reference IDs reset
	        assertEquals(0, field.getAD_Reference_Value_ID());
	        assertEquals(0, field.getAD_Val_Rule_ID());
	        assertNull(field.getIsToolbarButton());

	        // Validate logic expressions evaluated without exceptions
	        field.setReadOnlyLogic("1=1");
	        field.setDisplayLogic("1=1");
	        field.setMandatoryLogic("1=1");
	        assertTrue(field.save());
	    } finally {
	        rollback();
	    }
	}
}
