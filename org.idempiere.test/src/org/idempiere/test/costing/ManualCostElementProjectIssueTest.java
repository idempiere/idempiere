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
import java.util.ArrayList;
import java.util.List;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MFactAcct;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.ProductCost;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Project Issue and legacy reversal tests for IDEMPIERE-7231.
 */
public class ManualCostElementProjectIssueTest extends AbstractManualCostElementTest
{
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

			MProject proj = createWorkOrderProject("ManualCost Test Project");
			MProjectIssue issue = createProjectIssue(proj, product, 10, new BigDecimal("2"), getLoginDate());
			completeAndPost(issue);

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

			MProjectIssue reversal = reverseAndPost(issue);

			// ProjectBalanceAmt must return to 0.00 even after cost element mutations
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should return to zero after reversal");

			List<MFactAcct> revFacts = getFacts(MProjectIssue.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(4, revFacts.size(), "ProjectIssue reversal should have 4 Fact_Acct lines matching original");
			assertProjectIssueReversalFactTotals(revFacts, wipAcctId, new BigDecimal("230.00"), BigDecimal.ZERO, as);
			assertProjectIssueReversalFactTotals(revFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("200.00"), as);
			assertProjectIssueReversalFactTotals(revFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("30.00"), as);

			List<BigDecimal> revChargeDebits = new ArrayList<>();
			for (MFactAcct fa : revFacts)
			{
				if (fa.getAccount_ID() == freightAcctId)
				{
					assertEquals(DictionaryIDs.C_Charge.FREIGHT.id, fa.getC_Charge_ID(), "Reversed ProjectIssue Charge line must retain C_Charge_ID");
					revChargeDebits.add(fa.getAmtAcctDr().subtract(fa.getAmtAcctCr()).setScale(2, RoundingMode.HALF_UP));
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

			MProject proj = createWorkOrderProject("ManualCost Deferred Project");

			// 1. Complete first issue with deferred posting (200 material + 20 burden + 10 overhead = 230)
			MProjectIssue issue = createProjectIssue(proj, product, 10, new BigDecimal("2"), getLoginDate());
			runDeferred(() -> complete(issue));
			assertFalse(issue.isPosted(), "Deferred accounting should leave issue unposted at completion");
			assertEquals(new BigDecimal("230.00"), issue.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"CostAmt should persist completion-time balance contribution");

			proj.load(getTrxName());
			assertEquals(new BigDecimal("230.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			// Deactivate overhead BETWEEN completion and posting
			overheadCe.setIsActive(false);
			overheadCe.saveEx();
			postImmediate(issue);

			int wipAcctId = getProjectWipAccountId(proj, as);
			assertFactTotals(getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID()),
					wipAcctId, new BigDecimal("220.00"), BigDecimal.ZERO);

			// Reverse must subtract the 230.00 recorded at completion, returning ProjectBalanceAmt to 0.00
			reverseCorrect(issue);
			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-230.00"), reversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Reversal CostAmt should negate original CostAmt");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should return to zero even when manual cost changed between completion and posting");

			// 2a. Pre-migration NULL CostAmt with pre-migration unmapped burden
			burdenCe.setIsActive(false);
			burdenCe.saveEx();
			MCostElement unmappedBurdenCe = createManualCostElement("ProjUnmappedBurden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, 0);
			MCost unmappedBurdenCost = createManualCostRecord(product, as, unmappedBurdenCe, 0, BigDecimal.ZERO, 10);

			MProjectIssue legacyIssue = createProjectIssue(proj, product, 20, BigDecimal.ONE, getLoginDate());
			completeAndPost(legacyIssue);
			assertFactTotals(getFacts(MProjectIssue.Table_ID, legacyIssue.get_ID(), as.get_ID()),
					wipAcctId, new BigDecimal("110.00"), BigDecimal.ZERO);
			proj.load(getTrxName());
			assertEquals(new BigDecimal("110.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { legacyIssue.get_ID() }, getTrxName());
			legacyIssue.load(getTrxName());
			assertNull(legacyIssue.get_Value(MProjectIssue.COLUMNNAME_CostAmt));
			unmappedBurdenCost.setPercent(0);
			unmappedBurdenCost.saveEx();
			unmappedBurdenCe.setIsActive(false);
			unmappedBurdenCe.saveEx();

			reverseCorrect(legacyIssue);
			MProjectIssue legacyReversal = new MProjectIssue(Env.getCtx(), legacyIssue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-110.00"), legacyReversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Legacy reversal should resolve original cost detail (-110.00), not current cost (-100.00)");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			// 2b. Pre-migration NULL CostAmt completed before any charge existed, then charge configured before first posting
			MProduct lateChargeProd = createStockedProduct("ManualCostLateChgProjProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, lateChargeProd);
			createPOAndMR(lateChargeProd, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MProjectIssue legacyDeferredIssue = createProjectIssue(proj, lateChargeProd, 30, BigDecimal.ONE, getLoginDate());
			runDeferred(() -> complete(legacyDeferredIssue));
			assertFalse(legacyDeferredIssue.isPosted());
			proj.load(getTrxName());
			assertEquals(new BigDecimal("100.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));

			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { legacyDeferredIssue.get_ID() }, getTrxName());
			legacyDeferredIssue.load(getTrxName());
			MCostElement lateChargeCe = createManualCostElement("ProjLateCharge 20",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.COMMISSIONS.id);
			createManualCostRecord(lateChargeProd, as, lateChargeCe, 0, new BigDecimal("20.00"), 0);

			postImmediate(legacyDeferredIssue);
			assertFactTotals(getFacts(MProjectIssue.Table_ID, legacyDeferredIssue.get_ID(), as.get_ID()),
					wipAcctId, new BigDecimal("120.00"), BigDecimal.ZERO);

			reverseCorrect(legacyDeferredIssue);
			MProjectIssue lateReversal = new MProjectIssue(Env.getCtx(), legacyDeferredIssue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-100.00"), lateReversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Legacy reversal must not subtract a charge added after completion");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt must return to 0.00 rather than -20.00");
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

			// Use a test-owned Charge so updating C_Charge_Acct does not lock GardenWorld's shared FREIGHT row
			MCharge testCharge = new MCharge(Env.getCtx(), 0, getTrxName());
			testCharge.setName("SubCent Proj Test Charge");
			testCharge.setChargeAmt(BigDecimal.ZERO);
			testCharge.saveEx();
			MAccount freightAcct = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName());
			assertNotNull(freightAcct);
			DB.executeUpdateEx("UPDATE C_Charge_Acct SET Ch_Expense_Acct=? WHERE C_Charge_ID=? AND C_AcctSchema_ID=?",
					new Object[] { freightAcct.get_ID(), testCharge.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MCostElement overheadCe = createManualCostElement("SubCent Proj Overhead 5",
					MCostElement.COSTELEMENTTYPE_Overhead, testCharge.get_ID());
			createManualCostRecord(product, as, overheadCe, 0, new BigDecimal("5.00"), 0);

			MProject proj = createWorkOrderProject("ManualCost SubCent Project");
			MProjectIssue issue = createProjectIssue(proj, product, 10, BigDecimal.ONE, getLoginDate());
			completeAndPost(issue);

			List<MFactAcct> origFacts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			assertEquals(3, origFacts.size(), "Original ProjectIssue should have 3 Fact_Acct lines (WIP, Asset, Charge)");
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int origWipAcctId = getProjectWipAccountId(proj, as);
			int origAssetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(testCharge.get_ID(), as, getTrxName()).getAccount_ID();
			assertFactTotals(origFacts, origWipAcctId, new BigDecimal("105.00"), BigDecimal.ZERO);
			assertFactTotals(origFacts, origAssetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(origFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"));

			MCostDetail origCd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", issue.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(origCd, "Original ProjectIssue MCostDetail not found");
			assertEquals(new BigDecimal("-100.0040"), origCd.getAmt().setScale(4, RoundingMode.HALF_UP),
					"Original ProjectIssue MCostDetail should preserve sub-cent costing precision");

			// Change Charge Ch_Expense_Acct BEFORE reversing to verify historical C_ValidCombination_ID preservation
			MAccount altAcct = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName());
			assertNotNull(altAcct);
			DB.executeUpdateEx("UPDATE C_Charge_Acct SET Ch_Expense_Acct=? WHERE C_Charge_ID=? AND C_AcctSchema_ID=?",
					new Object[] { altAcct.get_ID(), testCharge.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MProjectIssue reversal = reverseAndPost(issue);

			List<MFactAcct> revFacts = getFacts(MProjectIssue.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(3, revFacts.size(), "Reversal should have 3 Fact_Acct lines matching original");
			assertProjectIssueReversalFactTotals(revFacts, origWipAcctId, new BigDecimal("105.00"), BigDecimal.ZERO, as);
			assertProjectIssueReversalFactTotals(revFacts, origAssetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"), as);
			assertProjectIssueReversalFactTotals(revFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("5.00"), as);
			assertFactTotals(revFacts, altAcct.getAccount_ID(), BigDecimal.ZERO, BigDecimal.ZERO);

			List<MManualCostDetail> origMcds = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MProjectIssue.Table_ID, issue.get_ID(), getTrxName());
			List<MManualCostDetail> revMcds = MManualCostDetail.getByRecord(Env.getCtx(), as.get_ID(),
					MProjectIssue.Table_ID, reversal.get_ID(), getTrxName());
			assertEquals(1, origMcds.size());
			assertEquals(1, revMcds.size());
			assertEquals(0, origMcds.get(0).getAmt().add(revMcds.get(0).getAmt()).signum(),
					"Original and reversed ProjectIssue M_ManualCostDetail must net to zero");

			// Reversal MCostDetail must cancel original unrounded amount (-100.0040 + 100.0040 = 0)
			MCostDetail revCd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", reversal.get_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(revCd, "Reversed ProjectIssue MCostDetail not found");
			assertEquals(origCd.getM_CostDetail_ID(), revCd.getRef_CostDetail_ID(),
					"Reversed ProjectIssue MCostDetail should reference original MCostDetail");
			assertEquals(new BigDecimal("100.0040"), revCd.getAmt().setScale(4, RoundingMode.HALF_UP),
					"Reversed ProjectIssue MCostDetail should offset original unrounded amount exactly");
			assertEquals(0, origCd.getAmt().add(revCd.getAmt()).compareTo(BigDecimal.ZERO));
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
			MProductCategory stdCategory = createCategoryWithCosting("ManualCostStdOverrideCat", as,
					null, MCostElement.COSTINGMETHOD_StandardCosting, mockedCategory);
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

			MProject proj = createWorkOrderProject("ManualCost StdOverride Project");
			MProjectIssue issue = createProjectIssue(proj, product, 10, new BigDecimal("2"), getLoginDate());
			completeAndPost(issue);

			// ProjectBalanceAmt must match Standard Costing valuation (2 * 80.00 = 160.00, no manual costs)
			proj.load(getTrxName());
			assertEquals(new BigDecimal("160.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt should use product's Standard Costing override and exclude manual costs");

			List<MFactAcct> facts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			assertEquals(2, facts.size(), "Standard Costing ProjectIssue should create 2 Fact_Acct lines without manual cost Charges");
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int wipAcctId = getProjectWipAccountId(proj, as);
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			assertFactTotals(facts, wipAcctId, new BigDecimal("160.00"), BigDecimal.ZERO);
			assertFactTotals(facts, assetAcctId, BigDecimal.ZERO, new BigDecimal("160.00"));

			reverseAndPost(issue);
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
	public void testProjectIssueReversalWaitsForOriginalPosting()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("ProjRevWaitOrigProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProjRevWait Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCost burdenCost = createManualCostRecord(product, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MProject proj = createWorkOrderProject("ProjRevWait Project");
			MProjectIssue issue = createProjectIssue(proj, product, 10, BigDecimal.ONE, getLoginDate());
			runDeferred(() -> {
				complete(issue);
				reverseCorrect(issue);
			});

			assertFalse(issue.isPosted(), "Original ProjectIssue should still be unposted");
			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			assertFalse(reversal.isPosted(), "Reversal ProjectIssue should still be unposted");

			// Mutate burden to 25% before posting either document
			burdenCost.setPercent(25);
			burdenCost.saveEx();

			// Posting the reversal BEFORE the original must be rejected
			String revErrBefore = tryPostImmediate(reversal);
			assertNotNull(revErrBefore, "ProjectIssue reversal must not post before original ProjectIssue is posted");
			assertTrue(revErrBefore.contains("Original Project Issue not posted yet"),
					"Unexpected error when posting ProjectIssue reversal before original: " + revErrBefore);
			reversal.load(getTrxName());
			assertFalse(reversal.isPosted(), "Reversal ProjectIssue must remain unposted");

			// Post original (posts 25% = 25.00), mutate burden again to 40%, then post reversal -> replays exact 25.00
			postImmediate(issue);
			burdenCost.setPercent(40);
			burdenCost.saveEx();
			postImmediate(reversal);

			List<MFactAcct> origFacts = getFacts(MProjectIssue.Table_ID, issue.get_ID(), as.get_ID());
			List<MFactAcct> revFacts = getFacts(MProjectIssue.Table_ID, reversal.get_ID(), as.get_ID());
			assertEquals(3, origFacts.size());
			assertEquals(3, revFacts.size());
			int wipAcctId = getProjectWipAccountId(proj, as);
			ProductCost pc = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			int assetAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(origFacts, wipAcctId, new BigDecimal("125.00"), BigDecimal.ZERO);
			assertFactTotals(origFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"));
			assertFactTotals(origFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("25.00"));
			assertProjectIssueReversalFactTotals(revFacts, wipAcctId, new BigDecimal("125.00"), BigDecimal.ZERO, as);
			assertProjectIssueReversalFactTotals(revFacts, assetAcctId, BigDecimal.ZERO, new BigDecimal("100.00"), as);
			assertProjectIssueReversalFactTotals(revFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("25.00"), as);
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

			MProject proj = createWorkOrderProject("UnpostedLegacy Project");
			MProjectIssue issue = createProjectIssue(proj, product, 10, BigDecimal.ONE, getLoginDate());
			runDeferred(() -> complete(issue));
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

			runDeferred(() -> reverseCorrect(issue));
			MProjectIssue reversal = new MProjectIssue(Env.getCtx(), issue.getReversal_ID(), getTrxName());
			assertEquals(new BigDecimal("-100.00"), reversal.getCostAmt().setScale(2, RoundingMode.HALF_UP),
					"Unposted pre-migration legacy reversal must subtract only material cost (-100.00), not late manual charge");
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"ProjectBalanceAmt must return to 0.00 rather than -20.00");
		}
	}

	@Test
	public void testUnpostedLegacyProjectIssueReversalPreservesSchemaCostingMethod()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS))
		{
			// Product category overrides schema costing method (AveragePO=100) with StandardCosting (80)
			MProductCategory stdCat = createCategoryWithCosting("LegacyProjStdCat", as,
					null, MAcctSchema.COSTINGMETHOD_StandardCosting, mockedCategory);
			MProduct serviceProd = createServiceProduct("LegacySchemaMethodSvc", stdCat.get_ID());
			mockProductGet(mockedProduct, serviceProd);

			MCost.CostingKey key = MCost.CostingKey.resolve(getAD_Org_ID(), 0, serviceProd.getCostingLevel(as));
			MCostElement avgPoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AveragePO);
			MCost avgPoCost = MCost.get(serviceProd, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgPoCe.get_ID(), getTrxName());
			avgPoCost.setCurrentCostPrice(new BigDecimal("100.00"));
			avgPoCost.saveEx();

			MCostElement stdCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_StandardCosting);
			MCost stdCost = MCost.get(serviceProd, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), stdCe.get_ID(), getTrxName());
			stdCost.setCurrentCostPrice(new BigDecimal("80.00"));
			stdCost.saveEx();

			MProject proj = createWorkOrderProject("Legacy Schema Costing Method Project");

			// 1. Simulate unposted pre-upgrade issue that added 100.00 under schema method (AveragePO), CostAmt=NULL
			MProjectIssue legacyIssue = createProjectIssue(proj, serviceProd, 10, BigDecimal.ONE, getLoginDate());
			runDeferred(() -> complete(legacyIssue));
			assertFalse(legacyIssue.isPosted(), "Simulated pre-upgrade issue should be unposted");
			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { legacyIssue.get_ID() }, getTrxName());
			DB.executeUpdateEx("UPDATE C_Project SET ProjectBalanceAmt=100.00 WHERE C_Project_ID=?",
					new Object[] { proj.get_ID() }, getTrxName());
			legacyIssue.load(getTrxName());

			runDeferred(() -> reverseCorrect(legacyIssue));
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Unposted legacy reversal must use pre-upgrade schema costing method (-100.00), not product override (-80.00)");

			// 2. Verify new completion still uses product override (StandardCosting = +80.00) and reverses -80.00 via CostAmt
			MProjectIssue newIssue = createProjectIssue(proj, serviceProd, 20, BigDecimal.ONE, TimeUtil.addDays(getLoginDate(), 1));
			runDeferred(() -> {
				complete(newIssue);
				proj.load(getTrxName());
				assertEquals(new BigDecimal("80.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
						"New completion must use product costing method override (+80.00)");
				reverseCorrect(newIssue);
				proj.load(getTrxName());
				assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
						"New issue reversal must subtract exact stored CostAmt (-80.00)");
			});
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testFailedProjectIssuePostingDoesNotLeakManualCostDetail()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct product = createStockedProduct("AtomicFailProjProd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			mockProductGet(mockedProduct, product);
			createPOAndMR(product, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCharge validCharge = new MCharge(Env.getCtx(), 0, getTrxName());
			validCharge.setName("AtomicFail Valid Charge");
			validCharge.setChargeAmt(BigDecimal.ZERO);
			validCharge.saveEx();

			MCharge brokenCharge = new MCharge(Env.getCtx(), 0, getTrxName());
			brokenCharge.setName("AtomicFail Broken Charge");
			brokenCharge.setChargeAmt(BigDecimal.ZERO);
			brokenCharge.saveEx();
			DB.executeUpdateEx("DELETE FROM C_Charge_Acct WHERE C_Charge_ID=? AND C_AcctSchema_ID=?",
					new Object[] { brokenCharge.get_ID(), as.get_ID() }, getTrxName());
			CacheMgt.get().reset();

			MCostElement ce1 = createManualCostElement("AtomicFail CE1",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, validCharge.get_ID());
			MCostElement ce2 = createManualCostElement("AtomicFail CE2",
					MCostElement.COSTELEMENTTYPE_Overhead, brokenCharge.get_ID());
			createManualCostRecord(product, as, ce1, 0, new BigDecimal("5.00"), 0);
			createManualCostRecord(product, as, ce2, 0, new BigDecimal("3.00"), 0);

			MProject proj = createWorkOrderProject("AtomicFail Project");
			MProjectIssue issue = createProjectIssue(proj, product, 10, BigDecimal.ONE, getLoginDate());
			runDeferred(() -> complete(issue));
			assertFalse(issue.isPosted());

			String err = tryPostImmediate(issue);
			assertNotNull(err, "Posting with missing second charge account must fail");
			assertFalse(MManualCostDetail.hasForRecord(as.get_ID(), MProjectIssue.Table_ID, issue.get_ID(), getTrxName()),
					"Failed posting must not persist partial M_ManualCostDetail from the first charge");
		}
	}

	@Test
	public void testServiceProjectIssueReversalUsesOriginalPostedPrincipalNotCompletionCostAmt()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct serviceProd = createServiceProduct("SvcProjRevPrincipal", DictionaryIDs.M_Product_Category.STANDARD.id);
			mockProductGet(mockedProduct, serviceProd);

			MCostElement avgPoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AveragePO);
			MCost baseCost = MCost.get(serviceProd, 0, as, 0, avgPoCe.get_ID(), getTrxName());
			baseCost.setCurrentCostPrice(new BigDecimal("100.00"));
			baseCost.saveEx();

			MCostElement overheadCe = createManualCostElement("SvcProj Overhead",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			MCost manualCostRec = createManualCostRecord(serviceProd, as, overheadCe, 0, new BigDecimal("20.00"), 0);

			MProject proj = createWorkOrderProject("SvcProjRevPrincipal Project");
			MProjectIssue issue = createProjectIssue(proj, serviceProd, 10, BigDecimal.ONE, getLoginDate());

			// Complete deferred: CostAmt saved as 120.00 (100 base + 20 manual)
			runDeferred(() -> complete(issue));
			assertEquals(new BigDecimal("120.00"), issue.getCostAmt().setScale(2, RoundingMode.HALF_UP));

			// Lower manual cost to 10.00 BEFORE first posting -> original posts WIP DR 110, Expense CR 100, Charge CR 10
			manualCostRec.setCurrentCostPrice(new BigDecimal("10.00"));
			manualCostRec.saveEx();
			postImmediate(issue);

			// Reverse and post reversal -> must reverse posted facts (WIP CR 110, Expense DR 100, Charge DR 10), not 120/110
			MProjectIssue reversal = reverseAndPost(issue);

			int wipAcctId = getProjectWipAccountId(proj, as);
			ProductCost pc = new ProductCost(Env.getCtx(), serviceProd.get_ID(), 0, getTrxName());
			int expAcctId = pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as).getAccount_ID();
			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();

			List<MFactAcct> revFacts = getFacts(MProjectIssue.Table_ID, reversal.get_ID(), as.get_ID());
			assertProjectIssueReversalFactTotals(revFacts, wipAcctId, new BigDecimal("110.00"), BigDecimal.ZERO, as);
			assertProjectIssueReversalFactTotals(revFacts, expAcctId, BigDecimal.ZERO, new BigDecimal("100.00"), as);
			assertProjectIssueReversalFactTotals(revFacts, freightAcctId, BigDecimal.ZERO, new BigDecimal("10.00"), as);

			// ProjectBalanceAmt still reverses exact completion CostAmt (-120.00) -> 0.00
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP));
		}
	}

	private void assertProjectIssueReversalFactTotals(List<MFactAcct> revFacts, int accountId,
			BigDecimal origDr, BigDecimal origCr, MAcctSchema as)
	{
		if (as.isAllowNegativePosting())
			assertFactTotals(revFacts, accountId, origDr.negate(), origCr.negate());
		else
			assertFactTotals(revFacts, accountId, origCr, origDr);
	}
}
