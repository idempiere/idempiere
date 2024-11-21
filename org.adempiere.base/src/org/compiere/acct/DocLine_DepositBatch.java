package org.compiere.acct;

import org.compiere.model.MBankStatement;
import org.compiere.model.MPayment;
import org.compiere.util.DB;

/**
 * Deposit Batch Line
 * @author Deepak Pansheriya
 *
 */
public class DocLine_DepositBatch extends DocLine {

	public DocLine_DepositBatch(MPayment line, Doc_BankStatement doc, Boolean isReversal) {
		super(line, doc);
		
		MPayment payment = new MPayment(line.getCtx(), line.getC_Payment_ID(), line.get_TrxName());
		
		m_C_Payment_ID = line.getC_Payment_ID();
		m_IsReversal = isReversal;

		//
		setDateDoc(payment.getDateTrx());
		setDateAcct(MBankStatement.isPostWithDateFromLine(doc.getAD_Client_ID()) ? line.getDateAcct() : doc.getDateAcct());
		setC_BPartner_ID(payment.getC_BPartner_ID());
	}

	/** Reversal Flag */
	private boolean m_IsReversal = false;
	/** Payment */
	private int m_C_Payment_ID = 0;

	/**
	 * Get Payment
	 * 
	 * @return C_Paymnet_ID
	 */
	public int getC_Payment_ID() {
		return m_C_Payment_ID;
	} // getC_Payment_ID

	/**
	 * Get AD_Org_ID
	 * 
	 * @param payment
	 *            if true get Org from payment
	 * @return org
	 */
	public int getAD_Org_ID(boolean payment) {
		if (payment && getC_Payment_ID() != 0) {
			String sql = "SELECT AD_Org_ID FROM C_Payment WHERE C_Payment_ID=?";
			int id = DB.getSQLValue(null, sql, getC_Payment_ID());
			if (id > 0)
				return id;
		}
		return super.getAD_Org_ID();
	} // getAD_Org_ID

	/**
	 * Is Reversal
	 * 
	 * @return true if reversal
	 */
	public boolean isReversal() {
		return m_IsReversal;
	} // isReversal

} // DocLine_DepositBatch