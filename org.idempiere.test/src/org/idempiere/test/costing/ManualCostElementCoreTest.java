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
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MDiscountSchema;
import org.compiere.model.MDiscountSchemaLine;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MOrder;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.process.DocumentEngine;
import org.compiere.process.M_PriceList_Create;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Core model, price list, and manual cost detail lifecycle tests for IDEMPIERE-7231.
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
		MCostElement manualCe = createManualCostElement("Test Burden With Charge",
				MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
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

			MDiscountSchema ds = createPricelistDiscountSchema("ManualCost CostPlus Schema");
			addCostPlusDiscountLine(ds, 10, product, BigDecimal.ZERO);
			MPriceListVersion targetPlv = runPriceListCreate("ManualCost Target", ds);

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
			MProduct productWithManual = createStockedProduct("ManualCostZeroMatPLProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, productWithManual);
			MProduct productNoCost = createStockedProduct("ManualCostNoCostPLProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, productNoCost);

			MCostElement burdenCe = createManualCostElement("PL ZeroMat Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("PL ZeroMat Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(productWithManual, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(productWithManual, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MDiscountSchema ds = createPricelistDiscountSchema("ManualCost ZeroMat Schema");
			addCostPlusDiscountLine(ds, 10, productWithManual, new BigDecimal("2.00"));
			addCostPlusDiscountLine(ds, 20, productNoCost, new BigDecimal("2.00"));
			MPriceListVersion targetPlv = runPriceListCreate("ManualCost ZeroMat Target", ds);

			MProductPrice generatedWithManual = MProductPrice.get(Env.getCtx(), targetPlv.get_ID(), productWithManual.get_ID(), getTrxName());
			assertNotNull(generatedWithManual, "MProductPrice was not generated for product with fixed manual cost");
			// 0.00 material + 0.00 (10% of 0) + 5.00 fixed = 5.00
			assertEquals(new BigDecimal("5.00"), generatedWithManual.getPriceStd().setScale(2, RoundingMode.HALF_UP),
					"Cost-based PriceList creation should include fixed manual cost when material cost is zero");

			MProductPrice generatedNoCost = MProductPrice.get(Env.getCtx(), targetPlv.get_ID(), productNoCost.get_ID(), getTrxName());
			assertNotNull(generatedNoCost, "MProductPrice was not generated for product with no costs");
			// No material or manual cost -> add fallback (0.00 + 2.00 = 2.00) still applies
			assertEquals(new BigDecimal("2.00"), generatedNoCost.getPriceStd().setScale(2, RoundingMode.HALF_UP),
					"Existing add fallback should still apply when neither material nor manual cost exists");
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
			DB.executeUpdateEx("DELETE FROM C_Charge_Acct WHERE C_Charge_ID=? AND C_AcctSchema_ID=?",
					new Object[] { unconfiguredCharge.get_ID(), as.get_ID() }, getTrxName());

			MCostElement badCe = createManualCostElement("MissingAcct Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, unconfiguredCharge.get_ID());
			createManualCostRecord(product, as, badCe, 0, new BigDecimal("5.00"), 0);

			// 1. Sales Shipment (CR branch)
			MOrder so = createCompletedSO(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id), 0,
					product, null, new BigDecimal("2"), new BigDecimal("150.00"), getLoginDate(), true);
			MInOut shipment = createDraftShipment(so, so.getLines()[0], null, new BigDecimal("2"), so.getDateOrdered());
			runDeferred(() -> complete(shipment));

			String shipErr = tryPostImmediate(shipment);
			assertNotNull(shipErr, "Shipment posting must fail when manual charge has no expense account");
			assertTrue(shipErr.contains(unconfiguredCharge.getName()), "Shipment CR error must name the charge: " + shipErr);
			assertTrue(shipErr.contains(as.getName()), "Shipment CR error must name the accounting schema: " + shipErr);

			// 2. Customer Return (DR branch)
			MInOut customerReturn = createDraftCustomerReturn(shipment, shipment.getLines()[0], BigDecimal.ONE);
			runDeferred(() -> completeCustomerReturn(customerReturn));

			String retErr = tryPostImmediate(customerReturn);
			assertNotNull(retErr, "Customer return posting must fail when manual charge has no expense account");
			assertTrue(retErr.contains(unconfiguredCharge.getName()), "Customer return DR error must name the charge: " + retErr);
			assertTrue(retErr.contains(as.getName()), "Customer return DR error must name the accounting schema: " + retErr);
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
			MInOut reversal = reverseAndPost(shipment);
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
			postImmediate(reversal);
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
			assertFalse(getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()).isEmpty());
			assertFalse(getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID()).isEmpty());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), "FactAcctReset failed: " + pi.getSummary());
			assertTrue(getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()).isEmpty());
			assertTrue(getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID()).isEmpty());
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

	private MDiscountSchema createPricelistDiscountSchema(String name)
	{
		MDiscountSchema ds = new MDiscountSchema(Env.getCtx(), 0, getTrxName());
		ds.setName(name);
		ds.setDiscountType(MDiscountSchema.DISCOUNTTYPE_Pricelist);
		ds.setValidFrom(getLoginDate());
		ds.saveEx();
		return ds;
	}

	private void addCostPlusDiscountLine(MDiscountSchema ds, int seqNo, MProduct product, BigDecimal addAmt)
	{
		MDiscountSchemaLine dsl = new MDiscountSchemaLine(Env.getCtx(), 0, getTrxName());
		dsl.setM_DiscountSchema_ID(ds.get_ID());
		dsl.setSeqNo(seqNo);
		dsl.setM_Product_ID(product.get_ID());
		dsl.setConversionDate(getLoginDate());
		dsl.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
		dsl.setList_Base(MDiscountSchemaLine.LIST_BASE_ProductCost);
		dsl.setList_AddAmt(addAmt);
		dsl.setList_Discount(BigDecimal.ZERO);
		dsl.setStd_Base(MDiscountSchemaLine.STD_BASE_ProductCost);
		dsl.setStd_AddAmt(addAmt);
		dsl.setStd_Discount(BigDecimal.ZERO);
		dsl.setLimit_Base(MDiscountSchemaLine.LIMIT_BASE_ProductCost);
		dsl.setLimit_AddAmt(addAmt);
		dsl.setLimit_Discount(BigDecimal.ZERO);
		dsl.setList_Rounding(MDiscountSchemaLine.LIST_ROUNDING_CurrencyPrecision);
		dsl.setStd_Rounding(MDiscountSchemaLine.STD_ROUNDING_CurrencyPrecision);
		dsl.setLimit_Rounding(MDiscountSchemaLine.LIMIT_ROUNDING_CurrencyPrecision);
		dsl.saveEx();
	}

	private MPriceListVersion runPriceListCreate(String namePrefix, MDiscountSchema ds)
	{
		MPriceList pl = new MPriceList(Env.getCtx(), 0, getTrxName());
		pl.setName(namePrefix + " PL");
		pl.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		pl.setIsSOPriceList(true);
		pl.saveEx();

		MPriceListVersion targetPlv = new MPriceListVersion(pl);
		targetPlv.setName(namePrefix + " PLV");
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
		return targetPlv;
	}
}
