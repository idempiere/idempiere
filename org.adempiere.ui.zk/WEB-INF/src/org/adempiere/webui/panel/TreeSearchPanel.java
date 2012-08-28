/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
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
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.util.List;
import java.util.TreeMap;

import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.AutoComplete;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.util.DocumentSearch;
import org.adempiere.webui.util.TreeItemAction;
import org.adempiere.webui.util.TreeNodeAction;
import org.adempiere.webui.util.TreeUtils;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.event.TreeDataEvent;
import org.zkoss.zul.event.TreeDataListener;
import org.zkoss.zul.impl.LabelElement;
import org.zkoss.zul.impl.LabelImageElement;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 3, 2007
 * @version $Revision: 0.10 $
 */
public class TreeSearchPanel extends Panel implements EventListener<Event>, TreeDataListener
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3478451169922775667L;
	private TreeMap<String, Object> treeNodeItemMap = new TreeMap<String, Object>();
    private String[] treeValues;
    private String[] treeDescription;
    private String[] treeImages;

    private Label lblSearch;
    private AutoComplete cmbSearch;

	private Tree tree;

	private String eventToFire;
	private int m_windowno = 0;
	private int m_tabno = 0;

	private static final String PREFIX_DOCUMENT_SEARCH = "/";

	/**
     * @param tree
     */
    public TreeSearchPanel(Tree tree)
    {
    	this(tree, Events.ON_CLICK);
    }

    /**
     * @param tree
     * @param event
     */
    public TreeSearchPanel(Tree tree, String event)
    {
        super();
        this.tree = tree;
        this.eventToFire = event;
        init();
    }

    /**
     * @param tree
     * @param event
     */
    public TreeSearchPanel(Tree tree, String event, int windowno, int tabno)
    {
        super();
        this.tree = tree;
        this.eventToFire = event;
        m_windowno = windowno;
        m_tabno = tabno;
        init();
    }

    private void init()
    {
    	Hlayout hLayout = new Hlayout();
    	hLayout.setValign("middle");
        lblSearch = new Label();
        lblSearch.setValue(Msg.getMsg(Env.getCtx(),"TreeSearch").replaceAll("&", "") + ":");
        lblSearch.setTooltiptext(Msg.getMsg(Env.getCtx(),"TreeSearchText"));

        cmbSearch = new AutoComplete();
        cmbSearch.setAutodrop(true);
       	cmbSearch.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unqCmbSearch" + "_" + m_windowno + "_" + m_tabno);
      
        cmbSearch.addEventListener(Events.ON_CHANGE, this);
        if (AEnv.isInternetExplorer())
        {
        	cmbSearch.setWidth("200px");
        }

        hLayout.appendChild(lblSearch);
        hLayout.appendChild(cmbSearch);
        this.appendChild(hLayout);
    }

    private void addTreeItem(Treeitem treeItem)
    {
        String key = getLabel(treeItem);
        treeNodeItemMap.put(key, treeItem);
    }

    private void addTreeItem(DefaultTreeNode node) {
    	Object data = node.getData();
    	if (data instanceof MTreeNode) {
    		MTreeNode mNode = (MTreeNode) data;
    		treeNodeItemMap.put(mNode.getName(), node);
    	}
	}

    /**
     * populate the searchable list
     */
    public void initialise()
    {
    	refreshSearchList();

        if (tree.getModel() != null)
        {
        	tree.getModel().addTreeDataListener(this);
        }
    }

	public void refreshSearchList() {
		treeNodeItemMap.clear();
		if (tree.getModel() == null) {
	    	TreeUtils.traverse(tree, new TreeItemAction() {
				public void run(Treeitem treeItem) {
					if (treeItem.isVisible())
						addTreeItem(treeItem);
				}
	    	});
		} else {
			TreeUtils.traverse(tree.getModel(), new TreeNodeAction() {
				public void run(DefaultTreeNode treeNode) {
					addTreeItem(treeNode);
				}
	    	});
		}

    	treeValues = new String[treeNodeItemMap.size()];
    	treeDescription = new String[treeNodeItemMap.size()];
    	treeImages = new String[treeNodeItemMap.size()];

    	int i = -1;

        for (Object value : treeNodeItemMap.values())
        {
        	i++;
        	if (value instanceof Treeitem)
        	{
        		Treeitem treeItem = (Treeitem) value;
        		treeValues[i] = getLabel(treeItem);
        		treeDescription[i] = treeItem.getTooltiptext();
        		treeImages[i] = getImage(treeItem);
        		if ((treeImages[i] == null || treeImages[i].trim().length() == 0) && isFolder(treeItem))
        		{
        			treeImages[i] = "/images/Folder16.png";
        		}
        	}
        	else if (value instanceof DefaultTreeNode)
        	{
        		DefaultTreeNode sNode = (DefaultTreeNode) value;
        		MTreeNode mNode = (MTreeNode) sNode.getData();
        		treeValues[i] = mNode.getName();
        		treeDescription[i] = mNode.getDescription();
        		treeImages[i] = mNode.getImageIndiactor();
        	}
        }

        cmbSearch.setDescription(treeDescription);
        cmbSearch.setDict(treeValues);
        cmbSearch.setImages(treeImages);
	}

	private boolean isFolder(Treeitem treeItem) {
		List<Component> list = treeItem.getChildren();
		for (Component c : list) {
			if (c instanceof Treechildren && ((Treechildren)c).getChildren().size() > 1) {
				return true;
			}
		}
		return false;
	}

	private String getLabel(Treeitem treeItem) {
		String label = treeItem.getLabel();
        if (label == null || label.trim().length() == 0) 
        {
        	if (treeItem.getTreerow().getFirstChild().getFirstChild() != null &&
        		treeItem.getTreerow().getFirstChild().getFirstChild() instanceof LabelElement)
        	{
        		LabelElement element = (LabelElement) treeItem.getTreerow().getFirstChild().getFirstChild();
        		label = element.getLabel();
        	}
        }
        return label;
	}
	
	private String getImage(Treeitem treeItem) {
		String image = treeItem.getImage();
        if (image == null || image.trim().length() == 0) 
        {
        	if (treeItem.getTreerow().getFirstChild().getFirstChild() != null &&
        		treeItem.getTreerow().getFirstChild().getFirstChild() instanceof LabelImageElement)
        	{
        		LabelImageElement element = (LabelImageElement) treeItem.getTreerow().getFirstChild().getFirstChild();
        		image = element.getImage();
        	}
        }
        return image;
	}

	/**
     * @param event
     * @see EventListener#onEvent(Event)
     */
    public void onEvent(Event event)
    {
        if (cmbSearch.equals(event.getTarget()) && (event.getName().equals(Events.ON_CHANGE)))
        {
            String value = cmbSearch.getValue();

            if (value != null && value.trim().length() > 0
            		&& value.substring(0, 1).equals(PREFIX_DOCUMENT_SEARCH))
            {
            	DocumentSearch search = new DocumentSearch();
            	if (search.openDocumentsByDocumentNo(value.substring(1)))
    				cmbSearch.setText(null);
            	return;
            }

            Object node = treeNodeItemMap.get(value);
            Treeitem treeItem = null;
            if (node == null) {
            	return;
            } else if (node instanceof Treeitem) {
	            treeItem = (Treeitem) node;
            } else {
            	DefaultTreeNode sNode = (DefaultTreeNode) node;
            	int[] path = tree.getModel().getPath(sNode);
    			treeItem = tree.renderItemByPath(path);
    			tree.setSelectedItem(treeItem);
            }
            if (treeItem != null)
            {
                select(treeItem);
                Clients.showBusy(Msg.getMsg(Env.getCtx(), "Loading"));
                Events.echoEvent("onPostSelect", this, null);
            }
        }
    }

    /**
     * don't call this directly, use internally for post selection event
     */
    public void onPostSelect() {
    	Clients.clearBusy();
    	Event event = null;
    	if (eventToFire.equals(Events.ON_CLICK))
    	{
    		if (tree.getSelectedItem().getTreerow().getFirstChild().getFirstChild() instanceof A)
    		{
    			event = new Event(Events.ON_CLICK, tree.getSelectedItem().getTreerow().getFirstChild().getFirstChild());
    		}
    		else
    		{
    			event = new Event(Events.ON_CLICK, tree.getSelectedItem().getTreerow());
    		}
    	}
    	else
    		event = new Event(eventToFire, tree);
    	Events.postEvent(event);
    }

	public static void select(Treeitem selectedItem) {
		Treeitem parent = selectedItem.getParentItem();
		while (parent != null) {
			if (!parent.isOpen())
				parent.setOpen(true);

			parent = parent.getParentItem();
		}
		selectedItem.getTree().setSelectedItem(selectedItem);
	}

	/**
	 * @param event
	 * @see TreeDataListener#onChange(TreeDataEvent)
	 */
	public void onChange(TreeDataEvent event) {
		refreshSearchList();
	}
}
