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
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.spy;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.UUID;

import org.adempiere.base.Core;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTabVO;
import org.compiere.model.GridTable;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MBPartner;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MBankStatement;
import org.compiere.model.MDocType;
import org.compiere.model.MField;
import org.compiere.model.MLookup;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrg;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MRule;
import org.compiere.model.MStatusLine;
import org.compiere.model.MStatusLineUsedIn;
import org.compiere.model.MStyle;
import org.compiere.model.MTable;
import org.compiere.model.MTest;
import org.compiere.model.MUser;
import org.compiere.model.MWarehouse;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_C_BPartner_Location;
import org.compiere.model.X_C_Greeting;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * 
 * @author hengsin
 *
 */
public class GridTabTest extends AbstractTestCase {

	private static final int FIELD_ORDERLINE_SHIPPER = 1135;

	public GridTabTest() {
	}

	@Test
	public void testQuery() {		
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
		var gridWindow = createGridWindow(AD_Window_ID);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID="+AD_Window_ID);
		
		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			GridTab gTab = gridWindow.getTab(i);
			if (i == 0) {
				gTab.setUpdateWindowContext(true);
				gTab.setQuery(query);
				gTab.query(false, 0, 0);
			} else {
				gTab.setUpdateWindowContext(false);
			}
		}
		
		GridTab gTab = gridWindow.getTab(0);
		assertTrue(gTab.getRowCount()==1, "GridTab Row Count is not 1. GridTab="+gTab.getName());
		
