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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.text.SimpleDateFormat;
import java.util.Properties;

import org.adempiere.model.MRelationType;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MMailText;
import org.compiere.model.MOrder;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class EnvTest extends AbstractTestCase {

	/**
	 * default constructor
	 */
	public EnvTest() {
		// TODO Auto-generated constructor stub
	}

	@Test
	public void testParseVariable() {
		//test bean property, i.e order.getSummary()
		MOrder order = new MOrder(Env.getCtx(), 100, getTrxName());
		String summary = order.getSummary();
		String expr = "@=Summary@";
		String parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(summary, parsedText, "Unexpected parsed text for "+expr);
		expr = "@=summary@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(summary, parsedText, "Unexpected parsed text for "+expr);
		
		//test po column access
		String docNo = order.getDocumentNo();
		expr = "@DocumentNo@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(docNo, parsedText, "Unexpected parsed text for "+expr);
		
		//test formatting of date
		String dateOrdered = DisplayType.getDateFormat(MTable.get(MOrder.Table_ID).getColumn(MOrder.COLUMNNAME_DateOrdered).getAD_Reference_ID())
				.format(order.getDateOrdered());
		expr = "@DateOrdered@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(dateOrdered, parsedText, "Unexpected parsed text for "+expr);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		dateOrdered = sdf.format(order.getDateOrdered());
		expr = "@DateOrdered<"+sdf.toPattern()+">@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(dateOrdered, parsedText, "Unexpected parsed text for "+expr);
		
		//test foreign table access
		String clientId = Env.getContext(Env.getCtx(), Env.AD_CLIENT_ID);
		expr = "@#AD_Client_ID@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(clientId, parsedText, "Unexpected parsed text for "+expr);
		
		String clientName = MClient.get(getAD_Client_ID()).getName();
		expr = "@#AD_Client_ID<Name>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(clientName, parsedText, "Unexpected parsed text for "+expr);
		expr = "@#AD_Client_ID.Name@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(clientName, parsedText, "Unexpected parsed text for "+expr);
		
		String bpartnerValue = MBPartner.get(Env.getCtx(), order.getC_BPartner_ID()).getValue();
		expr = "@C_BPartner_ID<Value>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID:0<Value>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID.Value@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID:0.Value@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		
		//test list expression
		String docStatusName = order.getDocStatusName();
		expr = "@DocStatus<Name>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(docStatusName, parsedText, "Unexpected parsed text for "+expr);

		//test '@@' escape sequence
		expr = "test@@mail.com";
		parsedText = Env.parseVariable(expr, null, getTrxName(), true, true, true);
		assertEquals("test@mail.com", parsedText, "Unexpected parsed text for " + expr);

		//test multiple call to parse
		expr = "test@@mail.com";
		expr = Env.parseVariable(expr, null, getTrxName(), true, true, true, true);
		assertEquals("test@@mail.com", expr, "Unexpected parsed text for " + expr + " with keepEscapeSequence=true");
		parsedText = Env.parseVariable(expr, null, getTrxName(), true, true, true, false);		
		assertEquals("test@mail.com", parsedText, "Unexpected parsed text for " + expr + " with keepEscapeSequence=false");
	}

	@Test
	public void testParseContext() {
		//global
		String parsedText = Env.parseContext(Env.getCtx(), 0, "@"+Env.AD_CLIENT_ID+"@", false);
		assertEquals(Env.getContext(Env.getCtx(), Env.AD_CLIENT_ID), parsedText, "Unexpected parseContext value");

		final int windowNo = 1;
		final int tabNo = 1;

		//window only
		Env.setContext(Env.getCtx(), windowNo, "AnInt", 1);
		parsedText = Env.parseContext(Env.getCtx(), windowNo, "@AnInt@", true);
		assertEquals("1", parsedText, "Unexpected parseContext value");
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, "@AnInt@", true);
		assertTrue(Util.isEmpty(parsedText), "Unexpected parseContext value");		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, "@AnInt@", false, true);
		assertEquals("1", parsedText, "Unexpected parseContext value");
		parsedText = Env.parseContext(Env.getCtx(), windowNo, "@"+tabNo+"|AnInt@", true);
		assertEquals("1", parsedText, "Unexpected parseContext value");
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, "@"+tabNo+"|AnInt@", true, true);
		assertTrue(Util.isEmpty(parsedText), "Unexpected parseContext value");
		
		//window and tab
		Env.setContext(Env.getCtx(), windowNo, "AnInt", (String)null);
		Env.setContext(Env.getCtx(), windowNo, tabNo, "AnInt", 1);
		parsedText = Env.parseContext(Env.getCtx(), windowNo, "@AnInt@", true);
		assertTrue(Util.isEmpty(parsedText), "Unexpected parseContext value");
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, "@AnInt@", true, true);
		assertEquals("1", parsedText, "Unexpected parseContext value");		

		//test escape sequence
		Env.setContext(Env.getCtx(), windowNo, "EMail", "test@idempiere.com");
		parsedText = Env.parseContext(Env.getCtx(), windowNo, "@EMail@='test@@idempiere.com'", true, true);
		assertEquals("test@idempiere.com='test@idempiere.com'", parsedText, "Unexpected parseContext value");
		parsedText = Env.parseContext(Env.getCtx(), windowNo, "@EMail@='test@@idempiere.com'", true, true, false);
		assertEquals("test@idempiere.com='test@idempiere.com'", parsedText, "Unexpected parseContext value");
		parsedText = Env.parseContext(Env.getCtx(), windowNo, "@EMail@='test@@idempiere.com'", true, true, true);
		assertEquals("test@idempiere.com='test@@idempiere.com'", parsedText, "Unexpected parseContext value");
		
		Evaluatee contextEvaluatee = v -> {
			return Env.getContext(Env.getCtx(), windowNo, v);
		};
		
		boolean evaluation = Evaluator.evaluateLogic(contextEvaluatee, "@EMail@='test@idempiere.com'");
		assertTrue(evaluation, "Unexpected logic evaluation result");
		evaluation = Evaluator.evaluateLogic(contextEvaluatee, "@EMail@=test@idempiere.com");
		assertTrue(evaluation, "Unexpected logic evaluation result");
		evaluation = Evaluator.evaluateLogic(contextEvaluatee, "@EMail@=test1@idempiere.com");
		assertFalse(evaluation, "Unexpected logic evaluation result");
		
		//column value
		String clientName = MClient.get(getAD_Client_ID()).getName();
		String expr = "@#AD_Client_ID<Name>@";
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, false);
		assertEquals(clientName, parsedText, "Unexpected parsed text for "+expr);
		expr = "@#AD_Client_ID.Name@";
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, false);
		assertEquals(clientName, parsedText, "Unexpected parsed text for "+expr);
		//window only
		String bpartnerValue = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id).getValue();
		Env.setContext(Env.getCtx(), windowNo, "C_BPartner_ID", DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		expr = "@C_BPartner_ID<Value>@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID.Value@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID:0<Value>@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID:0.Value@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		//tab only
		Env.setContext(Env.getCtx(), windowNo, "C_BPartner_ID", "");
		Env.setContext(Env.getCtx(), windowNo, tabNo, "C_BPartner_ID", DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		expr = "@C_BPartner_ID<Value>@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID.Value@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID:0<Value>@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@C_BPartner_ID:0.Value@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, tabNo, expr, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		//window only with tab prefix
		expr = "@"+tabNo+"|C_BPartner_ID<Value>@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, -1, expr, false, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@"+tabNo+"|C_BPartner_ID.Value@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, -1, expr, false, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@"+tabNo+"|C_BPartner_ID:0<Value>@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo, -1, expr, false, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		expr = "@"+tabNo+"|C_BPartner_ID:0.Value@";		
		parsedText = Env.parseContext(Env.getCtx(), windowNo,  -1, expr, false, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		//logic
		DefaultEvaluatee evaluatee = new DefaultEvaluatee(null, windowNo, tabNo, true);
		expr = "@C_BPartner_ID<Value>@='"+bpartnerValue+"'";
		evaluation = Evaluator.evaluateLogic(evaluatee, expr);
		assertTrue(evaluation, "Unexpected logic evaluation result");
		expr = "@C_BPartner_ID.Value@='"+bpartnerValue+"'";
		evaluation = Evaluator.evaluateLogic(evaluatee, expr);
		assertTrue(evaluation, "Unexpected logic evaluation result");
		//logic+formatting
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String created = sdf.format(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id).getCreated());
		expr = "@C_BPartner_ID.Created<yyyy-MM-dd>@='"+created+"'";
		evaluation = Evaluator.evaluateLogic(evaluatee, expr);
		assertTrue(evaluation, "Unexpected logic evaluation result");
		expr = "@C_BPartner_ID:0.Created<yyyy-MM-dd>@='"+created+"'";
		evaluation = Evaluator.evaluateLogic(evaluatee, expr);
		assertTrue(evaluation, "Unexpected logic evaluation result");

		//@AD_Client_ID@
		expr = "@AD_Client_ID@";
		parsedText = Env.parseContext(Env.getCtx(), -1, expr, false, true); // like in GridFieldVO parsing ColumnSQL
		assertEquals("11", parsedText, "Unexpected parsed text for "+expr);
		
		//custom context
		Properties ctx = new Properties();
		ctx.putAll(Env.getCtx());
		String customValue = "MyCustomValue";
		String customVariable = "CustomVariable"; 
		Env.setContext(ctx, customVariable, customValue);
		parsedText = Env.parseContext(ctx, -1, "@"+customVariable+"@", false, false);
		assertEquals(customValue, parsedText, "Failed to get value from custom context");
		
		expr = "C_BPartner.C_BPartner_ID=@C_BPartner_ID@";
		MInOut inout = new MInOut(Env.getCtx(), 100, null);
		parsedText = MRelationType.parseWhereClause(inout, expr);
		assertEquals("C_BPartner.C_BPartner_ID="+inout.getC_BPartner_ID(), parsedText, "Failed to get value from custom context");
		expr = "C_BPartner.C_BPartner_ID=@#C_BPartner_ID@";
		parsedText = MRelationType.parseWhereClause(inout, expr);
		assertEquals("C_BPartner.C_BPartner_ID="+inout.getC_BPartner_ID(), parsedText, "Failed to get value from custom context");
	}

	@Test
	public void testParseMailText() {
		String mailText = """
				Hello @Name@

				Here is some text

				Contact us at: test@@test.com

				or to this another mail test2@@test.com""";
		MMailText mMailText = new MMailText(Env.getCtx(), 0, getTrxName());
		mMailText.setMailHeader("Mail Header");
		mMailText.setMailText(mailText);
		MBPartner bPartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id);
		mMailText.setBPartner(bPartner);
		MUser[] contacts = bPartner.getContacts(true);
		mMailText.setUser(contacts[0]);
		String parsedText = mMailText.getMailText();
		String expectedText = """
				Hello %s

				Here is some text

				Contact us at: test@test.com

				or to this another mail test2@test.com"""
				.formatted(contacts[0].getName());
		assertEquals(expectedText, parsedText, "Unexpected parsed mail text");
	}
}
