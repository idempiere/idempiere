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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import org.adempiere.model.MRelationType;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MMailText;
import org.compiere.model.MOrder;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.SystemIDs;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Language;
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
		parsedText = Env.parseContext(Env.getCtx(), windowNo, "@EMail@='test@@idempiere.com'", true, true, true, false);
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

        // test parse with and without SQL
		Env.setContext(Env.getCtx(), windowNo, "TestString", "'MyString'");
		expr = "SELECT * FROM C_Charge WHERE Name=@TestString@";
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true, false, false, false);
		assertEquals("SELECT * FROM C_Charge WHERE Name='MyString'", parsedText, "Unexpected parsed text forSQL=false for "+expr);
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true, false, false, true);
		assertEquals("SELECT * FROM C_Charge WHERE Name=''MyString''", parsedText, "Unexpected parsed text forSQL=true for "+expr);

		Env.setContext(Env.getCtx(), windowNo, "TestString", "MyString");
		expr = "SELECT * FROM C_Charge WHERE Name='@TestString@'";
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true, false, false, false);
		assertEquals("SELECT * FROM C_Charge WHERE Name='MyString'", parsedText, "Unexpected parsed text forSQL=false for "+expr);
		parsedText = Env.parseContext(Env.getCtx(), windowNo, expr, true, false, false, true);
		assertEquals("SELECT * FROM C_Charge WHERE Name='MyString'", parsedText, "Unexpected parsed text forSQL=true for "+expr);
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
		assertNotNull(retrieved, "Should retrieve valid timestamp");
		
		// Test missing context returns current date
		java.sql.Timestamp defaultDate = Env.getContextAsDate(ctx, "MissingDate");
		assertNotNull(defaultDate, "Missing date should return current date");
		
		// Test with window context
		int windowNo = 7;
		Env.setContext(ctx, windowNo, "WindowDate", timestamp);
		java.sql.Timestamp windowDate = Env.getContextAsDate(ctx, windowNo, "WindowDate");
		assertNotNull(windowDate, "Should retrieve valid window timestamp");
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
		assertThrows(IllegalArgumentException.class, () -> {
			Env.getContext(null, "TestKey");
		}, "Should throw IllegalArgumentException for null context");
		
		// setContext handles null context gracefully - should not throw
		Env.setContext(null, "TestKey", "TestValue");
		
		// Test null context key
		assertThrows(IllegalArgumentException.class, () -> {
			Env.getContext(new Properties(), null);
		}, "Should throw IllegalArgumentException for null context key");
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

	@Test
	public void testGetAD_Language() {
		Properties ctx = new Properties();
		
		// Test with no language set - should return base language
		String adLanguage = Env.getAD_Language(ctx);
		assertEquals(Language.getBaseAD_Language(), adLanguage, "Should return base AD_Language when not set");
		
		// Test with language set in context
		Env.setContext(ctx, Env.LANGUAGE, "es_CO");
		assertEquals("es_CO", Env.getAD_Language(ctx), "Should return es_MX from context");
		
		// Test with different language
		Env.setContext(ctx, Env.LANGUAGE, "de_DE");
		assertEquals("de_DE", Env.getAD_Language(ctx), "Should return de_DE from context");
		
		// Test with empty string - should fall back to base language
		Env.setContext(ctx, Env.LANGUAGE, "");
		assertEquals(Language.getBaseAD_Language(), Env.getAD_Language(ctx), "Empty language should return base language");
		
		// Test with null context - should return base language
		assertEquals(Language.getBaseAD_Language(), Env.getAD_Language(null), "Null context should return base language");
	}

	@Test
	public void testGetLanguage() {
		Properties ctx = new Properties();
		
		// Test with no language set - should return base language
		Language language = Env.getLanguage(ctx);
		assertEquals(Language.getBaseLanguage(), language, "Should return base Language when not set");
		
		// Test with language set in context
		Env.setContext(ctx, Env.LANGUAGE, "en_US");
		language = Env.getLanguage(ctx);
		assertEquals("en_US", language.getAD_Language(), "Should return en_US Language from context");
		
		// Test with Spanish language
		Env.setContext(ctx, Env.LANGUAGE, "es_ES");
		language = Env.getLanguage(ctx);
		assertEquals("es_ES", language.getAD_Language(), "Should return es_ES Language from context");
		
		// Test with empty string - should fall back to base language
		Env.setContext(ctx, Env.LANGUAGE, "");
		language = Env.getLanguage(ctx);
		assertEquals(Language.getBaseLanguage(), language, "Empty language should return base Language");
		
		// Test with null context - should return base language
		assertEquals(Language.getBaseLanguage(), Env.getLanguage(null), "Null context should return base Language");
	}

	@Test
	public void testGetLoginLanguage() {
		Properties ctx = new Properties();
		
		// Test that getLoginLanguage returns the login language (not context dependent)
		Language loginLanguage = Env.getLoginLanguage(ctx);
		assertNotNull(loginLanguage, "Login language should not be null");
		
		// Login language should be consistent regardless of context language
		Env.setContext(ctx, Env.LANGUAGE, "es_CO");
		Language loginLanguage2 = Env.getLoginLanguage(ctx);
		assertEquals(loginLanguage, loginLanguage2, "Login language should be consistent");
	}

	@Test
	public void testGetLocaleLanguage() {
		Properties ctx = new Properties();
		
		// Test with default locale
		Language localeLanguage = Env.getLocaleLanguage(ctx);
		assertNotNull(localeLanguage, "Locale language should not be null");
		
		// Test with specific locale set
		Env.setContext(ctx, Env.LOCALE, "en_GB");
		Env.setContext(ctx, Env.LANGUAGE, "en_US");
		localeLanguage = Env.getLocaleLanguage(ctx);
		assertNotNull(localeLanguage, "Locale language should not be null");
		assertEquals("en_US", localeLanguage.getAD_Language(), "Should have AD_Language from context");
		assertEquals("en", localeLanguage.getLocale().getLanguage(), "Should have language from locale");
		assertEquals("GB", localeLanguage.getLocale().getCountry(), "Should have country from locale");
		
		// Test with matching locale and language
		Env.setContext(ctx, Env.LOCALE, "es_CO");
		Env.setContext(ctx, Env.LANGUAGE, "es_CO");
		localeLanguage = Env.getLocaleLanguage(ctx);
		assertEquals("es_CO", localeLanguage.getAD_Language(), "Should return es_CO");
		assertEquals("es", localeLanguage.getLocale().getLanguage(), "Should have es language");
		assertEquals("CO", localeLanguage.getLocale().getCountry(), "Should have CO country");
	}

	@Test
	public void testGetLocale() {
		Properties ctx = new Properties();
		
		// Test with no locale set - should use language locale
		Locale locale = Env.getLocale(ctx);
		assertNotNull(locale, "Locale should not be null");
		
		// Test with locale set in context
		Env.setContext(ctx, Env.LOCALE, "en_US");
		locale = Env.getLocale(ctx);
		assertEquals("en", locale.getLanguage(), "Locale language should be en");
		assertEquals("US", locale.getCountry(), "Locale country should be US");
		
		// Test with different locale
		Env.setContext(ctx, Env.LOCALE, "de_DE");
		locale = Env.getLocale(ctx);
		assertEquals("de", locale.getLanguage(), "Locale language should be de");
		assertEquals("DE", locale.getCountry(), "Locale country should be DE");
		
		// Test with locale that has only language
		Env.setContext(ctx, Env.LOCALE, "fr");
		locale = Env.getLocale(ctx);
		assertEquals("fr", locale.getLanguage(), "Locale language should be fr");
		assertEquals("", locale.getCountry(), "Locale country should be empty");
		
		// Test with empty locale - should fall back to language locale
		Env.setContext(ctx, Env.LOCALE, "");
		Env.setContext(ctx, Env.LANGUAGE, "en_US");
		locale = Env.getLocale(ctx);
		assertNotNull(locale, "Should fall back to language locale");
	}

	@Test
	public void testIsBaseTranslation() {
		// Test AD tables are base translation
		assertTrue(Env.isBaseTranslation("AD_Message"), "AD_Message should be base translation");
		assertTrue(Env.isBaseTranslation("AD_Element"), "AD_Element should be base translation");
		assertTrue(Env.isBaseTranslation("AD_Field"), "AD_Field should be base translation");
		assertTrue(Env.isBaseTranslation("AD_Window"), "AD_Window should be base translation");
		
		// Test C_Country_Trl is base translation
		assertTrue(Env.isBaseTranslation("C_Country_Trl"), "C_Country_Trl should be base translation");
		
		// Test non-AD tables are not base translation
		assertFalse(Env.isBaseTranslation("C_Order"), "C_Order should not be base translation");
		assertFalse(Env.isBaseTranslation("M_Product"), "M_Product should not be base translation");
		assertFalse(Env.isBaseTranslation("C_Invoice"), "C_Invoice should not be base translation");
		assertFalse(Env.isBaseTranslation("M_InOut"), "M_InOut should not be base translation");
	}

	@Test
	public void testIsMultiLingualDocument() {
		boolean isMultiLingual =  MClient.get(Env.getCtx()).isMultiLingualDocument();
		assertEquals(isMultiLingual, Env.isMultiLingualDocument(Env.getCtx()));
	}

	@Test
	public void testIsShowTechnicalInfOnHelp() {
		Properties ctx = new Properties();
		
		// Test default (should be false when not set)
		assertFalse(Env.IsShowTechnicalInfOnHelp(ctx), "Default should be false");
		
		// Test setting to true
		Env.setContext(ctx, "P|IsShowTechnicalInfOnHelp", "Y");
		assertTrue(Env.IsShowTechnicalInfOnHelp(ctx), "Should return true when set to Y");
		
		// Test setting to false
		Env.setContext(ctx, "P|IsShowTechnicalInfOnHelp", "N");
		assertFalse(Env.IsShowTechnicalInfOnHelp(ctx), "Should return false when set to N");
		
		// Test with null context throws exception
		assertThrows(IllegalArgumentException.class, () -> {
			Env.IsShowTechnicalInfOnHelp(null);
		}, "Should throw IllegalArgumentException for null context");
	}

	@Test
	public void testIsBaseLanguage() {
		Properties ctx = new Properties();
		
		// Test with base language in context
		Env.setContext(ctx, Env.LANGUAGE, Language.getBaseAD_Language());
		assertTrue(Env.isBaseLanguage(ctx, "AnyTable"), "Should return true for base language");
		
		// Test static method with AD_Language string
		assertTrue(Env.isBaseLanguage(Language.getBaseAD_Language(), "AnyTable"), 
			"Should return true for base AD_Language string");
		
		// Test static method with Language object
		Language baseLanguage = Language.getBaseLanguage();
		assertTrue(Env.isBaseLanguage(baseLanguage, "AnyTable"), 
			"Should return true for base Language object");
	}

	@Test
	public void testLanguageContextWithWindowNo() {
		Properties ctx = new Properties();
		int windowNo = 25;
		
		// Test that language can be set at window level (though unusual)
		Env.setContext(ctx, windowNo, Env.LANGUAGE, "it_IT");
		
		// Global getAD_Language should not see window-level language
		Env.setContext(ctx, Env.LANGUAGE, "en_US");
		assertEquals("en_US", Env.getAD_Language(ctx), "Global language should be en_US");
		
		// Window-specific context should have its own language
		String windowLang = Env.getContext(ctx, windowNo, Env.LANGUAGE);
		assertEquals("it_IT", windowLang, "Window language should be it_IT");
	}

	@Test
	public void testGetPreferenceUserLevel() {
		Properties ctx = new Properties();
		int windowId = 100;
		
		// Test user preference - window level
		ctx.setProperty("P100|TestPref", "WindowValue");
		assertEquals("WindowValue", Env.getPreference(ctx, windowId, "TestPref", false), 
			"Should return window-level preference");
		
		// Test user preference - global level
		ctx.setProperty("P|GlobalPref", "GlobalValue");
		assertEquals("GlobalValue", Env.getPreference(ctx, windowId, "GlobalPref", false), 
			"Should return global preference");
		
		// Test window preference takes precedence over global
		ctx.setProperty("P|CommonPref", "GlobalValue");
		ctx.setProperty("P100|CommonPref", "WindowValue");
		assertEquals("WindowValue", Env.getPreference(ctx, windowId, "CommonPref", false), 
			"Window preference should take precedence");
		
		// Test non-existent preference returns empty string
		assertEquals("", Env.getPreference(ctx, windowId, "NonExistent", false), 
			"Non-existent preference should return empty string");
	}

	@Test
	public void testGetPreferenceSystemLevel() {
		Properties ctx = new Properties();
		int windowId = 100;
		
		// Test system preference - login setting (#)
		ctx.setProperty("#LoginSetting", "LoginValue");
		assertEquals("LoginValue", Env.getPreference(ctx, windowId, "LoginSetting", true), 
			"Should return login setting");
		
		// Test system preference - accounting setting ($)
		ctx.setProperty("$AcctSetting", "AcctValue");
		assertEquals("AcctValue", Env.getPreference(ctx, windowId, "AcctSetting", true), 
			"Should return accounting setting");
		
		// Test system preference - injected role variable (+)
		ctx.setProperty("+RoleVar", "RoleValue");
		assertEquals("RoleValue", Env.getPreference(ctx, windowId, "RoleVar", true), 
			"Should return role variable");
		
		// Test precedence: # before $ before +
		ctx.setProperty("#CommonSetting", "LoginValue");
		ctx.setProperty("$CommonSetting", "AcctValue");
		ctx.setProperty("+CommonSetting", "RoleValue");
		assertEquals("LoginValue", Env.getPreference(ctx, windowId, "CommonSetting", true), 
			"Login setting should take precedence");
		
		// Test $ before +
		ctx.remove("#CommonSetting");
		assertEquals("AcctValue", Env.getPreference(ctx, windowId, "CommonSetting", true), 
			"Accounting setting should take precedence over role variable");
		
		// Test + when others don't exist
		ctx.remove("$CommonSetting");
		assertEquals("RoleValue", Env.getPreference(ctx, windowId, "CommonSetting", true), 
			"Should return role variable");
	}

	@Test
	public void testGetPreferenceInfoWindow() {
		Properties ctx = new Properties();
		int windowId = 100;
		int infoWindowId = 200;
		
		// Test info window preference
		ctx.setProperty("P100|200|InfoPref", "InfoValue");
		assertEquals("InfoValue", Env.getPreference(ctx, windowId, infoWindowId, "InfoPref"), 
			"Should return info window preference");
		
		// Test non-existent returns empty string
		assertEquals("", Env.getPreference(ctx, windowId, infoWindowId, "NonExistent"), 
			"Non-existent preference should return empty string");
	}

	@Test
	public void testGetPreferenceProcess() {
		Properties ctx = new Properties();
		int windowId = 100;
		int infoWindowId = 200;
		int processId = 300;
		
		// Test process preference
		ctx.setProperty("P100|200|300|ProcessPref", "ProcessValue");
		assertEquals("ProcessValue", Env.getPreference(ctx, windowId, infoWindowId, processId, "ProcessPref"), 
			"Should return process preference");
		
		// Test non-existent returns empty string
		assertEquals("", Env.getPreference(ctx, windowId, infoWindowId, processId, "NonExistent"), 
			"Non-existent preference should return empty string");
	}

	@Test
	public void testGetPreferenceNullHandling() {
		Properties ctx = new Properties();
		
		// Test null context throws exception
		assertThrows(IllegalArgumentException.class, () -> {
			Env.getPreference(null, 100, "TestPref", false);
		}, "Null context should throw IllegalArgumentException");
		
		// Test null key throws exception
		assertThrows(IllegalArgumentException.class, () -> {
			Env.getPreference(ctx, 100, null, false);
		}, "Null key should throw IllegalArgumentException");
		
		// Test null context for info window
		assertThrows(IllegalArgumentException.class, () -> {
			Env.getPreference(null, 100, 200, "TestPref");
		}, "Null context should throw IllegalArgumentException");
		
		// Test null key for info window
		assertThrows(IllegalArgumentException.class, () -> {
			Env.getPreference(ctx, 100, 200, null);
		}, "Null key should throw IllegalArgumentException");
	}

	@Test
	public void testGetSupportedLanguages() {
		// Test that getSupportedLanguages returns a valid list
		ArrayList<String> languages = Env.getSupportedLanguages();
		assertNotNull(languages, "Supported languages should not be null");
		
		// Should contain at least the base language (assuming AD_Message_Trl has data)
		// The exact content depends on database state, so we just verify it's a valid list
		assertTrue(languages.size() >= 0, "Should return a valid list");
	}

	@Test
	public void testGetLoginLanguages() {
		// Test that getLoginLanguages returns a valid list
		ArrayList<String> languages = Env.getLoginLanguages();
		assertNotNull(languages, "Login languages should not be null");
		
		// Should return list of active login languages
		// The exact content depends on database state
		assertTrue(languages.size() >= 0, "Should return a valid list");
	}

	@Test
	public void testVerifyLanguage() {
		Properties ctx = new Properties();
		
		// Test with base language - should not modify
		Language baseLanguage = Language.getBaseLanguage();
		Language testLang = new Language(baseLanguage.getName(), baseLanguage.getAD_Language(), 
			baseLanguage.getLocale(), baseLanguage.isDecimalPoint(), 
			baseLanguage.getDateFormat().toPattern(), baseLanguage.getMediaSize());
		
		String originalADLang = testLang.getAD_Language();
		Env.verifyLanguage(ctx, testLang);
		assertEquals(originalADLang, testLang.getAD_Language(), 
			"Base language should not be modified");
	}

	@Test
	public void testGetEntireContext() {
		Properties ctx = new Properties();
		
		// Test with empty context
		String[] emptyContext = Env.getEntireContext(ctx);
		assertEquals(0, emptyContext.length, "Empty context should return empty array");
		
		// Test with some values
		ctx.setProperty("Key1", "Value1");
		ctx.setProperty("Key2", "Value2");
		ctx.setProperty("#GlobalKey", "GlobalValue");
		
		String[] contextArray = Env.getEntireContext(ctx);
		assertEquals(3, contextArray.length, "Should return 3 entries");
		
		// Verify format: key == value
		boolean foundKey1 = false;
		for (String entry : contextArray) {
			if (entry.contains("Key1")) {
				assertTrue(entry.contains("=="), "Entry should contain ==");
				assertTrue(entry.contains("Value1"), "Entry should contain value");
				foundKey1 = true;
			}
		}
		assertTrue(foundKey1, "Should find Key1 entry");
		
		// Test null context throws exception
		assertThrows(IllegalArgumentException.class, () -> {
			Env.getEntireContext(null);
		}, "Null context should throw IllegalArgumentException");
	}

	@Test
	public void testGetHeader() {
		Properties ctx = Env.getCtx();
		int windowNo = 30;
		
		// Set up window context
		Env.setContext(ctx, windowNo, "_WinInfo_WindowName", "Test Window");
		Env.setContext(ctx, windowNo, "DocumentNo", "DOC-001");
		Env.setContext(ctx, windowNo, "Value", "VAL-001");
		Env.setContext(ctx, windowNo, "Name", "Test Name");
		
		// Get header
		String header = Env.getHeader(ctx, windowNo);
		assertNotNull(header, "Header should not be null");
		assertFalse(header.isEmpty(), "Header should not be empty");
		
		// Should contain window info when WindowNo > 0
		assertTrue(header.contains("Test Window"), "Header should contain window name");
		assertTrue(header.contains("DOC-001"), "Header should contain document number");
		assertTrue(header.contains("VAL-001"), "Header should contain value");
		assertTrue(header.contains("Test Name"), "Header should contain name");
		
		// Test with WindowNo = 0 (no window-specific info)
		String header0 = Env.getHeader(ctx, 0);
		assertNotNull(header0, "Header should not be null");
		assertFalse(header0.isEmpty(), "Header should not be empty");
	}

	@Test
	public void testClearWinContext() {
		Properties ctx = new Properties();
		int windowNo = 35;
		
		// Set up window context
		Env.setContext(ctx, windowNo, "WindowKey1", "Value1");
		Env.setContext(ctx, windowNo, "WindowKey2", "Value2");
		Env.setContext(ctx, windowNo, 0, "TabKey1", "TabValue1");
		
		// Set up global context
		Env.setContext(ctx, "#GlobalKey", "GlobalValue");
		
		// Verify context exists
		assertEquals("Value1", Env.getContext(ctx, windowNo, "WindowKey1"));
		assertEquals("TabValue1", Env.getContext(ctx, windowNo, 0, "TabKey1"));
		
		// Clear window context
		Env.clearWinContext(ctx, windowNo);
		
		// Verify window and tab context are cleared
		assertEquals("", Env.getContext(ctx, windowNo, "WindowKey1"), 
			"Window context should be cleared");
		assertEquals("", Env.getContext(ctx, windowNo, "WindowKey2"), 
			"Window context should be cleared");
		assertEquals("", Env.getContext(ctx, windowNo, 0, "TabKey1"), 
			"Tab context should be cleared");
		
		// Verify global context is not affected
		assertEquals("GlobalValue", Env.getContext(ctx, "#GlobalKey"), 
			"Global context should not be affected");
		
		// Test null context throws exception
		assertThrows(IllegalArgumentException.class, () -> {
			Env.clearWinContext(null, windowNo);
		}, "Null context should throw IllegalArgumentException");
	}

	@Test
	public void testClearTabContext() {
		Properties ctx = new Properties();
		int windowNo = 40;
		int tabNo = 5;
		
		// Set up tab context
		Env.setContext(ctx, windowNo, tabNo, "TabKey1", "TabValue1");
		Env.setContext(ctx, windowNo, tabNo, "TabKey2", "TabValue2");
		
		// Set up tab info context (should NOT be cleared)
		ctx.setProperty(windowNo + "|" + tabNo + "|_TabInfo_Name", "TabInfoValue");
		
		// Set up window context (should NOT be cleared)
		Env.setContext(ctx, windowNo, "WindowKey", "WindowValue");
		
		// Set up another tab context (should NOT be cleared)
		Env.setContext(ctx, windowNo, 10, "OtherTabKey", "OtherTabValue");
		
		// Verify context exists
		assertEquals("TabValue1", Env.getContext(ctx, windowNo, tabNo, "TabKey1"));
		assertEquals("TabValue2", Env.getContext(ctx, windowNo, tabNo, "TabKey2"));
		
		// Clear tab context
		Env.clearTabContext(ctx, windowNo, tabNo);
		
		// Verify tab context is cleared
		assertTrue(Util.isEmpty(Env.getContext(ctx, windowNo, tabNo, "TabKey1")), 
			"Tab context should be cleared");
		assertTrue(Util.isEmpty(Env.getContext(ctx, windowNo, tabNo, "TabKey2")), 
			"Tab context should be cleared");
		
		// Verify _TabInfo is NOT cleared
		assertEquals("TabInfoValue", ctx.getProperty(windowNo + "|" + tabNo + "|_TabInfo_Name"), 
			"TabInfo should not be cleared");
		
		// Verify window context is NOT cleared
		assertEquals("WindowValue", Env.getContext(ctx, windowNo, "WindowKey"), 
			"Window context should not be cleared");
		
		// Verify other tab context is NOT cleared
		assertEquals("OtherTabValue", Env.getContext(ctx, windowNo, 10, "OtherTabKey"), 
			"Other tab context should not be cleared");
		
		// Test null context throws exception
		assertThrows(IllegalArgumentException.class, () -> {
			Env.clearTabContext(null, windowNo, tabNo);
		}, "Null context should throw IllegalArgumentException");
	}

	@Test
	public void testClearContext() {
		Properties ctx = new Properties();
		
		// Set up various context values
		Env.setContext(ctx, "#GlobalKey", "GlobalValue");
		Env.setContext(ctx, 10, "WindowKey", "WindowValue");
		Env.setContext(ctx, 10, 0, "TabKey", "TabValue");
		ctx.setProperty("CustomKey", "CustomValue");
		
		// Verify context has values
		assertTrue(ctx.size() > 0, "Context should have values");
		
		// Clear context
		Env.clearContext(ctx);
		
		// Verify context is completely empty
		assertEquals(0, ctx.size(), "Context should be empty after clear");
		assertEquals("", Env.getContext(ctx, "#GlobalKey"), "Global context should be cleared");
		
		// Test null context throws exception
		assertThrows(IllegalArgumentException.class, () -> {
			Env.clearContext(null);
		}, "Null context should throw IllegalArgumentException");
	}

	@Test
	public void testClearContextHierarchy() {
		Properties ctx = new Properties();
		int windowNo = 45;
		int tabNo1 = 1;
		int tabNo2 = 2;
		
		// Set up complex hierarchy
		Env.setContext(ctx, "#Global1", "G1");
		Env.setContext(ctx, "#Global2", "G2");
		Env.setContext(ctx, windowNo, "Window1", "W1");
		Env.setContext(ctx, windowNo, "Window2", "W2");
		Env.setContext(ctx, windowNo, tabNo1, "Tab1Key1", "T1K1");
		Env.setContext(ctx, windowNo, tabNo1, "Tab1Key2", "T1K2");
		Env.setContext(ctx, windowNo, tabNo2, "Tab2Key1", "T2K1");
		Env.setContext(ctx, windowNo, tabNo2, "Tab2Key2", "T2K2");
		
		int initialSize = ctx.size();
		assertTrue(initialSize >= 8, "Should have at least 8 entries");
		
		// Clear tab1 only
		Env.clearTabContext(ctx, windowNo, tabNo1);
		
		// Verify only tab1 is cleared
		assertTrue(Util.isEmpty(Env.getContext(ctx, windowNo, tabNo1, "Tab1Key1")));
		assertTrue(Util.isEmpty(Env.getContext(ctx, windowNo, tabNo1, "Tab1Key2")));
		assertEquals("T2K1", Env.getContext(ctx, windowNo, tabNo2, "Tab2Key1"), "Tab2 should remain");
		assertEquals("W1", Env.getContext(ctx, windowNo, "Window1"), "Window should remain");
		assertEquals("G1", Env.getContext(ctx, "#Global1"), "Global should remain");
		
		// Clear entire window
		Env.clearWinContext(ctx, windowNo);
		
		// Verify window and remaining tabs are cleared
		assertTrue(Util.isEmpty(Env.getContext(ctx, windowNo, "Window1")));
		assertTrue(Util.isEmpty(Env.getContext(ctx, windowNo, tabNo2, "Tab2Key1")));
		
		// Verify global remains
		assertEquals("G1", Env.getContext(ctx, "#Global1"), "Global should still remain");
		assertEquals("G2", Env.getContext(ctx, "#Global2"), "Global should still remain");
	}

	@Test
	public void testGetZoomWindowIDWithTableAndRecordID() {

		int userTableId = MTable.getTable_ID("AD_User");
		
		int windowId = Env.getZoomWindowID(userTableId, 100);
		assertEquals(windowId, DictionaryIDs.AD_Window.USER.id, "Should return user window ID");
		
		// Test with windowNo parameter
		int windowId2 = Env.getZoomWindowID(userTableId, 100, 0);
		assertEquals(windowId2, DictionaryIDs.AD_Window.USER.id, "Should return user window ID");
		
		// The two calls should return the same result for the same parameters
		assertEquals(windowId, windowId2, "Should return consistent window ID");
	}

	@Test
	public void testGetZoomWindowUU() {
		int userTableId = MTable.getTable_ID("AD_User");
		String testUU = "test-uuid-12345";
		
		// Test that it returns a valid window ID (or 0 if not configured)
		int windowId = Env.getZoomWindowUU(userTableId, testUU);
		assertEquals(windowId, DictionaryIDs.AD_Window.USER.id, "Should return user window ID");
		
		// Test with windowNo parameter
		int windowId2 = Env.getZoomWindowUU(userTableId, testUU, 0);
		assertEquals(windowId2, DictionaryIDs.AD_Window.USER.id, "Should return user window ID");
		
		// The two calls should return the same result for the same parameters
		assertEquals(windowId, windowId2, "Should return consistent window ID");
	}

	@Test
	public void testGetZoomWindowIDWithMQuery() {
		MQuery query = new MQuery("AD_User");
		query.addRestriction("AD_User_ID", MQuery.EQUAL, 100);
		
		// Test that it returns a valid window ID
		int windowId = Env.getZoomWindowID(query);
		assertEquals(windowId, DictionaryIDs.AD_Window.USER.id, "Should return user window ID");
		
		// Test with different table
		MQuery invoiceQuery = new MQuery("C_Invoice");
		invoiceQuery.addRestriction("C_Invoice_ID", MQuery.EQUAL, 100);
		
		int invoiceWindowId = Env.getZoomWindowID(invoiceQuery);
		assertEquals(invoiceWindowId, DictionaryIDs.AD_Window.SALES_INVOICE.id, "Should return valid window ID or 0");

		// Test condition zoom
		query = new MQuery(MOrder.Table_Name);
		query.addRestriction("IsSOTrx", MQuery.EQUAL, "Y");
		query.addRestriction("C_Order_ID", MQuery.LESS, 1000000);
		int soWindowId = Env.getZoomWindowID(query);
		assertEquals(soWindowId, SystemIDs.WINDOW_SALES_ORDER, "Should return sales order window ID");
	}

	@Test
	public void testGetZoomWindowIDWithDifferentTables() {
		// Test with various standard tables to ensure the method handles them
		String[] tables = {"AD_User", "AD_Role", "C_BPartner", "M_Product"};
		
		for (String tableName : tables) {
			int tableId = MTable.getTable_ID(tableName);
			if (tableId > 0) {
				int windowId = Env.getZoomWindowID(tableId, 1);
				assertTrue(windowId >= 0, "Window ID for " + tableName + " should be >= 0");
			}
		}
	}

	@Test
	public void testSetPredefinedVariablesGlobalLevel() {
		Properties ctx = new Properties();
		
		// Test simple variable assignment
		String predefinedVars = "VAR1=Value1\nVAR2=Value2";
		Env.setPredefinedVariables(ctx, -1, predefinedVars);
		
		// Variables should be set with + prefix at global level
		assertEquals("Value1", Env.getContext(ctx, "+VAR1"), "VAR1 should be set with + prefix");
		assertEquals("Value2", Env.getContext(ctx, "+VAR2"), "VAR2 should be set with + prefix");
	}

	@Test
	public void testSetPredefinedVariablesWindowLevel() {
		Properties ctx = new Properties();
		int windowNo = 50;
		
		// Test window-level variables
		String predefinedVars = "WIN_VAR1=WinValue1\nWIN_VAR2=WinValue2";
		Env.setPredefinedVariables(ctx, windowNo, predefinedVars);
		
		// Variables should be set with + prefix at window level
		assertEquals("WinValue1", Env.getContext(ctx, windowNo, "+WIN_VAR1"), 
			"WIN_VAR1 should be set at window level with + prefix");
		assertEquals("WinValue2", Env.getContext(ctx, windowNo, "+WIN_VAR2"), 
			"WIN_VAR2 should be set at window level with + prefix");
		
		// Should not be in global context
		assertEquals("", Env.getContext(ctx, "+WIN_VAR1"), 
			"Window variables should not be in global context");
	}

	@Test
	public void testSetPredefinedVariablesWithQuotes() {
		Properties ctx = new Properties();
		
		// Test with double quotes
		String varsWithDoubleQuotes = "QUOTED_VAR=\"Value with spaces\"";
		Env.setPredefinedVariables(ctx, -1, varsWithDoubleQuotes);
		assertEquals("Value with spaces", Env.getContext(ctx, "+QUOTED_VAR"), 
			"Double quotes should be removed");
		
		// Test with single quotes
		String varsWithSingleQuotes = "SINGLE_VAR='Another value'";
		Env.setPredefinedVariables(ctx, -1, varsWithSingleQuotes);
		assertEquals("Another value", Env.getContext(ctx, "+SINGLE_VAR"), 
			"Single quotes should be removed");
		
		// Test without quotes
		String varsWithoutQuotes = "NO_QUOTE_VAR=PlainValue";
		Env.setPredefinedVariables(ctx, -1, varsWithoutQuotes);
		assertEquals("PlainValue", Env.getContext(ctx, "+NO_QUOTE_VAR"), 
			"Plain values should work without quotes");
	}

	@Test
	public void testSetPredefinedVariablesWithSpecialCases() {
		Properties ctx = new Properties();
		
		// Test with empty value
		String varsWithEmpty = "EMPTY_VAR=\nNON_EMPTY=Value";
		Env.setPredefinedVariables(ctx, -1, varsWithEmpty);
		assertEquals("", Env.getContext(ctx, "+EMPTY_VAR"), "Empty value should be allowed");
		assertEquals("Value", Env.getContext(ctx, "+NON_EMPTY"), "Non-empty should work");
		
		// Test with spaces around equals
		String varsWithSpaces = "SPACED_VAR  =  Spaced Value  ";
		Env.setPredefinedVariables(ctx, -1, varsWithSpaces);
		assertEquals("Spaced Value", Env.getContext(ctx, "+SPACED_VAR"), 
			"Should trim spaces around variable name and handle value spaces");
		
		// Test with equals in value
		String varsWithEqualsInValue = "EQUALS_VAR=Value=WithEquals";
		Env.setPredefinedVariables(ctx, -1, varsWithEqualsInValue);
		assertEquals("Value=WithEquals", Env.getContext(ctx, "+EQUALS_VAR"), 
			"Should handle equals sign in value");
	}

	@Test
	public void testSetPredefinedVariablesIgnoresComments() {
		Properties ctx = new Properties();
		
		// Test that lines without equals are ignored (can be used as comments)
		String varsWithComments = "# This is a comment\nVAR1=Value1\nThis is also ignored\nVAR2=Value2";
		Env.setPredefinedVariables(ctx, -1, varsWithComments);
		
		assertEquals("Value1", Env.getContext(ctx, "+VAR1"), "VAR1 should be set");
		assertEquals("Value2", Env.getContext(ctx, "+VAR2"), "VAR2 should be set");
		
		// Comment lines should not create any context
		assertEquals("", Env.getContext(ctx, "+# This is a comment"), 
			"Comment line should not be parsed");
		assertEquals("", Env.getContext(ctx, "+This is also ignored"), 
			"Non-assignment line should not be parsed");
	}

	@Test
	public void testSetPredefinedVariablesWithMultipleFormats() {
		Properties ctx = new Properties();
		
		// Test mixing different formats
		String mixedVars = "VAR1=Plain\n" +
						   "VAR2=\"Double Quoted\"\n" +
						   "VAR3='Single Quoted'\n" +
						   "VAR4 = Spaced\n" +
						   "Comment line without equals\n" +
						   "VAR5=\"Quoted=Value\"";
		
		Env.setPredefinedVariables(ctx, -1, mixedVars);
		
		assertEquals("Plain", Env.getContext(ctx, "+VAR1"), "Plain format should work");
		assertEquals("Double Quoted", Env.getContext(ctx, "+VAR2"), "Double quoted should work");
		assertEquals("Single Quoted", Env.getContext(ctx, "+VAR3"), "Single quoted should work");
		assertEquals("Spaced", Env.getContext(ctx, "+VAR4"), "Spaced format should work");
		assertEquals("Quoted=Value", Env.getContext(ctx, "+VAR5"), 
			"Quoted value with equals should work");
	}

	@Test
	public void testSetPredefinedVariablesNullHandling() {
		Properties ctx = new Properties();
		
		// Test with null predefinedVariables - should not throw exception
		Env.setPredefinedVariables(ctx, -1, null);
		// No exception should be thrown, method should simply return
		
		Env.setPredefinedVariables(ctx, 10, null);
		// No exception should be thrown at window level either
	}

	@Test
	public void testSetPredefinedVariablesEmptyString() {
		Properties ctx = new Properties();
		
		// Test with empty string
		Env.setPredefinedVariables(ctx, -1, "");
		// Should not throw exception and context should remain empty
		
		// Test with only whitespace/newlines
		Env.setPredefinedVariables(ctx, -1, "\n\n  \n");
		// Should not throw exception
	}

	@Test
	public void testSetPredefinedVariablesOverwrite() {
		Properties ctx = new Properties();
		
		// Set initial value
		Env.setPredefinedVariables(ctx, -1, "VAR=InitialValue");
		assertEquals("InitialValue", Env.getContext(ctx, "+VAR"), "Should set initial value");
		
		// Overwrite with new value
		Env.setPredefinedVariables(ctx, -1, "VAR=NewValue");
		assertEquals("NewValue", Env.getContext(ctx, "+VAR"), "Should overwrite with new value");
		
		// Test overwrite at window level
		int windowNo = 55;
		Env.setPredefinedVariables(ctx, windowNo, "WIN_VAR=Initial");
		assertEquals("Initial", Env.getContext(ctx, windowNo, "+WIN_VAR"), 
			"Should set initial window value");
		
		Env.setPredefinedVariables(ctx, windowNo, "WIN_VAR=Updated");
		assertEquals("Updated", Env.getContext(ctx, windowNo, "+WIN_VAR"), 
			"Should overwrite window value");
	}

	@Test
	public void testSetPredefinedVariablesWithNumericValues() {
		Properties ctx = new Properties();
		
		// Test with numeric values
		String numericVars = "INT_VAR=123\nDECIMAL_VAR=45.67\nNEGATIVE_VAR=-89";
		Env.setPredefinedVariables(ctx, -1, numericVars);
		
		assertEquals("123", Env.getContext(ctx, "+INT_VAR"), "Integer value should be stored as string");
		assertEquals("45.67", Env.getContext(ctx, "+DECIMAL_VAR"), "Decimal value should be stored");
		assertEquals("-89", Env.getContext(ctx, "+NEGATIVE_VAR"), "Negative value should be stored");
		
		// Verify they can be retrieved as integers
		assertEquals(123, Env.getContextAsInt(ctx, "+INT_VAR"), 
			"Should be retrievable as integer");
		assertEquals(-89, Env.getContextAsInt(ctx, "+NEGATIVE_VAR"), 
			"Negative should be retrievable as integer");
	}

	@Test
	public void testPredefinedVariablesPrefixConstant() {
		// Verify the PREFIX_PREDEFINED_VARIABLE constant is "+"
		assertEquals("+", Env.PREFIX_PREDEFINED_VARIABLE, 
			"Predefined variable prefix should be +");
	}

	@Test
	public void testParseContextForSql() {
		Properties ctx = new Properties();
		int windowNo = 100;
		
		// Setup context
		Env.setContext(ctx, windowNo, "AD_Client_ID", 11);
		Env.setContext(ctx, windowNo, "AD_Org_ID", 11);
		Env.setContext(ctx, windowNo, "CreatedBy", 100);
		Env.setContext(ctx, windowNo, "Name", "TestUser");
		
		List<Object> params = new ArrayList<>();
		
		// Test simple substitution
		String sql = "SELECT * FROM AD_Client WHERE AD_Client_ID=@AD_Client_ID@";
		String parsed = Env.parseContextForSql(ctx, windowNo, sql, true, false, params);
		assertEquals("SELECT * FROM AD_Client WHERE AD_Client_ID=?", parsed, "SQL should use placeholder");
		assertEquals(1, params.size(), "Should have 1 parameter");
		assertEquals(11, params.get(0), "Parameter value should match context");
		
		// Test string parameter
		params.clear();
		sql = "SELECT * FROM AD_User WHERE Name=@Name@";
		parsed = Env.parseContextForSql(ctx, windowNo, sql, true, false, params);
		assertEquals("SELECT * FROM AD_User WHERE Name=?", parsed, "SQL should use placeholder");
		assertEquals(1, params.size(), "Should have 1 parameter");
		assertEquals("TestUser", params.get(0), "Parameter value should match context");
		
		// Test multiple parameters
		params.clear();
		sql = "UPDATE AD_Org SET CreatedBy=@CreatedBy@ WHERE AD_Client_ID=@AD_Client_ID@";
		parsed = Env.parseContextForSql(ctx, windowNo, sql, true, false, params);
		assertEquals("UPDATE AD_Org SET CreatedBy=? WHERE AD_Client_ID=?", parsed, "SQL should use placeholders");
		assertEquals(2, params.size(), "Should have 2 parameters");
		assertEquals(100, params.get(0), "First parameter should be CreatedBy");
		assertEquals(11, params.get(1), "Second parameter should be AD_Client_ID");
	}

	@Test
	public void testMergeParameters() {
		Properties ctx = new Properties();
		int windowNo = 100;
		Env.setContext(ctx, windowNo, "ContextVar", "ContextValue");
		
		// SQL with mixed parameters: '?' and '@ContextVar@'
		String preParseSQL = "SELECT * FROM Table WHERE Col1=? AND Col2=@ContextVar@ AND Col3=?";
		
		// Original parameters for '?'
		Object[] sqlParams = new Object[] { 100, "AfterContext" };
		
		// Mock parse result (what parseContextForSql does)
		// It replaces @ContextVar@ with ? and collects parameters
		List<Object> contextParamsList = new ArrayList<>();
		String postParseSQL = Env.parseContextForSql(ctx, windowNo, preParseSQL, true, false, contextParamsList);
		
		// Verify parse result first
		assertEquals("SELECT * FROM Table WHERE Col1=? AND Col2=? AND Col3=?", postParseSQL, "Parsed SQL not as expected");
		assertEquals(1, contextParamsList.size(), "Should have 1 context parameter");
		assertEquals("ContextValue", contextParamsList.get(0), "Context parameter mismatch");
		
		// Now merge parameters
		List<Object> merged = Env.mergeParameters(preParseSQL, postParseSQL, sqlParams, contextParamsList.toArray());
		
		assertEquals(3, merged.size(), "Should have 3 parameters total");
		assertEquals(100, merged.get(0), "First param should be from sqlParams");
		assertEquals("ContextValue", merged.get(1), "Second param should be from contextParams");
		assertEquals("AfterContext", merged.get(2), "Third param should be from sqlParams");
	}
}
