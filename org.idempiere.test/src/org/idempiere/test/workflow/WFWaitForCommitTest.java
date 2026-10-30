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

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.SvrProcess;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Wait (Sleep) node with Wait Time -1: the workflow waits until the transaction of the document commits
 * (IDEMPIERE-4186).<br/>
 * The workflow Process_Shipment gets Complete -> Wait (-1) -> probe. The probe records whether its receipt is
 * visible from another connection, and for the first receipt it creates and completes a second receipt through
 * its workflow, so the second receipt waits behind its own Wait (-1).<br/>
 * The nodes are committed (the Wait needs a commit) and removed after each test, hence {@link Isolated}.
 */
@Isolated
public class WFWaitForCommitTest extends AbstractTestCase {

	private static final int WF_PROCESS_SHIPMENT_NODE_COMPLETE = 190;
	private static final int LOCATION_FROM_PATIO = 115;

	private static final String DESCRIPTION = "WFWaitForCommitTest";
	private static final String DESCRIPTION_NESTED = DESCRIPTION + " nested ";
	private static final String DESCRIPTION_FAIL = DESCRIPTION + " fail";

	/** M_InOut_ID -> receipt committed when the probe behind its Wait (-1) ran */
	private static final Map<Integer, Boolean> committedAtProbe = new ConcurrentHashMap<>();

	private MProcess probeProcess;
	private MWFNode nodeWait;
	private MWFNodeNext fromCompleteToWait;
	private MWFNode nodeProbe;
	private MWFNodeNext fromWaitToProbe;

	public WFWaitForCommitTest() {
	}

	@BeforeEach
	public void setUpWorkflow() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		committedAtProbe.clear();

		Core.getMappedProcessFactory().addMapping(WaitProbe.class.getName(), () -> new WaitProbe());
		probeProcess = new MProcess(ctx, 0, trxName);
		probeProcess.set_ValueNoCheck("AD_Client_ID", 0);
		probeProcess.setAD_Org_ID(0);
		probeProcess.setValue(DESCRIPTION);
		probeProcess.setName(DESCRIPTION);
		probeProcess.setClassname(WaitProbe.class.getName());
		probeProcess.saveCrossTenantSafeEx();

		MWorkflow wf = new MWorkflow(ctx, DictionaryIDs.AD_Workflow.PROCESS_SHIPMENT.id, trxName);
		nodeWait = new MWFNode(wf, "WaitForCommit", "WaitForCommit");
		nodeWait.setClientOrg(Env.getAD_Client_ID(ctx), 0);
		nodeWait.setAction(MWFNode.ACTION_WaitSleep);
		nodeWait.setWaitTime(-1);
		nodeWait.saveEx();
		MWFNode nodeComplete = new MWFNode(ctx, WF_PROCESS_SHIPMENT_NODE_COMPLETE, trxName);
		fromCompleteToWait = new MWFNodeNext(nodeComplete, nodeWait.getAD_WF_Node_ID());
		fromCompleteToWait.setClientOrg(Env.getAD_Client_ID(ctx), 0);
		fromCompleteToWait.saveEx();
		nodeProbe = new MWFNode(wf, "WaitProbe", "WaitProbe");
		nodeProbe.setClientOrg(Env.getAD_Client_ID(ctx), 0);
		nodeProbe.setAction(MWFNode.ACTION_AppsProcess);
		nodeProbe.setAD_Process_ID(probeProcess.getAD_Process_ID());
		nodeProbe.saveEx();
		fromWaitToProbe = new MWFNodeNext(nodeWait, nodeProbe.getAD_WF_Node_ID());
		fromWaitToProbe.saveEx();

