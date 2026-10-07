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

import java.util.Objects;
import java.util.function.Supplier;

/**
 * Answer of a document defaults provider ({@link IOrderDefaultsProvider},
 * {@link IInvoiceDefaultsProvider}) for one field: a value, {@link #useFallback()} to let the
 * next provider or the built-in fallback decide, or {@link #noDefault()} to leave the field empty.
 * @param <V> field value type
 */
public final class DefaultValue<V> {

	private static final DefaultValue<?> USE_FALLBACK = new DefaultValue<>(null, true);
	private static final DefaultValue<?> NO_DEFAULT = new DefaultValue<>(null, false);

	private final V value;
	private final boolean useFallback;

	private DefaultValue(V value, boolean useFallback) {
		this.value = value;
		this.useFallback = useFallback;
	}

	/**
	 * @param value field value, not null
	 * @return answer setting the field to value
	 */
	public static <V> DefaultValue<V> of(V value) {
		return new DefaultValue<>(Objects.requireNonNull(value, "value"), false);
	}

	/**
	 * @return no opinion: ask the next provider, then apply the built-in fallback
	 */
	@SuppressWarnings("unchecked")
	public static <V> DefaultValue<V> useFallback() {
		return (DefaultValue<V>) USE_FALLBACK;
	}

	/**
	 * @return leave the field empty, skip the built-in fallback
	 */
	@SuppressWarnings("unchecked")
	public static <V> DefaultValue<V> noDefault() {
		return (DefaultValue<V>) NO_DEFAULT;
	}

	/**
	 * @return true if the built-in fallback decides
	 */
	public boolean isUseFallback() {
		return useFallback;
	}

	/**
	 * @return true if the field is left empty
	 */
	public boolean isNoDefault() {
		return !useFallback && value == null;
	}

	/**
	 * @return value, or null for {@link #useFallback()} and {@link #noDefault()}
	 */
	public V getValue() {
		return value;
	}

	/**
	 * @param fallback built-in fallback, called only for {@link #useFallback()}
	 * @return value, fallback value for {@link #useFallback()}, or null for {@link #noDefault()}
	 */
	public V resolve(Supplier<V> fallback) {
		return useFallback ? fallback.get() : value;
	}

	@Override
	public String toString() {
		return useFallback ? "DefaultValue[useFallback]" : value == null ? "DefaultValue[noDefault]" : "DefaultValue[" + value + "]";
	}
}
