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
 * - etantg                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCurrency;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProduction;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MShipper;
import org.compiere.model.MShippingProcessor;
import org.compiere.model.MShippingProcessorCfg;
import org.compiere.model.MSysConfig;
import org.compiere.model.MWarehouse;
import org.compiere.model.PO;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_C_BP_ShippingAcct;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.acct.doc.Doc;
import org.idempiere.acct.doc.DocManager;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.ConversionRateHelper;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.FactAcct;
import org.idempiere.test.ZeroCostPostingTestHelper;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * @author etantg
 */
public class InOutTest extends AbstractTestCase {
	
	public InOutTest() {
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4656
	 */
	public void testMatReceiptPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		Timestamp currentDate = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		
		int Spot_ConversionType_ID = DictionaryIDs.C_ConversionType.SPOT.id; // Spot;
		int Company_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, getTrxName());
		priceList.setName("Purchase AUD " + System.currentTimeMillis());
		MCurrency australianDollar = MCurrency.get(DictionaryIDs.C_Currency.AUD.id); // Australian Dollar (AUD)
		priceList.setC_Currency_ID(australianDollar.getC_Currency_ID());
		priceList.setPricePrecision(australianDollar.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id); // Purchase 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		BigDecimal priceInAud = new BigDecimal(23.32);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInAud, priceInAud, Env.ZERO);
		pp.saveEx();
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		BigDecimal audToUsdCompany = new BigDecimal(0.676234);
		BigDecimal audToUsdSpot = new BigDecimal(0.77);
		
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal audToEuroCompany = new BigDecimal(0.746234);
		BigDecimal audToEuroSpot = new BigDecimal(0.64);

