/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation                                     *
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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.adempiere.webui.session.SessionManager;
import org.compiere.model.X_R_RequestType;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.zkoss.calendar.Calendars;
import org.zkoss.calendar.api.CalendarEvent;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.calendar.impl.SimpleCalendarModel;
import org.zkoss.util.Locales;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Button;
import org.zkoss.zul.Label;
import org.zkoss.zul.Toolbarbutton;

/**
 * Dashboard item: ZK calendar
 * 
 * @author Elaine
 * @date November 20, 2008
 */
public class DPCalendar extends DashboardPanel implements EventListener<Event> {


	/**
	 * 
	 */
	private static final long serialVersionUID = -224914882522997787L;
	private Calendars calendars;
	private SimpleCalendarModel scm;
	private Toolbarbutton btnCal, btnRefresh;
	private Button btnCurrentDate;
	private Label lblDate;
	private Component divArrowLeft, divArrowRight;
	
	private EventWindow eventWin;

	public DPCalendar() {
		super();

		scm = new SimpleCalendarModel();
		ArrayList<ADCalendarEvent> events = getEvents(0);
		for (ADCalendarEvent event : events)
			scm.add(event);

		Component component = Executions.createComponents("calendar_mini.zul", this, null);

		calendars = (Calendars) component.getFellow("cal");
		calendars.setModel(scm);

		btnCal = (Toolbarbutton) component.getFellow("btnCal");
		btnCal.addEventListener(Events.ON_CLICK, this);
		
		btnRefresh = (Toolbarbutton) component.getFellow("btnRefresh");
		btnRefresh.addEventListener(Events.ON_CLICK, this);
		
		btnCurrentDate = (Button) component.getFellow("btnCurrentDate");
		btnCurrentDate.addEventListener(Events.ON_CLICK, this);
		
		lblDate = (Label) component.getFellow("lblDate");
		lblDate.addEventListener(Events.ON_CREATE, this);
		
		divArrowLeft = component.getFellow("divArrowLeft");
		divArrowLeft.addEventListener("onMoveDate", this);
		
		divArrowRight = component.getFellow("divArrowRight");
		divArrowRight.addEventListener("onMoveDate", this);
		
		this.appendChild(component);

		calendars.addEventListener("onEventCreate", this);
		calendars.addEventListener("onEventEdit", this);	
	}

	public void onEvent(Event e) throws Exception {
		String type = e.getName();

		if (type.equals(Events.ON_CLICK)) {
			if (e.getTarget() == btnCal)
				new CalendarWindow(scm);
			else if (e.getTarget() == btnRefresh)
				btnRefreshClicked();
			else if (e.getTarget() == btnCurrentDate)
				btnCurrentDateClicked();
		}
		else if (type.equals(Events.ON_CREATE)) {
			if (e.getTarget() == lblDate)
				updateDateLabel();
		}
		else if (type.equals("onMoveDate")) {
			if (e.getTarget() == divArrowLeft)
				divArrowClicked(false);
			else if (e.getTarget() == divArrowRight)
				divArrowClicked(true);
		}
		else if (type.equals("onEventCreate")) {
			if (e instanceof CalendarsEvent) {
				CalendarsEvent calendarsEvent = (CalendarsEvent) e;
				RequestWindow requestWin = new RequestWindow(calendarsEvent, this);
				SessionManager.getAppDesktop().showWindow(requestWin);
			}
		}	
		else if (type.equals("onEventEdit")) {
			if (e instanceof CalendarsEvent) {
				CalendarsEvent calendarsEvent = (CalendarsEvent) e;
				CalendarEvent calendarEvent = calendarsEvent.getCalendarEvent();

				if (calendarEvent instanceof ADCalendarEvent) {
					ADCalendarEvent ce = (ADCalendarEvent) calendarEvent;
					
					if(eventWin == null)
						eventWin = new EventWindow();
					eventWin.setData(ce);
					SessionManager.getAppDesktop().showWindow(eventWin);
				}
			}
		}		
	}
	
