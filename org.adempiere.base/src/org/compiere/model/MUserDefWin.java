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
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.Env;

/**
 *	User overrides for window model
 *  @author Dirk Niemeyer, action42 GmbH
 *  @version $Id$
 *  
 */
public class MUserDefWin extends X_AD_UserDef_Win
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5775251886672840324L;

	private static List<MUserDefWin> m_fullList = null;

	/**
	 * 	Standard constructor.
	 * 	You must implement this constructor for Adempiere Persistency
	 *	@param ctx context
	 *	@param ID the primary key ID
	 *	@param trxName transaction
	 */
	public MUserDefWin (Properties ctx, int ID, String trxName)
	{
		super (ctx, ID, trxName);
	}	//	MUserDefWin

	/**
	 * 	Optional Load Constructor.
	 * 	You would use this constructor to load several business objects.
	 *  <code>
	 * 	SELECT * FROM MyModelExample WHERE ...
	 *  </code> 
	 *  @param ctx context
	 *  @param rs result set
	 *	@param trxName transaction
	 */
	public MUserDefWin (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MUserDefWin

	/**
	 *  Get all MUserDefWin entries related to window
	 * 	@param ctx context
	 *  @param window_ID window
	 *  @return Array of MUserDefWin for window
	 */
	private static MUserDefWin[] getAll (Properties ctx, int window_ID )
	{
		if (m_fullList == null) {
			m_fullList = new Query(ctx, MUserDefWin.Table_Name, "IsActive='Y'", null).list();
		}
		
		if (m_fullList.size() == 0) {
			return null;
		}

		List<MUserDefWin> list = new ArrayList<MUserDefWin>();
		
		for (MUserDefWin udw : m_fullList) {
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
	 * Get best matching MUserDefWin for current window
	 * the best match is cached
	 * @param ctx
	 * @param window_ID
	 * @return best matching MUserDefWin
	 */
	public static MUserDefWin getBestMatch (Properties ctx, int window_ID)
	{
		//  Check Cache
		Integer key = new Integer(window_ID);
		MUserDefWin retValue = (MUserDefWin)s_cache.get(key);
		if (retValue != null)
			return retValue;

		// parameters
		final int AD_Org_ID = Env.getAD_Org_ID(ctx);
		//final int anyOrg = 0;
		final int AD_Role_ID = Env.getAD_Role_ID(ctx);
		//final String anyRole = "NULL";
		final int AD_User_ID = Env.getAD_User_ID(ctx);
		//final String anyUser = "NULL";
		
		// candidates
		MUserDefWin[] candidates = getAll(ctx, window_ID);
		if (candidates == null)
			return null;
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
	    	retValue=candidates[maxindex];
	    	s_cache.put(key, retValue);
	    	return retValue;
	    } else {
	    	return null;
	    }
	}
	
	/**	Cache of selected MUserDefWin entries 					**/
	private static CCache<Integer,MUserDefWin> s_cache = new CCache<Integer,MUserDefWin>("AD_UserDef_Win", 3);	//  3 weights

	@Override
	protected boolean beforeSave(boolean newRecord) {
		m_fullList = null;
		return true;
	}
	
	@Override
	protected boolean beforeDelete() {
		m_fullList = null;
		return true;
	}
	
}	//	MUserDefWin
