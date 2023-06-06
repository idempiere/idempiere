/**********************************************************************
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
*                                                                     *
* Contributors:                                                       *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.adempiere.webui.window;

import static org.compiere.model.SystemIDs.REFERENCE_DATESELECTIONMODE;
import static org.compiere.model.SystemIDs.REFERENCE_MONTHS;
import static org.compiere.model.SystemIDs.REFERENCE_QUARTERS;
import static org.compiere.model.SystemIDs.REFERENCE_TIMEUNIT;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.concurrent.TimeUnit;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ComboItem;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.factory.ButtonFactory;
import org.compiere.model.MChart;
import org.compiere.model.MRefList;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zhtml.Br;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Div;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Spinner;

/**
*
* @author Peter Takacs, Cloudempiere
*
*/
public class DateRangePicker extends Popup implements EventListener<Event>, ValueChangeListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1674676283499219325L;
	
	// AD_Reference_ID
	private static final String DATESELECTIONMODE_PREVIOUS = "01";
	private static final String DATESELECTIONMODE_NEXT = "02";
	private static final String DATESELECTIONMODE_CURRENT = "03";
    private static final String DATESELECTIONMODE_BEFORE = "04";
    private static final String DATESELECTIONMODE_AFTER = "05";
    private static final String DATESELECTIONMODE_ON = "06";
	private static final String DATESELECTIONMODE_BETWEEN = "07";
	private static final String DATESELECTIONMODE_QUICK = "08";
	
	private Button okBtn;
	private Combobox modeCombobox;
	private Spinner numberBox;
	private Combobox unitCombobox;
	private Textbox dateTextBox;
	private org.zkoss.zul.Calendar cal;
	private org.zkoss.zul.Calendar cal2;
	private Div quickListBoxes;
	private Tabbox tabbox;
	private Tabs tabs;
	private Tabpanels tabpanels;
	private Tab fromTab;
	private Tab toTab;
	private Tabpanel fromTabPanel;
	private Tabpanel toTabPanel;
	private Div midDiv;
	
	/** date editor from **/
	private WEditor editor;
	/** date editor to **/
	private WEditor editor2;
	/** value of date from **/
	private Date dateFrom;
	/** value of date to **/
	private Date dateTo;
	/** current/new display value **/
	private String displayValue;
	/** old display value **/
	private String oldDisplayValue = "";
	/** if true, react to value change event from {@link #editor} and {@link #editor2} **/
	private boolean enableValueChange = true;
	/** is mobile version **/
	private boolean isMobile = ClientInfo.isMobile() && ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1);

	/** registered value change listeners **/
	protected ArrayList<ValueChangeListener> listeners = new ArrayList<ValueChangeListener>();
	/** rendered list boxes on 'Quick' mode **/
	private ArrayList<Listbox> quickListBoxesArray = new ArrayList<Listbox>();
	/** selected list item from the list boxes on 'Quick' mode **/
	private ListItem selectedQuickListItem;
	
    /**
     * Constructor
     */
	public DateRangePicker(WEditor editor, WEditor editor2) {
		super();
		
		this.editor = editor;
		this.editor2 = editor2;
		init();
	}

	private void init() {
		
		editor.addValueChangeListener(this);
		editor2.addValueChangeListener(this);
		
		Div div = new Div();
		okBtn = ButtonFactory.createNamedButton("ApplyFilter", true, false);

		modeCombobox = new Combobox();
		modeCombobox.setSclass("date-picker-component");
		modeCombobox.setWidth("120px");
		modeCombobox.addEventListener(Events.ON_SELECT, this);
		
		numberBox = new Spinner(1);
		numberBox.setConstraint("no empty, min 1");
		numberBox.setSclass("date-picker-component");
		numberBox.addEventListener(Events.ON_CHANGING, this);

		unitCombobox = new Combobox();
		unitCombobox.setSclass("date-picker-component");
		unitCombobox.setWidth("90px");
		unitCombobox.addEventListener(Events.ON_SELECT, this);
		
		// Tabs visible on "Between" mode, mobile screen
		tabbox = new Tabbox();
		tabs = new Tabs();
		tabbox.appendChild(tabs);
		tabpanels = new Tabpanels();
		tabbox.appendChild(tabpanels);

		fromTab = new Tab(Msg.getMsg(Env.getCtx(), "From"));
		tabs.appendChild(fromTab);
		toTab = new Tab(Msg.getMsg(Env.getCtx(), "To"));
		tabs.appendChild(toTab);
		
		fromTabPanel = new Tabpanel();
		toTabPanel = new Tabpanel();
		tabpanels.appendChild(fromTabPanel);
		tabpanels.appendChild(toTabPanel);
		
		cal = new org.zkoss.zul.Calendar();
		cal.setSclass("date-picker-component");
		cal.addEventListener(Events.ON_CHANGE, this);
		cal2 = new org.zkoss.zul.Calendar();
		cal2.setSclass("date-picker-component");
		cal2.addEventListener(Events.ON_CHANGE, this);
		
		Label dateTextBoxLabel = new Label(Msg.getMsg(Env.getCtx(), "SelectedTimeRange"));
		dateTextBoxLabel.setSclass("date-picker-label");
		
		dateTextBox = new Textbox();
		dateTextBox.setReadonly(true);
		dateTextBox.setSclass("date-picker-component");
		dateTextBox.setStyle("min-width: 170px; background: white !important");
		dateTextBox.setValue(DisplayType.getDateFormat().format(cal.getValue()));
		dateTextBox.addEventListener(Events.ON_CHANGE, this);
		
		okBtn.setSclass("date-picker-component");
		okBtn.addEventListener(Events.ON_CLICK, event -> {
			setDateTextBoxAndDisplayValue();
			if(dateFrom != null && dateTo != null && dateTo.before(dateFrom))
				throw new WrongValueException(dateTextBox, Msg.getMsg(Env.getCtx(), "EndDateAfterStartDate"));
			if(Util.isEmpty(dateTextBox.getValue())) {
				dateFrom = null;
				dateTo = null;
			}
			enableValueChange = false;
			editor.setValue(dateFrom);
			editor2.setValue(dateTo);
			fireValueChange(new ValueChangeEvent(this,"DateRangePicker",oldDisplayValue, displayValue));
			enableValueChange = true;
			this.detach();
		});
		
		quickListBoxes = new Div();
		quickListBoxes.appendChild(getQuickModeContent());
		
		// Load Modes to ListBox
		ValueNamePair[] modes = MRefList.getList(Env.getCtx(), REFERENCE_DATESELECTIONMODE, false, "Value");
		for(ValueNamePair mode : modes) {
			ComboItem item = new ComboItem(mode.getName(), mode.getValue());
			modeCombobox.appendChild(item);
		}
		if(isMobile) {
			// disable "Quick" mode
			modeCombobox.removeItemAt(modeCombobox.getItemCount()-1);
		}
		modeCombobox.setSelectedIndex(0);
		
		// Load Units to ListBox
		ValueNamePair[] units = MRefList.getList(Env.getCtx(), REFERENCE_TIMEUNIT, false);
		for(ValueNamePair timeUnit : units) {
			ComboItem item = new ComboItem(timeUnit.getName(), timeUnit.getValue());
			unitCombobox.appendChild(item);
		}
		unitCombobox.setSelectedIndex(0);
		
		div.setSclass("date-picker-container");
		div.appendChild(modeCombobox);
		if (isMobile) {
			ZkCssHelper.appendStyle(modeCombobox, "margin: 0px 5px 10px 0px !important;");
			div.appendChild(new Br());
		}
		div.appendChild(numberBox);
		
		div.appendChild(unitCombobox);
		this.appendChild(div);
		
		midDiv = new Div();
		midDiv.appendChild(tabbox);
		midDiv.setSclass("date-picker-container");
		midDiv.setStyle("Margin-top: 10px;");
		midDiv.appendChild(cal);
		midDiv.appendChild(cal2);
		midDiv.appendChild(quickListBoxes);
		this.appendChild(midDiv);
		
		div = new Div();
		div.setSclass("date-picker-container");
		div.setStyle("margin: 10px 0 10px 0;");
		div.appendChild(dateTextBoxLabel);
		div.appendChild(dateTextBox);		
		div.setSclass("date-picker-container");
		if (isMobile) {
			div.appendChild(new Br());
			ZkCssHelper.appendStyle(okBtn, "margin: 5px 5px 5px 0px !important;");
		}
		else {
			ZkCssHelper.appendStyle(okBtn, "float: right;");
		}
		div.appendChild(okBtn);
		this.appendChild(div);
		
		if(isMobile)
			this.setStyle("min-width: 350px;");
		else
			this.setStyle("min-width: 320px;");
		
		dateFrom = (Date) editor.getValue();
		dateTo = (Date) editor2.getValue();
 		if(dateFrom != null || dateTo != null) { // Set the picker to defined Default Logic
			Date[] dates = setTimesOnDates(dateFrom, dateTo);
			dateFrom = dates[0];
			dateTo = dates[1];
			loadPickerSelection();
 		}
 		else {
 			// If no Default Logic defined, set Current Month as selected range
 			setPickerSelection(DATESELECTIONMODE_CURRENT, MChart.TIMEUNIT_Month, 0);
 			Date[] dates = setTimesOnDates(dateFrom, dateTo);
			dateFrom = dates[0];
			dateTo = dates[1];
 		}
		updateUI();
	}

	private void setPickerSelection(String mode, String unit, int offset) {
		for(Comboitem item : modeCombobox.getItems()) {
			if(item.getValue().equals(mode))
				modeCombobox.setSelectedItem(item);
		}
		for(Comboitem item : unitCombobox.getItems()) {
			if(item.getValue().equals(unit))
				unitCombobox.setSelectedItem(item);
		}
		int numBoxValue = Math.abs(offset) >= 1 ? Math.abs(offset) : 1; 
		numberBox.setValue(numBoxValue);
		
		setDateTextBoxAndDisplayValue();
	}
	
	private void updateUI() {
		
		String selectedMode = modeCombobox.getSelectedItem().getValue().toString();
		
		if(selectedMode.equalsIgnoreCase(DATESELECTIONMODE_BETWEEN) && isMobile) {
			updateCal1AndCal2();
			cal.detach();
			fromTabPanel.appendChild(cal);
			cal2.detach();
			toTabPanel.appendChild(cal2);
		}
		else {
			cal.detach();
			midDiv.appendChild(cal);
			cal2.detach();
			midDiv.appendChild(cal2);
		}
		
		switch (selectedMode) {
		case DATESELECTIONMODE_AFTER:
		case DATESELECTIONMODE_BEFORE:
		case DATESELECTIONMODE_ON:
			tabbox.setVisible(false);
			numberBox.setVisible(false);
			unitCombobox.setVisible(false);
			cal.setVisible(true);
			cal2.setVisible(false);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_BETWEEN:
			tabbox.setVisible(isMobile);
			numberBox.setVisible(false);
			unitCombobox.setVisible(false);
			cal.setVisible(true);
			cal2.setVisible(true);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_CURRENT:
			tabbox.setVisible(false);
			numberBox.setVisible(false);
			unitCombobox.setVisible(true);
			cal.setVisible(false);
			cal2.setVisible(false);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_NEXT:
		case DATESELECTIONMODE_PREVIOUS:
			tabbox.setVisible(false);
			numberBox.setVisible(true);
			unitCombobox.setVisible(true);
			cal.setVisible(false);
			cal2.setVisible(false);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_QUICK:
			tabbox.setVisible(false);
			numberBox.setVisible(false);
			unitCombobox.setVisible(false);
			cal.setVisible(false);
			cal2.setVisible(false);
			quickListBoxes.setVisible(true);
			break;
		default:
			break;
		}
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		Component target = event.getTarget();
		if(target.equals(modeCombobox))
			updateUI();
		if(target instanceof Listbox) {
			for(Listbox listBox : quickListBoxesArray) {
				if(!target.equals(listBox))
					listBox.setSelectedItem(null);
				else
					selectedQuickListItem = listBox.getSelectedItem();
			}
		}
		if(target instanceof Spinner) {
			String actValue = String.valueOf(((InputEvent)event).getValue());
			if(!Util.isEmpty(actValue))
				numberBox.setValue(Integer.valueOf(actValue));
		}
		
		dateTextBox.clearErrorMessage();
		if(!Util.isEmpty(dateTextBox.getValue()) || !event.getTarget().equals(dateTextBox)) {
			setDateTextBoxAndDisplayValue();
		}
	}
	
	private void setDateTextBoxAndDisplayValue() {
		displayValue = "";
		String dateTextBoxValue = getDateTextBoxValue();
		dateTextBox.setValue(dateTextBoxValue);
		
		if(Util.isEmpty(displayValue))
			displayValue = dateTextBoxValue;
	}

	/**
	 * @return date range text, for e.g "01/01/2023 - 01/31/2023"
	 */
	public String getDateRangeText() {
		return dateTextBox.getValue();
	}

	private String getDateTextBoxValue() {
		String returnVal = "";
		Date[] dates;
		
		switch (modeCombobox.getSelectedItem().getValue().toString()) {
			case DATESELECTIONMODE_PREVIOUS:
			case DATESELECTIONMODE_NEXT:
			case DATESELECTIONMODE_CURRENT:
			case DATESELECTIONMODE_BEFORE:
			case DATESELECTIONMODE_AFTER:
			case DATESELECTIONMODE_ON:
				returnVal = getIntervalHumanReadable();
				break;
			case DATESELECTIONMODE_BETWEEN:
				returnVal = DisplayType.getDateFormat().format(cal.getValue()) + " - " + DisplayType.getDateFormat().format(cal2.getValue());
				dateFrom = new Timestamp(cal.getValue().getTime());
				dateTo = new Timestamp(cal2.getValue().getTime());
				dates = setTimesOnDates(dateFrom, dateTo);
				dateFrom = dates[0];
				dateTo = dates[1];
				break;
			case DATESELECTIONMODE_QUICK:
				if(selectedQuickListItem != null) {
					String unit = (String) selectedQuickListItem.getAttribute("TimeUnit");
					int offset = (int) selectedQuickListItem.getAttribute("Offset");
					Date dateFromAttr = (Date) selectedQuickListItem.getAttribute("DateFrom");
					dates = getInterval(unit, unit, offset, false, false, dateFromAttr);
					this.dateFrom = new Timestamp(dates[0].getTime());
					this.dateTo = new Timestamp(dates[1].getTime());
					dates = setTimesOnDates(this.dateFrom, this.dateTo);
					this.dateFrom = dates[0];
					this.dateTo = dates[1];
					returnVal = DisplayType.getDateFormat().format(this.dateFrom) + " - " + DisplayType.getDateFormat().format(this.dateTo);
				}
				break;
			default:
				throw new AdempiereException("InvalidDateSelectionMode");
		}
		return returnVal;
	}

	private void loadPickerSelection() {
		
		String detectedMode = null;
		String detectedUnit = null;
		int detectedOffset = 0;
		Timestamp today = new Timestamp(System.currentTimeMillis());
		today = new Timestamp(setTimesOnDates(today, null)[0].getTime());
		
		detectedMode = autodetectMode(today);
		if(detectedMode != null) {
			String[] arr = autodetectUnitAndCorrectMode(today, detectedMode);
			if(arr != null) {
				detectedUnit = arr[0];
				if(!Util.isEmpty(arr[1]))
					detectedMode = arr[1];
			}
		}
		
		if(!Util.isEmpty(detectedMode) && !Util.isEmpty(detectedUnit)) {
			detectedOffset = autodetectOffset(detectedMode, detectedUnit);
		}
		
		for(Comboitem item : modeCombobox.getItems()) {
			if(item.getValue().equals(detectedMode)) {
				modeCombobox.setSelectedItem(item);
				break;
			}
		}
		for(Comboitem item : unitCombobox.getItems()) {
			if(item.getValue().equals(detectedUnit)) {
				unitCombobox.setSelectedItem(item);
				break;
			}
		}
		int numBoxValue = Math.abs(detectedOffset) >= 1 ? Math.abs(detectedOffset) : 1; 
		numberBox.setValue(numBoxValue);
		updateCal1AndCal2();
		setDateTextBoxAndDisplayValue();
	}

	private void updateCal1AndCal2() {
		if(dateFrom == null) {
			cal.setValue(dateTo);
			cal2.setValue(dateTo);
		}
		else if(dateTo == null) {
			cal.setValue(dateFrom);
			cal2.setValue(dateFrom);
		}
		else {
			cal.setValue(dateFrom);
			cal2.setValue(dateTo);
		}
	}
	
	private String autodetectMode(Timestamp today) {
		Date d1 = dateFrom;
		Date d2 = dateTo;
		d1 = setTimesOnDates(d1, null)[0];
		d2 = setTimesOnDates(d2, null)[0];
		if(d1 != null && d2 == null)
			return DATESELECTIONMODE_AFTER;
		else if(d1 == null && d2 != null)
			return DATESELECTIONMODE_BEFORE;
		else if(d1.compareTo(d2) == 0)
			return DATESELECTIONMODE_ON;
		
		if(d1.after(d2))
			return null;
		
		if(d1.before(today)){
			if(d2.before(today))
				return DATESELECTIONMODE_PREVIOUS;
			else if(d2.after(today))
				return DATESELECTIONMODE_CURRENT;
			else
				return DATESELECTIONMODE_BETWEEN;
		}
		else if(d1.after(today)){
			return DATESELECTIONMODE_NEXT;
		}
		else
			return DATESELECTIONMODE_BETWEEN;
	}
	
	private String[] autodetectUnitAndCorrectMode(Timestamp today, String predictedMode) {
		// use case: modes Before, After, On - unit is not needed
		Date d1 = dateFrom;
		Date d2 = dateTo;
		d1 = setTimesOnDates(d1, null)[0];
		d2 = setTimesOnDates(d2, null)[0];
		if(d1 == null || d2 == null || (d1.compareTo(d2) == 0))
			return null;
		
		if(dateFrom.after(dateTo))
			return null;
		
		String detectedUnit = "";
		String correctedMode = predictedMode;
		Calendar calendar = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		Calendar calendar2 = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		Calendar calendarToday = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		Calendar testCalendar = (Calendar) calendarToday.clone();
		int timeUnit = 0;
		
		calendar.setTime(dateFrom);
		calendar2.setTime(dateTo);
		calendarToday.setTime(today);
		
		// check start and end day of periods
		if(calendar.get(Calendar.DAY_OF_YEAR) == 1 && 
				calendar2.get(Calendar.DAY_OF_YEAR) == calendar2.getActualMaximum(Calendar.DAY_OF_YEAR)) {
			detectedUnit = MChart.TIMEUNIT_Year;
			timeUnit = Calendar.YEAR;
		}
		else if(calendar.get(Calendar.DAY_OF_MONTH) == 1 &&
				calendar2.get(Calendar.DAY_OF_MONTH) == calendar2.getActualMaximum(Calendar.DAY_OF_MONTH)) {
			if((calendar.get(Calendar.MONTH) == Calendar.JANUARY  && calendar2.get(Calendar.MONTH) == Calendar.MARCH ) ||
			   (calendar.get(Calendar.MONTH) == Calendar.APRIL && calendar2.get(Calendar.MONTH) == Calendar.JUNE) ||
			   (calendar.get(Calendar.MONTH) == Calendar.JULY && calendar2.get(Calendar.MONTH) == Calendar.SEPTEMBER) ||
			   (calendar.get(Calendar.MONTH) == Calendar.OCTOBER && calendar2.get(Calendar.MONTH) == Calendar.DECEMBER) &&
			   (calendar.get(Calendar.MONTH) != calendar2.get(Calendar.MONTH) && calendar.get(Calendar.YEAR) == calendar2.get(Calendar.YEAR)))
				detectedUnit = MChart.TIMEUNIT_Quarter;
			else
				detectedUnit = MChart.TIMEUNIT_Month;
			timeUnit = Calendar.MONTH;
		}
		else if(calendar.get(Calendar.DAY_OF_WEEK) == calendar.getFirstDayOfWeek() &&
				calendar2.get(Calendar.DAY_OF_WEEK) == calendar2.getActualMaximum(Calendar.DAY_OF_WEEK)) {
			detectedUnit = MChart.TIMEUNIT_Week;
			timeUnit = Calendar.WEEK_OF_YEAR;
		}
		else {
			if(predictedMode.equalsIgnoreCase(DATESELECTIONMODE_CURRENT))
				correctedMode = DATESELECTIONMODE_BETWEEN;
			else {
				detectedUnit = MChart.TIMEUNIT_Day;
				timeUnit = Calendar.DAY_OF_YEAR;
			}
		}
		int testOffset = 1;
		if(detectedUnit.equalsIgnoreCase(MChart.TIMEUNIT_Quarter))
			testOffset = 3;	// three months = 1 quarter
		testCalendar.add(timeUnit, -testOffset);
		if(testCalendar.getTime().after(dateTo)) {
			detectedUnit = MChart.TIMEUNIT_Day;
			correctedMode = DATESELECTIONMODE_BETWEEN;
		}
		
		testCalendar = (Calendar) calendarToday.clone();
		testCalendar.add(timeUnit, testOffset);
		if(testCalendar.getTime().before(dateFrom)) {
			detectedUnit = MChart.TIMEUNIT_Day;
			correctedMode = DATESELECTIONMODE_BETWEEN;
		}
		
		//re-validate current month detection
		if (detectedUnit == MChart.TIMEUNIT_Month ) {
			if (correctedMode.equalsIgnoreCase(DATESELECTIONMODE_CURRENT)) {
				if (calendar.get(Calendar.MONTH) != calendar2.get(Calendar.MONTH) || calendar.get(Calendar.YEAR) != calendar2.get(Calendar.YEAR)) {
					detectedUnit = MChart.TIMEUNIT_Day;
					correctedMode = DATESELECTIONMODE_BETWEEN;
				} else if (calendar.get(Calendar.MONTH) != calendarToday.get(Calendar.MONTH)
						   || calendar.get(Calendar.YEAR) != calendarToday.get(Calendar.YEAR)) {
					detectedUnit = MChart.TIMEUNIT_Day;
					correctedMode = DATESELECTIONMODE_BETWEEN;
				}
			}
		}

		return new String[] {detectedUnit, correctedMode};
	}
	
	private int autodetectOffset(String mode, String unit) {
		Date date = dateFrom;
	    Date date2 = dateTo;

	    long diffInMillies = Math.abs(date2.getTime() - date.getTime());
	    long diff = TimeUnit.DAYS.convert(diffInMillies+1, TimeUnit.MILLISECONDS);
		
	    switch (unit) {
			case MChart.TIMEUNIT_Year:
				diff = diff / 365;
			break;
			case MChart.TIMEUNIT_Quarter:
				diff = diff / 89;
			break;
			case MChart.TIMEUNIT_Month:
				diff = diff / 28;
			break;
			case MChart.TIMEUNIT_Week:
				diff = diff / 7;
			break;
		}
	    if(mode.equalsIgnoreCase(DATESELECTIONMODE_PREVIOUS))
	    	diff = -diff;
		return (int) diff;
	}
	
	private String getIntervalHumanReadable() {
		
		Timestamp ts = new Timestamp(cal.getValue().getTime());
		String mode = modeCombobox.getSelectedItem().getValue().toString();
		String unit = unitCombobox.getSelectedItem().getValue().toString();
		Integer numBoxValue = numberBox.getValue();
		Date[] dates;
		
		if(numBoxValue == null) {
			numBoxValue = 1;
			numberBox.setValue(numBoxValue);
		}
		
		if(mode.equalsIgnoreCase(DATESELECTIONMODE_AFTER)) {
			displayValue = Msg.getMsg(Env.getCtx(), "AfterDate", new Object[] {DisplayType.getDateFormat().format(ts)});
			dateFrom = ts;
			dateFrom = setTimesOnDates(dateFrom, null)[0];
			dateTo = null;
			return displayValue;
		}
		else if(mode.equalsIgnoreCase(DATESELECTIONMODE_BEFORE)) {
			displayValue = Msg.getMsg(Env.getCtx(), "BeforeDate", new Object[] {DisplayType.getDateFormat().format(ts)});
			dateFrom = null;
			dateTo = ts;
			dateTo = setTimesOnDates(null, dateTo)[1];
			return displayValue;
		}
		else if(mode.equalsIgnoreCase(DATESELECTIONMODE_ON)) {
			displayValue = Msg.getMsg(Env.getCtx(), "OnDate", new Object[] {DisplayType.getDateFormat().format(ts)});
			dateFrom = ts;
			dateTo = ts;
			dates = setTimesOnDates(dateFrom, dateTo);
			dateFrom = dates[0];
			dateTo = dates[1];
			return displayValue;
		}
		
		if(mode.equalsIgnoreCase(DATESELECTIONMODE_PREVIOUS))
			numBoxValue = -numBoxValue;
		
		if(mode.equalsIgnoreCase(DATESELECTIONMODE_CURRENT))
			dates = getInterval(unit, 0);
		else
			dates = getInterval(unit, numBoxValue.intValue());

		dateFrom = new Timestamp(dates[0].getTime());
		dateTo = new Timestamp(dates[1].getTime());
		dates = setTimesOnDates(dateFrom, dateTo);
		dateFrom = dates[0];
		dateTo = dates[1];
		
		displayValue = datesToHumanReadable(mode, unit, numBoxValue);
		return DisplayType.getDateFormat().format(dateFrom) + " - " + DisplayType.getDateFormat().format(dateTo);
	}

	private Date[] getInterval(String timeUnit, int offset) {
		return getInterval(timeUnit, null, offset, false, false, null);
	}

	private Date[] getInterval(String timeUnit, String timeUnitForRange, int offset, boolean isToDate, boolean includeThis, Date dateFrom) {

		if(dateFrom == null)
			dateFrom = new Date(System.currentTimeMillis());
		
		Calendar cal1 = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		Calendar cal2 = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		cal1.setTime(dateFrom);
		cal2.setTime(dateFrom);
		
		int iUnit;
		int iDayUnit;
		
		// Transform Time Unit
		switch (timeUnit) {
			case MChart.TIMEUNIT_Day:
				iUnit = Calendar.DAY_OF_YEAR;
				iDayUnit = Calendar.DAY_OF_YEAR;
				break;
			case MChart.TIMEUNIT_Month:
				iUnit = Calendar.MONTH;
				iDayUnit = Calendar.DAY_OF_MONTH;
				break;
			case MChart.TIMEUNIT_Quarter:
				iUnit = Calendar.MONTH;
				iDayUnit = Calendar.DAY_OF_MONTH;
				offset = offset * 3;
				break;
			case MChart.TIMEUNIT_Week:
				iUnit = Calendar.WEEK_OF_YEAR;
				iDayUnit = Calendar.DAY_OF_WEEK;
				break;
			case MChart.TIMEUNIT_Year:
				iUnit = Calendar.YEAR;
				iDayUnit = Calendar.DAY_OF_YEAR;
				break;
			default:
				throw new AdempiereException("TimeUnitNotSupported");
		}

		if(!Util.isEmpty(timeUnitForRange) || !isToDate){
			boolean hasTimeUnitForRange = true;
			
			if(Util.isEmpty(timeUnitForRange)) {
				timeUnitForRange = timeUnit;
				hasTimeUnitForRange = false;
			}
			// Add the offset
			if(hasTimeUnitForRange && offset != 0) {
				cal1.add(iUnit, offset);
				cal2.add(iUnit, offset);
			}
			else if(!hasTimeUnitForRange && !isToDate) {
				if(offset < 0) {
					cal1.add(iUnit, offset);
					if(!includeThis) {
						if(timeUnitForRange.equalsIgnoreCase(MChart.TIMEUNIT_Quarter))
							cal2.add(iUnit, -3);
						else
							cal2.add(iUnit, -1);
					}
				}
				else if (offset > 0) {
					if(!includeThis) {
						if(timeUnitForRange.equalsIgnoreCase(MChart.TIMEUNIT_Quarter))
							cal1.add(iUnit, 3);
						else
							cal1.add(iUnit, 1);
					}
					cal2.add(iUnit, offset);
				}
			}
			
			// Set first and last Day of the given time period
			if(timeUnitForRange.equalsIgnoreCase(MChart.TIMEUNIT_Week)) {
				cal1.set(iDayUnit, cal1.getFirstDayOfWeek());
				cal2.set(iDayUnit, cal2.getFirstDayOfWeek());
				cal2.add(iDayUnit, 6);
			}
			else if(timeUnitForRange.equalsIgnoreCase(MChart.TIMEUNIT_Quarter)){
				if(cal1.after(new GregorianCalendar(cal1.get(Calendar.YEAR), Calendar.OCTOBER, 1))) {
					cal1.set(Calendar.MONTH, Calendar.OCTOBER);
					cal2.set(Calendar.MONTH, Calendar.DECEMBER);
				}
				else if(cal1.after(new GregorianCalendar(cal1.get(Calendar.YEAR), Calendar.JULY, 1))) {
					cal1.set(Calendar.MONTH, Calendar.JULY);
					cal2.set(Calendar.MONTH, Calendar.SEPTEMBER);
				}
				else if(cal1.after(new GregorianCalendar(cal1.get(Calendar.YEAR), Calendar.APRIL, 1))) {
					cal1.set(Calendar.MONTH, Calendar.APRIL);
					cal2.set(Calendar.MONTH, Calendar.JUNE);
				}
				else {
					cal1.set(Calendar.MONTH, Calendar.JANUARY);
					cal2.set(Calendar.MONTH, Calendar.MARCH);
				}
				cal1.set(Calendar.DAY_OF_MONTH, cal1.getActualMinimum(iDayUnit));
				cal2.set(Calendar.DAY_OF_MONTH, cal2.getActualMaximum(Calendar.DAY_OF_MONTH));
			}
			else if (!timeUnitForRange.equalsIgnoreCase(MChart.TIMEUNIT_Day)) {
				cal1.set(iDayUnit, cal1.getActualMinimum(iDayUnit));
				cal2.set(iDayUnit, cal2.getActualMaximum(iDayUnit));
			}
		}
		else if(isToDate) {
			if(offset < 0)
				cal1.add(iUnit, offset);
			else if (offset > 0)
				cal2.add(iUnit, offset);
		}

		Date date1 = cal1.getTime();
		Date date2 = cal2.getTime();
		
		return new Date[] {date1, date2};
	}

	private String datesToHumanReadable(String mode, String unit, Integer offset) {
		String msgVal = "";
		String modeVal = "";

		if(offset < 0)
			offset = -offset;
		if(mode.equalsIgnoreCase(DATESELECTIONMODE_CURRENT))
			offset = -1;
		
		switch (unit) {
			case MChart.TIMEUNIT_Day:
				msgVal = "DatePickerDay";
				break;
			case MChart.TIMEUNIT_Month:
				msgVal = "DatePickerMonth";
				break;
			case MChart.TIMEUNIT_Quarter:
				msgVal = "DatePickerQuarter";
				break;
			case MChart.TIMEUNIT_Week:
				msgVal = "DatePickerWeek";
				break;
			case MChart.TIMEUNIT_Year:
				msgVal = "DatePickerYear";
				break;
			default:
				throw new AdempiereException("TimeUnitNotSupported");
		}
		for(Comboitem item : modeCombobox.getItems()) {
			if(item.getValue().equals(mode))
				modeVal = item.getLabel();
		}
		return Msg.getMsg(Env.getCtx(), msgVal, new Object[]{modeVal, offset});
	}
	
	private Date[] setTimesOnDates(Date dateFrom, Date dateTo) {
		Calendar cal = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		if(dateFrom != null) {
			cal.setTime(dateFrom);
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			dateFrom = new Timestamp(cal.getTime().getTime());
		}
		if(dateTo != null) {
			cal.setTime(dateTo);
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			cal.add(Calendar.DAY_OF_MONTH, 1);
			cal.add(Calendar.MILLISECOND, -1);
			dateTo = new Timestamp(cal.getTime().getTime());
		}
		return new Date[] {dateFrom, dateTo};
	}

	private ListItem createItem(String value, String timeUnit, int offset, Date dateFrom) {
		ListItem item = new ListItem(value, value);
		item.setAttribute("Offset", offset);
		item.setAttribute("TimeUnit", timeUnit);
		item.setAttribute("DateFrom", dateFrom);
		return item;
	}
	
	private Div getQuickModeContent() {
		
		Calendar cNow = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		cNow.setTime(new Date(System.currentTimeMillis()));
		Calendar c = Calendar.getInstance(Env.getLocale(Env.getCtx()));
		c.setTime(new Date(System.currentTimeMillis()));
		
		Div wrapperDiv1 = new Div();
		wrapperDiv1.setStyle("width: 420px; display: flex; border-top: 2px solid #CFCFCF;");
		
		// Months
		Div wrapperDiv2 = new Div();
		wrapperDiv2.setStyle("width: 420px; display: flex;");

		Label label = new Label(Msg.getMsg(Env.getCtx(), "CurrentYearMonths"));
		label.setSclass("date-picker-label");
		Div monthLabelDiv = new Div();
		monthLabelDiv.setStyle("margin-top: 10px;");
		monthLabelDiv.appendChild(label);
		
		c = cNow;
		int idx=0;
		int monthIdx = Calendar.APRIL;
		ListItem item;
		Listbox box;
		Div innerDiv;
		
		while (monthIdx <= Calendar.DECEMBER) {
			innerDiv = new Div();
			innerDiv.setSclass("date-picker-component");
			innerDiv.setStyle("margin: 5px 5px 16px 5px !important; width: 33%;");
			
			box = new Listbox();
			box.addEventListener(Events.ON_SELECT, this);
			box.setCheckmark(true);
			
			ValueNamePair[] months = MRefList.getList(Env.getCtx(), REFERENCE_MONTHS, false, "Value");
			
			for(int i = idx; i <= monthIdx; i++) {
				c.set(Calendar.MONTH, i);
				item = createItem(months[i].getName(), MChart.TIMEUNIT_Month, 0, new Date(c.getTimeInMillis()));
				box.appendChild(item);
				idx=i;
			}
			innerDiv.appendChild(box);
			quickListBoxesArray.add(box);
			wrapperDiv1.appendChild(innerDiv);
			
			idx++;
			monthIdx += 4;
		}
		
		// Quarters		
		c = cNow;
		innerDiv = new Div();
		innerDiv.setSclass("date-picker-component");
		innerDiv.setStyle("width: 50%;");
		label = new Label(Msg.getMsg(Env.getCtx(), "CurrentYearQuarters"));
		label.setSclass("date-picker-label");
		innerDiv.appendChild(label);
		
		box = new Listbox();
		box.setStyle("border-top: 2px solid #CFCFCF;");
		box.addEventListener(Events.ON_SELECT, this);
		box.setCheckmark(true);
		
		ValueNamePair[] quarters = MRefList.getList(Env.getCtx(), REFERENCE_QUARTERS, false, "Value");
		idx = 0;
		for(ValueNamePair quarter : quarters) {
			c.set(Calendar.MONTH, idx);
			item = createItem(quarter.getName(), MChart.TIMEUNIT_Quarter, 0, new Date(c.getTimeInMillis()));
			box.appendChild(item);
			idx+=3;
		}
		
		innerDiv.appendChild(box);
		quickListBoxesArray.add(box);
		wrapperDiv2.appendChild(innerDiv);
		
		// Year
		innerDiv = new Div();
		innerDiv.setSclass("date-picker-component");
		innerDiv.setStyle("width: 50%;");
		label = new Label(Msg.getMsg(Env.getCtx(), "Year"));
		label.setSclass("date-picker-label");
		innerDiv.appendChild(label);
		
		box = new Listbox();
		box.setStyle("border-top: 2px solid #CFCFCF;");
		box.addEventListener(Events.ON_SELECT, this);
		box.setCheckmark(true);
		
		for(int i=0; i>=-3; i--) {
			item = createItem(String.valueOf(c.get(Calendar.YEAR)), MChart.TIMEUNIT_Year, i, null);
			box.appendChild(item);
			c.add(Calendar.YEAR, -1);
		}
		innerDiv.appendChild(box);
		quickListBoxesArray.add(box);
		wrapperDiv2.appendChild(innerDiv);
		
		Div div = new Div();
		div.appendChild(monthLabelDiv);
		div.appendChild(wrapperDiv1);
		div.appendChild(wrapperDiv2);
		
		return div;
	}
	
	/**
	 * Get Display Value
	 * @return String
	 */
	public String getDisplayValue() {
		return this.displayValue;
	}

	/**
	 * Add value change listener
     * @param listener
     */
    public void addValueChangeListener(ValueChangeListener listener)
    {
    	if (listener == null)
            return;
    	
    	if (!listeners.contains(listener))
    		listeners.add(listener);
    }
	
    /**
     * Remove value change listener
     * @param listener
     * @return true if the class had the specified listener
     */
    public boolean removeValuechangeListener(ValueChangeListener listener)
    {
    	return listeners.remove(listener);
    }

    /**
     * Fire value change event
     * @param event
     */
    protected void fireValueChange(ValueChangeEvent event)
    {
    	//copy to array to avoid concurrent modification exception
    	ValueChangeListener[] vcl = new ValueChangeListener[listeners.size()];
    	listeners.toArray(vcl);
        for (ValueChangeListener listener : vcl)
        {
            listener.valueChange(event);
        }
    }
    
	@Override
	public void valueChange(ValueChangeEvent evt) {
		if(enableValueChange) {
			dateFrom = (Date) editor.getValue();
			dateTo = (Date) editor2.getValue();
			if(dateFrom != null || dateTo != null) { // Set the picker to defined Default Logic
				Date[] dates = setTimesOnDates(dateFrom, dateTo);
				dateFrom = dates[0];
				dateTo = dates[1];
				loadPickerSelection();
	 		}
	 		else {
	 			// If no Default Logic defined, set Current Month as selected range
	 			setPickerSelection(DATESELECTIONMODE_CURRENT, MChart.TIMEUNIT_Month, 0);
	 			Date[] dates = setTimesOnDates(dateFrom, dateTo);
				dateFrom = dates[0];
				dateTo = dates[1];
	 		}
			updateUI();
			fireValueChange(new ValueChangeEvent(this,"DateRangePicker",oldDisplayValue, displayValue));
		}
	}
}