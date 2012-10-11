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
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.compiere.apps.form.SetupWizard;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
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
import org.zkoss.zul.Div;
import org.zkoss.zul.East;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.North;
import org.zkoss.zul.Progressmeter;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treecell;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;
import org.zkoss.zul.West;

/**
 * View for Setup Wizard
 *
 * @author Carlos Ruiz
 *
 */
@SuppressWarnings({"unchecked", "rawtypes"})
public class WSetupWizard extends SetupWizard implements IFormController, EventListener, ValueChangeListener
{
	private CustomForm form = new CustomForm();	
	
	private Borderlayout	mainLayout	= new Borderlayout();
	private Panel 			northPanel	= new Panel();
	private Progressmeter  progressbar    = new Progressmeter();
	private Label			progressLabel	= new Label();
	//
	private Tree			wfnodeTree;

	private Label			titleLabel	= new Label();
	private Iframe			helpFrame	= new Iframe();
	private Label			notesLabel  = new Label(Msg.getElement(Env.getCtx(), MWizardProcess.COLUMNNAME_Note));
	private Textbox			notesField  = new Textbox();
	
	private Label			statusLabel = new Label();
	private WTableDirEditor statusField;
	
	private Button 			bRefresh 	= new Button();
	private Button 			bOK 		= new Button();
	private Button 			bNext 		= new Button();
	
	private ArrayList<Treeitem> nextItems = new ArrayList<Treeitem>();

	private static final String WIZARD_LABEL_STYLE = "font-weight: bold";
	private static final String NODE_LABEL_STYLE = "margin-left:20px";
	
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
		wfnodeTree = new Tree();
		wfnodeTree.addEventListener(Events.ON_SELECT, this);
		loadWizardNodes();		
	}	//	preInit
	
	/**
	 * 	Load Wizard Nodes
	 */
	private void loadWizardNodes() {
		Treechildren treeChildren = wfnodeTree.getTreechildren();		
		if (treeChildren == null)
		{
			treeChildren = new Treechildren();
			wfnodeTree.appendChild(treeChildren);
			wfnodeTree.setMultiple(false);
		}

		List<MWorkflow> wfwizards = getWfWizards();
		for(MWorkflow wfwizard : wfwizards)
		{
			addWfEntry(wfwizard);
		}
	}

	protected void addWfEntry(MWorkflow wfwizard) {
		/* TODO: Color of workflow according to wizard status */
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
		addNodes(wfwizard, treeitemwf);

		treeitemwf.setAttribute("AD_Workflow_ID", wfwizard.getAD_Workflow_ID());
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
		nodeLabel.setStyle(NODE_LABEL_STYLE);
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
		nextItems.add(childItem);
	}

	/**
	 * 	Static init
	 *	@throws Exception
	 */
	private void jbInit () throws Exception
	{
		form.setWidth("99%");
		form.setHeight("100%");
		form.setStyle("position: absolute; padding: 0; margin: 0");
		form.appendChild (mainLayout);
		mainLayout.setWidth("100%");
		mainLayout.setHeight("100%");
		mainLayout.setStyle("position: absolute");

		bRefresh.setImage("/images/Refresh24.png");
		bRefresh.setTooltiptext(Msg.getMsg(Env.getCtx(), "Refresh"));
		bRefresh.addEventListener(Events.ON_CLICK, this);

		bOK.setImage("/images/Ok24.png");
		bOK.setTooltiptext(Msg.getMsg(Env.getCtx(), "Update"));
		bOK.addEventListener(Events.ON_CLICK, this);

		bNext.setImage("/images/Detail24.png");
		bNext.setTooltiptext(Msg.getMsg(Env.getCtx(), "Next"));
		bNext.addEventListener(Events.ON_CLICK, this);
		
		North north = new North();
		mainLayout.appendChild(north);
		north.appendChild(northPanel);
		north.setHeight("38px");
		//
		northPanel.appendChild(progressbar);
		progressbar.setWidth("100%");
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
		statusField.addValueChangeListener(this);
		
		//
		West west = new West();
		mainLayout.appendChild(west);	
		west.appendChild(wfnodeTree);
		wfnodeTree.setVflex("1");
		wfnodeTree.setHflex("1");
		west.setAutoscroll(true);
		west.setWidth("30%");
		
		Grid gridView = new Grid();
		gridView.setStyle("margin:0; padding:0;");
		gridView.makeNoStrip();
		gridView.setOddRowSclass("even");

		Rows rows = new Rows();
		gridView.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.setAlign("center");
		row.appendChild(titleLabel);
		titleLabel.setStyle("font-weight: bold; font-size: 14px");

		row = new Row();
		rows.appendChild(row);
		row.appendChild(helpFrame);
		helpFrame.setWidth("99%");
		helpFrame.setHeight("90%");
		helpFrame.setStyle("min-height:300px; border: 1px solid lightgray; margin:auto");

		row = new Row();
		rows.appendChild(row);
		row.appendChild(notesLabel);
		notesLabel.setWidth("100%");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(notesField);
		notesField.setRows(4);
		notesField.setWidth("100%");

		row = new Row();
		rows.appendChild(row);
		Div div = new Div();
		div.appendChild(statusLabel);
		div.appendChild(statusField.getComponent());
		div.appendChild(new Space());
		div.setAlign("right");
		div.appendChild(bRefresh);
		div.appendChild(bOK);
		div.appendChild(bNext);
		row.appendChild(div);

		East east = new East();
		mainLayout.appendChild(east);
		east.appendChild(gridView);
		east.setCollapsible(false);
		east.setSplittable(true);
		east.setWidth("70%");

		setNotesPanelVisible(false);
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
			refresh();
			showInRightPanel(0, m_node.getAD_WF_Node_ID());
		} else if (e.getTarget() == bOK) {
			save(notesField.getText(), (String) statusField.getValue());
			showInRightPanel(0, m_node.getAD_WF_Node_ID());
			refreshProgress();
		} else if (e.getTarget() == bNext) {
			navigateToNext();
		}
	}	//	actionPerformed

	private void refresh() {
		if (m_node != null) {
			MWizardProcess wp = MWizardProcess.get(Env.getCtx(), m_node.getAD_WF_Node_ID(), Env.getAD_Client_ID(Env.getCtx()));
			notesField.setText(wp.getNote());
			statusField.setValue(wp.getWizardStatus());
		}
	}

	private void navigateToNext() {
		if (m_node != null) {
			save(notesField.getText(), (String) statusField.getValue());
			refreshProgress();
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
		} else if (ti.getAttribute("AD_WF_Node_ID") != null) {
			// MWFNode
			int nodeid = (Integer) ti.getAttribute("AD_WF_Node_ID");
			showInRightPanel(0, nodeid);
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
			setNotesPanelVisible(true);
		} else {
			MWorkflow wf = MWorkflow.get(Env.getCtx(), ad_workflow_id);
			title = wf.getName(true);
			help = wf.getHelp(true);
			setNotesPanelVisible(false);
			m_node = null;
		}
		titleLabel.setText(title);
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
	}

	public ADForm getForm() 
	{
		return form;
	}

	@Override
	public void valueChange(ValueChangeEvent e) {
		log.info(e.getPropertyName() + "=" + e.getNewValue());
		/* if (e.getPropertyName().equals("WizardStatus")) */
	}

} // WSetupWizard
