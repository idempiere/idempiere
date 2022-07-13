/*******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                        *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it     *
 * under the terms version 2 of the GNU General Public License as published    *
 * by the Free Software Foundation. This program is distributed in the hope    *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied  *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.            *
 * See the GNU General Public License for more details.                        *
 * You should have received a copy of the GNU General Public License along     *
 * with this program; if not, write to the Free Software Foundation, Inc.,     *
 * 59 Temple Place, Suite 330, Boston, MA                                      *
 * 02111-1307 USA.                                                             *
 *                                                                             *
 * Copyright (C) 2007 Low Heng Sin hengsin@avantz.com                          *
 * Contributor(s):                                                             *
 *                 Teo Sarca, www.arhipac.ro                                   *
 * __________________________________________                                  *
 ******************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Spliterator;
import java.util.Spliterators;
import java.util.function.Consumer;
import java.util.logging.Level;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * 
 * @author Low Heng Sin
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 1981760 ] Improve Query class
 * 			<li>BF [ 2030280 ] org.compiere.model.Query apply access filter issue
 * 			<li>FR [ 2041894 ] Add Query.match() method
 * 			<li>FR [ 2107068 ] Query.setOrderBy should be more error tolerant
 * 			<li>FR [ 2107109 ] Add method Query.setOnlyActiveRecords
 * 			<li>FR [ 2421313 ] Introduce Query.firstOnly convenient method
 * 			<li>FR [ 2546052 ] Introduce Query aggregate methods
 * 			<li>FR [ 2726447 ] Query aggregate methods for all return types
 * 			<li>FR [ 2818547 ] Implement Query.setOnlySelection
 * 				https://sourceforge.net/p/adempiere/feature-requests/759/
 * 			<li>FR [ 2818646 ] Implement Query.firstId/firstIdOnly
 * 				https://sourceforge.net/p/adempiere/feature-requests/760/
 * @author Redhuan D. Oon
 * 			<li>FR: [ 2214883 ] Remove SQL code and Replace for Query // introducing SQL String prompt in log.info 
 *			<li>FR: [ 2214883 ] - to introduce .setClient_ID
 */
public class Query
{
	public static final String AGGREGATE_COUNT		= "COUNT";
	public static final String AGGREGATE_SUM		= "SUM";
	public static final String AGGREGATE_AVG		= "AVG";
	public static final String AGGREGATE_MIN		= "MIN";
	public static final String AGGREGATE_MAX		= "MAX";
	
	private static CLogger log	= CLogger.getCLogger (Query.class);
	
	private Properties ctx = null;
	private MTable table = null;
	private String whereClause = null;
	private String orderBy = null;
	private String trxName = null;
	private Object[] parameters = null;

	/**
	 * Name of virtual columns to be included in the query
	 */
	private String[] virtualColumns = null;

	private boolean applyAccessFilter = false;
	private boolean applyAccessFilterRW = false;
	private boolean applyAccessFilterFullyQualified = true;
	private boolean onlyActiveRecords = false;
	private boolean onlyClient_ID = false;
	private int onlySelection_ID = -1;
	private boolean forUpdate = false;

	/**
	 * Whether to load (<code>false</code> value) all declared virtual columns at once or use 
	 * lazy loading (<code>true</code> value).
	 */
	private boolean noVirtualColumn = true;

	private int queryTimeout = 0;
	private List<String> joinClauseList = new ArrayList<String>();
	
    /**
     * Limit current query rows return.
     */
    private int pageSize;

    /**
     * Number of records will be skipped on query run.
     */
    private int recordsToSkip;

	/**
	 * 
	 * @param table
	 * @param whereClause
	 * @param trxName
	 * @deprecated Use {@link #Query(Properties, MTable, String, String)} instead because this method is security error prone
	 */
	public Query(MTable table, String whereClause, String trxName)
	{
		this.ctx = table.getCtx();
		this.table = table;
		this.whereClause = whereClause;
		this.trxName = trxName;
	}
	
