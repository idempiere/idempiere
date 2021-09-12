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
import java.util.Set;
import java.util.TreeMap;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.AutoComplete;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.DocumentSearch;
import org.adempiere.webui.util.TreeItemAction;
import org.adempiere.webui.util.TreeNodeAction;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.SelectEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;
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
public class TreeSearchPanel extends Panel implements EventListener<Event>, TreeDataListener, IdSpace
{
	public static final String TREE_ROW_MOVABLE = "tree.row.movable";

	/**
	 * 
	 */
	private static final long serialVersionUID = -1659100374345282774L;

	private static final String ON_COMBO_SELECT_ECHO_EVENT = "onComboSelectEcho";
	private static final String ON_POST_SELECT_TREEITEM_EVENT = "onPostSelectTreeitem";
	protected static final String ON_POST_FIRE_TREE_EVENT = "onPostFireTreeEvent";
	protected TreeMap<String, Object> treeNodeItemMap = new TreeMap<String, Object>();
    protected String[] treeValues;
    protected String[] treeTypes;
    protected String[] treeDescription;
    protected String[] treeImages;

    private Label lblSearch;
    protected AutoComplete cmbSearch;

	protected Tree tree;

	protected String eventToFire;
	@SuppressWarnings("unused")
	private int m_windowno = 0;
	@SuppressWarnings("unused")
	private int m_tabno = 0;
	private Treeitem selectedItem;
	protected Hlayout layout;

	private Hlayout moveItemBox;

	private ToolBarButton moveItemBtn;

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

    private static final String onComboSelectEchoScript = "var combo=zk('@combo').$();"
    		+ "var panel=zk('@this').$();"
    		+ "var comboitem=zk('@item').$();"
    		+ "var popupheight=combo.getPopupNode_().offsetHeight;"
    		+ "var evt = new zk.Event(panel, 'onComboSelectEcho', [comboitem.uuid, popupheight], {toServer: true});"
    		+ "zAu.send(evt);";
	
    protected void init()
    {
    	layout = new Hlayout();
    	layout.setHflex("1");
    	layout.setValign("middle");
        lblSearch = new Label();
        lblSearch.setValue(Msg.getMsg(Env.getCtx(),"TreeSearch").replaceAll("&", "") + ":");
        lblSearch.setTooltiptext(Msg.getMsg(Env.getCtx(),"TreeSearchText"));

        cmbSearch = new AutoComplete();
        cmbSearch.setAutodrop(true);
        cmbSearch.setAutocomplete(false);
       	cmbSearch.setId("treeSearchCombo");
       	cmbSearch.setSclass("tree-search-combo");
      
        cmbSearch.addEventListener(Events.ON_OK, this);
        cmbSearch.addEventListener(Events.ON_SELECT, new EventListener<SelectEvent<Comboitem,Object>>() {
			@Override
			public void onEvent(SelectEvent<Comboitem, Object> event)
					throws Exception {
				Set<Comboitem> set = event.getSelectedItems();
        		if (set.size() > 0) {
        			Comboitem item = set.iterator().next();
        			String script = onComboSelectEchoScript.replaceFirst("@combo", cmbSearch.getUuid())
        				.replaceFirst("@this", TreeSearchPanel.this.getUuid())
        				.replaceFirst("@item", item.getUuid());
        			AuScript response = new AuScript(script);
        			Clients.response(response);
        		}				
			}
		});
        
        addEventListener(ON_COMBO_SELECT_ECHO_EVENT, this);
        addEventListener(ON_POST_SELECT_TREEITEM_EVENT, this);
        if (AEnv.isInternetExplorer())
        {
        	ZKUpdateUtil.setWidth(cmbSearch, "200px");
        }

        layout.appendChild(lblSearch);
        layout.appendChild(cmbSearch);
        //move selected treeitem for mobile, alternative to dnd
        if (ClientInfo.isMobile())
        {
	        moveItemBtn = new ToolBarButton();
	        moveItemBtn.setSclass("tree-moveitem-btn");
	        moveItemBtn.setIconSclass("z-icon-arrows-alt");
	        layout.appendChild(moveItemBtn);
	        moveItemBtn.addEventListener(Events.ON_CLICK, evt -> onMoveBtnClicked());
	        tree.addEventListener("onPostMove", evt -> onPostMove(evt));
        }
        this.appendChild(layout);
        
        addEventListener(ON_POST_FIRE_TREE_EVENT, this);
        
        if (ClientInfo.isMobile()) {
        	tree.addEventListener(Events.ON_SELECT, evt -> onSelect(evt));
        }
    }

