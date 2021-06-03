/******************************************************************************
 * Copyright (C) 2019 devCoffee - #3858                                       *
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * Model class for Process Customizations
 *
 * @author raphael.gildo (devCoffee, www.devcoffee.com.br)
 *
 */
public class MUserDefProc extends X_AD_UserDef_Proc implements ImmutablePOSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1599140293008534080L;
	private static final Map<Integer, List<MUserDefProc>> m_fullMap = new HashMap<Integer, List<MUserDefProc>>();

	/**
	 * @param ctx
	 * @param AD_UserDef_Proc_ID
	 * @param trxName
	 */
	public MUserDefProc(Properties ctx, int AD_UserDef_Proc_ID, String trxName) {
		super(ctx, AD_UserDef_Proc_ID, trxName);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MUserDefProc(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
		// TODO Auto-generated constructor stub
	}

	/**
	 * 
	 * @param copy
	 */
	public MUserDefProc(MUserDefProc copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MUserDefProc(Properties ctx, MUserDefProc copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MUserDefProc(Properties ctx, MUserDefProc copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	private static MUserDefProc[] getAll (Properties ctx, int processID)
	{
		List<MUserDefProc> fullList = null;
		synchronized (m_fullMap) {
			fullList = m_fullMap.get(Env.getAD_Client_ID(ctx));
			if (fullList == null) {
				fullList = new Query(ctx, MUserDefProc.Table_Name, null, null)
						.setOnlyActiveRecords(true)
						.setClient_ID()
						.list();
				m_fullMap.put(Env.getAD_Client_ID(ctx), fullList);
			}
		}

		if (fullList.size() == 0) {
			return null;
		}

		List<MUserDefProc> list = new ArrayList<MUserDefProc>();

		for (MUserDefProc udp : fullList) {
			if (udp.getAD_Process_ID() == processID
				&& udp.getAD_Client_ID() == Env.getAD_Client_ID(ctx)
				&& (udp.getAD_Language() == null || udp.getAD_Language().equals(Env.getAD_Language(ctx)))
				) {
				list.add(udp);
			}
		}

		if (list.size() == 0)
			return null;

		return list.toArray(new MUserDefProc[list.size()]);
	}

	public static MUserDefProc getBestMatch (Properties ctx, int AD_Process_ID)
	{
		final int AD_Org_ID = Env.getAD_Org_ID(ctx);
		final int AD_Role_ID = Env.getAD_Role_ID(ctx);
		final int AD_User_ID = Env.getAD_User_ID(ctx);

		//Check Cache
		String key = new StringBuilder().append(AD_Process_ID).append("_")
				.append(Env.getAD_Client_ID(ctx)).append("_")
				.append(Env.getAD_Language(ctx)).append("_")
				.append(AD_Org_ID).append("_")
				.append(AD_Role_ID).append("_")
				.append(AD_User_ID)
				.toString();
		if (s_cache.containsKey(key))
			return s_cache.get(ctx, key, e -> new MUserDefProc(ctx, e));

		//candidates
		MUserDefProc[] candidates = getAll(ctx, AD_Process_ID);
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
	    for (int i=0; i<weight.length; i++) {
	        if (weight[i] > maximum) {
	            maximum = weight[i];   // new maximum
	            maxindex = i;
	        }
	    }

	    if (weight[maxindex] > -1) {
	    	MUserDefProc retValue = null;
	    	retValue = candidates[maxindex];
	    	s_cache.put(key, retValue, e -> new MUserDefProc(Env.getCtx(), e));
	    	return retValue;
	    } else {
	    	s_cache.put(key, null);
	    	return null;
	    }
	}

	//Cache of selected MUserDefProc entries 					**/
	private static ImmutablePOCache<String, MUserDefProc> s_cache = new ImmutablePOCache<String, MUserDefProc>(Table_Name, 3);	//  3 weights

	@Override
	protected boolean beforeSave(boolean newRecord) {
		synchronized (m_fullMap) {
			m_fullMap.remove(getAD_Client_ID());
		}
		return true;
	}

	@Override
	protected boolean beforeDelete() {
		synchronized (m_fullMap) {
			m_fullMap.remove(getAD_Client_ID());
		}
		return true;
	}

	@Override
	public MUserDefProc markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
