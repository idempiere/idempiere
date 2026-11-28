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
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MUOM;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.X_C_Charge_Acct;
import org.compiere.model.X_C_SubAcct;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.idempiere.acct.base.model.MDistribution;
import org.idempiere.acct.base.model.MDistributionLine;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Sales Shipment and Customer Return tests for IDEMPIERE-7231.
 */
public class ManualCostElementInOutTest extends AbstractManualCostElementTest
{
	@Test
	public void testShipmentAndReversalWithManualCosts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostShipProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("10"), new BigDecimal("100.00"));

			// Two distinct manual cost elements intentionally sharing the SAME Charge/GL Account
			MCostElement burdenCe = createManualCostElement("Ship Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("Ship Overhead Fixed 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement zeroCe = createManualCostElement("Ship Zero Resource",
					MCostElement.COSTELEMENTTYPE_Resource, DictionaryIDs.C_Charge.COMMISSIONS.id);
			MCostElement inactiveCe = createManualCostElement("Ship Inactive Burden",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.COMMISSIONS.id);

			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);
			createManualCostRecord(product, as, zeroCe, 0, BigDecimal.ZERO, 0);
			MCost inactiveCost = createManualCostRecord(product, as, inactiveCe, 0, new BigDecimal("99.00"), 0);
			inactiveCost.setIsActive(false);
			inactiveCost.saveEx();

			// Ship qty 2: material = 200, burden = 20, overhead = 10 -> COGS = 230
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			MInOutLine shipLine = shipment.getLines()[0];

			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(4, facts.size(), "Shipment should have 4 Fact_Acct lines (COGS, Asset, 2 manual cost Charges)");

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(facts, cogsAcctId, new BigDecimal("230.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(facts, freightAcctId, BigDecimal.ZERO, new BigDecimal("30.00"));

			List<BigDecimal> chargeCredits = new ArrayList<>();
			for (MFactAcct fa : facts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Manual cost FactLine must record C_Charge_ID");
					chargeCredits.add(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, chargeCredits.size(), "Expected 2 separate Charge credit lines");
			assertTrue(chargeCredits.contains(new BigDecimal("20.00")));
			assertTrue(chargeCredits.contains(new BigDecimal("10.00")));

			// MCostDetail must remain material-only (-200.00)
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipLine.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			assertEquals(new BigDecimal("-200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Shipment MCostDetail must record negative material cost only");

			// Mutate cost elements BEFORE reversing
			burdenCe.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			burdenCe.saveEx();
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			MInOut reversal = reverseAndPost(shipment);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size(), "Reversal should have 4 Fact_Acct lines matching original shipment");
			assertFactTotals(revFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("230.00"));
			assertFactTotals(revFacts, assetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("30.00"), BigDecimal.ZERO);

			List<BigDecimal> chargeDebits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID());
					chargeDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, chargeDebits.size(), "Expected 2 separate Charge debit lines on reversal");
			assertTrue(chargeDebits.contains(new BigDecimal("20.00")));
			assertTrue(chargeDebits.contains(new BigDecimal("10.00")));
		}
	}

	@Test
	public void testShipmentReversalPreservesChargeAccountDimensions()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MCharge charge = new MCharge(Env.getCtx(), 0, getTrxName());
			charge.setName("ManualCost Dim Charge");
			charge.saveEx();

			MAccount baseAcct = MCharge.getAccount(charge.get_ID(), as, getTrxName());
			assertNotNull(baseAcct, "Default charge account not created");

			X_C_SubAcct subAcct1 = new X_C_SubAcct(Env.getCtx(), 0, getTrxName());
			subAcct1.setC_ElementValue_ID(baseAcct.getAccount_ID());
			subAcct1.setValue("SUB1");
			subAcct1.setName("SubAcct 1");
			subAcct1.saveEx();

			X_C_SubAcct subAcct2 = new X_C_SubAcct(Env.getCtx(), 0, getTrxName());
			subAcct2.setC_ElementValue_ID(baseAcct.getAccount_ID());
			subAcct2.setValue("SUB2");
			subAcct2.setName("SubAcct 2");
			subAcct2.saveEx();

			MAccount vc1 = MAccount.get(Env.getCtx(), getAD_Client_ID(), baseAcct.getAD_Org_ID(), as.get_ID(),
					baseAcct.getAccount_ID(), subAcct1.get_ID(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, getTrxName());
			MAccount vc2 = MAccount.get(Env.getCtx(), getAD_Client_ID(), baseAcct.getAD_Org_ID(), as.get_ID(),
					baseAcct.getAccount_ID(), subAcct2.get_ID(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, getTrxName());
			assertNotNull(vc1);
			assertNotNull(vc2);

			X_C_Charge_Acct chargeAcct = new Query(Env.getCtx(), X_C_Charge_Acct.Table_Name,
					"C_Charge_ID=? AND C_AcctSchema_ID=?", getTrxName())
					.setParameters(charge.get_ID(), as.get_ID())
					.first();
			assertNotNull(chargeAcct);
			chargeAcct.setCh_Expense_Acct(vc1.get_ID());
			chargeAcct.saveEx();

			MProduct product = createStockedProduct("ManualCostDimProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement overheadCe = createManualCostElement("Dim Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, charge.get_ID());
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("150.00"));
			MFactAcct origChargeFact = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()).stream()
					.filter(fa -> fa.getC_Charge_ID() == charge.get_ID())
					.findFirst()
					.orElse(null);
			assertNotNull(origChargeFact);
			assertEquals(baseAcct.getAccount_ID(), origChargeFact.getAccount_ID());
			assertEquals(subAcct1.get_ID(), origChargeFact.getC_SubAcct_ID());

			// Switch charge account to another ValidCombination on the SAME natural Account_ID with SubAcct 2
			chargeAcct.setCh_Expense_Acct(vc2.get_ID());
			chargeAcct.saveEx();

			MInOut reversal = reverseAndPost(shipment);
			MFactAcct revChargeFact = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID()).stream()
					.filter(fa -> fa.getC_Charge_ID() == charge.get_ID())
					.findFirst()
					.orElse(null);
			assertNotNull(revChargeFact);
			assertEquals(baseAcct.getAccount_ID(), revChargeFact.getAccount_ID());
			assertEquals(subAcct1.get_ID(), revChargeFact.getC_SubAcct_ID(),
					"Reversal must preserve original C_SubAcct_ID even when Ch_Expense_Acct changed on same natural account");
			assertEquals(origChargeFact.getC_BPartner_ID(), revChargeFact.getC_BPartner_ID());
		}
	}

	@Test
	public void testShipmentReversalWhenNegativeManualCostFlipsCogsSide()
	{
		MAcctSchema baseAs = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, baseAs.getCostingMethod(), "Default costing method not Average PO");

		MAcctSchema as = new MAcctSchema(Env.getCtx(), baseAs, getTrxName());
		as.setIsAllowNegativePosting(false);

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAcctSchema> mockedAcctSchema = mockStatic(MAcctSchema.class, Mockito.CALLS_REAL_METHODS))
		{
			mockedAcctSchema.when(() -> MAcctSchema.get(eq(as.getC_AcctSchema_ID()))).thenReturn(as);
			mockedAcctSchema.when(() -> MAcctSchema.get(any(Properties.class), eq(as.getC_AcctSchema_ID()))).thenReturn(as);
			mockedAcctSchema.when(() -> MAcctSchema.get(any(Properties.class), eq(as.getC_AcctSchema_ID()), any())).thenReturn(as);
			mockedAcctSchema.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(getAD_Client_ID())))
					.thenReturn(new MAcctSchema[] { as });
			mockedAcctSchema.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(getAD_Client_ID()), any()))
					.thenReturn(new MAcctSchema[] { as });

			MProduct product = createStockedProduct("ManualCostNegFlipProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			// Negative manual cost (-150) flips CoGS (100 - 150 = -50) onto the same CR side as Inventory (CR 100)
			MCostElement negCe = createManualCostElement("Negative Rebate Overhead",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, negCe, 0, new BigDecimal("-150.00"), 0);

			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("150.00"));
			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(3, facts.size());

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(facts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("50.00"));
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(facts, freightAcctId, new BigDecimal("150.00"), BigDecimal.ZERO);

			MInOut reversal = reverseAndPost(shipment);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(3, revFacts.size());
			assertFactTotals(revFacts, cogsAcctId, new BigDecimal("50.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, assetAcctId, new BigDecimal("100.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("150.00"));
		}
	}

	@Test
	public void testShipmentRoundingPrecisionBalance()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostRoundProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			// Material = 10.0040 (-> 10.00), Manual1 = 1.0040 (-> 1.00), Manual2 = 2.0040 (-> 2.00) -> COGS = 13.00 (not 13.01)
			createPOAndMR(product, null, new BigDecimal("3"), new BigDecimal("10.004"));

			MCostElement ce1 = createManualCostElement("Round Burden 1",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement ce2 = createManualCostElement("Round Burden 2",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(product, as, ce1, 0, new BigDecimal("1.004"), 0);
			createManualCostRecord(product, as, ce2, 0, new BigDecimal("2.004"), 0);

			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("20.00"));
			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(4, facts.size());

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			int commAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(facts, cogsAcctId, new BigDecimal("13.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("10.00"));
			assertFactTotals(facts, freightAcctId, BigDecimal.ZERO, new BigDecimal("1.00"));
			assertFactTotals(facts, commAcctId, BigDecimal.ZERO, new BigDecimal("2.00"));
		}
	}

	@Test
	public void testShipmentBatchLotMAAndASIDeduplication()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MAttributeSet attrSet = createLotAttributeSet("ManualCostLotAttrSet", mockedAttrSet);
			MProductCategory lotCategory = createCategoryWithCosting("ManualCostLotCategory", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MProduct product = createStockedProduct("ManualCostLotProd", lotCategory.get_ID(), attrSet.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = createLot(attrSet.get_ID(), "Lot-A");
			MAttributeSetInstance lotB = createLot(attrSet.get_ID(), "Lot-B");

			// Receive 2 of Lot-A @ 50 earlier and 2 of Lot-B @ 80 later so FIFO consumes Lot-A first
			createPOAndMR(product, lotA, new BigDecimal("2"), new BigDecimal("50.00"), TimeUtil.addDays(getLoginDate(), -2));
			createPOAndMR(product, lotB, new BigDecimal("2"), new BigDecimal("80.00"), TimeUtil.addDays(getLoginDate(), -1));

			// Manual burden: 10% fallback at ASI=0, overridden to 20% for Lot-A (must NOT double-count 20%+10%)
			MCostElement burdenCe = createManualCostElement("Lot Burden",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, burdenCe, lotA.get_ID(), BigDecimal.ZERO, 20);

			// Ship 3 units without ASI (auto-allocates 2 from Lot-A + 1 from Lot-B): material = 180, manual = 20 + 8 = 28
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("3"), new BigDecimal("120.00"));
			MInOutLineMA[] shipMas = MInOutLineMA.get(Env.getCtx(), shipment.getLines()[0].get_ID(), getTrxName());
			assertEquals(2, shipMas.length);
			BigDecimal lotAQty = BigDecimal.ZERO;
			BigDecimal lotBQty = BigDecimal.ZERO;
			for (MInOutLineMA ma : shipMas)
			{
				if (ma.getM_AttributeSetInstance_ID() == lotA.get_ID())
					lotAQty = lotAQty.add(ma.getMovementQty());
				else if (ma.getM_AttributeSetInstance_ID() == lotB.get_ID())
					lotBQty = lotBQty.add(ma.getMovementQty());
			}
			assertEquals(new BigDecimal("2.00"), lotAQty.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("1.00"), lotBQty.setScale(2, RoundingMode.HALF_UP));

			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(3, facts.size());

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(facts, cogsAcctId, new BigDecimal("208.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("180.00"));
			assertFactTotals(facts, freightAcctId, BigDecimal.ZERO, new BigDecimal("28.00"));

			MInOut customerReturn = createCustomerReturn(shipment, shipment.getLines()[0], new BigDecimal("3"));
			List<MFactAcct> retFacts = getFacts(MInOut.Table_ID, customerReturn.get_ID(), as.get_ID());
			assertEquals(3, retFacts.size());
			assertFactTotals(retFacts, assetAcctId, new BigDecimal("180.00"), BigDecimal.ZERO);
			assertFactTotals(retFacts, freightAcctId, new BigDecimal("28.00"), BigDecimal.ZERO);
			assertFactTotals(retFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("208.00"));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testCustomerReturnAndReversalWithManualCosts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostReturnProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("10"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("Return Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("Return Overhead Fixed 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			MInOut customerReturn = createCustomerReturn(shipment, shipment.getLines()[0], new BigDecimal("2"));
			MInOutLine returnLine = customerReturn.getLines()[0];

			List<MFactAcct> facts = getFacts(MInOut.Table_ID, customerReturn.get_ID(), as.get_ID());
			assertEquals(4, facts.size());

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(facts, assetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(facts, freightAcctId, new BigDecimal("30.00"), BigDecimal.ZERO);
			assertFactTotals(facts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("230.00"));

			List<BigDecimal> chargeDebits = new ArrayList<>();
			for (MFactAcct fa : facts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID());
					chargeDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, chargeDebits.size());
			assertTrue(chargeDebits.contains(new BigDecimal("20.00")));
			assertTrue(chargeDebits.contains(new BigDecimal("10.00")));

			MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", returnLine.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd);
			assertEquals(new BigDecimal("200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));

			// Mutate cost elements BEFORE reversing Customer Return
			burdenCe.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			burdenCe.saveEx();
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			MInOut reversal = reverseAndPost(customerReturn);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size());
			assertFactTotals(revFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(revFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("30.00"));
			assertFactTotals(revFacts, cogsAcctId, new BigDecimal("230.00"), BigDecimal.ZERO);

			List<BigDecimal> chargeCredits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID());
					chargeCredits.add(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, chargeCredits.size());
			assertTrue(chargeCredits.contains(new BigDecimal("20.00")));
			assertTrue(chargeCredits.contains(new BigDecimal("10.00")));
		}
	}

	@Test
	public void testShipmentAndReturnReversalWhenProductAssetChangedToChargeAccount()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostAssetSwapProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("2"), new BigDecimal("100.00"));

			MCostElement overheadCe = createManualCostElement("AssetSwap Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int origCogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int origAssetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			MAccount freightAcct = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(freightAcct);
			int freightAcctId = freightAcct.getAccount_ID();
			assertTrue(origAssetAcctId != freightAcctId);

			// 1. Post Shipment 1 and Shipment 2 + Customer Return BEFORE changing P_Asset_Acct
			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("180.00"));
			MCostDetail origShipCd = MCostDetail.getShipment(as, product.get_ID(), 0, shipment.getLines()[0].get_ID(), 0, getTrxName());
			assertNotNull(origShipCd);
			assertEquals(new BigDecimal("-100.00"), origShipCd.getAmt().setScale(2, RoundingMode.HALF_UP));

			MInOut shipment2 = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("180.00"));
			MInOut customerReturn = createCustomerReturn(shipment2, shipment2.getLines()[0], BigDecimal.ONE);
			MCostDetail origReturnCd = MCostDetail.getShipment(as, product.get_ID(), 0, customerReturn.getLines()[0].get_ID(), 0, getTrxName());
			assertNotNull(origReturnCd);
			assertEquals(new BigDecimal("100.00"), origReturnCd.getAmt().setScale(2, RoundingMode.HALF_UP));

			// Change Product Asset (P_Asset_Acct) to Freight Charge account
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] { freightAcct.get_ID(), product.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MInOut shipRev = reverseAndPost(shipment);
			List<MFactAcct> shipRevFacts = getFacts(MInOut.Table_ID, shipRev.get_ID(), as.get_ID());
			assertEquals(3, shipRevFacts.size());
			assertFactTotals(shipRevFacts, origCogsAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			assertFactTotals(shipRevFacts, freightAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);
			BigDecimal chargeDr = BigDecimal.ZERO;
			BigDecimal assetDr = BigDecimal.ZERO;
			for (MFactAcct fa : shipRevFacts)
			{
				if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == DictionaryIDs.C_Charge.FREIGHT.id)
					chargeDr = chargeDr.add(fa.getAmtAcctDr());
				else if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == 0)
					assetDr = assetDr.add(fa.getAmtAcctDr());
			}
			assertEquals(new BigDecimal("100.00"), assetDr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("5.00"), chargeDr.setScale(2, RoundingMode.HALF_UP));

			MCostDetail revShipCd = MCostDetail.getShipment(as, product.get_ID(), 0, shipRev.getLines()[0].get_ID(), 0, getTrxName());
			assertNotNull(revShipCd);
			assertEquals(origShipCd.getM_CostDetail_ID(), revShipCd.getRef_CostDetail_ID());
			assertEquals(new BigDecimal("100.00"), revShipCd.getAmt().setScale(2, RoundingMode.HALF_UP));

			// 2. Reverse Customer Return while P_Asset_Acct still points to Charge account
			MInOut retRev = reverseAndPost(customerReturn);
			List<MFactAcct> retRevFacts = getFacts(MInOut.Table_ID, retRev.get_ID(), as.get_ID());
			assertEquals(3, retRevFacts.size());
			assertFactTotals(retRevFacts, origCogsAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);
			assertFactTotals(retRevFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			BigDecimal retChargeCr = BigDecimal.ZERO;
			BigDecimal retAssetCr = BigDecimal.ZERO;
			for (MFactAcct fa : retRevFacts)
			{
				if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == DictionaryIDs.C_Charge.FREIGHT.id)
					retChargeCr = retChargeCr.add(fa.getAmtAcctCr());
				else if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == 0)
					retAssetCr = retAssetCr.add(fa.getAmtAcctCr());
			}
			assertEquals(new BigDecimal("100.00"), retAssetCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("5.00"), retChargeCr.setScale(2, RoundingMode.HALF_UP));

			MCostDetail revReturnCd = MCostDetail.getShipment(as, product.get_ID(), 0, retRev.getLines()[0].get_ID(), 0, getTrxName());
			assertNotNull(revReturnCd);
			assertEquals(origReturnCd.getM_CostDetail_ID(), revReturnCd.getRef_CostDetail_ID());
			assertEquals(new BigDecimal("-100.00"), revReturnCd.getAmt().setScale(2, RoundingMode.HALF_UP));
		}
	}

	@Test
	public void testShipmentRejectsMissingValuationEvenWithFixedManualCost()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct noCostProduct = createStockedProduct("MissingValProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, noCostProduct);
			MCostElement overheadCe = createManualCostElement("MissingVal Fixed Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(noCostProduct, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MOrder so = createCompletedSO(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id), 0,
					noCostProduct, null, BigDecimal.ONE, new BigDecimal("50.00"), getLoginDate(), true);
			MInOut missingValShip = createDraftShipment(so, so.getLines()[0], null, BigDecimal.ONE, so.getDateOrdered());
			runDeferred(() -> complete(missingValShip));

			String err = tryPostImmediate(missingValShip);
			assertNotNull(err, "Shipment with missing material valuation must still be rejected");
			assertTrue(err.contains(Msg.getMsg(Env.getCtx(), "No Costs for")) && err.contains(noCostProduct.getName()),
					"Expected missing-valuation 'No Costs for' error, got: " + err);
		}
	}

	@Test
	public void testMultiOrgShipmentReversalReversesOrgBalancingDueToDueFrom()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		MAcctSchemaElement[] origElems = as.getAcctSchemaElements();
		MAcctSchemaElement[] balancedElems = new MAcctSchemaElement[origElems.length];
		boolean foundOrgElem = false;
		for (int i = 0; i < origElems.length; i++)
		{
			if (MAcctSchemaElement.ELEMENTTYPE_Organization.equals(origElems[i].getElementType()))
			{
				MAcctSchemaElement copy = new MAcctSchemaElement(Env.getCtx(), origElems[i].get_ID(), getTrxName());
				copy.setIsBalanced(true);
				balancedElems[i] = copy;
				foundOrgElem = true;
			}
			else
			{
				balancedElems[i] = origElems[i];
			}
		}
		assertTrue(foundOrgElem);

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAcctSchemaElement> mockedElem = mockStatic(MAcctSchemaElement.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			mockedElem.when(() -> MAcctSchemaElement.getAcctSchemaElements(any(MAcctSchema.class)))
					.thenReturn(balancedElems);

			MProduct product = createStockedProduct("MultiOrgBalProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement overheadCe = createManualCostElement("MultiOrg Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			int cogsAcctId = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			MDistribution orgDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			orgDist.setName("Test MultiOrg COGS Split");
			orgDist.setC_AcctSchema_ID(as.get_ID());
			orgDist.setIsCreateReversal(false);
			orgDist.setAnyAcct(false);
			orgDist.setAccount_ID(cogsAcctId);
			orgDist.saveEx();

			MDistributionLine odl = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			odl.setGL_Distribution_ID(orgDist.get_ID());
			odl.setLine(10);
			odl.setPercent(new BigDecimal("100"));
			odl.setOverwriteOrg(true);
			odl.setOrg_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			odl.saveEx();

			orgDist.load(getTrxName());
			orgDist.getLines(true);
			assertTrue(orgDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { orgDist });

			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("150.00"));

			int dueToAcctId = as.getDueTo_Acct(MAcctSchemaElement.ELEMENTTYPE_Organization).getAccount_ID();
			int dueFromAcctId = as.getDueFrom_Acct(MAcctSchemaElement.ELEMENTTYPE_Organization).getAccount_ID();
			List<MFactAcct> origFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertFactTotals(origFacts, dueToAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			assertFactTotals(origFacts, dueFromAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);

			MInOut reversal = reverseAndPost(shipment);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFacts, dueFromAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, dueToAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			BigDecimal hqNet = BigDecimal.ZERO;
			BigDecimal storeNet = BigDecimal.ZERO;
			for (MFactAcct fa : revFacts)
			{
				BigDecimal net = fa.getAmtAcctDr().subtract(fa.getAmtAcctCr());
				if (fa.getAD_Org_ID() == DictionaryIDs.AD_Org.HQ.id)
					hqNet = hqNet.add(net);
				else if (fa.getAD_Org_ID() == DictionaryIDs.AD_Org.STORE_CENTRAL.id)
					storeNet = storeNet.add(net);
				if (fa.getAccount_ID() == dueToAcctId)
				{
					assertEquals(DictionaryIDs.AD_Org.HQ.id, fa.getAD_Org_ID());
					assertEquals(0, fa.getLine_ID());
				}
				else if (fa.getAccount_ID() == dueFromAcctId)
				{
					assertEquals(DictionaryIDs.AD_Org.STORE_CENTRAL.id, fa.getAD_Org_ID());
					assertEquals(0, fa.getLine_ID());
				}
			}
			assertEquals(0, hqNet.signum());
			assertEquals(0, storeNet.signum());
		}
	}

	@Test
	public void testShipmentAllowsUncommittedZeroCostPurchaseDetailInSameTrx()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct freeProd = createStockedProduct("UncommittedZeroCostPOProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, freeProd);
			createPOAndMR(freeProd, null, new BigDecimal("5"), BigDecimal.ZERO);

			MInOut shipment = createSOAndShipment(freeProd, null, BigDecimal.ONE, BigDecimal.ZERO);
			shipment.load(getTrxName());
			assertTrue(shipment.isPosted(), "Shipment of item with uncommitted zero-cost purchase detail must post");
		}
	}

	@Test
	public void testCustomerReturnAllowsVerifiedZeroCostPurchaseWithFixedManualCost()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct freeProd = createStockedProduct("ZeroCostReturnProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, freeProd);
			// Ensure MOrderLine.beforeSave() does not replace 0.00 PO price with the default 100.00 purchase price list
			DB.executeUpdateEx("UPDATE M_ProductPrice SET PriceStd=0, PriceList=0 WHERE M_Product_ID=?",
					new Object[] { freeProd.get_ID() }, getTrxName());
			MInOutLine receiptLine = createPOAndMR(freeProd, null, new BigDecimal("5"), BigDecimal.ZERO);
			for (MMatchPO matchPO : MMatchPO.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), getTrxName()))
			{
				if (!matchPO.isPosted())
					postImmediate(matchPO);
			}
			MCostDetail.processProduct(as, freeProd, getLoginDate(), getTrxName());
			MCostDetail receiptCd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(receiptCd);
			assertTrue(receiptCd.isProcessed(), "Purchase receipt M_CostDetail must be processed");
			assertEquals(0, receiptCd.getAmt().signum(), "Purchase receipt M_CostDetail must be zero");

			MCostElement overheadCe = createManualCostElement("ZeroCostReturn Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(freeProd, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MInOut shipment = createSOAndShipment(freeProd, null, BigDecimal.ONE, BigDecimal.ZERO);
			MInOut customerReturn = createCustomerReturn(shipment, shipment.getLines()[0], BigDecimal.ONE);
			customerReturn.load(getTrxName());
			assertTrue(customerReturn.isPosted(), "Customer return of verified zero-cost purchase with fixed manual cost must post");

			ProductCost pc = new ProductCost(Env.getCtx(), freeProd.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			List<MFactAcct> retFacts = getFacts(MInOut.Table_ID, customerReturn.get_ID(), as.get_ID());
			assertFactTotals(retFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));
			assertFactTotals(retFacts, freightAcctId, new BigDecimal("5.00"), BigDecimal.ZERO);

			// Customer return of stocked product with NO valuation evidence must still be rejected even with fixed manual cost
			MProduct noValProd = createStockedProduct("ReturnMissingValProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, noValProd);
			createManualCostRecord(noValProd, as, overheadCe, 0, new BigDecimal("5.00"), 0);
			MOrder soNoVal = createCompletedSO(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id), 0,
					noValProd, null, BigDecimal.ONE, new BigDecimal("50.00"), getLoginDate(), true);
			MInOut shipNoVal = createDraftShipment(soNoVal, soNoVal.getLines()[0], null, BigDecimal.ONE, soNoVal.getDateOrdered());
			runDeferred(() -> complete(shipNoVal));
			MInOut retNoVal = createDraftCustomerReturn(shipNoVal, shipNoVal.getLines()[0], BigDecimal.ONE);
			runDeferred(() -> completeCustomerReturn(retNoVal));
			String err = tryPostImmediate(retNoVal);
			assertNotNull(err, "Return with missing valuation must still be rejected");
			assertTrue(err.contains(Msg.getMsg(Env.getCtx(), "No Costs for")) && err.contains(noValProd.getName()),
					"Expected 'No Costs for' error, got: " + err);
		}
	}

	@Test
	public void testShipmentReversalDoesNotCreateValidCombinations()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("NoVcBloatShipProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("NoVcBloat Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			assertEquals(3, getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()).size());

			int vcCountBefore = DB.getSQLValueEx(getTrxName(),
					"SELECT COUNT(*) FROM C_ValidCombination WHERE AD_Client_ID=?", getAD_Client_ID());

			MInOut reversal = reverseAndPost(shipment);

			int vcCountAfter = DB.getSQLValueEx(getTrxName(),
					"SELECT COUNT(*) FROM C_ValidCombination WHERE AD_Client_ID=?", getAD_Client_ID());
			assertEquals(vcCountBefore, vcCountAfter,
					"Shipment reversal using M_ManualCostDetail.C_ValidCombination_ID must not insert new C_ValidCombination rows");

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(3, revFacts.size());
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(revFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("220.00"));
			assertFactTotals(revFacts, assetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("20.00"), BigDecimal.ZERO);
		}
	}

	@Test
	public void testBackdatedReceiptRepostsShipmentAndReversalManualCostDetails()
	{
		Timestamp day1 = TimeUtil.addDays(getLoginDate(), -4);
		Timestamp day2 = TimeUtil.addDays(getLoginDate(), -3);
		Timestamp day3 = TimeUtil.addDays(getLoginDate(), -2);
		int requiredBackDateDays = Math.max(30, TimeUtil.getDaysBetween(day1, new Timestamp(System.currentTimeMillis())) + 7);
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MAcctSchema[] spiedAss = new MAcctSchema[ass.length];
		for (int i = 0; i < ass.length; i++)
		{
			MAcctSchema spyAs = Mockito.spy(new MAcctSchema(Env.getCtx(), ass[i]));
			if (spyAs.getBackDateDay() < requiredBackDateDays)
				Mockito.doReturn(requiredBackDateDays).when(spyAs).getBackDateDay();
			spiedAss[i] = spyAs;
		}
		MAcctSchema as = spiedAss[0];
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null);
		MClientInfo spyCi = Mockito.spy(new MClientInfo(Env.getCtx(), ci));
		Mockito.doReturn(as).when(spyCi).getMAcctSchema1();
		Mockito.doReturn(as.getC_Currency_ID()).when(spyCi).getC_Currency_ID();

		int clientId = getAD_Client_ID();
		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClientInfo> clientInfoMock = mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAcctSchema> acctSchemaMock = mockStatic(MAcctSchema.class, Mockito.CALLS_REAL_METHODS))
		{
			clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(clientId), any())).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(clientId))).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.get(eq(clientId))).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.getCopy(any(Properties.class), eq(clientId), any())).thenReturn(spyCi);

			acctSchemaMock.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(clientId), any())).thenReturn(spiedAss);
			acctSchemaMock.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(clientId))).thenReturn(spiedAss);
			for (MAcctSchema spyAs : spiedAss)
			{
				int acctSchemaId = spyAs.getC_AcctSchema_ID();
				acctSchemaMock.when(() -> MAcctSchema.get(any(Properties.class), eq(acctSchemaId), any())).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.get(any(Properties.class), eq(acctSchemaId))).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.get(eq(acctSchemaId))).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.getCopy(any(Properties.class), eq(acctSchemaId), any())).thenReturn(spyAs);
			}

			MProduct product = createStockedProduct("BackDateManualCostProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			MCostElement burdenCe = createManualCostElement("BackDate Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			// Day 1: Receipt qty 10 @ 100.00 -> AvgPO = 100.00
			createPOAndMR(product, null, new BigDecimal("10"), new BigDecimal("100.00"), day1);

			// Day 3: Shipment qty 2 (inv 200, 10% burden 20, COGS 220) + Reverse_Correct on Day 3
			MOrder so = createCompletedSO(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id), 0,
					product, null, new BigDecimal("2"), new BigDecimal("180.00"), day3, false);
			MInOut shipment = createDraftShipment(so, so.getLines()[0], null, new BigDecimal("2"), day3);
			completeAndPost(shipment);
			MInOut reversal = reverseAndPost(shipment);

			List<MManualCostDetail> shipMcdsBefore = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, shipment.get_ID(), getTrxName());
			List<MManualCostDetail> revMcdsBefore = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, reversal.get_ID(), getTrxName());
			assertEquals(1, shipMcdsBefore.size());
			assertEquals(1, revMcdsBefore.size());
			assertEquals(new BigDecimal("20.00"), shipMcdsBefore.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-20.00"), revMcdsBefore.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));

			// Day 2 (Backdated BEFORE Day 3): Receipt qty 10 @ 200.00 -> new AvgPO = 150.00
			createPOAndMR(product, null, new BigDecimal("10"), new BigDecimal("200.00"), day2);

			List<MManualCostDetail> shipMcdsAfter = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, shipment.get_ID(), getTrxName());
			List<MManualCostDetail> revMcdsAfter = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, reversal.get_ID(), getTrxName());
			assertEquals(1, shipMcdsAfter.size());
			assertEquals(1, revMcdsAfter.size());
			assertEquals(new BigDecimal("30.00"), shipMcdsAfter.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-30.00"), revMcdsAfter.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			List<MFactAcct> shipFactsAfter = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertFactTotals(shipFactsAfter, cogsAcctId, new BigDecimal("330.00"), BigDecimal.ZERO);
			assertFactTotals(shipFactsAfter, assetAcctId, BigDecimal.ZERO, new BigDecimal("300.00"));
			assertFactTotals(shipFactsAfter, freightAcctId, BigDecimal.ZERO, new BigDecimal("30.00"));

			List<MFactAcct> revFactsAfter = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFactsAfter, cogsAcctId, BigDecimal.ZERO, new BigDecimal("330.00"));
			assertFactTotals(revFactsAfter, assetAcctId, new BigDecimal("300.00"), BigDecimal.ZERO);
			assertFactTotals(revFactsAfter, freightAcctId, new BigDecimal("30.00"), BigDecimal.ZERO);
		}
	}

	@Test
	public void testBatchLotShipmentMixedSignLotsNegateAllKnownLotAmounts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = createCategoryWithCosting("MixedSignLotCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, null, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("MixedSignLotAS", mockedAttrSet);
			MProduct product = createStockedProduct("MixedSignLotProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotPos = createLot(lotAs.get_ID(), "MIX-POS");
			MAttributeSetInstance lotNeg = createLot(lotAs.get_ID(), "MIX-NEG");

			// Lot 1: +100.00; Lot 2: +50.00 material + (-100.00 unmapped adjustment) = -50.00 -> aggregate = +50.00
			createPOAndMR(product, lotPos, BigDecimal.ONE, new BigDecimal("100.00"));
			createPOAndMR(product, lotNeg, BigDecimal.ONE, new BigDecimal("50.00"));

			MCostElement unmappedAdjCe = createManualCostElement("MixedSign Unmapped Neg Adj",
					MCostElement.COSTELEMENTTYPE_Overhead, 0);
			createManualCostRecord(product, as, unmappedAdjCe, lotNeg.get_ID(), new BigDecimal("-100.00"), 0);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			MInOutLine shipLine = shipment.getLines()[0];

			MCostDetail cdPos = MCostDetail.getShipment(as, product.get_ID(), lotPos.get_ID(), shipLine.get_ID(), 0, getTrxName());
			MCostDetail cdNeg = MCostDetail.getShipment(as, product.get_ID(), lotNeg.get_ID(), shipLine.get_ID(), 0, getTrxName());
			assertNotNull(cdPos);
			assertNotNull(cdNeg);
			assertEquals(new BigDecimal("-100.00"), cdPos.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("50.00"), cdNeg.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-50.00"), cdPos.getAmt().add(cdNeg.getAmt()).setScale(2, RoundingMode.HALF_UP));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testZeroCostCheckScopedByBatchLotAndOrganization()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			// 1. Batch/Lot costing: verified zero purchase for lotZero must NOT satisfy unvalued lotUnvalued
			MProductCategory batchCat = createCategoryWithCosting("ZeroCostBatchCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("ZeroCostBatchAS", mockedAttrSet);
			MProduct lotProd = createStockedProduct("ZeroCostBatchProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, lotProd);
			DB.executeUpdateEx("UPDATE M_ProductPrice SET PriceStd=0, PriceList=0 WHERE M_Product_ID=?",
					new Object[] { lotProd.get_ID() }, getTrxName());

			MAttributeSetInstance lotZero = createLot(lotAs.get_ID(), "LOT-ZERO");
			MAttributeSetInstance lotUnvalued = createLot(lotAs.get_ID(), "LOT-UNVALUED");
			MInOutLine zeroReceiptLine = createPOAndMR(lotProd, lotZero, new BigDecimal("5"), BigDecimal.ZERO);
			for (MMatchPO matchPO : MMatchPO.get(Env.getCtx(), zeroReceiptLine.getM_InOutLine_ID(), getTrxName()))
			{
				if (!matchPO.isPosted())
					postImmediate(matchPO);
			}
			MCostDetail.processProduct(as, lotProd, getLoginDate(), getTrxName());

			MCostElement overheadCe = createManualCostElement("ZeroCostScope Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(lotProd, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MInOut zeroLotShip = createSOAndShipment(lotProd, lotZero, BigDecimal.ONE, BigDecimal.ZERO);
			assertTrue(zeroLotShip.isPosted(), "Shipment of verified zero-cost lot must post");
			MInOut zeroLotReturn = createCustomerReturn(zeroLotShip, zeroLotShip.getLines()[0], BigDecimal.ONE);
			assertTrue(zeroLotReturn.isPosted(), "Return of verified zero-cost lot must post");

			MOrder unvalSo = createCompletedSO(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id), 0,
					lotProd, lotUnvalued, BigDecimal.ONE, new BigDecimal("10.00"), getLoginDate(), true);
			MInOut unvalShip = createDraftShipment(unvalSo, unvalSo.getLines()[0], lotUnvalued, BigDecimal.ONE, unvalSo.getDateOrdered());
			runDeferred(() -> complete(unvalShip));
			String lotErr = tryPostImmediate(unvalShip);
			assertNotNull(lotErr, "Unvalued lot must NOT inherit verified zero-cost evidence from another lot");
			assertTrue(lotErr.contains(Msg.getMsg(Env.getCtx(), "No Costs for")) && lotErr.contains(lotProd.getName()),
					"Expected 'No Costs for' error, got: " + lotErr);

			// 2. Organization costing: verified zero purchase in HQ must NOT satisfy shipment in Store Central
			MProductCategory orgCat = createCategoryWithCosting("ZeroCostOrgCat", as,
					MAcctSchema.COSTINGLEVEL_Organization, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MProduct orgProd = createStockedProduct("ZeroCostOrgProd", orgCat.get_ID(), 0);
			mockProductGet(mockedProduct, orgProd);
			DB.executeUpdateEx("UPDATE M_ProductPrice SET PriceStd=0, PriceList=0 WHERE M_Product_ID=?",
					new Object[] { orgProd.get_ID() }, getTrxName());

			MInOutLine hqReceiptLine = createPOAndMR(orgProd, null, new BigDecimal("5"), BigDecimal.ZERO);
			for (MMatchPO matchPO : MMatchPO.get(Env.getCtx(), hqReceiptLine.getM_InOutLine_ID(), getTrxName()))
			{
				if (!matchPO.isPosted())
					postImmediate(matchPO);
			}
			MCostDetail.processProduct(as, orgProd, getLoginDate(), getTrxName());

			MCost storeCost = MCost.get(orgProd, 0, as, DictionaryIDs.AD_Org.STORE_CENTRAL.id, overheadCe.get_ID(), getTrxName());
			storeCost.setCurrentCostPrice(new BigDecimal("5.00"));
			storeCost.saveEx();

			MOrder storeSo = new MOrder(Env.getCtx(), 0, getTrxName());
			storeSo.setAD_Org_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			storeSo.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			storeSo.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			storeSo.setDeliveryRule(MOrder.DELIVERYRULE_Force);
			storeSo.setIsSOTrx(true);
			storeSo.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.STORE_CENTRAL.id);
			storeSo.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			storeSo.setDateOrdered(getLoginDate());
			storeSo.setDateAcct(getLoginDate());
			storeSo.setDatePromised(getLoginDate());
			storeSo.saveEx();

			var storeSoLine = new org.compiere.model.MOrderLine(storeSo);
			storeSoLine.setLine(10);
			storeSoLine.setProduct(orgProd);
			storeSoLine.setQty(BigDecimal.ONE);
			storeSoLine.setDatePromised(getLoginDate());
			storeSoLine.setPrice(BigDecimal.TEN);
			storeSoLine.saveEx();
			complete(storeSo);

			MInOut storeShip = new MInOut(storeSo, DictionaryIDs.C_DocType.MM_SHIPMENT.id, getLoginDate());
			storeShip.setAD_Org_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			storeShip.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.STORE_CENTRAL.id);
			storeShip.saveEx();
			MInOutLine storeShipLine = new MInOutLine(storeShip);
			storeShipLine.setOrderLine(storeSoLine, DictionaryIDs.M_Locator.STORE.id, BigDecimal.ONE);
			storeShipLine.setM_Locator_ID(DictionaryIDs.M_Locator.STORE.id);
			storeShipLine.setQty(BigDecimal.ONE);
			storeShipLine.saveEx();
			runDeferred(() -> complete(storeShip));

			String orgErr = tryPostImmediate(storeShip);
			assertNotNull(orgErr, "Store Central shipment must NOT inherit verified zero-cost evidence from HQ");
			assertTrue(orgErr.contains(Msg.getMsg(Env.getCtx(), "No Costs for")) && orgErr.contains(orgProd.getName()),
					"Expected 'No Costs for' error, got: " + orgErr);
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotMultiMaSameAsiAssetChangeReversalRecoversFullCost()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = createCategoryWithCosting("MultiMaAssetSwapCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("MultiMaAssetSwapAS", mockedAttrSet);
			MProduct product = createStockedProduct("MultiMaAssetSwapProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = createLot(lotAs.get_ID(), "LOT-SPLIT-MA");
			Timestamp day1 = TimeUtil.addDays(getLoginDate(), -2);
			Timestamp day2 = TimeUtil.addDays(getLoginDate(), -1);
			createPOAndMR(product, lotA, BigDecimal.ONE, new BigDecimal("100.00"), day1);
			createPOAndMR(product, lotA, BigDecimal.ONE, new BigDecimal("100.00"), day2);

			MCostElement burdenCe = createManualCostElement("MultiMa Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("250.00"));
			MInOutLine shipLine = shipment.getLines()[0];
			MInOutLineMA[] shipMas = MInOutLineMA.get(Env.getCtx(), shipLine.get_ID(), getTrxName());
			assertEquals(2, shipMas.length, "Expected 2 MInOutLineMA rows for two DateMaterialPolicy buckets");

			// MCostDetail.createShipment aggregates by (M_InOutLine_ID, M_AttributeSetInstance_ID) across MA buckets
			List<MCostDetail> origCds = new Query(Env.getCtx(), MCostDetail.Table_Name,
					"C_AcctSchema_ID=? AND M_Product_ID=? AND M_InOutLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
					getTrxName())
					.setParameters(as.get_ID(), product.get_ID(), shipLine.get_ID())
					.list();
			assertEquals(1, origCds.size());
			assertEquals(0, new BigDecimal("-2").compareTo(origCds.get(0).getQty()));
			assertEquals(0, new BigDecimal("-200.00").compareTo(origCds.get(0).getAmt()));

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			MAccount freightAcct = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(freightAcct);
			int freightAcctId = freightAcct.getAccount_ID();

			// Change P_Asset_Acct after posting original shipment
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] { freightAcct.get_ID(), product.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MInOut reversal = reverseAndPost(shipment);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("220.00"));
			BigDecimal invDr = BigDecimal.ZERO;
			BigDecimal chgDr = BigDecimal.ZERO;
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == 0)
					invDr = invDr.add(fa.getAmtAcctDr());
				else if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == DictionaryIDs.C_Charge.FREIGHT.id)
					chgDr = chgDr.add(fa.getAmtAcctDr());
			}
			assertEquals(new BigDecimal("200.00"), invDr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("20.00"), chgDr.setScale(2, RoundingMode.HALF_UP));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotMultiMaSameAsiAssetChangeAndClearedChargeDistributionReversal()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			int commissionsAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName()).getAccount_ID();

			MDistribution chargeDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			chargeDist.setName("Test Clear Charge SameAsi GL Dist");
			chargeDist.setC_AcctSchema_ID(as.get_ID());
			chargeDist.setIsCreateReversal(false);
			chargeDist.setAnyAcct(false);
			chargeDist.setAccount_ID(freightAcctId);
			chargeDist.setAnyCharge(false);
			chargeDist.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			chargeDist.saveEx();

			for (int[] lineAndPct : new int[][] { { 10, 60 }, { 20, 40 } })
			{
				MDistributionLine dl = new MDistributionLine(Env.getCtx(), 0, getTrxName());
				dl.setGL_Distribution_ID(chargeDist.get_ID());
				dl.setLine(lineAndPct[0]);
				dl.setPercent(BigDecimal.valueOf(lineAndPct[1]));
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
			CacheMgt.get().reset(MDistribution.Table_Name);

			MProductCategory batchCat = createCategoryWithCosting("MultiMaDistCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("MultiMaDistAS", mockedAttrSet);
			MProduct product = createStockedProduct("MultiMaDistProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = createLot(lotAs.get_ID(), "LOT-SPLIT-DIST");
			Timestamp day1 = TimeUtil.addDays(getLoginDate(), -2);
			Timestamp day2 = TimeUtil.addDays(getLoginDate(), -1);
			createPOAndMR(product, lotA, BigDecimal.ONE, new BigDecimal("100.00"), day1);
			createPOAndMR(product, lotA, new BigDecimal("2"), new BigDecimal("100.00"), day2);

			MCostElement burdenCe = createManualCostElement("MultiMaDist Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("3"), new BigDecimal("250.00"));
			MInOutLine shipLine = shipment.getLines()[0];
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), shipLine.get_ID(), getTrxName()).length);

			List<MCostDetail> origCds = new Query(Env.getCtx(), MCostDetail.Table_Name,
					"C_AcctSchema_ID=? AND M_Product_ID=? AND M_InOutLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
					getTrxName())
					.setParameters(as.get_ID(), product.get_ID(), shipLine.get_ID())
					.list();
			assertEquals(1, origCds.size());
			assertEquals(0, new BigDecimal("-3").compareTo(origCds.get(0).getQty()));
			assertEquals(0, new BigDecimal("-300.00").compareTo(origCds.get(0).getAmt()));

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			MAccount freightAcct = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(freightAcct);

			// Change P_Asset_Acct after posting original shipment
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] { freightAcct.get_ID(), product.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MInOut reversal = reverseAndPost(shipment);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("330.00"));
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("300.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, commissionsAcctId, new BigDecimal("30.00"), BigDecimal.ZERO);
		}
		finally
		{
			CacheMgt.get().reset(MDistribution.Table_Name);
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testCustomerReturnBatchLotMultiMaSameAsiAssetChangeReversal()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = createCategoryWithCosting("RetMultiMaCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("RetMultiMaAS", mockedAttrSet);
			MProduct product = createStockedProduct("RetMultiMaProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = createLot(lotAs.get_ID(), "LOT-RET-SPLIT");
			Timestamp day1 = TimeUtil.addDays(getLoginDate(), -2);
			Timestamp day2 = TimeUtil.addDays(getLoginDate(), -1);
			createPOAndMR(product, lotA, BigDecimal.ONE, new BigDecimal("100.00"), day1);
			createPOAndMR(product, lotA, new BigDecimal("2"), new BigDecimal("100.00"), day2);

			MCostElement burdenCe = createManualCostElement("RetMultiMa Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("3"), new BigDecimal("250.00"));
			MInOut customerReturn = createCustomerReturn(shipment, shipment.getLines()[0], new BigDecimal("3"));
			MInOutLine retLine = customerReturn.getLines()[0];
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), retLine.get_ID(), getTrxName()).length);

			List<MCostDetail> origCds = new Query(Env.getCtx(), MCostDetail.Table_Name,
					"C_AcctSchema_ID=? AND M_Product_ID=? AND M_InOutLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
					getTrxName())
					.setParameters(as.get_ID(), product.get_ID(), retLine.get_ID())
					.list();
			assertEquals(1, origCds.size());
			assertEquals(0, new BigDecimal("3").compareTo(origCds.get(0).getQty()));
			assertEquals(0, new BigDecimal("300.00").compareTo(origCds.get(0).getAmt()));

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			MAccount freightAcct = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(freightAcct);
			int freightAcctId = freightAcct.getAccount_ID();

			// Change P_Asset_Acct after posting original customer return
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] { freightAcct.get_ID(), product.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MInOut reversal = reverseAndPost(customerReturn);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFacts, cogsAcctId, new BigDecimal("330.00"), BigDecimal.ZERO);
			BigDecimal invCr = BigDecimal.ZERO;
			BigDecimal chgCr = BigDecimal.ZERO;
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == 0)
					invCr = invCr.add(fa.getAmtAcctCr());
				else if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == DictionaryIDs.C_Charge.FREIGHT.id)
					chgCr = chgCr.add(fa.getAmtAcctCr());
			}
			assertEquals(new BigDecimal("300.00"), invCr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("30.00"), chgCr.setScale(2, RoundingMode.HALF_UP));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotMultiMaSameAsiNegativeInventoryCostReversal()
	{
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MAcctSchema[] spiedAss = new MAcctSchema[ass.length];
		for (int i = 0; i < ass.length; i++)
		{
			MAcctSchema spyAs = Mockito.spy(new MAcctSchema(Env.getCtx(), ass[i]));
			Mockito.doReturn(false).when(spyAs).isAllowNegativePosting();
			spiedAss[i] = spyAs;
		}
		MAcctSchema as = spiedAss[0];
		assertFalse(as.isAllowNegativePosting());

		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null);
		MClientInfo spyCi = Mockito.spy(new MClientInfo(Env.getCtx(), ci));
		Mockito.doReturn(as).when(spyCi).getMAcctSchema1();
		Mockito.doReturn(as.getC_Currency_ID()).when(spyCi).getC_Currency_ID();

		int clientId = getAD_Client_ID();
		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClientInfo> clientInfoMock = mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAcctSchema> acctSchemaMock = mockStatic(MAcctSchema.class, Mockito.CALLS_REAL_METHODS))
		{
			clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(clientId), any())).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(clientId))).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.get(eq(clientId))).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.getCopy(any(Properties.class), eq(clientId), any())).thenReturn(spyCi);

			acctSchemaMock.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(clientId), any())).thenReturn(spiedAss);
			acctSchemaMock.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(clientId))).thenReturn(spiedAss);
			for (MAcctSchema spyAs : spiedAss)
			{
				int acctSchemaId = spyAs.getC_AcctSchema_ID();
				acctSchemaMock.when(() -> MAcctSchema.get(any(Properties.class), eq(acctSchemaId), any())).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.get(any(Properties.class), eq(acctSchemaId))).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.get(eq(acctSchemaId))).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.getCopy(any(Properties.class), eq(acctSchemaId), any())).thenReturn(spyAs);
			}

			MProductCategory batchCat = createCategoryWithCosting("MultiMaNegCostCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("MultiMaNegCostAS", mockedAttrSet);
			MProduct product = createStockedProduct("MultiMaNegCostProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = createLot(lotAs.get_ID(), "LOT-SPLIT-NEG");
			Timestamp day1 = TimeUtil.addDays(getLoginDate(), -2);
			Timestamp day2 = TimeUtil.addDays(getLoginDate(), -1);
			createPOAndMR(product, lotA, BigDecimal.ONE, new BigDecimal("50.00"), day1);
			createPOAndMR(product, lotA, BigDecimal.ONE, new BigDecimal("50.00"), day2);

			// Unmapped negative cost adjustment -> unit inventory cost = 50.00 - 100.00 = -50.00 (-100.00 for qty 2)
			MCostElement unmappedAdjCe = createManualCostElement("MultiMaNeg Unmapped Adj",
					MCostElement.COSTELEMENTTYPE_Overhead, 0);
			createManualCostRecord(product, as, unmappedAdjCe, lotA.get_ID(), new BigDecimal("-100.00"), 0);

			// Charge-mapped fixed manual cost -> +10.00 per MA bucket (+20.00 total), net COGS = -80.00
			MCostElement overheadCe = createManualCostElement("MultiMaNeg Freight 10",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, lotA.get_ID(), new BigDecimal("10.00"), 0);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("150.00"));
			MInOutLine shipLine = shipment.getLines()[0];
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), shipLine.get_ID(), getTrxName()).length);

			List<MCostDetail> origCds = new Query(Env.getCtx(), MCostDetail.Table_Name,
					"C_AcctSchema_ID=? AND M_Product_ID=? AND M_InOutLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
					getTrxName())
					.setParameters(as.get_ID(), product.get_ID(), shipLine.get_ID())
					.list();
			assertEquals(1, origCds.size());
			assertEquals(0, new BigDecimal("-2").compareTo(origCds.get(0).getQty()));
			assertEquals(0, new BigDecimal("100.00").compareTo(origCds.get(0).getAmt()));

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			List<MFactAcct> shipFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertFactTotals(shipFacts, assetAcctId, new BigDecimal("100.00"), BigDecimal.ZERO);
			assertFactTotals(shipFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("80.00"));
			assertFactTotals(shipFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("20.00"));

			MInOut reversal = reverseAndPost(shipment);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(revFacts, cogsAcctId, new BigDecimal("80.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("20.00"), BigDecimal.ZERO);
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotMultiMaSameAsiFractionalRoundingRepostAndReversal()
	{
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MAcctSchema[] spiedAss = new MAcctSchema[ass.length];
		for (int i = 0; i < ass.length; i++)
		{
			MAcctSchema spyAs = Mockito.spy(new MAcctSchema(Env.getCtx(), ass[i]));
			Mockito.doReturn(2).when(spyAs).getCostingPrecision();
			spiedAss[i] = spyAs;
		}
		MAcctSchema as = spiedAss[0];
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null);
		MClientInfo spyCi = Mockito.spy(new MClientInfo(Env.getCtx(), ci));
		Mockito.doReturn(as).when(spyCi).getMAcctSchema1();
		Mockito.doReturn(as.getC_Currency_ID()).when(spyCi).getC_Currency_ID();

		int clientId = getAD_Client_ID();
		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MUOM> mockedUom = mockStatic(MUOM.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClientInfo> clientInfoMock = mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAcctSchema> acctSchemaMock = mockStatic(MAcctSchema.class, Mockito.CALLS_REAL_METHODS))
		{
			clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(clientId), any())).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(clientId))).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.get(eq(clientId))).thenReturn(spyCi);
			clientInfoMock.when(() -> MClientInfo.getCopy(any(Properties.class), eq(clientId), any())).thenReturn(spyCi);

			acctSchemaMock.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(clientId), any())).thenReturn(spiedAss);
			acctSchemaMock.when(() -> MAcctSchema.getClientAcctSchema(any(Properties.class), eq(clientId))).thenReturn(spiedAss);
			for (MAcctSchema spyAs : spiedAss)
			{
				int acctSchemaId = spyAs.getC_AcctSchema_ID();
				acctSchemaMock.when(() -> MAcctSchema.get(any(Properties.class), eq(acctSchemaId), any())).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.get(any(Properties.class), eq(acctSchemaId))).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.get(eq(acctSchemaId))).thenReturn(spyAs);
				acctSchemaMock.when(() -> MAcctSchema.getCopy(any(Properties.class), eq(acctSchemaId), any())).thenReturn(spyAs);
			}

			MUOM decUom = new MUOM(Env.getCtx(), 0, getTrxName());
			decUom.setName("FracRoundUOM_" + System.nanoTime());
			decUom.setX12DE355("D2");
			decUom.setStdPrecision(2);
			decUom.setCostingPrecision(2);
			decUom.saveEx();
			int decUomId = decUom.get_ID();
			mockedUom.when(() -> MUOM.get(any(Properties.class), eq(decUomId))).thenReturn(decUom);
			mockedUom.when(() -> MUOM.get(eq(decUomId))).thenReturn(decUom);
			mockedUom.when(() -> MUOM.getPrecision(any(Properties.class), eq(decUomId))).thenReturn(2);

			MProductCategory batchCat = createCategoryWithCosting("FracRoundCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("FracRoundAS", mockedAttrSet);
			MProduct product = createStockedProduct("FracRoundProd", batchCat.get_ID(), lotAs.get_ID());
			product.setC_UOM_ID(decUomId);
			product.saveEx();
			mockProductGet(mockedProduct, product);

			// 100.00 @ 1.00 + 0.50 @ 3.02 => 101.51 / 100.50 = 1.01 unit cost
			// 100 * 1.01 = 101.00, 0.5 * 1.01 = 0.51 (rounded at precision 2) => 101.51 posted (scaling 0.51 would yield 102.51)
			MAttributeSetInstance lotA = createLot(lotAs.get_ID(), "LOT-FRAC-ROUND");
			Timestamp day1 = TimeUtil.addDays(getLoginDate(), -2);
			Timestamp day2 = TimeUtil.addDays(getLoginDate(), -1);
			createPOAndMR(product, lotA, new BigDecimal("100.00"), new BigDecimal("1.00"), day1);
			createPOAndMR(product, lotA, new BigDecimal("0.50"), new BigDecimal("3.02"), day2);

			MCostElement burdenCe = createManualCostElement("FracRound Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("100.50"), new BigDecimal("2.50"));
			MInOutLine shipLine = shipment.getLines()[0];
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), shipLine.get_ID(), getTrxName()).length);

			List<MCostDetail> origCds = new Query(Env.getCtx(), MCostDetail.Table_Name,
					"C_AcctSchema_ID=? AND M_Product_ID=? AND M_InOutLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
					getTrxName())
					.setParameters(as.get_ID(), product.get_ID(), shipLine.get_ID())
					.list();
			assertEquals(1, origCds.size());
			assertEquals(0, new BigDecimal("-100.50").compareTo(origCds.get(0).getQty()));
			assertEquals(0, new BigDecimal("-101.51").compareTo(origCds.get(0).getAmt()));

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int origAssetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			MAccount freightAcct = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(freightAcct);
			int freightAcctId = freightAcct.getAccount_ID();

			// Re-post forward shipment -> amounts stay exact (101.51 + 10.15 = 111.66)
			String repostErr = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(),
					MInOut.Table_ID, shipment.get_ID(), true, getTrxName());
			assertEquals(null, repostErr, "Re-post failed: " + repostErr);
			List<MFactAcct> shipFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertFactTotals(shipFacts, origAssetAcctId, BigDecimal.ZERO, new BigDecimal("101.51"));
			assertFactTotals(shipFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("10.15"));
			assertFactTotals(shipFacts, cogsAcctId, new BigDecimal("111.66"), BigDecimal.ZERO);

			// Change P_Asset_Acct and reverse -> must reverse exact 101.51 (NOT 102.51)
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] { freightAcct.get_ID(), product.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MInOut reversal = reverseAndPost(shipment);
			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("111.66"));
			BigDecimal invDr = BigDecimal.ZERO;
			BigDecimal chgDr = BigDecimal.ZERO;
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == 0)
					invDr = invDr.add(fa.getAmtAcctDr());
				else if (fa.getAccount_ID() == freightAcctId && fa.getC_Charge_ID() == DictionaryIDs.C_Charge.FREIGHT.id)
					chgDr = chgDr.add(fa.getAmtAcctDr());
			}
			assertEquals(new BigDecimal("101.51"), invDr.setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("10.15"), chgDr.setScale(2, RoundingMode.HALF_UP));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotIncompleteHistoricalCostDetailShipmentReversalFailsClosed()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = createCategoryWithCosting("IncHistCat", as,
					MAcctSchema.COSTINGLEVEL_BatchLot, MCostElement.COSTINGMETHOD_AveragePO, mockedCategory);
			MAttributeSet lotAs = createLotAttributeSet("IncHistAS", mockedAttrSet);
			MProduct product = createStockedProduct("IncHistProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = createLot(lotAs.get_ID(), "LOT-INC-HIST");
			Timestamp day1 = TimeUtil.addDays(getLoginDate(), -2);
			Timestamp day2 = TimeUtil.addDays(getLoginDate(), -1);
			createPOAndMR(product, lotA, BigDecimal.ONE, new BigDecimal("100.00"), day1);
			createPOAndMR(product, lotA, new BigDecimal("2"), new BigDecimal("100.00"), day2);

			MCostElement burdenCe = createManualCostElement("IncHist Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("3"), new BigDecimal("250.00"));
			MInOutLine shipLine = shipment.getLines()[0];

			MCostDetail origCd = new Query(Env.getCtx(), MCostDetail.Table_Name,
					"C_AcctSchema_ID=? AND M_Product_ID=? AND M_InOutLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
					getTrxName())
					.setParameters(as.get_ID(), product.get_ID(), shipLine.get_ID())
					.firstOnly();
			assertNotNull(origCd);
			// Seed incomplete historical M_CostDetail (qty -2 instead of -3)
			DB.executeUpdateEx("UPDATE M_CostDetail SET Qty=?, Amt=? WHERE M_CostDetail_ID=?",
					new Object[] { new BigDecimal("-2"), new BigDecimal("-200.00"), origCd.getM_CostDetail_ID() }, getTrxName());

			runDeferred(() -> reverseCorrect(shipment));
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			String postErr = tryPostImmediate(reversal);
			assertNotNull(postErr, "Reversal with incomplete historical M_CostDetail must fail closed");
			assertTrue(postErr.contains("Original shipment cost detail is missing or incomplete"), "Unexpected error: " + postErr);
			reversal.load(getTrxName());
			assertFalse(reversal.isPosted());
			assertEquals(0, getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID()).size());
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}
}
