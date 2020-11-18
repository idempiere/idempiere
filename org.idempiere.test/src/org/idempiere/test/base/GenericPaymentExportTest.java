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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.fail;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;

import org.compiere.model.MBPartner;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPaySelectionLine;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.GenericPaymentExport;
import org.compiere.util.Ini;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class GenericPaymentExportTest extends AbstractTestCase {

	public GenericPaymentExportTest() {
	}

	@Test
	public void testGenericPaymentExport() {
		if (DB.isPostgreSQL())
			Ini.setProperty("PostgreSQLNative", "Y");
		
		int seedFarm=120; 
		int moneyBankCheckAccount=100;
		int commissionCharge=101;
		
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());	
		invoice.setIsSOTrx(false);		
		invoice.setC_DocTypeTarget_ID();
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID());
		invoice.setBPartner(new MBPartner(Env.getCtx(), seedFarm, getTrxName()));
		invoice.setDateInvoiced(TimeUtil.getDay(System.currentTimeMillis()));
		invoice.setGrandTotal(new BigDecimal("10.00"));
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		MInvoiceLine il = new MInvoiceLine(invoice);
		il.setLine(10);
		il.setC_Charge_ID(commissionCharge);
		il.setPrice(new BigDecimal("10.00"));
		il.saveEx();
		
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(pi.isError());
		
		String paymentRule = MPaySelectionLine.PAYMENTRULE_Check;
		MPaySelection ps = new MPaySelection(Env.getCtx(), 0, getTrxName());
		ps.setAD_Org_ID(getAD_Org_ID());
		ps.setC_BankAccount_ID(moneyBankCheckAccount);
		ps.setPayDate(TimeUtil.getDay(System.currentTimeMillis()));
		ps.setName("Test@" + System.currentTimeMillis());
		ps.setTotalAmt(new BigDecimal("10.00"));
		ps.saveEx();
		
		MPaySelectionLine psl = new MPaySelectionLine(ps, 10, paymentRule);
		psl.setIsSOTrx(false);
		psl.setPayAmt(ps.getTotalAmt());
		psl.setDifferenceAmt(BigDecimal.ZERO);
		psl.setDiscountAmt(BigDecimal.ZERO);
		psl.setOpenAmt(ps.getTotalAmt());
		psl.setWriteOffAmt(BigDecimal.ZERO);
		psl.setC_Invoice_ID(invoice.getC_Invoice_ID());
		psl.saveEx();
		
		MPaySelectionCheck psc = new MPaySelectionCheck(psl, paymentRule);
		psc.saveEx();
		
		GenericPaymentExport export = new GenericPaymentExport();
		StringBuffer err = new StringBuffer();
		File file = null;
		try {
			file = File.createTempFile("GenericPaymentExportTest", "csv");
		} catch (IOException e) {
			fail(e);
			return;
		}
		int noOfLines = export.exportToFile(new MPaySelectionCheck[] {psc}, false, MPaySelectionCheck.PAYMENTRULE_Check, file, err);
		assertEquals(2, noOfLines);
	}
}
