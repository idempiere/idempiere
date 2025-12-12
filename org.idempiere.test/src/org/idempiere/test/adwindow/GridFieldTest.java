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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.adwindow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNotSame;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.beans.PropertyChangeListener;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridTab;
import org.compiere.model.MColumn;
import org.compiere.model.MRole;
import org.compiere.model.MTest;
import org.compiere.model.MUserDefField;
import org.compiere.model.SystemIDs;
import org.compiere.util.CPreparedStatement;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import org.adempiere.base.LookupFactoryHelper;
import org.compiere.model.Lookup;
import org.compiere.model.MBPartner;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MQuery;
import org.compiere.model.MTab;
import org.compiere.model.X_AD_Table;

@ExtendWith(MockitoExtension.class)
public class GridFieldTest extends AbstractTestCase {
	
	@SuppressWarnings("serial")
	private class GridFieldExposed extends GridField {
		public GridFieldExposed(GridFieldVO vo) {
			super(vo);
		}

		@Override
		public Object defaultFromPreferenceForPanel() {
			return super.defaultFromPreferenceForPanel();
		}

		@Override
		protected Object defaultForClientOrg() {
			return super.defaultForClientOrg();
		}

		@Override
		protected Object defaultFromExpression() {
			return super.defaultFromExpression();
		}
	}
		
	private GridField createField(Properties ctx, int windowNo, int tabNo, String columnName, String header, int displayType, boolean isReadOnly, 
			boolean isUpdateable, boolean isMandatory) {
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.WindowNo = windowNo;
		vo.TabNo = tabNo;
		vo.AD_Window_ID = SystemIDs.WINDOW_TEST;
		vo.AD_Tab_ID = 152; //Test Tab in Test Window
		vo.AD_Table_ID = MTest.Table_ID;
		vo.AD_Column_ID = MColumn.getColumn_ID(MTest.Table_Name, columnName);
		vo.ColumnName = columnName;
		vo.tabReadOnly = false;
		vo.Header = header;
		vo.displayType = displayType;
		vo.IsReadOnly = isReadOnly;
		vo.ReadOnlyLogic = "";
		vo.IsUpdateable = isUpdateable;
		vo.IsMandatory = isMandatory;
		vo.AlwaysUpdatableLogic = "";
		vo.IsDisplayed = true;
		vo.DisplayLogic = "";
		return new GridField(vo);
	}
	
