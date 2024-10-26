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
 **********************************************************************/
package org.adempiere.webui.window;

import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Urlbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WImageURLEditor;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Vlayout;

public class WImageURLDialog extends Window {

	private static final long serialVersionUID = 5623154038308907944L;
	private Urlbox url;
	private WImageURLEditor editor;
	private boolean cancel = true;
	private ConfirmPanel confirmPanel;
	
	public WImageURLDialog(WImageURLEditor editor) {
		this.editor = editor;
		layout();
	}

	private void layout() {
		Vlayout layout = new Vlayout();
		layout.setWidth("100%");
		layout.setVflex("min");
		url = new Urlbox();
		url.setText(editor.getDisplay());
		url.setHflex("1");
		url.setVflex("min");
		layout.appendChild(url);
		confirmPanel = new ConfirmPanel(true);
		layout.appendChild(confirmPanel);
		confirmPanel.addActionListener(e -> onConfirmPanelAction(e));
		confirmPanel.setHflex("1");
		confirmPanel.setVflex("min");
		addEventListener(Events.ON_CANCEL, e -> onCancel());
		addEventListener(Events.ON_OK, e -> onOk());
		appendChild(layout);
	}

	private void onCancel() {
		cancel = true;
		onOk();
	}

	private void onConfirmPanelAction(Event e) {
		if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
			onCancel();
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK))
			onOk();
	}

	private void onOk() {
		cancel = false;
		this.dispose();
	}

	/**
	 * Is dialog cancel by user
	 * @return true if cancel by user
	 */
	public boolean isCancel() {
		return cancel;
	}

	/**
	 * Get URL of image
	 * @return URL of image
	 */
	public String getValue() {
		return url.getText();
	}

	@Override
	public void focus() {
		super.focus();
		url.focus();
	}
}
