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

package org.adempiere.base.sso;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.adempiere.base.Service;
import org.compiere.model.I_SSO_PrincipalConfig;
import org.compiere.model.MClient;
import org.compiere.model.MSSOPrincipalConfig;
import org.compiere.model.MSysConfig;
import org.compiere.util.CCache;
import org.compiere.util.Util;

/**
 * Utility methods for single sign on support.
 * @author Logilite Technologies
 */
public class SSOUtils
{
	private static final CCache<Integer, ISSOPrincipalService>	s_SSOPrincipalServicecache	= new CCache<Integer, ISSOPrincipalService>(SSOUtils.class.getSimpleName(), 40, 0);

	public static final String									ERROR_VALIDATION_URL		= "/error.zul";

	public static final String									SSO_MODE_OSGI				= "SSO_MODE_OSGI";
	public static final String									SSO_MODE_WEBUI				= "SSO_MODE_WEBUI";
	public static final String									SSO_MODE_MONITOR			= "SSO_MODE_MONITOR";

	public static final String									ISCHANGEROLE_REQUEST		= "ISCHANGEROLE_REQUEST";

	public static final String									EVENT_ON_AFTER_SSOLOGIN		= "onAfterSSOLogin";

	private static final String									SSO_AUTHENTICATED_TOKEN		= "sso.authenticated.token";

	private static final Object[]								SESSION_LOCKS				= new Object[64];

	// List of url patterns ignored for validating token
	private static ArrayList<String>							ignoreResourceURL			= null;

	static
	{
		ignoreResourceURL = new ArrayList<String>();
		ignoreResourceURL.add("zkau");
		ignoreResourceURL.add("images");
		ignoreResourceURL.add("css");
		ignoreResourceURL.add("res");
		for (int i = 0; i < SESSION_LOCKS.length; i++)
			SESSION_LOCKS[i] = new Object();
	}

	/**
	 * Immutable binding of an authenticated SSO session token to the {@code SSO_PrincipalConfig_UU}
	 * of the provider that produced it.
	 * @param token authenticated principal token
	 * @param providerUU {@code SSO_PrincipalConfig_UU} of the authenticating provider
	 */
	public record SSOSessionToken(Object token, String providerUU) implements Serializable
	{
		private static final long serialVersionUID = 1L;
	}

	private static Object getSessionLock(HttpSession session)
	{
		String id = session.getId();
		int stripe = id != null ? Math.floorMod(id.hashCode(), SESSION_LOCKS.length) : 0;
		return SESSION_LOCKS[stripe];
	}

	/**
	 * Get system level default single sign on service
	 * @return system level default single sign on service
	 */
	public static ISSOPrincipalService getSSOPrincipalService()
	{
		MSSOPrincipalConfig config = MSSOPrincipalConfig.getDefaultSSOPrincipalConfig(0);
		if (config == null)
			return null;

		return getSSOPrincipalServiceForConfig(config);
	}

	/**
	 * Get SSO Principal Service for a configuration
	 * @param config SSO Principal Configuration
	 * @return SSO Principal Service or null
	 */
	public static ISSOPrincipalService getSSOPrincipalServiceForConfig(I_SSO_PrincipalConfig config)
	{
		if (config == null)
			return null;
		if (s_SSOPrincipalServicecache.containsKey(config.getSSO_PrincipalConfig_ID()))
			return s_SSOPrincipalServicecache.get(config.getSSO_PrincipalConfig_ID());

		ISSOPrincipalService principal = null;
		List<ISSOPrincipalFactory> factories = Service.locator().list(ISSOPrincipalFactory.class).getServices();
		for (ISSOPrincipalFactory factory : factories)
		{
			principal = factory.getSSOPrincipalService(config);
			if (principal != null)
			{
				s_SSOPrincipalServicecache.put(config.getSSO_PrincipalConfig_ID(), principal);
				break;
			}
		}
		return principal;
	}

