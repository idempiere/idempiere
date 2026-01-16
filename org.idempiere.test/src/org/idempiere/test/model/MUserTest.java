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
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Properties;

import javax.mail.internet.InternetAddress;

import org.compiere.model.MClient;
import org.compiere.model.MForm;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.MUserBPAccess;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_C_BPartner;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * Comprehensive JUnit 5 tests for {@link MUser}.
 */
public class MUserTest extends AbstractTestCase {

	private static int USER_ID = DictionaryIDs.AD_User.SUPER_USER.id;
	private static String USER_UU;
	
	@BeforeAll
	public static void beforeAll()
	{
		USER_UU = DB.getSQLValueString(null, "SELECT AD_User_UU FROM AD_User WHERE AD_User_ID=?", USER_ID);
		assertNotNull(USER_UU, "User UUID should not be null");
	}
	
	/**
	 * Test construction of MUser by ID.
	 */
	@Test
	public void testConstructorById()
	{
		MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
		assertEquals(USER_ID, user.getAD_User_ID(), "User ID should match the expected ID");
		assertEquals(USER_UU, user.getAD_User_UU(), "User UUID should match the expected UUID");
	}

	/**
	 * Test construction of MUser using UUID.
	 */
	@Test
	public void testConstructorByUUID()
	{
		MUser user = new MUser(Env.getCtx(), USER_UU, getTrxName());
		assertEquals(USER_ID, user.getAD_User_ID(), "User ID resolved from UUID should match expected ID");
	}

	/**
	 * Test if the user is active.
	 */
	@Test
	public void testIsActive()
	{
		MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
		assertTrue(user.isActive(), "User should be active");
	}

	/**
	 * Test cases for MUser.getRoles(int)
	 */
	@Test
	public void testGetRoles()
	{
		int userId = Env.getAD_User_ID(Env.getCtx());		
		int orgId = Env.getAD_Org_ID(Env.getCtx());
		int roleId = Env.getAD_Role_ID(Env.getCtx());
		MUser user = new MUser(Env.getCtx(), userId, getTrxName());
		MRole[] roles = user.getRoles(orgId);
		assertNotNull(roles, "Roles array should not be null");
		assertTrue(roles.length > 0, "User should have at least one role assigned");
		assertTrue(Arrays.stream(user.getRoles(orgId)).anyMatch(r -> r.getAD_Role_ID() == roleId), 
				"User roles for org " + orgId + " should contain role ID " + roleId);
	}

	/**
	 * Test caching of MUser objects.
	 */
	@Test
	public void testUserCache()
	{
		MUser user1 = MUser.get(Env.getCtx(), USER_ID);
		MUser user2 = MUser.get(Env.getCtx(), USER_ID);
		assertSame(user1, user2, "Repeated retrieval of user should return the cached instance");
	}

	/**
	 * Test email retrieval for a user.
	 */
	@Test
	public void testEmail()
	{
		MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
		assertNotNull(user.getEMail(), "User email should not be null");
		assertTrue(user.getEMail().contains("@"), "User email should contain '@'");
	}

	/**
	 * Test summary information methods like getName() and toString().
	 */
	@Test
	public void testSummary()
	{
		MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
		assertNotNull(user.getName(), "User name should not be null");
		assertTrue(user.getName().length() > 0, "User name should have non-zero length");
		assertNotNull(user.toString(), "User toString() should not be null");
	}

	/**
	 * Test cases for MUser.isEMailValid()
	 */
	@Test
	public void testIsEmailValid() {
		MUser user = new MUser(MUser.get(getAD_User_ID()));
		user.setEMail(null);
		
		assertFalse(user.isEMailValid(), "IsEmailValid=true for null email");
		
		user.setEMail("admin @ idempiere.org");
		assertFalse(user.isEMailValid(), "IsEmailValid=true for email=admin @ idempiere.org");
		
		user.setEMail("admin@idempiere.org");
		assertTrue(user.isEMailValid(), "IsEmailValid=false for email=admin@idempiere.org");
		
		user.setEMail("admin");
		assertFalse(user.isEMailValid(), "IsEmailValid=true for email=admin");
	}
	
	/**
	 * Test cases for MUser.get(Properties)
	 */
	@Test
	public void testGetUser()
	{
		int ctxUserId = Env.getAD_User_ID(Env.getCtx());
		assertTrue(ctxUserId > 0, "Context must contain a valid AD_User_ID");
		MUser user = MUser.get(Env.getCtx());
		assertNotNull(user, "MUser.get(ctx) should return a user when AD_User_ID is set");
		assertEquals(ctxUserId, user.getAD_User_ID(), "Returned user must match AD_User_ID from context");
	}
	
