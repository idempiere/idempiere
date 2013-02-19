/******************************************************************************
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.adinterface;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Properties;

import org.adempiere.util.ServerContext;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;

/**
 * @author deepak
 * @author hengsin
 *
 */
public class CompiereService {

	private static CLogger	log = CLogger.getCLogger(CompiereService.class);
	
	public final static String datePattern = "dd-MM-yyyy"; 

	private Properties m_ctx; 
	
	private int m_AD_Client_ID;
	private int m_AD_Org_ID;
	private int m_AD_User_ID;
	private int m_AD_Role_ID;
	private int m_M_Warehouse_ID;
	private String m_locale;
	private String m_userName;

	private boolean m_loggedin = false; 
	
	
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
	
	private Language m_language; 
		
	public final String dateFormatOnlyForCtx =  "yyyy-MM-dd";

	private boolean m_connected;
    
	/**
	 * 
	 * @return AD_Client_ID of current request
	 */
    public int getAD_Client_ID() {
		return m_AD_Client_ID;
	}

    /**
     * 
     * @return AD_Org_ID of current request
     */
	public int getAD_Org_ID() {
		return m_AD_Org_ID;
	}

	/**
	 * 
	 * @return context of current request
	 */
	public Properties getCtx() {
		return m_ctx;
	}

	/**
	 * default constructor
	 */
	public CompiereService()
	{		
		m_loggedin = false;
		m_connected = false;
	}
	
	/**
	 * setup request
	 */
	public void connect()
	{
		if (!m_connected)
		{
			CompiereUtil.initWeb();
			
			m_ctx = new Properties();
			m_connected = true;
			
			ServerContext.setCurrentInstance(m_ctx);
			Env.setContext( m_ctx, "#AD_Language", "en_US" );
			m_language = Language.getLanguage("en_US");
			
			// These variables are needed for ADClient.exe
			Language m_lang2 = Language.getLanguage("pl_PL");
			
			
			dateFormat = new SimpleDateFormat( datePattern );
			dateTimeFormat = new SimpleDateFormat( datePattern );
			
			amountFormat = DisplayType.getNumberFormat(DisplayType.Amount, m_lang2);
			integerFormat = DisplayType.getNumberFormat(DisplayType.Integer, m_lang2);
			numberFormat = DisplayType.getNumberFormat(DisplayType.Number, m_lang2);
			quantityFormat = DisplayType.getNumberFormat(DisplayType.Quantity, m_lang2);		
		}
	}

	/**
	 * cleanup request
	 */
	public void disconnect() 
	{
		if (m_connected) 
		{
			ServerContext.dispose();
			m_ctx = null;
			m_loggedin = false;
			m_connected = false;
		}
	}
	
	/**
	 * @return true if started
	 */
	public boolean isConnected() 
	{
		return m_connected;
	}

	/**
	 * @return Language of current request
	 */
	public Language getLanguage() {
		return m_language;
	}

	/**
	 * @return true if already logged in
	 */
	public boolean isLoggedIn() {
		return m_loggedin;
	}
	
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
			rs.close();
			pstmt.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally {
			DB.close(rs, pstmt);
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
		//
		return loginInfo;
	}   //  checkLogin

	/**
	 * 
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @param AD_Client_ID
	 * @param AD_Org_ID
	 * @param M_Warehouse_ID
	 * @param Lang
	 * @return true if login is successful
	 */
	public boolean login( int AD_User_ID, int AD_Role_ID, int AD_Client_ID, int AD_Org_ID, int M_Warehouse_ID, String Lang ) {
		m_loggedin = false;
		String loginInfo = checkLogin (getCtx(), AD_User_ID, AD_Role_ID, AD_Client_ID, AD_Org_ID, M_Warehouse_ID );				
		if (loginInfo == null)
			return false;	
		
		m_AD_Client_ID = AD_Client_ID;
		m_AD_Org_ID = AD_Org_ID;
		m_AD_User_ID = AD_User_ID;
		m_AD_Role_ID = AD_Role_ID;
		m_M_Warehouse_ID = M_Warehouse_ID;
		m_locale = Lang;
		m_userName = MUser.getNameOfUser(m_AD_User_ID);
		
		Env.setContext( m_ctx, "#AD_Language", Lang);
		m_language = Language.getLanguage(Lang);
		Env.verifyLanguage( getCtx(), m_language );
		
		modelDateFormat = new SimpleDateFormat( datePattern );
		modelDateTimeFormat = new SimpleDateFormat( datePattern );
		
		modelAmountFormat = DisplayType.getNumberFormat(DisplayType.Amount, m_language);
		modelIntegerFormat = DisplayType.getNumberFormat(DisplayType.Integer, m_language);
		modelNumberFormat = DisplayType.getNumberFormat(DisplayType.Number, m_language);
		modelQuantityFormat = DisplayType.getNumberFormat(DisplayType.Quantity, m_language);

		//  Set Date
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		
		SimpleDateFormat dateFormat4Timestamp = new SimpleDateFormat( dateFormatOnlyForCtx ); 
		Env.setContext( getCtx(), "#Date", dateFormat4Timestamp.format(ts)+" 00:00:00" );    //  JDBC format
		log.info(" #Date = "+ Env.getContextAsDate( getCtx(), "#Date"));

		Env.setContext( getCtx(), "#M_Warehouse_ID", M_Warehouse_ID );
		Env.setContext(m_ctx, Env.LANGUAGE, m_language.getAD_Language());
		
		m_loggedin = true;		
		return true;
	}

	/**
	 * 
	 * @return AD_User_ID of current request
	 */
	public int getAD_User_ID() {
		return m_AD_User_ID;
	}

	/**
	 * 
	 * @return AD_Role_ID of current request
	 */
	public int getAD_Role_ID() {
		return m_AD_Role_ID;
	}

	/**
	 * 
	 * @return locale code of current request
	 */
	public String getLocale() {
		return m_locale;
	}

	/**
	 * 
	 * @return M_Warehouse_ID of current request
	 */
	public int getM_Warehouse_ID() {
		return m_M_Warehouse_ID;
	}
	
	/**
	 * 
	 * @return logged in user name of current request
	 */
	public String getUserName() {
		return m_userName;
	}

}
