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
 **********************************************************************/
package org.adempiere.base.acct;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;

import org.adempiere.base.AnnotationBasedFactory;
import org.compiere.util.CLogger;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;

import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassInfo;
import io.github.classgraph.ScanResult;

/**
 * Factory that discovers and provides IAcctInfoService implementations.
 * 
 * @author etantg
 */
public final class AcctInfoServiceFactory extends AnnotationBasedFactory {
	
	private static final CLogger log = CLogger.getCLogger(AcctInfoServiceFactory.class);
		
	private static final AcctInfoServiceFactory INSTANCE = new AcctInfoServiceFactory();
	
	private final Map<Class<? extends IAcctInfoService>, IAcctInfoService> serviceMap = new ConcurrentHashMap<>();
	
	private AcctInfoServiceFactory() {}

    public static AcctInfoServiceFactory getInstance() {
        return INSTANCE;
    }
    
    public void scan(BundleContext context, String packageName) {
    	ClassLoader classLoader = context.getBundle().adapt(BundleWiring.class).getClassLoader();
		ClassGraph graph = new ClassGraph()
				.enableClassInfo()
				.enableAnnotationInfo()
				.overrideClassLoaders(classLoader)
				.disableNestedJarScanning()
				.disableModuleScanning()
				.acceptPackagesNonRecursive(packageName);
		try (ScanResult scanResult = graph.scan())
		{
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(AcctInfoService.class.getName())) {
		    	final Class<?> clazz = classLoader.loadClass(classInfo.getName());
		    	AcctInfoService ann = clazz.getAnnotation(AcctInfoService.class);
	            Class<? extends IAcctInfoService> iface = ann.value();
	            IAcctInfoService service = (IAcctInfoService) clazz.getDeclaredConstructor().newInstance();
	            serviceMap.put(iface, service);
		    }	    
		    signalScanCompletion(true);
        } catch (Exception e) {
            log.log(Level.SEVERE, "Error scanning package " + packageName, e);
            signalScanCompletion(false);
        }
    }
    
    @SuppressWarnings("unchecked")
	public <T extends IAcctInfoService> T getService(Class<T> iface) {
        blockWhileScanning();
        return (T) serviceMap.get(iface);
    }
    
}
