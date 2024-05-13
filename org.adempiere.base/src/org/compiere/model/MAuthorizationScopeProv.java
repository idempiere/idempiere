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
import java.util.Properties;

/**
 * Authorization Scope Provider
 */
public class MAuthorizationScopeProv extends X_AD_AuthorizationScopeProv {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1862019802912162492L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_AuthorizationScopeProv_UU  UUID key
     * @param trxName Transaction
     */
    public MAuthorizationScopeProv(Properties ctx, String AD_AuthorizationScopeProv_UU, String trxName) {
        super(ctx, AD_AuthorizationScopeProv_UU, trxName);
    }

	/**
	 * Create empty Authorization Scope Provider
	 *
	 * @param ctx              context
	 * @param AD_AuthorizationScopeProv_ID ID
	 * @param trxName          transaction
	 */
	public MAuthorizationScopeProv(Properties ctx, int AD_AuthorizationScopeProv_ID, String trxName) {
		super(ctx, AD_AuthorizationScopeProv_ID, trxName);
	} // MAuthorizationScopeProv

	/**
	 * Create Authorization Scope Provider from current row in ResultSet
	 *
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MAuthorizationScopeProv(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MAuthorizationScopeProv

} // MAuthorizationScopeProv
