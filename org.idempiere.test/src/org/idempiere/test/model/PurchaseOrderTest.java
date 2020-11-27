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
 * @author Carlos Ruiz - globalqss
 */
public class PurchaseOrderTest extends AbstractTestCase {

	public PurchaseOrderTest() {
	}

	private static final int BP_PATIO = 121;
	private static final int DOCTYPE_PO = 126;
	private static final int DOCTYPE_RECEIPT = 122;
	private static final int PRODUCT_SEEDER = 143;
	private static final int USER_GARDENADMIN = 101;

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

}
