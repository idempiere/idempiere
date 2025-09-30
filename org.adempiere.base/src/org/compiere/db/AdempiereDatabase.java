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

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.SQLException;
import java.sql.SQLTimeoutException;
import java.sql.Timestamp;

import javax.sql.DataSource;

import org.compiere.db.partition.ITablePartitionService;
import org.compiere.dbPort.Convert;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;

/**
 *  Interface for database adapter
 *
 *  @author     Jorg Janke
 *  @version    $Id: AdempiereDatabase.java,v 1.5 2006/09/22 23:35:19 jjanke Exp $
 */
public interface AdempiereDatabase
{
	
	/** default lock timeout, 60 seconds **/
	static final int LOCK_TIME_OUT = 60;

	/* PostgreSQL restricts object names to 63 characters */
	public final static int MAX_OBJECT_NAME_LENGTH = 63;

	/**
	 *  Get Database Name
	 *  @return database short name
	 */
	public String getName();

	/**
	 *  Get Database Description
	 *  @return database long name and version
	 */
	public String getDescription();

	/**
	 *  Get and register Database Driver
	 *  @return Driver
	 *  @throws SQLException
	 */
	public Driver getDriver() throws SQLException;


	/**
	 *  Get Standard JDBC Port
	 *  @return standard port
	 */
	public int getStandardPort();

	/**
	 *  Get Database Connection String
	 *  @param connection Connection Descriptor
	 *  @return connection String
	 */
	public String getConnectionURL (CConnection connection);
	
	/**
	 * 	Get Connection URL
	 *	@param dbHost db Host
	 *	@param dbPort db Port
	 *	@param dbName db Name
	 *	@param userName user name
	 *	@return url
	 */
	public String getConnectionURL (String dbHost, int dbPort, String dbName,
		String userName);

	/**
	 *  Get Database Connection URL
	 *  @param connectionURL Connection URL
	 *  @param userName user name
	 *  @return connection URL
	 */
	public String getConnectionURL (String connectionURL, String userName);

	/**
	 * 	Get JDBC Catalog
	 *	@return catalog
	 */
	public String getCatalog();
	
	/**
	 * 	Get JDBC Schema
	 *	@return schema
	 */
	public String getSchema();

	/**
	 *  Supports BLOB
	 *  @return true if BLOB is supported
	 */
	public boolean supportsBLOB();

	/**
	 *  String Representation
	 *  @return info
	 */
	public String toString();
	
	/**
	 *  Convert an individual Oracle syntax statements to target database statement syntax
	 *
	 *  @param oraStatement oracle statement
	 *  @return converted Statement
	 */
	public String convertStatement (String oraStatement);

	/**
	 *  Check if DBMS support the sql statement
	 *  @param sql SQL statement
	 *  @return true: yes
	 */
	public boolean isSupported(String sql);

	/**
	 *  Get constraint type associated with the index
	 *  @param conn connection
	 *  @param tableName table name
	 *  @param IXName Index name
	 *  @return String[0] = 0: do not know, 1: Primary Key  2: Foreign Key
	 *  		String[1] - String[n] = Constraint Name
	 */
	public String getConstraintType(Connection conn, String tableName, String IXName);

	/**
	 *  Check and generate an alternative SQL
	 *  @param reExNo number of re-execution
	 *  @param msg previous execution error message
	 *  @param sql previous executed SQL
	 *  @return String, the alternative SQL, null if no alternative
	 */
	public String getAlternativeSQL(int reExNo, String msg, String sql);

	/**
	 *  Get Name of System User
	 *  @return e.g. sa, system
	 */
	public String getSystemUser();
	
	/**
	 *  Get Name of System Database
	 *  @param databaseName database Name
	 *  @return e.g. master or database Name
	 */
	public String getSystemDatabase(String databaseName);
	
	/**
	 *  Create SQL TO Date statement for Timestamp
	 *
	 *  @param  time Date to be converted
	 *  @param  dayOnly true if time should be set to 00:00:00
	 *  @return to date function
	 */
	public String TO_DATE (Timestamp time, boolean dayOnly);

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
	public String TO_CHAR (String columnName, int displayType, String AD_Language);

	
	/**
	 * 	Return number as string for INSERT statements with correct precision
	 *	@param number number
	 *	@param displayType display Type
	 *	@return number as string
	 */
	public String TO_NUMBER (BigDecimal number, int displayType);
	
