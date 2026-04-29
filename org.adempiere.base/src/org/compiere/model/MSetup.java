/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import static org.compiere.model.SystemIDs.COUNTRY_US;
import static org.compiere.model.SystemIDs.SCHEDULE_10_MINUTES;
import static org.compiere.model.SystemIDs.SCHEDULE_15_MINUTES;

import java.io.File;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.ProcessUtil;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.idempiere.acct.AcctModelServices;
import org.idempiere.acct.IAccountingSetupService;
import org.idempiere.acct.IAccountingSetupService.AccountingSetupResult;

/**
 * Initial Setup Model
 *
 * @author Jorg Janke
 * @version $Id: MSetup.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>FR [ 1795384 ] Setup: create default accounts records is too rigid
 * @author Carlos Ruiz - globalqss
 * 			<li>Setup correctly IsSOTrx for return documents
 */
public final class MSetup
{

	public final static String TRXNAME_PREFIX = "InitialClientSetup";
	public final static String TRX_DISPLAYNAME = "org.compiere.model.MSetup_createClient";

	/**
	 *  Constructor
	 *  @param ctx context
	 *  @param WindowNo window
	 */
	public MSetup(Properties ctx, int WindowNo)
	{
		this(ctx, WindowNo, false);
	}
	
	/**
	 *  Constructor
	 *  @param ctx context
	 *  @param WindowNo window
	 */
	public MSetup(Properties ctx, int WindowNo, boolean dryRun)
	{
		m_ctx = new Properties(ctx);	//	copy
		m_lang = Env.getAD_Language(m_ctx);
		m_WindowNo = WindowNo;
		m_dryRun = dryRun;
	}   //  MSetup

	/**	Logger			*/
	protected CLogger	log = CLogger.getCLogger(getClass());

	private Trx				m_trx = Trx.get(Trx.createTrxName(TRXNAME_PREFIX), true);
	private Properties      m_ctx;
	private String          m_lang;
	private int             m_WindowNo;
	private StringBuffer    m_info;
	//
	private String          m_clientName;
	//
	private String          m_stdColumns = "AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy";
	private String          m_stdValues;
	private String          m_stdValuesOrg;
	//
	private MClient			m_client;
	private MOrg			m_org;
	private int             C_AcctSchema_ID = -1;
	//
	private int     		AD_User_ID;
	private String  		AD_User_Name;
	private int     		AD_User_U_ID;
	private String  		AD_User_U_Name;
	private MCalendar		m_calendar;
	private int     		C_Cycle_ID;
	//
	private boolean         m_hasProject = false;
	private boolean         m_hasMCampaign = false;
	private boolean         m_hasSRegion = false;
	private boolean         m_hasActivity = false;

    private Map<String, Integer> glCategories = null;
	private boolean 		m_dryRun = false;
	
