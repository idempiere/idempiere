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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;

import org.compiere.apps.form.Match;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MStorageReservation;
import org.compiere.model.MWarehouse;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.ui.MiniTableImpl;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MatchPOTest extends AbstractTestCase {

	public MatchPOTest() {
	}

	@Test
	public void testOrderInvoiceReceiptMatching() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
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
		orderLine.setQty(new BigDecimal("3"));
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInvoice invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(new BigDecimal("3"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MInOut receipt = new MInOut(invoice, DictionaryIDs.C_DocType.MM_RECEIPT.id, invoice.getDateInvoiced(), getM_Warehouse_ID()); // MM Receipt
		receipt.saveEx();
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setInvoiceLine(invoiceLine, M_Locator_ID, new BigDecimal("3"));
		receiptLine.setLine(10);
		receiptLine.setQty(new BigDecimal("3"));
		receiptLine.saveEx();
		
		invoiceLine.load(getTrxName());
		invoiceLine.setM_InOutLine_ID(receiptLine.getM_InOutLine_ID());
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		MMatchPO[] matchPOs = MMatchPO.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), getTrxName());
		assertEquals(1, matchPOs.length);
		assertEquals(orderLine.getC_OrderLine_ID(), matchPOs[0].getC_OrderLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchPOs[0].getM_InOutLine_ID());
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchPOs[0].getC_InvoiceLine_ID());
		assertTrue(matchPOs[0].getQty().compareTo(new BigDecimal("3"))==0);
		
		rollback();
	}
	
	@Test
	public void testOrderReceiptInvoiceMatching() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
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
		orderLine.setQty(new BigDecimal("3"));
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, M_Locator_ID, new BigDecimal("3"));
		receiptLine.setLine(10);
		receiptLine.setQty(new BigDecimal("3"));
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
		invoiceLine.setQty(new BigDecimal("3"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MMatchPO[] matchPOs = MMatchPO.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), getTrxName());
		assertEquals(1, matchPOs.length);
		assertEquals(orderLine.getC_OrderLine_ID(), matchPOs[0].getC_OrderLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchPOs[0].getM_InOutLine_ID());
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchPOs[0].getC_InvoiceLine_ID());
		assertTrue(matchPOs[0].getQty().compareTo(new BigDecimal("3"))==0);
		
		rollback();
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-3212
	 */
	public void testOrderMultiInvoiceReceiptMatching() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
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
		orderLine.setQty(new BigDecimal("10"));
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInvoice invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(new BigDecimal("3"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MInOut receipt = new MInOut(invoice, DictionaryIDs.C_DocType.MM_RECEIPT.id, invoice.getDateInvoiced(), getM_Warehouse_ID()); // MM Receipt
		receipt.saveEx();
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setInvoiceLine(invoiceLine, M_Locator_ID, new BigDecimal("3"));
		receiptLine.setLine(10);
		receiptLine.setQty(new BigDecimal("3"));
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		MMatchPO[] matchPOs = MMatchPO.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), getTrxName());
		assertEquals(1, matchPOs.length);
		assertEquals(orderLine.getC_OrderLine_ID(), matchPOs[0].getC_OrderLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchPOs[0].getM_InOutLine_ID());
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchPOs[0].getC_InvoiceLine_ID());
		assertTrue(matchPOs[0].getQty().compareTo(new BigDecimal("3"))==0);
		
		invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(new BigDecimal("7"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		invoice.getDocsPostProcess().clear();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Reverse_Accrual);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Reversed, invoice.getDocStatus());
		
		invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(new BigDecimal("7"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		receipt = new MInOut(invoice, DictionaryIDs.C_DocType.MM_RECEIPT.id, invoice.getDateInvoiced(), getM_Warehouse_ID()); // MM Receipt
		receipt.saveEx();
		
		receiptLine = new MInOutLine(receipt);
		receiptLine.setInvoiceLine(invoiceLine, M_Locator_ID, new BigDecimal("3"));
		receiptLine.setLine(10);
		receiptLine.setQty(new BigDecimal("3"));
		receiptLine.saveEx();

		invoiceLine.load(getTrxName());
		invoiceLine.setM_InOutLine_ID(receiptLine.getM_InOutLine_ID());
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		matchPOs = MMatchPO.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), getTrxName());
		assertEquals(1, matchPOs.length);
		assertEquals(orderLine.getC_OrderLine_ID(), matchPOs[0].getC_OrderLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchPOs[0].getM_InOutLine_ID());
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchPOs[0].getC_InvoiceLine_ID());
		assertTrue(matchPOs[0].getQty().compareTo(new BigDecimal("3"))==0, "Expected 3 but got " + matchPOs[0].getQty());
		
		matchPOs = MMatchPO.get(Env.getCtx(), invoiceLine.getC_OrderLine_ID(), invoiceLine.getC_InvoiceLine_ID(), getTrxName());
		
		receipt = new MInOut(invoice, DictionaryIDs.C_DocType.MM_RECEIPT.id, invoice.getDateInvoiced(), getM_Warehouse_ID()); // MM Receipt
		receipt.saveEx();
		
		receiptLine = new MInOutLine(receipt);
		receiptLine.setInvoiceLine(invoiceLine, M_Locator_ID, new BigDecimal("4"));
		receiptLine.setLine(10);
		receiptLine.setQty(new BigDecimal("4"));
		receiptLine.saveEx();
				
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		matchPOs = MMatchPO.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), getTrxName());
		assertEquals(1, matchPOs.length);
		assertEquals(orderLine.getC_OrderLine_ID(), matchPOs[0].getC_OrderLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchPOs[0].getM_InOutLine_ID());
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchPOs[0].getC_InvoiceLine_ID());
		assertTrue(matchPOs[0].getQty().compareTo(new BigDecimal("4"))==0, "Expected 4 but got " + matchPOs[0].getQty());
		
		rollback();
	}
	
	@Test
	public void testOrderMultiReceiptInvoiceMatching() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
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
		orderLine.setQty(new BigDecimal("10"));
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, M_Locator_ID, new BigDecimal("3"));
		receiptLine.setLine(10);
		receiptLine.setQty(new BigDecimal("3"));
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
		invoiceLine.setQty(new BigDecimal("3"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MMatchPO[] matchPOs = MMatchPO.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), getTrxName());
		assertEquals(1, matchPOs.length);
		assertEquals(orderLine.getC_OrderLine_ID(), matchPOs[0].getC_OrderLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchPOs[0].getM_InOutLine_ID());
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchPOs[0].getC_InvoiceLine_ID());
		assertTrue(matchPOs[0].getQty().compareTo(new BigDecimal("3"))==0);
		
		receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
		
		receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, M_Locator_ID, new BigDecimal("7"));
		receiptLine.setLine(10);
		receiptLine.setQty(new BigDecimal("7"));
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setShipLine(receiptLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(new BigDecimal("3"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		MMatchInv[] matchInvoices = MMatchInv.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), invoiceLine.getC_InvoiceLine_ID(), getTrxName());
		assertEquals(1, matchInvoices.length);
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchInvoices[0].getC_InvoiceLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchInvoices[0].getM_InOutLine_ID());
		assertTrue(matchInvoices[0].getQty().compareTo(new BigDecimal("3"))==0, "Expected 3, get " + matchInvoices[0].getQty());
		
		invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setShipLine(receiptLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(new BigDecimal("4"));
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		
		matchInvoices = MMatchInv.get(Env.getCtx(), receiptLine.getM_InOutLine_ID(), invoiceLine.getC_InvoiceLine_ID(), getTrxName());
		assertEquals(1, matchInvoices.length);
		assertEquals(invoiceLine.getC_InvoiceLine_ID(), matchInvoices[0].getC_InvoiceLine_ID());
		assertEquals(receiptLine.getM_InOutLine_ID(), matchInvoices[0].getM_InOutLine_ID());
		assertTrue(matchInvoices[0].getQty().compareTo(new BigDecimal("4"))==0, "Expected 4, get " + matchInvoices[0].getQty());
		
		rollback();
	}
	
	@Test
	public void testReverseFullyMatchPO() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		int initialOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		int initialOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		BigDecimal orderQty = new BigDecimal("1");
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(orderQty);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		int newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered+1, newOnOrdered, "Unexpected qty on ordered value");
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, M_Locator_ID, orderQty);
		receiptLine.setLine(10);
		receiptLine.setQty(orderQty);
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(0, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(1, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered, newOnOrdered, "Unexpected qty on ordered value");
		int newOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		assertEquals(initialOnHand+1, newOnHand, "Unexpected qty on hand value");
		
		MMatchPO[] matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(1, matchPOs.length, "Unexpected number of MatchPO for order line");
		int matchedPOReverse = SystemIDs.PROCESS_M_MATCHPO_REVERSAL;
		info = new ProcessInfo("MatchPOReverse", matchedPOReverse, MMatchPO.Table_ID, matchPOs[0].get_ID());
		ServerProcessCtl.process(info, getTrx(), false);
		assertFalse(info.isError(), info.getSummary());
		
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(0, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		receiptLine.load(getTrxName());
		assertEquals(0, receiptLine.getC_OrderLine_ID(), "Unexpected order line ID value for receipt line");
		matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(2, matchPOs.length, "Unexpected number of MatchPO for order line");
		newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered+1, newOnOrdered, "Unexpected qty on ordered value");
		newOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		assertEquals(initialOnHand+1, newOnHand, "Unexpected qty on hand value");
		
		Match match = new Match();
		match.setTrxName(getTrxName());
		MiniTableImpl fromTable = new MiniTableImpl();
		MiniTableImpl toTable = new MiniTableImpl();
		ColumnInfo[] layout = match.getColumnLayout();
		fromTable.prepareTable(layout, null, null, false, null);
		toTable.prepareTable(layout, null, null, false, null);		
		match.cmd_search(fromTable, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched Material Receipt: " + fromTable.getRowCount());
		int selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, Match.I_DocumentNo);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for Material Receipt line");
				int qty = ((Number)fromTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(receiptLine.getMovementQty().intValue(), qty, "Unexpected qty for Material Receipt line");
				selectedRow = i;
				break;
			}
		}
		assertTrue(selectedRow >= 0, "Can't find not matched Material Receipt line");
		fromTable.setSelectedRow(selectedRow);
		match.cmd_searchTo(fromTable, toTable, match.getMatchTypeText(Match.MATCH_ORDER), Match.MATCH_SHIPMENT, true, true, false, false);
		assertTrue(toTable.getRowCount()>0, "Unexpected number of records for not matched Order Line: " + fromTable.getRowCount());
		int selectedOrderRow = -1;
		for(int i = 0; i < toTable.getRowCount(); i++) {
			String docNo = (String)toTable.getValueAt(i, Match.I_DocumentNo);
			if (order.getDocumentNo().equals(docNo)) {
				int matched = ((Number)toTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for PO line");
				int qty = ((Number)toTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for PO line");
				selectedOrderRow = i;
				break;
			}
		}
		assertTrue(selectedOrderRow >= 0, "Can't find not matched PO line");
		
		//create vendor invoice
		MInvoice invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(orderQty);
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(invoiceLine.getQtyInvoiced().intValue(), orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced");
		matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(3, matchPOs.length, "Unexpected number of MatchPO for order line");
		
		fromTable.prepareTable(layout, null, null, false, null);
		toTable.prepareTable(layout, null, null, false, null);
		match.cmd_search(fromTable, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched Material Receipt: " + fromTable.getRowCount());
		selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, Match.I_DocumentNo);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for Material Receipt line");
				int qty = ((Number)fromTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(receiptLine.getMovementQty().intValue(), qty, "Unexpected qty for Material Receipt line");
				selectedRow = i;
				break;
			}
		}
		assertTrue(selectedRow >= 0, "Can't find not matched Material Receipt line");
		fromTable.setSelectedRow(selectedRow);
		match.cmd_searchTo(fromTable, toTable, match.getMatchTypeText(Match.MATCH_ORDER), Match.MATCH_SHIPMENT, true, true, false, false);
		assertTrue(toTable.getRowCount()>0, "Unexpected number of records for not matched Order Line: " + fromTable.getRowCount());
		selectedOrderRow = -1;
		for(int i = 0; i < toTable.getRowCount(); i++) {
			String docNo = (String)toTable.getValueAt(i, Match.I_DocumentNo);
			if (order.getDocumentNo().equals(docNo)) {
				int matched = ((Number)toTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for PO line");
				int qty = ((Number)toTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for PO line");
				selectedOrderRow = i;
				break;
			}
		}
		assertTrue(selectedOrderRow >= 0, "Can't find not matched PO line");
				
		IDColumn idColumn = (IDColumn)toTable.getValueAt(selectedOrderRow, Match.I_ID);
		idColumn.setSelected(true);
		match.cmd_process(fromTable, toTable, Match.MODE_NOTMATCHED, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), new BigDecimal(1));
		
		orderLine.load(getTrxName());
		assertEquals(0, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(1, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		receiptLine.load(getTrxName());
		assertEquals(orderLine.getC_OrderLine_ID(), receiptLine.getC_OrderLine_ID(), "Unexpected order line ID value for receipt line");
		matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(3, matchPOs.length, "Unexpected number of MatchPO for order line");
		newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered, newOnOrdered, "Unexpected qty on ordered value");
		newOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		assertEquals(initialOnHand+1, newOnHand, "Unexpected qty on hand value");
	}
	
	@Test
	public void testReversePartialMatchPO() {
		MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.TREE_FARM.id); // Tree Farm Inc.
		MProduct product = MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.ELM.id); // Elm Tree
		
		int initialOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		int initialOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(bpartner);
		order.setIsSOTrx(false);
		order.setC_DocTypeTarget_ID();
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		
		BigDecimal orderQty = new BigDecimal("2");
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(orderQty);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(2, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		int newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered+2, newOnOrdered, "Unexpected qty on ordered value");
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered()); // MM Receipt
		receipt.saveEx();
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		
		BigDecimal receiptQty = new BigDecimal("1");
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, M_Locator_ID, receiptQty);
		receiptLine.setLine(10);
		receiptLine.setQty(receiptQty);
		receiptLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(1, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered+1, newOnOrdered, "Unexpected qty on ordered value");
		int newOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		assertEquals(initialOnHand+1, newOnHand, "Unexpected qty on hand value");
		
		MMatchPO[] matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(1, matchPOs.length, "Unexpected number of MatchPO for order line");
		int matchedPOReverse = SystemIDs.PROCESS_M_MATCHPO_REVERSAL;
		info = new ProcessInfo("MatchPOReverse", matchedPOReverse, MMatchPO.Table_ID, matchPOs[0].get_ID());
		ServerProcessCtl.process(info, getTrx(), false);
		assertFalse(info.isError(), info.getSummary());
		
		orderLine.load(getTrxName());
		assertEquals(2, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(0, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		receiptLine.load(getTrxName());
		assertEquals(0, receiptLine.getC_OrderLine_ID(), "Unexpected order line ID value for receipt line");
		matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(2, matchPOs.length, "Unexpected number of MatchPO for order line");
		newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered+2, newOnOrdered, "Unexpected qty on ordered value");
		newOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		assertEquals(initialOnHand+1, newOnHand, "Unexpected qty on hand value");
		
		Match match = new Match();
		match.setTrxName(getTrxName());		
		MiniTableImpl fromTable = new MiniTableImpl();
		MiniTableImpl toTable = new MiniTableImpl();
		ColumnInfo[] layout = match.getColumnLayout();
		fromTable.prepareTable(layout, null, null, false, null);
		toTable.prepareTable(layout, null, null, false, null);		
		match.cmd_search(fromTable, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched Material Receipt: " + fromTable.getRowCount());
		int selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, 1);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, 7)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for Material Receipt line");
				int qty = ((Number)fromTable.getValueAt(i, 6)).intValue();
				assertEquals(receiptLine.getMovementQty().intValue(), qty, "Unexpected qty for Material Receipt line");
				selectedRow = i;
				break;
			}
		}
		assertTrue(selectedRow >= 0, "Can't find not matched Material Receipt line");
		fromTable.setSelectedRow(selectedRow);
		match.cmd_searchTo(fromTable, toTable, match.getMatchTypeText(Match.MATCH_ORDER), Match.MATCH_SHIPMENT, true, true, false, false);
		assertTrue(toTable.getRowCount()>0, "Unexpected number of records for not matched Order Line: " + fromTable.getRowCount());
		int selectedOrderRow = -1;
		for(int i = 0; i < toTable.getRowCount(); i++) {
			String docNo = (String)toTable.getValueAt(i, 1);
			if (order.getDocumentNo().equals(docNo)) {
				int matched = ((Number)toTable.getValueAt(i, 7)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for PO line");
				int qty = ((Number)toTable.getValueAt(i, 6)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for PO line");
				selectedOrderRow = i;
				break;
			}
		}
		assertTrue(selectedOrderRow >= 0, "Can't find not matched PO line");
		
		//create vendor invoice
		MInvoice invoice = new MInvoice(order, MDocType.getOfDocBaseType(Env.getCtx(), MDocType.DOCBASETYPE_APInvoice)[0].getC_DocType_ID(), order.getDateAcct());
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setOrderLine(orderLine);
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(orderQty);
		invoiceLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		invoice.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		orderLine.load(getTrxName());
		assertEquals(invoiceLine.getQtyInvoiced().intValue(), orderLine.getQtyInvoiced().intValue(), "Unexpected order line qty invoiced");
		
		fromTable.prepareTable(layout, null, null, false, null);
		toTable.prepareTable(layout, null, null, false, null);
		match.cmd_search(fromTable, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), product.get_ID(), bpartner.get_ID(), null, null, false);
		assertTrue(fromTable.getRowCount()>0, "Unexpected number of records for not matched Material Receipt: " + fromTable.getRowCount());
		selectedRow = -1;
		for(int i = 0; i < fromTable.getRowCount(); i++) {
			String docNo = (String)fromTable.getValueAt(i, Match.I_DocumentNo);
			if (receipt.getDocumentNo().equals(docNo)) {
				int matched = ((Number)fromTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for Material Receipt line");
				int qty = ((Number)fromTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(receiptLine.getMovementQty().intValue(), qty, "Unexpected qty for Material Receipt line");
				selectedRow = i;
				break;
			}
		}
		assertTrue(selectedRow >= 0, "Can't find not matched Material Receipt line");
		fromTable.setSelectedRow(selectedRow);
		match.cmd_searchTo(fromTable, toTable, match.getMatchTypeText(Match.MATCH_ORDER), Match.MATCH_SHIPMENT, true, true, false, false);
		assertTrue(toTable.getRowCount()>0, "Unexpected number of records for not matched Order Line: " + fromTable.getRowCount());
		selectedOrderRow = -1;
		for(int i = 0; i < toTable.getRowCount(); i++) {
			String docNo = (String)toTable.getValueAt(i, Match.I_DocumentNo);
			if (order.getDocumentNo().equals(docNo)) {
				int matched = ((Number)toTable.getValueAt(i, Match.I_MATCHED)).intValue();
				assertEquals(0, matched, "Unexpected matched qty for PO line");
				int qty = ((Number)toTable.getValueAt(i, Match.I_QTY)).intValue();
				assertEquals(orderLine.getQtyOrdered().intValue(), qty, "Unexpected qty for PO line");
				selectedOrderRow = i;
				break;
			}
		}
		assertTrue(selectedOrderRow >= 0, "Can't find not matched PO line");
		
		IDColumn idColumn = (IDColumn)toTable.getValueAt(selectedOrderRow, Match.I_ID);
		idColumn.setSelected(true);
		match.cmd_process(fromTable, toTable, Match.MODE_NOTMATCHED, Match.MATCH_SHIPMENT, match.getMatchTypeText(Match.MATCH_ORDER), new BigDecimal(1));
		
		orderLine.load(getTrxName());
		assertEquals(1, orderLine.getQtyReserved().intValue(), "Unexpected order line qty ordered value");
		assertEquals(1, orderLine.getQtyDelivered().intValue(), "Unexpected order line qty delivered value");
		receiptLine.load(getTrxName());
		assertEquals(orderLine.getC_OrderLine_ID(), receiptLine.getC_OrderLine_ID(), "Unexpected order line ID value for receipt line");
		matchPOs = MMatchPO.getOrderLine(Env.getCtx(), orderLine.get_ID(), getTrxName());
		assertEquals(4, matchPOs.length, "Unexpected number of MatchPO for order line");
		newOnOrdered = MStorageReservation.getQty(product.get_ID(), getM_Warehouse_ID(), 0, false, getTrxName()).intValue();
		assertEquals(initialOnOrdered+1, newOnOrdered, "Unexpected qty on ordered value");
		newOnHand = MStorageOnHand.getQtyOnHand(product.get_ID(), getM_Warehouse_ID(), 0, getTrxName()).intValue();
		assertEquals(initialOnHand+1, newOnHand, "Unexpected qty on hand value");
	}
}