	/**
	 * Test cases for MUser.get(Properties, int)
	 */
	@Test
	public void testGetUserById()
	{
		Properties ctx = Env.getCtx();
		
		// 1. Existing user should be loaded correctly
		MUser user = MUser.get(ctx, USER_ID);
		assertNotNull(user, "Existing user must be returned");
		assertEquals(USER_ID, user.getAD_User_ID(), "Returned user must match requested AD_User_ID");

		// 2. Same user ID should return cached instance
		MUser cachedUser = MUser.get(ctx, USER_ID);
		assertSame(user, cachedUser, "Second call must return the cached MUser instance");

		// 3. Non-existing user ID should return null or invalid user
		int nonExistingUserId = -999999;
		MUser nonExisting = MUser.get(ctx, nonExistingUserId);
		assertNull(nonExisting, "Non-existing AD_User_ID must not return a valid user");

		// 4. Deprecated system user must be loadable explicitly
		int deprecatedSystemUserId = SystemIDs.USER_SYSTEM_DEPRECATED;
		MUser deprecatedSystemUser = MUser.get(ctx, deprecatedSystemUserId);
		assertNotNull(deprecatedSystemUser, "Deprecated system user must be loadable");
		assertEquals(deprecatedSystemUserId, deprecatedSystemUser.getAD_User_ID(), "Deprecated system user ID must match constant");
	}
	
	/**
	 * Test cases for MUser.get(Properties, String)
	 */
	@Test
	public void testGetUserByName()
	{
		Properties ctx = Env.getCtx();

		// 1. Null name → must return null
		MUser nullNameUser = MUser.get(ctx, (String) null);
		assertNull(nullNameUser, "Null user name must return null");

		// 2. Empty name → must return null
		MUser emptyNameUser = MUser.get(ctx, "");
		assertNull(emptyNameUser, "Empty user name must return null");

		// 3. Valid user lookup (System user)
		String systemUserName = DB.getSQLValueString(getTrxName(), "SELECT Name FROM AD_User WHERE AD_User_ID=?", Env.getAD_User_ID(ctx));
		assertNotNull(systemUserName, "System user name must exist in DB");

		MUser systemUser = MUser.get(ctx, systemUserName);
		assertNotNull(systemUser, "Existing active user with role must be returned");
		assertEquals(Env.getAD_User_ID(ctx), systemUser.getAD_User_ID(), "Returned user must match the logged-in user");

		// 4. Non-existing name → must return null
		String nonExistingName = "___NON_EXISTING_USER___";
		MUser nonExistingUser = MUser.get(ctx, nonExistingName);
		assertNull(nonExistingUser, "Non-existing user name must return null");
	}
	
	/**
	 * Test cases for MUser.get(Properties, String, String)
	 */
	@Test
	public void testGetUserByNameAndPassword()
	{
		Properties ctx = Env.getCtx();

		// 1. Null name → must return null
		MUser nullNameUser = MUser.get(ctx, null, "anyPassword");
		assertNull(nullNameUser, "Null user name must return null");

		// 2. Empty name → must return null
		MUser emptyNameUser = MUser.get(ctx, "", "anyPassword");
		assertNull(emptyNameUser, "Empty user name must return null");

		// 3. Resolve a valid user name for testing (System user)
		int systemUserId = Env.getAD_User_ID(ctx);
		assertTrue(systemUserId > 0, "System user ID must be available");
		String systemUserName = DB.getSQLValueString(getTrxName(), "SELECT Name FROM AD_User WHERE AD_User_ID=?", systemUserId);
		assertNotNull(systemUserName, "System user name must exist");

		// 4. Valid name + WRONG password → must return null
		MUser wrongPasswordUser = MUser.get(ctx, systemUserName, "___WRONG_PASSWORD___");
		assertNull(wrongPasswordUser, "Valid user name with wrong password must return null");

		// 5. Non-existing user → must return null
		MUser nonExistingUser = MUser.get(ctx, "___NON_EXISTING_USER___", "anyPassword");
		assertNull(nonExistingUser, "Non-existing user must return null");
	}
	
	/**
	 * Test cases for MUser.get(Properties, String, String, boolean)
	 */
	@Test
	public void testGetUserByNamePasswordSSO()
	{
	    Properties ctx = Env.getCtx();

	    // 1. Null name → must return null
	    MUser nullNameUser = MUser.get(ctx, null, "anyPassword", false);
	    assertNull(nullNameUser, "Null name must return null");

	    // 2. Empty name → must return null
	    MUser emptyNameUser = MUser.get(ctx, "", "anyPassword", false);
	    assertNull(emptyNameUser, "Empty name must return null");

	    // 3. Null password when not SSO → must return null
	    MUser nullPasswordUser = MUser.get(ctx, "System", null, false);
	    assertNull(nullPasswordUser, "Null password (non-SSO) must return null");

	    // 4. Empty password when not SSO → must return null
	    MUser emptyPasswordUser = MUser.get(ctx, "System", "", false);
	    assertNull(emptyPasswordUser, "Empty password (non-SSO) must return null");

	    // 5. SSO login → password ignored, should return user if exists
	    MUser ssoUser = MUser.get(ctx, "System", null, true);
	    assertNotNull(ssoUser, "SSO login must bypass password and return user");
	    assertEquals("System", ssoUser.getName(), "SSO user must match requested name");

	    // 6. Non-existing user → must return null
	    MUser nonExistingUser = MUser.get(ctx, "___NON_EXISTING_USER___", "anyPassword", false);
	    assertNull(nonExistingUser, "Non-existing user must return null");

	    // 7. Invalid password → must return null
	    MUser wrongPasswordUser = MUser.get(ctx, "System", "___WRONG_PASSWORD___", false);
	    assertNull(wrongPasswordUser, "Wrong password must return null");

	    // 8. Delegation path: plain password
	    MUser user = new MUser(ctx, Env.getAD_User_ID(ctx), getTrxName());
	    String password = user.getPassword(); // assume plain text available
	    if (!Util.isEmpty(password)) {
	        MUser plainPassUser = MUser.get(ctx, user.getName(), password, false);
	        assertNotNull(plainPassUser, "Plain password must authenticate user");
	        assertEquals(user.getAD_User_ID(), plainPassUser.getAD_User_ID(), "Authenticated user ID must match");
	    }

	    // 9. Delegation path: SSO login bypass
	    MUser ssoBypass = MUser.get(ctx, user.getName(), "ignored", true);
	    assertNotNull(ssoBypass, "SSO login bypass must succeed regardless of password");
	    assertEquals(user.getAD_User_ID(), ssoBypass.getAD_User_ID(), "SSO user ID must match");
	}
	
