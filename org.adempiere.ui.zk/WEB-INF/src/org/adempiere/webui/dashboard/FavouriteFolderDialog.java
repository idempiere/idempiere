/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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

import java.util.Set;

import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.FavoriteSimpleTreeModel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
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
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Label;
import org.zkoss.zul.Rows;
import org.zkoss.zul.South;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Tree;
import org.zkoss.zul.TreeNode;
import org.zkoss.zul.event.TreeDataEvent;

/**
 * Favourite folder add or edit dialog
 * 
 * @author Logilite Technologies
 */
public class FavouriteFolderDialog extends Window implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long		serialVersionUID	= -2838644830113603288L;

	private Textbox					txtFolder;
	private Checkbox				chkAddAsRoot;
	private Checkbox				chkDefaultExpanded;
	private Label					lblSelectedNodeInfo	= new Label();

	private Borderlayout			mainLayout			= new Borderlayout();
	private Panel					centerPanel			= new Panel();
	private Grid					grid				= new Grid();
	private ConfirmPanel			confirmPanel		= new ConfirmPanel(true);

	private MTreeFavoriteNode		favNodeSummary;
	private FavoriteSimpleTreeModel	treeModel;
	private Tree					tree;

	private boolean					isAdd;

	public FavouriteFolderDialog(boolean isAdd, FavoriteSimpleTreeModel treeModel, Tree tree)
	{
		super();

		this.isAdd = isAdd;
		this.treeModel = treeModel;
		this.tree = tree;

		//
		init();
		initAttributes();
	}

	private void init()
	{
		if (isAdd)
			this.setTitle(Msg.translate(Env.getCtx(), "AddFolder"));
		else
			this.setTitle(Msg.translate(Env.getCtx(), "EditFolder"));

		this.setBorder("normal");
		this.setShadow(true);
		this.setSizable(true);
		this.setMaximizable(true);
		this.setMode(Window.MODE_HIGHLIGHTED);
		this.setSclass("popup-dialog fav-add-edit-dialog");
		ZKUpdateUtil.setWindowWidthX(this, 325);
		ZKUpdateUtil.setWindowHeightX(this, 225);

		mainLayout.setParent(this);

		grid.setOddRowSclass("even");
		centerPanel.appendChild(grid);

		Center center = new Center();
		center.setSclass("dialog-content");
		center.appendChild(centerPanel);
		center.setParent(mainLayout);

		South south = new South();
		south.setSclass("dialog-footer");
		south.appendChild(confirmPanel);
		south.setParent(mainLayout);

		confirmPanel.addActionListener(Events.ON_CLICK, this);

		//
		Rows rows = new Rows();
		rows.setParent(grid);

		Row row = new Row();
		row.setParent(rows);
		row.appendChild(lblSelectedNodeInfo);

		if (isAdd)
		{
			chkAddAsRoot = new Checkbox();
			chkAddAsRoot.setClass("fav-chkbox");
			chkAddAsRoot.setText(Msg.getMsg(Env.getCtx(), "AddAsRoot"));
			chkAddAsRoot.setTooltiptext(Msg.getMsg(Env.getCtx(),"Tooltip_AddAsRoot"));
			row = new Row();
			row.setParent(rows);
			row.appendChild(chkAddAsRoot);
		}

		chkDefaultExpanded = new Checkbox();
		chkDefaultExpanded.setClass("fav-chkbox");
		chkDefaultExpanded.setText(Msg.getMsg(Env.getCtx(), "DefaultExpanded"));
		chkDefaultExpanded.setTooltiptext(Msg.getMsg(Env.getCtx(), "Tooltip_DefaultExpanded"));
		row = new Row();
		row.setParent(rows);
		row.appendChild(chkDefaultExpanded);

		txtFolder = new Textbox();
		txtFolder.setClass("fav-folder-textbox");
		txtFolder.setPlaceholder(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		txtFolder.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		txtFolder.addEventListener(Events.ON_OK, this);
		row = new Row();
		row.setParent(rows);
		row.appendChild(txtFolder);
	} // init

	private void initAttributes()
	{
		String MSG_CURRENT_FOLDER_SELECTED = Msg.getMsg(Env.getCtx(), "CurrentFolderSelected");

		int selectedNodeID = DPFavourites.getCurrentSelectedNodeID(tree);
		if (selectedNodeID > 0)
		{
			favNodeSummary = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(selectedNodeID, null);
			if (!favNodeSummary.isSummary())
			{
				if (favNodeSummary.getParent_ID() > 0)
				{
					favNodeSummary = (MTreeFavoriteNode) favNodeSummary.getParent();
				}
				else
				{
					lblSelectedNodeInfo.setValue(MSG_CURRENT_FOLDER_SELECTED + " : [ Root ]");
					return;
				}
			}

			chkDefaultExpanded.setSelected(!favNodeSummary.isCollapsible());
			lblSelectedNodeInfo.setValue(MSG_CURRENT_FOLDER_SELECTED + " : " + favNodeSummary.getName());

			if (!isAdd)
				txtFolder.setText(favNodeSummary.getName());
		}
		else
		{
			lblSelectedNodeInfo.setValue(MSG_CURRENT_FOLDER_SELECTED + " : [ Root ]");
		}
	} // initAttributes

	@Override
	public void onEvent(Event event) throws Exception
	{
		if (event.getTarget().getId().equals(ConfirmPanel.A_OK) || (event.getTarget() == txtFolder && Events.ON_OK.equals(event.getName())))
		{
			if (Util.isEmpty(txtFolder.getText(), true))
			{
				txtFolder.setFocus(true);
			}
			else
			{
				if (isAdd)
				{
					insertFolder(txtFolder.getText());
				}
				else
				{
					favNodeSummary.setIsCollapsible(!chkDefaultExpanded.isChecked());
					favNodeSummary.setName(txtFolder.getText());
					favNodeSummary.saveEx();

					//
					Set<TreeNode<Object>> nodeSelection = treeModel.getSelection();
					for (TreeNode<Object> tNode : nodeSelection)
					{
						MTreeNode mtNode = (MTreeNode) tNode.getData();
						mtNode.setName(favNodeSummary.getName());
						mtNode.setCollapsible(favNodeSummary.isCollapsible());
					}

					int path[] = treeModel.getSelectionPath();
					if (path != null && path.length > 0)
					{
						DefaultTreeNode<Object> parentNode = treeModel.getRoot();
						int index = path.length - 1;
						for (int i = 0; i < index; i++)
						{
							parentNode = (DefaultTreeNode<Object>) treeModel.getChild(parentNode, path[i]);
						}
						treeModel.fireEvent(TreeDataEvent.CONTENTS_CHANGED, treeModel.getPath(parentNode), path[index], path[index]);
					}
				}

				txtFolder.setText("");
				//
				dispose();
			}
		}
		else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
		{
			dispose();
		}
	} // onEvent

	/**
	 * Insert Folder as Node to Tree.
	 */
	private void insertFolder(String folderName)
	{
		int parentID = 0;
		if (!chkAddAsRoot.isChecked())
		{
			parentID = DPFavourites.getCurrentSelectedNodeID(tree);
			if (parentID > 0)
			{
				favNodeSummary = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(parentID, null);
				if (!favNodeSummary.isSummary())
				{
					if (favNodeSummary.getParent_ID() > 0)
						parentID = favNodeSummary.getParent_ID();
					else
						parentID = 0;
				}
			}
		}

		MTreeFavoriteNode favNode = MTreeFavoriteNode.create(	Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()),
																MTreeFavorite.getFavoriteTreeID(Env.getAD_User_ID(Env.getCtx())),
																0, parentID, 0, folderName, true, !chkDefaultExpanded.isChecked(), false);
		//
		DPFavourites.addNodeInTree(treeModel, tree, treeModel.find(null, favNode.getParent_ID()), favNode);
	} // insertFolder

}
