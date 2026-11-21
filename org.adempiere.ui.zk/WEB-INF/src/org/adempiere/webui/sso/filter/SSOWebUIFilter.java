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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Objects;
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
import javax.servlet.http.HttpSession;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
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
	public static final String TENANT_PREFIX_PARAMETER = "tenant";
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
			String servletPath = hsr.getServletPath();
			String requestURI = hsr.getRequestURI();
			String tenantParam = hsr.getParameter(TENANT_PREFIX_PARAMETER);
			boolean isIndexZulUri = requestURI != null && requestURI.endsWith("index.zul");
			boolean isRootOrIndexPath = isIndexZulUri
					|| "/index.zul".equalsIgnoreCase(servletPath)
					|| "/".equals(servletPath);
			if (isIndexZulUri || (isRootOrIndexPath && tenantParam != null))
			{
				HttpSession session = hsr.getSession();
				String previousTenant = (String) session.getAttribute(TENANT_PREFIX_PARAMETER);
				String newTenant = (tenantParam != null && !tenantParam.trim().isEmpty()) ? tenantParam.trim() : null;
				if (!Objects.equals(previousTenant, newTenant))
				{
					SSOUtils.clearSSOSessionToken(session);
					session.removeAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
					session.removeAttribute(ISSOPrincipalService.SSO_QUERY_STRING);
				}
				if (newTenant == null)
					session.removeAttribute(TENANT_PREFIX_PARAMETER);
				else
					session.setAttribute(TENANT_PREFIX_PARAMETER, newTenant);
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

			// Allow error page without triggering SSO redirect
			if (SSOUtils.ERROR_VALIDATION_URL.equalsIgnoreCase(httpRequest.getServletPath()))
			{
				chain.doFilter(request, response);
				return;
			}

			HttpSession session = httpRequest.getSession();
			boolean isAdminResRequest = false;
			if (session.getAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN) != null)
				isAdminResRequest = (boolean) session.getAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN);
			isAdminResRequest = isAdminResRequest || httpRequest.getServletPath().toLowerCase().startsWith("/admin");

			// work as default log in
			if (httpRequest.getServletPath().toLowerCase().startsWith("/index") || httpRequest.getServletPath().equalsIgnoreCase("/"))
				isAdminResRequest = false;

			session.setAttribute(ISSOPrincipalService.SSO_ADMIN_LOGIN, isAdminResRequest);
			// redirect to admin zul file
			if (isAdminResRequest && httpRequest.getServletPath().toLowerCase().endsWith("admin"))
			{
				httpResponse.sendRedirect("/webui/admin.zul");
				return;
			}

			String provider = httpRequest.getParameter(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
			if (provider != null)
				provider = provider.trim();
			boolean providerFromCookie = false;
			if (Util.isEmpty(provider, true))
			{
				if (session.getAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER) != null)
				{
					provider = (String) session.getAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
					removeProviderCookie(httpRequest, httpResponse, provider);
				}
				else
				{
					// after logout and redirect back from SSO authentication, get the provider uuid from cookie
					Cookie[] cookies = httpRequest.getCookies();
					if (cookies != null)
					{
						for (Cookie cookie : cookies)
						{
							if (ISSOPrincipalService.SSO_SELECTED_PROVIDER.equals(cookie.getName()))
							{
								String cookieVal = cookie.getValue();
								if (!Util.isEmpty(cookieVal, true))
								{
									provider = cookieVal.trim();
									session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
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
				removeProviderCookie(httpRequest, httpResponse, provider);
				Object previousProvider = session.getAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
				Object authenticatedProvider = session.getAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER);
				if (!provider.equals(previousProvider) || !provider.equals(authenticatedProvider))
				{
					SSOUtils.clearSSOSessionToken(session);
				}
				session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
			}

			String tenant = (String) session.getAttribute(TENANT_PREFIX_PARAMETER);
			MSSOPrincipalConfig principalConfig = null;
			ISSOPrincipalService m_SSOPrincipal = null;
			try
			{
				if (!isAdminResRequest)
				{
					principalConfig = SSOUtils.getSSOPrincipalConfig(provider, tenant);
					// if cause by invalid cookie, try to get default SSO provider by tenant
					if (principalConfig == null && !Util.isEmpty(provider, true) && !Util.isEmpty(tenant, true) && providerFromCookie)
					{
						session.removeAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
						principalConfig = SSOUtils.getSSOPrincipalConfig(null, tenant);
						if (principalConfig != null)
						{
							provider = principalConfig.getSSO_PrincipalConfig_UU();
							session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
						}
					}
					else if (principalConfig != null && Util.isEmpty(provider, true))
					{
						// update provider to session if it's not set and can get SSOPrincipalConfig by tenant login prefix
						provider = principalConfig.getSSO_PrincipalConfig_UU();
						session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
					}
					m_SSOPrincipal = SSOUtils.getSSOPrincipalService(principalConfig);
				}
			
				if (m_SSOPrincipal != null && principalConfig != null)
				{
					String configUU = principalConfig.getSSO_PrincipalConfig_UU();
					if (m_SSOPrincipal.hasAuthenticationCode(httpRequest, httpResponse))
					{
						// Clear any prior SSO token before exchanging the callback code
						SSOUtils.clearSSOSessionToken(session);

						// Use authentication code to get token
						String currentUri = httpRequest.getRequestURL().toString();
						m_SSOPrincipal.getAuthenticationToken(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);

						if (!httpResponse.isCommitted())
						{
							if (session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN) != null)
								session.setAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, configUU);

							// Redirect to default request URL after authentication and handle query
							// string.
							Object queryString = session.getAttribute(ISSOPrincipalService.SSO_QUERY_STRING);
							if (queryString != null && queryString instanceof String && !Util.isEmpty((String) queryString))
								currentUri += "?" + (String) queryString;
							session.removeAttribute(ISSOPrincipalService.SSO_QUERY_STRING);
							if (request.getParameter(TENANT_PREFIX_PARAMETER) != null && (queryString == null || !queryString.toString().contains(TENANT_PREFIX_PARAMETER+"=")))
							{
								currentUri += (currentUri.contains("?") ? "&" : "?") + TENANT_PREFIX_PARAMETER + "="
										+ URLEncoder.encode(request.getParameter(TENANT_PREFIX_PARAMETER), StandardCharsets.UTF_8);
							}
							httpResponse.sendRedirect(currentUri);
						}
						return;
					}
					else if (!SSOUtils.isTokenValidForProvider(session, configUU)
							|| !m_SSOPrincipal.isAuthenticated(httpRequest, httpResponse))
					{
						if (session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN) != null)
						{
							m_SSOPrincipal.removePrincipalFromSession(httpRequest);
							SSOUtils.clearSSOSessionToken(session);
						}
						session.setAttribute(ISSOPrincipalService.SSO_QUERY_STRING, httpRequest.getQueryString());
						// Redirect to SSO sign in page for authentication
						m_SSOPrincipal.redirectForAuthentication(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);
						session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, configUU);
						return;
					}
				}
			}
			catch (Throwable exc)
			{
				log.log(Level.SEVERE, "Exception while authenticating: ", exc);
				if (m_SSOPrincipal != null)
					m_SSOPrincipal.removePrincipalFromSession(httpRequest);
				SSOUtils.clearSSOSessionToken(httpRequest.getSession(false));
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

	private void removeProviderCookie(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
			String provider) {
		// Remove cookie if provider is from request parameter
		Cookie cookie = new Cookie(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
		cookie.setSecure(true);
		cookie.setHttpOnly(true);
		cookie.setMaxAge(0);
		cookie.setPath(httpRequest.getContextPath());
		httpResponse.addCookie(cookie);
	}

	@Override
	public void destroy( )
	{

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException
	{
	}

} // AdempiereMonitorFilter
