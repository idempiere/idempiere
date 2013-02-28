/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz                                           *
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
* - Carlos Ruiz - globalqss                                           *
***********************************************************************/

package org.idempiere.fitnesse.fixture;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;

/**
 *	iDempiere Service to control login for use with fitnesse framework testing
 *
 *  @author Carlos Ruiz - globalqss
 */
public class Service {

	private static CLogger	log = CLogger.getCLogger(Service.class);
	
	public final static String datePattern = "dd-MM-yyyy"; 

	private String m_trx_name; 
	
	private int m_AD_Client_ID;
	private int m_AD_Org_ID;
	private int m_AD_User_ID;
	private int m_AD_Role_ID;
	private int m_M_Warehouse_ID;
	private String m_Lang;
	private String m_User;

	private int m_WindowNo = 1;

	private boolean LoggedIn = false; 
	
	
	/** Localized Date format       */
	public SimpleDateFormat dateFormat = null;
	/** Localized Timestamp format  */
	public SimpleDateFormat dateTimeFormat = null;

	/** Localized Amount format    */
	public DecimalFormat 	amountFormat = null;
	/** Localized Integer format    */
	public DecimalFormat 	integerFormat = null;
	/** Localized Number format     */
	public DecimalFormat 	numberFormat = null;
	/** Localized Quantity format   */
	public DecimalFormat 	quantityFormat = null;

	/** Localized Date format       */
	public SimpleDateFormat modelDateFormat = null;
	/** Localized Timestamp format  */
	public SimpleDateFormat modelDateTimeFormat = null;

	/** Localized Amount format    */
	public DecimalFormat 	modelAmountFormat = null;
	/** Localized Integer format    */
	public DecimalFormat 	modelIntegerFormat = null;
	/** Localized Number format     */
	public DecimalFormat 	modelNumberFormat = null;
	/** Localized Quantity format   */
	public DecimalFormat 	modelQuantityFormat = null;
	
	private Language m_lang; 
		
	public final String dateFormatOnlyForCtx =  "yyyy-MM-dd";
    
    public int getM_AD_Client_ID() {
		return m_AD_Client_ID;
	}

	public void setM_AD_Client_ID(int client_ID) {
		m_AD_Client_ID = client_ID;
	}

	public int getM_AD_Org_ID() {
		return m_AD_Org_ID;
	}

	public void setM_AD_Org_ID(int org_ID) {
		m_AD_Org_ID = org_ID;
	}

	public Properties getCtx() {
		return Env.getCtx();
	}

	public String get_TrxName() {
		return m_trx_name;
	}

	public void set_TrxName(String m_trx_name) {
		this.m_trx_name = m_trx_name;
	}
	
	
	public Service()
	{
		m_trx_name= null; //Trx.createTrxName(); 
		LoggedIn = false;
	}
	
	public void connect()
	{
		Util.initWeb();
		
		getCtx().setProperty("#AD_Client_ID", "0");
		Env.setContext( getCtx(), "#AD_Language", "en_US" );
		m_lang = Language.getLanguage("en_US");
		
		// These variables are needed for ADClient.exe
		Language m_lang2 = Language.getLanguage("pl_PL");
		
		//dateFormat = DisplayType.getDateFormat(DisplayType.Date, m_lang2);
		//dateTimeFormat = DisplayType.getDateFormat(DisplayType.DateTime, m_lang2);
		
		dateFormat = new SimpleDateFormat( datePattern );
		dateTimeFormat = new SimpleDateFormat( datePattern );
		
		//dateTimeFormat = DisplayType.getDateFormat(DisplayType.DateTime, m_lang2);
		//
		amountFormat = DisplayType.getNumberFormat(DisplayType.Amount, m_lang2);
		integerFormat = DisplayType.getNumberFormat(DisplayType.Integer, m_lang2);
		numberFormat = DisplayType.getNumberFormat(DisplayType.Number, m_lang2);
		quantityFormat = DisplayType.getNumberFormat(DisplayType.Quantity, m_lang2);

	} // connect

