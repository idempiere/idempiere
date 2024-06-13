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

import java.io.File;

import org.compiere.model.MOrder;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.SystemIDs;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Diego Ruiz - BX Service GmbH
 */
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
}
