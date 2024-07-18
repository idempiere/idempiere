/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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
package org.compiere.db;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.logging.Level;

import javax.sql.RowSet;

import org.adempiere.exceptions.DBException;
import org.compiere.model.SystemProperties;
import org.compiere.util.CCachedRowSet;
import org.compiere.util.CLogger;
import org.compiere.util.CStatementVO;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Trx;
import org.idempiere.db.util.AutoCommitConnectionBroker;

/**
 * Dynamic proxy for the CStatement interface
 * @author Low Heng Sin
 */
public class StatementProxy implements InvocationHandler {

	protected Connection m_conn = null;
	
	private boolean close = false;
	
	/**	Logger							*/
	protected transient CLogger			log = CLogger.getCLogger (getClass());
	/** Used if local					*/
	protected transient Statement		p_stmt = null;
	/**	Value Object					*/
	protected CStatementVO				p_vo = null;

	/**
	 * @param resultSetType
	 * @param resultSetConcurrency
	 * @param trxName
	 */
	public StatementProxy(int resultSetType, int resultSetConcurrency, String trxName) {
		p_vo = new CStatementVO (resultSetType, resultSetConcurrency);
		p_vo.setTrxName(trxName);

		init();
	}
	
	/**
	 * @param vo
	 */
	public StatementProxy(CStatementVO vo) {
		p_vo = vo;
		init();
	}
	
	//for subclass
	protected StatementProxy() {}
	
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
		} else if (name.equals("commit") && (args == null || args.length == 0)) {
			commit();
			return null;
		} else if (name.equals("getSql") && (args == null || args.length == 0)) {
			return getSql();
		} else if (name.equals("equals") && (args != null && args.length == 1)) {
			return equals(args[0]);
		}
		
		String logSql = null;
		String logOperation = null;
		if (log.isLoggable(Level.FINE) && getSql() != null)
		{
			if (name.equals("executeUpdate") || name.equals("execute"))
			{
				logSql = getSql().toUpperCase();
				if (logSql.startsWith("UPDATE ")) {
					logSql = logSql.substring("UPDATE ".length()).trim();
					logOperation = "Update";
				} else if (logSql.startsWith("INSERT INTO ")) {
					logSql = logSql.substring("INSERT INTO ".length()).trim();
					logOperation = "Insert";
				} else if (logSql.startsWith("DELETE FROM ")) {
					logSql = logSql.substring("DELETE FROM ".length()).trim();
					logOperation = "Delete";
				}
				if (logOperation != null) {
					int idxspace = logSql.indexOf(' ');
					if (idxspace > 0)
						logSql = logSql.substring(0, logSql.indexOf(' '));
					if (log.isLoggable(Level.FINE)) log.fine((DisplayType.getDateFormat(DisplayType.DateTime)).format(new Date(System.currentTimeMillis()))+","+logOperation+","+logSql+","+(p_vo.getTrxName() != null ? p_vo.getTrxName() : "")+" (begin)");
				}
			}
		}
		Method m = p_stmt.getClass().getMethod(name, method.getParameterTypes());
		String nullTrxName = null;
		try
		{
			if (SystemProperties.isTraceNullTrxConnection() && p_vo.getTrxName() == null)
				nullTrxName = Trx.registerNullTrx();
			return m.invoke(p_stmt, args);
		}
		catch (InvocationTargetException e)
		{
			throw DB.getSQLException(e);
		}
		finally
		{
			if (nullTrxName != null && p_vo.getTrxName() == null)
				Trx.unregisterNullTrx(nullTrxName);
			if (log.isLoggable(Level.FINE) && logSql != null && logOperation != null)
			{
				log.fine((DisplayType.getDateFormat(DisplayType.DateTime)).format(new Date(System.currentTimeMillis()))+","+logOperation+","+logSql+","+(p_vo.getTrxName() != null ? p_vo.getTrxName() : "")+" (end)");
			}
		}
	}
	
	/**
	 * Initialise the statement wrapper object 
	 */
	protected void init()
	{
		try
		{
			Connection conn = null;
			Trx trx = p_vo.getTrxName() == null ? null : Trx.get(p_vo.getTrxName(), false);
			if (trx != null)
			{
				conn = trx.getConnection();
			}
			else
			{
				m_conn = AutoCommitConnectionBroker.getConnection();
				conn = m_conn;
			}
			if (conn == null)
				throw new DBException("No Connection");
			p_stmt = conn.createStatement(p_vo.getResultSetType(), p_vo.getResultSetConcurrency());
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "CStatement", e);
			throw new DBException(e);
		}
	}
	
	/**
	 * Close
	 * @throws SQLException
	 * @see java.sql.Statement#close()
	 */
	protected void close () throws SQLException
	{
		if (close) return;
		
		try {
	        DB.close(p_stmt);
		} finally {
			if (m_conn != null)
			{
				AutoCommitConnectionBroker.releaseConnection(m_conn);
			}
			m_conn = null;
			p_stmt = null;
			close = true;
		}
	}	//	close
	
	/**
	 * 	Execute the wrapped statement and return row set
	 * 	@return RowSet
	 * 	@throws SQLException
	 *  @see java.sql.PreparedStatement#executeQuery()
	 */
	protected RowSet getRowSet()
	{
		if (log.isLoggable(Level.FINEST))
			log.finest("getRowSet");
		RowSet rowSet = null;
		ResultSet rs = null;
		try
		{
			rs = p_stmt.executeQuery(p_vo.getSql());
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
			rs = null;
			DB.close(rowSet);
			rowSet = null;
		}
		return rowSet;
	}	//	getRowSet

	/**
	 * 	Commit (if local trx)
	 *	@throws SQLException
	 */
	private void commit() throws SQLException
	{
		if (m_conn != null && !m_conn.getAutoCommit())
		{
			m_conn.commit();
		}
	}	//	commit
	
	/**
	 * 	Get Sql
	 *	@return sql
	 */
	public String getSql()
	{
		if (p_vo != null)
			return p_vo.getSql();
		return null;
	}	//	getSql
}
