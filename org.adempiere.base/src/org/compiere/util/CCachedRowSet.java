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
package org.compiere.util;

import java.io.InputStream;
import java.io.Reader;
import java.io.Serializable;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Array;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.NClob;
import java.sql.Ref;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.RowId;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.SQLXML;
import java.sql.Savepoint;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Collection;
import java.util.Locale;
import java.util.Map;

import javax.sql.RowSet;
import javax.sql.RowSetEvent;
import javax.sql.RowSetListener;
import javax.sql.RowSetMetaData;
import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetProvider;
import javax.sql.rowset.RowSetWarning;
import javax.sql.rowset.spi.SyncProvider;
import javax.sql.rowset.spi.SyncProviderException;

import org.compiere.db.AdempiereDatabase;
import org.compiere.db.Database;


/**
 *	Adempiere Cached Row Set Implementation
 *	
 *  @author Jorg Janke
 *  @version $Id: CCachedRowSet.java,v 1.6 2006/07/30 00:54:36 jjanke Exp $
 */
public class CCachedRowSet implements RowSet, Serializable, Cloneable, CachedRowSet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -233983261449861555L;

	private CachedRowSet compositeCachedRowSet;
	/**
	 * 	Get Cached Row Set.
	 * 	Required due to Java Sun bug 393865
	 *	@return Cached Row Set
	 *	@throws SQLException
	 */
	public synchronized static CCachedRowSet get() throws SQLException
	{
		CCachedRowSet crs = null;
		//	only first time call
		if (s_loc == null)
		{
			s_loc = Locale.getDefault();
			Locale.setDefault(Locale.US);
			crs = new CCachedRowSet();
			Locale.setDefault(s_loc);
		}
		else
			crs = new CCachedRowSet();
		//
		return crs;
	}	//	get
	
	/**
	 * 	Get Row Set.
	 * 	Read-Only, Scroll Insensitive
	 * 	Need to set parameters and call  execute(Commection)
	 *	@param sql sql
	 *	@return row set
	 *	@throws SQLException
	 */
	public static RowSet getRowSet (String sql) throws SQLException
	{
		CachedRowSet crs = get();
		crs.setConcurrency(ResultSet.CONCUR_READ_ONLY);
		crs.setType(ResultSet.TYPE_SCROLL_INSENSITIVE);
		crs.setCommand(sql);
		//	Set Parameters
	//	crs.execute(conn);
		return crs;
	}	//	get

	/**
	 * 	Get and Execute Row Set.
	 * 	No parameters, Read-Only, Scroll Insensitive
	 *	@param sql sql
	 *	@param conn connection
	 *	@param db database
	 *	@return row set
	 *	@throws SQLException
	 */
	public static RowSet getRowSet (String sql, Connection conn, AdempiereDatabase db) throws SQLException
	{
		if (db.getName().equals(Database.DB_ORACLE))
		{
			Statement stmt = null;
			ResultSet rs = null;
			try 
			{
				stmt = conn.createStatement
						(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				rs = stmt.executeQuery(sql);
				CachedRowSet crs = RowSetProvider.newFactory().createCachedRowSet();
				crs.populate(rs);
				return crs;
			} catch (SQLException e) 
			{
				throw e;
			}
			finally
			{				
				DB.close(rs, stmt);
				rs = null;
				stmt = null;
			}
		}
		CachedRowSet crs = get();
		crs.setConcurrency(ResultSet.CONCUR_READ_ONLY);
		crs.setType(ResultSet.TYPE_SCROLL_INSENSITIVE);
		crs.setCommand(sql);
		crs.execute(conn);
		return crs;
	}	//	get
	
	/**
	 * 	Get Cached Row Set.
	 * 	Required due to Java Sun bug 393865. 
	 * 	Also, Oracle NUMBER returns scale -127 
	 * 	@param rs result set
	 * 	@param db database 
	 *	@return Cached Row Set
	 *	@throws SQLException
	 */
	public static RowSet getRowSet (ResultSet rs, AdempiereDatabase db) throws SQLException
	{
		if (db.getName().equals(Database.DB_ORACLE))
		{
			CachedRowSet crs = RowSetProvider.newFactory().createCachedRowSet();
			crs.populate(rs);
			return crs;
		}
		CachedRowSet crs = get();
		crs.populate(rs);
		return crs;
	}	//	getRowSet
	
	/**
	 * 	Get Cached Row Set.
	 * 	Gets Database from DB
	 * 	Required due to Java Sun bug 393865. 
	 * 	Also, Oracle NUMBER returns scale -127 
	 * 	@param rs result set
	 *	@return Cached Row Set
	 *	@throws SQLException
	 */
	public static RowSet getRowSet (ResultSet rs) throws SQLException
	{
		return getRowSet(rs, DB.getDatabase());
	}	//	getRowSet

	
	/**	Private Locale Marker	*/
	private static Locale s_loc = null;
	
	
	/**************************************************************************
	 * 	Adempiere Cached RowSet
	 *	@throws java.sql.SQLException
	 */
	private CCachedRowSet() throws SQLException
	{
		compositeCachedRowSet = RowSetProvider.newFactory().createCachedRowSet();
		
		setSyncProvider("com.sun.rowset.providers.RIOptimisticProvider");
	}	//	CCachedRowSet

	
	/**************************************************************************
	 * 	Test
	 *	@param args ignored
	 */
	public static void main (String[] args)
	{
		CachedRowSet rs = null;
		try
		{
			Locale.setDefault(Locale.CANADA);
			get();
			System.out.println("OK 1");
			get();
			System.out.println("OK 1a");
			rs = RowSetProvider.newFactory().createCachedRowSet();
			System.out.println("OK 2");
		}
		catch (Exception e)
		{
			e.printStackTrace();
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
		}
	}	//	main

	@Override
	public int getInt(int idx) throws SQLException {
		//CachedRowSetImpl throw null pointer exception converting 
		//decimal value to integer
		try {
			return compositeCachedRowSet.getInt(idx);
		} catch (NullPointerException e) {
			String s = getString(idx);
			if ( s == null ) return 0;
			return Double.valueOf(s).intValue();
		}
	}

	@Override
	public int getInt(String column) throws SQLException {
		//CachedRowSetImpl throw null pointer exception converting 
		//decimal value to integer
		try {
			return compositeCachedRowSet.getInt(column);
		} catch (NullPointerException e) {
			String s = getString(column);
			if ( s == null ) return 0;
			return Double.valueOf(s).intValue();
		}	
	}
	
	@Override
	public String getUrl() throws SQLException  {
		return compositeCachedRowSet.getUrl();
	}

	@Override
	public void setUrl(String url) throws SQLException  {
		compositeCachedRowSet.setUrl(url);
	}

	@Override
	public String getDataSourceName()  {
		return compositeCachedRowSet.getDataSourceName();
	}

	@Override
	public void setDataSourceName(String name) throws SQLException  {
		compositeCachedRowSet.setDataSourceName(name);
	}

	@Override
	public String getUsername()  {
		return compositeCachedRowSet.getUsername();
	}

	@Override
	public void setUsername(String name) throws SQLException  {
		compositeCachedRowSet.setUsername(name);
	}

	@Override
	public String getPassword()  {
		return compositeCachedRowSet.getPassword();
	}

	@Override
	public void setPassword(String password) throws SQLException  {
		compositeCachedRowSet.setPassword(password);
	}

	@Override
	public int getTransactionIsolation()  {
		return compositeCachedRowSet.getTransactionIsolation();
	}

	@Override
	public void setTransactionIsolation(int level) throws SQLException  {
		compositeCachedRowSet.setTransactionIsolation(level);
	}

	@Override
	public Map<String, Class<?>> getTypeMap() throws SQLException {
		return compositeCachedRowSet.getTypeMap();
	}

	@Override
	public void setTypeMap(Map<String, Class<?>> map) throws SQLException  {
		compositeCachedRowSet.setTypeMap(map);
	}

	@Override
	public String getCommand()  {
		return compositeCachedRowSet.getCommand();
	}

	@Override
	public void setCommand(String cmd) throws SQLException  {
		compositeCachedRowSet.setCommand(cmd);
	}

	@Override
	public boolean isReadOnly()  {
		return compositeCachedRowSet.isReadOnly();
	}

	@Override
	public void setReadOnly(boolean value) throws SQLException  {
		compositeCachedRowSet.setReadOnly(value);
	}

	@Override
	public int getMaxFieldSize() throws SQLException  {
		return compositeCachedRowSet.getMaxFieldSize();
	}

	@Override
	public void setMaxFieldSize(int max) throws SQLException  {
		compositeCachedRowSet.setMaxFieldSize(max);
	}

	@Override
	public int getMaxRows() throws SQLException  {
		return compositeCachedRowSet.getMaxRows();
	}

	@Override
	public void setMaxRows(int max) throws SQLException  {
		compositeCachedRowSet.setMaxRows(max);
	}

	@Override
	public boolean getEscapeProcessing() throws SQLException  {
		return compositeCachedRowSet.getEscapeProcessing();
	}

	@Override
	public void setEscapeProcessing(boolean enable) throws SQLException  {
		compositeCachedRowSet.setEscapeProcessing(enable);
	}

	@Override
	public int getQueryTimeout() throws SQLException  {
		return compositeCachedRowSet.getQueryTimeout();
	}

	@Override
	public void setQueryTimeout(int seconds) throws SQLException  {
		compositeCachedRowSet.setQueryTimeout(seconds);
	}

	@Override
	public void setType(int type) throws SQLException  {
		compositeCachedRowSet.setType(type);
	}

	@Override
	public void setConcurrency(int concurrency) throws SQLException  {
		compositeCachedRowSet.setConcurrency(concurrency);
	}

	@Override
	public void setNull(int parameterIndex, int sqlType) throws SQLException  {
		compositeCachedRowSet.setNull(parameterIndex, sqlType);
	}

	@Override
	public void setNull(String parameterName, int sqlType) throws SQLException  {
		compositeCachedRowSet.setNull(parameterName, sqlType);
	}

	@Override
	public void setNull(int paramIndex, int sqlType, String typeName) throws SQLException  {
		compositeCachedRowSet.setNull(paramIndex, sqlType, typeName);
	}

	@Override
	public void setNull(String parameterName, int sqlType, String typeName) throws SQLException  {
		compositeCachedRowSet.setNull(parameterName, sqlType, typeName);
	}

	@Override
	public void setBoolean(int parameterIndex, boolean x) throws SQLException  {
		compositeCachedRowSet.setBoolean(parameterIndex, x);
	}

	@Override
	public void setBoolean(String parameterName, boolean x) throws SQLException  {
		compositeCachedRowSet.setBoolean(parameterName, x);
	}

	@Override
	public void setByte(int parameterIndex, byte x) throws SQLException  {
		compositeCachedRowSet.setByte(parameterIndex, x);
	}

	@Override
	public void setByte(String parameterName, byte x) throws SQLException  {
		compositeCachedRowSet.setByte(parameterName, x);
	}

	@Override
	public void setShort(int parameterIndex, short x) throws SQLException  {
		compositeCachedRowSet.setShort(parameterIndex, x);
	}

	@Override
	public void setShort(String parameterName, short x) throws SQLException  {
		compositeCachedRowSet.setShort(parameterName, x);
	}

	@Override
	public void setInt(int parameterIndex, int x) throws SQLException  {
		compositeCachedRowSet.setInt(parameterIndex, x);
	}

	@Override
	public void setInt(String parameterName, int x) throws SQLException  {
		compositeCachedRowSet.setInt(parameterName, x);
	}

	@Override
	public void setLong(int parameterIndex, long x) throws SQLException  {
		compositeCachedRowSet.setLong(parameterIndex, x);
	}

	@Override
	public void setLong(String parameterName, long x) throws SQLException  {
		compositeCachedRowSet.setLong(parameterName, x);
	}

	@Override
	public void setFloat(int parameterIndex, float x) throws SQLException  {
		compositeCachedRowSet.setFloat(parameterIndex, x);
	}

	@Override
	public void setFloat(String parameterName, float x) throws SQLException  {
		compositeCachedRowSet.setFloat(parameterName, x);
	}

	@Override
	public void setDouble(int parameterIndex, double x) throws SQLException  {
		compositeCachedRowSet.setDouble(parameterIndex, x);
	}

	@Override
	public void setDouble(String parameterName, double x) throws SQLException  {
		compositeCachedRowSet.setDouble(parameterName, x);
	}

	@Override
	public void setBigDecimal(int parameterIndex, BigDecimal x) throws SQLException  {
		compositeCachedRowSet.setBigDecimal(parameterIndex, x);
	}

	@Override
	public void setBigDecimal(String parameterName, BigDecimal x) throws SQLException  {
		compositeCachedRowSet.setBigDecimal(parameterName, x);
	}

	@Override
	public void setString(int parameterIndex, String x) throws SQLException  {
		compositeCachedRowSet.setString(parameterIndex, x);
	}

	@Override
	public void setString(String parameterName, String x) throws SQLException  {
		compositeCachedRowSet.setString(parameterName, x);
	}

	@Override
	public void setBytes(int parameterIndex, byte[] x) throws SQLException  {
		compositeCachedRowSet.setBytes(parameterIndex, x);
	}

	@Override
	public void setBytes(String parameterName, byte[] x) throws SQLException  {
		compositeCachedRowSet.setBytes(parameterName, x);
	}

	@Override
	public void setDate(int parameterIndex, Date x) throws SQLException  {
		compositeCachedRowSet.setDate(parameterIndex, x);
	}

	@Override
	public void setTime(int parameterIndex, Time x) throws SQLException  {
		compositeCachedRowSet.setTime(parameterIndex, x);
	}

	@Override
	public void setTimestamp(int parameterIndex, Timestamp x) throws SQLException  {
		compositeCachedRowSet.setTimestamp(parameterIndex, x);
	}

	@Override
	public void setTimestamp(String parameterName, Timestamp x) throws SQLException  {
		compositeCachedRowSet.setTimestamp(parameterName, x);
	}

	@Override
	public void setAsciiStream(int parameterIndex, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.setAsciiStream(parameterIndex, x, length);
	}

	@Override
	public void setAsciiStream(String parameterName, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.setAsciiStream(parameterName, x, length);
	}

	@Override
	public void setBinaryStream(int parameterIndex, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.setBinaryStream(parameterIndex, x, length);
	}

	@Override
	public void setBinaryStream(String parameterName, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.setBinaryStream(parameterName, x, length);
	}

	@Override
	public void setCharacterStream(int parameterIndex, Reader reader, int length) throws SQLException  {
		compositeCachedRowSet.setCharacterStream(parameterIndex, reader, length);
	}

	@Override
	public void setCharacterStream(String parameterName, Reader reader, int length) throws SQLException  {
		compositeCachedRowSet.setCharacterStream(parameterName, reader, length);
	}

	@Override
	public void setAsciiStream(int parameterIndex, InputStream x) throws SQLException  {
		compositeCachedRowSet.setAsciiStream(parameterIndex, x);
	}

	@Override
	public void setAsciiStream(String parameterName, InputStream x) throws SQLException  {
		compositeCachedRowSet.setAsciiStream(parameterName, x);
	}

	@Override
	public void setBinaryStream(int parameterIndex, InputStream x) throws SQLException  {
		compositeCachedRowSet.setBinaryStream(parameterIndex, x);
	}

	@Override
	public void setBinaryStream(String parameterName, InputStream x) throws SQLException  {
		compositeCachedRowSet.setBinaryStream(parameterName, x);
	}

	@Override
	public void setCharacterStream(int parameterIndex, Reader reader) throws SQLException  {
		compositeCachedRowSet.setCharacterStream(parameterIndex, reader);
	}

	@Override
	public void setCharacterStream(String parameterName, Reader reader) throws SQLException  {
		compositeCachedRowSet.setCharacterStream(parameterName, reader);
	}

	@Override
	public void setNCharacterStream(int parameterIndex, Reader value) throws SQLException  {
		compositeCachedRowSet.setNCharacterStream(parameterIndex, value);
	}

	@Override
	public void setObject(int parameterIndex, Object x, int targetSqlType, int scaleOrLength) throws SQLException  {
		compositeCachedRowSet.setObject(parameterIndex, x, targetSqlType, scaleOrLength);
	}

	@Override
	public void setObject(String parameterName, Object x, int targetSqlType, int scale) throws SQLException  {
		compositeCachedRowSet.setObject(parameterName, x, targetSqlType, scale);
	}

	@Override
	public void setObject(int parameterIndex, Object x, int targetSqlType) throws SQLException  {
		compositeCachedRowSet.setObject(parameterIndex, x, targetSqlType);
	}

	@Override
	public void setObject(String parameterName, Object x, int targetSqlType) throws SQLException  {
		compositeCachedRowSet.setObject(parameterName, x, targetSqlType);
	}

	@Override
	public void setObject(String parameterName, Object x) throws SQLException  {
		compositeCachedRowSet.setObject(parameterName, x);
	}

	@Override
	public void setObject(int parameterIndex, Object x) throws SQLException  {
		compositeCachedRowSet.setObject(parameterIndex, x);
	}

	@Override
	public void setRef(int i, Ref x) throws SQLException  {
		compositeCachedRowSet.setRef(i, x);
	}

	@Override
	public void setBlob(int i, Blob x) throws SQLException  {
		compositeCachedRowSet.setBlob(i, x);
	}

	@Override
	public void setBlob(int parameterIndex, InputStream inputStream, long length) throws SQLException  {
		compositeCachedRowSet.setBlob(parameterIndex, inputStream, length);
	}

	@Override
	public void setBlob(int parameterIndex, InputStream inputStream) throws SQLException  {
		compositeCachedRowSet.setBlob(parameterIndex, inputStream);
	}

	@Override
	public void setBlob(String parameterName, InputStream inputStream, long length) throws SQLException  {
		compositeCachedRowSet.setBlob(parameterName, inputStream, length);
	}

	@Override
	public void setBlob(String parameterName, Blob x) throws SQLException  {
		compositeCachedRowSet.setBlob(parameterName, x);
	}

	@Override
	public void setBlob(String parameterName, InputStream inputStream) throws SQLException  {
		compositeCachedRowSet.setBlob(parameterName, inputStream);
	}

	@Override
	public void setClob(int i, Clob x) throws SQLException  {
		compositeCachedRowSet.setClob(i, x);
	}

	@Override
	public void setClob(int parameterIndex, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.setClob(parameterIndex, reader, length);
	}

	@Override
	public void setClob(int parameterIndex, Reader reader) throws SQLException  {
		compositeCachedRowSet.setClob(parameterIndex, reader);
	}

	@Override
	public void setClob(String parameterName, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.setClob(parameterName, reader, length);
	}

	@Override
	public void setClob(String parameterName, Clob x) throws SQLException  {
		compositeCachedRowSet.setClob(parameterName, x);
	}

	@Override
	public void setClob(String parameterName, Reader reader) throws SQLException  {
		compositeCachedRowSet.setClob(parameterName, reader);
	}

	@Override
	public void setArray(int i, Array x) throws SQLException  {
		compositeCachedRowSet.setArray(i, x);
	}

	@Override
	public void setDate(int parameterIndex, Date x, Calendar cal) throws SQLException  {
		compositeCachedRowSet.setDate(parameterIndex, x, cal);
	}

	@Override
	public void setDate(String parameterName, Date x) throws SQLException  {
		compositeCachedRowSet.setDate(parameterName, x);
	}

	@Override
	public void setDate(String parameterName, Date x, Calendar cal) throws SQLException  {
		compositeCachedRowSet.setDate(parameterName, x, cal);
	}

	@Override
	public void setTime(int parameterIndex, Time x, Calendar cal) throws SQLException  {
		compositeCachedRowSet.setTime(parameterIndex, x, cal);
	}

	@Override
	public void setTime(String parameterName, Time x) throws SQLException  {
		compositeCachedRowSet.setTime(parameterName, x);
	}

	@Override
	public void setTime(String parameterName, Time x, Calendar cal) throws SQLException  {
		compositeCachedRowSet.setTime(parameterName, x, cal);
	}

	@Override
	public void setTimestamp(int parameterIndex, Timestamp x, Calendar cal) throws SQLException  {
		compositeCachedRowSet.setTimestamp(parameterIndex, x, cal);
	}

	@Override
	public void setTimestamp(String parameterName, Timestamp x, Calendar cal) throws SQLException  {
		compositeCachedRowSet.setTimestamp(parameterName, x, cal);
	}

	@Override
	public void clearParameters() throws SQLException  {
		compositeCachedRowSet.clearParameters();
	}

	@Override
	public void execute() throws SQLException  {
		compositeCachedRowSet.execute();
	}

	@Override
	public void addRowSetListener(RowSetListener listener)  {
		compositeCachedRowSet.addRowSetListener(listener);
	}

	@Override
	public void removeRowSetListener(RowSetListener listener)  {
		compositeCachedRowSet.removeRowSetListener(listener);
	}

	@Override
	public void setSQLXML(int parameterIndex, SQLXML xmlObject) throws SQLException  {
		compositeCachedRowSet.setSQLXML(parameterIndex, xmlObject);
	}

	@Override
	public void setSQLXML(String parameterName, SQLXML xmlObject) throws SQLException  {
		compositeCachedRowSet.setSQLXML(parameterName, xmlObject);
	}

	@Override
	public void setRowId(int parameterIndex, RowId x) throws SQLException  {
		compositeCachedRowSet.setRowId(parameterIndex, x);
	}

	@Override
	public void setRowId(String parameterName, RowId x) throws SQLException  {
		compositeCachedRowSet.setRowId(parameterName, x);
	}

	@Override
	public void setNString(int parameterIndex, String value) throws SQLException  {
		compositeCachedRowSet.setNString(parameterIndex, value);
	}

	@Override
	public void setNString(String parameterName, String value) throws SQLException  {
		compositeCachedRowSet.setNString(parameterName, value);
	}

	@Override
	public void setNCharacterStream(int parameterIndex, Reader value, long length) throws SQLException  {
		compositeCachedRowSet.setNCharacterStream(parameterIndex, value, length);
	}

	@Override
	public void setNCharacterStream(String parameterName, Reader value, long length) throws SQLException  {
		compositeCachedRowSet.setNCharacterStream(parameterName, value, length);
	}

	@Override
	public void setNCharacterStream(String parameterName, Reader value) throws SQLException  {
		compositeCachedRowSet.setNCharacterStream(parameterName, value);
	}

	@Override
	public void setNClob(String parameterName, NClob value) throws SQLException  {
		compositeCachedRowSet.setNClob(parameterName, value);
	}

	@Override
	public void setNClob(String parameterName, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.setNClob(parameterName, reader, length);
	}

	@Override
	public void setNClob(String parameterName, Reader reader) throws SQLException  {
		compositeCachedRowSet.setNClob(parameterName, reader);
	}

	@Override
	public void setNClob(int parameterIndex, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.setNClob(parameterIndex, reader, length);
	}

	@Override
	public void setNClob(int parameterIndex, NClob value) throws SQLException  {
		compositeCachedRowSet.setNClob(parameterIndex, value);
	}

	@Override
	public void setNClob(int parameterIndex, Reader reader) throws SQLException  {
		compositeCachedRowSet.setNClob(parameterIndex, reader);
	}

	@Override
	public void setURL(int parameterIndex, URL x) throws SQLException  {
		compositeCachedRowSet.setURL(parameterIndex, x);
	}

	@Override
	public boolean next() throws SQLException  {
		return compositeCachedRowSet.next();
	}

	@Override
	public void close() throws SQLException  {
		compositeCachedRowSet.close();
	}

	@Override
	public boolean wasNull() throws SQLException  {
		return compositeCachedRowSet.wasNull();
	}

	@Override
	public String getString(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getString(columnIndex);
	}

	@Override
	public boolean getBoolean(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getBoolean(columnIndex);
	}

	@Override
	public byte getByte(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getByte(columnIndex);
	}

	@Override
	public short getShort(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getShort(columnIndex);
	}

	@Override
	public long getLong(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getLong(columnIndex);
	}

	@Override
	public float getFloat(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getFloat(columnIndex);
	}

	@Override
	public double getDouble(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getDouble(columnIndex);
	}

	@Override
	@Deprecated
	public BigDecimal getBigDecimal(int columnIndex, int scale) throws SQLException  {
		return compositeCachedRowSet.getBigDecimal(columnIndex, scale);
	}

	@Override
	public byte[] getBytes(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getBytes(columnIndex);
	}

	@Override
	public Date getDate(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getDate(columnIndex);
	}

	@Override
	public Time getTime(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getTime(columnIndex);
	}

	@Override
	public Timestamp getTimestamp(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getTimestamp(columnIndex);
	}

	@Override
	public InputStream getAsciiStream(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getAsciiStream(columnIndex);
	}

	@Override
	@Deprecated
	public InputStream getUnicodeStream(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getUnicodeStream(columnIndex);
	}

	@Override
	public InputStream getBinaryStream(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getBinaryStream(columnIndex);
	}

	@Override
	public String getString(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getString(columnLabel);
	}

	@Override
	public boolean getBoolean(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getBoolean(columnLabel);
	}

	@Override
	public byte getByte(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getByte(columnLabel);
	}

	@Override
	public short getShort(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getShort(columnLabel);
	}

	@Override
	public long getLong(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getLong(columnLabel);
	}

	@Override
	public float getFloat(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getFloat(columnLabel);
	}

	@Override
	public double getDouble(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getDouble(columnLabel);
	}

	@Override
	@Deprecated
	public BigDecimal getBigDecimal(String columnLabel, int scale) throws SQLException  {
		return compositeCachedRowSet.getBigDecimal(columnLabel, scale);
	}

	@Override
	public byte[] getBytes(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getBytes(columnLabel);
	}

	@Override
	public Date getDate(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getDate(columnLabel);
	}

	@Override
	public Time getTime(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getTime(columnLabel);
	}

	@Override
	public Timestamp getTimestamp(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getTimestamp(columnLabel);
	}

	@Override
	public InputStream getAsciiStream(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getAsciiStream(columnLabel);
	}

	@Override
	@Deprecated
	public InputStream getUnicodeStream(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getUnicodeStream(columnLabel);
	}

	@Override
	public InputStream getBinaryStream(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getBinaryStream(columnLabel);
	}

	@Override
	public SQLWarning getWarnings() throws SQLException  {
		return compositeCachedRowSet.getWarnings();
	}

	@Override
	public void clearWarnings() throws SQLException  {
		compositeCachedRowSet.clearWarnings();
	}

	@Override
	public String getCursorName() throws SQLException  {
		return compositeCachedRowSet.getCursorName();
	}

	@Override
	public ResultSetMetaData getMetaData() throws SQLException  {
		return compositeCachedRowSet.getMetaData();
	}

	@Override
	public Object getObject(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getObject(columnIndex);
	}

	@Override
	public Object getObject(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getObject(columnLabel);
	}

	@Override
	public int findColumn(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.findColumn(columnLabel);
	}

	@Override
	public Reader getCharacterStream(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getCharacterStream(columnIndex);
	}

	@Override
	public Reader getCharacterStream(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getCharacterStream(columnLabel);
	}

	@Override
	public BigDecimal getBigDecimal(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getBigDecimal(columnIndex);
	}

	@Override
	public BigDecimal getBigDecimal(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getBigDecimal(columnLabel);
	}

	@Override
	public boolean isBeforeFirst() throws SQLException  {
		return compositeCachedRowSet.isBeforeFirst();
	}

	@Override
	public boolean isAfterLast() throws SQLException  {
		return compositeCachedRowSet.isAfterLast();
	}

	@Override
	public boolean isFirst() throws SQLException  {
		return compositeCachedRowSet.isFirst();
	}

	@Override
	public boolean isLast() throws SQLException  {
		return compositeCachedRowSet.isLast();
	}

	@Override
	public void beforeFirst() throws SQLException  {
		compositeCachedRowSet.beforeFirst();
	}

	@Override
	public void afterLast() throws SQLException  {
		compositeCachedRowSet.afterLast();
	}

	@Override
	public boolean first() throws SQLException  {
		return compositeCachedRowSet.first();
	}

	@Override
	public boolean last() throws SQLException  {
		return compositeCachedRowSet.last();
	}

	@Override
	public int getRow() throws SQLException  {
		return compositeCachedRowSet.getRow();
	}

	@Override
	public boolean absolute(int row) throws SQLException  {
		return compositeCachedRowSet.absolute(row);
	}

	@Override
	public boolean relative(int rows) throws SQLException  {
		return compositeCachedRowSet.relative(rows);
	}

	@Override
	public boolean previous() throws SQLException  {
		return compositeCachedRowSet.previous();
	}

	@Override
	public void setFetchDirection(int direction) throws SQLException  {
		compositeCachedRowSet.setFetchDirection(direction);
	}

	@Override
	public int getFetchDirection() throws SQLException  {
		return compositeCachedRowSet.getFetchDirection();
	}

	@Override
	public void setFetchSize(int rows) throws SQLException  {
		compositeCachedRowSet.setFetchSize(rows);
	}

	@Override
	public int getFetchSize() throws SQLException  {
		return compositeCachedRowSet.getFetchSize();
	}

	@Override
	public int getType() throws SQLException  {
		return compositeCachedRowSet.getType();
	}

	@Override
	public int getConcurrency() throws SQLException  {
		return compositeCachedRowSet.getConcurrency();
	}

	@Override
	public boolean rowUpdated() throws SQLException  {
		return compositeCachedRowSet.rowUpdated();
	}

	@Override
	public boolean rowInserted() throws SQLException  {
		return compositeCachedRowSet.rowInserted();
	}

	@Override
	public boolean rowDeleted() throws SQLException  {
		return compositeCachedRowSet.rowDeleted();
	}

	@Override
	public void updateNull(int columnIndex) throws SQLException  {
		compositeCachedRowSet.updateNull(columnIndex);
	}

	@Override
	public void updateBoolean(int columnIndex, boolean x) throws SQLException  {
		compositeCachedRowSet.updateBoolean(columnIndex, x);
	}

	@Override
	public void updateByte(int columnIndex, byte x) throws SQLException  {
		compositeCachedRowSet.updateByte(columnIndex, x);
	}

	@Override
	public void updateShort(int columnIndex, short x) throws SQLException  {
		compositeCachedRowSet.updateShort(columnIndex, x);
	}

	@Override
	public void updateInt(int columnIndex, int x) throws SQLException  {
		compositeCachedRowSet.updateInt(columnIndex, x);
	}

	@Override
	public void updateLong(int columnIndex, long x) throws SQLException  {
		compositeCachedRowSet.updateLong(columnIndex, x);
	}

	@Override
	public void updateFloat(int columnIndex, float x) throws SQLException  {
		compositeCachedRowSet.updateFloat(columnIndex, x);
	}

	@Override
	public void updateDouble(int columnIndex, double x) throws SQLException  {
		compositeCachedRowSet.updateDouble(columnIndex, x);
	}

	@Override
	public void updateBigDecimal(int columnIndex, BigDecimal x) throws SQLException  {
		compositeCachedRowSet.updateBigDecimal(columnIndex, x);
	}

	@Override
	public void updateString(int columnIndex, String x) throws SQLException  {
		compositeCachedRowSet.updateString(columnIndex, x);
	}

	@Override
	public void updateBytes(int columnIndex, byte[] x) throws SQLException  {
		compositeCachedRowSet.updateBytes(columnIndex, x);
	}

	@Override
	public void updateDate(int columnIndex, Date x) throws SQLException  {
		compositeCachedRowSet.updateDate(columnIndex, x);
	}

	@Override
	public void updateTime(int columnIndex, Time x) throws SQLException  {
		compositeCachedRowSet.updateTime(columnIndex, x);
	}

	@Override
	public void updateTimestamp(int columnIndex, Timestamp x) throws SQLException  {
		compositeCachedRowSet.updateTimestamp(columnIndex, x);
	}

	@Override
	public void updateAsciiStream(int columnIndex, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.updateAsciiStream(columnIndex, x, length);
	}

	@Override
	public void updateBinaryStream(int columnIndex, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.updateBinaryStream(columnIndex, x, length);
	}

	@Override
	public void updateCharacterStream(int columnIndex, Reader x, int length) throws SQLException  {
		compositeCachedRowSet.updateCharacterStream(columnIndex, x, length);
	}

	@Override
	public void updateObject(int columnIndex, Object x, int scaleOrLength) throws SQLException  {
		compositeCachedRowSet.updateObject(columnIndex, x, scaleOrLength);
	}

	@Override
	public void updateObject(int columnIndex, Object x) throws SQLException  {
		compositeCachedRowSet.updateObject(columnIndex, x);
	}

	@Override
	public void updateNull(String columnLabel) throws SQLException  {
		compositeCachedRowSet.updateNull(columnLabel);
	}

	@Override
	public void updateBoolean(String columnLabel, boolean x) throws SQLException  {
		compositeCachedRowSet.updateBoolean(columnLabel, x);
	}

	@Override
	public void updateByte(String columnLabel, byte x) throws SQLException  {
		compositeCachedRowSet.updateByte(columnLabel, x);
	}

	@Override
	public void updateShort(String columnLabel, short x) throws SQLException  {
		compositeCachedRowSet.updateShort(columnLabel, x);
	}

	@Override
	public void updateInt(String columnLabel, int x) throws SQLException  {
		compositeCachedRowSet.updateInt(columnLabel, x);
	}

	@Override
	public void updateLong(String columnLabel, long x) throws SQLException  {
		compositeCachedRowSet.updateLong(columnLabel, x);
	}

	@Override
	public void updateFloat(String columnLabel, float x) throws SQLException  {
		compositeCachedRowSet.updateFloat(columnLabel, x);
	}

	@Override
	public void updateDouble(String columnLabel, double x) throws SQLException  {
		compositeCachedRowSet.updateDouble(columnLabel, x);
	}

	@Override
	public void updateBigDecimal(String columnLabel, BigDecimal x) throws SQLException  {
		compositeCachedRowSet.updateBigDecimal(columnLabel, x);
	}

	@Override
	public void updateString(String columnLabel, String x) throws SQLException  {
		compositeCachedRowSet.updateString(columnLabel, x);
	}

	@Override
	public void updateBytes(String columnLabel, byte[] x) throws SQLException  {
		compositeCachedRowSet.updateBytes(columnLabel, x);
	}

	@Override
	public void updateDate(String columnLabel, Date x) throws SQLException  {
		compositeCachedRowSet.updateDate(columnLabel, x);
	}

	@Override
	public void updateTime(String columnLabel, Time x) throws SQLException  {
		compositeCachedRowSet.updateTime(columnLabel, x);
	}

	@Override
	public void updateTimestamp(String columnLabel, Timestamp x) throws SQLException  {
		compositeCachedRowSet.updateTimestamp(columnLabel, x);
	}

	@Override
	public void updateAsciiStream(String columnLabel, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.updateAsciiStream(columnLabel, x, length);
	}

	@Override
	public void updateBinaryStream(String columnLabel, InputStream x, int length) throws SQLException  {
		compositeCachedRowSet.updateBinaryStream(columnLabel, x, length);
	}

	@Override
	public void updateCharacterStream(String columnLabel, Reader reader, int length) throws SQLException  {
		compositeCachedRowSet.updateCharacterStream(columnLabel, reader, length);
	}

	@Override
	public void updateObject(String columnLabel, Object x, int scaleOrLength) throws SQLException  {
		compositeCachedRowSet.updateObject(columnLabel, x, scaleOrLength);
	}

	@Override
	public void updateObject(String columnLabel, Object x) throws SQLException  {
		compositeCachedRowSet.updateObject(columnLabel, x);
	}

	@Override
	public void insertRow() throws SQLException  {
		compositeCachedRowSet.insertRow();
	}

	@Override
	public void updateRow() throws SQLException  {
		compositeCachedRowSet.updateRow();
	}

	@Override
	public void deleteRow() throws SQLException  {
		compositeCachedRowSet.deleteRow();
	}

	@Override
	public void refreshRow() throws SQLException  {
		compositeCachedRowSet.refreshRow();
	}

	@Override
	public void cancelRowUpdates() throws SQLException  {
		compositeCachedRowSet.cancelRowUpdates();
	}

	@Override
	public void moveToInsertRow() throws SQLException  {
		compositeCachedRowSet.moveToInsertRow();
	}

	@Override
	public void moveToCurrentRow() throws SQLException  {
		compositeCachedRowSet.moveToCurrentRow();
	}

	@Override
	public Statement getStatement() throws SQLException  {
		return compositeCachedRowSet.getStatement();
	}

	@Override
	public Object getObject(int columnIndex, Map<String, Class<?>> map) throws SQLException  {
		return compositeCachedRowSet.getObject(columnIndex, map);
	}

	@Override
	public Ref getRef(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getRef(columnIndex);
	}

	@Override
	public Blob getBlob(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getBlob(columnIndex);
	}

	@Override
	public Clob getClob(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getClob(columnIndex);
	}

	@Override
	public Array getArray(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getArray(columnIndex);
	}

	@Override
	public Object getObject(String columnLabel, Map<String, Class<?>> map) throws SQLException  {
		return compositeCachedRowSet.getObject(columnLabel, map);
	}

	@Override
	public Ref getRef(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getRef(columnLabel);
	}

	@Override
	public Blob getBlob(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getBlob(columnLabel);
	}

	@Override
	public Clob getClob(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getClob(columnLabel);
	}

	@Override
	public Array getArray(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getArray(columnLabel);
	}

	@Override
	public Date getDate(int columnIndex, Calendar cal) throws SQLException  {
		return compositeCachedRowSet.getDate(columnIndex, cal);
	}

	@Override
	public Date getDate(String columnLabel, Calendar cal) throws SQLException  {
		return compositeCachedRowSet.getDate(columnLabel, cal);
	}

	@Override
	public Time getTime(int columnIndex, Calendar cal) throws SQLException  {
		return compositeCachedRowSet.getTime(columnIndex, cal);
	}

	@Override
	public Time getTime(String columnLabel, Calendar cal) throws SQLException  {
		return compositeCachedRowSet.getTime(columnLabel, cal);
	}

	@Override
	public Timestamp getTimestamp(int columnIndex, Calendar cal) throws SQLException  {
		return compositeCachedRowSet.getTimestamp(columnIndex, cal);
	}

	@Override
	public Timestamp getTimestamp(String columnLabel, Calendar cal) throws SQLException  {
		return compositeCachedRowSet.getTimestamp(columnLabel, cal);
	}

	@Override
	public URL getURL(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getURL(columnIndex);
	}

	@Override
	public URL getURL(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getURL(columnLabel);
	}

	@Override
	public void updateRef(int columnIndex, Ref x) throws SQLException  {
		compositeCachedRowSet.updateRef(columnIndex, x);
	}

	@Override
	public void updateRef(String columnLabel, Ref x) throws SQLException  {
		compositeCachedRowSet.updateRef(columnLabel, x);
	}

	@Override
	public void updateBlob(int columnIndex, Blob x) throws SQLException  {
		compositeCachedRowSet.updateBlob(columnIndex, x);
	}

	@Override
	public void updateBlob(String columnLabel, Blob x) throws SQLException  {
		compositeCachedRowSet.updateBlob(columnLabel, x);
	}

	@Override
	public void updateClob(int columnIndex, Clob x) throws SQLException  {
		compositeCachedRowSet.updateClob(columnIndex, x);
	}

	@Override
	public void updateClob(String columnLabel, Clob x) throws SQLException  {
		compositeCachedRowSet.updateClob(columnLabel, x);
	}

	@Override
	public void updateArray(int columnIndex, Array x) throws SQLException  {
		compositeCachedRowSet.updateArray(columnIndex, x);
	}

	@Override
	public void updateArray(String columnLabel, Array x) throws SQLException  {
		compositeCachedRowSet.updateArray(columnLabel, x);
	}

	@Override
	public RowId getRowId(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getRowId(columnIndex);
	}

	@Override
	public RowId getRowId(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getRowId(columnLabel);
	}

	@Override
	public void updateRowId(int columnIndex, RowId x) throws SQLException  {
		compositeCachedRowSet.updateRowId(columnIndex, x);
	}

	@Override
	public void updateRowId(String columnLabel, RowId x) throws SQLException  {
		compositeCachedRowSet.updateRowId(columnLabel, x);
	}

	@Override
	public int getHoldability() throws SQLException  {
		return compositeCachedRowSet.getHoldability();
	}

	@Override
	public boolean isClosed() throws SQLException  {
		return compositeCachedRowSet.isClosed();
	}

	@Override
	public void updateNString(int columnIndex, String nString) throws SQLException  {
		compositeCachedRowSet.updateNString(columnIndex, nString);
	}

	@Override
	public void updateNString(String columnLabel, String nString) throws SQLException  {
		compositeCachedRowSet.updateNString(columnLabel, nString);
	}

	@Override
	public void updateNClob(int columnIndex, NClob nClob) throws SQLException  {
		compositeCachedRowSet.updateNClob(columnIndex, nClob);
	}

	@Override
	public void updateNClob(String columnLabel, NClob nClob) throws SQLException  {
		compositeCachedRowSet.updateNClob(columnLabel, nClob);
	}

	@Override
	public NClob getNClob(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getNClob(columnIndex);
	}

	@Override
	public NClob getNClob(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getNClob(columnLabel);
	}

	@Override
	public SQLXML getSQLXML(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getSQLXML(columnIndex);
	}

	@Override
	public SQLXML getSQLXML(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getSQLXML(columnLabel);
	}

	@Override
	public void updateSQLXML(int columnIndex, SQLXML xmlObject) throws SQLException  {
		compositeCachedRowSet.updateSQLXML(columnIndex, xmlObject);
	}

	@Override
	public void updateSQLXML(String columnLabel, SQLXML xmlObject) throws SQLException  {
		compositeCachedRowSet.updateSQLXML(columnLabel, xmlObject);
	}

	@Override
	public String getNString(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getNString(columnIndex);
	}

	@Override
	public String getNString(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getNString(columnLabel);
	}

	@Override
	public Reader getNCharacterStream(int columnIndex) throws SQLException  {
		return compositeCachedRowSet.getNCharacterStream(columnIndex);
	}

	@Override
	public Reader getNCharacterStream(String columnLabel) throws SQLException  {
		return compositeCachedRowSet.getNCharacterStream(columnLabel);
	}

	@Override
	public void updateNCharacterStream(int columnIndex, Reader x, long length) throws SQLException  {
		compositeCachedRowSet.updateNCharacterStream(columnIndex, x, length);
	}

	@Override
	public void updateNCharacterStream(String columnLabel, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.updateNCharacterStream(columnLabel, reader, length);
	}

	@Override
	public void updateAsciiStream(int columnIndex, InputStream x, long length) throws SQLException  {
		compositeCachedRowSet.updateAsciiStream(columnIndex, x, length);
	}

	@Override
	public void updateBinaryStream(int columnIndex, InputStream x, long length) throws SQLException  {
		compositeCachedRowSet.updateBinaryStream(columnIndex, x, length);
	}

	@Override
	public void updateCharacterStream(int columnIndex, Reader x, long length) throws SQLException  {
		compositeCachedRowSet.updateCharacterStream(columnIndex, x, length);
	}

	@Override
	public void updateAsciiStream(String columnLabel, InputStream x, long length) throws SQLException  {
		compositeCachedRowSet.updateAsciiStream(columnLabel, x, length);
	}

	@Override
	public void updateBinaryStream(String columnLabel, InputStream x, long length) throws SQLException  {
		compositeCachedRowSet.updateBinaryStream(columnLabel, x, length);
	}

	@Override
	public void updateCharacterStream(String columnLabel, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.updateCharacterStream(columnLabel, reader, length);
	}

	@Override
	public void updateBlob(int columnIndex, InputStream inputStream, long length) throws SQLException  {
		compositeCachedRowSet.updateBlob(columnIndex, inputStream, length);
	}

	@Override
	public void updateBlob(String columnLabel, InputStream inputStream, long length) throws SQLException  {
		compositeCachedRowSet.updateBlob(columnLabel, inputStream, length);
	}

	@Override
	public void updateClob(int columnIndex, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.updateClob(columnIndex, reader, length);
	}

	@Override
	public void updateClob(String columnLabel, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.updateClob(columnLabel, reader, length);
	}

	@Override
	public void updateNClob(int columnIndex, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.updateNClob(columnIndex, reader, length);
	}

	@Override
	public void updateNClob(String columnLabel, Reader reader, long length) throws SQLException  {
		compositeCachedRowSet.updateNClob(columnLabel, reader, length);
	}

	@Override
	public void updateNCharacterStream(int columnIndex, Reader x) throws SQLException  {
		compositeCachedRowSet.updateNCharacterStream(columnIndex, x);
	}

	@Override
	public void updateNCharacterStream(String columnLabel, Reader reader) throws SQLException  {
		compositeCachedRowSet.updateNCharacterStream(columnLabel, reader);
	}

	@Override
	public void updateAsciiStream(int columnIndex, InputStream x) throws SQLException  {
		compositeCachedRowSet.updateAsciiStream(columnIndex, x);
	}

	@Override
	public void updateBinaryStream(int columnIndex, InputStream x) throws SQLException  {
		compositeCachedRowSet.updateBinaryStream(columnIndex, x);
	}

	@Override
	public void updateCharacterStream(int columnIndex, Reader x) throws SQLException  {
		compositeCachedRowSet.updateCharacterStream(columnIndex, x);
	}

	@Override
	public void updateAsciiStream(String columnLabel, InputStream x) throws SQLException  {
		compositeCachedRowSet.updateAsciiStream(columnLabel, x);
	}

	@Override
	public void updateBinaryStream(String columnLabel, InputStream x) throws SQLException  {
		compositeCachedRowSet.updateBinaryStream(columnLabel, x);
	}

	@Override
	public void updateCharacterStream(String columnLabel, Reader reader) throws SQLException  {
		compositeCachedRowSet.updateCharacterStream(columnLabel, reader);
	}

	@Override
	public void updateBlob(int columnIndex, InputStream inputStream) throws SQLException  {
		compositeCachedRowSet.updateBlob(columnIndex, inputStream);
	}

	@Override
	public void updateBlob(String columnLabel, InputStream inputStream) throws SQLException  {
		compositeCachedRowSet.updateBlob(columnLabel, inputStream);
	}

	@Override
	public void updateClob(int columnIndex, Reader reader) throws SQLException  {
		compositeCachedRowSet.updateClob(columnIndex, reader);
	}

	@Override
	public void updateClob(String columnLabel, Reader reader) throws SQLException  {
		compositeCachedRowSet.updateClob(columnLabel, reader);
	}

	@Override
	public void updateNClob(int columnIndex, Reader reader) throws SQLException  {
		compositeCachedRowSet.updateNClob(columnIndex, reader);
	}

	@Override
	public void updateNClob(String columnLabel, Reader reader) throws SQLException  {
		compositeCachedRowSet.updateNClob(columnLabel, reader);
	}

	@Override
	public <T> T getObject(int columnIndex, Class<T> type) throws SQLException {
		return compositeCachedRowSet.getObject(columnIndex, type);
	}

	@Override
	public <T> T getObject(String columnLabel, Class<T> type) throws SQLException {
		return compositeCachedRowSet.getObject(columnLabel, type);
	}

	@Override
	public <T> T unwrap(Class<T> iface) throws SQLException {
		return compositeCachedRowSet.unwrap(iface);
	}

	@Override
	public boolean isWrapperFor(Class<?> iface) throws SQLException  {
		return compositeCachedRowSet.isWrapperFor(iface);
	}

	@Override
	public void setMatchColumn(int columnIdx) throws SQLException  {
		compositeCachedRowSet.setMatchColumn(columnIdx);
	}

	@Override
	public void setMatchColumn(int[] columnIdxes) throws SQLException  {
		compositeCachedRowSet.setMatchColumn(columnIdxes);
	}

	@Override
	public void setMatchColumn(String columnName) throws SQLException  {
		compositeCachedRowSet.setMatchColumn(columnName);
	}

	@Override
	public void setMatchColumn(String[] columnNames) throws SQLException  {
		compositeCachedRowSet.setMatchColumn(columnNames);
	}

	@Override
	public int[] getMatchColumnIndexes() throws SQLException  {
		return compositeCachedRowSet.getMatchColumnIndexes();
	}

	@Override
	public String[] getMatchColumnNames() throws SQLException  {
		return compositeCachedRowSet.getMatchColumnNames();
	}

	@Override
	public void unsetMatchColumn(int columnIdx) throws SQLException  {
		compositeCachedRowSet.unsetMatchColumn(columnIdx);
	}

	@Override
	public void unsetMatchColumn(int[] columnIdxes) throws SQLException  {
		compositeCachedRowSet.unsetMatchColumn(columnIdxes);
	}

	@Override
	public void unsetMatchColumn(String columnName) throws SQLException  {
		compositeCachedRowSet.unsetMatchColumn(columnName);
	}

	@Override
	public void unsetMatchColumn(String[] columnName) throws SQLException  {
		compositeCachedRowSet.unsetMatchColumn(columnName);
	}

	@Override
	public void populate(ResultSet data) throws SQLException  {
		compositeCachedRowSet.populate(data);
	}

	@Override
	public void execute(Connection conn) throws SQLException  {
		compositeCachedRowSet.execute(conn);
	}

	@Override
	public void acceptChanges() throws SyncProviderException  {
		compositeCachedRowSet.acceptChanges();
	}

	@Override
	public void acceptChanges(Connection con) throws SyncProviderException  {
		compositeCachedRowSet.acceptChanges(con);
	}

	@Override
	public void restoreOriginal() throws SQLException  {
		compositeCachedRowSet.restoreOriginal();
	}

	@Override
	public void release() throws SQLException  {
		compositeCachedRowSet.release();
	}

	@Override
	public void undoDelete() throws SQLException  {
		compositeCachedRowSet.undoDelete();
	}

	@Override
	public void undoInsert() throws SQLException  {
		compositeCachedRowSet.undoInsert();
	}

	@Override
	public void undoUpdate() throws SQLException  {
		compositeCachedRowSet.undoUpdate();
	}

	@Override
	public boolean columnUpdated(int idx) throws SQLException  {
		return compositeCachedRowSet.columnUpdated(idx);
	}

	@Override
	public boolean columnUpdated(String columnName) throws SQLException  {
		return compositeCachedRowSet.columnUpdated(columnName);
	}

	@Override
	public Collection<?> toCollection() throws SQLException {
		return compositeCachedRowSet.toCollection();
	}

	@Override
	public Collection<?> toCollection(int column) throws SQLException {
		return compositeCachedRowSet.toCollection(column);
	}

	@Override
	public Collection<?> toCollection(String column) throws SQLException {
		return compositeCachedRowSet.toCollection(column);
	}

	@Override
	public SyncProvider getSyncProvider() throws SQLException  {
		return compositeCachedRowSet.getSyncProvider();
	}

	@Override
	public void setSyncProvider(String provider) throws SQLException  {
		compositeCachedRowSet.setSyncProvider(provider);
	}

	@Override
	public int size()  {
		return compositeCachedRowSet.size();
	}

	@Override
	public void setMetaData(RowSetMetaData md) throws SQLException  {
		compositeCachedRowSet.setMetaData(md);
	}

	@Override
	public ResultSet getOriginal() throws SQLException  {
		return compositeCachedRowSet.getOriginal();
	}

	@Override
	public ResultSet getOriginalRow() throws SQLException  {
		return compositeCachedRowSet.getOriginalRow();
	}

	@Override
	public void setOriginalRow() throws SQLException  {
		compositeCachedRowSet.setOriginalRow();
	}

	@Override
	public String getTableName() throws SQLException  {
		return compositeCachedRowSet.getTableName();
	}

	@Override
	public void setTableName(String tabName) throws SQLException  {
		compositeCachedRowSet.setTableName(tabName);
	}

	@Override
	public int[] getKeyColumns() throws SQLException  {
		return compositeCachedRowSet.getKeyColumns();
	}

	@Override
	public void setKeyColumns(int[] keys) throws SQLException  {
		compositeCachedRowSet.setKeyColumns(keys);
	}

	@Override
	public RowSet createShared() throws SQLException  {
		return compositeCachedRowSet.createShared();
	}

	@Override
	public CachedRowSet createCopy() throws SQLException  {
		return compositeCachedRowSet.createCopy();
	}

	@Override
	public CachedRowSet createCopySchema() throws SQLException  {
		return compositeCachedRowSet.createCopySchema();
	}

	@Override
	public CachedRowSet createCopyNoConstraints() throws SQLException  {
		return compositeCachedRowSet.createCopyNoConstraints();
	}

	@Override
	public RowSetWarning getRowSetWarnings() throws SQLException  {
		return compositeCachedRowSet.getRowSetWarnings();
	}

	@Override
	public boolean getShowDeleted() throws SQLException  {
		return compositeCachedRowSet.getShowDeleted();
	}

	@Override
	public void setShowDeleted(boolean b) throws SQLException  {
		compositeCachedRowSet.setShowDeleted(b);
	}

	@Override
	public void commit() throws SQLException  {
		compositeCachedRowSet.commit();
	}

	@Override
	public void rollback() throws SQLException  {
		compositeCachedRowSet.rollback();
	}

	@Override
	public void rollback(Savepoint s) throws SQLException  {
		compositeCachedRowSet.rollback(s);
	}

	@Override
	public void rowSetPopulated(RowSetEvent event, int numRows) throws SQLException  {
		compositeCachedRowSet.rowSetPopulated(event, numRows);
	}

	@Override
	public void populate(ResultSet rs, int startRow) throws SQLException  {
		compositeCachedRowSet.populate(rs, startRow);
	}

	@Override
	public void setPageSize(int size) throws SQLException  {
		compositeCachedRowSet.setPageSize(size);
	}

	@Override
	public int getPageSize()  {
		return compositeCachedRowSet.getPageSize();
	}

	@Override
	public boolean nextPage() throws SQLException  {
		return compositeCachedRowSet.nextPage();
	}

	@Override
	public boolean previousPage() throws SQLException  {
		return compositeCachedRowSet.previousPage();
	}
}	//	CCachedRowSet
