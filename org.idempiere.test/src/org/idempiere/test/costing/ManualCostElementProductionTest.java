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
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mockStatic;

import java.lang.reflect.Proxy;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MCostQueue;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
import org.compiere.model.MProductionLineMA;
import org.compiere.model.MProductionPlan;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.util.CPreparedStatement;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.eevolution.model.MPPProductBOM;
import org.idempiere.acct.base.model.MDistribution;
import org.idempiere.acct.base.model.MDistributionLine;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Production and reversal tests for IDEMPIERE-7231.
 */
public class ManualCostElementProductionTest extends AbstractManualCostElementTest
{
	@Test
	public void testProductionWithComponentManualCosts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct component = createStockedProduct("ManualCostComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, component);
			MProduct finished = createBomProduct("ManualCostFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);
			createPOAndMR(component, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("Prod Component Burden",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("Prod Component Overhead",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(component, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(component, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MPPProductBOM bom = createSimpleBOM(finished, component, new BigDecimal("2"));
			MProduction production = createProduction(finished, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);
			completeAndPost(production);

			// Verify Fact_Acct: DR Finished Asset 230, CR Component Asset 200, CR Freight Charge 20 + 10
			List<MFactAcct> facts = getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID());
			assertEquals(4, facts.size());

			int fgAssetAcctId = new ProductCost(Env.getCtx(), finished.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int compAssetAcctId = new ProductCost(Env.getCtx(), component.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			BigDecimal fgDr = BigDecimal.ZERO;
			BigDecimal compCr = BigDecimal.ZERO;
			List<BigDecimal> chargeCredits = new ArrayList<>();
			for (MFactAcct fa : facts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID());
					chargeCredits.add(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP));
				}
				else if (fa.getM_Product_ID() == finished.get_ID())
				{
					assertEquals(fgAssetAcctId, fa.getAccount_ID());
					fgDr = fgDr.add(fa.getAmtAcctDr());
				}
				else if (fa.getM_Product_ID() == component.get_ID())
				{
					assertEquals(compAssetAcctId, fa.getAccount_ID());
					compCr = compCr.add(fa.getAmtAcctCr());
				}
			}
			assertEquals(new BigDecimal("230.00"), fgDr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("200.00"), compCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(2, chargeCredits.size());
			assertTrue(chargeCredits.contains(new BigDecimal("20.00")));
			assertTrue(chargeCredits.contains(new BigDecimal("10.00")));

			// Finished goods MCost should now be 230.00; Component MCostDetail should be -200.00
			BigDecimal fgCost = MCost.getCurrentCost(finished, 0, as, getAD_Org_ID(), as.getCostingMethod(),
					BigDecimal.ONE, 0, false, getTrxName());
			assertEquals(new BigDecimal("230.00"), fgCost.setScale(2, RoundingMode.HALF_UP));

			for (MProductionLine pl : production.getLines())
			{
				if (pl.getM_Product_ID() == component.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, component.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd);
					assertEquals(new BigDecimal("-200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));
				}
			}

			// Mutate cost elements BEFORE reversing production
			burdenCe.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			burdenCe.saveEx();
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			MProduction reversal = reverseAndPost(production);
			List<MFactAcct> revFacts = getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size());
			BigDecimal fgCr = BigDecimal.ZERO;
			BigDecimal compDr = BigDecimal.ZERO;
			List<BigDecimal> revChargeDebits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID());
					revChargeDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				}
				else if (fa.getM_Product_ID() == finished.get_ID())
				{
					assertEquals(fgAssetAcctId, fa.getAccount_ID());
					fgCr = fgCr.add(fa.getAmtAcctCr());
				}
				else if (fa.getM_Product_ID() == component.get_ID())
				{
					assertEquals(compAssetAcctId, fa.getAccount_ID());
					compDr = compDr.add(fa.getAmtAcctDr());
				}
			}
			assertEquals(new BigDecimal("230.00"), fgCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("200.00"), compDr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(2, revChargeDebits.size());
			assertTrue(revChargeDebits.contains(new BigDecimal("20.00")));
			assertTrue(revChargeDebits.contains(new BigDecimal("10.00")));

			for (MProductionLine pl : reversal.getLines())
			{
				if (pl.getM_Product_ID() == finished.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, finished.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd);
					assertEquals(new BigDecimal("-230.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));
				}
				else if (pl.getM_Product_ID() == component.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, component.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd);
					assertEquals(new BigDecimal("200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));
				}
			}
		}
	}

	@Test
	public void testShipmentAndProductionReversalWhenGLDistributionClearsCharge()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			int commissionsAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName()).getAccount_ID();

			MDistribution chargeDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			chargeDist.setName("Test Clear Charge GL Dist");
			chargeDist.setC_AcctSchema_ID(as.get_ID());
			chargeDist.setIsCreateReversal(false);
			chargeDist.setAnyAcct(false);
			chargeDist.setAccount_ID(freightAcctId);
			chargeDist.setAnyCharge(false);
			chargeDist.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			chargeDist.saveEx();

			for (int[] pctAndLine : new int[][] { { 10, 60 }, { 20, 40 } })
			{
				MDistributionLine dl = new MDistributionLine(Env.getCtx(), 0, getTrxName());
				dl.setGL_Distribution_ID(chargeDist.get_ID());
				dl.setLine(pctAndLine[0]);
				dl.setPercent(BigDecimal.valueOf(pctAndLine[1]));
				dl.setOverwriteAcct(true);
				dl.setAccount_ID(commissionsAcctId);
				dl.setOverwriteCharge(true);
				dl.setC_Charge_ID(0);
				dl.saveEx();
			}
			chargeDist.load(getTrxName());
			chargeDist.getLines(true);
			assertTrue(chargeDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { chargeDist });

			// 1. Shipment + Reversal with GL distribution clearing C_Charge_ID
			MProduct shipProd = createStockedProduct("GLDistClearChgShipProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, shipProd);
			createPOAndMR(shipProd, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("GLDistClearChg Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(shipProd, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(shipProd, null, new BigDecimal("2"), new BigDecimal("180.00"));
			List<MFactAcct> shipFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(4, shipFacts.size());

			ProductCost shipPc = new ProductCost(Env.getCtx(), shipProd.get_ID(), 0, getTrxName());
			int cogsAcctId = shipPc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int shipAssetAcctId = shipPc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			assertFactTotals(shipFacts, cogsAcctId, new BigDecimal("220.00"), BigDecimal.ZERO);
			assertFactTotals(shipFacts, shipAssetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(shipFacts, commissionsAcctId, BigDecimal.ZERO, new BigDecimal("20.00"));
			for (MFactAcct fa : shipFacts)
				if (fa.getAccount_ID() == commissionsAcctId)
					assertEquals(0, fa.getC_Charge_ID());

			MInOut shipReversal = reverseAndPost(shipment);
			List<MFactAcct> shipRevFacts = getFacts(MInOut.Table_ID, shipReversal.get_ID(), as.get_ID());
			assertEquals(4, shipRevFacts.size());
			assertFactTotals(shipRevFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("220.00"));
			assertFactTotals(shipRevFacts, shipAssetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(shipRevFacts, commissionsAcctId, new BigDecimal("20.00"), BigDecimal.ZERO);

			// 2. Production + Reversal with GL distribution clearing C_Charge_ID
			MProduct comp = createStockedProduct("GLDistClearChgComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("GLDistClearChgFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = createSimpleBOM(fg, comp, new BigDecimal("2"));
			MProduction production = createProduction(fg, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);
			completeAndPost(production);

			List<MFactAcct> prodFacts = getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID());
			assertEquals(4, prodFacts.size());
			assertFactTotals(prodFacts, commissionsAcctId, BigDecimal.ZERO, new BigDecimal("20.00"));
			for (MFactAcct fa : prodFacts)
				if (fa.getAccount_ID() == commissionsAcctId)
					assertEquals(0, fa.getC_Charge_ID());

			MProduction prodReversal = reverseAndPost(production);
			List<MFactAcct> prodRevFacts = getFacts(MProduction.Table_ID, prodReversal.get_ID(), as.get_ID());
			assertEquals(4, prodRevFacts.size());
			BigDecimal fgCr = BigDecimal.ZERO;
			BigDecimal compDr = BigDecimal.ZERO;
			BigDecimal commDr = BigDecimal.ZERO;
			for (MFactAcct fa : prodRevFacts)
			{
				if (fa.getAccount_ID() == commissionsAcctId)
					commDr = commDr.add(fa.getAmtAcctDr());
				else if (fa.getM_Product_ID() == fg.get_ID())
					fgCr = fgCr.add(fa.getAmtAcctCr());
				else if (fa.getM_Product_ID() == comp.get_ID())
					compDr = compDr.add(fa.getAmtAcctDr());
			}
			assertEquals(new BigDecimal("220.00"), fgCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("200.00"), compDr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("20.00"), commDr.setScale(2, RoundingMode.HALF_UP));

			for (MProductionLine pl : prodReversal.getLines())
			{
				if (pl.getM_Product_ID() == fg.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, fg.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd);
					assertEquals(new BigDecimal("-220.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));
				}
				else if (pl.getM_Product_ID() == comp.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, comp.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd);
					assertEquals(new BigDecimal("200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));
				}
			}
		}
	}

	@Test
	public void testProductionReversalWaitsForOriginalPosting()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("ProdRevOrderComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("ProdRevOrderFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);
			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProdRevOrder Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCost burdenCost = createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = createSimpleBOM(fg, comp, new BigDecimal("2"));
			MProduction production = createProduction(fg, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);

			runDeferred(() -> {
				complete(production);
				assertFalse(production.isPosted());
				reverseCorrect(production);
			});

			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			assertFalse(reversal.isPosted());

			// Mutate manual cost percent before attempting to post reversal first
			burdenCost.setPercent(25);
			burdenCost.saveEx();

			String revFirstError = tryPostImmediate(reversal);
			assertNotNull(revFirstError, "Reversal production must not post before original production has posted");
			assertTrue(revFirstError.contains(Msg.getMsg(Env.getCtx(), "Original Production not posted yet")),
					"Unexpected error: " + revFirstError);
			reversal.load(getTrxName());
			assertFalse(reversal.isPosted());
			assertEquals(0, getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID()).size());

			// Post original (posts 25% = 50.00), mutate burden again to 40%, then post reversal -> replays exact 50.00
			postImmediate(production);
			burdenCost.setPercent(40);
			burdenCost.saveEx();
			postImmediate(reversal);

			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID()),
					freightAcctId, BigDecimal.ZERO, new BigDecimal("50.00"));
			assertFactTotals(getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID()),
					freightAcctId, new BigDecimal("50.00"), BigDecimal.ZERO);
		}
	}

	@Test
	public void testProductionExplicitAsiAndMaUseSameCostingPrecisionForPercentManualCost()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = createCategoryWithCosting("ProdPrecisionBatchCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, null, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("ProdPrecisionLotAS", mockedAttrSet);
			MProduct comp = createStockedProduct("ProdPrecisionComp", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("ProdPrecisionFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			MAttributeSetInstance lot1 = createLot(lotAs.get_ID(), "LOT-PREC-1");
			// Cost 10.006 with 50% burden: unrounded -10.006 * 50% = -5.003 -> -5.00 (not -5.01)
			createPOAndMR(comp, lot1, new BigDecimal("5"), new BigDecimal("10.006"));

			MCostElement burdenCe = createManualCostElement("ProdPrecision Burden 50pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, burdenCe, lot1.get_ID(), BigDecimal.ZERO, 50);

			MPPProductBOM bom = createSimpleBOM(fg, comp, BigDecimal.ONE);
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			// 1. Production with explicit ASI on component line
			MProduction prodExplicit = createProduction(fg, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);
			for (MProductionLine pl : prodExplicit.getLines())
			{
				if (pl.getM_Product_ID() == comp.get_ID())
				{
					pl.setM_AttributeSetInstance_ID(lot1.get_ID());
					pl.saveEx();
				}
			}
			completeAndPost(prodExplicit);
			assertFactTotals(getFacts(MProduction.Table_ID, prodExplicit.get_ID(), as.get_ID()),
					freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));

			// 2. Production with ASI=0 (allocated via MProductionLineMA)
			MProduction prodMa = createProduction(fg, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);
			completeAndPost(prodMa);
			assertFactTotals(getFacts(MProduction.Table_ID, prodMa.get_ID(), as.get_ID()),
					freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testProductionReversalCostDetailMatchesReversedInventoryWhenMaterialCostChanges()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("ProdCostDriftComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("ProdCostDriftFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);
			createPOAndMR(comp, null, new BigDecimal("2"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProdCostDrift Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = createSimpleBOM(fg, comp, BigDecimal.ONE);
			MProduction production = createProduction(fg, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);
			completeAndPost(production);

			// Post a real second receipt (1 unit @ 140.00) on the same date so Average PO moves from 100.00 to 120.00
			createPOAndMR(comp, null, BigDecimal.ONE, new BigDecimal("140.00"));
			ProductCost datedCheckPc = new ProductCost(Env.getCtx(), comp.get_ID(), 0, getTrxName());
			datedCheckPc.setQty(BigDecimal.ONE);
			BigDecimal datedCost = datedCheckPc.getProductCosts(as, getAD_Org_ID(),
					MCostElement.COSTINGMETHOD_AveragePO, 0, false, getLoginDate(), null, false);
			assertEquals(new BigDecimal("120.00"), datedCost.setScale(2, RoundingMode.HALF_UP));

			MProduction reversal = reverseAndPost(production);

			MProductionLine origCompLine = findLineByProduct(production, comp.get_ID());
			MProductionLine revCompLine = findLineByProduct(reversal, comp.get_ID());
			MCostDetail origCd = MCostDetail.getProduction(as, comp.get_ID(), 0, origCompLine.get_ID(), 0, getTrxName());
			MCostDetail revCd = MCostDetail.getProduction(as, comp.get_ID(), 0, revCompLine.get_ID(), 0, getTrxName());
			assertNotNull(origCd);
			assertNotNull(revCd);
			assertEquals(new BigDecimal("-100.00"), origCd.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("100.00"), revCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Reversal component M_CostDetail must match reversed inventory (+100.00), not drifted current cost (120.00)");
			assertEquals(origCd.getM_CostDetail_ID(), revCd.getRef_CostDetail_ID());

			int compAssetAcctId = new ProductCost(Env.getCtx(), comp.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			BigDecimal origCompAssetCr = sumLineAccount(getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID()),
					origCompLine.get_ID(), compAssetAcctId, false);
			BigDecimal revCompAssetDr = sumLineAccount(getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID()),
					revCompLine.get_ID(), compAssetAcctId, true);
			assertEquals(new BigDecimal("100.00"), origCompAssetCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("100.00"), revCompAssetDr.setScale(2, RoundingMode.HALF_UP));
		}
	}

	@Test
	public void testProductionReversalLoadFailureAbortsPostingAndUnlocksDocument() throws SQLException
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("ProdLoadFailComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("ProdLoadFailFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);
			createPOAndMR(comp, null, new BigDecimal("10"), new BigDecimal("50.00"));
			createSimpleBOM(fg, comp, BigDecimal.ONE);

			MProduction prod = createPlanProduction("TwoPlan LoadFail Production");
			for (int planLineNo : new int[] { 10, 20 })
			{
				MProductionPlan plan = createProductionPlan(prod, planLineNo, fg, BigDecimal.ONE);
				addProductionLine(null, plan, 10, fg, 0, true, BigDecimal.ONE);
				addProductionLine(null, plan, 20, comp, 0, false, BigDecimal.ONE.negate());
			}
			completeAndPost(prod);

			runDeferred(() -> reverseCorrect(prod));
			MProduction rev = new MProduction(Env.getCtx(), prod.getReversal_ID(), getTrxName());
			assertFalse(rev.isPosted());

			// Inject SQLException during Doc_Production.loadLines after reading plan 1's two rows
			try (MockedStatic<DB> mockedDb = mockStatic(DB.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedDb.when(() -> DB.prepareStatement(
						Mockito.<String>argThat(sql -> sql != null && sql.contains("M_ProductionLine pro_line")), Mockito.<String>any()))
						.thenAnswer(inv -> {
							CPreparedStatement realPstmt = (CPreparedStatement) inv.callRealMethod();
							return (CPreparedStatement) Proxy.newProxyInstance(
									CPreparedStatement.class.getClassLoader(),
									new Class<?>[] { CPreparedStatement.class },
									(proxy, method, args) -> {
										if ("executeQuery".equals(method.getName()) && (args == null || args.length == 0))
										{
											ResultSet realRs = realPstmt.executeQuery();
											int[] nextCalls = { 0 };
											return (ResultSet) Proxy.newProxyInstance(
													ResultSet.class.getClassLoader(),
													new Class<?>[] { ResultSet.class },
													(rsProxy, rsMethod, rsArgs) -> {
														if ("next".equals(rsMethod.getName()) && (rsArgs == null || rsArgs.length == 0))
														{
															if (++nextCalls[0] > 2)
																throw new SQLException("simulated partial plan load failure after plan 1");
														}
														try
														{
															return rsMethod.invoke(realRs, rsArgs);
														}
														catch (java.lang.reflect.InvocationTargetException ite)
														{
															throw ite.getCause();
														}
													});
										}
										try
										{
											return method.invoke(realPstmt, args);
										}
										catch (java.lang.reflect.InvocationTargetException ite)
										{
											throw ite.getCause();
										}
									});
						});
				assertThrows(DBException.class, () -> tryPostImmediate(rev),
						"Current-line load failure after partial read must abort posting instead of replaying partial lines");
			}

			rev.load(getTrxName());
			assertFalse(rev.isPosted());
			assertFalse(rev.isProcessing(), "Doc.post() must unlock Processing='N' when loadDocumentDetails() throws");
			assertEquals(0, getFacts(MProduction.Table_ID, rev.get_ID(), as.get_ID()).size());

			postImmediate(rev);
			assertEquals(getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID()).size(),
					getFacts(MProduction.Table_ID, rev.get_ID(), as.get_ID()).size());
		}
	}

	@Test
	public void testProductionPlanReversalWithTiedPlanLineNumbers()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct compA = createStockedProduct("TiedPlanCompA", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct compB = createStockedProduct("TiedPlanCompB", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, compA);
			mockProductGet(mockedProduct, compB);
			MProduct fg = createBomProduct("TiedPlanFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			createPOAndMR(compA, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createPOAndMR(compB, null, new BigDecimal("5"), new BigDecimal("200.00"));
			MCostElement burdenCe = createManualCostElement("TiedPlan Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(compA, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(compB, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createSimpleBOM(fg, compA, BigDecimal.ONE);

			// Two plans with the SAME Line=10, FG product, locator, and qty, but different component costs (100 vs 200)
			MProduction prod = createPlanProduction("TiedPlanLineNo Production");
			MProductionPlan plan1 = createProductionPlan(prod, 10, fg, BigDecimal.ONE);
			addProductionLine(null, plan1, 10, fg, 0, true, BigDecimal.ONE);
			addProductionLine(null, plan1, 20, compA, 0, false, BigDecimal.ONE.negate());

			MProductionPlan plan2 = createProductionPlan(prod, 10, fg, BigDecimal.ONE);
			addProductionLine(null, plan2, 10, fg, 0, true, BigDecimal.ONE);
			addProductionLine(null, plan2, 20, compB, 0, false, BigDecimal.ONE.negate());

			// Perturb heap order in PostgreSQL
			plan1.setDescription("Plan 1 updated");
			plan1.saveEx();

			completeAndPost(prod);
			MProduction rev = reverseAndPost(prod);

			List<MProductionPlan> revPlans = new Query(Env.getCtx(), MProductionPlan.Table_Name,
					"M_Production_ID=?", getTrxName())
					.setParameters(rev.get_ID())
					.setOrderBy("Line, M_ProductionPlan_ID")
					.list();
			assertEquals(2, revPlans.size());
			MCostDetail revFgCd1 = MCostDetail.getProduction(as, fg.get_ID(), 0, revPlans.get(0).getLines()[0].get_ID(), 0, getTrxName());
			MCostDetail revFgCd2 = MCostDetail.getProduction(as, fg.get_ID(), 0, revPlans.get(1).getLines()[0].get_ID(), 0, getTrxName());
			assertNotNull(revFgCd1);
			assertNotNull(revFgCd2);
			assertEquals(new BigDecimal("-110.00"), revFgCd1.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-220.00"), revFgCd2.getAmt().setScale(2, RoundingMode.HALF_UP));
		}
	}

	@Test
	public void testBatchLotAllocatedComponentProductionReversalMatchesOriginalLine()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = createCategoryWithCosting("ProdMaRevBatchCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, null, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("ProdMaRevLotAS", mockedAttrSet);
			MProduct comp = createStockedProduct("ProdMaRevComp", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("ProdMaRevFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			MAttributeSetInstance lot1 = createLot(lotAs.get_ID(), "LOT-MA-REV-1");
			createPOAndMR(comp, lot1, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProdMaRev Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, burdenCe, lot1.get_ID(), BigDecimal.ZERO, 10);

			MPPProductBOM bom = createSimpleBOM(fg, comp, new BigDecimal("2"));
			MProduction prod = createProduction(fg, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);
			completeAndPost(prod);

			MProductionLine origCompLine = findLineByProduct(prod, comp.get_ID());
			assertEquals(0, origCompLine.getM_AttributeSetInstance_ID());
			assertTrue(MProductionLineMA.get(Env.getCtx(), origCompLine.get_ID(), getTrxName()).length > 0);

			MProduction rev = reverseAndPost(prod);
			MProductionLine revCompLine = findLineByProduct(rev, comp.get_ID());
			assertEquals(lot1.get_ID(), revCompLine.getM_AttributeSetInstance_ID());

			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(getFacts(MProduction.Table_ID, rev.get_ID(), as.get_ID()),
					freightAcctId, new BigDecimal("20.00"), BigDecimal.ZERO);
			MCostDetail origCompCd = MCostDetail.getProduction(as, comp.get_ID(), lot1.get_ID(), origCompLine.get_ID(), 0, getTrxName());
			MCostDetail revCompCd = MCostDetail.getProduction(as, comp.get_ID(), lot1.get_ID(), revCompLine.get_ID(), 0, getTrxName());
			assertNotNull(origCompCd);
			assertNotNull(revCompCd);
			assertEquals(origCompCd.get_ID(), revCompCd.getRef_CostDetail_ID());
			assertEquals(new BigDecimal("200.00"), revCompCd.getAmt().setScale(2, RoundingMode.HALF_UP));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testMultiFinishedGoodsLinesPreserveManualChargeTotalWithoutRoundingImbalance()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("MultiFgComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("MultiFgEnd", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			MCostElement overheadCe = createManualCostElement("MultiFg Penny Charge",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, overheadCe, 0, new BigDecimal("0.01"), 0);
			createSimpleBOM(fg, comp, BigDecimal.ONE);

			MProduction prod = createProduction(fg, new BigDecimal("2"), 0, false);
			MProductionLine fgLine1 = addProductionLine(prod, null, 10, fg, 0, true, BigDecimal.ONE);
			MProductionLine fgLine2 = addProductionLine(prod, null, 20, fg, 0, true, BigDecimal.ONE);
			addProductionLine(prod, null, 30, comp, 0, false, BigDecimal.ONE.negate());
			completeAndPost(prod);

			List<MFactAcct> facts = getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID());
			assertFactTotals(facts, as.getSuspenseBalancing_Acct().getAccount_ID(), BigDecimal.ZERO, BigDecimal.ZERO);

			BigDecimal fgDrTotal = BigDecimal.ZERO;
			for (MFactAcct fa : facts)
				if (fa.getM_Product_ID() == fg.get_ID())
					fgDrTotal = fgDrTotal.add(fa.getAmtAcctDr());
			assertEquals(new BigDecimal("100.01"), fgDrTotal.setScale(2, RoundingMode.HALF_UP));

			MCostDetail fgCd1 = MCostDetail.getProduction(as, fg.get_ID(), 0, fgLine1.get_ID(), 0, getTrxName());
			MCostDetail fgCd2 = MCostDetail.getProduction(as, fg.get_ID(), 0, fgLine2.get_ID(), 0, getTrxName());
			assertNotNull(fgCd1);
			assertNotNull(fgCd2);
			assertEquals(new BigDecimal("50.01"), fgCd1.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("50.00"), fgCd2.getAmt().setScale(2, RoundingMode.HALF_UP));
		}
	}

	@Test
	public void testNonManualProductionReversalWaitsForOriginalAndLinksReversalLines()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");
		assertFalse(MCost.hasChargeManualCostElements(getAD_Client_ID(), getTrxName()));

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("NonManualProdComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("NonManualProdFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createPOAndMR(fg, null, new BigDecimal("2"), new BigDecimal("200.00"));

			MPPProductBOM bom = createSimpleBOM(fg, comp, new BigDecimal("2"));
			MProduction production = createProduction(fg, BigDecimal.ONE, bom.getPP_Product_BOM_ID(), true);

			runDeferred(() -> {
				complete(production);
				reverseCorrect(production);
			});

			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			assertFalse(production.isPosted());
			assertFalse(reversal.isPosted());

			// Verify bidirectional M_ProductionLine.ReversalLine_ID linkage
			MProductionLine[] origLines = production.getLines();
			MProductionLine[] revLines = reversal.getLines();
			assertEquals(origLines.length, revLines.length);
			for (MProductionLine revLine : revLines)
			{
				assertTrue(revLine.getReversalLine_ID() > 0);
				MProductionLine matchedOrig = new MProductionLine(Env.getCtx(), revLine.getReversalLine_ID(), getTrxName());
				assertEquals(revLine.getM_ProductionLine_ID(), matchedOrig.getReversalLine_ID());
			}

			String revFirstError = tryPostImmediate(reversal);
			assertNotNull(revFirstError, "Production reversal must wait for original production posting");
			assertTrue(revFirstError.contains(Msg.getMsg(Env.getCtx(), "Original Production not posted yet")),
					"Unexpected error: " + revFirstError);
			reversal.load(getTrxName());
			assertFalse(reversal.isPosted());

			postImmediate(production);
			postImmediate(reversal);
			assertFalse(MManualCostDetail.hasForRecord(as.get_ID(), MProduction.Table_ID, reversal.get_ID(), getTrxName()));
		}
	}

	@Test
	public void testMultiFgRoundingDoesNotFlipLastReceiptSign()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("SixFgSignComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("SixFgSignFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			// Material cost 0.06 + fixed manual charge 0.03 = 0.09 split across 6 equal FG lines of qty 1
			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("0.06"));
			MCostElement overheadCe = createManualCostElement("SixFg Overhead 0.03",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, overheadCe, 0, new BigDecimal("0.03"), 0);
			createSimpleBOM(fg, comp, BigDecimal.ONE);

			MProduction prod = createProduction(fg, new BigDecimal("6"), 0, false);
			List<MProductionLine> fgLines = new ArrayList<>();
			for (int k = 1; k <= 6; k++)
				fgLines.add(addProductionLine(prod, null, k * 10, fg, 0, true, BigDecimal.ONE));
			addProductionLine(prod, null, 70, comp, 0, false, BigDecimal.ONE.negate());
			completeAndPost(prod);

			List<MFactAcct> facts = getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID());
			BigDecimal totalFgDr = BigDecimal.ZERO;
			for (MProductionLine fgLine : fgLines)
			{
				MCostDetail cd = MCostDetail.getProduction(as, fg.get_ID(), 0, fgLine.get_ID(), 0, getTrxName());
				assertNotNull(cd);
				assertTrue(cd.getAmt().signum() > 0, "FG MCostDetail must stay positive, got " + cd.getAmt());
				BigDecimal lineDr = BigDecimal.ZERO;
				BigDecimal lineCr = BigDecimal.ZERO;
				for (MFactAcct fa : facts)
				{
					if (fa.getLine_ID() == fgLine.get_ID())
					{
						lineDr = lineDr.add(fa.getAmtAcctDr());
						lineCr = lineCr.add(fa.getAmtAcctCr());
					}
				}
				assertTrue(lineDr.signum() > 0 && lineCr.signum() == 0);
				totalFgDr = totalFgDr.add(lineDr);
			}
			assertEquals(new BigDecimal("0.09"), totalFgDr.setScale(2, RoundingMode.HALF_UP));
		}
	}

	@Test
	public void testFifoMultiComponentAndMultiFgProductionRollupAndPercentCharge()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory fifoCat = createCategoryWithCosting("ProdFifoCat", as,
					null, MCostElement.COSTINGMETHOD_Fifo, mockedCategory);
			MProduct comp = createStockedProduct("ProdFifoComp", fifoCat.get_ID(), 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("ProdFifoFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			// Two distinct FIFO layers: asi1 (lower ID) qty 1 @ 1000.00, asi2 (higher ID) qty 1 @ 1200.00
			MAttributeSetInstance asi1 = createLot(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id, "PROD-FIFO-L1");
			MAttributeSetInstance asi2 = createLot(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id, "PROD-FIFO-L2");
			assertTrue(asi1.get_ID() < asi2.get_ID());

			assertTrue(MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, comp.get_ID(), 0,
					new BigDecimal("2"), getLoginDate(), getTrxName()));

			MCost.CostingKey key = MCost.CostingKey.resolve(getAD_Org_ID(), 0, comp.getCostingLevel(as));
			MCostElement fifoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_Fifo);
			seedMaterialCost(comp, as, key, fifoCe, new BigDecimal("1000.00"), new BigDecimal("2"));
			seedMaterialCost(comp, as, key, MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AveragePO),
					new BigDecimal("1100.00"), new BigDecimal("2"));
			MCostElement avgInvCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AverageInvoice);
			if (avgInvCe != null)
				seedMaterialCost(comp, as, key, avgInvCe, new BigDecimal("1100.00"), new BigDecimal("2"));

			MCostQueue q1 = MCostQueue.get(comp, asi1.get_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			q1.setCurrentQty(BigDecimal.ONE);
			q1.setCurrentCostPrice(new BigDecimal("1000.00"));
			q1.saveEx();
			MCostQueue q2 = MCostQueue.get(comp, asi2.get_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			q2.setCurrentQty(BigDecimal.ONE);
			q2.setCurrentCostPrice(new BigDecimal("1200.00"));
			q2.saveEx();

			for (MAcctSchema clientAs : MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID(), getTrxName()))
			{
				if (clientAs.get_ID() == as.get_ID())
					continue;
				MCost.CostingKey secKey = MCost.CostingKey.resolve(getAD_Org_ID(), 0, comp.getCostingLevel(clientAs));
				MCostElement secCe = MCostElement.getMaterialCostElement(clientAs, clientAs.getCostingMethod());
				if (secCe != null)
					seedMaterialCost(comp, clientAs, secKey, secCe, new BigDecimal("1000.00"), new BigDecimal("2"));
			}

			MCostElement burdenCe = createManualCostElement("ProdFifo Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createSimpleBOM(fg, comp, BigDecimal.ONE);

			// Two 1-unit FIFO component issues between two FG output lines (1 and 99,999 units)
			MProduction prod = createProduction(fg, new BigDecimal("100000"), 0, false);
			MProductionLine fgLine1 = addProductionLine(prod, null, 10, fg, 0, true, BigDecimal.ONE);
			MProductionLine compLine1 = addProductionLine(prod, null, 20, comp, 0, false, BigDecimal.ONE.negate());
			MProductionLine compLine2 = addProductionLine(prod, null, 30, comp, 0, false, BigDecimal.ONE.negate());
			MProductionLine fgLine2 = addProductionLine(prod, null, 40, fg, 0, true, new BigDecimal("99999"));
			completeAndPost(prod);

			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			List<MFactAcct> facts = getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID());

			BigDecimal comp1InvCr = BigDecimal.ZERO;
			BigDecimal comp1ChargeCr = BigDecimal.ZERO;
			BigDecimal comp2InvCr = BigDecimal.ZERO;
			BigDecimal comp2ChargeCr = BigDecimal.ZERO;
			BigDecimal fg1Dr = BigDecimal.ZERO;
			BigDecimal fg2Dr = BigDecimal.ZERO;
			BigDecimal totalDr = BigDecimal.ZERO;
			BigDecimal totalCr = BigDecimal.ZERO;
			for (MFactAcct fa : facts)
			{
				totalDr = totalDr.add(fa.getAmtAcctDr());
				totalCr = totalCr.add(fa.getAmtAcctCr());
				if (fa.getLine_ID() == compLine1.get_ID())
				{
					if (fa.getC_Charge_ID() == DictionaryIDs.C_Charge.FREIGHT.id)
						comp1ChargeCr = comp1ChargeCr.add(fa.getAmtAcctCr());
					else
						comp1InvCr = comp1InvCr.add(fa.getAmtAcctCr());
				}
				else if (fa.getLine_ID() == compLine2.get_ID())
				{
					if (fa.getC_Charge_ID() == DictionaryIDs.C_Charge.FREIGHT.id)
						comp2ChargeCr = comp2ChargeCr.add(fa.getAmtAcctCr());
					else
						comp2InvCr = comp2InvCr.add(fa.getAmtAcctCr());
				}
				else if (fa.getLine_ID() == fgLine1.get_ID())
					fg1Dr = fg1Dr.add(fa.getAmtAcctDr());
				else if (fa.getLine_ID() == fgLine2.get_ID())
					fg2Dr = fg2Dr.add(fa.getAmtAcctDr());
			}

			assertEquals(new BigDecimal("1000.00"), comp1InvCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("100.00"), comp1ChargeCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("1200.00"), comp2InvCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("120.00"), comp2ChargeCr.setScale(2, RoundingMode.HALF_UP));
			assertFactTotals(facts, freightAcctId, BigDecimal.ZERO, new BigDecimal("220.00"));
			assertEquals(new BigDecimal("2420.00"), fg1Dr.add(fg2Dr).setScale(2, RoundingMode.HALF_UP));
			assertEquals(totalDr.setScale(2, RoundingMode.HALF_UP), totalCr.setScale(2, RoundingMode.HALF_UP));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotMultiFgUsesLineQty()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = createCategoryWithCosting("ProdBatchQtyCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, null, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("ProdBatchQtyLotAS", mockedAttrSet);
			MProduct comp = createStockedProduct("ProdBatchQtyComp", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("ProdBatchQtyFG", batchCat.get_ID(), lotAs.get_ID(), mockedProduct);

			MAttributeSetInstance compLotA = createLot(lotAs.get_ID(), "COMP-LOT-A");
			MAttributeSetInstance fgLot1 = createLot(lotAs.get_ID(), "FG-LOT-1");
			MAttributeSetInstance fgLot2 = createLot(lotAs.get_ID(), "FG-LOT-2");

			createPOAndMR(comp, compLotA, new BigDecimal("5"), new BigDecimal("50.00"));
			createSimpleBOM(fg, comp, BigDecimal.ONE);

			// Multi-FG Batch/Lot production: 2 FG lines of qty 1 each consuming 2 units of compLotA (@ 50 = 100)
			MProduction prod = createProduction(fg, new BigDecimal("2"), 0, false);
			MProductionLine fgLine1 = addProductionLine(prod, null, 10, fg, fgLot1.get_ID(), true, BigDecimal.ONE);
			MProductionLine fgLine2 = addProductionLine(prod, null, 20, fg, fgLot2.get_ID(), true, BigDecimal.ONE);
			addProductionLine(prod, null, 30, comp, compLotA.get_ID(), false, new BigDecimal("-2"));
			completeAndPost(prod);

			MCostDetail fgCd1 = MCostDetail.getProduction(as, fg.get_ID(), fgLot1.get_ID(), fgLine1.get_ID(), 0, getTrxName());
			MCostDetail fgCd2 = MCostDetail.getProduction(as, fg.get_ID(), fgLot2.get_ID(), fgLine2.get_ID(), 0, getTrxName());
			assertNotNull(fgCd1);
			assertNotNull(fgCd2);
			assertEquals(0, BigDecimal.ONE.compareTo(fgCd1.getQty()));
			assertEquals(0, BigDecimal.ONE.compareTo(fgCd2.getQty()));
			assertEquals(new BigDecimal("50.00"), fgCd1.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("50.00"), fgCd2.getAmt().setScale(2, RoundingMode.HALF_UP));

			for (MFactAcct fa : getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID()))
			{
				if (fa.getLine_ID() == fgLine1.get_ID() || fa.getLine_ID() == fgLine2.get_ID())
					assertEquals(0, BigDecimal.ONE.compareTo(fa.getQty()),
							"BatchLot FG Fact_Acct must use line qty (1), not group qtyProduced (2)");
			}
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testMultiPlanSubAssemblyProductionRollup()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct rawMat = createStockedProduct("MultiPlanRawMat", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, rawMat);
			MProduct subAsm = createBomProduct("MultiPlanSubAsm", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);
			MProduct fg = createBomProduct("MultiPlanFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			createPOAndMR(rawMat, null, BigDecimal.ONE, new BigDecimal("100.00"));
			MCostElement freightCe = createManualCostElement("MultiPlan Freight 10",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(rawMat, as, freightCe, 0, new BigDecimal("10.00"), 0);
			createSimpleBOM(subAsm, rawMat, BigDecimal.ONE);
			createSimpleBOM(fg, subAsm, BigDecimal.ONE);

			MProduction prod = createPlanProduction("MultiPlan SubAssembly Production");

			// Insert Plan 20 BEFORE Plan 10 so Plan 20 has lower M_ProductionPlan_ID (tests ordering by plan.Line)
			MProductionPlan plan2 = createProductionPlan(prod, 20, fg, BigDecimal.ONE);
			MProductionLine plan2Fg = addProductionLine(null, plan2, 10, fg, 0, true, BigDecimal.ONE);
			MProductionLine plan2Comp = addProductionLine(null, plan2, 20, subAsm, 0, false, BigDecimal.ONE.negate());

			// Plan 10 produces subAsm (no prior cost) from rawMat (FG line listed before component line)
			MProductionPlan plan1 = createProductionPlan(prod, 10, subAsm, BigDecimal.ONE);
			MProductionLine plan1Fg = addProductionLine(null, plan1, 10, subAsm, 0, true, BigDecimal.ONE);
			addProductionLine(null, plan1, 20, rawMat, 0, false, BigDecimal.ONE.negate());

			completeAndPost(prod);

			MCostDetail subInCd = MCostDetail.getProduction(as, subAsm.get_ID(), 0, plan1Fg.get_ID(), 0, getTrxName());
			MCostDetail subOutCd = MCostDetail.getProduction(as, subAsm.get_ID(), 0, plan2Comp.get_ID(), 0, getTrxName());
			MCostDetail fgInCd = MCostDetail.getProduction(as, fg.get_ID(), 0, plan2Fg.get_ID(), 0, getTrxName());
			assertNotNull(subInCd);
			assertNotNull(subOutCd);
			assertNotNull(fgInCd);
			assertEquals(new BigDecimal("110.00"), subInCd.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-110.00"), subOutCd.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("110.00"), fgInCd.getAmt().setScale(2, RoundingMode.HALF_UP));

			BigDecimal totalDr = BigDecimal.ZERO;
			BigDecimal totalCr = BigDecimal.ZERO;
			BigDecimal fgDr = BigDecimal.ZERO;
			for (MFactAcct fa : getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID()))
			{
				totalDr = totalDr.add(fa.getAmtAcctDr());
				totalCr = totalCr.add(fa.getAmtAcctCr());
				if (fa.getLine_ID() == plan2Fg.get_ID())
					fgDr = fgDr.add(fa.getAmtAcctDr());
			}
			assertEquals(new BigDecimal("110.00"), fgDr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(totalDr.setScale(2, RoundingMode.HALF_UP), totalCr.setScale(2, RoundingMode.HALF_UP));
		}
	}

	@Test
	public void testNetZeroFinishedGoodsGroupRejectedWithoutPartialCostDetails()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("NetZeroFgComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("NetZeroFgEnd", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createPOAndMR(fg, null, new BigDecimal("5"), new BigDecimal("50.00"));
			MCostElement freightCe = createManualCostElement("NetZeroFg Freight 10",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, freightCe, 0, new BigDecimal("10.00"), 0);
			createSimpleBOM(fg, comp, BigDecimal.ONE);

			MProduction prod = createProduction(fg, BigDecimal.ONE, 0, false);
			MProductionLine fgPos = addProductionLine(prod, null, 10, fg, 0, true, BigDecimal.ONE);
			MProductionLine fgNeg = addProductionLine(prod, null, 20, fg, 0, false, BigDecimal.ONE.negate());
			MProductionLine compLine = addProductionLine(prod, null, 30, comp, 0, false, BigDecimal.ONE.negate());
			runDeferred(() -> complete(prod));

			String err = tryPostImmediate(prod);
			assertNotNull(err, "Production with net-zero finished goods output group must fail posting");
			assertTrue(err.contains("Zero net quantity produced"), "Unexpected error: " + err);
			prod.load(getTrxName());
			assertFalse(prod.isPosted());
			assertEquals(0, getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID()).size());
			assertFalse(MManualCostDetail.hasForRecord(as.get_ID(), MProduction.Table_ID, prod.get_ID(), getTrxName()));
			assertEquals(null, MCostDetail.getProduction(as, comp.get_ID(), 0, compLine.get_ID(), 0, getTrxName()));
			assertEquals(null, MCostDetail.getProduction(as, fg.get_ID(), 0, fgPos.get_ID(), 0, getTrxName()));
			assertEquals(null, MCostDetail.getProduction(as, fg.get_ID(), 0, fgNeg.get_ID(), 0, getTrxName()));
		}
	}

	@Test
	public void testPreMigrationProductionReversalWithNullReversalLineIdMatchesOriginalManualDetails()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("LegacyProdRevComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, comp);
			MProduct fg = createBomProduct("LegacyProdRevFg", DictionaryIDs.M_Product_Category.STANDARD.id, 0, mockedProduct);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			MCostElement freightCe = createManualCostElement("LegacyProdRev Freight 10",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, freightCe, 0, new BigDecimal("10.00"), 0);
			createSimpleBOM(fg, comp, BigDecimal.ONE);

			MProduction prod = createProduction(fg, BigDecimal.ONE, 0, true);
			runDeferred(() -> {
				complete(prod);
				reverseCorrect(prod);
			});
			prod.load(getTrxName());
			MProduction reversal = new MProduction(Env.getCtx(), prod.getReversal_ID(), getTrxName());
			assertTrue(reversal.get_ID() > 0);

			// Simulate pre-migration rows where M_ProductionLine.ReversalLine_ID is NULL
			DB.executeUpdateEx("UPDATE M_ProductionLine SET ReversalLine_ID=NULL WHERE M_Production_ID IN (?,?)",
					new Object[] { prod.get_ID(), reversal.get_ID() }, getTrxName());

			postImmediate(prod);
			postImmediate(reversal);

			List<MManualCostDetail> origDetails = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MProduction.Table_ID, prod.get_ID(), getTrxName());
			List<MManualCostDetail> revDetails = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MProduction.Table_ID, reversal.get_ID(), getTrxName());
			assertEquals(1, origDetails.size());
			assertEquals(1, revDetails.size());
			assertEquals(new BigDecimal("10.00"), origDetails.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-10.00"), revDetails.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));

			int fgAssetId = new ProductCost(Env.getCtx(), fg.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int compAssetId = new ProductCost(Env.getCtx(), comp.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			MProductionLine revFgLine = findLineByProduct(reversal, fg.get_ID());
			MProductionLine revCompLine = findLineByProduct(reversal, comp.get_ID());
			assertNotNull(revFgLine);
			assertNotNull(revCompLine);
			List<MFactAcct> revFacts = getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(new BigDecimal("110.00"), sumLineAccount(revFacts, revFgLine.get_ID(), fgAssetId, false).setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("100.00"), sumLineAccount(revFacts, revCompLine.get_ID(), compAssetId, true).setScale(2, RoundingMode.HALF_UP));
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("10.00"), BigDecimal.ZERO);
		}
	}

	private MProductionLine findLineByProduct(MProduction prod, int productId)
	{
		for (MProductionLine pl : prod.getLines())
		{
			if (pl.getM_Product_ID() == productId)
				return pl;
		}
		return null;
	}

	private BigDecimal sumLineAccount(List<MFactAcct> facts, int lineId, int accountId, boolean debit)
	{
		BigDecimal sum = BigDecimal.ZERO;
		for (MFactAcct fa : facts)
		{
			if (fa.getLine_ID() == lineId && fa.getAccount_ID() == accountId && fa.getC_Charge_ID() == 0)
				sum = sum.add(debit ? fa.getAmtAcctDr() : fa.getAmtAcctCr());
		}
		return sum;
	}

	private void seedMaterialCost(MProduct product, MAcctSchema as, MCost.CostingKey key,
			MCostElement ce, BigDecimal price, BigDecimal qty)
	{
		MCost cost = MCost.get(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), ce.get_ID(), getTrxName());
		cost.setCurrentCostPrice(price);
		cost.setCurrentQty(qty);
		cost.saveEx();
	}
}
