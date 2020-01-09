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
package org.compiere.db;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;

import javax.sql.DataSource;

import org.adempiere.db.oracle.OracleBundleActivator;
import org.adempiere.exceptions.DBException;
import org.compiere.Adempiere;
import org.compiere.dbPort.Convert;
import org.compiere.dbPort.Convert_Oracle;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.compiere.util.Util;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import oracle.jdbc.OracleDriver;

/**
 *  Oracle Database Port
 *
 *  @author     Jorg Janke
 *  @version    $Id: DB_Oracle.java,v 1.7 2006/09/22 23:35:19 jjanke Exp $
 *  ---
 *  Modifications: Refactoring. Replaced Oracle Cache Manager with C3P0
 *  connection pooling framework for better and more efficient connnection handling
 *
 *  @author Ashley Ramdass (Posterita)
 */
public class DB_Oracle implements AdempiereDatabase
{

	private static final String POOL_PROPERTIES = "pool.properties";
	
    /**
     *  Oracle Database
     */
    public DB_Oracle()
    {
        /** Causes VPN problems ???
        try
        {
            getDriver();
        }
        catch (Exception e)
        {
            log.log(Level.SEVERE, e.getMessage());
        }
        **/
        // teo [ bug 1638208 ]: oracle 10g DATETIME issue
        // http://www.oracle.com/technology/tech/java/sqlj_jdbc/htdocs/jdbc_faq.htm#08_01
        try
        {
            System.setProperty("oracle.jdbc.V8Compatible", "true");
        }
        catch (Exception e)
        {
            log.log(Level.SEVERE, e.getMessage());
        }
    }   //  DB_Oracle

    /** Static Driver               */
    private static OracleDriver     s_driver = null;
    /** Driver Class Name           */
    public static final String      DRIVER = "oracle.jdbc.OracleDriver";

    /** Default Port                */
    public static final int         DEFAULT_PORT = 1521;
    /** Default Connection Manager Port */
    public static final int         DEFAULT_CM_PORT = 1630;

    /** Connection String           */
    private String                  m_connectionURL;

    /** Data Source                 */
    private ComboPooledDataSource   m_ds = null;

    /** Cached User Name            */
    private String                  m_userName = null;

    private Convert m_convert = new Convert_Oracle();

    /** Logger          */
    private static final CLogger          log = CLogger.getCLogger (DB_Oracle.class);


    private static int              m_maxbusyconnections = 0;

    private Random rand = new Random();

    /**
     *  Get Database Name
     *  @return database short name
     */
    public String getName()
    {
        return Database.DB_ORACLE;
    }   //  getName

