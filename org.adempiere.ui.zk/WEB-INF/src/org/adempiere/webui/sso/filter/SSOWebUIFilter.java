/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.sso.filter;

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

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;

/**
 * Request filter class for the SSO authentication
 * 
 * @author Logilite Technologies
 */
public class SSOWebUIFilter implements Filter
{
	/** Logger */
	protected static CLogger		log				= CLogger.getCLogger(SSOWebUIFilter.class);
	// TODO as this is static, will not work on multi tenant environment
	private static ISSOPrincipalService	m_SSOPrincipal	= null;

	/**
	 * SSOWebUIFilter
	 */
	public SSOWebUIFilter()
	{
		super();
	} // SSOWebUIFilter
	
	/**
	 * Filter
	 * 
	 * @param  request          request
	 * @param  response         response
	 * @param  chain            chain
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false);
		if (isSSOEnable && request instanceof HttpServletRequest)
		{
			HttpServletRequest httpRequest = (HttpServletRequest) request;
			HttpServletResponse httpResponse = (HttpServletResponse) response;

			// Ignore the resource request	
			if (SSOUtils.isResourceRequest(httpRequest, true))
			{
				chain.doFilter(request, response);
				return;
			}

			boolean isRedirectToLoginOnError = false;
			boolean isAdminResRequest = false;
			if (httpRequest.getSession().getAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN) != null)
				isAdminResRequest = (boolean) httpRequest.getSession().getAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN);
			isAdminResRequest = isAdminResRequest || httpRequest.getServletPath().toLowerCase().startsWith("/admin");
			
			// work as default log in
			if (httpRequest.getServletPath().toLowerCase().startsWith("/index") || httpRequest.getServletPath().equalsIgnoreCase("/"))
				isAdminResRequest = false;
			
			httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN, isAdminResRequest);
			// redirect to admin zul file
			if(isAdminResRequest && httpRequest.getServletPath().toLowerCase().endsWith("admin"))
			 {
				httpResponse.sendRedirect("/webui/admin.zul");
				return;
			 }
			
			try
			{
				if (m_SSOPrincipal == null)
				{
					m_SSOPrincipal = SSOUtils.getSSOPrincipalService();
				}

				if (m_SSOPrincipal != null && !isAdminResRequest)
				{
					if (m_SSOPrincipal.hasAuthenticationCode(httpRequest, httpResponse))
					{
						// Use authentication code get get token
						m_SSOPrincipal.getAuthenticationToken(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);
					}
					else if (!m_SSOPrincipal.isAuthenticated(httpRequest, httpResponse))
					{
						// Redirect to SSO sing in page for authentication
						m_SSOPrincipal.redirectForAuthentication(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);
						return;
					}
				}
			}
			catch (Throwable exc)
			{
				log.log(Level.SEVERE, "Exception while authenticating: ",exc);
				if (m_SSOPrincipal != null)
					m_SSOPrincipal.removePrincipalFromSession(httpRequest);
				if(isRedirectToLoginOnError)
				{
					httpResponse.sendRedirect("webui/index.zul");
				}
				else
				{
					httpResponse.setStatus(500);
                    response.setContentType("text/html");
                    response.getWriter().append(SSOUtils.getCreateErrorResponce(exc.getLocalizedMessage()));
				}
				return;
			}
		}
		else if (request instanceof HttpServletRequest && ((HttpServletRequest) request).getServletPath().startsWith("/admin"))
		{
			((HttpServletResponse) response).setStatus(404);
			return;
		}
		chain.doFilter(request, response);
		return;
	} // doFilter

	@Override
	public void destroy()
	{

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException
	{
	}
	
	public static ISSOPrincipalService getSSOPrincipal()
	{
		return m_SSOPrincipal;
	}
} // AdempiereMonitorFilter
