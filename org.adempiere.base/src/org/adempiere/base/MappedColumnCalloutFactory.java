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
import java.util.function.Supplier;
import java.util.logging.Level;

import org.adempiere.base.annotation.Callout;
import org.adempiere.base.annotation.Callouts;
import org.compiere.util.CLogger;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.annotations.Component;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.AnnotationInfoList;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassInfo;
import io.github.classgraph.ScanResult;

/**
 * 
 * @author hengsin
 *
 */
@Component(name = "org.adempiere.base.MappedColumnCalloutFactory", 
	immediate = true, 
	service = {IColumnCalloutFactory.class, IMappedColumnCalloutFactory.class}, 
	property = {"service.ranking:Integer=1"})
public class MappedColumnCalloutFactory implements IColumnCalloutFactory, IMappedColumnCalloutFactory {

	private final static CLogger s_log = CLogger.getCLogger(MappedColumnCalloutFactory.class);
	
	private final HashMap<String, List<Supplier<IColumnCallout>>> calloutMap = new HashMap<>();
	
	/**
	 * default constructor
	 */
	public MappedColumnCalloutFactory() {
	}

	@Override
	public IColumnCallout[] getColumnCallouts(String tableName, String columnName) {
		List<IColumnCallout> calloutList = new ArrayList<IColumnCallout>();
		StringBuilder key = new StringBuilder();
		key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());
		StringBuilder key1 = new StringBuilder();
		key1.append("*|").append(columnName.toLowerCase());
		StringBuilder key2 = new StringBuilder();
		key2.append(tableName.toLowerCase()).append("|*");
		synchronized (calloutMap) {
			List<Supplier<IColumnCallout>> list = calloutMap.get(key.toString());
			if (list != null && list.size() > 0) {
				list.forEach(e -> calloutList.add(e.get()));
			}
			list = calloutMap.get(key1.toString());
			if (list != null && list.size() > 0) {
				list.forEach(e -> calloutList.add(e.get()));
			}
			list = calloutMap.get(key2.toString());
			if (list != null && list.size() > 0) {
				list.forEach(e -> calloutList.add(e.get()));
			}
		}
		return calloutList.isEmpty() ? null : calloutList.toArray(new IColumnCallout[0]);
	}

	@Override
	public void addMapping(String tableName, String columnName, Supplier<IColumnCallout> supplier) {
		StringBuilder key = new StringBuilder();
		key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());
		synchronized (calloutMap) {
			List<Supplier<IColumnCallout>> list = calloutMap.get(key.toString());
			if (list == null) {
				list = new ArrayList<Supplier<IColumnCallout>>();
				calloutMap.put(key.toString(), list);
			}
			list.add(supplier);
		}		
	}
	
	@Override
	public void removeMapping(String tableName, String columnName, Supplier<IColumnCallout> supplier) {
		StringBuilder key = new StringBuilder();
		key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());
		synchronized (calloutMap) {
			List<Supplier<IColumnCallout>> list = calloutMap.get(key.toString());
			if (list != null) {
				list.remove(supplier);
			}
		}		
	}

	@Override
	public void scan(BundleContext context, String... packages) {
		ClassLoader classLoader = context.getBundle().adapt(BundleWiring.class).getClassLoader();

		ClassGraph graph = new ClassGraph()
				.enableAnnotationInfo()
				.overrideClassLoaders(classLoader)
				.disableNestedJarScanning()
				.disableModuleScanning()
				.acceptPackagesNonRecursive(packages);

		try (ScanResult scanResult = graph.scan()) {
			List<String> processed = new ArrayList<String>();
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Callouts.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();		        
		        AnnotationInfoList annotationInfos = classInfo.getAnnotationInfoRepeatable(Callout.class);
		        for(AnnotationInfo annotationInfo : annotationInfos) {
			        processAnnotation(className, annotationInfo, classLoader);
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
			    processAnnotation(className, annotationInfo, classLoader);
		    }
		}
	}
	
	private void processAnnotation(String className, AnnotationInfo annotationInfo, ClassLoader classLoader) {
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
        
        try {
        	Class<?> clazz = classLoader.loadClass(className);
        	Constructor<?> constructor = clazz.getDeclaredConstructor();
        	CalloutSupplier supplier = new CalloutSupplier(constructor);
        	if (matchAllTables) {
        		for(Object columnName : columnNames) {
        			addMapping("*", (String)columnName, supplier);
        		}
        	} else {
        		for(Object tableName : tableNames) {
        			if (matchAllColumns) {
        				addMapping((String)tableName, "*", supplier);
        			} else {
        				for(Object columnName : columnNames) {
        					addMapping((String)tableName, (String)columnName, supplier);
        				}
        			}
        		}
        	}
        		
        } catch (Exception e) {
        	if (s_log.isLoggable(Level.INFO))
        		s_log.log(Level.INFO, e.getMessage(), e);
        }
    
	}
	
	private static class CalloutSupplier implements Supplier<IColumnCallout> {

		private Constructor<?> constructor;

		private CalloutSupplier(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public IColumnCallout get() {
			IColumnCallout callout = null;
			if (constructor != null) {
				try {
					callout = (IColumnCallout) constructor.newInstance();
				} catch (Exception e) {
					constructor = null;
					s_log.log(Level.WARNING, e.getMessage(), e);
				}
			}
			return callout;
		}
		
	}
}
