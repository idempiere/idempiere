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
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2430845 ] Add ProcessInfoParameter.getParameterAsBoolean method
 */
public class ProcessInfoParameter implements Serializable
{

	/**
	 * 
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
		setParameterName (parameterName);
		setParameter (parameter);
		setParameter_To (parameter_To);
		setInfo (info);
		setInfo_To (info_To);
	}   //  ProcessInfoParameter

	private String 	m_ParameterName;
	private Object 	m_Parameter;
	private	Object	m_Parameter_To;
	private String	m_Info = "";
	private String 	m_Info_To = "";

	/**
	 * 	String Representation
	 *	@return info
	 */
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
	 * Method getInfo
	 * @return String
	 */
	public String getInfo ()
	{
		return m_Info;
	}

	/**
	 * Method getInfo_To
	 * @return String
	 */
	public String getInfo_To ()
	{
		return m_Info_To;
	}

	/**
	 * Method getParameter
	 * @return Object
	 */
	public Object getParameter ()
	{
		return m_Parameter;
	}
	
	/**
	 * Method getParameter as Int
	 * @return Object
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
	 * Method getParameter as Boolean
	 * @return boolean value
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
	 * Method getParameter_To
	 * @return Object
	 */
	public Object getParameter_To ()
	{
		return m_Parameter_To;
	}

	/**
	 * Method getParameter as Int
	 * @return Object
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
	 * Method getParameter as Boolean
	 * @return boolean
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
	 * Method getParameter_To as Timestamp
	 * @return Timestamp
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
	 * Method getParameter To as String
	 * @return Object
	 */
	public String getParameter_ToAsString()
	{
		if (m_Parameter_To == null)
			return null;
		return m_Parameter_To.toString();
	}	//	getParameter_ToAsString
	
	
	/**
	 * Method getParameter as String
	 * @return Object
	 */
	public String getParameterAsString()
	{
		if (m_Parameter == null)
			return null;
		return m_Parameter.toString();
	}	//	getParameterAsString
	
	/**
	 * Method getParameter To as BigDecimal
	 * @return Object
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
	 * Method getParameter as BigDecimal
	 * @return Object
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
	 * Method getParameterName
	 * @return String
	 */
	public String getParameterName ()
	{
		return m_ParameterName;
	}

	/**
	 * Method setInfo
	 * @param Info String
	 */
	public void setInfo (String Info)
	{
		if (Info == null)
			m_Info = "";
		else
			m_Info = Info;
	}

	/**
	 * Method setInfo_To
	 * @param Info_To String
	 */
	public void setInfo_To (String Info_To)
	{
		if (Info_To == null)
			m_Info_To = "";
		else
			m_Info_To = Info_To;
	}

	/**
	 * Method setParameter
	 * @param Parameter Object
	 */
	public void setParameter (Object Parameter)
	{
		m_Parameter = Parameter;
	}

	/**
	 * Method setParameter_To
	 * @param Parameter_To Object
	 */
	public void setParameter_To (Object Parameter_To)
	{
		m_Parameter_To = Parameter_To;
	}

	/**
	 * Method setParameterName
	 * @param ParameterName String
	 */
	public void setParameterName (String ParameterName)
	{
		m_ParameterName = ParameterName;
	}

	/**
	 * Return the value of the parameter as a comma separated integer string. Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return String
	 */
	public String getParameterAsCSVInt() {
		return getParameterAsCSVInt(getParameterAsString());
	}

	/**
	 * Return the value of the parameter To as a comma separated integer string. Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return String
	 */
	public String getParameter_ToAsCSVInt() {
		return getParameterAsCSVInt(getParameter_ToAsString());
	}

	/**
	 * Return the value of the parameter as a validated String (all values between commas must be integer)
	 * @return String
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
	 * Return the value of the parameter as a String with all values between commas surrounded by quotes
	 * @return String
	 */
	public String getParameterAsCSVString() {
		return getParameterAsCSVString(getParameterAsString());
	}

	/**
	 * Return the value of the parameter as a String with all values between commas surrounded by quotes
	 * @return String
	 */
	public String getParameter_ToAsCSVString() {
		return getParameterAsCSVString(getParameter_ToAsString());
	}

	/**
	 * Return the value of the parameter as a String with all values between commas surrounded by quotes
	 * @return String
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
	 * Return the value of the parameter as an array of int. Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return array of int
	 */
	public int[] getParameterAsIntArray() {
		return getParameterAsIntArray(getParameterAsString());
	}

	/**
	 * Return the value of the parameter To as an array of int. Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return array of int
	 */
	public int[] getParameterToAsIntArray() {
		return getParameterAsIntArray(getParameter_ToAsString());
	}

	/**
	 * Return the value of the parameter as an array of int. Validate every value is an integer and throws NumberFormatException if one of the value is not a valid integer.
	 * @return array of int
	 */
	private int[] getParameterAsIntArray(String param) {

		if (Util.isEmpty(param))
			return new int[0];

		return Arrays.stream(param.split(",")).mapToInt(Integer::parseInt).toArray();  
	}

	/**
	 * Return the value of the parameter as an array of String.
	 * @return array of String
	 */
	public String[] getParameterAsStringArray() {
		return getParameterAsStringArray(getParameterAsString());
	}

	/**
	 * Return the value of the parameter To as an array of String.
	 * @return array of String
	 */
	public String[] getParameterToAsStringArray() {
		return getParameterAsStringArray(getParameter_ToAsString());
	}

	/**
	 * Return the value of the parameter as an array of String.
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
