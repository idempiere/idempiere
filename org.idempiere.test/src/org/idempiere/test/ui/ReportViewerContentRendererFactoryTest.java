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
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.adempiere.base.Core;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.ReportContentServiceProvider;
import org.adempiere.base.Service;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.report.jasper.JasperReportContentRendererFactory;
import org.compiere.print.ReportEngine;
import org.idempiere.print.IReportContentProcessor;
import org.idempiere.print.IReportContentRenderer;
import org.idempiere.print.IReportContentRendererFactory;
import org.idempiere.print.ReportContentRequest;
import org.idempiere.print.ReportContentType;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

public class ReportViewerContentRendererFactoryTest extends AbstractTestCase {

	@Test
	public void testHigherRankingFactoryTakesPrecedence() throws IOException {
		File highRankingContent = Files.createTempFile("high-ranking-report-content-", ".pdf").toFile();
		File lowRankingContent = Files.createTempFile("low-ranking-report-content-", ".pdf").toFile();
		IReportContentRenderer highRankingRenderer = new TestRenderer(highRankingContent);
		IReportContentRenderer lowRankingRenderer = new TestRenderer(lowRankingContent);
		IReportContentRendererFactory highRankingFactory = request -> highRankingRenderer;
		ServiceRegistration<IReportContentRendererFactory> highRankingRegistration =
				registerFactory(highRankingFactory, 20);
		ServiceRegistration<IReportContentRendererFactory> lowRankingRegistration =
				registerFactory(request -> lowRankingRenderer, 10);
		try {
			IReportContentRenderer renderer = Core.getReportContentRenderer(emptyRequest());
			assertNotNull(renderer);
			assertSame(highRankingContent, renderer.getContent("application/pdf", "pdf"));
		} finally {
			lowRankingContent.delete();
			highRankingContent.delete();
			lowRankingRegistration.unregister();
			highRankingRegistration.unregister();
		}
		assertFalse(List.of(ReportContentServiceProvider.getRendererFactories()).contains(highRankingFactory));
	}

	@Test
	public void testNullResultFallsBackToNextFactory() throws IOException {
		File fallbackContent = Files.createTempFile("fallback-report-content-", ".pdf").toFile();
		IReportContentRenderer fallbackRenderer = new TestRenderer(fallbackContent);
		ServiceRegistration<IReportContentRendererFactory> firstRegistration =
				registerFactory(request -> null, 20);
		ServiceRegistration<IReportContentRendererFactory> fallbackRegistration =
				registerFactory(request -> fallbackRenderer, 10);
		try {
			IReportContentRenderer renderer = Core.getReportContentRenderer(emptyRequest());
			assertNotNull(renderer);
			assertSame(fallbackContent, renderer.getContent("application/pdf", "pdf"));
		} finally {
			fallbackContent.delete();
			fallbackRegistration.unregister();
			firstRegistration.unregister();
		}
	}

	@Test
	public void testCoreJasperFactoryIsRegisteredAsFallback() {
		List<IServiceReferenceHolder<IReportContentRendererFactory>> references = Service.locator()
				.list(IReportContentRendererFactory.class).getServiceReferences();
		IServiceReferenceHolder<IReportContentRendererFactory> defaultReference = references.stream()
				.filter(reference -> reference.getService() instanceof JasperReportContentRendererFactory)
				.findFirst()
				.orElseThrow();

		assertEquals(0, defaultReference.getServiceReference().getProperty(Constants.SERVICE_RANKING));
		assertTrue(defaultReference.getService() instanceof JasperReportContentRendererFactory);
	}

	@Test
	public void testApplicableContentProcessorsRunInRankingOrder() throws IOException {
		List<Integer> calls = new ArrayList<>();
		ServiceRegistration<IReportContentProcessor> highRankingRegistration =
				registerProcessor(processor(true, 20, calls), 20);
		ServiceRegistration<IReportContentProcessor> notApplicableRegistration =
				registerProcessor(processor(false, 15, calls), 15);
		ServiceRegistration<IReportContentProcessor> lowRankingRegistration =
				registerProcessor(processor(true, 10, calls), 10);
		File content = Files.createTempFile("report-content-", ".pdf").toFile();
		try {
			assertSame(content, Core.processReportContent(emptyRequest(), "application/pdf", "pdf", content));
			assertEquals(List.of(20, 10), calls);
		} finally {
			content.delete();
			lowRankingRegistration.unregister();
			notApplicableRegistration.unregister();
			highRankingRegistration.unregister();
		}
	}

