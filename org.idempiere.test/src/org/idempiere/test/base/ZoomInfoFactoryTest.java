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
 * - hengsin                                                           *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.adempiere.model.ZoomInfoFactory;
import org.adempiere.model.ZoomInfoFactory.ZoomInfo;
import org.compiere.model.MBPartner;
import org.compiere.model.MQuery;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Unit tests for {@link ZoomInfoFactory} and {@link ZoomInfo}.
 */
public class ZoomInfoFactoryTest extends AbstractTestCase {

	@Test
	public void testGetRecordCountWithNullQuery() {
		ZoomInfo zoomInfo = new ZoomInfo(SystemIDs.WINDOW_SALES_ORDER, null, "Sales Order");
		assertEquals(0, zoomInfo.getRecordCount(), "Record count should be 0 when query is null");
	}

	@Test
	public void testGetRecordCountWithQuery() {
		MQuery query = new MQuery();
		query.setRecordCount(0);
		ZoomInfo zoomInfo = new ZoomInfo(SystemIDs.WINDOW_SALES_ORDER, query, "Sales Order");
		assertEquals(0, zoomInfo.getRecordCount(), "Record count should match query record count 0");

		query.setRecordCount(5);
		assertEquals(5, zoomInfo.getRecordCount(), "Record count should match query record count 5");
	}

	@Test
	public void testGetRecordCountFromRetrievedZoomInfos() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		List<ZoomInfo> zoomInfos = ZoomInfoFactory.retrieveZoomInfos(bpartner, SystemIDs.WINDOW_BUSINESS_PARTNER);
		assertNotNull(zoomInfos, "Zoom infos should not be null");
		assertFalse(zoomInfos.isEmpty(), "Zoom infos should not be empty for Joe Block");

		boolean hasPositiveRecordCount = false;
		for (ZoomInfo zoomInfo : zoomInfos) {
			int expected = zoomInfo.query == null ? 0 : zoomInfo.query.getRecordCount();
			assertEquals(expected, zoomInfo.getRecordCount(),
					"ZoomInfo.getRecordCount() should match underlying query record count");
			if (zoomInfo.getRecordCount() > 0) {
				hasPositiveRecordCount = true;
			}
		}
		assertTrue(hasPositiveRecordCount, "At least one zoom info should have positive record count");
	}
}
