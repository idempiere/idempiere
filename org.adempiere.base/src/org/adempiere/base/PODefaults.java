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
import java.util.logging.Level;

import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.util.CLogger;

/**
 * Asks the {@link IPODefaultsProvider}s registered for one table in service ranking order,
 * highest first, and returns the first answer other than {@link DefaultValue#useFallback()}.
 * <p>
 * The providers are looked up once, when the instance is created: get a new instance from
 * {@link Core#getPODefaults(String)} for each save.
 * With no provider registered every question returns useFallback.
 */
public final class PODefaults {

	/** Service property that selects the table of a provider */
	public static final String TABLE_NAME_PROPERTY = "tableName";

	private static final CLogger s_log = CLogger.getCLogger(PODefaults.class);

	/** Service holders by table name; a holder tracks providers registered later */
	private static final Map<String, IServicesHolder<IPODefaultsProvider>> s_holders = new ConcurrentHashMap<>();

	/** Shared instance for a table with no provider registered */
	private static final PODefaults NONE = new PODefaults(List.of());

	private final List<IPODefaultsProvider> providers;

	/** Dictionary of the table, looked up when a first answer has to be checked */
	private POInfo poInfo;

	private PODefaults(List<IPODefaultsProvider> providers) {
		this.providers = providers;
	}

	/**
	 * @param tableName table name
	 * @return defaults asking the providers registered now for the table, highest service ranking first
	 */
	public static PODefaults of(String tableName) {
		IServicesHolder<IPODefaultsProvider> holder = s_holders.computeIfAbsent(tableName, t -> {
			ServiceQuery query = new ServiceQuery();
			query.put(TABLE_NAME_PROPERTY, t);
			return Service.locator().list(IPODefaultsProvider.class, query);
		});
		List<IPODefaultsProvider> services = holder.getServices();
		if (services == null || services.isEmpty())
			return NONE;
		List<IPODefaultsProvider> providers = new ArrayList<>(services.size());
		for (IPODefaultsProvider service : services) {
			// null if the provider was unregistered meanwhile
			if (service != null)
				providers.add(service);
		}
		return providers.isEmpty() ? NONE : new PODefaults(providers);
	}

	/**
	 * @param po record being saved
	 * @param columnName column to default
	 * @return first answer other than useFallback, or useFallback.
	 * The value type V must be the column's class ({@link POInfo#getColumnClass(int)}): an answer
	 * whose value is not of that class is logged and skipped. A value is also skipped when the class
	 * cannot be checked (unknown column, or a column class of Object).
	 * A provider that throws is logged and skipped.
	 */
	@SuppressWarnings("unchecked")
	public <V> DefaultValue<V> get(PO po, String columnName) {
		Class<?> columnClass = null;
		boolean checkable = false;
		boolean classLookedUp = false;
		for (IPODefaultsProvider provider : providers) {
			DefaultValue<?> answer;
			try {
				answer = provider.getDefault(po, columnName);
			} catch (RuntimeException e) {
				s_log.log(Level.WARNING, provider.getClass().getName() + " failed for " + po.get_TableName() + "." + columnName, e);
				continue;
			}
			if (answer == null || answer.isUseFallback())
				continue;
			if (answer.getValue() != null && !classLookedUp) {
				if (poInfo == null)
					poInfo = POInfo.getPOInfo(po.getCtx(), po.get_Table_ID());
				columnClass = poInfo.getColumnClass(poInfo.getColumnIndex(columnName));
				// Object accepts any value, so it cannot guard the cast to V
				checkable = columnClass != null && columnClass != Object.class;
				classLookedUp = true;
			}
			if (answer.getValue() != null && (!checkable || !columnClass.isInstance(answer.getValue()))) {
				s_log.log(Level.WARNING, provider.getClass().getName() + " returned " + answer.getValue().getClass().getName()
						+ " for " + po.get_TableName() + "." + columnName + ", expected "
						+ (checkable ? columnClass.getName() : "a column with a known class"));
				continue;
			}
			return (DefaultValue<V>) answer;
		}
		return DefaultValue.useFallback();
	}

	/**
	 * Call every provider, lowest service ranking first, so that when two providers set the same
	 * column the value of the highest ranking provider is kept.
	 * A provider that throws is logged and skipped.
	 * @param action call on one provider
	 */
	public void forEach(Consumer<IPODefaultsProvider> action) {
		for (int i = providers.size() - 1; i >= 0; i--) {
			IPODefaultsProvider provider = providers.get(i);
			try {
				action.accept(provider);
			} catch (RuntimeException e) {
				s_log.log(Level.WARNING, provider.getClass().getName() + " failed", e);
			}
		}
	}
}
