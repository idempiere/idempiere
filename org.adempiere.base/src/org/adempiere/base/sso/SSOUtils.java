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

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

	// List of url patterns ignored for validating token
	private static ArrayList<String>							ignoreResourceURL			= null;

	static
	{
		ignoreResourceURL = new ArrayList<String>();
		ignoreResourceURL.add("zkau");
		ignoreResourceURL.add("images");
		ignoreResourceURL.add("css");
		ignoreResourceURL.add("res");
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

		return getSSOPrincipalService(config);
	}

	/**
	 * Get SSO Principal Service for a configuration
	 * @param config SSO Principal Configuration
	 * @return SSO Principal Service or null
	 */
	public static ISSOPrincipalService getSSOPrincipalService(MSSOPrincipalConfig config)
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
		return getSSOPrincipalService(getSSOPrincipalConfig(uuID, tenant));
	}

	/**
	 * Check whether the session's SSO token was authenticated by the expected SSO configuration UUID.
	 * @param session HTTP session
	 * @param expectedProviderUU expected SSO_PrincipalConfig_UU
	 * @return true if session has both an SSO token and matching authenticated provider UUID
	 */
	public static boolean isTokenValidForProvider(HttpSession session, String expectedProviderUU)
	{
		if (session == null || Util.isEmpty(expectedProviderUU, true))
			return false;
		Object token = session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
		Object authProvider = session.getAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER);
		return token != null
				&& authProvider instanceof String authenticatedProviderUU
				&& expectedProviderUU.trim().equals(authenticatedProviderUU);
	}

	/**
	 * Clear SSO token and authenticated provider binding from HTTP session.
	 * @param session HTTP session
	 */
	public static void clearSSOSessionToken(HttpSession session)
	{
		if (session != null)
		{
			session.removeAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
			session.removeAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER);
		}
	}
}
