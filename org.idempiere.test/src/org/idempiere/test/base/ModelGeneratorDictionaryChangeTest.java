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
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;

import org.adempiere.base.ModelGeneratorApplication;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

/**
 * The model generator when the dictionary changes: a column is added to C_Order, changed and removed, the way a plug-in
 * adds columns. The column is a dictionary record only (no database column), which is all the generator reads.
 * The calls go through the command line path of {@code ModelGeneratorApplication} (its private {@code execute}, by
 * reflection), so the safety rules, {@code --check} and the exit results are the real ones.
 * The column is committed because the generator reads the dictionary outside the test transaction, and deleted again
 * after each test, as in {@code ModelInterfaceGeneratorTest}.
 */
public class ModelGeneratorDictionaryChangeTest extends AbstractTestCase {

	private static final String COLUMN = "XYZ_TestNote";
	private static final String PACKAGE = "com.xyz.model";
	private static final String ACCESSOR = "com/xyz/model/C_Order_XYZ.java";
	private static final String INTERFACE = "com/xyz/model/I_C_Order_XYZ.java";

	private int columnId = 0;
	private String output = "";

	@BeforeEach
	public void removeLeftOver() {
		// a column left behind by a crashed run would make the next run fail with a duplicate name
		for (int id : new Query(Env.getCtx(), MColumn.Table_Name, "AD_Table_ID=? AND ColumnName=?", null)
				.setParameters(MTable.getTable_ID("C_Order"), COLUMN).getIDs())
			delete(id);
	}

	@AfterEach
	public void deleteColumn() {
		if (columnId > 0) {
			delete(columnId);
			columnId = 0;
		}
		assertEquals(0, DB.getSQLValue(null, "SELECT COUNT(*) FROM AD_Column WHERE AD_Table_ID=? AND ColumnName=?",
				MTable.getTable_ID("C_Order"), COLUMN), "the test leaves no column behind");
	}

	/** a plain delete of the test record: the model delete is refused for a dictionary record of the system client */
	private static void delete(int id) {
		DB.executeUpdateEx("DELETE FROM AD_Column WHERE AD_Column_ID=?", new Object[] {id}, null);
		refreshDictionaryCache();
	}

	/** the generator reads the column list of the table from the cache: a process of its own never sees a stale one */
	private static void refreshDictionaryCache() {
		CacheMgt.get().reset(MColumn.Table_Name);
		CacheMgt.get().reset(MTable.Table_Name);
	}

	/** adds XYZ_TestNote to C_Order as a plug-in would: entity type U, a string */
	private void addColumn() {
		MColumn column = new MColumn(MTable.get(Env.getCtx(), "C_Order"));
		column.setColumnName(COLUMN);
		column.setName(COLUMN);
		column.setEntityType("U");
		column.setAD_Reference_ID(DisplayType.String);
		column.setFieldLength(60);
		column.saveCrossTenantSafeEx();
		columnId = column.getAD_Column_ID();
		commit();
		refreshDictionaryCache();
	}

	private void changeColumnToInteger() {
		MColumn column = new MColumn(Env.getCtx(), columnId, null);
		column.setAD_Reference_ID(DisplayType.Integer);
		column.setFieldLength(10);
		column.saveCrossTenantSafeEx();
		commit();
		refreshDictionaryCache();
	}

	private void removeColumn() {
		delete(columnId);
		columnId = 0;
	}

	private static String[] args(Path folder, boolean check, String... more) {
		java.util.List<String> list = new java.util.ArrayList<>(java.util.List.of("--folder=" + folder, "--package=" + PACKAGE,
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=U", "--output=interface,accessor", "--suffix=XYZ"));
		if (check)
			list.add("--check");
		list.addAll(java.util.List.of(more));
		return list.toArray(new String[0]);
	}

	/** runs the command line path and keeps what it printed in {@link #output}; returns ok, refused, error or differs */
	private String run(String... args) throws Exception {
		Method execute = ModelGeneratorApplication.class.getDeclaredMethod("execute", String[].class);
		execute.setAccessible(true);
		ModelGeneratorApplication application = ModelGeneratorApplication.class.getDeclaredConstructor().newInstance();
		PrintStream console = System.out;
		ByteArrayOutputStream captured = new ByteArrayOutputStream();
		System.setOut(new PrintStream(captured, true, StandardCharsets.UTF_8));
		try {
			return ((Enum<?>) execute.invoke(application, (Object) args)).name();
		} catch (InvocationTargetException e) {
			if (e.getCause() instanceof Exception ex)
				throw ex;
			throw e;
		} finally {
			System.setOut(console);
			output = captured.toString(StandardCharsets.UTF_8);
		}
	}

	private static String read(Path folder, String file) throws IOException {
		return Files.readString(folder.resolve(file), StandardCharsets.UTF_8);
	}

	@Test
	public void testNewColumnAppearsInAccessorAndInterface(@TempDir Path folder) throws Exception {
		addColumn();
		assertEquals("OK", run(args(folder, false)), output);
		String accessor = read(folder, ACCESSOR);
		assertTrue(accessor.contains("getXYZ_TestNote") && accessor.contains("setXYZ_TestNote"), "typed get and set for the new column");
		assertTrue(read(folder, INTERFACE).contains("COLUMNNAME_XYZ_TestNote"), "constant in the suffixed interface");
	}

	@Test
	public void testCheckPassesAfterGenerateAndFindsAColumnChange(@TempDir Path folder) throws Exception {
		addColumn();
		assertEquals("OK", run(args(folder, false)), output);
		assertEquals("OK", run(args(folder, true)), "generated files match the dictionary: " + output);

		changeColumnToInteger();
		assertEquals("DIFFERS", run(args(folder, true)), "the column is an integer now: " + output);
		assertTrue(output.contains("differs"), output);
	}

	@Test
	public void testCheckFindsARemovedColumn(@TempDir Path folder) throws Exception {
		addColumn();
		assertEquals("OK", run(args(folder, false)), output);

		removeColumn();
		assertNotEquals("OK", run(args(folder, true)), "the column is gone from the dictionary but still in the files: " + output);
	}

	@Test
	public void testColumnsListWithTheNewColumnOnly(@TempDir Path folder) throws Exception {
		addColumn();
		assertEquals("OK", run(args(folder, false, "--columns=" + COLUMN)), output);
		assertTrue(read(folder, ACCESSOR).contains("getXYZ_TestNote"));
	}

	@Test
	public void testCoreColumnNextToTheNewColumnIsRefused(@TempDir Path folder) throws Exception {
		addColumn();
		assertEquals("REFUSED", run(args(folder, false, "--columns=" + COLUMN + ",DocumentNo")), output);
		assertTrue(output.contains("S7"), output);
		assertFalse(Files.exists(folder.resolve(ACCESSOR)), "nothing is written");
	}

	@Test
	public void testRemovedColumnIsAnUnknownName(@TempDir Path folder) throws Exception {
		addColumn();
		removeColumn();
		assertEquals("REFUSED", run(args(folder, false, "--columns=" + COLUMN)), output);
		assertTrue(output.contains("No column matches " + COLUMN), output);
		assertFalse(Files.exists(folder.resolve(ACCESSOR)), "nothing is written");
	}
}
