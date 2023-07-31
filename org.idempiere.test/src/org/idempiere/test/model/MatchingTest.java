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
}
