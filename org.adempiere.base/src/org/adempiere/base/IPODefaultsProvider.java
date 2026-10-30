/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or      *
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

import org.compiere.model.PO;

/**
 * Supplies defaults for the records of one table.
 * <p>
 * Register the component with the table it serves, the same way column callouts are selected:
 * <pre>
 * &#64;Component(service = IPODefaultsProvider.class, property = "tableName=C_Order")
 * </pre>
 * Only providers registered for the table of the record are asked, see
 * {@link Core#getPODefaults(String)}. Providers are asked in service ranking order, highest first.
 * <p>
 * The model decides where it asks: {@link #initDefaults(PO)} at the end of its initial values
 * for a new record, and {@link #getDefault(PO, String)} in {@code beforeSave} where it has a
 * built-in fallback for an empty column. A table whose model does not ask ignores its providers.
 * <p>
 * Event handlers cannot do this: {@code PO_BEFORE_NEW} fires after the model's
 * {@code beforeSave}, by which time the built-in fallbacks have already filled the column.
 */
public interface IPODefaultsProvider {

	/**
	 * Called by the model at the end of its initial values for a new record. Only the context
	 * (client, org, user) is known here. A provider may overwrite initial values, or clear one
	 * so that it is resolved in {@code beforeSave} through {@link #getDefault(PO, String)}.
	 * A mandatory column is cleared with {@code po.set_ValueNoCheck(columnName, null)}: the
	 * generated setters refuse null on a mandatory column and leave a FillMandatory error that
	 * fails the save.
	 * <p>
	 * Runs inside the model constructor: a subclass of the model is not yet initialized, so only
	 * call setters on {@code po}. All providers are called, lowest service ranking first, so the
	 * highest ranking provider runs last and its values are kept.
	 * @param po new record
	 */
	default void initDefaults(PO po) {
	}

	/**
	 * Called by the model in {@code beforeSave} while the column is still empty.
	 * The value type is the column's Java type (Integer for record ids, String for lists).
	 * @param po record being saved
	 * @param columnName column to default
	 * @return {@link DefaultValue#of(Object)}, {@link DefaultValue#useFallback()} to let the next
	 * provider or the built-in fallback decide, or {@link DefaultValue#noDefault()} to leave the
	 * column empty
	 */
	default DefaultValue<?> getDefault(PO po, String columnName) {
		return DefaultValue.useFallback();
	}
}
