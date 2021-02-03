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
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.LogRecord;

import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAllocationLine;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPayment;
import org.compiere.process.DocAction;
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
				payment1.getDateTrx(), CURRENCY_USD, Env.getContext(Env.getCtx(), Env.AD_USER_NAME), trxName);
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

}
