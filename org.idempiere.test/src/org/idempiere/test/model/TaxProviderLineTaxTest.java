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
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;

import org.adempiere.base.Core;
import org.adempiere.model.ITaxProvider;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MTax;
import org.compiere.model.MTaxProvider;
import org.compiere.model.StandardTaxProvider;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * IDEMPIERE-7145 - the tax provider calculates the invoice line tax amount
 * ({@link ITaxProvider#updateLineTax(MTaxProvider, MInvoiceLine)}).
 */
public class TaxProviderLineTaxTest extends AbstractTestCase {

	private static final BigDecimal PROVIDER_TAX_AMT = new BigDecimal("1.23");

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
		assertEquals(0, line.getLineNetAmt().add(expected).compareTo(line.getLineTotalAmt()), "Unexpected line total: " + line.getLineTotalAmt());
	}

	/**
	 * Saving an invoice line whose tax provider overrides updateLineTax: the line tax amount comes from the provider.
	 */
	@Test
	public void testProviderLineTax() {
		try (MockedStatic<Core> coreMock = mockStatic(Core.class, Mockito.CALLS_REAL_METHODS)) {
			coreMock.when(() -> Core.getTaxProvider(any(MTaxProvider.class))).thenReturn(new LineTaxProvider());

			MInvoice invoice = createInvoice();
			MInvoiceLine line = new MInvoiceLine(invoice);
			line.setLine(10);
			line.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
			line.setQty(Env.ONE);
			line.setPrice(Env.ONEHUNDRED);
			line.setC_Tax_ID(DictionaryIDs.C_Tax.CT_SALES.id);
			line.saveEx();

			assertEquals(0, Env.ONEHUNDRED.compareTo(line.getLineNetAmt()), "Unexpected line net amount: " + line.getLineNetAmt());
			assertEquals(0, PROVIDER_TAX_AMT.compareTo(line.getTaxAmt()), "Line tax amount not calculated by the tax provider: " + line.getTaxAmt());
			assertEquals(0, line.getLineNetAmt().add(PROVIDER_TAX_AMT).compareTo(line.getLineTotalAmt()), "Unexpected line total: " + line.getLineTotalAmt());
		} finally {
			rollback();
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
		 * Set the fixed {@link #PROVIDER_TAX_AMT} as line tax amount,
		 * updating LineNetAmt and LineTotalAmt as {@link MInvoiceLine#setTaxAmt()} does.
		 */
		@Override
		public boolean updateLineTax(MTaxProvider provider, MInvoiceLine line) {
			line.setLineNetAmt();
			line.setTaxAmt(PROVIDER_TAX_AMT);
			if (line.isTaxIncluded())
				line.setLineTotalAmt(line.getLineNetAmt());
			else
				line.setLineTotalAmt(line.getLineNetAmt().add(PROVIDER_TAX_AMT));
			return true;
		}
	}
}
