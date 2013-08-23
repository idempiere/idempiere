/******************************************************************************
 * Product: Compiere ERP & CRM Smart Business Solution                        *
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

import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_ACCOUNT;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_AMOUNT;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_ASSIGNMENT;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_BINARY;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_BUTTON;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_COLOR;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_COSTPRICE;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_DATE;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_DATETIME;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_FILENAME;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_FILEPATH;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_ID;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_IMAGE;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_INTEGER;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_LIST;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_LOCATION;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_LOCATOR;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_MEMO;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_NUMBER;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_PAYMENT;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_PRINTNAME;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_PRODUCTATTRIBUTE;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_QUANTITY;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_ROWID;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_SEARCH;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_STRING;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_TABLE;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_TABLEDIR;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_TEXT;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_TEXTLONG;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_TIME;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_URL;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_YES_NO;
import static org.compiere.model.SystemIDs.REFERENCE_DATATYPE_CHART;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;

import org.adempiere.base.IDisplayTypeFactory;
import org.adempiere.base.Service;

/**
 *	System Display Types.
 *  <pre>
 *	SELECT AD_Reference_ID, Name FROM AD_Reference WHERE ValidationType = 'D'
 *  </pre>
 *  @author     Jorg Janke
 *  @version    $Id: DisplayType.java,v 1.6 2006/08/30 20:30:44 comdivision Exp $
 *
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 				<li>BF [ 1810632 ] PricePrecision error in InfoProduct (and similar)
 */
public final class DisplayType
{
	/** Display Type 10	String	*/
	public static final int String     = REFERENCE_DATATYPE_STRING;
	/** Display Type 11	Integer	*/
	public static final int Integer    = REFERENCE_DATATYPE_INTEGER;
	/** Display Type 12	Amount	*/
	public static final int Amount     = REFERENCE_DATATYPE_AMOUNT;
	/** Display Type 13	ID	*/
	public static final int ID         = REFERENCE_DATATYPE_ID;
	/** Display Type 14	Text	*/
	public static final int Text       = REFERENCE_DATATYPE_TEXT;
	/** Display Type 15	Date	*/
	public static final int Date       = REFERENCE_DATATYPE_DATE;
	/** Display Type 16	DateTime	*/
	public static final int DateTime   = REFERENCE_DATATYPE_DATETIME;
	/** Display Type 17	List	*/
	public static final int List       = REFERENCE_DATATYPE_LIST;
	/** Display Type 18	Table	*/
	public static final int Table      = REFERENCE_DATATYPE_TABLE;
	/** Display Type 19	TableDir	*/
	public static final int TableDir   = REFERENCE_DATATYPE_TABLEDIR;
	/** Display Type 20	YN	*/
	public static final int YesNo      = REFERENCE_DATATYPE_YES_NO;
	/** Display Type 21	Location	*/
	public static final int Location   = REFERENCE_DATATYPE_LOCATION;
	/** Display Type 22	Number	*/
	public static final int Number     = REFERENCE_DATATYPE_NUMBER;
	/** Display Type 23	BLOB	*/
	public static final int Binary     = REFERENCE_DATATYPE_BINARY;
	/** Display Type 24	Time	*/
	public static final int Time       = REFERENCE_DATATYPE_TIME;
	/** Display Type 25	Account	*/
	public static final int Account    = REFERENCE_DATATYPE_ACCOUNT;
	/** Display Type 26	RowID	*/
	public static final int RowID      = REFERENCE_DATATYPE_ROWID;
	/** Display Type 27	Color   */
	public static final int Color      = REFERENCE_DATATYPE_COLOR;
	/** Display Type 28	Button	*/
	public static final int Button	   = REFERENCE_DATATYPE_BUTTON;
	/** Display Type 29	Quantity	*/
	public static final int Quantity   = REFERENCE_DATATYPE_QUANTITY;
	/** Display Type 30	Search	*/
	public static final int Search     = REFERENCE_DATATYPE_SEARCH;
	/** Display Type 31	Locator	*/
	public static final int Locator    = REFERENCE_DATATYPE_LOCATOR;
	/** Display Type 32 Image	*/
	public static final int Image      = REFERENCE_DATATYPE_IMAGE;
	/** Display Type 33 Assignment	*/
	public static final int Assignment = REFERENCE_DATATYPE_ASSIGNMENT;
	/** Display Type 34	Memo	*/
	public static final int Memo       = REFERENCE_DATATYPE_MEMO;
	/** Display Type 35	PAttribute	*/
	public static final int PAttribute = REFERENCE_DATATYPE_PRODUCTATTRIBUTE;
	/** Display Type 36	CLOB	*/
	public static final int TextLong   = REFERENCE_DATATYPE_TEXTLONG;
	/** Display Type 37	CostPrice	*/
	public static final int CostPrice  = REFERENCE_DATATYPE_COSTPRICE;
	/** Display Type 38	File Path	*/
	public static final int FilePath  = REFERENCE_DATATYPE_FILEPATH;
	/** Display Type 39 File Name	*/
	public static final int FileName  = REFERENCE_DATATYPE_FILENAME;
	/** Display Type 40	URL	*/
	public static final int URL  = REFERENCE_DATATYPE_URL;
	/** Display Type 42	PrinterName	*/
	public static final int PrinterName  = REFERENCE_DATATYPE_PRINTNAME;
	//	Candidates:
	/** Display Type 200012	Payment	*/
	public static final int Payment  = REFERENCE_DATATYPE_PAYMENT;
	
