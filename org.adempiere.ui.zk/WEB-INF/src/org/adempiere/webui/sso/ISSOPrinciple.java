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
package org.adempiere.webui.sso;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.compiere.util.Language;

/**
 * @author Logilite Technologies
 *
 */
public interface ISSOPrinciple
{
	public static final String	SSO_PRINCIPLE_SESSION_NAME	= "sso.principle";

	public boolean hasAuthenticationCode(HttpServletRequest request, HttpServletResponse response);

	public void getAuthenticationToken(HttpServletRequest request, HttpServletResponse response) throws Throwable;

	public boolean isAuthenticated(HttpServletRequest request, HttpServletResponse response);

	public void redirectForAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException;

	public boolean isAccessTokenExpired(HttpServletRequest request, HttpServletResponse response);

	public void refreshToken(HttpServletRequest request, HttpServletResponse response) throws Throwable;

	public void removePrincipleFromSession(HttpServletRequest httpRequest);

	public String getUserName(Object result) throws ParseException;

	public Language getLanguage(Object result) throws ParseException;

}
