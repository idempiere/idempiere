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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.UUID;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *  Process Instance Log Model.
 * 	(not standard table and not using PO)
 *
 *  @author Jorg Janke
 *  @version $Id: MPInstanceLog.java,v 1.3 2006/07/30 00:58:18 jjanke Exp $
 */
public class MPInstanceLog
{
	/**
	 *	@param AD_PInstance_ID instance
	 *	@param Log_ID log sequence
	 *	@param P_Date date
	 *	@param P_ID id
	 *	@param P_Number number
	 *	@param P_Msg msg
	 */
	public MPInstanceLog (int AD_PInstance_ID, int Log_ID, Timestamp P_Date,
	  int P_ID, BigDecimal P_Number, String P_Msg)
	{
		this(AD_PInstance_ID, Log_ID, P_Date, P_ID, P_Number, P_Msg, 0, 0, null, X_AD_PInstance_Log.PINSTANCELOGTYPE_Result);
	}	//	MPInstance_Log

	/**
	 * @param AD_PInstance_ID
	 * @param Log_ID
	 * @param P_Date
	 * @param P_ID
	 * @param P_Number
	 * @param P_Msg
	 * @param AD_Table_ID
	 * @param Record_ID
	 */
	public MPInstanceLog (int AD_PInstance_ID, int Log_ID, Timestamp P_Date,
			int P_ID, BigDecimal P_Number, String P_Msg, int AD_Table_ID, int Record_ID)
	{
		this(AD_PInstance_ID, Log_ID, P_Date, P_ID, P_Number, P_Msg, AD_Table_ID, Record_ID, null, X_AD_PInstance_Log.PINSTANCELOGTYPE_Result);
	}	//	MPInstance_Log
	
	/**
	 * @param AD_PInstance_ID
	 * @param Log_ID
	 * @param P_Date
	 * @param P_ID
	 * @param P_Number
	 * @param P_Msg
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param PInstanceLogType Log Type X_AD_PInstance_Log.PINSTANCELOGTYPE_*
	 */
	public MPInstanceLog (int AD_PInstance_ID, int Log_ID, Timestamp P_Date,
			int P_ID, BigDecimal P_Number, String P_Msg, int AD_Table_ID, int Record_ID, String jsonData, String PInstanceLogType)
	{
		this("", AD_PInstance_ID, Log_ID, P_Date, P_ID, P_Number, P_Msg, AD_Table_ID, Record_ID, jsonData, PInstanceLogType);
	}
	
	/**
	 * Full Constructor
	 * @param AD_PInstance_Log_UU
	 * @param AD_PInstance_ID
	 * @param Log_ID
	 * @param P_Date
	 * @param P_ID
	 * @param P_Number
	 * @param P_Msg
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param PInstanceLogType Log Type X_AD_PInstance_Log.PINSTANCELOGTYPE_*
	 */
	public MPInstanceLog (String AD_PInstance_Log_UU, int AD_PInstance_ID, int Log_ID, Timestamp P_Date,
			int P_ID, BigDecimal P_Number, String P_Msg, int AD_Table_ID, int Record_ID, String jsonData, String PInstanceLogType)
	{
		setAD_PInstance_ID(AD_PInstance_ID);
		setLog_ID(Log_ID);
		setP_Date(P_Date);
		setP_ID(P_ID);
		setP_Number(P_Number);
		setP_Msg(P_Msg);
		setAD_Table_ID(AD_Table_ID);
		setRecord_ID(Record_ID);
		setJsonData(jsonData);
		setPInstanceLogType(PInstanceLogType);
		if(!Util.isEmpty(AD_PInstance_Log_UU))
			setAD_PInstance_Log_UU(AD_PInstance_Log_UU);
	}	//	MPInstance_Log

	/**
	 * 	Load Constructor
	 * 	@param rs Result Set
	 * 	@throws SQLException
	 */
	public MPInstanceLog (ResultSet rs) throws SQLException
	{
		setAD_PInstance_ID(rs.getInt(X_AD_PInstance_Log.COLUMNNAME_AD_PInstance_ID));
		setLog_ID(rs.getInt(X_AD_PInstance_Log.COLUMNNAME_Log_ID));
		setP_Date(rs.getTimestamp(X_AD_PInstance_Log.COLUMNNAME_P_Date));
		setP_ID(rs.getInt(X_AD_PInstance_Log.COLUMNNAME_P_ID));
		setP_Number(rs.getBigDecimal(X_AD_PInstance_Log.COLUMNNAME_P_Number));
		setP_Msg(rs.getString(X_AD_PInstance_Log.COLUMNNAME_P_Msg));
		setAD_Table_ID(rs.getInt(X_AD_PInstance_Log.COLUMNNAME_AD_Table_ID));
		setRecord_ID(rs.getInt(X_AD_PInstance_Log.COLUMNNAME_Record_ID));
		setJsonData(rs.getString(X_AD_PInstance_Log.COLUMNNAME_JsonData));
		setPInstanceLogType(rs.getString(X_AD_PInstance_Log.COLUMNNAME_PInstanceLogType));
		setAD_PInstance_Log_UU(rs.getString(X_AD_PInstance_Log.COLUMNNAME_AD_PInstance_Log_UU));
	}	//	MPInstance_Log

