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

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;
import org.idempiere.db.util.SQLFragment;

/**
 * Batch Update PO.<br/>
 * Difference from individual PO update - no auto reload of PO after successful save.
 * @param <T> PO type
 * @author iDempiere
 */
public class BatchUpdate<T extends PO> implements IBatchOperation<T> {
	private static final CLogger s_log = CLogger.getCLogger(BatchUpdate.class);
	private List<T> m_list = new ArrayList<>();
	private Class<T> type;

	private record BatchElement<T extends PO>(T po, List<Object> parameters) {}

	public BatchUpdate(Class<T> type) {
		this.type = type;
	}
	
	@Override
	public void add(T po) {
		if (po != null && type.isInstance(po)) {
			m_list.add(po);
		}
	}

	@Override
	public void executeBatch(String trxName) {
		if (m_list.isEmpty()) {
			return;
		}

		Trx trx = null;
		boolean internalTrx = false;
		String localTrxName = trxName;
		if (localTrxName != null) {
			trx = Trx.get(localTrxName, false);
			if (trx == null)
			{
				// Using a trx that was previously closed or never opened
				// Creating and starting the transaction right here, but please note
				// that this is not a good practice
				trx = Trx.get(localTrxName, true);
				s_log.severe("Transaction closed or never opened ("+localTrxName+") => starting now --> " + toString());
			}
		} else {
			localTrxName = Trx.createTrxName("BatchUpdate");
			trx = Trx.get(localTrxName, true);
			internalTrx = true;
		}

		Map<String, List<BatchElement<T>>> sqlMap = new LinkedHashMap<>();
		BatchInsert<MChangeLog> changeLogBatch = new BatchInsert<>(MChangeLog.class);

		Savepoint savepoint = null;
		boolean allSuccess = true;
		Connection conn = null;

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
					if (CLogger.peekError() == null)
						s_log.saveError("Error","beforeSave failed - " + po.toString());
					allSuccess = false;
					break;
				}

				String errorMsg = ModelValidationEngine.get().fireModelChange(po, ModelValidator.TYPE_CHANGE);
				if (errorMsg != null) {
					s_log.warning("Validation failed - " + errorMsg);
					s_log.saveError(errorMsg, "");
					allSuccess = false;
					break;
				}

				if (!po.doOrganizationCheckForSave()) {
					if (CLogger.peekError() == null)
						s_log.saveError("Error", "Organization check failed - " + po.toString());
					allSuccess = false;
					break;
				}

				// build update sql
				SQLFragment sqlFragment = po.buildUpdateSQL(po.isLogSQLScript(), null, changeLogBatch);
				if (sqlFragment == null) {
					if (CLogger.peekError() == null)
						s_log.saveError("Error", "Failed to build update SQL - " + po.toString());
					allSuccess = false;
					break;
				}
				if (sqlFragment.sqlClause() == null || sqlFragment.sqlClause().length() == 0) {
					// no changes, pretend success
					po.m_idOld = po.get_ID();
					if (po.afterSave(false, true)) {
						errorMsg = ModelValidationEngine.get().fireModelChange(po, ModelValidator.TYPE_AFTER_CHANGE);
						if (errorMsg != null) {
							s_log.warning("Validation failed - " + errorMsg);
							s_log.saveError(errorMsg, "");
							allSuccess = false;
						}
					} else {
						if (CLogger.peekError() == null)
							s_log.saveError("Error", "afterSave failed - " + po.toString());
						allSuccess = false;
					}
					continue;
				}

				sql = sqlFragment.sqlClause();
				sql = DB.getDatabase().convertStatement(sql);
				sqlMap.computeIfAbsent(sql, k -> new ArrayList<>()).add(new BatchElement<>(po, sqlFragment.parameters()));
			}

			// insert change logs
			if (allSuccess && !changeLogBatch.isEmpty()) {				
				changeLogBatch.executeBatch(localTrxName);
			}

			List <T> allProcessed = new ArrayList<>();
			if (allSuccess) {
				for (Map.Entry<String, List<BatchElement<T>>> entry : sqlMap.entrySet()) {
					sql = entry.getKey();
					try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
						List<T> processed = new ArrayList<>();			
						for (BatchElement<T> element : entry.getValue()) {
							T po = element.po();
							List<Object> params = element.parameters();
							if (params != null && !params.isEmpty()) {
								DB.setParameters(pstmt, params);
							}
							pstmt.addBatch();
							pstmt.clearParameters();
							processed.add(po);
						}
						int[] results = pstmt.executeBatch();
						for (int i = 0; i < results.length; i++) {
							T po = processed.get(i);
							if (results[i] != 1 && results[i] != Statement.SUCCESS_NO_INFO) {
								s_log.warning("Batch execution failed for " + po.toString());
								if (CLogger.peekError() == null)
									s_log.saveError("Error", "Batch execution failed - " + po.toString());
								allSuccess = false;
								break;
							} else {
								allSuccess = po.lobSave();
								if (!allSuccess)
									break;
							}
						}
						if (!allSuccess) {
							break;
						}
						allProcessed.addAll(processed);
					}
				}
			}
			
			if (allSuccess) {
				for(T po : allProcessed) {
					allSuccess = po.saveFinish(false, allSuccess);
					if (!allSuccess)
						break;
				}
			}

			if (allSuccess) {
				if (internalTrx) {
					trx.commit(true);
				} else if (savepoint != null) {
					trx.releaseSavepoint(savepoint);
					savepoint = null;
				}
			} else {
				rollback(trx, internalTrx, savepoint);
				throwSaveError();
			}
		} catch (Exception e) {
			s_log.log(Level.SEVERE, "executeBatch", e);
			if (e instanceof BatchUpdateException batchUpdateException)
				throw batchUpdateException;

			rollback(trx, internalTrx, savepoint);
			if (e instanceof RuntimeException runtimeException)
				throw runtimeException;
			else if (e instanceof SQLException sqlException)
				throw new DBException(sqlException);
			else
				throw new AdempiereException(e);
		} finally {
			if (internalTrx) {
				trx.close();
			}
		}
	}

	@Override
	public boolean isEmpty() {
		return m_list.isEmpty();
	}

	@Override
	public int getCount() {
		return m_list.size();
	}

	/**
	 * Throw BatchUpdateException based on CLogger error
	 * @throws BatchUpdateException
	 */
	private void throwSaveError() {
		StringBuilder msg = new StringBuilder();
		ValueNamePair err = CLogger.retrieveError();
		String val = err != null ? Msg.translate(Env.getCtx(), err.getValue()) : "";
		if (err != null) {
			if (val != null) {
				msg.append(val);
				if (val.endsWith(":"))
					msg.append(" ");
				else if (! val.endsWith(": "))
					msg.append(": ");
			}
			msg.append(err.getName());
		}
		if (msg.length() == 0)
			msg.append("SaveError");
		Exception ex = CLogger.retrieveException();
		throw new BatchUpdateException(msg.toString(), ex);
	}

	/**
	 * Batch Update Exception
	 */
	private static class BatchUpdateException extends AdempiereException {
		/**
		 * 
		 */
		private static final long serialVersionUID = -2458156172535084920L;

		public BatchUpdateException(String message, Throwable cause) {
			super(message, cause);
		}
	}

	private void rollback(Trx trx, boolean internalTrx, Savepoint savepoint) {
		if (internalTrx) {
			trx.rollback();
		} else if (savepoint != null) {
			try {
				trx.rollback(savepoint);
			} catch (SQLException e) {
				s_log.log(Level.FINE, "Rollback to savepoint failed", e);
			}
		}
	}
}
