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
package org.compiere.model;

import java.util.ArrayList;
import java.util.StringTokenizer;
import java.util.logging.Level;

import org.compiere.util.CLogger;

/**
 *	Parse FROM in SQL WHERE clause
 *	
 *  @author Jorg Janke
 *  @version $Id: AccessSqlParser.java,v 1.3 2006/07/30 00:58:36 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1652623 ] AccessSqlParser.getTableInfo(String) - tablename parsing bug
 * 			<li>BF [ 1964496 ] AccessSqlParser is not parsing well JOIN CLAUSE
 * 			<li>BF [ 2840157 ] AccessSqlParser is not parsing well ON keyword
 * 				https://sourceforge.net/p/adempiere/bugs/2042/
 */
public class AccessSqlParser
{
	/**
	 *	Base Constructor.
	 *	You need to set the SQL and start the parsing manually.
	 */
	public AccessSqlParser ()
	{
	}	//	AccessSqlParser

	/**
	 *	Full Constructor 
	 *	@param sql sql command
	 */
	public AccessSqlParser (String sql)
	{
		setSql(sql);
	}	//	AccessSqlParser

	/**	FROM String			*/
	private static final String		FROM = " FROM ";
	private static final int		FROM_LENGTH = FROM.length();
	private static final String		WHERE = " WHERE ";
	private static final String		ON = " ON ";

	/**	Logger				*/
	private static final CLogger	log = CLogger.getCLogger(AccessSqlParser.class);
	/**	Original SQL			*/
	private String		m_sqlOriginal;
	/**	SQL Selects			*/
	private String[]	m_sql;
	/**	List of Arrays		*/
	private ArrayList<TableInfo[]>	m_tableInfo = new ArrayList<TableInfo[]>(); 

	/**
	 * 	Set Sql and parse it
	 *	@param sql sql
	 */
	public void setSql (String sql)
	{
		if (sql == null)
			throw new IllegalArgumentException("No SQL");
		m_sqlOriginal = sql;
		int index = m_sqlOriginal.indexOf("\nFROM ");
		if (index != -1)
			m_sqlOriginal = m_sqlOriginal.replace("\nFROM ", FROM);
		index = m_sqlOriginal.indexOf("\nWHERE ");
		if (index != -1)
			m_sqlOriginal = m_sqlOriginal.replace("\nWHERE ", WHERE);
		//
		parse();
	}	//	setSQL

	/**
	 * 	Get (original) Sql
	 *	@return sql
	 */
	public String getSql()
	{
		return m_sqlOriginal;
	}	//	getSql

	/**
	 * 	Parse Original SQL.
	 * 	Called from setSql or Constructor.
	 * 	@return true if pased
	 */
	public boolean parse()
	{
		if (m_sqlOriginal == null || m_sqlOriginal.length() == 0)
			throw new IllegalArgumentException("No SQL");

		getSelectStatements();
		//	analyse each select	
		for (int i = 0; i < m_sql.length; i++)
		{	
			TableInfo[] info = getTableInfo(m_sql[i].trim());
			m_tableInfo.add(info);
		}
		//
		if (log.isLoggable(Level.FINE)) log.fine(toString());
		return m_tableInfo.size() > 0;
	}	//	parse

