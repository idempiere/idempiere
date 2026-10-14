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
package org.idempiere.test.print;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;

import org.adempiere.impexp.ExcelSubtotalFunction;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataColumn;
import org.compiere.print.PrintDataElement;
import org.compiere.print.PrintDataFunction;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * Tests for {@link PrintData} function row and total row tracking, summary flag,
 * and {@link ExcelSubtotalFunction} generated formula ranges.
 */
public class PrintDataTest extends AbstractTestCase
{
	/**
	 * Test {@link PrintData#addRow(int, char)}, {@link PrintData#addRow(int, char, boolean)},
	 * {@link PrintData#getFunctionType(int)}, {@link PrintData#getFunctionType()},
	 * {@link PrintData#isTotalRow(int)}, {@link PrintData#isTotalRow()},
	 * {@link PrintData#isFunctionRow(int)}, and {@link PrintData#isSummary()}.
	 */
	@Test
	public void testAddRowAndFunctionAndTotalRow()
	{
		PrintData pd = new PrintData(Env.getCtx(), "Test Report");
		PrintDataColumn[] cols = new PrintDataColumn[] {
			new PrintDataColumn(1, 1, "Name", DisplayType.String, 60, "Name", false),
			new PrintDataColumn(2, 2, "Amount", DisplayType.Amount, 10, "Amount", false)
		};
		pd.setColumnInfo(cols);

		// Initial state
		assertEquals(0, pd.getRowCount());
		assertFalse(pd.isSummary(), "Summary default should be false");

		pd.setSummary(true);
		assertTrue(pd.isSummary(), "Summary flag should be true after setSummary(true)");
		pd.setSummary(false);
		assertFalse(pd.isSummary(), "Summary flag should be false after setSummary(false)");

		// Row 0: Regular data row
		pd.addRow(false, 0);
		pd.addNode(new PrintDataElement(1, "Name", "Product A", DisplayType.String, null));
		pd.addNode(new PrintDataElement(2, "Amount", new BigDecimal("100.00"), DisplayType.Amount, null));

		// Row 1: Regular data row
		pd.addRow(false, 0);
		pd.addNode(new PrintDataElement(1, "Name", "Product B", DisplayType.String, null));
		pd.addNode(new PrintDataElement(2, "Amount", new BigDecimal("200.00"), DisplayType.Amount, null));

		// Row 2: Subtotal function row using 2-arg overload (default totalRow = false)
		pd.addRow(0, PrintDataFunction.F_SUM);
		pd.addNode(new PrintDataElement(1, "Name", "Subtotal", DisplayType.String, null));
		pd.addNode(new PrintDataElement(2, "Amount", new BigDecimal("300.00"), DisplayType.Amount, null));

		// Row 3: Grand Total function row using 3-arg overload (totalRow = true)
		pd.addRow(0, PrintDataFunction.F_SUM, true);
		pd.addNode(new PrintDataElement(1, "Name", "Grand Total", DisplayType.String, null));
		pd.addNode(new PrintDataElement(2, "Amount", new BigDecimal("300.00"), DisplayType.Amount, null));

		// Row 4: Grand Total Count row
		pd.addRow(0, PrintDataFunction.F_COUNT, true);
		pd.addNode(new PrintDataElement(1, "Name", "Count", DisplayType.String, null));
		pd.addNode(new PrintDataElement(2, "Amount", new BigDecimal("2"), DisplayType.Quantity, null));

		assertEquals(5, pd.getRowCount());

		// Test row index based queries
		// Row 0 (Data)
		assertFalse(pd.isFunctionRow(0), "Row 0 should not be function row");
		assertNull(pd.getFunctionType(0), "Row 0 should have null function type");
		assertFalse(pd.isTotalRow(0), "Row 0 should not be total row");

		// Row 1 (Data)
		assertFalse(pd.isFunctionRow(1), "Row 1 should not be function row");
		assertNull(pd.getFunctionType(1), "Row 1 should have null function type");
		assertFalse(pd.isTotalRow(1), "Row 1 should not be total row");

		// Row 2 (Subtotal)
		assertTrue(pd.isFunctionRow(2), "Row 2 should be function row");
		assertEquals(Character.valueOf(PrintDataFunction.F_SUM), pd.getFunctionType(2), "Row 2 function type should be F_SUM");
		assertFalse(pd.isTotalRow(2), "Row 2 should be subtotal, not total row");

		// Row 3 (Grand Total Sum)
		assertTrue(pd.isFunctionRow(3), "Row 3 should be function row");
		assertEquals(Character.valueOf(PrintDataFunction.F_SUM), pd.getFunctionType(3), "Row 3 function type should be F_SUM");
		assertTrue(pd.isTotalRow(3), "Row 3 should be total row");

		// Row 4 (Grand Total Count)
		assertTrue(pd.isFunctionRow(4), "Row 4 should be function row");
		assertEquals(Character.valueOf(PrintDataFunction.F_COUNT), pd.getFunctionType(4), "Row 4 function type should be F_COUNT");
		assertTrue(pd.isTotalRow(4), "Row 4 should be total row");

		// Test cursor based queries (current row index)
		assertTrue(pd.setRowIndex(0));
		assertFalse(pd.isFunctionRow());
		assertNull(pd.getFunctionType());
		assertFalse(pd.isTotalRow());

		assertTrue(pd.setRowIndex(2));
		assertTrue(pd.isFunctionRow());
		assertEquals(Character.valueOf(PrintDataFunction.F_SUM), pd.getFunctionType());
		assertFalse(pd.isTotalRow());

		assertTrue(pd.setRowIndex(3));
		assertTrue(pd.isFunctionRow());
		assertEquals(Character.valueOf(PrintDataFunction.F_SUM), pd.getFunctionType());
		assertTrue(pd.isTotalRow());

		assertTrue(pd.setRowIndex(4));
		assertTrue(pd.isFunctionRow());
		assertEquals(Character.valueOf(PrintDataFunction.F_COUNT), pd.getFunctionType());
		assertTrue(pd.isTotalRow());
	}

