/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or      *
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
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockConstruction;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import java.sql.Timestamp;
import java.util.Properties;
import java.util.function.Consumer;

import org.adempiere.base.Core;
import org.adempiere.base.DefaultTaxLookup;
import org.adempiere.base.ITaxLookup;
import org.compiere.model.Callout;
import org.compiere.model.CalloutInvoice;
import org.compiere.model.CalloutInvoiceBatch;
import org.compiere.model.CalloutOrder;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MBPartner;
import org.compiere.model.I_C_InvoiceBatchLine;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedConstruction;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * IDEMPIERE-7146 - document type and payment rule passed to {@link ITaxLookup}.
 */
public class TaxSpiDefaultsTest extends AbstractTestCase {

	/**
	 * Default constructor
	 */
	public TaxSpiDefaultsTest() {
	}

	/**
	 * A lookup implementing only the abstract methods: the document type and payment rule overloads
	 * fall back to the existing methods with the same arguments.
	 */
	@Test
	public void testTaxLookupDocTypeOverloadsFallBack() {
		MinimalTaxLookup lookup = new MinimalTaxLookup();
		Properties ctx = Env.getCtx();
		Timestamp billDate = TimeUtil.getDay(null);
		Timestamp shipDate = TimeUtil.addDays(billDate, 1);

		int id = lookup.get(ctx, 101, 102, billDate, shipDate, 103, 104, 105, 106,
				true, MOrder.DELIVERYVIARULE_Pickup, 107, MOrder.PAYMENTRULE_Cash, "trx");
		assertEquals(MinimalTaxLookup.RESULT, id);
		assertEquals("101/102/" + billDate + "/" + shipDate + "/103/104/105/106/true/P/trx", lookup.called,
				"Unexpected arguments passed to the fallback method");

		lookup.called = null;
		id = lookup.get(ctx, 101, 102, billDate, shipDate, 103, 104, 105, 106, 108,
				false, MOrder.DELIVERYVIARULE_Shipper, 107, MOrder.PAYMENTRULE_OnCredit, "trx");
		assertEquals(MinimalTaxLookup.RESULT, id);
		// the drop ship overload falls back to the method without drop ship location
		assertEquals("101/102/" + billDate + "/" + shipDate + "/103/104/105/106/false/S/trx", lookup.called,
				"Unexpected arguments passed to the fallback method");
	}

	/**
	 * A lookup implementing only the document type and payment rule overload with drop ship location
	 * is called by the overload without drop ship location, with -1 as drop ship location.
	 */
	@Test
	public void testTaxLookupDocTypeOverloadWithoutDropShip() {
		RecordingTaxLookup lookup = new RecordingTaxLookup();
		Timestamp today = TimeUtil.getDay(null);
		int locationId = DictionaryIDs.C_BPartner_Location.C_AND_W_STAMFORD.id;

		lookup.get(Env.getCtx(), 0, DictionaryIDs.C_Charge.BANK.id, today, today,
				DictionaryIDs.AD_Org.HQ.id, DictionaryIDs.M_Warehouse.HQ.id, locationId, locationId,
				true, null, DictionaryIDs.C_DocType.STANDARD_ORDER.id, MOrder.PAYMENTRULE_Cash, getTrxName());
		assertEquals(-1, lookup.dropshipLocationId, "Unexpected drop ship location");
		assertEquals(DictionaryIDs.C_DocType.STANDARD_ORDER.id, lookup.docTypeId, "Unexpected document type");
		assertEquals(MOrder.PAYMENTRULE_Cash, lookup.paymentRule, "Unexpected payment rule");
	}

