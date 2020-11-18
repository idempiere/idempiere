/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.adempiere.util.PaymentUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.IBAN;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *  BP Bank Account Model
 *
 *  @author Jorg Janke
 *  @version $Id: MBPBankAccount.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MBPBankAccount extends X_C_BP_BankAccount
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6826961806519015878L;

	/**
	 * 	Get Accounts Of BPartner
	 *	@param ctx context
	 *	@param C_BPartner_ID bpartner
	 *	@return
	 */
	public static MBPBankAccount[] getOfBPartner (Properties ctx, int C_BPartner_ID)
	{
		final String whereClause = MBPBankAccount.COLUMNNAME_C_BPartner_ID+"=?";
		List<MBPBankAccount>list = new Query(ctx,I_C_BP_BankAccount.Table_Name,whereClause,null)
		.setParameters(C_BPartner_ID)
		.setOnlyActiveRecords(true)
		.list();
		
		MBPBankAccount[] retValue = new MBPBankAccount[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getOfBPartner

	/**	Logger	*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MBPBankAccount.class);
	
	/**************************************************************************
	 * 	Constructor
	 *	@param ctx context
	 *	@param C_BP_BankAccount_ID BP bank account
	 *	@param trxName transaction
	 */
	public MBPBankAccount (Properties ctx, int C_BP_BankAccount_ID, String trxName)
	{
		super (ctx, C_BP_BankAccount_ID, trxName);
		if (C_BP_BankAccount_ID == 0)
		{
		//	setC_BPartner_ID (0);
			setIsACH (false);
			setBPBankAcctUse(BPBANKACCTUSE_Both);
		}
	}	//	MBP_BankAccount

	/**
	 * 	Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MBPBankAccount (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MBP_BankAccount

	/**
	 * 	Constructor
	 *	@param ctx context
	 * 	@param bp BP
	 *	@param bpc BP Contact
	 * 	@param location Location
	 */
	public MBPBankAccount (Properties ctx, MBPartner bp, MUser bpc, MLocation location)
	{
		this(ctx, 0, bp.get_TrxName());
		setIsACH (false);
		//
		setC_BPartner_ID(bp.getC_BPartner_ID());
		//
		setA_Name(bpc.getName());
		setA_EMail(bpc.getEMail());
		//
		setA_Street(location.getAddress1());
		setA_City(location.getCity());
		setA_Zip(location.getPostal());
		setA_State(location.getRegionName(true));
		setA_Country(location.getCountryName());
	}	//	MBP_BankAccount

	/**
	 * 
	 * @param copy
	 */
	public MBPBankAccount(MBPBankAccount copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MBPBankAccount(Properties ctx, MBPBankAccount copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MBPBankAccount(Properties ctx, MBPBankAccount copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_bank = copy.m_bank != null ? new MBank(ctx, copy.m_bank, trxName) : null;
	}
	
	/** Bank Link			*/
	private MBank		m_bank = null;

	/**
	 * 	Is Direct Deposit
	 *	@return true if dd
	 */
	public boolean isDirectDeposit()
	{
		if (!isACH())
			return false;
		String s = getBPBankAcctUse();
		if (s == null)
			return true;
		return (s.equals(BPBANKACCTUSE_Both) || s.equals(BPBANKACCTUSE_DirectDeposit));
	}	//	isDirectDeposit
	
	/**
	 * 	Is Direct Debit
	 *	@return true if dd
	 */
	public boolean isDirectDebit()
	{
		if (!isACH())
			return false;
		String s = getBPBankAcctUse();
		if (s == null)
			return true;
		return (s.equals(BPBANKACCTUSE_Both) || s.equals(BPBANKACCTUSE_DirectDebit));
	}	//	isDirectDebit
	
	
	/**
	 * 	Get Bank
	 *	@return bank
	 */
	public MBank getBank()
	{
		int C_Bank_ID = getC_Bank_ID();
		if (C_Bank_ID == 0)
			return null;
		if (m_bank == null)
			m_bank = new MBank (getCtx(), C_Bank_ID, get_TrxName());
		return m_bank;
	}	//	getBank
	
	/**
	 * 	Get Routing No
	 *	@return routing No
	 */
	public String getRoutingNo() 
	{
		MBank bank = getBank();
		String rt = super.getRoutingNo();
		if (bank != null)
			rt = bank.getRoutingNo();
		return rt;
	}	//	getRoutingNo

	/**
	 * 	Get SwiftCode
	 *	@return SwiftCode
	 */
	public String getSwiftCode() 
	{
		MBank bank = getBank();
		if (bank != null)
			return bank.getSwiftCode();
		return null;
	}	//	getSwiftCode
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave(boolean newRecord) 
	{
		//	maintain routing on bank level
		if (isACH() && getBank() != null)
			setRoutingNo(null);
		//
		if (getCreditCardNumber() != null)
		{
			String encrpytedCCNo = PaymentUtil.encrpytCreditCard(getCreditCardNumber());
			if (!encrpytedCCNo.equals(getCreditCardNumber()))
				setCreditCardNumber(encrpytedCCNo);
		}
		
		if (getCreditCardVV() != null)
		{
			String encrpytedCvv = PaymentUtil.encrpytCvv(getCreditCardVV());
			if (!encrpytedCvv.equals(getCreditCardVV()))
				setCreditCardVV(encrpytedCvv);
		}
		
		if (MSysConfig.getBooleanValue(MSysConfig.IBAN_VALIDATION, true, Env.getAD_Client_ID(Env.getCtx()))) {
			if (!Util.isEmpty(getIBAN())) {
				setIBAN(IBAN.normalizeIBAN(getIBAN()));
				if (!IBAN.isValid(getIBAN())) {
					log.saveError("Error", Msg.getMsg(getCtx(), "InvalidIBAN"));
					return false;
				}
			}
		}

		return true;
	}	//	beforeSave
	
	/**
	 *	String Representation
	 * 	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MBP_BankAccount[")
			.append (get_ID ())
			.append(", Name=").append(getA_Name())
			.append ("]");
		return sb.toString ();
	}	//	toString

}	//	MBPBankAccount
