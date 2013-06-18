/******************************************************************************
 * Copyright (C) 2012 Carlos Ruiz                                             *
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

package org.adempiere.webui.apps.form;

import static org.compiere.model.SystemIDs.COLUMN_WIZARDSTATUS;
import static org.compiere.model.SystemIDs.REFERENCE_WIZARDSTATUS;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.model.MWizardProcess;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.compiere.apps.form.SetupWizard;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWorkflow;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.East;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.North;
import org.zkoss.zul.Progressmeter;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treecell;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;
import org.zkoss.zul.Vbox;
/**
 * View for Setup Wizard
 *
 * @author Carlos Ruiz
 *
 */
public class WSetupWizard extends SetupWizard implements IFormController, EventListener<Event>
{
	private CustomForm form = null;
	
	private Borderlayout	mainLayout	= new Borderlayout();
	private Panel 			northPanel	= new Panel();
	private Progressmeter  progressbar    = new Progressmeter();
	private Label			progressLabel	= new Label();
	//
	private Tree			wfnodeTree;
	private Treeitem 		prevti = null;

	private Label			pretitleLabel	= new Label(Msg.getMsg(Env.getCtx(), "SetupTask"));
	private Label			titleLabel	= new Label();
	private Iframe			helpFrame	= new Iframe();
	private Label			notesLabel  = new Label(Msg.getElement(Env.getCtx(), MWizardProcess.COLUMNNAME_Note));
	private Textbox			notesField  = new Textbox();
	
	private Label 			userLabel = new Label(Msg.getMsg(Env.getCtx(), "User"));
	private WSearchEditor	userField;	

	private Label			statusLabel = new Label();
	private WTableDirEditor statusField;
	
	private Label			bZoomLabel = new Label(Msg.getMsg(Env.getCtx(), "Zoom"));
	private Button 			bRefresh 	= new Button();
	private Button 			bOK 		= new Button();
	private Button 			bNext 		= new Button();
	private Button 			bZoom 		= new Button();
	private Button 			bExpand 	= new Button();

	private Checkbox		justmine    = new Checkbox();
	private Checkbox		showColors = new Checkbox();
	
	private ArrayList<Treeitem> nextItems = new ArrayList<Treeitem>();

	private static final String WIZARD_LABEL_STYLE = "font-weight: bold";
	
	private boolean expandTree = false;
	private boolean allFinished = true;
	private Vbox centerBox = new Vbox();
	private Vbox centerBoxdown = new Vbox();
	private Vbox westdown = new Vbox();
	private ArrayList<Integer> openNodes = new ArrayList<Integer>();

