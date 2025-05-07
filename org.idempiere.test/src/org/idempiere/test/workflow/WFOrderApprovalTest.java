/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP                               *
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

import static org.junit.jupiter.api.Assertions.*;

import java.math.BigDecimal;
import java.util.Properties;

import org.compiere.model.*;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.*;
import org.compiere.wf.*;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Test case for validating a custom approval column in Order Workflow.
 * This class dynamically creates a workflow with approval steps, assigns supervisor relationships,
 * and tests approval and rejection scenarios for sales orders via user context switching.
 */
public class WFOrderApprovalTest extends AbstractTestCase
{

	private MWorkflow	workflow;
	private MWFNode		nodeStart, nodePrepare, nodeApprove, nodeAuto, nodeComplete;
	private MOrder		order;
	private MUser		joeSales, carlBoss;
	private MWFNodeNext	nextStartPrepare, nextStartAuto, nextPrepareApprove, nextApproveComplete, nextPrepareComplete;

	/**
	 * Tests rejection of a sales order using a custom approval column.
	 * Simulates supervisor/user roles and verifies that rejection updates document status
	 * correctly.
	 */
	@Test
	public void testOrderRejectWithCustomApprovalColumn( )
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			setupWorkflow(ctx, trxName);
			assignSupervisor(ctx, trxName);

			Env.setContext(ctx, Env.AD_USER_ID, carlBoss.getAD_User_ID());
			Env.setContext(ctx, Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);

