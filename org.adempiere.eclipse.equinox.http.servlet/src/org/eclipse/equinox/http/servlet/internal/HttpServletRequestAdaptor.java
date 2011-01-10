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
 *     Angelo Zerr <angelo.zerr@gmail.com> - give the capability to use resources (JSP, HTML, Servlet...) 
 *     from the Bridge webapp with HTTP Filter.     
 *******************************************************************************/
package org.eclipse.equinox.http.servlet.internal;

import javax.servlet.*;
import javax.servlet.http.*;
import org.osgi.service.http.HttpContext;

public class HttpServletRequestAdaptor extends HttpServletRequestWrapper {

	private String alias;
	private Servlet servlet;
	private boolean isRequestDispatcherInclude;
	private boolean calledByFilter;

	static final String INCLUDE_REQUEST_URI_ATTRIBUTE = "javax.servlet.include.request_uri"; //$NON-NLS-1$
	static final String INCLUDE_CONTEXT_PATH_ATTRIBUTE = "javax.servlet.include.context_path"; //$NON-NLS-1$
	static final String INCLUDE_SERVLET_PATH_ATTRIBUTE = "javax.servlet.include.servlet_path"; //$NON-NLS-1$
	static final String INCLUDE_PATH_INFO_ATTRIBUTE = "javax.servlet.include.path_info"; //$NON-NLS-1$

	public HttpServletRequestAdaptor(HttpServletRequest req, String alias, Servlet servlet, FilterChain filterChain) {
		super(req);
		this.alias = alias;
		this.servlet = servlet;
		isRequestDispatcherInclude = req.getAttribute(HttpServletRequestAdaptor.INCLUDE_REQUEST_URI_ATTRIBUTE) != null;
		this.calledByFilter = (filterChain != null);
	}

	public String getAuthType() {
		String authType = (String) super.getAttribute(HttpContext.AUTHENTICATION_TYPE);
		if (authType != null)
			return authType;

		return super.getAuthType();
	}

	public String getRemoteUser() {
		String remoteUser = (String) super.getAttribute(HttpContext.REMOTE_USER);
		if (remoteUser != null)
			return remoteUser;

		return super.getRemoteUser();
	}

	public String getPathInfo() {
		String pathInfo = getPathInfo(super.getPathInfo(), super.getContextPath(), super.getRequestURI(), this.calledByFilter);
		if (isRequestDispatcherInclude)
			return pathInfo;

		if (alias.equals("/")) { //$NON-NLS-1$
			return pathInfo;
		}
		pathInfo = pathInfo.substring(alias.length());
		if (pathInfo.length() == 0)
			return null;

		return pathInfo;
	}

	public String getServletPath() {
		if (isRequestDispatcherInclude)
			return super.getServletPath();

		if (alias.equals("/")) { //$NON-NLS-1$
			return ""; //$NON-NLS-1$
		}
		return alias;
	}

	public String getContextPath() {
		if (isRequestDispatcherInclude)
			return super.getContextPath();
		if (!calledByFilter)
			// Not called with HTTP Filter, servlet case.
			return super.getContextPath() + super.getServletPath();
		// HTTP Filter case.
		return super.getContextPath();
	}

