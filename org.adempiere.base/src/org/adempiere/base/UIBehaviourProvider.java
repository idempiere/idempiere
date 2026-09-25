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
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.logging.Level;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.Lookup;
import org.compiere.model.MLookupInfo;
import org.compiere.util.CLogger;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * IDEMPIERE-7024
 * Static helper that aggregates the three UI decisions exposed by
 * {@link IUIBehaviour}.
 *
 * Registered as an immediate OSGi DS component; all IUIBehaviour providers
 * are injected via @Reference (cardinality 0..n, dynamic policy).
 * The static methods delegate to the component instance so callers
 * (MLookup, GridField) need no OSGi awareness.
 *
 * For each decision the aggregator applies AND/veto logic:
 *   - all providers return true -> true
 *   - at least one provider returns false -> false
 *
 * With no registered provider returns true (vanilla behaviour).
 *
 * Provider failures are isolated: any Exception raised by a provider is
 * logged at WARNING and treated as neutral (allowing), so a single bad plug-in
 * cannot abort lookup resolution or field-editability for the whole window.
 * JVM errors (OutOfMemoryError, etc.) are intentionally not caught and propagate normally.
 */
@Component(name = "org.adempiere.base.UIBehaviourProvider", immediate = true, service = {})
public class UIBehaviourProvider
{
	/** Logger */
	private static final CLogger log = CLogger.getCLogger(UIBehaviourProvider.class);

	/** Singleton instance set by OSGi DS on activate/deactivate. */
	private static volatile UIBehaviourProvider instance;

	private final List<IUIBehaviour> behaviours = new CopyOnWriteArrayList<>();

	@Activate
	public void activate()
	{
		instance = this;
	}

	@Deactivate
	public void deactivate()
	{
		instance = null;
	}

	// IDEMPIERE-7024
	@Reference(name = "IUIBehaviour",
	           service = IUIBehaviour.class,
	           cardinality = ReferenceCardinality.MULTIPLE,
	           policy = ReferencePolicy.DYNAMIC,
	           unbind = "removeIUIBehaviour")
	public void addIUIBehaviour(IUIBehaviour behaviour)
	{
		behaviours.add(behaviour);
	}

	public void removeIUIBehaviour(IUIBehaviour behaviour)
	{
		behaviours.remove(behaviour);
	}

	/**
	 * Concatenate all non-null suffixes returned by registered providers with {@code |}
	 * as separator, or return {@code null} if no provider supplies one.
	 * Each provider contributes an independent dimension to the composite cache key
	 * (e.g. {@code "HST@2026-06-23|ROLE@admin"}), keeping caching active and
	 * well-defined for any number of registered providers.
	 *
	 * @return concatenated suffixes, or null if no provider supplies one
	 */
	public static String getLookupCacheKeySuffix(Lookup lookup, MLookupInfo lookupInfo)
	{
		UIBehaviourProvider inst = instance;
		if (inst == null || inst.behaviours.isEmpty())
			return null;
		StringBuilder sb = null;
		for (IUIBehaviour svc : inst.behaviours) {
			try {
				String suffix = svc.getLookupCacheKeySuffix(lookup, lookupInfo);
				if (suffix != null && !suffix.isEmpty()) {
					if (sb == null) sb = new StringBuilder(suffix);
					else sb.append("|").append(suffix);
				}
			} catch (Exception t) {
				log.log(Level.WARNING,
					"IUIBehaviour provider " + svc.getClass().getName()
					+ " threw in getLookupCacheKeySuffix; treating as neutral", t);
			}
		}
		return sb != null ? sb.toString() : null;
	}

	/**
	 * @return true if every registered IUIBehaviour allows tab editing,
	 *         or if no provider is registered.
	 */
	public static boolean isTabEditable(Properties ctx, GridTab tab)
	{
		UIBehaviourProvider inst = instance;
		if (inst == null || inst.behaviours.isEmpty())
			return true;
		for (IUIBehaviour svc : inst.behaviours) {
			try {
				if (!svc.isTabEditable(ctx, tab))
					return false;
			} catch (Exception t) {
				log.log(Level.WARNING,
					"IUIBehaviour provider " + svc.getClass().getName()
					+ " threw in isTabEditable; treating as neutral", t);
			}
		}
		return true;
	}

	/**
	 * @return true if every registered IUIBehaviour allows field editing,
	 *         or if no provider is registered.
	 */
	public static boolean isFieldEditable(Properties ctx, GridField field,
	                                       boolean checkContext, boolean isGrid)
	{
		UIBehaviourProvider inst = instance;
		if (inst == null || inst.behaviours.isEmpty())
			return true;
		for (IUIBehaviour svc : inst.behaviours) {
			try {
				if (!svc.isFieldEditable(ctx, field, checkContext, isGrid))
					return false;
			} catch (Exception t) {
				log.log(Level.WARNING,
					"IUIBehaviour provider " + svc.getClass().getName()
					+ " threw in isFieldEditable; treating as neutral", t);
			}
		}
		return true;
	}
}