	/**
	 * 	Return string as JSON object for INSERT statements
	 *	@param value
	 *	@return value as JSON
	 */
	public String TO_JSON (String value);
	
	/**
	 *	@return string with right casting for JSON inserts
	 */
	public String getJSONCast ();
		
	/**
	 * 	Get next sequence number in this Sequence
	 *	@param Name Sequence name
	 *  @param trxName Transaction name
	 */
	public int getNextID(String Name, String trxName);
	
	/**
	 * 	Get next sequence number in this Sequence
	 *	@param Name Sequence name
	 */
	public int getNextID(String Name);
	
	/**
	 * Create Native Sequence
	 * @param name Sequence Name
	 * @param increment
	 * @param minvalue
	 * @param maxvalue
	 * @param start
	 * @param trxName
	 */
	public boolean createSequence(String name , int increment , int minvalue , int maxvalue ,int  start, String trxName);
		
	/** Create User commands					*/
	public static final int		CMD_CREATE_USER = 0;
	/** Create Database/Schema Commands			*/
	public static final int		CMD_CREATE_DATABASE = 1;
	/** Drop Database/Schema Commands			*/
	public static final int		CMD_DROP_DATABASE = 2;
	
	/**
	 * 	Get SQL Commands.
	 *  <pre>
	 * 	The following variables are resolved:
	 * 	@SystemPassword@, @AdempiereUser@, @AdempierePassword@
	 * 	@SystemPassword@, @DatabaseName@, @DatabaseDevice@
	 *  </pre>
	 *	@param cmdType {@link #CMD_CREATE_USER}, {@link #CMD_CREATE_DATABASE} or {@link #CMD_DROP_DATABASE}
	 *	@return array of commands to be executed
	 */
	public String[] getCommands (int cmdType);
	
	/**
	 * 	Get Cached Connection on Server
	 *	@param connection info
	 *  @param autoCommit true if autocommit connection
	 *  @param transactionIsolation transaction isolation level
	 *	@return connection or null
	 *  @throws Exception
	 */
	public Connection getCachedConnection (CConnection connection, 
		boolean autoCommit, int transactionIsolation) throws Exception;

	/**
	 * 	Get Connection from Driver
	 *	@param connection info
	 *	@return connection or null
	 *  @throws SQLException
	 */
	public Connection getDriverConnection (CConnection connection) throws SQLException;

	/**
	 * 	Get Driver Connection
	 *	@param dbUrl URL
	 *	@param dbUid user
	 *	@param dbPwd password
	 *	@return connection
	 *	@throws SQLException
	 */
	public Connection getDriverConnection (String dbUrl, String dbUid, String dbPwd) 
		throws SQLException;

	/**
	 * 	Create DataSource
	 *	@param connection connection
	 *	@return data source
	 */
	public DataSource getDataSource(CConnection connection);

	/**
	 * 	Get Status
	 * 	@return status info or null if no local datasource available
	 */
	public String getStatus();

	/**
	 * 	Close
	 */
	public void close();
	
	/**
	 * Get {@link Convert} implementation for this DB adapter
	 * @return Convert instance
	 */
	public Convert getConvert();

	/**
	 * @return true if jdbc driver support statement timeout
	 */
	public boolean isQueryTimeoutSupported();

	/**
	 * Is the database have sql extension that return a subset of the query result
	 * @return true if DB support paging SQL
	 */
	public boolean isPagingSupported();

	/**
	 * modify sql to return a subset of the query result. use 1 base index for start and end parameter
	 * @param sql
	 * @param start
	 * @param end
	 * @return SQL with added paging clause
	 */
	public String addPagingSQL(String sql, int start, int end);
	
	/**
	 * Lock PO for update
	 * @param po
	 * @param timeout
	 * @return true if lock is granted
	 */
	public boolean forUpdate(PO po, int timeout);
	
	/**
	 * @param e
	 * @return unique constraint name
	 */
	public String getNameOfUniqueConstraintError(Exception e);

