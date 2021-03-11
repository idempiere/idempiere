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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.I_C_Currency;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
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
import org.compiere.model.MWarehouse;
import org.compiere.model.PO;
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
public class MatchInv2ndAcctSchemaTest extends AbstractTestCase {
	
	public MatchInv2ndAcctSchemaTest() {
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (same period)
	 * PO Qty1=2400, Qty2=2400 
	 * IV Qty1=2400, Qty2=2400 
	 * CM Qty1=100, Qty2=100
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4263
	 */
	public void testCreditMemoPosting_1() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product1 = MProduct.get(Env.getCtx(), 124); // Elm Tree
		MProduct product2 = MProduct.get(Env.getCtx(), 123); // Oak Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal usdToEur = new BigDecimal(31.526248754713);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, usdToEur);
		BigDecimal eurToUsd = cr.getDivideRate();
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur1 = new BigDecimal(1);
			BigDecimal qtyOrdered1 = new BigDecimal(2400);
			MOrderLine orderLine1 = createPurchaseOrderLine(order, 10, product1, qtyOrdered1, priceInEur1);			
			BigDecimal priceInEur2 = new BigDecimal(2);
			BigDecimal qtyOrdered2 = new BigDecimal(2400);
			MOrderLine orderLine2 = createPurchaseOrderLine(order, 20, product2, qtyOrdered2, priceInEur2);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, currentDate);
			BigDecimal qtyInvoiced1 = new BigDecimal(2400);
			MInvoiceLine invoiceLine1  = createAPInvoiceLine(invoice, orderLine1, qtyInvoiced1);
			BigDecimal qtyInvoiced2 = new BigDecimal(2400);
			MInvoiceLine invoiceLine2 = createAPInvoiceLine(invoice, orderLine2, qtyInvoiced2);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInvoice creditMemo = createAPCreditMemo(order, currentDate);
			BigDecimal qtyCredited1 = new BigDecimal(100);
			MInvoiceLine creditMemoLine1 = createAPCreditMemoLine(creditMemo, orderLine1, qtyCredited1);			
			BigDecimal qtyCredited2 = new BigDecimal(100);
			MInvoiceLine creditMemoLine2 = createAPCreditMemoLine(creditMemo, orderLine2, qtyCredited2);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyInvoiced1.doubleValue(), qtyCredited1.doubleValue()));
			
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine1);
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine1);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine1);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, creditMemoLine1);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced2.doubleValue(), qtyCredited2.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine2);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine2);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro,accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine2);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, creditMemoLine2);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (same period)
	 * PO Qty=10, Price=33.75
	 * MR Qty=5
	 * IV Qty=6
	 * CM Qty=1
	 * MR Qty=5
	 * IV Qty=5
	 */
	public void testCreditMemoPosting_2() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd = new BigDecimal(31.526248754713);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, eurToUsd, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(33.75);
			BigDecimal qtyOrdered = new BigDecimal(10);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);	
			completeDocument(order);
			
			MInOut receipt1 = createMMReceipt(order, currentDate);
			BigDecimal qtyDelivered = new BigDecimal(5);
			MInOutLine receiptLine1 = createMMReceiptLine(receipt1, orderLine, qtyDelivered);
			completeDocument(receipt1);
			postDocument(receipt1);
			
			MInvoice invoice1 = createAPInvoice(order, currentDate);
			BigDecimal qtyInvoiced = new BigDecimal(6);
			MInvoiceLine invoiceLine1 = createAPInvoiceLine(invoice1, orderLine, qtyInvoiced);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine1);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine1);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInvoice creditMemo = createAPCreditMemo(order, currentDate);
			BigDecimal qtyCredited = new BigDecimal(1);
			MInvoiceLine creditMemoLine = createAPCreditMemoLine(creditMemo, orderLine, qtyCredited);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced.doubleValue(), qtyCredited.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine1);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine1);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, creditMemoLine);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInOut receipt2 = createMMReceipt(order, currentDate);
			qtyDelivered = new BigDecimal(5);
			MInOutLine receiptLine2 = createMMReceiptLine(receipt2, orderLine, qtyDelivered);
			completeDocument(receipt2);
			postDocument(receipt2);
			
			MInvoice invoice2 = createAPInvoice(order, currentDate);
			qtyInvoiced = new BigDecimal(5);
			MInvoiceLine invoiceLine2 = createAPInvoiceLine(invoice2, orderLine, qtyInvoiced);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (different period)
	 * PO Qty=3, Price=0.3023, Period 1
	 * IV Qty=3, Period 1
	 * MR Qty=1, Period 2
	 * CM Qty=2, Period 2
	 */
	public void testCreditMemoPosting_3() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = 201; // Company
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Purchase GBP " + System.currentTimeMillis());
		MCurrency britishPound = MCurrency.get("GBP"); // British Pound (GBP)
		priceList.setC_Currency_ID(britishPound.getC_Currency_ID());
		priceList.setPricePrecision(britishPound.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(101); // Purchase 2001
		plv.setValidFrom(date1);
		plv.saveEx();
		
		BigDecimal priceInPound = new BigDecimal(0.3023);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInPound, priceInPound, Env.ZERO);
		pp.saveEx();
		
		MCurrency usd = MCurrency.get("USD"); // USD
		BigDecimal usdToPound1 = new BigDecimal(0.88917098794);
		MConversionRate crUsd1 = createConversionRate(britishPound.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, usdToPound1, false);
		BigDecimal poundToUsd1 = crUsd1.getMultiplyRate();
		
		BigDecimal usdToPound2 = new BigDecimal(0.84225);
		MConversionRate crUsd2 = createConversionRate(britishPound.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, usdToPound2, false);
		BigDecimal poundToUsd2 = crUsd2.getMultiplyRate();
		
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal poundToEuro1 = new BigDecimal(34.7186);
		MConversionRate crEur1 = createConversionRate(britishPound.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date1, poundToEuro1, true);
		
		BigDecimal poundToEuro2 = new BigDecimal(37.1828);
		MConversionRate crEur2 = createConversionRate(britishPound.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date2, poundToEuro2, true);

		try {
			MOrder order = createPurchaseOrder(bpartner, date1, priceList.getM_PriceList_ID(), C_ConversionType_ID);			
			BigDecimal qtyOrdered = new BigDecimal(3);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInPound);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, date1);
			BigDecimal qtyInvoiced = new BigDecimal(3);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt = createMMReceipt(order, date2);			
			BigDecimal qtyDelivered = Env.ONE;
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, poundToEuro2, matchQty, receiptLine);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, poundToEuro1, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, poundToUsd2, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, poundToUsd1, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInvoice creditMemo = createAPCreditMemo(order, date2);
			BigDecimal qtyCredited = new BigDecimal(2);
			MInvoiceLine creditMemoLine = createAPCreditMemoLine(creditMemo, orderLine, qtyCredited);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced.doubleValue(), qtyCredited.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, poundToEuro1, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(euro, poundToEuro2, matchQty, creditMemoLine);
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, poundToUsd1, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(usd, poundToUsd2, matchQty, creditMemoLine);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(crUsd1);
			deleteConversionRate(crUsd2);
			deleteConversionRate(crEur1);
			deleteConversionRate(crEur2);
			
			pp.deleteEx(true);
			plv.deleteEx(true);
			priceList.deleteEx(true);
			
			rollback();
		}		
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (different period)
	 * PO Qty1=1000, Qty2=1000, Qty3=1000, Price1=3.00, Price2=2.70, Price3=3.15, Period 1
	 * IV Qty1=1000, Qty2=1000, Qty3=1000, Period 1
	 * MR Qty1=800, Qty2=700, Qty3=1000, Period 2
	 * CM Qty1=200, Qty2=300, Period 3
	 */
	public void testCreditMemoPosting_4() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product1 = MProduct.get(Env.getCtx(), 124); // Elm Tree
		MProduct product2 = MProduct.get(Env.getCtx(), 123); // Oak Tree
		MProduct product3 = MProduct.get(Env.getCtx(), 130); // Plum Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date2 = new Timestamp(cal.getTimeInMillis());
		Timestamp date3 = currentDate;
		
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30.212666962751);
		MConversionRate cr1 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(31.526248754713);
		MConversionRate cr2 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
		
		BigDecimal eurToUsd3 = new BigDecimal(29.326631220545);
		MConversionRate cr3 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date3, eurToUsd3, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur1 = new BigDecimal(3.00);
			BigDecimal qtyOrdered1 = new BigDecimal(1000);
			MOrderLine orderLine1 = createPurchaseOrderLine(order, 10, product1, qtyOrdered1, priceInEur1);			
			BigDecimal priceInEur2 = new BigDecimal(2.70);
			BigDecimal qtyOrdered2 = new BigDecimal(1000);
			MOrderLine orderLine2 = createPurchaseOrderLine(order, 20, product2, qtyOrdered2, priceInEur2);
			BigDecimal priceInEur3 = new BigDecimal(3.15);
			BigDecimal qtyOrdered3 = new BigDecimal(1000);
			MOrderLine orderLine3 = createPurchaseOrderLine(order, 30, product3, qtyOrdered3, priceInEur3);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, date1);			
			BigDecimal qtyInvoiced1 = qtyOrdered1;
			MInvoiceLine invoiceLine1 = createAPInvoiceLine(invoice, orderLine1, qtyInvoiced1);			
			BigDecimal qtyInvoiced2 = qtyOrdered2;
			MInvoiceLine invoiceLine2 = createAPInvoiceLine(invoice, orderLine2, qtyInvoiced2);
			BigDecimal qtyInvoiced3 = qtyOrdered3;
			MInvoiceLine invoiceLine3 = createAPInvoiceLine(invoice, orderLine3, qtyInvoiced3);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt = createMMReceipt(order, date2);
			BigDecimal qtyDelivered1 = new BigDecimal(800);
			MInOutLine receiptLine1 = createMMReceiptLine(receipt, orderLine1, qtyDelivered1);
			BigDecimal qtyDelivered2 = new BigDecimal(700);
			MInOutLine receiptLine2 = createMMReceiptLine(receipt, orderLine2, qtyDelivered2);
			BigDecimal qtyDelivered3 = new BigDecimal(1000);
			MInOutLine receiptLine3 = createMMReceiptLine(receipt, orderLine3, qtyDelivered3);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered1.doubleValue(), qtyInvoiced1.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine1);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd2, matchQty, receiptLine1);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered2.doubleValue(), qtyInvoiced2.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd2, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine3.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered3.doubleValue(), qtyInvoiced3.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine3);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine3);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd2, matchQty, receiptLine3);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine3);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInvoice creditMemo = createAPCreditMemo(order, date3);			
			BigDecimal qtyCredited1 = new BigDecimal(200);
			MInvoiceLine creditMemoLine1 = createAPCreditMemoLine(creditMemo, orderLine1, qtyCredited1);
			BigDecimal qtyCredited2 = new BigDecimal(300);
			MInvoiceLine creditMemoLine2 = createAPCreditMemoLine(creditMemo, orderLine2, qtyCredited2);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine1.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced1.doubleValue(), qtyCredited1.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine1);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine1);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine1);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd3, matchQty, creditMemoLine1);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced2.doubleValue(), qtyCredited2.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine2);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine2);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine2);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd3, matchQty, creditMemoLine2);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
			deleteConversionRate(cr3);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (same period)
	 * PO Qty=2, Price=0.1875
	 * IV Qty=2
	 * MR Qty=1
	 * CM Qty=1
	 */
	public void testCreditMemoPosting_5() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.870771861909);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, eurToUsd, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.1875);
			BigDecimal qtyOrdered = new BigDecimal(2);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced = new BigDecimal(2);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(1);
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInvoice creditMemo = createAPCreditMemo(order, currentDate);			
			BigDecimal qtyCredited = new BigDecimal(1);
			MInvoiceLine creditMemoLine = createAPCreditMemoLine(creditMemo, orderLine, qtyCredited);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced.doubleValue(), qtyCredited.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, creditMemoLine);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (same period)
	 * PO Qty=200, Price=0.1875
	 * IV Qty=200
	 * MR Qty=100
	 * CM Qty=100
	 */
	public void testCreditMemoPosting_6() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.870771861909);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, eurToUsd, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.1875);
			BigDecimal qtyOrdered = new BigDecimal(200);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced = new BigDecimal(200);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(100);
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInvoice creditMemo = createAPCreditMemo(order, currentDate);			
			BigDecimal qtyCredited = new BigDecimal(100);
			MInvoiceLine creditMemoLine = createAPCreditMemoLine(creditMemo, orderLine, qtyCredited);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced.doubleValue(), qtyCredited.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, creditMemoLine);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (same period)
	 * PO Qty=45, Price=0.3742
	 * IV Qty=45
	 * MR Qty=1
	 * CM Qty=44
	 */
	public void testCreditMemoPosting_7() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.870771861909);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, eurToUsd, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.3742);
			BigDecimal qtyOrdered = new BigDecimal(45);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced = new BigDecimal(45);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(1);
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInvoice creditMemo = createAPCreditMemo(order, currentDate);			
			BigDecimal qtyCredited = new BigDecimal(44);
			MInvoiceLine creditMemoLine = createAPCreditMemoLine(creditMemo, orderLine, qtyCredited);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced.doubleValue(), qtyCredited.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, creditMemoLine);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting for credit memo (same period + reversal)
	 * PO Qty=2, Price=0.1875
	 * IV Qty=2
	 * MR Qty=1
	 * MR Qty=1 (Reversed)
	 * MR Qty=1 (Reversed)
	 * CM Qty=1
	 */
	public void testCreditMemoPosting_8() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.870771861909);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, eurToUsd, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.1875);
			BigDecimal qtyOrdered = new BigDecimal(2);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced = new BigDecimal(2);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt1 = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(1);
			MInOutLine receiptLine = createMMReceiptLine(receipt1, orderLine, qtyDelivered);
			completeDocument(receipt1);
			postDocument(receipt1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInOut receipt2 = createMMReceipt(order, currentDate);			
			qtyDelivered = new BigDecimal(1);
			receiptLine = createMMReceiptLine(receipt2, orderLine, qtyDelivered);
			completeDocument(receipt2);
			postDocument(receipt2);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			reverseDocument(receipt2);
			MInOut receipt3 = new MInOut(Env.getCtx(), receipt2.getReversal_ID(), getTrxName());
			postDocument(receipt3);
			
			ArrayList<MMatchInv> miList0 = new ArrayList<MMatchInv>();
			for (MMatchInv mi : miList) {
				mi.load(getTrxName());
				miList0.add(new MMatchInv(Env.getCtx(), mi.getReversal_ID(), getTrxName()));
			}
			MMatchInv[] miList2 = new MMatchInv[miList0.size()];
			ArrayList<PostingLine> notInvoicedReceiptsLineList2 = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList2 = new ArrayList<PostingLine>();
			for (PostingLine notInvoicedReceiptsLine : notInvoicedReceiptsLineList)
				notInvoicedReceiptsLineList2.add(new PostingLine(notInvoicedReceiptsLine.currency, notInvoicedReceiptsLine.amtAcctCr, notInvoicedReceiptsLine.amtAcctDr));
			for (PostingLine inventoryClearingLine : inventoryClearingLineList)
				inventoryClearingLineList2.add(new PostingLine(inventoryClearingLine.currency, inventoryClearingLine.amtAcctCr, inventoryClearingLine.amtAcctDr));
			testMatchInvoicePosting(ass, miList0.toArray(miList2), notInvoicedReceiptsLineList2, inventoryClearingLineList2);
			
			MInvoice creditMemo = createAPCreditMemo(order, currentDate);			
			BigDecimal qtyCredited = new BigDecimal(1);
			MInvoiceLine creditMemoLine = createAPCreditMemoLine(creditMemo, orderLine, qtyCredited);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), creditMemoLine.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyInvoiced.doubleValue(), qtyCredited.doubleValue()));
			
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, creditMemoLine);			
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));			
			inventoryClearingLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, creditMemoLine);
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			inventoryClearingLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting (same period)
	 * PO Qty=1200, Price=0.3742
	 * IV Qty=1156
	 * IV Qty=44
	 * MR Qty=1200
	 */
	public void testMatReceiptPosting_1() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.870771861909);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, eurToUsd, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.3742);
			BigDecimal qtyOrdered = new BigDecimal(1200);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice1 = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced1 = new BigDecimal(1156);
			MInvoiceLine invoiceLine1 = createAPInvoiceLine(invoice1, orderLine, qtyInvoiced1);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MInvoice invoice2 = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced2 = new BigDecimal(44);
			MInvoiceLine invoiceLine2 = createAPInvoiceLine(invoice2, orderLine, qtyInvoiced2);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(1200);
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced1.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced2.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting (different period)
	 * PO Qty=1200, Price=0.3742, Period 1
	 * IV Qty=1200, Period 1
	 * MR Qty=1156, Period 1
	 * MR Qty=44, Period 2
	 */
	public void testMatReceiptPosting_2() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30.870771861909);
		MConversionRate cr1 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(31.326259863856);
		MConversionRate cr2 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.3742);
			BigDecimal qtyOrdered = new BigDecimal(1200);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, date1);			
			BigDecimal qtyInvoiced = new BigDecimal(1200);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt1 = createMMReceipt(order, date1);			
			BigDecimal qtyDelivered1 = new BigDecimal(1156);
			MInOutLine receiptLine1 = createMMReceiptLine(receipt1, orderLine, qtyDelivered1);
			completeDocument(receipt1);
			postDocument(receipt1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered1.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine1);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd1, matchQty, receiptLine1);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInOut receipt2 = createMMReceipt(order, date2);			
			BigDecimal qtyDelivered2 = new BigDecimal(44);
			MInOutLine receiptLine2 = createMMReceiptLine(receipt2, orderLine, qtyDelivered2);
			completeDocument(receipt2);
			postDocument(receipt2);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered2.doubleValue(), qtyInvoiced.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd2, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting (same period + reversal)
	 * PO Qty=2, Price=0.1875
	 * IV Qty=2
	 * MR Qty=1 
	 * MR Qty=1 (Reversed)
	 * MR Qty=1 (Reversed)
	 * MR Qty=1
	 */
	public void testMatReceiptPosting_3() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.870771861909);
		MConversionRate cr = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, eurToUsd, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.1875);
			BigDecimal qtyOrdered = new BigDecimal(2);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced = new BigDecimal(2);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt1 = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered1 = new BigDecimal(1);
			MInOutLine receiptLine1 = createMMReceiptLine(receipt1, orderLine, qtyDelivered1);
			completeDocument(receipt1);
			postDocument(receipt1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered1.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine1);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine1);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInOut receipt2 = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered2 = new BigDecimal(1);
			MInOutLine receiptLine2 = createMMReceiptLine(receipt2, orderLine, qtyDelivered2);
			completeDocument(receipt2);
			postDocument(receipt2);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered2.doubleValue(), qtyInvoiced.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			reverseDocument(receipt2);
			MInOut receipt3 = new MInOut(Env.getCtx(), receipt2.getReversal_ID(), getTrxName());
			postDocument(receipt3);
			
			ArrayList<MMatchInv> miList0 = new ArrayList<MMatchInv>();
			for (MMatchInv mi : miList) {
				mi.load(getTrxName());
				miList0.add(new MMatchInv(Env.getCtx(), mi.getReversal_ID(), getTrxName()));
			}
			MMatchInv[] miList2 = new MMatchInv[miList0.size()];
			ArrayList<PostingLine> notInvoicedReceiptsLineList2 = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList2 = new ArrayList<PostingLine>();
			for (PostingLine notInvoicedReceiptsLine : notInvoicedReceiptsLineList)
				notInvoicedReceiptsLineList2.add(new PostingLine(notInvoicedReceiptsLine.currency, notInvoicedReceiptsLine.amtAcctCr, notInvoicedReceiptsLine.amtAcctDr));
			for (PostingLine inventoryClearingLine : inventoryClearingLineList)
				inventoryClearingLineList2.add(new PostingLine(inventoryClearingLine.currency, inventoryClearingLine.amtAcctCr, inventoryClearingLine.amtAcctDr));
			testMatchInvoicePosting(ass, miList0.toArray(miList2), notInvoicedReceiptsLineList2, inventoryClearingLineList2);

			MInOut receipt4 = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered4 = new BigDecimal(1);
			MInOutLine receiptLine4 = createMMReceiptLine(receipt4, orderLine, qtyDelivered4);
			completeDocument(receipt4);
			postDocument(receipt4);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine4.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered4.doubleValue(), qtyInvoiced.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine4);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd, matchQty, receiptLine4);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting (different period + reversal)
	 * PO Qty=2, Price=0.1875, Period 1
	 * IV Qty=2, Period 1
	 * MR Qty=1, Period 1
	 * MR Qty=1, Period 1 (Reversed)
	 * MR Qty=1, Period 1 (Reversed)
	 * MR Qty=1, Period 2
	 */
	public void testMatReceiptPosting_4() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30.870771861909);
		MConversionRate cr1 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(31.326259863856);
		MConversionRate cr2 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
		
		int M_PriceList_ID = 103; // Export in EUR
		
		try {
			MOrder order = createPurchaseOrder(bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal priceInEur = new BigDecimal(0.1875);
			BigDecimal qtyOrdered = new BigDecimal(2);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInEur);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, date1);			
			BigDecimal qtyInvoiced = new BigDecimal(2);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt1 = createMMReceipt(order, date1);			
			BigDecimal qtyDelivered1 = new BigDecimal(1);
			MInOutLine receiptLine1 = createMMReceiptLine(receipt1, orderLine, qtyDelivered1);
			completeDocument(receipt1);
			postDocument(receipt1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered1.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine1);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd1, matchQty, receiptLine1);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInOut receipt2 = createMMReceipt(order, date1);			
			BigDecimal qtyDelivered2 = new BigDecimal(1);
			MInOutLine receiptLine2 = createMMReceiptLine(receipt2, orderLine, qtyDelivered2);
			completeDocument(receipt2);
			postDocument(receipt2);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered2.doubleValue(), qtyInvoiced.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd1, matchQty, receiptLine2);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			reverseDocument(receipt2);
			MInOut receipt3 = new MInOut(Env.getCtx(), receipt2.getReversal_ID(), getTrxName());
			postDocument(receipt3);
			
			ArrayList<MMatchInv> miList0 = new ArrayList<MMatchInv>();
			for (MMatchInv mi : miList) {
				mi.load(getTrxName());
				miList0.add(new MMatchInv(Env.getCtx(), mi.getReversal_ID(), getTrxName()));
			}
			MMatchInv[] miList2 = new MMatchInv[miList0.size()];
			ArrayList<PostingLine> notInvoicedReceiptsLineList2 = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList2 = new ArrayList<PostingLine>();
			for (PostingLine notInvoicedReceiptsLine : notInvoicedReceiptsLineList)
				notInvoicedReceiptsLineList2.add(new PostingLine(notInvoicedReceiptsLine.currency, notInvoicedReceiptsLine.amtAcctCr, notInvoicedReceiptsLine.amtAcctDr));
			for (PostingLine inventoryClearingLine : inventoryClearingLineList)
				inventoryClearingLineList2.add(new PostingLine(inventoryClearingLine.currency, inventoryClearingLine.amtAcctCr, inventoryClearingLine.amtAcctDr));
			testMatchInvoicePosting(ass, miList0.toArray(miList2), notInvoicedReceiptsLineList2, inventoryClearingLineList2);

			MInOut receipt4 = createMMReceipt(order, date2);			
			BigDecimal qtyDelivered4 = new BigDecimal(1);
			MInOutLine receiptLine4 = createMMReceiptLine(receipt4, orderLine, qtyDelivered4);
			completeDocument(receipt4);
			postDocument(receipt4);
			
			miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine4.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered4.doubleValue(), qtyInvoiced.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, Env.ONE, matchQty, receiptLine4);
			accountedAmtCr = getAccountedAmount(euro, Env.ONE, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, eurToUsd2, matchQty, receiptLine4);
			accountedAmtCr = getAccountedAmount(usd, eurToUsd1, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			inventoryClearingLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
			rollback();
		}
	}
	
	@Test
	/**
	 * Test the matched invoice posting (same period)
	 * PO Qty=500, Price=23.32
	 * MR Qty=500
	 * IV Qty=250
	 * IV Qty=250
	 */
	public void testMatReceiptPosting_5() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		int C_ConversionType_ID = 201; // Company
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Purchase GBP " + System.currentTimeMillis());
		MCurrency britishPound = MCurrency.get("GBP"); // British Pound (GBP)
		priceList.setC_Currency_ID(britishPound.getC_Currency_ID());
		priceList.setPricePrecision(britishPound.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(101); // Purchase 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		BigDecimal priceInPound = new BigDecimal(23.32);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInPound, priceInPound, Env.ZERO);
		pp.saveEx();
		
		MCurrency usd = MCurrency.get("USD"); // USD
		BigDecimal poundToUsd = new BigDecimal(0.676234);
		MConversionRate crUsd = createConversionRate(britishPound.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, currentDate, poundToUsd);
		
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal poundToEuro = new BigDecimal(22.5062);
		MConversionRate crEur = createConversionRate(britishPound.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, poundToEuro);

		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), C_ConversionType_ID);			
			BigDecimal qtyOrdered = new BigDecimal(500);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInPound);
			completeDocument(order);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(500);
			MInOutLine receiptLine = createMMReceiptLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MInvoice invoice1 = createAPInvoice(order, currentDate);
			BigDecimal qtyInvoiced1 = new BigDecimal(250);
			MInvoiceLine invoiceLine1 = createAPInvoiceLine(invoice1, orderLine, qtyInvoiced1);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced1.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, poundToEuro, matchQty, receiptLine);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, poundToEuro, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, poundToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, poundToUsd, matchQty, invoiceLine1);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			MInvoice invoice2 = createAPInvoice(order, currentDate);
			BigDecimal qtyInvoiced2 = new BigDecimal(250);
			MInvoiceLine invoiceLine2 = createAPInvoiceLine(invoice2, orderLine, qtyInvoiced2);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine2.get_ID(), getTrxName());
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			inventoryClearingLineList = new ArrayList<PostingLine>();
			matchQty = new BigDecimal(Math.min(qtyDelivered.doubleValue(), qtyInvoiced2.doubleValue()));
			
			accountedAmtDr = getAccountedAmount(euro, poundToEuro, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(euro, poundToEuro, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(euro.getStdPrecision(), RoundingMode.HALF_UP);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, Env.ZERO, currBalAmt));
			
			accountedAmtDr = getAccountedAmount(usd, poundToUsd, matchQty, receiptLine);
			accountedAmtCr = getAccountedAmount(usd, poundToUsd, matchQty, invoiceLine2);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, Env.ZERO, currBalAmt));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
		} finally {
			deleteConversionRate(crUsd);
			deleteConversionRate(crEur);
			
			pp.deleteEx(true);
			plv.deleteEx(true);
			priceList.deleteEx(true);
			
			rollback();
		}		
	}
	
	@Test
	/**
	 * Test the matched invoice posting (same period + reversal)
	 * PO Qty=5, Price=65
	 * IV Qty=5
	 * MR Qty=5 (Reversed)
	 * MR Qty=5 (Reversed)
	 */
	public void testMatReceiptPostingWithDiffCurrencyPrecision() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), 124); // Elm Tree
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		int C_ConversionType_ID = 201; // Company
		
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
		
		BigDecimal priceInYen = new BigDecimal(65);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInYen, priceInYen, Env.ZERO);
		pp.saveEx();
		
		MCurrency usd = MCurrency.get("USD"); // USD
		BigDecimal yenToUsd = new BigDecimal(0.00956427);
		MConversionRate crUsd = createConversionRate(japaneseYen.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, currentDate, yenToUsd);
		
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal yenToEuro = new BigDecimal(0.29);
		MConversionRate crEur = createConversionRate(japaneseYen.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, currentDate, yenToEuro);
		
		try {
			MOrder order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), C_ConversionType_ID);
			BigDecimal qtyOrdered = new BigDecimal(5);
			MOrderLine orderLine = createPurchaseOrderLine(order, 10, product, qtyOrdered, priceInYen);
			completeDocument(order);
			
			MInvoice invoice = createAPInvoice(order, currentDate);			
			BigDecimal qtyInvoiced = new BigDecimal(5);
			MInvoiceLine invoiceLine = createAPInvoiceLine(invoice, orderLine, qtyInvoiced);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInOut receipt1 = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered1 = new BigDecimal(5);
			MInOutLine receiptLine1 = createMMReceiptLine(receipt1, orderLine, qtyDelivered1);
			completeDocument(receipt1);
			postDocument(receipt1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine1.get_ID(), getTrxName());
			ArrayList<PostingLine> notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList = new ArrayList<PostingLine>();
			BigDecimal matchQty = new BigDecimal(Math.min(qtyDelivered1.doubleValue(), qtyInvoiced.doubleValue()));
			
			BigDecimal accountedAmtDr = getAccountedAmount(euro, yenToEuro, matchQty, receiptLine1);
			BigDecimal accountedAmtCr = getAccountedAmount(euro, yenToEuro, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(euro, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(euro, Env.ZERO, accountedAmtCr));
			
			accountedAmtDr = getAccountedAmount(usd, yenToUsd, matchQty, receiptLine1);
			accountedAmtCr = getAccountedAmount(usd, yenToUsd, matchQty, invoiceLine);
			notInvoicedReceiptsLineList.add(new PostingLine(usd, accountedAmtDr, Env.ZERO));
			inventoryClearingLineList.add(new PostingLine(usd, Env.ZERO, accountedAmtCr));
			
			testMatchInvoicePosting(ass, miList, notInvoicedReceiptsLineList, inventoryClearingLineList);
			
			reverseDocument(receipt1);
			MInOut receipt2 = new MInOut(Env.getCtx(), receipt1.getReversal_ID(), getTrxName());
			postDocument(receipt2);
			
			ArrayList<MMatchInv> miList0 = new ArrayList<MMatchInv>();
			for (MMatchInv mi : miList) {
				mi.load(getTrxName());
				miList0.add(new MMatchInv(Env.getCtx(), mi.getReversal_ID(), getTrxName()));
			}
			MMatchInv[] miList2 = new MMatchInv[miList0.size()];
			ArrayList<PostingLine> notInvoicedReceiptsLineList2 = new ArrayList<PostingLine>();
			ArrayList<PostingLine> inventoryClearingLineList2 = new ArrayList<PostingLine>();
			for (PostingLine notInvoicedReceiptsLine : notInvoicedReceiptsLineList)
				notInvoicedReceiptsLineList2.add(new PostingLine(notInvoicedReceiptsLine.currency, notInvoicedReceiptsLine.amtAcctCr, notInvoicedReceiptsLine.amtAcctDr));
			for (PostingLine inventoryClearingLine : inventoryClearingLineList)
				inventoryClearingLineList2.add(new PostingLine(inventoryClearingLine.currency, inventoryClearingLine.amtAcctCr, inventoryClearingLine.amtAcctDr));
			testMatchInvoicePosting(ass, miList0.toArray(miList2), notInvoicedReceiptsLineList2, inventoryClearingLineList2);
		} finally {
			deleteConversionRate(crUsd);
			deleteConversionRate(crEur);
			
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
	
	private void completeDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Completed, docStatus, DocAction.STATUS_Completed + " != " + docStatus);
	}
	
	private void reverseDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Reverse_Correct);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Reversed, docStatus, DocAction.STATUS_Reversed + " != " + docStatus);
	}
	
	private void postDocument(PO po) {
		if (!po.get_ValueAsBoolean("Posted")) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), po.getAD_Client_ID(), po.get_Table_ID(), po.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		po.load(getTrxName());
		assertTrue(po.get_ValueAsBoolean("Posted"));
	}
	
	private MInvoice createAPInvoice(MOrder order, Timestamp date) {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setOrder(order);
		invoice.setDateAcct(date);
		invoice.setSalesRep_ID(order.getSalesRep_ID());
		invoice.setC_BPartner_ID(order.getBill_BPartner_ID());
		invoice.setC_BPartner_Location_ID(order.getBill_Location_ID());
		invoice.setAD_User_ID(order.getBill_User_ID());
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		return invoice;
	}
	
	private MInvoiceLine createAPInvoiceLine(MInvoice invoice, MOrderLine orderLine, BigDecimal qty) {
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setC_OrderLine_ID(orderLine.get_ID());
		invoiceLine.setLine(orderLine.getLine());
		invoiceLine.setProduct(orderLine.getProduct());
		invoiceLine.setQty(qty);
		invoiceLine.setPrice(orderLine.getPriceActual());
		invoiceLine.saveEx();
		return invoiceLine;
	}
	
	private MInvoice createAPCreditMemo(MOrder order, Timestamp date) {
		MInvoice creditMemo = new MInvoice(Env.getCtx(), 0, getTrxName());
		creditMemo.setOrder(order);
		creditMemo.setDateAcct(date);
		creditMemo.setSalesRep_ID(order.getSalesRep_ID());
		creditMemo.setC_BPartner_ID(order.getBill_BPartner_ID());
		creditMemo.setC_BPartner_Location_ID(order.getBill_Location_ID());
		creditMemo.setAD_User_ID(order.getBill_User_ID());
		creditMemo.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APCreditMemo);
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		return creditMemo;
	}
	
	private MInvoiceLine createAPCreditMemoLine(MInvoice creditMemo, MOrderLine orderLine, BigDecimal qty) {
		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setC_OrderLine_ID(orderLine.get_ID());
		creditMemoLine.setLine(orderLine.getLine());
		creditMemoLine.setProduct(orderLine.getProduct());
		creditMemoLine.setQty(qty);
		creditMemoLine.setPrice(orderLine.getPriceActual());
		creditMemoLine.saveEx();
		return creditMemoLine;
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
	
	private void testMatchInvoicePosting(MAcctSchema[] ass, MMatchInv[] miList, ArrayList<PostingLine> notInvoicedReceiptsLineList, ArrayList<PostingLine> inventoryClearingLineList) {
		assertTrue(miList.length > 0);
		
		if (notInvoicedReceiptsLineList == null)
			notInvoicedReceiptsLineList = new ArrayList<PostingLine>();
		if (inventoryClearingLineList == null)
			inventoryClearingLineList = new ArrayList<PostingLine>();
		
		HashMap<Integer, BigDecimal> totalNIRAmtByCurrencyId = new HashMap<Integer, BigDecimal>();
		for (PostingLine notInvoicedReceiptsLine : notInvoicedReceiptsLineList) {
			BigDecimal totalAmt = totalNIRAmtByCurrencyId.get(notInvoicedReceiptsLine.currency.get_ID());
			if (totalAmt == null)
				totalAmt = Env.ZERO;
			totalAmt = totalAmt.add(notInvoicedReceiptsLine.amtAcctDr).subtract(notInvoicedReceiptsLine.amtAcctCr);
			totalNIRAmtByCurrencyId.put(notInvoicedReceiptsLine.currency.get_ID(), totalAmt);
		}
		
		HashMap<Integer, BigDecimal> totalInvClrAmtByCurrencyId = new HashMap<Integer, BigDecimal>();
		for (PostingLine inventoryClearingLine : inventoryClearingLineList) {
			BigDecimal totalAmt = totalInvClrAmtByCurrencyId.get(inventoryClearingLine.currency.get_ID());
			if (totalAmt == null)
				totalAmt = Env.ZERO;
			totalAmt = totalAmt.add(inventoryClearingLine.amtAcctDr).subtract(inventoryClearingLine.amtAcctCr);
			totalInvClrAmtByCurrencyId.put(inventoryClearingLine.currency.get_ID(), totalAmt);
		}
		
		for (MMatchInv mi : miList) {
			postDocument(mi);
			
			for (MAcctSchema as : ass) {
				Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
				doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				
				BigDecimal totalNIRAmtAcct = Env.ZERO;
				BigDecimal totalInvClrAmtAcct = Env.ZERO;
				String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MMatchInv.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + mi.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctNIR.getAccount_ID() == fa.getAccount_ID())
						totalNIRAmtAcct = totalNIRAmtAcct.add(fa.getAmtAcctDr()).subtract(fa.getAmtAcctCr());
					else if (acctInvClr.getAccount_ID() == fa.getAccount_ID())
						totalInvClrAmtAcct = totalInvClrAmtAcct.add(fa.getAmtAcctDr()).subtract(fa.getAmtAcctCr());
				}
				
				BigDecimal totalAmtExpected = totalNIRAmtByCurrencyId.get(as.getC_Currency_ID());
				if (totalAmtExpected != null && totalAmtExpected.compareTo(totalNIRAmtAcct) == 0)
					totalNIRAmtByCurrencyId.remove(as.getC_Currency_ID());
				totalAmtExpected = totalInvClrAmtByCurrencyId.get(as.getC_Currency_ID());
				if (totalAmtExpected != null && totalAmtExpected.compareTo(totalInvClrAmtAcct) == 0)
					totalInvClrAmtByCurrencyId.remove(as.getC_Currency_ID());
			}
		}
		
		assertTrue(totalNIRAmtByCurrencyId.isEmpty(), totalNIRAmtByCurrencyId.toString());
		assertTrue(totalInvClrAmtByCurrencyId.isEmpty(), totalInvClrAmtByCurrencyId.toString());
	}
	
	private BigDecimal getSourceAmount(I_C_Currency currency, BigDecimal price, BigDecimal qty) {
		return price.multiply(qty).setScale(currency.getStdPrecision(), RoundingMode.HALF_UP);
	}
		
	private BigDecimal getAccountedAmount(MCurrency currency, BigDecimal multiplyRate, BigDecimal miQty, MInOutLine iol) {
		BigDecimal sourceAmt = getSourceAmount(iol.getParent().getC_Order().getC_Currency(), iol.getC_OrderLine().getPriceActual(), iol.getMovementQty());
		BigDecimal accountedAmt = sourceAmt.multiply(multiplyRate).setScale(currency.getStdPrecision(), RoundingMode.HALF_UP);
		BigDecimal multiplier = miQty.divide(iol.getMovementQty(), 12, RoundingMode.HALF_UP);
		return accountedAmt.multiply(multiplier).setScale(currency.getStdPrecision(), RoundingMode.HALF_UP);
	}
	
	private BigDecimal getAccountedAmount(MCurrency currency, BigDecimal multiplyRate, BigDecimal miQty, MInvoiceLine il) {
		BigDecimal sourceAmt = getSourceAmount(il.getParent().getC_Order().getC_Currency(), il.getC_OrderLine().getPriceActual(), il.getQtyInvoiced());
		BigDecimal accountedAmt = sourceAmt.multiply(multiplyRate).setScale(currency.getStdPrecision(), RoundingMode.HALF_UP);
		BigDecimal multiplier = miQty.divide(il.getQtyInvoiced(), 12, RoundingMode.HALF_UP);
		return accountedAmt.multiply(multiplier).setScale(currency.getStdPrecision(), RoundingMode.HALF_UP);
	}
	
	private class PostingLine {
		private MCurrency currency;
		private BigDecimal amtAcctDr;
		private BigDecimal amtAcctCr;
		
		private PostingLine(MCurrency currency, BigDecimal amtAcctDr, BigDecimal amtAcctCr) {
			this.currency = currency;
			this.amtAcctDr = amtAcctDr;
			this.amtAcctCr = amtAcctCr;
		}
		
		public String toString() {
			return currency.toString() + ", " + amtAcctDr + ", " + amtAcctCr + "\n";
		}
	}
}