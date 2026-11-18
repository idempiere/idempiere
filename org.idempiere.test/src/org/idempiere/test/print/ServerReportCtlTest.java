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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         							       *
 **********************************************************************/
package org.idempiere.test.print;

import java.awt.Font;
import java.awt.Graphics;
import java.awt.GraphicsEnvironment;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.Pageable;
import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;

import org.adempiere.pdf.Document;
import org.compiere.model.MOrder;
import org.compiere.model.MSysConfig;
import org.compiere.process.ProcessInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.print.ServerReportCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.osgi.framework.Bundle;
import org.osgi.framework.FrameworkUtil;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class ServerReportCtlTest extends AbstractTestCase {

	/**
	 * Test order print
	 */
	@Test
	public void testOrderPrint() {
		// Verify MOrder 102 exists
		MOrder order = new MOrder(Env.getCtx(), 102, getTrxName());
		assertEquals(102, order.get_ID(), "Order 102 not found");
		
		// Order_Header  ** TEMPLATE ** | C_Order_Header_v | 100
		MPrintFormat format = MPrintFormat.get(100);				
		assertNotNull(format, "Print Format 'Order_Header  ** TEMPLATE **' not found");
        assertEquals(100, format.get_ID(), "Print Format 'Order_Header  ** TEMPLATE **' not found");
		
		// Prepare ProcessInfo
		ProcessInfo pi = new ProcessInfo("Test Order Print", 0);
		pi.setRecord_ID(order.get_ID());
		pi.setTable_ID(order.get_Table_ID());
		pi.setIsBatch(true);
		pi.setPrintPreview(true);
		pi.setPDFReport(null);
		
		boolean result = ServerReportCtl.startDocumentPrint(ReportEngine.ORDER, format, order.get_ID(), null, pi);
		
		assertTrue(result, "ServerReportCtl.startDocumentPrint failed");
		File pdf = pi.getPDFReport();
		assertNotNull(pdf, "PDF Report was not generated");
		assertTrue(pdf.exists(), "PDF Report file does not exist");
		assertTrue(pdf.length() > 0, "PDF Report file is empty");
	}

	/**
	 * Test Document PDF rendering with empty and custom PDF_FONT_DIR values, custom TTF font registration/embedding, and CacheReset reload
	 */
	@Test
	public void testCustomPdfFontDirectory() throws Exception {
		Path tempFontDir = Files.createTempDirectory("idempiere-pdf-fonts");
		Path invalidFont = tempFontDir.resolve("invalid.ttf");
		Path validFont = tempFontDir.resolve("LiberationSans-Regular.ttf");
		try {
			Files.writeString(invalidFont, "not a font", StandardCharsets.UTF_8);
			Pageable defaultPageable = createSinglePagePageable(null);

			try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
				mocked.when(() -> MSysConfig.getValue(MSysConfig.PDF_FONT_DIR, "")).thenReturn("");
				Document.registerCustomAwtFonts();
				byte[] defaultPdf = Document.getPDFAsArray(defaultPageable);
				assertNotNull(defaultPdf, "PDF with default font directory should not be null");
				assertTrue(new String(defaultPdf, 0, Math.min(defaultPdf.length, 5), StandardCharsets.US_ASCII).startsWith("%PDF-"));

				// Prime cache for tempFontDir before adding the valid TTF font
				mocked.when(() -> MSysConfig.getValue(MSysConfig.PDF_FONT_DIR, "")).thenReturn(tempFontDir.toString());
				Document.registerCustomAwtFonts();
				byte[] customDirPdf = Document.getPDFAsArray(defaultPageable);
				assertNotNull(customDirPdf, "PDF with custom font directory should not be null");
				assertTrue(new String(customDirPdf, 0, Math.min(customDirPdf.length, 5), StandardCharsets.US_ASCII).startsWith("%PDF-"));

				// Copy a valid TTF font into the already-cached directory and trigger CacheReset
				copyLiberationSansRegular(validFont);
				Font expectedFont = Font.createFont(Font.TRUETYPE_FONT, validFont.toFile());
				CacheMgt.get().reset(MSysConfig.Table_Name);

				Document.registerCustomAwtFonts();
				assertTrue(Arrays.asList(GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames())
						.contains(expectedFont.getFamily()), "Custom font family should be registered in AWT GraphicsEnvironment");

				Pageable customFontPageable = createSinglePagePageable(new Font(expectedFont.getFamily(), Font.PLAIN, 12));
				byte[] embeddedPdf = Document.getPDFAsArray(customFontPageable);
				assertNotNull(embeddedPdf, "PDF using custom TTF font should not be null");
				String pdfText = new String(embeddedPdf, StandardCharsets.ISO_8859_1);
				assertTrue(pdfText.startsWith("%PDF-"), "Output should be a valid PDF");
				assertTrue(pdfText.contains("LiberationSans"), "Generated PDF should embed/reference LiberationSans font");
			}
		} finally {
			Files.deleteIfExists(validFont);
			Files.deleteIfExists(invalidFont);
			Files.deleteIfExists(tempFontDir);
		}
	}

	private static Pageable createSinglePagePageable(Font font) {
		return new Pageable() {
			private final PageFormat format = new PageFormat();
			@Override
			public int getNumberOfPages() {
				return 1;
			}
			@Override
			public PageFormat getPageFormat(int pageIndex) {
				return format;
			}
			@Override
			public Printable getPrintable(int pageIndex) {
				return (Graphics g, PageFormat pf, int idx) -> {
					if (font != null) {
						g.setFont(font);
					}
					g.drawString("Font test", 50, 50);
					return Printable.PAGE_EXISTS;
				};
			}
		};
	}

	private static void copyLiberationSansRegular(Path destination) throws Exception {
		Bundle docBundle = FrameworkUtil.getBundle(Document.class);
		if (docBundle != null && docBundle.getBundleContext() != null) {
			for (Bundle bundle : docBundle.getBundleContext().getBundles()) {
				if ("com.github.librepdf.openpdf-fonts-extra".equals(bundle.getSymbolicName())) {
					URL entry = bundle.getEntry("liberation/LiberationSans-Regular.ttf");
					if (entry != null) {
						try (InputStream in = entry.openStream()) {
							Files.copy(in, destination);
							return;
						}
					}
				}
			}
		}
		Path fallback = Path.of("../org.adempiere.ui.zk/WEB-INF/src/web/js/pdf.js/web/standard_fonts/LiberationSans-Regular.ttf");
		Files.copy(fallback, destination);
	}
}
