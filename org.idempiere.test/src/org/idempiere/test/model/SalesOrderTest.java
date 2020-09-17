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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 */
public class SalesOrderTest extends AbstractTestCase {

	public SalesOrderTest() {
	}

	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-235
	 */
	public void testDatePromisedValidation() {
		//first test - invalid with completeorder and multiple datepromised
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), 118));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), 128));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		MOrderLine line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), 123));
		line2.setQty(new BigDecimal("1"));
		line2.setDatePromised(TimeUtil.addDays(today, 1));
		line2.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertTrue(info.isError());
		assertEquals(DocAction.STATUS_Invalid, order.getDocStatus());
		
		rollback();
		
		//second test - ok with completeorder and 1 datepromised
		order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), 118));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), 128));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), 123));
		line2.setQty(new BigDecimal("1"));
		line2.setDatePromised(today);
		line2.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		rollback();
		
		//test 3 - ok with !completeorder and multiple datepromised
		order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), 118));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_Availability);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), 128));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), 123));
		line2.setQty(new BigDecimal("1"));
		line2.setDatePromised(TimeUtil.addDays(today, 1));
		line2.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		rollback();
	}
	
	@Test
	public void testQtyReservedForOverAndNegativeShipment() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), 118));
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
		line1.setProduct(MProduct.get(Env.getCtx(), 128));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		MInOut shipment = new MInOut(order, 120, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//over shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("2"));
		shipmentLine.setQty(new BigDecimal("2"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		
		shipment = new MInOut(order, 120, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//-1 to correct over shipment
		shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("-1"));
		shipmentLine.setQty(new BigDecimal("-1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
	}
	
	@Test
	public void testQtyReservedForNegativeOrderAndShipment() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), 118));
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
		line1.setProduct(MProduct.get(Env.getCtx(), 128));
		line1.setQty(new BigDecimal("-1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		
		MInOut shipment = new MInOut(order, 120, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//over shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("-1"));
		shipmentLine.setQty(new BigDecimal("-1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());		
	}
	
	@Test
	public void testPOSOrder() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), 118));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_POS);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), 128));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
		assertEquals(1, line1.getQtyInvoiced().intValue());
		
		MInOut[] shipments = order.getShipments();
		assertEquals(1, shipments.length);
		assertEquals(DocAction.STATUS_Completed, shipments[0].getDocStatus());
		
		MInvoice[] invoices = order.getInvoices();
		assertEquals(1, invoices.length);
		assertEquals(DocAction.STATUS_Completed, invoices[0].getDocStatus());
	}
}
