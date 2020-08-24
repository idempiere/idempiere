/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.component;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Objects;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.adwindow.ADTabpanel;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.WTextEditorDialog;
import org.compiere.model.MMenu;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.model.MToolBarButtonRestrict;
import org.compiere.model.MTreeFavorite;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Tree;
import org.zkoss.zul.TreeNode;
import org.zkoss.zul.Treecell;
import org.zkoss.zul.Treecol;
import org.zkoss.zul.Treecols;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.TreeitemRenderer;
import org.zkoss.zul.Treerow;
import org.zkoss.zul.event.TreeDataEvent;

/**
 * User Favorite Tree Model
 * 
 * @author Logilite Technologies
 * @since June 20, 2017
 */
public class FavoriteSimpleTreeModel extends SimpleTreeModel implements EventListener<Event>, TreeitemRenderer<Object>
{

	/**
	 * 
	 */
	private static final long			serialVersionUID	= 6950349031548896628L;

	private static final CLogger		log					= CLogger.getCLogger(FavoriteSimpleTreeModel.class);

	private List<EventListener<Event>>	onDropListners		= new ArrayList<EventListener<Event>>();

	private boolean						itemDraggable;
	private int							currFolderID		= 0;

	public FavoriteSimpleTreeModel(DefaultTreeNode<Object> root)
	{
		super(root);
	}

	/**
	 * Tree Initialization
	 * 
	 * @param Tree
	 * @param AD_Tree_Favorite_ID
	 * @param windowNo
	 * @param editable
	 * @param trxName
	 * @return
	 */
	public static FavoriteSimpleTreeModel initADTree(Tree tree, int AD_Tree_Favorite_ID, int windowNo, boolean editable, String trxName)
	{
		MTreeFavorite mTreeFavorite = (MTreeFavorite) MTable.get(Env.getCtx(), MTreeFavorite.Table_ID).getPO(AD_Tree_Favorite_ID, trxName);
		MTreeNode root = mTreeFavorite.getRoot();
		FavoriteSimpleTreeModel treeModel = FavoriteSimpleTreeModel.createFrom(root);
		treeModel.currFolderID = root.getNode_ID();
		treeModel.setItemDraggable(true);
		treeModel.addOnDropEventListener(new ADTreeFavoriteOnDropListener(tree, treeModel, windowNo));

		if (tree.getTreecols() == null)
		{
			Treecols treeCols = new Treecols();
			tree.appendChild(treeCols);
			Treecol treeCol = new Treecol();
			treeCols.appendChild(treeCol);
		}

		tree.setPageSize(-1);

		try
		{
			tree.setItemRenderer(treeModel);
			tree.setModel(treeModel);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Failed to setup tree");
		}

		return treeModel;
	} // initADTree

	/**
	 * Creating Tree hierarchy
	 * 
	 * @param RootNode
	 * @return model
	 */
	public static FavoriteSimpleTreeModel createFrom(MTreeNode root)
	{
		FavoriteSimpleTreeModel model = null;
		Enumeration<?> nodeEnum = root.children();

		DefaultTreeNode<Object> stRoot = new DefaultTreeNode<Object>(root, nodeEnum.hasMoreElements() ? new ArrayList<TreeNode<Object>>() : null);

		while (nodeEnum.hasMoreElements())
		{
			MTreeNode childNode = (MTreeNode) nodeEnum.nextElement();

			DefaultTreeNode<Object> stNode = childNode.getChildCount() > 0
					? new DefaultTreeNode<Object>(childNode, new ArrayList<TreeNode<Object>>())
					: new DefaultTreeNode<Object>(childNode);

			stRoot.getChildren().add(stNode);
			if (childNode.getChildCount() > 0)
			{
				populate(stNode, childNode);
			}
		}

		model = new FavoriteSimpleTreeModel(stRoot);
		return model;
	}// createFrom

	/**
	 * Populate Node
	 * 
	 * @param stNode
	 * @param root
	 */
	private static void populate(DefaultTreeNode<Object> stNode, MTreeNode root)
	{
		Enumeration<?> nodeEnum = root.children();
		while (nodeEnum.hasMoreElements())
		{
			MTreeNode childNode = (MTreeNode) nodeEnum.nextElement();

			DefaultTreeNode<Object> stChildNode = childNode.getChildCount() > 0
					? new DefaultTreeNode<Object>(childNode, new ArrayList<TreeNode<Object>>())
					: new DefaultTreeNode<Object>(childNode);

			stNode.getChildren().add(stChildNode);
			if (childNode.getChildCount() > 0)
			{
				populate(stChildNode, childNode);
			}
		}
	} // populate

