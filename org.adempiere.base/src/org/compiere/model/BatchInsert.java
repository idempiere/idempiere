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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Trx;

/**
 * Batch Insert PO
 * @param <T> PO type
 * @author iDempiere
 */
public class BatchInsert<T extends PO> implements IBatchOperation<T> {
	private static final CLogger s_log = CLogger.getCLogger(BatchInsert.class);
	private List<T> m_list = new ArrayList<>();
	
	private record BatchElement<T extends PO>(T po, List<Object> parameters) {}

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
	 * Execute batch insert
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
			localTrxName = Trx.createTrxName("BatchInsert");
			trx = Trx.get(localTrxName, true);
			internalTrx = true;
		}

		Map<String, List<BatchElement<T>>> sqlMap = new LinkedHashMap<>();

		Savepoint savepoint = null;
		boolean allSuccess = true;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			if (m_list.get(0) instanceof MChangeLog) {
				PO.setCrossTenantSafe();
			}
			conn = trx.getConnection(true);
			if (!internalTrx) {
				savepoint = trx.setSavepoint(null);
			}

			MSession session = null;

			BatchInsert<MChangeLog> changeLogBatch = new BatchInsert<>();
			for (T po : m_list) {
				po.set_TrxName(localTrxName);
				if (!po.doVerificationForSave()) {
					allSuccess = false;
					break;
				}
				if (!po.is_new()) {
					s_log.warning("Not a new record - " + po.toString());
					allSuccess = false;
					break;
				}
				if (!po.beforeSave(true)) {
					s_log.warning("beforeSave failed - " + po.toString());
					allSuccess = false;
					break;
				}

				String errorMsg = ModelValidationEngine.get().fireModelChange(po, ModelValidator.TYPE_NEW);
				if (errorMsg != null) {
					s_log.warning("Validation failed - " + errorMsg);
					allSuccess = false;
					break;
				}

				if (!po.doOrganizationCheckForSave()) {
					allSuccess = false;
					break;
				}

				// PK
				if (!po.set_IDForNewRecord(localTrxName)) {
					allSuccess = false;
					break;
				}
				po.set_UUIDForNewRecord();
				po.set_DocumentNoForNewRecord();
				po.set_ValueForNewRecord();

				if (session == null) {
					session = MSession.get(po.getCtx());
				}

				StringBuilder sqlb = new StringBuilder();
				List<Object> params = new ArrayList<>();
				po.buildInsertSQL(sqlb, false, params, session, 0, false, null, changeLogBatch);

				sqlMap.computeIfAbsent(sqlb.toString(), k -> new ArrayList<>()).add(new BatchElement<>(po, params));
			}

			// insert change logs
			if (!changeLogBatch.isEmpty()) {				
				if (!changeLogBatch.executeBatch(localTrxName)) {
					allSuccess = false;
				}
			}

			// execute batch insert
			List <T> allProcessed = new ArrayList<>();
			if (allSuccess) {
				for (Map.Entry<String, List<BatchElement<T>>> entry : sqlMap.entrySet()) {
					String sql = entry.getKey();
					pstmt = conn.prepareStatement(sql);
					List<T> processed = new ArrayList<>();			
					for (BatchElement<T> element : entry.getValue()) {
						T po = element.po();
						List<Object> params = element.parameters();
						if (params != null) {
							DB.setParameters(pstmt, params);
						}
						pstmt.addBatch();
						pstmt.clearParameters();
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
				po.saveFinish(true, allSuccess);
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
			if (m_list.get(0) instanceof MChangeLog) {
				PO.clearCrossTenantSafe();
			}
		}

		return allSuccess;
	}

	@Override
	public boolean isEmpty() {
		return m_list.isEmpty();
	}
}
