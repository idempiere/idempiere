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
 * - etantg                         								   *
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
import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MWarehouse;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author etantg
 */
public class InOutTest extends AbstractTestCase {
	
	public InOutTest() {
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4656
	 */
	public void testMatReceiptPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		int Spot_ConversionType_ID = 114; // Spot;
		int Company_ConversionType_ID = 201; // Company
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Purchase AUD " + System.currentTimeMillis());
		MCurrency australianDollar = MCurrency.get("AUD"); // Australian Dollar (AUD)
		priceList.setC_Currency_ID(australianDollar.getC_Currency_ID());
		priceList.setPricePrecision(australianDollar.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(101); // Purchase 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		BigDecimal priceInAud = new BigDecimal(23.32);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInAud, priceInAud, Env.ZERO);
		pp.saveEx();
		
		MCurrency usd = MCurrency.get("USD"); // USD
		BigDecimal audToUsdCompany = new BigDecimal(0.676234);
		MConversionRate crUsdCompany = createConversionRate(australianDollar.getC_Currency_ID(), usd.getC_Currency_ID(), Company_ConversionType_ID, currentDate, audToUsdCompany);
		BigDecimal audToUsdSpot = new BigDecimal(0.77);
		MConversionRate crUsdSpot = createConversionRate(australianDollar.getC_Currency_ID(), usd.getC_Currency_ID(), Spot_ConversionType_ID, currentDate, audToUsdSpot);
		
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal audToEuroCompany = new BigDecimal(0.746234);
		MConversionRate crEurCompany = createConversionRate(australianDollar.getC_Currency_ID(), euro.getC_Currency_ID(), Company_ConversionType_ID, currentDate, audToEuroCompany);
		BigDecimal audToEuroSpot = new BigDecimal(0.64);
		MConversionRate crEurSpot = createConversionRate(australianDollar.getC_Currency_ID(), euro.getC_Currency_ID(), Spot_ConversionType_ID, currentDate, audToEuroSpot);

		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), Company_ConversionType_ID);			
			BigDecimal qtyOrdered = new BigDecimal(500);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInAud);
			completeDocument(order);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(500);
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdCompany;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroCompany;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				doc.setC_BPartner_ID(receipt.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MInOut.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + receipt.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctNIR.getAccount_ID() == fa.getAccount_ID()) {
						if (receiptLine.get_ID() == fa.getLine_ID()) {
							BigDecimal acctSource = orderLine.getPriceActual().multiply(receiptLine.getMovementQty())
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							BigDecimal acctAmount = acctSource.multiply(rate)
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							assertTrue(fa.getAmtSourceCr().compareTo(acctSource) == 0, fa.getAmtSourceCr().toPlainString() + " != " + acctSource.toPlainString());
							assertTrue(fa.getAmtAcctCr().compareTo(acctAmount) == 0, fa.getAmtAcctCr().toPlainString() + " != " + acctAmount.toPlainString());							
						}
					}
				}
			}
			
			order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), Spot_ConversionType_ID);
			orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInAud);
			completeDocument(order);
			
			receipt = createMMReceipt(order, currentDate);
			receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdSpot;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroSpot;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				doc.setC_BPartner_ID(receipt.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MInOut.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + receipt.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctNIR.getAccount_ID() == fa.getAccount_ID()) {
						if (receiptLine.get_ID() == fa.getLine_ID()) {							
							BigDecimal acctSource = orderLine.getPriceActual().multiply(receiptLine.getMovementQty())
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							BigDecimal acctAmount = acctSource.multiply(rate)
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							assertTrue(fa.getAmtSourceCr().compareTo(acctSource) == 0, fa.getAmtSourceCr().toPlainString() + " != " + acctSource.toPlainString());
							assertTrue(fa.getAmtAcctCr().compareTo(acctAmount) == 0, fa.getAmtAcctCr().toPlainString() + " != " + acctAmount.toPlainString());							
						}
					}
				}
			}
		} finally {
			deleteConversionRate(crUsdCompany);
			deleteConversionRate(crUsdSpot);
			deleteConversionRate(crEurCompany);
			deleteConversionRate(crEurSpot);
			
			pp.deleteEx(true);
			plv.deleteEx(true);
			priceList.deleteEx(true);
			
			rollback();
		}		
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4656
	 */
	public void testMatShipmentPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		int Company_ConversionType_ID = 201; // Company
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Purchase AUD " + System.currentTimeMillis());
		MCurrency australianDollar = MCurrency.get("AUD"); // Australian Dollar (AUD)
		priceList.setC_Currency_ID(australianDollar.getC_Currency_ID());
		priceList.setPricePrecision(australianDollar.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(101); // Purchase 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		BigDecimal priceInAud = new BigDecimal(23.32);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInAud, priceInAud, Env.ZERO);
		pp.saveEx();
		
		MCurrency usd = MCurrency.get("USD"); // USD
		BigDecimal audToUsdCompany = new BigDecimal(0.676234);
		MConversionRate crUsdCompany = createConversionRate(australianDollar.getC_Currency_ID(), usd.getC_Currency_ID(), Company_ConversionType_ID, currentDate, audToUsdCompany);
		
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal audToEuroCompany = new BigDecimal(0.746234);
		MConversionRate crEurCompany = createConversionRate(australianDollar.getC_Currency_ID(), euro.getC_Currency_ID(), Company_ConversionType_ID, currentDate, audToEuroCompany);
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), Company_ConversionType_ID);			
			BigDecimal qtyOrdered = BigDecimal.TEN;
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInAud);
			completeDocument(order);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = BigDecimal.TEN;
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdCompany;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroCompany;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				doc.setC_BPartner_ID(receipt.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MInOut.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + receipt.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctNIR.getAccount_ID() == fa.getAccount_ID()) {
						if (receiptLine.get_ID() == fa.getLine_ID()) {
							BigDecimal acctSource = orderLine.getPriceActual().multiply(receiptLine.getMovementQty())
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							BigDecimal acctAmount = acctSource.multiply(rate)
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							assertTrue(fa.getAmtSourceCr().compareTo(acctSource) == 0, fa.getAmtSourceCr().toPlainString() + " != " + acctSource.toPlainString());
							assertTrue(fa.getAmtAcctCr().compareTo(acctAmount) == 0, fa.getAmtAcctCr().toPlainString() + " != " + acctAmount.toPlainString());							
						}
					}
				}
			}
			
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
			rmaLine.setQty(BigDecimal.TEN);
			rmaLine.saveEx();
			
			completeDocument(rma);
			
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
			deliveryLine.setQty(BigDecimal.TEN);
			deliveryLine.setM_Locator_ID(receiptLine.getM_Locator_ID());
			deliveryLine.saveEx();
			
			completeDocument(delivery);
			postDocument(delivery);
			
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdCompany;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroCompany;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, delivery.get_ID(), getTrxName());
				doc.setC_BPartner_ID(delivery.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MInOut.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + delivery.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctNIR.getAccount_ID() == fa.getAccount_ID()) {
						if (deliveryLine.get_ID() == fa.getLine_ID()) {
							BigDecimal acctSource = orderLine.getPriceActual().multiply(deliveryLine.getMovementQty())
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							BigDecimal acctAmount = acctSource.multiply(rate)
									.setScale(as.getC_Currency().getStdPrecision(), RoundingMode.HALF_UP);
							assertTrue(fa.getAmtAcctDr().compareTo(acctAmount) == 0, fa.getAmtAcctDr().toPlainString() + " != " + acctAmount.toPlainString());							
						}
					}
				}
			}
		} finally {
			deleteConversionRate(crUsdCompany);
			deleteConversionRate(crEurCompany);
			
			pp.deleteEx(true);
			plv.deleteEx(true);
			priceList.deleteEx(true);
			
			rollback();
		}		
	}
	
	private MConversionRate createConversionRate(int C_Currency_ID, int C_Currency_ID_To, int C_ConversionType_ID, 
			Timestamp date, BigDecimal rate) {
		return createConversionRate(C_Currency_ID, C_Currency_ID_To, C_ConversionType_ID, date, rate, true);
	}
	
	private MConversionRate createConversionRate(int C_Currency_ID, int C_Currency_ID_To, int C_ConversionType_ID, 
			Timestamp date, BigDecimal rate, boolean isMultiplyRate) {
		MConversionRate cr = new MConversionRate(Env.getCtx(), 0, null);
		cr.setC_Currency_ID(C_Currency_ID);
		cr.setC_Currency_ID_To(C_Currency_ID_To);
		cr.setC_ConversionType_ID(C_ConversionType_ID);
		cr.setValidFrom(date);
		cr.setValidTo(date);
		if (isMultiplyRate)
			cr.setMultiplyRate(rate);
		else
			cr.setDivideRate(rate);
		cr.saveEx();
		return cr;
	}
	
	private void deleteConversionRate(MConversionRate cr) {
		String whereClause = "ValidFrom=? AND ValidTo=? "
				+ "AND C_Currency_ID=? AND C_Currency_ID_To=? "
				+ "AND C_ConversionType_ID=? "
				+ "AND AD_Client_ID=? AND AD_Org_ID=?";
		MConversionRate reciprocal = new Query(Env.getCtx(), MConversionRate.Table_Name, whereClause, null)
				.setParameters(cr.getValidFrom(), cr.getValidTo(), 
						cr.getC_Currency_ID_To(), cr.getC_Currency_ID(),
						cr.getC_ConversionType_ID(),
						cr.getAD_Client_ID(), cr.getAD_Org_ID())
				.firstOnly();
		if (reciprocal != null)
			reciprocal.deleteEx(true);
		cr.deleteEx(true);
	}
	
	private MOrder createPurchaseOrder(MBPartner bpartner, Timestamp date, int M_PriceList_ID, int C_ConversionType_ID) {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDateOrdered(date);
		order.setDateAcct(date);
		order.setM_PriceList_ID(M_PriceList_ID);
		order.setC_ConversionType_ID(C_ConversionType_ID);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		return order;
	}
	
	private MOrderLine createPurchaseOrderLine(MOrder order, int line, MProduct product, BigDecimal qty, BigDecimal price) {
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(line);
		orderLine.setProduct(product);
		orderLine.setQty(qty);
		orderLine.setPrice(price);
		orderLine.saveEx();
		return orderLine;
	}
	
	private MInOut createMMReceipt(MOrder order, Timestamp date) {
		MInOut receipt = new MInOut(order, 122, date); // MM Receipt
		receipt.saveEx();
		return receipt;
	}
	
	private MInOutLine createMMReceiptLine(MInOut receipt, MOrderLine orderLine, BigDecimal qty) {
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setC_OrderLine_ID(orderLine.get_ID());
		receiptLine.setLine(orderLine.getLine());
		receiptLine.setProduct(orderLine.getProduct());
		receiptLine.setQty(qty);
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		receiptLine.setM_Locator_ID(M_Locator_ID);
		receiptLine.saveEx();
		return receiptLine;
	}
	
	private void completeDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Completed, docStatus, DocAction.STATUS_Completed + " != " + docStatus);
	}
	
	private void postDocument(PO po) {
		if (!po.get_ValueAsBoolean("Posted")) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), po.getAD_Client_ID(), po.get_Table_ID(), po.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		po.load(getTrxName());
		assertTrue(po.get_ValueAsBoolean("Posted"));
	}
}
