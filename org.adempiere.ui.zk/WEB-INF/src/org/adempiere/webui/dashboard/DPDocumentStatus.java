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
* - Adaxa                                                             *
* - Ashley Ramdass                                                    *
* - Deepak Pansheriya                                                 *
* - Murilo Ht                                                         *
* - Carlos Ruiz                                                       *
**********************************************************************/

package org.adempiere.webui.dashboard;

import org.adempiere.webui.apps.graph.WDocumentStatusPanel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ServerPushTemplate;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Image;
import org.zkoss.zul.Toolbar;

public class DPDocumentStatus extends DashboardPanel implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7904122964566112177L;
	private WDocumentStatusPanel statusPanel;

	@Override
	public void refresh(ServerPushTemplate template) {
		statusPanel.refresh();
		template.execute(this);
	}

	@Override
	public void updateUI() {
		statusPanel.updateUI();
	}

	public DPDocumentStatus()
	{
		super();

		statusPanel = WDocumentStatusPanel.get();
		if (statusPanel == null)
			return;
		this.appendChild(statusPanel);

		Toolbar documentStatusToolbar = new Toolbar();
		this.appendChild(documentStatusToolbar);

		if (ThemeManager.isUseFontIconForImage())
		{
			ToolBarButton btn = new ToolBarButton();
			btn.setIconSclass("z-icon-Refresh");
			btn.setSclass("trash-toolbarbutton");
			documentStatusToolbar.appendChild(btn);
			btn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
			btn.addEventListener(Events.ON_CLICK, this);
		}
		else
		{
			Image imgr = new Image(ThemeManager.getThemeResource("images/Refresh24.png"));
			documentStatusToolbar.appendChild(imgr);
			imgr.setStyle("text-align: right; cursor: pointer; width:24px; height:24px;");
			imgr.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
			imgr.addEventListener(Events.ON_CLICK, this);
		}
	}

	public void onEvent(Event event) throws Exception {
		String eventName = event.getName();

		if (eventName.equals(Events.ON_CLICK)) {
			statusPanel.refresh();
			statusPanel.updateUI();
		}
	}	
	
	@Override
	public boolean isPooling() {
		return true;
	}
}
