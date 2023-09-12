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
		fromTable.prepareTable(columnLayout, null, null, false, null);
		toTable.prepareTable(columnLayout, null, null, false, null);
		
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
		
		orderLine.load(getTrxName());
		assertEquals(0, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(1, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		assertEquals(0, orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced value");
				
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
		
		//load not match receipt
		match.cmd_search(fromTable, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_INVOICE), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched material receipt: " + fromTable.getRowCount());
		int selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, Match.I_DocumentNo);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for material receipt line");
				int qty = ((Number)fromTable.getValueAt(i, Match.I_QTY)).intValue() ;
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for material receipt line");
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
				int qty = ((Number)toTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for vendor invoice line");
				selectedInvoiceRow = i;
				break;
			}
		}
		assertTrue(selectedInvoiceRow >= 0, "Can't find not matched vendor invoice line");
		
		//select and process matching
		IDColumn idColumn = (IDColumn)toTable.getValueAt(selectedInvoiceRow, Match.I_ID);
		idColumn.setSelected(true);
		match.cmd_process(fromTable, toTable, Match.MODE_NOTMATCHED, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_INVOICE), new BigDecimal(1));
		
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced value");
		receiptLine.load(getTrxName());
		MMatchInv[] matchInvs = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		assertEquals(1, matchInvs.length, "Unexpected number of MatchInv for invoice line");
	}
}
