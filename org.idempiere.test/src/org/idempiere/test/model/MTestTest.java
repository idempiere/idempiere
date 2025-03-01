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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.CrossTenantException;
import org.compiere.model.MTest;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
public class MTestTest extends AbstractTestCase {

	private static final String TestInGardenWorld = "6846b9eb-aff1-47c8-8b50-e9632b39c0c7";
	private static final String TestInSystem = "d08e9de9-39e5-485c-ad50-e8bc7ee0f575";

	public MTestTest() {
	}

	@Test
	public void testReadingUpdatingTest() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MTest test = new MTest(ctx, TestInGardenWorld, trxName);
		test.setDescription("Test setting description");
		test.saveEx();
		test.load(trxName);
		String newDescription = test.getDescription();
	    assertTrue(newDescription.startsWith("Test setting description"));
		MTest testSys = new MTest(ctx, TestInSystem, trxName);
		testSys.setDescription("Test setting description");
		AdempiereException thrown = assertThrows(
				AdempiereException.class,
				() -> testSys.saveEx(),
				"Expected test.SaveEx() to throw cross tenant error, but it didn't"
				);
		assertTrue(thrown instanceof CrossTenantException);
	}

	@Test
	public void testInsertingTest() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MTest test = new MTest(ctx, PO.UUID_NEW_RECORD, trxName);
		test.setName("Test UU record created on JUnit test");
		test.saveEx();
		test.load(trxName);
	    assertEquals("Test UU record created on JUnit test", test.getName());
	    String uukey = test.getTest_UU();
	    String uuid = test.get_UUID();
	    assertTrue(Util.isUUID(uukey));
	    assertEquals(uukey, uuid);
	}

	@Test
	public void testDeletingTest() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MTest test = new MTest(ctx, TestInGardenWorld, trxName);
		test.deleteEx(true);
		MTest test2 = new MTest(ctx, TestInGardenWorld, trxName);
	    assertFalse(test2.get_UUID().equals(TestInGardenWorld));
	}

}
