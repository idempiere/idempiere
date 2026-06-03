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
 *  - whether a lookup is cacheable (e.g. disable cache when a plugin depends
 *    on a dynamic context that may change at runtime)
 *  - whether a tab is editable (e.g. workflow approval, role-based read-only)
 *  - whether a single field is editable (e.g. PII masking for certain roles,
 *    license-based feature gating)
 *
 * All methods return a nullable Boolean: returning null means "not relevant
 * for this case" and does not alter the framework's aggregated decision.
 *
 * Implementations must be registered via OSGi Declarative Services as
 * providers of this interface. The core helper {@link UIBehaviour} iterates
 * all registered providers and aggregates their answers with AND logic.
 */
public interface IUIBehaviour
{
	/**
	 * Allow caching of the lookup. The lookup cache is enabled only if EVERY
	 * registered provider allows it.
	 *
	 * @param lookup     the lookup being evaluated
	 * @param lookupInfo the lookup info (may be null)
	 * @return null when not relevant, true to allow cache, false to disable
	 */
	public Boolean isLookupCacheable(Lookup lookup, MLookupInfo lookupInfo);

	/**
	 * Additional check on tab editability. The tab is editable only if EVERY
	 * registered provider allows it.
	 *
	 * @param ctx current context
	 * @param tab the tab being evaluated
	 * @return null when not relevant, true to allow edit, false to deny
	 */
	public Boolean isEditable(Properties ctx, GridTab tab);

	/**
	 * Additional check on field editability. The field is editable only if
	 * EVERY registered provider allows it.
	 *
	 * @param ctx          current context
	 * @param field        the field being evaluated
	 * @param checkContext pass-through flag from GridField.isEditable
	 * @param isGrid       pass-through flag from GridField.isEditable
	 * @return null when not relevant, true to allow edit, false to deny
	 */
	public Boolean isEditable(Properties ctx, GridField field,
	                          boolean checkContext, boolean isGrid);
}
