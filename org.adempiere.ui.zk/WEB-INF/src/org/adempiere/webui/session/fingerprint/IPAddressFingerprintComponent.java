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
import org.compiere.util.Util;

/**
 * Fingerprint component based on client IP address.
 * Considers X-Forwarded-For header for proxy/load balancer scenarios.
 */
public class IPAddressFingerprintComponent implements ISessionFingerprintComponent {

	private final static String IPV6_LOOPBACK = "[0:0:0:0:0:0:0:1]";
	private final static String IPV4_LOOPBACK = "127.0.0.1";

	@Override
	public boolean verify(String storedValue, String currentValue) {
		// with websocket serverpush, there's confusion between IPv4 and IPv6 loopback addresses
		if (IPV6_LOOPBACK.equals(storedValue) && IPV4_LOOPBACK.equals(currentValue)) {
			return true;
		} else if (IPV4_LOOPBACK.equals(storedValue) && IPV6_LOOPBACK.equals(currentValue)) {
			return true;
		}

		return ISessionFingerprintComponent.super.verify(storedValue, currentValue);
	}

	public static final String COMPONENT_ID = "IP";
	// Default Action is Log Warning session
	private static final String DEFAULT_MISMATCH_ACTION = ISessionFingerprintComponent.ACTION_LOG_SEVERE;

	@Override
	public String getComponentId() {
		return COMPONENT_ID;
	}

	@Override
	public String getDisplayName() {
		return "IP Address";
	}

	@Override
	public boolean isEnabled() {
		return ! ISessionFingerprintComponent.ACTION_NOTHING.equals(MSysConfig.getValue(MSysConfig.ZK_SESSION_FINGERPRINT_CHECK_IP, DEFAULT_MISMATCH_ACTION));
	}

	@Override
	public String extractValue(HttpServletRequest request) {
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

	@Override
	public String getMismatchAction() {
		return MSysConfig.getValue(MSysConfig.ZK_SESSION_FINGERPRINT_CHECK_IP, DEFAULT_MISMATCH_ACTION);
	}

	@Override
	public int getPriority() {
		return 30;
	}

}
