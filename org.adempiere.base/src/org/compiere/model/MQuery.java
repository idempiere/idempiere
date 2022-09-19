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

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;

/**
 *	Query Descriptor.
 * 	Maintains restrictions (WHERE clause)
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: MQuery.java,v 1.4 2006/07/30 00:58:04 jjanke Exp $
 * 
 * @author Teo Sarca
 * 		<li>BF [ 2860022 ] MQuery.get() is generating restrictions for non-existent column
 * 			https://sourceforge.net/p/adempiere/bugs/2099/
 */
public class MQuery implements Serializable, Cloneable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8671209250739719461L;

	/**
	 *	Get Query from Parameter
	 *	@param ctx context (to determine language)
	 *  @param AD_PInstance_ID instance
	 *  @param TableName table name
	 *  @return where clause
	 */
	static public MQuery get (Properties ctx, int AD_PInstance_ID, String TableName)
	{
		if (s_log.isLoggable(Level.INFO)) s_log.info("AD_PInstance_ID=" + AD_PInstance_ID + ", TableName=" + TableName);
		MQuery reportQuery = new MQuery(TableName);
		//	Temporary Tables - add qualifier (not displayed)
		MTable table =  MTable.get(ctx, TableName);
		if (TableName.startsWith("T_"))
		{
			reportQuery.addRestriction(TableName + ".AD_PInstance_ID=" + AD_PInstance_ID);
		}
		//use separate query object for rendering of parameter at report
		reportQuery.setReportProcessQuery(new MQuery(TableName));
		reportQuery.m_AD_PInstance_ID = AD_PInstance_ID;

		//	How many rows do we have?
		String SQL = "SELECT COUNT(*) FROM AD_PInstance_Para WHERE AD_PInstance_ID=?";
		int rows = DB.getSQLValue(null, SQL, AD_PInstance_ID);

		if (rows < 1)
			return reportQuery;

		Map<String, String> parameterMap = new HashMap<>();
		List<String> queryList = new ArrayList<>();
		boolean trl = !Env.isBaseLanguage(ctx, "AD_Process_Para");
		if (!trl)
			SQL = "SELECT ip.ParameterName,ip.P_String,ip.P_String_To,"			//	1..3
				+ "ip.P_Number,ip.P_Number_To,"									//	4..5
				+ "ip.P_Date,ip.P_Date_To, ip.Info,ip.Info_To, "				//	6..9
				+ "pp.Name, pp.IsRange, pp.AD_Reference_ID, pp.Query, "			//	10..13
				+ "pp.AD_Process_ID, pp.AD_Process_Para_ID "					//	14..15
				+ "FROM AD_PInstance_Para ip, AD_PInstance i, AD_Process_Para pp "
				+ "WHERE i.AD_PInstance_ID=ip.AD_PInstance_ID"
				+ " AND pp.AD_Process_ID=i.AD_Process_ID"
				+ " AND pp.ColumnName=ip.ParameterName"
				+ " AND pp.IsActive='Y'"
				+ " AND ip.AD_PInstance_ID=?"
				+ " ORDER BY pp.SeqNo";
		else
			SQL = "SELECT ip.ParameterName,ip.P_String,ip.P_String_To, ip.P_Number,ip.P_Number_To,"
				+ "ip.P_Date,ip.P_Date_To, ip.Info,ip.Info_To, "
				+ "ppt.Name, pp.IsRange, pp.AD_Reference_ID, pp.Query, "
				+ "pp.AD_Process_ID, pp.AD_Process_Para_ID "
				+ "FROM AD_PInstance_Para ip, AD_PInstance i, AD_Process_Para pp, AD_Process_Para_Trl ppt "
				+ "WHERE i.AD_PInstance_ID=ip.AD_PInstance_ID"
				+ " AND pp.AD_Process_ID=i.AD_Process_ID"
				+ " AND pp.ColumnName=ip.ParameterName"
				+ " AND pp.IsActive='Y'"
				+ " AND pp.AD_Process_Para_ID=ppt.AD_Process_Para_ID"
				+ " AND ip.AD_PInstance_ID=?"
				+ " AND ppt.AD_Language=?"
				+ " ORDER BY pp.SeqNo";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			pstmt.setInt(1, AD_PInstance_ID);
			if (trl)
				pstmt.setString(2, Env.getAD_Language(ctx));
			rs = pstmt.executeQuery();
			//	all records
			for (int row = 0; rs.next(); row++)
			{
				if (row == rows)
				{
					s_log.log(Level.SEVERE, "(Parameter) - more rows than expected");
					break;
				}
				MQuery query = reportQuery;
				String ParameterName = rs.getString(1);
				String P_String = rs.getString(2);
				String P_String_To = rs.getString(3);
				int restrictionCount = reportQuery.getRestrictionCount();
				//
				Double P_Number = null;
				double d = rs.getDouble(4);
				if (!rs.wasNull())
					P_Number = Double.valueOf(d);
				Double P_Number_To = null;
				d = rs.getDouble(5);
				if (!rs.wasNull())
					P_Number_To = Double.valueOf(d);
				//
				Timestamp P_Date = rs.getTimestamp(6);
				Timestamp P_Date_To = rs.getTimestamp(7);
				//
				String Info = rs.getString(8);
				String Info_To = rs.getString(9);
				//
				String Name = rs.getString(10);
				boolean isRange = "Y".equals(rs.getString(11));
				//
				int Reference_ID = rs.getInt(12);

				MUserDefProcParameter udpp = MUserDefProcParameter.get(ctx, rs.getInt(15), rs.getInt(14));
				if (udpp != null)
					Reference_ID = udpp.getAD_Reference_ID();

				String P_Query = rs.getString(13);
				//
				if (s_log.isLoggable(Level.FINE)) s_log.fine(ParameterName + " S=" + P_String + "-" + P_String_To
					+ ", N=" + P_Number + "-" + P_Number_To + ", D=" + P_Date + "-" + P_Date_To
					+ "; Name=" + Name + ", Info=" + Info + "-" + Info_To + ", Range=" + isRange);
				//
				//custom query or column not exists - render as report parameters
				if (!Util.isEmpty(P_Query) || (table != null && table.getColumn(ParameterName) == null))
				{
					query = reportQuery.getReportProcessQuery();
				}

				//-------------------------------------------------------------
				if (P_String != null)
				{
					parameterMap.put(ParameterName, P_String);
					if (P_String_To == null)
					{
						if (Reference_ID == DisplayType.ChosenMultipleSelectionList)
						{
							String columnName = TableName + "." + ParameterName;		
							int cnt = DB.getSQLValueEx(null, "SELECT Count(*) From AD_Column WHERE IsActive='Y' AND AD_Client_ID=0 AND Upper(ColumnName)=? AND AD_Reference_ID=?", ParameterName.toUpperCase(), DisplayType.ChosenMultipleSelectionList);
							if (cnt > 0)
								query.addRestriction(DB.intersectClauseForCSV(columnName, P_String), MQuery.EQUAL, Name, Info);
							else
								query.addRestriction(DB.inClauseForCSV(columnName, P_String), MQuery.EQUAL, Name, Info);
						} 
						else if (Reference_ID == DisplayType.ChosenMultipleSelectionTable || Reference_ID == DisplayType.ChosenMultipleSelectionSearch)
						{
							String columnName = TableName + "." + ParameterName;
							if (columnName.endsWith("_ID"))
								query.addRestriction(DB.inClauseForCSV(columnName, P_String), MQuery.EQUAL, Name, Info);
							else
								query.addRestriction(DB.intersectClauseForCSV(columnName, P_String), MQuery.EQUAL, Name, Info);
						}
						else
						{
							if (P_String.indexOf('%') == -1)
								query.addRestriction(ParameterName, MQuery.EQUAL, 
									P_String, Name, Info);
							else
								query.addRestriction(ParameterName, MQuery.LIKE, 
									P_String, Name, Info);
						}
					}
					else
					{
						query.addRangeRestriction(ParameterName, 
							P_String, P_String_To, Name, Info, Info_To);
						parameterMap.put("To_"+ParameterName, P_String_To);
					}
				}
				//	Number
				else if (P_Number != null || P_Number_To != null)
				{
					if (P_Number_To == null)
					{
						parameterMap.put(ParameterName, P_Number.toString());
						if (isRange)
							query.addRestriction(ParameterName, MQuery.GREATER_EQUAL, 
								P_Number, Name, Info);
						else
							query.addRestriction(ParameterName, MQuery.EQUAL, 
								P_Number, Name, Info);
					}
					else	//	P_Number_To != null
					{
						parameterMap.put("To_"+ParameterName, P_Number_To.toString());
						if (P_Number == null)							
							query.addRestriction(ParameterName, MQuery.LESS_EQUAL, 
								P_Number_To, Name, Info);
						else
						{
							query.addRangeRestriction(ParameterName, 
								P_Number, P_Number_To, Name, Info, Info_To);
							parameterMap.put(ParameterName, P_Number.toString());
						}
					}
				}
				//	Date
				else if (P_Date != null || P_Date_To != null)
				{
					String paramName = (Reference_ID == DisplayType.DateTime) ? ParameterName
							: "TRUNC(" + ParameterName + ")";

					if (P_Date_To == null)
					{
						parameterMap.put(ParameterName, DisplayType.getDateFormat().format(P_Date));
						if (isRange)
							query.addRestriction(paramName, MQuery.GREATER_EQUAL, P_Date, Name, Info);
						else
							query.addRestriction(paramName, MQuery.EQUAL, P_Date, Name, Info);
					}
					else // P_Date_To != null
					{
						parameterMap.put("To_"+ParameterName, DisplayType.getDateFormat().format(P_Date_To));
						if (P_Date == null)
							query.addRestriction(paramName, MQuery.LESS_EQUAL, P_Date_To, Name, Info);
						else
						{
							query.addRangeRestriction(paramName, P_Date, P_Date_To, Name, Info, Info_To);
							parameterMap.put(ParameterName, DisplayType.getDateFormat().format(P_Date));
						}
					}
				}
				
				//keep custom query for later context parsing
				if (!Util.isEmpty(P_Query) && (parameterMap.containsKey(ParameterName) || parameterMap.containsKey("To_"+ParameterName)))
					queryList.add(P_Query);
				
				//add to reportprocessquery if new restriction added to reportquery
				if (query == reportQuery && reportQuery.getReportProcessQuery() != null 
					&& reportQuery.getRestrictionCount() > restrictionCount) 
				{
					reportQuery.getReportProcessQuery().m_list.add(reportQuery.m_list.get(reportQuery.m_list.size()-1));
				}
			}
		}
		catch (SQLException e2)
		{
			s_log.log(Level.SEVERE, SQL, e2);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		//add custom query
		if (queryList.size() > 0)
		{
			QueryEvaluatee evaluatee=  new QueryEvaluatee(parameterMap);
			for(String query : queryList)
			{
				if (query.indexOf("@") >= 0)
				{
					query = parseVariable(evaluatee, query, false);
					reportQuery.addRestriction(query);
				}
			}
		}
		
		if (s_log.isLoggable(Level.INFO)) s_log.info(reportQuery.toString());
		return reportQuery;
	}	//	get
	
	private static String parseVariable(Evaluatee evaluatee, String expression, boolean ignoreUnparseable) {
		if (expression == null || expression.length() == 0)
			return "";

		String token;
		String inStr = new String(expression);
		StringBuilder outStr = new StringBuilder();

		int i = inStr.indexOf('@');
		while (i != -1)
		{
			outStr.append(inStr.substring(0, i));			// up to @
			inStr = inStr.substring(i+1, inStr.length());	// from first @

			int j = inStr.indexOf('@');						// next @
			if (j < 0)
			{
				s_log.log(Level.SEVERE, "No second tag: " + inStr);
				return "";						//	no second tag
			}

			token = inStr.substring(0, j);

			//format string
			String format = "";
			int f = token.indexOf('<');
			if (f > 0 && token.endsWith(">")) {
				format = token.substring(f+1, token.length()-1);
				token = token.substring(0, f);
			}

			String v = evaluatee.get_ValueAsString(token);
			if (!Util.isEmpty(v)) {
				if (format != null && format.length() > 0) {
					MessageFormat mf = new MessageFormat(format);
					outStr.append(mf.format(v));
				} else {
					outStr.append(v.toString());
				}
			} else if (!ignoreUnparseable) {
				return "";				
			}

			inStr = inStr.substring(j+1, inStr.length());	// from second @
			i = inStr.indexOf('@');
		}
		outStr.append(inStr);						// add the rest of the string

		return outStr.toString();
	}
	
	/**
	 * 	Get Zoom Column Name.
	 * 	Converts Synonyms like SalesRep_ID to AD_User_ID
	 *	@param columnName column name
	 *	@return column name
	 */
	public static String getZoomColumnName (String columnName)
	{
		if (columnName == null)
			return null;
		if (columnName.equals("SalesRep_ID"))
			return "AD_User_ID";
		if (columnName.equals("C_DocTypeTarget_ID"))
			return "C_DocType_ID";
		if (columnName.equals("Bill_BPartner_ID"))
			return "C_BPartner_ID";
		if (columnName.equals("Bill_Location_ID") || columnName.equals("BillTo_ID"))
			return "C_BPartner_Location_ID";
		if (columnName.equals("Account_ID"))
			return "C_ElementValue_ID";
		if (columnName.equals("C_LocFrom_ID") || columnName.equals("C_LocTo_ID") || columnName.equals("BP_Location_ID"))
			return "C_Location_ID";
		if (columnName.equals("C_UOM_To_ID"))
			return "C_UOM_ID";
		if (columnName.equals("M_AttributeSetInstanceTo_ID"))
			return "M_AttributeSetInstance_ID";
		if (columnName.equals("M_LocatorTo_ID"))
			return "M_Locator_ID";
		if (columnName.equals("AD_OrgBP_ID") || columnName.equals("AD_OrgTrx_ID") || columnName.equals("AD_OrgTo_ID"))
			return "AD_Org_ID";
		//	See also GridTab.validateQuery
		return columnName;
	}	//	getZoomColumnName
	
	/**
	 * 	Derive Zoom Table Name from column name.
	 * 	(e.g. drop _ID)
	 *	@param columnName  column name
	 *	@return table name
	 */
	public static String getZoomTableName (String columnName)
	{
		String tableName = getZoomColumnName(columnName);
		int index = tableName.lastIndexOf("_ID");
		if (index != -1)
			return tableName.substring(0, index);
		return tableName;
	}	//	getZoomTableName

	
	/*************************************************************************
	 * 	Create simple Equal Query.
	 *  Creates columnName=value or columnName='value'
	 * 	@param columnName columnName
	 * 	@param value value
	 * 	@return quary
	 */
	public static MQuery getEqualQuery (String columnName, Object value)
	{
		MQuery query = new MQuery();
		query.addRestriction(columnName, EQUAL, value);
		query.setRecordCount(1);	//	guess
		return query;
	}	//	getEqualQuery

	/**
	 * 	Create simple Equal Query.
	 *  Creates columnName=value
	 * 	@param columnName columnName
	 * 	@param value value
	 * 	@return query
	 */
	public static MQuery getEqualQuery (String columnName, int value)
	{
		MQuery query = new MQuery();
		if (columnName.endsWith("_ID"))
			query.setTableName(columnName.substring(0, columnName.length()-3));
		query.addRestriction(columnName, EQUAL, Integer.valueOf(value));
		query.setRecordCount(1);	//	guess
		return query;
	}	//	getEqualQuery

	/**
	 * 	Create No Record query.
	 * 	@param tableName table name
	 * 	@param newRecord new Record Indicator (2=3) 
	 * 	@return query
	 */
	public static MQuery getNoRecordQuery (String tableName, boolean newRecord)
	{
		MQuery query = new MQuery(tableName);
		if (newRecord)
			query.addRestriction(NEWRECORD);
		else
			query.addRestriction("1=2");
		query.setRecordCount(0);
		return query;
	}	//	getNoRecordQuery
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MQuery.class);
	
	
	/**************************************************************************
	 *	Constructor w/o table name
	 */
	public MQuery ()
	{
	}	//	MQuery

	/**
	 *	Constructor
	 *  @param TableName Table Name
	 */
	public MQuery (String TableName)
	{
		m_TableName = TableName;
	}	//	MQuery

	/**
	 * 	Constructor get TableNAme from Table
	 * 	@param AD_Table_ID Table_ID
	 */
	public MQuery (int AD_Table_ID)
	{	//	Use Client Context as r/o
		m_TableName = MTable.getTableName (Env.getCtx(), AD_Table_ID);
	}	//	MQuery

	/**	Table Name					*/
	private String		m_TableName = "";
	/** PInstance					*/
	private int m_AD_PInstance_ID = 0;
	/**	List of Restrictions		*/
	private ArrayList<Restriction>	m_list = new ArrayList<Restriction>();
	/**	Record Count				*/
	private int			m_recordCount = 999999;
	/** New Record Query			*/
	private boolean		m_newRecord = false;
	/** New Record String			*/
	private static final String	NEWRECORD = "2=3";
	
	private String m_zoomTable;
	
	private String m_zoomColumn;
	
	private Object m_zoomValue;

	private int m_zoomWindow_ID;

	private MQuery m_reportProcessQuery;


	public int getZoomWindowID() {
		return m_zoomWindow_ID;
	}


	public void setZoomWindowID(int m_zoomWindow_ID) {
		this.m_zoomWindow_ID = m_zoomWindow_ID;
	}


	/**
	 * 	Get Record Count
	 *	@return count - default 999999
	 */
	public int getRecordCount()
	{
		return m_recordCount;
	}	//	getRecordCount
	
	/**
	 * 	Set Record Count
	 *	@param count count
	 */
	public void setRecordCount(int count)
	{
		m_recordCount = count;
	}	//	setRecordCount
	
	
	/** Equal 			*/
	public static final String	EQUAL = "=";
	public static final String	MSG_EQUAL = "OPERATOR_EQUAL";
	/** Equal - 0		*/
	public static final int		EQUAL_INDEX = 0;
	/** Not Equal		*/
	public static final String	NOT_EQUAL = "!=";
	public static final String	MSG_NOT_EQUAL = "OPERATOR_NOT_EQUAL";
	/** Not Equal - 1		*/
	public static final int		NOT_EQUAL_INDEX = 1;
	/** Like			*/
	public static final String	LIKE = " LIKE ";
	public static final String	MSG_LIKE = "OPERATOR_LIKE";
	/** Not Like		*/
	public static final String	NOT_LIKE = " NOT LIKE ";
	public static final String	MSG_NOT_LIKE = "OPERATOR_NOT_LIKE";
	/** Greater			*/
	public static final String	GREATER = ">";
	public static final String	MSG_GREATER = "OPERATOR_GREATER";
	/** Greater Equal	*/
	public static final String	GREATER_EQUAL = ">=";
	public static final String	MSG_GREATER_EQUAL = "OPERATOR_GREATER_EQUAL";
	/** Less			*/
	public static final String	LESS = "<";
	public static final String	MSG_LESS = "OPERATOR_LESS";
	/** Less Equal		*/
	public static final String	LESS_EQUAL = "<=";
	public static final String	MSG_LESS_EQUAL = "OPERATOR_LESS_EQUAL";
	/** Between			*/
	public static final String	BETWEEN = " BETWEEN ";
	public static final String	MSG_BETWEEN = "OPERATOR_BETWEEN";
	/** Between - 8		*/
	public static final int		BETWEEN_INDEX = 8;
	/** For IDEMPIERE-377	*/
	public static final String 	NOT_NULL = " IS NOT NULL ";
	public static final String 	MSG_NOT_NULL = "OPERATOR_NOT_NULL";
	/** For IDEMPIERE-377	*/
	public static final String 	NULL = " IS NULL ";
	public static final String 	MSG_NULL = "OPERATOR_NULL";

	/* NOTE: Value is the SQL operator, and Name is the message that appears in Find window and reports */
	/**	All the Operators			*/
	public static final ValueNamePair[]	OPERATORS = new ValueNamePair[] {
		new ValueNamePair (EQUAL,			MSG_EQUAL),		//	0 - EQUAL_INDEX
		new ValueNamePair (NOT_EQUAL,		MSG_NOT_EQUAL),	//  1 - NOT_EQUAL_INDEX
		new ValueNamePair (LIKE,			MSG_LIKE),
		new ValueNamePair (NOT_LIKE,		MSG_NOT_LIKE),
		new ValueNamePair (GREATER,			MSG_GREATER),
		new ValueNamePair (GREATER_EQUAL,	MSG_GREATER_EQUAL),
		new ValueNamePair (LESS,			MSG_LESS),
		new ValueNamePair (LESS_EQUAL,		MSG_LESS_EQUAL),
		new ValueNamePair (BETWEEN,			MSG_BETWEEN),	//	8 - BETWEEN_INDEX
		new ValueNamePair (NULL,			MSG_NULL),
		new ValueNamePair (NOT_NULL,		MSG_NOT_NULL)
	};
	/**	Operators for Strings				*/
	public static final ValueNamePair[]	OPERATORS_STRINGS = new ValueNamePair[] {
		new ValueNamePair (EQUAL,			MSG_EQUAL),
		new ValueNamePair (NOT_EQUAL,		MSG_NOT_EQUAL),
		new ValueNamePair (LIKE,			MSG_LIKE),
		new ValueNamePair (NOT_LIKE,		MSG_NOT_LIKE),
		new ValueNamePair (GREATER,			MSG_GREATER),
		new ValueNamePair (GREATER_EQUAL,	MSG_GREATER_EQUAL),
		new ValueNamePair (LESS,			MSG_LESS),
		new ValueNamePair (LESS_EQUAL,		MSG_LESS_EQUAL),
		new ValueNamePair (BETWEEN,			MSG_BETWEEN),
		new ValueNamePair (NULL,			MSG_NULL),
		new ValueNamePair (NOT_NULL,		MSG_NOT_NULL)
	};
	/**	Operators for Lookups and Lists	(including Y/N)				*/
	public static final ValueNamePair[]	OPERATORS_LOOKUP = new ValueNamePair[] {
		new ValueNamePair (EQUAL,			MSG_EQUAL),
		new ValueNamePair (NOT_EQUAL,		MSG_NOT_EQUAL),
		new ValueNamePair (NULL,			MSG_NULL),
		new ValueNamePair (NOT_NULL,		MSG_NOT_NULL)
	};
	/**	Operators for encrypted fields								*/
	public static final ValueNamePair[]	OPERATORS_ENCRYPTED = new ValueNamePair[] {
		new ValueNamePair (NULL,			MSG_NULL),
		new ValueNamePair (NOT_NULL,		MSG_NOT_NULL)
	};

	/**	Operators for Numbers, Integers	*/
	public static final ValueNamePair[]	OPERATORS_NUMBERS = new ValueNamePair[] {
		new ValueNamePair (EQUAL,			MSG_EQUAL),
		new ValueNamePair (NOT_EQUAL,		MSG_NOT_EQUAL),
		new ValueNamePair (GREATER,			MSG_GREATER),
		new ValueNamePair (GREATER_EQUAL,	MSG_GREATER_EQUAL),
		new ValueNamePair (LESS,			MSG_LESS),
		new ValueNamePair (LESS_EQUAL,		MSG_LESS_EQUAL),
		new ValueNamePair (BETWEEN,			MSG_BETWEEN),
		new ValueNamePair (NULL,			MSG_NULL),
		new ValueNamePair (NOT_NULL,		MSG_NOT_NULL)
	};
	
	/**	Operators for Dates	*/
	public static final ValueNamePair[]	OPERATORS_DATES = new ValueNamePair[] {
		new ValueNamePair (EQUAL,			MSG_EQUAL),
		new ValueNamePair (NOT_EQUAL,		MSG_NOT_EQUAL),
		new ValueNamePair (GREATER,			MSG_GREATER),
		new ValueNamePair (GREATER_EQUAL,	MSG_GREATER_EQUAL),
		new ValueNamePair (LESS,			MSG_LESS),
		new ValueNamePair (LESS_EQUAL,		MSG_LESS_EQUAL),
		new ValueNamePair (BETWEEN,			MSG_BETWEEN),
		new ValueNamePair (NULL,			MSG_NULL),
		new ValueNamePair (NOT_NULL,		MSG_NOT_NULL)
	};

	/*************************************************************************
	 * 	Add Restriction
	 * 	@param ColumnName ColumnName
	 * 	@param Operator Operator, e.g. = != ..
	 * 	@param Code Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 *  @param andCondition true=and, false=or
	 *  @param depth ( = no open brackets )
	 */
	public void addRestriction (String ColumnName, String Operator,
		Object Code, String InfoName, String InfoDisplay, boolean andCondition, int depth)
	{
		Restriction r = new Restriction (ColumnName, Operator,
			Code, InfoName, InfoDisplay, andCondition, false, depth);
		m_list.add(r);
	}	//	addRestriction
	
	/*************************************************************************
	 * 	Add Restriction
	 * 	@param ColumnName ColumnName
	 * 	@param Operator Operator, e.g. = != ..
	 * 	@param Code Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 *  @param andCondition true=and, false=or
	 *  @param notCondition true=not, false=empty
	 *  @param depth ( = no open brackets )
	 */
	public void addRestriction (String ColumnName, String Operator,
		Object Code, String InfoName, String InfoDisplay, boolean andCondition, boolean notCondition, int depth)
	{
		Restriction r = new Restriction (ColumnName, Operator,
			Code, InfoName, InfoDisplay, andCondition, notCondition, depth);
		m_list.add(r);
	}	//	addRestriction
	
	/**
	 * 	Add Range Restriction (BETWEEN)
	 * 	@param ColumnName ColumnName
	 * 	@param Code Code, e.g 0, All%
	 * 	@param Code_to Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 * 	@param InfoDisplay_to Display of Code (Lookup)
	 *  @param andCondition true=and, false=or
	 *  @param notCondition true=not, false=empty
	 *  @param depth ( = no open brackets )
	 */
	public void addRangeRestriction (String ColumnName,
		Object Code, Object Code_to,
		String InfoName, String InfoDisplay, String InfoDisplay_to, boolean andCondition, boolean notCondition, int depth)
	{
		Restriction r = new Restriction (ColumnName, Code, Code_to,
			InfoName, InfoDisplay, InfoDisplay_to, andCondition, notCondition, depth);
		m_list.add(r);
	}
	
	/*************************************************************************
	 * 	Add Restriction
	 * 	@param ColumnName ColumnName
	 * 	@param Operator Operator, e.g. = != ..
	 * 	@param Code Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 * 	@param andOrCondition AND/OR/AND NOT/OR NOT - concatenation of parenthesis
	 *  @param depth ( = no open brackets )
	 */
	public void addRestriction (String ColumnName, String Operator,
		Object Code, String InfoName, String InfoDisplay, String andOrCondition, int depth)
	{
		Restriction r = new Restriction (ColumnName, Operator,
			Code, InfoName, InfoDisplay, andOrCondition, depth);
		m_list.add(r);
	}	//	addRestriction
	
	/*************************************************************************
	 * 	Add Restriction
	 * 	@param ColumnName ColumnName
	 * 	@param Operator Operator, e.g. = != ..
	 * 	@param Code Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 */
	public void addRestriction (String ColumnName, String Operator,
		Object Code, String InfoName, String InfoDisplay)
	{
		Restriction r = new Restriction (ColumnName, Operator,
			Code, InfoName, InfoDisplay, true, 0);
		m_list.add(r);
	}	//	addRestriction

	/**
	 * 	Add Restriction
	 * 	@param ColumnName ColumnName
	 * 	@param Operator Operator, e.g. = != ..
	 * 	@param Code Code, e.g 0, All%
	 */
	public void addRestriction (String ColumnName, String Operator,
		Object Code)
	{
		Restriction r = new Restriction (ColumnName, Operator,
			Code, null, null, true, 0);
		m_list.add(r);
	}	//	addRestriction

	/**
	 * 	Add Restriction
	 * 	@param ColumnName ColumnName
	 * 	@param Operator Operator, e.g. = != ..
	 * 	@param Code Code, e.g 0
	 */
	public void addRestriction (String ColumnName, String Operator,
		int Code)
	{
		Restriction r = new Restriction (ColumnName, Operator,
			Integer.valueOf(Code), null, null, true, 0);
		m_list.add(r);
	}	//	addRestriction

	/**
	 * 	Add Range Restriction (BETWEEN)
	 * 	@param ColumnName ColumnName
	 * 	@param Code Code, e.g 0, All%
	 * 	@param Code_to Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 * 	@param InfoDisplay_to Display of Code (Lookup)
	 *  @param andCondition true=and, false=or
	 *  @param depth ( = no open brackets )
	 */
	public void addRangeRestriction (String ColumnName,
		Object Code, Object Code_to,
		String InfoName, String InfoDisplay, String InfoDisplay_to, boolean andCondition, int depth)
	{
		addRangeRestriction(ColumnName,
				Code, Code_to,
				InfoName, InfoDisplay, InfoDisplay_to, andCondition ? "AND" : "OR", depth);
	}

	/**
	 * 	Add Range Restriction (BETWEEN)
	 * 	@param ColumnName ColumnName
	 * 	@param Code Code, e.g 0, All%
	 * 	@param Code_to Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 * 	@param InfoDisplay_to Display of Code (Lookup)
	 * 	@param andOrCondition AND/OR/AND NOT/OR NOT - concatenation of parenthesis
	 *  @param depth ( = no open brackets )
	 */
	public void addRangeRestriction (String ColumnName,
		Object Code, Object Code_to,
		String InfoName, String InfoDisplay, String InfoDisplay_to, String andOrCondition, int depth)
	{
		Restriction r = new Restriction (ColumnName, Code, Code_to,
			InfoName, InfoDisplay, InfoDisplay_to, andOrCondition, depth);
		m_list.add(r);
	}	//	addRestriction
	
	/**
	 * 	Add Range Restriction (BETWEEN)
	 * 	@param ColumnName ColumnName
	 * 	@param Code Code, e.g 0, All%
	 * 	@param Code_to Code, e.g 0, All%
	 *  @param InfoName Display Name
	 * 	@param InfoDisplay Display of Code (Lookup)
	 * 	@param InfoDisplay_to Display of Code (Lookup)
	 */
	public void addRangeRestriction (String ColumnName,
		Object Code, Object Code_to,
		String InfoName, String InfoDisplay, String InfoDisplay_to)
	{
		Restriction r = new Restriction (ColumnName, Code, Code_to,
			InfoName, InfoDisplay, InfoDisplay_to, true, 0);
		m_list.add(r);
	}	//	addRestriction

	/**
	 * 	Add Range Restriction (BETWEEN)
	 * 	@param ColumnName ColumnName
	 * 	@param Code Code, e.g 0, All%
	 * 	@param Code_to Code, e.g 0, All%
	 */
	public void addRangeRestriction (String ColumnName,
		Object Code, Object Code_to)
	{
		Restriction r = new Restriction (ColumnName, Code, Code_to,
			null, null, null, true, 0);
		m_list.add(r);
	}	//	addRestriction

	/**
	 * 	Add Restriction
	 * 	@param r Restriction
	 */
	protected void addRestriction (Restriction r)
	{
		m_list.add(r);
	}	//	addRestriction

	/**
	 * 	Add Restriction
	 * 	@param whereClause SQL WHERE clause
	 *  @param andCondition
	 *  @param joinDepth
	 */
	public void addRestriction (String whereClause, boolean andCondition, int joinDepth)
	{
		if (whereClause == null || whereClause.trim().length() == 0)
			return;
		Restriction r = new Restriction (whereClause, andCondition, false, false, joinDepth);
		m_list.add(r);
		m_newRecord = whereClause.equals(NEWRECORD);
	}	//	addRestriction
	
	/**
	 * 	Add Restriction
	 * 	@param whereClause SQL WHERE clause
	 */
	public void addRestriction (String whereClause, boolean andCondition, boolean notCondition, int joinDepth)
	{
		if (whereClause == null || whereClause.trim().length() == 0)
			return;
		Restriction r = new Restriction (whereClause, andCondition, notCondition, false, joinDepth);
		m_list.add(r);
		m_newRecord = whereClause.equals(NEWRECORD);
	}	//	addRestriction

	/**
	 * 	Add Restriction
	 * 	@param whereClause SQL WHERE clause
	 */
	public void addRestriction (String whereClause, boolean andCondition, boolean notCondition, boolean existsCondition, int joinDepth)
	{
		if (whereClause == null || whereClause.trim().length() == 0)
			return;
		Restriction r = new Restriction (whereClause, andCondition, notCondition, existsCondition, joinDepth);
		m_list.add(r);
		m_newRecord = whereClause.equals(NEWRECORD);
	}	//	addRestriction
	
	/**
	 * 	Add Restriction
	 * 	@param whereClause SQL WHERE clause
	 *  @param joinDepth
	 *  @param andOrCondition
	 */
	public void addRestriction (String whereClause, int joinDepth, String andOrCondition)
	{
		if (whereClause == null || whereClause.trim().length() == 0)
			return;
		Restriction r = new Restriction (whereClause, andOrCondition, joinDepth);
		m_list.add(r);
		m_newRecord = whereClause.equals(NEWRECORD);
	}	//	addRestriction
	
	/**
	 * 	Add Restriction
	 * 	@param whereClause SQL WHERE clause
	 */
	public void addRestriction (String whereClause)
	{
		if (whereClause == null || whereClause.trim().length() == 0)
			return;
		Restriction r = new Restriction (whereClause, true, 0);
		m_list.add(r);
		m_newRecord = whereClause.equals(NEWRECORD);
	}	//	addRestriction

	public void addRestriction (String whereClause, String Operator, String InfoName, String InfoDisplay)
	{
		if (whereClause == null || whereClause.trim().length() == 0)
			return;
		Restriction r = new Restriction (whereClause, true, 0);
		r.Operator = Operator;
		if (InfoName != null)
			r.InfoName = InfoName;
		if (InfoDisplay != null)
			r.InfoDisplay = InfoDisplay.trim();
		m_list.add(r);
		m_newRecord = whereClause.equals(NEWRECORD);
	}

	/**
	 * 	New Record Query
	 *	@return true if new record query
	 */
	public boolean isNewRecordQuery()
	{
		return m_newRecord;
	}	//	isNewRecord
	
	/*************************************************************************
	 * 	Create the resulting Query WHERE Clause
	 * 	@return Where Clause
	 */
	public String getWhereClause ()
	{
		return getWhereClause(false);
	}	//	getWhereClause

	/**
	 * 	Create the resulting Query WHERE Clause
	 * 	@param fullyQualified fully qualified Table.ColumnName
	 * 	@return Where Clause
	 */
	public String getWhereClause (boolean fullyQualified)
	{
		int currentDepth = 0;
		boolean qualified = fullyQualified;
		if (qualified && (m_TableName == null || m_TableName.length() == 0))
			qualified = false;
		//
		StringBuilder sb = new StringBuilder();
		if (! isActive())
			return sb.toString();
		
		sb.append('(');
		for (int i = 0; i < m_list.size(); i++)
		{
			Restriction r = (Restriction)m_list.get(i);
			if (i != 0)
				sb.append(" ").append(r.andOrCondition).append(" ");
			
			//NOT
			sb.append(r.notCondition ? " NOT " : "");
			//EXISTS 
			sb.append(r.existsCondition ? " EXISTS " : "");
			
			for ( ; currentDepth < r.joinDepth; currentDepth++ )
			{
				sb.append('(');
			}
			if (qualified)
				sb.append(r.getSQL(m_TableName));
			else
				sb.append(r.getSQL(null));
			
			for ( ; currentDepth > r.joinDepth; currentDepth-- )
			{
				sb.append(')');
			}
		}
		
		// close brackets
		for ( ; currentDepth > 0; currentDepth-- )
		{
			sb.append(')');
		}
		sb.append(')');
		return sb.toString();
	}	//	getWhereClause

	/**
	 * 	Get printable Query Info
	 *	@return info
	 */
	public String getInfo ()
	{
		StringBuilder sb = new StringBuilder();
		int currentDepth = 0;
		if (m_TableName != null)
			sb.append(m_TableName).append(": ");
		//
		for (int i = 0; i < m_list.size(); i++)
		{
			Restriction r = (Restriction)m_list.get(i);
			for ( ; currentDepth < r.joinDepth; currentDepth++ )
			{
				sb.append('(');
			}
			for ( ; currentDepth > r.joinDepth; currentDepth-- )
			{
				sb.append(')');
			}
			if (i != 0)
				sb.append(" ").append(r.andOrCondition).append(" ");
			//NOT
			sb.append(r.notCondition ? " NOT " : "");		
			//EXISTS
			sb.append(r.existsCondition ? " EXISTS " : "");	
			
			//
			sb.append(r.getInfoName())
				.append(r.getInfoOperator())
				.append(r.getInfoDisplayAll());
		}
		// close brackets
		for ( ; currentDepth > 0; currentDepth-- )
		{
			sb.append(')');
		}
		return sb.toString();
	}	//	getInfo

	
	/**
	 * 	Create Query WHERE Clause.
	 *  Not fully qualified
	 * 	@param index restriction index
	 * 	@return Where Clause or "" if not valid
	 */
	public String getWhereClause (int index)
	{
		StringBuilder sb = new StringBuilder();
		if (index >= 0 && index < m_list.size())
		{
			Restriction r = (Restriction)m_list.get(index);
			sb.append(r.getSQL(null));
		}
		return sb.toString();
	}	//	getWhereClause

	/**
	 * 	Get Restriction Count
	 * 	@return number of restrictions
	 */
	public int getRestrictionCount()
	{
		return m_list.size();
	}	//	getRestrictionCount

	/**
	 * 	Is Query Active
	 * 	@return true if number of restrictions &gt; 0
	 */
	public boolean isActive()
	{
		return m_list.size() != 0;
	}	//	isActive

	/**
	 * 	Get Table Name
	 * 	@return Table Name
	 */
	public String getTableName ()
	{
		return m_TableName;
	}	//	getTableName

	/**
	 * 	Set Table Name
	 * 	@param TableName Table Name
	 */
	public void setTableName (String TableName)
	{
		m_TableName = TableName;
	}	//	setTableName

	
	/*************************************************************************
	 * 	Get ColumnName of index
	 * 	@param index index
	 * 	@return ColumnName
	 */
	public String getColumnName (int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.ColumnName;
	}	//	getColumnName

	/**
	 * 	Set ColumnName of index
	 * 	@param index index
	 *  @param ColumnName new column name
	 */
	protected void setColumnName (int index, String ColumnName)
	{
		if (index < 0 || index >= m_list.size())
			return;
		Restriction r = (Restriction)m_list.get(index);
		r.ColumnName = ColumnName;
	}	//	setColumnName

	/**
	 * 	Get Operator of index
	 * 	@param index index
	 * 	@return Operator
	 */
	public String getOperator (int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.Operator;
	}	//	getOperator

	/**
	 * 	Get Operator of index
	 * 	@param index index
	 * 	@return Operator
	 */
	public Object getCode (int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.Code;
	}	//	getCode

	/**
	 * 	Get Operator of index
	 * 	@param index index
	 * 	@return Operator
	 */
	public Object getCode_to (int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.Code_to;
	}	//	getCode
	
	/**
	 * 	Get Restriction Display of index
	 * 	@param index index
	 * 	@return Restriction Display
	 */
	public String getInfoDisplay (int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.InfoDisplay;
	}	//	getOperator

	/**
	 * 	Get TO Restriction Display of index
	 * 	@param index index
	 * 	@return Restriction Display
	 */
	public String getInfoDisplay_to (int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.InfoDisplay_to;
	}	//	getOperator

	/**
	 * 	Get Info Name
	 * 	@param index index
	 * 	@return Info Name
	 */
	public String getInfoName(int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.InfoName;
	}	//	getInfoName

	/**
	 * 	Get Info Operator
	 * 	@param index index
	 * 	@return info Operator
	 */
	public String getInfoOperator(int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.getInfoOperator();
	}	//	getInfoOperator

	/**
	 * 	Get Display with optional To
	 * 	@param index index
	 * 	@return info display
	 */
	public String getInfoDisplayAll (int index)
	{
		if (index < 0 || index >= m_list.size())
			return null;
		Restriction r = (Restriction)m_list.get(index);
		return r.getInfoDisplayAll();
	}	//	getInfoDisplay

	/**
	 * 	String representation
	 * 	@return info
	 */
	public String toString()
	{
		if (isActive())
			return getWhereClause(true);
		return "MQuery[" + m_TableName + ",Restrictions=0]";
	}	//	toString
	
	/**
	 * 	Get Display Name
	 *	@param ctx context
	 *	@return display Name
	 */
	public String getDisplayName(Properties ctx)
	{
		String keyColumn = null;
		if (m_TableName != null)
			keyColumn = m_TableName + "_ID";
		else
			keyColumn = getColumnName(0);
		String retValue = Msg.translate(ctx, keyColumn);
		if (retValue != null && retValue.length() > 0)
			return retValue;
		return m_TableName;
	}	//	getDisplayName

	/**
	 * 	Clone Query
	 * 	@return Query
	 */
	public MQuery deepCopy()
	{
		MQuery newQuery = new MQuery(m_TableName);
		for (int i = 0; i < m_list.size(); i++)
			newQuery.addRestriction((Restriction)m_list.get(i));
		return newQuery;
	}	//	clone

	/**
	 * @return AD_PInstance_ID; this value is set if you created this query by using {@link #get(Properties, int, String)}  
	 */
	public int getAD_PInstance_ID() {
		return m_AD_PInstance_ID;
	}

	/**
	 * 
	 * @param tableName
	 */
	public void setZoomTableName(String tableName) {
		m_zoomTable = tableName;
	}
	
	/**
	 * 
	 * @return zoom table name
	 */
	public String getZoomTableName() {
		return m_zoomTable;
	}

	/**
	 * 
	 * @param column
	 */
	public void setZoomColumnName(String column) {
		m_zoomColumn = column;
	}
	
	/**
	 * 
	 * @return zoom column name
	 */
	public String getZoomColumnName() {
		return m_zoomColumn;
	}

	/**
	 * 
	 * @param value
	 */
	public void setZoomValue(Object value) {
		m_zoomValue = value;
	}
	
	/**
	 * 
	 * @return zoom value, usually an integer
	 */
	public Object getZoomValue() {
		return m_zoomValue;
	}
	
	public void setReportProcessQuery(MQuery query) {
		m_reportProcessQuery = query;
	}
	
	public MQuery getReportProcessQuery() {
		return m_reportProcessQuery;
	}
	
	/**
	 * 
	 * @param ColumnName
	 * @param Operator
	 * @param Code
	 * @param InfoName
	 * @param InfoDisplay
	 * @param andCondition
	 * @param depth
	 * @return
	 */
	public String getRestrictionSQL (String ColumnName, String Operator,
			Object Code, String InfoName, String InfoDisplay, boolean andCondition, int depth)
	{
		Restriction r = new Restriction (ColumnName, Operator,
				Code, InfoName, InfoDisplay, andCondition, depth);
		return r.getSQL(null);
	}	//	getRestrictionSQL

	/**
	 * @param ColumnName
	 * @param Code
	 * @param Code_To
	 * @param InfoName
	 * @param InfoDisplay
	 * @param InfoDisplay_To
	 * @param andCondition
	 * @param depth
	 * @return
	 */
	public String getRestrictionSQL (String ColumnName, 
			Object Code, Object Code_To, String InfoName, String InfoDisplay, String InfoDisplay_To, boolean andCondition, int depth)
	{
		Restriction r = new Restriction(ColumnName, Code, Code_To, InfoName, 
					InfoDisplay, InfoDisplay_To, andCondition, false, depth);
		return r.getSQL(null);
	}
	
	@Override
	public MQuery clone() {
		try {
			MQuery clone = (MQuery) super.clone();
			clone.m_recordCount = 999999;
			if (m_reportProcessQuery != null)
				clone.m_reportProcessQuery = m_reportProcessQuery.clone();
			return clone;
		} catch (CloneNotSupportedException e) {
			throw new RuntimeException(e);
		}
	}
}	//	MQuery

