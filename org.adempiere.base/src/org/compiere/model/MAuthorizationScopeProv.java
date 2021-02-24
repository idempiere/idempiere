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
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Authorization ScopeProvider
 */
public class MAuthorizationScopeProv extends X_AD_AuthorizationScopeProv {
	/**
	 * 
	 */
	private static final long serialVersionUID = -532429032686884288L;

	/**
	 * Create empty Authorization ScopeProvider
	 * 
	 * @param ctx              context
	 * @param AD_AuthorizationScopeProv_ID ID
	 * @param trxName          transaction
	 */
	public MAuthorizationScopeProv(Properties ctx, int AD_AuthorizationScopeProv_ID, String trxName) {
		super(ctx, AD_AuthorizationScopeProv_ID, trxName);
	} // MAuthorizationScopeProv

	/**
	 * Create Authorization ScopeProvider from current row in ResultSet
	 * 
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MAuthorizationScopeProv(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MAuthorizationScopeProv

	/**
	 * Get the configured scopes, optionally get just the scope passed as parameter if is configured
	 * @param parameter_scope
	 * @return List of scopes (Strings)
	 */
	public static List<String> getConfiguredScopes(String parameter_scope) {
		int clientId = Env.getAD_Client_ID(Env.getCtx());
		List<String> scopeList = new ArrayList<String>();
		final String sql = "SELECT DISTINCT asp.AD_AuthorizationScope "
				+ "FROM AD_AuthorizationScopeProv asp "
				+ "WHERE asp.IsActive='Y' "
				+ "  AND (''=? OR asp.AD_AuthorizationScope=?) "
				+ "  AND asp.AD_Client_ID IN (0,?) "
				+ "  AND EXISTS (SELECT 1 "
				+ "    FROM AD_AuthorizationCredential ac "
				+ "    JOIN AD_AuthorizationProvider ap ON (ac.AD_AuthorizationProvider_ID=ap.AD_AuthorizationProvider_ID "
				+ "      AND ap.IsActive='Y' "
				+ "      AND ap.AD_Client_ID IN (0,?)) "
				+ "    WHERE ac.AD_AuthorizationProvider_ID=asp.AD_AuthorizationProvider_ID  "
				+ "      AND ac.IsActive='Y' "
				+ "      AND ac.AD_AuthorizationScopeList LIKE '%'||asp.AD_AuthorizationScope||'%' "
				+ "      AND ac.AD_Client_ID IN (0,?))";
		List<List<Object>> scopeArray = DB.getSQLArrayObjectsEx(null, sql, parameter_scope, parameter_scope, clientId, clientId, clientId);
		if (scopeArray != null) {
			for (List<Object> row : scopeArray) {
				for (Object field : row) {
					scopeList.add(field.toString());
				}
			}
		}
		return scopeList;
	}

} // MAuthorizationScopeProv
