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

package org.adempiere.webui.session.fingerprint;

import javax.servlet.http.HttpServletRequest;

/**
 * Interface for session fingerprint components.
 * Each component extracts a specific value from the request to be used
 * as part of the session fingerprint for security validation.
 * 
 * <p>Implementations should be registered as OSGi services to be discovered
 * automatically by the fingerprint manager.</p>
 * 
 * <p>Example components:</p>
 * <ul>
 *   <li>IP Address</li>
 *   <li>User-Agent</li>
 *   <li>Accept-Language</li>
 *   <li>Accept-Encoding</li>
 * </ul>
 */
public interface ISessionFingerprintComponent {

	/** Action to take on fingerprint mismatch: Do nothing */
	public static final String ACTION_NOTHING = "N";

	/** Action to take on fingerprint mismatch: Log a warning */
	public static final String ACTION_LOG_WARNING = "W";

	/** Action to take on fingerprint mismatch: Log a severe message, including AD_Issue */
	public static final String ACTION_LOG_SEVERE = "L";

	/** Action to take on fingerprint mismatch: Stop/invalidate session */
	public static final String ACTION_STOP = "S";

	/**
	 * Get the unique identifier for this fingerprint component.
	 * This ID is used as the key when storing the fingerprint value in the session.
	 * 
	 * @return unique component identifier (e.g., "IP", "UserAgent", "AcceptLanguage")
	 */
	String getComponentId();

	/**
	 * Get a human-readable name for this component.
	 * Used for logging and display purposes.
	 * 
	 * @return display name
	 */
	String getDisplayName();

	/**
	 * Check if this fingerprint component is enabled.
	 * Typically reads from AD_SysConfig.
	 * 
	 * @return true if this component should be used for fingerprinting
	 */
	boolean isEnabled();

	/**
	 * Extract the fingerprint value from the HTTP request.
	 * This value will be stored in the session and compared on subsequent requests.
	 * 
	 * @param request the HTTP servlet request
	 * @return the fingerprint value, or null if not available
	 */
	String extractValue(HttpServletRequest request);

	/**
	 * Verify if the current request value matches the stored fingerprint value.
	 * Default implementation does exact string comparison, but subclasses can
	 * override for fuzzy matching (e.g., IP subnet matching).
	 * 
	 * @param storedValue the value stored in the session fingerprint
	 * @param currentValue the value from the current request
	 * @return true if the values match
	 */
	default boolean verify(String storedValue, String currentValue) {
		if (storedValue == null && currentValue == null) {
			return true;
		}
		if (storedValue == null || currentValue == null) {
			return false;
		}
		return storedValue.equals(currentValue);
	}

	/**
	 * Get the action to take when a fingerprint mismatch is detected.
	 * Returns one of the ACTION_* constants.
	 * Typically reads from AD_SysConfig.
	 * 
	 * @return the action code (ACTION_NOTHING, ACTION_LOG_WARNING, ACTION_LOG_SEVERE, or ACTION_STOP)
	 */
	String getMismatchAction();

	/**
	 * Get the priority/order for this component.
	 * Lower values are processed first.
	 * 
	 * @return priority value (default 100)
	 */
	default int getPriority() {
		return 100;
	}

}
