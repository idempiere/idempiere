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
package org.idempiere.test.event;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.adempiere.base.Core;
import org.adempiere.base.DefaultAnnotationBasedEventManager;
import org.compiere.model.MAcctSchema;
import org.adempiere.base.event.annotations.BaseEventHandler;
import org.compiere.acct.Doc;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProcess;
import org.compiere.model.MTest;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.osgi.service.event.EventHandler;

/**
 * @author hengsin
 */
@Isolated
public class EventDelegateAnnotationTest extends AbstractTestCase {

	public EventDelegateAnnotationTest() {
	}

	@Test
	public void testAnnotatedEventDelegate() {
		DefaultAnnotationBasedEventManager mgr = Core.getDefaultAnnotationBasedEventManager();
		CompletableFuture<List<EventHandler>> completable = mgr.scan(TestActivator.context, MTestEventDelegate.class.getPackageName());
		completable.join();
		
		// 1. Standard Cycle
		MTestEventDelegate.eventLog.clear();
		String desc = "test";
		MTest mtest = new MTest(Env.getCtx(), 0, getTrxName());
		mtest.setName("testAnnotatedEventDelegate");
		mtest.setDescription(desc);
		mtest.saveEx();
		
		assertEquals(desc + "MTestEventDelegate", mtest.getDescription(), "MTestEventDelegate not handling before new event as expected");
		assertTrue(MTestEventDelegate.eventLog.contains("BeforeNew"));
		assertTrue(MTestEventDelegate.eventLog.contains("AfterNew"));
		assertTrue(MTestEventDelegate.eventLog.contains("PostCreate"));
		
		MTestEventDelegate.eventLog.clear();
		mtest.setDescription("test update");
		mtest.saveEx();
		assertTrue(MTestEventDelegate.eventLog.contains("BeforeChange"));
		assertTrue(MTestEventDelegate.eventLog.contains("AfterChange"));
		assertTrue(MTestEventDelegate.eventLog.contains("PostUpdate"));
		
		MTestEventDelegate.eventLog.clear();
		mtest.deleteEx(true);
		assertTrue(MTestEventDelegate.eventLog.contains("BeforeDelete"));
		assertTrue(MTestEventDelegate.eventLog.contains("AfterDelete"));
		assertTrue(MTestEventDelegate.eventLog.contains("PostDelete"));

		// 2. Replication Cycle
		// Create
		MTestEventDelegate.eventLog.clear();
		MTest mtestRepl = new MTest(Env.getCtx(), 0, getTrxName());
		mtestRepl.setName("testReplication");
		mtestRepl.setDescription("test replication");
		mtestRepl.setReplication(true);
		mtestRepl.saveEx();
		
		assertTrue(MTestEventDelegate.eventLog.contains("BeforeNew"));
		assertTrue(MTestEventDelegate.eventLog.contains("AfterNewReplication"));
		assertFalse(MTestEventDelegate.eventLog.contains("AfterNew")); // Should use replication variant
		assertTrue(MTestEventDelegate.eventLog.contains("PostCreate"));

		// Update
		MTestEventDelegate.eventLog.clear();
		mtestRepl.setDescription("test replication update");
		mtestRepl.setReplication(true);
		mtestRepl.saveEx();
		
		assertTrue(MTestEventDelegate.eventLog.contains("BeforeChange"));
		assertTrue(MTestEventDelegate.eventLog.contains("AfterChangeReplication"));
		assertFalse(MTestEventDelegate.eventLog.contains("AfterChange")); // Should use replication variant
		assertTrue(MTestEventDelegate.eventLog.contains("PostUpdate"));

		// Delete
		MTestEventDelegate.eventLog.clear();
		mtestRepl.setReplication(true);
		mtestRepl.deleteEx(true);
		
		assertTrue(MTestEventDelegate.eventLog.contains("BeforeDeleteReplication"));
		assertFalse(MTestEventDelegate.eventLog.contains("BeforeDelete")); // BeforeDeleteReplication replaces BeforeDelete
		assertTrue(MTestEventDelegate.eventLog.contains("AfterDelete")); // AfterDelete is always called (no replication variant for AfterDelete)
		assertTrue(MTestEventDelegate.eventLog.contains("PostDelete"));
		
	}