		try (MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic();
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class)) {
			mockGetRate(conversionRateMock, australianDollar, usd, Company_ConversionType_ID, currentDate, audToUsdCompany);
			mockGetRate(conversionRateMock, australianDollar, usd, Spot_ConversionType_ID, currentDate, audToUsdSpot);
			mockGetRate(conversionRateMock, australianDollar, euro, Company_ConversionType_ID, currentDate, audToEuroCompany);
			mockGetRate(conversionRateMock, australianDollar, euro, Spot_ConversionType_ID, currentDate, audToEuroSpot);
			
			priceListMock.when(() -> MPriceList.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
			
			MOrder order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), Company_ConversionType_ID);			
			BigDecimal qtyOrdered = new BigDecimal(500);
			MOrderLine orderLine = createOrderLine(order, 10, product, qtyOrdered, priceInAud);
			completeDocument(order);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = new BigDecimal(500);
			MInOutLine receiptLine = createInOutLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdCompany;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroCompany;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				doc.setC_BPartner_ID(receipt.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				BigDecimal acctSource = orderLine.getPriceActual().multiply(receiptLine.getMovementQty())
						.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				BigDecimal acctAmount = acctSource.multiply(rate)
						.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, acctAmount, acctSource, as.getCurrency().getStdPrecision(), false, receiptLine.get_ID()));
				assertFactAcctEntries(factAccts, expected);
			}
			
			order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), Spot_ConversionType_ID);
			orderLine = createOrderLine(order, 10, product, qtyOrdered, priceInAud);
			completeDocument(order);
			
			receipt = createMMReceipt(order, currentDate);
			receiptLine = createInOutLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdSpot;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroSpot;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				doc.setC_BPartner_ID(receipt.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				BigDecimal acctSource = orderLine.getPriceActual().multiply(receiptLine.getMovementQty())
									.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				BigDecimal acctAmount = acctSource.multiply(rate)
						.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, acctAmount, acctSource, as.getCurrency().getStdPrecision(), false, receiptLine.get_ID()));
				assertFactAcctEntries(factAccts, expected);
			}
		}		
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4656
	 */
	public void testMatShipmentPosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		Timestamp currentDate = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		
		int Company_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; // Company
		
		MPriceList priceList = new MPriceList(Env.getCtx(), 0, getTrxName());
		priceList.setName("Purchase AUD " + System.currentTimeMillis());
		MCurrency australianDollar = MCurrency.get(DictionaryIDs.C_Currency.AUD.id); // Australian Dollar (AUD)
		priceList.setC_Currency_ID(australianDollar.getC_Currency_ID());
		priceList.setPricePrecision(australianDollar.getStdPrecision());
		priceList.saveEx();
		
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id); // Purchase 2001
		plv.setValidFrom(currentDate);
		plv.saveEx();
		
		BigDecimal priceInAud = new BigDecimal(23.32);
		MProductPrice pp = new MProductPrice(plv, product.getM_Product_ID(), priceInAud, priceInAud, Env.ZERO);
		pp.saveEx();
		
		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id); // USD
		BigDecimal audToUsdCompany = new BigDecimal(0.676234);
		
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id); // EUR
		BigDecimal audToEuroCompany = new BigDecimal(0.746234);
		try (MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic();
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class)) {
			mockGetRate(conversionRateMock, australianDollar, usd, Company_ConversionType_ID, currentDate, audToUsdCompany);
			mockGetRate(conversionRateMock, australianDollar, euro, Company_ConversionType_ID, currentDate, audToEuroCompany);
			
			priceListMock.when(() -> MPriceList.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
			
			MOrder order = createPurchaseOrder(bpartner, currentDate, priceList.getM_PriceList_ID(), Company_ConversionType_ID);			
			BigDecimal qtyOrdered = BigDecimal.TEN;
			MOrderLine orderLine = createOrderLine(order, 10, product, qtyOrdered, priceInAud);
			completeDocument(order);
			
			MInOut receipt = createMMReceipt(order, currentDate);			
			BigDecimal qtyDelivered = BigDecimal.TEN;
			MInOutLine receiptLine = createInOutLine(receipt, orderLine, qtyDelivered);
			completeDocument(receipt);
			postDocument(receipt);
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdCompany;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroCompany;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, receipt.get_ID(), getTrxName());
				doc.setC_BPartner_ID(receipt.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				BigDecimal acctSource = orderLine.getPriceActual().multiply(receiptLine.getMovementQty())
						.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				BigDecimal acctAmount = acctSource.multiply(rate)
						.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, receipt.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> fas = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, acctAmount, acctSource, 2, false, receiptLine.get_ID()));
				assertFactAcctEntries(fas, expected);
			}
			
			MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
			rma.setName(order.getDocumentNo());
			rma.setC_DocType_ID(DictionaryIDs.C_DocType.VENDOR_RETURN_MATERIAL.id); // Vendor Return Material
			rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id); // Damaged on Arrival
			rma.setM_InOut_ID(receipt.get_ID());
			rma.setIsSOTrx(false);
			rma.setSalesRep_ID(SystemIDs.USER_SUPERUSER); // SuperUser
			rma.saveEx();
			
			MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
			rmaLine.setLine(10);
			rmaLine.setM_RMA_ID(rma.get_ID());
			rmaLine.setM_InOutLine_ID(receiptLine.get_ID());
			rmaLine.setQty(BigDecimal.TEN);
			rmaLine.saveEx();
			
			completeDocument(rma);
			
			MInOut delivery = new MInOut(Env.getCtx(), 0, getTrxName());
			delivery.setM_RMA_ID(rma.get_ID());
			delivery.setBPartner(bpartner);
			delivery.setIsSOTrx(false);
			delivery.setMovementType(MInOut.MOVEMENTTYPE_VendorReturns);
			delivery.setC_DocType_ID(DictionaryIDs.C_DocType.MM_VENDOR_RETURN.id); // MM Vendor Return
			delivery.setDocStatus(DocAction.STATUS_Drafted);
			delivery.setDocAction(DocAction.ACTION_Complete);
			delivery.setM_Warehouse_ID(receipt.getM_Warehouse_ID());
			delivery.saveEx();
			
			MInOutLine deliveryLine = new MInOutLine(delivery);
			deliveryLine.setM_RMALine_ID(rmaLine.get_ID());
			deliveryLine.setLine(10);
			deliveryLine.setProduct(product);
			deliveryLine.setQty(BigDecimal.TEN);
			deliveryLine.setM_Locator_ID(receiptLine.getM_Locator_ID());
			deliveryLine.saveEx();
			
			completeDocument(delivery);
			postDocument(delivery);
			
			for (MAcctSchema as : ass) {
				BigDecimal rate = Env.ZERO;
				if (as.getC_Currency_ID() == usd.getC_Currency_ID())
					rate = audToUsdCompany;
				else if (as.getC_Currency_ID() == euro.getC_Currency_ID())
					rate = audToEuroCompany;
					
				Doc doc = DocManager.getDocument(as, MInOut.Table_ID, delivery.get_ID(), getTrxName());
				doc.setC_BPartner_ID(delivery.getC_BPartner_ID());
				MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);
				
				BigDecimal acctSource = orderLine.getPriceActual().multiply(deliveryLine.getMovementQty())
						.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				BigDecimal acctAmount = acctSource.multiply(rate)
						.setScale(as.getCurrency().getStdPrecision(), RoundingMode.HALF_UP);
				Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, delivery.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> fas = query.list();
				List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, acctAmount, null, 2, true, deliveryLine.get_ID()));
				assertFactAcctEntries(fas, expected);
			}
		}		
	}
	
	private MOrder createPurchaseOrder(MBPartner bpartner, Timestamp date, int M_PriceList_ID, int C_ConversionType_ID)
	{
		 return createOrder(bpartner, date, M_PriceList_ID, C_ConversionType_ID, false);
	}
	
	private MOrder createSalseOrder(MBPartner bpartner, Timestamp date, int M_PriceList_ID, int C_ConversionType_ID)
	{
		return createOrder(bpartner, date, M_PriceList_ID, C_ConversionType_ID, true);
	}

	private MOrder createOrder(MBPartner bpartner, Timestamp date, int M_PriceList_ID, int C_ConversionType_ID, boolean isSOTrx)
	{
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		order.setBPartner(bpartner);
		order.setIsSOTrx(isSOTrx);
		order.setC_DocTypeTarget_ID();
		order.setDateOrdered(date);
		order.setDateAcct(date);
		order.setM_PriceList_ID(M_PriceList_ID);
		order.setC_ConversionType_ID(C_ConversionType_ID);
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		return order;
	}
	
	private MOrderLine createOrderLine(MOrder order, int line, MProduct product, BigDecimal qty, BigDecimal price) {
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(line);
		orderLine.setProduct(product);
		orderLine.setQty(qty);
		if (price != null)
			orderLine.setPrice(price);
		else
			orderLine.setPrice();
		orderLine.saveEx();
		return orderLine;
	}
	
	private MInOut createMMReceipt(MOrder order, Timestamp date) {
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, date); // MM Receipt
		receipt.saveEx();
		return receipt;
	}
	
	
	private MInOut createShipment(MOrder order, Timestamp date) {
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, date); // MM Shipment
		receipt.saveEx();
		return receipt;
	}
	
	private MInOutLine createInOutLine(MInOut mInOut, MOrderLine orderLine, BigDecimal qty) {
		MInOutLine receiptLine = new MInOutLine(mInOut);
		receiptLine.setC_OrderLine_ID(orderLine.get_ID());
		receiptLine.setLine(orderLine.getLine());
		receiptLine.setProduct(orderLine.getProduct());
		receiptLine.setQty(qty);
		MWarehouse wh = MWarehouse.get(Env.getCtx(), mInOut.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		receiptLine.setM_Locator_ID(M_Locator_ID);
		receiptLine.saveEx();
		return receiptLine;
	}
	
	private void completeDocument(PO po) {
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
		po.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		String docStatus = (String) po.get_Value("DocStatus");
		assertEquals(DocAction.STATUS_Completed, docStatus, DocAction.STATUS_Completed + " != " + docStatus);
	}
	
	private void postDocument(PO po) {
		if (!po.get_ValueAsBoolean("Posted")) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), po.getAD_Client_ID(), po.get_Table_ID(), po.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		po.load(getTrxName());
		assertTrue(po.get_ValueAsBoolean("Posted"));
	}
	
	private void repostDocument(PO po) {
		if (po.get_ValueAsBoolean("Posted")) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), po.getAD_Client_ID(), po.get_Table_ID(), po.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		po.load(getTrxName());
		assertTrue(po.get_ValueAsBoolean("Posted"));
	}
	
	@Test
	public void testFreightCostRuleCustomerAccount() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		MShippingProcessorCfg cfg = new MShippingProcessorCfg(Env.getCtx(), 0, getTrxName());
		cfg.setHostAddress("0.0.0.0");
		cfg.setName("Test Shipping Processor Config");
		cfg.setHostPort(0);
		cfg.saveEx();
		
		MShippingProcessor processor = new MShippingProcessor(Env.getCtx(), 0, getTrxName());
		processor.setM_ShippingProcessorCfg_ID(cfg.get_ID());
		processor.setUserID("-");
		processor.setConnectionPassword("-");		
		processor.setName("Test Shipping Processor");
		processor.saveEx();

		MShipper shipper = new MShipper(Env.getCtx(), 0, getTrxName());
		shipper.setName("Test Shipper");
		shipper.setM_ShipperCfg_ID(cfg.get_ID());
		shipper.setM_ShippingProcessor_ID(processor.get_ID());
		shipper.saveEx();
		
		final String shipperAccount = "testFreightCostRuleCustomerAccount";
		
		MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
		X_C_BP_ShippingAcct acct = new X_C_BP_ShippingAcct(Env.getCtx(), 0, getTrxName());
		acct.setC_BPartner_ID(bp.getC_BPartner_ID());		
		acct.setShipperAccount(shipperAccount);
		acct.setM_ShippingProcessor_ID(processor.get_ID());
		acct.saveEx();
		
		MInOut inout = new MInOut(Env.getCtx(), 0, getTrxName());				
		inout.setBPartner(bp);
		inout.setIsSOTrx(true);
		inout.setC_Order_ID(order.getC_Order_ID());
		inout.setM_Warehouse_ID(getM_Warehouse_ID());
		inout.setC_DocType_ID();
		inout.setDeliveryViaRule(MInOut.DELIVERYVIARULE_Shipper);
		inout.setM_Shipper_ID(shipper.get_ID());
		inout.setFreightCostRule(MInOut.FREIGHTCOSTRULE_CustomerAccount);
		inout.saveEx();
		
		assertEquals(shipperAccount, inout.getShipperAccount(), "Unexpected shipper account");
		assertEquals(MInOut.FREIGHTCHARGES_Collect, inout.getFreightCharges(), "Unexpected freight charges rule");
	}
	
	/**
	 * Test cases for Credit Check
	 */
	@Test
	public void testCreditCheckInOut()
	{
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id, getTrxName());
		bpartner.setSOCreditStatus(MBPartner.SOCREDITSTATUS_NoCreditCheck);
		bpartner.saveEx();

		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id);
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");

		MOrder order = createSalseOrder(bpartner, currentDate, DictionaryIDs.M_PriceList.STANDARD.id, DictionaryIDs.C_ConversionType.COMPANY.id);
		MOrderLine orderLine = createOrderLine(order, 10, product, new BigDecimal(500), new BigDecimal(23.32));
		completeDocument(order);

		MInOut receipt = createShipment(order, currentDate);
		BigDecimal qtyDelivered = new BigDecimal(500);
		createInOutLine(receipt, orderLine, qtyDelivered);

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Prepare);
		receipt.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_InProgress, receipt.getDocStatus());

		bpartner.setSOCreditStatus(MBPartner.SOCREDITSTATUS_CreditStop);
		bpartner.saveEx();

		receipt.load(getTrxName());
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Prepare);
		assertTrue(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Invalid, receipt.getDocStatus());

		bpartner.setSOCreditStatus(MBPartner.SOCREDITSTATUS_CreditHold);
		bpartner.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Prepare);
		assertTrue(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Invalid, receipt.getDocStatus());
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-5503
	 */
	public void testShipmentRePosting() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id);
		Timestamp currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		
		// make sure there's cost for AZALEA_BUSH
		MBPartner vendor = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.SEED_FARM.id);
		MOrder purchaseOrder = createPurchaseOrder(vendor, currentDate, DictionaryIDs.M_PriceList.PURCHASE.id, DictionaryIDs.C_ConversionType.SPOT.id);
		MOrderLine poLine = createOrderLine(purchaseOrder, 10, product, new BigDecimal("1"), null);
		completeDocument(purchaseOrder);
		MInOut receipt = createMMReceipt(purchaseOrder, currentDate);
		createInOutLine(receipt, poLine, new BigDecimal("1"));
		completeDocument(receipt);
		
		MOrder order = createSalseOrder(bpartner, currentDate, DictionaryIDs.M_PriceList.STANDARD.id, DictionaryIDs.C_ConversionType.SPOT.id);
		int plv = MPriceList.get(DictionaryIDs.M_PriceList.STANDARD.id).getPriceListVersion(currentDate).get_ID();
		BigDecimal price = MProductPrice.get(Env.getCtx(), plv, product.get_ID(), getTrxName()).getPriceStd();
		MOrderLine orderLine = createOrderLine(order, 10, product, new BigDecimal("1"), price);
		completeDocument(order);
		
		MInOut delivery = createShipment(order, currentDate);
					
		MInOutLine deliveryLine = createInOutLine(delivery, orderLine, new BigDecimal("1"));
		completeDocument(delivery);
		postDocument(delivery);
		
		ProductCost pc = new ProductCost(Env.getCtx(), deliveryLine.getM_Product_ID(), deliveryLine.getM_AttributeSetInstance_ID(), getTrxName());
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		MAccount cogs = pc.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
		MAccount asset = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			
		Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, delivery.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
		List<MFactAcct> fas = query.list();
		assertTrue(fas.size() > 0, "Failed to retrieve fact posting entries for shipment document");
		boolean cogsFound = false;
		boolean assetFound = false;
		for (MFactAcct fa : fas) {
			if (cogs.getAccount_ID() == fa.getAccount_ID()) {
				if (deliveryLine.get_ID() == fa.getLine_ID()) {
					assertEquals(fa.getAmtSourceDr().abs().toPlainString(), fa.getAmtSourceDr().toPlainString(), "Not DR COGS");
					assertTrue(fa.getAmtSourceDr().signum() > 0, "Not DR COGS");
				}
				cogsFound = true;
			} else if (asset.getAccount_ID() == fa.getAccount_ID()) {
				if (deliveryLine.get_ID() == fa.getLine_ID()) {
					assertEquals(fa.getAmtSourceCr().abs().toPlainString(), fa.getAmtSourceCr().toPlainString(), "Not CR Product Asset");
					assertTrue(fa.getAmtSourceCr().signum() > 0, "Not CR Product Asset");
				}
				assetFound = true;
			}
		}
		assertTrue(cogsFound, "No COGS posting found");
		assertTrue(assetFound, "No Product Asset posting found");
		
		//re-post
		repostDocument(delivery);
		fas = query.list();
		cogsFound = false;
		assetFound = false;
		for (MFactAcct fa : fas) {
			if (cogs.getAccount_ID() == fa.getAccount_ID()) {
				if (deliveryLine.get_ID() == fa.getLine_ID()) {
					assertEquals(fa.getAmtSourceDr().abs().toPlainString(), fa.getAmtSourceDr().toPlainString(), "Not DR COGS");
					assertTrue(fa.getAmtSourceDr().signum() > 0, "Not DR COGS");
				}
				cogsFound = true;
			} else if (asset.getAccount_ID() == fa.getAccount_ID()) {
				if (deliveryLine.get_ID() == fa.getLine_ID()) {
					assertEquals(fa.getAmtSourceCr().abs().toPlainString(), fa.getAmtSourceCr().toPlainString(), "Not CR Product Asset");
					assertTrue(fa.getAmtSourceCr().signum() > 0, "Not CR Product Asset");
				}
				assetFound = true;
			}
		}
		assertTrue(cogsFound, "No COGS posting found");
		assertTrue(assetFound, "No Product Asset posting found");
	}

	@Test
	public void testShipmentZeroCostPostingByPO() {
		MBPartner vendor = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
		MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		Timestamp today = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));

		MProduct product = ZeroCostPostingTestHelper.createStockedProduct(Env.getCtx(), "TestZeroCostPO_" + System.currentTimeMillis(), DictionaryIDs.M_Product_Category.STANDARD.id, getTrxName());
		MPriceList purchasePL = ZeroCostPostingTestHelper.createPurchasePriceList(Env.getCtx(), "Purchase ZeroCostPO " + System.currentTimeMillis(), today, product.get_ID(), BigDecimal.ONE, getTrxName());
		ZeroCostPostingTestHelper.addSalesPriceListEntry(Env.getCtx(), product.get_ID(), BigDecimal.TEN, getTrxName());

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSysConfig> sysConfigMock = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			ZeroCostPostingTestHelper.mockProductGet(productMock, product);
			ZeroCostPostingTestHelper.mockPriceListGet(priceListMock, purchasePL);

			// Create & complete zero-price Purchase Order and Material Receipt
			MOrder po = createPurchaseOrder(vendor, today, purchasePL.get_ID(), DictionaryIDs.C_ConversionType.SPOT.id);
			MOrderLine poLine = new MOrderLine(po);
			poLine.setLine(10);
			poLine.setProduct(product);
			poLine.setQty(BigDecimal.TEN);
			poLine.setPriceList(BigDecimal.ONE);
			poLine.setPrice(BigDecimal.ZERO);
			poLine.saveEx();
			assertEquals(0, poLine.getPriceActual().signum(), "Expected zero price on PO line");
			completeDocument(po);

			MInOut receipt = createMMReceipt(po, today);
			createInOutLine(receipt, poLine, BigDecimal.TEN);
			completeDocument(receipt);
			postDocument(receipt);
			for (MMatchPO matchPO : MMatchPO.getInOut(Env.getCtx(), receipt.get_ID(), getTrxName())) {
				postDocument(matchPO);
			}
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", poLine.get_ID(), 0,
					MClient.get(Env.getCtx()).getAcctSchema().get_ID(), getTrxName());
			assertNotNull(cd, "Expected processed zero-cost MCostDetail for PO line");
			assertEquals(0, cd.getAmt().signum(), "Expected zero amount on MCostDetail");

			// Disable all zero-cost checks before completing shipment
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);

			MOrder so = createSalseOrder(customer, today, DictionaryIDs.M_PriceList.STANDARD.id, DictionaryIDs.C_ConversionType.SPOT.id);
			MOrderLine soLine = createOrderLine(so, 10, product, BigDecimal.ONE, BigDecimal.TEN);
			completeDocument(so);

			MInOut shipment = createShipment(so, today);
			createInOutLine(shipment, soLine, BigDecimal.ONE);
			completeDocument(shipment);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment should not post when zero-cost SysConfig checks are disabled");

			// With CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING=false, posting must fail even if other checks are true
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, true, true);
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error when CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING is false");
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment must remain unposted when PO zero-cost check is disabled");

			// With CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING=true (others false), posting must succeed
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, false, false);
			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNull(error, error);
			shipment.load(getTrxName());
			assertTrue(shipment.isPosted(), "Shipment should post when CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING is true");
		}
	}

	@Test
	public void testShipmentZeroCostPostingByInvoiceAndAcctSchemaScope() {
		MBPartner vendor = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
		MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		Timestamp today = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		long ts = System.currentTimeMillis();

		MAcctSchema[] schemas = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID(), getTrxName());
		assertTrue(schemas.length >= 2, "Expected at least 2 active accounting schemas in GardenWorld");

		MProductCategory category = ZeroCostPostingTestHelper.createStandardCostingCategory(Env.getCtx(), "StdCost ZeroInv " + ts, getTrxName());
		MProduct product = ZeroCostPostingTestHelper.createStockedProduct(Env.getCtx(), "ZeroCostInv_" + ts, category.get_ID(), getTrxName());
		MPriceList purchasePL = ZeroCostPostingTestHelper.createPurchasePriceList(Env.getCtx(), "Purchase ZeroCostInv " + ts, today, product.get_ID(), BigDecimal.ZERO, getTrxName());
		MProductPrice purchasePP = MProductPrice.get(Env.getCtx(), purchasePL.getPriceListVersion(today).get_ID(), product.get_ID(), getTrxName());
		assertNotNull(purchasePP);
		ZeroCostPostingTestHelper.addSalesPriceListEntry(Env.getCtx(), product.get_ID(), BigDecimal.TEN, getTrxName());

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> categoryMock = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSysConfig> sysConfigMock = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			ZeroCostPostingTestHelper.mockProductGet(productMock, product);
			ZeroCostPostingTestHelper.mockProductCategoryGet(categoryMock, category);
			ZeroCostPostingTestHelper.mockPriceListGet(priceListMock, purchasePL);

			// Seed MCost quantity via Physical Inventory (M_InventoryLine_ID > 0 only, not PO/Invoice/Production)
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, true);
			MInventory seedInventory = new MInventory(Env.getCtx(), 0, getTrxName());
			seedInventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			seedInventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
			seedInventory.setCostingMethod(schemas[0].getCostingMethod());
			seedInventory.saveEx();
			MInventoryLine seedLine = new MInventoryLine(seedInventory, DictionaryIDs.M_Locator.HQ.id, product.get_ID(), 0, BigDecimal.ZERO, new BigDecimal("5"));
			seedLine.saveEx();
			completeDocument(seedInventory);
			postDocument(seedInventory);

			// Switch purchase price list to positive so free purchase price list check does not match
			purchasePP.setPrices(BigDecimal.ONE, BigDecimal.ONE, BigDecimal.ZERO);
			purchasePP.saveEx();
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);

			// Create & complete a zero-price AP Vendor Invoice without a Purchase Order
			MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			invoice.setBPartner(vendor);
			invoice.setIsSOTrx(false);
			invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
			invoice.setM_PriceList_ID(purchasePL.get_ID());
			invoice.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
			invoice.setDateInvoiced(today);
			invoice.setDateAcct(today);
			invoice.saveEx();

			MInvoiceLine invLine = new MInvoiceLine(invoice);
			invLine.setLine(10);
			invLine.setProduct(product);
			invLine.setQty(new BigDecimal("5"));
			invLine.setPriceList(BigDecimal.ONE);
			invLine.setPrice(BigDecimal.ZERO);
			invLine.saveEx();
			assertEquals(0, invLine.getPriceActual().signum(), "Expected zero price on AP Invoice line");
			completeDocument(invoice);

			// Create processed zero-cost M_CostDetail (C_InvoiceLine_ID > 0, C_OrderLine_ID = 0) ONLY for the first accounting schema
			assertTrue(MCostDetail.createInvoice(schemas[0], DictionaryIDs.AD_Org.HQ.id,
					product.get_ID(), 0, invLine.get_ID(), 0,
					BigDecimal.ZERO, new BigDecimal("5"), "Zero cost vendor invoice", today, 0, getTrxName()));
			MCostDetail cd0 = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invLine.get_ID(), 0,
					schemas[0].getC_AcctSchema_ID(), getTrxName());
			assertNotNull(cd0, "Expected processed zero-cost MCostDetail for invoice line in first schema");
			assertEquals(0, cd0.getC_OrderLine_ID(), "Expected no C_OrderLine_ID on invoice-only MCostDetail");
			assertTrue(cd0.isProcessed(), "Expected processed MCostDetail");

			MOrder so = createSalseOrder(customer, today, DictionaryIDs.M_PriceList.STANDARD.id, DictionaryIDs.C_ConversionType.SPOT.id);
			MOrderLine soLine = createOrderLine(so, 10, product, BigDecimal.ONE, BigDecimal.TEN);
			completeDocument(so);

			MInOut shipment = createShipment(so, today);
			createInOutLine(shipment, soLine, BigDecimal.ONE);
			completeDocument(shipment);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment should not post when zero-cost SysConfig checks are disabled");

			// With zero-cost M_CostDetail in only the first schema, posting must fail for the second schema
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, false, false);
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error when second accounting schema has no zero-cost M_CostDetail");
			assertTrue(error.contains("No Costs for"), "Expected No Costs error for unscoped schema, got: " + error);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment must not post when another accounting schema lacks zero-cost M_CostDetail");

			// Create processed zero-cost M_CostDetail (C_InvoiceLine_ID > 0) for the remaining accounting schema(s)
			for (int i = 1; i < schemas.length; i++) {
				assertTrue(MCostDetail.createInvoice(schemas[i], DictionaryIDs.AD_Org.HQ.id,
						product.get_ID(), 0, invLine.get_ID(), 0,
						BigDecimal.ZERO, new BigDecimal("5"), "Zero cost vendor invoice", today, 0, getTrxName()));
			}

			// With CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING=false, posting must fail even if other checks are true
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, true, true);
			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error when CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING is false");
			assertTrue(error.contains("No Costs for"), "Expected No Costs error when PO/invoice check disabled, got: " + error);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted());

			// With CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING=true and zero-cost invoice detail in all schemas, posting must succeed
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, false, false);
			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNull(error, error);
			shipment.load(getTrxName());
			assertTrue(shipment.isPosted(), "Shipment should post via C_InvoiceLine_ID zero-cost MCostDetail across all schemas");
		}
	}

	@Test
	public void testShipmentZeroCostPostingByProduction() {
		MBPartner vendor = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
		MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		Timestamp today = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		long ts = System.currentTimeMillis();

		MProduct component = ZeroCostPostingTestHelper.createStockedProduct(Env.getCtx(), "ZeroCostComp_" + ts, DictionaryIDs.M_Product_Category.STANDARD.id, getTrxName());
		MProduct parent = ZeroCostPostingTestHelper.createStockedProduct(Env.getCtx(), "ZeroCostBOM_" + ts, DictionaryIDs.M_Product_Category.STANDARD.id, getTrxName());
		parent.setIsBOM(true);
		parent.setIsPurchased(false);
		parent.saveEx();

		MPriceList purchasePL = ZeroCostPostingTestHelper.createPurchasePriceList(Env.getCtx(), "Purchase ZeroCostComp " + ts, today, component.get_ID(), BigDecimal.ONE, getTrxName());
		ZeroCostPostingTestHelper.addSalesPriceListEntry(Env.getCtx(), parent.get_ID(), BigDecimal.TEN, getTrxName());

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSysConfig> sysConfigMock = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			ZeroCostPostingTestHelper.mockProductGet(productMock, component);
			ZeroCostPostingTestHelper.mockProductGet(productMock, parent);
			ZeroCostPostingTestHelper.mockPriceListGet(priceListMock, purchasePL);

			// Receive component at zero cost so component has stock and zero cost
			MOrder po = createPurchaseOrder(vendor, today, purchasePL.get_ID(), DictionaryIDs.C_ConversionType.SPOT.id);
			MOrderLine poLine = new MOrderLine(po);
			poLine.setLine(10);
			poLine.setProduct(component);
			poLine.setQty(BigDecimal.TEN);
			poLine.setPriceList(BigDecimal.ONE);
			poLine.setPrice(BigDecimal.ZERO);
			poLine.saveEx();
			completeDocument(po);

			MInOut receipt = createMMReceipt(po, today);
			createInOutLine(receipt, poLine, BigDecimal.TEN);
			completeDocument(receipt);
			postDocument(receipt);
			for (MMatchPO matchPO : MMatchPO.getInOut(Env.getCtx(), receipt.get_ID(), getTrxName())) {
				postDocument(matchPO);
			}

			// Create BOM & complete/post zero-cost production for parent
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(parent.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(parent.getName());
			bom.saveEx();

			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(component.get_ID());
			bomLine.setQtyBOM(BigDecimal.ONE);
			bomLine.saveEx();

			parent.load(getTrxName());
			parent.setIsVerified(true);
			parent.saveEx();

			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(parent.get_ID());
			production.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			production.setIsUseProductionPlan(false);
			production.setMovementDate(today);
			production.setDocAction(DocAction.ACTION_Complete);
			production.setDocStatus(DocAction.STATUS_Drafted);
			production.setIsComplete(false);
			production.setProductionQty(new BigDecimal("5"));
			production.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production.saveEx();

			MProcess process = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.CREATE_UPDATE_PRODUCTION_LINES.id);
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			production.load(getTrxName());
			completeDocument(production);
			postDocument(production);

			// Disable all zero-cost checks before completing shipment
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);

			MOrder so = createSalseOrder(customer, today, DictionaryIDs.M_PriceList.STANDARD.id, DictionaryIDs.C_ConversionType.SPOT.id);
			MOrderLine soLine = createOrderLine(so, 10, parent, BigDecimal.ONE, BigDecimal.TEN);
			completeDocument(so);

			MInOut shipment = createShipment(so, today);
			createInOutLine(shipment, soLine, BigDecimal.ONE);
			completeDocument(shipment);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment should not post when zero-cost SysConfig checks are disabled");

			// With CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING=false, posting must fail even if PO and PriceList checks are true
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, false, true);
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error when CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING is false");
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment must remain unposted when production zero-cost check is disabled");

			// With CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING=true (others false), posting must succeed
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, true, false);
			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNull(error, error);
			shipment.load(getTrxName());
			assertTrue(shipment.isPosted(), "Shipment should post when CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING is true");
		}
	}

	@Test
	public void testZeroCostPostingByFreePurchasePriceList() {
		MBPartner vendor = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
		MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		Timestamp today = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		long ts = System.currentTimeMillis();

		MProductCategory category = ZeroCostPostingTestHelper.createStandardCostingCategory(Env.getCtx(), "Standard Costing ZeroPriceList " + ts, getTrxName());
		MProduct product = ZeroCostPostingTestHelper.createStockedProduct(Env.getCtx(), "ZeroCostPL_" + ts, category.get_ID(), getTrxName());
		ZeroCostPostingTestHelper.createPurchasePriceList(Env.getCtx(), "Free Purchase PL " + ts, today, product.get_ID(), BigDecimal.ZERO, getTrxName());
		ZeroCostPostingTestHelper.addSalesPriceListEntry(Env.getCtx(), product.get_ID(), BigDecimal.TEN, getTrxName());

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> categoryMock = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSysConfig> sysConfigMock = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			ZeroCostPostingTestHelper.mockProductGet(productMock, product);
			ZeroCostPostingTestHelper.mockProductCategoryGet(categoryMock, category);

			// 1. Direct Material Receipt without PO (tests Doc_InOut Purchasing Receipt path)
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);

			MInOut receipt = new MInOut(Env.getCtx(), 0, getTrxName());
			receipt.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
			receipt.setBPartner(vendor);
			receipt.setIsSOTrx(false);
			receipt.setMovementType(MInOut.MOVEMENTTYPE_VendorReceipts);
			receipt.setC_DocType_ID(DictionaryIDs.C_DocType.MM_RECEIPT.id);
			receipt.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			receipt.setMovementDate(today);
			receipt.setDateAcct(today);
			receipt.saveEx();

			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setLine(10);
			receiptLine.setProduct(product);
			receiptLine.setQty(new BigDecimal("5"));
			receiptLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			receiptLine.saveEx();

			completeDocument(receipt);
			receipt.load(getTrxName());
			assertFalse(receipt.isPosted(), "Receipt without PO should not post when CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING is false");

			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error on receipt when CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING is false");
			receipt.load(getTrxName());
			assertFalse(receipt.isPosted());

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, true);
			error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), true, getTrxName());
			assertNull(error, error);
			receipt.load(getTrxName());
			assertTrue(receipt.isPosted(), "Receipt without PO should post when free purchase price list check is enabled");

			// Seed MCost quantity via Physical Inventory (creates M_CostDetail with M_InventoryLine_ID > 0, not PO/Production)
			MInventory seedInventory = new MInventory(Env.getCtx(), 0, getTrxName());
			seedInventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			seedInventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
			seedInventory.setCostingMethod(MClient.get(Env.getCtx()).getAcctSchema().getCostingMethod());
			seedInventory.saveEx();

			MInventoryLine seedLine = new MInventoryLine(seedInventory, DictionaryIDs.M_Locator.HQ.id, product.get_ID(), 0, BigDecimal.ZERO, new BigDecimal("5"));
			seedLine.saveEx();
			completeDocument(seedInventory);
			postDocument(seedInventory);

			// 2. Sales Shipment + positive purchase price list guard
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);

			MOrder so = createSalseOrder(customer, today, DictionaryIDs.M_PriceList.STANDARD.id, DictionaryIDs.C_ConversionType.SPOT.id);
			MOrderLine soLine = createOrderLine(so, 10, product, BigDecimal.ONE, BigDecimal.TEN);
			completeDocument(so);

			MInOut shipment = createShipment(so, today);
			createInOutLine(shipment, soLine, BigDecimal.ONE);
			completeDocument(shipment);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment should not post when CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING is false");

			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error on shipment when CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING is false");

			// Add an active positive purchase price list entry -> posting must still fail even with flag=true
			MPriceList positivePL = ZeroCostPostingTestHelper.createPurchasePriceList(Env.getCtx(), "Positive Purchase PL " + ts, today, product.get_ID(), new BigDecimal("5"), getTrxName());
			MPriceListVersion positivePLV = positivePL.getPriceListVersion(today);
			MProductPrice positivePP = MProductPrice.get(Env.getCtx(), positivePLV.get_ID(), product.get_ID(), getTrxName());
			assertNotNull(positivePP);

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, true, true);
			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error when an active positive purchase price list exists");
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment must remain unposted when an active positive purchase price list exists");

			// Deactivate positive price list entry -> posting must now succeed with CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING=true
			positivePP.setIsActive(false);
			positivePP.saveEx();

			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, true);
			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNull(error, error);
			shipment.load(getTrxName());
			assertTrue(shipment.isPosted(), "Shipment should post once only zero purchase price list is active");
		}
	}

	@Test
	public void testZeroCostPostingByPurchasePriceListVersionValidity() {
		MBPartner vendor = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
		Timestamp today = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		Timestamp past = TimeUtil.addDays(today, -10);
		Timestamp future = TimeUtil.addDays(today, 10);
		long ts = System.currentTimeMillis();

		MProductCategory category = ZeroCostPostingTestHelper.createStandardCostingCategory(Env.getCtx(), "StdCost PLV Validity " + ts, getTrxName());
		MProduct product = ZeroCostPostingTestHelper.createStockedProduct(Env.getCtx(), "ZeroCostPLV_" + ts, category.get_ID(), getTrxName());

		// Start with ONLY a future-dated zero-price version (not effective on today)
		MPriceList purchasePL = ZeroCostPostingTestHelper.createPurchasePriceList(Env.getCtx(), "Purchase PLV Validity " + ts, future, product.get_ID(), BigDecimal.ZERO, getTrxName());
		MPriceListVersion futurePLV = new Query(Env.getCtx(), MPriceListVersion.Table_Name, "M_PriceList_ID=?", getTrxName())
				.setParameters(purchasePL.get_ID())
				.first();
		assertNotNull(futurePLV);
		MProductPrice futurePP = MProductPrice.get(Env.getCtx(), futurePLV.get_ID(), product.get_ID(), getTrxName());
		assertNotNull(futurePP);

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> categoryMock = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSysConfig> sysConfigMock = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			ZeroCostPostingTestHelper.mockProductGet(productMock, product);
			ZeroCostPostingTestHelper.mockProductCategoryGet(categoryMock, category);
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);

			MInOut receipt = new MInOut(Env.getCtx(), 0, getTrxName());
			receipt.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
			receipt.setBPartner(vendor);
			receipt.setIsSOTrx(false);
			receipt.setMovementType(MInOut.MOVEMENTTYPE_VendorReceipts);
			receipt.setC_DocType_ID(DictionaryIDs.C_DocType.MM_RECEIPT.id);
			receipt.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			receipt.setMovementDate(today);
			receipt.setDateAcct(today);
			receipt.saveEx();

			MInOutLine receiptLine = new MInOutLine(receipt);
			receiptLine.setLine(10);
			receiptLine.setProduct(product);
			receiptLine.setQty(new BigDecimal("5"));
			receiptLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			receiptLine.saveEx();
			completeDocument(receipt);

			// 1. Future-only zero-price version must NOT allow posting on today
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, true);
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error when only a future-dated zero purchase price list version exists");
			receipt.load(getTrxName());
			assertFalse(receipt.isPosted());

			// 2. Add a superseded past positive version (past, price=5), an effective current zero version (today, price=0),
			//    and turn the future version into a future positive version (future, price=5) — all active on the same price list.
			futurePP.setPrices(new BigDecimal("5"), new BigDecimal("5"), BigDecimal.ZERO);
			futurePP.saveEx();
			ZeroCostPostingTestHelper.addPriceListVersion(purchasePL, past, product.get_ID(), new BigDecimal("5"));
			ZeroCostPostingTestHelper.addPriceListVersion(purchasePL, today, product.get_ID(), BigDecimal.ZERO);

			// Posting on today must succeed: superseded past positive version and future positive version must be ignored
			error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), true, getTrxName());
			assertNull(error, error);
			receipt.load(getTrxName());
			assertTrue(receipt.isPosted(), "Receipt should post when current effective purchase price list version is zero despite superseded past and future positive versions");
		}
	}

	@Test
	public void testShipmentZeroCostPostingOrgCostingLevelScope() {
		MBPartner vendor = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
		MBPartner customer = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		Timestamp today = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));
		long ts = System.currentTimeMillis();

		MAcctSchema[] schemas = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID(), getTrxName());
		assertTrue(schemas.length >= 1, "Expected at least 1 active accounting schema");

		MProductCategory category = ZeroCostPostingTestHelper.createStandardCostingCategory(
				Env.getCtx(), "OrgCostLevel ZeroCost " + ts, MAcctSchema.COSTINGLEVEL_Organization, getTrxName());
		MProduct product = ZeroCostPostingTestHelper.createStockedProduct(Env.getCtx(), "ZeroCostOrg_" + ts, category.get_ID(), getTrxName());
		MPriceList purchasePL = ZeroCostPostingTestHelper.createPurchasePriceList(Env.getCtx(), "Purchase ZeroCostOrg " + ts, today, product.get_ID(), BigDecimal.ZERO, getTrxName());
		MProductPrice purchasePP = MProductPrice.get(Env.getCtx(), purchasePL.getPriceListVersion(today).get_ID(), product.get_ID(), getTrxName());
		assertNotNull(purchasePP);
		ZeroCostPostingTestHelper.addSalesPriceListEntry(Env.getCtx(), product.get_ID(), BigDecimal.TEN, getTrxName());

		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MProductCategory> categoryMock = mockStatic(MProductCategory.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSysConfig> sysConfigMock = mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			ZeroCostPostingTestHelper.mockProductGet(productMock, product);
			ZeroCostPostingTestHelper.mockProductCategoryGet(categoryMock, category);
			ZeroCostPostingTestHelper.mockPriceListGet(priceListMock, purchasePL);

			assertEquals(MAcctSchema.COSTINGLEVEL_Organization, product.getCostingLevel(schemas[0]),
					"Expected Organization costing level on product");

			// Seed MCost quantity in STORE_CENTRAL via Physical Inventory (M_InventoryLine_ID > 0 only)
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, true);
			MInventory seedInventory = new MInventory(Env.getCtx(), 0, getTrxName());
			seedInventory.setAD_Org_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			seedInventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.STORE_CENTRAL.id);
			seedInventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
			seedInventory.setCostingMethod(schemas[0].getCostingMethod());
			seedInventory.saveEx();
			MInventoryLine seedLine = new MInventoryLine(seedInventory, DictionaryIDs.M_Locator.STORE.id, product.get_ID(), 0, BigDecimal.ZERO, new BigDecimal("5"));
			seedLine.saveEx();
			completeDocument(seedInventory);
			postDocument(seedInventory);

			// Switch purchase price list to positive so free purchase price list check does not match
			purchasePP.setPrices(BigDecimal.ONE, BigDecimal.ONE, BigDecimal.ZERO);
			purchasePP.saveEx();
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), false, false, false);

			// Create zero-price AP Vendor Invoice in HQ and zero-cost M_CostDetail ONLY for AD_Org.HQ
			MInvoice hqInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			hqInvoice.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
			hqInvoice.setBPartner(vendor);
			hqInvoice.setIsSOTrx(false);
			hqInvoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
			hqInvoice.setM_PriceList_ID(purchasePL.get_ID());
			hqInvoice.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
			hqInvoice.setDateInvoiced(today);
			hqInvoice.setDateAcct(today);
			hqInvoice.saveEx();

			MInvoiceLine hqInvLine = new MInvoiceLine(hqInvoice);
			hqInvLine.setLine(10);
			hqInvLine.setProduct(product);
			hqInvLine.setQty(new BigDecimal("5"));
			hqInvLine.setPriceList(BigDecimal.ONE);
			hqInvLine.setPrice(BigDecimal.ZERO);
			hqInvLine.saveEx();
			completeDocument(hqInvoice);

			for (MAcctSchema as : schemas) {
				assertTrue(MCostDetail.createInvoice(as, DictionaryIDs.AD_Org.HQ.id,
						product.get_ID(), 0, hqInvLine.get_ID(), 0,
						BigDecimal.ZERO, new BigDecimal("5"), "Zero cost invoice HQ", today, 0, getTrxName()));
			}

			// Create & complete Sales Order + Shipment in AD_Org.STORE_CENTRAL
			MOrder so = new MOrder(Env.getCtx(), 0, getTrxName());
			so.setAD_Org_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			so.setBPartner(customer);
			so.setIsSOTrx(true);
			so.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			so.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			so.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.STORE_CENTRAL.id);
			so.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
			so.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
			so.setDateOrdered(today);
			so.setDatePromised(today);
			so.saveEx();

			MOrderLine soLine = createOrderLine(so, 10, product, BigDecimal.ONE, BigDecimal.TEN);
			completeDocument(so);

			MInOut shipment = new MInOut(so, DictionaryIDs.C_DocType.MM_SHIPMENT.id, today);
			shipment.setAD_Org_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			shipment.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.STORE_CENTRAL.id);
			shipment.saveEx();

			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setOrderLine(soLine, DictionaryIDs.M_Locator.STORE.id, BigDecimal.ONE);
			shipmentLine.setQty(BigDecimal.ONE);
			shipmentLine.saveEx();
			completeDocument(shipment);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted());

			// Zero-cost M_CostDetail in HQ must NOT authorize zero-cost shipment in STORE_CENTRAL under Organization costing level
			ZeroCostPostingTestHelper.mockZeroCostSysConfig(sysConfigMock, getAD_Client_ID(), true, false, false);
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNotNull(error, "Expected posting error when zero-cost M_CostDetail only exists for another organization");
			assertTrue(error.contains("No Costs for"), "Expected No Costs error for unscoped org, got: " + error);
			shipment.load(getTrxName());
			assertFalse(shipment.isPosted(), "Shipment in STORE_CENTRAL must not post using HQ zero-cost M_CostDetail");

			// Create zero-cost M_CostDetail for AD_Org.STORE_CENTRAL -> posting must now succeed
			MInvoice storeInvoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			storeInvoice.setAD_Org_ID(DictionaryIDs.AD_Org.STORE_CENTRAL.id);
			storeInvoice.setBPartner(vendor);
			storeInvoice.setIsSOTrx(false);
			storeInvoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
			storeInvoice.setM_PriceList_ID(purchasePL.get_ID());
			storeInvoice.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
			storeInvoice.setDateInvoiced(today);
			storeInvoice.setDateAcct(today);
			storeInvoice.saveEx();

			MInvoiceLine storeInvLine = new MInvoiceLine(storeInvoice);
			storeInvLine.setLine(10);
			storeInvLine.setProduct(product);
			storeInvLine.setQty(new BigDecimal("5"));
			storeInvLine.setPriceList(BigDecimal.ONE);
			storeInvLine.setPrice(BigDecimal.ZERO);
			storeInvLine.saveEx();
			completeDocument(storeInvoice);

			for (MAcctSchema as : schemas) {
				assertTrue(MCostDetail.createInvoice(as, DictionaryIDs.AD_Org.STORE_CENTRAL.id,
						product.get_ID(), 0, storeInvLine.get_ID(), 0,
						BigDecimal.ZERO, new BigDecimal("5"), "Zero cost invoice STORE_CENTRAL", today, 0, getTrxName()));
			}

			error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), true, getTrxName());
			assertNull(error, error);
			shipment.load(getTrxName());
			assertTrue(shipment.isPosted(), "Shipment in STORE_CENTRAL should post once STORE_CENTRAL has a zero-cost M_CostDetail");
		}
	}

	private void mockGetRate(MockedStatic<MConversionRate> conversionRateMock, MCurrency fromCurrency,
			MCurrency toCurrency, int C_ConversionType_ID, Timestamp conversionDate, BigDecimal multiplyRate) {
		ConversionRateHelper.mockGetRate(conversionRateMock, fromCurrency, toCurrency, C_ConversionType_ID, 
				conversionDate, multiplyRate, getAD_Client_ID(), getAD_Org_ID());
		ConversionRateHelper.mockGetRate(conversionRateMock, toCurrency, fromCurrency, C_ConversionType_ID, 
				conversionDate, BigDecimal.valueOf(1d/multiplyRate.doubleValue()), getAD_Client_ID(), getAD_Org_ID());
	}
}
