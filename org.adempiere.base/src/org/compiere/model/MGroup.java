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

import org.compiere.util.CCache;
import org.compiere.util.Env;

/**
 * 	Request Group Model
 *  @author Jorg Janke
 *  @version $Id: MGroup.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MGroup extends X_R_Group
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3218102715154328611L;


	/**
	 * 	Get MGroup from Cache
	 *	@param ctx context
	 *	@param R_Group_ID id
	 *	@return MGroup
	 */
	public static MGroup get (Properties ctx, int R_Group_ID)
	{
		Integer key = Integer.valueOf(R_Group_ID);
		MGroup retValue = (MGroup) s_cache.get (key);
		if (retValue != null)
			return new MGroup(ctx, retValue);
		retValue = new MGroup (ctx, R_Group_ID, (String)null);
		if (retValue.get_ID () == R_Group_ID)
		{
			s_cache.put (key, new MGroup(Env.getCtx(), retValue));
			return retValue;
		}
		return null;
	} //	get

	/**	Cache						*/
	private static CCache<Integer,MGroup> s_cache = new CCache<Integer,MGroup>(Table_Name, 20);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param R_Group_ID group
	 *	@param trxName trx
	 */
	public MGroup (Properties ctx, int R_Group_ID, String trxName)
	{
		super (ctx, R_Group_ID, trxName);
	}	//	MGroup

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MGroup (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MGroup
	
	/**
	 * 
	 * @param copy
	 */
	public MGroup(MGroup copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MGroup(Properties ctx, MGroup copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MGroup(Properties ctx, MGroup copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
}	//	MGroup
