/**********************************************************************
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
*                                                                     *
* Contributors:                                                       *
* - Igor Pojzl, Cloudempiere                                          *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * User overrides for Info Window Model
 * @author Igor Pojzl, Cloudempiere
 * @version $Id$
 */
public class MUserDefInfo extends X_AD_UserDef_Info {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5611033457579880793L;

	private static final Map<Integer, List<MUserDefInfo>> m_fullMap = new HashMap<Integer, List<MUserDefInfo>>();
	
	/**
	 * 	Standard constructor.
	 * 	You must implement this constructor for Adempiere Persistency
	 * @param ctx Context
	 * @param AD_UserDef_Info_ID Primary Key ID
	 * @param trxName Transaction name
	 */
	public MUserDefInfo(Properties ctx, int AD_UserDef_Info_ID, String trxName) {
		super(ctx, AD_UserDef_Info_ID, trxName);
	}

	/**
	 * 	Optional Load Constructor.
	 * 	You would use this constructor to load several business objects.
	 *  <code>
	 * 	SELECT * FROM MyModelExample WHERE ...
	 *  </code> 
	 * @param ctx Context
	 * @param rs Result set
	 * @param trxName Transaction name
	 */
	public MUserDefInfo(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 *  Get all MUserDefInfo entries related to info window
	 * 	@param ctx Context
	 *  @param infowindow_ID Info window
	 *  @return Array of MUserDefInfo for window
	 */
	private static MUserDefInfo[] getAll (Properties ctx, int infowindow_ID )
	{
		List<MUserDefInfo> fullList = null;
		synchronized (m_fullMap) {
			fullList = m_fullMap.get(Env.getAD_Client_ID(ctx));
			if (fullList == null) {
				fullList = new Query(ctx, MUserDefInfo.Table_Name, null, null)
						.setOnlyActiveRecords(true)
						.setClient_ID()
						.list();
				m_fullMap.put(Env.getAD_Client_ID(ctx), fullList);
			}
		}
				
		if (fullList.size() == 0) {
			return null;
		}

		List<MUserDefInfo> list = new ArrayList<MUserDefInfo>();
		
		for (MUserDefInfo udw : fullList) {
			if (udw.getAD_InfoWindow_ID() == infowindow_ID
				&& udw.getAD_Client_ID() == Env.getAD_Client_ID(ctx)
				&& (udw.getAD_Language() == null || udw.getAD_Language().equals(Env.getAD_Language(ctx)))
				) {
				list.add(udw);
			}
		}

		if (list.size() == 0)
			return null;

		return list.toArray(new MUserDefInfo[list.size()]);
	}	//getAll

	/**
	 * Get best matching MUserDefWin for current window
	 * the best match is cached
	 * @param ctx
	 * @param infowindow_ID
	 * @return best matching MUserDefWin
	 */
	public static MUserDefInfo getBestMatch (Properties ctx, int infowindow_ID)
	{
		// parameters
		final int AD_Org_ID = Env.getAD_Org_ID(ctx);
		final int AD_Role_ID = Env.getAD_Role_ID(ctx);
		final int AD_User_ID = Env.getAD_User_ID(ctx);
		
		//  Check Cache
		String key = new StringBuilder().append(infowindow_ID).append("_")
				.append(Env.getAD_Client_ID(ctx)).append("_")
				.append(Env.getAD_Language(ctx)).append("_")
				.append(AD_Org_ID).append("_")
				.append(AD_Role_ID).append("_")
				.append(AD_User_ID)
				.toString();
		if (s_cache.containsKey(key))
			return s_cache.get(key);

		// candidates
		MUserDefInfo[] candidates = getAll(ctx, infowindow_ID);
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
			
			if (weight[i] > -1 && !Util.isEmpty(candidates[i].getAD_Language())) {
				if(Env.getAD_Language(ctx).equalsIgnoreCase(candidates[i].getAD_Language())) {
					weight[i] = weight[i] + 8;
				}
				else {
					weight[i] = -1;
				}
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
	    	MUserDefInfo retValue = null;
	    	retValue=candidates[maxindex];
	    	s_cache.put(key, retValue);
	    	return retValue;
	    } else {
	    	s_cache.put(key, null);
	    	return null;
	    }
	}
	
	/**	Cache of selected MUserDefInfo entries 					**/
	private static CCache<String,MUserDefInfo> s_cache = new CCache<String,MUserDefInfo>(Table_Name, 3);	//  3 weights

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

}
