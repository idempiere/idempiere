/*******************************************************************************
 * Copyright (c) 2005, 2010 Cognos Incorporated, IBM Corporation and others.
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
import javax.servlet.*;
import org.eclipse.equinox.http.servlet.ExtendedHttpService;
import org.osgi.framework.Bundle;
import org.osgi.service.http.*;

public class HttpServiceImpl implements HttpService, ExtendedHttpService {

	private Bundle bundle; //The bundle associated with this instance of http service

	private ProxyServlet proxy; //The proxy that does the dispatching of the incoming requests

	private Set aliases = new HashSet(); //Aliases registered against this particular instance of the service
	private Set filters = new HashSet(); //Filters registered against this particular instance of the service

	private boolean shutdown = false; // We prevent use of this instance if HttpServiceFactory.ungetService has called unregisterAliases.

	public HttpServiceImpl(Bundle bundle, ProxyServlet proxy) {
		this.bundle = bundle;
		this.proxy = proxy;
	}

	//Clean up method
	synchronized void shutdown() {
		for (Iterator it = aliases.iterator(); it.hasNext();) {
			String alias = (String) it.next();
			proxy.unregister(alias, false);
		}
		aliases.clear();

		for (Iterator it = filters.iterator(); it.hasNext();) {
			Filter filter = (Filter) it.next();
			proxy.unregisterFilter(filter, false);
		}
		filters.clear();
		shutdown = true;
	}

	private void checkShutdown() {
		if (shutdown)
			throw new IllegalStateException("Service instance is already shutdown"); //$NON-NLS-1$
	}

	/**
	 * @see HttpService#registerServlet(String, Servlet, Dictionary, HttpContext)
	 */
	public synchronized void registerServlet(String alias, Servlet servlet, Dictionary initparams, HttpContext context) throws ServletException, NamespaceException {
		checkShutdown();
		if (context == null) {
			context = createDefaultHttpContext();
		}
		proxy.registerServlet(alias, servlet, initparams, context);
		aliases.add(alias);
	}

	/**
	 * @see HttpService#registerResources(String, String, HttpContext)
	 */
	public synchronized void registerResources(String alias, String name, HttpContext context) throws NamespaceException {
		checkShutdown();
		if (context == null) {
			context = createDefaultHttpContext();
		}
		proxy.registerResources(alias, name, context);
		aliases.add(alias);
	}

	/**
	 * @see HttpService#unregister(String)
	 */
	public synchronized void unregister(String alias) {
		checkShutdown();
		if (aliases.remove(alias)) {
			proxy.unregister(alias, true);
		} else {
			throw new IllegalArgumentException("Alias not found: " + alias); //$NON-NLS-1$
		}
	}

	/**
	 * @see HttpService#createDefaultHttpContext()
	 */
	public synchronized HttpContext createDefaultHttpContext() {
		checkShutdown();
		return new DefaultHttpContext(bundle);
	}

	public void registerFilter(String alias, Filter filter, Dictionary initparams, HttpContext context) throws ServletException {
		checkShutdown();
		if (context == null) {
			context = createDefaultHttpContext();
		}
		proxy.registerFilter(alias, filter, initparams, context);
		filters.add(filter);
	}

	public void unregisterFilter(Filter filter) {
		checkShutdown();
		if (filters.remove(filter)) {
			proxy.unregisterFilter(filter, true);
		} else {
			throw new IllegalArgumentException("Filter not found."); //$NON-NLS-1$
		}
	}
}
