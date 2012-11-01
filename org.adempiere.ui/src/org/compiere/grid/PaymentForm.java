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
import java.sql.Timestamp;
import java.util.Hashtable;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MPaymentProcessor;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.TrxRunnable;

/**
 * 
 * @author Elaine
 *
 */
public abstract class PaymentForm implements IPaymentForm {

	/**	Logger			*/
	protected CLogger log = CLogger.getCLogger(getClass());
	
	/**	Window						*/
	private int                 m_WindowNo = 0;
	/**	Tab							*/
	private GridTab         	m_mTab;
	
	// Data from Order/Invoice
	public String 				m_DocStatus = null;
	/** Start Payment Rule */
	public String 				m_PaymentRule = "";
	/** Start Acct Date */
	public Timestamp 			m_DateAcct = null;
	/** Start Payment */
//	public int 					m_C_Payment_ID = 0;
//	public MPayment 			m_mPayment = null;
//	public MPayment 			m_mPaymentOriginal = null;

	/** Invoice Currency */
	public int 					m_C_Currency_ID = 0;
	public int 					m_AD_Client_ID = 0;
	public boolean 				m_Cash_As_Payment = true;
	public int 					m_AD_Org_ID = 0;
	public int 					m_C_BPartner_ID = 0;
	public BigDecimal 			m_Amount = Env.ZERO; // Payment Amount
	
	public boolean				m_needSave = false;
	/** Only allow changing Rule        */
	public boolean 				m_onlyRule = false;
	/** Is SOTrx					*/
	public boolean				m_isSOTrx = true;
	
	public Hashtable<Integer,KeyNamePair> s_Currencies = null;
	
	public PaymentForm(int WindowNo, GridTab mTab) {
		m_WindowNo = WindowNo;
		m_isSOTrx = "Y".equals(Env.getContext(Env.getCtx(), WindowNo, "IsSOTrx"));
		m_mTab = mTab;
	}
	
	@Override
	public boolean dynInit() throws Exception {
		m_DocStatus = (String) m_mTab.getValue("DocStatus");
		log.config(m_DocStatus);

		if (m_mTab.getValue("C_BPartner_ID") == null) {
			throw new AdempiereException("SaveErrorRowNotFound");
		}

		// DocStatus
		if (m_DocStatus == null)
			m_DocStatus = "";
		// Is the Trx closed? Reversed / Voided / Cloased
		if (m_DocStatus.equals("RE") || m_DocStatus.equals("VO") || m_DocStatus.equals("CL"))
			return false;
		
		// Document is not complete - allow to change the Payment Rule only
		if (m_DocStatus.equals("CO") || m_DocStatus.equals("WP"))
			m_onlyRule = false;
		else
			m_onlyRule = true;
		// PO only Rule
		if (!m_onlyRule // Only order has Warehouse
				&& !m_isSOTrx && m_mTab.getValue("M_Warehouse_ID") != null)
			m_onlyRule = true;
		
		//  Amount
		m_Amount = (BigDecimal)m_mTab.getValue("GrandTotal");
		if (!m_onlyRule && m_Amount.compareTo(Env.ZERO) == 0)
		{
			throw new AdempiereException("PaymentZero");
		}
		
		/**
		 *	Get Data from Grid
		 */
		m_AD_Client_ID = ((Integer)m_mTab.getValue("AD_Client_ID")).intValue();
		m_Cash_As_Payment = MSysConfig.getBooleanValue(MSysConfig.CASH_AS_PAYMENT,true, m_AD_Client_ID);
		m_AD_Org_ID = ((Integer)m_mTab.getValue("AD_Org_ID")).intValue();
		m_C_BPartner_ID = ((Integer)m_mTab.getValue("C_BPartner_ID")).intValue();
		m_PaymentRule = (String)m_mTab.getValue("PaymentRule");
		m_C_Currency_ID = ((Integer)m_mTab.getValue("C_Currency_ID")).intValue();
		m_DateAcct = (Timestamp)m_mTab.getValue("DateAcct");
		
		if (s_Currencies == null)
			loadCurrencies();
				
		/**
		 *	Payment Combo
		 */
		if (m_PaymentRule == null)
			m_PaymentRule = "";

		loadData();
		
		return true;
	}
	
	@Override
	public boolean saveChanges() {
		// BF [ 1920179 ] perform the save in a trx's context.
		final boolean[] success = new boolean[] { false };
		final TrxRunnable r = new TrxRunnable() {

			public void run(String trxName) {
				//  only Payment Rule
				if (m_onlyRule)
					success[0] = true;
				else
					success[0] = saveChangesInTrx(trxName);
			}
		};
		try {
			Trx.run(r);
		} catch (AdempiereException ae) {
			success[0] = false;
			throw ae;
		} catch (Throwable e) {
			success[0] = false;
			throw new AdempiereException("PaymentError", e);
		}
		return success[0];
	} // saveChanges
	
