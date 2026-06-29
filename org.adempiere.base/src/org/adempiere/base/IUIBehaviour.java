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

import java.util.Properties;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.Lookup;
import org.compiere.model.MLookupInfo;

/**
 * IDEMPIERE-7024
 * OSGi extension point that lets a plugin participate in three UI decisions:
 *  - lookup cache partitioning via {@link #getLookupCacheKeySuffix}
 *  - whether a tab is editable (e.g. workflow approval, role-based read-only)
 *  - whether a single field is editable (e.g. PII masking for certain roles,
 *    license-based feature gating)
 *
 * <h3>Lookup cache</h3>
 * A non-null suffix appended to the cache key creates an isolated cache bucket
 * (e.g. one per history date) using the existing {@link org.compiere.util.CCache}
 * infrastructure — caching stays active, just partitioned.
 * Returning {@code null} (the default) is a no-op with zero overhead.
 *
 * <h3>Veto semantics</h3>
 * Boolean methods use veto semantics: return true when not relevant (neutral/allow),
 * false to deny. The aggregator in {@link UIBehaviourProvider} returns false as soon
 * as any provider returns false.
 *
 * Implementations must be registered via OSGi Declarative Services as
 * providers of this interface. The core helper {@link UIBehaviourProvider} iterates
 * all registered providers and aggregates their answers with AND logic.
 */
public interface IUIBehaviour
{
	/**
	 * Return a suffix appended to the lookup cache key to create an isolated cache
	 * bucket, or {@code null} to use the standard key.
	 * <p>
	 * Example: a time-machine provider returns {@code "HST@2026-06-23"} so each
	 * history date gets its own cache partition while caching stays active.
	 * In normal (non-time-travel) mode the provider returns {@code null} — zero
	 * overhead, identical to vanilla iDempiere.
	 *
	 * @param lookup     the lookup being evaluated
	 * @param lookupInfo the lookup info (may be null)
	 * @return null to use the standard cache key, or a non-empty string to partition
	 */
	default String getLookupCacheKeySuffix(Lookup lookup, MLookupInfo lookupInfo) {
		return null;
	}

	/**
	 * Additional check on tab editability. The tab is editable only if EVERY
	 * registered provider allows it.
	 *
	 * @param ctx current context
	 * @param tab the tab being evaluated
	 * @return true to allow edit (or when not relevant), false to deny
	 */
	public boolean isTabEditable(Properties ctx, GridTab tab);

	/**
	 * Additional check on field editability. The field is editable only if
	 * EVERY registered provider allows it.
	 *
	 * @param ctx          current context
	 * @param field        the field being evaluated
	 * @param checkContext pass-through flag from GridField.isEditable
	 * @param isGrid       pass-through flag from GridField.isEditable
	 * @return true to allow edit (or when not relevant), false to deny
	 */
	public boolean isFieldEditable(Properties ctx, GridField field,
	                               boolean checkContext, boolean isGrid);
}
