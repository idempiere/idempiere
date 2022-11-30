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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MPayment;
import org.compiere.model.MRole;
import org.compiere.process.DocAction;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 * 
 * @author Elaine
 *
 */
public abstract class PaymentFormDirect extends PaymentForm {
	private String PAYMENTRULE;
	
	/** Start Payment */
	protected int 				m_C_Payment_ID = 0;
	protected MPayment 			m_mPayment = null;
	protected MPayment 			m_mPaymentOriginal = null;
	
	/**
	 * 
	 * @param windowNo
	 * @param mTab
	 * @param isDebit
	 */
	public PaymentFormDirect(int windowNo, GridTab mTab, boolean isDebit) {
		super(windowNo, mTab);
		PAYMENTRULE = isDebit ? MInvoice.PAYMENTRULE_DirectDebit : MInvoice.PAYMENTRULE_DirectDeposit;
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
		
		if (m_mPayment == null)
		{
			m_mPayment = new MPayment (Env.getCtx (), 0, null);
			m_mPayment.setAD_Org_ID(m_AD_Org_ID);
			m_mPayment.setAmount (m_C_Currency_ID, m_Amount);
		}
	}
	
	/**
	 * 
	 * @return List of active bank accounts
	 */
	public ArrayList<KeyNamePair> getBankAccountList() {
		ArrayList<KeyNamePair> list = new ArrayList<KeyNamePair>();
		
		/**
		 *  Load Bank Accounts
		 */
		String SQL = MRole.getDefault().addAccessSQL(
			"SELECT C_BankAccount_ID, ba.Name || ' ' || ba.AccountNo, ba.IsDefault "
			+ "FROM C_BankAccount ba"
			+ " INNER JOIN C_Bank b ON (ba.C_Bank_ID=b.C_Bank_ID) "
			+ "WHERE b.IsActive='Y' AND ba.IsActive='Y' ORDER BY ba.IsDefault DESC ",
			"ba", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int key = rs.getInt(1);
				String name = rs.getString(2);
				KeyNamePair pp = new KeyNamePair(key, name);
				list.add(pp);
			}
		}
		catch (SQLException eac)
		{
			log.log(Level.SEVERE, SQL, eac);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return list;
	}
	
	@Override
	public boolean saveChanges() {
		boolean ok = super.saveChanges();
		if (m_mPayment != null)
			m_mPayment.set_TrxName(null);
		if (m_mPaymentOriginal != null)
			m_mPaymentOriginal.set_TrxName(null);
		return ok;
	}
	
	protected String processMsg;
	
	/**
	 * 
	 * @param C_BankAccount_ID
	 * @param routing routing number
	 * @param number account number
	 * @param trxName
	 * @return true if save successfully
	 */
	public boolean save(int C_BankAccount_ID, String routing, String number, String trxName)
	{
		// set trxname for class objects
		if (m_mPayment != null)
			m_mPayment.set_TrxName(trxName);
		if (m_mPaymentOriginal != null)
			m_mPaymentOriginal.set_TrxName(trxName);
				
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
		if (log.isLoggable(Level.CONFIG)) log.config("C_Order_ID=" + C_Order_ID + ", C_Invoice_ID=" + C_Invoice_ID + ", NegateAmt=" + negateAmt);
		
		/***********************
		 *  Payments
		 */
		//  Set Amount
		m_mPayment.setAmount(m_C_Currency_ID, payAmount);
		m_mPayment.setBankACH(C_BankAccount_ID, m_isSOTrx, PAYMENTRULE, routing, number);
		m_mPayment.setC_BPartner_ID(m_C_BPartner_ID);
		m_mPayment.setC_Invoice_ID(C_Invoice_ID);
		if (order != null)
		{
			m_mPayment.setC_Order_ID(C_Order_ID);					
		}
		m_mPayment.setDateTrx(m_DateAcct);
		m_mPayment.setDateAcct(m_DateAcct);
		setCustomizeValues(m_mPayment);
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
			if (log.isLoggable(Level.FINE)) log.fine("NotDraft " + m_mPayment);
		
		return true;
	}

	@Override
	protected void afterSave(boolean success) 
	{
		if (!success)
			return;
		
		/**********************
		 *	Save Values to mTab
		 */
		//refresh
		getGridTab().dataRefresh(false);
		Object paymentIdValue = getGridTab().getValue("C_Payment_ID");
		if (paymentIdValue != null && paymentIdValue instanceof Number)
			m_C_Payment_ID = ((Number)paymentIdValue).intValue();
		else
			m_C_Payment_ID = 0;
		//	Set Payment
		if (m_mPayment.getC_Payment_ID() != m_C_Payment_ID)
		{
			if (m_mPayment.getC_Payment_ID() == 0)
				getGridTab().setValue("C_Payment_ID", null);
			else
				getGridTab().setValue("C_Payment_ID", Integer.valueOf(m_mPayment.getC_Payment_ID()));
			m_needSave = true;
		}
	}
	
	/**
	 * 
	 * @return true if online payment processor have been configured for direct* tender type
	 */
	public boolean isBankAccountProcessorExist()
	{
		String tender = PAYMENTRULE.equals(MInvoice.PAYMENTRULE_DirectDebit) ? MPayment.TENDERTYPE_DirectDebit : MPayment.TENDERTYPE_DirectDeposit;
		return isBankAccountProcessorExist(Env.getCtx(), tender, "", Env.getAD_Client_ID(Env.getCtx()), m_C_Currency_ID, m_Amount, null);
	}
	
	/**
	 * Get online payment processor configured for direct* tender type
	 * @return {@link MBankAccountProcessor}
	 */
	public MBankAccountProcessor getBankAccountProcessor()
	{
		String tender = PAYMENTRULE.equals(MInvoice.PAYMENTRULE_DirectDebit) ? MPayment.TENDERTYPE_DirectDebit : MPayment.TENDERTYPE_DirectDeposit;
		return getBankAccountProcessor(Env.getCtx(), tender, "", Env.getAD_Client_ID(Env.getCtx()), m_C_Currency_ID, m_Amount, null);
	}
}
