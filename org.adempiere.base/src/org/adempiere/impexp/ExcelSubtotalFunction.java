/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                                                           *
 **********************************************************************/
package org.adempiere.impexp;

import org.apache.poi.ss.util.CellReference;

/**
 * Excel SUBTOTAL function codes and formula builder shared by the XLS and XLSX exporters.<br/>
 * SUBTOTAL ignores other SUBTOTAL cells within its range, which allows nested group and grand totals.
 */
public final class ExcelSubtotalFunction
{
	/** SUBTOTAL function code for SUM */
	public static final int SUM_FUNCTION   = 9;
	/** SUBTOTAL function code for COUNTA (non-empty count) */
	public static final int COUNT_FUNCTION = 3;
	/** SUBTOTAL function code for MIN */
	public static final int MIN_FUNCTION   = 5;
	/** SUBTOTAL function code for MAX */
	public static final int MAX_FUNCTION   = 4;
	/** SUBTOTAL function code for VARP (population variance) */
	public static final int VAR_FUNCTION   = 11;
	/** SUBTOTAL function code for AVERAGE */
	public static final int AVG_FUNCTION   = 1;
	/** SUBTOTAL function code for STDEVP (population standard deviation) */
	public static final int STDEV_FUNCTION = 8;

	private ExcelSubtotalFunction()
	{
	}

	/**
	 * @param functionCode SUBTOTAL function code
	 * @return true if functionCode is a valid function code (i.e. cell should be exported as formula)
	 */
	public static boolean isFunction(int functionCode)
	{
		return functionCode > 0;
	}

	/**
	 * Build SUBTOTAL formula (without the leading =) for a column range
	 * @param functionCode SUBTOTAL function code (SUM_FUNCTION, COUNT_FUNCTION, etc.)
	 * @param firstRow first row index (0 based) of range
	 * @param lastRow last row index (0 based) of range
	 * @param col column index (0 based)
	 * @return formula, for e.g. SUBTOTAL(9,C2:C10)
	 */
	public static String getSubtotalFormula(int functionCode, int firstRow, int lastRow, int col)
	{
		StringBuilder formula = new StringBuilder("SUBTOTAL(");
		formula.append(functionCode).append(",");
		formula.append(new CellReference(firstRow, col).formatAsString());
		formula.append(":");
		formula.append(new CellReference(lastRow, col).formatAsString());
		formula.append(")");
		return formula.toString();
	}
}
