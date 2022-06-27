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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Arrays;

import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MLocator;
import org.compiere.model.MLocatorType;
import org.compiere.model.MMovement;
import org.compiere.model.MMovementLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MStorageReservation;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MStorageTest extends AbstractTestCase {

	public MStorageTest() {
	}

	@Test
	public void testStorageOnHandAndReservation() {
		MProduct azalea = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id);
		
		BigDecimal onhandForReservation = MStorageOnHand.getQtyOnHandForReservation(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, getTrxName());
		BigDecimal onhandForShipping  = MStorageOnHand.getQtyOnHandForShipping(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, getTrxName());
		BigDecimal qtyReserved = MStorageReservation.getQty(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, true, getTrxName());
		BigDecimal availableForReservation = MStorageReservation.getQtyAvailable(getM_Warehouse_ID(), azalea.getM_Product_ID(), 0, getTrxName());
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(azalea);
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		BigDecimal qtyReserved1 = MStorageReservation.getQty(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, true, getTrxName());
		assertTrue(qtyReserved1.compareTo(qtyReserved) > 0, "Qty reserved doesn't increase as expected (Before=" + qtyReserved.toPlainString() + " After=" + qtyReserved1.toPlainString());
		BigDecimal availableForReservation1 = MStorageReservation.getQtyAvailable(getM_Warehouse_ID(), azalea.getM_Product_ID(), 0, getTrxName());
		assertTrue(availableForReservation1.compareTo(availableForReservation) < 0, "Qty available for reservation doesn't reduce as expected (Before=" + availableForReservation.toPlainString() + " After=" + availableForReservation1.toPlainString());
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//over shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		
		BigDecimal onhandForReservation1 = MStorageOnHand.getQtyOnHandForReservation(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, getTrxName());
		assertTrue(onhandForReservation1.compareTo(onhandForReservation) < 0, "Qty on hand for reservation doesn't reduce as expected (Before=" + onhandForReservation.toPlainString() + " After=" + onhandForReservation1.toPlainString());
		
		BigDecimal onhandForShipping1  = MStorageOnHand.getQtyOnHandForShipping(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, getTrxName());
		assertTrue(onhandForShipping1.compareTo(onhandForShipping) < 0, "Qty on hand for shipping doesn't reduce as expected (Before=" + onhandForShipping.toPlainString() + " After=" + onhandForShipping1.toPlainString());
		
		MLocatorType reservedLocatorType = new MLocatorType(Env.getCtx(), 0, getTrxName());
		reservedLocatorType.setName("Reserved Locator1");
		reservedLocatorType.setIsAvailableForReservation(true);
		reservedLocatorType.setIsAvailableForReplenishment(false);
		reservedLocatorType.setIsAvailableForShipping(false);
		reservedLocatorType.saveEx();
		
		MLocatorType shippingLocatorType = new MLocatorType(Env.getCtx(), 0, getTrxName());
		shippingLocatorType.setName("Shipping Locator1");
		shippingLocatorType.setIsAvailableForReservation(false);
		shippingLocatorType.setIsAvailableForReplenishment(false);
		shippingLocatorType.setIsAvailableForShipping(true);
		shippingLocatorType.saveEx();
		
		MLocator shippingLocator = new MLocator(Env.getCtx(), 0, getTrxName());
		shippingLocator.setM_LocatorType_ID(shippingLocatorType.getM_LocatorType_ID());
		shippingLocator.setM_Warehouse_ID(getM_Warehouse_ID());
		shippingLocator.setXYZ("x1", "y1", "z1");
		shippingLocator.saveEx();
				
		MMovement movement = new MMovement(Env.getCtx(), 0, getTrxName());
		//143 | Material Movement
		movement.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_MOVEMENT.id);
		movement.setDocAction(DocAction.ACTION_Complete);
		movement.saveEx();
		
		MStorageOnHand[] storages = MStorageOnHand.getWarehouse(Env.getCtx(), getM_Warehouse_ID(), azalea.getM_Product_ID(), 0, null, true, true, 0, getTrxName(), false);
		final int[] line = new int[] {0};
		Arrays.stream(storages).forEach(e -> {
			MMovementLine ml = new MMovementLine(movement);
			ml.setM_Product_ID(azalea.getM_Product_ID());
			line[0] += 10;
			ml.setLine(line[0]);
			ml.setM_Locator_ID(e.getM_Locator_ID());
			ml.setM_LocatorTo_ID(shippingLocator.getM_Locator_ID());
			ml.setMovementQty(new BigDecimal("1"));
			ml.saveEx();
			
			MLocator locator = new MLocator(Env.getCtx(), e.getM_Locator_ID(), getTrxName());
			locator.setM_LocatorType_ID(reservedLocatorType.getM_LocatorType_ID());
			locator.saveEx();
		});
		info = MWorkflow.runDocumentActionWorkflow(movement, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		movement.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, movement.getDocStatus());
		
		BigDecimal onhandForReservation2 = MStorageOnHand.getQtyOnHandForReservation(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, getTrxName());
		assertTrue(onhandForReservation2.compareTo(onhandForReservation1) < 0, "Qty on hand for reservation doesn't reduce as expected (Before=" + onhandForReservation1.toPlainString() + " After=" + onhandForReservation2.toPlainString());
		
		BigDecimal onhandForShipping2  = MStorageOnHand.getQtyOnHandForShipping(azalea.getM_Product_ID(), getM_Warehouse_ID(), 0, getTrxName());
		assertTrue(onhandForShipping2.compareTo(onhandForShipping1) < 0, "Qty on hand for shipping doesn't reduce as expected (Before=" + onhandForShipping1.toPlainString() + " After=" + onhandForShipping2.toPlainString());
	}
}
