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
 * Portions created by Victor Perez are Copyright (C) 1999-2005 e-Evolution,S.C
 * Contributor(s): Victor Perez                                               *
 *****************************************************************************/
package org.compiere.db;

import java.io.File;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.logging.Level;

import javax.sql.ConnectionPoolDataSource;
import javax.sql.DataSource;
import javax.sql.RowSet;

import org.adempiere.db.postgresql.PostgreSQLBundleActivator;
import org.adempiere.exceptions.DBException;
import org.compiere.dbPort.Convert;
import org.compiere.dbPort.Convert_PostgreSQL;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.compiere.util.Util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import com.zaxxer.hikari.HikariPoolMXBean;

/**
 *  PostgreSQL Database Port
 *
 *  @author      @author     Jorg Janke, Victor Perez
 *  @version    $Id: DB_PostgreSQL.java,v 1.23 2005/03/11 20:29:01 jjanke Exp $
 *  ---
 *  Modifications: removed static references to database connection and instead always
 *  get a new connection from database pool manager which manages all connections
 *                 set rw/ro properties for the connection accordingly.
 *  @author Ashley Ramdass (Posterita)
 */
public class DB_PostgreSQL implements AdempiereDatabase
{

    private static final String P_POSTGRE_SQL_NATIVE = "PostgreSQLNative";

	private static final String POOL_PROPERTIES = "hikaricp.properties";

	private static Boolean sysNative = null;
	
	static
	{
		String property = System.getProperty(P_POSTGRE_SQL_NATIVE);
		if (!Util.isEmpty(property, true) ) 
		{
			sysNative = "Y".equalsIgnoreCase(property);
		}
	}
	
	public Convert getConvert() {
		return m_convert;
	}

	/**
	 *  PostgreSQL Database
	 */
	public DB_PostgreSQL() {	
	}

	/** Driver                  */
	private org.postgresql.Driver   s_driver = null;

    /** Driver class            */
    public static final String DRIVER = "org.postgresql.Driver";

	/** Default Port            */
	public static final int         DEFAULT_PORT = 5432;

	/** Data Source				*/
	private volatile HikariDataSource m_ds;

	/** Statement Converter     */
	private Convert_PostgreSQL         m_convert = new Convert_PostgreSQL();
	/** Cached Database Name	*/
	private String			m_dbName = null;

    @SuppressWarnings("unused")
	private String				m_userName = null;

    /** Connection String       	*/
	private String          		m_connectionURL;

	/**	Logger			*/
	private static final CLogger			log	= CLogger.getCLogger (DB_PostgreSQL.class);

    private static final String NATIVE_MARKER = "NATIVE_"+Database.DB_POSTGRESQL+"_KEYWORK";

    private CCache<String, String> convertCache = new CCache<String, String>(null, "DB_PostgreSQL_Convert_Cache", 1000, CCache.DEFAULT_EXPIRE_MINUTE, false);

    private static final List<String> reservedKeywords = Arrays.asList("limit","action","old","new");
    
	/**
	 *  Get Database Name
	 *  @return database short name
	 */
	public String getName()
	{
		return Database.DB_POSTGRESQL;
	}   //  getName

	/**
	 *  Get Database Description
	 *  @return database long name and version
	 */
	public String getDescription()
	{       //begin vpj-cd e-evolution 30.09.2005
		//return s_driver.toString();
                try
		{
			if (s_driver == null)
				getDriver();
		}
		catch (Exception e)
		{
		}
		if (s_driver != null)
			return s_driver.toString();
		return "No Driver";
                //end vpj-cd e-evolution 30.09.2005
	}   //  getDescription

	/**
	 *  Get Standard JDBC Port
	 *  @return standard port
	 */
	public int getStandardPort()
	{
		return DEFAULT_PORT;
	}   //  getStandardPort

	/**
	 *  Get and register Database Driver
	 *  @return Driver
	 */
	public java.sql.Driver getDriver() throws SQLException
	{
		if (s_driver == null)
		{
			s_driver = new org.postgresql.Driver();
			DriverManager.registerDriver (s_driver);
			DriverManager.setLoginTimeout (Database.CONNECTION_TIMEOUT);
		}
		return s_driver;
	}   //  getDriver

	/**
	 *  Get Database Connection String.
	 *  Requirements:
	 *      - createdb -E UNICODE compiere
	 *  @param connection Connection Descriptor
	 *  @return connection String
	 */
	public String getConnectionURL (CConnection connection)
	{
		//  jdbc:postgresql://hostname:portnumber/databasename?encoding=UNICODE
		StringBuilder sb = new StringBuilder("jdbc:postgresql://")
			.append(connection.getDbHost())
			.append(":").append(connection.getDbPort())
			.append("/").append(connection.getDbName())
			.append("?encoding=UNICODE&ApplicationName=iDempiere");

		String urlParameters = System.getProperty("org.idempiere.postgresql.URLParameters");
	    if (!Util.isEmpty(urlParameters)) {
   			sb.append("&").append(urlParameters);  
	    }

		return sb.toString();
	}   //  getConnectionString

