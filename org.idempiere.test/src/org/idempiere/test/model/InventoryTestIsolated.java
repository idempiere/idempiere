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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Properties;

import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
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
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * 
 * @author hengsin
 *
 */
@Isolated
public class InventoryTestIsolated extends AbstractTestCase {

	public InventoryTestIsolated() {
	}

	@Test
	public void testSkipProductWithSerial() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		
		MWarehouse wh = new MWarehouse(Env.getCtx(), DictionaryIDs.M_Warehouse.HQ.id, null);
		boolean disallow = wh.isDisallowNegativeInv(); 
		MProduct product = null;
		try {
			
			if (!disallow) {
				wh.setIsDisallowNegativeInv(true);
				wh.saveEx();
				CacheMgt.get().reset(MWarehouse.Table_Name, wh.get_ID());
			}
			
			product = new MProduct(ctx, 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product.setName("testSkipProductWithSerial");
			product.setValue("testSkipProductWithSerial");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
			product.saveEx();
	
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
			asi.setSerNo("testSkipProductWithSerial #1");
			asi.saveEx();
			
			createPOAndMRForProduct(product.get_ID(), asi);
			
			MStorageOnHand[] onhands = MStorageOnHand.getOfProduct(Env.getCtx(), product.get_ID(), getTrxName());
			assertEquals(1, onhands.length, "Unexpected number of on hand records");
			assertEquals(onhands[0].getM_AttributeSetInstance_ID(), asi.get_ID(), "Unexpected M_AttributeSetInstance_ID for on hand record");
			
			MInventory inventory = new MInventory(ctx, 0, trxName);
			inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
			inventory.saveEx();
	
			MInventoryLine iline = new MInventoryLine(inventory,
					DictionaryIDs.M_Locator.HQ.id, 
					product.getM_Product_ID(),
					0, // M_AttributeSetInstance_ID
					Env.ONE, // QtyBook
					Env.ZERO);
			iline.saveEx();
	
			//should error out with negative on hand (skip the only asi record with serno)
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			assertTrue(info.isError(), info.getSummary());
		} finally {
			rollback();
			
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
		
		MWarehouse wh = new MWarehouse(Env.getCtx(), DictionaryIDs.M_Warehouse.HQ.id, null);
		boolean disallow = wh.isDisallowNegativeInv(); 
		MProduct product = null;
		try {
			
			if (!disallow) {
				wh.setIsDisallowNegativeInv(true);
				wh.saveEx();
				CacheMgt.get().reset(MWarehouse.Table_Name, wh.get_ID());
			}
			
			product = new MProduct(ctx, 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product.setName("testSkipProductWithSerial2");
			product.setValue("testSkipProductWithSerial2");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
			product.saveEx();
	
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
			asi.setSerNo("testSkipProductWithSerial2 #1");
			asi.saveEx();
			
			createPOAndMRForProduct(product.get_ID(), asi);
						
			MStorageOnHand[] onhands = MStorageOnHand.getOfProduct(Env.getCtx(), product.get_ID(), getTrxName());
			assertEquals(1, onhands.length, "Unexpected number of on hand records");
			assertEquals(onhands[0].getM_AttributeSetInstance_ID(), asi.get_ID(), "Unexpected M_AttributeSetInstance_ID for on hand record");
			
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
			asi1.saveEx();

			createPOAndMRForProduct(product.get_ID(), asi1);
			
			onhands = MStorageOnHand.getOfProduct(Env.getCtx(), product.get_ID(), getTrxName());
			assertEquals(2, onhands.length, "Unexpected number of on hand records");
			Arrays.sort(onhands, new MStorageOnHand(Env.getCtx(), 0, null));
			assertEquals(onhands[0].getM_AttributeSetInstance_ID(), asi.get_ID(), "Unexpected M_AttributeSetInstance_ID for first on hand record");
			assertEquals(onhands[1].getM_AttributeSetInstance_ID(), asi1.get_ID(), "Unexpected M_AttributeSetInstance_ID for second on hand record");
			
			MInventory inventory = new MInventory(ctx, 0, trxName);
			inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
			inventory.saveEx();
	
			MInventoryLine iline = new MInventoryLine(inventory,
					DictionaryIDs.M_Locator.HQ.id, 
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
			
			if (product != null) 
				product.deleteEx(true);
			
			if (!disallow) {
				wh.setIsDisallowNegativeInv(false);
				wh.saveEx();
				CacheMgt.get().reset(MWarehouse.Table_Name, wh.get_ID());
			}
		}
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
