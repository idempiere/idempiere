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
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MCost;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MDiscountSchema;
import org.compiere.model.MDiscountSchemaLine;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutConfirm;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.X_C_Charge_Acct;
import org.compiere.model.X_C_SubAcct;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.M_PriceList_Create;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.acct.doc.Doc;
import org.idempiere.acct.doc.DocLine;
import org.idempiere.acct.doc.DocManager;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for IDEMPIERE-7231: Charge-based posting for manual (non-material) Cost Elements.
 */
@Isolated
public class ManualCostElementTest extends AbstractTestCase
{
	private static final Timestamp FIXTURE_DATE = TimeUtil.getDay(2025, 6, 15);

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo)
	{
		return new LoginDetails(GARDEN_WORLD_CLIENT, GARDEN_WORLD_HQ_ORG, GARDEN_WORLD_ADMIN_USER,
				GARDEN_WORLD_ADMIN_ROLE, GARDEN_WORLD_HQ_WAREHOUSE, FIXTURE_DATE, Language.getLanguage("en_US"));
	}
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
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		MAcctSchema asCopy = MAcctSchema.getCopy(Env.getCtx(), as.getC_AcctSchema_ID(), null);
		boolean origAllowNegative = asCopy.isAllowNegativePosting();
		if (origAllowNegative)
		{
			asCopy.setIsAllowNegativePosting(false);
			asCopy.saveEx();
			CacheMgt.get().reset(MAcctSchema.Table_Name);
			CacheMgt.get().reset(MClientInfo.Table_Name);
			as = MClient.get(Env.getCtx()).getAcctSchema();
		}
		assertFalse(as.isAllowNegativePosting(), "AllowNegativePosting should be disabled for this test");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
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
		finally
		{
			if (origAllowNegative)
			{
				asCopy.setIsAllowNegativePosting(true);
				asCopy.saveEx();
				CacheMgt.get().reset(MAcctSchema.Table_Name);
				CacheMgt.get().reset(MClientInfo.Table_Name);
			}
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
	public void testProductionWithComponentManualCosts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct component = createStockedProduct("ManualCostComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct finished = createStockedProduct("ManualCostFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			finished.setIsBOM(true);
			finished.saveEx();

			mockProductGet(mockedProduct, component);
			mockProductGet(mockedProduct, finished);

			// Receive 5 units of component @ 100.00
			createPOAndMR(component, null, new BigDecimal("5"), new BigDecimal("100.00"));

			// Add 10% burden + fixed 5 overhead on component, both mapped to Freight charge
			MCostElement burdenCe = createManualCostElement("Prod Component Burden",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("Prod Component Overhead",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(component, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(component, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			// BOM: 1 Finished = 2 Component
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(finished.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(finished.getName());
			bom.saveEx();

			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(component.get_ID());
			bomLine.setQtyBOM(new BigDecimal("2"));
			bomLine.saveEx();

			finished.load(getTrxName());
			finished.setIsVerified(true);
			finished.saveEx();

			// Create & run production for qty 1
			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(finished.get_ID());
			production.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			production.setIsUseProductionPlan(false);
			production.setMovementDate(getLoginDate());
			production.setDocAction(DocAction.ACTION_Complete);
			production.setDocStatus(DocAction.STATUS_Drafted);
			production.setIsComplete(false);
			production.setProductionQty(BigDecimal.ONE);
			production.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production.saveEx();

			MProcess process = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.CREATE_UPDATE_PRODUCTION_LINES.id);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			production.load(getTrxName());
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus());

			if (!production.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), production.getAD_Client_ID(),
						production.get_Table_ID(), production.get_ID(), false, getTrxName());
				assertNull(error, "Production posting failed: " + error);
			}

			// Verify Fact_Acct: DR Finished Asset 230, CR Component Asset 200, CR Freight Charge 20 + 10
			List<MFactAcct> facts = getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID());
			assertEquals(4, facts.size(), "Production should have 4 Fact_Acct lines (FG Asset, Comp Asset, 2 manual cost Charges)");

			ProductCost fgPc = new ProductCost(Env.getCtx(), finished.get_ID(), 0, getTrxName());
			int fgAssetAcctId = fgPc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			ProductCost compPc = new ProductCost(Env.getCtx(), component.get_ID(), 0, getTrxName());
			int compAssetAcctId = compPc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			BigDecimal fgDr = BigDecimal.ZERO;
			BigDecimal compCr = BigDecimal.ZERO;
			List<BigDecimal> chargeCredits = new ArrayList<>();
			for (MFactAcct fa : facts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Production manual cost line must record C_Charge_ID");
					chargeCredits.add(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP));
				}
				else if (fa.getM_Product_ID() == finished.get_ID())
				{
					assertEquals(fgAssetAcctId, fa.getAccount_ID(), "Finished goods Fact_Acct must post to Product Asset account");
					fgDr = fgDr.add(fa.getAmtAcctDr());
				}
				else if (fa.getM_Product_ID() == component.get_ID())
				{
					assertEquals(compAssetAcctId, fa.getAccount_ID(), "Component Fact_Acct must post to Product Asset account");
					compCr = compCr.add(fa.getAmtAcctCr());
				}
			}
			assertEquals(new BigDecimal("230.00"), fgDr.setScale(2, RoundingMode.HALF_UP), "Finished goods DR should include component manual costs");
			assertEquals(new BigDecimal("200.00"), compCr.setScale(2, RoundingMode.HALF_UP), "Component Asset CR should be material cost only");
			assertEquals(2, chargeCredits.size(), "Expected 2 separate Charge credit lines on production");
			assertTrue(chargeCredits.contains(new BigDecimal("20.00")), "Missing 20.00 burden credit line");
			assertTrue(chargeCredits.contains(new BigDecimal("10.00")), "Missing 10.00 overhead credit line");

			// Finished goods MCost should now be 230.00; Component MCostDetail should be -200.00
			BigDecimal fgCost = MCost.getCurrentCost(finished, 0, as, getAD_Org_ID(), as.getCostingMethod(),
					BigDecimal.ONE, 0, false, getTrxName());
			assertEquals(new BigDecimal("230.00"), fgCost.setScale(2, RoundingMode.HALF_UP),
					"Finished goods cost should roll up component material + manual cost");

			for (MProductionLine pl : production.getLines())
			{
				if (pl.getM_Product_ID() == component.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, component.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd, "Component MCostDetail not found");
					assertEquals(new BigDecimal("-200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP),
							"Component MCostDetail must remain negative material-only");
				}
			}

			// Mutate cost elements BEFORE reversing production (change Charge on one, deactivate the other)
			burdenCe.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			burdenCe.saveEx();
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			// Reverse-Correct production and post reversal
			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			assertTrue(production.getReversal_ID() > 0, "Production reversal not created");

			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Production reversal posting failed: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size(), "Production reversal should have 4 Fact_Acct lines matching original");
			BigDecimal fgCr = BigDecimal.ZERO;
			BigDecimal compDr = BigDecimal.ZERO;
			List<BigDecimal> revChargeDebits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Reversed production Charge line must retain original C_Charge_ID");
					revChargeDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				}
				else if (fa.getM_Product_ID() == finished.get_ID())
				{
					assertEquals(fgAssetAcctId, fa.getAccount_ID(), "Reversed finished goods Fact_Acct must post to Product Asset account");
					fgCr = fgCr.add(fa.getAmtAcctCr());
				}
				else if (fa.getM_Product_ID() == component.get_ID())
				{
					assertEquals(compAssetAcctId, fa.getAccount_ID(), "Reversed component Fact_Acct must post to Product Asset account");
					compDr = compDr.add(fa.getAmtAcctDr());
				}
			}
			assertEquals(new BigDecimal("230.00"), fgCr.setScale(2, RoundingMode.HALF_UP), "Reversed FG CR must match original DR 230.00");
			assertEquals(new BigDecimal("200.00"), compDr.setScale(2, RoundingMode.HALF_UP), "Reversed Component DR must match original CR 200.00");
			assertEquals(2, revChargeDebits.size(), "Expected 2 separate Charge debit lines on production reversal");
			assertTrue(revChargeDebits.contains(new BigDecimal("20.00")), "Missing 20.00 reversed burden debit line");
			assertTrue(revChargeDebits.contains(new BigDecimal("10.00")), "Missing 10.00 reversed overhead debit line");

			for (MProductionLine pl : reversal.getLines())
			{
				if (pl.getM_Product_ID() == finished.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, finished.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd, "Reversed FG MCostDetail not found");
					assertEquals(new BigDecimal("-230.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP),
							"Reversed FG MCostDetail must negate original rolled-up cost");
				}
				else if (pl.getM_Product_ID() == component.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, component.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd, "Reversed Component MCostDetail not found");
					assertEquals(new BigDecimal("200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP),
							"Reversed Component MCostDetail must remain material-only");
				}
			}
		}
	}

	@Test
	public void testProjectIssueWithManualCosts()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostProjProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("Project Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("Project Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("ManualCost Test Project");
			proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
			proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			proj.setPlannedAmt(Env.ONE);
			proj.setCommittedQty(Env.ONE);
			proj.saveEx();

			MProjectIssue issue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			issue.setLine(10);
			issue.setMovementDate(getLoginDate());
			issue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			issue.setMovementQty(new BigDecimal("2"));
			issue.setC_Project_ID(proj.get_ID());
			issue.setM_Product_ID(product.get_ID());
			issue.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, issue.getDocStatus());

			if (!issue.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), issue.getAD_Client_ID(),
						issue.get_Table_ID(), issue.get_ID(), false, getTrxName());
				assertNull(error, "ProjectIssue posting failed: " + error);
			}

			// ProjectBalanceAmt must match DR Project WIP (230.00)
			proj.load(getTrxName());
			assertEquals(new BigDecimal("230.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should include manual costs");

			List<MFactAcct> facts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			assertEquals(4, facts.size(), "ProjectIssue should create 4 Fact_Acct lines (WIP, Asset, 2 manual cost Charges)");

			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int wipAcctId = getProjectWipAccountId(proj, as);
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			assertFactTotals(facts, wipAcctId, new BigDecimal("230.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(facts, freightAcctId, BigDecimal.ZERO, new BigDecimal("30.00"));

			// MCostDetail must remain material-only (-200.00)
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", issue.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "ProjectIssue MCostDetail not found");
			assertEquals(new BigDecimal("-200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectIssue MCostDetail must record negative material cost only");

			// Mutate cost elements BEFORE reversing Project Issue
			burdenCe.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			burdenCe.saveEx();
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			// Reverse-Correct Project Issue and post reversal
			info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			assertTrue(issue.getReversal_ID() > 0, "ProjectIssue reversal not created");

			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "ProjectIssue reversal posting failed: " + error);
			}

			// ProjectBalanceAmt must return to 0.00 even after cost element mutations
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should return to zero after reversal");

			List<MFactAcct> revFacts = getFacts(MProjectIssue.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size(), "ProjectIssue reversal should have 4 Fact_Acct lines matching original");
			assertFactTotals(revFacts, wipAcctId, BigDecimal.ZERO, new BigDecimal("230.00"));
			assertFactTotals(revFacts, assetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("30.00"), BigDecimal.ZERO);

			List<BigDecimal> revChargeDebits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Reversed ProjectIssue Charge line must retain C_Charge_ID");
					revChargeDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				}
			}
			assertEquals(2, revChargeDebits.size(), "Expected 2 separate Charge debit lines on ProjectIssue reversal");
			assertTrue(revChargeDebits.contains(new BigDecimal("20.00")), "Missing 20.00 reversed burden debit line");
			assertTrue(revChargeDebits.contains(new BigDecimal("10.00")), "Missing 10.00 reversed overhead debit line");

			MCostDetail revCd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", reversal.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(revCd, "Reversed ProjectIssue MCostDetail not found");
			assertEquals(new BigDecimal("200.00"), revCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Reversed ProjectIssue MCostDetail must record material cost only");
		}
	}

	@Test
	public void testProjectIssueReversesCompletionBalanceAfterDeferredPostingCostChange()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostDeferredProjProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("Deferred Proj Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCostElement overheadCe = createManualCostElement("Deferred Proj Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("ManualCost Deferred Project");
			proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
			proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			proj.setPlannedAmt(Env.ONE);
			proj.setCommittedQty(Env.ONE);
			proj.saveEx();

			// 1. Complete first issue with deferred posting (200 material + 20 burden + 10 overhead = 230)
			MProjectIssue issue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			issue.setLine(10);
			issue.setMovementDate(getLoginDate());
			issue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			issue.setMovementQty(new BigDecimal("2"));
			issue.setC_Project_ID(proj.get_ID());
			issue.setM_Product_ID(product.get_ID());
			issue.saveEx();

			ProcessInfo info;
			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
			}
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, issue.getDocStatus());
			assertFalse(issue.isPosted(), "Deferred accounting should leave issue unposted at completion");
			assertEquals(new BigDecimal("230.00"), issue.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"CostAmt should persist completion-time balance contribution");

			proj.load(getTrxName());
			assertEquals(new BigDecimal("230.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			// Simulate deferred posting: deactivate overhead BETWEEN completion and posting
			overheadCe.setIsActive(false);
			overheadCe.saveEx();

			if (!issue.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), issue.getAD_Client_ID(),
						issue.get_Table_ID(), issue.get_ID(), false, getTrxName());
				assertNull(error, "ProjectIssue posting failed: " + error);
			}

			// Posted WIP DR is 220.00 (without deactivated overhead), while completion added 230.00
			List<MFactAcct> facts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			int wipAcctId = getProjectWipAccountId(proj, as);
			assertFactTotals(facts, wipAcctId, new BigDecimal("220.00"), BigDecimal.ZERO);

			// Reverse must subtract the 230.00 recorded at completion, returning ProjectBalanceAmt to 0.00
			info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-230.00"), reversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Reversal CostAmt should negate original CostAmt");

			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should return to zero even when manual cost changed between completion and posting");

			// 2. Verify backward compatibility when pre-migration CostAmt is NULL (falls back to Fact_Acct)
			MProjectIssue legacyIssue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			legacyIssue.setLine(20);
			legacyIssue.setMovementDate(getLoginDate());
			legacyIssue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			legacyIssue.setMovementQty(new BigDecimal("1"));
			legacyIssue.setC_Project_ID(proj.get_ID());
			legacyIssue.setM_Product_ID(product.get_ID());
			legacyIssue.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(legacyIssue, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			legacyIssue.load(getTrxName());
			if (!legacyIssue.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), legacyIssue.getAD_Client_ID(),
						legacyIssue.get_Table_ID(), legacyIssue.get_ID(), false, getTrxName());
				assertNull(error, "Legacy ProjectIssue posting failed: " + error);
			}
			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] {legacyIssue.get_ID()}, getTrxName());
			legacyIssue.load(getTrxName());
			assertNull(legacyIssue.get_Value(MProjectIssue.COLUMNNAME_CostAmt));

			info = MWorkflow.runDocumentActionWorkflow(legacyIssue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Pre-migration NULL CostAmt should fall back to Fact_Acct and return ProjectBalanceAmt to zero");
		}
	}

	@Test
	public void testProjectIssueReversalWithChangedAccountsAndSubCentCost()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ManualCostProjSubCentProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);

			// Sub-cent unit cost (100.0040) exceeds currency StdPrecision (2)
			createPOAndMR(product, null, new BigDecimal("3"), new BigDecimal("100.004"));

			MCostElement overheadCe = createManualCostElement("SubCent Proj Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("ManualCost SubCent Project");
			proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
			proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			proj.setPlannedAmt(Env.ONE);
			proj.setCommittedQty(Env.ONE);
			proj.saveEx();

			MProjectIssue issue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			issue.setLine(10);
			issue.setMovementDate(getLoginDate());
			issue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			issue.setMovementQty(BigDecimal.ONE);
			issue.setC_Project_ID(proj.get_ID());
			issue.setM_Product_ID(product.get_ID());
			issue.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			if (!issue.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), issue.getAD_Client_ID(),
						issue.get_Table_ID(), issue.get_ID(), false, getTrxName());
				assertNull(error, "ProjectIssue posting failed: " + error);
			}

			List<MFactAcct> origFacts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			assertEquals(3, origFacts.size(), "Original ProjectIssue should have 3 Fact_Acct lines (WIP, Asset, Charge)");
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int origWipAcctId = getProjectWipAccountId(proj, as);
			int origAssetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(origFacts, origWipAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);
			assertFactTotals(origFacts, origAssetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(origFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));

			MCostDetail origCd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", issue.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(origCd, "Original ProjectIssue MCostDetail not found");
			assertEquals(new BigDecimal("-100.0040"), origCd.getAmt().setScale(4, RoundingMode.HALF_UP),
					"Original ProjectIssue MCostDetail should preserve sub-cent costing precision");

			// Change BOTH project WIP account and product Asset account BEFORE reversing
			MAccount altAcct = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName());
			assertNotNull(altAcct);
			DB.executeUpdateEx("UPDATE C_Project_Acct SET PJ_WIP_Acct=? WHERE C_Project_ID=? AND C_AcctSchema_ID=?",
					new Object[] {altAcct.get_ID(), proj.get_ID(), as.get_ID()}, getTrxName());
			DB.executeUpdateEx("UPDATE M_Product_Acct SET P_Asset_Acct=? WHERE M_Product_ID=? AND C_AcctSchema_ID=?",
					new Object[] {altAcct.get_ID(), product.get_ID(), as.get_ID()}, getTrxName());
			CacheMgt.get().reset();

			info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			assertTrue(issue.getReversal_ID() > 0, "ProjectIssue reversal not created");

			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "ProjectIssue reversal posting failed after account change: " + error);
			}

			List<MFactAcct> revFacts = getFacts(MProjectIssue.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(3, revFacts.size(), "Reversal should have 3 Fact_Acct lines matching original");
			assertFactTotals(revFacts, origWipAcctId, BigDecimal.ZERO, new BigDecimal("105.00"));
			assertFactTotals(revFacts, origAssetAcctId, new BigDecimal("100.00"), BigDecimal.ZERO);
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("5.00"), BigDecimal.ZERO);

			// Reversal MCostDetail must cancel original unrounded amount (-100.0040 + 100.0040 = 0)
			MCostDetail revCd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", reversal.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(revCd, "Reversed ProjectIssue MCostDetail not found");
			assertEquals(origCd.getM_CostDetail_ID(), revCd.getRef_CostDetail_ID(),
					"Reversed ProjectIssue MCostDetail should reference original MCostDetail");
			assertEquals(new BigDecimal("100.0040"), revCd.getAmt().setScale(4, RoundingMode.HALF_UP),
					"Reversed ProjectIssue MCostDetail should offset original unrounded amount exactly");
			assertEquals(0, origCd.getAmt().add(revCd.getAmt()).compareTo(BigDecimal.ZERO),
					"Original and reversed MCostDetail amounts must net to zero");
		}
	}

	@Test
	public void testProjectIssueWithStandardCostingOverride()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory stdCategory = new MProductCategory(Env.getCtx(), 0, getTrxName());
			stdCategory.setName("ManualCostStdOverrideCat");
			stdCategory.saveEx();

			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(stdCategory.get_ID()))).thenReturn(stdCategory);
			mockedCategory.when(() -> MProductCategory.get(eq(stdCategory.get_ID()))).thenReturn(stdCategory);

			MProductCategoryAcct stdAcct = MProductCategoryAcct.get(stdCategory.get_ID(), as.get_ID(), getTrxName());
			stdAcct = new MProductCategoryAcct(Env.getCtx(), stdAcct, getTrxName());
			stdAcct.setCostingMethod(MCostElement.COSTINGMETHOD_StandardCosting);
			stdAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(stdCategory.get_ID(), as.get_ID(), getTrxName());

			MProduct product = createStockedProduct("ManualCostStdProjProd", stdCategory.get_ID(), 0);
			mockProductGet(mockedProduct, product);

			MCost.CostingKey key = MCost.CostingKey.resolve(getAD_Org_ID(), 0, product.getCostingLevel(as));
			MCostElement stdCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_StandardCosting);
			MCost stdCost = MCost.get(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), stdCe.getM_CostElement_ID(), getTrxName());
			stdCost.setCurrentCostPrice(new BigDecimal("80.00"));
			stdCost.saveEx();

			MCostElement avgPoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AveragePO);
			MCost avgPoCost = MCost.get(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgPoCe.getM_CostElement_ID(), getTrxName());
			avgPoCost.setCurrentCostPrice(new BigDecimal("100.00"));
			avgPoCost.saveEx();

			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement overheadCe = createManualCostElement("StdOverride Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			// Verify MCost.getManualCosts honors explicit costingMethod overload and product override
			assertEquals(0, MCost.getManualCosts(product, 0, as, getAD_Org_ID(), new BigDecimal("80.00"), BigDecimal.ONE, getTrxName()).length,
					"Default getManualCosts should exclude manual costs for Standard Costing product override");
			assertEquals(0, MCost.getManualCosts(product, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_StandardCosting,
					new BigDecimal("80.00"), BigDecimal.ONE, getTrxName()).length,
					"Explicit Standard Costing should exclude manual costs");
			ManualCost[] avgPoManualCosts = MCost.getManualCosts(product, 0, as, getAD_Org_ID(), MCostElement.COSTINGMETHOD_AveragePO,
					new BigDecimal("100.00"), BigDecimal.ONE, getTrxName());
			assertEquals(1, avgPoManualCosts.length, "Explicit Average PO costingMethod should include fixed manual cost");
			assertEquals(new BigDecimal("5.00"), avgPoManualCosts[0].getAmount().setScale(2, RoundingMode.HALF_UP));

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("ManualCost StdOverride Project");
			proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
			proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			proj.setPlannedAmt(Env.ONE);
			proj.setCommittedQty(Env.ONE);
			proj.saveEx();

			MProjectIssue issue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			issue.setLine(10);
			issue.setMovementDate(getLoginDate());
			issue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			issue.setMovementQty(new BigDecimal("2"));
			issue.setC_Project_ID(proj.get_ID());
			issue.setM_Product_ID(product.get_ID());
			issue.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, issue.getDocStatus());

			if (!issue.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), issue.getAD_Client_ID(),
						issue.get_Table_ID(), issue.get_ID(), false, getTrxName());
				assertNull(error, "ProjectIssue posting failed: " + error);
			}

			// ProjectBalanceAmt must match Standard Costing valuation (2 * 80.00 = 160.00, no manual costs)
			proj.load(getTrxName());
			assertEquals(new BigDecimal("160.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should use product's Standard Costing override and exclude manual costs");

			List<MFactAcct> facts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			assertEquals(2, facts.size(), "Standard Costing ProjectIssue should create 2 Fact_Acct lines (WIP, Asset) without manual cost Charge lines");
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int wipAcctId = getProjectWipAccountId(proj, as);
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			assertFactTotals(facts, wipAcctId, new BigDecimal("160.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("160.00"));

			// Reverse-Correct and verify ProjectBalanceAmt returns cleanly to 0.00
			info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			issue.load(getTrxName());
			assertTrue(issue.getReversal_ID() > 0, "ProjectIssue reversal not created");

			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "ProjectIssue reversal posting failed: " + error);
			}

			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should return to zero after reversing Standard Costing ProjectIssue");
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
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

	private MProduct createStockedProduct(String name, int categoryId, int attributeSetId)
	{
		MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setM_Product_Category_ID(categoryId);
		product.setName(name);
		product.setValue(name);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		if (attributeSetId > 0)
			product.setM_AttributeSet_ID(attributeSetId);
		product.saveEx();

		MPriceListVersion purchasePlv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(getLoginDate());
		MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
		pp.setM_PriceList_Version_ID(purchasePlv.get_ID());
		pp.setM_Product_ID(product.get_ID());
		pp.setPriceStd(new BigDecimal("100.00"));
		pp.setPriceList(new BigDecimal("100.00"));
		pp.saveEx();

		MPriceListVersion salesPlv = MPriceList.get(DictionaryIDs.M_PriceList.STANDARD.id).getPriceListVersion(getLoginDate());
		MProductPrice sp = new MProductPrice(Env.getCtx(), 0, getTrxName());
		sp.setM_PriceList_Version_ID(salesPlv.get_ID());
		sp.setM_Product_ID(product.get_ID());
		sp.setPriceStd(new BigDecimal("150.00"));
		sp.setPriceList(new BigDecimal("150.00"));
		sp.saveEx();

		return product;
	}

	private MCostElement createManualCostElement(String name, String costElementType, int chargeId)
	{
		MCostElement ce = new MCostElement(Env.getCtx(), 0, getTrxName());
		ce.setName(name);
		ce.setCostElementType(costElementType);
		ce.setC_Charge_ID(chargeId);
		ce.saveEx();
		return ce;
	}

	private MCost createManualCostRecord(MProduct product, MAcctSchema as, MCostElement ce,
			int asiId, BigDecimal currentCostPrice, int percent)
	{
		MCost.CostingKey key = MCost.CostingKey.resolve(getAD_Org_ID(), asiId, product.getCostingLevel(as));
		MCost cost = new MCost(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), ce.getM_CostElement_ID());
		cost.setCurrentCostPrice(currentCostPrice);
		cost.setPercent(percent);
		cost.saveEx();
		return cost;
	}

	private MInOutLine createPOAndMR(MProduct product, MAttributeSetInstance asi, BigDecimal qty, BigDecimal price)
	{
		return createPOAndMR(product, asi, qty, price, getLoginDate());
	}

	private MInOutLine createPOAndMR(MProduct product, MAttributeSetInstance asi, BigDecimal qty, BigDecimal price,
			Timestamp movementDate)
	{
		Timestamp date = movementDate != null ? TimeUtil.getDay(movementDate) : getLoginDate();

		MOrder po = new MOrder(Env.getCtx(), 0, getTrxName());
		po.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		po.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		po.setIsSOTrx(false);
		po.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		po.setDocStatus(DocAction.STATUS_Drafted);
		po.setDocAction(DocAction.ACTION_Complete);
		po.setDateOrdered(date);
		po.setDatePromised(date);
		po.saveEx();

		MOrderLine poLine = new MOrderLine(po);
		poLine.setLine(10);
		poLine.setProduct(product);
		poLine.setQty(qty);
		poLine.setDatePromised(date);
		poLine.setPrice(price);
		if (asi != null)
			poLine.setM_AttributeSetInstance_ID(asi.get_ID());
		poLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		po.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, po.getDocStatus());

		MInOut receipt = new MInOut(po, DictionaryIDs.C_DocType.MM_RECEIPT.id, date);
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(poLine, 0, qty);
		receiptLine.setQty(qty);
		if (asi != null)
			receiptLine.setM_AttributeSetInstance_ID(asi.get_ID());
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());

		if (!receipt.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(),
					receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
			assertNull(error, "Receipt posting failed: " + error);
		}
		return receiptLine;
	}

	private MInOut createSOAndShipment(MProduct product, MAttributeSetInstance asi, BigDecimal qty, BigDecimal price)
	{
		Timestamp date = getLoginDate();

		MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
		so.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		so.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		so.setIsSOTrx(true);
		so.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		so.setDocStatus(DocAction.STATUS_Drafted);
		so.setDocAction(DocAction.ACTION_Complete);
		so.setDateOrdered(date);
		so.setDatePromised(date);
		so.saveEx();

		MOrderLine soLine = new MOrderLine(so);
		soLine.setLine(10);
		soLine.setProduct(product);
		soLine.setQty(qty);
		soLine.setDatePromised(date);
		soLine.setPrice(price);
		if (asi != null)
			soLine.setM_AttributeSetInstance_ID(asi.get_ID());
		soLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(so, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		so.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, so.getDocStatus());

		MInOut shipment = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, so.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();

		MInOutLine shipLine = new MInOutLine(shipment);
		shipLine.setOrderLine(soLine, 0, qty);
		shipLine.setQty(qty);
		if (asi != null)
			shipLine.setM_AttributeSetInstance_ID(asi.get_ID());
		shipLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());

		if (!shipment.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(),
					shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
			assertNull(error, "Shipment posting failed: " + error);
		}
		return shipment;
	}

	private MInOut createCustomerReturn(MInOut shipment, MInOutLine shipLine, BigDecimal qty)
	{
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setName("ManualCost RMA " + shipment.getDocumentNo());
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
		rmaLine.setQty(qty);
		rmaLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		rma.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());

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

		MInOutLine returnLine = new MInOutLine(customerReturn);
		returnLine.setM_RMALine_ID(rmaLine.get_ID());
		returnLine.setLine(10);
		returnLine.setProduct(MProduct.get(Env.getCtx(), shipLine.getM_Product_ID()));
		returnLine.setM_Locator_ID(shipLine.getM_Locator_ID());
		returnLine.setQty(qty);
		if (shipLine.getM_AttributeSetInstance_ID() > 0)
			returnLine.setM_AttributeSetInstance_ID(shipLine.getM_AttributeSetInstance_ID());
		returnLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(customerReturn, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		customerReturn.load(getTrxName());

		// Complete any generated receipt confirmation so the customer return completes
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
				customerReturn.load(getTrxName());
			}
		}
		assertEquals(DocAction.STATUS_Completed, customerReturn.getDocStatus());

		if (!customerReturn.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), customerReturn.getAD_Client_ID(),
					customerReturn.get_Table_ID(), customerReturn.get_ID(), false, getTrxName());
			assertNull(error, "Customer Return posting failed: " + error);
		}
		return customerReturn;
	}

	private int getProjectWipAccountId(MProject project, MAcctSchema as)
	{
		int vcId = DB.getSQLValueEx(getTrxName(),
				"SELECT PJ_WIP_Acct FROM C_Project_Acct WHERE C_Project_ID=? AND C_AcctSchema_ID=?",
				project.get_ID(), as.get_ID());
		assertTrue(vcId > 0, "PJ_WIP_Acct not found for project " + project.get_ID());
		MAccount acct = MAccount.get(Env.getCtx(), vcId);
		assertNotNull(acct, "MAccount not found for PJ_WIP_Acct=" + vcId);
		return acct.getAccount_ID();
	}

	private List<MFactAcct> getFacts(int tableId, int recordId, int acctSchemaId)
	{
		return MFactAcct.createRecordIdQuery(tableId, recordId, acctSchemaId, getTrxName())
				.setOrderBy(MFactAcct.COLUMNNAME_Fact_Acct_ID)
				.list();
	}

	private void assertFactTotals(List<MFactAcct> facts, int accountId, BigDecimal expectedDr, BigDecimal expectedCr)
	{
		BigDecimal actualDr = BigDecimal.ZERO;
		BigDecimal actualCr = BigDecimal.ZERO;
		for (MFactAcct fa : facts)
		{
			if (fa.getAccount_ID() == accountId)
			{
				actualDr = actualDr.add(fa.getAmtAcctDr());
				actualCr = actualCr.add(fa.getAmtAcctCr());
			}
		}
		assertEquals(expectedDr.setScale(2, RoundingMode.HALF_UP), actualDr.setScale(2, RoundingMode.HALF_UP),
				"Unexpected DR total for Account_ID=" + accountId);
		assertEquals(expectedCr.setScale(2, RoundingMode.HALF_UP), actualCr.setScale(2, RoundingMode.HALF_UP),
				"Unexpected CR total for Account_ID=" + accountId);
	}

	private void mockProductGet(MockedStatic<MProduct> productMock, MProduct product)
	{
		productMock.when(() -> MProduct.getCopy(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()))).thenReturn(product);
		productMock.when(() -> MProduct.get(eq(product.get_ID()))).thenReturn(product);
	}
}
