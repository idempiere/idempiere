/******************************************************************************
 * Copyright (C) 2014 Low Heng Sin                                            *
 * Copyright (C) 2014 Trek Global                                             *
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
package org.adempiere.webui.apps;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.desktop.FavouriteController;
import org.adempiere.webui.panel.AbstractMenuPanel;
import org.adempiere.webui.panel.MenuTreePanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeItemAction;
import org.adempiere.webui.util.TreeNodeAction;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MMenu;
import org.compiere.model.MPreference;
import org.compiere.model.MToolBarButtonRestrict;
import org.compiere.model.MTreeNode;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.ListModels;
import org.zkoss.zul.ListSubModel;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.impl.LabelElement;
import org.zkoss.zul.impl.LabelImageElement;

/**
 * Controller for search on AD_Menu records.
 * @author hengsin
 */
public class MenuSearchController implements EventListener<Event>{

	/** Initial number of menu items loaded into listbox */
	private static final int INITIAL_LOADING_SIZE = 50;

	/** Component attribute to hold reference of {@link MTreeNode} **/
	public static final String M_TREE_NODE_ATTR = "MTreeNode";
	
	/** font icon sclass for already added to favourite menu item **/
	private static final String Z_ICON_STAR_O = "z-icon-star-o";
	/** font icon sclass for not yet added to favourite menu item **/
	private static final String Z_ICON_STAR = "z-icon-star";
	/** Event echo from {@link #search(String)} to initiate search action **/
	private static final String ON_SEARCH_ECHO_EVENT = "onSearchEcho";
	/** Event to load all menu items into {@link #listbox}. Default is to load the first {@link #INITIAL_LOADING_SIZE} only. **/
	private static final String ON_LOAD_MORE_EVENT = "onLoadMore";
	/** {@link Listitem} attribute to store the last timestamp of ON_CLICK or ON_SELECT event **/
	private static final String ONSELECT_TIMESTAMP_ATTR = "onselect.timestamp";
	/** name of star button **/
	private static final String STAR_BUTTON_NAME = "Star";
	/** name of new button **/
	private static final String NEW_BUTTON_NAME = "New";
	/** tree for AD_Menu **/
	private Tree tree;
	/** list box for menu items **/
	private Listbox listbox;
	/** model for all menu items **/
	private ListModelList<MenuItem> model;
	/** main layout component. parent of {@link #listbox}. **/
	private Vlayout layout;
	/** model for all menu items **/
	private ListModelList<MenuItem> fullModel;
	/** true when controller is handling event from Star/Favourite button **/
	private boolean inStarEvent;
	
	private String highlightText = null;

	/** List of recently access menu items (AD_Menu_ID) */
	private List<String> recentMenuItemIds = new ArrayList<>();
	
	/** Event post from {@link #selectTreeitem(Object, Boolean)} **/
	private static final String ON_POST_SELECT_TREEITEM_EVENT = "onPostSelectTreeitem";
	
	/**
	 * @param tree usually the tree instance from {@link MenuTreePanel}
	 */
	public MenuSearchController(Tree tree) {
		this.tree = tree;
	}
	