			order = createOrder(ctx, trxName);

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_InProgress, order.getDocStatus(), "Document should be in progress awaiting approval");

			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process);
			assertNotNull(suspendedActivity, "Suspended approval step should be assigned to Joe Sales");

			// Switch context to Joe Sales to reject
			Env.setContext(ctx, Env.AD_USER_ID, joeSales.getAD_User_ID());
			Env.setContext(ctx, Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);

			updateActivity(suspendedActivity, false);

			assertEquals(MWFActivity.WFSTATE_Aborted, suspendedActivity.getWFState(), "Activity status should be Aborted.");
			order.saveEx();

			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertTrue(MOrder.DOCSTATUS_NotApproved.equals(reloadOrder.getDocStatus()), "Order should be Not Approved.");
		}
		finally
		{
			cleanup();
		}
	}

	/**
	 * Tests approval of a sales order using a custom approval column.
	 * Ensures the order moves from InProgress to Completed after approval.
	 */
	@Test
	public void testOrderApprovalWithCustomApprovalColumn( )
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			setupWorkflow(ctx, trxName);
			assignSupervisor(ctx, trxName);

			Env.setContext(ctx, Env.AD_USER_ID, carlBoss.getAD_User_ID());
			Env.setContext(ctx, Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);

			order = createOrder(ctx, trxName);

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_InProgress, order.getDocStatus(), "Document should be in progress awaiting approval");

			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process);
			assertNotNull(suspendedActivity, "Suspended approval step should be assigned to Joe Sales");

			// Switch context to Joe Sales to approve
			Env.setContext(ctx, Env.AD_USER_ID, joeSales.getAD_User_ID());
			Env.setContext(ctx, Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);

			updateActivity(suspendedActivity, true);

			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");
			order.saveEx();

			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be completed.");
		}
		finally
		{
			cleanup();
		}
	}

	/**
	 * Sets up the dynamic workflow and creates required nodes and transitions.
	 *
	 * @param ctx
	 *            application context
	 * @param trxName
	 *            transaction name
	 */
	private void setupWorkflow(Properties ctx, String trxName)
	{
		workflow = new MWorkflow(ctx, 0, trxName);
		workflow.setName("Process_Order");
		workflow.setDescription("(Standard Process Order)");
		workflow.setAD_Table_ID(MOrder.Table_ID);
		workflow.setEntityType("D");
		workflow.setWorkflowType(MWorkflow.WORKFLOWTYPE_DocumentProcess);
		workflow.setIsValid(true);
		workflow.saveEx();

		nodeStart = createNode(workflow, "(Start)", MWFNode.ACTION_WaitSleep, null, trxName);
		nodePrepare = createNode(workflow, "(DocPrepare)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Prepare, trxName);
		nodeApprove = createNode(workflow, "(DocApprove)", MWFNode.ACTION_UserChoice, null, trxName);
		nodeAuto = createNode(workflow, "(DocAuto)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_None, trxName);
		nodeComplete = createNode(workflow, "(DocComplete)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Complete, trxName);

		createTransitions();
		commit();
	}

	/**
	 * Creates a single node for the workflow.
	 *
	 * @param wf
	 *            workflow object
	 * @param name
	 *            name of the node
	 * @param action
	 *            type of node action
	 * @param docAction
	 *            document action if any
	 * @param trxName
	 *            transaction name
	 * @return created MWFNode object
	 */
	private MWFNode createNode(MWorkflow wf, String name, String action, String docAction, String trxName)
	{
		MWFNode node = new MWFNode(wf, name, "(Standard Node)");
		node.setAction(action);
		if (docAction != null)
		{
			node.setDocAction(docAction);
		}
		if (MWFNode.ACTION_UserChoice.equalsIgnoreCase(action))
			node.setApprovalColumn_ID(MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved));
		node.saveEx();
		return node;
	}

	/**
	 * Creates transitions between workflow nodes.
	 */
	private void createTransitions( )
	{
		nextStartPrepare = new MWFNodeNext(nodeStart, nodePrepare.getAD_WF_Node_ID());
		nextStartPrepare.saveEx();
		nextStartAuto = new MWFNodeNext(nodeStart, nodeAuto.getAD_WF_Node_ID());
		nextStartAuto.saveEx();
		nextPrepareApprove = new MWFNodeNext(nodePrepare, nodeApprove.getAD_WF_Node_ID());
		nextPrepareApprove.saveEx();
		nextApproveComplete = new MWFNodeNext(nodeApprove, nodeComplete.getAD_WF_Node_ID());
		nextApproveComplete.saveEx();
	}

	/**
	 * Assigns Joe Sales as the supervisor for Carl Boss.
	 *
	 * @param ctx
	 *            application context
	 * @param trxName
	 *            transaction name
	 */
	private void assignSupervisor(Properties ctx, String trxName)
	{
		joeSales = new MUser(ctx, 103, trxName);
		carlBoss = new MUser(ctx, 104, trxName);
		carlBoss.setSupervisor_ID(joeSales.getAD_User_ID());
		carlBoss.saveEx();
	}

	/**
	 * Creates a new test order with one product line.
	 *
	 * @param ctx
	 *            application context
	 * @param trxName
	 *            transaction name
	 * @return created order
	 */
	private MOrder createOrder(Properties ctx, String trxName)
	{
		MOrder order = new MOrder(ctx, 0, trxName);
		order.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setDateOrdered(TimeUtil.getDay(System.currentTimeMillis()));
		order.setDatePromised(TimeUtil.getDay(System.currentTimeMillis()));
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();

		MOrderLine line = new MOrderLine(order);
		line.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.SEEDER.id));
		line.setQty(BigDecimal.ONE);
		line.setPrice(new BigDecimal("200"));
		line.saveEx();

		return order;
	}

	/**
	 * Fetches the workflow process associated with a given order ID.
	 *
	 * @param ctx
	 *            application context
	 * @param trxName
	 *            transaction name
	 * @param orderId
	 *            order ID
	 * @return workflow process or null
	 */
	private MWFProcess fetchWorkflowProcess(Properties ctx, String trxName, int orderId)
	{
		return new Query(ctx, MWFProcess.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName)
						.setParameters(MOrder.Table_ID, orderId)
						.setOrderBy("created desc")
						.firstOnly();
	}

	/**
	 * Finds the suspended workflow activity assigned to Joe Sales.
	 *
	 * @param ctx
	 *            application context
	 * @param trxName
	 *            transaction name
	 * @param process
	 *            workflow process
	 * @return suspended activity or null
	 */
	private MWFActivity findSuspendedActivity(Properties ctx, String trxName, MWFProcess process)
	{
		MWFActivity[] activities = process.getActivities(true, false, trxName);

		for (MWFActivity act : activities)
		{
			if (MWFActivity.WFSTATE_Suspended.equals(act.getWFState())
				&& act.getAD_User_ID() == joeSales.getAD_User_ID())
			{
				return act;
			}
		}
		return null;
	}

	/**
	 * Updates the activity with either approval or rejection.
	 *
	 * @param activity
	 *            workflow activity
	 * @param isApprove
	 *            true to approve, false to reject
	 */
	private void updateActivity(MWFActivity activity, boolean isApprove)
	{
		Exception exception = null;
		try
		{
			Properties ctx = activity.getCtx();

			activity.setUserChoice(joeSales.getAD_User_ID(), isApprove ? "Y" : "N", DisplayType.YesNo, "Unit test approval");
			new MWFProcess(ctx, activity.getAD_WF_Process_ID(), activity.get_TrxName())
							.checkCloseActivities(activity.get_TrxName());
			assertTrue(Util.isEmpty(activity.getProcessMsg(), true), "There is no error when approving the activity.");
			activity.saveEx();
		}
		catch (Exception e)
		{
			exception = e;
		}
		assertNull(exception, "Approval should not throw an exception.");
	}

	/**
	 * Cleans up all created workflow data, nodes, transitions, and resets cache.
	 */
	private void cleanup( )
	{
		rollback();
		deleteIfExists(order);
		deleteIfExists(nextStartPrepare, nextStartAuto, nextPrepareApprove, nextApproveComplete, nextPrepareComplete);
		deleteIfExists(nodeComplete, nodeAuto, nodeApprove, nodePrepare, nodeStart);
		deleteIfExists(workflow);
		commit();
		CacheMgt.get().reset();
	}

	/**
	 * Deletes the given persistent objects if they exist.
	 *
	 * @param records
	 *            one or more PO instances
	 */
	private void deleteIfExists(PO... records)
	{
		for (PO record : records)
		{
			if (record != null && record.get_ID() > 0)
			{
				record.delete(true);
			}
		}
	}
}
