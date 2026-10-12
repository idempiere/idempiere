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
package org.idempiere.ui.zk.report;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.osgi.framework.Constants;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * OSGi component that collects the {@link IReportFormatSelectorFactory} services in service ranking order.
 */
@Component(immediate = true, service = {ReportFormatSelectorProvider.class})
public class ReportFormatSelectorProvider {

	private static volatile ReportFormatSelectorProvider instance;

	private final List<RankedFactory> holders = new ArrayList<>();
	private volatile IReportFormatSelectorFactory[] factories = new IReportFormatSelectorFactory[0];

	/**
	 * Make this provider available to {@link #getFactories()}
	 */
	@Activate
	public void activate() {
		instance = this;
	}

	/**
	 * Remove this provider from {@link #getFactories()}
	 */
	@Deactivate
	public void deactivate() {
		if (instance == this)
			instance = null;
	}

	/**
	 * Bind a factory
	 * @param factory factory to add
	 * @param properties service properties, used for the ranking
	 */
	@Reference(
		service = IReportFormatSelectorFactory.class,
		cardinality = ReferenceCardinality.MULTIPLE,
		policy = ReferencePolicy.DYNAMIC,
		unbind = "unbindFactory"
	)
	public synchronized void bindFactory(IReportFormatSelectorFactory factory, Map<String, Object> properties) {
		if (factory == null || holders.stream().anyMatch(h -> h.factory == factory))
			return;
		holders.add(new RankedFactory(factory, properties));
		holders.sort(null);
		factories = holders.stream().map(h -> h.factory).toArray(IReportFormatSelectorFactory[]::new);
	}

	/**
	 * Unbind a factory
	 * @param factory factory to remove
	 */
	public synchronized void unbindFactory(IReportFormatSelectorFactory factory) {
		if (holders.removeIf(h -> h.factory == factory))
			factories = holders.stream().map(h -> h.factory).toArray(IReportFormatSelectorFactory[]::new);
	}

	/**
	 * Get the bound factories
	 * @return factories, highest service ranking first. Empty if none
	 */
	public static IReportFormatSelectorFactory[] getFactories() {
		ReportFormatSelectorProvider provider = instance;
		return provider != null ? provider.factories.clone() : new IReportFormatSelectorFactory[0];
	}

	private static final class RankedFactory implements Comparable<RankedFactory> {
		private final IReportFormatSelectorFactory factory;
		private final int ranking;
		private final long serviceId;

		private RankedFactory(IReportFormatSelectorFactory factory, Map<String, Object> properties) {
			this.factory = factory;
			Object rank = properties != null ? properties.get(Constants.SERVICE_RANKING) : null;
			ranking = rank instanceof Number number ? number.intValue() : 0;
			Object id = properties != null ? properties.get(Constants.SERVICE_ID) : null;
			serviceId = id instanceof Number number ? number.longValue() : Long.MAX_VALUE;
		}

		@Override
		public int compareTo(RankedFactory other) {
			int result = Integer.compare(other.ranking, ranking);
			return result != 0 ? result : Long.compare(serviceId, other.serviceId);
		}
	}
}
