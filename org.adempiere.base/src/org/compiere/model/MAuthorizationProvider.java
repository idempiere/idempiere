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
 * Authorization Provider
 */
public class MAuthorizationProvider extends X_AD_AuthorizationProvider {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5486619727437115587L;

	/**
	 * Create empty Authorization Provider
	 *
	 * @param ctx              context
	 * @param AD_AuthorizationProvider_ID ID
	 * @param trxName          transaction
	 */
	public MAuthorizationProvider(Properties ctx, int AD_AuthorizationProvider_ID, String trxName) {
		super(ctx, AD_AuthorizationProvider_ID, trxName);
	} // MAuthorizationProvider

	/**
	 * Create Authorization Provider from current row in ResultSet
	 *
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MAuthorizationProvider(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MAuthorizationProvider

} // MAuthorizationProvider
