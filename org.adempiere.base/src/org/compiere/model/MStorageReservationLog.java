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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.compiere.util.DB;
import org.compiere.util.Trx;

/**
 * Change log for inventory reservation storage
 * @author hengsin
 */
public class MStorageReservationLog extends X_M_StorageReservationLog {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 4527538966135474314L;

	/** Map of temporary DocumentNo to list of M_StorageReservationLog_IDs created with that temporary DocumentNo */
	private static final Map<String, List<Integer>> s_deferredDocumentNoReservationLogIds = new ConcurrentHashMap<>();

	/**
	 * Track a M_StorageReservationLog_ID that was created with a temporary DocumentNo.<br/>
	 * Internal method that should not be called directly by developer.
	 * @param tempDocumentNo temporary DocumentNo value
	 * @param M_StorageReservationLog_ID storage reservation log id
	 */
	private static void addDeferredDocumentNoReservationLog(String tempDocumentNo, int M_StorageReservationLog_ID) {
		if (tempDocumentNo == null || M_StorageReservationLog_ID <= 0)
			return;
		s_deferredDocumentNoReservationLogIds
				.computeIfAbsent(tempDocumentNo, k -> new CopyOnWriteArrayList<>())
				.add(Integer.valueOf(M_StorageReservationLog_ID));
	}

	/**
	 * Get and remove the M_StorageReservationLog_IDs recorded for the given temporary DocumentNo.<br/>
	 * Internal method that should not be called directly by developer.
	 * @param tempDocumentNo temporary DocumentNo value
	 * @return list of M_StorageReservationLog_ID or null if none
	 */
	static List<Integer> removeDeferredDocumentNoReservationLogIds(String tempDocumentNo) {
		if (tempDocumentNo == null)
			return null;
		return s_deferredDocumentNoReservationLogIds.remove(tempDocumentNo);
	}

	/**
	 * Update M_StorageReservationLog entries (if any) that were recorded with the temporary DocumentNo
	 * with the actual document no generated from the sequence.<br/>
	 * Internal method that should not be called directly by developer.
	 * @param tempDocumentNo temporary document no
	 * @param docNo generated document no
	 * @param trx
	 */
	static void updateDeferredDocumentNoReservationLog(String tempDocumentNo, String docNo, Trx trx) {
		List<Integer> logIds = removeDeferredDocumentNoReservationLogIds(tempDocumentNo);
		if (logIds == null || logIds.isEmpty())
			return;
		final int batchSize = 1000;
		for (int start = 0; start < logIds.size(); start += batchSize) {
			List<Integer> batch = logIds.subList(start, Math.min(start + batchSize, logIds.size()));
			StringBuilder sql = new StringBuilder("UPDATE ").append(Table_Name)
					.append(" SET ").append(DB.getDatabase().quoteColumnName(COLUMNNAME_DocumentNo)).append("=?")
					.append(" WHERE ").append(DB.getDatabase().quoteColumnName(COLUMNNAME_M_StorageReservationLog_ID));
			List<Object> params = new ArrayList<>(batch.size() + 1);
			params.add(docNo);
			if (batch.size() == 1) {
				sql.append("=?");
				params.add(batch.get(0));
			} else {
				sql.append(" IN (");
				for (int i = 0; i < batch.size(); i++) {
					if (i > 0)
						sql.append(",");
					sql.append("?");
					params.add(batch.get(i));
				}
				sql.append(")");
			}
			DB.executeUpdateEx(sql.toString(), params.toArray(), trx.getTrxName());
		}
	}

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_StorageReservationLog_UU  UUID key
     * @param trxName Transaction
     */
    public MStorageReservationLog(Properties ctx, String M_StorageReservationLog_UU, String trxName) {
        super(ctx, M_StorageReservationLog_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param M_StorageReservationLog_ID
	 * @param trxName
	 */
	public MStorageReservationLog(Properties ctx, int M_StorageReservationLog_ID, String trxName) {
		super(ctx, M_StorageReservationLog_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MStorageReservationLog(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * DocumentNo column in M_StorageReservationLog is for reference to other table
	 */
	@Override
	protected void set_DocumentNoForNewRecord() {		
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (!success)
			return false;
		if (newRecord && MSequence.isTemporaryDocumentNo(getDocumentNo())) {
			addDeferredDocumentNoReservationLog(getDocumentNo(), getM_StorageReservationLog_ID());
		}
		return super.afterSave(newRecord, success);
	}
}

