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

import org.compiere.model.MBPartner;
import org.compiere.model.MBankStatement;
import org.compiere.model.MBankStatementLine;
import org.compiere.model.MPayment;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.ResourceLock;

/**
 * @author hengsin
 *
 */
public class BankStatementTest extends AbstractTestCase {

	/**
	 * 
	 */
	public BankStatementTest() {
	}

	@Test
	public void testCompleteStatement() {
		MBankStatement stmt = new MBankStatement(Env.getCtx(), 0, getTrxName());
		stmt.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		stmt.setStatementDate(today);
		stmt.setDateAcct(today);
		stmt.setName(System.currentTimeMillis()+"");
		stmt.setDocAction(DocAction.ACTION_Complete);
		stmt.setDocStatus(DocAction.STATUS_Drafted);
		stmt.saveEx();
		
		MBankStatementLine line = new MBankStatementLine(stmt);
		line.setValutaDate(today);
		line.setStatementLineDate(today);
		line.setStmtAmt(new BigDecimal("10.00"));
		line.setTrxAmt(new BigDecimal("10.00"));
		line.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		line.saveEx();
		
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(stmt, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		stmt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, stmt.getDocStatus());
	}
	
	@Test
	@ResourceLock(value = MSysConfig.ALLOW_REVERSAL_OF_RECONCILED_PAYMENT)
	public void testReversalOfReconciledPayment1() {
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		
		Query query = new Query(Env.getCtx(), MSysConfig.Table_Name, "Name=? AND AD_Client_ID IN (0, ?)", null);
		MSysConfig sysConfig = query.setOrderBy("AD_Client_ID Desc").setParameters(MSysConfig.ALLOW_REVERSAL_OF_RECONCILED_PAYMENT, getAD_Client_ID()).first();
		if (!sysConfig.getValue().equals("Y")) {
			sysConfig.setValue("Y");
			try {
				PO.setCrossTenantSafe();
				sysConfig.saveEx();
			} finally {
				PO.clearCrossTenantSafe();
			}
			CacheMgt.get().reset();
		} else {
			sysConfig = null;
		}
		
		try {
			MBPartner bp = new MBPartner (Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
			DB.getDatabase().forUpdate(bp, 0);
			
			MPayment payment1 = new MPayment(Env.getCtx(), 0, getTrxName());
			payment1.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id); //C&W
			payment1.setC_DocType_ID(true); // Receipt
			payment1.setDocStatus(DocAction.STATUS_Drafted);
			payment1.setDocAction(DocAction.ACTION_Complete);
			payment1.setPayAmt(Env.ONEHUNDRED);
			payment1.setTenderType(MPayment.TENDERTYPE_Check);
			payment1.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id); // 1234_MoneyBank_123456789
			payment1.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);  // USD
			payment1.setDateTrx(today);
			payment1.setDateAcct(today);
			payment1.saveEx();
			
			ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Complete);
			payment1.load(getTrxName());
			assertFalse(pi.isError(), "Error processing payment: " + pi.getSummary());
			assertEquals(DocAction.STATUS_Completed, payment1.getDocStatus(), "Payment document status is not completed: " + payment1.getDocStatus());
			
			MBankStatement stmt = new MBankStatement(Env.getCtx(), 0, getTrxName());
			stmt.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);		
			stmt.setStatementDate(today);
			stmt.setDateAcct(today);
			stmt.setName(System.currentTimeMillis()+"");
			stmt.setDocAction(DocAction.ACTION_Complete);
			stmt.setDocStatus(DocAction.STATUS_Drafted);
			stmt.saveEx();
			
			MBankStatementLine line = new MBankStatementLine(stmt);
			line.setValutaDate(today);
			line.setStatementLineDate(today);
			line.setStmtAmt(payment1.getPayAmt());
			line.setTrxAmt(payment1.getPayAmt());
			line.setC_Payment_ID(payment1.getC_Payment_ID());
			line.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			line.saveEx();
			
			pi = MWorkflow.runDocumentActionWorkflow(stmt, DocAction.ACTION_Complete);
			assertFalse(pi.isError(), pi.getSummary());
			
			stmt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, stmt.getDocStatus());
			
			payment1.load(getTrxName());
			payment1.setDocAction(DocAction.ACTION_Reverse_Correct);
			payment1.saveEx();
			pi = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Reverse_Correct);		
			assertFalse(pi.isError(), "Error reversing payment: " + pi.getSummary());
			assertEquals(DocAction.STATUS_Reversed, payment1.getDocStatus(), "Unexpected Payment Document Status");
		} finally {
			if (sysConfig != null) {
				sysConfig.setValue("N");
				try {
					PO.setCrossTenantSafe();
					sysConfig.saveEx();
				} finally {
					PO.clearCrossTenantSafe();
				}
			}
		}
	}
	
	@Test
	@ResourceLock(value = MSysConfig.ALLOW_REVERSAL_OF_RECONCILED_PAYMENT)
	public void testReversalOfReconciledPayment2() {
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		
		Query query = new Query(Env.getCtx(), MSysConfig.Table_Name, "Name=? AND AD_Client_ID IN (0, ?)", null);
		MSysConfig sysConfig = query.setOrderBy("AD_Client_ID Desc").setParameters(MSysConfig.ALLOW_REVERSAL_OF_RECONCILED_PAYMENT, getAD_Client_ID()).first();
		if (!sysConfig.getValue().equals("N")) {
			sysConfig.setValue("N");
			try {
				PO.setCrossTenantSafe();
				sysConfig.saveEx();
			} finally {
				PO.clearCrossTenantSafe();
			}
			CacheMgt.get().reset();
		} else {
			sysConfig = null;
		}
		try {
			MBPartner bp = new MBPartner (Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
			DB.getDatabase().forUpdate(bp, 0);
			
			MPayment payment1 = new MPayment(Env.getCtx(), 0, getTrxName());
			payment1.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id); //C&W
			payment1.setC_DocType_ID(true); // Receipt
			payment1.setDocStatus(DocAction.STATUS_Drafted);
			payment1.setDocAction(DocAction.ACTION_Complete);
			payment1.setPayAmt(Env.ONEHUNDRED);
			payment1.setTenderType(MPayment.TENDERTYPE_Check);
			payment1.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id); // 1234_MoneyBank_123456789
			payment1.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);  // USD
			payment1.setDateTrx(today);
			payment1.setDateAcct(today);
			payment1.saveEx();
			
			ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Complete);
			payment1.load(getTrxName());
			assertFalse(pi.isError(), "Error processing payment: " + pi.getSummary());
			assertEquals(DocAction.STATUS_Completed, payment1.getDocStatus(), "Payment document status is not completed: " + payment1.getDocStatus());
			
			MBankStatement stmt = new MBankStatement(Env.getCtx(), 0, getTrxName());
			stmt.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);		
			stmt.setStatementDate(today);
			stmt.setDateAcct(today);
			stmt.setName(System.currentTimeMillis()+"");
			stmt.setDocAction(DocAction.ACTION_Complete);
			stmt.setDocStatus(DocAction.STATUS_Drafted);
			stmt.saveEx();
			
			MBankStatementLine line = new MBankStatementLine(stmt);
			line.setValutaDate(today);
			line.setStatementLineDate(today);
			line.setStmtAmt(payment1.getPayAmt());
			line.setTrxAmt(payment1.getPayAmt());
			line.setC_Payment_ID(payment1.getC_Payment_ID());
			line.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			line.saveEx();
			
			pi = MWorkflow.runDocumentActionWorkflow(stmt, DocAction.ACTION_Complete);
			assertFalse(pi.isError(), pi.getSummary());
			
			stmt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, stmt.getDocStatus());
			
			payment1.load(getTrxName());
			payment1.setDocAction(DocAction.ACTION_Reverse_Correct);
			payment1.saveEx();
			pi = MWorkflow.runDocumentActionWorkflow(payment1, DocAction.ACTION_Reverse_Correct);		
			assertTrue(pi.isError(), "Reversal of reconciled payment should fail here.");
			assertTrue(pi.getSummary() != null && pi.getSummary().contains(Msg.getMsg(Env.getCtx(), "NotAllowReversalOfReconciledPayment")), "Unexpected error message: " + pi.getSummary());
		} finally {
			if (sysConfig != null) {
				sysConfig.setValue("Y");
				try {
					PO.setCrossTenantSafe();
					sysConfig.saveEx();
				} finally {
					PO.clearCrossTenantSafe();
				}
			}
		}
	}
}
