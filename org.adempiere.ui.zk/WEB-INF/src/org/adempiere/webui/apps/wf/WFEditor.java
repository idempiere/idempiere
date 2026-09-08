/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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
package org.adempiere.webui.apps.wf;

import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.Icon;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.apps.wf.WFNodeWidget;
import org.compiere.model.MEntityType;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Toolbarbutton;
import org.adempiere.webui.component.FlexHlayout;
import org.zkoss.zul.Label;
import org.adempiere.webui.component.FlexVlayout;

/**
 * Workflow editor form.
 *
 * <p>Renders the workflow as client side SVG via {@link WWorkflowGraph}.
 * Nodes are dragged to a new grid cell to change their position.</p>
 *
 * @author Low Heng Sin
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.wf.WFPanel")
public class WFEditor extends ADForm {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 4293422396394778274L;

	/** Workflows dropdown list */
	private Listbox workflowList;
	private int m_workflowId = 0;
	private Toolbarbutton zoomButton;
	private Toolbarbutton refreshButton;
	private Toolbarbutton newButton;
	/** SVG workflow graph */
	private WWorkflowGraph graph;
	/** Center of form */
	private Center center;
	private MWorkflow m_wf;
	private WFNodeContainer nodeContainer;

	/**
	 * Layout form
	 */
	@Override
	protected void initForm() {
		ZKUpdateUtil.setHeight(this, "100%");
		Borderlayout layout = new Borderlayout();
		layout.setStyle("width: 100%; height: 100%; position: relative;");
		appendChild(layout);
		KeyNamePair[] pp = MWorkflow.getWorkflowKeyNamePairs(true);

		workflowList = ListboxFactory.newDropdownListbox();
		for (KeyNamePair knp : pp) {
			workflowList.addItem(knp);
		}
		workflowList.addEventListener(Events.ON_SELECT, this);

		North north = new North();
		layout.appendChild(north);
		ToolBar toolbar = new ToolBar();
		north.appendChild(toolbar);
		toolbar.appendChild(workflowList);
		// Zoom
		zoomButton = new Toolbarbutton();
		if (ThemeManager.isUseFontIconForImage())
			zoomButton.setIconSclass(Icon.getIconSclass(Icon.ZOOM));
		else
			zoomButton.setImage(ThemeManager.getThemeResource("images/Zoom16.png"));
		toolbar.appendChild(zoomButton);
		zoomButton.addEventListener(Events.ON_CLICK, this);
		zoomButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Zoom")));
		// New Node
		newButton = new Toolbarbutton();
		if (ThemeManager.isUseFontIconForImage())
			newButton.setIconSclass(Icon.getIconSclass(Icon.NEW));
		else
			newButton.setImage(ThemeManager.getThemeResource("images/New16.png"));
		toolbar.appendChild(newButton);
		newButton.addEventListener(Events.ON_CLICK, this);
		newButton.setTooltiptext(Msg.getMsg(Env.getCtx(), "CreateNewNode"));
		// Refresh
		refreshButton = new Toolbarbutton();
		if (ThemeManager.isUseFontIconForImage())
			refreshButton.setIconSclass(Icon.getIconSclass(Icon.REFRESH));
		else
			refreshButton.setImage(ThemeManager.getThemeResource("images/Refresh16.png"));
		toolbar.appendChild(refreshButton);
		refreshButton.addEventListener(Events.ON_CLICK, this);
		refreshButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
		ZKUpdateUtil.setHeight(north, "30px");

		graph = new WWorkflowGraph();
		graph.setEditable(true);
		graph.setVflex("1");
		graph.setHflex("1");
		graph.addEventListener(WWorkflowGraph.ON_NODE_CLICK, this);
		graph.addEventListener(WWorkflowGraph.ON_NODE_CONTEXT, this);
		graph.addEventListener(WWorkflowGraph.ON_NODE_DBL_CLICK, this);
		graph.addEventListener(WWorkflowGraph.ON_NODE_DROP, this);
		center = new Center();
		layout.appendChild(center);
		center.setAutoscroll(true);
		center.appendChild(graph);

		ConfirmPanel confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		South south = new South();
		layout.appendChild(south);
		south.appendChild(confirmPanel);
		ZKUpdateUtil.setHeight(south, "36px");
	}

	@Override
	public void onEvent(Event event) throws Exception {
		super.onEvent(event);

		if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			this.detach();
		else if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
			this.detach();
		else if (event.getTarget() == workflowList) {
			ListItem item = workflowList.getSelectedItem();
			KeyNamePair knp = item != null ? item.toKeyNamePair() : null;
			if (knp != null && knp.getKey() > 0) {
				load(knp.getKey(), true);
			}
		}
		else if (event.getTarget() == zoomButton) {
			if (workflowList.getSelectedIndex() > 0)
				zoom();
		}
		else if (event.getTarget() == refreshButton) {
			if (workflowList.getSelectedIndex() > 0)
				reload(m_workflowId, true);
		}
		else if (event.getTarget() == newButton) {
			if (workflowList.getSelectedIndex() > 0)
				createNewNode();
		}
		else if (event.getTarget() instanceof WFPopupItem) {
			WFPopupItem item = (WFPopupItem) event.getTarget();
			item.execute(this);
		}
		else if (event.getTarget() == graph) {
			String name = event.getName();
			if (WWorkflowGraph.ON_NODE_CLICK.equals(name)
					|| WWorkflowGraph.ON_NODE_CONTEXT.equals(name)
					|| WWorkflowGraph.ON_NODE_DBL_CLICK.equals(name)) {
				int nodeId = WWorkflowGraph.getNodeId(event);
				if (nodeId > 0)
					showNodeMenu(nodeId);
			} else if (WWorkflowGraph.ON_NODE_DROP.equals(name)) {
				onNodeDrop(event);
			}
		}
	}

	/**
	 * Move a workflow node to the dropped grid cell
	 * @param event drop event from {@link WWorkflowGraph}
	 */
	private void onNodeDrop(Event event) {
		int nodeId = WWorkflowGraph.getNodeId(event);
		int row = WWorkflowGraph.getDropRow(event);
		int col = WWorkflowGraph.getDropColumn(event);
		if (nodeId <= 0 || row <= 0 || col <= 0 || nodeContainer == null)
			return;
		try {
			WFNodeWidget widget = nodeContainer.findNode(nodeId);
			if (widget != null) {
				MWFNode node = widget.getModel();
				if (node.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
					node.setXPosition(col);
					node.setYPosition(row);
					node.saveEx();
				}
				// reload even for rejected cross-client drops so the client
				// discards the dropped position and shows the persisted one
				reload(m_workflowId, true);
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
	}

	/**
	 * Create new workflow node
	 */
	private void createNewNode() {
		String nameLabel = Msg.getElement(Env.getCtx(), MWFNode.COLUMNNAME_Name);
		String title = Msg.getMsg(Env.getCtx(), "CreateNewNode");
		final Window w = new Window();
		w.setTitle(title);
		FlexVlayout vbox = new FlexVlayout();
		w.appendChild(vbox);
		vbox.appendChild(new Separator());
		FlexHlayout hbox = new FlexHlayout();
		hbox.appendChild(new Label(nameLabel));
		hbox.appendChild(new Space());
		final Textbox text = new Textbox();
		hbox.appendChild(text);
		vbox.appendChild(hbox);
		vbox.appendChild(new Separator());
		final ConfirmPanel panel = new ConfirmPanel(true, false, false, false, false, false, false);
		vbox.appendChild(panel);
		panel.addActionListener(Events.ON_CLICK, new EventListener<Event>() {

			public void onEvent(Event event) throws Exception {
				if (event.getTarget() == panel.getButton(ConfirmPanel.A_CANCEL)) {
					text.setText("");
				}
				w.onClose();
			}
		});
		
		w.setBorder("normal");
		w.setPage(this.getPage());
		w.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				String name = text.getText();
				if (name != null && name.length() > 0)
				{
					int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
					MWFNode node = new MWFNode(m_wf, name, name);
					node.setClientOrg(AD_Client_ID, 0);
					if (AD_Client_ID > 11)
						node.setEntityType(MSysConfig.getValue(MSysConfig.DEFAULT_ENTITYTYPE, MEntityType.ENTITYTYPE_UserMaintained));
					node.saveEx();
					reload(m_wf.getAD_Workflow_ID(), true);
				}
			}
		});
		w.doHighlighted();				
	}

	/**
	 * reload and re-render workflow nodes
	 * @param workflowId
	 * @param reread
	 */
	protected void reload(int workflowId, boolean reread) {
		load(workflowId, reread);
	}

	/**
	 * Load and render workflow nodes
	 * @param workflowId
	 * @param reread
	 */
	private void load(int workflowId, boolean reread) {
		//	Get Workflow
		m_wf = MWorkflow.getCopy(Env.getCtx(), workflowId, (String)null);
		m_workflowId = workflowId;
		nodeContainer = new WFNodeContainer();

		if (reread) {
			m_wf.reloadNodes();
		}
		nodeContainer.load(m_wf, true);
		graph.setEditable(m_wf.isActive() && MRole.getDefault().canUpdate(m_wf.getAD_Client_ID(), m_wf.getAD_Org_ID(), 
			m_wf.get_Table_ID(), workflowId, false));
		graph.setModel(nodeContainer.toJson());
	}

	/**
	 * Show popup menu for workflow node
	 * @param AD_WF_Node_ID workflow node id
	 */
	protected void showNodeMenu(int AD_WF_Node_ID) {
		if (nodeContainer == null)
			return;
		WFNodeWidget widget = nodeContainer.findNode(AD_WF_Node_ID);
		if (widget == null)
			return;
		MWFNode node = widget.getModel();
		Menupopup popupMenu = new Menupopup();
		// Zoom
		addMenuItem(popupMenu, Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Zoom")), node, WFPopupItem.WFPOPUPITEM_ZOOM);
		if (node.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx()))
		{
			// Properties
			addMenuItem(popupMenu, Msg.getMsg(Env.getCtx(), "Properties"), node, WFPopupItem.WFPOPUPITEM_PROPERTIES);
			// Delete node
			String title = Msg.getMsg(Env.getCtx(), "DeleteNode") +
				": " + node.getName(true);
			addMenuItem(popupMenu, title, node, WFPopupItem.WFPOPUPITEM_DELETENODE);
		}
		MWFNode[] nodes = m_wf.getNodes(true, Env.getAD_Client_ID(Env.getCtx()));
		MWFNodeNext[] lines = node.getTransitions(Env.getAD_Client_ID(Env.getCtx()));
		//	Add New Line
		for (MWFNode nn : nodes)
		{
			if (nn.getAD_WF_Node_ID() == node.getAD_WF_Node_ID())
				continue;	//	same
			if (nn.getAD_WF_Node_ID() == node.getAD_Workflow().getAD_WF_Node_ID())
				continue;	//	don't add line to starting node
			boolean found = false;
			for (MWFNodeNext line : lines)
			{
				if (nn.getAD_WF_Node_ID() == line.getAD_WF_Next_ID())
				{
					found = true; // line already exists
					break;
				}
			}
			if (!found) {
				// Check that inverse line doesn't exist
				for (MWFNodeNext revline : nn.getTransitions(Env.getAD_Client_ID(Env.getCtx()))) {
					if (node.getAD_WF_Node_ID() == revline.getAD_WF_Next_ID())
					{
						found = true; // inverse line already exists
						break;
					}
				}
			}
			if (!found)
			{
				String title = Msg.getMsg(Env.getCtx(), "AddLine")
					+ ": " + node.getName(true) + " -> " + nn.getName(true);
				addMenuItem(popupMenu, title, node, nn.getAD_WF_Node_ID());
			}
		}
		//	Delete Lines
		for (MWFNodeNext line : lines)
		{
			if (line.getAD_Client_ID() != Env.getAD_Client_ID(Env.getCtx()))
				continue;
			MWFNode next = MWFNode.get(Env.getCtx(), line.getAD_WF_Next_ID());
			String title = Msg.getMsg(Env.getCtx(), "DeleteLine")
				+ ": " + node.getName(true) + " -> " + next.getName(true);
			addMenuItem(popupMenu, title, line);
		}
		popupMenu.setPage(graph.getPage());
		popupMenu.open(graph);
	}

	/**
	 * 	Zoom to WorkFlow window
	 */
	private void zoom()
	{
		if (m_workflowId > 0) {
			AEnv.zoom(MWorkflow.Table_ID, m_workflowId);
		}
	}	//	zoom

	/**
	 * Menu item to add line to next node or to apply actions (delete, properties or zoom) to source workflow node.
	 * @param menu popup  menu
	 * @param title title
	 * @param node source workflow node
	 * @param AD_WF_NodeTo_ID if > 0, next workflow node id. if < 0, actions to apply to node
	 */
	private void addMenuItem (Menupopup menu, String title, MWFNode node, int AD_WF_NodeTo_ID)
	{
		WFPopupItem item = new WFPopupItem (title, node, AD_WF_NodeTo_ID);
		menu.appendChild(item);
		item.addEventListener(Events.ON_CLICK, this);
	}	//	addMenuItem

	/**
	 * Add Menu Item to - delete line
	 * @param menu popup menu
	 * @param title title
	 * @param line
	 */
	private void addMenuItem (Menupopup menu, String title, MWFNodeNext line)
	{
		WFPopupItem item = new WFPopupItem (title, line);
		menu.appendChild(item);
		item.addEventListener(Events.ON_CLICK, this);
	}	//	addMenuItem
}
