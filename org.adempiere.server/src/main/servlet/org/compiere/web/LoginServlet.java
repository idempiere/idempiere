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
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.util.LogAuthFailure;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 * Login Servlet for iDempiere Monitor
 * Handles form-based authentication with CSRF protection and rate limiting
 * 
 * @author iDempiere Community
 */
public class LoginServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6773644128475237855L;

	/** Logger */
	private static final CLogger log = CLogger.getCLogger(LoginServlet.class);
	
	/** Session attribute for authenticated user */
	public static final String AUTHENTICATED_USER = "AuthenticatedUser";
	
	/** Session attribute for authentication timestamp */
	public static final String AUTH_TIMESTAMP = "AuthTimestamp";
	
	/** Rate limiting: track failed login attempts per IP */
	private static final Map<String, LoginAttempt> loginAttempts = new ConcurrentHashMap<>();
	
	/** Maximum failed login attempts before temporary lockout */
	private static final int MAX_FAILED_ATTEMPTS = 5;
	
	/** Lockout duration in milliseconds (5 minutes) */
	private static final long LOCKOUT_DURATION = 5 * 60 * 1000;

	/** Logger for authentication failures */
	private static LogAuthFailure logAuthFailure = new LogAuthFailure();

	/**
	 * Handle GET requests - redirect to login page
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String returnUrl = request.getParameter("returnUrl");
		if (returnUrl != null && !returnUrl.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp?returnUrl=" + 
					java.net.URLEncoder.encode(returnUrl, "UTF-8"));
		} else {
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp");
		}
	}
	
	/**
	 * Handle POST requests - process login
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String clientIP = getClientIP(request);
		
		// Check rate limiting
		if (isLockedOut(clientIP)) {
			log.warning("Login attempt from locked out IP: " + clientIP);
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp?error=locked");
			return;
		}
		
		// Validate CSRF token
		String csrfToken = request.getParameter("csrfToken");
		HttpSession session = request.getSession(false);
		
		if (session == null || csrfToken == null || 
				!csrfToken.equals(session.getAttribute("CSRF_TOKEN"))) {
			log.warning("CSRF token validation failed from IP: " + clientIP);
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp?error=invalid");
			return;
		}
		
		// Remove CSRF token after use (one-time token)
		session.removeAttribute("CSRF_TOKEN");
		
		// Get credentials
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String returnUrl = request.getParameter("returnUrl");
		
		if (username == null || password == null || 
				username.trim().isEmpty() || password.trim().isEmpty()) {
			log.warning("Empty credentials from IP: " + clientIP);
			recordFailedAttempt(clientIP);
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp?error=invalid");
			return;
		}
		
		// Validate user credentials
		MUser user = null;
		try {
			user = MUser.get(Env.getCtx(), username, password, false);
		} catch (Exception e) {
			log.log(Level.SEVERE, "Error validating user: " + username, e);
		}
		
		if (user == null) {
			log.warning("Invalid login attempt for user: " + username + " from IP: " + clientIP);
			recordFailedAttempt(clientIP);
			logAuthFailure.log(clientIP, "/idempiereMonitor", username, "Invalid login attempt");
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp?error=invalid");
			return;
		}
		
		// Check if user has access to monitor
		if (!user.isAdministrator() && !user.hasURLFormAccess("/idempiereMonitor")) {
			log.warning("User " + username + " attempted to access monitor without permission from IP: " + clientIP);
			recordFailedAttempt(clientIP);
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor/login.jsp?error=access");
			return;
		}
		
		// Authentication successful - clear failed attempts
		loginAttempts.remove(clientIP);
		
		// Create new session to prevent session fixation attacks
		session.invalidate();
		session = request.getSession(true);
		
		// Set secure session attributes
		session.setAttribute(AUTHENTICATED_USER, username);
		session.setAttribute(AUTH_TIMESTAMP, System.currentTimeMillis());
		
		// Set session timeout (15 minutes)
		session.setMaxInactiveInterval(15 * 60);
		
		log.info("Successful login for user: " + username + " from IP: " + clientIP);
		
		// Redirect to original URL or default monitor page
		if (returnUrl != null && !returnUrl.isEmpty() && isValidReturnUrl(returnUrl)) {
			response.sendRedirect(returnUrl);
		} else {
			response.sendRedirect(request.getContextPath() + "/idempiereMonitor");
		}
	}
	
	/**
	 * Get client IP address, considering proxy headers
	 */
	private String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		// If multiple IPs in X-Forwarded-For, take the first one
		if (ip != null && ip.contains(",")) {
			ip = ip.split(",")[0].trim();
		}
		return ip;
	}
	
	/**
	 * Check if IP is currently locked out
	 */
	private boolean isLockedOut(String ip) {
		LoginAttempt attempt = loginAttempts.get(ip);
		if (attempt == null) {
			return false;
		}
		
		if (attempt.failedAttempts.get() >= MAX_FAILED_ATTEMPTS) {
			long timeSinceLockout = System.currentTimeMillis() - attempt.lastAttemptTime.get();
			if (timeSinceLockout < LOCKOUT_DURATION) {
				return true;
			} else {
				// Lockout period expired, reset
				loginAttempts.remove(ip);
				return false;
			}
		}
		return false;
	}
	
	/**
	 * Record a failed login attempt
	 */
	private void recordFailedAttempt(String ip) {
		LoginAttempt attempt = loginAttempts.computeIfAbsent(ip, k -> new LoginAttempt());
		attempt.failedAttempts.incrementAndGet();
		attempt.lastAttemptTime.set(System.currentTimeMillis());
		
		if (attempt.failedAttempts.get() >= MAX_FAILED_ATTEMPTS) {
			log.warning("IP " + ip + " has been locked out after " + MAX_FAILED_ATTEMPTS + " failed attempts");
		}
	}
	
	/**
	 * Validate return URL to prevent open redirect vulnerabilities
	 */
	private boolean isValidReturnUrl(String returnUrl) {
		if (returnUrl == null || returnUrl.isEmpty()) {
			return false;
		}
		// Only allow relative URLs within the same application
		return returnUrl.startsWith("/") && !returnUrl.startsWith("//");
	}
	
	/**
	 * Inner class to track login attempts
	 */
	private static class LoginAttempt {
		AtomicInteger failedAttempts = new AtomicInteger(0);
		AtomicLong lastAttemptTime = new AtomicLong(0);
	}
}
