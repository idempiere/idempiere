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
 * - Elaine Tan                         							   *
 **********************************************************************/
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;
import static org.junit.jupiter.api.parallel.ResourceAccessMode.READ_WRITE;
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
import java.util.Properties;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MCharge;
import org.compiere.model.MClientInfo;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
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
import org.compiere.model.MLandedCost;
import org.compiere.model.MLandedCostAllocation;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLandedCost;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.ConversionRateHelper;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.FactAcct;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.junit.jupiter.api.parallel.ResourceLock;
import org.junit.jupiter.api.parallel.Resources;
import org.mockito.MockedStatic;

@Isolated
@ResourceLock(value = Resources.GLOBAL, mode = READ_WRITE) // ensure no other tests running at the same time as this changes AcctSchema
public class BackDateAveragePOCostingTest extends AbstractTestCase {

	public BackDateAveragePOCostingTest() {
	}

	/**
	 * Scenarios 1 Back-Date Landed Cost
	 * 1.1 Stock as of account date is zero
	 * MR1
	 * SH1
	 * Landed Cost (Back-Date)
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateLandedCostZeroStock() {
		testBackDateLandedCostZeroStock(true);
		testBackDateLandedCostZeroStock(false);
	}
	public void testBackDateLandedCostZeroStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();
		
		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateLandedCostZeroStock", new BigDecimal(5));
			mockProductGet(productMock, product);
			
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// Landed Cost (Back-Date)
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, backDate2, new BigDecimal(10), forProduct);
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}

	private void resetAcctSchema(MAcctSchema[] ass, int[] backDateDays) {
		for (int i = 0; i < ass.length; i++) {
			MAcctSchema as = ass[i];
			int backDateDay = backDateDays[i];
			if (backDateDay > -1) {
				String sql = "UPDATE C_AcctSchema SET BackDateDay=? WHERE C_AcctSchema_ID=?";
				DB.executeUpdate(sql, new Object[] {backDateDay, as.getC_AcctSchema_ID()}, false, null);
			}
			as.load(null);
		}
	} 
	
	/**
	 * Scenarios 1 Back-Date Landed Cost
	 * 1.2 Stock as of account date is not sufficient coverage
	 * MR1
	 * SH1
	 * Landed Cost (Back-Date)
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateLandedCostInsufficientStock() {
		testBackDateLandedCostInsufficientStock(true);
		testBackDateLandedCostInsufficientStock(false);
	}
	public void testBackDateLandedCostInsufficientStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateLandedCostInsufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);
			
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// Landed Cost (Back-Date)
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, backDate2, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("67.50"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("67.50"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * Scenarios 1 Back-Date Landed Cost
	 * 1.3 Stock as of account date is sufficient coverage
	 * MR1
	 * Landed Cost (Back-Date)
	 * SH1
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateLandedCostSufficientStock() {
		testBackDateLandedCostSufficientStock(true);
		testBackDateLandedCostSufficientStock(false);
	}
	public void testBackDateLandedCostSufficientStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateLandedCostSufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);
			
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// Landed Cost (Back-Date)
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, backDate2, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment1 = shipmentLine1.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment1.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("36.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("36.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MInOut shipment2 = shipmentLine2.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("67.50"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("67.50"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * Scenarios 2 Back-Date product invoice with price variance or foreign currency
	 * 2.1 Stock as of account date is zero
	 * MR1
	 * SH1
	 * Landed Cost (Back-Date)
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateLandedCostZeroStockWithPV() {
		testBackDateLandedCostZeroStockWithPV(true);
		testBackDateLandedCostZeroStockWithPV(false);
	}
	public void testBackDateLandedCostZeroStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();
		
		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateLandedCostZeroStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// Landed Cost (Back-Date)
			createLandedCost(receiptLine1, backDate2, new BigDecimal(10), forProduct);
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	} 
	
	/**
	 * Scenarios 2 Back-Date product invoice with price variance or foreign currency
	 * 2.2 Stock as of account date is not sufficient coverage
	 * MR1
	 * SH1
	 * Landed Cost (Back-Date)
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateLandedCostInsufficientStockWithPV() {
		testBackDateLandedCostInsufficientStockWithPV(true);
		testBackDateLandedCostInsufficientStockWithPV(false);
	}
	public void testBackDateLandedCostInsufficientStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateLandedCostInsufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);
			
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// Landed Cost (Back-Date)
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, backDate2, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * Scenarios 2 Back-Date product invoice with price variance or foreign currency
	 * 2.3 Stock as of account date is sufficient coverage
	 * MR1
	 * Landed Cost (Back-Date)
	 * SH1
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateLandedCostSufficientStockWithPV() {
		testBackDateLandedCostSufficientStockWithPV(true);
		testBackDateLandedCostSufficientStockWithPV(false);
	}
	public void testBackDateLandedCostSufficientStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateLandedCostSufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);
			 
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// Landed Cost (Back-Date)
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, backDate2, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 3 Back-Date material receipt after shipment/stock out
	 * MR1
	 * MR3 (Back-Date)
	 * SH
	 * MR2
	 * Internal use inventory
	 */
	@Test
	public void testBackDateReceiptAfterShipmentInventory() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptAfterShipmentInventory", new BigDecimal(10));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(2), new BigDecimal(10));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("10.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("10.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(1), new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("10.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(2), new BigDecimal(16));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("14.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(16));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("14.00"));
			
			// Internal use inventory
			MInventoryLine inventoryLine = createInventoryUse(today, product.getM_Product_ID(), new BigDecimal(1));
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("14.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(1), new BigDecimal(13));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("11.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(13));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("11.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("11.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("13.50"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("13.50"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("13.50"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("11.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("11.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MInventory inventory = inventoryLine.getParent();
			MAccount invDiffAccount = MCharge.getAccount(inventoryLine.getC_Charge_ID(), as);
			query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(invDiffAccount, new BigDecimal("13.50"), 2, true),//debit
					new FactAcct(assetAccount, new BigDecimal("13.50"), 2, false));//credit
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 4 Back-Date material receipt to the date before landed cost transaction
	 * 4.1 Stock as of landed cost account date changed from zero to not sufficient coverage. Landed cost posting in expense before performing back-date MR.
	 * MR1
	 * SH1
	 * MR3 (Back-Date)
	 * Landed Cost
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateReceiptBeforeLandedCostZero2InsufficientStock() {
		testBackDateReceiptBeforeLandedCostZero2InsufficientStock(true);
		testBackDateReceiptBeforeLandedCostZero2InsufficientStock(false);
	}
	public void testBackDateReceiptBeforeLandedCostZero2InsufficientStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptBeforeLandedCostZero2InsufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("67.50"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("67.50"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 4 Back-Date material receipt to the date before landed cost transaction
	 * 4.1 Stock as of landed cost account date changed from zero to not sufficient coverage. Landed cost posting in expense before performing back-date MR.
	 * MR1
	 * SH
	 * MR3 (Back-Date)
	 * Landed Cost
	 * MR2
	 * Internal use inventory
	 */
	@Test
	public void testBackDateReceiptBeforeLandedCostZero2InsufficientStock2() {
		testBackDateReceiptBeforeLandedCostZero2InsufficientStock2(true);
		testBackDateReceiptBeforeLandedCostZero2InsufficientStock2(false);
	}
	public void testBackDateReceiptBeforeLandedCostZero2InsufficientStock2(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptBeforeLandedCostZero2InsufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// Internal use inventory
			MInventoryLine inventoryLine = createInventoryUse(today, product.getM_Product_ID(), new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("7.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("6.75"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MInventory inventory = inventoryLine.getParent();
			MAccount invDiffAccount = MCharge.getAccount(inventoryLine.getC_Charge_ID(), as);
			query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(invDiffAccount, new BigDecimal("67.50"), 2, true),//debit
					new FactAcct(assetAccount, new BigDecimal("67.50"), 2, false));//credit
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 4 Back-Date material receipt to the date before landed cost transaction
	 * 4.2 Stock as of landed cost account date changed from zero to sufficient coverage. Landed cost posting in expense before performing back-date MR.
	 * MR1
	 * SH1
	 * MR3 (Back-Date)
	 * Landed Cost
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateReceiptBeforeLandedCostZero2SufficientStock() {
		testBackDateReceiptBeforeLandedCostZero2SufficientStock(true);
		testBackDateReceiptBeforeLandedCostZero2SufficientStock(false);
	}
	public void testBackDateReceiptBeforeLandedCostZero2SufficientStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptBeforeLandedCostZero2SufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.55"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.55"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.55"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("65.45"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("65.45"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 4 Back-Date material receipt to the date before landed cost transaction
	 * 4.3 Stock as of landed cost account date changed from shortage to sufficient coverage.
	 * MR1
	 * SH1
	 * MR3 (Back-Date)
	 * Landed Cost
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock() {
		testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock(true);
		testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock(false);
	}
	public void testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) { 
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.75));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("5.71"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.31"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.31"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.31"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("63.08"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("63.08"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 5 Back-Date material receipt to date before product invoice with price variance or foreign currency
	 * 5.1 Stock as of landed cost account date changed from zero to not sufficient coverage. Landed cost posting in expense before performing back-date MR.
	 * MR1
	 * SH1
	 * MR3 (Back-Date)
	 * Landed Cost
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateReceiptBeforeLandedCostZero2InsufficientStockWithPV() {
		testBackDateReceiptBeforeLandedCostZero2InsufficientStockWithPV(true);
		testBackDateReceiptBeforeLandedCostZero2InsufficientStockWithPV(false);
	}
	public void testBackDateReceiptBeforeLandedCostZero2InsufficientStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptBeforeLandedCostZero2InsufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 5 Back-Date material receipt to date before product invoice with price variance or foreign currency
	 * 5.2 Stock as of landed cost account date changed from zero to sufficient coverage. Landed cost posting in expense before performing back-date MR.
	 * MR1
	 * SH1
	 * MR3 (Back-Date)
	 * Landed Cost
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateReceiptBeforeLandedCostZero2SufficientStockWithPV() {
		testBackDateReceiptBeforeLandedCostZero2SufficientStockWithPV(true);
		testBackDateReceiptBeforeLandedCostZero2SufficientStockWithPV(false);
	}
	public void testBackDateReceiptBeforeLandedCostZero2SufficientStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptBeforeLandedCostZero2SufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.45"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.55"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.55"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 5 Back-Date material receipt to date before product invoice with price variance or foreign currency
	 * 5.3 Stock as of landed cost account date changed from shortage to sufficient coverage.
	 * MR1
	 * SH1
	 * MR3 (Back-Date)
	 * Landed Cost
	 * MR2
	 * SH2
	 */
	@Test
	public void testBackDateReceiptBeforeLandedCostInsufficient2SufficientStockWithPV() {
		testBackDateReceiptBeforeLandedCostInsufficient2SufficientStockWithPV(true);
		testBackDateReceiptBeforeLandedCostInsufficient2SufficientStockWithPV(false);
	}
	public void testBackDateReceiptBeforeLandedCostInsufficient2SufficientStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) { 
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.25"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.75));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine3 = createInvoiceForMR(receiptLine3, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine3.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("5.71"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.38"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.31"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.31"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * Scenarios 6 Back-Date shipment to the date before MR/other shipment transactions
	 * MR1
	 * SH2 (Back-Date)
	 * MR2
	 * SH1
	 */
	@Test
	public void testBackDateShipmentBeforeReceiptShipment() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeReceiptShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			 
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd,  shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("20.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("20.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MInOut shipment1 = shipmentLine1.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment1.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("62.50"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("62.50"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 7 Back-Date shipment to date before landed cost
	 * 7.1 Stock as of landed cost account date changed from sufficient coverage to zero.
	 * MR1
	 * SH2 (Back-Date)
	 * MR2
	 * SH1
	 * Landed Cost
	 */
	@Test
	public void testBackDateShipmentBeforeLandedCostSufficient2ZeroStock() {
		testBackDateShipmentBeforeLandedCostSufficient2ZeroStock(true);
		testBackDateShipmentBeforeLandedCostSufficient2ZeroStock(false);
	}
	public void testBackDateShipmentBeforeLandedCostSufficient2ZeroStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2ZeroStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("50.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("50.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MInOut shipment1 = shipmentLine1.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment1.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("70.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("70.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 7 Back-Date shipment to date before landed cost
	 * 7.2 Stock as of landed cost account date changed from not sufficient coverage to zero.
	 * MR1
	 * SH2 (Back-Date)
	 * MR2
	 * SH1
	 * Landed Cost
	 */
	@Test
	public void testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock() {
		testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock(true);
		testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock(false);
	}
	public void testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(16), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("20.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("20.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MInOut shipment1 = shipmentLine1.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment1.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("100.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("100.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 7 Back-Date shipment to date before landed cost
	 * 7.3 Stock as of landed cost account date changed from sufficient coverage to not sufficient.
	 * MR1
	 * SH2 (Back-Date)
	 * MR2
	 * SH1
	 * Landed Cost
	 */
	@Test
	public void testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock() {
		testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock(true);
		testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock(false);
	}
	public void testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.43"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment2 = shipmentLine2.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MInOut shipment1 = shipmentLine1.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment1.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("64.29"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("64.29"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 8 Back-Date shipment to date before product invoice with price variance or foreign currency
	 * 8.1 Stock as of landed cost account date changed from sufficient coverage to zero.
	 * MR1
	 * SH2 (Back-Date)
	 * MR2
	 * SH1
	 * Landed Cost
	 */
	@Test
	public void testBackDateShipmentBeforeLandedCostSufficient2ZeroStockWithPV() {
		testBackDateShipmentBeforeLandedCostSufficient2ZeroStockWithPV(true);
		testBackDateShipmentBeforeLandedCostSufficient2ZeroStockWithPV(false);
	}
	public void testBackDateShipmentBeforeLandedCostSufficient2ZeroStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2ZeroStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 8 Back-Date shipment to date before product invoice with price variance or foreign currency
	 * 8.2 Stock as of landed cost account date changed from not sufficient coverage to zero.
	 * MR1
	 * SH2 (Back-Date)
	 * MR2
	 * SH1
	 * Landed Cost
	 */
	@Test
	public void testBackDateShipmentBeforeLandedCostInsufficient2ZeroStockWithPV() {
		testBackDateShipmentBeforeLandedCostInsufficient2ZeroStockWithPV(true);
		testBackDateShipmentBeforeLandedCostInsufficient2ZeroStockWithPV(false);
	}
	public void testBackDateShipmentBeforeLandedCostInsufficient2ZeroStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(16), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 8 Back-Date shipment to date before product invoice with price variance or foreign currency
	 * 8.3 Stock as of landed cost account date changed from sufficient coverage to not sufficient.
	 * MR1
	 * SH2 (Back-Date)
	 * MR2
	 * SH1
	 * Landed Cost
	 */
	@Test
	public void testBackDateShipmentBeforeLandedCostSufficient2InsufficientStockWithPV() {
		testBackDateShipmentBeforeLandedCostSufficient2InsufficientStockWithPV(true);
		testBackDateShipmentBeforeLandedCostSufficient2InsufficientStockWithPV(false);
	}
	public void testBackDateShipmentBeforeLandedCostSufficient2InsufficientStockWithPV(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("7.43"));
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 9 Post-Date shipment
	 * MR1
	 * MR2 (Back-Date)
	 * SH (Post-Date)
	 */
	@Test
	public void testPostDateShipment() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPostDateShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			Timestamp postDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// SH (Post-Date)
			MInOutLine shipmentLine = createSOAndSHForProduct(postDate, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// MR2 (Back-Date)
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("36.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("36.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 9 Post-Date shipment
	 * MR1
	 * MR2 (Back-Date) - Today
	 * Internal use inventory (Post-Date)
	 */
	@Test
	public void testPostDateShipment2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPostDateShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			Timestamp postDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// Internal use inventory (Post-Date) 
			MInventoryLine inventoryLine = createInventoryUse(postDate, product.getM_Product_ID(), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("5.00")); 
			
			// MR2 (Back-Date)
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInventory inventory = inventoryLine.getParent();
			MAccount invDiffAccount = MCharge.getAccount(inventoryLine.getC_Charge_ID(), as);
			Query query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(invDiffAccount, new BigDecimal("36.00"), 2, true),//debit
					new FactAcct(assetAccount, new BigDecimal("36.00"), 2, false));//credit
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.1 Reverse-Correct MR after shipment/stock out.
	 * MR1
	 * MR2
	 * MR2 Reversal (Back-Date)
	 * SH
	 * Landed Cost
	 */
	@Test
	public void testReverseCorrectReceiptAfterShipment() {
		testReverseCorrectReceiptAfterShipment(true);
		testReverseCorrectReceiptAfterShipment(false);
	}
	public void testReverseCorrectReceiptAfterShipment(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectReceiptAfterShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.71"));
			
			// MR2 Reversal (Back-Date)
			MInOutLine reversalReceiptLine = reverseInOut(receiptLine2, false);
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", reversalReceiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, reversalReceiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			// no Ref_CostDetail_ID check - using the same cost detail when c_orderline_id+dateacct are the same
			
			MInvoiceLine reversalInvoiceLine = reverseInvoice(invoiceLine2, false);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName()); // get cost detail using original invoice line
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, reversalInvoiceLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			// no Ref_CostDetail_ID check - using the same cost detail when c_invoiceline_id+dateacct are the same
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.1 Reverse-Correct MR after shipment/stock out.
	 * MR1
	 * MR2
	 * MR2 Reversal (Back-Date) - Today
	 * SH
	 * Landed Cost
	 */
	@Test
	public void testReverseCorrectReceiptAfterShipment2() {
		testReverseCorrectReceiptAfterShipment2(true);
		testReverseCorrectReceiptAfterShipment2(false);
	}
	public void testReverseCorrectReceiptAfterShipment2(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectReceiptAfterShipment21", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.71"));
			
			// MR2 Reversal (Back-Date)
			MInOutLine reversalReceiptLine = reverseInOut(receiptLine2, false);
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", reversalReceiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, reversalReceiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			// no Ref_CostDetail_ID check - using the same cost detail when c_orderline_id+dateacct are the same
			
			MInvoiceLine reversalInvoiceLine = reverseInvoice(invoiceLine2, false);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName()); // get cost detail using original invoice line
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, reversalInvoiceLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
 			// no Ref_CostDetail_ID check - using the same cost detail when c_invoiceline_id+dateacct are the same
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.2 Reverse-Correct SH after AVG cost moved.
	 * MR1
	 * SH1
	 * SH1 Reversal (Back-Date)
	 * MR2
	 * SH2
	 */
	@Test
	public void testReverseCorrectShipmentAfterAVGCostMoved() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectShipmentAfterAVGCostMoved", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));

			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.43));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));

			// SH1 Reversal (Back-Date)
			MInOutLine reversalLine = reverseInOut(shipmentLine1, false);
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment1 = reversalLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, false),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, true));
			assertFactAcctEntries(factAccts, expected);
			
			MInOut shipment2 = shipmentLine2.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("60.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("60.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.2 Reverse-Correct SH after AVG cost moved.
	 * MR1
	 * SH1
	 * SH1 Reversal (Back-Date) - Today
	 * MR2
	 * SH2
	 */
	@Test
	public void testReverseCorrectShipmentAfterAVGCostMoved2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectShipmentAfterAVGCostMoved", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));

			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.43));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));

			// SH1 Reversal (Back-Date)
			MInOutLine reversalLine = reverseInOut(shipmentLine1, false);
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment1 = reversalLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, false),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, true));
			assertFactAcctEntries(factAccts, expected);
			
			MInOut shipment2 = shipmentLine2.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("60.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("60.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}	
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.2 Reverse-Correct SH after AVG cost moved.
	 * MR
	 * SH
	 * SH Reversal (Back-Date) - Today
	 * Landed Cost
	 */
	@Test
	public void testReverseCorrectShipmentAfterAVGCostMoved3() {
		testReverseCorrectShipmentAfterAVGCostMoved3(true);
		testReverseCorrectShipmentAfterAVGCostMoved3(false);
	}
	public void testReverseCorrectShipmentAfterAVGCostMoved3(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectShipmentAfterAVGCostMoved", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
						
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			//	SH Reversal (Back-Date)
			MInOutLine reversalLine = reverseInOut(shipmentLine, false);
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
 			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
		
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.3 Reverse-Correct Landed cost, product invoice with price variance or foreign currency.
	 * MR
	 * Landed Cost
	 * Landed Cost Reversal (Back-Date)
	 * SH
	 */
	@Test
	public void testReverseCorrectLandedCost() {
		testReverseCorrectLandedCost(true);
		testReverseCorrectLandedCost(false);
	}
	public void testReverseCorrectLandedCost(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectLandedCost", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine, backDate, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost Reversal (Back-Date)
			MInvoiceLine reversalLine = reverseLandedCost(landedCostLine, false);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", reversalLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = reversalLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, false),
					new FactAcct(apAccount, landedCost.getGrandTotal().negate(), 2, true));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.3 Reverse-Correct Landed cost, product invoice with price variance or foreign currency.
	 * MR
	 * Landed Cost
	 * Landed Cost Reversal (Back-Date) - Today
	 * SH
	 */
	@Test
	public void testReverseCorrectLandedCost2() {
		testReverseCorrectLandedCost2(true);
		testReverseCorrectLandedCost2(false);
	}
	public void testReverseCorrectLandedCost2(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectLandedCost", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost Reversal (Back-Date)
			MInvoiceLine reversalLine = reverseLandedCost(landedCostLine, false);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", reversalLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = reversalLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, false),
					new FactAcct(apAccount, landedCost.getGrandTotal().negate(), 2, true));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.3 Reverse-Correct product invoice with price variance or foreign currency.
	 * MR
	 * Purchase invoice
	 * Purchase invoice Reversal (Back-Date)
	 * SH
	 */
	@Test
	public void testReverseCorrectProductInvoice() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectProductInvoice", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Purchase Invoice
			MInvoiceLine invoiceLine = createInvoiceForMR(receiptLine, new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Purchase Invoice (Back-Date)
			MInvoiceLine reversalLine = reverseInvoice(invoiceLine, false);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName()); // get cost detail using original invoice line
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			// no Ref_CostDetail_ID check - using the same cost detail when c_invoiceline_id+dateacct are the same
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.3 Reverse-Correct product invoice with price variance or foreign currency.
	 * MR
	 * Purchase invoice
	 * Purchase invoice Reversal (Back-Date) - Today
	 * SH
	 */
	@Test
	public void testReverseCorrectProductInvoice2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectProductInvoice", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Purchase Invoice
			MInvoiceLine invoiceLine = createInvoiceForMR(receiptLine, today, new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Purchase Invoice (Back-Date)
			MInvoiceLine reversalLine = reverseInvoice(invoiceLine, false);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName()); // get cost detail using original invoice line
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			// no Ref_CostDetail_ID check - using the same cost detail when c_invoiceline_id+dateacct are the same
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("30.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("30.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.4 Reverse-Correct Internal Use after AVG cost moved.
	 * MR
	 * Internal use inventory
	 * Internal use inventory Reversal (Back-Date)
	 * Landed Cost
	 */
	@Test
	public void testReverseCorrectInternalUseAfterAVGCostMoved() {
		testReverseCorrectInternalUseAfterAVGCostMoved(true);
		testReverseCorrectInternalUseAfterAVGCostMoved(false);
	}
	public void testReverseCorrectInternalUseAfterAVGCostMoved(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectInternalUseAfterAVGCostMoved", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Internal use inventory
			MInventoryLine inventoryLine = createInventoryUse(backDate, product.getM_Product_ID(), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), true, new BigDecimal("5.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));

			// Internal use inventory Reversal (Back-Date)
			MInventoryLine reversalLine = reverseInventory(inventoryLine, false);
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversalLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, reversalLine.getParent().getMovementDate(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
 			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.4 Reverse-Correct Internal Use after AVG cost moved.
	 * MR
	 * Internal use inventory
	 * Internal use inventory Reversal (Back-Date)
	 * Landed Cost
	 */
	@Test
	public void testReverseCorrectInternalUseAfterAVGCostMoved2() {
		testReverseCorrectInternalUseAfterAVGCostMoved2(true);
		testReverseCorrectInternalUseAfterAVGCostMoved2(false);
	}
	public void testReverseCorrectInternalUseAfterAVGCostMoved2(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectInternalUseAfterAVGCostMoved2", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Internal use inventory
			MInventoryLine inventoryLine = createInventoryUse(today, product.getM_Product_ID(), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("5.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));

			// Internal use inventory Reversal (Back-Date)
			MInventoryLine reversalLine = reverseInventory(inventoryLine, false);
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", reversalLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, reversalLine.getParent().getMovementDate(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * Scenarios 10 Reverse-Correct Transactions
	 * 10.5 Reverse-Correct MR after landed cost.
	 * MR1
	 * MR1 Reversal (Back-Date)
	 * MR2
	 * SH
	 * Landed Cost
	 */
	@Test
	public void testReverseCorrectReceiptAfterLandedCost() {
		testReverseCorrectReceiptAfterLandedCost(true);
		testReverseCorrectReceiptAfterLandedCost(false);
	}
	public void testReverseCorrectReceiptAfterLandedCost(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectReceiptAfterLandedCost", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, today, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.71"));
			
			// MR1 Reversal (Back-Date)
			MInOutLine reversalReceiptLine = reverseInOut(receiptLine1, false);
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", reversalReceiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, reversalReceiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			// no Ref_CostDetail_ID check - using the same cost detail when c_orderline_id+dateacct are the same
			
			MInvoiceLine reversalInvoiceLine = reverseInvoice(invoiceLine1, false);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName()); // get cost detail using original invoice line
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, reversalInvoiceLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			// no Ref_CostDetail_ID check - using the same cost detail when c_invoiceline_id+dateacct are the same
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("8.00"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = shipmentLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("42.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("42.00"), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 11 Reverse-Accrual Transactions
	 * 11.1 Reverse-Accrual SH after shipment/stock out.
	 * MR1
	 * MR2
	 * SH
	 * SH Reversal (Back-Date)
	 * Landed Cost (Post-Date)
	 */
	@Test
	public void testReverseAccrualShipmentAfterShipment() {
		testReverseAccrualShipmentAfterShipment(true);
		testReverseAccrualShipmentAfterShipment(false);
	}
	public void testReverseAccrualShipmentAfterShipment(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseAccrualShipmentAfterShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			Timestamp postDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(backDate, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, postDate, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.71"));

			// SH Reversal (Back-Date)
			MInOutLine reversalLine = reverseInOut(shipmentLine, true);
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount cogsAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Cogs, as);
			MInOut shipment = reversalLine.getParent();
			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, shipment.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(cogsAccount, new BigDecimal("36.00"), 2, false),
					new FactAcct(assetAccount, new BigDecimal("36.00"), 2, true));
			assertFactAcctEntries(factAccts, expected);
			
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(assetAccount, new BigDecimal("10.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Scenarios 11 Reverse-Accrual Transactions
	 * 11.2 Reverse-Accrual MR after shipment/stock out.
	 * MR1
	 * MR2
	 * SH
	 * MR2 Reversal
	 * Landed Cost (Post-Date)
	 */
	@Test
	public void testReverseAccrualReceiptAfterShipment() {
		testReverseAccrualReceiptAfterShipment(true);
		testReverseAccrualReceiptAfterShipment(false);
	}
	public void testReverseAccrualReceiptAfterShipment(boolean forProduct) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseAccrualReceiptAfterShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			Timestamp postDate = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCostLine = createLandedCost(receiptLine1, postDate, new BigDecimal(10), forProduct);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("6.71"));

			// MR2 Reversal
			MInOutLine reversalLine = reverseInOut(receiptLine2, true);
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=? AND TRUNC(DateAcct)="+DB.TO_DATE(reversalLine.getParent().getDateAcct(), true), reversalLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("3.50"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCostLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, landedCostLine.getParent().getDateAcct(), false, new BigDecimal("4.50"));
			
			ProductCost productCost = new ProductCost(Env.getCtx(), product.get_ID(), 0, getTrxName());
			MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			MInvoice landedCost = landedCostLine.getParent();
			Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, landedCost.get_ID(), getTrxName());
			MAccount apAccount = doc.getAccount(Doc.ACCTTYPE_V_Liability, as);
			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, landedCost.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
					new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
					new FactAcct(apAccount, landedCost.getGrandTotal(), 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * MR
	 * Landed Cost
	 * SH
	 * Landed Cost Reversal
	 */
	@Test
	public void testUnplannedLandedCostReversalAfterShipment1() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();
		
		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			 
			BigDecimal p1price = new BigDecimal("30.00");
			MProduct p1 = createProduct("testUnplannedLandedCostReversalAfterShipment1.1", p1price);
			BigDecimal p2price = new BigDecimal("50.00");
			MProduct p2 = createProduct("testUnplannedLandedCostReversalAfterShipment1.2", p2price);
			mockProductGet(productMock, p1);
			mockProductGet(productMock, p2);
			
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			//create purchase order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			purchaseOrder.setDateAcct(backDate);
			purchaseOrder.setDateOrdered(backDate);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("10");
			poLine1.setQty(orderQty);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(10);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
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
			freightInvoice.setDateAcct(backDate);
			freightInvoice.setDateInvoiced(backDate);
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
			salesOrder.setDateAcct(today);
			salesOrder.setDateOrdered(today);
			salesOrder.saveEx();
			
			MOrderLine soLine1 = new MOrderLine(salesOrder);
			soLine1.setLine(10);
			soLine1.setProduct(p1);
			BigDecimal p1ShipQty = new BigDecimal("10");
			soLine1.setQty(p1ShipQty);
			soLine1.setPrice(new BigDecimal("50"));
			soLine1.saveEx();
			
			MOrderLine soLine2 = new MOrderLine(salesOrder);
			soLine2.setLine(20);
			soLine2.setProduct(p2);
			BigDecimal p2ShipQty = new BigDecimal("5");
			soLine2.setQty(p2ShipQty);
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
			info = MWorkflow.runDocumentActionWorkflow(freightInvoice, DocAction.ACTION_Reverse_Accrual);
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
			MAccount varianceAccount = p1ProductCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			expected = Arrays.asList(new FactAcct(varianceAccount, p1a1, 2, false),
					new FactAcct(assetAccount, p2a1.divide(new BigDecimal(2), RoundingMode.HALF_UP), 2, false),
					new FactAcct(apAccount, freightInvoice.getGrandTotal(), 2, true));
 			assertFactAcctEntries(rFactAccts, expected);
 			
 			validateProductCostQty(ass, p1);
 			validateProductCostQty(ass, p2);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * Back-Date shipment to the date before MR. Stock as of that account date was zero.
	 * Shipment should not be completed.
	 * MR
	 * SH (Back-Date)
	 */
	@Test
	public void testBackDateShipmentBeforeReceipt() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeReceipt", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// SH (Back-Date)
			Timestamp acctDate = backDate;
			int productId = product.getM_Product_ID();
			BigDecimal qty = new BigDecimal(6);
			BigDecimal price = new BigDecimal(6);

			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			order.setIsSOTrx(true);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(acctDate);
			order.setDateOrdered(acctDate);
			order.setDatePromised(acctDate);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(new MProduct(Env.getCtx(), productId, getTrxName()));
			orderLine.setQty(qty);
			orderLine.setDatePromised(acctDate);
			if (price != null)
				orderLine.setPrice(price);
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();

			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setOrderLine(orderLine, 0, qty);
			shipmentLine.setQty(qty);
			shipmentLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertTrue(info.isError(), info.getSummary());
		} finally { 
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * Back-Date shipment to the date before MRs. Stock as of that account date was zero.
	 * Shipment should not be completed.
	 * MR1
	 * MR2
	 * SH (Back-Date)
	 */
	@Test
	public void testBackDateShipmentBeforeMultipleMR() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeMultipleMR", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH (Back-Date)
			Timestamp acctDate = backDate1;
			int productId = product.getM_Product_ID();
			BigDecimal qty = new BigDecimal(6);
			BigDecimal price = new BigDecimal(6);

			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			order.setIsSOTrx(true);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(acctDate);
			order.setDateOrdered(acctDate);
			order.setDatePromised(acctDate);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(new MProduct(Env.getCtx(), productId, getTrxName()));
			orderLine.setQty(qty);
			orderLine.setDatePromised(acctDate);
			if (price != null)
				orderLine.setPrice(price);
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
			shipment.setDocStatus(DocAction.STATUS_Drafted);
			shipment.setDocAction(DocAction.ACTION_Complete);
			shipment.saveEx();

			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setOrderLine(orderLine, 0, qty);
			shipmentLine.setQty(qty);
			shipmentLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
			assertTrue(info.isError(), info.getSummary());
		} finally { 
			rollback();
			resetAcctSchema(ass, backDateDays);
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
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

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
		
		int[] backDateDays = new int[ass.length];
		MProductPrice pp1 = null;
		MProductPrice pp2 = null;
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class);
			 MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic()) {
			backDateDays = configureAcctSchema(ass);
			priceListMock.when(() -> MPriceList.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
			mockGetRate(conversionRateMock, usd, thb, 0, date1, usdToThb1);
			mockGetRate(conversionRateMock, usd, thb, 0, date2, usdToThb2);
			mockGetRate(conversionRateMock, usd, thb, 0, date3, usdToThb3);
			mockGetRate(conversionRateMock, euro, thb, 0, date1, eurToThb1);
			mockGetRate(conversionRateMock, euro, thb, 0, date2, eurToThb2);
			mockGetRate(conversionRateMock, euro, thb, 0, date3, eurToThb3);
			mockGetRate(conversionRateMock, usd, euro, C_ConversionType_ID, date1, usdToEur);
			mockGetRate(conversionRateMock, usd, euro, C_ConversionType_ID, date2, usdToEur);
			mockGetRate(conversionRateMock, usd, euro, C_ConversionType_ID, date3, usdToEur);
			
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
			pp1 = new MProductPrice(plv, product1.getM_Product_ID(), priceInThb1, priceInThb1, Env.ZERO);
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
			pp2 = new MProductPrice(plv, product2.getM_Product_ID(), priceInThb2, priceInThb2, Env.ZERO);
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
			
			validateProductCostQty(ass, product1);
			validateProductCostQty(ass, product2);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	/**
	 * MR1
	 * Physical Inventory (Back-Date)
	 * MR2 
	 * SH
	 */
	@Test
	public void testBackDateInventoryBeforeReceiptShipment() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateInventoryBeforeReceiptShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			MInOutLine receiptLine1 = createPOAndMRForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine1.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			MInvoiceLine invoiceLine1 = createInvoiceForMR(receiptLine1, new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine1.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			MInvoiceLine invoiceLine2 = createInvoiceForMR(receiptLine2, new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Physical Inventory (Back-Date)			
			MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
			inventory.setMovementDate(backDate2);
			inventory.saveEx();
			
			MInventoryLine inventoryLine = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			inventoryLine.setM_Inventory_ID(inventory.get_ID());
			inventoryLine.setM_Product_ID(product.getM_Product_ID());
			inventoryLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			BigDecimal QtyOnHand = MStorageOnHand.getQtyOnHandForLocatorWithASIMovementDate(
					inventoryLine.getM_Product_ID(), inventoryLine.getM_Locator_ID(), 
					inventoryLine.getM_AttributeSetInstance_ID(), inventory.getMovementDate(), getTrxName());
			inventoryLine.setQtyBook(QtyOnHand);
			assertEquals(new BigDecimal("10.00").setScale(2), inventoryLine.getQtyBook().setScale(2), "Unexpected Quantity Book");
			inventoryLine.setQtyCount(new BigDecimal("6.00"));
			inventoryLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			inventory.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
			if (!inventory.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), inventory.getAD_Client_ID(), inventory.get_Table_ID(), inventory.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			inventory.load(getTrxName());
			assertTrue(inventory.isPosted());
			
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetail(cd, inventoryLine.getParent().getMovementDate(), true, new BigDecimal("5.00"));
			assertEquals(new BigDecimal("6.00").setScale(2), cd.getCurrentQty().setScale(2), "Unexpected Current Quantity");
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			assertEquals(new BigDecimal("16.00").setScale(2), cd.getCurrentQty().setScale(2), "Unexpected Current Quantity");
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			assertEquals(new BigDecimal("16.00").setScale(2), cd.getCurrentQty().setScale(2), "Unexpected Current Quantity");
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			assertEquals(new BigDecimal("4.00").setScale(2), cd.getCurrentQty().setScale(2), "Unexpected Current Quantity");
			
			validateProductCostQty(ass, product); 
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * MR, Qty=10, Price=5
	 * SH1, Qty=6
	 * SH2 (Back-Date), Qty=4
	 * Purchase Invoice (MR), Qty=10, Price=6
	 */
	@Test
	public void testBackDateShipmentBeforeShipment() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateShipmentBeforeShipment", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate  = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
									 
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Purchase Invoice (MR)
			MInvoiceLine invoiceLine = createInvoiceForMR(receiptLine, today, new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoiceLine.getC_Invoice_ID(), getTrxName());
			assertEquals(1, miList.length);
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
				ProductCost productCost = new ProductCost(Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = productCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				MAccount assetAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				List<FactAcct> expected = Arrays.asList(
						new FactAcct(varianceAccount, new BigDecimal("6.00"), 2, true),
						new FactAcct(assetAccount, new BigDecimal("4.00"), 2, true),
						new FactAcct(acctInvClr, new BigDecimal("60.00"), 2, false),
						new FactAcct(acctNIR, new BigDecimal("50.00"), 2, true));
				assertFactAcctEntries(factAccts, expected);
			}

			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd,  shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			miList = MMatchInv.getInvoice(Env.getCtx(), invoiceLine.getC_Invoice_ID(), getTrxName());
			assertEquals(1, miList.length);
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
				ProductCost productCost = new ProductCost(Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount acctInvClr = productCost.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
				MAccount varianceAccount = productCost.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				List<FactAcct> expected = Arrays.asList(
						new FactAcct(varianceAccount, new BigDecimal("10.00"), 2, true),
						new FactAcct(acctInvClr, new BigDecimal("60.00"), 2, false),
						new FactAcct(acctNIR, new BigDecimal("50.00"), 2, true));
				assertFactAcctEntries(factAccts, expected);
			}
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			
		}
	}
	
	@Test
	public void testMRWithMultiASILine() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id);
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id);
		MCurrency pound = MCurrency.get(DictionaryIDs.C_Currency.GBP.id);
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; 
		
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(today.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
		cal.setTimeInMillis(today.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
		
		BigDecimal crate1 = new BigDecimal("1.0427304");
		BigDecimal crate2 = new BigDecimal("1.0387569");

		BigDecimal crate3 = new BigDecimal("35.514204");
		BigDecimal crate4 = new BigDecimal("34.968573");
 
		BigDecimal crate5 = new BigDecimal("34.061888748762");
		BigDecimal crate6 = new BigDecimal("33.676559212063");
				
		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic();
		     MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class)) {
			backDateDays = configureAcctSchema(ass);
			mockGetRate(conversionRateMock, pound, usd, 0, backDate1, crate1);
			mockGetRate(conversionRateMock, pound, usd, 0, backDate2, crate2);
			mockGetRate(conversionRateMock, pound, euro, 0, backDate1, crate3);
			mockGetRate(conversionRateMock, pound, euro, 0, backDate2, crate4);
			mockGetRate(conversionRateMock, euro, usd, 0, backDate1, crate5);
			mockGetRate(conversionRateMock, euro, usd, 0, backDate2, crate6);
			 
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testMRWithMultiASILine.1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			p1.saveEx();
			mockProductGet(productMock, p1);
			
			MPriceList priceList = new MPriceList(Env.getCtx(), 0, getTrxName());
			priceList.setName("Purchase GBP " + System.currentTimeMillis());
			priceList.setC_Currency_ID(pound.getC_Currency_ID());
			priceList.setPricePrecision(pound.getStdPrecision());
			priceList.saveEx();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
			
			MPriceListVersion plv = new MPriceListVersion(priceList);
			plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id); // Purchase 2001
			plv.setValidFrom(backDate1);
			plv.saveEx();
			
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("3.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testMRWithMultiASILine.2");
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
			BigDecimal p2price = new BigDecimal("5.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			// Purchase Order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			purchaseOrder.setDateOrdered(backDate1);
			purchaseOrder.setDatePromised(backDate1 );
			purchaseOrder.setM_PriceList_ID(plv.getM_PriceList_ID());
			purchaseOrder.setC_ConversionType_ID(C_ConversionType_ID);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("100");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(backDate1);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(20);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(backDate1);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			// Purchase invoice
			MInvoice invoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(invoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(invoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(20);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
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
			
			// Material Receipt
			MInOut receipt = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate2);
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();

			MInOutLine mrLine1 = new MInOutLine(receipt);
			BigDecimal p1l1Qty = new BigDecimal("35");
			mrLine1.setOrderLine(poLine1, 0, p1l1Qty);
			mrLine1.setQty(p1l1Qty);
			MAttributeSetInstance p1l1asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			p1l1asi.setM_AttributeSet_ID(p1.getM_AttributeSet_ID());
			p1l1asi.setLot("p1l1asi");
			p1l1asi.setDescription();
			p1l1asi.saveEx();
			mrLine1.setM_AttributeSetInstance_ID(p1l1asi.get_ID());
			mrLine1.saveEx();
			
			MInOutLine mrLine2 = new MInOutLine(receipt);
			BigDecimal p1l2Qty = new BigDecimal("50");
			mrLine2.setOrderLine(poLine1, 0, p1l2Qty);
			mrLine2.setQty(p1l2Qty);
			MAttributeSetInstance p1l2asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			p1l2asi.setM_AttributeSet_ID(p1.getM_AttributeSet_ID());
			p1l2asi.setLot("p1l2asi");
			p1l2asi.setDescription();
			p1l2asi.saveEx();
			mrLine2.setM_AttributeSetInstance_ID(p1l2asi.get_ID());
			mrLine2.saveEx();
			
			MInOutLine mrLine3 = new MInOutLine(receipt);
			BigDecimal p2l1Qty = new BigDecimal("50");
			mrLine3.setOrderLine(poLine2, 0, p2l1Qty);
			mrLine3.setQty(p2l1Qty);
			MAttributeSetInstance p2l1asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			p2l1asi.setM_AttributeSet_ID(p2.getM_AttributeSet_ID());
			p2l1asi.setLot("p2l1asi");
			p2l1asi.setDescription();
			p2l1asi.saveEx();
			mrLine3.setM_AttributeSetInstance_ID(p2l1asi.get_ID());
			mrLine3.saveEx();
			
			MInOutLine mrLine4 = new MInOutLine(receipt);
			BigDecimal p2l2Qty = new BigDecimal("50");
			mrLine4.setOrderLine(poLine2, 0, p2l2Qty);
			mrLine4.setQty(p2l2Qty);
			MAttributeSetInstance p2l2asi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			p2l2asi.setM_AttributeSet_ID(p2.getM_AttributeSet_ID());
			p2l2asi.setLot("p2l2asi");
			p2l2asi.setDescription();
			p2l2asi.saveEx();
			mrLine4.setM_AttributeSetInstance_ID(p2l2asi.get_ID());
			mrLine4.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			} 
			
			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
			assertEquals(4, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount account = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				boolean found = false;
				for (MFactAcct factAcct : factAccts) {
					if (factAcct.getAccount_ID() == account.getAccount_ID()) {
						found = true;
						break;
					}
				}
				assertTrue(found);
			} 
			
			p1.set_TrxName(getTrxName());
			MCost cost1 = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost1, "No MCost record found");			
 			assertEquals(new BigDecimal("85").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			p2.set_TrxName(getTrxName());
			MCost cost2 = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost2, "No MCost record found");			
			assertEquals(new BigDecimal("100").setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			validateProductCostQty(ass, p1);
			validateProductCostQty(ass, p2); 
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			  
		}	
	}
	
	@Test
	public void testMRWithMultiProductLine() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		MCurrency usd = MCurrency.get(DictionaryIDs.C_Currency.USD.id);
		MCurrency euro = MCurrency.get(DictionaryIDs.C_Currency.EUR.id);
		MCurrency pound = MCurrency.get(DictionaryIDs.C_Currency.GBP.id);
		int C_ConversionType_ID = DictionaryIDs.C_ConversionType.COMPANY.id; 
		
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(today.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -2);
		Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
		cal.setTimeInMillis(today.getTime());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
		
		BigDecimal crate1 = new BigDecimal("1.0427304");
		BigDecimal crate2 = new BigDecimal("1.0387569");

		BigDecimal crate3 = new BigDecimal("35.514204");
		BigDecimal crate4 = new BigDecimal("34.968573");
 
		BigDecimal crate5 = new BigDecimal("34.061888748762");
		BigDecimal crate6 = new BigDecimal("33.676559212063");
				
		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class);
			 MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic();
		     MockedStatic<MPriceList> priceListMock = mockStatic(MPriceList.class)) {
			backDateDays = configureAcctSchema(ass);
			mockGetRate(conversionRateMock, pound, usd, 0, backDate1, crate1);
			mockGetRate(conversionRateMock, pound, usd, 0, backDate2, crate2);
			mockGetRate(conversionRateMock, pound, euro, 0, backDate1, crate3);
			mockGetRate(conversionRateMock, pound, euro, 0, backDate2, crate4);
			mockGetRate(conversionRateMock, euro, usd, 0, backDate1, crate5);
			mockGetRate(conversionRateMock, euro, usd, 0, backDate2, crate6);
			 
			MProduct p1 = new MProduct(Env.getCtx(), 0, getTrxName());
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setName("testMRWithMultiProductLine.1");
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(true);
			p1.setIsSold(true);
			p1.setIsPurchased(true);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();
			mockProductGet(productMock, p1);
			
			MPriceList priceList = new MPriceList(Env.getCtx(), 0, getTrxName());
			priceList.setName("Purchase GBP " + System.currentTimeMillis());
			priceList.setC_Currency_ID(pound.getC_Currency_ID());
			priceList.setPricePrecision(pound.getStdPrecision());
			priceList.saveEx();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
			
			MPriceListVersion plv = new MPriceListVersion(priceList);
			plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id); // Purchase 2001
			plv.setValidFrom(backDate1);
			plv.saveEx();
			
			MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
			pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
			pp.setM_Product_ID(p1.get_ID());
			BigDecimal p1price = new BigDecimal("3.00");
			pp.setPriceStd(p1price);
			pp.setPriceList(p1price);
			pp.saveEx();
			
			MProduct p2 = new MProduct(Env.getCtx(), 0, getTrxName());
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setName("testMRWithMultiProductLine.2");
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
			BigDecimal p2price = new BigDecimal("5.00");
			pp.setPriceStd(p2price);
			pp.setPriceList(p2price);
			pp.saveEx();
			
			// Purchase Order
			MOrder purchaseOrder = new MOrder(Env.getCtx(), 0, getTrxName());
			purchaseOrder.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			purchaseOrder.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			purchaseOrder.setIsSOTrx(false);
			purchaseOrder.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			purchaseOrder.setDocStatus(DocAction.STATUS_Drafted);
			purchaseOrder.setDocAction(DocAction.ACTION_Complete);
			purchaseOrder.setDateOrdered(backDate1);
			purchaseOrder.setDatePromised(backDate1 );
			purchaseOrder.setM_PriceList_ID(plv.getM_PriceList_ID());
			purchaseOrder.setC_ConversionType_ID(C_ConversionType_ID);
			purchaseOrder.saveEx();

			MOrderLine poLine1 = new MOrderLine(purchaseOrder);
			poLine1.setLine(10);
			poLine1.setProduct(new MProduct(Env.getCtx(), p1.get_ID(), getTrxName()));
			BigDecimal orderQty = new BigDecimal("100");
			poLine1.setQty(orderQty);
			poLine1.setDatePromised(backDate1);
			poLine1.setPrice(p1price);
			poLine1.saveEx();
			
			MOrderLine poLine2 = new MOrderLine(purchaseOrder);
			poLine2.setLine(20);
			poLine2.setProduct(new MProduct(Env.getCtx(), p2.get_ID(), getTrxName()));
			poLine2.setQty(orderQty);
			poLine2.setDatePromised(backDate1);
			poLine2.setPrice(p2price);
			poLine2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(purchaseOrder, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			purchaseOrder.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, purchaseOrder.getDocStatus());		
			
			// Purchase invoice
			MInvoice invoice = new MInvoice(purchaseOrder, DictionaryIDs.C_DocType.AP_INVOICE.id, purchaseOrder.getDateOrdered());
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine piLine1 = new MInvoiceLine(invoice);
			piLine1.setOrderLine(poLine1);
			piLine1.setLine(10);
			piLine1.setProduct(p1);
			piLine1.setQty(poLine1.getQtyOrdered());
			piLine1.saveEx();
			
			MInvoiceLine piLine2 = new MInvoiceLine(invoice);
			piLine2.setOrderLine(poLine2);
			piLine2.setLine(20);
			piLine2.setProduct(p2);
			piLine2.setQty(poLine2.getQtyOrdered());
			piLine2.saveEx();
			
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
			
			// Material Receipt
			MInOut receipt = new MInOut(purchaseOrder, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate2);
			receipt.setDocStatus(DocAction.STATUS_Drafted);
			receipt.setDocAction(DocAction.ACTION_Complete);
			receipt.saveEx();

			MInOutLine mrLine1 = new MInOutLine(receipt);
			BigDecimal p1l1Qty = new BigDecimal("35");
			mrLine1.setOrderLine(poLine1, 0, p1l1Qty);
			mrLine1.setQty(p1l1Qty);
			mrLine1.saveEx();
			
			MInOutLine mrLine2 = new MInOutLine(receipt);
			BigDecimal p1l2Qty = new BigDecimal("50");
			mrLine2.setOrderLine(poLine1, 0, p1l2Qty);
			mrLine2.setQty(p1l2Qty);
			mrLine2.saveEx();
			
			MInOutLine mrLine3 = new MInOutLine(receipt);
			BigDecimal p2l1Qty = new BigDecimal("50");
			mrLine3.setOrderLine(poLine2, 0, p2l1Qty);
			mrLine3.setQty(p2l1Qty);
			mrLine3.saveEx();
			
			MInOutLine mrLine4 = new MInOutLine(receipt);
			BigDecimal p2l2Qty = new BigDecimal("50");
			mrLine4.setOrderLine(poLine2, 0, p2l2Qty);
			mrLine4.setQty(p2l2Qty);
			mrLine4.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
			if (!receipt.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
				assertNull(error, error);
			} 
			
			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
			assertEquals(4, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
				
				ProductCost pc = new ProductCost (Env.getCtx(), mi.getM_Product_ID(), mi.getM_AttributeSetInstance_ID(), getTrxName());
				MAccount account = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
				Query query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, mi.get_ID(), as.getC_AcctSchema_ID(), getTrxName());
				List<MFactAcct> factAccts = query.list();
				boolean found = false;
				for (MFactAcct factAcct : factAccts) {
					if (factAcct.getAccount_ID() == account.getAccount_ID()) {
						found = true;
						break;
					}
				}
				assertTrue(found);
			} 
			
			p1.set_TrxName(getTrxName());
			MCost cost1 = p1.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost1, "No MCost record found");			
 			assertEquals(new BigDecimal("85").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			p2.set_TrxName(getTrxName());
			MCost cost2 = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost2, "No MCost record found");			
			assertEquals(new BigDecimal("100").setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			validateProductCostQty(ass, p1);
			validateProductCostQty(ass, p2); 
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);			  
		}	
	}
	
	/**
	 * PO Qty=177, Price=29
	 * MR1 Qty=28
	 * SH1 Qty=28
	 * MR2 Qty=27
	 * SH2 Qty=27
	 * MR3 Qty=33
	 * PI1 Qty=28 for MR1 (Back-Date)
	 * PI2 Qty=27 for MR2 (Back-Date)
	 * SH3 Qty=33
	 */
	@Test
	public void testBackDateMultiReceiptShipmentInvoice() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateMultiReceiptShipmentInvoice", new BigDecimal(10));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// PO
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate1);
			order.setDateOrdered(backDate1);
			order.setDatePromised(backDate1);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(new MProduct(Env.getCtx(), product.getM_Product_ID(), getTrxName()));
			orderLine.setQty(new BigDecimal(177));
			orderLine.setDatePromised(today);
			orderLine.setPrice(new BigDecimal(29));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			// MR1
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate1);
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(orderLine, 0, new BigDecimal(28));
			receiptLine1.setQty(new BigDecimal(28));
			receiptLine1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			receipt1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			receipt1.load(getTrxName());
			assertTrue(receipt1.isPosted());
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("28").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);
			
 			// SH1
 			createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(28), new BigDecimal(29));
 			product.set_TrxName(getTrxName());
 			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);

 			// MR2
			MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate2);
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine receiptLine2 = new MInOutLine(receipt2);
			receiptLine2.setOrderLine(orderLine, 0, new BigDecimal(27));
			receiptLine2.setQty(new BigDecimal(27));
			receiptLine2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			receipt2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			receipt2.load(getTrxName());
			assertTrue(receipt2.isPosted());
			
			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("27").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);
			
 			// SH2
 			createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(27), new BigDecimal(29));
 			product.set_TrxName(getTrxName());
 			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);

 			// MR3
			MInOut receipt3 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, today);
			receipt3.setDocStatus(DocAction.STATUS_Drafted);
			receipt3.setDocAction(DocAction.ACTION_Complete);
			receipt3.saveEx();

			MInOutLine receiptLine3 = new MInOutLine(receipt3);
			receiptLine3.setOrderLine(orderLine, 0, new BigDecimal(33));
			receiptLine3.setQty(new BigDecimal(33));
			receiptLine3.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt3, DocAction.ACTION_Complete);
			receipt3.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt3.getDocStatus());
			if (!receipt3.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt3.getAD_Client_ID(), receipt3.get_Table_ID(), receipt3.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			receipt3.load(getTrxName());
			assertTrue(receipt3.isPosted());
			
			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("33").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);
 		 	
 			// PI1
			createInvoiceForMR(receiptLine1, backDate1, new BigDecimal(28));
			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("33").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);

 			// PI2
			createInvoiceForMR(receiptLine2, backDate2, new BigDecimal(27));
			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("33").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);

 			// SH3
 			createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(33), new BigDecimal(29));
 			product.set_TrxName(getTrxName());
 			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6694
	 * PO Qty=30, Price=20.25, Date2
	 * MR1 Qty=22, Date1
	 * MR2 Qty=8, Date1
	 * PI Date2 (Back-Date)
	 * 	Qty=30, Price=20.25
	 *  Qty=1, Price=70 - Landed Cost: Cost Distribution=Quantity, Select Product, Qty=22
	 */
	@Test
	public void testBackDateInvoiceWithMultiReceipt() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateInvoiceWithMultiReceipt", new BigDecimal(10));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// PO
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate1);
			order.setDateOrdered(backDate1);
			order.setDatePromised(backDate1);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(new MProduct(Env.getCtx(), product.getM_Product_ID(), getTrxName()));
			orderLine.setQty(new BigDecimal(30));
			orderLine.setDatePromised(today);
			orderLine.setPrice(new BigDecimal(20.25));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			// MR1
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate2);
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(orderLine, 0, new BigDecimal(22));
			receiptLine1.setQty(new BigDecimal(22));
			receiptLine1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			receipt1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			receipt1.load(getTrxName());
			assertTrue(receipt1.isPosted());
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("22").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);
 			
 			// MR2
			MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate2);
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine receiptLine2 = new MInOutLine(receipt2);
			receiptLine2.setOrderLine(orderLine, 0, new BigDecimal(8));
			receiptLine2.setQty(new BigDecimal(8));
			receiptLine2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			receipt2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			receipt2.load(getTrxName());
			assertTrue(receipt2.isPosted());
			
			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);

 			// PI (Back-Date)
 			MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
 			invoice.setOrder(order); 			
 			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
 			invoice.setDateAcct(backDate1);
 			invoice.setSalesRep_ID(order.getSalesRep_ID());
 			invoice.setC_BPartner_ID(order.getBill_BPartner_ID());
 			invoice.setC_BPartner_Location_ID(order.getBill_Location_ID());
 			invoice.setAD_User_ID(order.getBill_User_ID());
 			invoice.setDocStatus(DocAction.STATUS_Drafted);
 			invoice.setDocAction(DocAction.ACTION_Complete);
 			invoice.saveEx();
 			
 			MInvoiceLine invoiceLine1 = new MInvoiceLine(invoice);
 			invoiceLine1.setC_OrderLine_ID(orderLine.get_ID());
 			invoiceLine1.setLine(10);
 			invoiceLine1.setProduct(orderLine.getProduct());
 			invoiceLine1.setQty(new BigDecimal(30));
 			invoiceLine1.setPrice(new BigDecimal(20.25));
 			invoiceLine1.saveEx();
 			
 			MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice);
 			invoiceLine2.setLine(20);
 			invoiceLine2.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
 			invoiceLine2.setQty(BigDecimal.ONE);
 			invoiceLine2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
 			invoiceLine2.setPrice(new BigDecimal(70));
 			invoiceLine2.saveEx();
 			
 			MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
 			landedCost.setC_InvoiceLine_ID(invoiceLine2.getC_InvoiceLine_ID());
 			landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);		
			landedCost.setM_Product_ID(receiptLine1.getM_Product_ID());
			landedCost.setQty(receiptLine1.getMovementQty());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
 			landedCost.saveEx();
 			{
 				String error = landedCost.allocateCosts();
 				assertTrue(Util.isEmpty(error, true), error);
 			}
 			
 			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
 			invoice.load(getTrxName());
 			assertFalse(info.isError(), info.getSummary());
 			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
 			if (!invoice.isPosted()) {
 				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
 				assertTrue(error == null, error);
 			}
 			invoice.load(getTrxName());
 			assertTrue(invoice.isPosted());
 			
 			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
 			for (MMatchInv mi : miList) {
 				if (!mi.isPosted()) {
 					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
 					assertTrue(error == null, error);
 				}
 				mi.load(getTrxName());
 				assertTrue(mi.isPosted());
 			}
 			
 			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6694
	 * PO Qty=30, Price=20.25, Date2
	 * MR1 Qty=22, Date1
	 * MR2 Qty=8, Date1
	 * PI Date2 (Back-Date)
	 * 	Qty=30, Price=20.25
	 *  Qty=1, Price=70 - Landed Cost: Cost Distribution=Quantity, Select Product, Qty=22
	 *  Qty=1, Price=25 - Landed Cost: Cost Distribution=Quantity, Select Product, Qty=8
	 */
	@Test
	public void testBackDateInvoiceWithMultiReceipt2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testBackDateInvoiceWithMultiReceipt2", new BigDecimal(10));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			
			// PO
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate1);
			order.setDateOrdered(backDate1);
			order.setDatePromised(backDate1);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(new MProduct(Env.getCtx(), product.getM_Product_ID(), getTrxName()));
			orderLine.setQty(new BigDecimal(30));
			orderLine.setDatePromised(today);
			orderLine.setPrice(new BigDecimal(20.25));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
			
			// MR1
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate2);
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(orderLine, 0, new BigDecimal(22));
			receiptLine1.setQty(new BigDecimal(22));
			receiptLine1.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			receipt1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			receipt1.load(getTrxName());
			assertTrue(receipt1.isPosted());
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("22").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);
 			
 			// MR2
			MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate2);
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine receiptLine2 = new MInOutLine(receipt2);
			receiptLine2.setOrderLine(orderLine, 0, new BigDecimal(8));
			receiptLine2.setQty(new BigDecimal(8));
			receiptLine2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			receipt2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			receipt2.load(getTrxName());
			assertTrue(receipt2.isPosted());
			
			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);

 			// PI (Back-Date)
 			MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
 			invoice.setOrder(order); 			
 			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
 			invoice.setDateAcct(backDate1);
 			invoice.setSalesRep_ID(order.getSalesRep_ID());
 			invoice.setC_BPartner_ID(order.getBill_BPartner_ID());
 			invoice.setC_BPartner_Location_ID(order.getBill_Location_ID());
 			invoice.setAD_User_ID(order.getBill_User_ID());
 			invoice.setDocStatus(DocAction.STATUS_Drafted);
 			invoice.setDocAction(DocAction.ACTION_Complete);
 			invoice.saveEx();
 			
 			MInvoiceLine invoiceLine1 = new MInvoiceLine(invoice);
 			invoiceLine1.setC_OrderLine_ID(orderLine.get_ID());
 			invoiceLine1.setLine(10);
 			invoiceLine1.setProduct(orderLine.getProduct());
 			invoiceLine1.setQty(new BigDecimal(30));
 			invoiceLine1.setPrice(new BigDecimal(20.25));
 			invoiceLine1.saveEx();
 			
 			MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice);
 			invoiceLine2.setLine(20);
 			invoiceLine2.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
 			invoiceLine2.setQty(BigDecimal.ONE);
 			invoiceLine2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
 			invoiceLine2.setPrice(new BigDecimal(70));
 			invoiceLine2.saveEx();
 			
 			MLandedCost landedCost1 = new MLandedCost(Env.getCtx(), 0, getTrxName());
 			landedCost1.setC_InvoiceLine_ID(invoiceLine2.getC_InvoiceLine_ID());
 			landedCost1.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
 			landedCost1.setM_Product_ID(receiptLine1.getM_Product_ID());
 			landedCost1.setQty(receiptLine1.getMovementQty());
			landedCost1.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
 			landedCost1.saveEx();
 			{
 				String error = landedCost1.allocateCosts();
 				assertTrue(Util.isEmpty(error, true), error);
 			}
 			
 			MInvoiceLine invoiceLine3 = new MInvoiceLine(invoice);
 			invoiceLine3.setLine(30);
 			invoiceLine3.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
 			invoiceLine3.setQty(BigDecimal.ONE);
 			invoiceLine3.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
 			invoiceLine3.setPrice(new BigDecimal(25));
 			invoiceLine3.saveEx();
 			
 			MLandedCost landedCost2 = new MLandedCost(Env.getCtx(), 0, getTrxName());
 			landedCost2.setC_InvoiceLine_ID(invoiceLine3.getC_InvoiceLine_ID());
 			landedCost2.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);
 			landedCost2.setM_Product_ID(receiptLine2.getM_Product_ID());
 			landedCost2.setQty(receiptLine2.getMovementQty());
 			landedCost2.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Quantity);
 			landedCost2.saveEx();
 			{
 				String error = landedCost2.allocateCosts();
 				assertTrue(Util.isEmpty(error, true), error);
 			}
 			
 			info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
 			invoice.load(getTrxName());
 			assertFalse(info.isError(), info.getSummary());
 			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
 			if (!invoice.isPosted()) {
 				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
 				assertTrue(error == null, error);
 			}
 			invoice.load(getTrxName());
 			assertTrue(invoice.isPosted());
 			
 			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoice.get_ID(), getTrxName());
 			for (MMatchInv mi : miList) {
 				if (!mi.isPosted()) {
 					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
 					assertTrue(error == null, error);
 				}
 				mi.load(getTrxName());
 				assertTrue(mi.isPosted());
 			}
 			
 			product.set_TrxName(getTrxName());
			cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6694
	 * PO Qty=100
	 * MR Qty=100
	 * SH Qty=100
	 * SH Reverse-Correct
	 * MR Reverse-Correct
	 */
	@Test
	public void testReverseCorrectShipmentReceipt() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testReverseCorrectShipmentReceipt", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate  = new Timestamp(cal.getTimeInMillis());
			
			// MR
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(100), new BigDecimal(5));
			MCostDetail cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(backDate, product.getM_Product_ID(), new BigDecimal(100), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			int Ref_CostDetail_ID = cd.getM_CostDetail_ID();

			// SH Reversal
			MInOutLine reversalShipmentLine = reverseInOut(shipmentLine, false);
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalShipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, reversalShipmentLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			assertEquals(cd.getRef_CostDetail_ID(), Ref_CostDetail_ID);
			
			// MR2 Reversal
			MInOutLine reversalReceiptLine = reverseInOut(receiptLine, false);
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", reversalReceiptLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, reversalReceiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH
			MInOut shipment = shipmentLine.getParent();
			shipment.load(getTrxName());
			if (!shipment.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			shipment.load(getTrxName());
			assertTrue(shipment.isPosted());
			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * PI Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=7 (Today)
	 * MR2 Qty=1 (Today)
	 */
	@Test
	public void testPurchaseInvoiceWithMultiReceipt() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceWithMultiReceipt", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate);
			order.setDateOrdered(backDate);
			order.setDatePromised(backDate);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal(8));
			orderLine.setDatePromised(backDate);
			orderLine.setPrice(new BigDecimal(15.73));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			// Purchase invoice
			MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setOrderLine(orderLine);
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(orderLine.getQtyOrdered());
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
			
			// Material Receipt 1
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, today);
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(orderLine, 0, new BigDecimal(7));
			receiptLine1.setQty(new BigDecimal(7));
			receiptLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			// Material Receipt 2
			MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, today);
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine receiptLine2 = new MInOutLine(receipt2);
			receiptLine2.setOrderLine(orderLine, 0, new BigDecimal(1));
			receiptLine2.setQty(new BigDecimal(1));
			receiptLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt2.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
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
			} 
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * PI Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=7 (Yesterday)
	 * MR2 Qty=1 (Today)
	 */
	@Test
	public void testPurchaseInvoiceWithMultiReceipt2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceWithMultiReceipt2", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate);
			order.setDateOrdered(backDate);
			order.setDatePromised(backDate);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal(8));
			orderLine.setDatePromised(backDate);
			orderLine.setPrice(new BigDecimal(15.73));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			// Purchase invoice
			MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, order.getDateOrdered());
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();
			
			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setOrderLine(orderLine);
			invoiceLine.setLine(10);
			invoiceLine.setProduct(product);
			invoiceLine.setQty(orderLine.getQtyOrdered());
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
			
			// Material Receipt 1
			MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, backDate);
			receipt1.setDocStatus(DocAction.STATUS_Drafted);
			receipt1.setDocAction(DocAction.ACTION_Complete);
			receipt1.saveEx();

			MInOutLine receiptLine1 = new MInOutLine(receipt1);
			receiptLine1.setOrderLine(orderLine, 0, new BigDecimal(7));
			receiptLine1.setQty(new BigDecimal(7));
			receiptLine1.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt1.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
			if (!receipt1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			
			// Material Receipt 2
			MInOut receipt2 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, today);
			receipt2.setDocStatus(DocAction.STATUS_Drafted);
			receipt2.setDocAction(DocAction.ACTION_Complete);
			receipt2.saveEx();

			MInOutLine receiptLine2 = new MInOutLine(receipt2);
			receiptLine2.setOrderLine(orderLine, 0, new BigDecimal(1));
			receiptLine2.setQty(new BigDecimal(1));
			receiptLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(receipt2, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			receipt2.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, receipt2.getDocStatus());
			if (!receipt2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), receipt2.getAD_Client_ID(), receipt2.get_Table_ID(), receipt2.get_ID(), false, getTrxName());
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
			} 
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * PI Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=7 (Today)
	 * MR2 Qty=1 (Today)
	 */
	@Test
	public void testPurchaseInvoiceWithMultiReceipt3() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceWithMultiReceipt3", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate);
			order.setDateOrdered(backDate);
			order.setDatePromised(backDate);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal(8));
			orderLine.setDatePromised(backDate);
			orderLine.setPrice(new BigDecimal(15.73));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			// Purchase invoice
			createInvoiceForPO(orderLine, order.getDateOrdered(), orderLine.getQtyOrdered());
			
			// Material Receipt 1
			createMRForPO(orderLine, today, new BigDecimal(7));
			
			// Material Receipt 2
			createMRForPO(orderLine, today, new BigDecimal(1));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * PI Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=7 (Yesterday)
	 * MR2 Qty=1 (Today)
	 */
	@Test
	public void testPurchaseInvoiceWithMultiReceipt4() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceWithMultiReceipt4", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate);
			order.setDateOrdered(backDate);
			order.setDatePromised(backDate);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal(8));
			orderLine.setDatePromised(backDate);
			orderLine.setPrice(new BigDecimal(15.73));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			// Purchase invoice
			createInvoiceForPO(orderLine, order.getDateOrdered(), orderLine.getQtyOrdered());
			
			// Material Receipt 1
			createMRForPO(orderLine, backDate, new BigDecimal(7));
			
			// Material Receipt 2
			createMRForPO(orderLine, backDate, new BigDecimal(1));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=8 (Yesterday)
	 * PI Qty=7, Price=15.73 (Today)
	 * PI2 Qty=1, Price=15.73 (Today)
	 */
	@Test
	public void testMRWithMultiPurchaseInvoice() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testMRWithMultiPurchaseInvoice", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(8), new BigDecimal(15.73));
			MInOut receipt = new MInOut(Env.getCtx(), receiptLine.getM_InOut_ID(), getTrxName());
			MOrder order = new MOrder(Env.getCtx(), receipt.getC_Order_ID(), getTrxName());
			MOrderLine orderLine = new MOrderLine(Env.getCtx(), receiptLine.getC_OrderLine_ID(), getTrxName());
			
			// Purchase invoice 1
			MInvoice invoice1 = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, today);
			invoice1.setDocStatus(DocAction.STATUS_Drafted);
			invoice1.setDocAction(DocAction.ACTION_Complete);
			invoice1.saveEx();
			
			MInvoiceLine invoiceLine1 = new MInvoiceLine(invoice1);
			invoiceLine1.setOrderLine(orderLine);
			invoiceLine1.setLine(10);
			invoiceLine1.setProduct(product);
			invoiceLine1.setQty(new BigDecimal(7));
			invoiceLine1.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice1, DocAction.ACTION_Complete);
			invoice1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice1.getDocStatus());
			
			if (!invoice1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice1.getAD_Client_ID(), MInvoice.Table_ID, invoice1.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice1.load(getTrxName());
			assertTrue(invoice1.isPosted());
			
			// Purchase invoice 2
			MInvoice invoice2 = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, today);
			invoice2.setDocStatus(DocAction.STATUS_Drafted);
			invoice2.setDocAction(DocAction.ACTION_Complete);
			invoice2.saveEx();
			
			MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice2);
			invoiceLine2.setOrderLine(orderLine);
			invoiceLine2.setLine(10);
			invoiceLine2.setProduct(product);
			invoiceLine2.setQty(new BigDecimal(1));
			invoiceLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice2, DocAction.ACTION_Complete);
			invoice2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice2.getDocStatus());
			
			if (!invoice2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice2.getAD_Client_ID(), MInvoice.Table_ID, invoice2.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice2.load(getTrxName());
			assertTrue(invoice2.isPosted());
			
			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoice2.get_ID(), getTrxName());
			assertEquals(1, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
			} 
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=8 (Yesterday)
	 * PI Qty=7, Price=15.73 (Yesterday)
	 * PI2 Qty=1, Price=15.73 (Today)
	 */
	@Test
	public void testMRWithMultiPurchaseInvoice2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testMRWithMultiPurchaseInvoice2", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(8), new BigDecimal(15.73));
			MInOut receipt = new MInOut(Env.getCtx(), receiptLine.getM_InOut_ID(), getTrxName());
			MOrder order = new MOrder(Env.getCtx(), receipt.getC_Order_ID(), getTrxName());
			MOrderLine orderLine = new MOrderLine(Env.getCtx(), receiptLine.getC_OrderLine_ID(), getTrxName());
			
			// Purchase invoice 1
			MInvoice invoice1 = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, backDate);
			invoice1.setDocStatus(DocAction.STATUS_Drafted);
			invoice1.setDocAction(DocAction.ACTION_Complete);
			invoice1.saveEx();
			
			MInvoiceLine invoiceLine1 = new MInvoiceLine(invoice1);
			invoiceLine1.setOrderLine(orderLine);
			invoiceLine1.setLine(10);
			invoiceLine1.setProduct(product);
			invoiceLine1.setQty(new BigDecimal(7));
			invoiceLine1.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice1, DocAction.ACTION_Complete);
			invoice1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice1.getDocStatus());
			
			if (!invoice1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice1.getAD_Client_ID(), MInvoice.Table_ID, invoice1.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice1.load(getTrxName());
			assertTrue(invoice1.isPosted());
			
			// Purchase invoice 2
			MInvoice invoice2 = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, today);
			invoice2.setDocStatus(DocAction.STATUS_Drafted);
			invoice2.setDocAction(DocAction.ACTION_Complete);
			invoice2.saveEx();
			
			MInvoiceLine invoiceLine2 = new MInvoiceLine(invoice2);
			invoiceLine2.setOrderLine(orderLine);
			invoiceLine2.setLine(10);
			invoiceLine2.setProduct(product);
			invoiceLine2.setQty(new BigDecimal(1));
			invoiceLine2.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(invoice2, DocAction.ACTION_Complete);
			invoice2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, invoice2.getDocStatus());
			
			if (!invoice2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), invoice2.getAD_Client_ID(), MInvoice.Table_ID, invoice2.get_ID(), false, getTrxName());
				assertTrue(error == null);
			}
			invoice2.load(getTrxName());
			assertTrue(invoice2.isPosted());
			
			MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), invoice2.get_ID(), getTrxName());
			assertEquals(1, miList.length);
			for (MMatchInv mi : miList) {
				if (!mi.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
					assertTrue(error == null);
				}
				mi.load(getTrxName());
				assertTrue(mi.isPosted());
			} 
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=8 (Yesterday)
	 * PI Qty=7, Price=15.73 (Today)
	 * PI2 Qty=1, Price=15.73 (Today)
	 */
	@Test
	public void testMRWithMultiPurchaseInvoice3() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testMRWithMultiPurchaseInvoice3", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(8), new BigDecimal(15.73));
			MOrderLine orderLine = new MOrderLine(Env.getCtx(), receiptLine.getC_OrderLine_ID(), getTrxName());
			
			// Purchase invoice 1
			createInvoiceForPO(orderLine, today, new BigDecimal(7));
			
			// Purchase invoice 2
			createInvoiceForPO(orderLine, today, new BigDecimal(1));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6707
	 * PO Qty=8, Price=15.73 (Yesterday)
	 * MR Qty=8 (Yesterday)
	 * PI Qty=7, Price=15.73 (Yesterday)
	 * PI2 Qty=1, Price=15.73 (Today)
	 */
	@Test
	public void testMRWithMultiPurchaseInvoice4() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testMRWithMultiPurchaseInvoice4", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(8), new BigDecimal(15.73));
			MOrderLine orderLine = new MOrderLine(Env.getCtx(), receiptLine.getC_OrderLine_ID(), getTrxName());
			
			// Purchase invoice 1
			createInvoiceForPO(orderLine, backDate, new BigDecimal(7));
			
			// Purchase invoice 2
			createInvoiceForPO(orderLine, today, new BigDecimal(1));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("8").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
 			
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6704
	 * MR1 Product1, Qty=52, Std Cost Price=28.94
	 * MR2 Product2, Qty=52, Std Cost Price=30
	 * SH1 Product2, Qty=50, Date1 - Complete
	 * SH2 Product1, Qty=50, Product2, Qty=1, Date2 - In Progress
	 * Cost Adjustment Product1, Std Cost Price=30, Date3
	 * SH2 - Complete (Back-Date)
	 * Internal use inventory Product1, Qty=-10, Today
	 * SH1 (Reverse-Correct)
	 */
	@Test
	public void testBackDateShipmentAfterCostAdjustment() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();
		
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

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product1 = createProduct("testBackDateShipmentAfterCostAdjustment1", new BigDecimal(28.94), category.get_ID());
			mockProductGet(productMock, product1);
			MProduct product2 = createProduct("testBackDateShipmentAfterCostAdjustment2", new BigDecimal(30), category.get_ID());
			mockProductGet(productMock, product2);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -3);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate3  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			createPOAndMRForProduct(backDate1, product1.get_ID(), new BigDecimal(52), new BigDecimal(28.94));
			// MR2
			createPOAndMRForProduct(backDate1, product2.get_ID(), new BigDecimal(52), new BigDecimal(30.00));
			// SH1 - Complete
			MInOutLine shipment1Line1 = createSOAndSHForProduct(backDate1, product2.get_ID(), new BigDecimal(50), new BigDecimal(30.00));
			
			// SO2
			MOrder salesOrder2 = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder2.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			salesOrder2.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			salesOrder2.setIsSOTrx(true);
			salesOrder2.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			salesOrder2.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder2.setDocAction(DocAction.ACTION_Complete);
			salesOrder2.setDateAcct(backDate2);
			salesOrder2.setDateOrdered(backDate2);
			salesOrder2.setDatePromised(backDate2);		
			salesOrder2.saveEx();

			MOrderLine salesOrder2Line1 = new MOrderLine(salesOrder2);
			salesOrder2Line1.setLine(10);
			salesOrder2Line1.setProduct(new MProduct(Env.getCtx(), product1.get_ID(), getTrxName()));
			salesOrder2Line1.setQty(new BigDecimal(50));
			salesOrder2Line1.setDatePromised(backDate2);
			salesOrder2Line1.setPrice(new BigDecimal(28.94));
			salesOrder2Line1.saveEx();
			
			MOrderLine salesOrder2Line2 = new MOrderLine(salesOrder2);
			salesOrder2Line2.setLine(20);
			salesOrder2Line2.setProduct(new MProduct(Env.getCtx(), product2.get_ID(), getTrxName()));
			salesOrder2Line2.setQty(new BigDecimal(1));
			salesOrder2Line2.setDatePromised(backDate2);
			salesOrder2Line2.setPrice(new BigDecimal(30));
			salesOrder2Line2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(salesOrder2, DocAction.ACTION_Complete);
			salesOrder2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder2.getDocStatus());		
			
			// SH2 - In Progress
			MInOut shipment2 = new MInOut(salesOrder2, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder2.getDateOrdered());
			shipment2.setDocStatus(DocAction.STATUS_Drafted);
			shipment2.setDocAction(DocAction.ACTION_Complete);
			shipment2.saveEx();

			MInOutLine shipment2Line1 = new MInOutLine(shipment2);
			shipment2Line1.setOrderLine(salesOrder2Line1, 0, new BigDecimal(50));
			shipment2Line1.setQty(new BigDecimal(50));
			shipment2Line1.saveEx();
			
			MInOutLine shipment2Line2 = new MInOutLine(shipment2);
			shipment2Line2.setOrderLine(salesOrder2Line2, 0, new BigDecimal(1));
			shipment2Line2.setQty(new BigDecimal(1));
			shipment2Line2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(shipment2, DocAction.ACTION_Prepare);
			shipment2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_InProgress, shipment2.getDocStatus());

			// Cost Adjustment
			MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
			inventory.setC_Currency_ID(as.getC_Currency_ID());
			inventory.setCostingMethod(MCostElement.COSTINGMETHOD_StandardCosting);
			inventory.setMovementDate(backDate3);			
			inventory.saveEx();
			
			MCost cost1 = product1.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
			assertNotNull(cost1, "No MCost record found");
			BigDecimal currentCost = cost1.getCurrentCostPrice();
			assertEquals(new BigDecimal(28.94).setScale(2, RoundingMode.HALF_UP), currentCost.setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			BigDecimal newCost = new BigDecimal(30);
			
			MInventoryLine line = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			line.setM_Inventory_ID(inventory.get_ID());
			line.setM_Product_ID(product1.get_ID());
			line.setCurrentCostPrice(currentCost);
			line.setNewCostPrice(newCost);
			line.saveEx();
			
			info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
			inventory.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
			if (!inventory.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), inventory.getAD_Client_ID(), inventory.get_Table_ID(), inventory.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			inventory.load(getTrxName());
			assertTrue(inventory.isPosted());
			
			Query query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			BigDecimal invDiff = newCost.subtract(currentCost).multiply(new BigDecimal("52"));
			ProductCost pc = new ProductCost (Env.getCtx(), product1.getM_Product_ID(), 0, getTrxName());
			MAccount assetAccount = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount costAdjAccount = pc.getAccount(ProductCost.ACCTTYPE_P_CostAdjustment, as);
			List<FactAcct> expected = Arrays.asList(
					new FactAcct(assetAccount, invDiff, 2, true),
					new FactAcct(costAdjAccount, invDiff, 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			cost1.load(getTrxName());
			assertEquals(newCost.setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			assertEquals(new BigDecimal("52").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			// SH2 - Complete
			info = MWorkflow.runDocumentActionWorkflow(shipment2, DocAction.ACTION_Complete);
			shipment2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, shipment2.getDocStatus());
			if (!shipment2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), shipment2.getAD_Client_ID(), shipment2.get_Table_ID(), shipment2.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			shipment2.load(getTrxName());
			assertTrue(shipment2.isPosted());
			
			query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			invDiff = newCost.subtract(currentCost).multiply(new BigDecimal("2"));			
			expected = Arrays.asList(
					new FactAcct(assetAccount, invDiff, 2, true),
					new FactAcct(costAdjAccount, invDiff, 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			cost1.load(getTrxName());
			assertEquals(newCost.setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			// Inventory Increase
			createInventoryUse(today, product1.get_ID(), new BigDecimal(-10));
			
			cost1.load(getTrxName());
			assertEquals(newCost.setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			assertEquals(new BigDecimal("12").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			// SH1 (Reverse-Correct)
			reverseInOut(shipment1Line1, false);
			
			cost1.load(getTrxName());
			assertEquals(newCost.setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			assertEquals(new BigDecimal("12").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			 			
			validateProductCostQty(ass, product1);
			validateProductCostQty(ass, product2);
		} finally {
			rollback();
			category.deleteEx(true);
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6704
	 * MR1 Product1, Qty=52, Std Cost Price=28.94
	 * MR2 Product2, Qty=52, Std Cost Price=30
	 * SH1 Product2, Qty=50, Date1 - Complete
	 * SH2 Product1, Qty=50, Product2, Qty=1, Date2 - In Progress
	 * Cost Adjustment2 Product1, Std Cost Price=30, Date3
	 * Cost Adjustment1 Product1, Std Cost Price=29, Date1 (Back-Date)
	 * SH2 - Complete (Back-Date)
	 * Internal use inventory Product1, Qty=-10, Today
	 * SH1 (Reverse-Correct)
	 */
	@Test
	public void testBackDateShipmentAfterCostAdjustment2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();
		
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

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product1 = createProduct("testBackDateShipmentAfterCostAdjustment21", new BigDecimal(28.94), category.get_ID());
			mockProductGet(productMock, product1);
			MProduct product2 = createProduct("testBackDateShipmentAfterCostAdjustment22", new BigDecimal(30), category.get_ID());
			mockProductGet(productMock, product2);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -3);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate2  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate3  = new Timestamp(cal.getTimeInMillis());
			
			// MR1
			createPOAndMRForProduct(backDate1, product1.get_ID(), new BigDecimal(52), new BigDecimal(28.94));
			// MR2
			createPOAndMRForProduct(backDate1, product2.get_ID(), new BigDecimal(52), new BigDecimal(30.00));
			// SH1 - Complete
			MInOutLine shipment1Line1 = createSOAndSHForProduct(backDate1, product2.get_ID(), new BigDecimal(50), new BigDecimal(30.00));
			
			MCost cost0 = product1.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
			assertNotNull(cost0, "No MCost record found");
			
			// SO2
			MOrder salesOrder2 = new MOrder(Env.getCtx(), 0, getTrxName());
			salesOrder2.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			salesOrder2.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
			salesOrder2.setIsSOTrx(true);
			salesOrder2.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			salesOrder2.setDocStatus(DocAction.STATUS_Drafted);
			salesOrder2.setDocAction(DocAction.ACTION_Complete);
			salesOrder2.setDateAcct(backDate2);
			salesOrder2.setDateOrdered(backDate2);
			salesOrder2.setDatePromised(backDate2);		
			salesOrder2.saveEx();

			MOrderLine salesOrder2Line1 = new MOrderLine(salesOrder2);
			salesOrder2Line1.setLine(10);
			salesOrder2Line1.setProduct(new MProduct(Env.getCtx(), product1.get_ID(), getTrxName()));
			salesOrder2Line1.setQty(new BigDecimal(50));
			salesOrder2Line1.setDatePromised(backDate2);
			salesOrder2Line1.setPrice(new BigDecimal(28.94));
			salesOrder2Line1.saveEx();
			
			MOrderLine salesOrder2Line2 = new MOrderLine(salesOrder2);
			salesOrder2Line2.setLine(20);
			salesOrder2Line2.setProduct(new MProduct(Env.getCtx(), product2.get_ID(), getTrxName()));
			salesOrder2Line2.setQty(new BigDecimal(1));
			salesOrder2Line2.setDatePromised(backDate2);
			salesOrder2Line2.setPrice(new BigDecimal(30));
			salesOrder2Line2.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(salesOrder2, DocAction.ACTION_Complete);
			salesOrder2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, salesOrder2.getDocStatus());		
			
			// SH2 - In Progress
			MInOut shipment2 = new MInOut(salesOrder2, DictionaryIDs.C_DocType.MM_SHIPMENT.id, salesOrder2.getDateOrdered());
			shipment2.setDocStatus(DocAction.STATUS_Drafted);
			shipment2.setDocAction(DocAction.ACTION_Complete);
			shipment2.saveEx();

			MInOutLine shipment2Line1 = new MInOutLine(shipment2);
			shipment2Line1.setOrderLine(salesOrder2Line1, 0, new BigDecimal(50));
			shipment2Line1.setQty(new BigDecimal(50));
			shipment2Line1.saveEx();
			
			MInOutLine shipment2Line2 = new MInOutLine(shipment2);
			shipment2Line2.setOrderLine(salesOrder2Line2, 0, new BigDecimal(1));
			shipment2Line2.setQty(new BigDecimal(1));
			shipment2Line2.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(shipment2, DocAction.ACTION_Prepare);
			shipment2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_InProgress, shipment2.getDocStatus());

			// Cost Adjustment 1
			MInventory inventory1 = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory1.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
			inventory1.setC_Currency_ID(as.getC_Currency_ID());
			inventory1.setCostingMethod(MCostElement.COSTINGMETHOD_StandardCosting);
			inventory1.setMovementDate(backDate3);			
			inventory1.saveEx();
			
			MCost cost1 = product1.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
			assertNotNull(cost1, "No MCost record found");
			BigDecimal currentCost1 = cost1.getCurrentCostPrice();
			assertEquals(new BigDecimal(28.94).setScale(2, RoundingMode.HALF_UP), currentCost1.setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			BigDecimal newCost1 = new BigDecimal(30);
			
			MInventoryLine inventoryLine1 = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			inventoryLine1.setM_Inventory_ID(inventory1.get_ID());
			inventoryLine1.setM_Product_ID(product1.get_ID());
			inventoryLine1.setCurrentCostPrice(currentCost1);
			inventoryLine1.setNewCostPrice(newCost1);
			inventoryLine1.saveEx();
			assertEquals(currentCost1.setScale(2, RoundingMode.HALF_UP), inventoryLine1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			info = MWorkflow.runDocumentActionWorkflow(inventory1, DocAction.ACTION_Complete);
			inventory1.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory1.getDocStatus(), "Unexpected Document Status");
			if (!inventory1.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), inventory1.getAD_Client_ID(), inventory1.get_Table_ID(), inventory1.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			inventory1.load(getTrxName());
			assertTrue(inventory1.isPosted());
			
			Query query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory1.get_ID(), as.get_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			BigDecimal invDiff = newCost1.subtract(currentCost1).multiply(new BigDecimal("52"));
			ProductCost pc = new ProductCost (Env.getCtx(), product1.getM_Product_ID(), 0, getTrxName());
			MAccount assetAccount = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
			MAccount costAdjAccount = pc.getAccount(ProductCost.ACCTTYPE_P_CostAdjustment, as);
			List<FactAcct> expected = Arrays.asList(
					new FactAcct(assetAccount, invDiff, 2, true),
					new FactAcct(costAdjAccount, invDiff, 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			cost1.load(getTrxName());
			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			assertEquals(new BigDecimal("52").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			// Cost Adjustment 2
			MInventory inventory2 = new MInventory(Env.getCtx(), 0, getTrxName());
			inventory2.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
			inventory2.setC_Currency_ID(as.getC_Currency_ID());
			inventory2.setCostingMethod(MCostElement.COSTINGMETHOD_StandardCosting);
			inventory2.setMovementDate(backDate1);			
			inventory2.saveEx();
			
			BigDecimal currentCost2 = cost0.getCurrentCostPrice();
			assertEquals(new BigDecimal(28.94).setScale(2, RoundingMode.HALF_UP), currentCost2.setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			BigDecimal newCost2 = new BigDecimal(29);
			
			MInventoryLine inventoryLine2 = new MInventoryLine(Env.getCtx(), 0, getTrxName());
			inventoryLine2.setM_Inventory_ID(inventory2.get_ID());
			inventoryLine2.setM_Product_ID(product1.get_ID());
			inventoryLine2.setCurrentCostPrice(currentCost2);
			inventoryLine2.setNewCostPrice(newCost2);
			inventoryLine2.saveEx();
			assertEquals(currentCost2.setScale(2, RoundingMode.HALF_UP), inventoryLine2.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			info = MWorkflow.runDocumentActionWorkflow(inventory2, DocAction.ACTION_Complete);
			inventory2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, inventory2.getDocStatus(), "Unexpected Document Status");
			if (!inventory2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), inventory2.getAD_Client_ID(), inventory2.get_Table_ID(), inventory2.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			inventory2.load(getTrxName());
			assertTrue(inventory2.isPosted());
			
			query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory2.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			invDiff = newCost2.subtract(currentCost2).multiply(new BigDecimal("52"));
			expected = Arrays.asList(
					new FactAcct(assetAccount, invDiff, 2, true),
					new FactAcct(costAdjAccount, invDiff, 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			cost1.load(getTrxName());
			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			assertEquals(new BigDecimal("52").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			// SH2 - Complete
			info = MWorkflow.runDocumentActionWorkflow(shipment2, DocAction.ACTION_Complete);
			shipment2.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, shipment2.getDocStatus());
			if (!shipment2.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), shipment2.getAD_Client_ID(), shipment2.get_Table_ID(), shipment2.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			shipment2.load(getTrxName());
			assertTrue(shipment2.isPosted());
			
			query = MFactAcct.createRecordIdQuery(MInventory.Table_ID, inventory1.get_ID(), as.get_ID(), getTrxName());
			factAccts = query.list();
			invDiff = newCost1.subtract(newCost2).multiply(new BigDecimal("2"));
			expected = Arrays.asList(
					new FactAcct(assetAccount, invDiff, 2, true),
					new FactAcct(costAdjAccount, invDiff, 2, false));
			assertFactAcctEntries(factAccts, expected);
			
			cost1.load(getTrxName());
			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			
			// Inventory Increase
			createInventoryUse(today, product1.get_ID(), new BigDecimal(-10));
			
			cost1.load(getTrxName());
			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			assertEquals(new BigDecimal("12").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			
			// SH1 (Reverse-Correct)
			reverseInOut(shipment1Line1, false);
			
			cost1.load(getTrxName());
			assertEquals(new BigDecimal("30").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
			assertEquals(new BigDecimal("12").setScale(2, RoundingMode.HALF_UP), cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			 			
			validateProductCostQty(ass, product1);
			validateProductCostQty(ass, product2);
		} finally {
			rollback();
			category.deleteEx(true);
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6708
	 * PO Qty=50, Price=35, Date1
	 * MR1 Qty=5, Date1
	 * SH1 Qty=5, Date1
	 * MR2 Qty=5, Date1
	 * SH2 Qty=5, Date1
	 * MR3 Qty=5, Date1
	 * SH3 Qty=5, Date2
	 * MR4 Qty=5, Date3
	 * SH4 Qty=5, Date3
	 * MR5 Qty=5, Date3
	 * SH5 Qty=5, Date3
	 * MR6 Qty=5, Date4
	 * SH6 Qty=5, Date4
	 * MR7 Qty=5, Date4
	 * SH7 Qty=5, Date5
	 * MR8 Qty=5, Date6
	 * SH8 Qty=5, Date6
	 * MR9 Qty=5, Date7
	 * SH9 Qty=5, Date7
	 * MR10 Qty=5, Date7
	 * SH10 Qty=5, Date7
	 * PI for MR1..10
	 */
	@Test
	public void testMultiReceiptShipmentForPO() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testMultiReceiptShipmentForPO", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -7);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -6);
			Timestamp backDate2 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -5);
			Timestamp backDate3  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -4);
			Timestamp backDate4  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -3);
			Timestamp backDate5  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate6  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate7  = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate1);
			order.setDateOrdered(backDate1);
			order.setDatePromised(backDate1);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal(50));
			orderLine.setDatePromised(backDate1);
			orderLine.setPrice(new BigDecimal(35));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MCost cost = null;
			List<MInOutLine> receiptLineList = new ArrayList<MInOutLine>();
			List<MInOutLine> shipmentLineList = new ArrayList<MInOutLine>();
			for (int i=0; i < 10; i++) {
				Timestamp movementDate = null;
				if (i >= 8)
					movementDate = backDate7;
				else if (i >= 7)
					movementDate = backDate6;
				else if (i >= 5)
					movementDate = backDate4;
				else if (i >= 3)
					movementDate = backDate3;
				else
					movementDate = backDate1;
				MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, movementDate);
				receipt.setDocStatus(DocAction.STATUS_Drafted);
				receipt.setDocAction(DocAction.ACTION_Complete);
				receipt.saveEx();

				MInOutLine receiptLine = new MInOutLine(receipt);
				receiptLine.setOrderLine(orderLine, 0, new BigDecimal(5));
				receiptLine.setQty(new BigDecimal(5));
				receiptLine.saveEx();
				receiptLineList.add(receiptLine);
				
				info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
				assertFalse(info.isError(), info.getSummary());
				receipt.load(getTrxName());
				assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
				if (!receipt.isPosted()) {
					String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
					assertNull(error, error);
				}
				
				if (cost == null) {
					cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
					assertNotNull(cost, "No MCost record found");
				} else
					cost.load(getTrxName());
				assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
				assertEquals(new BigDecimal("5").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal(5*(i+1)).setScale(2, RoundingMode.HALF_UP), cost.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				validateProductCostQty(ass, product);
				
				if (i >= 8)
					movementDate = backDate7;
				else if (i >= 7)
					movementDate = backDate6;
				else if (i >= 6)
					movementDate = backDate5;
				else if (i >= 5)
					movementDate = backDate4;
				else if (i >= 3)
					movementDate = backDate3;
				else if (i >= 2)
					movementDate = backDate2;
				else
					movementDate = backDate1;
				MInOutLine shipmentLine = createSOAndSHForProduct(movementDate, product.get_ID(), new BigDecimal(5), new BigDecimal(35));
				shipmentLineList.add(shipmentLine);
				
				cost.load(getTrxName());
				assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
				assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal(5*(i+1)).setScale(2, RoundingMode.HALF_UP), cost.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				validateProductCostQty(ass, product);
			}
			
			for (MInOutLine receiptLine : receiptLineList) {
				createInvoiceForMR(receiptLine, new BigDecimal(35));
				for (MInOutLine shipmentLine : shipmentLineList) {
					MInOut shipment = new MInOut(Env.getCtx(), shipmentLine.getM_InOut_ID(), getTrxName());
					shipment.load(getTrxName());
					if (!shipment.isPosted()) {
						String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
						assertNull(error, error);
					}
				}
				cost.load(getTrxName());
				assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
				assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("50").setScale(2, RoundingMode.HALF_UP), cost.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				validateProductCostQty(ass, product);
			}
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * IDEMPIERE-6708
	 * PO Qty=50, Price=35, Date1
	 * MR1 Qty=5, Date1
	 * SH1 Qty=5, Date1
	 * MR2 Qty=5, Date1
	 * SH2 Qty=5, Date1
	 * MR3 Qty=5, Date1
	 * SH3 Qty=5, Date2
	 * MR4 Qty=5, Date3
	 * SH4 Qty=5, Date3
	 * MR5 Qty=5, Date3
	 * SH5 Qty=5, Date3
	 * MR6 Qty=5, Date4
	 * SH6 Qty=5, Date4
	 * MR7 Qty=5, Date4
	 * SH7 Qty=5, Date5
	 * MR8 Qty=5, Date6
	 * SH8 Qty=5, Date6
	 * MR9 Qty=5, Date7
	 * SH9 Qty=5, Date7
	 * MR10 Qty=5, Date7
	 * SH10 Qty=5, Date7
	 * PI for MR1..10
	 */
	@Test
	public void testMultiReceiptShipmentForPO2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testMultiReceiptShipmentForPO2", new BigDecimal(5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -7);
			Timestamp backDate1 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -6);
			Timestamp backDate2 = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -5);
			Timestamp backDate3  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -4);
			Timestamp backDate4  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -3);
			Timestamp backDate5  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -2);
			Timestamp backDate6  = new Timestamp(cal.getTimeInMillis());
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate7  = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setIsSOTrx(false);
			order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.setDateAcct(backDate1);
			order.setDateOrdered(backDate1);
			order.setDatePromised(backDate1);		
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setLine(10);
			orderLine.setProduct(product);
			orderLine.setQty(new BigDecimal(50));
			orderLine.setDatePromised(backDate1);
			orderLine.setPrice(new BigDecimal(35));
			orderLine.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
			
			MCost cost = null;
			List<MInOutLine> receiptLineList = new ArrayList<MInOutLine>();
			List<MInOutLine> shipmentLineList = new ArrayList<MInOutLine>();
			for (int i=0; i < 10; i++) {
				Timestamp movementDate = null;
				if (i >= 8)
					movementDate = backDate7;
				else if (i >= 7)
					movementDate = backDate6;
				else if (i >= 5)
					movementDate = backDate4;
				else if (i >= 3)
					movementDate = backDate3;
				else
					movementDate = backDate1;
				
				createMRForPO(orderLine, movementDate, new BigDecimal(5));
				
				if (cost == null) {
					cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
					assertNotNull(cost, "No MCost record found");
				} else
					cost.load(getTrxName());
				assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
				assertEquals(new BigDecimal("5").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal(5*(i+1)).setScale(2, RoundingMode.HALF_UP), cost.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				validateProductCostQty(ass, product);
				
				if (i >= 8)
					movementDate = backDate7;
				else if (i >= 7)
					movementDate = backDate6;
				else if (i >= 6)
					movementDate = backDate5;
				else if (i >= 5)
					movementDate = backDate4;
				else if (i >= 3)
					movementDate = backDate3;
				else if (i >= 2)
					movementDate = backDate2;
				else
					movementDate = backDate1;
				MInOutLine shipmentLine = createSOAndSHForProduct(movementDate, product.get_ID(), new BigDecimal(5), new BigDecimal(35));
				shipmentLineList.add(shipmentLine);
				
				cost.load(getTrxName());
				assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
				assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal(5*(i+1)).setScale(2, RoundingMode.HALF_UP), cost.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				validateProductCostQty(ass, product);
			}
			
			for (MInOutLine receiptLine : receiptLineList) {
				createInvoiceForPO(orderLine, receiptLine.getParent().getMovementDate(), receiptLine.getMovementQty());
				for (MInOutLine shipmentLine : shipmentLineList) {
					MInOut shipment = new MInOut(Env.getCtx(), shipmentLine.getM_InOut_ID(), getTrxName());
					shipment.load(getTrxName());
					if (!shipment.isPosted()) {
						String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
						assertNull(error, error);
					}
				}
				cost.load(getTrxName());
				assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost");
				assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
				assertEquals(new BigDecimal("50").setScale(2, RoundingMode.HALF_UP), cost.getCumulatedQty().setScale(2, RoundingMode.HALF_UP), "Unexpected cumulated quantity");
				validateProductCostQty(ass, product);
			}
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * PO Qty=40, Price=40.5
	 * MR Qty=40
	 * Internal use inventory Qty=40
	 * PI Qty=40
	 */
	@Test
	public void testPurchaseInvoiceAfterInternalUseInventory() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceAfterInternalUseInventory", new BigDecimal(40.5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(40), new BigDecimal(40.5));
			
			// Inventory Decrease
			createInventoryUse(backDate, product.get_ID(), new BigDecimal(40));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
									
			// Purchase invoice
			createInvoiceForMR(receiptLine, backDate, new BigDecimal(40.5));
			
			product.set_TrxName(getTrxName());
			cost.load(getTrxName());
 			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * PO Qty=40, Price=40.5
	 * MR Qty=40
	 * Internal use inventory Qty=40
	 * PI Qty=40
	 */
	@Test
	public void testPurchaseInvoiceAfterInternalUseInventory2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceAfterInternalUseInventory2", new BigDecimal(40.5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(40), new BigDecimal(40.5));
			
			// Inventory Decrease
			createInventoryUse(backDate, product.get_ID(), new BigDecimal(40));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
									
			// Purchase invoice
			MOrderLine orderLine = new MOrderLine(Env.getCtx(), receiptLine.getC_OrderLine_ID(), getTrxName());
			createInvoiceForPO(orderLine, receiptLine.getParent().getMovementDate(), receiptLine.getMovementQty());
			
			product.set_TrxName(getTrxName());
			cost.load(getTrxName());
 			assertEquals(new BigDecimal("0").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * PO Qty=40, Price=40.5
	 * MR Qty=40
	 * SH Qty=5
	 * PI Qty=40
	 */
	@Test
	public void testPurchaseInvoiceAfterShipment() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceAfterShipment", new BigDecimal(40.5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(40), new BigDecimal(40.5));
			
			// Inventory Decrease
			createSOAndSHForProduct(backDate, product.get_ID(), new BigDecimal(5), new BigDecimal(40.5));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
									
			// Purchase invoice
			createInvoiceForMR(receiptLine, new BigDecimal(40.5));
			
			product.set_TrxName(getTrxName());
			cost.load(getTrxName());
 			assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	/**
	 * PO Qty=40, Price=40.5
	 * MR Qty=40
	 * SH Qty=5
	 * PI Qty=40
	 */
	@Test
	public void testPurchaseInvoiceAfterShipment2() {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID());
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), null); 
		MAcctSchema as = ci.getMAcctSchema1();

		int[] backDateDays = new int[ass.length];
		try (MockedStatic<MProduct> productMock = mockStatic(MProduct.class)) {
			backDateDays = configureAcctSchema(ass);
			MProduct product = createProduct("testPurchaseInvoiceAfterShipment2", new BigDecimal(40.5));
			mockProductGet(productMock, product);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(today.getTime());
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Timestamp backDate = new Timestamp(cal.getTimeInMillis());
			
			// Purchase Order
			MInOutLine receiptLine = createPOAndMRForProduct(backDate, product.get_ID(), new BigDecimal(40), new BigDecimal(40.5));
			
			// Inventory Decrease
			createSOAndSHForProduct(backDate, product.get_ID(), new BigDecimal(5), new BigDecimal(40.5));
			
			product.set_TrxName(getTrxName());
			MCost cost = product.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertNotNull(cost, "No MCost record found");			
 			assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
									
			// Purchase invoice
			MOrderLine orderLine = new MOrderLine(Env.getCtx(), receiptLine.getC_OrderLine_ID(), getTrxName());
			createInvoiceForPO(orderLine, receiptLine.getParent().getMovementDate(), receiptLine.getMovementQty());
			
			product.set_TrxName(getTrxName());
			cost.load(getTrxName());
 			assertEquals(new BigDecimal("35").setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
			validateProductCostQty(ass, product);
		} finally {
			rollback();
			resetAcctSchema(ass, backDateDays);
		}
	}
	
	private MProduct createProduct(String name, BigDecimal price) {
		return createProduct(name, price, DictionaryIDs.M_Product_Category.STANDARD.id);
	}
	
	private MProduct createProduct(String name, BigDecimal price, int M_Product_Category_ID) {
		MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setM_Product_Category_ID(M_Product_Category_ID);
		product.setName(name);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();
		product.set_TrxName(getTrxName());
		
		MPriceListVersion plv1 = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
		MProductPrice pp1 = new MProductPrice(Env.getCtx(), 0, getTrxName());
		pp1.setM_PriceList_Version_ID(plv1.getM_PriceList_Version_ID());
		pp1.setM_Product_ID(product.get_ID());
		pp1.setPriceStd(price);
		pp1.setPriceList(price);
		pp1.saveEx();
		
		MPriceListVersion plv2 = MPriceList.get(DictionaryIDs.M_PriceList.STANDARD.id).getPriceListVersion(null);
		MProductPrice pp2 = new MProductPrice(Env.getCtx(), 0, getTrxName());
		pp2.setM_PriceList_Version_ID(plv2.getM_PriceList_Version_ID());
		pp2.setM_Product_ID(product.get_ID());
		pp2.setPriceStd(price);
		pp2.setPriceList(price);
		pp2.saveEx();
		
		return product;		
	}
		
	private MInOutLine createPOAndMRForProduct(Timestamp acctDate, int productId, BigDecimal qty, BigDecimal price) {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDateAcct(acctDate);
		order.setDateOrdered(acctDate);
		order.setDatePromised(acctDate);		
		order.saveEx();

		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(new MProduct(Env.getCtx(), productId, getTrxName()));
		orderLine.setQty(qty);
		orderLine.setDatePromised(acctDate);
		if (price != null)
			orderLine.setPrice(price);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, 0, qty);
		receiptLine.setQty(qty);
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		receipt.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		if (!receipt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		receipt.load(getTrxName());
		assertTrue(receipt.isPosted());
		
		return receiptLine;
	}
	
	private MInOutLine createSOAndSHForProduct(Timestamp acctDate, int productId, BigDecimal qty, BigDecimal price) {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setIsSOTrx(true);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setDateAcct(acctDate);
		order.setDateOrdered(acctDate);
		order.setDatePromised(acctDate);		
		order.saveEx();

		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(new MProduct(Env.getCtx(), productId, getTrxName()));
		orderLine.setQty(qty);
		orderLine.setDatePromised(acctDate);
		if (price != null)
			orderLine.setPrice(price);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
		
		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();

		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(orderLine, 0, qty);
		shipmentLine.setQty(qty);
		shipmentLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		shipment.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
		if (!shipment.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		shipment.load(getTrxName());
		assertTrue(shipment.isPosted());
		
		return shipmentLine;
	}
	
	private MInvoiceLine createLandedCost(MInOutLine receiptLine, Timestamp acctDate, BigDecimal price, boolean forProduct) {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.setDateAcct(acctDate);
		invoice.setDateInvoiced(acctDate);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setLine(10);
		invoiceLine.setC_Charge_ID(DictionaryIDs.C_Charge.FREIGHT.id);
		invoiceLine.setQty(BigDecimal.ONE);
		invoiceLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		invoiceLine.setPrice(price); 
		invoiceLine.saveEx();
		
		MLandedCost landedCost = new MLandedCost(Env.getCtx(), 0, getTrxName());
		landedCost.setC_InvoiceLine_ID(invoiceLine.getC_InvoiceLine_ID());
		landedCost.setM_CostElement_ID(DictionaryIDs.M_CostElement.FREIGHT.id);		
		if (forProduct) {
			landedCost.setM_Product_ID(receiptLine.getM_Product_ID());
			landedCost.setQty(receiptLine.getMovementQty());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Costs);
		} else {
			landedCost.setM_InOut_ID(receiptLine.getM_InOut_ID());
			landedCost.setM_InOutLine_ID(receiptLine.getM_InOutLine_ID());
			landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Line);
		}
		landedCost.saveEx();
		
		String error = landedCost.allocateCosts();
		assertTrue(Util.isEmpty(error, true), error);

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		if (!invoice.isPosted()) {
			error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		invoice.load(getTrxName());
		assertTrue(invoice.isPosted());
		
		return invoiceLine;
	}
	
	private MInventoryLine createInventoryUse(Timestamp acctDate, int productId, BigDecimal qty) {
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
		inventory.setMovementDate(acctDate);
		inventory.saveEx();
		
		MInventoryLine inventoryLine = new MInventoryLine(Env.getCtx(), 0, getTrxName());
		inventoryLine.setM_Inventory_ID(inventory.get_ID());
		inventoryLine.setM_Product_ID(productId);
		inventoryLine.setQtyInternalUse(qty);
		inventoryLine.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
		inventoryLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		inventoryLine.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		inventory.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus(), "Unexpected Document Status");
		if (!inventory.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), inventory.getAD_Client_ID(), inventory.get_Table_ID(), inventory.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		inventory.load(getTrxName());
		assertTrue(inventory.isPosted());
		
		return inventoryLine;
	}
	
	private MInOutLine reverseInOut(MInOutLine iol, boolean accrual) {
		MInOut io = new MInOut(Env.getCtx(), iol.getM_InOut_ID(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(io, accrual ? DocAction.ACTION_Reverse_Accrual : DocAction.ACTION_Reverse_Correct);
		io.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, io.getDocStatus(), "Unexpected Document Status");
		
		MInOut reversal = new MInOut(Env.getCtx(), io.getReversal_ID(), getTrxName());
		if (!reversal.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(), reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		reversal.load(getTrxName());
		assertTrue(reversal.isPosted());
		
		MInOutLine[] reversalLines = reversal.getLines();
		return reversalLines[0];
	}
	
	private MInvoiceLine reverseLandedCost(MInvoiceLine il, boolean accrual) {
		MInvoice i = new MInvoice(Env.getCtx(), il.getC_Invoice_ID(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(i, accrual ? DocAction.ACTION_Reverse_Accrual : DocAction.ACTION_Reverse_Correct);
		i.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, i.getDocStatus(), "Unexpected Document Status");
		
		MInvoice reversal = new MInvoice(Env.getCtx(), i.getReversal_ID(), getTrxName());
		if (!reversal.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(), reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		reversal.load(getTrxName());
		assertTrue(reversal.isPosted());
		
		MInvoiceLine[] reversalLines = reversal.getLines();
		return reversalLines[0];
	}
	
	private MInventoryLine reverseInventory(MInventoryLine il, boolean accrual) {
		MInventory i = new MInventory(Env.getCtx(), il.getM_Inventory_ID(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(i, accrual ? DocAction.ACTION_Reverse_Accrual : DocAction.ACTION_Reverse_Correct);
		i.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, i.getDocStatus(), "Unexpected Document Status");
		
		MInventory reversal = new MInventory(Env.getCtx(), i.getReversal_ID(), getTrxName());
		if (!reversal.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(), reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		reversal.load(getTrxName());
		assertTrue(reversal.isPosted());
		
		MInventoryLine[] reversalLines = reversal.getLines(false);
		return reversalLines[0];
	}
	
	private MInvoiceLine createInvoiceForMR(MInOutLine receiptLine, BigDecimal price) {
		MInOut receipt = receiptLine.getParent();
		return createInvoiceForMR(receiptLine, receipt.getMovementDate(), price);
	}
	
	private MInvoiceLine createInvoiceForMR(MInOutLine receiptLine, Timestamp invoiceDate, BigDecimal price) {
		MInOut receipt = receiptLine.getParent();
		MInvoice invoice = new MInvoice(receipt, invoiceDate);
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
		invoiceLine.setLine(10);
		invoiceLine.setProduct(receiptLine.getProduct());
		invoiceLine.setQty(receiptLine.getMovementQty());
		invoiceLine.setPrice(price);
		invoiceLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		invoice.load(getTrxName());
		assertTrue(invoice.isPosted());
		
		MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
		}
		
		return invoiceLine;
	}
	
	private MInvoiceLine createInvoiceForPO(MOrderLine orderLine, Timestamp invoiceDate, BigDecimal qty) {
		MOrder order = orderLine.getParent();
		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, invoiceDate);
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(orderLine.getProduct());
		invoiceLine.setQty(qty);
		invoiceLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		invoice.load(getTrxName());
		assertTrue(invoice.isPosted());
		
		MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), invoiceLine.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
		}
		
		return invoiceLine;
	}
	
	private MInOutLine createMRForPO(MOrderLine orderLine, Timestamp movementDate, BigDecimal qty) {
		MOrder order = orderLine.getParent();
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, 0, qty);
		receiptLine.setQty(qty);
		receiptLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		receipt.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		if (!receipt.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		receipt.load(getTrxName());
		assertTrue(receipt.isPosted());
		
		MMatchInv[] miList = MMatchInv.getInOutLine(Env.getCtx(), receiptLine.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
		}
		
		return receiptLine;
	}
	
	private MInvoiceLine reverseInvoice(MInvoiceLine il, boolean accrual) {
		MInvoice inv = new MInvoice(Env.getCtx(), il.getC_Invoice_ID(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inv, accrual ? DocAction.ACTION_Reverse_Accrual : DocAction.ACTION_Reverse_Correct);
		inv.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Reversed, inv.getDocStatus(), "Unexpected Document Status");
		
  		MInvoice reversal = new MInvoice(Env.getCtx(), inv.getReversal_ID(), getTrxName());
		if (!reversal.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), reversal.getAD_Client_ID(), reversal.get_Table_ID(), reversal.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		reversal.load(getTrxName());
		assertTrue(reversal.isPosted());
		
		MMatchInv[] miList = MMatchInv.getInvoiceLine(Env.getCtx(), reversal.get_ID(), getTrxName());
		for (MMatchInv mi : miList) {
			if (!mi.isPosted()) {
				String error = DocumentEngine.postImmediate(Env.getCtx(), mi.getAD_Client_ID(), MMatchInv.Table_ID, mi.get_ID(), false, getTrxName());
				assertTrue(error == null, error);
			}
			mi.load(getTrxName());
			assertTrue(mi.isPosted());
		}
		
		MInvoiceLine[] reversalLines = reversal.getLines();
		return reversalLines[0];
	}
	
	public static void validateCostDetail(MCostDetail cd, Timestamp dateAcct, boolean isBackDate, BigDecimal currentCostPrice) {
		assertEquals(cd.getDateAcct(), dateAcct, "Unexpected MCostDetail DateAcct");
		assertEquals(cd.isBackDate(), isBackDate, "Unexpected MCostDetail IsBackDate");
		
		if (currentCostPrice != null)
			assertEquals(cd.getCurrentCostPrice().setScale(currentCostPrice.scale(), RoundingMode.HALF_UP), currentCostPrice, "Unexpected MCostDetail CurrentCostPrice");
		
		if (isBackDate)
			assertNotNull(cd.getBackDateProcessedOn(), "Unexpected MCostDetail DateBackDateProcess");
	}
	
	private int[] configureAcctSchema(MAcctSchema[] ass) {
		final int MIN_BACK_DATE_DAY = 7;
		int[] backDateDays = new int[ass.length];
		for (int i = 0; i < ass.length; i++) {
			MAcctSchema as = ass[i];
			assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
			
			int backDateDay = as.getBackDateDay();
			if (backDateDay < MIN_BACK_DATE_DAY) {
				String sql = "UPDATE C_AcctSchema SET BackDateDay=? WHERE C_AcctSchema_ID=?";
				DB.executeUpdate(sql, new Object[] {MIN_BACK_DATE_DAY, as.getC_AcctSchema_ID()}, false, null);
				as.load(null);
			}
			
			assertTrue(as.getBackDateDay() >= MIN_BACK_DATE_DAY, "Unexpected MAcctSchema BackDateDay");
			backDateDays[i] = backDateDay < MIN_BACK_DATE_DAY ? backDateDay : -1;
		}
		return backDateDays;
	}
	
	private void validateProductCostQty(MAcctSchema[] ass, MProduct product) {
		for (MAcctSchema as : ass) {
			MCost cost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_AveragePO);
			MCost cost2 = product.getCostingRecord(as, getAD_Org_ID(), 0, MCostElement.COSTINGMETHOD_StandardCosting);
			assertNotNull(cost1, "No MCost record found");
			assertNotNull(cost2, "No MCost record found");			
			assertEquals(cost1.getCurrentQty().setScale(2, RoundingMode.HALF_UP), cost2.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current quantity");
		}
	}
	
	private void mockGetRate(MockedStatic<MConversionRate> conversionRateMock, MCurrency fromCurrency,
			MCurrency toCurrency, int C_ConversionType_ID, Timestamp conversionDate, BigDecimal multiplyRate) {
		ConversionRateHelper.mockGetRate(conversionRateMock, fromCurrency, toCurrency, C_ConversionType_ID, 
				conversionDate, multiplyRate, getAD_Client_ID(), getAD_Org_ID());
		ConversionRateHelper.mockGetRate(conversionRateMock, toCurrency, fromCurrency, C_ConversionType_ID, 
				conversionDate, BigDecimal.valueOf(1d/multiplyRate.doubleValue()), getAD_Client_ID(), getAD_Org_ID());
	}
	
	private void mockProductGet(MockedStatic<MProduct> productMock, MProduct product) {
		productMock.when(() -> MProduct.getCopy(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()))).thenReturn(product);
	}
}
