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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Properties;

import org.adempiere.exceptions.CrossTenantException;
import org.compiere.model.MTest;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class POCrossTenantTest extends AbstractTestCase
{
	private MTest testPO;
    private Properties ctx;
    private int originalClientID;
    
    @BeforeEach
    void setUp() {
        ctx = Env.getCtx();
        originalClientID = Env.getAD_Client_ID(ctx);
        testPO = new MTest(Env.getCtx(), 0, getTrxName());
    	testPO.setName("Name");
    	testPO.saveEx();
    }
    
    @AfterEach
	protected void tearDown() {
        PO.clearCrossTenantSafe();
        Env.setContext(ctx, Env.AD_CLIENT_ID, originalClientID);
    }
    
    @Test
    void testDelete_SameTenant_Success() {
        assertDoesNotThrow(() -> testPO.delete(false));
    }
    
    @Test
    void testDelete_CrossTenant_ThrowsException() {
        Env.setContext(ctx, Env.AD_CLIENT_ID, 1000000);
        assertThrows(CrossTenantException.class, () -> testPO.delete(false));
    }

    
    @Test
    void testDelete_CrossTenantWithSafeFlag_Success() {
        Env.setContext(ctx, Env.AD_CLIENT_ID, 1000000);
        PO.setCrossTenantSafe();
        
        assertDoesNotThrow(() -> testPO.delete(false));
    }
   
    @Test
    void testDelete_SystemClientCanDeleteTenantRecord() {
        Env.setContext(ctx, Env.AD_CLIENT_ID, 0); //System Tenant
        assertDoesNotThrow(() -> testPO.delete(false));
    }
    
    
    @Test
    void testDelete_TenantClientCannotDeleteSystemRecord() {

        Env.setContext(ctx, Env.AD_CLIENT_ID, 0);
        MTest systemTestPO = new MTest(Env.getCtx(), 0, getTrxName());
        systemTestPO.setName("Name");
        systemTestPO.saveEx();
        
        Env.setContext(ctx, Env.AD_CLIENT_ID, originalClientID);
        assertThrows(CrossTenantException.class, () -> systemTestPO.delete(false));
    }

    @Test
    void testDelete_CrossTenantFlagClearedAfterUse() {
        Env.setContext(ctx, Env.AD_CLIENT_ID, 1000);

        PO.setCrossTenantSafe(); // Sets cross tenant safe flag
        PO.clearCrossTenantSafe(); // Clears it immediately

        assertThrows(CrossTenantException.class, () -> testPO.delete(false));
    }
    
    @Test
    void testDelete_MultipleOperationsWithSafeFlag() {
    	MTest testPO2 = new MTest(Env.getCtx(), 0, getTrxName());
    	testPO2.setName("Name 2");
    	testPO2.saveEx();
        
        Env.setContext(ctx, Env.AD_CLIENT_ID, 1000);
        PO.setCrossTenantSafe();
        
        assertDoesNotThrow(() -> testPO.delete(false));
        assertDoesNotThrow(() -> testPO2.delete(false));
        
        PO.clearCrossTenantSafe();
    }
    
    @Test
    public void testSaveWithSameTenant_ShouldSucceed() {
    	testPO.setName("Updated Name");
        assertDoesNotThrow(() -> testPO.saveEx());
        assertTrue(testPO.get_ID() > 0);
        assertEquals(testPO.getName(), "Updated Name");
    }
    
    @Test
    public void testSaveWithDifferentTenant_ShouldThrowException() {
    	testPO.setName("Updated Name");
        Env.setContext(ctx, Env.AD_CLIENT_ID, 1000);
        assertThrows(CrossTenantException.class, () -> testPO.saveEx());
    }
    
    @Test
    public void testSaveSystemRecordFromTenant_ShouldThrowException() {
    	Env.setContext(ctx, Env.AD_CLIENT_ID, 0);
        MTest systemTestPO = new MTest(Env.getCtx(), 0, getTrxName());
        systemTestPO.setName("Name");

        Env.setContext(ctx, Env.AD_CLIENT_ID, originalClientID);
        assertThrows(CrossTenantException.class, () -> systemTestPO.saveEx());
    }
    
    @Test
    public void testSaveWithCrossTenantSafeFlag_ShouldSucceed() {
        Env.setContext(ctx, Env.AD_CLIENT_ID, 1000);
    	testPO.setName("Updated Name");

        try {
            // Execute: Enable cross-tenant safe mode
            PO.setCrossTenantSafe();
            
            // Verify: Should save without exception
            assertDoesNotThrow(() -> testPO.saveEx());
            assertTrue(testPO.get_ID() > 0);
            assertEquals(testPO.getName(), "Updated Name");
        } finally {
            PO.clearCrossTenantSafe();
        }
    }
}
