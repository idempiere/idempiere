/*******************************************************************************
 * Copyright (c) 2010 Angelo Zerr and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     Angelo Zerr <angelo.zerr@gmail.com> - give the capability to use resources (JSP, HTML, Servlet...) 
 *     from the Bridge webapp with HTTP Filter.
 *******************************************************************************/
package org.eclipse.equinox.servletbridge;

import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * {@link BridgeServlet} which implements HTTP {@link Filter} to declare "BridgeServlet" as an HTTP Filter (see >=2.3 Servlet spec): 
 * 
 *  <pre>
 *   <filter id="bridge">
 *     <filter-name>equinoxbridgeservlet</filter-name>
 *     <filter-class>org.eclipse.equinox.servletbridge.BridgeFilter</filter-class>
 *   </filter>
 *   ...
 *	<filter-mapping>
		<filter-name>equinoxbridgeservlet</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
 *  </pre>
 *
 */
public class BridgeFilter extends BridgeServlet implements Filter {

	private static final long serialVersionUID = 1309373924501049438L;

	private ServletConfigAdaptor servletConfig;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.servletConfig = new ServletConfigAdaptor(filterConfig);
		super.init();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		// Call process class with FilterChain.
		super.process(req, resp, chain);
	}

	public ServletConfig getServletConfig() {
		return servletConfig;
	}

	/**
	 * 
	 * Class which adapt {@link FilterConfig} to a {@link ServletConfig}.
	 *
	 */
	private static class ServletConfigAdaptor implements ServletConfig {

		private FilterConfig filterConfig;

		public ServletConfigAdaptor(FilterConfig filterConfig) {
			this.filterConfig = filterConfig;
		}

		public String getInitParameter(String arg0) {
			return filterConfig.getInitParameter(arg0);
		}

		public Enumeration getInitParameterNames() {
			return filterConfig.getInitParameterNames();
		}

		public ServletContext getServletContext() {
			return filterConfig.getServletContext();
		}

		public String getServletName() {
			return filterConfig.getFilterName();
		}

	}
}
