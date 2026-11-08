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
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.spy;

import java.io.Serializable;
import java.util.ArrayList;

import org.apache.ecs.xhtml.td;
import org.compiere.model.MStyle;
import org.compiere.model.MStyleLine;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.print.renderer.HTMLReportRenderer;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * Test of the style variable substitution in {@link HTMLReportRenderer#setStyle(PrintData, org.apache.ecs.MultiPartElement, MStyle)}
 */
public class HTMLReportRendererStyleTest extends AbstractTestCase {

	private String render(String inlineStyle, String fieldValue) {
		PrintData printData = new PrintData(Env.getCtx(), "Test");
		ArrayList<Serializable> nodes = new ArrayList<>();
		nodes.add(new PrintDataElement(0, "Field", fieldValue, DisplayType.String, null));
		printData.addRow(false, 0, nodes);
		printData.setRowIndex(0);

		MStyleLine line = new MStyleLine(Env.getCtx(), 0, null);
		line.setInlineStyle(inlineStyle);
		MStyle style = spy(new MStyle(Env.getCtx(), 0, null));
		doReturn(1).when(style).getAD_Style_ID();
		doReturn(new MStyleLine[] {line}).when(style).getStyleLines();

		td element = new td();
		HTMLReportRenderer.setStyle(printData, element, style);
		return element.toString();
	}

	@Test
	public void testVariableIsReplaced() {
		assertTrue(render("color: @Field@", "red").contains("style=\"color: red\""));
	}

	@Test
	public void testValueCannotBreakOutOfTheStyleAttribute() {
		String html = render("color: @Field@", "red\" onmouseover=\"alert(document.domain)");
		assertFalse(html.contains("onmouseover=\"alert"), "value must not create an attribute: " + html);
		assertTrue(html.contains("style=\"color: red&quot; onmouseover=&quot;alert(document.domain)\""), html);
	}

	@Test
	public void testPlainStyleUnchanged() {
		assertEquals("color: red; font-weight: bold", extractStyle(render("color: red; font-weight: bold", "x")));
	}

	private String extractStyle(String html) {
		int start = html.indexOf("style=\"") + 7;
		return html.substring(start, html.indexOf('"', start));
	}
}
