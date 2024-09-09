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
 * - Elaine Tan - etantg       								   		   *
 * - hengsin														   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
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
import org.compiere.model.MWarehouse;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.ConversionRateHelper;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.FactAcct;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * 
 * @author hengsin
 *
 */
@Isolated
public class MatchInvTestIsolated extends AbstractTestCase {

	public MatchInvTestIsolated() {
	}

	@Test
	/**
	 * Test Standard Cost and Invoice Price Variance posting
	 */
	public void testMatchInvStdCost() {
		MProductCategory category = new MProductCategory(Env.getCtx(), 0, null);
		category.setName("Standard Costing");
		category.saveEx();
		String whereClause = "M_Product_Category_ID=?";
		List<MProductCategoryAcct> categoryAccts = new Query(Env.getCtx(), MProductCategoryAcct.Table_Name, whereClause, null)
									.setParameters(category.get_ID())
									.list();
		for (MProductCategoryAcct categoryAcct : categoryAccts) {
			categoryAcct.setCostingMethod(MAcctSchema.COSTINGMETHOD_StandardCosting);
			categoryAcct.saveEx();
		}
		
		int mulchId = DictionaryIDs.M_Product.MULCH.id;  // Mulch product
		MProduct mulch = new MProduct(Env.getCtx(), mulchId, null);
		int mulchCategoryId = mulch.getM_Product_Category_ID();
		try {						
			mulch.setM_Product_Category_ID(category.get_ID());
			mulch.saveEx();
			
			int purchaseId = DictionaryIDs.M_PriceList.PURCHASE.id; // Purchase Price List
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id); // Seed Farm Inc.
			MAcctSchema as = MClient.get(getAD_Client_ID()).getAcctSchema();
			BigDecimal mulchCost = MCost.getCurrentCost(mulch, 0, getTrxName()).setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
			
			// Change standard cost of mulch product to 2.1234
			int hqLocator = DictionaryIDs.M_Locator.HQ.id;
			int costAdjustmentDocTypeId = DictionaryIDs.C_DocType.COST_ADJUSTMENT.id;
			MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory.setCostingMethod(MAcctSchema.COSTINGMETHOD_StandardCosting);
			inventory.setC_DocType_ID(costAdjustmentDocTypeId);
			inventory.setM_Warehouse_ID(getM_Warehouse_ID());
			inventory.setMovementDate(getLoginDate());
			inventory.setDocAction(DocAction.ACTION_Complete);
			inventory.saveEx();
			
			BigDecimal endProductCost = new BigDecimal("2.1234").setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
			MInventoryLine il = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			il.setM_Inventory_ID(inventory.get_ID());
			il.setM_Locator_ID(hqLocator);
			il.setM_Product_ID(mulch.getM_Product_ID());
			il.setCurrentCostPrice(mulchCost);
			il.setNewCostPrice(endProductCost);
			il.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			inventory.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Cost Adjustment Status="+inventory.getDocStatus());
			
			if (!inventory.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInventory.Table_ID, inventory.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			mulchCost = MCost.getCurrentCost(mulch, 0, getTrxName()).setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
			assertEquals(endProductCost, mulchCost, "Cost not adjusted: " + mulchCost.toPlainString());
			
			//test converted cost for all schemas
			MAcctSchema[] schemas = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
			for (int i = 0; i < schemas.length; i++) {
				BigDecimal expected = MConversionRate.convert (Env.getCtx(),
						mulchCost, as.getC_Currency_ID(), schemas[i].getC_Currency_ID(),
						inventory.getMovementDate(), 0, getAD_Client_ID(), getAD_Org_ID(), true);
				BigDecimal mulchCostConv = MCost.getCurrentCost(mulch, 0, schemas[i], schemas[i].getAD_Org_ID(), MAcctSchema.COSTINGMETHOD_StandardCosting,
						BigDecimal.ONE, 0, true, getTrxName()).setScale(schemas[i].getCostingPrecision(), RoundingMode.HALF_UP);
				assertEquals(expected, mulchCostConv, "Converted Cost for schema incorrect: " + schemas[i].toString()+ " - " + mulchCostConv.toPlainString());
			}
			
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setM_PriceList_ID(purchaseId);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(mulch);
			orderLine.setQty(BigDecimal.ONE);
			orderLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setC_OrderLine_ID(orderLine.get_ID());
			receiptLine.setLine(10);
			receiptLine.setProduct(mulch);
			receiptLine.setQty(BigDecimal.ONE);
			MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
			int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
			receiptLine.setM_Locator_ID(M_Locator_ID);
			receiptLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			receipt.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			receipt.load(getTrxName());
			assertTrue(receipt.isPosted());
			
			MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(mulch);
			invoiceLine.setQty(BigDecimal.ONE);
			invoiceLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
				doc.setC_BPartner_ID(mi.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				MAccount acctIPV = pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as);
				int C_AcctSchema_ID = as.getC_AcctSchema_ID();
				
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), C_AcctSchema_ID, getTrxName());
				List<MFactAcct> factAccts = query.list();
				BigDecimal invMatchAmt = invoiceLine.getMatchedQty().multiply(invoiceLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
				mulchCost = mulchCost.setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, mulchCost, 2, true), new FactAcct(acctInvClr, invMatchAmt, 2, false),
						new FactAcct(acctIPV, invMatchAmt.subtract(mulchCost), 2, true));
				assertFactAcctEntries(factAccts, expected);
			}
		} finally {
			getTrx().rollback();
			mulch.setM_Product_Category_ID(mulchCategoryId);
			mulch.saveEx();
			category.deleteEx(true);
		}
	}
		
	/**
	 * Test Average PO Cost and Invoice Price Variance posting
	 */
	@Test
	public void testAverageCostingIPV() {
		MProduct product = null;
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try {						
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testAverageCostingIPV");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			BigDecimal orderPrice = new BigDecimal("2.00");
			pp.setPriceStd(orderPrice);
			pp.setPriceList(orderPrice);
			pp.saveEx();
			
			int purchaseId = DictionaryIDs.M_PriceList.PURCHASE.id; // Purchase Price List
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id);
			
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setM_PriceList_ID(purchaseId);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(BigDecimal.TEN);
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setC_OrderLine_ID(orderLine.get_ID());
			receiptLine.setLine(10);
			receiptLine.setProduct(product);
			receiptLine.setQty(BigDecimal.TEN);
			MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
			int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
			receiptLine.setM_Locator_ID(M_Locator_ID);
			receiptLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			receipt.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			receipt.load(getTrxName());
			assertTrue(receipt.isPosted());
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(orderPrice, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(BigDecimal.TEN);
			BigDecimal invoicePrice = new BigDecimal("2.50");
			invoiceLine.setPrice(invoicePrice);
			invoiceLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
				assertNotNull(cost, "No MCost record found");			
				assertEquals(invoicePrice, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
								
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				MAccount acctAsset = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
				MAccount  nirAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				int C_AcctSchema_ID = as.getC_AcctSchema_ID();
				
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), C_AcctSchema_ID, getTrxName());
				List<MFactAcct> factAccts = query.list();
				BigDecimal ipvAmt = invoicePrice.subtract(orderPrice).multiply(BigDecimal.TEN);
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctAsset, ipvAmt, 2, true), 
						new FactAcct(nirAccount, orderPrice.multiply(BigDecimal.TEN), 2, true),
						new FactAcct(acctInvClr, invoicePrice.multiply(BigDecimal.TEN), 2, false));
				assertFactAcctEntries(factAccts, expected);
			}
		} finally {
			rollback();
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
		}
	}
	
	/**
	 * Test Average PO Cost and Invoice Price Variance posting (after customer shipment)
	 */
	@Test
	public void testAverageCostingIPVAfterShipment() {
		MProduct product = null;
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
		List<MAcctSchema> allowNegatives = new ArrayList<MAcctSchema>();
		Arrays.stream(ass).forEach(e -> {
			MAcctSchema copy = MAcctSchema.getCopy(Env.getCtx(), e.getC_AcctSchema_ID(), null);
			if (copy.isAllowNegativePosting())
			{
				copy.setIsAllowNegativePosting(false);
				copy.saveEx();
				allowNegatives.add(copy);
			}
		});
		if (allowNegatives.size() > 0)
			CacheMgt.get().reset(MAcctSchema.Table_Name);
		ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
					
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); 
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); 
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.SPOT.id; 
		Timestamp today = TimeUtil.getDay(null);		
		Timestamp tomorrow = TimeUtil.addDays(today, 1);
		MConversionRate cr1 = ConversionRateHelper.createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, today, new BigDecimal("0.91"), true);	
		MConversionRate cr2 = ConversionRateHelper.createConversionRate(usd.getC_Currency_ID(), euro.getC_Currency_ID(), C_ConversionType_ID, tomorrow, new BigDecimal("0.85"), true);
		try {						
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testAverageCostingIPVAfterShipment");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			BigDecimal orderPrice = new BigDecimal("2.00");
			pp.setPriceStd(orderPrice);
			pp.setPriceList(orderPrice);
			pp.saveEx();
			
			//PO and MR
			int purchaseId = DictionaryIDs.M_PriceList.PURCHASE.id; // Purchase Price List
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id);
			
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setM_PriceList_ID(purchaseId);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(BigDecimal.TEN);
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setC_OrderLine_ID(orderLine.get_ID());
			receiptLine.setLine(10);
			receiptLine.setProduct(product);
			receiptLine.setQty(BigDecimal.TEN);
			MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
			int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
			receiptLine.setM_Locator_ID(M_Locator_ID);
			receiptLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			receipt.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			receipt.load(getTrxName());
			assertTrue(receipt.isPosted());
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(orderPrice, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			//customer shipment
			MOrder salesOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			salesOrder.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			salesOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			salesOrder.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder.setDocAction(DocAction.ACTION_Complete);
			salesOrder.setDatePromised(today);
			salesOrder.saveEx();
			
			BigDecimal salesQty = new BigDecimal("5");
			MOrderLine salesLine1 = new MOrderLine(salesOrder);
			salesLine1.setLine(10);
			salesLine1.setProduct(product);
			salesLine1.setQty(salesQty);
			salesLine1.setDatePromised(today);
			salesLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(salesOrder, DocAction.ACTION_Complete);
			salesOrder.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder.getDocStatus(), "Unexpected Document Status");
			
			MInOut shipment = new MInOut(salesOrder, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setOrderLine(salesLine1, 0, salesQty);
			shipmentLine.setQty(salesQty);
			shipmentLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected Document Status");
			
			//MR invoice
			MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(BigDecimal.TEN);
			BigDecimal invoicePrice = new BigDecimal("2.50");
			invoiceLine.setPrice(invoicePrice);
			invoiceLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
				assertNotNull(cost, "No MCost record found");			
				assertEquals(invoicePrice, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
								
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				MAccount acctAsset = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				MAccount varianceAccount = pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
				Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
				MAccount  nirAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				int C_AcctSchema_ID = as.getC_AcctSchema_ID();
				
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), C_AcctSchema_ID, getTrxName());
				List<MFactAcct> factAccts = query.list();
				BigDecimal stockBalance = BigDecimal.TEN.subtract(salesQty);
				BigDecimal assetAmt = invoicePrice.subtract(orderPrice).multiply(stockBalance);
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctAsset, assetAmt, 2, true), 
						new FactAcct(varianceAccount, invoicePrice.subtract(orderPrice).multiply(BigDecimal.TEN.subtract(stockBalance)), 2, true),
						new FactAcct(nirAccount, orderPrice.multiply(BigDecimal.TEN), 2, true),
						new FactAcct(acctInvClr, invoicePrice.multiply(BigDecimal.TEN), 2, false));
				assertFactAcctEntries(factAccts, expected);
			}
			
			//test reversal posting
			Env.setContext(Env.getCtx(), Env.DATE, tomorrow);
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Reverse_Accrual);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, invoice.getDocStatus());
			assertTrue(invoice.getReversal_ID() > 0, "No reversal invoice id");
			
			MInvoice reversalInvoice = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), getTrxName());
			assertEquals(invoice.getReversal_ID(), reversalInvoice.get_ID(), "Failed to load reversal invoice");			
			if (!reversalInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), reversalInvoice.getAD_Client_ID(), MInvoice.Table_ID, reversalInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			reversalInvoice.load(getTrxName());
			assertTrue(reversalInvoice.isPosted());
			
			for (MMatchInv mi : miList) {
				mi.load(getTrxName());
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.getReversal_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> rFactAccts = query.list();
				ArrayList<FactAcct> expected = new ArrayList<FactAcct>();
				for(MFactAcct factAcct : factAccts) {
					MAccount acct = MAccount.get(factAcct, getTrxName());
					if (factAcct.getAmtAcctDr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 2, false));
					} else if (factAcct.getAmtAcctCr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 2, true));
					}
				}
				assertFactAcctEntries(rFactAccts, expected);

				Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
				if (optional.isPresent()) {
					MAcctSchema as2 = optional.get();
					query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as2.get_ID(), getTrxName());
					factAccts = query.list();
					query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.getReversal_ID(), as2.get_ID(), getTrxName());
					rFactAccts = query.list();
					expected = new ArrayList<FactAcct>();
					for(MFactAcct factAcct : factAccts) {
						MAccount acct = MAccount.get(factAcct, getTrxName());
						if (factAcct.getAmtAcctDr().signum() != 0) {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 2, false));
						} else if (factAcct.getAmtAcctCr().signum() != 0) {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 2, true));
						}
					}
					assertFactAcctEntries(rFactAccts, expected);
				}
			}
			
			//assert reversal invoice posting
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.getReversal_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
			ArrayList<FactAcct> expected = new ArrayList<FactAcct>();
			for(MFactAcct factAcct : factAccts) {
				MAccount acct = MAccount.get(factAcct, getTrxName());
				if (factAcct.getAmtAcctDr().signum() != 0) {
					expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 2, false));
				} else if (factAcct.getAmtAcctCr().signum() != 0) {
					expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 2, true));
				}
			}
			assertFactAcctEntries(rFactAccts, expected);

			Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
			if (optional.isPresent()) {
				MAcctSchema as2 = optional.get();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.get_ID(), as2.get_ID(), getTrxName());
				factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.getReversal_ID(), as2.get_ID(), getTrxName());
				rFactAccts = query.list();
				expected = new ArrayList<FactAcct>();
				for(MFactAcct factAcct : factAccts) {
					MAccount acct = MAccount.get(factAcct, getTrxName());
					if (factAcct.getAmtAcctDr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 2, false));
					} else if (factAcct.getAmtAcctCr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 2, true));
					}
				}
				assertFactAcctEntries(rFactAccts, expected);
			}
		} finally {
			rollback();
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
			ConversionRateHelper.deleteConversionRate(cr1);
			ConversionRateHelper.deleteConversionRate(cr2);
			
			if (allowNegatives.size() > 0) {
				allowNegatives.forEach(e -> {
					e.setIsAllowNegativePosting(true);
					e.saveEx();
				});
			}
				
		}
	}
	
	/**
	 * Test Average PO Cost and Invoice Price Variance posting for partial MR
	 */
	@Test
	public void testAverageCostingIPVPartialMR() {
		MProduct product = null;
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try {						
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testAverageCostingIPVPartialMR");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			BigDecimal orderPrice = new BigDecimal("2.00");
			pp.setPriceStd(orderPrice);
			pp.setPriceList(orderPrice);
			pp.saveEx();
			
			int purchaseId = DictionaryIDs.M_PriceList.PURCHASE.id; // Purchase Price List
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id);
			
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setM_PriceList_ID(purchaseId);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(BigDecimal.TEN);
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			//partial MR
			MInOut receipt = new MInOut(order, 122, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
			
			BigDecimal mrQty = new BigDecimal("5");
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setC_OrderLine_ID(orderLine.get_ID());
			receiptLine.setLine(10);
			receiptLine.setProduct(product);
			receiptLine.setQty(mrQty);
			MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
			int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
			receiptLine.setM_Locator_ID(M_Locator_ID);
			receiptLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			receipt.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), MInOut.Table_ID, receipt.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			receipt.load(getTrxName());
			assertTrue(receipt.isPosted());
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(orderPrice, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			//ap invoce, full
			MInvoice invoice = new MInvoice(receipt, receipt.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(BigDecimal.TEN);
			BigDecimal invoicePrice = new BigDecimal("4.00");
			invoiceLine.setPrice(invoicePrice);
			invoiceLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
				assertNotNull(cost, "No MCost record found");			
				assertEquals(invoicePrice, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
								
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				MAccount acctAsset = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
				MAccount  nirAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				int C_AcctSchema_ID = as.getC_AcctSchema_ID();
				
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), C_AcctSchema_ID, getTrxName());
				List<MFactAcct> factAccts = query.list();
				BigDecimal assetAmt = invoicePrice.subtract(orderPrice).multiply(mrQty);
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctAsset, assetAmt, 2, true), 
						new FactAcct(nirAccount, orderPrice.multiply(mrQty), 2, true),
						new FactAcct(acctInvClr, invoicePrice.multiply(mrQty), 2, false));
				assertFactAcctEntries(factAccts, expected);
			}
		} finally {
			rollback();
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
		}
	}
}
