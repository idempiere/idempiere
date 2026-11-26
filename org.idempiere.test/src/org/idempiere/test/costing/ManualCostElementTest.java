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
import static org.junit.jupiter.api.Assertions.assertThrows;
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

import org.adempiere.exceptions.DBException;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MCostQueue;
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
import org.compiere.model.MSalesRegion;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MTimeExpense;
import org.compiere.model.MTimeExpenseLine;
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
import org.idempiere.acct.base.model.MDistribution;
import org.idempiere.acct.base.model.MDistributionLine;
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

			// 2a. Verify backward compatibility when pre-migration CostAmt is NULL with pre-migration unmapped burden
			burdenCe.setIsActive(false);
			burdenCe.saveEx();
			MCostElement unmappedBurdenCe = createManualCostElement("ProjUnmappedBurden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, 0);
			MCost unmappedBurdenCost = createManualCostRecord(product, as, unmappedBurdenCe, 0, BigDecimal.ZERO, 10);

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

			// Posted WIP DR is 110.00 (100 material + 10 unmapped burden); project balance is 110.00
			List<MFactAcct> legacyFacts = getFacts(MProjectIssue.Table_ID, legacyIssue.get_ID(), as.get_ID());
			assertFactTotals(legacyFacts, wipAcctId, new BigDecimal("110.00"), BigDecimal.ZERO);
			proj.load(getTrxName());
			assertEquals(new BigDecimal("110.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Legacy ProjectIssue should add 110.00 to ProjectBalanceAmt");

			// Clear CostAmt (simulate pre-migration record) and deactivate unmapped burden so current cost (100.00) differs from posted cost (110.00)
			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] {legacyIssue.get_ID()}, getTrxName());
			legacyIssue.load(getTrxName());
			assertNull(legacyIssue.get_Value(MProjectIssue.COLUMNNAME_CostAmt));
			unmappedBurdenCost.setPercent(0);
			unmappedBurdenCost.saveEx();
			unmappedBurdenCe.setIsActive(false);
			unmappedBurdenCe.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(legacyIssue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			legacyIssue.load(getTrxName());
			MProjectIssue legacyReversal = new MProjectIssue(Env.getCtx(), legacyIssue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-110.00"), legacyReversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Legacy reversal should resolve original cost detail (-110.00), not current cost (-100.00)");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Pre-migration NULL CostAmt should return ProjectBalanceAmt to zero");

			// 2b. Pre-migration NULL CostAmt completed before any charge existed, then charge configured before first posting:
			// reversal must subtract only the 100.00 completion contribution, NOT the 20.00 charge added before first posting.
			MProduct lateChargeProd = createStockedProduct("ManualCostLateChgProjProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, lateChargeProd);
			createPOAndMR(lateChargeProd, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MProjectIssue legacyDeferredIssue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			legacyDeferredIssue.setLine(30);
			legacyDeferredIssue.setMovementDate(getLoginDate());
			legacyDeferredIssue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			legacyDeferredIssue.setMovementQty(new BigDecimal("1"));
			legacyDeferredIssue.setC_Project_ID(proj.get_ID());
			legacyDeferredIssue.setM_Product_ID(lateChargeProd.get_ID());
			legacyDeferredIssue.saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(legacyDeferredIssue, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
			}
			legacyDeferredIssue.load(getTrxName());
			assertFalse(legacyDeferredIssue.isPosted());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("100.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			// Simulate pre-migration row (CostAmt=NULL), then configure a 20.00 manual charge before first posting
			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] {legacyDeferredIssue.get_ID()}, getTrxName());
			legacyDeferredIssue.load(getTrxName());
			MCostElement lateChargeCe = createManualCostElement("ProjLateCharge 20",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(lateChargeProd, as, lateChargeCe, 0, new BigDecimal("20.00"), 0);

			String postErr = DocumentEngine.postImmediate(Env.getCtx(), legacyDeferredIssue.getAD_Client_ID(),
					legacyDeferredIssue.get_Table_ID(), legacyDeferredIssue.get_ID(), false, getTrxName());
			assertNull(postErr, "Late-charge legacy ProjectIssue posting failed: " + postErr);
			List<MFactAcct> lateFacts = getFacts(MProjectIssue.Table_ID, legacyDeferredIssue.get_ID(), as.get_ID());
			assertFactTotals(lateFacts, wipAcctId, new BigDecimal("120.00"), BigDecimal.ZERO);

			info = MWorkflow.runDocumentActionWorkflow(legacyDeferredIssue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			legacyDeferredIssue.load(getTrxName());
			MProjectIssue lateReversal = new MProjectIssue(Env.getCtx(), legacyDeferredIssue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-100.00"), lateReversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Legacy reversal must not subtract a charge added after completion");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt must return to 0.00 rather than -20.00");
		}
	}

	@Test
	public void testProjectIssueLegacyReversalWithGLDistribution()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct stockedProduct = createStockedProduct("LegacyGLDistStockedProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, stockedProduct);
			createPOAndMR(stockedProduct, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MProduct serviceProduct = new MProduct(Env.getCtx(), 0, getTrxName());
			serviceProduct.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			serviceProduct.setName("LegacyGLDistServiceProd");
			serviceProduct.setValue("LegacyGLDistServiceProd");
			serviceProduct.setProductType(MProduct.PRODUCTTYPE_Service);
			serviceProduct.setIsStocked(false);
			serviceProduct.setIsSold(true);
			serviceProduct.setIsPurchased(true);
			serviceProduct.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			serviceProduct.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			serviceProduct.saveEx();
			mockProductGet(mockedProduct, serviceProduct);

			MCost.CostingKey svcKey = MCost.CostingKey.resolve(getAD_Org_ID(), 0, serviceProduct.getCostingLevel(as));
			MCostElement avgPoCe = MCostElement.getMaterialCostElement(as, as.getCostingMethod());
			MCost svcCost = MCost.get(serviceProduct, svcKey.M_AttributeSetInstance_ID(), as, svcKey.AD_Org_ID(),
					avgPoCe.getM_CostElement_ID(), getTrxName());
			svcCost.setCurrentCostPrice(new BigDecimal("100.00"));
			svcCost.saveEx();

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("Legacy GLDist Project");
			proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
			proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			proj.setPlannedAmt(Env.ONE);
			proj.setCommittedQty(Env.ONE);
			proj.saveEx();

			int wipAcctId = getProjectWipAccountId(proj, as);
			int altAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName()).getAccount_ID();

			// GL Distribution that deletes the original WIP debit (IsCreateReversal=N) and splits it 60/40
			MDistribution sameAcctDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			sameAcctDist.setName("Test Proj WIP SameAcct Split");
			sameAcctDist.setC_AcctSchema_ID(as.get_ID());
			sameAcctDist.setIsCreateReversal(false);
			sameAcctDist.setAnyAcct(false);
			sameAcctDist.setAccount_ID(wipAcctId);
			sameAcctDist.saveEx();

			MDistributionLine dl1 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			dl1.setGL_Distribution_ID(sameAcctDist.get_ID());
			dl1.setLine(10);
			dl1.setPercent(new BigDecimal("60"));
			dl1.saveEx();

			MDistributionLine dl2 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			dl2.setGL_Distribution_ID(sameAcctDist.get_ID());
			dl2.setLine(20);
			dl2.setPercent(new BigDecimal("40"));
			dl2.saveEx();

			sameAcctDist.load(getTrxName());
			sameAcctDist.getLines(true);
			assertTrue(sameAcctDist.isValid(), "GL Distribution should be valid");

			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { sameAcctDist });

			// 1. Stocked product legacy issue (CostAmt NULL) with GL distribution replacing WIP debit
			MProjectIssue stockedIssue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			stockedIssue.setLine(10);
			stockedIssue.setMovementDate(getLoginDate());
			stockedIssue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			stockedIssue.setMovementQty(BigDecimal.ONE);
			stockedIssue.setC_Project_ID(proj.get_ID());
			stockedIssue.setM_Product_ID(stockedProduct.get_ID());
			stockedIssue.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(stockedIssue, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			stockedIssue.load(getTrxName());
			if (!stockedIssue.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), stockedIssue.getAD_Client_ID(),
						stockedIssue.get_Table_ID(), stockedIssue.get_ID(), false, getTrxName());
				assertNull(error, "Stocked ProjectIssue posting failed: " + error);
			}

			// Verify GL distribution moved Inventory CR to be the first saved Fact_Acct line
			List<MFactAcct> stockedFacts = getFacts(MProjectIssue.Table_ID, stockedIssue.get_ID(), as.get_ID());
			assertEquals(3, stockedFacts.size(), "Expected 1 Inventory CR + 2 distributed WIP DR lines");
			assertEquals(new BigDecimal("100.00"), stockedFacts.get(0).getAmtAcctCr().setScale(2, RoundingMode.HALF_UP),
					"First saved fact should be the Inventory CR after GL distribution replaced WIP");
			assertEquals(new BigDecimal("0.00"), stockedFacts.get(0).getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));

			// Simulate legacy pre-migration issue by clearing CostAmt
			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { stockedIssue.get_ID() }, getTrxName());
			stockedIssue.load(getTrxName());
			assertNull(stockedIssue.get_Value(MProjectIssue.COLUMNNAME_CostAmt));

			proj.load(getTrxName());
			assertEquals(new BigDecimal("100.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			info = MWorkflow.runDocumentActionWorkflow(stockedIssue, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Stocked legacy reversal with GL distribution must clear ProjectBalanceAmt to zero");

			// 2. Non-stocked service legacy issue (no MCostDetail) with GL distribution replacing WIP (same account)
			MProjectIssue svcIssue1 = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			svcIssue1.setLine(20);
			svcIssue1.setMovementDate(getLoginDate());
			svcIssue1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			svcIssue1.setMovementQty(BigDecimal.ONE);
			svcIssue1.setC_Project_ID(proj.get_ID());
			svcIssue1.setM_Product_ID(serviceProduct.get_ID());
			svcIssue1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(svcIssue1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			svcIssue1.load(getTrxName());
			if (!svcIssue1.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), svcIssue1.getAD_Client_ID(),
						svcIssue1.get_Table_ID(), svcIssue1.get_ID(), false, getTrxName());
				assertNull(error, "Service ProjectIssue posting failed: " + error);
			}
			assertNull(MCostDetail.getProjectIssue(as, serviceProduct.get_ID(), 0, svcIssue1.get_ID(), 0, getTrxName()),
					"Service product should not create MCostDetail");

			List<MFactAcct> svcFacts1 = getFacts(MProjectIssue.Table_ID, svcIssue1.get_ID(), as.get_ID());
			assertEquals(3, svcFacts1.size(), "Expected 1 Expense CR + 2 distributed WIP DR lines");
			assertEquals(new BigDecimal("100.00"), svcFacts1.get(0).getAmtAcctCr().setScale(2, RoundingMode.HALF_UP),
					"First saved fact should be the Expense CR after GL distribution replaced WIP");

			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { svcIssue1.get_ID() }, getTrxName());
			svcIssue1.load(getTrxName());

			info = MWorkflow.runDocumentActionWorkflow(svcIssue1, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Service legacy reversal with same-account GL distribution must aggregate WIP facts and clear ProjectBalanceAmt");

			// 3. Non-stocked service legacy issue with GL distribution overwriting the WIP account
			MDistribution overwriteAcctDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			overwriteAcctDist.setName("Test Proj WIP OverwriteAcct Split");
			overwriteAcctDist.setC_AcctSchema_ID(as.get_ID());
			overwriteAcctDist.setIsCreateReversal(false);
			overwriteAcctDist.setAnyAcct(false);
			overwriteAcctDist.setAccount_ID(wipAcctId);
			overwriteAcctDist.saveEx();

			MDistributionLine odl1 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			odl1.setGL_Distribution_ID(overwriteAcctDist.get_ID());
			odl1.setLine(10);
			odl1.setPercent(new BigDecimal("60"));
			odl1.setOverwriteAcct(true);
			odl1.setAccount_ID(altAcctId);
			odl1.saveEx();

			MDistributionLine odl2 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			odl2.setGL_Distribution_ID(overwriteAcctDist.get_ID());
			odl2.setLine(20);
			odl2.setPercent(new BigDecimal("40"));
			odl2.setOverwriteAcct(true);
			odl2.setAccount_ID(altAcctId);
			odl2.saveEx();

			overwriteAcctDist.load(getTrxName());
			overwriteAcctDist.getLines(true);
			assertTrue(overwriteAcctDist.isValid(), "Overwrite-account GL Distribution should be valid");

			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { overwriteAcctDist });

			MProjectIssue svcIssue2 = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			svcIssue2.setLine(30);
			svcIssue2.setMovementDate(getLoginDate());
			svcIssue2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			svcIssue2.setMovementQty(BigDecimal.ONE);
			svcIssue2.setC_Project_ID(proj.get_ID());
			svcIssue2.setM_Product_ID(serviceProduct.get_ID());
			svcIssue2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(svcIssue2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			svcIssue2.load(getTrxName());
			if (!svcIssue2.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), svcIssue2.getAD_Client_ID(),
						svcIssue2.get_Table_ID(), svcIssue2.get_ID(), false, getTrxName());
				assertNull(error, "Service ProjectIssue (overwrite acct) posting failed: " + error);
			}

			List<MFactAcct> svcFacts2 = getFacts(MProjectIssue.Table_ID, svcIssue2.get_ID(), as.get_ID());
			assertEquals(3, svcFacts2.size(), "Expected 1 Expense CR + 2 overwritten-account DR lines");
			assertEquals(new BigDecimal("100.00"), svcFacts2.get(0).getAmtAcctCr().setScale(2, RoundingMode.HALF_UP));
			List<BigDecimal> altDebits = new ArrayList<>();
			for (MFactAcct fa : svcFacts2)
			{
				if (fa.getAccount_ID() == altAcctId && fa.getAmtAcctDr().signum() != 0)
					altDebits.add(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP));
				assertFalse(fa.getAccount_ID() == wipAcctId && fa.getAmtAcctDr().signum() != 0,
						"GL distribution must have moved debit off wipAcctId");
			}
			assertEquals(List.of(new BigDecimal("60.00"), new BigDecimal("40.00")), altDebits,
					"Expected two debit lines of 60.00 and 40.00 on altAcctId");

			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { svcIssue2.get_ID() }, getTrxName());
			svcIssue2.load(getTrxName());

			info = MWorkflow.runDocumentActionWorkflow(svcIssue2, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Service legacy reversal with overwrite-account GL distribution must clear ProjectBalanceAmt to zero");

			// 4. Partial WIP split (60% stays on WIP, 40% moves to altAcctId): must not return partial -60
			MDistribution partialWipDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			partialWipDist.setName("Test Proj Partial WIP Split");
			partialWipDist.setC_AcctSchema_ID(as.get_ID());
			partialWipDist.setIsCreateReversal(false);
			partialWipDist.setAnyAcct(false);
			partialWipDist.setAccount_ID(wipAcctId);
			partialWipDist.saveEx();

			MDistributionLine pwdl1 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			pwdl1.setGL_Distribution_ID(partialWipDist.get_ID());
			pwdl1.setLine(10);
			pwdl1.setPercent(new BigDecimal("60"));
			pwdl1.setOverwriteAcct(false);
			pwdl1.saveEx();

			MDistributionLine pwdl2 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			pwdl2.setGL_Distribution_ID(partialWipDist.get_ID());
			pwdl2.setLine(20);
			pwdl2.setPercent(new BigDecimal("40"));
			pwdl2.setOverwriteAcct(true);
			pwdl2.setAccount_ID(altAcctId);
			pwdl2.saveEx();

			partialWipDist.load(getTrxName());
			partialWipDist.getLines(true);
			assertTrue(partialWipDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { partialWipDist });

			MProjectIssue svcIssue3 = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			svcIssue3.setLine(40);
			svcIssue3.setMovementDate(getLoginDate());
			svcIssue3.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			svcIssue3.setMovementQty(BigDecimal.ONE);
			svcIssue3.setC_Project_ID(proj.get_ID());
			svcIssue3.setM_Product_ID(serviceProduct.get_ID());
			svcIssue3.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(svcIssue3, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			svcIssue3.load(getTrxName());
			if (!svcIssue3.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), svcIssue3.getAD_Client_ID(),
						svcIssue3.get_Table_ID(), svcIssue3.get_ID(), false, getTrxName());
				assertNull(error, "Service ProjectIssue (partial WIP split) posting failed: " + error);
			}
			List<MFactAcct> svcFacts3 = getFacts(MProjectIssue.Table_ID, svcIssue3.get_ID(), as.get_ID());
			assertFactTotals(svcFacts3, wipAcctId, new BigDecimal("60.00"), BigDecimal.ZERO);
			assertFactTotals(svcFacts3, altAcctId, new BigDecimal("40.00"), BigDecimal.ZERO);

			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { svcIssue3.get_ID() }, getTrxName());
			svcIssue3.load(getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(svcIssue3, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Partial WIP split legacy reversal must resolve full -100.00, not partial -60.00");

			// 5. Partial split on BOTH WIP and Expense (with IsCreateReversal=true): both account checks are partial,
			// so reversal must cancel distribution reversal pairs and fall through to quantity-sign total (-100.00).
			int expenseAcctId = new ProductCost(Env.getCtx(), serviceProduct.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Expense, as).getAccount_ID();
			partialWipDist.setIsCreateReversal(true);
			partialWipDist.saveEx();
			MDistribution partialExpDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			partialExpDist.setName("Test Proj Partial Expense Split");
			partialExpDist.setC_AcctSchema_ID(as.get_ID());
			partialExpDist.setIsCreateReversal(true);
			partialExpDist.setAnyAcct(false);
			partialExpDist.setAccount_ID(expenseAcctId);
			partialExpDist.saveEx();

			MDistributionLine pedl1 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			pedl1.setGL_Distribution_ID(partialExpDist.get_ID());
			pedl1.setLine(10);
			pedl1.setPercent(new BigDecimal("60"));
			pedl1.setOverwriteAcct(false);
			pedl1.saveEx();

			MDistributionLine pedl2 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			pedl2.setGL_Distribution_ID(partialExpDist.get_ID());
			pedl2.setLine(20);
			pedl2.setPercent(new BigDecimal("40"));
			pedl2.setOverwriteAcct(true);
			pedl2.setAccount_ID(altAcctId);
			pedl2.saveEx();

			partialExpDist.load(getTrxName());
			partialExpDist.getLines(true);
			assertTrue(partialExpDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { partialWipDist, partialExpDist });

			MProjectIssue svcIssue4 = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			svcIssue4.setLine(50);
			svcIssue4.setMovementDate(getLoginDate());
			svcIssue4.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			svcIssue4.setMovementQty(BigDecimal.ONE);
			svcIssue4.setC_Project_ID(proj.get_ID());
			svcIssue4.setM_Product_ID(serviceProduct.get_ID());
			svcIssue4.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(svcIssue4, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			svcIssue4.load(getTrxName());
			if (!svcIssue4.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), svcIssue4.getAD_Client_ID(),
						svcIssue4.get_Table_ID(), svcIssue4.get_ID(), false, getTrxName());
				assertNull(error, "Service ProjectIssue (both sides split) posting failed: " + error);
			}

			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { svcIssue4.get_ID() }, getTrxName());
			svcIssue4.load(getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(svcIssue4, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Both-sides partial split legacy reversal must resolve full -100.00 via quantity fallback");
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

			// GL Distribution replacing manual-cost Freight Charge facts, overwriting Account and clearing C_Charge_ID
			MDistribution chargeDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			chargeDist.setName("Test Clear Charge GL Dist");
			chargeDist.setC_AcctSchema_ID(as.get_ID());
			chargeDist.setIsCreateReversal(false);
			chargeDist.setAnyAcct(false);
			chargeDist.setAccount_ID(freightAcctId);
			chargeDist.setAnyCharge(false);
			chargeDist.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			chargeDist.saveEx();

			MDistributionLine cdl1 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			cdl1.setGL_Distribution_ID(chargeDist.get_ID());
			cdl1.setLine(10);
			cdl1.setPercent(new BigDecimal("60"));
			cdl1.setOverwriteAcct(true);
			cdl1.setAccount_ID(commissionsAcctId);
			cdl1.setOverwriteCharge(true);
			cdl1.setC_Charge_ID(0);
			cdl1.saveEx();

			MDistributionLine cdl2 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			cdl2.setGL_Distribution_ID(chargeDist.get_ID());
			cdl2.setLine(20);
			cdl2.setPercent(new BigDecimal("40"));
			cdl2.setOverwriteAcct(true);
			cdl2.setAccount_ID(commissionsAcctId);
			cdl2.setOverwriteCharge(true);
			cdl2.setC_Charge_ID(0);
			cdl2.saveEx();

			chargeDist.load(getTrxName());
			chargeDist.getLines(true);
			assertTrue(chargeDist.isValid(), "Charge GL Distribution should be valid");

			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { chargeDist });

			// 1. Shipment + Reversal with GL distribution clearing C_Charge_ID on manual-cost Charge
			MProduct shipProd = createStockedProduct("GLDistClearChgShipProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, shipProd);
			createPOAndMR(shipProd, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("GLDistClearChg Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(shipProd, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MInOut shipment = createSOAndShipment(shipProd, null, new BigDecimal("2"), new BigDecimal("180.00"));
			List<MFactAcct> shipFacts = getFacts(MInOut.Table_ID, shipment.get_ID(), as.get_ID());
			assertEquals(4, shipFacts.size(), "Shipment should have COGS, Asset, and 2 GL-distributed Charge lines");

			ProductCost shipPc = new ProductCost(Env.getCtx(), shipProd.get_ID(), 0, getTrxName());
			int cogsAcctId = shipPc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as).getAccount_ID();
			int shipAssetAcctId = shipPc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			assertFactTotals(shipFacts, cogsAcctId, new BigDecimal("220.00"), BigDecimal.ZERO);
			assertFactTotals(shipFacts, shipAssetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"));
			assertFactTotals(shipFacts, commissionsAcctId, BigDecimal.ZERO, new BigDecimal("20.00"));
			for (MFactAcct fa : shipFacts)
			{
				if (fa.getAccount_ID() == commissionsAcctId)
					assertEquals(0, fa.getC_Charge_ID(), "GL distribution should have cleared C_Charge_ID");
			}

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut shipReversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!shipReversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), shipReversal.getAD_Client_ID(),
						shipReversal.get_Table_ID(), shipReversal.get_ID(), false, getTrxName());
				assertNull(error, "Shipment reversal posting failed when GL distribution cleared C_Charge_ID: " + error);
			}

			List<MFactAcct> shipRevFacts = getFacts(MInOut.Table_ID, shipReversal.get_ID(), as.get_ID());
			assertEquals(4, shipRevFacts.size(), "Shipment reversal should reverse all 4 original facts including distributed lines");
			assertFactTotals(shipRevFacts, cogsAcctId, BigDecimal.ZERO, new BigDecimal("220.00"));
			assertFactTotals(shipRevFacts, shipAssetAcctId, new BigDecimal("200.00"), BigDecimal.ZERO);
			assertFactTotals(shipRevFacts, commissionsAcctId, new BigDecimal("20.00"), BigDecimal.ZERO);

			// 2. Production + Reversal with GL distribution clearing C_Charge_ID on component manual-cost Charge
			MProduct comp = createStockedProduct("GLDistClearChgComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct fg = createStockedProduct("GLDistClearChgFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(fg.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(fg.getName());
			bom.saveEx();

			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(comp.get_ID());
			bomLine.setQtyBOM(new BigDecimal("2"));
			bomLine.saveEx();

			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(fg.get_ID());
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
			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			if (!production.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), production.getAD_Client_ID(),
						production.get_Table_ID(), production.get_ID(), false, getTrxName());
				assertNull(error, "Production posting failed: " + error);
			}

			List<MFactAcct> prodFacts = getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID());
			assertEquals(4, prodFacts.size(), "Production should have FG Asset, Comp Asset, and 2 GL-distributed Charge lines");
			assertFactTotals(prodFacts, commissionsAcctId, BigDecimal.ZERO, new BigDecimal("20.00"));
			for (MFactAcct fa : prodFacts)
			{
				if (fa.getAccount_ID() == commissionsAcctId)
					assertEquals(0, fa.getC_Charge_ID(), "GL distribution should have cleared C_Charge_ID on production");
			}

			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			MProduction prodReversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			if (!prodReversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), prodReversal.getAD_Client_ID(),
						prodReversal.get_Table_ID(), prodReversal.get_ID(), false, getTrxName());
				assertNull(error, "Production reversal posting failed when GL distribution cleared C_Charge_ID: " + error);
			}

			List<MFactAcct> prodRevFacts = getFacts(MProduction.Table_ID, prodReversal.get_ID(), as.get_ID());
			assertEquals(4, prodRevFacts.size(), "Production reversal should reverse all 4 original facts including distributed lines");
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
					assertNotNull(cd, "Reversed FG MCostDetail not found");
					assertEquals(new BigDecimal("-220.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));
				}
				else if (pl.getM_Product_ID() == comp.get_ID())
				{
					MCostDetail cd = MCostDetail.getProduction(as, comp.get_ID(), 0, pl.get_ID(), getTrxName());
					assertNotNull(cd, "Reversed Comp MCostDetail not found");
					assertEquals(new BigDecimal("200.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP));
				}
			}
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
	public void testProductionReversalWaitsForOriginalPosting()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("ProdRevOrderComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct fg = createStockedProduct("ProdRevOrderFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProdRevOrder Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCost burdenCost = createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(fg.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(fg.getName());
			bom.saveEx();

			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(comp.get_ID());
			bomLine.setQtyBOM(new BigDecimal("2"));
			bomLine.saveEx();

			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(fg.get_ID());
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

			ProcessInfo info;
			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				production.load(getTrxName());
				info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());

				production.load(getTrxName());
				assertFalse(production.isPosted(), "Deferred accounting should leave original production unposted");

				info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}

			production.load(getTrxName());
			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			assertFalse(reversal.isPosted(), "Reversal should still be unposted");

			// Mutate manual cost percent before attempting to post reversal first
			burdenCost.setPercent(25);
			burdenCost.saveEx();

			// Posting reversal BEFORE original must fail rather than computing charges from mutated current costs
			String revFirstError = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
					reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertNotNull(revFirstError, "Reversal production must not post before original production has posted");
			reversal.load(getTrxName());
			assertFalse(reversal.isPosted(), "Reversal production must remain unposted");
			assertEquals(0, getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID()).size());

			// Post original first, then mutate burden again to 40% before posting reversal -> reversal must replay 25% (50.00), not recalculate 40% (80.00)
			String origError = DocumentEngine.postImmediate(Env.getCtx(), production.getAD_Client_ID(),
					production.get_Table_ID(), production.get_ID(), false, getTrxName());
			assertNull(origError, "Original production posting failed: " + origError);

			burdenCost.setPercent(40);
			burdenCost.saveEx();

			String revError = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
					reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertNull(revError, "Reversal production posting failed after original posted: " + revError);

			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			List<MFactAcct> origFacts = getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID());
			List<MFactAcct> revFacts = getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID());
			// Original posted with mutated 25% = 50.00 CR; reversal replays exact 50.00 DR
			assertFactTotals(origFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("50.00"));
			assertFactTotals(revFacts, freightAcctId, new BigDecimal("50.00"), BigDecimal.ZERO);
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
			MProductCategory batchCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			batchCat.setName("ProdPrecisionBatchCat");
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
			lotAs.setName("ProdPrecisionLotAS");
			lotAs.setIsLot(true);
			lotAs.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			lotAs.saveEx();
			MAttributeSet lotAsSpy = Mockito.spy(lotAs);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MOrderLine.Table_ID, true);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MInOutLine.Table_ID, true);
			mockedAttrSet.when(() -> MAttributeSet.getCopy(any(Properties.class), eq(lotAs.get_ID()), any())).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(any(Properties.class), eq(lotAs.get_ID()))).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(eq(lotAs.get_ID()))).thenReturn(lotAsSpy);

			MProduct comp = createStockedProduct("ProdPrecisionComp", batchCat.get_ID(), lotAs.get_ID());
			MProduct fg = createStockedProduct("ProdPrecisionFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			MAttributeSetInstance lot1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lot1.setM_AttributeSet_ID(lotAs.get_ID());
			lot1.setLot("LOT-PREC-1");
			lot1.setDescription();
			lot1.saveEx();

			// Cost 10.006 with 50% burden: unrounded -10.006 * 50% = -5.003 -> -5.00
			// (currency-rounded -10.01 * 50% = -5.005 would have wrongly rounded to -5.01)
			createPOAndMR(comp, lot1, new BigDecimal("5"), new BigDecimal("10.006"));

			MCostElement burdenCe = createManualCostElement("ProdPrecision Burden 50pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, burdenCe, lot1.get_ID(), BigDecimal.ZERO, 50);

			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(fg.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(fg.getName());
			bom.saveEx();

			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(comp.get_ID());
			bomLine.setQtyBOM(BigDecimal.ONE);
			bomLine.saveEx();

			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			MProcess createLinesProc = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.CREATE_UPDATE_PRODUCTION_LINES.id);

			// 1. Production with explicit ASI on component line
			MProduction prodExplicit = new MProduction(Env.getCtx(), 0, getTrxName());
			prodExplicit.setM_Product_ID(fg.get_ID());
			prodExplicit.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prodExplicit.setIsUseProductionPlan(false);
			prodExplicit.setMovementDate(getLoginDate());
			prodExplicit.setDocAction(DocAction.ACTION_Complete);
			prodExplicit.setDocStatus(DocAction.STATUS_Drafted);
			prodExplicit.setIsComplete(false);
			prodExplicit.setProductionQty(BigDecimal.ONE);
			prodExplicit.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			prodExplicit.saveEx();

			ProcessInfo pi = new ProcessInfo(createLinesProc.getName(), createLinesProc.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(prodExplicit.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			for (MProductionLine pl : prodExplicit.getLines())
			{
				if (pl.getM_Product_ID() == comp.get_ID())
				{
					pl.setM_AttributeSetInstance_ID(lot1.get_ID());
					pl.saveEx();
				}
			}

			prodExplicit.load(getTrxName());
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prodExplicit, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prodExplicit.load(getTrxName());
			if (!prodExplicit.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), prodExplicit.getAD_Client_ID(),
						prodExplicit.get_Table_ID(), prodExplicit.get_ID(), false, getTrxName());
				assertNull(error, "Explicit-ASI production posting failed: " + error);
			}

			List<MFactAcct> explicitFacts = getFacts(MProduction.Table_ID, prodExplicit.get_ID(), as.get_ID());
			assertFactTotals(explicitFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));

			// 2. Production with ASI=0 (allocated via MProductionLineMA)
			MProduction prodMa = new MProduction(Env.getCtx(), 0, getTrxName());
			prodMa.setM_Product_ID(fg.get_ID());
			prodMa.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prodMa.setIsUseProductionPlan(false);
			prodMa.setMovementDate(getLoginDate());
			prodMa.setDocAction(DocAction.ACTION_Complete);
			prodMa.setDocStatus(DocAction.STATUS_Drafted);
			prodMa.setIsComplete(false);
			prodMa.setProductionQty(BigDecimal.ONE);
			prodMa.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			prodMa.saveEx();

			pi = new ProcessInfo(createLinesProc.getName(), createLinesProc.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(prodMa.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			prodMa.load(getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(prodMa, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prodMa.load(getTrxName());
			if (!prodMa.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), prodMa.getAD_Client_ID(),
						prodMa.get_Table_ID(), prodMa.get_ID(), false, getTrxName());
				assertNull(error, "MA-allocated production posting failed: " + error);
			}

			List<MFactAcct> maFacts = getFacts(MProduction.Table_ID, prodMa.get_ID(), as.get_ID());
			assertFactTotals(maFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
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
	public void testLaborCostLookupDistinguishesGenuineZeroFromUnavailable()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		// 1. Missing expense line ID returns null (unavailable), not Env.ZERO
		MTimeExpenseLine missing = new MTimeExpenseLine(Env.getCtx(), 0, getTrxName());
		missing.setS_TimeExpenseLine_ID(999999999);
		assertNull(missing.getLaborCost(as), "Missing S_TimeExpenseLine row must return null, not zero");

		// 2. Genuine zero ConvertedAmt returns BigDecimal.ZERO (non-null)
		MTimeExpense te = new MTimeExpense(Env.getCtx(), 0, getTrxName());
		te.setC_BPartner_ID(DictionaryIDs.C_BPartner.GARDEN_USER.id);
		te.setDateReport(getLoginDate());
		te.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		te.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
		te.setDocStatus(DocAction.STATUS_Drafted);
		te.setDocAction(DocAction.ACTION_Complete);
		te.saveEx();

		MTimeExpenseLine zeroLine = new MTimeExpenseLine(Env.getCtx(), 0, getTrxName());
		zeroLine.setS_TimeExpense_ID(te.get_ID());
		zeroLine.setLine(10);
		zeroLine.setQty(BigDecimal.ONE);
		zeroLine.setExpenseAmt(BigDecimal.ZERO);
		zeroLine.setConvertedAmt(BigDecimal.ZERO);
		zeroLine.saveEx();

		BigDecimal zeroLabor = zeroLine.getLaborCost(as);
		assertNotNull(zeroLabor, "Genuine zero-cost expense line must return non-null zero");
		assertEquals(0, zeroLabor.signum(), "Genuine zero-cost expense line must return 0");

		// 3. SQL error propagates DBException instead of swallowing and returning zero
		try (MockedStatic<DB> mockedDb = mockStatic(DB.class, Mockito.CALLS_REAL_METHODS))
		{
			mockedDb.when(() -> DB.prepareStatement(any(String.class), any()))
					.thenThrow(new DBException(new java.sql.SQLException("simulated labor lookup failure")));
			assertThrows(DBException.class, () -> zeroLine.getLaborCost(as),
					"Database failure in getLaborCost must propagate instead of returning zero");
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
	public void testProductionReversalCostDetailMatchesReversedInventoryWhenMaterialCostChanges()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("ProdCostDriftComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct fg = createStockedProduct("ProdCostDriftFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			// Receive 2 units at 100.00 each
			createPOAndMR(comp, null, new BigDecimal("2"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProdCostDrift Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(fg.get_ID());
			bom.setValue("BOM_" + fg.getValue());
			bom.setName("BOM " + fg.getName());
			bom.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.saveEx();

			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(comp.get_ID());
			bomLine.setQtyBOM(BigDecimal.ONE);
			bomLine.saveEx();

			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(fg.get_ID());
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
			if (!production.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), production.getAD_Client_ID(),
						production.get_Table_ID(), production.get_ID(), false, getTrxName());
				assertNull(error, "Original production posting failed: " + error);
			}

			// Change component material cost from 100.00 to 120.00 before reversing production
			MCostElement avgPoCe = MCostElement.getMaterialCostElement(Env.getCtx(), MCostElement.COSTINGMETHOD_AveragePO);
			MCost compMatCost = MCost.get(comp, 0, as, 0, avgPoCe.get_ID(), getTrxName());
			assertNotNull(compMatCost);
			compMatCost.setCurrentCostPrice(new BigDecimal("120.00"));
			compMatCost.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			if (!reversal.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
						reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
				assertNull(error, "Production reversal posting failed: " + error);
			}

			MProductionLine origCompLine = null;
			for (MProductionLine pl : production.getLines())
				if (pl.getM_Product_ID() == comp.get_ID())
					origCompLine = pl;
			MProductionLine revCompLine = null;
			for (MProductionLine pl : reversal.getLines())
				if (pl.getM_Product_ID() == comp.get_ID())
					revCompLine = pl;
			assertNotNull(origCompLine);
			assertNotNull(revCompLine);

			MCostDetail origCd = MCostDetail.getProduction(as, comp.get_ID(), 0, origCompLine.get_ID(), 0, getTrxName());
			MCostDetail revCd = MCostDetail.getProduction(as, comp.get_ID(), 0, revCompLine.get_ID(), 0, getTrxName());
			assertNotNull(origCd);
			assertNotNull(revCd);
			assertEquals(new BigDecimal("-100.00"), origCd.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("100.00"), revCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Reversal production component M_CostDetail must match reversed inventory (+100.00), not drifted current cost (120.00)");
			assertEquals(origCd.getM_CostDetail_ID(), revCd.getRef_CostDetail_ID(),
					"Reversal production component M_CostDetail must preserve Ref_CostDetail_ID");
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
	public void testProjectIssueReversalWaitsForOriginalPosting()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ProjRevWaitOrigProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			// Create a Time & Expense line priced at 100.00; expense-linked ProjectIssue must NOT post product manual charges
			MTimeExpense te = new MTimeExpense(Env.getCtx(), 0, getTrxName());
			te.setC_BPartner_ID(DictionaryIDs.C_BPartner.GARDEN_USER.id);
			te.setDateReport(getLoginDate());
			te.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			te.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
			te.setDocStatus(DocAction.STATUS_Drafted);
			te.setDocAction(DocAction.ACTION_Complete);
			te.saveEx();

			MTimeExpenseLine teLine = new MTimeExpenseLine(Env.getCtx(), 0, getTrxName());
			teLine.setS_TimeExpense_ID(te.get_ID());
			teLine.setLine(10);
			teLine.setIsTimeReport(false);
			teLine.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			teLine.setM_Product_ID(product.get_ID());
			teLine.setQty(BigDecimal.ONE);
			teLine.setExpenseAmt(new BigDecimal("100.00"));
			teLine.setConvertedAmt(new BigDecimal("100.00"));
			teLine.saveEx();

			MCostElement burdenCe = createManualCostElement("ProjRevWait Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("ProjRevWait Project");
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
			issue.setS_TimeExpenseLine_ID(teLine.get_ID());
			issue.saveEx();

			ProcessInfo info;
			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}

			issue.load(getTrxName());
			assertFalse(issue.isPosted(), "Original ProjectIssue should still be unposted");
			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			assertFalse(reversal.isPosted(), "Reversal ProjectIssue should still be unposted");

			// Posting the reversal BEFORE the original must be rejected instead of falling through to ProductCost + ManualCosts
			String revErrBefore = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
					reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertNotNull(revErrBefore, "ProjectIssue reversal must not post before original ProjectIssue is posted");
			assertTrue(revErrBefore.contains("Original Project Issue not posted yet"),
					"Unexpected error when posting ProjectIssue reversal before original: " + revErrBefore);
			reversal.load(getTrxName());
			assertFalse(reversal.isPosted(), "Reversal ProjectIssue must remain unposted");

			// Post original first, then reversal succeeds and matches original facts (no Charge facts)
			String origErr = DocumentEngine.postImmediate(Env.getCtx(), issue.getAD_Client_ID(),
					issue.get_Table_ID(), issue.get_ID(), false, getTrxName());
			assertNull(origErr, "Original ProjectIssue posting failed: " + origErr);

			String revErrAfter = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
					reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertNull(revErrAfter, "Reversal ProjectIssue posting failed after original posted: " + revErrAfter);

			List<MFactAcct> origFacts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			List<MFactAcct> revFacts = getFacts(MProjectIssue.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(2, origFacts.size(), "PO-linked original ProjectIssue should post 2 facts without Charge");
			assertEquals(2, revFacts.size(), "Reversal ProjectIssue must reverse exact 2 original facts without Charge");
			int wipAcctId = getProjectWipAccountId(proj, as);
			assertFactTotals(revFacts, wipAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
		}
	}

	@Test
	public void testProjectIssueUnpostedLegacyReversalExcludesManualCharge()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("UnpostedLegacyProjProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("UnpostedLegacy Project");
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

			ProcessInfo info;
			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
			}
			issue.load(getTrxName());
			assertFalse(issue.isPosted(), "Legacy issue must remain unposted");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("100.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			// Simulate pre-migration unposted record (CostAmt NULL), then configure a 20.00 manual charge before reversal
			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { issue.get_ID() }, getTrxName());
			issue.load(getTrxName());
			MCostElement lateChargeCe = createManualCostElement("UnpostedLegacy Charge 20",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(product, as, lateChargeCe, 0, new BigDecimal("20.00"), 0);

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}
			issue.load(getTrxName());
			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-100.00"), reversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Unposted pre-migration legacy reversal must subtract only material cost (-100.00), not late manual charge");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt must return to 0.00 rather than -20.00");
		}
	}

	@Test
	public void testProjectIssueReversalFallbackCostDetailWithGLDistribution()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ProjGLDistFallbackProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProjGLDistFallback Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("ProjGLDistFallback Project");
			proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
			proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			proj.setPlannedAmt(Env.ONE);
			proj.setCommittedQty(Env.ONE);
			proj.saveEx();

			int wipAcctId = getProjectWipAccountId(proj, as);
			int assetAcctId = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int altAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName()).getAccount_ID();

			// 1. GL Distribution (IsCreateReversal=N) replaces WIP DR so origFacts.get(0)=Asset CR and origFacts.get(1)=Charge CR
			MDistribution wipDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			wipDist.setName("ProjFallback Replace WIP");
			wipDist.setC_AcctSchema_ID(as.get_ID());
			wipDist.setIsCreateReversal(false);
			wipDist.setAnyAcct(false);
			wipDist.setAccount_ID(wipAcctId);
			wipDist.saveEx();

			MDistributionLine wdl = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			wdl.setGL_Distribution_ID(wipDist.get_ID());
			wdl.setLine(10);
			wdl.setPercent(new BigDecimal("100"));
			wdl.setOverwriteAcct(true);
			wdl.setAccount_ID(altAcctId);
			wdl.saveEx();
			wipDist.load(getTrxName());
			wipDist.getLines(true);
			assertTrue(wipDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { wipDist });

			MProjectIssue issue1 = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			issue1.setLine(10);
			issue1.setMovementDate(getLoginDate());
			issue1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			issue1.setMovementQty(BigDecimal.ONE);
			issue1.setC_Project_ID(proj.get_ID());
			issue1.setM_Product_ID(product.get_ID());
			issue1.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(issue1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			issue1.load(getTrxName());
			if (!issue1.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), issue1.getAD_Client_ID(),
						issue1.get_Table_ID(), issue1.get_ID(), false, getTrxName());
				assertNull(err, "ProjectIssue1 posting failed: " + err);
			}
			List<MFactAcct> facts1 = getFacts(MProjectIssue.Table_ID, issue1.get_ID(), as.get_ID());
			assertEquals(3, facts1.size());
			assertEquals(assetAcctId, facts1.get(0).getAccount_ID(), "First fact should be Asset CR after WIP replacement");
			assertTrue(facts1.get(1).getC_Charge_ID() > 0, "Second fact should be Charge CR");

			// Delete original M_CostDetail so reversal must use resolveReversalInventoryCost fallback
			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE C_ProjectIssue_ID=?",
					new Object[] { issue1.get_ID() }, getTrxName());

			info = MWorkflow.runDocumentActionWorkflow(issue1, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			issue1.load(getTrxName());
			MProjectIssue rev1 = new MProjectIssue(Env.getCtx(), issue1.getReversal_ID(), getTrxName());
			if (!rev1.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), rev1.getAD_Client_ID(),
						rev1.get_Table_ID(), rev1.get_ID(), false, getTrxName());
				assertNull(err, "ProjectIssue1 reversal posting failed: " + err);
			}
			MCostDetail revCd1 = MCostDetail.getProjectIssue(as, product.get_ID(), 0, rev1.get_ID(), 0, getTrxName());
			assertNotNull(revCd1, "Reversal ProjectIssue1 M_CostDetail should be created");
			assertEquals(new BigDecimal("100.00"), revCd1.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Fallback M_CostDetail must resolve +100.00 inventory cost, not +10.00 Charge fact at index 1");

			// 2. Partial P_Asset split with IsCreateReversal=true (60% stays on P_Asset, 40% moves to altAcctId)
			MDistribution partialAssetDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			partialAssetDist.setName("ProjFallback Partial Asset Split");
			partialAssetDist.setC_AcctSchema_ID(as.get_ID());
			partialAssetDist.setIsCreateReversal(true);
			partialAssetDist.setAnyAcct(false);
			partialAssetDist.setAccount_ID(assetAcctId);
			partialAssetDist.saveEx();

			MDistributionLine padl1 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			padl1.setGL_Distribution_ID(partialAssetDist.get_ID());
			padl1.setLine(10);
			padl1.setPercent(new BigDecimal("60"));
			padl1.setOverwriteAcct(false);
			padl1.saveEx();

			MDistributionLine padl2 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			padl2.setGL_Distribution_ID(partialAssetDist.get_ID());
			padl2.setLine(20);
			padl2.setPercent(new BigDecimal("40"));
			padl2.setOverwriteAcct(true);
			padl2.setAccount_ID(altAcctId);
			padl2.saveEx();
			partialAssetDist.load(getTrxName());
			partialAssetDist.getLines(true);
			assertTrue(partialAssetDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { partialAssetDist });

			MProjectIssue issue2 = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			issue2.setLine(20);
			issue2.setMovementDate(getLoginDate());
			issue2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			issue2.setMovementQty(BigDecimal.ONE);
			issue2.setC_Project_ID(proj.get_ID());
			issue2.setM_Product_ID(product.get_ID());
			issue2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(issue2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			issue2.load(getTrxName());
			if (!issue2.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), issue2.getAD_Client_ID(),
						issue2.get_Table_ID(), issue2.get_ID(), false, getTrxName());
				assertNull(err, "ProjectIssue2 posting failed: " + err);
			}
			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE C_ProjectIssue_ID=?",
					new Object[] { issue2.get_ID() }, getTrxName());

			info = MWorkflow.runDocumentActionWorkflow(issue2, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			issue2.load(getTrxName());
			MProjectIssue rev2 = new MProjectIssue(Env.getCtx(), issue2.getReversal_ID(), getTrxName());
			if (!rev2.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), rev2.getAD_Client_ID(),
						rev2.get_Table_ID(), rev2.get_ID(), false, getTrxName());
				assertNull(err, "ProjectIssue2 reversal posting failed: " + err);
			}
			MCostDetail revCd2 = MCostDetail.getProjectIssue(as, product.get_ID(), 0, rev2.get_ID(), 0, getTrxName());
			assertNotNull(revCd2, "Reversal ProjectIssue2 M_CostDetail should be created");
			assertEquals(new BigDecimal("100.00"), revCd2.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Partial asset split with IsCreateReversal=true must resolve full +100.00 (not 60.00 or 200.00)");
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
	public void testShipmentAndProductionReversalWithPartialAssetSplitAndMultiOrgFgDistribution()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		MAcctSchemaElement[] origElems = as.getAcctSchemaElements();
		MAcctSchemaElement[] balancedElems = new MAcctSchemaElement[origElems.length];
		for (int i = 0; i < origElems.length; i++)
		{
			if (MAcctSchemaElement.ELEMENTTYPE_Organization.equals(origElems[i].getElementType()))
			{
				MAcctSchemaElement copy = new MAcctSchemaElement(Env.getCtx(), origElems[i].get_ID(), getTrxName());
				copy.setIsBalanced(true);
				balancedElems[i] = copy;
			}
			else
			{
				balancedElems[i] = origElems[i];
			}
		}

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAcctSchemaElement> mockedElem = mockStatic(MAcctSchemaElement.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MDistribution> mockedDist = mockStatic(MDistribution.class, Mockito.CALLS_REAL_METHODS))
		{
			int altAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName()).getAccount_ID();

			// 1. Shipment reversal with IsCreateReversal=true partial P_Asset split (60% P_Asset, 40% altAcctId) and deleted M_CostDetail
			MProduct shipProd = createStockedProduct("ShipPartialSplitProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, shipProd);
			createPOAndMR(shipProd, null, new BigDecimal("5"), new BigDecimal("100.00"));
			MCostElement burdenCe = createManualCostElement("PartialSplit Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(shipProd, as, burdenCe, 0, BigDecimal.ZERO, 10);

			int shipAssetAcctId = new ProductCost(Env.getCtx(), shipProd.get_ID(), 0, getTrxName())
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();

			MDistribution partialAssetDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			partialAssetDist.setName("Partial Asset Split IsCreateReversal");
			partialAssetDist.setC_AcctSchema_ID(as.get_ID());
			partialAssetDist.setIsCreateReversal(true);
			partialAssetDist.setAnyAcct(false);
			partialAssetDist.setAccount_ID(shipAssetAcctId);
			partialAssetDist.saveEx();

			MDistributionLine padl1 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			padl1.setGL_Distribution_ID(partialAssetDist.get_ID());
			padl1.setLine(10);
			padl1.setPercent(new BigDecimal("60"));
			padl1.setOverwriteAcct(false);
			padl1.saveEx();

			MDistributionLine padl2 = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			padl2.setGL_Distribution_ID(partialAssetDist.get_ID());
			padl2.setLine(20);
			padl2.setPercent(new BigDecimal("40"));
			padl2.setOverwriteAcct(true);
			padl2.setAccount_ID(altAcctId);
			padl2.saveEx();
			partialAssetDist.load(getTrxName());
			partialAssetDist.getLines(true);
			assertTrue(partialAssetDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { partialAssetDist });

			MInOut shipment = createSOAndShipment(shipProd, null, BigDecimal.ONE, new BigDecimal("150.00"));
			MInOutLine origShipLine = shipment.getLines(true)[0];
			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE M_InOutLine_ID=?",
					new Object[] { origShipLine.get_ID() }, getTrxName());

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			MInOut shipRev = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			if (!shipRev.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), shipRev.getAD_Client_ID(),
						shipRev.get_Table_ID(), shipRev.get_ID(), false, getTrxName());
				assertNull(err, "Shipment reversal posting failed: " + err);
			}
			MInOutLine revShipLine = shipRev.getLines(true)[0];
			MCostDetail revShipCd = MCostDetail.getShipment(as, shipProd.get_ID(), 0, revShipLine.get_ID(), 0, getTrxName());
			assertNotNull(revShipCd, "Reversal shipment M_CostDetail should be created");
			assertEquals(new BigDecimal("100.00"), revShipCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Shipment fallback must resolve full +100.00 after cancelling IsCreateReversal=true pair and combining 60/40 split");

			// 2. Production reversal: partial component P_Asset split (IsCreateReversal=true) + multi-org GL Distribution on FG line
			// deactivated before reversal (must replay FG facts in STORE_CENTRAL alongside header DueTo/DueFrom so both orgs balance)
			mockedElem.when(() -> MAcctSchemaElement.getAcctSchemaElements(any(MAcctSchema.class)))
					.thenReturn(balancedElems);

			MProduct comp = createStockedProduct("ProdMultiOrgComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct fg = createStockedProduct("ProdMultiOrgFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);
			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createManualCostRecord(comp, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(fg.get_ID());
			bom.setValue("BOM_" + fg.getValue());
			bom.setName("BOM " + fg.getName());
			bom.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.saveEx();

			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(comp.get_ID());
			bomLine.setQtyBOM(BigDecimal.ONE);
			bomLine.saveEx();
			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			// Distribute FG line (matching M_Product_ID = fg) to STORE_CENTRAL, and partially split comp P_Asset (matching M_Product_ID = comp)
			partialAssetDist.setAnyProduct(false);
			partialAssetDist.setM_Product_ID(comp.get_ID());
			partialAssetDist.saveEx();

			MDistribution fgOrgDist = new MDistribution(Env.getCtx(), 0, getTrxName());
			fgOrgDist.setName("Prod FG Move To StoreCentral");
			fgOrgDist.setC_AcctSchema_ID(as.get_ID());
			fgOrgDist.setIsCreateReversal(false);
			fgOrgDist.setAnyProduct(false);
			fgOrgDist.setM_Product_ID(fg.get_ID());
			fgOrgDist.saveEx();

			MDistributionLine fgdl = new MDistributionLine(Env.getCtx(), 0, getTrxName());
			fgdl.setGL_Distribution_ID(fgOrgDist.get_ID());
			fgdl.setLine(10);
			fgdl.setPercent(new BigDecimal("100"));
			fgdl.setOverwriteOrg(true);
			fgdl.setOrg_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			fgdl.saveEx();
			fgOrgDist.load(getTrxName());
			fgOrgDist.getLines(true);
			assertTrue(fgOrgDist.isValid());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[] { partialAssetDist, fgOrgDist });

			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(fg.get_ID());
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
			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			if (!production.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), production.getAD_Client_ID(),
						production.get_Table_ID(), production.get_ID(), false, getTrxName());
				assertNull(err, "Production posting failed: " + err);
			}

			int dueToAcctId = as.getDueTo_Acct(MAcctSchemaElement.ELEMENTTYPE_Organization).getAccount_ID();
			int dueFromAcctId = as.getDueFrom_Acct(MAcctSchemaElement.ELEMENTTYPE_Organization).getAccount_ID();
			List<MFactAcct> origProdFacts = getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID());
			assertFactTotals(origProdFacts, dueToAcctId, BigDecimal.ZERO, new BigDecimal("110.00"));
			assertFactTotals(origProdFacts, dueFromAcctId, new BigDecimal("110.00"), BigDecimal.ZERO);

			// Delete component M_CostDetail AND deactivate GL distributions before reversing
			MProductionLine origCompLine = null;
			for (MProductionLine pl : production.getLines())
				if (pl.getM_Product_ID() == comp.get_ID())
					origCompLine = pl;
			assertNotNull(origCompLine);
			DB.executeUpdateEx("DELETE FROM M_CostDetail WHERE M_ProductionLine_ID=?",
					new Object[] { origCompLine.get_ID() }, getTrxName());
			mockedDist.when(MDistribution::getAll).thenReturn(new MDistribution[0]);

			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			MProduction prodRev = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			if (!prodRev.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), prodRev.getAD_Client_ID(),
						prodRev.get_Table_ID(), prodRev.get_ID(), false, getTrxName());
				assertNull(err, "Production reversal posting failed: " + err);
			}

			List<MFactAcct> revProdFacts = getFacts(MProduction.Table_ID, prodRev.get_ID(), as.get_ID());
			// Verify DueTo and DueFrom are reversed cleanly without generating extra balancing entries
			assertFactTotals(revProdFacts, dueToAcctId, new BigDecimal("110.00"), BigDecimal.ZERO);
			assertFactTotals(revProdFacts, dueFromAcctId, BigDecimal.ZERO, new BigDecimal("110.00"));
			// Verify every Org balances to 0.00 on the reversal
			BigDecimal hqNet = BigDecimal.ZERO;
			BigDecimal storeNet = BigDecimal.ZERO;
			for (MFactAcct fa : revProdFacts)
			{
				BigDecimal net = fa.getAmtAcctDr().subtract(fa.getAmtAcctCr());
				if (fa.getAD_Org_ID() == DictionaryIDs.AD_Org.HQ.id)
					hqNet = hqNet.add(net);
				else if (fa.getAD_Org_ID() == DictionaryIDs.AD_Org.STORE_CENTRAL.id)
					storeNet = storeNet.add(net);
			}
			assertEquals(0, hqNet.signum(), "HQ org must balance to 0.00 on multi-org production reversal");
			assertEquals(0, storeNet.signum(), "STORE_CENTRAL org must balance to 0.00 on multi-org production reversal");

			MProductionLine revCompLine = null;
			for (MProductionLine pl : prodRev.getLines())
				if (pl.getM_Product_ID() == comp.get_ID())
					revCompLine = pl;
			assertNotNull(revCompLine);
			MCostDetail revCompCd = MCostDetail.getProduction(as, comp.get_ID(), 0, revCompLine.get_ID(), 0, getTrxName());
			assertNotNull(revCompCd, "Reversal production component M_CostDetail should be created");
			assertEquals(new BigDecimal("100.00"), revCompCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Production component fallback must resolve full +100.00 after cancelling IsCreateReversal=true pair and combining 60/40 split");
		}
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
