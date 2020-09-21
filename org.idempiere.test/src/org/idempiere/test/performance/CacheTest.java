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
package org.idempiere.test.performance;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import org.compiere.model.I_AD_Table;
import org.compiere.model.MColumn;
import org.compiere.model.MOrder;
import org.compiere.model.MProduct;
import org.compiere.model.MRefTable;
import org.compiere.model.MTable;
import org.compiere.model.MWarehouse;
import org.compiere.model.MZoomCondition;
import org.compiere.util.CCache;
import org.compiere.util.CacheInterface;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class CacheTest extends AbstractTestCase {

	public CacheTest() {
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-2698
	 */
	public void testZoomConditionCache() {
		MZoomCondition[] conditions1 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions1 != null && conditions1.length > 0);
		MZoomCondition[] conditions2 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions2 != null && conditions2.length > 0);
		assertTrue(conditions1 == conditions2);
		CacheMgt.get().reset();
		MZoomCondition[] conditions3 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions3 != null && conditions3.length == conditions1.length);
		assertTrue(conditions1 != conditions3);
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-2699
	 */
	public void testTableCache() {
		MTable table = MTable.get(Env.getCtx(), MOrder.Table_ID);
		
		//find table cache instance
		@SuppressWarnings("rawtypes")
		CCache tblCache = null;
		CacheInterface[] cis = CacheMgt.get().getInstancesAsArray();
		for(CacheInterface ci : cis) {
			if (ci instanceof CCache<?, ?>) {				
				@SuppressWarnings("rawtypes")
				CCache ccache = (CCache) ci;
				if (ccache.getName().equals(ccache.getTableName()) && ccache.getTableName().equals(MTable.Table_Name)) {
					if (ccache.containsKey(MOrder.Table_ID)) {
						tblCache = ccache;
						break;
					}
				}
			}
		}
			
		if (tblCache == null)
			fail("Table cache instance missing");
		
		long hit = tblCache.getHit();
		
		MColumn column = table.getColumn(MOrder.COLUMNNAME_C_Order_ID);
		@SuppressWarnings("unused")
		I_AD_Table table2 = column.getAD_Table();
		assertEquals(hit+1, tblCache.getHit());
		
		//M_Warehouse of Client
		table = MTable.get(Env.getCtx(), MWarehouse.Table_ID);		
		MRefTable refTable = MRefTable.get(Env.getCtx(), 197);
		
		tblCache = null;
		for(CacheInterface ci : cis) {
			if (ci instanceof CCache<?, ?>) {				
				@SuppressWarnings("rawtypes")
				CCache ccache = (CCache) ci;
				if (ccache.getName().equals(ccache.getTableName()) && ccache.getTableName().equals(MTable.Table_Name)) {
					if (ccache.containsKey(MWarehouse.Table_ID)) {
						tblCache = ccache;
						break;
					}
				}
			}
		}
			
		if (tblCache == null)
			fail("Table cache instance missing");
		
		hit = tblCache.getHit();
		table2 = refTable.getAD_Table();
		assertEquals(hit+1, tblCache.getHit());
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@Test
	public void testPOCacheAfterUpdate() {
		int mulch = 137;
		int oak = 123;
		//init cache
		MProduct p1 = MProduct.get(Env.getCtx(), mulch);
		CCache<Integer, MProduct> pc = null;
		CacheInterface[] cis = CacheMgt.get().getInstancesAsArray();
		//find product cache instance
		for(CacheInterface ci : cis) {
			if (ci instanceof CCache<?, ?>) {				
				CCache ccache = (CCache) ci;
				if (ccache.getName().equals(ccache.getTableName()) && ccache.getTableName().equals(MProduct.Table_Name)) {
					if (ccache.containsKey(mulch)) {
						pc = ccache;
						break;
					}
				}
			}
		}
		
		if (pc == null)
			fail("Product cache instance missing");
		
		//second get, hit should increase
		long hit = pc.getHit();
		p1 = MProduct.get(Env.getCtx(), mulch);
		assertEquals(mulch, p1.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Second get of product Mulch, cache hit should increase");
		
		//first get for p2, miss should increase
		long miss = pc.getMiss();
		MProduct p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getMiss() > miss, "First get of product Oak, cache miss should increase");
		
		//second get for p2, hit should increase
		hit = pc.getHit();
		p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Second get of product Oak, cache hit should increase");
		
		p2 = new MProduct(Env.getCtx(), p2, getTrxName());
		p2.setDescription("Test Update @ " + System.currentTimeMillis());
		p2.saveEx();
		
		//get after p2 update, miss should increase
		miss = pc.getMiss();
		p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getMiss() > miss, "Get of product Oak after update of product Oak, cache miss should increase");
		
		//cache for p1 not effected by p2 update, hit should increase
		hit = pc.getHit();
		p1 = MProduct.get(Env.getCtx(), mulch);
		assertEquals(mulch, p1.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Get of product Mulch after update of product Oak, cache hit should increase");
		
		//create p3 to test delete
		MProduct p3 = new MProduct(Env.getCtx(), 0, getTrxName());
		String name = "Test@"+System.currentTimeMillis();
		p3.setValue(name);
		p3.setName(name);
		p3.setM_Product_Category_ID(p1.getM_Product_Category_ID());
		p3.setC_UOM_ID(p1.getC_UOM_ID());
		p3.setC_TaxCategory_ID(p1.getC_TaxCategory_ID());
		p3.saveEx();
		
		p3.deleteEx(true);
		
		//cache for p2 not effected by p3 delete, hit should increase
		hit = pc.getHit();
		p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Get of product Oak after delete of product Mulch, cache hit should increase");
		
		//test update when cache is empty
		CacheMgt.get().reset();
		p2 = new MProduct(Env.getCtx(), p2, getTrxName());
		p2.setDescription("Test1@"+System.currentTimeMillis());
		p2.saveEx();
		
		rollback();
	}
}