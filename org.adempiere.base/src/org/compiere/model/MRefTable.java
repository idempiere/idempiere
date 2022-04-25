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


public class MRefTable extends X_AD_Ref_Table implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5068032076487795624L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Reference_ID id warning if you are referring to reference list or table type should be used AD_Reference_Value_ID
	 *	@param trxName trx
	 */
	public MRefTable (Properties ctx, int AD_Reference_ID, String trxName)
	{
		super (ctx, AD_Reference_ID, trxName);
		if (AD_Reference_ID == 0)
		{
			setEntityType (ENTITYTYPE_UserMaintained);	// U
			setIsValueDisplayed (false);
		}
	}	//	MRefTable

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MRefTable (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MRefTable

	/**
	 * 
	 * @param copy
	 */
	public MRefTable(MRefTable copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MRefTable(Properties ctx, MRefTable copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRefTable(Properties ctx, MRefTable copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public I_AD_Table getAD_Table() throws RuntimeException {
		MTable table = MTable.getCopy(getCtx(), getAD_Table_ID(), get_TrxName());
		return table;
	}

	/**	Ref Table Cache				*/
	private static ImmutableIntPOCache<Integer,MRefTable>	s_cache = new ImmutableIntPOCache<Integer,MRefTable>(Table_Name, 20);

	/**
	 * 	Get from Cache
	 *	@param AD_Reference_ID id
	 *	@return category
	 */
	public static MRefTable get (int AD_Reference_ID)
	{
		return get(Env.getCtx(), AD_Reference_ID);
	}
	
	/**
	 * 	Get from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Reference_ID id
	 *	@return category
	 */
	public static MRefTable get (Properties ctx, int AD_Reference_ID)
	{
		return get (ctx, AD_Reference_ID, null);
	}

	/**
	 * 	Get from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Reference_ID id
	 *  @param trxName trx
	 *	@return category
	 */
	public static MRefTable get (Properties ctx, int AD_Reference_ID, String trxName)
	{
		Integer ii = Integer.valueOf(AD_Reference_ID);
		MRefTable retValue = s_cache.get(ctx, ii, e -> new MRefTable(ctx, e));
		if (retValue != null) {
			return retValue;
		}
		retValue = new MRefTable (ctx, AD_Reference_ID, trxName);
		if (retValue.get_ID () == AD_Reference_ID)
		{
			s_cache.put (AD_Reference_ID, retValue, e -> new MRefTable(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	@Override
	public MRefTable markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MRefTable
