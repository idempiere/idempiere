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
 **********************************************************************/
package org.idempiere.test.workflow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.util.Properties;

import org.adempiere.base.Core;
import org.adempiere.util.ProcessUtil;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MNote;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.StateEngine;
import org.compiere.process.SvrProcess;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNextCondition;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * A process run by a workflow node must not leave its changes in the transaction when it fails.
 * https://idempiere.atlassian.net/browse/IDEMPIERE-7179
 */
@Isolated
public class WFProcessNodeTest extends AbstractTestCase {

	private static final int LOCATION_FROM_PATIO = 115;
	private static final int WF_PROCESS_SHIPMENT = 117;
	private static final int WF_PROCESS_SHIPMENT_NODE_COMPLETE = 190;
	private static final int COLUMN_M_INOUT_ISSOTRX = 3790;

	private static final String MARKER = "IDEMPIERE-7179";

	public WFProcessNodeTest() {
	}

	@Test
	public void testFailedProcessNodeIsRolledBack() {
		MInOut mr = completeReceiptWithProcessNode(true);
		assertNotEquals(MARKER, mr.getDescription(), "Changes of the failed process node were not rolled back");
	}

	@Test
	public void testSuccessfulProcessNodeIsKept() {
		MInOut mr = completeReceiptWithProcessNode(false);
		assertEquals(MARKER, mr.getDescription(), "Changes of the successful process node were lost");
	}

	@Test
	public void testCommittingProcessNodeCompletes() {
		runProcessNodeThatCommits(false);
	}

	@Test
	public void testCommittingProcessNodeFails() {
		runProcessNodeThatCommits(true);
	}

	/**
	 * Adds a process node after (DocComplete) of Process_Shipment for material receipts,
	 * completes a receipt and returns it reloaded.
	 */
	private MInOut completeReceiptWithProcessNode(boolean fail) {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProcess process = null;
		MWFNode node = null;
		MWFNodeNext transition = null;
		MWFNextCondition condition = null;
		try {
			process = createProcess(ctx, false, fail);

			MWorkflow wf = new MWorkflow(ctx, WF_PROCESS_SHIPMENT, trxName);
			node = new MWFNode(wf, MARKER, MARKER);
			node.setClientOrg(Env.getAD_Client_ID(ctx), 0);
			node.setAction(MWFNode.ACTION_AppsProcess);
			node.setAD_Process_ID(process.getAD_Process_ID());
			node.saveEx();
			MWFNode nodeComplete = new MWFNode(ctx, WF_PROCESS_SHIPMENT_NODE_COMPLETE, trxName);
			transition = new MWFNodeNext(nodeComplete, node.getAD_WF_Node_ID());
			transition.setClientOrg(Env.getAD_Client_ID(ctx), 0);
			transition.setDescription("IsSOTrx=N");
			transition.saveEx();
			// just material receipts
			condition = new MWFNextCondition(ctx, 0, trxName);
			condition.setAD_WF_NodeNext_ID(transition.getAD_WF_NodeNext_ID());
			condition.setOperation(MWFNextCondition.OPERATION_Eq);
			condition.setAD_Column_ID(COLUMN_M_INOUT_ISSOTRX);
			condition.setValue("N");
			condition.setSeqNo(10);
			condition.setAndOr(MWFNextCondition.ANDOR_Or);
			condition.saveEx();

			// the workflow code reads the dictionary outside the test transaction
			commit();
			CacheMgt.get().reset();

			MInOut mr = new MInOut(ctx, 0, trxName);
			mr.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
			mr.setC_BPartner_Location_ID(LOCATION_FROM_PATIO);
			mr.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			mr.setC_DocType_ID(DictionaryIDs.C_DocType.MM_RECEIPT.id);
			mr.setIsSOTrx(false);
			mr.setMovementType(MInOut.MOVEMENTTYPE_VendorReceipts);
			mr.setDocStatus(DocAction.STATUS_Drafted);
			mr.setDocAction(DocAction.ACTION_Complete);
			mr.setDateOrdered(getLoginDate());
			mr.saveEx();

			MInOutLine line = new MInOutLine(mr);
			line.setLine(10);
			line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.SEEDER.id));
			line.setQty(BigDecimal.ONE);
			line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			line.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(mr, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());

			MWFActivity activity = getActivity(node, MInOut.Table_ID, mr.getM_InOut_ID());
			assertEquals(fail ? StateEngine.STATE_Suspended : StateEngine.STATE_Completed, activity.getWFState());