	private int m_AD_PInstance_ID;
	private int m_Log_ID;
	private Timestamp m_P_Date;
	private int m_P_ID;
	private BigDecimal m_P_Number;
	private String m_P_Msg;
	private int m_AD_Table_ID;
	private int m_Record_ID;
	private String m_jsonData;
	private String m_PInstanceLogType;
	private String m_AD_PInstance_Log_UU;

	/**
	 * 	String Representation
	 * 	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder("PPInstance_Log[");
		sb.append(m_Log_ID);
		if (m_P_Date != null)
			sb.append(",Date=").append(m_P_Date);
		if (m_P_ID != 0)
			sb.append(",ID=").append(m_P_ID);
		if (m_P_Number != null)
			sb.append(",Number=").append(m_P_Number);
		if (m_P_Msg != null)
			sb.append(",").append(m_P_Msg);
		if (m_jsonData != null)
			sb.append(",").append(m_jsonData);
		sb.append("]");
		return sb.toString();
	}	//	toString

	private final static String insertSql = "INSERT INTO AD_PInstance_Log "
			+ "(AD_PInstance_ID, Log_ID, P_Date, P_ID, P_Number, P_Msg, AD_Table_ID, Record_ID, AD_PInstance_Log_UU, JsonData, PInstanceLogType)"
			+ " VALUES (?,?,?,?,?,?,?,?,?," + DB.getJSONCast() + ",?) ";
	
	private final static String updateSql = "UPDATE AD_PInstance_Log "
			+ " SET P_Date = ?, "
			+ " 	P_ID = ?, "
			+ " 	P_Number = ?, "
			+ " 	P_Msg = ?, "
			+ " 	AD_Table_ID = ?, "
			+ " 	Record_ID = ?, "
			+ " 	JsonData = " + DB.getJSONCast() + ", "
			+ " 	PInstanceLogType = ? "
			+ " WHERE AD_PInstance_Log_UU = ? ";

	/**
	 *	Save to Database
	 * 	@return true if saved
	 */
	public boolean save ()
	{
		int no = DB.executeUpdate(insertSql, getParams(true), false, null);	//	outside of trx
		return no == 1;
	} 	//	save

	/**
	 *	Save to Database, throw Exception if there are errors.
	 */
	public void saveEx ()
	{
		DB.executeUpdateEx(insertSql, getParams(true), null);	//	outside of trx
	} 	//	saveEx

	/**
	 *	Update record in Database
	 * 	@return true if saved
	 */
	public boolean update ()
	{
		int no = DB.executeUpdate(updateSql, getParams(false), false, null);	//	outside of trx
		return no == 1;
	} 	//	update

	/**
	 *	Update record in Database, throw Exception if there are errors.
	 */
	public void updateEx ()
	{
		DB.executeUpdateEx(updateSql, getParams(false), null);	//	outside of trx
	} 	//	updateEx
	
	/**
	 * Get parameters for SQL INSERT or UPDATE
	 * @param isInsert - if true, get parameters for INSERT, else get parameters for UPDATE
	 * @return Object[] parameters
	 */
	private Object[] getParams(boolean isInsert) {
		MColumn colMsg = MColumn.get(Env.getCtx(), I_AD_PInstance_Log.Table_Name, I_AD_PInstance_Log.COLUMNNAME_P_Msg);
		int maxMsgLength = colMsg.getFieldLength();
		ArrayList<Object> params = new ArrayList <Object>();
				
		if(isInsert) {
			params.add(m_AD_PInstance_ID);
			params.add(m_Log_ID);
		}
		params.add(m_P_Date != null ? m_P_Date : null);
		
		params.add(m_P_ID != 0 ? m_P_ID : null);
		
		params.add(m_P_Number != null ? m_P_Number : null);
		
		if (m_P_Msg != null) {
			params.add(m_P_Msg.length() > maxMsgLength ? m_P_Msg.substring(0,  maxMsgLength) : m_P_Msg);
		}
		else {
			params.add(null);
		}
		
		params.add(m_AD_Table_ID != 0 ? m_AD_Table_ID : null);
		
		params.add(m_Record_ID != 0 ? m_Record_ID : null);
		
		if(isInsert)
			params.add(getAD_PInstance_Log_UU());
		
		params.add(m_jsonData);
		
		params.add(m_PInstanceLogType);
		
		if(!isInsert)
			params.add(getAD_PInstance_Log_UU());
		
		return params.toArray();
	}	//	getParams
	
