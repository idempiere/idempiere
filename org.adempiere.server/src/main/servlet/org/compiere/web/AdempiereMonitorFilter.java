/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.web;

import java.io.IOException;
import java.util.logging.Level;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
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

/**
 * 	Adempiere Monitor Filter.
 * 	Application Server independent check of username/password
 * 	
 *  @author Jorg Janke
 *  @version $Id: AdempiereMonitorFilter.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
 *  @author Michael Judd BF [ 2736817 ] - remove deprecated BASE64Encoder classes
 */
public class AdempiereMonitorFilter implements Filter
{
	/**
	 * 	AdempiereMonitorFilter
	 */
	public AdempiereMonitorFilter ()
	{
		super ();
	}	//	AdempiereMonitorFilter

	/** Logger */
	protected CLogger				log				= CLogger.getCLogger(getClass());


	/**
	 * 	Init
	 *	@param config configuration
	 *	@throws ServletException
	 */
	public void init (FilterConfig config)
		throws ServletException
	{
		log.info ("");
	}	//	Init

	/**
	 * 	Filter
	 *	@param request request
	 *	@param response response
	 *	@param chain chain
	 *	@throws IOException
	 *	@throws ServletException
	 */
	public void doFilter (ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException
	{
		String errorPage = "/error.html";
		try
		{
			if (!(request instanceof HttpServletRequest && response instanceof HttpServletResponse))
			{
				request.getRequestDispatcher(errorPage).forward(request, response);
				return;
			}

			boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO_IDEMPIERE_MONITOR, false);
			HttpServletRequest req = (HttpServletRequest)request;
			HttpServletResponse resp = (HttpServletResponse)response;
			boolean isRedirectToLoginOnError = false;
			ISSOPrincipalService m_SSOPrincipal = null;
			if (isSSOEnable) {
				try {

					MSSOPrincipalConfig config = MSSOPrincipalConfig.getDefaultSSOPrincipalConfig(0);
					m_SSOPrincipal = config != null ? SSOUtils.getSSOPrincipalService(config) : null;

					if (m_SSOPrincipal != null && config != null) {
						String configUU = config.getSSO_PrincipalConfig_UU();
						if (m_SSOPrincipal.hasAuthenticationCode(req, resp)) {
							// Clear any prior SSO token before exchanging the callback code
							HttpSession session = req.getSession();
							SSOUtils.clearSSOSessionToken(session);
							// Use authentication code get get token
							String currentUri = req.getRequestURL().toString();
							m_SSOPrincipal.getAuthenticationToken(req, resp, SSOUtils.SSO_MODE_MONITOR);
							if (!resp.isCommitted()) {
								if (session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN) != null)
									session.setAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, configUU);
								resp.sendRedirect(currentUri);
							}
							return;
						} else if (!SSOUtils.isTokenValidForProvider(req.getSession(false), configUU)
								|| !m_SSOPrincipal.isAuthenticated(req, resp)) {
							HttpSession session = req.getSession(false);
							if (session != null && session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN) != null) {
								m_SSOPrincipal.removePrincipalFromSession(req);
								SSOUtils.clearSSOSessionToken(session);
							}
							// Redirect to SSO sing in page for authentication
							m_SSOPrincipal.redirectForAuthentication(req, resp, SSOUtils.SSO_MODE_MONITOR);
							return;
						}
						// validate the user
						if (checkSSOAuthorization(m_SSOPrincipal, req.getSession().getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN)))
						{
							chain.doFilter(request, response);
							return;
						}
					}
					SSOUtils.clearSSOSessionToken(req.getSession(false));
				} catch (Throwable exc) {
					log.log(Level.SEVERE, "Exception while authenticating: ", exc);
					if (m_SSOPrincipal != null)
						m_SSOPrincipal.removePrincipalFromSession(req);
					SSOUtils.clearSSOSessionToken(req.getSession(false));
					if (isRedirectToLoginOnError) {
						resp.sendRedirect("idempiereMonitor");
					} else {
						resp.setStatus(500);
						response.setContentType("text/html");
						response.getWriter().append(SSOUtils.getCreateErrorResponce(exc.getLocalizedMessage()));
					}
					return;
				}
			}

			if (m_SSOPrincipal == null || !isSSOEnable)
			{
				// Check for authenticated session
				HttpSession session = req.getSession(false);
				String authenticatedUser = null;
				
				if (session != null) {
					authenticatedUser = (String) session.getAttribute(LoginServlet.AUTHENTICATED_USER);
				}
				
				// Check if this is a login or logout request (allow through)
				String requestURI = req.getRequestURI();
				String contextPath = req.getContextPath();
				if (requestURI.equals(contextPath + "/idempiereMonitor/login") || 
					requestURI.equals(contextPath + "/idempiereMonitor/logout") || 
					requestURI.equals(contextPath + "/idempiereMonitor/login.jsp")) {
					chain.doFilter(request, response);
					return;
				}
				
				if (authenticatedUser != null) {
					// User is authenticated, allow access
					chain.doFilter(request, response);
				} else {
					// Not authenticated, redirect to login page
					String returnUrl = req.getRequestURI();
					if (req.getQueryString() != null) {
						returnUrl += "?" + req.getQueryString();
					}
					if ("/idempiereMonitor".equals(returnUrl) || "/idempiereMonitor/".equals(returnUrl))
						resp.sendRedirect(req.getContextPath() + "/idempiereMonitor/login.jsp");
					else
					resp.sendRedirect(req.getContextPath() + "/idempiereMonitor/login.jsp?returnUrl=" + 
						java.net.URLEncoder.encode(returnUrl, "UTF-8"));
				}
			}
			return;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "filter", e);
		}
		request.getRequestDispatcher(errorPage).forward(request, response);
	}	//	doFilter

	private boolean checkSSOAuthorization(ISSOPrincipalService principalService, Object token)
	{
		if (token == null)
			return false;
		try
		{
			String username = principalService.getUserName(token);
			return validateUser(username, null, true);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "check", e);
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
		if (!user.isAdministrator() && !user.hasURLFormAccess("/idempiereMonitor"))
		{
			log.warning ("User doesn't have access to /idempiereMonitor = " + name);
			return false;
		}
		if (log.isLoggable(Level.INFO)) log.info ("Name=" + name);
		return true;
	}
	
	/**
	 * 	Destroy
	 */
	public void destroy ()
	{
		log.info ("");
	}	//	destroy

}	//	AdempiereMonitorFilter
