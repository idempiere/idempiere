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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Properties;

import org.compiere.model.MColumnAccess;
import org.compiere.model.MRole;
import org.compiere.model.MTableAccess;
import org.compiere.model.X_AD_Alert;
import org.compiere.model.X_AD_Color;
import org.compiere.model.X_AD_WizardProcess;
import org.compiere.model.X_A_Asset;
import org.compiere.model.X_A_Asset_Change;
import org.compiere.model.X_C_BankTransfer;
import org.compiere.model.X_C_Order;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.DictionaryIDs.AD_Org;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;


public class MRoleTest extends AbstractTestCase {

	private MRole defaultRole;

	@BeforeEach
	public void setup() {
		defaultRole = MRole.getDefault(); //GardenAdmin role
	}

	@Test
	void testGetDefault() {
		assertNotNull(defaultRole);

		// Based on the login credentials from Abstract Test Case, default login should be GardenAdmin
		assertEquals(GARDEN_WORLD_ADMIN_ROLE, defaultRole.getAD_Role_ID());
	}

	@Test
	void testGetDefault_withContext() {
		// Null with  invalid context 
		assertNull(MRole.getDefault(new Properties(), false));

		// Null with null context 
		Exception ex = assertThrows(IllegalArgumentException.class, () -> {
			MRole.getDefault(null, false);
		});
		assertTrue(ex.getMessage().contains("Require Context"));
	}

	@Test
	void testGet() {
		MRole role = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		assertNotNull(role);

		// Get System Role
		role = MRole.get(Env.getCtx(), 0);
		assertNotNull(role);
	}

	@Test
	void testClientAccess() {

		// Test same client access
		assertTrue(defaultRole.isClientAccess(11, false));
		assertTrue(defaultRole.isClientAccess(11, true));

		// Test system client access 
		assertFalse(defaultRole.isClientAccess(0, true));
		assertTrue(defaultRole.isClientAccess(0, false)); //Can always read System

		// Test client access for wrong client ID
		assertFalse(defaultRole.isClientAccess(15, true));        
	}

	@Test
	void testOrgAccess() {

		// GardenAdmin has explicit access to all organizations 
		for (AD_Org org : AD_Org.values()) {
			assertTrue(defaultRole.isOrgAccess(org.id, true));
			assertTrue(defaultRole.isOrgAccess(org.id, false));
		}
		// Access to a non-existing organization should return false
		assertFalse(defaultRole.isOrgAccess(1234, true));

		MRole role = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN_NOT_ADVANCED.id);
		// GardenAdmin - Not Advanced - Access All Orgs = Y
		for (AD_Org org : AD_Org.values()) {
			assertTrue(role.isOrgAccess(org.id, true));
			assertTrue(role.isOrgAccess(org.id, false));
		}

