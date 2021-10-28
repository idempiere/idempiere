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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;
import java.util.StringTokenizer;

import org.adempiere.base.ColumnCalloutManager;
import org.adempiere.base.Core;
import org.adempiere.base.IColumnCallout;
import org.adempiere.model.CalloutInfoWindow;
import org.compiere.Adempiere;
import org.compiere.model.Callout;
import org.compiere.model.I_M_InventoryLine;
import org.compiere.model.MBPartner;
import org.compiere.model.MColumn;
import org.compiere.model.MRule;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class CalloutTest extends AbstractTestCase {

	public CalloutTest() {
	}

	@Test
	public void testAnnotatedCallout() {
		List<IColumnCallout> callouts = ColumnCalloutManager.findCallout("AD_InfoWindow", "AD_Table_ID");
		assertNotNull(callouts, "Null column callouts for AD_InfoWindow.AD_Table_ID");
		assertTrue(callouts.size() > 0, "Empty column callouts for AD_InfoWindow.AD_Table_ID");		
		int found = 0;
		for(IColumnCallout callout : callouts) {
			if (callout instanceof CalloutInfoWindow) {
				found++;
			}
		}		
		assertTrue(found==1, CalloutInfoWindow.class.getName() + " not found for AD_InfoWindow.AD_Table_ID");
		
		callouts = ColumnCalloutManager.findCallout("AD_InfoColumn", "AD_Element_ID");
		assertNotNull(callouts, "Null column callouts for AD_InfoColumn.AD_Element_ID");
		assertTrue(callouts.size() > 0, "Empty column callouts for AD_InfoColumn.AD_Element_ID");		
		found = 0;
		for(IColumnCallout callout : callouts) {
			if (callout instanceof CalloutInfoWindow) {
				found++;
			}
		}		
		assertTrue(found==1, CalloutInfoWindow.class.getName() + " not found for AD_InfoColumn.AD_Element_ID");
		
		callouts = ColumnCalloutManager.findCallout("AD_InfoColumn", "AD_Reference_ID");
		assertNotNull(callouts, "Null column callouts for AD_InfoColumn.AD_Reference_ID");
		assertTrue(callouts.size() > 0, "Empty column callouts for AD_InfoColumn.AD_Reference_ID");		
		found = 0;
		for(IColumnCallout callout : callouts) {
			if (callout instanceof CalloutInfoWindow) {
				found++;
			}
		}		
		assertTrue(found==1, CalloutInfoWindow.class.getName() + " not found for AD_InfoColumn.AD_Reference_ID");
		
		String calloutClass = "org.adempiere.base.callout.CostAdjustmentLineASI";
		callouts = ColumnCalloutManager.findCallout(I_M_InventoryLine.Table_Name, I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);
		assertNotNull(callouts, "Null column callouts for "+I_M_InventoryLine.Table_Name+"."+I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);
		assertTrue(callouts.size() > 0, "Empty column callouts for "+I_M_InventoryLine.Table_Name+"."+I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);		
		found = 0;
		for(IColumnCallout callout : callouts) {
			if (callout.getClass().getName().equals(calloutClass)) {
				found++;
			}
		}		
		assertTrue(found==1, calloutClass+" not found for "+I_M_InventoryLine.Table_Name+"."
				+I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);
		
		calloutClass = "org.adempiere.base.callout.CostAdjustmentLineProduct";
		callouts = ColumnCalloutManager.findCallout(I_M_InventoryLine.Table_Name, I_M_InventoryLine.COLUMNNAME_M_Product_ID);
		assertNotNull(callouts, "Null column callouts for "+I_M_InventoryLine.Table_Name+"."+I_M_InventoryLine.COLUMNNAME_M_Product_ID);
		assertTrue(callouts.size() > 0, "Empty column callouts for "+I_M_InventoryLine.Table_Name+"."+I_M_InventoryLine.COLUMNNAME_M_Product_ID);		
		found = 0;
		for(IColumnCallout callout : callouts) {
			if (callout.getClass().getName().equals(calloutClass)) {
				found++;
			}
		}		
		assertTrue(found==1, calloutClass+" not found for "+I_M_InventoryLine.Table_Name+"."
				+I_M_InventoryLine.COLUMNNAME_M_Product_ID);
		
		calloutClass = "org.adempiere.base.callout.CostAdjustmentLineProduct"; 
		callouts = ColumnCalloutManager.findCallout(I_M_InventoryLine.Table_Name, I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);
		assertNotNull(callouts, "Null column callouts for "+I_M_InventoryLine.Table_Name+"."+I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);
		assertTrue(callouts.size() > 0, "Empty column callouts for "+I_M_InventoryLine.Table_Name+"."+I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);		
		found = 0;
		for(IColumnCallout callout : callouts) {
			if (callout.getClass().getName().equals(calloutClass)) {
				found++;
			}
		}		
		assertTrue(found==0, calloutClass+" found for "+I_M_InventoryLine.Table_Name+"."
				+I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);
		
		calloutClass = "org.adempiere.model.CalloutBPartnerQuickEntry";
		callouts = ColumnCalloutManager.findCallout(MBPartner.Table_Name, MBPartner.COLUMNNAME_C_BPartner_ID);
		assertNotNull(callouts, "Null column callouts for "+MBPartner.Table_Name+"."+MBPartner.COLUMNNAME_C_BPartner_ID);
		assertTrue(callouts.size() > 0, "Empty column callouts for "+MBPartner.Table_Name+"."+MBPartner.COLUMNNAME_C_BPartner_ID);		
		found = 0;
		for(IColumnCallout callout : callouts) {
			if (callout.getClass().getName().equals(calloutClass)) {
				found++;
			}
		}		
		assertTrue(found==1, calloutClass+" not found for "+MBPartner.Table_Name+"."
				+MBPartner.COLUMNNAME_Name);
	}
	
	@Test
	public void testCoreCalloutMapping() {
		Query query = new Query(Env.getCtx(), MColumn.Table_Name, "AD_Column.IsActive='Y' AND AD_Column.AD_Column_ID < 1000000 "
				+ "AND AD_Table.IsActive='Y' AND AD_Table.AD_Table_ID < 1000000 "
				+ "AND AD_Column.Callout IS NOT NULL ", getTrxName());
		query.addJoinClause("JOIN AD_Table ON (AD_Column.AD_Table_ID=AD_Table.AD_Table_ID)");
		query.addJoinClause("JOIN AD_Tab ON (AD_Table.AD_Table_ID=AD_Tab.AD_Table_ID AND AD_Tab.IsActive='Y' AND AD_Tab.AD_Tab_ID<1000000)");
		query.addJoinClause("JOIN AD_Window ON (AD_Tab.AD_Window_ID=AD_Window.AD_Window_ID AND AD_Window.IsActive='Y' AND AD_Window.AD_Window_ID<1000000)");
		query.addJoinClause("JOIN AD_Menu ON (AD_Window.AD_Window_ID=AD_Menu.AD_Window_ID AND AD_Menu.IsActive='Y' AND AD_Menu.AD_Menu_ID<1000000)");
		List<MColumn> columns = query.list();
		ClassLoader baseClassLoader = Adempiere.class.getClassLoader();
		int calloutCount = 0;
		for(MColumn column : columns) {
			StringTokenizer st = new StringTokenizer(column.getCallout(), ";,", false);
			while (st.hasMoreTokens()) {
				String cmd = st.nextToken().trim();
	
				if (cmd.toLowerCase().startsWith(MRule.SCRIPT_PREFIX))
					continue;
				int methodStart = cmd.lastIndexOf('.');
				try {
					if (methodStart != -1)      //  no class
					{
						String className = cmd.substring(0,methodStart);
						String method = cmd.substring(methodStart+1);
						Callout callout = Core.getCallout(className, method);					
						if (callout == null) {
							//no match from factory, check java classpath
							Class<?> cClass = baseClassLoader.loadClass(className);
							callout = (Callout)cClass.getDeclaredConstructor().newInstance();
						}
						assertNotNull(callout, "Can't get callout "+cmd+" for "+column.getAD_Table()+" "+column);
						calloutCount++;
					}
				} catch (Exception e) {
					fail("Can't get callout "+cmd+" for "+column.getAD_Table()+" "+column, e);
				}
			}
		}
		assertTrue(calloutCount > 0, "Zero callout loaded");
	}
}
