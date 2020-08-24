/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.dashboard;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.FavoriteSimpleTreeModel;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.I_AD_Tree_Favorite;
import org.compiere.model.MTable;
import org.compiere.model.MTreeFavorite;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Box;
import org.zkoss.zul.Button;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Vbox;

/**
 * Dashboard item: User's Favorite Dashboard Panel
 * 
 * @author Logilite Technologies
 * @since June 20, 2017
 */
public class DPUserFavorites extends DashboardPanel implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long		serialVersionUID	= 4341658324859506048L;

	private FavoriteSimpleTreeModel	treeModel;
	private Checkbox				chkExpand;
	private Checkbox				addAsRoot;
	private Textbox					textbox;
	private Tree					tree;

	private int						m_AD_FavTree_ID;
	private int						AD_Role_ID;
	private int						AD_Client_ID;
	private int						AD_Org_ID;
	private int						AD_User_ID;

	public DPUserFavorites()
	{
		super();

		AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());
		AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());

		Panel panel = new Panel();
		panel.setClass("fav-tree-panel");
		this.appendChild(panel);

		Panelchildren favContent = new Panelchildren();
		favContent.appendChild(createFavoritePanel());
		favContent.setDroppable(DPFavourites.FAVOURITE_DROPPABLE);
		favContent.addEventListener(Events.ON_DROP, this);
		panel.appendChild(favContent);

		chkExpand = new Checkbox();
		chkExpand.setClass("fav-chkbox");
		chkExpand.setText(Msg.getMsg(Env.getCtx(), "ExpandTree"));
		chkExpand.addEventListener(Events.ON_CHECK, this);
		chkExpand.setTooltiptext("Expand/Collapse Tree");
		ZkCssHelper.appendStyle(chkExpand, "width: 25%;");

		addAsRoot = new Checkbox();
		addAsRoot.setClass("fav-chkbox");
		addAsRoot.setText(Msg.getMsg(Env.getCtx(), "AddAsRoot"));
		addAsRoot.setTooltiptext("If checked then new node added as on root node.");
		ZkCssHelper.appendStyle(addAsRoot, "width: 20%;");

		textbox = new Textbox();
		textbox.setClass("fav-folder-textbox");
		textbox.setPlaceholder(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		textbox.setTooltiptext("Specify new node name");
		textbox.addEventListener(Events.ON_OK, this);

		Button btnAdd = new Button();
		btnAdd.setClass("fav-button-add");
		btnAdd.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		btnAdd.addEventListener(Events.ON_CLICK, this);
		ZkCssHelper.appendStyle(btnAdd, "margin: 0px 0px 0px 5px !important; padding: 5px 5px 2px 5px; width: 10%; min-width: 30px;");
		if (ThemeManager.isUseFontIconForImage())
			btnAdd.setIconSclass("z-icon-New");
		else
			btnAdd.setImage(ThemeManager.getThemeResource("images/FolderAdd24.png"));

		Toolbar favToolbar = new Toolbar();
		favToolbar.setClass("fav-toolbar");
		favToolbar.appendChild(chkExpand);
		favToolbar.appendChild(addAsRoot);
		favToolbar.appendChild(textbox);
		favToolbar.appendChild(btnAdd);
		this.appendChild(favToolbar);
	}

	private Box createFavoritePanel()
	{
		int AD_FavTree_ID = MTreeFavorite.getTreeID(AD_Client_ID, AD_Role_ID, AD_User_ID);
		if (AD_FavTree_ID == -1)
		{
			MTreeFavorite mtFav = (MTreeFavorite) MTable.get(Env.getCtx(), MTreeFavorite.Table_ID).getPO(0, null);
			mtFav.set_ValueOfColumn(I_AD_Tree_Favorite.COLUMNNAME_AD_Client_ID, AD_Client_ID);
			mtFav.setAD_Org_ID(AD_Org_ID);
			mtFav.setAD_Role_ID(AD_Role_ID);
			mtFav.setAD_User_ID(AD_User_ID);
			if (!mtFav.save())
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FavTreeNotCreate"));

			m_AD_FavTree_ID = mtFav.getAD_Tree_Favorite_ID();
		}
		else
		{
			m_AD_FavTree_ID = AD_FavTree_ID;
		}

		tree = new Tree();
		tree.setMultiple(false);
		tree.setSizedByContent(false);
		tree.setClass("menu-tree");
		ZKUpdateUtil.setWidth(tree, "100%");
		ZkCssHelper.appendStyle(tree, "border: none");

		Box box = new Vbox();
		ZKUpdateUtil.setVflex(box, "1");
		ZKUpdateUtil.setHflex(box, "1");
		box.appendChild(tree);

		initTreeModel();

		return box;
	} // createFavoritePanel

	/**
	 * Creating Tree structure
	 */
	public void initTreeModel()
	{
		treeModel = FavoriteSimpleTreeModel.initADTree(tree, m_AD_FavTree_ID, 0, true, null);
	} // initTreeModel

	/**
	 * Event Like open Menu Window, Expand/Collapse Node, Add node into Tree
	 */
	public void onEvent(Event event)
	{
		String eventName = event.getName();
		if (eventName.equals(Events.ON_CLICK))
		{
			if (event.getTarget() instanceof Button)
				addNodeBtnPressed();
		}
		else if (eventName.equals(Events.ON_OK))
		{
			addNodeBtnPressed();
		}
		else if (eventName.equals(Events.ON_CHECK) && event.getTarget() == chkExpand)
		{
			expandOnCheck();
		}
	} // onEvent

	/**
	 * When Button or Enter Key Pressed Add Node Into Tree.
	 */
	private void addNodeBtnPressed()
	{
		String nodeName = textbox.getText().toString();
		if (Util.isEmpty(nodeName))
			textbox.setFocus(true);
		else
			insertNode(nodeName);
	} // addNodeBtnPressed

	/**
	 * Insert Folder as Node to Tree.
	 */
	private void insertNode(String nodeName)
	{
		MTreeFavoriteNode tfNode = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(0, null);
		tfNode.set_ValueOfColumn(I_AD_Tree_Favorite.COLUMNNAME_AD_Client_ID, AD_Client_ID);
		tfNode.setAD_Org_ID(AD_Org_ID);
		tfNode.setAD_Tree_Favorite_ID(m_AD_FavTree_ID);
		tfNode.setIsSummary(true);
		tfNode.setName(nodeName);
		if (addAsRoot.isChecked())
			tfNode.setParent_ID(0);
		else
			tfNode.setParent_ID(treeModel.getSelectedFolderID());
		tfNode.setSeqNo(0);

		if (!tfNode.save())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NodeNotCreate"));
		else
		{
			MTreeNode mtnNew = new MTreeNode(tfNode.getAD_Tree_Favorite_Node_ID(), tfNode.getSeqNo(), tfNode.getName(),
					"", tfNode.getParent_ID(), tfNode.isSummary(), tfNode.getAD_Menu_ID(), null, false);

			DefaultTreeNode<Object> newNode = new DefaultTreeNode<Object>(mtnNew);
			DefaultTreeNode<Object> parentNode = treeModel.find(null, mtnNew.getParent_ID());

			try
			{
				treeModel.addNode(parentNode, newNode, 0);
				int[] path = treeModel.getPath(newNode);
				Treeitem ti = tree.renderItemByPath(path);
				tree.setSelectedItem(ti);
				Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));
				treeModel.setSelectedFolderID(mtnNew.getNode_ID());
				textbox.setText("");
			}
			catch (Exception e)
			{
				FDialog.warn(0, Msg.getMsg(Env.getCtx(), "SelectMenuItem"));
			}
		}
	} // insertNode

	/**
	 * Expand All Node
	 */
	public void expandAll()
	{
		if (!chkExpand.isChecked())
			chkExpand.setChecked(true);
		if (!tree.getChildren().isEmpty())
			TreeUtils.expandAll(tree);
	} // expandAll

	/**
	 * Collapse All Node
	 */
	public void collapseAll()
	{
		if (chkExpand.isChecked())
			chkExpand.setChecked(false);
		if (!tree.getChildren().isEmpty())
			TreeUtils.collapseAll(tree);
	} // collapseAll

	/**
	 * On check to Expand/Collapse Tree
	 */
	private void expandOnCheck()
	{
		if (chkExpand.isChecked())
			expandAll();
		else
			collapseAll();
	} // expandOnCheck
}