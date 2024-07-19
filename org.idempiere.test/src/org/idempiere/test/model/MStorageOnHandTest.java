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
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MLocator;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MStorageOnHandTest extends AbstractTestCase {

	public MStorageOnHandTest() {
	}

	@Test
	public void testGetAll() {
		//storageonhand api doesn't use trx to retrieve product 
		MProduct product = new MProduct(Env.getCtx(), 0, null);
		product.setName("testGetAll");
		product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		product.setIsStocked(true);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();
				
		try {
			Timestamp today = TimeUtil.getDay(null);
			Timestamp tomorrow = TimeUtil.addDays(today, 1);
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product.get_ID(), 0, new BigDecimal("1"), today, getTrxName());
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.STORE.id, product.get_ID(), 0, new BigDecimal("2"), tomorrow, getTrxName());
			
			MStorageOnHand[] onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), DictionaryIDs.M_Locator.HQ.id, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(1, onhands.length);
			assertEquals(DictionaryIDs.M_Locator.HQ.id, onhands[0].getM_Locator_ID());
			assertEquals(1, onhands[0].getQtyOnHand().intValue());
			
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), DictionaryIDs.M_Locator.STORE.id, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(1, onhands.length);
			assertEquals(DictionaryIDs.M_Locator.STORE.id, onhands[0].getM_Locator_ID());
			assertEquals(2, onhands[0].getQtyOnHand().intValue());
			
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			
			//test locator priority
			MLocator locator = new MLocator(Env.getCtx(), DictionaryIDs.M_Locator.STORE.id, getTrxName());
			locator.setPriorityNo(Integer.MAX_VALUE);
			locator.saveEx();
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, true, true, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			assertEquals(DictionaryIDs.M_Locator.STORE.id, onhands[0].getM_Locator_ID());
			assertEquals(2, onhands[0].getQtyOnHand().intValue());
			
			//test fifo
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, true, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			assertEquals(DictionaryIDs.M_Locator.HQ.id, onhands[0].getM_Locator_ID());
			assertEquals(1, onhands[0].getQtyOnHand().intValue());
			
			//test lifo
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, false, getTrxName(), false, 0);
			assertNotNull(onhands);
			assertEquals(2, onhands.length);
			assertEquals(DictionaryIDs.M_Locator.STORE.id, onhands[0].getM_Locator_ID());
			assertEquals(2, onhands[0].getQtyOnHand().intValue());
			
			//test UseGuaranteeDateForMPolicy
			onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, true, getTrxName(), false, 0);
			assertEquals(DictionaryIDs.M_Locator.HQ.id, onhands[0].getM_Locator_ID());
			assertEquals(1, onhands[0].getQtyOnHand().intValue());
			MAttributeSet as = new MAttributeSet(Env.getCtx(), DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id, null);
			try {
				as.setUseGuaranteeDateForMPolicy(true);
				as.saveEx();			
				MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
				asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
				asi1.setGuaranteeDate(tomorrow);
				asi1.saveEx();
				DB.executeUpdateEx("UPDATE M_StorageOnHand SET M_AttributeSetInstance_ID=? WHERE M_StorageOnHand_UU=?", new Object[] {asi1.get_ID(), onhands[0].getM_StorageOnHand_UU()}, getTrxName());
				MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
				asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
				asi2.setGuaranteeDate(today);
				asi2.saveEx();
				DB.executeUpdateEx("UPDATE M_StorageOnHand SET M_AttributeSetInstance_ID=? WHERE M_StorageOnHand_UU=?", new Object[] {asi2.get_ID(), onhands[1].getM_StorageOnHand_UU()}, getTrxName());
				CacheMgt.get().reset(MProduct.Table_Name, product.get_ID());
				onhands = MStorageOnHand.getAll(Env.getCtx(), product.get_ID(), 0, false, true, getTrxName(), false, 0);
				assertEquals(asi2.get_ID(), onhands[0].getM_AttributeSetInstance_ID());
				assertEquals(DictionaryIDs.M_Locator.STORE.id, onhands[0].getM_Locator_ID());
				assertEquals(2, onhands[0].getQtyOnHand().intValue());
			} finally {
				as.setUseGuaranteeDateForMPolicy(false);
				as.saveEx();
			}
		} finally {
			rollback();
			product.deleteEx(true);			
		}
	}
	
	@Test
	public void testGetM_Locator_ID() {
		MLocator hqLocator = new MLocator(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, getTrxName());
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
		product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		product.setIsStocked(true);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();
		
		Timestamp today = TimeUtil.getDay(null);
		MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product.get_ID(), 0, new BigDecimal("2"), today, getTrxName());
		MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		asi1.setLot("Lot1");
		asi1.saveEx();		
		MStorageOnHand.add(Env.getCtx(), hqLocator1.get_ID(), product.get_ID(), asi1.get_ID(), new BigDecimal("1"), today, getTrxName());
				
		//get asi=0
		int M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), 0, new BigDecimal("1"), getTrxName());
		assertEquals(DictionaryIDs.M_Locator.HQ.id, M_Locator_ID);
		//get asi>0
		M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), asi1.get_ID(), new BigDecimal("1"), getTrxName());
		assertEquals(hqLocator1.get_ID(), M_Locator_ID);
		//check all asi and get locator with highest onhand
		M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), -1, new BigDecimal("1"), getTrxName());		
		assertEquals(DictionaryIDs.M_Locator.HQ.id, M_Locator_ID);
		MStorageOnHand.add(Env.getCtx(), hqLocator1.get_ID(), product.get_ID(), asi1.get_ID(), new BigDecimal("2"), today, getTrxName());
		M_Locator_ID = MStorageOnHand.getM_Locator_ID(hqLocator.getM_Warehouse_ID(), product.get_ID(), -1, new BigDecimal("1"), getTrxName());
		assertEquals(hqLocator1.get_ID(), M_Locator_ID);
	}		
}