	public Object getAttribute(String attributeName) {
		if (isRequestDispatcherInclude) {
			if (attributeName.equals(HttpServletRequestAdaptor.INCLUDE_CONTEXT_PATH_ATTRIBUTE)) {
				String contextPath = (String) super.getAttribute(HttpServletRequestAdaptor.INCLUDE_CONTEXT_PATH_ATTRIBUTE);
				if (contextPath == null || contextPath.equals("/")) //$NON-NLS-1$
					contextPath = ""; //$NON-NLS-1$

				String servletPath = (String) super.getAttribute(HttpServletRequestAdaptor.INCLUDE_SERVLET_PATH_ATTRIBUTE);
				if (servletPath == null || servletPath.equals("/")) //$NON-NLS-1$
					servletPath = ""; //$NON-NLS-1$

				return contextPath + servletPath;
			} else if (attributeName.equals(HttpServletRequestAdaptor.INCLUDE_SERVLET_PATH_ATTRIBUTE)) {
				if (alias.equals("/")) { //$NON-NLS-1$
					return ""; //$NON-NLS-1$
				}
				return alias;
			} else if (attributeName.equals(HttpServletRequestAdaptor.INCLUDE_PATH_INFO_ATTRIBUTE)) {
				String pathInfo = (String) super.getAttribute(HttpServletRequestAdaptor.INCLUDE_PATH_INFO_ATTRIBUTE);
				if (alias.equals("/")) { //$NON-NLS-1$
					return pathInfo;
				}

				pathInfo = pathInfo.substring(alias.length());
				if (pathInfo.length() == 0)
					return null;

				return pathInfo;
			}
		}

		return super.getAttribute(attributeName);
	}

	public RequestDispatcher getRequestDispatcher(String arg0) {
		return new RequestDispatcherAdaptor(super.getRequestDispatcher(super.getServletPath() + arg0));
	}

	public static String getDispatchPathInfo(HttpServletRequest req, FilterChain filterChain) {
		if (req.getAttribute(INCLUDE_REQUEST_URI_ATTRIBUTE) != null)
			return (String) req.getAttribute(INCLUDE_PATH_INFO_ATTRIBUTE);
		return getPathInfo(req.getPathInfo(), req.getContextPath(), req.getRequestURI(), filterChain);
	}

	/**
	 * Returns the path info pathInfo if not null otherwise compute it (in Filter case) by using contextPath + requestURI.
	 * 
	 * @param pathInfo the path info coming from the request.getPathInfo().
	 * @param contextPath the context path coming from the request.getContextPath().
	 * @param requestURI the request URI coming from the request.getRequestURI().
	 * @param filterChain the filter chain or null if this method is not called with Filter.
	 * @return the path info pathInfo if not null otherwise compute it (in Filter case) by using contextPath + requestURI.
	 */
	private static String getPathInfo(String pathInfo, String contextPath, String requestURI, FilterChain filterChain) {
		return getPathInfo(pathInfo, contextPath, requestURI, filterChain != null);
	}

	/**
	 * Returns the path info pathInfo if not null otherwise compute it (in Filter case) by using contextPath + requestURI.
	 * 
	 * @param pathInfo the path info coming from the request.getPathInfo().
	 * @param contextPath the context path coming from the request.getContextPath().
	 * @param requestURI the request URI coming from the request.getRequestURI().
	 * @param calledByFilter true if this method is called with Filter and false otherwise. 
	 * @return the path info pathInfo if not null otherwise compute it (in Filter case) by using contextPath + requestURI.
	 */
	private static String getPathInfo(String pathInfo, String contextPath, String requestURI, boolean calledByFilter) {
		if (pathInfo != null) {
			return pathInfo;
		}
		if (!calledByFilter) {
			// Not called with HTTP Filter, servlet case.
			return null;
		}

		// HTTP Filter case, pathInfo is null, compute it by using contextPath and requestURI
		return requestURI.substring(contextPath.length(), requestURI.length());
	}

	public static String getDispatchServletPath(HttpServletRequest req) {
		if (req.getAttribute(INCLUDE_REQUEST_URI_ATTRIBUTE) != null) {
			String servletPath = (String) req.getAttribute(INCLUDE_SERVLET_PATH_ATTRIBUTE);
			return (servletPath == null) ? "" : servletPath; //$NON-NLS-1$
		}
		return req.getServletPath();
	}

	public HttpSession getSession() {
		HttpSession session = super.getSession();
		if (session != null)
			return new HttpSessionAdaptor(session, servlet);

		return null;
	}

	public HttpSession getSession(boolean create) {
		HttpSession session = super.getSession(create);
		if (session != null)
			return new HttpSessionAdaptor(session, servlet);

		return null;
	}

}