			mr.load(trxName);
			// the failed process node must not undo the document action before it
			assertEquals(DocAction.STATUS_Completed, mr.getDocStatus());
			return mr;
		} finally {
			rollback();

			if (condition != null)
				condition.delete(true);
			if (transition != null)
				transition.delete(true);
			if (node != null)
				node.delete(true);
			deleteProcess(ctx, process);
			commit();
			CacheMgt.get().reset();
		}
	}

	/**
	 * Runs a general workflow with one process node whose process commits the transaction,
	 * then fails or succeeds. The node savepoint is gone after the commit.
	 */
	private void runProcessNodeThatCommits(boolean fail) {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProcess process = null;
		MWorkflow wf = null;
		MNote note = null;
		try {
			process = createProcess(ctx, true, fail);

			wf = new MWorkflow(ctx, 0, trxName);
			wf.setValue(MARKER);
			wf.setName(MARKER);
			wf.setAuthor(MARKER);
			wf.setAccessLevel(MWorkflow.ACCESSLEVEL_ClientPlusOrganization);
			wf.setEntityType("U");
			wf.setPublishStatus(MWorkflow.PUBLISHSTATUS_Released);
			wf.setWorkflowType(MWorkflow.WORKFLOWTYPE_General);
			wf.setAD_Table_ID(MNote.Table_ID);
			wf.saveEx();
			MWFNode node = new MWFNode(wf, MARKER, MARKER);
			node.setAction(MWFNode.ACTION_AppsProcess);
			node.setAD_Process_ID(process.getAD_Process_ID());
			node.saveEx();
			wf.setAD_WF_Node_ID(node.getAD_WF_Node_ID());
			wf.saveEx();

			note = new MNote(ctx, "OK", getAD_User_ID(), trxName);
			note.saveEx();

			// the workflow code reads the dictionary outside the test transaction
			commit();
			CacheMgt.get().reset();

			ProcessInfo pi = new ProcessInfo(MARKER, process.getAD_Process_ID(), MNote.Table_ID, note.getAD_Note_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setTransactionName(trxName);
			MWFProcess wfProcess = ProcessUtil.startWorkFlow(ctx, pi, wf.getAD_Workflow_ID());
			assertNotNull(wfProcess, pi.getSummary());

			// the transaction must still be usable
			assertEquals(MARKER, DB.getSQLValueStringEx(trxName, "SELECT TextMsg FROM AD_Note WHERE AD_Note_ID=?", note.getAD_Note_ID()),
					"Changes committed by the process node are lost");
			MWFActivity activity = getActivity(node, MNote.Table_ID, note.getAD_Note_ID());
			assertEquals(fail ? StateEngine.STATE_Suspended : StateEngine.STATE_Completed, activity.getWFState(), activity.getTextMsg());
		} finally {
			rollback();

			if (wf != null) {
				// the process committed the workflow process and its activities
				int wfId = wf.getAD_Workflow_ID();
				DB.executeUpdateEx("DELETE FROM AD_WF_EventAudit WHERE AD_WF_Process_ID IN (SELECT AD_WF_Process_ID FROM AD_WF_Process WHERE AD_Workflow_ID=?)",
						new Object[] {wfId}, getTrxName());
				DB.executeUpdateEx("DELETE FROM AD_WF_Activity WHERE AD_Workflow_ID=?", new Object[] {wfId}, getTrxName());
				DB.executeUpdateEx("DELETE FROM AD_WF_Process WHERE AD_Workflow_ID=?", new Object[] {wfId}, getTrxName());
				wf.setAD_WF_Node_ID(0);
				wf.saveEx();
				for (MWFNode node : new Query(ctx, MWFNode.Table_Name, "AD_Workflow_ID=?", getTrxName()).setParameters(wfId).<MWFNode>list())
					node.deleteEx(true);
				wf.deleteEx(true);
			}
			if (note != null)
				note.deleteEx(true);
			deleteProcess(ctx, process);
			commit();
			CacheMgt.get().reset();
		}
	}

	private MProcess createProcess(Properties ctx, boolean commits, boolean fails) {
		Core.getMappedProcessFactory().addMapping(TestProcess.class.getName(), () -> new TestProcess(commits, fails));
		MProcess process = new MProcess(ctx, 0, getTrxName());
		process.set_ValueNoCheck("AD_Client_ID", 0);
		process.setAD_Org_ID(0);
		process.setValue(MARKER);
		process.setName(MARKER);
		process.setClassname(TestProcess.class.getName());
		process.saveCrossTenantSafeEx();
		return process;
	}

	private void deleteProcess(Properties ctx, MProcess process) {
		if (process == null)
			return;
		// process instances of the node are saved outside the test transaction
		DB.executeUpdateEx("DELETE FROM AD_PInstance_Log WHERE AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE AD_Process_ID=?)",
				new Object[] {process.getAD_Process_ID()}, getTrxName());
		DB.executeUpdateEx("DELETE FROM AD_PInstance WHERE AD_Process_ID=?", new Object[] {process.getAD_Process_ID()}, getTrxName());
		int oldRole = Env.getAD_Role_ID(ctx);
		try {
			PO.setCrossTenantSafe();
			Env.setContext(ctx, Env.AD_ROLE_ID, 0); // to allow deleting process
			process.deleteEx(true);
		} finally {
			Env.setContext(ctx, Env.AD_ROLE_ID, oldRole);
			PO.clearCrossTenantSafe();
		}
	}

	private MWFActivity getActivity(MWFNode node, int tableId, int recordId) {
		MWFActivity activity = new Query(Env.getCtx(), MWFActivity.Table_Name, "AD_WF_Node_ID=? AND AD_Table_ID=? AND Record_ID=?", getTrxName())
				.setParameters(node.getAD_WF_Node_ID(), tableId, recordId)
				.first();
		assertNotNull(activity, "Process node did not run");
		return activity;
	}

	/** Writes {@link #MARKER} into the record, optionally commits, then fails or succeeds */
	private static final class TestProcess extends SvrProcess {

		private final boolean commits;
		private final boolean fails;

		private TestProcess(boolean commits, boolean fails) {
			this.commits = commits;
			this.fails = fails;
		}

		@Override
		protected void prepare() {
		}

		@Override
		protected String doIt() throws Exception {
			writeMarker();
			if (commits) {
				commitEx();
				// like a process committing per document: work goes on in a new transaction
				writeMarker();
			}
			if (fails)
				return "@Error@" + MARKER;
			return MARKER;
		}

		private void writeMarker() {
			if (getTable_ID() == MNote.Table_ID)
				DB.executeUpdateEx("UPDATE AD_Note SET TextMsg=? WHERE AD_Note_ID=?",
						new Object[] {MARKER, getRecord_ID()}, get_TrxName());
			else
				DB.executeUpdateEx("UPDATE M_InOut SET Description=? WHERE M_InOut_ID=?",
						new Object[] {MARKER, getRecord_ID()}, get_TrxName());
		}
	}
}
