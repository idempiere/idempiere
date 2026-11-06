/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.idempiere.test.workflow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProduct;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Test cases for document type workflow configuration and execution.
 *
 * @author Logilite Technologies
 */
public class WorkflowPerDocumentTypeTest extends AbstractTestCase
{

	private static final int LOCATION_FROM_PATIO = 115;

	/**
	 * Test workflow handling when a workflow is configured on a document type.
	 * <p>
	 * This test verifies that a workflow assigned to the Material Receipt
	 * document type is used when processing the document, even when the
	 * workflow is defined for a different table.
	 * </p>
	 *
	 * @see <a href="https://idempiere.atlassian.net/browse/IDEMPIERE-6902">
	 *      IDEMPIERE-6902</a>
	 */
	@Test
	public void testDocumentTypeWorkflow()
	{

		MDocType docType = null;
		int originalWorkflowID = 0;
		Properties ctx = Env.getCtx();
		try
		{
			String trxName = getTrxName();

			/*
			 * Use the existing Material Receipt Document Type.
			 * Save its original workflow so it can be restored
			 * after the test.
			 */
			docType = new MDocType(ctx, DictionaryIDs.C_DocType.MM_RECEIPT.id, trxName);

			assertNotNull(docType);

			originalWorkflowID = docType.getAD_Workflow_ID();

			/*
			 * Use the Order workflow and assign it to the
			 * Material Receipt Document Type.
			 * The workflow table is different from M_InOut,
			 * which verifies that workflow selection is based
			 * on the Document Type and not on the document table.
			 */
			MWorkflow orderWorkflow = new MWorkflow(ctx, DictionaryIDs.AD_Workflow.PROCESS_ORDER.id, trxName);

			assertNotNull(orderWorkflow);

			assertFalse(orderWorkflow.getAD_Table_ID() == MInOut.Table_ID);

			docType.setAD_Workflow_ID(orderWorkflow.getAD_Workflow_ID());
			docType.saveEx();

			/*
			 * Workflow processing can work outside the current
			 * transaction, so commit the Document Type change.
			 */
			commit();

			CacheMgt.get().reset();

			/*
			 * Create a Material Receipt using the Document Type
			 * configured above.
			 */
			MInOut mr = new MInOut(ctx, 0, trxName);
			mr.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
			mr.setC_BPartner_Location_ID(LOCATION_FROM_PATIO);
			mr.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			mr.setC_DocType_ID(docType.getC_DocType_ID());
			mr.setIsSOTrx(false);
			mr.setMovementType(MInOut.MOVEMENTTYPE_VendorReceipts);
			mr.setDocStatus(DocAction.STATUS_Drafted);
			mr.setDocAction(DocAction.ACTION_Complete);

			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			mr.setDateOrdered(today);
			mr.saveEx();

			MInOutLine line = new MInOutLine(mr);
			line.setLine(10);
			line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.SEEDER.id));
			line.setQty(new BigDecimal("1"));
			line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			line.saveEx();

			/*
			 * Run the document action.
			 */
			ProcessInfo info = runDocumentActionWorkflow(mr, DocAction.ACTION_Complete);

			assertFalse(info.isError(), info.getSummary());

			/*
			 * Verify that the document was completed.
			 */
			mr.load(trxName);

			assertEquals(DocAction.STATUS_Completed, mr.getDocStatus());

			/*
			 * Find the workflow process created for the
			 * Material Receipt.
			 */
			MWFProcess proc = new Query(ctx, MWFProcess.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName).setParameters(MInOut.Table_ID, mr.getM_InOut_ID()).firstOnly();

			assertNotNull(proc);

			/*
			 * Verify that the workflow assigned to the
			 * Document Type was used.
			 */
			assertEquals(orderWorkflow.getAD_Workflow_ID(), proc.getAD_Workflow_ID());

			/*
			 * The workflow process must run against the
			 * current Material Receipt, even though the
			 * selected workflow belongs to another table.
			 */
			assertEquals(MInOut.Table_ID, proc.getAD_Table_ID());

			assertEquals(mr.getM_InOut_ID(), proc.getRecord_ID());

		}
		finally
		{

			/*
			 * Rollback document changes made by the test.
			 */
			rollback();

			/*
			 * Restore the original workflow on the
			 * Material Receipt Document Type.
			 */
			if (docType != null)
			{
				docType.setAD_Workflow_ID(originalWorkflowID);
				docType.saveEx();
				commit();
			}

			CacheMgt.get().reset();
		}
	}

	/**
	 * Runs the document action process for the given persistent object.
	 * <p>
	 * The process is marked as a document action process to ensure that
	 * the workflow configured on the document type is not overwritten when
	 * the document action is executed from the backend.
	 * </p>
	 *
	 * @param  po        the persistent object on which the document action is executed
	 * @param  docAction the document action to execute
	 * @return           the process information for the executed document action,
	 *                   or {@code null} if the object's table does not contain a
	 *                   {@code DocAction} column
	 * @see              <a href="https://idempiere.atlassian.net/browse/IDEMPIERE-6902">
	 *                   IDEMPIERE-6902</a>
	 */
	public static ProcessInfo runDocumentActionWorkflow(PO po, String docAction)
	{
		int AD_Table_ID = po.get_Table_ID();
		MTable table = MTable.get(Env.getCtx(), AD_Table_ID);
		MColumn column = table.getColumn("DocAction");
		if (column == null)
			return null;
		if (!docAction.equals(po.get_Value(column.getColumnName())))
		{
			po.set_ValueOfColumn(column.getColumnName(), docAction);
			po.saveEx();
		}
		ProcessInfo processInfo = new ProcessInfo(((DocAction) po).getDocumentInfo(), column.getAD_Process_ID(), po.get_Table_ID(), po.get_ID());
		processInfo.setTransactionName(po.get_TrxName());
		processInfo.setPO(po);
		processInfo.setIsDocActionProcess(true);
		ServerProcessCtl.process(processInfo, !Util.isEmpty(processInfo.getTransactionName(), true) ? Trx.get(processInfo.getTransactionName(), false) : null);
		return processInfo;
	}

}