	@Test
	public void testDocumentEventDelegate() {
		DefaultAnnotationBasedEventManager mgr = Core.getDefaultAnnotationBasedEventManager();
		CompletableFuture<List<EventHandler>> completable = mgr.scan(TestActivator.context, MOrderEventDelegate.class.getPackageName());
		completable.join();
		
		MOrderEventDelegate.eventLog.clear();
		// Create Order
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setIsSOTrx(true);
		order.setC_DocTypeTarget_ID();
		// set mandatory fields
		order.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id);
		order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		order.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
		order.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
		order.saveEx();

		MOrderLine line = new MOrderLine(order);
		line.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		line.setQty(Env.ONE);
		line.saveEx();
		
		// Prepare
		String status = order.prepareIt();
		assertEquals(DocAction.STATUS_InProgress, status, "Order should be in progress");
		assertTrue(MOrderEventDelegate.eventLog.contains("BeforePrepare"));
		assertTrue(MOrderEventDelegate.eventLog.contains("AfterPrepare"));
		
		// Complete
		MOrderEventDelegate.eventLog.clear();
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();
		status = order.completeIt();
		assertEquals(DocAction.STATUS_Completed, status, "Order should be completed");
		assertTrue(MOrderEventDelegate.eventLog.contains("BeforeComplete"));
		assertTrue(MOrderEventDelegate.eventLog.contains("AfterComplete"));
		
		// Re-activate
		MOrderEventDelegate.eventLog.clear();
		boolean ok = order.reActivateIt();
		assertTrue(ok, "Order should be reactivated");
		assertTrue(MOrderEventDelegate.eventLog.contains("BeforeReactivate"));
		assertTrue(MOrderEventDelegate.eventLog.contains("AfterReactivate"));

		// Void (from prepared/invalid/draft)
		MOrderEventDelegate.eventLog.clear();
		ok = order.voidIt();
		assertTrue(ok, "Order should be voided");
		assertTrue(MOrderEventDelegate.eventLog.contains("BeforeVoid"));
		assertTrue(MOrderEventDelegate.eventLog.contains("AfterVoid"));
		
		// Close (from Voided/Completed etc)
		MOrder order2 = MOrder.copyFrom(order, new java.sql.Timestamp(System.currentTimeMillis()), order.getC_DocTypeTarget_ID(), true, false, false, getTrxName());
		order2.saveEx();
		// skip prepare check, just complete
		order2.prepareIt();
		order2.completeIt();
		
		MOrderEventDelegate.eventLog.clear();
		ok = order2.closeIt();
		assertTrue(ok, "Order should be closed");
		assertTrue(MOrderEventDelegate.eventLog.contains("BeforeClose"));
		assertTrue(MOrderEventDelegate.eventLog.contains("AfterClose"));

		// Reverse Correct (requires Completed)
		MOrder order3 = MOrder.copyFrom(order, new java.sql.Timestamp(System.currentTimeMillis()), order.getC_DocTypeTarget_ID(), true, false, false, getTrxName());
		order3.saveEx();
		order3.prepareIt();
		order3.completeIt();
		
		MOrderEventDelegate.eventLog.clear();
		ok = order3.reverseCorrectIt();
		assertTrue(ok, "Order should have been reversed");
		assertTrue(MOrderEventDelegate.eventLog.contains("BeforeReverseCorrect"));
		assertTrue(MOrderEventDelegate.eventLog.contains("AfterReverseCorrect"));
		
