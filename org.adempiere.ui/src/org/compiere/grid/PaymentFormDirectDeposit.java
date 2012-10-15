package org.compiere.grid;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.GridTab;
import org.compiere.model.MInvoice;
import org.compiere.process.DocAction;
import org.compiere.util.DB;
import org.compiere.util.KeyNamePair;

public abstract class PaymentFormDirectDeposit extends PaymentForm {
	public static final String PAYMENTRULE = MInvoice.PAYMENTRULE_DirectDeposit;

	public PaymentFormDirectDeposit(int WindowNo, GridTab mTab) {
		super(WindowNo, mTab);
	}
	
	public ArrayList<KeyNamePair> getBankAccountList() {
		ArrayList<KeyNamePair> list = new ArrayList<KeyNamePair>();
		
		/**
		 * 	Load Accounts
		 */
		String SQL = "SELECT a.C_BP_BankAccount_ID, NVL(b.Name, ' ')||'_'||NVL(a.AccountNo, ' ') AS Acct "
			+ "FROM C_BP_BankAccount a"
			+ " LEFT OUTER JOIN C_Bank b ON (a.C_Bank_ID=b.C_Bank_ID) "
			+ "WHERE C_BPartner_ID=?"
			+ "AND a.IsActive='Y' AND a.IsACH='Y'";
		try
		{
			PreparedStatement pstmt = DB.prepareStatement(SQL, null);
			pstmt.setInt(1, m_C_BPartner_ID);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				int key = rs.getInt(1);
				String name = rs.getString(2);
				KeyNamePair pp = new KeyNamePair(key, name);
				list.add(pp);
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException eac)
		{
			log.log(Level.SEVERE, SQL, eac);
		}
		
		return list;
	}
	
	public String processMsg;
	public boolean save()
	{
		processMsg = null;
		boolean error = false;
		
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
					log.info( "Payment Canecelled - " + m_mPaymentOriginal);
				else
				{
					processMsg = "PaymentNotCancelled " + m_mPaymentOriginal.getDocumentNo();
					error = true;
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
						processMsg = "PaymentNotCancelled " + m_mPayment.getDocumentNo();
						error = true;
					}
				}
			}
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
		
		return !error;
	}
}
