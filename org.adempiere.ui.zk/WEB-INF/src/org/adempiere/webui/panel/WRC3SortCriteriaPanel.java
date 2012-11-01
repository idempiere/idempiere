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

import java.util.ArrayList;
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
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.KeyNamePair;
import org.compiere.util.NamePair;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Vbox;

public class WRC3SortCriteriaPanel extends WRCTabPanel implements  EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2798618953887598651L;

	//	UI variables
	private Label noLabel = new Label();
	private Label yesLabel = new Label();
	private Button bAdd = new Button();
	private Button bRemove = new Button();
	private Button bUp = new Button();
	private Button bDown = new Button();

	public ArrayList<MPrintFormatItem> yesItems=new ArrayList<MPrintFormatItem>();
	public ArrayList<MPrintFormatItem> noItems=new ArrayList<MPrintFormatItem>();

	//
	SimpleListModel noModel = new SimpleListModel();
	SimpleListModel yesModel = new SimpleListModel();
	Listbox noList = new Listbox();
	Listbox yesList = new Listbox();

	public WRC3SortCriteriaPanel() {
		super();
	}

	public void init()
	{
		//
		noLabel.setValue("Available");
		yesLabel.setValue("Order By");

		yesList.setVflex(true);
		noList.setVflex(true);

		EventListener mouseListener = new EventListener()
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
		EventListener actionListener = new EventListener()
		{
			public void onEvent(Event event) throws Exception {
				migrateValueAcrossLists(event);
			}
		};
		yesList.setSeltype("multiple");
		noList.setSeltype("multiple");

		bAdd.setImage("images/Next24.png");
		bAdd.addEventListener(Events.ON_CLICK, actionListener);

		bRemove.setImage("images/Previous24.png");
		bRemove.addEventListener(Events.ON_CLICK, actionListener);

		EventListener crossListMouseListener = new DragListener();
		yesList.addOnDropListener(crossListMouseListener);
		noList.addOnDropListener(crossListMouseListener);
		yesList.setItemDraggable(true);
		noList.setItemDraggable(true);

		EventListener yesListMouseMotionListener = new EventListener()
		{
			public void onEvent(Event event) throws Exception {
				if (event instanceof DropEvent)
				{
					DropEvent me = (DropEvent) event;
					ListItem startItem = (ListItem) me.getDragged();
					ListItem endItem = (ListItem) me.getTarget();
					if (startItem.getListbox() == endItem.getListbox() && startItem.getListbox() == yesList)
					{
						int startIndex = yesList.getIndexOfItem(startItem);
						int endIndex = yesList.getIndexOfItem(endItem);
						ListElement endElement = (ListElement) yesModel.getElementAt(endIndex);
						ListElement startElement = (ListElement) yesModel.getElementAt(startIndex);
						yesModel.removeElement(startElement);
						endIndex = yesModel.indexOf(endElement);
						yesModel.add(endIndex, startElement);
						yesList.setSelectedIndex(endIndex);
						
						int firstposition=0, secondposition=0;
						MPrintFormatItem targetPFI = null;
						MPrintFormatItem draggedPFI = null;
						for(int j=0 ;j <m_pfi.length ;j++){
							if(m_pfi[j].get_ID() == endElement.getKey()){
								targetPFI = m_pfi[j];
								firstposition=j;
							}
							if(m_pfi[j].get_ID() == startElement.getKey()){
								draggedPFI = m_pfi[j];
								secondposition=j;
							}
						}
						draggedPFI.setSeqNo(targetPFI.getSeqNo()-5);
						
						wc.setIsChanged(true);
						updateYesList();
						MPrintFormatItem fi=m_pfi[firstposition];
						m_pfi[firstposition]=m_pfi[secondposition];
						m_pfi[secondposition]=fi;
						
						if ( yesList.getSelectedItem() != null)
						{
							AuFocus focus = new AuFocus(yesList.getSelectedItem());
							Clients.response(focus);
						}
						//setIsChanged(true);
					}
				}
			}
		};
		yesList.addOnDropListener(yesListMouseMotionListener);

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
		hlayout.setVflex("true");
		hlayout.setHflex("true");
		hlayout.setStyle("width:80%;height:80%;border:none;margin:none;padding:none");
		noList.setHflex("1");
		noList.setVflex(true);
		hlayout.appendChild(noList);
		Vbox vbox = new Vbox();
		vbox.appendChild(bAdd);
		vbox.appendChild(bRemove);
		vbox.setWidth("50px");
		hlayout.appendChild(vbox);

		yesList.setVflex(true);
		yesList.setHflex("1");
		hlayout.appendChild(yesList);
		
		
		EventListener actionListener2 = new EventListener()
		{
			public void onEvent(Event event) throws Exception {
				migrateValueWithinYesList(event);
			}
		};
		
		bUp.setImage("images/Parent24.png");
		bUp.addEventListener(Events.ON_CLICK, actionListener2);

		bDown.setImage("images/Detail24.png");
		bDown.addEventListener(Events.ON_CLICK, actionListener2);
		
		vbox = new Vbox();
		vbox.appendChild(bUp);
		vbox.appendChild(bDown);
		vbox.setWidth("46px");
		hlayout.appendChild(vbox);
		
		this.appendChild(hlayout);
	}

	@Override
	public void onEvent(Event event) throws Exception {

	}

	@Override
	public void refresh() {
		yesItems =new ArrayList<MPrintFormatItem>();
		noItems =new ArrayList<MPrintFormatItem>();
		if (m_pfi.length > 0 && m_pfi != null ) {
			int seq = 10;
			for(int i=0 ; i < m_pfi.length ; i++ ){
				if (m_pfi[i].isPrinted() && m_pfi[i] != null) {
					if (m_pfi[i].isOrderBy()) {
						m_pfi[i].setSortNo(seq);
						seq=seq+10;
						yesItems.add(m_pfi[i]);
					} else{
						noItems.add(m_pfi[i]);
					}
				}
			}
		}

		Collections.sort(yesItems, new Comparator<MPrintFormatItem>() {
			@Override
			public int compare(MPrintFormatItem o1, MPrintFormatItem o2) {
				return o1.getSortNo()-o2.getSortNo();
			}
		});

		yesList.removeAllItems();
		noList.removeAllItems();

		if (yesItems.size() > 0 && yesItems != null) {
			yesModel.removeAllElements();
			for (int i=0 ; i < yesItems.size() ; i++) {
				MPrintFormatItem pfi = yesItems.get(i);
				if (pfi != null) {
					int ID= pfi.get_ID();
					String name =pfi.getPrintName();
					if(name == null)		
					   name=pfi.getName();
					KeyNamePair pair =new KeyNamePair(ID, name);
					yesList.addItem(pair);
					ListElement element =new ListElement(pfi.get_ID(), pfi.getName(), pfi.getSortNo(), true, pfi.getAD_Client_ID(), pfi.getAD_Org_ID());
					yesModel.addElement(element);
				}
			}
		}

		if (noItems.size() > 0 && noItems != null) {
			noModel.removeAllElements();
			for (int i=0 ; i < noItems.size() ; i++) {
				MPrintFormatItem pfi = noItems.get(i);
				if (pfi != null) {
					int ID= pfi.get_ID();
					pfi.setSortNo(0);
					pfi.setIsOrderBy(false);
					String name =pfi.getPrintName();
					if(name == null)		
						   name=pfi.getName();
					KeyNamePair pair =new KeyNamePair(ID, name);					
					noList.addItem(pair);
					ListElement element =new ListElement(pfi.get_ID(), pfi.getName(), pfi.getSortNo(), false, pfi.getAD_Client_ID(), pfi.getAD_Org_ID());
					noModel.add(i,element);
				}
			}
		}
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
		SimpleListModel lmFrom = (source == bAdd || source == noList) ?
				noModel : yesModel;
		SimpleListModel lmTo = (lmFrom == yesModel) ? noModel : yesModel;
		Set selectedItems = listFrom.getSelectedItems();
		List<ListElement> selObjects = new ArrayList<ListElement>();
		for (Object obj : selectedItems) {
			ListItem listItem = (ListItem) obj;
			int index = listFrom.getIndexOfItem(listItem);			
			ListElement selObject = (ListElement)lmFrom.getElementAt(index);
			selObjects.add(selObject);
		}
		for (ListElement selObject : selObjects)
		{
			if (selObject == null)
				continue;

			lmFrom.removeElement(selObject);
			lmTo.addElement(selObject);
			
			for (int j=0 ; j<m_pfi.length ; j++) {
				if (m_pfi[j].get_ID() == selObject.m_key) {
					if (listFrom.equals(noList)) {
						m_pfi[j].setIsOrderBy(true);
					} else {
						m_pfi[j].setIsOrderBy(false);
					}
				}
			}
			wc.setIsChanged(true);
		}

		refresh();
		if ( listTo.getSelectedItem() != null)
		{
			AuFocus focus = new AuFocus(listTo.getSelectedItem());
			Clients.response(focus);
		}

	}	//	migrateValueAcrossLists
	
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
			updateYesList();
			if ( yesList.getSelectedItem() != null)
			{
				AuFocus focus = new AuFocus(yesList.getSelectedItem());
				Clients.response(focus);
			}
		}
	}	//	migrateValueWithinYesList
	
	public void updateYesList(){
		yesList.removeAllItems();
		wc.setIsChanged(true);
		int sortNo=10;
		for(int i=0;i<yesModel.getSize();i++){		
			ListElement obj=(ListElement) yesModel.getElementAt(i);
			for(int j=0;j<m_pfi.length;j++){
				if(m_pfi[j].get_ID() == obj.getKey()){
					String name=obj.getName();
					int ID=obj.getKey();
					KeyNamePair pair=new KeyNamePair(ID, name);
					yesList.addItem(pair);
					m_pfi[j].setSortNo(sortNo);
					sortNo=sortNo+10;
				}
			}
		}
	}

	/**
	 * List Item
	 */
	public class ListElement extends NamePair {
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
	private class DragListener implements EventListener
	{

		/**
		 * Creates a ADSortTab.DragListener.
		 */
		public DragListener()
		{
		}

		public void onEvent(Event event) throws Exception {
			int endIndex=0;
			if (event instanceof DropEvent)
			{
				DropEvent me = (DropEvent) event;

				ListItem endItem = (ListItem) me.getTarget();
				if (!(endItem.getListbox() == yesList))
				{
					return;		//	move within noList
				}

				ListItem startItem = (ListItem) me.getDragged();
				if (startItem.getListbox() == endItem.getListbox())
				{
					return; //move within same list
				}
				int startIndex = noList.getIndexOfItem(startItem);
				ListElement element = (ListElement) noModel.getElementAt(startIndex);
				noModel.removeElement(element);
				endIndex = yesList.getIndexOfItem(endItem);
				yesModel.add(endIndex, element);
				
				for (int j=0 ; j<m_pfi.length ; j++) {
					if (m_pfi[j].get_ID() == element.m_key) {
						 m_pfi[j].setIsOrderBy(true);
						 m_pfi[j].setSortNo(endIndex*10);
					}
				}
				wc.setIsChanged(true);
			}

			   refresh();
				//
				noList.clearSelection();
				yesList.clearSelection();

				yesList.setSelectedIndex(endIndex);
				
			}
		}
	
}
