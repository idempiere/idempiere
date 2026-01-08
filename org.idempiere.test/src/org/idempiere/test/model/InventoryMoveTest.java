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
 * - Diego Ruiz                        								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MClient;
import org.compiere.model.MMovement;
import org.compiere.model.MMovementLine;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MUOMConversion;
import org.compiere.model.MWarehouse;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

@Isolated
public class InventoryMoveTest extends AbstractTestCase {

	private static final int OAK_PRODUCT_ID = 123;
	private static final int ELM_PRODUCT_ID = 124;
	private static final int HQ_WAREHOUSE_ID = 103;
	private static final int STORE_WAREHOUSE_ID = 104;
	private static final int UOM_SIXPACK_ID = 109;
	
	public InventoryMoveTest() {
	}

	@Test
	public void testInventoryMove() {

		BigDecimal qtyOnHandHQ = MStorageOnHand.getQtyOnHandWithASIZero(OAK_PRODUCT_ID, HQ_WAREHOUSE_ID, getTrxName());
		BigDecimal qtyOnHandStore = MStorageOnHand.getQtyOnHandWithASIZero(OAK_PRODUCT_ID, STORE_WAREHOUSE_ID, getTrxName());

		//Inventory Move
		MMovement mh = new MMovement (Env.getCtx(), 0, getTrxName());
		mh.setM_Warehouse_ID(HQ_WAREHOUSE_ID);
		mh.setM_WarehouseTo_ID(STORE_WAREHOUSE_ID);
		mh.saveEx();

		//Movement Line
		MMovementLine ml = new MMovementLine(mh);
		ml.setM_Product_ID(OAK_PRODUCT_ID);
		ml.setM_LocatorTo_ID(MWarehouse.get(STORE_WAREHOUSE_ID).getDefaultLocator().get_ID());
		//	From
		ml.setM_Locator_ID(MWarehouse.get(HQ_WAREHOUSE_ID).getDefaultLocator().get_ID());

		BigDecimal qtyMove = BigDecimal.ONE;
		ml.setMovementQty(qtyMove);	
		ml.saveEx();

		assertTrue(ml.getQtyEntered().compareTo(ml.getMovementQty()) == 0);

		mh.processIt(MMovement.ACTION_Complete);
		
		BigDecimal newQtyOnHandHQ = MStorageOnHand.getQtyOnHandWithASIZero(OAK_PRODUCT_ID, HQ_WAREHOUSE_ID, getTrxName());
		BigDecimal newQtyOnHandStore = MStorageOnHand.getQtyOnHandWithASIZero(OAK_PRODUCT_ID, STORE_WAREHOUSE_ID, getTrxName());
		assertTrue(newQtyOnHandHQ.compareTo(qtyOnHandHQ.subtract(qtyMove)) == 0);
		assertTrue(newQtyOnHandStore.compareTo(qtyOnHandStore.add(qtyMove)) == 0);
		
		rollback();
		
		//Inventory Move - Setting QtyOrdered with default UOM
		mh = new MMovement (Env.getCtx(), 0, getTrxName());
		mh.setM_Warehouse_ID(HQ_WAREHOUSE_ID);
		mh.setM_WarehouseTo_ID(STORE_WAREHOUSE_ID);
		mh.saveEx();

		//Movement Line
		ml = new MMovementLine(mh);
		ml.setM_Product_ID(OAK_PRODUCT_ID);
		ml.setM_LocatorTo_ID(MWarehouse.get(STORE_WAREHOUSE_ID).getDefaultLocator().get_ID());
		//	From
		ml.setM_Locator_ID(MWarehouse.get(HQ_WAREHOUSE_ID).getDefaultLocator().get_ID());

		qtyMove = BigDecimal.ONE;
		ml.setQtyEntered(qtyMove);	
		ml.saveEx();

		assertTrue(ml.getQtyEntered().compareTo(ml.getMovementQty()) == 0);

		mh.processIt(MMovement.ACTION_Complete);
		
		newQtyOnHandHQ = MStorageOnHand.getQtyOnHandWithASIZero(OAK_PRODUCT_ID, HQ_WAREHOUSE_ID, getTrxName());
		newQtyOnHandStore = MStorageOnHand.getQtyOnHandWithASIZero(OAK_PRODUCT_ID, STORE_WAREHOUSE_ID, getTrxName());
		assertTrue(newQtyOnHandHQ.compareTo(qtyOnHandHQ.subtract(qtyMove)) == 0);
		assertTrue(newQtyOnHandStore.compareTo(qtyOnHandStore.add(qtyMove)) == 0);
		
		rollback();
		
		//Inventory Move - Setting QtyOrdered with different UOM
		qtyOnHandHQ = MStorageOnHand.getQtyOnHandWithASIZero(ELM_PRODUCT_ID, HQ_WAREHOUSE_ID, getTrxName());
		qtyOnHandStore = MStorageOnHand.getQtyOnHandWithASIZero(ELM_PRODUCT_ID, STORE_WAREHOUSE_ID, getTrxName());
		
		mh = new MMovement (Env.getCtx(), 0, getTrxName());
		mh.setM_Warehouse_ID(HQ_WAREHOUSE_ID);
		mh.setM_WarehouseTo_ID(STORE_WAREHOUSE_ID);
		mh.saveEx();

		//Movement Line
		ml = new MMovementLine(mh);
		ml.setM_Product_ID(ELM_PRODUCT_ID);
		ml.setM_LocatorTo_ID(MWarehouse.get(STORE_WAREHOUSE_ID).getDefaultLocator().get_ID());
		//	From
		ml.setM_Locator_ID(MWarehouse.get(HQ_WAREHOUSE_ID).getDefaultLocator().get_ID());

		qtyMove = BigDecimal.ONE;
		ml.setQtyEntered(qtyMove);
		ml.setC_UOM_ID(UOM_SIXPACK_ID); //Six Pack
		ml.saveEx();
		
		BigDecimal movementQty = MUOMConversion.convertProductFrom(Env.getCtx(), ELM_PRODUCT_ID, UOM_SIXPACK_ID, qtyMove);
		assertFalse(ml.getQtyEntered().compareTo(ml.getMovementQty()) == 0);
		assertTrue(ml.getMovementQty().compareTo(movementQty) == 0);

		mh.processIt(MMovement.ACTION_Complete);
		
		newQtyOnHandHQ = MStorageOnHand.getQtyOnHandWithASIZero(ELM_PRODUCT_ID, HQ_WAREHOUSE_ID, getTrxName());
		newQtyOnHandStore = MStorageOnHand.getQtyOnHandWithASIZero(ELM_PRODUCT_ID, STORE_WAREHOUSE_ID, getTrxName());
		assertFalse(newQtyOnHandHQ.compareTo(qtyOnHandHQ.subtract(qtyMove)) == 0);
		assertFalse(newQtyOnHandStore.compareTo(qtyOnHandStore.add(qtyMove)) == 0);
		
		assertTrue(newQtyOnHandHQ.compareTo(qtyOnHandHQ.subtract(movementQty)) == 0);
		assertTrue(newQtyOnHandStore.compareTo(qtyOnHandStore.add(movementQty)) == 0);
		
		rollback();
		
		//Inventory Move - Setting not default UOM with no QtyEntered but positive MovementQty
		mh = new MMovement (Env.getCtx(), 0, getTrxName());
		mh.setM_Warehouse_ID(HQ_WAREHOUSE_ID);
		mh.setM_WarehouseTo_ID(STORE_WAREHOUSE_ID);
		mh.saveEx();

		//Movement Line
		ml = new MMovementLine(mh);
		ml.setM_Product_ID(ELM_PRODUCT_ID);
		ml.setM_LocatorTo_ID(MWarehouse.get(STORE_WAREHOUSE_ID).getDefaultLocator().get_ID());
		//	From
		ml.setM_Locator_ID(MWarehouse.get(HQ_WAREHOUSE_ID).getDefaultLocator().get_ID());

		ml.setMovementQty(qtyMove);
		ml.setC_UOM_ID(UOM_SIXPACK_ID); //Six Pack
		boolean success = ml.save();

		assertFalse(success);

		rollback();
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
		boolean originalUseGuaranteeDateForMPolicy = attributeSet.isUseGuaranteeDateForMPolicy();
		
		String sql = "UPDATE " + MAttributeSet.Table_Name 
				+ " SET " + MAttributeSet.COLUMNNAME_UseGuaranteeDateForMPolicy + "=?"
				+ " WHERE " + MAttributeSet.COLUMNNAME_M_AttributeSet_ID + "=?";
		try {
			// set MAttributeSet.isUseGuaranteeDateForMPolicy = Y
			DB.executeUpdateEx(sql, new Object[] {"Y", attributeSet.get_ID()}, null);
			attributeSet.load(null);
			
			Timestamp today = TimeUtil.getDay(null);
			Timestamp tomorrow = TimeUtil.addDays(today, 1);
			
			MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
			asi.setM_AttributeSet_ID(product.getM_AttributeSet_ID());
			asi.setLot("8888");
			asi.setGuaranteeDate(tomorrow);
			asi.saveEx();					
			
			// Inventory Move
			MMovement mh = new MMovement (Env.getCtx(), 0, getTrxName());
			mh.setM_Warehouse_ID(HQ_WAREHOUSE_ID);
			mh.setM_WarehouseTo_ID(STORE_WAREHOUSE_ID);
			mh.saveEx();
			
			MMovementLine ml = new MMovementLine(mh);
			ml.setM_Product_ID(product.get_ID());
			ml.setM_Locator_ID(MWarehouse.get(HQ_WAREHOUSE_ID).getDefaultLocator().get_ID());
			ml.setM_LocatorTo_ID(MWarehouse.get(STORE_WAREHOUSE_ID).getDefaultLocator().get_ID());
			ml.setM_AttributeSetInstance_ID(asi.get_ID());
			ml.setM_AttributeSetInstanceTo_ID(asi.get_ID());
			BigDecimal qtyMove = Env.ONEHUNDRED;
			ml.setMovementQty(qtyMove);	
			ml.saveEx();

			assertTrue(ml.getQtyEntered().compareTo(ml.getMovementQty()) == 0);
			mh.processIt(MMovement.ACTION_Complete);
			
			MStorageOnHand[] storages = MStorageOnHand.getWarehouse(ctx, HQ_WAREHOUSE_ID,
					product.get_ID(), asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
					0, trxName);
			assertEquals(1, storages.length);
			MStorageOnHand storage = storages[0];
			assertEquals(qtyMove.negate().intValue(), storage.getQtyOnHand().intValue());
			assertEquals(today, storage.getDateMaterialPolicy()); // not equals to guarantee date because inventory is not increasing
			
			storages = MStorageOnHand.getWarehouse(ctx, STORE_WAREHOUSE_ID,
					product.get_ID(), asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
					0, trxName);
			assertEquals(1, storages.length);
			storage = storages[0];
			assertEquals(qtyMove.intValue(), storage.getQtyOnHand().intValue());
			assertEquals(tomorrow, storage.getDateMaterialPolicy());
		} finally {
			rollback();
			
			// reset MAttributeSet.isUseGuaranteeDateForMPolicy
			DB.executeUpdateEx(sql, new Object[] {originalUseGuaranteeDateForMPolicy ? "Y" : "N", attributeSet.get_ID()}, null);
			attributeSet.load(null);
		}
	}
}
