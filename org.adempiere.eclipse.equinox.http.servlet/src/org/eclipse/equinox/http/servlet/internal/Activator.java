/*******************************************************************************
 * Copyright (c) 2005, 2007 Cognos Incorporated, IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     Cognos Incorporated - initial API and implementation
 *     IBM Corporation - bug fixes and enhancements
 *******************************************************************************/

package org.eclipse.equinox.http.servlet.internal;

import java.util.*;
import org.eclipse.equinox.http.servlet.ExtendedHttpService;
import org.osgi.framework.*;
import org.osgi.service.http.HttpService;

public class Activator implements BundleActivator {

	private static final String DEFAULT_SERVICE_DESCRIPTION = "Equinox Servlet Bridge"; //$NON-NLS-1$
	private static final String DEFAULT_SERVICE_VENDOR = "Eclipse.org"; //$NON-NLS-1$
	private static final String[] HTTP_SERVICES_CLASSES = new String[] {HttpService.class.getName(), ExtendedHttpService.class.getName()};

	private static BundleContext context;
	private static ServiceRegistration<?> serviceRegistration;

	public void start(BundleContext bundleContext) throws Exception {
		context = bundleContext;
		serviceRegistration = startHttpServiceProxy(bundleContext);		
	}

	public void stop(BundleContext bundleContext) throws Exception {
		stopHttpServiceProxy(bundleContext);
		context = null;
	}

	private static synchronized ServiceRegistration<?> startHttpServiceProxy(BundleContext bundleContext) {
		HttpServiceProxyFactory factory = new HttpServiceProxyFactory();
		
		Dictionary<String, String> serviceProperties = new Hashtable<String, String>(2);
		if (serviceProperties.get(Constants.SERVICE_VENDOR) == null)
			serviceProperties.put(Constants.SERVICE_VENDOR, DEFAULT_SERVICE_VENDOR);

		if (serviceProperties.get(Constants.SERVICE_DESCRIPTION) == null)
			serviceProperties.put(Constants.SERVICE_DESCRIPTION, DEFAULT_SERVICE_DESCRIPTION);

		return context.registerService(HTTP_SERVICES_CLASSES, factory, serviceProperties);
	}
	
	private static synchronized void stopHttpServiceProxy(BundleContext bundleContext) {
		serviceRegistration.unregister();
	}

	static synchronized void addProxyServlet(ProxyServlet proxyServlet) {
		HttpServiceProxyFactory.registerServletDelegate(proxyServlet.getHttpContext(), proxyServlet);
	}
//
	static synchronized void removeProxyServlet(ProxyServlet proxyServlet) {
		HttpServiceProxyFactory.unregisterServletDelegate(proxyServlet);
	}
}
