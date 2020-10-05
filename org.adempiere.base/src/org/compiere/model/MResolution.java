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
 * 	Request Resolution Model
 *  @author Jorg Janke
 *  @version $Id: MResolution.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MResolution extends X_R_Resolution implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7430644542278601152L;

	/**
	 * 	Get MResolution from Cache (immutable)
	 *	@param R_Resolution_ID id
	 *	@return MResolution
	 */
	public static MResolution get (int R_Resolution_ID)
	{
		return get(Env.getCtx(), R_Resolution_ID);
	}

	/**
	 * 	Get MResolution from Cache (immutable)
	 *	@param ctx context
	 *	@param R_Resolution_ID id
	 *	@return MResolution
	 */
	public static MResolution get (Properties ctx, int R_Resolution_ID)
	{
		Integer key = Integer.valueOf(R_Resolution_ID);
		MResolution retValue = s_cache.get (ctx, key, e -> new MResolution(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MResolution (ctx, R_Resolution_ID, (String)null);
		if (retValue.get_ID () == R_Resolution_ID)
		{
			s_cache.put (key, retValue, e -> new MResolution(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MResolution from cache
	 * @param ctx
	 * @param R_Resolution_ID
	 * @param trxName
	 * @return MResolution
	 */
	public static MResolution getCopy(Properties ctx, int R_Resolution_ID, String trxName)
	{
		MResolution resolution = get(R_Resolution_ID);
		if (resolution != null)
			resolution = new MResolution(ctx, resolution, trxName);
		return resolution;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MResolution>	s_cache	= new ImmutableIntPOCache<Integer,MResolution>(Table_Name, 10);
	
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param R_Resolution_ID id
	 *	@param trxName
	 */
	public MResolution (Properties ctx, int R_Resolution_ID, String trxName)
	{
		super (ctx, R_Resolution_ID, trxName);
	}	//	MResolution

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MResolution (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MResolution
	
	/**
	 * 
	 * @param copy
	 */
	public MResolution(MResolution copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MResolution(Properties ctx, MResolution copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MResolution(Properties ctx, MResolution copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	@Override
	public MResolution markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MResolution
