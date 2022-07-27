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
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;
import org.compiere.util.Util;
import org.idempiere.adInterface.x10.ADLoginRequest;

/**
 * @author deepak
 * @author hengsin
 *
 */
public class CompiereService {

	private static final CLogger	log = CLogger.getCLogger(CompiereService.class);

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

	private int m_connectCount;

	/**
	 * 
	 * @return AD_Client_ID of current request
	 */
	public synchronized int getAD_Client_ID() {
		return m_AD_Client_ID;
	}

    /**
     * 
     * @return AD_Org_ID of current request
     */
	public synchronized int getAD_Org_ID() {
		return m_AD_Org_ID;
	}

	/**
	 * 
	 * @return context of current request
	 */
	public synchronized Properties getCtx() {
		return Env.getCtx();
	}

	/**
	 * default constructor
	 */
	public CompiereService()
	{		
		m_loggedin = false;
		m_connectCount = 0;
	}
	
	/**
	 * setup request
	 */
	public void connect()
	{
		CompiereUtil.initWeb();

		ServerContext.setCurrentInstance(new Properties());
		Env.setContext(getCtx(), Env.LANGUAGE, "en_US" );
		m_language = Language.getLanguage("en_US");

		dateFormat = DisplayType.getDateFormat(DisplayType.Date, m_language);
		dateTimeFormat = DisplayType.getDateFormat(DisplayType.DateTime, m_language);
		timeFormat = DisplayType.getDateFormat(DisplayType.Time, m_language);
		dateFormatJDBC = DisplayType.getDateFormat_JDBC();
		dateTimeFormatJDBC = DisplayType.getTimestampFormat_Default();
		timeFormatJDBC = DisplayType.getTimeFormat_Default();

		m_connectCount++;
	}
	
	/**
	 * Increase connect count
	 */
	public synchronized void connectCacheInstance()
	{
		m_connectCount++;
	}

	/**
	 * cleanup request
	 */
	public synchronized void disconnect() 
	{
		m_connectCount--;
		// TODO: create a thread that checks expired connected compiereservices and log them out
		expungeIfExpire();		
	}

	/**
	 * @return Language of current request
	 */
	public synchronized Language getLanguage() {
		return m_language;
	}

