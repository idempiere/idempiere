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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
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
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MWarehouse;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
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
		
		try {
			int mulchId = DictionaryIDs.M_Product.MULCH.id;  // Mulch product
			MProduct mulch = new MProduct(Env.getCtx(), mulchId, getTrxName());
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
				
				String whereClause2 = MFactAcct.COLUMNNAME_AD_Table_ID + "=" + MMatchInv.Table_ID
						+ " AND " + MFactAcct.COLUMNNAME_Record_ID + "=" + mi.get_ID()
						+ " AND " + MFactAcct.COLUMNNAME_C_AcctSchema_ID + "=" + C_AcctSchema_ID;
				int[] ids = MFactAcct.getAllIDs(MFactAcct.Table_Name, whereClause2, getTrxName());
				BigDecimal invMatchAmt = invoiceLine.getMatchedQty().multiply(invoiceLine.getPriceActual()).setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
				mulchCost = mulchCost.setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
				for (int id : ids) {
					MFactAcct fa = new MFactAcct(Env.getCtx(), id, getTrxName());
					if (fa.getAccount_ID() == acctNIR.getAccount_ID())
						assertEquals(fa.getAmtAcctDr().setScale(2, RoundingMode.HALF_UP), mulchCost.setScale(2, RoundingMode.HALF_UP), "");
					else if (fa.getAccount_ID() == acctInvClr.getAccount_ID())
						assertEquals(fa.getAmtAcctCr().setScale(2, RoundingMode.HALF_UP), invMatchAmt.setScale(2, RoundingMode.HALF_UP), "");
					else if (fa.getAccount_ID() == acctIPV.getAccount_ID())
						assertEquals(fa.getAmtAcctDr().subtract(fa.getAmtAcctCr()).setScale(2, RoundingMode.HALF_UP), invMatchAmt.subtract(mulchCost).setScale(2, RoundingMode.HALF_UP), "");
				}
			}
		} finally {
			getTrx().rollback();
			category.deleteEx(true);
		}
	}
}