	/**
	 * 	Get Connection URL
	 *	@param dbHost db Host
	 *	@param dbPort db Port
	 *	@param dbName sb Name
	 *	@param userName user name
	 *	@return connection url
	 */
	public String getConnectionURL (String dbHost, int dbPort, String dbName,
		String userName)
	{
		StringBuilder sb = new StringBuilder("jdbc:postgresql://")
			.append(dbHost)
			.append(":").append(dbPort)
			.append("/").append(dbName);

		String urlParameters = System.getProperty("org.idempiere.postgresql.URLParameters") ;
	    if (!Util.isEmpty(urlParameters)) {
			sb.append("?").append(urlParameters);  
		}

		return sb.toString();
	}	//	getConnectionURL

	/**
	 *  Get Database Connection String
	 *  @param connectionURL Connection URL
	 *  @param userName user name
	 *  @return connection String
	 */
	public String getConnectionURL (String connectionURL, String userName)
	{
		m_userName = userName;
		m_connectionURL = connectionURL;
		return m_connectionURL;
	}	//	getConnectionURL

	/**
	 * 	Get JDBC Catalog
	 *	@return catalog (database name)
	 */
	public String getCatalog()
	{
		if (m_dbName != null)
			return m_dbName;
	//	log.severe("Database Name not set (yet) - call getConnectionURL first");
		return null;
	}	//	getCatalog

	/**
	 * 	Get JDBC Schema
	 *	@return schema (dbo)
	 */
	public String getSchema()
	{
		//begin vpj-cd e-evolution 03/04/2005
		return "adempiere";
		//end vpj-cd e-evolution 03/04/2005
	}	//	getSchema

	/**
	 *  Supports BLOB
	 *  @return true if BLOB is supported
	 */
	public boolean supportsBLOB()
	{
		return true;
	}   //  supportsBLOB

	/**
	 *  String Representation
	 *  @return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("DB_PostgreSQL[");
        sb.append(m_connectionURL);
        try
        {        	
            StringBuilder logBuffer = new StringBuilder();
            HikariPoolMXBean mxBean = m_ds.getHikariPoolMXBean();            
            
            logBuffer.append("# Connections: ").append(mxBean.getTotalConnections());
            logBuffer.append(" , # Busy Connections: ").append(mxBean.getActiveConnections());
            logBuffer.append(" , # Idle Connections: ").append(mxBean.getIdleConnections());
            logBuffer.append(" , # Threads waiting on connection: ").append(mxBean.getThreadsAwaitingConnection());
        }
        catch (Exception e)
        {
            sb.append("=").append(e.getLocalizedMessage());
        }
        sb.append("]");
        return sb.toString();
	}   //  toString

	/**
	 * 	Get Status
	 * 	@return status info
	 */
	public String getStatus()
	{
        if (m_ds == null)
        {
            return null;
        }

        StringBuilder sb = new StringBuilder();
        try
        {
            HikariPoolMXBean mxBean = m_ds.getHikariPoolMXBean();            
            
            sb.append("# Connections: ").append(mxBean.getTotalConnections());
            sb.append(" , # Busy Connections: ").append(mxBean.getActiveConnections());
            sb.append(" , # Idle Connections: ").append(mxBean.getIdleConnections());
            sb.append(" , # Threads waiting on connection: ").append(mxBean.getThreadsAwaitingConnection());        	        	
            sb.append(" , # Min Pool Size: ").append(m_ds.getMinimumIdle());
            sb.append(" , # Max Pool Size: ").append(m_ds.getMaximumPoolSize());
            sb.append(" , # Open Transactions: ").append(Trx.getOpenTransactions().length);
        }
        catch (Exception e)
        {}
        return sb.toString();
	}	//	getStatus

