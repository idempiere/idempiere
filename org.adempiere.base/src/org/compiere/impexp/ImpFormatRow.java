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
 * Contributor(s): Teo Sarca
 *****************************************************************************/
package org.compiere.impexp;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.Callout;
import org.compiere.model.X_AD_ImpFormat_Row;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *	Import Format Row with parsing capability
 *
 *  @author Jorg Janke
 *  @author Trifon Trifonov, Catura AG (www.catura.de)
 *				<li>FR [ 3010957 ] Custom Separator Character, https://sourceforge.net/p/adempiere/feature-requests/975/ </li>
 *  @version $Id: ImpFormatRow.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 *  
 *  globalqss: integrate Teo Sarca bug fix [ 1623817 ] Minor bug on importing calendar date

 */
public final class ImpFormatRow
{
	/**
	 *	Constructor for fixed format
	 *  @param seqNo sequence
	 *  @param columnName db column name
	 *  @param startNo start no
	 *  @param endNo and no
	 *  @param dataType data type - see constants DATATYPE_
	 *  @param maxLength if String it is the maximum length (truncated)
	 *  @param name column label
	 */
	public ImpFormatRow(int seqNo, String columnName, int startNo, int endNo, String dataType, int maxLength, String name)
	{
		m_seqNo = seqNo;
		setColumnName(columnName);
		setName(name);
		m_startNo = startNo;
		m_endNo = endNo;
		setDataType (dataType);
		setMaxLength (maxLength);
	}	//	ImpFormatRow

	/**
	 *	Constructor for non-fixed format
	 *  @param seqNo sequence
	 *  @param columnName db column name
	 *  @param dataType data type - see constants DATATYPE_
	 *  @param maxLength if String it is the maximum length (truncated)
	 */
	public ImpFormatRow(int seqNo, String columnName, String dataType, int maxLength)
	{
		m_seqNo = seqNo;
		setColumnName(columnName);
		setDataType (dataType);
		setMaxLength (maxLength);
	}	//	ImpFormatRow

	private int 				m_seqNo;
	private String				m_columnName;
	private String				m_name;
	private int 				m_startNo = 0;
	private int 				m_endNo = 0;
	private String				m_dataType;
	private String				m_dataFormat = "";
	private String				m_decimalPoint = ".";
	private boolean				m_divideBy100 = false;
	private String				m_constantValue = "";
	private boolean				m_constantIsString = true;
	//
	private Callout[]			m_callout = null;
	private String[]			m_method = null;
	private String				importprefix = "";
	//
	private SimpleDateFormat	m_dformat = null;
	private int					m_maxLength = 0;

	/**	Logger			*/
	private static final CLogger	log = CLogger.getCLogger(ImpFormatRow.class);
	
	/**
	 *	Sequence No
	 *  @return seq no
	 */
	public int getSeqNo ()
	{
		return m_seqNo;
	}   //  getSeqNo

	/**
	 *  Set Sequence No
	 *  @param newSeqNo sequence
	 */
	public void setSeqNo (int newSeqNo)
	{
		m_seqNo = newSeqNo;
	}   //  setSeqNo

	/**
	 *	Start Position
	 *  @param newStartNo start position
	 */
	public void setStartNo (int newStartNo)
	{
		m_startNo = newStartNo;
	}   //  setStartNo

	/**
	 *  Get Start Position
	 *  @return start position
	 */
	public int getStartNo()
	{
		return m_startNo;
	}   //  getStartNo

	/**
	 *	End Position
	 *  @param newEndNo end position
	 */
	public void setEndNo (int newEndNo)
	{
		m_endNo = newEndNo;
	}   //  setEndNo

	/**
	 *  Get End Position
	 *  @return End Position
	 */
	public int getEndNo ()
	{
		return m_endNo;
	}   //  getEndNo

	/**
	 *	Column
	 *  @param columnName column name
	 */
	public void setColumnName (String columnName)
	{
		if (columnName == null || columnName.length() == 0)
			throw new IllegalArgumentException("ColumnName must be at least 1 char");
		else
			m_columnName = columnName;
	}   //  setColumnName

	/**
	 *  Get Column Name
	 *  @return Column Name
	 */
	public String getColumnName()
	{
		return m_columnName;
	}   //  getColumnName

	/**
	 *	Name
	 *  @param name name
	 */
	public void setName (String name)
	{
		if (name == null || name.length() == 0)
			throw new IllegalArgumentException("Name must be at least 1 char");
		else
			m_name = name;
	}   //  setName

	/**
	 *  Get Name
	 *  @return Name
	 */
	public String getName()
	{
		return m_name;
	}   //  getName

