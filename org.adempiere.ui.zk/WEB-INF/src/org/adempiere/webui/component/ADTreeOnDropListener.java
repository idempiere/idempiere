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
package org.adempiere.webui.component;

import java.util.logging.Level;

import org.adempiere.webui.adwindow.ADTabpanel;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.ADWindowContent;
import org.adempiere.webui.adwindow.IADTabpanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.MTree;
import org.compiere.model.MTreeNode;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class ADTreeOnDropListener implements EventListener<Event> {
	
	private SimpleTreeModel treeModel;
	private MTree mTree;
	private int windowNo;
	private Tree tree;
	
	private static final CLogger log = CLogger.getCLogger(ADTreeOnDropListener.class);

	/**
	 * 
	 * @param tree
	 * @param model
	 * @param mTree
	 * @param windowNo
	 */
	public ADTreeOnDropListener(Tree tree, SimpleTreeModel model, MTree mTree, int windowNo) {
		this.tree = tree;
		this.treeModel = model;
		this.mTree = mTree;
		this.windowNo = windowNo;
	}

	/**
	 * @param event
	 */
	@SuppressWarnings("unchecked")
	public void onEvent(Event event) throws Exception {
		if (event instanceof DropEvent) {
			DropEvent de = (DropEvent) event;
			if (log.isLoggable(Level.FINE)) log.fine("Source=" + de.getDragged() + " Target=" + de.getTarget());
			if (de.getDragged() != de.getTarget()) {
				Treeitem src = (Treeitem) ((Treerow) de.getDragged()).getParent();
				Treeitem target = (Treeitem) ((Treerow) de.getTarget()).getParent();
				moveNode((DefaultTreeNode<Object>)src.getValue(), (DefaultTreeNode<Object>)target.getValue());
			}
		} 
	}
	
	/**
	 *	Move TreeNode
	 *	@param	movingNode	The node to be moved
	 *	@param	toNode		The target node
	 */
	private void moveNode(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode)
	{
		log.info(movingNode.toString() + " to " + toNode.toString());

		if (movingNode == toNode)
			return;
		
		MTreeNode toMNode = (MTreeNode) toNode.getData();
				
		if (!toMNode.isSummary())	//	drop on a child node
		{
			moveNode(movingNode, toNode, false);
		}
		else						//	drop on a summary node
		{
			//prompt user to select insert after or drop into the summary node
			int path[] = treeModel.getPath(toNode);
			Treeitem toItem = tree.renderItemByPath(path);
			
			//tree.setSelectedItem(toItem);
			//Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));

			MenuListener listener = new MenuListener(movingNode, toNode);

			Menupopup popup = new Menupopup();
			Menuitem menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), "InsertAfter"));
			menuItem.setValue("InsertAfter");
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, listener);

			menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), "MoveInto"));
			menuItem.setValue("MoveInto");
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, listener);

			popup.setPage(tree.getPage());
			popup.open(toItem.getTreerow());
		}
		
	}	//	moveNode
	
	private void moveNode(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode, boolean moveInto)
	{
		DefaultTreeNode<Object> newParent;
		int index;		
		
		//  remove
		DefaultTreeNode<Object> oldParent = treeModel.getParent(movingNode);
		treeModel.removeNode(movingNode);
		
		//get new index
		if (!moveInto)
		{
			newParent = treeModel.getParent(toNode);
			index = newParent.getChildren().indexOf(toNode) + 1;	//	the next node
		}
		else									//	drop on a summary node
		{
			newParent = toNode;
			index = 0;                   			//	the first node
		}
		
		//  insert
		newParent = treeModel.addNode(newParent, movingNode, index);
		
		int path[] = treeModel.getPath(movingNode);
		if (TreeUtils.isOnInitRenderPosted(tree) || tree.getTreechildren() == null)
		{
			tree.onInitRender();
		}
		@SuppressWarnings("unused")
		Treeitem movingItem = tree.renderItemByPath(path);		
		//tree.setSelectedItem(movingItem);
		//Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));

		//	***	Save changes to disk
		Trx trx = Trx.get (Trx.createTrxName("ADTree"), true);
		trx.setDisplayName(getClass().getName()+"_moveNode");
		try
		{
			MTreeNode oldMParent = (MTreeNode) oldParent.getData();
			for (int i = 0; i < oldParent.getChildCount(); i++)
			{
				DefaultTreeNode<?> nd = (DefaultTreeNode<?>)oldParent.getChildAt(i);
				MTreeNode md = (MTreeNode) nd.getData();
				updateNodePO(oldMParent, md, i, trx.getTrxName());
			}
			if (oldParent != newParent) 
			{
				MTreeNode newMParent = (MTreeNode) newParent.getData();
				for (int i = 0; i < newParent.getChildCount(); i++)
				{
					DefaultTreeNode<?> nd = (DefaultTreeNode<?>)newParent.getChildAt(i);
					MTreeNode md = (MTreeNode) nd.getData();
					updateNodePO(newMParent, md, i, trx.getTrxName());
				}
			}
			//	COMMIT          *********************
			trx.commit(true);
			
			Component c = SessionManager.getAppDesktop().getActiveWindow();
			ADWindow adwindow = ADWindow.findADWindow(c);
			if (adwindow != null) {
				ADWindowContent adwindowContent = adwindow.getADWindowContent();
				if (trx.hasChangesMadeByEventListener()) {
					Clients.showBusy(null);
					Executions.schedule(c.getDesktop(), e -> {
						adwindowContent.onRefresh();
						Executions.schedule(c.getDesktop(), e1 -> Clients.clearBusy(), new Event("onEchangeIndicatorchoClearBusy"));
					}, new Event("onPostTreeOnDrop"));
				} else {
					adwindowContent.focusToActivePanel();
					IADTabpanel selected = adwindowContent.getADTab().getSelectedTabpanel();
					if (selected instanceof ADTabpanel) {
						((ADTabpanel)selected).setSelectedNode();
					}
				}
			}
		}
        catch (Exception e)
		{
			trx.rollback();
			Dialog.error(windowNo, "TreeUpdateError", e.getLocalizedMessage());
		}
		finally
		{
			trx.close();
			trx = null;
		}
	}
	
	private void updateNodePO(MTreeNode mtnParentNode, MTreeNode mtnMovingNode, int NodeIndex, String trxName) {
		StringBuilder whereClause = new StringBuilder("AD_Tree_ID=").append(mTree.getAD_Tree_ID())
				.append(" AND Node_ID=").append(mtnMovingNode.getNode_ID());
		PO mnPO = new Query(Env.getCtx(), mTree.getNodeTableName(), whereClause.toString(), trxName).first();
		mnPO.set_ValueNoCheck("Parent_ID", mtnParentNode.getNode_ID());
		mnPO.set_ValueNoCheck("SeqNo", NodeIndex);
		if (mnPO.is_Changed()) 
			mnPO.saveEx(trxName);
	}
	
	class MenuListener implements EventListener<Event> {
		private DefaultTreeNode<Object> movingNode;
		private DefaultTreeNode<Object> toNode;
		MenuListener(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode) {
			this.movingNode = movingNode;
			this.toNode = toNode;
		}
		public void onEvent(Event event) throws Exception {
			if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Menuitem) {
				Menuitem menuItem = (Menuitem) event.getTarget();
				if ("InsertAfter".equals(menuItem.getValue())) {
					moveNode(movingNode, toNode, false);
				} else if ("MoveInto".equals(menuItem.getValue())) {
					moveNode(movingNode, toNode, true);
				}
			}
		}
		
	}
}
