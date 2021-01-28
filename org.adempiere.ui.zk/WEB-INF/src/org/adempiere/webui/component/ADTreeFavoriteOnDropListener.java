/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.component;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.dashboard.DPFavourites;
import org.adempiere.webui.desktop.FavouriteController;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MTable;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MouseEvent;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;

/**
 * Register listener for Drag&Drop item, Context Menu, Delete Item, Summary folder default
 * Collapsed/Expanded Operation
 * 
 * @author Logilite Technologies
 * @since  June 20, 2017
 */
public class ADTreeFavoriteOnDropListener implements EventListener<Event>
{
	public static final String		MENU_ITEM_DELETE			= "DELETE";
	public static final String		NODE_MOVEINTO				= "MoveInto";
	public static final String		NODE_INSERTAFTER			= "InsertAfter";
	public static final String		MENU_ITEM_DEFAULT_EXPANDED	= "DefaultExpanded";
	public static final String		MENU_ITEM_DEFAULT_COLLAPSED	= "DefaultCollapsed";

	private FavoriteSimpleTreeModel	treeModel;
	private Tree					tree;

	private int						mTreeFavID;

	//
	public ADTreeFavoriteOnDropListener(Tree tree, FavoriteSimpleTreeModel treeModel)
	{
		this.tree = tree;
		this.treeModel = treeModel;

		FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getDesktop().getSession());
		mTreeFavID = controller.getAD_Tree_Favorite_ID();
	} // ADTreeFavoriteOnDropListener

	/**
	 * Events For Right Click And Menu Item Dragged Source to Target Folder
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void onEvent(Event event) throws Exception
	{
		if (Events.ON_RIGHT_CLICK.equals(event.getName())
			|| (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Toolbarbutton
				&& (boolean) ((Toolbarbutton) event.getTarget()).getAttribute(FavoriteSimpleTreeModel.MOBILE_TOOLBAR_CTX_MENU)))
		{
			MouseEvent me = (MouseEvent) event;
			Treeitem target = (event.getTarget() instanceof Toolbarbutton)	? (Treeitem) ((Treerow) me.getTarget().getParent().getParent()).getParent()
																			: (Treeitem) ((Treerow) me.getTarget()).getParent();
			menuItemList(target);
		}
		else if (event instanceof DropEvent)
		{
			DropEvent de = (DropEvent) event;
			if (de.getDragged() != de.getTarget())
			{
				Treeitem src;
				Treeitem target;

				if (de.getDragged() instanceof Treerow && de.getTarget() instanceof Treerow)
				{
					src = (Treeitem) ((Treerow) de.getDragged()).getParent();
					target = (Treeitem) ((Treerow) de.getTarget()).getParent();
				}
				else
				{
					FDialog.error(0, "DragItemMenu");
					return;
				}

				Treerow tr = (Treerow) de.getDragged();
				String strDraggable = tr.getDraggable();

				if (!strDraggable.equals(DPFavourites.FAVOURITE_DROPPABLE))
				{
					DefaultTreeNode<?> stn_src = (DefaultTreeNode<?>) src.getValue();
					DefaultTreeNode<?> stn_target = (DefaultTreeNode<?>) target.getValue();
					MTreeNode nd_src = (MTreeNode) stn_src.getData();
					MTreeNode nd_target = (MTreeNode) stn_target.getData();

					/*
					 * True When Source is a Menu otherwise a folder.
					 */
					if (!nd_src.isSummary())
					{
						int menuID = nd_src.getMenu_ID();
						boolean menuAvailable;

						if (!nd_target.isSummary())
						{
							menuAvailable = MTreeFavoriteNode.isMenuExists(menuID, nd_target.getParent_ID(), mTreeFavID);
							if (nd_src.getParent_ID() == nd_target.getParent_ID())
							{
								moveNode((DefaultTreeNode<Object>) src.getValue(), (DefaultTreeNode<Object>) target.getValue());
							}
							else if (menuAvailable)
							{
								showWarningDialog();
							}
							else
							{
								moveNode((DefaultTreeNode<Object>) src.getValue(), (DefaultTreeNode<Object>) target.getValue());
							}
						}
						else
						{
							menuAvailable = MTreeFavoriteNode.isMenuExists(menuID, nd_target.getNode_ID(), mTreeFavID);
							if (menuAvailable)
							{
								showWarningDialog();
							}
							else
							{
								moveNode((DefaultTreeNode<Object>) src.getValue(), (DefaultTreeNode<Object>) target.getValue());
							}
						}
					}
					else
					{
						moveNode((DefaultTreeNode<Object>) src.getValue(), (DefaultTreeNode<Object>) target.getValue());
					}
				}
				else
				{
					int mID = Integer.valueOf((src.getValue().toString()));
					DefaultTreeNode<Object> stn_target = (DefaultTreeNode<Object>) target.getValue();
					MTreeNode nd = (MTreeNode) stn_target.getData();

					/*
					 * True when Target is Folder, Otherwise its Menu item.
					 */
					if (nd.isSummary())
					{
						if (MTreeFavoriteNode.isMenuExists(mID, nd.getNode_ID(), mTreeFavID))
						{
							showWarningDialog();
						}
						else
						{
							insertMenuInTree(mID, nd.getNode_ID(), stn_target);
						}
					}
					else
					{
						DefaultTreeNode<Object> dtn_target_parent = treeModel.getParent(stn_target);
						int pID = ((MTreeNode) dtn_target_parent.getData()).getNode_ID();

						if (MTreeFavoriteNode.isMenuExists(mID, pID, mTreeFavID))
						{
							showWarningDialog();
						}
						else
						{
							insertMenuInTree(mID, pID, dtn_target_parent);
						}
					}
				}
			}
		}
	} // onEvent

	/**
	 * Show Dialog for Warning
	 */
	private void showWarningDialog()
	{
		FDialog.warn(0, Msg.getMsg(Env.getCtx(), "AlreadyExists"));
	} // showWarningDialog

	/**
	 * When Right click on Item show Delete Menu popup for Delete a node.
	 * 
	 * @param toItem
	 */
	private void menuItemList(Treeitem toItem)
	{
		@SuppressWarnings("unchecked")
		DefaultTreeNode<Object> toNode = (DefaultTreeNode<Object>) toItem.getValue();

		Menupopup popup = new Menupopup();
		Menuitem menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), "delete"));
		menuItem.setParent(popup);
		menuItem.setValue(MENU_ITEM_DELETE);
		menuItem.addEventListener(Events.ON_CLICK, new DeleteListener(toNode));
		if (ThemeManager.isUseFontIconForImage())
			menuItem.setIconSclass("z-icon-Delete");
		else
			menuItem.setImage(ThemeManager.getThemeResource("images/Delete24.png"));

		MTreeNode mtn = (MTreeNode) toNode.getData();
		if (mtn.isSummary())
		{
			MTreeFavoriteNode favNode = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(mtn.getNode_ID(), null);
			if (favNode.isCollapsible())
			{
				menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), MENU_ITEM_DEFAULT_EXPANDED));
				menuItem.setValue(MENU_ITEM_DEFAULT_EXPANDED);
				if (ThemeManager.isUseFontIconForImage())
					menuItem.setIconSclass("z-icon-Expand");
				else
					menuItem.setImage(ThemeManager.getThemeResource("images/expand-header.png"));
			}
			else
			{
				menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), MENU_ITEM_DEFAULT_COLLAPSED));
				menuItem.setValue(MENU_ITEM_DEFAULT_COLLAPSED);
				if (ThemeManager.isUseFontIconForImage())
					menuItem.setIconSclass("z-icon-Parent");
				else
					menuItem.setImage(ThemeManager.getThemeResource("images/collapse-header.png"));
			}
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, new CollExpdListener(favNode));
		}

		popup.setPage(tree.getPage());

		if (ClientInfo.isMobile())
			popup.open(toItem, "after_start");
		else
			popup.open(toItem, "after_pointer");
	} // menuItemList

	/**
	 * Insert Node into Tree it's contains only Menu type node, Dragged from Menu Tab.
	 * 
	 * @param menuID
	 * @param parentNodeID
	 * @param stn
	 */
	public void insertMenuInTree(int menuID, int parentNodeID, DefaultTreeNode<Object> stn)
	{
		MTreeFavoriteNode favNode = MTreeFavoriteNode.create(	Env.getAD_Client_ID(Env.getCtx()), Env.getContextAsInt(Env.getCtx(), Env.AD_ORG_ID), mTreeFavID,
																menuID, parentNodeID, 0, null, false, true, false);

		DPFavourites.addNodeInTree(treeModel, tree, stn, favNode);
	} // insertMenuInTree

	/**
	 * Internally movement of Tree node
	 * 
	 * @param movingNode
	 * @param toNode
	 */
	private void moveNode(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode)
	{
		if (movingNode == toNode)
			return;

		MTreeNode toMNode = (MTreeNode) toNode.getData();
		if (!toMNode.isSummary())
		{
			// drop on a child node
			moveNode(movingNode, toNode, false);
		}
		else
		{
			// drop on a summary node
			// prompt user to select insert after or drop into the summary node
			int path[] = treeModel.getPath(toNode);
			Treeitem toItem = tree.renderItemByPath(path);

			tree.setSelectedItem(toItem);
			Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));

			MenuListener listener = new MenuListener(movingNode, toNode);

			Menupopup popup = new Menupopup();
			Menuitem menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), NODE_INSERTAFTER));
			menuItem.setValue(NODE_INSERTAFTER);
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, listener);

			menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), NODE_MOVEINTO));
			menuItem.setValue(NODE_MOVEINTO);
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, listener);
			popup.setPage(tree.getPage());
			popup.open(toItem.getTreerow(), "overlap");
		}
	} // moveNode

	/**
	 * It's specify the Moving node where to inserted... Like Insert After or Move Into.
	 * 
	 * @param movingNode
	 * @param toNode
	 * @param isMoveInto
	 */
	private void moveNode(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode, boolean isMoveInto)
	{
		int index;
		DefaultTreeNode<Object> newParent;

		// Remove moving node from its old parent
		DefaultTreeNode<Object> oldParent = treeModel.getParent(movingNode);
		treeModel.removeNode(movingNode);

		// get new index
		if (!isMoveInto)
		{
			newParent = treeModel.getParent(toNode);
			// the next node
			index = newParent.getChildren().indexOf(toNode) + 1;
		}
		else
		{
			// drop on a summary node
			newParent = toNode;
			index = 0; // the first node
		}

		// insert in to tree
		treeModel.addNode(newParent, movingNode, index);

		int path[] = treeModel.getPath(movingNode);
		if (TreeUtils.isOnInitRenderPosted(tree) || tree.getTreechildren() == null)
		{
			tree.onInitRender();
		}
		Treeitem movingItem = tree.renderItemByPath(path);

		if (((MTreeNode) movingNode.getData()).isSummary())
			tree.setSelectedItem(movingItem);
		else
			tree.setSelectedItem(movingItem.getParentItem());
		Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));

		// Save move node info
		MTreeNode newParentTNode = (MTreeNode) newParent.getData();
		MTreeNode moveTNode = (MTreeNode) movingNode.getData();
		updateTFNParentAndSeqNo(newParentTNode, moveTNode, index);
		moveTNode.setParent_ID(newParentTNode.getNode_ID());

		// Old parent child node sequence altering
		MTreeNode oldMParent = (MTreeNode) oldParent.getData();
		for (int i = 0; i < oldParent.getChildCount(); i++)
		{
			DefaultTreeNode<Object> oldChildNode = (DefaultTreeNode<Object>) oldParent.getChildAt(i);
			MTreeNode oldTNode = (MTreeNode) oldChildNode.getData();

			updateTFNParentAndSeqNo(oldMParent, oldTNode, i);
		}

		// New parent child node sequence altering
		if (oldParent != newParent)
		{
			MTreeNode newMParent = (MTreeNode) newParent.getData();
			for (int i = 0; i < newParent.getChildCount(); i++)
			{
				DefaultTreeNode<Object> newChildNode = (DefaultTreeNode<Object>) newParent.getChildAt(i);
				MTreeNode newTNode = (MTreeNode) newChildNode.getData();

				updateTFNParentAndSeqNo(newMParent, newTNode, i);
			}
		}
	} // moveNode

	/**
	 * Update reference of Parent and Seqno
	 * 
	 * @param parentTNode
	 * @param moveTNode
	 * @param seqNo
	 */
	private void updateTFNParentAndSeqNo(MTreeNode parentTNode, MTreeNode moveTNode, int seqNo)
	{
		MTreeFavoriteNode favNode = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(moveTNode.getNode_ID(), null);
		if (favNode.getParent_ID() != parentTNode.getNode_ID() || favNode.getSeqNo() != seqNo)
		{
			favNode.setParent_ID(parentTNode.getNode_ID());
			favNode.setSeqNo(seqNo);
			try {
				//For service users, needs to persist data in system tenant
				PO.setCrossTenantSafe();
				favNode.save();
			}finally {
				PO.clearCrossTenantSafe();
			}
		}
	} // updateTFNParentAndSeqNo

	/**
	 * Listener for Delete Node on Right click on MouseEvent
	 */
	class DeleteListener implements EventListener<Event>
	{
		private DefaultTreeNode<Object> toNode;

		DeleteListener(DefaultTreeNode<Object> toNode)
		{
			this.toNode = toNode;
		}

		public void onEvent(Event event) throws Exception
		{
			if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Menuitem)
			{
				Menuitem menuItem = (Menuitem) event.getTarget();
				if (MENU_ITEM_DELETE.equals(menuItem.getValue()))
				{
					deleteNodeItem(toNode);
				}
			}
		} // onEvent

		/**
		 * Deleting a Node and its hierarchy
		 * 
		 * @param toNode
		 */
		private void deleteNodeItem(DefaultTreeNode<Object> toNode)
		{
			int nodeID = ((MTreeNode) toNode.getData()).getNode_ID();
			MTreeFavoriteNode favNode = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(nodeID, null);
			if (favNode.getAD_Menu_ID() > 0 && favNode.isFavourite())
			{
				FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getDesktop().getSession());
				if (!controller.removeNode(favNode.getAD_Menu_ID()))
				{
					throw new AdempiereException(Msg.getMsg(favNode.getCtx(), CLogger.retrieveError().getValue()));
				}
			}
			else
			{
				if (favNode.delete(true))
					treeModel.removeNode(toNode);
				else
					throw new AdempiereException(Msg.getMsg(favNode.getCtx(), CLogger.retrieveError().getValue()));
			}
		} // deleteNodeItem

	} // DeleteListener

	/**
	 * Listener for set default start Collapse/Expand Node by Right click on MouseEvent.
	 */
	class CollExpdListener implements EventListener<Event>
	{
		private MTreeFavoriteNode favNode;

		CollExpdListener(MTreeFavoriteNode favNode)
		{
			this.favNode = favNode;
		}

		public void onEvent(Event event) throws Exception
		{
			if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Menuitem)
			{
				Menuitem menuItem = (Menuitem) event.getTarget();
				if (MENU_ITEM_DEFAULT_EXPANDED.equals(menuItem.getValue()))
				{
					favNode.setIsCollapsible(false);
				}
				else if (MENU_ITEM_DEFAULT_COLLAPSED.equals(menuItem.getValue()))
				{
					favNode.setIsCollapsible(true);
				}
				favNode.saveEx();
			}
		} // onEvent

	} // CollExpdListener

	/**
	 * Listener for Movement of Node
	 */
	class MenuListener implements EventListener<Event>
	{
		private DefaultTreeNode<Object>	movingNode;
		private DefaultTreeNode<Object>	toNode;

		MenuListener(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode)
		{
			this.movingNode = movingNode;
			this.toNode = toNode;
		}

		public void onEvent(Event event) throws Exception
		{
			if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Menuitem)
			{
				Menuitem menuItem = (Menuitem) event.getTarget();
				if (NODE_INSERTAFTER.equals(menuItem.getValue()))
				{
					moveNode(movingNode, toNode, false);
				}
				else if (NODE_MOVEINTO.equals(menuItem.getValue()))
				{
					moveNode(movingNode, toNode, true);
				}
			}
		} // onEvent

	} // MenuListener

}
