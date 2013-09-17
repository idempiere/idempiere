/******************************************************************************
 * Copyright (C) 2013 Juliana                                                 *
 * Copyright (C) 2013 hengsin                                                 *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.webui.window;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.MDashboardContent;
import org.compiere.model.MDashboardPreference;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MouseEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Vbox;
import org.zkoss.zul.Vlayout;

/**
 * @author juliana
 * @author hengsin
 */
public class WGadgets extends Window implements  EventListener<Event>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3652943562286386813L;
	
	
	// UI variables
	protected Label noLabel = new Label();
	protected Label yesLabel = new Label();
	protected Button bAdd = new Button();
	protected Button bRemove = new Button();
	protected ConfirmPanel panel;
	//
	protected SimpleListModel noModel = new SimpleListModel();
	protected SimpleListModel yesModel = new SimpleListModel();
	protected Listbox noList = new Listbox();
	protected Listbox yesList = new Listbox();
	protected ArrayList<MDashboardContent> yesItems =new ArrayList<MDashboardContent>();
	protected ArrayList<MDashboardContent> noItems =new ArrayList<MDashboardContent>();

	protected Map<Integer, MDashboardPreference> dirtyList = new LinkedHashMap<Integer, MDashboardPreference>();
	
	/**
	 * 
	 */
	public WGadgets() {			
		init();
		refresh();
	}

	@Override
	public void onEvent(Event event) throws Exception 
	{
		 if (Events.ON_CLICK.equals(event.getName()))
		 {
			 if (panel.getButton("Ok").equals(event.getTarget()))
			 {
				 Trx trx = Trx.get(Trx.createTrxName("ManagedGadgets"), true);
				 try {
					 trx.start();
					 for(MDashboardPreference pre : dirtyList.values()) {
						 pre.saveEx(trx.getTrxName());
					 }
					 trx.commit(true);
				 } catch (RuntimeException e) {
					 trx.rollback();
					 throw e;
				 } finally {
					 trx.close();
				 }
				 SessionManager.getAppDesktop().renderHomeTab();
			     this.detach();
			 }
			 else if (panel.getButton("Cancel").equals(event.getTarget()))
			 {				
			  	  this.detach();
			 }			
		}
		
	}
	
	public void init()
	{
		setSclass("popup-dialog");			
		//
		noLabel.setValue( Msg.translate(Env.getCtx(), "Available"));
		yesLabel.setValue( Msg.translate(Env.getCtx(), "Show"));

		EventListener<Event> mouseListener = new EventListener<Event>()
		{

			public void onEvent(Event event) throws Exception
			{
				if (Events.ON_CLICK.equals(event.getName()))
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
		yesList.setSeltype("multiple");
		noList.setSeltype("multiple");

		bAdd.setImage(ThemeManager.getThemeResource("images/Next24.png"));
		bAdd.addEventListener(Events.ON_CLICK, actionListener);

		bRemove.setImage(ThemeManager.getThemeResource("images/Previous24.png"));
		bRemove.addEventListener(Events.ON_CLICK, actionListener);

		final EventListener<Event> moveListener = new MoveListener();
		yesList.addOnDropListener(moveListener);
		yesList.addDoubleClickListener(moveListener);
		noList.addOnDropListener(moveListener);
		noList.addDoubleClickListener(moveListener);
		yesList.setItemDraggable(true);
		yesList.setDroppable("true");
		yesList.addEventListener(Events.ON_DROP, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				moveListener.onEvent(event);
			}
		});
		noList.setItemDraggable(true);
		noList.setDroppable("true");
		noList.addEventListener(Events.ON_DROP, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				moveListener.onEvent(event);
			}
		});
		
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
		hlayout.setStyle("padding: 2px 3px;");
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
				
		panel = new ConfirmPanel(true);
		panel.setSclass("dialog-footer");
		panel.addActionListener(Events.ON_CLICK, this);
		panel.setVflex("min");
				
		Vlayout vlayout = new Vlayout();
		vlayout.setHeight("100%");
		vlayout.setWidth("100%");
		vlayout.setStyle("margin: 0px; border: none; padding: 0px");
		vlayout.appendChild(hlayout);
		vlayout.appendChild(panel);
		this.appendChild(vlayout);
		this.setBorder("normal");
	}
	
	
	public void loadItems()
	{
		Properties ctx = Env.getCtx();
			
		int AD_CLient_ID =Env.getAD_Client_ID(ctx);
		int AD_Role_ID = Env.getAD_Role_ID(ctx);
		int AD_User_ID = Env.getAD_User_ID(ctx);
				
		noItems.removeAll(noItems);
		yesItems.removeAll(yesItems);
		String query = " SELECT ct.PA_DashboardContent_ID, ct.Name "
					+" FROM PA_DashboardContent ct"
					+" WHERE ct.AD_Client_ID IN (0,?)"
					+" AND ct.IsActive='Y'"
					+" AND ct.PA_DashboardContent_ID NOT IN ("
					+" SELECT pre.PA_DashboardContent_ID"
					+" FROM PA_DashboardPreference pre"
					+" WHERE pre.AD_Client_ID IN (0,?)"					
					+" AND pre.AD_Role_ID = ?"
					+" AND pre.AD_User_ID = ?"
					+" AND pre.AD_Org_ID=0 "
					+" AND pre.IsActive='Y') " 
					+" AND (" 
					+" ct.PA_DashboardContent_ID NOT IN ( SELECT PA_DashboardContent_ID "
					+"  FROM  PA_DashboardContent_Access"
					+"   WHERE IsActive='Y' AND AD_Client_ID IN (0, ?))" 
					+" OR ct.PA_DashboardContent_ID IN ( SELECT cta.PA_DashboardContent_ID " 
					+"  FROM PA_DashboardContent_Access cta "
					+" WHERE cta.IsActive='Y'"
					+" AND coalesce(cta.AD_Role_ID, ?) = ?"
					+" AND coalesce(cta.AD_User_ID, ?) = ?"
					+" AND cta.AD_Client_ID in (0,?) ) " 
					+" )";
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		try {
			pstmt = DB.prepareStatement(query, null);
			pstmt.setInt(1, AD_CLient_ID);
			pstmt.setInt(2, AD_CLient_ID);
			pstmt.setInt(3, AD_Role_ID);
			pstmt.setInt(4, AD_User_ID);
			pstmt.setInt(5, AD_CLient_ID);
			pstmt.setInt(6, AD_Role_ID);
			pstmt.setInt(7, AD_Role_ID);
			pstmt.setInt(8, AD_User_ID);
			pstmt.setInt(9, AD_User_ID);
			pstmt.setInt(10, AD_CLient_ID);
			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				
				MDashboardContent content= new MDashboardContent(ctx, rs.getInt(1),null);
				if (!dirtyList.containsKey(content.getPA_DashboardContent_ID())) {
					noItems.add(content);
				}					
			}		
		} catch (Exception e) {
			throw new AdempiereException( "Error while loading dashboard contents"+e.getMessage());
			
		} finally {
		   DB.close(rs, pstmt);
		}

		String where=" AD_User_ID=?"
				    +" AND AD_Role_ID=?"
				    +" AND AD_Client_ID=?"
				    +" AND AD_Org_ID=0"
				    +" AND IsActive='Y'";
		
		Query query1 =new Query(ctx,MDashboardPreference.Table_Name, where, null);
		query1.setParameters(new Object[]{AD_User_ID,AD_Role_ID ,AD_CLient_ID});
		List<MDashboardPreference> preference=query1.list();

	    if(preference.size() > 0){
	    	for(int i = 0; i < preference.size() ; i++){
	    		int ID = preference.get(i).getPA_DashboardContent_ID();
	    		MDashboardContent content = new MDashboardContent(ctx, ID, null);
	    		if (content.isActive()) {
		    		if (!dirtyList.containsKey(content.getPA_DashboardContent_ID())) {
		    			yesItems.add(content);
		    		}
	    		}
	    	}
	    }

		for(MDashboardPreference pre : dirtyList.values()) {
			MDashboardContent content = (MDashboardContent) pre.getPA_DashboardContent();
			if (pre.isActive())
				yesItems.add(content);
			else
				noItems.add(content);
		}
	}
	
	/**
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
		
		migrateLists (listFrom,listTo); //,endIndex);
	}	//	migrateValueAcrossLists
	
	protected void migrateLists (Listbox listFrom , Listbox listTo) // , int endIndex)
	{
		int index = 0; 
		SimpleListModel lmFrom = (listFrom == yesList) ? yesModel:noModel;
		Set<?> selectedItems = listFrom.getSelectedItems();
		List<ListElement> selObjects = new ArrayList<ListElement>();
		for (Object obj : selectedItems) {
			ListItem listItem = (ListItem) obj;
			index = listFrom.getIndexOfItem(listItem);			
			ListElement selObject = (ListElement)lmFrom.getElementAt(index);
			selObjects.add(selObject);
		}
		index = 0;
		Arrays.sort(selObjects.toArray());	
		for (ListElement selObject : selObjects)
		{
			if (selObject == null)
				continue;

			Properties ctx =Env.getCtx();
			int AD_User_ID= Env.getAD_User_ID(ctx);
			int AD_Role_ID=Env.getAD_Role_ID(ctx);
			int AD_Client_ID= Env.getAD_Client_ID(ctx);
			
			MDashboardContent content = new MDashboardContent(Env.getCtx(),selObject.m_key, null);
			String where=" AD_Client_ID=?"
				    +" AND PA_DashboardContent_ID=?" 
					+" AND AD_Role_ID=? AND AD_User_ID=? AND AD_Org_ID=0";
			Query query = new Query(ctx, MDashboardPreference.Table_Name, where, null);
			query.setParameters(AD_Client_ID, content.getPA_DashboardContent_ID(), AD_Role_ID, AD_User_ID);
			
			MDashboardPreference pre = query.setOnlyActiveRecords(false).first();
			
			if(listFrom.equals(noList)) {				
				if (pre != null){
					pre.setIsActive(true);			
					pre.setIsShowInDashboard(content.isShowInDashboard());
				}else{
					pre = new MDashboardPreference(Env.getCtx(), 0, null);
					pre.setAD_Org_ID(0);
					pre.setAD_Role_ID(AD_Role_ID);
					pre.set_ValueNoCheck("AD_User_ID",AD_User_ID);
					pre.setColumnNo(content.getColumnNo());
					pre.setIsCollapsedByDefault(content.isCollapsedByDefault());
					pre.setIsShowInDashboard(content.isShowInDashboard());
					pre.setLine(content.getLine());
					pre.setPA_DashboardContent_ID(content.getPA_DashboardContent_ID());				     
				}
				dirtyList.put(pre.getPA_DashboardContent_ID(), pre);
			}else{			 
				if(pre != null){
					pre.setIsActive(false);
				}else{
					pre = new MDashboardPreference(Env.getCtx(), 0, null);
					pre.setAD_Org_ID(0);
					pre.setAD_Role_ID(AD_Role_ID);
					pre.set_ValueNoCheck("AD_User_ID",AD_User_ID);
					pre.setColumnNo(content.getColumnNo());
					pre.setIsCollapsedByDefault(content.isCollapsedByDefault());
					pre.setIsShowInDashboard(content.isShowInDashboard());
					pre.setLine(content.getLine());
					pre.setPA_DashboardContent_ID(content.getPA_DashboardContent_ID());
					pre.setIsActive(false);
				}
				dirtyList.put(pre.getPA_DashboardContent_ID(), pre);
			}
		}	
		refresh();
		if ( listTo.getSelectedItem() != null)
		{
			AuFocus focus = new AuFocus(listTo.getSelectedItem());
			Clients.response(focus);
		}
	}
	
    public void refresh() {		
		
		this.loadItems();
		yesList.removeAllItems();
		noList.removeAllItems();

		if (yesItems.size() > 0 && yesItems != null) {
			yesModel.removeAllElements();
			for (int i=0 ; i < yesItems.size() ; i++) {				 
				 int ID= yesItems.get(i).get_ID();
				 String name = yesItems.get(i).getName();
				 yesList.addItem(new KeyNamePair(ID, name));
				 yesModel.addElement(new ListElement(ID, name, yesItems.get(i).getName(), true, yesItems.get(i).getAD_Client_ID(), yesItems.get(i).getAD_Org_ID()));	
			}
		}
		
		if (noItems.size() > 0 && noItems != null) {
			noModel.removeAllElements();
			for (int i=0 ; i < noItems.size() ; i++) {
				 int ID= noItems.get(i).get_ID();
				 String name = noItems.get(i).getName();
				 noList.addItem(new KeyNamePair(ID, name));
				 noModel.add(i,new ListElement(ID, name, noItems.get(i).getName(), false, noItems.get(i).getAD_Client_ID(), noItems.get(i).getAD_Org_ID()));
			}
		}
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
		private String	m_namecontent;
		/** Initial selection flag */
		private boolean m_isYes;
	
	
		public ListElement(int key, String name, String namecontent, boolean isYes, int AD_Client_ID, int AD_Org_ID) {
			super(name);
			this.m_key = key;
			this.m_AD_Client_ID = AD_Client_ID;
			this.m_AD_Org_ID = AD_Org_ID;
			this.m_namecontent = namecontent;
			this.m_isYes = isYes;
	
		}
		
		public int getKey() {
			return m_key;
		}
				
		public String getM_namecontent() {
			return m_namecontent;
		}
	
		public void setM_namecontent(String m_namecontent) {
			this.m_namecontent = m_namecontent;
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
	private class MoveListener implements EventListener<Event>
	{

		/**
		 * Creates a ADSortTab.DragListener.
		 */
		public MoveListener()
		{
		}

		public void onEvent(Event event) throws Exception {
			if (event instanceof DropEvent)
			{
				Listbox listFrom = null;
				Listbox listTo = null;
				
				ListItem fromItem = null;
				ListItem toItem = null;
				
				DropEvent me = (DropEvent) event;
				Object target = me.getTarget();
				if (target instanceof ListItem) {
					toItem = (ListItem) target;
					listTo = (Listbox) toItem.getListbox();
				} else {
					listTo = (Listbox) target;
				}
				fromItem = (ListItem) me.getDragged();
				listFrom = (Listbox) fromItem.getListbox();
				
				if (!fromItem.isSelected())
					fromItem.setSelected(true);
				
				if (listFrom != listTo)
				{
					migrateLists (listFrom,listTo);
				}
				else
				{
					//reordering not implemented
					;
				}
			}
			else if (event instanceof MouseEvent)
			{
				Listbox listFrom = null;
				Listbox listTo = null;
				
				ListItem fromItem = (ListItem) event.getTarget();				
				listFrom = (Listbox) fromItem.getListbox();
				listTo = listFrom==yesList ? noList : yesList;
				
				if (!fromItem.isSelected())
					fromItem.setSelected(true);
				
				migrateLists (listFrom,listTo);
			}
		}
	}
}
