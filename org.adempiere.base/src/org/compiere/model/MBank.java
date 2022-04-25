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
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Bank Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MBank.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MBank extends X_C_Bank implements ImmutablePOSupport
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5093713970786841175L;

	/**
	 * 	Get MBank from Cache (immutable)
	 *	@param C_Bank_ID id
	 *	@return MBank
	 */
	public static MBank get (int C_Bank_ID)
	{
		return get(Env.getCtx(), C_Bank_ID);
	}
	
	/**
	 * 	Get MBank from Cache (immutable)
	 *	@param ctx context
	 *	@param C_Bank_ID id
	 *	@return MBank
	 */
	public static MBank get (Properties ctx, int C_Bank_ID)
	{
		Integer key = Integer.valueOf(C_Bank_ID);
		MBank retValue = s_cache.get (ctx, key, e -> new MBank(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MBank (ctx, C_Bank_ID, (String)null);
		if (retValue.get_ID() == C_Bank_ID)
		{
			s_cache.put (key, retValue, e -> new MBank(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**
	 * Get updateable copy of MBank from cache
	 * @param ctx
	 * @param C_Bank_ID
	 * @param trxName
	 * @return MBank
	 */
	public static MBank getCopy(Properties ctx, int C_Bank_ID, String trxName)
	{
		MBank bank = get(C_Bank_ID);
		if (bank != null)
			bank = new MBank(ctx, bank, trxName);
		return bank;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MBank> s_cache = 
		new ImmutableIntPOCache<Integer,MBank> (Table_Name, 3);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_Bank_ID bank
	 *	@param trxName trx
	 */
	public MBank (Properties ctx, int C_Bank_ID, String trxName)
	{
		super (ctx, C_Bank_ID, trxName);
	}	//	MBank

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MBank (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MBank

	/**
	 * 
	 * @param copy
	 */
	public MBank(MBank copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MBank(Properties ctx, MBank copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MBank(Properties ctx, MBank copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	public MBank(Properties ctx, int C_Bank_ID, String trxName, String... virtualColumns) {
		super(ctx, C_Bank_ID, trxName, virtualColumns);
	}

	@Override
	public MBank markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MBank[");
		sb.append (get_ID ()).append ("-").append(getName ()).append ("]");
		return sb.toString ();
	}	//	toString
	
}	//	MBank