	@Test
	public void testContentProcessorMustReturnContent() throws IOException {
		IReportContentProcessor processor = new IReportContentProcessor() {
			@Override
			public boolean isApplicable(ReportContentRequest request, String contentType, String fileExtension) {
				return true;
			}

			@Override
			public File process(ReportContentRequest request, String contentType, String fileExtension, File input) {
				return null;
			}
		};
		ServiceRegistration<IReportContentProcessor> registration = registerProcessor(processor, 10);
		File content = Files.createTempFile("report-content-", ".pdf").toFile();
		try {
			assertThrows(AdempiereException.class,
					() -> Core.processReportContent(emptyRequest(), "application/pdf", "pdf", content));
		} finally {
			content.delete();
			registration.unregister();
		}
	}

	@Test
	public void testRendererCachesFinalContent() throws IOException {
		File content = Files.createTempFile("report-content-", ".pdf").toFile();
		IReportContentRenderer renderer = new TestRenderer() {
			@Override
			public File getContent(String contentType, String fileExtension) {
				return content;
			}
		};
		AtomicInteger calls = new AtomicInteger();
		IReportContentProcessor processor = new IReportContentProcessor() {
			@Override
			public boolean isApplicable(ReportContentRequest request, String contentType, String fileExtension) {
				return true;
			}

			@Override
			public File process(ReportContentRequest request, String contentType, String fileExtension, File input) {
				calls.incrementAndGet();
				return input;
			}
		};
		ServiceRegistration<IReportContentRendererFactory> factoryRegistration =
				registerFactory(request -> renderer, 20);
		ServiceRegistration<IReportContentProcessor> processorRegistration =
				registerProcessor(processor, 10);
		try {
			IReportContentRenderer processedRenderer = Core.getReportContentRenderer(emptyRequest());
			assertNotNull(processedRenderer);
			assertSame(content, processedRenderer.getContent("application/pdf", "pdf"));
			assertSame(content, processedRenderer.getContent("application/pdf", "pdf"));
			assertEquals(1, calls.get());
		} finally {
			content.delete();
			processorRegistration.unregister();
			factoryRegistration.unregister();
		}
	}

	@Test
	public void testPostProcessingIsEnabledByDefault() {
		assertTrue(emptyRequest().applyPostProcessing());
	}

	@Test
	public void testDisabledPostProcessingReturnsAndCachesOriginalContent() throws IOException {
		File content = Files.createTempFile("unprocessed-report-content-", ".pdf").toFile();
		AtomicInteger rendererCalls = new AtomicInteger();
		IReportContentRenderer renderer = new TestRenderer(content) {
			@Override
			public File getContent(String contentType, String fileExtension) {
				rendererCalls.incrementAndGet();
				return super.getContent(contentType, fileExtension);
			}
		};
		AtomicInteger processorCalls = new AtomicInteger();
		IReportContentProcessor processor = new IReportContentProcessor() {
			@Override
			public boolean isApplicable(ReportContentRequest request, String contentType, String fileExtension) {
				processorCalls.incrementAndGet();
				return true;
			}

			@Override
			public File process(ReportContentRequest request, String contentType, String fileExtension, File input) {
				processorCalls.incrementAndGet();
				return input;
			}
		};
		ServiceRegistration<IReportContentRendererFactory> factoryRegistration =
				registerFactory(request -> renderer, 20);
		ServiceRegistration<IReportContentProcessor> processorRegistration =
				registerProcessor(processor, 10);
		ReportContentRequest request = new ReportContentRequest(null, null, "Test", false);
		try {
			IReportContentRenderer cachedRenderer = Core.getReportContentRenderer(request);
			assertNotNull(cachedRenderer);
			assertSame(content, cachedRenderer.getContent("application/pdf", "pdf"));
			assertSame(content, cachedRenderer.getContent("application/pdf", "pdf"));
			assertEquals(1, rendererCalls.get());
			assertEquals(0, processorCalls.get());
			assertSame(content, Core.processReportContent(request, "application/pdf", "pdf", content));
			assertEquals(0, processorCalls.get());
		} finally {
			content.delete();
			processorRegistration.unregister();
			factoryRegistration.unregister();
		}
	}

