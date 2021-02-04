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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MMenu;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MTreeFavorite;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.South;

/**
 * Favorite node login to open menu and its sequence configuration dialog
 * 
 * @author Logilite Technologies
 */
public class LoginOpenSequenceDialog extends Window
{
	/**
	 * 
	 */
	private static final long		serialVersionUID	= -6200912526954948898L;

	/** Logger */
	protected static final CLogger	log					= CLogger.getCLogger(LoginOpenSequenceDialog.class);

	private Button					bAdd				= ButtonFactory.createNamedButton("Next", false, true);
	private Button					bRemove				= ButtonFactory.createNamedButton("Previous", false, true);
	private Button					bUp					= ButtonFactory.createNamedButton("Parent", false, true);
	private Button					bDown				= ButtonFactory.createNamedButton("Detail", false, true);

	private ConfirmPanel			confirmPanel		= new ConfirmPanel(true, false, true, false, false, false);

	private SimpleListModel			noModel				= new SimpleListModel();
	private SimpleListModel			yesModel			= new SimpleListModel();

	private Listbox					noList				= new Listbox();
	private Listbox					yesList				= new Listbox();

	private Label					noLabel				= new Label();
	private Label					yesLabel			= new Label();

	private ArrayList<Integer>		autoOpenSeqs		= new ArrayList<Integer>();
	private int						m_AD_User_ID;

	/**
	 * Favorite node arrange login open sequence constructor
	 *
	 * @param AD_User_ID
	 */
	public LoginOpenSequenceDialog(int AD_User_ID)
	{
		m_AD_User_ID = AD_User_ID;

		this.setTitle(Msg.translate(Env.getCtx(), "LoginOpenSeqNo"));
		this.setBorder("normal");
		this.setPosition("center");
		this.setShadow(true);
		this.setSizable(true);
		this.setClosable(true);
		this.setMaximizable(true);
		this.setSclass("popup-dialog fav-login-open-seq-dialog");
		this.setStyle("position: relative; margin: none; border: none; padding: none;");
		ZKUpdateUtil.setWindowWidthX(this, 650);
		ZKUpdateUtil.setWindowHeightX(this, 450);

		//
		init();
	} //

	/**
	 * Layout design
	 */
	private void init()
	{
		// Center Part
		Hlayout hlayout = new Hlayout();
		hlayout.appendChild(noList);
		hlayout.appendChild(yesList);
		ZKUpdateUtil.setVflex(hlayout, "1");
		ZKUpdateUtil.setHflex(hlayout, "1");

		Center center = new Center();
		center.setSclass("dialog-content");
		center.appendChild(hlayout);

		// South part
		Panel southPanel = new Panel();
		southPanel.appendChild(confirmPanel);

		South south = new South();
		south.setSclass("dialog-footer");
		south.appendChild(southPanel);

		// Main Layout
		Borderlayout layout = new Borderlayout();
		ZKUpdateUtil.setHflex(layout, "1");
		ZKUpdateUtil.setVflex(layout, "1");
		layout.appendChild(center);
		layout.appendChild(south);
		this.appendChild(layout);

		// Yes or No list items
		yesModel.setMultiple(true);
		noModel.setMultiple(true);

		noLabel.setValue(Msg.getMsg(Env.getCtx(), "Available"));
		yesLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected"));

		ZKUpdateUtil.setHflex(noList, "1");
		ZKUpdateUtil.setVflex(noList, true);

		ZKUpdateUtil.setHflex(yesList, "1");
		ZKUpdateUtil.setVflex(yesList, true);

		EventListener<Event> mouseListener = new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception
			{
				if (Events.ON_DOUBLE_CLICK.equals(event.getName()))
				{
					migrateValueAcrossLists(event);
				}
			}
		};
		yesList.addDoubleClickListener(mouseListener);
		noList.addDoubleClickListener(mouseListener);