	/*************************************************************************
	 *  Convert an individual Oracle Style statements to target database statement syntax
	 *
	 *  @param oraStatement
	 *  @return converted Statement
	 *  @throws Exception
	 */
	public String convertStatement (String oraStatement)
	{
		if (!isNativeMode())
		{
			String cache = convertCache.get(oraStatement);
			if (cache != null) {
				Convert.logMigrationScript(oraStatement, cache);
				if ("true".equals(System.getProperty("org.idempiere.db.debug"))) {
					String filterPgDebug = System.getProperty("org.idempiere.db.debug.filter");
					boolean print = true;
					if (filterPgDebug != null)
						print = cache.matches(filterPgDebug);
					// log.warning("Oracle -> " + oraStatement);
					if (print)
						log.warning("Pgsql  -> " + cache);
				}
				return cache;
			}
		}

		String retValue[] = m_convert.convert(oraStatement);

        //begin vpj-cd e-evolution 03/14/2005
		if (retValue == null || retValue.length == 0 )
			return  oraStatement;
        //end vpj-cd e-evolution 03/14/2005

		if (retValue.length != 1)
			//begin vpj-cd 24/06/2005 e-evolution
			{
			log.log(Level.SEVERE, ("DB_PostgreSQL.convertStatement - Convert Command Number=" + retValue.length
				+ " (" + oraStatement + ") - " + m_convert.getConversionError()));
			throw new IllegalArgumentException
				("DB_PostgreSQL.convertStatement - Convert Command Number=" + retValue.length
					+ " (" + oraStatement + ") - " + m_convert.getConversionError());
			}
			//end vpj-cd 24/06/2005 e-evolution

		if (!isNativeMode())
			convertCache.put(oraStatement, retValue[0]);

		//  Diagnostics (show changed, but not if AD_Error
		if (log.isLoggable(Level.FINE))
		{
			if (!oraStatement.equals(retValue[0]) && retValue[0].indexOf("AD_Error") == -1)
			{
				//begin vpj-cd 24/06/2005 e-evolution
				if (log.isLoggable(Level.FINE))log.log(Level.FINE, "PostgreSQL =>" + retValue[0] + "<= <" + oraStatement + ">");
			}
		}
		    //end vpj-cd 24/06/2005 e-evolution
		//
		Convert.logMigrationScript(oraStatement, retValue[0]);
		return retValue[0];
	}   //  convertStatement


	/**
	 *  Get Name of System User
	 *  @return e.g. sa, system
	 */
	public String getSystemUser()
	{
    	String systemUser = System.getProperty("ADEMPIERE_DB_SYSTEM_USER");
    	if (systemUser == null)
    		systemUser = "postgres";
        return systemUser;
	}	//	getSystemUser

	/**
	 *  Get Name of System Database
	 *  @param databaseName database Name
	 *  @return e.g. master or database Name
	 */
	public String getSystemDatabase(String databaseName)
	{
		return "template1";
	}	//	getSystemDatabase


	/**
	 *  Create SQL TO Date String from Timestamp
	 *
	 *  @param  time Date to be converted
	 *  @param  dayOnly true if time set to 00:00:00
	 *
	 *  @return TO_TIMESTAMP('2001-01-30 18:10:20',''YYYY-MM-DD HH24:MI:SS')
	 *      or  TO_TIMESTAMP('2001-01-30',''YYYY-MM-DD')
	 */
	public String TO_DATE (Timestamp time, boolean dayOnly)
	{
		if (time == null)
		{
			if (dayOnly)
				return "current_date";
			return "current_timestamp";
		}

		StringBuilder dateString = new StringBuilder("TO_TIMESTAMP('");
		//  YYYY-MM-DD HH24:MI:SS.mmmm  JDBC Timestamp format
		String myDate = time.toString();
		if (dayOnly)
		{
			dateString.append(myDate.substring(0,10));
			dateString.append("','YYYY-MM-DD')");
		}
		else
		{
			dateString.append(myDate.substring(0, myDate.indexOf('.')));	//	cut off miliseconds
			dateString.append("','YYYY-MM-DD HH24:MI:SS')");
		}
		return dateString.toString();
	}   //  TO_DATE

	/**
	 *  Create SQL for formatted Date, Number
	 *
	 *  @param  columnName  the column name in the SQL
	 *  @param  displayType Display Type
	 *  @param  AD_Language 6 character language setting (from Env.LANG_*)
	 *
	 *  @return TRIM(TO_CHAR(columnName,'999G999G999G990D00','NLS_NUMERIC_CHARACTERS='',.'''))
	 *      or TRIM(TO_CHAR(columnName,'TM9')) depending on DisplayType and Language
	 *  @see org.compiere.util.DisplayType
	 *  @see org.compiere.util.Env
	 *
	 **/
	public String TO_CHAR (String columnName, int displayType, String AD_Language)
	{
		StringBuilder retValue = null;
		if (DisplayType.isDate(displayType)) {
			retValue = new StringBuilder("TO_CHAR(");
	        retValue.append(columnName)
	        	.append(",'")
            	.append(Language.getLanguage(AD_Language).getDBdatePattern())
            	.append("')");	        
		} else {
			retValue = new StringBuilder("CAST (");
			retValue.append(columnName);
			retValue.append(" AS Text)");
		}
		return retValue.toString();
		//  Numbers
		/*
		if (DisplayType.isNumeric(displayType))
		{
			if (displayType == DisplayType.Amount)
				retValue.append(" AS TEXT");
			else
				retValue.append(" AS TEXT");
			//if (!Language.isDecimalPoint(AD_Language))      //  reversed
			//retValue.append(",'NLS_NUMERIC_CHARACTERS='',.'''");
		}
		else if (DisplayType.isDate(displayType))
		{
			retValue.append(",'")
				.append(Language.getLanguage(AD_Language).getDBdatePattern())
				.append("'");
		}
		retValue.append(")");
		//*/		
	}   //  TO_CHAR

