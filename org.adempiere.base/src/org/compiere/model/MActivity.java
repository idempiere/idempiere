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
 *	Activity Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MActivity.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 * 
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2736867 ] Add caching support to MActivity
 */
public class MActivity extends X_C_Activity implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5939026057597689130L;
	
	/** Static Cache */
	private static ImmutableIntPOCache<Integer, MActivity> s_cache = new ImmutableIntPOCache<Integer, MActivity>(Table_Name, 30);

	/**
	 * Get/Load Activity [CACHED] (immutable)
	 * @param C_Activity_ID
	 * @return activity or null
	 */
	public static MActivity get(int C_Activity_ID)
	{
		return get(Env.getCtx(), C_Activity_ID);
	}
	
	/**
	 * Get/Load Activity [CACHED] (immutable)
	 * @param ctx context
	 * @param C_Activity_ID
	 * @return activity or null
	 */
	public static MActivity get(Properties ctx, int C_Activity_ID)
	{
		if (C_Activity_ID <= 0)
		{
			return null;
		}
		// Try cache
		MActivity activity = s_cache.get(ctx, C_Activity_ID, e -> new MActivity(ctx, e));
		if (activity != null)
		{
			return activity;
		}
		// Load from DB
		activity = new MActivity(ctx, C_Activity_ID, (String)null);
		if (activity.get_ID() == C_Activity_ID)
		{
			s_cache.put(C_Activity_ID, activity, e -> new MActivity(Env.getCtx(), e));
			return activity;
		}
		return null;
	}

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_Activity_ID id
	 *	@param trxName transaction
	 */
	public MActivity (Properties ctx, int C_Activity_ID, String trxName)
	{
		super (ctx, C_Activity_ID, trxName);
	}	//	MActivity

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MActivity (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MActivity
	
	/**
	 * 
	 * @param copy
	 */
	public MActivity(MActivity copy)
	{
		this(Env.getCtx(), copy);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MActivity(Properties ctx, MActivity copy)
	{
		this(ctx, copy, (String)null);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MActivity(Properties ctx, MActivity copy, String trxName)
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	public MActivity(Properties ctx, int C_Activity_ID, String trxName, String... virtualColumns) {
		super(ctx, C_Activity_ID, trxName, virtualColumns);
	}

	/**
	 * 	After Save.
	 * 	Insert
	 * 	- create tree
	 *	@param newRecord insert
	 *	@param success save success
	 *	@return true if saved
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (newRecord)
			insert_Tree(MTree_Base.TREETYPE_Activity);
		if (newRecord || is_ValueChanged(COLUMNNAME_Value))
			update_Tree(MTree_Base.TREETYPE_Activity);
		//	Value/Name change
		if (!newRecord && (is_ValueChanged("Value") || is_ValueChanged("Name"))){
			StringBuilder msguvd = new StringBuilder("C_Activity_ID=").append(getC_Activity_ID());
			MAccount.updateValueDescription(getCtx(), msguvd.toString(), get_TrxName());
		}	
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
			delete_Tree(MTree_Base.TREETYPE_Activity);
		return success;
	}	//	afterDelete

	@Override
	public MActivity markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MActivity