	/**
	 * The target redirect URL for identity provider after authentication 
	 * @param redirectMode
	 * @param config
	 * @return
	 */
	public static String getRedirectedURL(String redirectMode, I_SSO_PrincipalConfig config)
	{
		if (SSO_MODE_OSGI.equalsIgnoreCase(redirectMode))
			return config.getSSO_OSGIRedirectURIs();
		else if (SSO_MODE_MONITOR.equalsIgnoreCase(redirectMode))
			return config.getSSO_IDempMonitorRedirectURIs();
		return config.getSSO_ApplicationRedirectURIs();
	}

	/**
	 * Create HTML page for error message
	 * @param error
	 * @return HTML error page
	 */
	public static String getCreateErrorResponce(String error)
	{
		return new StringBuffer("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>")
						.append("<html xmlns='http://www.w3.org/1999/xhtml'>")
						.append("<head>")
						.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />")
						.append("<title>iDempiere Server Error</title>")
						.append("<link href='/standard.css' rel='stylesheet'/>")
						.append("</head>")
						.append("<body>")
						.append("<h1>iDempiere Server Error </h1>")
						.append("<p>The iDempiere Server encountered a unrecoverable error.</p>")
						.append("<p>")
						.append(error)
						.append("</p>")
						.append("<h2>Please notify the administrator.</h2>")
						.append("</body>")
						.append("</html>")
						.toString();

	}

	/**
	 * If request is a resource request, do not redirected to identity provider for authentication
	 * @param request
	 * @param isWebUI
	 * @return true if request is a resource request
	 */
	public static boolean isResourceRequest(HttpServletRequest request, boolean isWebUI)
	{
		String[] urlpath = request.getServletPath().toLowerCase().split("/");
		if (isWebUI)
			return urlpath != null && urlpath.length > 1 && ignoreResourceURL.contains(urlpath[1]);
		else
			return urlpath != null && urlpath.length > 3 && ignoreResourceURL.contains(urlpath[3]);
	}

	/**
	 * Get SSO Principal Service by UUID
	 * @param uuID
	 * @return
	 */
	public static ISSOPrincipalService getSSOPrincipalService(String uuID)
	{
		return getSSOPrincipalService(uuID, null);
	}

	/**
	 * Get SSO Principal Configuration by UUID and tenant login prefix
	 * @param uuID
	 * @param tenant tenant login prefix
	 * @return {@link MSSOPrincipalConfig} or null
	 */
	public static MSSOPrincipalConfig getSSOPrincipalConfig(String uuID, String tenant)
	{
		if (Util.isEmpty(uuID, true))
		{
			List<MSSOPrincipalConfig> configList = null;
			if (!Util.isEmpty(tenant, true))
			{
				MClient client = MClient.getByLoginPrefix(tenant.trim());
				if (client != null)
				{
					configList = MSSOPrincipalConfig.getSSOPrincipalConfigByClient(client.getAD_Client_ID());
				}
				else
				{
					return null;
				}
			}
			else
			{
				configList = MSSOPrincipalConfig.getSSOPrincipalConfigByClient(0);
			}

			if (configList == null || configList.size() != 1 || MSysConfig.getBooleanValue(MSysConfig.SSO_SHOW_LOGINPAGE, false))
				return null;
			else
				return configList.get(0);
		}

		MSSOPrincipalConfig config = MSSOPrincipalConfig.getSSOPrincipalConfig(uuID.trim());
		if (config == null)
			return null;
		
		// validate config is valid for tenant login prefix argument
		if (!Util.isEmpty(tenant, true)) 
		{
			MClient client = MClient.getByLoginPrefix(tenant.trim());
			if (client == null || config.getAD_Client_ID() != client.getAD_Client_ID())
				return null;
		}
		else if (config.getAD_Client_ID() != 0)
		{
			return null;
		}
		
		return config;
	}

	/**
	 * Get SSO Principal Service by UUID and tenant login prefix
	 * @param uuID
	 * @param tenant tenant login prefix
	 * @return
	 */
	public static ISSOPrincipalService getSSOPrincipalService(String uuID, String tenant)
	{
		return getSSOPrincipalServiceForConfig(getSSOPrincipalConfig(uuID, tenant));
	}

