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
 **********************************************************************/
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.List;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MCostQueue;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductPrice;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * IDEMPIERE-7102 - Fifo cost layers for products without attribute set instance.<br/>
 * The product category (with Fifo costing method in its accounting) and the product are created without transaction,
 * so that they are visible to the costing and document api, and deleted at the end of each test.
 * @author vitor_santos
 */
@Isolated
public class FIFOCostingTest extends AbstractTestCase {

	private static final BigDecimal QTY_100 = new BigDecimal("100");
	private static final BigDecimal QTY_150 = new BigDecimal("150");
	private static final BigDecimal COST_10 = new BigDecimal("10.00");
	private static final BigDecimal COST_20 = new BigDecimal("20.00");

	public FIFOCostingTest() {
	}

	/**
	 * MR+Invoice 100 @ 10.00 (2 days ago), MR+Invoice 100 @ 20.00 (yesterday): 2 cost layers.<br/>
	 * Shipment 150: consumes 100 @ 10.00 and 50 @ 20.00, remaining 50 @ 20.00.
	 */
	@Test
	public void testFIFOWithoutAttributeSetPreservesSeparateCostLayers() {
		MProductCategory category = createFIFOProductCategory();
		MProduct product = null;
		try {
			product = createProduct(category.get_ID());
			createPurchasePrice(product);

			MAcctSchema as = getAccountingSchema();
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

			createPurchaseForProduct(product, QTY_100, COST_10, TimeUtil.addDays(today, -2));

			MCost cost = getFIFOCost(product, as);
			assertEquals(new BigDecimal("100.00"), scale(cost.getCurrentQty()), "Unexpected quantity after first receipt");

			createPurchaseForProduct(product, QTY_100, COST_20, TimeUtil.addDays(today, -1));

			cost.load(getTrxName());
			assertEquals(new BigDecimal("200.00"), scale(cost.getCurrentQty()), "Unexpected quantity after second receipt");

			MCostQueue[] queue = getQueue(product, as, cost);
			assertEquals(2, queue.length, "Unexpected number of cost layers");
			assertLayer(queue[0], QTY_100, COST_10, "oldest");
			assertLayer(queue[1], QTY_100, COST_20, "newest");

			createSOAndShipmentForProduct(product, QTY_150);

			cost.load(getTrxName());
			assertEquals(new BigDecimal("50.00"), scale(cost.getCurrentQty()), "Unexpected quantity after shipment");
			assertEquals(scale(COST_20), scale(cost.getCurrentCostPrice()), "Unexpected current cost price");

			queue = getQueue(product, as, cost);
			assertEquals(1, queue.length, "Unexpected number of cost layers after shipment");
			assertLayer(queue[0], new BigDecimal("50"), COST_20, "remaining");
		} finally {
			rollback();
			deleteProduct(product);
			deleteProductCategory(category);
		}
	}

	/**
	 * Two purchases with the same account date share the same cost layer: 100 @ 10.00 + 100 @ 20.00 = 200 @ 15.00
	 */
	@Test
	public void testFIFOSameAccountDate() {
		MProductCategory category = createFIFOProductCategory();
		MProduct product = null;
		try {
			product = createProduct(category.get_ID());
			createPurchasePrice(product);

			MAcctSchema as = getAccountingSchema();
			Timestamp yesterday = TimeUtil.addDays(TimeUtil.getDay(System.currentTimeMillis()), -1);

			createPurchaseForProduct(product, QTY_100, COST_10, yesterday);
			createPurchaseForProduct(product, QTY_100, COST_20, yesterday);

			MCostQueue[] queue = getQueue(product, as, getFIFOCost(product, as));
			assertEquals(1, queue.length, "Unexpected number of cost layers");
			assertLayer(queue[0], new BigDecimal("200"), new BigDecimal("15.00"), "shared");
		} finally {
			rollback();
			deleteProduct(product);
			deleteProductCategory(category);
		}
	}