    /**
     *  Get Database Description
     *  @return database long name and version
     */
    public String getDescription()
    {
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
     *  @throws SQLException
     */
    public synchronized Driver getDriver() throws SQLException
    {
        if (s_driver == null)
        {
            //  Speed up transfer rate
            System.setProperty("oracle.jdbc.TcpNoDelay", "true");
            //  Oracle Multi - Language
            System.setProperty("oracle.jdbc.defaultNChar", "true");
            //
            s_driver = new OracleDriver();
            DriverManager.registerDriver (s_driver);
            DriverManager.setLoginTimeout (Database.CONNECTION_TIMEOUT);
        }
        return s_driver;
    }   //  getDriver

    /**
     *  Get Database Connection String.
     *  <pre>
     *  Timing:
     *  - CM with source_route not in address_list  = 28.5 sec
     *  - CM with source_route in address_list      = 58.0 sec
     *  - direct    = 4.3-8 sec  (no real difference if on other box)
     *  - bequeath  = 3.4-8 sec
     *  </pre>
     *  @param connection Connection Descriptor
     *  @return connection String
     */
    public String getConnectionURL (CConnection connection)
    {
        StringBuilder sb = null;
        //  Server Connections (bequeath)
        if (connection.isBequeath())
        {
            sb = new StringBuilder("jdbc:oracle:oci8:@");
            //  bug: does not work if there is more than one db instance - use Net8
        //  sb.append(connection.getDbName());
        }
        else        //  thin driver
        {
            sb = new StringBuilder("jdbc:oracle:thin:@");
            //  direct connection
            if (connection.isViaFirewall())
            {
                //  (description=(address_list=
                //  ( (source_route=yes)
                //    (address=(protocol=TCP)(host=cmhost)(port=1630))
                //    (address=(protocol=TCP)(host=dev)(port=1521))
                //  (connect_data=(service_name=dev1.adempiere.org)))
                sb.append("(DESCRIPTION=(ADDRESS_LIST=")
                    .append("(SOURCE_ROUTE=YES)")
                    .append("(ADDRESS=(PROTOCOL=TCP)(HOST=").append(connection.getFwHost())
                        .append(")(PORT=").append(connection.getFwPort()).append("))")
                    .append("(ADDRESS=(PROTOCOL=TCP)(HOST=").append(connection.getDbHost())
                        .append(")(PORT=").append(connection.getDbPort()).append(")))")
                    .append("(CONNECT_DATA=(SERVICE_NAME=").append(connection.getDbName()).append(")))");
            }
            else
            {
                //  old: jdbc:oracle:thin:@dev2:1521:sid
                //  new: jdbc:oracle:thin:@//dev2:1521/serviceName
                sb.append("//")
                    .append(connection.getDbHost())
                    .append(":").append(connection.getDbPort())
                    .append("/").append(connection.getDbName());
            }
        }
        m_connectionURL = sb.toString();
    //  log.config(m_connectionURL);
        //
        m_userName = connection.getDbUid();
        return m_connectionURL;
    }   //  getConnectionURL

    /**
     *  Get Connection URL.
     *  http://download-east.oracle.com/docs/cd/B14117_01/java.101/b10979/urls.htm#BEIDBFDF
     *  @param dbHost db Host
     *  @param dbPort db Port
     *  @param dbName db Name
     *  @param userName user name
     *  @return connection
     */
    public String getConnectionURL (String dbHost, int dbPort, String dbName,
        String userName)
    {
        m_userName = userName;
        m_connectionURL = "jdbc:oracle:thin:@//"
            + dbHost + ":" + dbPort + "/" + dbName;
        return m_connectionURL;
    }   //  getConnectionURL

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
    }   //  getConnectionURL

    /**
     *  Get JDBC Catalog
     *  @return null - not used
     */
    public String getCatalog()
    {
        return null;
    }   //  getCatalog

    /**
     *  Get JDBC Schema
     *  @return user name
     */
    public String getSchema()
    {
        if (m_userName != null)
            return m_userName.toUpperCase();
        log.severe("User Name not set (yet) - call getConnectionURL first");
        return null;
    }   //  getSchema

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
        StringBuilder sb = new StringBuilder("DB_Oracle[");
        sb.append(m_connectionURL);
        try
        {
            StringBuilder logBuffer = new StringBuilder(50);
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

        StringBuilder sb = new StringBuilder();
        try
        {
            sb.append("# Connections: ").append(m_ds.getNumConnections());
            sb.append(" , # Busy Connections: ").append(m_ds.getNumBusyConnections());
            sb.append(" , # Idle Connections: ").append(m_ds.getNumIdleConnections());
            sb.append(" , # Orphaned Connections: ").append(m_ds.getNumUnclosedOrphanedConnections());
            sb.append(" , # Min Pool Size: ").append(m_ds.getMinPoolSize());
            sb.append(" , # Max Pool Size: ").append(m_ds.getMaxPoolSize());
            sb.append(" , # Max Statements Cache Per Session: ").append(m_ds.getMaxStatementsPerConnection());
            sb.append(" , # Active Transactions: ").append(Trx.getActiveTransactions().length);
        }
        catch (Exception e)
        {}
        return sb.toString();
	}	//	getStatus


