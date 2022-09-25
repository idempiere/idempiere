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
 * - Carlos Ruiz - globalqss	       								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.compiere.model.SystemIDs.PROCESS_M_INOUT_GENERATERMA_MANUAL;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProduct;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MStorageReservation;
import org.compiere.model.MStorageReservationLog;
import org.compiere.model.MSysConfig;
import org.compiere.model.Query;
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

/**
 * @author Carlos Ruiz - globalqss
 */
public class PurchaseOrderTest extends AbstractTestCase {

	public PurchaseOrderTest() {
	}

	private static final BigDecimal THREE = new BigDecimal("3");
	private static final BigDecimal MINUS_THREE = new BigDecimal("-3");

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4575
	 */
	@Test
	public void testQtyReservedForNegativeOrderAndReceipt() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.SEEDER.id));
		line1.setQty(new BigDecimal("-1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		// negative receipt
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(line1, 0, new BigDecimal("-1"));
		receiptLine.setQty(new BigDecimal("-1"));
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());

		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());		
	}

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4577
	 */
	@Test
	public void testPositiveAndNegativeOrderThenReceiptThenInvoice() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.WEEDER.id));
		line1.setQty(new BigDecimal("10"));
		line1.setDatePromised(today);
		line1.saveEx();

		MOrderLine line2 = new MOrderLine(order);
		line2.setLine(20);
		line2.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.SEEDER.id));
		line2.setQty(new BigDecimal("-1"));
		line2.setDatePromised(today);
		line2.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt);
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("10"));
		receiptLine1.setQty(new BigDecimal("10"));
		receiptLine1.saveEx();

		MInOutLine receiptLine2 = new MInOutLine(receipt);
		receiptLine2.setOrderLine(line2, 0, new BigDecimal("-1"));
		receiptLine2.setQty(new BigDecimal("-1"));
		receiptLine2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());

		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine invoiceLine1 = new MInvoiceLine(invoice);
		invoiceLine1.setOrderLine(line1);
		invoiceLine1.setQty(new BigDecimal("10"));
		invoiceLine1.saveEx();

		MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice);
		invoiceLine2.setOrderLine(line2);
		invoiceLine2.setQty(new BigDecimal("-1"));
		invoiceLine2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(trxName);
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());

	}

	/*
	 * IDEMPIERE-4587
	 */
	@Test
	public void testOrderedStorageForReactivatedOrder() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		BigDecimal qtyOrderedOriginal = getQtyOrdered(ctx, DictionaryIDs.M_Product.HOLLY_BUSH.id, trxName);

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.HOLLY_BUSH.id));
		line1.setQty(THREE);
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().compareTo(THREE));

		BigDecimal newQtyOrdered = getQtyOrdered(ctx, DictionaryIDs.M_Product.HOLLY_BUSH.id, trxName);
		assertEquals(0, qtyOrderedOriginal.add(THREE).compareTo(newQtyOrdered));

		MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt1.setDocStatus(DocAction.STATUS_Drafted);
		receipt1.setDocAction(DocAction.ACTION_Complete);
		receipt1.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt1);
		receiptLine1.setOrderLine(line1, 0, THREE);
		receiptLine1.setQty(THREE);
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt1.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());

		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().compareTo(Env.ZERO));

		newQtyOrdered = getQtyOrdered(ctx, DictionaryIDs.M_Product.HOLLY_BUSH.id, trxName);
		assertEquals(0, qtyOrderedOriginal.compareTo(newQtyOrdered));

		// reactivate the purchase order
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_ReActivate);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_InProgress, order.getDocStatus());

		// change the line quantity to zero
		line1.load(trxName);
		line1.setQty(Env.ZERO);
		line1.saveEx();

		// complete the order again
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		// IDEMPIERE-5039 - when reservations go negative they are changed to zero
		assertEquals(0, line1.getQtyReserved().compareTo(Env.ZERO));

		newQtyOrdered = getQtyOrdered(ctx, DictionaryIDs.M_Product.HOLLY_BUSH.id, trxName);
		assertEquals(0, qtyOrderedOriginal.compareTo(newQtyOrdered));

		// create a new material receipt for the -3 reversed
		MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt2.setDocStatus(DocAction.STATUS_Drafted);
		receipt2.setDocAction(DocAction.ACTION_Complete);
		receipt2.saveEx();

		MInOutLine receiptLine2 = new MInOutLine(receipt2);
		receiptLine2.setOrderLine(line1, 0, MINUS_THREE);
		receiptLine2.setQty(MINUS_THREE);
		receiptLine2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt2.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());

		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().compareTo(Env.ZERO));

		newQtyOrdered = getQtyOrdered(ctx, DictionaryIDs.M_Product.HOLLY_BUSH.id, trxName);
		assertEquals(0, qtyOrderedOriginal.compareTo(newQtyOrdered));
	}

	private BigDecimal getQtyOrdered(Properties ctx, int M_Product_ID, String trxName) {
		BigDecimal qtyOrdered = Env.ZERO;
		for (MStorageReservation rs : MStorageReservation.getOfProduct(ctx, M_Product_ID, trxName)) {
			if (! rs.isSOTrx())
				qtyOrdered = qtyOrdered.add(rs.getQty());
		}
		return qtyOrdered;
	}

	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4768
	 */
	public void testMultiDateMaterialReceipt() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		MProduct fert50 = new MProduct(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id, trxName);

		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		Timestamp past_month = TimeUtil.addMonths(today, -1);
		
		// create an ASI for Fertilizer Lot with Lot 2020  
		MAttributeSetInstance asi = new MAttributeSetInstance(ctx, 0, trxName);
		asi.setM_AttributeSet_ID(fert50.getM_AttributeSet_ID());
		asi.setLot("2020");
		asi.saveEx();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Warehouse);
		// ?? why setC_DocTypeTarget_ID sets back IsSOTrx=true
		order.setIsSOTrx(false);
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.FERTILIZER.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setPaymentRule(MOrder.PAYMENTRULE_OnCredit); // this is the default, just making it explicit
		order.setDateOrdered(past_month);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id));
		line1.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(past_month);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());
		assertEquals(1, line1.getQtyDelivered().intValue());
		assertEquals(0, line1.getQtyInvoiced().intValue());

		MOrder order2 = new MOrder(ctx, 0, trxName);
		order2.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
		order2.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order2.setIsSOTrx(false);
		order2.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Warehouse);
		// ?? why setC_DocTypeTarget_ID sets back IsSOTrx=true
		order2.setIsSOTrx(false);
		order2.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.FERTILIZER.id);
		order2.setDocStatus(DocAction.STATUS_Drafted);
		order2.setDocAction(DocAction.ACTION_Complete);
		order2.setPaymentRule(MOrder.PAYMENTRULE_OnCredit); // this is the default, just making it explicit
		order2.setDateOrdered(today);
		order2.saveEx();

		MOrderLine line2 = new MOrderLine(order2);
		line2.setLine(10);
		line2.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.FERTILIZER_50.id));
		line2.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line2.setQty(new BigDecimal("1"));
		line2.setDatePromised(today);
		line2.saveEx();

		ProcessInfo info2 = MWorkflow.runDocumentActionWorkflow(order2, DocAction.ACTION_Complete);
		assertFalse(info2.isError(), info2.getSummary());
		order2.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order2.getDocStatus());
		line2.load(trxName);
		assertEquals(0, line2.getQtyReserved().intValue());
		assertEquals(1, line2.getQtyDelivered().intValue());
		assertEquals(0, line2.getQtyInvoiced().intValue());

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
	}

	@Test
	public void testQtyOrderedLog() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.WEEDER.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		Query query = new Query(Env.getCtx(), MStorageReservationLog.Table_Name, "M_Product_ID=? AND IsSOTrx='N' AND M_Warehouse_ID=?", getTrxName());
		MStorageReservationLog log = query.setOrderBy(MStorageReservationLog.COLUMNNAME_M_StorageReservationLog_ID+" Desc")
				.setParameters(DictionaryIDs.M_Product.WEEDER.id, line1.getM_Warehouse_ID()).first();
		assertNotNull(log, "MStorageReservationLog not created after completion of purchase order");
		assertTrue(log.getDeltaQty().intValue() == 1, "Delta quantity of MStorageReservationLog != 1 ("+log.getDeltaQty().toPlainString()+")");
		MStorageReservation ordered = MStorageReservation.get(Env.getCtx(), line1.getM_Warehouse_ID(), DictionaryIDs.M_Product.WEEDER.id, 0, false, getTrxName());
		assertTrue(log.getNewQty().equals(ordered.getQty()), "New Qty from MStorageReservationLog != Qty from MStorageReservation");
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt);
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine1.setQty(new BigDecimal("1"));
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		log = query.first();
		assertNotNull(log, "MStorageReservationLog not created after completion of material receipt");
		assertTrue(log.getDeltaQty().intValue() == -1, "Delta quantity of MStorageReservationLog != -1 ("+log.getDeltaQty().toPlainString()+")");
		ordered = MStorageReservation.get(Env.getCtx(), line1.getM_Warehouse_ID(), DictionaryIDs.M_Product.WEEDER.id, 0, false, getTrxName());
		assertTrue(log.getNewQty().equals(ordered.getQty()), "New Qty from MStorageReservationLog != Qty from MStorageReservation");
	}
	
	@Test
	public void testQtyOverReceipt() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		
		DB.executeUpdateEx("UPDATE AD_SysConfig SET Value='N' WHERE AD_Client_ID=0 AND Name=?", 
				new Object[] {MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY}, null);
		CacheMgt.get().reset();

		BigDecimal initialQtyOrdered = getQtyOrdered(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id, getTrxName());
		try {			
			MOrder order = new MOrder(ctx, 0, trxName);
			order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			order.setDateOrdered(today);
			order.setDatePromised(today);
			order.saveEx();
	
			MOrderLine line1 = new MOrderLine(order);
			line1.setLine(10);
			line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.ROSE_BUSH.id));
			line1.setQty(new BigDecimal("1"));
			line1.setDatePromised(today);
			line1.saveEx();
	
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(trxName);
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order not completed");
			line1.load(trxName);
			assertEquals(1, line1.getQtyReserved().intValue(), "Wrong Order line qty reserved value");
			BigDecimal newQtyOrdered = getQtyOrdered(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id, getTrxName());
			assertEquals(initialQtyOrdered.intValue()+1, newQtyOrdered.intValue(), "Quantiy Ordered not updated as expected");
	
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();
	
			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("2"));
			receiptLine1.setQty(new BigDecimal("2"));
			receiptLine1.saveEx();
	
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(trxName);
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus(), "Material receipt not completed");
	
			line1.load(trxName);
			assertEquals(0, line1.getQtyReserved().intValue(), "Wrong order line qty reserved value");
			newQtyOrdered = getQtyOrdered(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id, getTrxName());
			assertEquals(initialQtyOrdered.intValue(), newQtyOrdered.intValue(), "Quantiy Ordered not updated as expected");
	
			// reactivate the purchase order
			info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_ReActivate);
			assertFalse(info.isError(), info.getSummary());
			order.load(trxName);
			assertEquals(DocAction.STATUS_InProgress, order.getDocStatus(), "Order not reactivated");
	
			// change the line quantity to 2
			line1.load(trxName);
			line1.setQty(new BigDecimal("2"));
			line1.saveEx();
	
			// complete the order again
			info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(trxName);
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order not completed");
			line1.load(trxName);
			assertEquals(0, line1.getQtyReserved().intValue(), "Wrong order line qty reserved value");
			assertEquals(2, line1.getQtyOrdered().intValue(), "Wrong order line qty ordered value");
			newQtyOrdered = getQtyOrdered(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id, getTrxName());
			assertEquals(initialQtyOrdered.intValue(), newQtyOrdered.intValue(), "Quantiy Ordered not updated as expected");
	
			//reverse MR
			receiptLine1.load(trxName);
			assertEquals(2, receiptLine1.getMovementQty().intValue(), "Wrong receipt line movement qty value");
			receipt1.load(trxName);
			receipt1.getLines(true);
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(trxName);
			assertEquals(DocAction.STATUS_Reversed, receipt1.getDocStatus(), "Material receipt not reversed");
			line1.load(trxName);
			assertEquals(2, line1.getQtyReserved().intValue(), "Wrong order line qty reserved value");
			assertEquals(0, line1.getQtyDelivered().intValue(), "Wrong order line qty delivered value");
			newQtyOrdered = getQtyOrdered(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id, getTrxName());
			assertEquals(initialQtyOrdered.intValue()+2, newQtyOrdered.intValue(), "Quantiy Ordered not updated as expected");
		} finally {
			DB.executeUpdateEx("UPDATE AD_SysConfig SET Value='Y' WHERE AD_Client_ID=0 AND Name=?", 
					new Object[] {MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY}, null);
			CacheMgt.get().reset();
		}
	}
	
	@Test
	public void testVendorRMA() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt);
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine1.setQty(new BigDecimal("1"));
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setM_InOut_ID(receipt.getM_InOut_ID());
		rma.setC_BPartner_ID(receipt.getC_BPartner_ID());
		rma.setC_Currency_ID(order.getC_Currency_ID());
		rma.setIsSOTrx(false);
		rma.setName("testVendorRMA");
		rma.setC_DocType_ID(DictionaryIDs.C_DocType.VENDOR_RETURN_MATERIAL.id);
		rma.setSalesRep_ID(order.getSalesRep_ID());
		rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
		rma.saveEx();
		
		MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
		rmaLine.setM_RMA_ID(rma.get_ID());
		rmaLine.setM_InOutLine_ID(receiptLine1.get_ID());
		rmaLine.setQty(receiptLine1.getMovementQty());
		rmaLine.saveEx();
		assertEquals(0, rmaLine.getQtyDelivered().intValue(), "Unexpected RMA Line QtyDelivered value");
		
		info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		rma.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());
		
		int AD_Process_ID = PROCESS_M_INOUT_GENERATERMA_MANUAL;
		MPInstance instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0);
		instance.saveEx();
		
		String insert = "INSERT INTO T_SELECTION(AD_PINSTANCE_ID, T_SELECTION_ID) Values (?, ?)";
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), rma.get_ID()}, null);
		
		//call process
		ProcessInfo pi = new ProcessInfo ("InOutGenRMA", AD_Process_ID);
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
		
		rmaLine.load(getTrxName());
		assertEquals(rmaLine.getQty().intValue(), rmaLine.getQtyDelivered().intValue(), "RMA Line QtyDelivered not updated by shipment for Vendor RMA");
	}
}
