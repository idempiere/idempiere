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
 * - Nicolas Micoud, TGI		                                          *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * User, role, organization or tenant overrides of form model
 * @author Nicolas Micoud, TGI
 * @version $Id$
 */
public class MUserDefForm extends X_AD_UserDef_Form implements ImmutablePOSupport {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8543012038608086438L;
	/** AD_Client_ID:MUserDefForm List */
	private static final Map<Integer, List<MUserDefForm>> m_fullMap = new ConcurrentHashMap<>();

	/**
	 * UUID based Constructor
	 * @param ctx  Context
	 * @param X_AD_UserDef_Form_UU  UUID key
	 * @param trxName Transaction
	 */
	public MUserDefForm(Properties ctx, String X_AD_UserDef_Form_UU, String trxName) {
		super(ctx, X_AD_UserDef_Form_UU, trxName);
	}

	/**
	 * Standard constructor.
	 * @param ctx Context
	 * @param X_AD_UserDef_Form_ID Primary Key ID
	 * @param trxName Transaction name
	 */
	public MUserDefForm(Properties ctx, int X_AD_UserDef_Form_ID, String trxName) {
		super(ctx, X_AD_UserDef_Form_ID, trxName);
	}

	/**
	 * Load Constructor.
	 * @param ctx Context
	 * @param rs Result set
	 * @param trxName Transaction name
	 */
	public MUserDefForm(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MUserDefForm(MUserDefForm copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MUserDefForm(Properties ctx, MUserDefForm copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MUserDefForm(Properties ctx, MUserDefForm copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 *  Get all MUserDefForm entries for a form
	 * 	@param ctx Context
	 *  @param infowindow_ID Info window
	 *  @return Array of MUserDefForm for form
	 */
	private static MUserDefForm[] getAll (Properties ctx, int formID)
	{
		List<MUserDefForm> fullList = null;
		fullList = m_fullMap.get(Env.getAD_Client_ID(ctx));
		if (fullList == null) {
			fullList = new Query(ctx, MUserDefForm.Table_Name, null, null)
					.setOnlyActiveRecords(true)
					.setClient_ID()
					.list();
			m_fullMap.put(Env.getAD_Client_ID(ctx), fullList);
		}

		if (fullList.size() == 0) {
			return null;
		}

		List<MUserDefForm> list = new ArrayList<MUserDefForm>();

		for (MUserDefForm udf : fullList) {
			if (udf.getAD_Form_ID() == formID
				&& udf.getAD_Client_ID() == Env.getAD_Client_ID(ctx)
				&& (udf.getAD_Language() == null || udf.getAD_Language().equals(Env.getAD_Language(ctx)))
				) {
				list.add(udf);
			}
		}

		if (list.size() == 0)
			return null;

		return list.toArray(new MUserDefForm[list.size()]);
	}

	/**
	 * Get best matching MUserDefForm for a form
	 * @param ctx
	 * @param AD_Form_ID
	 * @return MUserDefForm or null
	 */
	public static MUserDefForm getBestMatch (Properties ctx, int formID)
	{
		final int AD_Org_ID = Env.getAD_Org_ID(ctx);
		final int AD_Role_ID = Env.getAD_Role_ID(ctx);
		final int AD_User_ID = Env.getAD_User_ID(ctx);

		//Check Cache
		String key = new StringBuilder().append(formID).append("_")
				.append(Env.getAD_Client_ID(ctx)).append("_")
				.append(Env.getAD_Language(ctx)).append("_")
				.append(AD_Org_ID).append("_")
				.append(AD_Role_ID).append("_")
				.append(AD_User_ID)
				.toString();
		if (s_cache.containsKey(key))
			return s_cache.get(ctx, key, e -> new MUserDefForm(ctx, e));

		//candidates
		MUserDefForm[] candidates = getAll(ctx, formID);
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
	    	MUserDefForm retValue = null;
	    	retValue = candidates[maxindex];
	    	s_cache.put(key, retValue, e -> new MUserDefForm(Env.getCtx(), e));
	    	return retValue;
	    } else {
	    	s_cache.put(key, null);
	    	return null;
	    }
	}

	/**	Cache of selected MUserDefForm entries 					**/
	private static ImmutablePOCache<String, MUserDefForm> s_cache = new ImmutablePOCache<String, MUserDefForm>(Table_Name, 3);	//  3 weights

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
	public MUserDefForm markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
}