/*****************************************************************************
 *	Query Restriction
 */
class Restriction  implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4521978087587321243L;

	/**
	 * 	Restriction
	 * 	@param columnName ColumnName
	 * 	@param operator Operator, e.g. = != ..
	 * 	@param code Code, e.g 0, All%
	 *  @param infoName Display Name
	 * 	@param infoDisplay Display of Code (Lookup)
	 * 	@param andCondition true->AND false->OR
	 *  @param depth number of parenthesis
	 */
	Restriction (String columnName, String operator,
		Object code, String infoName, String infoDisplay, boolean andCondition, int depth)
	{
		this(columnName, operator, code, infoName, infoDisplay,
				andCondition ? "AND" : "OR",
				depth);
	}

	/**
	 * 	Restriction
	 * 	@param columnName ColumnName
	 * 	@param operator Operator, e.g. = != ..
	 * 	@param code Code, e.g 0, All%
	 *  @param infoName Display Name
	 * 	@param infoDisplay Display of Code (Lookup)
	 * 	@param andOrCondition AND/OR/AND NOT/OR NOT - concatenation of parenthesis
	 *  @param depth number of parenthesis
	 */
	Restriction (String columnName, String operator,
		Object code, String infoName, String infoDisplay, String andOrCondition, int depth)
	{
		this.ColumnName = columnName.trim();
		if (infoName != null)
			InfoName = infoName;
		else
			InfoName = ColumnName;

		
		this.andOrCondition = andOrCondition;
		this.joinDepth = depth < 0 ? 0 : depth;
		
		//
		this.Operator = operator;
		//	Boolean
		if (code instanceof Boolean)
			Code = ((Boolean)code).booleanValue() ? "Y" : "N";
		else if (code instanceof KeyNamePair)
			Code = Integer.valueOf(((KeyNamePair)code).getKey());
		else if (code instanceof ValueNamePair)
			Code = ((ValueNamePair)code).getValue();
		else
			Code = code;
		//	clean code
		if (Code instanceof String)
		{
			if (Code.toString().startsWith("'") && Code.toString().endsWith("'")) {
				Code = Code.toString().substring(1);
				Code = Code.toString().substring(0, Code.toString().length()-2);
			}
		}
		if (infoDisplay != null)
			InfoDisplay = infoDisplay.trim();
		else if (code != null)
			InfoDisplay = code.toString();
	}	//	Restriction

	/**
	 * Restriction
	 * @param columnName
	 * @param operator
	 * @param code
	 * @param infoName
	 * @param infoDisplay
	 * @param andCondition
	 * @param notCondition
	 * @param depth
	 */
	Restriction (String columnName, String operator,
			Object code, String infoName, String infoDisplay, boolean andCondition,boolean notCondition, int depth)
	{
		this (columnName, operator, code, infoName, infoDisplay, andCondition, depth);

		this.notCondition = notCondition;

	} 	//	Restriction
	
	/**
	 * 	Range Restriction (BETWEEN)
	 * 	@param columnName ColumnName
	 * 	@param code Code, e.g 0, All%
	 * 	@param code_to Code, e.g 0, All%
	 *  @param infoName Display Name
	 * 	@param infoDisplay Display of Code (Lookup)
	 * 	@param infoDisplay_to Display of Code (Lookup)
	 * 	@param andCondition true->AND false->OR
	 *  @param depth number of parenthesis
	 */
	Restriction (String columnName,
		Object code, Object code_to,
		String infoName, String infoDisplay, String infoDisplay_to, boolean andCondition, int depth)
	{
		this(columnName, code, code_to,
				infoName, infoDisplay, infoDisplay_to, andCondition ? "AND" : "OR", depth);
	}

	/**
	 * 	Range Restriction (BETWEEN)
	 * 	@param columnName ColumnName
	 * 	@param code Code, e.g 0, All%
	 * 	@param code_to Code, e.g 0, All%
	 *  @param infoName Display Name
	 * 	@param infoDisplay Display of Code (Lookup)
	 * 	@param infoDisplay_to Display of Code (Lookup)
	 * 	@param andOrCondition AND/OR/AND NOT/OR NOT - concatenation of parenthesis
	 *  @param depth number of parenthesis
	 */
	Restriction (String columnName,
		Object code, Object code_to,
		String infoName, String infoDisplay, String infoDisplay_to, String andOrCondition, int depth)
	{
		this (columnName, MQuery.BETWEEN, code, infoName, infoDisplay, andOrCondition, depth);

		//	Code_to
		Code_to = code_to;
		if (Code_to instanceof String)
		{
			if (Code_to.toString().startsWith("'"))
				Code_to = Code_to.toString().substring(1);
			if (Code_to.toString().endsWith("'"))
				Code_to = Code_to.toString().substring(0, Code_to.toString().length()-2);
		}
		//	InfoDisplay_to
		if (infoDisplay_to != null)
			InfoDisplay_to = infoDisplay_to.trim();
		else if (Code_to != null)
			InfoDisplay_to = Code_to.toString();
	}	//	Restriction

	/**
	 * 	Range Restriction (BETWEEN)
	 * 	@param columnName ColumnName
	 * 	@param code Code, e.g 0, All%
	 * 	@param code_to Code, e.g 0, All%
	 *  @param infoName Display Name
	 * 	@param infoDisplay Display of Code (Lookup)
	 * 	@param infoDisplay_to Display of Code (Lookup)
	 */
	Restriction (String columnName,
		Object code, Object code_to,
		String infoName, String infoDisplay, String infoDisplay_to, boolean andCondition, boolean notCondition, int depth)
	{
		this (columnName, MQuery.BETWEEN, code, infoName, infoDisplay, andCondition, notCondition, depth);

		//	Code_to
		Code_to = code_to;
		if (Code_to instanceof String)
		{
			if (Code_to.toString().startsWith("'"))
				Code_to = Code_to.toString().substring(1);
			if (Code_to.toString().endsWith("'"))
				Code_to = Code_to.toString().substring(0, Code_to.toString().length()-2);
		}
		//	InfoDisplay_to
		if (infoDisplay_to != null)
			InfoDisplay_to = infoDisplay_to.trim();
		else if (Code_to != null)
			InfoDisplay_to = Code_to.toString();
	}	//	Restriction
	
	/**
	 * 	Create Restriction with direct WHERE clause
	 * 	@param whereClause SQL WHERE Clause
	 * 	@param andCondition true->AND false->OR
	 *  @param depth number of parenthesis
	 */
	Restriction (String whereClause, boolean andCondition, int depth)
	{
		this(whereClause, andCondition ? "AND" : "OR", depth);
	}

	/**
	 * 	Create Restriction with direct WHERE clause
	 * 	@param whereClause SQL WHERE Clause
	 * 	@param andOrCondition AND/OR/AND NOT/OR NOT - concatenation of parenthesis
	 *  @param depth number of parenthesis
	 */
	Restriction (String whereClause, String andOrCondition, int depth)
	{
		DirectWhereClause = whereClause;
		this.andOrCondition = andOrCondition;
		this.notCondition = false;
		this.existsCondition = false;
		this.joinDepth = depth;
	}	//	Restriction

	/**
	 * 	Create Restriction with direct WHERE clause
	 * 	@param whereClause SQL WHERE Clause
	 */
	Restriction (String whereClause, boolean andCondition, boolean notCondition, boolean existsCondition, int depth)
	{
		DirectWhereClause = whereClause;
		this.andOrCondition = andCondition ? "AND" : "OR";
		this.notCondition = notCondition;
		this.existsCondition = existsCondition;
		this.joinDepth = depth;
	}	//	Restriction

	/**
	 * 
	 * @param ColumnName
	 * @param ExistsClause
	 * @param Code
	 */
	Restriction (String ExistsClause, Object Code)
	{
		this.ExistsClause = ExistsClause;
		this.Code = Code;
	}	//	Restriction
	
	/**	Direct Where Clause	*/
	protected String	DirectWhereClause = null;
	/**	Exists Clause	*/
	protected String	ExistsClause = null;
	/**	Column Name			*/
	protected String 	ColumnName;
	/** Name				*/
	protected String	InfoName;
	/** Operator			*/
	protected String 	Operator;
	/** SQL Where Code		*/
	protected Object 	Code;
	/** Info				*/
	protected String 	InfoDisplay;
	/** SQL Where Code To	*/
	protected Object 	Code_to;
	/** Info To				*/
	protected String 	InfoDisplay_to;
	/** And/Or Condition	*/
	protected String	andOrCondition = "AND";
	/** And/Or condition nesting depth ( = number of open brackets at and/or) */
	protected int		joinDepth = 0;
	/** Not Condition	*/
	protected boolean	notCondition = false;	
	/** Exists Condition	*/
	protected boolean	existsCondition = false;

	/**
	 * 	Return SQL construct for this restriction
	 *  @param tableName optional table name
	 * 	@return SQL WHERE construct
	 */
	public String getSQL (String tableName)
	{
		if (DirectWhereClause != null)
			return DirectWhereClause;
		

		if(ExistsClause != null){
			StringBuilder sb = new StringBuilder();
			sb.append(ExistsClause);

			if (Code instanceof String)
				sb = new StringBuilder(sb.toString().replaceAll("\\?", DB.TO_STRING(Code.toString())));
			else if (Code instanceof Timestamp)
				sb = new StringBuilder(sb.toString().replaceAll("\\?", DB.TO_DATE((Timestamp)Code, false)));
			else
				sb = new StringBuilder(sb.toString().replaceAll("\\?", Code.toString()));

			return sb.toString();
		}
		
		// verify if is a virtual column, do not prefix tableName if this is a virtualColumn
		boolean virtualColumn = false;
		if (tableName != null && tableName.length() > 0) {
			MTable table = MTable.get(Env.getCtx(), tableName);
			if (table != null) {
				for (MColumn col : table.getColumns(false)) {
					String colSQL = col.getColumnSQL(true, false);
					if (colSQL != null && colSQL.contains("@"))
						colSQL = Env.parseContext(Env.getCtx(), -1, colSQL, false, true);
					if (colSQL != null && ColumnName.equals(colSQL.trim()))  {
						virtualColumn = true;
						break;
					}
				}
			}
		}
		//
		StringBuilder sb = new StringBuilder();
		if (!virtualColumn && tableName != null && tableName.length() > 0)
		{
			//	Assumes - REPLACE(INITCAP(variable),'s','X') or UPPER(variable)
			int pos = ColumnName.lastIndexOf('(')+1;	//	including (
			int end = ColumnName.indexOf(')');
			//	We have a Function in the ColumnName
			if (pos != -1 && end != -1 && !(pos-1==ColumnName.indexOf('(') && ColumnName.trim().startsWith("(")))
				sb.append(ColumnName.substring(0, pos))
					.append(tableName).append(".").append(DB.getDatabase().quoteColumnName(ColumnName.substring(pos, end)))
					.append(ColumnName.substring(end));
			else
			{
				int selectIndex = ColumnName.toLowerCase().indexOf("select ");
				int fromIndex = ColumnName.toLowerCase().indexOf(" from ");
				if (selectIndex >= 0 && fromIndex > 0) 
				{
					sb.append(ColumnName);
				}
				else
				{
					sb.append(tableName).append(".").append(DB.getDatabase().quoteColumnName(ColumnName));
				}
			}
		}
		else
			sb.append(virtualColumn ? ColumnName : DB.getDatabase().quoteColumnName(ColumnName));
		
		sb.append(Operator);
		if ( ! (Operator.equals(MQuery.NULL) || Operator.equals(MQuery.NOT_NULL)))
		{
			if (Code instanceof String) {
				if (ColumnName.toUpperCase().startsWith("UPPER(")) {
					sb.append("UPPER("+DB.TO_STRING(Code.toString())+")");
				} else {
					sb.append(DB.TO_STRING(Code.toString()));
				}
			}
			else if (Code instanceof Timestamp)
				sb.append(DB.TO_DATE((Timestamp)Code, false));
			else
				sb.append(Code);

			//	Between
			//	if (Code_to != null && InfoDisplay_to != null)
			if (MQuery.BETWEEN.equals(Operator))
			{
				sb.append(" AND ");
				if (Code_to instanceof String)
					sb.append(DB.TO_STRING(Code_to.toString()));
				else if (Code_to instanceof Timestamp)
					sb.append(DB.TO_DATE((Timestamp)Code_to, false));
				else
					sb.append(Code_to);
			}
		}
		return sb.toString();
	}	//	getSQL

	/**
	 * 	Get String Representation
	 * 	@return info
	 */
	public String toString()
	{
		return getSQL(null);
	}	//	toString

	/**
	 * 	Get Info Name
	 * 	@return Info Name
	 */
	public String getInfoName()
	{
		return InfoName;
	}	//	getInfoName

	/**
	 * 	Get Info Operator
	 * 	@return info Operator
	 */
	public String getInfoOperator()
	{
		for (int i = 0; i < MQuery.OPERATORS.length; i++)
		{
			if (MQuery.OPERATORS[i].getValue().equals(Operator))
				return Msg.getMsg(Env.getCtx(), MQuery.OPERATORS[i].getName());
		}
		return Operator;
	}	//	getInfoOperator

	/**
	 * 	Get Display with optional To
	 * 	@return info display
	 */
	public String getInfoDisplayAll()
	{
		if (InfoDisplay_to == null)
			return InfoDisplay;
		StringBuilder sb = new StringBuilder(InfoDisplay);
		sb.append(" - ").append(InfoDisplay_to);
		return sb.toString();
	}	//	getInfoDisplay

}	//	Restriction