	/**
	 * MR+Invoice 100 @ 10.00 (2 days ago), MR+Invoice 100 @ 20.00 (yesterday).<br/>
	 * Reverse-Accrual of the first invoice (account date today, different from the cost layers):
	 * the reversal of the matched invoice must reduce the open cost layers in Fifo order and
	 * must not create a cost layer with negative quantity.
	 */
	@Test
	public void testFIFOInvoiceReverseAccrual() {
		MProductCategory category = createFIFOProductCategory();
		MProduct product = null;
		try {
			product = createProduct(category.get_ID());
			createPurchasePrice(product);

			MAcctSchema as = getAccountingSchema();
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

			MInvoice invoice1 = createPurchaseForProduct(product, QTY_100, COST_10, TimeUtil.addDays(today, -2));
			createPurchaseForProduct(product, QTY_100, COST_20, TimeUtil.addDays(today, -1));

			MCost cost = getFIFOCost(product, as);
			assertEquals(2, getQueue(product, as, cost).length, "Unexpected number of cost layers");

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice1, DocAction.ACTION_Reverse_Accrual);
			invoice1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, invoice1.getDocStatus());
			assertTrue(invoice1.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), invoice1.getReversal_ID(), getTrxName());
			if (!reversal.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			postMatchInv(invoice1);
			postMatchInv(reversal);

			assertNoNegativeLayer(product, as, cost);
			MCostQueue[] queue = getQueue(product, as, cost);
			assertEquals(1, queue.length, "Unexpected number of cost layers after invoice reversal");
			assertLayer(queue[0], QTY_100, COST_20, "remaining");
		} finally {
			rollback();
			deleteProduct(product);
			deleteProductCategory(category);
		}
	}

	/**
	 * MR+Invoice 100 @ 10.00 (2 days ago), MR+Invoice 100 @ 20.00 (yesterday).<br/>
	 * Reverse-Correct of the second invoice (same account date as its cost layer):
	 * the quantity and amount are removed from the cost layer of the account date, the oldest layer stays untouched.
	 */
	@Test
	public void testFIFOInvoiceReverseCorrect() {
		MProductCategory category = createFIFOProductCategory();
		MProduct product = null;
		try {
			product = createProduct(category.get_ID());
			createPurchasePrice(product);

			MAcctSchema as = getAccountingSchema();
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

			createPurchaseForProduct(product, QTY_100, COST_10, TimeUtil.addDays(today, -2));
			MInvoice invoice2 = createPurchaseForProduct(product, QTY_100, COST_20, TimeUtil.addDays(today, -1));

			MCost cost = getFIFOCost(product, as);

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice2, DocAction.ACTION_Reverse_Correct);
			invoice2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, invoice2.getDocStatus());
			MInvoice reversal = new MInvoice(Env.getCtx(), invoice2.getReversal_ID(), getTrxName());
			if (!reversal.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			postMatchInv(invoice2);
			postMatchInv(reversal);

			assertNoNegativeLayer(product, as, cost);
			MCostQueue[] queue = getQueue(product, as, cost);
			assertEquals(1, queue.length, "Unexpected number of cost layers after invoice reversal");
			assertLayer(queue[0], QTY_100, COST_10, "remaining");
		} finally {
			rollback();
			deleteProduct(product);
			deleteProductCategory(category);
		}
	}

	/**
	 * Create product category (without transaction) with Fifo costing method in its accounting
	 * @return product category
	 */
	private MProductCategory createFIFOProductCategory() {
		MProductCategory category = new MProductCategory(Env.getCtx(), 0, null);
		category.setName("FIFO Costing");
		category.saveEx();

		List<MProductCategoryAcct> categoryAccts = new Query(Env.getCtx(), MProductCategoryAcct.Table_Name, "M_Product_Category_ID=?", null)
				.setParameters(category.get_ID())
				.list();
		for (MProductCategoryAcct categoryAcct : categoryAccts) {
			categoryAcct.setCostingMethod(MAcctSchema.COSTINGMETHOD_Fifo);
			categoryAcct.saveEx();
		}
		return category;
	}

	private void deleteProduct(MProduct product) {
		if (product != null && product.get_ID() > 0) {
			MProduct p = new MProduct(Env.getCtx(), product.get_ID(), null);
			if (p.get_ID() > 0)
				p.deleteEx(true);
		}
	}


	private void deleteProductCategory(MProductCategory category) {
		if (category != null && category.get_ID() > 0) {
			category.load((String) null);
			category.deleteEx(true);
		}
	}

	private MCost getFIFOCost(MProduct product, MAcctSchema as) {
		// the product is created without transaction: read the cost record with the test transaction
		MProduct trxProduct = new MProduct(Env.getCtx(), product.get_ID(), getTrxName());
		assertEquals(MAcctSchema.COSTINGMETHOD_Fifo, trxProduct.getCostingMethod(as), "Unexpected costing method of the product");
		MCost cost = trxProduct.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_Fifo);
		assertNotNull(cost, "No Fifo cost record for the product");
		return cost;
	}

	private MCostQueue[] getQueue(MProduct product, MAcctSchema as, MCost cost) {
		return MCostQueue.getQueue(product, 0, as, 0, MCostElement.get(cost.getM_CostElement_ID()), getTrxName());
	}

	private void assertLayer(MCostQueue layer, BigDecimal qty, BigDecimal price, String name) {
		assertEquals(scale(qty), scale(layer.getCurrentQty()), "Unexpected quantity of " + name + " cost layer");
		assertEquals(scale(price), scale(layer.getCurrentCostPrice()), "Unexpected cost of " + name + " cost layer");
	}

	private void assertNoNegativeLayer(MProduct product, MAcctSchema as, MCost cost) {
		for (MCostQueue layer : getQueue(product, as, cost))
			assertTrue(layer.getCurrentQty().signum() >= 0, "Cost layer with negative quantity: " + layer);
	}

	private BigDecimal scale(BigDecimal value) {
		return value.setScale(2, RoundingMode.HALF_UP);
	}

	private void postMatchInv(MInvoice invoice) {
		for (MMatchInv mi : MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName())) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
		}
	}

	private void createPurchasePrice(MProduct product) {
		MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
		MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
		pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
		pp.setM_Product_ID(product.get_ID());
		pp.setPriceStd(new BigDecimal("2"));
		pp.setPriceList(new BigDecimal("2"));
		pp.saveEx();
	}

	/**
	 * Create PO, MR and matching invoice for the product
	 *
	 * @param product
	 * @param qty
	 * @param price
	 * @param date document and account date
	 */
	private MInvoice createPurchaseForProduct(MProduct product, BigDecimal qty, BigDecimal price, Timestamp date) {
		MInOutLine receiptLine = createPOAndMRForProduct(product, qty, price, date);

		MInvoice invoice = new MInvoice(receiptLine.getParent(), date);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MOrderLine oLine = new MOrderLine(receiptLine.getCtx(), receiptLine.getC_OrderLine_ID(), receiptLine.get_TrxName());
		MInvoiceLine iLine = new MInvoiceLine(invoice);
		iLine.setOrderLine(oLine);
		iLine.setLine(10);
		iLine.setProduct(new MProduct(Env.getCtx(), product, getTrxName()));
		iLine.setQty(qty);
		iLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		invoice.getDocsPostProcess().clear();
		postMatchInv(invoice);
		return invoice;
	}

	private MProduct createProduct(int category_ID) {
		// Without transaction: the costing and document api retrieve the product with MProduct.get (no trx)
		MProduct product = new MProduct(
				Env.getCtx(),
				0,
				null);

		product.setName("testFIFO");
		product.setValue("testFIFO-" + System.currentTimeMillis());
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setM_Product_Category_ID(category_ID);
		product.setC_TaxCategory_ID(
				DictionaryIDs.C_TaxCategory.STANDARD.id);

		product.saveEx();

		return product;
	}

	private MAcctSchema getAccountingSchema() {
		MClient client = MClient.get(Env.getCtx());
		return client.getAcctSchema();
	}

	/**
	 * Create PO And MR for the product
	 * 
	 * @param  product
	 * @param  date order and receipt date
	 * @return
	 */
	private MInOutLine createPOAndMRForProduct(MProduct product, BigDecimal qtd, BigDecimal price, Timestamp date)
	{
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDateOrdered(date);
		order.setDateAcct(date);
		order.setDatePromised(date);
		order.saveEx();

		MOrderLine oLine = new MOrderLine(order);
		oLine.setLine(10);
		oLine.setProduct(product);
		oLine.setQty(qtd);
		oLine.setDatePromised(date);
		oLine.setPrice(price);
		oLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine rLine = new MInOutLine(receipt);
		rLine.setOrderLine(oLine, 0, qtd);
		rLine.setQty(qtd);
		rLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		if (!receipt.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(),
											receipt.get_ID(), false, getTrxName());
			assertNull(error, error);
		}

		return rLine;
	}
	
	private MInOutLine createSOAndShipmentForProduct(MProduct product, BigDecimal qty) {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setIsSOTrx(true);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine oLine = new MOrderLine(order);
		oLine.setLine(10);
		oLine.setProduct(product);
		oLine.setQty(qty);
		oLine.setDatePromised(today);
		oLine.setPrice(new BigDecimal("30"));
		oLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();

		MInOutLine sLine = new MInOutLine(shipment);
		sLine.setOrderLine(oLine, 0, qty);
		sLine.setQty(qty);
		sLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		if (!shipment.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(),
					shipment.get_ID(), false, getTrxName());
			assertNull(error, error);
		}

		return sLine;
		
	}
	
}