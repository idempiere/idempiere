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
 * - hengsin                                                                                               *
 **********************************************************************/
package org.idempiere.test.adwindow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.compiere.model.GridFieldVO;
import org.compiere.model.MUserDefProcParameter;
import org.compiere.model.MUserDefField;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

public class GridFieldVOTest extends AbstractTestCase {

    @Test
    void testCreateParameter() throws SQLException {
        Properties ctx = Env.getCtx();
        int windowNo = 1;
        int tabNo = 1;
        int adWindowId = 100;
        int adInfoWindowId = 101;

        ResultSet rs = mock(ResultSet.class);
        when(rs.getString(anyString())).thenReturn("N"); // For IsEncrypted and others not explicitly set
        when(rs.getString("ColumnName")).thenReturn("TestColumn");
        when(rs.getString("Name")).thenReturn("Test Name");
        when(rs.getString("Description")).thenReturn("Test Description");
        when(rs.getString("Help")).thenReturn("Test Help");
        when(rs.getInt("AD_Reference_ID")).thenReturn(10);
        when(rs.getInt("AD_Reference_Value_ID")).thenReturn(11);
        when(rs.getString("IsMandatory")).thenReturn("Y");
        when(rs.getString("IsRange")).thenReturn("N");
        when(rs.getString("DefaultValue")).thenReturn("Default");
        when(rs.getString("DefaultValue2")).thenReturn("Default2");
        when(rs.getString("VFormat")).thenReturn("");
        when(rs.getInt("ValueMin")).thenReturn(1);
        when(rs.getInt("ValueMax")).thenReturn(100);
        when(rs.getInt("FieldLength")).thenReturn(50);
        when(rs.getString("ReadOnlyLogic")).thenReturn("");
        when(rs.getString("DisplayLogic")).thenReturn("");
        when(rs.getInt("AD_Process_Para_ID")).thenReturn(102);
        when(rs.getString("EntityType")).thenReturn("U");
        when(rs.getString("ColumnSQL")).thenReturn("");
        when(rs.getString("InfoFactoryClass")).thenReturn("");        

        GridFieldVO vo = GridFieldVO.createParameter(ctx, windowNo, tabNo, 0, adWindowId, adInfoWindowId, rs);

        assertNotNull(vo);
        assertEquals(ctx, vo.ctx);
        assertEquals(windowNo, vo.WindowNo);
        assertEquals(tabNo, vo.TabNo);
        assertEquals(adWindowId, vo.AD_Window_ID_Of_Panel);
        assertEquals(adInfoWindowId, vo.AD_InfoWindow_ID_Of_Panel);
        assertTrue(vo.isProcess);
        assertEquals("TestColumn", vo.ColumnName);
        assertEquals("Test Name", vo.Header);
        assertEquals("Test Description", vo.Description);
        assertEquals("Test Help", vo.Help);
        assertEquals(10, vo.displayType);
        assertEquals(11, vo.AD_Reference_Value_ID);
        assertTrue(vo.IsMandatory);
        assertEquals("Default", vo.DefaultValue);
        assertEquals("Default2", vo.DefaultValue2);
        assertEquals(50, vo.FieldLength);
        assertEquals(102, vo.AD_Column_ID);
    }

    @Test
    void testAfterCreate() throws SQLException {
        Properties ctx = Env.getCtx();
        ResultSet rs = mock(ResultSet.class);
        when(rs.getString(anyString())).thenReturn("N");
        when(rs.getInt("AD_Field_ID")).thenReturn(999);

        try (MockedStatic<MUserDefField> mUserDefField = Mockito.mockStatic(MUserDefField.class)) {
            MUserDefField userDef = mock(MUserDefField.class);
            when(userDef.getDisplayLogic()).thenReturn("@Test@='Y'");
            when(userDef.getReadOnlyLogic()).thenReturn("@TestRO@='Y'");
            when(userDef.getDefaultValue()).thenReturn("DefaultValue");
            when(userDef.getMandatoryLogic()).thenReturn("@TestMandatory@='Y'");
            mUserDefField.when(() -> MUserDefField.get(ctx, 999, 0, 0)).thenReturn(userDef);

            GridFieldVO vo = GridFieldVO.createFromResultSet(ctx, 0, 0, 0, 0, false, rs);
            vo.afterCreate();

            assertEquals("@Test@='Y'", vo.DisplayLogic);
            assertEquals("@TestRO@='Y'", vo.ReadOnlyLogic);
            assertEquals("DefaultValue", vo.DefaultValue);
            assertEquals("@TestMandatory@='Y'", vo.MandatoryLogic);
        }
    }

