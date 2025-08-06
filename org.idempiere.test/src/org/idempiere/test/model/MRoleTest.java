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
import org.compiere.model.MRecordAccess;
import org.compiere.model.MRole;
import org.compiere.model.MTableAccess;
import org.compiere.model.X_AD_Alert;
import org.compiere.model.X_AD_Color;
import org.compiere.model.X_AD_Table;
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

	// Add static variables for table IDs
	private static final int CLIENT_LEVEL_TABLE_ID = X_AD_WizardProcess.Table_ID;
	private static final int ORGANIZATION_LEVEL_TABLE_ID = X_C_BankTransfer.Table_ID;
	private static final int CLIENT_ORGANIZATION_LEVEL_TABLE_ID = X_A_Asset.Table_ID;
	private static final int ALL_LEVEL_TABLE_ID = X_A_Asset_Change.Table_ID;
	private static final int SYSTEM_CLIENT_LEVEL_TABLE_ID = X_AD_Alert.Table_ID;
	private static final int SYSTEM_LEVEL_TABLE_ID = X_AD_Color.Table_ID;

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

		assertFalse(defaultRole.isTableAccess(CLIENT_LEVEL_TABLE_ID, false), 
				"Client level tables must NOT work with client only");

		assertFalse(defaultRole.isTableAccess(ORGANIZATION_LEVEL_TABLE_ID, false),
				"Organization level tables must NOT work with system only");

		assertFalse(defaultRole.isTableAccess(CLIENT_ORGANIZATION_LEVEL_TABLE_ID, false), 
				"Client+Organization level tables must NOT work with system only");

		assertTrue(defaultRole.isTableAccess(ALL_LEVEL_TABLE_ID, false),
				"All level tables must work with system only");

		assertTrue(defaultRole.isTableAccess(SYSTEM_CLIENT_LEVEL_TABLE_ID, false), 
				"System+Client level tables must work with system only");

		assertTrue(defaultRole.isTableAccess(SYSTEM_LEVEL_TABLE_ID, false), 
				"System level tables must work with system only");
	}

	@Test
	public void testIsTableAccess_ClientOnly() {
		defaultRole.setUserLevel(MRole.USERLEVEL_Client);

		assertTrue(defaultRole.isTableAccess(CLIENT_LEVEL_TABLE_ID, false), 
				"Client level tables must work with client only");

		assertFalse(defaultRole.isTableAccess(ORGANIZATION_LEVEL_TABLE_ID, false), 
				"Organization level tables must NOT work with client only");

		assertFalse(defaultRole.isTableAccess(CLIENT_ORGANIZATION_LEVEL_TABLE_ID, false), 
				"Client+Organization level tables must NOT work with client only");

		assertTrue(defaultRole.isTableAccess(ALL_LEVEL_TABLE_ID, false), 
				"All level tables must work with client only");

		assertTrue(defaultRole.isTableAccess(SYSTEM_CLIENT_LEVEL_TABLE_ID, false), 
				"System+Client level tables must work with client only");

		assertFalse(defaultRole.isTableAccess(SYSTEM_LEVEL_TABLE_ID, false), 
				"System level tables must NOT work with client only");
	}

	@Test
	public void testIsTableAccess_OrganizationOnly() {
		defaultRole.setUserLevel(MRole.USERLEVEL_Organization);

		assertFalse(defaultRole.isTableAccess(CLIENT_LEVEL_TABLE_ID, false), 
				"Client level tables must NOT work with Organization only");

		assertTrue(defaultRole.isTableAccess(ORGANIZATION_LEVEL_TABLE_ID, false), 
				"Organization level tables must work with Organization only");

		assertTrue(defaultRole.isTableAccess(CLIENT_ORGANIZATION_LEVEL_TABLE_ID, false), 
				"Client+Organization level tables must work with Organization only");

		assertTrue(defaultRole.isTableAccess(ALL_LEVEL_TABLE_ID, false), 
				"All level tables must work with Organization only");

		assertFalse(defaultRole.isTableAccess(SYSTEM_CLIENT_LEVEL_TABLE_ID, false), 
				"System+Client level tables must NOT work with Organization only");

		assertFalse(defaultRole.isTableAccess(SYSTEM_LEVEL_TABLE_ID, false), 
				"System level tables must NOT work with Organization only");
	}

	@Test
	public void testIsTableAccess_ClientPlusOrganization() {
		assertTrue(defaultRole.isTableAccess(CLIENT_LEVEL_TABLE_ID, false),
				"Client level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(ORGANIZATION_LEVEL_TABLE_ID, false), 
				"Organization level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(CLIENT_ORGANIZATION_LEVEL_TABLE_ID, false), 
				"Client+Organization level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(ALL_LEVEL_TABLE_ID, false), 
				"All level tables must work with both Client and Organization");

		assertTrue(defaultRole.isTableAccess(SYSTEM_CLIENT_LEVEL_TABLE_ID, false), 
				"System+Client level tables must work with both Client and Organization");

		assertFalse(defaultRole.isTableAccess(SYSTEM_LEVEL_TABLE_ID, false), 
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

	/** Record Access Level **/
	@Test
	void testRecordAccess() {
		MRole role = new MRole(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, getTrxName());
		role.loadAccess(true);
		assertTrue(role.isRecordAccess(X_C_Order.Table_ID, 108, false),
				"No record access defined, should be accessible by default");
	}

	@Test
	void testRecordAccessExclude() {
		int recordID = 108; // C_Order record ID

		MRecordAccess recordAccess = new MRecordAccess(Env.getCtx(), 0, getTrxName());
		recordAccess.setAD_Table_ID(X_C_Order.Table_ID);
		recordAccess.setAD_Role_ID(DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		recordAccess.setRecord_ID(recordID);
		recordAccess.setIsExclude(true);
		recordAccess.setIsReadOnly(true);
		recordAccess.saveEx();

		MRole role = new MRole(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, getTrxName());
		role.loadAccess(true);
		assertTrue(role.isRecordAccess(X_C_Order.Table_ID, recordID, true),
				"Record is excluded for read/write, should not accessible for read only");
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, recordID, false),
				"Record is excluded, should not be accessible");

		recordAccess.setIsReadOnly(false);
		recordAccess.saveEx();
		role.loadAccess(true);
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, recordID, true), 
				"Record is completely excluded, should not be accessible in read only mode");
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, recordID, false), 
				"Record is completely excluded, should not be accessible");
	}

	@Test
	void testRecordAccessInclude() {
		int recordID = 108; // C_Order record ID

		MRecordAccess recordAccess = new MRecordAccess(Env.getCtx(), 0, getTrxName());
		recordAccess.setAD_Table_ID(X_C_Order.Table_ID);
		recordAccess.setAD_Role_ID(DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		recordAccess.setRecord_ID(recordID);
		recordAccess.setIsExclude(false);
		recordAccess.setIsReadOnly(true);
		recordAccess.saveEx();

		MRole role = new MRole(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, getTrxName());
		role.loadAccess(true);
		assertTrue(role.isRecordAccess(X_C_Order.Table_ID, recordID, true),
				"Record is included for read only, should be accessible for reading");
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, recordID, false),
				"Record is included for read only, should not be accessible for writing");
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, 100, false),
				"Record 108 is included, no other records should be accessible");
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, 100, true),
				"Record 108 is included, no other records should be accessible");

		recordAccess.setIsReadOnly(false);
		recordAccess.saveEx();
		role.loadAccess(true);
		assertTrue(role.isRecordAccess(X_C_Order.Table_ID, recordID, true), 
				"Record is included for read/write, should be accessible in read only mode");
		assertTrue(role.isRecordAccess(X_C_Order.Table_ID, recordID, false), 
				"Record is included for read/write, should be accessible in read/write mode");
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, 100, false),
				"Record 108 is included, no other records should be accessible");
		assertFalse(role.isRecordAccess(X_C_Order.Table_ID, 100, true),
				"Record 108 is included, no other records should be accessible");
	}

	/** canUpdate **/
	@Test
	void testcanUpdate() {
		defaultRole.setUserLevel(MRole.USERLEVEL_System);
		boolean result = defaultRole.canUpdate(0, 0, CLIENT_ORGANIZATION_LEVEL_TABLE_ID, 0, false);
		assertTrue(result, "System-level access should allow updates.");
	}
	
    @Test
    void testCanUpdate_ClientLevelAccess() {
		defaultRole.setUserLevel(MRole.USERLEVEL_Client);

        boolean result = defaultRole.canUpdate(0, 0, CLIENT_LEVEL_TABLE_ID, 0, false);
        assertFalse(result, "Client-level should not allow updates for system tenant");
        
        result = defaultRole.canUpdate(defaultRole.getAD_Client_ID(), 0, CLIENT_LEVEL_TABLE_ID, 0, false);
        assertTrue(result, "Client-level should allow updates for client tenant and client table");
    }
    

    @Test
    void testCanUpdate_OrganizationLevelAccess() {
		defaultRole.setUserLevel(MRole.USERLEVEL_Organization);
        boolean result = defaultRole.canUpdate(0, 0, CLIENT_LEVEL_TABLE_ID, 0, false);
        assertFalse(result, "Organization-level access should not allow updates for system tenant");
        
        result = defaultRole.canUpdate(defaultRole.getAD_Client_ID(), 0, CLIENT_LEVEL_TABLE_ID, 0, false);
        assertFalse(result, "Organization-level should not allow updates for client tenant and client table");
        
        result = defaultRole.canUpdate(defaultRole.getAD_Client_ID(), 0, CLIENT_ORGANIZATION_LEVEL_TABLE_ID, 0, false);
        assertTrue(result, "Organization-level should allow updates for client tenant and client+org table");
        
        result = defaultRole.canUpdate(defaultRole.getAD_Client_ID(), GARDEN_WORLD_HQ_ORG, CLIENT_ORGANIZATION_LEVEL_TABLE_ID, 0, false);
        assertTrue(result, "Organization-level should allow updates for client tenant, org and client+org table");
        
        MRole role = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
		// GardenUser - Access All Orgs = N - only access to 4 Orgs
        result = role.canUpdate(role.getAD_Client_ID(), GARDEN_WORLD_HQ_ORG, CLIENT_ORGANIZATION_LEVEL_TABLE_ID, 0, false);
        assertTrue(result, "Organization-level should allow updates for client tenant, org and client+org table");
        
        result = role.canUpdate(role.getAD_Client_ID(), DictionaryIDs.AD_Org.STORE_EAST.id, CLIENT_ORGANIZATION_LEVEL_TABLE_ID, 0, false);
        assertFalse(result, "Organization-level should not allow updates for client tenant, org and client+org table when org is not accessible");
    }
    
    /** canView **/
    @Test
	public void testCanView_SystemOnly() {
		defaultRole.setUserLevel(MRole.USERLEVEL_System);

		assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_All), 
				"System level should have acess to all tables");

		assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemOnly), 
				"System level should have acess to System Only tables");

		assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientOnly), 
				"System level should NOT have acess to Client Only tables");

		assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_Organization),
				"System level should NOT have acess to Organization level tables");

		assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientPlusOrganization),
				"System level should NOT have acess to Client+Organization level tables");

		assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemPlusClient),
				"System level should have acess to System+Client level tables");
	}
    @Test
    public void testCanView_ClientOnly() {
        defaultRole.setUserLevel(MRole.USERLEVEL_Client);

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_All), 
                "Client level should have access to all tables");

        assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemOnly), 
                "Client level should NOT have access to System Only tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientOnly), 
                "Client level should have access to Client Only tables");

        assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_Organization), 
                "Client level should NOT have access to Organization level tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientPlusOrganization), 
                "Client level should have access to Client+Organization level tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemPlusClient), 
                "Client level should have access to System+Client level tables");
    }

    @Test
    public void testCanView_OrganizationOnly() {
        defaultRole.setUserLevel(MRole.USERLEVEL_Organization);

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_All), 
                "Organization level should have access to all tables");

        assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemOnly), 
                "Organization level should NOT have access to System Only tables");

        assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientOnly), 
                "Organization level should NOT have access to Client Only tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_Organization), 
                "Organization level should have access to Organization level tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientPlusOrganization), 
                "Organization level should have access to Client+Organization level tables");

        assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemPlusClient), 
                "Organization level should NOT have access to System+Client level tables");
    }

    @Test
    public void testCanView_ClientPlusOrganization() {
        defaultRole.setUserLevel(MRole.USERLEVEL_ClientPlusOrganization);

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_All), 
                "Client+Organization level should have access to all tables");

        assertFalse(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemOnly), 
                "Client+Organization level should NOT have access to System Only tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientOnly), 
                "Client+Organization level should have access to Client Only tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_Organization), 
                "Client+Organization level should have access to Organization level tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_ClientPlusOrganization), 
                "Client+Organization level should have access to Client+Organization level tables");

        assertTrue(defaultRole.canView(Env.getCtx(), X_AD_Table.ACCESSLEVEL_SystemPlusClient), 
                "Client+Organization level should have access to System+Client level tables");
    }

    /** getWhereRoleType **/
    @Test
    public void testGetWhereRoleType_WithValidRoleTypes() {
        String roleType = "Admin,User";
        String tableName = "AD_Role";
        String expected = "(AD_Role.RoleType IN ('Admin','User'))";

        String result = MRole.getWhereRoleType(roleType, tableName);
        assertEquals(expected, result);
    }

    @Test
    public void testGetWhereRoleType_WithNullRoleType() {
        String roleType = null;
        String tableName = "AD_Role";
        String result = MRole.getWhereRoleType(roleType, tableName);

        assertNull(result);
    }

    @Test
    public void testGetWhereRoleType_WithEmptyRoleType() {
        String roleType = "";
        String tableName = "AD_Role";

        String result = MRole.getWhereRoleType(roleType, tableName);
        assertNull(result);
    }

    @Test
    public void testGetWhereRoleType_WithIncludeNull() {
        String roleType = "Admin,null";
        String tableName = "AD_Role";
        String expected = "(AD_Role.RoleType IN ('Admin') OR AD_Role.RoleType IS NULL)";

        String result = MRole.getWhereRoleType(roleType, tableName);
        assertEquals(expected, result);
    }

    @Test
    public void testGetWhereRoleType_WithoutTableName() {
        String roleType = "Admin,User";
        String tableName = null;
        String expected = "(RoleType IN ('Admin','User'))";

        String result = MRole.getWhereRoleType(roleType, tableName);

        assertEquals(expected, result);
    }    

}