	public Language getM_lang() {
		return m_lang;
	}

	public void setM_lang(Language m_lang) {
		this.m_lang = m_lang;
	}

	public boolean isLoggedIn() {
		return LoggedIn;
	}
	
	/*
	public static Properties testLogin (boolean isClient)
	{
		//logger.entering("Env", "initTest");
		Compiere.startupEnvironment(true);
		//  Test Context
		Properties ctx = Env.getCtx();
		org.compiere.util.Login login = new org.compiere.util.Login(ctx);
		KeyNamePair[] roles = login.getRoles("SuperUser", "System1969");
		//  load role
		if (roles != null && roles.length > 0)
		{
			int x = -1;
			for (int i=0; i<roles.length; i++)
			{
				if (roles[i].getName().equalsIgnoreCase("Opony Admin"))
					x= i;
				log.info( roles[i].getName()); 
			}
			KeyNamePair[] clients = login.getClients (roles[x]);
			//  load client
			if (clients != null && clients.length > 0)
			{
				KeyNamePair[] orgs = login.getOrgs(clients[0]);
				//  load org
				if (orgs != null && orgs.length > 0)
				{
					KeyNamePair[] whs = login.getWarehouses(orgs[0]);
					//
					login.loadPreferences(orgs[0], null, null, null);
				}
			}
		}
		//
		Env.setContext(ctx, "#Date", "2006-01-26");
	//	logger.exiting("Env", "initTest");
		return ctx;
	}   //  testInit
	 */
	
	
	
	/**
	 *  Check Login information and set context.
	 *  @returns    true if login info are OK
	 *  @param ctx context
	 *  @param AD_User_ID user
	 *  @param AD_Role_ID role
	 *  @param AD_Client_ID client
	 *  @param AD_Org_ID org
	 *  @param M_Warehouse_ID warehouse
	 */
	private String checkLogin (Properties ctx, int AD_User_ID, int AD_Role_ID, int AD_Client_ID, int AD_Org_ID, int M_Warehouse_ID)
	{
		//  Get Login Info
		String loginInfo = null;
		//  Verify existance of User/Client/Org/Role and User's acces to Client & Org
		String sql = "SELECT u.Name || '@' || c.Name || '.' || o.Name || ' [' || INITCAP(USER) || ']' AS Text "
			+ "FROM AD_User u, AD_Client c, AD_Org o, AD_User_Roles ur "
			+ "WHERE u.AD_User_ID=?"    //  #1
			+ " AND c.AD_Client_ID=?"   //  #2
			+ " AND o.AD_Org_ID=?"      //  #3
			+ " AND ur.AD_Role_ID=?"    //  #4
			+ " AND ur.AD_User_ID=u.AD_User_ID"
			+ " AND (o.AD_Client_ID = 0 OR o.AD_Client_ID=c.AD_Client_ID)"
			+ " AND c.AD_Client_ID IN (SELECT AD_Client_ID FROM AD_Role_OrgAccess ca WHERE ca.AD_Role_ID=ur.AD_Role_ID)"
			+ " AND o.AD_Org_ID IN (SELECT AD_Org_ID FROM AD_Role_OrgAccess ca WHERE ca.AD_Role_ID=ur.AD_Role_ID)";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_User_ID);
			pstmt.setInt(2, AD_Client_ID);
			pstmt.setInt(3, AD_Org_ID);
			pstmt.setInt(4, AD_Role_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				loginInfo = rs.getString(1);
		}
		catch (SQLException e)
		{
			//	log.log(Level.SEVERE, "checkLogin", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		//  not verified
		if (loginInfo == null)
			return null;

		//  Set Preferences
		KeyNamePair org = new KeyNamePair(AD_Org_ID, String.valueOf(AD_Org_ID));
		KeyNamePair wh = null;
		if (M_Warehouse_ID > 0)
			wh = new KeyNamePair(M_Warehouse_ID, String.valueOf(M_Warehouse_ID));
		//
		Timestamp date = null;
		String printer = null;
		Login login = new Login(ctx);
		login.loadPreferences(org, wh, date, printer);
		//	Don't Show Acct/Trl Tabs on HTML UI
		Env.setContext(ctx, "#ShowAcct", "N");
		Env.setContext(ctx, "#ShowTrl", "N");
		//
		return loginInfo;
	}   //  checkLogin

