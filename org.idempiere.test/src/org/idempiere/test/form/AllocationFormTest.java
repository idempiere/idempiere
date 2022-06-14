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
package org.idempiere.test.form;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Vector;

import org.compiere.apps.form.Allocation;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MBPartner;
import org.compiere.model.MBankAccount;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPayment;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.ui.MiniTableImpl;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class AllocationFormTest extends AbstractTestCase {

	/**
	 *  default constructor
	 */
	public AllocationFormTest() {
	}

	@Test
	/**
	 * test basic invoice allocation with multi currency and auto writeoff off.
	 */
	public void testInvoiceAllocation1() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		MInvoice invoice = createCustomerInvoice(today,  today,
				bpartner.getC_BPartner_ID(), DictionaryIDs.C_PaymentTerm.IMMEDIATE.id, DictionaryIDs.C_Tax.EXEMPT.id, Env.ONEHUNDRED);
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id);

		String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
		MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
				.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
				.setOrderBy("IsDefault DESC")
				.first();
		assertTrue(ba != null, "@NoAccountOrgCurrency@");
		MPayment payment = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), today, usd.getC_Currency_ID(), 0, Env.ONEHUNDRED);
		pi = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		IMiniTable paymentTable = new MiniTableImpl();
		IMiniTable invoiceTable = new MiniTableImpl();
		
		boolean multiCurrency = false;
		Allocation allocation = new Allocation();
		allocation.setC_BPartner_ID(bpartner.get_ID());
		allocation.setC_Currency_ID(usd.get_ID());
		Vector<String> paymentColumns = allocation.getPaymentColumnNames(multiCurrency);
		for(String column : paymentColumns) {
			paymentTable.addColumn(column);
		}
		allocation.setPaymentColumnClass(paymentTable, multiCurrency);
		
		Vector<String> invoiceColumns = allocation.getInvoiceColumnNames(multiCurrency);
		for(String column : invoiceColumns) {
			invoiceTable.addColumn(column);
		}
		allocation.setInvoiceColumnClass(invoiceTable, multiCurrency);
		
		//load payment table
		Vector<Vector<Object>> paymentDatas = allocation.getPaymentData(multiCurrency, today, getTrxName());
		loadTable(paymentTable, paymentDatas);
		assertTrue(paymentTable.getRowCount() >= 1, "Failed to retrieve unallocated payment data");
		
		//load invoice table
		Vector<Vector<Object>> invoiceDatas = allocation.getInvoiceData(multiCurrency, today, getTrxName());
		loadTable(invoiceTable, invoiceDatas);
		assertTrue(invoiceTable.getRowCount() >= 1, "Failed to retrieve unpaided invoice data");
				
		allocation.calculate(paymentTable, invoiceTable, multiCurrency);
		
		for (int i = 0; i < paymentTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) paymentTable.getValueAt(i, MPayment.UNALLOCATED_PAYMENT_DOCUMENT_KEY_NAME_PAIR);
			if (knp.getKey() == payment.get_ID()) {
				paymentTable.setValueAt(Boolean.TRUE, i, MPayment.UNALLOCATED_PAYMENT_SELECTED);
				((MiniTableImpl)paymentTable).setSelectedRow(i);
				break;
			}
		}
		assertTrue(paymentTable.getSelectedRow() >= 0, "Failed to locate open payment created");
		
		allocation.writeOff(paymentTable.getSelectedRow(), 0, false, paymentTable, invoiceTable, false);
		allocation.calculate(paymentTable, invoiceTable, multiCurrency);		
		assertEquals(payment.getPayAmt().setScale(2, RoundingMode.HALF_UP), allocation.getPaymentAppliedTotal().setScale(2, RoundingMode.HALF_UP), "Unexpected Payment Applied Total");
		assertEquals(payment.getPayAmt().setScale(2, RoundingMode.HALF_UP), allocation.getTotalDifference().setScale(2, RoundingMode.HALF_UP), "Unexpected Total Applied Difference");
		
				
		for (int i = 0; i < invoiceTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) invoiceTable.getValueAt(i, MInvoice.UNPAID_INVOICE_DOCUMENT_KEY_NAME_PAIR);
			if (knp.getKey() == invoice.get_ID()) {
				invoiceTable.setValueAt(Boolean.TRUE, i, MInvoice.UNPAID_INVOICE_SELECTED);
				((MiniTableImpl)invoiceTable).setSelectedRow(i);
				invoiceTable.setValueAt(new BigDecimal("0.00"), i, MInvoice.UNPAID_INVOICE_SINGLE_CURRENCY_DISCOUNT_AMT);
				break;
			}
		}
		assertTrue(invoiceTable.getSelectedRow() >= 0, "Failed to locate open invoice created");
		allocation.writeOff(invoiceTable.getSelectedRow(), 0, true, paymentTable, invoiceTable, false);
		allocation.calculate(paymentTable, invoiceTable, multiCurrency);		
		assertEquals(invoice.getGrandTotal().setScale(2, RoundingMode.HALF_UP), allocation.getInvoiceAppliedTotal().setScale(2, RoundingMode.HALF_UP), "Unexpected Invoice Applied Total");
		assertEquals(new BigDecimal("0.00"), allocation.getTotalDifference().setScale(2, RoundingMode.HALF_UP), "Unexpected Total Applied Difference");
		assertTrue(allocation.isOkToAllocate(), "Invoice and payment applied total is different: " + allocation.getTotalDifference().toPlainString());
		
		MAllocationHdr allocationHdr = allocation.saveData(0, today, paymentTable, invoiceTable, getTrxName());
		assertNotNull(allocationHdr, "Failed to create allocation header");
	}

	@Test
	/**
	 * test basic invoice allocation with multi currency on and auto writeoff off.
	 */
	public void testInvoiceAllocation2() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		MInvoice invoice = createCustomerInvoice(today,  today,
				bpartner.getC_BPartner_ID(), DictionaryIDs.C_PaymentTerm.IMMEDIATE.id, DictionaryIDs.C_Tax.EXEMPT.id, Env.ONEHUNDRED);
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id);

		String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
		MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
				.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
				.setOrderBy("IsDefault DESC")
				.first();
		assertTrue(ba != null, "@NoAccountOrgCurrency@");
		MPayment payment = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), today, usd.getC_Currency_ID(), 0, Env.ONEHUNDRED);
		pi = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		IMiniTable paymentTable = new MiniTableImpl();
		IMiniTable invoiceTable = new MiniTableImpl();
		
		boolean multiCurrency = true;
		Allocation allocation = new Allocation();
		allocation.setC_BPartner_ID(bpartner.get_ID());
		allocation.setC_Currency_ID(usd.get_ID());
		Vector<String> paymentColumns = allocation.getPaymentColumnNames(multiCurrency);
		for(String column : paymentColumns) {
			paymentTable.addColumn(column);
		}
		allocation.setPaymentColumnClass(paymentTable, multiCurrency);
		
		Vector<String> invoiceColumns = allocation.getInvoiceColumnNames(multiCurrency);
		for(String column : invoiceColumns) {
			invoiceTable.addColumn(column);
		}
		allocation.setInvoiceColumnClass(invoiceTable, multiCurrency);
		
		//load payment table
		Vector<Vector<Object>> paymentDatas = allocation.getPaymentData(multiCurrency, today, getTrxName());
		loadTable(paymentTable, paymentDatas);
		assertTrue(paymentTable.getRowCount() >= 1, "Failed to retrieve unallocated payment data");
		
		//load invoice table
		Vector<Vector<Object>> invoiceDatas = allocation.getInvoiceData(multiCurrency, today, getTrxName());
		loadTable(invoiceTable, invoiceDatas);
		assertTrue(invoiceTable.getRowCount() >= 1, "Failed to retrieve unpaided invoice data");
				
		allocation.calculate(paymentTable, invoiceTable, multiCurrency);
		
		for (int i = 0; i < paymentTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) paymentTable.getValueAt(i, MPayment.UNALLOCATED_PAYMENT_DOCUMENT_KEY_NAME_PAIR);
			if (knp.getKey() == payment.get_ID()) {
				paymentTable.setValueAt(Boolean.TRUE, i, MPayment.UNALLOCATED_PAYMENT_SELECTED);
				((MiniTableImpl)paymentTable).setSelectedRow(i);
				break;
			}
		}
		assertTrue(paymentTable.getSelectedRow() >= 0, "Failed to locate open payment created");
		
		allocation.writeOff(paymentTable.getSelectedRow(), 0, false, paymentTable, invoiceTable, false);
		allocation.calculate(paymentTable, invoiceTable, multiCurrency);		
		assertEquals(payment.getPayAmt().setScale(2, RoundingMode.HALF_UP), allocation.getPaymentAppliedTotal().setScale(2, RoundingMode.HALF_UP), "Unexpected Payment Applied Total");
		assertEquals(payment.getPayAmt().setScale(2, RoundingMode.HALF_UP), allocation.getTotalDifference().setScale(2, RoundingMode.HALF_UP), "Unexpected Total Applied Difference");
		
				
		for (int i = 0; i < invoiceTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) invoiceTable.getValueAt(i, MInvoice.UNPAID_INVOICE_DOCUMENT_KEY_NAME_PAIR);
			if (knp.getKey() == invoice.get_ID()) {
				invoiceTable.setValueAt(Boolean.TRUE, i, MInvoice.UNPAID_INVOICE_SELECTED);
				((MiniTableImpl)invoiceTable).setSelectedRow(i);
				invoiceTable.setValueAt(new BigDecimal("0.00"), i, MInvoice.UNPAID_INVOICE_MULTI_CURRENCY_CONVERTED_DISCOUNT_AMT);
				break;
			}
		}
		assertTrue(invoiceTable.getSelectedRow() >= 0, "Failed to locate open invoice created");
		allocation.writeOff(invoiceTable.getSelectedRow(), 0, true, paymentTable, invoiceTable, false);
		allocation.calculate(paymentTable, invoiceTable, multiCurrency);		
		assertEquals(invoice.getGrandTotal().setScale(2, RoundingMode.HALF_UP), allocation.getInvoiceAppliedTotal().setScale(2, RoundingMode.HALF_UP), "Unexpected Invoice Applied Total");
		assertEquals(new BigDecimal("0.00"), allocation.getTotalDifference().setScale(2, RoundingMode.HALF_UP), "Unexpected Total Applied Difference");
		assertTrue(allocation.isOkToAllocate(), "Invoice and payment applied total is different: " + allocation.getTotalDifference().toPlainString());
		
		MAllocationHdr allocationHdr = allocation.saveData(0, today, paymentTable, invoiceTable, getTrxName());
		assertNotNull(allocationHdr, "Failed to create allocation header");
	}
	
	private void loadTable(IMiniTable miniTable, Vector<Vector<Object>> datas) {
		int row=0;
		for(Vector<Object> data : datas) {			
			miniTable.setRowCount(row+1);
			int column = 0;
			for(Object value : data) {
				miniTable.setValueAt(value, row, column);
				column++;
			}
			row++;
		}
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
	
	private MInvoice createCustomerInvoice(Timestamp dateinvoiced,  Timestamp dateacct,
			int bpartnerid, int payterm, int taxid, BigDecimal totallines) {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setC_DocType_ID(DictionaryIDs.C_DocType.AR_INVOICE.id); //AR Invoice
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_BPartner_ID(bpartnerid);
		invoice.setDateInvoiced(dateinvoiced);
		invoice.setDateAcct(dateacct);
		invoice.setC_PaymentTerm_ID(payterm);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
		line1.setQty(new BigDecimal("1"));
		line1.setPrice(totallines);
		line1.setC_Tax_ID(taxid);
		line1.saveEx();

		return invoice;
	}
}
