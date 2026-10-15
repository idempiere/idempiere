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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.spy;

import org.compiere.model.MBPartner;
import org.compiere.model.MOrder;
import org.compiere.model.MStyle;
import org.compiere.model.MStyleLine;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Test of {@link MStyle#buildStyle(String, Evaluatee, boolean)} variable substitution in the style line inline style.
 */
public class MStyleTest extends AbstractTestCase {

	/**
	 * Build a style (not persisted) that returns the given inline style texts as its lines
	 * @param inlineStyles
	 * @return MStyle
	 */
	private MStyle createStyle(String... inlineStyles) {
		MStyleLine[] lines = new MStyleLine[inlineStyles.length];
		for (int i = 0; i < inlineStyles.length; i++) {
			lines[i] = new MStyleLine(Env.getCtx(), 0, null);
			lines[i].setInlineStyle(inlineStyles[i]);
		}
		MStyle style = spy(new MStyle(Env.getCtx(), 0, null));
		doReturn(lines).when(style).getStyleLines();
		return style;
	}

	@Test
	public void testLineWithoutVariableUnchanged() {
		MStyle style = createStyle("color: red", "font-weight: bold;");
		assertEquals("color: red; font-weight: bold;", style.buildStyle("", new DefaultEvaluatee()));
	}

	@Test
	public void testVariableFromPO() {
		MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setC_BPartner_ID(bp.getC_BPartner_ID());
		MStyle style = createStyle("content: '@C_BPartner_ID.Name@'; color: @Missing:blue@");
		assertEquals("content: '" + bp.getName() + "'; color: blue", style.buildStyle("", new DefaultEvaluatee(order)));
	}

	@Test
	public void testReferenceVariableWithoutForeignKeyValue() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		MStyle style = createStyle("background-color: @C_BPartner_ID.Name@");
		// unresolved variable is kept, the browser ignores the invalid declaration
		assertEquals("background-color: @C_BPartner_ID.Name@", style.buildStyle("", new DefaultEvaluatee(order)));
	}

	@Test
	public void testVariableFromPlainEvaluatee() {
		Evaluatee evaluatee = name -> "Color".equals(name) ? "#FF0000" : "";
		MStyle style = createStyle("background-color: @Color@");
		assertEquals("background-color: #FF0000", style.buildStyle("", evaluatee));
	}

	@Test
	public void testEscapedAt() {
		MStyle style = createStyle("content: '@@'");
		assertEquals("content: '@'", style.buildStyle("", new DefaultEvaluatee()));
	}

	@Test
	public void testUnpairedAtKeepsOriginalText() {
		String text = "background-image: url(img@2x.png)";
		MStyle style = createStyle(text);
		assertEquals(text, style.buildStyle("", new DefaultEvaluatee()));
	}

	@Test
	public void testLiteralAtPairKeptWithValidVariable() {
		Evaluatee evaluatee = name -> "Color".equals(name) ? "#FF0000" : "";
		MStyle style = createStyle("content: 'a@b c@d'; color: @Color@");
		assertEquals("content: 'a@b c@d'; color: #FF0000", style.buildStyle("", evaluatee));
	}

	@Test
	public void testNoSubstitutionForCss() {
		String css = "@media print { span { color: red; } }";
		MStyle style = createStyle(css);
		assertEquals(css, style.buildStyle("", new DefaultEvaluatee(), false));
	}
}
