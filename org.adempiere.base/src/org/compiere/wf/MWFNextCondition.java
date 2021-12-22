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
package org.compiere.wf;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;
import org.compiere.model.X_AD_WF_NextCondition;

/**
 *	Workflow Transition Condition
 *	
 *  @author Jorg Janke
 *  @version $Id: MWFNextCondition.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 		<li>BF [ 1943720 ] WF Next Condition: handling boolean values is poor
 */
public class MWFNextCondition extends X_AD_WF_NextCondition implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3119863973003103716L;

	/**
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param id id
	 * 	@param trxName transaction
	 */
	public MWFNextCondition (Properties ctx, int id, String trxName)
	{
		super (ctx, id, trxName);
	}	//	MWFNextCondition

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 * 	@param trxName transaction
	 */
	public MWFNextCondition (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MWFNextCondition
	
	/**
	 * 
	 * @param copy
	 */
	public MWFNextCondition(MWFNextCondition copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MWFNextCondition(Properties ctx, MWFNextCondition copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWFNextCondition(Properties ctx, MWFNextCondition copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_numeric = copy.m_numeric;
	}
	
	/**	Numeric evaluation		*/
	private boolean		m_numeric = true;
	
	/**
	 * 	Is Or Condition
	 * 	@return true if OR
	 */
	public boolean isOr()
	{
		return ANDOR_Or.equals(getAndOr());
	}	//	isOr
	
	/**
	 * 	Evaluate Condition
	 * 	@param activity activity
	 *	@return true if true
	 */
	public boolean evaluate (MWFActivity activity)
	{
		return evaluate(activity.getPO());
	}	//	evaluate
	
	/**
	 * 	Evaluate Condition
	 * 	@param po PO
	 *	@return true if true
	 */
	protected boolean evaluate (PO po)
	{
		if (getAD_Column_ID() == 0 && Util.isEmpty(getSQLStatement(), true))
			throw new IllegalStateException("No Column and SQL Statement defined - " + this);
			
		if (po == null || po.get_ID() == 0)
			throw new IllegalStateException("Could not evaluate " + po + " - " + this);
		//
		if (getOperation().equals(OPERATION_Sql)) {
			String sqlStatement = getSQLStatement();
			if (Util.isEmpty(getSQLStatement(), true))
				return false;
			if (sqlStatement.indexOf("@") >= 0)
				sqlStatement = Env.parseVariable(sqlStatement, po, po.get_TrxName(), false);
			String result = DB.getSQLValueStringEx(po.get_TrxName(), sqlStatement);
			return "true".equalsIgnoreCase(result) || "y".equalsIgnoreCase(result);
		}
		//
		Object valueObj = null;
		if (!Util.isEmpty(getSQLStatement(), true)) {
			try {
				valueObj = getColumnSQLValue(po);
			} catch (SQLException e) {
				throw new RuntimeException("Could not get result from column sql: " + getSQLStatement(), e);
			}
		} else {
			valueObj = po.get_ValueOfColumn(getAD_Column_ID());
		}		
		if (valueObj == null)
			valueObj = "";
		String value1 = getDecodedValue(getValue(), po);	// F3P: added value decoding
		if (value1 == null)
			value1 = "";
		String value2 = getDecodedValue(getValue2(), po);	// F3P: added value decoding
		if (value2 == null)
			value2 = "";
		
		String resultStr = "PO:{" + valueObj + "} " + getOperation() + " Condition:{" + value1 + "}";
		if (getOperation().equals(OPERATION_X))
			resultStr += "{" + value2 + "}";

		boolean result = false;
		if (valueObj instanceof Number)
			result = compareNumber ((Number)valueObj, value1, value2);
		else if (valueObj instanceof Boolean)
			result = compareBoolean((Boolean)valueObj, value1, value2);
		else
			result = compareString(valueObj, value1, value2);
		//
		if (log.isLoggable(Level.FINE)) log.fine(resultStr + " -> " + result 
			+ (m_numeric ? " (#)" : " ($)"));
		return result;
	}	//	evaluate
	
	/**
	 * F3P: Decode value string, for each substring enclosed in @:
	 *  COL= remaining value is interpreted as a column of the associated record
	 * 
	 * @param sValue value to be decoded
	 * @param po PO model object bound to the activity
	 * @return
	 */
	protected String getDecodedValue(String sValue, PO po)
	{		
		String sRet = sValue;
		
		if (sValue == null)
			;
		else if (sValue.startsWith("@COL="))
		{
			Object o = po.get_Value(sValue.substring(5));  
			//
			if(o != null)
				sRet = o.toString();
		}
		else if (sValue.startsWith("@") 
				&& sValue.endsWith("@")
				&& sValue.length() > 1)
		{
			sRet = Env.parseVariable (sValue, po, null, false);
		}
		
		return sRet;
	}
	
	/**
	 * 	Compare Number
	 *	@param valueObj comparator
	 *	@param value1 first value
	 *	@param value2 second value
	 *	@return true if operation
	 */
	private boolean compareNumber (Number valueObj, String value1, String value2)
	{
		BigDecimal valueObjB = null;
		BigDecimal value1B = null;
		BigDecimal value2B = null;
		try
		{
			if (valueObj instanceof BigDecimal)
				valueObjB = (BigDecimal)valueObj;
			else if (valueObj instanceof Integer)
				valueObjB = new BigDecimal (((Integer)valueObj).intValue());
			else
				valueObjB = new BigDecimal (String.valueOf(valueObj));
		}
		catch (Exception e)
		{
			if (log.isLoggable(Level.FINE)) log.fine("compareNumber - valueObj=" + valueObj + " - " + e.toString());
			return compareString(valueObj, value1, value2);
		}
		try
		{
			value1B = new BigDecimal (value1);
		}
		catch (Exception e)
		{
			if (log.isLoggable(Level.FINE)) log.fine("compareNumber - value1=" + value1 + " - " + e.toString());
			return compareString(valueObj, value1, value2);
		}
		
		String op = getOperation();
		if (OPERATION_Eq.equals(op))
			return valueObjB.compareTo(value1B) == 0;
		else if (OPERATION_Gt.equals(op))
			return valueObjB.compareTo(value1B) > 0;
		else if (OPERATION_GtEq.equals(op))
			return valueObjB.compareTo(value1B) >= 0;
		else if (OPERATION_Le.equals(op))
			return valueObjB.compareTo(value1B) < 0;
		else if (OPERATION_LeEq.equals(op))
			return valueObjB.compareTo(value1B) <= 0;
		else if (OPERATION_Like.equals(op))
			return valueObjB.compareTo(value1B) == 0;
		else if (OPERATION_NotEq.equals(op))
			return valueObjB.compareTo(value1B) != 0;
		//
		else if (OPERATION_Sql.equals(op))
			throw new IllegalArgumentException("SQL not Implemented");
		//
		else if (OPERATION_X.equals(op))
		{
			if (valueObjB.compareTo(value1B) < 0)
				return false;
			//	To
			try
			{
				value2B = new BigDecimal (String.valueOf(value2));
				return valueObjB.compareTo(value2B) <= 0;
			}
			catch (Exception e)
			{
				if (log.isLoggable(Level.FINE)) log.fine("compareNumber - value2=" + value2 + " - " + e.toString());
				return false;
			}
		}
		//
		throw new IllegalArgumentException("Unknown Operation=" + op);
	}	//	compareNumber
	
	/**
	 * 	Compare String
	 *	@param valueObj comparator
	 *	@param value1S first value
	 *	@param value2S second value
	 *	@return true if operation
	 */
	private boolean compareString (Object valueObj, String value1S, String value2S)
	{
		m_numeric = false;
		String valueObjS = String.valueOf(valueObj);
		//
		String op = getOperation();
		if (OPERATION_Eq.equals(op))
			return valueObjS.compareTo(value1S) == 0;
		else if (OPERATION_Gt.equals(op))
			return valueObjS.compareTo(value1S) > 0;
		else if (OPERATION_GtEq.equals(op))
			return valueObjS.compareTo(value1S) >= 0;
		else if (OPERATION_Le.equals(op))
			return valueObjS.compareTo(value1S) < 0;
		else if (OPERATION_LeEq.equals(op))
			return valueObjS.compareTo(value1S) <= 0;
		else if (OPERATION_Like.equals(op))
			return valueObjS.compareTo(value1S) == 0;
		else if (OPERATION_NotEq.equals(op))
			return valueObjS.compareTo(value1S) != 0;
		//
		else if (OPERATION_Sql.equals(op))
			throw new IllegalArgumentException("SQL not Implemented");
		//
		else if (OPERATION_X.equals(op))
		{
			if (valueObjS.compareTo(value1S) < 0)
				return false;
			//	To
			return valueObjS.compareTo(value2S) <= 0;
		}
		//
		throw new IllegalArgumentException("Unknown Operation=" + op);
	}	//	compareString
	
	/**
	 * 	Compare Boolean
	 *	@param valueObj comparator
	 *	@param value1S first value
	 *	@param value2S second value
	 *	@return true if operation
	 */
	private boolean compareBoolean (Boolean valueObj, String value1S, String value2S)
	{
		m_numeric = false;
		//
		Boolean value1B = Boolean.valueOf(value1S) || "Y".equalsIgnoreCase(value1S);
		//
		String op = getOperation();
		if (OPERATION_Eq.equals(op))
			return valueObj.equals(value1B);
		else if (OPERATION_NotEq.equals(op))
			return !valueObj.equals(value1B);
		else
			throw new IllegalArgumentException("Not Supported =" + op);
	}	//	compareBoolean

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MWFNextCondition[");
		sb.append(get_ID()).append(",SeqNo=").append(getSeqNo())
			.append ("]");
		return sb.toString ();
	} //	toString
	
	@Override
	public MWFNextCondition markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
	
	/**
	 * Get value from Column SQL (SQLStatement) instead of from AD_Column_ID
	 * @param po
	 * @return Value from Column SQL
	 * @throws SQLException 
	 */
	private Object getColumnSQLValue(PO po) throws SQLException {
		String columnSQL = getSQLStatement();
		if (columnSQL.indexOf("@") >= 0) {
			columnSQL = Env.parseVariable(columnSQL, po, po.get_TrxName(), false);
		}
		String tableName = po.get_TableName();
		String pkName = po.get_KeyColumns() != null && po.get_KeyColumns().length==1 ? po.get_KeyColumns()[0] : po.getUUIDColumnName();

		String resultSql = String.format("SELECT (%s) FROM %s WHERE %s = ?", columnSQL, tableName, pkName);

		try (PreparedStatement pstmt = DB.prepareStatement(resultSql, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY, po.get_TrxName())) {
			if (pkName.endsWith("_UU"))
				pstmt.setString(1, po.get_ValueAsString(po.getUUIDColumnName()));				
			else
				pstmt.setInt(1, po.get_ID());
			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getObject(1);
		}
		return null;
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (!Util.isEmpty(getSQLStatement(), true)) {
			setAD_Column_ID(0);
		}
		return true;
	}	 
}	//	MWFNextCondition