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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.adempiere.base.Core;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClientInfo;
import org.compiere.model.MCost;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MTax;
import org.compiere.model.MTaxCategory;
import org.compiere.model.MWarehouse;
import org.compiere.model.ProductCost;
import org.compiere.model.Tax;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MTaxTest extends AbstractTestCase {

	public MTaxTest() {
	}

	@Test
	public void testClearParentTaxId() {
		MTax tax = new MTax(Env.getCtx(), 0, getTrxName());
		tax.setName("testClearParentTaxId");
		tax.setParent_Tax_ID(DictionaryIDs.C_Tax.STANDARD.id);
		tax.setValidFrom(TimeUtil.getDay(null));
		tax.setIsSummary(false);
		tax.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		tax.saveEx();		
		assertEquals(DictionaryIDs.C_Tax.STANDARD.id, tax.getParent_Tax_ID(), "Unexpected parent tax id");
		
		tax.setIsSummary(true);
		tax.saveEx();
		assertEquals(0, tax.getParent_Tax_ID(), "Unexpected parent tax id");
	}
	
	@Test
	public void testTaxLookup() {
		int taxExemptId = Tax.getExemptTax(Env.getCtx(), getAD_Org_ID(), getTrxName());
		assertTrue(taxExemptId>0, "Fail to get tax exempt Id");
		
		MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
		bp.setIsTaxExempt(true);
		bp.saveEx();
		
		int id = Core.getTaxLookup().get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, 0, getLoginDate(), getLoginDate(), getAD_Org_ID(), getM_Warehouse_ID(), 
				bp.getPrimaryC_BPartner_Location_ID(), bp.getPrimaryC_BPartner_Location_ID(), true, null, getTrxName());
		assertEquals(taxExemptId, id, "Unexpected tax id");
		
		bp.setIsTaxExempt(false);
		bp.saveEx();
		
		id = Core.getTaxLookup().get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, 0, getLoginDate(), getLoginDate(), getAD_Org_ID(), getM_Warehouse_ID(), 
				bp.getPrimaryC_BPartner_Location_ID(), bp.getPrimaryC_BPartner_Location_ID(), true, null, getTrxName());
		assertTrue(id != taxExemptId, "Unexpected tax id: " + id);
		assertEquals(DictionaryIDs.C_Tax.STANDARD.id, id, "Unexpected tax id");
	}
	
	@Test
	public void testDistributeTaxToProductCost() {
		MProduct product = null;
		MTaxCategory category = null;
		MTax tax = null;
		try {
			category = new MTaxCategory(Env.getCtx(), 0, null);
			category.setName("testDistributeTaxToProductCost");
			category.saveEx();
			
			//need to create tax without trx as tax is cache
			tax = new MTax(Env.getCtx(), 0, null);
			tax.setC_TaxCategory_ID(category.get_ID());
			tax.setIsDocumentLevel(false);
			tax.setIsSummary(false);
			tax.setRate(new BigDecimal("5.00"));
			tax.setTaxPostingIndicator(MTax.TAXPOSTINGINDICATOR_DistributeTaxWithRelevantExpense);
			tax.setSOPOType(MTax.SOPOTYPE_PurchaseTax);
			tax.setName("testDistributeTaxToProductCost");
			tax.saveEx();
			CacheMgt.get().reset();
			
			//need to create product with trx as order line get product from cache
			MProduct p = MProduct.get(DictionaryIDs.M_Product.AZALEA_BUSH.id);
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(p.getM_Product_Category_ID());
			product.setC_TaxCategory_ID(category.get_ID());
			product.setIsStocked(true);
			product.setIsPurchased(true);
			product.setIsSold(true);
			product.setIsStocked(true);
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setName("testDistributeTaxToProductCost");
			product.setC_UOM_ID(p.getC_UOM_ID());
			product.saveEx();
			
			MPriceList priceList = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id);
			MPriceListVersion priceListVersion = priceList.getPriceListVersion(null);
			MProductPrice productPrice = new MProductPrice(Env.getCtx(), 0, getTrxName());
			productPrice.setM_PriceList_Version_ID(priceListVersion.get_ID());
			productPrice.setM_Product_ID(product.getM_Product_ID());
			productPrice.setPrices(new BigDecimal("2.00"), new BigDecimal("2.00"), new BigDecimal("2.00"));
			productPrice.saveEx();
			
			//purchase price of 2 + 5% tax
			BigDecimal expectedCost = new BigDecimal("2.00").add(new BigDecimal("2.00").multiply(new BigDecimal("0.05"))).setScale(2, RoundingMode.HALF_EVEN);
			
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal("1"));
			orderLine.setTax();
			orderLine.saveEx();
			
			assertEquals(tax.get_ID(), orderLine.getC_Tax_ID(), "Un-expected tax id");
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());		
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			assertEquals(expectedCost, order.getGrandTotal().setScale(2, RoundingMode.HALF_EVEN), "Un-expected order grand total");
			
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
			
			MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
			int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setOrderLine(orderLine, M_Locator_ID, new BigDecimal("1"));
			receiptLine.setLine(10);
			receiptLine.setQty(new BigDecimal("1"));
			receiptLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());		
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			MInvoice invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setShipLine(receiptLine);
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(new BigDecimal("1"));
			invoiceLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			invoice.load(getTrxName());		
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			//ensure match po have been posted
			MMatchPO[] matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
			assertNotNull(matchPOs, "Can't retrive match po for order line");
			assertEquals(1, matchPOs.length, "Un-expected number of match po record for order line");
			if (!matchPOs[0].isPosted())
				DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MMatchPO.Table_ID, matchPOs[0].get_ID(), true, getTrxName());
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			productCost.setQty(new BigDecimal("1"));
			MAcctSchema schema = MClientInfo.get().getMAcctSchema1();
			BigDecimal averageCost = productCost.getProductCosts(schema, getAD_Org_ID(), MCost.COSTINGMETHOD_AveragePO, 0, true);	
			if (averageCost == null)
				averageCost = BigDecimal.ZERO;
			averageCost = averageCost.setScale(2, RoundingMode.HALF_EVEN);
			assertEquals(expectedCost, averageCost, "Un-expected average cost");
			
			MAccount acctAsset = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, schema);
			String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MInOut.Table_ID 
					+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + receipt.get_ID()
					+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + schema.getC_AcctSchema_ID();
			int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
			BigDecimal totalDebit = new BigDecimal("0.00");
			for(int id : ids) {
				MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
				if (fa.getAccount_ID() == acctAsset.getAccount_ID()) {
					totalDebit = totalDebit.add(fa.getAmtAcctDr());
				}
			}
			assertEquals(expectedCost, totalDebit.setScale(2, RoundingMode.HALF_EVEN), "Un-expected product asset account posted amount");
		} finally {
			rollback();
			if (product != null && product.get_ID() > 0)
				product.deleteEx(true);
			if (tax != null && tax.get_ID() > 0)
				tax.deleteEx(true);
			if (category != null && category.get_ID() > 0)
				category.deleteEx(true);			
		}
	}
	
	@Test
	public void testSeparateTaxPosting() {
		MProduct product = null;
		MTaxCategory category = null;
		MTax tax = null;
		try {
			category = new MTaxCategory(Env.getCtx(), 0, null);
			category.setName("testSeparateTaxPosting");
			category.saveEx();
			
			//need to create tax without trx as tax is cache
			tax = new MTax(Env.getCtx(), 0, null);
			tax.setC_TaxCategory_ID(category.get_ID());
			tax.setIsDocumentLevel(false);
			tax.setIsSummary(false);
			tax.setRate(new BigDecimal("5.00"));
			tax.setTaxPostingIndicator(MTax.TAXPOSTINGINDICATOR_SeparateTaxPosting);
			tax.setSOPOType(MTax.SOPOTYPE_PurchaseTax);
			tax.setName("testSeparateTaxPosting");
			tax.saveEx();
			CacheMgt.get().reset();
			
			//need to create product with trx as order line get product from cache
			MProduct p = MProduct.get(DictionaryIDs.M_Product.AZALEA_BUSH.id);
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(p.getM_Product_Category_ID());
			product.setC_TaxCategory_ID(category.get_ID());
			product.setIsStocked(true);
			product.setIsPurchased(true);
			product.setIsSold(true);
			product.setIsStocked(true);
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setName("testSeparateTaxPosting");
			product.setC_UOM_ID(p.getC_UOM_ID());
			product.saveEx();
			
			MPriceList priceList = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id);
			MPriceListVersion priceListVersion = priceList.getPriceListVersion(null);
			MProductPrice productPrice = new MProductPrice(Env.getCtx(), 0, getTrxName());
			productPrice.setM_PriceList_Version_ID(priceListVersion.get_ID());
			productPrice.setM_Product_ID(product.getM_Product_ID());
			productPrice.setPrices(new BigDecimal("2.00"), new BigDecimal("2.00"), new BigDecimal("2.00"));
			productPrice.saveEx();
			
			//purchase price of 2
			BigDecimal expectedCost = new BigDecimal("2.00").setScale(2, RoundingMode.HALF_EVEN);
			//purchase price of 2 + 5% tax
			BigDecimal expectedTotal = new BigDecimal("2.00").add(new BigDecimal("2.00").multiply(new BigDecimal("0.05"))).setScale(2, RoundingMode.HALF_EVEN);
			
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(bpartner);
			order.setIsSOTrx(false);
			order.setC_DocTypeTarget_ID();
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();
			
			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal("1"));
			orderLine.setTax();
			orderLine.saveEx();
			
			assertEquals(tax.get_ID(), orderLine.getC_Tax_ID(), "Un-expected tax id");
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());		
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			assertEquals(expectedTotal, order.getGrandTotal().setScale(2, RoundingMode.HALF_EVEN), "Un-expected order grand total");
			
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
			receipt.saveEx();
			
			MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
			int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setOrderLine(orderLine, M_Locator_ID, new BigDecimal("1"));
			receiptLine.setLine(10);
			receiptLine.setQty(new BigDecimal("1"));
			receiptLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());		
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			MInvoice invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setShipLine(receiptLine);
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(new BigDecimal("1"));
			invoiceLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			invoice.load(getTrxName());		
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			//ensure match po have been posted
			MMatchPO[] matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
			assertNotNull(matchPOs, "Can't retrive match po for order line");
			assertEquals(1, matchPOs.length, "Un-expected number of match po record for order line");
			if (!matchPOs[0].isPosted())
				DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MMatchPO.Table_ID, matchPOs[0].get_ID(), true, getTrxName());
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			productCost.setQty(new BigDecimal("1"));
			MAcctSchema schema = MClientInfo.get().getMAcctSchema1();
			BigDecimal averageCost = productCost.getProductCosts(schema, getAD_Org_ID(), MCost.COSTINGMETHOD_AveragePO, 0, true);	
			if (averageCost == null)
				averageCost = BigDecimal.ZERO;
			averageCost = averageCost.setScale(2, RoundingMode.HALF_EVEN);
			assertEquals(expectedCost, averageCost, "Un-expected average cost");
			
			MAccount acctAsset = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, schema);
			String whereClause = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MInOut.Table_ID 
					+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + receipt.get_ID()
					+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + schema.getC_AcctSchema_ID();
			int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause, getTrxName());
			BigDecimal totalDebit = new BigDecimal("0.00");
			for(int id : ids) {
				MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
				if (fa.getAccount_ID() == acctAsset.getAccount_ID()) {
					totalDebit = totalDebit.add(fa.getAmtAcctDr());
				}
			}
			assertEquals(expectedCost, totalDebit.setScale(2, RoundingMode.HALF_EVEN), "Un-expected product asset account posted amount");
		} finally {
			rollback();
			if (product != null && product.get_ID() > 0)
				product.deleteEx(true);
			if (tax != null && tax.get_ID() > 0)
				tax.deleteEx(true);
			if (category != null && category.get_ID() > 0)
				category.deleteEx(true);			
		}
	}
}