	/**
	 *	Fill s_Currencies with EMU currencies
	 */
	protected void loadCurrencies()
	{
		s_Currencies = new Hashtable<Integer,KeyNamePair>(12);	//	Currenly only 10+1
		String SQL = "SELECT C_Currency_ID, ISO_Code FROM C_Currency "
			+ "WHERE (IsEMUMember='Y' AND EMUEntryDate<SysDate) OR IsEuro='Y' "
			+ "ORDER BY 2";
		try
		{
			PreparedStatement pstmt = DB.prepareStatement(SQL, null);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				int id = rs.getInt(1);
				String name = rs.getString(2);
				s_Currencies.put(new Integer(id), new KeyNamePair(id, name));
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, SQL, e);
		}
	}	//	loadCurrencies
	
	@Override
	public boolean needSave()
	{
		return m_needSave;
	}	//	needSave
	
	/**
	 *  Get Invoice ID for Order
	 *  @param C_Order_ID order
	 *  @return C_Invoice_ID or 0 if not found
	 */
	protected int getInvoiceID (int C_Order_ID)
	{
		int retValue = 0;
		String sql = "SELECT C_Invoice_ID FROM C_Invoice WHERE C_Order_ID=? "
			+ "ORDER BY C_Invoice_ID DESC";     //  last invoice
		try
		{
			PreparedStatement pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_Order_ID);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				retValue = rs.getInt(1);
			rs.close();
			pstmt.close();
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		return retValue;
	}   //  getInvoiceID
	
	@Override
	public void processOnline()
	{
		throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ActionNotSupported"));
	}
	
	protected boolean isBankAccountProcessorExist(Properties ctx, String tender, String CCType, int AD_Client_ID, int C_Currency_ID, BigDecimal PayAmt, String trxName)
	{
		MBankAccountProcessor[] m_mBankAccountProcessors = MPaymentProcessor.find(ctx, tender, CCType, AD_Client_ID, C_Currency_ID, PayAmt, trxName);
		//	Relax Amount
		if (m_mBankAccountProcessors == null || m_mBankAccountProcessors.length == 0)
			m_mBankAccountProcessors = MPaymentProcessor.find(ctx, tender, CCType, AD_Client_ID, C_Currency_ID, Env.ZERO, trxName);
		if (m_mBankAccountProcessors == null || m_mBankAccountProcessors.length == 0)
			return false;
		return true;
	}
	
	protected MBankAccountProcessor getBankAccountProcessor(Properties ctx, String tender, String CCType, int AD_Client_ID, int C_Currency_ID, BigDecimal PayAmt, String trxName)
	{
		MBankAccountProcessor[] m_mBankAccountProcessors = MPaymentProcessor.find(ctx, tender, CCType, AD_Client_ID, C_Currency_ID, PayAmt, trxName);
		//	Relax Amount
		if (m_mBankAccountProcessors == null || m_mBankAccountProcessors.length == 0)
			m_mBankAccountProcessors = MPaymentProcessor.find(ctx, tender, CCType, AD_Client_ID, C_Currency_ID, Env.ZERO, trxName);
		if (m_mBankAccountProcessors == null || m_mBankAccountProcessors.length == 0)
			return null;

		MBankAccountProcessor m_mBankAccountProcessor = null;
		//	Find the first right one
		for (int i = 0; i < m_mBankAccountProcessors.length; i++)
		{
			MBankAccountProcessor bap = m_mBankAccountProcessors[i];
			MPaymentProcessor paymentProcessor = new MPaymentProcessor(bap.getCtx(), bap.getC_PaymentProcessor_ID(), bap.get_TrxName());
			if (paymentProcessor.accepts (tender, CCType))
			{
				m_mBankAccountProcessor = m_mBankAccountProcessors[i];
				break;
			}
		}
		//
		return m_mBankAccountProcessor;
	}
	
	public GridTab getGridTab()
	{
		return m_mTab;
	}
	
	public boolean isOnlyRule()
	{
		return m_onlyRule;
	}
	
	@Override
	public boolean isApproved()
	{
		return true;
	}
	
	public int getWindowNo()
	{
		return m_WindowNo;
	}
	
	@Override
	public Object getCustomizePanel()
	{
		return null;
	}
	
	@Override
	public void setCustomizeValues()
	{
		
	}
	
	@Override
	public void setBankAccountProcessor(MBankAccountProcessor bankAccountProcessor)
	{
		
	}
}
