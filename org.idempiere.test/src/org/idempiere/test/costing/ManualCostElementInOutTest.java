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
import org.compiere.model.MCostQueue;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutConfirm;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
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
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
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
			assertEquals(new BigDecimal("100.00"), assetDr.setScale(2, RoundingMode.HALF_UP), "Reversed Asset fact must debit 100.00 without C_Charge_ID");
			assertEquals(new BigDecimal("5.00"), chargeDr.setScale(2, RoundingMode.HALF_UP), "Reversed Charge fact must debit 5.00 with C_Charge_ID");

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

			MInOutLine retRevLine = retRev.getLines()[0];
			MCostDetail revReturnCd = MCostDetail.getShipment(as, product.get_ID(), 0, retRevLine.get_ID(), 0, getTrxName());
			assertNotNull(revReturnCd, "Customer Return reversal MCostDetail not found");
			assertEquals(origReturnCd.getM_CostDetail_ID(), revReturnCd.getRef_CostDetail_ID());
			assertEquals(new BigDecimal("-100.00"), revReturnCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Customer Return reversal MCostDetail must reverse inventory cost (-100), not manual charge (-5)");
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
			so.setDateAcct(getLoginDate());
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
			assertTrue(err.contains(Msg.getMsg(Env.getCtx(), "No Costs for")) && err.contains(noCostProduct.getName()),
					"Expected missing-valuation 'No Costs for' error for " + noCostProduct.getName() + ", got: " + err);
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
			// Standard Fact.balanceSegment() balances each Org on reversal: DueFrom DR 105.00 in STORE_CENTRAL and DueTo CR 105.00 in HQ
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
					assertEquals(DictionaryIDs.AD_Org.HQ.id, fa.getAD_Org_ID(), "Reversal DueTo balancing fact should be in HQ");
					assertEquals(0, fa.getLine_ID(), "Balancing fact must have no Line_ID");
				}
				else if (fa.getAccount_ID() == dueFromAcctId)
				{
					assertEquals(DictionaryIDs.AD_Org.STORE_CENTRAL.id, fa.getAD_Org_ID(), "Reversal DueFrom balancing fact should be in STORE_CENTRAL");
					assertEquals(0, fa.getLine_ID(), "Balancing fact must have no Line_ID");
				}
			}
			assertEquals(0, hqNet.signum(), "HQ org must balance to 0.00 on multi-org reversal");
			assertEquals(0, storeNet.signum(), "STORE_CENTRAL org must balance to 0.00 on multi-org reversal");
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
			// Realistic MCostDetail state: first FIFO queue layer has price 0, so M_Cost.CurrentCostPrice is 0
			MCost fifoCost = MCost.get(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			fifoCost.setCurrentCostPrice(BigDecimal.ZERO);
			fifoCost.setCurrentQty(new BigDecimal("6"));
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

			// Direct verification with CurrentCostPrice=0:
			// positive qty=2 sees second layer (true); qty=1 and negative qty=-2 only inspect first zero layer (false)
			assertTrue(MCost.hasMaterialCost(product, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_Fifo,
					new BigDecimal("2"), getLoginDate(), getTrxName()),
					"FIFO hasMaterialCost with positive qty=2 must see non-zero second layer even when CurrentCostPrice=0");
			assertFalse(MCost.hasMaterialCost(product, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_Fifo,
					BigDecimal.ONE, getLoginDate(), getTrxName()),
					"FIFO hasMaterialCost with qty=1 only consumes first zero layer");
			assertFalse(MCost.hasMaterialCost(product, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_Fifo,
					new BigDecimal("-2"), getLoginDate(), getTrxName()),
					"FIFO hasMaterialCost with negative qty=-2 only inspects first zero layer");

			// Shipment of qty 2 with unmapped -50/unit offsets FIFO 100 to net 0 -> posts COGS DR 10 / Asset 0 / Charge CR 10
			MInOut shipment = createSOAndShipment(product, null, new BigDecimal("2"), new BigDecimal("150.00"));
			List<MFactAcct> shipFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(shipFacts, cogsAcctId, new BigDecimal("10.00"), BigDecimal.ZERO);
			assertFactTotals(shipFacts, assetAcctId, BigDecimal.ZERO, BigDecimal.ZERO);
			assertFactTotals(shipFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("10.00"));

			// Also verify WITHOUT unmapped adjustment (and CurrentCostPrice still 0): MCost.getCost must consult FIFO queue
			// and value 2 units at 100.00 (not 0.00), posting COGS DR 110 / Asset CR 100 / Charge CR 10
			MProduct fifoNoAdjProd = createStockedProduct("FifoZeroFirstLayerNoAdj", fifoCat.get_ID(), 0);
			mockProductGet(mockedProduct, fifoNoAdjProd);
			assertTrue(MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, fifoNoAdjProd.get_ID(), 0,
					new BigDecimal("6"), getLoginDate(), getTrxName()), "Failed to add on-hand stock");
			MCost fifoNoAdjCost = MCost.get(fifoNoAdjProd, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			fifoNoAdjCost.setCurrentCostPrice(BigDecimal.ZERO);
			fifoNoAdjCost.setCurrentQty(new BigDecimal("6"));
			fifoNoAdjCost.saveEx();
			MCost avgPoNoAdjCost = MCost.get(fifoNoAdjProd, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgPoCe.get_ID(), getTrxName());
			avgPoNoAdjCost.setCurrentCostPrice(new BigDecimal("100.00"));
			avgPoNoAdjCost.setCurrentQty(new BigDecimal("6"));
			avgPoNoAdjCost.saveEx();
			if (avgInvCe != null)
			{
				MCost avgInvNoAdjCost = MCost.get(fifoNoAdjProd, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgInvCe.get_ID(), getTrxName());
				avgInvNoAdjCost.setCurrentCostPrice(new BigDecimal("100.00"));
				avgInvNoAdjCost.setCurrentQty(new BigDecimal("6"));
				avgInvNoAdjCost.saveEx();
			}
			for (MAcctSchema clientAs : MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID(), getTrxName()))
			{
				if (clientAs.get_ID() == as.get_ID())
					continue;
				MCost.CostingKey secKey = MCost.CostingKey.resolve(getAD_Org_ID(), 0, fifoNoAdjProd.getCostingLevel(clientAs));
				MCostElement secCe = MCostElement.getMaterialCostElement(clientAs, clientAs.getCostingMethod());
				if (secCe != null)
				{
					MCost secCost = MCost.get(fifoNoAdjProd, secKey.M_AttributeSetInstance_ID(), clientAs, secKey.AD_Org_ID(),
							secCe.get_ID(), getTrxName());
					secCost.setCurrentCostPrice(new BigDecimal("100.00"));
					secCost.setCurrentQty(new BigDecimal("6"));
					secCost.saveEx();
				}
			}
			MCostQueue q0 = MCostQueue.get(fifoNoAdjProd, asi1.get_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			q0.setCurrentQty(BigDecimal.ONE);
			q0.setCurrentCostPrice(BigDecimal.ZERO);
			q0.saveEx();
			MCostQueue q1 = MCostQueue.get(fifoNoAdjProd, asi2.get_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			q1.setCurrentQty(new BigDecimal("5"));
			q1.setCurrentCostPrice(new BigDecimal("100.00"));
			q1.saveEx();
			createManualCostRecord(fifoNoAdjProd, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MInOut noAdjShip = createSOAndShipment(fifoNoAdjProd, null, new BigDecimal("2"), new BigDecimal("150.00"));
			List<MFactAcct> noAdjFacts = getFacts(MInOut.Table_ID, noAdjShip.get_ID(), as.get_ID());
			ProductCost pc2 = new ProductCost(Env.getCtx(), fifoNoAdjProd.get_ID(), 0, getTrxName());
			assertFactTotals(noAdjFacts, pc2.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID(), new BigDecimal("110.00"), BigDecimal.ZERO);
			assertFactTotals(noAdjFacts, pc2.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID(), BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(noAdjFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("10.00"));

			// Empty FIFO queue product with CurrentCostPrice=0 must still report hasMaterialCost=false
			MProduct emptyFifoProd = createStockedProduct("FifoEmptyQueueProd", fifoCat.get_ID(), 0);
			mockProductGet(mockedProduct, emptyFifoProd);
			assertFalse(MCost.hasMaterialCost(emptyFifoProd, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_Fifo,
					new BigDecimal("2"), getLoginDate(), getTrxName()),
					"Empty FIFO queue must return hasMaterialCost=false");
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}


	@Test
	public void testBatchLotRejectsUnvaluedChargeBearingLotAndAcceptsKnownZeroBaseLot()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			batchCat.setName("LotValGuardBatchCat");
			batchCat.saveEx();
			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(batchCat.get_ID()))).thenReturn(batchCat);
			mockedCategory.when(() -> MProductCategory.get(eq(batchCat.get_ID()))).thenReturn(batchCat);

			MProductCategoryAcct batchAcct = MProductCategoryAcct.get(batchCat.get_ID(), as.get_ID(), getTrxName());
			batchAcct = new MProductCategoryAcct(Env.getCtx(), batchAcct, getTrxName());
			batchAcct.setCostingLevel(MAcctSchema.COSTINGLEVEL_BatchLot);
			batchAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(batchCat.get_ID(), as.get_ID(), getTrxName());

			MAttributeSet lotAs = new MAttributeSet(Env.getCtx(), 0, getTrxName());
			lotAs.setName("LotValGuardAS");
			lotAs.setIsLot(true);
			lotAs.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			lotAs.saveEx();
			MAttributeSet lotAsSpy = Mockito.spy(lotAs);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MOrderLine.Table_ID, true);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MInOutLine.Table_ID, true);
			mockedAttrSet.when(() -> MAttributeSet.getCopy(any(Properties.class), eq(lotAs.get_ID()), any())).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(any(Properties.class), eq(lotAs.get_ID()))).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(eq(lotAs.get_ID()))).thenReturn(lotAsSpy);

			MProduct product = createStockedProduct("LotValGuardProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lotA = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lotA.setM_AttributeSet_ID(lotAs.get_ID());
			lotA.setLot("LOT-VAL-A");
			lotA.setDescription();
			lotA.saveEx();

			MAttributeSetInstance lotB = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lotB.setM_AttributeSet_ID(lotAs.get_ID());
			lotB.setLot("LOT-VAL-B");
			lotB.setDescription();
			lotB.saveEx();

			// Lot A received at 100.00; Lot B has stock on hand ONLY (no receipt/cost valuation)
			createPOAndMR(product, lotA, new BigDecimal("5"), new BigDecimal("100.00"));
			assertTrue(MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product.get_ID(), lotB.get_ID(),
					new BigDecimal("5"), getLoginDate(), getTrxName()));

			// Fixed charge 5.00 applies to all lots (ASI=0 fallback)
			MCostElement overheadCe = createManualCostElement("LotValGuard Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
			so.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			so.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			so.setIsSOTrx(true);
			so.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			so.setDocStatus(DocAction.STATUS_Drafted);
			so.setDocAction(DocAction.ACTION_Complete);
			so.setDateOrdered(getLoginDate());
			so.setDateAcct(getLoginDate());
			so.setDatePromised(getLoginDate());
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

			MInOut shipment = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, getLoginDate());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			MInOutLine shipLine = new MInOutLine(shipment);
			shipLine.setOrderLine(soLine, 0, new BigDecimal("2"));
			shipLine.setQty(new BigDecimal("2"));
			shipLine.saveEx();
			new MInOutLineMA(shipLine, lotA.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			new MInOutLineMA(shipLine, lotB.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
			}
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), shipLine.get_ID(), getTrxName()).length,
					"Shipment must preserve both Lot A and Lot B MA allocations");

			// 1. Shipment must reject unvalued charge-bearing Lot B even though aggregate costs = 100.00
			String shipErr = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(),
					shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
			assertNotNull(shipErr, "Shipment must reject charge-bearing lot with missing valuation");
			assertTrue(shipErr.contains(Msg.getMsg(Env.getCtx(), "No Costs for")) && shipErr.contains(product.getName()),
					"Expected 'No Costs for' error, got: " + shipErr);

			// 2. Customer Return must also reject unvalued charge-bearing Lot B
			MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
			rma.setName("LotValGuard RMA");
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
			rmaLine.setQty(new BigDecimal("2"));
			rmaLine.saveEx();
			info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			MInOut custReturn = new MInOut(Env.getCtx(), 0, getTrxName());
			custReturn.setIsSOTrx(true);
			custReturn.setC_DocType_ID(DictionaryIDs.C_DocType.MM_CUSTOMER_RETURN.id);
			custReturn.setMovementType(MInOut.MOVEMENTTYPE_CustomerReturns);
			custReturn.setM_RMA_ID(rma.get_ID());
			custReturn.setC_BPartner_ID(shipment.getC_BPartner_ID());
			custReturn.setC_BPartner_Location_ID(shipment.getC_BPartner_Location_ID());
			custReturn.setM_Warehouse_ID(shipment.getM_Warehouse_ID());
			custReturn.setMovementDate(getLoginDate());
			custReturn.setDateAcct(getLoginDate());
			custReturn.setDocStatus(DocAction.STATUS_Drafted);
			custReturn.setDocAction(DocAction.ACTION_Complete);
			custReturn.saveEx();
			MInOutLine retLine = new MInOutLine(custReturn);
			retLine.setM_RMALine_ID(rmaLine.get_ID());
			retLine.setM_Product_ID(product.get_ID());
			retLine.setM_Locator_ID(shipLine.getM_Locator_ID());
			retLine.setQty(new BigDecimal("2"));
			retLine.saveEx();
			new MInOutLineMA(retLine, lotA.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			new MInOutLineMA(retLine, lotB.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(custReturn, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				custReturn.load(getTrxName());
				if (!DocAction.STATUS_Completed.equals(custReturn.getDocStatus()))
				{
					for (MInOutConfirm confirm : custReturn.getConfirmations(true))
					{
						if (!DocAction.STATUS_Completed.equals(confirm.getDocStatus()))
						{
							info = MWorkflow.runDocumentActionWorkflow(confirm, DocAction.ACTION_Complete);
							assertFalse(info.isError(), info.getSummary());
						}
					}
					custReturn.load(getTrxName());
					if (!DocAction.STATUS_Completed.equals(custReturn.getDocStatus()))
					{
						info = MWorkflow.runDocumentActionWorkflow(custReturn, DocAction.ACTION_Complete);
						assertFalse(info.isError(), info.getSummary());
						custReturn.load(getTrxName());
					}
				}
			}
			assertEquals(DocAction.STATUS_Completed, custReturn.getDocStatus());
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), retLine.get_ID(), getTrxName()).length,
					"Customer return must preserve both Lot A and Lot B MA allocations");
			String retErr = DocumentEngine.postImmediate(Env.getCtx(), custReturn.getAD_Client_ID(),
					custReturn.get_Table_ID(), custReturn.get_ID(), false, getTrxName());
			assertNotNull(retErr, "Customer return must reject charge-bearing lot with missing valuation");
			assertTrue(retErr.contains(Msg.getMsg(Env.getCtx(), "No Costs for")) && retErr.contains(product.getName()),
					"Expected 'No Costs for' error on return, got: " + retErr);

			// 3. Give Lot B a KNOWN zero base cost (material=100, unmapped adj=-100) -> both Shipment and Return must post
			createPOAndMR(product, lotB, new BigDecimal("2"), new BigDecimal("100.00"));
			MCostElement unmappedAdj = createManualCostElement("LotValGuard Unmapped -100",
					MCostElement.COSTELEMENTTYPE_Overhead, 0);
			createManualCostRecord(product, as, unmappedAdj, lotB.get_ID(), new BigDecimal("-100.00"), 0);

			shipErr = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(),
					shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
			assertNull(shipErr, "Shipment with known zero base lot must post: " + shipErr);
			retErr = DocumentEngine.postImmediate(Env.getCtx(), custReturn.getAD_Client_ID(),
					custReturn.get_Table_ID(), custReturn.get_ID(), false, getTrxName());
			assertNull(retErr, "Customer return with known zero base lot must post: " + retErr);

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int cogsAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()), cogsAcctId, new BigDecimal("110.00"), BigDecimal.ZERO);
			assertFactTotals(getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()), assetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID()), freightAcctId, BigDecimal.ZERO, new BigDecimal("10.00"));
			assertFactTotals(getFacts(MInOut.Table_ID, custReturn.get_ID(), as.get_ID()), assetAcctId, new BigDecimal("100.00"), BigDecimal.ZERO);
			assertFactTotals(getFacts(MInOut.Table_ID, custReturn.get_ID(), as.get_ID()), cogsAcctId, BigDecimal.ZERO, new BigDecimal("110.00"));
			assertFactTotals(getFacts(MInOut.Table_ID, custReturn.get_ID(), as.get_ID()), freightAcctId, new BigDecimal("10.00"), BigDecimal.ZERO);
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotReversalFallbackCostDetailSignAndPartialMissingLotAllocation()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			batchCat.setName("LotRevAllocBatchCat");
			batchCat.saveEx();
			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(batchCat.get_ID()))).thenReturn(batchCat);
			mockedCategory.when(() -> MProductCategory.get(eq(batchCat.get_ID()))).thenReturn(batchCat);

			MProductCategoryAcct batchAcct = MProductCategoryAcct.get(batchCat.get_ID(), as.get_ID(), getTrxName());
			batchAcct = new MProductCategoryAcct(Env.getCtx(), batchAcct, getTrxName());
			batchAcct.setCostingLevel(MAcctSchema.COSTINGLEVEL_BatchLot);
			batchAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(batchCat.get_ID(), as.get_ID(), getTrxName());

			MAttributeSet lotAs = new MAttributeSet(Env.getCtx(), 0, getTrxName());
			lotAs.setName("LotRevAllocAS");
			lotAs.setIsLot(true);
			lotAs.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			lotAs.saveEx();
			MAttributeSet lotAsSpy = Mockito.spy(lotAs);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MOrderLine.Table_ID, true);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MInOutLine.Table_ID, true);
			mockedAttrSet.when(() -> MAttributeSet.getCopy(any(Properties.class), eq(lotAs.get_ID()), any())).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(any(Properties.class), eq(lotAs.get_ID()))).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(eq(lotAs.get_ID()))).thenReturn(lotAsSpy);

			MProduct product = createStockedProduct("LotRevAllocProd", batchCat.get_ID(), lotAs.get_ID());
			mockProductGet(mockedProduct, product);

			MAttributeSetInstance lot1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lot1.setM_AttributeSet_ID(lotAs.get_ID());
			lot1.setLot("LOT-REV-90");
			lot1.setDescription();
			lot1.saveEx();

			MAttributeSetInstance lot2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lot2.setM_AttributeSet_ID(lotAs.get_ID());
			lot2.setLot("LOT-REV-10");
			lot2.setDescription();
			lot2.saveEx();

			createPOAndMR(product, lot1, new BigDecimal("5"), new BigDecimal("90.00"));
			createPOAndMR(product, lot2, new BigDecimal("5"), new BigDecimal("10.00"));

			// Helper order for 4 units across two 2-unit shipments
			MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
			so.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			so.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			so.setIsSOTrx(true);
			so.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			so.setDocStatus(DocAction.STATUS_Drafted);
			so.setDocAction(DocAction.ACTION_Complete);
			so.setDateOrdered(getLoginDate());
			so.setDateAcct(getLoginDate());
			so.setDatePromised(getLoginDate());
			so.saveEx();
			MOrderLine soLine = new MOrderLine(so);
			soLine.setLine(10);
			soLine.setProduct(product);
			soLine.setQty(new BigDecimal("4"));
			soLine.setDatePromised(getLoginDate());
			soLine.setPrice(new BigDecimal("150.00"));
			soLine.saveEx();
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(so, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			// Scenario 1: Shipment reversal where BOTH original lot M_CostDetail records are missing -> each lot must get +50.00 (positive!)
			MInOut ship1 = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, getLoginDate());
			ship1.setDocStatus(DocAction.STATUS_Drafted);
			ship1.setDocAction(DocAction.ACTION_Complete);
			ship1.saveEx();
			MInOutLine shipLine1 = new MInOutLine(ship1);
			shipLine1.setOrderLine(soLine, 0, new BigDecimal("2"));
			shipLine1.setQty(new BigDecimal("2"));
			shipLine1.saveEx();
			new MInOutLineMA(shipLine1, lot1.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			new MInOutLineMA(shipLine1, lot2.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			info = MWorkflow.runDocumentActionWorkflow(ship1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), shipLine1.get_ID(), getTrxName()).length);
			ship1.load(getTrxName());
			if (!ship1.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), ship1.getAD_Client_ID(), ship1.get_Table_ID(), ship1.get_ID(), false, getTrxName()));

			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE M_InOutLine_ID=?", new Object[] { shipLine1.get_ID() }, getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(ship1, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			ship1.load(getTrxName());
			MInOut revShip1 = new MInOut(Env.getCtx(), ship1.getReversal_ID(), getTrxName());
			if (!revShip1.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), revShip1.getAD_Client_ID(), revShip1.get_Table_ID(), revShip1.get_ID(), false, getTrxName()));

			MInOutLine revShipLine1 = revShip1.getLines(true)[0];
			MCostDetail revCd1A = MCostDetail.getShipment(as, product.get_ID(), lot1.get_ID(), revShipLine1.get_ID(), 0, getTrxName());
			MCostDetail revCd1B = MCostDetail.getShipment(as, product.get_ID(), lot2.get_ID(), revShipLine1.get_ID(), 0, getTrxName());
			assertNotNull(revCd1A);
			assertNotNull(revCd1B);
			assertEquals(new BigDecimal("50.00"), revCd1A.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Shipment reversal lot fallback must preserve positive +50.00 sign, not -50.00");
			assertEquals(new BigDecimal("50.00"), revCd1B.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Shipment reversal lot fallback must preserve positive +50.00 sign, not -50.00");

			// Scenario 2: Shipment + Customer Return reversal where ONLY lot4's original M_CostDetail is missing
			// Use dedicated lots so Scenario 1's +50/+50 fallback does not alter lot AveragePO costs.
			// Lot3=90 found, Lot4 missing -> Lot4 must receive ONLY remaining 10 (total +100 / -100, NOT +140 / -140)
			MAttributeSetInstance lot3 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lot3.setM_AttributeSet_ID(lotAs.get_ID());
			lot3.setLot("LOT-REV2-90");
			lot3.setDescription();
			lot3.saveEx();

			MAttributeSetInstance lot4 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lot4.setM_AttributeSet_ID(lotAs.get_ID());
			lot4.setLot("LOT-REV2-10");
			lot4.setDescription();
			lot4.saveEx();

			createPOAndMR(product, lot3, new BigDecimal("5"), new BigDecimal("90.00"));
			createPOAndMR(product, lot4, new BigDecimal("5"), new BigDecimal("10.00"));

			MInOut ship2 = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, getLoginDate());
			ship2.setDocStatus(DocAction.STATUS_Drafted);
			ship2.setDocAction(DocAction.ACTION_Complete);
			ship2.saveEx();
			MInOutLine shipLine2 = new MInOutLine(ship2);
			shipLine2.setOrderLine(soLine, 0, new BigDecimal("2"));
			shipLine2.setQty(new BigDecimal("2"));
			shipLine2.saveEx();
			new MInOutLineMA(shipLine2, lot3.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			new MInOutLineMA(shipLine2, lot4.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			info = MWorkflow.runDocumentActionWorkflow(ship2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), shipLine2.get_ID(), getTrxName()).length);
			ship2.load(getTrxName());
			if (!ship2.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), ship2.getAD_Client_ID(), ship2.get_Table_ID(), ship2.get_ID(), false, getTrxName()));

			// Customer return of ship2 (lot3=90 + lot4=10 = 100)
			MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
			rma.setName("LotRevAlloc RMA");
			rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
			rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
			rma.setM_InOut_ID(ship2.get_ID());
			rma.setIsSOTrx(true);
			rma.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			rma.saveEx();
			MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
			rmaLine.setLine(10);
			rmaLine.setM_RMA_ID(rma.get_ID());
			rmaLine.setM_InOutLine_ID(shipLine2.get_ID());
			rmaLine.setQty(new BigDecimal("2"));
			rmaLine.saveEx();
			info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			MInOut ret = new MInOut(Env.getCtx(), 0, getTrxName());
			ret.setIsSOTrx(true);
			ret.setC_DocType_ID(DictionaryIDs.C_DocType.MM_CUSTOMER_RETURN.id);
			ret.setMovementType(MInOut.MOVEMENTTYPE_CustomerReturns);
			ret.setM_RMA_ID(rma.get_ID());
			ret.setC_BPartner_ID(ship2.getC_BPartner_ID());
			ret.setC_BPartner_Location_ID(ship2.getC_BPartner_Location_ID());
			ret.setM_Warehouse_ID(ship2.getM_Warehouse_ID());
			ret.setMovementDate(getLoginDate());
			ret.setDateAcct(getLoginDate());
			ret.setDocStatus(DocAction.STATUS_Drafted);
			ret.setDocAction(DocAction.ACTION_Complete);
			ret.saveEx();
			MInOutLine retLine = new MInOutLine(ret);
			retLine.setM_RMALine_ID(rmaLine.get_ID());
			retLine.setM_Product_ID(product.get_ID());
			retLine.setM_Locator_ID(shipLine2.getM_Locator_ID());
			retLine.setQty(new BigDecimal("2"));
			retLine.saveEx();
			new MInOutLineMA(retLine, lot3.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			new MInOutLineMA(retLine, lot4.get_ID(), BigDecimal.ONE, getLoginDate(), false).saveEx();
			info = MWorkflow.runDocumentActionWorkflow(ret, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			ret.load(getTrxName());
			if (!DocAction.STATUS_Completed.equals(ret.getDocStatus()))
			{
				for (MInOutConfirm confirm : ret.getConfirmations(true))
				{
					if (!DocAction.STATUS_Completed.equals(confirm.getDocStatus()))
					{
						info = MWorkflow.runDocumentActionWorkflow(confirm, DocAction.ACTION_Complete);
						assertFalse(info.isError(), info.getSummary());
					}
				}
				ret.load(getTrxName());
				if (!DocAction.STATUS_Completed.equals(ret.getDocStatus()))
				{
					info = MWorkflow.runDocumentActionWorkflow(ret, DocAction.ACTION_Complete);
					assertFalse(info.isError(), info.getSummary());
					ret.load(getTrxName());
				}
			}
			assertEquals(DocAction.STATUS_Completed, ret.getDocStatus());
			assertEquals(2, MInOutLineMA.get(Env.getCtx(), retLine.get_ID(), getTrxName()).length);
			if (!ret.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), ret.getAD_Client_ID(), ret.get_Table_ID(), ret.get_ID(), false, getTrxName()));

			// Delete ONLY lot4's original M_CostDetail on Customer Return, then reverse
			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE M_InOutLine_ID=? AND M_AttributeSetInstance_ID=?",
					new Object[] { retLine.get_ID(), lot4.get_ID() }, getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(ret, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			ret.load(getTrxName());
			MInOut revRet = new MInOut(Env.getCtx(), ret.getReversal_ID(), getTrxName());
			if (!revRet.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), revRet.getAD_Client_ID(), revRet.get_Table_ID(), revRet.get_ID(), false, getTrxName()));

			MInOutLine revRetLine = revRet.getLines(true)[0];
			MCostDetail revRetCd1 = MCostDetail.getShipment(as, product.get_ID(), lot3.get_ID(), revRetLine.get_ID(), 0, getTrxName());
			MCostDetail revRetCd2 = MCostDetail.getShipment(as, product.get_ID(), lot4.get_ID(), revRetLine.get_ID(), 0, getTrxName());
			assertNotNull(revRetCd1);
			assertNotNull(revRetCd2);
			assertEquals(new BigDecimal("-90.00"), revRetCd1.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-10.00"), revRetCd2.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Missing lot fallback on return reversal must allocate only remaining -10.00, not -50.00");

			// Delete ONLY lot4's original M_CostDetail on ship2, then reverse
			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE M_InOutLine_ID=? AND M_AttributeSetInstance_ID=?",
					new Object[] { shipLine2.get_ID(), lot4.get_ID() }, getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(ship2, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			ship2.load(getTrxName());
			MInOut revShip2 = new MInOut(Env.getCtx(), ship2.getReversal_ID(), getTrxName());
			if (!revShip2.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), revShip2.getAD_Client_ID(), revShip2.get_Table_ID(), revShip2.get_ID(), false, getTrxName()));

			MInOutLine revShipLine2 = revShip2.getLines(true)[0];
			MCostDetail revShipCd1 = MCostDetail.getShipment(as, product.get_ID(), lot3.get_ID(), revShipLine2.get_ID(), 0, getTrxName());
			MCostDetail revShipCd2 = MCostDetail.getShipment(as, product.get_ID(), lot4.get_ID(), revShipLine2.get_ID(), 0, getTrxName());
			assertNotNull(revShipCd1);
			assertNotNull(revShipCd2);
			assertEquals(new BigDecimal("90.00"), revShipCd1.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("10.00"), revShipCd2.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Missing lot fallback on shipment reversal must allocate only remaining +10.00, not +50.00");
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
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

			// Create & post a zero-cost PO + Material Receipt in this uncommitted test transaction
			createPOAndMR(freeProd, null, new BigDecimal("5"), BigDecimal.ZERO);

			// Shipment in the same uncommitted transaction must see the zero-cost purchase M_CostDetail via getTrxName()
			MInOut shipment = createSOAndShipment(freeProd, null, BigDecimal.ONE, BigDecimal.ZERO);
			assertTrue(shipment.isPosted(), "Shipment of item with uncommitted zero-cost purchase detail must post");
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
			List<MFactAcct> origFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(3, origFacts.size(), "Expected COGS, Asset, and Charge facts");

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

			// Day 3: Shipment qty 2 (AvgPO 100 -> inv 200, 10% burden 20, COGS 220) + Reverse_Correct on Day 3
			MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
			so.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			so.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			so.setIsSOTrx(true);
			so.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			so.setDocStatus(DocAction.STATUS_Drafted);
			so.setDocAction(DocAction.ACTION_Complete);
			so.setDateOrdered(day3);
			so.setDateAcct(day3);
			so.setDatePromised(day3);
			so.saveEx();
			MOrderLine soLine = new MOrderLine(so);
			soLine.setLine(10);
			soLine.setProduct(product);
			soLine.setQty(new BigDecimal("2"));
			soLine.setDatePromised(day3);
			soLine.setPrice(new BigDecimal("180.00"));
			soLine.saveEx();
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(so, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			MInOut shipment = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, day3);
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			MInOutLine shipLine = new MInOutLine(shipment);
			shipLine.setOrderLine(soLine, 0, new BigDecimal("2"));
			shipLine.setQty(new BigDecimal("2"));
			shipLine.saveEx();
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			if (!shipment.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(),
						shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName()));

			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName()));

			List<MManualCostDetail> shipMcdsBefore = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, shipment.get_ID(), getTrxName());
			List<MManualCostDetail> revMcdsBefore = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, reversal.get_ID(), getTrxName());
			assertEquals(1, shipMcdsBefore.size());
			assertEquals(1, revMcdsBefore.size());
			assertEquals(new BigDecimal("20.00"), shipMcdsBefore.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-20.00"), revMcdsBefore.get(0).getAmt().setScale(2, RoundingMode.HALF_UP));

			// Day 2 (Backdated BEFORE Day 3): Receipt qty 10 @ 200.00 -> new AvgPO = (1000 + 2000)/20 = 150.00!
			// Backdate reposting must update Day 3 Shipment (inv 300, burden 30, COGS 330) AND Day 3 Reversal (inv 300, burden 30, COGS 330)
			createPOAndMR(product, null, new BigDecimal("10"), new BigDecimal("200.00"), day2);

			List<MManualCostDetail> shipMcdsAfter = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, shipment.get_ID(), getTrxName());
			List<MManualCostDetail> revMcdsAfter = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MInOut.Table_ID, reversal.get_ID(), getTrxName());
			assertEquals(1, shipMcdsAfter.size(), "Backdated repost must replace shipment M_ManualCostDetail cleanly");
			assertEquals(1, revMcdsAfter.size(), "Backdated repost must replace reversal M_ManualCostDetail cleanly");
			assertEquals(new BigDecimal("30.00"), shipMcdsAfter.get(0).getAmt().setScale(2, RoundingMode.HALF_UP),
					"Backdated shipment manual cost must update from 20.00 to 30.00 (10% of 300.00)");
			assertEquals(new BigDecimal("-30.00"), revMcdsAfter.get(0).getAmt().setScale(2, RoundingMode.HALF_UP),
					"Backdated reversal manual cost must update from -20.00 to -30.00");

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
}
