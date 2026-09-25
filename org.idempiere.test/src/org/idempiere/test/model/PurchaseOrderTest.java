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
import java.util.Calendar;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInfoWindow;
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
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

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

		BigDecimal initialQtyOrdered = getQtyOrdered(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id, getTrxName());
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getBooleanValue(MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY, true,
					Env.getAD_Client_ID(ctx))).thenReturn(false);

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
		}
	}

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-7075
	 */
	@Test
	public void testOverReceiptReversalAndOrderCloseReservation() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		int productId = DictionaryIDs.M_Product.ROSE_BUSH.id;
		BigDecimal qtyOrdered = new BigDecimal("300");
		BigDecimal qtyReceived = new BigDecimal("303");
		BigDecimal initialQtyOrdered = getQtyOrdered(ctx, productId, trxName);

		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getBooleanValue(MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY, true,
					Env.getAD_Client_ID(ctx))).thenReturn(false);

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

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(MProduct.get(ctx, productId));
			orderLine.setQty(qtyOrdered);
			orderLine.setDatePromised(today);
			orderLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(trxName);
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order not completed");
			orderLine.load(trxName);
			assertEquals(0, qtyOrdered.compareTo(orderLine.getQtyReserved()), "Wrong order line reserved qty after order completion");
			assertEquals(0, initialQtyOrdered.add(qtyOrdered).compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Wrong storage reservation after order completion");

			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();

			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setOrderLine(orderLine, 0, qtyReceived);
			receiptLine.setQty(qtyReceived);
			receiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(trxName);
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus(), "Material receipt not completed");
			orderLine.load(trxName);
			assertEquals(0, Env.ZERO.compareTo(orderLine.getQtyReserved()), "Order line reservation not cleared by over-receipt");
			assertEquals(0, initialQtyOrdered.compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Storage reservation not cleared by over-receipt");

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(trxName);
			assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus(), "Material receipt not reversed");
			orderLine.load(trxName);
			assertEquals(0, qtyOrdered.compareTo(orderLine.getQtyReserved()), "Over-receipt quantity was restored as reservation");
			assertEquals(0, initialQtyOrdered.add(qtyOrdered).compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Wrong storage reservation after reversing over-receipt");

			info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Close);
			assertFalse(info.isError(), info.getSummary());
			order.load(trxName);
			assertEquals(DocAction.STATUS_Closed, order.getDocStatus(), "Order not closed");
			orderLine.load(trxName);
			assertEquals(0, Env.ZERO.compareTo(orderLine.getQtyOrdered()), "Wrong ordered qty on closed order line");
			assertEquals(0, Env.ZERO.compareTo(orderLine.getQtyDelivered()), "Wrong delivered qty on closed order line");
			assertEquals(0, qtyOrdered.compareTo(orderLine.getQtyLostSales()), "Wrong lost sales qty on closed order line");
			assertEquals(0, Env.ZERO.compareTo(orderLine.getQtyReserved()), "Order line reservation not cleared on close");
			assertEquals(0, initialQtyOrdered.compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Closed order left a storage reservation");
		}
	}

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-7075
	 */
	@Test
	public void testPartialReceiptsOverReceiptReversalAndOrderCloseReservation() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		int productId = DictionaryIDs.M_Product.ROSE_BUSH.id;
		BigDecimal qtyOrdered = new BigDecimal("200");
		BigDecimal firstReceiptQty = new BigDecimal("150");
		BigDecimal secondReceiptQty = new BigDecimal("60");
		BigDecimal openQtyAfterFirstReceipt = new BigDecimal("50");
		BigDecimal initialQtyOrdered = getQtyOrdered(ctx, productId, trxName);

		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getBooleanValue(MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY, true,
					Env.getAD_Client_ID(ctx))).thenReturn(false);

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

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(MProduct.get(ctx, productId));
			orderLine.setQty(qtyOrdered);
			orderLine.setDatePromised(today);
			orderLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(trxName);
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order not completed");
			orderLine.load(trxName);
			assertEquals(0, qtyOrdered.compareTo(orderLine.getQtyReserved()), "Wrong order line reserved qty after order completion");
			assertEquals(0, initialQtyOrdered.add(qtyOrdered).compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Wrong storage reservation after order completion");

			MInOut firstReceipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			firstReceipt.setDocStatus(DocAction.STATUS_Drafted);
			firstReceipt.setDocAction(DocAction.ACTION_Complete);
			firstReceipt.saveEx();

			MInOutLine firstReceiptLine = new MInOutLine(firstReceipt);
			firstReceiptLine.setOrderLine(orderLine, 0, firstReceiptQty);
			firstReceiptLine.setQty(firstReceiptQty);
			firstReceiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(firstReceipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			firstReceipt.load(trxName);
			assertEquals(DocAction.STATUS_Completed, firstReceipt.getDocStatus(), "First material receipt not completed");
			orderLine.load(trxName);
			assertEquals(0, firstReceiptQty.compareTo(orderLine.getQtyDelivered()), "Wrong delivered qty after first receipt");
			assertEquals(0, openQtyAfterFirstReceipt.compareTo(orderLine.getQtyReserved()), "Wrong reserved qty after first receipt");
			assertEquals(0, initialQtyOrdered.add(openQtyAfterFirstReceipt).compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Wrong storage reservation after first receipt");

			MInOut secondReceipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			secondReceipt.setDocStatus(DocAction.STATUS_Drafted);
			secondReceipt.setDocAction(DocAction.ACTION_Complete);
			secondReceipt.saveEx();

			MInOutLine secondReceiptLine = new MInOutLine(secondReceipt);
			secondReceiptLine.setOrderLine(orderLine, 0, secondReceiptQty);
			secondReceiptLine.setQty(secondReceiptQty);
			secondReceiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(secondReceipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			secondReceipt.load(trxName);
			assertEquals(DocAction.STATUS_Completed, secondReceipt.getDocStatus(), "Second material receipt not completed");
			orderLine.load(trxName);
			assertEquals(0, firstReceiptQty.add(secondReceiptQty).compareTo(orderLine.getQtyDelivered()),
					"Wrong delivered qty after second receipt");
			assertEquals(0, Env.ZERO.compareTo(orderLine.getQtyReserved()), "Order line reservation not cleared by over-receipt");
			assertEquals(0, initialQtyOrdered.compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Storage reservation not cleared by over-receipt");

			info = MWorkflow.runDocumentActionWorkflow(secondReceipt, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			secondReceipt.load(trxName);
			assertEquals(DocAction.STATUS_Reversed, secondReceipt.getDocStatus(), "Second material receipt not reversed");
			orderLine.load(trxName);
			assertEquals(0, firstReceiptQty.compareTo(orderLine.getQtyDelivered()), "Wrong delivered qty after reversing second receipt");
			assertEquals(0, openQtyAfterFirstReceipt.compareTo(orderLine.getQtyReserved()),
					"Reversal restored more than the open order quantity");
			assertEquals(0, initialQtyOrdered.add(openQtyAfterFirstReceipt).compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Wrong storage reservation after reversing second receipt");

			info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Close);
			assertFalse(info.isError(), info.getSummary());
			order.load(trxName);
			assertEquals(DocAction.STATUS_Closed, order.getDocStatus(), "Order not closed");
			orderLine.load(trxName);
			assertEquals(0, firstReceiptQty.compareTo(orderLine.getQtyOrdered()), "Wrong ordered qty on closed order line");
			assertEquals(0, firstReceiptQty.compareTo(orderLine.getQtyDelivered()), "Wrong delivered qty on closed order line");
			assertEquals(0, openQtyAfterFirstReceipt.compareTo(orderLine.getQtyLostSales()), "Wrong lost sales qty on closed order line");
			assertEquals(0, Env.ZERO.compareTo(orderLine.getQtyReserved()), "Order line reservation not cleared on close");
			assertEquals(0, initialQtyOrdered.compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Closed order left a storage reservation");
		}
	}

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-7075
	 */
	@Test
	public void testOverReceiptReversalDoesNotAffectOtherOrderReservation() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		int productId = DictionaryIDs.M_Product.ROSE_BUSH.id;
		BigDecimal firstOrderQty = new BigDecimal("200");
		BigDecimal secondOrderQty = new BigDecimal("100");
		BigDecimal firstReceiptQty = new BigDecimal("150");
		BigDecimal overReceiptQty = new BigDecimal("60");
		BigDecimal firstOrderOpenQty = new BigDecimal("50");
		BigDecimal initialQtyOrdered = getQtyOrdered(ctx, productId, trxName);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getBooleanValue(MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY, true,
					Env.getAD_Client_ID(ctx))).thenReturn(false);

			MOrder firstOrder = new MOrder(ctx, 0, trxName);
			firstOrder.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
			firstOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			firstOrder.setIsSOTrx(false);
			firstOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			firstOrder.setDocStatus(DocAction.STATUS_Drafted);
			firstOrder.setDocAction(DocAction.ACTION_Complete);
			firstOrder.setDateOrdered(today);
			firstOrder.setDatePromised(today);
			firstOrder.saveEx();

			MOrderLine firstOrderLine = new MOrderLine(firstOrder);
			firstOrderLine.setLine(10);
			firstOrderLine.setProduct(MProduct.get(ctx, productId));
			firstOrderLine.setQty(firstOrderQty);
			firstOrderLine.setDatePromised(today);
			firstOrderLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(firstOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			firstOrder.load(trxName);
			assertEquals(DocAction.STATUS_Completed, firstOrder.getDocStatus(), "First order not completed");

			MOrder secondOrder = new MOrder(ctx, 0, trxName);
			secondOrder.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
			secondOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			secondOrder.setIsSOTrx(false);
			secondOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			secondOrder.setDocStatus(DocAction.STATUS_Drafted);
			secondOrder.setDocAction(DocAction.ACTION_Complete);
			secondOrder.setDateOrdered(today);
			secondOrder.setDatePromised(today);
			secondOrder.saveEx();

			MOrderLine secondOrderLine = new MOrderLine(secondOrder);
			secondOrderLine.setLine(10);
			secondOrderLine.setProduct(MProduct.get(ctx, productId));
			secondOrderLine.setQty(secondOrderQty);
			secondOrderLine.setDatePromised(today);
			secondOrderLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(secondOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			secondOrder.load(trxName);
			assertEquals(DocAction.STATUS_Completed, secondOrder.getDocStatus(), "Second order not completed");
			firstOrderLine.load(trxName);
			secondOrderLine.load(trxName);
			assertEquals(0, firstOrderQty.compareTo(firstOrderLine.getQtyReserved()), "Wrong reservation on first order line");
			assertEquals(0, secondOrderQty.compareTo(secondOrderLine.getQtyReserved()), "Wrong reservation on second order line");
			assertEquals(0, initialQtyOrdered.add(firstOrderQty).add(secondOrderQty)
					.compareTo(getQtyOrdered(ctx, productId, trxName)), "Wrong combined storage reservation");

			MInOut firstReceipt = new MInOut(firstOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, firstOrder.getDateOrdered());
			firstReceipt.setDocStatus(DocAction.STATUS_Drafted);
			firstReceipt.setDocAction(DocAction.ACTION_Complete);
			firstReceipt.saveEx();

			MInOutLine firstReceiptLine = new MInOutLine(firstReceipt);
			firstReceiptLine.setOrderLine(firstOrderLine, 0, firstReceiptQty);
			firstReceiptLine.setQty(firstReceiptQty);
			firstReceiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(firstReceipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			firstOrderLine.load(trxName);
			secondOrderLine.load(trxName);
			assertEquals(0, firstOrderOpenQty.compareTo(firstOrderLine.getQtyReserved()), "Wrong reservation after first receipt");
			assertEquals(0, secondOrderQty.compareTo(secondOrderLine.getQtyReserved()), "First receipt changed second order line");
			assertEquals(0, initialQtyOrdered.add(firstOrderOpenQty).add(secondOrderQty)
					.compareTo(getQtyOrdered(ctx, productId, trxName)), "Wrong combined reservation after first receipt");

			MInOut overReceipt = new MInOut(firstOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, firstOrder.getDateOrdered());
			overReceipt.setDocStatus(DocAction.STATUS_Drafted);
			overReceipt.setDocAction(DocAction.ACTION_Complete);
			overReceipt.saveEx();

			MInOutLine overReceiptLine = new MInOutLine(overReceipt);
			overReceiptLine.setOrderLine(firstOrderLine, 0, overReceiptQty);
			overReceiptLine.setQty(overReceiptQty);
			overReceiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(overReceipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			firstOrderLine.load(trxName);
			secondOrderLine.load(trxName);
			assertEquals(0, Env.ZERO.compareTo(firstOrderLine.getQtyReserved()), "Over-received first order still reserved");
			assertEquals(0, secondOrderQty.compareTo(secondOrderLine.getQtyReserved()), "Over-receipt changed second order line");
			assertEquals(0, initialQtyOrdered.add(secondOrderQty).compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Over-receipt changed the other order's storage reservation");

			info = MWorkflow.runDocumentActionWorkflow(overReceipt, DocAction.ACTION_Reverse_Correct);
			assertFalse(info.isError(), info.getSummary());
			overReceipt.load(trxName);
			assertEquals(DocAction.STATUS_Reversed, overReceipt.getDocStatus(), "Over-receipt not reversed");
			firstOrderLine.load(trxName);
			secondOrderLine.load(trxName);
			assertEquals(0, firstOrderOpenQty.compareTo(firstOrderLine.getQtyReserved()), "Wrong first order reservation after reversal");
			assertEquals(0, secondOrderQty.compareTo(secondOrderLine.getQtyReserved()), "Reversal changed second order line");
			assertEquals(0, initialQtyOrdered.add(firstOrderOpenQty).add(secondOrderQty)
					.compareTo(getQtyOrdered(ctx, productId, trxName)), "Wrong combined reservation after reversal");

			info = MWorkflow.runDocumentActionWorkflow(firstOrder, DocAction.ACTION_Close);
			assertFalse(info.isError(), info.getSummary());
			firstOrder.load(trxName);
			assertEquals(DocAction.STATUS_Closed, firstOrder.getDocStatus(), "First order not closed");
			firstOrderLine.load(trxName);
			secondOrderLine.load(trxName);
			assertEquals(0, firstReceiptQty.compareTo(firstOrderLine.getQtyOrdered()), "Wrong ordered qty on closed first order line");
			assertEquals(0, firstReceiptQty.compareTo(firstOrderLine.getQtyDelivered()), "Wrong delivered qty on closed first order line");
			assertEquals(0, firstOrderOpenQty.compareTo(firstOrderLine.getQtyLostSales()), "Wrong lost sales on closed first order line");
			assertEquals(0, Env.ZERO.compareTo(firstOrderLine.getQtyReserved()), "Closed first order line still reserved");
			assertEquals(0, secondOrderQty.compareTo(secondOrderLine.getQtyReserved()), "Closing first order changed second order line");
			assertEquals(0, initialQtyOrdered.add(secondOrderQty).compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Closing first order did not preserve second order's storage reservation");

			info = MWorkflow.runDocumentActionWorkflow(secondOrder, DocAction.ACTION_Close);
			assertFalse(info.isError(), info.getSummary());
			secondOrder.load(trxName);
			assertEquals(DocAction.STATUS_Closed, secondOrder.getDocStatus(), "Second order not closed");
			secondOrderLine.load(trxName);
			assertEquals(0, Env.ZERO.compareTo(secondOrderLine.getQtyOrdered()), "Wrong ordered qty on closed second order line");
			assertEquals(0, Env.ZERO.compareTo(secondOrderLine.getQtyDelivered()), "Wrong delivered qty on closed second order line");
			assertEquals(0, secondOrderQty.compareTo(secondOrderLine.getQtyLostSales()), "Wrong lost sales on closed second order line");
			assertEquals(0, Env.ZERO.compareTo(secondOrderLine.getQtyReserved()), "Closed second order line still reserved");
			assertEquals(0, initialQtyOrdered.compareTo(getQtyOrdered(ctx, productId, trxName)),
					"Closing both orders did not clear the combined storage reservation");
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
		MPInstance instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0, 0, null);
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
	
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-5915
	 */
	@Test
	public void testInOutGenerateRMAManualMovementDate() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		cal.setTimeInMillis(currentDate.getTime());
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date2 = new Timestamp(cal.getTimeInMillis());
		
		order.setDateOrdered(date1);
		order.setDatePromised(date1);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ROSE_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(date1);
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
		rma.setName("testInOutGenerateRMAManualMovementDate");
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
		MPInstance instance = new MPInstance(Env.getCtx(), AD_Process_ID, 0, 0, null);
		instance.saveEx();
		
		String insert = "INSERT INTO T_SELECTION(AD_PINSTANCE_ID, T_SELECTION_ID) Values (?, ?)";
		DB.executeUpdateEx(insert, new Object[] {instance.getAD_PInstance_ID(), rma.get_ID()}, null);
		
		//	Call InOutGenerateRMAManual process
		ProcessInfo pi = new ProcessInfo ("InOutGenRMA", AD_Process_ID);
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Add Selection parameter Selection=Y
		MPInstancePara ip = new MPInstancePara(instance, 10);
		ip.setParameter("Selection","Y");
		ip.saveEx();
		//	Add Document Action parameter
		ip = new MPInstancePara(instance, 20);
		ip.setParameter("DocAction", "CO");
		ip.saveEx();
		//	Add Warehouse parameter
		ip = new MPInstancePara(instance, 30);
		ip.setParameter("M_Warehouse_ID", getM_Warehouse_ID());
		ip.saveEx();
		//	Add Movement Date parameter
		ip = new MPInstancePara(instance, 40);
		ip.setParameter("MovementDate", date2);
		ip.saveEx();
		
		ServerProcessCtl processCtl = new ServerProcessCtl(pi, getTrx());
		processCtl.setManagedTrxForJavaProcess(false);
		processCtl.run();
		
		assertFalse(pi.isError(), pi.getSummary());
		
		rmaLine.load(getTrxName());
		assertEquals(rmaLine.getQty().intValue(), rmaLine.getQtyDelivered().intValue(), "RMA Line QtyDelivered not updated by shipment for Vendor RMA");
		
		int M_InOut_ID = DB.getSQLValueEx(getTrxName(), "SELECT M_InOut_ID FROM M_InOut WHERE M_RMA_ID=?", rma.getM_RMA_ID());
		MInOut vendorReturn = new MInOut(Env.getCtx(), M_InOut_ID, getTrxName());
		assertEquals(date2, vendorReturn.getMovementDate());
		assertEquals(date2, vendorReturn.getDateAcct());
	}
	
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-6025
	 * PO Qty=12
	 * MR Qty=10
	 * INV Qty=12
	 * CM Qty=2 (should be displayed on Purchase Credit Memo > Create Lines From info window)
	 */
	@Test
	public void testDeferredMatchedPOCreditQty() {
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

		MOrderLine line = new MOrderLine(order);
		line.setLine(10);
		line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.WEEDER.id));
		line.setQty(new BigDecimal("12"));
		line.setDatePromised(today);
		line.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(line, 0, new BigDecimal("10"));
		receiptLine.setQty(new BigDecimal("10"));
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());

		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(line);
		invoiceLine.setQty(new BigDecimal("12"));
		invoiceLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(trxName);
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MInvoice creditMemo = new MInvoice(order, DictionaryIDs.C_DocType.AP_CREDIT_MEMO.id, order.getDateOrdered());
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInfoWindow infoWindow = MInfoWindow.get(200024, trxName);	// Create lines from Invoice
		String tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
		String sql = "SELECT C_OrderLine_ID, CreditQty, Qty FROM " + tableName + " WHERE C_Order_ID=? ";
		List<Object> data = DB.getSQLValueObjectsEx(trxName, sql, order.getC_Order_ID());
		assertEquals(data.size(), 3);
		int C_OrderLine_ID = ((BigDecimal) data.get(0)).intValue();
		BigDecimal CreditQty = (BigDecimal) data.get(1);
		BigDecimal Qty = (BigDecimal) data.get(2);
		CreditQty = CreditQty.setScale(0);
		Qty = Qty.setScale(0);
		assertEquals(line.getC_OrderLine_ID(), C_OrderLine_ID);
		assertEquals(new BigDecimal("2"), CreditQty);
		assertEquals(new BigDecimal("0"), Qty);

		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setOrderLine(line);
		creditMemoLine.setQty(CreditQty);
		creditMemoLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		creditMemo.load(trxName);
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
	}
	
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-6025
	 * PO Qty=3
	 * INV Qty=3
	 * CM Qty=3 (should be displayed on Purchase Credit Memo > Create Lines From info window)
	 */
	@Test
	public void testDeferredMatchedPOCreditQtyNoMR() {
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

		MOrderLine line = new MOrderLine(order);
		line.setLine(10);
		line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.WEEDER.id));
		line.setQty(new BigDecimal("3"));
		line.setDatePromised(today);
		line.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(line);
		invoiceLine.setQty(new BigDecimal("3"));
		invoiceLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(trxName);
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MInvoice creditMemo = new MInvoice(order, DictionaryIDs.C_DocType.AP_CREDIT_MEMO.id, order.getDateOrdered());
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInfoWindow infoWindow = MInfoWindow.get(200024, trxName);	// Create lines from Invoice
		String tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
		String sql = "SELECT C_OrderLine_ID, CreditQty, Qty FROM " + tableName + " WHERE C_Order_ID=? ";
		List<Object> data = DB.getSQLValueObjectsEx(trxName, sql, order.getC_Order_ID());
		assertEquals(data.size(), 3);
		int C_OrderLine_ID = ((BigDecimal) data.get(0)).intValue();
		BigDecimal CreditQty = (BigDecimal) data.get(1);
		BigDecimal Qty = (BigDecimal) data.get(2);
		CreditQty = CreditQty.setScale(0);
		Qty = Qty.setScale(0);
		assertEquals(line.getC_OrderLine_ID(), C_OrderLine_ID);
		assertEquals(new BigDecimal("3"), CreditQty);
		assertEquals(new BigDecimal("0"), Qty);

		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setOrderLine(line);
		creditMemoLine.setQty(CreditQty);
		creditMemoLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		creditMemo.load(trxName);
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
	}
	
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-6025
	 * PO Qty=1800
	 * INV Qty=1800
	 * MR-1 Qty=1763
	 * MR-2 Qty=30
	 * CM Qty=7 (should be displayed on Purchase Credit Memo > Create Lines From info window)
	 */
	@Test
	public void testDeferredMatchedPOCreditQtyMultiMR_1() {
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

		MOrderLine line = new MOrderLine(order);
		line.setLine(10);
		line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.WEEDER.id));
		line.setQty(new BigDecimal("1800"));
		line.setDatePromised(today);
		line.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(line);
		invoiceLine.setQty(new BigDecimal("1800"));
		invoiceLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(trxName);
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());

		MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt1.setDocStatus(DocAction.STATUS_Drafted);
		receipt1.setDocAction(DocAction.ACTION_Complete);
		receipt1.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt1);
		receiptLine1.setOrderLine(line, 0, new BigDecimal("1763"));
		receiptLine1.setQty(new BigDecimal("1763"));
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt1.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());

		MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt2.setDocStatus(DocAction.STATUS_Drafted);
		receipt2.setDocAction(DocAction.ACTION_Complete);
		receipt2.saveEx();

		MInOutLine receiptLine2 = new MInOutLine(receipt2);
		receiptLine2.setOrderLine(line, 0, new BigDecimal("30"));
		receiptLine2.setQty(new BigDecimal("30"));
		receiptLine2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt2.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
		
		MInvoice creditMemo = new MInvoice(order, DictionaryIDs.C_DocType.AP_CREDIT_MEMO.id, order.getDateOrdered());
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInfoWindow infoWindow = MInfoWindow.get(200024, trxName);	// Create lines from Invoice
		String tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
		String sql = "SELECT C_OrderLine_ID, CreditQty, Qty FROM " + tableName + " WHERE C_Order_ID=? ";
		List<Object> data = DB.getSQLValueObjectsEx(trxName, sql, order.getC_Order_ID());
		assertEquals(data.size(), 3);
		int C_OrderLine_ID = ((BigDecimal) data.get(0)).intValue();
		BigDecimal CreditQty = (BigDecimal) data.get(1);
		BigDecimal Qty = (BigDecimal) data.get(2);
		CreditQty = CreditQty.setScale(0);
		Qty = Qty.setScale(0);
		assertEquals(line.getC_OrderLine_ID(), C_OrderLine_ID);
		assertEquals(new BigDecimal("7"), CreditQty);
		assertEquals(new BigDecimal("0"), Qty);

		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setOrderLine(line);
		creditMemoLine.setQty(CreditQty);
		creditMemoLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		creditMemo.load(trxName);
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
	}
	
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-6025
	 * PO Qty=1800
	 * MR-1 Qty=1763
	 * MR-2 Qty=30
	 * INV Qty=1800
	 * CM Qty=7 (should be displayed on Purchase Credit Memo > Create Lines From info window)
	 */
	@Test
	public void testDeferredMatchedPOCreditQtyMultiMR_2() {
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

		MOrderLine line = new MOrderLine(order);
		line.setLine(10);
		line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.WEEDER.id));
		line.setQty(new BigDecimal("1800"));
		line.setDatePromised(today);
		line.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt1.setDocStatus(DocAction.STATUS_Drafted);
		receipt1.setDocAction(DocAction.ACTION_Complete);
		receipt1.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt1);
		receiptLine1.setOrderLine(line, 0, new BigDecimal("1763"));
		receiptLine1.setQty(new BigDecimal("1763"));
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt1.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());

		MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt2.setDocStatus(DocAction.STATUS_Drafted);
		receipt2.setDocAction(DocAction.ACTION_Complete);
		receipt2.saveEx();

		MInOutLine receiptLine2 = new MInOutLine(receipt2);
		receiptLine2.setOrderLine(line, 0, new BigDecimal("30"));
		receiptLine2.setQty(new BigDecimal("30"));
		receiptLine2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt2.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
		
		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(line);
		invoiceLine.setQty(new BigDecimal("1800"));
		invoiceLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(trxName);
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());

		MInvoice creditMemo = new MInvoice(order, DictionaryIDs.C_DocType.AP_CREDIT_MEMO.id, order.getDateOrdered());
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInfoWindow infoWindow = MInfoWindow.get(200024, trxName);	// Create lines from Invoice
		String tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
		String sql = "SELECT C_OrderLine_ID, CreditQty, Qty FROM " + tableName + " WHERE C_Order_ID=? ";
		List<Object> data = DB.getSQLValueObjectsEx(trxName, sql, order.getC_Order_ID());
		assertEquals(data.size(), 3);
		int C_OrderLine_ID = ((BigDecimal) data.get(0)).intValue();
		BigDecimal CreditQty = (BigDecimal) data.get(1);
		BigDecimal Qty = (BigDecimal) data.get(2);
		CreditQty = CreditQty.setScale(0);
		Qty = Qty.setScale(0);
		assertEquals(line.getC_OrderLine_ID(), C_OrderLine_ID);
		assertEquals(new BigDecimal("7"), CreditQty);
		assertEquals(new BigDecimal("0"), Qty);

		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setOrderLine(line);
		creditMemoLine.setQty(CreditQty);
		creditMemoLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		creditMemo.load(trxName);
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
	}
	
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-6025
	 * PO Line-1 Qty=3, Line-2 Qty=3
	 * MR Line-1 Qty=3, Line-2 Qty=2
	 * INV Line-1 Qty=3, Line-2 Qty=2
	 * CM Line-2 Qty=1 (Line-1 should not be displayed. Line-2 should be displayed on Purchase Credit Memo > Create Lines From info window) 
	 */
	@Test
	public void testDeferredMatchedPOCreditQtyMultiLine() {
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
		line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.ELM.id));
		line1.setQty(new BigDecimal("3"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		MOrderLine line2 = new MOrderLine(order);
		line2.setLine(20);
		line2.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.OAK.id));
		line2.setQty(new BigDecimal("3"));
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
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("3"));
		receiptLine1.setQty(new BigDecimal("3"));
		receiptLine1.saveEx();
		
		MInOutLine receiptLine2 = new MInOutLine(receipt);
		receiptLine2.setOrderLine(line2, 0, new BigDecimal("2"));
		receiptLine2.setQty(new BigDecimal("2"));
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
		invoiceLine1.setQty(new BigDecimal("3"));
		invoiceLine1.saveEx();
		
		MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice);
		invoiceLine2.setOrderLine(line2);
		invoiceLine2.setQty(new BigDecimal("3"));
		invoiceLine2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(trxName);
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());

		MInvoice creditMemo = new MInvoice(order, DictionaryIDs.C_DocType.AP_CREDIT_MEMO.id, order.getDateOrdered());
		creditMemo.setDocStatus(DocAction.STATUS_Drafted);
		creditMemo.setDocAction(DocAction.ACTION_Complete);
		creditMemo.saveEx();
		
		MInfoWindow infoWindow = MInfoWindow.get(200024, trxName);	// Create lines from Invoice
		String tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
		String sql = "SELECT CreditQty, Qty FROM " + tableName + " WHERE C_Order_ID=? AND C_OrderLine_ID=?";
		List<Object> data = DB.getSQLValueObjectsEx(trxName, sql, order.getC_Order_ID(), line1.getC_OrderLine_ID());
		assertTrue(data == null);	// fully invoiced, should not appear in the create lines from info window
		data = DB.getSQLValueObjectsEx(trxName, sql, order.getC_Order_ID(), line2.getC_OrderLine_ID());
		assertEquals(data.size(), 2);
		BigDecimal CreditQty = (BigDecimal) data.get(0);
		BigDecimal Qty = (BigDecimal) data.get(1);
		CreditQty = CreditQty.setScale(0);
		Qty = Qty.setScale(0);
		assertEquals(new BigDecimal("1"), CreditQty);
		assertEquals(new BigDecimal("0"), Qty);

		MInvoiceLine creditMemoLine = new MInvoiceLine(creditMemo);
		creditMemoLine.setOrderLine(line2);
		creditMemoLine.setQty(CreditQty);
		creditMemoLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(creditMemo, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		creditMemo.load(trxName);
		assertEquals(DocAction.STATUS_Completed, creditMemo.getDocStatus());
	}
}