	/**
	 *  Create Client Info. <br/>
	 *  - Client, Trees, Org, Role, User, User_Role
	 *  @param clientName client name
	 *  @param orgValue org Value
	 *  @param orgName org name
	 *  @param userClient client user name
	 *  @param userOrg org user name
	 *  @param phone
	 *  @param phone2
	 *  @param fax
	 *  @param eMail
	 *  @param taxID
	 *  @param adminEmail
	 *  @param userEmail
	 *  @param isSetInitialPassword 
	 *  @return true if created
	 */
	public boolean createClient (String clientName, String orgValue, String orgName,
		String userClient, String userOrg, String phone, String phone2, String fax, String eMail, String taxID,
		String adminEmail, String userEmail, boolean isSetInitialPassword)
	{
		log.info(clientName);
		m_trx.setDisplayName(TRX_DISPLAYNAME);
		m_trx.start();
		
		//  info header
		m_info = new StringBuffer();
		//  Standard columns
		String name = null;
		String sql = null;
		int no = 0;

		/**
		 *  Create Client
		 */
		name = clientName;
		if (name == null || name.length() == 0)
			name = "newClient";
		m_clientName = name;
		m_client = new MClient(m_ctx, 0, true, m_trx.getTrxName());
		m_client.setValue(m_clientName);
		if (MSystem.isUseLoginPrefix())
			m_client.setLoginPrefix(m_clientName);
		m_client.setName(m_clientName);
		if (!m_client.save())
		{
			String err = "Tenant NOT created";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		int AD_Client_ID = m_client.getAD_Client_ID();
		Env.setContext(m_ctx, m_WindowNo, "AD_Client_ID", AD_Client_ID);
		Env.setContext(m_ctx, Env.AD_CLIENT_ID, AD_Client_ID);

		//	Standard Values
		m_stdValues = String.valueOf(AD_Client_ID) + ",0,'Y',getDate(),0,getDate(),0";
		//  Info - Client
		m_info.append(Msg.translate(m_lang, "AD_Client_ID")).append("=").append(name).append("\n");

		//	Setup Sequences
		if (!MSequence.checkClientSequences (m_ctx, AD_Client_ID, m_trx.getTrxName()))
		{
			String err = "Sequences NOT created";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		
		//  Trees and Client Info
		if (!m_client.setupClientInfo(m_lang))
		{
			String err = "Tenant Info NOT created";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}

		/**
		 *  Create Org
		 */
		name = orgName;
		if (name == null || name.length() == 0)
			name = "newOrg";
		if (orgValue == null || orgValue.length() == 0)
			orgValue = name;
		m_org = new MOrg (m_client, orgValue, name);
		if (!m_org.save())
		{
			String err = "Organization NOT created";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		Env.setContext(m_ctx, m_WindowNo, "AD_Org_ID", getAD_Org_ID());
		Env.setContext(m_ctx, Env.AD_ORG_ID, getAD_Org_ID());
		m_stdValuesOrg = AD_Client_ID + "," + getAD_Org_ID() + ",'Y',getDate(),0,getDate(),0";
		//  Info
		m_info.append(Msg.translate(m_lang, "AD_Org_ID")).append("=").append(name).append("\n");
		
		// Set Organization Phone, Phone2, Fax, EMail
		MOrgInfo orgInfo = MOrgInfo.getCopy(m_ctx, getAD_Org_ID(), m_trx.getTrxName());
		orgInfo.setPhone(phone);
		orgInfo.setPhone2(phone2);
		orgInfo.setFax(fax);
		orgInfo.setEMail(eMail);
		if (taxID != null && taxID.length() > 0) {
			orgInfo.setTaxID(taxID);
		}
		if (!orgInfo.save())
		{
			String err = "Organization Info NOT Updated";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		
		/**
		 *  Create Roles
		 *  - Admin
		 *  - User
		 */
		name = m_clientName + " Admin";
		MRole admin = new MRole(m_ctx, 0, m_trx.getTrxName());
		admin.setClientOrg(m_client);
		admin.setName(name);
		admin.setUserLevel(MRole.USERLEVEL_ClientPlusOrganization);
		admin.setPreferenceType(MRole.PREFERENCETYPE_Client);
		admin.setIsShowAcct(true);
		admin.setIsAccessAdvanced(true);
		admin.setIsClientAdministrator(true);
		if (!admin.save())
		{
			String err = "Admin Role A NOT inserted";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		//	OrgAccess x, 0
		MRoleOrgAccess adminClientAccess = new MRoleOrgAccess (admin, 0);
		if (!adminClientAccess.save())
			log.log(Level.SEVERE, "Admin Role_OrgAccess 0 NOT created");
		//  OrgAccess x,y
		MRoleOrgAccess adminOrgAccess = new MRoleOrgAccess (admin, m_org.getAD_Org_ID());
		if (!adminOrgAccess.save())
			log.log(Level.SEVERE, "Admin Role_OrgAccess NOT created");
		
		//  Info - Admin Role
		m_info.append(Msg.translate(m_lang, "AD_Role_ID")).append("=").append(name).append("\n");

		//
		name = m_clientName + " User";
		MRole user = new MRole (m_ctx, 0, m_trx.getTrxName());
		user.setClientOrg(m_client);
		user.setName(name);
		user.setIsAccessAdvanced(false);
		user.setIsClientAdministrator(false);
		if (!user.save())
		{
			String err = "User Role A NOT inserted";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		//  OrgAccess x,y
		MRoleOrgAccess userOrgAccess = new MRoleOrgAccess (user, m_org.getAD_Org_ID());
		if (!userOrgAccess.save())
			log.log(Level.SEVERE, "User Role_OrgAccess NOT created");
		
		//  Info - Client Role
		m_info.append(Msg.translate(m_lang, "AD_Role_ID")).append("=").append(name).append("\n");

		/**
		 *  Create Users
		 *  - Client
		 *  - Org
		 */
		MUser clientAdminUser = new MUser(m_ctx, 0, m_trx.getTrxName());

		name = userClient;
		if (name == null || name.length() == 0)
			name = m_clientName + "Client";

		if (isSetInitialPassword)
			clientAdminUser.setPassword(name);
		clientAdminUser.setDescription(name);
		clientAdminUser.setName(name);
		clientAdminUser.setAD_Client_ID(AD_Client_ID);
		clientAdminUser.setAD_Org_ID(0);
		clientAdminUser.setEMail(adminEmail);

		try {
			clientAdminUser.saveEx();
		} catch (AdempiereException ex) {
			String err = "Admin User NOT inserted - " + AD_User_Name;
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}

		AD_User_ID = clientAdminUser.getAD_User_ID();
		AD_User_Name = name;

		//  Info
		m_info.append(Msg.translate(m_lang, "AD_User_ID")).append("=").append(AD_User_Name).append("/").append(AD_User_Name).append("\n");

		MUser clientUser = new MUser(m_ctx, 0, m_trx.getTrxName());

		name = userOrg;
		if (name == null || name.length() == 0)
			name = m_clientName + "Org";

		if (isSetInitialPassword)
			clientUser.setPassword(name);
		clientUser.setDescription(name);
		clientUser.setName(name);
		clientUser.setAD_Client_ID(AD_Client_ID);
		clientUser.setAD_Org_ID(0);
		clientUser.setEMail(userEmail);

		try {
			clientUser.saveEx();
		} catch (AdempiereException ex) {
			String err = "Org User NOT inserted - " + AD_User_U_Name;
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}

		AD_User_U_ID = clientUser.getAD_User_ID();
		AD_User_U_Name = name;
		//  Info
		m_info.append(Msg.translate(m_lang, "AD_User_ID")).append("=").append(AD_User_U_Name).append("/").append(AD_User_U_Name).append("\n");

		/**
		 *  Create User-Role
		 */
		//  ClientUser          - Admin & User
		sql = "INSERT INTO AD_User_Roles(" + m_stdColumns + ",AD_User_ID,AD_Role_ID,AD_User_Roles_UU)"
			+ " VALUES (" + m_stdValues + "," + AD_User_ID + "," + admin.getAD_Role_ID() + "," + DB.TO_STRING(Util.generateUUIDv7().toString()) + ")";
		no = DB.executeUpdateEx(sql, m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "UserRole ClientUser+Admin NOT inserted");
		sql = "INSERT INTO AD_User_Roles(" + m_stdColumns + ",AD_User_ID,AD_Role_ID,AD_User_Roles_UU)"
			+ " VALUES (" + m_stdValues + "," + AD_User_ID + "," + user.getAD_Role_ID() + "," + DB.TO_STRING(Util.generateUUIDv7().toString()) + ")";
		no = DB.executeUpdateEx(sql, m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "UserRole ClientUser+User NOT inserted");
		//  OrgUser             - User
		sql = "INSERT INTO AD_User_Roles(" + m_stdColumns + ",AD_User_ID,AD_Role_ID,AD_User_Roles_UU)"
			+ " VALUES (" + m_stdValues + "," + AD_User_U_ID + "," + user.getAD_Role_ID() + "," + DB.TO_STRING(Util.generateUUIDv7().toString()) + ")";
		no = DB.executeUpdateEx(sql, m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "UserRole OrgUser+Org NOT inserted");

		//	Processors
		MAcctProcessor ap = new MAcctProcessor(m_client, AD_User_ID);
		ap.setAD_Schedule_ID(SCHEDULE_10_MINUTES);
		ap.saveEx();
		
		MRequestProcessor rp = new MRequestProcessor (m_client, AD_User_ID);
		rp.setAD_Schedule_ID(SCHEDULE_15_MINUTES);
		rp.saveEx();
		
		log.info("fini");
		return true;
	}   //  createClient

	/** 
	 * preserving backward compatibility with swing client
	 * @param currency
	 * @param hasProduct
	 * @param hasBPartner
	 * @param hasProject
	 * @param hasMCampaign
	 * @param hasSRegion
	 * @param AccountingFile
	 * @return true if created
	 * @deprecated
	 */
	@Deprecated (since="13", forRemoval=true)
	public boolean createAccounting(KeyNamePair currency,
			boolean hasProduct, boolean hasBPartner, boolean hasProject,
			boolean hasMCampaign, boolean hasSRegion,
			File AccountingFile) {
		return createAccounting(currency,
				hasProduct, hasBPartner, hasProject,
				hasMCampaign, hasSRegion,
				false, AccountingFile, false, false);
	}

	/**
	 *  <pre>
	 *  Create Accounting elements.
	 *  - Account Trees
	 *  - Account Values
	 *  - Accounting Schema
	 *  - Default Accounts
	 *  </pre>
	 *  @param currency currency
	 *  @param hasProduct has product segment
	 *  @param hasBPartner has bp segment
	 *  @param hasProject has project segment
	 *  @param hasMCampaign has campaign segment
	 *  @param hasSRegion has sales region segment
	 *  @param hasActivity has activity segment
	 *  @param AccountingFile accounting file
	 *  @param useDefaultCoA use the Default CoA (load and group summary account)
	 *  @param inactivateDefaults inactivate the default accounts after created
	 *  @return true if created
	 */
	public boolean createAccounting(KeyNamePair currency,
		boolean hasProduct, boolean hasBPartner, boolean hasProject,
		boolean hasMCampaign, boolean hasSRegion,
		boolean hasActivity, File AccountingFile, boolean useDefaultCoA, boolean inactivateDefaults)
	{
		if (log.isLoggable(Level.INFO)) log.info(m_client.toString());
		//
		m_hasProject = hasProject;
		m_hasMCampaign = hasMCampaign;
		m_hasSRegion = hasSRegion;
		m_hasActivity = hasActivity;

		//  Initialize
		m_info = new StringBuffer();

		try {
			
			IAccountingSetupService acctService = null;
			if (AcctModelServices.isAccountingSetupAvailable()) {
				acctService = AcctModelServices.getAccountingSetupService();
			}

		    if (acctService == null) {
		        log.warning("Accounting service not available - skipping dimension links");
		        return true; // Not an error, just skip
		    }
		    
		    AccountingSetupResult result = acctService.createAccountingInfrastructure(
		    		m_ctx, m_client, getAD_Org_ID(), currency, 
		    		hasProduct, hasBPartner, hasProject,
		    		hasMCampaign, hasSRegion, hasActivity,
		    		AccountingFile, inactivateDefaults, m_calendar.getC_Calendar_ID(),
		    		m_stdColumns, m_stdValues,
		    		m_trx.getTrxName()
		    		);
		    
		    if (!result.isSuccess()) {
		        m_info.append(result.getInfo());
		        m_trx.rollback();
		        m_trx.close();
		        return false;
		    }
		    
		    m_info.append(result.getInfo());
			C_AcctSchema_ID = result.getC_AcctSchema_ID();
			glCategories = result.getGLCategories();

			//
			if (log.isLoggable(Level.INFO)) log.info("fini");
			return true;
		} catch (Exception e) {
	        String err = "Accounting setup failed: " + e.getMessage();
	        log.log(Level.SEVERE, err, e);
	        m_info.append(err);
	        m_trx.rollback();
	        m_trx.close();
	        return false;
	    }
	}   //  createAccounting
	
	/**
	 * Create default document types and validates the setup
	 * @return true if created and validated
	 */
	public boolean createAndValidateDocumentTypes() {
	    if (!createDocumentTypes(glCategories)) {
	        return false;
	    }
	    
	    return validateDocumentTypeSetup();
	}

	/**
	 * Create document types with optional GL categories.
	 * This method works even without accounting module installed.
	 * If glCategories is null or empty, GL_Category_ID will be 0.
	 * 
	 * @param glCategories map of GL category names to IDs (can be null)
	 * @return true if created
	 */
	private boolean createDocumentTypes(Map<String, Integer> glCategories)
	{
		// Get GL category IDs (default to 0 if accounting not installed)
	    int GL_None = getGLCategoryID(glCategories, "GL_None");
	    int GL_GL = getGLCategoryID(glCategories, "GL_GL");
	    int GL_ARI = getGLCategoryID(glCategories, "GL_ARI");
	    int GL_ARR = getGLCategoryID(glCategories, "GL_ARR");
	    int GL_MM = getGLCategoryID(glCategories, "GL_MM");
	    int GL_API = getGLCategoryID(glCategories, "GL_API");
	    int GL_APP = getGLCategoryID(glCategories, "GL_APP");
	    int GL_CASH = getGLCategoryID(glCategories, "GL_CASH");
	    int GL_Manufacturing = getGLCategoryID(glCategories, "GL_Manufacturing");
	    int GL_Distribution = getGLCategoryID(glCategories, "GL_Distribution");
	    int GL_Payroll = getGLCategoryID(glCategories, "GL_Payroll");
	    
	    // Create all document types
	    if (!createAccountingDocTypes(GL_GL)) {
	        return false;
	    }
	    
	    if (!createInvoiceDocTypes(GL_ARI, GL_API)) {
	        return false;
	    }
	    
	    if (!createPaymentDocTypes(GL_ARR, GL_APP, GL_CASH)) {
	        return false;
	    }
	    
	    if (!createBankingDocTypes(GL_CASH)) {
	        return false;
	    }
	    
	    if (!createInventoryDocTypes(GL_MM)) {
	        return false;
	    }
	    
	    if (!createSalesDocTypes(GL_None, GL_MM, GL_ARI)) {
	        return false;
	    }
	    
	    if (!createManufacturingDocTypes(GL_Manufacturing, GL_Distribution, GL_Payroll)) {
	        return false;
	    }
	    
	    return true;
	}
	
	/**
	 * Get GL category ID from map, return 0 if not found
	 * @param glCategories category map
	 * @param key category key
	 * @return GL_Category_ID or 0
	 */
	private int getGLCategoryID(Map<String, Integer> glCategories, String key)
	{
	    if (glCategories == null || !glCategories.containsKey(key)) {
	        return 0;
	    }
	    return glCategories.get(key);
	}
	
	/**
	 * Create accounting-related document types
	 * @return true if created
	 */
	private boolean createAccountingDocTypes(int GL_GL)
	{
		if (!AcctModelServices.isAccountingSetupAvailable()) {
			return true; // Skip if accounting module not available
		}

	    // GL Journal
	    int id = createDocType("GL Journal", Msg.getElement(m_ctx, "GL_Journal_ID"), 
	        MDocType.DOCBASETYPE_GLJournal, null, 0, 0, 1000, GL_GL, false);
	    if (id == 0) {
	        String err = "Document Type not created";
	        m_info.append(err);
	        m_trx.rollback();
	        m_trx.close();
	        return false;
	    }
	    
	    createDocType("GL Journal Batch", Msg.getElement(m_ctx, "GL_JournalBatch_ID"), 
	        MDocType.DOCBASETYPE_GLJournal, null, 0, 0, 100, GL_GL, false);

	    return true;
	}
	
	/**
	 * Create invoice document types
	 * @return true if created
	 */
	private boolean createInvoiceDocTypes(int GL_ARI, int GL_API)
	{
	    // AR Invoices
	    createDocType("AR Invoice", Msg.getElement(m_ctx, "C_Invoice_ID", true), 
	        MDocType.DOCBASETYPE_ARInvoice, null, 0, 0, 100000, GL_ARI, false);
	    createDocType("AR Invoice Indirect", Msg.getElement(m_ctx, "C_Invoice_ID", true), 
	        MDocType.DOCBASETYPE_ARInvoice, null, 0, 0, 150000, GL_ARI, false);
	    createDocType("AR Credit Memo", Msg.getMsg(m_ctx, "CreditMemo"), 
	        MDocType.DOCBASETYPE_ARCreditMemo, null, 0, 0, 170000, GL_ARI, false);
	    
	    // AP Invoices
	    createDocType("AP Invoice", Msg.getElement(m_ctx, "C_Invoice_ID", false), 
	        MDocType.DOCBASETYPE_APInvoice, null, 0, 0, 0, GL_API, false);
	    createDocType("AP CreditMemo", Msg.getMsg(m_ctx, "CreditMemo"), 
	        MDocType.DOCBASETYPE_APCreditMemo, null, 0, 0, 0, GL_API, false);
	    createDocType("Match Invoice", Msg.getElement(m_ctx, "M_MatchInv_ID", false), 
	        MDocType.DOCBASETYPE_MatchInvoice, null, 0, 0, 390000, GL_API, false);
	    
	    return true;
	}
	
	/**
	 * Create Payment document types
	 * @return true if created
	 */
	private boolean createPaymentDocTypes(int GL_ARR, int GL_APP, int GL_CASH)
	{
	    // Payments
	    createDocType("AR Receipt", Msg.getElement(m_ctx, "C_Payment_ID", true), 
	        MDocType.DOCBASETYPE_ARReceipt, null, 0, 0, 0, GL_ARR, false);
	    createDocType("AP Payment", Msg.getElement(m_ctx, "C_Payment_ID", false), 
	        MDocType.DOCBASETYPE_APPayment, null, 0, 0, 0, GL_APP, false);
	    createDocType("Allocation", "Allocation", 
	        MDocType.DOCBASETYPE_PaymentAllocation, null, 0, 0, 490000, GL_CASH, false);
	    
	    return true;
	}
	
	/**
	 * Create accounting-related document types
	 * @return true if created
	 */
	private boolean createBankingDocTypes(int GL_CASH)
	{
	    // Banking
	    createDocType("Bank Statement", Msg.getElement(m_ctx, "C_BankStatement_ID", true), 
	        MDocType.DOCBASETYPE_BankStatement, null, 0, 0, 700000, GL_CASH, false);
	    createDocType("Cash Journal", Msg.getElement(m_ctx, "C_Cash_ID", true),
	        MDocType.DOCBASETYPE_CashJournal, null, 0, 0, 750000, GL_CASH, false);
	    
	    return true;
	}

	/**
	 * Create inventory/material management document types
	 * @return true if created
	 */
	private boolean createInventoryDocTypes(int GL_MM)
	{
	    // Shipments
	    createDocType("MM Shipment", "Delivery Note", 
	        MDocType.DOCBASETYPE_MaterialDelivery, null, 0, 0, 500000, GL_MM, false);
	    createDocType("MM Shipment Indirect", "Delivery Note", 
	        MDocType.DOCBASETYPE_MaterialDelivery, null, 0, 0, 550000, GL_MM, false);
	    createDocType("MM Vendor Return", "Vendor Return", 
	        MDocType.DOCBASETYPE_MaterialDelivery, null, 0, 0, 590000, GL_MM, true);
	    
	    // Receipts
	    createDocType("MM Receipt", "Vendor Delivery", 
	        MDocType.DOCBASETYPE_MaterialReceipt, null, 0, 0, 0, GL_MM, false);
	    createDocType("MM Customer Return", "Customer Return", 
	        MDocType.DOCBASETYPE_MaterialReceipt, null, 0, 0, 570000, GL_MM, true);
	    
	    // Inventory
	    createDocType("Material Movement", Msg.getElement(m_ctx, "M_Movement_ID", false),
	        MDocType.DOCBASETYPE_MaterialMovement, null, 0, 0, 610000, GL_MM, false);
	    createDocType("Physical Inventory", Msg.getElement(m_ctx, "M_Inventory_ID", false), 
	        MDocType.DOCBASETYPE_MaterialPhysicalInventory, 
	        MDocType.DOCSUBTYPEINV_PhysicalInventory, 0, 0, 620000, GL_MM, false);
	    createDocType("Internal Use Inventory", "Internal Use Inventory", 
	        MDocType.DOCBASETYPE_MaterialPhysicalInventory, 
	        MDocType.DOCSUBTYPEINV_InternalUseInventory, 0, 0, 650000, GL_MM, false);
	    createDocType("Cost Adjustment", "Cost Adjustment", 
	        MDocType.DOCBASETYPE_MaterialPhysicalInventory, 
	        MDocType.DOCSUBTYPEINV_CostAdjustment, 0, 0, 660000, GL_MM, false);
	    
	    // Production
	    createDocType("Material Production", Msg.getElement(m_ctx, "M_Production_ID", false), 
	        MDocType.DOCBASETYPE_MaterialProduction, null, 0, 0, 630000, GL_MM, false);
	    createDocType("Project Issue", Msg.getElement(m_ctx, "C_ProjectIssue_ID", false), 
	        MDocType.DOCBASETYPE_ProjectIssue, null, 0, 0, 640000, GL_MM, false);
	    
	    return true;
	}

	/**
	 * Create sales-related document types
	 * @return true if created
	 */
	private boolean createSalesDocTypes(int GL_None, int GL_MM, int GL_ARI)
	{
	    // Get shipment/invoice doc types for linking
	    int DT_S  = getDocTypeID("MM Shipment");
	    int DT_SI = getDocTypeID("MM Shipment Indirect");
	    int DT_I  = getDocTypeID("AR Invoice");
	    int DT_II = getDocTypeID("AR Invoice Indirect");
	    int DT_IC = getDocTypeID("AR Credit Memo");
	    int DT_RM = getDocTypeID("MM Customer Return");
	    int DT_VRM = getDocTypeID("MM Vendor Return");
	    int DT_IPC = getDocTypeID("AP CreditMemo");
	    
	    // Purchase Orders
	    createDocType("Purchase Order", Msg.getElement(m_ctx, "C_Order_ID", false), 
	        MDocType.DOCBASETYPE_PurchaseOrder, null, 0, 0, 800000, GL_None, false);
	    createDocType("Match PO", Msg.getElement(m_ctx, "M_MatchPO_ID", false), 
	        MDocType.DOCBASETYPE_MatchPO, null, 0, 0, 890000, GL_None, false);
	    createDocType("Purchase Requisition", Msg.getElement(m_ctx, "M_Requisition_ID", false), 
	        MDocType.DOCBASETYPE_PurchaseRequisition, null, 0, 0, 900000, GL_None, false);
	    createDocType("Vendor Return Material", "Vendor Return Material Authorization",
	        MDocType.DOCBASETYPE_PurchaseOrder, MDocType.DOCSUBTYPESO_ReturnMaterial, 
	        DT_VRM, DT_IPC, 990000, GL_MM, false);
	    
	    // Sales Orders
	    createDocType("Binding offer", "Quotation", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_Quotation, 
	        0, 0, 10000, GL_None, false);
	    createDocType("Non binding offer", "Proposal", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_Proposal, 
	        0, 0, 20000, GL_None, false);
	    createDocType("Prepay Order", "Prepay Order", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_PrepayOrder, 
	        DT_S, DT_I, 30000, GL_None, false);
	    createDocType("Customer Return Material", "Customer Return Material Authorization", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_ReturnMaterial, 
	        DT_RM, DT_IC, 30000, GL_None, false);
	    createDocType("Standard Order", "Order Confirmation", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_StandardOrder, 
	        DT_S, DT_I, 50000, GL_None, false);
	    createDocType("Credit Order", "Order Confirmation", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_OnCreditOrder, 
	        DT_SI, DT_I, 60000, GL_None, false);
	    createDocType("Warehouse Order", "Order Confirmation", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_WarehouseOrder, 
	        DT_S, DT_I, 70000, GL_None, false);
	    
	    // POS Order
	    int DT = createDocType("POS Order", "Order Confirmation", 
	        MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_POSOrder, 
	        DT_SI, DT_II, 80000, GL_None, false);
	    
	    // Set POS as default for Sales Order window
	    createPreference("C_DocTypeTarget_ID", String.valueOf(DT), 143);
	    
	    return true;
	}

	/**
	 * Create manufacturing/distribution document types
	 * @return true if created
	 */
	private boolean createManufacturingDocTypes(int GL_Manufacturing, 
	                                           int GL_Distribution, int GL_Payroll)
	{
	    createDocType("Manufacturing Order", "Manufacturing Order", 
	        MDocType.DOCBASETYPE_ManufacturingOrder, null,
	        0, 0, 80000, GL_Manufacturing, false);
	    createDocType("Manufacturing Cost Collector","Cost Collector", 
	        MDocType.DOCBASETYPE_ManufacturingCostCollector, null, 
	        0, 0, 81000, GL_Manufacturing, false);
	    createDocType("Maintenance Order","Maintenance Order",
	        MDocType.DOCBASETYPE_MaintenanceOrder, null,
	        0, 0, 86000, GL_Manufacturing, false);
	    createDocType("Quality Order","Quality Order",
	        MDocType.DOCBASETYPE_QualityOrder, null,
	        0, 0, 87000, GL_Manufacturing, false);
	    createDocType("Distribution Order","Distribution Order", 
	        MDocType.DOCBASETYPE_DistributionOrder, null,
	        0, 0, 88000, GL_Distribution, false);
	    createDocType("Payroll","Payroll", 
	        MDocType.DOCBASETYPE_Payroll, null,
	        0, 0, 90000, GL_Payroll, false);
	    
	    return true;
	}
	
	/**
	 * Helper to get doc type ID by name
	 * @param name doc type name
	 * @return C_DocType_ID
	 */
	private int getDocTypeID(String name)
	{
	    String sql = "SELECT C_DocType_ID FROM C_DocType WHERE AD_Client_ID=? AND Name=?";
	    return DB.getSQLValueEx(m_trx.getTrxName(), sql, m_client.getAD_Client_ID(), name);
	}
	
	/**
	 * Validate accounting setup completeness
	 * @return true if valid
	 */
	private boolean validateDocumentTypeSetup()
	{
	    ProcessInfo processInfo = new ProcessInfo("Document Type Verify", 0);
	    processInfo.setAD_Client_ID(getAD_Client_ID());
	    processInfo.setAD_User_ID(getAD_User_ID());
	    processInfo.setParameter(new ProcessInfoParameter[0]);
	    processInfo.setClassName("org.compiere.process.DocumentTypeVerify");
	    
	    if (!ProcessUtil.startJavaProcess(m_ctx, processInfo, m_trx, false)) {
	        String err = "Document type verification failed. Message=" + processInfo.getSummary();
	        log.log(Level.SEVERE, err);
	        m_info.append(err);
	        m_trx.rollback();
	        m_trx.close();
	        return false;
	    }
	    
	    return true;
	}

	/**
	 *  Create Document Types with Sequence
	 *  @param Name name
	 *  @param PrintName print name
	 *  @param DocBaseType document base type
	 *  @param DocSubTypeSO sales order sub type
	 *  @param C_DocTypeShipment_ID shipment doc
	 *  @param C_DocTypeInvoice_ID invoice doc
	 *  @param StartNo start doc no
	 *  @param GL_Category_ID gl category
	 *  @param isReturnTrx is return trx
	 *  @return C_DocType_ID doc type or 0 for error
	 */
	private int createDocType (String Name, String PrintName,
		String DocBaseType, String DocSubTypeSO,
		int C_DocTypeShipment_ID, int C_DocTypeInvoice_ID,
		int StartNo, int GL_Category_ID, boolean isReturnTrx)
	{
		MSequence sequence = null;
		if (StartNo != 0)
		{
			sequence = new MSequence(m_ctx, getAD_Client_ID(), Name, StartNo, m_trx.getTrxName());
			if (!sequence.save())
			{
				log.log(Level.SEVERE, "Sequence NOT created - " + Name);
				return 0;
			}
		}
		
		MDocType dt = new MDocType (m_ctx, DocBaseType, Name, m_trx.getTrxName());
		if (PrintName != null && PrintName.length() > 0)
			dt.setPrintName(PrintName);	//	Defaults to Name
		if (DocSubTypeSO != null)
		{
			if (MDocType.DOCBASETYPE_MaterialPhysicalInventory.equals(DocBaseType))
			{
				dt.setDocSubTypeInv(DocSubTypeSO);
			}
			else
			{
				dt.setDocSubTypeSO(DocSubTypeSO);
			}
		}
		if (C_DocTypeShipment_ID != 0)
			dt.setC_DocTypeShipment_ID(C_DocTypeShipment_ID);
		if (C_DocTypeInvoice_ID != 0)
			dt.setC_DocTypeInvoice_ID(C_DocTypeInvoice_ID);
		if (GL_Category_ID != 0)
			dt.setGL_Category_ID(GL_Category_ID);
		if (sequence == null)
			dt.setIsDocNoControlled(false);
		else
		{
			dt.setIsDocNoControlled(true);
			dt.setDocNoSequence_ID(sequence.getAD_Sequence_ID());
		}
		dt.setIsSOTrx();
		if (isReturnTrx)
			dt.setIsSOTrx(!dt.isSOTrx());
		if (!dt.save())
		{
			log.log(Level.SEVERE, "DocType NOT created - " + Name);
			return 0;
		}
		//
		return dt.getC_DocType_ID();
	}   //  createDocType
	
	/**
	 * Create calendar for the client
	 * @return C_Calendar_ID or -1 if failed
	 */
	public int createCalendar() {
	    m_calendar = new MCalendar(m_client);
	    if (!m_calendar.save()) {
	        String err = "Calendar NOT inserted";
	        log.log(Level.SEVERE, err);
	        m_info.append(err);
	        m_trx.rollback();
	        m_trx.close();
	        return -1;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_Calendar_ID"))
	         .append("=").append(m_calendar.getName()).append("\n");
	    
	    if (m_calendar.createYear(m_client.getLocale()) == null) {
	        log.log(Level.SEVERE, "Year NOT inserted");
	    }
	    
	    return m_calendar.getC_Calendar_ID();
	}
	
	/**
	 *  <pre>
	 *  Create default main entities.
	 *  - Dimensions, BPGroup and Product Category
	 *  - Location, Locator, Warehouse
	 *  - PriceList
	 *  - Cashbook, PaymentTerm
	 *  </pre>
	 *  @param C_Country_ID country
	 *  @param City city
	 *  @param C_Region_ID region
	 *  @param C_Currency_ID currency
	 *  @param postal
	 *  @param address1
	 *  @return true if created
	 */
	public boolean createEntities (int C_Country_ID, String City, int C_Region_ID, int C_Currency_ID, String postal, String address1)
	{
	    boolean hasAccounting = (C_AcctSchema_ID > 0);
	    if (!hasAccounting) {
	    	if (log.isLoggable(Level.INFO)) log.info("No accounting schema - entities will be created without accounting links");
	    }

		if (log.isLoggable(Level.INFO)) log.info("C_Country_ID=" + C_Country_ID 
			+ ", City=" + City + ", C_Region_ID=" + C_Region_ID);
		m_info.append("\n----\n");
		
		try {
			// 1. Create marketing and sales dimensions
	        DimensionIDs dimensions = createMarketingDimensions();
	        if (dimensions == null) {
	            return false;
	        }
	        
	        // 2. Create business partner master data
	        MBPartner standardBP = createBusinessPartnerSetup(C_Country_ID, City, C_Region_ID);
	        if (standardBP == null) {
	            return false;
	        }
	        
	        // 3. Create product and tax master data
	        MProduct standardProduct = createProductSetup(C_Country_ID);
	        if (standardProduct == null) {
	            return false;
	        }
	        
	        // 4. Create warehouse and location setup
	        if (!createWarehouseSetup(C_Country_ID, City, C_Region_ID, postal, address1)) {
	            return false;
	        }
	        
	        // 5. Create pricing and payment setup
	        if (!createPricingSetup(C_Currency_ID, standardProduct)) {
	            return false;
	        }
	        
	        // 6. Create project setup
	        int C_Project_ID = createProjectSetup(C_Currency_ID);
	        if (C_Project_ID <= 0) {
	            return false;
	        }
	        
	        // 7. Create finance setup (CashBook)
	        if (!createFinanceSetup(C_Currency_ID)) {
	            return false;
	        }
	        
	        // 8. Update client configuration
	        if (!updateClientEntities(standardBP, standardProduct)) {
	            return false;
	        }
	        
	        // Link to accounting schema if accounting is installed
	        if (hasAccounting) {
	            if (!linkEntitiesToAccounting(dimensions, standardBP, standardProduct, C_Project_ID)) {
	                return false;
	            }
	        }
	        
	        // Commit if not dry run
	        if (m_dryRun) {
	            if (log.isLoggable(Level.INFO)) log.info("Dry run - skipping commit");
	            return true;
	        }
	        
	        boolean success = m_trx.commit();
	        m_trx.close();
	        if (log.isLoggable(Level.INFO)) log.info("Entity setup completed");
	        return success;
	        
		} catch (Exception e) {
	        String err = "Entity setup failed: " + e.getMessage();
	        log.log(Level.SEVERE, err, e);
	        m_info.append(err);
	        m_trx.rollback();
	        m_trx.close();
	        return false;
	    }
	}   //  createEntities
	
	/**
	 * Create marketing and sales dimensions:
	 * - Marketing Channel & Campaign
	 * - Sales Region
	 * - Activity
	 * 
	 * @return DimensionIDs object with created dimension IDs, or null if failed
	 */
	private DimensionIDs createMarketingDimensions()
	{
	    String defaultName = Msg.translate(m_lang, "Standard");
	    
	    // Create Marketing Channel
	    int C_Channel_ID = createMarketingChannel(defaultName);
	    if (C_Channel_ID == 0) {
	        return null;
	    }
	    
	    // Create Marketing Campaign
	    int C_Campaign_ID = createMarketingCampaign(defaultName, C_Channel_ID);
	    if (C_Campaign_ID == 0) {
	        return null;
	    }
	    
	    // Create Sales Region
	    int C_SalesRegion_ID = createSalesRegion(defaultName);
	    if (C_SalesRegion_ID == 0) {
	        return null;
	    }
	    
	    // Create Activity
	    int C_Activity_ID = createActivity(defaultName);
	    if (C_Activity_ID == 0) {
	        return null;
	    }
	    
	    return new DimensionIDs(C_Campaign_ID, C_SalesRegion_ID, C_Activity_ID);
	}

	/**
	 * Create marketing channel
	 * @param name channel name
	 * @return C_Channel_ID or 0 if failed
	 */
	private int createMarketingChannel(String name)
	{
	    int C_Channel_ID = getNextID(getAD_Client_ID(), "C_Channel");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_Channel ");
	    sql.append("(C_Channel_ID,Name,");
	    sql.append(m_stdColumns).append(",C_Channel_UU) VALUES (");
	    sql.append(C_Channel_ID).append(",'").append(name).append("',");
	    sql.append(m_stdValues).append(",").append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "Channel NOT inserted");
	        return 0;
	    }
	    
	    return C_Channel_ID;
	}

	/**
	 * Create marketing campaign
	 * @param name campaign name
	 * @param C_Channel_ID channel
	 * @return C_Campaign_ID or 0 if failed
	 */
	private int createMarketingCampaign(String name, int C_Channel_ID)
	{
	    int C_Campaign_ID = getNextID(getAD_Client_ID(), "C_Campaign");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_Campaign ");
	    sql.append("(C_Campaign_ID,C_Channel_ID,").append(m_stdColumns).append(",");
	    sql.append(" Value,Name,Costs,C_Campaign_UU) VALUES (");
	    sql.append(C_Campaign_ID).append(",").append(C_Channel_ID).append(",");
	    sql.append(m_stdValues).append(",").append(DB.TO_STRING(name)).append(",")
	    .append(DB.TO_STRING(name)).append(",");
	    sql.append("0,").append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "Campaign NOT inserted");
	        return 0;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_Campaign_ID"))
	         .append("=").append(name).append("\n");
	    
	    // Create translations
	    createTranslations("C_Campaign", C_Campaign_ID);
	    
	    return C_Campaign_ID;
	}

	/**
	 * Create sales region
	 * @param name region name
	 * @return C_SalesRegion_ID or 0 if failed
	 */
	private int createSalesRegion(String name)
	{
	    int C_SalesRegion_ID = getNextID(getAD_Client_ID(), "C_SalesRegion");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_SalesRegion ");
	    sql.append("(C_SalesRegion_ID,").append(m_stdColumns).append(",");
	    sql.append(" Value,Name,IsSummary,C_SalesRegion_UU) VALUES (");
	    sql.append(C_SalesRegion_ID).append(",").append(m_stdValues).append(",");
	    sql.append(DB.TO_STRING(name)).append(",").append(DB.TO_STRING(name)).append(",'N',");
	    sql.append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "SalesRegion NOT inserted");
	        return 0;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_SalesRegion_ID"))
	         .append("=").append(name).append("\n");
	    
	    // Create translations
	    createTranslations("C_SalesRegion", C_SalesRegion_ID);
	    
	    return C_SalesRegion_ID;
	}

	/**
	 * Create activity
	 * @param name activity name
	 * @return C_Activity_ID or 0 if failed
	 */
	private int createActivity(String name)
	{
	    int C_Activity_ID = getNextID(getAD_Client_ID(), "C_Activity");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_Activity ");
	    sql.append("(C_Activity_ID,").append(m_stdColumns).append(",");
	    sql.append(" Value,Name,IsSummary,C_Activity_UU) VALUES (");
	    sql.append(C_Activity_ID).append(",").append(m_stdValues).append(",");
	    sql.append(DB.TO_STRING(name)).append(",").append(DB.TO_STRING(name)).append(",'N',");
	    sql.append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "Activity NOT inserted");
	        return 0;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_Activity_ID"))
	         .append("=").append(name).append("\n");
	    
	    // Create translations
	    createTranslations("C_Activity", C_Activity_ID);
	    
	    return C_Activity_ID;
	}

	/**
	 * Create translations for an entity
	 * @param tableName table name (without _Trl)
	 * @param recordID record ID
	 */
	private void createTranslations(String tableName, int recordID)
	{
	    String idColumn = tableName + "_ID";
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO ").append(tableName).append("_Trl ");
	    sql.append("(AD_Language,").append(idColumn).append(", Description,Name, ");
	    sql.append("IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,");
	    sql.append(tableName).append("_Trl_UU)");
	    sql.append(" SELECT l.AD_Language,t.").append(idColumn).append(", t.Description,t.Name, ");
	    sql.append("'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy, ");
	    sql.append("generate_uuid() FROM AD_Language l, ").append(tableName).append(" t");
	    sql.append(" WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N'");
	    sql.append(" AND t.").append(idColumn).append("=").append(recordID);
	    sql.append(" AND NOT EXISTS (SELECT * FROM ").append(tableName).append("_Trl tt ");
	    sql.append("WHERE tt.AD_Language=l.AD_Language AND tt.").append(idColumn).append("=t.").append(idColumn).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no < 0) {
	        log.log(Level.SEVERE, tableName + " Translation NOT inserted");
	    }
	}
	
	/**
	 * Create business partner setup:
	 * - BP Group
	 * - Standard BPartner
	 * - BP Location
	 * - Link to accounting schema
	 * 
	 * @param C_Country_ID country
	 * @param city city
	 * @param C_Region_ID region
	 * @return standard BPartner or null if failed
	 */
	private MBPartner createBusinessPartnerSetup(int C_Country_ID, String city, int C_Region_ID)
	{
	    String defaultName = Msg.translate(m_lang, "Standard");
	    
	    // Create BP Group
	    MBPGroup bpg = new MBPGroup(m_ctx, 0, m_trx.getTrxName());
	    bpg.setAD_Org_ID(0);
	    bpg.setValue(defaultName);
	    bpg.setName(defaultName);
	    bpg.setIsDefault(true);
	    if (!bpg.save()) {
	        log.log(Level.SEVERE, "BP Group NOT inserted");
	        return null;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_BP_Group_ID"))
	         .append("=").append(defaultName).append("\n");
	    
	    // Create Standard BPartner
	    MBPartner bp = new MBPartner(m_ctx, 0, m_trx.getTrxName());
	    bp.setAD_Org_ID(0);
	    bp.setValue(defaultName);
	    bp.setName(defaultName);
	    bp.setBPGroup(bpg);
	    if (!bp.save()) {
	        log.log(Level.SEVERE, "BPartner NOT inserted");
	        return null;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_BPartner_ID"))
	         .append("=").append(defaultName).append("\n");
	    
	    // Create Location for Standard BP
	    MLocation bpLoc = new MLocation(m_ctx, C_Country_ID, C_Region_ID, city, m_trx.getTrxName());
	    bpLoc.setAD_Org_ID(0);
	    bpLoc.saveEx();
	    
	    MBPartnerLocation bpl = new MBPartnerLocation(bp);
	    bpl.setC_Location_ID(bpLoc.getC_Location_ID());
	    if (!bpl.save()) {
	        log.log(Level.SEVERE, "BP_Location (Standard) NOT inserted");
	        return null;
	    }
	    
	    // Create user preference
	    createPreference("C_BPartner_ID", String.valueOf(bp.getC_BPartner_ID()), 143);
	    
        // 8. Create sales representatives for users
        if (!createSalesRepresentatives(C_Country_ID, city, C_Region_ID, bpg)) {
            return null;
        }
	    
	    return bp;
	}
	
	/**
	 * Create product and tax setup:
	 * - Product Category
	 * - Tax Category & Tax
	 * - Standard Product
	 * - Link to accounting schema
	 * 
	 * @param C_Country_ID country for tax setup
	 * @return standard Product or null if failed
	 */
	private MProduct createProductSetup(int C_Country_ID)
	{
	    String defaultName = Msg.translate(m_lang, "Standard");
	    
	    // Create Product Category
	    MProductCategory pc = new MProductCategory(m_ctx, 0, m_trx.getTrxName());
	    pc.setAD_Org_ID(0);
	    pc.setValue(defaultName);
	    pc.setName(defaultName);
	    pc.setIsDefault(true);
	    if (!pc.save()) {
	        log.log(Level.SEVERE, "Product Category NOT inserted");
	        return null;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "M_Product_Category_ID"))
	         .append("=").append(defaultName).append("\n");
	    
	    // Create Tax Category
	    int C_TaxCategory_ID = createTaxCategory(C_Country_ID);
	    if (C_TaxCategory_ID == 0) {
	        return null;
	    }
	    
	    // Create Default Tax (Zero Rate)
	    MTax tax = createDefaultTax(C_TaxCategory_ID);
	    if (tax == null) {
	        return null;
	    }
	    
	    // Create Standard Product
	    int C_UOM_ID = 100; // EA (Each)
	    
	    MProduct product = new MProduct(m_ctx, 0, m_trx.getTrxName());
	    product.setAD_Org_ID(0);
	    product.setValue(defaultName);
	    product.setName(defaultName);
	    product.setC_UOM_ID(C_UOM_ID);
	    product.setM_Product_Category_ID(pc.getM_Product_Category_ID());
	    product.setC_TaxCategory_ID(C_TaxCategory_ID);
	    if (!product.save()) {
	        log.log(Level.SEVERE, "Product NOT inserted");
	        return null;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "M_Product_ID"))
	         .append("=").append(defaultName).append("\n");
	    
	    return product;
	}

	/**
	 * Create tax category
	 * @param C_Country_ID country
	 * @return C_TaxCategory_ID or 0 if failed
	 */
	private int createTaxCategory(int C_Country_ID)
	{
	    int C_TaxCategory_ID = getNextID(getAD_Client_ID(), "C_TaxCategory");
	    
	    String taxName = (C_Country_ID == COUNTRY_US) ? "Sales Tax" : 
	                     Msg.translate(m_lang, "Standard");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_TaxCategory ");
	    sql.append("(C_TaxCategory_ID,").append(m_stdColumns).append(",");
	    sql.append(" Name,IsDefault,C_TaxCategory_UU) VALUES (");
	    sql.append(C_TaxCategory_ID).append(",").append(m_stdValues).append(",");
	    sql.append(DB.TO_STRING(taxName)).append(",'Y',");
	    sql.append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "TaxCategory NOT inserted");
	        return 0;
	    }
	    
