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
 * - hengsin                                                           *
 **********************************************************************/
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutConfirm;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrder;
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
import org.compiere.model.MProductionPlan;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.PO;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Shared fixture and helpers for IDEMPIERE-7231 manual cost element tests.
 */
@Isolated
public abstract class AbstractManualCostElementTest extends AbstractTestCase
{
	protected static final Timestamp FIXTURE_DATE = TimeUtil.getDay(2025, 6, 15);

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo)
	{
		return new LoginDetails(GARDEN_WORLD_CLIENT, GARDEN_WORLD_HQ_ORG, GARDEN_WORLD_ADMIN_USER,
				GARDEN_WORLD_ADMIN_ROLE, GARDEN_WORLD_HQ_WAREHOUSE, FIXTURE_DATE, Language.getLanguage("en_US"));
	}

	protected void complete(PO doc)
	{
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(doc, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		doc.load(getTrxName());
	}

	protected void completeAndPost(PO doc)
	{
		complete(doc);
		assertEquals(DocAction.STATUS_Completed, doc.get_ValueAsString("DocStatus"));
		if (!doc.get_ValueAsBoolean("Posted"))
			postImmediate(doc);
	}

	protected void postImmediate(PO doc)
	{
		String error = tryPostImmediate(doc);
		assertNull(error, doc.get_TableName() + " posting failed: " + error);
		doc.load(getTrxName());
	}

	protected String tryPostImmediate(PO doc)
	{
		return DocumentEngine.postImmediate(Env.getCtx(), doc.getAD_Client_ID(),
				doc.get_Table_ID(), doc.get_ID(), false, getTrxName());
	}

	protected void runDeferred(Runnable action)
	{
		try (MockedStatic<MClient> mockedClient = mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS))
		{
			mockedClient.when(MClient::isClientAccountingImmediate).thenReturn(false);
			action.run();
		}
	}

	protected void reverseCorrect(PO doc)
	{
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(doc, DocAction.ACTION_Reverse_Correct);
		assertFalse(info.isError(), info.getSummary());
		doc.load(getTrxName());
	}

	protected MInOut reverseAndPost(MInOut doc)
	{
		reverseCorrect(doc);
		assertTrue(doc.getReversal_ID() > 0, "MInOut reversal not created");
		MInOut reversal = new MInOut(Env.getCtx(), doc.getReversal_ID(), getTrxName());
		if (!reversal.isPosted())
			postImmediate(reversal);
		return reversal;
	}

	protected MProduction reverseAndPost(MProduction doc)
	{
		reverseCorrect(doc);
		assertTrue(doc.getReversal_ID() > 0, "MProduction reversal not created");
		MProduction reversal = new MProduction(Env.getCtx(), doc.getReversal_ID(), getTrxName());
		if (!reversal.isPosted())
			postImmediate(reversal);
		return reversal;
	}

	protected MProjectIssue reverseAndPost(MProjectIssue doc)
	{
		reverseCorrect(doc);
		assertTrue(doc.getReversal_ID() > 0, "MProjectIssue reversal not created");
		MProjectIssue reversal = new MProjectIssue(Env.getCtx(), doc.getReversal_ID(), getTrxName());
		if (!reversal.isPosted())
			postImmediate(reversal);
		return reversal;
	}

	protected MProduct createStockedProduct(String name, int categoryId, int attributeSetId)
	{
		MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setM_Product_Category_ID(categoryId);
		product.setName(name);
		product.setValue(name);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		if (attributeSetId > 0)
			product.setM_AttributeSet_ID(attributeSetId);
		product.saveEx();

		MPriceListVersion purchasePlv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(getLoginDate());
		MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
		pp.setM_PriceList_Version_ID(purchasePlv.get_ID());
		pp.setM_Product_ID(product.get_ID());
		pp.setPriceStd(new BigDecimal("100.00"));
		pp.setPriceList(new BigDecimal("100.00"));
		pp.saveEx();

		MPriceListVersion salesPlv = MPriceList.get(DictionaryIDs.M_PriceList.STANDARD.id).getPriceListVersion(getLoginDate());
		MProductPrice sp = new MProductPrice(Env.getCtx(), 0, getTrxName());
		sp.setM_PriceList_Version_ID(salesPlv.get_ID());
		sp.setM_Product_ID(product.get_ID());
		sp.setPriceStd(new BigDecimal("150.00"));
		sp.setPriceList(new BigDecimal("150.00"));
		sp.saveEx();

		return product;
	}

	protected MProduct createServiceProduct(String name, int categoryId)
	{
		MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setValue(name);
		product.setName(name);
		product.setProductType(MProduct.PRODUCTTYPE_Service);
		product.setIsStocked(false);
		product.setIsPurchased(true);
		product.setIsSold(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setM_Product_Category_ID(categoryId);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();
		return product;
	}

	protected MProduct createBomProduct(String name, int categoryId, int attributeSetId, MockedStatic<MProduct> mockedProduct)
	{
		MProduct fg = createStockedProduct(name, categoryId, attributeSetId);
		fg.setIsBOM(true);
		fg.saveEx();
		mockProductGet(mockedProduct, fg);
		return fg;
	}

	protected MProductCategory createCategoryWithCosting(String name, MAcctSchema as,
			String costingLevel, String costingMethod, MockedStatic<MProductCategory> mockedCategory)
	{
		MProductCategory cat = new MProductCategory(Env.getCtx(), 0, getTrxName());
		cat.setName(name);
		cat.saveEx();

		mockedCategory.when(() -> MProductCategory.get(any(Properties.class), eq(cat.get_ID()))).thenReturn(cat);
		mockedCategory.when(() -> MProductCategory.get(eq(cat.get_ID()))).thenReturn(cat);

		MProductCategoryAcct catAcct = MProductCategoryAcct.get(cat.get_ID(), as.get_ID(), getTrxName());
		catAcct = new MProductCategoryAcct(Env.getCtx(), catAcct, getTrxName());
		if (costingLevel != null)
			catAcct.setCostingLevel(costingLevel);
		if (costingMethod != null)
			catAcct.setCostingMethod(costingMethod);
		catAcct.saveEx();
		CacheMgt.get().reset(MProductCategoryAcct.Table_Name);
		MProductCategoryAcct.get(cat.get_ID(), as.get_ID(), getTrxName());
		return cat;
	}

	protected MAttributeSet createLotAttributeSet(String name, MockedStatic<MAttributeSet> mockedAttrSet)
	{
		MAttributeSet attrSet = new MAttributeSet(Env.getCtx(), 0, getTrxName());
		attrSet.setName(name);
		attrSet.setIsLot(true);
		attrSet.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
		attrSet.saveEx();
		MAttributeSet attrSetSpy = Mockito.spy(attrSet);
		Mockito.doReturn(true).when(attrSetSpy).excludeTableEntry(MOrderLine.Table_ID, true);
		Mockito.doReturn(true).when(attrSetSpy).excludeTableEntry(MInOutLine.Table_ID, true);
		mockedAttrSet.when(() -> MAttributeSet.getCopy(any(Properties.class), eq(attrSet.get_ID()), any())).thenReturn(attrSetSpy);
		mockedAttrSet.when(() -> MAttributeSet.get(any(Properties.class), eq(attrSet.get_ID()))).thenReturn(attrSetSpy);
		mockedAttrSet.when(() -> MAttributeSet.get(eq(attrSet.get_ID()))).thenReturn(attrSetSpy);
		return attrSet;
	}

	protected MAttributeSetInstance createLot(int attributeSetId, String lotName)
	{
		MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
		asi.setM_AttributeSet_ID(attributeSetId);
		asi.setLot(lotName);
		asi.setDescription();
		asi.saveEx();
		return asi;
	}

	protected MCostElement createManualCostElement(String name, String costElementType, int chargeId)
	{
		MCostElement ce = new MCostElement(Env.getCtx(), 0, getTrxName());
		ce.setName(name);
		ce.setCostElementType(costElementType);
		ce.setC_Charge_ID(chargeId);
		ce.saveEx();
		return ce;
	}

	protected MCost createManualCostRecord(MProduct product, MAcctSchema as, MCostElement ce,
			int asiId, BigDecimal currentCostPrice, int percent)
	{
		MCost.CostingKey key = MCost.CostingKey.resolve(getAD_Org_ID(), asiId, product.getCostingLevel(as));
		MCost cost = new MCost(product, key.M_AttributeSetInstance_ID(), as, key.AD_Org_ID(), ce.getM_CostElement_ID());
		cost.setCurrentCostPrice(currentCostPrice);
		cost.setPercent(percent);
		cost.saveEx();
		return cost;
	}

	protected MInOutLine createPOAndMR(MProduct product, MAttributeSetInstance asi, BigDecimal qty, BigDecimal price)
	{
		return createPOAndMR(product, asi, qty, price, getLoginDate());
	}

	protected MInOutLine createPOAndMR(MProduct product, MAttributeSetInstance asi, BigDecimal qty, BigDecimal price,
			Timestamp movementDate)
	{
		Timestamp date = movementDate != null ? TimeUtil.getDay(movementDate) : getLoginDate();

		MOrder po = new MOrder(Env.getCtx(), 0, getTrxName());
		po.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		po.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		po.setIsSOTrx(false);
		po.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		po.setDocStatus(DocAction.STATUS_Drafted);
		po.setDocAction(DocAction.ACTION_Complete);
		po.setDateOrdered(date);
		po.setDateAcct(date);
		po.setDatePromised(date);
		po.saveEx();

		MOrderLine poLine = new MOrderLine(po);
		poLine.setLine(10);
		poLine.setProduct(product);
		poLine.setQty(qty);
		poLine.setDatePromised(date);
		poLine.setPrice(price);
		if (asi != null)
			poLine.setM_AttributeSetInstance_ID(asi.get_ID());
		poLine.saveEx();

		complete(po);
		assertEquals(DocAction.STATUS_Completed, po.getDocStatus());

		MInOut receipt = new MInOut(po, DictionaryIDs.C_DocType.MM_RECEIPT.id, date);
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(poLine, 0, qty);
		receiptLine.setQty(qty);
		if (asi != null)
			receiptLine.setM_AttributeSetInstance_ID(asi.get_ID());
		receiptLine.saveEx();

		completeAndPost(receipt);
		return receiptLine;
	}

	protected MOrder createCompletedSO(MBPartner bpartner, int bpartnerLocationId, MProduct product,
			MAttributeSetInstance asi, BigDecimal qty, BigDecimal price, Timestamp date, boolean forceDelivery)
	{
		Timestamp orderDate = date != null ? date : getLoginDate();
		MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
		so.setBPartner(bpartner);
		if (bpartnerLocationId > 0)
			so.setC_BPartner_Location_ID(bpartnerLocationId);
		so.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		if (forceDelivery)
			so.setDeliveryRule(MOrder.DELIVERYRULE_Force);
		so.setIsSOTrx(true);
		so.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		so.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		so.setDocStatus(DocAction.STATUS_Drafted);
		so.setDocAction(DocAction.ACTION_Complete);
		so.setDateOrdered(orderDate);
		so.setDateAcct(orderDate);
		so.setDatePromised(orderDate);
		so.saveEx();

		MOrderLine soLine = new MOrderLine(so);
		soLine.setLine(10);
		soLine.setProduct(product);
		soLine.setQty(qty);
		soLine.setDatePromised(orderDate);
		soLine.setPrice(price);
		if (asi != null)
			soLine.setM_AttributeSetInstance_ID(asi.get_ID());
		soLine.saveEx();

		complete(so);
		assertEquals(DocAction.STATUS_Completed, so.getDocStatus());
		return so;
	}

	protected MInOut createDraftShipment(MOrder so, MOrderLine soLine, MAttributeSetInstance asi,
			BigDecimal qty, Timestamp date)
	{
		MInOut shipment = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, date != null ? date : so.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();

		MInOutLine shipLine = new MInOutLine(shipment);
		shipLine.setOrderLine(soLine, 0, qty);
		shipLine.setQty(qty);
		if (asi != null)
			shipLine.setM_AttributeSetInstance_ID(asi.get_ID());
		shipLine.saveEx();
		return shipment;
	}

	protected MInOut createSOAndShipment(MProduct product, MAttributeSetInstance asi, BigDecimal qty, BigDecimal price)
	{
		return createSOAndShipment(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id), 0, product, asi, qty, price);
	}

	protected MInOut createSOAndShipment(MBPartner bpartner, int bpartnerLocationId, MProduct product,
			MAttributeSetInstance asi, BigDecimal qty, BigDecimal price)
	{
		MOrder so = createCompletedSO(bpartner, bpartnerLocationId, product, asi, qty, price, getLoginDate(), false);
		MInOut shipment = createDraftShipment(so, so.getLines()[0], asi, qty, so.getDateOrdered());
		completeAndPost(shipment);
		return shipment;
	}

	protected MInOut createDraftCustomerReturn(MInOut shipment, MInOutLine shipLine, BigDecimal qty)
	{
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setName("ManualCost RMA " + shipment.getDocumentNo());
		rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
		rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
		rma.setM_InOut_ID(shipment.get_ID());
		rma.setIsSOTrx(true);
		rma.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		rma.saveEx();

		MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
		rmaLine.setLine(10);
		rmaLine.setM_RMA_ID(rma.get_ID());
		rmaLine.setM_InOutLine_ID(shipLine.get_ID());
		rmaLine.setQty(qty);
		rmaLine.saveEx();

		complete(rma);
		assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());

		MInOut customerReturn = new MInOut(Env.getCtx(), 0, getTrxName());
		customerReturn.setM_RMA_ID(rma.get_ID());
		customerReturn.setBPartner(MBPartner.get(Env.getCtx(), shipment.getC_BPartner_ID()));
		customerReturn.setC_DocType_ID(DictionaryIDs.C_DocType.MM_CUSTOMER_RETURN.id);
		customerReturn.setMovementType(MInOut.MOVEMENTTYPE_CustomerReturns);
		customerReturn.setIsSOTrx(true);
		customerReturn.setMovementDate(shipment.getMovementDate());
		customerReturn.setDateAcct(shipment.getDateAcct());
		customerReturn.setDocStatus(DocAction.STATUS_Drafted);
		customerReturn.setDocAction(DocAction.ACTION_Complete);
		customerReturn.setM_Warehouse_ID(shipment.getM_Warehouse_ID());
		customerReturn.saveEx();

		MInOutLine returnLine = new MInOutLine(customerReturn);
		returnLine.setM_RMALine_ID(rmaLine.get_ID());
		returnLine.setLine(10);
		returnLine.setProduct(MProduct.get(Env.getCtx(), shipLine.getM_Product_ID()));
		returnLine.setM_Locator_ID(shipLine.getM_Locator_ID());
		returnLine.setQty(qty);
		if (shipLine.getM_AttributeSetInstance_ID() > 0)
			returnLine.setM_AttributeSetInstance_ID(shipLine.getM_AttributeSetInstance_ID());
		returnLine.saveEx();
		return customerReturn;
	}

	protected void completeCustomerReturn(MInOut customerReturn)
	{
		complete(customerReturn);
		if (!DocAction.STATUS_Completed.equals(customerReturn.getDocStatus()))
		{
			for (MInOutConfirm confirm : customerReturn.getConfirmations(true))
			{
				if (!DocAction.STATUS_Completed.equals(confirm.getDocStatus()))
					complete(confirm);
			}
			customerReturn.load(getTrxName());
			if (!DocAction.STATUS_Completed.equals(customerReturn.getDocStatus()))
				complete(customerReturn);
		}
		assertEquals(DocAction.STATUS_Completed, customerReturn.getDocStatus());
	}

	protected MInOut createCustomerReturn(MInOut shipment, MInOutLine shipLine, BigDecimal qty)
	{
		MInOut customerReturn = createDraftCustomerReturn(shipment, shipLine, qty);
		completeCustomerReturn(customerReturn);
		if (!customerReturn.isPosted())
			postImmediate(customerReturn);
		return customerReturn;
	}

	protected MPPProductBOM createSimpleBOM(MProduct fg, MProduct comp, BigDecimal qtyBom)
	{
		MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
		bom.setM_Product_ID(fg.get_ID());
		bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
		bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
		bom.setName(fg.getName());
		bom.saveEx();

		MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
		bomLine.setM_Product_ID(comp.get_ID());
		bomLine.setQtyBOM(qtyBom);
		bomLine.saveEx();

		fg.load(getTrxName());
		fg.setIsVerified(true);
		fg.saveEx();
		return bom;
	}

	protected MProduction createProduction(MProduct fg, BigDecimal qty, int bomId, boolean createLines)
	{
		MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
		prod.setM_Product_ID(fg.get_ID());
		prod.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		prod.setIsUseProductionPlan(false);
		prod.setMovementDate(getLoginDate());
		prod.setDocAction(DocAction.ACTION_Complete);
		prod.setDocStatus(DocAction.STATUS_Drafted);
		prod.setIsComplete(false);
		prod.setProductionQty(qty);
		if (bomId > 0)
			prod.setPP_Product_BOM_ID(bomId);
		if (!createLines)
			prod.setIsCreated("Y");
		prod.saveEx();

		if (createLines)
		{
			MProcess process = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.CREATE_UPDATE_PRODUCTION_LINES.id);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(prod.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());
			prod.load(getTrxName());
		}
		return prod;
	}

	protected MProduction createPlanProduction(String name)
	{
		MProduction prod = new MProduction(Env.getCtx(), 0, getTrxName());
		prod.setName(name);
		prod.setIsUseProductionPlan(true);
		prod.setMovementDate(getLoginDate());
		prod.setIsCreated("Y");
		prod.saveEx();
		return prod;
	}

	protected MProductionPlan createProductionPlan(MProduction prod, int lineNo, MProduct fg, BigDecimal qty)
	{
		MProductionPlan plan = new MProductionPlan(Env.getCtx(), 0, getTrxName());
		plan.setM_Production_ID(prod.get_ID());
		plan.setLine(lineNo);
		plan.setM_Product_ID(fg.get_ID());
		plan.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		plan.setProductionQty(qty);
		plan.saveEx();
		return plan;
	}

	protected MProductionLine addProductionLine(MProduction prod, MProductionPlan plan, int lineNo,
			MProduct product, int asiId, boolean isEndProduct, BigDecimal movementQty)
	{
		MProductionLine pl = plan != null ? new MProductionLine(plan) : new MProductionLine(prod);
		pl.setLine(lineNo);
		pl.setM_Product_ID(product.get_ID());
		if (asiId > 0)
			pl.setM_AttributeSetInstance_ID(asiId);
		pl.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		pl.setIsEndProduct(isEndProduct);
		pl.setMovementQty(movementQty);
		pl.setPlannedQty(movementQty.abs());
		if (!isEndProduct)
			pl.setQtyUsed(movementQty.abs());
		pl.saveEx();
		return pl;
	}

	protected MProject createWorkOrderProject(String name)
	{
		MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
		proj.setName(name);
		proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
		proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		proj.setPlannedAmt(Env.ONE);
		proj.setCommittedQty(Env.ONE);
		proj.saveEx();
		return proj;
	}

	protected MProjectIssue createProjectIssue(MProject proj, MProduct product, int lineNo, BigDecimal qty, Timestamp date)
	{
		MProjectIssue issue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
		issue.setLine(lineNo);
		issue.setMovementDate(date != null ? date : getLoginDate());
		issue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		issue.setMovementQty(qty);
		issue.setC_Project_ID(proj.get_ID());
		issue.setM_Product_ID(product.get_ID());
		issue.saveEx();
		return issue;
	}

	protected int getProjectWipAccountId(MProject project, MAcctSchema as)
	{
		int vcId = DB.getSQLValueEx(getTrxName(),
				"SELECT PJ_WIP_Acct FROM C_Project_Acct WHERE C_Project_ID=? AND C_AcctSchema_ID=?",
				project.get_ID(), as.get_ID());
		assertTrue(vcId > 0, "PJ_WIP_Acct not found for project " + project.get_ID());
		MAccount acct = MAccount.get(Env.getCtx(), vcId);
		assertNotNull(acct, "MAccount not found for PJ_WIP_Acct=" + vcId);
		return acct.getAccount_ID();
	}

	protected List<MFactAcct> getFacts(int tableId, int recordId, int acctSchemaId)
	{
		return MFactAcct.createRecordIdQuery(tableId, recordId, acctSchemaId, getTrxName())
				.setOrderBy(MFactAcct.COLUMNNAME_Fact_Acct_ID)
				.list();
	}

	protected void assertFactTotals(List<MFactAcct> facts, int accountId, BigDecimal expectedDr, BigDecimal expectedCr)
	{
		BigDecimal actualDr = BigDecimal.ZERO;
		BigDecimal actualCr = BigDecimal.ZERO;
		for (MFactAcct fa : facts)
		{
			if (fa.getAccount_ID() == accountId)
			{
				actualDr = actualDr.add(fa.getAmtAcctDr());
				actualCr = actualCr.add(fa.getAmtAcctCr());
			}
		}
		assertEquals(expectedDr.setScale(2, RoundingMode.HALF_UP), actualDr.setScale(2, RoundingMode.HALF_UP),
				"Unexpected DR total for Account_ID=" + accountId);
		assertEquals(expectedCr.setScale(2, RoundingMode.HALF_UP), actualCr.setScale(2, RoundingMode.HALF_UP),
				"Unexpected CR total for Account_ID=" + accountId);
	}

	protected void mockProductGet(MockedStatic<MProduct> productMock, MProduct product)
	{
		productMock.when(() -> MProduct.getCopy(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()))).thenReturn(product);
		productMock.when(() -> MProduct.get(eq(product.get_ID()))).thenReturn(product);
	}
}