	public static final int Chart = REFERENCE_DATATYPE_CHART;

	/**
	 *	- New Display Type
		INSERT INTO AD_REFERENCE
		(AD_REFERENCE_ID, AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,
		NAME,DESCRIPTION,HELP, VALIDATIONTYPE,VFORMAT,ENTITYTYPE)
		VALUES (35, 0,0,'Y',SysDate,0,SysDate,0,
		'PAttribute','Product Attribute',null,'D',null,'D');
	 *
	 *  - org.compiere.model.MModel (??)
	 *	- org.compiere.grid.ed.VEditor/Dialog
	 *	- org.compiere.grid.ed.VEditorFactory
	 *	- RColumn, WWindow
	 *  add/check 0_cleanupAD.sql
	 */

	//  See DBA_DisplayType.sql ----------------------------------------------

	/** Maximum number of digits    */
	private static final int    MAX_DIGITS = 28;        //  Oracle Standard Limitation 38 digits
	/** Digits of an Integer        */
	private static final int    INTEGER_DIGITS = 10;
	/** Maximum number of fractions */
	private static final int    MAX_FRACTION = 12;
	/** Default Amount Precision    */
	private static final int    AMOUNT_FRACTION = 2;

	public static final String DEFAULT_TIME_FORMAT = "HH:mm:ss";
	public static final String DEFAULT_TIMESTAMP_FORMAT = "yyyy-MM-dd HH:mm:ss";
	public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";

	/**	Logger	*/
	private static CLogger s_log = CLogger.getCLogger (DisplayType.class);

	/**
	 *	Returns true if (numeric) ID (Table, Search, Account, ..).
	 *  (stored as Integer)
	 *  @param displayType Display Type
	 *  @return true if ID
	 */
	public static boolean isID (int displayType)
	{
		if (displayType == ID || displayType == Table || displayType == TableDir
			|| displayType == Search || displayType == Location || displayType == Locator
			|| displayType == Account || displayType == Assignment || displayType == PAttribute
			|| displayType == Image || displayType == Chart || displayType == Color)
			return true;
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			if(factory.isID(displayType))
				return true;
		}
		
