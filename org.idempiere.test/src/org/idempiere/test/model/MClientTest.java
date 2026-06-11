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
import static org.junit.jupiter.api.Assertions.assertNotSame;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.mail.internet.InternetAddress;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.Mockito;

/**
 * Comprehensive JUnit 5 tests for {@link MClient}.
 * 
 * @author etantg
 */
@Isolated
public class MClientTest extends AbstractTestCase {

	private static final int CLIENT_ID = DictionaryIDs.AD_Client.GARDEN_WORLD.id;
	private static String CLIENT_UU;

	@BeforeAll
	public static void beforeAll() {
		CLIENT_UU = DB.getSQLValueString(null, "SELECT AD_Client_UU FROM AD_Client WHERE AD_Client_ID=?", CLIENT_ID);
	}

	/**
	 * Test construction of MClient by ID.
	 */
	@Test
	public void testConstructorById() {
		MClient client = new MClient(Env.getCtx(), CLIENT_ID, getTrxName());
		assertEquals(CLIENT_ID, client.getAD_Client_ID());
		assertEquals(CLIENT_UU, client.getAD_Client_UU());
	}

	/**
	 * Test construction of MClient using UUID.
	 */
	@Test
	public void testConstructorByUUID() {
		MClient client = new MClient(Env.getCtx(), CLIENT_UU, getTrxName());
		assertEquals(CLIENT_ID, client.getAD_Client_ID());
	}
	
	/**
	 * Test cases for MClient.get(int), MClient.get(Properties) and MClient.get(Properties, int)
	 */
	@Test
	public void testGetClient() {
		Properties ctx = Env.getCtx();
		int clientId = Env.getAD_Client_ID(ctx);
		MClient client0 = MClient.get(ctx, clientId);
		assertNotNull(client0, "Client should not be null on first load");
		assertEquals(clientId, client0.getAD_Client_ID(), "Client ID should match");

		MClient[] clients = {
			MClient.get(ctx, clientId),
			MClient.get(clientId),
			MClient.get(ctx)
		};
		for (MClient client : clients) {
			assertNotNull(client, "Client should not be null when retrieved by client ID only");
			assertEquals(clientId, client.getAD_Client_ID(), "Client ID should match");
			assertSame(client0, client, "Should return the same cached client");
		}
	}
	
	/**
	 * Test cases for MClient.getByLoginPrefix(String)
	 */
	@Test
	public void testGetByLoginPrefix() {
	    MClient client = null;
	    try { 	
		    // 1. No matching client → returns null
		    MClient none = MClient.getByLoginPrefix("___NO_SUCH_PREFIX___");
		    assertNull(none);
	
		    // 2. Create real client with LoginPrefix
		    client = new MClient(Env.getCtx(), 0, true, getTrxName());
		    PO.setCrossTenantSafe();
		    client.setValue("TEST_CLIENT_PX");
		    client.setName("Test Client PX");
		    client.setLoginPrefix("PX_TEST");
		    client.setIsActive(true);
		    client.saveEx();
		    
		    commit();
	
		    int clientId = client.getAD_Client_ID();
	
		    // 3. Cache miss → first load from DB
		    MClient loaded1 = MClient.getByLoginPrefix("PX_TEST");
		    assertNotNull(loaded1);
		    assertEquals(clientId, loaded1.getAD_Client_ID());
	    } finally {
	    	PO.clearCrossTenantSafe();
	    	
	    	if (client != null && client.get_ID() > 0) {
		    	String sql = "DELETE FROM AD_Client WHERE AD_Client_ID=?";
		    	DB.executeUpdateEx(sql, new Object[] {client.get_ID()}, null);
	    	}
	    }
	}
	
	/**
	 * Test cases for MClient.isClientAccounting(), MClient.isClientAccountingQueue() and MClient.isClientAccountingImmediate()
	 */
	@Test
	public void testClientAccountingMethods() {
		MSysConfig config = null;
		try {
			// Case 1: Default / Queue
			config = new MSysConfig(Env.getCtx(), 0, getTrxName());
			config.setName(MSysConfig.CLIENT_ACCOUNTING);
			config.setValue("Q");
			config.setAD_Org_ID(0);
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
			assertTrue(MClient.isClientAccounting(), "Default/Queue config should be accounting");
			assertTrue(MClient.isClientAccountingQueue(), "Queue config should return true for isClientAccountingQueue");
			assertFalse(MClient.isClientAccountingImmediate(), "Queue config should return false for isClientAccountingImmediate");
	
			// Case 2: Immediate
			config.setValue("I");
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
			assertTrue(MClient.isClientAccounting(), "Immediate config should be accounting");
			assertFalse(MClient.isClientAccountingQueue(), "Immediate config should return false for isClientAccountingQueue");
			assertTrue(MClient.isClientAccountingImmediate(), "Immediate config should return true for isClientAccountingImmediate");
	
			// Case 3: Unexpected / invalid value
			config.setValue("INVALID_VALUE");
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
			assertFalse(MClient.isClientAccounting(), "Invalid config should return false for isClientAccounting");
			assertFalse(MClient.isClientAccountingQueue(), "Invalid config should return false for isClientAccountingQueue");
			assertFalse(MClient.isClientAccountingImmediate(), "Invalid config should return false for isClientAccountingImmediate");
		} finally {
	        rollback();
	        
	        if (config != null && config.get_ID() > 0)
    			config.deleteEx(true, null);
	    }
	}
	
