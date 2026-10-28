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
 * - Contributors                                                      *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.DocActionDelegate;
import org.adempiere.model.DocActionDelegate.ActionStage;
import org.compiere.model.MInOut;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MMovement;
import org.compiere.model.MPeriod;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for the action steps of {@link DocActionDelegate} and for the contract that
 * {@link MInOut}, {@link MMovement} and {@link MInventory} keep with sub classes when using it.
 */
public class DocActionDelegateTest extends AbstractTestCase {

	private static final Timestamp DOC_DATE = TimeUtil.getDay(System.currentTimeMillis());

	/** Delegate without the period and document number logic, which need a saved document */
	private static class TestDelegate extends DocActionDelegate<MInventory> {
		TestDelegate(MInventory inventory) {
			super(inventory);
		}

		@Override
		protected void testPeriodOpen() {
		}

		@Override
		protected void setDefiniteDocumentNo() {
		}
	}

	private MInventory createInventory() {
		MInventory inventory = new MInventory(Env.getCtx(), 0, getTrxName());
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.setMovementDate(DOC_DATE);
		inventory.setDocAction(DocAction.ACTION_Complete);
		return inventory;
	}

	@Test
	public void testStepsRunInStageAndAddOrder() {
		List<String> calls = new ArrayList<>();
		TestDelegate delegate = new TestDelegate(createInventory());
		delegate.setActionCallable(DocAction.ACTION_Complete, () -> {
			calls.add("callable");
			return null;
		});
		for (ActionStage stage : List.of(ActionStage.COMPLETE_AFTER_VALIDATION, ActionStage.COMPLETE_MAIN,
				ActionStage.COMPLETE_BEFORE_APPROVAL, ActionStage.PREPARE_AFTER_VALIDATION, ActionStage.PREPARE_MAIN)) {
			delegate.addActionStep(stage, () -> {
				calls.add(stage + "1");
				return null;
			});
			delegate.addActionStep(stage, () -> {
				calls.add(stage + "2");
				return null;
			});
		}

		assertEquals(DocAction.STATUS_Completed, delegate.completeIt());
		assertEquals(List.of("PREPARE_MAIN1", "PREPARE_MAIN2",
				"PREPARE_AFTER_VALIDATION1", "PREPARE_AFTER_VALIDATION2",
				"COMPLETE_BEFORE_APPROVAL1", "COMPLETE_BEFORE_APPROVAL2",
				"callable",
				"COMPLETE_MAIN1", "COMPLETE_MAIN2",
				"COMPLETE_AFTER_VALIDATION1", "COMPLETE_AFTER_VALIDATION2"), calls);
	}

	@Test
	public void testStepStatusEndsAction() {
		MInventory inventory = createInventory();
		List<String> calls = new ArrayList<>();
		TestDelegate delegate = new TestDelegate(inventory);
		delegate.addActionStep(ActionStage.COMPLETE_BEFORE_APPROVAL, () -> DocAction.STATUS_InProgress);
		delegate.addActionStep(ActionStage.COMPLETE_BEFORE_APPROVAL, () -> {
			calls.add("next step");
			return null;
		});
		delegate.addActionStep(ActionStage.COMPLETE_MAIN, () -> {
			calls.add("main");
			return null;
		});

		assertEquals(DocAction.STATUS_InProgress, delegate.completeIt());
		assertTrue(calls.isEmpty(), "Steps after the one that returned a status must not run: " + calls);
		assertFalse(inventory.isApproved(), "Document must not be approved before the step that stopped it");
		assertFalse(inventory.isProcessed());
	}

	@Test
	public void testStepRuntimeExceptionIsNotWrapped() {
		AdempiereException expected = new AdempiereException("step error");
		TestDelegate delegate = new TestDelegate(createInventory());
		delegate.addActionStep(ActionStage.PREPARE_MAIN, () -> {
			throw expected;
		});

		assertSame(expected, assertThrows(AdempiereException.class, delegate::prepareIt));
	}

	@Test
	public void testActionCallableMessageIsInvalid() {
		TestDelegate delegate = new TestDelegate(createInventory());
		delegate.setActionCallable(DocAction.ACTION_Prepare, () -> "callable error");

		assertEquals(DocAction.STATUS_Invalid, delegate.prepareIt());
		assertEquals("callable error", delegate.getProcessMsg());
	}

	/** Plugin style sub class, using the extension points of MInventory */
	private static class PluginInventory extends MInventory {
		private static final long serialVersionUID = 1L;

		/** Null while the constructor of MInventory calls the overridden methods */
		private List<String> calls;

		PluginInventory(Properties ctx, String trxName) {
			super(ctx, 0, trxName);
			calls = new ArrayList<>();
		}

