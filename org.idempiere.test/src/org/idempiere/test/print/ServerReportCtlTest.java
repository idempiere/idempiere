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
 * - hengsin                         							       *
 **********************************************************************/
package org.idempiere.test.print;

import java.io.File;
import java.sql.SQLException;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MClient;
import org.compiere.model.MOrder;
import org.compiere.process.ProcessInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.print.ServerReportCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class ServerReportCtlTest extends AbstractTestCase {

	/**
	 * Test order print
	 */
	@Test
	public void testOrderPrint() {
		// Verify MOrder 102 exists
		MOrder order = new MOrder(Env.getCtx(), 102, getTrxName());
		assertEquals(102, order.get_ID(), "Order 102 not found");
		
		// Order_Header  ** TEMPLATE ** | C_Order_Header_v | 100
		MPrintFormat format = MPrintFormat.get(100);				
		assertNotNull(format, "Print Format 'Order_Header  ** TEMPLATE **' not found");
        assertEquals(100, format.get_ID(), "Print Format 'Order_Header  ** TEMPLATE **' not found");
		
		// Prepare ProcessInfo
		ProcessInfo pi = new ProcessInfo("Test Order Print", 0);
		pi.setRecord_ID(order.get_ID());
		pi.setTable_ID(order.get_Table_ID());
		pi.setIsBatch(true);
		pi.setPrintPreview(true);
		pi.setPDFReport(null);
		
		boolean result = ServerReportCtl.startDocumentPrint(ReportEngine.ORDER, format, order.get_ID(), null, pi);
		
		assertTrue(result, "ServerReportCtl.startDocumentPrint failed");
		File pdf = pi.getPDFReport();
		assertNotNull(pdf, "PDF Report was not generated");
		assertTrue(pdf.exists(), "PDF Report file does not exist");
		assertTrue(pdf.length() > 0, "PDF Report file is empty");
	}

	/**
	 * Test order print inside the caller's transaction: the printed flag update must join the
	 * transaction, otherwise it waits for the row lock held by the modified order.
	 */
	@Test
	public void testOrderPrintInTransaction() {
		MOrder order = prepareOrderInTransaction();
		ProcessInfo pi = newOrderPrintInfo(order);

		assertTrue(ServerReportCtl.startDocumentPrint(ReportEngine.ORDER, MPrintFormat.get(100), order.get_ID(), null, pi),
				"ServerReportCtl.startDocumentPrint failed");

		String printed = DB.getSQLValueString(getTrxName(), "SELECT IsPrinted FROM C_Order WHERE C_Order_ID=?", order.get_ID());
		assertEquals("Y", printed, "Order not marked as printed in the transaction");
	}

	/**
	 * Test that the archive of a printed order is created in the caller's transaction.
	 * Auto archive is read from the cached client, so it is switched on with a committed
	 * update that is restored in the finally block.
	 */
	@Test
	public void testOrderPrintArchiveInTransaction() {
		int clientId = Env.getAD_Client_ID(Env.getCtx());
		String autoArchive = MClient.get(Env.getCtx()).getAutoArchive();
		setAutoArchive(clientId, MClient.AUTOARCHIVE_AllReportsDocuments);
		try {
			MOrder order = prepareOrderInTransaction();
			ProcessInfo pi = newOrderPrintInfo(order);
			String archiveSql = "SELECT COUNT(*) FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID=?";
			int before = DB.getSQLValueEx(getTrxName(), archiveSql, order.get_Table_ID(), order.get_ID());

			assertTrue(ServerReportCtl.startDocumentPrint(ReportEngine.ORDER, MPrintFormat.get(100), order.get_ID(), null, pi),
					"ServerReportCtl.startDocumentPrint failed");

			int after = DB.getSQLValueEx(getTrxName(), archiveSql, order.get_Table_ID(), order.get_ID());
			assertEquals(before + 1, after, "Archive not created in the transaction");
		} finally {
			setAutoArchive(clientId, autoArchive);
		}
	}

	/** Update AD_Client.AutoArchive in its own committed transaction and reset the client cache. */
	private void setAutoArchive(int clientId, String autoArchive) {
		String trxName = Trx.createTrxName("ServerReportCtlTest_AutoArchive");
		Trx trx = Trx.get(trxName, true);
		try {
			DB.executeUpdateEx("UPDATE AD_Client SET AutoArchive=? WHERE AD_Client_ID=?", new Object[] {autoArchive, clientId}, trxName);
			trx.commit(true);
		} catch (SQLException e) {
			throw new AdempiereException(e);
		} finally {
			trx.close();
		}
		CacheMgt.get().reset(MClient.Table_Name);
	}

	/** Load order 102 in the test transaction and modify it, holding a row lock until rollback. */
	private MOrder prepareOrderInTransaction() {
		MOrder order = new MOrder(Env.getCtx(), 102, getTrxName());
		assertEquals(102, order.get_ID(), "Order 102 not found");
		order.setDescription("print in trx");
		order.saveEx();
		return order;
	}

	private ProcessInfo newOrderPrintInfo(MOrder order) {
		ProcessInfo pi = new ProcessInfo("Test Order Print", 0);
		pi.setRecord_ID(order.get_ID());
		pi.setTable_ID(order.get_Table_ID());
		pi.setIsBatch(true);
		pi.setPrintPreview(true);
		pi.setTransactionName(getTrxName());
		return pi;
	}
}
