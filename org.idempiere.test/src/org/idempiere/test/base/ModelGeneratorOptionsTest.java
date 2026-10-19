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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.function.Predicate;

import org.adempiere.util.ModelGeneratorOptions;
import org.junit.jupiter.api.Test;

/**
 * Command line options of the model generator. No database needed.
 */
public class ModelGeneratorOptionsTest {

	/** D and the EE entity types are system maintained, plug-in entity types are not */
	private static final Predicate<String> SYSTEM = et -> et.equals("D") || et.startsWith("EE");

	@Test
	public void testPositionalFormUnchanged() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"/src", "com.xyz.model", "XYZ", "XYZ_%"});
		assertFalse(o.isNamed());
		assertEquals("/src", o.getFolder());
		assertEquals("com.xyz.model", o.getPackageName());
		assertEquals("XYZ", o.getTableEntityType());
		assertEquals("XYZ_%", o.getTableName());
		assertNull(o.getColumnEntityType());
		assertTrue(o.isGenerateInterface());
		assertTrue(o.isGenerateClass());

		o = ModelGeneratorOptions.parse(new String[] {"/src", "com.xyz.model", "XYZ", "XYZ_%", "XYZ"});
		assertEquals("XYZ", o.getColumnEntityType());
	}

	@Test
	public void testPositionalWrongCount() {
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"/src", "pkg", "XYZ"}));
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"a", "b", "c", "d", "e", "f"}));
	}

	@Test
	public void testNamedArgumentMixedIntoPositionalIsRefused() {
		// the call that overwrote I_C_Order and X_C_Order: --output=accessor was taken as the column entity type
		IllegalArgumentException e = assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(
				new String[] {"/path/org.adempiere.base/src/", "org.compiere.model", "D", "C_Order", "--output=accessor"}));
		assertTrue(e.getMessage().contains("cannot be mixed") && e.getMessage().contains("--output=accessor"), e.getMessage());
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(
				new String[] {"/src", "com.xyz.model", "XYZ", "XYZ_%", "--check"}));
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(
				new String[] {"/src", "com.xyz.model", "--check"}), "also when the count is wrong");
	}

	@Test
	public void testNamedForm() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Invoice", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=interface", "--check"});
		assertTrue(o.isNamed());
		assertEquals("C_Invoice", o.getTableName());
		assertEquals("XYZ", o.getColumnEntityType());
		assertTrue(o.isGenerateInterface());
		assertFalse(o.isGenerateClass());
		assertTrue(o.isCheck());
		assertTrue(o.missing().isEmpty());
	}

	@Test
	public void testAccessorOutput() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=p",
				"--tables=C_OrderSource", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=interface,accessor", "--suffix=XYZ"});
		assertTrue(o.isGenerateAccessor());
		assertTrue(o.isGenerateInterface());
		assertFalse(o.isGenerateClass());
		assertFalse(ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=p", "--tables=C_Order"}).isGenerateAccessor(),
				"not in the default output");
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=p",
				"--tables=C_Order", "--output=accessor"}), "accessor needs the owner as suffix");
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=p",
				"--tables=C_Order", "--columns=DocumentNo"}), "default output includes the class, which ignores --columns");
	}

	@Test
	public void testNamedErrors() {
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--unknown=1"}));
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--folder"}));
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--check=yes"}));
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--output=wrapper"}));
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--folder=/src", "C_Invoice"}));
	}

	@Test
	public void testTemplateDoesNotOverrideArguments() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--template=xyz", "--tables=XYZ_Order"});
		assertEquals(List.of("--folder", "--package"), o.missing());
		o.applyTemplate("/tpl", "com.xyz.model", "XYZ_%", "XYZ", "XYZ");
		assertEquals("/tpl", o.getFolder());
		assertEquals("XYZ_Order", o.getTableName());
		assertTrue(o.missing().isEmpty());
	}

	@Test
	public void testOwnTablesAreSafe() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=XYZ_%", "--table-entity-type=XYZ", "--column-entity-type=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).isEmpty());
	}

	@Test
	public void testS1CoreTableWithoutColumnFilter() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Invoice", "--table-entity-type=D"});
		assertTrue(o.safetyProblems(SYSTEM).stream().anyMatch(p -> p.startsWith("S1")));

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=org.compiere.model",
				"--tables=C_Invoice", "--table-entity-type=D", "--column-entity-type=D"});
		assertTrue(o.safetyProblems(SYSTEM).isEmpty(), "release procedure on a vanilla seed");
	}

	@Test
	public void testS2PartialClass() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Invoice", "--table-entity-type=D", "--column-entity-type=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).stream().anyMatch(p -> p.startsWith("S2")), "class output is the default");

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Invoice", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=interface"});
		assertTrue(o.safetyProblems(SYSTEM).isEmpty(), "interface only is the safe call for columns on a core table");

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=ABC_Carrier", "--table-entity-type=ABC", "--column-entity-type=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).stream().anyMatch(p -> p.startsWith("S2")), "another plug-in's table");
	}

	@Test
	public void testS4PluginColumnsIntoCorePackage() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=org.compiere.model",
				"--tables=C_Invoice", "--table-entity-type=D", "--column-entity-type=D,XYZ", "--output=interface"});
		assertTrue(o.safetyProblems(SYSTEM).stream().anyMatch(p -> p.startsWith("S4")));

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=org.compiere.model",
				"--tables=C_Invoice", "--table-entity-type=D", "--column-entity-type=D"});
		assertTrue(o.safetyProblems(SYSTEM).isEmpty(), "core development: core columns into the core package");
	}

	@Test
	public void testPositionalUnsafeCallIsOnlyReported() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"/src", "com.xyz.model", "D", "C_Invoice", "XYZ"});
		assertFalse(o.isNamed(), "the caller warns instead of refusing for the positional form");
		assertFalse(o.safetyProblems(SYSTEM).isEmpty());
	}

	@Test
	public void testS4RefusedAlsoInPositionalForm() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"/src", "org.compiere.model", "D", "C_Order", "XYZ"});
		assertFalse(o.isNamed());
		List<String> problems = o.safetyProblems(SYSTEM);
		assertTrue(problems.stream().anyMatch(p -> p.startsWith("S4")));
		assertTrue(problems.stream().filter(p -> p.startsWith("S4")).allMatch(o::isRefused), "writes plug-in columns into core sources");
		assertTrue(problems.stream().filter(p -> !p.startsWith("S4")).noneMatch(o::isRefused), "the other problems only warn");
	}

	@Test
	public void testPlainPositionalCallsStillWork() {
		// core development, as before: core columns into the core package
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"/src", "org.compiere.model", "D", "C_Order", "D"});
		assertTrue(o.safetyProblems(SYSTEM).isEmpty());
		// no column entity type: all columns, only a warning (S1)
		o = ModelGeneratorOptions.parse(new String[] {"/src", "org.compiere.model", "D", "C_Order"});
		List<String> problems = o.safetyProblems(SYSTEM);
		assertTrue(problems.stream().anyMatch(p -> p.startsWith("S1")));
		assertTrue(problems.stream().noneMatch(o::isRefused));
	}

	@Test
	public void testNamedFormRefusesEveryProblem() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=org.compiere.model",
				"--tables=C_Order", "--table-entity-type=D"});
		assertTrue(o.safetyProblems(SYSTEM).stream().allMatch(o::isRefused));
	}

	@Test
	public void testEntityTypesQuotedList() {
		assertEquals(List.of("D", "XYZ"), ModelGeneratorOptions.entityTypes("'D', XYZ"));
		assertTrue(ModelGeneratorOptions.entityTypes(" ").isEmpty());
	}

	@Test
	public void testSuffixForInterfaceAndAccessor() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=interface,accessor", "--suffix=XYZ"});
		assertEquals("XYZ", o.getSuffix());
		assertTrue(o.isGenerateInterface());
		assertTrue(o.isGenerateAccessor());
		assertFalse(o.isGenerateClass());
		assertTrue(o.safetyProblems(SYSTEM).isEmpty());
		assertTrue(o.warnings().isEmpty(), "suffix given: no name clash");
	}

	@Test
	public void testSuffixRefusedWithClassOutput() {
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--folder=/src",
				"--package=p", "--tables=C_Order", "--suffix=XYZ"}), "default output includes the class");
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--folder=/src",
				"--package=p", "--tables=C_Order", "--output=interface", "--suffix=X-Y"}), "not a Java name part");
	}

	@Test
	public void testAccessorOnlyIsSafe() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=accessor", "--suffix=XYZ"});
		assertTrue(o.isGenerateAccessor());
		assertFalse(o.isGenerateInterface());
		assertTrue(o.safetyProblems(SYSTEM).isEmpty());
		assertTrue(o.warnings().isEmpty(), "no interface, no clash");
	}

	@Test
	public void testS7AccessorOverDictionaryColumns() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=D", "--output=interface,accessor", "--suffix=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).stream().anyMatch(p -> p.startsWith("S7")));
		assertTrue(o.safetyProblems(SYSTEM).stream().filter(p -> p.startsWith("S7")).allMatch(o::isRefused), "refused: nothing is written");

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=D,XYZ", "--output=accessor", "--suffix=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).stream().anyMatch(p -> p.startsWith("S7")), "one core entity type is enough");

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=interface,accessor", "--suffix=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).isEmpty(), "the columns of a plug-in");

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=D", "--output=interface", "--suffix=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).stream().noneMatch(p -> p.startsWith("S7")), "S7 is about the accessor only");

		o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=EE1", "--output=interface,accessor", "--suffix=XYZ"});
		assertTrue(o.safetyProblems(SYSTEM).stream().noneMatch(p -> p.startsWith("S7")),
				"a system maintained entity type other than D, for example one of a company, is not refused by S7");
	}

	@Test
	public void testS6InterfaceWithoutSuffix() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=interface"});
		assertTrue(o.warnings().stream().anyMatch(w -> w.startsWith("S6")));
	}

	@Test
	public void testHelp() {
		assertTrue(ModelGeneratorOptions.isHelp(new String[] {"--help"}));
		assertTrue(ModelGeneratorOptions.isHelp(new String[] {"--folder=/src", "--help"}));
		assertFalse(ModelGeneratorOptions.isHelp(new String[] {"--folder=/src", "--check"}));
		assertFalse(ModelGeneratorOptions.isHelp(new String[] {"/src", "p", "D", "C_Order"}));
		assertFalse(ModelGeneratorOptions.isHelp(null));
		assertTrue(ModelGeneratorOptions.usage().contains("--folder") && ModelGeneratorOptions.usage().contains("--check"));
	}

	@Test
	public void testCheckNeedsGeneratedFiles() {
		assertFalse(ModelGeneratorOptions.isCheckPassed(0, 0), "a check that generated nothing has checked nothing");
		assertTrue(ModelGeneratorOptions.isCheckPassed(2, 0));
		assertFalse(ModelGeneratorOptions.isCheckPassed(2, 1));
	}
}
