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

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.compiere.util.Language;

/**
 * Single sign on service interface
 * @author Logilite Technologies
 */
public interface ISSOPrincipalService
{
	public static final String	SSO_PRINCIPAL_SESSION_TOKEN	= "sso.principal.token";

	public static final String	SSO_QUERY_STRING				= "sso.query.string";
	public static final String	SSO_ADMIN_LOGIN				= "sso.admin.login";

	/**
	 * Check the request has an authentication code
	 * 
	 * @param  request  HttpServletRequest
	 * @param  response HttpServletResponse
	 * @return
	 */
	public boolean hasAuthenticationCode(HttpServletRequest request, HttpServletResponse response);

	/**
	 * Get the token by authentication code and save in the session attribute
	 * SSO_PRINCIPAL_SESSION_TOKEN
	 * 
	 * @param  request      HttpServletRequest
	 * @param  response     HttpServletResponse
	 * @param  redirectMode {@value SSOUtils#SSO_MODE_WEBUI}, {@value SSOUtils#SSO_MODE_OSGI},
	 *                      {@value SSOUtils#SSO_MODE_MONITOR}
	 * @throws Throwable
	 */
	public void getAuthenticationToken(HttpServletRequest request, HttpServletResponse response, String redirectMode) throws Throwable;

	/**
	 * Check the request session attribute SSO_PRINCIPAL_SESSION_TOKEN has token
	 * 
	 * @param  request  HttpServletRequest
	 * @param  response HttpServletResponse
	 * @return
	 */
	public boolean isAuthenticated(HttpServletRequest request, HttpServletResponse response);

	/**
	 * Redirect to SSO authentication/login page
	 * 
	 * @param  request      HttpServletRequest
	 * @param  response     HttpServletResponse
	 * @param  redirectMode {@value SSOUtils#SSO_MODE_WEBUI}, {@value SSOUtils#SSO_MODE_OSGI},
	 *                      {@value SSOUtils#SSO_MODE_MONITOR}
	 * @throws IOException
	 */
	public void redirectForAuthentication(HttpServletRequest request, HttpServletResponse response, String redirectMode) throws IOException;

	/**
	 * Remove all SSO-related attributes from the session.
	 * 
	 * @param request HttpServletRequest
	 */
	public void removePrincipalFromSession(HttpServletRequest request);

	/**
	 * Return user name/ email from a token.
	 * 
	 * @param  token          authentication token
	 * @return                User Name/email
	 * @throws ParseException
	 */
	public String getUserName(Object token) throws ParseException;

	/**
	 * Return login Language from a token
	 * 
	 * @param  token          authentication token
	 * @return                Login Language
	 * @throws ParseException
	 */
	public Language getLanguage(Object token) throws ParseException;
	
	/**
	 * Get logout url
	 * @return logout url or null
	 */
	default String getLogoutURL() {
		return null;
	}
}
