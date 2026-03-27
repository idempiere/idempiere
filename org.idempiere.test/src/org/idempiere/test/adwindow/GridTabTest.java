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
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
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
import static org.mockito.ArgumentMatchers.startsWith;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.when;

import java.beans.PropertyVetoException;
import java.beans.VetoableChangeListener;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLTimeoutException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.UUID;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.atomic.AtomicInteger;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.MTabCustomization;
import org.compiere.Adempiere;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTabVO;
import org.compiere.model.GridTable;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MAttachment;
import org.compiere.model.MBPartner;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MBankStatement;
import org.compiere.model.MChat;
import org.compiere.model.MColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MField;
import org.compiere.model.MImportTemplate;
import org.compiere.model.MLabel;
import org.compiere.model.MLabelAssignment;
import org.compiere.model.MLookup;
import org.compiere.model.MMessage;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrg;
import org.compiere.model.MPostIt;
import org.compiere.model.MPrivateAccess;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MRule;
import org.compiere.model.MStatusLine;
import org.compiere.model.MStatusLineUsedIn;
import org.compiere.model.MStyle;
import org.compiere.model.MTable;
import org.compiere.model.MTest;
import org.compiere.model.MTestUU;
import org.compiere.model.MUser;
import org.compiere.model.MWarehouse;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_C_BPartner_Location;
import org.compiere.model.X_C_Greeting;
import org.compiere.model.X_M_Substitute;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.CPreparedStatement;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.compiere.util.Util;
import org.idempiere.db.util.SQLFragment;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * 
 * @author hengsin
 *
 */
@Isolated
public class GridTabTest extends AbstractTestCase {

	private static final int FIELD_ORDERLINE_SHIPPER = 1135;

	public GridTabTest() {
	}

