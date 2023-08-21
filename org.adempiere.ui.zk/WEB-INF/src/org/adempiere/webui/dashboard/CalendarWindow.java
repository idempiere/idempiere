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

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TimeZone;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_R_RequestType;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.encoders.EncoderUtil;
import org.jfree.chart.encoders.ImageFormat;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;
import org.zkoss.calendar.Calendars;
import org.zkoss.calendar.api.CalendarEvent;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.calendar.impl.SimpleCalendarEvent;
import org.zkoss.calendar.impl.SimpleCalendarModel;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Button;
import org.zkoss.zul.Image;
import org.zkoss.zul.Label;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Span;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Timer;
import org.zkoss.zul.Toolbarbutton;

/**
 * Calendar window
 * @author Elaine
 */
public class CalendarWindow extends Window implements EventListener<Event>, ITabOnCloseHandler {	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1576992746053720647L;
	private static final String ON_MOBILE_SET_SELECTED_TAB_ECHO = "onMobileSetSelectedTabEcho";
	private static final String ON_MOVE_DATE_EVENT = "onMoveDate";
	private static final String ON_UPDATE_VIEW_EVENT = "onUpdateView";
	private static final String ON_MOUSE_OVER_EVENT = "onMouseOver";
	private static final String ON_EVENT_UPDATE_EVENT = "onEventUpdate";
	private static final String ON_EVENT_EDIT_EVENT = "onEventEdit";
	private static final String ON_EVENT_CREATE_EVENT = "onEventCreate";
	
	/** Zk Calendar instance. Center of window. */
	private Calendars calendars;
	/** Calendar model for {@link #calendars} */
	private SimpleCalendarModel scm;
	/** Re-query button */
	private Toolbarbutton btnRefresh;
	/** List of request types */
	private Listbox lbxRequestTypes;
	/** Pie chart for calendar events. South of window. */
	private Image myChart;
	private Button btnCurrentDate, btnSwitchTimeZone;
	/** Label for start and end date of current Calendar view */
	private Label lblDate;
	/** button to move Calendar to previous or next page */
	private Component divArrowLeft, divArrowRight;
	private Span FDOW;
	/** List to select first day of a week (monday, tuesday, etc). Visible for week and month view. */
	private Listbox lbxFDOW;
	/** Tab for Day, Week, 5Day and Month view */
	private Component divTabDay, divTabWeek, divTabWeekdays, divTabMonth;
	/** Message Popup */
	private Popup updateMsg;
	/** Content of {@link #updateMsg} */
	private	Label popupLabel;
	/** Timer to close {@link #updateMsg} */
	private Timer timer;
	
	/** Window for event */
	private EventWindow eventWin;
	
