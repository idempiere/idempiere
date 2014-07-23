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
 *	Persistent Validation Rule Model
 *  @author Carlos Ruiz
 *  @version $Id: MValRule.java
 */
public class MValRule extends X_AD_Val_Rule
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8482599477870030638L;

	/**
	 * 	Get Rule from Cache
	 *	@param ctx context
	 *	@param AD_Val_Rule_ID id
	 *	@return MValRule
	 */
	public static MValRule get (Properties ctx, int AD_Val_Rule_ID)
	{
		Integer key = new Integer (AD_Val_Rule_ID);
		MValRule retValue = (MValRule) s_cache.get (key);
		if (retValue != null)
			return retValue;
		retValue = new MValRule (ctx, AD_Val_Rule_ID, null);
		if (retValue.get_ID () != 0)
			s_cache.put (key, retValue);
		return retValue;
	}	//	get

	/**	Cache						*/
	private static CCache<Integer,MValRule> s_cache = new CCache<Integer,MValRule>(Table_Name, 20);

	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MValRule.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Val_Rule_ID id
	 *	@param trxName transaction
	 */
	public MValRule (Properties ctx, int AD_Val_Rule_ID, String trxName)
	{
		super (ctx, AD_Val_Rule_ID, trxName);
	}	//	MValRule

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MValRule (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MValRule

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MValRule[");
		sb.append (get_ID()).append ("-").append (getName()).append ("]");
		return sb.toString ();
	}	//	toString

}	//	MValRule