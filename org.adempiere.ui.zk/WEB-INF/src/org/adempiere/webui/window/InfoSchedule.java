/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
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
package org.adempiere.webui.window;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.panel.WSchedule;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MAssignmentSlot;
import org.compiere.model.MResourceAssignment;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.ScheduleUtil;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.calendar.impl.SimpleCalendarEvent;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;


/**
 *	Schedule - Resource availability and assignment.
 *
 * 	@author 	Jorg Janke
 * 
 *  Zk Port
 *  @author Low Heng Sin
 *  @author		Elaine
 *  @version	InfoSchedule.java Adempiere Swing UI 3.4.1 
 */
public class InfoSchedule extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3349721592479638482L;

	private Callback<MResourceAssignment> m_callback;
	private Component m_parent;
	/** Window No */
	private int m_windowNo;

	/**
	 * SysConfig USE_ESC_FOR_TAB_CLOSING
	 */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));

	/**
	 *  Constructor
	 *  @param mAssignment optional assignment
	 *  @param createNew if true, allows to create new assignments
	 */
	public InfoSchedule (MResourceAssignment mAssignment, boolean createNew)
	{
		this(mAssignment, createNew, (Callback<MResourceAssignment>)null);
	}
	
	/**
	 * @param mAssignment
	 * @param createNew
	 * @param callback
	 */
	public InfoSchedule (MResourceAssignment mAssignment, boolean createNew, Callback<MResourceAssignment> callback)
	{
		this(mAssignment, createNew, (Component)null, callback);
	}
	
	/**
	 *  Constructor
	 *  @param mAssignment optional assignment
	 *  @param createNew if true, allows to create new assignments
	 *  @param parent
	 *  @param callback
	 */
	public InfoSchedule (MResourceAssignment mAssignment, boolean createNew, Component parent, Callback<MResourceAssignment> callback)
	{
		super();
		setTitle(Msg.getMsg(Env.getCtx(), "InfoSchedule"));
		if (createNew)
		{
			setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
			ZKUpdateUtil.setWindowWidthX(this, 700);
			ZKUpdateUtil.setWindowHeightX(this, 600);
			this.setSizable(true);
		}
		else
		{
			ZKUpdateUtil.setWidth(this, "100%");
			ZKUpdateUtil.setHeight(this, "100%");
		}
		
		this.setClosable(true);
		this.setBorder("normal");
		this.setStyle("position: absolute");
		if (mAssignment == null)
			m_mAssignment = new MResourceAssignment(Env.getCtx(), 0, null);
		else
			m_mAssignment = mAssignment;
		if (mAssignment != null)
			log.info(mAssignment.toString());
		m_dateFrom = m_mAssignment.getAssignDateFrom();
		if (m_dateFrom == null)
			m_dateFrom = new Timestamp(System.currentTimeMillis());
		m_createNew = createNew;
		m_callback = callback;
		m_parent = parent;
		if (callback != null) {
			this.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					if (!m_cancel) {
						m_callback.onCallback(getMResourceAssignment());
					} else {
						m_callback.onCallback(null);
					}
				}
			});
		}
		try
		{
			init();
			dynInit(createNew);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "InfoSchedule", ex);
		}
		displayCalendar();

		m_windowNo = SessionManager.getAppDesktop().registerWindow(this);
		setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_windowNo);	// for closing the window with shortcut
    	SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
    	addEventListener(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this);

	}	//	InfoSchedule

	/**
	 * Default Constructor
	 */
	public InfoSchedule()
	{
		this (null, false);
	}	//	InfoSchedule

	/**	Resource 					*/
	private MResourceAssignment		m_mAssignment;
	/** Date						*/
	private Timestamp		m_dateFrom = null;
	/**	Loading						*/
	private boolean			m_loading = false;
	/**	 Ability to create new assignments	*/
	private boolean			m_createNew;
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(InfoSchedule.class);

	private Vbox mainLayout = new Vbox();
	private Hlayout parameterPanel = new Hlayout();
	private Label labelResourceType = new Label();
	private Listbox fieldResourceType = new Listbox();
	private Label labelResource = new Label();
	private Listbox fieldResource = new Listbox();
	//
	private WSchedule schedulePane = new WSchedule(this);
	private ConfirmPanel confirmPanel = null;
	private WAssignmentDialog vad;
	
	private boolean m_cancel = false;
	private Mask mask;

	/**
	 * Layout dialog
	 * @throws Exception
	 */
	private void init() throws Exception
	{
		this.appendChild(mainLayout);
		ZKUpdateUtil.setHeight(mainLayout, "100%");
		ZKUpdateUtil.setWidth(mainLayout, "100%");
		
		labelResourceType.setValue(Msg.translate(Env.getCtx(), "S_ResourceType_ID"));
		labelResource.setValue(Msg.translate(Env.getCtx(), "S_Resource_ID"));
		
		parameterPanel.setValign("middle");
		parameterPanel.appendChild(labelResourceType);
		parameterPanel.appendChild(fieldResourceType);
		parameterPanel.appendChild(new Space());
		parameterPanel.appendChild(labelResource);
		parameterPanel.appendChild(fieldResource);
		
		mainLayout.appendChild(schedulePane);
		schedulePane.addNorthPane(parameterPanel);
				
		if (m_createNew) 
		{
			Div div = new Div();
			confirmPanel = new ConfirmPanel(true);
			div.appendChild(confirmPanel);			
			schedulePane.addSouthPane(div, "80px");
			
			schedulePane.addEventListener(CalendarsEvent.ON_EVENT_CREATE, this);
			schedulePane.addEventListener(CalendarsEvent.ON_EVENT_EDIT, this);
			schedulePane.addEventListener(CalendarsEvent.ON_EVENT_UPDATE, this);
			schedulePane.removeRefreshButton();
		} 
		else 
		{
			schedulePane.addEventListener(CalendarsEvent.ON_EVENT_EDIT, this);
			schedulePane.addEventListener(CalendarsEvent.ON_EVENT_UPDATE, this);
		}
		
		fieldResourceType.setMold("select");
		fieldResource.setMold("select");
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}	//	jbInit

	/**
	 * Load resource and resource type
	 * @param createNew if true, allows to create new assignments
	 */
	private void dynInit (boolean createNew) 
	{
		//	Resource
		fillResourceType();
		fillResource();
		fieldResourceType.addEventListener(Events.ON_SELECT, this);
		fieldResource.addEventListener(Events.ON_SELECT, this);

		//		
		if (createNew) {
			confirmPanel.addActionListener(Events.ON_CLICK, this);
		}		
	}	//	dynInit

	/**
	 * 	Fill Resource Type (one time)
	 */
	private void fillResourceType()
	{
		//	Get ResourceType of selected Resource
		int S_ResourceType_ID = 0;
		if (m_mAssignment.getS_Resource_ID() != 0)
		{
			String sql = "SELECT S_ResourceType_ID FROM S_Resource WHERE S_Resource_ID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, m_mAssignment.getS_Resource_ID());
				rs = pstmt.executeQuery();
				if (rs.next())
					S_ResourceType_ID = rs.getInt(1);
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
		}

		//	Get Resource Types
		String sql = MRole.getDefault().addAccessSQL(
			"SELECT S_ResourceType_ID, Name FROM S_ResourceType WHERE IsActive='Y' ORDER BY 2",
			"S_ResourceType", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		KeyNamePair defaultValue = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				KeyNamePair pp = new KeyNamePair(rs.getInt(1), rs.getString(2));
				if (S_ResourceType_ID == pp.getKey())
					defaultValue = pp;
				fieldResourceType.appendItem(pp.getName(), pp.getKey());
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		if (defaultValue != null) {
			int cnt = fieldResourceType.getItemCount();
			for(int i = 0; i < cnt; i++) {
				ListItem li = fieldResourceType.getItemAtIndex(i);
				Integer key = (Integer) li.getValue();
				if (key.intValue() == defaultValue.getKey()) {
					fieldResourceType.setSelectedItem(li);
					break;
				}
			}
		} else if (fieldResourceType.getItemCount() > 0) {
			fieldResourceType.setSelectedIndex(0);
		}
	}	//	fillResourceType

	/**
	 * 	Fill Resource Pick from Resource Type
	 */
	private void fillResource()
	{
		ListItem listItem = fieldResourceType.getSelectedItem();
		if (listItem == null)
			return;
		//	Get Resource Type
		KeyNamePair pp = new KeyNamePair((Integer)listItem.getValue(), listItem.getLabel());
		int S_ResourceType_ID = pp.getKey();

		KeyNamePair defaultValue = null;

		//	Load Resources
		m_loading = true;
		fieldResource.getChildren().clear();
		String sql = "SELECT S_Resource_ID, Name FROM S_Resource WHERE S_ResourceType_ID=? ORDER BY 2";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, S_ResourceType_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				pp = new KeyNamePair(rs.getInt(1), rs.getString(2));
				if (m_mAssignment.getS_Resource_ID() == pp.getKey())
					defaultValue = pp;
				fieldResource.appendItem(pp.getName(), pp.getKey());
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs,pstmt);
			rs = null;
			pstmt = null;
		}
		if (defaultValue != null) {
			int cnt = fieldResource.getItemCount();
			for(int i = 0; i < cnt; i++) {
				ListItem li = fieldResource.getItemAtIndex(i);
				Integer key = (Integer) li.getValue();
				if (key.intValue() == defaultValue.getKey()) {
					fieldResource.setSelectedItem(li);
					break;
				}
			}
		} else if ( fieldResource.getItemCount() > 0) {
			fieldResource.setSelectedIndex(0);
		}

		m_loading = false;
	}	//	fillResource

	/**
	 * 	Display Calendar for selected Resource, Time(day/week/month) and Date
	 */
	private void displayCalendar ()
	{
		//	Get Values
		ListItem listItem = fieldResource.getSelectedItem();
		if (listItem == null)
			return;
		KeyNamePair pp = new KeyNamePair((Integer)listItem.getValue(), listItem.getLabel());
		int S_Resource_ID = pp.getKey();
		m_mAssignment.setS_Resource_ID(S_Resource_ID);

		Date date = m_dateFrom;
		if (date == null) date = new Timestamp(System.currentTimeMillis());
		//

		//	Set Info
		m_loading = true;
		schedulePane.recreate(S_Resource_ID, date);
		m_loading = false;
		invalidate();
	}	//	displayCalendar

	/**
	 * Close dialog
	 */
	public void dispose()
	{
		this.detach();
	}	//	dispose

	/**
	 * 	Callback.
	 * 	Called from WSchedule after WAssignmentDialog finished
	 * 	@param assignment New/Changed Assignment
	 *  @param createNew
	 *  @param cancelled
	 */
	public void mAssignmentCallback (MResourceAssignment assignment, boolean createNew, boolean cancelled)
	{
		hideBusyMask();
		if (!cancelled) 
		{
			m_mAssignment = assignment;		
			if (createNew)
				dispose();
			else
				displayCalendar();
		}
		else
			displayCalendar();
	}	//	mAssignmentCallback

	/**
	 * 	Get Assignment
	 * 	@return Assignment
	 */
	public MResourceAssignment getMResourceAssignment()
	{
		return m_mAssignment;
	}	//	getMResourceAssignment

	@Override
	public void onEvent(Event event) throws Exception {
		if (m_loading)
			return;

		if (event.getTarget().getId().equals("Ok")) {
			m_cancel = false;
			dispose();
		} else if (event.getTarget().getId().equals("Cancel")) {
			onCancel();
		//
		} else if (event.getTarget() == fieldResourceType)
		{
			fillResource();
			displayCalendar();
		}
		//
		else if (event instanceof CalendarsEvent)
			doEdit((CalendarsEvent)event);
		else if (event.getTarget() == fieldResource)
			displayCalendar();
		else if (event.getName().equals(Events.ON_CTRL_KEY)) {
        	KeyEvent keyEvent = (KeyEvent) event;
			if (LayoutUtils.isReallyVisible(this))
				this.onCtrlKeyEvent(keyEvent);
		}
		else if(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT.equals(event.getName())) {
        	IDesktop desktop = SessionManager.getAppDesktop();
        	if (m_windowNo > 0 && desktop.isCloseTabWithShortcut())
        		desktop.closeWindow(m_windowNo);
        	else
        		desktop.setCloseTabWithShortcut(true);
        }
		//
	}

	/**
	 * onCancel event
	 */
	private void onCancel() {
		// do not allow to close tab for Events.ON_CTRL_KEY event
		if(isUseEscForTabClosing)
			SessionManager.getAppDesktop().setCloseTabWithShortcut(false);

		m_cancel = true;
		dispose();
	}
	
	/**
	 * Edit or create calendar event (for S_ResourceAssignment)
	 * @param event
	 */
	private void doEdit(CalendarsEvent event) {
		ListItem listItem = fieldResource.getSelectedItem();
		if (listItem == null)
			return;
		//	Get Resource Type
		KeyNamePair pp = new KeyNamePair((Integer)listItem.getValue(), listItem.getLabel());
		int S_Resource_ID = pp.getKey();
		
		ScheduleUtil schedule = new ScheduleUtil (Env.getCtx());
		Timestamp start = new Timestamp(event.getBeginDate() != null ? event.getBeginDate().getTime() : event.getCalendarEvent().getBeginDate().getTime());
		Timestamp end =new Timestamp(event.getEndDate() != null ? event.getEndDate().getTime() : event.getCalendarEvent().getEndDate().getTime());
		double hours = (end.getTime() - start.getTime())/ 1000d / 60d / 60d;
		
		MAssignmentSlot[] mas = schedule.getAssignmentSlots(S_Resource_ID, TimeUtil.getPreviousDay(start), TimeUtil.getNextDay(end), null, true, null);
		MAssignmentSlot slot = null;
		for(int i = 0; i < mas.length; i++) {
			if (mas[i].getStartTime().getTime() == start.getTime()) {
				slot = mas[i];
				break;
			}
			if (mas[i].getEndTime() != null) {
				if (start.getTime() > mas[i].getStartTime().getTime()
					&& start.getTime() < mas[i].getEndTime().getTime()) {
					slot = mas[i];
					break;
				} else if (end.getTime() > mas[i].getStartTime().getTime()
						&& end.getTime() < mas[i].getEndTime().getTime()) {
					slot = mas[i];
					break;
				} else if (start.getTime() < mas[i].getStartTime().getTime()
					&& end.getTime() >= mas[i].getEndTime().getTime()) {
					slot = mas[i];
					break;
				}
			}
		}

		if (slot == null) {
			MResourceAssignment ma;
			if (m_mAssignment == null)
				ma = new MResourceAssignment(Env.getCtx(), 0, null);
			else
				ma = m_mAssignment;
			ma.setS_Resource_ID(S_Resource_ID);
			
			ma.setAssignDateFrom(start);
			ma.setQty(BigDecimal.valueOf(hours));
			if (m_parent == null || m_callback == null) {
				final boolean createNew = true;
				if (vad != null && vad.getPage() != null)
					vad.detach();
				
				vad =  new WAssignmentDialog (ma, false, createNew);
				if (event.getBeginDate() != null && event.getEndDate() != null) {
					SimpleCalendarEvent newEvent = new SimpleCalendarEvent();
					newEvent.setBeginDate(event.getBeginDate());
					newEvent.setEndDate(event.getEndDate());
					if (event.getCalendarEvent() != null) {
						newEvent.setContent(event.getCalendarEvent().getContent());
						newEvent.setContentColor(event.getCalendarEvent().getContentColor());
						newEvent.setHeaderColor(event.getCalendarEvent().getHeaderColor());
						newEvent.setTitle(event.getCalendarEvent().getTitle());						
						schedulePane.getModel().remove(event.getCalendarEvent());
					}
					schedulePane.getModel().add(newEvent);
				}
				vad.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						mAssignmentCallback(vad.getMResourceAssignment(), createNew, vad.isCancelled());
					}
				});					
				vad.setTitle(null);
				ZkCssHelper.appendStyle(vad, "position: absolute");
				showBusyMask();
				this.appendChild(vad);
				LayoutUtils.openOverlappedWindow(this, vad, "middle_center");
				vad.focus();
			} else {
				m_cancel = false;
				m_mAssignment = ma;
				dispose();
			}
		} else {
			if (!slot.isAssignment()) {
				Dialog.error(0, "No available time slot for the selected day.");
				return;
			}
			
			MResourceAssignment ma = slot.getMAssignment();
			ma.setAssignDateFrom(start);
			ma.setQty(BigDecimal.valueOf(hours));
			
			if (m_parent == null || m_callback == null) {
				if (event.getBeginDate() != null && event.getEndDate() != null) {
					SimpleCalendarEvent newEvent = new SimpleCalendarEvent();
					newEvent.setBeginDate(event.getBeginDate());
					newEvent.setEndDate(event.getEndDate());
					if (event.getCalendarEvent() != null) {
						newEvent.setContent(event.getCalendarEvent().getContent());
						newEvent.setContentColor(event.getCalendarEvent().getContentColor());
						newEvent.setHeaderColor(event.getCalendarEvent().getHeaderColor());
						newEvent.setTitle(event.getCalendarEvent().getTitle());
						schedulePane.getModel().remove(event.getCalendarEvent());
					}
					schedulePane.getModel().add(newEvent);
				}
				
				final boolean createNew = false;
				if (vad != null && vad.getPage() != null)
					vad.detach();
				vad =  new WAssignmentDialog (ma, false, createNew);
				vad.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						mAssignmentCallback(vad.getMResourceAssignment(), createNew, vad.isCancelled());
					}
				});					
				vad.setTitle(null);
				ZkCssHelper.appendStyle(vad, "position: absolute");
				showBusyMask();
				this.appendChild(vad);
				LayoutUtils.openOverlappedWindow(this, vad, "middle_center");
				vad.focus();
			} else {
				m_cancel = false;
				m_mAssignment = ma;
				dispose();
			}
		}
	}

	/**
	 * @return true if create new assignment is enable
	 */
	public boolean isCreateNew() {
		return m_createNew;
	}

	/**
	 * Callback from WSchedule
	 * @param date
	 */
	public void dateCallback(Date date) {
		m_dateFrom = new Timestamp(date.getTime());
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.AbstractComponent#onPageAttached(org.zkoss.zk.ui.Page, org.zkoss.zk.ui.Page)
	 */
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			displayCalendar();
			SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0);
		}
	}

	/**
	 * @return busy mask
	 */
	private Div getMask() {
		if (mask == null) {
			mask = new Mask();
		}
		return mask;
	}
	
	/**
	 * Show busy mask
	 */
	protected void showBusyMask() {
		appendChild(getMask());
	}
	
	/**
	 * Hide busy mask
	 */
	protected void hideBusyMask() {
		if (mask != null && mask.getParent() != null) {
			mask.detach();
		}
	}

	/**
	 * Handle shortcut key event
	 * @param keyEvent
	 */
	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		if ((keyEvent.isAltKey() && keyEvent.getKeyCode() == 0x58)	// Alt-X
				|| (keyEvent.getKeyCode() == 0x1B && isUseEscForTabClosing)) { 	// ESC
			keyEvent.stopPropagation();
			Events.echoEvent(new Event(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this));
		}
	}
}	//	InfoSchedule
