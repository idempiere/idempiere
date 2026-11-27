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
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MFactAcct;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MTimeExpense;
import org.compiere.model.MTimeExpenseLine;
import org.compiere.model.ProductCost;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
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

			// Change Charge Ch_Expense_Acct BEFORE reversing to verify historical C_ValidCombination_ID preservation
			MAccount altAcct = MCharge.getAccount(DictionaryIDs.C_Charge.COMMISSIONS.id, as, getTrxName());
			assertNotNull(altAcct);
			DB.executeUpdateEx("UPDATE C_Charge_Acct SET Ch_Expense_Acct=? WHERE C_Charge_ID=? AND C_AcctSchema_ID=?",
					new Object[] {altAcct.get_ID(), DictionaryIDs.C_Charge.FREIGHT.id, as.get_ID()}, getTrxName());
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
			BigDecimal wipNet = BigDecimal.ZERO;
			for (MFactAcct fa : origFacts)
				if (fa.getAccount_ID() == wipAcctId)
					wipNet = wipNet.add(fa.getAmtAcctDr().subtract(fa.getAmtAcctCr()));
			for (MFactAcct fa : revFacts)
				if (fa.getAccount_ID() == wipAcctId)
					wipNet = wipNet.add(fa.getAmtAcctDr().subtract(fa.getAmtAcctCr()));
			assertEquals(0, wipNet.signum(), "Original and reversed WIP facts must net to zero");
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
	public void testUnpostedLegacyProjectIssueReversalPreservesSchemaCostingMethod()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS))
		{
			// Product category overrides schema costing method (AveragePO=100) with StandardCosting (80)
			MProductCategory stdCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			stdCat.setName("LegacyProjStdCat");
			stdCat.saveEx();
			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(stdCat.get_ID()))).thenReturn(stdCat);
			mockedCategory.when(() -> MProductCategory.get(eq(stdCat.get_ID()))).thenReturn(stdCat);

			MProductCategoryAcct stdCatAcct = MProductCategoryAcct.get(stdCat.get_ID(), as.get_ID(), getTrxName());
			stdCatAcct = new MProductCategoryAcct(Env.getCtx(), stdCatAcct, getTrxName());
			stdCatAcct.setCostingMethod(MAcctSchema.COSTINGMETHOD_StandardCosting);
			stdCatAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(stdCat.get_ID(), as.get_ID(), getTrxName());

			MProduct serviceProd = new MProduct(Env.getCtx(), 0, getTrxName());
			serviceProd.setValue("LegacySchemaMethodSvc");
			serviceProd.setName("LegacySchemaMethodSvc");
			serviceProd.setProductType(MProduct.PRODUCTTYPE_Service);
			serviceProd.setIsStocked(false);
			serviceProd.setIsPurchased(true);
			serviceProd.setIsSold(true);
			serviceProd.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			serviceProd.setM_Product_Category_ID(stdCat.get_ID());
			serviceProd.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			serviceProd.saveEx();
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

			MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
			proj.setName("Legacy Schema Costing Method Project");
			proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
			proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			proj.setPlannedAmt(Env.ONE);
			proj.setCommittedQty(Env.ONE);
			proj.saveEx();

			// 1. Simulate unposted pre-upgrade issue that added 100.00 under schema method (AveragePO), CostAmt=NULL
			MProjectIssue legacyIssue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			legacyIssue.setLine(10);
			legacyIssue.setMovementDate(getLoginDate());
			legacyIssue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			legacyIssue.setMovementQty(BigDecimal.ONE);
			legacyIssue.setC_Project_ID(proj.get_ID());
			legacyIssue.setM_Product_ID(serviceProd.get_ID());
			legacyIssue.saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				ProcessInfo info = MWorkflow.runDocumentActionWorkflow(legacyIssue, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
			}
			legacyIssue.load(getTrxName());
			assertFalse(legacyIssue.isPosted(), "Simulated pre-upgrade issue should be unposted");
			// Set legacy state: CostAmt=NULL and ProjectBalanceAmt=100.00 (pre-upgrade schema AveragePO contribution)
			DB.executeUpdateEx("UPDATE C_ProjectIssue SET CostAmt=NULL WHERE C_ProjectIssue_ID=?",
					new Object[] { legacyIssue.get_ID() }, getTrxName());
			DB.executeUpdateEx("UPDATE C_Project SET ProjectBalanceAmt=100.00 WHERE C_Project_ID=?",
					new Object[] { proj.get_ID() }, getTrxName());
			legacyIssue.load(getTrxName());

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				ProcessInfo info = MWorkflow.runDocumentActionWorkflow(legacyIssue, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}
			proj.load(getTrxName());
			assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
					"Unposted legacy reversal must use pre-upgrade schema costing method (-100.00), not product override (-80.00)");

			// 2. Verify new completion still uses product override (StandardCosting = +80.00) and reverses -80.00 via CostAmt
			MProjectIssue newIssue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
			newIssue.setLine(20);
			newIssue.setMovementDate(TimeUtil.addDays(getLoginDate(), 1));
			newIssue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			newIssue.setMovementQty(BigDecimal.ONE);
			newIssue.setC_Project_ID(proj.get_ID());
			newIssue.setM_Product_ID(serviceProd.get_ID());
			newIssue.saveEx();
			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				ProcessInfo info = MWorkflow.runDocumentActionWorkflow(newIssue, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				proj.load(getTrxName());
				assertEquals(new BigDecimal("80.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
						"New completion must use product costing method override (+80.00)");

				newIssue.load(getTrxName());
				info = MWorkflow.runDocumentActionWorkflow(newIssue, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
				proj.load(getTrxName());
				assertEquals(new BigDecimal("0.00"), proj.getProjectBalanceAmt().setScale(2, RoundingMode.HALF_UP),
						"New issue reversal must subtract exact stored CostAmt (-80.00)");
			}
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

}
