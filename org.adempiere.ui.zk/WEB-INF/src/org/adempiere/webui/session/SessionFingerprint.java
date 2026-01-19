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

import java.io.Serializable;
import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.Util;

/**
 * Session Fingerprint implementation for protection against Session Fixation attacks.
 * This class generates and validates a fingerprint based on client characteristics
 * such as IP address and User-Agent to detect potential session hijacking attempts.
 * 
 * <p>Implementation follows NIST SP 800-63B guidelines for session management:</p>
 * <ul>
 *   <li>Binds session to client network identity (IP address)</li>
 *   <li>Binds session to device identity (User-Agent + Accept-Language)</li>
 *   <li>Session tokens are regenerated on logout to prevent session fixation</li>
 * </ul>
 * 
 * <p>The fingerprint validation can be configured via AD_SysConfig:</p>
 * <ul>
 *   <li>ZK_SESSION_FINGERPRINT_ENABLED: Enable/disable fingerprint validation (default: Y)</li>
 *   <li>ZK_SESSION_FINGERPRINT_CHECK_IP: Include IP address in fingerprint (default: Y)</li>
 *   <li>ZK_SESSION_FINGERPRINT_CHECK_USER_AGENT: Include User-Agent + Accept-Language in fingerprint (default: Y)</li>
 * </ul>
 */
