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
import java.sql.Timestamp;

import org.compiere.model.MBPRelation;
import org.compiere.model.MBPartner;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPaySelectionLine;
import org.compiere.model.MPayment;
import org.compiere.model.MProduct;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class PaymentTest extends AbstractTestCase {

	public PaymentTest() {
	}

	@Test
	public void testClearCreditCardFields() {
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_DocType_ID(true);
		payment.setC_BPartner_ID(DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		payment.setTenderType(MPayment.TENDERTYPE_CreditCard);
		payment.setCreditCard(MPayment.TRXTYPE_Sales, MPayment.CREDITCARDTYPE_MasterCard, "5555555555554444", "123", "0122");
		int C_BankAccount_ID = DB.getSQLValueEx(getTrxName(), "SELECT C_BankAccount_ID FROM C_BankAccount WHERE IsActive='Y' AND AD_Client_ID=? "
				+ "AND IsDefault='Y' ORDER BY C_BankAccount_ID", getAD_Client_ID());
		payment.setC_BankAccount_ID(C_BankAccount_ID);
		payment.setC_Currency_ID(Env.getContextAsInt(Env.getCtx(), Env.C_CURRENCY_ID));
		payment.saveEx();
		assertEquals("123", payment.getCreditCardVV());
		
		payment.setTenderType(MPayment.TENDERTYPE_Check);
		payment.saveEx();
		assertTrue(Util.isEmpty(payment.getCreditCardVV()), "Credit card verification code not clear after change of tender type: "+payment.getCreditCardVV());
	}
	
	/**
	 * Test cases for Credit Check
	 */
	@Test
	public void testCreditCheckPayment()
	{
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		// Joe Block
		MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
		bp.setSOCreditStatus(MBPartner.SOCREDITSTATUS_CreditStop);
		bp.saveEx();

		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_BPartner_ID(bp.getC_BPartner_ID());
		payment.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.HQ_POS_CASH.id);
		payment.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		payment.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		payment.setC_DocType_ID(false);
		payment.setDateTrx(today);
		payment.setPayAmt(new BigDecimal(1000));
		payment.setDateAcct(today);
		payment.saveEx();

		payment.load(getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Prepare);
		assertTrue(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Invalid, payment.getDocStatus());

		bp.setSOCreditStatus(MBPartner.SOCREDITSTATUS_NoCreditCheck);
		bp.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, payment.getDocStatus());

		info = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Reverse_Accrual);
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, payment.getDocStatus());
	}

	/**
	 * Test proxy payment feature - a business partner can pay for another business partner's invoice
	 * when the BP Relation IsPayFrom flag is enabled
	 */
	@Test
	public void testProxyPayment()
	{
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		// Step 1: Generate an invoice for Joe Block and complete it
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		invoice.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		invoice.setC_DocTypeTarget_ID(MInvoice.DOCBASETYPE_ARInvoice);
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
		invoice.saveEx();

		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.FERTILIZER_50.id));
		invoiceLine.setQty(new BigDecimal("2"));
		invoiceLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), "Error completing invoice: " + info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice should be completed");

		// Step 2: Create a payment for that invoice where the business partner is C&W Construction
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id); // C&W Construction
		payment.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		payment.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		payment.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		payment.setC_DocType_ID(true); // Receipt
		payment.setDateTrx(today);
		payment.setDateAcct(today);
		payment.setPayAmt(invoice.getGrandTotal());

		// Step 3: Expected - the payment cannot be saved, must throw an error indicating that the business partner is different
		boolean errorThrown = false;
		String errorMsg = null;
		try {
			payment.saveEx();
		} catch (Exception e) {
			errorThrown = true;
			errorMsg = e.getMessage();
		}
		assertTrue(errorThrown, "Payment save should fail when BP on payment differs from BP on invoice without proper relation");
		assertEquals("Error: Business Partner is different from Invoice - Business Partner", errorMsg);

		// Step 4: Retrieve the record from MBPRelation object (C_BP_Relation table) with C_BP_Relation_ID=100
		MBPRelation bpRelation = new MBPRelation(Env.getCtx(), DictionaryIDs.C_BP_Relation.C_AND_W_PAYS_FOR_JOE.id, getTrxName());
		assertTrue(bpRelation.getC_BP_Relation_ID() > 0, "BP Relation with ID 100 should exist");

		// Step 5: Set the flag IsPayFrom to true
		bpRelation.setIsPayFrom(true);

		// Step 6: Save the record
		bpRelation.saveEx();
		assertTrue(bpRelation.isPayFrom(), "IsPayFrom flag should be true");

		// Step 7: Try to save again the payment - this time the save must succeed
		MPayment payment2 = new MPayment(Env.getCtx(), 0, getTrxName());
		payment2.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment2.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id); // C&W Construction
		payment2.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		payment2.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		payment2.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		payment2.setC_DocType_ID(true); // Receipt
		payment2.setDateTrx(today);
		payment2.setDateAcct(today);
		payment2.setPayAmt(invoice.getGrandTotal());
		payment2.saveEx();

		assertTrue(payment2.getC_Payment_ID() > 0, "Payment should be saved successfully after enabling IsPayFrom");

		// Step 8: Complete the payment
		info = MWorkflow.runDocumentActionWorkflow(payment2, DocAction.ACTION_Complete);
		assertFalse(info.isError(), "Error completing payment: " + info.getSummary());
		payment2.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, payment2.getDocStatus(), "Payment should be completed");

		// Verify the invoice is now paid
		invoice.load(getTrxName());
		assertTrue(invoice.isPaid(), "Invoice should be marked as paid");
		assertTrue(Env.ZERO.compareTo(invoice.getOpenAmt()) == 0, "Invoice open amount should be zero");
	}

	/**
	 * Test Payment Selection Check with partial payment, discount, write-off and over/under amount
	 * This test verifies that the payment created from confirmPrint correctly inherits all amounts
	 */
	@Test
	public void testPaySelectionCheckWithPartialPayment()
	{
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		// Step 1: Create a purchase invoice for Seed Farm Business Partner with payment rule Check for $100
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setC_BPartner_ID(DictionaryIDs.C_BPartner.SEED_FARM.id);
		invoice.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		invoice.saveEx();

		// Add invoice line with Commissions charge for $100
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setLine(10);
		invoiceLine.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		invoiceLine.setQty(BigDecimal.ONE);
		invoiceLine.setPrice(new BigDecimal("100"));
		invoiceLine.saveEx();

		// Complete the invoice
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), "Error completing invoice: " + info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice should be completed");
		assertTrue(new BigDecimal("100").compareTo(invoice.getGrandTotal()) == 0, "Invoice grand total should be 100");

		// Step 2: Create a payment selection
		MPaySelection paySelection = new MPaySelection(Env.getCtx(), 0, getTrxName());
		paySelection.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		paySelection.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		paySelection.setName("Test Payment Selection");
		paySelection.setPayDate(today);
		paySelection.saveEx();

		// Step 3: Create a payment selection line with partial payment
		MPaySelectionLine paySelectionLine = new MPaySelectionLine(paySelection, 10, MInvoice.PAYMENTRULE_Check);
		paySelectionLine.setC_Invoice_ID(invoice.getC_Invoice_ID());
		paySelectionLine.setIsSOTrx(false);
		paySelectionLine.setOpenAmt(new BigDecimal("100"));
		paySelectionLine.setPayAmt(new BigDecimal("50"));
		paySelectionLine.setDiscountAmt(new BigDecimal("10"));
		paySelectionLine.setWriteOffAmt(new BigDecimal("10"));
		paySelectionLine.setDifferenceAmt(new BigDecimal("30")); // 100 - 50 - 10 - 10 = 30
		paySelectionLine.saveEx();

		// Step 4: Run the Prepare Payment process
		// This simulates what PaySelectionCreateCheck process does
		MPaySelectionCheck check = new MPaySelectionCheck(paySelectionLine, MInvoice.PAYMENTRULE_Check);
		check.saveEx();

		// Link the payment selection line to the check
		paySelectionLine.setC_PaySelectionCheck_ID(check.getC_PaySelectionCheck_ID());
		paySelectionLine.setProcessed(true);
		paySelectionLine.saveEx();

		// Mark the payment selection as processed
		paySelection.setProcessed(true);
		paySelection.saveEx();

		// Verify the check was created with correct amounts
		assertTrue(check.getC_PaySelectionCheck_ID() > 0, "Payment selection check should be created");
		assertTrue(new BigDecimal("50").compareTo(check.getPayAmt()) == 0, "Check pay amount should be 50");
		assertTrue(new BigDecimal("10").compareTo(check.getDiscountAmt()) == 0, "Check discount amount should be 10");
		assertTrue(new BigDecimal("10").compareTo(check.getWriteOffAmt()) == 0, "Check write-off amount should be 10");
		assertEquals(DictionaryIDs.C_BPartner.SEED_FARM.id, check.getC_BPartner_ID(), "Check should be for Seed Farm");

		// Step 5: Call confirmPrint - this should create a payment
		MPaySelectionCheck.confirmPrint(check, null);

		// Reload the check to get the payment ID
		check.load(getTrxName());
		assertTrue(check.getC_Payment_ID() > 0, "Payment should be created after confirmPrint");
		assertTrue(check.isPrinted(), "Check should be marked as printed");
		assertTrue(check.isProcessed(), "Check should be marked as processed");

		// Step 6: Verify the payment has correctly inherited all values
		MPayment payment = new MPayment(Env.getCtx(), check.getC_Payment_ID(), getTrxName());
		assertTrue(new BigDecimal("50").compareTo(payment.getPayAmt()) == 0, "Payment pay amount should be 50");
		assertTrue(new BigDecimal("10").compareTo(payment.getDiscountAmt()) == 0, "Payment discount amount should be 10");
		assertTrue(new BigDecimal("10").compareTo(payment.getWriteOffAmt()) == 0, "Payment write-off amount should be 10");

		// Verify over/under amount (difference amount)
		assertTrue(payment.isOverUnderPayment(), "Payment should be marked as over/under payment");
		assertTrue(new BigDecimal("30").compareTo(payment.getOverUnderAmt()) == 0, "Payment over/under amount should be 30");

		// Verify payment is linked to the invoice
		assertEquals(invoice.getC_Invoice_ID(), payment.getC_Invoice_ID(), "Payment should be linked to the invoice");
		assertEquals(DictionaryIDs.C_BPartner.SEED_FARM.id, payment.getC_BPartner_ID(), "Payment should be for Seed Farm");

		// Verify payment is completed
		assertEquals(DocAction.STATUS_Completed, payment.getDocStatus(), "Payment should be completed");

		// Verify payment rule and tender type
		assertEquals(MInvoice.PAYMENTRULE_Check, check.getPaymentRule(), "Check payment rule should be Check");
		assertEquals(MPayment.TENDERTYPE_Check, payment.getTenderType(), "Payment tender type should be Check");
	}

}
