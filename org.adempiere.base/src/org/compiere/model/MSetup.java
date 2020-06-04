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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.ProcessUtil;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

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
	/**
	 *  Constructor
	 *  @param ctx context
	 *  @param WindowNo window
	 */
	public MSetup(Properties ctx, int WindowNo)
	{
		m_ctx = new Properties(ctx);	//	copy
		m_lang = Env.getAD_Language(m_ctx);
		m_WindowNo = WindowNo;
	}   //  MSetup

	/**	Logger			*/
	protected CLogger	log = CLogger.getCLogger(getClass());

	private Trx				m_trx = Trx.get(Trx.createTrxName("Setup"), true);
	private Properties      m_ctx;
	private String          m_lang;
	private int             m_WindowNo;
	private StringBuffer    m_info;
	//
	private String          m_clientName;
//	private String          m_orgName;
	//
	private String          m_stdColumns = "AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy";
	private String          m_stdValues;
	private String          m_stdValuesOrg;
	//
	private NaturalAccountMap<String,MElementValue> m_nap = null;
	//
	private MClient			m_client;
	private MOrg			m_org;
	private MAcctSchema		m_as;
	//
	private int     		AD_User_ID;
	private String  		AD_User_Name;
	private int     		AD_User_U_ID;
	private String  		AD_User_U_Name;
	private MCalendar		m_calendar;
	private int     		m_AD_Tree_Account_ID;
	private int     		C_Cycle_ID;
	//
	private boolean         m_hasProject = false;
	private boolean         m_hasMCampaign = false;
	private boolean         m_hasSRegion = false;
	private boolean         m_hasActivity = false;

	/**
	 *  Create Client Info.
	 *  - Client, Trees, Org, Role, User, User_Role
	 *  @param clientName client name
	 *  @param orgName org name
	 *  @param userClient user id client
	 *  @param userOrg user id org
	 *  @param isSetInitialPassword 
	 *  @return true if created
	 */
	public boolean createClient (String clientName, String orgValue, String orgName,
		String userClient, String userOrg, String phone, String phone2, String fax, String eMail, String taxID,
		String adminEmail, String userEmail, boolean isSetInitialPassword)
	{
		log.info(clientName);
		m_trx.setDisplayName(getClass().getName()+"_createClient");
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
		m_client.setName(m_clientName);
		if (!m_client.save())
		{
			String err = "Client NOT created";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		int AD_Client_ID = m_client.getAD_Client_ID();
		Env.setContext(m_ctx, m_WindowNo, "AD_Client_ID", AD_Client_ID);
		Env.setContext(m_ctx, "#AD_Client_ID", AD_Client_ID);

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
			String err = "Client Info NOT created";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		m_AD_Tree_Account_ID = m_client.getSetup_AD_Tree_Account_ID();

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
		Env.setContext(m_ctx, "#AD_Org_ID", getAD_Org_ID());
		m_stdValuesOrg = AD_Client_ID + "," + getAD_Org_ID() + ",'Y',getDate(),0,getDate(),0";
		//  Info
		m_info.append(Msg.translate(m_lang, "AD_Org_ID")).append("=").append(name).append("\n");
		
		// Set Organization Phone, Phone2, Fax, EMail
		MOrgInfo orgInfo = MOrgInfo.get(m_ctx, getAD_Org_ID(), m_trx.getTrxName());
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

		name = userClient;
		if (name == null || name.length() == 0)
			name = m_clientName + "Client";

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
			+ " VALUES (" + m_stdValues + "," + AD_User_ID + "," + admin.getAD_Role_ID() + "," + DB.TO_STRING(UUID.randomUUID().toString()) + ")";
		no = DB.executeUpdateEx(sql, m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "UserRole ClientUser+Admin NOT inserted");
		sql = "INSERT INTO AD_User_Roles(" + m_stdColumns + ",AD_User_ID,AD_Role_ID,AD_User_Roles_UU)"
			+ " VALUES (" + m_stdValues + "," + AD_User_ID + "," + user.getAD_Role_ID() + "," + DB.TO_STRING(UUID.randomUUID().toString()) + ")";
		no = DB.executeUpdateEx(sql, m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "UserRole ClientUser+User NOT inserted");
		//  OrgUser             - User
		sql = "INSERT INTO AD_User_Roles(" + m_stdColumns + ",AD_User_ID,AD_Role_ID,AD_User_Roles_UU)"
			+ " VALUES (" + m_stdValues + "," + AD_User_U_ID + "," + user.getAD_Role_ID() + "," + DB.TO_STRING(UUID.randomUUID().toString()) + ")";
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

	// preserving backward compatibility with swing client
	public boolean createAccounting(KeyNamePair currency,
			boolean hasProduct, boolean hasBPartner, boolean hasProject,
			boolean hasMCampaign, boolean hasSRegion,
			File AccountingFile) {
		return createAccounting(currency,
				hasProduct, hasBPartner, hasProject,
				hasMCampaign, hasSRegion,
				false, AccountingFile, false, false);
	}

	/**************************************************************************
	 *  Create Accounting elements.
	 *  - Calendar
	 *  - Account Trees
	 *  - Account Values
	 *  - Accounting Schema
	 *  - Default Accounts
	 *
	 *  @param currency currency
	 *  @param hasProduct has product segment
	 *  @param hasBPartner has bp segment
	 *  @param hasProject has project segment
	 *  @param hasMCampaign has campaign segment
	 *  @param hasSRegion has sales region segment
	 *  @param hasActivity has activity segment
	 *  @param AccountingFile file name of accounting file
	 *  @param inactivateDefaults inactivate the default accounts after created
	 *  @param useDefaultCoA use the Default CoA (load and group summary account)
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

		//  Standard variables
		m_info = new StringBuffer();
		String name = null;
		StringBuilder sqlCmd = null;
		int no = 0;

		/**
		 *  Create Calendar
		 */
		m_calendar = new MCalendar(m_client);
		if (!m_calendar.save())
		{
			String err = "Calendar NOT inserted";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		//  Info
		m_info.append(Msg.translate(m_lang, "C_Calendar_ID")).append("=").append(m_calendar.getName()).append("\n");

		if (m_calendar.createYear(m_client.getLocale()) == null)
			log.log(Level.SEVERE, "Year NOT inserted");

		//	Create Account Elements
		name = m_clientName + " " + Msg.translate(m_lang, "Account_ID");
		MElement element = new MElement (m_client, name, 
			MElement.ELEMENTTYPE_Account, m_AD_Tree_Account_ID);
		if (!element.save())
		{
			String err = "Acct Element NOT inserted";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		int C_Element_ID = element.getC_Element_ID();
		m_info.append(Msg.translate(m_lang, "C_Element_ID")).append("=").append(name).append("\n");

		//	Create Account Values
		m_nap = new NaturalAccountMap<String,MElementValue>(m_ctx, m_trx.getTrxName());
		String errMsg = m_nap.parseFile(AccountingFile);
		if (errMsg.length() != 0)
		{
			log.log(Level.SEVERE, errMsg);
			m_info.append(errMsg);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		if (m_nap.saveAccounts(getAD_Client_ID(), getAD_Org_ID(), C_Element_ID, !inactivateDefaults))
			m_info.append(Msg.translate(m_lang, "C_ElementValue_ID")).append(" # ").append(m_nap.size()).append("\n");
		else
		{
			String err = "Acct Element Values NOT inserted";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}

		int summary_ID = m_nap.getC_ElementValue_ID("SUMMARY");
		if (log.isLoggable(Level.FINE)) log.fine("summary_ID=" + summary_ID);
		if (summary_ID > 0) {
			DB.executeUpdateEx("UPDATE AD_TreeNode SET Parent_ID=? WHERE AD_Tree_ID=? AND Node_ID!=?",
					new Object[] {summary_ID, m_AD_Tree_Account_ID, summary_ID},
					m_trx.getTrxName());
		}

		int C_ElementValue_ID = m_nap.getC_ElementValue_ID("DEFAULT_ACCT");
		if (log.isLoggable(Level.FINE)) log.fine("C_ElementValue_ID=" + C_ElementValue_ID);

		/**
		 *  Create AccountingSchema
		 */
		m_as = new MAcctSchema (m_client, currency);
		if (!m_as.save())
		{
			String err = "AcctSchema NOT inserted";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		//  Info
		m_info.append(Msg.translate(m_lang, "C_AcctSchema_ID")).append("=").append(m_as.getName()).append("\n");

		/**
		 *  Create AccountingSchema Elements (Structure)
		 */
		String sql2 = null;
		if (Env.isBaseLanguage(m_lang, "AD_Reference"))	//	Get ElementTypes & Name
			sql2 = "SELECT Value, Name FROM AD_Ref_List WHERE AD_Reference_ID=181";
		else
			sql2 = "SELECT l.Value, t.Name FROM AD_Ref_List l, AD_Ref_List_Trl t "
				+ "WHERE l.AD_Reference_ID=181 AND l.AD_Ref_List_ID=t.AD_Ref_List_ID"
				+ " AND t.AD_Language=" + DB.TO_STRING(m_lang); //bug [ 1638421 ]
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try
		{
			int AD_Client_ID = m_client.getAD_Client_ID();
			stmt = DB.prepareStatement(sql2, m_trx.getTrxName());
			rs = stmt.executeQuery();
			while (rs.next())
			{
				String ElementType = rs.getString(1);
				name = rs.getString(2);
				//
				String IsMandatory = null;
				String IsBalanced = "N";
				int SeqNo = 0;
				int C_AcctSchema_Element_ID = 0;

				if (ElementType.equals("OO"))
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "Y";
					IsBalanced = "Y";
					SeqNo = 10;
				}
				else if (ElementType.equals("AC"))
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "Y";
					SeqNo = 20;
				}
				else if (ElementType.equals("PR") && hasProduct)
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "N";
					SeqNo = 30;
				}
				else if (ElementType.equals("BP") && hasBPartner)
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "N";
					SeqNo = 40;
				}
				else if (ElementType.equals("PJ") && hasProject)
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "N";
					SeqNo = 50;
				}
				else if (ElementType.equals("MC") && hasMCampaign)
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "N";
					SeqNo = 60;
				}
				else if (ElementType.equals("SR") && hasSRegion)
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "N";
					SeqNo = 70;
				}
				else if (ElementType.equals("AY") && hasActivity)
				{
					C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
					IsMandatory = "N";
					SeqNo = 80;
				}
				//	Not OT, LF, LT, U1, U2

				if (IsMandatory != null)
				{
					sqlCmd = new StringBuilder ("INSERT INTO C_AcctSchema_Element(");
					sqlCmd.append(m_stdColumns).append(",C_AcctSchema_Element_ID,C_AcctSchema_ID,")
						.append("ElementType,Name,SeqNo,IsMandatory,IsBalanced,C_AcctSchema_Element_UU) VALUES (");
					sqlCmd.append(m_stdValues).append(",").append(C_AcctSchema_Element_ID).append(",").append(m_as.getC_AcctSchema_ID()).append(",")
						.append("'").append(ElementType).append("','").append(name).append("',").append(SeqNo).append(",'")
						.append(IsMandatory).append("','").append(IsBalanced).append("',").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
					no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
					if (no == 1)
						m_info.append(Msg.translate(m_lang, "C_AcctSchema_Element_ID")).append("=").append(name).append("\n");

					/** Default value for mandatory elements: OO and AC */
					if (ElementType.equals("OO"))
					{
						sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET Org_ID=");
						sqlCmd.append(getAD_Org_ID()).append(" WHERE C_AcctSchema_Element_ID=").append(C_AcctSchema_Element_ID);
						no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
						if (no != 1)
							log.log(Level.SEVERE, "Default Org in AcctSchemaElement NOT updated");
					}
					if (ElementType.equals("AC"))
					{
						sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET C_ElementValue_ID=");
						sqlCmd.append(C_ElementValue_ID).append(", C_Element_ID=").append(C_Element_ID);
						sqlCmd.append(" WHERE C_AcctSchema_Element_ID=").append(C_AcctSchema_Element_ID);
						no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
						if (no != 1)
							log.log(Level.SEVERE, "Default Account in AcctSchemaElement NOT updated");
					}
				}
			}
		}
		catch (SQLException e1)
		{
			log.log(Level.SEVERE, "Elements", e1);
			m_info.append(e1.getMessage());
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		finally
		{
			DB.close(rs, stmt);
			rs = null; stmt = null;
		}
		//  Create AcctSchema


		//  Create Defaults Accounts
		try {
			createAccountingRecord(X_C_AcctSchema_GL.Table_Name);
			createAccountingRecord(X_C_AcctSchema_Default.Table_Name);
		}
		catch (Exception e) {
			String err = e.getLocalizedMessage();
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}

		//  GL Categories
		createGLCategory("Standard", MGLCategory.CATEGORYTYPE_Manual, true);
		int GL_None = createGLCategory("None", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_GL = createGLCategory("Manual", MGLCategory.CATEGORYTYPE_Manual, false);
		int GL_ARI = createGLCategory("AR Invoice", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_ARR = createGLCategory("AR Receipt", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_MM = createGLCategory("Material Management", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_API = createGLCategory("AP Invoice", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_APP = createGLCategory("AP Payment", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_CASH = createGLCategory("Cash/Payments", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_Manufacturing = createGLCategory("Manufacturing", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_Distribution = createGLCategory("Distribution", MGLCategory.CATEGORYTYPE_Document, false);
		int GL_Payroll = createGLCategory("Payroll", MGLCategory.CATEGORYTYPE_Document, false);

		//	Base DocumentTypes
		int ii = createDocType("GL Journal", Msg.getElement(m_ctx, "GL_Journal_ID"), 
			MDocType.DOCBASETYPE_GLJournal, null, 0, 0, 1000, GL_GL, false);
		if (ii == 0)
		{
			String err = "Document Type not created";
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		createDocType("GL Journal Batch", Msg.getElement(m_ctx, "GL_JournalBatch_ID"), 
			MDocType.DOCBASETYPE_GLJournal, null, 0, 0, 100, GL_GL, false);
		//	MDocType.DOCBASETYPE_GLDocument
		//
		int DT_I = createDocType("AR Invoice", Msg.getElement(m_ctx, "C_Invoice_ID", true), 
			MDocType.DOCBASETYPE_ARInvoice, null, 0, 0, 100000, GL_ARI, false);
		int DT_II = createDocType("AR Invoice Indirect", Msg.getElement(m_ctx, "C_Invoice_ID", true), 
			MDocType.DOCBASETYPE_ARInvoice, null, 0, 0, 150000, GL_ARI, false);
		int DT_IC = createDocType("AR Credit Memo", Msg.getMsg(m_ctx, "CreditMemo"), 
			MDocType.DOCBASETYPE_ARCreditMemo, null, 0, 0, 170000, GL_ARI, false);
		//	MDocType.DOCBASETYPE_ARProFormaInvoice
		
		createDocType("AP Invoice", Msg.getElement(m_ctx, "C_Invoice_ID", false), 
			MDocType.DOCBASETYPE_APInvoice, null, 0, 0, 0, GL_API, false);
		int DT_IPC = createDocType("AP CreditMemo", Msg.getMsg(m_ctx, "CreditMemo"), 
			MDocType.DOCBASETYPE_APCreditMemo, null, 0, 0, 0, GL_API, false);
		createDocType("Match Invoice", Msg.getElement(m_ctx, "M_MatchInv_ID", false), 
			MDocType.DOCBASETYPE_MatchInvoice, null, 0, 0, 390000, GL_API, false);
		
		createDocType("AR Receipt", Msg.getElement(m_ctx, "C_Payment_ID", true), 
			MDocType.DOCBASETYPE_ARReceipt, null, 0, 0, 0, GL_ARR, false);
		createDocType("AP Payment", Msg.getElement(m_ctx, "C_Payment_ID", false), 
			MDocType.DOCBASETYPE_APPayment, null, 0, 0, 0, GL_APP, false);
		createDocType("Allocation", "Allocation", 
			MDocType.DOCBASETYPE_PaymentAllocation, null, 0, 0, 490000, GL_CASH, false);

		int DT_S  = createDocType("MM Shipment", "Delivery Note", 
			MDocType.DOCBASETYPE_MaterialDelivery, null, 0, 0, 500000, GL_MM, false);
		int DT_SI = createDocType("MM Shipment Indirect", "Delivery Note", 
			MDocType.DOCBASETYPE_MaterialDelivery, null, 0, 0, 550000, GL_MM, false);
		int DT_VRM = createDocType("MM Vendor Return", "Vendor Return", 
	            MDocType.DOCBASETYPE_MaterialDelivery, null, 0, 0, 590000, GL_MM, true);
		
		createDocType("MM Receipt", "Vendor Delivery", 
			MDocType.DOCBASETYPE_MaterialReceipt, null, 0, 0, 0, GL_MM, false);
		int DT_RM = createDocType("MM Customer Return", "Customer Return", 
			MDocType.DOCBASETYPE_MaterialReceipt, null, 0, 0, 570000, GL_MM, true);
		
		createDocType("Purchase Order", Msg.getElement(m_ctx, "C_Order_ID", false), 
			MDocType.DOCBASETYPE_PurchaseOrder, null, 0, 0, 800000, GL_None, false);
		createDocType("Match PO", Msg.getElement(m_ctx, "M_MatchPO_ID", false), 
			MDocType.DOCBASETYPE_MatchPO, null, 0, 0, 890000, GL_None, false);
		createDocType("Purchase Requisition", Msg.getElement(m_ctx, "M_Requisition_ID", false), 
			MDocType.DOCBASETYPE_PurchaseRequisition, null, 0, 0, 900000, GL_None, false);
		createDocType("Vendor Return Material", "Vendor Return Material Authorization",
		    MDocType.DOCBASETYPE_PurchaseOrder, MDocType.DOCSUBTYPESO_ReturnMaterial, DT_VRM, 
		    DT_IPC, 990000, GL_MM, false);
		        
		createDocType("Bank Statement", Msg.getElement(m_ctx, "C_BankStatemet_ID", true), 
			MDocType.DOCBASETYPE_BankStatement, null, 0, 0, 700000, GL_CASH, false);
		createDocType("Cash Journal", Msg.getElement(m_ctx, "C_Cash_ID", true),
			MDocType.DOCBASETYPE_CashJournal, null, 0, 0, 750000, GL_CASH, false);
		
		createDocType("Material Movement", Msg.getElement(m_ctx, "M_Movement_ID", false),
			MDocType.DOCBASETYPE_MaterialMovement, null, 0, 0, 610000, GL_MM, false);
		createDocType("Physical Inventory", Msg.getElement(m_ctx, "M_Inventory_ID", false), 
			MDocType.DOCBASETYPE_MaterialPhysicalInventory, MDocType.DOCSUBTYPEINV_PhysicalInventory, 0, 0, 620000, GL_MM, false);
		createDocType("Material Production", Msg.getElement(m_ctx, "M_Production_ID", false), 
			MDocType.DOCBASETYPE_MaterialProduction, null, 0, 0, 630000, GL_MM, false);
		createDocType("Project Issue", Msg.getElement(m_ctx, "C_ProjectIssue_ID", false), 
			MDocType.DOCBASETYPE_ProjectIssue, null, 0, 0, 640000, GL_MM, false);
		createDocType("Internal Use Inventory", "Internal Use Inventory", 
				MDocType.DOCBASETYPE_MaterialPhysicalInventory, MDocType.DOCSUBTYPEINV_InternalUseInventory, 0, 0, 650000, GL_MM, false);
		createDocType("Cost Adjustment", "Cost Adjustment", 
				MDocType.DOCBASETYPE_MaterialPhysicalInventory, MDocType.DOCSUBTYPEINV_CostAdjustment, 0, 0, 660000, GL_MM, false);

		//  Order Entry
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
			DT_SI, DT_I, 60000, GL_None, false);   //  RE
		createDocType("Warehouse Order", "Order Confirmation", 
			MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_WarehouseOrder, 
			DT_S, DT_I,	70000, GL_None, false);    //  LS
		
		//Manufacturing Document
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
		//Payroll
		createDocType("Payroll","Payroll", 
			MDocType.DOCBASETYPE_Payroll, null,
			0, 0, 90000, GL_Payroll, false);

		int DT = createDocType("POS Order", "Order Confirmation", 
			MDocType.DOCBASETYPE_SalesOrder, MDocType.DOCSUBTYPESO_POSOrder, 
			DT_SI, DT_II, 80000, GL_None, false);    // Bar
		//	POS As Default for window SO
		createPreference("C_DocTypeTarget_ID", String.valueOf(DT), 143);

		//  Update ClientInfo
		sqlCmd = new StringBuilder ("UPDATE AD_ClientInfo SET ");
		sqlCmd.append("C_AcctSchema1_ID=").append(m_as.getC_AcctSchema_ID())
			.append(", C_Calendar_ID=").append(m_calendar.getC_Calendar_ID())
			.append(" WHERE AD_Client_ID=").append(m_client.getAD_Client_ID());
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
		{
			String err = "ClientInfo not updated";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}

		//	Validate Completeness
		ProcessInfo processInfo = new ProcessInfo("Document Type Verify", 0);
		processInfo.setAD_Client_ID(getAD_Client_ID());
		processInfo.setAD_User_ID(getAD_User_ID());
		processInfo.setParameter(new ProcessInfoParameter[0]);
		processInfo.setClassName("org.compiere.process.DocumentTypeVerify");
		if (!ProcessUtil.startJavaProcess(m_ctx, processInfo, m_trx, false))
		{
			String err = "Document type verification failed. Message="+processInfo.getSummary();
			log.log(Level.SEVERE, err);
			m_info.append(err);
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		//
		log.info("fini");
		return true;
	}   //  createAccounting
	
	private void createAccountingRecord(String tableName) throws Exception
	{
		MTable table = MTable.get(m_ctx, tableName);
		PO acct = table.getPO(0, m_trx.getTrxName());
		
		MColumn[] cols = table.getColumns(false);
		for (MColumn c : cols) {
			if (!c.isActive())
				continue;
			String columnName = c.getColumnName();
			if (c.isStandardColumn()) {
			}
			else if (DisplayType.Account == c.getAD_Reference_ID()) {
				acct.set_Value(columnName, getAcct(columnName));
				if (log.isLoggable(Level.INFO)) log.info("Account: " + columnName);
			}
			else if (DisplayType.YesNo == c.getAD_Reference_ID()) {
				acct.set_Value(columnName, Boolean.TRUE);
				if (log.isLoggable(Level.INFO)) log.info("YesNo: " + c.getColumnName());
			}
		}
		acct.setAD_Client_ID(m_client.getAD_Client_ID());
		acct.set_Value(I_C_AcctSchema.COLUMNNAME_C_AcctSchema_ID, m_as.getC_AcctSchema_ID());
		//
		if (!acct.save()) {
			throw new AdempiereUserError(CLogger.retrieveErrorString(table.getName() + " not created"));
		}
	}


	/**
	 * Get Account ID for key
	 * @param key key
	 * @return C_ValidCombination_ID
	 * @throws AdempiereUserError 
	 */
	private Integer getAcct (String key) throws AdempiereUserError
	{
		log.fine(key);
		//  Element
		int C_ElementValue_ID = m_nap.getC_ElementValue_ID(key.toUpperCase());
		if (C_ElementValue_ID == 0)
		{
			throw new AdempiereUserError("Account not defined: " + key);
		}

		MAccount vc = MAccount.getDefault(m_as, true);	//	optional null
		vc.setAD_Org_ID(0);		//	will be overwritten
		vc.setAccount_ID(C_ElementValue_ID);
		if (!vc.save())
		{
			throw new AdempiereUserError("Not Saved - Key=" + key + ", C_ElementValue_ID=" + C_ElementValue_ID);
		}
		int C_ValidCombination_ID = vc.getC_ValidCombination_ID();
		if (C_ValidCombination_ID == 0)
		{
			throw new AdempiereUserError("No account - Key=" + key + ", C_ElementValue_ID=" + C_ElementValue_ID);
		}
		return C_ValidCombination_ID;
	}   //  getAcct

	/**
	 *  Create GL Category
	 *  @param Name name
	 *  @param CategoryType category type MGLCategory.CATEGORYTYPE_*
	 *  @param isDefault is default value
	 *  @return GL_Category_ID
	 */
	private int createGLCategory (String Name, String CategoryType, boolean isDefault)
	{
		MGLCategory cat = new MGLCategory (m_ctx, 0, m_trx.getTrxName());
		cat.setName(Name);
		cat.setCategoryType(CategoryType);
		cat.setIsDefault(isDefault);
		if (!cat.save())
		{
			log.log(Level.SEVERE, "GL Category NOT created - " + Name);
			return 0;
		}
		//
		return cat.getGL_Category_ID();
	}   //  createGLCategory

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

	
	/**************************************************************************
	 *  Create Default main entities.
	 *  - Dimensions & BPGroup, Prod Category)
	 *  - Location, Locator, Warehouse
	 *  - PriceList
	 *  - Cashbook, PaymentTerm
	 *  @param C_Country_ID country
	 *  @param City city
	 *  @param C_Region_ID region
	 *  @param C_Currency_ID currency
	 *  @return true if created
	 */
	public boolean createEntities (int C_Country_ID, String City, int C_Region_ID, int C_Currency_ID, String postal, String address1)
	{
		if (m_as == null)
		{
			log.severe ("No AcctountingSChema");
			m_trx.rollback();
			m_trx.close();
			return false;
		}
		if (log.isLoggable(Level.INFO)) log.info("C_Country_ID=" + C_Country_ID 
			+ ", City=" + City + ", C_Region_ID=" + C_Region_ID);
		m_info.append("\n----\n");
		//
		String defaultName = Msg.translate(m_lang, "Standard");
		String defaultEntry = "'" + defaultName + "',";
		StringBuilder sqlCmd = null;
		int no = 0;

		//	Create Marketing Channel/Campaign
		int C_Channel_ID = getNextID(getAD_Client_ID(), "C_Channel");
		sqlCmd = new StringBuilder("INSERT INTO C_Channel ");
		sqlCmd.append("(C_Channel_ID,Name,");
		sqlCmd.append(m_stdColumns).append(",C_Channel_UU) VALUES (");
		sqlCmd.append(C_Channel_ID).append(",").append(defaultEntry);
		sqlCmd.append(m_stdValues).append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "Channel NOT inserted");

		int C_Campaign_ID = getNextID(getAD_Client_ID(), "C_Campaign");
		sqlCmd = new StringBuilder("INSERT INTO C_Campaign ");
		sqlCmd.append("(C_Campaign_ID,C_Channel_ID,").append(m_stdColumns).append(",");
		sqlCmd.append(" Value,Name,Costs,C_Campaign_UU) VALUES (");
		sqlCmd.append(C_Campaign_ID).append(",").append(C_Channel_ID).append(",").append(m_stdValues).append(",");
		sqlCmd.append(defaultEntry).append(defaultEntry).append("0").append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no == 1)
			m_info.append(Msg.translate(m_lang, "C_Campaign_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "Campaign NOT inserted");
		if (m_hasMCampaign)
		{
			//  Default
			sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET ");
			sqlCmd.append("C_Campaign_ID=").append(C_Campaign_ID);
			sqlCmd.append(" WHERE C_AcctSchema_ID=").append(m_as.getC_AcctSchema_ID());
			sqlCmd.append(" AND ElementType='MC'");
			no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
			if (no != 1)
				log.log(Level.SEVERE, "AcctSchema Element Campaign NOT updated");
		}
		// Campaign Translation
		sqlCmd = new StringBuilder ("INSERT INTO C_Campaign_Trl (AD_Language,C_Campaign_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_Campaign_Trl_UU)");
		sqlCmd.append(" SELECT l.AD_Language,t.C_Campaign_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy, generate_uuid() FROM AD_Language l, C_Campaign t");
		sqlCmd.append(" WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_Campaign_ID=").append(C_Campaign_ID);
		sqlCmd.append(" AND NOT EXISTS (SELECT * FROM C_Campaign_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_Campaign_ID=t.C_Campaign_ID)");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no < 0)
			log.log(Level.SEVERE, "Campaign Translation NOT inserted");

		//	Create Sales Region
		int C_SalesRegion_ID = getNextID(getAD_Client_ID(), "C_SalesRegion");
		sqlCmd = new StringBuilder ("INSERT INTO C_SalesRegion ");
		sqlCmd.append("(C_SalesRegion_ID,").append(m_stdColumns).append(",");
		sqlCmd.append(" Value,Name,IsSummary,C_SalesRegion_UU) VALUES (");
		sqlCmd.append(C_SalesRegion_ID).append(",").append(m_stdValues).append(", ");
		sqlCmd.append(defaultEntry).append(defaultEntry).append("'N'").append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no == 1)
			m_info.append(Msg.translate(m_lang, "C_SalesRegion_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "SalesRegion NOT inserted");
		if (m_hasSRegion)
		{
			//  Default
			sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET ");
			sqlCmd.append("C_SalesRegion_ID=").append(C_SalesRegion_ID);
			sqlCmd.append(" WHERE C_AcctSchema_ID=").append(m_as.getC_AcctSchema_ID());
			sqlCmd.append(" AND ElementType='SR'");
			no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
			if (no != 1)
				log.log(Level.SEVERE, "AcctSchema Element SalesRegion NOT updated");
		}
		// Sales Region Translation
		sqlCmd = new StringBuilder ("INSERT INTO C_SalesRegion_Trl (AD_Language,C_SalesRegion_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_SalesRegion_Trl_UU)");
		sqlCmd.append(" SELECT l.AD_Language,t.C_SalesRegion_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy, generate_uuid() FROM AD_Language l, C_SalesRegion t");
		sqlCmd.append(" WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_SalesRegion_ID=").append(C_SalesRegion_ID);
		sqlCmd.append(" AND NOT EXISTS (SELECT * FROM C_SalesRegion_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_SalesRegion_ID=t.C_SalesRegion_ID)");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no < 0)
			log.log(Level.SEVERE, "Sales Region Translation NOT inserted");

		//	Create Activity
		int C_Activity_ID = getNextID(getAD_Client_ID(), "C_Activity");
		sqlCmd = new StringBuilder ("INSERT INTO C_Activity ");
		sqlCmd.append("(C_Activity_ID,").append(m_stdColumns).append(",");
		sqlCmd.append(" Value,Name,IsSummary,C_Activity_UU) VALUES (");
		sqlCmd.append(C_Activity_ID).append(",").append(m_stdValues).append(", ");
		sqlCmd.append(defaultEntry).append(defaultEntry).append("'N'").append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no == 1)
			m_info.append(Msg.translate(m_lang, "C_Activity_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "Activity NOT inserted");
		if (m_hasActivity)
		{
			//  Default
			sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET ");
			sqlCmd.append("C_Activity_ID=").append(C_Activity_ID);
			sqlCmd.append(" WHERE C_AcctSchema_ID=").append(m_as.getC_AcctSchema_ID());
			sqlCmd.append(" AND ElementType='AY'");
			no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
			if (no != 1)
				log.log(Level.SEVERE, "AcctSchema Element Activity NOT updated");
		}
		// Activity Translation
		sqlCmd = new StringBuilder ("INSERT INTO C_Activity_Trl (AD_Language,C_Activity_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_Activity_Trl_UU)");
		sqlCmd.append(" SELECT l.AD_Language,t.C_Activity_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy, generate_uuid() FROM AD_Language l, C_Activity t");
		sqlCmd.append(" WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_Activity_ID=").append(C_Activity_ID);
		sqlCmd.append(" AND NOT EXISTS (SELECT * FROM C_Activity_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_Activity_ID=t.C_Activity_ID)");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no < 0)
			log.log(Level.SEVERE, "Activity Translation NOT inserted");

		/**
		 *  Business Partner
		 */
		//  Create BP Group
		MBPGroup bpg = new MBPGroup (m_ctx, 0, m_trx.getTrxName());
		bpg.setValue(defaultName);
		bpg.setName(defaultName);
		bpg.setIsDefault(true);
		if (bpg.save())
			m_info.append(Msg.translate(m_lang, "C_BP_Group_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "BP Group NOT inserted");

		//	Create BPartner
		MBPartner bp = new MBPartner (m_ctx, 0, m_trx.getTrxName());
		bp.setValue(defaultName);
		bp.setName(defaultName);
		bp.setBPGroup(bpg);
		if (bp.save())
			m_info.append(Msg.translate(m_lang, "C_BPartner_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "BPartner NOT inserted");
		//  Location for Standard BP
		MLocation bpLoc = new MLocation(m_ctx, C_Country_ID, C_Region_ID, City, m_trx.getTrxName());
		bpLoc.saveEx();
		MBPartnerLocation bpl = new MBPartnerLocation(bp);
		bpl.setC_Location_ID(bpLoc.getC_Location_ID());
		if (!bpl.save())
			log.log(Level.SEVERE, "BP_Location (Standard) NOT inserted");
		//  Default
		sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET ");
		sqlCmd.append("C_BPartner_ID=").append(bp.getC_BPartner_ID());
		sqlCmd.append(" WHERE C_AcctSchema_ID=").append(m_as.getC_AcctSchema_ID());
		sqlCmd.append(" AND ElementType='BP'");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "AcctSchema Element BPartner NOT updated");
		createPreference("C_BPartner_ID", String.valueOf(bp.getC_BPartner_ID()), 143);

		/**
		 *  Product
		 */
		//  Create Product Category
		MProductCategory pc = new MProductCategory(m_ctx, 0, m_trx.getTrxName());
		pc.setValue(defaultName);
		pc.setName(defaultName);
		pc.setIsDefault(true);
		if (pc.save())
			m_info.append(Msg.translate(m_lang, "M_Product_Category_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "Product Category NOT inserted");

		//  UOM (EA)
		int C_UOM_ID = 100;

		//  TaxCategory
		int C_TaxCategory_ID = getNextID(getAD_Client_ID(), "C_TaxCategory");
		sqlCmd = new StringBuilder ("INSERT INTO C_TaxCategory ");
		sqlCmd.append("(C_TaxCategory_ID,").append(m_stdColumns).append(",");
		sqlCmd.append(" Name,IsDefault,C_TaxCategory_UU) VALUES (");
		sqlCmd.append(C_TaxCategory_ID).append(",").append(m_stdValues).append(", ");
		if (C_Country_ID == COUNTRY_US)    // US
			sqlCmd.append("'Sales Tax','Y',");
		else
			sqlCmd.append(defaultEntry).append("'Y',");
		sqlCmd.append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "TaxCategory NOT inserted");
		
		//  TaxCategory translation
		sqlCmd = new StringBuilder ("INSERT INTO C_TaxCategory_Trl (AD_Language,C_TaxCategory_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_TaxCategory_Trl_UU)");
		sqlCmd.append(" SELECT l.AD_Language,t.C_TaxCategory_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy, generate_uuid() FROM AD_Language l, C_TaxCategory t");
		sqlCmd.append(" WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_TaxCategory_ID=").append(C_TaxCategory_ID);
		sqlCmd.append(" AND NOT EXISTS (SELECT * FROM C_TaxCategory_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_TaxCategory_ID=t.C_TaxCategory_ID)");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no < 0)
			log.log(Level.SEVERE, "TaxCategory Translation NOT inserted");

		//  Tax - Zero Rate
		MTax tax = new MTax (m_ctx, "Standard", Env.ZERO, C_TaxCategory_ID, m_trx.getTrxName());
		tax.setIsDefault(true);
		if (tax.save())
			m_info.append(Msg.translate(m_lang, "C_Tax_ID"))
				.append("=").append(tax.getName()).append("\n");
		else
			log.log(Level.SEVERE, "Tax NOT inserted");

		//	Create Product
		MProduct product = new MProduct (m_ctx, 0, m_trx.getTrxName());
		product.setValue(defaultName);
		product.setName(defaultName);
		product.setC_UOM_ID(C_UOM_ID);
		product.setM_Product_Category_ID(pc.getM_Product_Category_ID());
		product.setC_TaxCategory_ID(C_TaxCategory_ID);
		if (product.save())
			m_info.append(Msg.translate(m_lang, "M_Product_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "Product NOT inserted");
		//  Default
		sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET ");
		sqlCmd.append("M_Product_ID=").append(product.getM_Product_ID());
		sqlCmd.append(" WHERE C_AcctSchema_ID=").append(m_as.getC_AcctSchema_ID());
		sqlCmd.append(" AND ElementType='PR'");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "AcctSchema Element Product NOT updated");

		/**
		 *  Location, Warehouse, Locator
		 */
		//  Location (Company)
		MLocation loc = new MLocation(m_ctx, C_Country_ID, C_Region_ID, City, m_trx.getTrxName());
		loc.setAddress1(address1);
		loc.setPostal(postal);
		loc.saveEx();
		sqlCmd = new StringBuilder ("UPDATE AD_OrgInfo SET C_Location_ID=");
		sqlCmd.append(loc.getC_Location_ID()).append(" WHERE AD_Org_ID=").append(getAD_Org_ID());
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "Location NOT inserted");
		createPreference("C_Country_ID", String.valueOf(C_Country_ID), 0);

		//  Default Warehouse
		MLocation locwh = new MLocation(m_ctx, C_Country_ID, C_Region_ID, City, m_trx.getTrxName());
		locwh.setAddress1(address1);
		locwh.setPostal(postal);
		locwh.saveEx();
		MWarehouse wh = new MWarehouse(m_ctx, 0, m_trx.getTrxName());
		wh.setValue(defaultName);
		wh.setName(defaultName);
		wh.setC_Location_ID(locwh.getC_Location_ID());
		if (!wh.save())
			log.log(Level.SEVERE, "Warehouse NOT inserted");

		//   Locator
		MLocator locator = new MLocator(wh, defaultName);
		locator.setIsDefault(true);
		if (!locator.save())
			log.log(Level.SEVERE, "Locator NOT inserted");

		//  Update ClientInfo
		sqlCmd = new StringBuilder ("UPDATE AD_ClientInfo SET ");
		sqlCmd.append("C_BPartnerCashTrx_ID=").append(bp.getC_BPartner_ID());
		sqlCmd.append(",M_ProductFreight_ID=").append(product.getM_Product_ID());
//		sqlCmd.append("C_UOM_Volume_ID=");
//		sqlCmd.append(",C_UOM_Weight_ID=");
//		sqlCmd.append(",C_UOM_Length_ID=");
//		sqlCmd.append(",C_UOM_Time_ID=");
		sqlCmd.append(" WHERE AD_Client_ID=").append(getAD_Client_ID());
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
		{
			String err = "ClientInfo not updated";
			log.log(Level.SEVERE, err);
			m_info.append(err);
			return false;
		}

		/**
		 *  Other
		 */
		//  PriceList
		MPriceList pl = new MPriceList(m_ctx, 0, m_trx.getTrxName());
		pl.setName(defaultName);
		pl.setC_Currency_ID(C_Currency_ID);
		pl.setIsDefault(true);
		if (!pl.save())
			log.log(Level.SEVERE, "PriceList NOT inserted");
		//  Price List
		MDiscountSchema ds = new MDiscountSchema(m_ctx, 0, m_trx.getTrxName());
		ds.setName(defaultName);
		ds.setDiscountType(MDiscountSchema.DISCOUNTTYPE_Pricelist);
		if (!ds.save())
			log.log(Level.SEVERE, "DiscountSchema NOT inserted");
		//  PriceList Version
		MPriceListVersion plv = new MPriceListVersion(pl);
		plv.setName();
		plv.setM_DiscountSchema_ID(ds.getM_DiscountSchema_ID());
		if (!plv.save())
			log.log(Level.SEVERE, "PriceList_Version NOT inserted");
		//  ProductPrice
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), 
			Env.ONE, Env.ONE, Env.ONE);
		if (!pp.save())
			log.log(Level.SEVERE, "ProductPrice NOT inserted");


		//	Create Sales Rep for Client-User
		MBPartner bpCU = new MBPartner (m_ctx, 0, m_trx.getTrxName());
		bpCU.setValue(AD_User_U_Name);
		bpCU.setName(AD_User_U_Name);
		bpCU.setBPGroup(bpg);
		bpCU.setIsEmployee(true);
		bpCU.setIsSalesRep(true);
		if (bpCU.save())
			m_info.append(Msg.translate(m_lang, "SalesRep_ID")).append("=").append(AD_User_U_Name).append("\n");
		else
			log.log(Level.SEVERE, "SalesRep (User) NOT inserted");
		//  Location for Client-User
		MLocation bpLocCU = new MLocation(m_ctx, C_Country_ID, C_Region_ID, City, m_trx.getTrxName());
		bpLocCU.saveEx();
		MBPartnerLocation bplCU = new MBPartnerLocation(bpCU);
		bplCU.setC_Location_ID(bpLocCU.getC_Location_ID());
		if (!bplCU.save())
			log.log(Level.SEVERE, "BP_Location (User) NOT inserted");
		//  Update User
		sqlCmd = new StringBuilder ("UPDATE AD_User SET C_BPartner_ID=");
		sqlCmd.append(bpCU.getC_BPartner_ID()).append(" WHERE AD_User_ID=").append(AD_User_U_ID);
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "User of SalesRep (User) NOT updated");


		//	Create Sales Rep for Client-Admin
		MBPartner bpCA = new MBPartner (m_ctx, 0, m_trx.getTrxName());
		bpCA.setValue(AD_User_Name);
		bpCA.setName(AD_User_Name);
		bpCA.setBPGroup(bpg);
		bpCA.setIsEmployee(true);
		bpCA.setIsSalesRep(true);
		if (bpCA.save())
			m_info.append(Msg.translate(m_lang, "SalesRep_ID")).append("=").append(AD_User_Name).append("\n");
		else
			log.log(Level.SEVERE, "SalesRep (Admin) NOT inserted");
		//  Location for Client-Admin
		MLocation bpLocCA = new MLocation(m_ctx, C_Country_ID, C_Region_ID, City, m_trx.getTrxName());
		bpLocCA.saveEx();
		MBPartnerLocation bplCA = new MBPartnerLocation(bpCA);
		bplCA.setC_Location_ID(bpLocCA.getC_Location_ID());
		if (!bplCA.save())
			log.log(Level.SEVERE, "BP_Location (Admin) NOT inserted");
		//  Update User
		sqlCmd = new StringBuilder ("UPDATE AD_User SET C_BPartner_ID=");
		sqlCmd.append(bpCA.getC_BPartner_ID()).append(" WHERE AD_User_ID=").append(AD_User_ID);
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "User of SalesRep (Admin) NOT updated");


		//  Payment Term
		int C_PaymentTerm_ID = getNextID(getAD_Client_ID(), "C_PaymentTerm");
		sqlCmd = new StringBuilder ("INSERT INTO C_PaymentTerm ");
		sqlCmd.append("(C_PaymentTerm_ID,").append(m_stdColumns).append(",");
		sqlCmd.append("Value,Name,NetDays,GraceDays,DiscountDays,Discount,DiscountDays2,Discount2,IsDefault,C_PaymentTerm_UU) VALUES (");
		sqlCmd.append(C_PaymentTerm_ID).append(",").append(m_stdValues).append(",");
		sqlCmd.append("'Immediate','Immediate',0,0,0,0,0,0,'Y'").append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "PaymentTerm NOT inserted");
		// Payment Term Translation
		sqlCmd = new StringBuilder ("INSERT INTO C_PaymentTerm_Trl (AD_Language,C_PaymentTerm_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_PaymentTerm_Trl_UU)");
		sqlCmd.append(" SELECT l.AD_Language,t.C_PaymentTerm_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy, generate_uuid() FROM AD_Language l, C_PaymentTerm t");
		sqlCmd.append(" WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_PaymentTerm_ID=").append(C_PaymentTerm_ID);
		sqlCmd.append(" AND NOT EXISTS (SELECT * FROM C_PaymentTerm_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_PaymentTerm_ID=t.C_PaymentTerm_ID)");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no < 0)
			log.log(Level.SEVERE, "Payment Term Translation NOT inserted");

		//  Project Cycle
		C_Cycle_ID = getNextID(getAD_Client_ID(), "C_Cycle");
		sqlCmd = new StringBuilder ("INSERT INTO C_Cycle ");
		sqlCmd.append("(C_Cycle_ID,").append(m_stdColumns).append(",");
		sqlCmd.append(" Name,C_Currency_ID,C_Cycle_UU) VALUES (");
		sqlCmd.append(C_Cycle_ID).append(",").append(m_stdValues).append(", ");
		sqlCmd.append(defaultEntry).append(C_Currency_ID).append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "Cycle NOT inserted");

		/**
		 *  Organization level data	===========================================
		 */

		//	Create Default Project
		int C_Project_ID = getNextID(getAD_Client_ID(), "C_Project");
		sqlCmd = new StringBuilder ("INSERT INTO C_Project ");
		sqlCmd.append("(C_Project_ID,").append(m_stdColumns).append(",");
		sqlCmd.append(" Value,Name,C_Currency_ID,IsSummary,C_Project_UU) VALUES (");
		sqlCmd.append(C_Project_ID).append(",").append(m_stdValuesOrg).append(", ");
		sqlCmd.append(defaultEntry).append(defaultEntry).append(C_Currency_ID).append(",'N'").append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(")");
		no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no == 1)
			m_info.append(Msg.translate(m_lang, "C_Project_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "Project NOT inserted");
		//  Default Project
		if (m_hasProject)
		{
			sqlCmd = new StringBuilder ("UPDATE C_AcctSchema_Element SET ");
			sqlCmd.append("C_Project_ID=").append(C_Project_ID);
			sqlCmd.append(" WHERE C_AcctSchema_ID=").append(m_as.getC_AcctSchema_ID());
			sqlCmd.append(" AND ElementType='PJ'");
			no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
			if (no != 1)
				log.log(Level.SEVERE, "AcctSchema Element Project NOT updated");
		}

		//  CashBook
		MCashBook cb = new MCashBook(m_ctx, 0, m_trx.getTrxName());
		cb.setName(defaultName);
		cb.setC_Currency_ID(C_Currency_ID);
		if (cb.save())
			m_info.append(Msg.translate(m_lang, "C_CashBook_ID")).append("=").append(defaultName).append("\n");
		else
			log.log(Level.SEVERE, "CashBook NOT inserted");
		//
		boolean success = m_trx.commit();
		m_trx.close();
		log.info("finish");
		return success;
	}   //  createEntities

	/**
	 *  Create Preference
	 *  @param Attribute attribute
	 *  @param Value value
	 *  @param AD_Window_ID window
	 */
	private void createPreference (String Attribute, String Value, int AD_Window_ID)
	{
		int AD_Preference_ID = getNextID(getAD_Client_ID(), "AD_Preference");
		StringBuilder sqlCmd = new StringBuilder ("INSERT INTO AD_Preference ");
		sqlCmd.append("(AD_Preference_ID,").append("AD_Preference_UU,").append(m_stdColumns).append(",");
		sqlCmd.append("Attribute,Value,AD_Window_ID) VALUES (");
		sqlCmd.append(AD_Preference_ID).append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(",").append(m_stdValues).append(",");
		sqlCmd.append("'").append(Attribute).append("','").append(Value).append("',");
		if (AD_Window_ID == 0)
			sqlCmd.append("NULL)");
		else
			sqlCmd.append(AD_Window_ID).append(")");
		int no = DB.executeUpdateEx(sqlCmd.toString(), m_trx.getTrxName());
		if (no != 1)
			log.log(Level.SEVERE, "Preference NOT inserted - " + Attribute);
	}   //  createPreference

	
	/**************************************************************************
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

}   //  MSetup
