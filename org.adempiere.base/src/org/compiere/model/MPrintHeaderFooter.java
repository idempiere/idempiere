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

public class MPrintHeaderFooter extends X_AD_PrintHeaderFooter {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4853150389021984724L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_PrintHeaderFooter_UU  UUID key
     * @param trxName Transaction
     */
    public MPrintHeaderFooter(Properties ctx, String AD_PrintHeaderFooter_UU, String trxName) {
        super(ctx, AD_PrintHeaderFooter_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param AD_PrintHeaderFooter_ID
	 * @param trxName
	 */
	public MPrintHeaderFooter(Properties ctx, int AD_PrintHeaderFooter_ID, String trxName) {
		super(ctx, AD_PrintHeaderFooter_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MPrintHeaderFooter(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

}
