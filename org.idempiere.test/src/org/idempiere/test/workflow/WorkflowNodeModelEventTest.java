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
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Properties;

import org.adempiere.base.Core;
import org.adempiere.base.IModelValidatorFactory;
import org.adempiere.base.MappedByNameFactory;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CacheMgt;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.osgi.framework.BundleContext;

/**
 * This test class validates workflow node execution logic in the Idempiere ERP system
 * for Purchase Orders, specifically verifying behavior under model validation during
 * workflow activities such as user tasks and user choices.
 * The test simulates various workflow paths, using fake validators to enforce role-based
 * approval limits and asserting correct workflow progression and side effects on the
 * order records.
 * Key test cases:
 * - Validation fails due to insufficient approval limit.
 * - Validation passes and order updates fields as expected.
 * - User choice paths with both success and failure validations.
 * - User task paths with both success and failure validations.
 * This class is part of an automated regression test suite.
 */
public class WorkflowNodeModelEventTest extends AbstractTestCase
{

	public static final int			C_Project_ID_Standard	= 100;
	public static final BigDecimal	ApprovalAmount			= new BigDecimal(400);

	/**
	 * A mock implementation of {@link ModelValidator} used for testing workflow node
	 * execution in the context of purchase orders.
	 * This validator simulates approval checks based on a user's role approval limit,
	 * and modifies the order during the {@code TIMING_BEFORE_WF_NODE_EXECUTION} phase
	 * if the order amount is within the allowed limit.
	 * On validation success, it updates the order's description, project ID, and delivery method.
	 * On failure, it throws an {@link AdempiereUserError} to simulate a business rule violation.
	 */
	private final static class FakeModelValidator implements ModelValidator
	{

		/**
		 * Registers validator with the validation engine.
		 *
		 * @param engine
		 *            the model validation engine
		 * @param client
		 *            the ADempiere client context
		 */
		@Override
		public void initialize(ModelValidationEngine engine, MClient client)
		{
		}

		/**
		 * Returns the client ID associated with the current environment context.
		 *
		 * @return the client ID
		 */
		@Override
		public int getAD_Client_ID( )
		{
			return Env.getAD_Client_ID(Env.getCtx());
		}

		/**
		 * Called during user login. No validation performed in this mock.
		 *
		 * @param AD_Org_ID
		 *            the organization ID
		 * @param AD_Role_ID
		 *            the role ID
		 * @param AD_User_ID
		 *            the user ID
		 * @return null (no error)
		 */
		@Override
		public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID)
		{
			return null;
		}

		/**
		 * Called on model change events. This mock implementation does not perform any actions.
		 *
		 * @param po
		 *            the persistent object that changed
		 * @param type
		 *            the change type (INSERT, UPDATE, DELETE)
		 * @return null (no error)
		 */
		@Override
		public String modelChange(PO po, int type) throws Exception
		{
			return null;
		}

