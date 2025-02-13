/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.adempiere.webui.panel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
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
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.I_AD_Field;
import org.compiere.model.MField;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUserDefField;
import org.compiere.model.MUserDefTab;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
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
 * Panel to customize grid view for AD_UserDef_Tab
 * @author hengsin
 */
public class CustomizeUserDefTabGridView extends Panel
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 7728908639309012238L;
	protected MUserDefTab userDefTab = null;
	private int m_WindowNo;

	/**
	 * @param AD_UserDef_Tab_ID
	 * @param windowNo 
	 */
	public CustomizeUserDefTabGridView(int AD_UserDef_Tab_ID, int windowNo)
	{
		m_AD_UserDef_Tab_ID = AD_UserDef_Tab_ID;
		m_WindowNo = windowNo;
		this.setStyle("position : relative;height: 100%; width:100%; margin: none; border: none; padding: none;");
	}	//	

	/**	Logger			*/
	protected static final CLogger log = CLogger.getCLogger(CustomizeUserDefTabGridView.class);
	private int	m_AD_UserDef_Tab_ID;

	// UI variables
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

	private SimpleListModel noModel = new SimpleListModel();
	private SimpleListModel yesModel = new SimpleListModel();
	private Listbox noList = new Listbox();
	private Listbox yesList = new Listbox();

	private ConfirmPanel confirmPanel = new ConfirmPanel(true, false, true, false, false, false);
	/* SysConfig USE_ESC_FOR_TAB_CLOSING */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));
	
	/**
	 * Layout panel
	 * 
	 * @throws Exception
	 */
	private void init() throws Exception {
		Borderlayout layout = new Borderlayout();
		layout.setStyle("width: 100%; height: 100%; border: none; margin: none; padding: none;");
		Center center = new Center();

		noLabel.setValue(Msg.getMsg(Env.getCtx(), "Available"));
		yesLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected"));

		ZKUpdateUtil.setVflex(yesList, true);
		ZKUpdateUtil.setVflex(noList, true);
		
		// Double click event
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
		
		// Add and remove item event
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

		// Drag and drop event
		EventListener<Event> crossListMouseListener = new DragListener();
		yesList.addOnDropListener(crossListMouseListener);
		noList.addOnDropListener(crossListMouseListener);
		if (!ClientInfo.isMobile()) 
		{
			yesList.setItemDraggable(true);
			noList.setItemDraggable(true);
		}

		// Move item up and down event
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
		
		// Layout the yes and no listbox
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

		ZKUpdateUtil.setVflex(hlayout, "true");
		ZKUpdateUtil.setHflex(hlayout, "true");
		hlayout.setStyle("margin: auto; margin-top: 2px;");

		ZKUpdateUtil.setHflex(noList, "1");
		ZKUpdateUtil.setVflex(noList, true);
		hlayout.appendChild(noList);

		ZKUpdateUtil.setVflex(yesList, true);
		ZKUpdateUtil.setHflex(yesList, "1");
		hlayout.appendChild(yesList);

		center.appendChild(hlayout);

		layout.appendChild(center);

		South south = new South();
		south.setStyle("border: none; margin: 0; padding: 0; ");
		Panel southPanel = new Panel();

		// Footer confirm panel
		Separator sep = new Separator();
		sep.setSpacing("2px");
		southPanel.appendChild(sep);
		
		LayoutUtils.addSclass("dialog-footer", confirmPanel);

		EventListener<Event> onClickListener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (event.getTarget().equals(
						confirmPanel.getButton(ConfirmPanel.A_OK))) {
					onOk();
				} else if (event.getTarget().equals(
						confirmPanel.getButton(ConfirmPanel.A_CANCEL))) {
					onCancel();
				} else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_RESET))) {
					onReset();
				}
			}			
		};

		confirmPanel.addActionListener(onClickListener);
		southPanel.appendChild(confirmPanel);
		south.appendChild(southPanel);
		layout.appendChild(south);

		this.appendChild(layout);		
	}	//	init
	
	/**
	 * Re-load data
	 */
	public void onReset() {
		loadData();
	}

	/**
	 * Save changes
	 */
	public void onOk() {
		saveData();
	}

	/**
	 * Cancel form
	 */
	public void onCancel() {
		// do not allow to close tab for Events.ON_CTRL_KEY event
		if(isUseEscForTabClosing)
			SessionManager.getAppDesktop().setCloseTabWithShortcut(false);

		getParent().detach();
	}
	
	/**
	 * Load yes/no list
	 */
	public void loadData()
	{
		// AD_UserDef_Tab and fields
		userDefTab = new MUserDefTab(Env.getCtx(), m_AD_UserDef_Tab_ID, null);
		Query ufQuery = new Query(Env.getCtx(), MUserDefField.Table_Name, "AD_UserDef_Tab_ID=?", null);
		List<MUserDefField> userDefFields = ufQuery.setParameters(m_AD_UserDef_Tab_ID).list();
		
		yesModel.removeAllElements();
		noModel.removeAllElements();		
		boolean baseLanguage = Env.isBaseLanguage(Env.getCtx(), "AD_Field");
		
		// Load from AD_Field
		Query query = new Query(Env.getCtx(), I_AD_Field.Table_Name, "AD_Field.AD_Tab_ID=? AND AD_Field.IsActive='Y'", null);
		query.addJoinClause("LEFT JOIN AD_UserDef_Field u ON (AD_Field.AD_Field_ID=u.AD_Field_ID AND u.IsActive='Y' AND u.AD_UserDef_Tab_ID="+m_AD_UserDef_Tab_ID+")");
		query.setOrderBy("CASE WHEN Coalesce(u.SeqNoGrid,0) > 0 THEN u.SeqNoGrid ELSE AD_Field.SeqNoGrid END, Coalesce(u.Name,AD_Field.Name), "
				+ "CASE WHEN Coalesce(u.SeqNo,0) > 0 THEN u.SeqNo ELSE AD_Field.SeqNo END");
		query.setParameters(new Object [] {userDefTab.getAD_Tab_ID()});
		query.setApplyAccessFilter(true);

		try
		{
			List<MField> fields = query.list();
			
			for (MField field : fields)
			{
				Optional<MUserDefField> optional = userDefFields.stream().filter(e -> e.getAD_Field_ID()==field.getAD_Field_ID()).findFirst();
				MUserDefField userDefField = optional.orElse(null);
				
				String name = null; 
				if (baseLanguage)
					name = field.getName();
				else
					name = field.get_Translation(I_AD_Field.COLUMNNAME_Name);
				if (userDefField != null && userDefField.getName() != null)
					name = userDefField.getName();
					
				ListElement pp = new ListElement(field.get_ID(), name, userDefField);
				boolean displayGrid = userDefField != null && userDefField.getIsDisplayedGrid() != null ? "Y".equals(userDefField.getIsDisplayedGrid()) : field.isDisplayedGrid();
				if (displayGrid)
					yesModel.addElement(pp);
				else
					noModel.addElement(pp);
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
	}	//	loadData

	/**
	 * Move item across yes no list
	 * @param event
	 */
	protected void migrateValueAcrossLists (Event event)
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

	/**
	 * Move selected items from listFrom to listTo
	 * @param listFrom
	 * @param listTo
	 * @param endIndex
	 */
	protected void migrateLists (Listbox listFrom , Listbox listTo , int endIndex	)
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
			if (selObject == null)
				continue;

			lmFrom.removeElement(selObject);
			lmTo.add(endIndex, selObject);
			endIndex++;			
			index = lmTo.indexOf(selObject);
			listTo.setSelectedIndex(index);
		}
	}
	
	/**
	 * 	Move selected items within Yes List
	 *  @param endIndex
	 *  @param selObjects
	 */
	protected void migrateValueWithinYesList (int endIndex, List<ListElement> selObjects)
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
	 * 	Move selected items within Yes List
	 *	@param event event
	 */
	protected void migrateValueWithinYesList (Event event)
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

	/**
	 * Save changes
	 */
	public void saveData()
	{
		Trx trx = Trx.get(Trx.createTrxName("saveData"), true);
		try 
		{
			//	yes list
			int prevSeqNo = 0;
			for (int i = 0; i < yesModel.getSize(); i++)
			{
				ListElement pp = (ListElement)yesModel.getElementAt(i);
				MField field = MField.get(pp.getKey());
				MUserDefField userDefField = pp.getUserDefField();
				if (userDefField != null)
				{
					if (!field.isDisplayedGrid())
						userDefField.setIsDisplayedGrid("Y");
					else
						userDefField.setIsDisplayedGrid(null);
					int seqNo = userDefField.getSeqNoGrid() > 0 ? userDefField.getSeqNoGrid() : field.getSeqNoGrid();
					if (seqNo <= prevSeqNo)
					{
						prevSeqNo += 5;
						userDefField.setSeqNoGrid(prevSeqNo);
					}
					else
					{
						if (i < yesModel.getSize()-1) 
						{
							ListElement next = (ListElement)yesModel.getElementAt(i+1);
							MField nextField = MField.get(next.getKey());
							MUserDefField nextUDF = pp.getUserDefField();
							int nextSeqNo = nextUDF != null && nextUDF.getSeqNoGrid() > 0 ? nextUDF.getSeqNoGrid() : nextField.getSeqNoGrid();
							if (seqNo >= nextSeqNo) {
								prevSeqNo += 5;
								userDefField.setSeqNoGrid(prevSeqNo);
							}
						}
					}
					prevSeqNo = userDefField.getSeqNoGrid() > 0 ? userDefField.getSeqNoGrid() : seqNo;
					if (userDefField.is_Changed())
						userDefField.saveEx(trx.getTrxName());
				}
				else
				{				
					if (!field.isDisplayedGrid())
					{
						prevSeqNo += 5;
						newUserDefField(field, prevSeqNo, trx);
					}
					else
					{
						int seqNo = field.getSeqNoGrid();
						if (seqNo <= prevSeqNo)
						{
							prevSeqNo += 5;
							newUserDefField(field, prevSeqNo, trx);
						}
						else
						{
							if (i < yesModel.getSize()-1) 
							{
								ListElement next = (ListElement)yesModel.getElementAt(i+1);
								MField nextField = MField.get(next.getKey());
								MUserDefField nextUDF = pp.getUserDefField();
								int nextSeqNo = nextUDF != null && nextUDF.getSeqNoGrid() > 0 ? nextUDF.getSeqNoGrid() : nextField.getSeqNoGrid();
								if (seqNo >= nextSeqNo) {
									prevSeqNo += 5;
									newUserDefField(field, prevSeqNo, trx);
								} else {
									prevSeqNo = seqNo;
								}
							}
						}
					}
				}
			}
			
			// no list
			for (int i = 0; i < noModel.getSize(); i++)
			{
				ListElement pp = (ListElement)noModel.getElementAt(i);
				MUserDefField userDefField = pp.getUserDefField();
				MField field = MField.get(pp.getKey());
				if (field.isDisplayedGrid()) 
				{
					if (userDefField == null)
					{
						userDefField = new MUserDefField(Env.getCtx(), 0, null);
						userDefField.setAD_UserDef_Tab_ID(m_AD_UserDef_Tab_ID);
						userDefField.setAD_Field_ID(field.getAD_Field_ID());					
					}
					userDefField.setIsDisplayedGrid("N");
					userDefField.setSeqNoGrid(0);
					userDefField.saveEx(trx.getTrxName());
				}
				else if (userDefField != null)
				{
					if ("Y".equals(userDefField.getIsDisplayedGrid()))
					{
						userDefField.setIsDisplayedGrid(null);
						userDefField.setSeqNoGrid(0);
						userDefField.saveEx(trx.getTrxName());
					}
				}
			}
			
			trx.commit(true);
			getParent().detach();
		} catch (Exception e) {
			trx.rollback();
			Dialog.error(m_WindowNo, "SaveError", e.getMessage());
		} finally {
			trx.close();
		}
	}	//	saveData

	/**
	 * Create and save new MUserDefField record
	 * @param field
	 * @param seqNoGrid
	 * @param trx
	 */
	private void newUserDefField(MField field, int seqNoGrid, Trx trx) {
		MUserDefField userDefField;
		userDefField = new MUserDefField(Env.getCtx(), 0, null);
		userDefField.setAD_UserDef_Tab_ID(m_AD_UserDef_Tab_ID);
		userDefField.setAD_Field_ID(field.getAD_Field_ID());							
		userDefField.setSeqNoGrid(seqNoGrid);
		if (!field.isDisplayedGrid())
			userDefField.setIsDisplayedGrid("Y");
		userDefField.saveEx(trx.getTrxName());
	}

	/**
	 * List Item
	 */
	private static class ListElement extends NamePair {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = -689533804854437328L;

		private int		m_AD_Field_ID;

		private MUserDefField userDefField;

		public ListElement(int key, String name, MUserDefField userDefField) {
			super(name);
			this.m_AD_Field_ID = key;
			this.userDefField = userDefField;
		}
		
		public int getKey() {
			return m_AD_Field_ID;
		}

		@Override
		public String getID() {
			return m_AD_Field_ID != -1 ? String.valueOf(m_AD_Field_ID) : null;
		}
		
		@Override
		public int hashCode() {
			return m_AD_Field_ID;
		}
		
		public MUserDefField getUserDefField() {
			return userDefField;
		}
		
		@Override
		public boolean equals(Object obj)
		{
			if (obj instanceof ListElement)
			{
				ListElement li = (ListElement)obj;
				return
					li.getKey() == m_AD_Field_ID
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
	 * Listener for list item drop event
	 */
	private class DragListener implements EventListener<Event>
	{
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

	/**
	 * Layout panel
	 */
	public void createUI() {
		try
		{
			init();
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}
}

