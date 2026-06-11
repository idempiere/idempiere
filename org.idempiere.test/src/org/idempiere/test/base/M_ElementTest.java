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
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MColumn;
import org.compiere.model.MField;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MTest;
import org.compiere.model.M_Element;
import org.compiere.model.SystemIDs;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
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
	 * Test UUID-based constructor: M_Element(Properties ctx, String AD_Element_UU, String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		M_Element e = new M_Element(ctx, testElementUUID, getTrxName());
		assertNotNull(e, "M_Element constructed by UUID should not be null");
		assertEquals(testElementId, e.getAD_Element_ID(), "M_Element loaded by UUID should map to same AD_Element_ID");
	}

	/**
	 * Test ResultSet-based constructor: M_Element(Properties ctx, ResultSet rs, String trxName)
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
			DB.close(rs, pstmt);
		}
	}

	/**
	 * Test static get(ctx, columnName), get(ctx, columnName, trxName) and getColumnName(columnName, trxName) behaviour.
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
		
		assertNull(M_Element.getColumnName(null, getTrxName()));
		assertEquals("", M_Element.getColumnName("", getTrxName()));
	}

	/**
	 * Test getOfColumn(ctx, AD_Column_ID) helper.
	 */
	@Test
	public void testGetOfColumn() {
		int adColumnId = DictionaryIDs.AD_Column.TEST_NAME.id;
		M_Element e = M_Element.getOfColumn(ctx, adColumnId);
		assertNotNull(e, "getOfColumn should return an M_Element for a valid AD_Column_ID");
	}

	/**
	 * Test getColumnName(columnName) static helper
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
		String unique = "T_" + System.currentTimeMillis();
		try {
			e.setColumnName("TestColumnName_" + unique);
			e.setName("Test Element " + unique);
			e.setPrintName("Test Element " + unique);
			boolean saved = e.save();
			assertTrue(saved, "New AD_Element should save when mandatory fields are provided");
			assertTrue(e.get_ID() > 0, "Saved AD_Element must have assigned AD_Element_ID");
		} finally {
			rollback();
		}
	}

	/**
     * Verifies that the constructor correctly initializes the column name,
     * name, print name, and entity type fields, and that the new object is
     * created with an ID of 0 (not yet persisted).
     */
    @Test
    public void testConstructorInitializesFieldsCorrectly() {
    	String columnName = "TestColumnName";
        String entityType = M_Element.ENTITYTYPE_UserMaintained;
        M_Element element = new M_Element(ctx, columnName, entityType, getTrxName());
        assertEquals(columnName, element.getColumnName(), "ColumnName should be initialized");
        assertEquals(columnName, element.getName(), "Name should match column name");
        assertEquals(columnName, element.getPrintName(), "PrintName should match column name");
        assertEquals(entityType, element.getEntityType(), "EntityType should be set");
        assertEquals(0, element.get_ID(), "Element should not be persisted and ID should be 0");
    }
    
    /**
     * Ensures that beforeSave returns false when creating a new M_Element
     * with a duplicate ColumnName (case-insensitive match).
     */
    @Test
    public void testBeforeSaveFailsWhenDuplicateNewRecord() {
        M_Element existing = null;
        M_Element duplicate = null;
		String unique = "T_" + System.currentTimeMillis();
        String columnName = "TestColumnName_" + unique;
        String name = "Test Element " + unique;
        String entityType = M_Element.ENTITYTYPE_UserMaintained;
        try {
            existing = new M_Element(ctx, 0, getTrxName());
            existing.setColumnName(columnName);
            existing.setName(name);
            existing.setPrintName(name);
            existing.setEntityType(entityType);
            assertTrue(existing.save(), "New record should save successfully");

            duplicate = new M_Element(ctx, 0, getTrxName());
            duplicate.setColumnName(columnName.toUpperCase());
            duplicate.setName(name);
            duplicate.setPrintName(name);
            duplicate.setEntityType(entityType);
            boolean result = duplicate.save();
            assertFalse(result, "beforeSave must reject duplicate column names");
        } finally {
        	rollback();
        }
    }

    /**
     * Ensures that beforeSave returns false when modifying an existing
     * M_Element to have a duplicate ColumnName.
     */
    @Test
    public void testBeforeSaveFailsWhenRenamingToDuplicate() {
        M_Element base = null;
        M_Element toModify = null;
        String unique = "T_" + System.currentTimeMillis();
        String columnName = "TestColumnName_" + unique;
        String name = "Test Element " + unique;
        String entityType = M_Element.ENTITYTYPE_UserMaintained;
        try {
            base = new M_Element(ctx, 0, getTrxName());
            base.setColumnName(columnName);
            base.setName(name);
            base.setPrintName(name);
            base.setEntityType(entityType);
            assertTrue(base.save(), "Base record should save successfully");

            toModify = new M_Element(ctx, 0, getTrxName());
            toModify.setColumnName(columnName+"2");
            toModify.setName(name);
            toModify.setPrintName(name);
            toModify.setEntityType(entityType);
            assertTrue(toModify.save(), "Record to modify should save successfully");
            toModify.setColumnName(columnName);
            assertFalse(toModify.save(), "beforeSave should detect duplicate on update");
        } finally {
        	rollback();
        }
    }

    /**
     * Ensures that beforeSave trims leading/trailing spaces from ColumnName
     * and proceeds successfully if the trimmed value is unique.
     */
    @Test
    public void testBeforeSaveTrimsColumnName() {
        M_Element element = null;
        String unique = "T_" + System.currentTimeMillis();
        String columnName = "TestColumnName_" + unique;
        String name = "Test Element " + unique;
        try {
            element = new M_Element(ctx, 0, getTrxName());
            element.setColumnName("   " + columnName + "   ");
            element.setName(name);
            element.setPrintName(name);
            element.setEntityType(M_Element.ENTITYTYPE_UserMaintained);
            assertTrue(element.save(), "beforeSave should allow valid trimmed name");
            assertEquals(columnName, element.getColumnName());
        } finally {
        	rollback();
        }
    }

    /**
     * Ensures that beforeSave rejects ColumnName values that are not valid
     * database identifiers (e.g., containing spaces or invalid characters).
     */
    @Test
    public void testBeforeSaveRejectsInvalidIdentifier() {
    	try {
			String unique = "T_" + System.currentTimeMillis();
		    String columnName = "Test Column Name " + unique;
		    String name = "Test Element " + unique;
		    M_Element element = new M_Element(ctx, 0, getTrxName());
		    element.setColumnName(columnName);
		    element.setName(name);
		    element.setPrintName(name);
		    element.setEntityType(M_Element.ENTITYTYPE_UserMaintained);
		    boolean result = element.save();
		    assertFalse(result, "beforeSave must reject invalid DB identifiers");
    	} finally {
        	rollback();
        }
    }
    
    /**
     * Verifies that afterSave updates related tables when Name, Description,
     * Help, Placeholder, or ColumnName changes in an existing M_Element.
     */
    @Test
    public void testAfterSaveUpdatesRelatedTables() {
        M_Element element = null;
        MColumn column = null;
        MProcess process = null;
        MProcessPara para = null;
        MInfoWindow infoWindow = null;
        MInfoColumn infoColumn = null;
        MField field = null;
        MPrintFormatItem printItem = null;
        String unique = "T_" + System.currentTimeMillis();
        String columnName = "TestColumnName_" + unique;
        String name = "TestColumnName_" + unique;
        String description = "Test Description";
        String help = "Test Help";
        String placeholder = "Test Placeholder";
        String printName = "Test Print Name";
        try {
            element = new M_Element(ctx, 0, getTrxName());
            element.setColumnName(columnName);
            element.setName(name);
            element.setDescription(description);
            element.setHelp(help);
            element.setPlaceholder(placeholder);
            element.setPrintName(printName);
            element.setEntityType(M_Element.ENTITYTYPE_UserMaintained);
            assertTrue(element.save(), "M_Element must save");

            int elementId = element.get_ID();
            
            column = new MColumn(ctx, 0, getTrxName());
            column.setAD_Table_ID(MTest.Table_ID);
            column.setAD_Element_ID(elementId);
            column.setColumnName(columnName);
            column.setName(name);
            column.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            column.setFieldLength(60);
            assertTrue(column.save(), "MColumn must save");

            process = MProcess.getCopy(ctx, DictionaryIDs.AD_Process.CACHE_RESET.id, getTrxName());
    		process.setName("Test Process " + unique);
			assertTrue(process.save(), "MProcess must save");
			
            para = new MProcessPara(ctx, 0, getTrxName());
            para.setAD_Process_ID(process.get_ID());
            para.setAD_Element_ID(elementId);
            para.setColumnName(columnName);
            para.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para.setFieldLength(60);
            para.setIsCentrallyMaintained(true);
            assertTrue(para.save(), "MProcessPara must save");

            infoWindow = new MInfoWindow(Env.getCtx(), 0, getTrxName());
    		infoWindow.setAD_Table_ID(MTest.Table_ID);
    		infoWindow.setName("Test Info Window " + unique);
    		infoWindow.setFromClause("Test t");
    		assertTrue(infoWindow.save(), "MInfoWindow must save");
    		
            infoColumn = new MInfoColumn(ctx, 0, getTrxName());
            infoColumn.setAD_InfoWindow_ID(infoWindow.get_ID());
            infoColumn.setAD_Element_ID(elementId);
            infoColumn.setColumnName(column.getColumnName());
            infoColumn.setSelectClause("t." + MTest.COLUMNNAME_Name);
            infoColumn.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            infoColumn.setIsCentrallyMaintained(true);
            assertTrue(infoColumn.save(), "MInfoColumn must save");

            field = new MField(ctx, 0, getTrxName());
            field.setAD_Tab_ID(DictionaryIDs.AD_Tab.TEST_TEST.id);
            field.setAD_Column_ID(column.getAD_Column_ID());
            field.setIsCentrallyMaintained(true);
            assertTrue(field.save(), "MField must save");

            MPrintFormat printFormat = new MPrintFormat(ctx, DictionaryIDs.AD_PrintFormat.TEST_REPORT.id, getTrxName());
            printItem = MPrintFormatItem.createFromColumn(printFormat, column.getAD_Column_ID(), 1000);
            assertTrue(printItem.get_ID() > 0, "MPrintFormatItem must save");
            
            // new columnName
            String newColumnName = "New" + columnName;
            element.setColumnName(newColumnName);
            boolean result = element.save();
            assertTrue(result, "afterSave should return true when success=true");
            
            column.load(getTrxName());
            assertEquals(newColumnName, column.getColumnName());

            para.load(getTrxName());
            assertEquals(newColumnName, para.getColumnName());

            infoColumn.load(getTrxName());
            assertEquals(newColumnName, infoColumn.getColumnName());
            
            // new Name
            String newName = "New" + name;
            element.setName(newName);
            result = element.save();
            assertTrue(result, "afterSave should return true when success=true");
            
            column.load(getTrxName());
            assertEquals(newColumnName, column.getColumnName());
            assertEquals(newName, column.getName());

            para.load(getTrxName());
            assertEquals(newColumnName, para.getColumnName());
            assertEquals(newName, para.getName());

            infoColumn.load(getTrxName());
            assertEquals(newColumnName, infoColumn.getColumnName());
            assertEquals(newName, infoColumn.getName());

            field.load(getTrxName());
            assertEquals(newName, field.getName());

            printItem.load(getTrxName());
            assertEquals(newName, printItem.getName());
            
            String newDescription = "New" + description;
            String newHelp = "New" + help;
            String newPlaceholder = "New" + placeholder;
            String newPrintName = "New" + printName;
            element.setColumnName(newColumnName);
            element.setName(newName);
            element.setDescription(newDescription);
            element.setHelp(newHelp);
            element.setPlaceholder(newPlaceholder);
            element.setPrintName(newPrintName);
            result = element.save();
            assertTrue(result, "afterSave should return true when success=true");

            column.load(getTrxName());
            assertEquals(newColumnName, column.getColumnName());
            assertEquals(newName, column.getName());
            assertEquals(newDescription, column.getDescription());
            assertEquals(newHelp, column.getHelp());
            assertEquals(newPlaceholder, column.getPlaceholder());

            para.load(getTrxName());
            assertEquals(newColumnName, para.getColumnName());
            assertEquals(newName, para.getName());
            assertEquals(newDescription, para.getDescription());
            assertEquals(newHelp, para.getHelp());
            assertEquals(newPlaceholder, para.getPlaceholder());

            infoColumn.load(getTrxName());
            assertEquals(newColumnName, infoColumn.getColumnName());
            assertEquals(newName, infoColumn.getName());
            assertEquals(newDescription, infoColumn.getDescription());
            assertEquals(newHelp, infoColumn.getHelp());
            assertEquals(newPlaceholder, infoColumn.getPlaceholder());

            field.load(getTrxName());
            assertEquals(newName, field.getName());
            assertEquals(newDescription, field.getDescription());
            assertEquals(newHelp, field.getHelp());
            assertEquals(newPlaceholder, field.getPlaceholder());

            printItem.load(getTrxName());
            assertEquals(newPrintName, printItem.getPrintName());
            assertEquals(newName, printItem.getName());
        } finally {
        	rollback();
        }
    }
    
    /**
	 * Test renameDBColumn(String newColumnName, ProcessInfo pi).
	 */
	@Test
	public void testRenameDBColumn() {
		M_Element e = new M_Element(ctx, 0, getTrxName());
		String unique = "T_" + System.currentTimeMillis();
		try {
			e.setColumnName("TestColumnName_" + unique);
			e.setName("Test Element " + unique);
			e.setPrintName("Test Element " + unique);
			boolean saved = e.save();
			assertTrue(saved, "New AD_Element should save when mandatory fields are provided");
			assertTrue(e.get_ID() > 0, "Saved AD_Element must have assigned AD_Element_ID");
			
			String newColumnName = "NewTestColumnName_" + unique;
			e.renameDBColumn(newColumnName, null);
			assertEquals(newColumnName, e.getColumnName(), "ColumnName must match");
		} finally {
			rollback();
		}
	}
}
