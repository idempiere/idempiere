/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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
package org.compiere.grid;

import java.math.BigDecimal;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.PaymentUtil;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MPayment;
import org.compiere.model.MPaymentProcessor;
import org.compiere.model.MPaymentTransaction;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;

/**
 * 
 * @author Elaine
 *
 */
public abstract class PaymentFormCreditCard extends PaymentForm {
	private static final String PAYMENTRULE = MInvoice.PAYMENTRULE_CreditCard;
	
	/** Start Payment */
	public int 					m_C_Payment_ID = 0;
	public MPayment 			m_mPayment = null;
	public MPayment 			m_mPaymentOriginal = null;
	public MPaymentTransaction	m_mPaymentTransaction = null;
	/** Start CreditCard */
	public String 				m_CCType = "";
	
	public PaymentFormCreditCard(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
	}
	
	@Override
	public void loadData() {
		//  Existing Payment
		if (getGridTab().getValue("C_Payment_ID") != null)
		{
			m_C_Payment_ID = ((Integer)getGridTab().getValue("C_Payment_ID")).intValue();
			if (m_C_Payment_ID != 0)
			{
				m_mPayment = new MPayment(Env.getCtx(), m_C_Payment_ID, null);
				m_mPaymentOriginal = new MPayment(Env.getCtx(), m_C_Payment_ID, null);	//	full copy
			}
		}
		
		if (m_mPayment == null || m_mPayment.getC_Payment_ID() == 0)
		{
			int C_Order_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Order_ID");
			int C_Invoice_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Invoice_ID");
			if (C_Invoice_ID == 0 && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed))
				C_Invoice_ID = getInvoiceID (C_Order_ID);
			
			boolean found = false;
			if (C_Order_ID > 0 || C_Invoice_ID > 0)
			{
				int[] ids = MPaymentTransaction.getAuthorizationPaymentTransactionIDs(C_Order_ID, C_Invoice_ID, null);
				
				if (ids.length > 0)
				{
					if (C_Invoice_ID > 0)
					{
						for (int id : ids)
						{
							MPaymentTransaction pt = new MPaymentTransaction(Env.getCtx(), id, null);
							if (pt.getC_Invoice_ID() == C_Invoice_ID)
							{
								m_mPaymentTransaction = new MPaymentTransaction(Env.getCtx(), id, null);
								found = true;
								break;
							}
						}
					}
					
					if (!found)
					{
						for (int id : ids)
						{
							MPaymentTransaction pt = new MPaymentTransaction(Env.getCtx(), id, null);
							if (pt.getC_Order_ID() == C_Order_ID)
							{
								m_mPaymentTransaction = new MPaymentTransaction(Env.getCtx(), id, null);
								break;
							}
						}
					}
				}
			}
		}
		
		if (m_mPayment == null || m_mPayment.getC_Payment_ID() == 0)
		{
			int C_Order_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Order_ID");
			int C_Invoice_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Invoice_ID");
			if (C_Invoice_ID == 0 && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed))
				C_Invoice_ID = getInvoiceID (C_Order_ID);
			BigDecimal grandTotal = (BigDecimal) getGridTab().getValue("GrandTotal");
			
			boolean isCreditMemo = false;
			int doctype = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_DocTypeTarget_ID");
			if(doctype > 0)
			{
				MDocType mDocType = MDocType.get(Env.getCtx(), doctype);
				if (MDocType.DOCBASETYPE_ARCreditMemo.equals(mDocType.getDocBaseType()))
					isCreditMemo = true;
			}
			
