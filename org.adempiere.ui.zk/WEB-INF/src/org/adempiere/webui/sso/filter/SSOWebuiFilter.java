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

import org.adempiere.webui.sso.ISSOPrinciple;
import org.adempiere.webui.sso.SSOUtils;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;

/**
 * Request filter class for the SSO authentication
 * 
 * @author Logilite Technologies
 */
public class SSOWebuiFilter implements Filter
{
	/** Logger */
	protected static CLogger		log				= CLogger.getCLogger(SSOWebuiFilter.class);
	//TODO as this is static, will not work on multi tenant environment
	private static ISSOPrinciple	m_SSOPrinciple	= null;

	/**
	 * AdempiereMonitorFilter
	 */
	public SSOWebuiFilter()
	{
		super();
	} // AdempiereMonitorFilter

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
			boolean isRedirectToLoginOnError = false; 
			try
			{
				if (m_SSOPrinciple == null)
				{
					m_SSOPrinciple = SSOUtils.getSSOPrinciple();
				}

				if (m_SSOPrinciple != null)
				{
					if (m_SSOPrinciple.hasAuthenticationCode(httpRequest, httpResponse))
					{
						// Use authentication code get get token
						m_SSOPrinciple.getAuthenticationToken(httpRequest, httpResponse);
					}
					else if (!m_SSOPrinciple.isAuthenticated(httpRequest, httpResponse))
					{
						// Redirect to SSO sing in page for authentication
						m_SSOPrinciple.redirectForAuthentication(httpRequest, httpResponse);
						return;
					}
					else if (m_SSOPrinciple.isAccessTokenExpired(httpRequest, httpResponse))
					{
						// Refresh token after expired
						isRedirectToLoginOnError = true;
						m_SSOPrinciple.refreshToken(httpRequest, httpResponse);
					}
				}
			}
			catch (Throwable exc)
			{
				log.log(Level.SEVERE, "Exception while authenticating: ",exc);
				if (m_SSOPrinciple != null)
					m_SSOPrinciple.removePrincipleFromSession(httpRequest);
				if(isRedirectToLoginOnError)
				{
					httpResponse.sendRedirect("webui/index.zul");
				}
				else
				{
					httpResponse.setStatus(500);
					httpResponse.sendRedirect(SSOUtils.ERROR_API + exc.getMessage());
				}
				return;
			}
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
	
	public static ISSOPrinciple getSSOPrinciple()
	{
		return m_SSOPrinciple;
	}
} // AdempiereMonitorFilter
