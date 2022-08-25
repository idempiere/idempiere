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
import java.util.List;
import java.util.logging.LogRecord;

import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MPayment;
import org.compiere.model.MProduct;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogErrorBuffer;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * @author Carlos Ruiz - globalqss
 */
@Isolated
public class InvoiceCustomerTest extends AbstractTestCase {

	public InvoiceCustomerTest() {
	}

	final static BigDecimal TWOHUNDRED = new BigDecimal("200");

	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-829
	 */
	public void testOpenAmt() {
		int severeCount = 0;
		LogRecord[] errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			severeCount = errorLogs.length;
		
		MBPartner bp = new MBPartner (Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
		DB.getDatabase().forUpdate(bp, 0);
		
		// Invoice $200 today
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id));  // C&W
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);  // Immediate
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);  // Bank Charge
		line1.setQty(new BigDecimal("1"));
		line1.setPrice(Env.ONEHUNDRED);
		line1.saveEx();

		MInvoiceLine line2 = new MInvoiceLine(invoice);
		line2.setLine(20);
		line2.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);  // Commissions Paid
		line2.setQty(new BigDecimal("1"));
		line2.setPrice(Env.ONEHUNDRED);
		line2.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), "Error processing invoice: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice document status is not completed: " + invoice.getDocStatus());
		assertTrue(TWOHUNDRED.compareTo(invoice.getGrandTotal()) == 0, "Invoice grand total not as expected: " + invoice.getGrandTotal().toPlainString());
		assertTrue(invoice.isPosted(), "Invoice not posted");

		// first $100 payment next week
		MPayment payment1 = new MPayment(Env.getCtx(), 0, getTrxName());
		payment1.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment1.setC_BPartner_ID(invoice.getC_BPartner_ID());
		payment1.setC_DocType_ID(true); // Receipt
		payment1.setDocStatus(DocAction.STATUS_Drafted);
		payment1.setDocAction(DocAction.ACTION_Complete);
		payment1.setPayAmt(Env.ONEHUNDRED);
		payment1.setTenderType(MPayment.TENDERTYPE_Check);
		payment1.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id); // 1234_MoneyBank_123456789
		payment1.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);  // USD
		Timestamp nextweek = TimeUtil.addDays(today, 7);
		payment1.setDateTrx(nextweek);
		payment1.setDateAcct(nextweek);
		payment1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Complete);
		payment1.load(getTrxName());
		assertFalse(info.isError(), "Error processing payment: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, payment1.getDocStatus(), "Payment document status is not completed: " + payment1.getDocStatus());
		assertEquals(false, invoice.isPaid(), "Invoice isPaid() is not false");
		assertTrue(payment1.isPosted(), "Payment not posted");
		
		List<PO> postProcessDocs = payment1.getDocsPostProcess();
		for(PO postProcessDoc : postProcessDocs) {
			assertTrue(postProcessDoc.get_ValueAsBoolean("Posted"), "Post Process Doc not posted: " + postProcessDoc);
		}
		
		// second $100 payment next two weeks
		MPayment payment2 = new MPayment(Env.getCtx(), 0, getTrxName());
		payment2.setC_Invoice_ID(invoice.getC_Invoice_ID());
		payment2.setC_BPartner_ID(invoice.getC_BPartner_ID());
		payment2.setC_DocType_ID(true); // Receipt
		payment2.setDocStatus(DocAction.STATUS_Drafted);
		payment2.setDocAction(DocAction.ACTION_Complete);
		payment2.setPayAmt(Env.ONEHUNDRED);
		payment2.setTenderType(MPayment.TENDERTYPE_Check);
		payment2.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id); // 1234_MoneyBank_123456789
		payment2.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);  // USD
		Timestamp next2weeks = TimeUtil.addDays(today, 14);
		payment2.setDateTrx(next2weeks);
		payment2.setDateAcct(next2weeks);
		payment2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(payment2, DocAction.ACTION_Complete);
		payment2.load(getTrxName());
		assertFalse(info.isError(), "Error processing payment: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, payment2.getDocStatus(), "Payment document status is not completed: " + payment2.getDocStatus());
		assertTrue(payment2.isPosted(), "Payment not posted");

		postProcessDocs = payment2.getDocsPostProcess();
		for(PO postProcessDoc : postProcessDocs) {
			assertTrue(postProcessDoc.get_ValueAsBoolean("Posted"), "Post Process Doc not posted: " + postProcessDoc);
		}
		
		invoice.load(getTrxName());
		assertEquals(true, invoice.isPaid(), "Invoice isPaid() is not true");
		assertTrue(Env.ZERO.compareTo(invoice.getOpenAmt()) == 0, "Invoice open amount not zero: " + invoice.getOpenAmt().toPlainString());
		assertTrue(TWOHUNDRED.compareTo(invoice.getOpenAmt(false, today, true)) == 0);
		assertTrue(Env.ONEHUNDRED.compareTo(invoice.getOpenAmt(false, nextweek, true)) == 0);
		assertTrue(Env.ZERO.compareTo(invoice.getOpenAmt(false, next2weeks, true)) == 0);

		errorLogs = CLogErrorBuffer.get(true).getRecords(true);
		if (errorLogs != null)
			assertEquals(severeCount, errorLogs.length, "Severe errors recorded in log: " + errorLogs.length);
		
		rollback();
	}

	@Test
	public void testGenerateInvoiceManual() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		assertEquals(0, line1.getQtyInvoiced().intValue());

		int AD_Process_ID = SystemIDs.PROCESS_C_INVOICE_GENERATE_MANUAL;
		MPInstance instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		String insert = "INSERT INTO T_SELECTION(AD_PINSTANCE_ID, T_SELECTION_ID) Values (?, ?)";
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order.getC_Order_ID()}, null);

		//call process
		ProcessInfo pi = new ProcessInfo ("InvoiceGenerateManual", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Add Parameter - Selection=Y
		MPInstancePara ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();

		ServerProcessCtl processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();

		assertFalse(pi.isError(), pi.getSummary());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyInvoiced().intValue());
	}

	@Test
	public void testInvoiceGenerateRMAManual() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.setSalesRep_ID(getAD_User_ID());
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());

		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();

		//shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());

		//invoice
		MInvoice invoice = new MInvoice(shipment, today);
		invoice.saveEx();
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setShipLine(shipmentLine);
		invoiceLine.setQty(new BigDecimal("1"));
		invoiceLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());

		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
		assertEquals(1, line1.getQtyInvoiced().intValue());

		//rma
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setInOut_ID(shipment.get_ID());
		rma.setC_BPartner_ID(shipment.getC_BPartner_ID());
		rma.setC_Currency_ID(order.getC_Currency_ID());
		rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
		rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
		rma.setSalesRep_ID(order.getSalesRep_ID());
		rma.setIsSOTrx(true);
		rma.setName("testInvoiceGenerateRMAManual");
		rma.saveEx();

		MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
		rmaLine.setM_RMA_ID(rma.get_ID());
		rmaLine.setM_InOutLine_ID(shipmentLine.get_ID());
		rmaLine.setM_Product_ID(shipmentLine.getM_Product_ID());
		rmaLine.setQty(new BigDecimal("1"));
		rmaLine.saveEx();
		assertEquals(0, rmaLine.getQtyInvoiced().intValue());

		info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		rma.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());

		int AD_Process_ID = SystemIDs.PROCESS_C_INVOICE_GENERATERMA_MANUAL;
		MPInstance instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		String insert = "INSERT INTO T_SELECTION(AD_PINSTANCE_ID, T_SELECTION_ID) Values (?, ?)";
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), rma.get_ID()}, null);

		//call process
		ProcessInfo pi = new ProcessInfo ("InvoiceGenerateRMAManual", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Add Parameter - Selection=Y
		MPInstancePara ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();

		ServerProcessCtl processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();

		assertFalse(pi.isError(), pi.getSummary());
		rmaLine.load(getTrxName());
		assertEquals(1, rmaLine.getQtyInvoiced().intValue());
	}
}
