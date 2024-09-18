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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Calendar;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MLandedCost;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLandedCost;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		
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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// Landed Cost (Back-Date)
			createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// Landed Cost (Back-Date)
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.50"));
			
			// Landed Cost (Back-Date)
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, backDate2, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("10.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(1), new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("10.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(2), new BigDecimal(16));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("14.00"));
			
			// Internal use inventory
			MInventoryLine inventoryLine = createInventoryUse(today, product.getM_Product_ID(), new BigDecimal(1));
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetailDateAcctBackDate(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("14.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(1), new BigDecimal(13));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("11.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("11.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("13.50"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InventoryLine_ID=?", inventoryLine.getM_InventoryLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for inventory line");
			validateCostDetailDateAcctBackDate(cd, inventoryLine.getParent().getMovementDate(), false, new BigDecimal("13.50"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
//			assertNotNull(cd, "MCostDetail not found for invoice line");
//			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("5.00"));

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.55"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.55"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate1, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(12), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.75));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.75"));
			
			// MR3 (Back-Date)
			MInOutLine receiptLine3 = createPOAndMRForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine3.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine3.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("5.71"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.31"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.31"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			 
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd,  shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.25"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("7.00"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema(); 

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(16), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(4), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.25"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("6.25"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("7.00"));
			
			// SH2 (Back-Date)
			MInOutLine shipmentLine2 = createSOAndSHForProduct(backDate2, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), false, new BigDecimal("6.43"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("7.43"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// SH (Post-Date)
			MInOutLine shipmentLine = createSOAndSHForProduct(postDate, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			// MR2 (Back-Date)
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(backDate, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine1, today, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("6.71"));
			
			// MR2 Reversal (Back-Date)
			MInOutLine reversalLine = reverseCorrectInOut(receiptLine2);
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", reversalLine.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), false, new BigDecimal("6.00"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// SH1
			MInOutLine shipmentLine1 = createSOAndSHForProduct(backDate, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(5));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine1.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine1.getParent().getDateAcct(), true, new BigDecimal("5.00"));

			// MR2
			MInOutLine receiptLine2 = createPOAndMRForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(7));
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));

			// SH2
			MInOutLine shipmentLine2 = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(10), new BigDecimal(6.43));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.43"));

			// SH1 Reversal (Back-Date)
			MInOutLine reversalLine = reverseCorrectInOut(shipmentLine1);
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", reversalLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "C_OrderLine_ID=?", receiptLine2.getC_OrderLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for receipt line");
			validateCostDetailDateAcctBackDate(cd, receiptLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine2.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine2.getParent().getDateAcct(), false, new BigDecimal("6.00"));
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
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();

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
			validateCostDetailDateAcctBackDate(cd, receiptLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			// Landed Cost
			MInvoiceLine landedCost = createLandedCostForMR(receiptLine, backDate, new BigDecimal(10));
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", landedCost.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, landedCost.getParent().getDateAcct(), true, new BigDecimal("6.00"));
			
			// SH
			MInOutLine shipmentLine = createSOAndSHForProduct(today, product.getM_Product_ID(), new BigDecimal(6), new BigDecimal(6));
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("6.00"));
			
			// Landed Cost Reversal (Back-Date)
			MInvoiceLine reversalLine = reverseCorrectLandedCost(landedCost);
			cd = MCostDetail.get(Env.getCtx(), "C_InvoiceLine_ID=?", reversalLine.getC_InvoiceLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for invoice line");
			validateCostDetailDateAcctBackDate(cd, reversalLine.getParent().getDateAcct(), true, new BigDecimal("5.00"));
			
			cd = MCostDetail.get(Env.getCtx(), "M_InOutLine_ID=?", shipmentLine.getM_InOutLine_ID(), 0, as.get_ID(), getTrxName());
			assertNotNull(cd, "MCostDetail not found for shipment line");
			validateCostDetailDateAcctBackDate(cd, shipmentLine.getParent().getDateAcct(), false, new BigDecimal("5.00"));
		} finally {
			rollback();
			
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
		invoice.setDateAcct(acctDate);
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
	
	private MInOutLine reverseCorrectInOut(MInOutLine iol) {
		MInOut io = new MInOut(Env.getCtx(), iol.getM_InOut_ID(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(io, DocAction.ACTION_Reverse_Correct);
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
	
	private MInvoiceLine reverseCorrectLandedCost(MInvoiceLine il) {
		MInvoice i = new MInvoice(Env.getCtx(), il.getC_Invoice_ID(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(i, DocAction.ACTION_Reverse_Correct);
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
	
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-6203
	 */
	public static void validateCostDetailDateAcctBackDate(MCostDetail cd, Timestamp dateAcct, boolean isBackDate, BigDecimal currentCostPrice) {
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
