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
 **********************************************************************/
package org.idempiere.acct;

/**
 * Static portal to accounting model services.
 * The volatile reference is populated by OSGi Declarative Services
 * via {@link #setAccountingService(IPOAccountingService)}.
 *
 * @author etantg
 */
public final class AcctModelServices {

	private AcctModelServices() {}

	private static volatile IPOAccountingService s_accountingService = null;

	/**
	 * Called by OSGi DS when the service becomes available.
	 * @param service accounting service implementation
	 */
	public static void setAccountingService(IPOAccountingService service) {
		s_accountingService = service;
	}

	/**
	 * Called by OSGi DS when the service is withdrawn.
	 * @param service accounting service implementation (ignored)
	 */
	public static void unsetAccountingService(IPOAccountingService service) {
		s_accountingService = null;
	}

	/**
	 * @return the accounting service, or {@code null} if not yet available
	 */
	public static IPOAccountingService getPOAccountingService() {
		return s_accountingService;
	}

	/**
	 * @return true if the accounting service is available
	 */
	public static boolean isAccountingAvailable() {
		return s_accountingService != null;
	}
}