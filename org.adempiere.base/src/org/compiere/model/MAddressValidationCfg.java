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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MAddressValidationCfg extends X_C_AddressValidationCfg {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4701790656580792912L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_AddressValidationCfg_UU  UUID key
     * @param trxName Transaction
     */
    public MAddressValidationCfg(Properties ctx, String C_AddressValidationCfg_UU, String trxName) {
        super(ctx, C_AddressValidationCfg_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param C_AddressValidationCfg_ID
	 * @param trxName
	 */
	public MAddressValidationCfg(Properties ctx, int C_AddressValidationCfg_ID, String trxName) {
		super(ctx, C_AddressValidationCfg_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MAddressValidationCfg(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

}