	@Test
	void testIsEditable() {
		Properties ctx = Env.getCtx();
		GridField gridField = createField(ctx, 100, 100, "Name", "Name", DisplayType.String, false, true, false);
		GridFieldVO vo = gridField.getVO();
		setupGridFieldAndContext(gridField, vo);
		
		// Test case 1: Virtual column should not be editable
		vo.ColumnSQL = "@SQL=SELECT 1";
		assertFalse(gridField.isEditable(ctx, true, false), "Virtual column should not be editable");
		vo.ColumnSQL = null;

		// Test case 2: Locked record should not be editable
		gridField.setLockedRecord(true);
		assertFalse(gridField.isEditable(ctx, true, false), "Locked record should not be editable");
		gridField.setLockedRecord(false);

		// Test case 3: 'Posted' column should be editable
		vo.ColumnName = "Posted";
		assertTrue(gridField.isEditable(ctx, true, false), "'Posted' column should be editable");
		vo.ColumnName = "TestColumn";

		// Test case 3a: Button with process access
		vo.displayType = DisplayType.Button;
		vo.AD_Process_ID = 123;
		try (MockedStatic<MRole> mrole = Mockito.mockStatic(MRole.class)) {
			MRole role = mock(MRole.class);
			mrole.when(() -> MRole.getDefault()).thenReturn(role);
			mrole.when(() -> MRole.getDefault(any(), anyBoolean())).thenReturn(role);
			when(role.isColumnAccess(anyInt(), anyInt(), anyBoolean())).thenReturn(true);
			when(role.canUpdate(anyInt(), anyInt(), anyInt(), anyInt(), anyBoolean())).thenReturn(true);
			
			when(role.getProcessAccess(123)).thenReturn(true);
			assertTrue(gridField.isEditable(ctx, true, false), "Button with process access should be editable");

			when(role.getProcessAccess(123)).thenReturn(false);
			assertFalse(gridField.isEditable(ctx, true, false), "Button without process access should not be editable");
			
			when(role.getProcessAccess(123)).thenReturn(null);
			assertFalse(gridField.isEditable(ctx, true, false), "Button without process access should not be editable");
		}
		vo.AD_Process_ID = 0;

		// Test case 3b: Button with info window access
		vo.AD_InfoWindow_ID = 456;
		try (MockedStatic<MRole> mrole = Mockito.mockStatic(MRole.class)) {
			MRole role = mock(MRole.class);
			mrole.when(() -> MRole.getDefault()).thenReturn(role);
			mrole.when(() -> MRole.getDefault(any(), anyBoolean())).thenReturn(role);
			when(role.isColumnAccess(anyInt(), anyInt(), anyBoolean())).thenReturn(true);
			when(role.canUpdate(anyInt(), anyInt(), anyInt(), anyInt(), anyBoolean())).thenReturn(true);
			
			when(role.getInfoAccess(456)).thenReturn(true);
			assertTrue(gridField.isEditable(ctx, true, false), "Button with info window access should be editable");

			when(role.getInfoAccess(456)).thenReturn(false);
			assertFalse(gridField.isEditable(ctx, true, false), "Button without info window access should not be editable");
			
			when(role.getInfoAccess(456)).thenReturn(null);
			assertFalse(gridField.isEditable(ctx, true, false), "Button without info window access should not be editable");
		}
		vo.AD_InfoWindow_ID = 0;
		vo.displayType = 1;

		// Test case 4: Tab or field is read-only
		vo.tabReadOnly = true;
		assertFalse(gridField.isEditable(ctx, true, false), "Read-only tab should not be editable");
		vo.tabReadOnly = false;
		vo.IsReadOnly = true;
		assertFalse(gridField.isEditable(ctx, true, false), "Read-only field should not be editable");
		vo.IsReadOnly = false;

		// Test case 5: Always updatable field should be editable
		vo.IsAlwaysUpdateable = true;
		assertTrue(gridField.isEditable(ctx, true, false), "Always updatable field should be editable");
		vo.IsAlwaysUpdateable = false;

		// Test case 5a: Always updatable logic evaluates to true
		vo.IsUpdateable = false;
		vo.AlwaysUpdatableLogic = "@#AlwaysUpdate@=Y";
		Env.setContext(ctx, "#AlwaysUpdate", "Y");
		assertTrue(gridField.isEditable(ctx, true, false), "Always updatable logic should make field editable even if IsUpdateable is false");
		Env.setContext(ctx, "#AlwaysUpdate", "N");
		assertFalse(gridField.isEditable(ctx, true, false), "Always updatable logic not met should not make field editable if IsUpdateable is false");
		vo.AlwaysUpdatableLogic = "";
		vo.IsUpdateable = true;

		// Test case 6: Not updatable and not inserting
		vo.IsUpdateable = false;
		gridField.setInserting(false);
		assertFalse(gridField.isEditable(ctx, true, false), "Not updatable and not inserting should not be editable");
		vo.IsUpdateable = true;

		// Test case 7: Link column should not be editable
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_LinkColumnName, "TestColumn");
		assertFalse(gridField.isEditable(ctx, true, false), "Link column should not be editable");
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_LinkColumnName, (String) null);

		// Test case 8: Read-only logic evaluates to true
		vo.ReadOnlyLogic = "@#IsReadOnly@=Y";
		Env.setContext(ctx, "#IsReadOnly", "Y");
		assertFalse(gridField.isEditable(ctx, true, false), "Read-only logic should make field not editable");
		Env.setContext(ctx, "#IsReadOnly", "N");
		assertTrue(gridField.isEditable(ctx, true, false), "Read-only logic not met should be editable");
		vo.ReadOnlyLogic = "";

		// Test case 8a: Read-only logic with VIRTUAL_UI_COLUMN_PREFIX
		vo.ReadOnlyLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "some_sql_logic";
		try (MockedStatic<Evaluator> evaluator = Mockito.mockStatic(Evaluator.class)) {
			evaluator.when(() -> Evaluator.parseSQLLogic(vo.ReadOnlyLogic, ctx, vo.WindowNo, vo.TabNo, vo.ColumnName))
				.thenReturn(true);
			assertFalse(gridField.isEditable(ctx, true, false), "Read-only logic with VIRTUAL_UI_COLUMN_PREFIX should make field not editable");

			evaluator.when(() -> Evaluator.parseSQLLogic(vo.ReadOnlyLogic, ctx, vo.WindowNo, vo.TabNo, vo.ColumnName))
				.thenReturn(false);
			assertTrue(gridField.isEditable(ctx, true, false), "Read-only logic with VIRTUAL_UI_COLUMN_PREFIX not met should be editable");
		}
		vo.ReadOnlyLogic = "";

		// Test case 9: Processed record
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "Processed", "Y");
		assertFalse(gridField.isEditable(ctx, true, false), "Processed record should not be editable");
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "Processed", "N");
		
		// Test case 10: IsActive field should be editable if not processed
		vo.ColumnName = "IsActive";
		assertTrue(gridField.isEditable(ctx, true, false), "'IsActive' field should be editable");
		vo.ColumnName = "TestColumn";
		
		// Test case 11: Record is not active
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "IsActive", "N");
		assertFalse(gridField.isEditable(ctx, true, false), "Inactive record should not be editable");
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "IsActive", "Y");
		
		// Default case: should be editable
		assertTrue(gridField.isEditable(ctx, true, false), "Default case should be editable");
		
	}

	private void setupGridFieldAndContext(GridField gridField, GridFieldVO vo) {
		GridTab gridTab = mock(GridTab.class);
		gridField.setGridTab(gridTab);		
		when(gridTab.isReadOnly()).thenReturn(false);
		Env.setContext(Env.getCtx(), 100, MTest.COLUMNNAME_Test_ID, 200003); // Test Record
		Env.setContext(Env.getCtx(), 100, 100, MTest.COLUMNNAME_Test_ID, 200003); // Test Record
		Env.setContext(Env.getCtx(), 100, 100, GridTab.CTX_KeyColumnName, MTest.COLUMNNAME_Test_ID);
		Env.setContext(Env.getCtx(), vo.WindowNo, vo.TabNo, MTest.COLUMNNAME_IsActive, "Y");
	}
	
	@Test
	void testIsEditableGrid() {
		Properties ctx = Env.getCtx();
		GridField gridField = createField(ctx, 100, 100, "Name", "Name", 1, false, true, false);
		GridFieldVO vo = gridField.getVO();
		setupGridFieldAndContext(gridField, vo);
		
		// Test case 1: Virtual column should not be editable
		vo.ColumnSQL = "@SQL=SELECT 1";
		assertFalse(gridField.isEditable(ctx, true, true), "Virtual column should not be editable");
		vo.ColumnSQL = null;

		// Test case 2: Locked record should not be editable
		gridField.setLockedRecord(true);
		assertFalse(gridField.isEditable(ctx, true, true), "Locked record should not be editable");
		gridField.setLockedRecord(false);

		// Test case 3: 'Posted' column should be editable
		vo.ColumnName = "Posted";
		assertTrue(gridField.isEditable(ctx, true, true), "'Posted' column should be editable");
		vo.ColumnName = "TestColumn";

		// Test case 4: Tab or field is read-only
		vo.tabReadOnly = true;
		assertFalse(gridField.isEditable(ctx, true, true), "Read-only tab should not be editable");
		vo.tabReadOnly = false;
		vo.IsReadOnly = true;
		assertFalse(gridField.isEditable(ctx, true, true), "Read-only field should not be editable");
		vo.IsReadOnly = false;

		// Test case 5: Always updatable field should be editable
		vo.IsAlwaysUpdateable = true;
		assertTrue(gridField.isEditable(ctx, true, true), "Always updatable field should be editable");
		vo.IsAlwaysUpdateable = false;

		// Test case 6: Not updatable and not inserting
		vo.IsUpdateable = false;
		gridField.setInserting(false);
		assertFalse(gridField.isEditable(ctx, true, true), "Not updatable and not inserting should not be editable");
		gridField.setInserting(true);
		assertTrue(gridField.isEditable(ctx, true, true), "Not updatable but inserting should be editable");
		vo.IsUpdateable = true;

		// Test case 7: Link column should not be editable
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_LinkColumnName, "TestColumn");
		assertFalse(gridField.isEditable(ctx, true, true), "Link column should not be editable");
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_LinkColumnName, (String) null);

		// Test case 8: Read-only logic evaluates to true
		vo.ReadOnlyLogic = "@#IsReadOnly@=Y";
		Env.setContext(ctx, "#IsReadOnly", "Y");
		assertFalse(gridField.isEditable(ctx, true, true), "Read-only logic should make field not editable");
		Env.setContext(ctx, "#IsReadOnly", "N");
		assertTrue(gridField.isEditable(ctx, true, true), "Read-only logic not met should be editable");
		vo.ReadOnlyLogic = "";

		// Test case 9: Processed record
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "Processed", "Y");
		assertFalse(gridField.isEditable(ctx, true, true), "Processed record should not be editable");
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "Processed", "N");
		
		// Test case 10: IsActive field should be editable if not processed
		vo.ColumnName = "IsActive";
		assertTrue(gridField.isEditable(ctx, true, true), "'IsActive' field should be editable");
		vo.ColumnName = "TestColumn";
		
		// Test case 11: Record is not active
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "IsActive", "N");
		assertFalse(gridField.isEditable(ctx, true, true), "Inactive record should not be editable");
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "IsActive", "Y");
		
		// Default case: should be editable
		assertTrue(gridField.isEditable(ctx, true, true), "Default case should be editable");
	}
	
	@Test
	void testDefaultFromPreferenceForPanel() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "TestColumn";
		GridFieldExposed gridField = new GridFieldExposed(vo);
		
		try (MockedStatic<Env> env = Mockito.mockStatic(Env.class)) {
			// Test case 1: AD_Process_ID_Of_Panel > 0
			vo.AD_Process_ID_Of_Panel = 123;
			vo.AD_Window_ID_Of_Panel = 456;
			vo.AD_InfoWindow_ID_Of_Panel = 789;
			
			env.when(() -> Env.getPreference(ctx, 456, 789, 123, "TestColumn")).thenReturn("Value1");
			assertEquals("Value1", gridField.defaultFromPreferenceForPanel());
			
			env.when(() -> Env.getPreference(ctx, 456, 789, 123, "TestColumn")).thenReturn("");
			env.when(() -> Env.getPreference(ctx, Env.adWindowDummyID, 789, 0, "TestColumn")).thenReturn("Value2");
			assertEquals("Value2", gridField.defaultFromPreferenceForPanel());
			
			env.when(() -> Env.getPreference(ctx, Env.adWindowDummyID, 789, 0, "TestColumn")).thenReturn("");
			env.when(() -> Env.getPreference(ctx, Env.adWindowDummyID, 0, 123, "TestColumn")).thenReturn("Value3");
			assertEquals("Value3", gridField.defaultFromPreferenceForPanel());

			env.when(() -> Env.getPreference(ctx, Env.adWindowDummyID, 0, 123, "TestColumn")).thenReturn("");
			env.when(() -> Env.getPreference(ctx, Env.adWindowDummyID, 0, 0, "TestColumn")).thenReturn("Value4");
			assertEquals("Value4", gridField.defaultFromPreferenceForPanel());

			env.when(() -> Env.getPreference(ctx, Env.adWindowDummyID, 0, 0, "TestColumn")).thenReturn("");
			env.when(() -> Env.getPreference(ctx, 456, 0, 0, "TestColumn")).thenReturn("Value5");
			assertEquals("Value5", gridField.defaultFromPreferenceForPanel());

			env.when(() -> Env.getPreference(ctx, 456, 0, 0, "TestColumn")).thenReturn("");
			env.when(() -> Env.getPreference(ctx, 0, 0, 123, "TestColumn")).thenReturn("Value6");
			assertEquals("Value6", gridField.defaultFromPreferenceForPanel());

			env.when(() -> Env.getPreference(ctx, 0, 0, 123, "TestColumn")).thenReturn("");
			env.when(() -> Env.getPreference(ctx, 0, 0, 0, "TestColumn")).thenReturn("Value7");
			assertEquals("Value7", gridField.defaultFromPreferenceForPanel());
			
			// Test case 2: AD_Process_ID_Of_Panel <= 0 and AD_InfoWindow_ID_of_Panel > 0
			vo.AD_Process_ID_Of_Panel = 0;
			vo.AD_InfoWindow_ID_Of_Panel = 789;
			vo.AD_Window_ID_Of_Panel = 456;
			
			env.when(() -> Env.getPreference(ctx, 456, 789, "TestColumn")).thenReturn("Value8");
			assertEquals("Value8", gridField.defaultFromPreferenceForPanel());
			
			// Test case 3: No preference found
			env.when(() -> Env.getPreference(ctx, 456, 789, "TestColumn")).thenReturn("");
			assertNull(gridField.defaultFromPreferenceForPanel());
		}
	}
	
	@Test
	void testValidateValueNoDirect() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "C_BPartner_ID";
		vo.IsMandatory = false;
		vo.MandatoryLogic = "";
		vo.IsDisplayed = true;
		vo.DisplayLogic = "";
		GridField gridField = new GridField(vo);
		
		// Test case 1: value is null and not mandatory
		gridField.setValue(null, false);
		assertTrue(gridField.validateValueNoDirect());
		assertFalse(gridField.isError());

		// Test case 2: value is null and mandatory
		vo.IsMandatory = true;
		gridField.setValue(null, false);
		assertFalse(gridField.validateValueNoDirect());
		assertTrue(gridField.isError());
		vo.IsMandatory = false;
		gridField.setError(false);
		
		Lookup lookup = mock(Lookup.class);
		try (MockedStatic<LookupFactoryHelper> helper = Mockito.mockStatic(LookupFactoryHelper.class)) {
			vo.displayType = DisplayType.Search;
			vo.lookupInfo = mock(MLookupInfo.class);
			doReturn(true).when(lookup).isLoaded();
			doReturn("").when(lookup).getValidation();
			helper.when(() -> LookupFactoryHelper.getLookup(vo)).thenReturn(lookup);
			gridField.loadLookup();
			
			// Test case 3: Search display type, value valid			
			gridField.setValue(100, false);
			when(lookup.getDirect(100, false, true)).thenReturn(new ValueNamePair("value", "name"));
			assertTrue(gridField.validateValueNoDirect());
			assertFalse(gridField.isError());

			// Test case 4: Search display type, value invalid
			when(lookup.getDirect(100, false, true)).thenReturn(null);
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
			gridField.setError(false);
			
			// Test case 5: Lookup display type, value valid
			vo.displayType = DisplayType.TableDir;
			gridField.setValue(100, false);
			ValueNamePair namePair = mock(ValueNamePair.class);
			when(namePair.getName()).thenReturn("Valid");
			when(lookup.get(100)).thenReturn(namePair);
			when(lookup.containsKeyNoDirect(100)).thenReturn(true);
			assertTrue(gridField.validateValueNoDirect());
			assertFalse(gridField.isError());
			
			// Test case 6: Lookup display type, value invalid
			when(lookup.containsKeyNoDirect(100)).thenReturn(false);
			when(lookup.get(100)).thenReturn(null);
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
			gridField.setError(false);
			
			// Test case 7: Lookup display type, value inactive
			gridField.setValue(100, false);
			when(lookup.containsKeyNoDirect(100)).thenReturn(true);
			when(lookup.get(100)).thenReturn(namePair);
			when(namePair.getName()).thenReturn(MLookup.INACTIVE_S + "Inactive" + MLookup.INACTIVE_E);
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
			gridField.setError(false);

			// Test case 8: ChosenMultipleSelectionList, all valid
			vo.displayType = DisplayType.ChosenMultipleSelectionList;
			gridField.setValue("A,B,C", false);
			when(lookup.containsKeyNoDirect("A")).thenReturn(true);
			when(lookup.containsKeyNoDirect("B")).thenReturn(true);
			when(lookup.containsKeyNoDirect("C")).thenReturn(true);
			assertTrue(gridField.validateValueNoDirect());
			assertFalse(gridField.isError());

			// Test case 9: ChosenMultipleSelectionList, one invalid
			gridField.setValue("A,B,C", false);
			when(lookup.containsKeyNoDirect("B")).thenReturn(false);
			when(lookup.get("B")).thenReturn(null);
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
			gridField.setError(false);
			
			// Test case 10: ChosenMultipleSelectionList, one inactive
			gridField.setValue("A,B,C", false);
			when(lookup.containsKeyNoDirect("B")).thenReturn(false);
			ValueNamePair inactivePair = mock(ValueNamePair.class);
			when(inactivePair.getName()).thenReturn(MLookup.INACTIVE_S + "Inactive" + MLookup.INACTIVE_E);
			when(lookup.get("B")).thenReturn(inactivePair);
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
			gridField.setError(false);

			// Test case 11: MultiID, all valid
			vo.displayType = DisplayType.ChosenMultipleSelectionSearch;
			gridField.setValue("1,2,3", false);
			when(lookup.containsKeyNoDirect(1)).thenReturn(true);
			when(lookup.containsKeyNoDirect(2)).thenReturn(true);
			when(lookup.containsKeyNoDirect(3)).thenReturn(true);
			assertTrue(gridField.validateValueNoDirect());
			assertFalse(gridField.isError());
			
			// Test case 12: MultiID, one invalid
			gridField.setValue("1,2,3", false);
			when(lookup.containsKeyNoDirect(2)).thenReturn(false);
			when(lookup.get(2)).thenReturn(null);
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
			gridField.setError(false);
			
			// Test case 13: MultiID, one inactive
			gridField.setValue("1,2,3", false);
			when(lookup.containsKeyNoDirect(2)).thenReturn(false);
			when(lookup.get(2)).thenReturn(inactivePair);
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
		}
	}
	
	@Test
	void testGetEntries() {
		Properties ctx = Env.getCtx();
		GridField gridField = createField(ctx, 100, 100, "Name", "Name", DisplayType.String, false, false, false);
		
		List<String> values = gridField.getEntries();
		assertNotNull(values);
		assertTrue(values.size() > 0);
	}
	
	@Test
	void testSetValue() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "C_BPartner_ID";
		vo.IsMandatory = false;
		vo.MandatoryLogic = "";
		vo.IsDisplayed = true;
		vo.DisplayLogic = "";
		GridField gridField = new GridField(vo);
		
		// Test case 1: set a valid value
		gridField.setValue(123, false);
		assertEquals(123, gridField.getValue());

		// Test case 2: set a value that needs conversion
		vo.displayType = DisplayType.Integer;
		gridField.setValue(456, false);
		assertEquals(456, gridField.getValue());
		
		// Test case 3: set an invalid value for lookup
		vo.displayType = DisplayType.TableDir;
		Lookup lookup = mock(Lookup.class);
		try (MockedStatic<LookupFactoryHelper> helper = Mockito.mockStatic(LookupFactoryHelper.class)) {
			vo.lookupInfo = mock(MLookupInfo.class);
			doReturn(true).when(lookup).isLoaded();
			doReturn("").when(lookup).getValidation();
			helper.when(() -> LookupFactoryHelper.getLookup(vo)).thenReturn(lookup);
			gridField.loadLookup();
			
			gridField.setValue(100, false);
			// The validation is not called from setValue, so the value should be set
			assertEquals(100, gridField.getValue());
			assertFalse(gridField.isError());
			
			// now validate
			assertFalse(gridField.validateValueNoDirect());
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
		}
	}
	
	@Test
	void testSetValueValidate() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "C_BPartner_ID";
		vo.IsMandatory = false;
		vo.MandatoryLogic = "";
		vo.IsDisplayed = true;
		vo.DisplayLogic = "";
		GridField gridField = new GridField(vo);

		// Test case 1: set a valid integer value
		vo.displayType = DisplayType.Integer;
		String error = gridField.setValueValidate("123", false);
		assertEquals(123, gridField.getValue());
		assertNull(error, error);
		gridField.validateValueNoDirect();
		assertFalse(gridField.isError());

		// Test case 2: set an invalid integer value
		gridField.setValueValidate(null, false);
		error = gridField.setValueValidate("abc", false);
		assertNull(gridField.getValue());
		assertNotNull(error);
		
		// Test case 3: set a valid lookup value
		vo.displayType = DisplayType.TableDir;
		Lookup lookup = mock(Lookup.class);
		try (MockedStatic<LookupFactoryHelper> helper = Mockito.mockStatic(LookupFactoryHelper.class)) {
			vo.lookupInfo = mock(MLookupInfo.class);
			doReturn(true).when(lookup).isLoaded();
			doReturn("").when(lookup).getValidation();
			helper.when(() -> LookupFactoryHelper.getLookup(vo)).thenReturn(lookup);
			gridField.loadLookup();

			when(lookup.containsKeyNoDirect(100)).thenReturn(true);
			when(lookup.get(100)).thenReturn(new ValueNamePair("value", "name"));
			error = gridField.setValueValidate("100", false);
			assertNull(error, error);
			assertEquals(100, gridField.getValue());
			gridField.validateValueNoDirect();
			assertFalse(gridField.isError());

			// Test case 4: set an invalid lookup value
			gridField.setValueValidate("101", false);
			assertEquals(101, gridField.getValue());
			gridField.validateValueNoDirect();
			assertTrue(gridField.isError());
			assertNull(gridField.getValue());
		}

		// Test case 5: set null for mandatory field
		vo.IsMandatory = true;
		gridField.setValueValidate(null, false);
		assertNull(gridField.getValue());
		gridField.validateValueNoDirect();
		assertTrue(gridField.isError());
		gridField.setError(false);
		vo.IsMandatory = false;

		// Test case 6: set empty string for mandatory field
		vo.IsMandatory = true;
		gridField.setValueValidate("", false);
		assertNull(gridField.getValue());
		gridField.validateValueNoDirect();
		assertTrue(gridField.isError());
		gridField.setError(false);
		vo.IsMandatory = false;
		
		vo.displayType = DisplayType.Amount;
		error = gridField.setValueValidate("123.45", false);
		assertNull(error, error);
		assertEquals(new BigDecimal("123.45").setScale(2, RoundingMode.HALF_UP), ((BigDecimal)gridField.getValue()).setScale(2, RoundingMode.HALF_UP));
		
		vo.displayType = DisplayType.Date;
		Timestamp now = new Timestamp(System.currentTimeMillis());
		error = gridField.setValueValidate(DisplayType.getDateFormat_JDBC().format(now), false);
		assertNull(error, error);
		assertEquals(DisplayType.getDateFormat_JDBC().format(now), DisplayType.getDateFormat_JDBC().format((Timestamp)gridField.getValue()));
		error = gridField.setValueValidate("2024-13-01", false);
		assertNotNull(error);
		
		vo.displayType = DisplayType.YesNo;
		gridField.setValueValidate("Y", false);
		assertEquals(Boolean.TRUE, gridField.getValue());
		gridField.setValueValidate("N", false);
		assertEquals(Boolean.FALSE, gridField.getValue());
		error = gridField.setValueValidate("X", false);
		assertNotNull(error);
	}
	
	@Test
	void testCreateFields() throws Exception {
		Properties ctx = Env.getCtx();
		int windowNo = 100;
		int tabNo = 100;
		int adTabId = 152;

		// MUserDefField.get(vo.ctx,vo.AD_Field_ID, vo.AD_Tab_ID, vo.AD_Window_ID);
		MTab mTab = mock(MTab.class);
		try (MockedStatic<MTab> mtabStatic = Mockito.mockStatic(MTab.class);
			 MockedStatic<DB> db = Mockito.mockStatic(DB.class);
			 MockedStatic<MUserDefField> muserDefFieldStatic = Mockito.mockStatic(MUserDefField.class)) {
			mtabStatic.when(() -> MTab.get(adTabId)).thenReturn(mTab);
			muserDefFieldStatic.when(() -> MUserDefField.get(any(Properties.class), anyInt(), anyInt(), anyInt()))
				.thenReturn(null);

			ResultSet rs = mock(ResultSet.class);
			when(rs.next()).thenReturn(true).thenReturn(true).thenReturn(false);
			when(rs.getInt(anyString())).thenReturn(0);
			when(rs.getString(anyString())).thenReturn("");
			when(rs.getString("ColumnName")).thenReturn("Name").thenReturn("Description");
			
			CPreparedStatement pstmt = mock(CPreparedStatement.class);
			when(pstmt.executeQuery()).thenReturn(rs);
			db.when(() -> DB.prepareStatement(anyString(), any())).thenReturn(pstmt);

			GridField[] fields = GridField.createFields(ctx, windowNo, tabNo, adTabId);
			assertEquals(2, fields.length);
			assertEquals("Name", fields[0].getColumnName());
			assertEquals("Description", fields[1].getColumnName());
		}
	}

	@Test
	void testProcessUIVirtualColumn() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "VirtualColumn";
		vo.ColumnSQL = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1";
		vo.displayType = DisplayType.String;
		
		GridField gridField = new GridField(vo);
		gridField.processUIVirtualColumn();
		assertTrue(gridField.getValue().toString().length() > 0);
		
		vo.ColumnSQL = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT Test_ID FROM Test";
		vo.displayType = DisplayType.ID;
		gridField.processUIVirtualColumn();
		assertTrue(gridField.getValue() instanceof Integer);
		assertTrue(((Number)gridField.getValue()).intValue() > 0);
		
		vo.ColumnSQL = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT Created FROM Test";
		vo.displayType = DisplayType.Date;
		gridField.processUIVirtualColumn();
		assertTrue(gridField.getValue() instanceof Timestamp);
	}

	@Test
	void testIsEditablePara() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.isProcess = true;
		vo.ColumnName = "TestPara";
		vo.IsReadOnly = false;
		vo.ReadOnlyLogic = "";
		vo.IsUpdateable = true;
		vo.IsDisplayed = true;
		vo.DisplayLogic = "";
		
		GridField gridField = new GridField(vo);

		// Default case: should be editable
		assertTrue(gridField.isEditablePara(true));

		// Test case 1: Field is hidden
		vo.IsDisplayed = false;
		assertFalse(gridField.isEditablePara(true));
		vo.IsDisplayed = true;

		// Test case 2: ReadOnlyLogic evaluates to true
		vo.ReadOnlyLogic = "@#IsReadOnly@=Y";
		Env.setContext(ctx, "#IsReadOnly", "Y");
		assertFalse(gridField.isEditablePara(true));
		Env.setContext(ctx, "#IsReadOnly", "N");
		assertTrue(gridField.isEditablePara(true));
		
		// Test case 3: checkContext is false, should ignore ReadOnlyLogic
		Env.setContext(ctx, "#IsReadOnly", "Y");
		assertTrue(gridField.isEditablePara(false));
		vo.ReadOnlyLogic = "";
		Env.setContext(ctx, "#IsReadOnly", "N");
		
		vo.ReadOnlyLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual";
		assertFalse(gridField.isEditablePara(true));
		vo.ReadOnlyLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual WHERE 1=2";
		assertTrue(gridField.isEditablePara(true));
	}

	@Test
	void testIsDisplayedGrid() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "TestColumn";
		vo.IsDisplayedGrid = true;
		vo.DisplayLogic = "";
		
		GridField gridField = new GridField(vo);

		// Test case 1: IsDisplayedGrid is true, no display logic
		assertTrue(gridField.isDisplayedGrid(ctx, true));

		// Test case 2: IsDisplayedGrid is false
		vo.IsDisplayedGrid = false;
		assertFalse(gridField.isDisplayedGrid(ctx, true));
		vo.IsDisplayedGrid = true;

		// Test case 3: DisplayLogic evaluates to false
		vo.DisplayLogic = "@#Show@=Y";
		Env.setContext(ctx, "#Show", "N");
		assertFalse(gridField.isDisplayedGrid(ctx, true));

		// Test case 4: DisplayLogic evaluates to true
		Env.setContext(ctx, "#Show", "Y");
		assertTrue(gridField.isDisplayedGrid(ctx, true));

		// Test case 5: checkContext is false, should ignore DisplayLogic
		Env.setContext(ctx, "#Show", "N");
		assertTrue(gridField.isDisplayedGrid(ctx, false));
		
		vo.DisplayLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual";
		assertTrue(gridField.isDisplayedGrid(ctx, true));
		vo.DisplayLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual WHERE 1=2";
		assertFalse(gridField.isDisplayedGrid(ctx, true));
	}

	@Test
	void testRestoreValue() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.WindowNo = 100;
		vo.TabNo = 100;
		vo.ColumnName = "TestColumn";
		vo.displayType = DisplayType.String;
		GridField gridField = new GridField(vo);
		GridTab gridTab = mock(GridTab.class);
		gridField.setGridTab(gridTab);
		when(gridTab.isUpdateWindowContext()).thenReturn(true);		
		assertTrue(gridField.getGridTab().isUpdateWindowContext());
		
		// Set initial value
		Env.setContext(ctx, vo.WindowNo, vo.ColumnName, "InitialValue");
		assertEquals("InitialValue", Env.getContext(ctx, vo.WindowNo, vo.ColumnName));
		assertTrue(Util.isEmpty(Env.getContext(ctx, vo.WindowNo, vo.TabNo, vo.ColumnName, true)));
		
		// Set a new value, this should make "InitialValue" the old value
		gridField.setValue("NewValue", false);
		assertEquals("NewValue", gridField.getValue());
		assertEquals("NewValue", Env.getContext(ctx, vo.WindowNo, vo.ColumnName));
		assertEquals("NewValue", Env.getContext(ctx, vo.WindowNo, vo.TabNo, vo.ColumnName, true));
		
		// Restore the old value
		gridField.restoreValue();
		
		// Check if the value is restored in context
		assertEquals("InitialValue", Env.getContext(ctx, vo.WindowNo, vo.ColumnName));
		
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, vo.ColumnName, null);
		Env.setContext(ctx, vo.WindowNo, vo.ColumnName, (String)null);
		
		// Test IsParentTab=true		
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, vo.ColumnName, "InitialValue");
		assertEquals("InitialValue", Env.getContext(ctx, vo.WindowNo, vo.TabNo, vo.ColumnName, true));
		gridField = new GridField(vo);
		gridField.setGridTab(gridTab);
		assertTrue(gridField.getGridTab().isUpdateWindowContext());
		var parentTab = mock(GridTab.class);
		when(gridTab.getParentTab()).thenReturn(parentTab);
		when(parentTab.getField(vo.ColumnName)).thenReturn(mock(GridField.class));
		
		// Set a new value, this should make "InitialValue" the old value
		gridField.setValue("NewValue", false);
		assertEquals("NewValue", gridField.getValue());
		assertEquals("NewValue", Env.getContext(ctx, vo.WindowNo, vo.TabNo, vo.ColumnName, true));
		// IsParentTab=true, so not set at WindowNo level
		assertEquals("", Env.getContext(ctx, vo.WindowNo, vo.ColumnName));
		
		gridField.restoreValue();
		// Check if the value is restored in context
		assertEquals("InitialValue", Env.getContext(ctx, vo.WindowNo, vo.TabNo, vo.ColumnName, true));
	}

	@Test
	void testIsParentValue() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "TestColumn";
		vo.WindowNo = 100;
		vo.TabNo = 2;
		vo.displayType = DisplayType.ID;

		// Test case 1: Direct parent link
		GridField gridField1 = new GridField(vo);
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_LinkColumnName, "TestColumn");
		assertTrue(gridField1.isParentValue());
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_LinkColumnName, (String)null); // reset

		// Test case 2: Indirect parent link
		GridField gridField2 = new GridField(vo);
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_TabLevel, 2);
		Env.setContext(ctx, vo.WindowNo, 1, GridTab.CTX_TabLevel, 1);
		Env.setContext(ctx, vo.WindowNo, 1, GridTab.CTX_LinkColumnName, "TestColumn");
		assertTrue(gridField2.isParentValue());
		Env.setContext(ctx, vo.WindowNo, 1, GridTab.CTX_LinkColumnName, (String)null); // reset
		Env.setContext(ctx, vo.WindowNo, 1, GridTab.CTX_TabLevel, (String)null);
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_TabLevel, (String)null);

		// Test case 3: No parent link
		GridField gridField3 = new GridField(vo);
		assertFalse(gridField3.isParentValue());
	}

	@Test
	void testClone() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		var gridTab = gridWindow.getTab(0);
		gridTab.setQuery(MQuery.getNoRecordQuery(MBPartner.Table_Name, true));
		gridTab.query(false);
		gridTab.dataNew(false);
		
		var originalField = gridTab.getField(MBPartner.COLUMNNAME_Name);
		var clonedField = originalField.clone(Env.getCtx());
		assertNotSame(originalField, clonedField);
		assertEquals(originalField.getColumnName(), clonedField.getColumnName());
		
		originalField = gridTab.getField(MBPartner.COLUMNNAME_C_BP_Group_ID);
		clonedField = originalField.clone(Env.getCtx());
		assertNotSame(originalField, clonedField);
		assertEquals(originalField.getColumnName(), clonedField.getColumnName());
		assertNotNull(originalField.getVO().lookupInfo);
		assertNull(clonedField.getVO().lookupInfo);
	}

	@Test
	void testDefaultForClientOrg() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.WindowNo = 100;
		vo.TabNo = 100;
		
		GridFieldExposed gridField = new GridFieldExposed(vo);

		// Test case 1: SystemOnly access
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AccessLevel, X_AD_Table.ACCESSLEVEL_SystemOnly);
		vo.ColumnName = "AD_Client_ID";
		assertEquals(0, gridField.defaultForClientOrg());
		vo.ColumnName = "AD_Org_ID";
		assertEquals(0, gridField.defaultForClientOrg());
		vo.ColumnName = "AnotherColumn";
		assertNull(gridField.defaultForClientOrg());

		// Test case 2: SystemPlusClient access
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AccessLevel, X_AD_Table.ACCESSLEVEL_SystemPlusClient);
		vo.ColumnName = "AD_Org_ID";
		assertEquals(0, gridField.defaultForClientOrg());
		vo.ColumnName = "AD_Client_ID";
		assertNull(gridField.defaultForClientOrg());

		// Test case 3: Other access levels
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AccessLevel, X_AD_Table.ACCESSLEVEL_All);
		vo.ColumnName = "AD_Client_ID";
		assertNull(gridField.defaultForClientOrg());
		vo.ColumnName = "AD_Org_ID";
		assertNull(gridField.defaultForClientOrg());
	}

	@Test
	void testGetSearchColumnSQL() {
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ColumnName = "TestColumn";
		GridField gridField = new GridField(vo);

		// Test case 1: No ColumnSQL, should return ColumnName
		vo.ColumnSQL = null;
		assertEquals("TestColumn", gridField.getSearchColumnSQL());

		// Test case 2: Empty ColumnSQL, should return ColumnName
		vo.ColumnSQL = "";
		assertEquals("TestColumn", gridField.getSearchColumnSQL());

		// Test case 3: VIRTUAL_UI_COLUMN_PREFIX, should return "NULL"
		vo.ColumnSQL = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1";
		assertEquals("NULL", gridField.getSearchColumnSQL());

		// Test case 4: VIRTUAL_SEARCH_COLUMN_PREFIX, should return the SQL part
		vo.ColumnSQL = MColumn.VIRTUAL_SEARCH_COLUMN_PREFIX + "SELECT 'Search'";
		assertEquals("SELECT 'Search'", gridField.getSearchColumnSQL());

		// Test case 5: Regular ColumnSQL, should return the SQL
		vo.ColumnSQL = "SELECT 'Regular'";
		assertEquals("SELECT 'Regular'", gridField.getSearchColumnSQL());
	}

	@Test
	void testIsToolbarButton() {
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ColumnName = "TestColumn";
		GridField gridField = new GridField(vo);

		// Test case 1: Not a button
		vo.displayType = DisplayType.String;
		vo.IsToolbarButton = MColumn.ISTOOLBARBUTTON_Toolbar;
		assertFalse(gridField.isToolbarButton());

		// Test case 2: Is a button, but IsToolbarButton is not 'T' or 'B'
		vo.displayType = DisplayType.Button;
		vo.IsToolbarButton = MColumn.ISTOOLBARBUTTON_Window; // "N"
		assertFalse(gridField.isToolbarButton());
		vo.IsToolbarButton = null;
		assertFalse(gridField.isToolbarButton());

		// Test case 3: Is a button and IsToolbarButton is 'T'
		vo.displayType = DisplayType.Button;
		vo.IsToolbarButton = MColumn.ISTOOLBARBUTTON_Toolbar; // "T"
		assertTrue(gridField.isToolbarButton());

		// Test case 4: Is a button and IsToolbarButton is 'B'
		vo.displayType = DisplayType.Button;
		vo.IsToolbarButton = MColumn.ISTOOLBARBUTTON_Both; // "B"
		assertTrue(gridField.isToolbarButton());
	}

	@Test
	void testIsVirtualDBColumn() {
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ColumnName = "TestColumn";
		GridField gridField = new GridField(vo);

		// Test case 1: ColumnSQL is null
		vo.ColumnSQL = null;
		assertFalse(gridField.isVirtualDBColumn());

		// Test case 2: ColumnSQL is empty
		vo.ColumnSQL = "";
		assertFalse(gridField.isVirtualDBColumn());

		// Test case 3: ColumnSQL is a virtual UI column
		vo.ColumnSQL = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1";
		assertFalse(gridField.isVirtualDBColumn());

		// Test case 4: ColumnSQL is a virtual DB column
		vo.ColumnSQL = "SELECT 1";
		assertTrue(gridField.isVirtualDBColumn());
		
		// Test case 5: ColumnSQL is a virtual search column, which is also a virtual DB column
		vo.ColumnSQL = MColumn.VIRTUAL_SEARCH_COLUMN_PREFIX + "SELECT 1";
		assertTrue(gridField.isVirtualDBColumn());
	}

	@Test
	void testIsVirtualUIColumn() {
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ColumnName = "TestColumn";
		GridField gridField = new GridField(vo);

		// Test case 1: ColumnSQL is null
		vo.ColumnSQL = null;
		assertFalse(gridField.isVirtualUIColumn());

		// Test case 2: ColumnSQL is empty
		vo.ColumnSQL = "";
		assertFalse(gridField.isVirtualUIColumn());

		// Test case 3: ColumnSQL is a virtual DB column
		vo.ColumnSQL = "SELECT 1";
		assertFalse(gridField.isVirtualUIColumn());
		
		// Test case 4: ColumnSQL is a virtual search column
		vo.ColumnSQL = MColumn.VIRTUAL_SEARCH_COLUMN_PREFIX + "SELECT 1";
		assertFalse(gridField.isVirtualUIColumn());

		// Test case 5: ColumnSQL is a virtual UI column
		vo.ColumnSQL = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1";
		assertTrue(gridField.isVirtualUIColumn());
	}

	@Test
	void testIsVirtualSearchColumn() {
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ColumnName = "TestColumn";
		GridField gridField = new GridField(vo);

		// Test case 1: ColumnSQL is null
		vo.ColumnSQL = null;
		assertFalse(gridField.isVirtualSearchColumn());

		// Test case 2: ColumnSQL is empty
		vo.ColumnSQL = "";
		assertFalse(gridField.isVirtualSearchColumn());

		// Test case 3: ColumnSQL is a virtual DB column
		vo.ColumnSQL = "SELECT 1";
		assertFalse(gridField.isVirtualSearchColumn());
		
		// Test case 4: ColumnSQL is a virtual UI column
		vo.ColumnSQL = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1";
		assertFalse(gridField.isVirtualSearchColumn());

		// Test case 5: ColumnSQL is a virtual search column
		vo.ColumnSQL = MColumn.VIRTUAL_SEARCH_COLUMN_PREFIX + "SELECT 1";
		assertTrue(gridField.isVirtualSearchColumn());
	}

	@Test
	void testIsReadOnly() {
		GridFieldVO vo = mock(GridFieldVO.class);
		GridField gridField = new GridField(vo);

		// Test case 1: Virtual column
		vo.ColumnSQL = "SELECT 1";
		assertTrue(gridField.isReadOnly());

		// Test case 2: Not a virtual column, IsReadOnly is true
		vo.ColumnSQL = null;
		vo.IsReadOnly = true;
		assertTrue(gridField.isReadOnly());

		// Test case 3: Not a virtual column, IsReadOnly is false
		vo.IsReadOnly = false;
		assertFalse(gridField.isReadOnly());
	}

	@Test
	void testIsUpdateable() {
		GridFieldVO vo = mock(GridFieldVO.class);
		GridField gridField = new GridField(vo);

		// Test case 1: Virtual column
		vo.ColumnSQL = "SELECT 1";
		assertFalse(gridField.isUpdateable());

		// Test case 2: Not a virtual column, IsUpdateable is true
		vo.ColumnSQL = null;
		vo.IsUpdateable = true;
		assertTrue(gridField.isUpdateable());

		// Test case 3: Not a virtual column, IsUpdateable is false
		vo.IsUpdateable = false;
		assertFalse(gridField.isUpdateable());
	}

	@Test
	void testIsMandatory() {
		Properties ctx = Env.getCtx();
		ResultSet rs = mock(ResultSet.class);		
		try {
			when(rs.getInt(anyString())).thenReturn(0);
			when(rs.getString(anyString())).thenReturn("");
		} catch (SQLException e) {
			fail("SQLException thrown during mock setup: " + e.getMessage());
		}
		GridFieldVO vo = GridFieldVO.createFromResultSet(ctx, 100, 100, SystemIDs.WINDOW_TEST, 
				152, false, rs);
		vo.ColumnName = "TestColumn";
		vo.IsMandatory = false;
		vo.MandatoryLogic = "";
		vo.IsDisplayed = true;
		vo.DisplayLogic = "";
		vo.IsReadOnly = false;
		vo.ReadOnlyLogic = "";
		vo.IsUpdateable = true;
		
		GridField gridField = new GridField(vo);
		GridTab gridTab = mock(GridTab.class);
		gridField.setGridTab(gridTab);
		Env.setContext(ctx, vo.WindowNo, vo.TabNo, "IsActive", "Y");

		// Default case: not mandatory
		assertFalse(gridField.isMandatory(true));

		// Test case 1: vo.IsMandatory is true
		vo.IsMandatory = true;
		assertTrue(gridField.isMandatory(true));
		vo.IsMandatory = false; // reset

		// Test case 2: Not displayed
		vo.IsDisplayed = false;
		assertFalse(gridField.isMandatory(true));
		vo.IsDisplayed = true; // reset

		// Test case 3: Not editable
		vo.IsReadOnly = true;
		assertFalse(gridField.isMandatory(true));
		vo.IsReadOnly = false; // reset

		// Test case 4: MandatoryLogic evaluates to true
		vo.MandatoryLogic = "@#IsMandatory@=Y";
		Env.setContext(ctx, "#IsMandatory", "Y");
		assertTrue(gridField.isMandatory(true));

		// Test case 5: MandatoryLogic evaluates to false
		Env.setContext(ctx, "#IsMandatory", "N");
		assertFalse(gridField.isMandatory(true));

		// Test case 6: checkContext is false, MandatoryLogic should be ignored
		Env.setContext(ctx, "#IsMandatory", "Y");
		assertFalse(gridField.isMandatory(false));
		
		vo.MandatoryLogic = "";
		Env.setContext(ctx, "#IsMandatory", (String)null);
		
		vo.MandatoryLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual";
		assertTrue(gridField.isMandatory(true));
		assertFalse(gridField.isMandatory(false));
		vo.MandatoryLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual WHERE 1=2";
		assertFalse(gridField.isMandatory(true));
		assertFalse(gridField.isMandatory(false));
	}

	@Test
	void testDefaultFromExpression() throws Exception {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.WindowNo = 100;
		vo.TabNo = 100;
		vo.ColumnName = "TestColumn";
		GridFieldExposed gridField = new GridFieldExposed(vo);

		// Test case 1: DefaultValue is "NULL"
		vo.DefaultValue = "NULL";
		assertNull(gridField.defaultFromExpression());
		vo.DefaultValue = "null";
		assertNull(gridField.defaultFromExpression());

		// Test case 2: DefaultValue is "@SysDate@"
		vo.DefaultValue = "@SysDate@";
		Object sysDate = gridField.defaultFromExpression();
		assertNotNull(sysDate);
		assertTrue(sysDate instanceof Timestamp);

		// Test case 3: DefaultValue is a context variable
		vo.DefaultValue = "@#TestVar@";
		Env.setContext(ctx, "#TestVar", "TestValue");
		assertEquals("TestValue", gridField.defaultFromExpression());
		Env.setContext(ctx, "#TestVar", (String)null);

		// Test case 4: DefaultValue is a string literal
		vo.DefaultValue = "'StringLiteral'";
		assertEquals("StringLiteral", gridField.defaultFromExpression());

		// Test case 5: DisplayType.Date
		vo.displayType = DisplayType.Date;
		vo.DefaultValue = "2025-12-12";
		Object date = gridField.defaultFromExpression();
		assertTrue(date instanceof Timestamp);
		assertEquals("2025-12-12", new SimpleDateFormat("yyyy-MM-dd").format((Date)date));

		// Test case 6: DisplayType.Time
		vo.displayType = DisplayType.Time;
		vo.DefaultValue = "14:30:00";
		Object time = gridField.defaultFromExpression();
		assertTrue(time instanceof Timestamp);
		assertEquals("14:30:00", new SimpleDateFormat("HH:mm:ss").format((Date)time));

		// Test case 7: DisplayType.DateTime
		vo.displayType = DisplayType.DateTime;
		vo.DefaultValue = "2025-12-12 14:30:00";
		Object dateTime = gridField.defaultFromExpression();
		assertTrue(dateTime instanceof Timestamp);
		assertEquals("2025-12-12 14:30:00", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format((Date)dateTime));

		// Test case 8: ChosenMultipleSelectionList
		vo.displayType = DisplayType.ChosenMultipleSelectionList;
		vo.DefaultValue = "A,B,C";
		assertEquals("A,B,C", gridField.defaultFromExpression());
	}

	@Test
	void testIsDisplayed() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "TestColumn";
		vo.IsDisplayed = true;
		vo.DisplayLogic = "";
		GridField gridField = new GridField(vo);

		// Test case 1: IsDisplayed is true, no display logic
		assertTrue(gridField.isDisplayed(ctx, true));

		// Test case 2: IsDisplayed is false
		vo.IsDisplayed = false;
		assertFalse(gridField.isDisplayed(ctx, true));
		vo.IsDisplayed = true; // reset

		// Test case 3: DisplayLogic evaluates to false
		vo.DisplayLogic = "@#Show@=Y";
		Env.setContext(ctx, "#Show", "N");
		assertFalse(gridField.isDisplayed(ctx, true));

		// Test case 4: DisplayLogic evaluates to true
		Env.setContext(ctx, "#Show", "Y");
		assertTrue(gridField.isDisplayed(ctx, true));

		// Test case 5: checkContext is false, should ignore DisplayLogic
		Env.setContext(ctx, "#Show", "N");
		assertTrue(gridField.isDisplayed(ctx, false));
		
		vo.DisplayLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual";
		assertTrue(gridField.isDisplayed(ctx, true));
		
		vo.DisplayLogic = MColumn.VIRTUAL_UI_COLUMN_PREFIX + "SELECT 1 FROM Dual WHERE 1=2";
		assertFalse(gridField.isDisplayed(ctx, true));
		assertTrue(gridField.isDisplayed(ctx, false));		
	}

	@Test
	void testPropertyChangeListener() {
		Properties ctx = Env.getCtx();
		GridFieldVO vo = mock(GridFieldVO.class);
		vo.ctx = ctx;
		vo.ColumnName = "TestColumn";
		GridField gridField = new GridField(vo);

		final boolean[] listenerCalled = { false };
		PropertyChangeListener listener = evt -> listenerCalled[0] = true;

		// Add listener and test
		gridField.addPropertyChangeListener(listener);
		gridField.setValue("NewValue", false);
		assertTrue(listenerCalled[0], "Listener should be called after being added");

		// Reset and remove listener
		listenerCalled[0] = false;
		gridField.removePropertyChangeListener(listener);
		gridField.setValue("AnotherValue", false);
		assertFalse(listenerCalled[0], "Listener should not be called after being removed");
	}
}