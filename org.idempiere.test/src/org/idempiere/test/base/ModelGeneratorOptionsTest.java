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

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.function.Predicate;

import org.adempiere.util.ModelGeneratorLaunch;
import org.adempiere.util.ModelGeneratorOptions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

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
		assertTrue(o.toNamedArgs("F").contains("--output=interface,accessor"));
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
				"--tables=C_Invoice", "--table-entity-type=D", "--allow-all-columns"});
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
	public void testS6InterfaceWithoutSuffix() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=com.xyz.model",
				"--tables=C_Order", "--table-entity-type=D", "--column-entity-type=XYZ", "--output=interface"});
		assertTrue(o.warnings().stream().anyMatch(w -> w.startsWith("S6")));
	}

	@Test
	public void testLaunchKeepsPlatformArgumentsAndReplacesGeneratorArguments() {
		String template = "<launchConfiguration>\n<stringAttribute key=\"org.eclipse.jdt.launching.PROGRAM_ARGUMENTS\" "
				+ "value=\"-os ${target.os} -consoleLog -noSplash --folder=/old\"/>\n</launchConfiguration>";
		String xml = ModelGeneratorLaunch.create(template, List.of("--folder=${workspace_loc:p}/src", "--tables=A&B", "--package=x y"));
		assertTrue(xml.contains("value=\"-os ${target.os} -consoleLog -noSplash --folder=${workspace_loc:p}/src --tables=A&amp;B &quot;--package=x y&quot;\""), xml);
		assertFalse(xml.contains("/old"), "an earlier generator call is replaced");
	}

	@Test
	public void testLaunchDropsPositionalLeftovers() {
		String template = "<launchConfiguration>\n<stringAttribute key=\"org.eclipse.jdt.launching.PROGRAM_ARGUMENTS\" "
				+ "value=\"-os ${target.os} -ws ${target.ws} -consoleLog -noSplash /tmp/x com.xyz.model D C_Order --folder=/old\"/>\n</launchConfiguration>";
		String xml = ModelGeneratorLaunch.create(template, List.of("--folder=F", "--tables=C_Order"));
		assertTrue(xml.contains("value=\"-os ${target.os} -ws ${target.ws} -consoleLog -noSplash --folder=F --tables=C_Order\""), xml);
		assertFalse(xml.contains("/tmp/x") || xml.contains("com.xyz.model") || xml.contains("C_Order --"), "positional leftovers are dropped");
		assertFalse(xml.contains("/old"));
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
	public void testCheckRefusedWithWriteLaunch() {
		assertThrows(IllegalArgumentException.class, () -> ModelGeneratorOptions.parse(new String[] {"--folder=/src", "--package=p",
				"--tables=C_Order", "--output=interface", "--check", "--write-launch=x.launch"}));
	}

	@Test
	public void testWorkspacePath(@TempDir Path dir) throws IOException {
		Path project = dir.resolve("org.idempiere.XYZ");
		Files.createDirectories(project.resolve("src"));
		Files.writeString(project.resolve(".project"), "<projectDescription><name>org.idempiere.XYZ</name></projectDescription>");
		assertEquals("${workspace_loc:org.idempiere.XYZ}/src", ModelGeneratorLaunch.workspacePath(project.resolve("src").toString()));
		assertEquals(dir.toString(), ModelGeneratorLaunch.workspacePath(dir.toString()), "outside a project: unchanged");
	}

	@Test
	public void testNamedArgsOfAPositionalCall() {
		ModelGeneratorOptions o = ModelGeneratorOptions.parse(new String[] {"/src", "com.xyz.model", "XYZ", "XYZ_%"});
		assertEquals(List.of("--folder=F", "--package=com.xyz.model", "--tables=XYZ_%", "--table-entity-type=XYZ",
				"--output=interface,class"), o.toNamedArgs("F"));
		o = ModelGeneratorOptions.parse(new String[] {"--folder=/s", "--package=p", "--tables=C_Order", "--table-entity-type=D",
				"--column-entity-type=XYZ", "--columns=A,B", "--output=accessor", "--suffix=XYZ", "--write-launch=x.launch"});
		assertEquals(List.of("--folder=F", "--package=p", "--tables=C_Order", "--table-entity-type=D", "--column-entity-type=XYZ",
				"--columns=A,B", "--output=accessor", "--suffix=XYZ"), o.toNamedArgs("F"), "--write-launch is not repeated");
	}
}
