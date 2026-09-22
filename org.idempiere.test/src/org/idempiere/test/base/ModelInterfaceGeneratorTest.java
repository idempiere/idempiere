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
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.adempiere.util.ModelInterfaceGenerator;
import org.compiere.model.MColumn;
import org.compiere.model.MRefTable;
import org.compiere.model.MReference;
import org.compiere.model.MTest;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * Test cases for {@link ModelInterfaceGenerator}
 */
public class ModelInterfaceGeneratorTest extends AbstractTestCase {

	public ModelInterfaceGeneratorTest() {
	}

	/**
	 * IDEMPIERE-7094 - getClass() must not recurse forever (and blow the stack) when a
	 * Table/Search reference's key column is itself validated by a reference that resolves
	 * back to the same AD_Reference_ID - it must instead report the cycle with a clear
	 * exception.
	 * <p>
	 * Reproduces the scenario from the ticket: a column (here Test.T_Integer, borrowed
	 * for the duration of the test) is made a Search reference validated against a new
	 * Table Validation reference whose key column is that very same column. Resolving
	 * the column's class then has to resolve the reference, whose key column's own
	 * reference is the same reference again - i.e. a direct cycle.
	 * <p>
	 * getClass() queries with a null trxName (DB.prepareStatement(sql, null)), so it only
	 * sees committed data - the dictionary rows below are committed and then removed again
	 * in a finally block, following the same commit/track/cleanup pattern used by
	 * {@code MTableTest.testPartition()}.
	 */
	@Test
	public void testCyclicTableReferenceIsDetected() {
		MColumn column = new MColumn(Env.getCtx(), MColumn.getColumn_ID(MTest.Table_Name, MTest.COLUMNNAME_T_Integer), getTrxName());
		int originalAD_Reference_ID = column.getAD_Reference_ID();
		int originalAD_Reference_Value_ID = column.getAD_Reference_Value_ID();

		MReference cyclicReference = new MReference(Env.getCtx(), 0, getTrxName());
		MRefTable refTable = null;
		try {
			cyclicReference.setName("IDEMPIERE-7094 Test Cyclic Reference");
			cyclicReference.setEntityType("U");
			cyclicReference.setValidationType(MReference.VALIDATIONTYPE_TableValidation);
			cyclicReference.saveCrossTenantSafeEx();

			refTable = new MRefTable(Env.getCtx(), 0, getTrxName());
			refTable.setAD_Reference_ID(cyclicReference.getAD_Reference_ID());
			refTable.setAD_Table_ID(MTest.Table_ID);
			refTable.setAD_Key(column.getAD_Column_ID());
			refTable.setAD_Display(column.getAD_Column_ID());
			refTable.setEntityType("U");
			refTable.saveCrossTenantSafeEx();

			//	Close the loop: the column's own reference now resolves, via refTable, back to itself
			column.setAD_Reference_ID(DisplayType.Search);
			column.setAD_Reference_Value_ID(cyclicReference.getAD_Reference_ID());
			column.saveCrossTenantSafeEx();

			//	getClass() reads with trxName=null, so the rows above must be committed to be visible
			commit();

			IllegalStateException ex = assertThrows(IllegalStateException.class,
					() -> ModelInterfaceGenerator.getClass(column.getColumnName(), DisplayType.Search, cyclicReference.getAD_Reference_ID()),
					"A Table/Search reference resolving back to itself must be reported, not recursed into a StackOverflowError");
			assertTrue(ex.getMessage().contains(column.getColumnName()), "Exception message should name the affected column");
			assertTrue(ex.getMessage().contains(String.valueOf(cyclicReference.getAD_Reference_ID())), "Exception message should name the affected reference");
		} finally {
			column.set_TrxName(null);
			column.setAD_Reference_ID(originalAD_Reference_ID);
			column.setAD_Reference_Value_ID(originalAD_Reference_Value_ID);
			column.saveCrossTenantSafeEx();

			if (refTable != null && refTable.get_ID() > 0) {
				refTable.set_TrxName(null);
				refTable.deleteEx(true);
			}
			if (cyclicReference.get_ID() > 0) {
				cyclicReference.set_TrxName(null);
				cyclicReference.deleteEx(true);
			}
		}
	}

	/**
	 * Sanity check for the non-cyclic path, which does not touch the database at all -
	 * guards against a refactor of the cycle-detection guard breaking ordinary resolution.
	 */
	@Test
	public void testNonReferenceDisplayTypeIsUnaffected() {
		assertEquals(String.class, ModelInterfaceGenerator.getClass("SomeColumn", DisplayType.String, 0));
	}
}
