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
package org.adempiere.eclipse.equinox.http.servlet;

import java.io.IOException;
import java.util.logging.Level;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
import org.compiere.model.MSSOPrincipalConfig;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.osgi.service.http.HttpContext;

//This class wraps the servlet object registered in the HttpService.registerServlet call, to manage the context classloader when handleRequests are being asked.
public class ServletRegistration extends Registration {

	/** Logger */
	protected static CLogger	log	= CLogger.getCLogger(ServletRegistration.class);
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
	/**
	 * @param req
	 * @param resp
	 * @throws IOException
	 * @throws ServletException
	 */
	public void service(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		ClassLoader original = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(registeredContextClassLoader);
			boolean isSSOEnable  = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO_OSGI_CONSOLE, false);
			MSSOPrincipalConfig config = isSSOEnable ? MSSOPrincipalConfig.getDefaultSSOPrincipalConfig(0) : null;
			ISSOPrincipalService ssoPrincipal = config != null ? SSOUtils.getSSOPrincipalService(config) : null;
			if (isSSOEnable && ssoPrincipal != null)
			{
				HttpSession session = req.getSession(false);
				Object token = (session != null && SSOUtils.isTokenValidForProvider(session, config.getSSO_PrincipalConfig_UU()))
						? session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN)
						: null;
				if (checkSSOAuthorization(ssoPrincipal, token))
				{
					servlet.service(req, resp);
					if (req.getPathInfo().endsWith("logout"))
					{
						SSOUtils.clearSSOSessionToken(req.getSession(false));
						resp.sendRedirect("osgi/system/console/bundles");
					}
				}
				else
				{
					SSOUtils.clearSSOSessionToken(req.getSession(false));
				}
			}
			else if (httpContext.handleSecurity(req, resp))
			{
				servlet.service(req, resp);
			}
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
	
	private boolean checkSSOAuthorization(ISSOPrincipalService ssoPrincipal, Object token)
	{
		if (ssoPrincipal == null || token == null)
			return false;
		try
		{
			String username = ssoPrincipal.getUserName(token);
			return validateUser(username, null, true);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "SSOAuthorizationChekError", e);
		}
		return false;
	}
	
	private boolean validateUser(String name, String password, boolean isSSO)
	{
		MUser user = MUser.get(Env.getCtx(), name, password, isSSO);
		if (user == null)
		{
			log.warning ("User not found: '" + name);
			return false;
		}
		if (!user.isAdministrator() && !user.hasURLFormAccess("/osgi/system/console"))
		{
			log.warning ("User doesn't have access to /osgi/system/console = " + name);
			return false;
		}
		if (log.isLoggable(Level.INFO)) log.info ("Name=" + name);
		return Boolean.TRUE;
	}

}
