/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MBPartner;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MProduct;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Invoice Test cases.
 * 
 * @author Logilite Technologies
 * @since  August 07, 2023
 */
public class InvoiceTest extends AbstractTestCase
{

	public InvoiceTest()
	{
	}

	/**
	 * Test cases for Credit Check
	 */
	@Test
	public void testCreditCheckInvoice()
	{
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		// Joe Block
		MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
		bp.setSOCreditStatus(MBPartner.SOCREDITSTATUS_CreditStop);
		bp.saveEx();

		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(bp);
		invoice.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		invoice.setC_DocTypeTarget_ID(MInvoice.DOCBASETYPE_ARInvoice);
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_OnCredit);
		invoice.saveEx();

		MInvoiceLine invoiceLine = new MInvoiceLine(Env.getCtx(), 0, getTrxName());
		invoiceLine.setInvoice(invoice);
		invoiceLine.setC_Invoice_ID(invoice.getC_Invoice_ID());
		invoiceLine.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.FERTILIZER_50.id));
		invoiceLine.setQty(new BigDecimal("1"));
		invoiceLine.saveEx();

		invoice.load(getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Prepare);
		assertTrue(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Invalid, invoice.getDocStatus());

		bp.setSOCreditStatus(MBPartner.SOCREDITSTATUS_NoCreditCheck);
		bp.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
	}
}
