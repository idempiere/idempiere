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
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MCostQueue;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MSalesRegion;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.X_C_Charge_Acct;
import org.compiere.model.X_C_SubAcct;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.acct.base.model.MDistribution;
import org.idempiere.acct.base.model.MDistributionLine;
import org.idempiere.acct.doc.FactLine;
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
			// Zero-amount manual cost element (must be skipped without failing posting)
			MCostElement zeroCe = createManualCostElement("Ship Zero Resource",
					MCostElement.COSTELEMENTTYPE_Resource, DictionaryIDs.C_Charge.COMMISSIONS.id);
			// Inactive M_Cost record (must be ignored)
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

			// Verify individual Charge lines have C_Charge_ID populated and distinct amounts (20 and 10)
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
			assertTrue(chargeCredits.contains(new BigDecimal("20.00")), "Missing 20.00 burden credit line");
			assertTrue(chargeCredits.contains(new BigDecimal("10.00")), "Missing 10.00 overhead credit line");

			// MCostDetail must remain material-only (-200.00)
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipLine.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			assertEquals(new BigDecimal("-200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Shipment MCostDetail must record negative material cost only");

			// Mutate cost elements BEFORE reversing (change Charge on one, deactivate the other)
			burdenCe.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			burdenCe.saveEx();
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			// Reverse-Correct shipment and post reversal
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertTrue(shipment.getReversal_ID() > 0, "Shipment reversal not created");

			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size(), "Reversal should have 4 Fact_Acct lines matching original shipment");
			assertFactTotals(revFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("230.00"));
			assertFactTotals(revFacts, assetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("30.00"), BigDecimal.ZERO);

			// Verify reversal preserved distinct amounts (20 and 10) even when both shared the same GL account
			List<BigDecimal> chargeDebits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Reversed manual cost FactLine must retain C_Charge_ID");
					chargeDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, chargeDebits.size(), "Expected 2 separate Charge debit lines on reversal");
			assertTrue(chargeDebits.contains(new BigDecimal("20.00")), "Missing 20.00 reversed burden debit line");
			assertTrue(chargeDebits.contains(new BigDecimal("10.00")), "Missing 10.00 reversed overhead debit line");
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
			assertNotNull(vc1);
			MAccount vc2 = MAccount.get(Env.getCtx(), getAD_Client_ID(), baseAcct.getAD_Org_ID(), as.get_ID(),
					baseAcct.getAccount_ID(), subAcct2.get_ID(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, getTrxName());
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
			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			MFactAcct origChargeFact = facts.stream()
					.filter(fa -> fa.getC_Charge_ID() == charge.get_ID())
					.findFirst()
					.orElse(null);
			assertNotNull(origChargeFact, "Original shipment charge Fact_Acct line not found");
			assertEquals(baseAcct.getAccount_ID(), origChargeFact.getAccount_ID());
			assertEquals(subAcct1.get_ID(), origChargeFact.getC_SubAcct_ID(),
					"Original shipment charge Fact_Acct should record SubAcct 1");

			// Switch charge account to another ValidCombination on the SAME natural Account_ID with SubAcct 2
			chargeAcct.setCh_Expense_Acct(vc2.get_ID());
			chargeAcct.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertTrue(shipment.getReversal_ID() > 0);

			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			MFactAcct revChargeFact = revFacts.stream()
					.filter(fa -> fa.getC_Charge_ID() == charge.get_ID())
					.findFirst()
					.orElse(null);
			assertNotNull(revChargeFact, "Reversed shipment charge Fact_Acct line not found");
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
		assertFalse(as.isAllowNegativePosting(), "AllowNegativePosting should be disabled for this test");

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
			assertEquals(3, facts.size(), "Shipment should have 3 Fact_Acct lines (CoGS, Asset, Charge)");

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			// Original shipment: CoGS CR 50, Inventory CR 100 (same side!), Charge DR 150
			assertFactTotals(facts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("50.00"));
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(facts, freightAcctId, new BigDecimal("150.00"), BigDecimal.ZERO);

			// Reverse-Correct shipment and verify reversal posts cleanly
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertTrue(shipment.getReversal_ID() > 0, "Shipment reversal not created");

			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(3, revFacts.size(), "Reversal should have 3 Fact_Acct lines matching original shipment");
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

			// CostingPrecision = 4, StdPrecision = 2:
			// Material = 10.0040 (rounds to 10.00), Manual1 = 1.0040 (rounds to 1.00), Manual2 = 2.0040 (rounds to 2.00)
			// Unrounded sum = 13.0120 (would round to 13.01 -> out of balance with 10.00 + 1.00 + 2.00 = 13.00!)
			createPOAndMR(product, null, new BigDecimal("3"), new BigDecimal("10.004"));

			MCostElement ce1 = createManualCostElement("Round Burden 1",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement ce2 = createManualCostElement("Round Burden 2",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(product, as, ce1, 0, new BigDecimal("1.004"), 0);
			createManualCostRecord(product, as, ce2, 0, new BigDecimal("2.004"), 0);

			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("20.00"));
			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(4, facts.size(), "Expected 4 balanced Fact_Acct lines");

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
			MAttributeSet attrSet = new MAttributeSet(Env.getCtx(), 0, getTrxName());
			attrSet.setName("ManualCostLotAttrSet");
			attrSet.setIsLot(true);
			attrSet.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			attrSet.saveEx();
			MAttributeSet attrSetSpy = Mockito.spy(attrSet);
			Mockito.doReturn(true).when(attrSetSpy).excludeTableEntry(MOrderLine.Table_ID, true);
			Mockito.doReturn(true).when(attrSetSpy).excludeTableEntry(MInOutLine.Table_ID, true);
			mockedAttrSet.when(() -> MAttributeSet.getCopy(any(Properties.class), eq(attrSet.get_ID()), any())).thenReturn(attrSetSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(any(Properties.class), eq(attrSet.get_ID()))).thenReturn(attrSetSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(eq(attrSet.get_ID()))).thenReturn(attrSetSpy);

			MProductCategory lotCategory = new MProductCategory(Env.getCtx(), 0, getTrxName());
			lotCategory.setName("ManualCostLotCategory");
			lotCategory.saveEx();

			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(lotCategory.get_ID()))).thenReturn(lotCategory);
			mockedCategory.when(() -> MProductCategory.get(eq(lotCategory.get_ID()))).thenReturn(lotCategory);

			MProductCategoryAcct lotAcct = MProductCategoryAcct.get(lotCategory.get_ID(), as.get_ID(), getTrxName());
			lotAcct = new MProductCategoryAcct(Env.getCtx(), lotAcct, getTrxName());
			lotAcct.setCostingLevel(MAcctSchema.COSTINGLEVEL_BatchLot);
			lotAcct.setCostingMethod(MCostElement.COSTINGMETHOD_AveragePO);
			lotAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(lotCategory.get_ID(), as.get_ID(), getTrxName());

			MProduct product = createStockedProduct("ManualCostLotProd", lotCategory.get_ID(), attrSet.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lotA.setM_AttributeSet_ID(attrSet.get_ID());
			lotA.setLot("Lot-A");
			lotA.saveEx();

			MAttributeSetInstance lotB = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lotB.setM_AttributeSet_ID(attrSet.get_ID());
			lotB.setLot("Lot-B");
			lotB.saveEx();

			// Receive 2 of Lot-A @ 50 on an earlier date and 2 of Lot-B @ 80 later so FIFO consumes Lot-A first
			createPOAndMR(product, lotA, new BigDecimal("2"), new BigDecimal("50.00"), TimeUtil.addDays(getLoginDate(), -2));
			createPOAndMR(product, lotB, new BigDecimal("2"), new BigDecimal("80.00"), TimeUtil.addDays(getLoginDate(), -1));

			// Manual burden: 10% fallback at ASI=0, overridden to 20% for Lot-A (must NOT double-count 20%+10%)
			MCostElement burdenCe = createManualCostElement("Lot Burden",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, burdenCe, lotA.get_ID(), BigDecimal.ZERO, 20);

			// Ship 3 units without ASI (auto-allocates MInOutLineMA: 2 from Lot-A + 1 from Lot-B)
			// Material = 2*50 + 1*80 = 180.00; Manual = 20% of 100 (= 20.00) + 10% of 80 (= 8.00) = 28.00
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("3"), new BigDecimal("120.00"));
			MInOutLineMA[] shipMas = MInOutLineMA.get(Env.getCtx(), shipment.getLines()[0].get_ID(), getTrxName());
			assertEquals(2, shipMas.length, "Expected 2 MInOutLineMA allocations (Lot-A and Lot-B)");
			BigDecimal lotAQty = BigDecimal.ZERO;
			BigDecimal lotBQty = BigDecimal.ZERO;
			for (MInOutLineMA ma : shipMas)
			{
				if (ma.getM_AttributeSetInstance_ID() == lotA.get_ID())
					lotAQty = lotAQty.add(ma.getMovementQty());
				else if (ma.getM_AttributeSetInstance_ID() == lotB.get_ID())
					lotBQty = lotBQty.add(ma.getMovementQty());
			}
			assertEquals(new BigDecimal("2.00"), lotAQty.setScale(2, RoundingMode.HALF_UP),
					"Expected 2 units allocated from earlier Lot-A");
			assertEquals(new BigDecimal("1.00"), lotBQty.setScale(2, RoundingMode.HALF_UP),
					"Expected 1 unit allocated from later Lot-B");
			List<MFactAcct> facts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(3, facts.size(), "Expected 3 Fact_Acct lines (COGS, Asset, aggregated Burden Charge)");

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(facts, cogsAcctId, new BigDecimal("208.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("180.00"));
			assertFactTotals(facts, freightAcctId, BigDecimal.ZERO, new BigDecimal("28.00"));

			// Customer return of all 3 units (auto-allocates MInOutLineMA matching shipment: 2 Lot-A + 1 Lot-B)
			MInOut customerReturn = createCustomerReturn(shipment, shipment.getLines()[0], new BigDecimal("3"));
			List<MFactAcct> retFacts = getFacts(MInOut.Table_ID, customerReturn.get_ID(), as.get_ID());
			assertEquals(3, retFacts.size(), "Expected 3 Fact_Acct lines on Batch/Lot Customer Return");
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

			// Two distinct manual cost elements sharing the SAME Charge/GL Account
			MCostElement burdenCe = createManualCostElement("Return Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("Return Overhead Fixed 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			// Ship qty 2, then return qty 2 via Customer RMA + Customer Return
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			MInOutLine shipLine = shipment.getLines()[0];

			MInOut customerReturn = createCustomerReturn(shipment, shipLine, new BigDecimal("2"));
			MInOutLine returnLine = customerReturn.getLines()[0];

			List<MFactAcct> facts = getFacts(MInOut.Table_ID, customerReturn.get_ID(), as.get_ID());
			assertEquals(4, facts.size(), "Customer Return should have 4 Fact_Acct lines (Asset, COGS, 2 manual cost Charges)");

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			// DR Asset 200, DR Freight 20 + 10, CR COGS 230
			assertFactTotals(facts, assetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(facts, freightAcctId, new BigDecimal("30.00"), BigDecimal.ZERO);
			assertFactTotals(facts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("230.00"));

			List<BigDecimal> chargeDebits = new ArrayList<>();
			for (MFactAcct fa : facts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Customer Return manual cost line must record C_Charge_ID");
					chargeDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, chargeDebits.size(), "Expected 2 separate Charge debit lines on Customer Return");
			assertTrue(chargeDebits.contains(new BigDecimal("20.00")), "Missing 20.00 burden debit line");
			assertTrue(chargeDebits.contains(new BigDecimal("10.00")), "Missing 10.00 overhead debit line");

			// MCostDetail must remain material-only (+200.00)
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", returnLine.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for customer return line");
			assertEquals(new BigDecimal("200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Customer Return MCostDetail must record positive material cost only");

			// Mutate cost elements BEFORE reversing Customer Return
			burdenCe.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			burdenCe.saveEx();
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			// Reverse-Correct Customer Return and post reversal
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(customerReturn, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			customerReturn.load(getTrxName());
			assertTrue(customerReturn.getReversal_ID() > 0, "Customer Return reversal not created");

			MInOut reversal = new MInOut(Env.getCtx(), customerReturn.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Customer Return reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size(), "Customer Return reversal should have 4 Fact_Acct lines");
			assertFactTotals(revFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(revFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("30.00"));
			assertFactTotals(revFacts, cogsAcctId, new BigDecimal("230.00"), BigDecimal.ZERO);

			List<BigDecimal> chargeCredits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Reversed Customer Return Charge line must retain C_Charge_ID");
					chargeCredits.add(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, chargeCredits.size(), "Expected 2 separate Charge credit lines on Customer Return reversal");
			assertTrue(chargeCredits.contains(new BigDecimal("20.00")), "Missing 20.00 reversed burden credit line");
			assertTrue(chargeCredits.contains(new BigDecimal("10.00")), "Missing 10.00 reversed overhead credit line");
		}
	}

	/**
	 * When Product Asset account is changed after posting to the same account as a manual-cost Charge,
	 * reversing the Shipment or Customer Return must still reverse each original fact on its original account
	 * and reverse the original inventory cost detail (100), never misidentifying the Charge fact (5) as inventory.
	 */
	@Test
	public void testShipmentAndReturnReversalWhenProductAssetChangedToChargeAccount()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostAssetSwapProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			// Receive qty 2 @ 100.00
			createPOAndMR(product, null, new BigDecimal("2"), new BigDecimal("100.00"));

			// Fixed manual cost 5.00 linked to Freight charge (account C)
			MCostElement overheadCe = createManualCostElement("AssetSwap Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int origCogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int origAssetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			MAccount freightAcct = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(freightAcct);
			int freightAcctId = freightAcct.getAccount_ID();
			assertTrue(origAssetAcctId != freightAcctId, "Product Asset and Freight Charge accounts must differ initially");

			// 1. Post Shipment (qty 1): DR CoGS 105 (A), CR Asset 100 (B), CR Freight 5 (C)
			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("180.00"));
			MInOutLine shipLine = shipment.getLines()[0];
			MCostDetail origShipCd = MCostDetail.getShipment(as, product.get_ID(), 0, shipLine.get_ID(), 0, getTrxName());
			assertNotNull(origShipCd, "Original Shipment MCostDetail not found");
			assertEquals(new BigDecimal("-100.00"), origShipCd.getAmt().setScale(2, RoundingMode.HALF_UP));

			// Also post a second Shipment + Customer Return BEFORE changing P_Asset_Acct
			MInOut shipment2 = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("180.00"));
			MInOutLine shipLine2 = shipment2.getLines()[0];
			MInOut customerReturn = createCustomerReturn(shipment2, shipLine2, BigDecimal.ONE);
			MInOutLine returnLine = customerReturn.getLines()[0];
			MCostDetail origReturnCd = MCostDetail.getShipment(as, product.get_ID(), 0, returnLine.get_ID(), 0, getTrxName());
			assertNotNull(origReturnCd, "Original Customer Return MCostDetail not found");
			assertEquals(new BigDecimal("100.00"), origReturnCd.getAmt().setScale(2, RoundingMode.HALF_UP));

			// Change Product Asset (P_Asset_Acct) from B to C (the Freight Charge account)
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] {freightAcct.get_ID(), product.get_ID(), as.get_ID()}, getTrxName());
			CacheMgt.get().reset();

			// Reverse Shipment and post reversal
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertTrue(shipment.getReversal_ID() > 0, "Shipment reversal not created");
			MInOut shipRev = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!shipRev.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), shipRev.getAD_Client_ID(),
						shipRev.get_Table_ID(), shipRev.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed after P_Asset_Acct changed to Charge account: " + error);
			}

			List<MFactAcct> shipRevFacts = getFacts(MInOut.Table_ID, shipRev.get_ID(), as.get_ID());
			assertEquals(3, shipRevFacts.size(), "Shipment reversal should have 3 Fact_Acct lines");
			assertFactTotals(shipRevFacts, origCogsAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			assertFactTotals(shipRevFacts, origAssetAcctId, new BigDecimal("100.00"), BigDecimal.ZERO);
			assertFactTotals(shipRevFacts, freightAcctId, new BigDecimal("5.00"), BigDecimal.ZERO);
			for (MFactAcct fa : shipRevFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Reversed Charge fact must preserve C_Charge_ID");
				else
					assertEquals(0, fa.getC_Charge_ID(), "Reversed CoGS/Asset facts must not carry C_Charge_ID");
			}

			MInOutLine shipRevLine = shipRev.getLines()[0];
			MCostDetail revShipCd = MCostDetail.getShipment(as, product.get_ID(), 0, shipRevLine.get_ID(), 0, getTrxName());
			assertNotNull(revShipCd, "Shipment reversal MCostDetail not found");
			assertEquals(origShipCd.getM_CostDetail_ID(), revShipCd.getRef_CostDetail_ID());
			assertEquals(new BigDecimal("100.00"), revShipCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Shipment reversal MCostDetail must reverse inventory cost (100), not manual charge (5)");

			// 2. Reverse Customer Return and post reversal while P_Asset_Acct is still C
			info = MWorkflow.runDocumentActionWorkflow(customerReturn, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			customerReturn.load(getTrxName());
			assertTrue(customerReturn.getReversal_ID() > 0, "Customer Return reversal not created");
			MInOut retRev = new MInOut(Env.getCtx(), customerReturn.getReversal_ID(), getTrxName());
			if (!retRev.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), retRev.getAD_Client_ID(),
						retRev.get_Table_ID(), retRev.get_ID(), false, getTrxName());
				assertNull(error, "Customer Return reversal posting failed after P_Asset_Acct changed to Charge account: " + error);
			}

			List<MFactAcct> retRevFacts = getFacts(MInOut.Table_ID, retRev.get_ID(), as.get_ID());
			assertEquals(3, retRevFacts.size(), "Customer Return reversal should have 3 Fact_Acct lines");
			assertFactTotals(retRevFacts, origAssetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(retRevFacts, origCogsAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);
			assertFactTotals(retRevFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));

			MInOutLine retRevLine = retRev.getLines()[0];
			MCostDetail revReturnCd = MCostDetail.getShipment(as, product.get_ID(), 0, retRevLine.get_ID(), 0, getTrxName());
			assertNotNull(revReturnCd, "Customer Return reversal MCostDetail not found");
			assertEquals(origReturnCd.getM_CostDetail_ID(), revReturnCd.getRef_CostDetail_ID());
			assertEquals(new BigDecimal("-100.00"), revReturnCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Customer Return reversal MCostDetail must reverse inventory cost (-100), not manual charge (-5)");
		}
	}

	@Test
	public void testReplayedReversalFactsSkipSubsequentGLDistribution()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ReplayNoRedistShipProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("10"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ReplayNoRedist Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			int commissionsAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName()).getAccount_ID();
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();

			// 1. Post original shipment BEFORE any GL distribution rule exists -> credits Freight (A) 20.00
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[0]);
			MInOut origShipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			List<MFactAcct> origFacts = getFacts(MInOut.Table_ID, origShipment.get_ID(), as.get_ID());
			assertFactTotals(origFacts, cogsAcctId, new BigDecimal("220.00"), BigDecimal.ZERO);
			assertFactTotals(origFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(origFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("20.00"));
			assertFactTotals(origFacts, commissionsAcctId, BigDecimal.ZERO, BigDecimal.ZERO);

			// 2. Activate a new GL distribution rule that replaces Freight (A) with Commissions (B)
			MDistribution newRule = new MDistribution(Env.getCtx(), 0, getTrxName());
			newRule.setName("Test New Rule Replace Freight With Commissions");
			newRule.setC_AcctSchema_ID(as.get_ID());
			newRule.setIsCreateReversal(false);
			newRule.setAnyAcct(false);
			newRule.setAccount_ID(freightAcctId);
			newRule.saveEx();

			MDistributionLine ndl = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			ndl.setGL_Distribution_ID(newRule.get_ID());
			ndl.setLine(10);
			ndl.setPercent(new BigDecimal("100"));
			ndl.setOverwriteAcct(true);
			ndl.setAccount_ID(commissionsAcctId);
			ndl.saveEx();

			newRule.load(getTrxName());
			newRule.getLines(true);
			assertTrue(newRule.isValid(), "New GL Distribution rule should be valid");
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { newRule });

			// 3. Reverse original shipment: replayed Freight fact must debit Freight (A), NOT Commissions (B)
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(origShipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			origShipment.load(getTrxName());
			MInOut reversal = new MInOut(Env.getCtx(), origShipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertFactTotals(revFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("220.00"));
			assertFactTotals(revFacts, assetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("20.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, commissionsAcctId, BigDecimal.ZERO, BigDecimal.ZERO);

			// 4. Newly calculated shipment while the new rule IS active must still apply GL distribution to Commissions (B)
			MInOut newShipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			List<MFactAcct> newFacts = getFacts(MInOut.Table_ID, newShipment.get_ID(), as.get_ID());
			assertFactTotals(newFacts, cogsAcctId, new BigDecimal("220.00"), BigDecimal.ZERO);
			assertFactTotals(newFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(newFacts, freightAcctId, BigDecimal.ZERO, BigDecimal.ZERO);
			assertFactTotals(newFacts, commissionsAcctId, BigDecimal.ZERO, new BigDecimal("20.00"));
		}
	}

	@Test
	public void testReversalPreservesUnsetSalesRegion()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("SalesRegRevProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("SalesReg Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("1"), new BigDecimal("150.00"));
			List<MFactAcct> origFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertTrue(origFacts.size() >= 3);

			// Ensure original facts had unset C_SalesRegion_ID = 0 (or force BP location to 0 before shipping)
			// Assign a sales region to the shipment's BP location BEFORE reversing
			MBPartnerLocation bpLoc = new MBPartnerLocation(Env.getCtx(), shipment.getC_BPartner_Location_ID(), getTrxName());
			int origBpSalesRegionId = bpLoc.getC_SalesRegion_ID();
			if (origBpSalesRegionId != 0)
			{
				// Force original facts to 0 to simulate posting when BP location had no sales region
				DB.executeUpdateEx("UPDATE Fact_Acct SET C_SalesRegion_ID=NULL WHERE AD_Table_ID=? AND Record_ID=?",
						new Object[] { MInOut.Table_ID, shipment.get_ID() }, getTrxName());
				origFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			}
			for (MFactAcct fa : origFacts)
				assertEquals(0, fa.getC_SalesRegion_ID(), "Original fact should have unset C_SalesRegion_ID=0");

			MSalesRegion sr = new MSalesRegion(Env.getCtx(), 0, getTrxName());
			sr.setValue("SR_REV_TEST");
			sr.setName("Sales Region Reversal Test");
			sr.saveEx();

			bpLoc.setC_SalesRegion_ID(sr.get_ID());
			bpLoc.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(origFacts.size(), revFacts.size());
			for (MFactAcct fa : revFacts)
				assertEquals(0, fa.getC_SalesRegion_ID(),
						"Replayed reversal fact must preserve unset C_SalesRegion_ID=0 instead of deriving new BP location region");
		}
	}

	@Test
	public void testKnownZeroBaseCostWithManualChargeOnShipmentAndReturn()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			// 1. Product with material=100, unmapped adjustment=-100 (known zero base), charge-mapped fixed overhead=5
			MProduct product = createStockedProduct("KnownZeroBaseProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement unmappedAdjCe = createManualCostElement("ZeroBase Unmapped Adj -100",
					MCostElement.COSTELEMENTTYPE_Overhead, 0);
			createManualCostRecord(product, as, unmappedAdjCe, 0, new BigDecimal("-100.00"), 0);

			MCostElement overheadCe = createManualCostElement("ZeroBase Fixed Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			// Sales Shipment of qty 2: COGS DR 10.00, Inventory CR 0.00, Freight Charge CR 10.00
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("50.00"));
			List<MFactAcct> shipFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(shipFacts, cogsAcctId, new BigDecimal("10.00"), BigDecimal.ZERO);
			assertFactTotals(shipFacts, assetAcctId, BigDecimal.ZERO, BigDecimal.ZERO);
			assertFactTotals(shipFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("10.00"));

			// Sales Return of qty 1: Inventory DR 0.00, COGS CR 5.00, Freight Charge DR 5.00
			MInOutLine shipLine = shipment.getLines(true)[0];
			MInOut customerReturn = createCustomerReturn(shipment, shipLine, BigDecimal.ONE);
			List<MFactAcct> retFacts = getFacts(MInOut.Table_ID, customerReturn.get_ID(), as.get_ID());
			assertFactTotals(retFacts, assetAcctId, BigDecimal.ZERO, BigDecimal.ZERO);
			assertFactTotals(retFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));
			assertFactTotals(retFacts, freightAcctId, new BigDecimal("5.00"), BigDecimal.ZERO);

			// 2. Product with MISSING material valuation (never received, CurrentCostPrice=0) + fixed overhead 5 must still fail
			MProduct noCostProduct = createStockedProduct("MissingValProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, noCostProduct);
			createManualCostRecord(noCostProduct, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
			so.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			so.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			so.setDeliveryRule(MOrder.DELIVERYRULE_Force);
			so.setDocStatus(DocAction.STATUS_Drafted);
			so.setDocAction(DocAction.ACTION_Complete);
			so.setDateOrdered(getLoginDate());
			so.setDatePromised(getLoginDate());
			so.setIsSOTrx(true);
			so.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			so.saveEx();

			MOrderLine soLine = new MOrderLine(so);
			soLine.setLine(10);
			soLine.setProduct(noCostProduct);
			soLine.setQty(BigDecimal.ONE);
			soLine.setDatePromised(getLoginDate());
			soLine.setPrice(new BigDecimal("50.00"));
			soLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(so, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			MInOut missingValShip = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, so.getDateOrdered());
			missingValShip.setDocStatus(DocAction.STATUS_Drafted);
			missingValShip.setDocAction(DocAction.ACTION_Complete);
			missingValShip.saveEx();
			MInOutLine missingValLine = new MInOutLine(missingValShip);
			missingValLine.setOrderLine(soLine, 0, BigDecimal.ONE);
			missingValLine.setQty(BigDecimal.ONE);
			missingValLine.saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(missingValShip, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
			}
			String err = DocumentEngine.postImmediate(Env.getCtx(), missingValShip.getAD_Client_ID(),
					missingValShip.get_Table_ID(), missingValShip.get_ID(), false, getTrxName());
			assertNotNull(err, "Shipment with missing material valuation data must still be rejected");
		}
	}

	@Test
	public void testShipmentReversalFallbackIgnoresCogsWhenAssetAccountChangedToCogs()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("AssetChangedToCogsProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement overheadCe = createManualCostElement("AssetToCogs Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("150.00"));
			MInOutLine origShipLine = shipment.getLines(true)[0];

			// Delete original shipment M_CostDetail so reversal must use resolveReversalInventoryCost fallback
			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE M_InOutLine_ID=?",
					new Object[] { origShipLine.get_ID() }, getTrxName());

			// Change product's P_Asset_Acct to its P_Cogs_Acct before reversing
			int cogsVcId = DB.getSQLValueEx(getTrxName(),
					"SELECT P_Cogs_Acct FROM M_Product_Acct WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					product.get_ID(), as.get_ID());
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] { cogsVcId, product.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset("ProductCost_ValidCombination");

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed: " + error);
			}

			MInOutLine revShipLine = reversal.getLines(true)[0];
			MCostDetail revCd = MCostDetail.getShipment(as, product.get_ID(), 0, revShipLine.get_ID(), 0, getTrxName());
			assertNotNull(revCd, "Reversal shipment M_CostDetail should be created");
			assertEquals(new BigDecimal("100.00"), revCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Fallback must return +100.00 inventory cost, not -105.00 COGS amount");
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
		assertTrue(foundOrgElem, "Organization acct schema element should exist");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAcctSchemaElement> mockedElem = mockStatic(MAcctSchemaElement.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			mockedElem.when(() -> MAcctSchemaElement.getAcctSchemaElements(any(MAcctSchema.class)))
					.thenReturn(balancedElems);

			MProduct product = createStockedProduct("MultiOrgBalProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			// Receive stock in HQ warehouse (Org HQ = 11)
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement overheadCe = createManualCostElement("MultiOrg Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			// Move COGS DR 105.00 to Org STORE_CENTRAL while Inventory CR 100.00 and Charge CR 5.00 remain in Org HQ,
			// triggering organization-balancing DueTo (CR 105.00 in STORE_CENTRAL) and DueFrom (DR 105.00 in HQ).
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
			assertTrue(orgDist.isValid(), "Multi-org GL Distribution should be valid");
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { orgDist });

			MInOut shipment = createSOAndShipment(product, null, BigDecimal.ONE, new BigDecimal("150.00"));
			ProcessInfo info;

			int dueToAcctId = as.getDueTo_Acct(MAcctSchemaElement.ELEMENTTYPE_Organization).getAccount_ID();
			int dueFromAcctId = as.getDueFrom_Acct(MAcctSchemaElement.ELEMENTTYPE_Organization).getAccount_ID();
			List<MFactAcct> origFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			// Original shipment should have DueTo CR 105.00 in STORE_CENTRAL and DueFrom DR 105.00 in HQ
			assertFactTotals(origFacts, dueToAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			assertFactTotals(origFacts, dueFromAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);

			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Multi-org shipment reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			// Reversal must reverse original DueTo (DR 105.00 in STORE_CENTRAL) and DueFrom (CR 105.00 in HQ) so intercompany accounts net to zero!
			assertFactTotals(revFacts, dueToAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, dueFromAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == dueToAcctId)
				{
					assertEquals(DictionaryIDs.AD_Org.STORE_CENTRAL.id, fa.getAD_Org_ID(), "Reversed DueTo must stay in STORE_CENTRAL");
					assertEquals(0, fa.getLine_ID(), "Reversed balancing fact must have no Line_ID");
				}
				else if (fa.getAccount_ID() == dueFromAcctId)
				{
					assertEquals(DictionaryIDs.AD_Org.HQ.id, fa.getAD_Org_ID(), "Reversed DueFrom must stay in HQ");
					assertEquals(0, fa.getLine_ID(), "Reversed balancing fact must have no Line_ID");
				}
			}
		}
	}

	@Test
	public void testShipmentKnownZeroBaseCostWithFifoQueueAndProductOverride()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory fifoCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			fifoCat.setName("ManualCostFifoZeroBaseCat");
			fifoCat.saveEx();
			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(fifoCat.get_ID()))).thenReturn(fifoCat);
			mockedCategory.when(() -> MProductCategory.get(eq(fifoCat.get_ID()))).thenReturn(fifoCat);

			MProductCategoryAcct fifoAcct = MProductCategoryAcct.get(fifoCat.get_ID(), as.get_ID(), getTrxName());
			fifoAcct = new MProductCategoryAcct(Env.getCtx(), fifoAcct, getTrxName());
			fifoAcct.setCostingMethod(MCostElement.COSTINGMETHOD_Fifo);
			fifoAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(fifoCat.get_ID(), as.get_ID(), getTrxName());

			MProduct product = createStockedProduct("FifoZeroBaseProd", fifoCat.get_ID(), 0);
			mockProductGet(mockedProduct, product);

			// Create two ASIs so FIFO queue orders asi1 (price 0, qty 1) before asi2 (price 100, qty 5)
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("FIFO-ZERO-LAYER");
			asi1.setDescription();
			asi1.saveEx();

			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi2.setLot("FIFO-POS-LAYER");
			asi2.setDescription();
			asi2.saveEx();
			assertTrue(asi1.get_ID() < asi2.get_ID(), "Expected first ASI to have lower ID for FIFO ordering");

			// Seed on-hand stock and two FIFO queue layers directly (no zero-cost PO M_CostDetail exists):
			// asi1 (lower ID): qty 1 @ 0.00, asi2 (higher ID): qty 5 @ 100.00
			assertTrue(MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product.get_ID(), 0,
					new BigDecimal("5"), getLoginDate(), getTrxName()), "Failed to add on-hand stock");

			MCostElement fifoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_Fifo);
			MCost.CostingKey key = MCost.CostingKey.resolve(getAD_Org_ID(), 0, product.getCostingLevel(as));
			MCost fifoCost = MCost.get(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			fifoCost.setCurrentCostPrice(new BigDecimal("100.00"));
			fifoCost.setCurrentQty(new BigDecimal("5"));
			fifoCost.saveEx();

			MCostElement avgPoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AveragePO);
			MCost avgPoCost = MCost.get(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgPoCe.get_ID(), getTrxName());
			avgPoCost.setCurrentCostPrice(new BigDecimal("100.00"));
			avgPoCost.setCurrentQty(new BigDecimal("5"));
			avgPoCost.saveEx();

			MCostElement avgInvCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AverageInvoice);
			if (avgInvCe != null)
			{
				MCost avgInvCost = MCost.get(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgInvCe.get_ID(), getTrxName());
				avgInvCost.setCurrentCostPrice(new BigDecimal("100.00"));
				avgInvCost.setCurrentQty(new BigDecimal("5"));
				avgInvCost.saveEx();
			}

			// Seed material cost on any secondary accounting schemas (e.g. GardenWorld Euro) so multi-schema posting succeeds
			for (MAcctSchema clientAs : MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID(), getTrxName()))
			{
				if (clientAs.get_ID() == as.get_ID())
					continue;
				MCost.CostingKey secKey = MCost.CostingKey.resolve(getAD_Org_ID(), 0, product.getCostingLevel(clientAs));
				MCostElement secCe = MCostElement.getMaterialCostElement(clientAs, clientAs.getCostingMethod());
				if (secCe != null)
				{
					MCost secCost = MCost.get(product, secKey.M_AttributeSetInstance_ID(), clientAs, secKey.AD_Org_ID(),
							secCe.get_ID(), getTrxName());
					secCost.setCurrentCostPrice(new BigDecimal("100.00"));
					secCost.setCurrentQty(new BigDecimal("5"));
					secCost.saveEx();
				}
			}

			MCostQueue zeroQueue = MCostQueue.get(product, asi1.get_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			zeroQueue.setCurrentQty(BigDecimal.ONE);
			zeroQueue.setCurrentCostPrice(BigDecimal.ZERO);
			zeroQueue.saveEx();

			MCostQueue posQueue = MCostQueue.get(product, asi2.get_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			posQueue.setCurrentQty(new BigDecimal("5"));
			posQueue.setCurrentCostPrice(new BigDecimal("100.00"));
			posQueue.saveEx();

			// For qty=2: FIFO material = (1 * 0) + (1 * 100) = 100; unmapped adj = -50/unit = -100 -> net base cost = 0
			MCostElement unmappedAdjCe = createManualCostElement("FifoZeroBase Unmapped -50",
					MCostElement.COSTELEMENTTYPE_Overhead, 0);
			createManualCostRecord(product, as, unmappedAdjCe, 0, new BigDecimal("-50.00"), 0);

			MCostElement overheadCe = createManualCostElement("FifoZeroBase Fixed Charge 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			// Direct verification: positive qty=2 sees positive layer (true); negative qty=-2 only inspects costQ[0] (false)
			assertTrue(MCost.hasMaterialCost(product, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_Fifo,
					new BigDecimal("2"), getLoginDate(), getTrxName()),
					"FIFO hasMaterialCost with positive qty=2 must see non-zero second layer");
			assertFalse(MCost.hasMaterialCost(product, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_Fifo,
					new BigDecimal("-2"), getLoginDate(), getTrxName()),
					"FIFO hasMaterialCost with negative qty=-2 only inspects first zero layer");

			// Shipment of qty 2 must pass positive qty to hasKnownZeroBaseCost and post COGS DR 10 / Charge CR 10
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("150.00"));
			List<MFactAcct> shipFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(shipFacts, cogsAcctId, new BigDecimal("10.00"), BigDecimal.ZERO);
			assertFactTotals(shipFacts, assetAcctId, BigDecimal.ZERO, BigDecimal.ZERO);
			assertFactTotals(shipFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("10.00"));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testShipmentReversalDoesNotCreateValidCombinationsAndHandlesForeignCurrency()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MConversionRate> mockedRate = mockStatic(MConversionRate.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("NoVcBloatShipProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("NoVcBloat Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("180.00"));
			List<MFactAcct> origFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(3, origFacts.size(), "Expected COGS, Asset, and Charge facts");

			// Simulate original facts posted in a foreign currency (EUR) with half source amounts
			DB.executeUpdateEx(
					"UPDATE Fact_Acct SET C_Currency_ID=?, AmtSourceDr=ROUND(AmtAcctDr/2, 2), AmtSourceCr=ROUND(AmtAcctCr/2, 2) "
							+ "WHERE AD_Table_ID=? AND Record_ID=? AND C_AcctSchema_ID=?",
					new Object[] { DictionaryIDs.C_Currency.EUR.id, MInOut.Table_ID, shipment.get_ID(), as.get_ID() },
					getTrxName());

			// Block EUR->schema conversion on reversal date to prove reversal replay does not invoke FX conversion
			mockedRate.when(() -> MConversionRate.convert(any(), any(), eq(DictionaryIDs.C_Currency.EUR.id),
					eq(as.getC_Currency_ID()), any(), Mockito.anyInt(), Mockito.anyInt(), Mockito.anyInt()))
					.thenReturn(null);
			mockedRate.when(() -> MConversionRate.getRate(eq(DictionaryIDs.C_Currency.EUR.id),
					eq(as.getC_Currency_ID()), any(), Mockito.anyInt(), Mockito.anyInt(), Mockito.anyInt()))
					.thenReturn(null);

			int vcCountBefore = DB.getSQLValueEx(getTrxName(),
					"SELECT COUNT(*) FROM C_ValidCombination WHERE AD_Client_ID=?", getAD_Client_ID());

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed: " + error);
			}

			int vcCountAfter = DB.getSQLValueEx(getTrxName(),
					"SELECT COUNT(*) FROM C_ValidCombination WHERE AD_Client_ID=?", getAD_Client_ID());
			assertEquals(vcCountBefore, vcCountAfter,
					"Replaying reversal facts must not insert new C_ValidCombination rows");

			List<MFactAcct> revFacts = getFacts(MInOut.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(3, revFacts.size());
			for (MFactAcct fa : revFacts)
			{
				assertEquals(DictionaryIDs.C_Currency.EUR.id, fa.getC_Currency_ID(),
						"Reversed fact must preserve original foreign currency");
				BigDecimal expectedSrcDr = fa.getAmtAcctDr().divide(new BigDecimal("2"), 2, RoundingMode.HALF_UP);
				BigDecimal expectedSrcCr = fa.getAmtAcctCr().divide(new BigDecimal("2"), 2, RoundingMode.HALF_UP);
				assertEquals(0, expectedSrcDr.compareTo(fa.getAmtSourceDr()), "Reversed AmtSourceDr mismatch");
				assertEquals(0, expectedSrcCr.compareTo(fa.getAmtSourceCr()), "Reversed AmtSourceCr mismatch");
			}
		}
	}
}
