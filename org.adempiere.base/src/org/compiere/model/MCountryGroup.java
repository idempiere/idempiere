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
import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 *	Country Group Model
 */
public class MCountryGroup extends X_C_CountryGroup
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4986629677773273899L;

	/**
	 * 	Get Country Group (cached)
	 * 	@param ctx context
	 *	@param C_CountryGroup_ID ID
	 *	@return Country Group
	 */
	public static MCountryGroup get (Properties ctx, int C_CountryGroup_ID)
	{
		MCountryGroup c = s_cache.get(C_CountryGroup_ID);
		if (c != null)
			return c;
		c = new MCountryGroup (ctx, C_CountryGroup_ID, null);
		if (c.getC_CountryGroup_ID() == C_CountryGroup_ID)
		{
			s_cache.put(C_CountryGroup_ID, c);
			return c;
		}
		return null;
	}	//	get

	/**	Cache						*/
	private static CCache<Integer,MCountryGroup> s_cache	= new CCache<Integer,MCountryGroup>(Table_Name, 5);
	/**	Static Logger					*/
	@SuppressWarnings("unused")
	private static CLogger		s_log = CLogger.getCLogger (MCountryGroup.class);

	/*************************************************************************
	 *	Create empty Country
	 * 	@param ctx context
	 * 	@param C_CountryGroup_ID ID
	 *	@param trxName transaction
	 */
	public MCountryGroup (Properties ctx, int C_CountryGroup_ID, String trxName)
	{
		super (ctx, C_CountryGroup_ID, trxName);
	}   //  MCountryGroup

	/**
	 *	Create Country Group from current row in ResultSet
	 * 	@param ctx context
	 *  @param rs ResultSet
	 *	@param trxName transaction
	 */
	public MCountryGroup (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCountryGroup

	public static boolean countryGroupContains(int c_CountryGroup_ID, int c_Country_ID) {
		
		if (c_CountryGroup_ID == 0 || c_Country_ID == 0)
			return false;

		final String sql = ""
				+ "SELECT Count(*) "
				+ "FROM   c_countrygroupcountry "
				+ "WHERE  c_country_id = ? "
				+ "       AND c_countrygroup_id = ? "
				+ "       AND isactive = 'Y' ";
		int cnt = DB.getSQLValue(null, sql, c_Country_ID, c_CountryGroup_ID);

		return cnt > 0;
	}

}	//	MCountryGroup
