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
package org.idempiere.process;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.function.Supplier;
import java.util.logging.Level;

import org.adempiere.base.IProcessFactory;
import org.adempiere.base.MappedByNameFactory;
import org.adempiere.base.annotation.Process;
import org.compiere.process.ProcessCall;
import org.compiere.util.CLogger;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.annotations.Component;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassInfo;
import io.github.classgraph.ScanResult;

/**
 * @author hengsin
 *
 */
@Component(name = "org.idempiere.process.MappedProcessFactory", 
	immediate = true, 
	service = {IProcessFactory.class, IMappedProcessFactory.class}, 
	property = {"service.ranking:Integer=1"})
public class MappedProcessFactory extends MappedByNameFactory<ProcessCall> implements IProcessFactory, IMappedProcessFactory {

	private static final CLogger s_log = CLogger.getCLogger(MappedProcessFactory.class);
	
	/**
	 * default constructor
	 */
	public MappedProcessFactory() {
	}

	@Override
	public ProcessCall newProcessInstance(String className) {
		return newInstance(className);				
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
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Process.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();	
		        try {
			        @SuppressWarnings("unchecked")
					Class<? extends ProcessCall> clazz = (Class<? extends ProcessCall>) classInfo.loadClass();
			        Constructor<? extends ProcessCall> constructor = clazz.getConstructor();
			        ProcessCallSupplier supplier = new ProcessCallSupplier(constructor);
			        AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(Process.class);
			        String alternateName = null;
			        if (annotationInfo != null)
			        	alternateName = (String) annotationInfo.getParameterValues().getValue("name");
			        
			        addMapping(className, supplier);
			        if (alternateName != null)
			        	addMapping(alternateName, supplier);
		        } catch (Exception e) {
		        	if (s_log.isLoggable(Level.INFO))
		        		s_log.log(Level.INFO, e.getMessage(), e);
		        }
		    }
		}
	}
	
	private static final class ProcessCallSupplier implements Supplier<ProcessCall> {
		
		private Constructor<? extends ProcessCall> constructor;

		private ProcessCallSupplier(Constructor<? extends ProcessCall> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public ProcessCall get() {
			if (constructor != null) {
				try {
					return constructor.newInstance();
				} catch (InstantiationException | IllegalAccessException | IllegalArgumentException
						| InvocationTargetException e) {
					s_log.log(Level.WARNING, e.getMessage(), e);
					constructor = null;
				}
			}
			return null;
		}		
	}
}
