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
 * - Carlos Ruiz - globalqss	       								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Properties;
import java.util.logging.LogRecord;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAllocationLine;
import org.compiere.model.MBPartner;
import org.compiere.model.MBankAccount;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPayment;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogErrorBuffer;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Carlos Ruiz - globalqss
 *
 */
public class AllocationTest extends AbstractTestCase {

	/**
	 * 
	 */
	public AllocationTest() {
	}

	final static int BP_C_AND_W = 117;
	final static int BP_TREEFARM = 114;
	
	final static int PAYMENT_TERM_IMMEDIATE = 105;
	final static int CHARGE_FREIGHT = 200000;
	final static int CURRENCY_USD = 100;
	final static int BANK_ACCOUNT_1234 = 100;

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4567
	 */
	@Test
	public void testAllocateCharge() {
		int severeCount = 0;
		LogRecord[] errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			severeCount = errorLogs.length;

		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// Get the OpenBalance of C&W
		MBPartner bpartner = new MBPartner(ctx, BP_C_AND_W, trxName);
		BigDecimal initialBalance = bpartner.getTotalOpenBalance();

		// Pay $100
		MPayment payment1 = new MPayment(ctx, 0, trxName);
		payment1.setC_BPartner_ID(BP_C_AND_W);
		payment1.setC_DocType_ID(true); // Receipt
		payment1.setDocStatus(DocAction.STATUS_Drafted);
		payment1.setDocAction(DocAction.ACTION_Complete);
		payment1.setPayAmt(Env.ONEHUNDRED);
		payment1.setTenderType(MPayment.TENDERTYPE_Check);
		payment1.setC_BankAccount_ID(BANK_ACCOUNT_1234);
		payment1.setC_Currency_ID(CURRENCY_USD);
		payment1.setDateTrx(TimeUtil.getDay(null));
		payment1.setDateAcct(TimeUtil.getDay(null));
		payment1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Complete);
		payment1.load(trxName);
		assertFalse(info.isError(), "Error processing payment: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, payment1.getDocStatus(), "Payment document status is not completed: " + payment1.getDocStatus());
		assertTrue(payment1.isPosted(), "Payment not posted");

		bpartner.load(trxName);
		BigDecimal actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance.subtract(Env.ONEHUNDRED)) == 0);

		// Create allocation to allocate payment to charge
		MAllocationHdr alloc = new MAllocationHdr (Env.getCtx(), true,	//	manual
				payment1.getDateTrx(), CURRENCY_USD, Env.getContext(Env.getCtx(), "#AD_User_Name"), trxName);
		alloc.setAD_Org_ID(payment1.getAD_Org_ID());
		int doctypeAlloc  = MDocType.getDocType("CMA");
		alloc.setC_DocType_ID(doctypeAlloc);
		alloc.setDescription(alloc.getDescriptionForManualAllocation(payment1.getC_BPartner_ID(), trxName));
		alloc.saveEx();

		MAllocationLine aLine1 = new MAllocationLine (alloc, Env.ONEHUNDRED, 
				Env.ZERO, Env.ZERO, Env.ZERO);
		aLine1.setDocInfo(BP_C_AND_W, 0, 0);
		aLine1.setPaymentInfo(payment1.getC_Payment_ID(), 0);
		aLine1.saveEx();

		MAllocationLine aLine2 = new MAllocationLine (alloc, Env.ONEHUNDRED.negate(),
				Env.ZERO, Env.ZERO, Env.ZERO);
		aLine2.setC_Charge_ID(CHARGE_FREIGHT);
		aLine2.setC_BPartner_ID(BP_C_AND_W);
		aLine2.saveEx();

		assertTrue(alloc.processIt(DocAction.ACTION_Complete));
		alloc.saveEx();

		payment1.load(trxName);
		assertTrue(payment1.isAllocated(), "Payment not allocated");

		bpartner.load(trxName);
		actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance) == 0);

		// Delete Allocation
		MAllocationHdr[] alloc1 = MAllocationHdr.getOfPayment(ctx, payment1.getC_Payment_ID(), trxName);
		assertTrue(alloc1[0].delete(true, trxName));

		payment1.load(trxName);
		assertFalse(payment1.isAllocated(), "Payment not allocated");

		bpartner.load(trxName);
		actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance.subtract(Env.ONEHUNDRED)) == 0);

		errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			assertEquals(severeCount, errorLogs.length, "Severe errors recorded in log: " + errorLogs.length);

		rollback();
	}

	@Test
	public void testAllocateCustomerInvoice() {
		int severeCount = 0;
		LogRecord[] errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			severeCount = errorLogs.length;

		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// Get the OpenBalance of C&W
		MBPartner bpartner = new MBPartner(ctx, BP_C_AND_W, trxName);
		BigDecimal initialBalance = bpartner.getTotalOpenBalance();

		// Create Invoice $100
		MInvoice invoice = new MInvoice(ctx, 0, trxName);
		invoice.setBPartner(MBPartner.get(ctx, BP_C_AND_W));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(PAYMENT_TERM_IMMEDIATE);  // Immediate
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setC_Charge_ID(CHARGE_FREIGHT);
		line1.setQty(new BigDecimal("1"));
		line1.setPrice(Env.ONEHUNDRED);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(trxName);
		assertFalse(info.isError(), "Error processing invoice: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice document status is not completed: " + invoice.getDocStatus());
		assertTrue(Env.ONEHUNDRED.compareTo(invoice.getGrandTotal()) == 0, "Invoice grand total not as expected: " + invoice.getGrandTotal().toPlainString());
		assertTrue(invoice.isPosted(), "Invoice not posted");

		bpartner.load(trxName);
		BigDecimal actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance.add(Env.ONEHUNDRED)) == 0);

		// Pay $100
		MPayment payment1 = new MPayment(ctx, 0, trxName);
		payment1.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment1.setC_BPartner_ID(invoice.getC_BPartner_ID());
		payment1.setC_DocType_ID(true); // Receipt
		payment1.setDocStatus(DocAction.STATUS_Drafted);
		payment1.setDocAction(DocAction.ACTION_Complete);
		payment1.setPayAmt(Env.ONEHUNDRED);
		payment1.setTenderType(MPayment.TENDERTYPE_Check);
		payment1.setC_BankAccount_ID(BANK_ACCOUNT_1234);
		payment1.setC_Currency_ID(CURRENCY_USD);
		payment1.setDateTrx(invoice.getDateInvoiced());
		payment1.setDateAcct(invoice.getDateInvoiced());
		payment1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Complete);
		payment1.load(trxName);
		assertFalse(info.isError(), "Error processing payment: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, payment1.getDocStatus(), "Payment document status is not completed: " + payment1.getDocStatus());
		assertEquals(false, invoice.isPaid(), "Invoice isPaid() is not false");
		assertTrue(payment1.isPosted(), "Payment not posted");

		bpartner.load(trxName);
		actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance) == 0);

		// Delete Allocation
		MAllocationHdr[] alloc1 = MAllocationHdr.getOfPayment(ctx, payment1.getC_Payment_ID(), trxName);
		assertTrue(alloc1[0].delete(true, trxName));

		bpartner.load(trxName);
		actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance) == 0);

		errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			assertEquals(severeCount, errorLogs.length, "Severe errors recorded in log: " + errorLogs.length);

		rollback();
	}

	@Test
	public void testAllocateVendorInvoice() {
		int severeCount = 0;
		LogRecord[] errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			severeCount = errorLogs.length;

		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// Get the OpenBalance of C&W
		MBPartner bpartner = new MBPartner(ctx, BP_TREEFARM, trxName);
		BigDecimal initialBalance = bpartner.getTotalOpenBalance();

		// Create Invoice $100
		MInvoice invoice = new MInvoice(ctx, 0, trxName);
		invoice.setBPartner(MBPartner.get(ctx, BP_TREEFARM));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(PAYMENT_TERM_IMMEDIATE);  // Immediate
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setC_Charge_ID(CHARGE_FREIGHT);
		line1.setQty(new BigDecimal("1"));
		line1.setPrice(Env.ONEHUNDRED);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(trxName);
		assertFalse(info.isError(), "Error processing invoice: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice document status is not completed: " + invoice.getDocStatus());
		assertTrue(Env.ONEHUNDRED.compareTo(invoice.getGrandTotal()) == 0, "Invoice grand total not as expected: " + invoice.getGrandTotal().toPlainString());
		assertTrue(invoice.isPosted(), "Invoice not posted");

		bpartner.load(trxName);
		BigDecimal actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance.subtract(Env.ONEHUNDRED)) == 0);

		// Pay $100
		MPayment payment1 = new MPayment(ctx, 0, trxName);
		payment1.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment1.setC_BPartner_ID(invoice.getC_BPartner_ID());
		payment1.setC_DocType_ID(false); // Payment
		payment1.setDocStatus(DocAction.STATUS_Drafted);
		payment1.setDocAction(DocAction.ACTION_Complete);
		payment1.setPayAmt(Env.ONEHUNDRED);
		payment1.setTenderType(MPayment.TENDERTYPE_Check);
		payment1.setC_BankAccount_ID(BANK_ACCOUNT_1234);
		payment1.setC_Currency_ID(CURRENCY_USD);
		payment1.setDateTrx(invoice.getDateInvoiced());
		payment1.setDateAcct(invoice.getDateInvoiced());
		payment1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Complete);
		payment1.load(trxName);
		assertFalse(info.isError(), "Error processing payment: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, payment1.getDocStatus(), "Payment document status is not completed: " + payment1.getDocStatus());
		assertEquals(false, invoice.isPaid(), "Invoice isPaid() is not false");
		assertTrue(payment1.isPosted(), "Payment not posted");

		bpartner.load(trxName);
		actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance) == 0);

		// Delete Allocation
		MAllocationHdr[] alloc1 = MAllocationHdr.getOfPayment(ctx, payment1.getC_Payment_ID(), trxName);
		assertTrue(alloc1[0].delete(true, trxName));

		bpartner.load(trxName);
		actualBalance = bpartner.getTotalOpenBalance();
		assertTrue(actualBalance.compareTo(initialBalance) == 0);

		errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			assertEquals(severeCount, errorLogs.length, "Severe errors recorded in log: " + errorLogs.length);

		rollback();
	}

	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testPaymentReversePosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30);
		MConversionRate cr1 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(31);
		MConversionRate cr2 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
		
		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");
			
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date1, euro.getC_Currency_ID(), C_ConversionType_ID, payAmt);
			completeDocument(payment);
			postDocument(payment);
			
			reverseAccrualDocument(payment);
			MPayment reversalPayment = new MPayment(Env.getCtx(), payment.getReversal_ID(), getTrxName());
			postDocument(reversalPayment);
			
			MAllocationHdr[] allocations = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			assertTrue(allocations.length == 1);
			
			MAllocationHdr allocation = allocations[0];
			postDocument(allocation);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			for (MAcctSchema as : ass) {
				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;
				
				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocation.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());
				MAccount acctUC = doc.getAccount(Doc.ACCTTYPE_UnallocatedCash, as);
				MAccount acctLoss = MAccount.get(as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
				BigDecimal ucAmtAcctDr = new BigDecimal(30000);
				BigDecimal ucAmtAcctCr = new BigDecimal(31000);
				BigDecimal lossAmtAcct = new BigDecimal(1000);
				
				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + allocation.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctUC.getAccount_ID() == fa.getAccount_ID()) {
						if (fa.getAmtAcctDr().signum() > 0)
							assertTrue(fa.getAmtAcctDr().compareTo(ucAmtAcctDr) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + ucAmtAcctDr.toPlainString());						
						else if (fa.getAmtAcctDr().signum() < 0)
							assertTrue(fa.getAmtAcctDr().compareTo(ucAmtAcctCr.negate()) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + ucAmtAcctCr.negate().toPlainString());						
						else if (fa.getAmtAcctCr().signum() > 0)
							assertTrue(fa.getAmtAcctCr().compareTo(ucAmtAcctCr) == 0, fa.getAmtAcctCr().toPlainString() + "!=" + ucAmtAcctCr.toPlainString());													
					}
					else if (acctLoss.getAccount_ID() == fa.getAccount_ID())
						assertTrue(fa.getAmtAcctDr().compareTo(lossAmtAcct) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + lossAmtAcct.toPlainString());
				}
			}
			
		} finally {
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
			
			rollback();
		}
	}
	
	@Test
	public void testAllocatePaymentPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30);
		MConversionRate cr1 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(31);
		MConversionRate cr2 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
		
		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");
			
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment1 = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date1, euro.getC_Currency_ID(), C_ConversionType_ID, payAmt);
			completeDocument(payment1);
			postDocument(payment1);
			
			MPayment payment2 = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date2, euro.getC_Currency_ID(), C_ConversionType_ID, payAmt.negate());
			completeDocument(payment2);
			postDocument(payment2);
			
			MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date2, euro.getC_Currency_ID(), Env.getContext(Env.getCtx(), "#AD_User_Name"), getTrxName());
			alloc.setAD_Org_ID(payment2.getAD_Org_ID());
			int doctypeAlloc = MDocType.getDocType("CMA");
			alloc.setC_DocType_ID(doctypeAlloc);
			alloc.setDescription(alloc.getDescriptionForManualAllocation(payment2.getC_BPartner_ID(), getTrxName()));
			alloc.saveEx();
			
			MAllocationLine aLine1 = new MAllocationLine(alloc, payment1.getPayAmt(), Env.ZERO, Env.ZERO, Env.ZERO);
			aLine1.setDocInfo(payment1.getC_BPartner_ID(), 0, 0);
			aLine1.setPaymentInfo(payment1.getC_Payment_ID(), 0);
			aLine1.saveEx();
			
			MAllocationLine aLine2 = new MAllocationLine(alloc, payment2.getPayAmt(), Env.ZERO, Env.ZERO, Env.ZERO);
			aLine2.setDocInfo(payment2.getC_BPartner_ID(), 0, 0);
			aLine2.setPaymentInfo(payment2.getC_Payment_ID(), 0);
			aLine2.saveEx();
			
			completeDocument(alloc);
			postDocument(alloc);
			
			MAllocationHdr[] allocations = MAllocationHdr.getOfPayment(Env.getCtx(), payment1.getC_Payment_ID(), getTrxName());
			assertTrue(allocations.length == 1);
			
			MAllocationHdr allocation = allocations[0];
			postDocument(allocation);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			for (MAcctSchema as : ass) {
				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;
				
				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocation.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());
				MAccount acctUC = doc.getAccount(Doc.ACCTTYPE_UnallocatedCash, as);
				MAccount acctLoss = MAccount.get(as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
				BigDecimal ucAmtAcctDr = new BigDecimal(30000);
				BigDecimal ucAmtAcctCr = new BigDecimal(31000);
				BigDecimal lossAmtAcct = new BigDecimal(1000);
				
				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + allocation.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctUC.getAccount_ID() == fa.getAccount_ID()) {
						if (fa.getAmtAcctDr().signum() > 0)
							assertTrue(fa.getAmtAcctDr().compareTo(ucAmtAcctDr) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + ucAmtAcctDr.toPlainString());						
						else if (fa.getAmtAcctDr().signum() < 0)
							assertTrue(fa.getAmtAcctDr().compareTo(ucAmtAcctCr.negate()) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + ucAmtAcctCr.negate().toPlainString());						
						else if (fa.getAmtAcctCr().signum() > 0)
							assertTrue(fa.getAmtAcctCr().compareTo(ucAmtAcctCr) == 0, fa.getAmtAcctCr().toPlainString() + "!=" + ucAmtAcctCr.toPlainString());													
					}
					else if (acctLoss.getAccount_ID() == fa.getAccount_ID())
						assertTrue(fa.getAmtAcctDr().compareTo(lossAmtAcct) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + lossAmtAcct.toPlainString());
				}
			}
			
		} finally {
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
			
			rollback();
		}
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
	
	private MPayment createReceiptPayment(int C_BPartner_ID, int C_BankAccount_ID, Timestamp date, int C_Currency_ID, int C_ConversionType_ID, BigDecimal payAmt) {
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_BankAccount_ID(C_BankAccount_ID);
		payment.setC_DocType_ID(true);
		payment.setDateTrx(date);
		payment.setDateAcct(date);
		payment.setC_BPartner_ID(C_BPartner_ID);
		payment.setPayAmt(payAmt);
		payment.setC_Currency_ID(C_Currency_ID);
		payment.setC_ConversionType_ID(C_ConversionType_ID);
		payment.setTenderType(MPayment.TENDERTYPE_Check);
		payment.setDocStatus(DocAction.STATUS_Drafted);
		payment.setDocAction(DocAction.ACTION_Complete);
		payment.saveEx();
		return payment;
	}


	private MPayment createPayment(int C_BPartner_ID, int C_BankAccount_ID, Timestamp date, int C_Currency_ID, int C_ConversionType_ID, BigDecimal payAmt) {
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_BankAccount_ID(C_BankAccount_ID);
		payment.setC_DocType_ID(false);
		payment.setDateTrx(date);
		payment.setDateAcct(date);
		payment.setC_BPartner_ID(C_BPartner_ID);
		payment.setPayAmt(payAmt);
		payment.setC_Currency_ID(C_Currency_ID);
		payment.setC_ConversionType_ID(C_ConversionType_ID);
		payment.setTenderType(MPayment.TENDERTYPE_Check);
		payment.setDocStatus(DocAction.STATUS_Drafted);
		payment.setDocAction(DocAction.ACTION_Complete);
		payment.saveEx();
		return payment;
	}


	private void completeDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Completed, docStatus, DocAction.STATUS_Completed + " != " + docStatus);
	}
	
	private void reverseAccrualDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Reverse_Accrual);
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


	@Test
	//* Test Allocation with write-off and discount
	// #1 Create AR Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm 2%10 Net 30)
	// #2 Create Payment received
	// #3 Allocate with discount 2.00$ and write-off 2.00$
	// #4 Check accounts
	public void testAllocatePaymentPostingWithWriteOffandDiscountARInv() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 118); // Joe Block
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 106; //(2%10 Net 30)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(true,false, date,  date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			// Payamt with discount
			BigDecimal payAmt = new BigDecimal("102");
			MPayment payment = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date, usd.getC_Currency_ID(), 0, payAmt);
			completeDocument(payment);
			postDocument(payment);


			MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date, usd.getC_Currency_ID(), Env.getContext(Env.getCtx(), "#AD_User_Name"), getTrxName());
			alloc.setAD_Org_ID(payment.getAD_Org_ID());
			int doctypeAlloc = MDocType.getDocType("CMA");
			alloc.setC_DocType_ID(doctypeAlloc);
			alloc.setDescription(alloc.getDescriptionForManualAllocation(payment.getC_BPartner_ID(), getTrxName()));
			alloc.saveEx();

			BigDecimal discount = new BigDecimal("2");
			BigDecimal writeoff = new BigDecimal("2");
			MAllocationLine aLine1 = new MAllocationLine(alloc, payment.getPayAmt(), discount, writeoff, Env.ZERO);
			aLine1.setDocInfo(payment.getC_BPartner_ID(), 0, 0);
			aLine1.setPaymentInfo(payment.getC_Payment_ID(), 0);
			aLine1.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine1.saveEx();

			completeDocument(alloc);
			postDocument(alloc);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, alloc.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 11130 Checking Unallocated Receipts	|		102.00	|		  0.00
				// 59201_Payment discount revenue		|		  2.00	|		  0.00
				// 78100_Bad Debts Write-off			|		  2.00	|		  0.00
				// 12110 Accounts Receivable - Trade	|		  0.00	|		106.00
				// 21610 Tax due						|		  0.11	|		  0.00
				// 59201_Payment discount revenue		|		  0.00	|		  0.11
				// 21610 Tax due						|		  0.11	|		  0.00
				// 78100_Bad Debts Write-off			|		  0.00	|		  0.11
				// --------------------------------------------------------------------
				MAccount acctUC = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_UnallocatedCash_Acct(), getTrxName());
				MAccount acctDEP = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Exp_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctART = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getC_Receivable_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Due_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + alloc.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctUC.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("102.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDEP.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}

					} else if(fa.getAccount_ID() == acctART.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00"));
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// #1 Create AR Credit Memo (TotalLines 100,GrandTotal 106) (PaymentTerm 2%10 Net 30)
	// #2 Create Payment
	// #3 Allocate with discount 2.00$ and write-off 2.00$
	// #4 check accounts
	public void testAllocatePaymentPostingWithWriteOffandDiscountARCredMemo() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 118); // Joe Block
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 106; //(2%10 Net 30)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(true, true, date,  date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			// Payamt with discount
			BigDecimal payAmt = new BigDecimal("102");
			MPayment payment = createPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date, usd.getC_Currency_ID(), 0, payAmt);
			completeDocument(payment);
			postDocument(payment);


			MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date, usd.getC_Currency_ID(), Env.getContext(Env.getCtx(), "#AD_User_Name"), getTrxName());
			alloc.setAD_Org_ID(payment.getAD_Org_ID());
			int doctypeAlloc = MDocType.getDocType("CMA");
			alloc.setC_DocType_ID(doctypeAlloc);
			alloc.setDescription(alloc.getDescriptionForManualAllocation(payment.getC_BPartner_ID(), getTrxName()));
			alloc.saveEx();

			BigDecimal discount = new BigDecimal("2").negate();
			BigDecimal writeoff = new BigDecimal("2").negate();
			MAllocationLine aLine1 = new MAllocationLine(alloc, payment.getPayAmt().negate(), discount, writeoff, Env.ZERO);
			aLine1.setDocInfo(payment.getC_BPartner_ID(), 0, 0);
			aLine1.setPaymentInfo(payment.getC_Payment_ID(), 0);
			aLine1.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine1.saveEx();

			completeDocument(alloc);
			postDocument(alloc);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, alloc.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	 Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 21300_Payment selection				|		-102.00	|		   0.00
				// 59201_Payment discount revenue		|		  -2.00	|		   0.00
				// 78100_Bad Debts Write-off			|		  -2.00	|		   0.00
				// 12110 Accounts Receivable - Trade	|		   0.00	|		-106.00
				// 59201_Payment discount revenue		|		   0.11	|		   0.00
				// 21610 Tax due						|		   0.00	|		   0.11
				// 78100_Bad Debts Write-off			|		   0.11	|		   0.00
				// 21610 Tax due						|		   0.00	|		   0.11
				// --------------------------------------------------------------------
				MAccount acctPS = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_PaymentSelect_Acct(), getTrxName());
				MAccount acctDEP = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Exp_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctART = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getC_Receivable_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Due_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + alloc.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctPS.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("102.00").negate());
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDEP.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctART.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00").negate());
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// #1 Create AP Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm Immediate)
	// #2 Create Payment
	// #3 Allocate with discount 2.00$ and write-off 2.00$
	// #4 check accounts
	public void testAllocatePaymentPostingWithWriteOffandDiscountAPInv() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 121); // Patio
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 105; //(Immediate)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(false, false, date, date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			// Payamt with discount
			BigDecimal payAmt = new BigDecimal("102");
			MPayment payment = createPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date, usd.getC_Currency_ID(), 0, payAmt);
			completeDocument(payment);
			postDocument(payment);


			MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date, usd.getC_Currency_ID(), Env.getContext(Env.getCtx(), "#AD_User_Name"), getTrxName());
			alloc.setAD_Org_ID(payment.getAD_Org_ID());
			int doctypeAlloc = MDocType.getDocType("CMA");
			alloc.setC_DocType_ID(doctypeAlloc);
			alloc.setDescription(alloc.getDescriptionForManualAllocation(payment.getC_BPartner_ID(), getTrxName()));
			alloc.saveEx();

			BigDecimal discount = new BigDecimal("2").negate();
			BigDecimal writeoff = new BigDecimal("2").negate();
			MAllocationLine aLine1 = new MAllocationLine(alloc, payment.getPayAmt().negate(), discount, writeoff, Env.ZERO);
			aLine1.setDocInfo(payment.getC_BPartner_ID(), 0, 0);
			aLine1.setPaymentInfo(payment.getC_Payment_ID(), 0);
			aLine1.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine1.saveEx();

			completeDocument(alloc);
			postDocument(alloc);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, alloc.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 21100_Accounts Payable Trade					106,00			  0,00
				// 59200_Payment discount revenue				  0,00			  2,00
				// 78100_Bad Debts Write-off					  0,00			  2,00
				// 21300_Payment selection						  0,00			102,00
				// 59200_Payment discount revenue				  0,11			  0,00
				// 12610_Tax credit A/R							  0,00			  0,11
				// 78100_Bad Debts Write-off					  0,11			  0,00
				// 12610_Tax credit A/R							  0,00			  0,11
				// --------------------------------------------------------------------
				MAccount acctPT = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getV_Liability_Acct(), getTrxName());
				MAccount acctDRE = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Rev_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctPS = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_PaymentSelect_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Credit_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + alloc.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctPT.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDRE.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctPS.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("102.00"));
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// #1 Create AP Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm Immediate)
	// #2 Create Payment
	// #3 Allocate with discount 2.00$ and write-off 2.00$
	// #4 check accounts
	public void testAllocatePaymentPostingWithWriteOffandDiscountAPCrMe() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 121); // Patio
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 105; //(Immediate)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(false, true, date, date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			// Payamt with discount
			BigDecimal payAmt = new BigDecimal("102");
			MPayment payment = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date, usd.getC_Currency_ID(), 0, payAmt);
			completeDocument(payment);
			postDocument(payment);


			MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date, usd.getC_Currency_ID(), Env.getContext(Env.getCtx(), "#AD_User_Name"), getTrxName());
			alloc.setAD_Org_ID(payment.getAD_Org_ID());
			int doctypeAlloc = MDocType.getDocType("CMA");
			alloc.setC_DocType_ID(doctypeAlloc);
			alloc.setDescription(alloc.getDescriptionForManualAllocation(payment.getC_BPartner_ID(), getTrxName()));
			alloc.saveEx();

			BigDecimal discount = new BigDecimal("2");
			BigDecimal writeoff = new BigDecimal("2");
			MAllocationLine aLine1 = new MAllocationLine(alloc, payment.getPayAmt(), discount, writeoff, Env.ZERO);
			aLine1.setDocInfo(payment.getC_BPartner_ID(), 0, 0);
			aLine1.setPaymentInfo(payment.getC_Payment_ID(), 0);
			aLine1.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine1.saveEx();

			completeDocument(alloc);
			postDocument(alloc);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, alloc.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	 Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 21100_Accounts Payable Trade					-106,00			   0,00
				// 59200_Payment discount revenue				   0,00			  -2,00
				// 78100_Bad Debts Write-off				   	   0,00			  -2,00
				// 21300_Payment selection						   0,00			-102,00
				// 59200_Payment discount revenue				   0,00			   0,11
				// 12610_Tax credit A/R							   0,11			   0,00
				// 78100_Bad Debts Write-off				  	   0,00			   0,11
				// 12610_Tax credit A/R							   0,11			   0,00
				// --------------------------------------------------------------------
				MAccount acctPT = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getV_Liability_Acct(), getTrxName());
				MAccount acctDRE = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Rev_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctUC = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_UnallocatedCash_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Credit_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + alloc.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctPT.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00").negate());
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDRE.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}
					} else if(fa.getAccount_ID() == acctUC.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("102.00").negate());
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// AR Invoice in payment
	// #1 Create AR Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm Immediate)
	// #2 Create Payment with discount 2.00$ and write-off 2.00$
	// #4 check accounts
	public void testPaymentPostingWithWriteOffandDiscountARInv() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 118); // Joe Block
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 106; //(2%10 Net 30)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(true,false, date,  date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			// Payamt with discount
			BigDecimal payAmt = new BigDecimal("102");
			BigDecimal discount = new BigDecimal("2");
			BigDecimal writeoff = new BigDecimal("2");
			MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
			payment.setC_BankAccount_ID(ba.getC_BankAccount_ID());
			payment.setC_DocType_ID(true);
			payment.setDateTrx(date);
			payment.setDateAcct(date);
			payment.setC_BPartner_ID(bpartner.getC_BPartner_ID());
			payment.setC_Invoice_ID(invoice.getC_Invoice_ID());
			payment.setPayAmt(payAmt);
			payment.setDiscountAmt(discount);
			payment.setWriteOffAmt(writeoff);
			payment.setC_Currency_ID(usd.getC_Currency_ID());
			payment.setC_ConversionType_ID(0);
			payment.setTenderType(MPayment.TENDERTYPE_Check);
			payment.setDocStatus(DocAction.STATUS_Drafted);
			payment.setDocAction(DocAction.ACTION_Complete);
			payment.saveEx();

			completeDocument(payment);
			postDocument(payment);

			MAllocationHdr[] allocationa = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocationa[0].get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 11130 Checking Unallocated Receipts	|		102.00	|		  0.00
				// 59201_Payment discount revenue		|		  2.00	|		  0.00
				// 78100_Bad Debts Write-off			|		  2.00	|		  0.00
				// 12110 Accounts Receivable - Trade	|		  0.00	|		106.00
				// 21610 Tax due						|		  0.11	|		  0.00
				// 59201_Payment discount revenue		|		  0.00	|		  0.11
				// 21610 Tax due						|		  0.11	|		  0.00
				// 78100_Bad Debts Write-off			|		  0.00	|		  0.11
				// --------------------------------------------------------------------
				MAccount acctUC = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_UnallocatedCash_Acct(), getTrxName());
				MAccount acctDEP = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Exp_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctART = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getC_Receivable_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Due_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + allocationa[0].get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctUC.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("102.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDEP.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}

					} else if(fa.getAccount_ID() == acctART.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00"));
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// AR Credit Memo in payment
	// #1 Create AR Credit Memo (TotalLines 100,GrandTotal 106) (PaymentTerm 2%10 Net 30)
	// #2 Create Payment with discount 2.00$ and write-off 2.00$
	// #4 check accounts
	public void testPaymentPostingWithWriteOffandDiscountARCredMemo() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 118); // Joe Block
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 106; //(2%10 Net 30)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(true, true, date,  date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			// Payamt with discount
			BigDecimal payAmt = new BigDecimal("102").negate();
			BigDecimal discount = new BigDecimal("2").negate();
			BigDecimal writeoff = new BigDecimal("2").negate();
			MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
			payment.setC_BankAccount_ID(ba.getC_BankAccount_ID());
			payment.setC_DocType_ID(true);
			payment.setDateTrx(date);
			payment.setDateAcct(date);
			payment.setC_BPartner_ID(bpartner.getC_BPartner_ID());
			payment.setC_Invoice_ID(invoice.getC_Invoice_ID());
			payment.setPayAmt(payAmt);
			payment.setDiscountAmt(discount);
			payment.setWriteOffAmt(writeoff);
			payment.setC_Currency_ID(usd.getC_Currency_ID());
			payment.setC_ConversionType_ID(0);
			payment.setTenderType(MPayment.TENDERTYPE_Check);
			payment.setDocStatus(DocAction.STATUS_Drafted);
			payment.setDocAction(DocAction.ACTION_Complete);
			payment.saveEx();

			completeDocument(payment);
			postDocument(payment);

			MAllocationHdr[] allocationa = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocationa[0].get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	 Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 11130_Checking Unallocated Receipts	|		-102.00	|		   0.00
				// 59201_Payment discount revenue		|		  -2.00	|		   0.00
				// 78100_Bad Debts Write-off			|		  -2.00	|		   0.00
				// 12110 Accounts Receivable - Trade	|		   0.00	|		-106.00
				// 59201_Payment discount revenue		|		   0.11	|		   0.00
				// 21610 Tax due						|		   0.00	|		   0.11
				// 78100_Bad Debts Write-off			|		   0.11	|		   0.00
				// 21610 Tax due						|		   0.00	|		   0.11
				// --------------------------------------------------------------------
				MAccount acctPS = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_PaymentSelect_Acct(), getTrxName());
				MAccount acctDEP = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Exp_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctART = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getC_Receivable_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Due_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + allocationa[0].get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctPS.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("102.00").negate());
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDEP.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctART.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00").negate());
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// AP Invoice in payment
	// #1 Create AP Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm Immediate)
	// #2 Create Payment with discount 2.00$ and write-off 2.00$
	// #4 check accounts
	public void testPaymentPostingWithWriteOffandDiscountAPInv() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 121); // Patio
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 105; //(Immediate)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(false, false, date, date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));


			BigDecimal payAmt = new BigDecimal("102");
			BigDecimal discount = new BigDecimal("2");
			BigDecimal writeoff = new BigDecimal("2");
			MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
			payment.setC_BankAccount_ID(ba.getC_BankAccount_ID());
			payment.setC_DocType_ID(false);
			payment.setDateTrx(date);
			payment.setDateAcct(date);
			payment.setC_BPartner_ID(bpartner.getC_BPartner_ID());
			payment.setC_Invoice_ID(invoice.getC_Invoice_ID());
			payment.setPayAmt(payAmt);
			payment.setDiscountAmt(discount);
			payment.setWriteOffAmt(writeoff);
			payment.setC_Currency_ID(usd.getC_Currency_ID());
			payment.setC_ConversionType_ID(0);
			payment.setTenderType(MPayment.TENDERTYPE_Check);
			payment.setDocStatus(DocAction.STATUS_Drafted);
			payment.setDocAction(DocAction.ACTION_Complete);
			payment.saveEx();

			completeDocument(payment);
			postDocument(payment);

			MAllocationHdr[] allocationa = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocationa[0].get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 21100_Accounts Payable Trade					106,00			  0,00
				// 59200_Payment discount revenue				  0,00			  2,00
				// 78100_Bad Debts Write-off					  0,00			  2,00
				// 21300_Payment selection						  0,00			102,00
				// 59200_Payment discount revenue				  0,11			  0,00
				// 12610_Tax credit A/R							  0,00			  0,11
				// 78100_Bad Debts Write-off					  0,11			  0,00
				// 12610_Tax credit A/R							  0,00			  0,11
				// --------------------------------------------------------------------
				MAccount acctPT = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getV_Liability_Acct(), getTrxName());
				MAccount acctDRE = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Rev_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctPS = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_PaymentSelect_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Credit_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + allocationa[0].get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctPT.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDRE.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctPS.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("102.00"));
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// AP Credit Memo in payment
	// #1 Create AP Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm Immediate)
	// #2 Create Payment with discount 2.00$ and write-off 2.00$
	// #4 check accounts
	public void testPaymentPostingWithWriteOffandDiscountAPCrMe() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 121); // Patio
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 105; //(Immediate)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(false, true, date, date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			// Payamt with discount
			BigDecimal payAmt = new BigDecimal("102").negate();
			BigDecimal discount = new BigDecimal("2").negate();
			BigDecimal writeoff = new BigDecimal("2").negate();
			MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
			payment.setC_BankAccount_ID(ba.getC_BankAccount_ID());
			payment.setC_DocType_ID(false);
			payment.setDateTrx(date);
			payment.setDateAcct(date);
			payment.setC_BPartner_ID(bpartner.getC_BPartner_ID());
			payment.setC_Invoice_ID(invoice.getC_Invoice_ID());
			payment.setPayAmt(payAmt);
			payment.setDiscountAmt(discount);
			payment.setWriteOffAmt(writeoff);
			payment.setC_Currency_ID(usd.getC_Currency_ID());
			payment.setC_ConversionType_ID(0);
			payment.setTenderType(MPayment.TENDERTYPE_Check);
			payment.setDocStatus(DocAction.STATUS_Drafted);
			payment.setDocAction(DocAction.ACTION_Complete);
			payment.saveEx();

			completeDocument(payment);
			postDocument(payment);

			MAllocationHdr[] allocationa = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocationa[0].get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	 Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 21100_Accounts Payable Trade					-106,00			   0,00
				// 59200_Payment discount revenue				   0,00			  -2,00
				// 78100_Bad Debts Write-off				   	   0,00			  -2,00
				// 21300_Payment selection						   0,00			-102,00
				// 59200_Payment discount revenue				   0,00			   0,11
				// 12610_Tax credit A/R							   0,11			   0,00
				// 78100_Bad Debts Write-off				  	   0,00			   0,11
				// 12610_Tax credit A/R							   0,11			   0,00
				// --------------------------------------------------------------------
				MAccount acctPT = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getV_Liability_Acct(), getTrxName());
				MAccount acctDRE = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Rev_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctUC = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getB_UnallocatedCash_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Credit_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + allocationa[0].get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctPT.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00").negate());
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					} else if(fa.getAccount_ID() == acctDRE.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)<0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00").negate());
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}
					} else if(fa.getAccount_ID() == acctUC.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("104.00").negate());
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// #1 Create AR Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm 2%10 Net 30)
	// #1 Create AR CreditMemo (TotalLines 96,32,GrandTotal 102) (PaymentTerm Immediate)
	// #3 Allocate of Invoice with discount 2.00$ and write-off 2.00$
	// #4 Check accounts
	public void testAllocatePostingWithWriteOffandDiscountARInvARCrMe() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 118); // Joe Block
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 106; //(2%10 Net 30)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(true,false, date,  date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			Integer paytermcm = 105; //(Immediate)
			MInvoice creditmemo = createInvoice(true,true, date,  date,
					bpartner.getC_BPartner_ID(), paytermcm, taxid, new BigDecimal("96.23"));
			assertEquals(creditmemo.getTotalLines(), new BigDecimal("96.23"));
			assertEquals(creditmemo.getGrandTotal(), new BigDecimal("102.00"));

			MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date, usd.getC_Currency_ID(), Env.getContext(Env.getCtx(), "#AD_User_Name"), getTrxName());
			alloc.setAD_Org_ID(invoice.getAD_Org_ID());
			int doctypeAlloc = MDocType.getDocType("CMA");
			alloc.setC_DocType_ID(doctypeAlloc);
			alloc.setDescription(alloc.getDescriptionForManualAllocation(invoice.getC_BPartner_ID(), getTrxName()));
			alloc.saveEx();

			BigDecimal discount = new BigDecimal("2");
			BigDecimal writeoff = new BigDecimal("2");
			MAllocationLine aLine1 = new MAllocationLine(alloc, invoice.getGrandTotal().subtract(discount.add(writeoff)), discount, writeoff, Env.ZERO);
			aLine1.setDocInfo(invoice.getC_BPartner_ID(), 0, 0);
			aLine1.setPaymentInfo(invoice.getC_Payment_ID(), 0);
			aLine1.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine1.saveEx();
			MAllocationLine aLine2 = new MAllocationLine(alloc, creditmemo.getGrandTotal().negate(), Env.ZERO, Env.ZERO, Env.ZERO);
			aLine2.setDocInfo(invoice.getC_BPartner_ID(), 0, 0);
			aLine2.setPaymentInfo(invoice.getC_Payment_ID(), 0);
			aLine2.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine2.saveEx();

			completeDocument(alloc);
			postDocument(alloc);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, alloc.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 59201_Payment discount revenue		|		  2.00	|		   0.00
				// 78100_Bad Debts Write-off			|		  2.00	|		   0.00
				// 12110 Accounts Receivable - Trade	|		  0.00	|		 106.00
				// 21610 Tax due						|		  0.11	|		   0.00
				// 59201_Payment discount revenue		|		  0.00	|		   0.11
				// 21610 Tax due						|		  0.11	|		   0.00
				// 78100_Bad Debts Write-off			|		  0.00	|		   0.11
				// 12110_Accounts Receivable - Trade	|		  0.00	|		-102.00
				// --------------------------------------------------------------------
				// ToDo: set Account
				MAccount acctDRE = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Rev_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctART = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getC_Receivable_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Due_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + alloc.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctDRE.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						}

					} else if(fa.getAccount_ID() == acctART.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("-102.00"));
						}
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
					}

				}
			}

		} finally {

			rollback();
		}
	}


	@Test
	//* Test Allocation with write-off and discount
	// #1 Create AP Invoice (TotalLines 100,GrandTotal 106) (PaymentTerm 2%10 Net 30)
	// #1 Create AP CreditMemo (TotalLines 96,32,GrandTotal 102) (PaymentTerm Immediate)
	// #3 Allocate of Invoice with discount 2.00$ and write-off 2.00$
	// #4 Check accounts
	public void testAllocatePostingWithWriteOffandDiscountAPInvAPCrMe() {

		MBPartner bpartner = MBPartner.get(Env.getCtx(), 121); // Patio
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		Timestamp date = new Timestamp(cal.getTimeInMillis());

		MCurrency usd = MCurrency.get(100); // USD

		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");

			// Invoice (totallines 100, grandtotal 106)
			Integer payterm = 105; //(Immediate)
			Integer taxid = 105; // (CT Sales, Rate 6)
			MInvoice invoice = createInvoice(false, false, date, date,
					bpartner.getC_BPartner_ID(), payterm, taxid, Env.ONEHUNDRED);
			assertEquals(invoice.getTotalLines(), new BigDecimal("100.0"));
			assertEquals(invoice.getGrandTotal(), new BigDecimal("106.00"));

			Integer paytermcm = 105; //(Immediate)
			MInvoice creditmemo = createInvoice(false,true, date,  date,
					bpartner.getC_BPartner_ID(), paytermcm, taxid, new BigDecimal("96.23"));
			assertEquals(creditmemo.getTotalLines(), new BigDecimal("96.23"));
			assertEquals(creditmemo.getGrandTotal(), new BigDecimal("102.00"));


			MAllocationHdr alloc = new MAllocationHdr(Env.getCtx(), true, date, usd.getC_Currency_ID(), Env.getContext(Env.getCtx(), "#AD_User_Name"), getTrxName());
			alloc.setAD_Org_ID(invoice.getAD_Org_ID());
			int doctypeAlloc = MDocType.getDocType("CMA");
			alloc.setC_DocType_ID(doctypeAlloc);
			alloc.setDescription(alloc.getDescriptionForManualAllocation(invoice.getC_BPartner_ID(), getTrxName()));
			alloc.saveEx();

			BigDecimal discount = new BigDecimal("2").negate();
			BigDecimal writeoff = new BigDecimal("2").negate();
			BigDecimal amtinv = invoice.getGrandTotal().negate().subtract(discount.add(writeoff));
			MAllocationLine aLine1 = new MAllocationLine(alloc, amtinv, discount, writeoff, Env.ZERO);
			aLine1.setDocInfo(invoice.getC_BPartner_ID(), 0, 0);
			aLine1.setPaymentInfo(invoice.getC_Payment_ID(), 0);
			aLine1.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine1.saveEx();
			MAllocationLine aLine2 = new MAllocationLine(alloc, creditmemo.getGrandTotal(), Env.ZERO, Env.ZERO, Env.ZERO);
			aLine2.setDocInfo(invoice.getC_BPartner_ID(), 0, 0);
			aLine2.setPaymentInfo(invoice.getC_Payment_ID(), 0);
			aLine2.setC_Invoice_ID(invoice.getC_Invoice_ID());
			aLine2.saveEx();

			completeDocument(alloc);
			postDocument(alloc);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));

			for (MAcctSchema as : ass) {

				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;

				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, alloc.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());

				// Account								|	Acct Debit	|	Acct Credit
				// --------------------------------------------------------------------
				// 21100_Accounts Payable Trade					106,00			  0,00
				// 59200_Payment discount revenue				  0,00			  2,00
				// 78100_Bad Debts Write-off					  0,00			  2,00
				// 59200_Payment discount revenue				  0,11			  0,00
				// 12610_Tax credit A/R							  0,00			  0,11
				// 78100_Bad Debts Write-off					  0,11			  0,00
				// 12610_Tax credit A/R							  0,00			  0,11
				// 21100_Accounts Payable Trade					-102,00			  0,00
				// --------------------------------------------------------------------
				MAccount acctPT = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getV_Liability_Acct(), getTrxName());
				MAccount acctDRE = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getPayDiscount_Rev_Acct(), getTrxName());
				MAccount acctWO = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getWriteOff_Acct(), getTrxName());
				MAccount acctTD = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getT_Credit_Acct(), getTrxName());

				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + alloc.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID()
						+ " ORDER BY Created";
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());

				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if(fa.getAccount_ID() == acctPT.getAccount_ID()) {
						if(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("106.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("-102.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctDRE.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctWO.getAccount_ID()) {
						if(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP).compareTo(Env.ZERO)>0) {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("2.00"));
						} else {
							assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
							assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						}
					} else if(fa.getAccount_ID() == acctTD.getAccount_ID()) {
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.00"));
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), new BigDecimal("0.11"));
					}
				}
			}

		} finally {

			rollback();
		}
	}

	private MInvoice createInvoice(Boolean isAR, Boolean isCreditMemo, Timestamp dateinvoiced,  Timestamp dateacct,
			Integer bpartnerid, Integer payterm, Integer taxid, BigDecimal totallines) {


		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());

		if(isAR) {
			if(isCreditMemo) {
				invoice.setC_DocType_ID(118); //AR Credit Memo
				invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARCreditMemo);

			} else {
				invoice.setC_DocType_ID(116); //AR Invoice
				invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
			}
		} else {
			if(isCreditMemo) {
				invoice.setC_DocType_ID(124); //AP CreditMemo
				invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APCreditMemo);
			} else {
				invoice.setC_DocType_ID(123); //AP Invoice
				invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			}
		}

		invoice.setC_BPartner_ID(bpartnerid);
		invoice.setDateInvoiced(dateinvoiced);
		invoice.setDateAcct(dateacct);
		invoice.setC_PaymentTerm_ID(payterm);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);


		line1.setLine(10);
		line1.setC_Charge_ID(CHARGE_FREIGHT);
		line1.setQty(new BigDecimal("1"));
		line1.setPrice(totallines);
		line1.setC_Tax_ID(taxid);
		line1.saveEx();


		completeDocument(invoice);
		postDocument(invoice);

		return invoice;
	}


}