		return false;
	}	//	isID

	/**
	 *	Returns true, if DisplayType is numeric (Amount, Number, Quantity, Integer).
	 *  (stored as BigDecimal)
	 *  @param displayType Display Type
	 *  @return true if numeric
	 */
	public static boolean isNumeric(int displayType)
	{
		if (displayType == Amount || displayType == Number || displayType == CostPrice
			|| displayType == Integer || displayType == Quantity)
			return true;
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			if(factory.isNumeric(displayType))
				return true;
		}
		
		return false;
	}	//	isNumeric

	/**
	 * 	Get Default Precision.
	 * 	Used for databases who cannot handle dynamic number precision.
	 *	@param displayType display type
	 *	@return scale (decimal precision)
	 */
	public static int getDefaultPrecision(int displayType)
	{
		if (displayType == Amount)
			return 2;
		if (displayType == Number)
			return 6;
		if (displayType == CostPrice
			|| displayType == Quantity)
			return 4;
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			if(factory.getDefaultPrecision(displayType) != null)
				return factory.getDefaultPrecision(displayType).intValue();
				
		}
		
		return 0;
	}	//	getDefaultPrecision


	/**
	 *	Returns true, if DisplayType is text (String, Text, TextLong, Memo).
	 *  @param displayType Display Type
	 *  @return true if text
	 */
	public static boolean isText(int displayType)
	{
		if (displayType == String || displayType == Text
			|| displayType == TextLong || displayType == Memo
			|| displayType == FilePath || displayType == FileName
			|| displayType == URL || displayType == PrinterName)
			return true;
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			if(factory.isText(displayType))
				return true;
		}
		return false;
	}	//	isText

	/**
	 *	Returns true if DisplayType is a Date.
	 *  (stored as Timestamp)
	 *  @param displayType Display Type
	 *  @return true if date
	 */
	public static boolean isDate (int displayType)
	{
		if (displayType == Date || displayType == DateTime || displayType == Time)
			return true;
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			if(factory.isDate(displayType))
				return true;
		}
		
		return false;
	}	//	isDate

	/**
	 *	Returns true if DisplayType is a VLookup (List, Table, TableDir, Search).
	 *  (stored as Integer)
	 *  @param displayType Display Type
	 *  @return true if Lookup
	 */
	public static boolean isLookup(int displayType)
	{
		if (displayType == List || displayType == Table
			|| displayType == TableDir || displayType == Search)
			return true;
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			if(factory.isLookup(displayType))
				return true;				
		}
		
		return false;
	}	//	isLookup

	/**
	 * 	Returns true if DisplayType is a Large Object
	 *	@param displayType Display Type
	 *	@return true if LOB
	 */
	public static boolean isLOB (int displayType)
	{
		if (displayType == Binary
			|| displayType == TextLong)
			return true;
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			if(factory.isLOB(displayType))
				return true;				
		}
		
		return false;
	}	//	isLOB

	/**************************************************************************
	 *	Return Format for numeric DisplayType
	 *  @param displayType Display Type (default Number)
	 *  @param language Language
	 *  @param pattern Java Number Format pattern e.g. "#,##0.00"
	 *  @return number format
	 */
	public static DecimalFormat getNumberFormat(int displayType, Language language, String pattern)
	{
		Language myLanguage = language;
		if (myLanguage == null)
			myLanguage = Language.getLoginLanguage();
		Locale locale = myLanguage.getLocale();
		DecimalFormat format = null;
		if (locale != null)
			format = (DecimalFormat)NumberFormat.getNumberInstance(locale);
		else
			format = (DecimalFormat)NumberFormat.getNumberInstance(Locale.US);
		//
		if (pattern != null && pattern.length() > 0)
		{
			try {
			format.applyPattern(pattern);
			return format;
			}
			catch (IllegalArgumentException e) {
				s_log.log(Level.WARNING, "Invalid number format: " + pattern);
			}
		}
		else if (displayType == Integer)
		{
			format.setParseIntegerOnly(true);
			format.setMaximumIntegerDigits(INTEGER_DIGITS);
			format.setMaximumFractionDigits(0);
		}
		else if (displayType == Quantity)
		{
			format.setMaximumIntegerDigits(MAX_DIGITS);
			format.setMaximumFractionDigits(MAX_FRACTION);
		}
		else if (displayType == Amount)
		{
			format.setMaximumIntegerDigits(MAX_DIGITS);
			format.setMaximumFractionDigits(MAX_FRACTION);
			format.setMinimumFractionDigits(AMOUNT_FRACTION);
		}
		else if (displayType == CostPrice)
		{
			format.setMaximumIntegerDigits(MAX_DIGITS);
			format.setMaximumFractionDigits(MAX_FRACTION);
			format.setMinimumFractionDigits(AMOUNT_FRACTION);
		}
		else
		{
			List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
			for(IDisplayTypeFactory factory : factoryList){
				DecimalFormat osgiFormat = factory.getNumberFormat(displayType, myLanguage, pattern);
				if(osgiFormat!=null){
					return osgiFormat;
				}
			}
			
			format.setMaximumIntegerDigits(MAX_DIGITS);
			format.setMaximumFractionDigits(MAX_FRACTION);
			format.setMinimumFractionDigits(1);
		}
		return format;
	}	//	getDecimalFormat

	/**************************************************************************
	 *	Return Format for numeric DisplayType
	 *  @param displayType Display Type (default Number)
	 *  @param language Language
	 *  @return number format
	 */
	public static DecimalFormat getNumberFormat(int displayType, Language language)
	{
		return getNumberFormat(displayType, language, null);
	}

	/**
	 *	Return Format for numeric DisplayType
	 *  @param displayType Display Type
	 *  @return number format
	 */
	public static DecimalFormat getNumberFormat(int displayType)
	{
		return getNumberFormat (displayType, null);
	}   //  getNumberFormat


	/*************************************************************************
	 *	Return Date Format
	 *  @return date format
	 */
	public static SimpleDateFormat getDateFormat()
	{
		return getDateFormat (DisplayType.Date, null);
	}   //  getDateFormat

	/**
	 *	Return Date Format
	 *  @param language Language
	 *  @return date format
	 */
	public static SimpleDateFormat getDateFormat (Language language)
	{
		return getDateFormat (DisplayType.Date, language);
	}	//	getDateFormat

	/**
	 *	Return format for date displayType
	 *  @param displayType Display Type
	 *  @return date format
	 */
	public static SimpleDateFormat getDateFormat (int displayType)
	{
		return getDateFormat (displayType, null);
	}   //  getDateFormat

	/**
	 *	Return format for date displayType
	 *  @param displayType Display Type (default Date)
	 *  @param language Language
	 *  @return date format
	 */
	public static SimpleDateFormat getDateFormat (int displayType, Language language)
	{
		return getDateFormat(displayType, language, null);
	}
	/**
	 *	Return format for date displayType
	 *  @param displayType Display Type (default Date)
	 *  @param language Language
	 *  @param pattern Java Simple Date Format pattern e.g. "dd/MM/yy"
	 *  @return date format
	 */
	public static SimpleDateFormat getDateFormat (int displayType, Language language, String pattern)
	{
		Language myLanguage = language;
		if (myLanguage == null)
			myLanguage = Env.getLanguage(Env.getCtx());
		//
		if ( pattern != null && pattern.length() > 0)
		{
			SimpleDateFormat format = (SimpleDateFormat)DateFormat.getInstance();
			try {
			format.applyPattern(pattern);
			return format;
			}
			catch (IllegalArgumentException e) {
				s_log.log(Level.WARNING, "Invalid date pattern: " + pattern);
			}
		}

		if (displayType == DateTime)
			return myLanguage.getDateTimeFormat();
		else if (displayType == Time)
			return myLanguage.getTimeFormat();
		else{
			List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
			for(IDisplayTypeFactory factory : factoryList){
				SimpleDateFormat osgiFormat = factory.getDateFormat(displayType, myLanguage, pattern);
				if(osgiFormat!=null)
					return osgiFormat;
			}
		}
		
	//	else if (displayType == Date)
		return myLanguage.getDateFormat();		//	default
	}	//	getDateFormat

	/**
	 *	JDBC Date Format YYYY-MM-DD
	 *  @return date format
	 */
	static public SimpleDateFormat getDateFormat_JDBC()
	{
		return new SimpleDateFormat (DEFAULT_DATE_FORMAT);
	}   //  getDateFormat_JDBC

	/**
	 *	JDBC Timestamp Format yyyy-mm-dd hh:mm:ss
	 *  @return timestamp format
	 */
	static public SimpleDateFormat getTimestampFormat_Default()
	{
		return new SimpleDateFormat (DEFAULT_TIMESTAMP_FORMAT);
	}   //  getTimestampFormat_JDBC

	static public SimpleDateFormat getTimeFormat_Default()
	{
		return new SimpleDateFormat (DEFAULT_TIME_FORMAT);
	}   //  getTimeFormat_Default

	/**
	 *  Return Storage Class.
	 *  (used for MiniTable)
	 *  @param displayType Display Type
	 *  @param yesNoAsBoolean - yes or no as boolean
	 *  @return class Integer - BigDecimal - Timestamp - String - Boolean
	 */
	public static Class<?> getClass (int displayType, boolean yesNoAsBoolean)
	{
		if (isText(displayType) || displayType == List || displayType == Payment)
			return String.class;
		else if (isID(displayType) || displayType == Integer)    //  note that Integer is stored as BD
			return Integer.class;
		else if (isNumeric(displayType))
			return java.math.BigDecimal.class;
		else if (isDate(displayType))
			return java.sql.Timestamp.class;
		else if (displayType == YesNo)
			return yesNoAsBoolean ? Boolean.class : String.class;
		else if (displayType == Button)
			return String.class;
		else if (isLOB(displayType))	//	CLOB is String
			return byte[].class;
		else
		{
			List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
			for(IDisplayTypeFactory factory : factoryList){
				Class<?> osgiClass = factory.getClass(displayType, yesNoAsBoolean); 
				if(osgiClass!=null)
					return osgiClass;
			}
		}
		//
		return Object.class;
	}   //  getClass

	/**
	 * 	Get SQL DataType
	 *	@param displayType AD_Reference_ID
	 *	@param columnName name
	 *	@param fieldLength length
	 *	@return SQL Data Type in Oracle Notation
	 */
	public static String getSQLDataType (int displayType, String columnName, int fieldLength)
	{
		if (columnName.equals("EntityType")
			|| columnName.equals ("AD_Language"))
			return "VARCHAR2(" + fieldLength + ")";
		//	ID
		if (DisplayType.isID(displayType))
		{
			if (displayType == DisplayType.Image 	//	FIXTHIS
				&& columnName.equals("BinaryData"))
				return "BLOB";
			//	ID, CreatedBy/UpdatedBy, Acct
			else if (columnName.endsWith("_ID")
				|| columnName.endsWith("tedBy")
				|| columnName.endsWith("_Acct") )
				return "NUMBER(10)";
			else if (fieldLength < 4)
				return "CHAR(" + fieldLength + ")";
			else	//	EntityType, AD_Language	fallback
				return "VARCHAR2(" + fieldLength + ")";
		}
		//
		if (displayType == DisplayType.Integer)
			return "NUMBER(10)";
		if (DisplayType.isDate(displayType))
			return "DATE";
		if (DisplayType.isNumeric(displayType))
			return "NUMBER";
		if (displayType == DisplayType.Binary)
			return "BLOB";
		if (displayType == DisplayType.TextLong
			|| (displayType == DisplayType.Text && fieldLength >= 4000))
			return "CLOB";
		if (displayType == DisplayType.YesNo)
			return "CHAR(1)";
		if (displayType == DisplayType.List || displayType == DisplayType.Payment) {
			if (fieldLength == 1)
				return "CHAR(" + fieldLength + ")";
			else
				return "NVARCHAR2(" + fieldLength + ")";
		}
		if (displayType == DisplayType.Color) // this condition is never reached - filtered above in isID
		{
			if (columnName.endsWith("_ID"))
				return "NUMBER(10)";
			else
				return "CHAR(" + fieldLength + ")";
		}
		if (displayType == DisplayType.Button)
		{
			if (columnName.endsWith("_ID"))
				return "NUMBER(10)";
			else
				return "CHAR(" + fieldLength + ")";
		}
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			String osgiSQLDataType = factory.getSQLDataType(displayType, columnName, fieldLength);
			if(osgiSQLDataType!=null)
				return osgiSQLDataType;
		}
		
		if (!DisplayType.isText(displayType))
			s_log.severe("Unhandled Data Type = " + displayType);

		return "NVARCHAR2(" + fieldLength + ")";
	}	//	getSQLDataType

	/**
	 * 	Get Description
	 *	@param displayType display Type
	 *	@return display type description
	 */
	public static String getDescription (int displayType)
	{
		if (displayType == String)
			return "String";
		if (displayType == Integer)
			return "Integer";
		if (displayType == Amount)
			return "Amount";
		if (displayType == ID)
			return "ID";
		if (displayType == Text)
			return "Text";
		if (displayType == Date)
			return "Date";
		if (displayType == DateTime)
			return "DateTime";
		if (displayType == List)
			return "List";
		if (displayType == Table)
			return "Table";
		if (displayType == TableDir)
			return "TableDir";
		if (displayType == YesNo)
			return "YesNo";
		if (displayType == Location)
			return "Location";
		if (displayType == Number)
			return "Number";
		if (displayType == Binary)
			return "Binary";
		if (displayType == Time)
			return "Time";
		if (displayType == Account)
			return "Account";
		if (displayType == RowID)
			return "RowID";
		if (displayType == Color)
			return "Color";
		if (displayType == Button)
			return "Button";
		if (displayType == Quantity)
			return "Quantity";
		if (displayType == Search)
			return "Search";
		if (displayType == Locator)
			return "Locator";
		if (displayType == Image)
			return "Image";
		if (displayType == Assignment)
			return "Assignment";
		if (displayType == Memo)
			return "Memo";
		if (displayType == PAttribute)
			return "PAttribute";
		if (displayType == TextLong)
			return "TextLong";
		if (displayType == CostPrice)
			return "CostPrice";
		if (displayType == FilePath)
			return "FilePath";
		if (displayType == FileName)
			return "FileName";
		if (displayType == URL)
			return "URL";
		if (displayType == PrinterName)
			return "PrinterName";
		if (displayType == Payment)
			return "Payment";
		if (displayType == Chart)
			return "Chart";
		
		List<IDisplayTypeFactory> factoryList = Service.locator().list(IDisplayTypeFactory.class).getServices();
		for(IDisplayTypeFactory factory : factoryList){
			String osgiDescription = factory.getDescription(displayType);
			if(osgiDescription!=null)
				return osgiDescription;
		}
		
		//
		return "UNKNOWN DisplayType=" + displayType;
	}	//	getDescription

}	//	DisplayType
