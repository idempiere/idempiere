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
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
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
	
	private void createPOAndMRForProduct(int productId) {
		createPOAndMRForProduct(productId, null);
	}
	
	private void createPOAndMRForProduct(int productId, MAttributeSetInstance asi) {
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
	}
}
