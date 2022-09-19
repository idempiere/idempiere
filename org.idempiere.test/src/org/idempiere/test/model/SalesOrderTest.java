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

import static org.compiere.model.SystemIDs.PROCESS_M_INOUT_GENERATE_MANUAL;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MPayment;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MStorageReservation;
import org.compiere.model.MStorageReservationLog;
import org.compiere.model.MTransaction;
import org.compiere.model.MUOM;
import org.compiere.model.MWarehouse;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * @author hengsin
 */
@Isolated
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
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		MOrderLine line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.OAK.id));
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
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.OAK.id));
		line2.setQty(new BigDecimal("1"));
		line2.setDatePromised(today);
		line2.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		rollback();
		
		//test 3 - ok with !completeorder and multiple datepromised
		order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_Availability);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.OAK.id));
		line2.setQty(new BigDecimal("1"));
		line2.setDatePromised(TimeUtil.addDays(today, 1));
		line2.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		rollback();
	}
	
	@Test
	public void testQtyReservedForOverAndNegativeShipment() {
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//over shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("2"));
		shipmentLine.setQty(new BigDecimal("2"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		
		shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//-1 to correct over shipment
		shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("-1"));
		shipmentLine.setQty(new BigDecimal("-1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
	}
	
	@Test
	public void testQtyReservedForNegativeOrderAndShipment() {
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("-1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//over shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("-1"));
		shipmentLine.setQty(new BigDecimal("-1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());		
	}

	@Test
	public void testOnCreditPOSOrder() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// Get the OpenBalance of Joe Block
		MBPartner bpartner = new MBPartner(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id, trxName);
		BigDecimal initialBalance = bpartner.getTotalOpenBalance();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_POS);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_OnCredit); // this is the default, just making it explicit
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
		assertEquals(1, line1.getQtyInvoiced().intValue());

		MInOut[] shipments = order.getShipments();
		assertEquals(1, shipments.length);
		assertEquals(DocAction.STATUS_Completed, shipments[0].getDocStatus());

		MInvoice[] invoices = order.getInvoices();
		assertEquals(1, invoices.length);
		assertEquals(DocAction.STATUS_Completed, invoices[0].getDocStatus());

		bpartner.load(trxName);
		BigDecimal actualBalance = bpartner.getTotalOpenBalance();
		// on credit increases the debt
		assertTrue(actualBalance.compareTo(initialBalance.add(order.getGrandTotal())) == 0);
	}

	@Test
	public void testCashPOSOrder() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// Get the OpenBalance of Joe Block
		MBPartner bpartner = new MBPartner(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id, trxName);
		BigDecimal initialBalance = bpartner.getTotalOpenBalance();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_POS);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_Cash);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
		assertEquals(1, line1.getQtyInvoiced().intValue());

		MInOut[] shipments = order.getShipments();
		assertEquals(1, shipments.length);
		assertEquals(DocAction.STATUS_Completed, shipments[0].getDocStatus());

		MInvoice[] invoices = order.getInvoices();
		assertEquals(1, invoices.length);
		assertEquals(DocAction.STATUS_Completed, invoices[0].getDocStatus());
		assertEquals(true, invoices[0].isPaid(), "Invoice is not paid");

		MAllocationHdr[] allocs = MAllocationHdr.getOfInvoice(ctx, invoices[0].getC_Invoice_ID(), trxName);
		assertEquals(1, allocs.length);
		assertEquals(DocAction.STATUS_Completed, allocs[0].getDocStatus());

		int paymentId = allocs[0].getLines(false)[0].getC_Payment_ID();
		MPayment payment = new MPayment(ctx, paymentId, trxName);
		assertEquals(DocAction.STATUS_Completed, payment.getDocStatus());
		assertEquals(true, payment.isAllocated(), "Payment is not allocated");

		bpartner.load(trxName);
		BigDecimal actualBalance = bpartner.getTotalOpenBalance();
		// cash creates payment immediately, so debt is not increased
		assertTrue(actualBalance.compareTo(initialBalance) == 0);
	}

	@Test
	public void testGenerateShipmentDeliveryRule() {
		//test1 with CompleteOrder
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		int AD_Process_ID = PROCESS_M_INOUT_GENERATE_MANUAL;
		MPInstance instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		
		String insert = "INSERT INTO T_SELECTION(AD_PINSTANCE_ID, T_SELECTION_ID) Values (?, ?)";
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order.getC_Order_ID()}, null);
		
		//call process
		ProcessInfo pi = new ProcessInfo ("InOutGen", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Add Parameter - Selection=Y
		MPInstancePara ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();
		//	Add Parameter - M_Warehouse_ID=x
		ip = new MPInstancePara(instance, 30);
		ip.setParameter("M_Warehouse_ID", getM_Warehouse_ID());
		ip.saveEx();
		
		ServerProcessCtl processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();
		
		assertFalse(pi.isError(), pi.getSummary());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
		order.getLines();
		rollback();
		
		//test2 with AfterReceipt
		MOrder order1 = MOrder.copyFrom(order, today, order.getC_DocType_ID(), true, false, false, getTrxName());
		order1.setDeliveryRule(MOrder.DELIVERYRULE_AfterPayment);
		order1.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order1.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order1.getDocStatus());
		line1 = order1.getLines()[0];
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order1.getC_Order_ID()}, null);
		
		//call process without payment
		pi = new ProcessInfo ("InOutGen", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Add Parameter - Selection=Y
		ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();
		//	Add Parameter - M_Warehouse_ID=x
		ip = new MPInstancePara(instance, 30);
		ip.setParameter("M_Warehouse_ID", getM_Warehouse_ID());
		ip.saveEx();
		
		processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();
		
		assertFalse(pi.isError(), pi.getSummary());
		
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		assertEquals(0, line1.getQtyDelivered().intValue());
		
		//create payment
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_DocType_ID(true);
		int C_BankAccount_ID = DB.getSQLValueEx(getTrxName(), "select c_bankaccount_id from c_bankaccount where ad_client_id=? and isdefault='Y'", getAD_Client_ID());
		payment.setC_BankAccount_ID(C_BankAccount_ID);
		payment.setC_BPartner_ID(order1.getC_BPartner_ID());		
		payment.setC_Order_ID(order1.getC_Order_ID());
		payment.setTenderType(MPayment.TENDERTYPE_DirectDeposit);
		payment.setPayAmt(order1.getGrandTotal());
		payment.setC_Currency_ID(order1.getC_Currency_ID());
		payment.saveEx();
		info = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		payment.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, payment.getDocStatus());
		
		//call process with payment
		instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order1.getC_Order_ID()}, null);
		pi = new ProcessInfo ("InOutGen", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());
	
		//	Add Parameter - Selection=Y
		ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();
		//	Add Parameter - M_Warehouse_ID=x
		ip = new MPInstancePara(instance, 30);
		ip.setParameter("M_Warehouse_ID", getM_Warehouse_ID());
		ip.saveEx();
		
		processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();
		
		assertFalse(pi.isError(), pi.getSummary());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
		
		//test3 with AfterReceipt
		MOrder order2 = MOrder.copyFrom(order, today, order.getC_DocType_ID(), true, false, false, getTrxName());
		order2.setDeliveryRule(MOrder.DELIVERYRULE_AfterPayment);
		order2.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order2, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order2.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order2.getDocStatus());
		line1 = order2.getLines()[0];
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		//create invoice
		instance = new MPInstance(Env.getCtx(), SystemIDs.PROCESS_C_INVOICE_GENERATE_MANUAL, 0);
		instance.saveEx();
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order2.getC_Order_ID()}, null);		
		pi = new ProcessInfo ("InvoiceGenerateManual", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Add Parameter - Selection=Y
		ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();
		
		processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();
		
		assertFalse(pi.isError(), pi.getSummary());
		
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyInvoiced().intValue());
		
		//create payment
		payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setC_DocType_ID(true);
		payment.setC_BankAccount_ID(C_BankAccount_ID);
		payment.setC_BPartner_ID(order2.getC_BPartner_ID());		
		payment.setC_Invoice_ID(DB.getSQLValueEx(getTrxName(), "SELECT C_Invoice_ID FROM C_Invoice WHERE C_Order_ID=?", order2.getC_Order_ID()));
		payment.setTenderType(MPayment.TENDERTYPE_DirectDeposit);
		payment.setPayAmt(order2.getGrandTotal());
		payment.setC_Currency_ID(order2.getC_Currency_ID());
		payment.saveEx();
		info = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		payment.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, payment.getDocStatus());
		
		//call process with payment
		instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order2.getC_Order_ID()}, null);
		pi = new ProcessInfo ("InOutGen", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());
	
		//	Add Parameter - Selection=Y
		ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();
		//	Add Parameter - M_Warehouse_ID=x
		ip = new MPInstancePara(instance, 30);
		ip.setParameter("M_Warehouse_ID", getM_Warehouse_ID());
		ip.saveEx();
		
		processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();
		
		assertFalse(pi.isError(), pi.getSummary());
		
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
	}

	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4768
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4854
	 */
	public void testMultiASIShipment() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		
		MProduct fert50 = new MProduct(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id, trxName);

		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		Timestamp past_month = TimeUtil.addMonths(today, -1);

		MWarehouse wh = new MWarehouse(ctx, DictionaryIDs.M_Warehouse.FERTILIZER.id, trxName);
		wh.setIsDisallowNegativeInv(true);
		wh.saveEx();
		CacheMgt.get().reset(MWarehouse.Table_Name, DictionaryIDs.M_Warehouse.FERTILIZER.id);
		// Put the modified record into cache
		MWarehouse.get(ctx, DictionaryIDs.M_Warehouse.FERTILIZER.id, trxName);

		// create an ASI for Fertilizer Lot with Lot 1010  
		MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
		asi.setM_AttributeSet_ID(fert50.getM_AttributeSet_ID());
		asi.setLot("1010");
		asi.saveEx();

		MStorageOnHand.add(ctx, DictionaryIDs.M_Locator.FERTILIZER.id, DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), Env.ONE, past_month, trxName);
		MStorageOnHand.add(ctx, DictionaryIDs.M_Locator.FERTILIZER.id, DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), Env.ONE, today, trxName);

		// Expected to create two entries in storage because of the different dates
		MStorageOnHand[] storages = MStorageOnHand.getWarehouse(ctx, DictionaryIDs.M_Warehouse.FERTILIZER.id,
				DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), null,
				MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), false,
				0, trxName);
		assertEquals(2, storages.length);
		for (int i = 0; i < storages.length; i++) {
			MStorageOnHand storage = storages[i];
			assertEquals(1, storage.getQtyOnHand().intValue());
			if (i == 0)
				assertEquals(past_month, storage.getDateMaterialPolicy());
			else
				assertEquals(today, storage.getDateMaterialPolicy());
		}

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.FERTILIZER.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_OnCredit); // this is the default, just making it explicit
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id));
		line1.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line1.setQty(new BigDecimal("2"));
		line1.setDatePromised(today);
		line1.saveEx();

		// Expected to complete without problems
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		//generate shipment
		int AD_Process_ID = PROCESS_M_INOUT_GENERATE_MANUAL;
		MPInstance instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		
		String insert = "INSERT INTO T_SELECTION(AD_PINSTANCE_ID, T_SELECTION_ID) Values (?, ?)";
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order.getC_Order_ID()}, null);
		
		//call process
		ProcessInfo pi = new ProcessInfo ("InOutGen", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Add Parameter - Selection=Y
		MPInstancePara ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//Add Document action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();
		//	Add Parameter - M_Warehouse_ID=x
		ip = new MPInstancePara(instance, 30);
		ip.setParameter("M_Warehouse_ID", DictionaryIDs.M_Warehouse.FERTILIZER.id);
		ip.saveEx();
		
		ServerProcessCtl processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();
		
		assertFalse(pi.isError(), pi.getSummary());
		
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(2, line1.getQtyDelivered().intValue());

		// Expected to have cleared both storage entries on shipment
		storages = MStorageOnHand.getWarehouse(ctx, DictionaryIDs.M_Warehouse.FERTILIZER.id,
				DictionaryIDs.M_Product.FERTILIZER_50.id, asi.getM_AttributeSetInstance_ID(), null,
				MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), false,
				0, trxName);
		assertEquals(0, storages.length);
		
		Query query = new Query(Env.getCtx(), MInOut.Table_Name, "C_Order_ID=?", getTrxName());
		MInOut inout = query.setParameters(order.get_ID()).first();
		assertNotNull(inout, "Can't find shipment for order");
		MInOutLine[] ilines = inout.getLines();
		assertTrue(ilines.length==1, "Shipment doesn't has 1 line as expected: " + ilines.length);
		assertEquals(line1.get_ID(), ilines[0].getC_OrderLine_ID(), "Shipment line doesn't has the expected order line ID");
		assertEquals(line1.getQtyOrdered(), ilines[0].getMovementQty(), "Shipment line doesn't has the expected movement quantity");
		assertEquals(line1.getM_Product_ID(), ilines[0].getM_Product_ID(), "Shipment line doesn't has the expected product ID");
		assertEquals(line1.getM_AttributeSetInstance_ID(), ilines[0].getM_AttributeSetInstance_ID(), "Shipment line doesn't has the expected ASI ID");
		assertEquals(DictionaryIDs.M_Locator.FERTILIZER.id, ilines[0].getM_Locator_ID(), "Shipment line doesn't has the expected Locator ID");
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4912
	 */
	public void testUOMDefault() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Assembly Area with default UOM = Hour
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.MARY.id));
		line1.setQty(new BigDecimal("1"));
		line1.saveEx();
		
		assertEquals(DictionaryIDs.C_UOM.HOUR.id, line1.getC_UOM_ID());
		
		MOrderLine line2 = new MOrderLine(order);
		line2.setLine(20);
		line2.setDescription("This is a description order line with no product nor charge");
		line2.saveEx();
		
		assertEquals(MUOM.getDefault_UOM_ID(Env.getCtx()), line2.getC_UOM_ID());
	}

	@Test
	public void testQtyReservedLog() {
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		Query query = new Query(Env.getCtx(), MStorageReservationLog.Table_Name, "M_Product_ID=? AND IsSOTrx='Y' AND M_Warehouse_ID=?", getTrxName());
		MStorageReservationLog log = query.setOrderBy(MStorageReservationLog.COLUMNNAME_M_StorageReservationLog_ID+" Desc")
				.setParameters(DictionaryIDs.M_Product.AZALEA_BUSH.id, line1.getM_Warehouse_ID()).first();
		assertNotNull(log, "MStorageReservationLog not created after completion of sales order");
		assertTrue(log.getDeltaQty().intValue() == 1, "Delta quantity of MStorageReservationLog != 1 ("+log.getDeltaQty().toPlainString()+")");
		MStorageReservation reservation = MStorageReservation.get(Env.getCtx(), line1.getM_Warehouse_ID(), DictionaryIDs.M_Product.AZALEA_BUSH.id, 0, true, getTrxName());
		assertTrue(log.getNewQty().equals(reservation.getQty()), "New Qty from MStorageReservationLog != Qty from MStorageReservation");
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		log = query.first();
		assertNotNull(log, "MStorageReservationLog not created after completion of shipment");
		assertTrue(log.getDeltaQty().intValue() == -1, "Delta quantity of MStorageReservationLog != -1 ("+log.getDeltaQty().toPlainString()+")");
		reservation = MStorageReservation.get(Env.getCtx(), line1.getM_Warehouse_ID(), DictionaryIDs.M_Product.AZALEA_BUSH.id, 0, true, getTrxName());
		assertTrue(log.getNewQty().equals(reservation.getQty()), "New Qty from MStorageReservationLog != Qty from MStorageReservation");
	}
	
	@Test
	public void testQtyLostSales() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());		
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//over shipment
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("2"));
		shipmentLine.setQty(new BigDecimal("2"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());

		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Close);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Closed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(0, line1.getQtyLostSales().intValue());
		
		order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("2"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(2, line1.getQtyReserved().intValue());		
		
		shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		//under shipment
		shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());

		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Close);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Closed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyLostSales().intValue());
		assertEquals(line1.getQtyDelivered().intValue(), line1.getQtyOrdered().intValue());
	}
	
	@Test
	public void testWarehouseChange() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Prepare);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();

		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQT.id);
		boolean success = order.save();
		assertEquals(true, success);
		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Prepare);
		assertFalse(info.isError(), info.getSummary());
		
		// No change on warehouse allowed if QtyDelivered, QtyInvoice or QtyReserved != 0 on any line
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		success = order.save();
		assertEquals(false, success);
	}
	
	@Test
	public void testSetASIWhenShipping() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Unexpected Order document status");
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue(), "Unexpected order line qty reserved value");		
		
		int originalOnHand = MStorageOnHand.getQtyOnHandWithASIZero(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), getTrxName()).intValue();
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi.setM_AttributeSet_ID(MProduct.get(DictionaryIDs.M_Product.P_CHAIR.id).getM_AttributeSet_ID());
		asi.setSerNo("PChair Serial #1000000");
		asi.saveEx();
		shipmentLine.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected Shipment document status");
		
		int newOnHand = MStorageOnHand.getQtyOnHandWithASIZero(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), getTrxName()).intValue();
		assertEquals(originalOnHand-1, newOnHand, "Unexpected on hand quantity");
				
		int asiOnHand = MStorageOnHand.getQtyOnHand(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), asi.get_ID(), getTrxName()).intValue();
		int asiRecords = 0;
		MStorageOnHand[] storages = MStorageOnHand.getOfProduct(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id, getTrxName());
		for (MStorageOnHand storage : storages) {
			if (storage.getM_Warehouse_ID()==getM_Warehouse_ID() && storage.getM_AttributeSetInstance_ID()==asi.get_ID()) {
				asiRecords++;
			}
		}
		assertEquals(0, asiOnHand, "Unexpected on hand quantity for Serial ASI");
		assertEquals(1, asiRecords, "Unexpected number of Serial ASI Storage records");
		
		Query query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=0", getTrxName());
		MTransaction trxFrom = query.setParameters(shipmentLine.get_ID(), shipmentLine.getM_Product_ID()).first();
		assertNotNull(trxFrom, "Can't find MTransaction record for no ASI MTransaction record");
		assertEquals(-1, trxFrom.getMovementQty().intValue(), "Unexpected movement qty for no ASI MTransaction record");
		
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
		List<MTransaction> asiTrxs = query.setParameters(shipmentLine.get_ID(), shipmentLine.getM_Product_ID(), shipmentLine.getM_AttributeSetInstance_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(2, asiTrxs.size(), "Unexpected number of records for ASI MTransaction");
		assertEquals(1, asiTrxs.get(0).getMovementQty().intValue(), "Unexpected movement qty for first ASI MTransaction record");
		assertEquals(-1, asiTrxs.get(1).getMovementQty().intValue(), "Unexpected movement qty for second ASI MTransaction record");
		
		//reverse the MR
		Timestamp tomorrow = TimeUtil.addDays(today, 1);
		Env.setContext(Env.getCtx(), Env.DATE, tomorrow);
		shipment.load(getTrxName());
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Accrual);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Reversed, shipment.getDocStatus(), "Unexpected Shipment document status");
		newOnHand = MStorageOnHand.getQtyOnHandWithASIZero(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), getTrxName()).intValue();
		assertEquals(originalOnHand, newOnHand, "Unexpected on hand quantity no ASI");
		asiOnHand = MStorageOnHand.getQtyOnHand(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), asi.get_ID(), getTrxName()).intValue();
		assertEquals(0, asiOnHand, "Unexpected on hand quantity for Serial ASI");
		storages = MStorageOnHand.getOfProduct(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id, getTrxName());
		for (MStorageOnHand storage : storages) {
			if (storage.getM_Warehouse_ID() == getM_Warehouse_ID()) {
				if (storage.getM_AttributeSetInstance_ID() == asi.get_ID()) {
					assertEquals(0, storage.getQtyOnHand().intValue(), "Unexpected qty on hand for asi: " + storage.toString());
				}
			}
		}
		
		MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
		MInOutLine[] reversalLines = reversal.getLines();
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=0", getTrxName());
		List<MTransaction> noASITrxs = query.setParameters(reversalLines[0].get_ID(), reversalLines[0].getM_Product_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(1, noASITrxs.size(), "Unexpected number of records for reversal no ASI MTransaction");
		assertEquals(1, noASITrxs.get(0).getMovementQty().intValue(), "Unexpected reversal movement qty for no ASI MTransaction record");
		
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
		asiTrxs = query.setParameters(reversalLines[0].get_ID(), reversalLines[0].getM_Product_ID(), reversalLines[0].getM_AttributeSetInstance_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(2, asiTrxs.size(), "Unexpected number of records for reversal ASI MTransaction");
		assertEquals(1, asiTrxs.get(0).getMovementQty().intValue(), "Unexpected reversal movement qty for first ASI MTransaction record");
		assertEquals(-1, asiTrxs.get(1).getMovementQty().intValue(), "Unexpected reversal movement qty for second ASI MTransaction record");
	}
	
	@Test
	public void testSetASIWhenShipping2() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id));
		line1.setQty(new BigDecimal("2"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Unexpected Order document status");
		line1.load(getTrxName());
		assertEquals(2, line1.getQtyReserved().intValue(), "Unexpected order line qty reserved value");		
		
		int originalOnHand = MStorageOnHand.getQtyOnHandWithASIZero(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), getTrxName()).intValue();
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("2"));
		shipmentLine.setQty(new BigDecimal("2"));
		shipmentLine.saveEx();
		
		MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi1.setM_AttributeSet_ID(MProduct.get(DictionaryIDs.M_Product.P_CHAIR.id).getM_AttributeSet_ID());
		asi1.setSerNo("PChair Serial #1000000");
		asi1.saveEx();
		MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi2.setM_AttributeSet_ID(MProduct.get(DictionaryIDs.M_Product.P_CHAIR.id).getM_AttributeSet_ID());
		asi2.setSerNo("PChair Serial #1000000");
		asi2.saveEx();
		MInOutLineMA ma1 = new MInOutLineMA(Env.getCtx(), 0, getTrxName());
		ma1.setM_AttributeSetInstance_ID(asi1.get_ID());
		ma1.setM_InOutLine_ID(shipmentLine.get_ID());
		ma1.setDateMaterialPolicy(shipment.getMovementDate());
		ma1.setMovementQty(new BigDecimal("1"));
		ma1.setIsAutoGenerated(false);
		ma1.saveEx();
		MInOutLineMA ma2 = new MInOutLineMA(Env.getCtx(), 0, getTrxName());
		ma2.setM_AttributeSetInstance_ID(asi2.get_ID());
		ma2.setM_InOutLine_ID(shipmentLine.get_ID());
		ma2.setDateMaterialPolicy(shipment.getMovementDate());
		ma2.setMovementQty(new BigDecimal("1"));
		ma2.setIsAutoGenerated(false);
		ma2.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected Shipment document status");
		
		int newOnHand = MStorageOnHand.getQtyOnHandWithASIZero(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), getTrxName()).intValue();
		assertEquals(originalOnHand-2, newOnHand, "Unexpected on hand quantity");
				
		int asiOnHand = MStorageOnHand.getQtyOnHand(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), asi1.get_ID(), getTrxName()).intValue();
		int asiRecords = 0;
		MStorageOnHand[] storages = MStorageOnHand.getOfProduct(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id, getTrxName());
		for (MStorageOnHand storage : storages) {
			if (storage.getM_Warehouse_ID()==getM_Warehouse_ID() && storage.getM_AttributeSetInstance_ID()==asi1.get_ID()) {
				asiRecords++;
			}
		}
		assertEquals(0, asiOnHand, "Unexpected on hand quantity for Serial ASI 1");
		assertEquals(1, asiRecords, "Unexpected number of Serial ASI 1 Storage records");
		
		asiOnHand = MStorageOnHand.getQtyOnHand(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), asi2.get_ID(), getTrxName()).intValue();
		asiRecords = 0;
		storages = MStorageOnHand.getOfProduct(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id, getTrxName());
		for (MStorageOnHand storage : storages) {
			if (storage.getM_Warehouse_ID()==getM_Warehouse_ID() && storage.getM_AttributeSetInstance_ID()==asi2.get_ID()) {
				asiRecords++;
			}
		}
		assertEquals(0, asiOnHand, "Unexpected on hand quantity for Serial ASI 2");
		assertEquals(1, asiRecords, "Unexpected number of Serial ASI 2 Storage records");
		
		Query query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=0", getTrxName());
		MTransaction trxFrom = query.setParameters(shipmentLine.get_ID(), shipmentLine.getM_Product_ID()).first();
		assertNotNull(trxFrom, "Can't find MTransaction record for no ASI MTransaction record");
		assertEquals(-1, trxFrom.getMovementQty().intValue(), "Unexpected movement qty for no ASI MTransaction record");
		
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
		List<MTransaction> asiTrxs = query.setParameters(shipmentLine.get_ID(), shipmentLine.getM_Product_ID(), ma1.getM_AttributeSetInstance_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(2, asiTrxs.size(), "Unexpected number of records for ASI MTransaction");
		assertEquals(1, asiTrxs.get(0).getMovementQty().intValue(), "Unexpected movement qty for first ASI 1 MTransaction record");
		assertEquals(-1, asiTrxs.get(1).getMovementQty().intValue(), "Unexpected movement qty for second ASI 1 MTransaction record");
		
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
		asiTrxs = query.setParameters(shipmentLine.get_ID(), shipmentLine.getM_Product_ID(), ma2.getM_AttributeSetInstance_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(2, asiTrxs.size(), "Unexpected number of records for ASI MTransaction");
		assertEquals(1, asiTrxs.get(0).getMovementQty().intValue(), "Unexpected movement qty for first ASI 2 MTransaction record");
		assertEquals(-1, asiTrxs.get(1).getMovementQty().intValue(), "Unexpected movement qty for second ASI 2 MTransaction record");
		
		//reverse the MR
		Timestamp tomorrow = TimeUtil.addDays(today, 1);
		Env.setContext(Env.getCtx(), Env.DATE, tomorrow);
		shipment.load(getTrxName());
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Accrual);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Reversed, shipment.getDocStatus(), "Unexpected Shipment document status");
		newOnHand = MStorageOnHand.getQtyOnHandWithASIZero(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), getTrxName()).intValue();
		assertEquals(originalOnHand, newOnHand, "Unexpected on hand quantity no ASI");
		
		asiOnHand = MStorageOnHand.getQtyOnHand(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), asi1.get_ID(), getTrxName()).intValue();
		assertEquals(0, asiOnHand, "Unexpected on hand quantity for Serial ASI 1");
		storages = MStorageOnHand.getOfProduct(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id, getTrxName());
		for (MStorageOnHand storage : storages) {
			if (storage.getM_Warehouse_ID() == getM_Warehouse_ID()) {
				if (storage.getM_AttributeSetInstance_ID() == asi1.get_ID()) {
					assertEquals(0, storage.getQtyOnHand().intValue(), "Unexpected qty on hand for asi 1: " + storage.toString());
				}
			}
		}
		
		asiOnHand = MStorageOnHand.getQtyOnHand(DictionaryIDs.M_Product.P_CHAIR.id, getM_Warehouse_ID(), asi2.get_ID(), getTrxName()).intValue();
		assertEquals(0, asiOnHand, "Unexpected on hand quantity for Serial ASI 2");
		storages = MStorageOnHand.getOfProduct(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id, getTrxName());
		for (MStorageOnHand storage : storages) {
			if (storage.getM_Warehouse_ID() == getM_Warehouse_ID()) {
				if (storage.getM_AttributeSetInstance_ID() == asi2.get_ID()) {
					assertEquals(0, storage.getQtyOnHand().intValue(), "Unexpected qty on hand for asi 2: " + storage.toString());
				}
			}
		}
		
		MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
		MInOutLine[] reversalLines = reversal.getLines();
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=0", getTrxName());
		List<MTransaction> noASITrxs = query.setParameters(reversalLines[0].get_ID(), reversalLines[0].getM_Product_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(2, noASITrxs.size(), "Unexpected number of records for reversal no ASI MTransaction");
		assertEquals(1, noASITrxs.get(0).getMovementQty().intValue(), "Unexpected reversal movement qty for no ASI MTransaction record");
		assertEquals(1, noASITrxs.get(1).getMovementQty().intValue(), "Unexpected reversal movement qty for no ASI MTransaction record");
		
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
		asiTrxs = query.setParameters(reversalLines[0].get_ID(), reversalLines[0].getM_Product_ID(), asi1.getM_AttributeSetInstance_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(2, asiTrxs.size(), "Unexpected number of records for reversal ASI MTransaction");
		assertEquals(1, asiTrxs.get(0).getMovementQty().intValue(), "Unexpected reversal movement qty for first ASI 1 MTransaction record");
		assertEquals(-1, asiTrxs.get(1).getMovementQty().intValue(), "Unexpected reversal movement qty for second ASI 1 MTransaction record");
		
		query = new Query(Env.getCtx(), MTransaction.Table_Name, "M_InOutLine_ID=? AND M_Product_ID=? AND M_AttributeSetInstance_ID=?", getTrxName());
		asiTrxs = query.setParameters(reversalLines[0].get_ID(), reversalLines[0].getM_Product_ID(), asi2.getM_AttributeSetInstance_ID())
				.setOrderBy("M_Transaction_ID")
				.list();
		assertEquals(2, asiTrxs.size(), "Unexpected number of records for reversal ASI MTransaction");
		assertEquals(1, asiTrxs.get(0).getMovementQty().intValue(), "Unexpected reversal movement qty for first ASI 2 MTransaction record");
		assertEquals(-1, asiTrxs.get(1).getMovementQty().intValue(), "Unexpected reversal movement qty for second ASI 2 MTransaction record");
	}
	
	@Test
	public void testShipmentDateMaterialPolicy() {
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		Timestamp tomorrow  = TimeUtil.addDays(today, 1);
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);		
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MProduct fert = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.FERTILIZER_50.id);
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(fert);
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order not completed");
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		// receipt
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine.setQty(new BigDecimal("1"));
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Prepare);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_InProgress, receipt.getDocStatus());
		receiptLine.load(getTrxName());
		MInOutLineMA ma = new MInOutLineMA(Env.getCtx(), 0, getTrxName());
		ma.setM_InOutLine_ID(receiptLine.get_ID());
		ma.setIsAutoGenerated(false);
		MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi1.setM_AttributeSet_ID(fert.getM_AttributeSet_ID());
		String lot1 = UUID.randomUUID().toString();
		asi1.setLot(lot1);
		asi1.saveEx();
		ma.setM_AttributeSetInstance_ID(asi1.get_ID());
		ma.setMovementQty(new BigDecimal("1"));
		ma.saveEx();
		assertEquals(receipt.getMovementDate(), ma.getDateMaterialPolicy());
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);		
		order.setDateOrdered(tomorrow);
		order.setDatePromised(tomorrow);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(fert);
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(tomorrow);
		line1.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order not completed");
		
		receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		// receipt
		receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine.setQty(new BigDecimal("1"));
		receiptLine.saveEx();
	
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Prepare);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_InProgress, receipt.getDocStatus());
		receiptLine.load(getTrxName());
		ma = new MInOutLineMA(Env.getCtx(), 0, getTrxName());
		ma.setM_InOutLine_ID(receiptLine.get_ID());
		ma.setIsAutoGenerated(false);
		MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi2.setM_AttributeSet_ID(fert.getM_AttributeSet_ID());
		String lot2 = UUID.randomUUID().toString();
		asi2.setLot(lot2);
		asi2.saveEx();
		ma.setM_AttributeSetInstance_ID(asi2.get_ID());
		ma.setMovementQty(new BigDecimal("1"));
		ma.saveEx();
		assertEquals(receipt.getMovementDate(), ma.getDateMaterialPolicy());
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		int onHand1 = MStorageOnHand.getQtyOnHand(fert.get_ID(), getM_Warehouse_ID(), asi1.get_ID(), getTrxName()).intValue();
		int onHand2 = MStorageOnHand.getQtyOnHand(fert.get_ID(), getM_Warehouse_ID(), asi2.get_ID(), getTrxName()).intValue();
		assertEquals(onHand1, onHand2);
		assertEquals(1, onHand1);
		
		//sales and shipment
		order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(fert);
		line1.setQty(new BigDecimal("2"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(2, line1.getQtyReserved().intValue());		
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Prepare);
		shipment.saveEx();
		
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("2"));
		shipmentLine.setQty(new BigDecimal("2"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Prepare);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_InProgress, shipment.getDocStatus());
		shipmentLine.load(getTrxName());
		ma = new MInOutLineMA(Env.getCtx(), 0, getTrxName());
		ma.setM_InOutLine_ID(shipmentLine.get_ID());
		ma.setIsAutoGenerated(false);
		ma.setM_AttributeSetInstance_ID(asi1.get_ID());
		ma.setMovementQty(new BigDecimal("1"));
		ma.saveEx();
		assertEquals(today, ma.getDateMaterialPolicy());
		ma = new MInOutLineMA(Env.getCtx(), 0, getTrxName());
		ma.setM_InOutLine_ID(shipmentLine.get_ID());
		ma.setIsAutoGenerated(false);
		ma.setM_AttributeSetInstance_ID(asi2.get_ID());
		ma.setMovementQty(new BigDecimal("1"));
		ma.saveEx();
		assertEquals(tomorrow, ma.getDateMaterialPolicy());
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		
		onHand1 = MStorageOnHand.getQtyOnHand(fert.get_ID(), getM_Warehouse_ID(), asi1.get_ID(), getTrxName()).intValue();
		onHand2 = MStorageOnHand.getQtyOnHand(fert.get_ID(), getM_Warehouse_ID(), asi2.get_ID(), getTrxName()).intValue();
		assertEquals(onHand1, onHand2);
		assertEquals(0, onHand1);
	}
}