		//
		EventListener<Event> actionListener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception
			{
				migrateValueAcrossLists(event);
			}
		};

		LayoutUtils.addSclass("btn-small", bAdd);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bAdd);
		bAdd.addEventListener(Events.ON_CLICK, actionListener);

		LayoutUtils.addSclass("btn-small", bRemove);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bRemove);
		bRemove.addEventListener(Events.ON_CLICK, actionListener);

		EventListener<Event> crossListMouseListener = new DragListener();
		yesList.addOnDropListener(crossListMouseListener);
		noList.addOnDropListener(crossListMouseListener);

		if (!ClientInfo.isMobile())
		{
			yesList.setItemDraggable(true);
			noList.setItemDraggable(true);
		}

		actionListener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception
			{
				migrateValueWithinYesList(event);
			}
		};

		LayoutUtils.addSclass("btn-small", bUp);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bUp);
		bUp.addEventListener(Events.ON_CLICK, actionListener);

		LayoutUtils.addSclass("btn-small", bDown);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bDown);
		bDown.addEventListener(Events.ON_CLICK, actionListener);

		//
		ListHead listHead = new ListHead();
		listHead.setParent(yesList);

		ListHeader listHeader = new ListHeader();
		listHeader.appendChild(yesLabel);

		Hlayout yesButtonLayout = new Hlayout();
		yesButtonLayout.appendChild(bUp);
		yesButtonLayout.appendChild(bDown);
		yesButtonLayout.setStyle("display: inline-block; float: right;");
		listHeader.appendChild(yesButtonLayout);
		listHeader.setParent(listHead);

		//
		listHead = new ListHead();
		listHead.setParent(noList);

		listHeader = new ListHeader();
		listHeader.appendChild(noLabel);
		listHeader.setSort("auto");
		listHeader.setSortDirection("ascending");
		// http://books.zkoss.org/wiki/ZK%20Configuration%20Reference/zk.xml/The%20Library%20Properties/org.zkoss.zul.listbox.autoSort
		noList.setAttribute("org.zkoss.zul.listbox.autoSort", "true");
		Hlayout noButtonLayout = new Hlayout();
		noButtonLayout.appendChild(bRemove);
		noButtonLayout.appendChild(bAdd);
		noButtonLayout.setStyle("display: inline-block; float: right;");
		listHeader.appendChild(noButtonLayout);
		listHeader.setParent(listHead);

		// Confirm Panel listener
		EventListener<Event> onClickListener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception
			{
				if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_OK)))
				{
					saveData();
				}
				else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_CANCEL)))
				{
					detach();
				}
				else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_RESET)))
				{
					loadData();
				}
			}
		};

		confirmPanel.addActionListener(onClickListener);
	} // init

	/**
	 * Load data into model
	 */
	public void loadData()
	{
		autoOpenSeqs.clear();
		yesModel.removeAllElements();
		noModel.removeAllElements();

		int favTreeID = MTreeFavorite.getFavoriteTreeID(m_AD_User_ID);
		MRole role = MRole.get(Env.getCtx(), Env.getAD_Role_ID(Env.getCtx()));

		// get login open seq no nodes
		Query query = new Query(Env.getCtx(), MTreeFavoriteNode.Table_Name, "AD_Tree_Favorite_ID=? AND AD_Menu_ID>0 AND LoginOpenSeqNo>=0", null);
		query.setOrderBy(MTreeFavoriteNode.COLUMNNAME_LoginOpenSeqNo);
		query.setOnlyActiveRecords(true);
		query.setParameters(new Object[] { favTreeID });

		for (int favNodeID : query.getIDs())
		{
			autoOpenSeqs.add(favNodeID);
		}

		// get all menu nodes
		query = new Query(Env.getCtx(), MTreeFavoriteNode.Table_Name, "AD_Tree_Favorite_ID=? AND AD_Menu_ID>0 ", null);
		query.setOrderBy(MTreeFavoriteNode.COLUMNNAME_LoginOpenSeqNo);
		query.setOnlyActiveRecords(true);
		query.setParameters(new Object[] { favTreeID });
		List<MTreeFavoriteNode> lsFavNode = null;
		try {
			PO.setCrossTenantSafe();
			lsFavNode = query.list();
		}finally {
			PO.clearCrossTenantSafe();
		}

		try
		{
			HashMap<Integer, ListElement> currSel = new HashMap<Integer, LoginOpenSequenceDialog.ListElement>();

			for (MTreeFavoriteNode favNode : lsFavNode)
			{
				int key = favNode.getAD_Tree_Favorite_Node_ID();
				MMenu menu = (MMenu) MTable.get(Env.getCtx(), MMenu.Table_ID).getPO(favNode.getAD_Menu_ID(), null);

				Boolean access = MTreeFavorite.getAccessForMenuItem(role, menu);
				if (access != null && access.booleanValue())
				{
					ListElement pp = new ListElement(key, menu.get_Translation(MMenu.COLUMNNAME_Name));
					if (autoOpenSeqs != null && autoOpenSeqs.size() > 0)
					{
						if (autoOpenSeqs.contains(key))
						{
							currSel.put(key, pp);
						}
						else
						{
							noModel.addElement(pp);
						}
					}
					else
					{
						noModel.addElement(pp);
					}
				}
			}

			if (autoOpenSeqs != null)
			{
				for (int key : autoOpenSeqs)
				{
					if (currSel.get(key) != null)
					{
						yesModel.addElement(currSel.get(key));
					}
				}
			}
		}
		catch (DBException e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
		}

		bAdd.setEnabled(true);
		bRemove.setEnabled(true);
		bUp.setEnabled(true);
		bDown.setEnabled(true);
		yesList.setEnabled(true);
		noList.setEnabled(true);

		yesList.setItemRenderer(yesModel);
		yesList.setModel(yesModel);
		noList.setItemRenderer(noModel);
		noList.setModel(noModel);
	} // loadData

	/**
	 * @param event - Event
	 */
	void migrateValueAcrossLists(Event event)
	{
		Object source = event.getTarget();
		if (source instanceof ListItem)
		{
			source = ((ListItem) source).getListbox();
		}
		Listbox listFrom = (source == bAdd || source == noList) ? noList : yesList;
		Listbox listTo = (source == bAdd || source == noList) ? yesList : noList;
		int endIndex = yesList.getIndexOfItem(listTo.getSelectedItem());
		// List to is empty.
		if (endIndex < 0)
			endIndex = 0;

		migrateLists(listFrom, listTo, endIndex);
	} // migrateValueAcrossLists

	/**
	 * @param listFrom
	 * @param listTo
	 * @param endIndex
	 */
	void migrateLists(Listbox listFrom, Listbox listTo, int endIndex)
	{
		int index = 0;
		SimpleListModel lmFrom = (SimpleListModel) listFrom.getModel();
		SimpleListModel lmTo = (SimpleListModel) listTo.getModel();
		Set<?> selectedItems = listFrom.getSelectedItems();
		List<ListElement> selObjects = new ArrayList<ListElement>();
		for (Object obj : selectedItems)
		{
			ListItem listItem = (ListItem) obj;
			index = listFrom.getIndexOfItem(listItem);
			ListElement selObject = (ListElement) lmFrom.getElementAt(index);
			selObjects.add(selObject);
		}
		for (ListElement selObject : selObjects)
		{
			if (selObject == null || !selObject.isUpdateable())
				continue;

			lmFrom.removeElement(selObject);
			lmTo.add(endIndex, selObject);
			endIndex++;
			index = lmTo.indexOf(selObject);
			listTo.setSelectedIndex(index);
		}
	} // migrateLists

	/**
	 * Move within Yes List with Drag Event and Multiple Choice
	 * 
	 * @param event - Event
	 */
	void migrateValueWithinYesList(int endIndex, List<ListElement> selObjects)
	{
		int iniIndex = 0;
		Arrays.sort(selObjects.toArray());
		ListElement endObject = (ListElement) yesModel.getElementAt(endIndex);
		for (ListElement selected : selObjects)
		{
			iniIndex = yesModel.indexOf(selected);
			ListElement selObject = (ListElement) yesModel.getElementAt(iniIndex);
			yesModel.removeElement(selObject);
			endIndex = yesModel.indexOf(endObject);
			yesModel.add(endIndex, selObject);
		}
	} // migrateValueWithinYesList

	/**
	 * Move within Yes List
	 * 
	 * @param event - Event
	 */
	void migrateValueWithinYesList(Event event)
	{
		Object[] selObjects = yesList.getSelectedItems().toArray();

		if (selObjects == null)
			return;
		int length = selObjects.length;
		if (length == 0)
			return;
		//
		int[] indices = yesList.getSelectedIndices();
		Arrays.sort(indices);
		//
		boolean change = false;
		//
		Object source = event.getTarget();
		if (source == bUp)
		{
			for (int i = 0; i < length; i++)
			{
				int index = indices[i];
				if (index == 0)
					break;
				ListElement selObject = (ListElement) yesModel.getElementAt(index);
				ListElement newObject = (ListElement) yesModel.getElementAt(index - 1);
				if (!selObject.isUpdateable() || !newObject.isUpdateable())
					break;
				yesModel.setElementAt(newObject, index);
				yesModel.setElementAt(selObject, index - 1);
				indices[i] = index - 1;
				change = true;
			}
		} // up
		else if (source == bDown)
		{
			for (int i = length - 1; i >= 0; i--)
			{
				int index = indices[i];
				if (index >= yesModel.getSize() - 1)
					break;
				ListElement selObject = (ListElement) yesModel.getElementAt(index);
				ListElement newObject = (ListElement) yesModel.getElementAt(index + 1);
				if (!selObject.isUpdateable() || !newObject.isUpdateable())
					break;
				yesModel.setElementAt(newObject, index);
				yesModel.setElementAt(selObject, index + 1);
				yesList.setSelectedIndex(index + 1);
				indices[i] = index + 1;
				change = true;
			}
		} // down

		//
		if (change)
		{
			yesList.setSelectedIndices(indices);
			if (yesList.getSelectedItem() != null)
			{
				AuFocus focus = new AuFocus(yesList.getSelectedItem());
				Clients.response(focus);
			}
		}
	} // migrateValueWithinYesList

	/**
	 * Save Login open sequence no
	 */
	public void saveData()
	{
		try
		{
			// For service users, needs to persist data in system tenant
			PO.setCrossTenantSafe();
			// yesList
			for (int i = 0; i < yesModel.getSize(); i++)
			{
				ListElement pp = (ListElement) yesModel.getElementAt(i);
				if (!pp.isUpdateable())
					continue;

				// Set seq no
				MTreeFavoriteNode favNode = (MTreeFavoriteNode) MTable.get(MTreeFavoriteNode.Table_ID).getPO(pp.getKey(), null);
				favNode.setLoginOpenSeqNo(i);
				favNode.saveEx();

			}

			// noList
			for (int i = 0; i < noModel.getSize(); i++)
			{
				ListElement pp = (ListElement) noModel.getElementAt(i);
				if (!pp.isUpdateable())
					continue;

				// remove seq no if exists
				MTreeFavoriteNode favNode = (MTreeFavoriteNode) MTable.get(MTreeFavoriteNode.Table_ID).getPO(pp.getKey(), null);
				favNode.set_ValueNoCheck(MTreeFavoriteNode.COLUMNNAME_LoginOpenSeqNo, null);
				favNode.saveEx();
			}

		}
		finally
		{
			PO.clearCrossTenantSafe();
		}
		//
		detach();
	} // saveData

	/**
	 * List Item
	 */
	private static class ListElement extends NamePair
	{
		/**
		 * 
		 */
		private static final long	serialVersionUID	= -1717531470895073281L;

		private int					m_key;

		private boolean				m_updateable;

		public ListElement(int key, String name)
		{
			super(name);
			this.m_key = key;
			this.m_updateable = true;
		}

		public int getKey()
		{
			return m_key;
		}

		public boolean isUpdateable()
		{
			return m_updateable;
		}

		@Override
		public String getID()
		{
			return m_key != -1 ? String.valueOf(m_key) : null;
		}

		@Override
		public int hashCode()
		{
			return m_key;
		}

		@Override
		public boolean equals(Object obj)
		{
			if (obj instanceof ListElement)
			{
				ListElement li = (ListElement) obj;
				return li.getKey() == m_key
						&& li.getName() != null
						&& li.getName().equals(getName());
			}
			return false;
		} // equals

		@Override
		public String toString()
		{
			String s = super.toString();
			if (s == null || s.trim().length() == 0)
				s = "<" + getKey() + ">";
			return s;
		}
	} // ListElement

	/**
	 * Drag Listener
	 */
	private class DragListener implements EventListener<Event>
	{

		/**
		 * Creates a ADSortTab.DragListener.
		 */
		public DragListener()
		{
		}

		@Override
		public void onEvent(Event event) throws Exception
		{
			if (event instanceof DropEvent)
			{
				int endIndex = 0;
				DropEvent me = (DropEvent) event;
				ListItem endItem = (ListItem) me.getTarget();
				ListItem startItem = (ListItem) me.getDragged();

				if (!startItem.isSelected())
					startItem.setSelected(true);

				if (!(startItem.getListbox() == endItem.getListbox()))
				{
					Listbox listFrom = (Listbox) startItem.getListbox();
					Listbox listTo = (Listbox) endItem.getListbox();
					endIndex = yesList.getIndexOfItem(endItem);
					migrateLists(listFrom, listTo, endIndex);
				}
				else if (startItem.getListbox() == endItem.getListbox() && startItem.getListbox() == yesList)
				{
					List<ListElement> selObjects = new ArrayList<ListElement>();
					endIndex = yesList.getIndexOfItem(endItem);
					for (Object obj : yesList.getSelectedItems())
					{
						ListItem listItem = (ListItem) obj;
						int index = yesList.getIndexOfItem(listItem);
						ListElement selObject = (ListElement) yesModel.getElementAt(index);
						selObjects.add(selObject);
					}
					migrateValueWithinYesList(endIndex, selObjects);
					yesList.clearSelection();
				}
			}
		}
	} // DragListener

}
