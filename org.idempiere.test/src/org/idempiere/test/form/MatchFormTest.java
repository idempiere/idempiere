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
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;

import org.compiere.apps.form.Match;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.MiniTableImpl;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MWarehouse;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class MatchFormTest extends AbstractTestCase {

	public MatchFormTest() {
	}

	@Test
	public void testMatchReceiptToPO() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id);
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id);
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		BigDecimal orderQty = new BigDecimal("1");
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(orderQty);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(0, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		
		MInOut receipt = new MInOut(Env.getCtx(), 0, getTrxName());
		receipt.setBPartner(bpartner);
		receipt.setIsSOTrx(false);
		receipt.setC_DocType_ID(DictionaryIDs.C_DocType.MM_RECEIPT.id);
		receipt.setM_Warehouse_ID(getM_Warehouse_ID());
		receipt.saveEx();		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();		
		BigDecimal receiptQty = new BigDecimal("1");
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setProduct(product);
		receiptLine.setM_Locator_ID(M_Locator_ID);
		receiptLine.setLine(10);
		receiptLine.setQty(receiptQty);
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(0, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		
		Match match = new Match();
		match.setTrxName(getTrxName());
		ColumnInfo[] columnLayout = match.getColumnLayout();
		MiniTableImpl fromTable = new MiniTableImpl();
		MiniTableImpl toTable = new MiniTableImpl();
		fromTable.prepareTable(columnLayout, null, false, null, null);
		toTable.prepareTable(columnLayout, null, false, null, null);
		
		//load not matched shipments
		match.cmd_search(fromTable, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched Material Receipt: " + fromTable.getRowCount());
		int selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, Match.I_DocumentNo);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for Material Receipt line");
				int qty = ((Number)fromTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(receiptLine.getMovementQty().intValue(), qty, "Unexpected qty for Material Receipt line");
				selectedRow = i;
				break;
			}
		}
		assertTrue(selectedRow >= 0, "Can't find not matched Material Receipt line");
		fromTable.setSelectedRow(selectedRow);
		
		//load not matched orders
		match.cmd_searchTo(fromTable, toTable, match.getMatchTypeText(Match.MATCH_ORDER), Match.MATCH_SHIPMENT, true, true, true, false);
		assertTrue(toTable.getRowCount()>0, "Unexpected number of records for not matched Order Line: " + fromTable.getRowCount());
		int selectedOrderRow = -1;
		for(int i = 0; i < toTable.getRowCount(); i++) {
			String docNo = (String)toTable.getValueAt(i, Match.I_DocumentNo);
			if (order.getDocumentNo().equals(docNo)) {
				int matched = ((Number)toTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for PO line");
				int qty = ((Number)toTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for PO line");
				selectedOrderRow = i;
				break;
			}
		}
		assertTrue(selectedOrderRow >= 0, "Can't find not matched PO line");
		
		//select and process matching
		IDColumn idColumn = (IDColumn)toTable.getValueAt(selectedOrderRow, Match.I_ID);
		idColumn.setSelected(true);
		match.cmd_process(fromTable, toTable, Match.MODE_NOTMATCHED, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), new BigDecimal(1));
		
		orderLine.load(getTrxName());
		assertEquals(0, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(1, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		receiptLine.load(getTrxName());
		assertEquals(orderLine.getC_OrderLine_ID(), receiptLine.getC_OrderLine_ID(), "Unexpected order line ID value for receipt line");
		MMatchPO[] matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(1, matchPOs.length, "Unexpected number of MatchPO for order line");
	}
	
	@Test
	public void testMatchInvoiceToReceipt() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id);
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id);
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		BigDecimal orderQty = new BigDecimal("1");
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(orderQty);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(0, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setC_OrderLine_ID(orderLine.get_ID());
		receiptLine.setLine(10);
		receiptLine.setProduct(product);
		receiptLine.setQty(BigDecimal.ONE);
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		receiptLine.setM_Locator_ID(M_Locator_ID);
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		receipt.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		if (!receipt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		receipt.load(getTrxName());
		assertTrue(receipt.isPosted());
		
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
		invoice.setBPartner(bpartner);
		invoice.setDateAcct(order.getDateAcct());
		invoice.setDateInvoiced(order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		BigDecimal qtyInvoiced = new BigDecimal(1);
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setProduct(product);
		invoiceLine.setLine(10);
		invoiceLine.setQty(qtyInvoiced);
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		invoice.load(getTrxName());
		assertTrue(invoice.isPosted());
		
		Match match = new Match();
		match.setTrxName(getTrxName());
		ColumnInfo[] columnLayout = match.getColumnLayout();
		MiniTableImpl fromTable = new MiniTableImpl(columnLayout);
		MiniTableImpl toTable = new MiniTableImpl(columnLayout);
		
		//load not match invoice
		match.cmd_search(fromTable, Match.MATCH_INVOICE, match.getMatchTypeText(Match.MATCH_SHIPMENT), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched vendor invoice: " + fromTable.getRowCount());
		int selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, Match.I_DocumentNo);
			if (invoice.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for purchase order line");
				int qty = ((Number)fromTable.getValueAt(i, Match.I_QTY)).intValue() ;
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for vendor invoice line");
				selectedRow = i;
				break;
			}
		}
		assertTrue(selectedRow >= 0, "Can't find not matched vendor invoice line");
		fromTable.setSelectedRow(selectedRow);
		
		//load not matched receipt
		match.cmd_searchTo(fromTable, toTable, match.getMatchTypeText(Match.MATCH_SHIPMENT), Match.MATCH_INVOICE, true, true, true, false);
		assertTrue(toTable.getRowCount()>0, "Unexpected number of records for not matched material receipt Line: " + fromTable.getRowCount());
		int selectedReceiptRow = -1;
		for(int i = 0; i < toTable.getRowCount(); i++) {
			String docNo = (String)toTable.getValueAt(i, Match.I_DocumentNo);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)toTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for material receipt line");
				int qty = ((Number)toTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for material receipt line");
				selectedReceiptRow = i;
				break;
			}
		}
		assertTrue(selectedReceiptRow >= 0, "Can't find not matched material receipt line");
		
		//select and process matching
		IDColumn idColumn = (IDColumn)toTable.getValueAt(selectedReceiptRow, Match.I_ID);
		idColumn.setSelected(true);
		match.cmd_process(fromTable, toTable, Match.MODE_NOTMATCHED, Match.MATCH_INVOICE, match.getMatchTypeText(Match.MATCH_SHIPMENT), new BigDecimal(1));
		
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced value");
		receiptLine.load(getTrxName());
		MMatchInv[] matchInvs = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		assertEquals(1, matchInvs.length, "Unexpected number of MatchInv for invoice line");
	}
	
	@Test
	public void testMatchReceiptToInvoice() {
		testMatchReceiptToInvoice(BigDecimal.ONE, false);
		testMatchReceiptToInvoice(BigDecimal.TEN, true);
	}

	public void testMatchReceiptToInvoice(BigDecimal qty, boolean withVendorReturn) {
		String trxName = getTrxName();
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id);
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id);
		
		MOrder order = new MOrder(Env.getCtx(), 0, trxName);
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(qty);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		orderLine.load(trxName);
		assertEquals(qty.intValue(), orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(0, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setC_OrderLine_ID(orderLine.get_ID());
		receiptLine.setLine(10);
		receiptLine.setProduct(product);
		receiptLine.setQty(qty);
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		receiptLine.setM_Locator_ID(M_Locator_ID);
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		receipt.load(trxName);
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		if (!receipt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, trxName);
			assertTrue(error == null);
		}
		receipt.load(trxName);
		assertTrue(receipt.isPosted());
		
		orderLine.load(trxName);
		assertEquals(0, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(qty.intValue(), orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		assertEquals(0, orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced value");
				
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, trxName);
		invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
		invoice.setBPartner(bpartner);
		invoice.setDateAcct(order.getDateAcct());
		invoice.setDateInvoiced(order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setProduct(product);
		invoiceLine.setLine(10);
		invoiceLine.setQty(qty);
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(trxName);
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, trxName);
			assertTrue(error == null);
		}
		invoice.load(trxName);
		assertTrue(invoice.isPosted());
		
		Match match = new Match();
		match.setTrxName(trxName);
		ColumnInfo[] columnLayout = match.getColumnLayout();
		MiniTableImpl fromTable = new MiniTableImpl(columnLayout);
		MiniTableImpl toTable = new MiniTableImpl(columnLayout);
		
		//load not match receipt
		match.cmd_search(fromTable, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_INVOICE), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched material receipt: " + fromTable.getRowCount());
		int selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, Match.I_DocumentNo);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for material receipt line");
				int qtyToMatch = ((Number)fromTable.getValueAt(i, Match.I_QTY)).intValue() ;
				assertEquals(orderLine.getQtyOrdered().intValue(), qtyToMatch, "Unexpected qty for material receipt line");
				selectedRow = i;
				break;
			}
		}
		assertTrue(selectedRow >= 0, "Can't find not matched material receipt line");
		fromTable.setSelectedRow(selectedRow);
		
		//load not matched vendor invoice
		match.cmd_searchTo(fromTable, toTable, match.getMatchTypeText(Match.MATCH_INVOICE), Match.MATCH_SHIPMENT, true, true, true, false);
		assertTrue(toTable.getRowCount()>0, "Unexpected number of records for not matched vendor invoice Line: " + fromTable.getRowCount());
		int selectedInvoiceRow = -1;
		for(int i = 0; i < toTable.getRowCount(); i++) {
			String docNo = (String)toTable.getValueAt(i, Match.I_DocumentNo);
			if (invoice.getDocumentNo().equals(docNo)) {
				int matched = ((Number)toTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for vendor invoice line");
				int qtyToMatch = ((Number)toTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qtyToMatch, "Unexpected qty for vendor invoice line");
				selectedInvoiceRow = i;
				break;
			}
		}
		assertTrue(selectedInvoiceRow >= 0, "Can't find not matched vendor invoice line");

		// select and process matching
		IDColumn idColumn = (IDColumn) toTable.getValueAt(selectedInvoiceRow, Match.I_ID);
		idColumn.setSelected(true);
		match.cmd_process(fromTable, toTable, Match.MODE_NOTMATCHED, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_INVOICE), qty);
		orderLine.load(trxName);
		assertEquals(qty.intValue(), orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced value");
		receiptLine.load(trxName);
		MMatchInv[] matchInvs = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), trxName);
		assertEquals(1, matchInvs.length, "Unexpected number of MatchInv for invoice line");

		if (withVendorReturn)
		{
			BigDecimal qtyReturn = BigDecimal.valueOf(2);
			// ----------------------------------------------------------------------
			// Create Vendor RMA (Damaged Qty = 2)
			// ----------------------------------------------------------------------
			MRMA rma = new MRMA(Env.getCtx(), 0, trxName);
			rma.setM_InOut_ID(receipt.getM_InOut_ID());
			rma.setC_BPartner_ID(receipt.getC_BPartner_ID());
			rma.setC_Currency_ID(order.getC_Currency_ID());
			rma.setIsSOTrx(false);
			rma.setName("testVendorRMA");
			rma.setC_DocType_ID(DictionaryIDs.C_DocType.VENDOR_RETURN_MATERIAL.id);
			rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
			rma.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
			rma.saveEx();

			MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, trxName);
			rmaLine.setM_RMA_ID(rma.get_ID());
			rmaLine.setM_InOutLine_ID(receiptLine.getM_InOutLine_ID());
			rmaLine.setM_Product_ID(receiptLine.getM_Product_ID());
			rmaLine.setQty(qtyReturn);
			rmaLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			rma.load(trxName);
			assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());

			// ----------------------------------------------------------------------
			// Return To Vendor
			// ----------------------------------------------------------------------
			MInOut rtv = new MInOut(Env.getCtx(), 0, trxName);
			rtv.setM_RMA_ID(rma.get_ID());
			rtv.setAD_Org_ID(rma.getAD_Org_ID());
			rtv.setDescription(rma.getDescription());
			rtv.setC_BPartner_ID(rma.getC_BPartner_ID());
			rtv.setC_BPartner_Location_ID(receipt.getC_BPartner_Location_ID());
			rtv.setM_Warehouse_ID(receipt.getM_Warehouse_ID());
			rtv.setIsSOTrx(rma.isSOTrx());
			rtv.setC_DocType_ID(DictionaryIDs.C_DocType.MM_VENDOR_RETURN.id);
			rtv.setMovementType(MInOut.MOVEMENTTYPE_VendorReturns);
			rtv.setMovementDate(receipt.getMovementDate());
			rtv.setDateAcct(receipt.getDateAcct());
			rtv.saveEx();

			MInOutLine rtvLine = new MInOutLine(rtv);
			rtvLine.setM_RMALine_ID(rmaLine.getM_RMALine_ID());
			rtvLine.setProduct(product);
			rtvLine.setQty(rmaLine.getQty());
			rtvLine.setM_Locator_ID(receiptLine.getM_Locator_ID());
			rtvLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(rtv, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			rtv.load(trxName);
			assertEquals(DocAction.STATUS_Completed, rtv.getDocStatus());

			if (!rtv.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), rtv.getAD_Client_ID(), MInOut.Table_ID, rtv.get_ID(), false, trxName);
				assertNull(error, "Unexpected error when posting Return To Vendor: " + error);
			}
			rtv.load(trxName);
			assertTrue(rtv.isPosted());

			// ----------------------------------------------------------------------
			// Create AP Credit Memo
			// ----------------------------------------------------------------------
			MInvoice creditMemo = new MInvoice(Env.getCtx(), 0, trxName);
			creditMemo.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_CREDIT_MEMO.id);
			creditMemo.setBPartner(bpartner);
			creditMemo.setDateAcct(order.getDateAcct());
			creditMemo.setDateInvoiced(order.getDateOrdered());
			creditMemo.saveEx();

			MInvoiceLine creditLine = new MInvoiceLine(creditMemo);
			creditLine.setLine(10);
			creditLine.setProduct(product);
			creditLine.setQty(qtyReturn);
			creditLine.setC_OrderLine_ID(orderLine.getC_OrderLine_ID());
			creditLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			creditMemo.load(trxName);
			assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());

			if (!creditMemo.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), creditMemo.getAD_Client_ID(), MInvoice.Table_ID, creditMemo.get_ID(), false, trxName);
				assertNull(error, "Unexpected error when posting AP Credit Memo: " + error);
			}
			creditMemo.load(trxName);
			assertTrue(creditMemo.isPosted());

			// ----------------------------------------------------------------------
			// Match Credit Memo <-> Vendor Return
			// ----------------------------------------------------------------------
			Match matchRMA = new Match();
			matchRMA.setTrxName(trxName);

			ColumnInfo[] layout = matchRMA.getColumnLayout();
			MiniTableImpl fromTableReturn = new MiniTableImpl(layout);
			MiniTableImpl toTableReturn = new MiniTableImpl(layout);

			// Load not matched credit memo
			matchRMA.cmd_search(fromTableReturn, Match.MATCH_INVOICE, matchRMA.getMatchTypeText(Match.MATCH_SHIPMENT),
								product.get_ID(), bpartner.get_ID(), null, null, false);

			// Select credit memo row
			int selectedCreditRow = -1;
			for (int i = 0; i < fromTableReturn.getRowCount(); i++)
			{
				String docNo = (String) fromTableReturn.getValueAt(i, Match.I_DocumentNo);
				if (creditMemo.getDocumentNo().equals(docNo))
				{
					selectedCreditRow = i;
					break;
				}
			}
			assertTrue(selectedCreditRow >= 0, "Credit Memo should appear in the Not Matched Invoice list");
			fromTableReturn.setSelectedRow(selectedCreditRow);

			// Load Vendor Return
			matchRMA.cmd_searchTo(	fromTableReturn, toTableReturn, matchRMA.getMatchTypeText(Match.MATCH_SHIPMENT),
									Match.MATCH_INVOICE, true, true, true, false);
			int selectedReturnRow = -1;
			for (int i = 0; i < toTableReturn.getRowCount(); i++)
			{
				String docNo = (String) toTableReturn.getValueAt(i, Match.I_DocumentNo);
				if (rtv.getDocumentNo().equals(docNo))
				{
					selectedReturnRow = i;
					break;
				}
			}

			// Verify that the selected rows are valid
			assertTrue(selectedReturnRow >= 0, "Vendor Return should appear in the Not Matched Shipment list");
			int matchedCR = ((Number) fromTableReturn.getValueAt(selectedCreditRow, Match.I_MATCHED)).intValue();
			int matchedRR = ((Number) toTableReturn.getValueAt(selectedReturnRow, Match.I_MATCHED)).intValue();
			int qtyCheckCR = ((Number) fromTableReturn.getValueAt(selectedCreditRow, Match.I_QTY)).intValue();
			int qtyCheckRR = ((Number) toTableReturn.getValueAt(selectedReturnRow, Match.I_QTY)).intValue();
			assertEquals(0, matchedCR, "Credit Memo should initially have zero matched quantity");
			assertEquals(0, matchedRR, "Vendor Return should initially have zero matched quantity");
			assertEquals(qtyReturn.negate().intValue(), qtyCheckCR, "Unexpected qty for Credit Memo line in Not Matched Invoice list");
			assertEquals(qtyReturn.negate().intValue(), qtyCheckRR, "Unexpected qty for Vendor Return line in Not Matched Shipment list");

			// Select the Vendor Return row and process the match
			IDColumn id = (IDColumn) toTableReturn.getValueAt(selectedReturnRow, Match.I_ID);
			id.setSelected(true);
			matchRMA.cmd_process(	fromTableReturn, toTableReturn, Match.MODE_NOTMATCHED, Match.MATCH_INVOICE,
									matchRMA.getMatchTypeText(Match.MATCH_SHIPMENT), qtyReturn);

			// ----------------------------------------------------------------------
			// Verify MatchInv
			// ----------------------------------------------------------------------
			MMatchInv[] creditMatches = MMatchInv.getInvoiceLine(Env.getCtx(), creditLine.get_ID(), trxName);
			assertEquals(1, creditMatches.length);
			assertEquals(0, creditMatches[0].getQty().compareTo(qtyReturn.negate()), "Unexpected matched quantity");
			assertEquals(rtvLine.getM_InOutLine_ID(), creditMatches[0].getM_InOutLine_ID());
			assertEquals(creditLine.getC_InvoiceLine_ID(), creditMatches[0].getC_InvoiceLine_ID());

			// ----------------------------------------------------------------------
			// Verify nothing remains in Not Matched
			// ----------------------------------------------------------------------
			MiniTableImpl verifyInvoiceTable = new MiniTableImpl(layout);
			matchRMA.cmd_search(verifyInvoiceTable, Match.MATCH_INVOICE, matchRMA.getMatchTypeText(Match.MATCH_SHIPMENT),
								product.get_ID(), bpartner.get_ID(), null, null, false);
			for (int i = 0; i < verifyInvoiceTable.getRowCount(); i++)
			{
				String docNo = (String) verifyInvoiceTable.getValueAt(i, Match.I_DocumentNo);
				assertNotEquals(creditMemo.getDocumentNo(), docNo, "Credit Memo should no longer appear as Not Matched");
			}

			//
			MiniTableImpl verifyReturnTable = new MiniTableImpl(layout);
			matchRMA.cmd_searchTo(	fromTableReturn, verifyReturnTable, matchRMA.getMatchTypeText(Match.MATCH_SHIPMENT), Match.MATCH_INVOICE,
									true, true, true, false);
			for (int i = 0; i < verifyReturnTable.getRowCount(); i++)
			{
				String docNo = (String) verifyReturnTable.getValueAt(i, Match.I_DocumentNo);
				assertNotEquals(rtv.getDocumentNo(), docNo, "Return To Vendor should no longer appear as Not Matched");
			}
		}
	}
}
