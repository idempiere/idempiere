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
 * - Nicolas Micoud (TGI)                                              *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Label Assignment
 */
public class MLabelAssignment extends X_C_LabelAssignment {

	/**
	 * 
	 */
	private static final long serialVersionUID = -964945898771768568L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_LabelAssignment_ID id
	 *	@param trxName transaction
	 */
	public MLabelAssignment(Properties ctx, int C_LabelAssignment_ID, String trxName) {
		super(ctx, C_LabelAssignment_ID, trxName);
	} // MLabelAssignment

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLabelAssignment(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MLabelAssignment

} // MLabelAssignment
