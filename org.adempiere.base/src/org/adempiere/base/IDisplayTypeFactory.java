/******************************************************************************
 * Copyright (C) 2013 Jan Thielemann - jan.thielemann@evenos-consulting.de    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.compiere.util.Language;

/**
 * Interface for display type factory.
 * @author Jan Thielemann - jan.thielemann@evenos-consulting.de
 * @author evenos Consulting GmbH - www.evenos.org
 */
public interface IDisplayTypeFactory {
	/**
	 * @param displayType
	 * @return true if displayType is of int ID type
	 */
	public boolean isID(int displayType);
	
	/**
	 * @param displayType
	 * @return true if displayType is of UUID type
	 */
	public default boolean isUUID(int displayType) {
		return false;
	}
	
	/**
	 * @param displayType
	 * @return true if displayType is of numeric type
	 */
	public boolean isNumeric(int displayType);
	
	/**
	 * @param displayType
	 * @return default numeric precision for displayType
	 */
	public Integer getDefaultPrecision(int displayType);
	
	/**
	 * @param displayType
	 * @return true if displayType is of text type
	 */
	public boolean isText(int displayType);
	
	/**
	 * @param displayType
	 * @return true if displayType is of date type
	 */
	public boolean isDate (int displayType);
	public default boolean isList (int displayType) {
		return false;
	}
	
	/**
	 * @param displayType
	 * @return true if displayType is of lookup type (usually a foreign key type)
	 */
	public boolean isLookup(int displayType);
	
	/**
	 * @param displayType
	 * @return true if displayType is of LOB type
	 */
	public boolean isLOB (int displayType);
	
	/**
	 * @param displayType
	 * @param language
	 * @param pattern
	 * @return DecimalFormat
	 */
	public DecimalFormat getNumberFormat(int displayType, Language language, String pattern);
	
	/**
	 * @param displayType
	 * @param language
	 * @param pattern
	 * @return SimpleDateFormat
	 */
	public SimpleDateFormat getDateFormat (int displayType, Language language, String pattern);
	
	/**
	 * @param displayType
	 * @param yesNoAsBoolean
	 * @return Java type for displayType
	 */
	public Class<?> getClass (int displayType, boolean yesNoAsBoolean);
	
	/**
	 * @param displayType
	 * @param columnName
	 * @param fieldLength
	 * @return SQL data type for displayType
	 */
	public String getSQLDataType (int displayType, String columnName, int fieldLength);
	
	/**
	 * @param displayType
	 * @return description for displayType
	 */
	public String getDescription (int displayType);

}
