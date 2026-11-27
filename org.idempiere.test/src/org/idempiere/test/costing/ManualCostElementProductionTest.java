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

import java.lang.reflect.Proxy;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

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
import org.compiere.model.MInOutLine;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
import org.compiere.model.MProductionLineMA;
import org.compiere.model.MProductionPlan;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CPreparedStatement;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
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
			assertTrue(revFirstError.contains(Msg.getMsg(Env.getCtx(), "Original Production not posted yet")),
					"First reversal posting error must identify unposted original production, got: " + revFirstError);
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

			// Post a real second receipt (1 unit @ 140.00) on the same date so Average PO and M_CostHistory move from 100.00 to 120.00
			createPOAndMR(comp, null, BigDecimal.ONE, new BigDecimal("140.00"));
			ProductCost datedCheckPc = new ProductCost(Env.getCtx(), comp.get_ID(), 0, getTrxName());
			datedCheckPc.setQty(BigDecimal.ONE);
			BigDecimal datedCost = datedCheckPc.getProductCosts(as, getAD_Org_ID(),
					MCostElement.COSTINGMETHOD_AveragePO, 0, false, getLoginDate(), null, false);
			assertNotNull(datedCost, "Dated valuation must be available after second receipt");
			assertEquals(new BigDecimal("120.00"), datedCost.setScale(2, RoundingMode.HALF_UP),
					"Ordinary dated valuation on reversal date must reflect drifted Average PO cost (120.00)");

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

			ProductCost compPc = new ProductCost(Env.getCtx(), comp.get_ID(), 0, getTrxName());
			int compAssetAcctId = compPc.getAccount(ProductCost.ACCTTYPE_P_Asset, as).getAccount_ID();
			List<MFactAcct> origFacts = getFacts(MProduction.Table_ID, production.get_ID(), as.get_ID());
			List<MFactAcct> revFacts = getFacts(MProduction.Table_ID, reversal.get_ID(), as.get_ID());
			BigDecimal origCompAssetCr = BigDecimal.ZERO;
			for (MFactAcct fa : origFacts)
			{
				if (fa.getLine_ID() == origCompLine.get_ID() && fa.getAccount_ID() == compAssetAcctId && fa.getC_Charge_ID() == 0)
					origCompAssetCr = origCompAssetCr.add(fa.getAmtAcctCr());
			}
			BigDecimal revCompAssetDr = BigDecimal.ZERO;
			for (MFactAcct fa : revFacts)
			{
				if (fa.getLine_ID() == revCompLine.get_ID() && fa.getAccount_ID() == compAssetAcctId && fa.getC_Charge_ID() == 0)
					revCompAssetDr = revCompAssetDr.add(fa.getAmtAcctDr());
			}
			assertEquals(new BigDecimal("100.00"), origCompAssetCr.setScale(2, RoundingMode.HALF_UP),
					"Original production component asset credit must be 100.00");
			assertEquals(new BigDecimal("100.00"), revCompAssetDr.setScale(2, RoundingMode.HALF_UP),
					"Reversal production component asset debit must be 100.00, matching revCd and offsetting original");
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
			MProduct fg = createStockedProduct("ProdLoadFailFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);
			createPOAndMR(comp, null, new BigDecimal("10"), new BigDecimal("50.00"));

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

			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setName("TwoPlan LoadFail Production");
			prod.setIsUseProductionPlan(true);
			prod.setMovementDate(getLoginDate());
			prod.setIsCreated("Y");
			prod.saveEx();

			for (int planLineNo : new int[] { 10, 20 })
			{
				MProductionPlan plan = new MProductionPlan(Env.getCtx(), 0, getTrxName());
				plan.setM_Production_ID(prod.get_ID());
				plan.setLine(planLineNo);
				plan.setM_Product_ID(fg.get_ID());
				plan.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
				plan.setProductionQty(BigDecimal.ONE);
				plan.saveEx();

				MProductionLine fgPl = new MProductionLine(plan);
				fgPl.setLine(10);
				fgPl.setM_Product_ID(fg.get_ID());
				fgPl.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
				fgPl.setIsEndProduct(true);
				fgPl.setMovementQty(BigDecimal.ONE);
				fgPl.setPlannedQty(BigDecimal.ONE);
				fgPl.saveEx();

				MProductionLine compPl = new MProductionLine(plan);
				compPl.setLine(20);
				compPl.setM_Product_ID(comp.get_ID());
				compPl.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
				compPl.setIsEndProduct(false);
				compPl.setMovementQty(BigDecimal.ONE.negate());
				compPl.setPlannedQty(BigDecimal.ONE);
				compPl.setQtyUsed(BigDecimal.ONE);
				compPl.saveEx();
			}

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(), prod.get_Table_ID(), prod.get_ID(), false, getTrxName()));

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}
			prod.load(getTrxName());
			MProduction rev = new MProduction(Env.getCtx(), prod.getReversal_ID(), getTrxName());
			assertFalse(rev.isPosted());

			// Inject SQLException during Doc_Production.loadLines after reading plan 1's two rows (before plan 2):
			// must abort posting AND unlock Processing='N'
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
															nextCalls[0]++;
															if (nextCalls[0] > 2)
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
				assertThrows(DBException.class, () -> DocumentEngine.postImmediate(Env.getCtx(), rev.getAD_Client_ID(),
						rev.get_Table_ID(), rev.get_ID(), false, getTrxName()),
						"Current-line load failure after partial read must abort posting instead of replaying partial lines");
			}

			rev.load(getTrxName());
			assertFalse(rev.isPosted(), "Failed reversal load must leave production unposted");
			assertFalse(rev.isProcessing(), "Doc.post() must unlock Processing='N' when loadDocumentDetails() throws");
			assertEquals(0, getFacts(MProduction.Table_ID, rev.get_ID(), as.get_ID()).size(),
					"Failed reversal load must not post partial facts");

			// Subsequent non-forced retry must succeed and reverse both plans completely
			String retryErr = DocumentEngine.postImmediate(Env.getCtx(), rev.getAD_Client_ID(),
					rev.get_Table_ID(), rev.get_ID(), false, getTrxName());
			assertNull(retryErr, "Retry after unlocked load failure must succeed without force: " + retryErr);
			assertEquals(getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID()).size(),
					getFacts(MProduction.Table_ID, rev.get_ID(), as.get_ID()).size(),
					"Retry must reverse all facts from both plans");
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
			MProduct fg = createStockedProduct("TiedPlanFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, compA);
			mockProductGet(mockedProduct, compB);
			mockProductGet(mockedProduct, fg);

			createPOAndMR(compA, null, new BigDecimal("5"), new BigDecimal("100.00"));
			createPOAndMR(compB, null, new BigDecimal("5"), new BigDecimal("200.00"));
			MCostElement burdenCe = createManualCostElement("TiedPlan Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(compA, as, burdenCe, 0, BigDecimal.ZERO, 10);
			createManualCostRecord(compB, as, burdenCe, 0, BigDecimal.ZERO, 10);

			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(fg.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(fg.getName());
			bom.saveEx();
			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(compA.get_ID());
			bomLine.setQtyBOM(BigDecimal.ONE);
			bomLine.saveEx();
			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			// Two plans with the SAME Line=10, FG product, locator, and qty, but different component costs (100 vs 200)
			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setName("TiedPlanLineNo Production");
			prod.setIsUseProductionPlan(true);
			prod.setMovementDate(getLoginDate());
			prod.setIsCreated("Y");
			prod.saveEx();

			MProductionPlan plan1 = new MProductionPlan(Env.getCtx(), 0, getTrxName());
			plan1.setM_Production_ID(prod.get_ID());
			plan1.setLine(10);
			plan1.setM_Product_ID(fg.get_ID());
			plan1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan1.setProductionQty(BigDecimal.ONE);
			plan1.saveEx();
			MProductionLine fg1 = new MProductionLine(plan1);
			fg1.setLine(10);
			fg1.setM_Product_ID(fg.get_ID());
			fg1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fg1.setIsEndProduct(true);
			fg1.setMovementQty(BigDecimal.ONE);
			fg1.setPlannedQty(BigDecimal.ONE);
			fg1.saveEx();
			MProductionLine c1 = new MProductionLine(plan1);
			c1.setLine(20);
			c1.setM_Product_ID(compA.get_ID());
			c1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			c1.setIsEndProduct(false);
			c1.setMovementQty(BigDecimal.ONE.negate());
			c1.setPlannedQty(BigDecimal.ONE);
			c1.setQtyUsed(BigDecimal.ONE);
			c1.saveEx();

			MProductionPlan plan2 = new MProductionPlan(Env.getCtx(), 0, getTrxName());
			plan2.setM_Production_ID(prod.get_ID());
			plan2.setLine(10);
			plan2.setM_Product_ID(fg.get_ID());
			plan2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan2.setProductionQty(BigDecimal.ONE);
			plan2.saveEx();
			MProductionLine fg2 = new MProductionLine(plan2);
			fg2.setLine(10);
			fg2.setM_Product_ID(fg.get_ID());
			fg2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fg2.setIsEndProduct(true);
			fg2.setMovementQty(BigDecimal.ONE);
			fg2.setPlannedQty(BigDecimal.ONE);
			fg2.saveEx();
			MProductionLine c2 = new MProductionLine(plan2);
			c2.setLine(20);
			c2.setM_Product_ID(compB.get_ID());
			c2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			c2.setIsEndProduct(false);
			c2.setMovementQty(BigDecimal.ONE.negate());
			c2.setPlannedQty(BigDecimal.ONE);
			c2.setQtyUsed(BigDecimal.ONE);
			c2.saveEx();

			// Update plan1 to perturb physical heap order in PostgreSQL
			plan1.setDescription("Plan 1 updated");
			plan1.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(), prod.get_Table_ID(), prod.get_ID(), false, getTrxName()));

			info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			MProduction rev = new MProduction(Env.getCtx(), prod.getReversal_ID(), getTrxName());
			if (!rev.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), rev.getAD_Client_ID(), rev.get_Table_ID(), rev.get_ID(), false, getTrxName()));

			List<MProductionPlan> revPlans = new org.compiere.model.Query(Env.getCtx(), MProductionPlan.Table_Name,
					"M_Production_ID=?", getTrxName())
					.setParameters(rev.get_ID())
					.setOrderBy("Line, M_ProductionPlan_ID")
					.list();
			assertEquals(2, revPlans.size());
			MProductionLine revFg1 = revPlans.get(0).getLines()[0];
			MProductionLine revFg2 = revPlans.get(1).getLines()[0];
			MCostDetail revFgCd1 = MCostDetail.getProduction(as, fg.get_ID(), 0, revFg1.get_ID(), 0, getTrxName());
			MCostDetail revFgCd2 = MCostDetail.getProduction(as, fg.get_ID(), 0, revFg2.get_ID(), 0, getTrxName());
			assertNotNull(revFgCd1);
			assertNotNull(revFgCd2);
			assertEquals(new BigDecimal("-110.00"), revFgCd1.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Reversal plan 1 FG cost detail must match original plan 1 (-110.00)");
			assertEquals(new BigDecimal("-220.00"), revFgCd2.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Reversal plan 2 FG cost detail must match original plan 2 (-220.00)");
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
			MProductCategory batchCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			batchCat.setName("ProdMaRevBatchCat");
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
			lotAs.setName("ProdMaRevLotAS");
			lotAs.setIsLot(true);
			lotAs.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			lotAs.saveEx();
			MAttributeSet lotAsSpy = Mockito.spy(lotAs);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MOrderLine.Table_ID, true);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MInOutLine.Table_ID, true);
			mockedAttrSet.when(() -> MAttributeSet.getCopy(any(Properties.class), eq(lotAs.get_ID()), any())).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(any(Properties.class), eq(lotAs.get_ID()))).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(eq(lotAs.get_ID()))).thenReturn(lotAsSpy);

			MProduct comp = createStockedProduct("ProdMaRevComp", batchCat.get_ID(), lotAs.get_ID());
			MProduct fg = createStockedProduct("ProdMaRevFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			MAttributeSetInstance lot1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			lot1.setM_AttributeSet_ID(lotAs.get_ID());
			lot1.setLot("LOT-MA-REV-1");
			lot1.setDescription();
			lot1.saveEx();
			createPOAndMR(comp, lot1, new BigDecimal("5"), new BigDecimal("100.00"));

			MCostElement burdenCe = createManualCostElement("ProdMaRev Burden 10pct",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, burdenCe, lot1.get_ID(), BigDecimal.ZERO, 10);

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

			// Original component line has ASI=0 and consumes stock via M_ProductionLineMA
			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setM_Product_ID(fg.get_ID());
			prod.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prod.setProductionQty(BigDecimal.ONE);
			prod.setMovementDate(getLoginDate());
			prod.saveEx();

			MProcess process = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.CREATE_UPDATE_PRODUCTION_LINES.id);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(prod.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			prod.load(getTrxName());
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
				assertNull(DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(), prod.get_Table_ID(), prod.get_ID(), false, getTrxName()));

			MProductionLine origCompLine = null;
			for (MProductionLine pl : prod.getLines())
				if (!pl.isEndProduct())
					origCompLine = pl;
			assertNotNull(origCompLine);
			assertEquals(0, origCompLine.getM_AttributeSetInstance_ID(), "Original component line should have ASI=0 with MA allocation");
			assertTrue(MProductionLineMA.get(Env.getCtx(), origCompLine.get_ID(), getTrxName()).length > 0);

			// Reverse: MProductionLine.createTransactions() assigns nonzero lot1 ASI onto the reversal component line
			info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			MProduction rev = new MProduction(Env.getCtx(), prod.getReversal_ID(), getTrxName());
			MProductionLine revCompLine = null;
			for (MProductionLine pl : rev.getLines())
				if (!pl.isEndProduct())
					revCompLine = pl;
			assertNotNull(revCompLine);
			assertEquals(lot1.get_ID(), revCompLine.getM_AttributeSetInstance_ID(),
					"MProductionLine.createTransactions() assigns lot ASI onto reversal component line");

			if (!rev.isPosted())
			{
				String revErr = DocumentEngine.postImmediate(Env.getCtx(), rev.getAD_Client_ID(),
						rev.get_Table_ID(), rev.get_ID(), false, getTrxName());
				assertNull(revErr, "BatchLot allocated component reversal must match original ASI=0 line and post: " + revErr);
			}

			int freightAcctId = MCharge.getAccount(DictionaryIDs.C_Charge.FREIGHT.id, as, getTrxName()).getAccount_ID();
			assertFactTotals(getFacts(MProduction.Table_ID, rev.get_ID(), as.get_ID()), freightAcctId, new BigDecimal("20.00"), BigDecimal.ZERO);
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
			MProduct fg = createStockedProduct("MultiFgEnd", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			// Fixed manual charge of 0.01 makes total component credit 100.01 across two FG lines of qty 1
			MCostElement overheadCe = createManualCostElement("MultiFg Penny Charge",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, overheadCe, 0, new BigDecimal("0.01"), 0);

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

			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setM_Product_ID(fg.get_ID());
			prod.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prod.setProductionQty(new BigDecimal("2"));
			prod.setMovementDate(getLoginDate());
			prod.setIsCreated("Y");
			prod.saveEx();

			MProductionLine fgLine1 = new MProductionLine(prod);
			fgLine1.setLine(10);
			fgLine1.setM_Product_ID(fg.get_ID());
			fgLine1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fgLine1.setIsEndProduct(true);
			fgLine1.setMovementQty(BigDecimal.ONE);
			fgLine1.setPlannedQty(BigDecimal.ONE);
			fgLine1.saveEx();

			MProductionLine fgLine2 = new MProductionLine(prod);
			fgLine2.setLine(20);
			fgLine2.setM_Product_ID(fg.get_ID());
			fgLine2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fgLine2.setIsEndProduct(true);
			fgLine2.setMovementQty(BigDecimal.ONE);
			fgLine2.setPlannedQty(BigDecimal.ONE);
			fgLine2.saveEx();

			MProductionLine compLine = new MProductionLine(prod);
			compLine.setLine(30);
			compLine.setM_Product_ID(comp.get_ID());
			compLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			compLine.setIsEndProduct(false);
			compLine.setMovementQty(BigDecimal.ONE.negate());
			compLine.setPlannedQty(BigDecimal.ONE);
			compLine.setQtyUsed(BigDecimal.ONE);
			compLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(),
						prod.get_Table_ID(), prod.get_ID(), false, getTrxName());
				assertNull(err, "Multi-FG production posting failed: " + err);
			}

			List<MFactAcct> facts = getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID());
			int suspenseAcctId = as.getSuspenseBalancing_Acct().getAccount_ID();
			assertFactTotals(facts, suspenseAcctId, BigDecimal.ZERO, BigDecimal.ZERO);

			BigDecimal fgDrTotal = BigDecimal.ZERO;
			for (MFactAcct fa : facts)
			{
				if (fa.getM_Product_ID() == fg.get_ID())
					fgDrTotal = fgDrTotal.add(fa.getAmtAcctDr());
			}
			assertEquals(new BigDecimal("100.01"), fgDrTotal.setScale(2, RoundingMode.HALF_UP),
					"Two FG lines must sum to exact 100.01 (50.01 + 50.00), not 100.02");

			MCostDetail fgCd1 = MCostDetail.getProduction(as, fg.get_ID(), 0, fgLine1.get_ID(), 0, getTrxName());
			MCostDetail fgCd2 = MCostDetail.getProduction(as, fg.get_ID(), 0, fgLine2.get_ID(), 0, getTrxName());
			assertNotNull(fgCd1);
			assertNotNull(fgCd2);
			assertEquals(new BigDecimal("50.01"), fgCd1.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("50.00"), fgCd2.getAmt().setScale(2, RoundingMode.HALF_UP));
		}
	}


	@Test
	public void testNonManualProductionReversalDoesNotBlockUnpostedOriginalAndLinksReversalLines()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		assertEquals(MCostElement.COSTINGMETHOD_AveragePO, as.getCostingMethod(), "Default costing method not Average PO");
		assertFalse(MCost.hasChargeManualCostElements(getAD_Client_ID(), getTrxName()),
				"Precondition: no charge-mapped manual cost elements configured");

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS))
		{
			MProduct comp = createStockedProduct("NonManualProdComp", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			MProduct fg = createStockedProduct("NonManualProdFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("100.00"));
			// Seed initial FG stock so AveragePO allows posting the -1 reversal ahead of the +1 original
			createPOAndMR(fg, null, new BigDecimal("2"), new BigDecimal("200.00"));

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

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				production.load(getTrxName());
				ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}

			production.load(getTrxName());
			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			assertFalse(production.isPosted());
			assertFalse(reversal.isPosted());

			// Verify bidirectional M_ProductionLine.ReversalLine_ID linkage
			MProductionLine[] origLines = production.getLines();
			MProductionLine[] revLines = reversal.getLines();
			assertEquals(origLines.length, revLines.length);
			for (MProductionLine revLine : revLines)
			{
				assertTrue(revLine.getReversalLine_ID() > 0, "Reversal M_ProductionLine must set ReversalLine_ID");
				MProductionLine matchedOrig = new MProductionLine(Env.getCtx(), revLine.getReversalLine_ID(), getTrxName());
				assertEquals(revLine.getM_ProductionLine_ID(), matchedOrig.getReversalLine_ID(),
						"Original M_ProductionLine must link back to reversal line");
			}

			// Without charge-mapped manual cost elements, posting reversal before original must NOT be blocked
			String revErr = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(),
					reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertNull(revErr, "Non-manual production reversal must not block on unposted original: " + revErr);
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
			MProduct fg = createStockedProduct("SixFgSignFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			// Material cost 0.06 + fixed manual charge 0.03 = 0.09 split across 6 equal FG lines of qty 1
			createPOAndMR(comp, null, new BigDecimal("5"), new BigDecimal("0.06"));
			MCostElement overheadCe = createManualCostElement("SixFg Overhead 0.03",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, overheadCe, 0, new BigDecimal("0.03"), 0);

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

			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setName("Six FG Rounding Production");
			prod.setM_Product_ID(fg.get_ID());
			prod.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prod.setIsUseProductionPlan(false);
			prod.setMovementDate(getLoginDate());
			prod.setIsCreated("Y");
			prod.setProductionQty(new BigDecimal("6"));
			prod.saveEx();

			List<MProductionLine> fgLines = new ArrayList<>();
			for (int k = 1; k <= 6; k++)
			{
				MProductionLine fgLine = new MProductionLine(prod);
				fgLine.setLine(k * 10);
				fgLine.setM_Product_ID(fg.get_ID());
				fgLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
				fgLine.setIsEndProduct(true);
				fgLine.setMovementQty(BigDecimal.ONE);
				fgLine.setPlannedQty(BigDecimal.ONE);
				fgLine.saveEx();
				fgLines.add(fgLine);
			}
			MProductionLine compLine = new MProductionLine(prod);
			compLine.setLine(70);
			compLine.setM_Product_ID(comp.get_ID());
			compLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			compLine.setIsEndProduct(false);
			compLine.setQtyUsed(BigDecimal.ONE);
			compLine.setMovementQty(BigDecimal.ONE.negate());
			compLine.setPlannedQty(BigDecimal.ONE);
			compLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(),
						prod.get_Table_ID(), prod.get_ID(), false, getTrxName());
				assertNull(err, "Six-FG production posting failed: " + err);
			}

			List<MFactAcct> facts = getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID());
			BigDecimal totalFgDr = BigDecimal.ZERO;
			for (MProductionLine fgLine : fgLines)
			{
				MCostDetail cd = MCostDetail.getProduction(as, fg.get_ID(), 0, fgLine.get_ID(), 0, getTrxName());
				assertNotNull(cd, "FG MCostDetail missing for line " + fgLine.getLine());
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
				assertTrue(lineDr.signum() > 0 && lineCr.signum() == 0,
						"FG receipt line " + fgLine.getLine() + " must debit inventory (never credit): DR=" + lineDr + ", CR=" + lineCr);
				totalFgDr = totalFgDr.add(lineDr);
			}
			assertEquals(new BigDecimal("0.09"), totalFgDr.setScale(2, RoundingMode.HALF_UP),
					"Total FG inventory debit across all 6 lines must equal 0.09");
		}
	}

	@Test
	public void testFifoMultiComponentAndMultiFgProductionRollupAndPercentCharge()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory fifoCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			fifoCat.setName("ProdFifoCat");
			fifoCat.saveEx();
			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(fifoCat.get_ID()))).thenReturn(fifoCat);
			mockedCategory.when(() -> MProductCategory.get(eq(fifoCat.get_ID()))).thenReturn(fifoCat);

			MProductCategoryAcct fifoAcct = MProductCategoryAcct.get(fifoCat.get_ID(), as.get_ID(), getTrxName());
			fifoAcct = new MProductCategoryAcct(Env.getCtx(), fifoAcct, getTrxName());
			fifoAcct.setCostingMethod(MCostElement.COSTINGMETHOD_Fifo);
			fifoAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(fifoCat.get_ID(), as.get_ID(), getTrxName());

			MProduct comp = createStockedProduct("ProdFifoComp", fifoCat.get_ID(), 0);
			MProduct fg = createStockedProduct("ProdFifoFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			// Two distinct FIFO layers: asi1 (lower ID) qty 1 @ 1000.00, then asi2 (higher ID) qty 1 @ 1200.00
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("PROD-FIFO-L1");
			asi1.setDescription();
			asi1.saveEx();

			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi2.setLot("PROD-FIFO-L2");
			asi2.setDescription();
			asi2.saveEx();
			assertTrue(asi1.get_ID() < asi2.get_ID(), "Expected first ASI to have lower ID for FIFO ordering");

			assertTrue(MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, comp.get_ID(), 0,
					new BigDecimal("2"), getLoginDate(), getTrxName()), "Failed to add FIFO component stock");

			MCost.CostingKey key = MCost.CostingKey.resolve(getAD_Org_ID(), 0, comp.getCostingLevel(as));
			MCostElement fifoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_Fifo);
			MCost fifoCost = MCost.get(comp, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), fifoCe.get_ID(), getTrxName());
			fifoCost.setCurrentCostPrice(new BigDecimal("1000.00"));
			fifoCost.setCurrentQty(new BigDecimal("2"));
			fifoCost.saveEx();

			MCostElement avgPoCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AveragePO);
			MCost avgPoCost = MCost.get(comp, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgPoCe.get_ID(), getTrxName());
			avgPoCost.setCurrentCostPrice(new BigDecimal("1100.00"));
			avgPoCost.setCurrentQty(new BigDecimal("2"));
			avgPoCost.saveEx();

			MCostElement avgInvCe = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AverageInvoice);
			if (avgInvCe != null)
			{
				MCost avgInvCost = MCost.get(comp, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), avgInvCe.get_ID(), getTrxName());
				avgInvCost.setCurrentCostPrice(new BigDecimal("1100.00"));
				avgInvCost.setCurrentQty(new BigDecimal("2"));
				avgInvCost.saveEx();
			}

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
				{
					MCost secCost = MCost.get(comp, secKey.M_AttributeSetInstance_ID(), clientAs, secKey.AD_Org_ID(),
							secCe.get_ID(), getTrxName());
					secCost.setCurrentCostPrice(new BigDecimal("1000.00"));
					secCost.setCurrentQty(new BigDecimal("2"));
					secCost.saveEx();
				}
			}

			MCostElement burdenCe = createManualCostElement("ProdFifo Burden 10pct",
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
			bomLine.setQtyBOM(BigDecimal.ONE);
			bomLine.saveEx();
			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setName("FIFO Multi-Comp Multi-FG Production");
			prod.setM_Product_ID(fg.get_ID());
			prod.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prod.setIsUseProductionPlan(false);
			prod.setMovementDate(getLoginDate());
			prod.setIsCreated("Y");
			prod.setProductionQty(new BigDecimal("100000"));
			prod.saveEx();

			// Put two 1-unit FIFO component issues between two FG output lines (1 and 99,999 units)
			MProductionLine fgLine1 = new MProductionLine(prod);
			fgLine1.setLine(10);
			fgLine1.setM_Product_ID(fg.get_ID());
			fgLine1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fgLine1.setIsEndProduct(true);
			fgLine1.setMovementQty(BigDecimal.ONE);
			fgLine1.setPlannedQty(BigDecimal.ONE);
			fgLine1.saveEx();

			MProductionLine compLine1 = new MProductionLine(prod);
			compLine1.setLine(20);
			compLine1.setM_Product_ID(comp.get_ID());
			compLine1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			compLine1.setIsEndProduct(false);
			compLine1.setQtyUsed(BigDecimal.ONE);
			compLine1.setMovementQty(BigDecimal.ONE.negate());
			compLine1.setPlannedQty(BigDecimal.ONE);
			compLine1.saveEx();

			MProductionLine compLine2 = new MProductionLine(prod);
			compLine2.setLine(30);
			compLine2.setM_Product_ID(comp.get_ID());
			compLine2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			compLine2.setIsEndProduct(false);
			compLine2.setQtyUsed(BigDecimal.ONE);
			compLine2.setMovementQty(BigDecimal.ONE.negate());
			compLine2.setPlannedQty(BigDecimal.ONE);
			compLine2.saveEx();

			MProductionLine fgLine2 = new MProductionLine(prod);
			fgLine2.setLine(40);
			fgLine2.setM_Product_ID(fg.get_ID());
			fgLine2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fgLine2.setIsEndProduct(true);
			fgLine2.setMovementQty(new BigDecimal("99999"));
			fgLine2.setPlannedQty(new BigDecimal("99999"));
			fgLine2.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(),
						prod.get_Table_ID(), prod.get_ID(), false, getTrxName());
				assertNull(err, "FIFO multi-component production posting failed: " + err);
			}

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
			assertEquals(new BigDecimal("120.00"), comp2ChargeCr.setScale(2, RoundingMode.HALF_UP),
					"Second FIFO issue percentage charge must use 1200.00 layer valuation (120.00), not stale 100.00");
			assertFactTotals(facts, freightAcctId, BigDecimal.ZERO, new BigDecimal("220.00"));
			assertEquals(new BigDecimal("2420.00"), fg1Dr.add(fg2Dr).setScale(2, RoundingMode.HALF_UP),
					"Allocated FG debits must sum to exact finalized component material + charge total (2420.00)");
			assertEquals(totalDr.setScale(2, RoundingMode.HALF_UP), totalCr.setScale(2, RoundingMode.HALF_UP),
					"Production posting must balance with no suspense");
		}
		finally
		{
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		}
	}

	@Test
	public void testBatchLotMultiFgUsesLineQtyAndUnrelatedLotChargeDoesNotBlockReversal()
	{
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MAttributeSet> mockedAttrSet = mockStatic(MAttributeSet.class, Mockito.CALLS_REAL_METHODS))
		{
			MProductCategory batchCat = new MProductCategory(Env.getCtx(), 0, getTrxName());
			batchCat.setName("ProdBatchQtyCat");
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
			lotAs.setName("ProdBatchQtyLotAS");
			lotAs.setIsLot(true);
			lotAs.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			lotAs.saveEx();
			MAttributeSet lotAsSpy = Mockito.spy(lotAs);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MOrderLine.Table_ID, true);
			Mockito.doReturn(true).when(lotAsSpy).excludeTableEntry(MInOutLine.Table_ID, true);
			mockedAttrSet.when(() -> MAttributeSet.getCopy(any(Properties.class), eq(lotAs.get_ID()), any())).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(any(Properties.class), eq(lotAs.get_ID()))).thenReturn(lotAsSpy);
			mockedAttrSet.when(() -> MAttributeSet.get(eq(lotAs.get_ID()))).thenReturn(lotAsSpy);

			MProduct comp = createStockedProduct("ProdBatchQtyComp", batchCat.get_ID(), lotAs.get_ID());
			MProduct fg = createStockedProduct("ProdBatchQtyFG", batchCat.get_ID(), lotAs.get_ID());
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, comp);
			mockProductGet(mockedProduct, fg);

			MAttributeSetInstance compLotA = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			compLotA.setM_AttributeSet_ID(lotAs.get_ID());
			compLotA.setLot("COMP-LOT-A");
			compLotA.setDescription();
			compLotA.saveEx();

			MAttributeSetInstance compLotB = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			compLotB.setM_AttributeSet_ID(lotAs.get_ID());
			compLotB.setLot("COMP-LOT-B");
			compLotB.setDescription();
			compLotB.saveEx();

			MAttributeSetInstance fgLot1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			fgLot1.setM_AttributeSet_ID(lotAs.get_ID());
			fgLot1.setLot("FG-LOT-1");
			fgLot1.setDescription();
			fgLot1.saveEx();

			MAttributeSetInstance fgLot2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			fgLot2.setM_AttributeSet_ID(lotAs.get_ID());
			fgLot2.setLot("FG-LOT-2");
			fgLot2.setDescription();
			fgLot2.saveEx();

			createPOAndMR(comp, compLotA, new BigDecimal("5"), new BigDecimal("50.00"));
			createPOAndMR(comp, compLotB, new BigDecimal("5"), new BigDecimal("50.00"));

			// Attach manual charge ONLY to unrelated compLotB (compLotA has NO charge record)
			MCostElement overheadCe = createManualCostElement("ProdBatchQty Unrelated Overhead",
					MCostElement.COSTELEMENTTYPE_Overhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(comp, as, overheadCe, compLotB.get_ID(), new BigDecimal("10.00"), 0);

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

			// 1. Multi-FG Batch/Lot production: 2 FG lines of qty 1 each consuming 2 units of compLotA (@ 50 = 100)
			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setName("BatchLot Multi-FG Qty Production");
			prod.setM_Product_ID(fg.get_ID());
			prod.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prod.setIsUseProductionPlan(false);
			prod.setMovementDate(getLoginDate());
			prod.setIsCreated("Y");
			prod.setProductionQty(new BigDecimal("2"));
			prod.saveEx();

			MProductionLine fgLine1 = new MProductionLine(prod);
			fgLine1.setLine(10);
			fgLine1.setM_Product_ID(fg.get_ID());
			fgLine1.setM_AttributeSetInstance_ID(fgLot1.get_ID());
			fgLine1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fgLine1.setIsEndProduct(true);
			fgLine1.setMovementQty(BigDecimal.ONE);
			fgLine1.setPlannedQty(BigDecimal.ONE);
			fgLine1.saveEx();

			MProductionLine fgLine2 = new MProductionLine(prod);
			fgLine2.setLine(20);
			fgLine2.setM_Product_ID(fg.get_ID());
			fgLine2.setM_AttributeSetInstance_ID(fgLot2.get_ID());
			fgLine2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fgLine2.setIsEndProduct(true);
			fgLine2.setMovementQty(BigDecimal.ONE);
			fgLine2.setPlannedQty(BigDecimal.ONE);
			fgLine2.saveEx();

			MProductionLine compLine = new MProductionLine(prod);
			compLine.setLine(30);
			compLine.setM_Product_ID(comp.get_ID());
			compLine.setM_AttributeSetInstance_ID(compLotA.get_ID());
			compLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			compLine.setIsEndProduct(false);
			compLine.setQtyUsed(new BigDecimal("2"));
			compLine.setMovementQty(new BigDecimal("-2"));
			compLine.setPlannedQty(new BigDecimal("2"));
			compLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(),
						prod.get_Table_ID(), prod.get_ID(), false, getTrxName());
				assertNull(err, "BatchLot multi-FG production posting failed: " + err);
			}

			MCostDetail fgCd1 = MCostDetail.getProduction(as, fg.get_ID(), fgLot1.get_ID(), fgLine1.get_ID(), 0, getTrxName());
			MCostDetail fgCd2 = MCostDetail.getProduction(as, fg.get_ID(), fgLot2.get_ID(), fgLine2.get_ID(), 0, getTrxName());
			assertNotNull(fgCd1);
			assertNotNull(fgCd2);
			assertEquals(0, BigDecimal.ONE.compareTo(fgCd1.getQty()), "FG line 1 M_CostDetail must use line qty (1), not group qtyProduced (2)");
			assertEquals(0, BigDecimal.ONE.compareTo(fgCd2.getQty()), "FG line 2 M_CostDetail must use line qty (1), not group qtyProduced (2)");
			assertEquals(new BigDecimal("50.00"), fgCd1.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("50.00"), fgCd2.getAmt().setScale(2, RoundingMode.HALF_UP));

			List<MFactAcct> facts = getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID());
			for (MFactAcct fa : facts)
			{
				if (fa.getLine_ID() == fgLine1.get_ID() || fa.getLine_ID() == fgLine2.get_ID())
					assertEquals(0, BigDecimal.ONE.compareTo(fa.getQty()), "BatchLot FG Fact_Acct must use line qty (1), not group qtyProduced (2)");
			}

			// 2. Unrelated compLotB charge must NOT block reversal of a compLotA production when original is unposted
			MProduction prod2 = new MProduction(Env.getCtx(), 0, getTrxName());
			prod2.setName("BatchLot Unrelated Charge Production");
			prod2.setM_Product_ID(fg.get_ID());
			prod2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			prod2.setIsUseProductionPlan(false);
			prod2.setMovementDate(getLoginDate());
			prod2.setIsCreated("Y");
			prod2.setProductionQty(BigDecimal.ONE);
			prod2.saveEx();

			MProductionLine fgLine = new MProductionLine(prod2);
			fgLine.setLine(10);
			fgLine.setM_Product_ID(fg.get_ID());
			fgLine.setM_AttributeSetInstance_ID(fgLot1.get_ID());
			fgLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			fgLine.setIsEndProduct(true);
			fgLine.setMovementQty(BigDecimal.ONE);
			fgLine.setPlannedQty(BigDecimal.ONE);
			fgLine.saveEx();

			MProductionLine compLineA = new MProductionLine(prod2);
			compLineA.setLine(20);
			compLineA.setM_Product_ID(comp.get_ID());
			compLineA.setM_AttributeSetInstance_ID(compLotA.get_ID());
			compLineA.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			compLineA.setIsEndProduct(false);
			compLineA.setQtyUsed(BigDecimal.ONE);
			compLineA.setMovementQty(BigDecimal.ONE.negate());
			compLineA.setPlannedQty(BigDecimal.ONE);
			compLineA.saveEx();

			try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
			{
				mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
				info = MWorkflow.runDocumentActionWorkflow(prod2, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				info = MWorkflow.runDocumentActionWorkflow(prod2, DocAction.ACTION_Reverse_Correct);
				assertFalse(info.isError(), info.getSummary());
			}
			prod2.load(getTrxName());
			MProduction rev2 = new MProduction(Env.getCtx(), prod2.getReversal_ID(), getTrxName());
			assertFalse(prod2.isPosted());
			String revErr = DocumentEngine.postImmediate(Env.getCtx(), rev2.getAD_Client_ID(),
					rev2.get_Table_ID(), rev2.get_ID(), false, getTrxName());
			assertNull(revErr, "Unrelated lot charge on compLotB must not block reversal of compLotA production: " + revErr);
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
			MProduct subAsm = createStockedProduct("MultiPlanSubAsm", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			subAsm.setIsBOM(true);
			subAsm.saveEx();
			MProduct fg = createStockedProduct("MultiPlanFG", DictionaryIDs.M_Product_Category.STANDARD.id, 0);
			fg.setIsBOM(true);
			fg.saveEx();
			mockProductGet(mockedProduct, rawMat);
			mockProductGet(mockedProduct, subAsm);
			mockProductGet(mockedProduct, fg);

			// Raw material received at 100.00 + 10.00 manual freight charge -> sub-assembly must roll up to 110.00
			createPOAndMR(rawMat, null, BigDecimal.ONE, new BigDecimal("100.00"));
			MCostElement freightCe = createManualCostElement("MultiPlan Freight 10",
					MCostElement.COSTELEMENTTYPE_BurdenMOverhead, DictionaryIDs.C_Charge.FREIGHT.id);
			createManualCostRecord(rawMat, as, freightCe, 0, new BigDecimal("10.00"), 0);

			MPPProductBOM subBom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			subBom.setM_Product_ID(subAsm.get_ID());
			subBom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			subBom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			subBom.setName(subAsm.getName());
			subBom.saveEx();
			MPPProductBOMLine subBomLine = new MPPProductBOMLine(subBom);
			subBomLine.setM_Product_ID(rawMat.get_ID());
			subBomLine.setQtyBOM(BigDecimal.ONE);
			subBomLine.saveEx();
			subAsm.load(getTrxName());
			subAsm.setIsVerified(true);
			subAsm.saveEx();

			MPPProductBOM fgBom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			fgBom.setM_Product_ID(fg.get_ID());
			fgBom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			fgBom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			fgBom.setName(fg.getName());
			fgBom.saveEx();
			MPPProductBOMLine fgBomLine = new MPPProductBOMLine(fgBom);
			fgBomLine.setM_Product_ID(subAsm.get_ID());
			fgBomLine.setQtyBOM(BigDecimal.ONE);
			fgBomLine.saveEx();
			fg.load(getTrxName());
			fg.setIsVerified(true);
			fg.saveEx();

			MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
			prod.setName("MultiPlan SubAssembly Production");
			prod.setIsUseProductionPlan(true);
			prod.setMovementDate(getLoginDate());
			prod.setIsCreated("Y");
			prod.saveEx();

			// Plan 10 produces subAsm (no prior cost) from rawMat (FG line listed before component line)
			MProductionPlan plan1 = new MProductionPlan(Env.getCtx(), 0, getTrxName());
			plan1.setM_Production_ID(prod.get_ID());
			plan1.setLine(10);
			plan1.setM_Product_ID(subAsm.get_ID());
			plan1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan1.setProductionQty(BigDecimal.ONE);
			plan1.saveEx();

			MProductionLine plan1Fg = new MProductionLine(plan1);
			plan1Fg.setLine(10);
			plan1Fg.setM_Product_ID(subAsm.get_ID());
			plan1Fg.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan1Fg.setIsEndProduct(true);
			plan1Fg.setMovementQty(BigDecimal.ONE);
			plan1Fg.setPlannedQty(BigDecimal.ONE);
			plan1Fg.saveEx();

			MProductionLine plan1Comp = new MProductionLine(plan1);
			plan1Comp.setLine(20);
			plan1Comp.setM_Product_ID(rawMat.get_ID());
			plan1Comp.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan1Comp.setIsEndProduct(false);
			plan1Comp.setQtyUsed(BigDecimal.ONE);
			plan1Comp.setMovementQty(BigDecimal.ONE.negate());
			plan1Comp.setPlannedQty(BigDecimal.ONE);
			plan1Comp.saveEx();

			// Plan 20 consumes subAsm produced in Plan 10 to produce fg
			MProductionPlan plan2 = new MProductionPlan(Env.getCtx(), 0, getTrxName());
			plan2.setM_Production_ID(prod.get_ID());
			plan2.setLine(20);
			plan2.setM_Product_ID(fg.get_ID());
			plan2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan2.setProductionQty(BigDecimal.ONE);
			plan2.saveEx();

			MProductionLine plan2Fg = new MProductionLine(plan2);
			plan2Fg.setLine(10);
			plan2Fg.setM_Product_ID(fg.get_ID());
			plan2Fg.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan2Fg.setIsEndProduct(true);
			plan2Fg.setMovementQty(BigDecimal.ONE);
			plan2Fg.setPlannedQty(BigDecimal.ONE);
			plan2Fg.saveEx();

			MProductionLine plan2Comp = new MProductionLine(plan2);
			plan2Comp.setLine(20);
			plan2Comp.setM_Product_ID(subAsm.get_ID());
			plan2Comp.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			plan2Comp.setIsEndProduct(false);
			plan2Comp.setQtyUsed(BigDecimal.ONE);
			plan2Comp.setMovementQty(BigDecimal.ONE.negate());
			plan2Comp.setPlannedQty(BigDecimal.ONE);
			plan2Comp.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(prod, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			prod.load(getTrxName());
			if (!prod.isPosted())
			{
				String err = DocumentEngine.postImmediate(Env.getCtx(), prod.getAD_Client_ID(),
						prod.get_Table_ID(), prod.get_ID(), false, getTrxName());
				assertNull(err, "Multi-plan sub-assembly production posting failed: " + err);
			}

			MCostDetail subInCd = MCostDetail.getProduction(as, subAsm.get_ID(), 0, plan1Fg.get_ID(), 0, getTrxName());
			MCostDetail subOutCd = MCostDetail.getProduction(as, subAsm.get_ID(), 0, plan2Comp.get_ID(), 0, getTrxName());
			MCostDetail fgInCd = MCostDetail.getProduction(as, fg.get_ID(), 0, plan2Fg.get_ID(), 0, getTrxName());
			assertNotNull(subInCd, "Plan 10 sub-assembly FG M_CostDetail missing");
			assertNotNull(subOutCd, "Plan 20 sub-assembly component M_CostDetail missing");
			assertNotNull(fgInCd, "Plan 20 FG M_CostDetail missing");
			assertEquals(new BigDecimal("110.00"), subInCd.getAmt().setScale(2, RoundingMode.HALF_UP));
			assertEquals(new BigDecimal("-110.00"), subOutCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Plan 20 must consume sub-assembly at Plan 10 rolled-up cost (110.00)");
			assertEquals(new BigDecimal("110.00"), fgInCd.getAmt().setScale(2, RoundingMode.HALF_UP),
					"Plan 20 FG must roll up sub-assembly cost (110.00)");

			List<MFactAcct> facts = getFacts(MProduction.Table_ID, prod.get_ID(), as.get_ID());
			BigDecimal totalDr = BigDecimal.ZERO;
			BigDecimal totalCr = BigDecimal.ZERO;
			BigDecimal fgDr = BigDecimal.ZERO;
			for (MFactAcct fa : facts)
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
}