	/**
	 * Order and invoice lines pass the header's document type and payment rule to the tax lookup.
	 */
	@Test
	public void testDocTypeAndPaymentRulePassedToTaxLookup() {
		withRecordingTaxLookup(lookup -> {
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id));
			order.setIsSOTrx(true);
			order.setC_DocTypeTarget_ID();
			order.setPaymentRule(MOrder.PAYMENTRULE_Cash);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
			assertTrue(orderLine.setTax(), "No tax found for order line");
			assertTrue(order.getDocTypeID() > 0, "Order has no document type");
			assertEquals(order.getDocTypeID(), lookup.docTypeId, "Unexpected document type passed by order line");
			assertEquals(MOrder.PAYMENTRULE_Cash, lookup.paymentRule, "Unexpected payment rule passed by order line");

			MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id));
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
			invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID());
			invoice.setPaymentRule(MInvoice.PAYMENTRULE_OnCredit);
			invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
			invoice.setDateInvoiced(TimeUtil.getDay(null));
			invoice.setDateAcct(TimeUtil.getDay(null));
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();

			MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
			invoiceLine.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
			lookup.reset();
			assertTrue(invoiceLine.setTax(), "No tax found for invoice line");
			assertTrue(invoice.getDocTypeID() > 0, "Invoice has no document type");
			assertEquals(invoice.getDocTypeID(), lookup.docTypeId, "Unexpected document type passed by invoice line");
			assertEquals(MInvoice.PAYMENTRULE_OnCredit, lookup.paymentRule, "Unexpected payment rule passed by invoice line");
		});
	}

	/**
	 * The order and invoice line tax callouts pass the header's target document type and payment rule
	 * from the window context to the tax lookup.
	 */
	@Test
	public void testDocTypeAndPaymentRulePassedByTaxCallouts() {
		Properties ctx = Env.getCtx();
		int windowNo = 9146;
		Timestamp today = TimeUtil.getDay(null);
		GridTab mTab = mock(GridTab.class);
		when(mTab.getTabNo()).thenReturn(1);
		// quantities and prices read by the amount callout that runs after the tax callout
		when(mTab.getValue(anyString())).thenAnswer(invocation -> {
			String columnName = invocation.getArgument(0);
			return columnName.startsWith("Qty") || columnName.startsWith("Price") || columnName.equals("Discount") ? Env.ZERO : null;
		});
		GridField mField = mock(GridField.class);
		when(mField.getColumnName()).thenReturn(MOrderLine.COLUMNNAME_C_Charge_ID);
		Integer chargeId = Integer.valueOf(DictionaryIDs.C_Charge.BANK.id);

		withRecordingTaxLookup(lookup -> {
			try {
				Env.setContext(ctx, windowNo, "IsSOTrx", true);
				Env.setContext(ctx, windowNo, "AD_Org_ID", DictionaryIDs.AD_Org.HQ.id);
				Env.setContext(ctx, windowNo, "M_Warehouse_ID", DictionaryIDs.M_Warehouse.HQ.id);
				Env.setContext(ctx, windowNo, "C_BPartner_Location_ID", DictionaryIDs.C_BPartner_Location.C_AND_W_STAMFORD.id);
				Env.setContext(ctx, windowNo, "DateOrdered", today);
				Env.setContext(ctx, windowNo, "DatePromised", today);
				Env.setContext(ctx, windowNo, "DateInvoiced", today);

				Env.setContext(ctx, windowNo, MOrder.COLUMNNAME_C_DocTypeTarget_ID, DictionaryIDs.C_DocType.STANDARD_ORDER.id);
				Env.setContext(ctx, windowNo, MOrder.COLUMNNAME_PaymentRule, MOrder.PAYMENTRULE_Cash);
				new CalloutOrder().tax(ctx, windowNo, mTab, mField, chargeId);
				assertEquals(DictionaryIDs.C_DocType.STANDARD_ORDER.id, lookup.docTypeId, "Unexpected document type passed by CalloutOrder.tax");
				assertEquals(MOrder.PAYMENTRULE_Cash, lookup.paymentRule, "Unexpected payment rule passed by CalloutOrder.tax");

				// a saved order: its document type wins over the target, as in MOrder.getDocTypeID()
				Env.setContext(ctx, windowNo, MOrder.COLUMNNAME_C_DocType_ID, DictionaryIDs.C_DocType.POS_ORDER.id);
				lookup.reset();
				new CalloutOrder().tax(ctx, windowNo, mTab, mField, chargeId);
				assertEquals(DictionaryIDs.C_DocType.POS_ORDER.id, lookup.docTypeId, "CalloutOrder.tax should pass C_DocType_ID when it is set");
				Env.setContext(ctx, windowNo, MOrder.COLUMNNAME_C_DocType_ID, "");

				Env.setContext(ctx, windowNo, MInvoice.COLUMNNAME_C_DocTypeTarget_ID, DictionaryIDs.C_DocType.AR_INVOICE.id);
				Env.setContext(ctx, windowNo, MInvoice.COLUMNNAME_PaymentRule, MInvoice.PAYMENTRULE_OnCredit);
				lookup.reset();
				new CalloutInvoice().tax(ctx, windowNo, mTab, mField, chargeId);
				assertEquals(DictionaryIDs.C_DocType.AR_INVOICE.id, lookup.docTypeId, "Unexpected document type passed by CalloutInvoice.tax");
				assertEquals(MInvoice.PAYMENTRULE_OnCredit, lookup.paymentRule, "Unexpected payment rule passed by CalloutInvoice.tax");

				// a saved invoice: its document type wins over the target, as in MInvoice.getDocTypeID()
				Env.setContext(ctx, windowNo, MInvoice.COLUMNNAME_C_DocType_ID, DictionaryIDs.C_DocType.AR_INVOICE_INDIRECT.id);
				lookup.reset();
				new CalloutInvoice().tax(ctx, windowNo, mTab, mField, chargeId);
				assertEquals(DictionaryIDs.C_DocType.AR_INVOICE_INDIRECT.id, lookup.docTypeId, "CalloutInvoice.tax should pass C_DocType_ID when it is set");
			} finally {
				Env.clearWinContext(ctx, windowNo);
			}
		});
	}

	/**
	 * The invoice batch line tax callout passes the batch line's document type from the window context
	 * and no payment rule (the invoice batch has none).
	 */
	@Test
	public void testDocTypePassedByInvoiceBatchTaxCallout() {
		Properties ctx = Env.getCtx();
		int windowNo = 9147;
		GridTab mTab = mock(GridTab.class);
		when(mTab.getTabNo()).thenReturn(1);
		GridField mField = mock(GridField.class);
		when(mField.getColumnName()).thenReturn(I_C_InvoiceBatchLine.COLUMNNAME_C_Charge_ID);

		withRecordingTaxLookup(lookup -> {
			try {
				Env.setContext(ctx, windowNo, "IsSOTrx", true);
				Env.setContext(ctx, windowNo, "AD_Org_ID", DictionaryIDs.AD_Org.HQ.id);
				Env.setContext(ctx, windowNo, "C_BPartner_Location_ID", DictionaryIDs.C_BPartner_Location.C_AND_W_STAMFORD.id);
				Env.setContext(ctx, windowNo, "DateInvoiced", TimeUtil.getDay(null));
				Env.setContext(ctx, windowNo, I_C_InvoiceBatchLine.COLUMNNAME_C_DocType_ID, DictionaryIDs.C_DocType.AR_INVOICE.id);
				new CalloutInvoiceBatch().tax(ctx, windowNo, mTab, mField, Integer.valueOf(DictionaryIDs.C_Charge.BANK.id));
				assertEquals(DictionaryIDs.C_DocType.AR_INVOICE.id, lookup.docTypeId, "Unexpected document type passed by CalloutInvoiceBatch.tax");
				assertNull(lookup.paymentRule, "CalloutInvoiceBatch.tax should pass no payment rule");
			} finally {
				Env.clearWinContext(ctx, windowNo);
			}
		});
	}

	/**
	 * RMA line tax lookups (MRMALine on save, CalloutRMA.product in the window) pass the document type and
	 * payment rule of the original document: the order while the shipment's order has no invoice, then the invoice.
	 */
	@Test
	public void testRMALineTaxLookupPassesOriginalDocument() {
		Properties ctx = Env.getCtx();
		Timestamp today = TimeUtil.getDay(null);
		int productId = DictionaryIDs.M_Product.AZALEA_BUSH.id;

		MOrder order = new MOrder(ctx, 0, getTrxName());
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
		order.setIsSOTrx(true);
		order.setC_DocTypeTarget_ID();
		order.setPaymentRule(MOrder.PAYMENTRULE_Cash);
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();

		MInOut shipment = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, today);
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();

		MRMA rma = new MRMA(ctx, 0, getTrxName());
		rma.setM_InOut_ID(shipment.getM_InOut_ID());
		rma.setC_BPartner_ID(order.getC_BPartner_ID());
		rma.setC_Currency_ID(order.getC_Currency_ID());
		rma.setIsSOTrx(true);
		rma.setName("IDEMPIERE-7146");
		rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
		rma.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
		rma.saveEx();

		withRecordingTaxLookup(lookup -> {
			// no invoice for the shipment's order: the order's document type and payment rule
			newRMALine(rma, productId);
			assertEquals(order.getDocTypeID(), lookup.docTypeId, "Unexpected document type passed by MRMALine (order)");
			assertEquals(MOrder.PAYMENTRULE_Cash, lookup.paymentRule, "Unexpected payment rule passed by MRMALine (order)");

			lookup.reset();
			runCalloutRMAProduct(rma, order, null, shipment, productId);
			assertEquals(order.getDocTypeID(), lookup.docTypeId, "Unexpected document type passed by CalloutRMA (order)");
			assertEquals(MOrder.PAYMENTRULE_Cash, lookup.paymentRule, "Unexpected payment rule passed by CalloutRMA (order)");

			// the order is invoiced: the invoice's document type and payment rule
			MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AR_INVOICE.id, today);
			invoice.setPaymentRule(MInvoice.PAYMENTRULE_OnCredit);
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();

			lookup.reset();
			newRMALine(rma, productId);
			assertEquals(invoice.getDocTypeID(), lookup.docTypeId, "Unexpected document type passed by MRMALine (invoice)");
			assertEquals(MInvoice.PAYMENTRULE_OnCredit, lookup.paymentRule, "Unexpected payment rule passed by MRMALine (invoice)");

			lookup.reset();
			runCalloutRMAProduct(rma, order, invoice, shipment, productId);
			assertEquals(invoice.getDocTypeID(), lookup.docTypeId, "Unexpected document type passed by CalloutRMA (invoice)");
			assertEquals(MInvoice.PAYMENTRULE_OnCredit, lookup.paymentRule, "Unexpected payment rule passed by CalloutRMA (invoice)");
		});
	}

	/**
	 * Run the RMA line product callout ({@code org.adempiere.model.CalloutRMA.product}, resolved as the AD column does);
	 * it reads the RMA outside the test transaction, so every RMA it creates answers with the test documents.
	 * @param rma RMA of the line
	 * @param order original order
	 * @param invoice original invoice, null if none
	 * @param shipment shipment of the RMA
	 * @param productId product entered on the line
	 */
	private void runCalloutRMAProduct(MRMA rma, MOrder order, MInvoice invoice, MInOut shipment, int productId) {
		GridTab mTab = mock(GridTab.class);
		when(mTab.getValue(MRMALine.COLUMNNAME_M_RMA_ID)).thenReturn(Integer.valueOf(rma.getM_RMA_ID()));
		when(mTab.getValue(MRMALine.COLUMNNAME_AD_Org_ID)).thenReturn(Integer.valueOf(rma.getAD_Org_ID()));
		when(mTab.getActiveCallouts()).thenReturn(new String[0]);
		GridField mField = mock(GridField.class);
		when(mField.getColumnName()).thenReturn(MRMALine.COLUMNNAME_M_Product_ID);
		try (MockedConstruction<MRMA> rmaMock = mockConstruction(MRMA.class, (mock, context) -> {
			when(mock.getOriginalInvoice()).thenReturn(invoice);
			when(mock.getOriginalOrder()).thenReturn(order);
			when(mock.getShipment()).thenReturn(shipment);
			when(mock.getC_BPartner_ID()).thenReturn(rma.getC_BPartner_ID());
			when(mock.isSOTrx()).thenReturn(rma.isSOTrx());
		})) {
			Callout callout = Core.getCallout("org.adempiere.model.CalloutRMA", "product");
			assertNotNull(callout, "CalloutRMA not found");
			String error = callout.start(Env.getCtx(), "product", 9148, mTab, mField, Integer.valueOf(productId), null);
			assertEquals("", error, "CalloutRMA.product failed");
		}
	}

	/**
	 * Save a new RMA line with a product and no shipment line, so its tax is looked up
	 * @param rma RMA
	 * @param productId product
	 */
	private void newRMALine(MRMA rma, int productId) {
		MRMALine line = new MRMALine(Env.getCtx(), 0, getTrxName());
		line.setM_RMA_ID(rma.getM_RMA_ID());
		line.setAD_Org_ID(rma.getAD_Org_ID());
		line.setM_Product_ID(productId);
		line.setQty(Env.ONE);
		line.saveEx();
	}

	/**
	 * Run the test with a static mock of {@link Core} returning a {@link RecordingTaxLookup}
	 * @param test test to run, with the recording lookup
	 */
	private void withRecordingTaxLookup(Consumer<RecordingTaxLookup> test) {
		RecordingTaxLookup lookup = new RecordingTaxLookup();
		try (MockedStatic<Core> coreMock = mockStatic(Core.class, Mockito.CALLS_REAL_METHODS)) {
			coreMock.when(Core::getTaxLookup).thenReturn(lookup);
			test.accept(lookup);
		}
	}

	/** Records the drop ship location, document type and payment rule, then looks up the tax as the default lookup does */
	private static final class RecordingTaxLookup extends DefaultTaxLookup {
		/** Drop ship location received by the last lookup, 0 if none */
		private int dropshipLocationId;
		/** Document type received by the last lookup, -1 if none */
		private int docTypeId;
		/** Payment rule received by the last lookup, null if none */
		private String paymentRule;

		/**
		 * Create a lookup with nothing recorded
		 */
		private RecordingTaxLookup() {
			reset();
		}

		/**
		 * Clear the recorded values
		 */
		private void reset() {
			dropshipLocationId = 0;
			docTypeId = -1;
			paymentRule = null;
		}

		/**
		 * Record the drop ship location, document type and payment rule, then find C_Tax_ID as {@link DefaultTaxLookup} does
		 */
		@Override
		public int get(Properties ctx, int M_Product_ID, int C_Charge_ID, Timestamp billDate, Timestamp shipDate,
				int AD_Org_ID, int M_Warehouse_ID, int billC_BPartner_Location_ID, int shipC_BPartner_Location_ID,
				int dropshipC_BPartner_Location_ID, boolean IsSOTrx, String deliveryViaRule,
				int C_DocType_ID, String paymentRule, String trxName) {
			this.dropshipLocationId = dropshipC_BPartner_Location_ID;
			this.docTypeId = C_DocType_ID;
			this.paymentRule = paymentRule;
			return super.get(ctx, M_Product_ID, C_Charge_ID, billDate, shipDate, AD_Org_ID, M_Warehouse_ID,
					billC_BPartner_Location_ID, shipC_BPartner_Location_ID, dropshipC_BPartner_Location_ID,
					IsSOTrx, deliveryViaRule, C_DocType_ID, paymentRule, trxName);
		}
	}

	/** Implements only the abstract methods */
	private static final class MinimalTaxLookup implements ITaxLookup {
		/** C_Tax_ID returned by the lookup */
		private static final int RESULT = 4711;
		/** Arguments received by the last lookup, separated by "/" */
		private String called;

		/**
		 * Record the arguments
		 * @return {@link #RESULT}
		 */
		@Override
		public int get(Properties ctx, int M_Product_ID, int C_Charge_ID, Timestamp billDate, Timestamp shipDate,
				int AD_Org_ID, int M_Warehouse_ID, int billC_BPartner_Location_ID, int shipC_BPartner_Location_ID,
				boolean IsSOTrx, String deliveryViaRule, String trxName) {
			called = M_Product_ID + "/" + C_Charge_ID + "/" + billDate + "/" + shipDate + "/" + AD_Org_ID + "/" + M_Warehouse_ID
					+ "/" + billC_BPartner_Location_ID + "/" + shipC_BPartner_Location_ID + "/" + IsSOTrx + "/" + deliveryViaRule
					+ "/" + trxName;
			return RESULT;
		}

		/**
		 * Not used by the test
		 * @return 0
		 */
		@Override
		public int get(Properties ctx, int C_TaxCategory_ID, boolean IsSOTrx, Timestamp shipDate,
				int shipFromC_Location_ID, int shipToC_Location_ID, Timestamp billDate, int billFromC_Location_ID,
				int billToC_Location_ID, String trxName) {
			return 0;
		}
	}
}
