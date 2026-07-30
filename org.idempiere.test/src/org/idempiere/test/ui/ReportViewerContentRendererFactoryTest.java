/**********************************************************************
 * This file is part of iDempiere ERP Open Source                     *
 * http://www.idempiere.org                                           *
 *                                                                    *
 * Copyright (C) Contributors                                         *
 *                                                                    *
 * This program is free software; you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2     *
 * of the License, or (at your option) any later version.              *
 **********************************************************************/
package org.idempiere.test.ui;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.Core;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.idempiere.print.IReportContentRenderer;
import org.idempiere.print.IReportContentRendererFactory;
import org.idempiere.print.ReportContentRequest;
import org.idempiere.print.ReportContentType;
import org.idempiere.ui.zk.report.JasperReportViewerContentRendererFactory;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

public class ReportViewerContentRendererFactoryTest extends AbstractTestCase {

	@Test
	public void testHigherRankingFactoryTakesPrecedence() {
		IReportContentRenderer highRankingRenderer = new TestRenderer();
		IReportContentRenderer lowRankingRenderer = new TestRenderer();
		ServiceRegistration<IReportContentRendererFactory> highRankingRegistration =
				registerFactory(request -> highRankingRenderer, 20);
		ServiceRegistration<IReportContentRendererFactory> lowRankingRegistration =
				registerFactory(request -> lowRankingRenderer, 10);
		try {
			assertSame(highRankingRenderer, Core.getReportContentRenderer(emptyRequest()));
		} finally {
			lowRankingRegistration.unregister();
			highRankingRegistration.unregister();
		}
	}

	@Test
	public void testNullResultFallsBackToNextFactory() {
		IReportContentRenderer fallbackRenderer = new TestRenderer();
		ServiceRegistration<IReportContentRendererFactory> firstRegistration =
				registerFactory(request -> null, 20);
		ServiceRegistration<IReportContentRendererFactory> fallbackRegistration =
				registerFactory(request -> fallbackRenderer, 10);
		try {
			assertSame(fallbackRenderer, Core.getReportContentRenderer(emptyRequest()));
		} finally {
			fallbackRegistration.unregister();
			firstRegistration.unregister();
		}
	}

	@Test
	public void testCoreJasperFactoryIsRegisteredAsFallback() {
		List<IServiceReferenceHolder<IReportContentRendererFactory>> references = Service.locator()
				.list(IReportContentRendererFactory.class).getServiceReferences();
		IServiceReferenceHolder<IReportContentRendererFactory> defaultReference = references.stream()
				.filter(reference -> reference.getService() instanceof JasperReportViewerContentRendererFactory)
				.findFirst()
				.orElseThrow();

		assertEquals(0, defaultReference.getServiceReference().getProperty(Constants.SERVICE_RANKING));
		assertTrue(defaultReference.getService() instanceof JasperReportViewerContentRendererFactory);
	}

	private ServiceRegistration<IReportContentRendererFactory> registerFactory(
			IReportContentRendererFactory factory, int ranking) {
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		return TestActivator.context.registerService(IReportContentRendererFactory.class, factory, properties);
	}

	private ReportContentRequest emptyRequest() {
		return new ReportContentRequest(null, null, null, "Test");
	}

	private static final class TestRenderer implements IReportContentRenderer {
		@Override
		public java.io.File getContent(String contentType, String fileExtension) {
			return null;
		}

		@Override
		public ReportContentType[] getSupportedContentTypes() {
			return new ReportContentType[0];
		}
	}
}
