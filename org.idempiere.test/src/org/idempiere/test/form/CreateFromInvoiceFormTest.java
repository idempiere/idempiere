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
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Vector;

import org.compiere.grid.CreateFromInvoice;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
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
public class CreateFromInvoiceFormTest extends AbstractTestCase {

	/**
	 * default constructor 
	 */
	public CreateFromInvoiceFormTest() {
	}

	@Test
	public void testCreateFromPurchaseOrder() {
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

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.HOLLY_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
		invoice.setIsSOTrx(false);
		invoice.setSalesRep_ID(order.getSalesRep_ID());
		invoice.setC_Currency_ID(order.getC_Currency_ID());
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.saveEx();
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_INVOICE_VENDOR);
		assertNotNull(gridWindow, "Failed to load grid window of Invoice (Vendor)");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MInvoice.Table_Name);
		query.addRestriction(MInvoice.COLUMNNAME_C_Invoice_ID, "=", invoice.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(invoice.get_ID(), gridTab.getRecord_ID(), "Wrong record id");
		
		CreateFromInvoiceImpl form = new CreateFromInvoiceImpl(gridTab);
		form.setTrxName(getTrxName());
		ArrayList<KeyNamePair> POs = form.getOrders(order.getC_BPartner_ID());
		assertNotNull(POs, "Can't load POs for BP");
		assertTrue(POs.size() > 0, "Can't load POs for BP");
		boolean found = false;
		for(KeyNamePair knp : POs) {
			if (knp.getKey() == order.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Fail to load PO");
		form.loadOrderLines(order.get_ID());
		assertTrue(form.minitable.getRowCount() > 0, "Failed to load data from DB");
		
		form.minitable.setSelectedRow(-1);
		for (int i = 0; i < form.minitable.getRowCount(); i++) {
			KeyNamePair pp = (KeyNamePair) form.minitable.getValueAt(i, 5);
			if (pp.getKey() == line1.get_ID()) {
				form.minitable.setValueAt(Boolean.TRUE, i, 0);
				form.minitable.setSelectedRow(i);
				break;
			}
		}
		
		assertTrue(form.minitable.getSelectedRow() >= 0, "Failed to find order line record");
		assertTrue(form.save(form.minitable, getTrxName()), "Failed to save changes");
		
		invoice.load(getTrxName());
		MInvoiceLine[] lines = invoice.getLines(true);
		assertEquals(1, lines.length, "Unexpected number of invoice lines ");
		assertEquals(lines[0].getM_Product_ID(), line1.getM_Product_ID());
		assertEquals(lines[0].getQtyInvoiced().setScale(2, RoundingMode.HALF_UP), line1.getQtyOrdered().setScale(2, RoundingMode.HALF_UP));
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
	}
	
	@Test
	public void testCreateFromMaterialReceipt() {
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

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.HOLLY_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt);
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine1.setQty(new BigDecimal("1"));
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
		invoice.setIsSOTrx(false);
		invoice.setSalesRep_ID(order.getSalesRep_ID());
		invoice.setC_Currency_ID(order.getC_Currency_ID());
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.saveEx();
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_INVOICE_VENDOR);
		assertNotNull(gridWindow, "Failed to load grid window of Invoice (Vendor)");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MInvoice.Table_Name);
		query.addRestriction(MInvoice.COLUMNNAME_C_Invoice_ID, "=", invoice.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(invoice.get_ID(), gridTab.getRecord_ID(), "Wrong record id");
		
		CreateFromInvoiceImpl form = new CreateFromInvoiceImpl(gridTab);
		form.setTrxName(getTrxName());
		ArrayList<KeyNamePair> MRs = form.getShipments(order.getC_BPartner_ID());
		assertNotNull(MRs, "Can't load MRs for BP");
		assertTrue(MRs.size() > 0, "Can't load MRs for BP");
		boolean found = false;
		for(KeyNamePair knp : MRs) {
			if (knp.getKey() == receipt.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Fail to load MR");
		form.loadShipmentLines(receipt.get_ID());
		assertTrue(form.minitable.getRowCount() > 0, "Failed to load data from DB");
		
		form.minitable.setSelectedRow(-1);
		for (int i = 0; i < form.minitable.getRowCount(); i++) {
			KeyNamePair pp = (KeyNamePair) form.minitable.getValueAt(i, 6);
			if (pp.getKey() == receiptLine1.get_ID()) {
				form.minitable.setValueAt(Boolean.TRUE, i, 0);
				form.minitable.setSelectedRow(i);
				break;
			}
		}
		
		assertTrue(form.minitable.getSelectedRow() >= 0, "Failed to find receipt line record");
		assertTrue(form.save(form.minitable, getTrxName()), "Failed to save changes");
		
		invoice.load(getTrxName());
		MInvoiceLine[] lines = invoice.getLines(true);
		assertEquals(1, lines.length, "Unexpected number of invoice lines ");
		assertEquals(lines[0].getM_Product_ID(), line1.getM_Product_ID());
		assertEquals(lines[0].getQtyInvoiced().setScale(2, RoundingMode.HALF_UP), line1.getQtyOrdered().setScale(2, RoundingMode.HALF_UP));
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
	}
	
	private static class CreateFromInvoiceImpl extends CreateFromInvoice {

		private MiniTableImpl minitable = null;
		
		public CreateFromInvoiceImpl(GridTab mTab) {
			super(mTab);
			
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
		
		public ArrayList<KeyNamePair> getOrders (int C_BPartner_ID) {
			return super.loadOrderData(C_BPartner_ID, true, true, false);
		}
		
		public void loadOrderLines (int C_Order_ID) {
			Vector<Vector<Object>> datas = super.getOrderData(C_Order_ID, true, false);
			for(int i = 0; i < datas.size(); i++) {
				minitable.setRowCount(i+1);
				Vector<Object> data = datas.get(i);
				for(int j = 0; j < data.size(); j++) {
					minitable.setValueAt(data.get(j), i, j);
				}
			}
		}

		public ArrayList<KeyNamePair> getShipments(int C_BPartner_ID) {
			return super.loadShipmentData(C_BPartner_ID);
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