	/**
	 * 	Parses 	m_sqlOriginal and creates Array of m_sql statements
	 */
	private void getSelectStatements()
	{
		String[] sqlIn = new String[] {m_sqlOriginal};
		String[] sqlOut = null;
		try
		{
			sqlOut = getSubSQL (sqlIn);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, m_sqlOriginal, e);
			throw new IllegalArgumentException(m_sqlOriginal);
		}
		//	a sub-query was found
		while (sqlIn.length != sqlOut.length)
		{
			sqlIn = sqlOut;
			try
			{
				sqlOut = getSubSQL (sqlIn);
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, m_sqlOriginal, e);
				throw new IllegalArgumentException(sqlOut.length + ": "+ m_sqlOriginal);
			}
		}
		m_sql = sqlOut;
	}	//	getSelectStatements

	/**
	 * 	Get Sub SQL of sql statements
	 *	@param sqlIn array of input sql
	 *	@return array of resulting sql
	 */
	private String[] getSubSQL (String[] sqlIn)
	{
		ArrayList<String> list = new ArrayList<String>();
		for (int sqlIndex = 0; sqlIndex < sqlIn.length; sqlIndex++)
		{
			String sql = sqlIn[sqlIndex];
			int index = sql.indexOf("(SELECT ", 7);
			while (index != -1)
			{
				int endIndex = index+1;
				int parenthesisLevel = 0;
				//	search for the end of the sql
				while (endIndex++ < sql.length())
				{
					char c = sql.charAt(endIndex); 
					if (c == ')')
					{
						if (parenthesisLevel == 0)
							break;
						else
							parenthesisLevel--;
					}
					else if (c == '(')
						parenthesisLevel++;
				}
				String subSQL = sql.substring(index, endIndex+1);
				list.add(subSQL);
				//	remove inner SQL (##)
				sql = sql.substring(0,index+1) + "##" 
					+ sql.substring(endIndex);
				index = sql.indexOf("(SELECT ", 7);
			}			
			list.add(sql);	//	last SQL
		}
		String[] retValue = new String[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getSubSQL

	/**
	 * 	Get Table Info for SQL
	 *	@param sql sql
	 *	@return array of table info for sql
	 */
	private TableInfo[] getTableInfo (String sql)
	{
		ArrayList<TableInfo> list = new ArrayList<TableInfo>();
		//	remove ()
		if (sql.startsWith("(") && sql.endsWith(")"))
			sql = sql.substring(1,sql.length()-1);
			
		int fromIndex = sql.indexOf(FROM);
		if (fromIndex != sql.lastIndexOf(FROM))
			log.log(Level.WARNING, "More than one FROM clause - " + sql);
		while (fromIndex != -1)
		{
			String from = sql.substring(fromIndex+FROM_LENGTH);
			int index = from.lastIndexOf(WHERE);	//	end at where
			if (index != -1)
				from = from.substring(0, index);
			from = from.replaceAll("[\r\n\t ]+AS[\r\n\t ]+", " ");
			from = from.replaceAll("[\r\n\t ]+as[\r\n\t ]+", " ");
			from = from.replaceAll("[\r\n\t ]+INNER[\r\n\t ]+JOIN[\r\n\t ]+", ", ");
			from = from.replaceAll("[\r\n\t ]+LEFT[\r\n\t ]+OUTER[\r\n\t ]+JOIN[\r\n\t ]+", ", ");
			from = from.replaceAll("[\r\n\t ]+RIGHT[\r\n\t ]+OUTER[\r\n\t ]+JOIN[\r\n\t ]+", ", ");
			from = from.replaceAll("[\r\n\t ]+FULL[\r\n\t ]+JOIN[\r\n\t ]+", ", ");
			from = from.replaceAll("[\r\n\t ]+LEFT[\r\n\t ]+JOIN[\r\n\t ]+", ", ");
			from = from.replaceAll("[\r\n\t ]+RIGHT[\r\n\t ]+JOIN[\r\n\t ]+", ", ");
			from = from.replaceAll("[\r\n\t ]+JOIN[\r\n\t ]+", ", ");
			
			from = from.replaceAll("[\r\n\t ]+[Oo][Nn][\r\n\t ]+", ON); // teo_sarca, BF [ 2840157 ]
			//	Remove ON clause - assumes that there is no IN () in the clause
			index = from.indexOf(ON);
			while (index != -1)
			{
				int indexClose = getIndexClose(from);		//	does not catch "IN (1,2)" in ON
				int indexNextOn = from.indexOf(ON, index+4);
				if (indexNextOn != -1)
					indexClose = from.lastIndexOf(')', indexNextOn);
				if (indexClose != -1)
				{
					if (index > indexClose)
					{
						throw new IllegalStateException("Could not remove (index="+index+" > indexClose="+indexClose+") - "+from);
					}
					from = from.substring(0, index) + from.substring(indexClose+1);
				}
				else
				{
					log.log(Level.SEVERE, "Could not remove ON " + from);
					break;
				}			
				index = from.indexOf(ON);
			}
			
			StringTokenizer tableST = new StringTokenizer (from, ",");
			while (tableST.hasMoreTokens())
			{
				String tableString = tableST.nextToken().trim();
				StringTokenizer synST = new StringTokenizer (tableString, " \r\n\t"); // teo_sarca [ 1652623 ] AccessSqlParser.getTableInfo(String) - tablename parsing bug
				TableInfo tableInfo = null;
				if (synST.countTokens() > 1)
					tableInfo = new TableInfo(synST.nextToken(), synST.nextToken());
				else
					tableInfo = new TableInfo(tableString);
				list.add(tableInfo);
			}
			//
			sql = sql.substring(0, fromIndex);
			fromIndex = sql.lastIndexOf(FROM);
		}
		TableInfo[] retValue = new TableInfo[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getTableInfo


	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("AccessSqlParser[");
		if (m_tableInfo == null)
			sb.append(m_sqlOriginal);
		else
		{
			for (int i = 0; i < m_tableInfo.size(); i++)
			{
				if (i > 0)
					sb.append("|");
				TableInfo[] info = (TableInfo[])m_tableInfo.get(i);
				for (int ii = 0; ii < info.length; ii++)
				{
					if (ii > 0)
						sb.append(",");
					sb.append(info[ii].toString());
				}
			}
		}
		sb.append("|").append(getMainSqlIndex());
		sb.append("]");
		return sb.toString();
	} //	toString

	/**
	 * 	Get Table Info.
	 * 	@param index record index
	 *	@return table info
	 */
	public TableInfo[] getTableInfo (int index)
	{
		if (index < 0 || index > m_tableInfo.size())
			return null;
		TableInfo[] retValue = (TableInfo[])m_tableInfo.get(index);
		return retValue;
	}	//	getTableInfo

	/**
	 * 	Get Sql Statements
	 * 	@param index record index
	 *	@return index index of query
	 */
	public String getSqlStatement (int index)
	{
		if (index < 0 || index > m_sql.length)
			return null;
		return m_sql[index];
	}	//	getSqlStatement

	/**
	 * 	Get No of SQL Statements
	 *	@return FROM clause count
	 */
	public int getNoSqlStatments()
	{
		if (m_sql == null)
			return 0;
		return m_sql.length;
	}	//	getNoSqlStatments

	/**
	 * 	Get index of main Statements
	 *	@return index of main statement or -1 if not found
	 */
	public int getMainSqlIndex()
	{
		if (m_sql == null)
			return -1;
		else if (m_sql.length == 1)
			return 0;
		for (int i = m_sql.length-1; i >= 0; i--)
		{
			if (m_sql[i].charAt(0) != '(')
				return i;
		}
		return -1;
	}	//	getMainSqlIndex

	/**
	 * 	Get main sql Statement
	 *	@return main statement
	 */
	public String getMainSql()
	{
		if (m_sql == null)
			return m_sqlOriginal;
			
		if (m_sql.length == 1)
			return m_sql[0];
		for (int i = m_sql.length-1; i >= 0; i--)
		{
			if (m_sql[i].charAt(0) != '(')
				return m_sql[i];
		}
		return "";
	}	//	getMainSql
	
	/**
	 * 	Get index of ')'
	 *	@return index of ')'
	 */
	public int getIndexClose(String from)
	{
		int parenthesisLevel = 0;
		int indexOpen=from.indexOf('(');
		int index=-1;
		while(indexOpen!=-1)
		{
			parenthesisLevel++;
			int indexNextOpen = from.indexOf('(', indexOpen+1);
			int indexClose = from.indexOf(')',indexOpen+1);
			if (indexNextOpen==-1 || indexClose<indexNextOpen){
				break;
			}	
			indexOpen=from.indexOf('(',indexNextOpen);
		}
		while(parenthesisLevel>0)
		{
			index = from.indexOf(')',index+1);
			parenthesisLevel--;
		}
		return index;
	}

	/**
	 * 	Table Info VO
	 */
	public static class TableInfo
	{
		/**
		 * 	Constructor
		 *	@param tableName table
		 *	@param synonym synonym
		 */
		public TableInfo (String tableName, String synonym)
		{
			m_tableName = tableName;
			m_synonym = synonym;
		}	//	TableInfo
		
		/**
		 * 	Short Constuctor - no syn
		 *	@param tableName table
		 */
		public TableInfo (String tableName)
		{
			this (tableName, null);
		}	//	TableInfo
		
		private String m_tableName;
		private String m_synonym;
		
		/**
		 * 	Get Table Synonym
		 *	@return synonym
		 */
		public String getSynonym()
		{
			if (m_synonym == null)
				return "";
			return m_synonym;
		}	//	getSynonym

		/**
		 * 	Get TableName
		 *	@return table name
		 */
		public String getTableName()
		{
			return m_tableName;
		}	//	getTableName

		/**
		 * 	String Representation
		 *	@return info
		 */
		public String toString()
		{
			StringBuilder sb = new StringBuilder(m_tableName);
			if (getSynonym().length() > 0)
				sb.append("=").append(m_synonym);
			return sb.toString();
		} 	//	toString

	}	//	TableInfo

}	//	AccessSqlParser
