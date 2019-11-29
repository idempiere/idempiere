/**********************************************************************
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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.adempiere.eclipse.equinox.http.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.osgi.service.http.HttpContext;

//This class wraps the filter object registered in the HttpService.registerFilter call, to manage the context classloader when handleRequests are being asked.
public class FilterRegistration extends Registration implements Comparable<FilterRegistration> {

	private static long nextSequenceNumber = 1L;

	private final Filter filter; //The actual filter object registered against the http service. All filter requests will eventually be delegated to it.
	private final HttpContext httpContext; //The context used during the registration of the filter
	private final ClassLoader registeredContextClassLoader;
	private final String prefix;
	private final String suffix;
	private final int priority;
	private final long sequenceNumber;

	public FilterRegistration(Filter filter, HttpContext context, String alias, int priority) {
		this.filter = filter;
		this.httpContext = context;
		registeredContextClassLoader = Thread.currentThread().getContextClassLoader();

		int lastSlash = alias.lastIndexOf('/');
		String lastSegment = alias.substring(alias.lastIndexOf('/') + 1);
		if (lastSegment.startsWith("*.")) { //$NON-NLS-1$
			prefix = alias.substring(0, lastSlash);
			suffix = lastSegment.substring(1);
		} else {
			prefix = alias.equals("/") ? "" : alias; //$NON-NLS-1$//$NON-NLS-2$
			suffix = null;
		}

		this.priority = priority;
		synchronized (FilterRegistration.class) {
			this.sequenceNumber = nextSequenceNumber++;
		}
	}

	public void destroy() {
		ClassLoader original = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(registeredContextClassLoader);
			super.destroy();
			filter.destroy();
		} finally {
			Thread.currentThread().setContextClassLoader(original);
		}
	}

	//Delegate the init call to the actual filter
	public void init(FilterConfig filterConfig) throws ServletException {
		ClassLoader original = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(registeredContextClassLoader);
			filter.init(filterConfig);
		} finally {
			Thread.currentThread().setContextClassLoader(original);
		}
	}

	//Delegate the handling of the request to the actual filter
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
		ClassLoader original = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(registeredContextClassLoader);
			if (httpContext.handleSecurity(request, response))
				filter.doFilter(request, response, chain);
		} finally {
			Thread.currentThread().setContextClassLoader(original);
		}
	}

	public Filter getFilter() {
		return filter;
	}

	public HttpContext getHttpContext() {
		return httpContext;
	}

	public boolean matches(String dispatchPathInfo) {
		if (!dispatchPathInfo.startsWith(prefix))
			return false;

		// perfect match
		if (prefix.length() == dispatchPathInfo.length())
			return suffix == null;

		// check the next character is a path separator
		if (dispatchPathInfo.charAt(prefix.length()) != '/')
			return false;

		// check for an extension match
		if (suffix == null)
			return true;

		return dispatchPathInfo.endsWith(suffix) && dispatchPathInfo.length() > prefix.length() + suffix.length();
	}

	public int compareTo(FilterRegistration otherFilterRegistration) {
		int priorityDifference = priority - otherFilterRegistration.priority;
		if (priorityDifference != 0)
			return -priorityDifference;

		return (sequenceNumber > otherFilterRegistration.sequenceNumber) ? 1 : -1;
	}
}