		String name = (String) gTab.getValue("Name");
		MBPartner bpartner = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
		assertTrue(bpartner.getName().equals(name), "GridTab Name != MBPartner.getName(). GridTab.Name="+name + " MBPartner.getName="+bpartner.getName());
	}
	
	@Test
	public void testCallout() {
		//Sales Order
		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		var gridWindow = createGridWindow(AD_Window_ID);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID="+AD_Window_ID);
		
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			GridTab gTab = gridWindow.getTab(i);
			if (i == 0) {
				gTab.setUpdateWindowContext(true);
				gTab.setQuery(null);
				gTab.query(false, 7, 0);
			} else {
				gTab.setUpdateWindowContext(false);
			}
		}
		
		//insert new row
		GridTab gTab = gridWindow.getTab(0);
		gTab.dataNew(false);
		assertTrue(gTab.isNew(), "Grid Tab dataNew call not working as expected");
		
		//initial value of Bill_BPartner_ID should be null
		assertNull(gTab.getValue(MOrder.COLUMNNAME_Bill_BPartner_ID), "Bill_BPartner_ID not null");
		gTab.setValue(MOrder.COLUMNNAME_C_BPartner_ID, DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		
		//set C_BPartner_ID to BP_JOE_BLOCK
		Object value = gTab.getValue(MOrder.COLUMNNAME_C_BPartner_ID);
		assertNotNull(value, "C_BPartner_ID is null");
		assertEquals(DictionaryIDs.C_BPartner.JOE_BLOCK.id, ((Number)value).intValue(), "C_BPartner_ID not equals to " + DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		
		//invoke org.compiere.model.CalloutOrder.bPartner
		GridField mField = gTab.getField(MOrder.COLUMNNAME_C_BPartner_ID);
		gTab.processFieldChange(mField);
		
		//org.compiere.model.CalloutOrder.bPartner should set Bill_BPartner_ID to BP_JOE_BLOCK
		value = gTab.getValue(MOrder.COLUMNNAME_Bill_BPartner_ID);
		assertNotNull(value, "Bill_BPartner_ID is null");
		assertEquals(DictionaryIDs.C_BPartner.JOE_BLOCK.id, ((Number)value).intValue(), "Bill_BPartner_ID not equals to " + DictionaryIDs.C_BPartner.JOE_BLOCK.id);
	}
	
	@Test
	public void testUpdate() {
		//Business Partner
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
		var gridWindow = createGridWindow(AD_Window_ID);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID="+AD_Window_ID);
		
		//retrieve for update
		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			GridTab gTab = gridWindow.getTab(i);
			if (i == 0) {
				gTab.setUpdateWindowContext(true);
				gTab.setQuery(query);
				gTab.query(false, 0, 0);
			} else {
				gTab.setUpdateWindowContext(false);
			}
		}
		
		GridTab gTab = gridWindow.getTab(0);
		assertTrue(gTab.getRowCount()==1, "GridTab Row Count is not 1. GridTab="+gTab.getName());
		
		String name = (String) gTab.getValue("Name");
		MBPartner bpartner = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
		assertTrue(bpartner.getName().equals(name), "GridTab Name != MBPartner.getName(). GridTab.Name="+name + " MBPartner.getName="+bpartner.getName());
		
		//use trx to perform update
		gTab.getTableModel().setImportingMode(true, getTrxName());
		String updateValue = "testUpdate";
		gTab.setValue(MBPartner.COLUMNNAME_Description, updateValue);
		gTab.dataSave(true);
		
		//verify update is working
		bpartner.load(getTrxName());
		String description = (String) gTab.getValue(MBPartner.COLUMNNAME_Description);
		assertTrue(updateValue.equals(description), "GridTab Description != Update Value. GridTab.Description="+description);
		assertTrue(bpartner.getDescription().equals(description), "GridTab Description != MBPartner.getDescription(). GridTab.Description="+description+ " MBPartner.getDescription="+bpartner.getDescription());
	}

	@Test
	public void testInsert() {
		Properties ctx = Env.getCtx();

		String prefKey = "P" + SystemIDs.WINDOW_SALES_ORDER + "|" + MOrder.COLUMNNAME_C_DocTypeTarget_ID;
		String pref = Env.getContext(ctx, prefKey);
		if (pref.length() == 0) {
			/* Call Load Preferences to fill the context variables required to process the defaults of the window */
			int orgId = Env.getAD_Org_ID(ctx);
			MOrg org = MOrg.get(orgId);
			KeyNamePair knpo = new KeyNamePair(orgId, org.getName());
			KeyNamePair knpw = null;
			int whId = Env.getContextAsInt(ctx, Env.M_WAREHOUSE_ID);
			if (whId > 0) {
				MWarehouse wh = MWarehouse.get(whId);
				knpw = new KeyNamePair(whId, wh.getName());
			}
			Timestamp loginDate = Env.getContextAsDate(ctx, Env.DATE);
			Login login = new Login(ctx);
			login.loadPreferences(knpo, knpw, loginDate, null);
		}

		MField field = MField.get(FIELD_ORDERLINE_SHIPPER);
		boolean displayOri = field.isDisplayed();
		boolean displayGridOri = field.isDisplayed();
		int createdOrderId = -1;
		
		try {
			/* IDEMPIERE-5560 */
			// must not use trx here for the test case below to get the update
			DB.executeUpdateEx("UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N' WHERE AD_Field_ID=?", new Object[] {FIELD_ORDERLINE_SHIPPER}, null);
			CacheMgt.get().reset();

			// Sales Order
			int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
			var gridWindow = createGridWindow(AD_Window_ID);
			int tabCount = gridWindow.getTabCount();
			assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID=" + AD_Window_ID);

			// insert new row
			GridTab gTab0 = gridWindow.getTab(0);
			gTab0.setQuery(null);
			gTab0.query(false, 7, 0);
			assertTrue(gTab0.dataNew(false));
			assertTrue(gTab0.isNew(), "Grid Tab dataNew call not working as expected");
			gTab0.setValue(MOrder.COLUMNNAME_C_BPartner_ID, DictionaryIDs.C_BPartner.C_AND_W.id);
			// DocTypeTarget and SalesRep are set using the default in preference (this is to test correct assignment of defaults)
			// gTab0.setValue(MOrder.COLUMNNAME_C_DocTypeTarget_ID, DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			// gTab0.setValue(MOrder.COLUMNNAME_SalesRep_ID, DictionaryIDs.AD_User.GARDEN_USER.id);
			assertTrue(gTab0.dataSave(true), CLogger.retrieveWarningString("Could not save order"));

	        createdOrderId = ((Integer) gTab0.getValue(MOrder.COLUMNNAME_C_Order_ID)).intValue();
			
			GridTab gTab1 = gridWindow.getTab(1);
			if (!gTab1.getTableModel().isOpen())
				gTab1.getTableModel().open(0);
			assertTrue(gTab1.dataNew(false));
			gTab1.setValue(MOrderLine.COLUMNNAME_M_Product_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id);
			assertTrue(gTab1.dataSave(true));

			assertTrue(gTab1.dataNew(false));
			gTab1.setValue(MOrderLine.COLUMNNAME_M_Product_ID, DictionaryIDs.M_Product.SEEDER.id);
			assertTrue(gTab1.dataSave(true));

		} finally {
			// Clean up the created records
	        if (createdOrderId > 0) {
	            String deleteLines = "DELETE FROM C_OrderLine WHERE C_Order_ID=?";
	            String deleteOrder = "DELETE FROM C_Order WHERE C_Order_ID=?";
	            
	            DB.executeUpdateEx(deleteLines, new Object[]{createdOrderId}, null);
	            DB.executeUpdateEx(deleteOrder, new Object[]{createdOrderId}, null);
	        }
	        
			// rollback the work from the test
			rollback();
			DB.executeUpdateEx("UPDATE AD_Field SET IsDisplayed=?, IsDisplayedGrid=? WHERE AD_Field_ID=?", new Object[] {displayOri, displayGridOri, FIELD_ORDERLINE_SHIPPER}, null);
			CacheMgt.get().reset();
		}

	}

	private DataStatusListener newGridTabDataStatusListener(GridWindow gridWindow) {
		return new DataStatusListener() {
			@Override
			public void dataStatusChanged(DataStatusEvent e) {
				int col = e.getChangedColumn();
				if (col < 0)
					return;
				GridTab gridTab = null;
				if (e.getSource() != null && e.getSource() instanceof GridTable) {
					GridTable gt = (GridTable) e.getSource();
					gridTab = gridWindow.getTab(gt.getTabNo());
					if (gridTab.getAD_Table_ID() != e.AD_Table_ID)
						throw new RuntimeException("Table doesn't match with updated tab");
				}
				// Process Callout
				GridField mField = gridTab.getField(col);
				if (mField != null && (mField.getCallout().length() > 0
						|| (Core.findCallout(gridTab.getTableName(), mField.getColumnName())).size() > 0
						|| gridTab.hasDependants(mField.getColumnName()))) {
					gridTab.processFieldChange(mField); // Dependencies & Callout
					// Refresh the list on dependent fields
					for (GridField dependentField : gridTab.getDependantFields(mField.getColumnName())) {
						// if the field has a lookup
						if (dependentField != null && dependentField.getLookup() instanceof MLookup) {
							MLookup mLookup = (MLookup) dependentField.getLookup();
							// if the lookup is dynamic (i.e. contains this columnName as variable)
							if (mLookup.getValidation().indexOf("@" + mField.getColumnName() + "@") != -1) {
								mLookup.refresh();
							}
						}
					} // for all dependent fields

				}
			}
		};
	}

	@Test
	void testScriptCallout() {
		MRule rule = new MRule(Env.getCtx(), 0, getTrxName());
		rule.setName("Test Script Callout Rule");
		rule.setValue("groovy:TestScriptCallout");
		rule.setEventType(MRule.EVENTTYPE_Callout);
		rule.setRuleType(MRule.RULETYPE_JSR223ScriptingAPIs);
		rule.setScript("""
				A_Tab.setValue("Description", A_Value);
				""");

		//Test window
		int AD_Window_ID = SystemIDs.WINDOW_TEST;
		var gridWindow = createGridWindow(AD_Window_ID);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID="+AD_Window_ID);
				
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			GridTab gTab = gridWindow.getTab(i);
			if (i == 0) {
				gTab.setUpdateWindowContext(true);
				gTab.setQuery(null);
				gTab.query(false, 7, 0);
			} else {
				gTab.setUpdateWindowContext(false);
			}
		}
				
		//insert new row
		GridTab gTab = gridWindow.getTab(0);
		gTab.dataNew(false);
		assertTrue(gTab.isNew(), "Grid Tab dataNew call not working as expected");
		GridField field = gTab.getField("Name");
		String scriptCallout = MRule.SCRIPT_PREFIX+rule.getValue();
		GridField spyField = spy(field);
		doReturn(scriptCallout).when(spyField).getCallout();
		String nameValue = "Test Script Callout";
		gTab.setValue(spyField, nameValue);
		spyField.setValue(nameValue, true);
		assertEquals(nameValue, gTab.getValue(spyField));
		assertEquals(nameValue, spyField.getValue());
		assertNotEquals(gTab.getValue(spyField), gTab.getValue("Description"));
		try (MockedStatic<MRule> mockedRule = mockStatic(MRule.class, Mockito.CALLS_REAL_METHODS)) {
			mockedRule.when(() -> MRule.get(any(), eq(rule.getValue()))).thenReturn(rule);			
			String error = gTab.processCallout(spyField);
			assertEquals("", error, "Script Callout processing error: " + error);
		}
		assertEquals(gTab.getValue(spyField), gTab.getValue("Description"));
		
		// test invalid script callout
		try (MockedStatic<MRule> mockedRule = mockStatic(MRule.class, Mockito.CALLS_REAL_METHODS)) {
			mockedRule.when(() -> MRule.get(any(), eq(rule.getValue()))).thenReturn(rule);
			//invalid rule value
			scriptCallout = MRule.SCRIPT_PREFIX+rule.getValue()+"_INVALID";
			reset(spyField);
			doReturn(scriptCallout).when(spyField).getCallout();
			String error = gTab.processCallout(spyField);
			assertTrue(!Util.isEmpty(error, true), "Script Callout processing should return error for invalid rule value");
						
			//invalid event type
			rule.setValue("groovy:TestScriptCallout");
			rule.setEventType(MRule.EVENTTYPE_ModelValidatorTableEvent);
			scriptCallout = MRule.SCRIPT_PREFIX+rule.getValue();
			reset(spyField);
			doReturn(scriptCallout).when(spyField).getCallout();
			error = gTab.processCallout(spyField);
			assertTrue(!Util.isEmpty(error, true), "Script Callout processing should return error for invalid rule event type");
			
			//invalid rule type
			rule.setEventType(MRule.EVENTTYPE_Callout);
			rule.setRuleType(MRule.RULETYPE_SQL);
			error = gTab.processCallout(spyField);
			assertTrue(!Util.isEmpty(error, true), "Script Callout processing should return error for invalid rule type");
		}

		//invalid script engine
		try (MockedStatic<MRule> mockedRule = mockStatic(MRule.class, Mockito.CALLS_REAL_METHODS)) {
			//need to create a new rule instance since engine is cache
			MRule rule1 = new MRule(Env.getCtx(), 0, getTrxName());
			rule1.setName("Test Script Callout Rule");
			rule1.setValue("groovy1:TestScriptCallout");
			rule1.setEventType(MRule.EVENTTYPE_Callout);
			rule1.setRuleType(MRule.RULETYPE_JSR223ScriptingAPIs);
			rule1.setScript("""
					A_Tab.setValue("Description", A_Value);
					""");
			
			mockedRule.when(() -> MRule.get(any(), eq(rule1.getValue()))).thenReturn(rule1);
			
			scriptCallout = MRule.SCRIPT_PREFIX+rule1.getValue();
			reset(spyField);
			doReturn(scriptCallout).when(spyField).getCallout();
			String error = gTab.processCallout(spyField);
			assertTrue(!Util.isEmpty(error, true), "Script Callout processing should return error for invalid script engine name");
		}
		
		//test script with exception
		try (MockedStatic<MRule> mockedRule = mockStatic(MRule.class, Mockito.CALLS_REAL_METHODS)) {
			rule.setValue("groovy:TestScriptCallout");
			rule.setEventType(MRule.EVENTTYPE_Callout);
			rule.setRuleType(MRule.RULETYPE_JSR223ScriptingAPIs);
			rule.setScript("""
					throw new Exception("Test Exception in Script");
					""");
			
			mockedRule.when(() -> MRule.get(any(), eq(rule.getValue()))).thenReturn(rule);
			
			scriptCallout = MRule.SCRIPT_PREFIX+rule.getValue();
			reset(spyField);
			doReturn(scriptCallout).when(spyField).getCallout();
			String error = gTab.processCallout(spyField);
			assertTrue(!Util.isEmpty(error, true), "Script Callout processing should return error for exception in script");
		}
	}
	
	@Test
	void testDetailTabQuery() {
		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		var gridWindow = createGridWindow(AD_Window_ID);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID=" + AD_Window_ID);

		GridTab gTab = gridWindow.getTab(0);
		//c_order_id | c_orderline_id
		//100 | 100
		MQuery query = new MQuery(gTab.getTableName());
		query.addRestriction(MOrderLine.COLUMNNAME_C_OrderLine_ID, MQuery.EQUAL, 100);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "GridTab Row Count is 0. GridTab=" + gTab.getName());
		// line tab
		gTab = gridWindow.getTab(1);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "GridTab Row Count is 0. GridTab=" + gTab.getName());
		gTab.setCurrentRow(0);
		assertEquals(100, gTab.getValue(MOrderLine.COLUMNNAME_C_Order_ID));
		assertEquals(100, gTab.getValue(MOrderLine.COLUMNNAME_C_OrderLine_ID));
	}
	
	@Test
	void testSwitchRows() {
		Properties ctx = Env.getCtx();
		int createdOrderId = -1;
		try {
			// set context for OrderType default below
			String prefKey = "P" + SystemIDs.WINDOW_SALES_ORDER + "|" + MOrder.COLUMNNAME_C_DocTypeTarget_ID;
			Env.setContext(ctx, prefKey, DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			Env.setContext(Env.getCtx(), "IsSOTrx", true);
			int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
			var gridWindow = createGridWindow(AD_Window_ID);

			// Header tab - create new order
			GridTab headerTab = gridWindow.getTab(0);
			headerTab.setQuery(MQuery.getNoRecordQuery(MOrder.Table_Name, true));
			headerTab.query(false);
			headerTab.dataNew(false);
			assertTrue(!Util.isEmpty(Env.getContext(ctx, 1, "OrderType", true), true), "OrderType" + " not set in context after dataNew");
			headerTab.setValue(MOrder.COLUMNNAME_C_BPartner_ID, DictionaryIDs.C_BPartner.C_AND_W.id);
			assertTrue(headerTab.dataSave(true), "Could not save order header");
			createdOrderId = ((Integer) headerTab.getValue(MOrder.COLUMNNAME_C_Order_ID)).intValue();
			assertTrue(createdOrderId > 0, "Created order id invalid");			

			// Line tab
			GridTab lineTab = gridWindow.getTab(1);
			if (!lineTab.getTableModel().isOpen())
				lineTab.getTableModel().open(0);

			// create first line
			assertTrue(lineTab.dataNew(false));
			lineTab.setValue(MOrderLine.COLUMNNAME_M_Product_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id);
			assertTrue(lineTab.dataSave(true));

			// create second line
			assertTrue(lineTab.dataNew(false));
			lineTab.setValue(MOrderLine.COLUMNNAME_M_Product_ID, DictionaryIDs.M_Product.SEEDER.id);
			assertTrue(lineTab.dataSave(true));

			assertTrue(lineTab.getRowCount() >= 2, "Need at least 2 lines for switchRows test");

			Integer idRow0Before = (Integer) lineTab.getValue(0, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			Integer idRow1Before = (Integer) lineTab.getValue(1, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			Integer lineRow0Before = (Integer) lineTab.getValue(0, "Line");
			Integer lineRow1Before = (Integer) lineTab.getValue(1, "Line");

			assertNotNull(idRow0Before);
			assertNotNull(idRow1Before);
			assertNotEquals(idRow0Before, idRow1Before);
			assertNotNull(lineRow0Before);
			assertNotNull(lineRow1Before);
			assertTrue(lineRow0Before < 9900 && lineRow1Before < 9900, "Line numbers should be normal lines");

			// Perform switch
			lineTab.switchRows(0, 1, -1, true);

			Integer idRow0After = (Integer) lineTab.getValue(0, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			Integer idRow1After = (Integer) lineTab.getValue(1, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			Integer lineRow0After = (Integer) lineTab.getValue(0, "Line");
			Integer lineRow1After = (Integer) lineTab.getValue(1, "Line");

			assertEquals(idRow1Before, idRow0After, "Row0 should now contain former Row1 line");
			assertEquals(idRow0Before, idRow1After, "Row1 should now contain former Row0 line");
			assertEquals(lineRow0Before, lineRow0After, "Line number at position 0 should remain ascending after swap");
			assertEquals(lineRow1Before, lineRow1After, "Line number at position 1 should remain ascending after swap");
			assertTrue(lineRow0After < lineRow1After, "Row ordering should remain ascending by line");

			// Swap back
			lineTab.switchRows(1, 0, -1, true);
			Integer idRow0Revert = (Integer) lineTab.getValue(0, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			Integer idRow1Revert = (Integer) lineTab.getValue(1, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			assertEquals(idRow0Before, idRow0Revert, "Row0 should revert to original line");
			assertEquals(idRow1Before, idRow1Revert, "Row1 should revert to original line");

			// Call with from==to should do nothing
			lineTab.switchRows(0, 0, -1, true);
			Integer idRow0NoChange = (Integer) lineTab.getValue(0, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			assertEquals(idRow0Revert, idRow0NoChange, "Switch with same indices should not change ordering");
			
			// Call with invalid to should do nothing
			lineTab.switchRows(0, 100, -1, true);
			idRow0NoChange = (Integer) lineTab.getValue(0, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			assertEquals(idRow0Revert, idRow0NoChange, "Switch with invalid to indices should not change ordering");
			
			// Mark both lines as processed and try switch
			// Switch should not happens since both line is processed (not editable)
			lineTab.navigate(0);
			lineTab.setValue(MOrderLine.COLUMNNAME_Processed, true);
			assertTrue(lineTab.dataSave(true), "Failed to save line 0");
			lineTab.navigate(1);
			lineTab.setValue(MOrderLine.COLUMNNAME_Processed, true);
			assertTrue(lineTab.dataSave(true), "Failed to save line 1");	
			lineTab.switchRows(0, 1, -1, true);
			idRow0NoChange = (Integer) lineTab.getValue(0, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			assertEquals(idRow0Revert, idRow0NoChange, "Switch with processed line should not change ordering");
		} finally {
			rollback();
			if (createdOrderId > 0) {
				DB.executeUpdateEx("DELETE FROM C_OrderLine WHERE C_Order_ID=?", new Object[]{createdOrderId}, null);
				DB.executeUpdateEx("DELETE FROM C_Order WHERE C_Order_ID=?", new Object[]{createdOrderId}, null);
			}			
		}
	}
	
	@Test
	void testLocking() {
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
		var gridWindow = createGridWindow(AD_Window_ID);
		GridTab gTab = gridWindow.getTab(0);

		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Should have one record");

		int recordID = gTab.getRecord_ID();
		assertTrue(recordID > 0, "Record ID should be greater than 0");

		// Lock the record
		gTab.lock(Env.getCtx(), recordID, true);
		gTab.isLocked();
		assertTrue(gTab.isLocked(), "Record should be locked");

		// Unlock the record
		gTab.lock(Env.getCtx(), recordID, false);
		assertEquals(false, gTab.isLocked(), "Record should not be locked");
	}
	
	/**
     * Test dataDelete() on a newly created record.
     */
    @Test
    public void testDataDelete_NewRecord() {
        int AD_Window_ID = 178; // AD_Greeting (Simple table for testing)
        GridWindow gridWindow = createGridWindow(AD_Window_ID);
        GridTab gridTab = gridWindow.getTab(0);
        gridTab.addDataStatusListener(newGridTabDataStatusListener(gridWindow));

        // Initialize the query to load the tab state
        gridTab.setQuery(MQuery.getNoRecordQuery(gridTab.getTableName(), true));
        gridTab.query(false, 0, 0);

        // Create New Record
        boolean created = gridTab.dataNew(false);
        assertTrue(created, "Failed to initialize a new record via dataNew()");
        String uniqueName = "UnitTest_" + System.currentTimeMillis();
        gridTab.setValue(X_C_Greeting.COLUMNNAME_Name, uniqueName);
        gridTab.setValue(X_C_Greeting.COLUMNNAME_Greeting, "Test");
        boolean saved = gridTab.dataSave(true);
        assertTrue(saved, "Failed to save the new record. " + getMessage(gridTab));
        
        int record_ID = gridTab.getRecord_ID();
        assertTrue(record_ID > 0, "Record ID should be valid after save");

        MTable table = MTable.get(Env.getCtx(), gridTab.getAD_Table_ID());
        PO result = table.getPO(record_ID, getTrxName());
        assertNotNull(result, "Record should exist in the database after save");
        
        // Delete
        boolean deleted = gridTab.dataDelete();
        assertTrue(deleted, "dataDelete() returned false. " + getMessage(gridTab));

        // Verify Database
        result = table.getPO(record_ID, getTrxName());        
        assertNull(result, "Record should be null (deleted) in the database");
    }

	private String getMessage(GridTab gridTab) {
		return gridTab.getLastDataStatusEvent() != null 
			? " Reason: " + gridTab.getLastDataStatusEvent().getAD_Message() 
					+ (gridTab.getLastDataStatusEvent().getInfo() != null ? " - " + gridTab.getLastDataStatusEvent().getInfo() : "")
			: "";
	}
	
	/**
	 * Test dataRefreshAll(boolean fireEvent, boolean retainedCurrentRow)
	 * Scenario:
	 * 1. Load a tab with data.
	 * 2. Navigate to a row other than 0.
	 * 3. Call dataRefreshAll with retainedCurrentRow = false.
	 * 4. Verify that the selection resets to 0.
	 */
	@Test
	public void testDataRefreshAll_ResetSelection()
	{
		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		GridWindow gw = createGridWindow(AD_Window_ID);
		GridTab gt = gw.getTab(0);

		// 2. Execution: Load data
		gt.query(false, 0, 3);

		// Pre-condition Assertion: Ensure we have enough data to test navigation
		assertTrue(gt.getRowCount() > 1, "Test requires at least 2 records in C_Order");

		// Move current row to second row (index 1)
		gt.navigate(1);
		assertEquals(1, gt.getCurrentRow(), "Pre-condition failed: Current row should be 1 before refresh");
		
		gt.addToSelection(0);
		gt.addToSelection(1);
		assertEquals(2, gt.getSelection().length);

		// Action: Refresh without retaining the current row
		gt.dataRefreshAll(true);

		// Current row remain and Selection should be reset to 0
		assertEquals(1, gt.getCurrentRow(), "Current row should remain as 1 after dataRefreshAll(..., false)");
		assertEquals(0, gt.getSelection().length, "Selection should be reset to 0 after dataRefreshAll(..., false)");
		
		gw.dispose();
		assertTrue(gw.getTabCount() == 0, "GridWindow should have 0 tabs after dispose()");
	}
	
	/**
	 * Test dataRefreshAll(boolean fireEvent, boolean retainedCurrentRow)
	 * Scenario:
	 * 1. Load a tab with query.
	 * 2. Make changes to a row with MTest
	 * 3. Call dataRefreshAll with retainedCurrentRow = true/false.
	 * 4. Verify that the current row is retained or not based on the parameter.
	 */
	@Test
	public void testDataRefreshAll_RetainedCurrentRow()
	{
		int AD_Window_ID = SystemIDs.WINDOW_TEST;
		
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		String description = UUID.randomUUID().toString();
		t1.setDescription(description);
		t1.saveEx();
		
		MTest t2 = new MTest(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		t2.setDescription(description);
		t2.saveEx();
		
		GridWindow gw = createGridWindow(AD_Window_ID);
		GridTab gt = gw.getTab(0);
		gt.getTableModel().setImportingMode(true, getTrxName());

		// Execution: Load data
		MQuery query = new MQuery(MTest.Table_Name);
		query.addRestriction(MTest.COLUMNNAME_Description, MQuery.EQUAL, description);
		gt.setQuery(query);
		gt.query(false);

		// Make t2 current row
		assertEquals(2, gt.getRowCount(), "Query should return 2 records in MTest");
		gt.navigate(0);
		if (gt.getRecord_ID() != t2.get_ID())
			gt.navigate(1);

		// Change t2 to make it not match the query above
		t2.setDescription("Changed");
		t2.saveEx();
		
		// retained t2
		gt.dataRefreshAll(true, true);
		assertEquals(2, gt.getRowCount(), "After dataRefreshAll(..., true), Row Count should still be 2");

		// not retained t2
		gt.dataRefreshAll(true, false);
		assertEquals(1, gt.getRowCount(), "After dataRefreshAll(..., false), Row Count should be 1");
	}
	
	/**
	 * Test dataIgnore()
	 * Scenario:
	 * 1. Load a tab and select a record.
	 * 2. Modify a field (Description) in memory.
	 * 3. Verify the field is updated in the buffer.
	 * 4. Call dataIgnore().
	 * 5. Verify the field reverts to the original database value.
	 */
	@Test
	public void testDataIgnore_RevertsChanges()
	{
		int AD_Window_ID = SystemIDs.WINDOW_TEST;
		GridWindow gw = createGridWindow(AD_Window_ID);
		GridTab gt = gw.getTab(0);

		// Load data
		gt.query(false, 0, 3);
		
		// Ensure we have a record to modify
		assertTrue(gt.getRowCount() > 0, "Test requires at least 1 record");
		
		// Store the original value of the Name column
		String column = "Name";
		Object originalValue = gt.getValue(column);
		
		// Modify the value
		String testValue = "UnitTest_Modified_" + System.currentTimeMillis();
		gt.setValue(column, testValue);		
		// Assert the change is reflected in the current memory buffer
		assertEquals(testValue, gt.getValue(column), "Value should be updated in memory before ignore");
		assertTrue(gt.isNeedSaveAndMandatoryFill(), "GridTab should indicate unsaved changes after modification");
		assertTrue(gt.needSave(true, true), "GridTab should indicate unsaved changes after modification");
		
		// Action: Ignore changes
		gt.dataIgnore();
		
		// Value should be reverted
		assertEquals(originalValue, gt.getValue(column), "Value should revert to original after dataIgnore()");
		assertFalse(gt.isNeedSaveAndMandatoryFill(), "GridTab should indicate no changes after dataIgnore()");
		assertFalse(gt.needSave(true, true), "GridTab should indicate no changes after dataIgnore()");
	}
	
	@Test
	void testStatusLineWidget() {
		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		GridWindow gw = createGridWindow(AD_Window_ID);
		GridTab gt = gw.getTab(0);

		// Load data
		gt.query(false, 0, 3);
		assertTrue(gt.getRowCount() > 0, "Test requires at least 1 records in C_Order");
		
		// StatusLine Name | StatusLine_ID | AD_Table_ID | AD_StatusLine_ID | ad_statuslineusedin_id
		// OrderSummary | 200000 | 259 | 200000 | 200000
		// Test getStatusLine
		MStatusLineUsedIn usedInModel = new MStatusLineUsedIn(Env.getCtx(), 200000, null);		
		MStatusLineUsedIn usedInModelSpy = spy(usedInModel);
		if (!usedInModelSpy.isStatusLine())
			doReturn(true).when(usedInModelSpy).isStatusLine();
		String statusLine = gt.getStatusLine();
		assertNotNull(statusLine, "Status line should not be null");
		assertTrue(statusLine.length() > 0, "Status line should not be empty");

		// Test getStatusLinesWidget and style
		MStatusLine statusLineModel = new MStatusLine(Env.getCtx(), usedInModel.getAD_StatusLine_ID(), null);
		MStatusLine statusLineSpy = spy(statusLineModel);
		doReturn(Integer.MAX_VALUE).when(statusLineSpy).getAD_Style_ID();
		MStyle style = new MStyle(Env.getCtx(), 0, null);
		MStyle styleSpy = spy(style);
		String css = "span {font-size:14px; color:#0000FF;}";
		doReturn(css).when(styleSpy).buildStyle(anyString(), any(), anyBoolean());
		try (MockedStatic<MStyle> mockedStyle = mockStatic(MStyle.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MStatusLine> mockedStatusLine = mockStatic(MStatusLine.class);) {
		    mockedStyle.when(() -> MStyle.get(Integer.MAX_VALUE)).thenReturn(styleSpy);
		    mockedStatusLine.when(() -> MStatusLine.getStatusLinesWidget(anyInt(), anyInt(), anyInt())).thenReturn(new MStatusLine[] {statusLineSpy});
		    doReturn(true).when(usedInModelSpy).isStatusLine();
			String statusLineWidget = gt.getStatusLinesWidget();
			assertNotNull(statusLineWidget, "Status line widget should not be null");
			assertTrue(statusLineWidget.length() > 0, "Status line widget should not be empty");
			assertTrue(statusLineWidget.contains(css), "Status line widget should contain style from MStyle");
		}										
	}
	
	/**
	 * Test asynchronous initialization: GridTab.init(true)
	 * Scenario:
	 * 1. Get a GridTab instance without initializing it synchronously.
	 * 2. Trigger initTab(true) to start background loading.
	 * 3. Wait for completion.
	 * 4. Verify the tab is loaded and fields exist.
	 */
	@Test
	public void testInitTab_Async()
	{
		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		var gWindowVO = GridWindowVO.create(Env.getCtx(), 1, AD_Window_ID);
		GridWindow gw = new GridWindow(gWindowVO, true);
		
		// Get the tab object directly. 
		// Note: We are NOT calling gw.initTab(0) here because that usually triggers sync loading.
		GridTab gt = gw.getTab(0);

		// Verify initial state is not loaded
		assertFalse(gt.isLoadComplete(), "Tab should not be loaded before init is called");

		// Initialize Asynchronously
		boolean init = gt.initTab(true);
		assertFalse(init, "initTab(true) should return false immediately as loading is async");
		assertFalse(gt.isLoadComplete(), "Tab should not be loaded yet since init is async");
		assertEquals(0, gt.getFieldCount(), "Tab should have zero fields before async loading completes");
		
		// Synchronization: Wait for the async task to finish
		gt.waitLoadComplete();
		assertTrue(gt.isLoadComplete(), "Tab should be marked as loaded after waitLoadComplete()");
		assertTrue(gt.getFieldCount() > 0, "Tab should have fields loaded after async loading completes");
	}
	
	/**
	 * Test dataRefresh(int row, boolean fireEvent)
	 * Scenario:
	 * 1. Create a new MTest record directly in DB.
	 * 2. Load the Test Window (SystemIDs.WINDOW_TEST).
	 * 3. Verify GridTab sees the original data.
	 * 4. Update the MTest record in DB (simulate external change).
	 * 5. Call dataRefresh on the specific row.
	 * 6. Verify GridTab reflects the new data.
	 */
	@Test
	public void testDataRefresh_ReflectsExternalChanges()
	{
		// Setup: Create a specific record to test
		MTest mTest = new MTest(Env.getCtx(), 0, null);
		String originalName = "Original_" + System.currentTimeMillis();
		mTest.setName(originalName);
		mTest.saveEx();
		
		try {
			int testRecordID = mTest.get_ID();
	
			GridWindow gw = createGridWindow(SystemIDs.WINDOW_TEST);
			GridTab gt = gw.getTab(0);
	
			// Load data and find our record
			MQuery query = new MQuery(MTest.Table_Name);
			query.addRestriction(MTest.COLUMNNAME_Test_ID, MQuery.EQUAL, testRecordID);
			gt.setQuery(query);
			gt.query(false);		
			assertTrue(gt.getKeyID(0) == testRecordID, "Newly created MTest record not found in GridTab query");
			assertEquals(originalName, gt.getValue(MTest.COLUMNNAME_Name), "GridTab should have original value");
	
			// External Update: Modify the record in the DB behind the GridTab's back
			String updatedName = "Updated_" + System.currentTimeMillis();
			mTest.setName(updatedName);
			mTest.saveEx();
	
			// Refresh the specific row
			gt.dataRefresh(0, true);	
			// GridTab should now show the updated value
			assertEquals(updatedName, gt.getValue(MTest.COLUMNNAME_Name), "GridTab should reflect external change after dataRefresh");
		} finally {
			rollback();
			// Cleanup
			mTest.deleteEx(true);
		}
	}
	
	/**
	 * Test resetDetailForNewParentRecord()
	 * Scenario:
	 * 1. Initialize Sales Order Window (Parent: Order, Detail: Order Line).
	 * 2. Call resetDetailForNewParentRecord() on the Detail Tab.
	 * 3. Verify Detail Tab has 0 row.
	 */
	@Test
	public void testResetDetailForNewParentRecord()
	{
		var gridWindow = createGridWindow(SystemIDs.WINDOW_SALES_ORDER);
		
		GridTab headerTab = gridWindow.getTab(0);
		headerTab.query(false, 0, 3);
		assertTrue(headerTab.getRowCount() > 0, "Header tab (Order) should have data after query");
		headerTab.setCurrentRow(0);
		GridTab detailTab = gridWindow.getTab(1);
		detailTab.query(false, 0, 0);
		assertTrue(detailTab.getRowCount() > 0, "Detail tab (Order Line) should be queryable");
		detailTab.setCurrentRow(0);
		assertFalse(detailTab.isNew(), "Detail tab current row should not be New");
		
		headerTab.dataNew(false);
		detailTab.resetDetailForNewParentRecord();
		assertEquals(0, detailTab.getRowCount(), "Detail tab should have 0 row after reset");
		
	}
	
	@Test
	void testGetDependentOn() {
		var gridWindow = createGridWindow(SystemIDs.WINDOW_PRODUCT);
		GridTab displayLogicTab = null;
		for (int i = 0; i < gridWindow.getTabCount(); i++) {
			GridTab gTab = gridWindow.getTab(i);
			if (!Util.isEmpty(gTab.getDisplayLogic())) {
				displayLogicTab = gTab;
				break;
			}
		}
		assertNotNull(displayLogicTab, "No tab with Display Logic found");
		try (MockedStatic<CLogMgt> mockLogMgt = mockStatic(CLogMgt.class, Mockito.CALLS_REAL_METHODS)) {
			mockLogMgt.when(() -> CLogMgt.isLevelFiner()).thenReturn(true);
			ArrayList<String> dependents = displayLogicTab.getDependentOn();
			assertTrue(dependents.size() > 0, "No dependent columns found for tab with Display Logic");
		}
		
	}
	
	@Test
	void testLoadPhoneFormat() {
		var gridWindow = createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		
		GridTab gTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.C_AND_W.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() == 1, "No records found in Business");
		gTab.setCurrentRow(0);
		GridTab locationTab = null;
		for (int i = 0; i < gridWindow.getTabCount(); i++) {
			var tab = gridWindow.getTab(i);
			if (tab.getAD_Table_ID() == MBPartnerLocation.Table_ID) {
				locationTab = tab;
				break;
			}
		}

		assertNotNull(locationTab, "Location Tab not found");
		locationTab.query(false, 0, 0);
		GridField fPhone = locationTab.getField(X_C_BPartner_Location.COLUMNNAME_Phone);
		assertNotNull(fPhone, "Phone Format is null");
		assertTrue(!Util.isEmpty(fPhone.getVFormat(), true), "Phone Format is empty");
	}

	private GridWindow createGridWindow(int AD_Window_ID) {
		var gWindowVO = GridWindowVO.create(Env.getCtx(), 1, AD_Window_ID);
		var gridWindow = new GridWindow(gWindowVO, true);
		for (int i = 0; i < gridWindow.getTabCount(); i++) {
			gridWindow.initTab(i);
			GridTab gTab = gridWindow.getTab(i);
			gTab.addDataStatusListener(newGridTabDataStatusListener(gridWindow));
		}
		return gridWindow;
	}
	
	@Test
	void testGetNumColumns() {
		var gridWindow = createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		GridTab gTab = gridWindow.getTab(0);
		assertEquals(9, gTab.getNumColumns(), "Number of columns in Business Partner tab mismatch");
	}
	
	@Test
    void testIsCurrent() {
        int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
        
        GridWindow window = createGridWindow(AD_Window_ID);
        GridTab bpTab = window.getTab(0);   // Parent Tab (Business Partner)
        GridTab contactsTab = window.getTab(1);  // Child Tab (Contact)
        
        // Setup: Ensure we have at least 2 records in the parent tab to switch between.
        String whereClause = "Value IN ('C&W', 'SeedFarm')";
        MQuery query = new MQuery(MBPartner.Table_Name);
        query.addRestriction(whereClause);
        bpTab.setQuery(query);
        bpTab.query(false);
        
        assertTrue(bpTab.getRowCount() >= 2, "Setup failed: Expected at least 2 tables to test navigation");
        
        // Select the first record in Parent
        bpTab.navigate(0);
        
        // Query the child tab to synchronize it with the current parent (Row 0)
        contactsTab.query(false);
        assertTrue(contactsTab.isCurrent(), "Child tab should be current after initial query");
        
        // Action: Move Parent to the second record
        // This changes the context (e.g., C_BPartner_ID) which the child tab relies on.
        bpTab.navigate(1);
        
        // The child tab is now pointing to the OLD parent ID, but the Context has the NEW parent ID.
        // Therefore, isCurrent() should return false.
        assertFalse(contactsTab.isCurrent(), "Child tab should NOT be current after parent record changed");
        
        // Recovery: Refresh the child tab
        contactsTab.query(false);
        assertTrue(contactsTab.isCurrent(), "Child tab should be current again after refresh");
	}
	
	@Test
	void testNavigate() {
		GridWindow gridWindow = createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		GridTab gridTab = gridWindow.getTab(0);

		// Test when gridTab is not initialized (no data queried yet)
		// Expectation: Row count is 0, navigation to 0 should fail or result in -1 (no row selected)
		assertEquals(0, gridTab.getRowCount(), "Tab should be empty before query");		
		assertEquals(-1, gridTab.navigate(0), "Current row should be -1 when navigating in an empty tab");

		// Initialize and Query Data
		gridTab.query(false, 0, 10);
		
		// Ensure we have data to test valid navigation
		if (gridTab.getRowCount() > 0) {
			
			// Test when target row is valid
			int validRow = 0;			
			assertEquals(validRow, gridTab.navigate(validRow), "Should successfully navigate to valid row 0");
			validRow = 1;			
			assertEquals(validRow, gridTab.navigate(validRow), "Should successfully navigate to valid row 1");

			// Test when target row is invalid (out of bounds)
			// Current row will move to last valid row
			int invalidRow = gridTab.getRowCount() + 100;
			int lastRowIndex = gridTab.getRowCount() - 1;
			assertEquals(lastRowIndex, gridTab.navigate(invalidRow), "Should not navigate to an invalid row index");			
		} else {
			fail("WARNING: SystemIDs.WINDOW_BUSINESS_PARTNER has no records. Valid row navigation test skipped.");
		}
	}
	
	@Test
	public void testRefreshParentTabs() {
		// Setup Data: Create an Order with one Line
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id));
		order.saveEx();

		MOrderLine line = new MOrderLine(order);
		line.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line.setQty(BigDecimal.ONE);
		line.setPrice(new BigDecimal("100.00"));
		line.saveEx();

		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		GridWindow gridWindow = createGridWindow(AD_Window_ID);
		
		GridTab parentTab = gridWindow.getTab(0); // Order Tab
		parentTab.getTableModel().setImportingMode(true, getTrxName());
		GridTab childTab = gridWindow.getTab(1);  // Order Line Tab
		childTab.getTableModel().setImportingMode(true, getTrxName());

		// Load the Order into the Parent Tab
		parentTab.setQuery(MQuery.getEqualQuery("C_Order_ID", order.get_ID()));
		parentTab.query(false, 0, 0);
		childTab.query(false);
		
		// Verify Parent Tab loaded the correct record
		assertEquals(order.get_ID(), parentTab.getRecord_ID(), "Parent Tab should be loaded with the test Order");

		// Modify Data in Database (Simulate a change that affects the parent)
		line.setPrice(new BigDecimal("200.00"));
		line.saveEx();
		
		// Verify DB has the new total
		MOrder updatedOrder = new MOrder(Env.getCtx(), order.get_ID(), getTrxName());
		BigDecimal newTotal = updatedOrder.getTotalLines();
		assertEquals(0, newTotal.compareTo(new BigDecimal("200.00")), "DB Total should be updated to 200.00");

		// Set the C_Order_ID in context so the child tab knows its parent link
		Env.setContext(Env.getCtx(), 1, "C_Order_ID", order.get_ID());
		
		childTab.refreshParentTabs(true);

		// Assert Parent Tab is Refreshed
		BigDecimal refreshedTabTotal = (BigDecimal) parentTab.getValue("TotalLines");
		assertEquals(0, refreshedTabTotal.compareTo(newTotal), 
				"Parent Tab TotalLines should be refreshed to match the new DB value (200.00)");
	}
	
	/**
     * Tests that the "IsSOTrx" window context is set from C_DocType 
     * after navigation to a row.
     */
    @Test
    public void testIsSOTrxContextByDocType() {
        int AD_Window_ID = SystemIDs.WINDOW_BANK_STATEMENT;

        // Create two Document Types with different IsSOTrx settings
        // DocType 1: Sales Transaction (IsSOTrx = Y)
        MDocType docTypeSales = new MDocType(Env.getCtx(), 0, null);
        docTypeSales.setName("Test Bank Statement Sales " + System.currentTimeMillis());
        docTypeSales.setPrintName(docTypeSales.getName());
        docTypeSales.setGL_Category_ID();
        docTypeSales.setDocBaseType(MDocType.DOCBASETYPE_BankStatement); // "CMB"
        docTypeSales.setIsSOTrx(true);
        docTypeSales.saveEx();

        // DocType 2: Purchase Transaction (IsSOTrx = N)
        MDocType docTypePurchase = new MDocType(Env.getCtx(), 0, null);
        docTypePurchase.setName("Test Bank Statement Purchase " + System.currentTimeMillis());
        docTypePurchase.setPrintName(docTypePurchase.getName());
        docTypePurchase.setGL_Category_ID();
        docTypePurchase.setDocBaseType(MDocType.DOCBASETYPE_BankStatement); // "CMB"
        docTypePurchase.setIsSOTrx(false);
        docTypePurchase.saveEx();

        try {
	        // Initialize the GridWindow and GridTab
	        GridWindow gridWindow = createGridWindow(AD_Window_ID);
	        GridTab gridTab = gridWindow.getTab(0); 
	        gridTab.getTableModel().setImportingMode(true, getTrxName());
	        gridTab.setQuery(MQuery.getNoRecordQuery(gridTab.getTableName(), true));
	        gridTab.query(false, 0, 0);
	
	        // Create first row
	        gridTab.dataNew(false);
	        // Test setting DocType to Sales (IsSOTrx = Y)
	        gridTab.setValue("C_DocType_ID", docTypeSales.getC_DocType_ID());
	        gridTab.setValue(MBankStatement.COLUMNNAME_C_BankAccount_ID, DictionaryIDs.C_BankAccount.ACCOUNT_1234.id); // Set mandatory Bank Account
	        assertTrue(gridTab.dataSave(true), "Failed to save record with Sales DocType " + getMessage(gridTab));
	        
	        // Create second row
	        gridTab.dataNew(false);
	        // Test setting DocType to Purchase (IsSOTrx = N)
	        gridTab.setValue("C_DocType_ID", docTypePurchase.getC_DocType_ID());
	        gridTab.setValue(MBankStatement.COLUMNNAME_C_BankAccount_ID, DictionaryIDs.C_BankAccount.ACCOUNT_1234.id); // Set mandatory Bank Account
	        assertTrue(gridTab.dataSave(true), "Failed to save record with Purchase DocType " + getMessage(gridTab));
	        
	        // Verify the context variable "IsSOTrx" is updated to "Y" for row 1
	        gridTab.setCurrentRow(0);	        
	        String isSOTrxCtx = Env.getContext(Env.getCtx(), gridWindow.getWindowNo(), "IsSOTrx");
	        assertEquals("Y", isSOTrxCtx, "Context IsSOTrx should be 'Y' for Sales DocType");
	
	        // Verify the context variable "IsSOTrx" is updated to "N"
	        gridTab.setCurrentRow(1);	        
	        isSOTrxCtx = Env.getContext(Env.getCtx(), gridWindow.getWindowNo(), "IsSOTrx");
	        assertEquals("N", isSOTrxCtx, "Context IsSOTrx should be 'N' for Purchase DocType");
        } finally {
        	rollback();
        	docTypePurchase.deleteEx(true);
        	docTypeSales.deleteEx(true);
        }
    }
    
    @Test
    void testHasChangedCurrentTabAndParents() {
    	var gridWindow = createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);		
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.C_AND_W.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() == 1, "No records found in Business");
		
		var childTab = gridWindow.getTab(1);
		childTab.getTableModel().setImportingMode(true, getTrxName());
		childTab.query(false, 0, 0);
		
		MUser user = new MUser(Env.getCtx(), childTab.getRecord_ID(), getTrxName());
		assertEquals(childTab.getValue("Name"), user.getName(), "User name mismatch");
		user.setDescription("Updated Description " + System.currentTimeMillis());
		user.saveEx();
		
		childTab.setValue("Description", "Updated Description " + System.currentTimeMillis());
		assertTrue(childTab.hasChangedCurrentTabAndParents(), "hasChangedCurrentTabAndParents should return true after external change");		
		assertFalse(childTab.dataSave(true), "dataSave should return false due to external changes");
		
		childTab.dataRefresh(childTab.getCurrentRow(), true);
		childTab.setValue("Description", "Updated Description " + System.currentTimeMillis());
		assertFalse(childTab.hasChangedCurrentTabAndParents(), "hasChangedCurrentTabAndParents should return false after refresh");
		assertTrue(childTab.dataSave(true), "dataSave should return true after refresh and local change");
		
		MBPartner bpartner = new MBPartner(Env.getCtx(), gTab.getRecord_ID(), getTrxName());
		bpartner.setDescription("Updated Description " + System.currentTimeMillis());
		bpartner.saveEx();
		
		childTab.setValue("Description", "Updated Description " + System.currentTimeMillis());
		assertTrue(childTab.hasChangedCurrentTabAndParents(), "hasChangedCurrentTabAndParents should return true after external change to parent");		
		assertFalse(childTab.dataSave(true), "dataSave should return false due to external changes to parent");
    }
    
    /**
	 * Test GridTab.isDisplayed() logic by manipulating the DisplayLogic in the VO.
	 */
	@Test
	void testIsDisplayed() {
		Properties ctx = Env.getCtx();
		
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;		

		// Create the Window Value Object (VO)
		int windowNo = 1;
		GridWindowVO windowVO = GridWindowVO.create(ctx, windowNo, AD_Window_ID);
		assertTrue(windowVO.Tabs.size() > 0, "Window must have tabs");

		// Test Case A: Tab should be displayed
		GridTabVO tabVO_Visible = windowVO.Tabs.get(0);
		
		// Inject "Always True" logic
		tabVO_Visible.DisplayLogic = "1=1"; 
		
		// Initialize Window and Tab from the modified VO
		GridWindow gridWindow = new GridWindow(windowVO);
		GridTab tabVisible = gridWindow.getTab(0);
		
		assertTrue(tabVisible.isDisplayed(), "Tab with DisplayLogic '1=1' should be displayed");

		// Test Case B: Tab should NOT be displayed		
		GridWindowVO windowVO_Hidden = GridWindowVO.create(ctx, windowNo + 1, AD_Window_ID);
		GridTabVO tabVO_Hidden = windowVO_Hidden.Tabs.get(0);
		
		// Inject "Always False" logic
		tabVO_Hidden.DisplayLogic = "1=2";
		
		GridWindow gridWindowHidden = new GridWindow(windowVO_Hidden);
		GridTab tabHidden = gridWindowHidden.getTab(0);
		
		assertFalse(tabHidden.isDisplayed(), "Tab with DisplayLogic '1=2' should NOT be displayed");
		
		// Test Case C: Tab visibility when no DisplayLogic is set
		windowVO = GridWindowVO.create(ctx, windowNo+2, AD_Window_ID);
		tabVO_Visible = windowVO.Tabs.get(0);
		
		// No display logic
		tabVO_Visible.DisplayLogic = ""; 
		
		// Initialize Window and Tab from the modified VO
		gridWindow = new GridWindow(windowVO);
		tabVisible = gridWindow.getTab(0);
		
		assertTrue(tabVisible.isDisplayed(), "Tab with no DisplayLogic should be displayed");
		
		// Test Case D: Tab with cotext-dependent DisplayLogic
		windowVO = GridWindowVO.create(ctx, windowNo+3, AD_Window_ID);
		tabVO_Visible = windowVO.Tabs.get(0);
		
		// No display logic
		tabVO_Visible.DisplayLogic = "@TestVar@='Y'"; 
		
		// Initialize Window and Tab from the modified VO
		gridWindow = new GridWindow(windowVO);
		tabVisible = gridWindow.getTab(0);
		
		Env.setContext(Env.getCtx(), windowNo+3, "TestVar", "Y");
		assertTrue(tabVisible.isDisplayed(), "Tab should be displayed when TestVar='Y'");
		
		Env.setContext(Env.getCtx(), windowNo+3, "TestVar", "N");
		assertFalse(tabVisible.isDisplayed(), "Tab should NOT be displayed when TestVar!='Y'");
		
		// Verify: False (TestVar is removed)
		Env.setContext(Env.getCtx(), windowNo+3, "TestVar", (String)null);
		assertFalse(tabVisible.isDisplayed(), "Tab should NOT be displayed when TestVar is null");
	}
	
	@Test
	void testGetMaxQueryRecords() {
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
		var gridWindow = createGridWindow(AD_Window_ID);
		assertTrue(gridWindow.getTabCount() > 0, "Tab Count is Zero. AD_Window_ID=" + AD_Window_ID);

		GridTab gTab = gridWindow.getTab(0);
		int maxRecords = gTab.getMaxQueryRecords();
		assertTrue(maxRecords > 0, "getMaxQueryRecords should return a positive value, got: " + maxRecords);
	}
	
	@Test
	void testIsQueryRequire() {
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
		var gridWindow = createGridWindow(AD_Window_ID);
		assertTrue(gridWindow.getTabCount() > 0, "Tab Count is Zero. AD_Window_ID=" + AD_Window_ID);

		GridTab gTab = gridWindow.getTab(0);
		int maxRecords = gTab.getMaxQueryRecords();

		MRole role = MRole.getDefault();
		MRole roleSpy = spy(role);
		doReturn(maxRecords).when(roleSpy).getConfirmQueryRecords();
		
		try (MockedStatic<MRole> mockedRole = mockStatic(MRole.class, Mockito.CALLS_REAL_METHODS);) {
			mockedRole.when(() -> MRole.getDefault()).thenReturn(roleSpy);

			// Should not require query if less than or equal to max
			assertFalse(gTab.isQueryRequire(1), "isQueryRequire should be false for rowCount < 2");
			assertFalse(gTab.isQueryRequire(maxRecords - 1), "isQueryRequire should be false for rowCount < maxRecords");
			assertFalse(gTab.isQueryRequire(maxRecords), "isQueryRequire should be false for rowCount == maxRecords");
			// Should require query if greater than max
			assertTrue(gTab.isQueryRequire(maxRecords + 1), "isQueryRequire should be true for rowCount > maxRecords");
		}
	}
}
