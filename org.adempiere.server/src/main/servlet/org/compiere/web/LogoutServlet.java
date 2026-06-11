/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.web;

import java.io.IOException;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.compiere.util.CLogger;

/**
 * Logout Servlet for iDempiere Monitor
 * Handles session invalidation and cleanup
 * 
 * @author iDempiere Community
 */
public class LogoutServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	/** Logger */
	private static final CLogger log = CLogger.getCLogger(LogoutServlet.class);
	
	/**
	 * Handle GET and POST requests
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		handleLogout(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		handleLogout(request, response);
	}
	
	/**
	 * Process logout
	 */
	private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		
		if (session != null) {
			// Get username for logging before invalidation
			String username = (String) session.getAttribute(LoginServlet.AUTHENTICATED_USER);
			
			try {
				// Clean up SSO session if present
				Object ssoToken = session.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
				if (ssoToken != null) {
					session.removeAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
				}
				
				// Invalidate session
				session.invalidate();
				
				if (username != null) {
					log.info("User logged out: " + username);
				} else {
					log.info("Anonymous session logged out");
				}
				
			} catch (Exception e) {
				log.log(Level.WARNING, "Error during logout", e);
			}
		}
		
		// Redirect to login page
		response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp");
	}
}