	public boolean login( int AD_User_ID, int AD_Role_ID, int AD_Client_ID, int AD_Org_ID, int AD_Warehouse_ID, String Lang ) {
		LoggedIn = false;
		String loginInfo = checkLogin (getCtx(), AD_User_ID, AD_Role_ID, AD_Client_ID, AD_Org_ID, AD_Warehouse_ID );				
		if (loginInfo == null)
			return false;	
		
		m_AD_Client_ID = AD_Client_ID;
		m_AD_Org_ID = AD_Org_ID;
		m_AD_User_ID = AD_User_ID;
		m_AD_Role_ID = AD_Role_ID;
		m_M_Warehouse_ID = AD_Warehouse_ID;
		m_Lang = Lang;
		m_User = MUser.getNameOfUser(m_AD_User_ID);
		
		Env.setContext( getCtx(), "#AD_Language", Lang);
		m_lang = Language.getLanguage(Lang);
		Env.verifyLanguage( getCtx(), m_lang );
		
		modelDateFormat = new SimpleDateFormat( datePattern );
		modelDateTimeFormat = new SimpleDateFormat( datePattern );
		
		modelAmountFormat = DisplayType.getNumberFormat(DisplayType.Amount, m_lang);
		modelIntegerFormat = DisplayType.getNumberFormat(DisplayType.Integer, m_lang);
		modelNumberFormat = DisplayType.getNumberFormat(DisplayType.Number, m_lang);
		modelQuantityFormat = DisplayType.getNumberFormat(DisplayType.Quantity, m_lang);

		//  Set Date
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		
		SimpleDateFormat dateFormat4Timestamp = new SimpleDateFormat( dateFormatOnlyForCtx ); 
		Env.setContext( getCtx(), "#Date", dateFormat4Timestamp.format(ts)+" 00:00:00" );    //  JDBC format
		if (log.isLoggable(Level.INFO)) log.info(" #Date = "+ Env.getContextAsDate( getCtx(), "#Date"));

		Env.setContext( getCtx(), "#M_Warehouse_ID", AD_Warehouse_ID );
		Env.setContext(getCtx(), Env.LANGUAGE, m_lang.getAD_Language());
		//Env.setContext( m_ctx, "#AD_Language", Lang );
		
		LoggedIn = true;		
		return true;
	} // login

	public void setAD_User_ID(int m_AD_User_ID) {
		this.m_AD_User_ID = m_AD_User_ID;
	}

	public int getAD_User_ID() {
		return m_AD_User_ID;
	}

	public void setAD_Role_ID(int m_AD_Role_ID) {
		this.m_AD_Role_ID = m_AD_Role_ID;
	}

	public int getAD_Role_ID() {
		return m_AD_Role_ID;
	}

	public void setLanguage(String m_Lang) {
		this.m_Lang = m_Lang;
	}

	public String getLanguage() {
		return m_Lang;
	}

	public void setM_Warehouse_ID(int m_AD_Warehouse_ID) {
		this.m_M_Warehouse_ID = m_AD_Warehouse_ID;
	}

	public int getM_Warehouse_ID() {
		return m_M_Warehouse_ID;
	}

	public void setUser(String m_User) {
		this.m_User = m_User;
	}

	public String getUser() {
		return m_User;
	}

	public int getWindowNo() {
		return m_WindowNo;
	}

	public void setWindowNo(int windowNo) {
		m_WindowNo = windowNo;
	}

	public int nextWindowNo() {
		m_WindowNo ++;
		return m_WindowNo;
	}

} // AdempiereService
