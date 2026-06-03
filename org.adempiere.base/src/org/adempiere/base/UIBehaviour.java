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
import java.util.Properties;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.Lookup;
import org.compiere.model.MLookupInfo;

/**
 * IDEMPIERE-7024
 * Static helper that aggregates the three UI decisions exposed by
 * {@link IUIBehaviour}.
 *
 * For each decision, iterates all OSGi-registered IUIBehaviour services
 * (via {@link Service#locator()}) and aggregates with AND logic:
 *   - all providers say true (or null = neutral) -> true
 *   - at least one provider says false           -> false
 *
 * With no registered provider returns true (vanilla behavior).
 */
public final class UIBehaviour
{
	private UIBehaviour() {
		// utility class - no instances
	}

	/**
	 * @return true if EVERY registered IUIBehaviour service allows caching
	 *         (or if no service is registered).
	 */
	public static boolean isLookupCacheable(Lookup lookup, MLookupInfo lookupInfo)
	{
		List<IUIBehaviour> services = Service.locator().list(IUIBehaviour.class).getServices();
		if (services == null || services.isEmpty())
			return true;
		for (IUIBehaviour svc : services) {
			Boolean res = svc.isLookupCacheable(lookup, lookupInfo);
			if (Boolean.FALSE.equals(res))
				return false;
		}
		return true;
	}

	/**
	 * @return true if EVERY registered IUIBehaviour service allows tab edit.
	 */
	public static boolean isEditable(Properties ctx, GridTab tab)
	{
		List<IUIBehaviour> services = Service.locator().list(IUIBehaviour.class).getServices();
		if (services == null || services.isEmpty())
			return true;
		for (IUIBehaviour svc : services) {
			Boolean res = svc.isEditable(ctx, tab);
			if (Boolean.FALSE.equals(res))
				return false;
		}
		return true;
	}

	/**
	 * @return true if EVERY registered IUIBehaviour service allows field edit.
	 */
	public static boolean isEditable(Properties ctx, GridField field,
	                                  boolean checkContext, boolean isGrid)
	{
		List<IUIBehaviour> services = Service.locator().list(IUIBehaviour.class).getServices();
		if (services == null || services.isEmpty())
			return true;
		for (IUIBehaviour svc : services) {
			Boolean res = svc.isEditable(ctx, field, checkContext, isGrid);
			if (Boolean.FALSE.equals(res))
				return false;
		}
		return true;
	}
}
