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
 * @author Jan Thielemann - jan.thielemann@evenos-consulting.de
 * @author evenos Consulting GmbH - www.evenos.org
 */

public interface IDisplayTypeFactory {
	
	public boolean isID(int displayType);
	public boolean isNumeric(int displayType);
	public Integer getDefaultPrecision(int displayType);
	public boolean isText(int displayType);
	public boolean isDate (int displayType);
	public boolean isLookup(int displayType);
	public boolean isLOB (int displayType);
	public DecimalFormat getNumberFormat(int displayType, Language language, String pattern);
	public SimpleDateFormat getDateFormat (int displayType, Language language, String pattern);
	public Class<?> getClass (int displayType, boolean yesNoAsBoolean);
	public String getSQLDataType (int displayType, String columnName, int fieldLength);
	public String getDescription (int displayType);

}











