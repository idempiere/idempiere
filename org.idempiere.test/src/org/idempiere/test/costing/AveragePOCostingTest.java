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
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetExclude;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MLandedCost;
import org.compiere.model.MLandedCostAllocation;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLandedCost;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.ConversionRateHelper;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.FactAcct;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;

@Isolated
public class AveragePOCostingTest extends AbstractTestCase {

	public AveragePOCostingTest() {
	}

	@Test
	public void testMaterialReceipt() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class)) {
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product.setName("testMaterialReceipt");
			product.setValue("testMaterialReceipt");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			mockProductGet(mockedProduct, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MInOutLine receiptLine = createPOAndMRForProduct(product.get_ID(), null, null);
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(new BigDecimal("2.00"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for material receipt line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			receiptLine = createPOAndMRForProduct(product.get_ID(), null, new BigDecimal("3.00"));
			cost.load(getTrxName());
			//(2+3)/2
			assertEquals(new BigDecimal("2.50"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for material receipt line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			//reverse MR2
			MInOut receipt = new MInOut(Env.getCtx(), receiptLine.getM_InOut_ID(), getTrxName());
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus(), "Unexpected Document Status");
			MInOut reverse = new MInOut(Env.getCtx(), receipt.getReversal_ID(), getTrxName());
			if (!reverse.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), reverse.getAD_Client_ID(), reverse.get_Table_ID(), reverse.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//back to cost=2 after reversal
			cost.load(getTrxName());
			assertEquals(new BigDecimal("2.00"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("0.00"), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		}
	}
	
	@Test
	public void testShipment() {
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, getTrxName());
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.AZALEA_BUSH.id, null, new BigDecimal("5.00"));
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Unexpected Document Status");
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected Document Status");
		
		//cost shouldn't change after shipment
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.get_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for shipment line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");		
		
		//reverse shipment
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Accrual);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Reversed, shipment.getDocStatus(), "Unexpected Document Status");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
		
		MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
		MInOutLine[] reversalLines = reversal.getLines();
		cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLines[0].get_ID(), 0, as.get_ID(), getTrxName());
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
	}
	
	@Test
	public void testInternalUse() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setQtyInternalUse(new BigDecimal("1.00"));
		line.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", line.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse internal use
		info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Reverse_Accrual);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MInventory reversal = new MInventory(Env.getCtx(), inventory.getReversal_ID(), getTrxName());
		cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversal.getLines(false)[0].getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	}
	
	@Test
	public void testProjectIssue() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MProject project = new MProject(Env.getCtx(), 0, getTrxName());
		project.setName("testProjectIssue");
		project.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		project.saveEx();
		
		MProjectIssue issue = new MProjectIssue(project);
		issue.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		issue.setLine(10);
		issue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		issue.setMovementQty(new BigDecimal("1.00"));
		issue.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Complete);
		issue.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, issue.getDocStatus(), "Unexpected Document Status");
		if (!issue.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), issue.getAD_Client_ID(), issue.get_Table_ID(), issue.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", issue.getC_ProjectIssue_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for project issue line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse issue
		info = MWorkflow.runDocumentActionWorkflow(issue, DocAction.ACTION_Reverse_Accrual);
		issue.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, issue.getDocStatus(), "Unexpected Document Status");
		
		cd = MCostDetail.get(Env.getCtx(), "C_ProjectIssue_ID=?", issue.getReversal_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for project issue line");
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	}
	
	@Test
	public void testProduction() {
		MProduct mulch = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MProduct azb = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, getTrxName());
		
		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class)) {			
			MProduct mulchX = new MProduct(Env.getCtx(), 0, getTrxName());
			mulchX.setName("MulchX2");
			mulchX.setIsBOM(true);
			mulchX.setIsStocked(true);
			mulchX.setC_UOM_ID(mulch.getC_UOM_ID());
			mulchX.setM_Product_Category_ID(mulch.getM_Product_Category_ID());
			mulchX.setProductType(mulch.getProductType());
			mulchX.setM_AttributeSet_ID(mulch.getM_AttributeSet_ID());
			mulchX.setC_TaxCategory_ID(mulch.getC_TaxCategory_ID());
			mulchX.saveEx();
			
			mockedProduct.when(() -> MProduct.getCopy(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(anyInt())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt())).thenCallRealMethod();
			mockProductGet(mockedProduct, mulchX);
			
			MClient client = MClient.get(Env.getCtx());
			MAcctSchema as = client.getAcctSchema();
			assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
			MCost cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
				createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
				cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			}
			BigDecimal mulchCost = cost.getCurrentCostPrice();
			cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
				createPOAndMRForProduct(DictionaryIDs.M_Product.AZALEA_BUSH.id, null, null);
				cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			}
			BigDecimal azbCost = cost.getCurrentCostPrice();
			
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(mulchX.get_ID());		
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(mulchX.getName());
			bom.saveEx();
			
			MPPProductBOMLine line1 = new MPPProductBOMLine(bom);
			line1.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
			line1.setQtyBOM(new BigDecimal("1"));
			line1.saveEx();
	
			MPPProductBOMLine line2 = new MPPProductBOMLine(bom);
			line2.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
			line2.setQtyBOM(new BigDecimal("1"));
			line2.saveEx();
			
			mulchX.load(getTrxName());
			mulchX.setIsVerified(true);
			mulchX.saveEx();
			
			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(mulchX.get_ID());
			production.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			production.setIsUseProductionPlan(false);
			production.setMovementDate(getLoginDate());
			production.setDocAction(DocAction.ACTION_Complete);
			production.setDocStatus(DocAction.STATUS_Drafted);
			production.setIsComplete(false);
			production.setProductionQty(new BigDecimal("1"));
			production.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production.saveEx();
			
			int productionCreate = 53226;
			MProcess process = MProcess.get(Env.getCtx(), productionCreate);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());
	
			production.load(getTrxName());
			MProductionLine[] plines = production.getLines();
			assertEquals("Y", production.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(plines.length > 0, "No Production Lines");
			assertEquals(3, plines.length, "Unexpected number of production lines");
	
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, production.getDocStatus(), "Production Status="+production.getDocStatus());
			
			BigDecimal rollup = mulchCost.add(azbCost); 
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", plines[0].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(rollup.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			mulchX.set_TrxName(getTrxName());
			cost = mulchX.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(rollup.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", plines[1].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(mulchCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(mulchCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", plines[2].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(azbCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(azbCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			//reverse production
			info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Reverse_Accrual);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, production.getDocStatus(), "Production Status="+production.getDocStatus());
			
			MProduction reversal = new MProduction(Env.getCtx(), production.getReversal_ID(), getTrxName());
			MProductionLine[] reversalLines = reversal.getLines();
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", reversalLines[0].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(rollup.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", reversalLines[1].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(mulchCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = mulch.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(mulchCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			cd = MCostDetail.get(Env.getCtx(), "M_ProductionLine_ID=?", reversalLines[2].getM_ProductionLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for project issue line");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(azbCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			cost = azb.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
	}
	
	@Test
	public void testMRAndShipmentByLot() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

		MAttributeSet mas = new MAttributeSet(Env.getCtx(), DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id, getTrxName());
		mas.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
		mas.saveEx();
		
		MAttributeSetExclude exclude = new MAttributeSetExclude(Env.getCtx(), 0, null);
		exclude.setM_AttributeSet_ID(mas.get_ID());
		exclude.setAD_Table_ID(MOrderLine.Table_ID);
		exclude.setIsSOTrx(true);
		exclude.saveEx();
		
		MAttributeSetExclude exclude1 = new MAttributeSetExclude(Env.getCtx(), 0, null);
		exclude1.setM_AttributeSet_ID(mas.get_ID());
		exclude1.setAD_Table_ID(MInOutLine.Table_ID);
		exclude1.setIsSOTrx(true);
		exclude1.saveEx();
		
		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class);
			MockedStatic<MProductCategory> mockedCategory = mockStatic(MProductCategory.class)) {	
			
			MProductCategory lotLevel = new MProductCategory(Env.getCtx(), 0, getTrxName());
			lotLevel.setName("testMaterialReceiptLot");
			lotLevel.saveEx();
			
			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), anyInt())).thenCallRealMethod();
			mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(lotLevel.get_ID()))).thenReturn(lotLevel);
						
			MProductCategoryAcct lotLevelAcct = MProductCategoryAcct.get(lotLevel.get_ID(), as.get_ID(), getTrxName());
			lotLevelAcct = new MProductCategoryAcct(Env.getCtx(), lotLevelAcct, getTrxName());
			lotLevelAcct.setCostingLevel(MAcctSchema.COSTINGLEVEL_BatchLot);
			lotLevelAcct.saveEx();
			CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
			MProductCategoryAcct.get(lotLevel.get_ID(), as.get_ID(), getTrxName());
			
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(lotLevel.get_ID());
			product.setName("testMaterialReceiptLot");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			product.saveEx();
			
			mockedProduct.when(() -> MProduct.getCopy(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(anyInt())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt())).thenCallRealMethod();
			mockProductGet(mockedProduct, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			MAttributeSetInstance asi1 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi1.setLot("Lot1");
			asi1.saveEx();			
			MInOutLine line1 = createPOAndMRForProduct(product.get_ID(), asi1, new BigDecimal("2.00"));
			
			MAttributeSetInstance asi2 = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			asi2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			asi2.setLot("Lot2");
			asi2.saveEx();			
			MInOutLine line2 = createPOAndMRForProduct(product.get_ID(), asi2, new BigDecimal("3.00"));
			
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), asi1.get_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", line2.getC_OrderLine_ID(), asi2.get_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			product.set_TrxName(getTrxName());
			MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), asi1.get_ID(), as.getCostingMethod());
			assertNotNull(cost1, "MCost record not found");
			assertEquals(new BigDecimal("2.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), asi2.get_ID(), as.getCostingMethod());
			assertNotNull(cost2, "MCost record not found");
			assertEquals(new BigDecimal("3.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			//check posting
			ProductCost pc = new ProductCost(Env.getCtx(), line1.getM_Product_ID(), line1.getM_AttributeSetInstance_ID(), getTrxName());
			MAccount asset = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, line1.getM_InOut_ID(), getTrxName());
			doc.setC_BPartner_ID(line1.getParent().getC_BPartner_ID());
			MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, line1.getM_InOut_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> fas = query.list();					
			assertTrue(fas.size() > 0, "Failed to retrieve fact posting entries for shipment document");
			boolean nirFound = false;
			boolean assetFound = false;
			for (MFactAcct fa : fas) {
				if (asset.getAccount_ID() == fa.getAccount_ID()) {
					if (line1.get_ID() == fa.getLine_ID()) {
						assertEquals(fa.getAmtSourceDr().abs().toPlainString(), fa.getAmtSourceDr().toPlainString(), "Not DR Asset");
						assertTrue(fa.getAmtSourceDr().signum() > 0, "Not DR Asset");
					}
					assetFound = true;
				} else if (acctNIR.getAccount_ID() == fa.getAccount_ID()) {
					if (line1.get_ID() == fa.getLine_ID()) {
						assertEquals(fa.getAmtSourceCr().abs().toPlainString(), fa.getAmtSourceCr().toPlainString(), "Not CR Not Invoiced Receipt");
						assertTrue(fa.getAmtSourceCr().signum() > 0, "Not CR Not Invoiced Receipt");
					}
					nirFound = true;
				}
			}
			assertTrue(nirFound, "No Not Invoiced Receipt posting found");
			assertTrue(assetFound, "No Product Asset posting found");
			
			//shipment
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			order.setDatePromised(today);
			order.saveEx();
			
			MOrderLine ol1 = new MOrderLine(order);
			ol1.setLine(10);
			//Azalea Bush
			ol1.setProduct(product);
			ol1.setQty(new BigDecimal("2"));
			ol1.setDatePromised(today);
			ol1.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Unexpected document status");
			
			MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setOrderLine(ol1, 0, new BigDecimal("2"));
			shipmentLine.setQty(new BigDecimal("2"));
			shipmentLine.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus(), "Unexpected document status");
			
			MInOutLineMA[] linema = MInOutLineMA.get(Env.getCtx(), shipmentLine.get_ID(), getTrxName());
			assertEquals(2, linema.length, "Unexpected number of MInOutLineMA records");
			assertEquals(linema[0].getM_AttributeSetInstance_ID(), asi1.get_ID(), "Unexpected M_AttributeSetInstance_ID for MInOutLineMA 1");
			assertEquals(linema[1].getM_AttributeSetInstance_ID(), asi2.get_ID(), "Unexpected M_AttributeSetInstance_ID for MInOutLineMA 2");
			assertEquals(1, linema[0].getMovementQty().intValue(), "Unexpected MovementQty for MInOutLineMA 1");
			assertEquals(1, linema[1].getMovementQty().intValue(), "Unexpected MovementQty for MInOutLineMA 2");
			
			// check posting
			if (!shipment.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
				assertTrue(error == null, error);			
			}
			pc = new ProductCost(Env.getCtx(), shipmentLine.getM_Product_ID(), shipmentLine.getM_AttributeSetInstance_ID(), getTrxName());
			MAccount cogs = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			asset = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.getM_InOut_ID(), as.getC_AcctSchema_ID(), getTrxName());
			fas = query.list();
			assertTrue(fas.size() > 0, "Failed to retrieve fact posting entries for shipment document");
			boolean cogsFound = false;
			assetFound = false;
			for (MFactAcct fa : fas) {
				if (cogs.getAccount_ID() == fa.getAccount_ID()) {
					if (shipmentLine.get_ID() == fa.getLine_ID()) {
						assertEquals(fa.getAmtSourceDr().abs().toPlainString(), fa.getAmtSourceDr().toPlainString(), "Not DR COGS");
						assertTrue(fa.getAmtSourceDr().signum() > 0, "Not DR COGS");
					}
					cogsFound = true;
				} else if (asset.getAccount_ID() == fa.getAccount_ID()) {
					if (shipmentLine.get_ID() == fa.getLine_ID()) {
						assertEquals(fa.getAmtSourceCr().abs().toPlainString(), fa.getAmtSourceCr().toPlainString(), "Not CR Product Asset");
						assertTrue(fa.getAmtSourceCr().signum() > 0, "Not CR Product Asset");
					}
					assetFound = true;
				}
			}
			assertTrue(cogsFound, "No COGS posting found");
			assertTrue(assetFound, "No Product Asset posting found");
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), linema[0].getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2").negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), linema[1].getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3").negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			//reverse shipment
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, shipment.getDocStatus(), "Unexpected document status");
			
			MInOut reversal = new MInOut(Env.getCtx(), shipment.getReversal_ID(), getTrxName());
			MInOutLine[] reversalLines = reversal.getLines();
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLines[0].getM_InOutLine_ID(), asi1.getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("2").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLines[0].getM_InOutLine_ID(), asi2.getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line1");
			assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("3").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
			
			cost1 = product.getCostingRecord(as, getAD_Org_ID(), asi1.get_ID(), as.getCostingMethod());
			assertNotNull(cost1, "MCost record not found");
			assertEquals(new BigDecimal("2.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			cost2 = product.getCostingRecord(as, getAD_Org_ID(), asi2.get_ID(), as.getCostingMethod());
			assertNotNull(cost2, "MCost record not found");
			assertEquals(new BigDecimal("3.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP));
			
			//reverse MR2
			MInOut mr2 = new MInOut(Env.getCtx(), line2.getM_InOut_ID(), getTrxName());
			info = MWorkflow.runDocumentActionWorkflow(mr2, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			mr2.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, mr2.getDocStatus(), "Unexpected document status");
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", line2.getC_OrderLine_ID(), asi2.getM_AttributeSetInstance_ID(), as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for order line2");
			assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		} finally {
			rollback();			
			
			exclude.deleteEx(true);
			exclude1.deleteEx(true);
		}
	}
	
	/**
	 * PO, Product1, Qty=100, Price=100; Product2, Qty=100, Price=185 (Period 1)
	 * MR, Product1, Qty=85, Price=100; Product2, Qty=100, Price=185 (Period 1)
	 * ID1, Product1, Qty=50; Product2, Qty=50 (Period 1) - Inventory Decrease
	 * PI, Product1, Qty=100, Price=107; Product2, Qty=100, Price=178 (Period 2) - Purchase Invoice
	 * ID2, Product1, Qty=15; Product2, Qty=50 (Period 2) - Inventory Decrease
	 * PI Reverse-Accrual (Period 3)
	 */
	@Test
	public void testMRAndInternalUse() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");

		Timestamp currentDate = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date2 = new Timestamp(cal.getTimeInMillis());
		Timestamp date3 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.SPOT.id; // Spot
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		MCurrency thb = MCurrency.get(206); // THB
		
		BigDecimal usdToThb1 = new BigDecimal(33.765676939525);
		BigDecimal usdToThb2 = new BigDecimal(33.676559212063);
		BigDecimal usdToThb3 = new BigDecimal(34.060623004218);

		BigDecimal eurToThb1 = new BigDecimal(35.514331076906);
		BigDecimal eurToThb2 = new BigDecimal(34.968463021279);
		BigDecimal eurToThb3 = new BigDecimal(35.413895000609);
		
		BigDecimal usdToEur = new BigDecimal(0.85);
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, getTrxName());
		priceList.setName("Import THB " + System.currentTimeMillis());
		priceList.setC_Currency_ID(thb.getC_Currency_ID());
		priceList.setPricePrecision(thb.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id); // Purchase 2001
		plv.setValidFrom(date1);
		plv.saveEx();
		 
		try (MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic();
			 MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class)) {
			mockGetRate(conversionRateMock, usd, thb, 0, date1, usdToThb1);
			mockGetRate(conversionRateMock, usd, thb, 0, date2, usdToThb2);
			mockGetRate(conversionRateMock, usd, thb, 0, date3, usdToThb3);
			
			mockGetRate(conversionRateMock, euro, thb, 0, date1, eurToThb1);
			mockGetRate(conversionRateMock, euro, thb, 0, date2, eurToThb2);
			mockGetRate(conversionRateMock, euro, thb, 0, date3, eurToThb3);
			
			mockGetRate(conversionRateMock, usd, euro, 0, date1, usdToEur);
			mockGetRate(conversionRateMock, usd, euro, 0, date2, usdToEur);
			mockGetRate(conversionRateMock, usd, euro, 0, date3, usdToEur);
			
			priceListMock.when(() -> MPriceList.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
			
			MProduct product1 = new MProduct(Env.getCtx(), 0, getTrxName());
			product1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product1.setName("testMRAndInternalUse1");
			product1.setValue("testMRAndInternalUse1");
			product1.setProductType(MProduct.PRODUCTTYPE_Item);
			product1.setIsStocked(true);
			product1.setIsSold(true);
			product1.setIsPurchased(true);
			product1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product1.saveEx();
 			
			mockProductGet(productMock, product1);
			
			BigDecimal priceInThb1 = new BigDecimal(100);
			MProductPrice pp1 = new MProductPrice(plv, product1.getM_Product_ID(), priceInThb1, priceInThb1, Env.ZERO);
			pp1.saveEx();
			
			MProduct product2 = new MProduct(Env.getCtx(), 0, getTrxName());
			product2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product2.setName("testMRAndInternalUse2");
			product2.setValue("testMRAndInternalUse2");
			product2.setProductType(MProduct.PRODUCTTYPE_Item);
			product2.setIsStocked(true);
			product2.setIsSold(true);
			product2.setIsPurchased(true);
			product2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product2.saveEx();
 			
			mockProductGet(productMock, product2);
			
			BigDecimal priceInThb2 = new BigDecimal(185);
			MProductPrice pp2 = new MProductPrice(plv, product2.getM_Product_ID(), priceInThb2, priceInThb2, Env.ZERO);
			pp2.saveEx();
			
			// PO
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setM_PriceList_ID(priceList.get_ID());
			order.setC_Currency_ID(thb.get_ID());
			order.setC_ConversionType_ID(C_ConversionType_ID);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateOrdered(date1);
			order.setDateAcct(date1);
			order.setDatePromised(date1);
			order.saveEx();

			MOrderLine line1 = new MOrderLine(order);
			line1.setLine(10);
			line1.setProduct(new MProduct(Env.getCtx(), product1, getTrxName()));
			line1.setQty(new BigDecimal("100"));
			line1.setDatePromised(date1);
			line1.setPrice(priceInThb1);
			line1.saveEx();
			
			MOrderLine line2 = new MOrderLine(order);
			line2.setLine(20);
			line2.setProduct(new MProduct(Env.getCtx(), product2, getTrxName()));
			line2.setQty(new BigDecimal("100"));
			line2.setDatePromised(date1);
			line2.setPrice(priceInThb2);
			line2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			// MR
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt);
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("85"));
			receiptLine1.setQty(new BigDecimal("85"));
			receiptLine1.saveEx();
			
			MInOutLine receiptLine2 = new MInOutLine(receipt);
			receiptLine2.setOrderLine(line2, 0, new BigDecimal("100"));
			receiptLine2.setQty(new BigDecimal("100"));
			receiptLine2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			} 
			
			// Inventory Decrease 1
			MInventory inventory1 = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory1.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
			inventory1.setMovementDate(date1);
			inventory1.saveEx();
			
			MInventoryLine invLine11 = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			invLine11.setM_Inventory_ID(inventory1.get_ID());
			invLine11.setM_Product_ID(product1.get_ID());
			invLine11.setQtyInternalUse(new BigDecimal("50"));
			invLine11.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
			invLine11.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			invLine11.saveEx();
			
			MInventoryLine invLine12 = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			invLine12.setM_Inventory_ID(inventory1.get_ID());
			invLine12.setM_Product_ID(product2.get_ID());
			invLine12.setQtyInternalUse(new BigDecimal("50"));
			invLine12.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
			invLine12.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			invLine12.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(inventory1, DocAction.ACTION_Complete);
			inventory1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory1.getDocStatus(), "Unexpected Document Status");

			// Purchase Invoice
			MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, date2);
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine1 = new MInvoiceLine(invoice);
			invoiceLine1.setLine(10);
			invoiceLine1.setProduct(product1);
			invoiceLine1.setQty(new BigDecimal("100"));
			invoiceLine1.setPrice(new BigDecimal("107"));
			invoiceLine1.saveEx();
			
			MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice);
			invoiceLine2.setM_InOutLine_ID(receiptLine2.get_ID());
			invoiceLine2.setLine(20);
			invoiceLine2.setProduct(product2);
			invoiceLine2.setQty(new BigDecimal("100"));
			invoiceLine2.setPrice(new BigDecimal("178"));
			invoiceLine2.saveEx();
			
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
			
			// Inventory Decrease 2 
			MInventory inventory2 = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory2.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
			inventory2.setMovementDate(date3);
			inventory2.saveEx();
			
			MInventoryLine invLine21 = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			invLine21.setM_Inventory_ID(inventory2.get_ID());
			invLine21.setM_Product_ID(product1.get_ID());
			invLine21.setQtyInternalUse(new BigDecimal("15"));
			invLine21.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
			invLine21.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			invLine21.saveEx();
			
			MInventoryLine invLine22 = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			invLine22.setM_Inventory_ID(inventory2.get_ID());
			invLine22.setM_Product_ID(product2.get_ID());
			invLine22.setQtyInternalUse(new BigDecimal("50"));
			invLine22.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
			invLine22.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			invLine22.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(inventory2, DocAction.ACTION_Complete);
			inventory2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory2.getDocStatus(), "Unexpected Document Status");
			
			// Purchase Invoice (Reverse-Accrual)
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Reverse_Accrual);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, invoice.getDocStatus());
			assertTrue(invoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), getTrxName());
			assertEquals(invoice.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			// Matched Invoice
			// If it is a reverse-accrual, perform a stock coverage check using the current stock quantity to prevent any leftover amount in the inventory GL
			ProductCost p2ProductCost = new ProductCost(Env.getCtx(), product2.get_ID(), 0, getTrxName());
			MAccount assetAccount = p2ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = p2ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine2.get_ID(), getTrxName());
			assertEquals(2, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, mi.get_ID(), getTrxName());
				MInvoiceLine invLine = new MInvoiceLine(Env.getCtx(), mi.getC_InvoiceLine_ID(), getTrxName());
				doc.setC_BPartner_ID(invLine.getParent().getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				List<FactAcct> expected = new ArrayList<FactAcct>();
				expected.add(new FactAcct(acctNIR, new BigDecimal("547.89"), 2, !mi.isReversal(), mi.getQty()));
				expected.add(new FactAcct(acctInvClr, new BigDecimal("528.56"), 2, mi.isReversal(), mi.getQty().negate()));
				if (mi.isReversal()) {
					expected.add(new FactAcct(varianceAccount, new BigDecimal("19.33"), 2, mi.isReversal()));
				} else {
					expected.add(new FactAcct(varianceAccount, new BigDecimal("9.67"), 2, mi.isReversal()));
					expected.add(new FactAcct(assetAccount, new BigDecimal("9.67"), 2, mi.isReversal()));
					expected.add(new FactAcct(as.getCurrencyBalancing_Acct(), new BigDecimal("-0.01"), 2, mi.isReversal()));
				}
				assertFactAcctEntries(factAccts, expected);
			}
			
			// Allocation
			// If the allocation is created as a result of the invoice reversal, do not use RLG/RLL, as this will cause the AP balance to not be zero
			MAllocationHdr[] allocationHdrs = MAllocationHdr.getOfInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			assertTrue(allocationHdrs.length == 1);
			if (!allocationHdrs[0].isPosted()) { 
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MAllocationHdr.Table_ID, allocationHdrs[0].get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			assertTrue(allocationHdrs[0].isPosted());
			Doc doc = DocManager.getDocument(as, MAllocationHdr.Table_ID, allocationHdrs[0].get_ID(), getTrxName());
			doc.setC_BPartner_ID(invoice.getC_BPartner_ID());
			MAccount acctLiability = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MAllocationHdr.Table_ID, allocationHdrs[0].get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(
					new FactAcct(acctLiability, new BigDecimal("836.74"), 2, true), 
					new FactAcct(acctLiability, new BigDecimal("9.55"), 2, true), 
					new FactAcct(acctLiability, new BigDecimal("9.55"), 2, false),
					new FactAcct(acctLiability, new BigDecimal("-836.74"), 2, true));
			assertFactAcctEntries(factAccts, expected);
		}
	}
	
	/**
	 * PO1, Product1, Qty=100, Price=100; Product2, Qty=100, Price=185 (Period 1)
	 * PI1, Product1, Qty=100, Price=100; Product2, Qty=100, Price=185 (Period 1)
	 * MR1, Product1, Qty=85, Price=100; Product2, Qty=100, Price=185 (Period 2) - Reverse-Correct
	 * PO2, Product1, Qty=100, Price=100; Product2, Qty=100, Price=185 (Period 2)
	 * PI2, Product1, Qty=100, Price=100; Product2, Qty=100, Price=185 (Period 2)
	 * MR2, Product1, Qty=85, Price=100; Product2, Qty=100, Price=185 (Period 3) - Reverse-Correct
	 */
	@Test
	public void testReverseCorrectMultipleMR() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");

		Timestamp currentDate = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp date1 = new Timestamp(cal.getTimeInMillis());
		cal.setTimeInMillis(currentDate.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp date2 = new Timestamp(cal.getTimeInMillis()); 
		Timestamp date3 = currentDate;
		
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		MCurrency thb = MCurrency.get(206); // THB
		
		BigDecimal usdToThb1 = new BigDecimal(33.765676939525);
		BigDecimal usdToThb2 = new BigDecimal(33.676559212063);
		BigDecimal usdToThb3 = new BigDecimal(34.060623004218);

		BigDecimal eurToThb1 = new BigDecimal(35.514331076906);
		BigDecimal eurToThb2 = new BigDecimal(34.968463021279);
		BigDecimal eurToThb3 = new BigDecimal(35.413895000609);
		
		BigDecimal usdToEur = new BigDecimal(0.85);
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, getTrxName());
		priceList.setName("Import THB " + System.currentTimeMillis());
		priceList.setC_Currency_ID(thb.getC_Currency_ID());
		priceList.setPricePrecision(thb.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id); // Purchase 2001
		plv.setValidFrom(date1);
		plv.saveEx();
		 
		try (MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic();
			 MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class)) {
			mockGetRate(conversionRateMock, usd, thb, C_ConversionType_ID, date1, usdToThb1);
			mockGetRate(conversionRateMock, usd, thb, C_ConversionType_ID, date2, usdToThb2);
			mockGetRate(conversionRateMock, usd, thb, C_ConversionType_ID, date3, usdToThb3);
			
			mockGetRate(conversionRateMock, euro, thb, C_ConversionType_ID, date1, eurToThb1);
			mockGetRate(conversionRateMock, euro, thb, C_ConversionType_ID, date2, eurToThb2);
			mockGetRate(conversionRateMock, euro, thb, C_ConversionType_ID, date3, eurToThb3);
			
			mockGetRate(conversionRateMock, usd, euro, C_ConversionType_ID, null, usdToEur);
			
			priceListMock.when(() -> MPriceList.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
			
			MProduct product1 = new MProduct(Env.getCtx(), 0, getTrxName());
			product1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product1.setName("testMultipleMR1");
			product1.setProductType(MProduct.PRODUCTTYPE_Item);
			product1.setIsStocked(true);
			product1.setIsSold(true);
			product1.setIsPurchased(true);
			product1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product1.saveEx();
 			
			mockProductGet(productMock, product1);
					
			BigDecimal priceInThb1 = new BigDecimal(100);
			MProductPrice pp1 = new MProductPrice(plv, product1.getM_Product_ID(), priceInThb1, priceInThb1, Env.ZERO);
			pp1.saveEx();
			
			MProduct product2 = new MProduct(Env.getCtx(), 0, getTrxName());
			product2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
			product2.setName("testMultipleMR2");
			product2.setProductType(MProduct.PRODUCTTYPE_Item);
			product2.setIsStocked(true);
			product2.setIsSold(true);
			product2.setIsPurchased(true);
			product2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product2.saveEx();
 			
			mockProductGet(productMock, product2);
						
			BigDecimal priceInThb2 = new BigDecimal(185);
			MProductPrice pp2 = new MProductPrice(plv, product2.getM_Product_ID(), priceInThb2, priceInThb2, Env.ZERO);
			pp2.saveEx();
			
			// PO
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setM_PriceList_ID(priceList.get_ID());
			order.setC_Currency_ID(thb.get_ID());
			order.setC_ConversionType_ID(C_ConversionType_ID);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateOrdered(date1);
			order.setDateAcct(date1);
			order.setDatePromised(date1);
			order.saveEx();

			MOrderLine line1 = new MOrderLine(order);
			line1.setLine(10);
			line1.setProduct(new MProduct(Env.getCtx(), product1, getTrxName()));
			line1.setQty(new BigDecimal("100"));
			line1.setDatePromised(date1);
			line1.setPrice(priceInThb1);
			line1.saveEx();
			
			MOrderLine line2 = new MOrderLine(order);
			line2.setLine(20);
			line2.setProduct(new MProduct(Env.getCtx(), product2, getTrxName()));
			line2.setQty(new BigDecimal("100"));
			line2.setDatePromised(date1);
			line2.setPrice(priceInThb2);
			line2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			// Purchase Invoice
			MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, date1);
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine1 = new MInvoiceLine(invoice);
			invoiceLine1.setOrderLine(line1);
			invoiceLine1.setQty(new BigDecimal("100"));
			invoiceLine1.saveEx();
			
			MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice);
			invoiceLine2.setOrderLine(line2);
			invoiceLine2.setQty(new BigDecimal("100"));
			invoiceLine2.saveEx();
			
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
						
			// MR
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, date2);
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt); 
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("85"));
			receiptLine1.setQty(new BigDecimal("85"));
			receiptLine1.saveEx();
			
			MInOutLine receiptLine2 = new MInOutLine(receipt);
			receiptLine2.setOrderLine(line2, 0, new BigDecimal("100"));
			receiptLine2.setQty(new BigDecimal("100"));
			receiptLine2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			} 
			
			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
			assertEquals(2, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				} 
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				boolean found = false;
				for (MFactAcct factAcct : factAccts) {
					if (factAcct.getAccount_ID() == acctInvClr.getAccount_ID()) {
						found = true;
						break;
					}
				}
				assertTrue(found);
			}
			
			product1.set_TrxName(getTrxName());
			MCost cost1 = product1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost1, "No MCost record found");			
			assertEquals(new BigDecimal("85").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			product2.set_TrxName(getTrxName());
			MCost cost2 = product2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost2, "No MCost record found");			
			assertEquals(new BigDecimal("100").setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			// MR (Reverse-Correct)
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Correct);
			receipt.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus());
			assertTrue(receipt.getReversal_ID() > 0, "Unexpected reversal id");
			MInOut reversal = new MInOut(Env.getCtx(), receipt.getReversal_ID(), getTrxName());
			assertEquals(receipt.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInOut.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
			assertEquals(4, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				} 
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				boolean found = false;
				for (MFactAcct factAcct : factAccts) {
					if (factAcct.getAccount_ID() == acctInvClr.getAccount_ID()) {
						found = true;
						break;
					}
				}
				assertTrue(found);
			}
			
			product1.set_TrxName(getTrxName());
			cost1 = product1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost1, "No MCost record found");			
			assertEquals(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			product2.set_TrxName(getTrxName());
			cost2 = product2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost2, "No MCost record found");			
			assertEquals(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setM_PriceList_ID(priceList.get_ID());
			order.setC_Currency_ID(thb.get_ID());
			order.setC_ConversionType_ID(C_ConversionType_ID);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateOrdered(date2);
			order.setDateAcct(date2);
			order.setDatePromised(date2);
			order.saveEx();

			line1 = new MOrderLine(order);
			line1.setLine(10);
			line1.setProduct(new MProduct(Env.getCtx(), product1, getTrxName()));
			line1.setQty(new BigDecimal("100"));
			line1.setDatePromised(date1);
			line1.setPrice(priceInThb1);
			line1.saveEx();
			
			line2 = new MOrderLine(order);
			line2.setLine(20);
			line2.setProduct(new MProduct(Env.getCtx(), product2, getTrxName()));
			line2.setQty(new BigDecimal("100"));
			line2.setDatePromised(date1);
			line2.setPrice(priceInThb2);
			line2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			// Purchase Invoice
			invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, date2);
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			invoiceLine1 = new MInvoiceLine(invoice);
			invoiceLine1.setOrderLine(line1);
			invoiceLine1.setQty(new BigDecimal("100"));
			invoiceLine1.saveEx();
			
			invoiceLine2 = new MInvoiceLine(invoice);
			invoiceLine2.setOrderLine(line2);
			invoiceLine2.setQty(new BigDecimal("100"));
			invoiceLine2.saveEx();
			
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
						
			// MR
			receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, date3);
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();

			receiptLine1 = new MInOutLine(receipt);
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("85"));
			receiptLine1.setQty(new BigDecimal("85"));
			receiptLine1.saveEx();
			
			receiptLine2 = new MInOutLine(receipt);
			receiptLine2.setOrderLine(line2, 0, new BigDecimal("100"));
			receiptLine2.setQty(new BigDecimal("100"));
			receiptLine2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
			assertEquals(2, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				boolean found = false;
				for (MFactAcct factAcct : factAccts) {
					if (factAcct.getAccount_ID() == acctInvClr.getAccount_ID()) {
						found = true;
						break;
					}
				}
				assertTrue(found);
			} 
			
			product1.set_TrxName(getTrxName());
			cost1 = product1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost1, "No MCost record found");			
			assertEquals(new BigDecimal("85").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			product2.set_TrxName(getTrxName());
			cost2 = product2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost2, "No MCost record found");			
			assertEquals(new BigDecimal("100").setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			// MR (Reverse-Correct)
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Correct);
			receipt.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus());
			assertTrue(receipt.getReversal_ID() > 0, "Unexpected reversal id");
			reversal = new MInOut(Env.getCtx(), receipt.getReversal_ID(), getTrxName());
			assertEquals(receipt.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInOut.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
			assertEquals(4, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				boolean found = false;
				for (MFactAcct factAcct : factAccts) {
					if (factAcct.getAccount_ID() == acctInvClr.getAccount_ID()) {
						found = true;
						break;
					}
				}
				assertTrue(found);
			}
			
			product1.set_TrxName(getTrxName());
			cost1 = product1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost1, "No MCost record found");			
			assertEquals(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			product2.set_TrxName(getTrxName());
			cost2 = product2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost2, "No MCost record found");			
			assertEquals(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
		}
	}
	
	@Test
	public void testCostAdjustment() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		if (cost == null || cost.getCurrentCostPrice().signum() == 0 || cost.getCurrentQty().signum() == 0) {
			createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		}
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		BigDecimal adjustment = new BigDecimal("0.25");
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
		inventory.setC_Currency_ID(as.getC_Currency_ID());
		inventory.setCostingMethod(as.getCostingMethod());
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		line.setCurrentCostPrice(currentCost);
		line.setNewCostPrice(currentCost.add(adjustment));
		line.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", line.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(adjustment.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.add(adjustment).setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse cost adjustment
		info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Reverse_Accrual);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MInventory reversal = new MInventory(Env.getCtx(), inventory.getReversal_ID(), getTrxName());
		MInventoryLine[] reversalLines = reversal.getLines(true);
		cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversalLines[0].getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(adjustment.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	}
	
	@Test
	public void testPhysicalInventory() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id, null, null);
		MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
		assertNotNull(cost, "No MCost Record");
		BigDecimal currentCost = cost.getCurrentCostPrice();
		
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();
		
		MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		BigDecimal qtyOnHand = MStorageOnHand.getQtyOnHandForLocator(line.getM_Product_ID(), line.getM_Locator_ID(), 0, getTrxName());
		line.setQtyBook(qtyOnHand);
		line.setQtyCount(line.getQtyBook().add(new BigDecimal("1")));
		line.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MCostDetail cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", line.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
		
		//reverse physical inventory
		info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Reverse_Accrual);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, inventory.getDocStatus(), "Unexpected Document Status");
		
		MInventory reversal = new MInventory(Env.getCtx(), inventory.getReversal_ID(), getTrxName());
		MInventoryLine[] reversalLines = reversal.getLines(true);
		cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversalLines[0].getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
		assertNotNull(cd, "MCostDetail not found for internal use line");
		assertEquals(-1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
		assertEquals(currentCost.negate().setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
		cost.load(getTrxName());
		assertEquals(currentCost.setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
	
	}
	
	@Test
	public void testLandedCostForPO() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testLandedCostForPO");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			//create order
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
			line1.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line1.setQty(new BigDecimal("1"));
			line1.setDatePromised(today);
			line1.setPrice(new BigDecimal("2"));
			line1.saveEx();
			
			MOrderLandedCost landedCost = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_Order_ID(order.get_ID());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Costs);
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setAmt(new BigDecimal("0.30"));
			landedCost.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
			receiptLine1.setQty(new BigDecimal("1"));
			receiptLine1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 2, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("2.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("0.30").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(new BigDecimal("2.30"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			//check posting
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> list = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("2.30"), 2, true),
					new FactAcct(nivReceiptAccount, new BigDecimal("2.00"), 2, false), new FactAcct(landedCostAccount, new BigDecimal("0.30"), 2, false));
			assertFactAcctEntries(list, expected);
			
			//reverse receipt
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Reverse_Accrual);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Reversed, receipt1.getDocStatus());
			
			cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 2, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(0, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			//check posting for reversal document
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.getReversal_ID(), as.get_ID(), getTrxName());
			list = query.list();
			expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("2.30"), 2, false),
					new FactAcct(nivReceiptAccount, new BigDecimal("2.00"), 2, true), new FactAcct(landedCostAccount, new BigDecimal("0.30"), 2, true));
			assertFactAcctEntries(list, expected);
		}
	}
	
	@Test
	public void testLandedCostForPOAndInvoice() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testLandedCostForPOAndInvoice");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			//create order
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
			line1.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line1.setQty(new BigDecimal("1"));
			line1.setDatePromised(today);
			line1.setPrice(new BigDecimal("2"));
			line1.saveEx();
			
			MOrderLandedCost landedCost = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_Order_ID(order.get_ID());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Costs);
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setAmt(new BigDecimal("0.30"));
			landedCost.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
			receiptLine1.setQty(new BigDecimal("1"));
			receiptLine1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 2, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("2.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("0.30").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(new BigDecimal("2.30"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> list = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("2.30"), 2, true),
					new FactAcct(nivReceiptAccount, new BigDecimal("2.00"), 2, false), new FactAcct(landedCostAccount, new BigDecimal("0.30"), 2, false));
			assertFactAcctEntries(list, expected);
			
			//invoice for MR
			MInvoice invoice = new MInvoice(receipt1, receipt1.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine1.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
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
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.get_ID(), as.get_ID(), getTrxName());
			list = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, new BigDecimal("2.00"), 2, true),
					new FactAcct(liabilityAccount, new BigDecimal("2.00"), 2, false));
			assertFactAcctEntries(list, expected);
			
			//invoice for landed cost
			MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setBPartner(bp);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setLine(10);
			invoiceLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			invoiceLine.setQty(BigDecimal.ONE);
			invoiceLine.setPrice(new BigDecimal("0.40"));
			invoiceLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			invoiceLine.saveEx();
			
			MLandedCost invoiceLandedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			invoiceLandedCost.setC_InvoiceLine_ID(invoiceLine.get_ID());
			invoiceLandedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			invoiceLandedCost.setM_InOut_ID(receipt1.get_ID());
			invoiceLandedCost.setM_InOutLine_ID(receiptLine1.get_ID());
			invoiceLandedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);		
			invoiceLandedCost.saveEx();			
			String error = invoiceLandedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			doc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount landedCostClearingAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.get_ID(), as.get_ID(), getTrxName());
			list = query.list();
			expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("0.10"), 2, true),
					new FactAcct(landedCostClearingAccount, new BigDecimal("0.30"), 2, true),
					new FactAcct(apAccount, new BigDecimal("0.40"), 2, false));
			assertFactAcctEntries(list, expected);
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(new BigDecimal("2.40"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
		}
	}
	
	@Test
	public void testLandedCostWithNoEstimateForPOAndInvoice() {
		testLandedCostWithNoEstimateForPOAndInvoice(true);
		testLandedCostWithNoEstimateForPOAndInvoice(false);
	}
	public void testLandedCostWithNoEstimateForPOAndInvoice(boolean forProduct) {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testLandedCostWtihNoEstimateForPOAndInvoice");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("2"));
			pp.setPriceList(new BigDecimal("2"));
			pp.saveEx();
			
			//create order
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
			line1.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line1.setQty(new BigDecimal("1"));
			line1.setDatePromised(today);
			line1.setPrice(new BigDecimal("2"));
			line1.saveEx();
						
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
			receiptLine1.setQty(new BigDecimal("1"));
			receiptLine1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(1, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("2.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
			assertEquals(new BigDecimal("2.00"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> list = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("2.00"), 2, true),
					new FactAcct(nivReceiptAccount, new BigDecimal("2.00"), 2, false));
			assertFactAcctEntries(list, expected);
			
			MInvoice invoice = new MInvoice(receipt1, receipt1.getMovementDate());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setM_InOutLine_ID(receiptLine1.get_ID());
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
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
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.get_ID(), as.get_ID(), getTrxName());
			list = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, new BigDecimal("2.00"), 2, true),
					new FactAcct(liabilityAccount, new BigDecimal("2.00"), 2, false));
			assertFactAcctEntries(list, expected);
			
			MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			invoice.setBPartner(bp);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setLine(10);
			invoiceLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			invoiceLine.setQty(BigDecimal.ONE);
			invoiceLine.setPrice(new BigDecimal("0.30"));
			invoiceLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			invoiceLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(invoiceLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			if (forProduct) {
				landedCost.setM_Product_ID(receiptLine1.getM_Product_ID());
				landedCost.setQty(receiptLine1.getMovementQty());				
			} else {
				landedCost.setM_InOut_ID(receipt1.get_ID());
				landedCost.setM_InOutLine_ID(receiptLine1.get_ID());
			}
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);		
			landedCost.saveEx();			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			if (!invoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			invoice.load(getTrxName());
			assertTrue(invoice.isPosted());
			
			doc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, invoice.get_ID(), as.get_ID(), getTrxName());
			list = query.list();
			expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("0.30"), 2, true),
					new FactAcct(apAccount, new BigDecimal("0.30"), 2, false));
			assertFactAcctEntries(list, expected);
			
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(new BigDecimal("2.30"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Reverse_Correct);
			invoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, invoice.getDocStatus());
			
			MInvoice reversal = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), getTrxName());
			assertEquals(invoice.getReversal_ID(), reversal.get_ID(), "Failed to load reversal invoice");
			if (!reversal.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
				reversal.load(getTrxName());
			}
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as.get_ID(), getTrxName());
			list = query.list();
			expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("0.30"), 2, false),
					new FactAcct(apAccount, new BigDecimal("0.30"), 2, true));
			assertFactAcctEntries(list, expected);
			
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(new BigDecimal("2.00"), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
		}
	}

	private void mockProductGet(MockedStatic<MProduct> productMock, MProduct product) {
		productMock.when(() -> MProduct.getCopy(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()))).thenReturn(product);
	}
	
	@Test
	public void testUnplannedLandedCostWtihMultipleMRAndShipment() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostWtihMultipleMRAndShipment1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("36.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testUnplannedLandedCostWtihMultipleMRAndShipment2");
			p2.setProductType(MProduct.PRODUCTTYPE_Item);
			p2.setIsStocked(true);
			p2.setIsSold(true);
			p2.setIsPurchased(true);
			p2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p2.saveEx();
			
			mockProductGet(productMock, p2);
			
			pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p2.get_ID());
			BigDecimal p2price = new BigDecimal("50.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("100");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(10);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(today);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
						
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//mr1 for 10 each
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receipt1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1Qty = new BigDecimal("10");
			receipt1Line1.setOrderLine(poLine1, 0, mr1Qty);
			receipt1Line1.setQty(mr1Qty);
			receipt1Line1.saveEx();
			
			MInOutLine receipt1Line2 = new MInOutLine(receipt1);
			receipt1Line2.setOrderLine(poLine2, 0, mr1Qty);
			receipt1Line2.setQty(mr1Qty);
			receipt1Line2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price, p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//assert p2 cost and posting
			cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line2");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p2price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p2.set_TrxName(getTrxName());
			MCost p2mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p2mcost, "No MCost record found");			
			assertEquals(p2price, p2mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p2ProductCost = new ProductCost(Env.getCtx(), p2.get_ID(), 0, getTrxName());
			assetAccount = p2ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			expected = Arrays.asList(new FactAcct(assetAccount, p2price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p2price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//mr2 for 90 each
			MInOut receipt2 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine receipt2Line1 = new MInOutLine(receipt2);
			BigDecimal mr2Qty = new BigDecimal("90");
			receipt2Line1.setOrderLine(poLine1, 0, mr2Qty);
			receipt2Line1.setQty(mr2Qty);
			receipt2Line1.saveEx();
			
			MInOutLine receipt2Line2 = new MInOutLine(receipt2);
			receipt2Line2.setOrderLine(poLine2, 0, mr2Qty);
			receipt2Line2.setQty(mr2Qty);
			receipt2Line2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt2.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//full po invoice
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(purchaseInvoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(10);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty), 2, true),
					new FactAcct(inventoryClearingAccount, p2price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty).add(p2price.multiply(orderQty)), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//so and shipment
			MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MOrder salesOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			salesOrder.setBPartner(customer);
			salesOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			salesOrder.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder.setDocAction(DocAction.ACTION_Complete);
			salesOrder.setDatePromised(today);
			salesOrder.saveEx();
			
			MOrderLine soLine1 = new MOrderLine(salesOrder);
			soLine1.setLine(10);
			soLine1.setProduct(p1);
			BigDecimal p1ShipQty = new BigDecimal("76");
			soLine1.setQty(p1ShipQty);
			soLine1.setDatePromised(today);
			soLine1.setPrice(new BigDecimal("50"));
			soLine1.saveEx();
			
			MOrderLine soLine2 = new MOrderLine(salesOrder);
			soLine2.setLine(20);
			soLine2.setProduct(p2);
			BigDecimal p2ShipQty = new BigDecimal("82");
			soLine2.setQty(p2ShipQty);
			soLine2.setDatePromised(today);
			soLine2.setPrice(new BigDecimal("70"));
			soLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(salesOrder, DocAction.ACTION_Complete);
			salesOrder.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder.getDocStatus());
			
			MInOut shipment = new MInOut(salesOrder, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine1 = new MInOutLine(shipment);
			shipmentLine1.setOrderLine(soLine1, 0, soLine1.getQtyOrdered());
			shipmentLine1.setQty(soLine1.getQtyOrdered());
			shipmentLine1.saveEx();
			
			MInOutLine shipmentLine2 = new MInOutLine(shipment);
			shipmentLine2.setOrderLine(soLine2, 0, soLine2.getQtyOrdered());
			shipmentLine2.setQty(soLine2.getQtyOrdered());
			shipmentLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("1000.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line2.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt2.get_ID());
			landedCost.setM_InOutLine_ID(receipt2Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt2.get_ID());
			landedCost.setM_InOutLine_ID(receipt2Line2.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal totalBase = purchaseInvoice.getGrandTotal();
			BigDecimal p1a1 =  p1price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p1a2 =  p1price.multiply(mr2Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p2a1 =  p2price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p2a2 =  p2price.multiply(mr2Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(4, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 10) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 90) {					
					assertEquals(p1a2.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p2.get_ID() && allocation.getQty().intValue() == 10) {					
					assertEquals(p2a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p2.get_ID() && allocation.getQty().intValue() == 90) {					
					assertEquals(p2a2.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			BigDecimal p1QtyOnHand = orderQty.subtract(p1ShipQty);
			BigDecimal p2QtyOnHand = orderQty.subtract(p2ShipQty);
			BigDecimal p1a1Qty = mr1Qty;
			BigDecimal p1a2Qty = p1QtyOnHand.subtract(p1a1Qty);
			BigDecimal p2a1Qty = mr1Qty;
			BigDecimal p2a2Qty = p2QtyOnHand.subtract(p2a1Qty);
			MAccount varianceAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			BigDecimal p1a2Asset = p1a2.divide(mr2Qty, RoundingMode.HALF_UP).multiply(p1a2Qty);
			BigDecimal p2a2Asset = p2a2.divide(mr2Qty, RoundingMode.HALF_UP).multiply(p2a2Qty);
			expected = Arrays.asList(new FactAcct(assetAccount, p1a1, 2, true),
					new FactAcct(assetAccount, p2a1, 2, true),
					new FactAcct(assetAccount, p1a2Asset, 2, true),
					new FactAcct(varianceAccount, p1a2.subtract(p1a2Asset), 0, true),
					new FactAcct(assetAccount, p2a2Asset, 2, true),
					new FactAcct(varianceAccount, p2a2.subtract(p2a2Asset), 0, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.add(p1a1.divide(p1QtyOnHand, 2, RoundingMode.HALF_UP))
					.add(p1a2Asset.divide(p1QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			p1mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p2price.add(p2a1.divide(p2QtyOnHand, 2, RoundingMode.HALF_UP))
					.add(p2a2Asset.divide(p2QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");
		}
	}
	
	@Test
	public void testUnplannedLandedCostReversal() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostReversal1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("30.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testUnplannedLandedCostReversal2");
			p2.setProductType(MProduct.PRODUCTTYPE_Item);
			p2.setIsStocked(true);
			p2.setIsSold(true);
			p2.setIsPurchased(true);
			p2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p2.saveEx();
			
			mockProductGet(productMock, p2);
			
			pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p2.get_ID());
			BigDecimal p2price = new BigDecimal("50.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("10");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(10);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(today);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
						
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//mr1 for 10 each
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receipt1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1Qty = new BigDecimal("10");
			receipt1Line1.setOrderLine(poLine1, 0, mr1Qty);
			receipt1Line1.setQty(mr1Qty);
			receipt1Line1.saveEx();
			
			MInOutLine receipt1Line2 = new MInOutLine(receipt1);
			receipt1Line2.setOrderLine(poLine2, 0, mr1Qty);
			receipt1Line2.setQty(mr1Qty);
			receipt1Line2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price, p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//assert p2 cost and posting
			cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line2");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p2price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p2.set_TrxName(getTrxName());
			MCost p2mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p2mcost, "No MCost record found");			
			assertEquals(p2price, p2mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p2ProductCost = new ProductCost(Env.getCtx(), p2.get_ID(), 0, getTrxName());
			assetAccount = p2ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			expected = Arrays.asList(new FactAcct(assetAccount, p2price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p2price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//full po invoice
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(purchaseInvoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(10);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty), 2, true),
					new FactAcct(inventoryClearingAccount, p2price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty).add(p2price.multiply(orderQty)), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("200.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line2.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal totalBase = purchaseInvoice.getGrandTotal();
			BigDecimal p1a1 =  p1price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p2a1 =  p2price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(2, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 10) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p2.get_ID() && allocation.getQty().intValue() == 10) {					
					assertEquals(p2a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			BigDecimal p1QtyOnHand = mr1Qty;
			BigDecimal p2QtyOnHand = mr1Qty;					
			expected = Arrays.asList(new FactAcct(assetAccount, p1a1, 2, true),
					new FactAcct(assetAccount, p2a1, 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.add(p1a1.divide(p1QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			p1mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p2price.add(p2a1.divide(p2QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			//reverse freight invoice
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Correct);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, freightInvoice.getDocStatus());
			assertTrue(freightInvoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), freightInvoice.getReversal_ID(), getTrxName());
			assertEquals(freightInvoice.getReversal_ID(), reversal.get_ID());
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
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

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
			if (optional.isPresent()) {
				MAcctSchema as2 = optional.get();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as2.get_ID(), getTrxName());
				factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as2.get_ID(), getTrxName());
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
	}
	
	@Test
	public void testUnplannedLandedCostAPCreditMemo() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostAPCreditMemo");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("5.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("10");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//mr1 for 10 each
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receipt1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1Qty = new BigDecimal("10");
			receipt1Line1.setOrderLine(poLine1, 0, mr1Qty);
			receipt1Line1.setQty(mr1Qty);
			receipt1Line1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price, p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("100.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal p1a1 =  fiLine.getLineNetAmt();
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(1, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 10) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			BigDecimal p1QtyOnHand = mr1Qty;
			expected = Arrays.asList(new FactAcct(assetAccount, p1a1, 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.add(p1a1.divide(p1QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			//ap credit memo for landed cost
			MInvoice freightCreditMemo = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightCreditMemo.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APCreditMemo);
			freightCreditMemo.setBPartner(freightBP);
			freightCreditMemo.setDocStatus(DocAction.STATUS_Drafted);
			freightCreditMemo.setDocAction(DocAction.ACTION_Complete);
			freightCreditMemo.saveEx();
			
			MInvoiceLine cmLine = new MInvoiceLine(freightCreditMemo);
			cmLine.setLine(10);
			cmLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			cmLine.setQty(BigDecimal.ONE);
			cmLine.setPrice(freightPrice);
			cmLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			cmLine.saveEx();
			
			MLandedCost landedCostCM = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCostCM.setC_InvoiceLine_ID(cmLine.get_ID());
			landedCostCM.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCostCM.setM_InOut_ID(receipt1.get_ID());
			landedCostCM.setM_InOutLine_ID(receipt1Line1.get_ID());
			landedCostCM.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);		
			landedCostCM.saveEx();
			
			error = landedCostCM.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			MLandedCostAllocation[] allocationsCM = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(1, allocationsCM.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocationsCM) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 10) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightCreditMemo, DocAction.ACTION_Complete);
			freightCreditMemo.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightCreditMemo.getDocStatus());
			
			if (!freightCreditMemo.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightCreditMemo.getAD_Client_ID(), MInvoice.Table_ID, freightCreditMemo.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightCreditMemo.load(getTrxName());
			assertTrue(freightCreditMemo.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightCreditMemo.get_ID(), getTrxName());
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightCreditMemo.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(assetAccount, p1a1, 2, false),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, true));
			assertFactAcctEntries(factAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");
		}
	}
	
	@Test
	public void testUnplannedLandedCostReversalAfterShipment1() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostReversalAfterShipment1.1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("30.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testUnplannedLandedCostReversalAfterShipment1.2");
			p2.setProductType(MProduct.PRODUCTTYPE_Item);
			p2.setIsStocked(true);
			p2.setIsSold(true);
			p2.setIsPurchased(true);
			p2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p2.saveEx();
			
			mockProductGet(productMock, p2);
			
			pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p2.get_ID());
			BigDecimal p2price = new BigDecimal("50.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("10");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(10);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(today);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
						
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//mr1 for 10 each
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receipt1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1Qty = new BigDecimal("10");
			receipt1Line1.setOrderLine(poLine1, 0, mr1Qty);
			receipt1Line1.setQty(mr1Qty);
			receipt1Line1.saveEx();
			
			MInOutLine receipt1Line2 = new MInOutLine(receipt1);
			receipt1Line2.setOrderLine(poLine2, 0, mr1Qty);
			receipt1Line2.setQty(mr1Qty);
			receipt1Line2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price, p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//assert p2 cost and posting
			cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line2");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p2price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p2.set_TrxName(getTrxName());
			MCost p2mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p2mcost, "No MCost record found");			
			assertEquals(p2price, p2mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p2ProductCost = new ProductCost(Env.getCtx(), p2.get_ID(), 0, getTrxName());
			assetAccount = p2ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			expected = Arrays.asList(new FactAcct(assetAccount, p2price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p2price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//full po invoice
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(purchaseInvoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(10);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty), 2, true),
					new FactAcct(inventoryClearingAccount, p2price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty).add(p2price.multiply(orderQty)), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("200.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line2.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal totalBase = purchaseInvoice.getGrandTotal();
			BigDecimal p1a1 =  p1price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p2a1 =  p2price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(2, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 10) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p2.get_ID() && allocation.getQty().intValue() == 10) {					
					assertEquals(p2a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			BigDecimal p1QtyOnHand = mr1Qty;
			BigDecimal p2QtyOnHand = mr1Qty;					
			expected = Arrays.asList(new FactAcct(assetAccount, p1a1, 2, true),
					new FactAcct(assetAccount, p2a1, 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.add(p1a1.divide(p1QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			p2mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p2price.add(p2a1.divide(p2QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p2mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			//so and shipment
			MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MOrder salesOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			salesOrder.setBPartner(customer);
			salesOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			salesOrder.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder.setDocAction(DocAction.ACTION_Complete);
			salesOrder.setDatePromised(today);
			salesOrder.saveEx();
			
			MOrderLine soLine1 = new MOrderLine(salesOrder);
			soLine1.setLine(10);
			soLine1.setProduct(p1);
			BigDecimal p1ShipQty = new BigDecimal("10");
			soLine1.setQty(p1ShipQty);
			soLine1.setDatePromised(today);
			soLine1.setPrice(new BigDecimal("50"));
			soLine1.saveEx();
			
			MOrderLine soLine2 = new MOrderLine(salesOrder);
			soLine2.setLine(20);
			soLine2.setProduct(p2);
			BigDecimal p2ShipQty = new BigDecimal("5");
			soLine2.setQty(p2ShipQty);
			soLine2.setDatePromised(today);
			soLine2.setPrice(new BigDecimal("70"));
			soLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(salesOrder, DocAction.ACTION_Complete);
			salesOrder.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder.getDocStatus());
			
			MInOut shipment = new MInOut(salesOrder, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine1 = new MInOutLine(shipment);
			shipmentLine1.setOrderLine(soLine1, 0, soLine1.getQtyOrdered());
			shipmentLine1.setQty(soLine1.getQtyOrdered());
			shipmentLine1.saveEx();
			
			MInOutLine shipmentLine2 = new MInOutLine(shipment);
			shipmentLine2.setOrderLine(soLine2, 0, soLine2.getQtyOrdered());
			shipmentLine2.setQty(soLine2.getQtyOrdered());
			shipmentLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
						
			//reverse freight invoice
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Correct);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, freightInvoice.getDocStatus());
			assertTrue(freightInvoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), freightInvoice.getReversal_ID(), getTrxName());
			assertEquals(freightInvoice.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
			expected = Arrays.asList(new FactAcct(assetAccount, p1a1, 2, false),
					new FactAcct(assetAccount, p2a1, 2, false),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, true));
			assertFactAcctEntries(rFactAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			p2mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			
			BigDecimal p1cogs = p1mcost.getCurrentCostPrice().multiply(p1ShipQty);
			BigDecimal p2cogs = p2mcost.getCurrentCostPrice().multiply(p2ShipQty);
			
			ProductCost pc1 = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount cogsAccount1 = pc1.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			ProductCost pc2 = new ProductCost(Env.getCtx(), p2.get_ID(), 0, getTrxName());
			MAccount cogsAccount2 = pc2.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount1, p1cogs, 2, true),
					new FactAcct(cogsAccount2, p2cogs, 2, true),
					new FactAcct(assetAccount, p1cogs, 2, false),
					new FactAcct(assetAccount, p2cogs, 2, false));
			assertFactAcctEntries(factAccts, expected);
		}
	}
	
	@Test
	public void testUnplannedLandedCostReversalAfterShipment3() {
		testUnplannedLandedCostReversalAfterShipment3(true);
		testUnplannedLandedCostReversalAfterShipment3(false);
	}
	public void testUnplannedLandedCostReversalAfterShipment3(boolean forProduct) {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); 
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); 
		Timestamp today = TimeUtil.getDay(null);		
		Timestamp tomorrow = TimeUtil.addDays(today, 1);
		BigDecimal crate1 = new BigDecimal("1.05");
		BigDecimal crate2 = new BigDecimal("1.12");
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic()) {
			mockGetRate(conversionRateMock, euro, usd, 0, today, crate1);
			mockGetRate(conversionRateMock, euro, usd, 0, tomorrow, crate2);
			
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostReversalAfterShipment3");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.IMPORT.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("30.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.setM_PriceList_ID(plv.getM_PriceList_ID());
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("100");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//material receipt
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receipt1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1Qty = new BigDecimal("100");
			receipt1Line1.setOrderLine(poLine1, 0, mr1Qty);
			receipt1Line1.setQty(mr1Qty);
			receipt1Line1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(mr1Qty.intValue(), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Qty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price.multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1Qty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1Qty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//PO invoice 
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty).multiply(crate1), p1price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty).multiply(crate1), p1price.multiply(orderQty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//so and shipment
			plv = MPriceList.get(DictionaryIDs.M_PriceList.EXPORT.id).getPriceListVersion(null);
			pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal orderPrice = new BigDecimal("100.00");
			pp.setPriceStd(orderPrice);
			pp.setPriceList(orderPrice);
			pp.saveEx();
			
			MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MOrder salesOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			salesOrder.setBPartner(customer);
			salesOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			salesOrder.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder.setDocAction(DocAction.ACTION_Complete);
			salesOrder.setDatePromised(today);
			salesOrder.setM_PriceList_ID(DictionaryIDs.M_PriceList.EXPORT.id);
			salesOrder.saveEx();
			
			MOrderLine soLine1 = new MOrderLine(salesOrder);
			soLine1.setLine(10);
			soLine1.setProduct(p1);
			BigDecimal p1ShipQty = new BigDecimal("80");
			soLine1.setQty(p1ShipQty);
			soLine1.setDatePromised(today);			 
			soLine1.setPrice(orderPrice);
			soLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(salesOrder, DocAction.ACTION_Complete);
			salesOrder.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder.getDocStatus());
			
			MInOut shipment = new MInOut(salesOrder, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine1 = new MInOutLine(shipment);
			shipmentLine1.setOrderLine(soLine1, 0, soLine1.getQtyOrdered());
			shipmentLine1.setQty(soLine1.getQtyOrdered());
			shipmentLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.setM_PriceList_ID(DictionaryIDs.M_PriceList.EXPORT.id);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("200.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			if (forProduct) {
				landedCost.setM_Product_ID(receipt1Line1.getM_Product_ID());
				landedCost.setQty(receipt1Line1.getMovementQty());				
			} else {
				landedCost.setM_InOut_ID(receipt1.get_ID());
				landedCost.setM_InOutLine_ID(receipt1Line1.get_ID());
			}
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal p1a1 =  fiLine.getLineTotalAmt();
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(1, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == orderQty.intValue()) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			BigDecimal assetAmt = p1a1.divide(orderQty, RoundingMode.HALF_UP).multiply(orderQty.subtract(p1ShipQty));
			BigDecimal varianceAmt = p1a1.subtract(assetAmt);
			expected = Arrays.asList(new FactAcct(varianceAccount, varianceAmt.multiply(crate1), varianceAmt, 2, true),
					new FactAcct(assetAccount, assetAmt.multiply(crate1), assetAmt, 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal().multiply(crate1), freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.multiply(crate1).add(assetAmt.multiply(crate1).divide(orderQty.subtract(p1ShipQty), RoundingMode.HALF_UP)).setScale(2, RoundingMode.HALF_UP), 
					p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			//reverse freight invoice
			Env.setContext(Env.getCtx(), Env.DATE, tomorrow);
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Correct);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, freightInvoice.getDocStatus());
			assertTrue(freightInvoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), freightInvoice.getReversal_ID(), getTrxName());
			assertEquals(freightInvoice.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
			expected = new ArrayList<FactAcct>();
			for(MFactAcct factAcct : factAccts) {
				MAccount acct = MAccount.get(factAcct, getTrxName());
				if (factAcct.getAmtAcctDr().signum() != 0) {
					expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 1, false));
				} else if (factAcct.getAmtAcctCr().signum() != 0) {
					expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 1, true));
				}
			}
			assertFactAcctEntries(rFactAccts, expected);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
			if (optional.isPresent()) {
				MAcctSchema as2 = optional.get();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as2.get_ID(), getTrxName());
				factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.getReversal_ID(), as2.get_ID(), getTrxName());
				rFactAccts = query.list();
				expected = new ArrayList<FactAcct>();
				for(MFactAcct factAcct : factAccts) {
					MAccount acct = MAccount.get(factAcct, getTrxName());
					if (factAcct.getAmtAcctDr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 1, false));
					} else if (factAcct.getAmtAcctCr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 1, true));
					}
				}
				assertFactAcctEntries(rFactAccts, expected);
			}
		}
	}
	
	@Test
	public void testUnplannedLandedCostReversalAfterShipment2() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); 
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); 
		Timestamp today = TimeUtil.getDay(null);		
		Timestamp tomorrow = TimeUtil.addDays(today, 1);
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic()) {
			mockGetRate(conversionRateMock, usd, euro, 0, today, new BigDecimal("0.91"));
			mockGetRate(conversionRateMock, usd, euro, 0, tomorrow, new BigDecimal("0.85"));
			
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostReversalAfterShipment2.1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("30.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, 	getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testUnplannedLandedCostReversalAfterShipment2.2");
			p2.setProductType(MProduct.PRODUCTTYPE_Item);
			p2.setIsStocked(true);
			p2.setIsSold(true);
			p2.setIsPurchased(true);
			p2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p2.saveEx();
			
			mockProductGet(productMock, p2);
			
			pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p2.get_ID());
			BigDecimal p2price = new BigDecimal("50.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("10");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(10);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(today);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
						
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//mr1 for 10 each
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receipt1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1Qty = new BigDecimal("10");
			receipt1Line1.setOrderLine(poLine1, 0, mr1Qty);
			receipt1Line1.setQty(mr1Qty);
			receipt1Line1.saveEx();
			
			MInOutLine receipt1Line2 = new MInOutLine(receipt1);
			receipt1Line2.setOrderLine(poLine2, 0, mr1Qty);
			receipt1Line2.setQty(mr1Qty);
			receipt1Line2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price, p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//assert p2 cost and posting
			cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line2");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p2price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p2.set_TrxName(getTrxName());
			MCost p2mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p2mcost, "No MCost record found");			
			assertEquals(p2price, p2mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p2ProductCost = new ProductCost(Env.getCtx(), p2.get_ID(), 0, getTrxName());
			assetAccount = p2ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			expected = Arrays.asList(new FactAcct(assetAccount, p2price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p2price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//full po invoice
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(purchaseInvoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(10);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty), 2, true),
					new FactAcct(inventoryClearingAccount, p2price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty).add(p2price.multiply(orderQty)), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//so and shipment
			MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MOrder salesOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			salesOrder.setBPartner(customer);
			salesOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			salesOrder.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder.setDocAction(DocAction.ACTION_Complete);
			salesOrder.setDatePromised(today);
			salesOrder.saveEx();
			
			MOrderLine soLine1 = new MOrderLine(salesOrder);
			soLine1.setLine(10);
			soLine1.setProduct(p1);
			BigDecimal p1ShipQty = new BigDecimal("10");
			soLine1.setQty(p1ShipQty);
			soLine1.setDatePromised(today);
			soLine1.setPrice(new BigDecimal("50"));
			soLine1.saveEx();
			
			MOrderLine soLine2 = new MOrderLine(salesOrder);
			soLine2.setLine(20);
			soLine2.setProduct(p2);
			BigDecimal p2ShipQty = new BigDecimal("5");
			soLine2.setQty(p2ShipQty);
			soLine2.setDatePromised(today);
			soLine2.setPrice(new BigDecimal("70"));
			soLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(salesOrder, DocAction.ACTION_Complete);
			salesOrder.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder.getDocStatus());
			
			MInOut shipment = new MInOut(salesOrder, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine1 = new MInOutLine(shipment);
			shipmentLine1.setOrderLine(soLine1, 0, soLine1.getQtyOrdered());
			shipmentLine1.setQty(soLine1.getQtyOrdered());
			shipmentLine1.saveEx();
			
			MInOutLine shipmentLine2 = new MInOutLine(shipment);
			shipmentLine2.setOrderLine(soLine2, 0, soLine2.getQtyOrdered());
			shipmentLine2.setQty(soLine2.getQtyOrdered());
			shipmentLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("200.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(receipt1Line2.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal totalBase = purchaseInvoice.getGrandTotal();
			BigDecimal p1a1 =  p1price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p2a1 =  p2price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(2, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 10) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p2.get_ID() && allocation.getQty().intValue() == 10) {					
					assertEquals(p2a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, p1a1, 2, true),
					new FactAcct(assetAccount, p2a1.divide(new BigDecimal("2"), RoundingMode.HALF_UP), 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.setScale(1, RoundingMode.HALF_UP), 
					p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			p1mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p2price.add(p2a1.divide(new BigDecimal("2"), 2, RoundingMode.HALF_UP).divide(new BigDecimal("5"), RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			//reverse freight invoice
			Env.setContext(Env.getCtx(), Env.DATE, tomorrow);
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Correct);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, freightInvoice.getDocStatus());
			assertTrue(freightInvoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), freightInvoice.getReversal_ID(), getTrxName());
			assertEquals(freightInvoice.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, p1a1, 2, false),
					new FactAcct(assetAccount, p2a1.divide(new BigDecimal(2), RoundingMode.HALF_UP), 2, false),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, true));
			assertFactAcctEntries(rFactAccts, expected);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
			if (optional.isPresent()) {
				MAcctSchema as2 = optional.get();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as2.get_ID(), getTrxName());
				factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.getReversal_ID(), as2.get_ID(), getTrxName());
				rFactAccts = query.list();
				expected = new ArrayList<FactAcct>();
				for(MFactAcct factAcct : factAccts) {
					MAccount acct = MAccount.get(factAcct, getTrxName());
					if (factAcct.getAmtAcctDr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 1, false));
					} else if (factAcct.getAmtAcctCr().signum() != 0) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 1, true));
					}
				}
				assertFactAcctEntries(rFactAccts, expected);
			}
		}
	}
	
	@Test	
	public void testUnplannedLandedCostReversalAfterInventoryUseASI() {

		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); 
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); 
		Timestamp today = TimeUtil.getDay(null);		
		Timestamp tomorrow = TimeUtil.addDays(today, 1);
		BigDecimal crate1 = new BigDecimal("1.05");
		BigDecimal crate2 = new BigDecimal("1.12");
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic()) {
			mockGetRate(conversionRateMock, euro, usd, 0, today, crate1);
			mockGetRate(conversionRateMock, euro, usd, 0, tomorrow, crate2);
			
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostReversalAfterInventoryUseASI.1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.IMPORT.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("30.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testUnplannedLandedCostReversalAfterInventoryUseASI.2");
			p2.setProductType(MProduct.PRODUCTTYPE_Item);
			p2.setIsStocked(true);
			p2.setIsSold(true);
			p2.setIsPurchased(true);
			p2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p2.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			p2.saveEx();
			
			mockProductGet(productMock, p2);
			
			pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p2.get_ID());
			BigDecimal p2price = new BigDecimal("50.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.setM_PriceList_ID(plv.getM_PriceList_ID());
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("100");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(10);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(today);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//material receipt 1
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine mr1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1l1Qty = new BigDecimal("25");
			mr1Line1.setOrderLine(poLine1, 0, mr1l1Qty);
			mr1Line1.setQty(mr1l1Qty);
			MAttributeSetInstance mr1l1asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			mr1l1asi.setM_AttributeSet_ID(p1.getM_AttributeSet_ID());
			mr1l1asi.setLot("mr1l1asi");
			mr1l1asi.setDescription();
			mr1l1asi.saveEx();
			mr1Line1.setM_AttributeSetInstance_ID(mr1l1asi.get_ID());
			mr1Line1.saveEx();
			
			MInOutLine mr1Line2 = new MInOutLine(receipt1);
			BigDecimal mr1l2Qty = new BigDecimal("100");
			mr1Line2.setOrderLine(poLine2, 0, mr1l2Qty);
			mr1Line2.setQty(mr1l2Qty);
			MAttributeSetInstance mr1l2asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			mr1l2asi.setM_AttributeSet_ID(p2.getM_AttributeSet_ID());
			mr1l2asi.setLot("mr1l2asi");
			mr1l2asi.setDescription();
			mr1l2asi.saveEx();
			mr1Line2.setM_AttributeSetInstance_ID(mr1l2asi.get_ID());
			mr1Line2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//material receipt 2
			MInOut receipt2 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine mr2Line1 = new MInOutLine(receipt2);
			BigDecimal mr2l1Qty = new BigDecimal("75");
			mr2Line1.setOrderLine(poLine1, 0, mr2l1Qty);
			mr2Line1.setQty(mr2l1Qty);
			MAttributeSetInstance mr2l1asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			mr2l1asi.setM_AttributeSet_ID(p1.getM_AttributeSet_ID());
			mr2l1asi.setLot("mr2l1asi");
			mr2l1asi.setDescription();
			mr2l1asi.saveEx();
			mr2Line1.setM_AttributeSetInstance_ID(mr2l1asi.get_ID());
			mr2Line1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt2.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), mr1l1asi.get_ID(), as.get_ID(), getTrxName());
			assertEquals(1, cds.size(), "Unexpected number of MCostDetail records for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(mr1Line1.getMovementQty().intValue(), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Line1.getMovementQty()).multiply(crate1).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			//assert p1 mcost
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price.multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1l1Qty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1price.multiply(mr1l1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1l1Qty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1price.multiply(mr1l1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//PO invoice 
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(purchaseInvoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(20);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty).multiply(crate1), p1price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty).multiply(crate1).add(p2price.multiply(orderQty).multiply(crate1)), 
							p1price.multiply(orderQty).add(p2price.multiply(orderQty)), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//inventory decrease
			MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
			inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			inventory.setMovementDate(today);
			inventory.saveEx();
			
			MInventoryLine inventoryLine1 = new MInventoryLine(inventory, DictionaryIDs.M_Locator.HQ.id, p1.get_ID(), 0, null, null, new BigDecimal("25"));
			inventoryLine1.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			inventoryLine1.setM_AttributeSetInstance_ID(mr2l1asi.get_ID());
			inventoryLine1.saveEx();
			MInventoryLine inventoryLine2 = new MInventoryLine(inventory, DictionaryIDs.M_Locator.HQ.id, p2.get_ID(), 0, null, null, new BigDecimal("100"));
			inventoryLine2.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			inventoryLine2.setM_AttributeSetInstance_ID(mr1l2asi.get_ID());
			inventoryLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			inventory.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
			if (!inventory.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), inventory.getAD_Client_ID(), inventory.get_Table_ID(), inventory.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("1000.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(mr1Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(mr1Line2.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(mr2Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal totalBase = purchaseOrder.getGrandTotal();			
			BigDecimal p1a1 = p1price.multiply(mr1l1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p1a2 = p1price.multiply(mr2l1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p2a1 = p2price.multiply(mr1l2Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(3, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == mr1l1Qty.intValue()) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == mr2l1Qty.intValue()) {
					assertEquals(p1a2.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p2.get_ID() && allocation.getQty().intValue() == mr1l2Qty.intValue()) {
					assertEquals(p2a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			BigDecimal p1OnHand = orderQty.add(inventoryLine1.getMovementQty());
			BigDecimal p1a1assetAmt = p1a1;
			BigDecimal p1a2assetAmt = p1a2.divide(mr2l1Qty, RoundingMode.HALF_UP).multiply(p1OnHand.subtract(mr1l1Qty));
			BigDecimal p1a2varianceAmt = p1a2.subtract(p1a2assetAmt);
			BigDecimal p2varianceAmt = p2a1;
			expected = Arrays.asList(new FactAcct(varianceAccount, p1a2varianceAmt, p1a2varianceAmt, 2, true),
					new FactAcct(assetAccount, p1a1assetAmt, p1a1assetAmt, 2, true),
					new FactAcct(assetAccount, p1a2assetAmt, p1a2assetAmt, 2, true),
					new FactAcct(varianceAccount, p2varianceAmt, p2varianceAmt, 2, true),
					new FactAcct(varianceAccount, p1a2varianceAmt, p1a2varianceAmt, 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			BigDecimal p1assetAmt = p1a1assetAmt.add(p1a2assetAmt);
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.multiply(crate1).add(p1assetAmt.divide(p1OnHand, RoundingMode.HALF_UP)).setScale(2, RoundingMode.HALF_UP), 
					p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			//reverse freight invoice
			Env.setContext(Env.getCtx(), Env.DATE, tomorrow);
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Correct);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, freightInvoice.getDocStatus());
			assertTrue(freightInvoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), freightInvoice.getReversal_ID(), getTrxName());
			assertEquals(freightInvoice.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
			expected = new ArrayList<FactAcct>();
			for(MFactAcct factAcct : factAccts) {
				MAccount acct = MAccount.get(factAcct, getTrxName());
				if (factAcct.getAmtAcctDr().signum() != 0) {
					FactAcct fa = null;
					for (FactAcct t : expected) {
						if (t.account().getAccount_ID() == acct.getAccount_ID() &&
							t.account().getM_Product_ID() == acct.getM_Product_ID() &&
							t.debit() == false) {
							fa = t;
							break;
						}
					}
					if (fa == null) { 
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 1, false));
					} else {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr().add(fa.accountedAmount()), 1, false));
						expected.remove(fa);
					}
				} else if (factAcct.getAmtAcctCr().signum() != 0) {
					FactAcct fa = null;
					for (FactAcct t : expected) {
						if (t.account().getAccount_ID() == acct.getAccount_ID() &&
							t.account().getM_Product_ID() == acct.getM_Product_ID() &&
							t.debit() == true) {
							fa = t;
							break;
						}
					}
					if (fa == null) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 1, true));
					} else {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr().add(fa.accountedAmount()), 1, true));
						expected.remove(fa);
					}
				}
				
				//assert reversal allocation generate no entries
				MAllocationHdr[] allocationHdrs = MAllocationHdr.getOfInvoice(Env.getCtx(), freightInvoice.getC_Invoice_ID(), getTrxName());
				assertEquals(1, allocationHdrs.length, "Unexpected number of allocations for freight invoice");
				if (!allocationHdrs[0].isPosted()) {
					String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MAllocationHdr.Table_ID, allocationHdrs[0].get_ID(), false, getTrxName());
					assertNull(msg, msg);
				}
				assertTrue(allocationHdrs[0].isPosted(), "Allocation of freight invoice not posted");
				query = MFactAcct.createRecordIdQuery(MAllocationHdr.Table_ID, allocationHdrs[0].get_ID(), as.get_ID(), getTrxName());
				factAccts = query.list();
				assertEquals(0, factAccts.size(), "Unexpected number of fact entries generated by invoice reversal allocation");
			}
			assertFactAcctEntries(rFactAccts, expected);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
			if (optional.isPresent()) {
				MAcctSchema as2 = optional.get();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as2.get_ID(), getTrxName());
				factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.getReversal_ID(), as2.get_ID(), getTrxName());
				rFactAccts = query.list();
				expected = new ArrayList<FactAcct>();
				for(MFactAcct factAcct : factAccts) {
					MAccount acct = MAccount.get(factAcct, getTrxName());
					if (factAcct.getAmtAcctDr().signum() != 0) {
						FactAcct fa = null;
						for (FactAcct t : expected) {
							if (t.account().getAccount_ID() == acct.getAccount_ID() &&
								t.account().getM_Product_ID() == acct.getM_Product_ID() &&
								t.debit() == false) {
								fa = t;
								break;
							}
						}
						if (fa == null) { 
							expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 1, false));
						} else {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctDr().add(fa.accountedAmount()), 1, false));
							expected.remove(fa);
						}
					} else if (factAcct.getAmtAcctCr().signum() != 0) {
						FactAcct fa = null;
						for (FactAcct t : expected) {
							if (t.account().getAccount_ID() == acct.getAccount_ID() &&
								t.account().getM_Product_ID() == acct.getM_Product_ID() &&
								t.debit() == true) {
								fa = t;
								break;
							}
						}
						if (fa == null) {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 1, true));
						} else {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctCr().add(fa.accountedAmount()), 1, true));
							expected.remove(fa);
						}
					}				
				}
				assertFactAcctEntries(rFactAccts, expected);
			}
		}		
	}
	
	@Test
	public void testUnplannedLandedCostReversalAfterInventoryUse() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); 
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); 
		Timestamp today = TimeUtil.getDay(null);		
		Timestamp tomorrow = TimeUtil.addDays(today, 1);
		BigDecimal crate1 = new BigDecimal("1.05");
		BigDecimal crate2 = new BigDecimal("1.12");
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic()) {
			mockGetRate(conversionRateMock, euro, usd, 0, today, crate1);
			mockGetRate(conversionRateMock, euro, usd, 0, tomorrow, crate2);
			
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostReversalAfterInventoryUse.1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.IMPORT.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("30.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testUnplannedLandedCostReversalAfterInventoryUse.2");
			p2.setProductType(MProduct.PRODUCTTYPE_Item);
			p2.setIsStocked(true);
			p2.setIsSold(true);
			p2.setIsPurchased(true);
			p2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p2.saveEx();
					
			mockProductGet(productMock, p2);
			
			pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p2.get_ID());
			BigDecimal p2price = new BigDecimal("50.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.setM_PriceList_ID(plv.getM_PriceList_ID());
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("100");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(10);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(today);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//material receipt 1
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine mr1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1l1Qty = new BigDecimal("25");
			mr1Line1.setOrderLine(poLine1, 0, mr1l1Qty);
			mr1Line1.setQty(mr1l1Qty);
			mr1Line1.saveEx();
			
			MInOutLine mr1Line2 = new MInOutLine(receipt1);
			BigDecimal mr1l2Qty = new BigDecimal("100");
			mr1Line2.setOrderLine(poLine2, 0, mr1l2Qty);
			mr1Line2.setQty(mr1l2Qty);
			mr1Line2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//material receipt 2
			MInOut receipt2 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine mr2Line1 = new MInOutLine(receipt2);
			BigDecimal mr2l1Qty = new BigDecimal("75");
			mr2Line1.setOrderLine(poLine1, 0, mr2l1Qty);
			mr2Line1.setQty(mr2l1Qty);
			mr2Line1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt2.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(poLine1.getQtyOrdered().intValue(), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(orderQty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			//assert p1 mcost
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price.multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1l1Qty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1price.multiply(mr1l1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1l1Qty).multiply(crate1).setScale(2, RoundingMode.HALF_UP), p1price.multiply(mr1l1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//PO invoice 
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(purchaseInvoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(20);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty).multiply(crate1), p1price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty).multiply(crate1).add(p2price.multiply(orderQty).multiply(crate1)), 
							p1price.multiply(orderQty).add(p2price.multiply(orderQty)), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//inventory decrease
			MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
			inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			inventory.setMovementDate(today);
			inventory.saveEx();
			
			MInventoryLine inventoryLine1 = new MInventoryLine(inventory, DictionaryIDs.M_Locator.HQ.id, p1.get_ID(), 0, null, null, new BigDecimal("25"));
			inventoryLine1.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			inventoryLine1.saveEx();
			MInventoryLine inventoryLine2 = new MInventoryLine(inventory, DictionaryIDs.M_Locator.HQ.id, p2.get_ID(), 0, null, null, new BigDecimal("100"));
			inventoryLine2.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			inventoryLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			inventory.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
			if (!inventory.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), inventory.getAD_Client_ID(), inventory.get_Table_ID(), inventory.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("1000.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(mr1Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(mr1Line2.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setM_InOut_ID(receipt1.get_ID());
			landedCost.setM_InOutLine_ID(mr2Line1.get_ID());
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal totalBase = purchaseOrder.getGrandTotal();			
			BigDecimal p1a1 = p1price.multiply(mr1l1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p1a2 = p1price.multiply(mr2l1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			BigDecimal p2a1 = p2price.multiply(mr1l2Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(3, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == mr1l1Qty.intValue()) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == mr2l1Qty.intValue()) {
					assertEquals(p1a2.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else if (allocation.getM_Product_ID() == p2.get_ID() && allocation.getQty().intValue() == mr1l2Qty.intValue()) {
					assertEquals(p2a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			BigDecimal p1OnHand = orderQty.add(inventoryLine1.getMovementQty());
			BigDecimal p1a1assetAmt = p1a1;
			BigDecimal p1a2assetAmt = p1a2.divide(mr2l1Qty, RoundingMode.HALF_UP).multiply(p1OnHand.subtract(mr1l1Qty));
			BigDecimal p1a2varianceAmt = p1a2.subtract(p1a2assetAmt);
			BigDecimal p2varianceAmt = p2a1;
			expected = Arrays.asList(new FactAcct(varianceAccount, p1a2varianceAmt, p1a2varianceAmt, 2, true),
					new FactAcct(assetAccount, p1a1assetAmt, p1a1assetAmt, 2, true),
					new FactAcct(assetAccount, p1a2assetAmt, p1a2assetAmt, 2, true),
					new FactAcct(varianceAccount, p2varianceAmt, p2varianceAmt, 2, true),
					new FactAcct(varianceAccount, p1a2varianceAmt, p1a2varianceAmt, 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			BigDecimal p1assetAmt = p1a1assetAmt.add(p1a2assetAmt);
			p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p1price.multiply(crate1).add(p1assetAmt.divide(p1OnHand, RoundingMode.HALF_UP)).setScale(2, RoundingMode.HALF_UP), 
					p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");			
			
			//reverse freight invoice
			Env.setContext(Env.getCtx(), Env.DATE, tomorrow);
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Correct);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, freightInvoice.getDocStatus());
			assertTrue(freightInvoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), freightInvoice.getReversal_ID(), getTrxName());
			assertEquals(freightInvoice.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversal.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
			expected = new ArrayList<FactAcct>();
			for(MFactAcct factAcct : factAccts) {
				MAccount acct = MAccount.get(factAcct, getTrxName());
				if (factAcct.getAmtAcctDr().signum() != 0) {
					FactAcct fa = null;
					for (FactAcct t : expected) {
						if (t.account().getAccount_ID() == acct.getAccount_ID() &&
							t.account().getM_Product_ID() == acct.getM_Product_ID() &&
							t.debit() == false) {
							fa = t;
							break;
						}
					}
					if (fa == null) { 
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 1, false));
					} else {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctDr().add(fa.accountedAmount()), 1, false));
						expected.remove(fa);
					}
				} else if (factAcct.getAmtAcctCr().signum() != 0) {
					FactAcct fa = null;
					for (FactAcct t : expected) {
						if (t.account().getAccount_ID() == acct.getAccount_ID() &&
							t.account().getM_Product_ID() == acct.getM_Product_ID() &&
							t.debit() == true) {
							fa = t;
							break;
						}
					}
					if (fa == null) {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 1, true));
					} else {
						expected.add(new FactAcct(acct, factAcct.getAmtAcctCr().add(fa.accountedAmount()), 1, true));
						expected.remove(fa);
					}
				}
				
				//assert reversal allocation generate no entries
				MAllocationHdr[] allocationHdrs = MAllocationHdr.getOfInvoice(Env.getCtx(), freightInvoice.getC_Invoice_ID(), getTrxName());
				assertEquals(1, allocationHdrs.length, "Unexpected number of allocations for freight invoice");
				if (!allocationHdrs[0].isPosted()) {
					String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MAllocationHdr.Table_ID, allocationHdrs[0].get_ID(), false, getTrxName());
					assertNull(msg, msg);
				}
				assertTrue(allocationHdrs[0].isPosted(), "Allocation of freight invoice not posted");
				query = MFactAcct.createRecordIdQuery(MAllocationHdr.Table_ID, allocationHdrs[0].get_ID(), as.get_ID(), getTrxName());
				factAccts = query.list();
				assertEquals(0, factAccts.size(), "Unexpected number of fact entries generated by invoice reversal allocation");
			}
			assertFactAcctEntries(rFactAccts, expected);

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
			if (optional.isPresent()) {
				MAcctSchema as2 = optional.get();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as2.get_ID(), getTrxName());
				factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.getReversal_ID(), as2.get_ID(), getTrxName());
				rFactAccts = query.list();
				expected = new ArrayList<FactAcct>();
				for(MFactAcct factAcct : factAccts) {
					MAccount acct = MAccount.get(factAcct, getTrxName());
					if (factAcct.getAmtAcctDr().signum() != 0) {
						FactAcct fa = null;
						for (FactAcct t : expected) {
							if (t.account().getAccount_ID() == acct.getAccount_ID() &&
								t.account().getM_Product_ID() == acct.getM_Product_ID() &&
								t.debit() == false) {
								fa = t;
								break;
							}
						}
						if (fa == null) { 
							expected.add(new FactAcct(acct, factAcct.getAmtAcctDr(), 1, false));
						} else {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctDr().add(fa.accountedAmount()), 1, false));
							expected.remove(fa);
						}
					} else if (factAcct.getAmtAcctCr().signum() != 0) {
						FactAcct fa = null;
						for (FactAcct t : expected) {
							if (t.account().getAccount_ID() == acct.getAccount_ID() &&
								t.account().getM_Product_ID() == acct.getM_Product_ID() &&
								t.debit() == true) {
								fa = t;
								break;
							}
						}
						if (fa == null) {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctCr(), 1, true));
						} else {
							expected.add(new FactAcct(acct, factAcct.getAmtAcctCr().add(fa.accountedAmount()), 1, true));
							expected.remove(fa);
						}
					}				
				}
				assertFactAcctEntries(rFactAccts, expected);
			}
		}	
	}
	
	@Test
	public void testUnplannedLandedCostReversalWithZeroOnHand() {
		testUnplannedLandedCostReversalWithZeroOnHand(true);
		testUnplannedLandedCostReversalWithZeroOnHand(false);
	}
	public void testUnplannedLandedCostReversalWithZeroOnHand(boolean forProduct) {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testUnplannedLandedCostReversalWithZeroOnHand");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			
			mockProductGet(productMock, p1);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("30.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			purchaseOrder.setDateOrdered(today);
			purchaseOrder.setDatePromised(today);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("10");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(today);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			//mr1 for 10 each
			MInOut receipt1 = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, purchaseOrder.getDateOrdered());
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receipt1Line1 = new MInOutLine(receipt1);
			BigDecimal mr1Qty = new BigDecimal("10");
			receipt1Line1.setOrderLine(poLine1, 0, mr1Qty);
			receipt1Line1.setQty(mr1Qty);
			receipt1Line1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			//assert p1 cost and posting
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", poLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 1, "MCostDetail not found for order line1");
			for(MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(10, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(p1price.multiply(mr1Qty).setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			p1.set_TrxName(getTrxName());
			MCost p1mcost = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(p1mcost, "No MCost record found");			
			assertEquals(p1price, p1mcost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			ProductCost p1ProductCost = new ProductCost(Env.getCtx(), p1.get_ID(), 0, getTrxName());
			MAccount assetAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt1.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, p1price.multiply(mr1Qty), 2, true),
					new FactAcct(nivReceiptAccount, p1price.multiply(mr1Qty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//full po invoice
			MInvoice purchaseInvoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			purchaseInvoice.setDocStatus(DocAction.STATUS_Drafted);
			purchaseInvoice.setDocAction(DocAction.ACTION_Complete);
			purchaseInvoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(purchaseInvoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(purchaseInvoice, DocAction.ACTION_Complete);
			purchaseInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, purchaseInvoice.getDocStatus());
			
			if (!purchaseInvoice.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), purchaseInvoice.getAD_Client_ID(), MInvoice.Table_ID, purchaseInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			purchaseInvoice.load(getTrxName());
			assertTrue(purchaseInvoice.isPosted());
			
			Doc invoiceDoc = DocManager.getDocument(as, MInvoice.Table_ID, purchaseInvoice.get_ID(), getTrxName());
			MAccount liabilityAccount = invoiceDoc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			MAccount inventoryClearingAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, purchaseInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(inventoryClearingAccount, p1price.multiply(orderQty), 2, true),
					new FactAcct(liabilityAccount, p1price.multiply(orderQty), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//so and shipment
			MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MOrder salesOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			salesOrder.setBPartner(customer);
			salesOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			salesOrder.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder.setDocAction(DocAction.ACTION_Complete);
			salesOrder.setDatePromised(today);
			salesOrder.saveEx();
			
			MOrderLine soLine1 = new MOrderLine(salesOrder);
			soLine1.setLine(10);
			soLine1.setProduct(p1);
			BigDecimal p1ShipQty = new BigDecimal("10");
			soLine1.setQty(p1ShipQty);
			soLine1.setDatePromised(today);
			soLine1.setPrice(new BigDecimal("50"));
			soLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(salesOrder, DocAction.ACTION_Complete);
			salesOrder.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder.getDocStatus());
			
			MInOut shipment = new MInOut(salesOrder, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();
			
			MInOutLine shipmentLine1 = new MInOutLine(shipment);
			shipmentLine1.setOrderLine(soLine1, 0, soLine1.getQtyOrdered());
			shipmentLine1.setQty(soLine1.getQtyOrdered());
			shipmentLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			shipment.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
			
			//landed cost invoice
			MBPartner freightBP = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			MInvoice freightInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			freightInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
			freightInvoice.setBPartner(freightBP);
			freightInvoice.setDocStatus(DocAction.STATUS_Drafted);
			freightInvoice.setDocAction(DocAction.ACTION_Complete);
			freightInvoice.saveEx();
			
			MInvoiceLine fiLine = new MInvoiceLine(freightInvoice);
			fiLine.setLine(10);
			fiLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
			fiLine.setQty(BigDecimal.ONE);
			BigDecimal freightPrice = new BigDecimal("200.00");
			fiLine.setPrice(freightPrice);
			fiLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fiLine.saveEx();
			
			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_InvoiceLine_ID(fiLine.get_ID());
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			if (forProduct) {
				landedCost.setM_Product_ID(receipt1Line1.getM_Product_ID());
				landedCost.setQty(receipt1Line1.getMovementQty());				
			} else {
				landedCost.setM_InOut_ID(receipt1.get_ID());
				landedCost.setM_InOutLine_ID(receipt1Line1.get_ID());
			}
			landedCost.setLandedCostDistribution(MLandedCost.LANDEDCOSTDISTRIBUTION_Costs);		
			landedCost.saveEx();
			
			String error = landedCost.allocateCosts();
			assertTrue(Util.isEmpty(error, true), error);

			BigDecimal totalBase = purchaseInvoice.getGrandTotal();
			BigDecimal p1a1 =  p1price.multiply(mr1Qty).multiply(fiLine.getLineNetAmt()).divide(totalBase, 6, RoundingMode.HALF_UP);
			
			MLandedCostAllocation[] allocations = MLandedCostAllocation.getOfInvoiceLine(Env.getCtx(), fiLine.get_ID(), getTrxName());
			assertEquals(1, allocations.length, "Unexpected number of landed cost allocation line");
			for (MLandedCostAllocation allocation : allocations) {
				if (allocation.getM_Product_ID() == p1.get_ID() && allocation.getQty().intValue() == 10) {
					assertEquals(p1a1.setScale(2, RoundingMode.HALF_UP), allocation.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected landed cost allocation amount");
				} else {
					fail("Unknown landed cost allocation line: " + allocation);
				}
			}
			
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Complete);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, freightInvoice.getDocStatus());
			
			if (!freightInvoice.isPosted()) {
				error = DocumentEngine.postImmediate(Env.getCtx(), freightInvoice.getAD_Client_ID(), MInvoice.Table_ID, freightInvoice.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			freightInvoice.load(getTrxName());
			assertTrue(freightInvoice.isPosted());
			
			//assert freight invoice posting
			doc = DocManager.getDocument(as, MInvoice.Table_ID, freightInvoice.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, p1a1, 2, true),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			//reverse freight invoice
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Correct);
			freightInvoice.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Reversed, freightInvoice.getDocStatus());
			assertTrue(freightInvoice.getReversal_ID() > 0, "Unexpected reversal id");
			MInvoice reversal = new MInvoice(Env.getCtx(), freightInvoice.getReversal_ID(), getTrxName());
			assertEquals(freightInvoice.getReversal_ID(), reversal.get_ID());
			if (!reversal.isPosted()) {
				String msg = DocumentEngine.postImmediate(Env.getCtx(), getAD_Client_ID(), MInvoice.Table_ID, reversal.get_ID(), false, getTrxName());
				assertNull(msg, msg);
			}
			
			//assert reversal invoice posting
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.getReversal_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> rFactAccts = query.list();
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

			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			Optional<MAcctSchema> optional = Arrays.stream(ass).filter(e -> e.getC_AcctSchema_ID() != as.get_ID()).findFirst();
			if (optional.isPresent()) {
				MAcctSchema as2 = optional.get();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.get_ID(), as2.get_ID(), getTrxName());
				factAccts = query.list();
				query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, freightInvoice.getReversal_ID(), as2.get_ID(), getTrxName());
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
	}
	
	/**
	 * IDEMPIERE-6659
	 * PO, Qty=20, Price=10, Landed Cost=100
	 * MR1, Qty=2
	 * MR2, Qty=2
	 * MR3, Qty=2
	 * MR3, Qty=2 (Reversed)
	 * MR2, Qty=2 (Reversed)
	 * MR1, Qty=2 (Reversed)
	 */
	@Test
	public void testLandedCostForPOWithMultiMRAndReversal() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testLandedCostForPOWithMultiMRAndReversal");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("10"));
			pp.setPriceList(new BigDecimal("10"));
			pp.saveEx();
			
			// create order
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

			MOrderLine line = new MOrderLine(order);
			line.setLine(10);
			line.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line.setQty(new BigDecimal("20"));
			line.setDatePromised(today);
			line.setPrice(new BigDecimal("10"));
			line.saveEx();
			
			MOrderLandedCost landedCost = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_Order_ID(order.get_ID());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Costs);
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setAmt(new BigDecimal("100"));
			landedCost.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			List<MInOut> receipts = new ArrayList<MInOut>();
			for (int i = 0; i < 3; i++) {
				MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
				receipt.setDocStatus(DocAction.STATUS_Drafted);
				receipt.setDocAction(DocAction.ACTION_Complete);
				receipt.saveEx();
				receipts.add(receipt);
				
				MInOutLine receiptLine = new MInOutLine(receipt);
				receiptLine.setOrderLine(line, 0, new BigDecimal("2"));
				receiptLine.setQty(new BigDecimal("2"));
				receiptLine.saveEx();
	
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
				if (!receipt.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
					assertNull(error, error);
				}
				
				List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 2, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(2 * (i+1), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i+1)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(2 * (i+1), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i+1)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("15.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("30.00").multiply(new BigDecimal(i+1)), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i+1)), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("20.00").multiply(new BigDecimal(i+1)), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i+1)), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
				
				// check posting
				ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
				MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> list = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("30.00"), 2, true),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, false), new FactAcct(landedCostAccount, new BigDecimal("10.00"), 2, false));
				assertFactAcctEntries(list, expected);
			}
			
			for (int i = receipts.size()-1; i >= 0; i--) {
				MInOut receipt = receipts.get(i);
				
				// reverse receipt
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Accrual);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus());
				
				List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 2, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(2 * (i), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(2 * (i), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal(i == 0 ? "10.00" : "15.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("30.00").multiply(new BigDecimal(i)), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i)), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("20.00").multiply(new BigDecimal(i)), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i)), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
				
				// check posting for reversal document
				ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
				MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.getReversal_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> list = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, true), new FactAcct(landedCostAccount, new BigDecimal("10.00"), 2, true));
				assertFactAcctEntries(list, expected);
			}
		}
	}
	
	/**
	 * IDEMPIERE-6659
	 * PO, Qty=20, Price=10, Landed Cost=100
	 * MR1, Qty=2
	 * MR2, Qty=2
	 * MR2, Qty=2 (Reversed)
	 * MR3, Qty=2
	 * MR3, Qty=2 (Reversed)
	 */
	@Test
	public void testLandedCostForPOWithMultiMRAndReversal2() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testLandedCostForPOWithMultiMRAndReversal2");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("10"));
			pp.setPriceList(new BigDecimal("10"));
			pp.saveEx();
			
			// create order
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

			MOrderLine line = new MOrderLine(order);
			line.setLine(10);
			line.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line.setQty(new BigDecimal("20"));
			line.setDatePromised(today);
			line.setPrice(new BigDecimal("10"));
			line.saveEx();
			
			MOrderLandedCost landedCost = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost.setC_Order_ID(order.get_ID());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Costs);
			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost.setAmt(new BigDecimal("100"));
			landedCost.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setOrderLine(line, 0, new BigDecimal("2"));
			receiptLine.setQty(new BigDecimal("2"));
			receiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 2, "MCostDetail not found for order line");
			for (MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			product.set_TrxName(getTrxName());			
			MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
			MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
			assertNotNull(cost1, "No MCost record found");
			assertNotNull(cost2, "No MCost record found");
			assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			assertEquals(new BigDecimal("15.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(new BigDecimal("30.00"), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
			assertEquals(new BigDecimal("2.00"), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
			assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(new BigDecimal("20.00"), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
			assertEquals(new BigDecimal("2.00"), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
			
			for (int i = 0; i < 2; i++) {
				receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
				receipt.setDocStatus(DocAction.STATUS_Drafted);
				receipt.setDocAction(DocAction.ACTION_Complete);
				receipt.saveEx();
				
				receiptLine = new MInOutLine(receipt);
				receiptLine.setOrderLine(line, 0, new BigDecimal("2"));
				receiptLine.setQty(new BigDecimal("2"));
				receiptLine.saveEx();
	
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
				if (!receipt.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
					assertNull(error, error);
				}
				
				cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 2, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(4, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("40.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(4, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("15.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("60.00"), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("4.00"), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("40.00"), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("4.00"), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
				
				// check posting
				ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
				MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> list = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("30.00"), 2, true),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, false), new FactAcct(landedCostAccount, new BigDecimal("10.00"), 2, false));
				assertFactAcctEntries(list, expected);
				
				// reverse receipt
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Accrual);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus());
				
				cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 2, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("15.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("30.00"), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00"), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("20.00"), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00"), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
				
				// check posting for reversal document
				query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.getReversal_ID(), as.get_ID(), getTrxName());
				list = query.list();
				expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, true), new FactAcct(landedCostAccount, new BigDecimal("10.00"), 2, true));
				assertFactAcctEntries(list, expected);
			}
		}
	}
	
	/**
	 * IDEMPIERE-6659
	 * PO, Qty=20, Price=10, Landed Cost1=100, Landed Cost2=200
	 * MR, Qty=2
	 */
	@Test
	public void testMultiLandedCostForPO() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MCostElement costElement = new MCostElement(Env.getCtx(), 0, null);
		costElement.setName("Tax");
		costElement.setCostElementType(MCostElement.COSTELEMENTTYPE_Material);
		costElement.saveEx();
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {			
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testMultiLandedCostForPO");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("10"));
			pp.setPriceList(new BigDecimal("10"));
			pp.saveEx();
			
			// create order
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

			MOrderLine line = new MOrderLine(order);
			line.setLine(10);
			line.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line.setQty(new BigDecimal("20"));
			line.setDatePromised(today);
			line.setPrice(new BigDecimal("10"));
			line.saveEx();
			
			MOrderLandedCost landedCost1 = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost1.setC_Order_ID(order.get_ID());
			landedCost1.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
			landedCost1.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost1.setAmt(new BigDecimal("100"));
			landedCost1.saveEx();
			
			MOrderLandedCost landedCost2 = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost2.setC_Order_ID(order.get_ID());
			landedCost2.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
			landedCost2.setM_CostElement_ID(costElement.get_ID());
			landedCost2.setAmt(new BigDecimal("200"));
			landedCost2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setOrderLine(line, 0, new BigDecimal("2"));
			receiptLine.setQty(new BigDecimal("2"));
			receiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 3, "MCostDetail not found for order line");
			for (MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == costElement.get_ID() ) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			product.set_TrxName(getTrxName());			
			MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
			MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
			assertNotNull(cost1, "No MCost record found");
			assertNotNull(cost2, "No MCost record found");
			assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			assertEquals(new BigDecimal("25.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(new BigDecimal("50.00"), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
			assertEquals(new BigDecimal("2.00"), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
			assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(new BigDecimal("20.00"), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
			assertEquals(new BigDecimal("2.00"), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
			
			// check posting
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
			MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
			MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> list = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("50.00"), 2, true),
					new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, false), 
					new FactAcct(landedCostAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(list, expected);
		} finally {
			rollback();
			costElement.deleteEx(true);
		}
	}
	
	/**
	 * IDEMPIERE-6659
	 * PO, Qty=20, Price=10, Landed Cost1=100, Landed Cost2=200
	 * MR1, Qty=2
	 * MR2, Qty=2
	 * MR3, Qty=2
	 * MR3, Qty=2 (Reversed)
	 * MR2, Qty=2 (Reversed)
	 * MR1, Qty=2 (Reversed)
	 */
	@Test
	public void testMultiLandedCostForPOWithMultiMRAndReversal() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MCostElement costElement = new MCostElement(Env.getCtx(), 0, null);
		costElement.setName("Tax");
		costElement.setCostElementType(MCostElement.COSTELEMENTTYPE_Material);
		costElement.saveEx();
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {			
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testMultiLandedCostForPOWithMultiMRAndReversal");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("10"));
			pp.setPriceList(new BigDecimal("10"));
			pp.saveEx();
			
			// create order
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

			MOrderLine line = new MOrderLine(order);
			line.setLine(10);
			line.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line.setQty(new BigDecimal("20"));
			line.setDatePromised(today);
			line.setPrice(new BigDecimal("10"));
			line.saveEx();
			
			MOrderLandedCost landedCost1 = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost1.setC_Order_ID(order.get_ID());
			landedCost1.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
			landedCost1.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost1.setAmt(new BigDecimal("100"));
			landedCost1.saveEx();
			
			MOrderLandedCost landedCost2 = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost2.setC_Order_ID(order.get_ID());
			landedCost2.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
			landedCost2.setM_CostElement_ID(costElement.get_ID());
			landedCost2.setAmt(new BigDecimal("200"));
			landedCost2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			List<MInOut> receipts = new ArrayList<MInOut>();
			for (int i = 0; i < 3; i++) {
				MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
				receipt.setDocStatus(DocAction.STATUS_Drafted);
				receipt.setDocAction(DocAction.ACTION_Complete);
				receipt.saveEx();
				receipts.add(receipt);
				
				MInOutLine receiptLine = new MInOutLine(receipt);
				receiptLine.setOrderLine(line, 0, new BigDecimal("2"));
				receiptLine.setQty(new BigDecimal("2"));
				receiptLine.saveEx();
	
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
				if (!receipt.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
					assertNull(error, error);
				}
				
				List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 3, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(2 * (i+1), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i+1)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(2 * (i+1), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i+1)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == costElement.get_ID() ) {
						assertEquals(2 * (i+1), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i+1)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("25.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("50.00").multiply(new BigDecimal(i+1)), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i+1)), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("20.00").multiply(new BigDecimal(i+1)), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i+1)), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				
				// check posting
				ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
				MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> list = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("50.00"), 2, true),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, false), 
						new FactAcct(landedCostAccount, new BigDecimal("30.00"), 2, false));
				assertFactAcctEntries(list, expected);
			}
			
			for (int i = receipts.size()-1; i >= 0; i--) {
				MInOut receipt = receipts.get(i);
				
				// reverse receipt
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Accrual);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus());
				
				List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 3, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(2 * (i), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(2 * (i), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == costElement.get_ID() ) {
						assertEquals(2 * (i), cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal(i)), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal(i == 0 ? "10.00" : "25.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("50.00").multiply(new BigDecimal(i)), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i)), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("20.00").multiply(new BigDecimal(i)), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00").multiply(new BigDecimal(i)), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
				
				// check posting for reversal document
				ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
				MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.getReversal_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> list = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("50.00"), 2, false),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, true), 
						new FactAcct(landedCostAccount, new BigDecimal("30.00"), 2, true));
				assertFactAcctEntries(list, expected);
			}
		} finally {
			rollback();
			costElement.deleteEx(true);
		}
	}
	
	/**
	 * IDEMPIERE-6659
	 * PO, Qty=20, Price=10, Landed Cost1=100, Landed Cost2=200
	 * MR1, Qty=2
	 * MR2, Qty=2
	 * MR2, Qty=2 (Reversed)
	 * MR3, Qty=2
	 * MR3, Qty=2 (Reversed)
	 */
	@Test
	public void testMultiLandedCostForPOWithMultiMRAndReversal2() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		MCostElement costElement = new MCostElement(Env.getCtx(), 0, null);
		costElement.setName("Tax");
		costElement.setCostElementType(MCostElement.COSTELEMENTTYPE_Material);
		costElement.saveEx();
		
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {			
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.setName("testMultiLandedCostForPOWithMultiMRAndReversal2");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			mockProductGet(productMock, product);
			
			MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(product.get_ID());
			pp.setPriceStd(new BigDecimal("10"));
			pp.setPriceList(new BigDecimal("10"));
			pp.saveEx();
			
			// create order
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

			MOrderLine line = new MOrderLine(order);
			line.setLine(10);
			line.setProduct(new MProduct(Env.getCtx(), product.get_ID(), getTrxName()));
			line.setQty(new BigDecimal("20"));
			line.setDatePromised(today);
			line.setPrice(new BigDecimal("10"));
			line.saveEx();
			
			MOrderLandedCost landedCost1 = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost1.setC_Order_ID(order.get_ID());
			landedCost1.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
			landedCost1.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
			landedCost1.setAmt(new BigDecimal("100"));
			landedCost1.saveEx();
			
			MOrderLandedCost landedCost2 = new MOrderLandedCost(Env.getCtx(), 0, getTrxName());
			landedCost2.setC_Order_ID(order.get_ID());
			landedCost2.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
			landedCost2.setM_CostElement_ID(costElement.get_ID());
			landedCost2.setAmt(new BigDecimal("200"));
			landedCost2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			order.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();
			
			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setOrderLine(line, 0, new BigDecimal("2"));
			receiptLine.setQty(new BigDecimal("2"));
			receiptLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			List<MCostDetail> cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertTrue(cds.size() == 3, "MCostDetail not found for order line");
			for (MCostDetail cd : cds) {
				if (cd.getM_CostElement_ID() == 0) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				} else if (cd.getM_CostElement_ID() == costElement.get_ID() ) {
					assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
					assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
				}
			}
			
			product.set_TrxName(getTrxName());			
			MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
			MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
			assertNotNull(cost1, "No MCost record found");
			assertNotNull(cost2, "No MCost record found");
			assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			assertEquals(new BigDecimal("25.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(new BigDecimal("50.00"), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
			assertEquals(new BigDecimal("2.00"), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
			assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(new BigDecimal("20.00"), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
			assertEquals(new BigDecimal("2.00"), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
			
			for (int i = 0; i < 2; i++) {
				receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
				receipt.setDocStatus(DocAction.STATUS_Drafted);
				receipt.setDocAction(DocAction.ACTION_Complete);
				receipt.saveEx();
				
				receiptLine = new MInOutLine(receipt);
				receiptLine.setOrderLine(line, 0, new BigDecimal("2"));
				receiptLine.setQty(new BigDecimal("2"));
				receiptLine.saveEx();
	
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
				if (!receipt.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
					assertNull(error, error);
				}
				
				cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 3, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(4, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("40.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(4, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == costElement.get_ID() ) {
						assertEquals(4, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("40.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("25.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("100.00"), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("4.00"), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("40.00"), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("4.00"), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
				
				// check posting
				ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
				MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				MAccount nivReceiptAccount = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				MAccount landedCostAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.get_ID(), getTrxName());
				List<MFactAcct> list = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("50.00"), 2, true),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, false), 
						new FactAcct(landedCostAccount, new BigDecimal("30.00"), 2, false));
				assertFactAcctEntries(list, expected);
				
				// reverse receipt
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Reverse_Accrual);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Reversed, receipt.getDocStatus());
				
				cds = MCostDetail.list(Env.getCtx(), "C_OrderLine_ID=?", line.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
				assertTrue(cds.size() == 3, "MCostDetail not found for order line");
				for (MCostDetail cd : cds) {
					if (cd.getM_CostElement_ID() == 0) {
						assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == DictionaryIDs.M_CostElement.FREIGHT.id ) {
						assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("10.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					} else if (cd.getM_CostElement_ID() == costElement.get_ID() ) {
						assertEquals(2, cd.getQty().intValue(), "Unexpected MCostDetail Qty");
						assertEquals(new BigDecimal("20.00").setScale(2, RoundingMode.HALF_UP), cd.getAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected MCostDetail Amt");
					}
				}
				
				product.set_TrxName(getTrxName());			
				cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
				cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
				assertNotNull(cost1, "No MCost record found");
				assertNotNull(cost2, "No MCost record found");
				assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("25.00"), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("50.00"), cost1.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00"), cost1.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				assertEquals(new BigDecimal("10.00"), cost2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
				assertEquals(new BigDecimal("20.00"), cost2.getCumulatedAmt().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated amount");
				assertEquals(new BigDecimal("2.00"), cost2.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");				
				
				// check posting for reversal document
				query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.getReversal_ID(), as.get_ID(), getTrxName());
				list = query.list();
				expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("50.00"), 2, false),
						new FactAcct(nivReceiptAccount, new BigDecimal("20.00"), 2, true), 
						new FactAcct(landedCostAccount, new BigDecimal("30.00"), 2, true));
				assertFactAcctEntries(list, expected);
			}
		} finally {
			rollback();
			costElement.deleteEx(true);
		}
	}
	
	private MInOutLine createPOAndMRForProduct(int productId, MAttributeSetInstance asi, BigDecimal price) {
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
		line1.setProduct(new MProduct(Env.getCtx(), productId, getTrxName()));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		if (price != null)
			line1.setPrice(price);
		if (asi != null)
			line1.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
		
		MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt1.setDocStatus(DocAction.STATUS_Drafted);
		receipt1.setDocAction(DocAction.ACTION_Complete);
		receipt1.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt1);
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine1.setQty(new BigDecimal("1"));
		if (asi != null)
			receiptLine1.setM_AttributeSetInstance_ID(asi.get_ID());
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt1.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
		if (!receipt1.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
		
		return receiptLine1;
	}
	
	private void mockGetRate(MockedStatic<MConversionRate> conversionRateMock, MCurrency fromCurrency,
			MCurrency toCurrency, int C_ConversionType_ID, Timestamp conversionDate, BigDecimal multiplyRate) {
		ConversionRateHelper.mockGetRate(conversionRateMock, fromCurrency, toCurrency, C_ConversionType_ID, 
				conversionDate, multiplyRate, getAD_Client_ID(), getAD_Org_ID());
		ConversionRateHelper.mockGetRate(conversionRateMock, toCurrency, fromCurrency, C_ConversionType_ID, 
				conversionDate, BigDecimal.valueOf(1d/multiplyRate.doubleValue()), getAD_Client_ID(), getAD_Org_ID());
	}
}
