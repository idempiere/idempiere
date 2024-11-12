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
 * - Nicolas Micoud, TGI				                                  *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * User, role, organization or tenant variation detail of Themes
 * @author Nicolas Micoud, TGI
 * @version $Id$
 */
public class MUserDefThemeDetail extends X_AD_UserDef_Theme_Detail {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2180810451872103229L;

	/**
	 * UUID based Constructor
	 * @param ctx  Context
	 * @param AD_UserDef_Theme_Detail_UU  UUID key
	 * @param trxName Transaction
	 */
	public MUserDefThemeDetail(Properties ctx, String AD_UserDef_Theme_Detail_UU, String trxName) {
		super(ctx, AD_UserDef_Theme_Detail_UU, trxName);
	}

	/**
	 * 	Standard constructor.
	 *	@param ctx Context
	 *	@param AD_UserDef_Theme_Detail_ID Primary key ID
	 *	@param trxName Transaction name
	 */
	public MUserDefThemeDetail(Properties ctx, int AD_UserDef_Theme_Detail_ID, String trxName) {
		super(ctx, AD_UserDef_Theme_Detail_ID, trxName);
	}

	/**
	 * 	Load Constructor.
	 *  @param ctx Context
	 *  @param rs Result set
	 *	@param trxName Transaction Name
	 */
	public MUserDefThemeDetail(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Get best matching MUserDefThemeDetail for info window and info column
	 * @param ctx
	 * @param ThemeName
	 * @param value to replace
	 * @return MUserDefThemeDetail or null
	 */
	public static MUserDefThemeDetail get (Properties ctx, String themeName, String valueToReplace)
	{
		MUserDefTheme userdefTheme = MUserDefTheme.getBestMatch(ctx, themeName);
		if (userdefTheme == null)
			return null;

		Query query = new Query(ctx, Table_Name, "AD_UserDef_Theme_ID = ? AND CurrentValue = ?", null)
				.setParameters(userdefTheme.getAD_UserDef_Theme_ID(), valueToReplace)
				.setOnlyActiveRecords(true);

		MUserDefThemeDetail retValue = query.first();

		return retValue;
	}	//get
}
