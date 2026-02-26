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

import org.compiere.model.MSysConfig;

/**
 * Fingerprint component based on Accept-Language header.
 * This identifies the user's language preferences configured in the browser.
 */
public class AcceptLanguageFingerprintComponent implements ISessionFingerprintComponent {

	public static final String COMPONENT_ID = "AcceptLanguage";
	// Default Action is Stop session
	private static final String DEFAULT_MISMATCH_ACTION = ISessionFingerprintComponent.ACTION_STOP;

	@Override
	public String getComponentId() {
		return COMPONENT_ID;
	}

	@Override
	public String getDisplayName() {
		return "Accept-Language";
	}

	@Override
	public boolean isEnabled() {
		return ! ISessionFingerprintComponent.ACTION_NOTHING.equals(MSysConfig.getValue(MSysConfig.ZK_SESSION_FINGERPRINT_CHECK_ACCEPT_LANGUAGE, DEFAULT_MISMATCH_ACTION));
	}

	@Override
	public String extractValue(HttpServletRequest request) {
		return request.getHeader("Accept-Language");
	}

	@Override
	public String getMismatchAction() {
		return MSysConfig.getValue(MSysConfig.ZK_SESSION_FINGERPRINT_CHECK_ACCEPT_LANGUAGE, DEFAULT_MISMATCH_ACTION);
	}

	@Override
	public int getPriority() {
		return 20;
	}

}
