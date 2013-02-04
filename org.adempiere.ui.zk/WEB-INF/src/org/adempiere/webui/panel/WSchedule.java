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
package org.adempiere.webui.panel;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;
import java.util.logging.Level;

import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.InfoSchedule;
import org.compiere.model.MAssignmentSlot;
import org.compiere.model.ScheduleUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.calendar.Calendars;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.calendar.impl.SimpleCalendarEvent;
import org.zkoss.calendar.impl.SimpleCalendarModel;
import org.zkoss.util.Locales;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Button;
import org.zkoss.zul.Label;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 *	Visual and Control Part of Schedule.
 *  Contains Time and Schedule Panels
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: VSchedule.java,v 1.3 2006/07/30 00:51:27 jjanke Exp $
 * 
 *  Zk Port
 *  @author Low Heng Sin
 */
public class WSchedule extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7714179510197450419L;

	@SuppressWarnings("unused")
	private InfoSchedule infoSchedule;

	/**
	 *	Constructor
	 *  @param is InfoSchedule for call back
	 *  @param type Type of schedule TYPE_...
	 */
	public WSchedule (InfoSchedule is)
	{		
		infoSchedule = is;
		
		try
		{
			init();
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "VSchedule", e);
		}		
	}	//	WSchedule

	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(WSchedule.class);


	private ToolBarButton button;

	@SuppressWarnings("unused")
	private Date m_center;

	private Component calendarContainer;

	private Calendars calendars;
	private SimpleCalendarModel scm;

	private Button btnCurrentDate;
	private Label lblDate;

	private int S_Resource_ID;

	private Component divArrowLeft;

	private Component divArrowRight;

	private Component divTabDay;

	private Component divTabWeek;

	private Component divTabWeekdays;

	private Component divTabMonth;

	private Borderlayout borderlayout;

	private Component btnRefresh;
	
	/**
	 * 	Static init
	 *  <pre>
	 * 	timePanel (West)
	 *  schedlePanel (in schedulePane - Center)
	 *  </pre>
	 * 	@throws Exception
	 */
	private void init() throws Exception
	{
		this.getChildren().clear();
				
		calendarContainer = Executions.createComponents("calendar.zul", this, null);
		
		borderlayout = (Borderlayout) calendarContainer.getFellow("main");
		borderlayout.setStyle("position: absolute; width: 98%; margin: auto;");
		borderlayout.setHeight("100%");
		if (borderlayout.getSouth() != null) {
			borderlayout.getSouth().detach();
		}

		Component tmp = calendarContainer.getFellow("btnSwitchTimeZone");
		if (tmp != null)
			tmp.detach();		
		tmp = calendarContainer.getFellow("lbxRequestTypes");
		if (tmp != null)
			tmp.getParent().detach();
		tmp = calendarContainer.getFellow("FDOW");
		if (tmp != null)
			tmp.detach();
		
		calendars = (Calendars) calendarContainer.getFellow("cal");
		TimeZone timezone = SessionManager.getAppDesktop().getClientInfo().timeZone;
		calendars.addTimeZone(timezone.getID(), timezone);
		
		calendars.addEventListener(CalendarsEvent.ON_EVENT_CREATE, this);
		calendars.addEventListener(CalendarsEvent.ON_EVENT_EDIT, this);
		calendars.addEventListener(CalendarsEvent.ON_EVENT_UPDATE, this);
		
		this.appendChild(calendarContainer);		
		
		btnCurrentDate = (Button) calendarContainer.getFellow("btnCurrentDate");
		btnCurrentDate.addEventListener(Events.ON_CLICK, this);
		
		btnRefresh = calendarContainer.getFellow("btnRefresh");
		btnRefresh.addEventListener(Events.ON_CLICK, this);
		
		lblDate = (Label) calendarContainer.getFellow("lblDate");
		lblDate.addEventListener(Events.ON_CREATE, this);
		
		divArrowLeft = calendarContainer.getFellow("divArrowLeft");
		divArrowLeft.addEventListener("onMoveDate", this);
		
		divArrowRight = calendarContainer.getFellow("divArrowRight");
		divArrowRight.addEventListener("onMoveDate", this);
		
		divTabDay = calendarContainer.getFellow("divTabDay");
		divTabDay.addEventListener("onUpdateView", this);
		
		divTabWeek = calendarContainer.getFellow("divTabWeek");
		divTabWeek.addEventListener("onUpdateView", this);
		
		divTabWeekdays = calendarContainer.getFellow("divTabWeekdays");
		divTabWeekdays.addEventListener("onUpdateView", this);
		
		divTabMonth = calendarContainer.getFellow("divTabMonth");
		divTabMonth.addEventListener("onUpdateView", this);
		
		button = new ToolBarButton();
		button.setLabel("Edit");
		button.setStyle("visibility: hidden; height: 0px; width: 0px");
		button.addEventListener(Events.ON_CLICK, this);
		this.appendChild(button);
		
		divTabClicked(7);
	}	//	jbInit

	/**
	 * 	Recreate View
	 * 	@param S_Resource_ID Resource
	 * 	@param date Date
	 */
	public void recreate (int S_Resource_ID, Date date)
	{
		this.S_Resource_ID = S_Resource_ID;
		calendars.setCurrentDate(date);
		
		updateModel();
	}	//	recreate

	private void updateModel() {
		ScheduleUtil m_model = new ScheduleUtil (Env.getCtx());
		
		//		Calculate Start Day
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(calendars.getCurrentDate());
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		Timestamp startDate = new Timestamp(cal.getTimeInMillis());
		//	Calculate End Date
		cal.add(Calendar.MONTH, 1);
		Timestamp endDate = new Timestamp (cal.getTimeInMillis());
		
		scm = new SimpleCalendarModel();
		if (S_Resource_ID > 0) {
			MAssignmentSlot[] list = m_model.getAssignmentSlots (S_Resource_ID, startDate, endDate, null, true, null);
			
			for(MAssignmentSlot mas : list) {
				SimpleCalendarEvent event = new SimpleCalendarEvent();
				event.setBeginDate(mas.getStartTime());
				event.setEndDate(mas.getEndTime());
				event.setTitle(mas.getName());
				event.setContent(mas.getDescription());
				event.setHeaderColor('#'+ZkCssHelper.createHexColorString(mas.getColor(true)));
				event.setContentColor('#'+ZkCssHelper.createHexColorString(mas.getColor(true)));
				if (!mas.isAssignment() || mas.getMAssignment().isConfirmed())
					event.setLocked(true);
				scm.add(event);
			}
		}
		
		calendars.setModel(scm);
	}
	
	public SimpleCalendarModel getModel() {
		return scm;
	}
	
	public void onEvent(Event event) throws Exception {
		String type = event.getName();
		if (type.equals(Events.ON_CLICK)) {
			if (event.getTarget() == btnCurrentDate) {
				btnCurrentDateClicked();
			} else if (event.getTarget() == btnRefresh) {
				updateModel();
			}
		} else if (type.equals(Events.ON_CREATE)) {
			if (event.getTarget() == lblDate)
				updateDateLabel();
		} else if (type.equals("onMoveDate")) {
			if (event.getTarget() == divArrowLeft)
				divArrowClicked(false);
			else if (event.getTarget() == divArrowRight)
				divArrowClicked(true);
		} else if (type.equals("onUpdateView")) {
			String text = String.valueOf(event.getData());
			int days = "Day".equals(text) ? 1: "5 Days".equals(text) ? 5: "Week".equals(text) ? 7: 0;
			divTabClicked(days);
		} else {
			Events.sendEvent(this, event);
		}
	}
	
	private void btnCurrentDateClicked() {
		calendars.setCurrentDate(Calendar.getInstance(calendars.getDefaultTimeZone()).getTime());
		updateDateLabel();
	}
	
	private void updateDateLabel() {
		Date b = calendars.getBeginDate();
		Date e = calendars.getEndDate();
		SimpleDateFormat sdfV = new SimpleDateFormat("yyyy/MMM/dd", Locales.getCurrent());
		sdfV.setTimeZone(calendars.getDefaultTimeZone());
		lblDate.setValue(sdfV.format(b) + " - " + sdfV.format(e));
	}
	
	private void divArrowClicked(boolean isNext) {
		if (isNext)
			calendars.nextPage();
		else
			calendars.previousPage();
		updateDateLabel();
		updateModel();
	}
	
	private void divTabClicked(int days) {		
		if (days > 0) {
			calendars.setMold("default");
			calendars.setDays(days);
		} else {
			calendars.setMold("month");
		}
		updateDateLabel();
	}

	public void addNorthPane(Component pane) {
		if (borderlayout != null) {
			if (borderlayout.getNorth() != null) {
				borderlayout.getNorth().detach();
			}
			North north = new North();
			north.appendChild(pane);
			borderlayout.appendChild(north);
		}
	}
	
	public void addSouthPane(Component pane, String height) {
		if (borderlayout != null) {
			if (borderlayout.getSouth() != null) {
				borderlayout.getSouth().detach();
			}
			South south = new South();
			south.appendChild(pane);
			if (!Util.isEmpty(height)) {
				south.setHeight(height);
			}
			borderlayout.appendChild(south);
		}
	}
	
	public void removeRefreshButton() {
		if (btnRefresh != null) {
			btnRefresh.detach();
			btnRefresh = null;
		}
	}
}	//	WSchedule
