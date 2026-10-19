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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Stream;

import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;

import org.adempiere.util.ModelInterfaceGenerator;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MOrder;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Bundle;
import org.osgi.framework.FrameworkUtil;

/**
 * Behaviour of a generated accessor, with nothing generated checked in. GardenWorld has no plug-in columns, so the accessor
 * is generated into a temporary folder over the columns of C_Order, compiled with the JDK compiler and loaded here; the tests
 * call it by reflection. The command line refuses an accessor over core columns (S7), the class API used here does not,
 * so these tests do not show a pattern to follow. Writes nothing to the database (each test rolls back).
 */
public class ModelGeneratorAccessorTest extends AbstractTestCase {

	private static final String PACKAGE = "org.idempiere.test.generated";
	private static final String CLASS_NAME = PACKAGE + ".C_Order_Test";

	private static Path folder;
	private static URLClassLoader loader;
	private static Class<?> accessor;

	@BeforeEach
	public void compileAccessorOnce() throws Exception {
		if (accessor != null)
			return;
		folder = Files.createTempDirectory("accessor-test");
		ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR, folder.toString(), PACKAGE,
				"D", "C_Order", "D", "Test");
		JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
		assertNotNull(compiler, "the tests need a JDK, not a JRE");
		Path source = folder.resolve(CLASS_NAME.replace('.', '/') + ".java");
		java.io.StringWriter errors = new java.io.StringWriter();
		boolean compiled = compiler.getTask(errors, null, null, List.of("-proc:none", "-nowarn", "-classpath", classPath(), "-d", folder.toString()),
				null, compiler.getStandardFileManager(null, null, null).getJavaFileObjects(source)).call();
		assertTrue(compiled, "the generated accessor compiles: " + errors + "\nclasspath: " + classPath().replace(java.io.File.pathSeparator, "\n"));
		loader = new URLClassLoader(new URL[] {folder.toUri().toURL()}, PO.class.getClassLoader());
		accessor = loader.loadClass(CLASS_NAME);
	}

	/** the jar of every installed bundle; a location is like initial@reference:file:../../../org.adempiere.base/target/x.jar, relative to an OSGi area */
	private static String classPath() {
		List<Path> bases = new ArrayList<>();
		for (String key : new String[] {"user.dir", "osgi.install.area", "osgi.configuration.area", "osgi.syspath", "osgi.framework"}) {
			String value = System.getProperty(key);
			if (value == null)
				continue;
			try {
				bases.add(value.startsWith("file:") ? Path.of(java.net.URI.create(value.replace(" ", "%20"))) : Path.of(value));
			} catch (RuntimeException e) {
				// not a usable location: try the next area
			}
		}
		List<String> entries = new ArrayList<>();
		Bundle bundle = FrameworkUtil.getBundle(PO.class);
		for (Bundle b : bundle.getBundleContext().getBundles()) {
			String location = b.getLocation();
			if (location == null)
				continue;
			location = location.replaceFirst("^initial@", "").replaceFirst("^reference:", "").replaceFirst("^file:", "");
			Path path = Path.of(location);
			if (path.isAbsolute()) {
				if (Files.exists(path))
					entries.add(path.toString());
				continue;
			}
			for (Path base : bases) {
				Path candidate = (Files.isDirectory(base) ? base : base.getParent()).resolve(path).normalize();
				if (Files.exists(candidate)) {
					entries.add(candidate.toString());
					break;
				}
			}
		}
		return String.join(java.io.File.pathSeparator, entries);
	}

	@AfterAll
	public static void cleanUp() throws IOException {
		accessor = null;
		if (loader != null)
			loader.close();
		if (folder != null)
			try (Stream<Path> files = Files.walk(folder)) {
				files.sorted(Comparator.reverseOrder()).forEach(f -> f.toFile().delete());
			}
	}

	private static Object of(Class<?> parameter, Object po) throws Exception {
		return call(null, "of", parameter, po);
	}

	/** calls a method of the generated accessor (or a static one when target is null), giving the exception of the accessor back */
	private static Object call(Object target, String name, Object... args) throws Exception {
		Class<?> parameter = null;
		if (target == null && args.length == 2 && args[0] instanceof Class<?> c) {
			parameter = c;
			args = new Object[] {args[1]};
		}
		for (Method m : accessor.getMethods()) {
			if (!m.getName().equals(name) || m.getParameterCount() != args.length)
				continue;
			if (parameter != null && m.getParameterTypes()[0] != parameter)
				continue;
			if (!accepts(m, args))
				continue;
			try {
				return m.invoke(target, args);
			} catch (InvocationTargetException e) {
				if (e.getCause() instanceof Exception ex)
					throw ex;
				throw e;
			}
		}
		throw new NoSuchMethodException(name);
	}

	private static boolean accepts(Method m, Object[] args) {
		Class<?>[] types = m.getParameterTypes();
		for (int i = 0; i < types.length; i++) {
			if (args[i] == null)
				continue;
			Class<?> type = types[i];
			if (type == int.class)
				type = Integer.class;
			else if (type == boolean.class)
				type = Boolean.class;
			if (!type.isInstance(args[i]))
				return false;
		}
		return true;
	}

	private static Object constant(String name) throws Exception {
		return accessor.getField(name).get(null);
	}

	@Test
	public void testGeneratedAccessorBehavesAsX() throws Exception {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		Object acc = of(PO.class, order);
		assertEquals(order, call(acc, "getPO"));

		// a foreign key below 1 is stored as null and read as 0, as in X_C_Order
		call(acc, "setC_BPartner_ID", 0);
		assertNull(order.get_Value("C_BPartner_ID"));
		assertEquals(0, call(acc, "getC_BPartner_ID"));
		call(acc, "setC_BPartner_ID", DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		assertEquals(order.getC_BPartner_ID(), call(acc, "getC_BPartner_ID"));
		assertEquals(DictionaryIDs.C_BPartner.JOE_BLOCK.id, ((MBPartner) call(acc, "getC_BPartner")).getC_BPartner_ID());

		// 0 is a valid document type, as in X_C_Order
		call(acc, "setC_DocType_ID", 0);
		assertEquals(Integer.valueOf(0), order.get_Value("C_DocType_ID"));

		call(acc, "setIsSOTrx", false);
		assertFalse(order.isSOTrx());
		call(acc, "setIsSOTrx", true);
		assertEquals(order.isSOTrx(), call(acc, "isSOTrx"));

		call(acc, "setDeliveryRule", constant("DELIVERYRULE_Force"));
		assertEquals(MOrder.DELIVERYRULE_Force, order.getDeliveryRule());

		call(acc, "setDescription", "typed");
		assertEquals("typed", order.getDescription());

		order.set_ValueNoCheck("GrandTotal", null);
		assertEquals(Env.ZERO, call(acc, "getGrandTotal"), "empty amount reads as zero, like getGrandTotal()");
		call(acc, "setGrandTotal", BigDecimal.TEN);
		assertEquals(BigDecimal.TEN, order.getGrandTotal());

		// works on an object core created, without a model factory
		assertThrows(IllegalArgumentException.class, () -> of(PO.class, new MProduct(Env.getCtx(), 0, getTrxName())),
				"another table is refused");
		assertThrows(IllegalArgumentException.class, () -> of(PO.class, null));
	}

	@Test
	public void testGeneratedAccessorSaves() throws Exception {
		MOrder order = newOrder();
		call(of(PO.class, order), "setDescription", "saved through the accessor");
		order.saveEx();

		MOrder reread = new MOrder(Env.getCtx(), order.getC_Order_ID(), getTrxName());
		assertEquals("saved through the accessor", call(of(PO.class, reread), "getDescription"));
		assertEquals(order.getDocumentNo(), call(of(PO.class, reread), "getDocumentNo"));
	}

	@Test
	public void testGeneratedAccessorOnGridTab() throws Exception {
		MOrder order = newOrder();
		order.setDescription("before");
		order.saveEx();

		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_SALES_ORDER);
		gridWindow.initTab(0);
		GridTab tab = gridWindow.getTab(0);
		MQuery query = new MQuery(MOrder.Table_Name);
		query.addRestriction(MOrder.COLUMNNAME_C_Order_ID, "=", order.get_ID());
		tab.setQuery(query);
		tab.getTableModel().setImportingMode(false, getTrxName());
		tab.query(false);
		assertEquals(1, tab.getRowCount());

		// the same accessor as on the model object, now over the fields of the tab (as in a callout)
		Object acc = of(GridTab.class, tab);
		assertEquals(tab, call(acc, "getGridTab"));
		assertNull(call(acc, "getPO"));
		assertEquals(order.getDocumentNo(), call(acc, "getDocumentNo"));
		assertEquals("before", call(acc, "getDescription"));
		assertEquals(order.isSOTrx(), call(acc, "isSOTrx"));

		call(acc, "setDescription", "set in a callout");
		assertEquals("set in a callout", tab.getValue(MOrder.COLUMNNAME_Description));
		call(acc, "setDeliveryRule", constant("DELIVERYRULE_Force"));
		assertEquals(MOrder.DELIVERYRULE_Force, tab.getValue(MOrder.COLUMNNAME_DeliveryRule));

		// the referenced record is read in the transaction of the tab
		assertEquals(DictionaryIDs.C_BPartner.JOE_BLOCK.id, ((MBPartner) call(acc, "getC_BPartner")).getC_BPartner_ID());

		// another table is refused
		assertThrows(IllegalArgumentException.class, () -> of(GridTab.class, null));
		tab.dataIgnore();
	}

	private MOrder newOrder() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setBPartner(new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName()));
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		return order;
	}
}
