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
 * - Logilite Technologies                                             *
 **********************************************************************/
package org.idempiere.test.process;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import org.compiere.model.MBPartner;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MInvoicePaySchedule;
import org.compiere.model.MPInstance;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionLine;
import org.compiere.model.MProcess;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * IDEMPIERE-7188 Tests for {@link org.compiere.process.PaySelectionCreateFromInfoWindow}
 */
public class PaySelectionCreateFromInfoWindowTest extends AbstractTestCase {

	private static final String PROCESS_VALUE = "PaySelectionCreateFromInfoWindow";

	/**
	 * Only the selected invoice gets a payment selection line.
	 */
	@Test
	public void testCreateLinesForSelectedInvoiceOnly() {
		MInvoice selected = createCompletedVendorInvoice(new BigDecimal("10"));
		MInvoice notSelected = createCompletedVendorInvoice(new BigDecimal("20"));

		ProcessInfo pi = runProcess(List.of(-selected.getC_Invoice_ID()), MInvoice.PAYMENTRULE_Check);
		assertFalse(pi.isError(), pi.getSummary());

		int paySelectionID = DB.getSQLValueEx(getTrxName(),
				"SELECT MAX(C_PaySelection_ID) FROM C_PaySelectionLine WHERE C_Invoice_ID=?", selected.getC_Invoice_ID());
		assertTrue(paySelectionID > 0, "Payment selection line not created for selected invoice");

		List<MPaySelectionLine> lines = new Query(Env.getCtx(), MPaySelectionLine.Table_Name, MPaySelection.COLUMNNAME_C_PaySelection_ID + "=?", getTrxName())
				.setParameters(paySelectionID)
				.list();
		assertEquals(1, lines.size(), "Unexpected number of payment selection lines");
		assertEquals(selected.getC_Invoice_ID(), lines.get(0).getC_Invoice_ID());
		assertFalse(lines.get(0).isSOTrx(), "Vendor invoice line must not be a sales transaction");
		assertTrue(lines.stream().noneMatch(l -> l.getC_Invoice_ID() == notSelected.getC_Invoice_ID()));
	}

	/**
	 * Direct Debit only applies to customer invoices; a vendor invoice must be rejected.
	 */
	@Test
	public void testDirectDebitRejectsVendorInvoice() {
		MInvoice invoice = createCompletedVendorInvoice(new BigDecimal("10"));

		ProcessInfo pi = runProcess(List.of(-invoice.getC_Invoice_ID()), MInvoice.PAYMENTRULE_DirectDebit);
		assertTrue(pi.isError(), "Direct Debit must not accept a vendor invoice");
	}