    /**************************************************************************
     *  Convert an individual Oracle Style statements to target database statement syntax.
     *  @param oraStatement oracle statement
     *  @return converted Statement oracle statement
     */
    public String convertStatement (String oraStatement)
    {
    	Convert.logMigrationScript(oraStatement, null);
		if ("true".equals(System.getProperty("org.idempiere.db.oracle.debug"))) {
			log.warning("Oracle -> " + oraStatement);
		}
        return oraStatement;
    }   //  convertStatement



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
     *  Get constraint type associated with the index
     *  @tableName table name
     *  @IXName Index name
     *  @return String[0] = 0: do not know, 1: Primary Key  2: Foreign Key
     *          String[1] - String[n] = Constraint Name
     */
    public String getConstraintType(Connection conn, String tableName, String IXName)
    {
        if (IXName == null || IXName.length()==0)
            return "0";
        if (IXName.endsWith("_KEY"))
            return "1"+IXName;
        else
            return "0";
        //jz temp, modify later from user.constraints
    }

    /**
     *  Get Name of System User
     *  @return system
     */
    public String getSystemUser()
    {
    	String systemUser = System.getProperty("ADEMPIERE_DB_SYSTEM_USER");
    	if (systemUser == null)
    		systemUser = "system";
        return systemUser;
    }   //  getSystemUser

