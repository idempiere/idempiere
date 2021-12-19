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
 * - Carlos Ruiz                                                       *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MDocumentActionAccess extends X_AD_Document_Action_Access {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2036011342206732816L;

	/**
	 * Standard Constructor
	 * 
	 * @param ctx     context
	 * @param ignored -
	 * @param trxName transaction
	 */
	public MDocumentActionAccess(Properties ctx, int ignored, String trxName) {
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	} // MDocumentActionAccess

	/**
	 * MDocumentActionAccess
	 * 
	 * @param ctx
	 * @param rs
	 * @param trxName transaction
	 */
	public MDocumentActionAccess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MDocumentActionAccess

} // MDocumentActionAccess
