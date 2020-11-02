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

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.FavoriteSimpleTreeModel;
import org.adempiere.webui.desktop.FavouriteController;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MMenu;
import org.compiere.model.MTable;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Box;
import org.zkoss.zul.Button;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Div;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
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
	private Checkbox				chkExpand;
	private Checkbox				addAsRoot;
	private Textbox					textbox;
	private Tree					tree;

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

		chkExpand = new Checkbox();
		chkExpand.setClass("fav-chkbox");
		chkExpand.setText(Msg.getMsg(Env.getCtx(), "ExpandTree"));
		chkExpand.addEventListener(Events.ON_CHECK, this);
		chkExpand.setTooltiptext("Expand/Collapse Tree");

		addAsRoot = new Checkbox();
		addAsRoot.setClass("fav-chkbox");
		addAsRoot.setText(Msg.getMsg(Env.getCtx(), "AddAsRoot"));
		addAsRoot.setTooltiptext("If checked then new node added as on root node.");

		textbox = new Textbox();
		textbox.setClass("fav-folder-textbox");
		textbox.setPlaceholder(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		textbox.setTooltiptext("Specify new node name");
		textbox.addEventListener(Events.ON_OK, this);

		Button btnAdd = new Button();
		btnAdd.setClass("fav-button-add");
		btnAdd.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		btnAdd.setStyle("padding: 3px 10px; margin-left: 1px !important;");
		btnAdd.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			btnAdd.setIconSclass("z-icon-TreeFavNodeAdd");
		else
			btnAdd.setImage(ThemeManager.getThemeResource("images/FolderAdd16.png"));

		Div favToolbarRow1 = new Div();
		favToolbarRow1.setClass("fav-toolbar-div favToolbarRow1");
		favToolbarRow1.appendChild(addAsRoot);
		favToolbarRow1.appendChild(chkExpand);

		Div favToolbarRow2 = new Div();
		favToolbarRow2.setClass("fav-toolbar-div favToolbarRow2");
		favToolbarRow2.appendChild(textbox);
		favToolbarRow2.appendChild(btnAdd);

		Div favToolbar = new Div();
		favToolbar.setClass("fav-toolbar");
		favToolbar.appendChild(favToolbarRow1);
		favToolbar.appendChild(favToolbarRow2);
		this.appendChild(favToolbar);
	}

	private Box createFavoritePanel()
	{
		tree = new Tree();
		tree.setMultiple(false);
		tree.setSizedByContent(false);
		tree.setClass("menu-tree");
		tree.setStyle("border: none");
		ZKUpdateUtil.setWidth(tree, "100%");

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
			insertSummaryNode(nodeName);
	} // addNodeBtnPressed

	/**
	 * Insert Folder as Node to Tree.
	 */
	private void insertSummaryNode(String nodeName)
	{
		MTreeFavoriteNode favNode = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(0, null);
		favNode.set_ValueOfColumn(MTreeFavoriteNode.COLUMNNAME_AD_Client_ID, Env.getAD_Client_ID(Env.getCtx()));
		favNode.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
		favNode.setAD_Tree_Favorite_ID(FavouriteController.getInstance(Executions.getCurrent().getDesktop().getSession()).getAD_Tree_Favorite_ID());
		favNode.setIsSummary(true);
		favNode.setName(nodeName);
		if (addAsRoot.isChecked())
			favNode.setParent_ID(0);
		else
			favNode.setParent_ID(treeModel.getSelectedNodeID());
		favNode.setSeqNo(0);
		if (!favNode.save())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NodeNotCreate"));
		else
		{
			DPFavourites.addNodeInTree(treeModel, tree, treeModel.find(null, favNode.getParent_ID()), favNode);
			textbox.setText("");
		}
	} // insertSummaryNode

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

	/**
	 * Add Node in Tree view
	 * 
	 * @param treeModel      - FavoriteSimpleTreeModel
	 * @param tree           - Tree
	 * @param parentTreeNode - Parent DefaultTreeNode
	 * @param favNode        - MTreeFavoriteNode
	 */
	public static void addNodeInTree(FavoriteSimpleTreeModel treeModel, Tree tree, DefaultTreeNode<Object> parentTreeNode, MTreeFavoriteNode favNode)
	{
		String name = null;
		String action = null;

		if (favNode.getAD_Menu_ID() > 0)
		{
			MMenu menu = (MMenu) MTable.get(Env.getCtx(), MMenu.Table_ID).getPO(favNode.getAD_Menu_ID(), null);
			name = menu.get_Translation(MMenu.COLUMNNAME_Name);
			action = menu.getAction();
		}
		else
		{
			name = favNode.getName();
		}

		MTreeNode mtnNew = new MTreeNode(	favNode.getAD_Tree_Favorite_Node_ID(), favNode.getSeqNo(), name, name, favNode.getParent_ID(), favNode.getAD_Menu_ID(),
											action, favNode.isSummary(), favNode.isCollapsible(), favNode.isFavourite());

		DefaultTreeNode<Object> newNode = new DefaultTreeNode<Object>(mtnNew);

		//
		treeModel.addNode(parentTreeNode, newNode, 0);
		int[] path = treeModel.getPath(newNode);
		Treeitem ti = tree.renderItemByPath(path);
		tree.setSelectedItem(ti);
		Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));

		if (mtnNew.isSummary())
			treeModel.setSelectedNodeID(mtnNew.getNode_ID());
		else
			treeModel.setSelectedNodeID(favNode.getParent_ID());
	} // addNodeInTree
}
