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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Charge Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MCharge.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 *  
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>FR [ 2214883 ] Remove SQL code and Replace for Query
 */
public class MCharge extends X_C_Charge implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1978008783808254164L;

	/**
	 *  Get Charge Account
	 *  @param C_Charge_ID charge
	 *  @param as account schema
	 *  @param amount amount NOT USED
	 *  @return Charge Account or null
	 *  @deprecated use getAccount(Charge, as) instead
	 */
	@Deprecated(forRemoval = true, since = "11")
	public static MAccount getAccount (int C_Charge_ID, MAcctSchema as, BigDecimal amount)
	{
		return getAccount (C_Charge_ID, as);
	}   //  getAccount

	/**
	 *  Get Charge Account
	 *  @param C_Charge_ID charge
	 *  @param as account schema
	 *  @return Charge Account or null
	 */
	public static MAccount getAccount (int C_Charge_ID, MAcctSchema as)
	{
		if (C_Charge_ID == 0 || as == null)
			return null;

		String sql = "SELECT Ch_Expense_Acct FROM C_Charge_Acct WHERE C_Charge_ID=? AND C_AcctSchema_ID=?";
		int Account_ID = DB.getSQLValueEx(null, sql, C_Charge_ID, as.get_ID());
		//	No account
		if (Account_ID <= 0)
		{
			s_log.severe ("NO account for C_Charge_ID=" + C_Charge_ID);
			return null;
		}

		//	Return Account
		MAccount acct = MAccount.get (as.getCtx(), Account_ID);
		return acct;
	}   //  getAccount

	/**
	 * 	Get MCharge from Cache (immutable)
	 *	@param C_Charge_ID id
	 *	@return MCharge
	 */
	public static MCharge get (int C_Charge_ID)
	{
		return get(Env.getCtx(), C_Charge_ID);
	}
	
	/**
	 * 	Get MCharge from Cache (immutable)
	 *	@param ctx context
	 *	@param C_Charge_ID id
	 *	@return MCharge
	 */
	public static MCharge get (Properties ctx, int C_Charge_ID)
	{
		Integer key = Integer.valueOf(C_Charge_ID);
		MCharge retValue = (MCharge)s_cache.get (ctx, key, e -> new MCharge(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MCharge (ctx, C_Charge_ID, (String)null);
		if (retValue.get_ID() == C_Charge_ID)
		{
			s_cache.put (key, retValue, e -> new MCharge(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MCharge from cache
	 * @param ctx
	 * @param C_Charge_ID
	 * @param trxName
	 * @return MCharge
	 */
	public static MCharge getCopy(Properties ctx, int C_Charge_ID, String trxName)
	{
		MCharge charge = get(C_Charge_ID);
		if (charge != null)
			charge = new MCharge(ctx, charge, trxName);
		return charge;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer, MCharge> s_cache 
		= new ImmutableIntPOCache<Integer, MCharge> (Table_Name, 10);
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MCharge.class);
		
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_Charge_UU  UUID key
     * @param trxName Transaction
     */
    public MCharge(Properties ctx, String C_Charge_UU, String trxName) {
        super(ctx, C_Charge_UU, trxName);
		if (Util.isEmpty(C_Charge_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_Charge_ID id
	 *	@param trxName transaction
	 */
	public MCharge (Properties ctx, int C_Charge_ID, String trxName)
	{
		super (ctx, C_Charge_ID, trxName);
		if (C_Charge_ID == 0)
			setInitialDefaults();
	}	//	MCharge

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setChargeAmt (Env.ZERO);
		setIsSameCurrency (false);
		setIsSameTax (false);
		setIsTaxIncluded (false);	// N
	}

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCharge (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCharge

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MCharge(MCharge copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MCharge(Properties ctx, MCharge copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MCharge(Properties ctx, MCharge copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		// Create accounting records (C_Charge_Acct)
		if (newRecord && success)
			insert_Accounting("C_Charge_Acct", "C_AcctSchema_Default", null);

		return success;
	}	//	afterSave

	@Override
	public MCharge markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MCharge
