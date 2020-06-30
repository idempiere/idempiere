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
 * - Carlos Ruiz - globalqss           								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPayment;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Carlos Ruiz - globalqss
 */
public class InvoiceCustomerTest extends AbstractTestCase {

	public InvoiceCustomerTest() {
	}

	final static BigDecimal TWOHUNDRED = new BigDecimal("200");

	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-829
	 */
	public void testOpenAmt() {
		// Invoice $200 today
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), 117));  // C&W
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(105);  // Immediate
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setC_Charge_ID(100);  // Bank Charge
		line1.setQty(new BigDecimal("1"));
		line1.setPrice(Env.ONEHUNDRED);
		line1.saveEx();

		MInvoiceLine line2 = new MInvoiceLine(invoice);
		line2.setLine(20);
		line2.setC_Charge_ID(101);  // Commissions Paid
		line2.setQty(new BigDecimal("1"));
		line2.setPrice(Env.ONEHUNDRED);
		line2.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		assertTrue(TWOHUNDRED.compareTo(invoice.getGrandTotal()) == 0);

		// first $100 payment next week
		MPayment payment1 = new MPayment(Env.getCtx(), 0, getTrxName());
		payment1.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment1.setC_BPartner_ID(invoice.getC_BPartner_ID());
		payment1.setC_DocType_ID(true); // Receipt
		payment1.setDocStatus(DocAction.STATUS_Drafted);
		payment1.setDocAction(DocAction.ACTION_Complete);
		payment1.setPayAmt(Env.ONEHUNDRED);
		payment1.setTenderType(MPayment.TENDERTYPE_Check);
		payment1.setC_BankAccount_ID(100); // 1234_MoneyBank_123456789
		payment1.setC_Currency_ID(100);  // USD
		Timestamp nextweek = TimeUtil.addDays(today, 7);
		payment1.setDateTrx(nextweek);
		payment1.setDateAcct(nextweek);
		payment1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Complete);
		payment1.load(getTrxName());
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, payment1.getDocStatus());
		assertEquals(false, invoice.isPaid());

		// second $100 payment next two weeks
		MPayment payment2 = new MPayment(Env.getCtx(), 0, getTrxName());
		payment2.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment2.setC_BPartner_ID(invoice.getC_BPartner_ID());
		payment2.setC_DocType_ID(true); // Receipt
		payment2.setDocStatus(DocAction.STATUS_Drafted);
		payment2.setDocAction(DocAction.ACTION_Complete);
		payment2.setPayAmt(Env.ONEHUNDRED);
		payment2.setTenderType(MPayment.TENDERTYPE_Check);
		payment2.setC_BankAccount_ID(100); // 1234_MoneyBank_123456789
		payment2.setC_Currency_ID(100);  // USD
		Timestamp next2weeks = TimeUtil.addDays(today, 14);
		payment2.setDateTrx(next2weeks);
		payment2.setDateAcct(next2weeks);
		payment2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(payment2, DocAction.ACTION_Complete);
		payment2.load(getTrxName());
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, payment2.getDocStatus());

		invoice.load(getTrxName());
		assertEquals(true, invoice.isPaid());
		assertTrue(Env.ZERO.compareTo(invoice.getOpenAmt()) == 0);
		assertTrue(TWOHUNDRED.compareTo(invoice.getOpenAmt(false, today, true)) == 0);
		assertTrue(Env.ONEHUNDRED.compareTo(invoice.getOpenAmt(false, nextweek, true)) == 0);
		assertTrue(Env.ZERO.compareTo(invoice.getOpenAmt(false, next2weeks, true)) == 0);

		rollback();
	}
}
