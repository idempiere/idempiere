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
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.DB;

/**
 * Verify Migration Model
 */
public class MVerifyMigration extends X_AD_VerifyMigration {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3950930035070040881L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_VerifyMigration_UU  UUID key
     * @param trxName Transaction
     */
    public MVerifyMigration(Properties ctx, String AD_VerifyMigration_UU, String trxName) {
        super(ctx, AD_VerifyMigration_UU, trxName);
    }

	/**
	 * Read/Create empty Verify Migration
	 *
	 * @param ctx                   context
	 * @param AD_VerifyMigration_ID ID
	 * @param trxName               transaction
	 */
	public MVerifyMigration(Properties ctx, int AD_VerifyMigration_ID, String trxName) {
		super(ctx, AD_VerifyMigration_ID, trxName);
	} // MVerifyMigration

	/**
	 * Read Verify Migration from current row in ResultSet
	 *
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MVerifyMigration(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MVerifyMigration

	/**
	 * @param ctx
	 * @param pinstanceId
	 * @param tableId
	 * @param columnId
	 * @param recordId
	 * @param changeLogId
	 * @param msg
	 * @param seqNo
	 * @param currentValue
	 * @param expectedValue
	 * @param priorityRule
	 * @param trxName
	 */
	public MVerifyMigration(Properties ctx, int pinstanceId, int tableId, int columnId, int recordId, int changeLogId,
			String msg, int seqNo, Object currentValue, String expectedValue, String priorityRule, String trxName) {
		this(ctx, 0, trxName);
		setAD_PInstance_ID(pinstanceId);
		setAD_Table_ID(tableId);
		setAD_Column_ID(columnId);
		setRecord_ID(recordId);
		setAD_ChangeLog_ID(changeLogId);
		setSeqNo(seqNo);
		setCurrentValue(currentValue == null ? null : currentValue.toString());
		setExpectedValue(expectedValue);
		setPriorityRule(MVerifyMigration.PRIORITYRULE_High);
		setHelp(msg);
	}

	/**
	 * Check if this record is marked as ignored in a previous run
	 * @param changelogId
	 * @param tableId
	 * @param columnId
	 * @param recordId
	 * @param trxName
	 * @return true if mark as ignore
	 */
	public static boolean isIgnored(int changelogId, int tableId, int columnId, int recordId, String trxName) {
		StringBuilder whereClause = new StringBuilder("IsIgnore='Y' AND IsActive='Y'");
		List<Object> params = new ArrayList<Object>();
		if (changelogId > 0) {
			whereClause.append(" AND AD_ChangeLog_ID=?");
			params.add(changelogId);
		} else if (changelogId < 0) {
			whereClause.append(" AND AD_ChangeLog_ID IS NULL");
		}
		if (tableId > 0) {
			whereClause.append(" AND AD_Table_ID=?");
			params.add(tableId);
		} else if (tableId < 0) {
			whereClause.append(" AND AD_Table_ID IS NULL");
		}
		if (columnId > 0) {
			whereClause.append(" AND AD_Column_ID=?");
			params.add(columnId);
		} else if (columnId < 0) {
			whereClause.append(" AND AD_Column_ID IS NULL");
		}
		if (recordId > 0) {
			whereClause.append(" AND Record_ID=?");
			params.add(recordId);
		} else if (recordId < 0) {
			whereClause.append(" AND Record_ID IS NULL");
		}
		int cnt = DB.getSQLValueEx(trxName, "SELECT COUNT(*) FROM AD_VerifyMigration WHERE " + whereClause.toString(), params);
		return cnt > 0;
	}

} // MVerifyMigration