		// the workflow engine reads the nodes outside the test transaction
		commit();
		CacheMgt.get().reset();
	}

	@AfterEach
	public void tearDownWorkflow() {
		rollback();
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		String receipts = "SELECT M_InOut_ID FROM M_InOut WHERE AD_Client_ID=? AND Description LIKE ?";
		Object[] params = new Object[] {getAD_Client_ID(), DESCRIPTION + "%"};
		DB.executeUpdateEx("DELETE FROM AD_WF_EventAudit WHERE AD_Table_ID=? AND Record_ID IN (" + receipts + ")",
				new Object[] {MInOut.Table_ID, params[0], params[1]}, trxName);
		DB.executeUpdateEx("DELETE FROM AD_WF_Activity WHERE AD_Table_ID=? AND Record_ID IN (" + receipts + ")",
				new Object[] {MInOut.Table_ID, params[0], params[1]}, trxName);
		DB.executeUpdateEx("DELETE FROM AD_WF_Process WHERE AD_Table_ID=? AND Record_ID IN (" + receipts + ")",
				new Object[] {MInOut.Table_ID, params[0], params[1]}, trxName);
		DB.executeUpdateEx("DELETE FROM M_InOutLine WHERE M_InOut_ID IN (" + receipts + ")", params, trxName);
		DB.executeUpdateEx("DELETE FROM M_InOut WHERE M_InOut_ID IN (" + receipts + ")", params, trxName);

		if (fromWaitToProbe != null)
			fromWaitToProbe.deleteEx(true);
		if (nodeProbe != null)
			nodeProbe.deleteEx(true);
		if (fromCompleteToWait != null)
			fromCompleteToWait.deleteEx(true);
		if (nodeWait != null)
			nodeWait.deleteEx(true);
		if (probeProcess != null) {
			DB.executeUpdateEx("DELETE FROM AD_PInstance_Log WHERE AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE AD_Process_ID=?)",
					new Object[] {probeProcess.getAD_Process_ID()}, trxName);
			DB.executeUpdateEx("DELETE FROM AD_PInstance WHERE AD_Process_ID=?", new Object[] {probeProcess.getAD_Process_ID()}, trxName);
			int oldRole = Env.getAD_Role_ID(ctx);
			try {
				PO.setCrossTenantSafe();
				Env.setContext(ctx, Env.AD_ROLE_ID, 0); // to allow deleting the process
				probeProcess.deleteEx(true);
			} finally {
				Env.setContext(ctx, Env.AD_ROLE_ID, oldRole);
				PO.clearCrossTenantSafe();
			}
		}
		commit();
		Core.getMappedProcessFactory().removeMapping(WaitProbe.class.getName());
		CacheMgt.get().reset();
	}

	/**
	 * A node behind the Wait (-1) creates and completes a second document, whose workflow waits too.
	 * The node behind the second Wait must run after the second document is committed.
	 */
	@Test
	public void testWaitOfDocumentCompletedBehindAWait() {
		MInOut first = createReceipt(Env.getCtx(), DESCRIPTION, getLoginDate(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(first, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		first.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, first.getDocStatus());
		assertTrue(committedAtProbe.isEmpty(), "the Wait (-1) released before the commit");

		commit();

		assertEquals(Boolean.TRUE, committedAtProbe.get(first.getM_InOut_ID()), "the probe of the first receipt did not run after its commit");
		MInOut second = new Query(Env.getCtx(), MInOut.Table_Name, "Description=?", getTrxName())
				.setParameters(DESCRIPTION_NESTED + first.getM_InOut_ID())
				.first();
		assertNotNull(second, "the second receipt was not created by the node behind the Wait");
		assertEquals(DocAction.STATUS_Completed, second.getDocStatus());
		assertEquals(Boolean.TRUE, committedAtProbe.get(second.getM_InOut_ID()),
				"the node behind the Wait (-1) of the second receipt ran before the second receipt was committed");
	}

	/**
	 * A document completed and rolled back must not continue its workflow on the next commit of the same transaction.
	 */
	@Test
	public void testWaitOfRolledBackDocument() {
		MInOut rolledBack = createReceipt(Env.getCtx(), DESCRIPTION, getLoginDate(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(rolledBack, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		rollback();

		// the next work of the same transaction
		createReceipt(Env.getCtx(), DESCRIPTION, getLoginDate(), getTrxName());
		assertDoesNotThrow(() -> commit(), "the commit after the rollback continued the workflow of the rolled back receipt");
		assertFalse(committedAtProbe.containsKey(rolledBack.getM_InOut_ID()),
				"the workflow of the rolled back receipt continued on the next commit");
		assertEquals(0, countActivities(rolledBack.getM_InOut_ID()), "the next commit recreated a workflow activity of the rolled back receipt");
	}

	/**
	 * A document completed and rolled back to a savepoint must not continue its workflow on the next commit.
	 * Trx.rollback(Savepoint) does not call afterRollback.
	 */
	@Test
	public void testWaitOfDocumentRolledBackToSavepoint() throws Exception {
		Trx trx = Trx.get(getTrxName(), false);
		Savepoint savepoint = trx.setSavepoint(null);
		MInOut rolledBack = createReceipt(Env.getCtx(), DESCRIPTION, getLoginDate(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(rolledBack, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		trx.rollback(savepoint);
		trx.setLastWFSavepoint(null);

		// the next work of the same transaction
		createReceipt(Env.getCtx(), DESCRIPTION, getLoginDate(), getTrxName());
		assertDoesNotThrow(() -> commit(), "the commit after the rollback to savepoint continued the workflow of the rolled back receipt");
		assertFalse(committedAtProbe.containsKey(rolledBack.getM_InOut_ID()),
				"the workflow of the receipt rolled back to a savepoint continued on the next commit");
		assertEquals(0, countActivities(rolledBack.getM_InOut_ID()), "the next commit recreated a workflow activity of the receipt rolled back to a savepoint");
	}

	/**
	 * A node behind the Wait (-1) fails: the document stays committed and the failing activity is suspended.
	 */
	@Test
	public void testFailingNodeBehindTheWait() {
		MInOut receipt = createReceipt(Env.getCtx(), DESCRIPTION_FAIL, getLoginDate(), getTrxName());
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());

		commit();

		assertEquals(Boolean.TRUE, committedAtProbe.get(receipt.getM_InOut_ID()), "the probe of the receipt did not run after its commit");
		String docStatus = DB.getSQLValueStringEx(null, "SELECT DocStatus FROM M_InOut WHERE M_InOut_ID=?", receipt.getM_InOut_ID());
		assertEquals(DocAction.STATUS_Completed, docStatus, "the completed receipt was not committed");
		String wfState = DB.getSQLValueStringEx(null, "SELECT a.WFState FROM AD_WF_Activity a"
				+ " WHERE a.AD_Table_ID=? AND a.Record_ID=? AND a.AD_WF_Node_ID=?",
				MInOut.Table_ID, receipt.getM_InOut_ID(), nodeProbe.getAD_WF_Node_ID());
		assertEquals(MWFActivity.WFSTATE_Suspended, wfState, "the failing node behind the Wait (-1) is not suspended");
	}

	/** Workflow activities of the receipt, read from another connection */
	private static int countActivities(int receiptId) {
		return DB.getSQLValueEx(null, "SELECT COUNT(*) FROM AD_WF_Activity WHERE AD_Table_ID=? AND Record_ID=?", MInOut.Table_ID, receiptId);
	}

	private static MInOut createReceipt(Properties ctx, String description, Timestamp dateOrdered, String trxName) {
		MInOut receipt = new MInOut(ctx, 0, trxName);
		receipt.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		receipt.setC_BPartner_Location_ID(LOCATION_FROM_PATIO);
		receipt.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		receipt.setC_DocType_ID(DictionaryIDs.C_DocType.MM_RECEIPT.id);
		receipt.setIsSOTrx(false);
		receipt.setMovementType(MInOut.MOVEMENTTYPE_VendorReceipts);
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.setDescription(description);
		receipt.setDateOrdered(dateOrdered);
		receipt.saveEx();

		MInOutLine line = new MInOutLine(receipt);
		line.setLine(10);
		line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.PLANTING.id));
		line.setQty(BigDecimal.ONE);
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.saveEx();
		return receipt;
	}

	/**
	 * Records whether the receipt is committed (read from another connection); for the first receipt, creates and
	 * completes the second one.
	 */
	private static final class WaitProbe extends SvrProcess {

		@Override
		protected void prepare() {
		}

		@Override
		protected String doIt() throws Exception {
			int receiptId = getRecord_ID();
			// null: read from another connection, which sees only committed data
			int committed = DB.getSQLValueEx(null, "SELECT COUNT(*) FROM M_InOut WHERE M_InOut_ID=?", receiptId);
			committedAtProbe.put(receiptId, committed > 0);

			MInOut receipt = new MInOut(getCtx(), receiptId, get_TrxName());
			if (DESCRIPTION_FAIL.equals(receipt.getDescription()))
				throw new AdempiereException("node behind the Wait (-1) fails");
			if (DESCRIPTION.equals(receipt.getDescription())) {
				MInOut second = createReceipt(getCtx(), DESCRIPTION_NESTED + receiptId, receipt.getDateOrdered(), get_TrxName());
				ProcessInfo info = MWorkflow.runDocumentActionWorkflow(second, DocAction.ACTION_Complete);
				if (info.isError())
					throw new AdempiereException(info.getSummary());
			}
			return "@OK@";
		}
	}
}
