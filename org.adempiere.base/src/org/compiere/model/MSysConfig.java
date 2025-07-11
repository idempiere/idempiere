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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	System Configuration
 *	
 *  @author Armen Rizal
 *  @version $Id: MSysConfig.java,v 1.5 2005/11/28 11:56:45 armen Exp $
 *  Contributor: Carlos Ruiz - globalqss - [ 1800371 ] System Configurator Enhancements
 *  @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1885496 ] Performance NEEDS
 */
public class MSysConfig extends X_AD_SysConfig
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4467301251742419106L;

	/** Constant for Predefine System Configuration Names (in alphabetical order) */
	
    public static final String AD_CHANGELOG_SAVE_UUID = "AD_CHANGELOG_SAVE_UUID";
    public static final String ADDRESS_VALIDATION = "ADDRESS_VALIDATION";
    public static final String ALERT_SEND_ATTACHMENT_AS_XLS = "ALERT_SEND_ATTACHMENT_AS_XLS";
    public static final String ALLOCATION_DESCRIPTION = "ALLOCATION_DESCRIPTION";
    public static final String ALLOW_APPLY_PAYMENT_TO_CREDITMEMO = "ALLOW_APPLY_PAYMENT_TO_CREDITMEMO";
    public static final String ALLOW_OVER_APPLIED_PAYMENT = "ALLOW_OVER_APPLIED_PAYMENT";
    public static final String ALLOW_REVERSAL_OF_RECONCILED_PAYMENT = "ALLOW_REVERSAL_OF_RECONCILED_PAYMENT";
    public static final String ALogin_ShowDate = "ALogin_ShowDate";
    @Deprecated(forRemoval = true, since = "11")
    public static final String ALogin_ShowOneRole = "ALogin_ShowOneRole";
    public static final String APPLICATION_DATABASE_VERSION = "APPLICATION_DATABASE_VERSION";
    public static final String APPLICATION_DATABASE_VERSION_SHOWN = "APPLICATION_DATABASE_VERSION_SHOWN";
    public static final String APPLICATION_HOST_SHOWN = "APPLICATION_HOST_SHOWN";   
    public static final String APPLICATION_IMPLEMENTATION_VENDOR = "APPLICATION_IMPLEMENTATION_VENDOR";
    public static final String APPLICATION_IMPLEMENTATION_VENDOR_SHOWN = "APPLICATION_IMPLEMENTATION_VENDOR_SHOWN";
    public static final String APPLICATION_JVM_VERSION_SHOWN = "APPLICATION_JVM_VERSION_SHOWN";
    public static final String APPLICATION_LOGIN_INFO_SHOWN = "APPLICATION_LOGIN_INFO_SHOWN";
    public static final String APPLICATION_LOGIN_LEFT_PANEL_SHOWN = "APPLICATION_LOGIN_LEFT_PANEL_SHOWN";
    public static final String APPLICATION_MAIN_VERSION = "APPLICATION_MAIN_VERSION";
    public static final String APPLICATION_MAIN_VERSION_SHOWN = "APPLICATION_MAIN_VERSION_SHOWN";
    public static final String APPLICATION_OS_INFO_SHOWN = "APPLICATION_OS_INFO_SHOWN";
    public static final String APPLICATION_URL = "APPLICATION_URL";
    public static final String ATTACH_EMBEDDED_2PACK = "ATTACH_EMBEDDED_2PACK";
    public static final String ATTACH_NOTIFY_2PACK = "ATTACH_NOTIFY_2PACK";
    public static final String AUTO_ASSIGN_ROLE_TO_CREATOR_USER = "AUTO_ASSIGN_ROLE_TO_CREATOR_USER";
    public static final String AUTOMATIC_PACKIN_FOLDERS = "AUTOMATIC_PACKIN_FOLDERS";
    public static final String AUTOMATIC_PACKIN_INITIAL_DELAY = "AUTOMATIC_PACKIN_INITIAL_DELAY";
    public static final String AUTOMATIC_PACKIN_PROCESSING = "AUTOMATIC_PACKIN_PROCESSING";
    public static final String AUTOMATIC_PACKIN_RETRIES = "AUTOMATIC_PACKIN_RETRIES";
    public static final String AUTOMATIC_PACKIN_TIMEOUT = "AUTOMATIC_PACKIN_TIMEOUT";
    public static final String BACKGROUND_JOB_ALLOWED = "BACKGROUND_JOB_ALLOWED";
    public static final String BACKGROUND_JOB_BY_DEFAULT = "BACKGROUND_JOB_BY_DEFAULT";
    public static final String BACKGROUND_JOB_MAX_IN_SYSTEM = "BACKGROUND_JOB_MAX_IN_SYSTEM";
    public static final String BACKGROUND_JOB_MAX_PER_CLIENT = "BACKGROUND_JOB_MAX_PER_CLIENT";
    public static final String BACKGROUND_JOB_MAX_PER_USER = "BACKGROUND_JOB_MAX_PER_USER";
    public static final String BANK_STATEMENT_POST_WITH_DATE_FROM_LINE = "BANK_STATEMENT_POST_WITH_DATE_FROM_LINE";
    public static final String BPARTNER_QUICK_ENTRY_OPTIONAL_LOCATION_TABLES = "BPARTNER_QUICK_ENTRY_OPTIONAL_LOCATION_TABLES";
    public static final String CALENDAR_ALTERNATE_TIMEZONE = "CALENDAR_ALTERNATE_TIMEZONE";
    public static final String CASH_AS_PAYMENT = "CASH_AS_PAYMENT";
    public static final String CHANGE_PASSWORD_MUST_DIFFER = "CHANGE_PASSWORD_MUST_DIFFER";
    public static final String CHART_MIN_WIDTH_3_PERIOD = "CHART_MIN_WIDTH_3_PERIOD";
    public static final String CHART_MIN_WIDTH_6_PERIOD = "CHART_MIN_WIDTH_6_PERIOD";
    public static final String CHECK_CREDIT_ON_CASH_POS_ORDER = "CHECK_CREDIT_ON_CASH_POS_ORDER";
    public static final String CHECK_CREDIT_ON_PREPAY_ORDER = "CHECK_CREDIT_ON_PREPAY_ORDER";
    public static final String CLIENT_ACCOUNTING = "CLIENT_ACCOUNTING";
    public static final String DASHBOARD_LAYOUT_ORIENTATION = "DASHBOARD_LAYOUT_ORIENTATION";
    public static final String DB_READ_REPLICA_NORMAL_MAX_ITERATIONS = "DB_READ_REPLICA_NORMAL_MAX_ITERATIONS";
    public static final String DB_READ_REPLICA_NORMAL_TIMEOUT_IN_MILLISECONDS = "DB_READ_REPLICA_NORMAL_TIMEOUT_IN_MILLISECONDS";
    public static final String DB_READ_REPLICA_URLS = "DB_READ_REPLICA_URLS";
    public static final String DEFAULT_COA_PATH = "DEFAULT_COA_PATH";
    public static final String DEFAULT_ENTITYTYPE = "DEFAULT_ENTITYTYPE"; // used as default in entity type columns with get_sysconfig
    public static final String DICTIONARY_ID_PASSWORD = "DICTIONARY_ID_PASSWORD";
    public static final String DICTIONARY_ID_USE_CENTRALIZED_ID = "DICTIONARY_ID_USE_CENTRALIZED_ID";
    public static final String DICTIONARY_ID_USER = "DICTIONARY_ID_USER";
    public static final String DICTIONARY_ID_WEBSITE = "DICTIONARY_ID_WEBSITE";
    public static final String DOCACTIONBUTTON_SHOWACTIONNAME = "DOCACTIONBUTTON_SHOWACTIONNAME";
    public static final String DPViews_ShowInfoAccount = "DPViews_ShowInfoAccount";
    public static final String DPViews_ShowInfoSchedule = "DPViews_ShowInfoSchedule";
    public static final String EMAIL_NOTIFY_2PACK = "EMAIL_NOTIFY_2PACK";
    public static final String EMAIL_SERVER_START_ENABLED = "EMAIL_SERVER_START_ENABLED";
    public static final String EMAIL_TEST_MAILTEXT_ID = "EMAIL_TEST_MAILTEXT_ID";
    public static final String ENABLE_PAYMENTBOX_BUTTON = "ENABLE_PAYMENTBOX_BUTTON";
    public static final String ENABLE_SSO = "ENABLE_SSO";
    public static final String ENABLE_SSO_OSGI_CONSOLE = "ENABLE_SSO_OSGI_CONSOLE";
    public static final String ENABLE_SSO_IDEMPIERE_MONITOR = "ENABLE_SSO_IDEMPIERE_MONITOR";
	public static final String SSO_SHOW_LOGINPAGE = "SSO_SHOW_LOGINPAGE";
    public static final String EXPORT_BLOB_COLUMN_FOR_INSERT = "EXPORT_BLOB_COLUMN_FOR_INSERT";
    public static final String FEEDBACK_EMAIL_CC = "FEEDBACK_EMAIL_CC";
    public static final String FEEDBACK_EMAIL_TO = "FEEDBACK_EMAIL_TO";
    public static final String FORCE_POSTING_PRIOR_TO_PERIOD_CLOSE = "FORCE_POSTING_PRIOR_TO_PERIOD_CLOSE";
    public static final String FORM_SQL_PROCESS_ALLOWED_KEYWORDS = "FORM_SQL_PROCESS_ALLOWED_KEYWORDS";
    public static final String FORM_SQL_QUERY_ALLOWED_KEYWORDS = "FORM_SQL_QUERY_ALLOWED_KEYWORDS";
    public static final String FORM_SQL_QUERY_LOG_ISSUE = "FORM_SQL_QUERY_LOG_ISSUE";
    public static final String FORM_SQL_QUERY_MAX_RECORDS = "FORM_SQL_QUERY_MAX_RECORDS";
    public static final String FORM_SQL_QUERY_TIMEOUT_IN_SECONDS = "FORM_SQL_QUERY_TIMEOUT_IN_SECONDS";
	public static final String GLOBAL_MAX_QUERY_RECORDS = "GLOBAL_MAX_QUERY_RECORDS";
	public static final String GLOBAL_MAX_REPORT_RECORDS = "GLOBAL_MAX_REPORT_RECORDS";
    public static final String GRIDTABLE_LOAD_TIMEOUT_IN_SECONDS = "GRIDTABLE_LOAD_TIMEOUT_IN_SECONDS";
	public static final String GRIDTABLE_INITIAL_COUNT_TIMEOUT_IN_SECONDS = "GRIDTABLE_INITIAL_COUNT_TIMEOUT_IN_SECONDS";
    public static final String HTML_REPORT_MINIFY = "HTML_REPORT_MINIFY";
    public static final String HTML_REPORT_THEME = "HTML_REPORT_THEME";
    public static final String IBAN_VALIDATION = "IBAN_VALIDATION";
    public static final String IDENTIFIER_SEPARATOR = "IDENTIFIER_SEPARATOR";
    public static final String IMAGE_DB_STORAGE_SAVE_AS_ZIP = "IMAGE_DB_STORAGE_SAVE_AS_ZIP";
    @Deprecated(forRemoval = true, since = "11")
    public static final String INFO_DEFAULTSELECTED = "INFO_DEFAULTSELECTED";
    @Deprecated(forRemoval = true, since = "11")
    public static final String INFO_DOUBLECLICKTOGGLESSELECTION = "INFO_DOUBLECLICKTOGGLESSELECTION";
    public static final String INFO_PRODUCT_SHOW_PRODUCTS_WITHOUT_PRICE = "INFO_PRODUCT_SHOW_PRODUCTS_WITHOUT_PRICE";
    public static final String Invoice_ReverseUseNewNumber = "Invoice_ReverseUseNewNumber";
    public static final String JASPER_SWAP_MAX_PAGES = "JASPER_SWAP_MAX_PAGES";
    public static final String LABEL_AUTOMATIC_COLOR = "LABEL_AUTOMATIC_COLOR";
    public static final String LASTRUN_RECORD_COUNT = "LASTRUN_RECORD_COUNT";
    public static final String LDAP_TYPE = "LDAP_TYPE";
    public static final String LOCATION_MAPS_DESTINATION_ADDRESS = "LOCATION_MAPS_DESTINATION_ADDRESS";
    public static final String LOCATION_MAPS_ROUTE_PREFIX = "LOCATION_MAPS_ROUTE_PREFIX";
    public static final String LOCATION_MAPS_SOURCE_ADDRESS = "LOCATION_MAPS_SOURCE_ADDRESS";
    public static final String LOCATION_MAPS_URL_PREFIX = "LOCATION_MAPS_URL_PREFIX";
    public static final String LOCATION_MAX_CITY_ROWS = "LOCATION_MAX_CITY_ROWS";
    public static final String LOGIN_HELP_URL = "LOGIN_HELP_URL";
    public static final String LOGIN_PREFIX_SEPARATOR = "LOGIN_PREFIX_SEPARATOR";
    public static final String LOGIN_SELECT_ROLE_HELP_URL = "LOGIN_SELECT_ROLE_HELP_URL";
    public static final String LOGIN_SHOW_RESETPASSWORD = "LOGIN_SHOW_RESETPASSWORD";
    public static final String LOGIN_WITH_TENANT_PREFIX = "LOGIN_WITH_TENANT_PREFIX";
    public static final String MAIL_DONT_SEND_TO_ADDRESS = "MAIL_DONT_SEND_TO_ADDRESS";
    public static final String MAIL_SEND_BCC_TO_ADDRESS = "MAIL_SEND_BCC_TO_ADDRESS";
    public static final String MAIL_SEND_BCC_TO_FROM = "MAIL_SEND_BCC_TO_FROM";
    public static final String MAIL_SEND_CREDENTIALS = "MAIL_SEND_CREDENTIALS";
	public static final String MAIL_SMTP_CONNECTIONTIMEOUT = "MAIL_SMTP_CONNECTIONTIMEOUT";
    public static final String MAIL_SMTP_TIMEOUT = "MAIL_SMTP_TIMEOUT";
	public static final String MAIL_SMTP_WRITETIMEOUT = "MAIL_SMTP_WRITETIMEOUT";
    public static final String MAX_ACTIVITIES_IN_LIST = "MAX_ACTIVITIES_IN_LIST";
    public static final String MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER = "MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER";
    public static final String MAX_ROWS_IN_TABLE_COMBOLIST = "MAX_ROWS_IN_TABLE_COMBOLIST";
    public static final String MAX_TEXT_LENGTH_ON_GRID_VIEW = "MAX_TEXT_LENGTH_ON_GRID_VIEW";
    public static final String MENU_INFOUPDATER_SLEEP_MS = "MENU_INFOUPDATER_SLEEP_MS";
    public static final String MESSAGES_AT_TENANT_LEVEL = "MESSAGES_AT_TENANT_LEVEL";
    public static final String MFA_NTP_TIMEOUT_IN_MILLISECONDS = "MFA_NTP_TIMEOUT_IN_MILLISECONDS";
    public static final String MFA_REGISTERED_DEVICE_EXPIRATION_DAYS = "MFA_REGISTERED_DEVICE_EXPIRATION_DAYS";
    public static final String MFG_ValidateCostsDifferenceOnCreate = "MFG_ValidateCostsDifferenceOnCreate";
    public static final String MFG_ValidateCostsOnCreate = "MFG_ValidateCostsOnCreate";
    public static final String MONITOR_INITIAL_WAIT_FOR_CLUSTER_IN_SECONDS = "MONITOR_INITIAL_WAIT_FOR_CLUSTER_IN_SECONDS";
    public static final String MONITOR_MAX_WAIT_FOR_CLUSTER_IN_SECONDS = "MONITOR_MAX_WAIT_FOR_CLUSTER_IN_SECONDS";
	public static final String MROLE_GETDEFAULT_RETURNS_NULL_WHEN_NO_CONTEXT = "MROLE_GETDEFAULT_RETURNS_NULL_WHEN_NO_CONTEXT";
    public static final String MSEQUENCE_GETNEXT_TIMEOUT = "MSEQUENCE_GETNEXT_TIMEOUT";
    public static final String OAUTH2_USE_ACCESS_TOKEN_UPN_ON_MICROSOFT_PROVIDER = "OAUTH2_USE_ACCESS_TOKEN_UPN_ON_MICROSOFT_PROVIDER";
    public static final String OAUTH2_USE_ID_TOKEN_PREF_USERNAME_ON_MS_PROVIDER = "OAUTH2_USE_ID_TOKEN_PREF_USERNAME_ON_MS_PROVIDER";
	public static final String ORDER_COLUMNS_TO_COPY_TO_NOT_COMPLETED_INVOICES = "ORDER_COLUMNS_TO_COPY_TO_NOT_COMPLETED_INVOICES";
    public static final String PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_PAYMENT = "PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_PAYMENT";
    public static final String PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_RECEIPT = "PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CHECK_ON_RECEIPT";
    public static final String PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CREDIT_CARD = "PAYMENT_OVERWRITE_DOCUMENTNO_WITH_CREDIT_CARD";
    public static final String PAYMENT_SELECTION_MANUAL_ASK_INVOKE_GENERATE = "PAYMENT_SELECTION_MANUAL_ASK_INVOKE_GENERATE";
    public static final String PDF_FONT_DIR = "PDF_FONT_DIR";
    public static final String ProductUOMConversionRateValidate = "ProductUOMConversionRateValidate";
    public static final String ProductUOMConversionUOMValidate = "ProductUOMConversionUOMValidate";
    public static final String PROJECT_ID_PASSWORD = "PROJECT_ID_PASSWORD";
    public static final String PROJECT_ID_PROJECT = "PROJECT_ID_PROJECT";
    public static final String PROJECT_ID_USE_CENTRALIZED_ID = "PROJECT_ID_USE_CENTRALIZED_ID";
    public static final String PROJECT_ID_USER = "PROJECT_ID_USER";
    public static final String PROJECT_ID_WEBSITE = "PROJECT_ID_WEBSITE";
    public static final String QUICKFORM_PAGE_SIZE = "QUICKFORM_PAGE_SIZE";
    public static final String REAL_TIME_POS = "REAL_TIME_POS";
    public static final String RecentItems_MaxSaved = "RecentItems_MaxSaved";
    public static final String RecentItems_MaxShown = "RecentItems_MaxShown";
	public static final String REPORT_LOAD_TIMEOUT_IN_SECONDS = "REPORT_LOAD_TIMEOUT_IN_SECONDS";
    public static final String REPORT_SWAP_MAX_ROWS = "REPORT_SWAP_MAX_ROWS";
    public static final String SHIPPING_DEFAULT_WEIGHT_PER_PACKAGE = "SHIPPING_DEFAULT_WEIGHT_PER_PACKAGE";
    public static final String STANDARD_REPORT_FOOTER_TRADEMARK_TEXT = "STANDARD_REPORT_FOOTER_TRADEMARK_TEXT";
    public static final String START_VALUE_BPLOCATION_NAME = "START_VALUE_BPLOCATION_NAME";
    public static final String SWING_LOGIN_ALLOW_REMEMBER_ME = "SWING_LOGIN_ALLOW_REMEMBER_ME";
    public static final String SWING_OVERRIDE_TEXT_AREA_BEHAVIOUR = "SWING_OVERRIDE_TEXT_AREA_BEHAVIOUR";
    public static final String SYSTEM_IN_MAINTENANCE_MODE = "SYSTEM_IN_MAINTENANCE_MODE";
    public static final String SYSTEM_INSERT_CHANGELOG = "SYSTEM_INSERT_CHANGELOG";
    public static final String SYSTEM_NATIVE_SEQUENCE = "SYSTEM_NATIVE_SEQUENCE";
	public static final String SSO_SELECT_ROLE = "SSO_SELECT_ROLE";
    public static final String TAX_LOOKUP_SERVICE = "TAX_LOOKUP_SERVICE";
    public static final String TOP_MARGIN_PIXELS_FOR_HEADER = "TOP_MARGIN_PIXELS_FOR_HEADER";
    public static final String TRACE_ALL_TRX_CONNECTION_GET = "TRACE_ALL_TRX_CONNECTION_GET";
    public static final String TRX_AUTOSET_DISPLAY_NAME = "TRX_AUTOSET_DISPLAY_NAME";
    public static final String TWOPACK_COMMIT_DDL = "2PACK_COMMIT_DDL";
    public static final String TWOPACK_HANDLE_TRANSLATIONS = "2PACK_HANDLE_TRANSLATIONS";
    public static final String UPLOAD_TEMP_FILENAME_PREFIX = "UPLOAD_TEMP_FILENAME_PREFIX";
    public static final String USE_EMAIL_FOR_LOGIN = "USE_EMAIL_FOR_LOGIN";
    public static final String USE_ESC_FOR_TAB_CLOSING = "USE_ESC_FOR_TAB_CLOSING";
    public static final String USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES = "USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES";
    public static final String USER_LOCKING_MAX_INACTIVE_PERIOD_DAY = "USER_LOCKING_MAX_INACTIVE_PERIOD_DAY";
    public static final String USER_LOCKING_MAX_LOGIN_ATTEMPT = "USER_LOCKING_MAX_LOGIN_ATTEMPT";
    public static final String USER_LOCKING_MAX_PASSWORD_AGE_DAY = "USER_LOCKING_MAX_PASSWORD_AGE_DAY";
    public static final String USER_LOCKING_PASSWORD_NOTIFY_DAY = "USER_LOCKING_PASSWORD_NOTIFY_DAY";
    public static final String USER_PASSWORD_HASH = "USER_PASSWORD_HASH";
    public static final String VALIDATE_MATCHING_PRODUCT_ON_SHIPMENT = "VALIDATE_MATCHING_PRODUCT_ON_SHIPMENT";
    public static final String VALIDATE_MATCHING_TO_ORDERED_QTY = "VALIDATE_MATCHING_TO_ORDERED_QTY";
    public static final String WEBUI_LOGOURL = "WEBUI_LOGOURL";
    public static final String XLSX_EXPORT_USE_FAST_METHOD = "XLSX_EXPORT_USE_FAST_METHOD";
    public static final String ZK_ADVANCE_FIND_FILTER_COLUMN_LIST = "ZK_ADVANCE_FIND_FILTER_COLUMN_LIST";
    public static final String ZK_AUTO_SAVE_CHANGES = "ZK_AUTO_SAVE_CHANGES";
    public static final String ZK_AUTO_SAVE_TABS_EXCLUDED = "ZK_AUTO_SAVE_TABS_EXCLUDED";
    public static final String ZK_BROWSER_ICON = "ZK_BROWSER_ICON";
    public static final String ZK_BROWSER_TITLE = "ZK_BROWSER_TITLE";
    public static final String ZK_BUTTON_STYLE = "ZK_BUTTON_STYLE";
    public static final String ZK_DASHBOARD_CALENDAR_REQUEST_DISPLAY_MODE = "ZK_DASHBOARD_CALENDAR_REQUEST_DISPLAY_MODE";
    public static final String ZK_DASHBOARD_PERFORMANCE_REFRESH_INTERVAL = "ZK_DASHBOARD_PERFORMANCE_REFRESH_INTERVAL";
    /** @deprecated not use for the new billboard implementation */
    @Deprecated(forRemoval = true, since = "11")
    public static final String ZK_DASHBOARD_PERFORMANCE_TIMEOUT = "ZK_DASHBOARD_PERFORMANCE_TIMEOUT";
    public static final String ZK_DASHBOARD_REFRESH_INTERVAL = "ZK_DASHBOARD_REFRESH_INTERVAL";
    public static final String ZK_DECIMALBOX_PROCESS_DOTKEYPAD = "ZK_DECIMALBOX_PROCESS_DOTKEYPAD";
	public static final String ZK_DESKTOP_HEADER_BACKGROUND_COLOR = "ZK_DESKTOP_HEADER_BACKGROUND_COLOR"; // used in desktop.css.dsp
	public static final String ZK_DESKTOP_HEADER_MESSAGE_VALUE = "ZK_DESKTOP_HEADER_MESSAGE_VALUE";
    public static final String ZK_DESKTOP_CLASS = "ZK_DESKTOP_CLASS";
    public static final String ZK_DESKTOP_SHOW_HOME_BUTTON = "ZK_DESKTOP_SHOW_HOME_BUTTON";
    public static final String ZK_DESKTOP_SHOW_TAB_LIST_BUTTON = "ZK_DESKTOP_SHOW_TAB_LIST_BUTTON";
    public static final String ZK_DESKTOP_TAB_AUTO_SHRINK_TO_FIT = "ZK_DESKTOP_TAB_AUTO_SHRINK_TO_FIT";
    public static final String ZK_DESKTOP_TAB_MAX_TITLE_LENGTH = "ZK_DESKTOP_TAB_MAX_TITLE_LENGTH";
    public static final String ZK_ERROR_MSG_LIFETIME_MILLISECONDS = "ZK_ERROR_MSG_LIFETIME_MILLISECONDS";
    public static final String ZK_FIELD_LABEL_ABOVE_INPUT = "ZK_FIELD_LABEL_ABOVE_INPUT";
    public static final String ZK_FIELD_MOBILE_LABEL_ABOVE_INPUT = "ZK_FIELD_MOBILE_LABEL_ABOVE_INPUT";
    public static final String ZK_FIELD_MOBILE_SMALL_WIDTH_LABEL_ABOVE_INPUT = "ZK_FIELD_MOBILE_SMALL_WIDTH_LABEL_ABOVE_INPUT";
    public static final String ZK_FLAT_VIEW_MENU_TREE = "ZK_FLAT_VIEW_MENU_TREE";
    public static final String ZK_FOOTER_SERVER_DATETIME_FORMAT = "ZK_FOOTER_SERVER_DATETIME_FORMAT";
    public static final String ZK_FOOTER_SERVER_MSG = "ZK_FOOTER_SERVER_MSG";
    public static final String ZK_GRID_AFTER_FIND = "ZK_GRID_AFTER_FIND";
    public static final String ZK_GRID_AUTO_HIDE_EMPTY_COLUMNS = "ZK_GRID_AUTO_HIDE_EMPTY_COLUMNS";
    public static final String ZK_GRID_EDIT_MODELESS = "ZK_GRID_EDIT_MODELESS";
    public static final String ZK_GRID_MOBILE_AUTO_HIDE_EMPTY_COLUMNS = "ZK_GRID_MOBILE_AUTO_HIDE_EMPTY_COLUMNS";
    public static final String ZK_GRID_MOBILE_EDITABLE = "ZK_GRID_MOBILE_EDITABLE";
    public static final String ZK_GRID_MOBILE_EDIT_MODELESS = "ZK_GRID_MOBILE_EDIT_MODELESS";
    public static final String ZK_GRID_MOBILE_LINE_BREAK_AS_IDENTIFIER_SEPARATOR = "ZK_GRID_MOBILE_LINE_BREAK_AS_IDENTIFIER_SEPARATOR";
    public static final String ZK_GRID_MOBILE_MAX_COLUMNS = "ZK_GRID_MOBILE_MAX_COLUMNS";
    public static final String ZK_GRID_MOBILE_SHOW_CURRENT_ROW_INDICATOR = "ZK_GRID_MOBILE_SHOW_CURRENT_ROW_INDICATOR";
    public static final String ZK_GRID_VIEW_USE_DEFER_RENDERING = "ZK_GRID_VIEW_USE_DEFER_RENDERING";
    public static final String ZK_INFO_AUTO_COLLAPSED_PARAMETER_PANEL = "ZK_INFO_AUTO_COLLAPSED_PARAMETER_PANEL";
    public static final String ZK_INFO_AUTO_HIDE_EMPTY_COLUMNS = "ZK_INFO_AUTO_HIDE_EMPTY_COLUMNS";
    public static final String ZK_INFO_MOBILE_AUTO_COLLAPSED_PARAMETER_PANEL = "ZK_INFO_MOBILE_AUTO_COLLAPSED_PARAMETER_PANEL";
    public static final String ZK_INFO_MOBILE_AUTO_HIDE_EMPTY_COLUMNS = "ZK_INFO_MOBILE_AUTO_HIDE_EMPTY_COLUMNS";
    public static final String ZK_INFO_NUM_PAGE_PRELOAD = "ZK_INFO_NUM_PAGE_PRELOAD";
    public static final String ZK_INFO_QUERY_TIME_OUT =  "ZK_INFO_QUERY_TIME_OUT";
    public static final String ZK_LOGIN_ALLOW_CHROME_SAVE_PASSWORD = "ZK_LOGIN_ALLOW_CHROME_SAVE_PASSWORD";
    public static final String ZK_LOGIN_ALLOW_REMEMBER_ME = "ZK_LOGIN_ALLOW_REMEMBER_ME";
    public static final String ZK_LOGO_LARGE = "ZK_LOGO_LARGE";
    public static final String ZK_LOGO_SMALL = "ZK_LOGO_SMALL";
    public static final String ZK_MAX_ATTACHMENT_PREVIEW_SIZE = "ZK_MAX_ATTACHMENT_PREVIEW_SIZE";
    public static final String ZK_MAX_UPLOAD_SIZE = "ZK_MAX_UPLOAD_SIZE";
    public static final String ZK_MOBILE_PAGING_SIZE = "ZK_MOBILE_PAGING_SIZE";
    public static final String ZK_PAGING_DETAIL_SIZE = "ZK_PAGING_DETAIL_SIZE";
    public static final String ZK_PAGING_SIZE = "ZK_PAGING_SIZE";
    public static final String ZK_REPORT_FORM_OUTPUT_TYPE = "ZK_REPORT_FORM_OUTPUT_TYPE";
    public static final String ZK_REPORT_JASPER_OUTPUT_TYPE = "ZK_REPORT_JASPER_OUTPUT_TYPE";
    public static final String ZK_REPORT_ONLY_PRINTFORMAT_LINKEDTO_REPORTVIEW = "ZK_REPORT_ONLY_PRINTFORMAT_LINKEDTO_REPORTVIEW";
    public static final String ZK_REPORT_TABLE_OPEN_IN_NEW_TAB = "ZK_REPORT_TABLE_OPEN_IN_NEW_TAB";
    public static final String ZK_REPORT_TABLE_OUTPUT_TYPE = "ZK_REPORT_TABLE_OUTPUT_TYPE";
    public static final String ZK_ROOT_FOLDER_BROWSER = "ZK_ROOT_FOLDER_BROWSER";
    public static final String ZK_SEARCH_AUTO_COMPLETE_MAX_ROWS = "ZK_SEARCH_AUTO_COMPLETE_MAX_ROWS";
    public static final String ZK_SEQ_DEFAULT_VALUE_PANEL = "ZK_SEQ_DEFAULT_VALUE_PANEL";
    public static final String ZK_SESSION_TIMEOUT_IN_SECONDS = "ZK_SESSION_TIMEOUT_IN_SECONDS";
    public static final String ZK_THEME = "ZK_THEME";
    public static final String ZK_THEME_USE_FONT_ICON_FOR_IMAGE = "ZK_THEME_USE_FONT_ICON_FOR_IMAGE";
    public static final String ZK_THUMBNAIL_IMAGE_HEIGHT = "ZK_THUMBNAIL_IMAGE_HEIGHT";
    public static final String ZK_THUMBNAIL_IMAGE_WIDTH = "ZK_THUMBNAIL_IMAGE_WIDTH";
    public static final String ZK_TOOLBAR_SHOW_MORE_VERTICAL = "ZK_TOOLBAR_SHOW_MORE_VERTICAL";
    public static final String ZK_USE_PDF_JS_VIEWER = "ZK_USE_PDF_JS_VIEWER";
    public static final String ZOOM_ACROSS_QUERY_TIMEOUT = "ZOOM_ACROSS_QUERY_TIMEOUT";

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_SysConfig_UU  UUID key
     * @param trxName Transaction
     */
    public MSysConfig(Properties ctx, String AD_SysConfig_UU, String trxName) {
        super(ctx, AD_SysConfig_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_SysConfig_ID id
	 */
	public MSysConfig (Properties ctx, int AD_SysConfig_ID, String trxName)
	{
		super (ctx, AD_SysConfig_ID, trxName);
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
	private static CCache<String, String> s_cache = new CCache<String, String>(Table_Name, 40, 0, false, 0);
	
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
	 * @return configured value
	 */
	public static String getValue(String Name)
	{
		return getValue(Name, null);
	}
	
	/**
	 * Get system configuration property of type integer
	 * @param Name
	 * @param defaultValue
	 * @return configured value or defaultValue
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
	 * @deprecated replace by getBigDecimalValue
	 */
	@Deprecated
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
	 * Get system configuration property of type BigDecimal
	 * @param Name
	 * @param defaultValue
	 * @return configured value or defaultValue
	 */
	public static BigDecimal getBigDecimalValue(String Name, BigDecimal defaultValue)
	{
		String s = getValue(Name);
		if (s == null || s.length() == 0)
			return defaultValue;
		//
		try
		{
			return new BigDecimal(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getBigDecimalValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}

	/**
	 * Get system configuration property of type boolean
	 * @param Name
	 * @param defaultValue
	 * @return configured value or defaultValue
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
	 * @param AD_Client_ID Client ID
	 * @return configured value or 0
	 */
	public static String getValue(String Name, String defaultValue, int AD_Client_ID)
	{
		return getValue(Name, defaultValue, AD_Client_ID, 0);
	}
	
	/**
	 * Get system configuration property of type string
	 * @param Name
	 * @param AD_Client_ID Client ID
	 * @return configured value or null
	 */
	public static String getValue(String Name, int AD_Client_ID)
	{
		return (getValue(Name, null, AD_Client_ID));
	}
	
	/**
	 * Get system configuration property of type int
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @return configured value or defaultValue
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
	 * @param AD_Client_ID Client ID
	 * @return double
	 * @deprecated replace by getBigDecimalValue
	 */
	@Deprecated
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
	 * Get system configuration property of type BigDecimal
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @return configured value or defaultValue
	 */
	public static BigDecimal getBigDecimalValue(String Name, BigDecimal defaultValue, int AD_Client_ID)
	{
		String s = getValue(Name, AD_Client_ID);
		if (s == null || s.length() == 0)
			return defaultValue;
		//
		try
		{
			return new BigDecimal(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getBigDecimalValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}

	/**
	 * Get system configuration property of type boolean
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @return configured value or defaultValue
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
	 * Get organization configuration property of type string
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @param AD_Org_ID Organization ID
	 * @return configured value or defaultValue
	 */
	public static String getValue(String Name, String defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String key = ""+AD_Client_ID+"_"+AD_Org_ID+"_"+Name;
		String str = null;
		if (! Name.endsWith("_NOCACHE")) {
			str = s_cache.get(key);
			if (str != null)
				return str;
			if (str == null && s_cache.containsKey(key)) // found null key
				return defaultValue;
		}

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
			if (! Name.endsWith("_NOCACHE"))
				s_cache.put(key, str);
			return str;
		} else {
			// anyways, put the not found key as null
			if (! Name.endsWith("_NOCACHE"))
				s_cache.put(key, null);
			return defaultValue;
		}
	}
	
	/**
	 * Get organization configuration property of type string
	 * @param Name
	 * @param AD_Client_ID Client ID
	 * @param AD_Org_ID Organization ID
	 * @return configured value or null
	 */
	public static String getValue(String Name, int AD_Client_ID, int AD_Org_ID)
	{
		return getValue(Name, null, AD_Client_ID, AD_Org_ID);
	}
	
	/**
	 * Get organization configuration property of type integer
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @param AD_Org_ID Organization ID
	 * @return configured value or defaultValue
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
	 * @param AD_Client_ID Client ID
	 * @param AD_Org_ID Organization ID
	 * @return double
	 * @deprecated replace by getBigDecimalValue
	 */
	@Deprecated
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
	 * Get system configuration property of type BigDecimal
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @param AD_Org_ID Organization ID
	 * @return configured value or defaultValue
	 */
	public static BigDecimal getBigDecimalValue(String Name, BigDecimal defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String s = getValue(Name, AD_Client_ID, AD_Org_ID);
		if (s == null || s.length() == 0)
			return defaultValue;
		//
		try
		{
			return new BigDecimal(s);
		}
		catch (NumberFormatException e)
		{
			s_log.log(Level.SEVERE, "getBigDecimalValue (" + Name + ") = " + s, e);
		}
		return defaultValue;
	}

	/**
	 * Get system configuration property of type boolean
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @param AD_Org_ID Organization ID
	 * @return configured value or defaultValue
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
	 * @return configured value or null
	 */
	public static Timestamp getTimestampValue(String Name)
	{
		return getTimestampValue(Name, null);
	}

	/**
	 * Get system configuration property of type Timestamp
	 * @param Name
	 * @param defaultValue
	 * @return configured value or defaultValue
	 */
	public static Timestamp getTimestampValue(String Name, Timestamp defaultValue)
	{
		return getTimestampValue(Name, defaultValue, 0);
	}

	/**
	 * Get system configuration property of type Timestamp
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @return configured value or defaultValue
	 */
	public static Timestamp getTimestampValue(String Name, Timestamp defaultValue, int AD_Client_ID)
	{
		return getTimestampValue(Name, defaultValue, AD_Client_ID, 0);
	}

	/**
	 * Get system configuration property of type Timestamp
	 * @param Name
	 * @param defaultValue
	 * @param AD_Client_ID Client ID
	 * @param AD_Org_ID Organization ID
	 * @return configured value or defaultValue
	 */
	public static Timestamp getTimestampValue(String Name, Timestamp defaultValue, int AD_Client_ID, int AD_Org_ID)
	{
		String text = getValue(Name, null, AD_Client_ID, AD_Org_ID);
		if (text !=null)
			return convertStringToTimestamp(text);

		return defaultValue;
	}

	private static int lendate = DisplayType.DEFAULT_DATE_FORMAT.length();
	private static int lentime = DisplayType.DEFAULT_TIME_FORMAT.length();
	private static int lentimestamp = DisplayType.DEFAULT_TIMESTAMP_FORMAT.length();

	/** 
	 * Convert a string to a time stamp.<br/>
	 * The method uses the length of the text argument to determine the time stamp format pattern to use.
	 * @param text text to be converted to time stamp
	 * @return converted time stamp 
	 */
	protected static Timestamp convertStringToTimestamp(String text)
	{
		SimpleDateFormat sdf = null;
		int lentext = text.length();
		if (lentext == lendate) {
			sdf = DisplayType.getDateFormat_JDBC();
		} else if (lentext == lentime) {
			sdf = DisplayType.getTimeFormat_Default();
		} else if (lentext == lentimestamp) {
			sdf = DisplayType.getTimestampFormat_Default();
		} else {
			s_log.warning("Cannot convert to a valid timestamp (invalid length): " + text);
		}

		Timestamp dt = null;
		if (sdf != null) {
			try {
				Date date = sdf.parse(text);
				dt = new Timestamp(date.getTime());
			} catch (ParseException e) {
				s_log.warning("Cannot convert to a valid timestamp: " + text);
			}
		}
		return dt;
	}	
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (log.isLoggable(Level.FINE)) log.fine("New=" + newRecord);
		
		// Validate configuration level
		if (getAD_Client_ID() != 0 || getAD_Org_ID() != 0) {
			
			// Get the configuration level from System client Record
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
				// No System client record
				// If saving with org parameter, find configuration level from client
				if (getAD_Org_ID() != 0) {
					// Get the configuration level from client record
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
					log.saveError( "Can't Save Org Level",Msg.getMsg(p_ctx, "ThisIsSystemOrTenantParameter"));
					return false;
				}

				// Disallow saving client parameter if the system parameter is marked as 'S'
				if (getAD_Client_ID() != 0 && configLevel.equals(MSysConfig.CONFIGURATIONLEVEL_System)) {
					log.saveError( "Can't Save Tenant Level",Msg.getMsg(p_ctx, "ThisIsSystemParameter"));
					return false;
				}

			} else {
				
				// fix possible wrong config level
				if (getAD_Org_ID() != 0)
					setConfigurationLevel(CONFIGURATIONLEVEL_Organization);
				else if (getAD_Client_ID() != 0 && (Util.isEmpty(getConfigurationLevel()) || getConfigurationLevel().equals(MSysConfig.CONFIGURATIONLEVEL_System)))
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

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (success && newRecord && ! getName().endsWith("_NOCACHE")) {
			// Clear cache of AD_SysConfig
			// This is to clear the cache of AD_SysConfig when creating a new record
			// the reset cache is being called on PO when a record is changed or deleted, but not on new
			// NOTE also that reset the specific ID doesn't work because the MSysConfig cache holds a
			//   String type, and CCache.reset(int) just call reset when the key is not an Integer
			Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(Table_Name));
		}
		return success;
	}

	@Override
	protected boolean afterDelete(boolean success) {
		if (success && ! getName().endsWith("_NOCACHE")) {
			Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(Table_Name));
		}
		return success;
	}

}	//	MSysConfig;
