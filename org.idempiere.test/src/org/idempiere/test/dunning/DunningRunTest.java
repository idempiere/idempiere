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

package org.idempiere.test.dunning;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MDunningLevel;
import org.compiere.model.MDunningRun;
import org.compiere.model.MDunningRunEntry;
import org.compiere.model.MDunningRunLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
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
public class DunningRunTest extends AbstractTestCase {

	private static final int PROCESS_DUNNING_RUN_CREATE = 289;

	/**
	 * 
	 */
	public DunningRunTest() {
	}

	@Test
	public void testDunning10DaysDue() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		MDunningLevel dl = new MDunningLevel(ctx, DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id, trxName);
		// change to due invoices after 10 days due
		dl.setDaysAfterDue(BigDecimal.valueOf(10.0));
		dl.setIsShowAllDue(false);
		dl.setName("Dun all due invoices after 10 days due");
		dl.saveEx();

		// create an invoice for GardenUser
		MInvoice invoice = new MInvoice(ctx, 0, trxName);
		invoice.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		invoice.setDateInvoiced(TimeUtil.addDays(today, -30)); // date 30 days ago
		invoice.setDateAcct(TimeUtil.addDays(today, -30));
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.NET_30_DAYS.id); // payment term 30 days, so the invoice is due exactly today
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

		// create a dunning run today for the 10 days level
		MDunningRun dr = new MDunningRun(ctx, 0, trxName);
		dr.setDunningDate(today);
		dr.setC_Dunning_ID(DictionaryIDs.C_Dunning.DEFAULT.id);
		dr.setC_DunningLevel_ID(DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id);
		dr.saveEx();

		// Run the process Dunning Run Create
		MProcess process = MProcess.get(PROCESS_DUNNING_RUN_CREATE);
		MPInstance pinstance = new MPInstance(process, 0);
		MPInstancePara[] paras = pinstance.getParameters();
		for (MPInstancePara para : paras) {
			if (para.getParameterName().equals("AD_Org_ID")) {
				para.setP_Number(DictionaryIDs.AD_Org.GLOBAL.id);
				para.saveEx();
			} else if (para.getParameterName().equals("IncludeInDispute")) {
				para.setP_String("N");
				para.saveEx();
			} else if (para.getParameterName().equals("OnlySOTrx")) {
				para.setP_String("Y");
				para.saveEx();
			} else if (para.getParameterName().equals("SalesRep_ID")) {
				para.setP_Number(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
				para.saveEx();
			} else if (para.getParameterName().equals("C_Currency_ID")) {
				para.setP_Number(DictionaryIDs.C_Currency.USD.id);
				para.saveEx();
			} else if (para.getParameterName().equals("IsAllCurrencies")) {
				para.setP_String("Y");
				para.saveEx();
			} else if (para.getParameterName().equals("C_BPartner_ID")) {
				para.setP_Number(DictionaryIDs.C_BPartner.C_AND_W.id);
				para.saveEx();
			}
		}
		ProcessInfo pi = new ProcessInfo(process.getName(), PROCESS_DUNNING_RUN_CREATE);
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		pi.setRecord_ID(dr.getC_DunningRun_ID());
		process.processIt(pi, Trx.get(getTrxName(), false), false);
		assertTrue(!pi.isError(), pi.getSummary());

		// The invoice must not be reported in this dunning because the due date is exactly today
		for (MDunningRunEntry dre : dr.getEntries(true)) {
			for (MDunningRunLine drl : dre.getLines()) {
				assertTrue(drl.getC_Invoice_ID() != invoice.getC_Invoice_ID());
			}
		}
	}

}
