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
import java.util.Properties;

import org.compiere.util.Env;
import org.compiere.util.IBAN;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;


/**
 *  Bank Account Model
 *
 *  @author Jorg Janke
 *  @version $Id: MBankAccount.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MBankAccount extends X_C_BankAccount implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3792366454862697171L;

	/**
	 * 	Get BankAccount from Cache (immutable)
	 *	@param C_BankAccount_ID id
	 *	@return MBankAccount
	 */
	public static MBankAccount get (int C_BankAccount_ID)
	{
		return get(Env.getCtx(), C_BankAccount_ID);
	}
	
	/**
	 * 	Get BankAccount from Cache (immutable)
	 *	@param ctx context
	 *	@param C_BankAccount_ID id
	 *	@return MBankAccount
	 */
	public static MBankAccount get (Properties ctx, int C_BankAccount_ID)
	{
		Integer key = Integer.valueOf(C_BankAccount_ID);
		MBankAccount retValue = s_cache.get (ctx, key, e -> new MBankAccount(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MBankAccount (ctx, C_BankAccount_ID, (String)null);
		if (retValue.get_ID () == C_BankAccount_ID)
		{
			s_cache.put (key, retValue, e -> new MBankAccount(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**
	 * Get updateable copy of MBankAccount from cache
	 * @param ctx
	 * @param C_BankAccount_ID
	 * @param trxName
	 * @return MBankAccount
	 */
	public static MBankAccount getCopy(Properties ctx, int C_BankAccount_ID, String trxName)
	{
		MBankAccount mba = get(C_BankAccount_ID);
		if (mba != null)
			mba = new MBankAccount(ctx, mba, trxName);
		return mba;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MBankAccount>	s_cache
		= new ImmutableIntPOCache<Integer,MBankAccount>(Table_Name, 5);
	
	/**
	 * 	Bank Account Model
	 *	@param ctx context
	 *	@param C_BankAccount_ID bank account
	 *	@param trxName transaction
	 */
	public MBankAccount (Properties ctx, int C_BankAccount_ID, String trxName)
	{
		super (ctx, C_BankAccount_ID, trxName);
		if (C_BankAccount_ID == 0)
		{
			setIsDefault (false);
			setBankAccountType (BANKACCOUNTTYPE_Checking);
			setCurrentBalance (Env.ZERO);
			setCreditLimit (Env.ZERO);
		}
	}	//	MBankAccount

	/**
	 * 	Bank Account Model
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MBankAccount (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MBankAccount

	/**
	 * 
	 * @param copy
	 */
	public MBankAccount(MBankAccount copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MBankAccount(Properties ctx, MBankAccount copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MBankAccount(Properties ctx, MBankAccount copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	String representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MBankAccount[")
			.append (get_ID())
			.append("-").append(getAccountNo())
			.append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Get Bank
	 *	@return bank parent
	 */
	public MBank getBank()
	{
		return MBank.getCopy(getCtx(), getC_Bank_ID(), get_TrxName());
	}	//	getBank
	
	/**
	 * 	Get Bank Name and Account No
	 *	@return Bank/Account
	 */
	public String getName()
	{
		StringBuilder msgreturn = new StringBuilder().append(getBank().getName()).append(" ").append(getAccountNo());
		return msgreturn.toString();
	}	//	getName
	
	
	/**
	 *  Before Save
	 *	@param newRecord new record
	 *	@return success  
	 */
	
	protected boolean beforeSave(boolean newRecord) {

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
	} // beforeSave

	/**
	 * 	After Save
	 *	@param newRecord new record
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (newRecord && success)
			return insert_Accounting("C_BankAccount_Acct", "C_AcctSchema_Default", null);
		return success;
	}	//	afterSave

	@Override
	public MBankAccount markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MBankAccount
