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

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.adempiere.base.Service;
import org.compiere.model.MSysConfig;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;

/**
 * Manager for extensible session fingerprinting.
 * Discovers and coordinates all registered {@link ISessionFingerprintComponent} services
 * to create and validate session fingerprints.
 * 
 * <p>Components are discovered via OSGi service registry and sorted by priority.</p>
 * 
 * <p>Global enable/disable is controlled via AD_SysConfig ZK_SESSION_FINGERPRINT_ENABLED</p>
 */
public class SessionFingerprintManager {

	private static final CLogger log = CLogger.getCLogger(SessionFingerprintManager.class);

	/** Session attribute name for storing the composite fingerprint */
	public static final String SESSION_FINGERPRINT_ATTR = "session.fingerprint";

	/** Cache key for components list */
	private static final String COMPONENTS_CACHE_KEY = "fingerprint.components";

	/** Cache for fingerprint components - expires after 60 minutes */
	private static final CCache<String, List<ISessionFingerprintComponent>> s_componentsCache = 
			new CCache<>(null, "SessionFingerprintComponents", 1, 60, false);

	/**
	 * Composite fingerprint stored in session, containing values from all components
	 */
	public static class CompositeFingerprint implements Serializable {
		/**
		 * 
		 */
		private static final long serialVersionUID = 1352639946351252330L;

		private final Map<String, String> componentValues = new ConcurrentHashMap<>();
		private final long createdAt;
		private int sessionId;

		public CompositeFingerprint() {
			this.createdAt = System.currentTimeMillis();
		}

		public void setValue(String componentId, String value) {
			componentValues.put(componentId, value);
		}

		public String getValue(String componentId) {
			return componentValues.get(componentId);
		}

		public boolean hasValue(String componentId) {
			return componentValues.containsKey(componentId);
		}

		public long getCreatedAt() {
			return createdAt;
		}

		public Map<String, String> getAllValues() {
			return new HashMap<>(componentValues);
		}

		public int getAD_Session_ID() {
			return sessionId;
		}

		public void setAD_Session_ID(int adSessionId) {
			this.sessionId = adSessionId;
		}

		@Override
		public String toString() {
			return "CompositeFingerprint[AD_Session_ID=" + sessionId + ", created=" + createdAt + ", values=" + componentValues + "]";
		}
	}

	/**
	 * Private constructor - utility class with static methods
	 */
	private SessionFingerprintManager() {
	}

