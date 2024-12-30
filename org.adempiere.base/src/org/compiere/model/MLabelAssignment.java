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
import org.compiere.util.Util;

/**
 * Label Assignment Model
 */
public class MLabelAssignment extends X_AD_LabelAssignment {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 310053368504090622L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_LabelAssignment_UU  UUID key
     * @param trxName Transaction
     */
    public MLabelAssignment(Properties ctx, String AD_LabelAssignment_UU, String trxName) {
        super(ctx, AD_LabelAssignment_UU, trxName);
    }

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
 	 * @deprecated Use {@link MLabelAssignment#hasAnyAssignment(int, int, String)} instead
	 */
	@Deprecated
	public static boolean hasAnyAssignment(int Table_ID, int Record_ID) {
		String sql="SELECT COUNT(*) FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID=?";
		int counter = DB.getSQLValueEx(null, sql, Table_ID, Record_ID);
		return counter > 0;
	}

	/**
	 * Check if record has any label assigned
	 * @param Table_ID
	 * @param Record_ID
	 * @param Record_UU
	 * @return true if record has any label assigned
	 */
	public static boolean hasAnyAssignment(int Table_ID, int Record_ID, String Record_UU) {
		if (Util.isEmpty(Record_UU))
			return hasAnyAssignment(Table_ID, Record_ID);
		String sql="SELECT COUNT(*) FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_UU=?";
		int counter = DB.getSQLValueEx(null, sql, Table_ID, Record_UU);
		return counter > 0;
	}

	/**
	 * Check if a label is assigned to a record
	 * @param AD_Label_ID
	 * @param Table_ID
	 * @param Record_ID
	 * @return true if label is assigned
 	 * @deprecated Use {@link MLabelAssignment#hasLabelAssignment(int, int, String)} instead
	 */
	@Deprecated
	public static boolean hasLabelAssignment(int AD_Label_ID, int Table_ID, int Record_ID) {
		String sql="SELECT COUNT(*) FROM AD_LabelAssignment WHERE AD_Label_ID = ? AND AD_Table_ID=? AND Record_ID=?";
		int counter = DB.getSQLValueEx(null, sql, AD_Label_ID, Table_ID, Record_ID);
		return counter > 0;
	}

	/**
	 * Check if a label is assigned to a record
	 * @param AD_Label_ID
	 * @param Table_ID
	 * @param Record_UU
	 * @return true if label is assigned
	 */
	public static boolean hasLabelAssignment(int AD_Label_ID, int Table_ID, String Record_UU) {
		String sql="SELECT COUNT(*) FROM AD_LabelAssignment WHERE AD_Label_ID = ? AND AD_Table_ID=? AND Record_UU=?";
		int counter = DB.getSQLValueEx(null, sql, AD_Label_ID, Table_ID, Record_UU);
		return counter > 0;
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Set record UUID from record id
		if (getRecord_ID() > 0 && getAD_Table_ID() > 0 && Util.isEmpty(getRecord_UU())) {
			MTable table = MTable.get(getAD_Table_ID());
			PO po = table.getPO(getRecord_ID(), get_TrxName());
			if (po != null)
				setRecord_UU(po.get_UUID());
		}
		return true;
	}

}
