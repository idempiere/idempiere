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
import static org.junit.jupiter.api.Assertions.fail;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import javax.xml.transform.stream.StreamResult;

import org.adempiere.util.Callback;
import org.adempiere.webui.apps.BackgroundJob;
import org.compiere.model.MAging;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MNote;
import org.compiere.model.MOrder;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.PrintInfo;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.print.MPrintFormat;
import org.compiere.print.PrintData;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.report.MReport;
import org.compiere.tools.FileUtil;
import org.compiere.util.DB;
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
		assertFalse(pi.isError(), pi.getSummary());
		File file = pi.getPDFReport();

		assertEquals(file.getName(), fileName);
		assertTrue(file.length() > 0, "Generated PDF file is empty");
	}
	
	@Test
	public void testBackgroundJob() {
		MProcess process = null;
		ProcessInfo pi = null;
		MPInstance pinstance = null;
		MNote note = null;
		try {
			process = MProcess.get(236);
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
				Thread.sleep(100);
			} catch (InterruptedException e) {}
			
			assertTrue(pi.getAD_PInstance_ID() > 0, "Failed to create background process instance");
			assertFalse(pi.isError(), "Error creating background job: " + pi.getSummary());
			pinstance = new MPInstance(Env.getCtx(), pi.getAD_PInstance_ID(), null);
			assertEquals(pi.getAD_PInstance_ID(), pinstance.get_ID(), "Failed to retrive background process instance");
			try {
				pi = future.get(10000, TimeUnit.MILLISECONDS);
			} catch (ExecutionException | TimeoutException | InterruptedException e) {
				e.printStackTrace();
				fail("Error waiting for background job to complete: " + e.getMessage());
			}
			assertFalse(pi.isError(), "Error running background job: " + pi.getSummary());
			pinstance.load((String)null);
			assertFalse(pinstance.isProcessing(), "Timeout waiting for background job to complete");
			
			Query query = new Query(Env.getCtx(), MNote.Table_Name, "AD_Table_ID=? AND Record_ID=?", null);
			note = query.setParameters(MPInstance.Table_ID, pinstance.getAD_PInstance_ID()).first();
			assertNotNull(note, "Failed to retrieve notice");
			MAttachment attachment = note.getAttachment();
			assertEquals(1, attachment.getEntryCount(), "Unexpected number of notice attachment");
			MAttachmentEntry entry = attachment.getEntry(0);
			assertNotNull(entry, "Failed to retrieve attachment entry");
			assertTrue(entry.getName() != null && entry.getName().toUpperCase().contains(".PDF"), "No PDF report attach to notice");
			
		} finally {
			rollback();

			// Clean up in reverse order of creation
			if (note != null) {
				MAttachment attachment = note.getAttachment();
				if (attachment != null) {
					attachment.deleteEx(true);
				}
				note.deleteEx(true);
			}
			
			if (pinstance != null) {
				pinstance.deleteEx(true);
			}
		}
	}
	
	@Test
	public void testCreateXML() {
		// 360 | RV_OrderDetail | AD_Table
		// 164 | RV_OrderDetail | AD_ReportView
		MPrintFormat pf = MPrintFormat.get(Env.getCtx(), 164, 360);
		if (pf == null) {
			pf = MPrintFormat.createFromTable(Env.getCtx(), 360);
			assertNotNull(pf, "Failed to create Print Format from Table");
		}
		// query
		MQuery query = new MQuery(MTable.get(pf.getAD_Table_ID()).getTableName());
		query.addRestriction("C_BPartner_ID", MQuery.EQUAL, DictionaryIDs.C_BPartner.C_AND_W.id);

		PrintInfo info = new PrintInfo(
			pf.getName(),
			0,
			0,
			0);
		info.setCopies(1);
		ReportEngine re = new ReportEngine(Env.getCtx(), pf, query, info);
		PrintData data = re.getPrintData();
		assertTrue(data.getRowCount() > 0);
		StringWriter writer = new StringWriter();
		re.createXML(writer);

		StringBuffer buffer = writer.getBuffer();
		assertTrue(buffer.length() > 0);
		// validate xml document using sax parser
		try {
			javax.xml.parsers.SAXParserFactory factory = javax.xml.parsers.SAXParserFactory.newInstance();
			factory.setValidating(false);
			factory.setNamespaceAware(true);
			javax.xml.parsers.SAXParser parser = factory.newSAXParser();
			org.xml.sax.InputSource is = new org.xml.sax.InputSource(new java.io.StringReader(buffer.toString()));
			parser.parse(is, new org.xml.sax.helpers.DefaultHandler());
		} catch (Exception e) {
			fail("XML is not well-formed: " + e.getMessage());
		}
		
		// test PrintData export and parse xml
		File file = null;
		try {
			file = File.createTempFile("PrintDataTest", ".xml");
			file.deleteOnExit();
		} catch (IOException e) {
			fail("Failed to create temp file: " + e.getMessage());
		}
		data.createXML(new StreamResult(file));
		PrintData copy = PrintData.parseXML(Env.getCtx(), file);
		assertNotNull(copy, "Failed to parse PrintData XML");
		assertEquals(data.getRowCount(), copy.getRowCount(), "PrintData row count mismatch");
	}
	
	@Test
	public void testFinancialReport() {
		MProcess financialReport = MProcess.get(Env.getCtx(), SystemIDs.PROCESS_RPT_FINREPORT);
		//100 | Balance Sheet Current Month
		MReport report = new MReport(Env.getCtx(), 100, getTrxName());
		assertNotNull(report, "Failed to retrieve Financial Report");
		assertEquals(100, report.get_ID(), "Unexpected Financial Report ID");
		String fileName = FileUtil.makePrefix(report.getName()) + ".pdf";

		ProcessInfo pi = new ProcessInfo(financialReport.getName(), financialReport.getAD_Process_ID());
		pi.setRecord_ID(report.get_ID());
		pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		pi.setTable_ID(report.get_Table_ID());
		pi.setPrintPreview(true);
		pi.setIsBatch(true);
		pi.setPDFFileName(fileName);
		pi.setReportType("PDF");
		MPInstance instance = new MPInstance(financialReport, report.get_Table_ID(), report.get_ID(), report.get_UUID());
		instance.saveEx();
		ServerProcessCtl.process(pi, null);
		assertFalse(pi.isError(), pi.getSummary());
		File file = pi.getPDFReport();

		assertEquals(file.getName(), fileName);
		assertTrue(file.length() > 0, "Generated PDF file is empty");
	}
	
	@Test
	public void testAgingReport() {
		List<PO> created = new ArrayList<PO>();
		try {
			// 238 | Aging | AD_Process
			// 631 | T_Aging | AD_Table
			// 137 | T_Aging | AD_ReportView
			int Aging_Process_ID = 238;
			MPrintFormat pf = MPrintFormat.get(Env.getCtx(), 137, MAging.Table_ID);
			if (pf == null) {
				pf = MPrintFormat.createFromTable(Env.getCtx(), MAging.Table_ID);
				assertNotNull(pf, "Failed to create Print Format from Table");
				created.add(pf);
			}
			
			MPInstance pInstance = new MPInstance(Env.getCtx(), Aging_Process_ID, 0, 0, "");
			pInstance.setAD_PrintFormat_ID(pf.get_ID());
			pInstance.setReportType("HTML");
			pInstance.saveEx();
			created.add(pInstance);
			
			MPInstancePara para = new MPInstancePara(Env.getCtx(), pInstance.getAD_PInstance_ID(), 10);
			para.setParameterName(MAging.COLUMNNAME_C_BPartner_ID);
			para.setP_Number(DictionaryIDs.C_BPartner.C_AND_W.id);
			para.saveEx();
			created.add(para);
			
			para = new MPInstancePara(Env.getCtx(), pInstance.getAD_PInstance_ID(), 20);
			para.setParameterName(MAging.COLUMNNAME_IsSOTrx);
			para.setP_String("Y");
			para.saveEx();
			created.add(para);
			
			ProcessInfo pi = new ProcessInfo("Aging", Aging_Process_ID);
			pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
			pi.setPrintPreview(true);
			pi.setIsBatch(true);
			pi.setReportType("PDF");
			pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());		
			ServerProcessCtl.process(pi, null);
			assertFalse(pi.isError(), pi.getSummary());

			int id = DB.getSQLValueEx(null, "SELECT C_BPartner_ID FROM T_Aging WHERE AD_PInstance_ID=? AND C_BPartner_ID IS NOT NULL", pInstance.getAD_PInstance_ID());
			assertEquals(DictionaryIDs.C_BPartner.C_AND_W.id, id, "Aging report query did not return expected results");

			File file = pi.getPDFReport();
			assertTrue(file.length() > 0, "Generated PDF file is empty");
		} finally {
			rollback();
			if (!created.isEmpty()) {
				Collections.reverse(created);
				for (PO po : created) {
					po.deleteEx(true);
				}
			}
		}
	}
}
