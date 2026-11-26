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

import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MCharge;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
import org.compiere.model.ProductCost;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
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

	@Test
	public void testProductionReversalFailsFastWhenOriginalLineCannotBeMatched()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("ProdUnmatchComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct otherComp = createStockedProduct("ProdUnmatchOther", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct fg = createStockedProduct("ProdUnmatchFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, otherComp);
			mockProductGet(mockedProduct, fg);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createPOAndMR(otherComp, null, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProdUnmatch Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
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
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			production.load(getTrxName());
			if (!production.isPosted())
			{
				String error = DocumentEngine.postImmediate(Env.getCtx(), production.getAD_Client_ID(),
						production.get_Table_ID(), production.get_ID(), false, getTrxName());
				assertNull(error, "Original production posting failed: " + error);
			}

			// Reverse with deferred posting so we can simulate an unmatchable reversal component line
			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}

			production.load(getTrxName());
			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			assertFalse(reversal.isPosted());

			// Alter reversal component line product so loadReversalLineMap cannot match it to any original line
			int updated = DB.executeUpdateEx(
					"UPDATE M_ProductionLine SET M_Product_ID=? WHERE M_Production_ID=? AND IsEndProduct='N'",
					new Object[] { otherComp.get_ID(), reversal.get_ID() }, getTrxName());
			assertEquals(1, updated);

			String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
					reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertNotNull(error, "Posting must fail fast when a reversal production line cannot be matched");
			assertTrue(error.contains("Original Production line not matched for reversal"),
					"Unexpected error message: " + error);
			reversal.load(getTrxName());
			assertFalse(reversal.isPosted(), "Unmatched reversal production must remain unposted");
			assertEquals(0, getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID()).size(),
					"Unmatched reversal production must not post partial/unbalanced facts");
		}
	}
}
