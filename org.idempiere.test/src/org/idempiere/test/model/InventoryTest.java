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
import java.util.Arrays;
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
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MWarehouse;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Carlos Ruiz - globalqss
 */
public class InventoryTest extends AbstractTestCase {

	public InventoryTest() {
	}

	private static final int PRODCAT_BUSHES = 107;
	private static final int TAXCAT_STANDARD = 107;
	private static final int UOM_EACH = 100;
	private static final int WAREHOUSE_HQ = 103;
	private static final int LOCATOR_HQ = 101;
	private static final int DOCTYPE_PHYSICAL_INV = 144;
	private static final int DOCTYPE_COST_ADJUSTMENT = 200004;
	private static final int DOCTYPE_PO = 126;
	private static final int DOCTYPE_RECEIPT = 122;
	private static final int BP_PATIO = 121;
	private static final int USER_GARDENADMIN = 101;
	private static final int MULCH_PRODUCT_ID = 137;
	private final static int FERTILIZER_LOT_ATTRIBUTESET_ID = 101;
	private static final int CHEMICALS_CATEGORY_ID = 109;
	private static final int PURCHASE_PRICE_LIST_ID = 102;

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4596
	 */
	@Test
	public void testCreateAProductAndInventory() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = new MProduct(ctx, 0, trxName);
		product.setM_Product_Category_ID(PRODCAT_BUSHES);
		product.setName("Test 4596");
		product.setValue("T4596");
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(UOM_EACH);
		product.setC_TaxCategory_ID(TAXCAT_STANDARD);
		product.saveEx();

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(WAREHOUSE_HQ);
		inventory.setC_DocType_ID(DOCTYPE_PHYSICAL_INV);
		inventory.saveEx();