    private void onSelect(Event evt) {
		if (moveItemBox != null) {
			Treeitem selected = tree.getSelectedItem();
			Treerow selectedRow = selected.getTreerow();
			Component dragged = (Component) moveItemBox.getAttribute("draggedComponent");
			DropEvent event = new DropEvent(Events.ON_DROP, selectedRow, dragged, 0, 0, 0, 0, 0);	
			moveItemBox.detach();
			moveItemBox = null;
			moveItemBtn.setSclass("tree-moveitem-btn");
			moveItemBtn.setAttribute("draggedComponent", dragged);
			Events.postEvent(event);
			Events.postEvent("onPostMove", tree, selected);						
		}
	}
    
    private void onPostMove(Event evt) {
    	Treeitem item = (Treeitem) evt.getData();
    	Treerow dragged = (Treerow) moveItemBtn.getAttribute("draggedComponent");
    	if (dragged == null) return;
    	Treeitem draggedItem = (Treeitem) dragged.getParent();
    	if (item.getNextSibling() != null) {
    		Treeitem next = (Treeitem) item.getNextSibling();
    		if (next.getValue().equals(draggedItem.getValue())) {
	    		tree.setSelectedItem(next);
	        	next.focus();
	        	Events.postEvent(Events.ON_SELECT, tree, next);
    		}
    	}    	
    }

	private void onMoveBtnClicked() {
		if (moveItemBox != null) {
			moveItemBox.detach();
			moveItemBox = null;
			moveItemBtn.setSclass("tree-moveitem-btn");
			Treeitem ti = tree.getSelectedItem();
			if (ti != null)
				ti.focus();
			return;
		}
		moveItemBtn.setSclass("tree-moveitem-btn pressed");
		Treeitem ti = tree.getSelectedItem();
		if (ti == null) return;
		Treerow tr = ti.getTreerow();
		if (tr == null) return;
		if (tr.getAttribute(TREE_ROW_MOVABLE) == null) return;
		moveItemBox = new Hlayout();
		Label l = new Label(Msg.getMsg(Env.getCtx(), "MoveSelectedTreeItem"));
		l.setStyle("font-weight: 600");
		moveItemBox.appendChild(l);
		moveItemBox.setValign("middle");
		ToolBarButton btn = new ToolBarButton();
		btn.setIconSclass("z-icon-remove");
		moveItemBox.appendChild(btn);
		moveItemBox.setAttribute("draggedComponent", tr);
		btn.addEventListener(Events.ON_CLICK, e -> {
			moveItemBox.detach();
			moveItemBox = null;
			moveItemBtn.setSclass("tree-moveitem-btn");
			if (tree.getSelectedItem() != null)
				tree.getSelectedItem().focus();
		});
		this.insertBefore(moveItemBox, layout);
		String script = "var w=zk.Widget.$('#" + moveItemBox.getUuid() + "'); ";
		script += "var e=jq('#" + layout.getUuid() + "'); "; 
		script += "w.setWidth(e.css('width')); ";
		Clients.response(new AuScript(script));
		ti.focus();
	}

	protected void addTreeItem(Treeitem treeItem)
    {
        StringBuilder key = new StringBuilder(getLabel(treeItem)).append(".").append(treeItem.getAttribute("menu.type"));
        treeNodeItemMap.put(key.toString(), treeItem);
    }