	/**
	 * Check if session fingerprint validation is enabled globally
	 * @return true if fingerprint validation is enabled
	 */
	public static boolean isEnabled() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_SESSION_FINGERPRINT_ENABLED, true);
	}

	/**
	 * Get all registered fingerprint components, sorted by priority.
	 * Results are cached for performance.
	 * @return list of components (empty list if no OSGi services registered)
	 */
	public static List<ISessionFingerprintComponent> getComponents() {
		List<ISessionFingerprintComponent> components = s_componentsCache.get(COMPONENTS_CACHE_KEY);
		if (components != null) {
			return components;
		}

		synchronized (s_componentsCache) {
			components = Service.locator().list(ISessionFingerprintComponent.class).getServices();

			if (components == null) {
				components = new ArrayList<>();
			} else {
				// Make a mutable copy for sorting
				components = new ArrayList<>(components);
			}

			// Sort by priority
			components.sort(Comparator.comparingInt(ISessionFingerprintComponent::getPriority));

			s_componentsCache.put(COMPONENTS_CACHE_KEY, components);

			if (log.isLoggable(Level.FINE)) {
				log.fine("Cached " + components.size() + " fingerprint components");
			}
		}

		return components;
	}

	/**
	 * Create a new composite fingerprint from the HTTP request and store it in the session.
	 * This should be called after successful user authentication.
	 * 
	 * @param request the HTTP servlet request
	 * @param session the HTTP session
	 * @param sessionId the AD_Session_ID for logging purposes
	 * @return the created fingerprint, or null if fingerprinting is disabled
	 */
	public static CompositeFingerprint create(HttpServletRequest request, HttpSession session, int sessionId) {
		if (!isEnabled()) {
			return null;
		}

		CompositeFingerprint fingerprint = new CompositeFingerprint();
		fingerprint.setAD_Session_ID(sessionId);
		List<ISessionFingerprintComponent> components = getComponents();

		for (ISessionFingerprintComponent component : components) {
			if (component.isEnabled()) {
				try {
					String value = component.extractValue(request);
					if (value != null)
						fingerprint.setValue(component.getComponentId(), value);

					if (log.isLoggable(Level.FINE)) {
						log.fine("Fingerprint component " + component.getComponentId() + 
								" = " + (value != null ? value.substring(0, Math.min(50, value.length())) : "null"));
					}
				} catch (Exception e) {
					log.log(Level.WARNING, "Error extracting fingerprint component: " + 
							component.getComponentId(), e);
				}
			}
		}

		session.setAttribute(SESSION_FINGERPRINT_ATTR, fingerprint);

		if (log.isLoggable(Level.FINE)) {
			log.fine("Session fingerprint created: " + fingerprint);
		}

		return fingerprint;
	}

	/**
	 * Validate the current request against the stored session fingerprint.
	 * This should be called on each request to detect session hijacking attempts.
	 * 
	 * @param request the HTTP servlet request
	 * @param session the HTTP session
	 * @return validation result with details about any mismatches
	 */
	public static FingerprintValidationResult validate(HttpServletRequest request, HttpSession session) {
		FingerprintValidationResult result = new FingerprintValidationResult();

		if (!isEnabled()) {
			return result; // Valid by default when disabled
		}

		CompositeFingerprint stored = (CompositeFingerprint) session.getAttribute(SESSION_FINGERPRINT_ATTR);
		if (stored == null) {
			// No fingerprint stored yet - this is OK for pre-login requests
			return result;
		}

		List<ISessionFingerprintComponent> components = getComponents();

		for (ISessionFingerprintComponent component : components) {
			if (!component.isEnabled()) {
				continue;
			}

			String action = component.getMismatchAction();
			if (ISessionFingerprintComponent.ACTION_NOTHING.equals(action)) {
				continue; // Skip validation if action is nothing
			}

			try {
				// Skip if we don't have a stored value for this component
				if (!stored.hasValue(component.getComponentId())) {
					continue;
				}

				String storedValue = stored.getValue(component.getComponentId());
				String currentValue = component.extractValue(request);
				int sessionId = stored.getAD_Session_ID();

				if (!component.verify(storedValue, currentValue)) {

					FingerprintValidationResult.ComponentMismatch mismatch = 
							new FingerprintValidationResult.ComponentMismatch(
									component.getComponentId(),
									component.getDisplayName(),
									storedValue,
									currentValue,
									action,
									sessionId);

					result.addMismatch(mismatch);

					if (   ISessionFingerprintComponent.ACTION_LOG_SEVERE.equals(action)
						|| ISessionFingerprintComponent.ACTION_STOP.equals(action))
						log.severe("Session " + sessionId + " fingerprint mismatch: " + mismatch);
					else if (ISessionFingerprintComponent.ACTION_LOG_WARNING.equals(action))
						log.warning("Session " + sessionId + " fingerprint mismatch: " + mismatch);

					if (!ISessionFingerprintComponent.ACTION_STOP.equals(action))
						stored.setValue(component.getComponentId(), currentValue);
				}
			} catch (Exception e) {
				log.log(Level.WARNING, "Error validating fingerprint component: " + 
						component.getComponentId(), e);
			}
		}

		return result;
	}

	/**
	 * Simple validation that returns boolean for backward compatibility.
	 * Returns false only if validation failed AND action is STOP.
	 * 
	 * @param request the HTTP servlet request
	 * @param session the HTTP session
	 * @return true if valid or no stop action required, false if session should be invalidated
	 */
	public static boolean isValid(HttpServletRequest request, HttpSession session) {
		FingerprintValidationResult result = validate(request, session);
		return !result.shouldStop();
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
	 * Update a specific component value in the stored fingerprint.
	 * Useful for components that receive values asynchronously (e.g., via JavaScript).
	 * 
	 * @param session the HTTP session
	 * @param componentId the component ID
	 * @param value the new value
	 */
	public static void updateComponentValue(HttpSession session, String componentId, String value) {
		if (session == null) {
			return;
		}

		CompositeFingerprint fingerprint = (CompositeFingerprint) session.getAttribute(SESSION_FINGERPRINT_ATTR);
		if (fingerprint != null) {
			fingerprint.setValue(componentId, value);
			if (log.isLoggable(Level.FINE)) {
				log.fine("Updated fingerprint component " + componentId + " = " + value);
			}
		}
	}

}