	/**
	 * Create window content from "zul/calendar/calendar.zul"
	 * @param scm SimpleCalendarModel
	 */
	public CalendarWindow(SimpleCalendarModel scm) {

		super();
		
		this.scm = scm;
		Properties ctx = Env.getCtx();
		setTitle(Msg.getMsg(ctx,"Calendar"));
		setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
		
		Component component = Executions.createComponents(ThemeManager.getThemeResource("zul/calendar/calendar.zul"), this, null);

		Borderlayout borderlayout = (Borderlayout) component.getFellow("main");
		borderlayout.setStyle("position: relative");
		ZKUpdateUtil.setWidth(borderlayout, "100%");
		ZKUpdateUtil.setHeight(borderlayout, "100%");

		calendars = (Calendars) component.getFellow("cal");
		calendars.setModel(scm);
		if (calendars.getCurrentDate() != null)
			calendars.setCurrentDate(calendars.getCurrentDate());
		setTimeZone();

		btnRefresh = (Toolbarbutton) component.getFellow("btnRefresh");
		btnRefresh.addEventListener(Events.ON_CLICK, this);
		
		lbxRequestTypes = (Listbox) component.getFellow("lbxRequestTypes");
		lbxRequestTypes.addEventListener(Events.ON_SELECT, this);
		
		lbxRequestTypes.appendItem(Msg.getMsg(ctx,"ShowAll"), "0");
		ArrayList<X_R_RequestType> types = DPCalendar.getRequestTypes(Env.getCtx());
		for(X_R_RequestType type : types)
			lbxRequestTypes.appendItem(type.getName(), type.getR_RequestType_ID() + "");
		lbxRequestTypes.setSelectedIndex(0);
		
		myChart = (Image) component.getFellow("mychart");
		myChart.addEventListener(Events.ON_CREATE, this);
		
		btnCurrentDate = (Button) component.getFellow("btnCurrentDate");
		btnCurrentDate.addEventListener(Events.ON_CLICK, this);
		
		btnSwitchTimeZone = (Button) component.getFellow("btnSwitchTimeZone");
		btnSwitchTimeZone.addEventListener(Events.ON_CLICK, this);
		String alternateTimeZone = MSysConfig.getValue(MSysConfig.CALENDAR_ALTERNATE_TIMEZONE, "Pacific Time=PST", Env.getAD_Client_ID(Env.getCtx()));
		if (Util.isEmpty(alternateTimeZone, true))
			btnSwitchTimeZone.setVisible(false);

		
		lblDate = (Label) component.getFellow("lblDate");
		lblDate.addEventListener(Events.ON_CREATE, this);
		
		divArrowLeft = component.getFellow("divArrowLeft");
		divArrowLeft.addEventListener(ON_MOVE_DATE_EVENT, this);
		
		divArrowRight = component.getFellow("divArrowRight");
		divArrowRight.addEventListener(ON_MOVE_DATE_EVENT, this);
		
		FDOW = (Span) component.getFellow("FDOW");
		FDOW.addEventListener(Events.ON_CREATE, this);

		lbxFDOW = (Listbox) component.getFellow("lbxFDOW");
		lbxFDOW.addEventListener(Events.ON_SELECT, this);
		lbxFDOW.addEventListener(Events.ON_CREATE, this);
		
		String[] days = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"};
		for (String day : days) {
			lbxFDOW.appendItem(Msg.getMsg(Env.getCtx(),day), day);
		}
		
		divTabDay = component.getFellow("divTabDay");
		divTabDay.addEventListener(ON_UPDATE_VIEW_EVENT, this);
		
		divTabWeek = component.getFellow("divTabWeek");
		divTabWeek.addEventListener(ON_UPDATE_VIEW_EVENT, this);
		
		divTabWeekdays = component.getFellow("divTabWeekdays");
		divTabWeekdays.addEventListener(ON_UPDATE_VIEW_EVENT, this);
		
		divTabMonth = component.getFellow("divTabMonth");
		divTabMonth.addEventListener(ON_UPDATE_VIEW_EVENT, this);
		
		updateMsg = (Popup) component.getFellow("updateMsg");
		
		popupLabel = (Label) component.getFellow("popupLabel");
		
		timer = (Timer) component.getFellow("timer");
		
		this.appendChild(component);

		calendars.addEventListener(ON_EVENT_CREATE_EVENT, this);
		calendars.addEventListener(ON_EVENT_EDIT_EVENT, this);
		calendars.addEventListener(ON_EVENT_UPDATE_EVENT, this);
		calendars.addEventListener(ON_MOUSE_OVER_EVENT, this);

		if (ClientInfo.isMobile()) {
			addCallback(AFTER_PAGE_ATTACHED, t -> afterPageAttached());
			addEventListener(ON_MOBILE_SET_SELECTED_TAB_ECHO, evt -> calendars.invalidate());
		}
		
		SessionManager.getAppDesktop().showWindow(this);

		// IDEMPIERE-1457: when show this window on tab, handle event close to remove calendars away scm
		Component parentTab = this.getParent();
		if (parentTab != null && parentTab.getClass().equals(Tabpanel.class)) {
			((Tabpanel)parentTab).setOnCloseHandler(this);
		}				
	}

