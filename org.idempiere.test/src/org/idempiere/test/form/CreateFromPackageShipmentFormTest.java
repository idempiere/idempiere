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
package org.idempiere.test.form;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.compiere.grid.CreateFromPackageShipment;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPackage;
import org.compiere.model.MPackageLine;
import org.compiere.model.MPackageMPS;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.MShipper;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.ui.MiniTableImpl;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class CreateFromPackageShipmentFormTest extends AbstractTestCase {

	/**
	 * default constructor
	 */
	public CreateFromPackageShipmentFormTest() {
	}

	@Test
	public void testCreateFromShipmentLine() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		orderLine.setQty(new BigDecimal("1"));
		orderLine.setDatePromised(today);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(orderLine, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		MShipper shipper = new MShipper(Env.getCtx(), DictionaryIDs.M_Shipper.UPS.id, getTrxName());
		//package
		MPackage mPackage = new MPackage(shipment, shipper);
		mPackage.setBoxCount(1);
		mPackage.saveEx();
		
		Query q = new Query(Env.getCtx(), MPackageMPS.Table_Name, MPackageMPS.COLUMNNAME_M_Package_ID+"=?", getTrxName());
		MPackageMPS mps = q.setParameters(mPackage.getM_Package_ID()).first();
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_SHIPMENT_CUSTOMER);
		assertNotNull(gridWindow, "Failed to load grid window of Shipment (Customer)");
		int index = -1;
		for(int i = 0; i < gridWindow.getTabCount(); i++) {
			gridWindow.initTab(i);
			GridTab gt = gridWindow.getTab(i);			
			if (gt.getAD_Table_ID() == MPackageMPS.Table_ID) {
				index = i;
				break;
			}
		}
		
		assertTrue(index > 0, "Failed to find Grid Tab for MPackageMPS");
		MQuery query = new MQuery(MInOut.Table_Name);
		query.addRestriction(MInOut.COLUMNNAME_M_InOut_ID, "=", shipment.get_ID());
		gridWindow.getTab(0).setQuery(query);
		gridWindow.getTab(0).getTableModel().setImportingMode(false, getTrxName());
		gridWindow.getTab(0).query(false);
		
		assertEquals(1, gridWindow.getTab(0).getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(shipment.get_ID(), gridWindow.getTab(0).getRecord_ID(), "Wrong shipment record id");
		
		List<GridTab> gtabs = new ArrayList<>();
		gtabs.add(gridWindow.getTab(index));
		int currentLevel = gridWindow.getTab(index).getTabLevel();
		for(int i = index - 1 ; i > 0; i--) {
			int level = gridWindow.getTab(i).getTabLevel(); 
			if (level > currentLevel)
				break;
			else if (level == currentLevel)
				continue;
			currentLevel = level;
			gtabs.add(gridWindow.getTab(i));
		}
		for (int i = gtabs.size()-1; i>= 0; i--) {
			gtabs.get(i).getTableModel().setImportingMode(false, getTrxName());
			gtabs.get(i).query(false);
		}
		
		assertEquals(mps.get_ID(), gridWindow.getTab(index).getValue(MPackageMPS.COLUMNNAME_M_PackageMPS_ID), "Wrong MPackageMPS record id");
		
		CreateFromPackageShipmentImpl form = new CreateFromPackageShipmentImpl(gridWindow.getTab(index));
		form.setTrxName(getTrxName());
		form.loadShipmentLines(shipment.get_ID());
		assertTrue(form.minitable.getRowCount() > 0, "Failed to load data from DB");
		
		form.minitable.setSelectedRow(-1);
		for (int i = 0; i < form.minitable.getRowCount(); i++) {
			KeyNamePair pp = (KeyNamePair) form.minitable.getValueAt(i, 1);
			if (pp.getKey() == shipmentLine.get_ID()) {
				form.minitable.setValueAt(Boolean.TRUE, i, 0);
				form.minitable.setSelectedRow(i);
				break;
			}
		}
		
		assertTrue(form.minitable.getSelectedRow() >= 0, "Failed to find shipment line record");
		assertTrue(form.save(form.minitable, getTrxName()), "Failed to save changes");
		
		q = new Query(Env.getCtx(), MPackageLine.Table_Name, MPackageLine.COLUMNNAME_M_PackageMPS_ID+"=?", getTrxName());
		List<MPackageLine> pls = q.setParameters(mps.get_ID()).list();
		assertTrue(pls.size() > 0, "Failed to create new MPackageLine record");
	}
	
	private static class CreateFromPackageShipmentImpl extends CreateFromPackageShipment {

		private MiniTableImpl minitable = null;
		
		public CreateFromPackageShipmentImpl(GridTab gridTab) {
			super(gridTab);
			
			try {
				dynInit();
			} catch (Exception e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}

		@Override
		public Object getWindow() {
			return this;
		}
		
		@Override
		protected boolean dynInit() throws Exception {
			super.dynInit();
			minitable = new MiniTableImpl();
			for(String column : getOISColumnNames()) {
				minitable.addColumn(column);
			}
			configureMiniTable(minitable);
			return true;
		}
		
		public void loadShipmentLines(int M_InOut_ID) {
			Vector<Vector<Object>> datas = super.getShipmentData(M_InOut_ID);
			for(int i = 0; i < datas.size(); i++) {
				minitable.setRowCount(i+1);
				Vector<Object> data = datas.get(i);
				for(int j = 0; j < data.size(); j++) {
					minitable.setValueAt(data.get(j), i, j);
				}
			}
		}
	}
}