    @Test
    void testCreateParameterForInfoWindow() {
        Properties ctx = Env.getCtx();
        int windowNo = 1;
        int windowIdOfPanel = 100;
        int infoWindowId = 101;
        int adColumnId = 12;
        String columnName = "TestColumn";
        String name = "Test Name";
        int adReferenceId = 10;
        int adReferenceValueId = 11;
        boolean isMandatory = true;
        boolean isEncrypted = false;
        String placeholder = "Test Placeholder";
        String entityType = "U";

        // Test the overload without EntityType
        GridFieldVO vo1 = GridFieldVO.createParameter(ctx, windowNo, windowIdOfPanel, infoWindowId, adColumnId, columnName, name, adReferenceId, adReferenceValueId, isMandatory, isEncrypted, placeholder);

        assertNotNull(vo1);
        assertTrue(vo1.isProcess);
        assertEquals(windowNo, vo1.WindowNo);
        assertEquals(windowIdOfPanel, vo1.AD_Window_ID_Of_Panel);
        assertEquals(infoWindowId, vo1.AD_InfoWindow_ID_Of_Panel);
        assertEquals(adColumnId, vo1.AD_Column_ID);
        assertEquals(columnName, vo1.ColumnName);
        assertEquals(name, vo1.Header);
        assertEquals(adReferenceId, vo1.displayType);
        assertEquals(adReferenceValueId, vo1.AD_Reference_Value_ID);
        assertEquals(isMandatory, vo1.IsMandatory);
        assertEquals(isEncrypted, vo1.IsEncryptedField);
        assertEquals(placeholder, vo1.Placeholder);
        assertEquals("", vo1.EntityType);

        // Test the overload with EntityType
        GridFieldVO vo2 = GridFieldVO.createParameter(ctx, windowNo, windowIdOfPanel, infoWindowId, adColumnId, columnName, name, adReferenceId, adReferenceValueId, isMandatory, isEncrypted, placeholder, entityType);

        assertNotNull(vo2);
        assertEquals(entityType, vo2.EntityType);
    }

