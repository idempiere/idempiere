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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.idempiere.test.commission;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MCommission;
import org.compiere.model.MCommissionAmt;
import org.compiere.model.MCommissionLine;
import org.compiere.model.MCommissionRun;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
*
* @author Carlos Ruiz - globalqss - bxservice
*
*/
public class CommissionRunTest extends AbstractTestCase {

	private static final int PROCESS_GENERATE_COMMISSION = 123;

	/**
	 * 
	 */
	public CommissionRunTest() {
	}

	@Test
	public void testCommissionOnInvoice() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		// create a commission to pay GardenUser 10% on own invoices
		MCommission com = new MCommission(ctx, 0, trxName);
		com.setName("Test commission to pay GardenUser 10% on own invoices");
		com.setC_BPartner_ID(DictionaryIDs.C_BPartner.GARDEN_USER.id);
		com.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		com.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		com.setDocBasisType(MCommission.DOCBASISTYPE_Invoice);
		com.setFrequencyType(MCommission.FREQUENCYTYPE_Monthly);
		com.setListDetails(true);
		com.saveEx();

		MCommissionLine coml = new MCommissionLine(ctx, 0, trxName);
		coml.setC_Commission_ID(com.getC_Commission_ID());
		coml.setLine(10);
		coml.setCommissionOrders(true);
		coml.setAmtMultiplier(BigDecimal.valueOf(0.1));  // 10% in GardenUser own invoices
		coml.saveEx();

		// create an invoice for GardenUser
		MInvoice invoice = new MInvoice(ctx, 0, trxName);
		invoice.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		line1.setQty(new BigDecimal("7"));
		line1.setPrice(BigDecimal.valueOf(23.75));
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(trxName);
		assertFalse(info.isError(), "Error processing invoice: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice document status is not completed: " + invoice.getDocStatus());

		// create a credit memo for GardenUser
		MInvoice creditMemo = new MInvoice(ctx, 0, trxName);
		creditMemo.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
		creditMemo.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARCreditMemo);
		creditMemo.setC_DocType_ID(creditMemo.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		creditMemo.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		creditMemo.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		creditMemo.setDateInvoiced(today);
		creditMemo.setDateAcct(today);
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
		creditMemo.saveEx();

		MInvoiceLine line1cm = new MInvoiceLine(creditMemo);
		line1cm.setLine(10);
		line1cm.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		line1cm.setQty(new BigDecimal("2"));
		line1cm.setPrice(BigDecimal.valueOf(23.75));
		line1cm.saveEx();

		ProcessInfo infocm = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		creditMemo.load(trxName);
		assertFalse(infocm.isError(), "Error processing invoice: " + infocm.getSummary());
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus(), "Credit Memo document status is not completed: " + creditMemo.getDocStatus());

		MProcess process = MProcess.get(PROCESS_GENERATE_COMMISSION);
		MPInstance pinstance = new MPInstance(process, 0);
		MPInstancePara[] paras = pinstance.getParameters();
		for (MPInstancePara para : paras) {
			if (para.getParameterName().equals("StartDate")) {
				para.setP_Date(today);
				para.saveEx();
			}
		}
		ProcessInfo pi = new ProcessInfo(process.getName(), PROCESS_GENERATE_COMMISSION);
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		pi.setRecord_ID(com.getC_Commission_ID());
		process.processIt(pi, Trx.get(getTrxName(), false), false);
		assertTrue(!pi.isError(), pi.getSummary());

		ProcessInfoLog[] logs = pi.getLogs();
		MCommissionRun comrun = new MCommissionRun(ctx, logs[0].getRecord_ID(), trxName);
		MCommissionAmt[] amts = comrun.getAmts();
		
		assertTrue(BigDecimal.valueOf(118.75).compareTo(amts[0].getConvertedAmt()) == 0);  // 23.75 * ( 7 - 5 )
		assertTrue(BigDecimal.valueOf(5).compareTo(amts[0].getActualQty()) == 0);          // ( 7 - 5 ) // invoiced minus credit memo
		assertTrue(BigDecimal.valueOf(11.875).compareTo(amts[0].getCommissionAmt()) == 0); // 10%
	}

}
