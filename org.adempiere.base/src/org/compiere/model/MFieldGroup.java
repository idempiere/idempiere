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

public class MFieldGroup extends X_AD_FieldGroup {
	/**
	 * 
	 */
    private static final long serialVersionUID = 881680905689024799L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_FieldGroup_UU  UUID key
     * @param trxName Transaction
     */
    public MFieldGroup(Properties ctx, String AD_FieldGroup_UU, String trxName) {
        super(ctx, AD_FieldGroup_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param AD_FieldGroup_ID
	 * @param trxName
	 */
	public MFieldGroup(Properties ctx, int AD_FieldGroup_ID, String trxName) {
		super(ctx, AD_FieldGroup_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MFieldGroup(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

}
