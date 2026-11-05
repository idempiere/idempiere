/**********************************************************************
 * This file is part of iDempiere ERP Open Source                     *
 * http://www.idempiere.org                                           *
 *                                                                    *
 * Copyright (C) Contributors                                         *
 *                                                                    *
 * This program is free software; you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2     *
 * of the License, or (at your option) any later version.              *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;

import java.sql.Timestamp;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.function.Consumer;

import org.adempiere.base.Core;
import org.adempiere.base.DefaultValue;
import org.adempiere.base.IPODefaultsProvider;
import org.adempiere.base.PODefaults;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

/**
 * Tests for {@link IPODefaultsProvider}: defaults applied in MOrder/MInvoice.beforeSave and
 * initial defaults applied in the constructor, selected by the tableName service property.
 */
public class PODefaultsProviderTest extends AbstractTestCase {

	@Test
	public void testNoProviderKeepsBuiltInDefaults() {
		MOrder order = newOrder();
		assertEquals(MOrder.DELIVERYRULE_Availability, order.getDeliveryRule());
		assertEquals(MOrder.INVOICERULE_Immediate, order.getInvoiceRule());
		order.saveEx();

		int contextSalesRep = Env.getContextAsInt(Env.getCtx(), Env.SALESREP_ID);
		if (contextSalesRep > 0)
			assertEquals(contextSalesRep, order.getSalesRep_ID());
		assertTrue(Core.getPODefaults(MOrder.Table_Name).get(order, MOrder.COLUMNNAME_SalesRep_ID).isUseFallback());
	}

