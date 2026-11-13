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
package org.idempiere.test.print;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.awt.Font;
import java.awt.GraphicsEnvironment;
import java.io.InputStream;
import java.net.URL;

import org.compiere.print.MPrintTableFormat;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Bundle;
import org.osgi.framework.FrameworkUtil;

/**
 * The fonts a table format derives from its standard font (table header, totals, parameters, page header) must keep
 * the requested style when the standard font is one face of a family, such as "Liberation Sans Italic" or
 * "Helvetica Neue Medium". Fonts registered with {@link GraphicsEnvironment#registerFont(Font)} are found by face
 * name only, so {@code new Font(faceName, Font.BOLD, size)} returns the same face without bold.
 */
public class MPrintTableFormatFontTest extends AbstractTestCase {

	private static final String FONTS_BUNDLE = "com.github.librepdf.openpdf-fonts-extra";
	private static final String[] FACES = { "LiberationSans-Regular.ttf", "LiberationSans-Bold.ttf",
			"LiberationSans-Italic.ttf", "LiberationSans-BoldItalic.ttf" };

	/** Registers the Liberation Sans faces the way a plug-in registers its print fonts. */
	@BeforeAll
	public static void registerFaces() throws Exception {
		Bundle fonts = null;
		for (Bundle bundle : FrameworkUtil.getBundle(MPrintTableFormatFontTest.class).getBundleContext().getBundles()) {
			if (FONTS_BUNDLE.equals(bundle.getSymbolicName()))
				fonts = bundle;
		}
		assertNotNull(fonts, FONTS_BUNDLE + " not found");
		for (String face : FACES) {
			URL url = fonts.getEntry("liberation/" + face);
			assertNotNull(url, face + " not found in " + FONTS_BUNDLE);
			try (InputStream in = url.openStream()) {
				GraphicsEnvironment.getLocalGraphicsEnvironment().registerFont(Font.createFont(Font.TRUETYPE_FONT, in));
			}
		}
	}

	@Test
	public void testStyleFromFaceUsesFamily() {
		Font italic = new Font("Liberation Sans Italic", Font.PLAIN, 10);
		assertEquals("Liberation Sans Italic", italic.getFontName(), "Liberation Sans not registered");

		assertEquals("Liberation Sans Bold", MPrintTableFormat.deriveFont(italic, Font.BOLD, 10).getFontName());
		assertEquals("Liberation Sans Bold Italic",
				MPrintTableFormat.deriveFont(italic, Font.BOLD | Font.ITALIC, 10).getFontName());
		// the requested style is already the face's own style
		assertEquals("Liberation Sans Italic", MPrintTableFormat.deriveFont(italic, Font.ITALIC, 10).getFontName());
		// plain keeps the face, as the page footer did before
		assertEquals("Liberation Sans Italic", MPrintTableFormat.deriveFont(italic, Font.PLAIN, 8).getFontName());
	}

	@Test
	public void testStyleFromFamilyIsUnchanged() {
		Font regular = new Font("Liberation Sans", Font.PLAIN, 10);
		assertEquals("Liberation Sans Bold", MPrintTableFormat.deriveFont(regular, Font.BOLD, 10).getFontName());
		assertEquals("Liberation Sans Bold Italic",
				MPrintTableFormat.deriveFont(regular, Font.BOLD | Font.ITALIC, 10).getFontName());

		Font logical = new Font("SansSerif", Font.PLAIN, 10);
		assertEquals(new Font("SansSerif", Font.BOLD, 10), MPrintTableFormat.deriveFont(logical, Font.BOLD, 10));
	}

	@Test
	public void testTableFormatFonts() {
		MPrintTableFormat tf = new MPrintTableFormat(Env.getCtx(), 0, getTrxName());
		tf.setStandard_Font(new Font("Liberation Sans Italic", Font.PLAIN, 9));
		assertEquals("Liberation Sans Bold", tf.getHeader_Font().getFontName());
		assertEquals("Liberation Sans Bold Italic", tf.getFunct_Font().getFontName());
		assertEquals("Liberation Sans Bold", tf.getPageHeader_Font().getFontName());
		assertEquals(9, tf.getFunct_Font().getSize());
	}
}
