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
 * - Elaine Tan - etantg       								   		   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Calendar;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MBPartner;
import org.compiere.model.MBankAccount;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.MFactAcct;
import org.compiere.model.MPayment;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Elaine Tan - etantg
 */
public class AllocationTest extends AbstractTestCase {

	public AllocationTest() {
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4696
	 */
	public void testPaymentReversePosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), 114); // Tree Farm Inc.
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		Timestamp date2 = currentDate;
		
		int C_ConversionType_ID = 201; // Company
		
		MCurrency usd = MCurrency.get(100); // USD
		MCurrency euro = MCurrency.get("EUR"); // EUR
		BigDecimal eurToUsd1 = new BigDecimal(30);
		MConversionRate cr1 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date1, eurToUsd1, false);
		
		BigDecimal eurToUsd2 = new BigDecimal(31);
		MConversionRate cr2 = createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, date2, eurToUsd2, false);
		
		try {
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(Env.getCtx(),MBankAccount.Table_Name, whereClause, getTrxName())
					.setParameters(Env.getAD_Org_ID(Env.getCtx()), usd.getC_Currency_ID())
					.setOrderBy("IsDefault DESC")
					.first();
			assertTrue(ba != null, "@NoAccountOrgCurrency@");
			
			BigDecimal payAmt = new BigDecimal(1000);
			MPayment payment = createReceiptPayment(bpartner.getC_BPartner_ID(), ba.getC_BankAccount_ID(), date1, euro.getC_Currency_ID(), C_ConversionType_ID, payAmt);
			completeDocument(payment);
			postDocument(payment);
			
			reverseAccrualDocument(payment);
			MPayment reversalPayment = new MPayment(Env.getCtx(), payment.getReversal_ID(), getTrxName());
			postDocument(reversalPayment);
			
			MAllocationHdr[] allocations = MAllocationHdr.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), getTrxName());
			assertTrue(allocations.length == 1);
			
			MAllocationHdr allocation = allocations[0];
			postDocument(allocation);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			for (MAcctSchema as : ass) {
				if (as.getC_Currency_ID() != usd.getC_Currency_ID())
					continue;
				
				Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocation.get_ID(), getTrxName());
				doc.setC_BankAccount_ID(ba.getC_BankAccount_ID());
				MAccount acctUC = doc.getAccount(Doc.ACCTTYPE_UnallocatedCash, as);
				MAccount acctLoss = MAccount.get(as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
				BigDecimal ucAmtAcctDr = new BigDecimal(30000);
				BigDecimal ucAmtAcctCr = new BigDecimal(31000);
				BigDecimal lossAmtAcct = new BigDecimal(1000);
				
				whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MAllocationHdr.Table_ID 
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + allocation.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + as.getC_AcctSchema_ID();
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (acctUC.getAccount_ID() == fa.getAccount_ID()) {
						if (fa.getAmtAcctDr().signum() != 0)
							assertTrue(fa.getAmtAcctDr().compareTo(ucAmtAcctDr) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + ucAmtAcctDr.toPlainString());						
						else if (fa.getAmtAcctCr().signum() != 0)
							assertTrue(fa.getAmtAcctCr().compareTo(ucAmtAcctCr) == 0, fa.getAmtAcctCr().toPlainString() + "!=" + ucAmtAcctCr.toPlainString());													
					}
					else if (acctLoss.getAccount_ID() == fa.getAccount_ID())
						assertTrue(fa.getAmtAcctDr().compareTo(lossAmtAcct) == 0, fa.getAmtAcctDr().toPlainString() + "!=" + lossAmtAcct.toPlainString());
				}
			}
			
		} finally {
			deleteConversionRate(cr1);
			deleteConversionRate(cr2);
			
			rollback();
		}
	}
	
	private MConversionRate createConversionRate(int C_Currency_ID, int C_Currency_ID_To, int C_ConversionType_ID, 
			Timestamp date, BigDecimal rate, boolean isMultiplyRate) {
		MConversionRate cr = new MConversionRate(Env.getCtx(), 0, null);
		cr.setC_Currency_ID(C_Currency_ID);
		cr.setC_Currency_ID_To(C_Currency_ID_To);
		cr.setC_ConversionType_ID(C_ConversionType_ID);
		cr.setValidFrom(date);
		cr.setValidTo(date);
		if (isMultiplyRate)
			cr.setMultiplyRate(rate);
		else
			cr.setDivideRate(rate);
		cr.saveEx();
		return cr;
	}
	
	private void deleteConversionRate(MConversionRate cr) {
		String whereClause = "ValidFrom=? AND ValidTo=? "
				+ "AND C_Currency_ID=? AND C_Currency_ID_To=? "
				+ "AND C_ConversionType_ID=? "
				+ "AND AD_Client_ID=? AND AD_Org_ID=?";
		MConversionRate reciprocal = new Query(Env.getCtx(), MConversionRate.Table_Name, whereClause, null)
				.setParameters(cr.getValidFrom(), cr.getValidTo(), 
						cr.getC_Currency_ID_To(), cr.getC_Currency_ID(),
						cr.getC_ConversionType_ID(),
						cr.getAD_Client_ID(), cr.getAD_Org_ID())
				.firstOnly();
		if (reciprocal != null)
			reciprocal.deleteEx(true);
		cr.deleteEx(true);
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
	
	private void completeDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Completed, docStatus, DocAction.STATUS_Completed + " != " + docStatus);
	}
	
	private void reverseAccrualDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Reverse_Accrual);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Reversed, docStatus, DocAction.STATUS_Reversed + " != " + docStatus);
	}
	
	private void postDocument(PO po) {
		if (!po.get_ValueAsBoolean("Posted")) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), po.getAD_Client_ID(), po.get_Table_ID(), po.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		po.load(getTrxName());
		assertTrue(po.get_ValueAsBoolean("Posted"));
	}
	
	
}
