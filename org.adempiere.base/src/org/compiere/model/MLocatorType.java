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

import org.compiere.util.CCache;
import org.compiere.util.CLogger;

/**
 *	Warehouse Locator Type Object
 *
 * 	@author 	Carlos Ruiz - Quality Systems & Solutions - globalqss
 */
public class MLocatorType extends X_M_LocatorType {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7567584133468332781L;

	/**
	 * 	Get Locator Type from Cache
	 *	@param ctx context
	 *	@param M_LocatorType_ID id
	 *	@return MLocator
	 */
	public static MLocatorType get (Properties ctx, int M_LocatorType_ID) {
		if (s_cache == null)
			s_cache	= new CCache<Integer,MLocatorType>(Table_Name, 20);
		Integer key = new Integer (M_LocatorType_ID);
		MLocatorType retValue = (MLocatorType) s_cache.get (key);
		if (retValue != null)
			return retValue;
		retValue = new MLocatorType (ctx, M_LocatorType_ID, null);
		if (retValue.get_ID () != 0)
			s_cache.put (key, retValue);
		return retValue;
	} //	get

	/**	Cache						*/
	private volatile static CCache<Integer,MLocatorType> s_cache; 

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
	 *	Get String Representation
	 * 	@return Name
	 */
	public String toString() {
		return getName();
	}	//	toString

}	//	MLocatorType