	/**
     * <p>
     * The "child record found error" contains the 
     * foreign key constraint name after the second occurrence
     * of the opening double quote: ["].
     * </p>
     * 
     * <h3>Example:</h3>
     * <p>
     * ERROR: update or delete on table "m_product_category" 
     * violates foreign key constraint "mprodcategory_mdiscountsbreak" 
     * on table "m_discountschemabreak" 
     * Detail: Key (m_product_category_id)=(50000) is still referenced from table "m_discountschemabreak".
     * </p>
     * 
     * @param e
     * @return constraint name
     */
	public String getForeignKeyConstraint(Exception e);

	/**
	 * @param columnName
	 * @param csv comma separated value
	 * @return subset sql clause
	 */
	public String subsetClauseForCSV(String columnName, String csv);
	
	/**
	 * @param columnName
	 * @param csv comma separated value
	 * @return intersect sql clause
	 */
	public String intersectClauseForCSV(String columnName, String csv);
	
	/**
	 * @param columnName
	 * @param csv comma separated value
	 * @param isNotClause
	 * @return intersect sql clause
	 */
	public String intersectClauseForCSV(String columnName, String csv, boolean isNotClause);
	
	/**
	 * Quote column name if necessary (usually to avoid conflict with reserved keywords)
	 * @param columnName
	 * @return columnName or quoted columnName
	 */
	public default String quoteColumnName(String columnName) {
		return columnName;
	}
	
	/**
	 * @return true if using native dialect, false if using oracle dialect
	 */
	public default boolean isNativeMode() {
		return true;
	}
	
	/**
	 * @return numeric data type name
	 */
	public String getNumericDataType();
	
	/**
	 * @return fixed length character data type name
	 */
	public String getCharacterDataType();
	
	/**
	 * @return variable length character data type name
	 */
	public String getVarcharDataType();

	/**
	 * @return variable length character data type suffix
	 */
	public default String getVarcharLengthSuffix() {
		return "";
	};

	/**
	 * @return binary large object data type name
	 */
	public String getBlobDataType();
	
	/**
	 * @return character large object data type name
	 */
	public String getClobDataType();
	
	/**
	 * @return json object data type name
	 */
	public String getJsonDataType();
	
	/**
	 * @return time stamp data type name
	 */
	public String getTimestampDataType();
	
	/**
	 * @return timestamp with time zone type name
	 */
	public String getTimestampWithTimezoneDataType();
	
	/**
	 * Get create table SQL statement 
	 * @param table
	 * @return create table DDL
	 */
	public default String getSQLCreate(MTable table)
	{
		StringBuilder sb = new StringBuilder("CREATE TABLE ")
			.append(table.getTableName()).append(" (");
		//
		StringBuilder constraints = new StringBuilder();
		MColumn[] columns = table.getColumns(true);
		boolean columnAdded = false;
		for (int i = 0; i < columns.length; i++)
		{
			MColumn column = columns[i];
			String colSQL = column.getSQLDDL();
			if ( colSQL != null )
			{
				if (columnAdded)
					sb.append(", ");
				else
					columnAdded = true;
				sb.append(column.getSQLDDL());
			}
			else // virtual column
				continue;
			//
			String constraint = column.getConstraint(table.getTableName());
			if (constraint != null && constraint.length() > 0)
				constraints.append(", ").append(constraint);
		}

		sb.append(constraints)
			.append(")");
		return sb.toString();
	}	//	getSQLCreate
	
	/**
	 * Convert blob to hex encoded string and return SQL function that will convert the hex encoded string back to blob
	 * @param blob
	 * @return SQL statement
	 */
	public String TO_Blob(byte[] blob);
	
	/**
	 * @param column
	 * @return DDL SQL statement for column
	 */
	public String getSQLDDL(MColumn column);
	
	/**
	 * @param table
	 * @param column
	 * @return add column SQL statement
	 */
	public String getSQLAdd(MTable table, MColumn column);
	
	/**
	 * @param table
	 * @param column
	 * @param setNullOption
	 * @return alter column SQL statement
	 */
	public String getSQLModify (MTable table, MColumn column, boolean setNullOption);

	/**
	 * @param ex
	 * @return true if ex is caused by query timeout
	 */
	public default boolean isQueryTimeout(SQLException ex) {
		return ex instanceof SQLTimeoutException;
	}
	
	/**
	 * Get DB specific table partition support
	 * @return ITablePartitionService instance
	 */
	public default ITablePartitionService getTablePartitionService() {
		return null;
	}
}   //  AdempiereDatabase