class QueryEvaluatee implements Evaluatee {
	private Map<String, String> parameterMap;

	public QueryEvaluatee(Map<String, String> parameterMap) {
		this.parameterMap = parameterMap;
	}

	/**
	 * 	Get Variable Value (Evaluatee)
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (Properties ctx, String variableName)
	{
		//ref column
		String foreignColumn = "";
		int f = variableName.indexOf('.');
		if (f > 0) {
			foreignColumn = variableName.substring(f+1, variableName.length());
			variableName = variableName.substring(0, f);
		}

		String value = null;
		if (variableName.startsWith("#") || variableName.startsWith("$")) {
			value = Env.getContext(ctx, variableName);
		} else {
			value = parameterMap.get(variableName);
		}
		if (!Util.isEmpty(value) && !Util.isEmpty(foreignColumn) && variableName.endsWith("_ID")) {
			String refValue = "";
			int id = 0;
			try {
				id = Integer.parseInt(value);
			} catch (Exception e){}
			if (id > 0) {
				if (variableName.startsWith("#") || variableName.startsWith("$")) {
					variableName = variableName.substring(1);
				} else if (variableName.indexOf("|") > 0) {
					variableName = variableName.substring(variableName.lastIndexOf("|")+1);
				}
				String foreignTable = null;
				if (foreignColumn.indexOf(".") > 0) {
					foreignTable = foreignColumn.substring(0, foreignColumn.indexOf("."));
				} else {
					foreignTable = variableName.substring(0, variableName.length()-3);
				}
				MTable t = MTable.get(Env.getCtx(), foreignTable);
				if (t != null) {
					refValue = DB.getSQLValueString(null,
							"SELECT " + foreignColumn + " FROM " + foreignTable + " WHERE "
							+ foreignTable + "_ID = ?", id);
				}
			}
			return refValue;
		}
		return value;
	}	//	get_ValueAsString

	@Override
	public String get_ValueAsString(String variableName) {
		return get_ValueAsString(Env.getCtx(), variableName);
	}

}
