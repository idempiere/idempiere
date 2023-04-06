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
import org.adempiere.webui.apps.graph.WPerformanceIndicator;
import org.adempiere.webui.apps.graph.WPerformanceIndicator.Options;
import org.adempiere.webui.util.ServerPushTemplate;
import org.compiere.model.MGoal;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.util.Clients;

/**
 * Dashboard item: Performance Indicators
 * @author Elaine
 * @date November 20, 2008
 */
public class DPPerformance extends DashboardPanel {	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8878665031716441912L;

	/** performance chart panel */
	private WPAPanel paPanel;
	private MGoal[] performanceData;
	
	/**
	 * Default constructor
	 */
	public DPPerformance()
	{
		super();
		setSclass("performance-widget");
		paPanel = new WPAPanel();
		appendChild(paPanel);
		paPanel.addEventListener(WPerformanceIndicator.ON_AFTER_RENDER_CHART_EVENT, e -> onPostRender());
	}
	
	@Override
	public void refresh(ServerPushTemplate template) {
		performanceData = WPAPanel.loadGoal();
		//usually, this should be call in non UI/Event listener thread (i.e Executions.getCurrent() should be null)
		if (Executions.getCurrent() != null) {
			updateUI();			
		} else {
			template.executeAsync(this);
		}
	}
	
	/**
	 * Adjust {@link #paPanel} height to match chart/content height
	 */
	public void onPostRender() 
	{
		if (this.getFirstChild() != null)
		{
			//first child of paPanel, the Grid layout
			Component grid = this.getFirstChild().getFirstChild();
			String script = "setTimeout(function() { let grid = jq('#" + grid.getUuid() + "');";
			script = script + "grid.parent().height(grid.css('height'));}, 10);";
			if (Executions.getCurrent() != null)
				Clients.response(new AuScript(script));
		}
	}

	@Override
	public void updateUI() {
		paPanel.setGoals(performanceData, (Options)null);
		performanceData = null;
	}

	@Override
	public boolean isLazy() {
		return true;
	}
	
	@Override
	public boolean isEmpty() {
		return performanceData.length <= 0;
	}
}
