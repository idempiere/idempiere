/*
 * Copyright (c) 2010 Rick Mugridge, www.RimuResearch.com
 * Released under the terms of the GNU General Public License version 2 or later.
 */

package fitlibrary.traverse.workflow.caller;

import java.lang.reflect.InvocationTargetException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.adempiere.base.Service;
import org.apache.log4j.Logger;
import org.idempiere.fitnesse.server.fit.IFitFixtureFactory;

import fit.Fixture;
import fit.FixtureName;
import fitlibrary.exception.classes.ConstructorNotVisible;
import fitlibrary.exception.classes.NoNullaryConstructor;
import fitlibrary.log.FitLibraryLogger;
import fitlibrary.runResults.TestResults;
import fitlibrary.table.Row;
import fitlibrary.table.TableFactory;
import fitlibrary.traverse.Evaluator;
import fitlibrary.traverse.workflow.AbstractDoCaller;
import fitlibrary.typed.TypedObject;
import fitlibrary.utility.ClassUtility;
import fitlibraryGeneric.typed.GenericTypedObject;

public class CreateFromClassNameCaller extends AbstractDoCaller {
	private static Logger logger = FitLibraryLogger.getLogger(CreateFromClassNameCaller.class);
	private static final ThreadLocal<Set<String>> packages = // Put into Runtime
		new ThreadLocal<Set<String>> () {
		@Override
		protected Set<String> initialValue() {
			HashSet<String> hashSet = new HashSet<String>();
			hashSet.add("fit.");
			return hashSet;
		}
	};
	private String className;
	private Object object = null;
	private Exception exceptionToThrow = null;

	public CreateFromClassNameCaller(Row row, Evaluator evaluator) {
		this.className = substituteName(row.text(0,evaluator).trim());		
		try {
			object = instantiateObject(className);			
			if (object == null && validClassName()) {
				Class<?> determineFullClass = determineFullClass();
				object = ClassUtility.newInstance(determineFullClass);
			}
			logger.trace("Created "+object);
			if (row.size() > 1 && object instanceof Fixture)
					handleArgs((Fixture)object,row);
		} catch (NoSuchMethodException ex) {
			exceptionToThrow = new NoNullaryConstructor(className,evaluator.getRuntimeContext());
		} catch (NoClassDefFoundError ex) { // "The definition can no longer be found"
			exceptionToThrow = new RuntimeException(ex);
		} catch (InstantiationException ex) {
			exceptionToThrow = new NoNullaryConstructor(className,evaluator.getRuntimeContext());
		} catch (IllegalAccessException ex) {
			exceptionToThrow = new ConstructorNotVisible(className,evaluator.getRuntimeContext());
		} catch (InvocationTargetException ex) {
			exceptionToThrow = ex;
		} catch (Throwable e) {
			// Nothing to do
		}
	}
	private Object instantiateObject(String className) {
		FixtureName fixtureName = new FixtureName(className);
		List<IFitFixtureFactory> factories = Service.locator().list(IFitFixtureFactory.class).getServices();
		for(IFitFixtureFactory factory : factories) {
			Object fixture = factory.getFixture(fixtureName);
			if (fixture != null)
				return fixture;
		}
		return null;
	}
	private boolean validClassName() {
		return !className.isEmpty() && !className.contains(" ") &&
			(className.contains(".") || Character.isUpperCase(className.charAt(0)));
	}
	private String substituteName(String name) {
		if ("Import".equals(name) || "fit.Import".equals(name) || "ImportFixture".equals(name) || "fit.ImportFixture".equals(name)) {
			return "fitlibrary.DefaultPackages";
		}
		return name;
	}
	private Class<?> determineFullClass() throws ClassNotFoundException {
		ClassLoader loader = getClass().getClassLoader();
		try {
			return loader.loadClass(className);
		} catch (Throwable e) {
			try {
				return loader.loadClass(className+"Fixture");
			} catch (Throwable e1) {
				for (String s : packages.get()) {
					try {
						return loader.loadClass(s+className);
					} catch (Exception e2) {
						try {
							return loader.loadClass(s+className+"Fixture");
						} catch (ClassNotFoundException e3) {
							// Do nothing
						} catch (NoClassDefFoundError e4) {
							// Do nothing
						}
					}
				}
			}
		}
		throw new ClassNotFoundException(className);
	}
	private void handleArgs(Fixture fixture, Row row) {
		fixture.getArgsForTable(TableFactory.table(row).asParse());
	}
	@Override
	public boolean isValid() {
		return object != null || exceptionToThrow != null;
	}
	@Override
	public String ambiguityErrorMessage() {
		return "class " + className;
	}
	@Override
	public TypedObject run(Row row, TestResults testResults) throws Exception {
		if (exceptionToThrow != null)
			throw exceptionToThrow;
		return new GenericTypedObject(object);
	}
	public static void addDefaultPackage(String name) {
		packages.get().add(name+".");
	}
}