	/**
	 * 	Get AD_PInstance_ID
	 *	@return AD_PInstance_ID
	 */
	public int getAD_PInstance_ID ()
	{
		return m_AD_PInstance_ID;
	}

	/**
	 * 	Set AD_PInstance_ID
	 *	@param AD_PInstance_ID instance id
	 */
	public void setAD_PInstance_ID (int AD_PInstance_ID)
	{
		m_AD_PInstance_ID = AD_PInstance_ID;
	}

	/**
	 * 	Get Log_ID
	 *	@return Log_ID
	 */
	public int getLog_ID ()
	{
		return m_Log_ID;
	}

	/**
	 * 	Set Log_ID
	 *	@param Log_ID log id
	 */
	public void setLog_ID (int Log_ID)
	{
		m_Log_ID = Log_ID;
	}

	/**
	 * 	Get P_Date
	 *	@return P_Date
	 */
	public Timestamp getP_Date ()
	{
		return m_P_Date;
	}

	/**
	 * 	Set P_Date
	 *	@param P_Date date
	 */
	public void setP_Date (Timestamp P_Date)
	{
		m_P_Date = P_Date;
	}

	/**
	 * 	Get P_ID
	 *	@return P_ID
	 */
	public int getP_ID ()
	{
		return m_P_ID;
	}

	/**
	 * 	Set P_ID
	 *	@param P_ID id
	 */
	public void setP_ID (int P_ID)
	{
		m_P_ID = P_ID;
	}

	/**
	 * 	Get P_Number
	 *	@return P_Number
	 */
	public BigDecimal getP_Number ()
	{
		return m_P_Number;
	}

	/**
	 * 	Set P_Number
	 *	@param P_Number number
	 */
	public void setP_Number (BigDecimal P_Number)
	{
		m_P_Number = P_Number;
	}

	/**
	 * 	Get P_Msg
	 *	@return P_Msg
	 */
	public String getP_Msg ()
	{
		return m_P_Msg;
	}

	/**
	 * 	Set P_Msg
	 *	@param P_Msg
	 */
	public void setP_Msg (String P_Msg)
	{
		m_P_Msg = P_Msg;
	}

	/**
	 * Get Table ID
	 * @return AD_Table_ID
	 */
	public int getAD_Table_ID()
	{
		return m_AD_Table_ID;
	}

	/**
	 * Set Table ID
	 * @param tableId
	 */
	public void setAD_Table_ID(int tableId)
	{
		m_AD_Table_ID = tableId;
	}

	/**
	 * Get Record ID
	 * @return Record_ID
	 */
	public int getRecord_ID()
	{
		return m_Record_ID;
	}

	/**
	 * Set Record ID
	 * @param recordId
	 */
	public void setRecord_ID(int recordId)
	{
		m_Record_ID = recordId;
	}

	/**
	 * Get JsonData
	 * @return JsonData
	 */
	public String getJsonData() {
		return m_jsonData;
	}
	/**
	 * Set JsonData
	 * @param jsonData
	 */
	public void setJsonData(String jsonData) {
		this.m_jsonData = jsonData;
	}

	/**
	 * Get Log Type
	 * @return Instance Log Type (X_AD_PInstance_Log.PINSTANCELOGTYPE_*)
	 */
	public String getPInstanceLogType() {
		return m_PInstanceLogType;
	}

	/**
	 * Set Log Type
	 * @param m_PInstanceLogType X_AD_PInstance_Log.PINSTANCELOGTYPE_*
	 */
	public void setPInstanceLogType(String m_PInstanceLogType) {
		this.m_PInstanceLogType = m_PInstanceLogType;
	}

	/**
	 * Set AD_PInstance_Log_UU
	 * @return String AD_PInstance_Log_UU
	 */
	public String getAD_PInstance_Log_UU() {
		if(Util.isEmpty(m_AD_PInstance_Log_UU))
			m_AD_PInstance_Log_UU = UUID.randomUUID().toString();
		return m_AD_PInstance_Log_UU;
	}
	
	/**
	 * Get AD_PInstance_Log_UU
	 * @param m_AD_PInstance_Log_UU
	 */
	public void setAD_PInstance_Log_UU(String m_AD_PInstance_Log_UU) {
		this.m_AD_PInstance_Log_UU = m_AD_PInstance_Log_UU;
	}

} //	MPInstance_Log