	/**
	 * Test cases for MClient.isSendCredentialsClient() and MClient.isSendCredentialsSystem()
	 */
	@Test
    public void testSendCredentialsMethods() {
		MSysConfig config = null;
		try {
	        // Case 1: Default / USER
			config = new MSysConfig(Env.getCtx(), 0, getTrxName());
			config.setName(MSysConfig.MAIL_SEND_CREDENTIALS);
			config.setValue("U");
			config.setAD_Org_ID(0);
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
	        assertFalse(MClient.isSendCredentialsClient(), "Default USER config should not be client");
	        assertFalse(MClient.isSendCredentialsSystem(), "Default USER config should not be system");
	
	        // Case 2: Client
	        config.setValue("C");
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
	        assertTrue(MClient.isSendCredentialsClient(), "Client config should return true for isSendCredentialsClient");
	        assertFalse(MClient.isSendCredentialsSystem(), "Client config should return false for isSendCredentialsSystem");
	
	        // Case 3: System
	        config.setValue("S");
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
	        assertFalse(MClient.isSendCredentialsClient(), "System config should return false for isSendCredentialsClient");
	        assertTrue(MClient.isSendCredentialsSystem(), "System config should return true for isSendCredentialsSystem");
	
	        // Case 4: Unexpected / invalid value
	        config.setValue("INVALID_VALUE");
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
	        assertFalse(MClient.isSendCredentialsClient(), "Invalid config should return false for isSendCredentialsClient");
	        assertFalse(MClient.isSendCredentialsSystem(), "Invalid config should return false for isSendCredentialsSystem");
		} finally {
	        rollback();
	        
	        if (config != null && config.get_ID() > 0)
    			config.deleteEx(true, null);
	    }
    }
	
	/**
	 * Test cases for MClient.get(MClient), MClient(Properties, MClient) and MClient(Properties, MClient, String)
	 */
	@Test
    public void testCopyConstructors() {
        Properties ctx = Env.getCtx();
        MClient original = MClient.get(ctx);
        
        MClient[] copies = {
        	new MClient(original),
        	new MClient(ctx, original),
        	new MClient(ctx, original, "TestTrx")
        };
        for (MClient copy : copies) {
            assertNotNull(copy, "Copy should be instantiated");
            assertEquals(original.getAD_Client_ID(), copy.getAD_Client_ID(), "AD_Client_ID should match original");
            assertNotSame(original, copy, "Copy should be a different instance");
            if (original.getInfo() != null) {
                assertNotNull(copy.getInfo(), "Copy MClientInfo should be copied");
                assertNotSame(original.getInfo(), copy.getInfo(), "MClientInfo should be a new instance");
            }
            assertEquals(original.getSetup_AD_Tree_Account_ID(), copy.getSetup_AD_Tree_Account_ID(), "Setup_AD_Tree_Account_ID should be copied");
        }
    }
	
	/**
	 * Test cases for MClient(Properties, int, boolean, String)
	 */
	@Test
    public void testMClientConstructorWithCreateNewFlag() {
        Properties ctx = Env.getCtx();

        // Case 1: AD_Client_ID = 0 and createNew = true
        MClient client1 = new MClient(ctx, 0, true, "TestTrx");
        assertNotNull(client1, "Client1 should be instantiated");
        assertEquals(0, client1.getAD_Client_ID(), "AD_Client_ID should be 0");
        assertFalse(client1.isMultiLingualDocument(), "MultiLingualDocument should be false");
        assertFalse(client1.isSmtpAuthorization(), "SMTP authorization should be false");
        assertTrue(client1.isUseBetaFunctions(), "UseBetaFunctions should be true");
        assertEquals(Language.getBaseAD_Language(), client1.getAD_Language(), "Language should be base language");
        assertEquals(MClient.AUTOARCHIVE_None, client1.getAutoArchive(), "AutoArchive should be None");
        assertEquals(MClient.MMPOLICY_FiFo, client1.getMMPolicy(), "MMPolicy should be FiFo");
        assertFalse(client1.isPostImmediate(), "PostImmediate should be false");

        // Case 2: AD_Client_ID = 0 and createNew = false
        MClient client2 = new MClient(ctx, 0, false, "TestTrx");
        assertNotNull(client2, "Client2 should be instantiated");
        assertEquals(0, client2.getAD_Client_ID(), "AD_Client_ID should be 0");
        assertNotNull(client2.getName(), "Loaded client should have a name");

        // Case 3: AD_Client_ID > 0
        int existingClientID = CLIENT_ID;
        MClient client3 = new MClient(ctx, existingClientID, true, "TestTrx");
        assertNotNull(client3, "Client3 should be instantiated");
        assertEquals(existingClientID, client3.getAD_Client_ID(), "AD_Client_ID should match the input");
    }
	
