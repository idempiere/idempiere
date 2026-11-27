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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
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
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProject;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;


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

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		po.load(getTrxName());
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

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());

		if (!receipt.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(),
					receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
			assertNull(error, "Receipt posting failed: " + error);
		}
		return receiptLine;
	}

	protected MInOut createSOAndShipment(MProduct product, MAttributeSetInstance asi, BigDecimal qty, BigDecimal price)
	{
		return createSOAndShipment(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id), 0, product, asi, qty, price);
	}

	protected MInOut createSOAndShipment(MBPartner bpartner, int bpartnerLocationId, MProduct product,
			MAttributeSetInstance asi, BigDecimal qty, BigDecimal price)
	{
		Timestamp date = getLoginDate();

		MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
		so.setBPartner(bpartner);
		if (bpartnerLocationId > 0)
			so.setC_BPartner_Location_ID(bpartnerLocationId);
		so.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		so.setIsSOTrx(true);
		so.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		so.setDocStatus(DocAction.STATUS_Drafted);
		so.setDocAction(DocAction.ACTION_Complete);
		so.setDateOrdered(date);
		so.setDateAcct(date);
		so.setDatePromised(date);
		so.saveEx();

		MOrderLine soLine = new MOrderLine(so);
		soLine.setLine(10);
		soLine.setProduct(product);
		soLine.setQty(qty);
		soLine.setDatePromised(date);
		soLine.setPrice(price);
		if (asi != null)
			soLine.setM_AttributeSetInstance_ID(asi.get_ID());
		soLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(so, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		so.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, so.getDocStatus());

		MInOut shipment = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, so.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();

		MInOutLine shipLine = new MInOutLine(shipment);
		shipLine.setOrderLine(soLine, 0, qty);
		shipLine.setQty(qty);
		if (asi != null)
			shipLine.setM_AttributeSetInstance_ID(asi.get_ID());
		shipLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());

		if (!shipment.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(),
					shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
			assertNull(error, "Shipment posting failed: " + error);
			shipment.load(getTrxName());
		}
		return shipment;
	}

	protected MInOut createCustomerReturn(MInOut shipment, MInOutLine shipLine, BigDecimal qty)
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

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		rma.load(getTrxName());
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

		info = MWorkflow.runDocumentActionWorkflow(customerReturn, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		customerReturn.load(getTrxName());

		// Complete any generated receipt confirmation so the customer return completes
		if (!DocAction.STATUS_Completed.equals(customerReturn.getDocStatus()))
		{
			for (MInOutConfirm confirm : customerReturn.getConfirmations(true))
			{
				if (!DocAction.STATUS_Completed.equals(confirm.getDocStatus()))
				{
					info = MWorkflow.runDocumentActionWorkflow(confirm, DocAction.ACTION_Complete);
					assertFalse(info.isError(), info.getSummary());
				}
			}
			customerReturn.load(getTrxName());
			if (!DocAction.STATUS_Completed.equals(customerReturn.getDocStatus()))
			{
				info = MWorkflow.runDocumentActionWorkflow(customerReturn, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				customerReturn.load(getTrxName());
			}
		}
		assertEquals(DocAction.STATUS_Completed, customerReturn.getDocStatus());

		if (!customerReturn.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), customerReturn.getAD_Client_ID(),
					customerReturn.get_Table_ID(), customerReturn.get_ID(), false, getTrxName());
			assertNull(error, "Customer Return posting failed: " + error);
			customerReturn.load(getTrxName());
		}
		return customerReturn;
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
