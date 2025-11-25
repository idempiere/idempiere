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
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.text.SimpleDateFormat;
import java.util.Properties;

import org.adempiere.model.MRelationType;
import org.compiere.model.*;
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

		expr = "@C_Order_ID<C_Order.DocumentNo>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(order.getDocumentNo(), parsedText, "Unexpected parsed text for "+expr);
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

		// Import CSV Process uses window -1 for the context
		//M_Warehouse.AD_Org_ID=@NonExisting_AD_Org_ID@
		Env.setContext(Env.getCtx(), "#NonExisting_AD_Org_ID", 0);
		Env.setContext(Env.getCtx(), -1, "NonExisting_AD_Org_ID", 11);
		Env.setContext(Env.getCtx(), -1, 0, "NonExisting_AD_Org_ID", 11);
		String validationCode = "M_Warehouse.AD_Org_ID=@NonExisting_AD_Org_ID@";
		String dynamicValid = Env.parseContext(Env.getCtx(), -1, 0, validationCode, false);
		assertEquals("M_Warehouse.AD_Org_ID=11", dynamicValid, "Unexpected parsed text for "+validationCode);

        //TabNo 0 for null _ID
        expr = "AD_User.C_BPartner_ID IN (@C_BPartner_ID@, @Bill_BPartner_ID@)";
        Env.setContext(Env.getCtx(), windowNo, 0, "C_BPartner_ID", DictionaryIDs.C_BPartner.C_AND_W.id);
        Env.setContext(Env.getCtx(), windowNo, 0, "Bill_BPartner_ID", null);
        parsedText = Env.parseContext(Env.getCtx(), windowNo, 0, expr, false);
        assertEquals("AD_User.C_BPartner_ID IN (%s, 0)".formatted(DictionaryIDs.C_BPartner.C_AND_W.id), parsedText, "Unexpected parsed text for "+expr);
        
        // AD_SysConfig
        // @$sysconfig.ZK_MAX_UPLOAD_SIZE@
        expr = "@"+Env.PREFIX_SYSCONFIG_VARIABLE + MSysConfig.ZK_MAX_UPLOAD_SIZE+"@";
        String sysConfigValue = MSysConfig.getValue(MSysConfig.ZK_MAX_UPLOAD_SIZE, Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));
        parsedText = Env.parseContext(Env.getCtx(), -1, expr, false);
        assertEquals(sysConfigValue, parsedText, "Unexpected parsed text for "+expr);
        // test logic evaluation
        evaluatee = new DefaultEvaluatee(null, -1, -1, false);
		expr = "@"+Env.PREFIX_SYSCONFIG_VARIABLE + MSysConfig.ZK_MAX_UPLOAD_SIZE+"@='"+sysConfigValue+"'";
		evaluation = Evaluator.evaluateLogic(evaluatee, expr);
		assertTrue(evaluation, "Unexpected logic evaluation result");
		expr = "@"+Env.PREFIX_SYSCONFIG_VARIABLE + MSysConfig.ZK_MAX_UPLOAD_SIZE+"@='0'";
		evaluation = Evaluator.evaluateLogic(evaluatee, expr);
		assertFalse(evaluation, "Unexpected logic evaluation result");
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

    @Test
    public void testParseMailTextWithEmailValue() {
        String mailText = "User Email = @EMail@ and BPartner Name=@Name@";
        MMailText mMailText = new MMailText(Env.getCtx(), 0, getTrxName());
        mMailText.setMailText(mailText);
        MBPartner bPartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id);
        mMailText.setBPartner(bPartner);
        MUser user = mock(MUser.class);
        when(user.get_TableName()).thenReturn("AD_User");
        when(user.get_ColumnIndex("EMail")).thenReturn(1);
        when(user.get_Value("EMail")).thenReturn("test@test.com");
        mMailText.setUser(user);
        mMailText.setPO(MProduct.get(DictionaryIDs.M_Product.AZALEA_BUSH.id));
        String expected = "User Email = %s and BPartner Name=%s".formatted(user.get_Value("EMail"), bPartner.getName());
        assertEquals(expected, mMailText.getMailText());
    }

    @Test
    public void testParseMailTextWithNullValue() {
        String mailText = "User Email = @EMail@ and Phone=@Phone@";
        MMailText mMailText = new MMailText(Env.getCtx(), 0, getTrxName());
        mMailText.setMailText(mailText);
        MBPartner bPartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id);
        mMailText.setBPartner(bPartner);
        MUser user = mock(MUser.class);
        when(user.get_TableName()).thenReturn("AD_User");
        when(user.get_ColumnIndex("EMail")).thenReturn(1);
        when(user.get_Value("EMail")).thenReturn("test@test.com");
        when(user.get_ColumnIndex("Phone")).thenReturn(2);
        when(user.get_Value("Phone")).thenReturn(null);
        mMailText.setUser(user);
        mMailText.setPO(MProduct.get(DictionaryIDs.M_Product.AZALEA_BUSH.id));
        String expected = "User Email = %s and Phone=".formatted(user.get_Value("EMail"));
        assertEquals(expected, mMailText.getMailText());
    }

    /**
     * https://idempiere.atlassian.net/browse/IDEMPIERE-6583
     */
    @Test
    public void testParseMailTextWithCreatedByAndUpdatedBy() {

    	String mailText = "The record @DocumentNo@ about @AD_User_ID<AD_User.Name>@ was created by @CreatedBy<AD_User.Name>@ and updated by @UpdatedBy<AD_User.Name>@";
    	MMailText mMailText = new MMailText(Env.getCtx(), 0, getTrxName());
    	mMailText.setMailText(mailText);

    	MOrder order = new MOrder(Env.getCtx(), 100, getTrxName());
    	order.set_ValueNoCheck("CreatedBy", DictionaryIDs.AD_User.GARDEN_USER.id);
    	order.set_ValueNoCheck("UpdatedBy", DictionaryIDs.AD_User.GARDEN_ADMIN.id);
    	order.set_ValueNoCheck("AD_User_ID", DictionaryIDs.AD_User.SUPER_USER.id);

    	mMailText.setPO(order);

    	String expected = "The record 80000 about SuperUser was created by GardenUser and updated by GardenAdmin";
    	assertEquals(expected, mMailText.getMailText());
    }

	@Test
	public void testSetContextString() {
		Properties ctx = new Properties();
		
		// Test setting string value
		Env.setContext(ctx, "TestKey", "TestValue");
		assertEquals("TestValue", Env.getContext(ctx, "TestKey"), "Failed to set/get string context");
		
		// Test setting null/empty value removes context
		Env.setContext(ctx, "TestKey", (String)null);
		assertEquals("", Env.getContext(ctx, "TestKey"), "Failed to remove context with null");
		
		Env.setContext(ctx, "TestKey2", "Value");
		Env.setContext(ctx, "TestKey2", "");
		assertEquals("", Env.getContext(ctx, "TestKey2"), "Failed to remove context with empty string");
	}

	@Test
	public void testSetContextInt() {
		Properties ctx = new Properties();
		
		// Test setting int value
		Env.setContext(ctx, "TestInt", 12345);
		assertEquals("12345", Env.getContext(ctx, "TestInt"), "Failed to set/get int context");
		assertEquals(12345, Env.getContextAsInt(ctx, "TestInt"), "Failed to get int context as int");
		
		// Test setting zero
		Env.setContext(ctx, "TestInt", 0);
		assertEquals("0", Env.getContext(ctx, "TestInt"), "Failed to set zero value");
		assertEquals(0, Env.getContextAsInt(ctx, "TestInt"), "Failed to get zero value as int");
		
		// Test negative value
		Env.setContext(ctx, "TestInt", -100);
		assertEquals("-100", Env.getContext(ctx, "TestInt"), "Failed to set negative value");
		assertEquals(-100, Env.getContextAsInt(ctx, "TestInt"), "Failed to get negative value as int");
	}

	@Test
	public void testSetContextBoolean() {
		Properties ctx = new Properties();
		
		// Test setting boolean values
		Env.setContext(ctx, "TestBool", true);
		assertEquals("Y", Env.getContext(ctx, "TestBool"), "Failed to set boolean true");
		
		Env.setContext(ctx, "TestBool", false);
		assertEquals("N", Env.getContext(ctx, "TestBool"), "Failed to set boolean false");
	}

	@Test
	public void testSetContextTimestamp() {
		Properties ctx = new Properties();
		java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf("2025-11-25 10:30:45");
		
		// Test setting timestamp value
		Env.setContext(ctx, "TestDate", timestamp);
		String value = Env.getContext(ctx, "TestDate");
		assertTrue(value.contains("2025-11-25"), "Timestamp should contain date");
		
		// Test setting null timestamp removes context
		Env.setContext(ctx, "TestDate", (java.sql.Timestamp)null);
		assertEquals("", Env.getContext(ctx, "TestDate"), "Failed to remove timestamp context with null");
	}

	@Test
	public void testSetContextWithWindowNo() {
		Properties ctx = new Properties();
		int windowNo = 5;
		
		// Test window-specific context
		Env.setContext(ctx, windowNo, "TestKey", "WindowValue");
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, "TestKey"), "Failed to set/get window context");
		
		// Test window context with int
		Env.setContext(ctx, windowNo, "TestInt", 999);
		assertEquals(999, Env.getContextAsInt(ctx, windowNo, "TestInt"), "Failed to set/get window int context");
		
		// Test window context with boolean
		Env.setContext(ctx, windowNo, "TestBool", true);
		assertEquals("Y", Env.getContext(ctx, windowNo, "TestBool"), "Failed to set/get window boolean context");
		
		// Test that window context doesn't affect global context
		Env.setContext(ctx, "GlobalKey", "GlobalValue");
		Env.setContext(ctx, windowNo, "GlobalKey", "WindowValue");
		assertEquals("GlobalValue", Env.getContext(ctx, "GlobalKey"), "Window context should not override global");
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, "GlobalKey"), "Window context should be retrievable");
	}

	@Test
	public void testSetContextWithWindowAndTabNo() {
		Properties ctx = new Properties();
		int windowNo = 3;
		int tabNo = 2;
		
		// Test tab-specific context
		Env.setContext(ctx, windowNo, tabNo, "TabKey", "TabValue");
		assertEquals("TabValue", Env.getContext(ctx, windowNo, tabNo, "TabKey"), "Failed to set/get tab context");
		
		// Test tab context with int
		Env.setContext(ctx, windowNo, tabNo, "TabInt", 777);
		assertEquals(777, Env.getContextAsInt(ctx, windowNo, tabNo, "TabInt"), "Failed to set/get tab int context");
		
		// Test tab context with boolean
		Env.setContext(ctx, windowNo, tabNo, "TabBool", false);
		assertEquals("N", Env.getContext(ctx, windowNo, tabNo, "TabBool"), "Failed to set/get tab boolean context");
		
		// Test null _ID field gets default value "0"
		Env.setContext(ctx, windowNo, tabNo, "Test_ID", (String)null);
		assertEquals("0", Env.getContext(ctx, windowNo, tabNo, "Test_ID"), "Null _ID field should default to 0");
		
		// Test non-ID field gets empty string
		Env.setContext(ctx, windowNo, tabNo, "TestName", (String)null);
		assertEquals("", Env.getContext(ctx, windowNo, tabNo, "TestName"), "Null non-ID field should be empty");
	}

	@Test
	public void testGetContextAsInt() {
		Properties ctx = new Properties();
		
		// Test valid int
		Env.setContext(ctx, "ValidInt", 12345);
		assertEquals(12345, Env.getContextAsInt(ctx, "ValidInt"), "Failed to get valid int");
		
		// Test empty/missing context returns 0
		assertEquals(0, Env.getContextAsInt(ctx, "MissingKey"), "Missing key should return 0");
		
		// Test invalid number returns 0
		ctx.setProperty("InvalidInt", "NotANumber");
		assertEquals(0, Env.getContextAsInt(ctx, "InvalidInt"), "Invalid number should return 0");
		
		// Test with window context
		int windowNo = 10;
		Env.setContext(ctx, windowNo, "WindowInt", 5555);
		assertEquals(5555, Env.getContextAsInt(ctx, windowNo, "WindowInt"), "Failed to get window int");
		assertEquals(0, Env.getContextAsInt(ctx, windowNo, "MissingWindowInt"), "Missing window key should return 0");
	}

	@Test
	public void testGetContextAsDate() {
		Properties ctx = new Properties();
		
		// Test valid timestamp
		java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf("2025-11-25 10:30:45");
		Env.setContext(ctx, "TestDate", timestamp);
		java.sql.Timestamp retrieved = Env.getContextAsDate(ctx, "TestDate");
		assertFalse(retrieved == null, "Should retrieve valid timestamp");
		
		// Test missing context returns current date
		java.sql.Timestamp defaultDate = Env.getContextAsDate(ctx, "MissingDate");
		assertFalse(defaultDate == null, "Missing date should return current date");
		
		// Test with window context
		int windowNo = 7;
		Env.setContext(ctx, windowNo, "WindowDate", timestamp);
		java.sql.Timestamp windowDate = Env.getContextAsDate(ctx, windowNo, "WindowDate");
		assertFalse(windowDate == null, "Should retrieve valid window timestamp");
	}

	@Test
	public void testAutoCommit() {
		Properties ctx = new Properties();
		
		// Test default (should be false)
		assertFalse(Env.isAutoCommit(ctx), "Default AutoCommit should be false");
		
		// Test window-specific auto commit
		int windowNo = 4;
		Env.setAutoCommit(ctx, windowNo, true);
		assertTrue(Env.isAutoCommit(ctx, windowNo), "Failed to set window AutoCommit to true");
		
		Env.setAutoCommit(ctx, windowNo, false);
		assertFalse(Env.isAutoCommit(ctx, windowNo), "Failed to set window AutoCommit to false");
	}

	@Test
	public void testAutoNew() {
		Properties ctx = new Properties();
		
		// Test default (should be false)
		assertFalse(Env.isAutoNew(ctx), "Default AutoNew should be false");
		
		// Test window-specific auto new
		int windowNo = 6;
		Env.setAutoNew(ctx, windowNo, true);
		assertTrue(Env.isAutoNew(ctx, windowNo), "Failed to set window AutoNew to true");
		
		Env.setAutoNew(ctx, windowNo, false);
		assertFalse(Env.isAutoNew(ctx, windowNo), "Failed to set window AutoNew to false");
	}

	@Test
	public void testIsSOTrx() {
		Properties ctx = new Properties();
		
		// Test default (should be true - Sales Order)
		assertTrue(Env.isSOTrx(ctx), "Default IsSOTrx should be true");
		
		// Test setting to Purchase Order
		Env.setSOTrx(ctx, false);
		assertFalse(Env.isSOTrx(ctx), "Failed to set IsSOTrx to false");
		
		// Test setting to Sales Order
		Env.setSOTrx(ctx, true);
		assertTrue(Env.isSOTrx(ctx), "Failed to set IsSOTrx to true");
		
		// Test window-specific IsSOTrx
		int windowNo = 8;
		Env.setContext(ctx, windowNo, "IsSOTrx", false);
		assertFalse(Env.isSOTrx(ctx, windowNo), "Failed to get window IsSOTrx as false");
		
		Env.setContext(ctx, windowNo, "IsSOTrx", true);
		assertTrue(Env.isSOTrx(ctx, windowNo), "Failed to get window IsSOTrx as true");
	}

	@Test
	public void testGetAD_Client_ID() {
		Properties ctx = new Properties();
		Env.setContext(ctx, Env.AD_CLIENT_ID, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		assertEquals(DictionaryIDs.AD_Client.GARDEN_WORLD.id, Env.getAD_Client_ID(ctx), "Failed to get AD_Client_ID");
	}

	@Test
	public void testGetAD_Org_ID() {
		Properties ctx = new Properties();
		Env.setContext(ctx, Env.AD_ORG_ID, DictionaryIDs.AD_Org.HQ.id);
		assertEquals(DictionaryIDs.AD_Org.HQ.id, Env.getAD_Org_ID(ctx), "Failed to get AD_Org_ID");
	}

	@Test
	public void testGetAD_User_ID() {
		Properties ctx = new Properties();
		Env.setContext(ctx, Env.AD_USER_ID, DictionaryIDs.AD_User.SUPER_USER.id);
		assertEquals(DictionaryIDs.AD_User.SUPER_USER.id, Env.getAD_User_ID(ctx), "Failed to get AD_User_ID");
	}

	@Test
	public void testGetAD_Role_ID() {
		Properties ctx = new Properties();
		Env.setContext(ctx, Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN_NOT_ADVANCED.id);
		assertEquals(DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN_NOT_ADVANCED.id, Env.getAD_Role_ID(ctx), "Failed to get AD_Role_ID");
	}

	@Test
	public void testContextHierarchy() {
		Properties ctx = new Properties();
		int windowNo = 1;
		int tabNo = 2;
		
		// Set values at different levels
		Env.setContext(ctx, "#GlobalKey", "GlobalValue");
		Env.setContext(ctx, windowNo, "WindowKey", "WindowValue");
		Env.setContext(ctx, windowNo, tabNo, "TabKey", "TabValue");
		
		// Test retrieval hierarchy
		// Global context should be accessible from anywhere
		assertEquals("GlobalValue", Env.getContext(ctx, "#GlobalKey"), "Global context should be accessible globally");
		assertEquals("GlobalValue", Env.getContext(ctx, windowNo, "#GlobalKey"), "Global context should be accessible from window");
		assertEquals("GlobalValue", Env.getContext(ctx, windowNo, tabNo, "#GlobalKey"), "Global context should be accessible from tab");
		
		// Window context should not be accessible globally with onlyWindow=true
		assertEquals("", Env.getContext(ctx, "WindowKey"), "Window context should not be in global context");
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, "WindowKey"), "Window context should be accessible from window");
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, tabNo, "WindowKey"), "Window context should be accessible from tab");
		
		// Tab context should only be accessible from tab
		assertEquals("", Env.getContext(ctx, "TabKey"), "Tab context should not be in global context");
		assertEquals("", Env.getContext(ctx, windowNo, "TabKey", true), "Tab context should not be in window context with onlyWindow=true");
		assertEquals("TabValue", Env.getContext(ctx, windowNo, tabNo, "TabKey"), "Tab context should be accessible from tab");
	}

	@Test
	public void testContextOnlyWindowAndOnlyTab() {
		Properties ctx = new Properties();
		int windowNo = 10;
		int tabNo = 5;
		
		// Set up contexts at different levels
		Env.setContext(ctx, "#TestKey", "GlobalValue");
		Env.setContext(ctx, windowNo, "TestKey", "WindowValue");
		Env.setContext(ctx, windowNo, tabNo, "TestKey", "TabValue");
		
		// Test onlyWindow flag
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, "TestKey", true), "onlyWindow=true should return window value");
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, "TestKey", false), "onlyWindow=false should return window value");
		
		// Test when window context doesn't exist
		assertEquals("", Env.getContext(ctx, windowNo, "OnlyGlobal", true), "onlyWindow=true should not return global value");
		assertEquals("", Env.getContext(ctx, windowNo, "OnlyGlobal", false), "onlyWindow=false with no # prefix should not return global value");
		
		// Test onlyTab flag
		assertEquals("TabValue", Env.getContext(ctx, windowNo, tabNo, "TestKey", true, false), "onlyTab=true should return tab value");
		assertTrue(Util.isEmpty(Env.getContext(ctx, windowNo, tabNo, "OnlyWindow", true, false)), "onlyTab=true should not search window");
		// Set window context and verify onlyTab=false searches window
		Env.setContext(ctx, windowNo, "OnlyWindow", "WindowValue");
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, tabNo, "OnlyWindow", false, false), "onlyTab=false should search window");
	}

	@Test
	public void testEnvironmentVariables() {
		Properties ctx = new Properties();
		
		// Test system variable prefix
		String expr = "@" + Env.PREFIX_SYSTEM_VARIABLE + "PATH@";
		String parsedText = Env.parseContext(ctx, 0, expr, false);
		assertFalse(parsedText.isEmpty(), "Should retrieve system PATH variable");
		
		// Test non-existent environment variable
		expr = "@" + Env.PREFIX_SYSTEM_VARIABLE + "NONEXISTENT_VAR_12345@";
		parsedText = Env.parseContext(ctx, 0, expr, false);
		assertEquals("", parsedText, "Non-existent environment variable should return empty string");
	}

	@Test
	public void testNullContextHandling() {
		// Test that null context throws IllegalArgumentException
		try {
			Env.getContext(null, "TestKey");
			assertTrue(false, "Should throw IllegalArgumentException for null context");
		} catch (IllegalArgumentException e) {
			assertTrue(true, "Correctly throws IllegalArgumentException");
		}
		
		try {
			Env.setContext(null, "TestKey", "TestValue");
			// Should not throw, just return early
			assertTrue(true, "setContext handles null context gracefully");
		} catch (Exception e) {
			assertTrue(false, "Should not throw exception: " + e.getMessage());
		}
		
		// Test null context key
		try {
			Env.getContext(new Properties(), null);
			assertTrue(false, "Should throw IllegalArgumentException for null context key");
		} catch (IllegalArgumentException e) {
			assertTrue(true, "Correctly throws IllegalArgumentException");
		}
	}

	@Test
	public void testContextAsIntWithWindowAndTab() {
		Properties ctx = new Properties();
		int windowNo = 15;
		int tabNo = 3;
		
		Env.setContext(ctx, windowNo, tabNo, "TabInt", 888);
		assertEquals(888, Env.getContextAsInt(ctx, windowNo, tabNo, "TabInt"), "Failed to get tab int context");
		
		// Test empty context returns 0
		assertEquals(0, Env.getContextAsInt(ctx, windowNo, tabNo, "MissingTabInt"), "Missing tab int should return 0");
		
		// Test invalid number returns 0
		ctx.setProperty(windowNo+"|"+tabNo+"|InvalidInt", "ABC");
		assertEquals(0, Env.getContextAsInt(ctx, windowNo, tabNo, "InvalidInt"), "Invalid tab int should return 0");
	}

	@Test
	public void testGetContextOnlyWindowParameter() {
		Properties ctx = new Properties();
		int windowNo = 20;
		
		// Set global context
		Env.setContext(ctx, "#GlobalParam", "GlobalValue");
		
		// Test that onlyWindow=true doesn't return global value without # prefix
		String result = Env.getContext(ctx, windowNo, "GlobalParam", true);
		assertEquals("", result, "onlyWindow=true should not search global context without # prefix");
		
		// Test that onlyWindow=false returns global value
		result = Env.getContext(ctx, windowNo, "#GlobalParam", false);
		assertEquals("GlobalValue", result, "onlyWindow=false should search global context with # prefix");
		
		// Test window-specific value
		Env.setContext(ctx, windowNo, "WindowParam", "WindowValue");
		result = Env.getContext(ctx, windowNo, "WindowParam", true);
		assertEquals("WindowValue", result, "onlyWindow=true should return window value");
	}
}