    /**
     *  Get Name of System Database
     *  @param databaseName database Name
     *  @return e.g. master or database Name
     */
    public String getSystemDatabase(String databaseName)
    {
        return databaseName;
    }   //  getSystemDatabase


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
                return "TRUNC(SysDate)";
            return "SysDate";
        }

        StringBuilder dateString = new StringBuilder("TO_DATE('");
        //  YYYY-MM-DD HH24:MI:SS.mmmm  JDBC Timestamp format
        String myDate = time.toString();
        if (dayOnly)
        {
            dateString.append(myDate.substring(0,10));
            dateString.append("','YYYY-MM-DD')");
        }
        else
        {
            dateString.append(myDate.substring(0, myDate.indexOf('.')));    //  cut off miliseconds
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
     *   */
    public String TO_CHAR (String columnName, int displayType, String AD_Language)
    {
        StringBuilder retValue = new StringBuilder("TRIM(TO_CHAR(");
        retValue.append(columnName);

        //  Numbers
        if (DisplayType.isNumeric(displayType))
        {
            if (displayType == DisplayType.Amount)
                retValue.append(",'999G999G999G990D00'");
            else
                retValue.append(",'TM9'");
            //  TO_CHAR(GrandTotal,'999G999G999G990D00','NLS_NUMERIC_CHARACTERS='',.''')
            if (!Language.isDecimalPoint(AD_Language))      //  reversed
                retValue.append(",'NLS_NUMERIC_CHARACTERS='',.'''");
        }
        else if (DisplayType.isDate(displayType))
        {
            retValue.append(",'")
                .append(Language.getLanguage(AD_Language).getDBdatePattern())
                .append("'");
        }
        retValue.append("))");
        //
        return retValue.toString();
    }   //  TO_CHAR

    /**
     *  Return number as string for INSERT statements with correct precision
     *  @param number number
     *  @param displayType display Type
     *  @return number as string
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
            //  log.severe("Number=" + number + ", Scale=" + " - " + e.getMessage());
            }
        }
        return result.toString();
    }   //  TO_NUMBER


    /**
     *  Get SQL Commands.
     *  The following variables are resolved:
     *  @SystemPassword@, @AdempiereUser@, @AdempierePassword@
     *  @SystemPassword@, @DatabaseName@, @DatabaseDevice@
     *  @param cmdType CMD_*
     *  @return array of commands to be executed
     */
    public String[] getCommands (int cmdType)
    {
        if (CMD_CREATE_USER == cmdType)
            return new String[]
            {

            };
        //
        if (CMD_CREATE_DATABASE == cmdType)
            return new String[]
            {

            };
        //
        if (CMD_DROP_DATABASE == cmdType)
            return new String[]
            {

            };
        //
        return null;
    }   //  getCommands

    private String getFileName ()
	{
		//
		String base = null;
		if (Ini.isClient())
			base = System.getProperty("user.home");
		else
			base = Ini.getAdempiereHome();
		
		if (base != null && !base.endsWith(File.separator))
			base += File.separator;
		
		//
		return base + getName() + File.separator + POOL_PROPERTIES;
	}	//	getFileName
    
    /**
     *  Create DataSource
     *  @param connection connection
     *  @return data dource
     */
    public DataSource getDataSource(CConnection connection)
    {
        if (m_ds != null)
            return m_ds;

        InputStream inputStream = null;
		
		//check property file from home
		String propertyFilename = getFileName();
		File propertyFile = null;
		if (!Util.isEmpty(propertyFilename))
		{
			propertyFile = new File(propertyFilename);
			if (propertyFile.exists() && propertyFile.canRead())
			{
				try {
					inputStream = new FileInputStream(propertyFile);
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}
			}
		}
		
		URL url = null;
		if (inputStream == null)
		{
			propertyFile = null;
        	url = Ini.isClient()
        		? OracleBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/client.default.properties")
        		: OracleBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/server.default.properties");
        		
			try {
				inputStream = url.openStream();
			} catch (IOException e) {
				throw new DBException(e);
			}
        }
		
		Properties poolProperties = new Properties();
		try {
			poolProperties.load(inputStream);
			inputStream.close();
			inputStream = null;
		} catch (IOException e) {
			throw new DBException(e);
		}

		//auto create property file at home folder from default config
		if (propertyFile == null)			
		{
			String directoryName = propertyFilename.substring(0,  propertyFilename.length() - (POOL_PROPERTIES.length()+1));
			File dir = new File(directoryName);
			if (!dir.exists())
				dir.mkdir();
			propertyFile = new File(propertyFilename);
			try {
				inputStream = url.openStream();
				Files.copy(inputStream, propertyFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
				inputStream.close();
				inputStream = null;
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		if (inputStream != null)
		{
			try {
				inputStream.close();
			} catch (IOException e) {}
		}
				
		int idleConnectionTestPeriod = getIntProperty(poolProperties, "IdleConnectionTestPeriod", 1200);
		int acquireRetryAttempts = getIntProperty(poolProperties, "AcquireRetryAttempts", 2);
		int maxIdleTimeExcessConnections = getIntProperty(poolProperties, "MaxIdleTimeExcessConnections", 1200);
		int maxIdleTime = getIntProperty(poolProperties, "MaxIdleTime", 1200);
		int unreturnedConnectionTimeout = getIntProperty(poolProperties, "UnreturnedConnectionTimeout", 0);
		boolean testConnectionOnCheckin = getBooleanProperty(poolProperties, "TestConnectionOnCheckin", false);
		boolean testConnectionOnCheckout = getBooleanProperty(poolProperties, "TestConnectionOnCheckout", true);
		String mlogClass = getStringProperty(poolProperties, "com.mchange.v2.log.MLog", "com.mchange.v2.log.FallbackMLog");
		int checkoutTimeout = getIntProperty(poolProperties, "CheckoutTimeout", 0);
		int statementCacheNumDeferredCloseThreads = getIntProperty(poolProperties, "StatementCacheNumDeferredCloseThreads", 0);
        try
        {
        	System.setProperty("com.mchange.v2.log.MLog", mlogClass);
            //System.setProperty("com.mchange.v2.log.FallbackMLog.DEFAULT_CUTOFF_LEVEL", "ALL");
            ComboPooledDataSource cpds = new ComboPooledDataSource();
            cpds.setDataSourceName("iDempiereDS");
            cpds.setDriverClass(DRIVER);
            //loads the jdbc driver
            cpds.setJdbcUrl(getConnectionURL(connection));
            cpds.setUser(connection.getDbUid());
            cpds.setPassword(connection.getDbPwd());
            //cpds.setPreferredTestQuery(DEFAULT_CONN_TEST_SQL);
            cpds.setIdleConnectionTestPeriod(idleConnectionTestPeriod);
            cpds.setAcquireRetryAttempts(acquireRetryAttempts);
            cpds.setTestConnectionOnCheckin(testConnectionOnCheckin);
            cpds.setTestConnectionOnCheckout(testConnectionOnCheckout);
            if (checkoutTimeout > 0)
            	cpds.setCheckoutTimeout(checkoutTimeout);
            cpds.setStatementCacheNumDeferredCloseThreads(statementCacheNumDeferredCloseThreads);
            cpds.setMaxIdleTimeExcessConnections(maxIdleTimeExcessConnections);
            cpds.setMaxIdleTime(maxIdleTime);
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
                cpds.setMinPoolSize(minPoolSize);
                cpds.setMaxPoolSize(maxPoolSize);
                m_maxbusyconnections = (int) (maxPoolSize * 0.9);
                
                //statement pooling
                int maxStatementsPerConnection = getIntProperty(poolProperties, "MaxStatementsPerConnection", 0);
                if (maxStatementsPerConnection > 0)
                	cpds.setMaxStatementsPerConnection(maxStatementsPerConnection);
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
            //log might cause infinite loop since it will try to acquire database connection again
            //log.log(Level.SEVERE, "Could not initialise C3P0 Datasource", ex);
            System.err.println("Could not initialise C3P0 Datasource: " + ex.getLocalizedMessage());
        }

        return m_ds;
    }   //  getDataSource

    /**
     *  Get Cached Connection
     *  @param connection info
     *  @param autoCommit true if autocommit connection
     *  @param transactionIsolation Connection transaction level
     *  @return connection or null
     *  @throws Exception
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
                if (DBException.isInvalidUserPassError(e))
                {
                	//log might cause infinite loop since it will try to acquire database connection again
                	/*
                    log.severe("Cannot connect to database: "
                        + getConnectionURL(connection)
                        + " - UserID=" + connection.getDbUid());
                    */
                	StringBuilder msgerr = new StringBuilder("Cannot connect to database: ")
                									.append(getConnectionURL(connection))
                									.append(" - UserID=").append(connection.getDbUid());
                	System.err.println(msgerr.toString());
                }
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
    }   //  getCachedConnection

    /**
     *  Get Connection from Driver
     *  @param connection info
     *  @return connection or null
     *  @throws SQLException
     */
    public Connection getDriverConnection (CConnection connection) throws SQLException
    {
        getDriver();
        return DriverManager.getConnection (getConnectionURL (connection),
            connection.getDbUid(), connection.getDbPwd());
    }   //  getDriverConnection

    /**
     *  Get Driver Connection
     *  @param dbUrl URL
     *  @param dbUid user
     *  @param dbPwd password
     *  @return connection
     *  @throws SQLException
     */
    public Connection getDriverConnection (String dbUrl, String dbUid, String dbPwd)
        throws SQLException
    {
        getDriver();
        return DriverManager.getConnection (dbUrl, dbUid, dbPwd);
    }   //  getDriverConnection

    /**
     *  Close
     */
    public void close()
    {
        if (log.isLoggable(Level.CONFIG)) log.config(toString());
        if (m_ds != null)
        {
            try
            {
                m_ds.close();
            }
            catch (Exception e)
            {
                log.log(Level.SEVERE, "Could not close Data Source");
            }
        }
        m_ds = null;
    }   //  close

    /**
     *  Clean up
     */
    public void cleanup()
    {

    }   //  cleanup

    /**
     *  Get Data Type
     *  @param columnName
     *  @param displayType display type
     *  @param precision precision
     *  @param defaultValue if true adds default value
     *  @return data type
     */
    public String getDataType (String columnName, int displayType, int precision,
        boolean defaultValue)
    {
        String retValue = null;
        //handle special case, bug [ 1618423 ]
        if (columnName != null)
        {
            if (displayType == DisplayType.Button
                && columnName.endsWith("_ID"))
            {
                retValue = "NUMBER(10)";
            }
        }
        if (retValue == null)
        {
            switch (displayType)
            {
                //  IDs
                case DisplayType.Account:
                case DisplayType.Assignment:
                case DisplayType.ID:
                case DisplayType.Location:
                case DisplayType.Locator:
                case DisplayType.PAttribute:
                case DisplayType.Search:
                case DisplayType.Table:
                case DisplayType.TableDir:
                case DisplayType.Image:
                case DisplayType.Chart:
                    retValue = "NUMBER(10)";
                    break;

                // Dynamic Precision
                case DisplayType.Amount:
                    retValue = "NUMBER";
                    if (defaultValue)
                        retValue += " DEFAULT 0";
                    break;

                case DisplayType.Binary:
                    retValue = "BLOB";
                    break;

                case DisplayType.Button:
                    retValue = "CHAR(1)";
                    break;

                // Number Dynamic Precision
                case DisplayType.CostPrice:
                    retValue = "NUMBER";
                    if (defaultValue)
                        retValue += " DEFAULT 0";
                    break;

                //  Date
                case DisplayType.Date:
                case DisplayType.DateTime:
                case DisplayType.Time:
                    retValue = "DATE";
                    if (defaultValue)
                        retValue += " DEFAULT SYSDATE";
                    break;

                //  Number(10)
                case DisplayType.Integer:
                    retValue = "NUMBER(10)";
                    break;

                case DisplayType.List:
                    retValue = "CHAR(" + precision + ")";
                    break;

                //  NVARCHAR
                case DisplayType.Color:
                case DisplayType.Memo:
                case DisplayType.String:
                case DisplayType.Text:
                    retValue = "NVARCHAR(" + precision + ")";
                    break;

                case DisplayType.TextLong:
                    retValue = "CLOB";
                    break;

                //  Dyn Prec
                case DisplayType.Quantity:
                    retValue = "NUMBER";
                    break;

                case DisplayType.YesNo:
                    retValue = "CHAR(1)";
                    break;

                default:
                    log.severe("Unknown: " + displayType);
                    break;
            }
        }
        return retValue;
    }   //  getDataType


    /**
     *  Check and generate an alternative SQL
     *  @reExNo number of re-execution
     *  @msg previous execution error message
     *  @sql previous executed SQL
     *  @return String, the alternative SQL, null if no alternative
     */
    public String getAlternativeSQL(int reExNo, String msg, String sql)
    {
        //check reExNo or based on reExNo to do a decision. Currently none

        return null; //do not do re-execution of alternative SQL
    }


    /**************************************************************************
     *  Testing
     *  @param args ignored
     */
    public static void main (String[] args)
    {
        Adempiere.startupEnvironment(true);
        CConnection cc = CConnection.get();
        DB_Oracle db = (DB_Oracle)cc.getDatabase();
        db.cleanup();

        try
        {
            Connection conn = null;
        //  System.out.println("Driver=" + db.getDriverConnection(cc));
            DataSource ds = db.getDataSource(cc);
            System.out.println("DS=" + ds.getConnection());
            conn = db.getCachedConnection(cc, true, Connection.TRANSACTION_READ_COMMITTED);
            System.out.println("Cached=" + conn);
            System.out.println(db);
            //////////////////////////
            System.out.println("JAVA classpath: [\n" +
                System.getProperty("java.class.path") + "\n]");
                DatabaseMetaData dmd = conn.getMetaData();
                System.out.println("DriverVersion: ["+
                dmd.getDriverVersion()+"]");
                System.out.println("DriverMajorVersion: ["+
                dmd.getDriverMajorVersion()+"]");
                System.out.println("DriverMinorVersion: ["+
                dmd.getDriverMinorVersion()+"]");
                System.out.println("DriverName: ["+
                dmd.getDriverName()+"]");
                System.out.println("ProductName: ["+
                dmd.getDatabaseProductName() +"]");
                System.out.println("ProductVersion: [\n"+
                dmd.getDatabaseProductVersion()+"\n]");
            //////////////////////////
        }
        catch (Exception e1)
        {
            e1.printStackTrace();
        }
        db.cleanup();

        System.out.println("--------------------------------------------------");
        /**
        DROP TABLE X_Test;
        CREATE TABLE X_Test
        (
            Text1   NVARCHAR2(2000) NULL,
            Text2   VARCHAR2(2000)  NULL
        );
        **/
        try
        {
            String myString1 = "123456789 12345678";
            StringBuilder myString = new StringBuilder();
            for (int i = 0; i < 99; i++)
                myString.append(myString1).append((char)('a'+i)).append("\n");
            System.out.println(myString.length());
            System.out.println(Util.size(myString.toString()));
            //
            myString = new StringBuilder().append(Util.trimSize(myString.toString(), 2000));
            System.out.println(myString.length());
            System.out.println(Util.size(myString.toString()));
            //
            Connection conn2 = db.getCachedConnection(cc, true, Connection.TRANSACTION_READ_COMMITTED);
            /** **/
            PreparedStatement pstmt = conn2.prepareStatement
                ("INSERT INTO X_Test(Text1, Text2) values(?,?)");
            pstmt.setString(1, myString.toString()); // NVARCHAR2 column
            pstmt.setString(2, myString.toString()); // VARCHAR2 column
            System.out.println(pstmt.executeUpdate());
            /** **/
            Statement stmt = conn2.createStatement();
            System.out.println(stmt.executeUpdate
                ("INSERT INTO X_Test(Text1, Text2) values('" + myString + "','" + myString + "')"));
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        db.cleanup();
        System.out.println("--------------------------------------------------");
        System.exit(0);


        System.out.println("--------------------------------------------------");
        try
        {
            Connection conn1 = db.getCachedConnection(cc, false, Connection.TRANSACTION_READ_COMMITTED);
            Connection conn2 = db.getCachedConnection(cc, true, Connection.TRANSACTION_READ_COMMITTED);
            Connection conn3 = db.getCachedConnection(cc, false, Connection.TRANSACTION_READ_COMMITTED);
            System.out.println("3 -> " + db);
            conn1.close();
            conn2.close();
            conn1 = db.getCachedConnection(cc, true, Connection.TRANSACTION_READ_COMMITTED);
            conn2 = db.getCachedConnection(cc, true, Connection.TRANSACTION_READ_COMMITTED);
            System.out.println("3 -> " + db);
            conn1.close();
            conn2.close();
            conn3.close();
            System.out.println("0 -> " + db);
        }
        catch (Exception e1)
        {
            e1.printStackTrace();
        }

        db.cleanup();

    //  System.exit(0);
        System.out.println("--------------------------------------------------");

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.getConnectionRO());
        System.out.println(DB.getConnectionRW());
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));
        System.out.println(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));

        System.out.println(db);


        try
        {
            System.out.println("-- Sleeping --");
            Thread.sleep(60000);
            System.out.println(db);
            db.close();
            db.cleanup();
            System.out.println(db);
        }
        catch (InterruptedException e)
        {
        }



        /**
        //  Connection option 1
        try
        {
            System.setProperty("oracle.jdbc.Trace", "true");
            DriverManager.registerDriver(new OracleDriver());
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//dev:1521/dev", "adempiere", "adempiere");
            System.out.println("Catalog=" + con.getCatalog());
            DatabaseMetaData md = con.getMetaData();
            System.out.println("URL=" + md.getURL());
            System.out.println("User=" + md.getUserName());
            //
            System.out.println("Catalog");
            ResultSet rs = md.getCatalogs();
            while (rs.next())
                System.out.println("- " + rs.getString(1));
            //
            System.out.println("Table");
            rs = md.getTables(null, "ADEMPIERE", null, new String[] {"TABLE"});
            while (rs.next())
                System.out.println("- User=" + rs.getString(2) + " | Table=" + rs.getString(3)
                    + " | Type=" + rs.getString(4) + " | " + rs.getString(5));
            //
            System.out.println("Column");
            rs = md.getColumns(null, "ADEMPIERE", "C_ORDER", null);
            while (rs.next())
                System.out.println("- Tab=" + rs.getString(3) + " | Col=" + rs.getString(4)
                    + " | Type=" + rs.getString(5) + ", " + rs.getString(6)
                    + " | Size=" + rs.getString(7) + " | " + rs.getString(8)
                    + " | Digits=" + rs.getString(9) + " | Radix=" + rs.getString(10)
                    + " | Null=" + rs.getString(11) + " | Rem=" + rs.getString(12)
                    + " | Def=" + rs.getString(13) + " | " + rs.getString(14)
                    + " | " + rs.getString(15) + " | " + rs.getString(16)
                    + " | Ord=" + rs.getString(17) + " | Null=" + rs.getString(18)
                    );

            con.close();
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        **/
    }   //  main

    public Convert getConvert() {
        return m_convert;
    }

	public int getNextID(String name) {
		return getNextID(name, null);
	}

	public int getNextID(String name, String trxName) {
		int m_sequence_id = DB.getSQLValueEx(trxName, "SELECT "+name.toUpperCase()+".nextval FROM DUAL");
		return m_sequence_id;
	}

	public boolean createSequence(String name , int increment , int minvalue , int maxvalue ,int  start , String trxName)
	{
		// Check if Sequence exists
		final int cnt = DB.getSQLValueEx(trxName, "SELECT COUNT(*) FROM USER_SEQUENCES WHERE UPPER(sequence_name)=?", name.toUpperCase());
		final int no;
		if (start < minvalue)
			start = minvalue;
		//
		// New Sequence
		if (cnt == 0)
		{
			no = DB.executeUpdate("CREATE SEQUENCE "+name.toUpperCase()
								+ " MINVALUE " + minvalue
								+ " MAXVALUE " + maxvalue
								+ " START WITH " + start 
								+ " INCREMENT BY " + increment
								+ " CACHE 20", trxName);
		}
		//
		// Already existing sequence => ALTER
		else
		{
			no = DB.executeUpdate("ALTER SEQUENCE "+name.toUpperCase()
					+ " INCREMENT BY " + increment
					// + " MINVALUE " + minvalue // ORA-04007
					+ " MAXVALUE " + maxvalue
					+ " CACHE 20", trxName);
			while (DB.getSQLValue(trxName, "SELECT " + name.toUpperCase() + ".NEXTVAL FROM DUAL") < start) {
	        	// do nothing - the while is incrementing the sequence
	        }
		}
		if(no == -1 )
			return false;
		else
			return true;
	}

	public boolean isQueryTimeoutSupported() {
		return true;
	}

	public String addPagingSQL(String sql, int start, int end) {
		StringBuilder newSql = new StringBuilder("select * from (")
				.append("   select tb.*, ROWNUM oracle_native_rownum_ from (")
				.append(sql)
				.append(") tb) where oracle_native_rownum_ >= ")
				.append(start)
				.append(" AND oracle_native_rownum_ <= ")
				.append(end)
				.append(" order by oracle_native_rownum_");

		return newSql.toString();
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

	private	String getStringProperty(Properties properties,	String key, String defaultValue)		
	{					
		String b = defaultValue;					
		try				
		{
			String s = properties.getProperty(key);				
			if	(s != null && s.trim().length() > 0)
				b = s.trim();
		}			
		catch(Exception e){}				
		return b;						
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
			sqlBuffer.append(" FOR UPDATE WAIT ").append((timeout > 0 ? timeout : LOCK_TIME_OUT));

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
			}			
		}
		return false;
	}

	@Override
	public String getNameOfUniqueConstraintError(Exception e) {
		String info = e.getMessage();
		int fromIndex = info.indexOf(".");
		if (fromIndex == -1)
			return info;
		int toIndex = info.indexOf(")", fromIndex + 1);
		if (toIndex == -1)
			return info;
		return info.substring(fromIndex + 1, toIndex);
	}

	@Override
	public String subsetClauseForCSV(String columnName, String csv) {
		StringBuilder builder = new StringBuilder();
		builder.append("toTableOfVarchar2(")
			.append(columnName)
			.append(")");
		builder.append(" submultiset of ")
			.append("toTableOfVarchar2('")
			.append(csv)
			.append("')");
		
		return builder.toString();
	}

	@Override
	public String intersectClauseForCSV(String columnName, String csv) {
		StringBuilder builder = new StringBuilder();
		builder.append("toTableOfVarchar2(")
			.append(columnName)
			.append(")");
		builder.append(" MULTISET INTERSECT ")
			.append("toTableOfVarchar2('")
			.append(csv)
			.append("') IS NOT EMPTY");
		
		return builder.toString();
	}	
}   //  DB_Oracle
