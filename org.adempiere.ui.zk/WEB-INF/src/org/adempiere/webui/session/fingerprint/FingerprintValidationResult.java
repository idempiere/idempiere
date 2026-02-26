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

import java.util.ArrayList;
import java.util.List;

/**
 * Result of fingerprint validation containing details about any mismatches found.
 */
public class FingerprintValidationResult {

	private boolean valid = true;
	private boolean shouldStop = false;
	private final List<ComponentMismatch> mismatches = new ArrayList<>();

	/**
	 * Record of a single component mismatch
	 */
	public static class ComponentMismatch {
		private final String componentId;
		private final String displayName;
		private final String storedValue;
		private final String currentValue;
		private final String action;
		private final int sessionId;

		public ComponentMismatch(String componentId, String displayName, 
				String storedValue, String currentValue, String action, int sessionId) {
			this.componentId = componentId;
			this.displayName = displayName;
			this.storedValue = storedValue;
			this.currentValue = currentValue;
			this.action = action;
			this.sessionId = sessionId;
		}

		public String getComponentId() {
			return componentId;
		}

		public String getDisplayName() {
			return displayName;
		}

		public String getStoredValue() {
			return storedValue;
		}

		public String getCurrentValue() {
			return currentValue;
		}

		public String getAction() {
			return action;
		}

		public int getAD_Session_ID() {
			return sessionId;
		}

		@Override
		public String toString() {
			return "Mismatch[" + displayName + ": stored=" + storedValue + 
					", current=" + currentValue + ", action=" + action + "]";
		}
	}

	/**
	 * @return true if all fingerprint components matched
	 */
	public boolean isValid() {
		return valid;
	}

	/**
	 * @return true if the session should be stopped/invalidated
	 */
	public boolean shouldStop() {
		return shouldStop;
	}

	/**
	 * @return list of all component mismatches
	 */
	public List<ComponentMismatch> getMismatches() {
		return mismatches;
	}

	/**
	 * Add a mismatch to the result
	 * @param mismatch the mismatch details
	 */
	public void addMismatch(ComponentMismatch mismatch) {
		mismatches.add(mismatch);
		valid = false;

		// Determine if we should stop or show message
		if (ISessionFingerprintComponent.ACTION_STOP.equals(mismatch.getAction()))
			shouldStop = true;
	}

	/**
	 * @return true if there are any mismatches
	 */
	public boolean hasMismatches() {
		return !mismatches.isEmpty();
	}

	@Override
	public String toString() {
		if (valid) {
			return "FingerprintValidationResult[valid=true]";
		}
		return "FingerprintValidationResult[valid=false, shouldStop=" + shouldStop + 
				", mismatches=" + mismatches + "]";
	}

}
