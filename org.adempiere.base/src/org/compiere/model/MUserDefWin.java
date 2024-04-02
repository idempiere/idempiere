/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Dirk Niemeyer                                           *
 * Copyright (C) 2012 action 42 GmbH                                          *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.ImmutablePOCache;

/**
 *	User, role, organization or tenant overrides of window model
 *  @author Dirk Niemeyer, action42 GmbH
 *  @version $Id$
 */
public class MUserDefWin extends X_AD_UserDef_Win implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7542708120229671875L;
	private static final Map<Integer, List<MUserDefWin>> m_fullMap = new ConcurrentHashMap<>();

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_UserDef_Win_UU  UUID key
     * @param trxName Transaction
     */
    public MUserDefWin(Properties ctx, String AD_UserDef_Win_UU, String trxName) {
        super(ctx, AD_UserDef_Win_UU, trxName);
    }

	/**
	 * 	Standard constructor.
	 *	@param ctx context
	 *	@param ID the primary key ID
	 *	@param trxName transaction
	 */
	public MUserDefWin (Properties ctx, int ID, String trxName)
	{
		super (ctx, ID, trxName);
	}	//	MUserDefWin

	/**
	 * 	Load Constructor.
	 *  @param ctx context
	 *  @param rs result set
	 *	@param trxName transaction
	 */
	public MUserDefWin (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MUserDefWin

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MUserDefWin(MUserDefWin copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MUserDefWin(Properties ctx, MUserDefWin copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MUserDefWin(Properties ctx, MUserDefWin copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 *  Get all MUserDefWin entries for a window
	 * 	@param ctx context
	 *  @param window_ID window
	 *  @return Array of MUserDefWin for window
	 */
	private static MUserDefWin[] getAll (Properties ctx, int window_ID )
	{
		List<MUserDefWin> fullList = null;
		fullList = m_fullMap.get(Env.getAD_Client_ID(ctx));
		if (fullList == null) {
			fullList = new Query(ctx, MUserDefWin.Table_Name, null, null)
					.setOnlyActiveRecords(true)
					.setClient_ID()
					.list();
			m_fullMap.put(Env.getAD_Client_ID(ctx), fullList);
		}
		
		if (fullList.size() == 0) {
			return null;
		}

		List<MUserDefWin> list = new ArrayList<MUserDefWin>();
		
		for (MUserDefWin udw : fullList) {
			if (udw.getAD_Window_ID() == window_ID
				&& udw.getAD_Client_ID() == Env.getAD_Client_ID(ctx)
				&& (udw.getAD_Language() == null || udw.getAD_Language().equals(Env.getAD_Language(ctx)))
				) {
				list.add(udw);
			}
		}

		if (list.size() == 0)
			return null;

		return list.toArray(new MUserDefWin[list.size()]);
	}
	
	/**
	 * Get best matching MUserDefWin for a window, 
	 * the best match is cached.
	 * @param ctx
	 * @param window_ID
	 * @return best matching MUserDefWin or null
	 */
	public static MUserDefWin getBestMatch (Properties ctx, int window_ID)
	{
		// parameters
		final int AD_Org_ID = Env.getAD_Org_ID(ctx);
		final int AD_Role_ID = Env.getAD_Role_ID(ctx);
		final int AD_User_ID = Env.getAD_User_ID(ctx);
		
		//  Check Cache
		String key = new StringBuilder().append(window_ID).append("_")
				.append(Env.getAD_Client_ID(ctx)).append("_")
				.append(Env.getAD_Language(ctx)).append("_")
				.append(AD_Org_ID).append("_")
				.append(AD_Role_ID).append("_")
				.append(AD_User_ID)
				.toString();
		if (s_cache.containsKey(key))
			return s_cache.get(ctx, key, e -> new MUserDefWin(ctx, e));

		// candidates
		MUserDefWin[] candidates = getAll(ctx, window_ID);
		if (candidates == null) {
	    	s_cache.put(key, null);
			return null;
		}
		final int size = candidates.length;
		int[] weight = new int[size];
		
		// this user + this role + this org => weight = 7
		// this user + this role + any org  => weight = 6
		// this user + any role  + this org => weight = 5
		// this user + any role  + any org  => weight = 4
		// any user  + this role + this org => weight = 3
		// any user  + this role + any org  => weight = 2
		// any user  + any role  + this org => weight = 1
		// any user  + any role  + any org  => weight = 0
		// other user or other role or other org => weight = -1 and thus ruled out
		for (int i=0; i < size; i++)
		{
			weight[i] = 0;
			if (candidates[i].getAD_User_ID() > 0) {
				if (candidates[i].getAD_User_ID() == AD_User_ID) {
					weight[i] = weight[i] + 4;
				} else {
					weight[i] = -1;
				}
			}
			if (weight[i] > -1 && candidates[i].getAD_Role_ID() > 0) {
				if (candidates[i].getAD_Role_ID() == AD_Role_ID) {
					weight[i] = weight[i] + 2;
				} else {
					weight[i] = -1;
				}
			}
			if (weight[i] > -1 && candidates[i].getAD_Org_ID() > 0) {
				if (candidates[i].getAD_Org_ID() == AD_Org_ID) {
					weight[i] = weight[i] + 1;
				} else {
					weight[i] = -1;
				}
			}
			// prefer if related to current login language
			if (weight[i] > -1 && Env.getAD_Language(ctx).equalsIgnoreCase(candidates[i].getAD_Language())) {
				weight[i] = weight[i] + 8;
			}
			// others are implicit
		}

	    int maximum = weight[0];   // start with the first value
	    int maxindex = 0;
	    for (int j=0; j<weight.length; j++) {
	        if (weight[j] > maximum) {
	            maximum = weight[j];   // new maximum
	            maxindex = j;
	        }
	    }

	    if (weight[maxindex] > -1) {
			MUserDefWin retValue = null;
	    	retValue=candidates[maxindex];
	    	s_cache.put(key, retValue, e -> new MUserDefWin(Env.getCtx(), e));
	    	return retValue;
	    } else {
	    	s_cache.put(key, null);
	    	return null;
	    }
	}
	
	/**	Cache of selected MUserDefWin entries 					**/
	private static ImmutablePOCache<String,MUserDefWin> s_cache = new ImmutablePOCache<String,MUserDefWin>(Table_Name, 3);	//  3 weights

	@Override
	protected boolean beforeSave(boolean newRecord) {
		m_fullMap.remove(getAD_Client_ID());
		return true;
	}
	
	@Override
	protected boolean beforeDelete() {
		m_fullMap.remove(getAD_Client_ID());
		return true;
	}

	@Override
	public MUserDefWin markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
}	//	MUserDefWin