    @Test
    void testCreateParameterFromVO() throws SQLException {
        Properties ctx = Env.getCtx();
        ResultSet rs = mock(ResultSet.class);
        when(rs.getString("ColumnName")).thenReturn("FromColumn");
        when(rs.getString("Name")).thenReturn("From Header");
        when(rs.getString("Description")).thenReturn("From Description");
        when(rs.getString("Help")).thenReturn("From Help");
        when(rs.getInt("AD_Reference_ID")).thenReturn(DisplayType.String);
        when(rs.getInt("AD_Reference_Value_ID")).thenReturn(202);
        when(rs.getInt("AD_Column_ID")).thenReturn(201);
        when(rs.getString("IsMandatory")).thenReturn("Y");
        when(rs.getString("IsRange")).thenReturn("Y");
        when(rs.getString("DefaultValue")).thenReturn("FromDefault");
        when(rs.getString("DefaultValue2")).thenReturn("ToDefault");
        when(rs.getString("VFormat")).thenReturn("FromVFormat");
        when(rs.getString("ValueMin")).thenReturn("0");
        when(rs.getString("ValueMax")).thenReturn("100");
        when(rs.getInt("FieldLength")).thenReturn(50);
        when(rs.getString("ReadOnlyLogic")).thenReturn("FromReadOnlyLogic");
        when(rs.getString("DisplayLogic")).thenReturn("FromDisplayLogic");
        when(rs.getInt("AD_Process_ID")).thenReturn(203);
        when(rs.getString("EntityType")).thenReturn("U");
        when(rs.getString("ColumnSQL")).thenReturn("");
        when(rs.getString("InfoFactoryClass")).thenReturn("");
        when(rs.getString("IsEncrypted")).thenReturn("Y");
        when(rs.getString("FormatPattern")).thenReturn("FromFormatPattern");
        when(rs.getString("DateRangeOption")).thenReturn("D");
        when(rs.getString("Placeholder")).thenReturn("FromPlaceholder");
        when(rs.getString("Placeholder2")).thenReturn("ToPlaceholder");
        when(rs.getString("ValidationCode")).thenReturn("FromValidation");
        when(rs.getString("ValidationCodeLookup")).thenReturn("FromValidationLookup");
        
        GridFieldVO voF = GridFieldVO.createParameter(ctx, 1, 1, 100, 101, rs);
        voF.AD_Table_ID = 200;
        voF.AD_Process_ID_Of_Panel = 203;

        GridFieldVO voT = GridFieldVO.createParameter(voF);

        assertNotNull(voT);
        assertTrue(voT.isProcess);
        assertEquals(voF.WindowNo, voT.WindowNo);
        assertEquals(voF.TabNo, voT.TabNo);
        assertEquals(voF.AD_Window_ID, voT.AD_Window_ID);
        assertEquals(voF.AD_Tab_ID, voT.AD_Tab_ID);
        assertEquals(voF.tabReadOnly, voT.tabReadOnly);
        assertEquals(voF.AD_Table_ID, voT.AD_Table_ID);
        assertEquals(voF.AD_Column_ID, voT.AD_Column_ID);
        assertEquals(voF.ColumnName, voT.ColumnName);
        assertEquals(voF.Header, voT.Header);
        assertEquals(voF.Description, voT.Description);
        assertEquals(voF.Help, voT.Help);
        assertEquals(voF.displayType, voT.displayType);
        assertEquals(voF.IsMandatory, voT.IsMandatory);
        assertEquals(voF.FieldLength, voT.FieldLength);
        assertEquals(voF.DefaultValue2, voT.DefaultValue);
        assertEquals(voF.Placeholder2, voT.Placeholder);
        assertEquals(voF.VFormat, voT.VFormat);
        assertEquals(voF.FormatPattern, voT.FormatPattern);
        assertEquals(voF.ValueMin, voT.ValueMin);
        assertEquals(voF.ValueMax, voT.ValueMax);
        assertEquals(voF.isRange, voT.isRange);
        assertEquals(voF.dateRangeOption, voT.dateRangeOption);
        assertEquals(voF.EntityType, voT.EntityType);
        assertEquals(voF.AD_Reference_Value_ID, voT.AD_Reference_Value_ID);
        assertEquals(voF.ValidationCode, voT.ValidationCode);
        assertEquals(voF.ValidationCodeLookup, voT.ValidationCodeLookup);
        assertEquals(voF.IsEncryptedField, voT.IsEncryptedField);
        assertEquals(voF.ReadOnlyLogic, voT.ReadOnlyLogic);
        assertEquals(voF.DisplayLogic, voT.DisplayLogic);
        assertEquals(voF.AD_Process_ID_Of_Panel, voT.AD_Process_ID_Of_Panel);
    }
    
    @Test
	void testUserDefProceParameter() throws Exception {
		Properties ctx = Env.getCtx();
		try (MockedStatic<MUserDefProcParameter> mUserDefProcParameter = Mockito.mockStatic(MUserDefProcParameter.class)) {

			ResultSet rs = mock(ResultSet.class);
			when(rs.getInt(anyString())).thenReturn(0);
			when(rs.getString(anyString())).thenReturn("");
			when(rs.getString("ColumnName")).thenReturn("Name");
			when(rs.getInt("AD_Process_Para_ID")).thenReturn(123);
			
			MUserDefProcParameter userDef = mock(MUserDefProcParameter.class);
			when(userDef.getDisplayLogic()).thenReturn("@Test@='Y'");
			when(userDef.getReadOnlyLogic()).thenReturn("@TestRO@='Y'");
			when(userDef.getDefaultValue()).thenReturn("DefaultValue");
			when(userDef.getMandatoryLogic()).thenReturn("@TestMandatory@='Y'");
			mUserDefProcParameter.when(() -> MUserDefProcParameter.get(ctx, 123, 123)).thenReturn(userDef);

			GridFieldVO vo = GridFieldVO.createParameter(ctx, 100, 123, 100, 100, rs);
			assertEquals("@Test@='Y'", vo.DisplayLogic);
			assertEquals("@TestRO@='Y'", vo.ReadOnlyLogic);
			assertEquals("DefaultValue", vo.DefaultValue);
			assertEquals("@TestMandatory@='Y'", vo.MandatoryLogic);
		}
	}
}
