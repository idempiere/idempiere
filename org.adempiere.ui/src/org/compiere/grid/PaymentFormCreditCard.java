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

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MPayment;
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
	private final String PAYMENTRULE = MInvoice.PAYMENTRULE_CreditCard;
	
	public PaymentFormCreditCard(int WindowNo, GridTab mTab) {
		super(WindowNo, mTab);
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
	
	public String processMsg = null;
	public boolean save(String newCCType, String newCCNumber, String newCCExp, BigDecimal newAmount)
	{
		processMsg = null;
		String payTypes = m_Cash_As_Payment ? "KTSDB" : "KTSD";
				
		/***********************
		 *  Changed PaymentRule
		 */
		if (!PAYMENTRULE.equals(m_PaymentRule))
		{
			log.fine("Changed PaymentRule: " + m_PaymentRule + " -> " + PAYMENTRULE);
			//  We had a change in Payment type (e.g. Check to CC)
			if (payTypes.indexOf(m_PaymentRule) != -1 && payTypes.indexOf(PAYMENTRULE) != -1 && m_mPaymentOriginal != null)
			{
				log.fine("Old Payment(1) - " + m_mPaymentOriginal);
				m_mPaymentOriginal.setDocAction(DocAction.ACTION_Reverse_Correct);
				boolean ok = m_mPaymentOriginal.processIt(DocAction.ACTION_Reverse_Correct);
				m_mPaymentOriginal.saveEx();
				if (ok)
					log.info( "Payment Cancelled - " + m_mPaymentOriginal);
				else
				{
					processMsg = Msg.getMsg(Env.getCtx(), "PaymentNotCancelled") + " " + m_mPaymentOriginal.getDocumentNo();
					throw new AdempiereException(processMsg);
				}
				m_mPayment.resetNew();
			}
			//	We had a Payment and something else (e.g. Check to Cash)
			else if (payTypes.indexOf(m_PaymentRule) != -1 && payTypes.indexOf(PAYMENTRULE) == -1)
			{
				log.fine("Old Payment(2) - " + m_mPaymentOriginal);
				if (m_mPaymentOriginal != null)
				{
					m_mPaymentOriginal.setDocAction(DocAction.ACTION_Reverse_Correct);
					boolean ok = m_mPaymentOriginal.processIt(DocAction.ACTION_Reverse_Correct);
					m_mPaymentOriginal.saveEx();
					if (ok)        //  Cancel Payment
					{
						log.fine("PaymentCancelled " + m_mPayment.getDocumentNo ());
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
		if (C_Invoice_ID == 0 && m_DocStatus.equals("CO"))
			C_Invoice_ID = getInvoiceID (C_Order_ID);

		//  Amount sign negative, if ARC (Credit Memo) or API (AP Invoice)
		boolean negateAmt = false;
		MInvoice invoice = null;
		if (C_Invoice_ID != 0)
		{
			invoice = new MInvoice (Env.getCtx(), C_Invoice_ID, null);
			negateAmt = invoice.isCreditMemo();
		}
		MOrder order = null;
		if (invoice == null && C_Order_ID != 0)
			order = new MOrder (Env.getCtx(), C_Order_ID, null);
		
		BigDecimal payAmount = m_Amount;
		

		if (negateAmt)
			payAmount = m_Amount.negate();
		// Info
		log.config("C_Order_ID=" + C_Order_ID + ", C_Invoice_ID=" + C_Invoice_ID + ", NegateAmt=" + negateAmt);
		
		/***********************
		 *  Payments
		 */
		log.fine("Payment - " + PAYMENTRULE);
		//  Set Amount
		m_mPayment.setAmount(m_C_Currency_ID, payAmount);
		m_mPayment.setCreditCard(MPayment.TRXTYPE_Sales, newCCType, newCCNumber, "", newCCExp);
		// Get changes to credit card amount
		m_mPayment.setAmount(m_C_Currency_ID, newAmount);
		m_mPayment.setPaymentProcessor();

		m_mPayment.setC_BPartner_ID(m_C_BPartner_ID);
		m_mPayment.setC_Invoice_ID(C_Invoice_ID);
		if (order != null)
		{
			m_mPayment.setC_Order_ID(C_Order_ID);
			m_needSave = true;
		}
		m_mPayment.setDateTrx(m_DateAcct);
		m_mPayment.setDateAcct(m_DateAcct);
		setCustomizeValues();
		
		if (!m_mPayment.isApproved())
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
			log.fine("NotDraft " + m_mPayment);
		
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
		
		boolean approved = false;
		String info = "";

		m_mPayment.setCreditCard(MPayment.TRXTYPE_Sales, CCType,
			CCNumber, "", CCExp);
		m_mPayment.setAmount(m_C_Currency_ID, m_Amount);
		m_mPayment.setPaymentProcessor();
		m_mPayment.setC_BPartner_ID(m_C_BPartner_ID);
		//
		int C_Invoice_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Invoice_ID");
		if (C_Invoice_ID == 0 && m_DocStatus.equals("CO"))
		{
			int C_Order_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Order_ID");
			C_Invoice_ID = getInvoiceID (C_Order_ID);
		}
		m_mPayment.setC_Invoice_ID(C_Invoice_ID);
		m_mPayment.setDateTrx(m_DateAcct);
		//  Set Amount
		m_mPayment.setAmount(m_C_Currency_ID, m_Amount);
		setCustomizeValues();
		if (!m_mPayment.save()) {
			processMsg = Msg.getMsg(Env.getCtx(), "PaymentNotCreated");
			return false;
		} else {
			approved = m_mPayment.processOnline();
			info = m_mPayment.getR_RespMsg() + " (" + m_mPayment.getR_AuthCode()
				+ ") ID=" + m_mPayment.getR_PnRef();
			m_mPayment.saveEx();

			if (approved)
			{
				boolean ok = m_mPayment.processIt(DocAction.ACTION_Complete);
				m_mPayment.saveEx();
				if (ok)
					processMsg = info + "\n" + m_mPayment.getDocumentNo();
				else
				{
					processMsg = Msg.getMsg(Env.getCtx(), "PaymentNotCreated");
					error = true;
				}
				saveChanges();
			}
			else
			{
				processMsg = info;
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
}
