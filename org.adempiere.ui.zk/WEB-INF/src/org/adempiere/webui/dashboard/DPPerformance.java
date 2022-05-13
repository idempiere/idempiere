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

import org.adempiere.util.ContextRunnable;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.DesktopRunnable;
import org.adempiere.webui.apps.graph.WPAPanel;
import org.adempiere.webui.apps.graph.WPerformanceIndicator.Options;
import org.adempiere.webui.util.ServerPushTemplate;
import org.compiere.Adempiere;
import org.compiere.model.MGoal;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
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

	private WPAPanel paPanel;
	
	public DPPerformance()
	{
		super();
		setSclass("performance-widget");
		// have to add at least a child component, other it will be remove from DashboardController
		// and can't update when finish load data
		paPanel = new WPAPanel();
		appendChild(paPanel);
		Adempiere.getThreadPoolExecutor().submit(new DesktopRunnable(new LoadPerfomanceData(this), Executions.getCurrent().getDesktop()));
	}
	
	static class LoadPerfomanceData extends ContextRunnable{
		private DPPerformance parentCtr;
		public LoadPerfomanceData (DPPerformance parentCtr){
			this.parentCtr = parentCtr;
		}
		
		@Override
		protected void doRun() {
			MGoal [] performanceData = WPAPanel.loadGoal();

			AEnv.executeAsyncDesktopTask(new Runnable() {
				@Override
				public void run() {
					if (performanceData !=  null && performanceData.length > 0){
						parentCtr.paPanel.setGoals(performanceData, (Options)null);
						if (parentCtr.getAttribute(ON_POST_RENDER_ATTR) == null) {
							parentCtr.setAttribute(ON_POST_RENDER_ATTR, Boolean.TRUE);
							Events.echoEvent("onPostRender", parentCtr, null);
						}
					}
				}
			});
			
		}
		
	}
	
	public void refresh(ServerPushTemplate template) {
		super.refresh(template);
		if (Executions.getCurrent() != null) {
			if (this.getAttribute(ON_POST_RENDER_ATTR) == null && paPanel.getChildren().size() > 0) {
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
				if (this.getAttribute(ON_POST_RENDER_ATTR) == null && paPanel.getChildren().size() > 0) {
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
			int timeout = MSysConfig.getIntValue(MSysConfig.ZK_DASHBOARD_PERFORMANCE_TIMEOUT, 500, Env.getAD_Client_ID(Env.getCtx()));
			Component grid = this.getFirstChild().getFirstChild();
			String script = "setTimeout(function() { let grid = jq('#" + grid.getUuid() + "');";
			script = script + "grid.parent().height(grid.css('height'));}, " + timeout + ");";
			if (Executions.getCurrent() != null)
				Clients.response(new AuScript(script));
			this.getFirstChild().invalidate();
		}
	}
}
