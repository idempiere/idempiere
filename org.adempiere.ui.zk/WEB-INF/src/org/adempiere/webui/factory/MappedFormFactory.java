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
 * - matheus.marcelino                								   *
 **********************************************************************/

package org.adempiere.webui.factory;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.function.Supplier;
import java.util.logging.Level;

/**
 *
 * @author matheus.marcelino
 *
 */
import org.adempiere.base.MappedByNameFactory;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.IFormController;
import org.compiere.util.CLogger;
import org.idempiere.ui.zk.annotation.Form;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.annotations.Component;

import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassInfo;
import io.github.classgraph.ScanResult;

@Component(name = "org.adempiere.webui.factory.MappedFormFactory",
immediate = true,
service = {IFormFactory.class, IMappedFormFactory.class},
property = {"service.ranking:Integer=1"})
public class MappedFormFactory extends MappedByNameFactory<ADForm> implements IFormFactory, IMappedFormFactory {

	private final static CLogger s_log = CLogger.getCLogger(MappedFormFactory.class);
	
	public MappedFormFactory() {
	}

	@Override
	public ADForm newFormInstance(String formName) {
		return newInstance(formName);
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
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(Form.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();	
		        try {
					Class<?> clazz = (Class<?>) classInfo.loadClass();
			        Constructor<?> constructor = clazz.getConstructor();
			        FormSupplier supplier = new FormSupplier(constructor);
			        AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(Form.class);
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

	private static final class FormSupplier implements Supplier<ADForm> {
		
		private Constructor<?> constructor;

		private FormSupplier(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public ADForm get() {
			ADForm form = null;
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
			} catch (InstantiationException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException e) {
				s_log.log(Level.WARNING, e.getMessage(), e);
			}
			return form;
		}		
	}
}
