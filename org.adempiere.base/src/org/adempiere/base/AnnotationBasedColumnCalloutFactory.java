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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;

import org.adempiere.base.annotation.Callout;
import org.adempiere.base.annotation.Callouts;
import org.compiere.util.CLogger;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.ComponentContext;
import org.osgi.service.component.annotations.Activate;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.AnnotationInfoList;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassGraph.ScanResultProcessor;
import io.github.classgraph.ClassInfo;

/**
 * 
 * @author hengsin
 *
 */
public abstract class AnnotationBasedColumnCalloutFactory extends AnnotationBasedFactory implements IColumnCalloutFactory {

	private final static CLogger s_log = CLogger.getCLogger(AnnotationBasedColumnCalloutFactory.class);
	
	private BundleContext bundleContext;
	
	private final Map<String, Map<String, List<String>>> tableNameMap = new HashMap<>();
	
	private final Map<String, Constructor<?>[]> constructorCache = new ConcurrentHashMap<>();

			
	public AnnotationBasedColumnCalloutFactory() {
	}

	@Override
	public IColumnCallout[] getColumnCallouts(String tableName, String columnName) {
		blockWhileScanning();
		List<IColumnCallout> callouts = new ArrayList<IColumnCallout>();
		ClassLoader classLoader = bundleContext.getBundle().adapt(BundleWiring.class).getClassLoader();
		Map<String, List<String>> columnNameMap = tableNameMap.get(tableName);
		if (columnNameMap != null) {
			List<String> calloutClassNames = columnNameMap.get(columnName);
			if (calloutClassNames != null) {
				newCalloutInstance(callouts, classLoader, calloutClassNames);
			}
			calloutClassNames = columnNameMap.get("*");
			if (calloutClassNames != null) {
				newCalloutInstance(callouts, classLoader, calloutClassNames);
			}
		}
		
		columnNameMap = tableNameMap.get("*");
		if (columnNameMap != null) {
			List<String> calloutClassNames = columnNameMap.get(columnName);
			if (calloutClassNames != null) {
				newCalloutInstance(callouts, classLoader, calloutClassNames);
			}
			calloutClassNames = columnNameMap.get("*");
			if (calloutClassNames != null) {
				newCalloutInstance(callouts, classLoader, calloutClassNames);
			}
		}
		
		
		return callouts.toArray(new IColumnCallout[0]);
	}

	private void newCalloutInstance(List<IColumnCallout> callouts, ClassLoader classLoader,
			List<String> calloutClassNames) {
		for(String calloutClass : calloutClassNames) {
			Constructor<?>[] constructors = constructorCache.get(calloutClass);
			if (constructors == null) {
				try {
					Class<?> clazz = classLoader.loadClass(calloutClass);
					Constructor<?> constructor = clazz.getDeclaredConstructor();
					IColumnCallout columnCallout = (IColumnCallout) constructor.newInstance();
					callouts.add(columnCallout);
					constructors = new Constructor<?>[] {constructor};
					constructorCache.put(calloutClass, constructors);
				} catch (Exception e) {
					s_log.log(Level.WARNING, e.getMessage(), e);
					constructors = new Constructor<?>[0];
					constructorCache.put(calloutClass, constructors);
				}
			} else if (constructors.length == 1){
				try {
					IColumnCallout columnCallout = (IColumnCallout) constructors[0].newInstance();
					callouts.add(columnCallout);
				} catch (Exception e) {
					s_log.log(Level.WARNING, e.getMessage(), e);
					constructors = new Constructor<?>[0];
					constructorCache.put(calloutClass, constructors);
				}						
			}
		}
	}

	/**
	 * Subclasses must override this method in order to provide packages to 
	 * scan, discover and register {@link IColumnCallout} classes
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
				.disableModuleScanning()
				.acceptPackagesNonRecursive(getPackages());

		ScanResultProcessor scanResultProcessor = scanResult -> {
			List<String> processed = new ArrayList<String>();
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Callouts.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();		        
		        AnnotationInfoList annotationInfos = classInfo.getAnnotationInfoRepeatable(Callout.class);
		        for(AnnotationInfo annotationInfo : annotationInfos) {
			        processAnnotation(className, annotationInfo);
		        }
		        processed.add(className);
		    }
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Callout.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();
		        if (processed.contains(className))
		        	continue;
		        AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(Callout.class);
			    processAnnotation(className, annotationInfo);
		    }
		    signalScanCompletion(true);
			long end = System.currentTimeMillis();
			s_log.info(() -> this.getClass().getSimpleName() + " loaded "+tableNameMap.size() +" classes in "
						+ ((end-start)/1000f) + "s");
		};

		graph.scanAsync(getExecutorService(), getMaxThreads(), scanResultProcessor, getScanFailureHandler());
	}

	private void processAnnotation(String className, AnnotationInfo annotationInfo) {
		//not sure why but sometime ClassGraph return Object[] instead of the expected String[]
		Object[] tableNames = (Object[]) annotationInfo.getParameterValues().getValue("tableName");
		Object[] columnNames = (Object[]) annotationInfo.getParameterValues().getValue("columnName");
		
		boolean matchAllTables = false;
		for(Object tableName : tableNames) {
			if ("*".equals(tableName) ) {
				matchAllTables = true;
				break;
			}
		}
		
		boolean matchAllColumns = false;
		for(Object columnName : columnNames) {
			if ("*".equals(columnName)) {
				matchAllColumns = true;
				break;
			}
		}
		
		//not allow to match everything
		if (matchAllColumns && matchAllTables)
			return;
		
		Map<String, List<String>> columnNameMap = null;
		if (matchAllTables) {
			columnNameMap = tableNameMap.get("*");
			if (columnNameMap == null) {
				columnNameMap = new HashMap<String, List<String>>();
				tableNameMap.put("*", columnNameMap);
			}
			if (matchAllColumns) {
				addCallout(className, columnNameMap);
			} else {
				addCallout(className, columnNames, columnNameMap);
			}
		} else {
			for(Object tableName : tableNames) {
				columnNameMap = tableNameMap.get(tableName);
		    	if (columnNameMap == null) {
		    		columnNameMap = new HashMap<String, List<String>>();
		    		tableNameMap.put((String)tableName, columnNameMap);
		    	}
		    	if (matchAllColumns) {
		    		addCallout(className, columnNameMap);
		    	} else {
		    		addCallout(className, columnNames, columnNameMap);
		    	}
			}
		}
	}

	private void addCallout(String className, Object[] columnNames, Map<String, List<String>> columnNameMap) {
		for (Object columnName : columnNames) {
			List<String> callouts = columnNameMap.get(columnName);
			if (callouts == null ) {
				callouts = new ArrayList<String>();
				columnNameMap.put((String)columnName, callouts);
			}
			callouts.add(className);
		}
	}

	private void addCallout(String className, Map<String, List<String>> columnNameMap) {
		List<String> callouts = columnNameMap.get("*");
		if (callouts == null ) {
			callouts = new ArrayList<String>();
			columnNameMap.put("*", callouts);
		}
		callouts.add(className);
	}
}
