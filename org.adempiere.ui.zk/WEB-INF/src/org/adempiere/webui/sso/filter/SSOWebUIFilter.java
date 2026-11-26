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
import java.net.URLDecoder;
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
		boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false);

		// process tenant login prefix parameter (if available)
		HttpServletRequest httpRequest = null;
		boolean pendingTenantClear = false;
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
				if (isSSOEnable
						&& tenantParam == null
						&& previousTenant != null
						&& response instanceof HttpServletResponse)
				{
					pendingTenantClear = true;
				}
				else
				{
					applyTenantChange(session, previousTenant, newTenant);
				}
			}
			httpRequest = hsr;

		}

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

			MSSOPrincipalConfig principalConfig = null;
			ISSOPrincipalService m_SSOPrincipal = null;
			try
			{
				boolean hasPendingAuthCode = false;
				if (pendingTenantClear)
				{
					String previousTenant = (String) session.getAttribute(TENANT_PREFIX_PARAMETER);
					if (previousTenant != null)
					{
						if (!isAdminResRequest && Util.isEmpty(httpRequest.getParameter(ISSOPrincipalService.SSO_SELECTED_PROVIDER), true))
						{
							String sessionProvider = (String) session.getAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
							if (!Util.isEmpty(sessionProvider, true))
							{
								MSSOPrincipalConfig pendingConfig = SSOUtils.getSSOPrincipalConfig(sessionProvider, previousTenant);
								ISSOPrincipalService pendingService = SSOUtils.getSSOPrincipalServiceForConfig(pendingConfig);
								if (pendingService != null)
								{
									m_SSOPrincipal = pendingService;
									hasPendingAuthCode = pendingService.hasAuthenticationCode(httpRequest, httpResponse);
									if (hasPendingAuthCode)
										principalConfig = pendingConfig;
									else
										m_SSOPrincipal = null;
								}
							}
						}
						if (!hasPendingAuthCode)
						{
							applyTenantChange(session, previousTenant, null);
						}
					}
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
					if (!provider.equals(previousProvider) || !SSOUtils.isTokenValidForProvider(session, provider))
					{
						SSOUtils.clearSSOSessionToken(session);
					}
					session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
				}

				String tenant = (String) session.getAttribute(TENANT_PREFIX_PARAMETER);
				if (!isAdminResRequest && !hasPendingAuthCode)
				{
					principalConfig = SSOUtils.getSSOPrincipalConfig(provider, tenant);
					m_SSOPrincipal = SSOUtils.getSSOPrincipalServiceForConfig(principalConfig);
					// if cause by invalid cookie, try to get default SSO provider by tenant
					if (m_SSOPrincipal == null && !Util.isEmpty(provider, true) && !Util.isEmpty(tenant, true) && providerFromCookie)
					{
						session.removeAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
						principalConfig = null;
						MClient client = MClient.getByLoginPrefix(tenant.trim());
						if (client != null)
						{
							var configs = MSSOPrincipalConfig.getSSOPrincipalConfigByClient(client.getAD_Client_ID());
							if (configs != null && configs.size() == 1)
							{
								String fallbackProvider = configs.get(0).getSSO_PrincipalConfig_UU();
								MSSOPrincipalConfig fallbackConfig = SSOUtils.getSSOPrincipalConfig(fallbackProvider, tenant);
								ISSOPrincipalService fallbackService = SSOUtils.getSSOPrincipalServiceForConfig(fallbackConfig);
								if (fallbackService != null)
								{
									principalConfig = fallbackConfig;
									m_SSOPrincipal = fallbackService;
									provider = principalConfig.getSSO_PrincipalConfig_UU();
									session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
								}
							}
						}
					}
					else if (principalConfig != null && m_SSOPrincipal != null && Util.isEmpty(provider, true))
					{
						// update provider to session if it's not set and can get SSOPrincipalConfig by tenant login prefix
						provider = principalConfig.getSSO_PrincipalConfig_UU();
						session.setAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER, provider);
					}
				}
			
				if (m_SSOPrincipal != null && principalConfig != null)
				{
					String configUU = principalConfig.getSSO_PrincipalConfig_UU();
					if (hasPendingAuthCode || m_SSOPrincipal.hasAuthenticationCode(httpRequest, httpResponse))
					{
						// Clear any prior SSO token before exchanging the callback code
						SSOUtils.clearSSOSessionToken(session);

						// Use authentication code to get token
						String currentUri = httpRequest.getRequestURL().toString();
						m_SSOPrincipal.getAuthenticationToken(
								SSOUtils.wrapRequestForTokenBinding(httpRequest, configUU), httpResponse, SSOUtils.SSO_MODE_WEBUI);

						if (!httpResponse.isCommitted())
						{
							// Redirect to default request URL after authentication and handle query
							// string.
							Object queryString = session.getAttribute(ISSOPrincipalService.SSO_QUERY_STRING);
							String savedQuery = queryString instanceof String s && !Util.isEmpty(s) ? s : null;
							session.removeAttribute(ISSOPrincipalService.SSO_QUERY_STRING);
							String redirectTenant = request.getParameter(TENANT_PREFIX_PARAMETER);
							if (Util.isEmpty(redirectTenant, true))
								redirectTenant = tenant;
							String redirectQuery = ensureTenantQueryParameter(savedQuery, redirectTenant);
							if (!Util.isEmpty(redirectQuery))
								currentUri += "?" + redirectQuery;
							httpResponse.sendRedirect(currentUri);
						}
						return;
					}
					else if (!SSOUtils.isTokenValidForProvider(session, configUU)
							|| !m_SSOPrincipal.isAuthenticated(httpRequest, httpResponse))
					{
						if (SSOUtils.getSSOSessionToken(session) != null
								|| session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN) != null)
						{
							try
							{
								m_SSOPrincipal.removePrincipalFromSession(httpRequest);
							}
							finally
							{
								SSOUtils.clearSSOSessionToken(httpRequest.getSession(false));
							}
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
				try
				{
					if (m_SSOPrincipal != null)
						m_SSOPrincipal.removePrincipalFromSession(httpRequest);
				}
				catch (Throwable cleanupExc)
				{
					log.log(Level.WARNING, "Exception while cleaning up SSO principal from session: ", cleanupExc);
				}
				finally
				{
					SSOUtils.clearSSOSessionToken(httpRequest.getSession(false));
				}
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

	private void applyTenantChange(HttpSession session, String previousTenant, String newTenant)
	{
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

	/**
	 * Ensure the redirect query string includes a valid {@code tenant} parameter when
	 * {@code redirectTenant} is non-empty, without false positives on parameter values
	 * containing {@code tenant=}.
	 * @param savedQuery saved query string from session (may be null)
	 * @param redirectTenant tenant login prefix to preserve (may be null)
	 * @return query string to append after {@code ?}, or null if empty
	 */
	private String ensureTenantQueryParameter(String savedQuery, String redirectTenant)
	{
		if (Util.isEmpty(redirectTenant, true))
			return savedQuery;

		StringBuilder filtered = new StringBuilder();
		boolean hasValidTenant = false;
		if (!Util.isEmpty(savedQuery))
		{
			for (String pair : savedQuery.split("&"))
			{
				if (pair.isEmpty())
					continue;
				int idx = pair.indexOf('=');
				String rawName = idx >= 0 ? pair.substring(0, idx) : pair;
				String decodedName = null;
				try
				{
					decodedName = URLDecoder.decode(rawName, StandardCharsets.UTF_8);
				}
				catch (IllegalArgumentException e)
				{
					// Leave malformed parameter untouched
				}
				if (TENANT_PREFIX_PARAMETER.equals(decodedName))
				{
					boolean validTenant = false;
					if (idx >= 0)
					{
						String rawValue = pair.substring(idx + 1);
						String decodedValue = rawValue;
						try
						{
							decodedValue = URLDecoder.decode(rawValue, StandardCharsets.UTF_8);
						}
						catch (IllegalArgumentException e)
						{
							// Fall back to raw value check
						}
						validTenant = !Util.isEmpty(decodedValue, true);
					}
					if (!validTenant)
					{
						// Skip empty tenant parameter so a valid or appended tenant parameter is not shadowed
						continue;
					}
					hasValidTenant = true;
				}
				if (filtered.length() > 0)
					filtered.append('&');
				filtered.append(pair);
			}
		}

		if (!hasValidTenant)
		{
			if (filtered.length() > 0)
				filtered.append('&');
			filtered.append(TENANT_PREFIX_PARAMETER)
					.append('=')
					.append(URLEncoder.encode(redirectTenant.trim(), StandardCharsets.UTF_8));
		}
		return filtered.toString();
	}

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
