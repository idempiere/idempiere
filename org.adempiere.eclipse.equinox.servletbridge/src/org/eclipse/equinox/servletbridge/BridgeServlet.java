/*******************************************************************************
 * Copyright (c) 2005, 2008 Cognos Incorporated, IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     Cognos Incorporated - initial API and implementation
 *     IBM Corporation - bug fixes and enhancements
 *     Angelo Zerr <angelo.zerr@gmail.com> - give the capability to use resources (JSP, HTML, Servlet...)
 *     from the Bridge webapp with HTTP Filter.
 *******************************************************************************/
package org.eclipse.equinox.servletbridge;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import org.eclipse.equinox.http.servlet.HttpServiceServlet;

/**
 * The BridgeServlet provides a means to bridge the servlet and OSGi
 * runtimes. This class has 3 main responsibilities:
 * 1) Control the lifecycle of the associated FrameworkLauncher in line with its own lifecycle
 * 2) Provide a servlet "hook" that allows all servlet requests to be delegated to the registered servlet
 * 3) Provide means to manually control the framework lifecycle
 */
public class BridgeServlet extends HttpServlet {

	static final String INCLUDE_REQUEST_URI_ATTRIBUTE = "javax.servlet.include.request_uri"; //$NON-NLS-1$
	static final String INCLUDE_SERVLET_PATH_ATTRIBUTE = "javax.servlet.include.servlet_path"; //$NON-NLS-1$
	static final String INCLUDE_PATH_INFO_ATTRIBUTE = "javax.servlet.include.path_info"; //$NON-NLS-1$

	private static final long serialVersionUID = 2825667412474494674L;
	private HttpServlet delegate;
	// true if current HttpServlet is an HTTP Filter and false otherwise.
	private boolean delegateIsFilter;

	/**
	 * init() is called by the Servlet Container and used to instantiate the frameworkLauncher which MUST be an instance of FrameworkLauncher.
	 * After instantiating the framework init, deploy, and start are called.
	 */
	public void init() throws ServletException {
		super.init();
		initDelegate();
	}

	/**
	 * destroy() is called by the Servlet Container and used to first stop and then destroy the framework.
	 */
	public void destroy() {
		try {
			initDelegate();
		} catch (ServletException e) {
		}
		super.destroy();
	}

	/**
	 * service is called by the Servlet Container and will first determine if the request is a
	 * framework control and will otherwise try to delegate to the registered servlet delegate
	 *
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp, null);
	}

	/**
	 * Search from OSGi registry the servlet, ressources... to executed according the path of the HTTP request. If no service are founded :
	 * <ul>
	 *   <li>if {@link FilterChain} is not null : {@link FilterChain#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse)} is called.</li>
	 *   <li>otherwise throw 404 error.</li>
	 * </ul>
	 *
	 * @param req
	 * @param resp
	 * @param chain
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void process(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws ServletException, IOException {
		String pathInfo = getDispatchPathInfo(req, chain);
		// Check if this is being handled by an extension mapping
		if (pathInfo == null && isExtensionMapping(req.getServletPath()))
			req = new ExtensionMappingRequest(req);

		if (req.getAttribute(INCLUDE_REQUEST_URI_ATTRIBUTE) == null) {
		} else {
			String includePathInfo = (String) req.getAttribute(INCLUDE_PATH_INFO_ATTRIBUTE);
			// Check if this is being handled by an extension mapping
			if (includePathInfo == null || includePathInfo.length() == 0) {
				String servletPath = (String) req.getAttribute(INCLUDE_SERVLET_PATH_ATTRIBUTE);
				if (isExtensionMapping(servletPath))
					req = new IncludedExtensionMappingRequest(req);
			}
		}

		HttpServlet servletReference = delegate;
		if (servletReference == null) {
			// Cannot find the HttpServletService from OSGi registry services :
			if (chain != null) {
				// Delegate the HTTP request to the Web server container.
				chain.doFilter(req, resp);

			} else {
				// Send HTTP 4040 Error.
				resp.sendError(HttpServletResponse.SC_NOT_FOUND, "BridgeServlet: " + req.getRequestURI()); //$NON-NLS-1$
			}
		} else {
			if (delegateIsFilter && chain != null) {
				((Filter) servletReference).doFilter(req, resp, chain);
			} else {
				servletReference.service(req, resp);
			}
		}
	}

	private boolean isExtensionMapping(String servletPath) {
		if (servletPath == null)
			return false;

		String lastSegment = servletPath;
		int lastSlash = servletPath.lastIndexOf('/');
		if (lastSlash != -1)
			lastSegment = servletPath.substring(lastSlash + 1);

		return lastSegment.indexOf('.') != -1;
	}

	private void initDelegate() throws ServletException {
		delegate = new HttpServiceServlet();
		delegate.init(getServletConfig());
		delegateIsFilter = (delegate instanceof Filter);
	}

	static class ExtensionMappingRequest extends HttpServletRequestWrapper {

		public ExtensionMappingRequest(HttpServletRequest req) {
			super(req);
		}

		public String getPathInfo() {
			return super.getServletPath();
		}

		public String getServletPath() {
			return ""; //$NON-NLS-1$
		}
	}

	static class IncludedExtensionMappingRequest extends HttpServletRequestWrapper {

		public IncludedExtensionMappingRequest(HttpServletRequest req) {
			super(req);
		}

		public Object getAttribute(String attributeName) {
			if (attributeName.equals(INCLUDE_SERVLET_PATH_ATTRIBUTE)) {
				return ""; //$NON-NLS-1$
			} else if (attributeName.equals(INCLUDE_PATH_INFO_ATTRIBUTE)) {
				String servletPath = (String) super.getAttribute(INCLUDE_SERVLET_PATH_ATTRIBUTE);
				return servletPath;
			}
			return super.getAttribute(attributeName);
		}
	}

	/**
	 * Returns the path info of the HTTP request.
	 *
	 * @param req
	 * @param chain
	 * @return the path info of the HTTP request.
	 */
	private static String getDispatchPathInfo(HttpServletRequest req, FilterChain chain) {
		//		if (req.getAttribute(INCLUDE_REQUEST_URI_ATTRIBUTE) != null)
		//			return (String) req.getAttribute(INCLUDE_PATH_INFO_ATTRIBUTE);

		String pathInfo = req.getPathInfo();
		if (pathInfo != null) {
			return pathInfo;
		}
		if (chain == null) {
			return null;
		}

		// HTTP Filter case, pathInfo is null, compute it by using contextPath and requestURI
		String contextPath = req.getContextPath();
		String requestURI = req.getRequestURI();
		return requestURI.substring(contextPath.length(), requestURI.length());
	}

}