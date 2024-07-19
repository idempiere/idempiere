/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.webui.apps.form;

import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Searchbox;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.SimpleTreeModel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.apps.form.TreeMaintenance;
import org.compiere.model.MTree;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.East;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.North;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tree;
import org.zkoss.zul.TreeModel;
import org.zkoss.zul.TreeNode;
import org.zkoss.zul.Treeitem;

/**
 * Tree maintenance form.
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VTreeMaintenance")
public class WTreeMaintenance extends TreeMaintenance implements IFormController, EventListener<Event>
{
	/** Custom form/window UI instance */
	private CustomForm form = new CustomForm();	
	
	/** Main layout of {@link #form} */
	private Borderlayout	mainLayout	= new Borderlayout ();
	
	/** North of {@link #mainLayout}. Form parameters and controls. */
	private Panel 			northPanel	= new Panel ();
	private Label			treeLabel	= new Label ();
	/** AD_Tree records drop down list. */
	private Listbox			treeField;
	private ToolBarButton	bAddAll		= new ToolBarButton ();
	private ToolBarButton	bAdd		= new ToolBarButton ();
	private ToolBarButton	bDelete		= new ToolBarButton ();
	private ToolBarButton	bDeleteAll	= new ToolBarButton ();
	private Checkbox		cbAllNodes	= new Checkbox ();
	/** Text to filter {@link #centerList} **/
	private Searchbox      searchBox   = new Searchbox();
	
	/** Center of {@link #mainLayout}. Tree of selected AD_Tree record from {@link #treeField}. */
	private Tree			centerTree;
	/** East of {@link #mainLayout}. List of all tree node records. */
	private Listbox			centerList	= new Listbox();

	/**
	 * Default constructor
	 */
	public WTreeMaintenance()
	{
		try
		{
			m_WindowNo = form.getWindowNo();
			preInit();
			jbInit ();
			action_loadTree();
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "VTreeMaintenance.init", ex);
		}
	}
	
	/**
	 * Fill {@link #treeField} and create {@link #centerTree}.
	 */
	private void preInit()
	{
		treeField = new Listbox(getTreeData());
		treeField.setMold("select");
		treeField.addActionListener(this);
		treeField.setSelectedIndex(0);
		//
		centerTree = new Tree();
		centerTree.addEventListener(Events.ON_SELECT, this);
		centerTree.addEventListener(Events.ON_DOUBLE_CLICK, this);
	}	//	preInit
	
	/**
	 * 	Layout {@link #form}
	 *	@throws Exception
	 */
	private void jbInit () throws Exception
	{
		if (ThemeManager.isUseFontIconForImage()) {
			bAddAll.setIconSclass("z-icon-FastBack");
			bAdd.setIconSclass("z-icon-StepBack");
			bDelete.setIconSclass("z-icon-StepForward");
			bDeleteAll.setIconSclass("z-icon-FastForward");
		} else {
			bAddAll.setImage(ThemeManager.getThemeResource("images/FastBack24.png"));
			bAdd.setImage(ThemeManager.getThemeResource("images/StepBack24.png"));
			bDelete.setImage(ThemeManager.getThemeResource("images/StepForward24.png"));
			bDeleteAll.setImage(ThemeManager.getThemeResource("images/FastForward24.png"));
		}
		
		ZKUpdateUtil.setWidth(form,"100%");
		ZKUpdateUtil.setHeight(form, "100%");
		form.setStyle("position: relative; padding: 0; margin: 0");
		form.appendChild (mainLayout);
		ZKUpdateUtil.setWidth(mainLayout, "100%");
		ZKUpdateUtil.setHeight(mainLayout, "100%");
		
		treeLabel.setText (Msg.translate(Env.getCtx(), "AD_Tree_ID"));
		cbAllNodes.setEnabled (false);
		cbAllNodes.setText (Msg.translate(Env.getCtx(), "IsAllNodes"));
		bAdd.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddToTree"));
		bAddAll.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddAllToTree"));
		bDelete.setTooltiptext(Msg.getMsg(Env.getCtx(), "DeleteFromTree"));
		bDeleteAll.setTooltiptext(Msg.getMsg(Env.getCtx(), "DeleteAllFromTree"));
		bAdd.addEventListener(Events.ON_CLICK, this);
		bAddAll.addEventListener(Events.ON_CLICK, this);
		bDelete.addEventListener(Events.ON_CLICK, this);
		bDeleteAll.addEventListener(Events.ON_CLICK, this);
		
		North north = new North();
		mainLayout.appendChild(north);
		north.appendChild(northPanel);
		ZKUpdateUtil.setHflex(north, "1");
		ZKUpdateUtil.setVflex(north, "min");
		ZKUpdateUtil.setWidth(northPanel, "100%");
		ZKUpdateUtil.setVflex(northPanel, "min");
		//
		Hbox hbox = new Hbox();
		hbox.setStyle("padding: 3px;");
		hbox.setAlign("center");
		ZKUpdateUtil.setHflex(hbox, "1");
		ZKUpdateUtil.setVflex(hbox, "1");
		northPanel.appendChild(hbox);
		
		if (ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH-1))
			treeField.setStyle("max-width: 200px");
		hbox.appendChild (treeLabel);
		hbox.appendChild (treeField);
		hbox.appendChild (new Space());
		hbox.appendChild (cbAllNodes);		

		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
		{
			hbox = new Hbox();
			hbox.setAlign("center");
			hbox.setStyle("padding-top: 3px; padding-bottom: 3px;");
			ZKUpdateUtil.setWidth(hbox, "100%");
			ZKUpdateUtil.setVflex(hbox, "min");
			northPanel.appendChild(hbox);
		}
		else
		{
			hbox.appendChild (new Space());
		}
		
		Hlayout div = new Hlayout();
		div.appendChild (bAddAll);
		div.appendChild (bAdd);
		div.appendChild (bDelete);
		div.appendChild (bDeleteAll);
		ZKUpdateUtil.setVflex(div, "min");

		searchBox.addEventListener(Events.ON_CLICK, this);
		searchBox.getTextbox().addEventListener(Events.ON_OK, this);
		if (ThemeManager.isUseFontIconForImage())
			searchBox.getButton().setIconSclass("z-icon-Search");
		else
			searchBox.getButton().setImage(ThemeManager.getThemeResource("images/Find16.png"));
		searchBox.setToolTipText(Msg.getCleanMsg(Env.getCtx(), "TreeSearch"));
		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
			ZKUpdateUtil.setHflex(searchBox, "1");
		else
			ZKUpdateUtil.setWidth(searchBox, "200px");
		ZKUpdateUtil.setVflex(searchBox, "min");
		div.appendChild(searchBox);
		hbox.appendChild(div);
		//
		Center center = new Center();
		mainLayout.appendChild(center);	
		center.appendChild(centerTree);
		ZKUpdateUtil.setVflex(centerTree, "1");
		ZKUpdateUtil.setHflex(centerTree, "1");
		center.setAutoscroll(true);
		
		East east = new East();
		mainLayout.appendChild(east);
		east.appendChild(centerList);
		east.setCollapsible(false);
		east.setSplittable(true);
		ZKUpdateUtil.setWidth(east, "45%");
		ZKUpdateUtil.setVflex(centerList, true);
		centerList.setSizedByContent(false);
		centerList.addEventListener(Events.ON_SELECT, this);
		centerList.addDoubleClickListener(centerListListener);
	}	//	jbInit
	
	/** Double click listener for {@link #centerList} */
	protected EventListener<Event> centerListListener = new EventListener<Event>() {
		public void onEvent(Event event) throws Exception {
			if (Events.ON_DOUBLE_CLICK.equals(event.getName())) {
				add();
				bAdd.setDisabled(true);
			}
		}
	};

	/**
	 * Close form.
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	dispose

	/**
	 * Event Listener
	 * @param e event
	 */
	@Override
	public void onEvent (Event e)
	{
		if (e.getTarget() == treeField)
		{
			action_loadTree();
		}
		else if (e.getTarget() == bAddAll)
			action_treeAddAll();
		else if (e.getTarget() == bAdd)
		{
			add();
		}
		else if (e.getTarget() == bDelete)
		{
			remove();
		}			
		else if (e.getTarget() == bDeleteAll)
			action_treeDeleteAll();
		else if (e.getTarget() == centerList)
			onListSelection(e);
		else if (e.getTarget() == centerTree) {
			if (e.getName().equals(Events.ON_DOUBLE_CLICK))
				remove();
			else
				onTreeSelection(e);	
		}
		else if (e.getTarget() == searchBox.getButton() || e.getTarget() == searchBox.getTextbox())
			searchElement();
	}

	/**
	 * Add selected {@link #centerList} item to {@link #centerTree}.
	 */
	protected void add() {
		SimpleListModel model = (SimpleListModel) centerList.getModel();
		int i = centerList.getSelectedIndex();
		if (i >= 0) {
			action_treeAdd((ListItem)model.getElementAt(i));
		}
	}

	/**
	 * Remove selected {@link #centerList} item from {@link #centerTree}.
	 */
	protected void remove() {
		if (cbAllNodes.isChecked())
			return;

		SimpleListModel model = (SimpleListModel) centerList.getModel();
		int i = centerList.getSelectedIndex();
		if (i >= 0) {
			action_treeDelete((ListItem)model.getElementAt(i));
		}
	}

	/**
	 * Filter {@link #centerList} with text from {@link #searchBox}.
	 */
	private void searchElement() {
		String filter = searchBox.getText() == null ? "" : searchBox.getText();
		filter = Util.deleteAccents(filter.trim().toUpperCase());
		action_loadTree(filter);
	}

	/**
	 * Load tree records into {@link #centerList} and {@link #centerTree}.
	 */
	private void action_loadTree() {
		action_loadTree(null);
	}

	/**
	 * Load tree records into {@link #centerList} and {@link #centerTree}.
	 * @param filter text to filter {@link #centerList} items (using contains).
	 */
	private void action_loadTree(String filter)
	{
		KeyNamePair tree = treeField.getSelectedItem().toKeyNamePair();
		if (log.isLoggable(Level.INFO)) log.info("Tree=" + tree);
		if (tree.getKey() <= 0)
		{
			SimpleListModel tmp = new SimpleListModel();
			centerList.setItemRenderer(tmp);
			centerList.setModel(tmp);
			return;
		}
		//	Tree
		m_tree = new MTree (Env.getCtx(), tree.getKey(), null);
		cbAllNodes.setSelected(m_tree.isAllNodes());
		bAddAll.setDisabled(m_tree.isAllNodes());
		bAdd.setDisabled(m_tree.isAllNodes());
		bDelete.setDisabled(m_tree.isAllNodes());
		bDeleteAll.setDisabled(m_tree.isAllNodes());
		
		//	List
		SimpleListModel model = new SimpleListModel();
		ArrayList<ListItem> items = getTreeItemData();
		for (ListItem item : items) {
			if (Util.isEmpty(filter)) {
				model.addElement(item);
			} else {
				String valueItem = item.toString() == null ? "" : Util.deleteAccents(item.toString().toUpperCase());
				if (valueItem.contains(filter)) {
					model.addElement(item);
				}
			}
		}
		
		if (log.isLoggable(Level.CONFIG)) log.config("#" + model.getSize());
		centerList.setItemRenderer(model);
		centerList.setModel(model);
		
		//	Tree
		try {
			centerTree.setModel(null);
		} catch (Exception e) {
		}
		if (centerTree.getTreecols() != null)
			centerTree.getTreecols().detach();
		if (centerTree.getTreefoot() != null)
			centerTree.getTreefoot().detach();
		if (centerTree.getTreechildren() != null)
			centerTree.getTreechildren().detach();

		SimpleTreeModel.initADTree(centerTree, m_tree.getAD_Tree_ID(), m_WindowNo);
		if (m_tree.isLoadAllNodesImmediately())
			TreeUtils.collapseTree(centerTree, true);
	}	//	action_fillTree
	
	/**
	 * 	On {@link #centerList} selection.
	 *	@param e event
	 */
	private void onListSelection(Event e)
	{
		ListItem selected = null;
		try		
		{	
			SimpleListModel model = (SimpleListModel) centerList.getModel();
			int i = centerList.getSelectedIndex();
			selected = (ListItem)model.getElementAt(i);
		}
		catch (Exception ex)
		{
		}
		if (log.isLoggable(Level.INFO)) log.info("Selected=" + selected);
		if (selected != null)	//	allow add if not in tree
		{
			SimpleTreeModel tm = (SimpleTreeModel)(TreeModel<?>) centerTree.getModel();
			DefaultTreeNode<Object> stn = tm.find(tm.getRoot(), selected.id);
			if (stn != null) {
				int[] path = tm.getPath(stn);
				Treeitem ti = centerTree.renderItemByPath(path);
				ti.setSelected(true);
			}
			bAdd.setDisabled(stn != null);
		}
	}
	
	/**
	 * 	On {@link #centerTree} selection.
	 *	@param e event
	 */
	private void onTreeSelection (Event e)
	{
		Treeitem ti = centerTree.getSelectedItem();
		DefaultTreeNode<?> stn = (DefaultTreeNode<?>) ti.getValue();
		MTreeNode tn = (MTreeNode)stn.getData();
		if (tn == null)
			return;
		if (log.isLoggable(Level.INFO)) log.info(tn.toString());
		ListModel<Object> model = centerList.getModel();
		int size = model.getSize();
		int found = -1;
		for (int index = 0; index < size; index++)
		{
			ListItem item = (ListItem)model.getElementAt(index);
			if (item.id == tn.getNode_ID()) {
				found = index;
				break;
			}
		}
		centerList.setSelectedIndex(found);
	}

	/**
	 * Add item to {@link #centerTree}.<br/>
	 * Add Tree Node (MTree_NodePR, MTree_NodeBP, MTree_NodeMM or MTree_Node) record.
	 * @param item {@link ListItem}
	 */
	private void action_treeAdd(ListItem item)
	{
		if (log.isLoggable(Level.INFO)) log.info("Item=" + item);
		if (item != null)
		{
			SimpleTreeModel model = (SimpleTreeModel)(TreeModel<?>) centerTree.getModel();
			DefaultTreeNode<Object> stn = model.find(model.getRoot(), item.id);
			if (stn != null) {
				MTreeNode tNode = (MTreeNode) stn.getData();
				tNode.setName(item.name);
				tNode.setAllowsChildren(item.isSummary);
				tNode.setImageIndicator(item.imageIndicator);
				model.nodeUpdated(stn);
				Treeitem ti = centerTree.renderItemByPath(model.getPath(stn));
				ti.setTooltiptext(item.description);
			} else {
				stn = new DefaultTreeNode<Object>(new MTreeNode(item.id, 0, item.name, item.description, 0, item.isSummary,
						item.imageIndicator, false, null), new ArrayList<TreeNode<Object>>());
				model.addNode(stn);
				//	May cause Error if in tree
				addNode(item);
			}			
		}
	}	//	action_treeAdd
	
	/**
	 * 	Remove item from {@link #centerTree}.<br/>
	 *  Delete Tree Node (MTree_NodePR, MTree_NodeBP, MTree_NodeMM or MTree_Node) record.
	 * 	@param item {@link ListItem}
	 */
	private void action_treeDelete(ListItem item)
	{
		if (log.isLoggable(Level.INFO)) log.info("Item=" + item);
		if (item != null)
		{
			SimpleTreeModel model = (SimpleTreeModel)(TreeModel<?>) centerTree.getModel();
			DefaultTreeNode<Object> stn = model.find(model.getRoot(), item.id);
			if (stn != null)
				model.removeNode(stn);			
			//
			deleteNode(item);
		}
	}	//	action_treeDelete

	
	/**
	 * Add all items from {@link #centerList} to {@link #centerTree}.
	 */
	private void action_treeAddAll()
	{
		// idempiere-85
		Dialog.ask(m_WindowNo, "TreeAddAllItems", new Callback<Boolean>() {			
			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					if (log.isLoggable(Level.INFO)) log.info("");
					ListModel<Object> model = centerList.getModel();
					int size = model.getSize();
					int index = -1;
					for (index = 0; index < size; index++)
					{
						ListItem item = (ListItem)model.getElementAt(index);
						action_treeAdd(item);
					}
				}
			}
		});
	}	//	action_treeAddAll
	
	/**
	 * Delete All Nodes from Tree
	 */
	private void action_treeDeleteAll()
	{
		if (log.isLoggable(Level.INFO)) log.info("");
		// idempiere-85
		Dialog.ask(m_WindowNo, "TreeRemoveAllItems", new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					ListModel<Object> model = centerList.getModel();
					int size = model.getSize();
					int index = -1;
					for (index = 0; index < size; index++)
					{
						ListItem item = (ListItem)model.getElementAt(index);
						action_treeDelete(item);
					}
				}
				
			}
		});
	}	//	action_treeDeleteAll
	
	@Override
	public ADForm getForm() 
	{
		return form;
	}
}
