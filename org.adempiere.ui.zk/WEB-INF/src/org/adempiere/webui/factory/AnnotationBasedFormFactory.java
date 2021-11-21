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
package org.adempiere.webui.factory;

import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;

import org.adempiere.base.AnnotationBasedFactory;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.IFormController;
import org.compiere.util.CLogger;
import org.compiere.util.Util;
import org.idempiere.ui.zk.annotation.Form;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.ComponentContext;
import org.osgi.service.component.annotations.Activate;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassGraph.ScanResultProcessor;
import io.github.classgraph.ClassInfo;

/**
 * Scan, discover and regiser classes with {@link Form} annotation.
 * @author hengsin
 *
 */
public abstract class AnnotationBasedFormFactory extends AnnotationBasedFactory implements IFormFactory {

	private final Map<String, String> classCache = new HashMap<>();
	
	private final Map<String, Constructor<?>[]> constructorCache = new ConcurrentHashMap<>();

	private BundleContext bundleContext = null;
	
	private static final CLogger s_log = CLogger.getCLogger(AnnotationBasedFormFactory.class);
	
	public AnnotationBasedFormFactory() {
	}

	@Override
	public ADForm newFormInstance(String formName) {
		blockWhileScanning();
		ADForm form = null;
		String realClassName = classCache.get(formName);
		if (realClassName != null) {
			Constructor<?> constructor = getConstructor(formName);
			try {
				Object formObject = constructor.newInstance();
				if (formObject != null) {
					if (formObject instanceof ADForm) {
						form = (ADForm)formObject;
					} else if (formObject instanceof IFormController) {
						IFormController controller = (IFormController) formObject;
						form = controller.getForm();
						form.setICustomForm(controller);
					}
				}
			} catch (Exception e) {
				s_log.log(Level.WARNING, e.getMessage(), e);
			}
			if (form == null)
				constructorCache.put(realClassName, new Constructor<?>[0]);			
		}
		return form;
	}

	/**
	 * 
	 * @param formName
	 * @return class default constructor
	 */
	public Constructor<?> getConstructor(String formName) {
		String className = classCache.get(formName);
		Constructor<?>[] constructors = null;
		if (className != null) {
			constructors = constructorCache.get(className);
			if (constructors == null) {
				ClassLoader classLoader = bundleContext.getBundle().adapt(BundleWiring.class).getClassLoader();
				try {
					Class<?> clazz = classLoader.loadClass(className);
					Constructor<?> constructor = clazz.getDeclaredConstructor();				
					if (constructor != null) {
						constructors = new Constructor<?>[] {constructor};
					} else {
						constructors = new Constructor<?>[0];
					}
					constructorCache.put(className, constructors);
				} catch (Exception e) {
					s_log.log(Level.WARNING, e.getMessage(), e);
					constructors = new Constructor<?>[0];
					constructorCache.put(className, constructors);
				}
			}
		}
		if (constructors != null && constructors.length == 1) {
			return constructors[0];
		} else {
			return null;
		}
	}
	
	protected abstract String[] getPackages();
	
	@Activate
	public void activate(ComponentContext context) throws ClassNotFoundException {
		long start = System.currentTimeMillis();
		bundleContext  = context.getBundleContext();
		ClassLoader classLoader = bundleContext.getBundle().adapt(BundleWiring.class).getClassLoader();

		ClassGraph graph = new ClassGraph()
				.enableAnnotationInfo()
				.overrideClassLoaders(classLoader)
				.disableNestedJarScanning()
				.disableModuleScanning()
				.acceptPackagesNonRecursive(getPackages());

		ScanResultProcessor scanResultProcessor = scanResult -> {
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Form.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();
		        AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(Form.class);
		        String alternateName = (String) annotationInfo.getParameterValues().getValue("name");

		        classCache.put(className, className);
		        if (!Util.isEmpty(alternateName, true))
		        	classCache.put(alternateName, className);		        	
		    }
			long end = System.currentTimeMillis();
			s_log.info(() -> this.getClass().getSimpleName() + " loaded " + classCache.size() + " classes in "
						+ ((end-start)/1000f) + "s");
			signalScanCompletion(true);
		};

		graph.scanAsync(getExecutorService(), getMaxThreads(), scanResultProcessor, getScanFailureHandler());
	}

}
