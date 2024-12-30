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

import java.util.Properties;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;

/**
 * Button for range date field editor. Open {@link DateRangePicker} dialog to set the from and to value.
 * @author Peter Takacs, Cloudempiere
 *
 */
public class DateRangeButton extends ToolBarButton implements WEditor.DynamicDisplayListener {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4404182204288841866L;

	private static final String IMAGES_CONTEXT_HISTORY_PNG = "images/History16.png";
	
	private WEditor editor;
	private WEditor editor2;
	
	/**
	 * Constructor
	 * @param editor
	 * @param editor2
	 */
	public DateRangeButton(WEditor editor, WEditor editor2) {
		super();
		this.editor = editor;
		this.editor2 = editor2;
		init();
	}
	
	/**
	 * Setup component and create {@link DateRangePicker}
	 */
	private void init() {
		
		if (ThemeManager.isUseFontIconForImage())
			setIconSclass("z-icon-History");
		else
			setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_HISTORY_PNG));
		
		DateRangePicker popup = new DateRangePicker(editor, editor2);
		this.addEventListener(Events.ON_CLICK, event -> {
			Window window = null;
			Component component = this.getParent();
			while(component != null) {
				if (component instanceof Window w) {
					window = w;
					break;
				} else {
					component = component.getParent();
				}
			}
			// Popup must be a child of highlighted parent, otherwise combobox wouldn't work
			// https://tracker.zkoss.org/browse/ZK-5740
			if (window != null && "highlighted".equals(window.getMode())) {
				window.appendChild(popup);
			} else {
				popup.setPage(this.getPage());
			}
			popup.open(this, "after_center");
			LayoutUtils.autoDetachOnClose(popup);
		});

		editor.addDynamicDisplayListener(this);
		onDynamicDisplay(Env.getCtx(), editor);
	}

	@Override
	public void onDynamicDisplay(Properties ctx, WEditor editor) {
		setVisible(this.editor.isVisible() && editor2.isVisible());
		setDisabled(!(this.editor.isReadWrite() && editor2.isReadWrite()));
	}


	/**
	 * set visibility of date button
	 * @param visible
	 */
	public void setDateButtonVisible(boolean visible) {
		if (editor instanceof WDateEditor && editor2 instanceof WDateEditor) {
			WDateEditor de1 = (WDateEditor) editor;
			WDateEditor de2 = (WDateEditor) editor2;
			de1.getComponent().setButtonVisible(visible);
			de2.getComponent().setButtonVisible(visible);
		}
	}
}