		// Reverse Accrual (requires Completed)
		MInvoiceEventDelegate.eventLog.clear();
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setIsSOTrx(true);
		invoice.setC_DocTypeTarget_ID(MInvoice.DOCBASETYPE_ARInvoice);
		invoice.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id);
		invoice.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
		invoice.saveEx();
		
		MInvoiceLine iLine = new MInvoiceLine(invoice);
		iLine.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		iLine.setQty(Env.ONE);
		iLine.setLineNetAmt(Env.ONE);
		iLine.saveEx();
		
		invoice.prepareIt();
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		status = invoice.completeIt();
		assertEquals(DocAction.STATUS_Completed, status, "Invoice should be completed");
		
		MInvoiceEventDelegate.eventLog.clear();
		ok = invoice.reverseAccrualIt();
		assertTrue(ok, "Invoice should have been reversed");
		assertTrue(MInvoiceEventDelegate.eventLog.contains("BeforeReverseAccrual"));
		assertTrue(MInvoiceEventDelegate.eventLog.contains("AfterReverseAccrual"));

		// Facts Validate (requires Posted)
		MInvoice invoice2 = MInvoice.copyFrom(invoice, invoice.getDateAcct(), invoice.getDateAcct(), invoice.getC_DocTypeTarget_ID(), true, false, getTrxName(), true);
		invoice2.setDocAction(DocAction.ACTION_Complete);
		invoice2.saveEx();
		status = invoice2.completeIt();
		invoice2.setDocStatus(status);
		invoice2.saveEx();
		assertEquals(DocAction.STATUS_Completed, status, "Invoice should be completed");

		MInvoiceEventDelegate.eventLog.clear();
		MAcctSchema as = MAcctSchema.get(Env.getCtx(), Env.getContextAsInt(Env.getCtx(), "$C_AcctSchema_ID"));
		String error = Doc.postImmediate(new MAcctSchema[] {as}, MInvoice.Table_ID, invoice2.get_ID(), true, getTrxName());
		assertEquals(null, error, "Invoice should be posted: " + error);
		assertTrue(MInvoiceEventDelegate.eventLog.contains("FactsValidate"));

		// clean up
		EventHandler[] handlers = mgr.getHandlers();
		for (EventHandler handler : handlers) {
			if (handler instanceof BaseEventHandler beh) {
				if (beh.getDelegateClass().getName().startsWith("org.idempiere.test.event")) {
					mgr.removeHandler(handler);
				}
			}
		}
	}

	@Test
	public void testProcessEventDelegate() {
		DefaultAnnotationBasedEventManager mgr = Core.getDefaultAnnotationBasedEventManager();
		CompletableFuture<List<EventHandler>> future = mgr.scan(TestActivator.context, "org.idempiere.test.event");
		future.join();

		MProcess process = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.CACHE_RESET.id);
		ProcessInfo pi = new ProcessInfo("Cache Reset", DictionaryIDs.AD_Process.CACHE_RESET.id);
		pi.setAD_Client_ID(GARDEN_WORLD_CLIENT);
		pi.setAD_User_ID(GARDEN_WORLD_ADMIN_USER);
		pi.setAD_Process_UU(process.getAD_Process_UU());

		CacheResetProcessEventDelegate.eventLog.clear();
		ServerProcessCtl.process(pi, null);
		assertTrue(!pi.isError(), "Process should have succeeded");
		assertTrue(CacheResetProcessEventDelegate.eventLog.contains("BeforeProcess"));
		assertTrue(CacheResetProcessEventDelegate.eventLog.contains("AfterProcess"));
		assertTrue(CacheResetProcessEventDelegate.eventLog.contains("PostProcess"));

		// clean up
		EventHandler[] handlers = mgr.getHandlers();
		for (EventHandler handler : handlers) {
			if (handler instanceof BaseEventHandler beh) {
				if (beh.getDelegateClass().getName().startsWith("org.idempiere.test.event")) {
					mgr.removeHandler(handler);
				}
			}
		}
	}
}
