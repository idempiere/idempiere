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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Consumer;
import java.util.function.Function;

/**
 * Asks the document defaults providers ({@link IOrderDefaultsProvider},
 * {@link IInvoiceDefaultsProvider}) in service ranking order, highest first, and returns the
 * first answer other than {@link DefaultValue#useFallback()}.
 * <p>
 * The providers are looked up once, when the instance is created: get a new instance from
 * {@link Core#getOrderDefaults()} or {@link Core#getInvoiceDefaults()} for each save.
 * With no provider registered every question returns useFallback.
 * @param <P> provider type
 */
public final class DocumentDefaults<P> {

	/** Service holders by provider type; a holder tracks providers registered later */
	private static final Map<Class<?>, IServicesHolder<?>> s_holders = new ConcurrentHashMap<>();

	private final List<P> providers;

	private DocumentDefaults(List<P> providers) {
		this.providers = providers;
	}

	/**
	 * @param type provider type
	 * @return defaults asking the providers registered now, highest service ranking first
	 */
	@SuppressWarnings("unchecked")
	static <P> DocumentDefaults<P> of(Class<P> type) {
		IServicesHolder<P> holder = (IServicesHolder<P>) s_holders.computeIfAbsent(type, t -> Service.locator().list(t));
		List<P> providers = new ArrayList<>();
		List<P> services = holder.getServices();
		if (services != null) {
			for (P service : services) {
				// null if the provider was unregistered meanwhile
				if (service != null)
					providers.add(service);
			}
		}
		return new DocumentDefaults<>(providers);
	}

	/**
	 * @param question asks one provider for a field value
	 * @return first answer other than useFallback, or useFallback
	 */
	public <V> DefaultValue<V> get(Function<P, DefaultValue<V>> question) {
		for (P provider : providers) {
			DefaultValue<V> answer = question.apply(provider);
			if (answer != null && !answer.isUseFallback())
				return answer;
		}
		return DefaultValue.useFallback();
	}

	/**
	 * Call every provider, in service ranking order
	 * @param action call on one provider
	 */
	public void forEach(Consumer<P> action) {
		for (P provider : providers)
			action.accept(provider);
	}
}
