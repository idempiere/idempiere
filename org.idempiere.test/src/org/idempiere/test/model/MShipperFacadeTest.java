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
 * MA 02111-1307 USA.                                                 *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.adempiere.model.MShipperFacade;
import org.compiere.model.MBPartner;
import org.compiere.model.MShipper;
import org.compiere.model.MShippingProcessor;
import org.compiere.model.MShippingProcessorCfg;
import org.compiere.model.X_C_BP_ShippingAcct;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Tests for {@link MShipperFacade}.
 */
public class MShipperFacadeTest extends AbstractTestCase {

	private MShippingProcessor createProcessor(String name) {
		MShippingProcessorCfg cfg = new MShippingProcessorCfg(Env.getCtx(), 0, getTrxName());
		cfg.setHostAddress("0.0.0.0");
		cfg.setName(name + " Config");
		cfg.setHostPort(0);
		cfg.saveEx();

		MShippingProcessor processor = new MShippingProcessor(Env.getCtx(), 0, getTrxName());
		processor.setM_ShippingProcessorCfg_ID(cfg.get_ID());
		processor.setUserID("-");
		processor.setConnectionPassword("-");
		processor.setName(name);
		processor.saveEx();
		return processor;
	}

	private X_C_BP_ShippingAcct createShippingAcct(int bpId, int orgId, int processorId,
			String shipperAccount, String dutiesAccount, String shipperMeter, boolean isActive) {
		X_C_BP_ShippingAcct acct = new X_C_BP_ShippingAcct(Env.getCtx(), 0, getTrxName());
		acct.setAD_Org_ID(orgId);
		acct.setC_BPartner_ID(bpId);
		if (processorId > 0)
			acct.setM_ShippingProcessor_ID(processorId);
		acct.setShipperAccount(shipperAccount);
		acct.setDutiesShipperAccount(dutiesAccount);
		acct.setShipperMeter(shipperMeter);
		acct.setIsActive(isActive);
		acct.saveEx();
		return acct;
	}

	@Test
	public void testShipperAccountAndMeterLookup() {
		MBPartner bp = new MBPartner(Env.getCtx(), 0, getTrxName());
		bp.setValue("TestShipperBP-" + System.currentTimeMillis());
		bp.setName("Test Shipper BP");
		bp.setC_BP_Group_ID(DictionaryIDs.C_BP_Group.STANDARD_CUSTOMERS.id);
		bp.saveEx();

		MShippingProcessor proc1 = createProcessor("Processor 1");
		MShippingProcessor proc2 = createProcessor("Processor 2");

		MShipper shipper1 = new MShipper(Env.getCtx(), 0, getTrxName());
		shipper1.setName("Shipper 1");
		shipper1.setC_BPartner_ID(bp.getC_BPartner_ID());
		shipper1.setM_ShippingProcessor_ID(proc1.get_ID());
		shipper1.saveEx();

		MShipper shipperNoProc = new MShipper(Env.getCtx(), 0, getTrxName());
		shipperNoProc.setName("Shipper No Processor");
		shipperNoProc.setC_BPartner_ID(bp.getC_BPartner_ID());
		shipperNoProc.saveEx();

		MShipperFacade facade1 = new MShipperFacade(shipper1);
		MShipperFacade facadeNoProc = new MShipperFacade(shipperNoProc);

		// No accounts yet -> null
		assertNull(facade1.getShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertNull(facade1.getDutiesShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertNull(facade1.getShipperMeter(DictionaryIDs.AD_Org.HQ.id));

		// Account for another processor must be ignored; inactive HQ account must be ignored
		createShippingAcct(bp.getC_BPartner_ID(), DictionaryIDs.AD_Org.HQ.id, proc2.get_ID(),
				"999-999", "888-888", "METER-999", true);
		createShippingAcct(bp.getC_BPartner_ID(), DictionaryIDs.AD_Org.HQ.id, proc1.get_ID(),
				"777-777", "666-666", "METER-777", false);

		assertNull(facade1.getShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertNull(facade1.getDutiesShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertNull(facade1.getShipperMeter(DictionaryIDs.AD_Org.HQ.id));

		// Org 0 fallback with M_ShippingProcessor_ID IS NULL matches both shipper1 and shipperNoProc
		createShippingAcct(bp.getC_BPartner_ID(), DictionaryIDs.AD_Org.GLOBAL.id, 0,
				"111-222 333", "444-555 666", "METER-000", true);

		assertEquals("111222333", facade1.getShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("444555666", facade1.getDutiesShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("METER-000", facade1.getShipperMeter(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("111222333", facadeNoProc.getShipperAccount(DictionaryIDs.AD_Org.HQ.id));

		// Processor-specific account at Org 0 takes precedence over NULL processor at Org 0 for shipper1,
		// while shipperNoProc still only matches the NULL processor account
		createShippingAcct(bp.getC_BPartner_ID(), DictionaryIDs.AD_Org.GLOBAL.id, proc1.get_ID(),
				"222-333 444", "555-666 777", "METER-PROC1-0", true);

		assertEquals("222333444", facade1.getShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("555666777", facade1.getDutiesShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("METER-PROC1-0", facade1.getShipperMeter(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("111222333", facadeNoProc.getShipperAccount(DictionaryIDs.AD_Org.HQ.id));

		// Org-specific account takes precedence over Org 0 fallback, and another org falls back to Org 0
		createShippingAcct(bp.getC_BPartner_ID(), DictionaryIDs.AD_Org.HQ.id, proc1.get_ID(),
				"333-444 555", "666-777 888", "METER-HQ", true);

		assertEquals("333444555", facade1.getShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("666777888", facade1.getDutiesShipperAccount(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("METER-HQ", facade1.getShipperMeter(DictionaryIDs.AD_Org.HQ.id));
		assertEquals("222333444", facade1.getShipperAccount(DictionaryIDs.AD_Org.STORE_CENTRAL.id));
	}
}
