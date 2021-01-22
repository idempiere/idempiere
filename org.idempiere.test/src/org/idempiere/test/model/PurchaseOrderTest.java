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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageReservation;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Carlos Ruiz - globalqss
 */
public class PurchaseOrderTest extends AbstractTestCase {

	public PurchaseOrderTest() {
	}

	private static final int BP_PATIO = 121;
	private static final int DOCTYPE_PO = 126;
	private static final int DOCTYPE_RECEIPT = 122;
	private static final int DOCTYPE_AP_INVOICE = 123;
	private static final int PRODUCT_SEEDER = 143;
	private static final int PRODUCT_WEEDER = 141;
	private static final int PRODUCT_MULCH = 137;
	private static final int USER_GARDENADMIN = 101;
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
		order.setBPartner(MBPartner.get(ctx, BP_PATIO));
		order.setC_DocTypeTarget_ID(DOCTYPE_PO);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(USER_GARDENADMIN);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, PRODUCT_SEEDER));
		line1.setQty(new BigDecimal("-1"));
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().intValue());

		MInOut receipt = new MInOut(order, DOCTYPE_RECEIPT, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		// negative receipt
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(line1, 0, new BigDecimal("-1"));
		receiptLine.setQty(new BigDecimal("-1"));
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError());
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
		order.setBPartner(MBPartner.get(ctx, BP_PATIO));
		order.setC_DocTypeTarget_ID(DOCTYPE_PO);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(USER_GARDENADMIN);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, PRODUCT_WEEDER));
		line1.setQty(new BigDecimal("10"));
		line1.setDatePromised(today);
		line1.saveEx();

		MOrderLine line2 = new MOrderLine(order);
		line2.setLine(20);
		line2.setProduct(MProduct.get(ctx, PRODUCT_SEEDER));
		line2.setQty(new BigDecimal("-1"));
		line2.setDatePromised(today);
		line2.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut receipt = new MInOut(order, DOCTYPE_RECEIPT, order.getDateOrdered());
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
		assertFalse(info.isError());
		receipt.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());

		MInvoice invoice = new MInvoice(order, DOCTYPE_AP_INVOICE, order.getDateOrdered());
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
		assertFalse(info.isError());
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

		BigDecimal qtyOrderedOriginal = getQtyOrdered(ctx, PRODUCT_MULCH, trxName);

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, BP_PATIO));
		order.setC_DocTypeTarget_ID(DOCTYPE_PO);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(USER_GARDENADMIN);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(ctx, PRODUCT_MULCH));
		line1.setQty(THREE);
		line1.setDatePromised(today);
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().compareTo(THREE));

		BigDecimal newQtyOrdered = getQtyOrdered(ctx, PRODUCT_MULCH, trxName);
		assertEquals(0, qtyOrderedOriginal.add(THREE).compareTo(newQtyOrdered));

		MInOut receipt1 = new MInOut(order, DOCTYPE_RECEIPT, order.getDateOrdered());
		receipt1.setDocStatus(DocAction.STATUS_Drafted);
		receipt1.setDocAction(DocAction.ACTION_Complete);
		receipt1.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt1);
		receiptLine1.setOrderLine(line1, 0, THREE);
		receiptLine1.setQty(THREE);
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		receipt1.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());

		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().compareTo(Env.ZERO));

		newQtyOrdered = getQtyOrdered(ctx, PRODUCT_MULCH, trxName);
		assertEquals(0, qtyOrderedOriginal.compareTo(newQtyOrdered));

		// reactivate the purchase order
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_ReActivate);
		assertFalse(info.isError());
		order.load(trxName);
		assertEquals(DocAction.STATUS_InProgress, order.getDocStatus());

		// change the line quantity to zero
		line1.load(trxName);
		line1.setQty(Env.ZERO);
		line1.saveEx();

		// complete the order again
		info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().compareTo(MINUS_THREE));

		newQtyOrdered = getQtyOrdered(ctx, PRODUCT_MULCH, trxName);
		assertEquals(0, qtyOrderedOriginal.add(MINUS_THREE).compareTo(newQtyOrdered));

		// create a new material receipt for the -3 reversed
		MInOut receipt2 = new MInOut(order, DOCTYPE_RECEIPT, order.getDateOrdered());
		receipt2.setDocStatus(DocAction.STATUS_Drafted);
		receipt2.setDocAction(DocAction.ACTION_Complete);
		receipt2.saveEx();

		MInOutLine receiptLine2 = new MInOutLine(receipt2);
		receiptLine2.setOrderLine(line1, 0, MINUS_THREE);
		receiptLine2.setQty(MINUS_THREE);
		receiptLine2.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		receipt2.load(trxName);
		assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());

		line1.load(trxName);
		assertEquals(0, line1.getQtyReserved().compareTo(Env.ZERO));

		newQtyOrdered = getQtyOrdered(ctx, PRODUCT_MULCH, trxName);
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

}
