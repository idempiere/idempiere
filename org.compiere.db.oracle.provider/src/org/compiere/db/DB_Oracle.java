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
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.logging.Level;

import javax.sql.DataSource;

import org.adempiere.db.oracle.OracleBundleActivator;
import org.adempiere.exceptions.DBException;
import org.compiere.dbPort.Convert;
import org.compiere.dbPort.Convert_Oracle;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Trx;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import com.zaxxer.hikari.HikariPoolMXBean;

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

	private static final String POOL_PROPERTIES = "hikaricp.properties";
	
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
    private volatile String         m_connectionURL;

    /** Data Source                 */
	private volatile HikariDataSource m_ds;

    /** Cached User Name            */
    private String                  m_userName = null;

    private Convert m_convert = new Convert_Oracle();

    /** Logger          */
    private static final CLogger          log = CLogger.getCLogger (DB_Oracle.class);

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
        System.setProperty("oracle.jdbc.v$session.program", "iDempiere");
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


    /**************************************************************************
     *  Convert an individual Oracle Style statements to target database statement syntax.
     *  @param oraStatement oracle statement
     *  @return converted Statement oracle statement
     */
    public String convertStatement (String oraStatement)
    {
    	Convert.logMigrationScript(oraStatement, null);
		if ("true".equals(System.getProperty("org.idempiere.db.debug"))) {
			String filterOrDebug = System.getProperty("org.idempiere.db.debug.filter");
			boolean print = true;
			if (filterOrDebug != null)
				print = oraStatement.matches(filterOrDebug);
			if (print)
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
                return "TRUNC(getDate())";
            return "getDate()";
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

	private String getPoolPropertiesFile ()
	{
		String base = Ini.getAdempiereHome();
		
		if (base != null && !base.endsWith(File.separator)) {
			base += File.separator;
		}
		
		//
		return base + getName() + File.separator + POOL_PROPERTIES;
	}	//	getFileName
    
	public DataSource getDataSource(CConnection connection)
	{
		ensureInitialized(connection);
			
		return m_ds;
	}

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
			propertyFileURL = OracleBundleActivator.bundleContext.getBundle().getEntry("META-INF/pool/server.default.properties");						
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
     *  @deprecated
     */
    public String getDataType (String columnName, int displayType, int precision,
        boolean defaultValue)
    {
    	return DisplayType.getSQLDataType(displayType, columnName, precision);
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
			.append("toTableOfVarchar2(")
			.append(DB.TO_STRING(csv))
			.append(")");
		
		return builder.toString();
	}

	@Override
	public String intersectClauseForCSV(String columnName, String csv) {
		StringBuilder builder = new StringBuilder();
		builder.append("toTableOfVarchar2(")
			.append(columnName)
			.append(")");
		builder.append(" MULTISET INTERSECT ")
			.append("toTableOfVarchar2(")
			.append(DB.TO_STRING(csv))
			.append(") IS NOT EMPTY");
		
		return builder.toString();
	}

	@Override
	public String getNumericDataType() {
		return "NUMBER";
	}

	@Override
	public String getCharacterDataType() {
		return "CHAR";
	}

	@Override
	public String getVarcharDataType() {
		return "VARCHAR2";
	}

	/**
	 * @return variable length character data type suffix
	 */
	public String getVarcharLengthSuffix() {
		return " CHAR";
	};

	@Override
	public String getBlobDataType() {
		return "BLOB";
	}

	@Override
	public String getClobDataType() {
		return "CLOB";
	}

	@Override
	public String getTimestampDataType() {
		return "DATE";
	}

	@Override
	public String getTimestampWithTimezoneDataType() {
		return "TIMESTAMP WITH TIME ZONE";
	}

	@Override
	public String getSQLDDL(MColumn column) {				
		StringBuilder sql = new StringBuilder ().append(column.getColumnName())
			.append(" ").append(column.getSQLDataType());

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
			sql.append(" DEFAULT ").append(defaultValue);
		}
		else
		{
			if (! column.isMandatory())
				sql.append(" DEFAULT NULL ");
			defaultValue = null;
		}

		//	Inline Constraint
		if (column.getAD_Reference_ID() == DisplayType.YesNo)
			sql.append(" CHECK (").append(column.getColumnName()).append(" IN ('Y','N'))");

		//	Null
		if (column.isMandatory())
			sql.append(" NOT NULL");
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
			.append(" ADD ").append(column.getSQLDDL());
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
		StringBuilder sql = new StringBuilder();
		StringBuilder sqlBase = new StringBuilder ("ALTER TABLE ")
			.append(table.getTableName())
			.append(" MODIFY ").append(column.getColumnName());
		
		//	Default
		StringBuilder sqlDefault = new StringBuilder(sqlBase)
			.append(" ").append(column.getSQLDataType());
		String defaultValue = column.getDefaultValue();
		String originalDefaultValue = defaultValue;
		if (defaultValue != null 
			&& defaultValue.length() > 0
			&& defaultValue.indexOf('@') == -1		//	no variables
			&& ( ! (DisplayType.isID(column.getAD_Reference_ID()) && defaultValue.equals("-1") ) ) )  // not for ID's with default -1
		{
			if (DisplayType.isText(column.getAD_Reference_ID()) 
				|| DisplayType.isList(column.getAD_Reference_ID())
				|| column.getAD_Reference_ID() == DisplayType.YesNo
				|| column.getAD_Reference_ID() == DisplayType.Payment
				// Two special columns: Defined as Table but DB Type is String 
				|| column.getColumnName().equals("EntityType") || column.getColumnName().equals("AD_Language")
				|| (column.getAD_Reference_ID() == DisplayType.Button &&
						!(column.getColumnName().endsWith("_ID"))))
			{
				if (!defaultValue.startsWith("'") && !defaultValue.endsWith("'"))
					defaultValue = DB.TO_STRING(defaultValue);
			}
			sqlDefault.append(" DEFAULT ").append(defaultValue);
		}
		else
		{
			if (! column.isMandatory())
				sqlDefault.append(" DEFAULT NULL ");
			defaultValue = null;
		}
		sql.append(sqlDefault);
		
		//	Constraint

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
			}
			StringBuilder sqlSet = new StringBuilder("UPDATE ")
				.append(table.getTableName())
				.append(" SET ").append(column.getColumnName())
				.append("=").append(defaultValue)
				.append(" WHERE ").append(column.getColumnName()).append(" IS NULL");
			sql.append(DB.SQLSTATEMENT_SEPARATOR).append(sqlSet);
		}
		
		//	Null
		if (setNullOption)
		{
			StringBuilder sqlNull = new StringBuilder(sqlBase);
			if (column.isMandatory())
				sqlNull.append(" NOT NULL");
			else
				sqlNull.append(" NULL");
			sql.append(DB.SQLSTATEMENT_SEPARATOR).append(sqlNull);
		}
		//
		return sql.toString();
	}	//	getSQLModify

	@Override
	public boolean isQueryTimeout(SQLException ex) {
		//java.sql.SQLTimeoutException: ORA-01013: user requested cancel of current operation
		return "72000".equals(ex.getSQLState()) && ex.getErrorCode() == 1013;
	}
	
	
}   //  DB_Oracle
