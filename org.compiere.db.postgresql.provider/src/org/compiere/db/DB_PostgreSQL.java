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

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;

import javax.sql.ConnectionPoolDataSource;
import javax.sql.DataSource;
import javax.sql.RowSet;

import org.adempiere.db.postgresql.PostgreSQLBundleActivator;
import org.adempiere.exceptions.DBException;
import org.compiere.dbPort.Convert;
import org.compiere.dbPort.Convert_PostgreSQL;
import org.compiere.model.PO;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Ini;
import org.compiere.util.Trx;
import org.compiere.util.Util;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 *  PostgreSQL Database Port
 *
 *  @author      @author     Jorg Janke, Victor P�rez
 *  @version    $Id: DB_PostgreSQL.java,v 1.23 2005/03/11 20:29:01 jjanke Exp $
 *  ---
 *  Modifications: removed static references to database connection and instead always
 *  get a new connection from database pool manager which manages all connections
 *                 set rw/ro properties for the connection accordingly.
 *  @author Ashley Ramdass (Posterita)
 */
public class DB_PostgreSQL implements AdempiereDatabase
{

    public Convert getConvert() {
		return m_convert;
	}

	/**
	 *  PostgreSQL Database
	 */
	public DB_PostgreSQL()
	{
	}   //  DB_PostgreSQL

	/** Driver                  */
	private org.postgresql.Driver   s_driver = null;

    /** Driver class            */
    public static final String DRIVER = "org.postgresql.Driver";

	/** Default Port            */
	public static final int         DEFAULT_PORT = 5432;

	/** Data Source				*/
	private ComboPooledDataSource m_ds = null;

	/** Statement Converter     */
	private Convert_PostgreSQL         m_convert = new Convert_PostgreSQL();
	/** Connection String       */
	private String          m_connection;
	/** Cached Database Name	*/
	private String			m_dbName = null;

    @SuppressWarnings("unused")
	private String				m_userName = null;

    /** Connection String       	*/
	private String          		m_connectionURL;

	/**	Logger			*/
	private static CLogger			log	= CLogger.getCLogger (DB_PostgreSQL.class);

    private static int              m_maxbusyconnections = 0;

    public static final String NATIVE_MARKER = "NATIVE_"+Database.DB_POSTGRESQL+"_KEYWORK";

    private CCache<String, String> convertCache = new CCache<String, String>(null, "DB_PostgreSQL_Convert_Cache", 1000, 0, true);

    private Random rand = new Random();

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
			.append("?encoding=UNICODE");

		String urlParameters = System.getProperty("org.idempiere.postgresql.URLParameters");
	    if (!Util.isEmpty(urlParameters)) {
   			sb.append("&").append(urlParameters);  
	    }