		MInventoryLine iline = new MInventoryLine(inventory,
				LOCATOR_HQ, 
				product.getM_Product_ID(),
				0, // M_AttributeSetInstance_ID
				Env.ZERO, // QtyBook
				Env.ONEHUNDRED);
		iline.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		inventory.load(trxName);
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
	}

	@Test
	public void testCostAdjustmentLineBeforeSave() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		MProduct product = new MProduct(Env.getCtx(), MULCH_PRODUCT_ID, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0) {
			createPOAndMRForProduct(MULCH_PRODUCT_ID);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost);
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DOCTYPE_COST_ADJUSTMENT);
		inventory.setCostingMethod(as.getCostingMethod());
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(MULCH_PRODUCT_ID);
		line.setNewCostPrice(cost.getCurrentCostPrice().add(new BigDecimal("0.5")));
		line.saveEx();
		
		assertNotEquals(0, line.getLine(), "Unexpected Line No");
		assertEquals(cost.getCurrentCostPrice(), line.getCurrentCostPrice());
	}
	
	private void createPOAndMRForProduct(int productId) {
		createPOAndMRForProduct(productId, null);
	}
	
	private void createPOAndMRForProduct(int productId, MAttributeSetInstance asi) {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_PATIO));
		order.setC_DocTypeTarget_ID(DOCTYPE_PO);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(USER_GARDENADMIN);
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
		assertFalse(info.isError());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
		
		MInOut receipt1 = new MInOut(order, DOCTYPE_RECEIPT, order.getDateOrdered());
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
		assertFalse(info.isError());
		receipt1.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
		if (!receipt1.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
	}
	
	@Test
	public void testSkipProductWithSerial() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		
		MAttributeSet set = new MAttributeSet(Env.getCtx(), FERTILIZER_LOT_ATTRIBUTESET_ID, null);
		set.setIsSerNo(true);
		set.saveEx();
			
		MWarehouse wh = new MWarehouse(Env.getCtx(), WAREHOUSE_HQ, null);
		boolean disallow = wh.isDisallowNegativeInv(); 
		MProduct product = null;
		try {
			
			if (!disallow) {
				wh.setIsDisallowNegativeInv(true);
				wh.saveEx();
				CacheMgt.get().reset(MWarehouse.Table_Name, wh.get_ID());
			}
			
			product = new MProduct(ctx, 0, null);
			product.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
			product.setName("testSkipProductWithSerial");
			product.setValue("testSkipProductWithSerial");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(UOM_EACH);
			product.setC_TaxCategory_ID(TAXCAT_STANDARD);
			product.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			product.saveEx();
	
			MPriceListVersion plv = MPriceList.get(PURCHASE_PRICE_LIST_ID).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			asi.setSerNo("testSkipProductWithSerial #1");
			asi.saveEx();
			
			createPOAndMRForProduct(product.get_ID(), asi);
			
			MStorageOnHand[] onhands = MStorageOnHand.getOfProduct(Env.getCtx(), product.get_ID(), getTrxName());
			assertEquals(1, onhands.length, "Unexpected number of on hand records");
			assertEquals(onhands[0].getM_AttributeSetInstance_ID(), asi.get_ID(), "Unexpected M_AttributeSetInstance_ID for on hand record");
			
			MInventory inventory = new MInventory(ctx, 0, trxName);
			inventory.setM_Warehouse_ID(WAREHOUSE_HQ);
			inventory.setC_DocType_ID(DOCTYPE_PHYSICAL_INV);
			inventory.saveEx();
	
			MInventoryLine iline = new MInventoryLine(inventory,
					LOCATOR_HQ, 
					product.getM_Product_ID(),
					0, // M_AttributeSetInstance_ID
					Env.ONE, // QtyBook
					Env.ZERO);
			iline.saveEx();
	
			//show error out with negative on hand (skip the only asi record with serno)
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			assertTrue(info.isError(), info.getSummary());
		} finally {
			rollback();
			set.setIsSerNo(false);
			set.saveEx();
			
			if (product != null) 
				product.deleteEx(true);
			
			if (!disallow) {
				wh.setIsDisallowNegativeInv(false);
				wh.saveEx();
				CacheMgt.get().reset(MWarehouse.Table_Name, wh.get_ID());
			}
		}
	}
	
	@Test
	public void testSkipProductWithSerial2() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		
		MAttributeSet set = new MAttributeSet(Env.getCtx(), FERTILIZER_LOT_ATTRIBUTESET_ID, null);
		set.setIsSerNo(true);
		set.saveEx();
			
		MWarehouse wh = new MWarehouse(Env.getCtx(), WAREHOUSE_HQ, null);
		boolean disallow = wh.isDisallowNegativeInv(); 
		MProduct product = null;
		try {
			
			if (!disallow) {
				wh.setIsDisallowNegativeInv(true);
				wh.saveEx();
				CacheMgt.get().reset(MWarehouse.Table_Name, wh.get_ID());
			}
			
			product = new MProduct(ctx, 0, null);
			product.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
			product.setName("testSkipProductWithSerial");
			product.setValue("testSkipProductWithSerial");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(UOM_EACH);
			product.setC_TaxCategory_ID(TAXCAT_STANDARD);
			product.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			product.saveEx();
	
			MPriceListVersion plv = MPriceList.get(PURCHASE_PRICE_LIST_ID).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			asi.setSerNo("testSkipProductWithSerial #1");
			asi.saveEx();
			
			createPOAndMRForProduct(product.get_ID(), asi);
						
			MStorageOnHand[] onhands = MStorageOnHand.getOfProduct(Env.getCtx(), product.get_ID(), getTrxName());
			assertEquals(1, onhands.length, "Unexpected number of on hand records");
			assertEquals(onhands[0].getM_AttributeSetInstance_ID(), asi.get_ID(), "Unexpected M_AttributeSetInstance_ID for on hand record");
			
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			asi1.saveEx();

			createPOAndMRForProduct(product.get_ID(), asi1);
			
			onhands = MStorageOnHand.getOfProduct(Env.getCtx(), product.get_ID(), getTrxName());
			assertEquals(2, onhands.length, "Unexpected number of on hand records");
			Arrays.sort(onhands, new MStorageOnHand(Env.getCtx(), 0, null));
			assertEquals(onhands[0].getM_AttributeSetInstance_ID(), asi.get_ID(), "Unexpected M_AttributeSetInstance_ID for first on hand record");
			assertEquals(onhands[1].getM_AttributeSetInstance_ID(), asi1.get_ID(), "Unexpected M_AttributeSetInstance_ID for second on hand record");
			
			MInventory inventory = new MInventory(ctx, 0, trxName);
			inventory.setM_Warehouse_ID(WAREHOUSE_HQ);
			inventory.setC_DocType_ID(DOCTYPE_PHYSICAL_INV);
			inventory.saveEx();
	
			MInventoryLine iline = new MInventoryLine(inventory,
					LOCATOR_HQ, 
					product.getM_Product_ID(),
					0, // M_AttributeSetInstance_ID
					new BigDecimal("2"), // QtyBook
					new BigDecimal("1"));
			iline.saveEx();
	
			//should success with qty difference being applied to the asi with null serno record
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			inventory.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
			
			onhands = MStorageOnHand.getOfProduct(Env.getCtx(), product.get_ID(), getTrxName());
			assertEquals(2, onhands.length, "Unexpected number of on hand records");
			Arrays.sort(onhands, new MStorageOnHand(Env.getCtx(), 0, null));
			assertEquals(onhands[0].getM_AttributeSetInstance_ID(), asi.get_ID(), "Unexpected M_AttributeSetInstance_ID for first on hand record");
			assertEquals(onhands[1].getM_AttributeSetInstance_ID(), asi1.get_ID(), "Unexpected M_AttributeSetInstance_ID for second on hand record");
			assertEquals(1, onhands[0].getQtyOnHand().intValue());
			assertEquals(0, onhands[1].getQtyOnHand().intValue());
		} finally {
			rollback();
			set.setIsSerNo(false);
			set.saveEx();
			
			if (product != null) 
				product.deleteEx(true);
			
			if (!disallow) {
				wh.setIsDisallowNegativeInv(false);
				wh.saveEx();
				CacheMgt.get().reset(MWarehouse.Table_Name, wh.get_ID());
			}
		}
	}
}
