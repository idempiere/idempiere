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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
import org.compiere.model.MClient;
import org.compiere.model.MSSOPrincipalConfig;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.Util;

/**
 * Request filter class for the SSO authentication
 * 
 * @author Logilite Technologies
 */
public class SSOWebUIFilter implements Filter
{
	/** Logger */
	protected static CLogger log = CLogger.getCLogger(SSOWebUIFilter.class);

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
	 * @param request
	 *            request
	 * @param response
	 *            response
	 * @param chain
	 *            chain
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		// process tenant login prefix parameter (if available)
		HttpServletRequest httpRequest = null;
		if (request instanceof HttpServletRequest hsr)
		{
			String tenant = hsr.getParameter("tenant");
			if (tenant != null)
			{
				tenant = tenant.trim();
				if (tenant.isEmpty())
					hsr.getSession().removeAttribute("tenant");
				else
					hsr.getSession().setAttribute("tenant", tenant);
			}
			httpRequest = hsr;

		}

		boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false);
		if (isSSOEnable && httpRequest != null && response instanceof HttpServletResponse httpResponse)
		{
			// handle ping request
			String ping = httpRequest.getHeader("X-PING");
			if (!Util.isEmpty(ping, true))
			{
				chain.doFilter(request, response);
				return;
			}

			// Ignore the resource request
			if (SSOUtils.isResourceRequest(httpRequest, true))
			{
				chain.doFilter(request, response);
				return;
			}

			boolean isAdminResRequest = false;
			if (httpRequest.getSession().getAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN) != null)
				isAdminResRequest = (boolean) httpRequest.getSession().getAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN);
			isAdminResRequest = isAdminResRequest || httpRequest.getServletPath().toLowerCase().startsWith("/admin");

			// work as default log in
			if (httpRequest.getServletPath().toLowerCase().startsWith("/index") || httpRequest.getServletPath().equalsIgnoreCase("/"))
				isAdminResRequest = false;

			httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN, isAdminResRequest);
			// redirect to admin zul file
			if (isAdminResRequest && httpRequest.getServletPath().toLowerCase().endsWith("admin"))
			{
				httpResponse.sendRedirect("/webui/admin.zul");
				return;
			}

			String provider = httpRequest.getParameter(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
			boolean providerFromCookie = false;
			if (Util.isEmpty(provider))
			{
				if (httpRequest.getSession().getAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER) != null)
				{
					provider = (String) httpRequest.getSession().getAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
				}
				else
				{
					Cookie[] cookies = httpRequest.getCookies();
					if (cookies != null)
					{
						for (Cookie cookie : cookies)
						{
							if (ISSOPrincipalService.SSO_SELECTED_PROVIDER.equals(cookie.getName()))
							{
								provider = cookie.getValue();
								if (!Util.isEmpty(provider))
								{
									httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
									providerFromCookie = true;
								}
								break;
							}
						}
					}
				}
			}
			else
			{
				// Remove cookie if provider is from request parameter
				Cookie cookie = new Cookie(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
				cookie.setSecure(true);
				cookie.setHttpOnly(true);
				cookie.setMaxAge(0);
				cookie.setPath(httpRequest.getContextPath());
				httpResponse.addCookie(cookie);
				
				httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
			}

			String tenant = (String) httpRequest.getSession().getAttribute("tenant");
			ISSOPrincipalService m_SSOPrincipal = null;
			try
			{
				if (!isAdminResRequest)
				{
					m_SSOPrincipal =  SSOUtils.getSSOPrincipalService(provider, tenant);
					// if cause by invalid cookie, try to get default SSO provider by tenant
					if (m_SSOPrincipal== null && !Util.isEmpty(provider, true) && !Util.isEmpty(tenant, true) && providerFromCookie)
					{
						httpRequest.getSession().removeAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
						MClient client = MClient.getByLoginPrefix(tenant);
						if (client != null)
						{
							var configs = MSSOPrincipalConfig.getSSOPrincipalConfigByClient(client.getAD_Client_ID());
							if (configs != null && configs.size() == 1)
							{
								provider= configs.get(0).getSSO_PrincipalConfig_UU();
								m_SSOPrincipal =  SSOUtils.getSSOPrincipalService(provider, tenant);
								if (m_SSOPrincipal != null)
								{
									httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
								}
							}
						}
					} else if (m_SSOPrincipal != null && Util.isEmpty(provider, true)) 
					{
						// update provider to session if it's not set and can get SSOPrincipalService by tenant login prefix
						MClient client = null;
						if (!Util.isEmpty(tenant, true)) 
						{
							client = MClient.getByLoginPrefix(tenant);
						}
						var configs = MSSOPrincipalConfig.getSSOPrincipalConfigByClient(client != null ? client.getAD_Client_ID() : 0);
						if (configs != null && configs.size() == 1)
						{
							provider= configs.get(0).getSSO_PrincipalConfig_UU();
							httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
						}
					}
				}
			
				if (m_SSOPrincipal != null)
				{
					if (m_SSOPrincipal.hasAuthenticationCode(httpRequest, httpResponse))
					{
						// Use authentication code get get token
						String currentUri = httpRequest.getRequestURL().toString();
						m_SSOPrincipal.getAuthenticationToken(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);

						if (!httpResponse.isCommitted())
						{
							// Redirect to default request URL after authentication and handle query
							// string.
							Object queryString = httpRequest.getSession().getAttribute(ISSOPrincipalService.SSO_QUERY_STRING);
							if (queryString != null && queryString instanceof String && !Util.isEmpty((String) queryString))
								currentUri += "?" + (String) queryString;
							httpRequest.getSession().removeAttribute(ISSOPrincipalService.SSO_QUERY_STRING);
							httpResponse.sendRedirect(currentUri);
						}
					}
					else if (!m_SSOPrincipal.isAuthenticated(httpRequest, httpResponse))
					{
						httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_QUERY_STRING, httpRequest.getQueryString());
						// Redirect to SSO sign in page for authentication
						m_SSOPrincipal.redirectForAuthentication(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);
						httpRequest.getSession().setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
						return;
					}
				}
			}
			catch (Throwable exc)
			{
				log.log(Level.SEVERE, "Exception while authenticating: ", exc);
				if (m_SSOPrincipal != null)
					m_SSOPrincipal.removePrincipalFromSession(httpRequest);
				httpResponse.setStatus(500);
				response.setContentType("text/html");
				response.getWriter().append(SSOUtils.getCreateErrorResponce(exc.getLocalizedMessage()));
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
	public void destroy( )
	{

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException
	{
	}

} // AdempiereMonitorFilter
