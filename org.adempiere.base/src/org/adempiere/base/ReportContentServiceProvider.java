/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) Contributors                                                 *
 *                                                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 *****************************************************************************/
package org.adempiere.base;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.idempiere.print.IReportContentProcessor;
import org.idempiere.print.IReportContentRendererFactory;
import org.osgi.framework.Constants;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * Declarative Services bridge for dynamically registered report content
 * factories and processors.
 */
@Component(name = "org.adempiere.base.ReportContentServiceProvider", immediate = true, service = {})
public class ReportContentServiceProvider {

	private static final IReportContentRendererFactory[] EMPTY_FACTORIES = new IReportContentRendererFactory[0];
	private static final IReportContentProcessor[] EMPTY_PROCESSORS = new IReportContentProcessor[0];
	private static volatile ReportContentServiceProvider instance;

	private final List<ServiceHolder<IReportContentRendererFactory>> rendererFactoryHolders = new ArrayList<>();
	private final List<ServiceHolder<IReportContentProcessor>> processorHolders = new ArrayList<>();
	private volatile IReportContentRendererFactory[] rendererFactories = EMPTY_FACTORIES;
	private volatile IReportContentProcessor[] processors = EMPTY_PROCESSORS;

	@Activate
	public void activate() {
		instance = this;
	}

	@Deactivate
	public void deactivate() {
		if (instance == this)
			instance = null;
	}

	@Reference(
			name = "IReportContentRendererFactory",
			service = IReportContentRendererFactory.class,
			cardinality = ReferenceCardinality.MULTIPLE,
			policy = ReferencePolicy.DYNAMIC,
			unbind = "unbindRendererFactory")
	public synchronized void bindRendererFactory(IReportContentRendererFactory factory,
			Map<String, Object> properties) {
		if (factory == null || rendererFactoryHolders.stream().anyMatch(holder -> holder.service == factory))
			return;
		rendererFactoryHolders.add(new ServiceHolder<>(factory, properties));
		rendererFactoryHolders.sort(null);
		rendererFactories = rendererFactoryHolders.stream()
				.map(holder -> holder.service)
				.toArray(IReportContentRendererFactory[]::new);
	}

	public synchronized void unbindRendererFactory(IReportContentRendererFactory factory) {
		if (rendererFactoryHolders.removeIf(holder -> holder.service == factory)) {
			rendererFactories = rendererFactoryHolders.stream()
					.map(holder -> holder.service)
					.toArray(IReportContentRendererFactory[]::new);
		}
	}

	@Reference(
			name = "IReportContentProcessor",
			service = IReportContentProcessor.class,
			cardinality = ReferenceCardinality.MULTIPLE,
			policy = ReferencePolicy.DYNAMIC,
			unbind = "unbindProcessor")
	public synchronized void bindProcessor(IReportContentProcessor processor, Map<String, Object> properties) {
		if (processor == null || processorHolders.stream().anyMatch(holder -> holder.service == processor))
			return;
		processorHolders.add(new ServiceHolder<>(processor, properties));
		processorHolders.sort(null);
		processors = processorHolders.stream()
				.map(holder -> holder.service)
				.toArray(IReportContentProcessor[]::new);
	}

	public synchronized void unbindProcessor(IReportContentProcessor processor) {
		if (processorHolders.removeIf(holder -> holder.service == processor)) {
			processors = processorHolders.stream()
					.map(holder -> holder.service)
					.toArray(IReportContentProcessor[]::new);
		}
	}

	/**
	 * Gets the currently bound renderer factories in OSGi service order.
	 *
	 * @return renderer factories, highest ranking first
	 */
	public static IReportContentRendererFactory[] getRendererFactories() {
		ReportContentServiceProvider provider = instance;
		return provider != null ? provider.rendererFactories.clone() : EMPTY_FACTORIES;
	}

	/**
	 * Gets the currently bound processors in OSGi service order.
	 *
	 * @return processors, highest ranking first
	 */
	public static IReportContentProcessor[] getProcessors() {
		ReportContentServiceProvider provider = instance;
		return provider != null ? provider.processors.clone() : EMPTY_PROCESSORS;
	}

	private static final class ServiceHolder<T> implements Comparable<ServiceHolder<T>> {
		private final T service;
		private final int ranking;
		private final long serviceId;

		private ServiceHolder(T service, Map<String, Object> properties) {
			this.service = service;
			ranking = intProperty(properties, Constants.SERVICE_RANKING, 0);
			serviceId = longProperty(properties, Constants.SERVICE_ID, Long.MAX_VALUE);
		}

		@Override
		public int compareTo(ServiceHolder<T> other) {
			int result = Integer.compare(other.ranking, ranking);
			return result != 0 ? result : Long.compare(serviceId, other.serviceId);
		}

		private static int intProperty(Map<String, Object> properties, String name, int defaultValue) {
			Object value = properties != null ? properties.get(name) : null;
			return value instanceof Number number ? number.intValue() : defaultValue;
		}

		private static long longProperty(Map<String, Object> properties, String name, long defaultValue) {
			Object value = properties != null ? properties.get(name) : null;
			return value instanceof Number number ? number.longValue() : defaultValue;
		}
	}
}
