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
import org.compiere.wf.MWorkflow;
import org.idempiere.acct.base.model.MDistribution;
import org.idempiere.acct.base.model.MDistributionLine;
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
}
