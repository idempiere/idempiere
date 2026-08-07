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
 **********************************************************************/
package org.adempiere.base;

import java.util.List;

import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.Util;

/**
 * Resolves the {@link IPasswordResetService} implementation to use.
 * <p>
 * By default the first registered OSGi DS provider is returned. Setting the
 * {@link MSysConfig#PASSWORD_RESET_SERVICE_CLASS} config (per tenant) to the <b>DS component name</b>
 * of another registered {@link IPasswordResetService} selects that implementation instead, so a
 * third-party plugin can swap the password-reset logic without changing any caller. If the configured
 * component is not registered, the built-in default is used.
 *
 * @author d-ruiz - IDEMPIERE-7060
 */
public class PasswordResetServiceFactory
{
	private final static CLogger s_log = CLogger.getCLogger(PasswordResetServiceFactory.class);

	/** DS component name of the built-in implementation */
	public static final String DEFAULT_SERVICE_NAME = "org.adempiere.base.DefaultPasswordResetService";

	private static IServiceReferenceHolder<IPasswordResetService> s_defaultRef = null;

	/**
	 * Resolve the password-reset service for the tenant. Reads
	 * {@link MSysConfig#PASSWORD_RESET_SERVICE_CLASS} (a DS component name); if set and registered,
	 * returns that provider; otherwise the built-in default.
	 * @param AD_Client_ID tenant used to resolve the config (may be 0 for system)
	 * @return the resolved service, or null if none is registered
	 */
	public static IPasswordResetService getService(int AD_Client_ID)
	{
		String name = MSysConfig.getValue(MSysConfig.PASSWORD_RESET_SERVICE_CLASS, AD_Client_ID);
		if (!Util.isEmpty(name, true) && !DEFAULT_SERVICE_NAME.equals(name.trim()))
		{
			IServiceHolder<IPasswordResetService> holder =
					Service.locator().locate(IPasswordResetService.class, name.trim(), null);
			IPasswordResetService service = (holder != null) ? holder.getService() : null;
			if (service != null)
				return service;
			s_log.warning("PASSWORD_RESET_SERVICE_CLASS '" + name
					+ "' is not a registered IPasswordResetService component; using default");
		}
		return getDefaultService();
	}

	/**
	 * @return the built-in (or first-registered) provider, or null if none is registered
	 */
	private static IPasswordResetService getDefaultService()
	{
		if (s_defaultRef != null)
		{
			IPasswordResetService service = s_defaultRef.getService();
			if (service != null)
				return service;
		}

		IServicesHolder<IPasswordResetService> holder = Service.locator().list(IPasswordResetService.class);
		List<IServiceReferenceHolder<IPasswordResetService>> references = holder.getServiceReferences();
		if (references != null)
		{
			for (IServiceReferenceHolder<IPasswordResetService> refHolder : references)
			{
				IPasswordResetService service = refHolder.getService();
				if (service != null)
				{
					s_defaultRef = refHolder;
					return service;
				}
			}
		}
		return null;
	}
}
