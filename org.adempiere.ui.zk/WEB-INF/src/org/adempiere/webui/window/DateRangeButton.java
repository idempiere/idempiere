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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.theme.ThemeManager;
import org.zkoss.zk.ui.event.Events;

/**
*
* @author Peter Takacs, Cloudempiere
*
*/
public class DateRangeButton extends ToolBarButton {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4404182204288841866L;

	private static final String IMAGES_CONTEXT_HISTORY_PNG = "images/History16.png";
	
	private WEditor editor;
	private WEditor editor2;
	
	/**
	 * Constructor
	 */
	public DateRangeButton(WEditor editor, WEditor editor2) {
		super();
		this.editor = editor;
		this.editor2 = editor2;
		init();
	}
	
	private void init() {
		
		if (ThemeManager.isUseFontIconForImage())
			setIconSclass("z-icon-History");
		else
			setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_HISTORY_PNG));
		
		DateRangePicker popup = new DateRangePicker(editor, editor2);
		this.setTooltip(popup);
		this.addEventListener(Events.ON_CLICK, event -> {
			popup.setPage(this.getPage());
			popup.open(this, "after_end");
			LayoutUtils.autoDetachOnClose(popup);
		});
	}
}
