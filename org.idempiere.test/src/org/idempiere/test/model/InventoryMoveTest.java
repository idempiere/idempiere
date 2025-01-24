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

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;

import org.compiere.model.MMovement;
import org.compiere.model.MMovementLine;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MUOMConversion;
import org.compiere.model.MWarehouse;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
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
}
