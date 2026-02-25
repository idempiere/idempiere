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
 * Batch Delete PO
 * @param <T> PO type
 * @author iDempiere
 */
public class BatchDelete<T extends PO> implements IBatchOperation<T> {
	private static final CLogger s_log = CLogger.getCLogger(BatchDelete.class);
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
	 * Execute batch delete
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
			localTrxName = Trx.createTrxName("BatchDelete");
			trx = Trx.get(localTrxName, true);
			internalTrx = true;
		}

		Savepoint savepoint = null;
		boolean allSuccess = true;
		Connection conn = null;

		try {
			conn = trx.getConnection(true);
			if (!internalTrx) {
				savepoint = trx.setSavepoint(null);
			}

			List<String> preDeleteStatements = new ArrayList<>();
			Map<String, List<T>> sqlMap = new LinkedHashMap<>();
			Map<T, List<Object>> paramMap = new HashMap<>();

			List<T> deletes = new ArrayList<>(m_list);
			List<PO> updates = new ArrayList<>();
			List<PO> preDeletes = new ArrayList<>();

			// 1. Process deletions (including cascades)
			for (int i = 0; i < deletes.size(); i++) {
				T po = deletes.get(i);
				po.set_TrxName(localTrxName);
				if (!po.doVerificationForDelete(false)) {
					allSuccess = false;
					break;
				}

				int AD_Table_ID = po.get_Table_ID();
				int Record_ID = po.get_ID();
				String Record_UU = po.get_UUID();
				String errorMsg = PO_Record.exists(AD_Table_ID, Record_ID, localTrxName);
				if (errorMsg == null && Record_UU != null)
					errorMsg = PO_Record.exists(AD_Table_ID, Record_UU, localTrxName);
				if (errorMsg != null) {
					s_log.saveError("CannotDelete", errorMsg);
					allSuccess = false;
					break;
				}

				if (!po.beforeDelete()) {
					s_log.warning("beforeDelete failed - " + po.toString());
					allSuccess = false;
					break;
				}

				errorMsg = ModelValidationEngine.get().fireModelChange(po, po.isReplication() ? ModelValidator.TYPE_BEFORE_DELETE_REPLICATION : ModelValidator.TYPE_DELETE);
				po.setReplication(false);
				if (errorMsg != null) {
					s_log.warning("Validation failed - " + errorMsg);
					allSuccess = false;
					break;
				}

				// Translations
				String sql = po.get_deleteTranslationsSQL();
				if (sql != null) {
					preDeleteStatements.add(sql);
				}
				// Trees
				if (po.is_hasCustomTree()) {
					sql = po.get_deleteTreeSQL(MTree_Base.TREETYPE_CustomTable, false);
					preDeleteStatements.add(sql);
				}

				// Cascades
				String[] keyColumns = po.get_KeyColumns();
				if (keyColumns != null && keyColumns.length == 1 && !MTable.get(po.get_Table_ID()).isUUIDKeyTable()) {
					PO_Record.deleteModelCascade(po.get_TableName(), Record_ID, localTrxName, preDeletes);
					PO_Record.deleteRecordCascade(po.get_Table_ID(), Record_ID, "AD_Table.TableName NOT IN ('AD_Attachment','AD_Archive')", localTrxName, preDeletes);
					PO_Record.setRecordNull(po.get_Table_ID(), Record_ID, localTrxName, updates);
				}
				if (Record_UU != null) {
					PO_Record.deleteModelCascade(po.get_TableName(), Record_UU, localTrxName, preDeletes);
					PO_Record.deleteRecordCascade(po.get_Table_ID(), Record_UU, "AD_Table.TableName NOT IN ('AD_Attachment','AD_Archive')", localTrxName, preDeletes);
					PO_Record.setRecordNull(po.get_Table_ID(), Record_UU, localTrxName, updates);
				}

				// Main Delete
				SQLFragment sqlFragment = po.get_deleteStatement();
				sqlMap.computeIfAbsent(sqlFragment.sqlClause(), k -> new ArrayList<>()).add(po);
				if (!sqlFragment.parameters().isEmpty()) {
					paramMap.put(po, sqlFragment.parameters());
				}
			}

			if (!allSuccess) {
				rollback(trx, internalTrx, savepoint);
				return false;
			}

			// 2. Process delete of dependent records
			if (preDeletes.size() > 0) {
				BatchDelete<PO> batchDelete = new BatchDelete<>();
				for (PO po : preDeletes)
					batchDelete.add(po);
				allSuccess = batchDelete.executeBatch(localTrxName);
			}

			// 3. Process updates (mostly from setRecordNull)
			if (allSuccess && updates.size() > 0) {
				BatchUpdate<PO> batchUpdate = new BatchUpdate<>();
				for(PO po : updates) {
					batchUpdate.add(po);
				}
				allSuccess = batchUpdate.executeBatch(localTrxName);
			}
			
			if (!allSuccess) {
				rollback(trx, internalTrx, savepoint);
				return false;
			}

			// 4. Execute pre delete statements (delete translations, trees, etc)
			Statement stmt = null;
			try {
				stmt = conn.createStatement();
				for (String sql : preDeleteStatements) {					
					stmt.addBatch(sql);
				}
				int[] results = stmt.executeBatch();
				for (int i = 0; i < results.length; i++) {
					if (results[i] == Statement.EXECUTE_FAILED) {
						s_log.warning("Batch execution failed for " + preDeleteStatements.get(i));
						allSuccess = false;
					}
				}
			} catch (SQLException e) {
				s_log.log(Level.SEVERE, "Failed to execute pre delete statements", e);
				allSuccess = false;
				rollback(trx, internalTrx, savepoint);
				return false;
			} finally {
				DB.close(stmt);
			}

			if (!allSuccess) {
				rollback(trx, internalTrx, savepoint);
				return false;
			}

			// 5. Execute delete
			PreparedStatement pstmt = null;
			try {
				for (Map.Entry<String, List<T>> entry : sqlMap.entrySet()) {
					String sql = entry.getKey();
					pstmt = conn.prepareStatement(sql);
					for (T po : entry.getValue()) {
						List<Object> params = paramMap.get(po);
						if (params != null && !params.isEmpty()) {
							DB.setParameters(pstmt, params);
						}
						pstmt.addBatch();
					}
					int[] results = pstmt.executeBatch();
					pstmt.close();
					pstmt = null;

					for (int i = 0; i < results.length; i++) {
						T po = entry.getValue().get(i);
						po.m_idOld = po.get_ID();
						po.m_IDs[0] = PO.I_ZERO;
						po.m_attachment = null;
						if (results[i] == Statement.EXECUTE_FAILED) {
							s_log.warning("Batch execution failed for " + po.toString());
							allSuccess = false;
							po.afterDelete(false);
							break;
						}
					}
					if (!allSuccess) {
						break;
					}
				}
			} finally {
				DB.close(pstmt);
			}

			if (allSuccess) {
				for(T po : deletes) {
					allSuccess = po.afterDelete(true);
					if (allSuccess) {
						ModelValidationEngine.get().fireModelChange(po, ModelValidator.TYPE_AFTER_DELETE);
						po.setupDeleteActionsForTransactionEvent();
					}
					if (!allSuccess) {
						break;
					}
				}
			}

			if (allSuccess) {
				if (internalTrx) {
					trx.commit(true);
				} else if (savepoint != null) {
					trx.releaseSavepoint(savepoint);
					savepoint = null;
				}
				for(T po : deletes) {
					if (!po.postDelete()) {
						s_log.warning("postDelete failed");
					}
					po.afterPostDelete();
				}
			} else {
				rollback(trx, internalTrx, savepoint);
			}

		} catch (Exception e) {
			s_log.log(Level.SEVERE, "executeBatch", e);
			allSuccess = false;
			rollback(trx, internalTrx, savepoint);
		} finally {
			if (internalTrx) {
				trx.close();
			}
		}

		return allSuccess;
	}

	private void rollback(Trx trx, boolean internalTrx, Savepoint savepoint) {
		if (internalTrx) {
			trx.rollback();
		} else if (savepoint != null) {
			try {
				trx.rollback(savepoint);
			} catch (SQLException e) {}
		}
	}

	@Override
	public boolean isEmpty() {
		return m_list.isEmpty();
	}
}
