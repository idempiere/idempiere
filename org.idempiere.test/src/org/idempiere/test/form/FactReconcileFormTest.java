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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.compiere.apps.form.FactReconcile;
import org.compiere.model.MBankStatement;
import org.compiere.model.MBankStatementLine;
import org.compiere.model.MClientInfo;
import org.compiere.model.MFactAcct;
import org.compiere.model.MFactReconciliation;
import org.compiere.model.MPayment;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.ui.MiniTableImpl;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class FactReconcileFormTest extends AbstractTestCase {

	public FactReconcileFormTest() {
	}

	@Test
	public void testReconcileForm() {
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		payment.setIsReceipt(true);
		payment.setPayAmt(new BigDecimal("9.99"));
		payment.setC_BPartner_ID(DictionaryIDs.C_BPartner.SEED_FARM.id);
		payment.setC_DocType_ID(true);
		payment.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		payment.saveEx();
		
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		payment.load(getTrxName());
		if (!payment.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), payment.getAD_Client_ID(), MPayment.Table_ID, payment.get_ID(), true, getTrxName());
			assertTrue(Util.isEmpty(error, true), error);
		}
		
		Query query = new Query(Env.getCtx(), MFactAcct.Table_Name, "AD_Table_ID=? AND Record_ID=? AND Account_ID=? AND C_AcctSchema_ID=?", getTrxName());
		MFactAcct paymentFact = query.setParameters(MPayment.Table_ID, payment.get_ID(), DictionaryIDs.C_ElementValue.CHECKING_IN_TRANSFER.id, MClientInfo.get(getAD_Client_ID()).getC_AcctSchema1_ID()).first();
		assertNotNull(paymentFact, "Faild to retrieve MFactAcct checking in transfer record for payment");
		
		MBankStatement stmt = new MBankStatement(Env.getCtx(), 0, getTrxName());
		stmt.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		stmt.setName("testReconcileForm");
		stmt.setDateAcct(payment.getDateAcct());
		stmt.saveEx();
		
		MBankStatementLine line = new MBankStatementLine(stmt);
		line.setC_Payment_ID(payment.get_ID());
		line.setStmtAmt(payment.getPayAmt());
		line.setTrxAmt(line.getStmtAmt());
		line.setC_Currency_ID(payment.getC_Currency_ID());
		line.saveEx();
		
		pi = MWorkflow.runDocumentActionWorkflow(stmt, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		stmt.load(getTrxName());
		if (!stmt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), stmt.getAD_Client_ID(), MBankStatement.Table_ID, stmt.get_ID(), true, getTrxName());
			assertTrue(Util.isEmpty(error, true), error);
		}
		MFactAcct statementFact = query.setParameters(MBankStatement.Table_ID, stmt.get_ID(), DictionaryIDs.C_ElementValue.CHECKING_IN_TRANSFER.id, MClientInfo.get(getAD_Client_ID()).getC_AcctSchema1_ID()).first();
		assertNotNull(statementFact, "Faild to retrieve MFactAcct checking in transfer record for bank statement");
		
		FactReconcileImpl fri = new FactReconcileImpl();
		Vector<KeyNamePair> accounts = fri.getAccount();
		assertTrue(accounts.size() > 0, "Failed to retrieve account elements");
		KeyNamePair checkingInTransfer = null;
		for(KeyNamePair account : accounts) {
			if (account.getKey() == DictionaryIDs.C_ElementValue.CHECKING_IN_TRANSFER.id) {
				checkingInTransfer = account;
				break;
			}
		}
		assertNotNull(checkingInTransfer, "Can't find Checking In Transfer account element");
		
		//load not reconciled fact records
		fri.setParameters(payment.getC_BPartner_ID(), payment.getDateAcct(), checkingInTransfer, false);
		fri.loadData();
		assertTrue(fri.miniTable.getRowCount() >= 2, "Failed to load not reconciled fact account records");		
		for(int i = 0; i < fri.miniTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) fri.miniTable.getValueAt(i, fri.getIdColumnIndex());
			if (knp.getKey() == paymentFact.get_ID() || knp.getKey() == statementFact.get_ID()) {
				fri.miniTable.setValueAt(Boolean.TRUE, i, fri.getSelectedColumnIndex());
			}
		}		
		
		//select and generate reconciliation
		fri.calculateSelection(fri.miniTable);
		assertEquals(2, fri.getSelectedCount(), "Failed to locate not reconciled payment and bank statement fact records in mini table");		
		List<Integer> generated = new ArrayList<>();
		fri.generate(fri.miniTable, generated);
		assertEquals(2, generated.size(), "Failed to generate " + MFactReconciliation.Table_Name + " records");
		
		//reload not reconciled fact records after generate
		fri.setParameters(payment.getC_BPartner_ID(), payment.getDateAcct(), checkingInTransfer, false);
		fri.loadData();
		for(int i = 0; i < fri.miniTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) fri.miniTable.getValueAt(i, fri.getIdColumnIndex());
			if (knp.getKey() == paymentFact.get_ID() || knp.getKey() == statementFact.get_ID()) {
				fri.miniTable.setValueAt(Boolean.TRUE, i, fri.getSelectedColumnIndex());
			}
		}
		//should select 0 after generate
		fri.calculateSelection(fri.miniTable);
		assertEquals(0, fri.getSelectedCount(), "Payment and bank statement line not reconcilled");
		
		//load reconciled fact records
		fri.setParameters(payment.getC_BPartner_ID(), payment.getDateAcct(), checkingInTransfer, true);
		fri.loadData();
		for(int i = 0; i < fri.miniTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) fri.miniTable.getValueAt(i, fri.getIdColumnIndex());
			if (knp.getKey() == paymentFact.get_ID() || knp.getKey() == statementFact.get_ID()) {
				fri.miniTable.setValueAt(Boolean.TRUE, i, fri.getSelectedColumnIndex());
			}
		}		
		fri.calculateSelection(fri.miniTable);
		assertEquals(2, fri.getSelectedCount(), "Failed to locate reconcilled payment and statement fact record in mini table");
		//select and reset
		List<Integer> reseted = new ArrayList<>();
		fri.reset(fri.miniTable, reseted);
		assertEquals(2, reseted.size(), "Failed to reset " + MFactReconciliation.Table_Name + " records");
		
		//reload not reconciled fact records after reset
		fri.setParameters(payment.getC_BPartner_ID(), payment.getDateAcct(), checkingInTransfer, false);
		fri.loadData();
		assertTrue(fri.miniTable.getRowCount() >= 2, "Failed to load fact account records");		
		for(int i = 0; i < fri.miniTable.getRowCount(); i++) {
			KeyNamePair knp = (KeyNamePair) fri.miniTable.getValueAt(i, fri.getIdColumnIndex());
			if (knp.getKey() == paymentFact.get_ID() || knp.getKey() == statementFact.get_ID()) {
				fri.miniTable.setValueAt(Boolean.TRUE, i, fri.getSelectedColumnIndex());
			}
		}
		//should select 2 again after reset
		fri.calculateSelection(fri.miniTable);
		assertEquals(2, fri.getSelectedCount(), "Failed to locate payment and statement fact record in mini table");
	}
	
	private class FactReconcileImpl extends FactReconcile {
		protected MiniTableImpl miniTable = null;
		
		protected FactReconcileImpl() {			
			m_trxName = getTrxName();
			m_C_AcctSchema_ID = MClientInfo.get(getAD_Client_ID()).getC_AcctSchema1_ID();
			m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		}
		
		public void loadData() {
			miniTable = new MiniTableImpl();
			Vector<String> headers = getColumnNames();
			for(String header : headers) {
				miniTable.addColumn(header);
			}
			setColumnClass(miniTable);
			
			Vector<Vector<Object>> datas = super.getData();
			for (Vector<Object> data : datas) {
				int row = miniTable.getRowCount();
				miniTable.setRowCount(row+1);
				for(int column = 0; column < data.size(); column++) {
					Object value = data.get(column);
					miniTable.setValueAt(value, row, column);
				}
			}
		}

		protected void setParameters(int C_BPartner_ID, Timestamp dateAcct, KeyNamePair checkingInTransfer, boolean isReconciled) {
			m_C_BPartner_ID = C_BPartner_ID;
			m_DateAcct = dateAcct;
			m_Account_ID = checkingInTransfer.getKey();
			m_isReconciled = isReconciled;
		}

		protected Vector<KeyNamePair> getAccount() {
			return super.getAccount();
		}
		
		protected int getSelectedCount() {
			return m_noSelected;
		}
		
		protected int getIdColumnIndex() {
			return idColIndex;
		}
		
		protected int getSelectedColumnIndex() {
			return selectedColIndex;
		}
	}
}
