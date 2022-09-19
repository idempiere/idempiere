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

import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
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
public class MStorageOnHandTestIsolated extends AbstractTestCase {

	public MStorageOnHandTestIsolated() {
	}

	@Test
	public void testStorageCleanUp() {
		MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setName("testStorageCleanUp");
		product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		product.setIsStocked(true);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();
		
		Timestamp today = TimeUtil.getDay(null);
		MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product.get_ID(), 0, new BigDecimal("2"), today, getTrxName());
		Query query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
		int count = query.setParameters(product.get_ID()).count();
		assertEquals(1, count);
		
		MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product.get_ID(), 0, new BigDecimal("-2"), today, getTrxName());
		DB.executeUpdateEx("UPDATE M_StorageOnHand SET Created=? WHERE M_Product_ID=?", new Object[] {TimeUtil.addDays(today, -7), product.get_ID()}, getTrxName());
		query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
		count = query.setParameters(product.get_ID()).count();
		assertEquals(1, count);
		
		//movement get product from cache
		MProduct product1 = new MProduct(Env.getCtx(), 0, null);
		product1.setName("testStorageCleanUp#1");
		product1.setValue(product1.getName());
		product1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		product1.setIsStocked(true);
		product1.setProductType(MProduct.PRODUCTTYPE_Item);
		product1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
		product1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product1.saveEx();
		
		try {
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("Lot1");
			asi1.saveEx();		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product1.get_ID(), asi1.get_ID(), new BigDecimal("-1"), today, getTrxName());		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product1.get_ID(), 0, new BigDecimal("1"), today, getTrxName());
			
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
			product2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			product2.setIsStocked(true);
			product2.setProductType(MProduct.PRODUCTTYPE_Item);
			product2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product2.saveEx();
			
			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi2.setLot("LotX");
			asi2.saveEx();		
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product2.get_ID(), asi2.get_ID(), new BigDecimal("-1"), today, getTrxName());
			
			MAttributeSetInstance asi3 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi3.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi3.setLot("LotY");
			asi3.saveEx();
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product2.get_ID(), asi3.get_ID(), new BigDecimal("1"), today, getTrxName());
			
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
			product3.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			product3.setIsStocked(true);
			product3.setProductType(MProduct.PRODUCTTYPE_Item);
			product3.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product3.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product3.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product3.saveEx();
			
			MAttributeSetInstance asi4 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi4.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi4.setSerNo(product3.getName()+"SerialNo#1");
			asi4.saveEx();
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product3.get_ID(), asi4.get_ID(), new BigDecimal("1"), today, getTrxName());
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
			count = query.setParameters(product3.get_ID()).count();
			assertEquals(1, count);
			
			MStorageOnHand.add(Env.getCtx(), DictionaryIDs.M_Locator.HQ.id, product3.get_ID(), asi4.get_ID(), new BigDecimal("-1"), today, getTrxName());
			DB.executeUpdateEx("UPDATE M_StorageOnHand SET Created=? WHERE M_Product_ID=?", new Object[] {TimeUtil.addDays(today, -7), product3.get_ID()}, getTrxName());
			query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
			count = query.setParameters(product3.get_ID()).count();
			assertEquals(1, count);
			
			MPInstance instance = new MPInstance(Env.getCtx(), SystemIDs.PROCESS_M_StorageCleanup, 0);
			instance.saveEx();
			MPInstancePara para = new MPInstancePara(instance, 10);
			para.setParameterName("C_DocType_ID");
			para.setP_Number(DictionaryIDs.C_DocType.MATERIAL_MOVEMENT.id);
			para.saveEx();
			
			MProcess process = MProcess.get(Env.getCtx(), SystemIDs.PROCESS_M_StorageCleanup);
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
