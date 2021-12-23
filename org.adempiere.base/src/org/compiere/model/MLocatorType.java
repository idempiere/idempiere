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
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Warehouse Locator Type Object
 *
 * 	@author 	Carlos Ruiz - Quality Systems &gt; Solutions - globalqss
 */
public class MLocatorType extends X_M_LocatorType implements ImmutablePOSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3021833597380696668L;

	/**
	 * 	Get Locator Type from Cache (immutable)
	 *	@param M_LocatorType_ID id
	 *	@return MLocator
	 */
	public static MLocatorType get (int M_LocatorType_ID) {
		return get(Env.getCtx(), M_LocatorType_ID);
	}
	
	/**
	 * 	Get Locator Type from Cache (immutable)
	 *  @param ctx context
	 *	@param M_LocatorType_ID id
	 *	@return MLocator
	 */
	public static MLocatorType get (Properties ctx, int M_LocatorType_ID) {
		Integer key = Integer.valueOf(M_LocatorType_ID);
		MLocatorType retValue = s_cache.get (ctx, key, e -> new MLocatorType(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MLocatorType (ctx, M_LocatorType_ID, (String)null);
		if (retValue.get_ID () == M_LocatorType_ID) {
			s_cache.put (key, retValue, e -> new MLocatorType(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**	Cache						*/
	private final static ImmutableIntPOCache<Integer,MLocatorType> s_cache = new ImmutableIntPOCache<Integer,MLocatorType>(Table_Name, 20); 

	/**	Logger						*/
	@SuppressWarnings("unused")
	private static CLogger		s_log = CLogger.getCLogger (MLocatorType.class);

	/**************************************************************************
	 * 	Standard Locator Constructor
	 *	@param ctx Context
	 *	@param M_LocatorType_ID id
	 *	@param trxName transaction
	 */
	public MLocatorType (Properties ctx, int M_LocatorType_ID, String trxName) {
		super (ctx, M_LocatorType_ID, trxName);
		if (M_LocatorType_ID == 0) {
			setIsAvailableForReplenishment (true);
			setIsAvailableForReservation (true);
			setIsAvailableForShipping (true);
		}
	}	//	MLocatorType

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLocatorType (Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}	//	MLocatorType

	/**
	 * 
	 * @param copy
	 */
	public MLocatorType(MLocatorType copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MLocatorType(Properties ctx, MLocatorType copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MLocatorType(Properties ctx, MLocatorType copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 *	Get String Representation
	 * 	@return Name
	 */
	public String toString() {
		return getName();
	}	//	toString

	@Override
	public MLocatorType markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MLocatorType