	/**
	 * Load recently access menu items
	 */
	private List<String> loadRecentItems() {		
		List<String> recents = new ArrayList<String>();
		int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		int AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());
		int AD_Org_ID = 0;
		String attribute = AD_Role_ID+"|RecentMenuItems";
		Query query = new Query(Env.getCtx(), MPreference.Table_Name, "PreferenceFor=? AND Attribute=? AND AD_Org_ID=? AND AD_User_ID=? AND AD_Window_ID=?", null);
		MPreference preference = query.setClient_ID().setParameters("W", attribute, AD_Org_ID, AD_User_ID, SystemIDs.WINDOW_MENU).first();
		if (preference != null) {
			String[] recentItems = preference.getValue().split("[,]");
			for (String recentItem : recentItems) {
				recents.add(recentItem);
			}
		}
		return recents;
	}
	
	/**
	 * If there are changes in the recent menu items for user, reload and update menu items model
	 */
	public void updateRecentItems() {
		List<String> recents = loadRecentItems();
		if (!recents.equals(recentMenuItemIds)) {
			recentMenuItemIds = recents;
			sortMenuItemModel();
			moveRecentItems();
			if (fullModel != null)
				updateListboxModel(model);
		}
	}
	
	/**
	 * Populate {@link #model} from {@link #tree}
	 */
	public void refreshModel() {
		recentMenuItemIds = loadRecentItems();
		final List<MenuItem> list = new ArrayList<MenuItem>();
		if (tree.getModel() == null) {
	    	TreeUtils.traverse(tree, new TreeItemAction() {
				public void run(Treeitem treeItem) {
					if (treeItem.isVisible())
						addTreeItem(list, treeItem);
				}
	    	});
		} else {
			TreeUtils.traverse(tree.getModel(), new TreeNodeAction() {
				public void run(DefaultTreeNode<?> treeNode) {
					addTreeItem(list, treeNode);
				}
	    	});
		}
		model = new ListModelList<MenuItem>(list, true);
		sortMenuItemModel();		
		moveRecentItems();
	}

	/**
	 * Sort menu items model in alphabetical order
	 */
	private void sortMenuItemModel() {
		model.sort(new Comparator<MenuItem>() {			
			@Override
			public int compare(MenuItem o1, MenuItem o2) {
				return o1.getLabel().compareTo(o2.getLabel());
			}
		}, true);
	}
	
	/**
	 * Move the 7 most recently access menu items to the top of menu items model
	 */
	private void moveRecentItems() {
		if (recentMenuItemIds.size() > 0) {
			List<MenuItem> recents  = new ArrayList<MenuItem>();
			for(String id : recentMenuItemIds) {
				for(int i = 0; i < model.getSize(); i++) {
					if (model.get(i).getData() instanceof Treeitem ti) {
						if (ti.getValue() instanceof String tis) {
							if (tis.equals(id)) {
								recents.add(model.get(i));
								break;
							}
						}
					}
				}
			}
			if (recents.size() > 0) {
				for (MenuItem mi : recents) {
					model.remove(mi);
				}
				for(int i = recents.size()-1; i >= 0; i--) {
					model.add(0, recents.get(i));
				}
			}
		}
	}

	/** 
	 * Add treeNode to list
	 * @param list
	 * @param treeNode
	 */
	private void addTreeItem(List<MenuItem> list, DefaultTreeNode<?> treeNode) {
		MTreeNode mNode = (MTreeNode) treeNode.getData();
		if (!mNode.isLeaf())
			return;
		
		MenuItem item = new MenuItem();
		item.setLabel(mNode.getName());
		item.setDescription(mNode.getDescription());
		item.setImage(mNode.getImagePath());
		item.setData(treeNode);		
		list.add(item);		
	}

	/**
	 * @param treeItem
	 * @return true if treeItem is a folder
	 */
	private boolean isFolder(Treeitem treeItem) {
		List<Component> list = treeItem.getChildren();
		for (Component c : list) {
			if (c instanceof Treechildren && ((Treechildren)c).getChildren().size() > 0) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Add treeItem to list
	 * @param list
	 * @param treeItem
	 */
	private void addTreeItem(List<MenuItem> list, Treeitem treeItem) {
		if (isFolder(treeItem))
			return;
		
		MenuItem item = new MenuItem();
		item.setLabel(getLabel(treeItem));
		item.setDescription(treeItem.getTooltiptext());
		
		String image = getImage(treeItem);
		if (image == null || image.length() == 0)
		{
			image = ThemeManager.getThemeResource("images/Folder16.png");
		}
		item.setImage(image);
		item.setData(treeItem);
		list.add(item);		
		item.setType((String) treeItem.getAttribute(AbstractMenuPanel.MENU_TYPE_ATTRIBUTE));
	}
	
	/**
	 * @param treeItem
	 * @return label for treeItem
	 */
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
	
	/**
	 * @param treeItem
	 * @return image url or font icon sclass (start with z-icon)
	 */
	private String getImage(Treeitem treeItem) {
		String image = treeItem.getImage();
        if (image == null || image.trim().length() == 0) 
        {
        	if (treeItem.getTreerow().getFirstChild().getFirstChild() != null &&
        		treeItem.getTreerow().getFirstChild().getFirstChild() instanceof LabelImageElement)
        	{
        		LabelImageElement element = (LabelImageElement) treeItem.getTreerow().getFirstChild().getFirstChild();
        		if (ThemeManager.isUseFontIconForImage() && element.getIconSclass() != null)
        			image = element.getIconSclass();
        		else
        			image = element.getImage();
        	}
        }
        return image != null ? image.intern() : null;
	}
	
	/**
	 * Call {@link #refreshModel()} and layout UI.
	 * @param parent
	 */
	public void create(Component parent) {
		refreshModel();
		
		layout = new Vlayout();
		ZKUpdateUtil.setHeight(layout, "100%");
		parent.appendChild(layout);
		
		listbox = new Listbox();
		listbox.setEmptyMessage(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "FindZeroRecords")));
		listbox.setStyle("border: none");
		ZKUpdateUtil.setWidth(listbox, "100%");
		ZKUpdateUtil.setVflex(listbox, "true");
		layout.appendChild(listbox);
		listbox.setItemRenderer(new MenuItemRenderer());
		listbox.addEventListener(Events.ON_SELECT, this);
		listbox.addEventListener(ON_POST_SELECT_TREEITEM_EVENT, this);
		ListHead listhead = new ListHead();
		listbox.appendChild(listhead);
		Listheader listheader = new Listheader();
		listhead.appendChild(listheader);
		listheader = new Listheader();
		listheader.setAlign("center");
		listheader.setValign("middle");
		ZKUpdateUtil.setWidth(listheader, "28px");
		listhead.appendChild(listheader);
		listheader = new Listheader();
		listheader.setAlign("center");
		listheader.setValign("middle");
		ZKUpdateUtil.setWidth(listheader, "28px");
		listhead.appendChild(listheader);
		
		layout.addEventListener(ON_SEARCH_ECHO_EVENT, this);
		layout.addEventListener(ON_LOAD_MORE_EVENT, this);
		updateListboxModel(model);
		
		FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getSession());
		controller.addDeletedCallback(t -> onDeletedCallback(t));
		controller.addInsertedCallback(t -> onInsertedCallback(t));
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_SELECT.equals(event.getName())) {
			ListItem selected = listbox.getSelectedItem();
			if (selected == null) return;
			onSelect(selected, Boolean.FALSE);
		} else if (event.getName().equals(ON_POST_SELECT_TREEITEM_EVENT)) {
        	onPostSelectTreeitem((Boolean) event.getData());
		} else if (Events.ON_CLICK.equals(event.getName())) {
        	if (event.getTarget() instanceof ListItem) {
	        	ListItem item = (ListItem) event.getTarget();
	        	Long onSelect = (Long) item.getAttribute(ONSELECT_TIMESTAMP_ATTR);
	        	if (onSelect == null) {
	        		onSelect(item, Boolean.FALSE);
	        	} else if (System.currentTimeMillis() - onSelect.longValue() > 1000) {
	        		onSelect(item, Boolean.FALSE);
	        	}
        	} else if (event.getTarget() instanceof ToolBarButton) {
        		ToolBarButton btn = (ToolBarButton) event.getTarget();
        		if (NEW_BUTTON_NAME.equals(btn.getName())) { 
        			ListItem item = null;
        			Component parent = event.getTarget();
        			while (parent != null) {
        				if (parent instanceof ListItem) {
        					item = (ListItem) parent;
        					break;
        				}
        				parent = parent.getParent();
        			}
        			if (item != null) {
        				onSelect(item, Boolean.TRUE);
        			}
        		} else if (STAR_BUTTON_NAME.equals(btn.getName())) {
        			inStarEvent = true;
        			FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getSession());
        			if (Z_ICON_STAR_O.equals(btn.getIconSclass())) {
        				btn.setIconSclass(Z_ICON_STAR);
        				btn.setTooltiptext(Msg.getMsg(Env.getCtx(), "RemoveFromFavourites"));
        				controller.addNode((MTreeNode) btn.getAttribute(M_TREE_NODE_ATTR));
        			} else if (Z_ICON_STAR.equals(btn.getIconSclass())) {
        				btn.setIconSclass(Z_ICON_STAR_O);
        				btn.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddToFavourites"));
        				controller.removeNode(((MTreeNode) btn.getAttribute(M_TREE_NODE_ATTR)).getNode_ID());
        			}
        			inStarEvent = false;
        		}
        	}
        } else if (event.getName().equals(ON_SEARCH_ECHO_EVENT)) {
        	onSearchEcho((String) event.getData());
        } else if (event.getName().equals(ON_LOAD_MORE_EVENT)) {
        	loadMore();
        }	
	}
	
	private void onInsertedCallback(MTreeNode node) {
		if (inStarEvent) return;
		ListModel<?> t = listbox.getModel();
        listbox.setModel((ListModel<?>)null);
        listbox.setModel(t);
	}
	
	private void onDeletedCallback(Integer nodeId) {
		if (inStarEvent) return;
		ListModel<?> t = listbox.getModel();
        listbox.setModel((ListModel<?>)null);
        listbox.setModel(t);
	}

	/**
	 * Echo {@link #ON_LOAD_MORE_EVENT} if selected is of type "...".<br/>
	 * Otherwise delegate to {@link #selectTreeitem(Object, Boolean)}.
	 * @param selected
	 * @param newRecord true if event is originated from new record button
	 */
	private void onSelect(ListItem selected, Boolean newRecord) {
		MenuItem item = selected.getValue();
		if (item == null) return;
		if ("...".equals(item.getType())) {
			selected.setAttribute(ONSELECT_TIMESTAMP_ATTR, System.currentTimeMillis());
			Clients.showBusy(selected, null);
			Events.echoEvent(ON_LOAD_MORE_EVENT, layout, null);
		} else {
			if (newRecord) {
				Treeitem ti = (Treeitem)item.getData();
				MMenu menu = MMenu.get(Integer.parseInt(ti.getValue()));
				if (MToolBarButtonRestrict.isNewButtonRestricted(menu.getAD_Window_ID()))
					newRecord = false;
			}
			selectTreeitem(item.getData(), newRecord);
			selected.setAttribute(ONSELECT_TIMESTAMP_ATTR, System.currentTimeMillis());
		}
	}

	/**
	 * Load {@link #fullModel} to {@link #listbox}.<br/>
	 * Only first {@link #INITIAL_LOADING_SIZE} loaded to {@link #listbox} initially.
	 */
	private void loadMore() {
		ListModel<MenuItem> listModel = listbox.getModel();
		ListModelList<MenuItem> lml = (ListModelList<MenuItem>) listModel;
		lml.remove(lml.size()-1);
		List<MenuItem> subList = fullModel.subList(INITIAL_LOADING_SIZE, fullModel.size());
		lml.addAll(subList);
		fullModel = null;
		listbox.setSelectedIndex(INITIAL_LOADING_SIZE);
		Clients.scrollIntoView(listbox.getSelectedItem());
	}
	
	/**
	 * Call {@link #select(Treeitem)} and post {@link #ON_POST_SELECT_TREEITEM_EVENT} event. 
	 * @param node {@link Treeitem} or {@link DefaultTreeNode}
	 * @param newRecord
	 */
	private void selectTreeitem(Object node, Boolean newRecord) {
		if (Executions.getCurrent().getAttribute(listbox.getUuid()+".selectTreeitem") != null)
			return;
		
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
		if (treeItem != null) {
			Executions.getCurrent().setAttribute(listbox.getUuid()+".selectTreeitem", Boolean.TRUE);
		    
		    select(treeItem);		    
		    Events.postEvent(ON_POST_SELECT_TREEITEM_EVENT, listbox, newRecord);
		}
	}
	
	/**
	 * Make sure all parent node is open and ensure tree selected item is selectedItem
	 * @param selectedItem
	 */
	private void select(Treeitem selectedItem) {
		Treeitem parent = selectedItem.getParentItem();
		while (parent != null) {
			if (!parent.isOpen())
				parent.setOpen(true);

			parent = parent.getParentItem();
		}
		selectedItem.getTree().setSelectedItem(selectedItem);
	}
	
	/**
	 * Handle {@link #ON_POST_SELECT_TREEITEM_EVENT} event.<br/>
	 * Post ON_CLICK event to link ({@link A} or {@link Treerow}, handle in {@link AbstractMenuPanel}).
	 * @param newRecord
	 */
	private void onPostSelectTreeitem(Boolean newRecord) {
    	Event event = null;
		if (tree.getSelectedItem().getTreerow().getFirstChild().getFirstChild() instanceof A)
		{
			event = new Event(Events.ON_CLICK, tree.getSelectedItem().getTreerow().getFirstChild().getFirstChild(), newRecord);
		}
		else
		{			
			event = new Event(Events.ON_CLICK, tree.getSelectedItem().getTreerow(), newRecord);
		}
		
    	Events.postEvent(event);
    }
	
	/**
	 * Echo {@link #ON_SEARCH_ECHO_EVENT} to initial search with value.
	 * @param value
	 */
	public void search(String value) {
		listbox.setModel((ListModel<?>)null);
		Events.echoEvent(ON_SEARCH_ECHO_EVENT, layout, value);
	}
	
	/**
	 * Handle {@link #ON_SEARCH_ECHO_EVENT} event.
	 * @param value
	 */
	public void onSearchEcho(String value) {
		ListModelList<MenuItem> newModel = null;
		if (Util.isEmpty(value)) {
			newModel = model;
		} else {
			@SuppressWarnings("unchecked")
			ListSubModel<MenuItem> subModel = (ListSubModel<MenuItem>) ListModels.toListSubModel(model, new MenuListComparator(value), model.size());
			newModel = (ListModelList<MenuItem>) subModel.getSubModel(null, -1);
		}
		updateListboxModel(newModel);
	}

	/**
	 * Update {@link #listbox} with newModel.<br/>
	 * If newModel has > {@link #INITIAL_LOADING_SIZE} items, only first {@link #INITIAL_LOADING_SIZE} is loaded into {@link #listbox}.<br/>
	 * User has to click the load more link (...) to load the rest of the items into {@link #listbox}.
	 * @param newModel
	 */
	private void updateListboxModel(ListModelList<MenuItem> newModel) {
		fullModel = null;
		if (newModel.size() > INITIAL_LOADING_SIZE) {
			List<MenuItem> list = newModel.getInnerList();
			List<MenuItem> subList = list.subList(0, INITIAL_LOADING_SIZE);
			fullModel = newModel;
			newModel = new ListModelList<MenuItem>(subList.toArray(new MenuItem[0]));
			MenuItem more = new MenuItem();
			more.setLabel("...");
			more.setType("...");
			newModel.add(more);
		}
		listbox.setModel(newModel);
	}
	
	/**
	 * Comparator to help filter menu items with a filter value. 
	 */
	private class MenuListComparator implements Comparator<MenuItem> {

		/**
		 * Text to filter menu items by label.
		 * Use startsWith if length of compare is < 3, otherwise use contains for filter.
		 */
		private String compare;

		/**
		 * @param compare filter text
		 */
		private MenuListComparator(String compare) {
			this.compare = Util.deleteAccents(compare.toLowerCase().trim());
		}
		
		@Override
		public int compare(MenuItem o1, MenuItem o2) {			
			String label2 = Util.deleteAccents(o2.getLabel().toLowerCase());
			boolean match = false;
			if (compare.length() < 3)
			{
				match = label2.startsWith(compare);
			}
			else
			{
				match = label2.contains(compare);
			} 
			return match ? 0 : -1;
		}
		
	}
	
	/**
	 * Select ListItem that comes before the current selected ListItem.
	 * @return new selected {@link MenuItem}
	 */
	public MenuItem selectPrior() {
		int i = listbox.getSelectedIndex();
		if (i > 0) {
			listbox.setSelectedIndex(i-1);
			ListItem selected = listbox.getSelectedItem();
			if (selected == null) return null;
			Clients.scrollIntoView(selected);
			MenuItem item = selected.getValue();
			return item;
		}
		return null;
	}
	
	/**
	 * Select ListItem that comes after the current selected ListItem.
	 * @return new selected {@link MenuItem}
	 */
	public MenuItem selectNext() {
		int i = listbox.getSelectedIndex();
		if (i < 0 && listbox.getItemCount() > 0) {
			listbox.setSelectedIndex(0);
			ListItem selected = listbox.getSelectedItem();
			if (selected == null) return null;
			MenuItem item = selected.getValue();			
			return item;
		} else if (i+1 < listbox.getItemCount()) {
			listbox.setSelectedIndex(i+1);
			ListItem selected = listbox.getSelectedItem();
			if (selected == null) return null;
			MenuItem item = selected.getValue();
			if (item == null) return null;
			if ("...".equals(item.getType())) {
				onSelect(selected, Boolean.FALSE);
			}
			Clients.scrollIntoView(selected);
			return item;
		}
		return null;
	}
	
	/**
	 * Handle ON_OK event
	 * @param textbox
	 * @return true if there's partial or exact match for textbox value
	 */
	public boolean onOk(Textbox textbox) {
		String text = textbox.getText();
		if (Util.isEmpty(text))
			return false;
		text = text.toLowerCase();
		ListItem exact = null;
		ListItem firstStart = null;
		int count = listbox.getItemCount();
		for(int i = 0; i < count; i++) {
			ListItem item = listbox.getItemAtIndex(i);
			MenuItem menuItem = item.getValue();
			String label = menuItem.getLabel();
			if (Util.isEmpty(label)) continue;
			if (label.equalsIgnoreCase(text)) {
				exact = item;
				break;
			} else if (firstStart == null && label.toLowerCase().startsWith(text) && text.length() >= 3) {
				firstStart = item;
			}
		}
		if (exact != null) {
			MenuItem menuItem = exact.getValue();
			textbox.setText(menuItem.getLabel());
			onSelect(exact, false);
			return true;
		} else if (firstStart != null) {
			MenuItem menuItem = firstStart.getValue();
			textbox.setText(menuItem.getLabel());
			onSelect(firstStart, false);
			return true;
		}
		return false;
	}
	
	/**
	 * Set text to highlight
	 * @param s
	 */
	public void setHighlightText(String s) {
		highlightText = s;
	}
	
	/**
	 * {@link ListitemRenderer} for {@link #listbox}	 
	 */
	private class MenuItemRenderer implements ListitemRenderer<MenuItem>, ListitemRendererExt {
		private static final String REMOVE_FROM_FAVOURITES_MSG = "RemoveFromFavourites";
		private static final String ADD_TO_FAVOURITES_MSG = "AddToFavourites";		

		@Override
		public Listitem newListitem(org.zkoss.zul.Listbox listbox) {
			return new ListItem();
		}

		@Override
		public Listcell newListcell(Listitem item) {
			return new Listcell(item.getLabel());
		}

		@Override
		public int getControls() {
			return ListitemRendererExt.DETACH_ON_RENDER;
		}

		@Override
		public void render(Listitem item, MenuItem data, int index)
				throws Exception {
			Listcell cell = new Listcell(data.getLabel(), data.getImage());
			if (ThemeManager.isUseFontIconForImage() && data.getImage() != null && data.getImage().startsWith("z-icon")) {
				cell.setImage(null);
				cell.setIconSclass(data.getImage());
			}
			
			// Highlight search text
			if (!Util.isEmpty(highlightText, true) && data.getLabel().toLowerCase().contains(highlightText.toLowerCase())) {
				// Space to maintain proper gap between icon and label
				cell.setLabel(" ");
				String label = data.getLabel();
				String matchString = highlightText.toLowerCase();
				int match = label.toLowerCase().indexOf(matchString);
    			while (match >= 0) {
    				if (match > 0) {
    					cell.appendChild(new Label(label.substring(0, match)));
    					Label l = new Label(label.substring(match, match+matchString.length()));
    					LayoutUtils.addSclass("highlight", l);
    					cell.appendChild(l);
    					label = label.substring(match+matchString.length());
    				} else {
    					Label l = new Label(label.substring(0, matchString.length()));
    					LayoutUtils.addSclass("highlight", l);
    					cell.appendChild(l);
    					label = label.substring(matchString.length());
    				}
    				match = label.toLowerCase().indexOf(matchString);
    			}
    			if (label.length() > 0)
    				cell.appendChild(new Label(label));
			}
			
			item.appendChild(cell);
			cell.setTooltiptext(data.getDescription());
			item.setValue(data);
			item.addEventListener(Events.ON_CLICK, MenuSearchController.this);
			
			cell = new Listcell();
			cell.setSclass("menu-search-list-toolbar-cell");
			item.appendChild(cell);
			boolean isWindow = data.getType() != null && data.getType().equals("window");
			if (isWindow) {
				ToolBarButton newBtn = new ToolBarButton();
				if (ThemeManager.isUseFontIconForImage())
					newBtn.setIconSclass("z-icon-New");
				else
					newBtn.setImage(ThemeManager.getThemeResource("images/New16.png"));
				newBtn.addEventListener(Events.ON_CLICK, MenuSearchController.this);
				newBtn.setSclass("fav-new-btn");
				newBtn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), NEW_BUTTON_NAME)));
				newBtn.setName(NEW_BUTTON_NAME);
				cell.appendChild(newBtn);
			}
		
			cell = new Listcell();
			cell.setSclass("menu-search-list-toolbar-cell");
			item.appendChild(cell);
			MTreeNode node = null;
			if (data.getData() instanceof MTreeNode) {
				node = (MTreeNode) data.getData();
			} else if (data.getData() instanceof Treeitem) {
				Treeitem value = (Treeitem) data.getData();
				if (value != null) {
					node = (MTreeNode) value.getAttribute(M_TREE_NODE_ATTR);
				}
			}
			if (node != null) {
				FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getSession());
				ToolBarButton starBtn = new ToolBarButton();
				starBtn.setAttribute(M_TREE_NODE_ATTR, node);
				starBtn.setName(STAR_BUTTON_NAME);
				if (controller.hasNode(node.getNode_ID())) {
					starBtn.setIconSclass(Z_ICON_STAR);
					starBtn.setTooltiptext(Msg.getMsg(Env.getCtx(), REMOVE_FROM_FAVOURITES_MSG));
				} else {
					starBtn.setIconSclass(Z_ICON_STAR_O);
					starBtn.setTooltiptext(Msg.getMsg(Env.getCtx(), ADD_TO_FAVOURITES_MSG));
				}
				cell.appendChild(starBtn);
				starBtn.addEventListener(Events.ON_CLICK, MenuSearchController.this);
				starBtn.setSclass("fav-new-btn");
			}			
		}			
	}	
}