	@Override
	public void render(Treeitem ti, Object node, int index)
	{
		DefaultTreeNode<?> stn = (DefaultTreeNode<?>) node;
		MTreeNode mtn = (MTreeNode) stn.getData();
		Treecell tc = new Treecell(Objects.toString(node));
		setIconOrImage(mtn, tc);

		Treerow tr = null;
		if (ti.getTreerow() == null)
		{
			tr = new Treerow();
			tr.setParent(ti);
			if (isItemDraggable())
			{
				tr.setDraggable("true");
			}
			if (!onDropListners.isEmpty())
			{
				ti.getTreerow().addEventListener(Events.ON_CLICK, this);
				ti.getTreerow().addEventListener(Events.ON_DOUBLE_CLICK, this);

				tr.setDroppable("true");
				tr.addEventListener(Events.ON_SELECT, this);
				tr.addEventListener(Events.ON_RIGHT_CLICK, this);
				tr.addEventListener(Events.ON_DROP, this);
			}

			Object data = ((DefaultTreeNode<?>) node).getData();
			if (data instanceof MTreeNode)
			{
				MTreeNode mNode = (MTreeNode) data;
				if (mNode.getColor() != null)
				{
					String hex = ZkCssHelper.createHexColorString(mNode.getColor());
					ZkCssHelper.appendStyle(tc, "color: #" + hex);
				}
				// default user action for Collapse/Expand
				ti.setOpen(!mNode.isCollapsible());
				ti.setTooltiptext(mNode.getDescription());
				if (mNode.isSummary())
					ZkCssHelper.appendStyle(tc, "font-weight: bold");

				if (mNode.isWindow())
				{
					// Check Window access for ReadWrite & New Toolbar button
					if (!MToolBarButtonRestrict.isNewButtonRestricted(MMenu.get(mNode.getMenu_ID()).getAD_Window_ID()))
					{
						if (ThemeManager.isUseFontIconForImage())
						{
							ToolBarButton newBtn = new ToolBarButton();
							newBtn.setIconSclass("z-icon-New");
							newBtn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "New")));
							newBtn.setSclass("trash-toolbarbutton");
							newBtn.addEventListener(Events.ON_CLICK, this);
							tc.appendChild(newBtn);
						}
						else
						{
							Toolbarbutton newBtn = new Toolbarbutton(null, ThemeManager.getThemeResource("images/New10.png"));
							newBtn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "New")));
							newBtn.setSclass("menu-href-newbtn");
							newBtn.addEventListener(Events.ON_CLICK, this);
							tc.appendChild(newBtn);
						}
					}
				}
			}
		}
		else
		{
			tr = ti.getTreerow();
			tr.getChildren().clear();
		}
		tc.setParent(tr);
		ti.setValue(node);
	} // render

	private void setIconOrImage(MTreeNode mtn, Treecell tc)
	{
		if (mtn.isSummary())
		{
			if (ThemeManager.isUseFontIconForImage())
				tc.setIconSclass("z-icon-Folder");
			else
				tc.setImage(ThemeManager.getThemeResource("images/Folder16.png"));
		}
		else if (mtn.isReport())
		{
			if (ThemeManager.isUseFontIconForImage())
				tc.setIconSclass("z-icon-Report");
			else
				tc.setImage(ThemeManager.getThemeResource("images/mReport.png"));
		}
		else if (mtn.isProcess() || mtn.isTask())
		{
			if (ThemeManager.isUseFontIconForImage())
				tc.setIconSclass("z-icon-Process");
			else
				tc.setImage(ThemeManager.getThemeResource("images/mProcess.png"));
		}
		else if (mtn.isWorkFlow())
		{
			if (ThemeManager.isUseFontIconForImage())
				tc.setIconSclass("z-icon-Workflow");
			else
				tc.setImage(ThemeManager.getThemeResource("images/mWorkFlow.png"));
		}
		else if (mtn.isForm())
		{
			if (ThemeManager.isUseFontIconForImage())
				tc.setIconSclass("z-icon-Form");
			else
				tc.setImage(ThemeManager.getThemeResource("images/mForm.png"));
		}
		else if (mtn.isInfo())
		{
			if (ThemeManager.isUseFontIconForImage())
				tc.setIconSclass("z-icon-Info");
			else
				tc.setImage(ThemeManager.getThemeResource("images/mInfo.png"));
		}
		else // Window
		{
			if (ThemeManager.isUseFontIconForImage())
				tc.setIconSclass("z-icon-Window");
			else
				tc.setImage(ThemeManager.getThemeResource("images/mWindow.png"));
		}
	} // setIconOrImage

	/**
	 * Get value of Current Selected Folder in Tree.
	 * 
	 * @return
	 */
	public int getSelectedFolderID()
	{
		return currFolderID;
	}

	/**
	 * Set the current selected Menu folder in Tree.
	 * 
	 * @param mtnID
	 */
	public void setSelectedFolderID(int mtnID)
	{
		currFolderID = mtnID;
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		Component comp = event.getTarget();
		String eventName = event.getName();

		if (Events.ON_DROP.equals(eventName) || Events.ON_RIGHT_CLICK.equals(eventName))
		{
			for (EventListener<Event> listener : onDropListners)
			{
				listener.onEvent(event);
			}
		}

		/**
		 * On click of menu to open that window
		 */
		if (Events.ON_CLICK.equals(eventName) || Events.ON_SELECT.equals(eventName))
		{
			boolean newRecord = false;
			if (comp instanceof Toolbarbutton)
			{
				comp = comp.getParent().getParent();
				newRecord = true;
			}
			
			if (comp instanceof Treerow)
			{
				Treerow treerow = (Treerow) comp;
				Treeitem treeitem = (Treeitem) treerow.getParent();
				Object value = treeitem.getValue();

				DefaultTreeNode<?> dtNode = (DefaultTreeNode<?>) value;
				MTreeNode mtn = (MTreeNode) dtNode.getData();

				if (newRecord)
				{
					onNewRecord(mtn.getMenu_ID());
				}
				else if (!mtn.isSummary())
				{
					int menuId = mtn.getMenu_ID();
					SessionManager.getAppDesktop().onMenuSelected(menuId);
					setSelectedFolderID(mtn.getParent_ID());
				}
				else
				{
					setSelectedFolderID(mtn.getNode_ID());
				}
			}
		}
		else if (Events.ON_DOUBLE_CLICK.equals(eventName))
		{
			// Rename the folder.
			if (comp instanceof Treerow)
			{
				Treerow treerow = (Treerow) comp;
				Treeitem treeitem = (Treeitem) treerow.getParent();
				Object value = treeitem.getValue();

				final DefaultTreeNode<?> dtNode = (DefaultTreeNode<?>) value;
				final MTreeNode mtn = (MTreeNode) dtNode.getData();

				if (mtn.isSummary())
				{
					final FavoriteSimpleTreeModel sftModel = this;
					final WTextEditorDialog editorDialog = new WTextEditorDialog(Msg.getMsg(Env.getCtx(), "EditFolderName"), mtn.getName() == null ? "" : mtn.getName(), true, 100, false, false);

					editorDialog.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
					editorDialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
						@Override
						public void onEvent(Event event) throws Exception
						{
							if (!editorDialog.isCancelled())
							{
								mtn.setName(editorDialog.getText());

								MTreeFavoriteNode mtfNode = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(mtn.getNode_ID(), null);
								mtfNode.setName(editorDialog.getText());
								mtfNode.saveEx();

								@SuppressWarnings("unchecked")
								int path[] = sftModel.getPath((TreeNode<Object>) dtNode);
								if (path != null && path.length > 0)
								{
									DefaultTreeNode<Object> parentNode = getRoot();
									int index = path.length - 1;
									for (int i = 0; i < index; i++)
									{
										parentNode = (DefaultTreeNode<Object>) getChild(parentNode, path[i]);
									}

									fireEvent(TreeDataEvent.CONTENTS_CHANGED, getPath(parentNode), path[index], path[index]);
								}
							}
						} // onEvent
					});

					SessionManager.getAppDesktop().showWindow(editorDialog);
				}
			}
		}
	}

	public void addNode(DefaultTreeNode<Object> newNode)
	{
		DefaultTreeNode<Object> root = (DefaultTreeNode<Object>) getRoot();
		root.getChildren().add(newNode);

		fireEvent(TreeDataEvent.INTERVAL_ADDED, getPath(root), root.getChildCount() - 1, root.getChildCount() - 1);
	} // addNode

	public void addOnDropEventListener(EventListener<Event> listener)
	{
		onDropListners.add(listener);
	}

	public void setItemDraggable(boolean isDraggable)
	{
		itemDraggable = isDraggable;
	}

	public boolean isItemDraggable()
	{
		return itemDraggable;
	}

	public DefaultTreeNode<Object> getChild(DefaultTreeNode<Object> parent, int index)
	{
		return (DefaultTreeNode<Object>) (parent).getChildAt(index);
	} // getChild
	
	private void onNewRecord(int menuID)
	{
		try
		{
			MMenu menu = new MMenu(Env.getCtx(), menuID, null);

			MQuery query = new MQuery("");
			query.addRestriction("1=2");
			query.setRecordCount(0);

			SessionManager.getAppDesktop().openWindow(menu.getAD_Window_ID(), query, new Callback<ADWindow>() {
				@Override
				public void onCallback(ADWindow result)
				{
					if (result == null)
						return;

					result.getADWindowContent().onNew();
					ADTabpanel adtabpanel = (ADTabpanel) result.getADWindowContent().getADTab().getSelectedTabpanel();
					adtabpanel.focusToFirstEditor(false);
				}
			});
		}
		catch (Exception e)
		{
			throw new ApplicationException(e.getMessage(), e);
		}
	} // onNewRecord

}