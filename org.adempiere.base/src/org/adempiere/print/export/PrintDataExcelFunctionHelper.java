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
package org.adempiere.print.export;

import org.adempiere.impexp.ExcelSubtotalFunction;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataFunction;
import org.compiere.print.layout.InstanceAttributeColumn;
import org.compiere.util.Util;

/**
 * Resolve Excel SUBTOTAL function of {@link PrintData} function rows.<br/>
 * Shared by {@link PrintDataExcelExporter} and {@link PrintDataXLSXExporter}.
 */
class PrintDataExcelFunctionHelper
{
	private final PrintData printData;
	private final MPrintFormat printFormat;
	/** Number of group by items, lazy loaded. -1 = not loaded yet */
	private int numberOfGroupByItem = -1;

	/**
	 * @param printData
	 * @param printFormat
	 */
	PrintDataExcelFunctionHelper(PrintData printData, MPrintFormat printFormat)
	{
		this.printData = printData;
		this.printFormat = printFormat;
	}

	/**
	 * Multiple group by items not supported for function cells
	 * @return number of group by items of print format
	 */
	private int getNumberOfGroupByItem()
	{
		if (numberOfGroupByItem < 0)
		{
			numberOfGroupByItem = 0;
			if (printFormat != null)
			{
				for (MPrintFormatItem item : printFormat.getAllItems())
				{
					if (item.isGroupBy())
						numberOfGroupByItem++;
				}
			}
		}
		return numberOfGroupByItem;
	}

	/**
	 * @param row row index
	 * @return true if row is a function row
	 */
	boolean isFunctionRow(int row)
	{
		return printData != null && printData.isFunctionRow(row);
	}

	/**
	 * @param row row index
	 * @return function type of row or null
	 */
	Character getFunctionType(int row)
	{
		return printData != null ? printData.getFunctionType(row) : null;
	}

	/**
	 * @param row row index
	 * @return true if row is a total row (grand total)
	 */
	boolean isTotalRow(int row)
	{
		return isFunctionRow(row) && printData.isTotalRow(row);
	}

	/**
	 * Get Excel SUBTOTAL function code for cell
	 * @param row row index
	 * @param colObj column object (MPrintFormatItem or InstanceAttributeColumn)
	 * @param summary true if summary report
	 * @return function code (see {@link ExcelSubtotalFunction}) or 0 if not a function cell
	 */
	int getFunction(int row, Object colObj, boolean summary)
	{
		if (getNumberOfGroupByItem() > 1 || !isFunctionRow(row) || printData.getRowCount() <= 1)
			return 0;

		// Summary report - detail rows are not included, only static group function rows.
		// A formula range would mix rows of different function types (e.g. Sum and Count), so formulas are not supported.
		if (summary)
			return 0;

		MPrintFormatItem item = null;
		if (colObj instanceof MPrintFormatItem)
			item = (MPrintFormatItem) colObj;
		else if (colObj instanceof InstanceAttributeColumn)
			item = ((InstanceAttributeColumn) colObj).getPrintFormatItem();

		if (item == null)
			return 0;

		// Suppress Repeats or display logic hides detail values, causing Excel SUBTOTAL to diverge from the printed total
		if (item.isSuppressRepeats() || !Util.isEmpty(item.getDisplayLogic()))
			return 0;

		Character functionType = printData.getFunctionType(row);
		if (functionType == null)
			return 0;

		switch (functionType.charValue())
		{
		case PrintDataFunction.F_SUM:
			return item.isSummarized() ? ExcelSubtotalFunction.SUM_FUNCTION : 0;
		case PrintDataFunction.F_COUNT:
			return item.isCounted() ? ExcelSubtotalFunction.COUNT_FUNCTION : 0;
		case PrintDataFunction.F_MIN:
			return item.isMinCalc() ? ExcelSubtotalFunction.MIN_FUNCTION : 0;
		case PrintDataFunction.F_MAX:
			return item.isMaxCalc() ? ExcelSubtotalFunction.MAX_FUNCTION : 0;
		case PrintDataFunction.F_DEVIATION:
			return item.isDeviationCalc() ? ExcelSubtotalFunction.STDEV_FUNCTION : 0;
		case PrintDataFunction.F_MEAN:
			return item.isAveraged() ? ExcelSubtotalFunction.AVG_FUNCTION : 0;
		case PrintDataFunction.F_VARIANCE:
			return item.isVarianceCalc() ? ExcelSubtotalFunction.VAR_FUNCTION : 0;
		default:
			return 0;
		}
	}
}