	/**
	 * Test cases for MUser.getNameOfUser(int)
	 */
	@Test
	public void testGetNameOfUser()
	{
	    // 1. Valid user ID → should return correct user name
	    int validUserID = Env.getAD_User_ID(Env.getCtx());
	    String userName = MUser.getNameOfUser(validUserID);
	    assertNotNull(userName, "Valid user ID must return a non-null name");
	    assertTrue(userName.length() > 0, "Valid user ID must return non-empty name");

	    // 2. Non-existing user ID → should return "?"
	    int nonExistingUserID = -1;
	    String unknownUserName = MUser.getNameOfUser(nonExistingUserID);
	    assertEquals("?", unknownUserName, "Non-existing user ID must return '?'");
	}
	
	/**
	 * Test cases for MUser.getOfBPartner(Properties, int, String)
	 */
	@Test
	public void testGetOfBPartner()
	{
	    // 1. Existing Business Partner with users
		int existingBPartnerID = DictionaryIDs.C_BPartner.GARDEN_USER.id;
	    MUser[] users = MUser.getOfBPartner(Env.getCtx(), existingBPartnerID, getTrxName());
	    assertNotNull(users, "Result array must not be null");
	    assertTrue(users.length > 0, "There should be at least one active user for the Business Partner");
	    for (MUser user : users) {
	        assertEquals(existingBPartnerID, user.getC_BPartner_ID(), "User must belong to the specified Business Partner");
	        assertTrue(user.isActive(), "Only active users should be returned");
	    }

	    // 2. Business Partner with no users → should return empty array
	    int noUserBPartnerID = DictionaryIDs.C_BPartner.COLOR_INC.id;
	    MUser[] emptyUsers = MUser.getOfBPartner(Env.getCtx(), noUserBPartnerID, getTrxName());
	    assertNotNull(emptyUsers, "Result array must not be null even if no users");
	    assertEquals(0, emptyUsers.length, "Business Partner with no users should return empty array");

	    // 3. Non-existing Business Partner → should return empty array
	    int nonExistingBPartnerID = -1;
	    MUser[] nonExisting = MUser.getOfBPartner(Env.getCtx(), nonExistingBPartnerID, getTrxName());
	    assertNotNull(nonExisting, "Result array must not be null for non-existing BP");
	    assertEquals(0, nonExisting.length, "Non-existing Business Partner should return empty array");
	}
	
	/**
	 * Test cases for MUser.getWithRole(MRole)
	 */
	@Test
	public void testGetWithRole()
	{
	    int existingRoleID = Env.getAD_Role_ID(Env.getCtx());
	    assertTrue(existingRoleID > 0, "Should have an existing role with users");
	    MRole role = MRole.get(Env.getCtx(), existingRoleID);
	    MUser[] users = MUser.getWithRole(role);
	    assertNotNull(users, "Result array must not be null");
	    assertTrue(users.length > 0, "There should be at least one active user for the role");
	    for (MUser user : users) {
	        assertTrue(user.isActive(), "Only active users should be returned");
	        boolean hasRole = false;
	        for (MRole ur : user.getRoles(Env.getAD_Org_ID(Env.getCtx()))) {
	            if (ur.getAD_Role_ID() == existingRoleID) {
	                hasRole = true;
	                break;
	            }
	        }
	        assertTrue(hasRole, "User must have the specified role assigned");
	    }
	}
	