	private static HttpSession unwrapSession(HttpSession session)
	{
		while (session instanceof TokenBindingHttpSession wrapped)
			session = wrapped.delegate;
		return session;
	}

	/**
	 * Store an SSO session token atomically bound to the authenticating provider UUID.
	 * Also updates {@link ISSOPrincipalService#SSO_PRINCIPAL_SESSION_TOKEN} and
	 * {@link ISSOPrincipalService#SSO_AUTHENTICATED_PROVIDER} for backward compatibility.
	 * @param session HTTP session
	 * @param token authenticated principal token
	 * @param providerUU {@code SSO_PrincipalConfig_UU} of the authenticating provider
	 */
	public static void setSSOSessionToken(HttpSession session, Object token, String providerUU)
	{
		session = unwrapSession(session);
		if (session == null)
			return;
		if (token == null || Util.isEmpty(providerUU, true))
		{
			clearSSOSessionToken(session);
			return;
		}
		String normalizedProviderUU = providerUU.trim();
		SSOSessionToken boundToken = new SSOSessionToken(token, normalizedProviderUU);
		synchronized (getSessionLock(session))
		{
			session.setAttribute(SSO_AUTHENTICATED_TOKEN, boundToken);
			session.setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, token);
			session.setAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, normalizedProviderUU);
		}
	}

	/**
	 * Wrap an {@link HttpServletRequest} for {@link ISSOPrincipalService#getAuthenticationToken}
	 * so that legacy implementations writing directly to
	 * {@link ISSOPrincipalService#SSO_PRINCIPAL_SESSION_TOKEN} atomically bind the token to
	 * {@code providerUU} at the write site without reading back from the shared session.
	 * @param request HTTP request
	 * @param providerUU {@code SSO_PrincipalConfig_UU} of the authenticating provider
	 * @return wrapped request, or {@code request} unchanged if {@code request} is null or {@code providerUU} is empty
	 */
	public static HttpServletRequest wrapRequestForTokenBinding(HttpServletRequest request, String providerUU)
	{
		if (request == null || Util.isEmpty(providerUU, true))
			return request;
		String normalizedProviderUU = providerUU.trim();
		return new HttpServletRequestWrapper(request)
		{
			@Override
			public HttpSession getSession()
			{
				HttpSession session = super.getSession();
				return session != null ? new TokenBindingHttpSession(unwrapSession(session), normalizedProviderUU) : null;
			}

			@Override
			public HttpSession getSession(boolean create)
			{
				HttpSession session = super.getSession(create);
				return session != null ? new TokenBindingHttpSession(unwrapSession(session), normalizedProviderUU) : null;
			}
		};
	}

	/**
	 * Get the atomically bound SSO session token and authenticating provider UUID in a single session read.
	 * @param session HTTP session
	 * @return {@link SSOSessionToken} or null if absent or invalid
	 */
	public static SSOSessionToken getSSOSessionToken(HttpSession session)
	{
		session = unwrapSession(session);
		if (session == null)
			return null;
		Object attr = session.getAttribute(SSO_AUTHENTICATED_TOKEN);
		if (attr instanceof SSOSessionToken boundToken
				&& boundToken.token() != null
				&& !Util.isEmpty(boundToken.providerUU(), true))
		{
			return boundToken;
		}
		return null;
	}

	/**
	 * Read the session's bound SSO token in a single session lookup and verify it was authenticated
	 * by the expected SSO configuration UUID.
	 * @param session HTTP session
	 * @param expectedProviderUU expected {@code SSO_PrincipalConfig_UU}
	 * @return the validated principal token, or null if absent or bound to a different provider
	 */
	public static Object getValidatedSessionToken(HttpSession session, String expectedProviderUU)
	{
		if (session == null || Util.isEmpty(expectedProviderUU, true))
			return null;
		SSOSessionToken boundToken = getSSOSessionToken(session);
		if (boundToken != null && expectedProviderUU.trim().equals(boundToken.providerUU()))
			return boundToken.token();
		return null;
	}

	/**
	 * Check whether the session's SSO token was authenticated by the expected SSO configuration UUID.
	 * @param session HTTP session
	 * @param expectedProviderUU expected SSO_PrincipalConfig_UU
	 * @return true if session has both an SSO token and matching authenticated provider UUID
	 */
	public static boolean isTokenValidForProvider(HttpSession session, String expectedProviderUU)
	{
		return getValidatedSessionToken(session, expectedProviderUU) != null;
	}

	/**
	 * Clear SSO token and authenticated provider binding from HTTP session.
	 * @param session HTTP session
	 */
	public static void clearSSOSessionToken(HttpSession session)
	{
		session = unwrapSession(session);
		if (session != null)
		{
			synchronized (getSessionLock(session))
			{
				session.removeAttribute(SSO_AUTHENTICATED_TOKEN);
				session.removeAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
				session.removeAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER);
			}
		}
	}

	private static final class TokenBindingHttpSession implements HttpSession
	{
		private final HttpSession delegate;
		private final String providerUU;

		private TokenBindingHttpSession(HttpSession delegate, String providerUU)
		{
			this.delegate = delegate;
			this.providerUU = providerUU;
		}

		@Override
		public long getCreationTime()
		{
			return delegate.getCreationTime();
		}

		@Override
		public String getId()
		{
			return delegate.getId();
		}

		@Override
		public long getLastAccessedTime()
		{
			return delegate.getLastAccessedTime();
		}

		@Override
		public ServletContext getServletContext()
		{
			return delegate.getServletContext();
		}

		@Override
		public void setMaxInactiveInterval(int interval)
		{
			delegate.setMaxInactiveInterval(interval);
		}

		@Override
		public int getMaxInactiveInterval()
		{
			return delegate.getMaxInactiveInterval();
		}

		@SuppressWarnings("deprecation")
		@Override
		public javax.servlet.http.HttpSessionContext getSessionContext()
		{
			return delegate.getSessionContext();
		}

		@Override
		public Object getAttribute(String name)
		{
			return delegate.getAttribute(name);
		}

		@SuppressWarnings("deprecation")
		@Override
		public Object getValue(String name)
		{
			return delegate.getValue(name);
		}

		@Override
		public Enumeration<String> getAttributeNames()
		{
			return delegate.getAttributeNames();
		}

		@SuppressWarnings("deprecation")
		@Override
		public String[] getValueNames()
		{
			return delegate.getValueNames();
		}

		@Override
		public void setAttribute(String name, Object value)
		{
			if (ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN.equals(name))
				setSSOSessionToken(delegate, value, providerUU);
			else
				delegate.setAttribute(name, value);
		}

		@SuppressWarnings("deprecation")
		@Override
		public void putValue(String name, Object value)
		{
			if (ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN.equals(name))
				setSSOSessionToken(delegate, value, providerUU);
			else
				delegate.putValue(name, value);
		}

		@Override
		public void removeAttribute(String name)
		{
			if (ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN.equals(name))
				clearSSOSessionToken(delegate);
			else
				delegate.removeAttribute(name);
		}

		@SuppressWarnings("deprecation")
		@Override
		public void removeValue(String name)
		{
			if (ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN.equals(name))
				clearSSOSessionToken(delegate);
			else
				delegate.removeValue(name);
		}

		@Override
		public void invalidate()
		{
			delegate.invalidate();
		}

		@Override
		public boolean isNew()
		{
			return delegate.isNew();
		}

		@Override
		public boolean equals(Object obj)
		{
			if (this == obj)
				return true;
			if (obj instanceof TokenBindingHttpSession other)
				return delegate.equals(other.delegate);
			return delegate.equals(obj);
		}

		@Override
		public int hashCode()
		{
			return delegate.hashCode();
		}
	}
}