	@Test
	public void testQuery() {		
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
		gTab.getTableModel().setImportingMode(true, getTrxName());
		assertTrue(gTab.getRowCount() == 1, "GridTab Row Count is not 1. GridTab=" + gTab.getName());

		String name = (String) gTab.getValue("Name");
		MBPartner bpartner = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
		assertTrue(bpartner.getName().equals(name), "GridTab Name != MBPartner.getName(). GridTab.Name="+name + " MBPartner.getName="+bpartner.getName());
		
		//test query with no restriction
		query = new MQuery(MBPartner.Table_Name);
		gTab.setQuery(query);
		gTab.query(false, 0, 3);
		assertTrue(gTab.getRowCount() >= 3, "GridTab Row Count is less than 3. GridTab="+gTab.getName());
		
		//test query with 2 restrictions
		query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_IsCustomer, MQuery.EQUAL, "Y");
		query.addRestriction(MBPartner.COLUMNNAME_IsVendor, MQuery.EQUAL, "Y");
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "GridTab Row Count is 0. GridTab="+gTab.getName());
		int customerCount = 0;
		int vendorCount = 0;
		for(int row = 0; row < gTab.getRowCount(); row++) {
			gTab.setCurrentRow(row);
			Boolean isCustomer = (Boolean) gTab.getValue(MBPartner.COLUMNNAME_IsCustomer);
			if (isCustomer != null && isCustomer.booleanValue())
				customerCount++;
			Boolean isVendor = (Boolean) gTab.getValue(MBPartner.COLUMNNAME_IsVendor);
			if (isVendor != null && isVendor.booleanValue())
				vendorCount++;
		}
		assertTrue(customerCount == vendorCount && customerCount == gTab.getRowCount(), "GridTab Row Count != Customer/Vendor count. GridTab="+gTab.getName()
				+ " RowCount="+gTab.getRowCount() + " CustomerCount="+customerCount + " VendorCount="+vendorCount);
		
		// test with function
		query = new MQuery(MBPartner.Table_Name);
		query.addRestriction("Upper("+MBPartner.COLUMNNAME_Name+")", MQuery.EQUAL, bpartner.getName().toUpperCase());
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount()==1, "GridTab Row Count is not 1. GridTab="+gTab.getName());
		assertEquals(bpartner.getName(), gTab.getValue(MBPartner.COLUMNNAME_Name), "GridTab Name != MBPartner.getName. GridTab.Name="+gTab.getValue(MBPartner.COLUMNNAME_Name) + " MBPartner.getName="+bpartner.getName());
		
		// test with reference column
		query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MOrder.COLUMNNAME_Bill_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount()==1, "GridTab Row Count is not 1. GridTab="+gTab.getName());
		assertEquals(DictionaryIDs.C_BPartner.JOE_BLOCK.id, gTab.getRecord_ID(), "GridTab Record_ID != BP_JOE_BLOCK id. GridTab.Record_ID="+gTab.getRecord_ID());
		
		// test with set negative current row
		assertEquals(0, gTab.setCurrentRow(-1, true),
				"Setting current row to -1 did not result in 0. GridTab=" + gTab.getName());
		assertEquals(0, gTab.getCurrentRow(), "Current row is not 0 after setting to -1. GridTab=" + gTab.getName());

		// test two email address don't confuse the parse context variable logic
		bpartner.setDescription("test1@test.com,test2@test.com");
		bpartner.saveEx();
		query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_Description, MQuery.EQUAL, "test1@test.com,test2@test.com");
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() == 1, "GridTab Row Count is not 1. GridTab=" + gTab.getName());
		assertEquals(DictionaryIDs.C_BPartner.JOE_BLOCK.id, gTab.getRecord_ID(),
				"GridTab Record_ID != BP_JOE_BLOCK id. GridTab.Record_ID=" + gTab.getRecord_ID());
		
		// test parsing of @CreatedBy@
		Env.setContext(Env.getCtx(), gTab.getWindowNo(), "CreatedBy", DictionaryIDs.AD_User.SUPER_USER.id);
		query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_CreatedBy, MQuery.EQUAL, "@CreatedBy:0@");
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "GridTab Row Count is not > 0. GridTab=" + gTab.getName());
		assertEquals(DictionaryIDs.AD_User.SUPER_USER.id, gTab.getValue(MBPartner.COLUMNNAME_CreatedBy),
				"GridTab CreatedBy != SUPER_USER id. GridTab.CreatedBy=" + gTab.getValue(MBPartner.COLUMNNAME_CreatedBy));
	}
	
	@Test
	public void testCallout() {
		//Sales Order
		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
			var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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

			gTab1.addToSelection(0);
			assertTrue(gTab1.getSelection().length > 0, "Selection is not working as expected");
			assertTrue(gTab1.dataNew(false));
			assertTrue(gTab1.getSelection().length == 0, "Selection should be cleared after dataNew");
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

	static DataStatusListener newGridTabDataStatusListener(GridWindow gridWindow) {
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
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
		
		// test with no link column
		var spyTab = spy(gTab);
		doReturn("").when(spyTab).getLinkColumnName();
		spyTab.query(false, 0, 0);
		assertEquals(0, spyTab.getRowCount(), "GridTab Row Count should be 0 when link column is empty. GridTab=" + gTab.getName());
		
		// test with new parent record
		gTab = gridWindow.getTab(0);
		gTab.dataNew(false);
		assertTrue(gTab.isNew(), "Grid Tab dataNew call not working as expected");
		gTab = gridWindow.getTab(1);
		gTab.query(false, 0, 0);
		assertEquals(0, gTab.getRowCount(), "GridTab Row Count should be 0 when parent record is new. GridTab=" + gTab.getName());
		
		// revert parent
		gTab = gridWindow.getTab(0);
		gTab.dataIgnore();
		assertFalse(gTab.isNew(), "Grid Tab dataIgnore call not working as expected");
		gTab = gridWindow.getTab(1);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "GridTab Row Count is 0. GridTab=" + gTab.getName());
		
		// test explicit parent link column
		gTab = gridWindow.getTab(1);
		gTab.getVO().Parent_Column_ID = MColumn.getColumn_ID(MOrderLine.Table_Name, MOrderLine.COLUMNNAME_C_Order_ID);
		gTab.setLinkColumnName(null);
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "GridTab Row Count is 0. GridTab=" + gTab.getName());
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
			var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);

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
			
			//test switch with explicit sort field
			lineTab.navigate(0);
			lineTab.setValue(MOrderLine.COLUMNNAME_Processed, false);
			assertTrue(lineTab.dataSave(true), "Failed to save line 0");
			lineTab.navigate(1);
			lineTab.setValue(MOrderLine.COLUMNNAME_Processed, false);
			assertTrue(lineTab.dataSave(true), "Failed to save line 1");
			int lineColumnIndex = lineTab.getTableModel().findColumn(MOrderLine.COLUMNNAME_Line);
			assertTrue(lineColumnIndex >= 0, "Could not find Line column index in line");
			lineTab.switchRows(0, 1, lineColumnIndex, true);
			idRow1After = (Integer) lineTab.getValue(1, MOrderLine.COLUMNNAME_C_OrderLine_ID);
			assertEquals(idRow0Before, idRow1After, "Row1 should now contain former Row0 line");

			//test switch row without line and seqno field
			gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
			GridTab bpTab = gridWindow.getTab(0);
			bpTab.query(false, 0, 3);
			assertTrue(bpTab.getRowCount() >= 2, "Need at least 2 rows for switchRows test");
			Integer bpIdRow0Before = (Integer) bpTab.getValue(0, MBPartner.COLUMNNAME_C_BPartner_ID);
			bpTab.switchRows(0, 1, -1, true);
			assertEquals(bpIdRow0Before, (Integer) bpTab.getValue(0, MBPartner.COLUMNNAME_C_BPartner_ID), "Row switching without line/seqno field should not change ordering");
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
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
		
		//repeat lock/unlock to ensure no side effect
		gTab.lock(Env.getCtx(), recordID, true);
		gTab.isLocked();
		assertTrue(gTab.isLocked(), "Record should be locked");
		gTab.lock(Env.getCtx(), recordID, false);
		assertEquals(false, gTab.isLocked(), "Record should not be locked");
		
		//clean up
		MPrivateAccess access = MPrivateAccess.get (Env.getCtx(), getAD_User_ID(), gTab.getAD_Table_ID(), gTab.getRecord_ID());
		if (access != null) {
			access.deleteEx(true);
		}
	}
	
	/**
     * Test dataDelete() on a newly created record.
     */
    @Test
    public void testDataDelete_NewRecord() {
        int AD_Window_ID = 178; // AD_Greeting (Simple table for testing)
        GridWindow gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
		GridWindow gw = GridWindowTest.createGridWindow(AD_Window_ID);
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
		
		// test without fireEvent
		gt.addToSelection(0);
		gt.addToSelection(1);
		assertEquals(2, gt.getSelection().length);
		gt.dataRefreshAll(false);
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
		
		GridWindow gw = GridWindowTest.createGridWindow(AD_Window_ID);
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

		// still not retained t2
		gt.dataRefreshAll(true, false);
		assertEquals(2, gt.getRowCount(), "After dataRefreshAll(..., false), Row Count should still be 2");

		// not retained t2
		gt.query(false);
		assertEquals(1, gt.getRowCount(), "After query, Row Count should be 1");
		
		// test retain for multi-key tab
		gw = GridWindowTest.createGridWindow(SystemIDs.WINDOW_PRODUCT);
		gt = gw.getTab(0);
		gt.setUpdateWindowContext(true);
		gt.getTableModel().setImportingMode(true, getTrxName());
		query = new MQuery(MProduct.Table_Name);
		query.addRestriction(MProduct.COLUMNNAME_M_Product_ID, MQuery.EQUAL, DictionaryIDs.M_Product.AZALEA_BUSH.id);
		gt.setQuery(query);
		gt.query(false);
		assertEquals(1, gt.getRowCount(), "Query should return 1 record after filtering M_Product by AZALEA_BUSH");
		//find substitute tab - no key, 2 parent key
		GridTab stab = null;
		for(int i=1; i < gw.getTabCount(); i++)
		{
			GridTab tab = gw.getTab(i);
			if (tab.getAD_Table_ID() == X_M_Substitute.Table_ID)
			{
				stab = tab;
				break;
			}
		}
		assertNotNull(stab, "Could not find Substitute tab in Product window");
		stab.getTableModel().setImportingMode(true, getTrxName());		
		stab.query(false);
		assertTrue(stab.getRowCount() == 0, "Substitute tab should have no records for Azalea Bush");
		stab.dataNew(false);
		stab.setValue(X_M_Substitute.COLUMNNAME_M_Product_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id);
		stab.setValue(X_M_Substitute.COLUMNNAME_Substitute_ID, DictionaryIDs.M_Product.SEEDER.id);
		stab.setValue(X_M_Substitute.COLUMNNAME_Name, "Name 1");
		stab.setValue(X_M_Substitute.COLUMNNAME_Description, "Description");
		assertTrue(stab.dataSave(true), "Failed to save substitute record. " + getMessage(stab));
		stab.dataNew(false);
		stab.setValue(X_M_Substitute.COLUMNNAME_M_Product_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id);
		stab.setValue(X_M_Substitute.COLUMNNAME_Substitute_ID, DictionaryIDs.M_Product.MULCH.id);
		stab.setValue(X_M_Substitute.COLUMNNAME_Description, "Description");
		stab.setValue(X_M_Substitute.COLUMNNAME_Name, "Name 2");
		assertTrue(stab.dataSave(true), "Failed to save substitute record");
		query = new MQuery(X_M_Substitute.Table_Name);
		query.addRestriction(X_M_Substitute.COLUMNNAME_Description	, MQuery.EQUAL, "Description");
		stab.setQuery(query);
		stab.query(false);
		assertEquals(2, stab.getRowCount(), "Should have 2 substitute records for Azalea Bush");		
		stab.setValue(X_M_Substitute.COLUMNNAME_Description, "Description Updated");
		assertTrue(stab.dataSave(true), "Failed to save substitute record");
		stab.dataRefreshAll(true, true);
		assertEquals(2, stab.getRowCount(), "Should retain 2 record for substitute of Azalea Bush after dataRefreshAll with retainCurrentRow=true");
		stab.dataRefreshAll(true, false);
		assertEquals(2, stab.getRowCount(), "Should retain 2 record for substitute of Azalea Bush after dataRefreshAll with retainCurrentRow=false");
		stab.query(false);
		assertEquals(1, stab.getRowCount(), "Should retain 1 record for substitute of Azalea Bush after query");
		PO po = stab.getTableModel().getPO(0);
		assertNotNull(po, "PO should not be null for remaining substitute record");
		assertInstanceOf(X_M_Substitute.class, po, "PO should be instance of X_M_Substitute");
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
	public void testDataRefreshAll_RetainedCurrentRow_UU()
	{
		int AD_Window_ID = SystemIDs.WINDOW_TEST_UU;
		
		MTestUU t1 = new MTestUU(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
		t1.setName("t1_"+System.currentTimeMillis());
		String description = UUID.randomUUID().toString();
		t1.setDescription(description);
		t1.saveEx();
		
		MTestUU t2 = new MTestUU(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
		t2.setName("t2_"+System.currentTimeMillis());
		t2.setDescription(description);
		t2.saveEx();
		
		GridWindow gw = GridWindowTest.createGridWindow(AD_Window_ID);
		GridTab gt = gw.getTab(0);
		gt.getTableModel().setImportingMode(true, getTrxName());

		// Execution: Load data
		MQuery query = new MQuery(MTestUU.Table_Name);
		query.addRestriction(MTestUU.COLUMNNAME_Description, MQuery.EQUAL, description);
		gt.setQuery(query);
		gt.query(false);

		// Make t2 current row
		assertEquals(2, gt.getRowCount(), "Query should return 2 records in MTest");
		gt.navigate(0);
		if (!t2.get_UUID().equals(gt.getRecord_UU()))
			gt.navigate(1);

		// Change t2 to make it not match the query above
		t2.setDescription("Changed");
		t2.saveEx();
		
		// retained t2
		gt.dataRefreshAll(true, true);
		assertEquals(2, gt.getRowCount(), "After dataRefreshAll(..., true), Row Count should still be 2");

		// still retained t2
		gt.dataRefreshAll(true, false);
		assertEquals(2, gt.getRowCount(), "After dataRefreshAll(..., false), Row Count should still be 2");

		// not retained t2
		gt.query(false);
		assertEquals(1, gt.getRowCount(), "After query, Row Count should be 1");
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
		GridWindow gw = GridWindowTest.createGridWindow(AD_Window_ID);
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
		GridWindow gw = GridWindowTest.createGridWindow(AD_Window_ID);
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
		
		// test initTab(true) twice as alternative to waitLoadComplete
		gWindowVO = GridWindowVO.create(Env.getCtx(), 2, AD_Window_ID);
		gw = new GridWindow(gWindowVO, true);
		gt = gw.getTab(0);
		init = gt.initTab(true);
		assertFalse(init, "initTab(true) should return false immediately as loading is async");
		assertFalse(gt.isLoadComplete(), "Tab should not be loaded yet since init is async");
		assertEquals(0, gt.getFieldCount(), "Tab should have zero fields before async loading completes");
		init = gt.initTab(true);
		assertTrue(init, "initTab(true) should return true when called second time and triggering completion");
		assertTrue(gt.isLoadComplete(), "Tab should be marked as loaded after second initTab(true) call");
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
	
			GridWindow gw = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
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
			
			// Refresh without fireEvent
			updatedName = "Updated1_" + System.currentTimeMillis();
			mTest.setName(updatedName);
			mTest.saveEx();
			gt.dataRefresh(0, false);	
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
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_SALES_ORDER);
		
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
		assertFalse(detailTab.dataNew(false), "Detail tab dataNew should return false when header tab is new");		
	}
	
	@Test
	void testGetDependentOn() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_PRODUCT);
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
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		
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

	@Test
	void testGetNumColumns() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		GridTab gTab = gridWindow.getTab(0);
		assertEquals(9, gTab.getNumColumns(), "Number of columns in Business Partner tab mismatch");
	}
	
	@Test
    void testIsCurrent() {
        int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
        
        GridWindow window = GridWindowTest.createGridWindow(AD_Window_ID);
        GridTab bpTab = window.getTab(0);   // Parent Tab (Business Partner)
        GridTab contactsTab = window.getTab(1);  // Child Tab (Contact)
        
        // Setup: Ensure we have at least 2 records in the parent tab to switch between.
        String whereClause = "Value IN (?, ?)";
        MQuery query = new MQuery(MBPartner.Table_Name);
        query.addRestriction(new SQLFragment(whereClause, List.of("C&W", "SeedFarm")));
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
        
        int currentRow = bpTab.getCurrentRow();
        assertEquals(currentRow, bpTab.navigateCurrent(), "navigateCurrent() should return the current row index");
	}
	
	@Test
	void testNavigate() {
		GridWindow gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
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
		GridWindow gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
		
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
	        GridWindow gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
	
	        // Verify the context variable "IsSOTrx" is updated to "N" for row 2
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
    	var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);		
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
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
		assertTrue(gridWindow.getTabCount() > 0, "Tab Count is Zero. AD_Window_ID=" + AD_Window_ID);

		GridTab gTab = gridWindow.getTab(0);
		int maxRecords = gTab.getMaxQueryRecords();
		assertTrue(maxRecords > 0, "getMaxQueryRecords should return a positive value, got: " + maxRecords);
		assertTrue(gTab.isQueryMax(maxRecords + 1), "isQueryMax should return true for rowCount > maxRecords");
	}
	
	@Test
	void testIsQueryRequire() {
		int AD_Window_ID = SystemIDs.WINDOW_BUSINESS_PARTNER;
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
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
	
	@Test
	void testAttachment_PostIt_Chat_Label() {
		Properties ctx = Env.getCtx();
		// create bpartner
		MBPartner bp = new MBPartner(ctx ,0 , null);
		bp.setValue("BP" + System.currentTimeMillis());
		bp.setName("Test BP");
		bp.saveEx();
		int recordId = bp.get_ID();
		String recordUU = bp.get_UUID();
		int tableId = MTable.getTable_ID(MBPartner.Table_Name);
		
		MAttachment attachment = new MAttachment(ctx, tableId, recordId, recordUU, null);
		MPostIt postIt = new MPostIt(ctx, 0, null);
		MChat chat = new MChat(ctx, 0, null);
		MLabelAssignment labelAssignment = new MLabelAssignment(ctx, 0, null);
		MLabel label = new MLabel(ctx, 0, null);
		try(attachment) {			
			var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
			GridTab gt = gridWindow.getTab(0);
			
			//navigate to record
			MQuery query = new MQuery(MBPartner.Table_Name);
			query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, recordId);
			gt.setQuery(query);
			gt.query(false);
			
			assertEquals(1, gt.getRowCount(), "Should have one record");
			assertEquals(recordId, gt.getRecord_ID(), "Failed to navigate to test record");
			
			// test attachment
			attachment.setTextMsg("Test Attachment");
			attachment.addEntry("test.txt", "test data".getBytes());
			attachment.saveEx();
			int attachmentId = attachment.get_ID();		
			int AD_Attachment_ID = gt.getAD_AttachmentID();
			assertEquals(attachmentId, AD_Attachment_ID);

			// test postit
			postIt.setAD_Table_ID(tableId);
			postIt.setRecord_ID(recordId);
			postIt.setRecord_UU(recordUU);
			postIt.setText("Test PostIt");
			postIt.saveEx();
			int postItId = postIt.get_ID();
			int AD_PostIt_ID = gt.getAD_PostIt_ID();
			assertEquals(postItId, AD_PostIt_ID);

			// test chat
			chat.setAD_Table_ID(tableId);
			chat.setRecord_ID(recordId);
			chat.setRecord_UU(recordUU);
			chat.setDescription("Test Chat");
			chat.saveEx();
			int chatId = chat.get_ID();
			int CM_Chat_ID = gt.getCM_ChatID();
			assertEquals(chatId, CM_Chat_ID);
			
			// test label
			label.setName("Test Label " + System.currentTimeMillis());
			label.saveEx();			
			labelAssignment.setAD_Table_ID(tableId);
			labelAssignment.setRecord_ID(recordId);
			labelAssignment.setRecord_UU(recordUU);
			labelAssignment.setAD_Label_ID(label.get_ID());
			labelAssignment.saveEx();
			assertTrue(gt.hasLabel(), "Should have label");
		} finally {
			// clean up
			rollback();
			if (attachment.get_ID() > 0)
				attachment.deleteEx(true);
			if (postIt.get_ID() > 0)
				postIt.deleteEx(true);
			if (chat.get_ID() > 0)
				chat.deleteEx(true);
			if (labelAssignment.get_ID() > 0)
				labelAssignment.deleteEx(true);			
			if (label.get_ID() > 0)
				label.deleteEx(true);
			bp.deleteEx(true);
		}
	}

	@Test
	void testIsSingleRow() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		GridTab gTab = gridWindow.getTab(0);
		assertTrue(gTab.isSingleRow(), "Business Partner main tab should be single-row");

		try (MockedStatic<MTabCustomization> mockedMTabCustomization = mockStatic(MTabCustomization.class, Mockito.CALLS_REAL_METHODS);) {
			MTabCustomization tabCustomization = new MTabCustomization(Env.getCtx(), 0, null);
			tabCustomization.setIsDisplayedGrid("Y");
			// mock to multi-row
			mockedMTabCustomization.when(() -> MTabCustomization.get(eq(Env.getCtx()), anyInt(), eq(gTab.getAD_Tab_ID()), any()))
				.thenReturn(tabCustomization);
			assertFalse(gTab.isSingleRow(), "Business Partner main tab should be multi-row after mock");
		}
	}
	
	@Test
	void testIsAlwaysUpdateable() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		GridTab gTab = gridWindow.getTab(0);
		// Payment Rule is always updateable
		assertTrue(gTab.isAlwaysUpdateField(), "Business Partner main tab has always updateable fields");
	}
	
	@Test
	void testGetRecord_UU() {
		MTestUU test = new MTestUU(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
		test.setName("Test UU " + System.currentTimeMillis());
		test.saveEx();
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST_UU);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		MQuery query = new MQuery(MTestUU.Table_Name);
		query.addRestriction(MTestUU.COLUMNNAME_TestUU_UU, MQuery.EQUAL,test.getTestUU_UU());
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		
		assertEquals(1, gTab.getRowCount(), "Should have one record");
		assertEquals(test.getTestUU_UU(), gTab.getRecord_UU(), "Record_UU mismatch" );
	}
	
	@Test
	void testToString() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST_UU);
		GridTab gTab = gridWindow.getTab(0);
		String toString = gTab.toString();
		assertNotNull(toString, "toString should not be null");
		assertTrue(toString.contains(Integer.toString(gTab.getTabNo())), "toString should contain TabNo");
		assertTrue(toString.contains(gTab.getName()), "toString should contain Name");
		assertTrue(toString.contains(Integer.toString(gTab.getAD_Tab_ID())), "toString should contain AD_Tab_ID");
	}
	
	@Test
	void testCanHaveAttachments() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		GridTab gTab = gridWindow.getTab(0);
		assertTrue(gTab.canHaveAttachment(), "Test tab should support attachments");
		
		gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST_UU);
		gTab = gridWindow.getTab(0);
		assertTrue(gTab.canHaveAttachment(), "Test UU tab should support attachments");
	}
	
	@Test
    void testHasTemplate() {
        var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
        GridTab gTab = gridWindow.getTab(0);
        // Mock MImportTemplate.getTemplates to return non-empty list
        try (MockedStatic<MImportTemplate> mockedTemplates = mockStatic(MImportTemplate.class, Mockito.CALLS_REAL_METHODS)) {
            List<Object> templates = new ArrayList<>();
            templates.add(new Object());
            mockedTemplates.when(() -> MImportTemplate.getTemplates(Env.getAD_Role_ID(Env.getCtx()), gTab.getAD_Tab_ID())).thenReturn(templates);
            assertTrue(gTab.hasTemplate(), "hasTemplate should return true when templates exist");
        }
        // Mock MImportTemplate.getTemplates to return empty list
        try (MockedStatic<MImportTemplate> mockedTemplates = mockStatic(MImportTemplate.class, Mockito.CALLS_REAL_METHODS)) {
            mockedTemplates.when(() -> MImportTemplate.getTemplates(Env.getAD_Role_ID(Env.getCtx()), gTab.getAD_Tab_ID())).thenReturn(Collections.emptyList());
            assertFalse(gTab.hasTemplate(), "hasTemplate should return false when no templates exist");
        }
    }
	
	@Test
	void testNeedSave() {
		String prefKey = "P" + SystemIDs.WINDOW_SALES_ORDER + "|" + MOrder.COLUMNNAME_C_DocTypeTarget_ID;
		Env.setContext(Env.getCtx(), prefKey, DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		Env.setContext(Env.getCtx(), "IsSOTrx", true);
		int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
		GridTab gTab = gridWindow.getTab(0);
		gTab.setQuery(MQuery.getNoRecordQuery(gTab.getTableName(), true));
		gTab.query(false, 0, 0);
		
		// New Record, no changes (setValue), no setChanged(true)
		gTab.dataNew(false);
		assertFalse(gTab.needSave(false, false));
		assertFalse(gTab.needSave(false, true));
		assertFalse(gTab.needSave(true, false));
		assertFalse(gTab.needSave(true, true));
		
		// New Record, no changes (setValue), with setChanged(true)
		gTab.getTableModel().setChanged(true);
		assertTrue(gTab.needSave(false, false));
		assertFalse(gTab.needSave(false, true));
		assertFalse(gTab.needSave(true, false));
		assertFalse(gTab.needSave(true, true));

		// New Record, with changes (setValue)
		gTab.setValue(MOrder.COLUMNNAME_C_BPartner_ID, DictionaryIDs.C_BPartner.C_AND_W.id);
		assertFalse(gTab.needSave(false, false));
		assertFalse(gTab.needSave(false, true));
		assertTrue(gTab.needSave(true, false));
		assertTrue(gTab.needSave(true, true));
		
		// Existing Record, no changes (setValue)
		gTab.dataIgnore();
		gTab.setQuery(null);
		gTab.query(false, 0, 3);
		assertFalse(gTab.needSave(false, false));
		assertFalse(gTab.needSave(false, true));
		assertFalse(gTab.needSave(true, false));
		assertFalse(gTab.needSave(true, true));
		
		// Existing Record, with changes (setValue)
		gTab.setValue(MOrder.COLUMNNAME_Description, "Test Need Save " + System.currentTimeMillis());
		assertFalse(gTab.needSave(false, false));
		assertFalse(gTab.needSave(false, true));
		assertTrue(gTab.needSave(true, false));
		assertTrue(gTab.needSave(true, true));
	
	}
	
	@Test
	void test0IsNull() {
		int AD_Window_ID = SystemIDs.WINDOW_TEST;
		var gridWindow = GridWindowTest.createGridWindow(AD_Window_ID);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.setQuery(MQuery.getNoRecordQuery(MTest.Table_Name, true));
		gTab.query(false, 0, 0);
		gTab.dataNew(false);
		gTab.setValue(MTest.COLUMNNAME_Name, "Test IsNull " + System.currentTimeMillis());
		gTab.setValue(MTest.COLUMNNAME_C_UOM_ID, DictionaryIDs.C_UOM.EACH.id);
		assertTrue(gTab.dataSave(true), "Failed to save new record for IsNull test");
		
		assertNotNull(gTab.getValue(MTest.COLUMNNAME_C_UOM_ID), "C_UOM_ID should not be null");
		gTab.setValue(MTest.COLUMNNAME_C_UOM_ID, 0);
		assertNull(gTab.getValue(MTest.COLUMNNAME_C_UOM_ID), "C_UOM_ID should be null after setting to 0");
		assertTrue(gTab.dataSave(true), "Failed to save new record for IsNull test");
	}
	
	@Test
	void testDataStatusEventProperties() {
		var gridWindow = GridWindowTest.createGridWindow(DictionaryIDs.AD_Window.ORGANIZATION.id);
		GridTab gTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MOrg.Table_Name);
		query.addRestriction(MOrg.COLUMNNAME_AD_Org_ID, MQuery.EQUAL, DictionaryIDs.AD_Org.HQ.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Should have one record");
		gTab = gridWindow.getTab(1); //org info
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Should have one record");
		DataStatusEvent dse = gTab.getLastDataStatusEvent();
		assertNotNull(dse, "DataStatusEvent should not be null");
		assertEquals(gridWindow.getTab(0).getRecord_ID(), dse.Record_ID, "Record_ID should match");
		assertEquals(gTab.getValue("CreatedBy"), dse.CreatedBy, "CreatedBy should match");
	}
	
	@Test
	void testStateChangeListener() {
		var gridWindow = GridWindowTest.createGridWindow(DictionaryIDs.AD_Window.ORGANIZATION.id);
		GridTab gTab = gridWindow.getTab(0);
		StringBuilder sb = new StringBuilder();
		gTab.addStateChangeListener((e) -> {
			sb.append(e.toString());
		});
		MQuery query = new MQuery(MOrg.Table_Name);
		query.addRestriction(MOrg.COLUMNNAME_AD_Org_ID, MQuery.EQUAL, DictionaryIDs.AD_Org.HQ.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Should have one record");
		assertTrue(sb.length() > 0, "StateChangeListener should have been triggered" );
	}	
	
	@Test
	void testInsertUpdateUU() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST_UU);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.setQuery(MQuery.getNoRecordQuery(gTab.getTableName(), true));
		gTab.query(false, 0, 0);
		
		assertEquals(0, gTab.getRowCount(), "Tab should be empty before insert");
		
		gTab.dataNew(false);
		gTab.setValue(MTestUU.COLUMNNAME_Name, "Test UU " + System.currentTimeMillis());
		assertTrue(gTab.dataSave(true), "Failed to save new record");
		
		assertEquals(1, gTab.getRowCount(), "Tab should have one record after insert");
		String recordUU = (String)gTab.getValue(MTestUU.COLUMNNAME_TestUU_UU);
		assertNotNull(recordUU, "Record_UU should not be null");
		assertTrue(recordUU.length() > 0, "Record_UU should not be empty");
		
		gTab.setValue(MTestUU.COLUMNNAME_Name, "Test UU1 " + System.currentTimeMillis());
		assertTrue(gTab.dataSave(true), "Failed to update record");
		
		MTestUU testUU = new MTestUU(Env.getCtx(), recordUU, getTrxName());
		assertEquals(recordUU, testUU.getTestUU_UU(), "Record_UU should match after update");
		testUU.setName("Test UU2 " + System.currentTimeMillis());
		testUU.saveEx();
		
		gTab.setValue(MTestUU.COLUMNNAME_Name, "Test UU3 " + System.currentTimeMillis());
		assertFalse(gTab.dataSave(true), "Update should fail due to external change");
		assertNotNull(gTab.getLastDataStatusEvent(), "DataStatusEvent should not be null after external change");
		//Oracle might return SaveErrorDataChanged instead of CurrentRecordModified
		//This is due to we are using Date data type for the Updated field and precision for Oracle Date data type is up to seconds only
		String actualMessage = gTab.getLastDataStatusEvent().getAD_Message();
		if (DB.isOracle()) {
			assertTrue("CurrentRecordModified".equals(actualMessage)
				|| "SaveErrorDataChanged".equals(actualMessage), "AD_Message should indicate record modified externally");
		} else {
			assertEquals("CurrentRecordModified", actualMessage, "AD_Message should indicate record modified externally");
		}
		
		// refresh and save should work now
		gTab.dataRefresh(gTab.getCurrentRow(), true);
		gTab.setValue(MTestUU.COLUMNNAME_Name, "Test UU4 " + System.currentTimeMillis());
		assertTrue(gTab.dataSave(true), "Update should succeed after refresh");
		
		// test direct external update
		DB.executeUpdateEx("UPDATE "+MTestUU.Table_Name+" SET Name=? WHERE "+MTestUU.COLUMNNAME_TestUU_UU+"=?", 
				new Object[] {"Test UU5 " + System.currentTimeMillis(), recordUU}, getTrxName());
		
		gTab.setValue(MTestUU.COLUMNNAME_Name, "Test UU6 " + System.currentTimeMillis());
		assertFalse(gTab.dataSave(true), "Update should fail due to external change");
		assertNotNull(gTab.getLastDataStatusEvent(), "DataStatusEvent should not be null after external change");
		assertEquals("SaveErrorDataChanged", gTab.getLastDataStatusEvent().getAD_Message(), "AD_Message should indicate record modified externally");
	}
	
	@Test
	void testUpdateWithWrongValueType() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.setQuery(MQuery.getNoRecordQuery(gTab.getTableName(), true));
		gTab.query(false, 0, 0);
		gTab.dataNew(false);
		gTab.setValue(MTest.COLUMNNAME_Name, "Test Wrong Type " + System.currentTimeMillis());
		assertTrue(gTab.dataSave(true), "Failed to save new record for Wrong Type test");

		gTab.setValue("Name", "Test Wrong Type Updated " + System.currentTimeMillis());
		gTab.setValue(MTest.COLUMNNAME_T_Qty, "A1"); // wrong type
		assertFalse(gTab.dataSave(true), "Save should fail for wrong type column update");
	}
	
	@Test
	void testUpdateZeroIdTable() {
		// need to use system administrator role to update org 0
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id);
		Env.setContext(Env.getCtx(), Env.AD_USER_ID, DictionaryIDs.AD_User.SUPER_USER.id);
		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, 0);
		Env.setContext(Env.getCtx(), Env.AD_ORG_ID, 0);
		
		var gridWindow = GridWindowTest.createGridWindow(DictionaryIDs.AD_Window.ORGANIZATION.id);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		MQuery query = new MQuery(MOrg.Table_Name);
		query.addRestriction(MOrg.COLUMNNAME_AD_Org_ID, MQuery.EQUAL,0);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Tab should have one record after query");
		Integer id = (Integer)gTab.getValue(MOrg.COLUMNNAME_AD_Org_ID);
		assertEquals(0, id.intValue(), "ID should be zero");
		gTab.setValue(MOrg.COLUMNNAME_Description, "Updated " + System.currentTimeMillis());
		assertTrue(gTab.dataSave(true), "Failed to save update on zero ID record");
	}
	
	@Test
	void testDataNewCopy() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL,DictionaryIDs.C_BPartner.C_AND_W.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Tab should have one record after query");
		String bpName = (String)gTab.getValue(MBPartner.COLUMNNAME_Name);
		assertTrue(!Util.isEmpty(bpName, true), "Business Partner Name should not be null or empty");
		gTab.dataNew(true); //copy
		String copyName = (String)gTab.getValue(MBPartner.COLUMNNAME_Name);
		assertEquals(bpName, copyName, "Copied Business Partner Name should match original");
	}
	
	@Test
	void testDeleteNotDeletable() {
		// need to use system administrator role to delete system message record
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id);
		Env.setContext(Env.getCtx(), Env.AD_USER_ID, DictionaryIDs.AD_User.SUPER_USER.id);
		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, 0);
		Env.setContext(Env.getCtx(), Env.AD_ORG_ID, 0);
		Env.setContext(Env.getCtx(), Env.SHOW_TRANSLATION, true);
		
		var gridWindow = GridWindowTest.createGridWindow(DictionaryIDs.AD_Window.MESSAGE.id);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		MQuery query = new MQuery(MMessage.Table_Name);
		query.addRestriction(MMessage.COLUMNNAME_AD_Message_ID, MQuery.EQUAL,101); //zero
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Tab should have one record after query");
		gTab = gridWindow.getTab(1); //translation tab is not deletable
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 0);
		MTable table = MTable.get(gTab.getAD_Table_ID());
		assertEquals(MMessage.Table_Name + "_Trl", table.getTableName(), "Tab 1 should be translation table for message");
		assertTrue(gTab.getRowCount() > 0, "Translation tab should have records");
		assertFalse(gTab.dataDelete(), "Delete should fail for non-deletable tab");
	}
	
	@Test
	void testDeleteProcessedRecord() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 3);
		assertTrue(gTab.getRowCount() > 0, "Tab should have at least one record after query");
		if (!Boolean.TRUE.equals(gTab.getValue(MTest.COLUMNNAME_Processed))) {
			gTab.setValue(MTest.COLUMNNAME_Processed, true);
			assertTrue(gTab.dataSave(true), "Failed to set record as processed");
		}
		assertFalse(gTab.dataDelete(), "Delete should fail for processed record");
	}
	
	@Test
	void testRowChangeIndexAfterSort() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.setQuery(MQuery.getNoRecordQuery(gTab.getTableName(), true));
		gTab.query(false, 0, 0);
		// Insert multiple records
		for (int i = 0; i < 3; i++) {
			gTab.dataNew(false);
			gTab.setValue(MTest.COLUMNNAME_Name, "Test Sort " + System.currentTimeMillis() + " " + i);
			gTab.setValue(MTest.COLUMNNAME_T_Integer, i+1);
			assertTrue(gTab.dataSave(true), "Failed to save new record for sort test");
		}
		int recordId = gTab.getRecord_ID();
		gTab.setValue(MTest.COLUMNNAME_T_Amount, BigDecimal.TEN);
		int changeRowIndex = gTab.getTableModel().getRowChanged();
		gTab.getTableModel().sort(gTab.getTableModel().findColumn(MTest.COLUMNNAME_T_Integer), false); //sort by t_integer desc
		int newChangeRowIndex = gTab.getTableModel().getRowChanged();
		assertNotEquals(changeRowIndex, newChangeRowIndex, "RowChanged index should change after sort");
		gTab.setCurrentRow(newChangeRowIndex);
		assertEquals(recordId, gTab.getRecord_ID(), "Record_ID should match after set newChangeRowIndex as current row");
	}
	
	@Test
	void testReset() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_PRODUCT);
		var gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 3);
		assertTrue(gTab.getRowCount() > 0, "Tab should have records after query");
		gTab.reset();
		assertEquals(0, gTab.getRowCount(), "Tab should have zero records after reset");
	}
	
	@Test
	void testColorColumn() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.setQuery(MQuery.getNoRecordQuery(gTab.getTableName(), true));
		gTab.query(false, 0, 0);
		gTab.dataNew(false);
		gTab.setValue(MTest.COLUMNNAME_Name, "Test Color " + System.currentTimeMillis());
		gTab.setValue(MTest.COLUMNNAME_T_Amount, BigDecimal.TEN);
		assertTrue(gTab.dataSave(true), "Failed to save new record for color column test");
		gTab.getTableModel().setColorColumn(MTest.COLUMNNAME_T_Amount);
		var value = gTab.getTableModel().getColorCode(gTab.getCurrentRow());
		assertEquals(1, value, "Color code should be 1 for T_Amount=10");
	}
	
	@Test
	void testSetVFormat() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.setQuery(MQuery.getNoRecordQuery(gTab.getTableName(), true));
		gTab.query(false, 0, 0);
		gTab.dataNew(false);
		String strNewFormat = "#,##0.000";
		gTab.setFieldVFormat(MTest.COLUMNNAME_T_Amount, strNewFormat);
		assertEquals(strNewFormat, gTab.getField(MTest.COLUMNNAME_T_Amount).getVFormat(), "VFormat should match the set format");
	}
	
	@Test
	void testRowCountTimeoutEvent() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		StringBuilder eventMessage = new StringBuilder();
		tableModel.addDataStatusListener(e -> {
			eventMessage.append(e.getAD_Message());
		});
		CPreparedStatement stmt = mock(CPreparedStatement.class);
		SQLTimeoutException simulatedTimeout = DB.isPostgreSQL()  
				 ? new SQLTimeoutException("Simulated timeout", "57014")
				 : new SQLTimeoutException("Simulated timeout", "72000", 1013);
		try {
			when(stmt.executeQuery()).thenThrow(simulatedTimeout);
		} catch (SQLException e1) {
			fail("Unexpected exception setting up mock CPreparedStatement. " + e1.getMessage());
		}
		
		Future<?> future= mock(Future.class);
		ScheduledThreadPoolExecutor scheduler = mock(ScheduledThreadPoolExecutor.class);
		when(scheduler.submit(any(Runnable.class))).thenAnswer(invocation -> {
			Runnable runnable = invocation.getArgument(0);
			runnable.run(); // run immediately
			return future;
		});
		try (MockedStatic<DB> mockedDB = mockStatic(DB.class, Mockito.CALLS_REAL_METHODS);
			MockedStatic<Adempiere> mockedAdempiere = mockStatic(Adempiere.class, Mockito.CALLS_REAL_METHODS);) {
			mockedDB.when(() -> DB.prepareStatement(startsWith("SELECT COUNT(*)"), any())).thenReturn(stmt);
			mockedAdempiere.when(Adempiere::getThreadPoolExecutor).thenReturn(scheduler);
			gTab.query(false, 0, 0);
			assertEquals(GridTable.COUNT_QUERY_TIMEOUT_ERROR_MESSAGE, eventMessage.toString(), "DataStatusEvent info should indicate timeout");
		}		
	}
	
	@Test
	void testBackGroundLoadingEvent() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		StringBuilder eventMessage = new StringBuilder();
		tableModel.addDataStatusListener(e -> {
			if (e.getLoadedRows() == 1000)
				eventMessage.append(e.getLoadedRows());
		});
		
		StringBuilder select = createSelectSQL(tableModel);
		
		Future<?> future= mock(Future.class);
		ScheduledThreadPoolExecutor scheduler = mock(ScheduledThreadPoolExecutor.class);
		when(scheduler.submit(any(Runnable.class))).thenAnswer(invocation -> {
			Runnable runnable = invocation.getArgument(0);
			runnable.run(); // run immediately
			return future;
		});
		
		// simulate large result set by returning true 1005 times
		int totalRows = 1005;
        AtomicInteger counter = new AtomicInteger(totalRows);
		try (MockedStatic<DB> mockedDB = mockStatic(DB.class, Mockito.CALLS_REAL_METHODS);
			MockedStatic<Adempiere> mockedAdempiere = mockStatic(Adempiere.class, Mockito.CALLS_REAL_METHODS);) {
			mockedDB.when(() -> DB.prepareStatement(startsWith(select.toString()), any())).thenAnswer(invocation -> {
				CPreparedStatement stmt = (CPreparedStatement) invocation.callRealMethod();
				var spyStmt = spy(stmt);
				// return true for next() totalRows times, then false
				doAnswer(invocationOnMock -> {
					ResultSet rs = (ResultSet) invocationOnMock.callRealMethod();
					var spyr = spy(rs);
					doAnswer(rsInvocation -> {						
						if (counter.get() == totalRows) {							
							rsInvocation.callRealMethod();
						}
						return counter.getAndDecrement() > 0;
					}).when(spyr).next();
					return spyr;
				}).when(spyStmt).executeQuery();
				return spyStmt;
			});
			mockedAdempiere.when(Adempiere::getThreadPoolExecutor).thenReturn(scheduler);
			gTab.query(false, 0, 0);
			gTab.getTableModel().loadComplete();
			assertEquals("1000", eventMessage.toString(), "DataStatusEvent info should capture 1000 loaded rows");
		}
	}

	private StringBuilder createSelectSQL(GridTable tableModel) {
		// Create SELECT Part (copy from GridTable)
		StringBuilder select = new StringBuilder("SELECT ");
		var fields = tableModel.getFields();
		for (int i = 0; i < fields.length; i++)
		{
			if (i > 0)
				select.append(",");
			GridField field = fields[i];
			select.append(field.isVirtualColumn() ? field.getColumnSQL(true) : DB.getDatabase().quoteColumnName(field.getColumnSQL(true)));	//	ColumnName or Virtual Column
		}
		//
		select.append(" FROM ").append(tableModel.getTableName());
		return select;
	}
	
	@Test
	void testLoadRowTimeoutEvent() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		StringBuilder eventMessage = new StringBuilder();
		tableModel.addDataStatusListener(e -> {
			eventMessage.append(e.getAD_Message());
		});
		
		StringBuilder select = createSelectSQL(tableModel);
		
		CPreparedStatement stmt = mock(CPreparedStatement.class);
		SQLTimeoutException simulatedTimeout = DB.isPostgreSQL()  
				 ? new SQLTimeoutException("Simulated timeout", "57014")
				 : new SQLTimeoutException("Simulated timeout", "72000", 1013);
		try {
			when(stmt.executeQuery()).thenThrow(simulatedTimeout);
		} catch (SQLException e1) {
			fail("Unexpected exception setting up mock CPreparedStatement. " + e1.getMessage());
		}
		
		Future<?> future= mock(Future.class);
		ScheduledThreadPoolExecutor scheduler = mock(ScheduledThreadPoolExecutor.class);
		when(scheduler.submit(any(Runnable.class))).thenAnswer(invocation -> {
			Runnable runnable = invocation.getArgument(0);
			runnable.run(); // run immediately
			return future;
		});
		try (MockedStatic<DB> mockedDB = mockStatic(DB.class, Mockito.CALLS_REAL_METHODS);
			MockedStatic<Adempiere> mockedAdempiere = mockStatic(Adempiere.class, Mockito.CALLS_REAL_METHODS);) {
			mockedDB.when(() -> DB.prepareStatement(startsWith(select.toString()), any())).thenReturn(stmt);
			mockedAdempiere.when(Adempiere::getThreadPoolExecutor).thenReturn(scheduler);
			gTab.query(false, 0, 0);
			assertEquals(GridTable.LOAD_TIMEOUT_ERROR_MESSAGE, eventMessage.toString(), "DataStatusEvent info should indicate timeout");
		}
	}
	
	@Test
	void testSaveNoChange() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		assertFalse(gTab.getTableModel().isNeedSaveAndMandatoryFill(), "Should return false when table model is not open yet");
		assertFalse(gTab.dataSave(true), "dataSave should return false when table model is not open yet");
		gTab.query(false, 0, 3);
		assertFalse(gTab.dataSave(true), "dataSave should return false when there are no changes to save");
		gTab.dataNew(false);
		assertFalse(gTab.getTableModel().isNeedSaveAndMandatoryFill(), "New record with no changes should not need save");
		assertFalse(gTab.dataSave(true), "dataSave should return false when there are no changes to save");
	}
	
	@Test
	void testIsCellEditable() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_BUSINESS_PARTNER);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		gTab.query(false, 0, 3);
		assertFalse(tableModel.isCellEditable(0, tableModel.findColumn(MBPartner.COLUMNNAME_C_BPartner_ID)), "Key column should not be editable");
		assertFalse(tableModel.isCellEditable(0, -1), "Invalid column index should not be editable");
		assertFalse(tableModel.isCellEditable(0, tableModel.getFieldCount()), "Invalid column index should not be editable");
		assertTrue(tableModel.isCellEditable(0, tableModel.findColumn("IsActive")), "IsActive column should be editable");
		GridField field = gTab.getField(MBPartner.COLUMNNAME_Name);
		if (tableModel.isRowEditable(0))
			assertEquals(field.isEditable(false), tableModel.isCellEditable(0, tableModel.findColumn(MBPartner.COLUMNNAME_Name)), "Should match field isEditable");
		else
			assertFalse(tableModel.isCellEditable(0, tableModel.findColumn(MBPartner.COLUMNNAME_Name)), "Row is not editable, so cell should not be editable");
	}
	
	@Test
	void testGetColumnClass() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		gTab.query(false, 0, 3);
		GridField field = gTab.getField(MTest.COLUMNNAME_T_Amount);
		Class<?> columnClass = tableModel.getColumnClass(tableModel.findColumn(MTest.COLUMNNAME_T_Amount));
		assertEquals(DisplayType.getClass(field.getDisplayType(), false), columnClass, "Column class should match field class type");
		assertNull(tableModel.getColumnClass(-1), "Invalid column index should return null class");
		assertTrue(tableModel.toString().contains(MTest.Table_Name), "GridTable.toString should contain table name");
	}
	
	@Test
	void testDeleteBySQL() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		tableModel.setImportingMode(true, getTrxName());
		gTab.setQuery(MQuery.getNoRecordQuery(MTest.Table_Name, true));
		gTab.query(false, 0, 0);
		gTab.dataNew(false);
		gTab.setValue(MTest.COLUMNNAME_Name, "Test DeleteBySQL " + System.currentTimeMillis());
		assertTrue(gTab.dataSave(true), "Failed to save new record for DeleteBySQL test");
		var spyTableModel = spy(tableModel);
		doReturn(null).when(spyTableModel).getPO(anyInt());
		assertTrue(spyTableModel.getPO(gTab.getCurrentRow()) == null, "getPO should return null for spy");
		setTableModelSpy(gTab, spyTableModel);
		assertTrue(gTab.dataDelete(), "dataDelete should succeed even when getPO returns null");
	}

	private void setTableModelSpy(GridTab gTab, GridTable spyTableModel) {
		//use reflection to set gTab.m_mTable to spyTableModel
		try {
			java.lang.reflect.Field mTableField = GridTab.class.getDeclaredField("m_mTable");
			mTableField.setAccessible(true);
			mTableField.set(gTab, spyTableModel);
		} catch (NoSuchFieldException | IllegalAccessException e) {
			fail("Failed to set m_mTable field for spyGTab. " + e.getMessage());
		}
	}
	
	@Test
	void testUpdateSystemRecord() {
		var gridWindow = GridWindowTest.createGridWindow(DictionaryIDs.AD_Window.ORGANIZATION.id);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		MQuery query = new MQuery(MOrg.Table_Name);
		query.addRestriction(MOrg.COLUMNNAME_AD_Org_ID, MQuery.EQUAL,DictionaryIDs.AD_Org.GLOBAL.id);
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Tab should have one record after query");
		Integer id = (Integer)gTab.getValue(MOrg.COLUMNNAME_AD_Org_ID);
		assertEquals(DictionaryIDs.AD_Org.GLOBAL.id, id.intValue(), "ID should match global org");
		gTab.setValue(MOrg.COLUMNNAME_Description, "Updated Global Org " + System.currentTimeMillis());
		assertFalse(gTab.dataSave(true), "Save should fail for system record");
	}
	
	@Test
	void testDeleteSystemRecord() {
		var gridWindow = GridWindowTest.createGridWindow(DictionaryIDs.AD_Window.ROLE.id);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		MQuery query = new MQuery(MRole.Table_Name);
		query.addRestriction(MRole.COLUMNNAME_AD_Role_ID, MQuery.EQUAL,DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id); //zero
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Tab should have one record after query" );
		MRole role = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id);
		assertEquals(role.getName(), gTab.getValue(MRole.COLUMNNAME_Name), "Role name should match" );
		assertFalse(gTab.dataDelete(), "Delete should fail for system record" );
	}
	
	@Test
	void testUpdateReadonly() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		GridTab gTab = gridWindow.getTab(0);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "Tab should have records after query" );
		gTab.setValue(MUser.COLUMNNAME_Name, "Updated Name " + System.currentTimeMillis());
		gTab.getTableModel().setReadOnly(true);
		assertTrue(gTab.getTableModel().isReadOnly(), "Row should be readonly" );		
		assertFalse(gTab.dataSave(true), "Save should fail for readonly record" );
		gTab.dataIgnore();
		assertFalse(gTab.dataDelete(), "Delete should fail for readonly record" );
	}
	
	@Test
	void testDeleteErrorEvent() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		StringBuilder eventMessage = new StringBuilder();
		tableModel.addDataStatusListener(e -> {
			if (e.isError())
				eventMessage.append(e.getAD_Message());
		});
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 0);
		assertFalse(gTab.getTableModel().isOnlyCurrentRowsDisplayed(), "Table model should not be only current rows displayed" );
		
		var spyTableModel = spy(tableModel);
		doAnswer(invocation -> {
			PO po = (PO) invocation.callRealMethod();
			var spyPo = spy(po);
			doReturn(false).when(spyPo).delete(anyBoolean());
			return spyPo;
		}).when(spyTableModel).getPO(anyInt());
		setTableModelSpy(gTab, spyTableModel);
		assertFalse(gTab.dataDelete(), "dataDelete should fail when PO.delete returns false");
		assertTrue(eventMessage.length() > 0, "DataStatusEvent error message should be captured" );
	}
	
	@Test
	void testSaveErrorEvent() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		StringBuilder eventMessage = new StringBuilder();
		tableModel.addDataStatusListener(e -> {
			if (e.isError())
				eventMessage.append(e.getAD_Message());
		});
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 0);
		
		var spyTableModel = spy(tableModel);
		doAnswer(invocation -> {
			PO po = (PO) invocation.callRealMethod();
			var spyPo = spy(po);
			doReturn(false).when(spyPo).save();
			return spyPo;
		}).when(spyTableModel).getPO(anyInt());
		setTableModelSpy(gTab, spyTableModel);
		gTab.setValue(MTest.COLUMNNAME_Name, "Test Save Error " + System.currentTimeMillis());
		assertTrue(spyTableModel.needSave(), "Table model should need save after value change" );		
		assertTrue(spyTableModel.needSave(true), "Table model should need save after value change" );
		assertFalse(gTab.dataSave(true), "dataSave should fail when PO.save returns false");
		assertTrue(eventMessage.length() > 0, "DataStatusEvent error message should be captured" );
	}
	
	@Test
	void testGetErrorFromLogger() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 0);
		
		var spyTableModel = spy(tableModel);
		doAnswer(invocation -> {
			PO po = (PO) invocation.callRealMethod();
			var spyPo = spy(po);
			doThrow(new AdempiereException("MyError")).when(spyPo).save();
			return spyPo;
		}).when(spyTableModel).getPO(anyInt());
		setTableModelSpy(gTab, spyTableModel);
		gTab.setValue(MTest.COLUMNNAME_Name, "Test Save Error " + System.currentTimeMillis());
		assertTrue(spyTableModel.needSave(), "Table model should need save after value change" );		
		assertTrue(spyTableModel.needSave(true), "Table model should need save after value change" );
		assertFalse(gTab.dataSave(true), "dataSave should fail when PO.save returns false");
		assertTrue(CLogger.retrieveError() != null, "CLogger should have captured error");
	}
	
	@Test
	void testVetoableChangeSupport() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		StringBuilder eventMessage = new StringBuilder();
		VetoableChangeListener listener = e -> {
			eventMessage.append(e.getPropertyName());
			throw new PropertyVetoException("Vetoable change failed", e);
		};
		tableModel.addVetoableChangeListener(listener);
		gTab.getTableModel().setImportingMode(true, getTrxName());
		gTab.query(false, 0, 0);
		gTab.setValue(MTest.COLUMNNAME_Name, "Test Vetoable " + System.currentTimeMillis());
		//false to trigger vetoable change event
		assertFalse(gTab.dataSave(false), "dataSave should fail due to vetoable change exception");
		assertTrue(eventMessage.length() > 0, "VetoableChangeEvent should be captured" );
		tableModel.removeVetoableChangeListener(listener);
		assertTrue(gTab.dataSave(false), "dataSave should succeed after removing vetoable change listener");
	}
	
	@Test
	void testGetColumnName() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		gTab.query(false, 0, 0);
		GridField[] fields = tableModel.getFields();
		assertEquals("", tableModel.getColumnName(-1), "Invalid column index should return empty string");
		assertEquals("", tableModel.getColumnName(fields.length), "Invalid column index should return empty string");
		for (int i = 0; i < fields.length; i++) {
			assertEquals(fields[i].getColumnName(), tableModel.getColumnName(i), "Column name should match for index " + i);
		}
	}
	
	@Test
	void testSort() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		gTab.query(false, 0, 0);
		assertEquals(-1, tableModel.getSortColumnIndex(), "Table should not be sorted initially");

		// Sort the table
		tableModel.sort(0, true);
		assertEquals(0, tableModel.getSortColumnIndex(), "Table should be sorted by column 0");
		assertTrue(tableModel.isSortedAscending(), "Table should be sorted ascending");
		int recordIdFirst = (int) tableModel.getValueAt(0, tableModel.findColumn(MTest.COLUMNNAME_Test_ID));
		// invalid column index should do nothing
		tableModel.sort(-1, false);
		assertEquals(0, tableModel.getSortColumnIndex(), "Table should be sorted by column 0");
		assertTrue(tableModel.isSortedAscending(), "Table should be sorted ascending");

		// Sort descending
		tableModel.sort(0, false);
		assertEquals(0, tableModel.getSortColumnIndex(), "Table should be sorted by column 0");
		assertFalse(tableModel.isSortedAscending(), "Table should be sorted descending");
		int recordIdLast = (int) tableModel.getValueAt(tableModel.getRowCount() -1, tableModel.findColumn(MTest.COLUMNNAME_Test_ID));
		assertEquals(recordIdFirst, recordIdLast, "First record ID in ascending sort should match last record ID in descending sort");
		
		// sort ascending with new row
		gTab.dataNew(false);
		gTab.setValue(MTest.COLUMNNAME_Name, "AAA New Sort " + System.currentTimeMillis());
		assertTrue(gTab.isNew(), "New record should be marked as new");
		int newRowIndex = tableModel.getNewRow();
		assertTrue(newRowIndex > 0, "New row index should be greater than zero");
		tableModel.sort(0, true);
		assertEquals(0, tableModel.getSortColumnIndex(), "Table should be sorted by column 0");
		assertTrue(tableModel.isSortedAscending(), "Table should be sorted ascending");
		assertEquals(0, tableModel.getNewRow(), "New row index should move to top after sort");
		
		tableModel.resetCacheSortState();
		assertEquals(-1, tableModel.getSortColumnIndex(), "Sort column index should be reset after resetCacheSortState");
	}
	
	@Test
	void testQueryWithContextVariable() {
		var gridWindow = GridWindowTest.createGridWindow(DictionaryIDs.AD_Window.USER.id);
		GridTab gTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MUser.Table_Name);
		query.addRestriction(MUser.COLUMNNAME_AD_User_ID, MQuery.EQUAL, "@#AD_User_ID@");
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(1, gTab.getRowCount(), "Should have one record for current user" );
		assertEquals(Env.getAD_User_ID(Env.getCtx()), gTab.getRecord_ID(), "Record_ID should match current user" );
		// invalid context
		query.addRestriction(MUser.COLUMNNAME_AD_User_ID, MQuery.EQUAL, "@#AD_User_IDx@");
		gTab.setQuery(query);
		gTab.query(false, 0, 0);
		assertEquals(0, gTab.getRowCount(), "Should have zero records for invalid context variable" );
	}
	
	@Test
	void testIsRowEditable() {
		var gridWindow = GridWindowTest.createGridWindow(SystemIDs.WINDOW_TEST);
		var gTab = gridWindow.getTab(0);
		var tableModel = gTab.getTableModel();
		tableModel.setImportingMode(true, getTrxName());
		gTab.query(false, 0, 0);
		assertTrue(gTab.getRowCount() > 0, "Tab should have records after query" );
		assertFalse(tableModel.isRowEditable(-1), "Invalid row index should not be editable" );
		assertFalse(tableModel.isRowEditable(gTab.getRowCount()), "Invalid row index should not be editable" );
		tableModel.setValueAt(false, 0, tableModel.findColumn(MTest.COLUMNNAME_Processed));
		tableModel.setValueAt(false, 0, tableModel.findColumn("IsActive"));
		assertFalse(tableModel.isRowEditable(0), "Row should not be editable when IsActive is false" );
		tableModel.setValueAt(true, 0, tableModel.findColumn("IsActive"));
		assertTrue(tableModel.isRowEditable(0), "Row should be editable when IsActive is true" );
		tableModel.setValueAt(true, 0, tableModel.findColumn(MTest.COLUMNNAME_Processed));
		assertFalse(tableModel.isRowEditable(0), "Row should not be editable when Processed is true" );
		tableModel.setValueAt(false, 0, tableModel.findColumn(MTest.COLUMNNAME_Processed));
		assertTrue(tableModel.isRowEditable(0), "Row should be editable when Processed is false" );
	}
}
