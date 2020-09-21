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
 *	Sales Region Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MSalesRegion.java,v 1.3 2006/07/30 00:54:54 jjanke Exp $
 */
public class MSalesRegion extends X_C_SalesRegion implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1958080117315345389L;


	/**
	 * 	Get SalesRegion from Cache (immutable)
	 *	@param C_SalesRegion_ID id
	 *	@return MSalesRegion
	 */
	public static MSalesRegion get (int C_SalesRegion_ID)
	{
		return get(Env.getCtx(), C_SalesRegion_ID);
	}
	
	/**
	 * 	Get SalesRegion from Cache (immutable)
	 *	@param ctx context
	 *	@param C_SalesRegion_ID id
	 *	@return MSalesRegion
	 */
	public static MSalesRegion get (Properties ctx, int C_SalesRegion_ID)
	{
		Integer key = Integer.valueOf(C_SalesRegion_ID);
		MSalesRegion retValue = (MSalesRegion) s_cache.get (ctx, key, e -> new MSalesRegion(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MSalesRegion (ctx, C_SalesRegion_ID, (String)null);
		if (retValue.get_ID () == C_SalesRegion_ID)
		{
			s_cache.put (key, retValue, e -> new MSalesRegion(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MSalesRegion>	s_cache	= new ImmutableIntPOCache<Integer,MSalesRegion>(Table_Name, 10);
	
	
	/**************************************************************************
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param C_SalesRegion_ID id
	 *	@param trxName transaction
	 */
	public MSalesRegion (Properties ctx, int C_SalesRegion_ID, String trxName)
	{
		super (ctx, C_SalesRegion_ID, trxName);
	}	//	MSalesRegion

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MSalesRegion (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MSalesRegion

	/**
	 * 
	 * @param copy
	 */
	public MSalesRegion(MSalesRegion copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MSalesRegion(Properties ctx, MSalesRegion copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MSalesRegion(Properties ctx, MSalesRegion copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	After Save.
	 * 	Insert
	 * 	- create tree
	 *	@param newRecord insert
	 *	@param success save success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (newRecord)
			insert_Tree(MTree_Base.TREETYPE_SalesRegion);
		if (newRecord || is_ValueChanged(COLUMNNAME_Value))
			update_Tree(MTree_Base.TREETYPE_SalesRegion);
		//	Value/Name change
		if (!newRecord && (is_ValueChanged("Value") || is_ValueChanged("Name")))
			MAccount.updateValueDescription(getCtx(), "C_SalesRegion_ID=" + getC_SalesRegion_ID(), get_TrxName());

		return true;
	}	//	afterSave

	/**
	 * 	After Delete
	 *	@param success
	 *	@return deleted
	 */
	protected boolean afterDelete (boolean success)
	{
		if (success)
			delete_Tree(MTree_Base.TREETYPE_SalesRegion);
		return success;
	}	//	afterDelete

	@Override
	public MSalesRegion markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MSalesRegion
