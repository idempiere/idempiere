package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Properties;

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
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductPrice;
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
import org.mockito.MockedStatic;

/**
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

	@Test
	public void testFIFO() {
		MProductCategory category = createProductCategory();
		MProduct product = createProduct(category.get_ID());

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MProductCategory> categoryMock = mockStatic(MProductCategory.class)) {

			mockProductGet(productMock, product);
			mockCategoryGet(categoryMock, category);
			createPurchasePrice(product);

			MAcctSchema as = getAccountingSchema();
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

			/*
			 * First purchase (2 days ago)
			 *
			 * 100 units @ 10.00
			 */
			createPurchaseForProduct(product, QTY_100, COST_10, TimeUtil.addDays(today, -2));

			MCost cost = product.getCostingRecord(
					as,
					getAD_Org_ID(),
					0,
					MCostElement.COSTINGMETHOD_Fifo);

			assertEquals(
					QTY_100.setScale(2, RoundingMode.HALF_UP),
					cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP),
					"Unexpected quantity after first receipt");

			/*
			 * Second purchase (yesterday)
			 *
			 * 100 units @ 20.00
			 */
			createPurchaseForProduct(product, QTY_100, COST_20, TimeUtil.addDays(today, -1));

			cost.load(getTrxName());

			assertEquals(
					new BigDecimal("200.00"),
					cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP),
					"Unexpected quantity after second receipt");

			/*
			 * FIFO should now have one layer per account date:
			 *
			 * 100 @ 10.00
			 * 100 @ 20.00
			 */
			MCostQueue[] queue = MCostQueue.getQueue(product, 0, as, 0, MCostElement.get(cost.getM_CostElement_ID()), getTrxName());
			assertEquals(2, queue.length, "Unexpected number of cost layers");
			assertEquals(COST_10.setScale(2, RoundingMode.HALF_UP),
					queue[0].getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected cost of oldest layer");
			assertEquals(COST_20.setScale(2, RoundingMode.HALF_UP),
					queue[1].getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected cost of newest layer");

			/*
			 * Shipment of 150 units.
			 *
			 * FIFO should consume:
			 *
			 * 100 @ 10.00
			 *  50 @ 20.00
			 *
			 * Remaining:
			 *
			 * 50 @ 20.00
			 */
			createSOAndShipmentForProduct(
					product,
					QTY_150);

			cost.load(getTrxName());

			assertEquals(
					new BigDecimal("50.00"),
					cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP),
					"Unexpected quantity after shipment");

			assertEquals(
					COST_20.setScale(2, RoundingMode.HALF_UP),
					cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP),
					"Unexpected current cost price");
		}
	}

	@Test
	public void testFIFOSameAccountDate() {
		MProductCategory category = createProductCategory();
		MProduct product = createProduct(category.get_ID());

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MProductCategory> categoryMock = mockStatic(MProductCategory.class)) {

			mockProductGet(productMock, product);
			mockCategoryGet(categoryMock, category);
			createPurchasePrice(product);

			MAcctSchema as = getAccountingSchema();
			Timestamp yesterday = TimeUtil.addDays(TimeUtil.getDay(System.currentTimeMillis()), -1);

			/*
			 * Two purchases with the same account date share the same cost layer:
			 *
			 * 100 @ 10.00 + 100 @ 20.00 = 200 @ 15.00
			 */
			createPurchaseForProduct(product, QTY_100, COST_10, yesterday);
			createPurchaseForProduct(product, QTY_100, COST_20, yesterday);

			MCost cost = product.getCostingRecord(
					as,
					getAD_Org_ID(),
					0,
					MCostElement.COSTINGMETHOD_Fifo);

			MCostQueue[] queue = MCostQueue.getQueue(product, 0, as, 0, MCostElement.get(cost.getM_CostElement_ID()), getTrxName());
			assertEquals(1, queue.length, "Unexpected number of cost layers");
			assertEquals(new BigDecimal("200.00"),
					queue[0].getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected layer quantity");
			assertEquals(new BigDecimal("15.00"),
					queue[0].getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected layer cost");
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
	private void createPurchaseForProduct(MProduct product, BigDecimal qty, BigDecimal price, Timestamp date) {
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
	}

	private MProduct createProduct(int category_ID) {
		MProduct product = new MProduct(
				Env.getCtx(),
				0,
				getTrxName());

		product.setName("testFIFO");
		product.setValue("testFIFO");
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

	private MProductCategory createProductCategory() {
		MProductCategory category = new MProductCategory(
				Env.getCtx(),
				0,
				getTrxName());

		category.setName("FIFO Costing");
		category.saveEx();

		return category;
	}

	private MAcctSchema getAccountingSchema() {
		MClient client = MClient.get(Env.getCtx());
		return client.getAcctSchema();
	}

	private void mockProductGet(
			MockedStatic<MProduct> productMock,
			MProduct product) {

		productMock.when(() ->
				MProduct.getCopy(
						any(Properties.class),
						eq(product.get_ID()),
						any()))
			.thenReturn(product);

		productMock.when(() ->
				MProduct.get(
						any(Properties.class),
						eq(product.get_ID()),
						any()))
			.thenReturn(product);

		productMock.when(() ->
				MProduct.get(
						any(Properties.class),
						eq(product.get_ID())))
			.thenReturn(product);
	}

	private void mockCategoryGet(
			MockedStatic<MProductCategory> categoryMock,
			MProductCategory category) {

		categoryMock.when(() ->
				MProductCategory.get(eq(category.get_ID())))
			.thenReturn(category);

		categoryMock.when(() ->
				MProductCategory.get(
						any(Properties.class),
						eq(category.get_ID())))
			.thenReturn(category);
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