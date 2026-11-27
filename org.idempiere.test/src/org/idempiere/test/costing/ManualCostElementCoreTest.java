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
 * - hengsin                                                           *
 **********************************************************************/
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.util.List;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MDiscountSchema;
import org.compiere.model.MDiscountSchemaLine;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutConfirm;
import org.compiere.model.MInOutLine;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MTimeExpense;
import org.compiere.model.MTimeExpenseLine;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.M_PriceList_Create;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CPreparedStatement;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.acct.doc.Doc;
import org.idempiere.acct.doc.DocLine;
import org.idempiere.acct.doc.DocManager;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;


/**
 * Core model, price list, labor cost, and reversal FactLine tests for IDEMPIERE-7231.
 */
public class ManualCostElementCoreTest extends AbstractManualCostElementTest
{
	@Test
	public void testCostElementChargeValidation()
	{
		// Material cost element must clear C_Charge_ID in beforeSave
		MCostElement matCe = new MCostElement(Env.getCtx(), 0, getTrxName());
		matCe.setName("Test Material Element");
		matCe.setCostElementType(MCostElement.COSTELEMENTTYPE_Material);
		matCe.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
		matCe.saveEx();
		assertEquals(0, matCe.getC_Charge_ID(), "Material cost element should not retain C_Charge_ID");

		// Non-material cost element with a costing method must also clear C_Charge_ID
		MCostElement methodCe = new MCostElement(Env.getCtx(), 0, getTrxName());
		methodCe.setName("Test Burden With Method");
		methodCe.setCostElementType(MCostElement.COSTELEMENTTYPE_BurdenMOverhead);
		methodCe.setCostingMethod(MCostElement.COSTINGMETHOD_AveragePO);
		methodCe.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
		methodCe.saveEx();
		assertEquals(0, methodCe.getC_Charge_ID(), "Cost element with CostingMethod should not retain C_Charge_ID");

		// Non-material cost element without costing method retains C_Charge_ID
		MCostElement manualCe = new MCostElement(Env.getCtx(), 0, getTrxName());
		manualCe.setName("Test Burden With Charge");
		manualCe.setCostElementType(MCostElement.COSTELEMENTTYPE_BurdenMOverhead);
		manualCe.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
		manualCe.saveEx();
		assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, manualCe.getC_Charge_ID(),
				"Non-material manual cost element should retain C_Charge_ID");
	}

	@Test
	public void testBackwardCompatibilityWhenChargeIsNull()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostLegacyProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			// Legacy non-material cost element with NO C_Charge_ID
			MCostElement legacyCe = createManualCostElement("Legacy Burden No Charge",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, 0);
			createManualCostRecord(product, as, legacyCe, 0, BigDecimal.ZERO, 10);

			// MCost.getCurrentCost should still include legacy burden (100 + 10% = 110)
			BigDecimal currentCost = MCost.getCurrentCost(product, 0, as, getAD_Org_ID(), as.getCostingMethod(),
					BigDecimal.ONE, 0, false, getTrxName());
			assertEquals(new BigDecimal("110.00"), currentCost.setScale(2, RoundingMode.HALF_UP),
					"Legacy cost element without C_Charge_ID should still be included in MCost.getCurrentCost");

			// MCost.getManualCosts should return empty
			ManualCost[] manualCosts = MCost.getManualCosts(product, 0, as, getAD_Org_ID(), new BigDecimal("100.00"),
					BigDecimal.ONE, getTrxName());
			assertEquals(0, manualCosts.length, "Cost element without C_Charge_ID must not be returned by getManualCosts");

			// Shipment posts DR COGS 110 / CR Asset 110 with no Charge Fact_Acct lines
			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("150.00"));
			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(2, facts.size(), "Legacy shipment should create only 2 Fact_Acct lines (COGS and Asset)");

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			assertFactTotals(facts, cogsAcctId, new BigDecimal("110.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("110.00"));
		}
	}

	@Test
	public void testDocLineGetTotalProductCosts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostDocLineProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("DocLine Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("DocLine Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			MInOutLine shipLine = shipment.getLines()[0];

			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, shipment.get_ID(), getTrxName());
			assertNotNull(doc, "Doc_InOut not resolved");
			DocLine docLine = new DocLine(shipLine, doc);
			docLine.setQty(shipLine.getMovementQty(), true);

			BigDecimal materialOnly = docLine.getProductCosts(as, shipLine.getAD_Org_ID(), false);
			BigDecimal totalCosts = docLine.getTotalProductCosts(as, shipLine.getAD_Org_ID(), false);
			assertEquals(new BigDecimal("200.00"), materialOnly.setScale(2, RoundingMode.HALF_UP),
					"DocLine.getProductCosts should return material cost only");
			assertEquals(new BigDecimal("230.00"), totalCosts.setScale(2, RoundingMode.HALF_UP),
					"DocLine.getTotalProductCosts should return material + manual costs");
		}
	}

	@Test
	public void testPriceListCreateIncludesManualCosts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostPLProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			createPOAndMR(product, null, new BigDecimal("2"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("PL Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("PL Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MDiscountSchema ds = new MDiscountSchema(Env.getCtx(), 0, getTrxName());
			ds.setName("ManualCost CostPlus Schema");
			ds.setDiscountType(MDiscountSchema.DISCOUNTTYPE_Pricelist);
			ds.setValidFrom(getLoginDate());
			ds.saveEx();

			MDiscountSchemaLine dsl = new MDiscountSchemaLine(Env.getCtx(), 0, getTrxName());
			dsl.setM_DiscountSchema_ID(ds.get_ID());
			dsl.setSeqNo(10);
			dsl.setM_Product_ID(product.get_ID());
			dsl.setConversionDate(getLoginDate());
			dsl.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
			dsl.setList_Base(MDiscountSchemaLine.LIST_BASE_ProductCost);
			dsl.setList_AddAmt(BigDecimal.ZERO);
			dsl.setList_Discount(BigDecimal.ZERO);
			dsl.setStd_Base(MDiscountSchemaLine.STD_BASE_ProductCost);
			dsl.setStd_AddAmt(BigDecimal.ZERO);
			dsl.setStd_Discount(BigDecimal.ZERO);
			dsl.setLimit_Base(MDiscountSchemaLine.LIMIT_BASE_ProductCost);
			dsl.setLimit_AddAmt(BigDecimal.ZERO);
			dsl.setLimit_Discount(BigDecimal.ZERO);
			dsl.setList_Rounding(MDiscountSchemaLine.LIST_ROUNDING_CurrencyPrecision);
			dsl.setStd_Rounding(MDiscountSchemaLine.STD_ROUNDING_CurrencyPrecision);
			dsl.setLimit_Rounding(MDiscountSchemaLine.LIMIT_ROUNDING_CurrencyPrecision);
			dsl.saveEx();

			MPriceList pl = new MPriceList(Env.getCtx(), 0, getTrxName());
			pl.setName("ManualCost Target PL");
			pl.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			pl.setIsSOPriceList(true);
			pl.saveEx();

			MPriceListVersion targetPlv = new MPriceListVersion(pl);
			targetPlv.setName("ManualCost Target PLV");
			targetPlv.setValidFrom(getLoginDate());
			targetPlv.setM_DiscountSchema_ID(ds.get_ID());
			targetPlv.setM_Pricelist_Version_Base_ID(
					MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(getLoginDate()).get_ID());
			targetPlv.saveEx();

			int processId = new Query(Env.getCtx(), MProcess.Table_Name, "Classname=?", getTrxName())
					.setParameters(M_PriceList_Create.class.getName())
					.firstId();
			assertTrue(processId > 0, "M_PriceList_Create process not found");

			MProcess process = MProcess.get(Env.getCtx(), processId);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(targetPlv.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			MProductPrice generatedPrice = MProductPrice.get(Env.getCtx(), targetPlv.get_ID(), product.get_ID(), getTrxName());
			assertNotNull(generatedPrice, "MProductPrice was not generated");
			// 100.00 material + 10.00 (10%) + 5.00 fixed = 115.00
			assertEquals(new BigDecimal("115.00"), generatedPrice.getPriceStd().setScale(2, RoundingMode.HALF_UP),
					"Cost-based PriceList creation should include manual costs");
		}
	}

	@Test
	public void testPriceListCreateIncludesFixedManualCostWhenMaterialCostZero()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			// Product with zero material cost and a fixed charge-linked manual cost
			MProduct productWithManual = createStockedProduct("ManualCostZeroMatPLProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, productWithManual);

			// Product with zero material cost and no manual cost (add fallback must still apply)
			MProduct productNoCost = createStockedProduct("ManualCostNoCostPLProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, productNoCost);

			MCostElement burdenCe = createManualCostElement("PL ZeroMat Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("PL ZeroMat Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(productWithManual, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(productWithManual, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MDiscountSchema ds = new MDiscountSchema(Env.getCtx(), 0, getTrxName());
			ds.setName("ManualCost ZeroMat Schema");
			ds.setDiscountType(MDiscountSchema.DISCOUNTTYPE_Pricelist);
			ds.setValidFrom(getLoginDate());
			ds.saveEx();

			MDiscountSchemaLine dsl1 = new MDiscountSchemaLine(Env.getCtx(), 0, getTrxName());
			dsl1.setM_DiscountSchema_ID(ds.get_ID());
			dsl1.setSeqNo(10);
			dsl1.setM_Product_ID(productWithManual.get_ID());
			dsl1.setConversionDate(getLoginDate());
			dsl1.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
			dsl1.setList_Base(MDiscountSchemaLine.LIST_BASE_ProductCost);
			dsl1.setList_AddAmt(new BigDecimal("2.00"));
			dsl1.setList_Discount(BigDecimal.ZERO);
			dsl1.setStd_Base(MDiscountSchemaLine.STD_BASE_ProductCost);
			dsl1.setStd_AddAmt(new BigDecimal("2.00"));
			dsl1.setStd_Discount(BigDecimal.ZERO);
			dsl1.setLimit_Base(MDiscountSchemaLine.LIMIT_BASE_ProductCost);
			dsl1.setLimit_AddAmt(new BigDecimal("2.00"));
			dsl1.setLimit_Discount(BigDecimal.ZERO);
			dsl1.setList_Rounding(MDiscountSchemaLine.LIST_ROUNDING_CurrencyPrecision);
			dsl1.setStd_Rounding(MDiscountSchemaLine.STD_ROUNDING_CurrencyPrecision);
			dsl1.setLimit_Rounding(MDiscountSchemaLine.LIMIT_ROUNDING_CurrencyPrecision);
			dsl1.saveEx();

			MDiscountSchemaLine dsl2 = new MDiscountSchemaLine(Env.getCtx(), 0, getTrxName());
			dsl2.setM_DiscountSchema_ID(ds.get_ID());
			dsl2.setSeqNo(20);
			dsl2.setM_Product_ID(productNoCost.get_ID());
			dsl2.setConversionDate(getLoginDate());
			dsl2.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
			dsl2.setList_Base(MDiscountSchemaLine.LIST_BASE_ProductCost);
			dsl2.setList_AddAmt(new BigDecimal("2.00"));
			dsl2.setList_Discount(BigDecimal.ZERO);
			dsl2.setStd_Base(MDiscountSchemaLine.STD_BASE_ProductCost);
			dsl2.setStd_AddAmt(new BigDecimal("2.00"));
			dsl2.setStd_Discount(BigDecimal.ZERO);
			dsl2.setLimit_Base(MDiscountSchemaLine.LIMIT_BASE_ProductCost);
			dsl2.setLimit_AddAmt(new BigDecimal("2.00"));
			dsl2.setLimit_Discount(BigDecimal.ZERO);
			dsl2.setList_Rounding(MDiscountSchemaLine.LIST_ROUNDING_CurrencyPrecision);
			dsl2.setStd_Rounding(MDiscountSchemaLine.STD_ROUNDING_CurrencyPrecision);
			dsl2.setLimit_Rounding(MDiscountSchemaLine.LIMIT_ROUNDING_CurrencyPrecision);
			dsl2.saveEx();

			MPriceList pl = new MPriceList(Env.getCtx(), 0, getTrxName());
			pl.setName("ManualCost ZeroMat Target PL");
			pl.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			pl.setIsSOPriceList(true);
			pl.saveEx();

			MPriceListVersion targetPlv = new MPriceListVersion(pl);
			targetPlv.setName("ManualCost ZeroMat Target PLV");
			targetPlv.setValidFrom(getLoginDate());
			targetPlv.setM_DiscountSchema_ID(ds.get_ID());
			targetPlv.setM_Pricelist_Version_Base_ID(
					MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(getLoginDate()).get_ID());
			targetPlv.saveEx();

			int processId = new Query(Env.getCtx(), MProcess.Table_Name, "Classname=?", getTrxName())
					.setParameters(M_PriceList_Create.class.getName())
					.firstId();
			assertTrue(processId > 0, "M_PriceList_Create process not found");

			MProcess process = MProcess.get(Env.getCtx(), processId);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(targetPlv.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			MProductPrice generatedWithManual = MProductPrice.get(Env.getCtx(), targetPlv.get_ID(), productWithManual.get_ID(), getTrxName());
			assertNotNull(generatedWithManual, "MProductPrice was not generated for product with fixed manual cost");
			// 0.00 material + 0.00 (10% of 0) + 5.00 fixed = 5.00
			assertEquals(new BigDecimal("5.00"), generatedWithManual.getPriceStd().setScale(2, RoundingMode.HALF_UP),
					"Cost-based PriceList creation should include fixed manual cost when material cost is zero");

			MProductPrice generatedNoCost = MProductPrice.get(Env.getCtx(), targetPlv.get_ID(), productNoCost.get_ID(), getTrxName());
			assertNotNull(generatedNoCost, "MProductPrice was not generated for product with no costs");
			// No material or manual cost -> costs stays null -> add fallback (0.00 + 2.00 = 2.00) still applies
			assertEquals(new BigDecimal("2.00"), generatedNoCost.getPriceStd().setScale(2, RoundingMode.HALF_UP),
					"Existing add fallback should still apply when neither material nor manual cost exists");
		}
	}

	@Test
	public void testLaborCostLookupDistinguishesGenuineZeroFromUnavailable() throws SQLException
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		// 1. Missing expense line ID returns null (unavailable), not Env.ZERO
		MTimeExpense te = new MTimeExpense(Env.getCtx(), 0, getTrxName());
		te.setC_BPartner_ID(DictionaryIDs.C_BPartner.GARDEN_USER.id);
		te.setDateReport(getLoginDate());
		te.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		te.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
		te.setDocStatus(DocAction.STATUS_Drafted);
		te.setDocAction(DocAction.ACTION_Complete);
		te.saveEx();

		MTimeExpenseLine deletedLine = new MTimeExpenseLine(Env.getCtx(), 0, getTrxName());
		deletedLine.setS_TimeExpense_ID(te.get_ID());
		deletedLine.setLine(5);
		deletedLine.setDateExpense(getLoginDate());
		deletedLine.setC_Currency_ID(te.getC_Currency_ID());
		deletedLine.setQty(BigDecimal.ONE);
		deletedLine.setExpenseAmt(BigDecimal.TEN);
		deletedLine.setConvertedAmt(BigDecimal.TEN);
		deletedLine.saveEx();
		int absentId = deletedLine.get_ID();
		deletedLine.deleteEx(true);

		MTimeExpenseLine missing = new MTimeExpenseLine(Env.getCtx(), 0, getTrxName());
		missing.setS_TimeExpenseLine_ID(absentId);
		assertNull(missing.getLaborCost(as), "Missing S_TimeExpenseLine row must return null, not zero");

		// 2. Genuine zero ConvertedAmt returns BigDecimal.ZERO (non-null)
		MTimeExpenseLine zeroLine = new MTimeExpenseLine(Env.getCtx(), 0, getTrxName());
		zeroLine.setS_TimeExpense_ID(te.get_ID());
		zeroLine.setLine(10);
		zeroLine.setDateExpense(getLoginDate());
		zeroLine.setC_Currency_ID(te.getC_Currency_ID());
		zeroLine.setQty(BigDecimal.ONE);
		zeroLine.setExpenseAmt(BigDecimal.ZERO);
		zeroLine.setConvertedAmt(BigDecimal.ZERO);
		zeroLine.saveEx();

		BigDecimal zeroLabor = zeroLine.getLaborCost(as);
		assertNotNull(zeroLabor, "Genuine zero-cost expense line must return non-null zero");
		assertEquals(0, zeroLabor.signum(), "Genuine zero-cost expense line must return 0");

		// 3. JDBC SQLException enters catch(SQLException) and propagates wrapped in DBException
		SQLException sqlEx = new SQLException("simulated labor lookup failure");
		CPreparedStatement mockPstmt = mock(CPreparedStatement.class);
		when(mockPstmt.executeQuery()).thenThrow(sqlEx);
		try (MockedStatic<DB> mockedDb = mockStatic(DB.class, Mockito.CALLS_REAL_METHODS))
		{
			mockedDb.when(() -> DB.prepareStatement(any(String.class), any())).thenReturn(mockPstmt);
			DBException thrown = assertThrows(DBException.class, () -> zeroLine.getLaborCost(as),
					"Database failure in getLaborCost must propagate instead of returning zero");
			assertSame(sqlEx, thrown.getCause(), "DBException must wrap the underlying SQLException");
		}
	}

	@Test
	public void testMissingManualChargeExpenseAccountErrorNamesChargeAndSchema()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("MissingChgAcctProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCharge unconfiguredCharge = new MCharge(Env.getCtx(), 0, getTrxName());
			unconfiguredCharge.setName("Unconfigured Manual Cost Charge");
			unconfiguredCharge.setChargeAmt(BigDecimal.ZERO);
			unconfiguredCharge.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			unconfiguredCharge.saveEx();
			// Delete C_Charge_Acct for this accounting schema so MCharge.getAccount returns null
			DB.executeUpdateEx("DELETE FROM C_Charge_Acct WHERE C_Charge_ID=? AND C_AcctSchema_ID=?",
					new Object[] { unconfiguredCharge.get_ID(), as.get_ID() }, getTrxName());

			MCostElement badCe = createManualCostElement("MissingAcct Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, unconfiguredCharge.get_ID());
			createManualCostRecord(product, as, badCe, 0, new BigDecimal("5.00"), 0);

			// 1. Sales Shipment (CR branch)
			MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
			so.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			so.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			so.setDeliveryRule(MOrder.DELIVERYRULE_Force);
			so.setDocStatus(DocAction.STATUS_Drafted);
			so.setDocAction(DocAction.ACTION_Complete);
			so.setDateOrdered(getLoginDate());
			so.setDateAcct(getLoginDate());
			so.setDatePromised(getLoginDate());
			so.setIsSOTrx(true);
			so.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			so.saveEx();

			MOrderLine soLine = new MOrderLine(so);
			soLine.setLine(10);
			soLine.setProduct(product);
			soLine.setQty(new BigDecimal("2"));
			soLine.setDatePromised(getLoginDate());
			soLine.setPrice(new BigDecimal("150.00"));
			soLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(so, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			MInOut shipment = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, so.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			MInOutLine shipLine = new MInOutLine(shipment);
			shipLine.setOrderLine(soLine, 0, new BigDecimal("2"));
			shipLine.setQty(new BigDecimal("2"));
			shipLine.saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
			}

			String shipErr = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(),
					shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
			assertNotNull(shipErr, "Shipment posting must fail when manual charge has no expense account");
			assertTrue(shipErr.contains(unconfiguredCharge.getName()),
					"Shipment CR error must name the charge: " + shipErr);
			assertTrue(shipErr.contains(as.getName()),
					"Shipment CR error must name the accounting schema: " + shipErr);

			// 2. Customer Return (DR branch)
			MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
			rma.setName("MissingAcct RMA");
			rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
			rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
			rma.setM_InOut_ID(shipment.get_ID());
			rma.setIsSOTrx(true);
			rma.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			rma.saveEx();

			MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
			rmaLine.setLine(10);
			rmaLine.setM_RMA_ID(rma.get_ID());
			rmaLine.setM_InOutLine_ID(shipLine.get_ID());
			rmaLine.setQty(BigDecimal.ONE);
			rmaLine.saveEx();
			info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			MInOut customerReturn = new MInOut(Env.getCtx(), 0, getTrxName());
			customerReturn.setM_RMA_ID(rma.get_ID());
			customerReturn.setBPartner(MBPartner.get(Env.getCtx(), shipment.getC_BPartner_ID()));
			customerReturn.setC_DocType_ID(DictionaryIDs.C_DocType.MM_CUSTOMER_RETURN.id);
			customerReturn.setMovementType(MInOut.MOVEMENTTYPE_CustomerReturns);
			customerReturn.setIsSOTrx(true);
			customerReturn.setMovementDate(shipment.getMovementDate());
			customerReturn.setDateAcct(shipment.getDateAcct());
			customerReturn.setDocStatus(DocAction.STATUS_Drafted);
			customerReturn.setDocAction(DocAction.ACTION_Complete);
			customerReturn.setM_Warehouse_ID(shipment.getM_Warehouse_ID());
			customerReturn.saveEx();

			MInOutLine retLine = new MInOutLine(customerReturn);
			retLine.setM_RMALine_ID(rmaLine.get_ID());
			retLine.setLine(10);
			retLine.setProduct(product);
			retLine.setM_Locator_ID(shipLine.getM_Locator_ID());
			retLine.setQty(BigDecimal.ONE);
			retLine.saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(customerReturn, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				customerReturn.load(getTrxName());
				if (!DocAction.STATUS_Completed.equals(customerReturn.getDocStatus()))
				{
					for (MInOutConfirm confirm : customerReturn.getConfirmations(true))
					{
						if (!DocAction.STATUS_Completed.equals(confirm.getDocStatus()))
						{
							info = MWorkflow.runDocumentActionWorkflow(confirm, DocAction.ACTION_Complete);
							assertFalse(info.isError(), info.getSummary());
						}
					}
					customerReturn.load(getTrxName());
					if (!DocAction.STATUS_Completed.equals(customerReturn.getDocStatus()))
					{
						info = MWorkflow.runDocumentActionWorkflow(customerReturn, DocAction.ACTION_Complete);
						assertFalse(info.isError(), info.getSummary());
					}
				}
			}

			String retErr = DocumentEngine.postImmediate(Env.getCtx(), customerReturn.getAD_Client_ID(),
					customerReturn.get_Table_ID(), customerReturn.get_ID(), false, getTrxName());
			assertNotNull(retErr, "Customer return posting must fail when manual charge has no expense account");
			assertTrue(retErr.contains(unconfiguredCharge.getName()),
					"Customer return DR error must name the charge: " + retErr);
			assertTrue(retErr.contains(as.getName()),
					"Customer return DR error must name the accounting schema: " + retErr);
		}
	}





	@Test
	public void testManualCostDetailLifecycleAndCleanup()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostDetailLifeProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("Lifecycle Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MAccount expectedChargeVc = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(expectedChargeVc);

			// 1. Forward shipment persists M_ManualCostDetail with Amt = +20.00
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			MInOutLine shipLine = shipment.getLines(true)[0];
			List<MManualCostDetail> origDetails = MManualCostDetail.getByLine(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, shipment.get_ID(), shipLine.get_ID(), getTrxName());
			assertEquals(1, origDetails.size(), "Forward shipment should persist 1 M_ManualCostDetail");
			MManualCostDetail origMcd = origDetails.get(0);
			assertEquals(burdenCe.get_ID(), origMcd.getM_CostElement_ID());
			assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, origMcd.getC_Charge_ID());
			assertEquals(expectedChargeVc.getC_ValidCombination_ID(), origMcd.getC_ValidCombination_ID());
			assertEquals(product.get_ID(), origMcd.getM_Product_ID());
			assertEquals(new BigDecimal("20.00"), origMcd.getAmt().setScale(2, RoundingMode.HALF_UP));

			// 2. Reversal persists negated M_ManualCostDetail with Amt = -20.00 (net = 0)
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Reversal posting failed: " + error);
			}
			MInOutLine revLine = reversal.getLines(true)[0];
			List<MManualCostDetail> revDetails = MManualCostDetail.getByLine(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, reversal.get_ID(), revLine.get_ID(), getTrxName());
			assertEquals(1, revDetails.size(), "Reversal shipment should persist 1 negated M_ManualCostDetail");
			assertEquals(new BigDecimal("-20.00"), revDetails.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(0, origMcd.getAmt().add(revDetails.get(0).getAmt()).signum(),
					"Forward and reversed M_ManualCostDetail must net to zero");

			// 3. Repost (Doc.deleteAcct) cleanly replaces M_ManualCostDetail without duplicates
			String repostErr = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(),
					shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNull(repostErr, "Repost of shipment failed: " + repostErr);
			List<MManualCostDetail> afterRepost = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, shipment.get_ID(), getTrxName());
			assertEquals(1, afterRepost.size(), "Repost must delete old M_ManualCostDetail before creating new row");
			assertTrue(afterRepost.get(0).get_ID() != origMcd.get_ID(), "Repost should create a fresh M_ManualCostDetail row");

			// 4. MFactAcct.deleteEx also deletes M_ManualCostDetail
			MFactAcct.deleteEx(MInOut.Table_ID, reversal.get_ID(), getTrxName());
			assertFalse(MManualCostDetail.hasForRecord(as.get_ID(), MInOut.Table_ID, reversal.get_ID(), getTrxName()),
					"MFactAcct.deleteEx must delete M_ManualCostDetail rows");

			// Repost reversal so both documents are posted again before FactAcctReset
			reversal.setPosted(false);
			reversal.saveEx();
			String repostRevErr = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
					reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertNull(repostRevErr, "Repost of reversal failed: " + repostRevErr);
			assertTrue(MManualCostDetail.hasForRecord(as.get_ID(), MInOut.Table_ID, reversal.get_ID(), getTrxName()));

			// 5. FactAcctReset deletes matching M_ManualCostDetail alongside Fact_Acct
			MProcess resetProcess = new Query(Env.getCtx(), MProcess.Table_Name, "Value=?", getTrxName())
					.setParameters("Fact_Acct_Reset")
					.first();
			assertNotNull(resetProcess, "Fact_Acct_Reset process not found");
			ProcessInfo pi = new ProcessInfo(resetProcess.getName(), resetProcess.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setTransactionName(getTrxName());
			pi.setParameter(new ProcessInfoParameter[] {
					new ProcessInfoParameter("AD_Client_ID", BigDecimal.valueOf(getAD_Client_ID()), null, null, null),
					new ProcessInfoParameter("AD_Table_ID", BigDecimal.valueOf(MInOut.Table_ID), null, null, null),
					new ProcessInfoParameter("DeletePosting", "Y", null, null, null),
					new ProcessInfoParameter("DateAcct", getLoginDate(), getLoginDate(), null, null),
			});
			assertFalse(getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()).isEmpty(),
					"Shipment Fact_Acct rows must exist before FactAcctReset");
			assertFalse(getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID()).isEmpty(),
					"Reversal Fact_Acct rows must exist before FactAcctReset");
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), "FactAcctReset failed: " + pi.getSummary());
			assertTrue(getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()).isEmpty(),
					"FactAcctReset must delete shipment Fact_Acct rows");
			assertTrue(getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID()).isEmpty(),
					"FactAcctReset must delete reversal Fact_Acct rows");
			assertFalse(MManualCostDetail.hasForRecord(as.get_ID(), MInOut.Table_ID, shipment.get_ID(), getTrxName()),
					"FactAcctReset must delete shipment M_ManualCostDetail");
			assertFalse(MManualCostDetail.hasForRecord(as.get_ID(), MInOut.Table_ID, reversal.get_ID(), getTrxName()),
					"FactAcctReset must delete reversal M_ManualCostDetail");
		}
	}

	@Test
	public void testHasChargeManualCostElementsGating()
	{
		assertFalse(MCost.hasChargeManualCostElements(getAD_Client_ID(), getTrxName()),
				"GardenWorld default seed should not have active charge-mapped manual cost elements");

		MCostElement legacyCe = createManualCostElement("Gate Legacy No Charge",
				MCostElement.COSTELEMENTTYPE_Overhead, 0);
		assertNotNull(legacyCe);
		assertFalse(MCost.hasChargeManualCostElements(getAD_Client_ID(), getTrxName()),
				"Manual cost element without C_Charge_ID must not activate gating");

		MCostElement chargeCe = createManualCostElement("Gate Charged Burden",
				MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
		assertTrue(MCost.hasChargeManualCostElements(getAD_Client_ID(), getTrxName()),
				"Active charge-mapped manual cost element must activate gating");

		chargeCe.setIsActive(false);
		chargeCe.saveEx();
		assertFalse(MCost.hasChargeManualCostElements(getAD_Client_ID(), getTrxName()),
				"Deactivated charge-mapped manual cost element must not activate gating");
	}
}
