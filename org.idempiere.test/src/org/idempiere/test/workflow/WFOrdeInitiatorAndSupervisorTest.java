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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MColumn;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNextCondition;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWFResponsible;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Test class for validating workflow behavior in sales order processing.
 * <p>
 * This class simulates real-world document approval scenarios using the Compiere/Adempiere
 * workflow engine. It verifies transitions, assignments, and outcomes based on user roles
 * such as initiator and supervisor.
 * </p>
 * <h2>Test Scenarios:</h2>
 * <ul>
 * <li><strong>testOrderInitiatorSupervisorApprove</strong>: Validates that when a sales order is
 * submitted,
 * it is routed to a supervisor for approval and, upon approval, transitions to 'Completed'
 * status.</li>
 * <li><strong>testOrderInitiatorSupervisorRework</strong>: Validates a rejection path where the
 * supervisor
 * sends the order back for rework. The initiator revises it, and the order stays in 'In
 * Progress'.</li>
 * </ul>
 */
public class WFOrdeInitiatorAndSupervisorTest extends AbstractTestCase
{

	private MWorkflow			workflow;
	private MWFNode				nodeStart, nodePrepare, nodeApprove, nodeRework, nodeAuto, nodeComplete;
	private MUser				gardenAdmin, gardenUser;
	private MWFNodeNext			nextStartPrepare, nextStartAuto, nextPrepareApprove, nextApproveComplete, nextApproveRework, nextReworkPrepare;
	private MWFNextCondition	conditionPrepareApprove, conditionPrepareComplete, conditionApproveCompleted, conditionApproveRework;
	private int					ordWFID;
	// Load the 'Supervisor' responsible entity (ID: 200001) used for assigning workflow tasks based
	// on the user's supervisor
	private MWFResponsible		responsibleSupervisor	= MWFResponsible.get(200001);
	// Load the 'Initiator' responsible entity (ID: 200000) used for assigning workflow tasks to the
	// user who initiated the document/workflow
	private MWFResponsible		responsibleInitiator	= MWFResponsible.get(200000);

	/**
	 * Tests the approval flow in a sales order workflow.
	 * <p>
	 * Scenario:
	 * <ul>
	 * <li>A user submits a sales order.</li>
	 * <li>The order is routed to a supervisor for approval via the workflow engine.</li>
	 * <li>The supervisor approves the order.</li>
	 * <li>The order status transitions to 'Completed'.</li>
	 * </ul>
	 * </p>
	 * This test ensures correct state transitions and proper workflow activity assignment and
	 * completion.
	 */
	@Test
	public void testOrderInitiatorSupervisorApprove( )
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			// Step 1: Set up user hierarchy and permissions
			loginSuperUser(ctx);
			setUserConfig(ctx, trxName);

			// Step 2: Configure and bind the workflow to the document process
			setupWorkflow(ctx, trxName);
			updateWFProcessRef(trxName);

			// Step 3: Login as the order initiator and create a new sales order
			loginGardenUser(ctx);
			MOrder order = createOrder(ctx, trxName);

			// Step 4: Attempt to complete the order, which triggers the workflow
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Step 5: Validate that the workflow started without error
			assertFalse(info.isError(), info.getSummary());
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting approval");

