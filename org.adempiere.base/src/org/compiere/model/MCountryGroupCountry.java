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
 *	Countries in a Country Group 
 */
public class MCountryGroupCountry extends X_C_CountryGroupCountry
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6075271124746909433L;

	/**	Static Logger					*/
	@SuppressWarnings("unused")
	private static CLogger		s_log = CLogger.getCLogger (MCountryGroupCountry.class);

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_CountryGroupCountry_UU  UUID key
     * @param trxName Transaction
     */
    public MCountryGroupCountry(Properties ctx, String C_CountryGroupCountry_UU, String trxName) {
        super(ctx, C_CountryGroupCountry_UU, trxName);
    }

	/**
	 * 	@param ctx context
	 * 	@param C_CountryGroupCountry_ID ID
	 *	@param trxName transaction
	 */
	public MCountryGroupCountry (Properties ctx, int C_CountryGroupCountry_ID, String trxName)
	{
		super (ctx, C_CountryGroupCountry_ID, trxName);
	}   //  MCountryGroupCountry

	/**
	 * 	@param ctx context
	 *  @param rs ResultSet
	 *	@param trxName transaction
	 */
	public MCountryGroupCountry (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCountryGroupCountry

}	//	MCountryGroupCountry
