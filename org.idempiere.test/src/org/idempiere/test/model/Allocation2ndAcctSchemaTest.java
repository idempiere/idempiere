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
package org.idempiere.test.model;

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
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAllocationLine;
import org.compiere.model.MBPartner;
import org.compiere.model.MBankAccount;
import org.compiere.model.MCharge;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPayment;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.ConversionRateHelper;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.ResourceLock;

/**
 * @author Elaine Tan - etantg
 */
public class Allocation2ndAcctSchemaTest extends AbstractTestCase {
	
	public Allocation2ndAcctSchemaTest() {
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period)
	 * Invoice Total=12,587.48, Period 1
	 * Payment Total=18,549.52, Period 2
	 * Allocation Total=12,5587.48, Period 2
	 * Invoice Total=40,125.00, Period 3
	 * Allocation Total=5,962.04, Period 3
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-5053
	 */
	public void testAllocateInvoicePaymentPosting_1() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id); // C&W Construction
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date2 = new Timestamp(cal.getTimeInMillis());
		Timestamp date3 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(32.458922422202);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(33.93972535567);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
		
		BigDecimal eurToUsd3 = new BigDecimal(33.27812049435);
		MConversionRate cr3 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date3, eurToUsd3, false);
		
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice1 = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(12587.48);
			createInvoiceLine(invoice1, 10, null, charge, qty, price);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(18549.52);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date2, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MAllocationHdr alloc1 = createAllocationHdr(date2, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(12587.48);
			createAllocationLine(alloc1, allocAmount, invoice1, payment);
			completeDocument(alloc1);
			postDocument(alloc1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice1.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList);
			
			MInvoice invoice2 = createInvoice(true, bpartner, date3, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(40125);
			createInvoiceLine(invoice2, 10, null, charge, qty, price);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			MAllocationHdr alloc2 = createAllocationHdr(date3, euro.getC_Currency_ID());
			allocAmount = new BigDecimal(5962.04);
			createAllocationLine(alloc2, allocAmount, invoice2, payment);
			completeDocument(alloc2);
			postDocument(alloc2);
			
			allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice2.getC_Invoice_ID(), getTrxName());
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> currBalList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr3.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			paymentLineList.add(new PostingLine(usd, Env.ZERO, currBalAmt));
			currBalList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, currBalList);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
			deleteConversionRate(cr3);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period)
	 * Invoice Total=12,587.48
	 * Payment Total=18,549.52
	 * Allocation Total=12,5587.48
	 * Invoice Total=40,125.00
	 * Allocation Total=5,962.04
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-5053
	 */
	public void testAllocateInvoicePaymentPosting_2() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(32.458922422202);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd, false);
		
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice1 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(12587.48);
			createInvoiceLine(invoice1, 10, null, charge, qty, price);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(18549.52);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MAllocationHdr alloc1 = createAllocationHdr(date, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(12587.48);
			createAllocationLine(alloc1, allocAmount, invoice1, payment);
			completeDocument(alloc1);
			postDocument(alloc1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice1.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList);
			
			MInvoice invoice2 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(40125);
			createInvoiceLine(invoice2, 10, null, charge, qty, price);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			MAllocationHdr alloc2 = createAllocationHdr(date, euro.getC_Currency_ID());
			allocAmount = new BigDecimal(5962.04);
			createAllocationLine(alloc2, allocAmount, invoice2, payment);
			completeDocument(alloc2);
			postDocument(alloc2);
			
			allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice2.getC_Invoice_ID(), getTrxName());
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, null);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period)
	 * Payment Total=12,000, Period 1
	 * Invoice Total=10,700, Period 2
	 * Allocation Total=10,700, Period 2
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4200
	 */
	public void testAllocateInvoicePaymentPosting_3() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30.212666962751);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(29.905289946739);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
				
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(12000);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date1, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MInvoice invoice = createInvoice(true, bpartner, date2, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(10700);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			MAllocationHdr alloc = createAllocationHdr(date2, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(10700);
			createAllocationLine(alloc, allocAmount, invoice, payment);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(3.64).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period)
	 * Payment Total=12,000
	 * Invoice Total=10,700
	 * Allocation Total=10,700
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4200
	 */
	public void testAllocateInvoicePaymentPosting_4() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.AGRI_TECH.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.212666962751);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd, false);
				
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(12000);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MInvoice invoice = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(10700);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			MAllocationHdr alloc = createAllocationHdr(date, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(10700);
			createAllocationLine(alloc, allocAmount, invoice, payment);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, null);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period)
	 * Invoice1 Total=9,362.50, Period 1
	 * Invoice2 Total=9,362.50, Period 1
	 * Invoice3 Total=2,587.26, Period 1
	 * Invoice4 Total=14,519.90, Period 1
	 * Invoice5 Total=14,329.44, Period 1
	 * Credit Memo1 Total=936.25, Period 1
	 * Credit Memo2 Total=936.25, Period 1
	 * Payment Total= 48,289.10, Period 2
	 * Allocation Total=48,289.10, Period 2
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4200
	 */
	public void testAllocateInvoicePaymentPosting_5() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(29.905289946739);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(31.526248754713);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
				
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice1 = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(9362.50);
			createInvoiceLine(invoice1, 10, null, charge, qty, price);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MInvoice invoice2 = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(9362.50);
			createInvoiceLine(invoice2, 10, null, charge, qty, price);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			MInvoice invoice3 = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(2587.26);
			createInvoiceLine(invoice3, 10, null, charge, qty, price);
			completeDocument(invoice3);
			postDocument(invoice3);
			
			MInvoice invoice4 = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(14519.90);
			createInvoiceLine(invoice4, 10, null, charge, qty, price);
			completeDocument(invoice4);
			postDocument(invoice4);
			
			MInvoice invoice5 = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(14329.44);
			createInvoiceLine(invoice5, 10, null, charge, qty, price);
			completeDocument(invoice5);
			postDocument(invoice5);
			
			MInvoice creditMemo1 = createCreditMemo(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(936.25);
			createInvoiceLine(creditMemo1, 10, null, charge, qty, price);
			completeDocument(creditMemo1);
			postDocument(creditMemo1);
			
			MInvoice creditMemo2 = createCreditMemo(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(936.25);
			createInvoiceLine(creditMemo2, 10, null, charge, qty, price);
			completeDocument(creditMemo2);
			postDocument(creditMemo2);
			
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(48289.10);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date2, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MAllocationHdr alloc = createAllocationHdr(date2, euro.getC_Currency_ID());
			createAllocationLine(alloc, invoice1.getGrandTotal(), invoice1, payment);
			createAllocationLine(alloc, invoice2.getGrandTotal(), invoice2, payment);
			createAllocationLine(alloc, invoice3.getGrandTotal(), invoice3, payment);
			createAllocationLine(alloc, invoice4.getGrandTotal(), invoice4, payment);
			createAllocationLine(alloc, invoice5.getGrandTotal(), invoice5, payment);
			createAllocationLine(alloc, creditMemo1.getGrandTotal().negate(), creditMemo1, payment);
			createAllocationLine(alloc, creditMemo2.getGrandTotal().negate(), creditMemo2, payment);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> currBalLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, invoice1.getGrandTotal(), cr2.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, invoice1.getGrandTotal(), cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice2.getGrandTotal(), cr2.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice2.getGrandTotal(), cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice3.getGrandTotal(), cr2.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice3.getGrandTotal(), cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice4.getGrandTotal(), cr2.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice4.getGrandTotal(), cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice5.getGrandTotal(), cr2.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice5.getGrandTotal(), cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedCrAmt = getAccountedAmount(usd, creditMemo1.getGrandTotal(), cr2.getMultiplyRate());
			accountedDrAmt = getAccountedAmount(usd, creditMemo1.getGrandTotal(), cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			accountedCrAmt = getAccountedAmount(usd, creditMemo2.getGrandTotal(), cr2.getMultiplyRate());
			accountedDrAmt = getAccountedAmount(usd, creditMemo2.getGrandTotal(), cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			paymentLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			currBalLineList.add(new PostingLine(usd, Env.ZERO, currBalAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, currBalLineList);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period)
	 * Invoice1 Total=9,362.50
	 * Invoice2 Total=9,362.50
	 * Invoice3 Total=2,587.26
	 * Invoice4 Total=14,519.90
	 * Invoice5 Total=14,329.44
	 * Credit Memo1 Total=936.25
	 * Credit Memo2 Total=936.25
	 * Payment Total= 48,289.10
	 * Allocation Total=48,289.10
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4200
	 */
	public void testAllocateInvoicePaymentPosting_6() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id); // C&W Construction
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(29.905289946739);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd, false);
						
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice1 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(9362.50);
			createInvoiceLine(invoice1, 10, null, charge, qty, price);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MInvoice invoice2 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(9362.50);
			createInvoiceLine(invoice2, 10, null, charge, qty, price);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			MInvoice invoice3 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(2587.26);
			createInvoiceLine(invoice3, 10, null, charge, qty, price);
			completeDocument(invoice3);
			postDocument(invoice3);
			
			MInvoice invoice4 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(14519.90);
			createInvoiceLine(invoice4, 10, null, charge, qty, price);
			completeDocument(invoice4);
			postDocument(invoice4);
			
			MInvoice invoice5 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(14329.44);
			createInvoiceLine(invoice5, 10, null, charge, qty, price);
			completeDocument(invoice5);
			postDocument(invoice5);
			
			MInvoice creditMemo1 = createCreditMemo(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(936.25);
			createInvoiceLine(creditMemo1, 10, null, charge, qty, price);
			completeDocument(creditMemo1);
			postDocument(creditMemo1);
			
			MInvoice creditMemo2 = createCreditMemo(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(936.25);
			createInvoiceLine(creditMemo2, 10, null, charge, qty, price);
			completeDocument(creditMemo2);
			postDocument(creditMemo2);
			
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(48289.10);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MAllocationHdr alloc = createAllocationHdr(date, euro.getC_Currency_ID());
			createAllocationLine(alloc, invoice1.getGrandTotal(), invoice1, payment);
			createAllocationLine(alloc, invoice2.getGrandTotal(), invoice2, payment);
			createAllocationLine(alloc, invoice3.getGrandTotal(), invoice3, payment);
			createAllocationLine(alloc, invoice4.getGrandTotal(), invoice4, payment);
			createAllocationLine(alloc, invoice5.getGrandTotal(), invoice5, payment);
			createAllocationLine(alloc, creditMemo1.getGrandTotal().negate(), creditMemo1, payment);
			createAllocationLine(alloc, creditMemo2.getGrandTotal().negate(), creditMemo2, payment);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, invoice1.getGrandTotal(), cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, invoice1.getGrandTotal(), cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice2.getGrandTotal(), cr.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice2.getGrandTotal(), cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice3.getGrandTotal(), cr.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice3.getGrandTotal(), cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice4.getGrandTotal(), cr.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice4.getGrandTotal(), cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedDrAmt = getAccountedAmount(usd, invoice5.getGrandTotal(), cr.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, invoice5.getGrandTotal(), cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			accountedCrAmt = getAccountedAmount(usd, creditMemo1.getGrandTotal(), cr.getMultiplyRate());
			accountedDrAmt = getAccountedAmount(usd, creditMemo1.getGrandTotal(), cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			accountedCrAmt = getAccountedAmount(usd, creditMemo2.getGrandTotal(), cr.getMultiplyRate());
			accountedDrAmt = getAccountedAmount(usd, creditMemo2.getGrandTotal(), cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, null);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period)
	 * Payment Total=12,000, Period 1
	 * Invoice1 Total=10,700, Period 2
	 * Allocation1 Total=10,700, Period 2
	 * Invoice2 Total=1,300, Period 2
	 * Allocation2 Total=1,300, Period 2
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4127
	 */
	public void testAllocateInvoicePaymentPosting_7() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id, getTrxName()); 
		DB.getDatabase().forUpdate(bpartner, 0);
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30.212666962751);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(29.905289946739);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
				
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(12000);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date1, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MInvoice invoice1 = createInvoice(true, bpartner, date2, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(10700);
			createInvoiceLine(invoice1, 10, null, charge, qty, price);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MAllocationHdr alloc1 = createAllocationHdr(date2, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(10700);
			createAllocationLine(alloc1, allocAmount, invoice1, payment);
			completeDocument(alloc1);
			postDocument(alloc1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice1.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(3.64).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			MInvoice invoice2 = createInvoice(true, bpartner, date2, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(1300);
			createInvoiceLine(invoice2, 10, null, charge, qty, price);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			MAllocationHdr alloc2 = createAllocationHdr(date2, euro.getC_Currency_ID());
			allocAmount = new BigDecimal(1300);
			createAllocationLine(alloc2, allocAmount, invoice2, payment);
			completeDocument(alloc2);
			postDocument(alloc2);
			
			allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice2.getC_Invoice_ID(), getTrxName());
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> currBalLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			paymentLineList.add(new PostingLine(usd, Env.ZERO, currBalAmt));
			currBalLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, currBalLineList);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period)
	 * Payment Total=12,000
	 * Invoice1 Total=10,700
	 * Allocation1 Total=10,700
	 * Invoice2 Total=1,300
	 * Allocation2 Total=1,300
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4127
	 */
	public void testAllocateInvoicePaymentPosting_8() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id, getTrxName()); // C&W Construction
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.212666962751);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd, false);
						
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(12000);
			DB.getDatabase().forUpdate(bpartner, 0);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MInvoice invoice1 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(10700);
			createInvoiceLine(invoice1, 10, null, charge, qty, price);
			completeDocument(invoice1);
			postDocument(invoice1);
			
			MAllocationHdr alloc1 = createAllocationHdr(date, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(10700);
			createAllocationLine(alloc1, allocAmount, invoice1, payment);
			completeDocument(alloc1);
			postDocument(alloc1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice1.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, null);
			
			MInvoice invoice2 = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(1300);
			createInvoiceLine(invoice2, 10, null, charge, qty, price);
			completeDocument(invoice2);
			postDocument(invoice2);
			
			MAllocationHdr alloc2 = createAllocationHdr(date, euro.getC_Currency_ID());
			allocAmount = new BigDecimal(1300);
			createAllocationLine(alloc2, allocAmount, invoice2, payment);
			completeDocument(alloc2);
			postDocument(alloc2);
			
			allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice2.getC_Invoice_ID(), getTrxName());
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> currBalLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			paymentLineList.add(new PostingLine(usd, Env.ZERO, currBalAmt));
			currBalLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, currBalLineList);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period)
	 * Invoice Total=12,000, Period 1
	 * Payment1 Total=10,700, Period 2
	 * Allocation1 Total=10,700, Period 2
	 * Payment2 Total=1,300, Period 2
	 * Allocation2 Total=1,300, Period 2
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4127
	 */
	public void testAllocateInvoicePaymentPosting_9() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.AGRI_TECH.id, getTrxName());
		DB.getDatabase().forUpdate(bpartner, 0);
		
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30.212666962751);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(29.905289946739);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
				
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			MInvoice invoice = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(12000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			BigDecimal payAmt = new BigDecimal(10700);
			MPayment payment1 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date2, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment1);
			postDocument(payment1);
			
			MAllocationHdr alloc1 = createAllocationHdr(date2, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(10700);
			createAllocationLine(alloc1, allocAmount, invoice, payment1);
			completeDocument(alloc1);
			postDocument(alloc1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment1.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(3.64).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, Env.ZERO, gainLossAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			payAmt = new BigDecimal(1300);
			MPayment payment2 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date2, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment2);
			postDocument(payment2);
			
			MAllocationHdr alloc2 = createAllocationHdr(date2, euro.getC_Currency_ID());
			allocAmount = new BigDecimal(1300);
			createAllocationLine(alloc2, allocAmount, invoice, payment2);
			completeDocument(alloc2);
			postDocument(alloc2);
			
			allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment2.getC_Payment_ID(), getTrxName());
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> currBalLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			tradeLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			currBalLineList.add(new PostingLine(usd, Env.ZERO, currBalAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, currBalLineList);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period)
	 * Invoice Total=12,000
	 * Payment1 Total=10,700
	 * Allocation1 Total=10,700
	 * Payment2 Total=1,300
	 * Allocation2 Total=1,300
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4127
	 */
	public void testAllocateInvoicePaymentPosting_10() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(30.212666962751);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd, false);
		
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			MInvoice invoice = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(12000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			BigDecimal payAmt = new BigDecimal(10700);
			MPayment payment1 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment1);
			postDocument(payment1);
			
			MAllocationHdr alloc1 = createAllocationHdr(date, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(10700);
			createAllocationLine(alloc1, allocAmount, invoice, payment1);
			completeDocument(alloc1);
			postDocument(alloc1);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment1.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, null);
			
			payAmt = new BigDecimal(1300);
			MPayment payment2 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment2);
			postDocument(payment2);
			
			MAllocationHdr alloc2 = createAllocationHdr(date, euro.getC_Currency_ID());
			allocAmount = new BigDecimal(1300);
			createAllocationLine(alloc2, allocAmount, invoice, payment2);
			completeDocument(alloc2);
			postDocument(alloc2);
			
			allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment2.getC_Payment_ID(), getTrxName());
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> currBalLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal currBalAmt = new BigDecimal(0.01).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			tradeLineList.add(new PostingLine(usd, currBalAmt, Env.ZERO));
			currBalLineList.add(new PostingLine(usd, Env.ZERO, currBalAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, currBalLineList);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period + reversal)
	 * Invoice Total=1000, Period 1
	 * Payment1 Total=1000, Period 2
	 * Payment2 Total=1000, Period 3 (Reversal)
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-5339
	 */
	public void testAllocateInvoicePaymentPosting_11() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id); // C&W Construction
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date2 = new Timestamp(cal.getTimeInMillis());
		
		Timestamp date3 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.SPOT.id; // Spot
		
		MCurrency aud = MCurrency.get(DictionaryIDs.C_Currency.AUD.id); // AUD
		MCurrency eur = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		BigDecimal audToEur = new BigDecimal(0.7);
		MConversionRate cr1a = createConversionRate(aud.getC_Currency_ID(), eur.getC_Currency_ID(), C_ConversionType_ID, date1, audToEur, true);
		BigDecimal audToUsd = new BigDecimal(0.8);
		MConversionRate cr1b = createConversionRate(aud.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, audToUsd, true);
		
		audToEur = new BigDecimal(0.8);
		MConversionRate cr2a = createConversionRate(aud.getC_Currency_ID(), eur.getC_Currency_ID(), C_ConversionType_ID, date2, audToEur, true);
		audToUsd = new BigDecimal(0.9);
		MConversionRate cr2b = createConversionRate(aud.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, audToUsd, true);
		
		audToEur = new BigDecimal(0.8);
		MConversionRate cr3a = createConversionRate(aud.getC_Currency_ID(), eur.getC_Currency_ID(), C_ConversionType_ID, date3, audToEur, true);
		audToUsd = new BigDecimal(0.9);
		MConversionRate cr3b = createConversionRate(aud.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date3, audToUsd, true);
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Export AUD " + System.currentTimeMillis());
		MCurrency australianDollar = MCurrency.get(DictionaryIDs.C_Currency.AUD.id); // Australian Dollar (AUD)
		priceList.setC_Currency_ID(australianDollar.getC_Currency_ID());
		priceList.setPricePrecision(australianDollar.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.SALES_2001.id); // Sales 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			MInvoice invoice = createInvoice(true, bpartner, date1, priceList.getM_PriceList_ID(), C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(1000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date2, payAmt, aud.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MAllocationHdr alloc = createAllocationHdr(date2, aud.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(1000);
			createAllocationLine(alloc, allocAmount, invoice, payment);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr2b.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr2b.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(100).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, Env.ZERO, gainLossAmt));
			tradeLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			gainLossLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(eur, allocAmount, cr2a.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(eur, allocAmount, cr2a.getMultiplyRate());
			paymentLineList.add(new PostingLine(eur, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(eur, Env.ZERO, accountedCrAmt));
			gainLossAmt = new BigDecimal(100).setScale(eur.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(eur, Env.ZERO, gainLossAmt));
			tradeLineList.add(new PostingLine(eur, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			reverseDocument(payment, false);
			MPayment reversalPayment = new MPayment(Env.getCtx(), payment.getReversal_ID(), getTrxName());
			postDocument(reversalPayment);
			
			MAllocationHdr reversalAlloc = null;
			allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			for (MAllocationHdr allocation : allocList) {
				if (allocation.getReversal_ID() > 0 && allocation.getReversal_ID() < allocation.get_ID()) {
					reversalAlloc = allocation;
					break;
				}
			}
			
			if (reversalAlloc == null)
				reversalAlloc = new MAllocationHdr(Env.getCtx(), alloc.getReversal_ID(), getTrxName());
		
			allocList = new MAllocationHdr[] { reversalAlloc };
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			gainLossLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr3b.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr3b.getMultiplyRate());
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			gainLossAmt = new BigDecimal(100).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, gainLossAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			gainLossLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(eur, allocAmount, cr3a.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(eur, allocAmount, cr3a.getMultiplyRate());
			tradeLineList.add(new PostingLine(eur, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(eur, Env.ZERO, accountedCrAmt));
			gainLossAmt = new BigDecimal(100).setScale(eur.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(eur, gainLossAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(eur, Env.ZERO, gainLossAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
		} finally {
			rollback();
			
			deleteConversionRate(cr1a);
			deleteConversionRate(cr1b);
			deleteConversionRate(cr2a);
			deleteConversionRate(cr2b);
			deleteConversionRate(cr3a);
			deleteConversionRate(cr3b);
			
			plv.deleteEx(true);
			priceList.deleteEx(true);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period + reversal)
	 * Payment Total=1000, Period 1
	 * Invoice Total=1000, Period 2
	 * Invoice Total=1000, Period 3 (Reversal)
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-5339
	 */
	public void testAllocateInvoicePaymentPosting_12() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date2 = new Timestamp(cal.getTimeInMillis());
		
		Timestamp date3 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.SPOT.id; // Spot
		
		MCurrency aud = MCurrency.get(DictionaryIDs.C_Currency.AUD.id); // AUD
		MCurrency eur = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		BigDecimal audToEur = new BigDecimal(0.7);
		MConversionRate cr1a = createConversionRate(aud.getC_Currency_ID(), eur.getC_Currency_ID(), C_ConversionType_ID, date1, audToEur, true);
		BigDecimal audToUsd = new BigDecimal(0.8);
		MConversionRate cr1b = createConversionRate(aud.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, audToUsd, true);
		
		audToEur = new BigDecimal(0.8);
		MConversionRate cr2a = createConversionRate(aud.getC_Currency_ID(), eur.getC_Currency_ID(), C_ConversionType_ID, date2, audToEur, true);
		audToUsd = new BigDecimal(0.9);
		MConversionRate cr2b = createConversionRate(aud.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, audToUsd, true);
		
		audToEur = new BigDecimal(0.8);
		MConversionRate cr3a = createConversionRate(aud.getC_Currency_ID(), eur.getC_Currency_ID(), C_ConversionType_ID, date3, audToEur, true);
		audToUsd = new BigDecimal(0.9);
		MConversionRate cr3b = createConversionRate(aud.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date3, audToUsd, true);
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, null);
		priceList.setName("Export AUD " + System.currentTimeMillis());
		MCurrency australianDollar = MCurrency.get(DictionaryIDs.C_Currency.AUD.id); // Australian Dollar (AUD)
		priceList.setC_Currency_ID(australianDollar.getC_Currency_ID());
		priceList.setPricePrecision(australianDollar.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.SALES_2001.id); // Sales 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date1, payAmt, aud.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			MInvoice invoice = createInvoice(true, bpartner, date2, priceList.getM_PriceList_ID(), C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(1000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			MAllocationHdr alloc = createAllocationHdr(date2, aud.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(1000);
			createAllocationLine(alloc, allocAmount, invoice, payment);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr1b.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr1b.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(100).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, gainLossAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			gainLossLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(eur, allocAmount, cr1a.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(eur, allocAmount, cr1a.getMultiplyRate());
			paymentLineList.add(new PostingLine(eur, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(eur, Env.ZERO, accountedCrAmt));
			gainLossAmt = new BigDecimal(100).setScale(eur.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(eur, gainLossAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(eur, Env.ZERO, gainLossAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			reverseDocument(invoice, false);
			MInvoice reversalInvoice = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), getTrxName());
			postDocument(reversalInvoice);
			
			MAllocationHdr reversalAlloc = null;
			allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			for (MAllocationHdr allocation : allocList) {
				if (allocation.getReversal_ID() > 0 && allocation.getReversal_ID() < allocation.get_ID()) {
					reversalAlloc = allocation;
					break;
				}
			}
			
			if (reversalAlloc == null)
				reversalAlloc = new MAllocationHdr(Env.getCtx(), alloc.getReversal_ID(), getTrxName());
		
			allocList = new MAllocationHdr[] { reversalAlloc };
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			gainLossLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(usd, allocAmount, cr1b.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(usd, allocAmount, cr1b.getMultiplyRate());
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			gainLossAmt = new BigDecimal(100).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, Env.ZERO, gainLossAmt));
			tradeLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
			
			paymentLineList = new ArrayList<PostingLine>();
			tradeLineList = new ArrayList<PostingLine>();
			gainLossLineList = new ArrayList<PostingLine>();
			accountedDrAmt = getAccountedAmount(eur, allocAmount, cr1a.getMultiplyRate());
			accountedCrAmt = getAccountedAmount(eur, allocAmount, cr1a.getMultiplyRate());
			tradeLineList.add(new PostingLine(eur, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(eur, Env.ZERO, accountedCrAmt));
			gainLossAmt = new BigDecimal(100).setScale(eur.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(eur, Env.ZERO, gainLossAmt));
			tradeLineList.add(new PostingLine(eur, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, gainLossLineList, null);
		} finally {
			rollback();

			deleteConversionRate(cr1a);
			deleteConversionRate(cr1b);
			deleteConversionRate(cr2a);
			deleteConversionRate(cr2b);
			deleteConversionRate(cr3a);
			deleteConversionRate(cr3b);
			
			plv.deleteEx(true);
			priceList.deleteEx(true);			
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period + reversal)
	 * Invoice Total=1000, Period 1
	 * Invoice Total=1000, Period 2 (Reversed)
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocateInvoicePosting_1() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1);
		
		BigDecimal eurToUsd2 = new BigDecimal(31);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2);
		
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(1000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			reverseDocument(invoice, false);
			MInvoice reversalInvoice = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), getTrxName());
			postDocument(reversalInvoice);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			
			BigDecimal allocAmount = new BigDecimal(1000);
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(1000).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, Env.ZERO, gainLossAmt));
			
			testAllocationPosting(ass, allocList, null, tradeLineList, gainLossLineList, null);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period + reversal)
	 * Invoice Total=1000
	 * Invoice Total=1000 (Reversed)
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocateInvoicePosting_2() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(30);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd);
		
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(1000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			reverseDocument(invoice);
			MInvoice reversalInvoice = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), getTrxName());
			postDocument(reversalInvoice);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			
			BigDecimal allocAmount = new BigDecimal(1000);
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, null, tradeLineList, null, null);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period + offset)
	 * Invoice Total=1000, Period 1
	 * Credit Memo Total=1000, Period 2
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocateInvoicePosting_3() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1);
		
		BigDecimal eurToUsd2 = new BigDecimal(31);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2);
		
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice = createInvoice(true, bpartner, date1, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(1000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInvoice creditMemo = createInvoice(true, true, bpartner, date2, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(1000);
			createInvoiceLine(creditMemo, 10, null, charge, qty, price);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			MAllocationHdr alloc = createAllocationHdr(date2, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(1000);
			createAllocationLine(alloc, allocAmount, invoice, null);
			createAllocationLine(alloc, allocAmount.negate(), creditMemo, null);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(1000).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, Env.ZERO, gainLossAmt));
			
			testAllocationPosting(ass, allocList, null, tradeLineList, gainLossLineList, null);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period + offset)
	 * Invoice Total=1000
	 * Credit Memo Total=1000
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocateInvoicePosting_4() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id); 
		MCharge charge = MCharge.get(Env.getCtx(), DictionaryIDs.C_Charge.FREIGHT.id); // Freight Charges
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(30);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd);
	
		int M_PriceList_ID = DictionaryIDs.M_PriceList.EXPORT.id; // Export in EUR
		
		try {
			MInvoice invoice = createInvoice(true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			BigDecimal qty = BigDecimal.ONE;
			BigDecimal price = new BigDecimal(1000);
			createInvoiceLine(invoice, 10, null, charge, qty, price);
			completeDocument(invoice);
			postDocument(invoice);
			
			MInvoice creditMemo = createInvoice(true, true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
			qty = BigDecimal.ONE;
			price = new BigDecimal(1000);
			createInvoiceLine(creditMemo, 10, null, charge, qty, price);
			completeDocument(creditMemo);
			postDocument(creditMemo);
			
			MAllocationHdr alloc = createAllocationHdr(date, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(1000);
			createAllocationLine(alloc, allocAmount, invoice, null);
			createAllocationLine(alloc, allocAmount.negate(), creditMemo, null);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			
			ArrayList<PostingLine> tradeLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			tradeLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			tradeLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, null, tradeLineList, null, null);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period + reversal)
	 * Payment Total=1000, Period 1
	 * Payment Total=1000, Period 2 (Reversed)
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocatePaymentPosting_1() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.AGRI_TECH.id); 
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1);
		
		BigDecimal eurToUsd2 = new BigDecimal(31);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2);
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date1, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			reverseDocument(payment, false);
			MPayment reversalPayment = new MPayment(Env.getCtx(), payment.getReversal_ID(), getTrxName());
			postDocument(reversalPayment);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			
			BigDecimal allocAmount = payAmt;
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(1000).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, null, gainLossLineList, null);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period + reversal)
	 * Payment Total=1000, Period 1
	 * Payment Total=1000, Period 2 (Reversed)
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocatePaymentPosting_2() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(30);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd);
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment);
			postDocument(payment);
			
			reverseDocument(payment, false);
			MPayment reversalPayment = new MPayment(Env.getCtx(), payment.getReversal_ID(), getTrxName());
			postDocument(reversalPayment);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			
			BigDecimal allocAmount = payAmt;
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, null, null, null);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (different period + offset)
	 * Payment Total=1000, Period 1
	 * Payment Total=-1000, Period 2
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocatePaymentPosting_3() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id);
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30);
		MConversionRate cr1 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1);
		
		BigDecimal eurToUsd2 = new BigDecimal(31);
		MConversionRate cr2 = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2);
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment1 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date1, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment1);
			postDocument(payment1);
			
			MPayment payment2 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date2, payAmt.negate(), euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment2);
			postDocument(payment2);
			
			MAllocationHdr alloc = createAllocationHdr(date2, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(1000);
			createAllocationLine(alloc, allocAmount, null, payment1);
			createAllocationLine(alloc, allocAmount.negate(), null, payment2);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment1.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			ArrayList<PostingLine> gainLossLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr1.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr2.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			BigDecimal gainLossAmt = new BigDecimal(1000).setScale(usd.getStdPrecision(), RoundingMode.HALF_UP);
			gainLossLineList.add(new PostingLine(usd, gainLossAmt, Env.ZERO));
			
			testAllocationPosting(ass, allocList, paymentLineList, null, gainLossLineList, null);
		} finally {
			rollback();
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
		}
	}
	
	@Test
	@ResourceLock(value = MConversionRate.Table_Name)
	/**
	 * Test the allocation posting (same period + offset)
	 * Payment Total=1000
	 * Payment Total=-1000
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testAllocatePaymentPosting_4() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Timestamp date = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal eurToUsd = new BigDecimal(30);
		MConversionRate cr = createConversionRate(euro.getC_Currency_ID(), usd.getC_Currency_ID(), C_ConversionType_ID, date, eurToUsd);
		
		try {
			MBankAccount ba = getBankAccount(usd.getC_Currency_ID());
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment1 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt, euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment1);
			postDocument(payment1);
			
			MPayment payment2 = createPayment(true, bpartner, ba.getC_BankAccount_ID(), date, payAmt.negate(), euro.getC_Currency_ID(), C_ConversionType_ID);
			completeDocument(payment2);
			postDocument(payment2);
			
			MAllocationHdr alloc = createAllocationHdr(date, euro.getC_Currency_ID());
			BigDecimal allocAmount = new BigDecimal(1000);
			createAllocationLine(alloc, allocAmount, null, payment1);
			createAllocationLine(alloc, allocAmount.negate(), null, payment2);
			completeDocument(alloc);
			postDocument(alloc);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			MAllocationHdr[] allocList = MAllocationHdr.getOfPayment(Env.getCtx(), payment1.getC_Payment_ID(), getTrxName());
			
			ArrayList<PostingLine> paymentLineList = new ArrayList<PostingLine>();
			BigDecimal accountedDrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			BigDecimal accountedCrAmt = getAccountedAmount(usd, allocAmount, cr.getMultiplyRate());
			paymentLineList.add(new PostingLine(usd, accountedDrAmt, Env.ZERO));
			paymentLineList.add(new PostingLine(usd, Env.ZERO, accountedCrAmt));
			
			testAllocationPosting(ass, allocList, paymentLineList, null, null, null);
		} finally {
			rollback();
			deleteConversionRate(cr);
		}
	}
		
	private MConversionRate createConversionRate(int C_Currency_ID, int C_Currency_ID_To, int C_ConversionType_ID, 
			Timestamp date, BigDecimal rate) {
		return createConversionRate(C_Currency_ID, C_Currency_ID_To, C_ConversionType_ID, date, rate, true);
	}
	
	private MConversionRate createConversionRate(int C_Currency_ID, int C_Currency_ID_To, int C_ConversionType_ID, 
			Timestamp date, BigDecimal rate, boolean isMultiplyRate) {
		return ConversionRateHelper.createConversionRate(C_Currency_ID, C_Currency_ID_To, C_ConversionType_ID, date, rate, isMultiplyRate);
	}
	
	private void deleteConversionRate(MConversionRate cr) {
		ConversionRateHelper.deleteConversionRate(cr);
	}
	
	private MInvoice createInvoice(boolean isSOTrx, MBPartner bpartner, Timestamp date, int M_PriceList_ID, int C_ConversionType_ID) {
		return createInvoice(isSOTrx, false, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
	}
	
	private MInvoice createCreditMemo(boolean isSOTrx, MBPartner bpartner, Timestamp date, int M_PriceList_ID, int C_ConversionType_ID) {
		return createInvoice(isSOTrx, true, bpartner, date, M_PriceList_ID, C_ConversionType_ID);
	}
	
	private MInvoice createInvoice(boolean isSOTrx, boolean isCreditMemo, MBPartner bpartner, Timestamp date, int M_PriceList_ID, int C_ConversionType_ID) {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(bpartner);
		invoice.setIsSOTrx(isSOTrx);
		if (isCreditMemo)
			invoice.setC_DocTypeTarget_ID(isSOTrx ? MDocType.DOCBASETYPE_ARCreditMemo : MDocType.DOCBASETYPE_APCreditMemo);
		invoice.setC_DocTypeTarget_ID();
		invoice.setDateInvoiced(date);
		invoice.setDateAcct(date);
		invoice.setM_PriceList_ID(M_PriceList_ID);
		invoice.setC_ConversionType_ID(C_ConversionType_ID);
		invoice.setC_PaymentTerm_ID(105); // Immediate
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		return invoice;
	}
	
	private MInvoiceLine createInvoiceLine(MInvoice invoice, int line, MProduct product, MCharge charge, BigDecimal qty, BigDecimal price) {
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setLine(line);
		if (product != null)
			invoiceLine.setProduct(product);
		else
			invoiceLine.setC_Charge_ID(charge.getC_Charge_ID());
		invoiceLine.setQty(qty);
		invoiceLine.setPrice(price);
		invoiceLine.saveEx();
		return invoiceLine;
	}
	
	private MPayment createPayment(boolean isReceipt, MBPartner bpartner, int C_BankAccount_ID, Timestamp date, BigDecimal payAmt, int C_Currency_ID, int C_ConversionType_ID) {
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_BPartner_ID(bpartner.getC_BPartner_ID());
		payment.setC_BankAccount_ID(C_BankAccount_ID);
		payment.setC_DocType_ID(isReceipt);
		payment.setDateTrx(date);
		payment.setDateAcct(date);
		payment.setPayAmt(payAmt);
		payment.setC_Currency_ID(C_Currency_ID);
		payment.setC_ConversionType_ID(C_ConversionType_ID);
		payment.setTenderType(MPayment.TENDERTYPE_Check);
		payment.setDocStatus(DocAction.STATUS_Drafted);
		payment.setDocAction(DocAction.ACTION_Complete);
		payment.saveEx();
		return payment;
	}
	
	private MAllocationHdr createAllocationHdr(Timestamp date, int C_Currency_ID) {
		MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date, C_Currency_ID, Env.getContext(Env.getCtx(), Env.AD_USER_NAME), getTrxName());
		int doctypeAlloc = MDocType.getDocType("CMA");
		alloc.setC_DocType_ID(doctypeAlloc);
		alloc.saveEx();
		return alloc;
	}
	
	private MAllocationLine createAllocationLine(MAllocationHdr alloc, BigDecimal allocAmount, MInvoice invoice, MPayment payment) {
		MAllocationLine aLine = new MAllocationLine(alloc, allocAmount, Env.ZERO, Env.ZERO, Env.ZERO);
		if (invoice != null) {
			aLine.setC_BPartner_ID(invoice.getC_BPartner_ID());
			aLine.setC_Invoice_ID(invoice.getC_Invoice_ID());
		}
		if (payment != null) {
			aLine.setC_BPartner_ID(payment.getC_BPartner_ID());
			aLine.setC_Payment_ID(payment.getC_Payment_ID());
		}
		aLine.saveEx();
		return aLine;
	}
	
	private void completeDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Completed, docStatus, DocAction.STATUS_Completed + " != " + docStatus);
	}
	
	private void reverseDocument(PO po) {
		reverseDocument(po, true);
	}
	
	private void reverseDocument(PO po, boolean isReverseCorrect) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, isReverseCorrect ? DocAction.ACTION_Reverse_Correct : DocAction.ACTION_Reverse_Accrual);
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
	
	private MBankAccount getBankAccount(int C_Currency_ID) {
		String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
		MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
				.setParameters(Env.getAD_Org_ID(Env.getCtx()), C_Currency_ID)
				.setOrderBy("IsDefault DESC")
				.first();
		assertTrue(ba != null, "@NoAccountOrgCurrency@");
		return ba;
	}
	
	private void testAllocationPosting(MAcctSchema[] ass, MAllocationHdr[] allocList, ArrayList<PostingLine> paymentLineList, ArrayList<PostingLine> tradeLineList) {
		testAllocationPosting(ass, allocList, paymentLineList, tradeLineList, null, null);
	}
	
	private void testAllocationPosting(MAcctSchema[] ass, MAllocationHdr[] allocList, ArrayList<PostingLine> paymentLineList, ArrayList<PostingLine> tradeLineList, 
			ArrayList<PostingLine> gainLossLineList, ArrayList<PostingLine> currBalLineList) {
		assertTrue(allocList.length > 0);
				
		if (paymentLineList == null)
			paymentLineList = new ArrayList<PostingLine>();
		if (tradeLineList == null)
			tradeLineList = new ArrayList<PostingLine>();
		if (gainLossLineList == null)
			gainLossLineList = new ArrayList<PostingLine>();
		if (currBalLineList == null)
			currBalLineList = new ArrayList<PostingLine>();
		
		HashMap<Integer, BigDecimal> totalPaymentAmtByCurrencyId = new HashMap<Integer, BigDecimal>();
		for (PostingLine paymentLine : paymentLineList) {
			BigDecimal totalAmt = totalPaymentAmtByCurrencyId.get(paymentLine.currency.get_ID());
			if (totalAmt == null)
				totalAmt = Env.ZERO;
			totalAmt = totalAmt.add(paymentLine.amtAcctDr).subtract(paymentLine.amtAcctCr);
			totalPaymentAmtByCurrencyId.put(paymentLine.currency.get_ID(), totalAmt);
		}
		
		HashMap<Integer, BigDecimal> totalTradeAmtByCurrencyId = new HashMap<Integer, BigDecimal>();
		for (PostingLine tradeLine : tradeLineList) {
			BigDecimal totalAmt = totalTradeAmtByCurrencyId.get(tradeLine.currency.get_ID());
			if (totalAmt == null)
				totalAmt = Env.ZERO;
			totalAmt = totalAmt.add(tradeLine.amtAcctDr).subtract(tradeLine.amtAcctCr);
			totalTradeAmtByCurrencyId.put(tradeLine.currency.get_ID(), totalAmt);
		}
		
		HashMap<Integer, BigDecimal> totalGainLossAmtByCurrencyId = new HashMap<Integer, BigDecimal>();
		for (PostingLine gainLossLine : gainLossLineList) {
			BigDecimal totalAmt = totalGainLossAmtByCurrencyId.get(gainLossLine.currency.get_ID());
			if (totalAmt == null)
				totalAmt = Env.ZERO;
			totalAmt = totalAmt.add(gainLossLine.amtAcctDr).subtract(gainLossLine.amtAcctCr);
			totalGainLossAmtByCurrencyId.put(gainLossLine.currency.get_ID(), totalAmt);
		}
		
		HashMap<Integer, BigDecimal> totalCurrBalAmtByCurrencyId = new HashMap<Integer, BigDecimal>();
		for (PostingLine currBalLine : currBalLineList) {
			BigDecimal totalAmt = totalCurrBalAmtByCurrencyId.get(currBalLine.currency.get_ID());
			if (totalAmt == null)
				totalAmt = Env.ZERO;
			totalAmt = totalAmt.add(currBalLine.amtAcctDr).subtract(currBalLine.amtAcctCr);
			totalCurrBalAmtByCurrencyId.put(currBalLine.currency.get_ID(), totalAmt);
		}
		
		for (MAllocationHdr alloc : allocList) {
			postDocument(alloc);			

			int C_BPartner_ID = 0;
			int C_BankAccount_ID = 0;
			MAllocationLine[] lines = alloc.getLines(false);
			for (MAllocationLine line : lines) {
				if (line.getC_Payment_ID() > 0) {
					C_BPartner_ID = line.getC_Payment().getC_BPartner_ID();
					C_BankAccount_ID = line.getC_Payment().getC_BankAccount_ID();
					break;
				}
			}
			
			if (C_BPartner_ID == 0) {
				for (MAllocationLine line : lines) {
					if (line.getC_Invoice_ID() > 0) {
						C_BPartner_ID = line.getC_Invoice().getC_BPartner_ID();
						break;
					}
					else if (line.getC_Order_ID() > 0) {
						C_BPartner_ID = line.getC_Order().getC_BPartner_ID();
						break;
					}
				}
			}
			
			for (MAcctSchema as : ass) {
				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, alloc.get_ID(), getTrxName());
				if (C_BankAccount_ID > 0)
					doc.setC_BankAccount_ID(C_BankAccount_ID);
				if (C_BPartner_ID > 0)
					doc.setC_BPartner_ID(C_BPartner_ID);
				
				MAccount acctUnallocatedCash = doc.getAccount(Doc.ACCTTYPE_UnallocatedCash, as);
				MAccount acctReceivable = doc.getAccount(Doc.ACCTTYPE_C_Receivable, as);
				MAccount acctLiability = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
				
				MAccount acctGain = MAccount.get(as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
				MAccount acctLoss = MAccount.get(as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
				MAccount acctCurrBal = as.getCurrencyBalancing_Acct();
				
				BigDecimal totalPaymentAmtAcct = Env.ZERO;
				BigDecimal totalTradeAmtAcct = Env.ZERO;
				BigDecimal totalGainLossAmtAcct = Env.ZERO;
				BigDecimal totalCurrBalAmtAcct = Env.ZERO;
				String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + alloc.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctUnallocatedCash != null && acctUnallocatedCash.getAccount_ID() == fa.getAccount_ID())
						totalPaymentAmtAcct = totalPaymentAmtAcct.add(fa.getAmtAcctDr()).subtract(fa.getAmtAcctCr());
					else if ((acctReceivable != null && acctReceivable.getAccount_ID() == fa.getAccount_ID()) || 
							(acctLiability != null && acctLiability.getAccount_ID() == fa.getAccount_ID()))
						totalTradeAmtAcct = totalTradeAmtAcct.add(fa.getAmtAcctDr()).subtract(fa.getAmtAcctCr());
					else if ((acctGain != null && acctGain.getAccount_ID() == fa.getAccount_ID()) || 
							(acctLoss != null && acctLoss.getAccount_ID() == fa.getAccount_ID()))
						totalGainLossAmtAcct = totalGainLossAmtAcct.add(fa.getAmtAcctDr()).subtract(fa.getAmtAcctCr());
					else if (acctCurrBal != null && acctCurrBal.getAccount_ID() == fa.getAccount_ID())
						totalCurrBalAmtAcct = totalCurrBalAmtAcct.add(fa.getAmtAcctDr()).subtract(fa.getAmtAcctCr());
				}
				
				BigDecimal totalAmtExpected = totalPaymentAmtByCurrencyId.get(as.getC_Currency_ID());
				if (totalAmtExpected != null && totalAmtExpected.compareTo(totalPaymentAmtAcct) == 0)
					totalPaymentAmtByCurrencyId.remove(as.getC_Currency_ID());
				totalAmtExpected = totalTradeAmtByCurrencyId.get(as.getC_Currency_ID());
				if (totalAmtExpected != null && totalAmtExpected.compareTo(totalTradeAmtAcct) == 0)
					totalTradeAmtByCurrencyId.remove(as.getC_Currency_ID());
				totalAmtExpected = totalGainLossAmtByCurrencyId.get(as.getC_Currency_ID());
				if (totalAmtExpected != null && totalAmtExpected.compareTo(totalGainLossAmtAcct) == 0)
					totalGainLossAmtByCurrencyId.remove(as.getC_Currency_ID());
				totalAmtExpected = totalCurrBalAmtByCurrencyId.get(as.getC_Currency_ID());
				if (totalAmtExpected != null && totalAmtExpected.compareTo(totalCurrBalAmtAcct) == 0)
					totalCurrBalAmtByCurrencyId.remove(as.getC_Currency_ID());
			}
		}
		
		assertTrue(totalPaymentAmtByCurrencyId.isEmpty(), totalPaymentAmtByCurrencyId.toString());
		assertTrue(totalTradeAmtByCurrencyId.isEmpty(), totalTradeAmtByCurrencyId.toString());
		assertTrue(totalGainLossAmtByCurrencyId.isEmpty(), totalGainLossAmtByCurrencyId.toString());
		assertTrue(totalCurrBalAmtByCurrencyId.isEmpty(), totalCurrBalAmtByCurrencyId.toString());
	}
	
	private BigDecimal getAccountedAmount(MCurrency currency, BigDecimal multiplyRate, BigDecimal sourceAmt) {
		return sourceAmt.multiply(multiplyRate).setScale(currency.getStdPrecision(), RoundingMode.HALF_UP);
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