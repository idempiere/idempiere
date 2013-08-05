/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation
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

import org.adempiere.webui.apps.graph.WPAPanel;
import org.adempiere.webui.util.ServerPushTemplate;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;

/**
 * Dashboard item: Performance Indicators
 * @author Elaine
 * @date November 20, 2008
 */
public class DPPerformance extends DashboardPanel {

	private static final String ON_POST_RENDER_ATTR = "onPostRender.Event.Posted";
	/**
	 * 
	 */
	private static final long serialVersionUID = -8878665031716441912L;

	public DPPerformance()
	{
		super();
		setSclass("performance-widget");
		
        WPAPanel paPanel = createPAPanel();
        if (paPanel != null) 
        {
        	this.appendChild(paPanel);        	
        }
	}

	protected WPAPanel createPAPanel() {
		WPAPanel paPanel = WPAPanel.get();
		return paPanel;
	}
	
	public void refresh(ServerPushTemplate template) {
		super.refresh(template);
		if (Executions.getCurrent() != null) {
			if (this.getAttribute(ON_POST_RENDER_ATTR) == null) {
				setAttribute(ON_POST_RENDER_ATTR, Boolean.TRUE);
				Events.echoEvent("onPostRender", this, null);
			}
		}
	}
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			if (Executions.getCurrent() != null) {
				if (this.getAttribute(ON_POST_RENDER_ATTR) == null) {
					setAttribute(ON_POST_RENDER_ATTR, Boolean.TRUE);
					Events.echoEvent("onPostRender", this, null);
				}
			}
		}
	}

	//adjust window height to match grid height
	public void onPostRender() 
	{
		removeAttribute(ON_POST_RENDER_ATTR);
		if (this.getFirstChild() != null)
		{
			Component grid = this.getFirstChild().getFirstChild();
			String script = "setTimeout(function() { var grid = jq('#" + grid.getUuid() + "');";
			script = script + "grid.parent().height(grid.css('height'));}, 500);";
			if (Executions.getCurrent() != null)
				Clients.response(new AuScript(script));
		}
	}
}
