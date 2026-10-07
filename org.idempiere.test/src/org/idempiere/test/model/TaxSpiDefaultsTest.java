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
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.sql.Timestamp;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Properties;

import org.adempiere.base.DefaultTaxLookup;
import org.adempiere.base.ITaxLookup;
import org.compiere.model.CalloutInvoice;
import org.compiere.model.CalloutOrder;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MSysConfig;
import org.compiere.process.DocAction;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.osgi.framework.ServiceRegistration;
import org.osgi.service.component.ComponentConstants;

/**
 * IDEMPIERE-7146 - document type and payment rule passed to {@link ITaxLookup}.
 */
@Isolated
public class TaxSpiDefaultsTest extends AbstractTestCase {

	private static final String LOOKUP_NAME = "TaxSpiDefaultsTest.RecordingTaxLookup";

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
	 * Order and invoice lines pass the header's target document type and payment rule to the tax lookup.
	 */
	@Test
	public void testDocTypeAndPaymentRulePassedToTaxLookup() {
		withRecordingTaxLookup(() -> {
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
			RecordingTaxLookup.reset();
			assertTrue(orderLine.setTax(), "No tax found for order line");
			assertTrue(order.getC_DocTypeTarget_ID() > 0, "Order has no target document type");
			assertEquals(order.getC_DocTypeTarget_ID(), RecordingTaxLookup.docTypeId, "Unexpected document type passed by order line");
			assertEquals(MOrder.PAYMENTRULE_Cash, RecordingTaxLookup.paymentRule, "Unexpected payment rule passed by order line");

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
			RecordingTaxLookup.reset();
			assertTrue(invoiceLine.setTax(), "No tax found for invoice line");
			assertTrue(invoice.getC_DocTypeTarget_ID() > 0, "Invoice has no target document type");
			assertEquals(invoice.getC_DocTypeTarget_ID(), RecordingTaxLookup.docTypeId, "Unexpected document type passed by invoice line");
			assertEquals(MInvoice.PAYMENTRULE_OnCredit, RecordingTaxLookup.paymentRule, "Unexpected payment rule passed by invoice line");
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

		withRecordingTaxLookup(() -> {
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
				RecordingTaxLookup.reset();
				new CalloutOrder().tax(ctx, windowNo, mTab, mField, chargeId);
				assertEquals(DictionaryIDs.C_DocType.STANDARD_ORDER.id, RecordingTaxLookup.docTypeId, "Unexpected document type passed by CalloutOrder.tax");
				assertEquals(MOrder.PAYMENTRULE_Cash, RecordingTaxLookup.paymentRule, "Unexpected payment rule passed by CalloutOrder.tax");

				Env.setContext(ctx, windowNo, MInvoice.COLUMNNAME_C_DocTypeTarget_ID, DictionaryIDs.C_DocType.AR_INVOICE.id);
				Env.setContext(ctx, windowNo, MInvoice.COLUMNNAME_PaymentRule, MInvoice.PAYMENTRULE_OnCredit);
				RecordingTaxLookup.reset();
				new CalloutInvoice().tax(ctx, windowNo, mTab, mField, chargeId);
				assertEquals(DictionaryIDs.C_DocType.AR_INVOICE.id, RecordingTaxLookup.docTypeId, "Unexpected document type passed by CalloutInvoice.tax");
				assertEquals(MInvoice.PAYMENTRULE_OnCredit, RecordingTaxLookup.paymentRule, "Unexpected payment rule passed by CalloutInvoice.tax");
			} finally {
				Env.clearWinContext(ctx, windowNo);
			}
		});
	}

	/**
	 * Run the test with {@link RecordingTaxLookup} as the tax lookup service
	 * @param test test to run
	 */
	private void withRecordingTaxLookup(Runnable test) {
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put(ComponentConstants.COMPONENT_NAME, LOOKUP_NAME);
		ServiceRegistration<ITaxLookup> sr = TestActivator.context.registerService(ITaxLookup.class, new RecordingTaxLookup(), properties);

		MSysConfig sysCfgTaxLookup = new MSysConfig(Env.getCtx(), DictionaryIDs.AD_SysConfig.TAX_LOOKUP_SERVICE.id, null);
		String oldValue = sysCfgTaxLookup.getValue();
		try {
			sysCfgTaxLookup.setValue(LOOKUP_NAME);
			sysCfgTaxLookup.saveCrossTenantSafeEx();
			CacheMgt.get().reset(MSysConfig.Table_Name);

			test.run();
		} finally {
			rollback();
			sysCfgTaxLookup.setValue(oldValue);
			sysCfgTaxLookup.saveCrossTenantSafeEx();
			CacheMgt.get().reset(MSysConfig.Table_Name);
			sr.unregister();
		}
	}

	/** Records the document type and payment rule, then looks up the tax as the default lookup does */
	private static final class RecordingTaxLookup extends DefaultTaxLookup {
		private static int docTypeId;
		private static String paymentRule;

		private static void reset() {
			docTypeId = -1;
			paymentRule = null;
		}

		@Override
		public int get(Properties ctx, int M_Product_ID, int C_Charge_ID, Timestamp billDate, Timestamp shipDate,
				int AD_Org_ID, int M_Warehouse_ID, int billC_BPartner_Location_ID, int shipC_BPartner_Location_ID,
				int dropshipC_BPartner_Location_ID, boolean IsSOTrx, String deliveryViaRule,
				int C_DocType_ID, String paymentRule, String trxName) {
			RecordingTaxLookup.docTypeId = C_DocType_ID;
			RecordingTaxLookup.paymentRule = paymentRule;
			return super.get(ctx, M_Product_ID, C_Charge_ID, billDate, shipDate, AD_Org_ID, M_Warehouse_ID,
					billC_BPartner_Location_ID, shipC_BPartner_Location_ID, dropshipC_BPartner_Location_ID,
					IsSOTrx, deliveryViaRule, C_DocType_ID, paymentRule, trxName);
		}
	}

	/** Implements only the abstract methods */
	private static final class MinimalTaxLookup implements ITaxLookup {
		private static final int RESULT = 4711;
		private String called;

		@Override
		public int get(Properties ctx, int M_Product_ID, int C_Charge_ID, Timestamp billDate, Timestamp shipDate,
				int AD_Org_ID, int M_Warehouse_ID, int billC_BPartner_Location_ID, int shipC_BPartner_Location_ID,
				boolean IsSOTrx, String deliveryViaRule, String trxName) {
			called = M_Product_ID + "/" + C_Charge_ID + "/" + billDate + "/" + shipDate + "/" + AD_Org_ID + "/" + M_Warehouse_ID
					+ "/" + billC_BPartner_Location_ID + "/" + shipC_BPartner_Location_ID + "/" + IsSOTrx + "/" + deliveryViaRule
					+ "/" + trxName;
			return RESULT;
		}

		@Override
		public int get(Properties ctx, int C_TaxCategory_ID, boolean IsSOTrx, Timestamp shipDate,
				int shipFromC_Location_ID, int shipToC_Location_ID, Timestamp billDate, int billFromC_Location_ID,
				int billToC_Location_ID, String trxName) {
			return 0;
		}
	}
}