		m_connection = sb.toString();
		return m_connection;
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
		StringBuffer sb = new StringBuffer("DB_PostgreSQL[");
        sb.append(m_connectionURL);
        try
        {
            StringBuffer logBuffer = new StringBuffer(50);
            logBuffer.append("# Connections: ").append(m_ds.getNumConnections());
            logBuffer.append(" , # Busy Connections: ").append(m_ds.getNumBusyConnections());
            logBuffer.append(" , # Idle Connections: ").append(m_ds.getNumIdleConnections());
            logBuffer.append(" , # Orphaned Connections: ").append(m_ds.getNumUnclosedOrphanedConnections());
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

        StringBuffer sb = new StringBuffer();
        try
        {
            sb.append("# Connections: ").append(m_ds.getNumConnections());
            sb.append(" , # Busy Connections: ").append(m_ds.getNumBusyConnections());
            sb.append(" , # Idle Connections: ").append(m_ds.getNumIdleConnections());
            sb.append(" , # Orphaned Connections: ").append(m_ds.getNumUnclosedOrphanedConnections());
            sb.append(" , # Active Transactions: ").append(Trx.getActiveTransactions().length);
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
		String cache = convertCache.get(oraStatement);
		if (cache != null) {
			Convert.logMigrationScript(oraStatement, cache);
			return cache;
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

		convertCache.put(oraStatement, retValue[0]);

		//  Diagnostics (show changed, but not if AD_Error
		if (log.isLoggable(Level.FINE))
		{
			if (!oraStatement.equals(retValue[0]) && retValue[0].indexOf("AD_Error") == -1)
			{
				//begin vpj-cd 24/06/2005 e-evolution
				log.log(Level.FINE, "PostgreSQL =>" + retValue[0] + "<= <" + oraStatement + ">");
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
		return "postgres";
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
	 *  @return TO_DATE('2001-01-30 18:10:20',''YYYY-MM-DD HH24:MI:SS')
	 *      or  TO_DATE('2001-01-30',''YYYY-MM-DD')
	 */
	public String TO_DATE (Timestamp time, boolean dayOnly)
	{
		if (time == null)
		{
			if (dayOnly)
				return "current_date()";
			return "current_date()";
		}

		StringBuffer dateString = new StringBuffer("TO_DATE('");
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
		StringBuffer retValue = new StringBuffer("CAST (");
		retValue.append(columnName);
		retValue.append(" AS Text)");

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
		return retValue.toString();
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
				result = number.setScale(scale, BigDecimal.ROUND_HALF_UP);
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
        Exception exception = null;
        try
        {
            if (m_ds == null)
                getDataSource(connection);

            //
            try
            {
            	int numConnections = m_ds.getNumBusyConnections();
        		if(numConnections >= m_maxbusyconnections && m_maxbusyconnections > 0)
        		{
        			//system is under heavy load, wait between 20 to 40 seconds
        			int randomNum = rand.nextInt(40 - 20 + 1) + 20;
        			Thread.sleep(randomNum * 1000);
        		}
        		conn = m_ds.getConnection();
        		if (conn == null) {
        			//try again after 10 to 30 seconds
        			int randomNum = rand.nextInt(30 - 10 + 1) + 10;
        			Thread.sleep(randomNum * 1000);
        			conn = m_ds.getConnection();
        		}

                if (conn != null)
                {
                    if (conn.getTransactionIsolation() != transactionIsolation)
                        conn.setTransactionIsolation(transactionIsolation);
                    if (conn.getAutoCommit() != autoCommit)
                        conn.setAutoCommit(autoCommit);
                }
            }
            catch (Exception e)
            {
                exception = e;
                conn = null;
            }

            if (conn == null && exception != null)
            {
            	//log might cause infinite loop since it will try to acquire database connection again
            	/*
                log.log(Level.SEVERE, exception.toString());
                log.fine(toString()); */
            	System.err.println(exception.toString());
            }
        }
        catch (Exception e)
        {
            exception = e;
        }

        try
        {
        	if (conn != null) {
        		boolean trace = "true".equalsIgnoreCase(System.getProperty("org.adempiere.db.traceStatus"));
        		int numConnections = m_ds.getNumBusyConnections();
        		if (numConnections > 1)
        		{
	    			if (trace)
	    			{
	    				log.warning(getStatus());
	    			}
	    			if(numConnections >= m_maxbusyconnections && m_maxbusyconnections > 0)
		            {
	    				if (!trace)
	    					log.warning(getStatus());
		                //hengsin: make a best effort to reclaim leak connection
		                Runtime.getRuntime().runFinalization();
		            }
        		}
        	} else {
        		//don't use log.severe here as it will try to access db again
        		System.err.println("Failed to acquire new connection. Status=" + getStatus());
        	}
        }
        catch (Exception ex)
        {
        }
        if (exception != null)
            throw exception;
        return conn;
	}	//	getCachedConnection


	/**
	 * 	Create DataSource (Client)
	 *	@param connection connection
	 *	@return data dource
	 */
	public DataSource getDataSource(CConnection connection)
	{
		if (m_ds != null)
			return m_ds;

		//try fragment contributed properties then default properties
		URL url = Ini.isClient()
    		? PostgreSQLBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/client.properties")
    		: PostgreSQLBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/server.properties");
    	if (url == null)
    	{
    		url = Ini.isClient()
    			? PostgreSQLBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/client.default.properties")
    			: PostgreSQLBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/server.default.properties");
    	}
		Properties poolProperties = new Properties();
		try {
			poolProperties.load(url.openStream());
		} catch (IOException e) {
			throw new DBException(e);
		}

		int idleConnectionTestPeriod = getIntProperty(poolProperties, "IdleConnectionTestPeriod", 1200);
		int acquireRetryAttempts = getIntProperty(poolProperties, "AcquireRetryAttempts", 2);
		int maxIdleTimeExcessConnections = getIntProperty(poolProperties, "MaxIdleTimeExcessConnections", 1200);
		int maxIdleTime = getIntProperty(poolProperties, "MaxIdleTime", 1200);
		int unreturnedConnectionTimeout = getIntProperty(poolProperties, "UnreturnedConnectionTimeout", 0);
		boolean testConnectionOnCheckin = getBooleanProperty(poolProperties, "TestConnectionOnCheckin", false);
		boolean testConnectionOnCheckout = getBooleanProperty(poolProperties, "TestConnectionOnCheckout", false);
		int checkoutTimeout = getIntProperty(poolProperties, "CheckoutTimeout", 0);

        try
        {
            System.setProperty("com.mchange.v2.log.MLog", "com.mchange.v2.log.FallbackMLog");
            //System.setProperty("com.mchange.v2.log.FallbackMLog.DEFAULT_CUTOFF_LEVEL", "ALL");
            ComboPooledDataSource cpds = new ComboPooledDataSource();
            cpds.setDataSourceName("AdempiereDS");
            cpds.setDriverClass(DRIVER);
            //loads the jdbc driver
            cpds.setJdbcUrl(getConnectionURL(connection));
            cpds.setUser(connection.getDbUid());
            cpds.setPassword(connection.getDbPwd());
            cpds.setPreferredTestQuery(DEFAULT_CONN_TEST_SQL);
            cpds.setIdleConnectionTestPeriod(idleConnectionTestPeriod);
            cpds.setMaxIdleTimeExcessConnections(maxIdleTimeExcessConnections);
            cpds.setMaxIdleTime(maxIdleTime);
            cpds.setTestConnectionOnCheckin(testConnectionOnCheckin);
            cpds.setTestConnectionOnCheckout(testConnectionOnCheckout);
            cpds.setAcquireRetryAttempts(acquireRetryAttempts);
            if (checkoutTimeout > 0)
            	cpds.setCheckoutTimeout(checkoutTimeout);

            if (Ini.isClient())
            {
            	int maxPoolSize = getIntProperty(poolProperties, "MaxPoolSize", 15);
            	int initialPoolSize = getIntProperty(poolProperties, "InitialPoolSize", 1);
            	int minPoolSize = getIntProperty(poolProperties, "MinPoolSize", 1);
                cpds.setInitialPoolSize(initialPoolSize);
                cpds.setMinPoolSize(minPoolSize);
                cpds.setMaxPoolSize(maxPoolSize);

                m_maxbusyconnections = (int) (maxPoolSize * 0.9);
            }
            else
            {
            	int maxPoolSize = getIntProperty(poolProperties, "MaxPoolSize", 400);
            	int initialPoolSize = getIntProperty(poolProperties, "InitialPoolSize", 10);
            	int minPoolSize = getIntProperty(poolProperties, "MinPoolSize", 5);
                cpds.setInitialPoolSize(initialPoolSize);
                cpds.setInitialPoolSize(initialPoolSize);
                cpds.setMinPoolSize(minPoolSize);
                cpds.setMaxPoolSize(maxPoolSize);
                m_maxbusyconnections = (int) (maxPoolSize * 0.9);
            }

            if (unreturnedConnectionTimeout > 0)
            {
	            //the following sometimes kill active connection!
	            cpds.setUnreturnedConnectionTimeout(1200);
	            cpds.setDebugUnreturnedConnectionStackTraces(true);
            }

            m_ds = cpds;
        }
        catch (Exception ex)
        {
            m_ds = null;
            log.log(Level.SEVERE, "Could not initialise C3P0 Datasource", ex);
        }

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


	/**
	 * 	Close
	 */
	public void close()
	{

		log.config(toString());

		if (m_ds != null)
		{
			try
			{
				m_ds.close();
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		m_ds = null;
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
		try {
			String sql = "select pg_class.relname,pg_locks.* from pg_class,pg_locks where pg_class.relfilenode=pg_locks.relation order by 1";
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
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
			try{
				if (stmt != null)
					stmt.close();
			} catch (Exception e) {}
		}
	}

	public int getNextID(String name) {

		int m_sequence_id = DB.getSQLValue(null, "SELECT nextval('"+name.toLowerCase()+"')");
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
	 * Implemented using the limit and offset feature. use 1 base index for start and end parameter
	 * @param sql
	 * @param start
	 * @param end
	 */
	public String addPagingSQL(String sql, int start, int end) {
		String newSql = sql + " " + NATIVE_MARKER + "LIMIT " + ( end - start + 1 )
			+ "  " + NATIVE_MARKER + "OFFSET " + (start - 1);
		return newSql;
	}

	public boolean isPagingSupported() {
		return true;
	}

	private int getIntProperty(Properties properties, String key, int defaultValue)
	{
		int i = defaultValue;
		try
		{
			String s = properties.getProperty(key);
			if (s != null && s.trim().length() > 0)
				i = Integer.parseInt(s);
		}
		catch (Exception e) {}
		return i;
	}

	private boolean getBooleanProperty(Properties properties, String key, boolean defaultValue)
	{
		boolean b = defaultValue;
		try
		{
			String s = properties.getProperty(key);
			if (s != null && s.trim().length() > 0)
				b = Boolean.valueOf(s);
		}
		catch (Exception e) {}
		return b;
	}

	@Override
	public int setStatementTimeout(Connection conn, int timeOut) throws SQLException {
		int currentTimeout = 0;		
		boolean autoCommit = conn.getAutoCommit();
		ResultSet rs = null;
		try
		{
			rs = conn.createStatement().executeQuery("select extract(epoch from current_setting('statement_timeout')::interval)*1000");
			if (rs.next()) {
				currentTimeout = rs.getInt(1) / 1000;
			}
		}
		finally
		{
			if (rs != null)
				rs.getStatement().close();
			DB.close(rs);
		}
		
		Statement timeoutStatement = conn.createStatement();
		String sql = "SET " + (autoCommit ? "SESSION" : "LOCAL") + " statement_timeout TO " + ( timeOut > 0 ? Integer.toString(timeOut * 1000) : " DEFAULT ");
		timeoutStatement.execute(sql);
		if (log.isLoggable(Level.FINEST))
		{
			log.finest("Set statement timeout to " + timeOut);
		}
		return currentTimeout;
	}
	
	@Override
	public boolean forUpdate(PO po, int timeout) {
    	//only can lock for update if using trx
    	if (po.get_TrxName() == null)
    		return false;
    	
    	String[] keyColumns = po.get_KeyColumns();
		if (keyColumns != null && keyColumns.length > 0 && !po.is_new()) {
			StringBuffer sqlBuffer = new StringBuffer(" SELECT ");
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
			int currentTimeout = -1;
			try {
				stmt = DB.prepareStatement(sqlBuffer.toString(),
					ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE, po.get_TrxName());
				for(int i = 0; i < keyColumns.length; i++) {
					stmt.setObject(i+1, parameters[i]);
				}
				currentTimeout = setStatementTimeout(stmt.getConnection(), (timeout > 0 ? timeout : LOCK_TIME_OUT));
				
				rs = stmt.executeQuery();
				if (rs.next()) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				log.log(Level.INFO, e.getLocalizedMessage(), e);
				throw new DBException("Could not lock record for " + po.toString() + " caused by " + e.getLocalizedMessage());
			} finally {
				try {
					setStatementTimeout(stmt.getConnection(), currentTimeout);
				} catch (SQLException e) {}
				DB.close(rs, stmt);
			}			
		}
		return false;
	}
}   //  DB_PostgreSQL
