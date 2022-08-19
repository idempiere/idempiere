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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MCostElement;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
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
import org.compiere.model.MStorageOnHand;
import org.compiere.model.Query;
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

/**
 * 
 * @author hengsin
 *
 */
public class ProductionTest extends AbstractTestCase {
	// creates an order and material receipt for qty 25 at special price of 2.60 each
	private void createPOAndMRForProduct(int mulchId) {
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
		line1.setProduct(MProduct.get(Env.getCtx(), mulchId));
		line1.setQty(new BigDecimal("25"));
		line1.setPrice(new BigDecimal("2.60"));
		line1.setDatePromised(today);
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
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("25"));
		receiptLine1.setQty(new BigDecimal("25"));
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt1.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
		if (!receipt1.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
	}
			
	@Test
	public void testAutoProduce() {
		int mulchId = 137;
		int joeBlock = 118;
		MProduct mulch = MProduct.get(mulchId);
		
		MProduct mulchX = new MProduct(Env.getCtx(), 0, null);
		mulchX.setName("MulchX2");
		mulchX.setIsBOM(true);
		mulchX.setIsStocked(true);
		mulchX.setC_UOM_ID(mulch.getC_UOM_ID());
		mulchX.setM_Product_Category_ID(mulch.getM_Product_Category_ID());
		mulchX.setProductType(mulch.getProductType());
		mulchX.setM_AttributeSet_ID(mulch.getM_AttributeSet_ID());
		mulchX.setC_TaxCategory_ID(mulch.getC_TaxCategory_ID());
		mulchX.setIsAutoProduce(true);
		mulchX.saveEx();
		
		try {
			createPOAndMRForProduct(mulchId);  // create some stock to avoid negative qty average cost exception
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(mulchX.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(mulchX.getName());
			bom.saveEx();
			
			MPPProductBOMLine line = new MPPProductBOMLine(bom);
			line.setM_Product_ID(mulchId);
			line.setQtyBOM(new BigDecimal("2"));
			line.saveEx();
	
			mulchX.load((String)null);
			mulchX.setIsVerified(true);
			mulchX.saveEx();
			
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			//Joe Block
			order.setBPartner(MBPartner.get(Env.getCtx(), joeBlock));
			order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			order.setDateOrdered(today);
			order.setDatePromised(today);
			order.saveEx();
			
			MPriceList priceList = MPriceList.get(order.getM_PriceList_ID());
			MPriceListVersion priceListVersion = priceList.getPriceListVersion(null);
			MProductPrice productPrice = new MProductPrice(Env.getCtx(), 0, getTrxName());
			productPrice.setM_PriceList_Version_ID(priceListVersion.get_ID());
			productPrice.setM_Product_ID(mulchX.get_ID());
			productPrice.setPriceLimit(new BigDecimal("5.00"));
			productPrice.setPriceStd(new BigDecimal("5.00"));
			productPrice.saveEx();
			MOrderLine line1 = new MOrderLine(order);
			line1.setLine(10);
			line1.setProduct(mulchX);
			line1.setQty(new BigDecimal("1"));
			line1.setDatePromised(today);
			line1.saveEx();		
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());		
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			line1.load(getTrxName());
			assertEquals(1, line1.getQtyReserved().intValue());
			
			MInOut shipment = new MInOut(order, 120, order.getDateOrdered());
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
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
			
			shipmentLine.load(getTrxName());
			assertTrue(shipmentLine.isAutoProduce(), "Shipment Line Auto Produce is False");
			
			Query query = new Query(Env.getCtx(), MProduction.Table_Name, "M_InOutLine_ID=?", getTrxName());
			MProduction production  = query.setParameters(shipmentLine.get_ID()).first();
			assertNotNull(production, "Can't find production for auto produce shipment line");
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus());
			MProductionLine[] productionLines = production.getLines();
			assertNotNull(productionLines, "Can't find production line for auto produce shipment line");
			assertTrue(productionLines.length==2,"Number of production line is not 2 as expected ("+productionLines.length+")");
			assertTrue(productionLines[0].getM_Product_ID()==shipmentLine.getM_Product_ID(), "Production Line Production <> Shipment Line Product");
			assertTrue(productionLines[0].getMovementQty().equals(shipmentLine.getMovementQty()), "Production Line Qty <> Shipment Line Qty");
			assertTrue(productionLines[1].getM_Product_ID()==mulchId,"Production Line 2 Product is not the expected component product");
			assertTrue(productionLines[1].getMovementQty().intValue()==-2,"Production Line 2 Qty is not the expected component qty");
		} finally {
			rollback();
			DB.executeUpdateEx("delete from m_cost where m_product_id=?", new Object[] {mulchX.get_ID()}, null);
			mulchX.deleteEx(true);
		}
	}
	
	@Test
	public void testMultipleASI() {
		//use standard costing only to avoid negative qty exception
		DB.executeUpdateEx("UPDATE M_CostElement SET IsActive = 'N' WHERE AD_Client_ID=? AND CostingMethod IS NOT NULL AND CostingMethod != ?", 
				new Object[] {getAD_Client_ID(), MCostElement.COSTINGMETHOD_StandardCosting}, getTrxName());
				
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
		
		//storageonhand api doesn't use trx to retrieve product 
		MProduct component = new MProduct(Env.getCtx(), 0, null);
		component.setName("testMultipleASI_Child");
		component.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		component.setIsStocked(true);
		component.setProductType(MProduct.PRODUCTTYPE_Item);
		component.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		component.setM_Product_Category_ID(category.get_ID());
		component.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		component.saveEx();
		
		try {
			Timestamp today = TimeUtil.getDay(null);
			MProduct parent = new MProduct(Env.getCtx(), 0, getTrxName());
			parent.setName("testMultipleASI_Parent");
			parent.setIsBOM(true);
			parent.setIsStocked(true);
			parent.setC_UOM_ID(component.getC_UOM_ID());
			parent.setM_Product_Category_ID(component.getM_Product_Category_ID());
			parent.setProductType(component.getProductType());
			parent.setC_TaxCategory_ID(component.getC_TaxCategory_ID());
			parent.saveEx();
			BigDecimal endProductOnHand1 = MStorageOnHand.getQtyOnHand(parent.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
			assertEquals(0, endProductOnHand1.intValue(), "On hand of new product is not zero");
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(parent.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(parent.getName());
			bom.saveEx();
			
			MPPProductBOMLine line = new MPPProductBOMLine(bom);
			line.setM_Product_ID(component.get_ID());
			line.setQtyBOM(new BigDecimal("2"));
			line.saveEx();

			parent.load(getTrxName());
			parent.setIsVerified(true);
			parent.saveEx();
			
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("Lot1");
			asi1.saveEx();		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, component.get_ID(), asi1.get_ID(), new BigDecimal("1"), today, getTrxName());
			
			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi2.setLot("Lot2");
			asi2.saveEx();		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, component.get_ID(), asi2.get_ID(), new BigDecimal("1"), today, getTrxName());
			
			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(parent.get_ID());
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
			assertEquals("Y", production.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(production.getLines().length > 0, "No Production Lines");
			assertEquals(2, production.getLines().length, "Unexpected number of production lines");
	
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus(), "Production Status="+production.getDocStatus());
			
			BigDecimal endProductOnHand2 = MStorageOnHand.getQtyOnHand(parent.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
			
			assertEquals(1, endProductOnHand2.intValue(), "On hand of end product doesn't increase as expected");
		} finally {
			getTrx().rollback();
			component.deleteEx(true);
			category.deleteEx(true);
		}
	}
	
	@Test
	public void testMultipleDateMPolicy() {
		//use standard costing only to avoid negative qty exception
		DB.executeUpdateEx("UPDATE M_CostElement SET IsActive = 'N' WHERE AD_Client_ID=? AND CostingMethod IS NOT NULL AND CostingMethod != ?", 
				new Object[] {getAD_Client_ID(), MCostElement.COSTINGMETHOD_StandardCosting}, getTrxName());
		
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
		
		//storageonhand api doesn't use trx to retrieve product 
		MProduct component = new MProduct(Env.getCtx(), 0, null);
		component.setName("testMultipleDateMPolicy_Child");
		component.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		component.setIsStocked(true);
		component.setProductType(MProduct.PRODUCTTYPE_Item);
		component.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		component.setM_Product_Category_ID(category.get_ID());
		component.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		component.saveEx();
		
		try {
			Timestamp today = TimeUtil.getDay(null);
			MProduct parent = new MProduct(Env.getCtx(), 0, getTrxName());
			parent.setName("testMultipleDateMPolicy_Parent");
			parent.setIsBOM(true);
			parent.setIsStocked(true);
			parent.setC_UOM_ID(component.getC_UOM_ID());
			parent.setM_Product_Category_ID(component.getM_Product_Category_ID());
			parent.setProductType(component.getProductType());
			parent.setC_TaxCategory_ID(component.getC_TaxCategory_ID());
			parent.saveEx();
			BigDecimal endProductOnHand1 = MStorageOnHand.getQtyOnHand(parent.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
			assertEquals(0, endProductOnHand1.intValue(), "On hand of new product is not zero");
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(parent.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(parent.getName());
			bom.saveEx();
			
			MPPProductBOMLine line = new MPPProductBOMLine(bom);
			line.setM_Product_ID(component.get_ID());
			line.setQtyBOM(new BigDecimal("2"));
			line.saveEx();

			parent.load(getTrxName());
			parent.setIsVerified(true);
			parent.saveEx();
			
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("Lot1");
			asi1.saveEx();		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, component.get_ID(), asi1.get_ID(), new BigDecimal("1"), TimeUtil.addDays(today, -1), getTrxName());			
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, component.get_ID(), asi1.get_ID(), new BigDecimal("1"), today, getTrxName());
			
			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(parent.get_ID());
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
			assertEquals("Y", production.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(production.getLines().length > 0, "No Production Lines");
			assertEquals(2, production.getLines().length, "Unexpected number of production lines");
	
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus(), "Production Status="+production.getDocStatus());
			
			BigDecimal endProductOnHand2 = MStorageOnHand.getQtyOnHand(parent.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
			
			assertEquals(1, endProductOnHand2.intValue(), "On hand of end product doesn't increase as expected");
		} finally {
			getTrx().rollback();
			component.deleteEx(true);
			category.deleteEx(true);
		}
	}
	
	@Test
	public void testMultipleInProgressProduction() {
		//use standard costing only to avoid negative qty exception
		DB.executeUpdateEx("UPDATE M_CostElement SET IsActive = 'N' WHERE AD_Client_ID=? AND CostingMethod IS NOT NULL AND CostingMethod != ?", 
				new Object[] {getAD_Client_ID(), MCostElement.COSTINGMETHOD_StandardCosting}, getTrxName());
		
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
		
		//storageonhand api doesn't use trx to retrieve product 
		MProduct component = new MProduct(Env.getCtx(), 0, null);
		component.setName("testMultipleDateMPolicy_Child");
		component.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		component.setIsStocked(true);
		component.setProductType(MProduct.PRODUCTTYPE_Item);
		component.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		component.setM_Product_Category_ID(category.get_ID());
		component.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		component.saveEx();
		
		try {
			Timestamp today = TimeUtil.getDay(null);
			MProduct parent = new MProduct(Env.getCtx(), 0, getTrxName());
			parent.setName("testMultipleDateMPolicy_Parent");
			parent.setIsBOM(true);
			parent.setIsStocked(true);
			parent.setC_UOM_ID(component.getC_UOM_ID());
			parent.setM_Product_Category_ID(component.getM_Product_Category_ID());
			parent.setProductType(component.getProductType());
			parent.setC_TaxCategory_ID(component.getC_TaxCategory_ID());
			parent.saveEx();
			BigDecimal endProductOnHand1 = MStorageOnHand.getQtyOnHand(parent.get_ID(), getM_Warehouse_ID(), 0, getTrxName());
			assertEquals(0, endProductOnHand1.intValue(), "On hand of new product is not zero");
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(parent.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(parent.getName());
			bom.saveEx();
			
			MPPProductBOMLine line = new MPPProductBOMLine(bom);
			line.setM_Product_ID(component.get_ID());
			line.setQtyBOM(new BigDecimal("2"));
			line.saveEx();

			parent.load(getTrxName());
			parent.setIsVerified(true);
			parent.saveEx();
			
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("Lot1");
			asi1.saveEx();		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, component.get_ID(), asi1.get_ID(), new BigDecimal("2"), today, getTrxName());	
			
			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi2.setLot("Lot2");
			asi2.saveEx();		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, component.get_ID(), asi2.get_ID(), new BigDecimal("2"), today, getTrxName());
			
			MProduction production1 = new MProduction(Env.getCtx(), 0, getTrxName());
			production1.setM_Product_ID(parent.get_ID());
			production1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			production1.setIsUseProductionPlan(false);
			production1.setMovementDate(getLoginDate());
			production1.setDocAction(DocAction.ACTION_Complete);
			production1.setDocStatus(DocAction.STATUS_Drafted);
			production1.setIsComplete(false);
			production1.setProductionQty(new BigDecimal("1"));
			production1.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production1.saveEx();
	
			int productionCreate = 53226;
			MProcess process = MProcess.get(Env.getCtx(), productionCreate);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production1.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());
	
			production1.load(getTrxName());
			assertEquals("Y", production1.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(production1.getLines().length > 0, "No Production Lines");
			assertEquals(2, production1.getLines().length, "Unexpected number of production lines");
	
			MProduction production2 = new MProduction(Env.getCtx(), 0, getTrxName());
			production2.setM_Product_ID(parent.get_ID());
			production2.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			production2.setIsUseProductionPlan(false);
			production2.setMovementDate(getLoginDate());
			production2.setDocAction(DocAction.ACTION_Complete);
			production2.setDocStatus(DocAction.STATUS_Drafted);
			production2.setIsComplete(false);
			production2.setProductionQty(new BigDecimal("1"));
			production2.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production2.saveEx();
	
			pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production2.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());
	
			production2.load(getTrxName());
			assertEquals("Y", production2.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(production2.getLines().length > 0, "No Production Lines");
			assertEquals(2, production2.getLines().length, "Unexpected number of production lines");
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production1, DocAction.ACTION_Complete);
			production1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, production1.getDocStatus(), "Production Status="+production1.getDocStatus());			
			BigDecimal endProductOnHand2 = MStorageOnHand.getQtyOnHand(parent.get_ID(), getM_Warehouse_ID(), 0, getTrxName());			
			assertEquals(1, endProductOnHand2.intValue(), "On hand of end product doesn't increase as expected");
			
			info = MWorkflow.runDocumentActionWorkflow(production2, DocAction.ACTION_Complete);
			production2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, production2.getDocStatus(), "Production Status="+production2.getDocStatus());			
			endProductOnHand2 = MStorageOnHand.getQtyOnHand(parent.get_ID(), getM_Warehouse_ID(), 0, getTrxName());			
			assertEquals(2, endProductOnHand2.intValue(), "On hand of end product doesn't increase as expected");
		} finally {
			getTrx().rollback();
			component.deleteEx(true);
			category.deleteEx(true);
		}
	}
}
