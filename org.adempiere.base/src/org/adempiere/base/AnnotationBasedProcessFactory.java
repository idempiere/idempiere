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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base;

import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;

import org.adempiere.base.annotation.Process;
import org.compiere.process.ProcessCall;
import org.compiere.util.CLogger;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.ComponentContext;
import org.osgi.service.component.annotations.Activate;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassGraph.ScanResultProcessor;
import io.github.classgraph.ClassInfo;

/**
 * Scan, discover and register process classes.
 * Process class will be registered using class name. You can use the optional 
 * {@link Process} annotation to register a process class with an additional name (for e.g
 * to replace a core process class).
 * @author hengsin
 *
 */
public abstract class AnnotationBasedProcessFactory extends AnnotationBasedFactory implements IProcessFactory
{
	/**
	 * Name to class cache
	 */
	private final Map<String,String> classCache = new HashMap<>();
	
	private final Map<String, Constructor<?>[]> constructorCache = new ConcurrentHashMap<>();

	private BundleContext bundleContext = null;
	
	private final static CLogger s_log = CLogger.getCLogger(AnnotationBasedProcessFactory.class);

	/**
	 * Subclasses must override this method in order to provide packages to 
	 * scan, discover and register process classes
	 * @return array of packages to be accepted during class scanning
	 * @see ClassGraph#acceptPackagesNonRecursive(String...)
	 */
	protected abstract String[] getPackages();

	@Activate
	public void activate(ComponentContext context) throws ClassNotFoundException {
		long start = System.currentTimeMillis();
		bundleContext = context.getBundleContext();
		ClassLoader classLoader = bundleContext.getBundle().adapt(BundleWiring.class).getClassLoader();

		ClassGraph graph = new ClassGraph()
				.enableAnnotationInfo()
				.overrideClassLoaders(classLoader)
				.disableNestedJarScanning()
				.disableModuleScanning();

		// narrow search to a list of packages
		String[] packages = getPackages();
		graph.acceptPackagesNonRecursive(packages);

		ScanResultProcessor scanResultProcessor = scanResult -> {
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Process.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();		        
		        AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(Process.class);
		        String alternateName = null;
		        if (annotationInfo != null)
		        	alternateName = (String) annotationInfo.getParameterValues().getValue("name");
		        
		        classCache.put(className, className);
		        if (alternateName != null)
		        	classCache.put(alternateName, className);
		    }
			long end = System.currentTimeMillis();
			s_log.info(() -> this.getClass().getSimpleName() + " loaded " + classCache.size() + " classes in "
						+ ((end-start)/1000f) + "s");
			signalScanCompletion(true);
		};

		graph.scanAsync(getExecutorService(), getMaxThreads(), scanResultProcessor, getScanFailureHandler());
	}

	@SuppressWarnings("unchecked")
	@Override
	public ProcessCall newProcessInstance(String className) {
		blockWhileScanning();
		ProcessCall pc = null;
		String realClassName = classCache.get(className);
		if (realClassName != null) {
			Constructor<?>[] constructors = constructorCache.get(realClassName);
			if (constructors == null) {
				Class<? extends ProcessCall> clazz = null;
				try {
					ClassLoader classLoader = bundleContext.getBundle().adapt(BundleWiring.class).getClassLoader();
					clazz = (Class<? extends ProcessCall>) classLoader.loadClass(realClassName);
					Constructor<? extends ProcessCall> constructor = clazz.getDeclaredConstructor();
					if (constructor != null) {
						constructors = new Constructor[] {constructor};
						constructorCache.put(realClassName, constructors);
					}
				} catch (Exception e) {
					s_log.log(Level.WARNING, e.getMessage(), e);
				}
				if (constructors == null)
					constructorCache.put(realClassName, new Constructor[0]);
			}
			if (constructors != null && constructors.length == 1) {
				try {
					pc = (ProcessCall) constructors[0].newInstance();
				} catch (Exception e) {
					s_log.log(Level.WARNING, e.getMessage(), e);
					constructorCache.put(realClassName, new Constructor[0]);
				}
			}
						
		}
		return pc;
	}

}