/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                        *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.webui.panel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.adempiere.model.MTabCustomization;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.GridView;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.I_AD_Field;
import org.compiere.model.MField;
import org.compiere.model.MRefList;
import org.compiere.model.MRole;
import org.compiere.model.MTab;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Tab_Customization;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;

/**
 * 
 * @author hengsin
 *
 */
public class CustomizeGridViewPanel extends Panel
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6300916636341781651L;

	private Map<Integer, String> m_columnsWidth;
	ArrayList<Integer> tableSeqs;
	GridView gridPanel = null;
	MTabCustomization m_tabcust;

	/**
	 *	Sort Tab Constructor
	 *
	 *  @param WindowNo Window No
	 * @param columnsWidth 
	 *  @param GridTab
	 */
	public CustomizeGridViewPanel(int WindowNo, int AD_Tab_ID, int AD_User_ID, Map<Integer, String> columnsWidth,ArrayList<Integer> gridFieldIds)
	{
		m_WindowNo = WindowNo;

		m_AD_Tab_ID = AD_Tab_ID;
		m_AD_User_ID = AD_User_ID;
		m_columnsWidth = columnsWidth;
		tableSeqs = gridFieldIds;
		this.setStyle("position : relative;height: 100%; width:100%; margin: none; border: none; padding: none;");
	}	//	

	/**	Logger			*/
	static CLogger log = CLogger.getCLogger(CustomizeGridViewPanel.class);
	private int			m_WindowNo;
	private int			m_AD_Tab_ID;
	private int 		m_AD_User_ID;

	//	UI variables
	private Label noLabel = new Label();
	private Label yesLabel = new Label();
	private Button bAdd = ButtonFactory.createButton(null,
			ThemeManager.getThemeResource("images/MoveRight16.png"), null);
	private Button bRemove = ButtonFactory.createButton(null,
			ThemeManager.getThemeResource("images/MoveLeft16.png"), null);
	private Button bUp = ButtonFactory.createButton(null,
			ThemeManager.getThemeResource("images/MoveUp16.png"), null);
	private Button bDown = ButtonFactory.createButton(null,
			ThemeManager.getThemeResource("images/MoveDown16.png"), null);
	private Checkbox chkSaveWidth = new Checkbox();
	private Label lblGridMode = new Label();
	private Listbox lstGridMode = new Listbox();

	//
	SimpleListModel noModel = new SimpleListModel();
	SimpleListModel yesModel = new SimpleListModel();
	Listbox noList = new Listbox();
	Listbox yesList = new Listbox();

	private boolean uiCreated;
	private boolean m_saved = false;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	
