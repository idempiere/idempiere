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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MPriceListTest extends AbstractTestCase {

	private final static int STANDARD_PRICELIST_ID=101;
	
	public MPriceListTest() {
	}

	@Test
	public void testAutoDeactiveVersion() {
		MPriceList priceList = new MPriceList(Env.getCtx(), STANDARD_PRICELIST_ID, getTrxName());
		assertEquals(STANDARD_PRICELIST_ID, priceList.get_ID());
		assertTrue(priceList.isActive());
		
		MPriceListVersion version = priceList.getPriceListVersion(null);
		assertNotNull(version);
		
		priceList.setIsActive(false);
		priceList.saveEx();
		
		version = priceList.getPriceListVersion(null);
		assertNull(version);
	}
}
