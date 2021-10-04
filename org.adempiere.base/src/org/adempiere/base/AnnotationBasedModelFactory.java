/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.ComponentContext;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassInfo;
import io.github.classgraph.ClassInfoList;
import io.github.classgraph.ScanResult;

/**
 * Translates table names into model classes having the {@link Model} annotation. Relies on
 * {@link DefaultModelFactory} for everything else.
 * This factory is designed to have a service rank higher than {@link DefaultModelFactory}, as class
 * discovery using SPI is preferred over reflection-based methods.
 * @author Saulo Gil
 * @author Heng Sin
 */
@Component(immediate = true, service = IModelFactory.class, property = {"service.ranking:Integer=0"})
public class AnnotationBasedModelFactory extends AbstractModelFactory implements IModelFactory
{
	/**
	 * Table name to class cache
	 */
	private Map<String,Class<?>> classCache = new HashMap<>();

	private final static CLogger s_log = CLogger.getCLogger(AnnotationBasedModelFactory.class);

	/**
	 * Packages to scan for Core X* classes
	 */
	private final static String[] CORE_PACKAGES = new String[] {
		"org.compiere.model",  "compiere.model", "adempiere.model", "org.adempiere.model",
		"org.compiere.wf", "org.compiere.print", "org.compiere.impexp",
		"org.eevolution.model"
	};
	
	/**
	 * Extension point. Subclasses might override this method in order to have faster
	 * model class scanning.
	 * @return array of packages to be accepted during class scanning
	 * @see ClassGraph#acceptPackagesNonRecursive(String...)
	 */
	protected String[] getPackages() {
		return new String[]{};
	}

	/**
	 * Extension point. Provide a list of patterns to match against class names.
	 * @return array of strings containing patterns
	 * @see ClassGraph#acceptClasses(String...)
	 */
	protected String[] getAcceptClassesPatterns() {
		String[] patterns = new String[] {"*.X_*","*.M*"};
		return patterns;
	}
	
	@Activate
	public void activate(ComponentContext context) throws ClassNotFoundException {
		long start = System.currentTimeMillis();
		ClassLoader classLoader = context.getBundleContext().getBundle().adapt(BundleWiring.class).getClassLoader();

		ClassGraph graph = new ClassGraph()
				.enableAnnotationInfo()
				.overrideClassLoaders(classLoader)
				.disableNestedJarScanning()
				.disableModuleScanning();

		// narrow search to a list of packages
		String[] packages = null;
		if(isAtCore())
			packages = CORE_PACKAGES;
		else
			packages = getPackages();

		//acceptClasses has no effect when acceptPackagesNonRecursive is use
		if (packages != null && packages.length > 0)
		{
			graph.acceptPackagesNonRecursive(packages);
		}
		else
		{
			// narrow search to class names matching a set of patterns
			String[] acceptClasses = getAcceptClassesPatterns();
			if(acceptClasses!=null && acceptClasses.length > 0)
				graph.acceptClasses(acceptClasses);
		}

		try (ScanResult scanResult = graph.scan())
		{

		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Model.class)) {
		        String className = classInfo.getName();
		        AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(Model.class);
		        String tableName = (String) annotationInfo.getParameterValues().getValue("table");

		        Class<?> existing = classCache.get(tableName);

		        // try to detect M classes only if we found an X class
		        if(existing == null && className.substring(className.lastIndexOf(".")).startsWith(".X")) {
			        ClassInfoList subclasses = classInfo.getSubclasses().directOnly();
			        while(!subclasses.isEmpty()) {
			        	className = subclasses.get(0).getName();
			        	subclasses = subclasses.get(0).getSubclasses().directOnly();
			        }
		        }
		        
		        if(existing==null) {
		        	classCache.put(tableName, classLoader.loadClass(className));
		        } else if (className.substring(className.lastIndexOf(".")).startsWith(".M")) {
		        	if(existing.getSimpleName().startsWith("X_")) {
		        		classCache.put(tableName, classLoader.loadClass(className));
		        	} else {
		        		Class<?> found = classLoader.loadClass(className);
			        	// replace existing entries only if found class has a lower hierarchy
			        	if(existing.isAssignableFrom(found))
			        		classCache.put(tableName, classLoader.loadClass(className));
		        	}
		        }
		    }
		}
		long end = System.currentTimeMillis();
		if (s_log.isLoggable(Level.INFO))
			s_log.info(this.getClass().getSimpleName() + " loaded "+classCache.size() +" classes in "
					+((end-start)/1000f) + "s");
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Class<?> getClass(String tableName) {
		return classCache.get(tableName);
	}

	/**
	 * Tells whether we're executing code from a subclass of {@link AnnotationBasedModelFactory}.
	 * @return
	 */
	private boolean isAtCore() {
		return getClass().equals(AnnotationBasedModelFactory.class);
	}

}