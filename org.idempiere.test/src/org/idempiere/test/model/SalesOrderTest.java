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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MPayment;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MWarehouse;
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
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 */
public class SalesOrderTest extends AbstractTestCase {

	public SalesOrderTest() {
	}

	private final static int BP_JOE_BLOCK = 118;
	private static final int PRODUCT_OAK_TREE = 123;
	private static final int PRODUCT_AZALEA = 128;
	private static final int PRODUCT_FERT50 = 136;
	private static final int ORG_FERTILIZER = 50001;
	private static final int WAREHOUSE_FERTILIZER = 50002;
	private static final int LOCATOR_FERTILIZER = 50001;

	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-235
	 */
	public void testDatePromisedValidation() {
		//first test - invalid with completeorder and multiple datepromised
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
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
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_AZALEA));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		MOrderLine line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), PRODUCT_OAK_TREE));
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
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_AZALEA));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), PRODUCT_OAK_TREE));
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
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_Availability);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDatePromised(today);
		order.saveEx();
		
		line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_AZALEA));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		line2 = new MOrderLine(order);
		line2.setLine(20);
		//Oak Tree	
		line2.setProduct(MProduct.get(Env.getCtx(), PRODUCT_OAK_TREE));
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
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
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
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_AZALEA));
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
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
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
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_AZALEA));
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
	public void testOnCreditPOSOrder() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// Get the OpenBalance of Joe Block
		MBPartner bpartner = new MBPartner(ctx, BP_JOE_BLOCK, trxName);
		BigDecimal initialBalance = bpartner.getTotalOpenBalance();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, BP_JOE_BLOCK));
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
		line1.setProduct(MProduct.get(ctx, PRODUCT_AZALEA));
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
		MBPartner bpartner = new MBPartner(ctx, BP_JOE_BLOCK, trxName);
		BigDecimal initialBalance = bpartner.getTotalOpenBalance();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, BP_JOE_BLOCK));
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
		line1.setProduct(MProduct.get(ctx, PRODUCT_AZALEA));
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
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
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
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_AZALEA));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError());
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
		order1.setDeliveryRule(MOrder.DELIVERYRULE_AfterReceipt);
		order1.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order1, DocAction.ACTION_Complete);
		assertFalse(info.isError());
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
		assertFalse(info.isError());
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
		order2.setDeliveryRule(MOrder.DELIVERYRULE_AfterReceipt);
		order2.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(order2, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		order2.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order2.getDocStatus());
		line1 = order2.getLines()[0];
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		//create invoice
		instance = new MPInstance(Env.getCtx(), SystemIDs.PROCESS_C_INVOICE_GENERATE, 0);
		instance.saveEx();
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), order2.getC_Order_ID()}, null);		
		pi = new ProcessInfo ("InvoiceGen", AD_Process_ID);
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
		assertFalse(info.isError());
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
	 */
	public void testMultiASIShipment() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MProduct fert50 = new MProduct(ctx, PRODUCT_FERT50, trxName);

		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		Timestamp past_month = TimeUtil.addMonths(today, -1);

		MWarehouse wh = new MWarehouse(ctx, WAREHOUSE_FERTILIZER, trxName);
		wh.setIsDisallowNegativeInv(true);
		wh.saveEx();
		CacheMgt.get().reset(MWarehouse.Table_Name, WAREHOUSE_FERTILIZER);
		// Put the modified record into cache
		MWarehouse.get(ctx, WAREHOUSE_FERTILIZER, trxName);

		// create an ASI for Fertilizer Lot with Lot 1010  
		MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
		asi.setM_AttributeSet_ID(fert50.getM_AttributeSet_ID());
		asi.setLot("1010");
		asi.saveEx();

		MStorageOnHand.add(ctx, WAREHOUSE_FERTILIZER, LOCATOR_FERTILIZER, PRODUCT_FERT50, asi.getM_AttributeSetInstance_ID(), Env.ONE, past_month, trxName);
		MStorageOnHand.add(ctx, WAREHOUSE_FERTILIZER, LOCATOR_FERTILIZER, PRODUCT_FERT50, asi.getM_AttributeSetInstance_ID(), Env.ONE, today, trxName);

		// Expected to create two entries in storage because of the different dates
		MStorageOnHand[] storages = MStorageOnHand.getWarehouse(ctx, WAREHOUSE_FERTILIZER,
				PRODUCT_FERT50, asi.getM_AttributeSetInstance_ID(), null,
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
		order.setAD_Org_ID(ORG_FERTILIZER);
		order.setBPartner(MBPartner.get(ctx, BP_JOE_BLOCK));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_POS);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setM_Warehouse_ID(WAREHOUSE_FERTILIZER);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_OnCredit); // this is the default, just making it explicit
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, PRODUCT_FERT50));
		line1.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line1.setQty(new BigDecimal("2"));
		line1.setDatePromised(today);
		line1.saveEx();

		// Expected to complete without problems
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(2, line1.getQtyDelivered().intValue());
		assertEquals(2, line1.getQtyInvoiced().intValue());

		// Expected to have cleared both storage entries on shipment
		storages = MStorageOnHand.getWarehouse(ctx, WAREHOUSE_FERTILIZER,
				PRODUCT_FERT50, asi.getM_AttributeSetInstance_ID(), null,
				MClient.MMPOLICY_FiFo.equals(fert50.getMMPolicy()), false,
				0, trxName);
		assertEquals(0, storages.length);
	}

}
