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

import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.Icon;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.apps.wf.WFNodeWidget;
import org.compiere.model.MEntityType;
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
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Menuitem;
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
	private Toolbarbutton zoomOutButton;
	private Toolbarbutton zoomInButton;
	private Toolbarbutton zoomFitButton;
	private Toolbarbutton zoomActualButton;
	private Toolbarbutton zoomMenuButton;
	private Menupopup zoomPopup;
	private Label zoomLabel;
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
		// cap the picker width, workflow names can be very long; vw based
		// so it also holds on phones without a mobile viewport
		workflowList.setStyle("max-width:42vw;");
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
		// canvas zoom of the client side graph (its own zoom row is hidden,
		// these buttons drive it through idempiere.wfgraph.zoom); separated
		// with a bar so the zoom plus is not confused with the new button.
		// mobile clients get a single zoom menu instead of four buttons,
		// same idea as the AD window toolbar overflow (ShowMore).
		Separator zoomSep = new Separator();
		zoomSep.setOrient("vertical");
		zoomSep.setBar(true);
		toolbar.appendChild(zoomSep);
		if (ClientInfo.isMobile()) {
			zoomPopup = new Menupopup();
			addZoomMenuItem("ZoomIn", "in");
			addZoomMenuItem("ZoomOut", "out");
			addZoomMenuItem("FitToWidth", "fit");
			addZoomMenuItem("ActualSize", "actual");
			zoomMenuButton = new Toolbarbutton();
			zoomMenuButton.setLabel("\u2922");
			toolbar.appendChild(zoomMenuButton);
			zoomMenuButton.addEventListener(Events.ON_CLICK, this);
			zoomLabel = new Label("100%");
			zoomLabel.setSclass("wf-zoom-label-host");
			zoomLabel.setStyle("min-width:42px;text-align:center;color:#57606a;");
			toolbar.appendChild(zoomLabel);
		} else {
			zoomOutButton = new Toolbarbutton();
			zoomOutButton.setLabel("\u2212");
			toolbar.appendChild(zoomOutButton);
			zoomOutButton.addEventListener(Events.ON_CLICK, this);
			zoomOutButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ZoomOut")));
			zoomLabel = new Label("100%");
			zoomLabel.setSclass("wf-zoom-label-host");
			zoomLabel.setStyle("min-width:42px;text-align:center;color:#57606a;");
			toolbar.appendChild(zoomLabel);
			zoomInButton = new Toolbarbutton();
			zoomInButton.setLabel("+");
			toolbar.appendChild(zoomInButton);
			zoomInButton.addEventListener(Events.ON_CLICK, this);
			zoomInButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ZoomIn")));
			zoomFitButton = new Toolbarbutton();
			zoomFitButton.setLabel("\u2922");
			toolbar.appendChild(zoomFitButton);
			zoomFitButton.addEventListener(Events.ON_CLICK, this);
			zoomFitButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "FitToWidth")));
			zoomActualButton = new Toolbarbutton();
			zoomActualButton.setLabel("1:1");
			toolbar.appendChild(zoomActualButton);
			zoomActualButton.addEventListener(Events.ON_CLICK, this);
			zoomActualButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ActualSize")));
		}
		ZKUpdateUtil.setHeight(north, "30px");

		graph = new WWorkflowGraph();
		graph.setEditable(true);
		// the graph's own zoom row stays hidden, zoom runs from the buttons above
		graph.setShowToolbar(false);
		// setup editor: nodes of another client are grayed out so it is
		// visible which nodes cannot be edited
		graph.setGrayLockedNodes(true);
		graph.setMenuEnabled(true);
		graph.setVflex("1");
		graph.setHflex("1");
		graph.addEventListener(WWorkflowGraph.ON_NODE_DROP, this);
		graph.addEventListener(WWorkflowGraph.ON_MENU_ACTION, this);
		graph.addEventListener(WWorkflowGraph.ON_EDGE_CREATE, this);
		center = new Center();
		layout.appendChild(center);
		center.setAutoscroll(true);
		center.appendChild(graph);

		ConfirmPanel confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		South south = new South();
		layout.appendChild(south);
		Div southDiv = new Div();
		southDiv.setStyle("display:flex;align-items:center;gap:8px;width:100%;height:100%;padding:0 6px;");
		Label hintLabel = new Label(Msg.getMsg(Env.getCtx(), "WFGraphHint"));
		hintLabel.setStyle("color:#57606a;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;flex:1;min-width:0;");
		southDiv.appendChild(hintLabel);
		southDiv.appendChild(confirmPanel);
		south.appendChild(southDiv);
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
		else if (event.getTarget() == zoomOutButton) {
			zoomGraph("out");
		}
		else if (event.getTarget() == zoomInButton) {
			zoomGraph("in");
		}
		else if (event.getTarget() == zoomFitButton) {
			zoomGraph("fit");
		}
		else if (event.getTarget() == zoomActualButton) {
			zoomGraph("actual");
		}
		else if (event.getTarget() == zoomMenuButton) {
			if (zoomPopup.getPage() == null)
				zoomPopup.setPage(getPage());
			zoomPopup.open(zoomMenuButton, "after_start");
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
			if (WWorkflowGraph.ON_NODE_DROP.equals(name)) {
				onNodeDrop(event);
			} else if (WWorkflowGraph.ON_MENU_ACTION.equals(name)) {
				String kind = WWorkflowGraph.getMenuKind(event);
				int id = WWorkflowGraph.getActionId(event);
				String action = WWorkflowGraph.getMenuAction(event);
				if (id <= 0 || action == null)
					return;
				if ("edge".equals(kind))
					runEdgeAction(id, action);
				else
					runNodeAction(id, action);
			} else if (WWorkflowGraph.ON_EDGE_CREATE.equals(name)) {
				int fromId = WWorkflowGraph.getEdgeCreateFrom(event);
				int toId = WWorkflowGraph.getEdgeCreateTo(event);
				if (fromId > 0 && toId > 0)
					createTransition(fromId, toId);
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
		WFNodeWidget widget = nodeContainer.findNode(nodeId);
		if (widget == null)
			return;
		try {
			MWFNode node = widget.getModel();
			WFNodeWidget occupied = nodeContainer.findWidget(row, col);
			MWFNode blockedBy = occupied != null ? occupied.getModel() : null;
			// a drop is allowed into an empty cell or onto an unpinned node
			boolean occupiedFree = blockedBy == null
					|| blockedBy.getAD_WF_Node_ID() == nodeId
					|| (blockedBy.getXPosition() <= 0 || blockedBy.getYPosition() <= 0);
			if (canEditNode(node)
					&& col <= WFNodeContainer.MAX_COLUMN_COUNT
					&& row <= WFNodeContainer.MAX_ROW_COUNT
					&& occupiedFree) {
				node.setXPosition(col);
				node.setYPosition(row);
				node.saveEx();
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} finally {
			// Restore the persisted position after accepted and rejected drops.
			reload(m_workflowId, true);
		}
	}

	/**
	 * Create new workflow node
	 */
	private void createNewNode() {
		final int workflowId = m_workflowId;
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
				if (name != null && name.length() > 0
						&& workflowId == m_workflowId)
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
		// the setup editor is always interactive; editability is decided per
		// node by the client rule (see canEditNode and the grayed out nodes)
		graph.setEditable(true);
		graph.setModel(nodeContainer.toJson());
	}

	/**
	 * Execute a client side menu action on a workflow node. The action logic
	 * (including authorization checks) lives in {@link WFPopupItem#execute(WFEditor)}.
	 * @param AD_WF_Node_ID workflow node id
	 * @param action zoom, properties, deleteNode, pinPosition or unpinPosition
	 */
	protected void runNodeAction(int AD_WF_Node_ID, String action) {
		if (nodeContainer == null)
			return;
		WFNodeWidget widget = nodeContainer.findNode(AD_WF_Node_ID);
		if (widget == null)
			return;
		MWFNode node = widget.getModel();
		if ("pinPosition".equals(action)) {
			pinNodePosition(node, true);
			return;
		}
		if ("unpinPosition".equals(action)) {
			pinNodePosition(node, false);
			return;
		}
		int popupAction;
		if ("properties".equals(action))
			popupAction = WFPopupItem.WFPOPUPITEM_PROPERTIES;
		else if ("deleteNode".equals(action)) {
			Dialog.ask(getWindowNo(), "DeleteRecord?", new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						WFPopupItem delItem = new WFPopupItem(node.getName(true), node, WFPopupItem.WFPOPUPITEM_DELETENODE);
						executePopupItem(delItem);
					}
				}
			});
			return;
		}
		else
			popupAction = WFPopupItem.WFPOPUPITEM_ZOOM;
		WFPopupItem item = new WFPopupItem(node.getName(true), node, popupAction);
		executePopupItem(item);
	}

	/**
	 * Pin a node to its current grid cell or release it back to automatic
	 * layout, then reload the workflow.
	 * @param node workflow node
	 * @param pin true to pin, false to release
	 */
	void pinNodePosition(MWFNode node, boolean pin) {
		if (!canEditNode(node))
			return;
		WFNodeWidget widget = nodeContainer.findNode(node.getAD_WF_Node_ID());
		if (pin) {
			if (widget != null) {
				node.setXPosition(widget.getColumn());
				node.setYPosition(widget.getRow());
			}
		} else {
			node.setXPosition(0);
			node.setYPosition(0);
		}
		node.saveEx();
		reload(m_workflowId, true);
	}

	/**
	 * Execute a client side menu action on a workflow transition.
	 * @param AD_WF_NodeNext_ID transition id
	 * @param action zoom or deleteLine
	 */
	protected void runEdgeAction(int AD_WF_NodeNext_ID, String action) {
		MWFNodeNext line = findTransition(AD_WF_NodeNext_ID);
		if (line == null)
			return;
		WFPopupItem item;
		if ("deleteLine".equals(action)) {
			Dialog.ask(getWindowNo(), "DeleteRecord?", new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						WFPopupItem delItem = new WFPopupItem(Msg.getMsg(Env.getCtx(), "DeleteLine"), line);
						executePopupItem(delItem);
					}
				}
			});
			return;
		}
		else if ("properties".equals(action))
			item = new WFPopupItem(Msg.getMsg(Env.getCtx(), "Properties"), line, WFPopupItem.WFPOPUPITEM_PROPERTIESLINE);
		else
			item = new WFPopupItem(Msg.getMsg(Env.getCtx(), "Zoom"), line, WFPopupItem.WFPOPUPITEM_ZOOMLINE);
		executePopupItem(item);
	}

	/**
	 * Run a popup item action. The item is attached to the page so dialogs
	 * opened by the action find their parent.
	 * @param item popup item to execute
	 */
	private void executePopupItem(WFPopupItem item) {
		item.setPage(graph.getPage());
		try {
			item.execute(this);
		} finally {
			item.detach();
		}
	}

	/**
	 * Create a transition from one node to another (connect by drag).
	 * Shared core used by drag events and popup menu actions.
	 * @param node source workflow node
	 * @param AD_WF_NodeTo_ID target workflow node id
	 * @return the new transition, or null if rejected
	 */
	protected MWFNodeNext createTransition(MWFNode node, int AD_WF_NodeTo_ID) {
		if (nodeContainer == null || node == null)
			return null;
		if (!canAddTransition(node, AD_WF_NodeTo_ID)) {
			logger.warning("Rejected unauthorized workflow transition creation");
			return null;
		}
		int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		MWFNodeNext newLine = new MWFNodeNext(node, AD_WF_NodeTo_ID);
		newLine.setClientOrg(AD_Client_ID, 0);
		newLine.setSeqNo(0);
		if (AD_Client_ID > 11)
			newLine.setEntityType(MSysConfig.getValue(MSysConfig.DEFAULT_ENTITYTYPE, MEntityType.ENTITYTYPE_UserMaintained));
		newLine.saveEx();
		if (logger.isLoggable(Level.INFO))
			logger.info("Add Line to " + node + " -> " + newLine);
		reload(m_workflowId, true);
		return newLine;
	}

	/**
	 * Create a transition from one node to another (connect by drag).
	 * @param AD_WF_Node_ID source workflow node id
	 * @param AD_WF_NodeTo_ID target workflow node id
	 */
	protected void createTransition(int AD_WF_Node_ID, int AD_WF_NodeTo_ID) {
		if (nodeContainer == null)
			return;
		WFNodeWidget widget = nodeContainer.findNode(AD_WF_Node_ID);
		if (widget == null)
			return;
		createTransition(widget.getModel(), AD_WF_NodeTo_ID);
	}

	/**
	 * Check that a node belongs to and can be changed in the displayed
	 * workflow. Consistent with the client side gray rule: editability is
	 * per node and only depends on the client.
	 * @param node workflow node
	 * @return true if the node can be changed
	 */
	protected boolean canEditNode(MWFNode node) {
		return node != null
				&& node.getAD_Workflow_ID() == m_workflowId
				&& node.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())
				&& nodeContainer != null && nodeContainer.findNode(node.getAD_WF_Node_ID()) != null;
	}

	/**
	 * Check that a transition belongs to and can be changed in the displayed
	 * workflow. Consistent with the client side gray rule: editability is
	 * per node (the source) and only depends on the client.
	 * @param line workflow transition
	 * @return true if the transition can be changed
	 */
	protected boolean canEditTransition(MWFNodeNext line) {
		if (line == null
				|| line.getAD_Client_ID() != Env.getAD_Client_ID(Env.getCtx())
				|| findTransition(line.getAD_WF_NodeNext_ID()) == null)
			return false;
		WFNodeWidget source = nodeContainer.findNode(line.getAD_WF_Node_ID());
		return source != null && source.getModel().getAD_Workflow_ID() == m_workflowId
				&& nodeContainer.findNode(line.getAD_WF_Next_ID()) != null;
	}

	/**
	 * Check a target before adding a transition from a node. The source
	 * node only anchors the new transition (it is not modified), so
	 * transitions may start from locked nodes of another client as well;
	 * the new line itself belongs to the current client.
	 * @param node source workflow node
	 * @param targetNodeId target workflow node id
	 * @return true if both nodes can be used for the new transition
	 */
	protected boolean canAddTransition(MWFNode node, int targetNodeId) {
		if (node == null || node.getAD_Workflow_ID() != m_workflowId
				|| nodeContainer == null || nodeContainer.findNode(node.getAD_WF_Node_ID()) == null
				|| targetNodeId <= 0 || nodeContainer.findNode(targetNodeId) == null)
			return false;
		for (MWFNodeNext line : nodeContainer.getEdges()) {
			if (line.getAD_WF_Node_ID() == node.getAD_WF_Node_ID()
					&& line.getAD_WF_Next_ID() == targetNodeId)
				return false;
		}
		return true;
	}

	private MWFNodeNext findTransition(int transitionId) {
		if (nodeContainer != null) {
			for (MWFNodeNext line : nodeContainer.getEdges()) {
				if (line.getAD_WF_NodeNext_ID() == transitionId)
					return line;
			}
		}
		return null;
	}

	/**
	 * Add a canvas zoom entry to the mobile zoom menu.
	 * @param msgKey message key for the item label
	 * @param mode zoom mode for idempiere.wfgraph.zoom
	 */
	private void addZoomMenuItem(String msgKey, String mode) {
		Menuitem item = new Menuitem(Util.cleanAmp(Msg.getMsg(Env.getCtx(), msgKey)));
		item.setValue(mode);
		item.addEventListener(Events.ON_CLICK, event -> zoomGraph((String) ((Menuitem) event.getTarget()).getValue()));
		zoomPopup.appendChild(item);
	}

	/**
	 * Drive the client side graph zoom from the symbol bar buttons.
	 * @param mode in, out, fit or actual (see idempiere.wfgraph.zoom)
	 */
	private void zoomGraph(String mode) {
		if (graph == null || graph.getPage() == null)
			return;
		Clients.evalJavaScript("if(window.idempiere&&idempiere.wfgraph&&idempiere.wfgraph.zoom)"
				+ "idempiere.wfgraph.zoom('" + graph.getUuid() + "','" + mode + "');");
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
}
