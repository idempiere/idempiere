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

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.compiere.model.MArchive;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MColumnAccess;
import org.compiere.model.MOrg;
import org.compiere.model.MProduct;
import org.compiere.model.MRecordAccess;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MTableAccess;
import org.compiere.model.MUser;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_AD_Alert;
import org.compiere.model.X_AD_Color;
import org.compiere.model.X_AD_PInstance_Log;
import org.compiere.model.X_AD_Table;
import org.compiere.model.X_AD_WizardProcess;
import org.compiere.model.X_A_Asset;
import org.compiere.model.X_A_Asset_Change;
import org.compiere.model.X_C_BankTransfer;
import org.compiere.model.X_C_Order;
import org.compiere.process.DocAction;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.DictionaryIDs.AD_Org;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Comprehensive JUnit 5 tests for {@link MRole}.
 */
@Isolated
public class MRoleTest extends AbstractTestCase {

	// Add static variables for table IDs
	private static final int CLIENT_LEVEL_TABLE_ID = X_AD_WizardProcess.Table_ID;
	private static final int ORGANIZATION_LEVEL_TABLE_ID = X_C_BankTransfer.Table_ID;
	private static final int CLIENT_ORGANIZATION_LEVEL_TABLE_ID = X_A_Asset.Table_ID;
	private static final int ALL_LEVEL_TABLE_ID = X_A_Asset_Change.Table_ID;
	private static final int SYSTEM_CLIENT_LEVEL_TABLE_ID = X_AD_Alert.Table_ID;
	private static final int SYSTEM_LEVEL_TABLE_ID = X_AD_Color.Table_ID;
	
	private static int ROLE_ID = DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id;
	private static String ROLE_UU;

	/**
	* Fetch static test data from the database.
	*/
	@BeforeAll
	public static void beforeAll()
	{
		ROLE_UU = DB.getSQLValueString(null, "SELECT AD_Role_UU FROM AD_Role WHERE AD_Role_ID=?", ROLE_ID);
	}
	
