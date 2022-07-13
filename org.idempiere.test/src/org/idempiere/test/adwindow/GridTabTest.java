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

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MBPartner;
import org.compiere.model.MOrder;
import org.compiere.model.MQuery;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class GridTabTest extends AbstractTestCase {

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
}