/**
	 * Static Layout
	 * 
	 * @throws Exception
	 */
	private void init() throws Exception {
		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; width: 100%; height: 100%; border: none; margin: none; padding: none;");
		Center center = new Center();

		noLabel.setValue(Msg.getMsg(Env.getCtx(), "Available"));
		yesLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected"));

		yesList.setVflex(true);
		noList.setVflex(true);
		
		EventListener<Event> mouseListener = new EventListener<Event>()
		{

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
		EventListener<Event> actionListener = new EventListener<Event>()
		{
			@Override
			public void onEvent(Event event) throws Exception {
				migrateValueAcrossLists(event);
			}
		};
		yesModel.setMultiple(true);
		noModel.setMultiple(true);

		LayoutUtils.addSclass("btn-small", bAdd);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bAdd);
		bAdd.addEventListener(Events.ON_CLICK, actionListener);

		LayoutUtils.addSclass("btn-small", bRemove);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bRemove);
		bRemove.addEventListener(Events.ON_CLICK, actionListener);

		EventListener<Event> crossListMouseListener = new DragListener();
		yesList.addOnDropListener(crossListMouseListener);
		noList.addOnDropListener(crossListMouseListener);
		yesList.setItemDraggable(true);
		noList.setItemDraggable(true);

		actionListener = new EventListener<Event>()
		{
			@Override
			public void onEvent(Event event) throws Exception {
				migrateValueWithinYesList(event);
			}
		};

		LayoutUtils.addSclass("btn-small", bUp);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bUp);
		bUp.addEventListener(Events.ON_CLICK, actionListener);

		LayoutUtils.addSclass("btn-small", bDown);
		LayoutUtils.addSclass("btn-sorttab small-img-btn", bDown);
		bDown.addEventListener(Events.ON_CLICK, actionListener);
		
		ListHead listHead = new ListHead();
		listHead.setParent(yesList);
		ListHeader listHeader = new ListHeader();
		listHeader.appendChild(yesLabel);

		Hlayout yesButtonLayout = new Hlayout();

		yesButtonLayout.appendChild(bUp);
		yesButtonLayout.appendChild(bDown);
		listHeader.appendChild(yesButtonLayout);
		yesButtonLayout.setStyle("display: inline-block; float: right;");
		listHeader.setParent(listHead);

		listHead = new ListHead();
		listHead.setParent(noList);
		listHeader = new ListHeader();
		listHeader.appendChild(noLabel);
		listHeader.setSort("auto");
		listHeader.setSortDirection("ascending");
		//http://books.zkoss.org/wiki/ZK%20Configuration%20Reference/zk.xml/The%20Library%20Properties/org.zkoss.zul.listbox.autoSort
		noList.setAttribute("org.zkoss.zul.listbox.autoSort", "true");
		Hlayout noButtonLayout = new Hlayout();

		noButtonLayout.appendChild(bRemove);
		noButtonLayout.appendChild(bAdd);
		listHeader.appendChild(noButtonLayout);
		noButtonLayout.setStyle("display: inline-block; float: right;");
		listHeader.setParent(listHead);

		Hlayout hlayout = new Hlayout();

		hlayout.setVflex("true");
		hlayout.setHflex("true");
		hlayout.setStyle("margin: auto; margin-top: 2px;");

		noList.setHflex("1");
		noList.setVflex(true);
		hlayout.appendChild(noList);

		yesList.setVflex(true);
		yesList.setHflex("1");
		hlayout.appendChild(yesList);

		center.appendChild(hlayout);

		layout.appendChild(center);

		South south = new South();
		south.setStyle("border: none; margin: 0; padding: 0; ");
		Panel southPanel = new Panel();

		Separator sep = new Separator();
		sep.setSpacing("2px");
		southPanel.appendChild(sep);
		
		southPanel.appendChild(chkSaveWidth);
		chkSaveWidth.setLabel(Msg.getMsg(Env.getCtx(), "SaveColumnWidth"));

		sep = new Separator("vertical");
		sep.setSpacing("200px");
		southPanel.appendChild(sep);
		lblGridMode.setValue(Msg.getMsg(Env.getCtx(), "OpenInGridMode"));
		southPanel.appendChild(lblGridMode);
		lstGridMode.setMold("select");
		lstGridMode.setStyle("margin-left: 2px");
		southPanel.appendChild(lstGridMode);
		
		sep = new Separator();
		sep.setSpacing("2px");
		southPanel.appendChild(sep);

		LayoutUtils.addSclass("dialog-footer", confirmPanel);

		EventListener<Event> onClickListener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (event.getTarget().equals(
						confirmPanel.getButton(ConfirmPanel.A_OK))) {
					saveData();
				} else if (event.getTarget().equals(
						confirmPanel.getButton(ConfirmPanel.A_CANCEL))) {
					getParent().detach();
				}
			}

		};

		confirmPanel.addActionListener(onClickListener);
		southPanel.appendChild(confirmPanel);
		south.appendChild(southPanel);
		layout.appendChild(south);

		this.appendChild(layout);
		
	}	//	init
	
	public void loadData()
	{
		m_tabcust = MTabCustomization.get(Env.getCtx(), m_AD_User_ID, m_AD_Tab_ID, null);

		yesModel.removeAllElements();
		noModel.removeAllElements();		
		boolean baseLanguage = Env.isBaseLanguage(Env.getCtx(), "AD_Field");
		Query query = null;
		
		query = new Query(Env.getCtx(), I_AD_Field.Table_Name, "AD_Tab_ID=? AND (IsDisplayed='Y' OR IsDisplayedGrid='Y') AND IsActive='Y'", null);
		query.setOrderBy("SeqNoGrid, Name, SeqNo");
		query.setParameters(new Object [] {m_AD_Tab_ID});
		query.setApplyAccessFilter(true);

		try
		{
			List<MField> lsFieldsOfGrid = query.list();
			HashMap<Integer, ListElement> curTabSel = new HashMap<Integer, CustomizeGridViewPanel.ListElement>();
			MTab tab = new MTab(Env.getCtx(), m_AD_Tab_ID, null);
			
			for (MField field : lsFieldsOfGrid)
			{
				if (!MRole.getDefault(Env.getCtx(), false).isColumnAccess(tab.getAD_Table_ID(), field.getAD_Column_ID(), true))
					continue;
				
				int key = field.get_ID();
				String name = null; 
				if (baseLanguage)
					name = field.getName();
				else
					name = field.get_Translation(I_AD_Field.COLUMNNAME_Name);
					
				ListElement pp = new ListElement(key, name);
				if (tableSeqs != null && tableSeqs.size() > 0 ) {
					if (tableSeqs.contains(key)) {
						curTabSel.put(key, pp);
					} else {
						noModel.addElement(pp);
					}
				} else {
					noModel.addElement(pp);
				}
			}
			if(tableSeqs!=null){
				for(int key:tableSeqs){
					if(curTabSel.get(key)!=null){
						yesModel.addElement(curTabSel.get(key));
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

		ValueNamePair pp = new ValueNamePair(null, null);
		lstGridMode.addItem(pp);
		ValueNamePair[]  list = MRefList.getList(Env.getCtx(), X_AD_Tab_Customization.ISDISPLAYEDGRID_AD_Reference_ID, false);
		for (int i = 0;i < list.length; i++ ) { 
			lstGridMode.addItem(list[i]);
			if (m_tabcust != null && list[i].getValue().equals(m_tabcust.getIsDisplayedGrid()))
				lstGridMode.setSelectedValueNamePair(list[i]);
		}

		if (m_tabcust != null && m_tabcust.getCustom().indexOf("px") > 0)
			chkSaveWidth.setChecked(true);
	}	//	loadData

	/**
	 * @param event
	 */
	void migrateValueAcrossLists (Event event)
	{
		Object source = event.getTarget();
		if (source instanceof ListItem) {
			source = ((ListItem)source).getListbox();
		}
		Listbox listFrom = (source == bAdd || source == noList) ? noList : yesList;
		Listbox listTo =  (source == bAdd || source == noList) ? yesList : noList;
		int endIndex = yesList.getIndexOfItem(listTo.getSelectedItem());	
		//Listto is empty. 
		if (endIndex<0 )
			endIndex=0;
		
		migrateLists (listFrom,listTo,endIndex);	
	}

	void migrateLists (Listbox listFrom , Listbox listTo , int endIndex	)
	{
		int index = 0;
		SimpleListModel lmFrom = (SimpleListModel) listFrom.getModel();
		SimpleListModel lmTo = (SimpleListModel) listTo.getModel();		
		Set<?> selectedItems = listFrom.getSelectedItems();
		List<ListElement> selObjects = new ArrayList<ListElement>();
		for (Object obj : selectedItems) {
			ListItem listItem = (ListItem) obj;
			index = listFrom.getIndexOfItem(listItem);
			ListElement selObject = (ListElement)lmFrom.getElementAt(index);
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
	}
	
	/**
	 * 	Move within Yes List with Drag Event and Multiple Choice
	 *	@param event event
	 */
	void migrateValueWithinYesList (int endIndex, List<ListElement> selObjects)
	{
		int iniIndex =0;
		Arrays.sort(selObjects.toArray());	
		ListElement endObject = (ListElement)yesModel.getElementAt(endIndex);
		for (ListElement selected : selObjects) {
			iniIndex = yesModel.indexOf(selected);
			ListElement selObject = (ListElement)yesModel.getElementAt(iniIndex);
			yesModel.removeElement(selObject);
			endIndex = yesModel.indexOf(endObject);
			yesModel.add(endIndex, selObject);
		}		
	}

	/**
	 * 	Move within Yes List
	 *	@param event event
	 */
	void migrateValueWithinYesList (Event event)
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
			for (int i = 0; i < length; i++) {
				int index = indices[i];
				if (index == 0)
					break;
				ListElement selObject = (ListElement) yesModel.getElementAt(index);
				ListElement newObject = (ListElement)yesModel.getElementAt(index - 1);
				if (!selObject.isUpdateable() || !newObject.isUpdateable())
					break;
				yesModel.setElementAt(newObject, index);
				yesModel.setElementAt(selObject, index - 1);
				indices[i] = index - 1;
				change = true;
			}
		}	//	up

		else if (source == bDown)
		{
			for (int i = length - 1; i >= 0; i--) {
				int index = indices[i];
				if (index  >= yesModel.getSize() - 1)
					break;
				ListElement selObject = (ListElement) yesModel.getElementAt(index);
				ListElement newObject = (ListElement)yesModel.getElementAt(index + 1);
				if (!selObject.isUpdateable() || !newObject.isUpdateable())
					break;
				yesModel.setElementAt(newObject, index);
				yesModel.setElementAt(selObject, index + 1);
				yesList.setSelectedIndex(index + 1);
				indices[i] = index + 1;
				change = true;
			}
		}	//	down

		//
		if (change) {
			yesList.setSelectedIndices(indices);
			if ( yesList.getSelectedItem() != null)
			{
				AuFocus focus = new AuFocus(yesList.getSelectedItem());
				Clients.response(focus);
			}
		}
	}	//	migrateValueWithinYesList

	public void saveData()
	{
		log.fine("");
		//	yesList
		//int index = 0;
		boolean ok = true;
		StringBuilder custom = new StringBuilder(); 
		for (int i = 0; i < yesModel.getSize(); i++)
		{
			ListElement pp = (ListElement)yesModel.getElementAt(i);
			if (!pp.isUpdateable())
				continue;

			if (i > 0)
				custom.append(",");
			custom.append(pp.getKey());
		}
		
		if (chkSaveWidth.isSelected() && m_columnsWidth != null && !m_columnsWidth.isEmpty())
		{			
			for (int i = 0; i < yesModel.getSize(); i++)
			{
				if (i > 0)
					custom.append(",");
				else
					custom.append(";");
				
				ListElement pp = (ListElement)yesModel.getElementAt(i);
				int fieldId = pp.getKey();
				String width = m_columnsWidth.get(fieldId);
				if (width == null) width = "";
				custom.append(width);
			}
		}

		String gridview = null;
		if (lstGridMode.getSelectedItem() != null && lstGridMode.getSelectedItem().toString().length() > 0)
			gridview = lstGridMode.getSelectedItem().toString();
		if (m_tabcust != null && m_tabcust.getAD_Tab_Customization_ID() > 0) {
			m_tabcust.setCustom(custom.toString());	
			m_tabcust.setIsDisplayedGrid(gridview);
		} else {
			m_tabcust = new MTabCustomization(Env.getCtx(), 0, null);
			m_tabcust.setAD_Tab_ID(m_AD_Tab_ID);
			m_tabcust.set_ValueOfColumn("AD_User_ID", m_AD_User_ID);
			m_tabcust.setCustom(custom.toString());
			m_tabcust.setIsDisplayedGrid(gridview);
		}
		if (m_tabcust.getCustom() == null || m_tabcust.getCustom().trim().length() == 0)
		{
			if (m_tabcust.is_new())
			{
				//no action needed
				getParent().detach();
				return;
			}
			else
			{
				ok = m_tabcust.delete(true);
			}
		}
		else
		{
			ok = m_tabcust.save();
		}
		//
		if(ok) {
			m_saved = true;
			// FDialog.info(m_WindowNo, null, "Saved");
			getParent().detach();
			if(gridPanel!=null){
				gridPanel.reInit();
			}
		} else {
			FDialog.error(m_WindowNo, null, "SaveError", custom.toString());
		}
	}	//	saveData

	/**
	 * List Item
	 * @author Teo Sarca
	 */
	private static class ListElement extends NamePair {
		/**
		 * 
		 */
		private static final long serialVersionUID = -1717531470895073281L;

		private int		m_key;

		private boolean	m_updateable;

		public ListElement(int key, String name) {
			super(name);
			this.m_key = key;
			this.m_updateable = true;
		}
		
		public int getKey() {
			return m_key;
		}

		public boolean isUpdateable() {
			return m_updateable;
		}
		
		@Override
		public String getID() {
			return m_key != -1 ? String.valueOf(m_key) : null;
		}
		
		@Override
		public int hashCode() {
			return m_key;
		}
		
		@Override
		public boolean equals(Object obj)
		{
			if (obj instanceof ListElement)
			{
				ListElement li = (ListElement)obj;
				return
					li.getKey() == m_key
					&& li.getName() != null
					&& li.getName().equals(getName());
			}
			return false;
		}	//	equals

		@Override
		public String toString() {
			String s = super.toString();
			if (s == null || s.trim().length() == 0)
				s = "<" + getKey() + ">";
			return s;
		}
	}
		/**
	 * @author eslatis
	 *
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
		public void onEvent(Event event) throws Exception {
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
					Listbox listFrom = (Listbox)startItem.getListbox();
					Listbox listTo =  (Listbox)endItem.getListbox();		
					endIndex = yesList.getIndexOfItem(endItem);
					migrateLists (listFrom,listTo,endIndex);
				}else if (startItem.getListbox() == endItem.getListbox() && startItem.getListbox() == yesList)
				{  
					List<ListElement> selObjects = new ArrayList<ListElement>();
					endIndex = yesList.getIndexOfItem(endItem);	
					for (Object obj : yesList.getSelectedItems()) {
						ListItem listItem = (ListItem) obj;
						int index = yesList.getIndexOfItem(listItem);
						ListElement selObject = (ListElement)yesModel.getElementAt(index);				
						selObjects.add(selObject);						
					}
					migrateValueWithinYesList (endIndex, selObjects);
					yesList.clearSelection();
				}
			}
		}
	}

	public void activate(boolean b) {
		if (b && !uiCreated) createUI();
	}

	public void createUI() {
		if (uiCreated) return;
		try
		{
			init();
		//	dynInit (m_AD_Tab_ID);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		uiCreated = true;
	}

	public void query() {
		loadData();
	}

	public boolean isSaved() {
		return m_saved;
	}

	public void setGridPanel(GridView gridPanel){
		this.gridPanel = gridPanel;
	}

}	//CustomizeGridViewPanel