	/**
	 * @return true if already logged in
	 */
	public synchronized boolean isLoggedIn() {
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
	private synchronized String checkLogin (Properties ctx, int AD_User_ID, int AD_Role_ID, int AD_Client_ID, int AD_Org_ID, int M_Warehouse_ID)
	{
		//  Get Login Info
		String loginInfo = null;
		//  Verify existence of User/Client/Org/Role and User's acces to Client & Org

		StringBuilder sql = new StringBuilder("SELECT u.Name || '@' || c.Name || '.' || o.Name AS Text")
		.append(" FROM AD_User u, AD_Client c, AD_Org o, AD_Role r")
		.append(" WHERE u.AD_User_ID = ?")    //  #1
		.append(" AND c.AD_Client_ID = ?")    //  #2
		.append(" AND o.AD_Org_ID = ?")       //  #3
		.append(" AND r.AD_Role_ID = ?")      //  #4
		.append(" AND (o.AD_Client_ID = 0 OR o.AD_Client_ID=c.AD_Client_ID)")
		.append(" AND ( ")
		.append(" 	r.IsAccessAllOrgs='Y'")
		.append(" 	OR (r.IsUseUserOrgAccess='N' AND o.AD_Org_ID IN (SELECT AD_Org_ID FROM AD_Role_OrgAccess ra WHERE ra.AD_Role_ID=r.AD_Role_ID AND ra.IsActive='Y'))")
		.append(" 	OR (r.IsUseUserOrgAccess='Y' AND o.AD_Org_ID IN (SELECT AD_Org_ID FROM AD_User_OrgAccess ua WHERE ua.AD_User_ID=u.AD_User_ID AND ua.IsActive='Y'))")
		.append(")");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
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
	public synchronized boolean login( int AD_User_ID, int AD_Role_ID, int AD_Client_ID, int AD_Org_ID, int M_Warehouse_ID, String Lang ) {
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
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
		MUser user = MUser.get(getCtx(), m_AD_User_ID);
		if (email_login)
			m_userName = user.getEMail();
		else
			m_userName = Util.isEmpty(user.getLDAPUser()) ? user.getName() : user.getLDAPUser();

		Env.setContext( getCtx(), Env.LANGUAGE, Lang);
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
		Env.setContext( getCtx(), Env.DATE, dateFormat4Timestamp.format(ts)+" 00:00:00" );    //  JDBC format
		if (log.isLoggable(Level.INFO)) log.info(" #Date = "+ Env.getContextAsDate( getCtx(), Env.DATE));

		Env.setContext( getCtx(), Env.M_WAREHOUSE_ID, M_Warehouse_ID );
		Env.setContext(getCtx(), Env.LANGUAGE, m_language.getAD_Language());
		
		// Create session
		MSession session = MSession.get (getCtx());
		if (session == null){
			log.fine("No Session found");
			session = MSession.create (getCtx());
		} else {
			session = new MSession(getCtx(), session.getAD_Session_ID(), null);
		}

		session.setWebSession("WebService");
		
		session.setDescription(session.getDescription() + "\nUser Agent: " + getCtx().getProperty("#UserAgent"));

		session.saveEx();
				
		m_loggedin = true;		
		
		synchronized (csMap) {
			//save session in cache
			String key = getKey(m_AD_Client_ID,
					m_AD_Org_ID,
					m_userName,
					m_AD_Role_ID,
					m_M_Warehouse_ID,
					m_locale,
					m_password,
					m_IPAddress);
			if (! csMap.containsKey(key)) {				
				csMap.put(key.toString(), this);
				Properties savedCache = new Properties();
				savedCache.putAll(Env.getCtx());
				ctxMap.put(key.toString(), savedCache);
				if (log.isLoggable(Level.INFO)) log.info("Saving " + this + " in cache");
			}
		}		
		
		return true;
	}

	/**
	 * 
	 * @return AD_User_ID of current request
	 */
	public synchronized int getAD_User_ID() {
		return m_AD_User_ID;
	}

	/**
	 * 
	 * @return AD_Role_ID of current request
	 */
	public synchronized int getAD_Role_ID() {
		return m_AD_Role_ID;
	}

	/**
	 * 
	 * @return locale code of current request
	 */
	public synchronized String getLocale() {
		return m_locale;
	}

	/**
	 * 
	 * @return M_Warehouse_ID of current request
	 */
	public synchronized int getM_Warehouse_ID() {
		return m_M_Warehouse_ID;
	}
	
	/**
	 * 
	 * @return logged in user name of current request
	 */
	public synchronized String getUserName() {
		return m_userName;
	}

	/**
	 * @param pass
	 */
	public synchronized void setPassword(String pass) {
		m_password = pass;
	}

	/**
	 * @return logged in password of current request
	 */
	public synchronized String getPassword() {
		return m_password;
	}

	/**
	 * @param expiryMinutes
	 */
	public synchronized void setExpiryMinutes(int expiryMinutes) {
		m_expiryMinutes = expiryMinutes;
	}

	/**
	 * @return logged in expiry minutes of current request
	 */
	public synchronized int getExpiryMinutes() {
		return m_expiryMinutes;
	}

	public synchronized void refreshLastAuthorizationTime() {
		m_lastAuthorizationTime = System.currentTimeMillis();
	}

	public synchronized void setIPAddress(String remoteAddr) {
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
		synchronized (csMap) {
			if (csMap.containsKey(key)) {
				l_cs = csMap.get(key);
				if (l_cs != null) {
					if (l_cs.expungeIfExpire()) {						
						l_cs = null;
					} else {
						Properties cachedCtx = ctxMap.get(key);
						Env.getCtx().putAll(cachedCtx);
						if (log.isLoggable(Level.INFO)) log.info("Reusing " + l_cs);
					}
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
	
	private synchronized boolean expungeIfExpire() {
		boolean expired =
			   (
				   (getExpiryMinutes() <= 0)
				|| (m_lastAuthorizationTime + (getExpiryMinutes() * 60000) <= System.currentTimeMillis())
			   );
		if (m_connectCount==0 && expired) 
		{
			synchronized (csMap) {
				String key = getKey(m_AD_Client_ID,
						m_AD_Org_ID,
						m_userName,
						m_AD_Role_ID,
						m_M_Warehouse_ID,
						m_locale,
						m_password,
						m_IPAddress);
				if (csMap.containsKey(key)) {
					csMap.remove(key);
				}
				if (ctxMap.containsKey(key)) {
					Properties cachedCtx = ctxMap.remove(key);
					Properties currentCtx = ServerContext.getCurrentInstance();
					try {
						ServerContext.setCurrentInstance(cachedCtx);
						if (log.isLoggable(Level.INFO)) log.info("Closing expired/invalid " + this);
						Env.logout();
					} finally {
						if (currentCtx == cachedCtx) {
							ServerContext.dispose();
						} else {
							ServerContext.setCurrentInstance(currentCtx);
						}
					}
				}				
				m_loggedin = false;
			}
		}
		return expired;
	}

}
