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
 * - Carlos Ruiz - globalqss	       								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.adempiere.util.Callback;
import org.adempiere.webui.apps.BackgroundJob;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MNote;
import org.compiere.model.MOrder;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MUser;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * @author Diego Ruiz - BX Service GmbH
 */
@Isolated
public class ReportTest extends AbstractTestCase {

	public ReportTest() {
	}

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-6165
	 */
	@Test
	public void testPDFFileName() {
		MProcess orderReport = MProcess.get(Env.getCtx(), SystemIDs.PROCESS_RPT_C_ORDER);
		MOrder order = new MOrder(Env.getCtx(),  108, getTrxName()); // Garden Order 60000

		String fileName = order.getDocumentNo() + ".pdf";

		ProcessInfo pi = new ProcessInfo(orderReport.getName(), orderReport.getAD_Process_ID());
		pi.setRecord_ID(order.getC_Order_ID());
		pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		pi.setTable_ID(order.get_Table_ID());
		pi.setPrintPreview(true);
		pi.setIsBatch(true);
		pi.setPDFFileName(fileName);
		pi.setReportType("PDF");
		MPInstance instance = new MPInstance(orderReport, order.get_Table_ID(), order.getC_Order_ID(), order.getC_Order_UU());
		instance.saveEx();
		ServerProcessCtl.process(pi, null);
		File file = pi.getPDFReport();

		assertEquals(file.getName(), fileName);

	}
	
	@Test
	public void testBackgroundJob() {
		//Storage Detail report
		MProcess process = MProcess.get(236);
		ProcessInfo pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
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
			Thread.sleep(100);
		} catch (InterruptedException e) {}
		
		assertTrue(pi.getAD_PInstance_ID() > 0, "Failed to create background process instance");
		assertFalse(pi.isError(), "Error creating background job: " + pi.getSummary());
		MPInstance pinstance = new MPInstance(Env.getCtx(), pi.getAD_PInstance_ID(), null);
		assertEquals(pi.getAD_PInstance_ID(), pinstance.get_ID(), "Failed to retrive background process instance");
		try {
			pi = future.get(10000, TimeUnit.MILLISECONDS);
		} catch (ExecutionException | TimeoutException | InterruptedException e) {
			e.printStackTrace();
		}
		assertFalse(pi.isError(), "Error running background job: " + pi.getSummary());
		pinstance.load((String)null);
		assertFalse(pinstance.isProcessing(), "Timeout waiting for background job to complete");
		
		Query query = new Query(Env.getCtx(), MNote.Table_Name, "AD_Table_ID=? AND Record_ID=?", null);
		MNote note = query.setParameters(MPInstance.Table_ID, pinstance.getAD_PInstance_ID()).first();
		assertNotNull(note, "Failed to retrieve notice");
		MAttachment attachment = note.getAttachment();
		assertEquals(1, attachment.getEntryCount(), "Unexpected number of notice attachment");
		MAttachmentEntry entry = attachment.getEntry(0);
		assertNotNull(entry, "Failed to retrieve attachment entry");
		assertTrue(entry.getName() != null && entry.getName().toUpperCase().contains(".PDF"), "No PDF report attach to notice");
	}
}