	/**
	 * 	Return number as string for INSERT statements with correct precision
	 *	@param number number
	 *	@param displayType display Type
	 *	@return number as string
	 */
	public String TO_NUMBER (BigDecimal number, int displayType)
	{
		if (number == null)
			return "NULL";
		BigDecimal result = number;
		int scale = DisplayType.getDefaultPrecision(displayType);
		if (scale > number.scale())
		{
			try
			{
				result = number.setScale(scale, RoundingMode.HALF_UP);
			}
			catch (Exception e)
			{
			//	log.severe("Number=" + number + ", Scale=" + " - " + e.getMessage());
			}
		}
		return result.toString();
	}	//	TO_NUMBER


	/**
	 * 	Get SQL Commands
	 *	@param cmdType CMD_*
	 *	@return array of commands to be executed
	 */
	public String[] getCommands (int cmdType)
	{
		if (CMD_CREATE_USER == cmdType)
			return new String[]
			{
			"CREATE USER adempiere;",
			};
		//
		if (CMD_CREATE_DATABASE == cmdType)
			return new String[]
			{
		    "CREATE DATABASE adempiere OWNER adempiere;",
			"GRANT ALL PRIVILEGES ON adempiere TO adempiere;"	,
			"CREATE SCHEMA adempiere;",
			"SET search_path TO adempiere;"
			};
		//
		if (CMD_DROP_DATABASE == cmdType)
			return new String[]
			{
			"DROP DATABASE adempiere;"
			};
		//
		return null;
	}	//	getCommands


	/**************************************************************************
	 *  Get RowSet
	 * 	@param rs ResultSet
	 *  @return RowSet
	 *  @throws SQLException
	 */
	public RowSet getRowSet (java.sql.ResultSet rs) throws SQLException
	{
		throw new UnsupportedOperationException("PostgreSQL does not support RowSets");
	}	//	getRowSet


	/**
	 * 	Get Cached Connection
	 *	@param connection connection
	 *	@param autoCommit auto commit
	 *	@param transactionIsolation trx isolation
	 *	@return Connection
	 *	@throws Exception
	 */
	public Connection getCachedConnection (CConnection connection,
			boolean autoCommit, int transactionIsolation)
					throws Exception
	{
		Connection conn = null;

		if (m_ds == null)
			getDataSource(connection);


		// If HikariCP has no available free connection this call will block until either
		// a connection becomes available or the configured 'connectionTimeout' value is
		// reached (after which a SQLException is thrown).
		conn = m_ds.getConnection();

		if (conn.getTransactionIsolation() != transactionIsolation)
		{
			conn.setTransactionIsolation(transactionIsolation);
		}
		if (conn.getAutoCommit() != autoCommit) 
		{
			conn.setAutoCommit(autoCommit);
		}

		return conn;
	}	//	getCachedConnection

	private String getPoolPropertiesFile ()
	{
		String base = Ini.getAdempiereHome();
		
		if (base != null && !base.endsWith(File.separator)) {
			base += File.separator;
		}
		
		//
		return base + getName() + File.separator + POOL_PROPERTIES;
	}	//	getFileName
		
	/**
	 * 	Create DataSource (Client)
	 *	@param connection connection
	 *	@return data dource
	 */
	public DataSource getDataSource(CConnection connection)
	{
		ensureInitialized(connection);
			
		return m_ds;
	}

	/**
	 * 	Create Pooled DataSource (Server)
	 *	@param connection connection
	 *	@return data source
	 */
	public ConnectionPoolDataSource createPoolDataSource(CConnection connection)
	{
		throw new UnsupportedOperationException("Not supported/implemented");
	}

	/**
	 * 	Get Connection from Driver
	 *	@param connection info
	 *	@return connection or null
	 */
	public Connection getDriverConnection (CConnection connection) throws SQLException
	{
		getDriver();
		return DriverManager.getConnection (getConnectionURL (connection),
			connection.getDbUid(), connection.getDbPwd());
	}	//	getDriverConnection