			boolean found = false;
			if (C_Order_ID > 0 || C_Invoice_ID > 0)
			{
				int[] ids = MPayment.getCompletedPaymentIDs(C_Order_ID, C_Invoice_ID, null);
				
				if (ids.length > 0)
				{
					if (C_Invoice_ID > 0)
					{
						for (int id : ids)
						{
							MPayment p = new MPayment(Env.getCtx(), id, null);
							BigDecimal payAmt = p.getPayAmt();
							if (isCreditMemo)
								payAmt = payAmt.negate();
							if (p.getC_Invoice_ID() == C_Invoice_ID && payAmt.compareTo(grandTotal) >= 0)
							{
								m_C_Payment_ID = id;
								m_mPayment = p;
								m_mPaymentOriginal = new MPayment(Env.getCtx(), id, null);
								found = true;
								break;
							}
						}
					}
					
					if (!found)
					{
						for (int id : ids)
						{
							MPayment p = new MPayment(Env.getCtx(), id, null);
							BigDecimal payAmt = p.getPayAmt();
							if (isCreditMemo)
								payAmt = payAmt.negate();
							if (p.getC_Order_ID() == C_Order_ID && payAmt.compareTo(grandTotal) >= 0)
							{
								m_C_Payment_ID = id;
								m_mPayment = p;
								m_mPaymentOriginal = new MPayment(Env.getCtx(), id, null);
								break;
							}
						}
					}
				}
			}
		}

		if (m_mPayment == null)
		{
			m_mPayment = new MPayment (Env.getCtx (), 0, null);
			m_mPayment.setAD_Org_ID(m_AD_Org_ID);
			m_mPayment.setAmount (m_C_Currency_ID, m_Amount);
		}
		
		if (m_C_Payment_ID > 0 && m_mPayment != null)
			m_CCType = m_mPayment.getCreditCardType();
		
		if (m_mPaymentTransaction != null)
			m_CCType = m_mPaymentTransaction.getCreditCardType();
	}
	
	public ValueNamePair selectedCreditCard;
	public ValueNamePair[] getCreditCardList()
	{
		selectedCreditCard = null;
		ValueNamePair[] ccs = m_mPayment.getCreditCards();
		for (int i = 0; i < ccs.length; i++)
		{
			if (ccs[i].getValue().equals(m_CCType))
				selectedCreditCard = ccs[i];
		}
		return ccs;
	}
	
	@Override
	public boolean saveChanges() {
		boolean ok = super.saveChanges();
		if (m_mPayment != null)
			m_mPayment.set_TrxName(null);
		if (m_mPaymentOriginal != null)
			m_mPaymentOriginal.set_TrxName(null);
		if (m_mPaymentTransaction != null)
			m_mPaymentTransaction.set_TrxName(null);
		return ok;
	}
	
	public String processMsg = null;
	public boolean save(String newCCType, String newCCNumber, String newCCExp, BigDecimal newAmount, String trxName)
	{
		// set trxname for class objects
		if (m_mPayment != null)
			m_mPayment.set_TrxName(trxName);		
		if (m_mPaymentOriginal != null)
			m_mPaymentOriginal.set_TrxName(trxName);
		if (m_mPaymentTransaction != null)
			m_mPaymentTransaction.set_TrxName(trxName);
		
		if (m_mPaymentTransaction != null)
			return true;
				
		processMsg = null;
		String payTypes = m_Cash_As_Payment ? "KTSDB" : "KTSD";
				
		/***********************
		 *  Changed PaymentRule
		 */
		if (!PAYMENTRULE.equals(m_PaymentRule))
		{
			if (log.isLoggable(Level.FINE)) log.fine("Changed PaymentRule: " + m_PaymentRule + " -> " + PAYMENTRULE);
			//  We had a change in Payment type (e.g. Check to CC)
			if (payTypes.indexOf(m_PaymentRule) != -1 && payTypes.indexOf(PAYMENTRULE) != -1 && m_mPaymentOriginal != null)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Old Payment(1) - " + m_mPaymentOriginal);
				m_mPaymentOriginal.setDocAction(DocAction.ACTION_Reverse_Correct);
				boolean ok = m_mPaymentOriginal.processIt(DocAction.ACTION_Reverse_Correct);
				m_mPaymentOriginal.saveEx();
				if (ok) {
					if (log.isLoggable(Level.INFO)) log.info( "Payment Cancelled - " + m_mPaymentOriginal);
				} else {
					processMsg = Msg.getMsg(Env.getCtx(), "PaymentNotCancelled") + " " + m_mPaymentOriginal.getDocumentNo();
					throw new AdempiereException(processMsg);
				}
				m_mPayment.resetNew();
			}
			//	We had a Payment and something else (e.g. Check to Cash)
			else if (payTypes.indexOf(m_PaymentRule) != -1 && payTypes.indexOf(PAYMENTRULE) == -1)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Old Payment(2) - " + m_mPaymentOriginal);
				if (m_mPaymentOriginal != null)
				{
					m_mPaymentOriginal.setDocAction(DocAction.ACTION_Reverse_Correct);
					boolean ok = m_mPaymentOriginal.processIt(DocAction.ACTION_Reverse_Correct);
					m_mPaymentOriginal.saveEx();
					if (ok)        //  Cancel Payment
					{
						if (log.isLoggable(Level.FINE)) log.fine("PaymentCancelled " + m_mPayment.getDocumentNo ());
						getGridTab().getTableModel().dataSave(true);
						m_mPayment.resetNew();
						m_mPayment.setAmount(m_C_Currency_ID, m_Amount);
					}
					else
					{
						processMsg = Msg.getMsg(Env.getCtx(), "PaymentNotCancelled") + " " + m_mPayment.getDocumentNo();
						throw new AdempiereException(processMsg);
					}
				}
			}
		}
		
		//  Get Order and optionally Invoice
		int C_Order_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Order_ID");
		int C_Invoice_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Invoice_ID");
		if (C_Invoice_ID == 0 && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed))
			C_Invoice_ID = getInvoiceID (C_Order_ID);
		
		boolean isPOSOrder = false;
		boolean isInvoice = false;
		boolean isCreditMemo = false;
		int doctype = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_DocTypeTarget_ID");
		if(doctype > 0)
		{
			MDocType mDocType = MDocType.get(Env.getCtx(), doctype);
			if (MDocType.DOCSUBTYPESO_POSOrder.equals(mDocType.getDocSubTypeSO()))
				isPOSOrder = true;
			else if (MDocType.DOCBASETYPE_ARInvoice.equals(mDocType.getDocBaseType()))
				isInvoice = true;
			else if (MDocType.DOCBASETYPE_ARCreditMemo.equals(mDocType.getDocBaseType()))
				isCreditMemo = true;
		}

		//  Amount sign negative, if ARC (Credit Memo) or API (AP Invoice)
		BigDecimal payAmount = m_Amount;
		if (isCreditMemo)
			payAmount = m_Amount.negate();
		
		/***********************
		 *  Payments
		 */
		if (log.isLoggable(Level.FINE)) log.fine("Payment - " + PAYMENTRULE);
		//  Set Amount
		m_mPayment.setAmount(m_C_Currency_ID, payAmount);
		m_mPayment.setCreditCard(MPayment.TRXTYPE_Sales, newCCType, newCCNumber, "", newCCExp);
		m_mPayment.setPaymentProcessor();
		
		if (isPOSOrder || isInvoice)
			m_mPayment.setTrxType(MPayment.TRXTYPE_Sales);
		else if (isCreditMemo)
		{
			m_mPayment.setTrxType(MPayment.TRXTYPE_CreditPayment);
//			m_mPayment.setOrig_TrxID(kPGOrderIDField.getValue());
		}
		else if (C_Invoice_ID != 0)
		{
			MInvoice invoice = new MInvoice (Env.getCtx(), C_Invoice_ID, null);
			if (invoice.isComplete())
				m_mPayment.setTrxType(MPayment.TRXTYPE_Sales);
		}
		else
		{
			MPaymentProcessor paymentProcessor = new MPaymentProcessor(m_mPayment.getCtx(), m_mPayment.getC_PaymentProcessor_ID(), m_mPayment.get_TrxName());
			if (paymentProcessor.getTrxType() != null)
				m_mPayment.setTrxType(paymentProcessor.getTrxType());
		}

		m_mPayment.setC_BPartner_ID(m_C_BPartner_ID);
		m_mPayment.setC_Invoice_ID(C_Invoice_ID);
		
		MInvoice invoice = null;
		if (C_Invoice_ID != 0)
			invoice = new MInvoice (Env.getCtx(), C_Invoice_ID, null);
		MOrder order = null;
		if (invoice == null && C_Order_ID != 0)
			order = new MOrder (Env.getCtx(), C_Order_ID, null);
		if (order != null)
		{
			m_mPayment.setC_Order_ID(C_Order_ID);
			m_needSave = true;
		}
		m_mPayment.setDateTrx(m_DateAcct);
		m_mPayment.setDateAcct(m_DateAcct);
		setCustomizeValues(m_mPayment);
		
		if (!m_mPayment.isOnline() && !m_mPayment.isApproved())
		{
			processMsg = Msg.getMsg(Env.getCtx(), "CardNotProcessed");
			throw new AdempiereException(processMsg);
		}
		
		m_mPayment.saveEx();
		
		//  Save/Post
		if (m_mPayment.get_ID() > 0 && MPayment.DOCSTATUS_Drafted.equals(m_mPayment.getDocStatus()))
		{
			boolean ok = m_mPayment.processIt(DocAction.ACTION_Complete);
			m_mPayment.saveEx();
			if (ok)
				processMsg = m_mPayment.getDocumentNo();
			else
			{
				processMsg = Msg.getMsg(Env.getCtx(), "PaymentNotCreated");
				throw new AdempiereException(processMsg);
			}
		}
		else
		{
			if (log.isLoggable(Level.FINE)) log.fine("NotDraft " + m_mPayment);
			m_mPayment.setCreditCardNumber(PaymentUtil.encrpytCreditCard(m_mPayment.getCreditCardNumber()));
			m_mPayment.setCreditCardVV(PaymentUtil.encrpytCvv(m_mPayment.getCreditCardVV()));
			m_mPayment.saveEx();
		}
		
		/**********************
		 *	Save Values to mTab
		 */
		log.config("Saving changes");
		//	Set Payment
		if (m_mPayment.getC_Payment_ID() != m_C_Payment_ID)
		{
			if (m_mPayment.getC_Payment_ID() == 0)
				getGridTab().setValue("C_Payment_ID", null);
			else
				getGridTab().setValue("C_Payment_ID", new Integer(m_mPayment.getC_Payment_ID()));
		}
		
		return true;
	}
	
	public boolean processOnline(String CCType, String CCNumber, String CCExp)
	{
		processMsg = null;
		boolean error = false;

		int C_Order_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Order_ID");
		int C_Invoice_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Invoice_ID");
		if (C_Invoice_ID == 0 && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed))
			C_Invoice_ID = getInvoiceID (C_Order_ID);

		boolean isPOSOrder = false;
		boolean isInvoice = false;
		boolean isCreditMemo = false;
		int doctype = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_DocTypeTarget_ID");
		if(doctype > 0)
		{
			MDocType mDocType = MDocType.get(Env.getCtx(), doctype);
			if (MDocType.DOCSUBTYPESO_POSOrder.equals(mDocType.getDocSubTypeSO()))
				isPOSOrder = true;
			else if (MDocType.DOCBASETYPE_ARInvoice.equals(mDocType.getDocBaseType()))
				isInvoice = true;
			else if (MDocType.DOCBASETYPE_ARCreditMemo.equals(mDocType.getDocBaseType()))
				isCreditMemo = true;
		}

		boolean approved = false;
		
		BigDecimal payAmount = m_Amount;
		if (isCreditMemo)
			payAmount = m_Amount.negate();
		
		MPaymentTransaction mpt = new MPaymentTransaction(Env.getCtx(), 0, null);
		mpt.setAD_Org_ID(m_AD_Org_ID);
		mpt.setCreditCard(MPayment.TRXTYPE_Sales, CCType, CCNumber, "", CCExp);
		mpt.setAmount(m_C_Currency_ID, payAmount);
		mpt.setPaymentProcessor();
		
		if (isPOSOrder || isInvoice)
			mpt.setTrxType(MPayment.TRXTYPE_Sales);
		else if (isCreditMemo)
		{
			mpt.setTrxType(MPayment.TRXTYPE_CreditPayment);
//			mpt.setOrig_TrxID(kPGOrderIDField.getValue());
		}
		else if (C_Invoice_ID != 0)
		{
			MInvoice invoice = new MInvoice (Env.getCtx(), C_Invoice_ID, null);
			if (invoice.isComplete())
				mpt.setTrxType(MPayment.TRXTYPE_Sales);
		}
		else
		{
			MPaymentProcessor paymentProcessor = new MPaymentProcessor(mpt.getCtx(), mpt.getC_PaymentProcessor_ID(), null);
			if (paymentProcessor.getTrxType() != null)
				mpt.setTrxType(paymentProcessor.getTrxType());
		}
		
		mpt.setC_BPartner_ID(m_C_BPartner_ID);
		//
		mpt.setC_Order_ID(C_Order_ID);
		mpt.setC_Invoice_ID(C_Invoice_ID);
		mpt.setDateTrx(m_DateAcct);
		setCustomizeValues(mpt);
		if (!mpt.save()) {
			processMsg = Msg.getMsg(Env.getCtx(), "PaymentNotCreated");
			return false;
		} else {
			approved = mpt.processOnline();
			mpt.saveEx();
			
			if (approved)
			{
				m_needSave = true;
				if (mpt.getC_Payment_ID() > 0)
				{
					m_mPayment = new MPayment(mpt.getCtx(), mpt.getC_Payment_ID(), null);
					String info = m_mPayment.getR_RespMsg() + " (" + m_mPayment.getR_AuthCode() + ") ID=" + m_mPayment.getR_PnRef();
					processMsg = info + "\n" + m_mPayment.getDocumentNo();
					saveChanges();
				}
				else
				{
					String info = mpt.getR_RespMsg() + " (" + mpt.getR_AuthCode() + ") ID=" + mpt.getR_PnRef();
					processMsg = info;
				}
			}
			else
			{
				processMsg = mpt.getErrorMessage();				
				error = true;
			}
		}
		return !error;
	}
	
	public boolean isBankAccountProcessorExist(String CCType, BigDecimal PayAmt)
	{
		return isBankAccountProcessorExist(Env.getCtx(), MPayment.TENDERTYPE_CreditCard, CCType, Env.getAD_Client_ID(Env.getCtx()), m_C_Currency_ID, PayAmt, null);
	}
	
	public MBankAccountProcessor getBankAccountProcessor(String CCType, BigDecimal PayAmt)
	{
		return getBankAccountProcessor(Env.getCtx(), MPayment.TENDERTYPE_CreditCard, CCType, Env.getAD_Client_ID(Env.getCtx()), m_C_Currency_ID, PayAmt, null);
	}

	@Override
	public boolean isApproved() {
		return m_mPayment.isApproved();
	}
}
