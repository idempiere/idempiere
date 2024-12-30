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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/
package org.compiere.model;

import org.compiere.util.Ini;
import org.compiere.util.SecureInterface;

/**
 * Collection of System properties used in iDempiere
 * 
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class SystemProperties {

	private static final String ADEMPIERE_DB_SYSTEM_USER = "ADEMPIERE_DB_SYSTEM_USER";
	private static final String ADEMPIERE_SECURE = SecureInterface.ADEMPIERE_SECURE;
	private static final String Cache_ExpireMinute = "Cache.ExpireMinute";
	private static final String Cache_MaxSize = "Cache.MaxSize";
	private static final String Cache_MaxSize_Per_Table_Prefix = "Cache.MaxSize.";
	private static final String env_IDEMPIERE_HOME = Ini.ENV_PREFIX + Ini.IDEMPIERE_HOME;
	private static final String IDEMPIERE_HOME = Ini.IDEMPIERE_HOME;
	private static final String IDEMPIERE_SECURE_PROPERTIES = "IDEMPIERE_SECURE_PROPERTIES";
	private static final String LogLevel = "LogLevel";
	private static final String org_adempiere_po_useTimeoutForUpdate = "org.adempiere.po.useTimeoutForUpdate";
	private static final String org_compiere_report_path = "org.compiere.report.path";
	private static final String org_idempiere_db_debug = "org.idempiere.db.debug";
	private static final String org_idempiere_db_debug_convert = "org.idempiere.db.debug.convert";
	private static final String org_idempiere_db_debug_filter = "org.idempiere.db.debug.filter";
	private static final String org_idempiere_FileLogPrefix = "org.idempiere.FileLogPrefix";
	private static final String org_idempiere_FullExceptionTraceInLog = "org.idempiere.FullExceptionTraceInLog";
	private static final String org_idempiere_postgresql_URLParameters = "org.idempiere.postgresql.URLParameters";
	private static final String org_idempiere_po_useOptimisticLocking = "org.idempiere.po.useOptimisticLocking";
	private static final String PostgreSQLNative = "PostgreSQLNative";
	private static final String PropertyFile = "PropertyFile";
	private static final String PropertyHomeFile = "PropertyHomeFile";
	private static final String TestOCI = "TestOCI";
	private static final String TRACE_NULL_TRX_CONNECTION = "TRACE_NULL_TRX_CONNECTION";
	private static final String ZK_THEME = MSysConfig.ZK_THEME;
	private static final String ZkUnitTest = "ZkUnitTest";

	/**
	 * ADEMPIERE_DB_SYSTEM_USER allows to override the default name of the system user for the database
	 * @return
	 */
	public static String getAdempiereDBSystemUser() {
		return System.getProperty(ADEMPIERE_DB_SYSTEM_USER);
	}

	/**
	 * ADEMPIERE_SECURE allows to override the default security class
	 * @return
	 */
	public static String getAdempiereSecure() {
		return System.getProperty(ADEMPIERE_SECURE);
	}

	/**
	 * Cache.ExpireMinute allows to override the default expire minutes for cache
	 * @return
	 */
	public static String getCacheExpireMinute() {
		return System.getProperty(Cache_ExpireMinute);
	}

	/**
	 * Cache.MaxSize allows to override the default max size for cache
	 * @return
	 */
	public static String getCacheMaxSize() {
		return System.getProperty(Cache_MaxSize);
	}

	/**
	 * Cache.MaxSize.[Table] allows to define a max size for cache specific for one table.<br/>
	 * For example -DCache.MaxSize.AD_Column=15000 will set the max size for AD_Column
	 * @return
	 */
	public static String getCacheMaxSizeTable(String tableName) {
		return System.getProperty(Cache_MaxSize_Per_Table_Prefix + tableName);
	}

	/**
	 * env.IDEMPIERE_HOME to define the home of iDempiere server instance
	 * @return
	 */
	public static String getEnvIdempiereHome() {
		return System.getProperty(env_IDEMPIERE_HOME);
	}

	/**
	 * IDEMPIERE_HOME to define the home of iDempiere server instance
	 * @return
	 */
	public static String getIdempiereHome() {
		return System.getProperty(IDEMPIERE_HOME);
	}

	/**
	 * IDEMPIERE_HOME to define the home of iDempiere server instance
	 * @return
	 */
	public static String setIdempiereHome(String idempiereHome) {
		return System.setProperty(IDEMPIERE_HOME, idempiereHome);
	}

	/**
	 * Verify if the system manages properties in a more secure way.<br/>
	 * For Windows and swing client the properties are managed as always.<br/>
	 * For other systems (like Linux) the default is to manage it with more security.<br/>
	 * This can be overridden passing the parameter -DIDEMPIERE_SECURE_PROPERTIES=false to the JVM.
	 * @return
	 */
	public static boolean isSecureProperties() {
		String secureProps = System.getProperty(IDEMPIERE_SECURE_PROPERTIES);
		return ! (secureProps != null && secureProps.equals("false"));
	}

	/**
	 * LogLevel=SEVERE|WARNING|INFO|CONFIG|FINE|FINER|FINEST  Set the log level for the Pack In Folder application.
	 * for example: LogLevel=INFO
	 * @return
	 */
	public static String getLogLevel() {
		return System.getProperty(LogLevel);
	}

	/**
	 * Define if it uses a timeout when executing an UPDATE or DELETE in PO class, default false
	 * @return
	 */
	public static boolean isUseTimeoutForUpdate() {
		return "true".equalsIgnoreCase(System.getProperty(org_adempiere_po_useTimeoutForUpdate, "false"));
	}

	/**
	 * org.compiere.report.path used to override the default of the report path where jasper reports are found
	 * @return
	 */
	public static String getReportPath() {
		return System.getProperty(org_compiere_report_path);
	}

	/**
	 * org.idempiere.db.debug=true to print SQL Statements as log.warning
	 * @return
	 */
	public static boolean isDBDebug() {
		return "true".equals(System.getProperty(org_idempiere_db_debug));
	}

	/**
	 * org.idempiere.db.debug.filter as a regular expression to filter the statements written in log.<br/>
	 * for example: org.idempiere.db.debug.filter='(?i)(?s:.)*\bc_order\b(?s:.)*' will show all SQL related to c_order table
	 * @return
	 */
	public static String getDBDebugFilter() {
		return System.getProperty(org_idempiere_db_debug_filter);
	}

	/**
	 * org.idempiere.db.convert=true to print also Oracle SQL Statements being converted
	 * @return
	 */
	public static boolean isDBDebugConvert() {
		return "true".equals(System.getProperty(org_idempiere_db_debug_convert));
	}

	/**
	 * org.idempiere.FileLogPrefix defines the template prefix to write logs
	 * @return
	 */
	public static String getFileLogPrefix() {
		return System.getProperty(org_idempiere_FileLogPrefix);
	}

	/**
	 * org.idempiere.FileLogPrefix defines the template prefix to write logs
	 * @return
	 */
	public static String setFileLogPrefix(String fileLogPrefix) {
		return System.setProperty(org_idempiere_FileLogPrefix, fileLogPrefix);
	}

	/**
	 * org.idempiere.postgresql.URLParameters allows to define additional URL parameters to be passed to
     *   the JDBC connection in PostgreSQL
	 * @return
	 */
	public static String getPostgresqlURLParameters() {
		return System.getProperty(org_idempiere_postgresql_URLParameters);
	}

	/**
	 * Define if optimistic locking must be used for UPDATE and DELETE in PO class, default false
	 * @return
	 */
	public static boolean isOptimisticLocking() {
		return "true".equalsIgnoreCase(System.getProperty(org_idempiere_po_useOptimisticLocking, "false"));
	}

	/**
	 * PostgreSQLNative allows to override the default to use the postgresql native dialect
	 * @return
	 */
	public static String getPostgreSQLNative() {
		return System.getProperty(PostgreSQLNative);
	}

	/**
	 * PropertyFile allows to define a PropertyFile to use instead of the default $HOME/idempiere.properties
	 * @return
	 */
	public static String getPropertyFile() {
		return System.getProperty(PropertyFile);
	}

	/**
	 * PropertyHomeFile allows to override the folder where the properties file is found
	 * @return
	 */
	public static String getPropertyHomeFile() {
		return System.getProperty(PropertyHomeFile);
	}

	/**
	 * TestOCI=Y defines if oracle config must test OCI, default to not test
	 * @return
	 */
	public static boolean isTestOCI() {
		return System.getProperty(TestOCI, "N").equals("Y");
	}

	/**
	 * ZK_THEME allows to define the theme to use, it overrides the SysConfig ZK_THEME so it can be used for testing purposes
	 * @return
	 */
	public static String getZkTheme() {
		return System.getProperty(ZK_THEME);
	}

	/**
	 * ZkUnitTest=true to define if the component ids must be generated using AdempiereIdGenerator.escapeId
	 * @return
	 */
	public static boolean isZkUnitTest() {
		return "true".equals(System.getProperty(ZkUnitTest));
	}

	/**
	 * TRACE_NULL_TRX_CONNECTION=true to allow tracing null transactions on idempiereMonitor
	 * WARNING! this setting can have a big performance impact, it is disabled by default
	 *   use it with care in production just temporarily to trace problematic connection slowness or leaks
	 * @return
	 */
	public static boolean isTraceNullTrxConnection() {
		return "true".equals(System.getProperty(TRACE_NULL_TRX_CONNECTION));
	}

	/**
	 * org_idempiere_FullExceptionTraceInLog=true to not cut trace log
	 * @return
	 */
	public static boolean isFullExceptionTraceInLog() {
		return "true".equals(System.getProperty(org_idempiere_FullExceptionTraceInLog));
	}
}
