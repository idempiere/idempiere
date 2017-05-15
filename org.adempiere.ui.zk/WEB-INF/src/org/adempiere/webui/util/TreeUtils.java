/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.util;

import java.util.Collection;
import java.util.Iterator;

import org.zkoss.zk.ui.Component;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Tree;
import org.zkoss.zul.TreeModel;
import org.zkoss.zul.TreeNode;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.ext.TreeOpenableModel;

/**
 * 
 * @author hengsin
 *
 */
public class TreeUtils {

	/**
	 * copy from Tree.java
	 */
	private static final String ATTR_ON_INIT_RENDER_POSTED =
			"org.zkoss.zul.Tree.onInitLaterPosted";
		
	/**
	 * Collapse all nodes
	 * @param tree
	 */
	public static void collapseAll(Tree tree) {
		traverse(tree, new TreeItemAction() {
			public void run(Treeitem treeItem) {
				treeItem.setOpen(false);
			}
			
		});
	}
	
	/**
	 * Expand all nodes
	 * @param tree
	 */
	public static void expandAll(Tree tree) {
		traverse(tree, new TreeItemAction() {
			public void run(Treeitem treeItem) {
				treeItem.setOpen(true);
			}			
		});
	}
	
	/**
	 * Traverse tree and execution action on Treeitem
	 * @param tree
	 * @param action
	 */
	public static void traverse(Tree tree, TreeItemAction action)
	{
		Treechildren treechildren = tree.getTreechildren();
		traverse(treechildren, action);
	}
	
	/**
	 * Traverse treechildren and execution action on Treeitem
	 * @param treechildren
	 * @param action
	 */
	public static void traverse(Treechildren treechildren, TreeItemAction action)
	{
		Object[] list = treechildren.getChildren().toArray();
		for(int index = 0; index < list.length; index++)
		{
			Object o = list[index];
			if(o instanceof Treechildren)
			{
				Treechildren treechild = (Treechildren) o;
				traverse(treechild, action);
			}
			else if(o instanceof Treeitem)
			{
				Treeitem treeitem = (Treeitem) o;
				action.run(treeitem);
	
				Object[] treeitemChildren = treeitem.getChildren().toArray();
				for(int childIndex = 0; childIndex < treeitemChildren.length; childIndex++)
				{
					Object child = treeitemChildren[childIndex];
					if(child instanceof Treechildren)
					{
						Treechildren treechild = (Treechildren) child;
						traverse(treechild, action);
					}
				}
			}
		}
	}

	/**
	 * Traverse tree model and execution action on tree node
	 * @param model
	 * @param action
	 */
	public static void traverse(TreeModel<Object> model, TreeNodeAction action) {
		traverse(model, model.getRoot(), action);
		
	}

	/**
	 * Traverse tree model from parent and execution action on tree node
	 * @param model
	 * @param parent
	 * @param action
	 */
	public static void traverse(TreeModel<Object> model, Object parent,
			TreeNodeAction action) {
		int count = model.getChildCount(parent);
		for(int i = 0; i < count; i++) {
			Object child = model.getChild(parent, i);
			if (child instanceof DefaultTreeNode) {
				action.run((DefaultTreeNode<?>) child);
			}
			traverse(model, child, action);
		}
	}
	
	public static boolean isOnInitRenderPosted(Tree tree) {
		if (tree.getAttribute(ATTR_ON_INIT_RENDER_POSTED) != null) {
			return ((Boolean)tree.getAttribute(ATTR_ON_INIT_RENDER_POSTED)).booleanValue();
		}
		return false;
	}

	/**
	 * travel all node of tree, at selected node, call callback function
	 * @param tree
	 * @param nodeModel
	 * @param isRootNode
	 * @param processNode
	 */
	static public void collapseTree (Component treeObject, boolean isOpen){
		if (treeObject instanceof Tree) {
			Tree tree = (Tree)treeObject;
			if (tree.getModel() != null && tree.getModel() instanceof TreeOpenableModel){
				collapseTreeModel ((TreeOpenableModel)tree.getModel(), isOpen, null);
				return;
			}
		}

		if (treeObject instanceof Treeitem) {// Tree also is Treeitem
			Treeitem treeitem = (Treeitem) treeObject;
			treeitem.setOpen(isOpen);
		}
		Collection<?> com = treeObject.getChildren();
		if (com != null) {
			for (Iterator<?> iterator = com.iterator(); iterator.hasNext();) {
				collapseTree((Component) iterator.next(), isOpen);

			}
		}
	}

	static protected <T> void collapseTreeModel (TreeOpenableModel treeModelOpenable, boolean isOpen, T treeNode){
		if (!isOpen){
			treeModelOpenable.clearOpen();
			return;//done, easy to close all node
		}else{
			if (!(treeModelOpenable instanceof TreeModel<?>)){
				return;//model have to be a instance of TreeModel. because it provide method to add open object
			}

			if (treeNode != null && !(treeNode instanceof TreeNode<?>)){
				return; //don't support, at least it's TreeNode to travel child node
			}

			@SuppressWarnings("unchecked")
			TreeModel<T> treeModel = (TreeModel<T>)treeModelOpenable;

			if (treeNode == null){// get from model
				Object rootNode = treeModel.getRoot();
				if (!(rootNode instanceof TreeNode<?>)){
					return;//don't support, at least it's TreeNode to travel child node 
				}

				@SuppressWarnings("unchecked")
				TreeNode<T> node = (TreeNode<T>)rootNode;
				collapseTreeModel (treeModelOpenable, isOpen, node);
			}else{//child node

				TreeNode<?> node = (TreeNode<?>)treeNode;

				treeModelOpenable.addOpenPath(treeModel.getPath(treeNode));


				if (node.getChildren() != null) {
					for (TreeNode<?> childNode : node.getChildren()){
						collapseTreeModel (treeModelOpenable, isOpen, childNode);
					}
				}
			}
		}
	}
}
