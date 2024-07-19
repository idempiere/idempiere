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
package org.adempiere.webui.editor;

import java.util.Objects;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.DateRangePicker;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;

/**
 * Composite component of a read only Textbox and ToolbarButton.<br/>
 * ToolbarButton open {@link DateRangePicker} to edit the value of from and to editor. Result is then shown in
 * the read only Textbox.
 * @author Peter Takacs, Cloudempiere
 *
 */
public class DateRangeEditor extends Div implements ValueChangeListener {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3329360781729704243L;

	private static final String IMAGES_CONTEXT_CALENDAR_PNG = "images/Calendar16.png";

	private Textbox textbox;
	private ToolBarButton popupBtn;
	private DateRangePicker popup;
	private WEditor editor;
	private WEditor editor2;
	private Label dateRangeText;

	/**
	 * Constructor
	 * @param editor
	 * @param editor2
	 */
	public DateRangeEditor(WEditor editor, WEditor editor2) {
		super();
		this.editor = editor;
		this.editor2 = editor2;
		init();
	}

	/**
	 * Layout UI.
	 * Horizontal layout of Textbox and ToolBarButton.
	 */
	private void init() {

		this.setWidth("100%");
		ZkCssHelper.appendStyle(this, "display: inline-block; position: relative;");
		textbox = new Textbox();
		textbox.setStyle("width: 100%; background: white !important");
		textbox.setReadonly(true);
		this.appendChild(textbox);

		popupBtn = new ToolBarButton();
		popupBtn.addSclass("date-picker-calendar-button");
		if (ThemeManager.isUseFontIconForImage())
			popupBtn.setIconSclass("z-icon-Calendar");
		else
			popupBtn.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_CALENDAR_PNG));
		this.appendChild(popupBtn);

		popup = new DateRangePicker(editor, editor2);
		popupBtn.addEventListener(Events.ON_CLICK, event -> {
			popup.setPage(popupBtn.getPage());
			popup.open(popupBtn, "after_center");
			LayoutUtils.autoDetachOnClose(popup);
		});
		popup.addValueChangeListener(this);

		dateRangeText = new Label();
		this.appendChild(dateRangeText);
		dateRangeText.setStyle("font-size: x-small;font-weight: normal;position: absolute;display: block;");
		dateRangeText.setVisible(false);
	}

	@Override
	public void valueChange(ValueChangeEvent evt) {
		textbox.setValue(evt.getNewValue() != null ? evt.getNewValue().toString() : "");
		if (evt.getNewValue() != null) {
			if (textbox.getValue().equals(popup.getDateRangeText())) {
				dateRangeText.setValue("");
				dateRangeText.setVisible(false);
			} else {
				dateRangeText.setValue(popup.getDateRangeText());
				dateRangeText.setVisible(true);
				if (getPage() != null)
					LayoutUtils.positionComponent(popupBtn, dateRangeText, "start_before");
			}
		} else {
			dateRangeText.setValue("");
			dateRangeText.setVisible(false);
		}
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
		return (editor.isMandatory() && editor.isReadWrite() && editor.getGridField().isEditable(true) && isNullOrEmpty(editor))
				|| (editor2.isMandatory() && editor2.isReadWrite() && editor2.getGridField().isEditable(true) && isNullOrEmpty(editor2));
	}

	private boolean isNullOrEmpty(WEditor editor) {
		Object value = editor.getValue();
		return Util.isEmpty(Objects.toString(value, ""), true);
	}

	/**
	 * Set Read Only
	 * @param readOnly
	 */
	public void setReadOnly(boolean readOnly) {
		popupBtn.setDisabled(readOnly);
		if(readOnly)
			textbox.setStyle("width: 100%;");
		else
			textbox.setStyle("width: 100%; background: white !important");
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null && dateRangeText.isVisible() && !Util.isEmpty(dateRangeText.getValue())) {
			LayoutUtils.positionComponent(popupBtn, dateRangeText, "start_before");
		}
	}
}
