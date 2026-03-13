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
		
		// Create MSetup instance with dry-run = false to keep data in transaction for validation
		MSetup setup = new MSetup(Env.getCtx(), 0, false);
		
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
		
		// NOW validate before rollback
		validateAccountingSetup(AD_Client_ID);
		
		// Rollback to clean up
		setup.rollback();
		rollback();
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
				"AD_Client_ID IN (0,?) AND Name=?", trxName)
				.setParameters(AD_Client_ID, categoryName)
				.first();
			assertNotNull(category, "GL Category '" + categoryName + "' should be created");
		}
		
		// Verify default category
		MGLCategory defaultCategory = new Query(Env.getCtx(), MGLCategory.Table_Name,
			"AD_Client_ID IN (0,?) AND IsDefault=?", trxName)
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
				"SELECT COUNT(*) FROM C_DocType WHERE AD_Client_ID IN (0,?) AND DocBaseType=?",
				AD_Client_ID, docBaseType);
			assertTrue(count > 0, 
				"At least one document type with DocBaseType '" + docBaseType + "' should exist");
		}
		
		// Verify specific important document types
		MDocType glJournal = new Query(Env.getCtx(), MDocType.Table_Name,
			"AD_Client_ID IN (0,?) AND DocBaseType=? AND Name LIKE '%Journal%'", trxName)
			.setParameters(AD_Client_ID, "GLJ")
			.first();
		assertNotNull(glJournal, "GL Journal document type should be created");
		
		// Verify Standard Order exists
		MDocType standardOrder = new Query(Env.getCtx(), MDocType.Table_Name,
			"AD_Client_ID IN (0,?) AND DocBaseType=? AND DocSubTypeSO=?", trxName)
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
}
