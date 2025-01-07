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

public class MDocumentStatusAccess extends X_PA_DocumentStatusAccess {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6018040839563733491L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param PA_DocumentStatusAccess_UU  UUID key
     * @param trxName Transaction
     */
    public MDocumentStatusAccess(Properties ctx, String PA_DocumentStatusAccess_UU, String trxName) {
        super(ctx, PA_DocumentStatusAccess_UU, trxName);
    }

    /**
     * @param ctx
     * @param PA_DocumentStatusAccess_ID
     * @param trxName
     */
	public MDocumentStatusAccess(Properties ctx, int PA_DocumentStatusAccess_ID, String trxName) {
		super(ctx, PA_DocumentStatusAccess_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDocumentStatusAccess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

}