	/**
	 * @param ctx context 
	 * @param table
	 * @param whereClause
	 * @param trxName
	 */
	public Query(Properties ctx, MTable table, String whereClause, String trxName)
	{
		this.ctx = ctx;
		this.table = table;
		this.whereClause = whereClause;
		this.trxName = trxName;
	}
	
	/**
	 * 
	 * @param ctx
	 * @param tableName
	 * @param whereClause
	 * @param trxName
	 */
	public Query(Properties ctx, String tableName, String whereClause, String trxName)
	{
		this(ctx, MTable.get(ctx, tableName), whereClause, trxName);
		if (this.table == null)
			throw new IllegalArgumentException("Table Name Not Found - "+tableName);
	}
	
	/**
	 * Set query parameters
	 * @param parameters
	 */
	public Query setParameters(Object ...parameters)
	{
		this.parameters = parameters;
		return this;
	}
	
	/**
	 * Set query parameters
	 * @param parameters collection of parameters
	 */
	public Query setParameters(List<Object> parameters)
	{
		if (parameters == null) {
			this.parameters = null;
			return this;
		}
		this.parameters = new Object[parameters.size()];
		parameters.toArray(this.parameters);
		return this;
	}
	
	/**
	 * Set order by clause.
	 * If the string starts with "ORDER BY" then "ORDER BY" keywords will be discarded. 
	 * @param orderBy SQL ORDER BY clause
	 */
	public Query setOrderBy(String orderBy)
	{
		this.orderBy = orderBy != null ? orderBy.trim() : null;
		if (this.orderBy != null && this.orderBy.toUpperCase().startsWith("ORDER BY"))
		{
			this.orderBy = this.orderBy.substring(8);
		}
		return this;
	}
	
	/**
	 * Turn on/off the addition of data access filter
	 * @param flag
	 */
	public Query setApplyAccessFilter(boolean flag)
	{
		this.applyAccessFilter = flag;
		return this;
	}

	/**
	 * Turn on data access filter with controls
	 * @param fullyQualified
	 * @param RW
	 * @return
	 */
	public Query setApplyAccessFilter(boolean fullyQualified, boolean RW)
	{
		this.applyAccessFilter = true;
		this.applyAccessFilterFullyQualified = fullyQualified;
		this.applyAccessFilterRW = RW;
		return this;
	}
	
	
	/**
	 * Select only active records (i.e. IsActive='Y')
	 * @param onlyActiveRecords
	 */
	public Query setOnlyActiveRecords(boolean onlyActiveRecords)
	{
		this.onlyActiveRecords = onlyActiveRecords;
		return this;
	}
	
	/**
	 * Set Client_ID true for WhereClause routine to include AD_Client_ID
	 */
	public Query setClient_ID()
	{
		return setClient_ID (true);
	}
	
	/**
	 * Set include or not include AD_Client_ID in where clause
	 */
	public Query setClient_ID(boolean isIncludeClient)
	{
		this.onlyClient_ID = isIncludeClient;
		return this;
	}
	
	/**
	 * Only records that are in T_Selection with AD_PInstance_ID.
	 * @param AD_PInstance_ID
	 */
	public Query setOnlySelection(int AD_PInstance_ID)
	{
		this.onlySelection_ID = AD_PInstance_ID;
		return this;
	}
	
	/**
	 * Add FOR UPDATE clause
	 * @param forUpdate
	 */
	public Query setForUpdate(boolean forUpdate)
	{
		this.forUpdate = forUpdate;
		return this;
	}

	/**
	 * Virtual columns are lazy loaded by default. In case lazy loading is not desired use this method with
	 * the <code>false</code> value.  
	 * @param noVirtualColumn Whether to load (<code>false</code> value) all declared virtual columns at once or use lazy loading (<code>true</code> value).
	 * @return
	 * @see #setVirtualColumns(String...)
	 */
	public Query setNoVirtualColumn(boolean noVirtualColumn)
	{
		this.noVirtualColumn = noVirtualColumn;
		return this;
	}
	
