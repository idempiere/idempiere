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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.idempiere.test.dunning;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MDunning;
import org.compiere.model.MDunningLevel;
import org.compiere.model.MDunningRun;
import org.compiere.model.MDunningRunEntry;
import org.compiere.model.MDunningRunLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
*
* @author Carlos Ruiz - globalqss - bxservice
*
*/
public class DunningRunTest extends AbstractTestCase {

	private static final int PROCESS_DUNNING_RUN_CREATE = 289;

	/**
	 * 
	 */
	public DunningRunTest() {
	}

	@Test
	public void testDunning10DaysDue() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		MDunningLevel dl = new MDunningLevel(ctx, DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id, trxName);
		// change to due invoices after 10 days due
		dl.setDaysAfterDue(BigDecimal.valueOf(10.0));
		dl.setIsShowAllDue(false);
		dl.setName("Dun all due invoices after 10 days due");
		dl.saveEx();

		// create an invoice for GardenUser
		MInvoice invoice = new MInvoice(ctx, 0, trxName);
		invoice.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		invoice.setDateInvoiced(TimeUtil.addDays(today, -30)); // date 30 days ago
		invoice.setDateAcct(TimeUtil.addDays(today, -30));
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.NET_30_DAYS.id); // payment term 30 days, so the invoice is due exactly today
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
		invoice.saveEx();

		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		line1.setQty(new BigDecimal("7"));
		line1.setPrice(BigDecimal.valueOf(23.75));
		line1.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(trxName);
		assertFalse(info.isError(), "Error processing invoice: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice document status is not completed: " + invoice.getDocStatus());

		// create a dunning run today for the 10 days level
		MDunningRun dr = new MDunningRun(ctx, 0, trxName);
		dr.setDunningDate(today);
		dr.setC_Dunning_ID(DictionaryIDs.C_Dunning.DEFAULT.id);
		dr.setC_DunningLevel_ID(DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id);
		dr.saveEx();

		// Run the process Dunning Run Create
		MProcess process = MProcess.get(PROCESS_DUNNING_RUN_CREATE);
		MPInstance pinstance = new MPInstance(process, 0, 0, null);
		MPInstancePara[] paras = pinstance.getParameters();
		for (MPInstancePara para : paras) {
			if (para.getParameterName().equals("AD_Org_ID")) {
				para.setP_Number(DictionaryIDs.AD_Org.GLOBAL.id);
				para.saveEx();
			} else if (para.getParameterName().equals("IncludeInDispute")) {
				para.setP_String("N");
				para.saveEx();
			} else if (para.getParameterName().equals("OnlySOTrx")) {
				para.setP_String("Y");
				para.saveEx();
			} else if (para.getParameterName().equals("SalesRep_ID")) {
				para.setP_Number(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
				para.saveEx();
			} else if (para.getParameterName().equals("C_Currency_ID")) {
				para.setP_Number(DictionaryIDs.C_Currency.USD.id);
				para.saveEx();
			} else if (para.getParameterName().equals("IsAllCurrencies")) {
				para.setP_String("Y");
				para.saveEx();
			} else if (para.getParameterName().equals("C_BPartner_ID")) {
				para.setP_Number(DictionaryIDs.C_BPartner.C_AND_W.id);
				para.saveEx();
			}
		}
		ProcessInfo pi = new ProcessInfo(process.getName(), PROCESS_DUNNING_RUN_CREATE);
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		pi.setRecord_ID(dr.getC_DunningRun_ID());
		process.processIt(pi, Trx.get(getTrxName(), false), false);
		assertTrue(!pi.isError(), pi.getSummary());

		// The invoice must not be reported in this dunning because the due date is exactly today
		for (MDunningRunEntry dre : dr.getEntries(true)) {
			for (MDunningRunLine drl : dre.getLines()) {
				assertTrue(drl.getC_Invoice_ID() != invoice.getC_Invoice_ID());
			}
		}
	}
	
	/**
	 * Test sequential dunning with independent invoices.
	 * <p>
	 * Scenario: dunning with at least three levels and "create levels sequentially".
	 * Dun one invoice up to the last level, then dun a new independent invoice:
	 * first run must place it in the first level, second run must place it in the
	 * second level - not in the last level just because another invoice was already
	 * dunned at the last level.
	 */
	@Test
	public void testSequentialDunningIndependentInvoices() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		// 1. Create a dunning with three levels and "create levels sequentially"
		MDunning dunning = new MDunning(ctx, 0, trxName);
		dunning.setName("SeqDun_" + System.currentTimeMillis());
		dunning.setCreateLevelsSequentially(true);
		dunning.saveEx();

		MDunningLevel level1 = createDunningLevel(ctx, trxName, dunning.getC_Dunning_ID(), "Level 1", 7);
		MDunningLevel level2 = createDunningLevel(ctx, trxName, dunning.getC_Dunning_ID(), "Level 2", 14);
		MDunningLevel level3 = createDunningLevel(ctx, trxName, dunning.getC_Dunning_ID(), "Level 3", 21);

		// Assign the dunning to the test business partner so that
		// DunningRunCreate picks up its invoices
		MBPartner bp = new MBPartner(ctx, DictionaryIDs.C_BPartner.C_AND_W.id, trxName);
		bp.setC_Dunning_ID(dunning.getC_Dunning_ID());
		bp.saveEx();

		int bpartnerId = bp.getC_BPartner_ID();

		// 2. Create first invoice some days in the past and dun it up to the last level
		MInvoice invoice1 = createCompletedInvoice(ctx, trxName, bpartnerId, TimeUtil.addDays(today, -35));

		MDunningRun runL1 = createAndRunDunning(ctx, trxName, today, dunning.getC_Dunning_ID(),
				level1.getC_DunningLevel_ID(), bpartnerId);
		assertTrue(getInvoiceDunnedLevels(runL1, invoice1.getC_Invoice_ID()).contains(level1.getC_DunningLevel_ID()),
				"Invoice1 should be dunned at level 1 in first run");
		markRunProcessed(runL1);

		MDunningRun runL2 = createAndRunDunning(ctx, trxName, today, dunning.getC_Dunning_ID(),
				level2.getC_DunningLevel_ID(), bpartnerId);
		assertTrue(getInvoiceDunnedLevels(runL2, invoice1.getC_Invoice_ID()).contains(level2.getC_DunningLevel_ID()),
				"Invoice1 should be dunned at level 2 in second run");
		markRunProcessed(runL2);

		MDunningRun runL3 = createAndRunDunning(ctx, trxName, today, dunning.getC_Dunning_ID(),
				level3.getC_DunningLevel_ID(), bpartnerId);
		assertTrue(getInvoiceDunnedLevels(runL3, invoice1.getC_Invoice_ID()).contains(level3.getC_DunningLevel_ID()),
				"Invoice1 should be dunned at last level after three runs");
		markRunProcessed(runL3);

		// 3. Create another invoice some days in the past and let it run in the first dunning
		// Use a whole-dunning run (no level) so levels are assigned by the process
		MInvoice invoice2 = createCompletedInvoice(ctx, trxName, bpartnerId, TimeUtil.addDays(today, -35));

		MDunningRun runFirst = createAndRunDunning(ctx, trxName, today, dunning.getC_Dunning_ID(),
				0, bpartnerId);
		Set<Integer> firstLevels = getInvoiceDunnedLevels(runFirst, invoice2.getC_Invoice_ID());
		assertTrue(firstLevels.contains(level1.getC_DunningLevel_ID()),
				"New invoice should be dunned with the first level on its first dunning run, got levels: " + firstLevels);
		markRunProcessed(runFirst);

		// 4. Let it run again - it should be dunned with the second level, not the last.
		// Wrong behaviour (bug): it ends up in the last level because another unrelated
		// invoice was already dunned at the last level.
		MDunningRun runSecond = createAndRunDunning(ctx, trxName, today, dunning.getC_Dunning_ID(),
				0, bpartnerId);
		Set<Integer> secondLevels = getInvoiceDunnedLevels(runSecond, invoice2.getC_Invoice_ID());
		assertTrue(secondLevels.contains(level2.getC_DunningLevel_ID()),
				"New invoice should be dunned with the second level on its second dunning run, got levels: " + secondLevels);
		assertFalse(secondLevels.contains(level3.getC_DunningLevel_ID()),
				"New invoice must not be dunned with the last level on its second dunning run, got levels: " + secondLevels);
	}

	private MDunningLevel createDunningLevel(Properties ctx, String trxName, int dunningId, String name, int daysAfterDue) {
		MDunningLevel level = new MDunningLevel(ctx, 0, trxName);
		level.setC_Dunning_ID(dunningId);
		level.setName(name + "_" + System.nanoTime());
		level.setPrintName(name);
		level.setDaysAfterDue(BigDecimal.valueOf(daysAfterDue));
		level.setDaysBetweenDunning(0);
		level.setChargeFee(false);
		level.setChargeInterest(false);
		level.setIsShowAllDue(false);
		level.setIsShowNotDue(false);
		level.setIsStatement(false);
		level.setIsSetCreditStop(false);
		level.setIsSetPaymentTerm(false);
		level.saveEx();
		return level;
	}

	private MInvoice createCompletedInvoice(Properties ctx, String trxName, int bpartnerId, Timestamp dateInvoiced) {
		MInvoice invoice = new MInvoice(ctx, 0, trxName);
		invoice.setBPartner(MBPartner.get(ctx, bpartnerId));
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		invoice.setDateInvoiced(dateInvoiced);
		invoice.setDateAcct(dateInvoiced);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
		invoice.saveEx();

		MInvoiceLine line = new MInvoiceLine(invoice);
		line.setLine(10);
		line.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		line.setQty(new BigDecimal("7"));
		line.setPrice(BigDecimal.valueOf(23.75));
		line.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(trxName);
		assertFalse(info.isError(), "Error processing invoice: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), "Invoice document status is not completed: " + invoice.getDocStatus());
		return invoice;
	}

	private MDunningRun createAndRunDunning(Properties ctx, String trxName, Timestamp dunningDate, int dunningId,
			int dunningLevelId, int bpartnerId) {
		MDunningRun dr = new MDunningRun(ctx, 0, trxName);
		dr.setDunningDate(dunningDate);
		dr.setC_Dunning_ID(dunningId);
		if (dunningLevelId > 0)
			dr.setC_DunningLevel_ID(dunningLevelId);
		dr.saveEx();

		// Run the process Dunning Run Create
		MProcess process = MProcess.get(PROCESS_DUNNING_RUN_CREATE);
		MPInstance pinstance = new MPInstance(process, 0, 0, null);
		MPInstancePara[] paras = pinstance.getParameters();
		for (MPInstancePara para : paras) {
			if (para.getParameterName().equals("AD_Org_ID")) {
				para.setP_Number(DictionaryIDs.AD_Org.GLOBAL.id);
				para.saveEx();
			} else if (para.getParameterName().equals("IncludeInDispute")) {
				para.setP_String("N");
				para.saveEx();
			} else if (para.getParameterName().equals("OnlySOTrx")) {
				para.setP_String("Y");
				para.saveEx();
			} else if (para.getParameterName().equals("SalesRep_ID")) {
				para.setP_Number(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
				para.saveEx();
			} else if (para.getParameterName().equals("C_Currency_ID")) {
				para.setP_Number(DictionaryIDs.C_Currency.USD.id);
				para.saveEx();
			} else if (para.getParameterName().equals("IsAllCurrencies")) {
				para.setP_String("Y");
				para.saveEx();
			} else if (para.getParameterName().equals("C_BPartner_ID")) {
				para.setP_Number(bpartnerId);
				para.saveEx();
			}
		}
		ProcessInfo pi = new ProcessInfo(process.getName(), PROCESS_DUNNING_RUN_CREATE);
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		pi.setRecord_ID(dr.getC_DunningRun_ID());
		process.processIt(pi, Trx.get(getTrxName(), false), false);
		assertTrue(!pi.isError(), pi.getSummary());
		return dr;
	}

	private void markRunProcessed(MDunningRun run) {
		for (MDunningRunEntry entry : run.getEntries(true)) {
			entry.setProcessed(true);
			entry.saveEx();
		}
		run.setProcessed(true);
		run.saveEx();
	}

	private Set<Integer> getInvoiceDunnedLevels(MDunningRun run, int invoiceId) {
		Set<Integer> levels = new HashSet<>();
		for (MDunningRunEntry entry : run.getEntries(true)) {
			for (MDunningRunLine line : entry.getLines()) {
				if (line.getC_Invoice_ID() == invoiceId) {
					levels.add(entry.getC_DunningLevel_ID());
				}
			}
		}
		return levels;
	}


	/**
	 * Test that getEntries returns active entries.
	 */
	@Test
	public void testGetEntriesReturnsActiveEntries() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		MDunningRun dr = new MDunningRun(ctx, 0, trxName);
		dr.setDunningDate(today);
		dr.setC_Dunning_ID(DictionaryIDs.C_Dunning.DEFAULT.id);
		dr.setC_DunningLevel_ID(DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id);
		dr.saveEx();

		MDunningRunEntry entry = new MDunningRunEntry(dr);
		entry.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id), true);
		entry.setC_DunningLevel_ID(DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id);
		entry.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		entry.setIsActive(true);
		entry.saveEx();

		MDunningRunEntry[] entries = dr.getEntries(true);
		assertNotNull(entries, "getEntries should not return null");
		assertEquals(1, entries.length, "getEntries should return exactly the one active entry");
		assertEquals(entry.getC_DunningRunEntry_ID(), entries[0].getC_DunningRunEntry_ID(),
				"The returned entry ID should match the created active entry");
	}

	/**
	 * Test that getEntries excludes inactive entries.
	 * After the fix, only active entries should be returned.
	 */
	@Test
	public void testGetEntriesExcludesInactiveEntries() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		MDunningRun dr = new MDunningRun(ctx, 0, trxName);
		dr.setDunningDate(today);
		dr.setC_Dunning_ID(DictionaryIDs.C_Dunning.DEFAULT.id);
		dr.setC_DunningLevel_ID(DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id);
		dr.saveEx();

		// Create an active entry
		MDunningRunEntry activeEntry = new MDunningRunEntry(dr);
		activeEntry.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id), true);
		activeEntry.setC_DunningLevel_ID(DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id);
		activeEntry.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		activeEntry.setIsActive(true);
		activeEntry.saveEx();

		// Create an inactive entry
		MDunningRunEntry inactiveEntry = new MDunningRunEntry(dr);
		inactiveEntry.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id), true);
		inactiveEntry.setC_DunningLevel_ID(DictionaryIDs.C_DunningLevel.DUN_ALL_DUE_INVOICES.id);
		inactiveEntry.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		inactiveEntry.setIsActive(false);
		inactiveEntry.saveEx();

		MDunningRunEntry[] entries = dr.getEntries(true);
		assertNotNull(entries, "getEntries should not return null");
		assertEquals(1, entries.length, "getEntries should return only the active entry, not the inactive one");
		assertEquals(activeEntry.getC_DunningRunEntry_ID(), entries[0].getC_DunningRunEntry_ID(),
				"The returned entry should be the active one");
		for (MDunningRunEntry e : entries) {
			assertTrue(e.isActive(), "All returned entries must be active");
			assertFalse(e.getC_DunningRunEntry_ID() == inactiveEntry.getC_DunningRunEntry_ID(),
					"Inactive entry must not appear in getEntries result");
		}
	}
}
