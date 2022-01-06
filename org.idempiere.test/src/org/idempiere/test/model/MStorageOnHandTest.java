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

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MLocator;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MStorageOnHandTest extends AbstractTestCase {

	private final static int FERTILIZER_LOT_ATTRIBUTESET_ID = 101;
	private final static int HQ_LOCATOR_ID = 101;
	private final static int STORE_LOCATOR_ID = 102;
	private static final int TAX_CATEGORY_STANDARD_ID = 107;
	private static final int CHEMICALS_CATEGORY_ID = 109;
	private static final int UOM_EACH_ID = 100;
	private static final int STORAGE_CLEANUP_PROCESS_ID = 325;
	private static final int MATERIAL_MOVEMENT_DOCTYPE_ID = 143;
	
	public MStorageOnHandTest() {
	}

	@Test
	public void testGetAll() {
		//storageonhand api doesn't use trx to retrieve product 
		MProduct product = new MProduct(Env.getCtx(), 0, null);
		product.setName("testGetAll");
		product.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
		product.setIsStocked(true);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setC_UOM_ID(UOM_EACH_ID);
		product.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
		product.setC_TaxCategory_ID(TAX_CATEGORY_STANDARD_ID);
		product.saveEx();
				
		try {
			Timestamp today = TimeUtil.getDay(null);
			Timestamp tomorrow = TimeUtil.addDays(today, 1);
			MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product.get_ID(), 0, new BigDecimal("1"), today, getTrxName());
			MStorageOnHand.add(Env.getCtx(), STORE_LOCATOR_ID, product.get_ID(), 0, new BigDecimal("2"), tomorrow, getTrxName());
			
			MStorageOnHand[] onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), HQ_LOCATOR_ID, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(1, onhands.length);
			assertEquals(HQ_LOCATOR_ID, onhands[0].getM_Locator_ID());
			assertEquals(1, onhands[0].getQtyOnHand().intValue());
			
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), STORE_LOCATOR_ID, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(1, onhands.length);
			assertEquals(STORE_LOCATOR_ID, onhands[0].getM_Locator_ID());
			assertEquals(2, onhands[0].getQtyOnHand().intValue());
			
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			
			//test locator priority
			MLocator locator = new MLocator(Env.getCtx(), STORE_LOCATOR_ID, getTrxName());
			locator.setPriorityNo(Integer.MAX_VALUE);
			locator.saveEx();
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, true, true, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			assertEquals(STORE_LOCATOR_ID, onhands[0].getM_Locator_ID());
			assertEquals(2, onhands[0].getQtyOnHand().intValue());
			
			//test fifo
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, true, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			assertEquals(HQ_LOCATOR_ID, onhands[0].getM_Locator_ID());
			assertEquals(1, onhands[0].getQtyOnHand().intValue());
			
			//test lifo
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, false, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			assertEquals(STORE_LOCATOR_ID, onhands[0].getM_Locator_ID());
			assertEquals(2, onhands[0].getQtyOnHand().intValue());
			
			//test UseGuaranteeDateForMPolicy
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, true, getTrxName(), false, 0);
			assertEquals(HQ_LOCATOR_ID, onhands[0].getM_Locator_ID());
			assertEquals(1, onhands[0].getQtyOnHand().intValue());
			MAttributeSet as = new MAttributeSet(Env.getCtx(), FERTILIZER_LOT_ATTRIBUTESET_ID, null);
			try {
				as.setUseGuaranteeDateForMPolicy(true);
				as.saveEx();			
				MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
				asi1.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
				asi1.setGuaranteeDate(tomorrow);
				asi1.saveEx();
				DB.executeUpdateEx("UPDATE M_StorageOnHand SET M_AttributeSetInstance_ID=? WHERE M_StorageOnHand_UU=?", new Object[] {asi1.get_ID(), onhands[0].getM_StorageOnHand_UU()}, getTrxName());
				MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
				asi2.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
				asi2.setGuaranteeDate(today);
				asi2.saveEx();
				DB.executeUpdateEx("UPDATE M_StorageOnHand SET M_AttributeSetInstance_ID=? WHERE M_StorageOnHand_UU=?", new Object[] {asi2.get_ID(), onhands[1].getM_StorageOnHand_UU()}, getTrxName());
				CacheMgt.get().reset(MProduct.Table_Name, product.get_ID());
				onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, true, getTrxName(), false, 0);
				assertEquals(asi2.get_ID(), onhands[0].getM_AttributeSetInstance_ID());
				assertEquals(STORE_LOCATOR_ID, onhands[0].getM_Locator_ID());
				assertEquals(2, onhands[0].getQtyOnHand().intValue());
			} finally {
				as.setUseGuaranteeDateForMPolicy(false);
				as.saveEx();
			}
		} finally {
			product.deleteEx(true);			
		}
	}
	
	@Test
	public void testGetM_Locator_ID() {
		MLocator hqLocator = new MLocator(Env.getCtx(), HQ_LOCATOR_ID, getTrxName());
		MLocator hqLocator1 = new MLocator(Env.getCtx(), 0, getTrxName());
		hqLocator1.setM_Warehouse_ID(hqLocator.getM_Warehouse_ID());
		hqLocator1.setValue("HQ Locator 1");
		hqLocator1.setPriorityNo(hqLocator.getPriorityNo());
		hqLocator1.setX("x");
		hqLocator1.setY("y");
		hqLocator1.setZ("z");
		hqLocator1.saveEx();
		
		MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setName("testGetM_Locator_ID");
		product.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
		product.setIsStocked(true);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setC_UOM_ID(UOM_EACH_ID);
		product.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
		product.setC_TaxCategory_ID(TAX_CATEGORY_STANDARD_ID);
		product.saveEx();
		
		Timestamp today = TimeUtil.getDay(null);
		MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product.get_ID(), 0, new BigDecimal("2"), today, getTrxName());
		MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi1.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
		asi1.setLot("Lot1");
		asi1.saveEx();		
		MStorageOnHand.add(Env.getCtx(), hqLocator1.get_ID(), product.get_ID(), asi1.get_ID(), new BigDecimal("1"), today, getTrxName());
				
		//get asi=0
		int M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), 0, new BigDecimal("1"), getTrxName());
		assertEquals(HQ_LOCATOR_ID, M_Locator_ID);
		//get asi>0
		M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), asi1.get_ID(), new BigDecimal("1"), getTrxName());
		assertEquals(hqLocator1.get_ID(), M_Locator_ID);
		//check all asi and get locator with highest onhand
		M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), -1, new BigDecimal("1"), getTrxName());		
		assertEquals(HQ_LOCATOR_ID, M_Locator_ID);
		MStorageOnHand.add(Env.getCtx(), hqLocator1.get_ID(), product.get_ID(), asi1.get_ID(), new BigDecimal("2"), today, getTrxName());
		M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), -1, new BigDecimal("1"), getTrxName());
		assertEquals(hqLocator1.get_ID(), M_Locator_ID);
	}
	
	@Test
	public void testStorageCleanUp() {
		MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setName("testStorageCleanUp");
		product.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
		product.setIsStocked(true);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setC_UOM_ID(UOM_EACH_ID);
		product.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
		product.setC_TaxCategory_ID(TAX_CATEGORY_STANDARD_ID);
		product.saveEx();
		
		Timestamp today = TimeUtil.getDay(null);
		MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product.get_ID(), 0, new BigDecimal("2"), today, getTrxName());
		Query query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
		int count = query.setParameters(product.get_ID()).count();
		assertEquals(1, count);
		
		MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product.get_ID(), 0, new BigDecimal("-2"), today, getTrxName());
		DB.executeUpdateEx("UPDATE M_StorageOnHand SET Created=? WHERE M_Product_ID=?", new Object[] {TimeUtil.addDays(today, -7), product.get_ID()}, getTrxName());
		query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
		count = query.setParameters(product.get_ID()).count();
		assertEquals(1, count);
		
		//movement get product from cache
		MProduct product1 = new MProduct(Env.getCtx(), 0, null);
		product1.setName("testStorageCleanUp#1");
		product1.setValue(product1.getName());
		product1.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
		product1.setIsStocked(true);
		product1.setProductType(MProduct.PRODUCTTYPE_Item);
		product1.setC_UOM_ID(UOM_EACH_ID);
		product1.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
		product1.setC_TaxCategory_ID(TAX_CATEGORY_STANDARD_ID);
		product1.saveEx();
		
		try {
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			asi1.setLot("Lot1");
			asi1.saveEx();		
			MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product1.get_ID(), asi1.get_ID(), new BigDecimal("-1"), today, getTrxName());		
			MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product1.get_ID(), 0, new BigDecimal("1"), today, getTrxName());
			
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			MStorageOnHand onhand = query.setParameters(product1.get_ID(), asi1.get_ID()).first();
			assertNotNull(onhand);
			assertEquals(-1, onhand.getQtyOnHand().intValue());
			
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			onhand = query.setParameters(product1.get_ID(), 0).first();
			assertNotNull(onhand);
			assertEquals(1, onhand.getQtyOnHand().intValue());
			
			MProduct product2 = new MProduct(Env.getCtx(), 0, getTrxName());
			product2.setName("testStorageCleanUp#2");
			product2.setValue(product2.getName());
			product2.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			product2.setIsStocked(true);
			product2.setProductType(MProduct.PRODUCTTYPE_Item);
			product2.setC_UOM_ID(UOM_EACH_ID);
			product2.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
			product2.setC_TaxCategory_ID(TAX_CATEGORY_STANDARD_ID);
			product2.saveEx();
			
			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			asi2.setLot("LotX");
			asi2.saveEx();		
			MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product2.get_ID(), asi2.get_ID(), new BigDecimal("-1"), today, getTrxName());
			
			MAttributeSetInstance asi3 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi3.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			asi3.setLot("LotY");
			asi3.saveEx();
			MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product2.get_ID(), asi3.get_ID(), new BigDecimal("1"), today, getTrxName());
			
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			onhand = query.setParameters(product2.get_ID(), asi2.get_ID()).first();
			assertNotNull(onhand);
			assertEquals(-1, onhand.getQtyOnHand().intValue());
			
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			onhand = query.setParameters(product2.get_ID(), asi3.get_ID()).first();
			assertNotNull(onhand);
			assertEquals(1, onhand.getQtyOnHand().intValue());
			
			MProduct product3 = new MProduct(Env.getCtx(), 0, getTrxName());
			product3.setName("testStorageCleanUp#3");
			product3.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			product3.setIsStocked(true);
			product3.setProductType(MProduct.PRODUCTTYPE_Item);
			product3.setC_UOM_ID(UOM_EACH_ID);
			product3.setM_Product_Category_ID(CHEMICALS_CATEGORY_ID);
			product3.setC_TaxCategory_ID(TAX_CATEGORY_STANDARD_ID);
			product3.saveEx();
			
			MAttributeSetInstance asi4 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi4.setM_AttributeSet_ID(FERTILIZER_LOT_ATTRIBUTESET_ID);
			asi4.setSerNo(product3.getName()+"SerialNo#1");
			asi4.saveEx();
			MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product3.get_ID(), asi4.get_ID(), new BigDecimal("1"), today, getTrxName());
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
			count = query.setParameters(product3.get_ID()).count();
			assertEquals(1, count);
			
			MStorageOnHand.add(Env.getCtx(), HQ_LOCATOR_ID, product3.get_ID(), asi4.get_ID(), new BigDecimal("-1"), today, getTrxName());
			DB.executeUpdateEx("UPDATE M_StorageOnHand SET Created=? WHERE M_Product_ID=?", new Object[] {TimeUtil.addDays(today, -7), product3.get_ID()}, getTrxName());
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
			count = query.setParameters(product3.get_ID()).count();
			assertEquals(1, count);
			
			MPInstance instance = new MPInstance(Env.getCtx(), STORAGE_CLEANUP_PROCESS_ID, 0);
			instance.saveEx();
			MPInstancePara para = new MPInstancePara(instance, 10);
			para.setParameterName("C_DocType_ID");
			para.setP_Number(MATERIAL_MOVEMENT_DOCTYPE_ID);
			para.saveEx();
			
			MProcess process = MProcess.get(Env.getCtx(), STORAGE_CLEANUP_PROCESS_ID);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_PInstance_ID(instance.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());
			
			//check 0 stock removed
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
			count = query.setParameters(product.get_ID()).count();
			assertEquals(0, count);
			
			//check 0 stock with serno not removed
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
			List<MStorageOnHand> onhands = query.setParameters(product3.get_ID()).list();
			assertEquals(1, onhands.size());
			assertEquals(0, onhands.get(0).getQtyOnHand().intValue());
			assertEquals(asi4.get_ID(), onhands.get(0).getM_AttributeSetInstance_ID());
			
			//check -1 and 1 consolidated
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			onhand = query.setParameters(product1.get_ID(), asi1.get_ID()).first();
			assertNotNull(onhand);
			assertEquals(0, onhand.getQtyOnHand().intValue());
			
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			onhand = query.setParameters(product1.get_ID(), 0).first();
			assertNotNull(onhand);
			assertEquals(0, onhand.getQtyOnHand().intValue());
			
			//check -1 and 1 not consolidated due to different lot
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			onhand = query.setParameters(product2.get_ID(), asi2.get_ID()).first();
			assertNotNull(onhand);
			assertEquals(-1, onhand.getQtyOnHand().intValue());
			
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
			onhand = query.setParameters(product2.get_ID(), asi3.get_ID()).first();
			assertNotNull(onhand);
			assertEquals(1, onhand.getQtyOnHand().intValue());
		} finally {
			getTrx().rollback();
			product1.deleteEx(true);
		}
	}
}
