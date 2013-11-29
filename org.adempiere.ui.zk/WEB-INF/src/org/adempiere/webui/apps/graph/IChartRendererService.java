/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.webui.apps.graph;

import org.adempiere.webui.apps.graph.model.ChartModel;
import org.adempiere.webui.apps.graph.model.GoalModel;
import org.adempiere.webui.apps.graph.model.IndicatorModel;
import org.zkoss.zk.ui.Component;

/**
 * Chart renderer service. Note that implementation must be thread safe.
 * @author hengsin
 *
 */
public interface IChartRendererService {
	
	/**
	 * render indicator chart for PA_Goal
	 * @param parent
	 * @param chartWidth
	 * @param chartHeight
	 * @param model
	 */
	public void renderPerformanceIndicator(Component parent, int chartWidth, int chartHeight, IndicatorModel model);
	
	/**
	 * render chart for PA_Goal
	 * @param parent
	 * @param chartWidth
	 * @param chartHeight
	 * @param goalModel
	 */
	public void renderPerformanceGraph(Component parent, int chartWidth, int chartHeight, GoalModel goalModel);
	
	/**
	 * render chart for AD_Chart
	 * @param parent
	 * @param width
	 * @param height
	 * @param chartModel
	 */
	public void renderChart(Component parent, int width, int height, ChartModel chartModel);
}