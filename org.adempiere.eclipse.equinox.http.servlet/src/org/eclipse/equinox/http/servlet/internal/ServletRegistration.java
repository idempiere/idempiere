/*******************************************************************************
 * Copyright (c) 2005-2007 Cognos Incorporated, IBM Corporation and others
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

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.osgi.service.http.HttpContext;

//This class wraps the servlet object registered in the HttpService.registerServlet call, to manage the context classloader when handleRequests are being asked.
public class ServletRegistration extends Registration {

	private Servlet servlet; //The actual servlet object registered against the http service. All requests will eventually be delegated to it.
	private HttpContext httpContext; //The context used during the registration of the servlet
	private ClassLoader registeredContextClassLoader;

	public ServletRegistration(Servlet servlet, HttpContext context) {
		this.servlet = servlet;
		this.httpContext = context;
		registeredContextClassLoader = Thread.currentThread().getContextClassLoader();
	}

	public void destroy() {
		ClassLoader original = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(registeredContextClassLoader);
			super.destroy();
			servlet.destroy();
		} finally {
			Thread.currentThread().setContextClassLoader(original);
		}
	}

	//Delegate the init call to the actual servlet
	public void init(ServletConfig servletConfig) throws ServletException {
		ClassLoader original = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(registeredContextClassLoader);
			servlet.init(servletConfig);
		} finally {
			Thread.currentThread().setContextClassLoader(original);
		}
	}

	//Delegate the handling of the request to the actual servlet
	public void service(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		ClassLoader original = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(registeredContextClassLoader);
			if (httpContext.handleSecurity(req, resp))
				servlet.service(req, resp);
		} finally {
			Thread.currentThread().setContextClassLoader(original);
		}
	}

	public Servlet getServlet() {
		return servlet;
	}

	public HttpContext getHttpContext() {
		return httpContext;
	}
}