    protected void addTreeItem(DefaultTreeNode<?> node) {
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
				public void run(DefaultTreeNode<?> treeNode) {
					addTreeItem(treeNode);
				}
	    	});
		}

    	treeValues = new String[treeNodeItemMap.size()];
    	treeDescription = new String[treeNodeItemMap.size()];
    	treeImages = new String[treeNodeItemMap.size()];
    	treeTypes = new String[treeNodeItemMap.size()];

    	int i = -1;
        for (Object value : treeNodeItemMap.values())
        {
        	i++;
        	if (value instanceof Treeitem)
        	{
        		Treeitem treeItem = (Treeitem) value;
        		treeValues[i] = getLabel(treeItem);
        		treeTypes[i]= String.valueOf(treeItem.getAttribute("menu.type")); 
        		treeDescription[i] = treeItem.getTooltiptext();
        		treeImages[i] = getImage(treeItem);
        		if ((treeImages[i] == null || treeImages[i].trim().length() == 0) && isFolder(treeItem))
        		{
        			treeImages[i] = ThemeManager.getThemeResource("images/Folder16.png");
        		}
        	}
        	else if (value instanceof DefaultTreeNode)
        	{
        		DefaultTreeNode<?> sNode = (DefaultTreeNode<?>) value;
        		MTreeNode mNode = (MTreeNode) sNode.getData();
        		treeValues[i] = mNode.getName();
        		treeDescription[i] = mNode.getDescription();
        		String indicator = mNode.getImageIndiactor();
        		if (!Util.isEmpty(indicator) || mNode.isSummary())
        		{
	        		String imagePath = mNode.getImagePath(); 
	        		if (imagePath != null)
	        		{
	        			if (imagePath.startsWith("/images"))
	        			{
	        				imagePath = ThemeManager.getThemeResource(imagePath.substring(1));
	        			}
	        			else if (imagePath.startsWith("images"))
	        			{
	        				imagePath = ThemeManager.getThemeResource(imagePath);
	        			}
	        		}
	       			treeImages[i] = imagePath != null ? imagePath.intern() : null;
        		}
        	}
        }

        cmbSearch.setDescription(treeDescription);
        cmbSearch.setDict(treeValues);
        cmbSearch.setImages(treeImages);
        cmbSearch.setContents(treeTypes);
	}

	protected boolean isFolder(Treeitem treeItem) {
		List<Component> list = treeItem.getChildren();
		for (Component c : list) {
			if (c instanceof Treechildren && ((Treechildren)c).getChildren().size() > 0) {
				return true;
			}
		}
		return false;
	}

	protected String getLabel(Treeitem treeItem) {
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
	
	protected String getImage(Treeitem treeItem) {
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
        return image != null ? image.intern() : null;
	}

	/**
     * @param event
     * @see EventListener#onEvent(Event)
     */
    public void onEvent(Event event)
    {
        if (cmbSearch.equals(event.getTarget()))
        {
        	if (!cmbSearch.isEnabled())
        		return;
        	
        	if (event.getName().equals(Events.ON_OK))
        	{
	        	selectedItem = null;
	            String value = cmbSearch.getValue();
	
	            if (value != null && value.trim().length() > 0
	            		&& value.substring(0, 1).equals(PREFIX_DOCUMENT_SEARCH))
	            {
	            	DocumentSearch search = new DocumentSearch();
	            	if (search.openDocumentsByDocumentNo(value.substring(1)))
	    				cmbSearch.setText(null);
	            	return;
	            }

	            for(Component comp : cmbSearch.getChildren())
        		{
	            	Comboitem item = (Comboitem) comp;
	            	if (item.getLabel().equals(value))
	            	{
	    				String type = cmbSearch.getContent(item);
	    				if (!Util.isEmpty(type))
	    					selectTreeitem(value+"."+type);
	    				else
	    					selectTreeitem(value);
	    				return;
					}
        		}
        	} 
        } 
        else if (event.getName().equals(ON_POST_FIRE_TREE_EVENT)) 
        {
        	cmbSearch.setEnabled(true);        	
        	cmbSearch.clearLastSel();
        }
        else if (event.getName().equals(ON_COMBO_SELECT_ECHO_EVENT))
        {
        	Object[] data = (Object[]) event.getData();
        	String uuid = (String) data[0];
        	int height = (Integer) data[1];
        	if (height == 0) 
        	{
        		List<Component> childs = cmbSearch.getChildren();
        		for(Component comp : childs)
        		{
        			if (comp.getUuid().equals(uuid))
        			{
        				Comboitem item = (Comboitem) comp;
        				String value = item.getLabel();
        				String type = cmbSearch.getContent(item);
        				if (!Util.isEmpty(type))
        					selectTreeitem(value+"."+type);
        				else
        					selectTreeitem(value);
        			}
        		}	        	
        	}
        	else
        	{
        		cmbSearch.clearLastSel();
        	}
        }
        else if (event.getName().equals(ON_POST_SELECT_TREEITEM_EVENT))
        {
        	onPostSelectTreeitem();
        }
    }

	private void selectTreeitem(String value) {
		if (Executions.getCurrent().getAttribute(getUuid()+".selectTreeitem") != null)
			return;
		
		Object node = treeNodeItemMap.get(value);
		Treeitem treeItem = null;
		if (node == null) {
			return;
		} else if (node instanceof Treeitem) {
		    treeItem = (Treeitem) node;
		} else {
			DefaultTreeNode<?> sNode = (DefaultTreeNode<?>) node;
			int[] path = tree.getModel().getPath(sNode);
			treeItem = tree.renderItemByPath(path);
			tree.setSelectedItem(treeItem);
		}
		if (treeItem != null)
		{
			selectedItem = treeItem;
			Executions.getCurrent().setAttribute(getUuid()+".selectTreeitem", Boolean.TRUE);
		    cmbSearch.setEnabled(false);
		    
		    select(treeItem);		    
		    Clients.showBusy(Msg.getMsg(Env.getCtx(), "Loading"));
		    Events.echoEvent(ON_POST_SELECT_TREEITEM_EVENT, this, null);
		}
	}

    protected void onPostSelectTreeitem() {
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
    	Events.echoEvent(ON_POST_FIRE_TREE_EVENT, this, null);
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
	
	public Treeitem getSelectedItem() {
		return selectedItem;
	}
}
