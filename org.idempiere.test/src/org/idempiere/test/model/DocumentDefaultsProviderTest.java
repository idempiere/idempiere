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
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Timestamp;
import java.util.Dictionary;
import java.util.Hashtable;

import org.adempiere.base.Core;
import org.adempiere.base.DefaultValue;
import org.adempiere.base.IInvoiceDefaultsProvider;
import org.adempiere.base.IOrderDefaultsProvider;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MBPartner;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

/**
 * Tests for {@link IOrderDefaultsProvider} and {@link IInvoiceDefaultsProvider}: header defaults applied in
 * MOrder/MInvoice.beforeSave and initial defaults applied in the constructor.
 */
public class DocumentDefaultsProviderTest extends AbstractTestCase {

	@Test
	public void testNoProviderKeepsBuiltInDefaults() {
		MOrder order = newOrder();
		assertEquals(MOrder.DELIVERYRULE_Availability, order.getDeliveryRule());
		assertEquals(MOrder.INVOICERULE_Immediate, order.getInvoiceRule());
		order.saveEx();

		int contextSalesRep = Env.getContextAsInt(Env.getCtx(), Env.SALESREP_ID);
		if (contextSalesRep > 0)
			assertEquals(contextSalesRep, order.getSalesRep_ID());
		assertTrue(Core.getOrderDefaults().get(provider -> provider.getSalesRep_ID(order)).isUseFallback());
	}

	@Test
	public void testProviderOverridesFallbacks() {
		IOrderDefaultsProvider provider = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getSalesRep_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id);
			}
			@Override
			public DefaultValue<Integer> getC_PaymentTerm_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id);
			}
			@Override
			public DefaultValue<Integer> getM_PriceList_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.M_PriceList.EXPORT.id);
			}
		};
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, provider, 10);
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
		IInvoiceDefaultsProvider provider = new IInvoiceDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getSalesRep_ID(MInvoice document) {
				return DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id);
			}
			@Override
			public DefaultValue<Integer> getC_PaymentTerm_ID(MInvoice document) {
				return DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id);
			}
			@Override
			public DefaultValue<Integer> getM_PriceList_ID(MInvoice document) {
				return DefaultValue.of(DictionaryIDs.M_PriceList.EXPORT.id);
			}
		};
		ServiceRegistration<?> registration = register(IInvoiceDefaultsProvider.class, provider, 10);
		try {
			MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
			invoice.setIsSOTrx(true);
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
			invoice.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id);
			invoice.setC_BPartner_Location_ID(DictionaryIDs.C_BPartner_Location.C_AND_W_STAMFORD.id);
			invoice.setDateInvoiced(TimeUtil.getDay(System.currentTimeMillis()));
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
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
	public void testValueSetByCallerIsKept() {
		IOrderDefaultsProvider provider = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getC_PaymentTerm_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id);
			}
		};
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, provider, 10);
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
		IOrderDefaultsProvider high = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getSalesRep_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id);
			}
		};
		IOrderDefaultsProvider low = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getSalesRep_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			}
			@Override
			public DefaultValue<Integer> getC_PaymentTerm_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id);
			}
		};
		ServiceRegistration<?> highRegistration = register(IOrderDefaultsProvider.class, high, 20);
		ServiceRegistration<?> lowRegistration = register(IOrderDefaultsProvider.class, low, 10);
		try {
			MOrder order = newOrder();
			order.saveEx();
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, order.getSalesRep_ID());
			// high returns USE_FALLBACK for the payment term, so low decides
			assertEquals(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id, order.getC_PaymentTerm_ID());
		} finally {
			highRegistration.unregister();
			lowRegistration.unregister();
		}
	}

	@Test
	public void testRankingDecidesNotRegistrationOrder() {
		IOrderDefaultsProvider low = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getSalesRep_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
			}
		};
		IOrderDefaultsProvider high = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getSalesRep_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.AD_User.GARDEN_USER.id);
			}
		};
		// low registered first: it gets the lower service.id, so only service.ranking can put high first
		ServiceRegistration<?> lowRegistration = register(IOrderDefaultsProvider.class, low, 10);
		ServiceRegistration<?> highRegistration = register(IOrderDefaultsProvider.class, high, 20);
		try {
			MOrder order = newOrder();
			assertEquals(DictionaryIDs.AD_User.GARDEN_USER.id, Core.getOrderDefaults().get(provider -> provider.getSalesRep_ID(order)).getValue());
		} finally {
			lowRegistration.unregister();
			highRegistration.unregister();
		}
	}

	@Test
	public void testProviderRegisteredAfterLookupIsAsked() {
		MOrder order = newOrder();
		// first lookup caches the service holder for the provider type
		assertTrue(Core.getOrderDefaults().get(provider -> provider.getC_PaymentTerm_ID(order)).isUseFallback());
		IOrderDefaultsProvider provider = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getC_PaymentTerm_ID(MOrder document) {
				return DefaultValue.of(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id);
			}
		};
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, provider, 10);
		try {
			assertEquals(DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id, Core.getOrderDefaults().get(p -> p.getC_PaymentTerm_ID(order)).getValue());
		} finally {
			registration.unregister();
		}
		assertTrue(Core.getOrderDefaults().get(p -> p.getC_PaymentTerm_ID(order)).isUseFallback());
	}

	@Test
	public void testNoDefaultSkipsBuiltInFallback() {
		IOrderDefaultsProvider provider = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getSalesRep_ID(MOrder document) {
				return DefaultValue.noDefault();
			}
		};
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, provider, 10);
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
		IOrderDefaultsProvider provider = new IOrderDefaultsProvider() {
			@Override
			public void initDefaults(MOrder document) {
				document.set_ValueNoCheck(MOrder.COLUMNNAME_DeliveryRule, null);
				document.set_ValueNoCheck(MOrder.COLUMNNAME_InvoiceRule, null);
			}
			@Override
			public DefaultValue<String> getDeliveryRule(MOrder document) {
				return DefaultValue.of(MOrder.DELIVERYRULE_CompleteOrder);
			}
		};
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, provider, 10);
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

	/**
	 * Provider that clears both rules at construction and leaves the decision to the built-in fallback
	 */
	private IOrderDefaultsProvider clearingProvider() {
		return new IOrderDefaultsProvider() {
			@Override
			public void initDefaults(MOrder document) {
				document.set_ValueNoCheck(MOrder.COLUMNNAME_DeliveryRule, null);
				document.set_ValueNoCheck(MOrder.COLUMNNAME_InvoiceRule, null);
			}
		};
	}

	@Test
	public void testClearedRulesSaveForOrderCreatedInCode() {
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, clearingProvider(), 10);
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
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, clearingProvider(), 10);
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
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, clearingProvider(), 10);
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
		IOrderDefaultsProvider provider = new IOrderDefaultsProvider() {
			@Override
			public DefaultValue<Integer> getM_PriceList_ID(MOrder document) {
				return DefaultValue.noDefault();
			}
		};
		ServiceRegistration<?> registration = register(IOrderDefaultsProvider.class, provider, 10);
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

	private <P> ServiceRegistration<P> register(Class<P> type, P provider, int ranking) {
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		return TestActivator.context.registerService(type, provider, properties);
	}
}
