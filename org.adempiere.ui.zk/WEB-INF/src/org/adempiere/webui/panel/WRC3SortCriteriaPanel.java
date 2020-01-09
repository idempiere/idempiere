/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Trek Global                                             *
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

package org.adempiere.webui.panel;

import static org.compiere.model.SystemIDs.REFERENCE_SQLORDERBY;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Set;

import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MRefList;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.Vbox;

public class WRC3SortCriteriaPanel extends WRCTabPanel implements  EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6470498382547293013L;
	//	UI variables
	private Label noLabel = new Label();
	private Label yesLabel = new Label();
	private Button bAdd = new Button();
	private Button bRemove = new Button();
	private Button bUp = new Button();
	private Button bDown = new Button();
	//
	SimpleListModel noModel = new SimpleListModel();
	SimpleListModel yesModel = new SimpleListModel();
	Listbox noList = new Listbox();
	Listbox yesList = new Listbox();
	ArrayList<MPrintFormatItem> yesItems =new ArrayList<MPrintFormatItem>();
	ArrayList<MPrintFormatItem> noItems =new ArrayList<MPrintFormatItem>();
	private final String asc_desc = "asc_desc";

	public WRC3SortCriteriaPanel() {
		super();
	}

	public void init()
	{
		//
		noLabel.setValue(Msg.getMsg(Env.getCtx(), "Available"));
		yesLabel.setValue(Msg.getMsg(Env.getCtx(), "OrderBy"));

		ZKUpdateUtil.setVflex(yesList, true);
		ZKUpdateUtil.setVflex(noList, true);

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

		yesList.addEventListener(Events.ON_RIGHT_CLICK, this);

		yesList.setSeltype("multiple");
		noList.setSeltype("multiple");

		bAdd.setImage(ThemeManager.getThemeResource("images/Next24.png"));
		bAdd.addEventListener(Events.ON_CLICK, actionListener);

		bRemove.setImage(ThemeManager.getThemeResource("images/Previous24.png"));
		bRemove.addEventListener(Events.ON_CLICK, actionListener);

		EventListener<Event> crossListMouseListener = new DragListener();
		yesList.addOnDropListener(crossListMouseListener);
		noList.addOnDropListener(crossListMouseListener);
		yesList.setItemDraggable(true);
		noList.setItemDraggable(true);
		
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

		Hlayout hlayout = new Hlayout();
		ZKUpdateUtil.setVflex(hlayout, "true");
		ZKUpdateUtil.setHflex(hlayout, "true");
		hlayout.setStyle("width:80%;height:80%;border:none;margin:none;padding:none");
		ZKUpdateUtil.setHflex(noList, "1");
		ZKUpdateUtil.setVflex(noList, true);
		hlayout.appendChild(noList);
		Vbox vbox = new Vbox();
		vbox.appendChild(bAdd);
		vbox.appendChild(bRemove);
		ZKUpdateUtil.setWidth(vbox, "50px");
		hlayout.appendChild(vbox);

		ZKUpdateUtil.setVflex(yesList, true);
		ZKUpdateUtil.setHflex(yesList, "1");
		hlayout.appendChild(yesList);
		
		
		EventListener<Event> actionListener2 = new EventListener<Event>()
		{
			public void onEvent(Event event) throws Exception {
				migrateValueWithinYesList(event);
			}
		};
		
		bUp.setImage(ThemeManager.getThemeResource("images/Parent24.png"));
		bUp.addEventListener(Events.ON_CLICK, actionListener2);

		bDown.setImage(ThemeManager.getThemeResource("images/Detail24.png"));
		bDown.addEventListener(Events.ON_CLICK, actionListener2);
		
		vbox = new Vbox();
		vbox.appendChild(bUp);
		vbox.appendChild(bDown);
		ZKUpdateUtil.setWidth(vbox, "46px");
		hlayout.appendChild(vbox);
		
		this.appendChild(hlayout);
	}

	@Override
	public void onEvent(Event event) throws Exception {

		if (event.getTarget() == yesList) {
			if (yesList.getSelectedItems().size() > 1) // Only one item
				return;

			Menupopup m_popup = new Menupopup();
			Menuitem menuItem = new Menuitem(yesItems.get(yesList.getSelectedIndex()).isDesc() ? (getOrderByDesc() + " -> " + getOrderByAsc()) : (getOrderByAsc() + " -> " + getOrderByDesc()));
			menuItem.setValue(asc_desc);
			menuItem.addEventListener(Events.ON_CLICK, this);
			m_popup.appendChild(menuItem);
			m_popup.setPage(yesList.getPage());
			m_popup.open(yesList);
		}
		else if (event.getTarget() instanceof Menuitem) {
			Menuitem menuItem = (Menuitem) event.getTarget();
			if (!Util.isEmpty(menuItem.getValue()) && menuItem.getValue().equals(asc_desc)) {
				MPrintFormatItem pfi = yesItems.get(yesList.getSelectedIndex());
				pfi.setIsDesc(!pfi.isDesc());
				pfi.saveEx();
				refresh();
			}
		}
	}
	
	public void setListsColumns() {
		yesItems =new ArrayList<MPrintFormatItem>();
		noItems =new ArrayList<MPrintFormatItem>();
		for(int i=0 ; i< m_pfi.size();i++){
		    MPrintFormatItem item  = m_pfi.get(i);
		    if(item!=null){
		    	if(item.isOrderBy()){
		    		yesItems.add(item);
		    	}else{
		    		noItems.add(item);
		    	}
		    }	
		}
		Collections.sort(yesItems, new Comparator<MPrintFormatItem>() {
			@Override
			public int compare(MPrintFormatItem o1, MPrintFormatItem o2) {
				return o1.getSortNo()-o2.getSortNo();
			}
		});
	}
	
	@Override
	public void refresh() {		
		
		this.setListsColumns();
		yesList.removeAllItems();
		noList.removeAllItems();

		if (yesItems.size() > 0 && yesItems != null) {
			yesModel.removeAllElements();
			for (int i=0 ; i < yesItems.size() ; i++) {				 
				 int ID= yesItems.get(i).get_ID();
				 String name = yesItems.get(i).getPrintName(Language.getLoginLanguage())==null? yesItems.get(i).getName():yesItems.get(i).getPrintName(Language.getLoginLanguage());
				 yesList.addItem(new KeyNamePair(ID, name));
				 yesModel.addElement(new ListElement(ID, name, yesItems.get(i).getSortNo(), true, yesItems.get(i).getAD_Client_ID(), yesItems.get(i).getAD_Org_ID()));	
			}
		}
		
		if (noItems.size() > 0 && noItems != null) {
			noModel.removeAllElements();
			for (int i=0 ; i < noItems.size() ; i++) {
				 int ID= noItems.get(i).get_ID();
				 String name = noItems.get(i).getPrintName(Language.getLoginLanguage())== null ? noItems.get(i).getName() : noItems.get(i).getPrintName(Language.getLoginLanguage());
				 noItems.get(i).setSortNo(0);
				 noItems.get(i).setIsOrderBy(false);
				 noList.addItem(new KeyNamePair(ID, name));
				 noModel.add(i,new ListElement(ID, name, noItems.get(i).getSortNo(), false, noItems.get(i).getAD_Client_ID(), noItems.get(i).getAD_Org_ID()));
			}
		}
	}

	String getName(MPrintFormatItem pfi) {
		StringBuilder name = new StringBuilder(Util.isEmpty(pfi.getPrintName()) ? pfi.getName() : pfi.getPrintName())
		.append(" (").append(pfi.isDesc() ? getOrderByDesc() : getOrderByAsc()).append(")");
		return name.toString();
	}

	String getOrderByAsc() {
		return MRefList.getListName(Env.getCtx(), REFERENCE_SQLORDERBY, "A");
	}

	String getOrderByDesc() {
		return MRefList.getListName(Env.getCtx(), REFERENCE_SQLORDERBY, "D");
	}

	@Override
	public void updatePFI() {
		// pfi is being updated on every refresh
	}

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
	}	//	migrateValueAcrossLists
	
	void migrateLists (Listbox listFrom , Listbox listTo , int endIndex)
	{
		int index = 0; 
		SimpleListModel lmFrom = (listFrom == yesList) ? yesModel:noModel;
		SimpleListModel lmTo = (lmFrom == yesModel) ? noModel:yesModel;
		Set<?> selectedItems = listFrom.getSelectedItems();
		List<ListElement> selObjects = new ArrayList<ListElement>();
		for (Object obj : selectedItems) {
			ListItem listItem = (ListItem) obj;
			index = listFrom.getIndexOfItem(listItem);			
			ListElement selObject = (ListElement)lmFrom.getElementAt(index);
			selObjects.add(selObject);
		}
		index = 0;
	    boolean reOrder = false; 
		Arrays.sort(selObjects.toArray());	
		for (ListElement selObject : selObjects)
		{
			if (selObject == null)
				continue;

			lmFrom.removeElement(selObject);
			lmTo.add(endIndex, selObject);
			index = m_pfi.indexOf(getPrintFormatItem(selObject.m_key));
			if(listFrom.equals(noList)) {
			  m_pfi.get(index).setIsOrderBy(true);
			  reOrder =true;
			}else{
			  m_pfi.get(index).setIsOrderBy(false);
			}
		}
		if(reOrder){
			int sortNo =10;
			ArrayList<ListElement> pp = new ArrayList<ListElement>();
			for(int i=0 ; i<lmTo.getSize(); i++) { 	
				ListElement aux = (ListElement)lmTo.getElementAt(i);
				aux.setSortNo(sortNo);
				sortNo =+10;
				pp.add(aux);
			}
			Collections.sort(pp, new Comparator<ListElement>() {
				@Override
				public int compare(ListElement o1, ListElement o2) {
					return o1.getSortNo()-o2.getSortNo();
				}
			});
			for(ListElement ele : pp) { 	
				int auxIndex = m_pfi.indexOf(getPrintFormatItem(ele.m_key));
				m_pfi.get(auxIndex).setSortNo(sortNo);
				sortNo = sortNo + 10;
			}
		  wc.setIsChanged(true);
		}
		refresh();
		if ( listTo.getSelectedItem() != null)
		{
			AuFocus focus = new AuFocus(listTo.getSelectedItem());
			Clients.response(focus);
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
		ListElement selObject= null;
		ListElement endObject = (ListElement)yesModel.getElementAt(endIndex);
		for (ListElement selected : selObjects) {
   		    iniIndex = yesModel.indexOf(selected);
			selObject = (ListElement)yesModel.getElementAt(iniIndex);
			yesModel.removeElement(selObject);
			endIndex = yesModel.indexOf(endObject);
			yesModel.add(endIndex, selObject);			
		}	
		int sortNo = 10;
	    int auxIndex =0;
		yesList.removeAllItems();
	    for(int i=0 ; i<yesModel.getSize(); i++) { 	
			ListElement pp = (ListElement)yesModel.getElementAt(i);
			auxIndex = m_pfi.indexOf(getPrintFormatItem(pp.m_key));
			m_pfi.get(auxIndex).setSortNo(sortNo);
			yesList.addItem(new KeyNamePair(pp.m_key, pp.getName()));
			sortNo = sortNo + 10;
		}
	}
	
	/**
	 * 	Move within Yes List
	 *	@param event event
	 */
	private void migrateValueWithinYesList (Event event)
	{
		Object[] selObjects = yesList.getSelectedItems().toArray();
		if (selObjects == null)
			return;
		int length = selObjects.length;
		if (length == 0)
			return;
		//
		int[] indices = yesList.getSelectedIndices();
		//
		boolean change = false;
        int selectedPI = 0 , targetPI = 0;	
		MPrintFormatItem orig = null;
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
				yesList.setSelectedIndex(index - 1);
				
				selectedPI = m_pfi.indexOf(getPrintFormatItem(selObject.m_key));
				  targetPI = m_pfi.indexOf(getPrintFormatItem(newObject.m_key));
				updateSortNo (selectedPI,targetPI);
				
				yesItems.get(index).setSortNo(yesItems.get(index).getSortNo());
				orig = yesItems.get(index);
				yesItems.get(index - 1).setSeqNo(yesItems.get(index - 1).getSeqNo()+10);
				yesItems.set(index, yesItems.get(index-1));
				yesItems.set(index-1 , orig);
		
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
				
				selectedPI = m_pfi.indexOf(getPrintFormatItem(selObject.m_key));
				  targetPI = m_pfi.indexOf(getPrintFormatItem(newObject.m_key));
				updateSortNo (selectedPI,targetPI);
				
				yesItems.get(index).setSeqNo(yesItems.get(index).getSeqNo()+10);
				orig = m_pfi.get(index);
				yesItems.get(index + 1).setSeqNo(yesItems.get(index + 1).getSeqNo()-10);
				yesItems.set(index, yesItems.get(index+1));
				yesItems.set(index+1,orig);
				
				indices[i] = index + 1;
				change = true;
			}
		}	//	down

		//
		if (change) {	
			yesList.removeAllItems();
			for(int i=0 ; i<yesModel.getSize(); i++) { 
				ListElement pp = (ListElement)yesModel.getElementAt(i);
				yesList.addItem(new KeyNamePair(pp.m_key, pp.getName()));
			}
			yesList.setSelectedIndices(indices);
			wc.setIsChanged(true);
			if ( yesList.getSelectedItem() != null)
			{
				AuFocus focus = new AuFocus(yesList.getSelectedItem());
				Clients.response(focus);
			}
		}
	}	//	migrateValueWithinYesList
	
	
   /**	
	*	@param int selIndexPI,int targetIndexPI
	*/
	private void updateSortNo(int selIndexPI,int targetIndexPI)
	{
		int selSortNo = m_pfi.get(selIndexPI).getSortNo();
		m_pfi.get(selIndexPI).setSortNo(m_pfi.get(targetIndexPI).getSortNo());		
		m_pfi.get(targetIndexPI).setSortNo(selSortNo);	
	}

	/**
	 * List Item
	 */
	public static class ListElement extends NamePair {
		/**
		 *
		 */
		private static final long serialVersionUID = -5645910649588308798L;
		private int		m_key;
		private int		m_AD_Client_ID;
		private int		m_AD_Org_ID;
		/** Initial seq number */
		private int		m_sortNo;
		/** Initial selection flag */
		private boolean m_isYes;


		public ListElement(int key, String name, int sortNo, boolean isYes, int AD_Client_ID, int AD_Org_ID) {
			super(name);
			this.m_key = key;
			this.m_AD_Client_ID = AD_Client_ID;
			this.m_AD_Org_ID = AD_Org_ID;
			this.m_sortNo = sortNo;
			this.m_isYes = isYes;

		}
		public int getKey() {
			return m_key;
		}
		public void setSortNo(int sortNo) {
			m_sortNo = sortNo;
		}
		public int getSortNo() {
			return m_sortNo;
		}
		public void setIsYes(boolean value) {
			m_isYes = value;
		}
		public boolean isYes() {
			return m_isYes;
		}
		public int getAD_Client_ID() {
			return m_AD_Client_ID;
		}
		public int getAD_Org_ID() {
			return m_AD_Org_ID;
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
				}
		 }
	   }
	 }
	
}
