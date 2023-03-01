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

import org.adempiere.base.sso.ISSOPrinciple;
import org.adempiere.base.sso.SSOUtils;
import org.apache.commons.codec.binary.Base64;
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
		m_authorization = Long.valueOf(System.currentTimeMillis());
	}	//	AdempiereMonitorFilter

	/** Logger */
	protected CLogger				log				= CLogger.getCLogger(getClass());
	/** Authorization ID */
	private static final String		AUTHORIZATION	= "AdempiereAuthorization";
	/** Authorization Marker */
	private Long					m_authorization	= null;

	private static ISSOPrinciple	m_SSOPrinciple	= null;
	
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
		boolean pass = false;
		try
		{
			if (!(request instanceof HttpServletRequest && response instanceof HttpServletResponse))
			{
				request.getRequestDispatcher(errorPage).forward(request, response);
				return;
			}
			boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false);
			HttpServletRequest req = (HttpServletRequest)request;
			HttpServletResponse resp = (HttpServletResponse)response;
			boolean isRedirectToLoginOnError = false;
			if (isSSOEnable) {
				try {
					if (m_SSOPrinciple == null) {
						m_SSOPrinciple = SSOUtils.getSSOPrinciple();
					}

					if (m_SSOPrinciple != null) {
						if (m_SSOPrinciple.hasAuthenticationCode(req, resp)) {
							// Use authentication code get get token
							m_SSOPrinciple.getAuthenticationToken(req, resp, SSOUtils.SSO_MODE_MONITOR);
						} else if (!m_SSOPrinciple.isAuthenticated(req, resp)) {
							// Redirect to SSO sing in page for authentication
							m_SSOPrinciple.redirectForAuthentication(req, resp, SSOUtils.SSO_MODE_MONITOR);
							return;
						} else if (m_SSOPrinciple.isAccessTokenExpired(req, resp)) {
							// Refresh token after expired
							isRedirectToLoginOnError = true;
							m_SSOPrinciple.refreshToken(req, resp, SSOUtils.SSO_MODE_MONITOR);
						}
						// validate the user
						if (checkSSOAuthorization(req.getSession().getAttribute(ISSOPrinciple.SSO_PRINCIPLE_SESSION_NAME)))
						{
							chain.doFilter(request, response);
							return;
						}
					}
					req.getSession().removeAttribute(ISSOPrinciple.SSO_PRINCIPLE_SESSION_NAME);
				} catch (Throwable exc) {
					log.log(Level.SEVERE, "Exception while authenticating: ", exc);
					if (m_SSOPrinciple != null)
						m_SSOPrinciple.removePrincipleFromSession(req);
					if (isRedirectToLoginOnError) {
						resp.sendRedirect("idempiereMonitor");
					} else {
						resp.setStatus(500);
						resp.sendRedirect(SSOUtils.ERROR_API);
					}
					return;
				}
			}

			if (m_SSOPrinciple == null || !isSSOEnable)
			{
				HttpSession session = req.getSession(true);
				// Previously checked
				Long compare = (Long) session.getAttribute(AUTHORIZATION);
				if (compare != null && compare.compareTo(m_authorization) == 0) {
					pass = true;
				} else if (checkAuthorization(req.getHeader("Authorization"))) {
					session.setAttribute(AUTHORIZATION, m_authorization);
					pass = true;
				}
				// --------------------------------------------
				if (pass) {
					chain.doFilter(request, response);
				} else {
					resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
					resp.setHeader("WWW-Authenticate", "BASIC realm=\"Adempiere Server\"");
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

	private boolean checkSSOAuthorization(Object token)
	{
		if (token == null)
			return false;
		try
		{
			String username = m_SSOPrinciple.getUserName(token);
			return validateUser(username, null, true);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "check", e);
		}
		return false;
	}

	/**
	 * 	Check Authorization
	 *	@param authorization authorization
	 *	@return true if authenticated
	 */
	private boolean checkAuthorization (String authorization)
	{
		if (authorization == null)
			return false;
		try
		{
			String userInfo = authorization.substring(6).trim();
			Base64 decoder = new Base64();
			String namePassword = new String (decoder.decode(userInfo.getBytes()));
		//	log.fine("checkAuthorization - Name:Password=" + namePassword);
			int index = namePassword.indexOf(':');
			String name = namePassword.substring(0, index);
			String password = namePassword.substring(index+1);
			return validateUser(name, password, false);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "check", e);
		}
		return false;
	}	//	check

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
