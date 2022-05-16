/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation
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
package org.adempiere.webui.dashboard;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.FavoriteSimpleTreeModel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MMenu;
import org.compiere.model.MTable;
import org.compiere.model.MTreeFavorite;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Box;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;
import org.zkoss.zul.Vbox;

/**
 * Dashboard item: User favourites - Tree based view organize
 * 
 * @author Elaine
 * @author Logilite Technologies - IDEMPIERE-3340
 * @date   November 20, 2008
 */
public class DPFavourites extends DashboardPanel implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long		serialVersionUID	= 7915726855926813700L;

	public static final String		FAVOURITE_DROPPABLE	= "favourite";

	private FavoriteSimpleTreeModel	treeModel;

	private ToolBarButton			btnAdd;
	private ToolBarButton			btnEdit;
	private ToolBarButton			btnExpand;
	private ToolBarButton			btnAutoLaunch;

	private Tree					tree;

	//
	public DPFavourites()
	{
		super();

		Panel panel = new Panel();
		panel.setClass("fav-tree-panel");
		this.appendChild(panel);

		Panelchildren favContent = new Panelchildren();
		favContent.appendChild(createFavoritePanel());
		favContent.setDroppable(FAVOURITE_DROPPABLE);
		favContent.addEventListener(Events.ON_DROP, this);
		panel.appendChild(favContent);

		//
		btnExpand = new ToolBarButton("Expand");
		btnExpand.setChecked(false);
		btnExpand.setClass("fav-button-Expand");
		btnExpand.addEventListener(Events.ON_CLICK, this);
		btnExpand.setTooltiptext(Msg.getMsg(Env.getCtx(), "Tooltip_ExpandCollapseTree"));
		if (ThemeManager.isUseFontIconForImage())
			btnExpand.setIconSclass("z-icon-Expanding");
		else
			btnExpand.setImage(ThemeManager.getThemeResource("images/expand-header.png"));

		//
		btnAdd = new ToolBarButton("AddFolder");
		btnAdd.setClass("fav-button-add");
		btnAdd.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddFolder"));
		btnAdd.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			btnAdd.setIconSclass("z-icon-TreeFavNodeAdd");
		else
			btnAdd.setImage(ThemeManager.getThemeResource("images/FolderAdd24.png"));

		//
		btnEdit = new ToolBarButton("Edit");
		btnEdit.setClass("fav-button-edit");
		btnEdit.setTooltiptext(Msg.getMsg(Env.getCtx(), "EditFolder"));
		btnEdit.addEventListener(Events.ON_CLICK, this);
		btnEdit.setDisabled(true);
		if (ThemeManager.isUseFontIconForImage())
			btnEdit.setIconSclass("z-icon-Edit");
		else
			btnEdit.setImage(ThemeManager.getThemeResource("images/Editor24.png"));

		//
		btnAutoLaunch = new ToolBarButton("AutoLaunch");
		btnAutoLaunch.setClass("fav-button-autolaunch");
		btnAutoLaunch.setTooltiptext(Msg.getMsg(Env.getCtx(), "AutoLaunch"));
		btnAutoLaunch.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			btnAutoLaunch.setIconSclass("z-icon-SequenceChange");
		else
			btnAutoLaunch.setImage(ThemeManager.getThemeResource("images/Customize24.png"));

		//
		Toolbar toolbar = new Toolbar();
		toolbar.setClass("fav-toolbar");
		toolbar.appendChild(btnExpand);
		toolbar.appendChild(btnAdd);
		toolbar.appendChild(btnEdit);
		toolbar.appendChild(btnAutoLaunch);
		this.appendChild(toolbar);
	} // DPFavourites

	private Box createFavoritePanel()
	{
		tree = new Tree();
		tree.setMultiple(false);
		tree.setSizedByContent(false);
		tree.setClass("menu-tree");
		tree.addEventListener(Events.ON_SELECT, this);
		ZKUpdateUtil.setWidth(tree, "100%");
		ZkCssHelper.appendStyle(tree, "border: none; min-height: 20px;");

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
		treeModel = FavoriteSimpleTreeModel.initADTree(tree, null);
	} // initTreeModel

	/**
	 * Event Like open Menu Window, Expand/Collapse Node, Add node into Tree
	 */
	public void onEvent(Event event)
	{
		String eventName = event.getName();
		if (eventName.equals(Events.ON_CLICK))
		{
			if (event.getTarget() == btnAdd)
				doFolderOpr(true);
			else if (event.getTarget() == btnEdit)
				doFolderOpr(false);
			else if (event.getTarget() == btnExpand)
				doExpandCollapseAll();
			else if (event.getTarget() == btnAutoLaunch)
				doLoginOpenSeq();
		}
		else if (eventName.equals(Events.ON_SELECT) && event.getTarget() == tree)
		{
			MTreeNode mtNode = getCurrentSelectedTreeNode(tree);
			btnEdit.setDisabled(mtNode.getNode_ID() == 0 || !mtNode.isSummary());
		}
		else if (eventName.equals(Events.ON_DROP) && event instanceof DropEvent && event.getTarget() instanceof Panelchildren)
		{
			DropEvent de = (DropEvent) event;
			if (de.getDragged() != de.getTarget())
			{
				if (de.getDragged() instanceof Treerow)
				{
					Treeitem src = (Treeitem) ((Treerow) de.getDragged()).getParent();
					int menuID = Integer.parseInt(src.getValue());
					int treeFavoriteID = MTreeFavorite.getFavoriteTreeID(Env.getAD_User_ID(Env.getCtx()));
					//
					insertMenuInTree(menuID, 0, treeFavoriteID, tree, treeModel, null);
				}
			}
		}
	} // onEvent

	private void doLoginOpenSeq()
	{
		LoginOpenSequenceDialog dialog = new LoginOpenSequenceDialog(Env.getAD_User_ID(Env.getCtx()));
		dialog.loadData();
		dialog.doHighlighted();
		AEnv.showCenterScreen(dialog);
	} // doLoginOpenSeq

	/**
	 * Add or Edit folder
	 */
	private void doFolderOpr(boolean isAddFolder)
	{
		FavouriteFolderDialog addFolderPanel = new FavouriteFolderDialog(isAddFolder, treeModel, tree);

		AEnv.showCenterScreen(addFolderPanel);
	} // doFolderOpr

	/**
	 * On check to Expand/Collapse Tree
	 */
	private void doExpandCollapseAll()
	{
		btnExpand.setChecked(!btnExpand.isChecked());
		if (!tree.getChildren().isEmpty())
		{
			if (btnExpand.isChecked())
			{
				btnExpand.addSclass("fav-expand-mode");
				TreeUtils.expandAll(tree);
			}
			else
			{
				btnExpand.removeSclass("fav-expand-mode");
				TreeUtils.collapseAll(tree);
			}
		}
	} // doExpandCollapseAll

	public static MTreeNode getCurrentSelectedTreeNode(Tree tree)
	{
		Treeitem selItem = tree.getSelectedItem();
		DefaultTreeNode<?> dtn;
		if (selItem == null)
			dtn = (DefaultTreeNode<?>) tree.getModel().getRoot();
		else
			dtn = selItem.getValue();

		return (MTreeNode) dtn.getData();
	} // getCurrentSelectedTreeNode

	public static int getCurrentSelectedNodeID(Tree tree)
	{
		return getCurrentSelectedTreeNode(tree).getNode_ID();
	} // getCurrentSelectedNodeID

	/**
	 * Insert Node into Tree it's contains only Menu type node, Dragged from Menu Tab.
	 * 
	 * @param menuID         - AD_Menu_ID
	 * @param parentNodeID   - Parent AD_Favorite_Node_ID
	 * @param treeFavoriteID - AD_Tree_Favorite_ID
	 * @param tree           - Tree
	 * @param treeModel      - FavoriteSimpleTreeModel
	 * @param parentDTN      - parent DefaultTreeNode
	 */
	public static void insertMenuInTree(int menuID, int parentNodeID, int treeFavoriteID, Tree tree, FavoriteSimpleTreeModel treeModel,
										DefaultTreeNode<Object> parentDTN)
	{
		MTreeFavoriteNode favNode = MTreeFavoriteNode.create(	Env.getAD_Client_ID(Env.getCtx()), Env.getContextAsInt(Env.getCtx(), Env.AD_ORG_ID), treeFavoriteID,
																menuID, parentNodeID, 0, null, false, true, false);
		addNodeInTree(treeModel, tree, parentDTN, favNode);
	} // insertMenuInTree

	/**
	 * Add Node in Tree view
	 * 
	 * @param treeModel - FavoriteSimpleTreeModel
	 * @param tree      - Tree
	 * @param parentDTN - Parent DefaultTreeNode
	 * @param favNode   - MTreeFavoriteNode
	 */
	public static void addNodeInTree(FavoriteSimpleTreeModel treeModel, Tree tree, DefaultTreeNode<Object> parentDTN, MTreeFavoriteNode favNode)
	{
		String name = null;
		String action = null;

		if (favNode.getAD_Menu_ID() > 0)
		{
			MMenu menu = (MMenu) MTable.get(Env.getCtx(), MMenu.Table_ID).getPO(favNode.getAD_Menu_ID(), null);
			name = menu.getDisplayedName();
			action = menu.getAction();
		}
		else
		{
			name = favNode.getName();
		}

		MTreeNode mtnNew = new MTreeNode(	favNode.getAD_Tree_Favorite_Node_ID(), favNode.getSeqNo(), name, name, favNode.getParent_ID(), favNode.getAD_Menu_ID(),
											action, favNode.isSummary(), favNode.isCollapsible(), favNode.isFavourite());

		DefaultTreeNode<Object> newNode = new DefaultTreeNode<Object>(mtnNew);

		if (parentDTN == null)
			parentDTN = treeModel.getRoot();

		treeModel.addNode(parentDTN, newNode, 0);
		int[] path = treeModel.getPath(newNode);
		Treeitem ti = tree.renderItemByPath(path);
		tree.renderItem(ti);

		if (mtnNew.isSummary())
		{
			tree.setSelectedItem(ti);
		}
		else
		{
			tree.setSelectedItem(ti.getParentItem());
			path = treeModel.getPath(treeModel.getParent(newNode));
		}

		treeModel.addSelectionPath(path);
		Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));
	} // addNodeInTree
}
