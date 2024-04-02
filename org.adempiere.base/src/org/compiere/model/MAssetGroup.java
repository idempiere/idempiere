/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * Asset Group Model
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MAssetGroup extends X_A_Asset_Group implements ImmutablePOSupport
{	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2605166916393528396L;
	
	/** Cache: ID -> MAssetGroup */
	private static ImmutableIntPOCache<Integer, MAssetGroup> s_cache = new ImmutableIntPOCache<Integer, MAssetGroup>(Table_Name, 10, 0);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Asset_Group_UU  UUID key
     * @param trxName Transaction
     */
    public MAssetGroup(Properties ctx, String A_Asset_Group_UU, String trxName) {
        super(ctx, A_Asset_Group_UU, trxName);
    }

	/**
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param A_Asset_Group_ID
	 */
	public MAssetGroup (Properties ctx, int A_Asset_Group_ID, String trxName)
	{
		super (ctx,A_Asset_Group_ID, trxName);
	}	//	MAssetGroup
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MAssetGroup (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs,  trxName);
	}	//	MAssetGroup
	
	/**
	 * Copy constructor
	 * @param copy
	 */
	public MAssetGroup(MAssetGroup copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MAssetGroup(Properties ctx, MAssetGroup copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MAssetGroup(Properties ctx, MAssetGroup copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * Get Asset Group [cache, immutable]
	 * @param A_Asset_Group_ID	asset group id
	 * @return asset group or null
	 */
	public static MAssetGroup get(int A_Asset_Group_ID)
	{
		return get(Env.getCtx(), A_Asset_Group_ID);				
	}
	
	/**
	 * Get Asset Group [cache, immutable]
	 * @param ctx context
	 * @param A_Asset_Group_ID	asset group id
	 * @return asset group or null
	 */
	public static MAssetGroup get(Properties ctx, int A_Asset_Group_ID)
	{
		if (A_Asset_Group_ID <= 0)
			return null;
		// Try cache
		MAssetGroup ag = s_cache.get(ctx, A_Asset_Group_ID, e -> new MAssetGroup(ctx, e));
		if (ag != null)
			return ag;
		// Load
		ag = new MAssetGroup(ctx, A_Asset_Group_ID, (String)null);
		if (ag.get_ID() == A_Asset_Group_ID)
		{
			s_cache.put(A_Asset_Group_ID, ag, e -> new MAssetGroup(Env.getCtx(), e));
			return ag;
		}
		return null;
	}
	
	/**
	 * Get updateable copy of MAssetGroup from cache
	 * @param ctx
	 * @param A_Asset_Group_ID
	 * @param trxName
	 * @return MAssetGroup
	 */
	public static MAssetGroup getCopy(Properties ctx, int A_Asset_Group_ID, String trxName)
	{
		MAssetGroup grp = get(A_Asset_Group_ID);
		if (grp != null)
			grp = new MAssetGroup(ctx, grp, trxName);
		return grp;
	}
	
	/**
	 * Get default asset group ID for given model.
	 * WARNING: trxName = null.
	 * @param m	reference model (used to get AD_Client_ID)
	 * @return default asset group ID or 0 if not found
	 */
	public static int getDefault_ID(SetGetModel m)
	{
		int AD_Client_ID = SetGetUtil.get_AttrValueAsInt(m, "AD_Client_ID");
		final String sql = "SELECT "+COLUMNNAME_A_Asset_Group_ID
				+ " FROM "+Table_Name
				+ " WHERE AD_Client_ID=?"
				+ " ORDER BY "+COLUMNNAME_IsDefault+" DESC"
							+", "+COLUMNNAME_A_Asset_Group_ID+" ASC" // default first, older first
		;
		int id = DB.getSQLValueEx(null, sql, AD_Client_ID);
		
		return id;
	}
	
	/**
	 * Update Asset<br/>
	 * - updates asset M_AssetGroup_ID if is null
	 */
	public static void updateAsset(SetGetModel m, int A_Asset_Group_ID)
	{
		if (A_Asset_Group_ID < 0) {
			A_Asset_Group_ID = MAssetGroup.getDefault_ID(SetGetUtil.wrap(m));
			m.set_AttrValue(MAsset.COLUMNNAME_A_Asset_Group_ID, A_Asset_Group_ID);
		}
	}

	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if(!success)
		{
			return false;
		}
		//
		if (newRecord)
		{
			// If this is not the default group, then copy accounting settings from default group
			int default_id = getDefault_ID(SetGetUtil.wrap(this));
			if (default_id > 0 && default_id != get_ID())
			{
				for (MAssetGroupAcct acct : MAssetGroupAcct.forA_Asset_Group_ID(getCtx(), default_id, null, get_TrxName()))
				{
					MAssetGroupAcct newAcct = acct.copy(this);
					newAcct.saveEx(get_TrxName());
				}
			}
		}
		//
		return true;
	}
	
	@Override
	public MAssetGroup markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MAssetGroup