	/**
	 * After page attached callback for mobile client. <br/>
	 * Setup listener for {@link WindowContainer#ON_MOBILE_SET_SELECTED_TAB} event.
	 */
	private void afterPageAttached() {
		Component p = getParent();
		while (p != null) {
			if (p instanceof Tabpanel) {
				p.addEventListener(WindowContainer.ON_MOBILE_SET_SELECTED_TAB, evt -> onMobileSelected());
				break;
			}
			p = p.getParent();
		}
	}

	/**
	 * {@link WindowContainer#ON_MOBILE_SET_SELECTED_TAB} event.<br/>
	 * Echo {@link #ON_MOBILE_SET_SELECTED_TAB_ECHO} event to redraw {@link #calendars}.
	 */
	private void onMobileSelected() {
		Events.echoEvent(ON_MOBILE_SET_SELECTED_TAB_ECHO, this, null);
	}

	@Override
	public void onClose(Tabpanel tabPanel){
		//IDEMPIERE-1457: On close, remove calendars away scm			
		calendars.setModel(null);
		Tab tab = tabPanel.getLinkedTab();
		tab.close();
	}

	@Override
	public void onEvent(Event e) throws Exception {
		String type = e.getName();

		if (type.equals(Events.ON_CLICK)) {
			if (e.getTarget() == btnRefresh)
				btnRefreshClicked();
			else if (e.getTarget() == btnCurrentDate)
				btnCurrentDateClicked();
			else if (e.getTarget() == btnSwitchTimeZone)
				btnSwitchTimeZoneClicked();
		}
		else if (type.equals(Events.ON_CREATE)) {
			if (e.getTarget() == lblDate)
				updateDateLabel();
			else if (e.getTarget() == FDOW)
				FDOW.setVisible("month".equals(calendars.getMold()) || calendars.getDays() == 7);
			else if (e.getTarget() == myChart)
				syncModel();
			else if (e.getTarget() == lbxFDOW)
				lbxFDOW.setSelectedIndex(0);
		}
		else if (type.equals(ON_MOVE_DATE_EVENT)) {
			if (e.getTarget() == divArrowLeft)
				divArrowClicked(false);
			else if (e.getTarget() == divArrowRight)
				divArrowClicked(true);
		}
		else if (type.equals(ON_UPDATE_VIEW_EVENT)) {
			String text = String.valueOf(e.getData());
			int days = Msg.getMsg(Env.getCtx(),"Day").equals(text) ? 1: Msg.getMsg(Env.getCtx(),"5Days").equals(text) ? 5: Msg.getMsg(Env.getCtx(),"Week").equals(text) ? 7: 0;
			divTabClicked(days);
		}
		else if (type.equals(Events.ON_SELECT)) {
			if (e.getTarget() == lbxRequestTypes) {
				Listitem li = lbxRequestTypes.getSelectedItem();
				if(li == null) return;
				
				if(li.getValue() == null) return;
				int R_RequestType_ID = Integer.parseInt(li.getValue().toString());
				
				scm.clear();
				ArrayList<ADCalendarEvent> events = DPCalendar.getEvents(R_RequestType_ID, Env.getCtx());
				for (ADCalendarEvent event : events)
					scm.add(event);

				calendars.invalidate();
				syncModel();
			}
			else if (e.getTarget() == lbxFDOW) {
				calendars.setFirstDayOfWeek(lbxFDOW.getSelectedItem().getValue().toString());
				syncModel();
			}
		}
		else if (type.equals(ON_EVENT_CREATE_EVENT)) {
			if (e instanceof CalendarsEvent) {
				CalendarsEvent calendarsEvent = (CalendarsEvent) e;
				RequestWindow requestWin = new RequestWindow(calendarsEvent, this);
				SessionManager.getAppDesktop().showWindow(requestWin);
			}
		}	
		else if (type.equals(ON_EVENT_EDIT_EVENT)) {
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
		else if (type.equals(ON_EVENT_UPDATE_EVENT)) {
			if (e instanceof CalendarsEvent)
			{
				CalendarsEvent evt = (CalendarsEvent) e;
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/d");
				sdf1.setTimeZone(calendars.getDefaultTimeZone());
				StringBuilder sb = new StringBuilder("Update... from ");
				sb.append(sdf1.format(evt.getCalendarEvent().getBeginDate()));
				sb.append(" to ");
				sb.append(sdf1.format(evt.getBeginDate()));
				popupLabel.setValue(sb.toString());
				int left = evt.getX();
				int top = evt.getY();
				if (top + 100 > evt.getDesktopHeight())
					top = evt.getDesktopHeight() - 100;
				if (left + 330 > evt.getDesktopWidth())
					left = evt.getDesktopWidth() - 330;
				updateMsg.open(left, top);
				timer.start();
				org.zkoss.calendar.Calendars cal = (org.zkoss.calendar.Calendars) evt.getTarget();
				SimpleCalendarModel m = (SimpleCalendarModel) cal.getModel();
				SimpleCalendarEvent sce = (SimpleCalendarEvent) evt.getCalendarEvent();
				sce.setBeginDate(evt.getBeginDate());
				sce.setEndDate(evt.getEndDate());
				m.update(sce);
			}
		}
	}
	
	/**
	 * Update {@link #myChart}
	 */
	private void syncModel() {
		Hashtable<String,BigDecimal> ht = new Hashtable<String,BigDecimal>();
		
		List<?> list = calendars.getModel().get(calendars.getBeginDate(), calendars.getEndDate(), null);
		int size = list.size();
		for (Iterator<?> it = list.iterator(); it.hasNext();) {
			String key = ((ADCalendarEvent)it.next()).getR_RequestType_ID() + "";
					
			if (!ht.containsKey(key))
				ht.put(key, BigDecimal.ONE);
			else {
				BigDecimal value = ht.get(key);
				ht.put(key, value.add(BigDecimal.ONE));
			}
		}
		
		Hashtable<Object, String> htTypes = new Hashtable<Object, String>();
		for(int i = 0; i < lbxRequestTypes.getItemCount(); i++)
		{
			Listitem li = lbxRequestTypes.getItemAtIndex(i);
			if(li != null && li.getValue() != null)
				htTypes.put(li.getValue(), li.getLabel());
		}
		
		DefaultPieDataset pieDataset = new DefaultPieDataset();
		Enumeration<?> keys = ht.keys();
		while(keys.hasMoreElements()) {
			String key = (String) keys.nextElement();
			BigDecimal value = ht.get(key);
			String name = (String) htTypes.get(key);
			pieDataset.setValue(name == null ? "" : name, Double.valueOf(size > 0 ? value.doubleValue()/size*100 : 0));
		}
		
		//TODO replace with billboard chart
		JFreeChart chart = ChartFactory.createPieChart(Msg.getMsg(Env.getCtx(),"EventsAnalysis"), pieDataset, true, true, true);
		PiePlot plot = (PiePlot) chart.getPlot(); 
		plot.setForegroundAlpha(0.5f);
		BufferedImage bi = chart.createBufferedImage(600, 250);
		try {
			byte[] bytes = EncoderUtil.encode(bi, ImageFormat.PNG, true);
			AImage image = new AImage("Pie Chart", bytes);
			myChart.setContent(image);
		} catch (IOException e) {
			e.printStackTrace();
		}		
		htTypes = null;
		ht = null;
	}
	
	/**
	 * Refresh model and UI
	 */
	public void onRefresh() {
		btnRefreshClicked();
	}
	
	/**
	 * Refresh model and UI
	 */
	private void btnRefreshClicked() {
		int R_RequestType_ID = 0;
		Listitem li = lbxRequestTypes.getSelectedItem();
		if(li != null && li.getValue() != null)
			R_RequestType_ID = Integer.parseInt(li.getValue().toString());
		
		int cnt = lbxRequestTypes.getItemCount();
		for (int i = cnt - 1; i >=0; i--)
			lbxRequestTypes.removeItemAt(i);
		
		lbxRequestTypes.appendItem(Msg.getMsg(Env.getCtx(),"ShowAll"), "0");
		ArrayList<X_R_RequestType> types = DPCalendar.getRequestTypes(Env.getCtx());
		for(X_R_RequestType requestType : types)
		{
			Listitem item = lbxRequestTypes.appendItem(requestType.getName(), requestType.getR_RequestType_ID() + "");
			if(R_RequestType_ID == requestType.getR_RequestType_ID())
				lbxRequestTypes.setSelectedItem(item);
		}
		if(lbxRequestTypes.getSelectedIndex() < 0)
			lbxRequestTypes.setSelectedIndex(0);
		
		scm.clear();
		ArrayList<ADCalendarEvent> events = DPCalendar.getEvents(R_RequestType_ID, Env.getCtx());
		for (ADCalendarEvent event : events)
			scm.add(event);

		calendars.invalidate();
		syncModel();
	}
	
	/**
	 * Set time zone of {@link #calendars}
	 */
	private void setTimeZone()
	{
		String alternateTimeZone = MSysConfig.getValue(MSysConfig.CALENDAR_ALTERNATE_TIMEZONE, "Pacific Time=PST", Env.getAD_Client_ID(Env.getCtx()));
		TimeZone defaultTimeZone = TimeZone.getDefault();
		calendars.addTimeZone (defaultTimeZone.getDisplayName(), defaultTimeZone);
		if (!Util.isEmpty(alternateTimeZone, true)) {
			if (!alternateTimeZone.equalsIgnoreCase(defaultTimeZone.getDisplayName())) {
				String[] pair = alternateTimeZone.split("=");
				calendars.addTimeZone(pair[0].trim(), pair[1].trim());
			}
		}
	}
	
	/**
	 * Update {@link #lblDate}
	 */
	private void updateDateLabel() {
		Date b = calendars.getBeginDate();
		Date e = calendars.getEndDate();
		SimpleDateFormat sdfV = DisplayType.getDateFormat();
		sdfV.setTimeZone(calendars.getDefaultTimeZone());
		lblDate.setValue(sdfV.format(b) + " - " + sdfV.format(e));
	}
	
	/**
	 * Set {@link #calendars} to current date
	 */
	private void btnCurrentDateClicked() {
		calendars.setCurrentDate(Calendar.getInstance(calendars.getDefaultTimeZone()).getTime());
		updateDateLabel();
		syncModel();
	}
	
	/**
	 * Change {@link #calendars} time zone
	 */
	private void btnSwitchTimeZoneClicked() {
		Map<?, ?> zone = calendars.getTimeZones();
		if (!zone.isEmpty()) {
			@SuppressWarnings("unchecked")
			Map.Entry<TimeZone, String> me = (Map.Entry<TimeZone, String>) zone.entrySet().iterator().next();
			calendars.removeTimeZone((TimeZone) me.getKey());
			calendars.addTimeZone((String) me.getValue(), (TimeZone) me.getKey());
		}
		syncModel();
	}

	/**
	 * Move {@link #calendars} to next or previous page
	 * @param isNext true for next page, false for previous page
	 */
	private void divArrowClicked(boolean isNext) {
		if (isNext)
			calendars.nextPage();
		else
			calendars.previousPage();
		updateDateLabel();
		syncModel();
	}
	
	/**
	 * On switching of calendar view (Days, Weeks, etc)
	 * @param days
	 */
	private void divTabClicked(int days) {		
		if (days > 0) {
			calendars.setMold("default");
			calendars.setDays(days);
		} else calendars.setMold("month");
		updateDateLabel();
		FDOW.setVisible("month".equals(calendars.getMold()) || calendars.getDays() == 7);
	}
}
