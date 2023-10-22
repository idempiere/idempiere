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
import static org.junit.jupiter.api.Assertions.fail;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.compiere.grid.PaymentFormCheck;
import org.compiere.grid.PaymentFormCreditCard;
import org.compiere.grid.PaymentFormDirect;
import org.compiere.grid.PaymentFormOnCredit;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPayment;
import org.compiere.model.MPaymentProcessor;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class PaymentFormTest extends AbstractTestCase {

	public PaymentFormTest() {
	}

	@Test
	public void testPaymentFormCheck() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_Check);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_SALES_ORDER);
		assertNotNull(gridWindow, "Failed to load grid window of Sales Order");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MOrder.Table_Name);
		query.addRestriction(MOrder.COLUMNNAME_C_Order_ID,"=", order.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(order.get_ID(), gridTab.getRecord_ID(), "Wrong record id");
		
		PaymentFormCheckImpl form = new PaymentFormCheckImpl(0, gridTab);
		form.loadData();
		ArrayList<KeyNamePair> bankAccounts = form.getBankAccountList();
		assertTrue(bankAccounts.size() > 0, "Failed to retrieve list of active bank accounts");
		assertTrue(form.getSelectedBankAccountId() > 0, "Failed to set default selected bank account");
		form.routingNumber = "routingNumber1";
		form.accountNumber = "customerAccountNumber1";
		form.checkNumber = "checkNumber1";
		form.paymentAmount = order.getGrandTotal();
		boolean ok = form.saveChangesInTrx(getTrxName());
		assertTrue(ok, "Save failed: " + form.getProcessMessage());
		assertNotNull(form.getPayment(), "Payment not created");
		assertTrue(form.getPayment().get_ID() > 0, "Payment not save successfully");
	}
	
	@Test
	public void testPaymentFormDirect() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_DirectDebit);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_SALES_ORDER);
		assertNotNull(gridWindow, "Failed to load grid window of Sales Order");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MOrder.Table_Name);
		query.addRestriction(MOrder.COLUMNNAME_C_Order_ID,"=", order.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(order.get_ID(), gridTab.getRecord_ID(), "Wrong record id");
		
		PaymentFormDirectImpl form = new PaymentFormDirectImpl(0, gridTab, true);
		try {
			form.dynInit();
		} catch (Exception e) {
			fail(e);
		}
		ArrayList<KeyNamePair> bankAccounts = form.getBankAccountList();
		assertTrue(bankAccounts.size() > 0, "Failed to retrieve list of active bank accounts");
		form.C_BankAccount_ID = bankAccounts.get(0).getKey();
		form.routingNumber = "routingNumber1";
		form.accountNumber = "customerAccountNumber1";
		assertEquals(order.getGrandTotal().setScale(2, RoundingMode.HALF_EVEN), form.getPaymentAmount().setScale(2, RoundingMode.HALF_EVEN), "Wrong Payment Form Amount");
		boolean ok = form.saveChangesInTrx(getTrxName());
		assertTrue(ok, "Save failed: " + form.getProcessMessage());
		assertNotNull(form.getPayment(), "Payment not created");
		assertTrue(form.getPayment().get_ID() > 0, "Payment not save successfully");
		assertEquals(order.getGrandTotal().setScale(2, RoundingMode.HALF_EVEN), form.getPayment().getPayAmt().setScale(2, RoundingMode.HALF_EVEN), "Wrong Payment Document Amount");
	}
	
	@Test
	public void testPaymentFormOnCredit() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_DirectDebit);
		order.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_SALES_ORDER);
		assertNotNull(gridWindow, "Failed to load grid window of Sales Order");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MOrder.Table_Name);
		query.addRestriction(MOrder.COLUMNNAME_C_Order_ID,"=", order.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(order.get_ID(), gridTab.getRecord_ID(), "Wrong record id");
		
		PaymentFormOnCreditImpl form = new PaymentFormOnCreditImpl(0, gridTab);
		try {
			form.dynInit();
		} catch (Exception e) {
			fail(e);
		}
		ArrayList<KeyNamePair> terms = form.getPaymentTermList();
		assertTrue(terms.size() > 0, "Failed to retrieve list of active payment terms");
		for(KeyNamePair term : terms) {
			if (term.getKey() == DictionaryIDs.C_PaymentTerm.NET_30.id) {
				form.setPaymentTerm(term.getKey());
			}
		}
		form.saveChangesInTrx(getTrxName());
		assertEquals(((Number)gridTab.getValue("C_PaymentTerm_ID")).intValue(), form.getPaymentTerm(), "Wrong Payment Term");
	}
	
	@Test
	public void testPaymentFormCreditCard() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_CreditCard);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_SALES_ORDER);
		assertNotNull(gridWindow, "Failed to load grid window of Sales Order");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MOrder.Table_Name);
		query.addRestriction(MOrder.COLUMNNAME_C_Order_ID,"=", order.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(order.get_ID(), gridTab.getRecord_ID(), "Wrong record id");
		
		
		PaymentFormCreditCardImpl form = new PaymentFormCreditCardImpl(0, gridTab);
		try {
			form.dynInit();
		} catch (Exception e) {
			fail(e);
		}
		assertEquals(order.getGrandTotal().setScale(2, RoundingMode.HALF_EVEN), form.getPaymentAmount().setScale(2, RoundingMode.HALF_EVEN), "Wrong Payment Form Amount");
		form.setCCType(MPayment.CREDITCARDTYPE_MasterCard);
		form.CCNumber = "5555555555554444";
		form.CCVV = "123";
		form.CCExp = "1199";
		
		MBankAccountProcessor[] processors = MBankAccountProcessor.find(Env.getCtx(), MPayment.TENDERTYPE_CreditCard, form.getCCType(), getAD_Client_ID(), order.getC_Currency_ID(), form.getPaymentAmount(), getTrxName());
		assertTrue(processors.length > 0, "Fail to retrieve default bank account processor for credit card");
		MPaymentProcessor mpp = null;
		String payProcessorClass = null;		
		for(MBankAccountProcessor processor : processors) {
			if (processor.accepts(MPayment.TENDERTYPE_CreditCard, form.getCCType())) {
				mpp = new MPaymentProcessor(Env.getCtx(), processor.getC_PaymentProcessor_ID(), null);				
				break;
			}
		}
		
		assertNotNull(mpp, "Failed to find default payment processor for credit card");
		try {
			payProcessorClass = mpp.getPayProcessorClass();
			mpp.setPayProcessorClass("org.compiere.model.PP_Dummy");
			mpp.saveCrossTenantSafeEx();
			boolean ok = form.saveChangesInTrx(getTrxName());
			assertTrue(ok, "Save failed: " + form.getProcessMessage());
			assertNotNull(form.getPayment(), "Payment not created");
			assertTrue(form.getPayment().get_ID() > 0, "Payment not save successfully");
			assertEquals(order.getGrandTotal().setScale(2, RoundingMode.HALF_EVEN), form.getPayment().getPayAmt().setScale(2, RoundingMode.HALF_EVEN), "Wrong Payment Document Amount");
		} finally {
			mpp.setPayProcessorClass(payProcessorClass);
			mpp.saveCrossTenantSafeEx();
		}
	}
	
	private class PaymentFormCheckImpl extends PaymentFormCheck {

		private String routingNumber;
		private String accountNumber;
		private String checkNumber;
		private BigDecimal paymentAmount;

		public PaymentFormCheckImpl(int windowNo, GridTab mTab) {
			super(windowNo, mTab);
			try {
				dynInit();
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}

		@Override
		public boolean checkMandatory() {
			return true;
		}

		public int getSelectedBankAccountId() {
			if (selectedBankAccount != null) {
				return selectedBankAccount.getKey();
			}
			return 0;
		}
		
		@Override
		public boolean saveChangesInTrx(String trxName) {
			return save(getSelectedBankAccountId(), routingNumber, accountNumber, 
					checkNumber, paymentAmount, trxName);
		}

		public String getProcessMessage() {
			return processMsg;
		}
		
		public MPayment getPayment() {
			return m_mPayment;
		}
		
		@Override
		public void showWindow() {
		}

		@Override
		public void closeWindow() {
		}

		@Override
		public Object getWindow() {
			return null;
		}
		
	}
	
	private class PaymentFormDirectImpl extends PaymentFormDirect {

		private String routingNumber;
		private String accountNumber;
		private int C_BankAccount_ID;

		public PaymentFormDirectImpl(int windowNo, GridTab mTab, boolean isDebit) {
			super(windowNo, mTab, isDebit);
		}

		@Override
		public boolean checkMandatory() {
			return true;
		}

		@Override
		public boolean saveChangesInTrx(String trxName) {
			return save(C_BankAccount_ID, routingNumber, accountNumber, trxName);
		}

		@Override
		public void showWindow() {
		}

		@Override
		public void closeWindow() {
		}

		@Override
		public Object getWindow() {
			return null;
		}	
		
		public BigDecimal getPaymentAmount() {
			return m_Amount;
		}
		
		public String getProcessMessage() {
			return processMsg;
		}
		
		public MPayment getPayment() {
			return m_mPayment;
		}
	}
	
	private class PaymentFormOnCreditImpl extends PaymentFormOnCredit {

		public PaymentFormOnCreditImpl(int windowNo, GridTab mTab) {
			super(windowNo, mTab);
		}

		public int getPaymentTerm() {
			return m_C_PaymentTerm_ID;
		}

		public void setPaymentTerm(int key) {
			m_C_PaymentTerm_ID = key;
		}

		@Override
		public boolean checkMandatory() {
			return true;
		}

		@Override
		public boolean saveChangesInTrx(String trxName) {
			return save(m_C_PaymentTerm_ID);
		}

		@Override
		public void showWindow() {
		}

		@Override
		public void closeWindow() {
		}

		@Override
		public Object getWindow() {
			return null;
		}
	}
	
	private class PaymentFormCreditCardImpl extends PaymentFormCreditCard {

		private String CCNumber;
		private String CCExp;
		private String CCVV;

		public PaymentFormCreditCardImpl(int windowNo, GridTab mTab) {
			super(windowNo, mTab);
		}

		public MPayment getPayment() {
			return m_mPayment;
		}

		public String getProcessMessage() {
			return processMsg;
		}

		public BigDecimal getPaymentAmount() {
			return m_Amount;
		}

		public void setCCType(String cctype) {
			m_CCType = cctype;
		}

		public String getCCType() {
			return m_CCType;
		}
		
		@Override
		public boolean checkMandatory() {
			return true;
		}

		@Override
		public boolean saveChangesInTrx(String trxName) {
			String msg = validateCreditCard(m_CCType, CCNumber, CCVV, CCExp, 0, null);
			if (!Util.isEmpty(msg, true)) {
				processMsg = msg;
				return false;
			}
			if (!processOnline(m_CCType, CCNumber, CCVV, CCExp, 0, trxName)) 
				return false;
			return save(m_CCType, CCNumber, CCExp, m_Amount, trxName);
		}

		@Override
		public void showWindow() {
		}

		@Override
		public void closeWindow() {
		}

		@Override
		public Object getWindow() {
			return null;
		}		
	}
}