			// Step 6: Login as the approver and retrieve the workflow process
			loginGardenAdmin(ctx);
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Step 7: Locate the pending approval activity
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenAdmin);
			assertNotNull(suspendedActivity, "Suspended approval step should be assigned to Garden Admin");

			// Step 8: Approve the activity
			updateActivity(suspendedActivity, gardenAdmin, true, true); // approve = true

			// Step 9: Verify that the activity is marked as completed
			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");
			order.saveEx();

			// Step 10: Reload the order and confirm its status is now 'Completed'
			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be completed.");
		}
		finally
		{
			// Step 11: Clean up any data created during the test
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Tests the rejection and rework flow in a sales order approval workflow.
	 * <p>
	 * This test simulates the scenario where:
	 * <ul>
	 * <li>A user creates and submits a sales order</li>
	 * <li>The order enters an approval workflow and is rejected by a supervisor</li>
	 * <li>The workflow routes a rework task to the appropriate responsible user</li>
	 * <li>The user completes the rework task, keeping the document in progress</li>
	 * </ul>
	 * It ensures proper workflow transitions, activity assignments, and document status.
	 * </p>
	 */
	@Test
	public void testOrderInitiatorSupervisorRework( )
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			// Configure user roles and supervisor relationships
			loginSuperUser(ctx);
			setUserConfig(ctx, trxName);

			// Set up the workflow definition and bind it to the order process
			setupWorkflow(ctx, trxName);
			updateWFProcessRef(trxName);

			// Login as the order initiator and create a sales order
			loginGardenUser(ctx);
			MOrder order = createOrder(ctx, trxName);

			// Attempt to complete the order, triggering the workflow
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Verify the workflow was triggered successfully and document is now in progress
			assertFalse(info.isError(), info.getSummary());
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting approval");

			// Login as the approver and retrieve the related workflow process
			loginGardenAdmin(ctx);
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Find the pending approval activity
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenAdmin);
			assertNotNull(suspendedActivity, "Suspended approval step should be assigned to Garden Admin");

			// Simulate rejection (rework request)
			loginGardenUser(ctx);
			updateActivity(suspendedActivity, gardenAdmin, false, true);

			// Confirm the rejection activity was completed
			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(),
							"Activity status should be Completed.");
			order.saveEx();

			// Reload and verify the document remains in progress awaiting rework
			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(MOrder.DOCSTATUS_InProgress, reloadOrder.getDocStatus(), "Order should be In Progress awaiting rework");

			// Login as the rework assignee and find the new activity
			loginGardenAdmin(ctx);
			suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenUser);
			assertNotNull(suspendedActivity, "Rework activity should be assigned to Garden User");

			// Complete the rework task
			updateActivity(suspendedActivity, null, false, false);

			// Confirm completion
			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Rework activity should be marked as Completed.");
			order.saveEx();

			// Verify document remains in progress after rework
			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(MOrder.DOCSTATUS_InProgress, reloadOrder.getDocStatus(), "Order should remain In Progress after rework completion");

		}
		finally
		{
			// Clean up test data and restore system state
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Sets the login context with the specified user, client, organization, and role.
	 *
	 * @param ctx
	 *            the context properties
	 * @param userId
	 *            the user ID to set
	 * @param clientId
	 *            the client ID to set
	 * @param orgId
	 *            the organization ID to set
	 * @param roleId
	 *            the role ID to set
	 */
	private void setLoginContext(Properties ctx, int userId, int clientId, int orgId, int roleId)
	{
		Env.setContext(ctx, Env.AD_USER_ID, userId);
		Env.setContext(ctx, Env.AD_CLIENT_ID, clientId);
		Env.setContext(ctx, Env.AD_ORG_ID, orgId);
		Env.setContext(ctx, Env.AD_ROLE_ID, roleId);
	}

	/**
	 * Simulates login for the Garden World Admin user.
	 * <p>
	 * Sets the login context using the Garden Admin's user ID,
	 * client, organization, and role defined in the system dictionary.
	 * </p>
	 *
	 * @param ctx
	 *            the application context containing environment properties
	 */
	private void loginGardenAdmin(Properties ctx)
	{
		setLoginContext(
						ctx,
						gardenAdmin.getAD_User_ID(),
						DictionaryIDs.AD_Client.GARDEN_WORLD.id,
						DictionaryIDs.AD_Org.GLOBAL.id,
						DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);
	}

	/**
	 * Simulates login for the Garden World standard user.
	 * <p>
	 * Sets the login context using the Garden User's user ID,
	 * client, fertilizer org, and standard user role defined in the dictionary.
	 * </p>
	 *
	 * @param ctx
	 *            the application context containing environment properties
	 */
	private void loginGardenUser(Properties ctx)
	{
		setLoginContext(
						ctx,
						gardenUser.getAD_User_ID(),
						DictionaryIDs.AD_Client.GARDEN_WORLD.id,
						DictionaryIDs.AD_Org.FERTILIZER.id,
						DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id);
	}

	/**
	 * Logs in as the Super User with System Administrator privileges.
	 *
	 * @param ctx
	 *            the context properties
	 */
	private void loginSuperUser(Properties ctx)
	{
		setLoginContext(ctx,
						DictionaryIDs.AD_User.SUPER_USER.id,
						DictionaryIDs.AD_Client.SYSTEM.id,
						DictionaryIDs.AD_Org.GLOBAL.id,
						DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id);
	}

	/**
	 * Updates the workflow process for the MOrder table.
	 * This method retrieves the workflow process associated with the "DocAction" column
	 * of the MOrder table and updates the workflow ID.
	 *
	 * @param trxName
	 *            the transaction name to be used for context
	 */
	private void updateWFProcessRef(String trxName)
	{
		// Retrieve the current workflow process for the given transaction
		MProcess wfProcess = getWFProcess(trxName);

		if (wfProcess != null)
		{
			// Store the original workflow ID for later restoration
			ordWFID = wfProcess.getAD_Workflow_ID();

			// Reassign the workflow process to the newly created test workflow
			wfProcess.setAD_Workflow_ID(workflow.getAD_Workflow_ID());

			// Persist the workflow process changes to the database
			wfProcess.saveEx();
		}

	}

	/**
	 * Resets the workflow definition of an existing process by updating it with a new workflow ID.
	 * <p>
	 * This method retrieves the current workflow process using
	 * {@code getWFProcess(String trxName)}.
	 * If a valid workflow process is found and a new workflow definition ID ({@code ordWFID}) is
	 * provided,
	 * it updates the process to use the new workflow and persists the change in the database.
	 * </p>
	 *
	 * @param trxName
	 *            the transaction name used for fetching and saving the workflow process
	 */
	private void resetWorkProcess(String trxName)
	{
		// Retrieve the current workflow process
		MProcess wfProcess = getWFProcess(trxName);

		// If a workflow process exists and a valid new workflow ID is defined
		if (wfProcess != null && ordWFID > 0)
		{
			// Assign the new workflow definition to this process
			wfProcess.setAD_Workflow_ID(ordWFID);

			// Save changes to the database
			wfProcess.saveEx();
		}
	}

	/**
	 * Retrieves the workflow process associated with the "DocAction" column of the MOrder table.
	 *
	 * @param trxName
	 *            the transaction name to be used for context
	 * @return the MProcess object corresponding to the "DocAction" column, or null if not found
	 */
	private MProcess getWFProcess(String trxName)
	{
		// Retrieve the MTable for MOrder using the provided transaction name
		MTable table = MTable.get(Env.getCtx(), MOrder.Table_ID, trxName);

		// Get the "DocAction" column from the table
		MColumn column = table.getColumn("DocAction");

		// Retrieve the workflow process associated with the "DocAction" column
		return (MProcess) column.getAD_Process();
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
		workflow.setName("Process_Order_Test");
		workflow.setDescription("(Standard Process Order)");
		workflow.setAD_Table_ID(MOrder.Table_ID);
		workflow.setEntityType("U");
		workflow.setWorkflowType(MWorkflow.WORKFLOWTYPE_DocumentProcess);
		workflow.setIsValid(true);
		workflow.saveEx();

		nodeAuto = createNode(workflow, "(DocAuto)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_None, trxName);
		nodeStart = createNode(workflow, "(Start)", MWFNode.ACTION_WaitSleep, null, trxName);
		nodePrepare = createNode(workflow, "(DocPrepare)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Prepare, trxName);
		nodeApprove
					= createNode(workflow, "(DocApprove)", MWFNode.ACTION_UserTask, null, responsibleSupervisor.get_ID(), MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved),
									trxName);
		nodeRework = createNode(workflow, "(DocRework)", MWFNode.ACTION_UserTask, null, responsibleInitiator.get_ID(), -1, trxName);
		nodeComplete = createNode(workflow, "(DocComplete)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Complete, trxName);

		workflow.setAD_WF_Node_ID(nodeStart.getAD_WF_Node_ID());
		workflow.saveEx();

		createTransitions(ctx, trxName);
		commit();
	}

	/**
	 * Overloaded helper method to create a workflow node without specifying a responsible ID
	 * or approval column. Defaults are used for these parameters.
	 *
	 * @param wf
	 *            The parent workflow to which the node is added
	 * @param name
	 *            The name of the node (also used as description)
	 * @param action
	 *            The action type this node performs (e.g., UserTask, SubProcess, etc.)
	 * @param docAction
	 *            An optional document action triggered by the node
	 * @param trxName
	 *            The transaction name used for persistence operations
	 * @return The newly created and saved workflow node
	 */
	private MWFNode createNode(MWorkflow wf, String name, String action, String docAction, String trxName)
	{
		return createNode(wf, name, action, docAction, -1, -1, trxName);
	}

	/**
	 * Creates a new {@link MWFNode} in the specified workflow with detailed configuration.
	 * <p>
	 * This method is used to define a node in a workflow with specific responsibilities and
	 * behavior, including document processing actions and optional approval configuration.
	 * </p>
	 *
	 * @param wf
	 *            The parent {@link MWorkflow} instance to which this node will belong
	 * @param name
	 *            The name of the workflow node (also used as its description)
	 * @param action
	 *            The type of action the node performs, such as "UserTask", "UserChoice", etc.
	 * @param docAction
	 *            Optional document action (e.g., "CO" for Complete) to execute at this node
	 * @param AD_WF_Responsible_ID
	 *            Optional ID of the responsible user or role; used for task assignment
	 * @param ApprovalColumn_ID
	 *            Optional ID of the column to be used for approval logic
	 * @param trxName
	 *            The transaction name used to maintain consistency during DB operations
	 * @return A fully initialized and persisted {@link MWFNode} instance
	 */
	private MWFNode createNode(MWorkflow wf, String name, String action, String docAction, int AD_WF_Responsible_ID, int ApprovalColumn_ID, String trxName)
	{
		// Create a new workflow node instance with provided name and use it as both name and
		// description
		MWFNode node = new MWFNode(wf, name, name);

		// Assign the node action type (mandatory)
		node.setAction(action);

		// Set document action if provided (optional)
		if (docAction != null)
		{
			node.setDocAction(docAction);
		}

		// Assign responsibility if specified
		if (AD_WF_Responsible_ID > 0)
		{
			node.setAD_WF_Responsible_ID(AD_WF_Responsible_ID);
		}

		// Assign approval column if specified
		if (ApprovalColumn_ID > 0)
		{
			node.setApprovalColumn_ID(ApprovalColumn_ID);
		}

		// Save the node to the database
		node.saveEx();

		// Return the created node for further configuration if needed
		return node;
	}

	/**
	 * Creates and configures the transitions (edges) between workflow nodes, along with conditional
	 * logic
	 * that determines which path to follow based on the document’s state (e.g., approval status).
	 * <p>
	 * The relationships define a sample workflow that progresses as follows:
	 * <ul>
	 * <li><strong>Start → Auto</strong>: Unconditional</li>
	 * <li><strong>Start → Prepare</strong>: Unconditional</li>
	 * <li><strong>Prepare → Approve</strong>: If order is not approved (IsApproved = 'N')</li>
	 * <li><strong>Approve → Complete</strong>: If approved during approval step</li>
	 * <li><strong>Approve → Rework</strong>: If not approved during approval step</li>
	 * <li><strong>Rework → Prepare</strong>: Loop back for another round of preparation</li>
	 * </ul>
	 *
	 * @param ctx
	 *            the context for DB and application access
	 * @param trxName
	 *            the current transaction name
	 */
	private void createTransitions(Properties ctx, String trxName)
	{
		// Start → Auto
		nextStartAuto = new MWFNodeNext(nodeStart, nodeAuto.getAD_WF_Node_ID());
		nextStartAuto.setSeqNo(100);
		nextStartAuto.saveEx();

		// Start → Prepare
		nextStartPrepare = new MWFNodeNext(nodeStart, nodePrepare.getAD_WF_Node_ID());
		nextStartPrepare.setSeqNo(10);
		nextStartPrepare.saveEx();

		// Prepare → Approve (only if IsApproved = 'N')
		nextPrepareApprove = new MWFNodeNext(nodePrepare, nodeApprove.getAD_WF_Node_ID());
		nextPrepareApprove.saveEx();
		conditionPrepareApprove = new MWFNextCondition(ctx, 0, trxName);
		conditionPrepareApprove.setAD_WF_NodeNext_ID(nextPrepareApprove.getAD_WF_NodeNext_ID());
		conditionPrepareApprove.setOperation(MWFNextCondition.OPERATION_Eq);
		conditionPrepareApprove.setAD_Column_ID(MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved));
		conditionPrepareApprove.setValue("N");
		conditionPrepareApprove.setSeqNo(10);
		conditionPrepareApprove.setAndOr(MWFNextCondition.ANDOR_And);
		conditionPrepareApprove.saveEx();

		// Approve → Complete (if approved)
		nextApproveComplete = new MWFNodeNext(nodeApprove, nodeComplete.getAD_WF_Node_ID());
		nextApproveComplete.saveEx();
		conditionApproveCompleted = new MWFNextCondition(ctx, 0, trxName);
		conditionApproveCompleted.setAD_WF_NodeNext_ID(nextApproveComplete.getAD_WF_NodeNext_ID());
		conditionApproveCompleted.setOperation(MWFNextCondition.OPERATION_Eq);
		conditionApproveCompleted.setAD_Column_ID(MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved));
		conditionApproveCompleted.setValue("Y");
		conditionApproveCompleted.setSeqNo(10);
		conditionApproveCompleted.setAndOr(MWFNextCondition.ANDOR_And);
		conditionApproveCompleted.saveEx();

		// Approve → Rework (if not approved)
		nextApproveRework = new MWFNodeNext(nodeApprove, nodeRework.getAD_WF_Node_ID());
		nextApproveRework.setSeqNo(100);
		nextApproveRework.saveEx();
		conditionApproveRework = new MWFNextCondition(ctx, 0, trxName);
		conditionApproveRework.setAD_WF_NodeNext_ID(nextApproveRework.getAD_WF_NodeNext_ID());
		conditionApproveRework.setOperation(MWFNextCondition.OPERATION_Eq);
		conditionApproveRework.setAD_Column_ID(MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved));
		conditionApproveRework.setValue("N");
		conditionApproveRework.setSeqNo(10);
		conditionApproveRework.setAndOr(MWFNextCondition.ANDOR_And);
		conditionApproveRework.saveEx();

		// Rework → Prepare (loop back for re-edit)
		nextReworkPrepare = new MWFNodeNext(nodeRework, nodePrepare.getAD_WF_Node_ID());
		nextReworkPrepare.saveEx();
	}

	/**
	 * Loads key users from the database using predefined dictionary-based IDs
	 * <p>
	 * This method loads user instances for  Garden Admin, and Garden User
	 * based on statically defined user IDs
	 * </p>
	 *
	 * @param ctx
	 *            the application context, usually from {@code Env.getCtx()}
	 * @param trxName
	 *            the transaction name for database operations
	 */
	private void setUserConfig(Properties ctx, String trxName)
	{
		// Instantiate key users using static dictionary-based IDs
		gardenAdmin = new MUser(ctx, DictionaryIDs.AD_User.GARDEN_ADMIN.id, trxName);
		gardenUser = new MUser(ctx, DictionaryIDs.AD_User.GARDEN_USER.id, trxName);
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
		order.setSalesRep_ID(gardenUser.getAD_User_ID());
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
	 * Finds a suspended workflow activity assigned to the specified user within a given workflow
	 * process.
	 * <p>
	 * This method scans all activities in the process and returns the first one that is in
	 * a "Suspended" state and assigned to the provided user. It is useful for workflow testing
	 * scenarios where task ownership and current state need to be validated.
	 * </p>
	 *
	 * @param ctx
	 *            The context properties
	 * @param trxName
	 *            The transaction name
	 * @param process
	 *            The workflow process containing the activities
	 * @param user
	 *            The user to whom the suspended activity should be assigned
	 * @return The suspended activity assigned to the user, or {@code null} if none is found
	 */
	private MWFActivity findSuspendedActivity(Properties ctx, String trxName, MWFProcess process, MUser user)
	{
		// Fetch all activities in the process (active only, non-completed)
		MWFActivity[] activities = process.getActivities(true, false, trxName);

		// Iterate through activities to find a suspended one assigned to the specified user
		for (MWFActivity act : activities)
		{
			if (MWFActivity.WFSTATE_Suspended.equals(act.getWFState())
				&& act.getAD_User_ID() == user.getAD_User_ID())
			{
				// Return the matching suspended activity
				return act;
			}
		}
		// No suspended activity found for this user
		return null;
	}

	/**
	 * Updates the given workflow activity by either approving or rejecting it,
	 * depending on the parameters provided.
	 * <p>
	 * If the workflow node uses a decision column (e.g., IsApproved), the decision is made
	 * using {@link MWFActivity#setUserChoice(int, String, int, String)}. Otherwise,
	 * it uses {@link MWFActivity#setUserConfirmation(int, String)} for a simple confirmation.
	 * </p>
	 * <p>
	 * After updating the activity, the method attempts to close the workflow process
	 * and asserts that no error occurred. Any exception during the update is caught and asserted
	 * null.
	 * </p>
	 *
	 * @param activity
	 *            The workflow activity to update (approve/rework)
	 * @param isApprove
	 *            True if the activity should be approved; false for rework/reject
	 * @param isWithColumn
	 *            Indicates whether the workflow node is using an approval column
	 */
	private void updateActivity(MWFActivity activity, MUser approverUser, boolean isApprove, boolean isWithColumn)
	{
		Exception exception = null;
		try
		{
			Properties ctx = activity.getCtx();

			// If the workflow node uses an approval column (e.g., IsApproved)
			if (isWithColumn)
			{
				// Set user choice to "Y" for approve or "N" for rework/reject
				activity.setUserChoice(
								approverUser.getAD_User_ID(),
								isApprove ? "Y" : "N",
								DisplayType.YesNo,
								"Unit test approval");
			}
			else
			{
				// If no approval column, just confirm the activity with a comment
				activity.setUserConfirmation(activity.getAD_User_ID(), "Unit test Reqork validation");
			}

			// Attempt to close related workflow activities
			new MWFProcess(ctx, activity.getAD_WF_Process_ID(), activity.get_TrxName())
							.checkCloseActivities(activity.get_TrxName());

			// Assert that there were no errors in the process message
			assertTrue(Util.isEmpty(activity.getProcessMsg(), true), "There is no error when approving/validation the activity.");

			// Persist the updated activity
			activity.saveEx();
		}
		catch (Exception e)
		{
			// Capture exception for assertion
			exception = e;
		}

		// Ensure no exception was thrown during approval
		assertNull(exception, "Approval should not throw an exception.");
	}

	/**
	 * Cleans up all created workflow data, nodes, transitions, and resets cache.
	 * 
	 * @param trxName
	 * @param ctx
	 */
	private void cleanup(Properties ctx, String trxName)
	{
		// Switch context back to SuperUser to perform cleanup operations
		loginSuperUser(ctx);

		// Roll back any uncommitted changes to ensure a clean state before cleanup
		rollback();

		// Reset workflow process and restore original supervisor settings for users
		resetWorkProcess(trxName);

		// Commit the reset operations
		commit();

		// Delete workflow conditions used for evaluating transitions
		deleteIfExists(
						conditionPrepareApprove, conditionPrepareComplete,
						conditionApproveCompleted, conditionApproveRework);

		// Delete workflow transitions (next steps), if they exist
		deleteIfExists(
						nextStartPrepare, nextStartAuto, nextPrepareApprove,
						nextApproveComplete, nextApproveRework, nextReworkPrepare);

		// Delete all workflow nodes (individual steps in the workflow), if they exist
		deleteIfExists(
						nodeComplete, nodeAuto, nodeApprove,
						nodePrepare, nodeRework, nodeStart);

		// Delete the workflow definition itself, if it exists
		deleteIfExists(workflow);

		// Final commit to ensure all deletions and resets are persisted
		commit();

		// Clear all application-level caches to prevent stale workflow/user state
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
