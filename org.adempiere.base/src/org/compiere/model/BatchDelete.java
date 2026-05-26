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
import org.compiere.util.TrxEventListener;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.db.util.SQLFragment;

/**
 * Batch Delete PO
 * @param <T> PO type
 * @author iDempiere
 */
public class BatchDelete<T extends PO> implements IBatchOperation<T> {
	private static final CLogger s_log = CLogger.getCLogger(BatchDelete.class);
	private List<T> m_list = new ArrayList<>();
	private Class<T> type;

	private record BatchElement<T extends PO>(T po, List<Object> parameters) {}

	public BatchDelete(Class<T> type) {
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
			localTrxName = Trx.createTrxName("BatchDelete");
			trx = Trx.get(localTrxName, true);
			internalTrx = true;
		}

		Savepoint savepoint = null;
		boolean allSuccess = true;
		Connection conn = null;

		// follow BatchInsert logic for save error and throwing of exception
		try {
			conn = trx.getConnection(true);
			if (!internalTrx) {
				savepoint = trx.setSavepoint(null);
			}

			List<String> preDeleteStatements = new ArrayList<>();
			Map<String, List<BatchElement<T>>> sqlMap = new LinkedHashMap<>();

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
					if (CLogger.peekError() == null)
						s_log.saveError("Error", "beforeDelete failed - " + po.toString());
					allSuccess = false;
					break;
				}

				errorMsg = ModelValidationEngine.get().fireModelChange(po, po.isReplication() ? ModelValidator.TYPE_BEFORE_DELETE_REPLICATION : ModelValidator.TYPE_DELETE);
				po.setReplication(false);
				if (errorMsg != null) {
					s_log.warning("Validation failed - " + errorMsg);
					s_log.saveError(errorMsg, "");
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
					try {
						sql = po.get_deleteTreeSQL(MTree_Base.TREETYPE_CustomTable, true);
					} catch (Exception e) {
						s_log.log(Level.SEVERE, "get_deleteTreeSQL failed - " + po.toString(), e);
						s_log.saveError("Error", e.getMessage());
						allSuccess = false;
						break;
					}
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
				sqlMap.computeIfAbsent(sqlFragment.sqlClause(), k -> new ArrayList<>()).add(new BatchElement<>(po, sqlFragment.parameters()));
				
			}

			if (!allSuccess) {
				rollback(trx, internalTrx, savepoint);
				throwSaveError();
			}

			// 2. Process delete of dependent records
			if (!preDeletes.isEmpty()) {
				BatchDelete<PO> batchDelete = new BatchDelete<>(PO.class);
				for (PO po : preDeletes)
					batchDelete.add(po);
				batchDelete.executeBatch(localTrxName);
			}

			// 3. Process updates (mostly from setRecordNull)
			if (allSuccess && !updates.isEmpty()) {
				BatchUpdate<PO> batchUpdate = new BatchUpdate<>(PO.class);
				for(PO po : updates) {
					batchUpdate.add(po);
				}
				batchUpdate.executeBatch(localTrxName);
			}

			// 4. Execute pre delete statements (delete translations, trees, etc)
			Statement stmt = null;
			try {
				stmt = conn.createStatement();
				for (String sql : preDeleteStatements) {	
					sql = DB.getDatabase().convertStatement(sql);				
					stmt.addBatch(sql);
				}
				int[] results = stmt.executeBatch();
				for (int i = 0; i < results.length; i++) {
					if (results[i] < 0 && results[i] != Statement.SUCCESS_NO_INFO) {
						s_log.warning("Batch execution failed for " + preDeleteStatements.get(i));
						if (CLogger.peekError() == null)
							s_log.saveError("Error", "Batch execution failed - " + preDeleteStatements.get(i));
						allSuccess = false;
						break;
					}
				}
			} catch (SQLException e) {
				s_log.log(Level.SEVERE, "Failed to execute pre delete statements", e);
				allSuccess = false;
				rollback(trx, internalTrx, savepoint);
				throw new DBException(e);
			} finally {
				DB.close(stmt);
			}

			if (!allSuccess) {
				rollback(trx, internalTrx, savepoint);
				throwSaveError();
			}

