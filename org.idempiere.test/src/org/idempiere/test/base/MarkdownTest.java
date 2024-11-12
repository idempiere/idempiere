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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.adempiere.base.Core;
import org.adempiere.base.markdown.IMarkdownRenderer;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class MarkdownTest extends AbstractTestCase {

	public MarkdownTest() {
	}

	@Test
	public void TestRenderToHtml() {
		IMarkdownRenderer service = Core.getMarkdownRenderer();
		assertNotNull(service, "Fail to get markdown renderer service instance");
		String html = service.renderToHtml("# Heading level 1");
		assertEquals("<h1>Heading level 1</h1>", html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("I just love **bold text**");
		assertEquals("I just love <strong>bold text</strong>", html, "Unexpected render to html output");
		html = service.renderToHtml("My favorite search engine is [Duck Duck Go](https://duckduckgo.com)");
		assertEquals("My favorite search engine is <a href=\"https://duckduckgo.com\" target=\"_blank\" onclick=\"event.stopPropagation()\">Duck Duck Go</a>", html, "Unexpected render to html output");
		String table = """
| Month | Name |
| -------- | ------- |
| 1 | January |""";
		html = service.renderToHtml(table);
		String expected = """
<table>
<thead>
<tr>
<th>Month</th>
<th>Name</th>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td>January</td>
</tr>
</tbody>
</table>""";
		assertEquals(expected, html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("Auto link **https://idempiere.org/**");
		assertEquals("Auto link <strong><a href=\"https://idempiere.org/\" target=\"_blank\" onclick=\"event.stopPropagation()\">https://idempiere.org/</a></strong>", html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("No Auto link **https://idempiere.org/**", false);
		assertEquals("No Auto link <strong>https://idempiere.org/</strong>", html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("Auto link **test@idempiere.org**");
		assertEquals("Auto link <strong><a href=\"mailto:test@idempiere.org\" target=\"_blank\" onclick=\"event.stopPropagation()\">test@idempiere.org</a></strong>", html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("No Auto link **test@idempiere.org**", false);
		assertEquals("No Auto link <strong>test@idempiere.org</strong>", html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("<div>Inside HTML **block**</div>");
		assertEquals("<div>Inside HTML **block**</div>", html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("<div>Inside HTML <#md>**block**</#md></div>");
		assertEquals("<div>Inside HTML <strong>block</strong></div>", html.trim(), "Unexpected render to html output");
		html = service.renderToHtml("Zoom [BP](javascript:directZoom(\"C_BPartner_ID\",100))");
		assertEquals("Zoom <a href=\"javascript:directZoom(&quot;C_BPartner_ID&quot;,100)\" onclick=\"event.stopPropagation()\">BP</a>", html.trim(), "Unexpected render to html output");
	}
}