	/**
	 * For an invoice with multi-installment payment schedule (using built-in 50% Immediate / 50% in 30 days),
	 * selecting only the 1st scheduled installment creates a payment selection line for that installment amount only.
	 */
	@Test
	public void testPayFirstScheduledPayment() {
		// Invoice of 100 USD (Schedule 1 = 50 USD, Schedule 2 = 50 USD)
		MInvoice invoice = createCompletedVendorInvoice(new BigDecimal("100"), DictionaryIDs.C_PaymentTerm.FIFTY_IMMEDIATE_FIFTY_30DAYS.id);

		// Verify 2 payment schedule lines were generated on completion
		List<MInvoicePaySchedule> schedules = new Query(Env.getCtx(), MInvoicePaySchedule.Table_Name,
				"C_Invoice_ID = ?", getTrxName())
				.setParameters(invoice.getC_Invoice_ID())
				.setOrderBy(MInvoicePaySchedule.COLUMNNAME_C_InvoicePaySchedule_ID)
				.list();
		assertEquals(2, schedules.size(), "Expected 2 invoice pay schedule lines");
		MInvoicePaySchedule schedule1 = schedules.get(0);
		MInvoicePaySchedule schedule2 = schedules.get(1);

		assertEquals(0, new BigDecimal("50.00").compareTo(schedule1.getDueAmt()), "Schedule 1 due amount must be 50.00");
		assertEquals(0, new BigDecimal("50.00").compareTo(schedule2.getDueAmt()), "Schedule 2 due amount must be 50.00");

		// Select ONLY the 1st scheduled payment (positive C_InvoicePaySchedule_ID in Info Window key)
		ProcessInfo pi = runProcess(List.of(schedule1.getC_InvoicePaySchedule_ID()), MInvoice.PAYMENTRULE_Check);
		assertFalse(pi.isError(), pi.getSummary());

		int paySelectionID = DB.getSQLValueEx(getTrxName(),
				"SELECT MAX(C_PaySelection_ID) FROM C_PaySelectionLine WHERE C_Invoice_ID=?", invoice.getC_Invoice_ID());
		assertTrue(paySelectionID > 0, "Payment selection line not created for selected schedule");

		List<MPaySelectionLine> lines = new Query(Env.getCtx(), MPaySelectionLine.Table_Name,
				MPaySelection.COLUMNNAME_C_PaySelection_ID + "=?", getTrxName())
				.setParameters(paySelectionID)
				.list();
		assertEquals(1, lines.size(), "Only 1 payment selection line should be created for the selected schedule");

		MPaySelectionLine line = lines.get(0);
		assertEquals(invoice.getC_Invoice_ID(), line.getC_Invoice_ID());
		// Open amount for schedule 1 is 50.00 (not the entire invoice total 100.00)
		assertEquals(0, new BigDecimal("50.00").compareTo(line.getOpenAmt()), "Expected open amount 50.00");
		assertEquals(0, schedule1.getDiscountAmt().compareTo(line.getDiscountAmt()), "Discount amount must match schedule discount");
		assertEquals(0, schedule1.getDueAmt().subtract(schedule1.getDiscountAmt()).compareTo(line.getPayAmt()), "Expected pay amount matching schedule");
		assertEquals(0, BigDecimal.ZERO.compareTo(line.getDifferenceAmt()), "Expected difference amount 0.00");
	}

	private MInvoice createCompletedVendorInvoice(BigDecimal price) {
		return createCompletedVendorInvoice(price, DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
	}

	private MInvoice createCompletedVendorInvoice(BigDecimal price, int paymentTermID) {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		invoice.setIsSOTrx(false);
		invoice.setC_DocTypeTarget_ID();
		invoice.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_OnCredit);
		invoice.setC_PaymentTerm_ID(paymentTermID);
		invoice.setDateAcct(TimeUtil.getDay(System.currentTimeMillis()));
		invoice.setDateOrdered(invoice.getDateAcct());
		invoice.saveEx();

		MInvoiceLine line = new MInvoiceLine(invoice);
		line.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		line.setQty(BigDecimal.ONE);
		line.setPrice(price);
		line.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		return invoice;
	}

	private ProcessInfo runProcess(List<Integer> selectedKeys, String paymentRule) {
		int processId = MProcess.getProcess_ID(PROCESS_VALUE, getTrxName());
		assertTrue(processId > 0, "Process not found: " + PROCESS_VALUE);
		MProcess process = MProcess.get(Env.getCtx(), processId);

		MPInstance instance = new MPInstance(Env.getCtx(), processId, 0, 0, null);
		instance.saveEx();
		DB.createT_Selection(instance.getAD_PInstance_ID(), selectedKeys, getTrxName());

		Timestamp payDate = TimeUtil.getDay(System.currentTimeMillis());
		ProcessInfo pi = new ProcessInfo(process.getName(), processId);
		pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setTransactionName(getTrxName());
		pi.setParameter(new ProcessInfoParameter[] {
			new ProcessInfoParameter("C_BankAccount_ID", BigDecimal.valueOf(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id), null, null, null),
			new ProcessInfoParameter("PayDate", payDate, null, null, null),
			new ProcessInfoParameter("PaymentRule", paymentRule, null, null, null),
			new ProcessInfoParameter(MPaySelection.COLUMNNAME_IsOnePaymentPerInvoice, "N", null, null, null),
			new ProcessInfoParameter("IsCreatePayments", "N", null, null, null)
		});
		ServerProcessCtl.process(pi, getTrx(), false);
		return pi;
	}
}