		/**
		 * Validates an order before workflow node execution.
		 * If the order total exceeds the approval limit, an error is thrown.
		 * Otherwise, updates the order with a description, project ID, and delivery method.
		 *
		 * @param po
		 *            the process object (expected to be {@link MWFActivity})
		 * @param timing
		 *            the validation timing constant
		 * @return null (no error if validation passes)
		 */
		@Override
		public String docValidate(PO po, int timing)
		{
			if (timing == TIMING_BEFORE_WF_NODE_EXECUTION)
			{
				MOrder order = (MOrder) ((MWFActivity) po).getPO();
				BigDecimal grandTotal = order.getGrandTotal();

				if (grandTotal.compareTo(ApprovalAmount) > 0)
				{
					throw new AdempiereUserError("Your role is not authorized to approve this order amount. Required: " + grandTotal + ", Limit: " + ApprovalAmount);
				}

				// Approval within limit — add description and update fields
				String note = "Approved within user role limit (Limit: " + ApprovalAmount + ")";
				order.setDescription(note);
				order.setC_Project_ID(C_Project_ID_Standard);
				order.setDeliveryViaRule(MOrder.DELIVERYVIARULE_Shipper);
				order.saveEx();
			}
			return null;
		}
	}

	/**
	 * A factory for producing instances of the {@link FakeModelValidator}
	 * using a name-to-class mapping strategy.
	 * This factory is used to register the fake validator during testing to simulate
	 * validation logic in a controlled environment.
	 */
	private final static class MyModelValidatorFactory extends MappedByNameFactory <ModelValidator>
					implements IModelValidatorFactory
	{

		/**
		 * Constructs the validator factory and registers the mapping between
		 * the validator class name and its instantiation logic.
		 */
		public MyModelValidatorFactory()
		{
			addMapping(FakeModelValidator.class.getName(), ( ) -> new FakeModelValidator());
		}

		/**
		 * Returns a new instance of a model validator by class name.
		 *
		 * @param className
		 *            the fully qualified class name of the validator
		 * @return a new instance of the validator
		 */
		@Override
		public ModelValidator newModelValidatorInstance(String className)
		{
			return newInstance(className);
		}
	}

	private MWorkflow	workflow;
	private MWFNode		nodeStart, nodePrepare, nodeVarActionNode, nodeAuto, nodeComplete;
	private MWFNodeNext	nextStartPrepare, nextStartAuto, nextPrepareApprove, nextValidateComplete, nextPrepareComplete;
	private MUser		gardenUser, gardenAdmin;
	private int			ordWFID;

	/**
	 * Tests that a workflow with a User Task node throws an error
	 * when the user does not have the required approval limit for the order amount.
	 */
	@Test
	public void testUserTaskException( )
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

			// simulate osgi component service
			loadModelValidator();

			// Create an purchase order for testing and trigger the workflow
			MOrder order = createPurchaseOrder(ctx, new BigDecimal("450"), trxName);

			// Run the document action (complete the order) and save it
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Verify that there is no error in the process
			assertFalse(info.isError(), info.getSummary());

			// Reload the order and assert that its status is "InProgress" awaiting validation
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");

			// Login as Garden Admin
			loginGardenAdmin(ctx);

			// Fetch the workflow process associated with the order
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Find the suspended activity assigned to the Garden User for validation
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenUser);
			assertNotNull(suspendedActivity, "Suspended Validation activity should be assigned to Garden User");

			// Update the activity to simulate the Garden User completing the task
			updateActivity(suspendedActivity, gardenUser, true, true);
		}
		finally
		{
			// Clean up the context and transaction after test execution
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Tests that a workflow with a User Task node completes successfully
	 * when the order amount is within the user's approval limit.
	 * Also verifies the model validator updates certain fields on the order.
	 */
	@Test
	public void testUserTaskSuccess( )
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

			// simulate osgi component service
			loadModelValidator();

			// Create an purchase order for testing and trigger the workflow
			MOrder order = createPurchaseOrder(ctx, new BigDecimal("20"), trxName);

			// Run the document action (complete the order) and save it
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Verify that there is no error in the process
			assertFalse(info.isError(), info.getSummary());

			// Reload the order and assert that its status is "InProgress" awaiting validation
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");

			// Login as Garden Admin
			loginGardenAdmin(ctx);

			// Fetch the workflow process associated with the order
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Find the suspended activity assigned to the Garden User for validation
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenUser);
			assertNotNull(suspendedActivity, "Suspended Validation activity should be assigned to Garden User");

			// Update the activity to simulate the Garden User completing the task
			updateActivity(suspendedActivity, gardenUser, true, false);

			// Assert that the activity state changes to "Completed"
			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");

			// reload order
			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			validateOrderFields(reloadOrder);

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
	 * Tests the behavior of a User Choice workflow where the validation fails
	 * due to approval limit, simulating an error scenario.
	 */
	@Test
	public void testUserChoiceException( )
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

			// simulate osgi component service
			loadModelValidator();

			// Create a new purchase order and complete it, which triggers workflow
			MOrder order = createPurchaseOrder(ctx, new BigDecimal("450"), trxName);
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Ensure no error occurred in starting the workflow
			assertFalse(info.isError(), info.getSummary());

			// Reload the order and confirm its status is "In Progress" (awaiting task completion)
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");

			// Login as Garden Admin
			loginGardenAdmin(ctx);

			// Retrieve the workflow process instance tied to the order
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Locate the suspended user task activity assigned to Garden User
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenAdmin);
			assertNotNull(suspendedActivity, "Suspended user task validate should be assigned to Garden Admin");

			// Complete the suspended activity as Garden User
			updateActivity(suspendedActivity, gardenAdmin, true, true);

		}
		finally
		{
			// Cleanup test data and reset transaction
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Tests that a workflow with a User Choice node completes successfully
	 * when the order amount is within the approval limit and fields are updated as expected.
	 */
	@Test
	public void testUserChoiceSuccess( )
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

			// simulate osgi component service
			loadModelValidator();

			// Create a new purchase order and complete it, which triggers workflow
			MOrder order = createPurchaseOrder(ctx, new BigDecimal("20"), trxName);
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			// Ensure no error occurred in starting the workflow
			assertFalse(info.isError(), info.getSummary());

			// Reload the order and confirm its status is "In Progress" (awaiting task completion)
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");

			// Login as Garden Admin
			loginGardenAdmin(ctx);

			// Retrieve the workflow process instance tied to the order
			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			// Locate the suspended user task activity assigned to Garden User
			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, gardenAdmin);
			assertNotNull(suspendedActivity, "Suspended user task validate should be assigned to Garden Admin");

			// Complete the suspended activity as Garden User
			updateActivity(suspendedActivity, gardenAdmin, true, false);

			// Assert that the activity state changes to "Completed"
			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");

			// reload order
			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			validateOrderFields(reloadOrder);

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
	 * Loads and registers a custom model validator for testing.
	 * The validator checks the approval limit before workflow node execution
	 * and modifies the order if the limit is met.
	 */
	private void loadModelValidator( )
	{
		BundleContext bc = TestActivator.context;
		Dictionary <String, Object> properties = new Hashtable <String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IModelValidatorFactory.class, new MyModelValidatorFactory(), properties);

		properties = new Hashtable <String, Object>();
		properties.put("service.ranking", Integer.valueOf(10));
		bc.registerService(ModelValidator.class, new FakeModelValidator(), properties);

		var validator = Core.getModelValidator(FakeModelValidator.class.getName());
		ModelValidationEngine.get().addDocValidate(MOrder.Table_Name, validator);
		assertNotNull(validator);
		assertTrue(validator instanceof FakeModelValidator, "validator not instanceof MyModelValidator. validator=" + validator.getClass().getName());
	}

	/**
	 * Validates that specific order fields are updated correctly by the validator.
	 *
	 * @param order
	 *            the order to validate
	 */
	private void validateOrderFields(MOrder order)
	{
		String expectedNote = "Approved within user role limit (Limit: " + ApprovalAmount + ")";
		assertEquals(expectedNote, order.getDescription(), "Order description not updated correctly");
		// Assert project ID was set correctly
		assertEquals(C_Project_ID_Standard, order.getC_Project_ID(), "Project ID not updated correctly");
		// Assert delivery rule was set correctly
		assertEquals(MOrder.DELIVERYVIARULE_Shipper, order.getDeliveryViaRule(), "DeliveryViaRule not updated correctly");
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

		workflow.setAD_WF_Node_ID(nodeStart.getAD_WF_Node_ID());
		workflow.saveEx();

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
			node.setDocAction(docAction);

		if (MWFNode.ACTION_UserChoice.equalsIgnoreCase(action) || MWFNode.ACTION_UserTask.equalsIgnoreCase(action))
			node.setAD_Column_ID(MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved));

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
	private MOrder createPurchaseOrder(Properties ctx, BigDecimal price, String trxName)
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
		line.setPrice(price);
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

	private void updateActivity(MWFActivity activity, MUser user, boolean isApprove, boolean isErrorThrown)
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
		if (isErrorThrown)
			assertNotNull(exception, "Expected an exception during validation, but none was thrown.");
		else
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
		resetModelValidator(ctx);
		loginSuperUser(ctx);
		rollback();
		resetWorkflowProcess(trxName);
		commit();
		deleteIfExists(nextStartPrepare, nextStartAuto, nextPrepareApprove, nextValidateComplete, nextPrepareComplete);
		deleteIfExists(nodeComplete, nodeAuto, nodeVarActionNode, nodePrepare, nodeStart);
		deleteIfExists(workflow);
		commit();
		CacheMgt.get().reset();
	}

	private void resetModelValidator(Properties ctx)
	{
		loginGardenUser(ctx);
		var validator = Core.getModelValidator(FakeModelValidator.class.getName());
		ModelValidationEngine.get().removeDocValidate(MOrder.Table_Name, validator);
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
