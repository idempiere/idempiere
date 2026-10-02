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

import java.sql.Timestamp;
import java.util.Dictionary;
import java.util.Hashtable;

import org.adempiere.base.Core;
import org.adempiere.base.IDocumentDefaultsProvider;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
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
 * Tests for {@link IDocumentDefaultsProvider}: header defaults applied in
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
		assertEquals(IDocumentDefaultsProvider.USE_FALLBACK, Core.getDocumentDefaults().getSalesRep_ID(order));
	}

	@Test
	public void testProviderOverridesFallbacks() {
		IDocumentDefaultsProvider<MOrder> provider = new IDocumentDefaultsProvider<MOrder>() {
			@Override
			public int getSalesRep_ID(MOrder document) {
				return DictionaryIDs.AD_User.GARDEN_USER.id;
			}
			@Override
			public int getC_PaymentTerm_ID(MOrder document) {
				return DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id;
			}
			@Override
			public int getM_PriceList_ID(MOrder document) {
				return DictionaryIDs.M_PriceList.EXPORT.id;
			}
		};
		ServiceRegistration<?> registration = register(provider, MOrder.Table_Name, 10);
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
		IDocumentDefaultsProvider<MInvoice> provider = new IDocumentDefaultsProvider<MInvoice>() {
			@Override
			public int getSalesRep_ID(MInvoice document) {
				return DictionaryIDs.AD_User.GARDEN_USER.id;
			}
			@Override
			public int getC_PaymentTerm_ID(MInvoice document) {
				return DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id;
			}
			@Override
			public int getM_PriceList_ID(MInvoice document) {
				return DictionaryIDs.M_PriceList.EXPORT.id;
			}
		};
		ServiceRegistration<?> registration = register(provider, MInvoice.Table_Name, 10);
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
		IDocumentDefaultsProvider<MOrder> provider = new IDocumentDefaultsProvider<MOrder>() {
			@Override
			public int getC_PaymentTerm_ID(MOrder document) {
				return DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id;
			}
		};
		ServiceRegistration<?> registration = register(provider, MOrder.Table_Name, 10);
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
		IDocumentDefaultsProvider<MOrder> high = new IDocumentDefaultsProvider<MOrder>() {
			@Override
			public int getSalesRep_ID(MOrder document) {
				return DictionaryIDs.AD_User.GARDEN_USER.id;
			}
		};
		IDocumentDefaultsProvider<MOrder> low = new IDocumentDefaultsProvider<MOrder>() {
			@Override
			public int getSalesRep_ID(MOrder document) {
				return DictionaryIDs.AD_User.GARDEN_ADMIN.id;
			}
			@Override
			public int getC_PaymentTerm_ID(MOrder document) {
				return DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id;
			}
		};
		ServiceRegistration<?> highRegistration = register(high, MOrder.Table_Name, 20);
		ServiceRegistration<?> lowRegistration = register(low, MOrder.Table_Name, 10);
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
	public void testProviderForOtherTableIsNotAsked() {
		IDocumentDefaultsProvider<MInvoice> invoiceProvider = new IDocumentDefaultsProvider<MInvoice>() {
			@Override
			public int getC_PaymentTerm_ID(MInvoice document) {
				return DictionaryIDs.C_PaymentTerm.TWO_PERCENT_10_NET_30.id;
			}
		};
		ServiceRegistration<?> registration = register(invoiceProvider, MInvoice.Table_Name, 10);
		try {
			MOrder order = newOrder();
			assertEquals(IDocumentDefaultsProvider.USE_FALLBACK, Core.getDocumentDefaults().getC_PaymentTerm_ID(order));
		} finally {
			registration.unregister();
		}
	}

	@Test
	public void testInitDefaultsClearedRuleIsResolvedOnSave() {
		IDocumentDefaultsProvider<MOrder> provider = new IDocumentDefaultsProvider<MOrder>() {
			@Override
			public void initDefaults(MOrder document) {
				document.setDeliveryRule(null);
				document.setInvoiceRule(null);
			}
			@Override
			public String getDeliveryRule(MOrder document) {
				return MOrder.DELIVERYRULE_CompleteOrder;
			}
		};
		ServiceRegistration<?> registration = register(provider, MOrder.Table_Name, 10);
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

	private ServiceRegistration<?> register(IDocumentDefaultsProvider<?> provider, String tableName, int ranking) {
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		properties.put("tableName", tableName);
		return TestActivator.context.registerService(IDocumentDefaultsProvider.class.getName(), provider, properties);
	}
}