			// 5. Execute delete
			for (Map.Entry<String, List<BatchElement<T>>> entry : sqlMap.entrySet()) {
				String sql = entry.getKey();
				sql = DB.getDatabase().convertStatement(sql); 
				try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
					for (BatchElement<T> element : entry.getValue()) {
						List<Object> params = element.parameters();
						if (params != null && !params.isEmpty()) {
							DB.setParameters(pstmt, params);
						}
						pstmt.addBatch();
						pstmt.clearParameters();
					}
					int[] results = pstmt.executeBatch();

					for (int i = 0; i < results.length; i++) {
						T po = entry.getValue().get(i).po();
						if (results[i] <= 0 && results[i] != Statement.SUCCESS_NO_INFO) {
							s_log.warning("Batch execution failed for " + po.toString());
							if (CLogger.peekError() == null)
								s_log.saveError("Error", "Batch execution failed - " + po.toString());
							allSuccess = false;
							po.afterDelete(false);
							break;
						}
						po.setupDeleteActionsForTransactionEvent(po.get_ID(), po.get_UUID());						
					}
					if (!allSuccess) {
						break;
					}
				}
			}
			
			// Change log
			if(allSuccess && !deletes.isEmpty() && MTable.get(deletes.get(0).get_Table_ID()).isChangeLog() 
				&& MSession.get (Env.getCtx()) != null)
			{				
				MSession session = MSession.get(Env.getCtx());
				BatchInsert<MChangeLog> changeLogBatch = new BatchInsert<>(MChangeLog.class);
				for(T po : deletes) {					
					if (po.m_IDs.length == 1 || !Util.isEmpty(po.get_UUID(), true))
					{
						int	AD_ChangeLog_ID = 0;
						int size = po.get_ColumnCount();						
						POInfo poInfo = POInfo.getPOInfo(Env.getCtx(), po.get_Table_ID());
						for (int i = 0; i < size; i++)
						{
							Object value = po.get_ValueOld(i);
							if (value != null
								&& poInfo.isAllowLogging(i)		//	logging allowed
								&& !poInfo.isEncrypted(i)		//	not encrypted
								&& !poInfo.isVirtualColumn(i)	//	no virtual column
								&& !"Password".equals(poInfo.getColumnName(i))
								)
							{
								// change log on delete
								MChangeLog cLog = session.changeLog (
									po.get_TrxName(), AD_ChangeLog_ID,
									poInfo.getAD_Table_ID(), poInfo.getColumn(i).AD_Column_ID,
									(po.m_IDs.length == 1 ? po.get_ID() : 0), po.get_UUID(), po.getAD_Client_ID(), po.getAD_Org_ID(), value, null, MChangeLog.EVENTCHANGELOG_Delete, false);
								if (cLog != null)
								{
									changeLogBatch.add(cLog);
									AD_ChangeLog_ID = cLog.getAD_ChangeLog_ID();
								}
							}
						} //   for all fields												
					}
				}
				if (!changeLogBatch.isEmpty()) {
					changeLogBatch.executeBatch(trx.getTrxName());
				}
			}

			// After delete
			if (allSuccess) {
				for(T po : deletes) {
					if (!po.afterDelete(true)) {
						if (CLogger.peekError() == null)
							s_log.saveError("Error", "afterDelete failed - " + po.toString());
						allSuccess = false;
						break;
					}
					String error = ModelValidationEngine.get().fireModelChange(po, ModelValidator.TYPE_AFTER_DELETE);
					if (error != null) {
						s_log.warning("Validation failed - " + error);
						s_log.saveError(error, "");
						allSuccess = false;
						break;
					}
				}
			}

			// Commit/Rollback and fire post-delete event
			if (allSuccess) {
				if (internalTrx) {
					trx.commit(true);
				} else if (savepoint != null) {
					trx.releaseSavepoint(savepoint);
					savepoint = null;
				}
				for(T po : deletes) {
					if (internalTrx) 
					{
						po.firePostDeleteEvent();
					}
					else
					{
						Trx trxdel = trx;
						trxdel.addTrxEventListener(new TrxEventListener() {
							@Override
							public void afterRollback(Trx trxdel, boolean success) {
								trxdel.removeTrxEventListener(this);
							}
							@Override
							public void afterCommit(Trx trxdel, boolean success) {
								if (success) {
									po.firePostDeleteEvent();
								}
								trxdel.removeTrxEventListener(this);
							}
							@Override
							public void afterClose(Trx trxdel) {
							}
						});						
					}
					po.resetStateAfterDelete();
				}
			} else {
				rollback(trx, internalTrx, savepoint);
				throwSaveError();
			}
		} catch (Exception e) {
			s_log.log(Level.SEVERE, "executeBatch", e);
			if (e instanceof BatchDeleteException batchDeleteException)
				throw batchDeleteException;
			
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
	 * Throw BatchDeleteException based on CLogger error
	 * @throws BatchDeleteException
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
		throw new BatchDeleteException(msg.toString(), ex);
	}

	/**
	 * Batch Delete Exception
	 */
	private static class BatchDeleteException extends AdempiereException {
		/**
		 * 
		 */
		private static final long serialVersionUID = -7883775051926324726L;

		public BatchDeleteException(String message, Throwable cause) {
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
