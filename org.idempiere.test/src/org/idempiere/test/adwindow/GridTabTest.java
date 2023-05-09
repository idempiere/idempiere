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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.base.Core;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MBPartner;
import org.compiere.model.MField;
import org.compiere.model.MLookup;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrg;
import org.compiere.model.MQuery;
import org.compiere.model.MWarehouse;
import org.compiere.model.SystemIDs;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

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
		var gWindowVO = GridWindowVO.create (Env.getCtx(), 1, AD_Window_ID);
		var gridWindow = new GridWindow(gWindowVO, true);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID="+AD_Window_ID);
		
		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			gridWindow.initTab(i);
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
		var gWindowVO = GridWindowVO.create (Env.getCtx(), 1, AD_Window_ID);
		var gridWindow = new GridWindow(gWindowVO, true);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID="+AD_Window_ID);
		
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			gridWindow.initTab(i);
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
		var gWindowVO = GridWindowVO.create (Env.getCtx(), 1, AD_Window_ID);
		var gridWindow = new GridWindow(gWindowVO, true);
		int tabCount = gridWindow.getTabCount();
		assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID="+AD_Window_ID);
		
		//retrieve for update
		MQuery query = new MQuery(MBPartner.Table_Name);
		query.addRestriction(MBPartner.COLUMNNAME_C_BPartner_ID, MQuery.EQUAL, DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			gridWindow.initTab(i);
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
		try {
			/* IDEMPIERE-5560 */
			// must not use trx here for the test case below to get the update
			DB.executeUpdateEx("UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N' WHERE AD_Field_ID=?", new Object[] {FIELD_ORDERLINE_SHIPPER}, null);
			CacheMgt.get().reset();

			// Sales Order
			int AD_Window_ID = SystemIDs.WINDOW_SALES_ORDER;
			var gWindowVO = GridWindowVO.create(ctx, 1, AD_Window_ID);
			var gridWindow = new GridWindow(gWindowVO, true);
			int tabCount = gridWindow.getTabCount();
			assertTrue(tabCount > 0, "Tab Count is Zero. AD_Window_ID=" + AD_Window_ID);

			for (int i = 0; i < gridWindow.getTabCount(); i++) {
				gridWindow.initTab(i);
				GridTab gTab = gridWindow.getTab(i);
				if (i == 0) {
					gTab.setQuery(null);
					gTab.query(false, 7, 0);
				}
				gTab.addDataStatusListener(new DataStatusListener() {
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
							// Refresh the list on dependant fields
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
				});
			}

			// insert new row
			GridTab gTab0 = gridWindow.getTab(0);
			assertTrue(gTab0.dataNew(false));
			assertTrue(gTab0.isNew(), "Grid Tab dataNew call not working as expected");
			gTab0.setValue(MOrder.COLUMNNAME_C_BPartner_ID, DictionaryIDs.C_BPartner.C_AND_W.id);
			// DocTypeTarget and SalesRep are set using the default in preference (this is to test correct assignment of defaults)
			// gTab0.setValue(MOrder.COLUMNNAME_C_DocTypeTarget_ID, DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			// gTab0.setValue(MOrder.COLUMNNAME_SalesRep_ID, DictionaryIDs.AD_User.GARDEN_USER.id);
			assertTrue(gTab0.dataSave(true), CLogger.retrieveWarningString("Could not save order"));

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
			// rollback the work from the test
			rollback();
			DB.executeUpdateEx("UPDATE AD_Field SET IsDisplayed=?, IsDisplayedGrid=? WHERE AD_Field_ID=?", new Object[] {displayOri, displayGridOri, FIELD_ORDERLINE_SHIPPER}, null);
			CacheMgt.get().reset();
		}

	}

}
