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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProduction;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MSysConfig;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.ZeroCostPostingTestHelper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * @author Carlos Ruiz - globalqss
 */
@Isolated
public class InventoryTest extends AbstractTestCase {

	public InventoryTest() {
	}

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4596
	 */
	@Test
	public void testCreateAProductAndInventory() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = new MProduct(ctx, 0, trxName);
		product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.BUSH.id);
		product.setName("Test 4596");
		product.setValue("T4596");
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();

		MInventoryLine iline = new MInventoryLine(inventory,
				DictionaryIDs.M_Locator.HQ.id, 
				product.getM_Product_ID(),
				0, // M_AttributeSetInstance_ID
				Env.ZERO, // QtyBook
				Env.ONEHUNDRED);
		iline.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		inventory.load(trxName);
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
	}

	@Test
	public void testCostAdjustmentLineBeforeSave() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost);
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
		inventory.setCostingMethod(as.getCostingMethod());
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setNewCostPrice(cost.getCurrentCostPrice().add(new BigDecimal("0.5")));
		line.saveEx();
		
		assertNotEquals(0, line.getLine(), "Unexpected Line No");
		assertEquals(cost.getCurrentCostPrice(), line.getCurrentCostPrice());
	}
	
	/**
	 * IDEMPIERE-6600 : Posting Error For No Cost Product On Physical Inventory
	 * @author ZuhriUtama
	 */
	@Test
	public void testZeroCostProductPosting() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		
		MClient client = MClient.get(ctx);
		MAcctSchema as = client.getAcctSchema();
		
		// create purchase order
		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
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
		line1.setM_Product_ID(DictionaryIDs.M_Product.FERTILIZER_50.id);
		line1.setQty(Env.ONEHUNDRED);
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut materialReceipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		materialReceipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(materialReceipt);
		receiptLine.setOrderLine(line1, 0, Env.ONEHUNDRED);
		receiptLine.setQty(Env.ONEHUNDRED);
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(materialReceipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		materialReceipt.load(trxName);
		assertEquals(DocAction.STATUS_Completed, materialReceipt.getDocStatus());
		assertEquals(true, materialReceipt.isPosted());
		
		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.setCostingMethod(as.getCostingMethod());
		inventory.saveEx();

		MInventoryLine iline = new MInventoryLine(inventory,
				DictionaryIDs.M_Locator.HQ.id, 
				DictionaryIDs.M_Product.FERTILIZER_50.id,
				0, // M_AttributeSetInstance_ID
				Env.ONEHUNDRED, // QtyBook
				Env.ONE);
		iline.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		inventory.load(trxName);
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
		assertEquals(true, inventory.isPosted());
	}
	
	/**
	 * IDEMPIERE-6737
	 * Attribute Set with "Use Guarantee Date for Material Policy" = "Y"
	 */
	@Test
	public void testAttributeSetWithGuaranteeDateForMaterialPolicy() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		
		MProduct product = new MProduct(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id, trxName);
		MAttributeSet attributeSet = MAttributeSet.get(ctx, product.getM_AttributeSet_ID());
		
		// Mock only the attribute set
	    MAttributeSet attributeSetMock = Mockito.mock(MAttributeSet.class);
	    Mockito.when(attributeSetMock.get_ID()).thenReturn(product.getM_AttributeSet_ID());
	    Mockito.when(attributeSetMock.isUseGuaranteeDateForMPolicy()).thenReturn(true); // simulate "Y"
	    Mockito.when(attributeSetMock.getM_AttributeSet_ID()).thenReturn(product.getM_AttributeSet_ID());
	    
	    try (MockedStatic<MAttributeSet> attributeSetStaticMock = Mockito.mockStatic(MAttributeSet.class)) {
	        attributeSetStaticMock.when(() -> MAttributeSet.get(ctx, product.getM_AttributeSet_ID()))
	                              .thenReturn(attributeSetMock);

	        attributeSet = MAttributeSet.get(ctx, product.getM_AttributeSet_ID());
	        assertTrue(attributeSet.isUseGuaranteeDateForMPolicy());
			
			Timestamp today = TimeUtil.getDay(null);
			Timestamp tomorrow = TimeUtil.addDays(today, 1);
			
			MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
			asi.setM_AttributeSet_ID(product.getM_AttributeSet_ID());
			asi.setLot("8888");
			asi.setGuaranteeDate(tomorrow);
			asi.saveEx();
			
			MInventory inventory = new MInventory(ctx, 0, trxName);
			inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
			inventory.setMovementDate(today);
			inventory.saveEx();

			MInventoryLine iline = new MInventoryLine(inventory,
					DictionaryIDs.M_Locator.HQ.id, 
					product.getM_Product_ID(),
					asi.get_ID(), // M_AttributeSetInstance_ID
					Env.ZERO, // QtyBook
					Env.ONEHUNDRED);
			iline.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			inventory.load(trxName);
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
			
			MStorageOnHand[] storages = MStorageOnHand.getWarehouse(ctx, inventory.getM_Warehouse_ID(),
					product.get_ID(), asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
					0, trxName);
			assertEquals(1, storages.length);
			MStorageOnHand storage = storages[0];
			assertEquals(100, storage.getQtyOnHand().intValue());
			assertEquals(tomorrow, storage.getDateMaterialPolicy());
		} finally {
			rollback();
		}
	}
	
	/**
	 * IDEMPIERE-6972
	 * MR1, Product1, ASI1, Qty=100
	 * MR2, Product1, ASI2, Qty=100
	 * Physical Inventory
	 * 	Line1, Product1, ASI1, QtyBook=1, QtyCount=100
	 * 	Line2, Product1, ASI2, QtyBook=100, QtyCount=100
	 */
	@Test
	public void testZeroDifferenceInventoryLine() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.FERTILIZER_50.id, getTrxName());

		MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi1.setM_AttributeSet_ID(product.getM_AttributeSet_ID());
		asi1.setLot("asi1");
		asi1.setDescription();
		asi1.saveEx();
		
		MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi2.setM_AttributeSet_ID(product.getM_AttributeSet_ID());
		asi2.setLot("asi2");
		asi2.setDescription();
		asi2.saveEx();
		
		createPOAndMRForProduct(DictionaryIDs.M_Product.FERTILIZER_50.id, asi1, Env.ONEHUNDRED);
		createPOAndMRForProduct(DictionaryIDs.M_Product.FERTILIZER_50.id, asi2, Env.ONEHUNDRED);
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.setCostingMethod(as.getCostingMethod());
		inventory.saveEx();
		
		// Qty Count <> Qty Book
		MInventoryLine line1 = new MInventoryLine(
				inventory,
				DictionaryIDs.M_Locator.HQ.id, 
				product.getM_Product_ID(),
				asi1.get_ID(),
				Env.ONE, // QtyBook
				Env.ONEHUNDRED); // QtyCount
		line1.saveEx();
		
		// Qty Count = Qty Book
		MInventoryLine line2 = new MInventoryLine(
				inventory,
				DictionaryIDs.M_Locator.HQ.id, 
				product.getM_Product_ID(),
				asi2.get_ID(),
				Env.ONEHUNDRED, // QtyBook
				Env.ONEHUNDRED); // QtyCount
		line2.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		inventory.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
		if (!inventory.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), inventory.getAD_Client_ID(), inventory.get_Table_ID(), inventory.get_ID(), false, getTrxName());
			assertNull(error, error);
			inventory.load(getTrxName());
		}
		assertTrue(inventory.isPosted(), "Inventory should be posted successfully");
	}
	
	private void createPOAndMRForProduct(int productId) {
		createPOAndMRForProduct(productId, null, BigDecimal.ONE);
	}
	
	private void createPOAndMRForProduct(int productId, MAttributeSetInstance asi, BigDecimal qty) {
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
		line1.setQty(qty);
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
		receiptLine1.setOrderLine(line1, 0, qty);
		receiptLine1.setQty(qty);
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
	}

	@Test
	public void testZeroCostProductPostingSysConfig() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(Env.getContextAsDate(ctx, "#Date"));
		long ts = System.currentTimeMillis();
		MAcctSchema as = MClient.get(ctx).getAcctSchema();

		// 1. PO check
		MProduct poProduct = ZeroCostPostingTestHelper.createStockedProduct(ctx, "InvZeroCostPO_" + ts, DictionaryIDs.M_Product_Category.STANDARD.id, trxName);
		MPriceList poPriceList = ZeroCostPostingTestHelper.createPurchasePriceList(ctx, "Inv Purchase PO " + ts, today, poProduct.get_ID(), BigDecimal.ONE, trxName);

		// 2. Production check
		MProduct component = ZeroCostPostingTestHelper.createStockedProduct(ctx, "InvZeroCostComp_" + ts, DictionaryIDs.M_Product_Category.STANDARD.id, trxName);
		MPriceList compPriceList = ZeroCostPostingTestHelper.createPurchasePriceList(ctx, "Inv Purchase Comp " + ts, today, component.get_ID(), BigDecimal.ONE, trxName);
		MProduct bomParent = ZeroCostPostingTestHelper.createStockedProduct(ctx, "InvZeroCostBOM_" + ts, DictionaryIDs.M_Product_Category.STANDARD.id, trxName);
		bomParent.setIsBOM(true);
		bomParent.setIsPurchased(false);
		bomParent.saveEx();

		// 3. Free purchase price list check (Standard Costing category with 0 standard cost)
		MProductCategory stdCategory = ZeroCostPostingTestHelper.createStandardCostingCategory(ctx, "Inv StdCost ZeroPL " + ts, trxName);
		MProduct plProduct = ZeroCostPostingTestHelper.createStockedProduct(ctx, "InvZeroCostPL_" + ts, stdCategory.get_ID(), trxName);
		ZeroCostPostingTestHelper.createPurchasePriceList(ctx, "Inv Free PL " + ts, today, plProduct.get_ID(), BigDecimal.ZERO, trxName);
		MPriceList positivePL = ZeroCostPostingTestHelper.createPurchasePriceList(ctx, "Inv Positive PL " + ts, today, plProduct.get_ID(), new BigDecimal("5"), trxName);
		MProductPrice positivePP = MProductPrice.get(ctx, positivePL.getPriceListVersion(today).get_ID(), plProduct.get_ID(), trxName);
		assertNotNull(positivePP);

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> categoryMock = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSysConfig> sysConfigMock = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			ZeroCostPostingTestHelper.mockProductGet(productMock, poProduct);
			ZeroCostPostingTestHelper.mockProductGet(productMock, component);
			ZeroCostPostingTestHelper.mockProductGet(productMock, bomParent);
			ZeroCostPostingTestHelper.mockProductGet(productMock, plProduct);
			ZeroCostPostingTestHelper.mockProductCategoryGet(categoryMock, stdCategory);
			ZeroCostPostingTestHelper.mockPriceListGet(priceListMock, poPriceList);
			ZeroCostPostingTestHelper.mockPriceListGet(priceListMock, compPriceList);

			// Setup PO zero-cost detail for poProduct
			createZeroCostPOAndReceipt(poProduct, poPriceList.get_ID(), today, BigDecimal.TEN);

			// Setup Production zero-cost detail for bomParent
			createZeroCostPOAndReceipt(component, compPriceList.get_ID(), today, BigDecimal.TEN);
			MPPProductBOM bom = new MPPProductBOM(ctx, 0, trxName);
			bom.setM_Product_ID(bomParent.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(bomParent.getName());
			bom.saveEx();
			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(component.get_ID());
			bomLine.setQtyBOM(BigDecimal.ONE);
			bomLine.saveEx();
			bomParent.load(trxName);
			bomParent.setIsVerified(true);
			bomParent.saveEx();

			MProduction production = new MProduction(ctx, 0, trxName);
			production.setM_Product_ID(bomParent.get_ID());
			production.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			production.setIsUseProductionPlan(false);
			production.setMovementDate(today);
			production.setDocAction(DocAction.ACTION_Complete);
			production.setDocStatus(DocAction.STATUS_Drafted);
			production.setIsComplete(false);
			production.setProductionQty(new BigDecimal("5"));
			production.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production.saveEx();

			MProcess process = MProcess.get(ctx, DictionaryIDs.AD_Process.CREATE_UPDATE_PRODUCTION_LINES.id);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production.get_ID());
			pi.setTransactionName(trxName);
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			production.load(trxName);
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			production.load(trxName);
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus());
			if (!production.isPosted()) {
				String error = DocumentEngine.postImmediate(ctx, production.getAD_Client_ID(), production.get_Table_ID(), production.get_ID(), false, trxName);
				assertNull(error, error);
			}

			// Test 1: Physical Inventory for poProduct respects CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);
			MInventory invPO = createAndCompletePhysicalInventory(poProduct.get_ID(), as.getCostingMethod(), BigDecimal.TEN, new BigDecimal("5"));
			assertFalse(invPO.isPosted(), "Inventory for PO zero-cost product should not post when SysConfig checks are disabled");

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, true, true);
			String error = DocumentEngine.postImmediate(ctx, invPO.getAD_Client_ID(), invPO.get_Table_ID(), invPO.get_ID(), true, trxName);
			assertNotNull(error, "Expected posting error when CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING is false");
			invPO.load(trxName);
			assertFalse(invPO.isPosted());

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, false, false);
			error = DocumentEngine.postImmediate(ctx, invPO.getAD_Client_ID(), invPO.get_Table_ID(), invPO.get_ID(), true, trxName);
			assertNull(error, error);
			invPO.load(trxName);
			assertTrue(invPO.isPosted(), "Inventory should post when CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING is true");

			// Test 2: Physical Inventory for bomParent respects CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);
			MInventory invProd = createAndCompletePhysicalInventory(bomParent.get_ID(), as.getCostingMethod(), new BigDecimal("5"), new BigDecimal("3"));
			assertFalse(invProd.isPosted(), "Inventory for production zero-cost product should not post when SysConfig checks are disabled");

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, false, true);
			error = DocumentEngine.postImmediate(ctx, invProd.getAD_Client_ID(), invProd.get_Table_ID(), invProd.get_ID(), true, trxName);
			assertNotNull(error, "Expected posting error when CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING is false");
			invProd.load(trxName);
			assertFalse(invProd.isPosted());

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, true, false);
			error = DocumentEngine.postImmediate(ctx, invProd.getAD_Client_ID(), invProd.get_Table_ID(), invProd.get_ID(), true, trxName);
			assertNull(error, error);
			invProd.load(trxName);
			assertTrue(invProd.isPosted(), "Inventory should post when CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING is true");

			// Test 3: Physical Inventory for plProduct respects CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);
			MInventory invPL = createAndCompletePhysicalInventory(plProduct.get_ID(), as.getCostingMethod(), BigDecimal.ZERO, new BigDecimal("5"));
			assertFalse(invPL.isPosted(), "Inventory for free purchase price list product should not post when SysConfig checks are disabled");

			error = DocumentEngine.postImmediate(ctx, invPL.getAD_Client_ID(), invPL.get_Table_ID(), invPL.get_ID(), true, trxName);
			assertNotNull(error, "Expected posting error when CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING is false");

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, true, true);
			error = DocumentEngine.postImmediate(ctx, invPL.getAD_Client_ID(), invPL.get_Table_ID(), invPL.get_ID(), true, trxName);
			assertNotNull(error, "Expected posting error when an active positive purchase price list exists");
			invPL.load(trxName);
			assertFalse(invPL.isPosted());

			positivePP.setIsActive(false);
			positivePP.saveEx();

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, true);
			error = DocumentEngine.postImmediate(ctx, invPL.getAD_Client_ID(), invPL.get_Table_ID(), invPL.get_ID(), true, trxName);
			assertNull(error, error);
			invPL.load(trxName);
			assertTrue(invPL.isPosted(), "Inventory should post once only zero purchase price list is active");
		}
	}

	private void createZeroCostPOAndReceipt(MProduct product, int M_PriceList_ID, Timestamp date, BigDecimal qty) {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setM_PriceList_ID(M_PriceList_ID);
		order.setDateOrdered(date);
		order.setDatePromised(date);
		order.saveEx();

		MOrderLine line = new MOrderLine(order);
		line.setLine(10);
		line.setProduct(product);
		line.setQty(qty);
		line.setPriceList(BigDecimal.ONE);
		line.setPrice(BigDecimal.ZERO);
		line.setDatePromised(date);
		line.saveEx();
		assertEquals(0, line.getPriceActual().signum(), "Expected zero price on PO line");

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, date);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(line, 0, qty);
		receiptLine.setQty(qty);
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		if (!receipt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
		for (MMatchPO matchPO : MMatchPO.getInOut(Env.getCtx(), receipt.get_ID(), getTrxName())) {
			if (!matchPO.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), matchPO.getAD_Client_ID(), matchPO.get_Table_ID(), matchPO.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
		}
	}

	private MInventory createAndCompletePhysicalInventory(int M_Product_ID, String costingMethod, BigDecimal qtyBook, BigDecimal qtyCount) {
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.setCostingMethod(costingMethod);
		inventory.saveEx();

		MInventoryLine iline = new MInventoryLine(inventory, DictionaryIDs.M_Locator.HQ.id, M_Product_ID, 0, qtyBook, qtyCount);
		iline.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		inventory.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
		return inventory;
	}
}
