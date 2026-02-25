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
 **********************************************************************/
package org.compiere.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Trx;
import org.idempiere.db.util.SQLFragment;

/**
 * Batch Update PO
 * @param <T> PO type
 * @author iDempiere
 */
public class BatchUpdate<T extends PO> implements IBatchOperation<T> {
	private static final CLogger s_log = CLogger.getCLogger(BatchUpdate.class);
	private List<T> m_list = new ArrayList<>();

	/**
	 * Add PO to batch
	 * @param po
	 */
	public void add(T po) {
		if (po != null) {
			m_list.add(po);
		}
	}


	/**
	 * Execute batch update
	 * @param trxName transaction name
	 * @return true if success
	 */
	public boolean executeBatch(String trxName) {
		if (m_list.isEmpty()) {
			return true;
		}

		Trx trx = null;
		boolean internalTrx = false;
		String localTrxName = trxName;
		if (localTrxName != null) {
			trx = Trx.get(localTrxName, false);
		} else {
			localTrxName = Trx.createTrxName("BatchUpdate");
			trx = Trx.get(localTrxName, true);
			internalTrx = true;
		}

		Map<String, List<T>> sqlMap = new LinkedHashMap<>();
		Map<T, List<Object>> paramMap = new HashMap<>();
		BatchInsert<MChangeLog> changeLogBatch = new BatchInsert<>();

		Savepoint savepoint = null;
		boolean allSuccess = true;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = trx.getConnection(true);
			if (!internalTrx) {
				savepoint = trx.setSavepoint(null);
			}

			String sql = null;

			for (T po : m_list) {
				po.set_TrxName(localTrxName);
				if (!po.doVerificationForSave()) {
					allSuccess = false;
					break;
				}
				if (!po.is_Changed()) {
					continue;
				}
				if (!po.beforeSave(false)) {
					s_log.warning("beforeSave failed - " + po.toString());
					allSuccess = false;
					break;
				}

				String errorMsg = ModelValidationEngine.get().fireModelChange(po, ModelValidator.TYPE_CHANGE);
				if (errorMsg != null) {
					s_log.warning("Validation failed - " + errorMsg);
					allSuccess = false;
					break;
				}

				if (!po.doOrganizationCheckForSave()) {
					allSuccess = false;
					break;
				}

				// build update sql
				SQLFragment sqlFragment = po.buildUpdateSQL(false, null, changeLogBatch);
				if (sqlFragment == null) {
					allSuccess = false;
					break;
				}
				if (sqlFragment.sqlClause() == null || sqlFragment.sqlClause().length() == 0) {
					// no changes, pretend success
					po.m_idOld = po.get_ID();
					po.afterSave(false, true);
					ModelValidationEngine.get().fireModelChange(po, ModelValidator.TYPE_AFTER_CHANGE);
					continue;
				}

				sql = sqlFragment.sqlClause();
				sqlMap.computeIfAbsent(sql, k -> new ArrayList<>()).add(po);
				if (sqlFragment.parameters().size() > 0) {
					paramMap.put(po, sqlFragment.parameters());
				}
			}

			// insert change logs
			if (!changeLogBatch.isEmpty()) {				
				if (!changeLogBatch.executeBatch(localTrxName)) {
					allSuccess = false;
				}
			}

			List <T> allProcessed = new ArrayList<>();
			if (allSuccess) {
				for (Map.Entry<String, List<T>> entry : sqlMap.entrySet()) {
					sql = entry.getKey();
					pstmt = conn.prepareStatement(sql);
					List<T> processed = new ArrayList<>();			
					for (T po : entry.getValue()) {
						List<Object> params = paramMap.get(po);
						if (params != null) {
							DB.setParameters(pstmt, params);
						}
						pstmt.addBatch();
						processed.add(po);
					}
					int[] results = pstmt.executeBatch();
					for (int i = 0; i < results.length; i++) {
						T po = processed.get(i);
						if (results[i] == Statement.EXECUTE_FAILED) {
							s_log.warning("Batch execution failed for " + po.toString());
							allSuccess = false;
							break;
						}
					}
					if (!allSuccess) {
						break;
					}
					allProcessed.addAll(processed);
				}
			}
			
			for(T po : allProcessed) {
				po.saveFinish(false, allSuccess);
			}

			if (allSuccess) {
				if (internalTrx) {
					trx.commit(true);
				} else if (savepoint != null) {
					trx.releaseSavepoint(savepoint);
					savepoint = null;
				}
			} else {
				if (internalTrx) {
					trx.rollback();
				} else if (savepoint != null) {
					trx.rollback(savepoint);
					savepoint = null;
				}
			}
		} catch (Exception e) {
			s_log.log(Level.SEVERE, "executeBatch", e);
			allSuccess = false;
			if (internalTrx) {
				trx.rollback();
			} else if (savepoint != null) {
				try {
					trx.rollback(savepoint);
				} catch (SQLException e1) {}
				savepoint = null;
			}
		} finally {
			DB.close(pstmt);
			if (internalTrx) {
				trx.close();
			}
		}

		return allSuccess;
	}

	@Override
	public boolean isEmpty() {
		return m_list.isEmpty();
	}
}
