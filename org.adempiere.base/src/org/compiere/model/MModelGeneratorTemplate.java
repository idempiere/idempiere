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
 * - Nicolas Micoud (TGI)		                                       *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Generate Model Template
 */
public class MModelGeneratorTemplate extends X_AD_ModelGeneratorTemplate {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8215029851779075135L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_ModelGeneratorTemplate_UU  UUID key
     * @param trxName Transaction
     */
    public MModelGeneratorTemplate(Properties ctx, String AD_ModelGeneratorTemplate_UU, String trxName) {
        super(ctx, AD_ModelGeneratorTemplate_UU, trxName);
    } // MModelGeneratorTemplate

	/**
	 * @param ctx			context
	 * @param AD_ModelGeneratorTemplate_ID	ID
	 * @param trxName		transaction
	 */
	public MModelGeneratorTemplate(Properties ctx, int AD_ModelGeneratorTemplate_ID, String trxName) {
		super(ctx, AD_ModelGeneratorTemplate_ID, trxName);
	} // MModelGeneratorTemplate

	/**
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MModelGeneratorTemplate(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MModelGeneratorTemplate

} // MModelGeneratorTemplate
