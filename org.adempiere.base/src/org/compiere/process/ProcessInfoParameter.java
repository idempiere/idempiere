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
import java.util.ArrayList;
import java.util.Arrays;

import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 * 	Process Parameter
 *
 *  @author Jorg Janke
 *  @version $Id: ProcessInfoParameter.java,v 1.2 2006/07/30 00:54:44 jjanke Exp $
 * 
 *  @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2430845 ] Add ProcessInfoParameter.getParameterAsBoolean method
 */
public class ProcessInfoParameter implements Serializable
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -5396796617617359891L;

	/**
	 *  Construct Parameter
	 *  @param parameterName parameter name
	 *  @param parameter parameter
	 *  @param parameter_To to parameter
	 *  @param info info
	 *  @param info_To to info
	 */
	public ProcessInfoParameter (String parameterName, Object parameter, Object parameter_To, String info, String info_To)
	{
		this(parameterName, parameter, parameter_To, info, info_To, false);
	}   //  ProcessInfoParameter
	
	/**
	 *  Construct Parameter
	 *  @param parameterName parameter name
	 *  @param parameter parameter
	 *  @param parameter_To to parameter
	 *  @param info info
	 *  @param info_To to info
	 *  @param isNotClause is not clause
	 */
	public ProcessInfoParameter (String parameterName, Object parameter, Object parameter_To, String info, String info_To, boolean isNotClause)
	{
		setParameterName (parameterName);
		setParameter (parameter);
		setParameter_To (parameter_To);
		setInfo (info);
		setInfo_To (info_To);
		setIsNotClause(isNotClause);
	}   //  ProcessInfoParameter

	private String 	m_ParameterName;
	private Object 	m_Parameter;
	private	Object	m_Parameter_To;
	private String	m_Info = "";
	private String 	m_Info_To = "";
	private boolean m_IsNotClause;

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString()
	{
		//	From .. To
		if (m_Parameter_To != null || m_Info_To.length() > 0)
			return "ProcessInfoParameter[" + m_ParameterName + "=" + m_Parameter
				+ (m_Parameter==null ? "" : "{" + m_Parameter.getClass().getName() + "}")
				+ " (" + m_Info + ") - "
				+ m_Parameter_To 
				+ (m_Parameter_To==null ? "" : "{" + m_Parameter_To.getClass().getName() + "}")
				+ " (" + m_Info_To + ")";
		//	Value
		return "ProcessInfoParameter[" + m_ParameterName + "=" + m_Parameter
			+ (m_Parameter==null ? "" : "{" + m_Parameter.getClass().getName() + "}")
			+ " (" + m_Info + ")";
	}	//	toString

	/**
	 * Get Info
	 * @return info text
	 */
	public String getInfo ()
	{
		return m_Info;
	}

	/**
	 * Get Info_To
	 * @return info text for to parameter
	 */
	public String getInfo_To ()
	{
		return m_Info_To;
	}

	/**
	 * Get Parameter
	 * @return parameter value
	 */
	public Object getParameter ()
	{
		return m_Parameter;
	}
	
	/**
	 * Get Parameter as Int
	 * @return parameter as integer value
	 */
	public int getParameterAsInt ()
	{
		if (m_Parameter == null)
			return 0;
		if (m_Parameter instanceof Number)
			return ((Number)m_Parameter).intValue();
		BigDecimal bd = new BigDecimal(m_Parameter.toString());
		return bd.intValue();
	}	//	getParameterAsInt
	
	/**
	 * Get Parameter as Boolean
	 * @return parameter as boolean value
	 */
	public boolean getParameterAsBoolean ()
	{
		if (m_Parameter == null)
			return false;
		if (m_Parameter instanceof Boolean)
			return ((Boolean)m_Parameter).booleanValue();
		return "Y".equals(m_Parameter);
	}

	/**
	 * Get Parameter_To
	 * @return to parameter value
	 */
	public Object getParameter_To ()
	{
		return m_Parameter_To;
	}

	/**
	 * Get Parameter To as Int
	 * @return to parameter as integer value
	 */
	public int getParameter_ToAsInt ()
	{
		if (m_Parameter_To == null)
			return 0;
		if (m_Parameter_To instanceof Number)
			return ((Number)m_Parameter_To).intValue();
		BigDecimal bd = new BigDecimal(m_Parameter_To.toString());
		return bd.intValue();
	}	//	getParameter_ToAsInt

	/**
	 * Get Parameter To as Boolean
	 * @return to parameter as boolean value
	 */
	public boolean getParameter_ToAsBoolean ()
	{
		if (m_Parameter_To == null)
			return false;
		if (m_Parameter_To instanceof Boolean)
			return ((Boolean)m_Parameter_To).booleanValue();
		return "Y".equals(m_Parameter_To);
	}
	
	/**
	 * Get Parameter_To as Timestamp
	 * @return to parameter as Timestamp value
	 */
	public Timestamp getParameter_ToAsTimestamp()
	{
		if (m_Parameter_To == null)
			return null;
		if (m_Parameter_To instanceof Timestamp)
			return (Timestamp) m_Parameter_To;
		return null;
	}  // getParameter_ToAsTimestamp

	/**
	 * Method getParameter as Timestamp
	 * @return Object
	 */
	public Timestamp getParameterAsTimestamp()
	{
		if (m_Parameter == null)
			return null;
		if (m_Parameter instanceof Timestamp)
			return (Timestamp) m_Parameter;
		return null;
	}	//	getParameterAsTimestamp

	
	/**
	 * Get Parameter To as String
	 * @return to parameter as string value
	 */
	public String getParameter_ToAsString()
	{
		if (m_Parameter_To == null)
			return null;
		return m_Parameter_To.toString();
	}	//	getParameter_ToAsString
	
	
	/**
	 * Get Parameter as String
	 * @return parameter as string value
	 */
	public String getParameterAsString()
	{
		if (m_Parameter == null)
			return null;
		return m_Parameter.toString();
	}	//	getParameterAsString
	
	/**
	 * Get Parameter To as BigDecimal
	 * @return to parameter as big decimal value
	 */
	public BigDecimal getParameter_ToAsBigDecimal ()
	{
		if (m_Parameter_To == null)
			return null;
		if (m_Parameter_To instanceof BigDecimal)
			return (BigDecimal) m_Parameter_To;
		return new BigDecimal(m_Parameter_To.toString());
	}	//	getParameter_ToAsBigDecimal

	/**
	 * Get Parameter as BigDecimal
	 * @return Parameter as big decimal value
	 */
	public BigDecimal getParameterAsBigDecimal ()
	{
		if (m_Parameter == null)
			return null;
		if (m_Parameter instanceof BigDecimal)
			return (BigDecimal) m_Parameter;
		return new BigDecimal(m_Parameter.toString());
	}	//	getParameterAsBigDecimal	
	
	/**
	 * Get ParameterName
	 * @return parameter name
	 */
	public String getParameterName ()
	{
		return m_ParameterName;
	}
	
	/**
	 * Is using Not Clause
	 * @return true if parameter is using not clause
	 */
	public boolean isNotClause() {
		return m_IsNotClause;
	}

	/**
	 * Set Info
	 * @param Info
	 */
	public void setInfo (String Info)
	{
		if (Info == null)
			m_Info = "";
		else
			m_Info = Info;
	}

	/**
	 * Set Info_To
	 * @param Info_To
	 */
	public void setInfo_To (String Info_To)
	{
		if (Info_To == null)
			m_Info_To = "";
		else
			m_Info_To = Info_To;
	}

	/**
	 * Set Parameter
	 * @param Parameter parameter value
	 */
	public void setParameter (Object Parameter)
	{
		m_Parameter = Parameter;
	}

	/**
	 * Set Parameter_To
	 * @param Parameter_To value for to parameter
	 */
	public void setParameter_To (Object Parameter_To)
	{
		m_Parameter_To = Parameter_To;
	}

	/**
	 * Set ParameterName
	 * @param ParameterName
	 */
	public void setParameterName (String ParameterName)
	{
		m_ParameterName = ParameterName;
	}
	
	/**
	 * Set Is using NotClause
	 * @param IsNotClause true to use not clause
	 */
	public void setIsNotClause(boolean IsNotClause) {
		this.m_IsNotClause = IsNotClause;
	}

	/**
	 * Get value of the parameter as a comma separated integer string.<br/>
	 * Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return comma separated integer string
	 */
	public String getParameterAsCSVInt() {
		return getParameterAsCSVInt(getParameterAsString());
	}

	/**
	 * Get value of the parameter To as a comma separated integer string.<br/>
	 * Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return comma separated integer string
	 */
	public String getParameter_ToAsCSVInt() {
		return getParameterAsCSVInt(getParameter_ToAsString());
	}

	/**
	 * Validate param is a comma separated integer string.<br/>
	 * Throw NumberFormatException if it is not. 
	 * @param param
	 * @return param
	 */
	private String getParameterAsCSVInt(String param) {

		if (Util.isEmpty(param))
			return "";

		String[] strarr = param.split(",");

		for (String par : strarr)
			Integer.valueOf(par);

		return param;
	}

	/**
	 * Get value of the parameter as a String with all values between commas surrounded by quotes
	 * @return CSV String with all values between commas surrounded by quotes
	 */
	public String getParameterAsCSVString() {
		return getParameterAsCSVString(getParameterAsString());
	}

	/**
	 * Get value of the parameter as a String with all values between commas surrounded by quotes
	 * @return CSV String with all values between commas surrounded by quotes
	 */
	public String getParameter_ToAsCSVString() {
		return getParameterAsCSVString(getParameter_ToAsString());
	}

	/**
	 * Convert param to a String with all values between commas surrounded by quotes
	 * @return CSV String with all values between commas surrounded by quotes
	 */
	private String getParameterAsCSVString(String param) {
		if (Util.isEmpty(param))
			return "";

		String[] strarr = ((String) param).split(",");

		StringBuilder whereValidated = new StringBuilder();
		for (String par : strarr) {
			if (whereValidated.length() > 0)
				whereValidated.append(",");
			whereValidated.append(DB.TO_STRING(par));
		}

		return whereValidated.toString();
	}

	/**
	 * Get value of the parameter as an array of int.<br/>
	 * Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return array of int
	 */
	public int[] getParameterAsIntArray() {
		return getParameterAsIntArray(getParameterAsString());
	}

	/**
	 * Get value of the parameter To as an array of int.<br/>
	 * Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return array of int
	 */
	public int[] getParameterToAsIntArray() {
		return getParameterAsIntArray(getParameter_ToAsString());
	}

	/**
	 * Convert param to array of int. 
	 * Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @param param CSV text
	 * @return array of int
	 */
	private int[] getParameterAsIntArray(String param) {

		if (Util.isEmpty(param))
			return new int[0];

		return Arrays.stream(param.split(",")).mapToInt(Integer::parseInt).toArray();  
	}

	/**
	 * Get value of the parameter as an array of String.
	 * @return array of String
	 */
	public String[] getParameterAsStringArray() {
		return getParameterAsStringArray(getParameterAsString());
	}

	/**
	 * Get value of the parameter To as an array of String.
	 * @return array of String
	 */
	public String[] getParameterToAsStringArray() {
		return getParameterAsStringArray(getParameter_ToAsString());
	}

	/**
	 * Convert param to array of String.
	 * @param param
	 * @return array of String
	 */
	private String[] getParameterAsStringArray(String param) {

		ArrayList<String> list = new ArrayList<String>();

		if (!Util.isEmpty(param)) {
			for (String par : param.split(","))
				list.add(par);
		}

		String[] retValue = new String[list.size()];
		list.toArray(retValue);
		return retValue;
	}
}   //  ProcessInfoParameter