	/**
	 * Test cases for MCLient(Properties, String)
	 */
	@Test
    public void testMClientConstructorWithTrxName() {
        Properties ctx = Env.getCtx();
        MClient client = new MClient(ctx, "TestTrx");
        assertNotNull(client, "Client should be instantiated");
        assertEquals(Env.getAD_Client_ID(ctx), client.getAD_Client_ID(), "AD_Client_ID should match the current context client");
        assertEquals("TestTrx", client.get_TrxName(), "Transaction name should be set");
    }
	
	/**
	 * Test cases for MClient.createEmail methods
	 */
	@Test
    public void testCreateEMailMethods() {
        MClient client = MClient.get(Env.getCtx());
        
        try {
	        MUser fromUser = new MUser(Env.getCtx(), 0, getTrxName());
	        fromUser.setName("Test From User");
	        fromUser.saveEx();
	        
	        MUser toUser = new MUser(Env.getCtx(), 0, getTrxName());
	        toUser.setName("Test To User");
	        toUser.saveEx();
	
	        // Case 1: Null recipient user -> should return null
	        EMail email = client.createEMail(fromUser, (MUser) null, "Subject", "Message");
	        assertNull(email, "Null 'to' user should return null");
	
	        // Case 2: Recipient user with null email -> should return null
	        toUser.setEMail(null);
	        email = client.createEMail(fromUser, toUser, "Subject", "Message");
	        assertNull(email, "User with null email should return null");
	
	        // Case 3: Recipient user with email -> should create EMail object
	        toUser.setEMail("to@example.com");
	        fromUser.setEMail("from@example.com");
	        fromUser.setEMailUser("from@example.com");
	        email = client.createEMail(fromUser, toUser, "Subject", "Message");
	        assertNotNull(email, "Valid users should create EMail");
	        assertEquals("to@example.com", email.getTo().getAddress());
	
	        // Case 4: createEMail using String recipient, null or empty -> should return null
	        email = client.createEMail((String) null, "Subj", "Msg");
	        assertNull(email, "Null 'to' string should return null");
	        email = client.createEMail("", "Subj", "Msg");
	        assertNull(email, "Empty 'to' string should return null");
	        email = client.createEMail(fromUser, (String) null, "Subj", "Msg", true);
	        assertNull(email, "Null 'to' string should return null");
	        email = client.createEMail(fromUser, "", "Subj", "Msg", true);
	        assertNull(email, "Empty 'to' string should return null");
	
	        // Case 5: createEMail using String recipient, valid -> should create EMail
	        email = client.createEMail("to2@example.com", "Subject2", "Message2");
	        assertNotNull(email, "Valid string 'to' should create EMail");
	        assertEquals("to2@example.com", email.getTo().getAddress());
	
	        // Case 6: createEMail with html = true
	        email = client.createEMail(fromUser, toUser, "SubjectHTML", "MessageHTML", true);
	        assertNotNull(email, "Valid users with html=true should create EMail");
	        assertNotNull(email.getMessageHTML(), "HTML email message should not be null");
	
	        // Case 7: createEMail without from user -> should still create EMail using client request
	        email = client.createEMail((MUser) null, "to3@example.com", "Subj3", "Msg3");
	        assertNotNull(email, "Null 'from' user should use client request email");
	
	        // Case 8: createEMail with from user missing email details -> should return null
	        MUser incompleteFrom = new MUser(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), getTrxName());
	        incompleteFrom.setEMail(null);
	        email = client.createEMail(incompleteFrom, toUser, "Subject", "Message");
	        assertNull(email, "From user with incomplete email should return null");
        } finally {
        	rollback();
        }
    }
	
	/**
	 * Test cases for MClient.createEMailFrom(String, String, String, String, boolean)
	 */
	@Test
    public void testCreateEMailFrom() {
        MClient client = new MClient(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()), getTrxName());

        String from = "from@example.com";
        String to = "to@example.com";
        String subject = "Test Subject";
        String message = "Test Message";

        // Case 1: null "from" -> should return null
        EMail email = client.createEMailFrom(null, to, subject, message, false);
        assertNull(email, "Null 'from' should return null");

        // Case 2: empty "from" -> should return null
        email = client.createEMailFrom("", to, subject, message, false);
        assertNull(email, "Empty 'from' should return null");

        // Case 3: null "to" -> should return null
        email = client.createEMailFrom(from, null, subject, message, false);
        assertNull(email, "Null 'to' should return null");

        // Case 4: empty "to" -> should return null
        email = client.createEMailFrom(from, "", subject, message, false);
        assertNull(email, "Empty 'to' should return null");

        // Case 5: valid from/to, html=false
        email = client.createEMailFrom(from, to, subject, message, false);
        assertNotNull(email, "Valid from/to should create EMail");
        assertEquals(from, email.getFrom().toString(), "From address should match");
        assertEquals(to, email.getTo().getAddress(), "To address should match");
        assertNull(email.getMessageHTML(), "HTML email message should be null");

        // Case 6: valid from/to, html=true
        email = client.createEMailFrom(from, to, subject, message, true);
        assertNotNull(email, "Valid from/to with html=true should create EMail");
        assertNotNull(email.getMessageHTML(), "HTML email message should not be null");

        // Case 7: SMTP authorization paths
        client.setIsSmtpAuthorization(true);
        email = client.createEMailFrom(from, to, subject, message, false);
        assertNotNull(email, "Email should still be created when SMTP authorization is evaluated");
    }
	
	/**
	 * Test cases for MClient.getAcctSchema()
	 */
	@Test
    public void testGetAcctSchema() {
        // Case 1: m_info is null and client has NO accounting schema
        MClient client = new MClient(Env.getCtx(), 0, getTrxName());
        MAcctSchema acctSchema = client.getAcctSchema();
        assertNull(acctSchema, "Should return null when no accounting schema is defined");

        // Case 2: m_info exists but C_AcctSchema1_ID == 0
        client.getInfo(); // trigger lazy init
        acctSchema = client.getAcctSchema();
        assertNull(acctSchema, "Should return null when accounting schema ID is zero");

        // Case 3: m_info exists and C_AcctSchema1_ID is valid
        client = MClient.get(Env.getCtx(), CLIENT_ID);
        MClientInfo info = client.getInfo();
        int validAcctSchemaId = info.getC_AcctSchema1_ID();
        acctSchema = client.getAcctSchema();
        assertNotNull(acctSchema, "Should return accounting schema when ID is valid");
        assertEquals(validAcctSchemaId, acctSchema.getC_AcctSchema_ID(), "Returned schema ID should match client accounting schema ID");
    }
	
	/**
	 * Test cases for MClient.getAD_Language()
	 */
	@Test
	public void testGetAD_Language() {
		MClient client = new MClient(Env.getCtx(), 0, getTrxName());

		// Case 1: AD_Language is null
		client.setAD_Language(null);
		String lang = client.getAD_Language();
		assertNotNull(lang, "Language should never be null");
		assertEquals(Language.getBaseAD_Language(), lang, "Base AD language should be returned when AD_Language is null");

		// Case 2: AD_Language is explicitly set
		String customLanguage = "es_CO";
		client.setAD_Language(customLanguage);
		lang = client.getAD_Language();
		assertEquals(customLanguage, lang, "Explicitly set AD_Language should be returned as-is");
	}
	
	/**
	 * Test cases for MClient.getC_Currency_ID()
	 */
	@Test
	public void testGetCurrencyID() {
		MClient client = new MClient(Env.getCtx(), 0, getTrxName());
		
		// Case 1: m_info is null initially
		int currencyId = client.getC_Currency_ID();
		assertTrue(currencyId >= 0, "Currency ID should be zero or a valid positive ID after loading client info");

		// Case 2: m_info already initialized
		int currencyIdAgain = client.getC_Currency_ID();
		assertEquals(currencyId, currencyIdAgain, "Currency ID should be consistent once client info is loaded");
	}
	
	/**
	 * Test cases for MClient.getInfo()
	 */
	@Test
	public void testGetInfo() {
		MClient client = new MClient(Env.getCtx(), 0, getTrxName());
		
		// Case 1: Mutable client (default)
		assertNotNull(client, "Client must exist for test");
		MClientInfo info1 = client.getInfo();
		assertNotNull(info1, "Client info should be initialized when m_info is null on mutable client");

		// Case 2: Cached value
		MClientInfo info2 = client.getInfo();
		assertSame(info1, info2, "getInfo() should return cached MClientInfo instance");
		
		// Case 3: Immutable client branch
		MClient immutableClient = new MClient(client);
		immutableClient.markImmutable();
		MClientInfo immutableInfo = immutableClient.getInfo();
		assertNotNull(immutableInfo, "Immutable client should load MClientInfo via get(), not getCopy()");
	}
	
	/**
	 * Test cases for MClient.getLanguage()
	 */
	@Test
	public void testGetLanguage() {
		MClient client = new MClient(Env.getCtx(), 0, getTrxName());
		assertNotNull(client, "Client must exist for test");

		// Case 1: m_language is null, triggers initialization
		Language lang1 = client.getLanguage();
		assertNotNull(lang1, "Language should be initialized if m_language is null");

		// Case 2: m_language is already set, cached value returned
		Language lang2 = client.getLanguage();
		assertSame(lang1, lang2, "Subsequent calls should return the cached Language instance");
	}
	
	/**
	 * Test cases for MClient.getLocale()
	 */
	@Test
	public void testGetLocale() {
		MClient client = MClient.get(Env.getCtx());
		assertNotNull(client, "Client must exist for test");
		Locale locale = client.getLocale();
		assertNotNull(locale, "Locale should be returned from Language");
		assertEquals(client.getLanguage().getLocale(), locale, "Locale should match Language's locale");
	}
	
	/**
	 * Test cases for MClient.getRequestUser() and MClient.getRequestUserPW()
	 */
	@Test
	public void testGetRequestUserAndPW() {
		MClient client = MClient.get(Env.getCtx());
		MSysConfig config = null;
		try {	
			// Case 1: Normal fallback (AD_Client_ID == 0 or isSendCredentialsSystem() == false)
			String reqUser = client.getRequestUser();
			String reqPW = client.getRequestUserPW();
			assertNotNull(reqUser, "RequestUser should not be null");
			assertNotNull(reqPW, "RequestUserPW should not be null");
	
			// Case 2: AD_Client_ID != 0 and isSendCredentialsSystem() == true → delegate to system client
			config = new MSysConfig(Env.getCtx(), 0, getTrxName());
			config.setName(MSysConfig.MAIL_SEND_CREDENTIALS);
			config.setValue("S");
			config.setAD_Org_ID(0);
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
			
			String sysUser = client.getRequestUser();
			String sysPW = client.getRequestUserPW();	
			assertNotNull(sysUser, "System client user should not be null");
			assertNotNull(sysPW, "System client password should not be null");
			assertEquals(MClient.get(Env.getCtx(), 0).getRequestUser(), sysUser, "Should delegate to system client");
			assertEquals(MClient.get(Env.getCtx(), 0).getRequestUserPW(), sysPW, "Should delegate to system client");
		} finally {
			rollback();
			
			if (config != null && config.get_ID() > 0)
    			config.deleteEx(true, null);
		}
	}
	
	/**
	 * Test cases for MClient.getSMTPHost(), MClient.getSMTPPort(), MClient.isSecureSMTP() and MClient.isSmtpAuthorization()
	 */
	@Test
    public void testSMTPMethods() {
        MClient sysClient = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.SYSTEM.id);
        MClient tenantClient = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		MClient client = MClient.get(Env.getCtx());
		MSysConfig config = null;
		try {	
	        // Case 1: normal client, host should not be null
	        String host = client.getSMTPHost();
	        assertNotNull(host, "getSMTPHost() should never return null");
	        assertEquals(tenantClient.getSMTPHost(), host, "getSMTPHost() should return client host");	
	        assertEquals(tenantClient.getSMTPPort(), client.getSMTPPort(), "getSMTPPort() should return client port");
	        assertEquals(tenantClient.isSecureSMTP(), client.isSecureSMTP(), "isSecureSMTP() should return client SMTP SSL/TLS");
	        assertEquals(tenantClient.isSmtpAuthorization(), client.isSmtpAuthorization(), "isSmtpAuthorization() should return client SMTP Authorization");
	
	        // Case 2: simulate system client forwarding
	        config = new MSysConfig(Env.getCtx(), 0, getTrxName());
			config.setName(MSysConfig.MAIL_SEND_CREDENTIALS);
			config.setValue("S");
			config.setAD_Org_ID(0);
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
	
	        assertEquals(sysClient.getSMTPHost(), client.getSMTPHost(), "getSMTPHost() should return system host");
	        assertEquals(sysClient.getSMTPPort(), client.getSMTPPort(), "getSMTPPort() should return system port");
	        assertEquals(sysClient.isSecureSMTP(), client.isSecureSMTP(), "isSecureSMTP() should return system SMTP SSL/TLS");
	        assertEquals(sysClient.isSmtpAuthorization(), client.isSmtpAuthorization(), "isSmtpAuthorization() should return system SMTP Authorization");
		} finally {
			rollback();
			
			if (config != null && config.get_ID() > 0)
    			config.deleteEx(true, null);
		}
    }
	
	/**
	 * Test cases for MClient.isAutoArchive()
	 */
	@Test
    public void testIsAutoArchive() {
        MClient client = new MClient(Env.getCtx(), 0, getTrxName());

        // Case 1: auto archive not set
        client.setAutoArchive(null);
        assertFalse(client.isAutoArchive(), "AutoArchive null should return false");

        // Case 2: auto archive set to "None"
        client.setAutoArchive(MClient.AUTOARCHIVE_None);
        assertFalse(client.isAutoArchive(), "AutoArchive 'None' should return false");

        // Case 3: auto archive set to other value
        client.setAutoArchive(MClient.AUTOARCHIVE_Documents);
        assertTrue(client.isAutoArchive(), "AutoArchive other than 'None' should return true");
    }
	
	/**
	 * Test cases for MClient.isDisplayField(int)
	 */
	@Test
    public void testIsDisplayField() throws Exception {
		MClient client = new MClient(Env.getCtx(), 0, getTrxName());
        int testFieldID = DictionaryIDs.AD_Field.TEST_TEST_NAME.id;

        // Case 1: ASP not used, should always return true
        client.setIsUseASP(false);
        assertTrue(client.isDisplayField(testFieldID), "When ASP not used, should return true");

        // Case 2: ASP used, but null m_fieldAccess
        client.setIsUseASP(true);
        assertTrue(client.isDisplayField(testFieldID), "Null m_fieldAccess should return true");
        
        // Case 3: ASP used, but no fields in m_fieldAccess (simulate empty query)
        Field field = client.getClass().getDeclaredField("m_fieldAccess");
        field.setAccessible(true);
        field.set(client, new ArrayList<Integer>());
        assertFalse(client.isDisplayField(testFieldID), "No fields in m_fieldAccess should return false");

        // Case 4: ASP used, field present in m_fieldAccess
        ArrayList<Integer> accessList = new ArrayList<>();
        accessList.add(100);
        accessList.add(200);
        accessList.add(testFieldID);
        Collections.sort(accessList);
        field.set(client, accessList);
        assertTrue(client.isDisplayField(testFieldID), "Field present in m_fieldAccess should return true");

        // Case 5: ASP used, field not present in m_fieldAccess
        int absentFieldID = -999;
        assertFalse(client.isDisplayField(absentFieldID), "Field not present should return false");
    }
	
	/**
	 * Test cases for all sendEMail methods
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Test
	public void testSendEMailMethods() throws Exception {
        MClient client = Mockito.spy(new MClient(Env.getCtx(), 0, getTrxName()));

        // Mock users
        MUser from = mock(MUser.class);
        MUser to = mock(MUser.class);
        when(from.getEMail()).thenReturn("from@test.com");
        when(from.getEMailUser()).thenReturn("from@test.com");
        when(from.getEMailUserPW()).thenReturn("pwd");
        when(to.getEMail()).thenReturn("to@test.com");

        // Mock EMail
        EMail email = mock(EMail.class);
        when(email.getFrom()).thenReturn(new InternetAddress("from@test.com"));
        when(email.send()).thenReturn(EMail.SENT_OK);

        // Stub internal MClient methods
        doReturn(true).when(client).sendEMailAttachments(anyInt(), anyString(), anyString(), any(Collection.class));
        doReturn(email).when(client).createEMail(any(MUser.class), any(MUser.class), anyString(), anyString(), anyBoolean());
        doReturn(email).when(client).createEMail(anyString(), anyString(), anyString(), anyBoolean());
        doReturn(true).when(client).sendEmailNow(any(), any(), any());

        File attachment = new File("test.txt");

        // sendEMail(int AD_User_ID, ...)
        assertTrue(client.sendEMail(100, "Sub", "Msg", null));
        assertTrue(client.sendEMail(100, "Sub", "Msg", attachment));

        // sendEMail(MUser from, MUser to, ...)
        assertTrue(client.sendEMail(from, to, "Sub", "Msg", null));
        assertTrue(client.sendEMail(from, to, "Sub", "Msg", attachment));
        assertTrue(client.sendEMail(from, to, "Sub", "Msg", attachment, true));

        // createEMail returns null → false
        doReturn(null).when(client).createEMail(any(MUser.class), any(MUser.class), anyString(), anyString(), anyBoolean());
        assertFalse(client.sendEMail(from, to, "Sub", "Msg", null));

        // restore
        doReturn(email).when(client).createEMail(any(MUser.class), any(MUser.class), anyString(), anyString(), anyBoolean());

        // sendEMail(String to, ...)
        assertTrue(client.sendEMail("to@test.com", "Sub", "Msg", null));
        assertTrue(client.sendEMail("to@test.com", "Sub", "Msg", attachment));
        assertTrue(client.sendEMail("to@test.com", "Sub", "Msg", attachment, true));

        // to is null
        assertFalse(client.sendEMail((String) null, "Sub", "Msg", null));

        // email.send() failure path
        when(email.send()).thenReturn("ERROR");
        assertFalse(client.sendEMail("to@test.com", "Sub", "Msg", null));

        // exception path
        when(email.send()).thenThrow(new RuntimeException("SMTP down"));
        assertFalse(client.sendEMail("to@test.com", "Sub", "Msg", null));
    }
	
	/**
	 * Test cases for MClient.toString()
	 */
	@Test
	public void testToString() {
	    // Case 1: ID = 0, Value = null
	    MClient client1 = new MClient(Env.getCtx(), 0, getTrxName());
	    client1.setValue(null); // Value = null
	    assertEquals("MClient[" + client1.get_ID() + "-" + client1.getValue() + "]", client1.toString());

	    // Case 2: ID > 0, Value = non-empty
	    MClient client2 = new MClient(Env.getCtx(), 0, getTrxName());
	    client2.setValue("TestValue");
	    client2.set_ValueNoCheck("AD_Client_ID", 123);
	    assertEquals("MClient[123-TestValue]", client2.toString());

	    // Case 3: Value is empty string
	    MClient client3 = new MClient(Env.getCtx(), 0, getTrxName());
	    client3.setValue(""); // empty value
	    client3.set_ValueNoCheck("AD_Client_ID", 456);
	    assertEquals("MClient[456-]", client3.toString());
	}
	
	/**
	 * Test cases for MClient.save()
	 */
	@Test
	public void testSave() {
	    Properties ctx = Env.getCtx();
	    String trxName = getTrxName();

	    // Test subclass to detect saveUpdate() usage
	    class TestClient extends MClient {
	        private static final long serialVersionUID = 1863629693199993291L;
			boolean saveUpdateCalled = false;

	        TestClient(Properties ctx, int id, boolean createNew, String trxName) {
	            super(ctx, id, createNew, trxName);
	        }

	        @Override
	        protected boolean saveUpdate() {
	            saveUpdateCalled = true;
	            return true;
	        }
	    }

	    try {
	    	PO.setCrossTenantSafe();
	    	
		    // 1. ID = 0, createNew = false → saveUpdate()
		    TestClient c1 = new TestClient(ctx, 0, false, trxName);
		    assertTrue(c1.save());
		    assertTrue(c1.saveUpdateCalled);
	
		    // 2. ID = 0, createNew = true → super.save()
		    TestClient c2 = new TestClient(ctx, 0, true, trxName);
		    c2.setValue("SAVE_TEST_2");
		    c2.setName("Save Test 2");
	
		    assertTrue(c2.save());
		    assertFalse(c2.saveUpdateCalled);
		    assertTrue(c2.get_ID() > 0);
	
		    // 3. ID > 0, createNew = false → super.save()
		    TestClient c3 = new TestClient(ctx, 0, true, trxName);
		    c3.setValue("SAVE_TEST_3");
		    c3.setName("Save Test 3");
		    c3.saveEx(); // now ID > 0
	
		    c3.saveUpdateCalled = false;
		    assertTrue(c3.save());
		    assertFalse(c3.saveUpdateCalled);
	
		    // 4. ID > 0, createNew = true → super.save()
		    TestClient c4 = new TestClient(ctx, 0, true, trxName);
		    c4.setValue("SAVE_TEST_4");
		    c4.setName("Save Test 4");
		    c4.saveEx(); // persist
	
		    c4.saveUpdateCalled = false;
		    assertTrue(c4.save());
		    assertFalse(c4.saveUpdateCalled);
	    } finally {
	    	rollback();
	    	PO.clearCrossTenantSafe();
	    }
	}
	
	/**
	 * Test cases for MClient.sendEMailAttachments methods
	 */
	@Test
	public void testSendEMailAttachmentsMethods() {
	    Properties ctx = Env.getCtx();
	    String trxName = getTrxName();

	    class TestClient extends MClient {
	        private static final long serialVersionUID = -471196445892408687L;
			boolean createEmailReturnsNull = false;
	        boolean sendThrowsException = false;

	        TestClient(Properties ctx) {
	            super(ctx, 0, true, trxName);
	            setValue("MAIL_TEST");
	            setName("Mail Test Client");
	        }

	        @Override
	        public EMail createEMail(MUser from, MUser to,
	                String subject, String message, boolean html) {
	            if (createEmailReturnsNull)
	                return null;
	            return new EMail(this, "from@test.com", "to@test.com", subject, message, html);
	        }

	        @Override
	        public boolean sendEmailNow(MUser from, MUser to, EMail email) {
	            if (sendThrowsException)
	                throw new RuntimeException("SMTP failure");
	            return true;
	        }
	    }
	    
	    TestClient client = null;
	    MUser to = null;
	    MUser from = null;
	    try {
	    	PO.setCrossTenantSafe();
	    	client = new TestClient(ctx);
	
		    to = new MUser(ctx, 0, trxName);
		    to.setName("Recipient");
		    to.setEMail("to@test.com");
		    to.saveEx();
	
		    from = new MUser(ctx, 0, trxName);
		    from.setName("Sender");
		    from.setEMail("from@test.com");
		    from.saveEx();
		    
		    commit();
	
		    File attachment = new File("test.txt");
		    List<File> list = List.of(attachment);
		    Collection<File> collection = List.of(attachment);
	
		    // sendEMailAttachments(int, ...)
		    assertTrue(client.sendEMailAttachments(to.getAD_User_ID(), "S", "M", collection));
		    assertTrue(client.sendEMailAttachments(to.getAD_User_ID(), "S", "M", collection, true));
	
		    // createEMail returns null
		    client.createEmailReturnsNull = true;
		    assertFalse(client.sendEMailAttachments(to.getAD_User_ID(), "S", "M", collection));
		    client.createEmailReturnsNull = false;
	
		    // send throws exception
		    client.sendThrowsException = true;
		    assertFalse(client.sendEMailAttachments(to.getAD_User_ID(), "S", "M", collection));
		    client.sendThrowsException = false;
	
		    // sendEMailAttachments(MUser from, MUser to, ...)
		    assertTrue(client.sendEMailAttachments(from, to, "S", "M", list));
		    assertTrue(client.sendEMailAttachments(from, to, "S", "M", list, true));
	
		    // null attachments
		    assertTrue(client.sendEMailAttachments(from, to, "S", "M", (List<File>) null));
	
		    // empty attachments
		    assertTrue(client.sendEMailAttachments(from, to, "S", "M", new ArrayList<>()));
	
		    // createEMail returns null
		    client.createEmailReturnsNull = true;
		    assertFalse(client.sendEMailAttachments(from, to, "S", "M", list));
		    client.createEmailReturnsNull = false;
	
		    // send throws exception
		    client.sendThrowsException = true;
		    assertFalse(client.sendEMailAttachments(from, to, "S", "M", list));
		    client.sendThrowsException = false;
	    } finally {
	    	PO.clearCrossTenantSafe();
	    	
	    	if (from != null && from.get_ID() > 0)
	    		from.deleteEx(true, null);
	    	if (to != null && to.get_ID() > 0)
	    		to.deleteEx(true, null);
	    	if (client != null && client.get_ID() > 0) {
		    	String sql = "DELETE FROM AD_Client WHERE AD_Client_ID=?";
		    	DB.executeUpdateEx(sql, new Object[] {client.get_ID()}, null);
	    	}
	    }
	}
	
	/**
	 * Test cases for MClient.setupClientInfo(String)
	 * @throws Exception
	 */
	@Test
	public void testSetupClientInfo() throws Exception {
		MClient client1 = null;
		MClient client2 = null;
		try {
	    	PO.setCrossTenantSafe();
	    	
		    client1 = new MClient(Env.getCtx(), 0, true, getTrxName());
		    client1.setValue("TEST_CLIENT1");
		    client1.setName("Test Client 1");
		    client1.saveEx();
		    
		    client2 = new MClient(Env.getCtx(), 0, true, getTrxName());
		    client2.setValue("TEST_CLIENT2");
		    client2.setName("Test Client 2");
		    client2.saveEx();
		    
		    commit();
		
		    // Base language path
		    boolean resultBase = client1.setupClientInfo(Language.getBaseAD_Language());
		    assertTrue(resultBase);
		    assertTrue(client1.getSetup_AD_Tree_Account_ID() > 0);
		    assertNotNull(client1.getInfo());
		
		    // Non-base language path
		    boolean resultNonBase = client2.setupClientInfo("es_CO");
		    assertTrue(resultNonBase);
		    assertTrue(client2.getSetup_AD_Tree_Account_ID() > 0);
		    assertNotNull(client2.getInfo());
		
		    // Verify tree IDs are assigned
		    assertTrue(client2.getSetup_AD_Tree_Account_ID() > 0);
		
		    // Verify ClientInfo is created
		    MClientInfo info = client2.getInfo();
		    assertNotNull(info);
		    assertTrue(info.getAD_Tree_Org_ID() > 0);
		    assertTrue(info.getAD_Tree_BPartner_ID() > 0);
		} finally {
			rollback();
			
			PO.clearCrossTenantSafe();
			
			if (client1 != null && client1.get_ID() > 0) {
		    	String sql = "DELETE FROM AD_Client WHERE AD_Client_ID=?";
		    	DB.executeUpdateEx(sql, new Object[] {client1.get_ID()}, null);
	    	}
			if (client2 != null && client2.get_ID() > 0) {
		    	String sql = "DELETE FROM AD_Client WHERE AD_Client_ID=?";
		    	DB.executeUpdateEx(sql, new Object[] {client2.get_ID()}, null);
	    	}
		}
	}
	
}
