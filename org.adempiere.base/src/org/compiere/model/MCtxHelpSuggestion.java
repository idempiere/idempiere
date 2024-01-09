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
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Suggestion for context help message
 * @author hengsin
 */
public class MCtxHelpSuggestion extends X_AD_CtxHelpSuggestion {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1940407803562658708L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_CtxHelpSuggestion_UU  UUID key
     * @param trxName Transaction
     */
    public MCtxHelpSuggestion(Properties ctx, String AD_CtxHelpSuggestion_UU, String trxName) {
        super(ctx, AD_CtxHelpSuggestion_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param AD_CtxHelpSuggestion_ID
	 * @param trxName
	 */
	public MCtxHelpSuggestion(Properties ctx, int AD_CtxHelpSuggestion_ID, String trxName) {
		super(ctx, AD_CtxHelpSuggestion_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MCtxHelpSuggestion(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.PO#setClientOrg(int, int)
	 */
	@Override
	public void setClientOrg(int AD_Client_ID, int AD_Org_ID) {
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}
}
