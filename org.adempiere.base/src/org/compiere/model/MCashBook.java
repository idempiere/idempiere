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

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Cash Book Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MCashBook.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 *  @author red1 - FR: [ 2214883 ] Remove SQL code and Replace for Query
 */
public class MCashBook extends X_C_CashBook implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -743516751730874877L;

	/**
	 * 	Get MCashBook from Cache (immutable))
	 *	@param C_CashBook_ID id
	 *	@return MCashBook
	 */
	public static MCashBook get (int C_CashBook_ID)
	{
		return get(Env.getCtx(), C_CashBook_ID);
	}
	
	/**
	 * 	Get MCashBook from Cache (immutable)
	 *	@param ctx context
	 *	@param C_CashBook_ID id
	 *	@return MCashBook
	 */
	public static MCashBook get (Properties ctx, int C_CashBook_ID)
	{
		return get(ctx, C_CashBook_ID, (String)null);
	}	//	get
	
	/**
	 * Gets MCashBook from Cache (immutabble)
	 * @param ctx 				context	
	 * @param C_CashBook_ID		id of cashbook to load
	 * @param trxName			transaction to load mcashbook if it is not in cache
	 * @return   Cashbook
	 */
	public static MCashBook get(Properties ctx, int C_CashBook_ID, String trxName)
	{
		Integer key = Integer.valueOf(C_CashBook_ID);
		MCashBook retValue = s_cache.get (ctx, key, e -> new MCashBook(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MCashBook (ctx, C_CashBook_ID, trxName);
		if (retValue.get_ID () == C_CashBook_ID)
		{
			s_cache.put (key, retValue, e -> new MCashBook(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MCashBook from cache
	 * @param ctx
	 * @param C_CashBook_ID
	 * @param trxName
	 * @return MCashBook 
	 */
	public static MCashBook getCopy(Properties ctx, int C_CashBook_ID, String trxName)
	{
		MCashBook cb = get(ctx, C_CashBook_ID, trxName);
		if (cb != null)
			cb = new MCashBook(ctx, cb, trxName);
		return cb;
	}
	
	/**
	 * 	Get CashBook for Org and Currency
	 *	@param ctx context
	 *	@param AD_Org_ID org
	 *	@param C_Currency_ID currency
	 *	@return cash book or null
	 */
	public static MCashBook get (Properties ctx, int AD_Org_ID, int C_Currency_ID)
	{
		//	Try from cache
		MCashBook[] it = s_cache.values().toArray(new MCashBook[0]);
		for (MCashBook cb : it)
		{
			if (cb.getAD_Org_ID() == AD_Org_ID && cb.getC_Currency_ID() == C_Currency_ID)
				return new MCashBook(ctx, cb);
		}
		
		//	Get from DB
		final String whereClause = I_C_CashBook.COLUMNNAME_AD_Org_ID+"=? AND "+I_C_CashBook.COLUMNNAME_C_Currency_ID+"=?";
		MCashBook retValue = new Query(ctx,I_C_CashBook.Table_Name,whereClause,null)
		.setParameters(AD_Org_ID,C_Currency_ID)
		.setOrderBy("IsDefault DESC")
		.first();
		if (retValue!=null)
		{
			Integer key = Integer.valueOf(retValue.getC_CashBook_ID());
			s_cache.put (key, new MCashBook(Env.getCtx(), retValue));
		}
		return retValue;
	}	//	get
	

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MCashBook> s_cache
		= new ImmutableIntPOCache<Integer,MCashBook>(Table_Name, 20);
	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MCashBook.class);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_CashBook_ID id
	 *	@param trxName transaction
	 */
	public MCashBook (Properties ctx, int C_CashBook_ID, String trxName)
	{
		super (ctx, C_CashBook_ID, trxName);
	}	//	MCashBook

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCashBook (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCashBook
	
	/**
	 * 
	 * @param copy
	 */
	public MCashBook(MCashBook copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MCashBook(Properties ctx, MCashBook copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MCashBook(Properties ctx, MCashBook copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (newRecord && success)
			insert_Accounting("C_CashBook_Acct", "C_AcctSchema_Default", null);

		return success;
	}	//	afterSave

	@Override
	public MCashBook markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MCashBook
