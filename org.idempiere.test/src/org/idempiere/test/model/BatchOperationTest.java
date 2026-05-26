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
 ***********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.util.List;

import org.compiere.dbPort.Convert;
import org.compiere.model.BatchDelete;
import org.compiere.model.BatchInsert;
import org.compiere.model.BatchUpdate;
import org.compiere.model.I_AD_UserPreference;
import org.compiere.model.MChangeLog;
import org.compiere.model.MNote;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.Query;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Integration test for batch operations
 * @author iDempiere
 */
public class BatchOperationTest extends AbstractTestCase {

	/**
	 * Test Batch Insert, Update and Delete
	 */
	@Test
	public void testBatchOperations() {
		MSession.create(Env.getCtx());
		boolean isChangeLog = MTable.get(Env.getCtx(), MNote.Table_ID).isChangeLog();
		try (MockedStatic<MSysConfig> msConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			msConfigMock.when(() -> MSysConfig.getValue(MSysConfig.SYSTEM_INSERT_CHANGELOG, "N", getAD_Client_ID())).thenReturn("Y");
			
			if (!isChangeLog) {
				MTable table = MTable.getCopy(Env.getCtx(), MNote.Table_ID, (String)null);
				table.setIsChangeLog(true);
				table.saveEx();
				CacheMgt.get().reset(MTable.Table_Name, MNote.Table_ID);
			}

			// 1. Batch Insert
			BatchInsert<MNote> insertBatch = new BatchInsert<>(MNote.class);
			for (int i = 0; i < 10; i++) {
				MNote note = new MNote(Env.getCtx(), 0, getTrxName());
				note.setAD_Table_ID(MUser.Table_ID);
				note.setRecord_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
				note.setTextMsg("org.idempiere.test.model.BatchOperationTest: " + i);
				note.setAD_Message_ID(125);
				insertBatch.add(note);
			}
			insertBatch.executeBatch(getTrxName());
			
			List<MNote> notes = new Query(Env.getCtx(), MNote.Table_Name, "TextMsg LIKE 'org.idempiere.test.model.BatchOperationTest:%' AND AD_Client_ID=?", getTrxName())
					.setParameters(getAD_Client_ID())
					.list();
			assertEquals(10, notes.size(), "Should have inserted 10 notes");
			StringBuilder builder = new StringBuilder("Record_ID IN (");
			for (int i = 0; i < notes.size(); i++) {
				builder.append("'");
				builder.append(notes.get(i).get_ID());
				builder.append("', ");
			}
			builder.delete(builder.length() - 2, builder.length());
			builder.append(")");
			
			// Verify change logs for insert
			long logCount = new Query(Env.getCtx(), MChangeLog.Table_Name, "AD_Table_ID=? AND EventChangeLog='I' AND AD_Client_ID=? AND "+builder.toString(), getTrxName())
					.setParameters(MNote.Table_ID, getAD_Client_ID())
					.count();
			assertTrue(logCount >= 10, "Should have change logs for insert");
			
			// 2. Batch Update
			BatchUpdate<MNote> updateBatch = new BatchUpdate<>(MNote.class);
			for (MNote note : notes) {
				note.setTextMsg(note.getTextMsg() + " Updated");
				updateBatch.add(note);
			}
			updateBatch.executeBatch(getTrxName());
			
			notes = new Query(Env.getCtx(), MNote.Table_Name, "TextMsg LIKE 'org.idempiere.test.model.BatchOperationTest: % Updated' AND AD_Client_ID=?", getTrxName())
					.setParameters(getAD_Client_ID())
					.list();
			assertEquals(10, notes.size(), "Should have updated 10 notes");
			
			// Verify change logs for update
			logCount = new Query(Env.getCtx(), MChangeLog.Table_Name, "AD_Table_ID=? AND EventChangeLog='U' AND AD_Client_ID=? AND "+builder.toString(), getTrxName())
					.setParameters(MNote.Table_ID, getAD_Client_ID())
					.count();
			assertTrue(logCount >= 10, "Should have change logs for update");

			// 3. Batch Delete
			BatchDelete<MNote> deleteBatch = new BatchDelete<>(MNote.class);
			for (MNote note : notes) {
				deleteBatch.add(note);
			}
			deleteBatch.executeBatch(getTrxName());
			
			notes = new Query(Env.getCtx(), MNote.Table_Name, "TextMsg LIKE 'org.idempiere.test.model.BatchOperationTest:% Updated' AND AD_Client_ID=?", getTrxName())
					.setParameters(getAD_Client_ID())
					.list();
			assertEquals(0, notes.size(), "Should have deleted 10 notes");
			
			// Verify change logs for delete
			logCount = new Query(Env.getCtx(), MChangeLog.Table_Name, "AD_Table_ID=? AND EventChangeLog='D' AND AD_Client_ID=? AND "+builder.toString(), getTrxName())
					.setParameters(MNote.Table_ID, getAD_Client_ID())
					.count();
			assertTrue(logCount >= 10, "Should have change logs for delete");
			
			// Verify change log with log migration script
			try {
				Env.getCtx().setProperty(Ini.P_LOGMIGRATIONSCRIPT, "Y");
				Env.setContext(Env.getCtx(), I_AD_UserPreference.COLUMNNAME_MigrationScriptComment, "testLogMigrationScript");
				assertTrue(Env.isLogMigrationScript(MNote.Table_Name), "Unexpected Log Migration Script Y/N value for MNote");
				insertBatch = new BatchInsert<>(MNote.class);
				for (int i = 0; i < 10; i++) {
					MNote note = new MNote(Env.getCtx(), 0, getTrxName());
					note.setAD_Table_ID(MUser.Table_ID);
					note.setRecord_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
					note.setTextMsg("org.idempiere.test.model.BatchOperationTest P_LOGMIGRATIONSCRIPT: " + i);
					note.setAD_Message_ID(125);
					insertBatch.add(note);
				}
				insertBatch.executeBatch(getTrxName());
				
				notes = new Query(Env.getCtx(), MNote.Table_Name, "TextMsg LIKE 'org.idempiere.test.model.BatchOperationTest P_LOGMIGRATIONSCRIPT:%' AND AD_Client_ID=?", getTrxName())
						.setParameters(getAD_Client_ID())
						.list();
				assertEquals(10, notes.size(), "Should have inserted 10 notes");
				builder = new StringBuilder("Record_ID IN (");
				for (int i = 0; i < notes.size(); i++) {
					builder.append("'");
					builder.append(notes.get(i).get_ID());
					builder.append("', ");
				}
				builder.delete(builder.length() - 2, builder.length());
				builder.append(")");

				logCount = new Query(Env.getCtx(), MChangeLog.Table_Name, "AD_Table_ID=? AND EventChangeLog='I' AND AD_Client_ID=? AND "+builder.toString(), getTrxName())
						.setParameters(MNote.Table_ID, getAD_Client_ID())
						.count();
				assertTrue(logCount >= 10, "Should have change logs for insert");
				
				// 2. Batch Update
				updateBatch = new BatchUpdate<>(MNote.class);
				for (MNote note : notes) {
					note.setTextMsg(note.getTextMsg() + " Updated");
					updateBatch.add(note);
				}
				updateBatch.executeBatch(getTrxName());
				
				notes = new Query(Env.getCtx(), MNote.Table_Name, "TextMsg LIKE 'org.idempiere.test.model.BatchOperationTest P_LOGMIGRATIONSCRIPT: % Updated' AND AD_Client_ID=?", getTrxName())
						.setParameters(getAD_Client_ID())
						.list();
				assertEquals(10, notes.size(), "Should have updated 10 notes");
				
				// Verify change logs for update
				logCount = new Query(Env.getCtx(), MChangeLog.Table_Name, "AD_Table_ID=? AND EventChangeLog='U' AND AD_Client_ID=? AND "+builder.toString(), getTrxName())
						.setParameters(MNote.Table_ID, getAD_Client_ID())
						.count();
				assertTrue(logCount >= 10, "Should have change logs for update");

				// 3. Batch Delete
				deleteBatch = new BatchDelete<>(MNote.class);
				for (MNote note : notes) {
					deleteBatch.add(note);
				}
				deleteBatch.executeBatch(getTrxName());
				
				notes = new Query(Env.getCtx(), MNote.Table_Name, "TextMsg LIKE 'org.idempiere.test.model.BatchOperationTest P_LOGMIGRATIONSCRIPT:% Updated' AND AD_Client_ID=?", getTrxName())
						.setParameters(getAD_Client_ID())
						.list();
				assertEquals(0, notes.size(), "Should have deleted 10 notes");	
				// Verify change logs for delete
				logCount = new Query(Env.getCtx(), MChangeLog.Table_Name, "AD_Table_ID=? AND EventChangeLog='D' AND AD_Client_ID=? AND "+builder.toString(), getTrxName())
						.setParameters(MNote.Table_ID, getAD_Client_ID())
						.count();
				assertTrue(logCount >= 10, "Should have change logs for delete");		
			} finally {
				String fileName = Convert.getGeneratedMigrationScriptFileName();
				if (!Util.isEmpty(fileName, true)) {
					String folderPg = Convert.getMigrationScriptFolder("postgresql");
					String folderOr = Convert.getMigrationScriptFolder("oracle");
					Convert.closeLogMigrationScript();
					File file = new File(folderPg + fileName);
					assertTrue(file.exists(), "Not found: " + folderPg + fileName);
					file.delete();
					file = new File(folderOr + fileName);
					assertTrue(file.exists(), "Not found: " + folderOr + fileName);
					file.delete();
				}
			}
		} finally {
			rollback();
			if (!isChangeLog) {
				MTable table = MTable.getCopy(Env.getCtx(), MNote.Table_ID, (String)null);
				table.setIsChangeLog(false);
				table.saveEx();
				CacheMgt.get().reset(MTable.Table_Name, MNote.Table_ID);
			}
		}
	}
}
