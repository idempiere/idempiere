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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.util.List;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProduction;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class ProductionTest extends AbstractTestCase {

	@Test
	public void testAverageCostingProduction() {
		int mulchId = 137;
		int hqLocator = 101;
		MProduct mulch = MProduct.get(mulchId);
		BigDecimal componentOnHand1 = MStorageOnHand.getQtyOnHand(mulchId, getM_Warehouse_ID(), 0, getTrxName());
		BigDecimal componentCost = MCost.getCurrentCost(mulch, 0, getTrxName());
		
		MProduct mulchX = new MProduct(Env.getCtx(), 0, getTrxName());
		mulchX.setName("Mulch X");
		mulchX.setIsBOM(true);
		mulchX.setIsStocked(true);
		mulchX.setC_UOM_ID(mulch.getC_UOM_ID());
		mulchX.setM_Product_Category_ID(mulch.getM_Product_Category_ID());
		mulchX.setProductType(mulch.getProductType());
		mulchX.setM_AttributeSet_ID(mulch.getM_AttributeSet_ID());
		mulchX.setC_TaxCategory_ID(mulch.getC_TaxCategory_ID());
		mulchX.saveEx();
		BigDecimal endProductOnHand1 = MStorageOnHand.getQtyOnHand(mulchX.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
		
		MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
		bom.setM_Product_ID(mulchX.get_ID());		
		bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
		bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
		bom.setName(mulchX.getName());
		bom.saveEx();
		
		MPPProductBOMLine line = new MPPProductBOMLine(bom);
		line.setM_Product_ID(mulchId);
		line.setQtyBOM(new BigDecimal("1"));
		line.saveEx();

		mulchX.load(getTrxName());
		mulchX.setIsVerified(true);
		mulchX.saveEx();

		MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
		production.setM_Product_ID(mulchX.get_ID());
		production.setM_Locator_ID(hqLocator);
		production.setIsUseProductionPlan(false);
		production.setMovementDate(getLoginDate());
		production.setDocAction(DocAction.ACTION_Complete);
		production.setDocStatus(DocAction.STATUS_Drafted);
		production.setIsComplete(false);
		production.setProductionQty(new BigDecimal("1"));
		production.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
		production.saveEx();

		int productionCreate = 53226;
		MProcess process = MProcess.get(Env.getCtx(), productionCreate);
		ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setRecord_ID(production.get_ID());
		pi.setTransactionName(getTrxName());
		ServerProcessCtl.process(pi, getTrx(), false);
		assertFalse(pi.isError(), pi.getSummary());

		production.load(getTrxName());
		assertEquals("Y", production.getIsCreated(), "MProduction.IsCreated != Y");
		assertTrue(production.getLines().length > 0, "No Production Lines");

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
		production.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, production.getDocStatus(), "Production Status="+production.getDocStatus());
		
		BigDecimal componentOnHand2 = MStorageOnHand.getQtyOnHand(mulchId, getM_Warehouse_ID(), 0, getTrxName());
		BigDecimal endProductOnHand2 = MStorageOnHand.getQtyOnHand(mulchX.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
		
		assertTrue(componentOnHand2.compareTo(componentOnHand1) < 0, "On hand of component doesn't reduce as expected");
		assertTrue(endProductOnHand2.compareTo(endProductOnHand1) > 0, "On hand of end product doesn't increase as expected");
		
		if (!production.isPosted()) {
			String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MProduction.Table_ID, production.get_ID(), false, getTrxName());
			assertNull(msg, msg);
		}
		
		BigDecimal endProductCost = MCost.getCurrentCost(mulchX, 0, getTrxName());
		assertTrue(endProductCost.equals(componentCost), "Cost not roll up correctly");
	}
	
	@Test
	public void testStandardCostingProduction() {
		MProductCategory category = new MProductCategory(Env.getCtx(), 0, null);
		category.setName("Standard Costing");
		category.saveEx();
		
		String whereClause = "M_Product_Category_ID=?";
		List<MProductCategoryAcct> categoryAccts = new Query(Env.getCtx(), MProductCategoryAcct.Table_Name, whereClause, null)
									.setParameters(category.get_ID())
									.list();
		for (MProductCategoryAcct categoryAcct : categoryAccts) {
			categoryAcct.setCostingMethod(MAcctSchema.COSTINGMETHOD_StandardCosting);
			categoryAcct.saveEx();
		}
		
		try {
			int mulchId = 137;
			int hqLocator = 101;
			MProduct mulch = MProduct.get(mulchId);
			BigDecimal componentOnHand1 = MStorageOnHand.getQtyOnHand(mulchId, getM_Warehouse_ID(), 0, getTrxName());
			BigDecimal componentCost = MCost.getCurrentCost(mulch, 0, getTrxName());
									
			MProduct mulchX = new MProduct(Env.getCtx(), 0, getTrxName());
			mulchX.setName("Mulch X");
			mulchX.setIsBOM(true);
			mulchX.setIsStocked(true);
			mulchX.setC_UOM_ID(mulch.getC_UOM_ID());
			mulchX.setM_Product_Category_ID(category.getM_Product_Category_ID());
			mulchX.setProductType(mulch.getProductType());
			mulchX.setM_AttributeSet_ID(mulch.getM_AttributeSet_ID());
			mulchX.setC_TaxCategory_ID(mulch.getC_TaxCategory_ID());
			mulchX.saveEx();
			BigDecimal endProductOnHand1 = MStorageOnHand.getQtyOnHand(mulchX.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
			
			int costAdjustmentDocTypeId = 200004;
			MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory.setCostingMethod(MAcctSchema.COSTINGMETHOD_StandardCosting);
			inventory.setC_DocType_ID(costAdjustmentDocTypeId);
			inventory.setM_Warehouse_ID(getM_Warehouse_ID());
			inventory.setMovementDate(getLoginDate());
			inventory.setDocAction(DocAction.ACTION_Complete);
			inventory.saveEx();
			
			BigDecimal endProductCost = new BigDecimal("2.50"); 
			MInventoryLine il = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			il.setM_Inventory_ID(inventory.get_ID());
			il.setM_Locator_ID(hqLocator);
			il.setM_Product_ID(mulchX.getM_Product_ID());
			il.setCurrentCostPrice(new BigDecimal("0"));
			il.setNewCostPrice(endProductCost);
			il.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			inventory.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Cost Adjustment Status="+inventory.getDocStatus());
			
			if (!inventory.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInventory.Table_ID, inventory.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			BigDecimal adjusted = MCost.getCurrentCost(mulchX, 0, getTrxName());
			assertTrue(adjusted.equals(endProductCost), "Cost not adjusted: " + adjusted.toPlainString());
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(mulchX.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(mulchX.getName());
			bom.saveEx();
			
			MPPProductBOMLine line = new MPPProductBOMLine(bom);
			line.setM_Product_ID(mulchId);
			line.setQtyBOM(new BigDecimal("1"));
			line.saveEx();
	
			mulchX.load(getTrxName());
			mulchX.setIsVerified(true);
			mulchX.saveEx();
	
			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(mulchX.get_ID());
			production.setM_Locator_ID(hqLocator);
			production.setIsUseProductionPlan(false);
			production.setMovementDate(getLoginDate());
			production.setDocAction(DocAction.ACTION_Complete);
			production.setDocStatus(DocAction.STATUS_Drafted);
			production.setIsComplete(false);
			production.setProductionQty(new BigDecimal("1"));
			production.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production.saveEx();
	
			int productionCreate = 53226;
			MProcess process = MProcess.get(Env.getCtx(), productionCreate);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());
	
			production.load(getTrxName());
			assertEquals("Y", production.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(production.getLines().length > 0, "No Production Lines");
	
			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus(), "Production Status="+production.getDocStatus());
			
			BigDecimal componentOnHand2 = MStorageOnHand.getQtyOnHand(mulchId, getM_Warehouse_ID(), 0, getTrxName());
			BigDecimal endProductOnHand2 = MStorageOnHand.getQtyOnHand(mulchX.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
			
			assertTrue(componentOnHand2.compareTo(componentOnHand1) < 0, "On hand of component doesn't reduce as expected");
			assertTrue(endProductOnHand2.compareTo(endProductOnHand1) > 0, "On hand of end product doesn't increase as expected");
			
			if (!production.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MProduction.Table_ID, production.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			BigDecimal endProductCost1 = MCost.getCurrentCost(mulchX, 0, getTrxName());
			assertTrue(endProductCost1.equals(endProductCost), "Standard Cost Changed");
			
			ProductCost pc = new ProductCost (Env.getCtx(), mulchX.getM_Product_ID(), 0, getTrxName());
			MAccount acctVariance = pc.getAccount(ProductCost.ACCTTYPE_P_RateVariance, MClient.get(getAD_Client_ID()).getAcctSchema());
			
			whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MProduction.Table_ID 
					+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + production.get_ID()
					+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + MClient.get(getAD_Client_ID()).getAcctSchema().getC_AcctSchema_ID()
				    + " AND " + MFactAcct.COLUMNNAME_Account_ID + "=" + acctVariance.getAccount_ID();
			int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
			BigDecimal variance = BigDecimal.ZERO;
			for (int id : ids) {
				MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
				variance = fa.getAmtAcctDr().subtract(fa.getAmtAcctCr());
				break;
			}		
			assertEquals(variance.doubleValue(), componentCost.subtract(endProductCost).doubleValue(), "Variance not posted correctly.");
		} finally {
			getTrx().rollback();
			category.deleteEx(true);
		}
	}
	
	@Test
	public void testRollUp() {		
		MProductCategory category = new MProductCategory(Env.getCtx(), 0, null);
		category.setName("Standard Costing");
		category.saveEx();
		
		String whereClause = "M_Product_Category_ID=?";
		List<MProductCategoryAcct> categoryAccts = new Query(Env.getCtx(), MProductCategoryAcct.Table_Name, whereClause, null)
									.setParameters(category.get_ID())
									.list();
		for (MProductCategoryAcct categoryAcct : categoryAccts) {
			categoryAcct.setCostingMethod(MAcctSchema.COSTINGMETHOD_StandardCosting);
			categoryAcct.saveEx();
		}
		
		try {
			int rollUpProcessId = 53230;
			int mulchId = 137;
			MProduct mulch = MProduct.get(mulchId);
			BigDecimal componentCost = MCost.getCurrentCost(mulch, 0, getTrxName());
									
			MProduct mulchX = new MProduct(Env.getCtx(), 0, getTrxName());
			mulchX.setName("Mulch X");
			mulchX.setIsBOM(true);
			mulchX.setIsStocked(true);
			mulchX.setC_UOM_ID(mulch.getC_UOM_ID());
			mulchX.setM_Product_Category_ID(category.getM_Product_Category_ID());
			mulchX.setProductType(mulch.getProductType());
			mulchX.setM_AttributeSet_ID(mulch.getM_AttributeSet_ID());
			mulchX.setC_TaxCategory_ID(mulch.getC_TaxCategory_ID());
			mulchX.saveEx();
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(mulchX.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(mulchX.getName());
			bom.saveEx();
			
			MPPProductBOMLine line = new MPPProductBOMLine(bom);
			line.setM_Product_ID(mulchId);
			line.setQtyBOM(new BigDecimal("1"));
			line.saveEx();
	
			mulchX.load(getTrxName());
			mulchX.setIsVerified(true);
			mulchX.saveEx();
			
			MPInstance instance = new MPInstance(Env.getCtx(), rollUpProcessId, 0);
			instance.saveEx();
			MPInstancePara para = new MPInstancePara(instance, 10);
			para.setParameterName("M_Product_ID");
			para.setP_Number(mulchX.get_ID());
			para.saveEx();
			
			para = new MPInstancePara(instance, 20);
			para.setParameterName("M_CostElement_ID");
			para.setP_Number(MCostElement.getMaterialCostElement(Env.getCtx(), MAcctSchema.COSTINGMETHOD_StandardCosting).get_ID());
			para.saveEx();
			
			ProcessInfo info = new ProcessInfo(MProcess.get(rollUpProcessId).getName(), rollUpProcessId);
			info.setAD_PInstance_ID(instance.getAD_PInstance_ID());
			info.setTransactionName(getTrxName());
			ServerProcessCtl.process(info, getTrx(), false);
			assertFalse(info.isError(), info.getSummary());
			
			BigDecimal endProductCost = MCost.getCurrentCost(mulchX, 0, getTrxName());
			assertEquals(componentCost.doubleValue(), endProductCost.doubleValue(), "BOM Cost not roll up.");
		} finally {
			getTrx().rollback();
			category.deleteEx(true);
		}
	}
}