	/**
	 * Test cases for MUser.getWithRoleKeyNamePairs(boolean, String)
	 */
	@Test
	public void testGetWithRoleKeyNamePairs()
	{
	    // 1. Without empty element
	    KeyNamePair[] pairs = MUser.getWithRoleKeyNamePairs(false, getTrxName());
	    assertNotNull(pairs, "Result array must not be null");
	    assertTrue(pairs.length > 0, "There should be at least one user with a role");
	    for (KeyNamePair pair : pairs) {
	        assertTrue(pair.getKey() > 0, "Key must be valid AD_User_ID");
	        assertNotNull(pair.getName(), "Name must not be null");
	        assertTrue(pair.getName().length() > 0, "Name must not be empty");
	    }

	    // 2. With empty element
	    KeyNamePair[] pairsWithEmpty = MUser.getWithRoleKeyNamePairs(true, getTrxName());
	    assertNotNull(pairsWithEmpty, "Result array must not be null");
	    assertTrue(pairsWithEmpty.length >= pairs.length, "Result array with empty element should be larger or equal in size");
	    assertEquals("", pairsWithEmpty[0].getName(), "First element should be empty string when withEmptyElement is true");
	    assertEquals(-1, pairsWithEmpty[0].getKey(), "Key of empty element should be -1");
	}
	
	/**
	 * Test cases for MUser.isSalesRep(int)
	 */
	@Test
	public void testIsSalesRep()
	{
	    // 1. User ID = 0 should always return false
	    assertFalse(MUser.isSalesRep(0), "User ID 0 should not be a SalesRep");

	    // 2. Existing user linked to SalesRep BP
	    int salesRepUserId = DictionaryIDs.AD_User.GARDEN_ADMIN.id;
	    assertTrue(MUser.isSalesRep(salesRepUserId), "User linked to SalesRep BP should return true");

	    // 3. Existing user NOT linked to SalesRep BP
	    int nonSalesRepUserId = DictionaryIDs.AD_User.SUPER_USER.id;
	    assertFalse(MUser.isSalesRep(nonSalesRepUserId), "User not linked to SalesRep BP should return false");
	}
	
	/**
	 * Test cases for MUser(X_C_BPartner)
	 */
	@Test
	public void testConstructorWithBPartner()
	{
	    X_C_BPartner partner = new X_C_BPartner(Env.getCtx(), DictionaryIDs.C_BPartner.STANDARD.id, getTrxName());
	    MUser user = new MUser(partner);
	    assertNotNull(user, "MUser instance should be created from BPartner");
	    assertEquals(partner.getAD_Client_ID(), user.getAD_Client_ID(), "MUser client should match BPartner client");
	    assertEquals(partner.getAD_Org_ID(), user.getAD_Org_ID(), "MUser org should match BPartner org");
	    assertEquals(partner.getC_BPartner_ID(), user.getC_BPartner_ID(), "MUser BPartner ID should match the partner");
	    assertEquals(partner.getName(), user.getName(), "MUser name should be set from BPartner name");
	}
	
	/**
	 * Test cases for MUser.addDescription(String)
	 */
	@Test
	public void testAddDescription()
	{
	    MUser user = new MUser(Env.getCtx(), 0, getTrxName());

	    // Initial description is null
	    assertNull(user.getDescription(), "Initial description should be null");

	    // Adding null description should not change anything
	    user.addDescription(null);
	    assertNull(user.getDescription(), "Description should remain null when adding null");

	    // Adding empty description should not change anything
	    user.addDescription("");
	    assertNull(user.getDescription(), "Description should remain null when adding empty string");

	    // Adding first description
	    user.addDescription("First description");
	    assertEquals("First description", user.getDescription(), "Description should be set when initially null");

	    // Adding a second description should append with ' - '
	    user.addDescription("Second description");
	    assertEquals("First description - Second description", user.getDescription(), 
	    		"Description should append with ' - ' when already set");

	    // Adding another description
	    user.addDescription("Third description");
	    assertEquals("First description - Second description - Third description", user.getDescription(), 
	    		"Subsequent descriptions should continue appending with ' - '");
	}
	
	/**
	 * Test cases for MUser.beforeSave(boolean)
	 */
	@Test
	public void testBeforeSave() throws Exception {
		try {
		    MUser user = new MUser(Env.getCtx(), 0, getTrxName());
		    
		    // Case 1: New record with valid email
		    user.setName("TestUser");
		    user.setEMail("test@example.com");
		    user.setPassword("test123");
		    assertTrue(user.save(), "New record with valid email should pass beforeSave");
		    
		    // Case 2: Existing record with email change invalidates previous verification
		    user.setEMailVerifyDate(new Timestamp(System.currentTimeMillis()));
		    user.setEMail("new@example.com");
		    user.saveEx();
		    assertNull(user.getEMailVerifyDate(), "Changing email should reset EMailVerifyDate");
	
		    // Case 3: Invalid email format
		    user.setEMail("invalid-email");
		    assertFalse(user.save(), "Invalid email format should return false");
	
		    // Case 4: New record with empty password should pass
		    user = new MUser(Env.getCtx(), 0, getTrxName());
		    user.setName("TestUser");
		    user.setEMail("testUser@example.com");
		    user.setPassword(null);
		    assertTrue(user.save(), "New record with no password should pass");
		} finally {
			rollback();
		}
	}
	