		role = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		// GardenUser - Access All Orgs = N - only access to 4 Orgs
		assertTrue(role.isOrgAccess(DictionaryIDs.AD_Org.HQ.id, true));
		assertFalse(role.isOrgAccess(DictionaryIDs.AD_Org.STORE_EAST.id, true));
		assertFalse(role.isOrgAccess(DictionaryIDs.AD_Org.STORE_EAST.id, false));
		assertFalse(role.isOrgAccess(1234, false));
	}

	/** Table Access Level **/
	@Test
	public void testIsTableAccess_WrongID() {
		assertFalse(defaultRole.isTableAccess(1234, false));
	}

	@Test
	public void testIsTableAccess_SystemOnly() {
		defaultRole.setUserLevel(MRole.USERLEVEL_System);

		assertFalse(defaultRole.isTableAccess(X_AD_WizardProcess.Table_ID, false), 
				"Client level tables must NOT work with client only");

		assertFalse(defaultRole.isTableAccess(X_C_BankTransfer.Table_ID, false),
				"Organization level tables must NOT work with system only");

		assertFalse(defaultRole.isTableAccess(X_A_Asset.Table_ID, false), 
				"Client+Organization level tables must NOT work with system only");

		assertTrue(defaultRole.isTableAccess(X_A_Asset_Change.Table_ID, false),
				"All level tables must work with system only");

		assertTrue(defaultRole.isTableAccess(X_AD_Alert.Table_ID, false), 
				"System+Client level tables must work with system only");

		assertTrue(defaultRole.isTableAccess(X_AD_Color.Table_ID, false), 
				"System level tables must work with system only");
	}

	@Test
	public void testIsTableAccess_ClientOnly() {
		defaultRole.setUserLevel(MRole.USERLEVEL_Client);

		assertTrue(defaultRole.isTableAccess(X_AD_WizardProcess.Table_ID, false), 
				"Client level tables must work with client only");

		assertFalse(defaultRole.isTableAccess(X_C_BankTransfer.Table_ID, false), 
				"Organization level tables must NOT work with client only");

		assertFalse(defaultRole.isTableAccess(X_A_Asset.Table_ID, false), 
				"Client+Organization level tables must NOT work with client only");

		assertTrue(defaultRole.isTableAccess(X_A_Asset_Change.Table_ID, false), 
				"All level tables must work with client only");

		assertTrue(defaultRole.isTableAccess(X_AD_Alert.Table_ID, false), 
				"System+Client level tables must work with client only");

		assertFalse(defaultRole.isTableAccess(X_AD_Color.Table_ID, false), 
				"System level tables must NOT work with client only");
	}

	@Test
	public void testIsTableAccess_OrganizationOnly() {
		defaultRole.setUserLevel(MRole.USERLEVEL_Organization);

		assertFalse(defaultRole.isTableAccess(X_AD_WizardProcess.Table_ID, false), 
				"Client level tables must NOT work with Organization only");

		assertTrue(defaultRole.isTableAccess(X_C_BankTransfer.Table_ID, false), 
				"Organization level tables must work with Organization only");

		assertTrue(defaultRole.isTableAccess(X_A_Asset.Table_ID, false), 
				"Client+Organization level tables must work with Organization only");

		assertTrue(defaultRole.isTableAccess(X_A_Asset_Change.Table_ID, false), 
				"All level tables must work with Organization only");

		assertFalse(defaultRole.isTableAccess(X_AD_Alert.Table_ID, false), 
				"System+Client level tables must NOT work with Organization only");

		assertFalse(defaultRole.isTableAccess(X_AD_Color.Table_ID, false), 
				"System level tables must NOT work with Organization only");
	}

	@Test
	public void testIsTableAccess_ClientPlusOrganization() {
		assertTrue(defaultRole.isTableAccess(X_AD_WizardProcess.Table_ID, false),
				"Client level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(X_C_BankTransfer.Table_ID, false), 
				"Organization level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(X_A_Asset.Table_ID, false), 
				"Client+Organization level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(X_A_Asset_Change.Table_ID, false), 
				"All level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(X_AD_Alert.Table_ID, false), 
				"System+Client level tables must work with both Client and Organization");

		assertFalse(defaultRole.isTableAccess(X_AD_Color.Table_ID, false), 
				"System level tables must NOT work with both Client and Organization");
	}
	
	@Test
	public void testIsTableAccess_ExcludeTableAccess() {
		int RV_BPartner_TABLE_ID = 520; //Client+Organization level table

		MTableAccess tableAccess = new MTableAccess(Env.getCtx(), 0, getTrxName());
		tableAccess.setAD_Table_ID(RV_BPartner_TABLE_ID);
		tableAccess.setAD_Role_ID(DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		tableAccess.setIsExclude(true);
		tableAccess.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
		tableAccess.saveEx();
		
		MRole role = new MRole(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, getTrxName());
		role.loadAccess(true);
		assertFalse(role.isTableAccess(RV_BPartner_TABLE_ID, false), "Table is excluded, should not be accessible");
	}
	
	@Test
	public void testIsTableAccess_IncludeTableAccess() {
		int RV_BPartner_TABLE_ID = 520; //Client+Organization level table

		MTableAccess tableAccess = new MTableAccess(Env.getCtx(), 0, getTrxName());
		tableAccess.setAD_Table_ID(RV_BPartner_TABLE_ID);
		tableAccess.setAD_Role_ID(DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		tableAccess.setIsExclude(false);
		tableAccess.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
		tableAccess.saveEx();
		
		MRole role = new MRole(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, getTrxName());
		role.loadAccess(true);
		
		assertTrue(role.isTableAccess(RV_BPartner_TABLE_ID, false), "Table is included, should be accessible");
		assertFalse(role.isTableAccess(X_C_Order.Table_ID, false), "One table is included, all the others should not be accessible");
		assertFalse(role.isTableAccess(X_C_Order.Table_ID, true), "One table is included, all the others should not be accessible - even in read only");
	}

	/** Column Access **/
	
    @Test
    void testColumnAccess_CheckAccess() {
        assertTrue(defaultRole.isColumnAccess(X_AD_Color.Table_ID, 6230, true), 
        		"System level columns should always be accessible in read only mode");
        assertFalse(defaultRole.isColumnAccess(X_AD_Color.Table_ID, 6230, false), 
        		"System level columns should not be accessible in read write mode");
    }
    
    @Test
    void testColumnAccess_NoExistingColumn() {
        assertTrue(defaultRole.isColumnAccess(X_C_Order.Table_ID, 6230, true), 
        		"System level columns should always be accessible in read only mode");
    }
	
	@Test
	public void testIsColumnAccess_ExcludeColumnAccess() {
		
		int documentNoColumnID = 2169; // DocumentNo column in C_Order table

		MColumnAccess columnAccess = new MColumnAccess(Env.getCtx(), 0, getTrxName());
		columnAccess.setAD_Table_ID(X_C_Order.Table_ID);
		columnAccess.setAD_Column_ID(documentNoColumnID);
		columnAccess.setAD_Role_ID(DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		columnAccess.setIsExclude(true);
		columnAccess.setIsReadOnly(false);
		columnAccess.saveEx();
		
		MRole role = new MRole(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, getTrxName());
		role.loadAccess(true);
		assertFalse(role.isColumnAccess(X_C_Order.Table_ID, documentNoColumnID, false, getTrxName()), 
				"Column is excluded, should not be accessible");
		assertTrue(role.isColumnAccess(X_C_Order.Table_ID, 55314, false, getTrxName()), 
				"Document No Column is excluded, other columns should be accessible");
		assertFalse(role.isColumnAccess(X_C_Order.Table_ID, documentNoColumnID, true, getTrxName()), 
				"Column is excluded, should not be accessible");
		
		columnAccess.setIsReadOnly(true);
		columnAccess.saveEx();
		role.loadAccess(true);
		assertFalse(role.isColumnAccess(X_C_Order.Table_ID, documentNoColumnID, false, getTrxName()), 
				"Column is excluded with read only, should be accessible only for read only");
		assertTrue(role.isColumnAccess(X_C_Order.Table_ID, documentNoColumnID, true, getTrxName()), 
				"Column is excluded with read only, should be accessible for read only");
	}

}
