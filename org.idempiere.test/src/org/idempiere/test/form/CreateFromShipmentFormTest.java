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
import java.util.Vector;

import org.compiere.grid.CreateFromShipment;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MLocator;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MWarehouse;
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
public class CreateFromShipmentFormTest extends AbstractTestCase {

	/**
	 * default constructor 
	 */
	public CreateFromShipmentFormTest() {
	}

	@Test
	public void testCreateFromOrderLine() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.HOLLY_BUSH.id));
		orderLine.setQty(new BigDecimal("1"));
		orderLine.setDatePromised(today);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_MATERIAL_RECEIPT);
		assertNotNull(gridWindow, "Failed to load grid window of Material Receipt");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MInOut.Table_Name);
		query.addRestriction(MInOut.COLUMNNAME_M_InOut_ID, "=", receipt.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(receipt.get_ID(), gridTab.getRecord_ID(), "Wrong Material Receipt record id");
		
		CreateFromShipmentImpl form = new CreateFromShipmentImpl(gridTab);
		form.setTrxName(getTrxName());
		ArrayList<KeyNamePair> orders = form.getOrders(order.getC_BPartner_ID());
		assertNotNull(orders, "Can't load Orders for BP");
		assertTrue(orders.size() > 0, "Can't load Orders for BP");
		boolean found = false;
		for(KeyNamePair knp : orders) {
			if (knp.getKey() == order.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Fail to load Order");
		
		form.loadOrderLines(order.get_ID());
		assertTrue(form.minitable.getRowCount() > 0, "Failed to load data from DB");
		
		form.minitable.setSelectedRow(-1);
		for (int i = 0; i < form.minitable.getRowCount(); i++) {
			KeyNamePair pp = (KeyNamePair) form.minitable.getValueAt(i, 6);
			if (pp.getKey() == orderLine.get_ID()) {
				form.minitable.setValueAt(Boolean.TRUE, i, 0);
				form.minitable.setSelectedRow(i);
				break;
			}
		}
		
		assertTrue(form.minitable.getSelectedRow() >= 0, "Failed to find order line record");
		assertTrue(form.save(form.minitable, getTrxName()), "Failed to save changes");
		
		receipt.load(getTrxName());
		MInOutLine[] receiptLines = receipt.getLines(true);
		assertEquals(1, receiptLines.length, "Unexpected number of Material Receipt Line records");
		assertEquals(orderLine.get_ID(), receiptLines[0].getC_OrderLine_ID(), "Order line not match to material receipt line");
	}
	
	@Test
	public void testCreateFromInvoiceLine() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.HOLLY_BUSH.id));
		orderLine.setQty(new BigDecimal("1"));
		orderLine.setDatePromised(today);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, today);
		invoice.saveEx();
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setQty(new BigDecimal("1"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_MATERIAL_RECEIPT);
		assertNotNull(gridWindow, "Failed to load grid window of Material Receipt");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MInOut.Table_Name);
		query.addRestriction(MInOut.COLUMNNAME_M_InOut_ID, "=", receipt.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(receipt.get_ID(), gridTab.getRecord_ID(), "Wrong Material Receipt record id");
		
		CreateFromShipmentImpl form = new CreateFromShipmentImpl(gridTab);
		form.setTrxName(getTrxName());
		ArrayList<KeyNamePair> invoices = form.getInvoices(order.getC_BPartner_ID());
		assertNotNull(invoices, "Can't load Invoices for BP");
		assertTrue(invoices.size() > 0, "Can't load Invoices for BP");
		boolean found = false;
		for(KeyNamePair knp : invoices) {
			if (knp.getKey() == invoice.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Fail to load Invoice");
		
		form.loadInvoiceLines(invoice.get_ID());
		assertTrue(form.minitable.getRowCount() > 0, "Failed to load data from DB");
		
		form.minitable.setSelectedRow(-1);
		for (int i = 0; i < form.minitable.getRowCount(); i++) {
			KeyNamePair pp = (KeyNamePair) form.minitable.getValueAt(i, 8);
			if (pp.getKey() == invoiceLine.get_ID()) {
				form.minitable.setValueAt(Boolean.TRUE, i, 0);
				form.minitable.setSelectedRow(i);
				break;
			}
		}
		
		assertTrue(form.minitable.getSelectedRow() >= 0, "Failed to find invoice line record");
		assertTrue(form.save(form.minitable, getTrxName()), "Failed to save changes");
		
		receipt.load(getTrxName());
		MInOutLine[] receiptLines = receipt.getLines(true);
		assertEquals(1, receiptLines.length, "Unexpected number of Material Receipt Line records");
		invoiceLine.load(getTrxName());
		assertEquals(invoiceLine.getM_InOutLine_ID(), receiptLines[0].get_ID(), "Invoice line not match to material receipt line");
	}
	
	@Test
	public void testCreateFromCustomerRMALines() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.setSalesRep_ID(getAD_User_ID());
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Unexpected Document Status");
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected Document Status");
		
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setC_BPartner_ID(order.getC_BPartner_ID());
		rma.setM_InOut_ID(shipment.getM_InOut_ID());
		rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
		rma.setC_Currency_ID(order.getC_Currency_ID());
		rma.setName("testCreateFromCustomerRMALines");
		rma.setIsSOTrx(true);
		rma.setSalesRep_ID(order.getSalesRep_ID());
		rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
		rma.saveEx();
		
		MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
		rmaLine.setM_RMA_ID(rma.get_ID());
		rmaLine.setM_InOutLine_ID(shipmentLine.get_ID());
		rmaLine.setM_Product_ID(shipmentLine.getM_Product_ID());
		rmaLine.setQty(new BigDecimal("1"));
		rmaLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		rma.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, rma.getDocStatus(), "Unexpected Document Status");
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_MATERIAL_RECEIPT);
		assertNotNull(gridWindow, "Failed to load grid window of Material Receipt");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MInOut.Table_Name);
		query.addRestriction(MInOut.COLUMNNAME_M_InOut_ID, "=", receipt.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(receipt.get_ID(), gridTab.getRecord_ID(), "Wrong Material Receipt record id");
		
		CreateFromShipmentImpl form = new CreateFromShipmentImpl(gridTab);
		form.setTrxName(getTrxName());
		ArrayList<KeyNamePair> RMAs = form.getRMAs(order.getC_BPartner_ID());
		assertNotNull(RMAs, "Can't load RMAs for BP");
		assertTrue(RMAs.size() > 0, "Can't load RMAsfor BP");
		boolean found = false;
		for(KeyNamePair knp : RMAs) {
			if (knp.getKey() == rma.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Fail to load RMA");
		
		form.loadRMALines(rma.get_ID());
		assertTrue(form.minitable.getRowCount() > 0, "Failed to load data from DB");
		
		form.minitable.setSelectedRow(-1);
		for (int i = 0; i < form.minitable.getRowCount(); i++) {
			KeyNamePair pp = (KeyNamePair) form.minitable.getValueAt(i, 7);
			if (pp.getKey() == rmaLine.get_ID()) {
				form.minitable.setValueAt(Boolean.TRUE, i, 0);
				form.minitable.setSelectedRow(i);
				break;
			}
		}
		
		assertTrue(form.minitable.getSelectedRow() >= 0, "Failed to find RMA line record");
		assertTrue(form.save(form.minitable, getTrxName()), "Failed to save changes");
		
		receipt.load(getTrxName());
		MInOutLine[] receiptLines = receipt.getLines(true);
		assertEquals(1, receiptLines.length, "Unexpected number of Material Receipt Line records");
		rmaLine.load(getTrxName());
		assertEquals(rmaLine.get_ID(), receiptLines[0].getM_RMALine_ID(), "RMA line not match to material receipt line");
	}
	
	private static class CreateFromShipmentImpl extends CreateFromShipment {

		private MiniTableImpl minitable = null;
		
		public CreateFromShipmentImpl(GridTab mTab) {
			super(mTab);
			
			try {
				dynInit();
			} catch (Exception e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}

		@Override
		public Object getWindow() {
			return null;
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
		
		public ArrayList<KeyNamePair> getOrders(int C_BPartner_ID) {
			return super.loadOrderData(C_BPartner_ID, false, true, false);
		}
		
		public void loadOrderLines(int C_Order_ID) {			
			Vector<Vector<Object>> datas = super.getOrderData(C_Order_ID, false, MLocator.getDefault(MWarehouse.get(getM_Warehouse_ID())).getM_Locator_ID());
			for(int i = 0; i < datas.size(); i++) {
				minitable.setRowCount(i+1);
				Vector<Object> data = datas.get(i);
				for(int j = 0; j < data.size(); j++) {
					minitable.setValueAt(data.get(j), i, j);
				}
			}
		}
		
		public ArrayList<KeyNamePair> getInvoices(int C_BPartner_ID) {
			return super.loadInvoiceData(C_BPartner_ID);
		}
		
		public void loadInvoiceLines(int C_Invoice_ID) {
			Vector<Vector<Object>> datas = super.getInvoiceData(C_Invoice_ID, MLocator.getDefault(MWarehouse.get(getM_Warehouse_ID())).getM_Locator_ID());
			for(int i = 0; i < datas.size(); i++) {
				minitable.setRowCount(i+1);
				Vector<Object> data = datas.get(i);
				for(int j = 0; j < data.size(); j++) {
					minitable.setValueAt(data.get(j), i, j);
				}
			}
		}
		
		public ArrayList<KeyNamePair> getRMAs(int C_BPartner_ID) {
			return super.loadRMAData(C_BPartner_ID);
		}
		
		public void loadRMALines(int M_RMA_ID) {
			Vector<Vector<Object>> datas = super.getRMAData(M_RMA_ID, MLocator.getDefault(MWarehouse.get(getM_Warehouse_ID())).getM_Locator_ID());
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
