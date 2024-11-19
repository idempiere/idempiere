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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MCharge;
import org.compiere.model.MClientInfo;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
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
import org.compiere.model.MProductPrice;
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
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.FactAcct;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

@Isolated
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();
		
		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateLandedCostZeroStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
			
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateLandedCostInsufficientStock", new BigDecimal(5));
			
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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateLandedCostSufficientStock", new BigDecimal(5));
			
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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();
		
		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateLandedCostZeroStock", new BigDecimal(5));

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
			createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetail(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", invoiceLine2.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetail(cd, invoiceLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetail(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateLandedCostInsufficientStock", new BigDecimal(5));
			
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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateLandedCostSufficientStock", new BigDecimal(5));
			
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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptAfterShipmentInventory", new BigDecimal(10));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptBeforeLandedCostZero2InsufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptBeforeLandedCostZero2InsufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptBeforeLandedCostZero2SufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try { 
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptBeforeLandedCostZero2InsufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptBeforeLandedCostZero2SufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try { 
			configureAcctSchema(as);
			product = createProduct("testBackDateReceiptBeforeLandedCostInsufficient2SufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeReceiptShipment", new BigDecimal(5));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2ZeroStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2ZeroStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeLandedCostInsufficient2ZeroStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeLandedCostSufficient2InsufficientStock", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testPostDateShipment", new BigDecimal(5));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testPostDateShipment", new BigDecimal(5));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectReceiptAfterShipment", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectReceiptAfterShipment21", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectShipmentAfterAVGCostMoved", new BigDecimal(5));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectShipmentAfterAVGCostMoved", new BigDecimal(5));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectShipmentAfterAVGCostMoved", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectLandedCost", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine, backDate, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectLandedCost", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectProductInvoice", new BigDecimal(5));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectProductInvoice", new BigDecimal(5));

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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectInternalUseAfterAVGCostMoved", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectInternalUseAfterAVGCostMoved2", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseCorrectReceiptAfterLandedCost", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseAccrualShipmentAfterShipment", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, postDate, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testReverseAccrualReceiptAfterShipment", new BigDecimal(5));

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
			MInvoiceLine landedCostLine = createLandedCostForMR(receiptLine1, postDate, new BigDecimal(10));
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
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
		MProduct p1 = null;
		MProduct p2 = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();
		
		try {
			configureAcctSchema(as);
			 
			BigDecimal p1price = new BigDecimal("30.00");
			p1 = createProduct("testUnplannedLandedCostReversalAfterShipment1.1", p1price);
			BigDecimal p2price = new BigDecimal("50.00");
			p2 = createProduct("testUnplannedLandedCostReversalAfterShipment1.2", p2price);
			
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
			
			p1mcost = p2.getCostingRecord(as, getAD_Org_ID(), 0, as.getCostingMethod());
			assertEquals(p2price.add(p2a1.divide(p2QtyOnHand, 2, RoundingMode.HALF_UP))
					.setScale(1, RoundingMode.HALF_UP), p1mcost.getCurrentCostPrice().setScale(1, RoundingMode.HALF_UP), "Unexpected current cost price");
			
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
		} finally {
			rollback();
			as.load(getTrxName());
			
			if (p1 != null) {
				p1.set_TrxName(null);
				p1.deleteEx(true);
			}
			
			if (p2 != null) {
				p2.set_TrxName(null);
				p2.deleteEx(true);
			}
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
		MProduct product = null;
		MClientInfo ci = MClientInfo.get(Env.getCtx(), getAD_Client_ID(), getTrxName()); 
		MAcctSchema as = ci.getMAcctSchema1();

		try {
			configureAcctSchema(as);
			product = createProduct("testBackDateShipmentBeforeReceipt", new BigDecimal(5));

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
			as.load(getTrxName());
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
		}
	}
	
	private MProduct createProduct(String name, BigDecimal price) {
		MProduct product = new MProduct(Env.getCtx(), 0, null);
		product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
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
	
	private MInvoiceLine createLandedCostForMR(MInOutLine receiptLine, Timestamp acctDate, BigDecimal price) {
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
		landedCost.setM_InOut_ID(receiptLine.getM_InOut_ID());
		landedCost.setM_InOutLine_ID(receiptLine.getM_InOutLine_ID());
		landedCost.setLandedCostDistribution(MOrderLandedCost.LANDEDCOSTDISTRIBUTION_Line);
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
	
	private void configureAcctSchema(MAcctSchema as) {
		assertEquals(as.getCostingMethod(), MCostElement.COSTINGMETHOD_AveragePO, "Default costing method not Average PO");
		
		if (as.getBackDateDay() < 3) {
			String sql = "UPDATE C_AcctSchema SET BackDateDay=? WHERE C_AcctSchema_ID=?";
			DB.executeUpdate(sql, new Object[] {3, as.getC_AcctSchema_ID()}, false, getTrxName());
			as.load(getTrxName());
		}
		
		assertTrue(as.getBackDateDay() >= 3, "Unexpected MAcctSchema BackDateDay");
	}
}