	/**
	 * Test cases for MUser.getEMailUser() and MUser.getEMailUserPW()
	 */
	@Test
	public void testGetEMailUserAndGetEmailUserPW() {
	    MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
	    assertNotNull(user, "User instance must be created");	    
	    MClient systemClient = MClient.get(Env.getCtx(), 0);
	    assertNotNull(systemClient, "System client must exist");
	    MClient client = MClient.get(Env.getCtx());
	    assertNotNull(client, "Client must exist");
	    MSysConfig config = null;
	    try {
	        // Case 1: System credentials enabled
			config = new MSysConfig(Env.getCtx(), 0, getTrxName());
			config.setName(MSysConfig.MAIL_SEND_CREDENTIALS);
			config.setValue("S");
			config.setAD_Org_ID(0);
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
			
	        String systemUser = user.getEMailUser();
	        assertEquals(systemClient.getRequestUser(), systemUser, "When system credentials are enabled, system request user must be returned");
	        String systemUserPW = user.getEMailUserPW();
	        assertEquals(systemClient.getRequestUserPW(), systemUserPW, "When system credentials are enabled, system request user password must be returned");

	        // Case 2: Client credentials enabled
			config.setValue("C");
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);

	        String clientUser = user.getEMailUser();
	        assertEquals(client.getRequestUser(), clientUser, "When client credentials are enabled, client request user must be returned");
	        String clientUserPW = user.getEMailUserPW();
	        assertEquals(client.getRequestUserPW(), clientUserPW, "When client credentials are enabled, client request user password must be returned");

	        // Case 3: No credential flags enabled → fallback behavior
	        config.setValue("U");
			config.saveEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
			
			// Retrieve expected fallback values directly from the superclass methods
			String expectedFallbackUser = DB.getSQLValueString(getTrxName(), "SELECT EMailUser FROM AD_User WHERE AD_User_ID=?", USER_ID);
			String fallbackUser = user.getEMailUser();
			assertEquals(expectedFallbackUser, fallbackUser, "When no credential flags are enabled, fallback email user must be returned");
			String expectedFallbackUserPW = DB.getSQLValueString(getTrxName(), "SELECT EMailUserPW FROM AD_User WHERE AD_User_ID=?", USER_ID);
			String fallbackUserPW = user.getEMailUserPW();
			assertEquals(expectedFallbackUserPW, fallbackUserPW, "When no credential flags are enabled, fallback email user password must be returned");
	    } finally {
	        rollback();
	        
	        if (config != null && config.get_ID() > 0)
    			config.deleteEx(true, null);
	    }
	}
	
	/**
	 * Test cases for MUser.getEMailVerifyCode()
	 */
	@Test
	public void testGetEMailVerifyCode() {
	    MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
	    assertNotNull(user, "User instance must be created");
	    int userId = user.getAD_User_ID();
	    assertTrue(userId > 0, "User must have a valid AD_User_ID");
	    String userName = user.getName();
	    assertNotNull(userName, "User name must not be null");

	    String verifyCode1 = user.getEMailVerifyCode();
	    String verifyCode2 = user.getEMailVerifyCode();
	    assertNotNull(verifyCode1, "Verification code must not be null");
	    assertTrue(verifyCode1.length() > 2, "Verification code must contain numeric payload");
	    assertTrue(verifyCode1.startsWith("C"), "Verification code must start with 'C'");
	    assertTrue(verifyCode1.endsWith("C"), "Verification code must end with 'C'");

	    long expectedCodeValue = Math.abs(userId + userName.hashCode());
	    String expectedCode = "C" + expectedCodeValue + "C";
	    assertEquals(expectedCode, verifyCode1, "Verification code must be calculated using AD_User_ID + name hash");
	    assertEquals(verifyCode1, verifyCode2, "Verification code must be stable across multiple invocations");
	}
	
	/**
	 * Test cases for MUser.getFirstName() and MUser.getLastName()
	 */
	@Test
	public void testGetFirstNameAndLastName() {
		try {
		    MUser user = new MUser(Env.getCtx(), 0, getTrxName());
		    assertNotNull(user, "User instance must be created");
		    user.setName("Elaine Tan");
		    user.saveEx();
	
		    String firstNameMulti = user.getFirstName();
		    assertEquals("Elaine", firstNameMulti, "First name should be extracted from the beginning of the full name");
		    assertEquals(firstNameMulti, user.getFirstName(), "First name must be stable across multiple invocations");
		    String lastNameMulti = user.getLastName();
		    assertEquals("Tan", lastNameMulti, "Last name should be extracted from the end of the full name");
		    assertEquals(lastNameMulti, user.getLastName(), "Last name must be stable across multiple invocations");
		    
		    user.setName("Elaine");
		    user.saveEx();
		    String firstNameSingle = user.getFirstName();
		    assertEquals("Elaine", firstNameSingle, "Single-word name should return the same value as the first name");
		    String lastNameSingle = user.getLastName();
		    assertEquals("", lastNameSingle, "Single-word name should return empty value as the last name");
		} finally {
			rollback();
		}
	}
	
	/**
	 * Test cases for MUser.getInternetAddress()
	 */
	@Test
    public void testInternetAddress() {
        MUser user = new MUser(Env.getCtx(), 0, getTrxName());

        // Case 1: Null email
        user.setEMail(null);
        InternetAddress ia = user.getInternetAddress();
        assertNull(ia, "Null email should result in null InternetAddress");

        // Case 2: Empty email
        user.setEMail("");
        ia = user.getInternetAddress();
        assertNull(ia, "Empty email should result in null InternetAddress");

        // Case 3: Valid email
        String validEmail = "elaine.tan@example.com";
        user.setEMail(validEmail);
        ia = user.getInternetAddress();
        assertNotNull(ia, "Valid email should return a non-null InternetAddress");
        assertEquals(validEmail, ia.getAddress(), "InternetAddress should contain the correct email string");

        // Case 4: Invalid email format
        user.setEMail("invalid-email-format");
        ia = user.getInternetAddress();
        assertNull(ia, "Invalid email format should result in null InternetAddress");
    }
	
	/**
	 * Test cases for MUser.getValue() and MUser.setValue(String)
	 */
	@Test
    public void testGetAndSetValue() {
        MUser user = new MUser(Env.getCtx(), 0, getTrxName());
        
        // getValue with existing value
        user.set_ValueNoCheck("Value", "TestVal");
        String val = user.getValue();
        assertEquals("TestVal", val, "getValue should return the existing value");

        // setValue with normal string
        user.setValue("Normal");
        val = user.getValue();
        assertEquals("normal", val, "setValue should clean value to lowercase");

        // setValue with null -> fallback to LDAPUser/Name/noname
        user.setValue(null);
        val = user.getValue();
        assertNotNull(val, "setValue with null should generate fallback value (LDAPUser, Name, or 'noname')");

        // setValue with empty string -> fallback
        user.setValue("   ");
        val = user.getValue();
        assertNotNull(val, "setValue with whitespace should generate fallback value");

        // setValue with long string > 8 characters
        String longName = "FirstnameLastname";
        user.setName(longName); // used for fallback logic
        user.setValue(longName);
        val = user.getValue();
        assertTrue(val.length() <= 8, "setValue should truncate long values to max 8 chars");
        assertNotEquals(longName, val, "Long value should be transformed");

        // setValue with single-word name fallback
        user.setName("SingleWord");
        user.setValue(null);
        val = user.getValue();
        assertNotNull(val, "Fallback value from single-word name should not be null");
        assertTrue(val.length() <= 8, "Fallback truncated value should be max 8 characters");
    }
	
	/**
	 * Test cases for MUser.getBPAccess(boolean) and MUser.hasBPAccess(String, Object[])
	 */
	@Test
    public void testGetAndHasBPAccess() throws Exception {
		MUser user = null;
		MUserBPAccess userBPAccess = null;
		try {
	        user = new MUser(Env.getCtx(), 0, getTrxName());
		    user.setName("Test User");
		    user.saveEx();
	
	        // Case 1: m_bpAccess is null, empty database result
	        MUserBPAccess[] access = user.getBPAccess(true);
	        assertNotNull(access, "Should return an array, even if empty");
	        assertEquals(0, access.length, "Initially, there should be no BP access records");
	
	        // Case 2: m_bpAccess not null, requery false
	        MUserBPAccess[] cached = user.getBPAccess(false);
	        assertSame(access, cached, "Should return cached m_bpAccess when requery is false");
	        
	        // Case 3: Full BP access enabled
	        user.setIsFullBPAccess(true);
	        assertTrue(user.hasBPAccess(MUserBPAccess.BPACCESSTYPE_Requests, null), "User with full BP access should return true");

	        // Case 4: Full BP access disabled, no m_bpAccess
	        user.setIsFullBPAccess(false);
	        access = user.getBPAccess(true);
	        assertNotNull(access, "BP access array should be initialized");
	
	        // Case 5: m_bpAccess non-empty, add a BP access with matching type
	        userBPAccess = new MUserBPAccess(user.getCtx(), 0, getTrxName());
	        userBPAccess.setAD_User_ID(user.getAD_User_ID());
	        userBPAccess.setIsActive(true);
	        userBPAccess.setBPAccessType(MUserBPAccess.BPACCESSTYPE_Requests);
	        userBPAccess.saveEx();
	        
	        commit();
	
	        MUserBPAccess[] requeryAccess = user.getBPAccess(true);
	        assertNotNull(requeryAccess, "Requery should return array with BP access");
	        assertTrue(requeryAccess.length > 0, "Requery should return at least one BP access");
	        assertTrue(user.hasBPAccess(MUserBPAccess.BPACCESSTYPE_Requests, null), "User should have access to existing BPAccessType");

	        // Case 6: Check for non-existing BPAccessType
	        assertFalse(user.hasBPAccess(MUserBPAccess.BPACCESSTYPE_AssetsDownload, null), "User should not have access to non-existing BPAccessType");        
		} finally {
			if (userBPAccess != null && userBPAccess.get_ID() > 0)
				userBPAccess.deleteEx(true, null);
			if (user != null && user.get_ID() > 0)
				user.deleteEx(true, null);
		}
    }
	
	/**
	 * Test cases for MUser.hasURLFormAccess(String)
	 */
	@Test
    public void testHasURLFormAccess() {
		try {
	        MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
	
	        // Case 1: Empty URL
	        assertFalse(user.hasURLFormAccess(null), "Null URL should return false");
	        assertFalse(user.hasURLFormAccess(""), "Empty URL should return false");
	
	        // Case 2: URL not matching any active form
	        String fakeURL = "com.example.NonExistingForm";
	        assertFalse(user.hasURLFormAccess(fakeURL), "Non-existing form URL should return false");

	        // Case 3: URL matches a form and at least one role has access
	        MForm form = new MForm(Env.getCtx(), SystemIDs.FORM_ARCHIVEVIEWER, getTrxName());	
	        assertTrue(user.hasURLFormAccess(form.getClassname()), "User should have access if at least one role grants access");
		} finally {
			rollback();
		}
    }
	
	/**
	 * Test cases for MUser.isAdministrator();
	 */
	@Test
    public void testIsAdministrator() {
        // Case 1: No roles assigned
        MUser user = new MUser(Env.getCtx(), 0, getTrxName());
        assertFalse(user.isAdministrator(), "User with no roles should not be administrator");

        // Case 2: Roles assigned but none are system administrator
        user = new MUser(Env.getCtx(), DictionaryIDs.AD_User.GARDEN_ADMIN.id, getTrxName());
        assertFalse(user.isAdministrator(), "User with roles but not system admin should return false");

        // Case 3: Roles assigned with one as system administrator
        user = new MUser(Env.getCtx(), DictionaryIDs.AD_User.SUPER_USER.id, getTrxName());
        assertTrue(user.isAdministrator(), "User with system role should return true");
    }
	
	/**
	 * Test cases for MUser.isCanSendEMail()
	 */
	@Test
    public void testIsCanSendEMail() {
		MClient client = new MClient(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()), getTrxName());
		boolean originalIsStmpAuthorization = client.isSmtpAuthorization();
		MSysConfig sc = new Query(Env.getCtx(), MSysConfig.Table_Name, "AD_Client_ID=0 AND Name=?", getTrxName())
				.setParameters(MSysConfig.MAIL_SEND_CREDENTIALS)
				.first();
		String originalSysCfg = sc.getValue();
		try {
			sc.setValue("U");
			sc.saveCrossTenantSafeEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);

	        MUser user = new MUser(Env.getCtx(), 0, getTrxName());
	
	        // Case 1: getEMailUser() returns null
	        user.setEMailUser(null);
	        assertFalse(user.isCanSendEMail(), "Null EMail user should return false");
	
	        // Case 2: getEMailUser() returns empty string
	        user.setEMailUser("");
	        assertFalse(user.isCanSendEMail(), "Empty EMail user should return false");
	
	        // Case 3: SMTP authorization not required
	        client.setIsSmtpAuthorization(false);
	        client.saveEx(null);
	        CacheMgt.get().reset(MClient.Table_Name);
	        
	        user.setEMailUser("user@example.com");
	        assertTrue(user.isCanSendEMail(), "SMTP not required should return true");
	
	        // Case 4: SMTP authorization required, empty password
	        client.setIsSmtpAuthorization(true);
	        client.saveEx(null);
	        CacheMgt.get().reset(MClient.Table_Name);
	        
	        user.setEMailUser("user@example.com");
	        user.setEMailUserPW("");
	        assertFalse(user.isCanSendEMail(), "Empty SMTP password should return false");
	
	        // Case 5: SMTP authorization required, non-empty password
	        user.setEMailUser("user@example.com");
	        user.setEMailUserPW("secret");
	        assertTrue(user.isCanSendEMail(), "Non-empty SMTP password should return true");
		} finally {
			client.setIsSmtpAuthorization(originalIsStmpAuthorization);
	        client.saveEx(null);
	        CacheMgt.get().reset(MClient.Table_Name);
			sc.setValue(originalSysCfg);
			sc.saveCrossTenantSafeEx(null);
			CacheMgt.get().reset(MSysConfig.Table_Name);
		}
    }
	
	/**
	 * Test cases for MUser.isEMailVerified()
	 */
	@Test
    public void testIsEMailVerified() {
        MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());

        // Case 1: Both EMailVerifyDate and EMailVerify are set
        user.setEMailVerifyDate(new Timestamp(System.currentTimeMillis()));
        user.setEMailVerify("Direct");
        assertTrue(user.isEMailVerified(), "Both EMailVerifyDate and EMailVerify set should return true");

        // Case 2: EMailVerifyDate is null
        user.setEMailVerifyDate(null);
        user.setEMailVerify("Direct");
        assertFalse(user.isEMailVerified(), "Null EMailVerifyDate should return false");

        // Case 3: EMailVerify is null
        user.setEMailVerifyDate(new Timestamp(System.currentTimeMillis()));
        user.setEMailVerify(null);
        assertFalse(user.isEMailVerified(), "Null EMailVerify should return false");

        // Case 4: EMailVerify is empty string
        user.setEMailVerify("");
        assertFalse(user.isEMailVerified(), "Empty EMailVerify should return false");
    }
	
	/**
	 * Test cases for MUser.isMenuAutoExpand()
	 */
	@Test
    public void testIsMenuAutoExpand() {
        MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());

        // Case 1: getIsMenuAutoExpand() returns "Y"
        user.setIsMenuAutoExpand(MUser.ISMENUAUTOEXPAND_Yes);
        assertTrue(user.isMenuAutoExpand(), "IS_MENU_AUTO_EXPAND='Y' should return true");

        // Case 2: getIsMenuAutoExpand() returns "N"
        user.setIsMenuAutoExpand(MUser.ISMENUAUTOEXPAND_No);
        assertFalse(user.isMenuAutoExpand(), "IS_MENU_AUTO_EXPAND='N' should return false");

        // Case 3: getIsMenuAutoExpand() is null, uses MRole default
        user.setIsMenuAutoExpand(null);
        boolean expected = MRole.getDefault().isMenuAutoExpand();
        assertEquals(expected, user.isMenuAutoExpand(), "Null IS_MENU_AUTO_EXPAND should return MRole default");
    }
	
	/**
	 * Test cases for MUser.isNotificationEMail() and MUser.isNotificationNote()
	 */
	@Test
    public void testNotificationFlagsFullCoverage() {
        MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());

        // Case 1: notification type is null
        user.setNotificationType(null);
        assertTrue(user.isNotificationEMail(), "Null type should be treated as EMail");
        assertFalse(user.isNotificationNote(), "Null type should not be treated as Note");

        // Case 2: notification type = EMail
        user.setNotificationType(MUser.NOTIFICATIONTYPE_EMail);
        assertTrue(user.isNotificationEMail(), "EMail type should return true for isNotificationEMail");
        assertFalse(user.isNotificationNote(), "EMail type should return false for isNotificationNote");

        // Case 3: notification type = Notice
        user.setNotificationType(MUser.NOTIFICATIONTYPE_Notice);
        assertFalse(user.isNotificationEMail(), "Notice type should return false for isNotificationEMail");
        assertTrue(user.isNotificationNote(), "Notice type should return true for isNotificationNote");

        // Case 4: notification type = EMailPlusNotice
        user.setNotificationType(MUser.NOTIFICATIONTYPE_EMailPlusNotice);
        assertTrue(user.isNotificationEMail(), "EMailPlusNotice type should return true for isNotificationEMail");
        assertTrue(user.isNotificationNote(), "EMailPlusNotice type should return true for isNotificationNote");

        // Case 5: notification type = invalid/other
        user.setNotificationType("InvalidType");
        assertFalse(user.isNotificationEMail(), "Invalid type should return false for isNotificationEMail");
        assertFalse(user.isNotificationNote(), "Invalid type should return false for isNotificationNote");
    }
	
	/**
	 * Test cases for MUser.isOnline()
	 */
	@Test
    public void testIsOnline() {
        MUser user = new MUser(Env.getCtx(), 0, getTrxName());

        // Case 1: EMail = null, Password = null
        user.setEMail(null);
        user.setPassword(null);
        assertFalse(user.isOnline(), "Both EMail and Password null should return false");

        // Case 2: EMail set, Password = null
        user.setEMail("user@example.com");
        user.setPassword(null);
        assertFalse(user.isOnline(), "Password null should return false even if EMail is set");

        // Case 3: EMail = null, Password set
        user.setEMail(null);
        user.setPassword("secret");
        assertFalse(user.isOnline(), "EMail null should return false even if Password is set");

        // Case 4: Both EMail and Password set
        user.setEMail("user@example.com");
        user.setPassword("secret");
        assertTrue(user.isOnline(), "Both EMail and Password set should return true");
    }
	
	/**
	 * Test cases for MUser.setEMailVerifyCode(String, String)
	 */
	@Test
    public void testSetEMailVerifyCode() {
        MUser user = new MUser(Env.getCtx(), USER_ID, getTrxName());
        String correctCode = user.getEMailVerifyCode();
        String info = "TestInfo";

        // --- Case 1: Correct verification code ---
        boolean result = user.setEMailVerifyCode(correctCode, info);
        assertTrue(result, "Correct code should return true");
        assertNotNull(user.getEMailVerifyDate(), "EMailVerifyDate should be set when code matches");
        assertEquals(info, user.getEMailVerify(), "EMailVerify info should be set");

        // --- Case 2: Incorrect verification code ---
        result = user.setEMailVerifyCode("WRONGCODE", info);
        assertFalse(result, "Incorrect code should return false");
        assertNull(user.getEMailVerifyDate(), "EMailVerifyDate should be null when code does not match");
        assertEquals(info, user.getEMailVerify(), "EMailVerify info should still be set");
    }
		
}
