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
package org.idempiere.model;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiFunction;
import java.util.function.Supplier;
import java.util.logging.Level;

import org.adempiere.base.IModelFactory;
import org.adempiere.base.Model;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.annotations.Component;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassInfo;
import io.github.classgraph.ClassInfoList;
import io.github.classgraph.ScanResult;

/**
 * @author hengsin
 *
 */
@Component(name = "org.idempiere.model.MappedModelFactory", 
	immediate = true, 
	service = {IModelFactory.class, IMappedModelFactory.class}, 
	property = {"service.ranking:Integer=1"})
public class MappedModelFactory implements IModelFactory, IMappedModelFactory {

	private final ConcurrentHashMap<String, Supplier<Class<?>>> classMap = new ConcurrentHashMap<>();
	private final ConcurrentHashMap<String, BiFunction<Integer, String, ? extends PO>> recordIdMap = new ConcurrentHashMap<>();
	private final ConcurrentHashMap<String, BiFunction<ResultSet, String, ? extends PO>> resultSetMap = new ConcurrentHashMap<>();
	
	private static final CLogger s_log = CLogger.getCLogger(MappedModelFactory.class);
	
	/**
	 * default constructor
	 */
	public MappedModelFactory() {
	}

	@Override
	public Class<?> getClass(String tableName) {
		var supplier = classMap.get(tableName);
		return supplier != null ? supplier.get() : null;
	}

	@Override
	public PO getPO(String tableName, int Record_ID, String trxName) {
		var function = recordIdMap.get(tableName);
		return function != null ? function.apply(Record_ID, trxName) : null;
	}

	@Override
	public PO getPO(String tableName, ResultSet rs, String trxName) {
		var function = resultSetMap.get(tableName);
		return function != null ? function.apply(rs, trxName) : null;
	}

	@Override
	public void addMapping(String tableName, Supplier<Class<?>> classSupplier, BiFunction<Integer, String, ? extends PO> recordIdFunction, 
			BiFunction<ResultSet, String, ? extends PO> resultSetFunction) {
		classMap.put(tableName, classSupplier);
		recordIdMap.put(tableName, recordIdFunction);
		resultSetMap.put(tableName, resultSetFunction);
	}
	
	@Override
	public void removeMapping(String tableName) {
		classMap.remove(tableName);
		recordIdMap.remove(tableName);
		resultSetMap.remove(tableName);
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
		
		try (ScanResult scanResult = graph.scan())
		{

		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Model.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();
		        AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(Model.class);
		        String tableName = (String) annotationInfo.getParameterValues().getValue("table");

		        // find subclass (if any)
		        ClassInfoList subclasses = classInfo.getSubclasses().directOnly();
		        while(!subclasses.isEmpty()) {
		        	className = subclasses.get(0).getName();
		        	subclasses = subclasses.get(0).getSubclasses().directOnly();
		        }
		        
		        try {
			        final Class<?> clazz = classLoader.loadClass(className);
			        Supplier<Class<?>> classSupplier = () -> { return clazz; };
			        Constructor<?> idConstructor = clazz.getDeclaredConstructor(new Class[]{Properties.class, int.class, String.class});
			        RecordIdFunction recordIdFunction = new RecordIdFunction(idConstructor);
			        Constructor<?> rsConstructor = clazz.getDeclaredConstructor(new Class[]{Properties.class, ResultSet.class, String.class});
			        ResultSetFunction resultSetFunction = new ResultSetFunction(rsConstructor);			        
			        addMapping(tableName, classSupplier, recordIdFunction, resultSetFunction);
		        } catch (Exception e) {
		        	if (s_log.isLoggable(Level.INFO))
		        		s_log.log(Level.INFO, e.getMessage(), e);
		        }
		    }
		}
	}
	
	private static final class RecordIdFunction implements BiFunction<Integer, String, PO> {
		private Constructor<?> constructor;

		private RecordIdFunction(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public PO apply(Integer id, String trxName) {
			if (constructor != null) {
				try {
					return (PO) constructor.newInstance(Env.getCtx(), id, trxName);
				} catch (InstantiationException | IllegalAccessException | IllegalArgumentException
						| InvocationTargetException e) {
					constructor = null;
					throw new RuntimeException(e);
				}
			}
			return null;
		}		
	}
	
	private static final class ResultSetFunction implements BiFunction<ResultSet, String, PO> {
		private Constructor<?> constructor;
		
		private ResultSetFunction(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public PO apply(ResultSet rs, String trxName) {
			if (constructor != null) {
				try {
					return (PO)constructor.newInstance(new Object[] {Env.getCtx(), rs, trxName});
				} catch (InstantiationException | IllegalAccessException | IllegalArgumentException
						| InvocationTargetException e) {
					constructor = null;
					throw new RuntimeException(e);
				}
			}
			return null;
		}
		
	}
}
