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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOut.MatchingRecord;
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

/**
 * Test matching api
 * @author hengsin
 */
public class MatchingTest extends AbstractTestCase {

	/**
	 * default constructor
	 */
	public MatchingTest() {
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
		
		List<MatchingRecord> notMatchList = MInOut.getNotFullyMatchedToOrder(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchList.size() > 0, "Fail to retrieve receipts not fully matched to order");
		Optional<MInOut.MatchingRecord> optionalReceipt = notMatchList.stream().filter(m -> receipt.getDocumentNo().equals(m.documentNo())).findFirst();
		assertTrue(optionalReceipt.isPresent(), "Can't find not matched Material Receipt line");

		if (order.is_UsingTemporaryDocumentNo())
			order.getDocumentNo();
		List<MOrder.MatchingRecord> notMatchOrders = MOrder.getNotFullyMatchedToReceipt(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchOrders.size() > 0, "Fail to retrieve orders not fully matched to material receipt");
		Optional<MOrder.MatchingRecord> optionalOrder = notMatchOrders.stream().filter(m -> order.getDocumentNo().equals(m.documentNo())).findFirst();
		assertTrue(optionalOrder.isPresent(), "Can't find not matched PO line");
				
		//process matching
		boolean ok = receiptLine.matchToOrderLine(orderLine.get_ID(), orderLine.getQtyOrdered());
		assertTrue(ok, "Failed to match receipt line to order line");
		
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
				
		//load not match invoice
		List<MInvoice.MatchingRecord> notMatchInvoices = MInvoice.getNotFullyMatchedToReceipt(bpartner.get_ID(), product.getM_Product_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchInvoices.size() > 0, "Unexpected number of records for not matched vendor invoice");
		Optional<MInvoice.MatchingRecord> optionalInvoice = notMatchInvoices.stream().filter(nmi -> invoice.getDocumentNo().equals(nmi.documentNo())).findFirst();
		assertTrue(optionalInvoice.isPresent(), "Can't find not matched vendor invoice line");
		
		//load not matched receipt
		List<MInOut.MatchingRecord> notMatchReceipts = MInOut.getNotFullyMatchedToInvoice(bpartner.getC_BPartner_ID(), product.getM_Product_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchReceipts.size()>0, "Unexpected number of records for not matched material receipt Line");
		Optional<MInOut.MatchingRecord> optionalReceipt = notMatchReceipts.stream().filter(nmr -> receipt.getDocumentNo().equals(nmr.documentNo())).findFirst();
		assertTrue(optionalReceipt.isPresent(), "Can't find not matched material receipt line");
		
		//select and process matching
		boolean ok = receiptLine.matchToInvoiceLine(invoiceLine.getC_InvoiceLine_ID(), qtyInvoiced);
		assertTrue(ok, "Failed to match receipt line to invoice line");
		
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
		
		//load not match receipt
		List<MInOut.MatchingRecord> notMatchReceipts = MInOut.getNotFullyMatchedToInvoice(bpartner.getC_BPartner_ID(), product.getM_Product_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchReceipts.size()>0, "Unexpected number of records for not matched material receipt");
		Optional<MInOut.MatchingRecord> optionalReceipt = notMatchReceipts.stream().filter(nmr -> receipt.getDocumentNo().equals(nmr.documentNo())).findFirst();
		assertTrue(optionalReceipt.isPresent(), "Can't find not matched material receipt line");
		
		//load not matched vendor invoice
		List<MInvoice.MatchingRecord> notMatchInvoices = MInvoice.getNotFullyMatchedToReceipt(bpartner.getC_BPartner_ID(), product.getM_Product_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchInvoices.size()>0, "Unexpected number of records for not matched vendor invoice Line");
		Optional<MInvoice.MatchingRecord> optionalInvoice = notMatchInvoices.stream().filter(nmi -> invoice.getDocumentNo().equals(nmi.documentNo())).findFirst();
		assertTrue(optionalInvoice.isPresent(), "Can't find not matched vendor invoice line");
		
		//select and process matching
		boolean ok = receiptLine.matchToInvoiceLine(invoiceLine.getC_InvoiceLine_ID(), qtyInvoiced);
		assertTrue(ok, "Failed to match receipt line to invoice line");
		
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced value");
		receiptLine.load(getTrxName());
		MMatchInv[] matchInvs = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		assertEquals(1, matchInvs.length, "Unexpected number of MatchInv for invoice line");
	}

