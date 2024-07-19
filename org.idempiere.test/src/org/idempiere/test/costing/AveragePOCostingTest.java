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
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.List;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetExclude;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLandedCost;
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
import org.compiere.model.MStorageOnHand;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

@Isolated
public class AveragePOCostingTest extends AbstractTestCase {

	public AveragePOCostingTest() {
	}

	@Test
	public void testMaterialReceipt() {
		MProduct product = null;
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try {
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product.setName("testMaterialReceipt");
			product.setValue("testMaterialReceipt");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MInOutLine receiptLine = createPOAndMRForProduct(product.get_ID(), null, null);
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(new BigDecimal("2.00"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for material receipt line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			receiptLine = createPOAndMRForProduct(product.get_ID(), null, new BigDecimal("3.00"));
			cost.load(getTrxName());
			//(2+3)/2
			assertEquals(new BigDecimal("2.50"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for material receipt line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			//reverse MR2
			MInOut receipt = new MInOut(Env.getCtx(), receiptLine.getM_InOut_ID(), getTrxName());
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus(), "Unexpected Document Status");
			MInOut reverse = new MInOut(Env.getCtx(), receipt.getReversal_ID(), getTrxName());
			if (!reverse.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), reverse.getAD_Client_ID(), reverse.get_Table_ID(), reverse.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//back to cost=2 after reversal
			cost.load(getTrxName());
			assertEquals(new BigDecimal("2.00"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("0.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		} finally {
			rollback();
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
		}
	}
	
	@Test
	public void testShipment() {
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, getTrxName());
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.AZALEA_BUSH.id, null, new BigDecimal("5.00"));
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Unexpected Document Status");
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected Document Status");
		
		//cost shouldn't change after shipment
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.get_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for shipment line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");		
		
		//reverse shipment
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Accrual);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Reversed, shipment.getDocStatus(), "Unexpected Document Status");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
		
		MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
		MInOutLine[] reversalLines = reversal.getLines();
		cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLines[0].get_ID(), 0, as.get_ID(), getTrxName());
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
	}
	
	@Test
	public void testInternalUse() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setQtyInternalUse(new BigDecimal("1.00"));
		line.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", line.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse internal use
		info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Reverse_Accrual);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MInventory reversal = new MInventory(Env.getCtx(), inventory.getReversal_ID(), getTrxName());
		cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversal.getLines(false)[0].getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	}
	
	@Test
	public void testProjectIssue() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MProject project = new MProject(Env.getCtx(), 0, getTrxName());
		project.setName("testProjectIssue");
		project.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		project.saveEx();
		
		MProjectIssue issue = new MProjectIssue(project);
		issue.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		issue.setLine(10);
		issue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		issue.setMovementQty(new BigDecimal("1.00"));
		issue.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
		issue.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, issue.getDocStatus(), "Unexpected Document Status");
		if (!issue.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), issue.getAD_Client_ID(), issue.get_Table_ID(), issue.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", issue.getC_ProjectIssue_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for project issue line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse issue
		info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Accrual);
		issue.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, issue.getDocStatus(), "Unexpected Document Status");
		
		cd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", issue.getReversal_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for project issue line");
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	}
	
	@Test
	public void testProduction() {
		MProduct mulch = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MProduct azb = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, getTrxName());
		
		MProduct mulchX = new MProduct(Env.getCtx(), 0, null);
		mulchX.setName("MulchX2");
		mulchX.setIsBOM(true);
		mulchX.setIsStocked(true);
		mulchX.setC_UOM_ID(mulch.getC_UOM_ID());
		mulchX.setM_Product_Category_ID(mulch.getM_Product_Category_ID());
		mulchX.setProductType(mulch.getProductType());
		mulchX.setM_AttributeSet_ID(mulch.getM_AttributeSet_ID());
		mulchX.setC_TaxCategory_ID(mulch.getC_TaxCategory_ID());
		mulchX.saveEx();
		
		try {
			MClient client = MClient.get(Env.getCtx());
			MAcctSchema as = client.getAcctSchema();
			assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
			MCost cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
				createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
				cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			}
			BigDecimal mulchCost = cost.getCurrentCostPrice();
			cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
				createPOAndMRForProduct(DictionaryIDs.M_Product.AZALEA_BUSH.id, null, null);
				cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			}
			BigDecimal azbCost = cost.getCurrentCostPrice();
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(mulchX.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(mulchX.getName());
			bom.saveEx();
			
			MPPProductBOMLine line1 = new MPPProductBOMLine(bom);
			line1.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
			line1.setQtyBOM(new BigDecimal("1"));
			line1.saveEx();
	
			MPPProductBOMLine line2 = new MPPProductBOMLine(bom);
			line2.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
			line2.setQtyBOM(new BigDecimal("1"));
			line2.saveEx();
			
			mulchX.load((String)null);
			mulchX.setIsVerified(true);
			mulchX.saveEx();
			
			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(mulchX.get_ID());
			production.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
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
			MProductionLine[] plines = production.getLines();
			assertEquals("Y", production.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(plines.length > 0, "No Production Lines");
			assertEquals(3, plines.length, "Unexpected number of production lines");
	
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus(), "Production Status="+production.getDocStatus());
			
			BigDecimal rollup = mulchCost.add(azbCost); 
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", plines[0].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(rollup.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			mulchX.set_TrxName(getTrxName());
			cost = mulchX.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(rollup.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", plines[1].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(mulchCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(mulchCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", plines[2].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(azbCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(azbCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			//reverse production
			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Accrual);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, production.getDocStatus(), "Production Status="+production.getDocStatus());
			
			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			MProductionLine[] reversalLines = reversal.getLines();
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", reversalLines[0].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(rollup.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", reversalLines[1].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(mulchCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(mulchCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", reversalLines[2].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(azbCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		} finally {
			rollback();
			DB.executeUpdateEx("delete from m_cost where m_product_id=?", new Object[] {mulchX.get_ID()}, null);
			mulchX.set_TrxName(null);
			mulchX.deleteEx(true);
		}
	}
	
	@Test
	public void testMRAndShipmentByLot() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		
		MProductCategory lotLevel = new MProductCategory(Env.getCtx(), 0, null);
		lotLevel.setName("testMaterialReceiptLot");
		lotLevel.saveEx();
				
		MProduct product = null;
		MAttributeSetExclude exclude = null;
		MAttributeSetExclude exclude1 = null;
		try {
			MAttributeSet mas = new MAttributeSet(Env.getCtx(), DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id, getTrxName());
			mas.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			mas.saveEx();
			
			exclude = new MAttributeSetExclude(Env.getCtx(), 0, null);
			exclude.setM_AttributeSet_ID(mas.get_ID());
			exclude.setAD_Table_ID(MOrderLine.Table_ID);
			exclude.setIsSOTrx(true);
			exclude.saveEx();
			
			exclude1 = new MAttributeSetExclude(Env.getCtx(), 0, null);
			exclude1.setM_AttributeSet_ID(mas.get_ID());
			exclude1.setAD_Table_ID(MInOutLine.Table_ID);
			exclude1.setIsSOTrx(true);
			exclude1.saveEx();
			
			MProductCategoryAcct lotLevelAcct = MProductCategoryAcct.get(lotLevel.get_ID(), as.get_ID());
			lotLevelAcct = new MProductCategoryAcct(Env.getCtx(), lotLevelAcct);
			lotLevelAcct.setCostingLevel(MAcctSchema.COSTINGLEVEL_BatchLot);
			lotLevelAcct.saveEx();
			
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(lotLevel.get_ID());
			product.setName("testMaterialReceiptLot");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			product.saveEx();
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("Lot1");
			asi1.saveEx();			
			MInOutLine line1 = createPOAndMRForProduct(product.get_ID(), asi1, new BigDecimal("2.00"));
			
			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi2.setLot("Lot2");
			asi2.saveEx();			
			MInOutLine line2 = createPOAndMRForProduct(product.get_ID(), asi2, new BigDecimal("3.00"));
			
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), asi1.get_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", line2.getC_OrderLine_ID(), asi2.get_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			product.set_TrxName(getTrxName());
			MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), asi1.get_ID(), as.getCostingMethod());
			assertNotNull(cost1, "MCost record not found");
			assertEquals(new BigDecimal("2.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), asi2.get_ID(), as.getCostingMethod());
			assertNotNull(cost2, "MCost record not found");
			assertEquals(new BigDecimal("3.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			//shipment
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			order.setDatePromised(today);
			order.saveEx();
			
			MOrderLine ol1 = new MOrderLine(order);
			ol1.setLine(10);
			//Azalea Bush
			ol1.setProduct(product);
			ol1.setQty(new BigDecimal("2"));
			ol1.setDatePromised(today);
			ol1.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Unexpected document status");
			
			MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setOrderLine(ol1, 0, new BigDecimal("2"));
			shipmentLine.setQty(new BigDecimal("2"));
			shipmentLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected document status");
			
			MInOutLineMA[] linema = MInOutLineMA.get(Env.getCtx(), shipmentLine.get_ID(), getTrxName());
			assertEquals(2, linema.length, "Unexpected number of MInOutLineMA records");
			assertEquals(linema[0].getM_AttributeSetInstance_ID(), asi1.get_ID(), "Unexpected M_AttributeSetInstance_ID for MInOutLineMA 1");
			assertEquals(linema[1].getM_AttributeSetInstance_ID(), asi2.get_ID(), "Unexpected M_AttributeSetInstance_ID for MInOutLineMA 2");
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), linema[0].getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2").negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), linema[1].getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3").negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			//reverse shipment
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, shipment.getDocStatus(), "Unexpected document status");
			
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			MInOutLine[] reversalLines = reversal.getLines();
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLines[0].getM_InOutLine_ID(), asi1.getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLines[0].getM_InOutLine_ID(), asi2.getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cost1 = product.getCostingRecord(as, getAD_Org_ID(), asi1.get_ID(), as.getCostingMethod());
			assertNotNull(cost1, "MCost record not found");
			assertEquals(new BigDecimal("2.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			cost2 = product.getCostingRecord(as, getAD_Org_ID(), asi2.get_ID(), as.getCostingMethod());
			assertNotNull(cost2, "MCost record not found");
			assertEquals(new BigDecimal("3.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			//reverse MR2
			MInOut mr2 = new MInOut(Env.getCtx(), line2.getM_InOut_ID(), getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(mr2, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			mr2.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, mr2.getDocStatus(), "Unexpected document status");
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", line2.getC_OrderLine_ID(), asi2.getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line2");
			assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		} finally {
			rollback();
			
			if (exclude != null)
				exclude.deleteEx(true);
			
			if (exclude1 != null)
				exclude1.deleteEx(true);
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
			
			lotLevel.deleteEx(true);
		}
	}
	
	@Test
	public void testCostAdjustment() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		BigDecimal adjustment = new BigDecimal("0.25");
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
		inventory.setC_Currency_ID(as.getC_Currency_ID());
		inventory.setCostingMethod(as.getCostingMethod());
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		line.setCurrentCostPrice(currentCost);
		line.setNewCostPrice(currentCost.add(adjustment));
		line.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", line.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(adjustment.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.add(adjustment).setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse cost adjustment
		info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Reverse_Accrual);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MInventory reversal = new MInventory(Env.getCtx(), inventory.getReversal_ID(), getTrxName());
		MInventoryLine[] reversalLines = reversal.getLines(true);
		cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversalLines[0].getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(adjustment.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	}
	
	@Test
	public void testPhysicalInventory() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		BigDecimal qtyOnHand = MStorageOnHand.getQtyOnHandForLocator(line.getM_Product_ID(), line.getM_Locator_ID(), 0, getTrxName());
		line.setQtyBook(qtyOnHand);
		line.setQtyCount(line.getQtyBook().add(new BigDecimal("1")));
		line.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", line.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse physical inventory
		info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Reverse_Accrual);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MInventory reversal = new MInventory(Env.getCtx(), inventory.getReversal_ID(), getTrxName());
		MInventoryLine[] reversalLines = reversal.getLines(true);
		cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversalLines[0].getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	
	}
	
	@Test
	public void testLandedCostForPO() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MProduct product = null;
		try {
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testLandedCostForPO");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			//create order
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			order.setDateOrdered(today);
			order.setDatePromised(today);
			order.saveEx();

			MOrderLine line1 = new MOrderLine(order);
			line1.setLine(10);
			line1.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line1.setQty(new BigDecimal("1"));
			line1.setDatePromised(today);
			line1.setPrice(new BigDecimal("2"));
			line1.saveEx();
			
			MOrderLandedCost landedCost = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_Order_ID(order.get_ID());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Costs);
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setAmt(new BigDecimal("0.30"));
			landedCost.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
			receiptLine1.setQty(new BigDecimal("1"));
			receiptLine1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 2, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("2.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("0.30").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(new BigDecimal("2.30"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			//reverse receipt
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, receipt1.getDocStatus());
			
			cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 2, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
		} finally {
			rollback();
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
		}
	}
	
	private MInOutLine createPOAndMRForProduct(int productId, MAttributeSetInstance asi, BigDecimal price) {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(new MProduct(Env.getCtx(), productId, getTrxName()));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		if (price != null)
			line1.setPrice(price);
		if (asi != null)
			line1.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
		
		MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt1.setDocStatus(DocAction.STATUS_Drafted);
		receipt1.setDocAction(DocAction.ACTION_Complete);
		receipt1.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt1);
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine1.setQty(new BigDecimal("1"));
		if (asi != null)
			receiptLine1.setM_AttributeSetInstance_ID(asi.get_ID());
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt1.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
		if (!receipt1.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
		
		return receiptLine1;
	}
}
