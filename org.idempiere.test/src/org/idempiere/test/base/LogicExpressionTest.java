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

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.LegacyLogicEvaluator;
import org.compiere.util.TimeUtil;
import org.idempiere.expression.logic.LogicEvaluator;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

@SuppressWarnings("deprecation")
/**
 * 
 * @author hengsin
 *
 */
public class LogicExpressionTest  extends AbstractTestCase {

	private final static ContextEvaluatee evaluatee = new ContextEvaluatee();
	
	public LogicExpressionTest() {
	}

	@Test
	public void testEqual() {
		
		String expr = "@$Element_AY@='Y'";
		Env.setContext(Env.getCtx(), "$Element_AY", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "Y");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "N");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "$Element_AY", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "N");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		
		expr = "@$Element_AY@=Y";
		Env.setContext(Env.getCtx(), "$Element_AY", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "Y");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "N");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "$Element_AY", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_AY", "N");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		
		expr = "@LineType@=\"C\"&@CalculationType@='A,R,S'";
		Env.setContext(Env.getCtx(), "LineType", "C");
		Env.setContext(Env.getCtx(), "CalculationType", "B");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "A");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "A,R,S");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testAnd() {
		String expr = "@$Element_BP@=Y & @AnyBPartner@=N";
		Env.setContext(Env.getCtx(), "$Element_BP", (String)null);
		Env.setContext(Env.getCtx(), "AnyBPartner", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_BP", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "AnyBPartner", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "AnyBPartner", "N");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_BP", "N");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "$Element_BP", (String)null);
		Env.setContext(Env.getCtx(), "AnyBPartner", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_BP", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "AnyBPartner", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "AnyBPartner", "N");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "$Element_BP", "N");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testIn() {
		String expr = "@LineType@=C&@CalculationType@=A,R,S";
		testInARS(expr);
		expr = "@LineType@='C'&@CalculationType@='A','R','S'";
		testInARS(expr);
		expr = "@LineType@=\"C\"&@CalculationType@=\"A\",\"R\",\"S\"";
		testInARS(expr);

		expr = "@Name@='Name 1','Name 2','Name 3'";
		testInName123(expr);
		expr = "@Name@=\"Name 1\",\"Name 2\",\"Name 3\"";
		testInName123(expr);
	}

	private void testInName123(String expr) {
		Env.setContext(Env.getCtx(), "Name", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Name", "Name 2");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Name", "Name 4");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "Name", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Name", "Name 2");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Name", "Name 4");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}

	private void testInARS(String expr) {
		Env.setContext(Env.getCtx(), "LineType", (String)null);
		Env.setContext(Env.getCtx(), "CalculationType", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "LineType", "C");
		Env.setContext(Env.getCtx(), "CalculationType", "B");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "A");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "R");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "S");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "LineType", "D");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "LineType", (String)null);
		Env.setContext(Env.getCtx(), "CalculationType", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "LineType", "C");
		Env.setContext(Env.getCtx(), "CalculationType", "B");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "A");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "R");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "CalculationType", "S");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "LineType", "D");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testNotEqual() {
		String expr = "@C_Bpartner_ID@!0";
		Env.setContext(Env.getCtx(), "C_Bpartner_ID", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Bpartner_ID", "0");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Bpartner_ID", "100");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "C_Bpartner_ID", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Bpartner_ID", "0");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Bpartner_ID", "100");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		
		expr = "@IsOverUnderPayment@=Y & @C_Invoice_ID@^0";
		Env.setContext(Env.getCtx(), "IsOverUnderPayment", (String)null);
		Env.setContext(Env.getCtx(), "C_Invoice_ID", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsOverUnderPayment", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Invoice_ID", "0");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Invoice_ID", "100");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "IsOverUnderPayment", (String)null);
		Env.setContext(Env.getCtx(), "C_Invoice_ID", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsOverUnderPayment", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Invoice_ID", "0");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "C_Invoice_ID", "100");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testOrAnd() {
		String expr = "@IsSold@='Y' | @IsPurchased@='Y' & @IsSummary@='N'";
		Env.setContext(Env.getCtx(), "IsSold", (String)null);
		Env.setContext(Env.getCtx(), "IsPurchased", (String)null);
		Env.setContext(Env.getCtx(), "IsSummary", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSold", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "N");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsPurchased", "Y");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSold", "N");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "IsSold", (String)null);
		Env.setContext(Env.getCtx(), "IsPurchased", (String)null);
		Env.setContext(Env.getCtx(), "IsSummary", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSold", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "N");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsPurchased", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSold", "N");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testAndOr() {
		String expr = "@IsSummary@='N' & @ProductType@=I | @ProductType@=S";
		Env.setContext(Env.getCtx(), "IsSummary", (String)null);
		Env.setContext(Env.getCtx(), "ProductType", (String)null);
		Env.setContext(Env.getCtx(), "ProductType", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "N");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ProductType", "I");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ProductType", "S");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "Y");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "IsSummary", (String)null);
		Env.setContext(Env.getCtx(), "ProductType", (String)null);
		Env.setContext(Env.getCtx(), "ProductType", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "N");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ProductType", "I");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ProductType", "S");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testAndOrGroup() {
		String expr = "@IsSummary@='N' & (@ProductType@=I | @ProductType@=S)";
		Env.setContext(Env.getCtx(), "IsSummary", (String)null);
		Env.setContext(Env.getCtx(), "ProductType", (String)null);
		Env.setContext(Env.getCtx(), "ProductType", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "N");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ProductType", "I");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ProductType", "S");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testOrAndGroup() {
		String expr = "@IsSold@='Y' | (@IsPurchased@='Y' & @IsSummary@='N')";
		Env.setContext(Env.getCtx(), "IsSold", (String)null);
		Env.setContext(Env.getCtx(), "IsPurchased", (String)null);
		Env.setContext(Env.getCtx(), "IsSummary", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSold", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "N");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsPurchased", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSold", "N");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSummary", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testGT() {
		String expr = "@IsLot@=Y& @M_LotCtl_ID@ > 0";
		Env.setContext(Env.getCtx(), "IsLot", (String)null);
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsLot", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "0");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "101");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsLot", "N");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "IsLot", (String)null);
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsLot", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "0");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "101");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsLot", "N");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testGE() {
		String expr = "@IsLot@=Y& @M_LotCtl_ID@ >= 100";
		Env.setContext(Env.getCtx(), "IsLot", (String)null);
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsLot", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "0");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "100");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "99");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testLT() {
		String expr = "@A_Asset_ID@<1&@A_CreateAsset@='Y'";
		Env.setContext(Env.getCtx(), "A_Asset_ID", (String)null);
		Env.setContext(Env.getCtx(), "A_CreateAsset", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_Asset_ID", "1");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_CreateAsset", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_Asset_ID", "0");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "A_Asset_ID", (String)null);
		Env.setContext(Env.getCtx(), "A_CreateAsset", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_Asset_ID", "1");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_CreateAsset", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_Asset_ID", "0");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testLE() {
		String expr = "@A_Asset_ID@<=1&@A_CreateAsset@='Y'";
		Env.setContext(Env.getCtx(), "A_Asset_ID", (String)null);
		Env.setContext(Env.getCtx(), "A_CreateAsset", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_Asset_ID", "2");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_CreateAsset", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "A_Asset_ID", "1");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testNegate() {
		String expr = "$!(@IsLot@=Y & @M_LotCtl_ID@ > 0)";
		Env.setContext(Env.getCtx(), "IsLot", (String)null);
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", (String)null);
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsLot", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "1");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "M_LotCtl_ID", "0");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testRE() {
		String expr = "@Identifier@ ~ '^([a-zA-Z_$][a-zA-Z\\d_$]*)$'";
		Env.setContext(Env.getCtx(), "Identifier", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Identifier", "validIdentifier");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Identifier", "$validIdentifier");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Identifier", "~inValidIdentifier");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Identifier", "_validIdentifier");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Identifier", "0inValidIdentifier");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "Identifier", "validIdentifier0");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testValidation() {
		Exception ex = null;
		String expr = "@IsSummary@='N' & (@ProductType@=I | @ProductType@=S)";
		try {
			LogicEvaluator.validate(expr);
		} catch (Exception e) {
			ex = e;
		}
		assertNull(ex);
		expr = expr.substring(0, expr.length()-1);
		try {
			LogicEvaluator.validate(expr);
		} catch (Exception e) {
			ex = e;			
		}		
		assertNotNull(ex);
		System.out.println(ex.getMessage());
	}
	
	@Test
	public void testConditionalVariable() {
		String expr = "@IsSOTrx:N@=N | @+IgnoreIsSOTrxInBPInfo:N@=Y";
		Env.setContext(Env.getCtx(), "IsSOTrx", (String)null);
		Env.setContext(Env.getCtx(), "+IgnoreIsSOTrxInBPInfo", (String)null);
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSOTrx", "Y");
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "+IgnoreIsSOTrxInBPInfo", "Y");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "IsSOTrx", (String)null);
		Env.setContext(Env.getCtx(), "+IgnoreIsSOTrxInBPInfo", (String)null);
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "IsSOTrx", "Y");
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "+IgnoreIsSOTrxInBPInfo", "Y");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testValidateAD() {
		String[] columns = {"MandatoryLogic","DocValueLogic","ReadOnlyLogic","DisplayLogic","ZoomLogic"};
		Query query = new Query(Env.getCtx(), MColumn.Table_Name, "AD_Column_ID < 1000000 AND ColumnName=?", getTrxName());
		query.setOnlyActiveRecords(true);
		List<Exception> exceptions = new ArrayList<Exception>();
		for(String column : columns) {
			List<MColumn> list = query.setParameters(column).list();
			for(MColumn mc : list) {
				MTable table = MTable.get(mc.getAD_Table_ID());
				if (!table.isActive() || table.getAD_Table_ID() >= 1000000)
					continue;
				StringBuilder builder = new StringBuilder();
				builder.append("SELECT * ")
					.append(" FROM ")
					.append(table.getTableName())
					.append(" WHERE ")
					.append(mc.getColumnName())
					.append(" IS NOT NULL");
				try (PreparedStatement stmt = DB.prepareStatement(builder.toString(), getTrxName())) {
					ResultSet rs = stmt.executeQuery();
					while (rs.next()) {
						String expr = rs.getString(mc.getColumnName());
						if (expr.startsWith("@SQL=") || expr.startsWith("SQL="))
							continue;
						try {
							LogicEvaluator.validate(expr);
						} catch (Exception e) {
							PO po = table.getPO(rs, getTrxName());
							System.out.println(po.toString()+", " + table.getTableName()+"."+mc.getColumnName()+" = " + expr);
							exceptions.add(e);			
						}
					}
				} catch (SQLException e) {
					fail(e.getMessage(), e);
				}
			}
		}
		assertTrue(exceptions.isEmpty(), "Found " + exceptions.size() + " logic expression with invalid syntax in AD");
	}
	
	@Test
	public void testDateExpression() {
		String expr = "@DateAcct@<@DateOrdered@";
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		
		Env.setContext(Env.getCtx(), "DateAcct", (Timestamp)null);
		Env.setContext(Env.getCtx(), "DateOrdered", (Timestamp)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "DateAcct", today);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "DateOrdered", today);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "DateAcct", TimeUtil.addDays(today, -1));
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "DateAcct", (Timestamp)null);
		Env.setContext(Env.getCtx(), "DateOrdered", (Timestamp)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "DateAcct", today);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "DateOrdered", today);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "DateAcct", TimeUtil.addDays(today, -1));
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testNumericExpression() {
		String expr = "@QtyReserved@=0";
		
		Env.setContext(Env.getCtx(), "QtyReserved", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "QtyReserved", 1);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "QtyReserved", 0);
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "QtyReserved", "0.00");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "QtyReserved", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "QtyReserved", 1);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "QtyReserved", 0);
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "QtyReserved", "0.00");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}
	
	@Test
	public void testEmptyStringExpression() {
		String expr = "@ColumnSQL@=''";
		Env.setContext(Env.getCtx(), "ColumnSQL", (String)null);
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "ColumnSQL", (String)null);
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
		
		expr = "@ColumnSQL@!''";
		
		Env.setContext(Env.getCtx(), "ColumnSQL", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ColumnSQL", "now()");
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
		
		Env.setContext(Env.getCtx(), "ColumnSQL", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(evaluatee, expr));
		Env.setContext(Env.getCtx(), "ColumnSQL", "now()");
		assertTrue(LogicEvaluator.evaluateLogic(evaluatee, expr));
	}

	@Test
	public void testOSEnvVariable() {
		String username = System.getenv("USER");
		if (username == null)
			username = "";
		String expr = "@$env.USER@='" + username + "'";
		assertTrue(LegacyLogicEvaluator.evaluateLogic(evaluatee, expr));
	}

	@Test
	public void testNestedProperty() {
		String expr = "@Processed@=Y & @M_Product_ID.IsBOM@=Y";
		Env.setContext(Env.getCtx(), 1, "Processed", (String)null);
		assertFalse(LegacyLogicEvaluator.evaluateLogic(new DefaultEvaluatee(null, 1, 0), expr));
		
		int pchair = 133;
		Env.setContext(Env.getCtx(), 1, "Processed", "Y");
		Env.setContext(Env.getCtx(), 1, "M_Product_ID", pchair);
		assertTrue(LegacyLogicEvaluator.evaluateLogic(new DefaultEvaluatee(null, 1, 0), expr));
		
		Env.setContext(Env.getCtx(), 1, "Processed", (String)null);
		assertFalse(LogicEvaluator.evaluateLogic(new DefaultEvaluatee(null, 1, 0), expr));
		
		Env.setContext(Env.getCtx(), 1, "Processed", "Y");
		Env.setContext(Env.getCtx(), 1, "M_Product_ID", pchair);
		assertTrue(LogicEvaluator.evaluateLogic(new DefaultEvaluatee(null, 1, 0), expr));
	}
	
	private static class ContextEvaluatee implements Evaluatee {

		@Override
		public String get_ValueAsString(String variableName) {
			return Env.getContext(Env.getCtx(), variableName);
		}
		
	}
}