	/**
	 *	Data Type
	 *  @param dataType data type - see constants DATATYPE_
	 */
	public void setDataType (String dataType)
	{
		if (dataType.equals(X_AD_ImpFormat_Row.DATATYPE_String) || dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Date)
			|| dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Number) || dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Constant))
			m_dataType = dataType;
		else
			throw new IllegalArgumentException("DataType must be S/D/N/C");
	}   //  setDataType


	/**
	 *  Data Type
	 *  @return data type
	 */
	public String getDataType()
	{
		return m_dataType;
	}   //  getDataType

	/**
	 *  Is String
	 *  @return true if data type is String
	 */
	public boolean isString()
	{
		if (m_dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Constant))
			return m_constantIsString;
		return m_dataType.equals(X_AD_ImpFormat_Row.DATATYPE_String);
	}	//	isString

	/**
	 *  Is Number
	 *  @return true if data type is Number
	 */
	public boolean isNumber()
	{
		return m_dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Number);
	}

	/**
	 *  Is Date
	 *  @return true if data type is Date
	 */
	public boolean isDate()
	{
		return m_dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Date);
	}

	/**
	 *  Is Constant
	 *  @return true if data type is Constant
	 */
	public boolean isConstant()
	{
		return m_dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Constant);
	}

	/**
	 *	Set Format Info
	 *  @param dataFormat data format - see constants DATATYPE_
	 *  @param decimalPoint decimal point representation
	 *  @param divideBy100 divide number by 100
	 *  @param constantValue constant value
	 *  @param callout Java callout
	 *  @param importprefix Prefix to be added if value is not null or empty
	 */
	public void setFormatInfo (String dataFormat, String decimalPoint, boolean divideBy100,
		String constantValue, String callout, String importprefix)
	{
		if (dataFormat == null)
			m_dataFormat = "";
		else
			m_dataFormat = dataFormat;
		m_dformat = null; // ADD THIS LINE TO RESET date format
		//	number
		if (decimalPoint == null || !decimalPoint.equals(","))
			m_decimalPoint = ".";
		else
			m_decimalPoint = ",";
		m_divideBy100 = divideBy100;
		//	constant
		if (constantValue == null || constantValue.length() == 0 || !m_dataType.equals(X_AD_ImpFormat_Row.DATATYPE_Constant))
		{
			m_constantValue = "";
			m_constantIsString = true;
		}
		else
		{
			m_constantValue = constantValue;
			m_constantIsString = false;
			for (int i = 0; i < m_constantValue.length(); i++)
			{
				char c = m_constantValue.charAt(i);
				if (!(Character.isDigit(c) || c == '.'))	//	if a constant number, it must be with . (not ,)
				{
					m_constantIsString = true;
					break;
				}
			}
		}
		//	callout
		if (callout != null)
		{
			String[] callouts = callout.split(";");
			m_callout = new Callout[callouts.length];
			m_method = new String[callouts.length];
			for (int i = 0; i < callouts.length; i++) {
				int methodStart = callouts[i].trim().lastIndexOf('.');
				try
				{
					if (methodStart != -1)      //  no class
					{
						Class<?> cClass = Class.forName(callouts[i].trim().substring(0,methodStart));
						m_callout[i] = (Callout)cClass.getDeclaredConstructor().newInstance();
						m_method[i] = callouts[i].trim().substring(methodStart+1);
					}
				}
				catch (Exception e)
				{
					throw new AdempiereException(e);
				}
				if (m_callout.length == 0 || m_method == null || m_method.length == 0)
				{
					log.log(Level.SEVERE, "MTab.setFormatInfo - Invalid Callout " + callout);
					m_callout = null;
				}
			}
		}
		//import prefix
		if (importprefix != null) {
			this.importprefix = importprefix;
		} else {
			this.importprefix = "";
		}
	}   //  setFormatInfo

	/**
	 *  Get Format
	 *  @return Data Format
	 */
	public String getDataFormat()
	{
		return m_dataFormat;
	}

	/**
	 *  Get Decimal Point
	 *  @return Decimal Point
	 */
	public String getDecimalPoint()
	{
		return m_decimalPoint;
	}

	/**
	 *  Divide result by 100
	 *  @return true if result will be divided by 100
	 */
	public boolean isDivideBy100()
	{
		return m_divideBy100;
	}

	/**
	 *  Get the constant value
	 *  @return constant value
	 */
	public String getConstantValue()
	{
		return m_constantValue;
	}

	/**
	 *	Set maximum length for Strings (truncated).
	 * 	Ignored, if 0
	 * 	@param maxLength max length
	 */
	public void setMaxLength (int maxLength)
	{
		m_maxLength = maxLength;
	}	//	setMaxLength

	
	/*************************************************************************
	 *	Parse value.
	 * 	Field content in [] are treated as comments
	 *  @param info data item
	 *  @return parsed info
	 */
	public String parse (String info)
	{
		if (info == null || info.length() == 0)
			return "";

		//	Comment ?
		if (info.startsWith("[") && info.endsWith("]"))
			return "";
		//
		String retValue = null;
		if (isNumber())
			retValue = parseNumber (info);
		else if (isDate())
			retValue = parseDate (info);
		else if (isConstant())
			retValue = m_constantIsString ? parseString (m_constantValue) : m_constantValue;
		else
			retValue = parseString (info);
		//
		if (m_callout != null && m_callout.length > 0)
		{
			try
			{
				for (int i = 0; i < m_callout.length; i++)
					retValue = m_callout[i].convert (m_method[i], retValue);
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "ImpFormatRow.parse - " + info + " (" + retValue + ")", e);
			}
		}
		//
		if (retValue == null)
			retValue = "";		
		return (retValue.trim().length() > 0 ? importprefix : "") + retValue.trim();
	}	//	parse

	
	/**
	 *	Return date as YYYY-MM-DD HH24:MI:SS	(JDBC Timestamp format w/o milliseconds)
	 *  @param info data
	 *  @return date as JDBC format String
	 */
	private String parseDate (String info)
	{
		if (m_dformat == null)
		{
			try
			{
				if (!Util.isEmpty(m_dataFormat))
					m_dformat = new SimpleDateFormat(m_dataFormat);
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "ImpFormatRow.parseDate Format=" + m_dataFormat, e);
			}
			if (m_dformat == null)
				m_dformat = (SimpleDateFormat)DateFormat.getDateInstance();
			m_dformat.setLenient(true);
		}

		Timestamp ts = null;
		try
		{
			ts = new Timestamp (m_dformat.parse(info).getTime());
		}
		catch (ParseException pe)
		{
			String msg = pe.getLocalizedMessage() + ": Pattern[" + m_dformat.toPattern() + "]  Data[" + info + "]";
			throw new AdempiereException(msg);
		}
		//
		String dateString = ts.toString();
		return dateString.substring(0, dateString.indexOf('.'));	//	cut off milliseconds
	}	//	parseNumber

	/**
	 *	Return String.
	 *  - clean ' and backslash
	 *  - check max length
	 *  @param info data
	 *  @return info with in SQL format
	 */
	private String parseString (String info)
	{
		String retValue = info;
		//	Length restriction
		if (m_maxLength > 0 && retValue.length() > m_maxLength)
			retValue = retValue.substring(0, m_maxLength);

		//  copy characters		(wee need to look through anyway)
		StringBuilder out = new StringBuilder(retValue.length());
		for (int i = 0; i < retValue.length(); i++)
		{
			char c = retValue.charAt(i);
			if (c == '\'')
				out.append("''");
			else if (c == '\\')
				out.append("\\\\");
			else
				out.append(c);
		}
		return out.toString();
	}	//	parseString

	/**
	 *	Return number with "." decimal
	 *  @param info data
	 *  @return converted number
	 */
	private String parseNumber (String info)
	{
		boolean hasPoint = info.indexOf('.') != -1;
		boolean hasComma = info.indexOf(',') != -1;
		//	delete thousands
		if (hasComma && m_decimalPoint.equals("."))
			info = info.replace(',', ' ');
		if (hasPoint && m_decimalPoint.equals(","))
			info = info.replace('.', ' ');
		hasComma = info.indexOf(',') != -1;

		//	replace decimal
		if (hasComma && m_decimalPoint.equals(","))
			info = info.replace(',', '.');

		//	remove everything but digits & '.' & '-'
		char[] charArray = info.toCharArray();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < charArray.length; i++)
			if (Character.isDigit(charArray[i]) || charArray[i] == '.' || charArray[i] == '-')
				sb.append(charArray[i]);

		if (sb.length() == 0)
			return "0";
		
		BigDecimal bd = null;
		try
		{
			bd = new BigDecimal(sb.toString());
		}
		catch (NumberFormatException pe)
		{
			log.log(Level.SEVERE, "ImpFormatRow.parseNumber - " + info, pe);
		}
		if (bd == null)
			bd = BigDecimal.ZERO;
		
		if (m_divideBy100)					//	assumed two decimal scale
			bd = bd.divide(Env.ONEHUNDRED, 2, RoundingMode.HALF_UP);
		return bd.toString();
	}	//	parseNumber

}	//	ImpFormatFow
