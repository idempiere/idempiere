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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.spy;

import java.util.Properties;

import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUserRoles;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
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
	
	@Test
	public void testBeforeSave_MasterRoleValidation() {
		role.setIsMasterRole(true);
		role.saveEx();
		MUserRoles userRole = new MUserRoles(ctx, 0, getTrxName());
		userRole.setAD_User_ID(SUPERUSER_ID);
		userRole.setAD_Role_ID(role.getAD_Role_ID());
		boolean result = userRole.save();
		assertFalse(result, "Should not allow assigning a Role Template to a user");
		ValueNamePair error = CLogger.retrieveError();
		assertNotNull(error, "Expected error message not found");
		assertEquals(Msg.getMsg(Env.getCtx(), "CannotAssignRoleTemplateToUser"), error.getName(),
				"Expected error message for assigning Role Template to user");
	}
	
	@Test
	public void testAutoAssign_NonMasterRole() {
		try (MockedStatic<MSysConfig> config = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			config.when(() -> MSysConfig.getBooleanValue(MSysConfig.AUTO_ASSIGN_ROLE_TO_CREATOR_USER, false, getAD_Client_ID()))
				.thenReturn(true);
			role.setIsMasterRole(false);
			role.saveEx();
			
			Query query = new Query(ctx, MUserRoles.Table_Name, "AD_User_ID=? AND AD_Role_ID=?", getTrxName());
			MUserRoles userRoles = query.setParameters(SUPERUSER_ID, role.getAD_Role_ID()).first();
			assertNotNull(userRoles, "UserRole should be auto-assigned for non-Template Role");
			if (role.getCreatedBy() != SUPERUSER_ID) {
				userRoles = query.setParameters(role.getCreatedBy(), role.getAD_Role_ID()).first();
				assertNotNull(userRoles, "UserRole should be auto-assigned for non-Template Role");
			}
		}
	}
}