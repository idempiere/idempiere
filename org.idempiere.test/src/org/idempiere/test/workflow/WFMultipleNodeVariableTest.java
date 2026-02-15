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
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWFNodeVar;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Unit test class for simulating and validating the execution of a document
 * Purchase Order workflow.
 * <p>
 * This test suite focuses on different user task configurations within workflows
 * tied to the {@link MOrder} document, including:
 * </p>
 * <ul>
 * <li>Tasks assigned based on a custom column (e.g., IsApproved)</li>
 * <li>Tasks assigned via a responsible user (workflow responsible setup)</li>
 * <li>Tasks assigned directly to a login user (e.g., Garden User)</li>
 * </ul>
 * <p>
 * Key scenarios include:
 * <ul>
 * <li>Validating custom column assignment behavior</li>
 * <li>Ensuring responsible-user assignments are honored in workflows</li>
 * <li>Simulating user task completion and document lifecycle progression</li>
 * </ul>
 * </p>
 */
public class WFMultipleNodeVariableTest extends AbstractTestCase
{

	private static final String	Description_VALUE		= "Sample description used in unit tests to validate order data";
	private static final String	C_Project_ID_Standard	= String.valueOf(100);
	private static final String	IsDiscountPrinted_No	= "N";
	private MWorkflow			workflow;
	private MWFNode				nodeStart, nodePrepare, nodeVarActionNode, nodeAuto, nodeComplete;
	private MWFNodeVar			descNodeVar, projectNodeVar, discountNodeVar;
	private MWFNodeNext			nextStartPrepare, nextStartAuto, nextPrepareApprove, nextValidateComplete, nextPrepareComplete;
	private MUser				gardenUser, gardenAdmin;
	private int					ordWFID;

	/**
	 * Test case for processing an Purchase order workflow with a user task with custom column.
	 * <p>
	 * This test simulates the creation of an Purchase order, the completion of a document action
	 * (e.g., completing the Purchase order),
	 * and the workflow activities that require user validation. The test specifically includes
	 * handling
	 * a custom column task in the workflow.
	 * </p>
	 * <p>
	 * The workflow will be set up with a suspended validation activity that needs to be completed
	 * by the user
	 * assigned to the task. The test verifies that the order's document status transitions
	 * correctly through the
	 * workflow process.
	 * </p>
	 * 
	 * @throws Exception
	 *             if there are issues during setup, execution, or validation of the workflow
	 */
	@Test
	public void testMultipleVariablesOnUserTask( )
	{
		// Get the current context and transaction name
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			// Log in as a superuser to perform necessary setup actions
			loginSuperUser(ctx);

			// Configure static users (Garden Admin, Garden User, etc.)
			setUserConfig(ctx, trxName);

			// Set up the workflow environment
			setupWorkflow(ctx, MWFNode.ACTION_UserTask, trxName);

			// Update the workflow process reference for the current transaction
			updateWFProcessRef(trxName);

			// Log in as the Garden User (the user who will validate the order)
			loginGardenUser(ctx);

			// Create an purchase order for testing and trigger the workflow
			MOrder order = createPurchaseOrder(ctx, trxName);

			// Run the document action (complete the order) and save it
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Verify that there is no error in the process
			assertFalse(info.isError(), info.getSummary());

			// Reload the order and assert that its status is "InProgress" awaiting validation
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");
			
	        // Validate order fields updated by Set Variable node
			validateOrderFields(reloadOrder);

			// Login as Garden Admin
			loginGardenAdmin(ctx);

			// Fetch the workflow process associated with the order
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Find the suspended activity assigned to the Garden User for validation
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenUser);
			assertNotNull(suspendedActivity, "Suspended Validation activity should be assigned to Garden User");

			// Update the activity to simulate the Garden User completing the task
			updateActivity(suspendedActivity, gardenUser, true);

			// Assert that the activity state changes to "Completed"
			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");