	/**
	 * Test {@link ExcelSubtotalFunction} constants, validation, and generated formula ranges.
	 */
	@Test
	public void testGeneratedFormulaRanges()
	{
		// Test function code validation
		assertTrue(ExcelSubtotalFunction.isFunction(ExcelSubtotalFunction.SUM_FUNCTION));
		assertTrue(ExcelSubtotalFunction.isFunction(ExcelSubtotalFunction.COUNT_FUNCTION));
		assertTrue(ExcelSubtotalFunction.isFunction(ExcelSubtotalFunction.AVG_FUNCTION));
		assertTrue(ExcelSubtotalFunction.isFunction(ExcelSubtotalFunction.MAX_FUNCTION));
		assertTrue(ExcelSubtotalFunction.isFunction(ExcelSubtotalFunction.MIN_FUNCTION));
		assertTrue(ExcelSubtotalFunction.isFunction(ExcelSubtotalFunction.STDEV_FUNCTION));
		assertTrue(ExcelSubtotalFunction.isFunction(ExcelSubtotalFunction.VAR_FUNCTION));
		assertFalse(ExcelSubtotalFunction.isFunction(0));
		assertFalse(ExcelSubtotalFunction.isFunction(-1));

		// Verify function codes match Excel SUBTOTAL function numbers
		assertEquals(9, ExcelSubtotalFunction.SUM_FUNCTION);
		assertEquals(3, ExcelSubtotalFunction.COUNT_FUNCTION);
		assertEquals(1, ExcelSubtotalFunction.AVG_FUNCTION);
		assertEquals(4, ExcelSubtotalFunction.MAX_FUNCTION);
		assertEquals(5, ExcelSubtotalFunction.MIN_FUNCTION);
		assertEquals(8, ExcelSubtotalFunction.STDEV_FUNCTION);
		assertEquals(11, ExcelSubtotalFunction.VAR_FUNCTION);

		// Test generated formulas for group subtotals and grand totals:
		// Group 1: data at rows 1..3 (0-based in sheet), subtotal at row 4
		// Formula range in Excel: B2:B4
		String group1Formula = ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.SUM_FUNCTION, 1, 3, 1);
		assertEquals("SUBTOTAL(9,B2:B4)", group1Formula, "Group 1 subtotal formula mismatch");

		// Group 2: data at rows 5..6 (0-based in sheet), subtotal at row 7
		// Formula range in Excel: B6:B7
		String group2Formula = ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.SUM_FUNCTION, 5, 6, 1);
		assertEquals("SUBTOTAL(9,B6:B7)", group2Formula, "Group 2 subtotal formula mismatch");

		// Grand Total: spans from first data row (1) to last data/subtotal row (7)
		// Formula range in Excel: B2:B8 (SUBTOTAL ignores nested SUBTOTAL cells B4 and B7)
		String grandTotalFormula = ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.SUM_FUNCTION, 1, 7, 1);
		assertEquals("SUBTOTAL(9,B2:B8)", grandTotalFormula, "Grand total formula mismatch");

		// Test formulas with other SUBTOTAL functions on column C (col = 2), rows 1..10 (Excel C2:C11)
		assertEquals("SUBTOTAL(3,C2:C11)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.COUNT_FUNCTION, 1, 10, 2));
		assertEquals("SUBTOTAL(1,C2:C11)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.AVG_FUNCTION, 1, 10, 2));
		assertEquals("SUBTOTAL(4,C2:C11)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.MAX_FUNCTION, 1, 10, 2));
		assertEquals("SUBTOTAL(5,C2:C11)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.MIN_FUNCTION, 1, 10, 2));
		assertEquals("SUBTOTAL(8,C2:C11)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.STDEV_FUNCTION, 1, 10, 2));
		assertEquals("SUBTOTAL(11,C2:C11)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.VAR_FUNCTION, 1, 10, 2));

		// Test column wrapping (e.g. column index 26 = AA, column index 27 = AB)
		assertEquals("SUBTOTAL(9,AA2:AA10)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.SUM_FUNCTION, 1, 9, 26));
		assertEquals("SUBTOTAL(9,AB5:AB15)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.SUM_FUNCTION, 4, 14, 27));

		// Test single row range
		assertEquals("SUBTOTAL(9,A2:A2)",
			ExcelSubtotalFunction.getSubtotalFormula(ExcelSubtotalFunction.SUM_FUNCTION, 1, 1, 0));
	}
}
