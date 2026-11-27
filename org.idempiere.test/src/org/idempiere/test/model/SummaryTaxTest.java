/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MBPartner;
import org.compiere.model.MCharge;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MInvoiceTax;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrderTax;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MTax;
import org.compiere.model.MTaxCategory;
import org.compiere.process.DocAction;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Integration tests for summary-level tax splitting, consolidation, and recalculation
 * across invoices, sales orders, and RMAs (IDEMPIERE-5117).
 * <p>
 * Covers:
 * <ul>
 * <li>Splitting summary taxes into child tax rows and recalculating amounts on line updates without
 * duplicating tax lines.</li>
 * <li>Tax-included price lists combined with summary taxes without double taxation.</li>
 * <li>Consolidating a summary tax line with a direct child tax line on the same document.</li>
 * <li>Consistent summary-tax recalculation in {@code StandardTaxProvider} for invoices, orders, and
 * RMAs.</li>
 * </ul>
 */
public class SummaryTaxTest extends AbstractTestCase
{

	/**
	 * Verifies that updating a customer invoice line after prepare recalculates child tax lines
	 * in place without recreating the summary tax or duplicating child tax records.
	 * <p>
	 * Uses summary tax {@code GST/PST 12%} (children {@code GST 5%} and {@code PST 7%}) on
	 * {@code Consulting Service Fee}, updating the line from {@code 100.00} ({@code 112.00} grand
	 * total)
	 * to {@code 200.00} ({@code 224.00} grand total).
	 */
	@Test
	public void testSummaryTaxUpdateAfterPrepare()
	{
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		String uniqueSuffix = "_" + System.currentTimeMillis();

		// Commit master tax/charge setup in a separate trx so MTax.get(ctx, id) can load them from
		// DB/cache
		String setupTrxName = Trx.createTrxName("TaxSetup5117_1");
		Trx setupTrx = Trx.get(setupTrxName, true);

		MTaxCategory taxCategory = null;
		MTax summaryTax = null;
		MTax gstTax = null;
		MTax pstTax = null;
		MCharge consultingCharge = null;

		try
		{
			taxCategory = new MTaxCategory(Env.getCtx(), 0, setupTrxName);
			taxCategory.setName("GST/PST Standard Category" + uniqueSuffix);
			taxCategory.saveEx();

			summaryTax = new MTax(Env.getCtx(), 0, setupTrxName);
			summaryTax.setName("GST/PST 12%" + uniqueSuffix);
			summaryTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			summaryTax.setValidFrom(today);
			summaryTax.setIsSummary(true);
			summaryTax.setRate(BigDecimal.ZERO);
			summaryTax.setSOPOType(MTax.SOPOTYPE_Both);
			summaryTax.saveEx();

			gstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			gstTax.setName("GST 5%" + uniqueSuffix);
			gstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			gstTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			gstTax.setValidFrom(today);
			gstTax.setIsSummary(false);
			gstTax.setRate(new BigDecimal("5"));
			gstTax.setSOPOType(MTax.SOPOTYPE_Both);
			gstTax.saveEx();

			pstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			pstTax.setName("PST 7%" + uniqueSuffix);
			pstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			pstTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			pstTax.setValidFrom(today);
			pstTax.setIsSummary(false);
			pstTax.setRate(new BigDecimal("7"));
			pstTax.setSOPOType(MTax.SOPOTYPE_Both);
			pstTax.saveEx();

			consultingCharge = new MCharge(Env.getCtx(), 0, setupTrxName);
			consultingCharge.setName("Consulting Service Fee" + uniqueSuffix);
			consultingCharge.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			consultingCharge.setChargeAmt(new BigDecimal("100.00"));
			consultingCharge.saveEx();

			setupTrx.commit(true);
		}
		catch (Exception e)
		{
			setupTrx.rollback();
			throw new RuntimeException(e);
		}
		finally
		{
			setupTrx.close();
		}

		try
		{
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MInvoice invoice = new MInvoice(Env.getCtx(), 0, trxName);
			invoice.setBPartner(bpartner);
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
			invoice.setIsSOTrx(true);
			invoice.saveEx();

			// Create invoice line with Consulting Service Fee = 100.00 and Summary Tax "GST/PST
			// 12%"
			MInvoiceLine line = new MInvoiceLine(invoice);
			line.setC_Charge_ID(consultingCharge.getC_Charge_ID());
			line.setQty(BigDecimal.ONE);
			line.setPrice(new BigDecimal("100.00"));
			line.setC_Tax_ID(summaryTax.getC_Tax_ID());
			line.saveEx();

			// Verify before Prepare: summary tax is already split into 2 child tax lines on line
			// save
			MInvoiceTax[] taxesBeforePrepare = invoice.getTaxes(true);
			assertEquals(2, taxesBeforePrepare.length, "Child tax lines should be created for summary tax");
			assertNull(MInvoiceTax.get(invoice.getC_Invoice_ID(), summaryTax.getC_Tax_ID(), trxName),
							"Summary tax record should not exist");

			// Prepare invoice and verify child tax amounts
			assertTrue(invoice.processIt(DocAction.ACTION_Prepare), "Invoice prepare should succeed: " + invoice.getProcessMsg());
			invoice.saveEx();

			MInvoiceTax[] taxesAfterPrepare = invoice.getTaxes(true);
			assertEquals(2, taxesAfterPrepare.length, "Summary tax should be replaced by 2 child taxes after prepare");
			assertNull(MInvoiceTax.get(invoice.getC_Invoice_ID(), summaryTax.getC_Tax_ID(), trxName),
							"Summary tax record should be deleted after prepare");

			MInvoiceTax gstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), gstTax.getC_Tax_ID(), trxName);
			MInvoiceTax pstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), pstTax.getC_Tax_ID(), trxName);
			assertNotNull(gstLine, "GST 5% child tax line should exist");
			assertNotNull(pstLine, "PST 7% child tax line should exist");
			assertEquals(0, new BigDecimal("5.00").compareTo(gstLine.getTaxAmt()), "GST 5% should be 5.00");
			assertEquals(0, new BigDecimal("7.00").compareTo(pstLine.getTaxAmt()), "PST 7% should be 7.00");

			invoice.load(trxName);
			assertEquals(0, new BigDecimal("112.00").compareTo(invoice.getGrandTotal()),
							"Grand Total after prepare should be 100 + 5 + 7 = 112.00");

			// Update existing invoice line (100.00 -> 200.00) and re-prepare to ensure tax is not
			// doubled
			line.setPrice(new BigDecimal("200.00"));
			line.saveEx();

			assertTrue(invoice.processIt(DocAction.ACTION_Prepare), "Re-prepare should succeed");
			invoice.saveEx();

			MInvoiceTax[] taxesAfterUpdate = invoice.getTaxes(true);
			assertEquals(2, taxesAfterUpdate.length, "Should still have only 2 child tax lines (no duplicate summary or child lines)");
			assertNull(MInvoiceTax.get(invoice.getC_Invoice_ID(), summaryTax.getC_Tax_ID(), trxName),
							"Summary tax must not reappear after updating line");

			gstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), gstTax.getC_Tax_ID(), trxName);
			pstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), pstTax.getC_Tax_ID(), trxName);
			assertEquals(0, new BigDecimal("10.00").compareTo(gstLine.getTaxAmt()), "GST 5% should be 10.00");
			assertEquals(0, new BigDecimal("14.00").compareTo(pstLine.getTaxAmt()), "PST 7% should be 14.00");

			invoice.load(trxName);
			assertEquals(0, new BigDecimal("224.00").compareTo(invoice.getGrandTotal()),
							"Grand Total after line update should be 200 + 10 + 14 = 224.00 (not doubled)");
		}
		finally
		{
			rollback();
			if (consultingCharge != null)
				consultingCharge.deleteEx(true, null);
			if (pstTax != null)
				pstTax.deleteEx(true, null);
			if (gstTax != null)
				gstTax.deleteEx(true, null);
			if (summaryTax != null)
				summaryTax.deleteEx(true, null);
			if (taxCategory != null)
				taxCategory.deleteEx(true, null);
			CacheMgt.get().reset();
		}
	}

	/**
	 * Verifies that a tax-included price list ({@code IsTaxIncluded = Y}) works with a summary tax
	 * without double-taxing when the line is saved, prepared, and updated.
	 * <p>
	 * Uses {@code Retail Tax-Included Price List} and summary tax {@code GST/PST 10%} (children
	 * {@code GST 4%} and {@code PST 6%}) on {@code Annual Support Package}, scaling from
	 * {@code 110.00}
	 * to {@code 220.00} while doubling the grand total cleanly.
	 */
	@Test
	public void testTaxIncludedPriceListWithSummaryTax()
	{
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		String uniqueSuffix = "_" + System.currentTimeMillis();

		String setupTrxName = Trx.createTrxName("TaxSetup5117_2");
		Trx setupTrx = Trx.get(setupTrxName, true);

		MPriceList retailTaxIncludedPL = null;
		MPriceListVersion plv = null;
		MTaxCategory taxCategory = null;
		MTax summaryTax = null;
		MTax gstChildTax = null;
		MTax pstChildTax = null;
		MCharge supportCharge = null;

		try
		{
			retailTaxIncludedPL = new MPriceList(Env.getCtx(), 0, setupTrxName);
			retailTaxIncludedPL.setName("Retail Tax-Included Price List" + uniqueSuffix);
			retailTaxIncludedPL.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			retailTaxIncludedPL.setIsSOPriceList(true);
			retailTaxIncludedPL.setIsTaxIncluded(true);
			retailTaxIncludedPL.setPricePrecision(2);
			retailTaxIncludedPL.saveEx();

			plv = new MPriceListVersion(retailTaxIncludedPL);
			plv.setName("Standard Version");
			plv.setValidFrom(today);
			plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.SALES_2001.id);
			plv.saveEx();

			taxCategory = new MTaxCategory(Env.getCtx(), 0, setupTrxName);
			taxCategory.setName("GST/PST Retail Category" + uniqueSuffix);
			taxCategory.saveEx();

			summaryTax = new MTax(Env.getCtx(), 0, setupTrxName);
			summaryTax.setName("GST/PST 10%" + uniqueSuffix);
			summaryTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			summaryTax.setValidFrom(today);
			summaryTax.setIsSummary(true);
			summaryTax.setRate(new BigDecimal("10"));
			summaryTax.setSOPOType(MTax.SOPOTYPE_Both);
			summaryTax.saveEx();

			gstChildTax = new MTax(Env.getCtx(), 0, setupTrxName);
			gstChildTax.setName("GST 4%" + uniqueSuffix);
			gstChildTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			gstChildTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			gstChildTax.setValidFrom(today);
			gstChildTax.setIsSummary(false);
			gstChildTax.setRate(new BigDecimal("4"));
			gstChildTax.setSOPOType(MTax.SOPOTYPE_Both);
			gstChildTax.saveEx();

			pstChildTax = new MTax(Env.getCtx(), 0, setupTrxName);
			pstChildTax.setName("PST 6%" + uniqueSuffix);
			pstChildTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			pstChildTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			pstChildTax.setValidFrom(today);
			pstChildTax.setIsSummary(false);
			pstChildTax.setRate(new BigDecimal("6"));
			pstChildTax.setSOPOType(MTax.SOPOTYPE_Both);
			pstChildTax.saveEx();

			supportCharge = new MCharge(Env.getCtx(), 0, setupTrxName);
			supportCharge.setName("Annual Support Package" + uniqueSuffix);
			supportCharge.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			supportCharge.setChargeAmt(new BigDecimal("110.00"));
			supportCharge.saveEx();

			setupTrx.commit(true);
		}
		catch (Exception e)
		{
			setupTrx.rollback();
			throw new RuntimeException(e);
		}
		finally
		{
			setupTrx.close();
		}

		try
		{
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MInvoice invoice = new MInvoice(Env.getCtx(), 0, trxName);
			invoice.setBPartner(bpartner);
			invoice.setM_PriceList_ID(retailTaxIncludedPL.getM_PriceList_ID());
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
			invoice.setIsSOTrx(true);
			invoice.saveEx();

			// Saving line with Tax-Included PriceList + Summary Tax should succeed[cite: 1]
			MInvoiceLine line = new MInvoiceLine(invoice);
			line.setC_Charge_ID(supportCharge.getC_Charge_ID());
			line.setQty(BigDecimal.ONE);
			line.setPrice(new BigDecimal("110.00"));
			line.setC_Tax_ID(summaryTax.getC_Tax_ID());
			line.saveEx();

			assertTrue(invoice.processIt(DocAction.ACTION_Prepare), "Prepare should succeed on tax-included summary invoice");
			invoice.saveEx();

			MInvoiceTax[] taxesAfterPrepare = invoice.getTaxes(true);
			assertEquals(2, taxesAfterPrepare.length, "Should have 2 child tax lines after prepare");
			assertNull(MInvoiceTax.get(invoice.getC_Invoice_ID(), summaryTax.getC_Tax_ID(), trxName),
							"Summary tax line should be deleted after prepare");

			// Verify exact child tax amounts on 110.00 charge base
			MInvoiceTax gstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), gstChildTax.getC_Tax_ID(), trxName);
			MInvoiceTax pstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), pstChildTax.getC_Tax_ID(), trxName);
			assertNotNull(gstLine, "GST 4% tax line should exist");
			assertNotNull(pstLine, "PST 6% tax line should exist");
			assertEquals(0, new BigDecimal("4.40").compareTo(gstLine.getTaxAmt()), "GST 4% tax amount should be 4.40");
			assertEquals(0, new BigDecimal("6.60").compareTo(pstLine.getTaxAmt()), "PST 6% tax amount should be 6.60");

			invoice.load(trxName);
			BigDecimal grandTotalAfterPrepare = invoice.getGrandTotal();
			assertTrue(grandTotalAfterPrepare.signum() > 0, "Grand Total should be positive");

			// Update line price (110.00 -> 220.00) and verify taxes scale proportionally without
			// duplication
			line.setPrice(new BigDecimal("220.00"));
			line.saveEx();

			assertTrue(invoice.processIt(DocAction.ACTION_Prepare), "Re-prepare should succeed");
			invoice.saveEx();

			assertEquals(2, invoice.getTaxes(true).length, "Should still have only 2 child tax lines after update");

			gstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), gstChildTax.getC_Tax_ID(), trxName);
			pstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), pstChildTax.getC_Tax_ID(), trxName);
			assertEquals(0, new BigDecimal("8.80").compareTo(gstLine.getTaxAmt()), "Updated GST 4% tax amount should be 8.80");
			assertEquals(0, new BigDecimal("13.20").compareTo(pstLine.getTaxAmt()), "Updated PST 6% tax amount should be 13.20");

			invoice.load(trxName);
			assertEquals(0, grandTotalAfterPrepare.multiply(new BigDecimal("2")).compareTo(invoice.getGrandTotal()),
							"Doubling line price should exactly double Grand Total (no double-tax bug)");
		}
		finally
		{
			rollback();
			if (supportCharge != null)
				supportCharge.deleteEx(true, null);
			if (pstChildTax != null)
				pstChildTax.deleteEx(true, null);
			if (gstChildTax != null)
				gstChildTax.deleteEx(true, null);
			if (summaryTax != null)
				summaryTax.deleteEx(true, null);
			if (taxCategory != null)
				taxCategory.deleteEx(true, null);
			if (plv != null)
				plv.deleteEx(true, null);
			if (retailTaxIncludedPL != null)
				retailTaxIncludedPL.deleteEx(true, null);
			CacheMgt.get().reset();
		}
	}

	/**
	 * Verifies that mixing a summary tax line and a direct child tax line on the same invoice
	 * consolidates into single child {@link org.compiere.model.MInvoiceTax} records with summed
	 * amounts.
	 * <p>
	 * Combines {@code SGST + CGST 18%} ({@code SGST 9%} + {@code CGST 9%}) with a direct
	 * {@code SGST 9%}
	 * line on {@code Implementation Charges}, verifying consolidated totals before and after
	 * updating line 1.
	 */
	@Test
	public void testSummaryTaxCombinedWithDirectChildTaxLine()
	{
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		String trxName = getTrxName();
		String uniqueSuffix = "_" + System.currentTimeMillis();

		String setupTrxName = Trx.createTrxName("TaxSetup5117_3");
		Trx setupTrx = Trx.get(setupTrxName, true);

		MTaxCategory taxCategory = null;
		MTax sgstCgstSummaryTax = null;
		MTax sgstTax = null;
		MTax cgstTax = null;
		MCharge implementationCharge = null;

		try
		{
			taxCategory = new MTaxCategory(Env.getCtx(), 0, setupTrxName);
			taxCategory.setName("Indian GST Category" + uniqueSuffix);
			taxCategory.saveEx();

			sgstCgstSummaryTax = new MTax(Env.getCtx(), 0, setupTrxName);
			sgstCgstSummaryTax.setName("SGST + CGST 18%" + uniqueSuffix);
			sgstCgstSummaryTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			sgstCgstSummaryTax.setValidFrom(today);
			sgstCgstSummaryTax.setIsSummary(true);
			sgstCgstSummaryTax.setRate(BigDecimal.ZERO);
			sgstCgstSummaryTax.setSOPOType(MTax.SOPOTYPE_Both);
			sgstCgstSummaryTax.saveEx();

			sgstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			sgstTax.setName("SGST 9%" + uniqueSuffix);
			sgstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			sgstTax.setParent_Tax_ID(sgstCgstSummaryTax.getC_Tax_ID());
			sgstTax.setValidFrom(today);
			sgstTax.setIsSummary(false);
			sgstTax.setRate(new BigDecimal("9"));
			sgstTax.setSOPOType(MTax.SOPOTYPE_Both);
			sgstTax.saveEx();

			cgstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			cgstTax.setName("CGST 9%" + uniqueSuffix);
			cgstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			cgstTax.setParent_Tax_ID(sgstCgstSummaryTax.getC_Tax_ID());
			cgstTax.setValidFrom(today);
			cgstTax.setIsSummary(false);
			cgstTax.setRate(new BigDecimal("9"));
			cgstTax.setSOPOType(MTax.SOPOTYPE_Both);
			cgstTax.saveEx();

			implementationCharge = new MCharge(Env.getCtx(), 0, setupTrxName);
			implementationCharge.setName("Implementation Charges" + uniqueSuffix);
			implementationCharge.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			implementationCharge.setChargeAmt(new BigDecimal("100.00"));
			implementationCharge.saveEx();

			setupTrx.commit(true);
		}
		catch (Exception e)
		{
			setupTrx.rollback();
			throw new RuntimeException(e);
		}
		finally
		{
			setupTrx.close();
		}

		try
		{
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MInvoice invoice = new MInvoice(Env.getCtx(), 0, trxName);
			invoice.setBPartner(bpartner);
			invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
			invoice.setIsSOTrx(true);
			invoice.saveEx();

			// Line 1: Amount 100.00 with Summary Tax ("SGST + CGST 18%" -> 9.00 SGST + 9.00 CGST)
			MInvoiceLine line1 = new MInvoiceLine(invoice);
			line1.setC_Charge_ID(implementationCharge.getC_Charge_ID());
			line1.setQty(BigDecimal.ONE);
			line1.setPrice(new BigDecimal("100.00"));
			line1.setC_Tax_ID(sgstCgstSummaryTax.getC_Tax_ID());
			line1.saveEx();

			// Line 2: Amount 100.00 with direct Child Tax ("SGST 9%" -> 9.00 SGST)
			MInvoiceLine line2 = new MInvoiceLine(invoice);
			line2.setC_Charge_ID(implementationCharge.getC_Charge_ID());
			line2.setQty(BigDecimal.ONE);
			line2.setPrice(new BigDecimal("100.00"));
			line2.setC_Tax_ID(sgstTax.getC_Tax_ID());
			line2.saveEx();

			// Prepare and verify ONLY 2 consolidated tax lines exist (SGST and CGST)
			assertTrue(invoice.processIt(DocAction.ACTION_Prepare), "Prepare should succeed: " + invoice.getProcessMsg());
			invoice.saveEx();

			MInvoiceTax[] taxesAfterPrepare = invoice.getTaxes(true);
			assertEquals(2, taxesAfterPrepare.length, "Must have exactly 2 tax lines: one for SGST and one for CGST");
			assertNull(MInvoiceTax.get(invoice.getC_Invoice_ID(), sgstCgstSummaryTax.getC_Tax_ID(), trxName),
							"Summary tax record should be deleted");

			MInvoiceTax sgstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), sgstTax.getC_Tax_ID(), trxName);
			MInvoiceTax cgstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), cgstTax.getC_Tax_ID(), trxName);
			assertNotNull(sgstLine, "SGST 9% tax line should exist");
			assertNotNull(cgstLine, "CGST 9% tax line should exist");
			assertEquals(0, new BigDecimal("18.00").compareTo(sgstLine.getTaxAmt()), "SGST should combine Line 1 (9) + Line 2 (9) = 18.00");
			assertEquals(0, new BigDecimal("9.00").compareTo(cgstLine.getTaxAmt()), "CGST should be 9.00 from Line 1");

			invoice.load(trxName);
			assertEquals(0, new BigDecimal("227.00").compareTo(invoice.getGrandTotal()),
							"Grand Total should be 200 + 18 + 9 = 227.00");

			// Update Line 1 (100.00 -> 200.00) and re-prepare
			line1.setPrice(new BigDecimal("200.00"));
			line1.saveEx();

			assertTrue(invoice.processIt(DocAction.ACTION_Prepare), "Re-prepare should succeed");
			invoice.saveEx();

			assertEquals(2, invoice.getTaxes(true).length, "Must still have only 2 tax lines after updating line");
			sgstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), sgstTax.getC_Tax_ID(), trxName);
			cgstLine = MInvoiceTax.get(invoice.getC_Invoice_ID(), cgstTax.getC_Tax_ID(), trxName);
			assertEquals(0, new BigDecimal("27.00").compareTo(sgstLine.getTaxAmt()), "Updated SGST should be 18 + 9 = 27.00");
			assertEquals(0, new BigDecimal("18.00").compareTo(cgstLine.getTaxAmt()), "Updated CGST should be 18.00");

			invoice.load(trxName);
			assertEquals(0, new BigDecimal("345.00").compareTo(invoice.getGrandTotal()),
							"Grand Total after update should be 300 + 27 + 18 = 345.00");
		}
		finally
		{
			rollback();
			if (implementationCharge != null)
				implementationCharge.deleteEx(true, null);
			if (cgstTax != null)
				cgstTax.deleteEx(true, null);
			if (sgstTax != null)
				sgstTax.deleteEx(true, null);
			if (sgstCgstSummaryTax != null)
				sgstCgstSummaryTax.deleteEx(true, null);
			if (taxCategory != null)
				taxCategory.deleteEx(true, null);
			CacheMgt.get().reset();
		}
	}

	/**
	 * Verifies summary-tax splitting and line-update recalculation on a sales order
	 * ({@code StandardTaxProvider.calculateOrderTaxTotal}).
	 * <p>
	 * Confirms {@code GST/PST 12%} splits into {@code GST 5%} and {@code PST 7%}
	 * {@link org.compiere.model.MOrderTax}
	 * rows, deletes the summary tax row, and recalculates cleanly from {@code 100.00}
	 * ({@code 112.00})
	 * to {@code 200.00} ({@code 224.00}) on re-prepare.
	 */
	@Test
	public void testOrderSummaryTaxUpdateAfterPrepare()
	{
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		String uniqueSuffix = "_" + System.currentTimeMillis();

		String setupTrxName = Trx.createTrxName("TaxSetup5117_Order");
		Trx setupTrx = Trx.get(setupTrxName, true);

		MTaxCategory taxCategory = null;
		MTax summaryTax = null;
		MTax gstTax = null;
		MTax pstTax = null;
		MCharge consultingCharge = null;

		try
		{
			taxCategory = new MTaxCategory(Env.getCtx(), 0, setupTrxName);
			taxCategory.setName("Order GST/PST Category" + uniqueSuffix);
			taxCategory.saveEx();

			summaryTax = new MTax(Env.getCtx(), 0, setupTrxName);
			summaryTax.setName("Order GST/PST 12%" + uniqueSuffix);
			summaryTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			summaryTax.setValidFrom(today);
			summaryTax.setIsSummary(true);
			summaryTax.setRate(BigDecimal.ZERO);
			summaryTax.setSOPOType(MTax.SOPOTYPE_Both);
			summaryTax.saveEx();

			gstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			gstTax.setName("Order GST 5%" + uniqueSuffix);
			gstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			gstTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			gstTax.setValidFrom(today);
			gstTax.setIsSummary(false);
			gstTax.setRate(new BigDecimal("5"));
			gstTax.setSOPOType(MTax.SOPOTYPE_Both);
			gstTax.saveEx();

			pstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			pstTax.setName("Order PST 7%" + uniqueSuffix);
			pstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			pstTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			pstTax.setValidFrom(today);
			pstTax.setIsSummary(false);
			pstTax.setRate(new BigDecimal("7"));
			pstTax.setSOPOType(MTax.SOPOTYPE_Both);
			pstTax.saveEx();

			consultingCharge = new MCharge(Env.getCtx(), 0, setupTrxName);
			consultingCharge.setName("Order Consulting Service Fee" + uniqueSuffix);
			consultingCharge.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			consultingCharge.setChargeAmt(new BigDecimal("100.00"));
			consultingCharge.saveEx();

			setupTrx.commit(true);
		}
		catch (Exception e)
		{
			setupTrx.rollback();
			throw new RuntimeException(e);
		}
		finally
		{
			setupTrx.close();
		}

		try
		{
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MOrder order = new MOrder(Env.getCtx(), 0, trxName);
			order.setBPartner(bpartner);
			order.setC_DocTypeTarget_ID(MDocType.DOCSUBTYPESO_StandardOrder);
			order.setIsSOTrx(true);
			order.saveEx();

			MOrderLine line = new MOrderLine(order);
			line.setC_Charge_ID(consultingCharge.getC_Charge_ID());
			line.setQty(BigDecimal.ONE);
			line.setPrice(new BigDecimal("100.00"));
			line.setC_Tax_ID(summaryTax.getC_Tax_ID());
			line.saveEx();

			assertTrue(order.processIt(DocAction.ACTION_Prepare), "Order prepare should succeed: " + order.getProcessMsg());
			order.saveEx();

			MOrderTax[] taxesAfterPrepare = order.getTaxes(true);
			assertEquals(2, taxesAfterPrepare.length, "Summary tax should split into 2 child order tax lines");
			assertNull(new org.compiere.model.Query(Env.getCtx(), MOrderTax.Table_Name,
							"C_Order_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(order.getC_Order_ID(), summaryTax.getC_Tax_ID())
											.firstOnly(), "Summary tax record should be deleted after prepare");

			MOrderTax gstLine = new org.compiere.model.Query(Env.getCtx(), MOrderTax.Table_Name,
							"C_Order_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(order.getC_Order_ID(), gstTax.getC_Tax_ID())
											.firstOnly();
			MOrderTax pstLine = new org.compiere.model.Query(Env.getCtx(), MOrderTax.Table_Name,
							"C_Order_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(order.getC_Order_ID(), pstTax.getC_Tax_ID())
											.firstOnly();
			assertNotNull(gstLine, "GST 5% child order tax line should exist");
			assertNotNull(pstLine, "PST 7% child order tax line should exist");
			assertEquals(0, new BigDecimal("5.00").compareTo(gstLine.getTaxAmt()), "GST 5% should be 5.00");
			assertEquals(0, new BigDecimal("7.00").compareTo(pstLine.getTaxAmt()), "PST 7% should be 7.00");

			order.load(trxName);
			assertEquals(0, new BigDecimal("112.00").compareTo(order.getGrandTotal()),
							"Grand Total after prepare should be 100 + 5 + 7 = 112.00");

			// Update line price (100.00 -> 200.00) and re-prepare
			line.setPrice(new BigDecimal("200.00"));
			line.saveEx();

			assertTrue(order.processIt(DocAction.ACTION_Prepare), "Order re-prepare should succeed: " + order.getProcessMsg());
			order.saveEx();

			assertEquals(2, order.getTaxes(true).length, "Should still have only 2 child order tax lines after update");
			assertNull(new org.compiere.model.Query(Env.getCtx(), MOrderTax.Table_Name,
							"C_Order_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(order.getC_Order_ID(), summaryTax.getC_Tax_ID())
											.firstOnly(), "Summary tax record must not reappear");

			gstLine = new org.compiere.model.Query(Env.getCtx(), MOrderTax.Table_Name,
							"C_Order_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(order.getC_Order_ID(), gstTax.getC_Tax_ID())
											.firstOnly();
			pstLine = new org.compiere.model.Query(Env.getCtx(), MOrderTax.Table_Name,
							"C_Order_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(order.getC_Order_ID(), pstTax.getC_Tax_ID())
											.firstOnly();
			assertEquals(0, new BigDecimal("10.00").compareTo(gstLine.getTaxAmt()), "Updated GST 5% should be 10.00");
			assertEquals(0, new BigDecimal("14.00").compareTo(pstLine.getTaxAmt()), "Updated PST 7% should be 14.00");

			order.load(trxName);
			assertEquals(0, new BigDecimal("224.00").compareTo(order.getGrandTotal()),
							"Grand Total after update should be 200 + 10 + 14 = 224.00");
		}
		finally
		{
			rollback();
			if (consultingCharge != null)
				consultingCharge.deleteEx(true, null);
			if (pstTax != null)
				pstTax.deleteEx(true, null);
			if (gstTax != null)
				gstTax.deleteEx(true, null);
			if (summaryTax != null)
				summaryTax.deleteEx(true, null);
			if (taxCategory != null)
				taxCategory.deleteEx(true, null);
			CacheMgt.get().reset();
		}
	}

	/**
	 * Verifies summary-tax splitting and line-update recalculation on a customer RMA
	 * ({@code StandardTaxProvider.calculateRMATaxTotal}).
	 * <p>
	 * Creates a completed order and customer shipment, prepares an RMA using {@code GST/PST 12%},
	 * and verifies child {@link org.compiere.model.MRMATax} rows ({@code GST 5%}, {@code PST 7%})
	 * and
	 * {@code Amt} update without duplicate tax lines on re-prepare.
	 */
	@Test
	public void testRMASummaryTaxUpdateAfterPrepare()
	{
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		String uniqueSuffix = "_" + System.currentTimeMillis();

		String setupTrxName = Trx.createTrxName("TaxSetup5117_RMA");
		Trx setupTrx = Trx.get(setupTrxName, true);

		MTaxCategory taxCategory = null;
		MTax summaryTax = null;
		MTax gstTax = null;
		MTax pstTax = null;

		try
		{
			taxCategory = new MTaxCategory(Env.getCtx(), 0, setupTrxName);
			taxCategory.setName("RMA GST/PST Category" + uniqueSuffix);
			taxCategory.saveEx();

			summaryTax = new MTax(Env.getCtx(), 0, setupTrxName);
			summaryTax.setName("RMA GST/PST 12%" + uniqueSuffix);
			summaryTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			summaryTax.setValidFrom(today);
			summaryTax.setIsSummary(true);
			summaryTax.setRate(BigDecimal.ZERO);
			summaryTax.setSOPOType(MTax.SOPOTYPE_Both);
			summaryTax.saveEx();

			gstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			gstTax.setName("RMA GST 5%" + uniqueSuffix);
			gstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			gstTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			gstTax.setValidFrom(today);
			gstTax.setIsSummary(false);
			gstTax.setRate(new BigDecimal("5"));
			gstTax.setSOPOType(MTax.SOPOTYPE_Both);
			gstTax.saveEx();

			pstTax = new MTax(Env.getCtx(), 0, setupTrxName);
			pstTax.setName("RMA PST 7%" + uniqueSuffix);
			pstTax.setC_TaxCategory_ID(taxCategory.getC_TaxCategory_ID());
			pstTax.setParent_Tax_ID(summaryTax.getC_Tax_ID());
			pstTax.setValidFrom(today);
			pstTax.setIsSummary(false);
			pstTax.setRate(new BigDecimal("7"));
			pstTax.setSOPOType(MTax.SOPOTYPE_Both);
			pstTax.saveEx();

			setupTrx.commit(true);
		}
		catch (Exception e)
		{
			setupTrx.rollback();
			throw new RuntimeException(e);
		}
		finally
		{
			setupTrx.close();
		}

		try
		{
			MBPartner bpartner = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);

			// 1. Create and complete a Sales Order so MInOutLine has a valid C_OrderLine_ID
			MOrder order = new MOrder(Env.getCtx(), 0, trxName);
			order.setBPartner(bpartner);
			order.setC_DocTypeTarget_ID(MDocType.DOCSUBTYPESO_StandardOrder);
			order.setIsSOTrx(true);
			order.saveEx();

			MOrderLine orderLine = new MOrderLine(order);
			orderLine.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
			orderLine.setQty(new BigDecimal("5"));
			orderLine.setPrice(new BigDecimal("100.00"));
			orderLine.setC_Tax_ID(summaryTax.getC_Tax_ID());
			orderLine.saveEx();

			assertTrue(order.processIt(DocAction.ACTION_Complete),
							"Order complete should succeed: " + order.getProcessMsg());
			order.saveEx();

			// 2. Create and complete Customer Shipment linked to the Order
			MInOut shipment = new MInOut(Env.getCtx(), 0, trxName);
			shipment.setBPartner(bpartner);
			shipment.setC_BPartner_Location_ID(bpartner.getPrimaryC_BPartner_Location_ID());
			shipment.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			shipment.setC_Order_ID(order.getC_Order_ID());
			shipment.setC_DocType_ID(DictionaryIDs.C_DocType.MM_SHIPMENT.id);
			shipment.setMovementType(MInOut.MOVEMENTTYPE_CustomerShipment);
			shipment.setIsSOTrx(true);
			shipment.saveEx();

			MInOutLine shipmentLine = new MInOutLine(shipment);
			shipmentLine.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
			shipmentLine.setC_OrderLine_ID(orderLine.getC_OrderLine_ID());
			shipmentLine.setQty(new BigDecimal("5"));
			shipmentLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			shipmentLine.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			shipmentLine.saveEx();

			assertTrue(shipment.processIt(DocAction.ACTION_Complete),
							"Shipment complete should succeed: " + shipment.getProcessMsg());
			shipment.saveEx();

			// 3. Create RMA and RMA Line referencing the completed Shipment Line
			MRMA rma = new MRMA(Env.getCtx(), 0, trxName);
			rma.setAD_Org_ID(shipment.getAD_Org_ID());
			rma.setName("Test RMA 5117" + uniqueSuffix);
			rma.setC_BPartner_ID(bpartner.getC_BPartner_ID());
			rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
			rma.setInOut_ID(shipment.getM_InOut_ID());
			rma.setSalesRep_ID(Env.getAD_User_ID(Env.getCtx()));
			rma.setIsSOTrx(true);
			rma.saveEx();

			MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, trxName);
			rmaLine.setAD_Org_ID(rma.getAD_Org_ID());
			rmaLine.setM_RMA_ID(rma.getM_RMA_ID());
			rmaLine.setM_InOutLine_ID(shipmentLine.getM_InOutLine_ID());
			rmaLine.setQty(BigDecimal.ONE);
			rmaLine.setAmt(new BigDecimal("100.00"));
			rmaLine.setC_Tax_ID(summaryTax.getC_Tax_ID());
			rmaLine.saveEx();
			assertTrue(rma.processIt(DocAction.ACTION_Prepare), "RMA prepare should succeed: " + rma.getProcessMsg());
			rma.saveEx();

			org.compiere.model.MRMATax[] taxesAfterPrepare = rma.getTaxes(true);
			assertEquals(2, taxesAfterPrepare.length, "Summary tax should split into 2 child RMA tax lines");
			assertNull(new org.compiere.model.Query(Env.getCtx(), org.compiere.model.MRMATax.Table_Name,
							"M_RMA_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(rma.getM_RMA_ID(), summaryTax.getC_Tax_ID())
											.firstOnly(), "Summary tax record should be deleted after prepare");

			org.compiere.model.MRMATax gstLine = new org.compiere.model.Query(Env.getCtx(), org.compiere.model.MRMATax.Table_Name,
							"M_RMA_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(rma.getM_RMA_ID(), gstTax.getC_Tax_ID())
											.firstOnly();
			org.compiere.model.MRMATax pstLine = new org.compiere.model.Query(Env.getCtx(), org.compiere.model.MRMATax.Table_Name,
							"M_RMA_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(rma.getM_RMA_ID(), pstTax.getC_Tax_ID())
											.firstOnly();
			assertNotNull(gstLine, "GST 5% child RMA tax line should exist");
			assertNotNull(pstLine, "PST 7% child RMA tax line should exist");
			assertEquals(0, new BigDecimal("5.00").compareTo(gstLine.getTaxAmt()), "GST 5% should be 5.00");
			assertEquals(0, new BigDecimal("7.00").compareTo(pstLine.getTaxAmt()), "PST 7% should be 7.00");

			rma.load(trxName);
			assertEquals(0, new BigDecimal("112.00").compareTo(rma.getAmt()),
							"RMA Amt after prepare should be 100 + 5 + 7 = 112.00");

			// Update RMA line amount (100.00 -> 200.00) and re-prepare
			rmaLine.setQty(new BigDecimal("2"));
			rmaLine.saveEx();

			rma.getLines(true); // refresh cached MRMALine objects from trxName
			assertTrue(rma.processIt(DocAction.ACTION_Prepare), "RMA re-prepare should succeed: " + rma.getProcessMsg());
			rma.saveEx();

			assertEquals(2, rma.getTaxes(true).length, "Should still have only 2 child RMA tax lines after update");
			assertNull(new org.compiere.model.Query(Env.getCtx(), org.compiere.model.MRMATax.Table_Name,
							"M_RMA_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(rma.getM_RMA_ID(), summaryTax.getC_Tax_ID())
											.firstOnly(), "Summary tax record must not reappear");

			gstLine = new org.compiere.model.Query(Env.getCtx(), org.compiere.model.MRMATax.Table_Name,
							"M_RMA_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(rma.getM_RMA_ID(), gstTax.getC_Tax_ID())
											.firstOnly();
			pstLine = new org.compiere.model.Query(Env.getCtx(), org.compiere.model.MRMATax.Table_Name,
							"M_RMA_ID=? AND C_Tax_ID=?", trxName)
											.setParameters(rma.getM_RMA_ID(), pstTax.getC_Tax_ID())
											.firstOnly();
			assertEquals(0, new BigDecimal("10.00").compareTo(gstLine.getTaxAmt()), "Updated GST 5% should be 10.00");
			assertEquals(0, new BigDecimal("14.00").compareTo(pstLine.getTaxAmt()), "Updated PST 7% should be 14.00");

			rma.load(trxName);
			assertEquals(0, new BigDecimal("224.00").compareTo(rma.getAmt()),
							"RMA Amt after update should be 200 + 10 + 14 = 224.00");
		}
		finally
		{
			rollback();
			if (pstTax != null)
				pstTax.deleteEx(true, null);
			if (gstTax != null)
				gstTax.deleteEx(true, null);
			if (summaryTax != null)
				summaryTax.deleteEx(true, null);
			if (taxCategory != null)
				taxCategory.deleteEx(true, null);
			CacheMgt.get().reset();
		}
	}
}
