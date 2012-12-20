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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;

import org.adempiere.model.MTabCustomization;
import org.adempiere.webui.adwindow.GridView;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.GridTab;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.zkoss.zhtml.Span;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.South;
import org.zkoss.zul.Vbox;

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
	private static final long serialVersionUID = -3190425241947591357L;

	private Map<Integer, String> m_columnsWidth;
	ArrayList<Integer> tableSeqs;
	GridView gridPanel = null;
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
		this.setStyle("position : absolute;height: 460px; width:585px; margin: none; border: none;");
	}	//	

	/**	Logger			*/
	static CLogger log = CLogger.getCLogger(CustomizeGridViewPanel.class);
	private int			m_WindowNo;
	private int			m_AD_Tab_ID;
	private int 		m_AD_User_ID;

	//	UI variables
	private Label noLabel = new Label();
	private Label yesLabel = new Label();
	private Button bAdd = new Button();
	private Button bRemove = new Button();
	private Button bUp = new Button();
	private Button bDown = new Button();
	private Checkbox chkSaveWidth = new Checkbox();
	//
	SimpleListModel noModel = new SimpleListModel();
	SimpleListModel yesModel = new SimpleListModel();
	Listbox noList = new Listbox();
	Listbox yesList = new Listbox();

	private GridTab gridTab;
	private boolean uiCreated;
	private boolean m_saved = false;

	
	/**
	 * 	Static Layout
	 * 	@throws Exception
	 */
	private void init() throws Exception
	{
		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; width: 584px; height: 100%; border: none; margin: none;");
		Panel centerPanel = new Panel();
		centerPanel.setStyle("border: none; margin: none");
		centerPanel.setHeight("100%");
		Center center = new Center();
		center.setStyle("border: none; margin: none");

		noLabel.setValue("No");
		yesLabel.setValue("Yes");
		noLabel.setValue(Msg.getMsg(Env.getCtx(), "Available"));
		yesLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected"));

		yesList.setVflex(true);
		noList.setVflex(true);

		EventListener<Event> mouseListener = new EventListener<Event>()
		{

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
			public void onEvent(Event event) throws Exception {
				migrateValueAcrossLists(event);
			}
		};
		yesModel.setMultiple(true);
		noModel.setMultiple(true);
		
		bAdd.setImage("images/Next24.png");
		bAdd.addEventListener(Events.ON_CLICK, actionListener);

		bRemove.setImage("images/Previous24.png");
		bRemove.addEventListener(Events.ON_CLICK, actionListener);

		EventListener<Event> crossListMouseListener = new DragListener();
		yesList.addOnDropListener(crossListMouseListener);
		noList.addOnDropListener(crossListMouseListener);
		yesList.setItemDraggable(true);
		noList.setItemDraggable(true);

		actionListener = new EventListener<Event>()
		{
			public void onEvent(Event event) throws Exception {
				migrateValueWithinYesList(event);
			}
		};

		bUp.setImage("images/Parent24.png");
		bUp.addEventListener(Events.ON_CLICK, actionListener);

		bDown.setImage("images/Detail24.png");
		bDown.addEventListener(Events.ON_CLICK, actionListener);
		
		ListHead listHead = new ListHead();
		listHead.setParent(yesList);
		ListHeader listHeader = new ListHeader();
		listHeader.appendChild(yesLabel);
		listHeader.setParent(listHead);

		listHead = new ListHead();
		listHead.setParent(noList);
		listHeader = new ListHeader();
		listHeader.appendChild(noLabel);
		listHeader.setParent(listHead);

		Span span = new Span();
		span.setParent(centerPanel);
		span.setStyle("height: 90%; display: inline-block; width: 250px; border:none; margin: none;");
		span.appendChild(noList);
		Vbox vbox = new Vbox();
		vbox.setStyle("border: none; margin: none;");
		vbox.appendChild(bAdd);
		vbox.appendChild(bRemove);
		span = new Span();
		span.setParent(centerPanel);
		span.setStyle("height: 90%; display: inline-block; width: 40px; border:none; margin: none;");
		span.appendChild(vbox);

		span = new Span();
		span.setParent(centerPanel);
		span.setStyle("height: 90%; display: inline-block; width: 250px; border:none; margin: none;");
		span.appendChild(yesList);
		yesList.setStyle("margin: none");
		vbox = new Vbox();
		vbox.appendChild(bUp);
		vbox.appendChild(bDown);
		vbox.setStyle("border: none; margin: none");
		span = new Span();
		span.setParent(centerPanel);
		span.setStyle("height: 90%; display: inline-block; width: 40px; border:none; margin: none;");
		span.appendChild(vbox);
		
		Div div = new Div();
		div.setStyle("margin-top:5px");
		div.appendChild(chkSaveWidth);
		chkSaveWidth.setLabel("Save Column Width");
		centerPanel.appendChild(div);
		
		center.appendChild(centerPanel);
		centerPanel.setVflex("1");
		centerPanel.setHflex("1");
		layout.appendChild(center);
		
		South south = new South();
		south.setStyle("border: none; margin: none");
		Panel southPanel = new Panel();
		south.setHeight("35px");
		south.setStyle("text-align: right;");
		southPanel.setStyle("margin-top: 2px; margin-right: 4px");
		@SuppressWarnings("unused")
		String label = Msg.getMsg(Env.getCtx(), "save");
		Button bOK = new Button();
		bOK.setImage("/images/Ok16.png");
		bOK.setId("Ok");
		EventListener<Event> onClickListener = new EventListener<Event>()
		{

			public void onEvent(Event event) throws Exception
			{
				if (Events.ON_CLICK.equals(event.getName()))
				{
					saveData();
				}
			}
		
		};		
		bOK.addActionListener(onClickListener);
		bOK.setSclass("action-button");
		southPanel.appendChild(bOK);
		label = Msg.getMsg(Env.getCtx(), "Cancel");
		Button btn = new Button();
		btn.setImage("/images/Cancel16.png");
		btn.setId("Cancel");
		EventListener<Event> onClickCancelListener = new EventListener<Event>()
		{

			public void onEvent(Event event) throws Exception
			{
				if (Events.ON_CLICK.equals(event.getName()))
				{
					getParent().detach();
				}
			}
		};
		
		btn.addActionListener(onClickCancelListener);
		btn.setSclass("action-button");
		
		southPanel.appendChild(btn);
		south.appendChild(southPanel);
		layout.appendChild(south);

		this.appendChild(layout);
		
	}	//	Init
	
	
	/* (non-Javadoc)
	 * @see org.compiere.grid.APanelTab#loadData()
	 */
	public void loadData()
	{
		yesModel.removeAllElements();
		noModel.removeAllElements();		
	
		String sql = "SELECT t.AD_Field_ID,t.Name,t.SeqNoGrid,AD_Client_ID, AD_Org_ID FROM AD_Field t WHERE t.AD_Tab_ID=? AND t.IsDisplayedGrid ='Y' ORDER BY 3,2";
		PreparedStatement  pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_AD_Tab_ID);
			rs = pstmt.executeQuery();

			HashMap<Integer, ListElement> curTabSel = new HashMap<Integer, CustomizeGridViewPanel.ListElement>();
			while (rs.next())
			{
				int key = rs.getInt(1);
				String name = rs.getString(2);
				int AD_Client_ID = rs.getInt(4);
				int AD_Org_ID = rs.getInt(5);
				ListElement pp = new ListElement(key, name, AD_Client_ID, AD_Org_ID);
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
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
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

	


	/** (non-Javadoc)
	 * @see org.compiere.grid.APanelTab#saveData()
	 */
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
			//index += 10;
			
			custom.append(pp.getKey());
			custom.append(",");			
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
		
		MTabCustomization uc = MTabCustomization.get(Env.getCtx(), m_AD_User_ID, m_AD_Tab_ID, null);
		if (uc != null && uc.getAD_Tab_Customization_ID() > 0) {
			uc.setCustom(custom.toString());	
		} else{
			uc = new MTabCustomization(Env.getCtx(), 0, null);
			uc.setAD_Tab_ID(m_AD_Tab_ID);
			uc.setAD_User_ID(m_AD_User_ID);
			uc.setCustom(custom.toString());			
		}
		if (uc.getCustom() == null || uc.getCustom().trim().length() == 0)
		{
			if (uc.is_new())
			{
				//no action needed
				getParent().detach();
				return;
			}
			else
			{
				ok = uc.delete(true);
			}
		}
		else
		{
			ok = uc.save();
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
		private static final long serialVersionUID = -5645910649588308798L;
		private int		m_key;
		private int		m_AD_Client_ID;
		private int		m_AD_Org_ID;
		/** Initial selection flag */

		private boolean	m_updateable;

		public ListElement(int key, String name, int AD_Client_ID, int AD_Org_ID) {
			super(name);
			this.m_key = key;
			this.m_AD_Client_ID = AD_Client_ID;
			this.m_AD_Org_ID = AD_Org_ID;
			this.m_updateable = true;
		}
		
		public int getKey() {
			return m_key;
		}
		
		public int getAD_Client_ID() {
			return m_AD_Client_ID;
		}
		
		public int getAD_Org_ID() {
			return m_AD_Org_ID;
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
					&& li.getName().equals(getName())
					&& li.getAD_Client_ID() == m_AD_Client_ID
					&& li.getAD_Org_ID() == m_AD_Org_ID;
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

	public void dynamicDisplay(int i) {
	}

	public void editRecord(boolean b) {
	}

	public String getDisplayLogic() {
		return gridTab.getDisplayLogic();
	}

	public GridTab getGridTab() {
		return gridTab;
	}

	public int getTabLevel() {
		return gridTab.getTabLevel();
	}

	public String getTitle() {
		return gridTab.getName();
	}

	public boolean isCurrent() {
		return gridTab != null ? gridTab.isCurrent() : false;
	}

	public void query() {
		loadData();
	}

	public void query(boolean currentRows, int currentDays, int i) {
		loadData();
	}

	public void refresh() {
		loadData();
	}

	public void switchRowPresentation() {
	}

	public String get_ValueAsString(String variableName) {
		return Env.getContext(Env.getCtx(), m_WindowNo, variableName);
	}

	public void afterSave(boolean onSaveEvent) {
	}

	public boolean onEnterKey() {
		return false;
	}
	
	public boolean isSaved() {
		return m_saved;
	}
	public void setGridPanel(GridView gridPanel){
		this.gridPanel = gridPanel;
	}
}	//ADSortTab

