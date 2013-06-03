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

package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Msg;

/**
 * Bank Account Payment Processor
 * @author Elaine
 * @date October 17, 2012
 */
public class MBankAccountProcessor extends X_C_BankAccount_Processor {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9082774421123292838L;

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MBankAccountProcessor.class);
	
	public static MBankAccountProcessor[] find (Properties ctx,
			String tender, String CCType,
			int AD_Client_ID, int AD_Org_ID, int C_Currency_ID, BigDecimal Amt, String trxName)
	{
		return find(ctx, tender, CCType, AD_Client_ID, C_Currency_ID, Amt, trxName);
	}
	
	/**
	 * 	Get Bank Account Processor
	 * 	@param ctx context
	 *  @param tender optional Tender see TENDER_
	 *  @param CCType optional CC Type see CC_
	 *  @param AD_Client_ID Client
	 *  @param C_Currency_ID Currency (ignored)
	 *  @param Amt Amount (ignored)
	 *	@param trxName transaction
	 *  @return Array of BankAccount[0] & PaymentProcessor[1] or null
	 */
	public static MBankAccountProcessor[] find (Properties ctx,
		String tender, String CCType,
		int AD_Client_ID, int C_Currency_ID, BigDecimal Amt, String trxName)
	{
		ArrayList<MBankAccountProcessor> list = new ArrayList<MBankAccountProcessor>();
		StringBuffer sql = new StringBuffer("SELECT bap.* "
				+ "FROM C_BankAccount_Processor bap, C_PaymentProcessor pp, C_BankAccount ba "
				+ "WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID" 
				+ " AND ba.C_BankAccount_ID = bap.C_BankAccount_ID" 
				+ " AND ba.AD_Client_ID=? AND pp.IsActive='Y'"				//	#1
				+ " AND ba.IsActive='Y' AND bap.IsActive='Y' "
				+ " AND (bap.C_Currency_ID IS NULL OR bap.C_Currency_ID=?)"		//	#2
				+ " AND (bap.MinimumAmt IS NULL OR bap.MinimumAmt = 0 OR bap.MinimumAmt <= ?)");	//	#3
		if (MPayment.TENDERTYPE_DirectDeposit.equals(tender))
			sql.append(" AND bap.AcceptDirectDeposit='Y' AND pp.AcceptDirectDeposit='Y' ");
		else if (MPayment.TENDERTYPE_DirectDebit.equals(tender))
			sql.append(" AND bap.AcceptDirectDebit='Y' AND AND pp.AcceptDirectDebit='Y' ");
		else if (MPayment.TENDERTYPE_Check.equals(tender))
			sql.append(" AND bap.AcceptCheck='Y' AND pp.AcceptCheck='Y' ");
		//  CreditCards
		else if (MPayment.CREDITCARDTYPE_ATM.equals(CCType))
			sql.append(" AND bap.AcceptATM='Y' AND pp.AcceptATM='Y' ");
		else if (MPayment.CREDITCARDTYPE_Amex.equals(CCType))
			sql.append(" AND bap.AcceptAMEX='Y' AND pp.AcceptAMEX='Y' ");
		else if (MPayment.CREDITCARDTYPE_Visa.equals(CCType))
			sql.append(" AND bap.AcceptVISA='Y' AND pp.AcceptVISA='Y' ");
		else if (MPayment.CREDITCARDTYPE_MasterCard.equals(CCType))
			sql.append(" AND bap.AcceptMC='Y' AND pp.AcceptMC='Y' ");
		else if (MPayment.CREDITCARDTYPE_Diners.equals(CCType))
			sql.append(" AND bap.AcceptDiners='Y' AND pp.AcceptDiners='Y' ");
		else if (MPayment.CREDITCARDTYPE_Discover.equals(CCType))
			sql.append(" AND bap.AcceptDiscover='Y' AND pp.AcceptDiscover='Y' ");
		else if (MPayment.CREDITCARDTYPE_PurchaseCard.equals(CCType))
			sql.append(" AND bap.AcceptCORPORATE='Y' AND pp.AcceptCORPORATE='Y' ");
		sql.append(" ORDER BY ba.IsDefault DESC ");
		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), trxName);
			pstmt.setInt(1, AD_Client_ID);
			pstmt.setInt(2, C_Currency_ID);
			pstmt.setBigDecimal(3, Amt);
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MBankAccountProcessor (ctx, rs, trxName));
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, "find - " + sql, e);
			return null;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		if (list.size() == 0)
			s_log.warning("find - not found - AD_Client_ID=" + AD_Client_ID
				+ ", C_Currency_ID=" + C_Currency_ID + ", Amt=" + Amt);
		else
			if (s_log.isLoggable(Level.FINE)) s_log.fine("find - #" + list.size() + " - AD_Client_ID=" + AD_Client_ID
				+ ", C_Currency_ID=" + C_Currency_ID + ", Amt=" + Amt);
		MBankAccountProcessor[] retValue = new MBankAccountProcessor[list.size()];
		list.toArray(retValue);
		return retValue;
	}   //  find
	
	public static MBankAccountProcessor get(Properties ctx, int C_BankAccount_ID, int C_PaymentProcessor_ID, String trxName) 
	{
		final String whereClause = MBankAccountProcessor.COLUMNNAME_C_BankAccount_ID + "=? AND " + MBankAccountProcessor.COLUMNNAME_C_PaymentProcessor_ID + "=?";
		MBankAccountProcessor retValue = new Query(ctx, I_C_BankAccount_Processor.Table_Name, whereClause, trxName)
		.setParameters(C_BankAccount_ID, C_PaymentProcessor_ID)
		.first();
		return retValue;
	}
	
	public MBankAccountProcessor (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}
	
	public MBankAccountProcessor (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public MBankAccountProcessor (Properties ctx, int C_BankAccount_ID, int C_PaymentProcessor_ID, String trxName)
	{
		this (ctx, 0, trxName);
		setC_BankAccount_ID(C_BankAccount_ID);	//	FK
		setC_PaymentProcessor_ID(C_PaymentProcessor_ID);	//	FK
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord) 
	{
		if (getC_PaymentProcessor_ID() > 0 && isActive())
		{
			MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
			if (!pp.isActive())
				throw new AdempiereException(Msg.translate(getCtx(), "InactivePaymentProcessor") + ". " + pp.toString());
		}
		
		return true;
	}

	/**
	 * 	Does Payment Processor accepts tender / CC
	 *	@param TenderType tender type
	 *	@param CreditCardType credit card type
	 *	@return true if acceptes
	 */
	public boolean accepts (String TenderType, String CreditCardType)
	{
		if (getC_PaymentProcessor_ID() > 0)
		{
			MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
			
			if ((MPayment.TENDERTYPE_DirectDeposit.equals(TenderType) && isAcceptDirectDeposit() && pp.isAcceptDirectDeposit())
				|| (MPayment.TENDERTYPE_DirectDebit.equals(TenderType) && isAcceptDirectDebit() && pp.isAcceptDirectDebit())
				|| (MPayment.TENDERTYPE_Check.equals(TenderType) && isAcceptCheck() && pp.isAcceptCheck())
				//
				|| (MPayment.CREDITCARDTYPE_ATM.equals(CreditCardType) && isAcceptATM() && pp.isAcceptATM())
				|| (MPayment.CREDITCARDTYPE_Amex.equals(CreditCardType) && isAcceptAMEX() && pp.isAcceptAMEX())
				|| (MPayment.CREDITCARDTYPE_PurchaseCard.equals(CreditCardType) && isAcceptCorporate() && pp.isAcceptCorporate())
				|| (MPayment.CREDITCARDTYPE_Diners.equals(CreditCardType) && isAcceptDiners() && pp.isAcceptDiners())
				|| (MPayment.CREDITCARDTYPE_Discover.equals(CreditCardType) && isAcceptDiscover() && pp.isAcceptDiscover())
				|| (MPayment.CREDITCARDTYPE_MasterCard.equals(CreditCardType) && isAcceptMC() && pp.isAcceptMC())
				|| (MPayment.CREDITCARDTYPE_Visa.equals(CreditCardType) && isAcceptVisa() && pp.isAcceptVisa()))
				return true;
			return false;
		}
		else
		{
			if ((MPayment.TENDERTYPE_DirectDeposit.equals(TenderType) && isAcceptDirectDeposit())
					|| (MPayment.TENDERTYPE_DirectDebit.equals(TenderType) && isAcceptDirectDebit())
					|| (MPayment.TENDERTYPE_Check.equals(TenderType) && isAcceptCheck())
					//
					|| (MPayment.CREDITCARDTYPE_ATM.equals(CreditCardType) && isAcceptATM())
					|| (MPayment.CREDITCARDTYPE_Amex.equals(CreditCardType) && isAcceptAMEX())
					|| (MPayment.CREDITCARDTYPE_PurchaseCard.equals(CreditCardType) && isAcceptCorporate())
					|| (MPayment.CREDITCARDTYPE_Diners.equals(CreditCardType) && isAcceptDiners())
					|| (MPayment.CREDITCARDTYPE_Discover.equals(CreditCardType) && isAcceptDiscover())
					|| (MPayment.CREDITCARDTYPE_MasterCard.equals(CreditCardType) && isAcceptMC())
					|| (MPayment.CREDITCARDTYPE_Visa.equals(CreditCardType) && isAcceptVisa()))
				return true;
			return false;
		}
	}	//	accepts
	
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MBankAccountProcessor[")
		.append("C_BankAccount_ID=").append(getC_BankAccount_ID())
		.append(",C_PaymentProcessor_ID=").append(getC_PaymentProcessor_ID())
		.append("]");
		return sb.toString ();
	}
	
	public String getHostAddress() 
	{
		MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
		return pp.getHostAddress();
	}
	
	public int getHostPort() 
	{
		MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
		return pp.getHostPort();
	}
	
	public String getProxyAddress() 
	{
		MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
		return pp.getProxyAddress();
	}
	
	public int getProxyPort()
	{
		MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
		return pp.getProxyPort();
	}
	
	public String getProxyLogon()
	{
		MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
		return pp.getProxyLogon();
	}
	
	public String getProxyPassword()
	{
		MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
		return pp.getProxyPassword();
	}
}
