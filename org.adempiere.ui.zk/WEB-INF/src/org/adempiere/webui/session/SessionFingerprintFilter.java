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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.adempiere.webui.session;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.webui.session.fingerprint.FingerprintValidationResult;
import org.adempiere.webui.session.fingerprint.SessionFingerprintManager;
import org.compiere.util.CLogger;
import org.compiere.util.Util;

/**
 * Servlet filter to validate session fingerprint on each request.
 * This filter helps protect against session fixation and session hijacking attacks
 * by validating that client characteristics (IP, User-Agent) match what was stored
 * at login time.
 * 
 * When a fingerprint mismatch is detected, the session is invalidated and the user
 * is redirected to the login page.
 */
public class SessionFingerprintFilter implements Filter {

	private static final CLogger log = CLogger.getCLogger(SessionFingerprintFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		if (log.isLoggable(java.util.logging.Level.INFO))
			log.info("SessionFingerprintFilter initialized");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		if (!(request instanceof HttpServletRequest) || !(response instanceof HttpServletResponse)) {
			chain.doFilter(request, response);
			return;
		}

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		// Skip fingerprint check for certain requests
		if (shouldSkipValidation(httpRequest)) {
			chain.doFilter(request, response);
			return;
		}

		HttpSession session = httpRequest.getSession(false);
		if (session != null) {
			// Validate the fingerprint and get detailed result
			FingerprintValidationResult result = SessionFingerprintManager.validate(httpRequest, session);

			if (result.hasMismatches()) {
				// Check if we need to stop/invalidate the session
				if (result.shouldStop()) {
					log.warning("Session " + result.getMismatches().get(0).getAD_Session_ID() + " fingerprint validation failed - invalidating session "
							+ " Remote IP: "
							+ httpRequest.getRemoteAddr());

					// Invalidate the compromised session
					try {
						session.invalidate();
					} catch (IllegalStateException e) {
						// Session already invalidated
					}

					// Redirect to login page
					String contextPath = httpRequest.getContextPath();
					if (Util.isEmpty(contextPath)) {
						contextPath = "";
					}
					httpResponse.sendRedirect(contextPath + "/");
					return;
				}
			}
		}

		chain.doFilter(request, response);
	}

	/**
	 * Check if fingerprint validation should be skipped for this request
	 * 
	 * @param request the HTTP request
	 * @return true if validation should be skipped
	 */
	private boolean shouldSkipValidation(HttpServletRequest request) {
		// Skip for static resources
		String path = request.getServletPath();
		if (path != null) {
			if (   path.endsWith(".css")
					|| path.endsWith(".js")
					|| path.endsWith(".png")
					|| path.endsWith(".jpg")
					|| path.endsWith(".gif")
					|| path.endsWith(".ico")
					|| path.endsWith(".woff")
					|| path.endsWith(".woff2")
					|| path.endsWith(".ttf")
					|| path.endsWith(".eot")
					|| path.startsWith("/images/")
					|| path.startsWith("/css/")
					|| path.startsWith("/js/")) {
				return true;
			}

			// Skip ZK AU requests EXCEPT uploads (uploads should be validated)
			if (path.startsWith("/zkau/") && !path.contains("/upload")) {
				return true;
			}
		}

		// Skip for ping requests
		String ping = request.getHeader("X-PING");
		if (!Util.isEmpty(ping, true)) {
			return true;
		}

		return false;
	}

	@Override
	public void destroy() {
		if (log.isLoggable(java.util.logging.Level.INFO))
			log.info("SessionFingerprintFilter destroyed");
	}

}
