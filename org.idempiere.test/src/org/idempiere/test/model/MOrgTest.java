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
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.lang.reflect.Field;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MOrg;
import org.compiere.model.MOrgInfo;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * Comprehensive JUnit 5 tests for {@link MOrg}.
 * 
 * @author etantg
 */
public class MOrgTest extends AbstractTestCase {

	private static int ORG_ID = DictionaryIDs.AD_Org.HQ.id;
	private static String ORG_UU;

	@BeforeAll
	public static void beforeAll() {
		ORG_UU = DB.getSQLValueString(null, "SELECT AD_Org_UU FROM AD_Org WHERE AD_Org_ID=?", ORG_ID);
	}

	/**
	 * Test construction of MOrg by ID.
	 */
	@Test
	public void testConstructorById() {
		MOrg org = new MOrg(Env.getCtx(), ORG_ID, getTrxName());
		assertEquals(ORG_ID, org.getAD_Org_ID());
		assertEquals(ORG_UU, org.getAD_Org_UU());
	}

	/**
	 * Test construction of MOrg using UUID.
	 */
	@Test
	public void testConstructorByUUID() {
		MOrg org = new MOrg(Env.getCtx(), ORG_UU, getTrxName());
		assertEquals(ORG_ID, org.getAD_Org_ID());
		
		org = new MOrg(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
		assertEquals(0, org.getAD_Org_ID());
		assertFalse(org.isSummary(), "Summary should be defaulted to false");
	}
	
	/**
	 * Test cases for MOrg(MClient, String, String)
	 */
	@Test
	public void testParentConstructor() {
	    MClient client = MClient.get(Env.getCtx());
	    assertNotNull(client);
	    String value = "TEST_ORG";
	    String name  = "Test Organization";
	    MOrg org = new MOrg(client, value, name);
	    assertNotNull(org);
	    // New record (not saved yet)
	    assertEquals(0, org.get_ID());
	    // Client copied correctly
	    assertEquals(client.getAD_Client_ID(), org.getAD_Client_ID());
	    // Fields assigned
	    assertEquals(value, org.getValue());
	    assertEquals(name, org.getName());
	    // Context & transaction propagated
	    assertEquals(client.getCtx(), org.getCtx());
	    assertEquals(client.get_TrxName(), org.get_TrxName());
	}
	
	/**
	 * Test cases for MOrg(MOrg), MOrg(Properties, MOrg) and MOrg(Properties, MOrg, String)
	 * @throws Exception
	 */
	@Test
	public void testCopyConstructors() throws Exception {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

	    MClient client = MClient.get(ctx);
	    assertNotNull(client);
	    MOrg source = new MOrg(client, "SRC_ORG", "Source Org");
	    source.setDescription("Original description");
	    source.setIsActive(true);

	    // Use reflection to set m_linkedBPartner in source
	    Field linkedBPField = MOrg.class.getDeclaredField("m_linkedBPartner");
	    linkedBPField.setAccessible(true);
	    linkedBPField.set(source, 12345); // arbitrary test value

	    MOrg[] copies = {
	    	new MOrg(source),
	    	new MOrg(ctx, source),
	    	new MOrg(ctx, source, trxName)
	    };
	    for (MOrg copy : copies) {
	    	assertNotNull(copy);
		    assertEquals(0, copy.get_ID());
		    assertEquals(source.getValue(), copy.getValue());
		    assertEquals(source.getName(), copy.getName());
		    assertEquals(12345, linkedBPField.get(copy));
	    }
	}

	@Test
	public void testActiveFlag() {
		MOrg org = new MOrg(Env.getCtx(), ORG_ID, getTrxName());
		assertTrue(org.isActive());
	}

	@Test
	public void testOrgCache() {
		MOrg org1 = MOrg.get(Env.getCtx(), ORG_ID);
		MOrg org2 = MOrg.get(Env.getCtx(), ORG_ID);
		assertSame(org1, org2);
	}

	@Test
	public void testNonExistingUUID() {
		String nonExistingUU = "00000000-0000-0000-0000-000000000000";
		MOrg org = new MOrg(Env.getCtx(), nonExistingUU, getTrxName());
		assertEquals(0, org.getAD_Org_ID(), "Non-existing UUID should result in new record with ID 0");
	}

	@Test
	public void testNameAndToString() {
		MOrg org = new MOrg(Env.getCtx(), ORG_ID, getTrxName());
		assertNotNull(org.getName());
		assertTrue(org.getName().length() > 0);
		assertNotNull(org.toString());
	}
	
	/**
	 * Test cases MOrg.get(int) and MOrg.get(Properties, int)
	 */
	@Test
	public void testGetMethods() {
	    Properties ctx = Env.getCtx();
	    int validOrgID = 0;
	    
	    // Ensure cache miss first
	    MOrg org1 = MOrg.get(ctx, validOrgID);
	    assertNotNull(org1);
	    assertEquals(validOrgID, org1.getAD_Org_ID());
	    
	    MOrg org2 = MOrg.get(ctx, validOrgID);
	    assertNotNull(org2);
	    assertSame(org1, org2, "Expected same cached instance");

	    // get(int) overload coverage
	    MOrg org3 = MOrg.get(validOrgID);
	    assertNotNull(org3);
	    assertEquals(validOrgID, org3.getAD_Org_ID());

	    // Invalid Org ID → constructor but ID mismatch → null
	    int invalidOrgID = -999999;
	    MOrg invalidOrg = MOrg.get(ctx, invalidOrgID);
	    assertNull(invalidOrg);
	}
	
	/**
	 * Test cases for MOrg.getOfClient(), MOrg.getOfClient(int) and MOrg.getOfClient(PO)
	 */
	@Test
	public void testGetOfClientMethods() {
	    Properties ctx = Env.getCtx();
	    int clientID = Env.getAD_Client_ID(ctx);

	    // getOfClient(int)
	    MOrg[] orgsByClient = MOrg.getOfClient(clientID);
	    assertNotNull(orgsByClient);
	    assertTrue(orgsByClient.length > 0);
	    for (MOrg org : orgsByClient) {
	        assertNotNull(org);
	        assertEquals(clientID, org.getAD_Client_ID());
	    }

	    // Cache population verification
	    MOrg cached = MOrg.get(ctx, orgsByClient[0].getAD_Org_ID());
	    assertNotNull(cached);
	    assertEquals(orgsByClient[0].getAD_Org_ID(), cached.getAD_Org_ID());

	    // getOfClient()
	    MOrg[] orgsDefault = MOrg.getOfClient();
	    assertNotNull(orgsDefault);
	    assertTrue(orgsDefault.length > 0);

	    // getOfClient(PO)
	    MUser user = MUser.get(ctx);
	    MOrg[] orgsByPO = MOrg.getOfClient(user);
	    assertNotNull(orgsByPO);
	    assertTrue(orgsByPO.length > 0);
	    for (MOrg org : orgsByPO) {
	        assertEquals(clientID, org.getAD_Client_ID());
	    }
	}
	
	@Test
	public void testSaveAndDelete() {
	    Properties ctx = Env.getCtx();
	    MClient client = MClient.get(ctx);
	    MOrg org = null;
	    try {
		    org = new MOrg(client, "TEST_ORG", "Test Org") {
				private static final long serialVersionUID = 1L;
	
				// Override tree and access methods to avoid DB side-effects
		        @Override
		        protected boolean insert_Tree (String treeType) {
		        	return true; 
		        }
	
		        @Override
		        public void update_Tree (String treeType) { /* do nothing */ }
	
		        @Override
		        protected boolean delete_Tree (String treeType) {
		        	return true;
		        }
		    };
		    org.set_TrxName(getTrxName());
		    assertTrue(org.save(), "save() should return true");
		    int orgID = org.get_ID();
		    assertTrue(orgID > 0, "save() should generate new ID for new record");
	
		    // Modify Value and Name to trigger is_ValueChanged branch in afterSave
		    org.setName("TEST_ORG_UPDATED");
		    org.setValue("TEST_ORG_UPDATED");
		    assertTrue(org.save(), "save() should return true");
		    int updatedID = org.get_ID();
		    assertEquals(orgID, updatedID, "save() should return same ID for update");
		    		    
		    assertTrue(org.delete(true), "delete() should return true for successful deletion");
	    } finally {
	    	rollback();
	    }
	}
	
	/**
	 * Test cases for MOrg.getInfo()
	 */
	@Test
	public void testGetInfo() {
	    MClient client = MClient.get(Env.getCtx());
	    MOrg org = new MOrg(client, "TEST_ORG", "Test Org");
	    MOrgInfo info = org.getInfo();
	    assertNotNull(info);
	    assertEquals(org.getAD_Org_ID(), info.getAD_Org_ID());
	    assertEquals(org.get_TrxName(), info.get_TrxName());

	    MOrgInfo info2 = org.getInfo();
	    assertNotNull(info2);
	    assertEquals(org.getAD_Org_ID(), info2.getAD_Org_ID());
	    assertEquals(org.get_TrxName(), info2.get_TrxName());
	}
	
	/**
	 * Test cases for MOrg.getLinkedC_BPartner_ID(String)
	 * @throws Exception
	 */
	@Test
	public void testGetLinkedC_BPartner_ID() throws Exception {
	    Properties ctx = Env.getCtx();
	    MClient client = MClient.get(ctx);
	    MOrg org = new MOrg(client, "TEST_ORG", "Test Org");

	    // Use reflection to access private m_linkedBPartner
	    Field linkedBPField = MOrg.class.getDeclaredField("m_linkedBPartner");
	    linkedBPField.setAccessible(true);

	    // Ensure m_linkedBPartner starts null
	    linkedBPField.set(org, null);
	    assertNull(linkedBPField.get(org));

	    // Case 1: No matching C_BPartner in DB (DB returns -1)
	    int bpID = org.getLinkedC_BPartner_ID(null); // trxName = null
	    assertEquals(0, bpID); // method converts -1 to 0
	    // Check that m_linkedBPartner was cached correctly
	    assertEquals(0, linkedBPField.get(org));

	    // Case 2: DB returns a valid C_BPartner_ID
	    int bpartnerId = DictionaryIDs.C_BPartner.STORE_CENTRAL.id;
	    MBPartner bp = MBPartner.get(ctx, bpartnerId);
	    org = MOrg.get(bp.getAD_OrgBP_ID());
	    // Reset cache
	    linkedBPField.set(org, null);
	    int bpID2 = org.getLinkedC_BPartner_ID(null);
	    assertEquals(bpartnerId, bpID2);
	    // m_linkedBPartner should now be cached
	    assertEquals(bpartnerId, linkedBPField.get(org));

	    // Case 3: Already cached value is returned without hitting DB
	    // Manually change cache to a different value
	    linkedBPField.set(org, 9999);
	    int bpID3 = org.getLinkedC_BPartner_ID(null);
	    assertEquals(9999, bpID3); // cached value used
	}
	
	/**
	 * Test cases for MOrg.markImmutable()
	 * @throws Exception
	 */
	@Test
	public void testMarkImmutable() throws Exception {
	    MClient client = MClient.get(Env.getCtx());
	    MOrg org = new MOrg(client, "TEST_ORG", "Test Org");

	    // Case 1: Already immutable
	    org.markImmutable();  // make it immutable
	    MOrg returned1 = org.markImmutable();
	    assertSame(org, returned1);               // should return same instance
	    assertTrue(org.is_Immutable());           // still immutable

	    // Case 2: Not immutable yet
	    MOrg org2 = new MOrg(client, "NEW_ORG", "New Org");
	    assertFalse(org2.is_Immutable());         // initially mutable
	    MOrg returned2 = org2.markImmutable();
	    assertSame(org2, returned2);             // should return same instance
	    assertTrue(org2.is_Immutable());         // now it is immutable
	}
	
}