	@Test
	void testGetDefault() {
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
		
		// Different role than default role
		int originalRoleId = Env.getAD_Role_ID(Env.getCtx());
		try {
			Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id); // different role
			MRole role = MRole.getDefault(Env.getCtx(), false);
			assertEquals(DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, role.getAD_Role_ID());
		} finally {
			Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, originalRoleId); // restore
		}
		MRole role = MRole.getDefault(Env.getCtx(), false);
		assertEquals(originalRoleId, role.getAD_Role_ID());
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

		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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

		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
		assertFalse(defaultRole.isTableAccess(1234, false));
	}

	@Test
	public void testIsTableAccess_SystemOnly() {
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getBooleanValue(eq(MSysConfig.READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST), anyBoolean(), anyInt()))
				.thenReturn(false);
			assertFalse(role.isTableAccess(X_C_Order.Table_ID, false), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=N, One table is included, all the others should not be accessible for r/w");
			assertFalse(role.isTableAccess(X_C_Order.Table_ID, true), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=N, One table is included, all the others should not be accessible for read only too");
			assertFalse(role.isCanReport(X_C_Order.Table_ID), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=N, One table is included, all the others should not be accessible for reporting too");
			assertFalse(role.isCanExport(X_C_Order.Table_ID), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=N, One table is included, all the others should not be accessible for export too");
		}
		
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getBooleanValue(eq(MSysConfig.READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST), anyBoolean(), anyInt()))
				.thenReturn(true);
			assertFalse(role.isTableAccess(X_C_Order.Table_ID, false), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=Y, One table is included, all the others should not be accessible for r/w");
			assertTrue(role.isTableAccess(X_C_Order.Table_ID, true), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=Y, One table is included, all the others is accessible for read only");
			assertTrue(role.isCanReport(X_C_Order.Table_ID), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=Y, One table is included, all the others is accessible for reporting too");
			assertTrue(role.isCanExport(X_C_Order.Table_ID), "READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST=Y, One table is included, all the others is accessible for exporting too");
		}
	}

	/** Column Access **/
	@Test
	void testColumnAccess_CheckAccess() {
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
		assertTrue(defaultRole.isColumnAccess(X_AD_Color.Table_ID, 6230, true), 
				"System level columns should always be accessible in read only mode");
		assertFalse(defaultRole.isColumnAccess(X_AD_Color.Table_ID, 6230, false), 
				"System level columns should not be accessible in read write mode");
	}

	@Test
	void testColumnAccess_NoExistingColumn() {
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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

	/**
	 * Test cases for MRole.canUpdate(int, int, int, int, boolean)
	 */
	@Test
	void testCanUpdate() {
		MRole defaultRole = MRole.getDefault(); //GardenAdmin role
		defaultRole.setUserLevel(MRole.USERLEVEL_System);
		boolean result = defaultRole.canUpdate(0, 0, CLIENT_ORGANIZATION_LEVEL_TABLE_ID, 0, false);
		assertTrue(result, "System-level access should allow updates.");
		        
		// System-level table without System-level access
		defaultRole.setUserLevel(MRole.USERLEVEL_Client);
		result = defaultRole.canUpdate(0, 0, SYSTEM_LEVEL_TABLE_ID, 0, true);
		assertFalse(result, "Client-level access must not allow updates to System-level table");
		
		defaultRole.setUserLevel(MRole.USERLEVEL_ClientPlusOrganization);
		result = defaultRole.canUpdate(0, 0, SYSTEM_LEVEL_TABLE_ID, 0, true);
		assertFalse(result, "Client+Organization-level access must not allow updates to System-level table");
		
		defaultRole.setUserLevel(MRole.USERLEVEL_Organization);
		result = defaultRole.canUpdate(0, 0, SYSTEM_LEVEL_TABLE_ID, 0, true);
		assertFalse(result, "Organization-level access must not allow updates to System-level table");
		
		// Client-level table without Client-level access
		int clientId = Env.getAD_Client_ID(Env.getCtx());
		defaultRole.setUserLevel(MRole.USERLEVEL_Organization);
		result = defaultRole.canUpdate(clientId, 0, CLIENT_LEVEL_TABLE_ID, 0, true);
		assertFalse(result, "Organization-level access must not allow updates to Client-level table");
		
		// Client+Organization-level table without Client+Organization-level access
        int orgId = Env.getAD_Org_ID(Env.getCtx());
		defaultRole.setUserLevel(MRole.USERLEVEL_Client);
		result = defaultRole.canUpdate(clientId, orgId, CLIENT_ORGANIZATION_LEVEL_TABLE_ID, 0, true);
		assertFalse(result, "Client-level access must not allow updates to Client+Organization-level table");
		
		// Organization-level table without Organization-level access
		defaultRole.setUserLevel(MRole.USERLEVEL_Client);
		result = defaultRole.canUpdate(clientId, orgId, ORGANIZATION_LEVEL_TABLE_ID, 0, true);
		assertFalse(result, "Client-level access must not allow updates to Organization-level table");
		
		defaultRole.setUserLevel(MRole.USERLEVEL_ClientPlusOrganization);
		result = defaultRole.canUpdate(clientId, orgId, MUser.Table_ID, DictionaryIDs.AD_User.GARDEN_ADMIN.id, true);
		assertTrue(result, "Should allow updates to record with record access");		
	}
	
    @Test
    void testCanUpdate_ClientLevelAccess() {
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
		defaultRole.setUserLevel(MRole.USERLEVEL_Client);

        boolean result = defaultRole.canUpdate(0, 0, CLIENT_LEVEL_TABLE_ID, 0, false);
        assertFalse(result, "Client-level should not allow updates for system tenant");
        
        result = defaultRole.canUpdate(defaultRole.getAD_Client_ID(), 0, CLIENT_LEVEL_TABLE_ID, 0, false);
        assertTrue(result, "Client-level should allow updates for client tenant and client table");
    }
    

    @Test
    void testCanUpdate_OrganizationLevelAccess() {
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
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

    /**
     * Verify constructor using role ID correctly loads persistent data.
     */
    @Test
    public void testConstructorById()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    assertNotNull(role, "Role instance should not be null");
	    assertEquals(ROLE_ID, role.getAD_Role_ID(), "Role ID should match");
	    assertEquals(ROLE_UU, role.getAD_Role_UU(), "Role UUID should match");
    }
    
    /**
     * Verify constructor using role UUID correctly resolves the same role.
     */
    @Test
    public void testConstructorByUUID()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_UU, getTrxName());
	    assertNotNull(role, "Role instance should not be null when fetched by UUID");
	    assertEquals(ROLE_ID, role.getAD_Role_ID(), "Role ID should match when loaded by UUID");
	    
	    role = new MRole(Env.getCtx(), MRole.UUID_NEW_RECORD, getTrxName());
		assertNotNull(role, "Role instance should not be null");
		assertTrue(role.isCanExport());
		assertTrue(role.isCanReport());
		assertFalse(role.isManual());
		assertFalse(role.isPersonalAccess());
		assertFalse(role.isPersonalLock());
		assertFalse(role.isShowAcct());
		assertFalse(role.isAccessAllOrgs());
	    assertEquals(MRole.USERLEVEL_Organization, role.getUserLevel());
	    assertEquals(MRole.PREFERENCETYPE_Organization, role.getPreferenceType());
	    assertFalse(role.isChangeLog());
	    assertFalse(role.isOverwritePriceLimit());
	    assertFalse(role.isUseUserOrgAccess());
	    assertEquals(0, role.getMaxQueryRecords());
	    assertEquals(500, role.getConfirmQueryRecords());
	    role.setConfirmQueryRecords(300);
	    assertEquals(300, role.getConfirmQueryRecords());
    }
    
    /**
     * Verify that active flag is correctly exposed.
     */
    @Test
    public void testIsActive()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    assertTrue(role.isActive(), "GardenWorld Admin role should be active");
    }

    /**
     * Verify access level flags for GardenWorld Admin role.
     */
    @Test
    public void testAccessFlags()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    assertFalse(role.isAccessAllOrgs(), "GardenWorld Admin role should not have access to all organizations");
	    assertTrue(role.isAccessAdvanced(), "GardenWorld Admin role should have advanced access enabled");
    }
    
    /**
     * Verify that creating a role with invalid ID throws an exception or results in new record state.
     */
    @Test
    public void testInvalidConstructor()
    {
	    MRole role = new MRole(Env.getCtx(), -1, getTrxName());
	    assertNotNull(role, "Role instance should still be created for invalid ID");
	    assertTrue(role.getAD_Role_ID() <= 0, "Invalid ID should not map to existing role");
    }
    
    /**
     * Verify approval-related flags.
     */
    @Test
    public void testApprovalFlags()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    assertTrue(role.isCanApproveOwnDoc(), "GardenWorld Admin should be able to approve own documents");
    }
    
    /**
     * Verify role summary methods return consistent values.
     */
    @Test
    public void testSummaryAndName()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    assertNotNull(role.getName(), "Role name should not be null");
	    assertTrue(role.getName().length() > 0, "Role name should not be empty");
	    assertNotNull(role.toString(), "toString() should not return null");
    }
    
    /**
     * Verify process access check for a well-known process.
     */
    @Test
    public void testProcessAccess()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    boolean hasAccess = role.getProcessAccess(DictionaryIDs.AD_Process.CACHE_RESET.id);
	    assertTrue(hasAccess, "GardenWorld Admin should have access to Cache Reset process");
    }
    
    /**
     * Verify form access API for a standard form.
     */
    @Test
    public void testFormAccess()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    boolean hasAccess = role.getFormAccess(SystemIDs.FORM_ARCHIVEVIEWER);
	    assertTrue(hasAccess, "GardenWorld Admin should have access to Archive Viewer form");
    }
    
    /**
     * Verify workflow access API for a standard workflow.
     */
    @Test
    public void testWorkflowAccess()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    boolean hasAccess = role.getWorkflowAccess(DictionaryIDs.AD_Workflow.PROCESS_ORDER.id);
	    assertTrue(hasAccess, "GardenWorld Admin should have access to Order workflow");
    }
    
    /**
     * Verify that user organization access flag is enabled for system role.
     */
    @Test
    public void testUseUserOrgAccess()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    assertFalse(role.isUseUserOrgAccess(), "GardenWorld Admin should not use user/org access rules");
    }
    
    /**
     * Verify manual and master role flags if supported by the model.
     */
    @Test
    public void testManualAndMasterFlags()
    {
	    MRole role = new MRole(Env.getCtx(), ROLE_ID, getTrxName());
	    assertFalse(role.isManual(), "GardenWorld Admin should not be a manual role");
	    assertFalse(role.isMasterRole(), "GardenWorld Admin should not be a master role");
    }
    
    /**
     * Test cases for MRole.getOf(Properties, String)
     */
    @Test
    public void testGetOf() {
        // 1. Null whereClause
        MRole[] roles = MRole.getOf(Env.getCtx(), null);
        assertNotNull(roles, "Roles array should not be null");
        assertTrue(roles.length > 0, "There should be at least one role returned");

        // 2. Empty whereClause
        MRole[] rolesEmpty = MRole.getOf(Env.getCtx(), "");
        assertNotNull(rolesEmpty);
        assertTrue(rolesEmpty.length > 0, "Roles array should contain at least one element");

        // 3. Valid whereClause
        String whereActive = "IsActive='Y'";
        MRole[] activeRoles = MRole.getOf(Env.getCtx(), whereActive);
        assertNotNull(activeRoles);
        assertTrue(activeRoles.length > 0, "There should be active roles returned");
        for (MRole role : activeRoles) {
            assertTrue(role.isActive(), "All returned roles should be active");
        }

        // 4. WhereClause that yields no results
        String whereNoMatch = "Name='NonExistingRoleXYZ'";
        MRole[] noRoles = MRole.getOf(Env.getCtx(), whereNoMatch);
        assertNotNull(noRoles);
        assertEquals(0, noRoles.length, "No roles should be returned");

        // 5. Malformed whereClause (SQL error)
        String whereInvalid = "INVALID SQL SYNTAX";
        MRole[] invalidRoles = MRole.getOf(Env.getCtx(), whereInvalid);
        assertNotNull(invalidRoles);
        assertEquals(0, invalidRoles.length, "Invalid SQL should return empty array safely");
    }
    
    /**
     * Test cases for MRole.getOfClient(Properties, String) and MRole.getOfClient(Properties)
     */
    @Test
    public void testGetOfClient() throws Exception {    	
        // 1. Normal execution
    	MRole[][] rolesArray = new MRole[][] {
    		MRole.getOfClient(Env.getCtx(), getTrxName()),
    		MRole.getOfClient(Env.getCtx(), null),
    		MRole.getOfClient(Env.getCtx())
    	};
    	for (MRole[] roles : rolesArray) {
	        assertNotNull(roles, "Roles array should not be null");
	        assertTrue(roles.length > 0, "There should be at least one role for this client");
	        
	        // Check that each role belongs to the current client
	        int currentClientId = Env.getAD_Client_ID(Env.getCtx());
	        for (MRole role : roles) {
	            assertEquals(currentClientId, role.getAD_Client_ID(), "Role should belong to current client");
	        }
    	}

        // 2. No roles exist (simulate by temporarily setting context client to -1)
        int originalClientId = Env.getAD_Client_ID(Env.getCtx());
    	try {
	        Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, -1); // invalid client
	        rolesArray = new MRole[][] {
	    		MRole.getOfClient(Env.getCtx(), getTrxName()),
	    		MRole.getOfClient(Env.getCtx(), null),
	    		MRole.getOfClient(Env.getCtx())
	    	};
	    	for (MRole[] noRoles : rolesArray) {
		        assertNotNull(noRoles);
		        assertEquals(0, noRoles.length, "No roles should be returned for invalid client");
	    	}
    	} finally {
    		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, originalClientId); // restore
    	}

        // 3. Exception handling path
        // This is implicitly tested if DB.prepareStatement fails; we simulate by passing null ctx
	    rolesArray = new MRole[][] {
    		MRole.getOfClient(null, getTrxName()),
    		MRole.getOfClient(null, null),
    		MRole.getOfClient(null)
    	};
    	for (MRole[] rolesWithNullCtx : rolesArray) {
	        assertNotNull(rolesWithNullCtx, "Should handle null context safely");
	        assertTrue(rolesWithNullCtx.length == 0, "Should return empty array on exception");
    	}
    }
    
    /**
     * Test cases for MRole.getRoleKeyNamePairs()
     */
    @Test
	public void testGetRoleKeyNamePairs() {
		// 1. Normal execution
		KeyNamePair[] pairs = MRole.getRoleKeyNamePairs();
		assertNotNull(pairs, "Returned KeyNamePair array must not be null");
		assertTrue(pairs.length > 0, "There should be at least one active role");

		// Validate content
		for (KeyNamePair pair : pairs) {
			assertTrue(pair.getKey() > 0, "Role ID must be > 0");
			assertNotNull(pair.getName(), "Role name must not be null");
			assertTrue(pair.getName().length() > 0, "Role name must not be empty");
		}

		// 2. Client-context edge case
		int originalClientId = Env.getAD_Client_ID(Env.getCtx());
		try {
			Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, -1);
			KeyNamePair[] emptyPairs = MRole.getRoleKeyNamePairs();
			assertNotNull(emptyPairs, "Should safely return empty array for invalid client");
		} finally {
			Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, originalClientId);
		}
	}
    
    /**
     * Test cases for MRole(Properties, MRole, String), MRole(Properties, MRole) and MRole(MRole)
     */
    @Test
	public void testCopyConstructor() {
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
		MRole original = defaultRole;
		assertNotNull(original);

		// Copy constructor
		MRole[] copies = {
				new MRole(Env.getCtx(), original, getTrxName()),
				new MRole(Env.getCtx(), original),
				new MRole(original)
		};
		for (MRole copy : copies) {
			assertEquals(original.getName(), copy.getName());
			assertEquals(original.getDescription(), copy.getDescription());
			assertEquals(original.isActive(), copy.isActive());
			assertEquals(original.getAD_User_ID(), copy.getAD_User_ID());
			assertEquals(original.canAccess_Info_Product(), copy.canAccess_Info_Product());
		}
	}
    
    /**
     * Test cases for MRole.addAccessSQL(String, String, boolean, boolean)
     */
    @Test
	public void testAddAccessSQL() {
    	Properties ctx = Env.getCtx();
        String trxName = getTrxName();
        String uniqueSuffix = String.valueOf(System.currentTimeMillis());
        
        try {
            MRole role = new MRole(ctx, 0, trxName);
            role.setName("Role " + uniqueSuffix);
            role.setAD_Org_ID(0);
            role.setAD_User_ID(Env.getAD_User_ID(ctx));
            role.setIsManual(true);
            role.saveEx();
            
            MTableAccess tableAccess1 = new MTableAccess(ctx, 0, trxName);
            tableAccess1.setAD_Role_ID(role.get_ID());
            tableAccess1.setAD_Table_ID(MUser.Table_ID);
            tableAccess1.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
            tableAccess1.setIsExclude(false);
            tableAccess1.setIsReadOnly(false);
            tableAccess1.saveEx();
            
            MTableAccess tableAccess2 = new MTableAccess(ctx, 0, trxName);
            tableAccess2.setAD_Role_ID(role.get_ID());
            tableAccess2.setAD_Table_ID(X_AD_PInstance_Log.Table_ID);
            tableAccess2.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
            tableAccess2.setIsExclude(false);
            tableAccess2.setIsReadOnly(false);
            tableAccess2.saveEx();
            
            MTableAccess tableAccess3 = new MTableAccess(ctx, 0, trxName);
            tableAccess3.setAD_Role_ID(role.get_ID());
            tableAccess3.setAD_Table_ID(MArchive.Table_ID);
            tableAccess3.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
            tableAccess3.setIsExclude(true);
            tableAccess3.setIsReadOnly(false);
            tableAccess3.saveEx();
            
            MTableAccess tableAccess4 = new MTableAccess(ctx, 0, trxName);
            tableAccess4.setAD_Role_ID(role.get_ID());
            tableAccess4.setAD_Table_ID(MRole.Table_ID);
            tableAccess4.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
            tableAccess4.setIsExclude(false);
            tableAccess4.setIsReadOnly(false);
            tableAccess4.saveEx();
            
            MRecordAccess recAccess1 = new MRecordAccess(ctx, 0, trxName);
            recAccess1.setAD_Role_ID(role.get_ID());
            recAccess1.setAD_Table_ID(MUser.Table_ID);
            recAccess1.setRecord_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
            recAccess1.setIsExclude(false);
            recAccess1.setIsReadOnly(false);
            recAccess1.setIsDependentEntities(true);
            recAccess1.saveEx();

            MRecordAccess recAccess2 = new MRecordAccess(ctx, 0, trxName);
            recAccess2.setAD_Role_ID(role.get_ID());
            recAccess2.setAD_Table_ID(MRole.Table_ID);
            recAccess2.setRecord_ID(DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);
            recAccess2.setIsExclude(false);
            recAccess2.setIsReadOnly(true);
            recAccess2.setIsDependentEntities(true);
            recAccess2.saveEx();
            
            role.loadAccess(true);
	
			// 1. ORDER BY clause
	        String sqlOrderBy = "SELECT * FROM AD_User ORDER BY Name";
	        String result = role.addAccessSQL(sqlOrderBy, "AD_User", false, true);
	        assertTrue(result.contains("ORDER BY Name"));
	        assertTrue(result.contains("WHERE"));
	
	        // 2. WHERE already exists
	        String sqlWhere = "SELECT * FROM AD_User WHERE IsActive='Y'";
	        result = role.addAccessSQL(sqlWhere, "AD_User", false, true);
	        assertTrue(result.contains("AND"));
	
	        // 3. Fully qualified columns
	        String sqlFullyQualified = "SELECT * FROM AD_User";
	        result = role.addAccessSQL(sqlFullyQualified, "AD_User", true, true);
	        assertTrue(result.contains("AD_User.AD_Client_ID"));
	
	        // 4. Special table: X_AD_PInstance_Log
	        String sqlPInstance = "SELECT * FROM " + X_AD_PInstance_Log.Table_Name;
	        result = role.addAccessSQL(sqlPInstance, X_AD_PInstance_Log.Table_Name, false, true);
	        assertTrue(result.contains("1=1"));
	
	        // 5. Access denied
	        String sqlDenied = "SELECT * FROM AD_Archive"; // simulate denied access table
	        result = role.addAccessSQL(sqlDenied, "AD_Archive", false, false);
	        assertTrue(result.contains("1=3"));
	
	        // 6. View table skipped
	        String sqlView = "SELECT * FROM AD_User_v"; // view table
	        result = role.addAccessSQL(sqlView, "AD_User_v", false, true);
	        assertNotNull(result);
	        assertTrue(result.contains("WHERE"));
	
	        // 7. _TRL table skipped
	        String sqlTrl = "SELECT * FROM AD_User_TRL";
	        result = role.addAccessSQL(sqlTrl, "AD_User_TRL", false, true);
	        assertNotNull(result);
	        assertTrue(result.contains("WHERE"));
	
	        // 8. COUNT(*) SQL path
	        String sqlCount = "SELECT COUNT(*) FROM AD_User";
	        result = role.addAccessSQL(sqlCount, "AD_User", false, true);
	        assertTrue(result.startsWith("SELECT COUNT(*)"));
	
	        // 9. Read-only vs read-write
	        String sqlRO = "SELECT * FROM AD_User";
	        String roSQL = role.addAccessSQL(sqlRO, "AD_User", false, false);
	        String rwSQL = role.addAccessSQL(sqlRO, "AD_User", false, true);
	        assertNotEquals(roSQL, rwSQL);
	
	        // 10. Table name mismatch fallback
	        String sqlMismatch = "SELECT * FROM AD_User u";
	        result = role.addAccessSQL(sqlMismatch, "AD_User", false, true);
	        assertTrue(result.contains("AD_Client_ID"));
	
	        // 11. Multi-table SQL parsing
	        String sqlMulti = "SELECT * FROM AD_User u JOIN AD_Role r ON u.CreatedBy=r.CreatedBy";
	        result = role.addAccessSQL(sqlMulti, "AD_User", true, true);
	        assertTrue(result.contains("AD_User"));
	
	        // 12. Empty SQL / minimal SQL
	        result = role.addAccessSQL("SELECT 1", "AD_User", false, true);
	        assertTrue(result.contains("WHERE"));
	
	        // 13. Fully qualified + org access all orgs
	        result = role.addAccessSQL("SELECT * FROM AD_User", "AD_User", true, true);
	        assertTrue(result.contains("AD_User.AD_Client_ID"));
        } finally {
        	rollback();
        }
	}
    
    /**
     * Test cases for MRole.beforeSave(boolean), MRole.afterSave(boolean, boolean) and MRole.afterDelete(boolean)
     */
    @Test
	public void testSaveAndDelete() {
    	MRole defaultRole = MRole.getDefault(); //GardenAdmin role
    	MSysConfig config = null;
    	try {
			// 1. Default role should always pass
			assertTrue(defaultRole.save(), "Default role should pass");
	
			// 2. Non-system client with System user level should fail
			MRole invalidSystemRole = new MRole(Env.getCtx(), 0, getTrxName());
			invalidSystemRole.setName("InvalidSystemRole");
			invalidSystemRole.setUserLevel(MRole.USERLEVEL_System);
			assertFalse(invalidSystemRole.save(), "Client role must not allow System user level");
	
			// 3. Empty user level should fail
			MRole emptyUserLevelRole = new MRole(Env.getCtx(), 0, getTrxName());
			emptyUserLevelRole.setName("EmptyUserLevelRole");
			emptyUserLevelRole.setUserLevel("   ");
			assertFalse(emptyUserLevelRole.save(), "Empty user level must fail validation");
			
			// 4. Null user level should fail
			MRole nullUserLevelRole = new MRole(Env.getCtx(), 0, getTrxName());
			nullUserLevelRole.setName("NullUserLevelRole");
			nullUserLevelRole.setUserLevel(null);
			assertFalse(nullUserLevelRole.save(), "Null user level must fail validation");
	
			// 5. Valid non-system user level should pass
			MRole validClientRole = new MRole(Env.getCtx(), 0, getTrxName());
			validClientRole.setName("ValidClientRole");
			validClientRole.setUserLevel(MRole.USERLEVEL_Client);
			assertTrue(validClientRole.save(), "Valid client user level should pass");
			assertTrue(validClientRole.delete(false, getTrxName()), "delete should return true");			
			
			// 6. Valid master role should pass
			MRole validMasterRole = new MRole(Env.getCtx(), 0, getTrxName());
			validMasterRole.setName("ValidMasterRole");
			validMasterRole.setUserLevel(null);
			validMasterRole.setIsMasterRole(true);
			assertTrue(validMasterRole.save(), "Valid master role should pass");			
			assertTrue(validMasterRole.delete(false, getTrxName()), "delete should return true");
			
			// 7. Test afterSave(boolean, boolean)
			// auto assign role to creator user
			config = new MSysConfig(Env.getCtx(), 0, getTrxName());
			config.setName(MSysConfig.AUTO_ASSIGN_ROLE_TO_CREATOR_USER);
			config.setValue("Y");
			config.setAD_Org_ID(0);
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
			
			MRole role = new MRole(Env.getCtx(), 0, getTrxName());
			role.setName("Test Role");
			role.setUserLevel(MRole.USERLEVEL_Client);
			assertTrue(role.save(), "save should return true");
			assertTrue(role.delete(false, getTrxName()), "delete should return true");
			
			// update user level
			MRole.setCrossTenantSafe();
			role.setUserLevel(MRole.USERLEVEL_ClientPlusOrganization);
			assertTrue(role.save(), "Valid client user level should pass");
    	} finally {
    		MRole.clearCrossTenantSafe();
    		rollback();
    		
    		if (config != null && config.get_ID() > 0)
    			config.deleteEx(true, null);
    	}
	}
    
    /**
     * Test cases for MRole.checkAccessSQL(MTable, int, String, boolean)
     */
    @Test
    public void testCheckAccessSQL() {
    	MRole role = MRole.getDefault();
    	MTable table = MTable.get(Env.getCtx(), MRole.Table_ID);
    	
        // 1. UUID path (non-empty UUID)
        assertDoesNotThrow(() -> role.checkAccessSQL(table, ROLE_ID, ROLE_UU, true));
        
        // 2. RecordId path (empty UUID)
        assertDoesNotThrow(() -> role.checkAccessSQL(table, ROLE_ID, "", true));

        // 3. Null UUID path
        assertDoesNotThrow(() -> role.checkAccessSQL(table, ROLE_ID, null, false));
    }
    
    /**
     * Test cases for MRole.checkActionAccessint, int, String[], int)
     */
    @Test
    public void testCheckActionAccess() {
    	MRole role = MRole.getDefault();
    	
        // 1. maxIndex <= 0
    	int docTypeId = DictionaryIDs.C_DocType.STANDARD_ORDER.id;
        String[] options = new String[] { DocAction.ACTION_Prepare, DocAction.ACTION_Complete };
        int result0 = role.checkActionAccess(Env.getAD_Client_ID(Env.getCtx()), docTypeId, options, 0);
        assertEquals(0, result0, "maxIndex <= 0 should return immediately");

        // 2. normal check for tenant role
        int maxIndex = options.length;
        int result = role.checkActionAccess(Env.getAD_Client_ID(Env.getCtx()), docTypeId, options, maxIndex);
        assertTrue(result >= 0 && result <= maxIndex, "Returned index must be valid");
        
        // 3. normal check for system/master role
        try {
        	MRole.setCrossTenantSafe();
            String uniqueSuffix = String.valueOf(System.currentTimeMillis());
            role = new MRole(Env.getCtx(), MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id), getTrxName());
            role.setName("Role " + uniqueSuffix);
            role.setIsMasterRole(true);
            role.saveEx();
            
            result = role.checkActionAccess(0, 0, options, maxIndex);
            assertTrue(result >= 0 && result <= maxIndex, "Returned index must be valid");
        } finally {
        	rollback();
        	MRole.clearCrossTenantSafe();
        }
    }
    
    /**
     * Test cases for MRole.getIncludedRolesWhereClause(String, List<Object>)
     */
    @Test
    public void testGetIncludedRolesWhereClause() {
    	MRole role = MRole.getDefault();
        String columnSQL = "AD_Role_ID";

        // 1. params == null (literal role IDs)
        String whereLiteral = role.getIncludedRolesWhereClause(columnSQL, null);
        assertNotNull(whereLiteral, "Where clause string must not be null");
        assertTrue(whereLiteral.startsWith(columnSQL + " IN ("), "Where clause must start with column IN (");
        assertTrue(whereLiteral.contains(String.valueOf(role.getAD_Role_ID())), "Where clause must include current role ID");

        // 2. params != null (role IDs as query parameters)
        List<Object> params = new ArrayList<>();
        String whereParams = role.getIncludedRolesWhereClause(columnSQL, params);
        assertNotNull(whereParams, "Where clause string must not be null");
        assertTrue(whereParams.startsWith(columnSQL + " IN ("), "Where clause must start with column IN (");
        assertTrue(whereParams.contains("?"), "Where clause must contain placeholders for params");
        assertFalse(params.isEmpty(), "Params list must contain role IDs");
        assertTrue(params.contains(role.getAD_Role_ID()), "Params list must include current role ID");

        // 3. Ensure included roles are reflected
        // Included roles are dynamically retrieved; check that their IDs appear
        List<MRole> includedRoles = role.getIncludedRoles(true);
        for (MRole r : includedRoles) {
        	assertTrue(params.contains(r.getAD_Role_ID()), "Params must include included role ID " + r.getAD_Role_ID());
        }
    }
    
    /**
     * Test cases for MRole.getInfoAccess(int)
     */
    @Test
    public void testGetInfoAccess() {
    	MRole role = MRole.getDefault();
    	
    	int infoWindowId = DictionaryIDs.AD_InfoWindow.PRODUCT_INFO.id;
        // 1. Initial call (m_infoAccess == null) should initialize map
        Boolean access1 = role.getInfoAccess(infoWindowId);
        assertTrue(access1, "Return value must be true");

        // 2. Second call (m_infoAccess already initialized)
        Boolean access2 = role.getInfoAccess(infoWindowId);
        assertEquals(access1, access2, "Subsequent calls should return same cached value");

        // 3. Call with non-existing InfoWindow ID
        Boolean accessInvalid = role.getInfoAccess(-9999);
        assertNull(accessInvalid, "Non-existing InfoWindow ID must return null");
    }
    
    /**
     * Test cases for MRole.getPredefinedContextVariables()
     */
    @Test
    public void testGetPredefinedContextVariables() {
    	MRole role = MRole.getDefault();
        List<MRole> includedRoles = role.getIncludedRoles(false);
    	
        // 1. Included roles have no variables, current role has no variable
        role.setPredefinedContextVariables(null);
        String resultEmpty = role.getPredefinedContextVariables();
        assertNotNull(resultEmpty, "Result string must not be null");
        assertEquals("", resultEmpty, "No variables should result in empty string");

        // 2. Current role has a variable, included roles empty
        role.setPredefinedContextVariables("CURRENT_VAR=1");
        String resultCurrentOnly = role.getPredefinedContextVariables();
        assertEquals("CURRENT_VAR=1", resultCurrentOnly, "Should return current role variable");
        
        // 3. Included roles have variables, current role empty
        for (MRole included : includedRoles) {
            included.set_Value("PredefinedContextVariables", "INCLUDED_VAR=" + included.getAD_Role_ID());
        }
        role.setPredefinedContextVariables(null);
        String resultIncludedOnly = role.getPredefinedContextVariables();
        for (MRole included : includedRoles) {
            assertTrue(resultIncludedOnly.contains("INCLUDED_VAR=" + included.getAD_Role_ID()), "Result must include included role variable");
        }

        // 4. Both included roles and current role have variables
        role.setPredefinedContextVariables("CURRENT_VAR=1");
        String resultAll = role.getPredefinedContextVariables();
        assertTrue(resultAll.contains("CURRENT_VAR=1"), "Result must contain current role variable");
        for (MRole included : includedRoles) {
            assertTrue(resultAll.contains("INCLUDED_VAR=" + included.getAD_Role_ID()), "Result must contain included role variable");
        }
        if (!includedRoles.isEmpty()) {
        	assertTrue(resultAll.contains("\n"), "Variables should be separated by newline");
        }
    }
    
    /**
     * Test cases for MRole.getTaskAccess(int)
     */
    @Test
    public void testGetTaskAccess() {
    	MRole role = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id);
    	int taskId = DictionaryIDs.AD_Task.JAVA_VERSION.id;
    	
    	// 1. Initial call (m_taskAccess == null) should initialize map
        Boolean access1 = role.getTaskAccess(taskId);
        assertNotNull(access1, "Return value must not be null");
        assertTrue(access1, "Return value must be true");

        // 2. Subsequent call (m_taskAccess already initialized)
        Boolean access2 = role.getTaskAccess(taskId);
        assertEquals(access1, access2, "Subsequent calls should return same cached value");

        // 3. Non-existing task ID should return null
        Boolean accessInvalid = role.getTaskAccess(-9999);
        assertNull(accessInvalid, "Non-existing task ID must return null");

        // 4. Check read-only session behavior
        try {
	        Env.setContext(Env.getCtx(), "IsReadOnlySession", true);
	        Boolean accessReadOnly = role.getTaskAccess(taskId);
	        if (access1 != null && access1) {
	            assertEquals(Boolean.FALSE, accessReadOnly, "Read-only session forces access to FALSE");
	        }
        } finally {
        	Env.setContext(Env.getCtx(), "IsReadOnlySession", false);
        }
    }
    
    /**
     * Test cases for MRole.getWindowAccess(int)
     */
    @Test
    public void testGetWindowAccess() {
    	MRole role = MRole.getDefault();
    	int windowId = DictionaryIDs.AD_Window.USER.id;
    	
        // 1. Initial call (m_windowAccess == null) should initialize map
        Boolean access1 = role.getWindowAccess(windowId);
        assertNotNull(access1, "Return value must not be null");
        assertTrue(access1, "Return value must be true");

        // 2. Subsequent call (m_windowAccess already initialized)
        Boolean access2 = role.getWindowAccess(windowId);
        assertEquals(access1, access2, "Subsequent calls should return same cached value");

        // 3. Non-existing window ID should return null
        Boolean accessInvalid = role.getWindowAccess(-9999);
        assertNull(accessInvalid, "Non-existing window ID must return null");

        try {
	        Env.setContext(Env.getCtx(), "IsReadOnlySession", true);
	        
            // 4. Read-only session overrides access
	        Boolean accessReadOnly = role.getWindowAccess(windowId);
	        if (access1 != null) {
	            assertEquals(Boolean.FALSE, accessReadOnly, "Read-only session forces access to FALSE");
	        }
	
	        // 5. User Preference window bypass
	        Boolean userPrefAccess = role.getWindowAccess(SystemIDs.WINDOW_USER_PREFERENCE);
	        assertNotNull(userPrefAccess, "User Preference window access should not be forced FALSE in read-only session");
        } finally {
        	Env.setContext(Env.getCtx(), "IsReadOnlySession", false);
        }
    }
    
    /**
     * Test cases for MRole.isCanExport(int)
     */
    @Test
    public void testIsCanExport() {
        // 1. Role-level deny
        MRole roleDeny = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.WEB_SERVICE_EXECUTION.id);
        assertFalse(roleDeny.isCanExport(MUser.Table_ID), "Role-level deny should return false");

        // 2. Table-level deny 
        MRole roleTableDeny = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
        MTable table = MTable.get(Env.getCtx(), "RV_BPartner");
        assertFalse(roleTableDeny.isCanExport(table.get_ID()), "Table-level deny should return false");
    }
    
    /**
     * Test cases for MRole.isCanReport(int)
     */
    @Test
    public void testIsCanReport() {
    	MRole roleDeny = MRole.get(Env.getCtx(), DictionaryIDs.AD_Role.WEB_SERVICE_EXECUTION.id);
        assertFalse(roleDeny.isCanReport(MUser.Table_ID), "Role-level deny should return false");
    }

    /**
     * Test cases for MRole.isShowPreference()
     */
    @Test
    public void testIsShowPreference() {
        MRole role = new MRole(Env.getCtx(), 0, getTrxName());

        // PreferenceType = None
        role.setPreferenceType(MRole.PREFERENCETYPE_None);
        assertFalse(role.isShowPreference(), "PreferenceType=None should return false");

        // PreferenceType = User
        role.setPreferenceType(MRole.PREFERENCETYPE_User);
        assertTrue(role.isShowPreference(), "PreferenceType=User should return true");

        // PreferenceType = Client
        role.setPreferenceType(MRole.PREFERENCETYPE_Client);
        assertTrue(role.isShowPreference(), "PreferenceType=Client should return true");

        // PreferenceType = Organization
        role.setPreferenceType(MRole.PREFERENCETYPE_Organization);
        assertTrue(role.isShowPreference(), "PreferenceType=Organization should return true");
    }
    
    /**
     * Test cases for MRole.isTableAccessExcluded(int)
     */
    @Test
    public void testIsTableAccessExcluded() throws Exception {
        final int TABLE_ID = 123;
        MRole role = new MRole(Env.getCtx(), 0, getTrxName());

        // Build table access entries
        MTableAccess excludeAccess = new MTableAccess(Env.getCtx(), 0, getTrxName());
        excludeAccess.setAD_Table_ID(TABLE_ID);
        excludeAccess.setIsExclude(true);
        excludeAccess.setIsReadOnly(false);
        excludeAccess.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);

        MTableAccess includeAccess = new MTableAccess(Env.getCtx(), 0, getTrxName());
        includeAccess.setAD_Table_ID(TABLE_ID);
        includeAccess.setIsExclude(false);
        includeAccess.setIsReadOnly(false);
        includeAccess.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);

        MTableAccess readOnlyExclude = new MTableAccess(Env.getCtx(), 0, getTrxName());
        readOnlyExclude.setAD_Table_ID(TABLE_ID);
        readOnlyExclude.setIsExclude(true);
        readOnlyExclude.setIsReadOnly(true);
        readOnlyExclude.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);

        MTableAccess wrongRuleExclude = new MTableAccess(Env.getCtx(), 0, getTrxName());
        wrongRuleExclude.setAD_Table_ID(TABLE_ID);
        wrongRuleExclude.setIsExclude(true);
        wrongRuleExclude.setIsReadOnly(false);
        wrongRuleExclude.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Reporting);

        MTableAccess otherTableExclude = new MTableAccess(Env.getCtx(), 0, getTrxName());
        otherTableExclude.setAD_Table_ID(999);
        otherTableExclude.setIsExclude(true);
        otherTableExclude.setIsReadOnly(false);
        otherTableExclude.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);

        // Inject m_tableAccess via reflection
        Field field = MRole.class.getDeclaredField("m_tableAccess");
        field.setAccessible(true);

        // 1. Exact matching exclude
        field.set(role, new MTableAccess[] { excludeAccess });
        assertTrue(role.isTableAccessExcluded(TABLE_ID), "Exclude + Accessing + not read-only should return true");

        // 2. Include rule
        field.set(role, new MTableAccess[] { includeAccess });
        assertFalse(role.isTableAccessExcluded(TABLE_ID), "Include rule should not be treated as excluded");

        // 3. Read-only exclusion
        field.set(role, new MTableAccess[] { readOnlyExclude });
        assertFalse(role.isTableAccessExcluded(TABLE_ID), "Read-only exclusion should not be treated as excluded");

        // 4. Wrong access rule
        field.set(role, new MTableAccess[] { wrongRuleExclude });
        assertFalse(role.isTableAccessExcluded(TABLE_ID), "Non-Accessing rule should not be treated as excluded");

        // 5. Different table ID
        field.set(role, new MTableAccess[] { otherTableExclude });
        assertFalse(role.isTableAccessExcluded(TABLE_ID), "Different table ID should not be treated as excluded");

        // 6. Empty access list
        field.set(role, new MTableAccess[0]);
        assertFalse(role.isTableAccessExcluded(TABLE_ID), "Empty table access list should return false");
    }
    
    /**
     * Test cases for MRole.markImmutable()
     */
    @Test
    public void testMarkImmutable() {
        MRole role = new MRole(Env.getCtx(), 0, getTrxName());
        assertFalse(role.is_Immutable(), "New role should not be immutable");

        // First call should mark immutable
        MRole returned = role.markImmutable();
        assertSame(role, returned, "markImmutable must return the same instance");
        assertTrue(role.is_Immutable(), "Role should be immutable after markImmutable");

        // Second call should be a no-op
        MRole returnedAgain = role.markImmutable();
        assertSame(role, returnedAgain, "Calling markImmutable again must return same instance");
        assertTrue(role.is_Immutable(), "Role must remain immutable");
    }
    
    /**
     * Test cases for MRole.toStringX(Properties)
     */
    @Test
    public void testToStringX() throws Exception {
    	Properties ctx = Env.getCtx();
        String trxName = getTrxName();
        String uniqueSuffix = String.valueOf(System.currentTimeMillis());
        try {
        	// 1. Create role
            MRole role = new MRole(ctx, 0, trxName);
            role.setName("Role " + uniqueSuffix);
            role.setAD_Org_ID(0);
            role.setAD_User_ID(Env.getAD_User_ID(ctx));
            role.setIsManual(true);
            role.saveEx();

            // 2. Table access
            // Include for table1
            MTableAccess tableAccess1 = new MTableAccess(ctx, 0, trxName);
            tableAccess1.setAD_Role_ID(role.get_ID());
            tableAccess1.setAD_Table_ID(MUser.Table_ID);
            tableAccess1.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
            tableAccess1.setIsExclude(false);
            tableAccess1.setIsReadOnly(false);
            tableAccess1.saveEx();
            
            // Include for table2
            MTableAccess tableAccess2 = new MTableAccess(ctx, 0, trxName);
            tableAccess2.setAD_Role_ID(role.get_ID());
            tableAccess2.setAD_Table_ID(MBPartner.Table_ID);
            tableAccess2.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
            tableAccess2.setIsExclude(false);
            tableAccess2.setIsReadOnly(false);
            tableAccess2.saveEx();

            // Exclude for table3
            MTableAccess tableAccess3 = new MTableAccess(ctx, 0, trxName);
            tableAccess3.setAD_Role_ID(role.get_ID());
            tableAccess3.setAD_Table_ID(MProduct.Table_ID);
            tableAccess3.setAccessTypeRule(MTableAccess.ACCESSTYPERULE_Accessing);
            tableAccess3.setIsExclude(false);
            tableAccess3.setIsReadOnly(true);
            tableAccess3.saveEx();

            // 3. Column access
            MColumn col1 = MColumn.get(ctx, MUser.Table_Name, MUser.COLUMNNAME_Name);
            MColumn col2 = MColumn.get(ctx, MBPartner.Table_Name, MBPartner.COLUMNNAME_Value);

            MColumnAccess colAccess1 = new MColumnAccess(ctx, 0, trxName);
            colAccess1.setAD_Role_ID(role.get_ID());   
            colAccess1.setAD_Table_ID(col1.getAD_Table_ID());
            colAccess1.setAD_Column_ID(col1.get_ID());
            colAccess1.setIsExclude(false);
            colAccess1.setIsReadOnly(false);
            colAccess1.saveEx();

            MColumnAccess colAccess2 = new MColumnAccess(ctx, 0, trxName);
            colAccess2.setAD_Role_ID(role.get_ID());   
            colAccess2.setAD_Table_ID(col2.getAD_Table_ID());
            colAccess2.setAD_Column_ID(col2.get_ID());
            colAccess2.setIsExclude(false);
            colAccess2.setIsReadOnly(true);
            colAccess2.saveEx();

            // 4. Record access
            MRecordAccess recAccess1 = new MRecordAccess(ctx, 0, trxName);
            recAccess1.setAD_Role_ID(role.get_ID());
            recAccess1.setAD_Table_ID(MUser.Table_ID);
            recAccess1.setRecord_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
            recAccess1.setIsExclude(false);
            recAccess1.setIsReadOnly(false);
            recAccess1.saveEx();

            MRecordAccess recAccess2 = new MRecordAccess(ctx, 0, trxName);
            recAccess2.setAD_Role_ID(role.get_ID());
            recAccess2.setAD_Table_ID(MBPartner.Table_ID);
            recAccess2.setRecord_ID(DictionaryIDs.C_BPartner.PATIO.id);
            recAccess2.setIsExclude(false);
            recAccess2.setIsReadOnly(true);
            recAccess2.saveEx();

            // 5. Dependent record access
            MRecordAccess depAccess1 = new MRecordAccess(ctx, 0, trxName);
            depAccess1.setAD_Role_ID(role.get_ID());
            depAccess1.setAD_Table_ID(MUser.Table_ID);
            depAccess1.setRecord_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
            depAccess1.setIsExclude(false);
            depAccess1.setIsReadOnly(false);
            depAccess1.setIsDependentEntities(true);
            depAccess1.saveEx();

            MRecordAccess depAccess2 = new MRecordAccess(ctx, 0, trxName);
            depAccess2.setAD_Role_ID(role.get_ID());
            depAccess2.setAD_Table_ID(MBPartner.Table_ID);
            depAccess2.setRecord_ID(DictionaryIDs.C_BPartner.GARDEN_USER.id);
            depAccess2.setIsExclude(false);
            depAccess2.setIsReadOnly(true);
            depAccess2.setIsDependentEntities(true);
            depAccess2.saveEx();
    	        
            // 6. Assertions
            role.loadAccess(true);

            // Table access
            assertTrue(role.isTableAccess(MUser.Table_ID, false));
            assertTrue(role.isTableAccess(MBPartner.Table_ID, false));
            assertFalse(role.isTableAccess(MProduct.Table_ID, false));

            // Column access
            assertTrue(role.isColumnAccess(col1.getAD_Table_ID(), col1.getAD_Column_ID(), false));
            assertFalse(role.isColumnAccess(col2.getAD_Table_ID(), col2.getAD_Column_ID(), false));

            // Record access
            assertTrue(role.isRecordAccess(recAccess1.getAD_Table_ID(), recAccess1.getRecord_ID(), false));
            assertFalse(role.isRecordAccess(recAccess2.getAD_Table_ID(), recAccess2.getRecord_ID(), false));

            // Dependent record access
            assertTrue(role.isRecordAccess(depAccess1.getAD_Table_ID(), depAccess1.getRecord_ID(), false));
            assertFalse(role.isRecordAccess(depAccess2.getAD_Table_ID(), depAccess2.getRecord_ID(), false));
            
        	String result = role.toStringX(Env.getCtx());
            assertNotNull(result, "toStringX must never return null");
            assertFalse(result.isEmpty(), "toStringX must not return empty string");
            assertTrue(result.contains(Env.NL), "Output should contain line separators");
        } finally {
        	rollback();
        }
    }
    
    /**
     * Test cases for all MRole.OrgAccess methods
     * @throws Exception
     */
    @Test
    public void testAllOrgAccessMethods() throws Exception {
    	int clientId = Env.getAD_Client_ID(Env.getCtx());
        int orgId = Env.getAD_Org_ID(Env.getCtx());
        
        MRole role = new MRole(Env.getCtx(), 0, getTrxName());

        // --- Load inner class ---
        Class<?> orgAccessClass = Class.forName("org.compiere.model.MRole$OrgAccess");

        // --- Constructor: (MRole role, int AD_Client_ID, int AD_Org_ID, boolean readonly) ---
        Constructor<?> ctor = orgAccessClass.getDeclaredConstructor(MRole.class, int.class, int.class, boolean.class);
        ctor.setAccessible(true);

        Object rwAccess = ctor.newInstance(role, clientId, orgId, false);
        Object roAccess = ctor.newInstance(role, clientId, orgId, true);
        Object differentOrg = ctor.newInstance(role, clientId, 99, false);

        // --- hashCode ---
        Method hashCodeMethod = orgAccessClass.getMethod("hashCode");
        hashCodeMethod.setAccessible(true);
        int hash1 = (Integer) hashCodeMethod.invoke(rwAccess);
        int hash2 = (Integer) hashCodeMethod.invoke(roAccess);
        assertEquals(hash1, hash2, "hashCode must ignore readonly flag");

        // --- equals ---
        Method equalsMethod = orgAccessClass.getMethod("equals", Object.class);
        equalsMethod.setAccessible(true);
        assertTrue((Boolean) equalsMethod.invoke(rwAccess, roAccess), "Same client/org must be equal regardless of readonly");
        assertFalse((Boolean) equalsMethod.invoke(rwAccess, differentOrg), "Different org must not be equal");
        assertFalse((Boolean) equalsMethod.invoke(rwAccess, (Object) null), "Must not be equal to null");

        // --- HashSet contract ---
        Set<Object> set = new HashSet<>();
        set.add(rwAccess);
        set.add(roAccess);       // duplicate
        set.add(differentOrg);  // unique
        assertEquals(2, set.size(), "HashSet must honor equals/hashCode");

        // --- toString ---
        Method toStringMethod = orgAccessClass.getMethod("toString");
        toStringMethod.setAccessible(true);
        String text = (String) toStringMethod.invoke(rwAccess);
        assertNotNull(text);
        String clientName = "System";
        if (clientId != 0)
        	clientName = MClient.get(Env.getCtx(), clientId).getName();
        String orgName = "*";
        if (orgId != 0)
        	orgName = MOrg.get(orgId).getName();
    	assertTrue(text.contains(clientName), "toString must contain client name");
        assertTrue(text.contains(orgName), "toString must contain org name");

        // --- deterministic toString ---
        assertEquals(text, toStringMethod.invoke(rwAccess));
    }
    
    /**
     * Test cases for MRole.getDefaultRole()
     * @throws Exception
     */
    @Test
    public void testGetDefaultRole() throws Exception {
        // Access private static method via reflection
        Method method = MRole.class.getDeclaredMethod("getDefaultRole");
        method.setAccessible(true); // allow access to private

        // Invoke the method (static: pass null as the instance)
        MRole defaultRole = (MRole) method.invoke(null);

        // Assertions
        assertNotNull(defaultRole, "Default role should not be null");
        assertEquals(Env.getAD_Role_ID(Env.getCtx()), defaultRole.getAD_Role_ID(), "Default role ID should match Env.getAD_Role_ID()");
    }
    
    /**
     * Test cases for MRole.mergeAccess(T[], T[], boolean)
     * @throws Exception
     */
    @Test
    public void testMergeAccess() throws Exception {
    	Properties ctx = Env.getCtx();
        String trxName = getTrxName();
        MRole role = new MRole(ctx, 0, trxName);

        // OrgAccess
        Class<?> orgAccessClass = Class.forName("org.compiere.model.MRole$OrgAccess");
        Constructor<?> ctor = orgAccessClass.getDeclaredConstructor(MRole.class, int.class, int.class, boolean.class);
        ctor.setAccessible(true);
        
        Object oa1 = ctor.newInstance(role, 1, 10, true);
        Object oa2 = ctor.newInstance(role, 1, 10, false); // will override
        Object oa3 = ctor.newInstance(role, 2, 20, true);  // new

        Object[] orgArray1 = new Object[]{oa1};
        Object[] orgArray2 = new Object[]{oa2, oa3};

        // TableAccess      
        MTableAccess ta1 = new MTableAccess(ctx, 0, trxName);
        ta1.setIsExclude(true);
        MTableAccess ta2 = new MTableAccess(ctx, 0, trxName);
        ta2.setIsExclude(false);

        MTableAccess[] tableArray1 = new MTableAccess[]{ta1};
        MTableAccess[] tableArray2 = new MTableAccess[]{ta2};

        // ColumnAccess
        MColumnAccess ca1 = new MColumnAccess(ctx, 0, trxName);
        ca1.setIsReadOnly(true);
        ca1.setIsExclude(true);

        MColumnAccess ca2 = new MColumnAccess(ctx, 0, trxName);
        ca2.setIsReadOnly(false);
        ca2.setIsExclude(false);

        MColumnAccess[] colArray1 = new MColumnAccess[]{ca1};
        MColumnAccess[] colArray2 = new MColumnAccess[]{ca2};

        // RecordAccess
        MRecordAccess ra1 = new MRecordAccess(ctx, 0, trxName);
        ra1.setIsReadOnly(true);
        ra1.setIsDependentEntities(true);
        ra1.setIsExclude(true);

        MRecordAccess ra2 = new MRecordAccess(ctx, 0, trxName);
        ra2.setIsReadOnly(false);
        ra2.setIsDependentEntities(false);
        ra2.setIsExclude(false);

        MRecordAccess[] recArray1 = new MRecordAccess[]{ra1};
        MRecordAccess[] recArray2 = new MRecordAccess[]{ra2};

        Method mergeAccess = MRole.class.getDeclaredMethod("mergeAccess", Object[].class, Object[].class, boolean.class);
        mergeAccess.setAccessible(true);

        // OrgAccess
        Object[] orgResult = (Object[]) mergeAccess.invoke(null, (Object) orgArray1, (Object) orgArray2, true);
        assertEquals(2, orgResult.length);

        // MTableAccess
        MTableAccess[] tableResult = (MTableAccess[]) mergeAccess.invoke(null, (Object) tableArray1, (Object) tableArray2, true);
        assertFalse(tableResult[0].isExclude());

        // MColumnAccess
        MColumnAccess[] colResult = (MColumnAccess[]) mergeAccess.invoke(null, (Object) colArray1, (Object) colArray2, true);
        assertFalse(colResult[0].isReadOnly());
        assertFalse(colResult[0].isExclude());

        // MRecordAccess
        MRecordAccess[] recResult = (MRecordAccess[]) mergeAccess.invoke(null, (Object) recArray1, (Object) recArray2, true);
        assertFalse(recResult[0].isReadOnly());
        assertFalse(recResult[0].isDependentEntities());
        assertFalse(recResult[0].isExclude());
    }
    
    /**
     * Test cases for MRole.getDependentAccess(String, ArrayList<Integer>, ArrayList<Integer>)
     * @throws Exception
     */
    @Test
    void testGetDependentAccess() throws Exception {
        MRole role = new MRole(Env.getCtx(), 0, getTrxName());
        Method method = MRole.class.getDeclaredMethod("getDependentAccess", String.class, ArrayList.class, ArrayList.class);
        method.setAccessible(true);
        String col = "AD_Org_ID";

        // 1. includes = empty, excludes = empty
        ArrayList<Integer> includes = new ArrayList<>();
        ArrayList<Integer> excludes = new ArrayList<>();
        String result = (String) method.invoke(role, col, includes, excludes);
        assertEquals("", result);

        // 2. includes size = 1
        includes.add(10);
        result = (String) method.invoke(role, col, includes, excludes);
        assertEquals(" AND AD_Org_ID=10", result);

        // 3. includes size > 1
        includes.clear();
        includes.add(10);
        includes.add(20);
        includes.add(30);
        result = (String) method.invoke(role, col, includes, excludes);
        assertEquals(" AND AD_Org_ID IN (10,20,30)", result);

        // 4. excludes size = 1
        includes.clear();
        excludes.clear();
        excludes.add(99);

        result = (String) method.invoke(role, col, includes, excludes);
        assertEquals(" AND (AD_Org_ID IS NULL OR AD_Org_ID<>99)", result);

        // 5. excludes size > 1
        excludes.clear();
        excludes.add(1);
        excludes.add(2);
        excludes.add(3);
        result = (String) method.invoke(role, col, includes, excludes);
        assertEquals(" AND (AD_Org_ID IS NULL OR AD_Org_ID NOT IN (1,2,3))", result);

        // 6. includes + excludes mixed (warning path)
        includes.clear();
        excludes.clear();
        includes.add(5);
        excludes.add(9);
        result = (String) method.invoke(role, col, includes, excludes);

        // include branch takes precedence
        assertEquals(" AND AD_Org_ID=5", result);
    }
    
    /**
     * Test cases for MRole.getDependentRecordWhereColumn(String, String)
     * @throws Exception
     */
    @Test
    void testGetDependentRecordWhereColumn() throws Exception {
    	MRole role = new MRole(Env.getCtx(), 0, getTrxName());
        Method method = MRole.class.getDeclaredMethod("getDependentRecordWhereColumn", String.class, String.class);
        method.setAccessible(true);

        // 1. columnName NOT found in SQL
        String sql = "SELECT Name FROM C_BPartner";
        String column = "AD_Org_ID";
        String result = (String) method.invoke(role, sql, column);
        assertEquals("AD_Org_ID", result);

        // 2. columnName found, NO table synonym
        sql = "SELECT AD_Org_ID FROM C_Order";
        result = (String) method.invoke(role, sql, column);
        assertEquals("AD_Org_ID", result);

        // 3. columnName found WITH table synonym (space delimiter)
        sql = "SELECT o.AD_Org_ID FROM C_Order o";
        result = (String) method.invoke(role, sql, column);
        assertEquals("o.AD_Org_ID", result);

        // 4. columnName found WITH table synonym (comma delimiter)
        sql = "SELECT o.AD_Org_ID, o.C_Order_ID FROM C_Order o";
        result = (String) method.invoke(role, sql, column);
        assertEquals("o.AD_Org_ID", result);

        // 5. columnName found WITH table synonym (parenthesis delimiter)
        sql = "SELECT COUNT(o.AD_Org_ID) FROM C_Order o";
        result = (String) method.invoke(role, sql, column);
        assertEquals("o.AD_Org_ID", result);
    }
    
    /**
     * Test cases for MRole.includeRole(MRole, int)
     */
    @SuppressWarnings("unchecked")
	@Test
    public void testIncludeRole() throws Exception {
    	Properties ctx = Env.getCtx();
        String trxName = getTrxName();
        String uniqueSuffix = String.valueOf(System.currentTimeMillis());
        try {
	    	MRole parentRole = new MRole(ctx, 0, trxName);
	    	parentRole.setName("Parent Role " + uniqueSuffix);
	    	parentRole.setAD_Org_ID(0);
	    	parentRole.setIsManual(true);
	    	parentRole.saveEx();
	        
	        MRole childRole1 = new MRole(ctx, 0, trxName);
	        childRole1.setName("Child Role 1 " + uniqueSuffix);
	        childRole1.setAD_Org_ID(0);
	        childRole1.setIsManual(true);
	        childRole1.saveEx();
	        
	        MRole childRole2 = new MRole(ctx, 0, trxName);
	        childRole2.setName("Child Role 2 " + uniqueSuffix);
	        childRole2.setAD_Org_ID(0);
	        childRole2.setIsManual(true);
	        childRole2.saveEx();
	        
	        MRole inactiveRole = new MRole(ctx, 0, trxName);
	        inactiveRole.setName("Inactive Role " + uniqueSuffix);
	        inactiveRole.setAD_Org_ID(0);
	        inactiveRole.setIsManual(true);
	        inactiveRole.setIsActive(false);
	        inactiveRole.saveEx();
	
	        Method includeRole = MRole.class.getDeclaredMethod("includeRole", MRole.class, int.class);
	        includeRole.setAccessible(true);
	
	        Field includedRolesField = MRole.class.getDeclaredField("m_includedRoles");
	        includedRolesField.setAccessible(true);
	
	        Field parentField = MRole.class.getDeclaredField("m_parent");
	        parentField.setAccessible(true);
	        
	        Field includedSeqNoField = MRole.class.getDeclaredField("m_includedSeqNo");
	        includedSeqNoField.setAccessible(true);
	
	        // 1. Add first child role (initializes m_includedRoles)
	        includeRole.invoke(parentRole, childRole1, 10);
	        List<MRole> includedRoles = (List<MRole>) includedRolesField.get(parentRole);
	        assertNotNull(includedRoles, "Included roles list must be initialized");
	        assertEquals(1, includedRoles.size());
	        assertSame(childRole1, includedRoles.get(0), "First included role should be childRole1");
	        assertSame(parentRole, parentField.get(childRole1), "Parent of childRole1 should be set");
	        assertEquals(10, includedSeqNoField.get(childRole1));
	
	        // 2. Add second child role
	        includeRole.invoke(parentRole, childRole2, 20);
	        includedRoles = (List<MRole>) includedRolesField.get(parentRole);
	        assertEquals(2, includedRoles.size(), "Second role should be added");
	        assertSame(childRole2, includedRoles.get(1));
	        assertSame(parentRole, parentField.get(childRole2));
	        assertEquals(20, includedSeqNoField.get(childRole2));
	
	        // 3. Try adding the same role again (should not add)
	        includeRole.invoke(parentRole, childRole1, 99);
	        includedRoles = (List<MRole>) includedRolesField.get(parentRole);
	        assertEquals(2, includedRoles.size(), "Duplicate role should not be added");
	
	        // 4. Try adding the parent role itself (should not add)
	        includeRole.invoke(parentRole, parentRole, 50);
	        includedRoles = (List<MRole>) includedRolesField.get(parentRole);
	        assertEquals(2, includedRoles.size(), "Parent role cannot include itself");
	
	        // 5. Add an inactive role (should not add)
	        includeRole.invoke(parentRole, inactiveRole, 30);
	        includedRoles = (List<MRole>) includedRolesField.get(parentRole);
	        assertEquals(2, includedRoles.size(), "Inactive role should not be added");
        } finally {
        	rollback();
        }
    }
}