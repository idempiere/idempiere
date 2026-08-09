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
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.CALLS_REAL_METHODS;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.spy;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MClient;
import org.compiere.model.MMovement;
import org.compiere.model.MMovementLine;
import org.compiere.model.MMovementLineMA;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MUOMConversion;
import org.compiere.model.MWarehouse;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

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
	 * Same ASI with multiple storage records at different DateMaterialPolicy
	 * must complete Inventory Move by consuming each storage (IDEMPIERE-4768 pattern).
	 */
	@Test
	public void testMultiASIDateMaterialPolicyMove() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct fert50 = new MProduct(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id, trxName);

		Timestamp today = TimeUtil.getDay(2024, 6, 15);
		Timestamp pastMonth = TimeUtil.addMonths(today, -1);

		try (MockedStatic<MWarehouse> warehouseMock = mockDisallowNegativeInvWarehouse(ctx, HQ_WAREHOUSE_ID, trxName)) {
			MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
			asi.setM_AttributeSet_ID(fert50.getM_AttributeSet_ID());
			asi.setLot("MOVE-1010");
			asi.saveEx();

			int locatorFrom = DictionaryIDs.M_Locator.HQ.id;
			int locatorTo = DictionaryIDs.M_Locator.STORE.id;

			MStorageOnHand.add(ctx, locatorFrom, DictionaryIDs.M_Product.FERTILIZER_50.id,
					asi.getM_AttributeSetInstance_ID(), Env.ONE, pastMonth, trxName);
			MStorageOnHand.add(ctx, locatorFrom, DictionaryIDs.M_Product.FERTILIZER_50.id,
					asi.getM_AttributeSetInstance_ID(), Env.ONE, today, trxName);

			MStorageOnHand[] storages = MStorageOnHand.getWarehouse(ctx, HQ_WAREHOUSE_ID,
					DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), true,
					locatorFrom, trxName);
			assertEquals(2, storages.length);

			MMovement mh = new MMovement(ctx, 0, trxName);
			mh.setM_Warehouse_ID(HQ_WAREHOUSE_ID);
			mh.setM_WarehouseTo_ID(STORE_WAREHOUSE_ID);
			mh.saveEx();

			MMovementLine ml = new MMovementLine(mh);
			ml.setM_Product_ID(DictionaryIDs.M_Product.FERTILIZER_50.id);
			ml.setM_Locator_ID(locatorFrom);
			ml.setM_LocatorTo_ID(locatorTo);
			ml.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
			ml.setM_AttributeSetInstanceTo_ID(asi.getM_AttributeSetInstance_ID());
			ml.setMovementQty(new BigDecimal("2"));
			ml.saveEx();

			boolean completed = mh.processIt(MMovement.ACTION_Complete);
			assertTrue(completed, mh.getProcessMsg());
			mh.saveEx();
			assertEquals(MMovement.DOCSTATUS_Completed, mh.getDocStatus());

			// Auto MAs should have been created to split by DateMaterialPolicy
			MMovementLineMA[] mas = MMovementLineMA.get(ctx, ml.getM_MovementLine_ID(), trxName);
			assertEquals(2, mas.length, "Expected MA split by DateMaterialPolicy");
			assertMaterialPolicyDates(mas, pastMonth, today);

			storages = MStorageOnHand.getWarehouse(ctx, HQ_WAREHOUSE_ID,
					DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), false,
					locatorFrom, trxName);
			assertEquals(0, storages.length);

			storages = MStorageOnHand.getWarehouse(ctx, STORE_WAREHOUSE_ID,
					DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), true,
					locatorTo, trxName);
			assertEquals(2, storages.length);
			assertMaterialPolicyStorage(storages, pastMonth, today);
		} finally {
			rollback();
		}
	}

	/**
	 * Reverse correction must restore both DateMaterialPolicy allocations for assigned ASI.
	 */
	@Test
	public void testMultiASIDateMaterialPolicyMoveReverse() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct fert50 = new MProduct(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id, trxName);

		Timestamp today = TimeUtil.getDay(2024, 6, 15);
		Timestamp pastMonth = TimeUtil.addMonths(today, -1);

		try (MockedStatic<MWarehouse> warehouseMock = mockDisallowNegativeInvWarehouse(ctx, HQ_WAREHOUSE_ID, trxName)) {
			MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
			asi.setM_AttributeSet_ID(fert50.getM_AttributeSet_ID());
			asi.setLot("MOVE-1011");
			asi.saveEx();

			int locatorFrom = DictionaryIDs.M_Locator.HQ.id;
			int locatorTo = DictionaryIDs.M_Locator.STORE.id;

			MStorageOnHand.add(ctx, locatorFrom, DictionaryIDs.M_Product.FERTILIZER_50.id,
					asi.getM_AttributeSetInstance_ID(), Env.ONE, pastMonth, trxName);
			MStorageOnHand.add(ctx, locatorFrom, DictionaryIDs.M_Product.FERTILIZER_50.id,
					asi.getM_AttributeSetInstance_ID(), Env.ONE, today, trxName);

			MMovement mh = new MMovement(ctx, 0, trxName);
			mh.setM_Warehouse_ID(HQ_WAREHOUSE_ID);
			mh.setM_WarehouseTo_ID(STORE_WAREHOUSE_ID);
			mh.saveEx();

			MMovementLine ml = new MMovementLine(mh);
			ml.setM_Product_ID(DictionaryIDs.M_Product.FERTILIZER_50.id);
			ml.setM_Locator_ID(locatorFrom);
			ml.setM_LocatorTo_ID(locatorTo);
			ml.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
			ml.setM_AttributeSetInstanceTo_ID(asi.getM_AttributeSetInstance_ID());
			ml.setMovementQty(new BigDecimal("2"));
			ml.saveEx();

			boolean completed = mh.processIt(MMovement.ACTION_Complete);
			assertTrue(completed, mh.getProcessMsg());
			mh.saveEx();
			assertEquals(MMovement.DOCSTATUS_Completed, mh.getDocStatus());

			MMovementLineMA[] mas = MMovementLineMA.get(ctx, ml.getM_MovementLine_ID(), trxName);
			assertEquals(2, mas.length, "Expected MA split by DateMaterialPolicy");
			assertMaterialPolicyDates(mas, pastMonth, today);

			boolean reversed = mh.processIt(DocAction.ACTION_Reverse_Correct);
			assertTrue(reversed, mh.getProcessMsg());
			mh.saveEx();
			assertEquals(MMovement.DOCSTATUS_Reversed, mh.getDocStatus());

			MMovement reversal = new MMovement(ctx, mh.getReversal_ID(), trxName);
			MMovementLine[] rLines = reversal.getLines(true);
			assertEquals(1, rLines.length);
			MMovementLineMA[] rMas = MMovementLineMA.get(ctx, rLines[0].getM_MovementLine_ID(), trxName);
			assertEquals(2, rMas.length, "Reversal must preserve MA split by DateMaterialPolicy");
			assertMaterialPolicyDates(rMas, pastMonth, today);
			for (MMovementLineMA ma : rMas) {
				assertEquals(-1, ma.getMovementQty().intValue());
			}

			MStorageOnHand[] storages = MStorageOnHand.getWarehouse(ctx, HQ_WAREHOUSE_ID,
					DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), true,
					locatorFrom, trxName);
			assertEquals(2, storages.length);
			assertMaterialPolicyStorage(storages, pastMonth, today);

			storages = MStorageOnHand.getWarehouse(ctx, STORE_WAREHOUSE_ID,
					DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), false,
					locatorTo, trxName);
			assertEquals(0, storages.length);
		} finally {
			rollback();
		}
	}

	/**
	 * Mock IsDisallowNegativeInv for a warehouse without persisting shared seed data.
	 */
	private static MockedStatic<MWarehouse> mockDisallowNegativeInvWarehouse(Properties ctx, int warehouseId, String trxName) {
		MWarehouse warehouseSpy = spy(new MWarehouse(ctx, warehouseId, trxName));
		doReturn(true).when(warehouseSpy).isDisallowNegativeInv();

		MockedStatic<MWarehouse> warehouseMock = Mockito.mockStatic(MWarehouse.class, CALLS_REAL_METHODS);
		warehouseMock.when(() -> MWarehouse.get(warehouseId)).thenReturn(warehouseSpy);
		warehouseMock.when(() -> MWarehouse.get(any(Properties.class), eq(warehouseId))).thenReturn(warehouseSpy);
		warehouseMock.when(() -> MWarehouse.get(any(Properties.class), eq(warehouseId), any())).thenReturn(warehouseSpy);
		return warehouseMock;
	}

	private static void assertMaterialPolicyDates(MMovementLineMA[] mas, Timestamp pastMonth, Timestamp today) {
		Set<Timestamp> dates = new HashSet<>();
		for (MMovementLineMA ma : mas) {
			assertEquals(1, Math.abs(ma.getMovementQty().intValue()));
			dates.add(ma.getDateMaterialPolicy());
		}
		assertTrue(dates.containsAll(Arrays.asList(pastMonth, today)),
				"Expected DateMaterialPolicy allocations for pastMonth and today");
	}

	private static void assertMaterialPolicyStorage(MStorageOnHand[] storages, Timestamp pastMonth, Timestamp today) {
		Set<Timestamp> dates = new HashSet<>();
		for (MStorageOnHand storage : storages) {
			assertEquals(1, storage.getQtyOnHand().intValue());
			dates.add(storage.getDateMaterialPolicy());
		}
		assertTrue(dates.containsAll(Arrays.asList(pastMonth, today)),
				"Expected storage DateMaterialPolicy for pastMonth and today");
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
			Timestamp theDayAfterTomorrow = TimeUtil.addDays(today, 2);
			
			MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
			asi.setM_AttributeSet_ID(product.getM_AttributeSet_ID());
			asi.setLot("8888");
			asi.setGuaranteeDate(tomorrow);
			asi.saveEx();					
			
			// Inventory Move (HQ > Store)
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
					product.get_ID(), ml.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
					0, trxName);
			assertEquals(1, storages.length);
			MStorageOnHand storage = storages[0];
			assertEquals(ml.getM_Locator_ID(), storage.getM_Locator_ID());
			assertEquals(ml.getM_AttributeSetInstance_ID(), storage.getM_AttributeSetInstance_ID());
			assertEquals(qtyMove.negate().intValue(), storage.getQtyOnHand().intValue());
			assertEquals(today, storage.getDateMaterialPolicy()); // not equals to guarantee date because inventory is not increasing
			
			storages = MStorageOnHand.getWarehouse(ctx, STORE_WAREHOUSE_ID,
					product.get_ID(), ml.getM_AttributeSetInstanceTo_ID(), null,
					MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
					0, trxName);
			assertEquals(1, storages.length);
			storage = storages[0];
			assertEquals(ml.getM_LocatorTo_ID(), storage.getM_Locator_ID());
			assertEquals(ml.getM_AttributeSetInstanceTo_ID(), storage.getM_AttributeSetInstance_ID());
			assertEquals(qtyMove.intValue(), storage.getQtyOnHand().intValue());
			assertEquals(tomorrow, storage.getDateMaterialPolicy());
			
			MAttributeSetInstance asi2 = new MAttributeSetInstance(ctx, 0, trxName);
			asi2.setM_AttributeSet_ID(product.getM_AttributeSet_ID());
			asi2.setLot("9999");
			asi2.setGuaranteeDate(theDayAfterTomorrow);
			asi2.saveEx();
			
			// Inventory Move (Store > Fertilizer)
			MMovement mh2 = new MMovement (Env.getCtx(), 0, getTrxName());
			mh2.setM_Warehouse_ID(STORE_WAREHOUSE_ID);
			mh2.setM_WarehouseTo_ID(DictionaryIDs.M_Warehouse.FERTILIZER.id);
			mh2.saveEx();
			
			MMovementLine ml2 = new MMovementLine(mh2);
			ml2.setM_Product_ID(product.get_ID());
			ml2.setM_Locator_ID(MWarehouse.get(STORE_WAREHOUSE_ID).getDefaultLocator().get_ID());
			ml2.setM_LocatorTo_ID(MWarehouse.get(DictionaryIDs.M_Warehouse.FERTILIZER.id).getDefaultLocator().get_ID());
			ml2.setM_AttributeSetInstance_ID(asi.get_ID());
			ml2.setM_AttributeSetInstanceTo_ID(asi2.get_ID());
			BigDecimal qtyMove2 = Env.ONEHUNDRED;
			ml2.setMovementQty(qtyMove2);	
			ml2.saveEx();

			assertTrue(ml2.getQtyEntered().compareTo(ml2.getMovementQty()) == 0);
			mh2.processIt(MMovement.ACTION_Complete);
			
			storages = MStorageOnHand.getWarehouse(ctx, STORE_WAREHOUSE_ID,
					product.get_ID(), ml2.getM_AttributeSetInstance_ID(), null,
					MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
					0, trxName);
			assertEquals(0, storages.length);
			
			storages = MStorageOnHand.getWarehouse(ctx, DictionaryIDs.M_Warehouse.FERTILIZER.id,
					product.get_ID(), ml2.getM_AttributeSetInstanceTo_ID(), null,
					MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
					0, trxName);
			assertEquals(1, storages.length);
			storage = storages[0];
			assertEquals(ml2.getM_LocatorTo_ID(), storage.getM_Locator_ID());
			assertEquals(ml2.getM_AttributeSetInstanceTo_ID(), storage.getM_AttributeSetInstance_ID());
			assertEquals(qtyMove2.intValue(), storage.getQtyOnHand().intValue());
			assertEquals(theDayAfterTomorrow, storage.getDateMaterialPolicy());
		} finally {
			rollback();
		}
	}
	
}
