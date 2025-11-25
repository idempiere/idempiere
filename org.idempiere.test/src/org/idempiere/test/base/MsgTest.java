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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.Adempiere;
import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class MsgTest extends AbstractTestCase {

	@Test
	public void testGetSingleton() {
		Msg msg1 = Msg.get();
		Msg msg2 = Msg.get();
		assertSame(msg1, msg2);
	}

	@Test
	public void testSplitToMsgTipNoTip() {
		String msg = Msg.getMsg(getLanguage(), "ZoomDocument");
		ValueNamePair vnp = Msg.splitToMsgTip(msg);
		assertEquals("Document Zoom", vnp.getValue());
		assertEquals("", vnp.getName());
	}

	@Test
	public void testSplitToMsgTipWithTip() {
		String msg = Msg.getMsg(getLanguage(), "AccessCannotDelete");
		ValueNamePair vnp = Msg.splitToMsgTip(msg);
		assertEquals("You cannot delete this record ", vnp.getValue());
		assertEquals("You don't have the privileges", vnp.getName());
	}

	@Test
	public void testGetLanguagesAndReset() {
		Msg msg = Msg.get();
		CCache<String, String> cache = msg.getMsgMap("es_CO");
		assertTrue(cache.size() > 0);
		String[] langs = msg.getLanguages();
		assertNotNull(langs);
		assertTrue(langs.length >= 2); // en_US and es_CO at least
		msg.reset();
		cache = msg.getMsgMap("xx_XX");
		assertNull(cache);
		cache = msg.getMsgMap("en_US");
		CCache<String, String> cacheNull = msg.getMsgMap(null); // must load base language
		assertNotNull(cacheNull);
		assertEquals(cache, cacheNull);
	}

	@Test
	public void testIsLoaded() {
		Msg msg = Msg.get();
		msg.getMsgMap("en_US");
		assertTrue(msg.isLoaded("en_US"));
		assertFalse(msg.isLoaded("xx_XX"));
	}

	@Test
	public void testGetMsgWithNullMessage() {
		assertEquals("", Msg.getMsg("en_US", null));
		assertEquals("", Msg.getMsg("en_US", ""));
	}

	@Test
	public void testGetMsgWithHardcodedValues() {
		assertEquals(System.getProperty("file.separator"), Msg.getMsg("en_US", "/"));
		assertEquals(System.getProperty("file.separator"), Msg.getMsg("en_US", "\\"));
		assertEquals(System.getProperty("path.separator"), Msg.getMsg("en_US", ";"));
		assertEquals(System.getProperty("path.separator"), Msg.getMsg("en_US", ":"));
		String msg = Msg.getMsg("en_US", "IDEMPIERE_HOME");
		assertEquals(Ini.getAdempiereHome(), msg);
		msg = Msg.getMsg("en_US", "bat");
		assertTrue(msg.equals("bat") || msg.equals("sh"));
		msg = Msg.getMsg("en_US", "CopyRight");
		assertEquals(Adempiere.COPYRIGHT, msg);
	}

	@Test
	public void testSplitToMsgTipEdgeCases() {
		assertNotNull(Msg.splitToMsgTip(""));
		assertThrows(NullPointerException.class, () -> Msg.splitToMsgTip(null));
	}

	@Test
	public void testTranslateNotExistent() {
		String input = "@^/NonExistentKey$@";
		String result = Msg.translate("en_US", input);
		// Should return input if no translation is found
		assertEquals(input, result);
	}

	@Test
	public void testTranslate() {
		assertEquals("Document Zoom", Msg.translate(Env.getCtx(), "ZoomDocument")); // translate from AD_Message
		assertEquals("Business Partner", Msg.translate(Env.getCtx(), "C_BPartner_ID")); // translate from AD_Element
		// es_CO
		assertEquals("Acercar Documento", Msg.translate("es_CO", "ZoomDocument"));
		Language lang = Language.getLanguage("es_CO");
		assertEquals("Tercero", Msg.translate(lang, "C_BPartner_ID"));
	}

	@Test
	public void testParseTranslation() {
		String input = "@ZoomDocument@ @C_BPartner_ID@";
		String result = Msg.parseTranslation(Env.getCtx(), input);
		String expected = "Document Zoom Business Partner";
		assertEquals(expected, result);
	}

	@Test
	public void testGetElementBasic() {
		assertEquals("Business Partner", Msg.getElement("en_US", "C_BPartner_ID", false));
		assertEquals("Order", Msg.getElement(Env.getCtx(), "C_Order_ID"));
		assertEquals("Purchase Order", Msg.getElement(Env.getCtx(), "C_Order_ID", false));
		assertEquals("Tercero", Msg.getElement("es_CO", "C_BPartner_ID", false));
		assertEquals("Orden de Venta", Msg.getElement("es_CO", "C_Order_ID", true));
		assertEquals("Orden de compra", Msg.getElement("es_CO", "C_Order_ID", false));
	}

	@Test
	public void testGetAmtInWords() {
		String amount = "123.45";

		Language lang = Language.getLanguage("en_US");
		String result = Msg.getAmtInWords(lang, amount);
		assertEquals("One Hundred Twenty Three 45/100", result);

		lang = Language.getLanguage("es_CO");
		result = Msg.getAmtInWords(lang, amount);
		assertEquals("CIENTO VEINTITRES 45/100", result);

		result = Msg.getAmtInWords(null, amount);
		assertEquals(amount, result);

		// Class not found: org.compiere.util.AmtInWords_AR
		lang = Language.getLanguage("ar_SA");
		result = Msg.getAmtInWords(lang, amount);
		assertEquals("1*2*3 45/100", result);
	}

	@Test
	public void testHasTranslation() {
		assertFalse(Msg.hasTranslation("es_CO", "^/NonExistentKey$"));
		// From AD_Message table
		assertTrue(Msg.hasTranslation("es_CO", "SelectDocument"));
		// From AD_Element table
		assertTrue(Msg.hasTranslation("es_CO", "C_BPartner_ID"));
	}

	@Test
	public void testGetCleanMsg() {
		String result = Msg.getCleanMsg(Env.getCtx(), "WorkflowActivities"); // Workflow &Activities
		assertEquals("Workflow Activities", result);
		result = Msg.getCleanMsg(Env.getCtx(), "SearchOK");
		assertEquals("Select Record & Return", result);
	}

	@Test
	public void testGetMsgParams() {
		Language lang = Language.getLanguage("en_US");
		// {0} Line(s) - Total: {1,number,#,##0.00} {2}
		String result = Msg.getMsg(lang, "ExpenseSummary", new Object[] {5, 1234.56, "USD"});
		assertEquals("5 Line(s) - Total: 1,234.56 USD", result);
	}

	@Test
	public void testGetMsg() {
		assertEquals("You cannot delete this record ", Msg.getMsg("en_US", "AccessCannotDelete", true));
		assertEquals("You don't have the privileges", Msg.getMsg("en_US", "AccessCannotDelete", false));
		assertEquals("Document Zoom", Msg.getMsg(Env.getCtx(), "ZoomDocument"));
	}

}