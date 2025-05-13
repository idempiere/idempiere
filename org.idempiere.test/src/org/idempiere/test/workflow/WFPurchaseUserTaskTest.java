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
import org.compiere.model.MUserRoles;
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
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWFResponsible;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class WFPurchaseUserTaskTest extends AbstractTestCase
{

	private MWorkflow		workflow;
	private MWFNode			nodeStart, nodePrepare, nodeValidate, nodeAuto, nodeComplete;
	private MWFResponsible	jsValResponsible;
	private MUser			carlBoss, joeSales;
	private MWFNodeNext		nextStartPrepare, nextStartAuto, nextPrepareApprove, nextValidateComplete, nextPrepareComplete;
	private MUserRoles		cbUserRoles, jsUserRoles, jsAdminUserRoles;
	private int				ordWFID;
	private boolean			isWithColumn	= false;

	/**
	 * Test case for user task workflow with the `isWithColumn` flag set to true.
	 * This test simulates a workflow process where:
	 * - A super user logs in and sets up a workflow.
	 * - A document (purchase order) is created and submitted for Validate.
	 * - The document remains in progress awaiting Validate from a user.
	 * - The approval step is found and programmatically completed.
	 * - The document is verified to be marked as completed.
	 * Validations include:
	 * - Workflow process creation.
	 * - Suspended activity assigned correctly.
	 * - Activity completion results in a completed document status.
	 */
	@Test
	public void testUserTaskWithColumn( )
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			isWithColumn = true;
			// Switch context to SuperUser
			loginSuperUser(ctx);

			setupWorkflow(ctx, trxName);
			setUserConfig(ctx, trxName);
			updateWFProcessRef(trxName);

			// Switch context to carl Boss
			loginCarlBoss(ctx);

			MOrder order = createOrder(ctx, trxName);

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			assertFalse(info.isError(), info.getSummary());
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");

			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, carlBoss);
			assertNotNull(suspendedActivity, "Suspended Validation activity should be assigned to Carl Boss");

			updateActivity(suspendedActivity, carlBoss);

			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");
			order.saveEx();

			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be Completed.");
		}
		finally
		{
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Test case for user task workflow with the `isWithColumn` flag set to false,
	 * where the workflow activity is assigned via the Responsible setting (not a column).
	 *
	 * This test simulates:
	 * - Workflow setup with the responsible user configuration enabled.
	 * - An order created and submitted for completion.
	 * - The workflow activity being assigned to a responsible user (`joeSales`) instead of via a column.
	 * - The responsible user (`joeSales`) completing the suspended activity.
	 * - Verifying that the document status is correctly updated to "Completed".
	 *
	 * Validations include:
	 * - Workflow and activity creation.
	 * - Proper assignment of the activity to `joeSales` based on responsibility.
	 * - Activity completion and final document state transition.
	 */
	@Test
	public void testUserTaskResponsibleWithoutColumn( )
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			isWithColumn = false;
			setUserConfig(ctx, trxName);

			// Switch context to Joe Sales
			loginSuperUser(ctx);

			setupWorkflow(ctx, trxName, true);
			updateWFProcessRef(trxName);

			// Switch context to carl Boss
			loginCarlBoss(ctx);

			MOrder order = createOrder(ctx, trxName);

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			assertFalse(info.isError(), info.getSummary());
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");

			// Switch context to Joe Sales
			loginJoeSales(ctx);

			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, joeSales);
			assertNotNull(suspendedActivity, "Suspended user task Validate should be assigned to joe Sales");

			updateActivity(suspendedActivity, joeSales);

			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");
			order.saveEx();

			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be Completed.");
		}
		finally
		{
			cleanup(ctx, trxName);
		}
	}

	/**
	 * Test case for user task workflow with the `isWithColumn` flag set to false.
	 * This test is similar to {@link #testUserTaskWithColumn()} but evaluates the workflow
	 * when additional user task-related configuration (the column setting) is disabled.
	 * Steps include:
	 * - Workflow setup and submission with `isWithColumn` false.
	 * - Document creation and execution of the associated workflow.
	 * - Verification that workflow and activity behave as expected even without the column setting.
	 * Validations include:
	 * - Workflow and activity creation.
	 * - Proper suspension and reactivation of activity.
	 * - Final document completion status check.
	 */
	@Test
	public void testUserTaskWithoutColumn( )
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		try
		{
			isWithColumn = false;
			// Switch context to SuperUser
			loginSuperUser(ctx);

			setupWorkflow(ctx, trxName);
			setUserConfig(ctx, trxName);
			updateWFProcessRef(trxName);

			// Switch context to carl Boss
			loginCarlBoss(ctx);

			MOrder order = createOrder(ctx, trxName);

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			order.saveEx();

			assertFalse(info.isError(), info.getSummary());
			MOrder reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertEquals(DocAction.STATUS_InProgress, reloadOrder.getDocStatus(), "Document should be in progress awaiting Validate");

			MWFProcess process = fetchWorkflowProcess(ctx, trxName, order.get_ID());
			assertNotNull(process, "Workflow process should exist");

			MWFActivity suspendedActivity = findSuspendedActivity(ctx, trxName, process, carlBoss);
			assertNotNull(suspendedActivity, "Suspended user task validate should be assigned to  Carl Boss");

			updateActivity(suspendedActivity, carlBoss);

			assertEquals(MWFActivity.WFSTATE_Completed, suspendedActivity.getWFState(), "Activity status should be completed.");
			order.saveEx();

			reloadOrder = new MOrder(ctx, order.getC_Order_ID(), trxName);
			assertTrue(MOrder.DOCSTATUS_Completed.equals(reloadOrder.getDocStatus()), "Order should be completed.");
		}
		finally
		{
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
	 * Logs in as Joe Sales with GardenWorld Admin privileges.
	 *
	 * @param ctx
	 *            the context properties
	 */
	private void loginJoeSales(Properties ctx)
	{
		setLoginContext(ctx,
						joeSales.getAD_User_ID(),
						DictionaryIDs.AD_Client.GARDEN_WORLD.id,
						DictionaryIDs.AD_Org.GLOBAL.id,
						DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);
	}

	/**
	 * Logs in as Carl Boss with GardenWorld User privileges for the Fertilizer organization.
	 *
	 * @param ctx
	 *            the context properties
	 */
	private void loginCarlBoss(Properties ctx)
	{
		setLoginContext(ctx,
						carlBoss.getAD_User_ID(),
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
		if (wfProcess != null)
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
	private void setupWorkflow(Properties ctx, String trxName)
	{
		setupWorkflow(ctx, trxName, false);
	}

	/**
	 * Sets up the dynamic workflow and creates required nodes and transitions.
	 *
	 * @param ctx
	 *            application context
	 * @param trxName
	 *            transaction name
	 * @param isAddResponsible
	 */
	private void setupWorkflow(Properties ctx, String trxName, boolean isAddResponsible)
	{
		workflow = new MWorkflow(ctx, 0, trxName);
		workflow.setName("Purchase_UserTask_Test");
		workflow.setDescription("(Purchase Order)");
		workflow.setAD_Table_ID(MOrder.Table_ID);
		workflow.setEntityType("U");
		workflow.setWorkflowType(MWorkflow.WORKFLOWTYPE_DocumentProcess);
		workflow.setIsValid(true);
		workflow.saveEx();

		if (isAddResponsible)
			jsValResponsible = createResponsible(ctx, trxName);

		nodeStart = createNode(workflow, "(Start)", MWFNode.ACTION_WaitSleep, null, trxName);
		nodePrepare = createNode(workflow, "(DocPrepare)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Prepare, trxName);
		nodeValidate = createNode(workflow, "(DocValidate)", MWFNode.ACTION_UserTask, null, trxName);
		nodeAuto = createNode(workflow, "(DocAuto)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_None, trxName);
		nodeComplete = createNode(workflow, "(DocComplete)", MWFNode.ACTION_DocumentAction, MWFNode.DOCACTION_Complete, trxName);

		workflow.setAD_WF_Node_ID(nodeStart.getAD_WF_Node_ID());
		workflow.saveEx();

		createTransitions();
		commit();
	}

	private MWFResponsible createResponsible(Properties ctx, String trxName)
	{
		MWFResponsible jsValResponsible = new MWFResponsible(ctx, 0, trxName);
		jsValResponsible.setName("Validator");
		jsValResponsible.setEntityType("U");
		jsValResponsible.setResponsibleType(MWFResponsible.RESPONSIBLETYPE_Human);
		jsValResponsible.setAD_User_ID(joeSales.getAD_User_ID());
		jsValResponsible.saveEx();
		return jsValResponsible;
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
		if (MWFNode.ACTION_UserTask.equalsIgnoreCase(action))
		{
			if (isWithColumn)
				node.setAD_Column_ID(MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_IsApproved));
			if (jsValResponsible != null && jsValResponsible.getAD_WF_Responsible_ID() > 0)
				node.setAD_WF_Responsible_ID(jsValResponsible.getAD_WF_Responsible_ID());
		}
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
		nextPrepareApprove = new MWFNodeNext(nodePrepare, nodeValidate.getAD_WF_Node_ID());
		nextPrepareApprove.saveEx();
		nextValidateComplete = new MWFNodeNext(nodeValidate, nodeComplete.getAD_WF_Node_ID());
		nextValidateComplete.saveEx();
	}

	/**
	 * Assigns a supervisor to Carl Boss and updates the user roles for both Joe Sales and Carl
	 * Boss.
	 * This method performs the following tasks:
	 * 1. Creates user roles for Joe Sales and assigns the "Garden World Admin" role.
	 * 2. Creates user roles for Carl Boss and assigns the "Garden World User" role.
	 * 3. Sets Joe Sales as the supervisor for Carl Boss and saves the changes.
	 * 4. Commits the transaction to persist changes.
	 *
	 * @param ctx
	 *            the context properties for the operation
	 * @param trxName
	 *            the transaction name for the operation
	 */
	private void setUserConfig(Properties ctx, String trxName)
	{

		// Create and assign role to Joe Sales
		joeSales = new MUser(ctx, 103, trxName);
		jsUserRoles = new MUserRoles(ctx, joeSales.getAD_User_ID(), DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id, trxName);
		jsUserRoles.saveEx();
		jsAdminUserRoles = new MUserRoles(ctx, joeSales.getAD_User_ID(), DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id, trxName);
		jsAdminUserRoles.saveEx();

		// Create and assign role to Carl Boss
		carlBoss = new MUser(ctx, 104, trxName);
		cbUserRoles = new MUserRoles(ctx, carlBoss.getAD_User_ID(), DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id, trxName);
		cbUserRoles.saveEx();

		// Commit the transaction to save the changes
		commit();
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
		order.setIsSOTrx(false);
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
	private void updateActivity(MWFActivity activity, MUser user)
	{
		Exception exception = null;
		try
		{
			Properties ctx = activity.getCtx();

			if (isWithColumn)
				activity.setUserChoice(user.getAD_User_ID(), "Y", DisplayType.YesNo, "Unit test validate against budget");
			else
				activity.setUserConfirmation(activity.getAD_User_ID(), "Unit test validate against budget");
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
		deleteIfExists(jsUserRoles, cbUserRoles, jsAdminUserRoles);
		deleteIfExists(jsValResponsible);
		deleteIfExists(nextStartPrepare, nextStartAuto, nextPrepareApprove, nextValidateComplete, nextPrepareComplete);
		deleteIfExists(nodeComplete, nodeAuto, nodeValidate, nodePrepare, nodeStart);
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
