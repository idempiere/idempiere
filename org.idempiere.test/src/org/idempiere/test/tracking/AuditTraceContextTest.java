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
 * - Elaine Tan                         							   *
 **********************************************************************/
package org.idempiere.test.tracking;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.adempiere.util.Callback;
import org.adempiere.webui.apps.BackgroundJob;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MChangeLog;
import org.compiere.model.MNote;
import org.compiere.model.MOrder;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTest;
import org.compiere.model.MUser;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.tracking.AuditTraceContext;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

@Isolated
public class AuditTraceContextTest extends AbstractTestCase {
	
	public AuditTraceContextTest() {
	}
	
	@Test
	public void testChangeLog() {
		MSession.create(Env.getCtx());
		String externalTraceId = UUID.randomUUID().toString();
		AuditTraceContext.setExternalTraceId(externalTraceId);
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getValue(MSysConfig.SYSTEM_INSERT_CHANGELOG, "N", getAD_Client_ID()))
				.thenReturn("K");
			MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
			t1.saveEx();
			Query query = new Query(Env.getCtx(), MChangeLog.Table_Name, 
				MChangeLog.COLUMNNAME_AD_Table_ID + "=? AND " + MChangeLog.COLUMNNAME_Record_ID + "=?", getTrxName());
			MChangeLog changeLog = query.setParameters(MTest.Table_ID, t1.get_ID()).first();
			assertNotNull(changeLog, "No change log found for inserted record");
			assertTrue(changeLog.get_ID() > 0, "Change log ID is invalid");
			assertEquals(externalTraceId, changeLog.getExternalTraceId(), "Unexpected ExternalTraceId");
		} finally {
			AuditTraceContext.clear();
		}
	}

	@Test
	public void testProcess() {
		String externalTraceId = UUID.randomUUID().toString();
		AuditTraceContext.setExternalTraceId(externalTraceId);
		try {
	        Trx trx = Trx.get(getTrxName(), false);
	        MProcess process = MProcess.get(Env.getCtx(), SystemIDs.PROCESS_RPT_C_ORDER);
	        MOrder order = new MOrder(Env.getCtx(), 108, getTrxName()); // Garden Order 60000
	        MPInstance pinstance = new MPInstance(process, order.get_Table_ID(), order.getC_Order_ID(), order.getC_Order_UU());
	        ProcessInfo pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
			pi.setTable_ID(pinstance.getAD_Table_ID());
			pi.setRecord_ID(pinstance.getRecord_ID());
	        boolean ok = process.processIt(pi, trx);
	        assertTrue(ok, "Report process must return true");
	        pinstance.load(getTrxName());
	        assertEquals(externalTraceId, pinstance.getExternalTraceId(), "Unexpected ExternalTraceId");
		} finally {
			AuditTraceContext.clear();
		}
    }
	
	@Test
	public void testBackgroundJob() {
		MSession.create(Env.getCtx());
		String externalTraceId = UUID.randomUUID().toString();
		AuditTraceContext.setExternalTraceId(externalTraceId);
		
		MProcess process = null;
		ProcessInfo pi = null;
		MPInstance pinstance = null;
		MNote note = null;
		int AD_Note_ID = 0;
		int AD_Attachment_ID = 0;
		try {
			process = MProcess.get(DictionaryIDs.AD_Process.RV_STORAGE.id); // Storage Detail
			pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
			pi.setReportType("PDF");
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			
			Callback<Integer> createParaCallback = id -> {
				if (id > 0) {
					MPInstancePara para = new MPInstancePara(Env.getCtx(), id, 10);
					para.setParameter("M_Product_Category_ID", ""+DictionaryIDs.M_Product_Category.PATIO.id);
					para.saveEx();
				}
			};
			
			ScheduledFuture<ProcessInfo> future = BackgroundJob.create(pi)
				.withNotificationType(MUser.NOTIFICATIONTYPE_Notice)
				.withInitialDelay(10)
				.run(createParaCallback);
			
			assertNotNull(future, "Failed to schedule background job");
			
			try {
				pi = future.get(10, TimeUnit.SECONDS);
			} catch (ExecutionException | TimeoutException e) {
			    fail("Error waiting for background job to complete: " + e.getMessage(), e);
			} catch (InterruptedException e) {
			    Thread.currentThread().interrupt();
			    fail("Interrupted while waiting for background job to complete", e);
			}
			
			assertTrue(pi.getAD_PInstance_ID() > 0, "Failed to create background process instance");
	        assertFalse(pi.isError(), "Error running background job: " + pi.getSummary());

	        pinstance = new MPInstance(Env.getCtx(), pi.getAD_PInstance_ID(), null);
	        assertEquals(pi.getAD_PInstance_ID(), pinstance.get_ID(), "Failed to retrieve background process instance");

	        pinstance.load((String) null);
	        assertFalse(pinstance.isProcessing(), "Background job still processing after completion");
			
			Query query = new Query(Env.getCtx(), MNote.Table_Name, "AD_Table_ID=? AND Record_ID=?", null);
			note = query.setParameters(MPInstance.Table_ID, pinstance.getAD_PInstance_ID()).first();
			assertNotNull(note, "Failed to retrieve notice");
			MAttachment attachment = note.getAttachment();
			assertNotNull(attachment, "Failed to retrieve notice attachment");
			assertEquals(1, attachment.getEntryCount(), "Unexpected number of notice attachment");
			MAttachmentEntry entry = attachment.getEntry(0);
			assertNotNull(entry, "Failed to retrieve attachment entry");
			assertTrue(entry.getName() != null && entry.getName().toUpperCase().contains(".PDF"), "No PDF report attach to notice");
						
			pinstance.load((String) null);
			assertEquals(externalTraceId, pinstance.getExternalTraceId(), "Unexpected ExternalTraceId");
		} finally {
			rollback();

			// Clean up in reverse order of creation
			if (note != null) {
				AD_Note_ID = note.get_ID();
				MAttachment attachment = note.getAttachment();
				if (attachment != null) {
					AD_Attachment_ID = attachment.get_ID();
					attachment.deleteEx(true);
				}
				note.deleteEx(true);
			}
			
			if (pinstance != null) {
				pinstance.deleteEx(true);
			}
			
			AuditTraceContext.clear();
		}
		
		Query query = new Query(Env.getCtx(), MChangeLog.Table_Name,
				MChangeLog.COLUMNNAME_AD_Table_ID + "=? AND "
				+ MChangeLog.COLUMNNAME_Record_ID + "=? AND "
				+ MChangeLog.COLUMNNAME_EventChangeLog + "=?", null);
		if (AD_Note_ID > 0) {
			List<MChangeLog> changeLogs = query.setParameters(
					MNote.Table_ID, AD_Note_ID, MChangeLog.EVENTCHANGELOG_Delete).list();
			assertFalse(changeLogs.isEmpty(), "No change log found");
			for (MChangeLog changeLog : changeLogs)
				assertEquals(externalTraceId, changeLog.getExternalTraceId(), "Unexpected ExternalTraceId");
		}
		
		if (AD_Attachment_ID > 0) {
			List<MChangeLog> changeLogs = query.setParameters(
					MAttachment.Table_ID, AD_Attachment_ID, MChangeLog.EVENTCHANGELOG_Delete).list();
			assertFalse(changeLogs.isEmpty(), "No change log found");
			for (MChangeLog changeLog : changeLogs)
				assertEquals(externalTraceId, changeLog.getExternalTraceId(), "Unexpected ExternalTraceId");
		}
	}
}