		/**
		 * Record a call to an overridden method, ignoring the calls made by the constructor of MInventory
		 * @param call
		 */
		private void addCall(String call) {
			if (calls != null)
				calls.add(call);
		}

		@Override
		public String prepareIt() {
			addCall("prepareIt");
			return super.prepareIt();
		}

		@Override
		public boolean approveIt() {
			addCall("approveIt");
			return super.approveIt();
		}

		@Override
		protected void setDefiniteDocumentNo() {
			addCall("setDefiniteDocumentNo");
			super.setDefiniteDocumentNo();
		}

		@Override
		public void setProcessed(boolean processed) {
			addCall("setProcessed");
			super.setProcessed(processed);
		}

		@Override
		public void setDocAction(String docAction) {
			addCall("setDocAction " + docAction);
			super.setDocAction(docAction);
		}
	}

	@Test
	public void testInventorySubClassOverridesAreUsed() {
		PluginInventory inventory = new PluginInventory(Env.getCtx(), getTrxName());
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.setMovementDate(DOC_DATE);
		inventory.saveEx();
		MInventoryLine line = new MInventoryLine(inventory, DictionaryIDs.M_Locator.HQ.id,
				DictionaryIDs.M_Product.AZALEA_BUSH.id, 0, Env.ZERO, Env.ONEHUNDRED);
		line.saveEx();
		inventory.calls.clear();

		assertEquals(DocAction.STATUS_Completed, inventory.completeIt(), inventory.getProcessMsg());

		assertEquals(List.of("prepareIt", "setDefiniteDocumentNo", "approveIt", "setProcessed",
				"setDocAction " + DocAction.ACTION_Close), inventory.calls);
		line.load(getTrxName());
		assertTrue(line.isProcessed(), "setProcessed of MInventory must update the lines");
	}

	/** Plugin style sub class, reading and writing the protected state of MMovement */
	private static class PluginMovement extends MMovement {
		private static final long serialVersionUID = 1L;

		PluginMovement(Properties ctx, String trxName) {
			super(ctx, 0, trxName);
			setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_MOVEMENT.id);
			m_justPrepared = true;
		}

		@Override
		public boolean pendingConfirmations() {
			return true;
		}

		String getProtectedProcessMsg() {
			return m_processMsg;
		}
	}

	@Test
	public void testMovementPendingConfirmationStaysInProgress() {
		PluginMovement movement = new PluginMovement(Env.getCtx(), getTrxName());

		assertEquals(DocAction.STATUS_InProgress, movement.completeIt());
		assertEquals("@Open@: @M_MovementConfirm_ID@", movement.getProcessMsg());
		assertEquals(movement.getProcessMsg(), movement.getProtectedProcessMsg());
		assertFalse(movement.isApproved(), "Pending confirmation must stop the document before the implicit approval");
	}

	/** Plugin style sub class of MInOut, skipping the prepare and with a pending confirmation */
	private static class PluginInOut extends MInOut {
		private static final long serialVersionUID = 1L;

		PluginInOut(Properties ctx, String trxName) {
			super(ctx, 0, trxName);
			setC_DocType_ID(DictionaryIDs.C_DocType.MM_RECEIPT.id);
			setDateAcct(DOC_DATE);
			setMovementDate(DOC_DATE);
			m_justPrepared = true;
		}

		@Override
		public boolean pendingCustomerConfirmations() {
			return true;
		}
	}

	@Test
	public void testInOutPendingConfirmationStaysInProgress() {
		PluginInOut inOut = new PluginInOut(Env.getCtx(), getTrxName());

		assertEquals(DocAction.STATUS_InProgress, inOut.completeIt());
		assertEquals("@Open@: @M_InOutConfirm_ID@", inOut.getProcessMsg());
		assertFalse(inOut.isApproved(), "Pending confirmation must stop the document before the implicit approval");
	}

	@Test
	public void testInOutPrepareChecksAndMessages() {
		PluginInOut inOut = new PluginInOut(Env.getCtx(), getTrxName());
		try (MockedStatic<MPeriod> period = Mockito.mockStatic(MPeriod.class, Mockito.CALLS_REAL_METHODS)) {
			period.when(() -> MPeriod.isOpen(ArgumentMatchers.any(), ArgumentMatchers.any(), ArgumentMatchers.anyString(),
					ArgumentMatchers.anyInt())).thenReturn(false);

			assertEquals(DocAction.STATUS_Invalid, inOut.prepareIt(), "Closed period is a status, not an exception");
			assertEquals("@PeriodClosed@", inOut.getProcessMsg());

			inOut.setC_Order_ID(1);
			inOut.setM_RMA_ID(1);
			assertEquals(DocAction.STATUS_Invalid, inOut.prepareIt());
			assertEquals("@OrderOrRMA@", inOut.getProcessMsg(), "Order or RMA is checked before the period");
		}
	}
}
