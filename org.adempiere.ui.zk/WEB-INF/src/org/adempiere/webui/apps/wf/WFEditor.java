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

import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
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
import org.compiere.apps.wf.WFGraphLayout;
import org.compiere.apps.wf.WFNodeWidget;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Label;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Vbox;

/**
 *
 * @author Low Heng Sin
 *
 */
public class WFEditor extends ADForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4293422396394778274L;

	private Listbox workflowList;
	private int m_workflowId = 0;
	private Toolbarbutton zoomButton;
	private Toolbarbutton refreshButton;
	private Toolbarbutton newButton;
	private Table table;
	private Center center;
	private MWorkflow m_wf;
	private WFNodeContainer nodeContainer;

	@Override
	protected void initForm() {
		this.setHeight("100%");
		Borderlayout layout = new Borderlayout();
		layout.setStyle("width: 100%; height: 100%; position: absolute;");
		appendChild(layout);

		String sql = MRole.getDefault().addAccessSQL(
				"SELECT AD_Workflow_ID, Name FROM AD_Workflow ORDER BY 2",
				"AD_Workflow", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);	//	all
			KeyNamePair[] pp = DB.getKeyNamePairs(sql, true);

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
		workflowList.setStyle("margin-left: 10px; margin-top: 5px; margin-right:5px;");
		// Zoom
		zoomButton = new Toolbarbutton();
		zoomButton.setImage(ThemeManager.getThemeResource("images/Zoom16.png"));
		toolbar.appendChild(zoomButton);
		zoomButton.addEventListener(Events.ON_CLICK, this);
		zoomButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Zoom")));
		// New Node
		newButton = new Toolbarbutton();
		newButton.setImage(ThemeManager.getThemeResource("images/New16.png"));
		toolbar.appendChild(newButton);
		newButton.addEventListener(Events.ON_CLICK, this);
		newButton.setTooltiptext(Msg.getMsg(Env.getCtx(), "CreateNewNode"));
		// Refresh
		refreshButton = new Toolbarbutton();
		refreshButton.setImage(ThemeManager.getThemeResource("images/Refresh16.png"));
		toolbar.appendChild(refreshButton);
		refreshButton.addEventListener(Events.ON_CLICK, this);
		refreshButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
		north.setHeight("30px");

		createTable();
		center = new Center();
		layout.appendChild(center);
		center.setAutoscroll(true);
		center.appendChild(table);

		ConfirmPanel confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		South south = new South();
		layout.appendChild(south);
		south.appendChild(confirmPanel);
		south.setHeight("36px");
	}

	private void createTable() {
		table = new Table();
		table.setDynamicProperty("cellpadding", "0");
		table.setDynamicProperty("cellspacing", "0");
		table.setDynamicProperty("border", "none");
		table.setStyle("margin:0;padding:0");
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			this.detach();
		else if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
			this.detach();
		else if (event.getTarget() == workflowList) {
			center.removeChild(table);
			createTable();
			center.appendChild(table);
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
		else if (event.getName().equals(Events.ON_DROP)) {
			DropEvent dropEvent = (DropEvent) event;
			Integer AD_WF_Node_ID = (Integer) dropEvent.getDragged().getAttribute("AD_WF_Node_ID");
			Integer xPosition = (Integer) event.getTarget().getAttribute("Node.XPosition");
			Integer yPosition = (Integer) event.getTarget().getAttribute("Node.YPosition");
			if (AD_WF_Node_ID != null) {
				WFNodeWidget widget = (WFNodeWidget) nodeContainer.getGraphScene().findWidget(AD_WF_Node_ID);
				if (widget != null) {
					widget.getModel().setXPosition(xPosition);
					widget.getModel().setYPosition(yPosition);
					widget.getModel().saveEx();
					reload(m_workflowId, true);
				}
			}
		}
	}

	private void createNewNode() {
		String nameLabel = Msg.getElement(Env.getCtx(), MWFNode.COLUMNNAME_Name);
		String title = Msg.getMsg(Env.getCtx(), "CreateNewNode");
		final Window w = new Window();
		w.setTitle(title);
		Vbox vbox = new Vbox();
		w.appendChild(vbox);
		vbox.appendChild(new Separator());
		Hbox hbox = new Hbox();
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
		
		w.setWidth("250px");
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
					node.saveEx();
					reload(m_wf.getAD_Workflow_ID(), true);
				}
			}
		});
		w.doHighlighted();				
	}

	void reload(int workflowId, boolean reread) {
		center.removeChild(table);
		createTable();
		center.appendChild(table);
		load(workflowId, reread);
	}

	private void load(int workflowId, boolean reread) {
		//	Get Workflow
		m_wf = MWorkflow.get(Env.getCtx(), workflowId);
		m_workflowId = workflowId;
		nodeContainer = new WFNodeContainer();
		nodeContainer.setWorkflow(m_wf);
		
		if (reread) {
			m_wf.reloadNodes();
		}

		//	Add Nodes for Paint
		MWFNode[] nodes = m_wf.getNodes(true, Env.getAD_Client_ID(Env.getCtx()));
		List<Integer> added = new ArrayList<Integer>();
		for (int i = 0; i < nodes.length; i++)
		{
			if (!added.contains(nodes[i].getAD_WF_Node_ID()))
				nodeContainer.addNode(nodes[i]);
		}
		
		//  Add lines
		for (int i = 0; i < nodes.length; i++)
		{
			MWFNodeNext[] nexts = nodes[i].getTransitions(Env.getAD_Client_ID(Env.getCtx()));
			for (int j = 0; j < nexts.length; j++)
			{
				nodeContainer.addEdge(nexts[j]);
			}
		}

		Dimension dimension = nodeContainer.getDimension();
		BufferedImage bi = new BufferedImage (dimension.width, dimension.height, BufferedImage.TYPE_INT_ARGB);
		Graphics2D graphics = bi.createGraphics();
		nodeContainer.validate(graphics);
		nodeContainer.paint(graphics);

		try {
			int row = nodeContainer.getRowCount();
			for(int i = 0; i < row+1; i++) {
				Tr tr = new Tr();
				table.appendChild(tr);
				for(int c = 0; c < 4; c++) {
					BufferedImage t = new BufferedImage(WFGraphLayout.COLUMN_WIDTH, WFGraphLayout.ROW_HEIGHT, BufferedImage.TYPE_INT_ARGB);
					Graphics2D tg = t.createGraphics();
					Td td = new Td();
					td.setStyle("border: 1px dotted lightgray");
					tr.appendChild(td);
					
					if (i < row)
					{
						int x = c * WFGraphLayout.COLUMN_WIDTH;
						int y = i * WFGraphLayout.ROW_HEIGHT;

						tg.drawImage(bi.getSubimage(x, y, WFGraphLayout.COLUMN_WIDTH, WFGraphLayout.ROW_HEIGHT), 0, 0, null);
						org.zkoss.zul.Image image = new org.zkoss.zul.Image();
						image.setContent(t);
						td.appendChild(image);
						String imgStyle = "border:none;margin:0;padding:0";

						WFNodeWidget widget = nodeContainer.findWidget(i+1, c+1);
						if (widget != null)
						{
							MWFNode node = widget.getModel();
							if (node.getHelp(true) != null) {
								image.setTooltiptext(node.getHelp(true));
							}
							image.setAttribute("AD_WF_Node_ID", node.getAD_WF_Node_ID());
							image.addEventListener(Events.ON_CLICK, new EventListener<Event>() {

								public void onEvent(Event event) throws Exception {
									showNodeMenu(event.getTarget());
								}
							});
							image.setDraggable("WFNode");
							imgStyle = imgStyle + ";cursor:pointer";
						}
						else
						{
							image.setDroppable("WFNode");
							image.addEventListener(Events.ON_DROP, this);
							image.setAttribute("Node.XPosition", c+1);
							image.setAttribute("Node.YPosition", i+1);
						}
						image.setStyle(imgStyle);
					}
					else
					{
						Div div = new Div();
						div.setWidth((WFGraphLayout.COLUMN_WIDTH) + "px");
						div.setHeight((WFGraphLayout.ROW_HEIGHT) + "px");
						div.setAttribute("Node.XPosition", c+1);
						div.setAttribute("Node.YPosition", i+1);
						div.setDroppable("WFNode");
						div.addEventListener(Events.ON_DROP, this);
						td.appendChild(div);
					}

					tg.dispose();
				}
			}

		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}

	}

	protected void showNodeMenu(Component target) {
		Integer AD_WF_Node_ID = (Integer) target.getAttribute("AD_WF_Node_ID");
		if (AD_WF_Node_ID != null) {
			WFNodeWidget widget = (WFNodeWidget) nodeContainer.getGraphScene().findWidget(AD_WF_Node_ID);
			if (widget != null) {
				MWFNode node = widget.getModel();
				Menupopup popupMenu = new Menupopup();
				if (node.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx()))
				{
					// Zoom
					addMenuItem(popupMenu, Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Zoom")), node, WFPopupItem.WFPOPUPITEM_ZOOM);
					// Properties
					addMenuItem(popupMenu, Msg.getMsg(Env.getCtx(), "Properties"), node, WFPopupItem.WFPOPUPITEM_PROPERTIES);
					// Delete node
					String title = Msg.getMsg(Env.getCtx(), "DeleteNode") +
						": " + node.getName();
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
							+ ": " + node.getName() + " -> " + nn.getName();
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
						+ ": " + node.getName() + " -> " + next.getName();
					addMenuItem(popupMenu, title, line);
				}
				popupMenu.setPage(target.getPage());
				popupMenu.open(target);
			}

		}
	}

	/**
	 * 	Zoom to WorkFlow
	 */
	private void zoom()
	{
		if (m_workflowId > 0) {
			int AD_Window_ID = MTable.get(Env.getCtx(), MWorkflow.Table_ID).getAD_Window_ID();

			if (AD_Window_ID <= 0) {
				throw new AdempiereException("@NotFound@ @AD_Window_ID@");
			}

			MQuery query = null;
			query = MQuery.getEqualQuery("AD_Workflow_ID", m_workflowId);
			AEnv.zoom(AD_Window_ID, query);
		}
	}	//	zoom

	/**
	 * 	Add Menu Item to - add new line to node
	 *	@param menu base menu
	 *	@param title title
	 */
	private void addMenuItem (Menupopup menu, String title, MWFNode node, int AD_WF_NodeTo_ID)
	{
		WFPopupItem item = new WFPopupItem (title, node, AD_WF_NodeTo_ID);
		menu.appendChild(item);
		item.addEventListener(Events.ON_CLICK, this);
	}	//	addMenuItem

	/**
	 * 	Add Menu Item to - delete line
	 *	@param menu base menu
	 *	@param title title
	 */
	private void addMenuItem (Menupopup menu, String title, MWFNodeNext line)
	{
		WFPopupItem item = new WFPopupItem (title, line);
		menu.appendChild(item);
		item.addEventListener(Events.ON_CLICK, this);
	}	//	addMenuItem
}