	public Query setQueryTimeout(int seconds)
	{
		this.queryTimeout = seconds;
		return this;
	}
	
	public Query addJoinClause(String joinClause)
	{
		joinClauseList.add(joinClause);
		return this;
	}
	
	/**
	 * Return a list of all po that match the query criteria.
	 * @return List
	 * @throws DBException 
	 */
	@SuppressWarnings("unchecked")
	public <T extends PO> List<T> list() throws DBException
	{
		List<T> list = new ArrayList<T>();
		String sql = buildSQL(null, true);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			rs = createResultSet(pstmt);
			while (rs.next ())
			{
				T po = (T)table.getPO(rs, trxName);
				list.add(po);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			throw new DBException(e, sql);
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return list;
	}
	
	/**
	 * Return first PO that match query criteria
	 * @return first PO
	 * @throws DBException
	 */
	@SuppressWarnings("unchecked")
	public <T extends PO> T first() throws DBException
	{
		T po = null;
		
		int oldPageSize = this.pageSize;
		if(DB.getDatabase().isPagingSupported())
			setPageSize(1);	// Limit to One record
		
		String sql = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			sql = buildSQL(null, true);
			
			pstmt = DB.prepareStatement (sql, trxName);
			rs = createResultSet(pstmt);
			if (rs.next ())
			{
				po = (T)table.getPO(rs, trxName);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			throw new DBException(e, sql);
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
			setPageSize(oldPageSize);
		}
		return po;
	}
	
	/**
	 * Return first PO that match query criteria.
	 * If there are more records that match criteria an exception will be throwed 
	 * @return first PO
	 * @throws DBException
	 * @see {@link #first()}
	 */
	@SuppressWarnings("unchecked")
	public <T extends PO> T firstOnly() throws DBException
	{
		T po = null;
		
		int oldPageSize = this.pageSize;
		if(DB.getDatabase().isPagingSupported())
			setPageSize(2);	// Limit to 2 Records
		
		String sql = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			sql = buildSQL(null, true);
			
			pstmt = DB.prepareStatement (sql, trxName);
			rs = createResultSet(pstmt);
			if (rs.next())
			{
				po = (T)table.getPO(rs, trxName);
			}
			if (rs.next())
			{
				throw new DBException("QueryMoreThanOneRecordsFound"); // TODO : translate
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
			setPageSize(oldPageSize);
		}
		return po;
	}
	
	/**
	 * Return first ID
	 * @return first ID or -1 if not found
	 * @throws DBException
	 */
	public int firstId() throws DBException
	{
		return firstId(false);
	}
	
	/**
	 * Return first ID.
	 * If there are more results and exception is thrown.
	 * @return first ID or -1 if not found
	 * @throws DBException
	 */
	public int firstIdOnly() throws DBException
	{
		return firstId(true);
	}
	
	private int firstId(boolean assumeOnlyOneResult) throws DBException
	{
		String[] keys = table.getKeyColumns();
		if (keys.length != 1)
		{
			throw new DBException("Table "+table+" has 0 or more than 1 key columns");
		}

		StringBuilder selectClause = new StringBuilder("SELECT ");
		if (!joinClauseList.isEmpty())
			selectClause.append(table.getTableName()).append(".");
		selectClause.append(keys[0]);
		selectClause.append(" FROM ").append(table.getTableName());
		
		int oldPageSize = this.pageSize;
		if(DB.getDatabase().isPagingSupported())
			setPageSize(assumeOnlyOneResult ? 2 : 1);

		String sql = null;
		
		int id = -1;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			sql = buildSQL(selectClause, true);
			
			pstmt = DB.prepareStatement(sql, trxName);
			rs = createResultSet(pstmt);
			if (rs.next())
			{
				id = rs.getInt(1);
			}
			if (assumeOnlyOneResult && rs.next())
			{
				throw new DBException("QueryMoreThanOneRecordsFound"); // TODO : translate
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
			setPageSize(oldPageSize);
		}
		//
		return id;
	}

	
	/**
	 * red1 - returns full SQL string - for caller needs
	 * @return buildSQL(null,true)
	 * 
	 */
	public String getSQL() throws DBException
	{
 		return buildSQL(null, true);
	}

	/**
	 * Aggregate given expression on this criteria
	 * @param sqlExpression
	 * @param sqlFunction 
	 * @return aggregated value
	 * @throws DBException
	 */
	public BigDecimal aggregate(String sqlExpression, String sqlFunction) throws DBException
	{
		return aggregate(sqlExpression, sqlFunction, BigDecimal.class);
	}

	/**
	 * Aggregate given expression on this criteria
	 * @param <T>
	 * @param sqlExpression
	 * @param sqlFunction
	 * @param returnType
	 * @return aggregated value
	 * @throws DBException
	 */
	@SuppressWarnings("unchecked")
	public <T> T aggregate(String sqlExpression, String sqlFunction, Class<T> returnType) throws DBException
	{
		if (Util.isEmpty(sqlFunction, true))
		{
			throw new DBException("No Aggregate Function defined");
		}
		if (Util.isEmpty(sqlExpression, true))
		{
			if (AGGREGATE_COUNT == sqlFunction)
			{
				sqlExpression = "*";
			}
			else
			{
				throw new DBException("No Expression defined");
			}
		}
		
		StringBuilder sqlSelect = new StringBuilder("SELECT ").append(sqlFunction).append("(")
					.append(sqlExpression).append(")")
					.append(" FROM ").append(table.getTableName());
		
		T value = null;
		T defaultValue = null;
		
		String sql = buildSQL(sqlSelect, false);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, this.trxName);
			rs = createResultSet(pstmt);
			if (rs.next())
			{
				if (returnType.isAssignableFrom(BigDecimal.class))
				{
					value = (T)rs.getBigDecimal(1);
					defaultValue = (T)Env.ZERO;
				}
				else if (returnType.isAssignableFrom(Double.class))
				{
					value = (T)Double.valueOf(rs.getDouble(1));
					defaultValue = (T)Double.valueOf(0.00);
				}
				else if (returnType.isAssignableFrom(Integer.class))
				{
					value = (T)Integer.valueOf(rs.getInt(1));
					defaultValue = (T)Integer.valueOf(0);
				}
				else if (returnType.isAssignableFrom(Timestamp.class))
				{
					value = (T)rs.getTimestamp(1);
				}
				else if (returnType.isAssignableFrom(Boolean.class))
				{
					value = (T) Boolean.valueOf("Y".equals(rs.getString(1)));
					defaultValue = (T) Boolean.FALSE;
				}
				else
				{
					value = (T)rs.getObject(1);
				}
			}
			if (rs.next())
			{
				throw new DBException("QueryMoreThanOneRecordsFound"); // TODO : translate
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		if (value == null)
		{
			value = defaultValue;
		}
		return value;
	}
	
	/**
	 * Count items that match query criteria
	 * @return count
	 * @throws DBException
	 */
	public int count() throws DBException
	{
		return aggregate("*", AGGREGATE_COUNT).intValue();
	}
	
	/**
	 * SUM sqlExpression for items that match query criteria
	 * @param sqlExpression
	 * @return sum
	 */
	public BigDecimal sum(String sqlExpression)
	{
		return aggregate(sqlExpression, AGGREGATE_SUM);
	}
	/**
	 * Check if there items for query criteria
	 * @return true if exists, false otherwise
	 * @throws DBException
	 */
	public boolean match() throws DBException
	{
		String sql = buildSQL(new StringBuilder("SELECT 1 FROM ").append(table.getTableName()), false);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, this.trxName);
			rs = createResultSet(pstmt);
			if (rs.next())
				return true;
		}
		catch (SQLException e) {
			throw new DBException(e, sql);
		}
		finally {
			DB.close(rs, pstmt);
		}
		return false;
	}
	
	/**
	 * Return an Stream implementation to fetch one PO at a time. This method will only create POs on-demand and
	 * they will become eligible for garbage collection once they have been consumed by the stream, so unlike
	 * {@link #list()} it doesn't have to hold a copy of all the POs in the result set in memory at one time.
	 * And unlike {#link #iterate()}, it only creates one ResultSet and iterates over it, creating a PO for each
	 * row ({@link #iterate()}, on the other hand, has to re-run the query for each element).<br/>
	 * 
	 * For situations where you need to iterate over a result set and operate on the results one-at-a-time rather
	 * than operate on the group as a whole, this method is likely to give better performance than <code>list()</code>
	 * or <code>iterate()</code>.<br/>
	 * 
	 * <strong>However</strong>, because it keeps the underlying {@code ResultSet} open, you need to make sure that the
	 * stream is properly disposed of using {@code close()} or else you will get resource leaks. As {@link Stream}
	 * extends {@link AutoCloseable}, you can use it in a try-with-resources statement to automatically close it when
	 * you are done.
	 * 
	 * @return Stream of POs.
	 * @throws DBException 
	 */
	public <T extends PO> Stream<T> stream() throws DBException
	{
		String sql = buildSQL(null, true);

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement (sql, trxName);
			final PreparedStatement finalPstmt = pstmt;
			rs = createResultSet(pstmt);
			final ResultSet finalRS = rs;
			
			return StreamSupport.stream(new Spliterators.AbstractSpliterator<T>(
						Long.MAX_VALUE,Spliterator.ORDERED) {
					@Override
					public boolean tryAdvance(Consumer<? super T> action) {
						try {
							if(!finalRS.next()) return false;
							@SuppressWarnings("unchecked")
							final T newRec = (T)table.getPO(finalRS, trxName);
							action.accept(newRec);
							return true;
						} catch(SQLException ex) {
							log.log(Level.SEVERE, sql, ex);
							throw new DBException(ex, sql);
						}
					}
				}, false).onClose(() -> DB.close(finalRS, finalPstmt));
		}
		catch (SQLException e)
		{
			DB.close(rs, pstmt);
			log.log(Level.SEVERE, sql, e);
			throw new DBException(e, sql);
		}
	}

	/**
	 * Return an Iterator implementation to fetch one PO at a time. The implementation first retrieve
	 * all IDS that match the query criteria and issue sql query to fetch the PO when caller want to
	 * fetch the next PO. This minimize memory usage but it is slower than the list method.
	 * @return Iterator
	 * @throws DBException 
	 */
	public <T extends PO> Iterator<T> iterate() throws DBException
	{
		String[] keys = table.getKeyColumns();
		StringBuilder sqlBuffer = new StringBuilder(" SELECT ");
		for (int i = 0; i < keys.length; i++) {
			if (i > 0)
				sqlBuffer.append(", ");
			if (!joinClauseList.isEmpty())
				sqlBuffer.append(table.getTableName()).append(".");
			sqlBuffer.append(keys[i]);
		}
		sqlBuffer.append(" FROM ").append(table.getTableName());
		String sql = buildSQL(sqlBuffer, true);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Object[]> idList = new ArrayList<Object[]>();
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			rs = createResultSet(pstmt);
			while (rs.next ())
			{
				Object[] ids = new Object[keys.length];
				for (int i = 0; i < ids.length; i++) {
					ids[i] = rs.getObject(i+1);
				}
				idList.add(ids);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			throw new DBException(e, sql);
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return new POIterator<T>(table, idList, trxName);
	}
	
	/**
	 * Return a simple wrapper over a jdbc resultset. It is the caller responsibility to
	 * call the close method to release the underlying database resources.
	 * @return POResultSet
	 * @throws DBException 
	 */
	public <T extends PO> POResultSet<T> scroll() throws DBException
	{
		String sql = buildSQL(null, true);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		POResultSet<T> rsPO = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			rs = createResultSet(pstmt);
			rsPO = new POResultSet<T>(table, pstmt, rs, trxName);
			rsPO.setCloseOnError(true);
			return rsPO;
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			throw new DBException(e, sql);
		}
		finally
		{
			// If there was an error, then close the statement and resultset
			if (rsPO == null) {
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}
	}
	
	/**
	 * Build SQL SELECT statement.
	 * @param selectClause optional; if null the select statement will be built by {@link POInfo}
	 * @return final SQL
	 */
	private final String buildSQL(StringBuilder selectClause, boolean useOrderByClause)
	{
		if (selectClause == null)
		{
			POInfo info = POInfo.getPOInfo(this.ctx, table.getAD_Table_ID(), trxName);
			if (info == null)
			{
				throw new IllegalStateException("No POInfo found for AD_Table_ID="+table.getAD_Table_ID());
			}
			boolean isFullyQualified = !joinClauseList.isEmpty();
			if(virtualColumns == null)
				selectClause = info.buildSelect(isFullyQualified, noVirtualColumn);
			else
				selectClause = info.buildSelect(isFullyQualified, virtualColumns);
		}
		if (!joinClauseList.isEmpty()) 
		{
			for(String joinClause : joinClauseList)
			{
				selectClause.append(" ").append(joinClause);
			}
		}
		
		StringBuilder whereBuffer = new StringBuilder(); 
		if (!Util.isEmpty(this.whereClause, true))
		{
			if (whereBuffer.length() > 0)
				whereBuffer.append(" AND ");
			whereBuffer.append("(").append(this.whereClause).append(")");
		}
		if (this.onlyActiveRecords)
		{
			if (whereBuffer.length() > 0)
				whereBuffer.append(" AND ");
			if (!joinClauseList.isEmpty())
				whereBuffer.append(table.getTableName()).append(".");
			whereBuffer.append("IsActive=?");
		}
		if (this.onlyClient_ID) //red1
		{
			if (whereBuffer.length() > 0)
				whereBuffer.append(" AND ");
			if (!joinClauseList.isEmpty())
				whereBuffer.append(table.getTableName()).append(".");
			whereBuffer.append("AD_Client_ID=?");
		}
		if (this.onlySelection_ID > 0)
		{
			String[] keys = table.getKeyColumns();
			if (keys.length != 1)
			{
				throw new DBException("Table "+table+" has 0 or more than 1 key columns");
			}
			//
			if (whereBuffer.length() > 0)
				whereBuffer.append(" AND ");
			whereBuffer.append(" EXISTS (SELECT 1 FROM T_Selection s WHERE s.AD_PInstance_ID=?"
					+" AND s.T_Selection_ID="+table.getTableName()+"."+keys[0]+")");
		}
		
		StringBuilder sqlBuffer = new StringBuilder(selectClause);
		if (whereBuffer.length() > 0)
		{
			sqlBuffer.append(" WHERE ").append(whereBuffer);
		}
		if (useOrderByClause && !Util.isEmpty(orderBy, true))
		{
			sqlBuffer.append(" ORDER BY ").append(orderBy);
		}
		String sql = sqlBuffer.toString();
		if (applyAccessFilter)
		{
			MRole role = MRole.getDefault(this.ctx, false);
			sql = role.addAccessSQL(sql, table.getTableName(), applyAccessFilterFullyQualified, applyAccessFilterRW);
		}
		if (forUpdate) {
			sql = sql + " FOR UPDATE";
			if (DB.isPostgreSQL())
				sql = sql + " OF " + table.getTableName();
		}
		
		// If have pagination
        if (pageSize > 0 || recordsToSkip > 0) {
            sql = appendPagination(sql);
        }

        if (log.isLoggable(Level.FINEST))
            log.finest("TableName = " + table.getTableName() + "... SQL = " + sql); // red1 - to assist in debugging SQL

        return sql;
    }

    /**
     * Set the pagination of the query.
     * 
     * @param pPageSize
     *            Limit current query rows return.
     * 
     * @return current Query
     */
    public Query setPageSize(int pPageSize) {
        this.pageSize = pPageSize;
        return this;
    }

    /**
     * Set the pagination of the query.
     * 
     * @param pPageSize
     *            Limit current query rows return.
     * 
     * @param pPagesToSkip
     *            Number of pages will be skipped on query run. ZERO for first page
     * 
     * @return current Query
     */
    public Query setPage(int pPageSize, int pPagesToSkip) {
    	if (pPageSize > 0) {
            this.pageSize = pPageSize;
            this.recordsToSkip = pPagesToSkip * pageSize;
    	} else {
    		log.warning("Wrong PageSize <= 0");
    	}
        return this;
    }

    /**
     * Set the number of records to skip (a.k.a. OFFSET)
     * 
     * @param pRecordsToSkip
     *            Limit current query rows return.
     * 
     * @return current Query
     */
    public Query setRecordstoSkip(int pRecordsToSkip) {
        this.recordsToSkip = pRecordsToSkip;
        return this;
    }

    /**
     * If top is bigger than 0 set the pagination on query
     * 
     * @param query
     *            SQL String
     * @param pageSize
     *            number
     * @param skip
     *            number
     */
    private String appendPagination(String pQuery) {

        String query = pQuery;

        if (pageSize > 0 || recordsToSkip > 0) {
        	if (DB.getDatabase().isPagingSupported()) {
        		query = DB.getDatabase().addPagingSQL(query, recordsToSkip+1, pageSize <= 0 ? 0 : recordsToSkip + pageSize);
        	} else {
        		throw new IllegalArgumentException("Pagination not supported by database");
        	}
        }

        return query;
    }
	
	private final ResultSet createResultSet (PreparedStatement pstmt) throws SQLException
	{
		DB.setParameters(pstmt, parameters);
		int i = 1 + (parameters != null ? parameters.length : 0);
		
		if (this.onlyActiveRecords)
		{
			DB.setParameter(pstmt, i++, true);
			if (log.isLoggable(Level.FINEST)) log.finest("Parameter IsActive = Y");
		}
		if (this.onlyClient_ID)
		{
			int AD_Client_ID = Env.getAD_Client_ID(ctx);
			DB.setParameter(pstmt, i++, AD_Client_ID);
			if (log.isLoggable(Level.FINEST)) log.finest("Parameter AD_Client_ID = "+AD_Client_ID);
		}
		if (this.onlySelection_ID > 0)
		{
			DB.setParameter(pstmt, i++, this.onlySelection_ID);
			if (log.isLoggable(Level.FINEST)) log.finest("Parameter Selection AD_PInstance_ID = "+this.onlySelection_ID);
		}
		if (queryTimeout > 0)
		{
			pstmt.setQueryTimeout(queryTimeout);
		}
		return pstmt.executeQuery();
	}
	
	/**
	 * Get a Array with the IDs for this Query
	 * @return Get a Array with the IDs
	 */
	public int[] getIDs ()
	{
		String[] keys = table.getKeyColumns();
		if (keys.length != 1)
		{
			throw new DBException("Table "+table+" has 0 or more than 1 key columns");
		}

		StringBuilder selectClause = new StringBuilder("SELECT ");
		if (!joinClauseList.isEmpty())
			selectClause.append(table.getTableName()).append(".");
		selectClause.append(keys[0]);
		selectClause.append(" FROM ").append(table.getTableName());
		String sql = buildSQL(selectClause, true);
		
		ArrayList<Integer> list = new ArrayList<Integer>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			rs = createResultSet(pstmt);
			while (rs.next())
			{
				list.add(rs.getInt(1));
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//	Convert to array
		int[] retValue = new int[list.size()];
		for (int i = 0; i < retValue.length; i++)
		{
			retValue[i] = list.get(i);
		}
		return retValue;
	}	//	get_IDs

	/**
	 * Virtual columns to be included in the query.
	 * @param virtualColumns virtual column names
	 */
	public Query setVirtualColumns(String ... virtualColumns) {
		this.virtualColumns = virtualColumns;
		return this;
	}

}
