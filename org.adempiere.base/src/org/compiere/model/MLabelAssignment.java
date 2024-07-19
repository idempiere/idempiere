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
 * - Alan Lescano                                                      *
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;

/**
 * Label Assignment Model
 */
public class MLabelAssignment extends X_AD_LabelAssignment {
	private static final long serialVersionUID = -964945898771768568L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_LabelAssignment_ID id
	 *	@param trxName transaction
	 */
	public MLabelAssignment(Properties ctx, int AD_LabelAssignment_ID, String trxName) {
		super(ctx, AD_LabelAssignment_ID, trxName);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLabelAssignment(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * Check if record has any label assigned
	 * @param Table_ID
	 * @param Record_ID
	 * @return true if record has any label assigned
	 */
	public static boolean hasAnyAssignment(int Table_ID, int Record_ID) {
		String sql="SELECT COUNT(*) FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID=?";
		int counter = DB.getSQLValueEx(null, sql, Table_ID, Record_ID);
		return counter > 0;
	}
	
	/**
	 * Check if a label is assigned to a record
	 * @param AD_Label_ID
	 * @param Table_ID
	 * @param Record_ID
	 * @return true if label is assigned
	 */
	public static boolean hasLabelAssignment(int AD_Label_ID, int Table_ID, int Record_ID) {
		String sql="SELECT COUNT(*) FROM AD_LabelAssignment WHERE AD_Label_ID = ? AND AD_Table_ID=? AND Record_ID=?";
		int counter = DB.getSQLValueEx(null, sql, AD_Label_ID, Table_ID, Record_ID);
		return counter > 0;
	}
}
