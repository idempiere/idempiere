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

import org.compiere.model.MOrder;
import org.compiere.process.ProcessInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.print.ServerReportCtl;
import org.compiere.util.Env;
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
}
