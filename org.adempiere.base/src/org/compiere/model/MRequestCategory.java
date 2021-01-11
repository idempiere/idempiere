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
 * 	Request Category Model
 *  @author Jorg Janke
 *  @version $Id: MRequestCategory.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MRequestCategory extends X_R_Category implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 984010124643923205L;

	/**
	 * 	Get MCategory from Cache (immutable)
	 *	@param R_Category_ID id
	 *	@return MCategory
	 */
	public static MRequestCategory get (int R_Category_ID)
	{
		return get(Env.getCtx(), R_Category_ID);				
	}
	
	/**
	 * 	Get MCategory from Cache (immutable)
	 *	@param ctx context
	 *	@param R_Category_ID id
	 *	@return MCategory
	 */
	public static MRequestCategory get (Properties ctx, int R_Category_ID)
	{
		Integer key = Integer.valueOf(R_Category_ID);
		MRequestCategory retValue = s_cache.get (ctx, key, e -> new MRequestCategory(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MRequestCategory (ctx, R_Category_ID, (String)null);
		if (retValue.get_ID () == R_Category_ID)
		{
			s_cache.put (key, retValue, e -> new MRequestCategory(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**
	 * Get updateable copy of MRequestCategory from cache
	 * @param ctx
	 * @param R_Category_ID
	 * @param trxName
	 * @return MRequestCategory
	 */
	public static MRequestCategory getCopy(Properties ctx, int R_Category_ID, String trxName)
	{
		MRequestCategory rc = get(R_Category_ID);
		if (rc != null)
			rc = new MRequestCategory(ctx, rc, trxName);
		return rc;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MRequestCategory>	s_cache	
		= new ImmutableIntPOCache<Integer,MRequestCategory>(Table_Name, 20);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param R_Category_ID id
	 *	@param trxName trx
	 */
	public MRequestCategory (Properties ctx, int R_Category_ID, String trxName)
	{
		super (ctx, R_Category_ID, trxName);
	}	//	MCategory

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MRequestCategory (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MCategory
	
	/**
	 * 
	 * @param copy
	 */
	public MRequestCategory(MRequestCategory copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MRequestCategory(Properties ctx, MRequestCategory copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRequestCategory(Properties ctx, MRequestCategory copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	@Override
	public MRequestCategory markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MCategory