	public WSetupWizard()
	{
		try
		{
			preInit();
			jbInit ();
			LayoutUtils.sendDeferLayoutEvent(mainLayout, 100);
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "VTreeMaintenance.init", ex);
		}
	}	//	init
	
	/**
	 * 	Fill Tree Combo
	 */
	private void preInit()
	{
		form = new CustomForm()
		{
			/**
			 * 
			 */
			private static final long serialVersionUID = 8563773513335140396L;

			public void onEvent(Event event) throws Exception
		    {
				if (event.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT)) 
				{
					Treeitem ti = wfnodeTree.getSelectedItem();
					if (ti.getAttribute("AD_Workflow_ID") != null) {
						// MWorkflow
						int wfid = (Integer) ti.getAttribute("AD_Workflow_ID");
						SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Workflow, wfid);
					} else if (ti.getAttribute("AD_WF_Node_ID") != null) {
						// MWFNode
						int nodeid = (Integer) ti.getAttribute("AD_WF_Node_ID");
						SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Node, nodeid);
					}
				}
				else
					super.onEvent(event);
		    }
		};
		
		wfnodeTree = new Tree();
		wfnodeTree.addEventListener(Events.ON_SELECT, this);
		showColors.setChecked(true);
		loadWizardNodes();
	}	//	preInit
	
	/**
	 * 	Load Wizard Nodes
	 */
	private void loadWizardNodes() {
		nextItems.removeAll(nextItems);
		Treechildren treeChildren = wfnodeTree.getTreechildren();		
		List<MWorkflow> wfwizards = getWfWizards();
		if (treeChildren == null)
		{
			treeChildren = new Treechildren();
			wfnodeTree.appendChild(treeChildren);
			wfnodeTree.setMultiple(false);
		}
		
		for(MWorkflow wfwizard : wfwizards)
		{
			addWfEntry(wfwizard);
		}
	}

	protected void addWfEntry(MWorkflow wfwizard) {
		/* TODO: Color of workflow according to wizard status */
		allFinished = true;
		Treechildren treeChildren = wfnodeTree.getTreechildren();
		Treeitem treeitemwf = new Treeitem();
		treeChildren.appendChild(treeitemwf);

		Label wizardLabel = new Label(wfwizard.getName(true));
		wizardLabel.setStyle(WIZARD_LABEL_STYLE);
		Div div = new Div();
		div.setStyle("display:inline;");
		div.appendChild(wizardLabel);

		Treerow treerow = new Treerow();
		treerow.setStyle("vertical-align:top;");
		treeitemwf.appendChild(treerow);
		treeitemwf.setOpen(false);
		Treecell treecell = new Treecell();
		treerow.appendChild(treecell);
		treecell.appendChild(div);
		nextItems.add(treeitemwf);
		if (openNodes.contains(wfwizard.getAD_Workflow_ID()))
			treeitemwf.setOpen(true);
		addNodes(wfwizard, treeitemwf);

		if(allFinished && showColors.isChecked()){
			wizardLabel.setZclass("tree-wsetupwizard-finished-all");
		}
		
		treeitemwf.setAttribute("AD_Workflow_ID", wfwizard.getAD_Workflow_ID());
		if (prevti != null && prevti.getAttribute("AD_Workflow_ID") != null) {
			if (prevti.getAttribute("AD_Workflow_ID").equals(treeitemwf.getAttribute("AD_Workflow_ID")))
				wfnodeTree.setSelectedItem(treeitemwf);
		}

	}

	private void addNodes(MWorkflow wfwizard, Treeitem treeitemwf) {
		MWFNode[] nodes = wfwizard.getNodes(true, Env.getAD_Client_ID(Env.getCtx()));
		for (MWFNode node : nodes) {
			addWfNode(node, treeitemwf);
		}
	}

	private void addWfNode(MWFNode node, Treeitem treeitemwf) {
		/* TODO: Color of node according to wizard status */
		Label nodeLabel = new Label(node.getName(true));
		if (node != null && showColors.isChecked()) {
			MWizardProcess wp = MWizardProcess.get(Env.getCtx(), node.getAD_WF_Node_ID(), Env.getAD_Client_ID(Env.getCtx()));
			String status = wp.getWizardStatus();
			if (MWizardProcess.WIZARDSTATUS_Finished.equals(status)){
				nodeLabel.setZclass("tree-wsetupwizard-finished");
				allFinished = allFinished && true;
			}else if (MWizardProcess.WIZARDSTATUS_Skipped.equals(status)) {
				nodeLabel.setZclass("tree-wsetupwizard-skipped");
				allFinished = allFinished && true;
			}else if (MWizardProcess.WIZARDSTATUS_Delayed.equals(status)) {
				nodeLabel.setZclass("tree-wsetupwizard-delayed");
				allFinished = allFinished && false;
			}else if (MWizardProcess.WIZARDSTATUS_In_Progress.equals(status)) {
				nodeLabel.setZclass("tree-wsetupwizard-in-progress");
				allFinished = allFinished && false;
			}else if (MWizardProcess.WIZARDSTATUS_Pending.equals(status)) {
				nodeLabel.setZclass("tree-wsetupwizard-pending");
				allFinished = allFinished && false;
			}else {
				nodeLabel.setZclass("tree-setupwizard-nostatus");
				allFinished = false;
			}
		}else{
			nodeLabel.setStyle("margin-left:20px;");
		}
		
		Div div = new Div();
		div.setStyle("display:inline;");
		div.appendChild(nodeLabel);

		Treechildren treeChildren = treeitemwf.getTreechildren();
		if (treeChildren == null)
		{
			treeChildren = new Treechildren();
			treeitemwf.appendChild(treeChildren);
		}
		Treeitem childItem = new Treeitem();
		treeChildren.appendChild(childItem);
		Treerow treerow = new Treerow();
		treerow.setStyle("vertical-align:top;");
		childItem.appendChild(treerow);				
		Treecell treecell = new Treecell();
		treerow.appendChild(treecell);
		treecell.appendChild(div);

		childItem.setAttribute("AD_WF_Node_ID", node.getAD_WF_Node_ID());
		if (prevti != null && prevti.getAttribute("AD_WF_Node_ID") != null) {
			if (prevti.getAttribute("AD_WF_Node_ID").equals(childItem.getAttribute("AD_WF_Node_ID")))
				wfnodeTree.setSelectedItem(childItem);
		}
		nextItems.add(childItem);
	}

	/**
	 * 	Static init
	 *	@throws Exception
	 */
	@SuppressWarnings("deprecation")
	private void jbInit () throws Exception
	{
		form.setWidth("99%");
		form.setHeight("100%");
		form.setStyle("position: absolute; padding: 0; margin: 0");
		form.appendChild (mainLayout);
		mainLayout.setWidth("100%");
		mainLayout.setHeight("100%");
		mainLayout.setStyle("position: absolute");

		bRefresh.setImage(ThemeManager.getThemeResource("images/Refresh16.png"));
		bRefresh.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "Refresh"));
		bRefresh.addEventListener(Events.ON_CLICK, this);

		bOK.setImage(ThemeManager.getThemeResource("images/Ok16.png"));
		bOK.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "Update"));
		bOK.addEventListener(Events.ON_CLICK, this);

		bNext.setImage(ThemeManager.getThemeResource("images/Next16.png"));
		bNext.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "Next"));
		bNext.addEventListener(Events.ON_CLICK, this);
		
		bZoom.setImage(ThemeManager.getThemeResource("images/Zoom16.png"));
		bZoom.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "Zoom"));
		bZoom.addEventListener(Events.ON_CLICK, this);
		
		bExpand.setLabel("Expand Tree");
		bExpand.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "ExpandTree"));
		bExpand.addEventListener(Events.ON_CLICK, this);
		
		justmine.setLabel("Just Mine");
		justmine.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "JustMine"));
		justmine.addEventListener(Events.ON_CHECK,this);
		
		showColors.setLabel("Show Colors");
		showColors.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "ShowColors"));
		showColors.addEventListener(Events.ON_CHECK,this);
			
		North north = new North();
		mainLayout.appendChild(north);
		north.appendChild(northPanel);
		north.setHeight("38px");
		//
		northPanel.appendChild(progressbar);
		progressbar.setWidth("100%");
		progressbar.setZclass("progressmeter-setupwizard");
		northPanel.appendChild(progressLabel);
		progressLabel.setWidth("100%");
		progressLabel.setStyle("margin:0; padding:0; position: absolute; align: center; valign: center; border:0; text-align: center; ");
		refreshProgress();

		statusLabel.setText(Msg.getElement(Env.getCtx(), "WizardStatus"));
		MLookup wizardL = MLookupFactory.get(Env.getCtx(), form.getWindowNo(), COLUMN_WIZARDSTATUS,
				DisplayType.List, Env.getLanguage(Env.getCtx()), "WizardStatus", REFERENCE_WIZARDSTATUS,
				false, "AD_Ref_List.Value IN ('D','S','I','F','P')");
		statusField = new WTableDirEditor("WizardStatus", true, false, true,wizardL);
		statusField.setValue(MWizardProcess.WIZARDSTATUS_Pending);
		
		centerBox.setVflex("1");
		centerBox.setHflex("1");
		Center center = new Center();
		mainLayout.appendChild(center);	
		center.appendChild(centerBox);
		centerBox.appendChild(wfnodeTree);
		centerBox.setWidth("100%");
		wfnodeTree.setVflex("1");
		centerBox.appendChild(centerBoxdown);
		centerBoxdown.setOrient("horizontal");
		centerBoxdown.setAlign("center");
		centerBoxdown.setPack("start");
		centerBoxdown.appendChild(bExpand);
		centerBoxdown.appendChild(justmine);
		centerBoxdown.appendChild(showColors);
		center.setAutoscroll(true);
	
		Div div = new Div();
		div.setHeight("88%");
		div.setHflex("1");
		
		div.setStyle("text-align:center ");
		pretitleLabel.setStyle("font-weight: bold; font-size: 14px");
		div.appendChild(titleLabel);
		titleLabel.setStyle("font-weight: bold; font-size: 14px");
		titleLabel.setLeft("50%");
		
		div.appendChild(helpFrame);
		helpFrame.setWidth("99%");
		helpFrame.setHeight("80%");
		helpFrame.setStyle("border: 1px solid lightgray; margin:auto");
		
		Div divNote = new Div();
		divNote.setStyle("text-align:left");
		Separator separator = new Separator();
		divNote.appendChild(separator);
		divNote.appendChild(notesLabel);
		
		divNote.appendChild(notesField);
		notesField.setRows(4);
		notesField.setHeight("100%");
		notesField.setWidth("99%");

		MLookup lookup = MLookupFactory.get(Env.getCtx(), form.getWindowNo(),
                0, 200913, DisplayType.Search);
		userField = new WSearchEditor(lookup, Msg.translate(
                Env.getCtx(), "AD_User_ID"), "", false, false, true);

		westdown.setOrient("horizontal");
		westdown.setAlign("center");
		westdown.setPack("center");
		westdown.appendChild(bZoomLabel);
		westdown.appendChild(bZoom);
		westdown.appendChild(userLabel);
		westdown.appendChild(userField.getComponent());
		westdown.appendChild(new Space());
		westdown.appendChild(statusLabel);
		westdown.appendChild(statusField.getComponent());
		westdown.appendChild(new Space());
		westdown.appendChild(bRefresh);
		westdown.appendChild(bOK);
		westdown.appendChild(bNext);
		Div divButton = new Div();
		divButton.setAlign("right");
		divButton.appendChild(westdown);

		East east = new East();
		mainLayout.appendChild(east);
		div.appendChild(divNote);
		div.appendChild(divButton);
		east.appendChild(div);
		east.setCollapsible(true);
		east.setSplittable(true);
		east.setWidth("70%");
		east.setAutoscroll(true);

		setNotesPanelVisible(false);
		
		MWorkflow wf = MWorkflow.get(Env.getCtx(), getWfWizards().get(0).get_ID());
		showInRightPanel(wf.getAD_Workflow_ID(), 0);


	}	//	jbInit

	private void refreshProgress() {
		int nodes = getNodesCnt();
		int solved = getWizardCnt();
		int percent = solved * 100;
		if (nodes > 0)
			percent = percent / nodes;
		else
			percent = 0;
		Object[] args = new Object[] {solved, nodes, percent};
		String msg = Msg.getMsg(Env.getCtx(), "SetupWizardProgress", args);
		progressLabel.setText(msg);
		progressbar.setValue(percent);
		progressbar.setTooltiptext(msg);
	}

	/**
	 * 	Dispose
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	dispose

	/**
	 * 	Action Listener
	 *	@param e event
	 */
	public void onEvent (Event e)
	{
		if (e.getTarget() == wfnodeTree) {
			onTreeSelection(e);
		} else if (e.getTarget() == bRefresh) {
			showInRightPanel(0, m_node.getAD_WF_Node_ID());
		} else if (e.getTarget() == bOK) {
			int userid = 0;
			allFinished=true;
			if (!userField.isNullOrEmpty())
				userid = (Integer)userField.getValue();
			if (save(notesField.getText(), (String) statusField.getValue(), userid))
				repaintTree();
		} else if (e.getTarget() == bNext) {
			navigateToNext();
		} else if (e.getTarget() == bZoom) {
			zoom();
		} else if (e.getTarget() == bExpand) {
			expandTree();
		} else if (e.getTarget() == justmine) {
			justMine();
		} else if (e.getTarget() == showColors) {
			showColors();
		}
	
	}	//	actionPerformed

	private void showColors() {
		if (showColors.isChecked())
			allFinished = true;
		repaintTree();
	}

	private void justMine() {
		if (justmine.isChecked()) {
			showChildren(false);
		} else {
			showChildren(true);
		}
	}

	private void showChildren(boolean showmine) {
		int user = Env.getAD_User_ID(Env.getCtx());
		for (Treeitem nextItem : nextItems){
			Treeitem ti= nextItem;
			if (ti.getLevel()!= 0){
				MWizardProcess wp = MWizardProcess.get(Env.getCtx(), (Integer) ti.getAttribute("AD_WF_Node_ID"), Env.getAD_Client_ID(Env.getCtx()));
				if (wp.getAD_User_ID() != user){
					ti.setVisible(showmine);
				}
			}
		}
		
	}

	private void expandTree() {
		if(!expandTree){
			TreeUtils.expandAll(wfnodeTree);
			expandTree = true;
		}else{
			TreeUtils.collapseAll(wfnodeTree);
			expandTree = false;
		}
		
	}

	private void zoom() {
		if (m_node != null) {
			if (MWFNode.ACTION_UserWindow.equals(m_node.getAction())) {
				AEnv.zoom(m_node.getAD_Window_ID(), null);
			} else if (MWFNode.ACTION_UserForm.equals(m_node.getAction())) {
				int AD_Form_ID = m_node.getAD_Form_ID();
				ADForm form = ADForm.openForm(AD_Form_ID);
				form.setAttribute(Window.MODE_KEY, form.getWindowMode());
				AEnv.showWindow(form);
			}
		}
	}

	private void repaintTree() {
		openNodes.removeAll(openNodes);
		for (Treeitem nextItem : nextItems) {
			if (nextItem.isOpen() && nextItem.getAttribute("AD_Workflow_ID") != null) {
				openNodes.add((Integer) nextItem.getAttribute("AD_Workflow_ID"));
			}
		}
		prevti = wfnodeTree.getSelectedItem();
		wfnodeTree.clear();
		loadWizardNodes();
		refreshProgress();
	}
	
	private void navigateToNext() {
		boolean repaint = false;
		if (m_node != null) {
			int userid = 0;
			if (!userField.isNullOrEmpty())
				userid = (Integer)userField.getValue();
			repaint = save(notesField.getText(), (String) statusField.getValue(), userid);
		}
		Treeitem ti = wfnodeTree.getSelectedItem();
		if (ti == null || nextItems.indexOf(ti)+1 == nextItems.size()) {
			ti = nextItems.get(0);
			wfnodeTree.setSelectedItem(ti);
			showItem(ti);
		} else {
			int idx = nextItems.indexOf(ti);
			Treeitem nextti = nextItems.get(idx+1);
			wfnodeTree.setSelectedItem(nextti);
			showItem(nextti);
		}
		if (repaint)
			repaintTree();
	}

	/**
	 * 	Tree selection
	 *	@param e event
	 */
	private void onTreeSelection (Event e)
	{
		Treeitem ti = wfnodeTree.getSelectedItem();
		showItem(ti);
	}	//	propertyChange

	private void showItem(Treeitem ti) {
		if (ti.getAttribute("AD_Workflow_ID") != null) {
			ti.setOpen(true);
			// MWorkflow
			int wfid = (Integer) ti.getAttribute("AD_Workflow_ID");
			showInRightPanel(wfid, 0);
			SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Workflow, wfid);
		} else if (ti.getAttribute("AD_WF_Node_ID") != null) {
			// MWFNode
			int nodeid = (Integer) ti.getAttribute("AD_WF_Node_ID");
			showInRightPanel(0, nodeid);
			SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Node, nodeid);
		}
	}

	private void showInRightPanel(int ad_workflow_id, int ad_wf_node_id) {
		String title = null;
		String help = null;
		if (ad_wf_node_id > 0) {
			MWFNode node = MWFNode.get(Env.getCtx(), ad_wf_node_id);
			title = node.getName(true);
			help = node.getHelp(true);
			m_node = node;
			MWizardProcess wp = MWizardProcess.get(Env.getCtx(), ad_wf_node_id, Env.getAD_Client_ID(Env.getCtx()));
			notesField.setText(wp.getNote());
			statusField.setValue(wp.getWizardStatus());
			userField.setValue(wp.getAD_User_ID() > 0 ? wp.getAD_User_ID() : null);
			setNotesPanelVisible(true);
		} else {
			MWorkflow wf = MWorkflow.get(Env.getCtx(), ad_workflow_id);
			title = wf.getName(true);
			help = wf.getHelp(true);
			setNotesPanelVisible(false);
			m_node = null;
		}
		titleLabel.setText(pretitleLabel.getValue() + title);
		if (help != null) {
	    	AMedia media = new AMedia("Help", "html", "text/html", help.getBytes());
			helpFrame.setContent(media);
			helpFrame.invalidate();
		} else {
			helpFrame.setContent(null);
		}
		helpFrame.invalidate();
	}

	private void setNotesPanelVisible(boolean visible) {
		notesLabel.setVisible(visible);
		notesField.setVisible(visible);
		bRefresh.setVisible(visible);
		bOK.setVisible(visible);
		statusLabel.setVisible(visible);
		statusField.setVisible(visible);
		userLabel.setVisible(visible);
		userField.setVisible(visible);
		bZoomLabel.setVisible(visible);
		bZoom.setVisible(visible);
	}

	public ADForm getForm() 
	{
		return form;
	}

} // WSetupWizard