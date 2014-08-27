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

import org.compiere.util.CLogger;

/**
 *	Country Group Country Model
 */
public class MCountryGroupCountry extends X_C_CountryGroupCountry
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6075271124746909433L;

	/**	Static Logger					*/
	@SuppressWarnings("unused")
	private static CLogger		s_log = CLogger.getCLogger (MCountryGroupCountry.class);

	/*************************************************************************
	 *	Create empty Country Group Country
	 * 	@param ctx context
	 * 	@param C_CountryGroupCountry_ID ID
	 *	@param trxName transaction
	 */
	public MCountryGroupCountry (Properties ctx, int C_CountryGroupCountry_ID, String trxName)
	{
		super (ctx, C_CountryGroupCountry_ID, trxName);
	}   //  MCountryGroupCountry

	/**
	 *	Create Country Group from current row in ResultSet
	 * 	@param ctx context
	 *  @param rs ResultSet
	 *	@param trxName transaction
	 */
	public MCountryGroupCountry (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCountryGroupCountry

}	//	MCountryGroupCountry
