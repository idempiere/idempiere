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

import org.compiere.util.CCache;

public class MReference extends X_AD_Reference {
	/**
	 * 
	 */
	private static final long serialVersionUID = 119105464164520763L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Reference_ID id
	 *	@param trxName trx
	 */
	public MReference (Properties ctx, int AD_Reference_ID, String trxName) {
		super (ctx, AD_Reference_ID, trxName);
		if (AD_Reference_ID == 0) {
			setEntityType (ENTITYTYPE_UserMaintained);	// U
		}
	}	//	MReference

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MReference (Properties ctx, ResultSet rs, String trxName) {
		super (ctx, rs, trxName);
	}	//	MReference

	/**	Reference Cache				*/
	private static CCache<Integer,MReference>	s_cache = new CCache<Integer,MReference>(Table_Name, 20);

	/**
	 * 	Get from Cache
	 *	@param ctx context
	 *	@param AD_Reference_ID id
	 *	@return category
	 */
	public static MReference get (Properties ctx, int AD_Reference_ID)
	{
		Integer ii = Integer.valueOf(AD_Reference_ID);
		MReference retValue = (MReference)s_cache.get(ii);
		if (retValue != null)
			return retValue;
		retValue = new MReference (ctx, AD_Reference_ID, null);
		if (retValue.get_ID () != 0)
			s_cache.put (AD_Reference_ID, retValue);
		return retValue;
	}	//	get
	
}	//	MReference
