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
 * - Elaine Tan - etantg       								   		   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MWarehouse;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.FactAcct;
import org.junit.jupiter.api.Test;

/**
 * @author Elaine Tan - etantg
 */
public class MatchInvTest extends AbstractTestCase {

	public MatchInvTest() {
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4173
	 */
	public void testMatShipmentPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(BigDecimal.ONE);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
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
		
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setName(order.getDocumentNo());
		rma.setC_DocType_ID(DictionaryIDs.C_DocType.VENDOR_RETURN_MATERIAL.id); // Vendor Return Material
		rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id); // Damaged on Arrival
		rma.setM_InOut_ID(receipt.get_ID());
		rma.setIsSOTrx(false);
		rma.setSalesRep_ID(SystemIDs.USER_SUPERUSER); // SuperUser
		rma.saveEx();
		
		MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
		rmaLine.setLine(10);
		rmaLine.setM_RMA_ID(rma.get_ID());
		rmaLine.setM_InOutLine_ID(receiptLine.get_ID());
		rmaLine.setQty(BigDecimal.ONE);
		rmaLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
		rma.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());
		
		MInOut delivery = new MInOut(Env.getCtx(), 0, getTrxName());
		delivery.setM_RMA_ID(rma.get_ID());
		delivery.setBPartner(bpartner);
		delivery.setIsSOTrx(false);
		delivery.setMovementType(MInOut.MOVEMENTTYPE_VendorReturns);
		delivery.setC_DocType_ID(DictionaryIDs.C_DocType.MM_VENDOR_RETURN.id); // MM Vendor Return
		delivery.setDocStatus(DocAction.STATUS_Drafted);
		delivery.setDocAction(DocAction.ACTION_Complete);
		delivery.setM_Warehouse_ID(receipt.getM_Warehouse_ID());
		delivery.saveEx();
		
		MInOutLine deliveryLine = new MInOutLine(delivery);
		deliveryLine.setM_RMALine_ID(rmaLine.get_ID());
		deliveryLine.setLine(10);
		deliveryLine.setProduct(product);
		deliveryLine.setQty(BigDecimal.ONE);
		deliveryLine.setM_Locator_ID(receiptLine.getM_Locator_ID());
		deliveryLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(delivery, DocAction.ACTION_Complete);
		delivery.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, delivery.getDocStatus());
		
		if (!delivery.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), delivery.getAD_Client_ID(), MInOut.Table_ID, delivery.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		delivery.load(getTrxName());
		assertTrue(delivery.isPosted());		
		
		MInvoice creditMemo = new MInvoice(delivery, delivery.getMovementDate());
		creditMemo.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APCreditMemo);
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setM_InOutLine_ID(deliveryLine.get_ID());
		creditMemoLine.setLine(10);
		creditMemoLine.setProduct(product);
		creditMemoLine.setQty(BigDecimal.ONE);
		creditMemoLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		creditMemo.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
		
		if (!creditMemo.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), creditMemo.getAD_Client_ID(), MInvoice.Table_ID, creditMemo.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		creditMemo.load(getTrxName());
		assertTrue(creditMemo.isPosted());
		
		MAcctSchema as = MClient.get(getAD_Client_ID()).getAcctSchema();
		BigDecimal credMatchAmt = creditMemoLine.getMatchedQty().negate().multiply(creditMemoLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
		MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
			
			Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
			doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
			MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			
			ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
			MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);

			Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, credMatchAmt, 2, false), new FactAcct(acctInvClr, credMatchAmt, 2, true));
			assertFactAcctEntries(factAccts, expected);
		}
		
		rollback();
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4173
	 */
	public void testMatReceiptPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(BigDecimal.ONE);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
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
		
		MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(BigDecimal.ONE);
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
		
		MAcctSchema as = MClient.get(getAD_Client_ID()).getAcctSchema();
		BigDecimal invMatchAmt = invoiceLine.getMatchedQty().multiply(invoiceLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
		MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
			
			Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
			doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
			MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			
			ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
			MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);

			Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, invMatchAmt, 2, true), new FactAcct(acctInvClr, invMatchAmt, 2, false));
			assertFactAcctEntries(factAccts, expected);
		}
		
		rollback();
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo
	 * PO Qty=10 > IV Qty=10 > MR Qty=9 > CM Qty=1
	 */
	public void testCreditMemoPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(BigDecimal.TEN);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setOrder(order);
		invoice.setDateAcct(order.getDateOrdered());
		invoice.setSalesRep_ID(order.getSalesRep_ID());
		invoice.setC_BPartner_ID(order.getBill_BPartner_ID());
		invoice.setC_BPartner_Location_ID(order.getBill_Location_ID());
		invoice.setAD_User_ID(order.getBill_User_ID());
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setC_OrderLine_ID(orderLine.get_ID());
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(BigDecimal.TEN);
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
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
				
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setC_OrderLine_ID(orderLine.get_ID());
		receiptLine.setLine(10);
		receiptLine.setProduct(product);
		receiptLine.setQty(new BigDecimal(9));
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
		
		MAcctSchema as = MClient.get(getAD_Client_ID()).getAcctSchema();
		BigDecimal invMatchAmt = invoiceLine.getMatchedQty().multiply(invoiceLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
		MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
			
			Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
			doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
			MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			
			ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
			MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);

			Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(acctInvClr, invMatchAmt, 2, false, mi.getQty().negate()), 
					new FactAcct(acctNIR, invMatchAmt, 2, true, mi.getQty()));
			assertFactAcctEntries(factAccts, expected);
		}
		
		MInvoice creditMemo = new MInvoice(Env.getCtx(), 0, getTrxName());
		creditMemo.setOrder(order);
		creditMemo.setDateAcct(order.getDateOrdered());
		creditMemo.setSalesRep_ID(order.getSalesRep_ID());
		creditMemo.setC_BPartner_ID(order.getBill_BPartner_ID());
		creditMemo.setC_BPartner_Location_ID(order.getBill_Location_ID());
		creditMemo.setAD_User_ID(order.getBill_User_ID());
		creditMemo.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APCreditMemo);
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setC_OrderLine_ID(orderLine.get_ID());
		creditMemoLine.setLine(10);
		creditMemoLine.setProduct(product);
		creditMemoLine.setQty(BigDecimal.ONE);
		creditMemoLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		creditMemo.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
		
		if (!creditMemo.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), creditMemo.getAD_Client_ID(), MInvoice.Table_ID, creditMemo.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		creditMemo.load(getTrxName());
		assertTrue(creditMemo.isPosted());
		
		BigDecimal credMatchAmt = creditMemoLine.getMatchedQty().negate().multiply(creditMemoLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
		miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
			
			ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
			MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);

			Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(acctInvClr, credMatchAmt, 2, false, mi.getQty()),
					new FactAcct(acctInvClr, credMatchAmt, 2, true, mi.getQty().negate()));
			assertFactAcctEntries(factAccts, expected);
		}
		
		rollback();
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4128
	 */
	public void testMatReceiptPostingWithDiffCurrencyPrecision() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), Env.DATE);
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Purchase JPY " + System.currentTimeMillis());
		MCurrency japaneseYen = MCurrency.get(DictionaryIDs.C_Currency.JPY.id); // Japanese Yen (JPY)
		priceList.setC_Currency_ID(japaneseYen.getC_Currency_ID());
		priceList.setPricePrecision(japaneseYen.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id); // Purchase 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		BigDecimal priceInYen = new BigDecimal(2400);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInYen, priceInYen, Env.ZERO);
		pp.saveEx();
		
		BigDecimal yenToUsd = new BigDecimal(0.277582);
		MConversionRate cr1 = new MConversionRate(Env.getCtx(), 0, null);
		cr1.setC_Currency_ID(japaneseYen.getC_Currency_ID());
		cr1.setC_Currency_ID_To(DictionaryIDs.C_Currency.USD.id); // USD
		cr1.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id); // Spot
		cr1.setValidFrom(currentDate);
		cr1.setValidTo(currentDate);
		cr1.setMultiplyRate(yenToUsd);
		cr1.saveEx();
		
		BigDecimal euroToUsd = new BigDecimal(0.236675);
		MConversionRate cr2 = new MConversionRate(Env.getCtx(), 0, null);
		cr2.setC_Currency_ID(japaneseYen.getC_Currency_ID());
		cr2.setC_Currency_ID_To(DictionaryIDs.C_Currency.EUR.id); // EUR
		cr2.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id); // Spot
		cr2.setValidFrom(currentDate);
		cr2.setValidTo(currentDate);
		cr2.setMultiplyRate(euroToUsd);
		cr2.saveEx();
		
		try {
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setDateOrdered(currentDate);
			order.setDateAcct(currentDate);
			order.setM_PriceList_ID(priceList.getM_PriceList_ID());
			order.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id); // Spot
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal(3));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
					
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setC_OrderLine_ID(orderLine.get_ID());
			receiptLine.setLine(10);
			receiptLine.setProduct(product);
			receiptLine.setQty(new BigDecimal(3));
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
			
			MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDateInvoiced(currentDate);
			invoice.setDateAcct(currentDate);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			BigDecimal qtyInvoiced = new BigDecimal(3);
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
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
			
			MAcctSchema as = MClient.get(getAD_Client_ID()).getAcctSchema();
			BigDecimal acctAmount = priceInYen.multiply(yenToUsd).multiply(qtyInvoiced).setScale(as.getStdPrecision(), RoundingMode.HALF_UP); 
			BigDecimal acctSource = priceInYen.multiply(qtyInvoiced).setScale(japaneseYen.getStdPrecision(), RoundingMode.HALF_UP);
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
				doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
	
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, acctAmount, acctSource, 2, true), 
						new FactAcct(acctInvClr, acctAmount, acctSource, 2, false));
				assertFactAcctEntries(factAccts, expected);
				assertTrue(acctAmount.compareTo(Env.ZERO) >= 0);
				for (MFactAcct fa : factAccts) {
					assertTrue(fa.getC_Currency_ID() == japaneseYen.getC_Currency_ID());
				}
			}
		} finally {
			rollback();
			String whereClause = "ValidFrom=? AND ValidTo=? "
					+ "AND C_Currency_ID=? AND C_Currency_ID_To=? "
					+ "AND C_ConversionType_ID=? "
					+ "AND AD_Client_ID=? AND AD_Org_ID=?";
			MConversionRate reciprocal = new Query(Env.getCtx(), MConversionRate.Table_Name, whereClause, null)
					.setParameters(cr1.getValidFrom(), cr1.getValidTo(), 
							cr1.getC_Currency_ID_To(), cr1.getC_Currency_ID(),
							cr1.getC_ConversionType_ID(),
							cr1.getAD_Client_ID(), cr1.getAD_Org_ID())
					.firstOnly();
			if (reciprocal != null)
				reciprocal.deleteEx(true);
			cr1.deleteEx(true);
			
			reciprocal = new Query(Env.getCtx(), MConversionRate.Table_Name, whereClause, null)
					.setParameters(cr2.getValidFrom(), cr2.getValidTo(), 
							cr2.getC_Currency_ID_To(), cr2.getC_Currency_ID(),
							cr2.getC_ConversionType_ID(),
							cr2.getAD_Client_ID(), cr2.getAD_Org_ID())
					.firstOnly();
			if (reciprocal != null)
				reciprocal.deleteEx(true);
			cr2.deleteEx(true);
			
			pp.deleteEx(true);
			plv.deleteEx(true);
			priceList.deleteEx(true);			
		}
	}
	
	@Test
	public void testIsReversal() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(BigDecimal.ONE);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
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
		
		MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(BigDecimal.ONE);
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
		
		MMatchInv[] beforeList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		assertEquals(1, beforeList.length);
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Reverse_Correct);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, invoice.getDocStatus());
		
		MMatchInv[] afterList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		assertEquals(2, afterList.length);
		beforeList[0].load(getTrxName());
		assertFalse(beforeList[0].isReversal());
		for(MMatchInv mi : afterList) {
			if (!mi.equals(beforeList[0])) {
				assertTrue(mi.isReversal());
				break;
			}
		}
	}
	
	@Test
	public void testIsReversalCM() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(new BigDecimal("2"));
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
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
		
		MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(new BigDecimal("2"));
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
		
		MInvoice creditMemo = new MInvoice(receipt, receipt.getMovementDate());
		creditMemo.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APCreditMemo);
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setM_InOutLine_ID(receiptLine.get_ID());
		creditMemoLine.setLine(10);
		creditMemoLine.setProduct(product);
		creditMemoLine.setQty(BigDecimal.ONE);
		creditMemoLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		creditMemo.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
		
		if (!creditMemo.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), creditMemo.getAD_Client_ID(), MInvoice.Table_ID, creditMemo.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		creditMemo.load(getTrxName());
		assertTrue(creditMemo.isPosted());

		MMatchInv[] beforeList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
		assertEquals(1, beforeList.length);
		
		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Reverse_Correct);
		creditMemo.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, creditMemo.getDocStatus());
		
		MMatchInv[] afterList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
		assertEquals(2, afterList.length);
		beforeList[0].load(getTrxName());
		assertFalse(beforeList[0].isReversal());
		for(MMatchInv mi : afterList) {
			if (!mi.equals(beforeList[0])) {
				assertTrue(mi.isReversal());
				break;
			}
		}
	}
	
	@Test
	public void testReversalPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(BigDecimal.ONE);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
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
		
		MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(BigDecimal.ONE);
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		MAcctSchema as = MClient.get(getAD_Client_ID()).getAcctSchema();
		BigDecimal invMatchAmt = invoiceLine.getMatchedQty().multiply(invoiceLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
		
		invoice.load(getTrxName());
		assertTrue(invoice.isPosted());
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Reverse_Correct);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, invoice.getDocStatus());
		
		MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		assertEquals(2, miList.length);
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
			
			Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
			doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
			MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			
			ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
			MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, invMatchAmt, 2, !mi.isReversal(), mi.getQty()),
					new FactAcct(acctInvClr, invMatchAmt, 2, mi.isReversal(), mi.getQty().negate()));
			assertFactAcctEntries(factAccts, expected);
		}
	}
	
	@Test
	public void testReversalPostingWithZeroOnHand() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		
		MProduct product = null;
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		Timestamp today = TimeUtil.getDay(null);
		try {			
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testReversalPostingWithZeroOnHand");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			BigDecimal orderPrice = new BigDecimal("2.00");
			pp.setPriceStd(orderPrice);
			pp.setPriceList(orderPrice);
			pp.saveEx();
			
			int purchaseId = DictionaryIDs.M_PriceList.PURCHASE.id; // Purchase Price List			
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setM_PriceList_ID(purchaseId);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(BigDecimal.TEN);
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setC_OrderLine_ID(orderLine.get_ID());
			receiptLine.setLine(10);
			receiptLine.setProduct(product);
			receiptLine.setQty(orderLine.getQtyOrdered());			
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
			
			//customer shipment
			MOrder salesOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			salesOrder.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			salesOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			salesOrder.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder.setDocAction(DocAction.ACTION_Complete);
			salesOrder.setDatePromised(today);
			salesOrder.saveEx();
			
			MOrderLine salesLine1 = new MOrderLine(salesOrder);
			salesLine1.setLine(10);
			salesLine1.setProduct(product);
			salesLine1.setQty(orderLine.getQtyOrdered());
			salesLine1.setDatePromised(today);
			salesLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(salesOrder, DocAction.ACTION_Complete);
			salesOrder.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder.getDocStatus(), "Unexpected Document Status");
			
			MInOut shipment = new MInOut(salesOrder, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setOrderLine(salesLine1, 0, orderLine.getQtyOrdered());
			shipmentLine.setQty(orderLine.getQtyOrdered());
			shipmentLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected Document Status");
			
			MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			//MR invoice
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(orderLine.getQtyOrdered());
			invoiceLine.setPrice(orderPrice.add(BigDecimal.ONE));
			invoiceLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			BigDecimal invMatchAmt = invoiceLine.getMatchedQty().multiply(invoiceLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
			BigDecimal poMatchAmt = invoiceLine.getMatchedQty().multiply(orderLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
			
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			//reverse MR invoice
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Reverse_Correct);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, invoice.getDocStatus());
			
			MInvoice reversalInvoice = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), getTrxName());
			if (!reversalInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversalInvoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
			assertEquals(2, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null, error);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				MMatchInv mir = new MMatchInv(Env.getCtx(), mi.getReversal_ID(), getTrxName());
				if (!mir.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mir.getAD_Client_ID(), MMatchInv.Table_ID, mir.get_ID(), false, getTrxName());
					assertTrue(error == null, error);
				}
				mir.load(getTrxName());
				assertTrue(mir.isPosted());
				
				Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
				doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				MAccount acctIPV = pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, poMatchAmt, 2, !mi.isReversal(), mi.getQty()),
						new FactAcct(acctInvClr, invMatchAmt, 2, mi.isReversal(), mi.getQty().negate()),
						new FactAcct(acctIPV, invMatchAmt.subtract(poMatchAmt), 2, !mi.isReversal()));
				assertFactAcctEntries(factAccts, expected);
			}
		} finally {
			rollback();
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
		}
	}
}