public class SessionFingerprint implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5710112124674857398L;

	private static final CLogger log = CLogger.getCLogger(SessionFingerprint.class);

	/** Session attribute name for storing the fingerprint */
	public static final String SESSION_FINGERPRINT_ATTR = "session.fingerprint";

	/** The IP address used to generate the fingerprint */
	private String ipAddress;

	/** The User-Agent used to generate the fingerprint */
	private String userAgent;

	/**
	 * Private constructor - use factory methods
	 */
	private SessionFingerprint() {
	}

	/**
	 * Check if session fingerprint validation is enabled
	 * @return true if fingerprint validation is enabled
	 */
	public static boolean isEnabled() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_SESSION_FINGERPRINT_ENABLED, true);
	}

	/**
	 * Check if IP address should be included in fingerprint
	 * @return true if IP address should be checked
	 */
	public static boolean isCheckIP() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_SESSION_FINGERPRINT_CHECK_IP, true);
	}

	/**
	 * Check if User-Agent should be included in fingerprint
	 * @return true if User-Agent should be checked
	 */
	public static boolean isCheckUserAgent() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_SESSION_FINGERPRINT_CHECK_USER_AGENT, true);
	}

	/**
	 * Create a new fingerprint from the HTTP request and store it in the session.
	 * This should be called after successful user authentication.
	 * 
	 * @param request the HTTP servlet request
	 * @param session the HTTP session
	 * @return the created fingerprint, or null if fingerprinting is disabled
	 */
	public static SessionFingerprint create(HttpServletRequest request, HttpSession session) {
		if (!isEnabled()) {
			return null;
		}

		SessionFingerprint fingerprint = new SessionFingerprint();
		fingerprint.ipAddress = getClientIP(request);
		StringBuilder uaBuilder = new StringBuilder(request.getHeader("User-Agent"))
				.append("|")
				.append(request.getHeader("Accept-Language"));
		fingerprint.userAgent =  uaBuilder.toString();

		session.setAttribute(SESSION_FINGERPRINT_ATTR, fingerprint);

		if (log.isLoggable(Level.FINE)) {
			log.fine("Session fingerprint created for session: " + session.getId() + 
					", IP: " + fingerprint.ipAddress);
		}

		return fingerprint;
	}

	/**
	 * Validate the current request against the stored session fingerprint.
	 * This should be called on each request to detect session hijacking attempts.
	 * <p>
	 * 
	 * @param request the HTTP servlet request
	 * @param session the HTTP session
	 * @return true if the fingerprint is valid or fingerprinting is disabled, false if mismatch detected
	 */
	public static boolean validate(HttpServletRequest request, HttpSession session) {
		if (!isEnabled()) {
			return true;
		}

		SessionFingerprint stored = (SessionFingerprint) session.getAttribute(SESSION_FINGERPRINT_ATTR);
		if (stored == null) {
			// No fingerprint stored yet - this is OK for pre-login requests
			return true;
		}

		boolean valid = true;
		String currentIP = null;
		String currentUA = null;

		if (isCheckIP()) {
			currentIP = getClientIP(request);
			if (!Util.isEmpty(stored.ipAddress, true) || !Util.isEmpty(currentIP, true)) {
				valid = valid && areEqual(stored.ipAddress, currentIP);
			}
		}

		if (valid && isCheckUserAgent()) {
			StringBuilder uaBuilder = new StringBuilder(request.getHeader("User-Agent"))
					.append("|")
					.append(request.getHeader("Accept-Language"));
			currentUA = uaBuilder.toString();
			if (!Util.isEmpty(stored.userAgent, true) || !Util.isEmpty(currentUA, true)) {
				valid = valid && areEqual(stored.userAgent, currentUA);
			}
		}

		if (!valid) {
			log.warning("Session fingerprint mismatch detected! Session: " + session.getId() +
					", Stored IP: " + stored.ipAddress + ", Current IP: " + currentIP +
					", Stored UA: " + stored.userAgent + ", Current UA: " + currentUA);
		}

		return valid;
	}

	/**
	 * Compare two strings for equality, handling nulls
	 * @param s1 first string
	 * @param s2 second string
	 * @return true if equal (including both null)
	 */
	private static boolean areEqual(String s1, String s2) {
		if (s1 == null && s2 == null) {
			return true;
		}
		if (s1 == null || s2 == null) {
			return false;
		}
		return s1.equals(s2);
	}

	/**
	 * Remove the fingerprint from the session.
	 * This should be called on logout.
	 * 
	 * @param session the HTTP session
	 */
	public static void remove(HttpSession session) {
		if (session != null) {
			session.removeAttribute(SESSION_FINGERPRINT_ATTR);
		}
	}

	/**
	 * Invalidate the current session and create a new one with a new JSESSIONID.
	 * This should be called on logout to prevent session fixation attacks.
	 * The new session will not have any attributes from the old session.
	 * 
	 * @param request the HTTP servlet request
	 * @return the new HTTP session, or null if request is null
	 */
	public static HttpSession invalidateAndCreateNewSession(HttpServletRequest request) {
		if (request == null) {
			return null;
		}

		HttpSession oldSession = request.getSession(false);
		if (oldSession != null) {
			String oldSessionId = oldSession.getId();
			try {
				oldSession.invalidate();
				if (log.isLoggable(Level.FINE)) {
					log.fine("Session invalidated on logout: " + oldSessionId);
				}
			} catch (IllegalStateException e) {
				// Session already invalidated
				if (log.isLoggable(Level.FINE)) {
					log.fine("Session already invalidated: " + oldSessionId);
				}
			}
		}

		// Create new session with new JSESSIONID
		HttpSession newSession = request.getSession(true);
		if (log.isLoggable(Level.FINE)) {
			log.fine("New session created after logout: " + newSession.getId());
		}

		return newSession;
	}

	/**
	 * Get the client IP address, considering X-Forwarded-For header for proxy scenarios
	 * 
	 * @param request the HTTP servlet request
	 * @return the client IP address
	 */
	private static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (!Util.isEmpty(ip, true) && !"unknown".equalsIgnoreCase(ip)) {
			// X-Forwarded-For can contain multiple IPs, take the first one (original client)
			int commaIndex = ip.indexOf(',');
			if (commaIndex > 0) {
				ip = ip.substring(0, commaIndex).trim();
			}
		} else {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * Get the IP address component of this fingerprint
	 * @return the IP address
	 */
	public String getIpAddress() {
		return ipAddress;
	}

	/**
	 * Get the User-Agent component of this fingerprint
	 * @return the User-Agent
	 */
	public String getUserAgent() {
		return userAgent;
	}

	@Override
	public String toString() {
		return "SessionFingerprint[ip=" + ipAddress + ", ua=" + userAgent + "]";
	}

}
