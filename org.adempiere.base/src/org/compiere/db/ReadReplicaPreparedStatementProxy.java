/**********************************************************************
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
* - Trek Global                                                       *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.compiere.db;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import javax.sql.RowSet;

import org.adempiere.exceptions.DBException;
import org.compiere.util.CCachedRowSet;
import org.compiere.util.CLogger;
import org.compiere.util.CStatementVO;
import org.compiere.util.DB;
import org.compiere.util.DBReadReplica;

/**
 * Read replica proxy for prepared statement 
 * @author Low Heng Sin
 */
public class ReadReplicaPreparedStatementProxy implements InvocationHandler {

	private boolean close = false;
	
	/**	Logger							*/
	protected transient CLogger			log = CLogger.getCLogger (getClass());
	/** Wrap prepared statement 		*/
	protected transient PreparedStatement p_stmt = null;
	/**	Value Object					*/
	protected CStatementVO				p_vo = null;
	
	/**
	 * 
	 * @param resultSetType
	 * @param resultSetConcurrency
	 * @param sql
	 */
	public ReadReplicaPreparedStatementProxy(int resultSetType, int resultSetConcurrency, String sql) {
		if (sql == null || sql.length() == 0)
			throw new IllegalArgumentException("sql required");

		p_vo = new CStatementVO(resultSetType, resultSetConcurrency, DB.getDatabase().convertStatement(sql));

		init();
	}
	
	/**
	 * Initialise the prepared statement wrapper object
	 */
	private void init() {
		try {
			Connection conn = DBReadReplica.getConnectionRO();
			if (conn != null) {
				p_stmt = conn.prepareStatement(p_vo.getSql(), p_vo.getResultSetType(), p_vo.getResultSetConcurrency());
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, p_vo.getSql(), e);
			throw new DBException(e);
		}
	}

	private RowSet getRowSet() 
	{
		if (log.isLoggable(Level.FINEST))
			log.finest("local_getRowSet");
		
		RowSet rowSet = null;
		ResultSet rs = null;
		try
		{
			rs = p_stmt.executeQuery();
			rowSet = CCachedRowSet.getRowSet(rs);						
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, p_vo.toString(), ex);
			throw new RuntimeException (ex);
		}		
		finally
		{
			DB.close(rs);
		}
		return rowSet;
	}

	@Override
	public Object invoke(Object obj, Method method, Object[] args)
			throws Throwable {
		String name = method.getName();		
		//handle special case	
		if (name.equals("executeQuery") || name.equals("executeUpdate") 
			|| name.equals("execute") || name.equals("addBatch")) {
			if (args != null && args.length > 0 && args[0] != null && args[0] instanceof String) {
				String sql = (String)args[0];
				p_vo.setSql(DB.getDatabase().convertStatement(sql));
				args[0] = p_vo.getSql();
			}
		} else if (name.equals("close") && (args == null || args.length == 0)) {
			close();
			return null;
		} else if (name.equals("getRowSet") && (args == null || args.length == 0)) {
			return getRowSet();
		} else if (name.equals("isClosed") && (args == null || args.length == 0)) {
			return close;
		} else if (name.equals("finalize") && (args == null || args.length == 0)) {
			if (p_stmt != null && !close) 
			{
				this.close();
			}
			return null;
		} else if (name.equals("getSql") && (args == null || args.length == 0)) {
			return getSql();
		} else if (name.equals("equals") && (args != null && args.length == 1)) {
			return equals(args[0]);
		}
		
		Method m = PreparedStatement.class.getMethod(name, method.getParameterTypes());
		try
		{
			return m.invoke(p_stmt, args);
		}
		catch (InvocationTargetException e)
		{
			throw DB.getSQLException(e);
		}
	}
	
	/**
	 * Close
	 * @throws SQLException
	 * @see java.sql.Statement#close()
	 */
	private void close () throws SQLException
	{
		if (close) return;
		
		if (p_stmt!=null)
		{
			try 
			{
	            p_stmt.close();
	        } catch (SQLException e) {
	            ;
	        }
			finally 
			{
				try 
				{
					DBReadReplica.closeReadReplicaStatement(p_stmt);
				} 
				catch (Exception e) 
				{
					;
				} 
				finally 
				{
					p_stmt = null;
					close = true;
				}
			}
		}
		else
		{
			close = true;
		}
	}	//	close
	
	/**
	 * 	Get Sql
	 *	@return sql
	 */
	public String getSql()
	{
		if (p_vo != null)
			return p_vo.getSql();
		return null;
	}
	
	/**
	 * 
	 * @return true if the wrapped prepared statement is valid
	 */
	public boolean isValid()
	{
		return p_stmt != null;
	}
}
