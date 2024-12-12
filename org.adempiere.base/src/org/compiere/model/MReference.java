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
 * - Carlos Ruiz                                                       *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

public class MReference extends X_AD_Reference implements ImmutablePOSupport {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3760461444953943829L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Reference_UU  UUID key
     * @param trxName Transaction
     */
    public MReference(Properties ctx, String AD_Reference_UU, String trxName) {
        super(ctx, AD_Reference_UU, trxName);
		if (Util.isEmpty(AD_Reference_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Reference_ID id
	 *	@param trxName trx
	 */
	public MReference (Properties ctx, int AD_Reference_ID, String trxName) {
		super (ctx, AD_Reference_ID, trxName);
		if (AD_Reference_ID == 0)
			setInitialDefaults();
	}	//	MReference

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setEntityType (ENTITYTYPE_UserMaintained);	// U
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MReference (Properties ctx, ResultSet rs, String trxName) {
		super (ctx, rs, trxName);
	}	//	MReference

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MReference(MReference copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MReference(Properties ctx, MReference copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MReference(Properties ctx, MReference copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**	Reference Cache				*/
	private static ImmutableIntPOCache<Integer,MReference> s_cache = new ImmutableIntPOCache<Integer,MReference>(Table_Name, 20, 0, false, 0);
	/**	Cache UUID						*/
	private static ImmutablePOCache<String,MReference>	s_cacheUU	= new ImmutablePOCache<String,MReference>(Table_Name, Table_Name+"|AD_Reference_UU", 20);

	/**
	 * 	Get from Cache (immutable)
	 *	@param AD_Reference_ID id
	 *	@return category
	 */
	public static MReference get (int AD_Reference_ID)
	{
		return get(Env.getCtx(), AD_Reference_ID);
	}
	
	/**
	 * 	Get from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Reference_ID id
	 *	@return category
	 */
	public static MReference get (Properties ctx, int AD_Reference_ID)
	{
		return get(ctx, AD_Reference_ID, null);
	}

	/**
	 * 	Get from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Reference_ID id
	 *	@param trxName trx
	 *	@return category
	 */
	public static MReference get (Properties ctx, int AD_Reference_ID, String trxName)
	{
		Integer ii = Integer.valueOf(AD_Reference_ID);
		MReference retValue = s_cache.get(ctx, ii, e -> new MReference(ctx, e));
		if (retValue != null) {
			return retValue;
		}
		retValue = new MReference (ctx, AD_Reference_ID, trxName);
		if (retValue.get_ID () == AD_Reference_ID)
		{
			s_cache.put (AD_Reference_ID, retValue, e -> new MReference(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	@Override
	public MReference markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * Show inactive records
	 * @return true if this lookup reference should include inactive records
	 */
	public boolean isShowInactiveRecords() {
		return !Util.isEmpty(getShowInactive()) && MReference.SHOWINACTIVE_Yes.equalsIgnoreCase(getShowInactive());
	}
	
	/**
	 * 	Get MReference from Cache based on UUID (immutable)
	 *	@param ctx context
	 *	@param AD_Reference_UU UUID
	 *	@return MReference
	 */
	public static MReference get (Properties ctx, String AD_Reference_UU)
	{
		MReference retValue = s_cacheUU.get(ctx, AD_Reference_UU, e -> new MReference(ctx, e));
		if (retValue != null)
			return retValue;
		int id = DB.getSQLValueEx(null, "SELECT AD_Reference_ID FROM AD_Reference WHERE AD_Reference_UU = ? ", AD_Reference_UU);
		if (id > 0)
		{
			retValue = new MReference (ctx, id, (String)null);
			if (retValue.get_ID() == id && !Util.isEmpty(retValue.getAD_Reference_UU())) 
			{
				s_cacheUU.put (retValue.getAD_Reference_UU(), retValue, e -> new MReference(Env.getCtx(), e));
				return retValue;
			}
		}
		return null;
	}	//	get

}	//	MReference
