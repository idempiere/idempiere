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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MQuery;
import org.compiere.model.MRequest;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class MRequestTest extends AbstractTestCase {

	public MRequestTest() {
	}

	@Test
	public void testRequestCount() {
		int[] counts = MRequest.getRequestCount(MBPartner.Table_ID, DictionaryIDs.C_BPartner.PATIO.id, DictionaryIDs.C_BPartner.PATIO.uuid, new StringBuilder(), getTrxName());
		
		MRequest req = new MRequest(Env.getCtx(), 0, getTrxName());
		req.setC_BPartner_ID(DictionaryIDs.C_BPartner.PATIO.id);
		req.setAD_Table_ID(MBPartner.Table_ID);
		req.setRecord_ID(req.getC_BPartner_ID());
		req.setProcessed(false);
		req.setR_RequestType_ID(DictionaryIDs.R_RequestType.SERVICE_REQUEST.id);
		req.setSummary("testRequestCount");
		req.setSalesRep_ID(getAD_User_ID());
		req.saveEx();
		
		int[] counts1 = MRequest.getRequestCount(MBPartner.Table_ID, DictionaryIDs.C_BPartner.PATIO.id, DictionaryIDs.C_BPartner.PATIO.uuid, new StringBuilder(), getTrxName());
		assertEquals(counts[0], counts1[0], "Unexpected processed request count");
		assertEquals(counts[1]+1, counts1[1], "Unexpected not processed request count");
		
		req.setProcessed(true);
		req.saveEx();
		
		counts1 = MRequest.getRequestCount(MBPartner.Table_ID, DictionaryIDs.C_BPartner.PATIO.id, DictionaryIDs.C_BPartner.PATIO.uuid, new StringBuilder(), getTrxName());
		assertEquals(counts[0]+1, counts1[0], "Unexpected processed request count");
		assertEquals(counts[1], counts1[1], "Unexpected not processed request count");
	}
	
	@Test
	public void testGridTabNewRequest() {
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_REQUESTS_ALL);
		assertNotNull(gridWindow, "Failed to load grid window of Request(All)");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MRequest.Table_ID);
		query.addRestriction("1=2");
		gridTab.setQuery(query);
		gridTab.query(false);
		MRequest.newRequest(gridTab, MBPartner.Table_ID, DictionaryIDs.C_BPartner.PATIO.id, DictionaryIDs.C_BPartner.PATIO.uuid, DictionaryIDs.C_BPartner.PATIO.id);
		assertTrue(gridTab.isNew(), "Current row of Grid Tab is not a new row");
		assertEquals(MBPartner.Table_ID, gridTab.getValue("AD_Table_ID"));				
		assertEquals(DictionaryIDs.C_BPartner.PATIO.id, gridTab.getValue("Record_ID"), "Unexpected Record_ID value");
		assertEquals(DictionaryIDs.C_BPartner.PATIO.id, gridTab.getValue("C_BPartner_ID"), "Unexpected C_BPartner_ID value");
	}
}
