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
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.spy;

import java.util.Properties;

import org.compiere.model.MRole;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class MRoleMockedTest extends AbstractTestCase {
	
	private MRole role;
	private Properties ctx;
	private static final int SUPERUSER_ID = 100;

	@BeforeEach
	public void setUp() {
		ctx = Env.getCtx();
		role = spy(new MRole(ctx, 0, getTrxName()));
	    role.setName("Test Role");
	}

	@Test
	public void testBeforeSave_ClientIdZeroSetsUserLevelSystem() {
	    doReturn(0).when(role).getAD_Client_ID();
		doReturn(SUPERUSER_ID).when(role).getCreatedBy();
		doReturn(getTrxName()).when(role).get_TrxName();
		role.setUserLevel(MRole.USERLEVEL_Client); // Ensure not already set

		try {
			PO.setCrossTenantSafe();
			boolean result = role.save();
			assertTrue(result);
			assertEquals(MRole.USERLEVEL_System, role.getUserLevel(),
					"BeforeSave should set UserLevel to System for Client ID 0");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			PO.clearCrossTenantSafe();
		}
	}
	

	@Test
	public void testBeforeSave_ClientIdNotZeroSetsUserLevelSystem() {
		role.setUserLevel(MRole.USERLEVEL_System);
		boolean result = role.save();
		assertFalse(result, "BeforeSave should not allow saving with UserLevel System for non-zero Client ID");
	}
}