	@Test
	public void testProviderOverridesFallbacks() {
		IPODefaultsProvider provider = provider(Map.of(
				MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id),
				MOrder.COLUMNNAME_C_PaymentTerm_ID, DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id),
				MOrder.COLUMNNAME_M_PriceList_ID, DefaultValue.of(DictionaryIDs.M_PriceList.EXPORT.id)));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, order.getSalesRep_ID());
			assertEquals(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id, order.getC_PaymentTerm_ID());
			assertEquals(DictionaryIDs.M_PriceList.EXPORT.id, order.getM_PriceList_ID());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testInvoiceProviderOverridesFallbacks() {
		IPODefaultsProvider provider = provider(Map.of(
				MInvoice.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id),
				MInvoice.COLUMNNAME_C_PaymentTerm_ID, DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id),
				MInvoice.COLUMNNAME_M_PriceList_ID, DefaultValue.of(DictionaryIDs.M_PriceList.EXPORT.id)));
		ServiceRegistration<?> registration = register(MInvoice.Table_Name, provider, 10);
		try {
			MInvoice invoice = newInvoice();
			invoice.saveEx();

			invoice = new MInvoice(Env.getCtx(), invoice.getC_Invoice_ID(), getTrxName());
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, invoice.getSalesRep_ID());
			assertEquals(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id, invoice.getC_PaymentTerm_ID());
			assertEquals(DictionaryIDs.M_PriceList.EXPORT.id, invoice.getM_PriceList_ID());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testProviderForAnotherTableIsNotAsked() {
		IPODefaultsProvider provider = new IPODefaultsProvider() {
			@Override
			public void initDefaults(PO po) {
				po.set_ValueOfColumn(MOrder.COLUMNNAME_Description, "asked");
			}
			@Override
			public DefaultValue<?> getDefault(PO po, String columnName) {
				return MOrder.COLUMNNAME_SalesRep_ID.equals(columnName) ? DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id) : DefaultValue.useFallback();
			}
		};
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		int contextSalesRep = Env.getContextAsInt(Env.getCtx(), Env.SALESREP_ID);
		Env.setContext(Env.getCtx(), Env.SALESREP_ID, DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		try {
			MInvoice invoice = newInvoice();
			assertEquals(null, invoice.getDescription());
			invoice.saveEx();
			assertEquals(DictionaryIDs.AD_User.GARDEN_ADMIN.id, invoice.getSalesRep_ID());

			MOrder order = newOrder();
			assertEquals("asked", order.getDescription());
		} finally {
			Env.setContext(Env.getCtx(), Env.SALESREP_ID, contextSalesRep);
			registration.unregister();
		}
	}

	@Test
	public void testAnswerOfWrongTypeIsSkipped() {
		IPODefaultsProvider wrongType = provider(Map.of(MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of("not an id")));
		IPODefaultsProvider low = provider(Map.of(MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id)));
		ServiceRegistration<?> wrongRegistration = register(MOrder.Table_Name, wrongType, 20);
		ServiceRegistration<?> lowRegistration = register(MOrder.Table_Name, low, 10);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, order.getSalesRep_ID());
		} finally {
			wrongRegistration.unregister();
			lowRegistration.unregister();
		}
	}

	@Test
	public void testAnswerForUnknownColumnIsSkipped() {
		IPODefaultsProvider provider = provider(Map.of("NoSuchColumn", DefaultValue.of(1)));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			MOrder order = newOrder();
			assertTrue(Core.getPODefaults(MOrder.Table_Name).get(order, "NoSuchColumn").isUseFallback());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testAnswerForColumnOfClassObjectIsSkipped() {
		IPODefaultsProvider provider = provider(Map.of(
				MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id)));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			MOrder order = newOrder();
			// control: with the real dictionary (Integer) the answer is used
			DefaultValue<Integer> salesRep = Core.getPODefaults(MOrder.Table_Name).get(order, MOrder.COLUMNNAME_SalesRep_ID);
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, salesRep.getValue());

			// a column class of Object (e.g. a custom display type) accepts any value, so it cannot guard the cast
			POInfo objectColumnInfo = Mockito.mock(POInfo.class);
			Mockito.doReturn(1).when(objectColumnInfo).getColumnIndex(MOrder.COLUMNNAME_SalesRep_ID);
			Mockito.doReturn(Object.class).when(objectColumnInfo).getColumnClass(1);
			try (MockedStatic<POInfo> poInfoMock = Mockito.mockStatic(POInfo.class, Mockito.CALLS_REAL_METHODS)) {
				poInfoMock.when(() -> POInfo.getPOInfo(any(), eq(MOrder.Table_ID))).thenReturn(objectColumnInfo);
				salesRep = Core.getPODefaults(MOrder.Table_Name).get(order, MOrder.COLUMNNAME_SalesRep_ID);
				assertTrue(salesRep.isUseFallback());
				poInfoMock.verify(() -> POInfo.getPOInfo(any(), eq(MOrder.Table_ID)));
			}
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testFallbackAnswerDoesNotLookUpDictionary() {
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider(Map.of()), 10);
		try {
			MOrder order = newOrder();
			PODefaults defaults = Core.getPODefaults(MOrder.Table_Name);
			try (MockedStatic<POInfo> poInfoMock = Mockito.mockStatic(POInfo.class, Mockito.CALLS_REAL_METHODS)) {
				assertTrue(defaults.get(order, MOrder.COLUMNNAME_SalesRep_ID).isUseFallback());
				assertTrue(defaults.get(order, MOrder.COLUMNNAME_C_PaymentTerm_ID).isUseFallback());
				poInfoMock.verify(() -> POInfo.getPOInfo(any(), eq(MOrder.Table_ID)), Mockito.never());
				poInfoMock.verify(() -> POInfo.getPOInfo(any(), eq(MOrder.Table_ID), anyString()), Mockito.never());
			}
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testDictionaryLookedUpOncePerInstance() {
		IPODefaultsProvider provider = provider(Map.of(
				MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id),
				MOrder.COLUMNNAME_C_PaymentTerm_ID, DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id)));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			MOrder order = newOrder();
			PODefaults defaults = Core.getPODefaults(MOrder.Table_Name);
			try (MockedStatic<POInfo> poInfoMock = Mockito.mockStatic(POInfo.class, Mockito.CALLS_REAL_METHODS)) {
				assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, defaults.get(order, MOrder.COLUMNNAME_SalesRep_ID).getValue());
				assertEquals(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id, defaults.get(order, MOrder.COLUMNNAME_C_PaymentTerm_ID).getValue());
				poInfoMock.verify(() -> POInfo.getPOInfo(any(), eq(MOrder.Table_ID)), Mockito.times(1));
			}
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testTableWithNoProviderSharesInstance() {
		assertSame(Core.getPODefaults(MOrder.Table_Name), Core.getPODefaults(MOrder.Table_Name));
	}

	@Test
	public void testThrowingProviderIsSkipped() {
		IPODefaultsProvider rogue = new IPODefaultsProvider() {
			@Override
			public void initDefaults(PO po) {
				throw new IllegalStateException("rogue initDefaults");
			}
			@Override
			public DefaultValue<?> getDefault(PO po, String columnName) {
				throw new IllegalStateException("rogue getDefault");
			}
		};
		IPODefaultsProvider low = provider(Map.of(MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id)));
		ServiceRegistration<?> rogueRegistration = register(MOrder.Table_Name, rogue, 20);
		ServiceRegistration<?> lowRegistration = register(MOrder.Table_Name, low, 10);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, order.getSalesRep_ID());
		} finally {
			rogueRegistration.unregister();
			lowRegistration.unregister();
		}
	}

	@Test
	public void testValueSetByCallerIsKept() {
		IPODefaultsProvider provider = provider(Map.of(
				MOrder.COLUMNNAME_C_PaymentTerm_ID, DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id)));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			MOrder order = newOrder();
			order.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
			order.saveEx();
			assertEquals(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id, order.getC_PaymentTerm_ID());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testHigherRankingProviderWinsAndFallbackPassesOn() {
		IPODefaultsProvider high = provider(Map.of(MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id)));
		IPODefaultsProvider low = provider(Map.of(
				MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_ADMIN.id),
				MOrder.COLUMNNAME_C_PaymentTerm_ID, DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id)));
		ServiceRegistration<?> highRegistration = register(MOrder.Table_Name, high, 20);
		ServiceRegistration<?> lowRegistration = register(MOrder.Table_Name, low, 10);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, order.getSalesRep_ID());
			// high returns useFallback for the payment term, so low decides
			assertEquals(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id, order.getC_PaymentTerm_ID());
		} finally {
			highRegistration.unregister();
			lowRegistration.unregister();
		}
	}

	@Test
	public void testRankingDecidesNotRegistrationOrder() {
		IPODefaultsProvider low = provider(Map.of(MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_ADMIN.id)));
		IPODefaultsProvider high = provider(Map.of(MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id)));
		// low registered first: it gets the lower service.id, so only service.ranking can put high first
		ServiceRegistration<?> lowRegistration = register(MOrder.Table_Name, low, 10);
		ServiceRegistration<?> highRegistration = register(MOrder.Table_Name, high, 20);
		try {
			MOrder order = newOrder();
			DefaultValue<Integer> salesRep = Core.getPODefaults(MOrder.Table_Name).get(order, MOrder.COLUMNNAME_SalesRep_ID);
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, salesRep.getValue());
		} finally {
			lowRegistration.unregister();
			highRegistration.unregister();
		}
	}

	@Test
	public void testInitDefaultsHigherRankingProviderWins() {
		IPODefaultsProvider high = initProvider(po -> po.set_ValueOfColumn(MInvoice.COLUMNNAME_Description, "high"));
		IPODefaultsProvider low = initProvider(po -> {
			po.set_ValueOfColumn(MInvoice.COLUMNNAME_Description, "low");
			po.set_ValueOfColumn(MInvoice.COLUMNNAME_PaymentRule, MInvoice.PAYMENTRULE_Cash);
		});
		ServiceRegistration<?> highRegistration = register(MInvoice.Table_Name, high, 20);
		ServiceRegistration<?> lowRegistration = register(MInvoice.Table_Name, low, 10);
		try {
			MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			// both providers run: low sets its own columns, high overrides the column they share
			assertEquals("high", invoice.getDescription());
			assertEquals(MInvoice.PAYMENTRULE_Cash, invoice.getPaymentRule());
		} finally {
			highRegistration.unregister();
			lowRegistration.unregister();
		}
	}

	@Test
	public void testProviderRegisteredAfterLookupIsAsked() {
		MOrder order = newOrder();
		// first lookup caches the service holder for the table
		assertTrue(paymentTerm(order).isUseFallback());
		IPODefaultsProvider provider = provider(Map.of(
				MOrder.COLUMNNAME_C_PaymentTerm_ID, DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id)));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			assertEquals(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id, paymentTerm(order).getValue());
		} finally {
			registration.unregister();
		}
		assertTrue(paymentTerm(order).isUseFallback());
	}

	@Test
	public void testNoDefaultSkipsBuiltInFallback() {
		IPODefaultsProvider provider = provider(Map.of(MOrder.COLUMNNAME_SalesRep_ID, DefaultValue.noDefault()));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		int contextSalesRep = Env.getContextAsInt(Env.getCtx(), Env.SALESREP_ID);
		Env.setContext(Env.getCtx(), Env.SALESREP_ID, DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(0, order.getSalesRep_ID());
		} finally {
			Env.setContext(Env.getCtx(), Env.SALESREP_ID, contextSalesRep);
			registration.unregister();
		}
	}

	@Test
	public void testInitDefaultsClearedRuleIsResolvedOnSave() {
		IPODefaultsProvider provider = new IPODefaultsProvider() {
			@Override
			public void initDefaults(PO po) {
				clearRules(po);
			}
			@Override
			public DefaultValue<?> getDefault(PO po, String columnName) {
				return MOrder.COLUMNNAME_DeliveryRule.equals(columnName) ? DefaultValue.of(MOrder.DELIVERYRULE_CompleteOrder) : DefaultValue.useFallback();
			}
		};
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(MOrder.DELIVERYRULE_CompleteOrder, order.getDeliveryRule());
			// no answer for the invoice rule: built-in fallback
			assertEquals(MOrder.INVOICERULE_Immediate, order.getInvoiceRule());

			MOrder explicitRule = newOrder();
			explicitRule.setDeliveryRule(MOrder.DELIVERYRULE_Force);
			explicitRule.saveEx();
			assertEquals(MOrder.DELIVERYRULE_Force, explicitRule.getDeliveryRule());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testClearedRulesSaveForOrderCreatedInCode() {
		ServiceRegistration<?> registration = register(MOrder.Table_Name, initProvider(PODefaultsProviderTest::clearRules), 10);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(MOrder.DELIVERYRULE_Availability, order.getDeliveryRule());
			assertEquals(MOrder.INVOICERULE_Immediate, order.getInvoiceRule());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testClearedRulesSaveWithSetBPartner() {
		ServiceRegistration<?> registration = register(MOrder.Table_Name, initProvider(PODefaultsProviderTest::clearRules), 10);
		try {
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			order.setBPartner(bp);
			order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			order.saveEx();
			String expectedDelivery = bp.getDeliveryRule() != null ? bp.getDeliveryRule() : MOrder.DELIVERYRULE_Availability;
			String expectedInvoice = bp.getInvoiceRule() != null ? bp.getInvoiceRule() : MOrder.INVOICERULE_Immediate;
			assertEquals(expectedDelivery, order.getDeliveryRule());
			assertEquals(expectedInvoice, order.getInvoiceRule());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testCopyFromKeepsSourceRules() {
		ServiceRegistration<?> registration = register(MOrder.Table_Name, initProvider(PODefaultsProviderTest::clearRules), 10);
		try {
			MOrder source = newOrder();
			source.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			source.setInvoiceRule(MOrder.INVOICERULE_AfterDelivery);
			source.saveEx();
			MOrderLine line = new MOrderLine(source);
			line.setLine(10);
			line.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.PLANTING.id));
			line.setQty(Env.ONE);
			line.setDatePromised(source.getDatePromised());
			line.saveEx();

			// copyFrom writes the values with PO.copyValues, which does not clear set errors
			MOrder copy = MOrder.copyFrom(source, source.getDateOrdered(), source.getC_DocTypeTarget_ID(),
					true, false, false, getTrxName());
			assertEquals(MOrder.DELIVERYRULE_CompleteOrder, copy.getDeliveryRule());
			assertEquals(MOrder.INVOICERULE_AfterDelivery, copy.getInvoiceRule());
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testNoDefaultPriceListFallsBackToContextCurrency() {
		IPODefaultsProvider provider = provider(Map.of(MOrder.COLUMNNAME_M_PriceList_ID, DefaultValue.noDefault()));
		ServiceRegistration<?> registration = register(MOrder.Table_Name, provider, 10);
		try {
			MOrder order = newOrder();
			// M_PriceList_ID is mandatory, so the insert fails; beforeSave has already set the currency.
			// DB.getSQLValue returns -1 for the missing price list, which must not be taken as a currency
			assertFalse(order.save());
			assertEquals(0, order.getM_PriceList_ID());
			assertEquals(Env.getContextAsInt(Env.getCtx(), Env.C_CURRENCY_ID), order.getC_Currency_ID());
		} finally {
			registration.unregister();
		}
	}

	/**
	 * Clear both rules at construction and leave the decision to beforeSave.
	 * Both columns are mandatory: the generated setters refuse null.
	 */
	private static void clearRules(PO po) {
		po.set_ValueNoCheck(MOrder.COLUMNNAME_DeliveryRule, null);
		po.set_ValueNoCheck(MOrder.COLUMNNAME_InvoiceRule, null);
	}

	private DefaultValue<Integer> paymentTerm(MOrder order) {
		PODefaults defaults = Core.getPODefaults(MOrder.Table_Name);
		return defaults.get(order, MOrder.COLUMNNAME_C_PaymentTerm_ID);
	}

	/**
	 * Provider answering the given columns, useFallback for the others
	 */
	private IPODefaultsProvider provider(Map<String, DefaultValue<?>> answers) {
		Map<String, DefaultValue<?>> copy = new HashMap<>(answers);
		return new IPODefaultsProvider() {
			@Override
			public DefaultValue<?> getDefault(PO po, String columnName) {
				return copy.getOrDefault(columnName, DefaultValue.useFallback());
			}
		};
	}

	private IPODefaultsProvider initProvider(Consumer<PO> init) {
		return new IPODefaultsProvider() {
			@Override
			public void initDefaults(PO po) {
				init.accept(po);
			}
		};
	}

	/**
	 * Sales order with partner and location set by id, so MOrder.setBPartner is not involved
	 */
	private MOrder newOrder() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id);
		order.setC_BPartner_Location_ID(DictionaryIDs.C_BPartner_Location.C_AND_W_STAMFORD.id);
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		return order;
	}

	private MInvoice newInvoice() {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setIsSOTrx(true);
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id);
		invoice.setC_BPartner_Location_ID(DictionaryIDs.C_BPartner_Location.C_AND_W_STAMFORD.id);
		invoice.setDateInvoiced(TimeUtil.getDay(System.currentTimeMillis()));
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		return invoice;
	}

	private ServiceRegistration<IPODefaultsProvider> register(String tableName, IPODefaultsProvider provider, int ranking) {
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		properties.put(PODefaults.TABLE_NAME_PROPERTY, tableName);
		return TestActivator.context.registerService(IPODefaultsProvider.class, provider, properties);
	}
}
