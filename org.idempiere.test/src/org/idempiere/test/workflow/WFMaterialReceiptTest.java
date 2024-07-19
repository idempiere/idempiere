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
 * - Carlos Ruiz - globalqss	       								   *
 **********************************************************************/
package org.idempiere.test.workflow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProduct;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNextCondition;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * @author Carlos Ruiz - globalqss
 */
public class WFMaterialReceiptTest extends AbstractTestCase {

	public WFMaterialReceiptTest() {
	}

	private static final int LOCATION_FROM_PATIO = 115;
	private static final int WF_PROCESS_SHIPMENT = 117;
	private static final int WF_PROCESS_SHIPMENT_NODE_COMPLETE = 190;
	private static final int PROCESS_SYNC_DOC_TRL = 321;
	private static final int COLUMN_M_INOUT_ISSOTRX = 3790;

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4186
	 */
	@Test
	public void testSplitAndWorkflow() {

		MWFNode nodeWait0 = null;
		MWFNodeNext fromCompleteToWait0 = null;
		MWFNextCondition conditionPurchase = null;
		MWFNode nodeSyncTrl1 = null;
		MWFNodeNext fromWait0ToSyncTrl1 = null;
		MWFNode nodeWaitAgain = null;
		MWFNodeNext fromWait0ToWaitAgain = null;
		MWFNode nodeSyncTrl2 = null;
		MWFNodeNext fromWaitAgainToSyncTrl2 = null;
		try {
			Properties ctx = Env.getCtx();
			String trxName = getTrxName();

			/* to avoid the process doc sync trl to fail */
			MClient client = new MClient (ctx, Env.getAD_Client_ID(ctx), trxName);
			client.setIsMultiLingualDocument(false);
			client.saveEx();

			MWorkflow wf = new MWorkflow(ctx, WF_PROCESS_SHIPMENT, trxName);
			// Add node Wait0(AND Split)
			nodeWait0 = new MWFNode(wf, "Wait0(AND Split)", "Wait0(AND Split)");
			nodeWait0.setClientOrg(Env.getAD_Client_ID(ctx), 0);
			nodeWait0.setAction(MWFNode.ACTION_WaitSleep);
			nodeWait0.setWaitTime(0);
			nodeWait0.setSplitElement(MWFNode.SPLITELEMENT_AND);
			nodeWait0.saveEx();
			// Add transition from Complete to Wait0
			MWFNode nodeComplete = new MWFNode(ctx, WF_PROCESS_SHIPMENT_NODE_COMPLETE, trxName);
			fromCompleteToWait0 = new MWFNodeNext(nodeComplete, nodeWait0.getAD_WF_Node_ID());
			fromCompleteToWait0.setClientOrg(Env.getAD_Client_ID(ctx), 0);
			fromCompleteToWait0.setDescription("IsSOTrx=N");
			fromCompleteToWait0.saveEx();
			// Add condition for transition - just purchases IsSOTrx=N
			conditionPurchase = new MWFNextCondition(ctx, 0, trxName);
			conditionPurchase.setAD_WF_NodeNext_ID(fromCompleteToWait0.getAD_WF_NodeNext_ID());
			conditionPurchase.setOperation(MWFNextCondition.OPERATION_Eq);
			conditionPurchase.setAD_Column_ID(COLUMN_M_INOUT_ISSOTRX);
			conditionPurchase.setValue("N");
			conditionPurchase.setSeqNo(10);
			conditionPurchase.setAndOr(MWFNextCondition.ANDOR_Or);
			conditionPurchase.saveEx();
			// Add node to run process Sync Doc Trl (1)
			nodeSyncTrl1 = new MWFNode(wf, "SyncTrl1", "SyncTrl1");
			nodeSyncTrl1.setClientOrg(Env.getAD_Client_ID(ctx), 0);
			nodeSyncTrl1.setAction(MWFNode.ACTION_AppsProcess);
			nodeSyncTrl1.setAD_Process_ID(PROCESS_SYNC_DOC_TRL);
			nodeSyncTrl1.saveEx();
			// Add transition from Wait0 to SyncTrl1
			fromWait0ToSyncTrl1 = new MWFNodeNext(nodeWait0, nodeSyncTrl1.getAD_WF_Node_ID());
			fromWait0ToSyncTrl1.saveEx();
			// Add node WaitZeroAgain
			nodeWaitAgain = new MWFNode(wf, "WaitAgain", "WaitAgain");
			nodeWaitAgain.setClientOrg(Env.getAD_Client_ID(ctx), 0);
			nodeWaitAgain.setAction(MWFNode.ACTION_WaitSleep);
			nodeWaitAgain.setWaitTime(0); // to test wait commit must be -1, but unit tests must not commit
			nodeWaitAgain.saveEx();
			// Add transition from Wait0 to WaitZeroAgain
			fromWait0ToWaitAgain = new MWFNodeNext(nodeWait0, nodeWaitAgain.getAD_WF_Node_ID());
			fromWait0ToWaitAgain.saveEx();
			// Add node to run process Sync Doc Trl (2)
			nodeSyncTrl2 = new MWFNode(wf, "SyncTrl2", "SyncTrl2");
			nodeSyncTrl2.setClientOrg(Env.getAD_Client_ID(ctx), 0);
			nodeSyncTrl2.setAction(MWFNode.ACTION_AppsProcess);
			nodeSyncTrl2.setAD_Process_ID(PROCESS_SYNC_DOC_TRL);
			nodeSyncTrl2.saveEx();
			// Add transition from WaitZeroAgain to SyncTrl2
			fromWaitAgainToSyncTrl2 = new MWFNodeNext(nodeWaitAgain, nodeSyncTrl2.getAD_WF_Node_ID());
			fromWaitAgainToSyncTrl2.saveEx();

			// we need to commit here because internally all the workflow code is working without trx
			commit();

			CacheMgt.get().reset();

			MInOut mr = new MInOut(ctx, 0, trxName);
			mr.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
			mr.setC_BPartner_Location_ID (LOCATION_FROM_PATIO);
			mr.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			mr.setC_DocType_ID(DictionaryIDs.C_DocType.MM_RECEIPT.id);
			mr.setIsSOTrx(false);
			mr.setMovementType(MInOut.MOVEMENTTYPE_VendorReceipts);
			mr.setDocStatus(DocAction.STATUS_Drafted);
			mr.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			mr.setDateOrdered(today);
			mr.saveEx();

			MInOutLine line1 = new MInOutLine(mr);
			line1.setLine(10);
			line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.SEEDER.id));
			line1.setQty(new BigDecimal("1"));
			line1.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			line1.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(mr, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			mr.load(trxName);
			assertEquals(DocAction.STATUS_Completed, mr.getDocStatus());

			MWFProcess proc = new Query(ctx, MWFProcess.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName)
					.setParameters(MInOut.Table_ID, mr.getM_InOut_ID())
					.firstOnly();

			MWFActivity[] acts = proc.getActivities(true, false, trxName);
			assertEquals(7, acts.length);

			for (MWFActivity act : acts) {
				assertEquals(act.isProcessed(), true);
			}
		} finally {

			// rollback the work from the test
			rollback();

			// cleanup the objects that were created and committed in the test
			if (fromWaitAgainToSyncTrl2 != null)
				fromWaitAgainToSyncTrl2.delete(true);
			if (nodeSyncTrl2 != null)
				nodeSyncTrl2.delete(true);
			if (fromWait0ToWaitAgain != null)
				fromWait0ToWaitAgain.delete(true);
			if (nodeWaitAgain != null)
				nodeWaitAgain.delete(true);
			if (fromWait0ToSyncTrl1 != null)
				fromWait0ToSyncTrl1.delete(true);
			if (nodeSyncTrl1 != null)
				nodeSyncTrl1.delete(true);
			if (conditionPurchase != null)
				conditionPurchase.delete(true);
			if (fromCompleteToWait0 != null)
				fromCompleteToWait0.delete(true);
			if (nodeWait0 != null)
				nodeWait0.delete(true);

			// commit the cleanup
			commit();

			CacheMgt.get().reset();
		}

	}

}