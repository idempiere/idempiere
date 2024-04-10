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
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * Persistence model for table val rule
 * 
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class MTableValRule extends X_AD_TableValRule implements ImmutablePOSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5156583311055069139L;

	/** Cache */
	private static ImmutablePOCache<String, MTableValRule> s_cache = new ImmutablePOCache<String, MTableValRule>(Table_Name, 20, 0, false, 0);
	private static CCache<String, List<MTableValRule>> s_cachesession = new CCache<String, List<MTableValRule>>(Table_Name, 5, 0, false, 0);

	/** Static Logger */
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MTableValRule.class);

	/**
	 * UUID based Constructor
	 * 
	 * @param ctx            Context
	 * @param AD_TableValRule_UU UUID key
	 * @param trxName        Transaction
	 */
	public MTableValRule(Properties ctx, String AD_TableValRule_UU, String trxName) {
		super(ctx, AD_TableValRule_UU, trxName);
	}

	/**
	 * Load Constructor
	 * 
	 * @param ctx     context
	 * @param rs      result set
	 * @param trxName transaction
	 */
	public MTableValRule(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MTableValRule

	/**
	 * 
	 * @param copy
	 */
	public MTableValRule(MTableValRule copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MTableValRule(Properties ctx, MTableValRule copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MTableValRule(Properties ctx, MTableValRule copy, String trxName) {
		this(ctx, PO.UUID_NEW_RECORD, trxName);
		copyPO(copy);
	}

	/**
	 * Get Rule from Cache (immutable)
	 * 
	 * @param AD_TableValRule_UU UUID
	 * @return MTableValRule
	 */
	public static MTableValRule get(String AD_TableValRule_UU) {
		return get(Env.getCtx(), AD_TableValRule_UU);
	}

	/**
	 * Get Rule from Cache (immutable)
	 * 
	 * @param ctx            context
	 * @param AD_TableValRule_UU UUID
	 * @return MTableValRule
	 */
	public static MTableValRule get(Properties ctx, String AD_TableValRule_UU) {
		return get(ctx, AD_TableValRule_UU, (String) null);
	}

	/**
	 * Get Rule from Cache (immutable)
	 * 
	 * @param ctx            context
	 * @param AD_TableValRule_UU UUID
	 * @param trxName
	 * @return MTableValRule
	 */
	public static MTableValRule get(Properties ctx, String AD_TableValRule_UU, String trxName) {
		String key = AD_TableValRule_UU;
		MTableValRule retValue = s_cache.get(ctx, key, e -> new MTableValRule(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MTableValRule(ctx, AD_TableValRule_UU, trxName);
		if (retValue.get_UUID() == AD_TableValRule_UU) {
			s_cache.put(key, retValue, e -> new MTableValRule(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} // get

	/**
	 * Get updateable copy of MTableValRule from cache
	 * 
	 * @param ctx
	 * @param AD_TableValRule_UU UUID
	 * @param trxName
	 * @return MTableValRule
	 */
	public static MTableValRule getCopy(Properties ctx, String AD_TableValRule_UU, String trxName) {
		MTableValRule vr = get(ctx, AD_TableValRule_UU, trxName);
		if (vr != null)
			vr = new MTableValRule(ctx, vr, trxName);
		return vr;
	}

	/**
	 * Get Rules applicable to session
	 * @param ctx
	 * @param AD_Table_ID
	 * @param AD_Client_ID
	 * @param AD_Role_ID
	 * @param AD_User_ID
	 * @return List of MTableValRule
	 */
	public static List<MTableValRule> get(Properties ctx, int AD_Table_ID, int AD_Client_ID, int AD_Role_ID, int AD_User_ID) {
		String keySession = new StringBuilder()
				.append(AD_Table_ID).append("|")
				.append(AD_Client_ID).append("|")
				.append(AD_Role_ID).append("|")
				.append(AD_User_ID)
				.toString();
		if (s_cachesession.containsKey(keySession))
			return s_cachesession.get(keySession);

		final String where = "AD_Table_ID=? AND AD_Client_ID IN (0,?) AND (AD_Role_ID IS NULL OR AD_Role_ID=?) AND (AD_User_ID IS NULL OR AD_User_ID=?)";
		List<MTableValRule> retValue = new Query(ctx, Table_Name, where, null)
				.setOnlyActiveRecords(true)
				.setParameters(AD_Table_ID, AD_Client_ID, AD_Role_ID, AD_User_ID)
				.list();
		s_cachesession.put(keySession, retValue);
		return retValue;
	}

	@Override
	public MTableValRule markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (getAD_Org_ID() > 0)
			setAD_Org_ID(0);
		return true;
	}

	/**
	 * String representation of this object, used in Recent Items
	 * @return info
	 */
	@Override
	public String toString() {
		MTable table = MTable.get(getAD_Table_ID());
		StringBuilder sb = new StringBuilder (table.getName());
		if (getAD_User_ID() > 0) {
			MUser user = MUser.get(getAD_User_ID());
			sb.append(" -> User=").append(user.getName());
		}
		if (getAD_Role_ID() > 0) {
			MRole role = MRole.get(getCtx(), getAD_Role_ID());
			sb.append(" -> Role=").append(role.getName());
		}
		return sb.toString();
	}

} // MTableValRule