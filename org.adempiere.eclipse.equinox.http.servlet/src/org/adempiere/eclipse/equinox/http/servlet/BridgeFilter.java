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
package org.adempiere.eclipse.equinox.http.servlet;

import java.io.IOException;
import java.util.Enumeration;
import java.util.logging.Level;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;

/**
 * 
 * {@link BridgeServlet} which implements HTTP {@link Filter} to declare "BridgeServlet" as an HTTP Filter (see &gt;=2.3 Servlet spec): 
 * 
 *  <pre>{@code
 *   <filter id="bridge">
 *     <filter-name>equinoxbridgeservlet</filter-name>
 *     <filter-class>org.eclipse.equinox.servletbridge.BridgeFilter</filter-class>
 *   </filter>
 *   ...
 *	<filter-mapping>
		<filter-name>equinoxbridgeservlet</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
 *  }</pre>
 *
 */
public class BridgeFilter extends BridgeServlet implements Filter {

	private static final long serialVersionUID = 1309373924501049438L;

	/** Logger */
	protected static CLogger		log					= CLogger.getCLogger(BridgeFilter.class);
	private ServletConfigAdaptor	servletConfig;
	
	public void init(FilterConfig filterConfig) throws ServletException {
		this.servletConfig = new ServletConfigAdaptor(filterConfig);
		super.init();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		// Ignore the resource request	
		if (SSOUtils.isResourceRequest(req, false))
		{
			super.process(req, resp, chain);
			return;
		}

		boolean isRedirectToLoginOnError = false;
		boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO_OSGI_CONSOLE, false);
		if (isSSOEnable) {
			ISSOPrincipalService m_SSOPrincipal = null;
			try
			{
				m_SSOPrincipal = SSOUtils.getSSOPrincipalService();

				if (m_SSOPrincipal != null) {
					if (m_SSOPrincipal.hasAuthenticationCode(req, resp)) {
						// Use authentication code to get token
						String currentUri = req.getRequestURL().toString();
						m_SSOPrincipal.getAuthenticationToken(req, resp, SSOUtils.SSO_MODE_OSGI);
						if (!resp.isCommitted())
							resp.sendRedirect(currentUri);
					} else if (!m_SSOPrincipal.isAuthenticated(req, resp)) {
						// Redirect to SSO sing in page for authentication
						m_SSOPrincipal.redirectForAuthentication(req, resp, SSOUtils.SSO_MODE_OSGI);
						return;
					}
				}
			} catch (Throwable exc) {
				log.log(Level.SEVERE, "Exception while authenticating: ", exc);
				if (m_SSOPrincipal != null)
					m_SSOPrincipal.removePrincipalFromSession(req);
				if (isRedirectToLoginOnError) {
					resp.sendRedirect("osgi/system/console/bundles");
				} else {
					resp.setStatus(500);
					response.setContentType("text/html");
					response.getWriter().append(SSOUtils.getCreateErrorResponce(exc.getLocalizedMessage()));
				}
				return;
			}
		}
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

		public Enumeration<String> getInitParameterNames() {
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
