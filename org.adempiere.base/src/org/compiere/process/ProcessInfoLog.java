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
package org.compiere.process;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 	Process Info Log (VO)
 *
 *  @author Jorg Janke
 *  @version $Id: ProcessInfoLog.java,v 1.3 2006/07/30 00:54:44 jjanke Exp $
 */
public class ProcessInfoLog implements Serializable
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2790364724540395200L;

	/**
	 * 	Create Process Info Log.
	 *  @param AD_PInstance_Log_UU Log UU
	 *	@param Log_ID Log ID
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@param AD_Table_ID Table ID
	 *	@param Record_ID Record ID
	 *  @param jsonData jsonData
	 *	@param PInstanceLogType Log Type
	 */
	public ProcessInfoLog (String AD_PInstance_Log_UU, int Log_ID,int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg, int AD_Table_ID ,int Record_ID, String jsonData, String PInstanceLogType)
	{
		setLog_ID (Log_ID);
		setP_ID (P_ID);
		setP_Date (P_Date);
		setP_Number (P_Number);
		setP_Msg (P_Msg);
		setAD_Table_ID(AD_Table_ID);
		setRecord_ID(Record_ID);
		setJsonData(jsonData);
		setPInstanceLogType(PInstanceLogType);
		setAD_PInstance_Log_UU(AD_PInstance_Log_UU);
		
	}	//	ProcessInfoLog
	
	/**
	 * 	Create Process Info Log.
	 *	@param Log_ID Log ID
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@param AD_Table_ID Table ID
	 *	@param Record_ID Record ID
	 */
	public ProcessInfoLog (int Log_ID,int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg, int AD_Table_ID ,int Record_ID)
	{
		this("", Log_ID, P_ID, P_Date, P_Number, P_Msg, AD_Table_ID, Record_ID, null, null);
	}
	
	/**
	 * 	Create Process Info Log.
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@param AD_Table_ID Table ID
	 *	@param Record_ID Record ID
	 *	@param PInstanceLogType Log Type
	 */
	public ProcessInfoLog (int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg, int AD_Table_ID ,int Record_ID, String PInstanceLogType)
	{
		this("", s_Log_ID++, P_ID, P_Date, P_Number, P_Msg, AD_Table_ID, Record_ID, null, PInstanceLogType);
	}
	
	/**
	 * 	Create Process Info Log.
	 *  @param AD_PInstance_Log_UU Log UU
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@param AD_Table_ID Table ID
	 *	@param Record_ID Record ID
	 */
	public ProcessInfoLog (String AD_PInstance_Log_UU, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg, int AD_Table_ID ,int Record_ID)
	{
		this(AD_PInstance_Log_UU, s_Log_ID++, P_ID, P_Date, P_Number, P_Msg, AD_Table_ID, Record_ID, null, null);
	}

	/**
	 * 	Create Process Info Log.
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@param AD_Table_ID Table ID
	 *	@param Record_ID Record ID
	 */
	public ProcessInfoLog (int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg , int AD_Table_ID ,int Record_ID)
	{
		this (s_Log_ID++, P_ID, P_Date, P_Number, P_Msg, AD_Table_ID,Record_ID);
	}

	/**
	 * 	Create Process Info Log.
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 */
	public ProcessInfoLog (int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		this (s_Log_ID++, P_ID, P_Date, P_Number, P_Msg, 0,0);
	}	//	ProcessInfoLog

	/**
	 * 	Create Process Info Log.
	 *	@param Log_ID Log ID
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 */
	public ProcessInfoLog (int Log_ID, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		this (Log_ID, P_ID, P_Date, P_Number, P_Msg, 0,0);
	}	//	ProcessInfoLog
	
	/**
	 * 	Create Process Info Log.
	 *	@param AD_PInstance_Log_UU Log UU
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@param PInstanceLogType Log Type
	 */
	public ProcessInfoLog (String AD_PInstance_Log_UU, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg, String PInstanceLogType)
	{
		this (AD_PInstance_Log_UU, s_Log_ID++, P_ID, P_Date, P_Number, P_Msg, 0, 0, null, PInstanceLogType);
	}	//	ProcessInfoLog
	
	/**
	 * 	Create Process Info Log.
	 *	@param AD_PInstance_Log_UU Log UU
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 */
	public ProcessInfoLog (String AD_PInstance_Log_UU, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		this (AD_PInstance_Log_UU, s_Log_ID++, P_ID, P_Date, P_Number, P_Msg, 0,0, null, null);
	}	//	ProcessInfoLog
	
	/**
	 * 	Create Process Info Log.
	 *	@param Log_ID Log ID
	 *	@param P_ID ID parameter, usually same as record id
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@param PInstanceLogType Log Type
	 */
	public ProcessInfoLog (int Log_ID, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg, String PInstanceLogType)
	{
		this ("", Log_ID, P_ID, P_Date, P_Number, P_Msg, 0, 0, null, PInstanceLogType);
	}	//	ProcessInfoLog

	private static int	s_Log_ID = 0;

	private int 		m_Log_ID;
	private int 		m_P_ID;
	private Timestamp 	m_P_Date;
	private BigDecimal	m_P_Number;
	private String 		m_P_Msg;
	private int 		m_AD_Table_ID;
	private int 		m_Record_ID;
	private String 		m_JsonData;
	private String 		m_PInstanceLogType;
	private String		m_AD_PInstance_Log_UU;

	/**
	 * Get AD_Table_ID
	 * @return AD_Table_ID
	 */
	public int getAD_Table_ID() {
		return m_AD_Table_ID;
	}

	/**
	 * Set AD_Table_ID
	 * @param tableId AD_Table_ID
	 */
	public void setAD_Table_ID(int tableId) {
		this.m_AD_Table_ID = tableId;
	}

	/**
	 * Get record id
	 * @return record id
	 */
	public int getRecord_ID() {
		return m_Record_ID;
	}

	public void setRecord_ID(int recordId) {
		this.m_Record_ID = recordId;
	}
	/**
	 * Get Log_ID
	 * @return id
	 */
	public int getLog_ID()
	{
		return m_Log_ID;
	}
	/**
	 * 	Set Log_ID
	 *	@param Log_ID id
	 */
	public void setLog_ID (int Log_ID)
	{
		m_Log_ID = Log_ID;
	}

	/**
	 * Get P_ID
	 * @return id value
	 */
	public int getP_ID()
	{
		return m_P_ID;
	}
	/**
	 * Set P_ID
	 * @param P_ID
	 */
	public void setP_ID (int P_ID)
	{
		m_P_ID = P_ID;
	}

	/**
	 * Get P_Date
	 * @return Timestamp
	 */
	public Timestamp getP_Date()
	{
		return m_P_Date;
	}
	/**
	 * Set P_Date
	 * @param P_Date Timestamp
	 */
	public void setP_Date (Timestamp P_Date)
	{
		m_P_Date = P_Date;
	}

	/**
	 * Get P_Number
	 * @return BigDecimal
	 */
	public BigDecimal getP_Number()
	{
		return m_P_Number;
	}
	/**
	 * Method setP_Number
	 * @param P_Number BigDecimal
	 */
	public void setP_Number (BigDecimal P_Number)
	{
		m_P_Number = P_Number;
	}

	/**
	 * Get P_Msg
	 * @return Message
	 */
	public String getP_Msg()
	{
		return m_P_Msg;
	}
	/**
	 * Set P_Msg
	 * @param P_Msg
	 */
	public void setP_Msg (String P_Msg)
	{
		m_P_Msg = P_Msg;
	}

	/**
	 * Get JsonData
	 * @returnJsonData
	 */
	public String getJsonData() {
		return m_JsonData;
	}
	/**
	 * Set JsonData
	 * @param jsonData
	 */
	public void setJsonData(String jsonData) {
		this.m_JsonData = jsonData;
	}

	/**
	 * Get Log Type
	 * @return Log Type
	 */
	public String getPInstanceLogType() {
		return m_PInstanceLogType;
	}

	/**
	 * Set Log Type
	 * @param m_PInstanceLogType
	 */
	public void setPInstanceLogType(String m_PInstanceLogType) {
		this.m_PInstanceLogType = m_PInstanceLogType;
	}

	/**
	 * Set AD_PInstance_Log_UU
	 * @return String AD_PInstance_Log_UU
	 */
	public String getAD_PInstance_Log_UU() {
		return m_AD_PInstance_Log_UU;
	}
	
	/**
	 * Get AD_PInstance_Log_UU
	 * @param m_AD_PInstance_Log_UU
	 */
	public void setAD_PInstance_Log_UU(String m_AD_PInstance_Log_UU) {
		this.m_AD_PInstance_Log_UU = m_AD_PInstance_Log_UU;
	}

}	//	ProcessInfoLog