	/**
	 * Test that an order fully matched to both receipt and invoice does not appear
	 * in not-fully-matched lists (IDEMPIERE-7174).
	 * <p>
	 * When an invoice is processed and posted before receipt, two distinct {@link MMatchPO}
	 * records are created for the order line (one for invoice with M_InOutLine_ID == 0,
	 * and one for receipt with C_InvoiceLine_ID == 0). IDEMPIERE-7174 fixed the SQL join
	 * condition so that the existence of both records does not falsely trigger the
	 * unmatched check on the order.
	 */
	@Test
	public void testOrderFullyMatchedToReceiptAndInvoice() {
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
		
		// 1. Verify order appears in both not-fully-matched lists before invoice and receipt
		List<MOrder.MatchingRecord> notMatchReceipts = MOrder.getNotFullyMatchedToReceipt(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchReceipts.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO line should be in not-fully-matched-to-receipt before receipt is created");

		List<MOrder.MatchingRecord> notMatchInvoices = MOrder.getNotFullyMatchedToInvoice(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchInvoices.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO line should be in not-fully-matched-to-invoice before invoice is created");
		
		// 2. Create and complete AP invoice for the order first
		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setQty(orderQty);
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		// Order is fully matched to invoice, but not yet to receipt
		notMatchInvoices = MOrder.getNotFullyMatchedToInvoice(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertFalse(notMatchInvoices.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO line should not be in not-fully-matched-to-invoice after invoice is completed");

		List<MOrder.MatchingRecord> fullOrPartialInvoices = MOrder.getFullOrPartiallyMatchedToInvoice(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(fullOrPartialInvoices.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO line should be in full-or-partially-matched-to-invoice after invoice is completed");

		notMatchReceipts = MOrder.getNotFullyMatchedToReceipt(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(notMatchReceipts.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO line should still be in not-fully-matched-to-receipt before receipt is created");

		// Post the invoice MatchPO so subsequent receipt matching does not combine with it,
		// producing two distinct MatchPO records (one for invoice, one for receipt) to reproduce IDEMPIERE-7174
		MMatchPO[] invoiceMatchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(1, invoiceMatchPOs.length, "Order line should have 1 MatchPO record for invoice");
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), invoiceMatchPOs[0].getC_InvoiceLine_ID());
		assertEquals(0, invoiceMatchPOs[0].getM_InOutLine_ID());
		invoiceMatchPOs[0].setPosted(true);
		invoiceMatchPOs[0].saveEx();

		// 3. Create and complete material receipt for the order
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.saveEx();
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, M_Locator_ID, orderQty);
		receiptLine.setLine(10);
		receiptLine.setQty(orderQty);
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		// Order line should now have 2 distinct MatchPO records (one for invoice, one for receipt)
		MMatchPO[] matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(2, matchPOs.length, "Order line should have 2 distinct MatchPO records (one for invoice, one for receipt)");
		boolean hasReceiptMatch = false;
		boolean hasInvoiceMatch = false;
		for (MMatchPO mpo : matchPOs) {
			if (mpo.getM_InOutLine_ID() == receiptLine.getM_InOutLine_ID() && mpo.getC_InvoiceLine_ID() == 0) {
				hasReceiptMatch = true;
			}
			if (mpo.getC_InvoiceLine_ID() == invoiceLine.getC_InvoiceLine_ID() && mpo.getM_InOutLine_ID() == 0) {
				hasInvoiceMatch = true;
			}
		}
		assertTrue(hasReceiptMatch, "Order line should have a MatchPO record specifically for the receipt");
		assertTrue(hasInvoiceMatch, "Order line should have a MatchPO record specifically for the invoice");

		// 4. Verify order does NOT appear in either not-fully-matched list (IDEMPIERE-7174 fix validation)
		notMatchReceipts = MOrder.getNotFullyMatchedToReceipt(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertFalse(notMatchReceipts.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO fully matched to both receipt and invoice must not appear in not-fully-matched-to-receipt");

		notMatchInvoices = MOrder.getNotFullyMatchedToInvoice(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertFalse(notMatchInvoices.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO fully matched to both receipt and invoice must not appear in not-fully-matched-to-invoice");

		// 5. Verify order DOES appear in both full-or-partially-matched lists
		List<MOrder.MatchingRecord> fullOrPartialReceipts = MOrder.getFullOrPartiallyMatchedToReceipt(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(fullOrPartialReceipts.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO fully matched to both receipt and invoice must appear in full-or-partially-matched-to-receipt");

		fullOrPartialInvoices = MOrder.getFullOrPartiallyMatchedToInvoice(bpartner.get_ID(), product.get_ID(), 0, null, null, getTrxName());
		assertTrue(fullOrPartialInvoices.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())), 
				"PO fully matched to both receipt and invoice must appear in full-or-partially-matched-to-invoice");

		// 6. Also verify filtering by specific line ID
		List<MOrder.MatchingRecord> lineMatchReceipts = MOrder.getFullOrPartiallyMatchedToReceipt(bpartner.get_ID(), product.get_ID(), receiptLine.get_ID(), null, null, getTrxName());
		assertTrue(lineMatchReceipts.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())),
				"PO fully matched should appear in full-or-partially-matched-to-receipt when filtering by M_InOutLine_ID");

		List<MOrder.MatchingRecord> lineMatchInvoices = MOrder.getFullOrPartiallyMatchedToInvoice(bpartner.get_ID(), product.get_ID(), invoiceLine.get_ID(), null, null, getTrxName());
		assertTrue(lineMatchInvoices.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())),
				"PO fully matched should appear in full-or-partially-matched-to-invoice when filtering by C_InvoiceLine_ID");

		List<MOrder.MatchingRecord> notMatchReceiptsWithLine = MOrder.getNotFullyMatchedToReceipt(bpartner.get_ID(), product.get_ID(), receiptLine.get_ID(), null, null, getTrxName());
		assertFalse(notMatchReceiptsWithLine.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())),
				"PO fully matched must not appear in not-fully-matched-to-receipt when filtering by M_InOutLine_ID");

		List<MOrder.MatchingRecord> notMatchInvoicesWithLine = MOrder.getNotFullyMatchedToInvoice(bpartner.get_ID(), product.get_ID(), invoiceLine.get_ID(), null, null, getTrxName());
		assertFalse(notMatchInvoicesWithLine.stream().anyMatch(m -> order.getDocumentNo().equals(m.documentNo())),
				"PO fully matched must not appear in not-fully-matched-to-invoice when filtering by C_InvoiceLine_ID");
	}
}
