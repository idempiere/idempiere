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

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ComboItem;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.factory.ButtonFactory;
import org.compiere.model.MChart;
import org.compiere.model.MRefList;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zul.Div;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Spinner;

/**
*
* @author Peter Takacs, Cloudempiere
*
*/
public class DateRangePicker extends Popup implements EventListener<Event> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7959690713224781610L;
	
	// AD_Reference_ID
	private static final int REFERENCE_TIMEUNIT = 53376;
	private static final int REFERENCE_DATESELECTIONMODE = 200217;
	private static final int REFERENCE_MONTHS = 200221;
	private static final int REFERENCE_QUARTERS = 200222;
	
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
	
	private WEditor editor;
	private WEditor editor2;
	private Date dateFrom;
	private Date dateTo;
	private Date oldValueFrom;
	private Date oldValueTo;
	
	private ArrayList<Listbox> quickListBoxesArray = new ArrayList<Listbox>();
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
		
		Div div = new Div();
		okBtn = ButtonFactory.createNamedButton(Msg.getMsg(Env.getCtx(), "ApplyFilter"), true, false);
		okBtn.setStyle("color: white; background: #A9A9A9; float: right;");

		modeCombobox = new Combobox();
		modeCombobox.setSclass("date-picker-component");
		modeCombobox.setWidth("90px");
		modeCombobox.addEventListener(Events.ON_SELECT, this);
		
		numberBox = new Spinner(1);
		numberBox.setConstraint("no empty, min 1");
		numberBox.setStyle("margin: 5px;");
		numberBox.addEventListener(Events.ON_CHANGING, this);

		unitCombobox = new Combobox();
		unitCombobox.setSclass("date-picker-component");
		unitCombobox.setWidth("90px");
		unitCombobox.addEventListener(Events.ON_SELECT, this);
		
		cal = new org.zkoss.zul.Calendar();
		cal.setSclass("date-picker-component");
		cal.addEventListener(Events.ON_CHANGE, this);
		cal2 = new org.zkoss.zul.Calendar();
		cal2.setSclass("date-picker-component");
		cal2.addEventListener(Events.ON_CHANGE, this);
		
		Label dateTextBoxLabel = new Label(Msg.getMsg(Env.getCtx(), "SelectedTimeRange"));
		dateTextBoxLabel.setSclass("date-picker-label");
		
		dateTextBox = new Textbox();
		dateTextBox.setSclass("date-picker-component");
		dateTextBox.setStyle("min-width: 170px;");
		dateTextBox.setValue(DisplayType.getDateFormat().format(cal.getValue()));
		dateTextBox.addEventListener(Events.ON_CHANGE, this);
		
		okBtn.setSclass("date-picker-component");
		okBtn.addEventListener(Events.ON_CLICK, event -> {
			if(dateFrom != null && dateTo != null && dateTo.before(dateFrom))
				throw new WrongValueException(dateTextBox, Msg.getMsg(Env.getCtx(), "EndDateAfterStartDate"));
			setTimesOnDates();
			if(Util.isEmpty(dateTextBox.getValue())) {
				oldValueFrom = dateFrom;
				oldValueTo = dateTo;
				dateFrom = null;
				dateTo = null;
			}
			editor.setValue(dateFrom);
			editor2.setValue(dateTo);
			this.detach();
		});
		
		quickListBoxes = new Div();
		quickListBoxes.appendChild(getQuickModeContent());
		
		// Load Modes to ListBox
		ComboItem selectedOnOpen = null; 
		ValueNamePair[] modes = MRefList.getList(Env.getCtx(), REFERENCE_DATESELECTIONMODE, false, "Value");
		for(ValueNamePair mode : modes) {
			ComboItem item = new ComboItem(mode.getName(), mode.getValue());
			if(mode.getValue().equalsIgnoreCase(DATESELECTIONMODE_CURRENT))
				selectedOnOpen = item;
			modeCombobox.appendChild(item);
		}
		if(selectedOnOpen != null)
			modeCombobox.setSelectedItem(selectedOnOpen);
		else
			modeCombobox.setSelectedIndex(0);
		
		// Load Units to ListBox
		ValueNamePair[] units = MRefList.getList(Env.getCtx(), REFERENCE_TIMEUNIT, false);
		for(ValueNamePair timeUnit : units) {
			ComboItem item = new ComboItem(timeUnit.getName(), timeUnit.getValue());
			if(timeUnit.getValue().equalsIgnoreCase(MChart.TIMEUNIT_Month))
				selectedOnOpen = item;
			unitCombobox.appendChild(item);
		}
		if(selectedOnOpen != null)
			unitCombobox.setSelectedItem(selectedOnOpen);
		else
			modeCombobox.setSelectedIndex(0);
		
		div.setSclass("date-picker-container");
		div.appendChild(modeCombobox);
		div.appendChild(numberBox);
		div.appendChild(unitCombobox);
		this.appendChild(div);
		
		div = new Div();
		div.setSclass("date-picker-container");
		div.setStyle("Margin-top: 10px;");
		div.appendChild(cal);
		div.appendChild(cal2);
		div.appendChild(quickListBoxes);
		this.appendChild(div);
		
		div = new Div();
		div.setSclass("date-picker-container");
		div.setStyle("margin: 10px 0 10px 0;");
		div.appendChild(dateTextBoxLabel);
		div.appendChild(dateTextBox);		
		div.setSclass("date-picker-container");
		div.appendChild(okBtn);
		this.appendChild(div);
		
		this.setStyle("min-width: 320px;");
		updateUI();
		setDisplayValue();
	}

	private void updateUI() {
		String selectedMode = modeCombobox.getSelectedItem().getValue().toString();
		switch (selectedMode) {
		case DATESELECTIONMODE_AFTER:
		case DATESELECTIONMODE_BEFORE:
		case DATESELECTIONMODE_ON:
			numberBox.setVisible(false);
			unitCombobox.setVisible(false);
			cal.setVisible(true);
			cal2.setVisible(false);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_BETWEEN:
			numberBox.setVisible(false);
			unitCombobox.setVisible(false);
			cal.setVisible(true);
			cal2.setVisible(true);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_CURRENT:
			numberBox.setVisible(false);
			unitCombobox.setVisible(true);
			cal.setVisible(false);
			cal2.setVisible(false);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_NEXT:
		case DATESELECTIONMODE_PREVIOUS:
			numberBox.setVisible(true);
			unitCombobox.setVisible(true);
			cal.setVisible(false);
			cal2.setVisible(false);
			quickListBoxes.setVisible(false);
			break;
		case DATESELECTIONMODE_QUICK:
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
		if(!Util.isEmpty(dateTextBox.getValue()) || !event.getTarget().equals(dateTextBox))
			setDisplayValue();
	}
	
	private void setDisplayValue() {
		String displayValue = getDisplayValue();
		dateTextBox.setValue(displayValue);
	}

	private String getDisplayValue() {
		String returnVal = "";
		Timestamp ts = new Timestamp(cal.getValue().getTime());
		switch (modeCombobox.getSelectedItem().getValue().toString()) {
			case DATESELECTIONMODE_AFTER:
				returnVal = Msg.getMsg(Env.getCtx(), "AfterDate", new Object[] {DisplayType.getDateFormat().format(ts)});
				oldValueFrom = dateFrom;
				oldValueTo = dateTo;
				dateFrom = ts;
				dateTo = null;
				break;
			case DATESELECTIONMODE_BEFORE:
				returnVal = Msg.getMsg(Env.getCtx(), "BeforeDate", new Object[] {DisplayType.getDateFormat().format(ts)});
				oldValueFrom = dateFrom;
				oldValueTo = dateTo;
				dateFrom = null;
				dateTo = ts;
				break;
			case DATESELECTIONMODE_BETWEEN:
				returnVal = DisplayType.getDateFormat().format(cal.getValue()) + " - " + DisplayType.getDateFormat().format(cal2.getValue());
				oldValueFrom = dateFrom;
				oldValueTo = dateTo;
				dateFrom = new Timestamp(cal.getValue().getTime());
				dateTo = new Timestamp(cal2.getValue().getTime());
				break;
			case DATESELECTIONMODE_CURRENT:
			case DATESELECTIONMODE_NEXT:
			case DATESELECTIONMODE_PREVIOUS:
				returnVal = getInterval();
				break;
			case DATESELECTIONMODE_ON:
				returnVal = Msg.getMsg(Env.getCtx(), "OnDate", new Object[] {DisplayType.getDateFormat().format(ts)});
				oldValueFrom = dateFrom;
				oldValueTo = dateTo;
				dateFrom = ts;
				dateTo = ts;
				break;
			case DATESELECTIONMODE_QUICK:
				if(selectedQuickListItem != null) {
					String unit = (String) selectedQuickListItem.getAttribute("TimeUnit");
					int offset = (int) selectedQuickListItem.getAttribute("Offset");
					Date dateFrom = (Date) selectedQuickListItem.getAttribute("DateFrom");
					Date[] dates = getInterval(unit, unit, offset, false, false, dateFrom);
					this.oldValueFrom = this.dateFrom;
					this.oldValueTo = this.dateTo;
					this.dateFrom = new Timestamp(dates[0].getTime());
					this.dateTo = new Timestamp(dates[1].getTime());
					returnVal = DisplayType.getDateFormat().format(this.dateFrom) + " - " + DisplayType.getDateFormat().format(this.dateTo);
				}
				break;
			default:
				throw new AdempiereException("InvalidDateSelectionMode");
		}
		return returnVal;
	}
	
	private String getInterval() {
		
		String mode = modeCombobox.getSelectedItem().getValue().toString();
		String unit = unitCombobox.getSelectedItem().getValue().toString();
		Integer numBoxValue = numberBox.getValue();
		Date[] dates;
		
		if(numBoxValue == null) {
			numBoxValue = 0;
			numberBox.setValue(numBoxValue);
		}
		
		if(mode.equalsIgnoreCase(DATESELECTIONMODE_PREVIOUS))
			numBoxValue = -numBoxValue;
		
		if(mode.equalsIgnoreCase(DATESELECTIONMODE_CURRENT))
			dates = getInterval(unit, 0);
		else
			dates = getInterval(unit, numBoxValue.intValue());

		oldValueFrom = dateFrom;
		oldValueTo = dateTo;
		dateFrom = new Timestamp(dates[0].getTime());
		dateTo = new Timestamp(dates[1].getTime());
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
			// Set first and last Day of the given time period
			if(Util.isEmpty(timeUnitForRange)) {
				timeUnitForRange = timeUnit;
				hasTimeUnitForRange = false;
			}
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

	private void setTimesOnDates() {
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
	 * Get Date Textbox
	 * @return Textbox
	 */
	public Textbox getDateTextbox() {
		return dateTextBox;
	}
	
	/**
	 * Get Update Button
	 * @return Button
	 */
	public Button getUpdateButton() {
		return okBtn;
	}

	/**
	 * Get Value From
	 * @return
	 */
	public Date getValueFrom() {
		return dateFrom;
	}
	
	/**
	 * Get Old Value From
	 * @return
	 */
	public Date getOldValueFrom() {
		return oldValueFrom;
	}

	/**
	 * Get Value To
	 * @return
	 */
	public Date getValueTo() {
		return dateTo;
	}

	/**
	 * Get Old Value To
	 * @return
	 */
	public Date getOldValueTo() {
		return oldValueTo;
	}
}
