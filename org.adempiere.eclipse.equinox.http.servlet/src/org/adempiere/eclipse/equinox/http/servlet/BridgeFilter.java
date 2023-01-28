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

import org.adempiere.base.sso.ISSOPrinciple;
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
	
	private static ISSOPrinciple	m_SSOPrinciple		= null;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.servletConfig = new ServletConfigAdaptor(filterConfig);
		super.init();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		boolean isRedirectToLoginOnError = false;
		boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false);
		if (isSSOEnable) {
			try {
				if (m_SSOPrinciple == null) {
					m_SSOPrinciple = SSOUtils.getSSOPrinciple();
				}

				if (m_SSOPrinciple != null) {
					if (m_SSOPrinciple.hasAuthenticationCode(req, resp)) {
						// Use authentication code to get token
						m_SSOPrinciple.getAuthenticationToken(req, resp, SSOUtils.SSO_MODE_OSGI);
					} else if (!m_SSOPrinciple.isAuthenticated(req, resp)) {
						// Redirect to SSO sing in page for authentication
						m_SSOPrinciple.redirectForAuthentication(req, resp, SSOUtils.SSO_MODE_OSGI);
						return;
					} else if (m_SSOPrinciple.isAccessTokenExpired(req, resp)) {
						// Refresh token after expired
						isRedirectToLoginOnError = true;
						m_SSOPrinciple.refreshToken(req, resp, SSOUtils.SSO_MODE_OSGI);
					}
				}
			} catch (Throwable exc) {
				log.log(Level.SEVERE, "Exception while authenticating: ", exc);
				if (m_SSOPrinciple != null)
					m_SSOPrinciple.removePrincipleFromSession(req);
				if (isRedirectToLoginOnError) {
					resp.sendRedirect("osgi/system/console/bundles");
				} else {
					resp.setStatus(500);
					resp.sendRedirect(SSOUtils.ERROR_API);
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
	
	public static ISSOPrinciple getSSOPrinciple()
	{
		return m_SSOPrinciple;
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
