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
 * Contributors:                                                       *
 * - d-ruiz                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.sql.Timestamp;

import org.compiere.Adempiere;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCalendar;
import org.compiere.model.MClientInfo;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MElement;
import org.compiere.model.MGLCategory;
import org.compiere.model.MSetup;
import org.compiere.model.Query;
import org.compiere.model.X_C_AcctSchema_Element;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;

/**
 * @author d-ruiz
 *
 */
public class MSetupTest extends AbstractTestCase {
	
	private String trxName = null;

	/**
	 * 
	 */
	public MSetupTest() {
	}

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		//System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, 
				new Timestamp(System.currentTimeMillis()), Language.getLanguage("en_US"));
	}
	
	@Test
	public void testSetup() {
		String clientName = "JUnit_InitialClientSetupTest";
		String orgValue = "JUnitOrg";
		String orgName = "JUnit Org";
		
		MSetup setup = new MSetup(Env.getCtx(), 0, true);
		
		try {
			// Create client first
			boolean clientCreated = setup.createClient(
				clientName, 
				orgValue, 
				orgName, 
				"AdminUser", 
				"NormalUser",
				null, null, null, null, null,
				"admin@junit.org", 
				"user@junit.org",
				false // don't set initial password
			);
			assertTrue(clientCreated, "Client creation should succeed");
			
			trxName = setup.getTrxName();
			
			// Get the created client ID
			int AD_Client_ID = DB.getSQLValueEx(trxName, 
				"SELECT AD_Client_ID FROM AD_Client WHERE Name=?", clientName);
			assertTrue(AD_Client_ID > 0, "Client should be created in database");
			
			//create the calendar
			int C_Calendar_ID = setup.createCalendar();
			assertTrue(C_Calendar_ID > 0, "Calendar creation should succeed");
			
			// Create accounting setup
			MCurrency currency = MCurrency.get(Env.getCtx(), 100); // USD
			KeyNamePair currencyKNP = new KeyNamePair(currency.getC_Currency_ID(), currency.getDescription());
			
			File coaFile = new File(Adempiere.getAdempiereHome() + File.separator 
				+ "org.adempiere.server-feature" + File.separator
				+ "data" + File.separator + "import"
				+ File.separator + "AccountingDefaultsOnly.csv");
			assertTrue(coaFile.exists(), "CoA file should exist: " + coaFile.getAbsolutePath());
			
			boolean accountingCreated = setup.createAccounting(
				currencyKNP,
				true,  // hasProduct
				true,  // hasBPartner
				false, // hasProject
				false, // hasCampaign
				false, // hasSalesRegion
				false, // hasActivity
				coaFile,
				false, // useDefaultCoA
				false  // inactivateDefaults
			);
			assertTrue(accountingCreated, "Accounting creation should succeed: " + setup.getInfo());
			
			boolean documentTypesCreated = setup.createAndValidateDocumentTypes();
			assertTrue(documentTypesCreated, "Client creation should succeed");
			
			// NOW validate before rollback
			validateAccountingSetup(AD_Client_ID);
		} finally {
			// Always rollback to clean up, even if assertions fail
			setup.rollback();
			rollback();
		}
	}
	
	/**
	 * Validate all accounting objects created by MSetup.createAccounting
	 * @param AD_Client_ID the client ID to validate
	 */
	private void validateAccountingSetup(int AD_Client_ID) {
		// 1. Validate Calendar creation
		validateCalendar(AD_Client_ID);
		
		// 2. Validate Account Element creation
		validateAccountElement(AD_Client_ID);
		
		// 3. Validate Account Values (Chart of Accounts)
		validateAccountValues(AD_Client_ID);
		
		// 4. Validate Accounting Schema
		validateAcctSchema(AD_Client_ID);
		
		// 5. Validate Accounting Schema Elements
		validateAcctSchemaElements(AD_Client_ID);
		
		// 6. Validate GL Categories
		validateGLCategories(AD_Client_ID);
		
		// 7. Validate Document Types
		validateDocumentTypes(AD_Client_ID);
		
		// 8. Validate ClientInfo update
		validateClientInfo(AD_Client_ID);
		
		// 9. Validate Valid Combinations (default accounts)
		validateValidCombinations(AD_Client_ID);
	}
	
	private void validateCalendar(int AD_Client_ID) {
		MCalendar calendar = new Query(Env.getCtx(), MCalendar.Table_Name, "AD_Client_ID=?", trxName)
			.setParameters(AD_Client_ID)
			.first();
		assertNotNull(calendar, "Calendar should be created");
		
		// Verify calendar has at least one year
		int yearCount = DB.getSQLValueEx(trxName, 
			"SELECT COUNT(*) FROM C_Year WHERE C_Calendar_ID=?", calendar.getC_Calendar_ID());
		assertTrue(yearCount > 0, "Calendar should have at least one year");
	}
	
	private void validateAccountElement(int AD_Client_ID) {
		MElement element = new Query(Env.getCtx(), MElement.Table_Name, 
			"AD_Client_ID=? AND ElementType=?", trxName)
			.setParameters(AD_Client_ID, MElement.ELEMENTTYPE_Account)
			.first();
		assertNotNull(element, "Account Element should be created");
		assertEquals(MElement.ELEMENTTYPE_Account, element.getElementType(), 
			"Element should be of type Account");
	}
	
	private void validateAccountValues(int AD_Client_ID) {
		// Get the account element
		MElement element = new Query(Env.getCtx(), MElement.Table_Name, 
			"AD_Client_ID=? AND ElementType=?", trxName)
			.setParameters(AD_Client_ID, MElement.ELEMENTTYPE_Account)
			.first();
		assertNotNull(element, "Account Element should exist");
		
		// Verify account values were created from CoA file
		int accountCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_ElementValue WHERE C_Element_ID=?", 
			element.getC_Element_ID());
		assertTrue(accountCount > 0, "Account values should be created from CoA file");
		
	}
	
	private void validateAcctSchema(int AD_Client_ID) {
		MAcctSchema acctSchema = new Query(Env.getCtx(), MAcctSchema.Table_Name, 
			"AD_Client_ID=?", trxName)
			.setParameters(AD_Client_ID)
			.first();
		assertNotNull(acctSchema, "Accounting Schema should be created");
		assertEquals(100, acctSchema.getC_Currency_ID(), 
			"Accounting Schema should use USD currency (ID=100)");
	}
	
	private void validateAcctSchemaElements(int AD_Client_ID) {
		MAcctSchema acctSchema = new Query(Env.getCtx(), MAcctSchema.Table_Name, 
			"AD_Client_ID=?", trxName)
			.setParameters(AD_Client_ID)
			.first();
		assertNotNull(acctSchema, "Accounting Schema should exist");
		
		// Verify mandatory elements: Organization (OO) and Account (AC)
		X_C_AcctSchema_Element orgElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "OO")
			.first();
		assertNotNull(orgElement, "Organization accounting element should be created");
		assertTrue(orgElement.isMandatory(), "Organization element should be mandatory");
		
		X_C_AcctSchema_Element acctElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "AC")
			.first();
		assertNotNull(acctElement, "Account element should be created");
		assertTrue(acctElement.isMandatory(), "Account element should be mandatory");
		
		// Verify optional dimensions based on setup parameters
		// Product dimension (enabled by default in test)
		X_C_AcctSchema_Element productElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "PR")
			.first();
		assertNotNull(productElement, "Product dimension should be created (enabled in test)");
		
		// BPartner dimension (enabled by default in test)
		X_C_AcctSchema_Element bpElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "BP")
			.first();
		assertNotNull(bpElement, "BPartner dimension should be created (enabled in test)");
		
		// Verify that explicitly disabled dimensions are NOT created
		// Project dimension (disabled in testSetup)
		X_C_AcctSchema_Element projectElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "PJ")
			.first();
		assertNull(projectElement, "Project dimension should NOT be created (disabled in test)");
		
		// Campaign dimension (disabled in testSetup)
		X_C_AcctSchema_Element campaignElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "MC")
			.first();
		assertNull(campaignElement, "Campaign dimension should NOT be created (disabled in test)");
		
		// Sales Region dimension (disabled in testSetup)
		X_C_AcctSchema_Element salesRegionElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "SR")
			.first();
		assertNull(salesRegionElement, "Sales Region dimension should NOT be created (disabled in test)");
		
		// Activity dimension (disabled in testSetup)
		X_C_AcctSchema_Element activityElement = new Query(Env.getCtx(), X_C_AcctSchema_Element.Table_Name,
			"C_AcctSchema_ID=? AND ElementType=?", trxName)
			.setParameters(acctSchema.getC_AcctSchema_ID(), "AY")
			.first();
		assertNull(activityElement, "Activity dimension should NOT be created (disabled in test)");
	}
	
	private void validateGLCategories(int AD_Client_ID) {
		// Verify standard GL categories were created
		String[] expectedCategories = {
			"Standard", "None", "Manual", "AR Invoice", "AR Receipt",
			"Material Management", "AP Invoice", "AP Payment", 
			"Cash/Payments", "Manufacturing", "Distribution", "Payroll"
		};
		
		for (String categoryName : expectedCategories) {
			MGLCategory category = new Query(Env.getCtx(), MGLCategory.Table_Name,
				"AD_Client_ID=? AND Name=?", trxName)
				.setParameters(AD_Client_ID, categoryName)
				.first();
			assertNotNull(category, "GL Category '" + categoryName + "' should be created");
		}
		
		// Verify default category
		MGLCategory defaultCategory = new Query(Env.getCtx(), MGLCategory.Table_Name,
			"AD_Client_ID=? AND IsDefault=?", trxName)
			.setParameters(AD_Client_ID, true)
			.first();
		assertNotNull(defaultCategory, "There should be a default GL Category");
		assertEquals("Standard", defaultCategory.getName(), 
			"'Standard' should be the default GL Category");
	}
	
	private void validateDocumentTypes(int AD_Client_ID) {
		// Verify key document types were created
		String[] expectedDocBaseTypes = {
			MDocType.DOCBASETYPE_GLJournal,  // GL Journal
			MDocType.DOCBASETYPE_ARInvoice,  // AR Invoice
			MDocType.DOCBASETYPE_ARCreditMemo,  // AR Credit Memo
			MDocType.DOCBASETYPE_APInvoice,  // AP Invoice
			MDocType.DOCBASETYPE_APCreditMemo,  // AP Credit Memo
			MDocType.DOCBASETYPE_ARReceipt,  // AR Receipt
			MDocType.DOCBASETYPE_APPayment,  // AP Payment
			MDocType.DOCBASETYPE_MaterialDelivery,  // Material Shipment
			MDocType.DOCBASETYPE_MaterialReceipt,  // Material Receipt
			MDocType.DOCBASETYPE_PurchaseOrder,  // Purchase Order
			MDocType.DOCBASETYPE_SalesOrder,  // Sales Order
			MDocType.DOCBASETYPE_BankStatement,  // Bank Statement
			MDocType.DOCBASETYPE_CashJournal,  // Cash Journal
			MDocType.DOCBASETYPE_MaterialMovement,  // Material Movement
			MDocType.DOCBASETYPE_MaterialPhysicalInventory,  // Physical Inventory
			MDocType.DOCBASETYPE_MaterialProduction,  // Material Production
			MDocType.DOCBASETYPE_ProjectIssue,  // Project Issue
			MDocType.DOCBASETYPE_ManufacturingCostCollector,  // Cost Collector
			MDocType.DOCBASETYPE_DistributionOrder  // Distribution Order
		};
		
		for (String docBaseType : expectedDocBaseTypes) {
			int count = DB.getSQLValueEx(trxName,
				"SELECT COUNT(*) FROM C_DocType WHERE AD_Client_ID=? AND DocBaseType=?",
				AD_Client_ID, docBaseType);
			assertTrue(count > 0, 
				"At least one document type with DocBaseType '" + docBaseType + "' should exist");
		}
		
		// Verify specific important document types
		MDocType glJournal = new Query(Env.getCtx(), MDocType.Table_Name,
			"AD_Client_ID=? AND DocBaseType=? AND Name LIKE '%Journal%'", trxName)
			.setParameters(AD_Client_ID, "GLJ")
			.first();
		assertNotNull(glJournal, "GL Journal document type should be created");
		
		// Verify Standard Order exists
		MDocType standardOrder = new Query(Env.getCtx(), MDocType.Table_Name,
			"AD_Client_ID=? AND DocBaseType=? AND DocSubTypeSO=?", trxName)
			.setParameters(AD_Client_ID, "SOO", "SO")
			.first();
		assertNotNull(standardOrder, "Standard Order document type should be created");
	}
	
	private void validateClientInfo(int AD_Client_ID) {
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), AD_Client_ID, trxName);
		assertNotNull(clientInfo, "ClientInfo should exist");
	}
	
	private void validateValidCombinations(int AD_Client_ID) {
		MAcctSchema acctSchema = new Query(Env.getCtx(), MAcctSchema.Table_Name, 
			"AD_Client_ID=?", trxName)
			.setParameters(AD_Client_ID)
			.first();
		assertNotNull(acctSchema, "Accounting Schema should exist");
		
		// Verify valid combinations were created for default accounts
		int vcCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_ValidCombination WHERE AD_Client_ID=? AND C_AcctSchema_ID=?",
			AD_Client_ID, acctSchema.getC_AcctSchema_ID());
		assertTrue(vcCount > 0, 
			"Valid combinations should be created for default accounts");
		
		// Verify C_AcctSchema_GL was created with default accounts
		int glCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_AcctSchema_GL WHERE C_AcctSchema_ID=?",
			acctSchema.getC_AcctSchema_ID());
		assertEquals(1, glCount, "C_AcctSchema_GL record should be created");
		
		// Verify C_AcctSchema_Default was created with default accounts
		int defaultCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_AcctSchema_Default WHERE C_AcctSchema_ID=?",
			acctSchema.getC_AcctSchema_ID());
		assertEquals(1, defaultCount, "C_AcctSchema_Default record should be created");
	}
	
	@Test
	public void testCreateEntities() {
		String clientName = "JUnit_CreateEntitiesTest";
		String orgValue = "JUnitEntOrg";
		String orgName = "JUnit Entities Org";
		
		// Create MSetup instance
		MSetup setup = new MSetup(Env.getCtx(), 0, true);
		
		try {
			// Create client first
			boolean clientCreated = setup.createClient(
				clientName, 
				orgValue, 
				orgName, 
				"EntitiesAdmin", 
				"EntitiesUser",
				null, null, null, null, null,
				"admin@entities.org", 
				"user@entities.org",
				false
			);
			assertTrue(clientCreated, "Client creation should succeed");
			
			trxName = setup.getTrxName();
			
			// Get the created client ID
			int AD_Client_ID = DB.getSQLValueEx(trxName, 
				"SELECT AD_Client_ID FROM AD_Client WHERE Name=?", clientName);
			assertTrue(AD_Client_ID > 0, "Client should be created in database");
			
			int C_Calendar_ID = setup.createCalendar();
			assertTrue(C_Calendar_ID > 0, "Calendar creation should succeed");
			
			// Create accounting setup first (required by createEntities)
			MCurrency currency = MCurrency.get(Env.getCtx(), 100); // USD
			KeyNamePair currencyKNP = new KeyNamePair(currency.getC_Currency_ID(), currency.getDescription());
			
			File coaFile = new File(Adempiere.getAdempiereHome() + File.separator 
				+ "org.adempiere.server-feature" + File.separator
				+ "data" + File.separator + "import"
				+ File.separator + "AccountingDefaultsOnly.csv");
			assertTrue(coaFile.exists(), "CoA file should exist: " + coaFile.getAbsolutePath());
			
			boolean accountingCreated = setup.createAccounting(
				currencyKNP,
				true,  // hasProduct
				true,  // hasBPartner
				false, // hasProject
				true,  // hasCampaign
				true,  // hasSalesRegion
				true,  // hasActivity
				coaFile,
				false,
				false
			);
			assertTrue(accountingCreated, "Accounting creation should succeed");
			
			// Now test createEntities
			int C_Country_ID = 100; // USA
			String city = "Test City";
			int C_Region_ID = 100; // California
			int C_Currency_ID = DictionaryIDs.C_Currency.USD.id;
			String postal = "12345";
			String address1 = "123 Test Street";
			
			boolean entitiesCreated = setup.createEntities(
				C_Country_ID, 
				city, 
				C_Region_ID, 
				C_Currency_ID, 
				postal, 
				address1
			);
			assertTrue(entitiesCreated, "Entities creation should succeed");
			
			// Validate all entities created
			validateEntitiesSetup(AD_Client_ID);
		} finally {
			// Always rollback to clean up
			setup.rollback();
			rollback();
		}
	}
	
	/**
	 * Validate all business entities created by MSetup.createEntities
	 * @param AD_Client_ID the client ID to validate
	 */
	private void validateEntitiesSetup(int AD_Client_ID) {
		// 1. Validate Marketing Channel
		validateMarketingChannel(AD_Client_ID);
		
		// 2. Validate Campaign
		validateCampaign(AD_Client_ID);
		
		// 3. Validate Sales Region
		validateSalesRegion(AD_Client_ID);
		
		// 4. Validate Activity
		validateActivity(AD_Client_ID);
		
		// 5. Validate Business Partner Group
		validateBPGroup(AD_Client_ID);
		
		// 6. Validate Business Partner
		validateBPartner(AD_Client_ID);
		
		// 7. Validate Product Category
		validateProductCategory(AD_Client_ID);
		
		// 8. Validate Tax Category
		validateTaxCategory(AD_Client_ID);
		
		// 9. Validate Tax
		validateTax(AD_Client_ID);
		
		// 10. Validate Product
		validateProduct(AD_Client_ID);
		
		// 11. Validate Warehouse and Locator
		validateWarehouseAndLocator(AD_Client_ID);
		
		// 12. Validate Price List
		validatePriceList(AD_Client_ID);
		
		// 13. Validate Sales Representatives
		validateSalesReps(AD_Client_ID);
		
		// 14. Validate ClientInfo updates
		validateClientInfoEntities(AD_Client_ID);
		
		validateDimensionLinks(AD_Client_ID);
	}
	
	private void validateMarketingChannel(int AD_Client_ID) {
		int channelCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_Channel WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(channelCount > 0, "Marketing Channel should be created");
		
		// Verify default channel exists
		int channelID = DB.getSQLValueEx(trxName,
			"SELECT C_Channel_ID FROM C_Channel WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(channelID > 0, "Standard Marketing Channel should exist");
	}
	
	private void validateCampaign(int AD_Client_ID) {
		int campaignCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_Campaign WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(campaignCount > 0, "Campaign should be created");
		
		// Verify default campaign
		int campaignID = DB.getSQLValueEx(trxName,
			"SELECT C_Campaign_ID FROM C_Campaign WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(campaignID > 0, "Standard Campaign should exist");
		
		// Verify campaign translation records created
		int trlCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_Campaign_Trl WHERE C_Campaign_ID=?", campaignID);
		assertTrue(trlCount > 0, "Campaign translation records should be created");
	}
	
	private void validateSalesRegion(int AD_Client_ID) {
		int regionCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_SalesRegion WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(regionCount > 0, "Sales Region should be created");
		
		// Verify default sales region
		int regionID = DB.getSQLValueEx(trxName,
			"SELECT C_SalesRegion_ID FROM C_SalesRegion WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(regionID > 0, "Standard Sales Region should exist");
		
		// Verify it's not a summary
		String isSummary = DB.getSQLValueStringEx(trxName,
			"SELECT IsSummary FROM C_SalesRegion WHERE C_SalesRegion_ID=?", regionID);
		assertEquals("N", isSummary, "Sales Region should not be a summary");
		
		// Verify translation records
		int trlCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_SalesRegion_Trl WHERE C_SalesRegion_ID=?", regionID);
		assertTrue(trlCount > 0, "Sales Region translation records should be created");
	}
	
	private void validateActivity(int AD_Client_ID) {
		int activityCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_Activity WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(activityCount > 0, "Activity should be created");
		
		// Verify default activity
		int activityID = DB.getSQLValueEx(trxName,
			"SELECT C_Activity_ID FROM C_Activity WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(activityID > 0, "Standard Activity should exist");
		
		// Verify it's not a summary
		String isSummary = DB.getSQLValueStringEx(trxName,
			"SELECT IsSummary FROM C_Activity WHERE C_Activity_ID=?", activityID);
		assertEquals("N", isSummary, "Activity should not be a summary");
		
		// Verify translation records
		int trlCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_Activity_Trl WHERE C_Activity_ID=?", activityID);
		assertTrue(trlCount > 0, "Activity translation records should be created");
	}
	
	private void validateBPGroup(int AD_Client_ID) {
		int bpgCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_BP_Group WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(bpgCount > 0, "Business Partner Group should be created");
		
		// Verify default BP Group
		int bpgID = DB.getSQLValueEx(trxName,
			"SELECT C_BP_Group_ID FROM C_BP_Group WHERE AD_Client_ID=? AND IsDefault='Y'", 
			AD_Client_ID);
		assertTrue(bpgID > 0, "Default Business Partner Group should exist");
	}
	
	private void validateBPartner(int AD_Client_ID) {
		int bpCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_BPartner WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(bpCount > 0, "Business Partner should be created");
		
		// Verify standard BP
		int bpID = DB.getSQLValueEx(trxName,
			"SELECT C_BPartner_ID FROM C_BPartner WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(bpID > 0, "Standard Business Partner should exist");
		
		// Verify BP Location exists
		int bplCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_BPartner_Location WHERE C_BPartner_ID=?", bpID);
		assertTrue(bplCount > 0, "Business Partner Location should be created");
	}
	
	private void validateProductCategory(int AD_Client_ID) {
		int pcCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_Product_Category WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(pcCount > 0, "Product Category should be created");
		
		// Verify default product category
		int pcID = DB.getSQLValueEx(trxName,
			"SELECT M_Product_Category_ID FROM M_Product_Category WHERE AD_Client_ID=? AND IsDefault='Y'", 
			AD_Client_ID);
		assertTrue(pcID > 0, "Default Product Category should exist");
	}
	
	private void validateTaxCategory(int AD_Client_ID) {
		int tcCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_TaxCategory WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(tcCount > 0, "Tax Category should be created");
		
		// Verify default tax category
		int tcID = DB.getSQLValueEx(trxName,
			"SELECT C_TaxCategory_ID FROM C_TaxCategory WHERE AD_Client_ID=? AND IsDefault='Y'", 
			AD_Client_ID);
		assertTrue(tcID > 0, "Default Tax Category should exist");
		
		// Verify translation records
		int trlCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_TaxCategory_Trl WHERE C_TaxCategory_ID=?", tcID);
		assertTrue(trlCount > 0, "Tax Category translation records should be created");
	}
	
	private void validateTax(int AD_Client_ID) {
		int taxCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM C_Tax WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(taxCount > 0, "Tax should be created");
		
		// Verify default tax with zero rate
		int taxID = DB.getSQLValueEx(trxName,
			"SELECT C_Tax_ID FROM C_Tax WHERE AD_Client_ID=? AND IsDefault='Y'", 
			AD_Client_ID);
		assertTrue(taxID > 0, "Default Tax should exist");
		
		int zeroRateCount = DB.getSQLValueEx(trxName,
				"SELECT COUNT(*) FROM C_Tax WHERE C_Tax_ID=? AND Rate=0", taxID);
		assertEquals(1, zeroRateCount, "Default Tax should have zero rate");
	}
	
	private void validateProduct(int AD_Client_ID) {
		int productCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_Product WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(productCount > 0, "Product should be created");
		
		// Verify standard product
		int productID = DB.getSQLValueEx(trxName,
			"SELECT M_Product_ID FROM M_Product WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(productID > 0, "Standard Product should exist");
	}
	
	private void validateWarehouseAndLocator(int AD_Client_ID) {
		// Validate Warehouse
		int whCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_Warehouse WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(whCount > 0, "Warehouse should be created");
		
		// Verify standard warehouse
		int whID = DB.getSQLValueEx(trxName,
			"SELECT M_Warehouse_ID FROM M_Warehouse WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(whID > 0, "Standard Warehouse should exist");
		
		// Validate Locator
		int locatorCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_Locator WHERE M_Warehouse_ID=?", whID);
		assertTrue(locatorCount > 0, "Locator should be created");
		
		// Verify default locator
		int defaultLocatorCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_Locator WHERE M_Warehouse_ID=? AND IsDefault='Y'", whID);
		assertEquals(1, defaultLocatorCount, "One default Locator should exist");
	}
	
	private void validatePriceList(int AD_Client_ID) {
		// Validate Price List
		int plCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_PriceList WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(plCount > 0, "Price List should be created");
		
		// Verify default price list
		int plID = DB.getSQLValueEx(trxName,
			"SELECT M_PriceList_ID FROM M_PriceList WHERE AD_Client_ID=? AND IsDefault='Y'", 
			AD_Client_ID);
		assertTrue(plID > 0, "Default Price List should exist");
		
		// Validate Discount Schema
		int dsCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_DiscountSchema WHERE AD_Client_ID=?", AD_Client_ID);
		assertTrue(dsCount > 0, "Discount Schema should be created");
		
		// Validate Price List Version
		int plvCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_PriceList_Version WHERE M_PriceList_ID=?", plID);
		assertTrue(plvCount > 0, "Price List Version should be created");
		
		// Validate Product Price
		int ppCount = DB.getSQLValueEx(trxName,
			"SELECT COUNT(*) FROM M_ProductPrice pp " +
			"JOIN M_PriceList_Version plv ON pp.M_PriceList_Version_ID=plv.M_PriceList_Version_ID " +
			"WHERE plv.M_PriceList_ID=?", plID);
		assertTrue(ppCount > 0, "Product Price should be created");
	}
	
	private void validateSalesReps(int AD_Client_ID) {
		int repEmployeeCount = DB.getSQLValueEx(trxName,
				"SELECT COUNT(*) FROM C_BPartner WHERE AD_Client_ID=? AND IsSalesRep='Y' AND IsEmployee='Y'",
				AD_Client_ID);
		assertTrue(repEmployeeCount >= 2,
				"At least 2 Business Partners should be both sales reps and employees");
	}
	
	private void validateClientInfoEntities(int AD_Client_ID) {
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), AD_Client_ID, trxName);
		assertNotNull(clientInfo, "ClientInfo should exist");
	}
	
	/**
	 * Validate that all dimensions are correctly linked to the accounting schema.
	 * This validates the work done by MSetup.linkEntitiesToAccounting
	 * @param AD_Client_ID the client ID to validate
	 */
	private void validateDimensionLinks(int AD_Client_ID) {
		// Get the accounting schema
		MAcctSchema acctSchema = new Query(Env.getCtx(), MAcctSchema.Table_Name, 
			"AD_Client_ID=?", trxName)
			.setParameters(AD_Client_ID)
			.first();
		assertNotNull(acctSchema, "Accounting Schema should exist");
		int C_AcctSchema_ID = acctSchema.getC_AcctSchema_ID();
		
		// 1. Validate Campaign dimension link
		validateCampaignLink(AD_Client_ID, C_AcctSchema_ID);
		
		// 2. Validate Sales Region dimension link
		validateSalesRegionLink(AD_Client_ID, C_AcctSchema_ID);
		
		// 3. Validate Activity dimension link
		validateActivityLink(AD_Client_ID, C_AcctSchema_ID);
		
		// 4. Validate Business Partner dimension link
		validateBPartnerLink(AD_Client_ID, C_AcctSchema_ID);
		
		// 5. Validate Product dimension link
		validateProductLink(AD_Client_ID, C_AcctSchema_ID);
		
	}
	
	private void validateCampaignLink(int AD_Client_ID, int C_AcctSchema_ID) {
		// Get the standard campaign created
		int campaignID = DB.getSQLValueEx(trxName,
			"SELECT C_Campaign_ID FROM C_Campaign WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(campaignID > 0, "Standard Campaign should exist");
		
		// Verify it's linked to the accounting schema via C_AcctSchema_Element table
		int linkedCampaignID = DB.getSQLValueEx(trxName,
			"SELECT C_Campaign_ID FROM C_AcctSchema_Element WHERE C_AcctSchema_ID=? AND ElementType='MC'",
			C_AcctSchema_ID);
		assertEquals(campaignID, linkedCampaignID, 
			"Campaign should be linked to Accounting Schema via C_AcctSchema_Element");
	}
	
	private void validateSalesRegionLink(int AD_Client_ID, int C_AcctSchema_ID) {
		// Get the standard sales region created
		int regionID = DB.getSQLValueEx(trxName,
			"SELECT C_SalesRegion_ID FROM C_SalesRegion WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(regionID > 0, "Standard Sales Region should exist");
		
		// Verify it's linked to the accounting schema via C_AcctSchema_Element table
		int linkedRegionID = DB.getSQLValueEx(trxName,
			"SELECT C_SalesRegion_ID FROM C_AcctSchema_Element WHERE C_AcctSchema_ID=? AND ElementType='SR'",
			C_AcctSchema_ID);
		assertEquals(regionID, linkedRegionID, 
			"Sales Region should be linked to Accounting Schema via C_AcctSchema_Element");
	}
	
	private void validateActivityLink(int AD_Client_ID, int C_AcctSchema_ID) {
		// Get the standard activity created
		int activityID = DB.getSQLValueEx(trxName,
			"SELECT C_Activity_ID FROM C_Activity WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(activityID > 0, "Standard Activity should exist");
		
		// Verify it's linked to the accounting schema via C_AcctSchema_Element table
		int linkedActivityID = DB.getSQLValueEx(trxName,
			"SELECT C_Activity_ID FROM C_AcctSchema_Element WHERE C_AcctSchema_ID=? AND ElementType='AY'",
			C_AcctSchema_ID);
		assertEquals(activityID, linkedActivityID, 
			"Activity should be linked to Accounting Schema via C_AcctSchema_Element");
	}
	
	private void validateBPartnerLink(int AD_Client_ID, int C_AcctSchema_ID) {
		// Get the standard business partner created
		int bpID = DB.getSQLValueEx(trxName,
			"SELECT C_BPartner_ID FROM C_BPartner WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(bpID > 0, "Standard Business Partner should exist");
		
		// Verify it's linked to the accounting schema via C_AcctSchema_Element table
		int linkedBPID = DB.getSQLValueEx(trxName,
			"SELECT C_BPartner_ID FROM C_AcctSchema_Element WHERE C_AcctSchema_ID=? AND ElementType='BP'",
			C_AcctSchema_ID);
		assertEquals(bpID, linkedBPID, 
			"Business Partner should be linked to Accounting Schema via C_AcctSchema_Element");
	}
	
	private void validateProductLink(int AD_Client_ID, int C_AcctSchema_ID) {
		// Get the standard product created
		int productID = DB.getSQLValueEx(trxName,
			"SELECT M_Product_ID FROM M_Product WHERE AD_Client_ID=? AND Name='Standard'", 
			AD_Client_ID);
		assertTrue(productID > 0, "Standard Product should exist");
		
		// Verify it's linked to the accounting schema via C_AcctSchema_Element table
		int linkedProductID = DB.getSQLValueEx(trxName,
			"SELECT M_Product_ID FROM C_AcctSchema_Element WHERE C_AcctSchema_ID=? AND ElementType='PR'",
			C_AcctSchema_ID);
		assertEquals(productID, linkedProductID, 
			"Product should be linked to Accounting Schema via C_AcctSchema_Element");
	}
}
