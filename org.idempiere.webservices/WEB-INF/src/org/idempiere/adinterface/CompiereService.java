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
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;

import org.adempiere.util.ServerContext;
import org.compiere.model.MSession;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;
import org.idempiere.adInterface.x10.ADLoginRequest;

/**
 * @author deepak
 * @author hengsin
 *
 */
public class CompiereService {

	private static CLogger	log = CLogger.getCLogger(CompiereService.class);

	private int m_AD_Client_ID;
	private int m_AD_Org_ID;
	private int m_AD_User_ID;
	private int m_AD_Role_ID;
	private int m_M_Warehouse_ID;
	private String m_locale;
	private String m_userName;
	private String m_password;
	private int m_expiryMinutes;
	private long m_lastAuthorizationTime;
	private String m_IPAddress;
	private static Map<String,CompiereService> csMap = new HashMap<String, CompiereService>();
	private static Map<String,Properties> ctxMap = new HashMap<String, Properties>();

	private boolean m_loggedin = false; 
	
	
	/** Localized Date format       */
	public SimpleDateFormat dateFormat = null;
	/** JDBC Date format  */
	public SimpleDateFormat dateFormatJDBC = null;
	/** Localized Timestamp format  */
	public SimpleDateFormat dateTimeFormat = null;
	/** JDBC Timestamp format  */
	public SimpleDateFormat dateTimeFormatJDBC = null;
	/** Localized Time format  */
	public SimpleDateFormat timeFormat = null;
	/** JDBC Time format  */
	public SimpleDateFormat timeFormatJDBC = null;

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
		return Env.getCtx();
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
			
			m_connected = true;
			
			ServerContext.setCurrentInstance(new Properties());
			Env.setContext(getCtx(), "#AD_Language", "en_US" );
			m_language = Language.getLanguage("en_US");
			
			dateFormat = DisplayType.getDateFormat(DisplayType.Date, m_language);
			dateTimeFormat = DisplayType.getDateFormat(DisplayType.DateTime, m_language);
			timeFormat = DisplayType.getDateFormat(DisplayType.Time, m_language);
			dateFormatJDBC = DisplayType.getDateFormat_JDBC();
			dateTimeFormatJDBC = DisplayType.getTimestampFormat_Default();
			timeFormatJDBC = DisplayType.getTimeFormat_Default();
		}
	}

	/**
	 * cleanup request
	 */
	public void disconnect() 
	{
		// TODO: create a thread that checks expired connected compiereservices and log them out
		if (! isExpired()) {
			// do not close, save session in cache
			if (! csMap.containsValue(this)) {
				String key = getKey(m_AD_Client_ID,
						m_AD_Org_ID,
						m_userName,
						m_AD_Role_ID,
						m_M_Warehouse_ID,
						m_locale,
						m_password,
						m_IPAddress);
				csMap.put(key.toString(), this);
				Properties savedCache = new Properties();
				savedCache.putAll(Env.getCtx());
				ctxMap.put(key.toString(), savedCache);
			}
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
		//  Verify existence of User/Client/Org/Role and User's acces to Client & Org
		String sql = "SELECT u.Name || '@' || c.Name || '.' || o.Name AS Text "
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
			e.printStackTrace();
		} finally {
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
		
		Env.setContext( getCtx(), "#AD_Language", Lang);
		m_language = Language.getLanguage(Lang);
		Env.verifyLanguage( getCtx(), m_language );

		dateFormat = DisplayType.getDateFormat(DisplayType.Date, m_language);
		dateTimeFormat = DisplayType.getDateFormat(DisplayType.DateTime, m_language);
		timeFormat = DisplayType.getDateFormat(DisplayType.Time, m_language);
		dateFormatJDBC = DisplayType.getDateFormat_JDBC();
		dateTimeFormatJDBC = DisplayType.getTimestampFormat_Default();
		timeFormatJDBC = DisplayType.getTimeFormat_Default();

		//  Set Date
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		
		SimpleDateFormat dateFormat4Timestamp = new SimpleDateFormat( dateFormatOnlyForCtx ); 
		Env.setContext( getCtx(), "#Date", dateFormat4Timestamp.format(ts)+" 00:00:00" );    //  JDBC format
		if (log.isLoggable(Level.INFO)) log.info(" #Date = "+ Env.getContextAsDate( getCtx(), "#Date"));

		Env.setContext( getCtx(), "#M_Warehouse_ID", M_Warehouse_ID );
		Env.setContext(getCtx(), Env.LANGUAGE, m_language.getAD_Language());
		
		// Create session
		MSession session = MSession.get (getCtx(), false);
		if (session == null){
			log.fine("No Session found");
			session = MSession.get (getCtx(), true);    	
		}
		session.setWebSession("WebService");
		
		session.setDescription(session.getDescription() + "\nUser Agent: " + getCtx().getProperty("#UserAgent"));

		session.saveEx();
				
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

	/**
	 * @return set password
	 */
	public void setPassword(String pass) {
		m_password = pass;
	}

	/**
	 * @return logged in password of current request
	 */
	public String getPassword() {
		return m_password;
	}

	/**
	 * @return set expiry minutes
	 */
	public void setExpiryMinutes(int expiryMinutes) {
		m_expiryMinutes = expiryMinutes;
	}

	/**
	 * @return logged in expiry minutes of current request
	 */
	public int getExpiryMinutes() {
		return m_expiryMinutes;
	}

	public void refreshLastAuthorizationTime() {
		m_lastAuthorizationTime = System.currentTimeMillis();
	}

	public void setIPAddress(String remoteAddr) {
		m_IPAddress = remoteAddr;
	}

	public static CompiereService get(HttpServletRequest req, ADLoginRequest loginRequest) {
		String key = getKey(loginRequest.getClientID(),
				loginRequest.getOrgID(),
				loginRequest.getUser(),
				loginRequest.getRoleID(),
				loginRequest.getWarehouseID(),
				loginRequest.getLang(),
				loginRequest.getPass(),
				req.getRemoteAddr());
		CompiereService l_cs = null;
		if (csMap.containsKey(key)) {
			l_cs = csMap.get(key);
			if (l_cs != null) {
				if (l_cs.isExpired()) {
					l_cs = null;
				} else {
					Properties cachedCtx = ctxMap.get(key);
					Env.getCtx().putAll(cachedCtx);
				}
			}
		}
		return l_cs;
	}

	private static String getKey(
			int aD_Client_ID,
			int aD_Org_ID,
			String userName,
			int aD_Role_ID,
			int m_Warehouse_ID,
			String locale,
			String password,
			String iPAddress) {
		StringBuilder key = new StringBuilder()
			.append(aD_Client_ID).append("|")
			.append(aD_Org_ID).append("|")
			.append(userName).append("|")
			.append(aD_Role_ID).append("|")
			.append(m_Warehouse_ID).append("|")
			.append(locale).append("|")
			.append(password).append("|")
			.append(iPAddress);
		return key.toString();
	}
	
	private boolean isExpired() {
		boolean expired =
			   (
				   (getExpiryMinutes() <= 0)
				|| (m_lastAuthorizationTime + (getExpiryMinutes() * 60000) <= System.currentTimeMillis())
			   );
		if (m_connected && expired) 
		{
			Env.logout();
			ServerContext.dispose();
			m_loggedin = false;
			m_connected = false;
		}
		return expired;
	}

}
