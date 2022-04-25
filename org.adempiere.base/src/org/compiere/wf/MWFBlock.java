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
package org.compiere.wf;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.X_AD_WF_Block;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;


/**
 *	Work Flow Commitment Block
 *	
 *  @author Jorg Janke
 *  @version $Id: MWFBlock.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MWFBlock extends X_AD_WF_Block implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -650413593723153474L;

	/**
	 * 	Get MWFBlock from Cache (immutable)
	 *	@param AD_WF_Block_ID id
	 *	@return MWFBlock
	 */
	public static MWFBlock get (int AD_WF_Block_ID)
	{
		return get(Env.getCtx(), AD_WF_Block_ID);
	}
	
	/**
	 * 	Get MWFBlock from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_WF_Block_ID id
	 *	@return MWFBlock
	 */
	public static MWFBlock get (Properties ctx, int AD_WF_Block_ID)
	{
		Integer key = Integer.valueOf(AD_WF_Block_ID);
		MWFBlock retValue = s_cache.get (ctx, key, e -> new MWFBlock(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MWFBlock (ctx, AD_WF_Block_ID, (String)null);
		if (retValue.get_ID () == AD_WF_Block_ID)
		{
			s_cache.put (key, retValue, e -> new MWFBlock(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MWFBlock>	s_cache	= new ImmutableIntPOCache<Integer,MWFBlock>(Table_Name, 20);
	
	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_WF_Block_ID id
	 * 	@param trxName transaction
	 */
	public MWFBlock (Properties ctx, int AD_WF_Block_ID, String trxName)
	{
		super (ctx, AD_WF_Block_ID, trxName);
	}	//	MWFBlock

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 * 	@param trxName transaction
	 */
	public MWFBlock (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MWFBlock
	
	/**
	 * 
	 * @param copy
	 */
	public MWFBlock(MWFBlock copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MWFBlock(Properties ctx, MWFBlock copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWFBlock(Properties ctx, MWFBlock copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MWFBlock markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MWFBlock
