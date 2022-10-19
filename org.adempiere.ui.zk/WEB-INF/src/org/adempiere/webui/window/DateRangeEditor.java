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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;

/**
*
* @author Peter Takacs, Cloudempiere
*
*/
public class DateRangeEditor extends Div implements ValueChangeListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3329360781729704243L;

	private static final String IMAGES_CONTEXT_CALENDAR_PNG = "images/Calendar16.png";
	
	private Textbox textbox;
	ToolBarButton popupBtn;
	private DateRangePicker popup;
	private boolean isProcessParameter;
	private WEditor editor;
	private WEditor editor2;
	
	/**
	 * Constructor
	 */
	public DateRangeEditor(WEditor editor, WEditor editor2, boolean isProcessParameter) {
		super();
		this.isProcessParameter = isProcessParameter;
		this.editor = editor;
		this.editor2 = editor2;
		init();
	}
	
	private void init() {
		
		this.setWidth("100%");
		textbox = new Textbox();
		textbox.setStyle("width: 100%; background: white !important");
		textbox.setReadonly(true);
		this.appendChild(textbox);
		
		popupBtn = new ToolBarButton();
		popupBtn.setSclass("date-picker-calendar-button");
		if (ThemeManager.isUseFontIconForImage())
			popupBtn.setIconSclass("z-icon-Calendar");
		else
			popupBtn.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_CALENDAR_PNG));
		this.appendChild(popupBtn);
		
		popup = new DateRangePicker(editor, editor2);
		popupBtn.setTooltip(popup);
		popupBtn.addEventListener(Events.ON_CLICK, event -> {
			popup.setPage(popupBtn.getPage());
			popup.open(popupBtn, "after_end");
			LayoutUtils.autoDetachOnClose(popup);
		});

		Button btn = popup.getUpdateButton();
		btn.addEventListener(Events.ON_CLICK, e -> {
			this.fireValueChangeEvent();
			textbox.setValue(popup.getDateTextbox().getValue());
		});
		editor.addValueChangeListener(this);
		editor2.addValueChangeListener(this);
		valueChange(null);
	}

	@Override
	public void valueChange(ValueChangeEvent evt) {
		Timestamp value = (Timestamp) editor.getValue();
		Timestamp value2 = (Timestamp) editor2.getValue();
		String sValue = null;
		String sValue2 = null;
		
		if(value != null)
			sValue = DisplayType.getDateFormat().format((Timestamp) editor.getValue());
		if(value2 != null)
			sValue2 = DisplayType.getDateFormat().format((Timestamp) editor2.getValue());
		
		if(value == null && value2 == null)
			return;
		else if(value == null && value2 != null)
			textbox.setValue(Msg.getMsg(Env.getCtx(), "BeforeDate", new Object[] {sValue2}));
		else if(value != null && value2 == null)
			textbox.setValue(Msg.getMsg(Env.getCtx(), "AfterDate", new Object[] {sValue}));
		else if(value.equals(value2))
			textbox.setValue(Msg.getMsg(Env.getCtx(), "OnDate", new Object[] {sValue}));
		else
			textbox.setValue(sValue + " - " + sValue2);	
	}
	
	/**
	 * Set/Remove Mandatory Style
	 * @param applyStyle
	 */
	public void setFieldMandatoryStyle() {
		if (isMandatoryStyle())
			LayoutUtils.addSclass("idempiere-mandatory", textbox);
		else 
			LayoutUtils.removeSclass("idempiere-mandatory", textbox);
	}
	
	private boolean isMandatoryStyle() {
		return editor.isMandatory() && editor.isReadWrite() && (isProcessParameter || editor.getGridField().isEditable(true)) && isNullOrEmpty(editor)
				|| editor2.isMandatory() && editor2.isReadWrite() && (isProcessParameter || editor2.getGridField().isEditable(true)) && isNullOrEmpty(editor2);
	}
	
	private boolean isNullOrEmpty(WEditor editor) {
		Object value = editor.getValue();
		return value == null || value.toString().trim().length() == 0;
	}
	
	private void fireValueChangeEvent() {
		ValueChangeEvent changeEvent = new ValueChangeEvent(this, editor.getColumnName(), popup.getOldValueFrom(), popup.getValueFrom());
		editor.fireValueChange(changeEvent);
		changeEvent = new ValueChangeEvent(this, editor2.getColumnName(), popup.getOldValueTo(), popup.getValueTo());
		editor2.fireValueChange(changeEvent);
	}
	
	public void setReadOnly(boolean readOnly) {
		popupBtn.setDisabled(readOnly);
		if(readOnly)
			textbox.setStyle("width: 100%;");
		else
			textbox.setStyle("width: 100%; background: white !important");
	}
}