	public static ArrayList<ADCalendarEvent> getEvents(int RequestTypeID) {
		ArrayList<ADCalendarEvent> events = new ArrayList<ADCalendarEvent>();
		String sql = "SELECT DISTINCT r.R_Request_ID, r.DateNextAction, "
				+ "r.DateStartPlan, r.DateCompletePlan, r.StartTime, r.EndTime, "
				+ "r.Summary, rt.HeaderColor, rt.ContentColor, rt.R_RequestType_ID "
				+ "FROM R_Request r, R_RequestType rt "
				+ "WHERE r.R_RequestType_ID = rt.R_RequestType_ID "
				+ "AND (r.SalesRep_ID = ? OR r.AD_User_ID = ? OR r.CreatedBy = ?) "
				+ "AND r.AD_Client_ID = ? AND r.IsActive = 'Y' "
				+ "AND (r.R_Status_ID IS NULL OR r.R_Status_ID IN (SELECT R_Status_ID FROM R_Status WHERE IsClosed='N')) ";
		if(RequestTypeID > 0)
			sql += "AND rt.R_RequestType_ID = ? ";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = DB.prepareStatement(sql, null);

			ps.setInt(1, Env.getAD_User_ID(Env.getCtx()));
			ps.setInt(2, Env.getAD_User_ID(Env.getCtx()));
			ps.setInt(3, Env.getAD_User_ID(Env.getCtx()));
			ps.setInt(4, Env.getAD_Client_ID(Env.getCtx()));
			if(RequestTypeID > 0)
				ps.setInt(5, RequestTypeID);

			rs = ps.executeQuery();

			while (rs.next()) {
				int R_Request_ID = rs.getInt("R_Request_ID");
				Date dateNextAction = rs.getDate("DateNextAction");
				Date dateStartPlan = rs.getDate("DateStartPlan");
				Date dateCompletePlan = rs.getDate("DateCompletePlan");
				Timestamp startTime = rs.getTimestamp("StartTime");
				Timestamp endTime = rs.getTimestamp("EndTime");
				String summary = rs.getString("Summary");
				String headerColor = rs.getString("HeaderColor");
				String contentColor = rs.getString("ContentColor");
				int R_RequestType_ID = rs.getInt("R_RequestType_ID");

				if (dateNextAction != null) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(dateNextAction);

					ADCalendarEvent event = new ADCalendarEvent();
					event.setR_Request_ID(R_Request_ID);

					cal.set(Calendar.HOUR_OF_DAY, 0);
					cal.set(Calendar.MINUTE, 0);
					cal.set(Calendar.SECOND, 0);
					cal.set(Calendar.MILLISECOND, 0);
					event.setBeginDate(cal.getTime());
					
					cal.add(Calendar.HOUR_OF_DAY, 24);
					event.setEndDate(cal.getTime());

					event.setContent(summary);
					event.setHeaderColor(headerColor);
					event.setContentColor(contentColor);
					event.setR_RequestType_ID(R_RequestType_ID);
					event.setLocked(true);
					events.add(event);
				}

				if (dateStartPlan != null && dateCompletePlan != null) {
					
					boolean isBeginFullDay = false;
					boolean isEndFullDay = false;
					
					Calendar calBegin = Calendar.getInstance();
					calBegin.setTime(dateStartPlan);
					if (startTime != null) {
						Calendar cal1 = Calendar.getInstance();
						cal1.setTimeInMillis(startTime.getTime());
						calBegin.set(Calendar.HOUR_OF_DAY, cal1.get(Calendar.HOUR_OF_DAY));
						calBegin.set(Calendar.MINUTE, cal1.get(Calendar.MINUTE));
						calBegin.set(Calendar.SECOND, 0);
						calBegin.set(Calendar.MILLISECOND, 0);
						
						if(calBegin.get(Calendar.HOUR_OF_DAY) == 0 && calBegin.get(Calendar.MINUTE) == 0)
							isBeginFullDay = true;
					} else {
						calBegin.set(Calendar.HOUR_OF_DAY, 0);
						calBegin.set(Calendar.MINUTE, 0);
						calBegin.set(Calendar.SECOND, 0);
						calBegin.set(Calendar.MILLISECOND, 0);
						isBeginFullDay = true;
					}
					
					Calendar calEnd = Calendar.getInstance();
					calEnd.setTime(dateStartPlan);
					if (endTime != null) {
						Calendar cal1 = Calendar.getInstance();
						cal1.setTimeInMillis(endTime.getTime());
						calEnd.set(Calendar.HOUR_OF_DAY, cal1.get(Calendar.HOUR_OF_DAY));
						calEnd.set(Calendar.MINUTE, cal1.get(Calendar.MINUTE));
						calEnd.set(Calendar.SECOND, 0);
						calEnd.set(Calendar.MILLISECOND, 0);
						
						if(calEnd.get(Calendar.HOUR_OF_DAY) == 0 && calEnd.get(Calendar.MINUTE) == 0)
							isEndFullDay = true;
					} else {
						calEnd.add(Calendar.HOUR_OF_DAY, 24);
						isEndFullDay = true;
					}
					
					Calendar cal = Calendar.getInstance();
					cal.setTime(dateCompletePlan);
					if (endTime != null) {
						Calendar cal1 = Calendar.getInstance();
						cal1.setTimeInMillis(endTime.getTime());
						cal.set(Calendar.HOUR_OF_DAY, cal1.get(Calendar.HOUR_OF_DAY));
						cal.set(Calendar.MINUTE, cal1.get(Calendar.MINUTE));
						cal.set(Calendar.SECOND, 0);
						cal.set(Calendar.MILLISECOND, 0);
					} else {
						cal.add(Calendar.HOUR_OF_DAY, 24);	
					}
					dateCompletePlan.setTime(cal.getTimeInMillis());
					
					if(isBeginFullDay && isEndFullDay)
					{
						ADCalendarEvent event = new ADCalendarEvent();
						event.setR_Request_ID(R_Request_ID);
						
						event.setBeginDate(calBegin.getTime());
						event.setEndDate(cal.getTime());
						
						if(event.getBeginDate().compareTo(event.getEndDate()) >= 0)
							continue;

						event.setContent(summary);
						event.setHeaderColor(headerColor);
						event.setContentColor(contentColor);
						event.setR_RequestType_ID(R_RequestType_ID);
						event.setLocked(true);
						events.add(event);
					}
					else
					{
						for(; calBegin.getTime().compareTo(dateCompletePlan) <= 0; calBegin.add(Calendar.DATE, 1), calEnd.add(Calendar.DATE, 1))
						{
							ADCalendarEvent event = new ADCalendarEvent();
							event.setR_Request_ID(R_Request_ID);
							
							event.setBeginDate(calBegin.getTime());
							event.setEndDate(calEnd.getTime());
							
							if(event.getBeginDate().compareTo(event.getEndDate()) >= 0)
								continue;
	
							event.setContent(summary);
							event.setHeaderColor(headerColor);
							event.setContentColor(contentColor);
							event.setR_RequestType_ID(R_RequestType_ID);
							event.setLocked(true);
							events.add(event);
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(rs, ps);
		}

		return events;
	}
	
	public static ArrayList<X_R_RequestType> getRequestTypes() {
		ArrayList<X_R_RequestType> types = new ArrayList<X_R_RequestType>();
		String sql = "SELECT * "
				+ "FROM R_RequestType "
				+ "WHERE AD_Client_ID = ? AND IsActive = 'Y' "
				+ "ORDER BY Name";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = DB.prepareStatement(sql, null);
			ps.setInt(1, Env.getAD_Client_ID(Env.getCtx()));

			rs = ps.executeQuery();

			while (rs.next()) {
				types.add(new X_R_RequestType(Env.getCtx(), rs, null));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(rs, ps);
		}
		
		return types;
	}
	
	public void onRefresh() {
		btnRefreshClicked();
	}
	
	private void btnRefreshClicked() {
		scm.clear();
		ArrayList<ADCalendarEvent> events = getEvents(0);
		for (ADCalendarEvent event : events)
			scm.add(event);
		calendars.setModel(scm);
		calendars.invalidate();
	}
	
	private void updateDateLabel() {
		Date b = calendars.getBeginDate();
		Date e = calendars.getEndDate();
		SimpleDateFormat sdfV = new SimpleDateFormat("yyyy/MMM/dd", Locales.getCurrent());
		sdfV.setTimeZone(calendars.getDefaultTimeZone());
		lblDate.setValue(sdfV.format(b) + " - " + sdfV.format(e));
	}
	
	private void btnCurrentDateClicked() {
		calendars.setCurrentDate(Calendar.getInstance(calendars.getDefaultTimeZone()).getTime());
		updateDateLabel();
	}

	private void divArrowClicked(boolean isNext) {
		if (isNext)
			calendars.nextPage();
		else
			calendars.previousPage();
		updateDateLabel();
	}
}
