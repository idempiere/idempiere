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

import java.math.BigDecimal;
import java.util.Dictionary;
import java.util.Hashtable;

import org.adempiere.base.ITaxProviderFactory;
import org.adempiere.base.MappedByNameFactory;
import org.adempiere.model.ITaxProvider;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MTax;
import org.compiere.model.MTaxCategory;
import org.compiere.model.MTaxProvider;
import org.compiere.model.MTaxProviderCfg;
import org.compiere.model.StandardTaxProvider;
import org.compiere.process.DocAction;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

/**
 * IDEMPIERE-7145 - the tax provider calculates the invoice line tax amount
 * ({@link ITaxProvider#updateLineTax(MTaxProvider, MInvoiceLine)}).
 */
@Isolated
public class TaxProviderLineTaxTest extends AbstractTestCase {

	private static final BigDecimal PROVIDER_TAX_AMT = new BigDecimal("1.23");
	private static final String PROVIDER_CLASS = "TaxProviderLineTaxTest.LineTaxProvider";

	/**
	 * A provider that does not override updateLineTax (StandardTaxProvider) calculates the line tax with the tax rate, as before.
	 */
	@Test
	public void testDefaultLineTax() {
		MInvoice invoice = createInvoice();
		MInvoiceLine line = new MInvoiceLine(invoice);
		line.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		line.setQty(Env.ONE);
		line.setPrice(Env.ONEHUNDRED);
		line.setC_Tax_ID(DictionaryIDs.C_Tax.CT_SALES.id);
		line.setTaxAmt(Env.ZERO);

		assertTrue(new StandardTaxProvider().updateLineTax(null, line));

		MTax tax = MTax.get(Env.getCtx(), DictionaryIDs.C_Tax.CT_SALES.id);
		BigDecimal expected = tax.calculateTax(line.getLineNetAmt(), line.isTaxIncluded(), line.getPrecision());
		assertTrue(expected.signum() > 0, "Expected a non-zero tax for the test");
		assertEquals(0, expected.compareTo(line.getTaxAmt()), "Unexpected line tax amount: " + line.getTaxAmt());
	}

	/**
	 * Saving an invoice line whose tax has a custom provider: the line tax amount comes from the provider.
	 */
	@Test
	public void testProviderLineTax() {
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		ServiceRegistration<ITaxProviderFactory> sr = bc.registerService(ITaxProviderFactory.class, new LineTaxProviderFactory(), properties);

		//need to create tax and provider without trx as they are cached
		MTaxProviderCfg cfg = null;
		MTaxProvider provider = null;
		MTaxCategory category = null;
		MTax tax = null;
		try {
			cfg = new MTaxProviderCfg(Env.getCtx(), 0, null);
			cfg.setName("testProviderLineTax");
			cfg.setTaxProviderClass(PROVIDER_CLASS);
			cfg.saveEx();

			provider = new MTaxProvider(Env.getCtx(), 0, null);
			provider.setName("testProviderLineTax");
			provider.setC_TaxProviderCfg_ID(cfg.get_ID());
			provider.saveEx();

			category = new MTaxCategory(Env.getCtx(), 0, null);
			category.setName("testProviderLineTax");
			category.saveEx();

			tax = new MTax(Env.getCtx(), 0, null);
			tax.setName("testProviderLineTax");
			tax.setC_TaxCategory_ID(category.get_ID());
			tax.setIsDocumentLevel(false);
			tax.setIsSummary(false);
			tax.setRate(new BigDecimal("10.00"));
			tax.setSOPOType(MTax.SOPOTYPE_Both);
			tax.setC_TaxProvider_ID(provider.get_ID());
			tax.saveEx();
			CacheMgt.get().reset();

			MInvoice invoice = createInvoice();
			MInvoiceLine line = new MInvoiceLine(invoice);
			line.setLine(10);
			line.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
			line.setQty(Env.ONE);
			line.setPrice(Env.ONEHUNDRED);
			line.setC_Tax_ID(tax.get_ID());
			line.saveEx();

			assertEquals(0, PROVIDER_TAX_AMT.compareTo(line.getTaxAmt()), "Line tax amount not calculated by the tax provider: " + line.getTaxAmt());
			assertEquals(0, line.getLineNetAmt().add(PROVIDER_TAX_AMT).compareTo(line.getLineTotalAmt()), "Unexpected line total: " + line.getLineTotalAmt());
		} finally {
			rollback();
			sr.unregister();
			if (tax != null && tax.get_ID() > 0)
				tax.deleteEx(true);
			if (category != null && category.get_ID() > 0)
				category.deleteEx(true);
			if (provider != null && provider.get_ID() > 0)
				provider.deleteEx(true);
			if (cfg != null && cfg.get_ID() > 0)
				cfg.deleteEx(true);
		}
	}

	/**
	 * Create a drafted AR invoice for C&W.
	 * @return saved invoice
	 */
	private MInvoice createInvoice() {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID());
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		invoice.setDateInvoiced(TimeUtil.getDay(null));
		invoice.setDateAcct(TimeUtil.getDay(null));
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		return invoice;
	}

	/** Calculates the line tax itself: a fixed amount */
	private static final class LineTaxProvider extends StandardTaxProvider {
		/**
		 * Set the fixed {@link #PROVIDER_TAX_AMT} as line tax amount.
		 */
		@Override
		public boolean updateLineTax(MTaxProvider provider, MInvoiceLine line) {
			line.setTaxAmt(PROVIDER_TAX_AMT);
			line.setLineTotalAmt(line.getLineNetAmt().add(PROVIDER_TAX_AMT));
			return true;
		}
	}

	/** Creates {@link LineTaxProvider} for {@link #PROVIDER_CLASS} */
	private static final class LineTaxProviderFactory extends MappedByNameFactory<ITaxProvider> implements ITaxProviderFactory {
		/**
		 * Register the mapping of {@link #PROVIDER_CLASS} to {@link LineTaxProvider}.
		 */
		public LineTaxProviderFactory() {
			addMapping(PROVIDER_CLASS, () -> new LineTaxProvider());
		}

		/**
		 * @param className tax provider class name
		 * @return new tax provider instance, or null if className is not mapped
		 */
		@Override
		public ITaxProvider newTaxProviderInstance(String className) {
			return newInstance(className);
		}
	}
}
