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
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.adempiere.webui.component.Button;
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


public class WRC2FieldOrderPanel extends WRCTabPanel implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7732332384947376101L;

	/**
	 * 
	 */
	private Button bUp = new Button();
	private Button bDown = new Button();
	
	private ArrayList<MPrintFormatItem> listColumns=new ArrayList<MPrintFormatItem>();
	SimpleListModel sortModel;
	private Listbox sortList;
	
	public WRC2FieldOrderPanel() {
		super();	
	}

	public void setListColumns() {
		listColumns = new ArrayList<MPrintFormatItem>();
		for (MPrintFormatItem item : m_pfi)
		    if(item!=null && item.isPrinted())
		       listColumns.add(item);
	}
	
	public void init()
	{

		Hlayout hlayout = new Hlayout();
		hlayout.setVflex("true");
		hlayout.setHflex("true");
		hlayout.setStyle("width:80%;height:80%;border:none;margin:none;padding:none");
		
		sortList = new Listbox();
		sortModel =new SimpleListModel();
		sortList.setHeight("100%");
		sortList.setWidth("40%");
		sortList.setHflex("40");
		sortList.setVflex("true");
		sortList.addDoubleClickListener(this);
		sortList.setSeltype("multiple");
		sortList.addOnDropListener(this);
		sortList.setItemDraggable(true);
		sortList.setDroppable("true");
		sortList.setVisible(true);
		sortList.setMultiple(true);

		EventListener<Event> sortListMouseMotionListener = new EventListener<Event>()
		{
			public void onEvent(Event event) throws Exception {
				if (event instanceof DropEvent)
				{
					DropEvent me = (DropEvent) event;
					ListItem draggedItem = (ListItem) me.getDragged();
					ListItem targetItem = (ListItem) me.getTarget();
					if (draggedItem.getListbox() == targetItem.getListbox() && draggedItem.getListbox() == sortList)
					{
						List<ListElement> selObjects = new ArrayList<ListElement>();
						int targetIndex = sortList.getIndexOfItem(targetItem);
		
						if (!draggedItem.isSelected())
							draggedItem.setSelected(true);

						for (Object obj : sortList.getSelectedItems()) {
							ListItem listItem = (ListItem) obj;
							int index = sortList.getIndexOfItem(listItem);
							ListElement selObject = (ListElement)sortModel.getElementAt(index);				
							selObjects.add(selObject);						
						}
						migrateValueWithinYesList (targetIndex, selObjects);
						wc.setIsChanged(true);
						refresh();
						if ( sortList.getSelectedItem() != null)
						{
							AuFocus focus = new AuFocus(sortList.getSelectedItem());
							Clients.response(focus);
						}
					}
				}
			}
		};
		sortList.addOnDropListener(sortListMouseMotionListener);

		ListHead listHead = new ListHead();
		listHead.setParent(sortList);
		ListHeader header=new ListHeader();
		header.setHflex("40");
		header.setParent(listHead);
		
		hlayout.appendChild(sortList);
	
		EventListener<Event> actionListener = new EventListener<Event>()
		{
			public void onEvent(Event event) throws Exception {
				migrateValueWithinSortList(event);
			}
		};

		bUp.setImage("images/Parent24.png");
		bUp.addEventListener(Events.ON_CLICK, actionListener);

		bDown.setImage("images/Detail24.png");
		bDown.addEventListener(Events.ON_CLICK, actionListener);
		
		Vbox vbox = new Vbox();
		vbox.appendChild(bUp);
		vbox.appendChild(bDown);
		vbox.setWidth("50px");
		vbox.setHflex("60");
		hlayout.appendChild(vbox);
		this.appendChild(hlayout);

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
		ListElement endObject = (ListElement)sortModel.getElementAt(endIndex);
		int targetPFISeq = 0;
		MPrintFormatItem draggedPFI = null;
		
		for (ListElement selected : selObjects) {
   		    iniIndex = sortModel.indexOf(selected);
			selObject = (ListElement)sortModel.getElementAt(iniIndex);
			draggedPFI =listColumns.get(iniIndex);
			sortModel.removeElement(selObject);
			listColumns.remove(draggedPFI);
			endIndex = sortModel.indexOf(endObject);
			targetPFISeq = listColumns.get(endIndex).getSeqNo();
			listColumns.add(endIndex, draggedPFI);
			sortModel.add(endIndex, selObject);
			draggedPFI.setSeqNo(targetPFISeq - 5);
		}	
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		
	}

	@Override
	public void refresh() {
		sortList.removeAllItems();
		this.setListColumns();

		Collections.sort(listColumns, new Comparator<MPrintFormatItem>() {
			@Override
			public int compare(MPrintFormatItem o1, MPrintFormatItem o2) {
				return o1.getSeqNo()-o2.getSeqNo();
			}
		});

		if (listColumns.size() > 0 && listColumns != null) {
			int seq = 10;
		    sortModel.removeAllElements();
			for (MPrintFormatItem pfi : listColumns){
				 pfi.setSeqNo(seq);
				 m_pfi.get(m_pfi.indexOf(pfi)).setSeqNo(seq);
			     String name= pfi.getPrintName()== null ? pfi.getName(): pfi.getPrintName() ;
			     ListElement element =new ListElement(pfi.get_ID(), name, pfi.getSeqNo(), pfi.getAD_Client_ID(), pfi.getAD_Org_ID());
			     sortModel.addElement(element);
			     sortList.addItem(new KeyNamePair(m_pfi.get(m_pfi.indexOf(pfi)).get_ID(), name)); 
				 seq = seq + 10;
		   }  
		}
	}

	@Override
	public void updatePFI() {
		
	}
	
	/**
	 * 	Move within Yes List
	 *	@param event event
	 */
	void migrateValueWithinSortList (Event event)
	{
		Object[] selObjects = sortList.getSelectedItems().toArray();
		if (selObjects == null)
			return;
		int length = selObjects.length;
		if (length == 0)
			return;
		//
		int[] indices = sortList.getSelectedIndices();
		boolean change = false;
		MPrintFormatItem orig = null;
		Object source = event.getTarget();
		if (source == bUp)
		{
			for (int i = 0; i < length; i++) {
				int index = indices[i];
				if (index == 0)
					break;

				ListElement selObject = (ListElement) sortModel.getElementAt(index);
				ListElement newObject = (ListElement)sortModel.getElementAt(index - 1);
				sortModel.setElementAt(newObject, index);
				sortModel.setElementAt(selObject, index - 1);
				
				listColumns.get(index).setSeqNo(listColumns.get(index).getSeqNo()-10);
				orig = listColumns.get(index);
				listColumns.get(index - 1).setSeqNo(listColumns.get(index - 1).getSeqNo()+10);
				listColumns.set(index, listColumns.get(index-1));
				listColumns.set(index-1 , orig);
				indices[i] = index - 1;
				change = true;
			}
		}	//	up

		else if (source == bDown)
		{
			for (int i = length - 1; i >= 0; i--) {
				int index = indices[i];
				if (index  >= sortModel.getSize() - 1)
					break;
				ListElement selObject = (ListElement) sortModel.getElementAt(index);
				ListElement newObject = (ListElement)sortModel.getElementAt(index + 1);

				sortModel.setElementAt(newObject, index);
				sortModel.setElementAt(selObject, index + 1);
				//
				listColumns.get(index).setSeqNo(listColumns.get(index).getSeqNo()+10);
				orig = m_pfi.get(index);
				listColumns.get(index + 1).setSeqNo(listColumns.get(index + 1).getSeqNo()-10);
				listColumns.set(index, listColumns.get(index+1));
				listColumns.set(index+1,orig);
				indices[i] = index + 1;
				change = true;
			}
		}	//	down

		if (change) {
			refresh();
			sortList.setSelectedIndices(indices);
			wc.setIsChanged(true);
			if ( sortList.getSelectedItem() != null)
			{
				AuFocus focus = new AuFocus(sortList.getSelectedItem());
				Clients.response(focus);
			}
		}
	}	//	migrateValueWithinSortList
	
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
		

		public ListElement(int key, String name, int sortNo, int AD_Client_ID, int AD_Org_ID) {
			super(name);
			this.m_key = key;
			this.m_AD_Client_ID = AD_Client_ID;
			this.m_AD_Org_ID = AD_Org_ID;
			this.m_sortNo = sortNo;
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

}