			// reload order
			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);

			// Verify that the order has been completed
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be Completed.");
		}
		finally
		{
			// Clean up the context and transaction after test execution
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Test case for executing a user task in a workflow where the user assignment and updated a
	 * custom column.
	 * <p>
	 * This test validates the correct behavior of a workflow that assigns a user task directly
	 * to a predefined user (Garden User) and ensures the task completes successfully.
	 * It verifies that:
	 * <ul>
	 * <li>The order enters the "In Progress" state upon workflow initiation.</li>
	 * <li>The user task is suspended and assigned to Garden User.</li>
	 * <li>The task completes without error.</li>
	 * <li>The order moves to the "Completed" state afterward.</li>
	 * </ul>
	 * </p>
	 */
	@Test
	public void testMultipleVariablesOnUserChoice( )
	{
		// Initialize application context and transaction name
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			// Login as Super User to setup the workflow and related configuration
			loginSuperUser(ctx);

			// Configure static users (Garden Admin, Garden User, etc.)
			setUserConfig(ctx, trxName);

			// Setup the workflow without column-based assignment
			setupWorkflow(ctx, MWFNode.ACTION_UserChoice, trxName);

			// Update workflow process reference in system config
			updateWFProcessRef(trxName);

			// Login as the document initiator (Garden User)
			loginGardenUser(ctx);

			// Create a new purchase order and complete it, which triggers workflow
			MOrder order = createPurchaseOrder(ctx, trxName);
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Ensure no error occurred in starting the workflow
			assertFalse(info.isError(), info.getSummary());

			// Reload the order and confirm its status is "In Progress" (awaiting task completion)
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");
			
	        // Validate order fields updated by Set Variable node
			validateOrderFields(reloadOrder);

			// Login as Garden Admin
			loginGardenAdmin(ctx);

			// Retrieve the workflow process instance tied to the order
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Locate the suspended user task activity assigned to Garden User
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenAdmin);
			assertNotNull(suspendedActivity, "Suspended user task validate should be assigned to Garden Admin");

			// Complete the suspended activity as Garden User
			updateActivity(suspendedActivity, gardenAdmin, true);

			// Assert that the activity state changes to "Completed"
			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");

			// reload order
			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);

			// Verify that the order has been completed
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be Completed.");

		}
		finally
		{
			// Cleanup test data and reset transaction
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Test case to validate workflow behavior when multiple variables are set using the Set
	 * Variable node.
	 * <p>
	 * This test performs the following steps:
	 * <ul>
	 * <li>Initializes application context and transaction</li>
	 * <li>Logs in as Super User to configure workflow environment</li>
	 * <li>Sets up a workflow with an "Set Variable" action node</li>
	 * <li>Creates and completes a purchase order to trigger the workflow</li>
	 * <li>Asserts that the workflow processes correctly and updates the order as expected</li>
	 * <li>Validates order fields that are modified via node variables</li>
	 * </ul>
	 * <p>
	 * The test ensures that multiple node variables are processed correctly and reflected in the
	 * order fields.
	 */
	@Test
	public void testMultipleVariablesOnSetVariable( )
	{
		// Initialize application context and transaction name
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			// Login as Super User to setup the workflow and related configuration
			loginSuperUser(ctx);

			// Configure static users (Garden Admin, Garden User, etc.)
			setUserConfig(ctx, trxName);

			// Setup the workflow without column-based assignment
			setupWorkflow(ctx, MWFNode.ACTION_SetVariable, trxName);

			// Update workflow process reference in system config
			updateWFProcessRef(trxName);

			// Login as the document initiator (Garden User)
			loginGardenUser(ctx);

			// Create a new purchase order and complete it, which triggers workflow
			MOrder order = createPurchaseOrder(ctx, trxName);
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Ensure no error occurred in starting the workflow
			assertFalse(info.isError(), info.getSummary());

	        // Reload the order and confirm its status is "Completed"
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be Completed.");
			assertTrue(order.isApproved(), "Order should be approved");
	        // Validate order fields updated by Set Variable node
			validateOrderFields(reloadOrder);
		}
		finally
		{
			// Cleanup test data and reset transaction
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Validates specific fields of the given order using different types of value tests:
	 * <ul>
	 * <li>Text value test: Verifies the order description matches the expected description.</li>
	 * <li>Reference value test: Checks that the project ID is correctly set to the standard project
	 * ID.</li>
	 * <li>Yes/No value test: Ensures that the discount flag is not printed on the order.</li>
	 * </ul>
	 *
	 * @param order
	 *            The order object to validate.
	 */
	public void validateOrderFields(MOrder order)
	{
		// Verify the description matches the expected value (Text value test)
		assertTrue(Description_VALUE.equals(order.getDescription()), "Order description does not match the expected value.");
		// Verify the project ID is correctly set to the standard ID (Reference value test)
		assertEquals(C_Project_ID_Standard, String.valueOf(order.getC_Project_ID()), "Expected project ID: " + C_Project_ID_Standard + ", but found: " + order.getC_Project_ID());
		// Verify that the discount is not printed on the order (Yes/No value test)
		assertFalse(order.isDiscountPrinted(), "Discount should not be printed on the order.");
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
	 * Updates the workflow process for the MOrder table.
	 * This method retrieves the workflow process associated with the "DocAction" column
	 * of the MOrder table and updates the workflow ID.
	 *
	 * @param trxName
	 *            the transaction name to be used for context
	 */
	private void updateWFProcessRef(String trxName)
	{
		MProcess wfProcess = getWFProcess(trxName);
		if (wfProcess != null)
		{
			ordWFID = wfProcess.getAD_Workflow_ID();
			wfProcess.setAD_Workflow_ID(workflow.getAD_Workflow_ID());
			wfProcess.saveEx();
		}
	}

	/**
	 * Updates the workflow process for the MOrder table and sets the supervisor for Carl Boss.
	 * This method performs two tasks:
	 * 1. Reset the workflow ID for the process associated with the "DocAction" column of the
	 * MOrder table.
	 * 2. Reset the supervisor ID for Carl Boss and saves the changes.
	 *
	 * @param trxName
	 *            the transaction name to be used for context
	 */
	private void resetWorkflowProcess(String trxName)
	{
		MProcess wfProcess = getWFProcess(trxName);
		if (wfProcess != null && ordWFID > 0)
		{
			wfProcess.setAD_Workflow_ID(ordWFID);
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
	private void setupWorkflow(Properties ctx, String nodeDocAction, String trxName)
	{
		workflow = new MWorkflow(ctx, 0, trxName);
		workflow.setName("Purchase_UserTask_Test");
		workflow.setDescription("(Purchase Order)");
		workflow.setAD_Table_ID(MOrder.Table_ID);
		workflow.setEntityType("U");
		workflow.setWorkflowType(MWorkflow.WORKFLOWTYPE_DocumentProcess);
		workflow.setIsValid(true);
		workflow.saveEx();

		nodeStart = createNode(workflow, "(Start)", MWFNode.ACTION_WaitSleep, null, trxName);
		nodePrepare = createNode(workflow, "(DocPrepare)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Prepare, trxName);
		nodeVarActionNode = createNode(workflow, "(DocVar)", nodeDocAction, null, trxName);
		nodeAuto = createNode(workflow, "(DocAuto)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_None, trxName);
		nodeComplete = createNode(workflow, "(DocComplete)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Complete, trxName);

		descNodeVar = createNodeVar(ctx, nodeVarActionNode, MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_Description), Description_VALUE, trxName);
		projectNodeVar = createNodeVar(ctx, nodeVarActionNode, MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_C_Project_ID), C_Project_ID_Standard, trxName);
		discountNodeVar = createNodeVar(ctx, nodeVarActionNode, MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsDiscountPrinted), IsDiscountPrinted_No, trxName);

		workflow.setAD_WF_Node_ID(nodeStart.getAD_WF_Node_ID());
		workflow.saveEx();

		createTransitions();
		commit();
	}

	/**
	 * Creates and persists a {@link MWFNodeVar} instance associated with a given workflow node.
	 * <p>
	 * This helper method sets up a workflow node variable, linking it to a specific column,
	 * value, and workflow node ID.
	 * </p>
	 *
	 * @param ctx
	 *            the {@link Properties} context, typically the system context (Env.getCtx())
	 * @param node
	 *            the {@link MWFNode} to associate the variable with
	 * @param adcolumnID
	 *            the ID of the column ({@code AD_Column_ID}) to bind the variable to
	 * @param value
	 *            the attribute value to assign to the variable
	 * @param trxName
	 *            the transaction name used for saving the variable
	 * @return the created and saved {@link MWFNodeVar} instance
	 */
	private MWFNodeVar createNodeVar(Properties ctx, MWFNode node, int adcolumnID, String value, String trxName)
	{
		MWFNodeVar nodeVar = new MWFNodeVar(ctx, 0, trxName);
		nodeVar.setAD_Column_ID(adcolumnID);
		nodeVar.setAttributeValue(value);
		nodeVar.setAD_WF_Node_ID(node.getAD_WF_Node_ID());
		nodeVar.saveEx();
		return nodeVar;
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
			node.setDocAction(docAction);

		if (MWFNode.ACTION_UserChoice.equalsIgnoreCase(action) || MWFNode.ACTION_SetVariable.equalsIgnoreCase(action) || MWFNode.ACTION_UserTask.equalsIgnoreCase(action))
			node.setAD_Column_ID(MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved));
		if (MWFNode.ACTION_SetVariable.equalsIgnoreCase(action))
			node.setAttributeValue("Y");

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
		nextPrepareApprove = new MWFNodeNext(nodePrepare, nodeVarActionNode.getAD_WF_Node_ID());
		nextPrepareApprove.saveEx();
		nextValidateComplete = new MWFNodeNext(nodeVarActionNode, nodeComplete.getAD_WF_Node_ID());
		nextValidateComplete.saveEx();
	}

	/**
	 * Initializes and configures test user instances using predefined static dictionary-based user
	 * IDs.
	 * <p>
	 * This method loads the following users from the database and assigns them to instance
	 * variables:
	 * </p>
	 * <ul>
	 * <li><strong>gardenAdmin</strong> – A user with administrative privileges, typically acting as
	 * the supervisor</li>
	 * <li><strong>gardenUser</strong> – A regular user who usually serves as the workflow
	 * initiator</li>
	 * </ul>
	 * 
	 * @param ctx
	 *            the context properties used for environment configuration
	 * @param trxName
	 *            the name of the transaction, or {@code null} if not within a transaction
	 */
	private void setUserConfig(Properties ctx, String trxName)
	{
		// Instantiate key users using static dictionary-based IDs
		gardenUser = new MUser(ctx, DictionaryIDs.AD_User.GARDEN_USER.id, trxName);
		gardenAdmin = new MUser(ctx, DictionaryIDs.AD_User.GARDEN_ADMIN.id, trxName);
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
	private MOrder createPurchaseOrder(Properties ctx, String trxName)
	{
		MOrder order = new MOrder(ctx, 0, trxName);
		order.setIsSOTrx(false);
		order.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setDateOrdered(TimeUtil.getDay(System.currentTimeMillis()));
		order.setDatePromised(TimeUtil.getDay(System.currentTimeMillis()));
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_USER.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.setIsDiscountPrinted(true);
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
	 * Finds the first suspended workflow activity assigned to the specified user
	 * within the given workflow process.
	 *
	 * @param ctx
	 *            the context properties
	 * @param trxName
	 *            the transaction name
	 * @param process
	 *            the workflow process to search for activities
	 * @param assignUser
	 *            the user to whom the activity should be assigned
	 * @return the first {@link MWFActivity} that is in the suspended state and assigned to
	 *         {@code assignUser},
	 *         or {@code null} if no such activity is found
	 */
	private MWFActivity findSuspendedActivity(Properties ctx, String trxName, MWFProcess process, MUser assignUser)
	{
		MWFActivity[] activities = process.getActivities(true, false, trxName);

		for (MWFActivity act : activities)
		{
			if (MWFActivity.WFSTATE_Suspended.equals(act.getWFState())
				&& act.getAD_User_ID() == assignUser.getAD_User_ID())
			{
				return act;
			}
		}
		return null;
	}

	/**
	 * Updates the activity Validate with or without column config.
	 *
	 * @param activity
	 *            workflow activity
	 * @param user
	 */
	private void updateActivity(MWFActivity activity, MUser user, boolean isApprove)
	{
		Exception exception = null;
		try
		{
			Properties ctx = activity.getCtx();

			activity.setUserChoice(user.getAD_User_ID(), isApprove ? "Y" : "N", DisplayType.YesNo, "Unit test validate against budget");
			new MWFProcess(ctx, activity.getAD_WF_Process_ID(), activity.get_TrxName())
							.checkCloseActivities(activity.get_TrxName());
			assertTrue(Util.isEmpty(activity.getProcessMsg(), true), "There is no error when validate the activity.");
			activity.saveEx();
		}
		catch (Exception e)
		{
			exception = e;
		}
		assertNull(exception, "validate should not throw an exception.");
	}

	/**
	 * Cleans up all created workflow data, nodes, transitions, and resets cache.
	 * 
	 * @param trxName
	 * @param ctx
	 */
	private void cleanup(Properties ctx, String trxName)
	{
		loginSuperUser(ctx);
		rollback();
		resetWorkflowProcess(trxName);
		commit();
		deleteIfExists(descNodeVar, projectNodeVar, discountNodeVar);
		deleteIfExists(nextStartPrepare, nextStartAuto, nextPrepareApprove, nextValidateComplete, nextPrepareComplete);
		deleteIfExists(nodeComplete, nodeAuto, nodeVarActionNode, nodePrepare, nodeStart);
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
			if (record != null && record.get_ID() >= 0)
			{
				record.delete(true);
			}
		}
	}

}