	@Test
	public void testReportEngineIsUsedAsRendererFallback() {
		ReportEngine reportEngine = org.mockito.Mockito.mock(ReportEngine.class);
		ReportContentRequest request = new ReportContentRequest(reportEngine, null, "Test", false);

		IReportContentRenderer renderer = Core.getReportContentRenderer(request);
		assertNotNull(renderer);
		assertTrue(Arrays.stream(renderer.getSupportedContentTypes())
				.anyMatch(type -> ReportContentType.isInteractiveHTML(type.contentType())));
		assertNull(renderer.getContent(ReportContentType.HTML_INTERACTIVE_CONTENT_TYPE, "html"));
	}

	@Test
	public void testInteractiveHtmlUsesOwnPipelineCacheKey() throws IOException {
		File content = Files.createTempFile("interactive-report-content-", ".html").toFile();
		AtomicInteger rendererCalls = new AtomicInteger();
		IReportContentRenderer renderer = new TestRenderer() {
			@Override
			public File getContent(String contentType, String fileExtension) {
				rendererCalls.incrementAndGet();
				return content;
			}

			@Override
			public ReportContentType[] getSupportedContentTypes() {
				return new ReportContentType[] { new ReportContentType("Interactive HTML", "html",
						ReportContentType.HTML_INTERACTIVE_CONTENT_TYPE) };
			}
		};
		List<String> processedContentTypes = new ArrayList<>();
		IReportContentProcessor processor = new IReportContentProcessor() {
			@Override
			public boolean isApplicable(ReportContentRequest request, String contentType, String fileExtension) {
				return true;
			}

			@Override
			public File process(ReportContentRequest request, String contentType, String fileExtension, File input) {
				processedContentTypes.add(contentType);
				return input;
			}
		};
		ServiceRegistration<IReportContentRendererFactory> factoryRegistration =
				registerFactory(request -> renderer, 20);
		ServiceRegistration<IReportContentProcessor> processorRegistration = registerProcessor(processor, 10);
		try {
			IReportContentRenderer cachedRenderer = Core.getReportContentRenderer(emptyRequest());
			assertNotNull(cachedRenderer);
			assertSame(content, cachedRenderer.getContent("text/html", "html"));
			assertSame(content, cachedRenderer.getContent("text/html", "html"));
			assertSame(content, cachedRenderer.getContent(ReportContentType.HTML_INTERACTIVE_CONTENT_TYPE, "html"));
			assertSame(content, cachedRenderer.getContent(ReportContentType.HTML_INTERACTIVE_CONTENT_TYPE, "html"));
			assertEquals(2, rendererCalls.get());
			assertEquals(List.of("text/html", ReportContentType.HTML_INTERACTIVE_CONTENT_TYPE), processedContentTypes);
		} finally {
			content.delete();
			processorRegistration.unregister();
			factoryRegistration.unregister();
		}
	}

	private ServiceRegistration<IReportContentRendererFactory> registerFactory(
			IReportContentRendererFactory factory, int ranking) {
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		return TestActivator.context.registerService(IReportContentRendererFactory.class, factory, properties);
	}

	private ServiceRegistration<IReportContentProcessor> registerProcessor(
			IReportContentProcessor processor, int ranking) {
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		return TestActivator.context.registerService(IReportContentProcessor.class, processor, properties);
	}

	private IReportContentProcessor processor(boolean applicable, int marker, List<Integer> calls) {
		return new IReportContentProcessor() {
			@Override
			public boolean isApplicable(ReportContentRequest request, String contentType, String fileExtension) {
				return applicable;
			}

			@Override
			public File process(ReportContentRequest request, String contentType, String fileExtension, File input) {
				calls.add(marker);
				return input;
			}
		};
	}

	private ReportContentRequest emptyRequest() {
		return new ReportContentRequest(null, null, "Test");
	}

	private static class TestRenderer implements IReportContentRenderer {
		private final File content;

		private TestRenderer() {
			this(null);
		}

		private TestRenderer(File content) {
			this.content = content;
		}

		@Override
		public File getContent(String contentType, String fileExtension) {
			return content;
		}

		@Override
		public ReportContentType[] getSupportedContentTypes() {
			return new ReportContentType[0];
		}
	}
}
