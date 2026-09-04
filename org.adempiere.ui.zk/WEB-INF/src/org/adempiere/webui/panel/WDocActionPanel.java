/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.Future;
import java.util.logging.Level;
import java.util.stream.Collectors;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.DesktopRunnable;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.util.ZkContextRunnable;
import org.adempiere.webui.window.Dialog;
import org.compiere.Adempiere;
import org.compiere.model.GridTab;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MClientInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MPeriod;
import org.compiere.model.MProcess;
import org.compiere.model.MRefList;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.MUserRoles;
import org.compiere.model.MValRule;
import org.compiere.model.MWFActivityApprover;
import org.compiere.model.PO;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWFResponsible;
import org.compiere.wf.MWorkflow;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;

/**
 * Document action dialog
 */
public class WDocActionPanel extends Window implements EventListener<Event>, DialogEvents
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3218367479851088526L;

	/** Event to fire on complete of execution of doc action **/
	private static final String		ON_COMPLETE_EVENT	= "onComplete";

	private Label lblDocAction;
	private Label label;
	private Listbox lstDocAction;

	private GridTab gridTab;
	private String[]		s_value = null;
	private String[]		s_name;
	private String[]		s_description;
	private String DocStatus;
	private String DocAction;
	private int m_AD_Table_ID;
	private boolean m_OKpressed;
    private ConfirmPanel confirmPanel;

	private Label lblAnswer;
	private Listbox lstAnswer;
	private Label lTextMsg = new Label(Msg.getMsg(Env.getCtx(), "Messages"));
	private Textbox fTextMsg = new Textbox();

	/** Current Activity */
	private MWFActivity				m_activity			= null;
	/** Current Node */
	private MWFNode					currentNode			= null;
	/** Approval Column of node */
	private int						ApprovalColumn_ID	= 0;
	/** Current WF Process */
	private MWFProcess				m_WFProcess			= null;
	/** Current process */
	private int						m_Process_ID		= 0;
	/** Current User */
	private int						m_AD_User_ID		= 0;
	/** Current Role */
	private int						m_AD_Role_ID		= 0;
	/** Workflow transaction name. */
	private String					wfTrxName			= null;
	/** Reference to docAction thread/task **/
	private Future<?>				future;

	/** Current Workflow Responsible */
	private MWFResponsible			resp				= null;

	private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(WDocActionPanel.class);
    }

    /**
     * @param mgridTab
     */
	public WDocActionPanel(GridTab mgridTab)
	{
		this(mgridTab, false, 0);
	}

	/**
	 * @param mgridTab
	 * @param fromMenu
	 */
	public WDocActionPanel(GridTab mgridTab, boolean fromMenu)
	{
		this(mgridTab, fromMenu, 0);
	}

    /**
     * @param mgridTab
     * @param process_ID 
     */
	public WDocActionPanel(GridTab mgridTab, int process_ID)
	{
		this(mgridTab, false, process_ID);
	}

	/**
	 * @param mgridTab
	 * @param fromMenu
	 */
	public WDocActionPanel(GridTab mgridTab, boolean fromMenu, int process_ID)
	{
		gridTab = mgridTab;
		DocStatus = (String)gridTab.getValue("DocStatus");
		DocAction = (String)gridTab.getValue("DocAction");
		m_Process_ID = process_ID;
		m_AD_Table_ID = mgridTab.getAD_Table_ID();
		m_AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		m_AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());

		loadActivity();

		if (!isValidApprover())
		{
			handleInvalidApprover(fromMenu);
			return;
		}

		readReference();
		initComponents();
		dynInit(fromMenu);

		init();
	}

	/**
	 * Displays an error message when the current user is not a valid approver.
	 *
	 * @param fromMenu indicates whether the action was initiated from the menu
	 */
	private void handleInvalidApprover(boolean fromMenu)
	{
		if (fromMenu)
			return;

		String respName = getResponsibleName();

		String msg = Msg.getMsg(Env.getCtx(), "AssignedToState", new Object[] { m_activity.getWFStateText(), m_activity.getNode().getName(), respName });

		Dialog.error(gridTab.getWindowNo(), msg, m_activity.toStringX());
	}

	/**
	 * Returns the name of the responsible user or role for the current workflow activity.
	 *
	 * @return responsible user or role name
	 */
	private String getResponsibleName()
	{
		if (resp.isRole())
			return resp.getRole().getName();

		if (resp.isManual())
		{
			return Arrays
							.stream(MWFActivityApprover.getOfActivity(m_activity.getCtx(), m_activity.getAD_WF_Activity_ID(), m_activity.get_TrxName()))
							.map(a -> MUser.get(a.getAD_User_ID()).getName())
							.collect(Collectors.joining(", "));
		}

		if (m_activity.getAD_User_ID() > 0)
			return MUser.get(m_activity.getAD_User_ID()).getName();

		if (resp.isHuman())
			return MUser.get(resp.getAD_User_ID()).getName();

		return "";
	}

	/**
	 * Validates whether the current user is authorized to approve
	 * the current workflow activity.
	 *
	 * @return {@code true} if the user is a valid approver; otherwise {@code false}
	 */
	private boolean isValidApprover()
	{
		if (resp != null && m_activity != null)
		{
			String respType = resp.getResponsibleType();

			// Current User is not Approver and Approval type is manual
			if (MWFResponsible.RESPONSIBLETYPE_Manual.equals(respType))
			{
				// If Approver is not assign then check current user is invoker
				MWFActivityApprover[] approvers = MWFActivityApprover.getOfActivity(m_activity.getCtx(), m_activity.getAD_WF_Activity_ID(), m_activity.get_TrxName());
				if ((approvers == null || approvers.length == 0) && m_activity.getAD_User_ID() <= 0)
				{
					return false;
				}

				// If Approver is assign then check current user is not Approver
				if (m_activity.getAD_User_ID() > 0 && m_AD_User_ID != m_activity.getAD_User_ID())
				{
					return false;
				}

				if (approvers != null && approvers.length > 0)
				{
					boolean isApprover = false;
					for (int i = 0; i < approvers.length; i++)
					{
						if (m_AD_User_ID == approvers[i].getAD_User_ID())
						{
							isApprover = true;
							break;
						}
					}
					return isApprover;
				}

				return true;
			}
			else if (MWFResponsible.RESPONSIBLETYPE_Human.equals(respType) && (resp.getAD_User_ID() > 0 || m_activity.getAD_User_ID() > 0))
			{
				return isValidHumanResponsible();
			}
			else
			{
				// Current User Role's is Approval Role
				if (MWFResponsible.RESPONSIBLETYPE_Role.equals(respType))
				{
					MUserRoles[] userRoles = MUserRoles.getOfUser(Env.getCtx(), m_AD_User_ID);

					boolean hasResponsibleRole = false;

					for (int i = 0; i < userRoles.length; i++)
					{
						MUserRoles role = userRoles[i];

						if (!role.isActive())
							continue;

						if (role.getAD_Role_ID() == resp.getAD_Role_ID())
						{
							hasResponsibleRole = true;
							break;
						}
					}

					if (!hasResponsibleRole)
					{
						return false;
					}
				}
			}
		}
		return true;
	}

	/**
	 * Loads the current workflow activity and initializes the
	 * associated workflow context and approval information.
	 */
	private void loadActivity()
	{
		m_activity = MWFActivity.getLastSuspended(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID(), true);
		if (m_activity != null)
		{
			m_WFProcess = MWFProcess.get(m_activity.getAD_WF_Process_ID());

			int AD_WF_Resp_ID = m_activity.getAD_WF_Responsible_ID();

			resp = m_activity.getResponsible();
			// first priority to suspended activity responsible
			if (resp == null)
			{
				MWFResponsible ovrResp = MWFResponsible.getClientWFResp(Env.getCtx(), AD_WF_Resp_ID);
				if (ovrResp != null)
					resp = ovrResp;
			}
		}

		if (m_activity != null)
		{
			currentNode = m_activity.getNode();
		}
		else if (org.compiere.process.DocAction.STATUS_Drafted.equals(DocStatus) && m_Process_ID > 0)
		{
			// Currently it only works for the DR state, because when the activity isn’t
			// created yet, we don’t know which node will run.
			currentNode = getNodeFromProcess();
		}

		if (isActUserApprovalTask() && currentNode != null)
		{
			ApprovalColumn_ID = currentNode.getAD_Column_ID();
		}
	}

	/**
	 * Checks whether the human responsible user is valid for the current activity
	 * or responsibility, including substitutes.
	 *
	 * @return {@code true} if the user is active and allowed, otherwise
	 *         {@code false}
	 */
	private boolean isValidHumanResponsible()
	{
		final int userId = (m_activity != null && m_activity.getAD_User_ID() != 0)	? m_activity.getAD_User_ID()
																					: resp.getAD_User_ID();
		return userId > 0 && m_AD_User_ID == userId;
	}

	/**
	 * Checks whether the current workflow activity represents a user interaction
	 * Returns true if the activity exists and is either a user approval or user task.
	 */
	private boolean isActUserApprovalTask()
	{
		return m_activity != null && m_activity.isUserApproval();
	}

	/**
	 * Checks whether the current workflow node represents a user interaction
	 * Returns true if the node exists and is either a user approval or user task.
	 * This is typically used as a fallback when no activity is available.
	 */
	private boolean isCurNodeUserApprovalTask()
	{
		return currentNode != null && currentNode.isUserApproval();
	}

	/**
	 * Get workflow node from process or PO document workflow
	 * 
	 * @return workflow node or null if not found
	 */
	private MWFNode getNodeFromProcess()
	{
		MProcess pr = new MProcess(Env.getCtx(), m_Process_ID, null);
		int workflowId = pr.getAD_Workflow_ID();
		MWorkflow workflow = workflowId > 0 ? MWorkflow.get(workflowId) : null;
		if (workflow != null)
			return (MWFNode) MWFNode.get(workflow.getAD_WF_Node_ID());
		return null;
	}

	/**
	 * Dynamic Init - determine valid DocActions based on DocStatus for the different documents.
	 * @param fromMenu 
	 */
	private void dynInit(boolean fromMenu)
	{
		//
		Object Processing = gridTab.getValue("Processing");
		String OrderType = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "OrderType");
		String IsSOTrx = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "IsSOTrx");

		if (DocStatus == null)
		{
			return;
		}

		if (logger.isLoggable(Level.FINE)) logger.fine("DocStatus=" + DocStatus
			+ ", DocAction=" + DocAction + ", OrderType=" + OrderType
			+ ", IsSOTrx=" + IsSOTrx + ", Processing=" + Processing
			+ ", AD_Table_ID=" +gridTab.getAD_Table_ID() + ", Record_ID=" + gridTab.getRecord_ID());
        int index = 0;
        if(lstDocAction.getSelectedItem() != null)
        {
            String selected = (lstDocAction.getSelectedItem().getValue()).toString();

            for(int i = 0; i < s_value.length && index == 0; i++)
            {
                if(s_value[i].equals(selected))
                {
                    index = i;
                }
            }
        }

		String[] options = new String[s_value.length];
		/**
		 * 	Check Existence of Workflow Acrivities
		 */
		String wfStatus = MWFActivity.getActiveInfo(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID());
		if (wfStatus != null)
		{
			if (! fromMenu)
				Dialog.error(gridTab.getWindowNo(), "WFActiveForRecord", wfStatus);
			return;
		}

		//	Status Change
		if (!checkStatus(gridTab.getTableName(), gridTab.getRecord_ID(), DocStatus))
		{
			Dialog.error(gridTab.getWindowNo(), "DocumentStatusChanged");
			return;
		}
		/*******************
		 *  General Actions
		 */

		MTable table = MTable.get(Env.getCtx(), m_AD_Table_ID);
		PO po = table.getPO(gridTab.getRecord_ID(), null);
		boolean periodOpen = true;
		boolean isBackDateTrxAllowed = true;
		if (po instanceof DocAction) {
			periodOpen = MPeriod.isOpen(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID(), null);
			isBackDateTrxAllowed = MAcctSchema.isBackDateTrxAllowed(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID(), null);
		}

		String[] docActionHolder = new String[]{DocAction};
		index = DocumentEngine.getValidActions(DocStatus, Processing, OrderType, IsSOTrx,
				m_AD_Table_ID, docActionHolder, options, periodOpen, isBackDateTrxAllowed, po);

		Integer doctypeId = (Integer)gridTab.getValue("C_DocTypeTarget_ID");
		if(doctypeId==null || doctypeId.intValue()==0){
			doctypeId = (Integer)gridTab.getValue("C_DocType_ID");
		}
		if (doctypeId == null && MAllocationHdr.Table_ID == m_AD_Table_ID) {
			doctypeId = MDocType.getDocType(MDocType.DOCBASETYPE_PaymentAllocation);
		}
		if (logger.isLoggable(Level.FINE)) logger.fine("get doctype: " + doctypeId);
		if (doctypeId != null) {
			index = DocumentEngine.checkActionAccess(Env.getAD_Client_ID(Env.getCtx()),
					Env.getAD_Role_ID(Env.getCtx()),
					doctypeId, options, index);
		}

		DocAction = docActionHolder[0];

		/**
		 *	Fill actionCombo
		 */

		boolean firstadded = true;
		for (int i = 0; i < index; i++)
		{
			//	Search for option and add it
			boolean added = false;

			for (int j = 0; j < s_value.length && !added; j++)
			{
				if (options[i].equals(s_value[j]))
				{
					Listitem newitem = lstDocAction.appendItem(s_name[j],s_value[j]);
					if (firstadded) {
						// select by default the first added item - can be changed below
						lstDocAction.setSelectedItem(newitem);
						firstadded = false;
					}
					added = true;
				}
			}
		}
		// look if the current DocAction is within the list and assign it as selected if it exists
		List<Listitem> lst = (List<Listitem>)lstDocAction.getItems();
		for(Listitem item: lst)
		{
			String value = item.getValue().toString();

			if(DocAction.equals(value))
			{
				lstDocAction.setSelectedItem(item);
				label.setValue(s_description[getSelectedIndex()]);
			}
		}
		//	setDefault
		if (DocAction.equals("--"))		//	If None, suggest closing
			DocAction = DocumentEngine.ACTION_Close;
	}

	/**
	 * @return available document action items
	 */
	public List<Listitem> getDocActionItems() {
		return (List<Listitem>)lstDocAction.getItems();
	}
	
	/**
	 * @param TableName
	 * @param Record_ID
	 * @param DocStatus
	 * @return true if DocStatus match DocStatus from DB
	 */
	private boolean checkStatus (String TableName, int Record_ID, String DocStatus)
	{
		String sql = "SELECT 2 FROM " + TableName
			+ " WHERE " + TableName + "_ID=" + Record_ID
			+ " AND DocStatus='" + DocStatus + "'";
		int result = DB.getSQLValue(null, sql);
		return result == 2;
	}

	/**
	 * Create components
	 */
	private void initComponents()
	{
		lblDocAction = new Label();
		lblDocAction.setValue(Msg.translate(Env.getCtx(), "DocAction"));

		label = new Label();

		lstDocAction  = new Listbox();
		lstDocAction.setId("lstDocAction");
		lstDocAction.setRows(0);
		lstDocAction.setMold("select");
		ZKUpdateUtil.setWidth(lstDocAction, "200px");
		lstDocAction.addEventListener(Events.ON_SELECT, this);
		
		lblAnswer = new Label(Msg.getMsg(Env.getCtx(), "Answer"));
		lstAnswer = new Listbox();
		lstAnswer.setRows(0);
		lstAnswer.setMold("select");
		lstAnswer.setVisible(false);
		lblAnswer.setVisible(false);
		ZKUpdateUtil.setWidth(lstAnswer, "100%");
		
		if (isActUserApprovalTask() && ApprovalColumn_ID > 0)
		{
			MColumn column = MColumn.get(Env.getCtx(), ApprovalColumn_ID);
			int dt = column.getAD_Reference_ID();

			if (dt == DisplayType.YesNo)
			{
				ValueNamePair[] values = MRefList.getList(Env.getCtx(), 319, false);
				for (int i = 0; i < values.length; i++)
				{
					lstAnswer.appendItem(values[i].getName(), values[i].getValue());
				}
				lstAnswer.setVisible(true);
				lblAnswer.setVisible(true);
			}
			else if (dt == DisplayType.List)
			{
				String validationCode = column.getAD_Val_Rule_ID() > 0 && MValRule.get(column.getAD_Val_Rule_ID()) != null ? MValRule.get(column.getAD_Val_Rule_ID()).getCode() : "";
				if (!Util.isEmpty(validationCode))
				{
					if (gridTab != null)
						validationCode = Env.parseContext(Env.getCtx(), gridTab.getWindowNo(), gridTab.getTabNo(), validationCode, false);
					else
						validationCode = Env.parseContext(Env.getCtx(), 0, 0, validationCode, false);
				}
				ValueNamePair[] values = MRefList.getList(Env.getCtx(), column.getAD_Reference_Value_ID(), false, validationCode, "D");
				for (int i = 0; i < values.length; i++)
				{
					lstAnswer.appendItem(values[i].getName(), values[i].getValue());
				}
				lstAnswer.setVisible(true);
				lblAnswer.setVisible(true);
			}
		}
		lstAnswer.addEventListener(Events.ON_SELECT, this);

        confirmPanel = new ConfirmPanel(true);
        confirmPanel.addActionListener(Events.ON_CLICK, this);
        ZKUpdateUtil.setVflex(confirmPanel, "true");
	}

	/**
	 * Layout dialog
	 */
	private void init()
	{
		setSclass("popup-dialog doc-action-dialog");
		Vlayout vlayout = new Vlayout();
		ZKUpdateUtil.setHflex(vlayout, "1");
		this.appendChild(vlayout);
		
		setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "documentAction");
		Grid grid = GridFactory.newGridLayout();
        grid.setStyle("background-image: none;");
        LayoutUtils.addSclass("dialog-content", grid);
        vlayout.appendChild(grid);

        Rows rows = new Rows();
        grid.appendChild(rows);

		Row rowDocAction = new Row();
		Row rowLabel = new Row();
        Row rowSpacer = new Row();
		Row rowAnswer = new Row();
		Row rowTxtMsg = new Row();

		Panel pnlDocAction = new Panel();
		pnlDocAction.appendChild(lblDocAction);
		pnlDocAction.appendChild(new Space());
		pnlDocAction.appendChild(lstDocAction);

		rowDocAction.appendChild(pnlDocAction);
		rowLabel.appendChild(label);
		
		rowSpacer.appendChild(new Space());
	    
		// Answer
		rowAnswer.appendCellChild(lblAnswer);
		rowAnswer.appendCellChild(lstAnswer);
		rowAnswer.appendCellChild(new Space());

		// Text Msg
		rowTxtMsg.appendCellChild(lTextMsg);
		rowTxtMsg.appendCellChild(fTextMsg);
		rowTxtMsg.appendCellChild(new Space());
		ZKUpdateUtil.setHflex(fTextMsg, "true");
		fTextMsg.setMultiline(true);
		ZKUpdateUtil.setWidth(fTextMsg, "100%");

		if (isActUserApprovalTask() || isCurNodeUserApprovalTask())
		{
			rows.appendChild(rowAnswer);
			rows.appendChild(rowTxtMsg);
		}
		else
		{
			rows.appendChild(rowDocAction);
			rows.appendChild(rowLabel);
			rows.appendChild(rowSpacer);
		}
	    
	    Div footer = new Div();
	    footer.setSclass("dialog-footer");
	    vlayout.appendChild(footer);
	    footer.appendChild(confirmPanel);
	    ZKUpdateUtil.setVflex(confirmPanel, "min");
	    
	    this.setTitle(Msg.translate(Env.getCtx(), "DocAction"));
	    if (!ThemeManager.isUseCSSForWindowSize())
	    	ZKUpdateUtil.setWindowWidthX(this, 410);
	    this.setBorder("normal");
	    this.setZindex(1000);
	}

	/**
	 *	Should the process be started?
	 *  @return OK pressed
	 */
	public boolean isStartProcess()
	{
		return m_OKpressed;
	}	//	isStartProcess

	@Override
	public void onEvent(Event event)
	{

		if (Events.ON_CLICK.equals(event.getName()))
		{
			if (confirmPanel.getButton("Ok").equals(event.getTarget()))
			{
				confirmPanel.getButton("Ok").setEnabled(false);
				wfTrxName = Trx.createTrxName("FWFA");
				if (isWFActivity())
				{
					m_activity.set_TrxName(wfTrxName);
					future = Adempiere.getThreadPoolExecutor().submit(new DesktopRunnable(new DocActionDialogRunnable(), getDesktop()));
				}
				else
				{
					try
					{
						onOk(result -> {
							confirmPanel.getButton("Ok").setEnabled(true);
						});
					}
					catch (Exception e)
					{
						// Ensure OK button is re-enabled if onOk() encounters an exception.
						confirmPanel.getButton("Ok").setEnabled(true);
						throw e;
					}
				}
			}
			else if (confirmPanel.getButton("Cancel").equals(event.getTarget()))
			{
				m_OKpressed = false;
				this.detach();
			}
		}
		else if (ON_COMPLETE_EVENT.equals(event.getName()))
		{
			if (future != null)
			{
				try
				{
					future.get();
				}
				catch (Exception e)
				{
					Throwable error = e.getCause();
					Dialog.error(gridTab.getWindowNo(), "Error", error != null ? error.getLocalizedMessage() : e.getLocalizedMessage());
					logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
				}
				finally
				{
					closeNodeTrx();
				}
			}
			future = null;
			this.detach();
			gridTab.dataRefresh();
		}
		else if (Events.ON_SELECT.equals(event.getName()))
		{

			if (lstDocAction.equals(event.getTarget()))
			{
				label.setValue(s_description[getSelectedIndex()]);
			}
		}
	}
	
	/**
	 * Checks if the workflow activity is valid for processing.  
	 * Returns true if a user answer is selected with a value,  
	 * or if the current activity exists and is a user task.  
	 */
	private boolean isWFActivity( )
	{
		return (lstAnswer.getSelectedItem() != null && lstAnswer.getSelectedItem().getValue() != null) || (m_activity != null && m_activity.isUserChoice());
	}


	/**
	 * Set selected document action item by value
	 * @param value
	 */
	public void setSelectedItem(String value) {
		lstDocAction.setSelectedIndex(-1);
		List<Listitem> lst = (List<Listitem>)lstDocAction.getItems();
		for(Listitem item: lst) {
			if (value.equals(item.getValue())) {
				item.setSelected(true);
				break;
			}
		}
	}
	
	/**
	 * Handle onOk event
	 * @param callback
	 */
	public void onOk(final Callback<Boolean> callback) {
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx());
		if(clientInfo.isConfirmOnDocClose() || clientInfo.isConfirmOnDocVoid())
		{
			String selected = lstDocAction.getSelectedItem().getValue().toString();
			if((selected.equals(org.compiere.process.DocAction.ACTION_Close) && clientInfo.isConfirmOnDocClose())  
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Void) && clientInfo.isConfirmOnDocVoid())
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Reverse_Accrual) && clientInfo.isConfirmOnDocVoid())
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Reverse_Correct) && clientInfo.isConfirmOnDocVoid()))
			{
				String docAction = lstDocAction.getSelectedItem().getLabel();
				MessageFormat mf = new MessageFormat(Msg.getMsg(Env.getAD_Language(Env.getCtx()), "ConfirmOnDocAction"));
				Object[] arguments = new Object[]{docAction};
				Dialog.ask(gridTab.getWindowNo(), "", mf.format(arguments), new Callback<Boolean>() {
					@Override
					public void onCallback(Boolean result) {
						if(result)
						{
							setValueAndClose();
							if (callback != null)
								callback.onCallback(Boolean.TRUE);
						}
						else
						{
							if (callback != null)
								callback.onCallback(Boolean.FALSE);
							return;
						}
					}
				});
			}
			else
			{
				setValueAndClose();
				if (callback != null)
					callback.onCallback(Boolean.TRUE);
			}
		}
		else
		{
			setValueAndClose();
			if (callback != null)
				callback.onCallback(Boolean.TRUE);
		}		
	}

	/**
	 * Validate DocStatus not change by other, update GridTab and close dialog
	 */
	private void setValueAndClose() {
		String statusSql = "SELECT DocStatus FROM " + gridTab.getTableName() 
				+ " WHERE " + gridTab.getKeyColumnName() + " = ? ";
		String currentStatus = DB.getSQLValueString((String)null, statusSql, gridTab.getKeyID(gridTab.getCurrentRow()));
		if (DocStatus != null && !DocStatus.equals(currentStatus)) {
			throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "DocStatusChanged"));
		}
		m_OKpressed = true;
		setValue();
		detach();
	}

	/**
	 * Update GridTab with selected DocAction value
	 */
	private void setValue()
	{
		int index = getSelectedIndex();
		//	Save Selection
		if (logger.isLoggable(Level.CONFIG)) logger.config("DocAction=" + s_value[index]);
		gridTab.setValue("DocAction", s_value[index]);
	}	//	save

	/**
	 * Load document action list from AD_Ref_List  
	 */
	private void readReference()
	{
	        ArrayList<String> v_value = new ArrayList<String>();
    		ArrayList<String> v_name = new ArrayList<String>();
    		ArrayList<String> v_description = new ArrayList<String>();

    		DocumentEngine.readReferenceList(v_value, v_name, v_description);

	    	int size = v_value.size();
			s_value = new String[size];
			s_name = new String[size];
			s_description = new String[size];

			for (int i = 0; i < size; i++)
			{
				s_value[i] = (String)v_value.get(i);
				s_name[i] = (String)v_name.get(i);
				s_description[i] = (String)v_description.get(i);
			}
	 }   //  readReference

	/**
	 * @return selected index
	 */
	 public int getSelectedIndex()
	 {
		int index = 0;
		if(lstDocAction.getSelectedItem() != null)
		{
			String selected = (lstDocAction.getSelectedItem().getValue()).toString();

			for(int i = 0; i < s_value.length && index == 0; i++)
			{
				if(s_value[i].equals(selected))
				{
					index = i;
                    break;
				}
			}
		}
		return index;
	}	//	getSelectedIndex

	 /**
	  * @return number of document action items
	  */
	public int getNumberOfOptions() {
		return lstDocAction != null ? lstDocAction.getItemCount() : 0;
	}

	/**
	 * Runnable to run process in background thread.
	 * Notify process dialog with {@link WDocActionPanel#ON_COMPLETE_EVENT} event.
	 */
	private class DocActionDialogRunnable extends ZkContextRunnable
	{
		private DocActionDialogRunnable()
		{
			super();
		}

		protected void doRun()
		{
			try
			{
				runBackgroundJob();
			}
			catch (Exception ex)
			{
				logger.log(Level.SEVERE, ex.getLocalizedMessage(), ex);
				throw new AdempiereException(ex.getLocalizedMessage(), ex);
			}
			finally
			{
				Executions.schedule(getDesktop(), WDocActionPanel.this, new Event(ON_COMPLETE_EVENT, WDocActionPanel.this, null));
			}
		}
	}// DocActionDialogRunnable

	/**
	 * Commits the workflow node variable transaction and closes it.
	 */
	public void commitNodeVar()
	{
		if (wfTrxName != null)
		{
			Trx wfTrx = Trx.get(wfTrxName, false);
			try
			{
				wfTrx.commit();
			}
			catch (Exception e)
			{
				wfTrx.rollback();
				throw new AdempiereException("Failed to commit workflow node variables", e);
			}
			finally
			{
				wfTrx.close();
				wfTrx = null;
				wfTrxName = null;
				if (gridTab != null)
					gridTab.dataRefresh();
			}
		}
	}

	/**
	 * Close the workflow node variable transaction.
	 */
	public void closeNodeTrx()
	{
		if (wfTrxName != null)
		{
			Trx wfTrx = Trx.get(wfTrxName, false);
			if (wfTrx != null && wfTrx.isActive())
				wfTrx.close();
			wfTrxName = null;
		}
	}

	/**
	 * Rolls back the workflow node variable transaction and closes it.
	 */
	public void rollbackNodeVar()
	{
		if (wfTrxName != null)
		{
			Trx wfTrx = Trx.get(wfTrxName, false);
			try
			{
				wfTrx.rollback();
			}
			finally
			{
				wfTrx.close();
				wfTrx = null;
				wfTrxName = null;
				if (gridTab != null)
					gridTab.dataRefresh();
			}
		}
	}

	public String getWfTrxName()
	{
		return wfTrxName;
	}

	/**
	 * Runs the workflow activity in a background transaction.
	 * Handles different node actions (User Choice, User Task)
	 * by capturing user input, validating it, and updating the activity state.
	 * Commits on success, or rolls back and throws an exception on failure.
	 */
	public void runBackgroundJob()
	{
		Trx trx = null;
		try
		{
			trx = Trx
							.get((m_activity.get_TrxName() == null ? Trx.createTrxName("FWFA") : m_activity.get_TrxName()),
											true);
			trx.setDisplayName(getClass().getName() + "_onOK");
			m_activity.set_TrxName(trx.getTrxName());

			MWFNode node = m_activity.getNode();
			String textMsg = fTextMsg.getValue();

			if (MWFNode.ACTION_UserChoice.equals(node.getAction()))
			{
				// getting Approval column for User Choice node
				int dt = node.getColumn() != null ? node.getColumn().getAD_Reference_ID() : -1;

				String value = null;

				if (dt == DisplayType.YesNo || dt == DisplayType.List)
				{
					Listitem li = lstAnswer.getSelectedItem();

					if (li != null)
						value = li.getValue().toString();
				}

				if ((value == null || value.length() == 0) && dt > 0)
					throw new AdempiereException(Msg.parseTranslation(Env.getCtx(), "@FillMandatory@ @Answer@"));

				//
				if (logger.isLoggable(Level.CONFIG))
					logger.config("Answer=" + value + " - " + textMsg);

				boolean ok = m_activity.setUserChoice(m_AD_User_ID, value, dt, textMsg);

				if (!ok || !Util.isEmpty(m_activity.getProcessMsg()))
				{
					String error = m_activity.getProcessMsg();
					if (!Util.isEmpty(error, true))
						throw new AdempiereException(error);
				}
			}
			else
			{
				if (logger.isLoggable(Level.CONFIG))
					logger.config("Action=" + node.getAction() + " - " + textMsg);
				// ensure activity is ran within a transaction
				m_activity.setUserConfirmation(m_AD_User_ID, textMsg);
			}
			trx.commit();
		}
		catch (Exception e)
		{
			if (trx != null)
				trx.rollback();
			throw new AdempiereException(e.getLocalizedMessage(), e);
		}
		finally
		{
			if (trx != null)
				trx.close();
		}
	}

}
