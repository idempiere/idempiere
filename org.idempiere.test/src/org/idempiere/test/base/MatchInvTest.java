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

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClientInfo;
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
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
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
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		if (!receipt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		receipt.load(getTrxName());
		assertTrue(receipt.isPosted());
		
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setName(order.getDocumentNo());
		rma.setC_DocType_ID(150); // Vendor Return Material
		rma.setM_RMAType_ID(100); // Damaged on Arrival
		rma.setM_InOut_ID(receipt.get_ID());
		rma.setIsSOTrx(false);
		rma.setSalesRep_ID(100); // SuperUser
		rma.saveEx();
		
		MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
		rmaLine.setLine(10);
		rmaLine.setM_RMA_ID(rma.get_ID());
		rmaLine.setM_InOutLine_ID(receiptLine.get_ID());
		rmaLine.setQty(BigDecimal.ONE);
		rmaLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
		rma.load(getTrxName());
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());
		
		MInOut delivery = new MInOut(Env.getCtx(), 0, getTrxName());
		delivery.setM_RMA_ID(rma.get_ID());
		delivery.setBPartner(bpartner);
		delivery.setIsSOTrx(false);
		delivery.setMovementType(MInOut.MOVEMENTTYPE_VendorReturns);
		delivery.setC_DocType_ID(151); // MM Vendor Return
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
		assertFalse(info.isError());
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
		
		if (!creditMemo.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), creditMemo.getAD_Client_ID(), MInvoice.Table_ID, creditMemo.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		creditMemo.load(getTrxName());
		assertTrue(creditMemo.isPosted());
		
		int C_AcctSchema_ID = MClientInfo.get(Env.getCtx()).getC_AcctSchema1_ID();
		MAcctSchema as = MAcctSchema.get(Env.getCtx(), C_AcctSchema_ID);		
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

			String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MMatchInv.Table_ID 
					+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + mi.get_ID()
					+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + C_AcctSchema_ID;
			int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
			for (int id : ids) {
				MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
				if (fa.getAccount_ID() == acctNIR.getAccount_ID())
					assertTrue(fa.getAmtAcctCr().compareTo(Env.ZERO) >= 0);
				else if (fa.getAccount_ID() == acctInvClr.getAccount_ID())
					assertTrue(fa.getAmtAcctDr().compareTo(Env.ZERO) >= 0);
			}
		}
		
		rollback();
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4173
	 */
	public void testMatReceiptPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
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
		assertFalse(info.isError());
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		invoice.load(getTrxName());
		assertTrue(invoice.isPosted());
		
		int C_AcctSchema_ID = MClientInfo.get(Env.getCtx()).getC_AcctSchema1_ID();
		MAcctSchema as = MAcctSchema.get(Env.getCtx(), C_AcctSchema_ID);		
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

			String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MMatchInv.Table_ID 
					+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + mi.get_ID()
					+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + C_AcctSchema_ID;
			int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
			for (int id : ids) {
				MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
				if (fa.getAccount_ID() == acctNIR.getAccount_ID())
					assertTrue(fa.getAmtAcctDr().compareTo(Env.ZERO) >= 0);
				else if (fa.getAccount_ID() == acctInvClr.getAccount_ID())
					assertTrue(fa.getAmtAcctCr().compareTo(Env.ZERO) >= 0);
			}
		}
		
		rollback();
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo
	 * PO Qty=10 > IV Qty=10 > MR Qty=9 > CM Qty=1
	 */
	public void testCreditMemoPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		
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
		assertFalse(info.isError());
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		invoice.load(getTrxName());
		assertTrue(invoice.isPosted());
		
		MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		if (!receipt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		receipt.load(getTrxName());
		assertTrue(receipt.isPosted());
		
		int C_AcctSchema_ID = MClientInfo.get(Env.getCtx()).getC_AcctSchema1_ID();
		MAcctSchema as = MAcctSchema.get(Env.getCtx(), C_AcctSchema_ID);		
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

			String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MMatchInv.Table_ID 
					+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + mi.get_ID()
					+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + C_AcctSchema_ID;
			int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
			for (int id : ids) {
				MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
				if (fa.getAccount_ID() == acctNIR.getAccount_ID())
					assertTrue(fa.getAmtAcctDr().compareTo(Env.ZERO) >= 0);
				else if (fa.getAccount_ID() == acctInvClr.getAccount_ID())
					assertTrue(fa.getAmtAcctCr().compareTo(Env.ZERO) >= 0);
			}
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
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
		
		if (!creditMemo.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), creditMemo.getAD_Client_ID(), MInvoice.Table_ID, creditMemo.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		creditMemo.load(getTrxName());
		assertTrue(creditMemo.isPosted());
		
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

			BigDecimal amtAcctDrInvClr = BigDecimal.ZERO;
			BigDecimal amtAcctCrInvClr = BigDecimal.ZERO;
			String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MMatchInv.Table_ID 
					+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + mi.get_ID()
					+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + C_AcctSchema_ID;
			int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
			for (int id : ids) {
				MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
				if (fa.getAccount_ID() == acctInvClr.getAccount_ID() && fa.getQty().compareTo(BigDecimal.ZERO) < 0) {
					assertTrue(fa.getAmtAcctCr().compareTo(Env.ZERO) >= 0);
					amtAcctCrInvClr = amtAcctCrInvClr.add(fa.getAmtAcctCr());
				}
				else if (fa.getAccount_ID() == acctInvClr.getAccount_ID() && fa.getQty().compareTo(BigDecimal.ZERO) > 0) {
					assertTrue(fa.getAmtAcctDr().compareTo(Env.ZERO) >= 0);
					amtAcctDrInvClr = amtAcctDrInvClr.add(fa.getAmtAcctDr());
				}
			}			
			assertTrue(amtAcctDrInvClr.compareTo(amtAcctCrInvClr) == 0);
		}
		
		rollback();
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4128
	 */
	public void testMatReceiptPostingWithDiffCurrencyPrecision() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Purchase JPY " + System.currentTimeMillis());
		MCurrency japaneseYen = MCurrency.get("JPY"); // Japanese Yen (JPY)
		priceList.setC_Currency_ID(japaneseYen.getC_Currency_ID());
		priceList.setPricePrecision(japaneseYen.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(101); // Purchase 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		BigDecimal priceInYen = new BigDecimal(2400);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInYen, priceInYen, Env.ZERO);
		pp.saveEx();
		
		BigDecimal yenToUsd = new BigDecimal(0.277582);
		MConversionRate cr1 = new MConversionRate(Env.getCtx(), 0, null);
		cr1.setC_Currency_ID(japaneseYen.getC_Currency_ID());
		cr1.setC_Currency_ID_To(100); // USD
		cr1.setC_ConversionType_ID(114); // Spot
		cr1.setValidFrom(currentDate);
		cr1.setValidTo(currentDate);
		cr1.setMultiplyRate(yenToUsd);
		cr1.saveEx();
		
		BigDecimal euroToUsd = new BigDecimal(0.236675);
		MConversionRate cr2 = new MConversionRate(Env.getCtx(), 0, null);
		cr2.setC_Currency_ID(japaneseYen.getC_Currency_ID());
		cr2.setC_Currency_ID_To(102); // EUR
		cr2.setC_ConversionType_ID(114); // Spot
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
			order.setC_ConversionType_ID(114); // Spot
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
			assertFalse(info.isError());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
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
			assertFalse(info.isError());
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
			assertFalse(info.isError());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			int C_AcctSchema_ID = MClientInfo.get(Env.getCtx()).getC_AcctSchema1_ID(); //usd schema
			MAcctSchema as = MAcctSchema.get(Env.getCtx(), C_AcctSchema_ID);		
			BigDecimal acctAmount = priceInYen.multiply(yenToUsd).multiply(qtyInvoiced).setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP); 
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
	
				String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MMatchInv.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + mi.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + C_AcctSchema_ID;
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (fa.getAccount_ID() == acctNIR.getAccount_ID()) {
						assertTrue(fa.getAmtAcctDr().compareTo(Env.ZERO) >= 0);
						assertTrue(fa.getAmtAcctDr().toPlainString().compareTo(acctAmount.toPlainString()) == 0, fa.getAmtAcctDr().toPlainString() + " != " + acctAmount.toPlainString());
						// verify source amt and currency
						assertTrue(fa.getC_Currency_ID() == japaneseYen.getC_Currency_ID());												
						assertTrue(fa.getAmtSourceDr().toPlainString().compareTo(acctSource.toPlainString()) == 0, fa.getAmtSourceDr().toPlainString() + " != " + acctSource.toPlainString());
					} else if (fa.getAccount_ID() == acctInvClr.getAccount_ID()) {
						assertTrue(fa.getAmtAcctCr().compareTo(Env.ZERO) >= 0);
						assertTrue(fa.getAmtAcctCr().toPlainString().compareTo(acctAmount.toPlainString()) == 0, fa.getAmtAcctCr().toPlainString() + " != " + acctAmount.toPlainString());
						// verify source amt and currency
						assertTrue(fa.getC_Currency_ID() == japaneseYen.getC_Currency_ID());
						assertTrue(fa.getAmtSourceCr().toPlainString().compareTo(acctSource.toPlainString()) == 0, fa.getAmtSourceCr().toPlainString() + " != " + acctSource.toPlainString());
					}
				}
			}
		} finally {
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
			rollback();
		}
	}
}
