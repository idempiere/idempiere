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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Properties;

import org.compiere.model.MTestUU;
import org.compiere.model.PO;
import org.compiere.model.X_TestUUDet;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
@Execution(ExecutionMode.SAME_THREAD)
public class MTestUUTest extends AbstractTestCase {

	private static final String TestRecordInGardenWorld = "8858ecc2-cf1d-405f-987f-793536037e76";
	private static final String TestRecordInSystem = "4e148b89-bdd9-48a6-8a8a-7609092f965c";

	public MTestUUTest() {
	}

	@Test
	public void testReadingUpdatingTestUU() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MTestUU testuu = new MTestUU(ctx, TestRecordInGardenWorld, trxName);
		testuu.setDescription("Test setting description");
		testuu.saveEx();
		testuu.load(trxName);
	    assertEquals("Test setting description", testuu.getDescription());
	}

	@Test
	public void testInsertingTestUU() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MTestUU testuu = new MTestUU(ctx, PO.UUID_NEW_RECORD, trxName);
		testuu.setName("Test UU record created on JUnit test");
		testuu.saveEx();
		testuu.load(trxName);
	    assertEquals("Test UU record created on JUnit test", testuu.getName());
	    String uukey = testuu.getTestUU_UU();
	    String uuid = testuu.get_UUID();
	    assertTrue(Util.isUUID(uukey));
	    assertEquals(uukey, uuid);
	}

	@Test
	public void testDeletingTestUU() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MTestUU testuu = new MTestUU(ctx, TestRecordInGardenWorld, trxName);
		testuu.deleteEx(true);
		MTestUU testuu2 = new MTestUU(ctx, TestRecordInGardenWorld, trxName);
	    assertFalse(testuu2.get_UUID().equals(TestRecordInGardenWorld));
	}

	@Test
	public void testInsertingTestUUDet() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		X_TestUUDet testuudet = new X_TestUUDet(ctx, PO.UUID_NEW_RECORD, trxName);
		testuudet.setName("Test UU Det record created on JUnit test");
		testuudet.setTestUU_UU(TestRecordInGardenWorld);
		testuudet.setAltTestUU_UU(TestRecordInSystem);
		assertTrue(testuudet.validForeignKeys());
		testuudet.saveEx();
		testuudet.load(trxName);
	    assertEquals("Test UU Det record created on JUnit test", testuudet.getName());
	    String uukey = testuudet.getTestUUDet_UU();
	    String uuid = testuudet.get_UUID();
	    assertTrue(Util.isUUID(uukey));
	    assertEquals(uukey, uuid);
	    assertEquals(testuudet.getAltTestUU_UU(), TestRecordInSystem);
	    assertEquals(testuudet.getTestUU_UU(), TestRecordInGardenWorld);
	}

}