	/**
	 * 	Get Driver Connection
	 *	@param dbUrl URL
	 *	@param dbUid user
	 *	@param dbPwd password
	 *	@return connection
	 *	@throws SQLException
	 */
	public Connection getDriverConnection (String dbUrl, String dbUid, String dbPwd)
		throws SQLException
	{
		getDriver();
		return DriverManager.getConnection (dbUrl, dbUid, dbPwd);
	}	//	getDriverConnection
	
	private Properties getPoolProperties() {	
		//check property file from home
		File userPropertyFile = new File(getPoolPropertiesFile());
		URL propertyFileURL = null;
		
		if (userPropertyFile.exists() && userPropertyFile.canRead())
		{			
			try {
				propertyFileURL = userPropertyFile.toURI().toURL();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
		if (propertyFileURL == null)
		{
			propertyFileURL = PostgreSQLBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/server.default.properties");						
		}

		Properties poolProperties = new Properties();
		try (InputStream propertyFileInputStream = propertyFileURL.openStream()) {
			poolProperties.load(propertyFileInputStream);
		} catch (Exception e) {
			throw new DBException(e);
		} 

		//auto create property file at home folder from default config
		if (!userPropertyFile.exists())			
		{
			try {				
				Path directory = userPropertyFile.toPath().getParent();
				Files.createDirectories(directory);
								
				try (InputStream propertyFileInputStream = propertyFileURL.openStream()) {
					Files.copy(propertyFileInputStream, userPropertyFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
				} 
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return poolProperties;
	}
	
	/** Boolean to indicate the PostgreSQL connection pool is either initializing or initialized.*/
	private final AtomicBoolean initialized = new AtomicBoolean(false);
	/** Latch which can be used to wait for initialization completion. */
	private final CountDownLatch initializedLatch = new CountDownLatch(1); 
	
	/**
	 * Allows the connection pool to be lazily initialized. While it might be preferable to do
	 * this once upon initialization of this class the current design of iDempiere makes this 
	 * hard.
	 * 
	 * Calling this method will block until the pool is configured. This does NOT mean it will
	 * block until a database connection has been setup.
	 * 
	 * @param connection
	 */
	private void ensureInitialized(CConnection connection) {
		if (!initialized.compareAndSet(false, true)) {
			try {
				initializedLatch.await();
			} catch (InterruptedException e) {
				return;
			}
		}
				
        try {
    		Properties poolProperties = getPoolProperties();
    		// Do not override values which might have been read from the users
    		// hikaricp.properties file.
    		if(!poolProperties.containsKey("jdbcUrl")) {
    			poolProperties.put("jdbcUrl", getConnectionURL(connection));
    		}
    		if (!poolProperties.containsKey("username")) {
    			poolProperties.put("username", connection.getDbUid());
    		}
    		if (!poolProperties.containsKey("password")) {
    			poolProperties.put("password", connection.getDbPwd());
    		}

    		HikariConfig hikariConfig = new HikariConfig(poolProperties);
    		hikariConfig.setDriverClassName(DRIVER);
    		m_ds = new HikariDataSource(hikariConfig);

            m_connectionURL = m_ds.getJdbcUrl();
            
            initializedLatch.countDown();
        }
        catch (Exception ex) {
        	throw new IllegalStateException("Could not initialise Hikari Datasource", ex);
        }		
	}
	
	/**
	 * 	Close
	 */
	public void close()
	{
		if (log.isLoggable(Level.CONFIG)) 
		{ 
			log.config(toString());
		}

		try
		{
			m_ds.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}	//	close


	/**
	 *  Check and generate an alternative SQL
	 *  @reExNo number of re-execution
	 *  @msg previous execution error message
	 *  @sql previous executed SQL
	 *  @return String, the alternative SQL, null if no alternative
	 */
	public String getAlternativeSQL(int reExNo, String msg, String sql)
	{
		return null; //do not do re-execution of alternative SQL
	}

        	/**
	 *  Get constraint type associated with the index
	 *  @tableName table name
	 *  @IXName Index name
	 *  @return String[0] = 0: do not know, 1: Primary Key  2: Foreign Key
	 *  		String[1] - String[n] = Constraint Name
	 */
	public String getConstraintType(Connection conn, String tableName, String IXName)
	{
		if (IXName == null || IXName.length()==0)
			return "0";
		if (IXName.toUpperCase().endsWith("_KEY"))
			return "1"+IXName;
		else
			return "0";
		//jz temp, modify later from user.constraints
	}

    /**
	 *  Check if DBMS support the sql statement
	 *  @sql SQL statement
	 *  @return true: yes
	 */
	public boolean isSupported(String sql)
	{
		return true;
		//jz temp, modify later
	}

	/**
	 * Dump table lock info to console for current transaction
	 * @param conn
	 */
	public static void dumpLocks(Connection conn)
	{
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select pg_class.relname,pg_locks.* from pg_class,pg_locks where pg_class.relfilenode=pg_locks.relation order by 1";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			int cnt = rs.getMetaData().getColumnCount();
			System.out.println();
			while (rs.next())
			{
				for(int i = 0; i < cnt; i++)
				{
					Object value = rs.getObject(i+1);
					if (i > 0)
						System.out.print(", ");
					System.out.print(value != null ? value.toString() : "");
				}
				System.out.println();
			}
			System.out.println();
		} catch (Exception e) {

		} finally {
			DB.close(rs,stmt);
			rs = null;stmt = null;
		}
	}

	public int getNextID(String name) {
		return getNextID(name, null);
	}

	public int getNextID(String name, String trxName) {
		int m_sequence_id = DB.getSQLValueEx(trxName, "SELECT nextval('"+name.toLowerCase()+"')");
		return m_sequence_id;
	}

	public boolean createSequence(String name , int increment , int minvalue , int maxvalue ,int  start, String trxName)
	{
		// Check if Sequence exists
		final int cnt = DB.getSQLValueEx(trxName, "SELECT COUNT(*) FROM pg_class WHERE UPPER(relname)=? AND relkind='S'", name.toUpperCase());
		final int no;
		if (start < minvalue)
			start = minvalue;
		//
		// New Sequence
		if (cnt == 0)
		{
			no = DB.executeUpdate("CREATE SEQUENCE "+name.toUpperCase()
								+ " INCREMENT BY " + increment
								+ " MINVALUE " + minvalue
								+ " MAXVALUE " + maxvalue
								+ " START WITH " + start, trxName);
		}
		//
		// Already existing sequence => ALTER
		else
		{
			no = DB.executeUpdate("ALTER SEQUENCE "+name.toUpperCase()
					+ " INCREMENT BY " + increment
					+ " MINVALUE " + minvalue
					+ " MAXVALUE " + maxvalue
					+ " RESTART WITH " + start, trxName);
		}
		if(no == -1 )
			return false;
		else
			return true;
	}

	/**
	 * Postgresql jdbc driver doesn't support setQueryTimeout, query/statement timeout is
	 * implemented using the "SET LOCAL statement_timeout TO" statement.
	 * @return true
	 */
	public boolean isQueryTimeoutSupported() {
		return true;
	}

	/**
	 * Implemented using the fetch first and offset feature. use 1 base index for start and end parameter
	 * @param sql
	 * @param start
	 * @param end
	 */
	public String addPagingSQL(String sql, int start, int end) {
		StringBuilder newSql = new StringBuilder(sql);
		if (start > 1) {
			newSql.append(" OFFSET ")
				.append((start - 1))
				.append( " ROWS");
		}
		if (end > 0) {
			newSql.append(" FETCH FIRST ")
				.append(( end - start + 1 ))
				.append(" ROWS ONLY");
		}
		return newSql.toString();
	}

	public boolean isPagingSupported() {
		return true;
	}

	@Override
	public boolean forUpdate(PO po, int timeout) {
    	//only can lock for update if using trx
    	if (po.get_TrxName() == null)
    		return false;
    	
    	String[] keyColumns = po.get_KeyColumns();
		if (keyColumns != null && keyColumns.length > 0 && !po.is_new()) {
			StringBuilder sqlBuffer = new StringBuilder(" SELECT ");
			sqlBuffer.append(keyColumns[0])
				.append(" FROM ")
				.append(po.get_TableName())
				.append(" WHERE ");
			for(int i = 0; i < keyColumns.length; i++) {
				if (i > 0)
					sqlBuffer.append(" AND ");
				sqlBuffer.append(keyColumns[i]).append("=?");
			}
			sqlBuffer.append(" FOR UPDATE ");

			Object[] parameters = new Object[keyColumns.length];
			for(int i = 0; i < keyColumns.length; i++) {
				Object parameter = po.get_Value(keyColumns[i]);
				if (parameter != null && parameter instanceof Boolean) {
					if ((Boolean) parameter)
						parameter = "Y";
					else
						parameter = "N";
				}
				parameters[i] = parameter;
			}

			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = DB.prepareStatement(sqlBuffer.toString(),
					ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE, po.get_TrxName());
				for(int i = 0; i < keyColumns.length; i++) {
					stmt.setObject(i+1, parameters[i]);
				}
				stmt.setQueryTimeout(timeout > 0 ? timeout : LOCK_TIME_OUT);
				
				rs = stmt.executeQuery();
				if (rs.next()) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				if (log.isLoggable(Level.INFO))log.log(Level.INFO, e.getLocalizedMessage(), e);
				throw new DBException("Could not lock record for " + po.toString() + " caused by " + e.getLocalizedMessage());
			} finally {
				DB.close(rs, stmt);
				rs = null;stmt = null;
			}			
		}
		return false;
	}
	
	@Override
	public String getNameOfUniqueConstraintError(Exception e) {
		String info = e.getMessage();
		int fromIndex = info.indexOf("\"");
		if (fromIndex == -1)
			fromIndex = info.indexOf("\u00ab"); // quote for spanish postgresql message
		if (fromIndex == -1)
			return info;
		int toIndex = info.indexOf("\"", fromIndex + 1);
		if (toIndex == -1)
			toIndex = info.indexOf("\u00bb", fromIndex + 1);
		if (toIndex == -1)
			return info;
		return info.substring(fromIndex + 1, toIndex);
	}

	@Override
	public String subsetClauseForCSV(String columnName, String csv) {
		StringBuilder builder = new StringBuilder();
		builder.append("string_to_array(")
			.append(columnName)
			.append(",',')");
		builder.append(" <@ "); //is contained by
		builder.append("string_to_array(")
			.append(DB.TO_STRING(csv))
			.append(",',')");

		return builder.toString();
	}

	@Override
	public String quoteColumnName(String columnName) {
		if (!isNativeMode()) {
			return columnName;
		}
		
		String lowerCase = columnName.toLowerCase();
		if (reservedKeywords.contains(lowerCase)) {
			StringBuilder sql = new StringBuilder("\"");
			sql.append(lowerCase).append("\"");
			return sql.toString();
		} else {
			return columnName;
		}
	}

	@Override
	public String intersectClauseForCSV(String columnName, String csv) {
		StringBuilder builder = new StringBuilder();
		builder.append("string_to_array(")
			.append(columnName)
			.append(",',')");
		builder.append(" && "); //intersect
		builder.append("string_to_array(")
			.append(DB.TO_STRING(csv))
			.append(",',')");

		return builder.toString();
	}
	
	@Override
	public boolean isNativeMode() {
		return isUseNativeDialect();
	}
	
	/**
	 * @return true if it is using native dialect
	 */
	public final static boolean isUseNativeDialect() {
		if (Convert.isLogMigrationScript())
			return false;
		else if (sysNative != null)
			return sysNative;
		else if (!Util.isEmpty(Ini.getProperty(P_POSTGRE_SQL_NATIVE), true))
			return Ini.isPropertyBool(P_POSTGRE_SQL_NATIVE);
		else
			return true;
	}
	
	/**
	 * 
	 * @param keyword
	 * @return if not using native dialect, return native_marker + keyword
	 */
	public final static String markNativeKeyword(String keyword) {
		if (isUseNativeDialect())
			return keyword;
		else
			return NATIVE_MARKER + keyword;
	}
	
	/**
	 * 
	 * @param statement
	 * @return statement after the removal of native keyword marker
	 */
	public final static String removeNativeKeyworkMarker(String statement) {
		return statement.replace(DB_PostgreSQL.NATIVE_MARKER, "");
	}

	
	@Override
	public String getNumericDataType() {
		return "NUMERIC";
	}

	@Override
	public String getCharacterDataType() {
		return "CHAR";
	}

	@Override
	public String getVarcharDataType() {
		return "VARCHAR";
	}

	@Override
	public String getBlobDataType() {
		return "BYTEA";
	}

	@Override
	public String getClobDataType() {
		return "TEXT";
	}

	@Override
	public String getTimestampDataType() {
		return "TIMESTAMP";
	}

	@Override
	public String getTimestampWithTimezoneDataType() {
		return "TIMESTAMP WITH TIME ZONE";
	}
	
	@Override
	public String getSQLDDL(MColumn column) {				
		StringBuilder sql = new StringBuilder ().append(column.getColumnName())
			.append(" ").append(column.getSQLDataType());

		//	Null
		if (column.isMandatory())
			sql.append(" NOT NULL");
			
		//	Inline Constraint
		if (column.getAD_Reference_ID() == DisplayType.YesNo)
			sql.append(" CHECK (").append(column.getColumnName()).append(" IN ('Y','N'))");

		//	Default
		String defaultValue = column.getDefaultValue();
		if (defaultValue != null 
				&& defaultValue.length() > 0
				&& defaultValue.indexOf('@') == -1		//	no variables
				&& ( ! (DisplayType.isID(column.getAD_Reference_ID()) && defaultValue.equals("-1") ) ) )  // not for ID's with default -1
		{
			if (DisplayType.isText(column.getAD_Reference_ID()) 
					|| DisplayType.isList(column.getAD_Reference_ID())
					|| column.getAD_Reference_ID() == DisplayType.YesNo
					// Two special columns: Defined as Table but DB Type is String 
					|| column.getColumnName().equals("EntityType") || column.getColumnName().equals("AD_Language")
					|| (column.getAD_Reference_ID() == DisplayType.Button &&
							!(column.getColumnName().endsWith("_ID"))))
			{
				if (!defaultValue.startsWith("'") && !defaultValue.endsWith("'"))
					defaultValue = DB.TO_STRING(defaultValue);
			}
			if (defaultValue.equalsIgnoreCase("sysdate"))
				defaultValue = "getDate()";
			sql.append(" DEFAULT ").append(defaultValue);
		}
		else
		{
			if (! column.isMandatory())
				sql.append(" DEFAULT NULL ");
			defaultValue = null;
		}
		
		return sql.toString();
	
	}
	
	/**
	 * 	Get SQL Add command
	 *	@param table table
	 *	@return sql
	 */
	@Override
	public String getSQLAdd (MTable table, MColumn column)
	{
		StringBuilder sql = new StringBuilder ("ALTER TABLE ")
			.append(table.getTableName())
			.append(" ADD COLUMN ").append(column.getSQLDDL());
		String constraint = column.getConstraint(table.getTableName());
		if (constraint != null && constraint.length() > 0) {
			sql.append(DB.SQLSTATEMENT_SEPARATOR).append("ALTER TABLE ")
			.append(table.getTableName())
			.append(" ADD ").append(constraint);
		}
		return sql.toString();
	}	//	getSQLAdd
	
	/**
	 * 	Get SQL Modify command
	 *	@param table table
	 *	@param setNullOption generate null / not null statement
	 *	@return sql separated by ;
	 */
	public String getSQLModify (MTable table, MColumn column, boolean setNullOption)
	{
		StringBuilder sql = new StringBuilder ("INSERT INTO t_alter_column values('")
			.append(table.getTableName())
			.append("','").append(quoteColumnName(column.getColumnName()))
			.append("','")
			.append(column.getSQLDataType())
			.append("',");
		
		//	Null
		if (setNullOption)
		{
			if (column.isMandatory())
				sql.append("'NOT NULL',");
			else
				sql.append("'NULL',");
		}
		else
		{
			sql.append("null,");
		}
			
		//	Default
		String defaultValue = column.getDefaultValue();
		String originalDefaultValue = defaultValue;
		if (defaultValue != null 
			&& defaultValue.length() > 0
			&& defaultValue.indexOf('@') == -1		//	no variables
			&& ( ! (DisplayType.isID(column.getAD_Reference_ID()) && defaultValue.equals("-1") ) ) )  // not for ID's with default -1
		{
			if (defaultValue.equalsIgnoreCase("sysdate"))
				defaultValue = "getDate()";
			if (!defaultValue.startsWith("'") && !defaultValue.endsWith("'"))
				defaultValue = DB.TO_STRING(defaultValue);
			sql.append(defaultValue);
		}
		else
		{
			sql.append("null");
			defaultValue = null;
		}
		sql.append(")");
		
		
		//	Null Values
		if (column.isMandatory() && defaultValue != null && defaultValue.length() > 0)
		{
			if (!(DisplayType.isText(column.getAD_Reference_ID()) 
					|| DisplayType.isList(column.getAD_Reference_ID())
					|| column.getAD_Reference_ID() == DisplayType.YesNo
					|| column.getAD_Reference_ID() == DisplayType.Payment
					// Two special columns: Defined as Table but DB Type is String 
					|| column.getColumnName().equals("EntityType") || column.getColumnName().equals("AD_Language")
					|| (column.getAD_Reference_ID() == DisplayType.Button &&
							!(column.getColumnName().endsWith("_ID")))))
			{
				defaultValue = originalDefaultValue;
				if (defaultValue.equalsIgnoreCase("sysdate"))
					defaultValue = "getDate()";
			}
			StringBuilder sqlSet = new StringBuilder("UPDATE ")
				.append(table.getTableName())
				.append(" SET ").append(quoteColumnName(column.getColumnName()))
				.append("=").append(defaultValue)
				.append(" WHERE ").append(quoteColumnName(column.getColumnName())).append(" IS NULL");
			sql.append(DB.SQLSTATEMENT_SEPARATOR).append(sqlSet);
		}
		
		
		//
		return sql.toString();
	}	//	getSQLModify

	@Override
	public boolean isQueryTimeout(SQLException ex) {
		//org.postgresql.util.PSQLException: ERROR: canceling statement due to user request | SQL Code: 0 | SQL State: 57014
		return "57014".equals(ex.getSQLState());
	}

	
}   //  DB_PostgreSQL
