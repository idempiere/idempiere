/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Contributor: Goodwill Consulting (www.goodwill.co.id)                      *
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
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 *	System Configuration
 *	
 *  @author Armen Rizal
 *  @version $Id: MSysConfig.java,v 1.5 2005/11/28 11:56:45 armen Exp $
 *  Contributor: Carlos Ruiz - globalqss - [ 1800371 ] System Configurator Enhancements
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1885496 ] Performance NEEDS
 */
public class MSysConfig extends X_AD_SysConfig
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5434521728516112616L;

	public final static String PDF_FONT_DIR = "PDF_FONT_DIR";
	public final static String TWOPACK_HANDLE_TRANSLATIONS = "2PACK_HANDLE_TRANSLATIONS";
	public static final String ZK_DESKTOP_CLASS = "ZK_DESKTOP_CLASS";
	public static final String CASH_AS_PAYMENT = "CASH_AS_PAYMENT";
	public static final String MAX_ACTIVITIES_IN_LIST = "MAX_ACTIVITIES_IN_LIST";
	public static final String ZK_ROOT_FOLDER_BROWSER = "ZK_ROOT_FOLDER_BROWSER";
	public static final String ZK_PAGING_SIZE = "ZK_PAGING_SIZE";
	public static final String ZK_GRID_EDIT_MODELESS = "ZK_GRID_EDIT_MODELESS";
	public static final String ZK_DASHBOARD_REFRESH_INTERVAL = "ZK_DASHBOARD_REFRESH_INTERVAL";
	public static final String RecentItems_MaxShown = "RecentItems_MaxShown";
	public static final String USE_EMAIL_FOR_LOGIN = "USE_EMAIL_FOR_LOGIN";
	public static final String LOGIN_SHOW_RESETPASSWORD = "LOGIN_SHOW_RESETPASSWORD";
	public static final String ALogin_ShowOneRole = "ALogin_ShowOneRole";
	public static final String ZK_BROWSER_ICON = "ZK_BROWSER_ICON";
	public static final String ZK_BROWSER_TITLE = "ZK_BROWSER_TITLE";
	public static final String ZK_LOGO_LARGE = "ZK_LOGO_LARGE";
	public static final String ZK_LOGO_SMALL = "ZK_LOGO_SMALL";
	public static final String WEBUI_LOGOURL = "WEBUI_LOGOURL";
	public static final String LOCATION_MAX_CITY_ROWS = "LOCATION_MAX_CITY_ROWS";
	public static final String ZK_REPORT_FORM_OUTPUT_TYPE = "ZK_REPORT_FORM_OUTPUT_TYPE";
	public static final String ZK_REPORT_TABLE_OUTPUT_TYPE = "ZK_REPORT_TABLE_OUTPUT_TYPE";
	public static final String MENU_INFOUPDATER_SLEEP_MS = "MENU_INFOUPDATER_SLEEP_MS";
	public static final String SYSCONFIG_INFO_DOUBLECLICKTOGGLESSELECTION = "SYSCONFIG_INFO_DOUBLECLICKTOGGLESSELECTION";
	public static final String SYSCONFIG_INFO_DEFAULTSELECTED = "SYSCONFIG_INFO_DEFAULTSELECTED";
	public static final String DICTIONARY_ID_USE_CENTRALIZED_ID = "DICTIONARY_ID_USE_CENTRALIZED_ID";
	public static final String PROJECT_ID_USE_CENTRALIZED_ID = "PROJECT_ID_USE_CENTRALIZED_ID";
	public static final String SYSTEM_NATIVE_SEQUENCE = "SYSTEM_NATIVE_SEQUENCE";
	public static final String START_VALUE_BPLOCATION_NAME = "START_VALUE_BPLOCATION_NAME";
	public static final String CLIENT_ACCOUNTING = "CLIENT_ACCOUNTING";
	public static final String CHECK_CREDIT_ON_PREPAY_ORDER = "CHECK_CREDIT_ON_PREPAY_ORDER";
	public static final String CHECK_CREDIT_ON_CASH_POS_ORDER = "CHECK_CREDIT_ON_CASH_POS_ORDER";
	public static final String Invoice_ReverseUseNewNumber = "Invoice_ReverseUseNewNumber";
	public static final String PROJECT_ID_COMMENTS = "PROJECT_ID_COMMENTS";
	public static final String DICTIONARY_ID_COMMENTS = "DICTIONARY_ID_COMMENTS";
	public static final String LOCATION_MAPS_URL_PREFIX = "LOCATION_MAPS_URL_PREFIX";
	public static final String LOCATION_MAPS_ROUTE_PREFIX = "LOCATION_MAPS_ROUTE_PREFIX";
	public static final String LOCATION_MAPS_SOURCE_ADDRESS = "LOCATION_MAPS_SOURCE_ADDRESS";
	public static final String LOCATION_MAPS_DESTINATION_ADDRESS = "LOCATION_MAPS_DESTINATION_ADDRESS";
	public static final String PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CREDIT_CARD = "PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CREDIT_CARD";
	public static final String PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_PAYMENT = "PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_PAYMENT";
	public static final String PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_RECEIPT = "PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_RECEIPT";
	public static final String RecentItems_MaxSaved = "RecentItems_MaxSaved";
	public static final String DICTIONARY_ID_WEBSITE = "DICTIONARY_ID_WEBSITE";
	public static final String DICTIONARY_ID_USER = "DICTIONARY_ID_USER";
	public static final String DICTIONARY_ID_PASSWORD = "DICTIONARY_ID_PASSWORD";
	public static final String PROJECT_ID_WEBSITE = "PROJECT_ID_WEBSITE";
	public static final String PROJECT_ID_USER = "PROJECT_ID_USER";
	public static final String PROJECT_ID_PASSWORD = "PROJECT_ID_PASSWORD";
	public static final String PROJECT_ID_PROJECT = "PROJECT_ID_PROJECT";
	public static final String ZK_LOGIN_ALLOW_REMEMBER_ME = "ZK_LOGIN_ALLOW_REMEMBER_ME";
	public static final String SWING_LOGIN_ALLOW_REMEMBER_ME = "SWING_LOGIN_ALLOW_REMEMBER_ME";
	public static final String USER_PASSWORD_HASH = "USER_PASSWORD_HASH";
	public static final String USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES = "USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES";
	public static final String USER_LOCKING_MAX_LOGIN_ATTEMPT = "USER_LOCKING_MAX_LOGIN_ATTEMPT";
	public static final String USER_LOCKING_MAX_INACTIVE_PERIOD_DAY = "USER_LOCKING_MAX_INACTIVE_PERIOD_DAY";
	public static final String USER_LOCKING_MAX_PASSWORD_AGE_DAY = "USER_LOCKING_MAX_PASSWORD_AGE_DAY";
	public static final String CHANGE_PASSWORD_MUST_DIFFER = "CHANGE_PASSWORD_MUST_DIFFER";
	public static final String ProductUOMConversionUOMValidate = "ProductUOMConversionUOMValidate";
	public static final String ProductUOMConversionRateValidate = "ProductUOMConversionRateValidate";
	public static final String SYSTEM_INSERT_CHANGELOG = "SYSTEM_INSERT_CHANGELOG";
	public static final String REPORT_SWAP_MAX_ROWS = "REPORT_SWAP_MAX_ROWS";
	public static final String JASPER_SWAP_MAX_PAGES = "JASPER_SWAP_MAX_PAGES";
	public static final String ALERT_SEND_ATTACHMENT_AS_XLS = "ALERT_SEND_ATTACHMENT_AS_XLS";
	public static final String SWING_OVERRIDE_TEXT_AREA_BEHAVIOUR = "SWING_OVERRIDE_TEXT_AREA_BEHAVIOUR";
	public static final String MAIL_SEND_BCC_TO_ADDRESS = "MAIL_SEND_BCC_TO_ADDRESS";
	public static final String MAIL_SEND_BCC_TO_FROM = "MAIL_SEND_BCC_TO_FROM";
	public static final String REAL_TIME_POS = "REAL_TIME_POS";

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_SysConfig_ID id
	 */
	public MSysConfig (Properties ctx, int AD_SysConfig_ID, String trxName)
	{
		super (ctx, AD_SysConfig_ID, trxName);
		if (AD_SysConfig_ID == 0)
		{
		//	setName (null);
		//  setValue (null);
		}	
	}	//	MSysConfig

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MSysConfig (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MSysConfig
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MSysConfig.class);
	/** Cache			*/
	private static CCache<String, String> s_cache = new CCache<String, String>(Table_Name, 40, 0, true);
	
	/**
	 * Get system configuration property of type string
	 * @param Name
	 * @param defaultValue
	 * @return String
	 */
	public static String getValue(String Name, String defaultValue)
	{
		return getValue(Name, defaultValue, 0, 0);
	}
	
	/**
	 * Get system configuration property of type string
	 * @param Name
	 * @return String
	 */
	public static String getValue(String Name)
	{
		return getValue(Name, null);
	}
	
	/**
	 * Get system configuration property of type int
	 * @param Name
	 * @param defaultValue
	 * @return int
	 */
	public static int getIntValue(String Name, int defaultValue)
	{
		String s = getValue(Name);
		if (s == null)
			return defaultValue; 
		
		if (s.length() == 0)
			return defaultValue;
		//
		try
		{
			return Integer.parseInt(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getIntValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}
	
	/**
	 * Get system configuration property of type double
	 * @param Name
	 * @param defaultValue
	 * @return double
	 */
	public static double getDoubleValue(String Name, double defaultValue)
	{
		String s = getValue(Name);
		if (s == null || s.length() == 0)
			return defaultValue;
		//
		try
		{
			return Double.parseDouble(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getDoubleValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}
	
	/**
	 * Get system configuration property of type boolean
	 * @param Name
	 * @param defaultValue
	 * @return boolean
	 */
	public static boolean getBooleanValue(String Name, boolean defaultValue)
	{
		String s = getValue(Name);
		if (s == null || s.length() == 0)
			return defaultValue;
		
		if ("Y".equalsIgnoreCase(s))
			return true;
		else if ("N".equalsIgnoreCase(s))
			return false;
		else
			return Boolean.valueOf(s).booleanValue();
	}
	
	/**
	 * Get client configuration property of type string
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @return String
	 */
	public static String getValue(String Name, String defaultValue, int AD_Client_ID)
	{
		return getValue(Name, defaultValue, AD_Client_ID, 0);
	}
	
	/**
	 * Get system configuration property of type string
	 * @param Name
	 * @param Client ID
	 * @return String
	 */
	public static String getValue(String Name, int AD_Client_ID)
	{
		return (getValue(Name, null, AD_Client_ID));
	}
	
	/**
	 * Get system configuration property of type int
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @return int
	 */
	public static int getIntValue(String Name, int defaultValue, int AD_Client_ID)
	{
		String s = getValue(Name, AD_Client_ID);
		if (s == null)
			return defaultValue; 
		
		if (s.length() == 0)
			return defaultValue;
		//
		try
		{
			return Integer.parseInt(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getIntValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}
	
	/**
	 * Get system configuration property of type double
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @return double
	 */
	public static double getDoubleValue(String Name, double defaultValue, int AD_Client_ID)
	{
		String s = getValue(Name, AD_Client_ID);
		if (s == null || s.length() == 0)
			return defaultValue;
		//
		try
		{
			return Double.parseDouble(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getDoubleValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}
	
	/**
	 * Get system configuration property of type boolean
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @return boolean
	 */
	public static boolean getBooleanValue(String Name, boolean defaultValue, int AD_Client_ID)
	{
		String s = getValue(Name, AD_Client_ID);
		if (s == null || s.length() == 0)
			return defaultValue;
		
		if ("Y".equalsIgnoreCase(s))
			return true;
		else if ("N".equalsIgnoreCase(s))
			return false;
		else
			return Boolean.valueOf(s).booleanValue();
	}

	/**
	 * Get client configuration property of type string
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @param Organization ID
	 * @return String
	 */
	public static String getValue(String Name, String defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String key = ""+AD_Client_ID+"_"+AD_Org_ID+"_"+Name;
		String str = s_cache.get(key);
		if (str != null)
			return str;
		if (str == null && s_cache.containsKey(key)) // found null key
			return defaultValue;
		
		//
		String sql = "SELECT Value FROM AD_SysConfig"
						+ " WHERE Name=? AND AD_Client_ID IN (0, ?) AND AD_Org_ID IN (0, ?) AND IsActive='Y'"
						+ " ORDER BY AD_Client_ID DESC, AD_Org_ID DESC";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, Name);
			pstmt.setInt(2, AD_Client_ID);
			pstmt.setInt(3, AD_Org_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				str = rs.getString(1);
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, "getValue", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		if (str != null) {
			s_cache.put(key, str);
			return str;
		}
		else {
			// anyways, put the not found key as null
			s_cache.put(key, null);
			return defaultValue;
		}
	}
	
	/**
	 * Get system configuration property of type string
	 * @param Name
	 * @param Client ID
	 * @param Organization ID
	 * @return String
	 */
	public static String getValue(String Name, int AD_Client_ID, int AD_Org_ID)
	{
		return getValue(Name, null, AD_Client_ID, AD_Org_ID);
	}
	
	/**
	 * Get system configuration property of type int
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @param Organization ID
	 * @return int
	 */
	public static int getIntValue(String Name, int defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String s = getValue(Name, AD_Client_ID, AD_Org_ID);
		if (s == null)
			return defaultValue; 
		
		if (s.length() == 0)
			return defaultValue;
		//
		try
		{
			return Integer.parseInt(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getIntValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}
	
	/**
	 * Get system configuration property of type double
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @param Organization ID
	 * @return double
	 */
	public static double getDoubleValue(String Name, double defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String s = getValue(Name, AD_Client_ID, AD_Org_ID);
		if (s == null || s.length() == 0)
			return defaultValue;
		//
		try
		{
			return Double.parseDouble(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getDoubleValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}
	
	/**
	 * Get system configuration property of type boolean
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @param Organization ID
	 * @return boolean
	 */
	public static boolean getBooleanValue(String Name, boolean defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String s = getValue(Name, AD_Client_ID, AD_Org_ID);
		if (s == null || s.length() == 0)
			return defaultValue;
		
		if ("Y".equalsIgnoreCase(s))
			return true;
		else if ("N".equalsIgnoreCase(s))
			return false;
		else
			return Boolean.valueOf(s).booleanValue();
	}

	/**
	 * Get system configuration property of type Timestamp
	 * @param Name
	 * @return Timestamp
	 */
	public static Timestamp getTimestampValue(String Name)
	{
		return getTimestampValue(Name, null);
	}

	/**
	 * Get system configuration property of type Timestamp
	 * @param Name
	 * @param defaultValue
	 * @return Timestamp
	 */
	public static Timestamp getTimestampValue(String Name, Timestamp defaultValue)
	{
		return getTimestampValue(Name, defaultValue, 0);
	}

	/**
	 * Get system configuration property of type Timestamp
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @return Timestamp
	 */
	public static Timestamp getTimestampValue(String Name, Timestamp defaultValue, int AD_Client_ID)
	{
		return getTimestampValue(Name, defaultValue, AD_Client_ID, 0);
	}

	/**
	 * Get system configuration property of type Timestamp
	 * @param Name
	 * @param defaultValue
	 * @param Client ID
	 * @param Organization ID
	 * @return Timestamp
	 */
	public static Timestamp getTimestampValue(String Name, Timestamp defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String text = getValue(Name, null, AD_Client_ID, AD_Org_ID);
		if (text !=null)
			return convertStringToTimestamp(text);

		return defaultValue;
	}
	/** convert a string to a timestamp */
	static Timestamp convertStringToTimestamp(String text)
	{
		Timestamp dt = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = null;

		try {
			date = sdf.parse(text);
			dt = new Timestamp(date.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dt;
	}	
	
	/**************************************************************************
	 * 	Before Save
	 *	@param newRecord
	 *	@return true if save
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		log.fine("New=" + newRecord);
		
		if (getAD_Client_ID() != 0 || getAD_Org_ID() != 0) {
			
			// Get the configuration level from the System Record
			String configLevel = null;
			String sql = "SELECT ConfigurationLevel FROM AD_SysConfig WHERE Name=? AND AD_Client_ID = 0 AND AD_Org_ID = 0";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setString(1, getName());
				rs = pstmt.executeQuery();
				if (rs.next())
					configLevel = rs.getString(1);
			}
			catch (SQLException e)
			{
				s_log.log(Level.SEVERE, "getValue", e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
			
			if (configLevel == null) {
				// not found for system
				// if saving an org parameter - look config in client
				if (getAD_Org_ID() != 0) {
					// Get the configuration level from the System Record
					sql = "SELECT ConfigurationLevel FROM AD_SysConfig WHERE Name=? AND AD_Client_ID = ? AND AD_Org_ID = 0";
					try
					{
						pstmt = DB.prepareStatement(sql, null);
						pstmt.setString(1, getName());
						pstmt.setInt(2, getAD_Client_ID());
						rs = pstmt.executeQuery();
						if (rs.next())
							configLevel = rs.getString(1);
					}
					catch (SQLException e)
					{
						s_log.log(Level.SEVERE, "getValue", e);
					}
					finally
					{
						DB.close(rs, pstmt);
						rs = null; pstmt = null;
					}
				}
			}
			
			if (configLevel != null) {
				
				setConfigurationLevel(configLevel);
				
				// Disallow saving org parameter if the system parameter is marked as 'S' or 'C'
				if (getAD_Org_ID() != 0 && 
						(configLevel.equals(MSysConfig.CONFIGURATIONLEVEL_System) || 
						 configLevel.equals(MSysConfig.CONFIGURATIONLEVEL_Client))) {
					log.saveError( "Can't Save Org Level", "This is a system or client parameter, you can't save it as organization parameter" );
					return false;
				}

				// Disallow saving client parameter if the system parameter is marked as 'S'
				if (getAD_Client_ID() != 0 && configLevel.equals(MSysConfig.CONFIGURATIONLEVEL_System)) {
					log.saveError( "Can't Save Client Level", "This is a system parameter, you can't save it as client parameter" );
					return false;
				}

			} else {
				
				// fix possible wrong config level
				if (getAD_Org_ID() != 0)
					setConfigurationLevel(CONFIGURATIONLEVEL_Organization);
				else if (getAD_Client_ID() != 0 && getConfigurationLevel().equals(MSysConfig.CONFIGURATIONLEVEL_System))
					setConfigurationLevel(CONFIGURATIONLEVEL_Client);
				
			}

		}
		
		return true;
	}	//	beforeSave

	@Override
	public String toString()
	{
		return getClass().getSimpleName()+"["+get_ID()
			+", "+getName()+"="+getValue()
			+", ConfigurationLevel="+getConfigurationLevel()
			+", Client|Org="+getAD_Client_ID()+"|"+getAD_Org_ID()
			+", EntityType="+getEntityType()
			+"]";
	}

}	//	MSysConfig