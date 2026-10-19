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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

import org.adempiere.util.ModelAccessorGenerator;
import org.adempiere.util.ModelInterfaceGenerator;
import org.compiere.util.DB;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

/**
 * Model generator outputs for a plug-in's columns on a core table: the suffixed interface and the accessor.
 * GardenWorld has no plug-in columns, so the generator is called through its class API on C_Order (entity type D) and the
 * generated source is checked as text. The command line refuses an accessor over core columns (S7), see ModelGeneratorOptionsTest.
 * Reads the dictionary only.
 */
public class ModelGeneratorTest extends AbstractTestCase {

	private static final String PACKAGE = "org.idempiere.test.generated";

	@Test
	public void testInterfaceWithSuffix(@TempDir Path folder) throws IOException {
		ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_INTERFACE, folder.toString(), PACKAGE,
				"D", "C_Order", "D", "Test");
		Path file = folder.resolve("org/idempiere/test/generated/I_C_Order_Test.java");
		assertTrue(Files.exists(file), "suffixed interface written");
		assertFalse(Files.exists(folder.resolve("org/idempiere/test/generated/I_C_Order.java")), "no unsuffixed interface");
		String src = Files.readString(file, StandardCharsets.UTF_8);
		assertTrue(src.contains("public interface I_C_Order_Test"));
		assertTrue(src.contains("public static final String Table_Name = \"C_Order\";"), "table name unchanged");
		assertTrue(src.contains("COLUMNNAME_DocumentNo = \"DocumentNo\""));
	}

	@Test
	public void testInterfaceWithoutSuffixUnchanged(@TempDir Path folder) throws IOException {
		ModelInterfaceGenerator.generateSource(folder.toString(), PACKAGE, "D", "C_Order", "D");
		String src = Files.readString(folder.resolve("org/idempiere/test/generated/I_C_Order.java"), StandardCharsets.UTF_8);
		assertTrue(src.contains("public interface I_C_Order "));
	}

	@Test
	public void testAccessor(@TempDir Path folder) throws IOException {
		ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR, folder.toString(), PACKAGE,
				"D", "C_Order", "D", "Test");
		String src = Files.readString(folder.resolve("org/idempiere/test/generated/C_Order_Test.java"), StandardCharsets.UTF_8);
		assertTrue(src.contains("public final class C_Order_Test\n"), "standalone: no interface");
		assertTrue(src.contains("public static final String Table_Name = \"C_Order\";"));
		assertTrue(src.contains("COLUMNNAME_DocumentNo = \"DocumentNo\""));
		assertTrue(src.contains("public static C_Order_Test of (PO po)"));
		// the X_ semantics, written at generation time
		assertTrue(src.contains("if (C_BPartner_ID < 1)\n\t\t\tset_Value (COLUMNNAME_C_BPartner_ID, null);"), "_ID below 1 is null, same text as X_");
		assertTrue(src.contains("if (C_DocType_ID < 0)"), "0 is a valid document type");
		assertTrue(src.contains("set_ValueNoCheck (COLUMNNAME_C_Order_ID,"), "key is not updateable");
		assertTrue(src.contains("public static C_Order_Test of (GridTab tab)"), "callout use");
		assertTrue(src.contains("String error = tab.setValue(columnName, value);"), "GridTab errors are reported");
		assertTrue(src.contains("public boolean isSOTrx()"));
		assertTrue(src.contains("public static final String DELIVERYRULE_Availability = \"A\";"), "list constants as in X_C_Order");
		assertTrue(src.contains("public static final int DELIVERYRULE_AD_Reference_ID=151;"));
		assertTrue(src.contains("return Env.ZERO;"), "empty amount reads as zero");
		assertTrue(src.contains("I_C_BPartner getC_BPartner() throws RuntimeException"), "referenced record, as the interface declares it");
		assertFalse(src.contains("void setAD_Client_ID") || src.contains("void setCreated "), "no setter where X_ has none");
		assertFalse(src.contains("@Override"));
	}

	@Test
	public void testAccessorImplementsInterface(@TempDir Path folder) throws IOException {
		ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR_INTERFACE, folder.toString(), PACKAGE,
				"D", "C_Order", "D", "Test");
		String src = Files.readString(folder.resolve("org/idempiere/test/generated/C_Order_Test.java"), StandardCharsets.UTF_8);
		assertTrue(src.contains("public final class C_Order_Test implements I_C_Order_Test"));
		assertTrue(src.contains("\t@Override\n\tpublic String getDocumentNo()"));
		assertFalse(src.contains("COLUMNNAME_DocumentNo = "), "constants come from the interface");
		assertTrue(src.contains("DELIVERYRULE_Availability"), "list constants also with the interface, which has none");
	}

	@Test
	public void testSuffixMustNotNameAnotherTable(@TempDir Path folder) {
		// M_Product + _PO is the table M_Product_PO: I_M_Product_PO exists in core
		assertThrows(IllegalArgumentException.class, () -> ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_INTERFACE,
				folder.toString(), PACKAGE, "D", "M_Product", "D", "PO"));
		assertThrows(IllegalArgumentException.class, () -> ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR,
				folder.toString(), PACKAGE, "D", "M_Product", "D", "PO"));
	}

	@Test
	public void testRefusalWritesNothing(@TempDir Path folder) throws IOException {
		// C_Order sorts before M_Product; the clash of M_Product_PO must stop the run before C_Order_PO is written
		assertThrows(IllegalArgumentException.class, () -> ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR,
				folder.toString(), PACKAGE, "D", "C_Order,M_Product", "D", "PO"));
		try (Stream<Path> files = Files.walk(folder)) {
			assertEquals(0, files.filter(f -> f.toString().endsWith(".java")).count());
		}
	}

	@Test
	public void testAccessorRefusesEncryptedColumn(@TempDir Path folder) {
		// X_ classes use set_ValueE / get_ValueE for an encrypted column, which the accessor cannot call; take any such column of the dictionary
		String table = DB.getSQLValueString(null, "SELECT t.TableName FROM AD_Column c JOIN AD_Table t ON t.AD_Table_ID=c.AD_Table_ID "
				+ "WHERE c.IsEncrypted='Y' AND c.IsActive='Y' AND c.EntityType='D' AND t.EntityType='D' AND t.IsView='N' "
				+ "AND (c.ColumnSQL IS NULL OR c.ColumnSQL NOT LIKE '@SQL%') ORDER BY t.TableName");
		assertNotNull(table, "no encrypted column of entity type D in the dictionary");
		IllegalArgumentException e = assertThrows(IllegalArgumentException.class, () -> ModelInterfaceGenerator.generateSource(
				ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR, folder.toString(), PACKAGE, "D", table, "D", "Test"));
		assertTrue(e.getMessage().contains("encrypted"), e.getMessage());
	}

	@Test
	public void testAccessorInterfaceRefusalWritesNothing(@TempDir Path folder) throws IOException {
		String table = DB.getSQLValueString(null, "SELECT t.TableName FROM AD_Column c JOIN AD_Table t ON t.AD_Table_ID=c.AD_Table_ID "
				+ "WHERE c.IsEncrypted='Y' AND c.IsActive='Y' AND c.EntityType='D' AND t.EntityType='D' AND t.IsView='N' "
				+ "AND (c.ColumnSQL IS NULL OR c.ColumnSQL NOT LIKE '@SQL%') ORDER BY t.TableName");
		assertNotNull(table, "no encrypted column of entity type D in the dictionary");
		assertThrows(IllegalArgumentException.class, () -> ModelInterfaceGenerator.generateSource(
				ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR_INTERFACE, folder.toString(), PACKAGE, "D", table, "D", "Test"));
		try (Stream<Path> files = Files.walk(folder)) {
			assertEquals(0, files.filter(f -> f.toString().endsWith(".java")).count(), "neither the accessor nor the interface is written");
		}
	}

	@Test
	public void testClassRefusesColumnNames(@TempDir Path folder) throws IOException {
		assertThrows(IllegalArgumentException.class, () -> ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_CLASS,
				folder.toString(), PACKAGE, "D", "C_Order", "D", null, "DocumentNo"));
		try (Stream<Path> files = Files.walk(folder)) {
			assertEquals(0, files.filter(f -> f.toString().endsWith(".java")).count());
		}
	}

	@Test
	public void testAccessorClassName() {
		assertEquals("C_Order_XYZ", ModelAccessorGenerator.className("C_Order", "XYZ"));
		assertThrows(IllegalArgumentException.class, () -> ModelAccessorGenerator.className("C_Order", null));
	}

	@Test
	public void testAccessorRefusesCoreColumnNamedWithColumns(@TempDir Path folder) throws IOException {
		// --columns names a column of the dictionary entity type D: the accessor would skip the logic of MOrder
		IllegalArgumentException e = assertThrows(IllegalArgumentException.class, () -> ModelInterfaceGenerator.generateSource(
				ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR_INTERFACE, folder.toString(), PACKAGE, "D", "C_Order", null, "Test", "DocumentNo,C_BPartner_ID"));
		assertTrue(e.getMessage().startsWith("S7"), e.getMessage());
		try (Stream<Path> files = Files.walk(folder)) {
			assertEquals(0, files.filter(f -> f.toString().endsWith(".java")).count(), "nothing is written");
		}
	}
}
