/***********************************************************************
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
 * - trek global													   *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.report;

import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.theme.ThemeManager;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;

/**
 * @author hengsin
 *
 */
public class LinkWindow extends Window {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3287664745149293281L;
	private String link;
	private String label;

	/**
	 * 
	 * @param link
	 * @param label
	 */
	public LinkWindow(String link, String label) {
		this.link = link;
		this.label = label;
		layout();
	}

	private void layout() {
		A a = new A();
		a.setLabel(label);
		a.setHref(link);
		a.setTarget("_blank");
		a.setStyle("font-weight: 600");
		appendChild(a);
		a.setVflex("min");
		a.setHflex("min");
		a.addEventListener(Events.ON_CLICK, evt->detach());
		ToolBarButton btn = new ToolBarButton();
		btn.setImage(ThemeManager.getThemeResource("images/X8.png"));
		btn.setStyle("position: absolute; top: 2px; right: 2px");
		appendChild(btn);
		btn.addEventListener(Events.ON_CLICK, evt -> detach());		
		setPosition("center, center");
		setStyle("padding: 32px;background-color: white;");
		setBorder(true);
		setShadow(true);		
	}

}