	    // Create translations
	    createTranslations("C_TaxCategory", C_TaxCategory_ID);
	    
	    return C_TaxCategory_ID;
	}

	/**
	 * Create default tax (zero rate)
	 * @param C_TaxCategory_ID tax category
	 * @return tax or null if failed
	 */
	private MTax createDefaultTax(int C_TaxCategory_ID)
	{
	    MTax tax = new MTax(m_ctx, "Standard", Env.ZERO, C_TaxCategory_ID, m_trx.getTrxName());
	    tax.setAD_Org_ID(0);
	    tax.setIsDefault(true);
	    if (!tax.save()) {
	        log.log(Level.SEVERE, "Tax NOT inserted");
	        return null;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_Tax_ID"))
	         .append("=").append(tax.getName()).append("\n");
	    
	    return tax;
	}
	
	/**
	 * Create warehouse and location setup:
	 * - Organization Location
	 * - Warehouse
	 * - Default Locator
	 * 
	 * @param C_Country_ID country
	 * @param city city
	 * @param C_Region_ID region
	 * @param postal postal code
	 * @param address1 address
	 * @return true if created
	 */
	private boolean createWarehouseSetup(int C_Country_ID, String city, int C_Region_ID,
	                                    String postal, String address1)
	{
	    String defaultName = Msg.translate(m_lang, "Standard");
	    
	    // Create Organization Location
	    MLocation orgLoc = new MLocation(m_ctx, C_Country_ID, C_Region_ID, city, m_trx.getTrxName());
	    orgLoc.setAddress1(address1);
	    orgLoc.setPostal(postal);
	    orgLoc.saveEx();
	    
	    // Update OrgInfo with location
	    StringBuilder sql = new StringBuilder("UPDATE AD_OrgInfo SET C_Location_ID=");
	    sql.append(orgLoc.getC_Location_ID())
	       .append(" WHERE AD_Org_ID=").append(getAD_Org_ID());
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "OrgInfo Location NOT updated");
	        return false;
	    }
	    
	    // Create Country preference
	    createPreference("C_Country_ID", String.valueOf(C_Country_ID), 0);
	    
	    // Create Warehouse Location
	    MLocation whLoc = new MLocation(m_ctx, C_Country_ID, C_Region_ID, city, m_trx.getTrxName());
	    whLoc.setAddress1(address1);
	    whLoc.setPostal(postal);
	    whLoc.saveEx();
	    
	    // Create Warehouse
	    MWarehouse wh = new MWarehouse(m_ctx, 0, m_trx.getTrxName());
	    wh.setValue(defaultName);
	    wh.setName(defaultName);
	    wh.setC_Location_ID(whLoc.getC_Location_ID());
	    if (!wh.save()) {
	        log.log(Level.SEVERE, "Warehouse NOT inserted");
	        return false;
	    }
	    
	    // Create Default Locator
	    MLocator locator = new MLocator(wh, defaultName);
	    locator.setIsDefault(true);
	    if (!locator.save()) {
	        log.log(Level.SEVERE, "Locator NOT inserted");
	        return false;
	    }
	    
	    return true;
	}

	/**
	 * Create pricing and payment setup:
	 * - Price List
	 * - Discount Schema
	 * - Price List Version
	 * - Product Price
	 * - Payment Term
	 * 
	 * @param C_Currency_ID currency
	 * @param product product for pricing
	 * @return true if created
	 */
	private boolean createPricingSetup(int C_Currency_ID, MProduct product)
	{
	    String defaultName = Msg.translate(m_lang, "Standard");
	    
	    // Create Price List
	    MPriceList pl = new MPriceList(m_ctx, 0, m_trx.getTrxName());
	    pl.setAD_Org_ID(0);
	    pl.setName(defaultName);
	    pl.setC_Currency_ID(C_Currency_ID);
	    pl.setIsDefault(true);
	    if (!pl.save()) {
	        log.log(Level.SEVERE, "PriceList NOT inserted");
	        return false;
	    }
	    
	    // Create Discount Schema
	    MDiscountSchema ds = new MDiscountSchema(m_ctx, 0, m_trx.getTrxName());
	    ds.setAD_Org_ID(0);
	    ds.setName(defaultName);
	    ds.setDiscountType(MDiscountSchema.DISCOUNTTYPE_Pricelist);
	    if (!ds.save()) {
	        log.log(Level.SEVERE, "DiscountSchema NOT inserted");
	        return false;
	    }
	    
	    // Create Price List Version
	    MPriceListVersion plv = new MPriceListVersion(pl);
	    plv.setAD_Org_ID(0);
	    plv.setName();
	    plv.setM_DiscountSchema_ID(ds.getM_DiscountSchema_ID());
	    if (!plv.save()) {
	        log.log(Level.SEVERE, "PriceList_Version NOT inserted");
	        return false;
	    }
	    
	    // Create Product Price
	    MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), 
	        Env.ONE, Env.ONE, Env.ONE);
	    if (!pp.save()) {
	        log.log(Level.SEVERE, "ProductPrice NOT inserted");
	        return false;
	    }
	    
	    // Create Payment Term
	    if (!createPaymentTerm()) {
	        return false;
	    }
	    
	    return true;
	}

	/**
	 * Create default payment term (Immediate)
	 * @return true if created
	 */
	private boolean createPaymentTerm()
	{
	    int C_PaymentTerm_ID = getNextID(getAD_Client_ID(), "C_PaymentTerm");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_PaymentTerm ");
	    sql.append("(C_PaymentTerm_ID,").append(m_stdColumns).append(",");
	    sql.append("Value,Name,NetDays,GraceDays,DiscountDays,Discount,");
	    sql.append("DiscountDays2,Discount2,IsDefault,C_PaymentTerm_UU) VALUES (");
	    sql.append(C_PaymentTerm_ID).append(",").append(m_stdValues).append(",");
	    sql.append("'Immediate','Immediate',0,0,0,0,0,0,'Y',");
	    sql.append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "PaymentTerm NOT inserted");
	        return false;
	    }
	    
	    // Create translations
	    createTranslations("C_PaymentTerm", C_PaymentTerm_ID);
	    
	    return true;
	}

	/**
	 * Create project setup:
	 * - Project Cycle
	 * - Default Project
	 * 
	 * @param C_Currency_ID currency
	 * @return C_Project_ID of default project or -1 if failed
	 */
	private int createProjectSetup(int C_Currency_ID)
	{
	    String defaultName = Msg.translate(m_lang, "Standard");
	    
	    // Create Project Cycle
	    C_Cycle_ID = getNextID(getAD_Client_ID(), "C_Cycle");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_Cycle ");
	    sql.append("(C_Cycle_ID,").append(m_stdColumns).append(",");
	    sql.append(" Name,C_Currency_ID,C_Cycle_UU) VALUES (");
	    sql.append(C_Cycle_ID).append(",").append(m_stdValues).append(",");
	    sql.append(DB.TO_STRING(defaultName)).append(",").append(C_Currency_ID).append(",");
	    sql.append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "Cycle NOT inserted");
	        return -1;
	    }
	    
	    // Create Default Project
	    int C_Project_ID = getNextID(getAD_Client_ID(), "C_Project");
	    
	    sql = new StringBuilder("INSERT INTO C_Project ");
	    sql.append("(C_Project_ID,").append(m_stdColumns).append(",");
	    sql.append(" Value,Name,C_Currency_ID,IsSummary,C_Project_UU) VALUES (");
	    sql.append(C_Project_ID).append(",").append(m_stdValuesOrg).append(",");
	    sql.append(DB.TO_STRING(defaultName)).append(",")
	    .append(DB.TO_STRING(defaultName)).append(",");
	    sql.append(C_Currency_ID).append(",'N',");
	    sql.append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "Project NOT inserted");
	        return -1;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_Project_ID"))
	         .append("=").append(defaultName).append("\n");
	    
	    return C_Project_ID;
	}

	/**
	 * Create finance setup:
	 * - CashBook
	 * 
	 * @param C_Currency_ID currency
	 * @return true if created
	 */
	private boolean createFinanceSetup(int C_Currency_ID)
	{
	    String defaultName = Msg.translate(m_lang, "Standard");
	    
	    // Create CashBook
	    MCashBook cb = new MCashBook(m_ctx, 0, m_trx.getTrxName());
	    cb.setName(defaultName);
	    cb.setC_Currency_ID(C_Currency_ID);
	    if (!cb.save()) {
	        log.log(Level.SEVERE, "CashBook NOT inserted");
	        return false;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "C_CashBook_ID"))
	         .append("=").append(defaultName).append("\n");
	    
	    return true;
	}

	/**
	 * Create sales representatives for users:
	 * - BPartner for Client Admin User
	 * - BPartner for Client Org User
	 * 
	 * @param C_Country_ID country
	 * @param city city
	 * @param C_Region_ID region
	 * @return true if created
	 */
	private boolean createSalesRepresentatives(int C_Country_ID, String city, int C_Region_ID, MBPGroup bpg)
	{
	    // Create Sales Rep for Client-User 
	    if (!createSalesRep(AD_User_ID, AD_User_Name, C_Country_ID, 
	    		city, C_Region_ID, bpg)) {
	        return false;
	    }
	    
	    // Create Sales Rep for Client-Admin
	    if (!createSalesRep(AD_User_U_ID, AD_User_U_Name, C_Country_ID, 
	    		city, C_Region_ID, bpg)) {
	        return false;
	    }
	    
	    return true;
	}

	/**
	 * Create sales representative
	 * @param AD_User_ID user ID
	 * @param userName user name
	 * @param C_BP_Group_ID bp group
	 * @param C_Country_ID country
	 * @param city city
	 * @param C_Region_ID region
	 * @return true if created
	 */
	private boolean createSalesRep(int AD_User_ID, String userName, int C_Country_ID,  
	                              String city, int C_Region_ID, MBPGroup bpg)
	{
	    // Create BPartner
	    MBPartner bp = new MBPartner(m_ctx, 0, m_trx.getTrxName());
	    bp.setAD_Org_ID(0);
	    bp.setValue(userName);
	    bp.setName(userName);
		bp.setBPGroup(bpg);
	    bp.setIsEmployee(true);
	    bp.setIsSalesRep(true);
	    if (!bp.save()) {
	        log.log(Level.SEVERE, "SalesRep NOT inserted - " + userName);
	        return false;
	    }
	    
	    m_info.append(Msg.translate(m_lang, "SalesRep_ID"))
	         .append("=").append(userName).append("\n");
	    
	    // Create Location
	    MLocation loc = new MLocation(m_ctx, C_Country_ID, C_Region_ID, city, m_trx.getTrxName());
	    loc.setAD_Org_ID(0);
	    loc.saveEx();
	    
	    MBPartnerLocation bpl = new MBPartnerLocation(bp);
	    bpl.setC_Location_ID(loc.getC_Location_ID());
	    if (!bpl.save()) {
	        log.log(Level.SEVERE, "BP_Location NOT inserted - " + userName);
	        return false;
	    }
	    
	    // Update User with BPartner link
	    StringBuilder sql = new StringBuilder("UPDATE AD_User SET C_BPartner_ID=");
	    sql.append(bp.getC_BPartner_ID())
	       .append(" WHERE AD_User_ID=").append(AD_User_ID);
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        log.log(Level.SEVERE, "User BPartner link NOT updated - " + userName);
	        return false;
	    }
	    
	    return true;
	}

	/**
	 * Update client with entity references
	 * @param standardBP standard business partner
	 * @param standardProduct standard product
	 * @return true if updated
	 */
	private boolean updateClientEntities(MBPartner standardBP, MProduct standardProduct)
	{
	    StringBuilder sql = new StringBuilder("UPDATE AD_ClientInfo SET ");
	    sql.append("C_BPartnerCashTrx_ID=").append(standardBP.getC_BPartner_ID());
	    sql.append(",M_ProductFreight_ID=").append(standardProduct.getM_Product_ID());
	    sql.append(" WHERE AD_Client_ID=").append(getAD_Client_ID());
	    
	    int no = DB.executeUpdateEx(sql.toString(), m_trx.getTrxName());
	    if (no != 1) {
	        String err = "ClientInfo not updated";
	        log.log(Level.SEVERE, err);
	        m_info.append(err);
	        return false;
	    }
	    
	    return true;
	}

	/**
	 *  Create Preference
	 *  @param Attribute attribute name
	 *  @param Value attribute value
	 *  @param AD_Window_ID window
	 */
	private void createPreference (String Attribute, String Value, int AD_Window_ID)
	{
		int AD_Preference_ID = getNextID(getAD_Client_ID(), "AD_Preference");
		StringBuilder sqlCmd = new StringBuilder ("INSERT INTO AD_Preference ");
		sqlCmd.append("(AD_Preference_ID,").append("AD_Preference_UU,").append(m_stdColumns).append(",");
		sqlCmd.append("Attribute,Value,AD_Window_ID) VALUES (");
		sqlCmd.append(AD_Preference_ID).append(",").append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(",").append(m_stdValues).append(",");
		sqlCmd.append("'").append(Attribute).append("','").append(Value).append("',");
		if (AD_Window_ID == 0)
			sqlCmd.append("NULL)");
		else
			sqlCmd.append(AD_Window_ID).append(")");
		int no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "Preference NOT inserted - " + Attribute);
	}   //  createPreference
	
	/**
	 * 	Get Next ID
	 * 	@param AD_Client_ID client
	 * 	@param TableName table name
	 * 	@return id
	 */
	private int getNextID (int AD_Client_ID, String TableName)
	{
		//	TODO: Exception 
		return DB.getNextID (AD_Client_ID, TableName, m_trx.getTrxName());
	}	//	getNextID

	/**
	 *  Get Client
	 *  @return AD_Client_ID
	 */
	public int getAD_Client_ID()
	{
		return m_client.getAD_Client_ID();
	}
	
	/**
	 * 	Get AD_Org_ID
	 *	@return AD_Org_ID
	 */
	public int getAD_Org_ID()
	{
		return m_org.getAD_Org_ID();
	}
	
	/**
	 * 	Get AD_User_ID
	 *	@return AD_User_ID
	 */
	public int getAD_User_ID()
	{
		return AD_User_ID;
	}
	
	/**
	 * 	Get Info
	 *	@return Info
	 */
	public String getInfo()
	{
		return m_info.toString();
	}

	/**
	 * 	Rollback Internal Transaction
	 */
	public void rollback() {
		try {
			m_trx.rollback();
			m_trx.close();
		} catch (Exception e) {}
	}

	/**
	 * 
	 * @return trxName
	 */
	public String getTrxName() {
		return m_trx != null ? m_trx.getTrxName() : null;
	}
	
	/**
	 * Link created entities to accounting schema (ACCOUNTING-SPECIFIC)
	 * This method calls the accounting service to link dimensions.
	 * 
	 * @param dimensions marketing dimensions
	 * @param standardBP standard business partner
	 * @param standardProduct standard product
	 * @param projects project IDs
	 * @return true if linked
	 */
	private boolean linkEntitiesToAccounting(DimensionIDs dimensions, 
	                                        MBPartner standardBP,
	                                        MProduct standardProduct,
	                                        int C_Project_ID)
	{
		IAccountingSetupService acctService = null;
		if (AcctModelServices.isAccountingSetupAvailable()) {
			acctService = AcctModelServices.getAccountingSetupService();
		}

	    if (acctService == null) {
	        log.warning("Accounting service not available - skipping dimension links");
	        return true; // Not an error, just skip
	    }
	    
	    // Link Campaign
	    if (m_hasMCampaign && dimensions.C_Campaign_ID > 0) {
	        if (!acctService.linkDimensionToAcctSchema(C_AcctSchema_ID, "MC", 
	                                                  dimensions.C_Campaign_ID, 
	                                                  m_trx.getTrxName())) {
	            log.severe("Failed to link Campaign to AcctSchema");
	            return false;
	        }
	    }
	    
	    // Link Sales Region
	    if (m_hasSRegion && dimensions.C_SalesRegion_ID > 0) {
	        if (!acctService.linkDimensionToAcctSchema(C_AcctSchema_ID, "SR",
	                                                  dimensions.C_SalesRegion_ID,
	                                                  m_trx.getTrxName())) {
	            log.severe("Failed to link Sales Region to AcctSchema");
	            return false;
	        }
	    }
	    
	    // Link Activity
	    if (m_hasActivity && dimensions.C_Activity_ID > 0) {
	        if (!acctService.linkDimensionToAcctSchema(C_AcctSchema_ID, "AY",
	                                                  dimensions.C_Activity_ID,
	                                                  m_trx.getTrxName())) {
	            log.severe("Failed to link Activity to AcctSchema");
	            return false;
	        }
	    }
	    
	    // Link BPartner
	    if (standardBP != null) {
	        if (!acctService.linkDimensionToAcctSchema(C_AcctSchema_ID, "BP",
	                                                  standardBP.getC_BPartner_ID(),
	                                                  m_trx.getTrxName())) {
	            log.severe("Failed to link BPartner to AcctSchema");
	            return false;
	        }
	    }
	    
	    // Link Product
	    if (standardProduct != null) {
	        if (!acctService.linkDimensionToAcctSchema(C_AcctSchema_ID, "PR",
	                                                  standardProduct.getM_Product_ID(),
	                                                  m_trx.getTrxName())) {
	            log.severe("Failed to link Product to AcctSchema");
	            return false;
	        }
	    }
	    
	    // Link Project
	    if (m_hasProject && C_Project_ID > 0) {
	        if (!acctService.linkDimensionToAcctSchema(C_AcctSchema_ID, "PJ",
	                                                  C_Project_ID,
	                                                  m_trx.getTrxName())) {
	            log.severe("Failed to link Project to AcctSchema");
	            return false;
	        }
	    }
	    
	    return true;
	}
	
	// Helper classes to return multiple IDs
	private static class DimensionIDs {
	    int C_Campaign_ID;
	    int C_SalesRegion_ID;
	    int C_Activity_ID;
	    
	    DimensionIDs(int campaign, int salesRegion, int activity) {
	        this.C_Campaign_ID = campaign;
	        this.C_SalesRegion_ID = salesRegion;
	        this.C_Activity_ID = activity;
	    }
	}
}   //  MSetup

