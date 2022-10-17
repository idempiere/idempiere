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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.zk.billboard.chart;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.graph.IChartRendererService;
import org.adempiere.webui.apps.graph.model.ChartModel;
import org.adempiere.webui.apps.graph.model.GoalModel;
import org.adempiere.webui.apps.graph.model.IndicatorModel;
import org.adempiere.webui.component.Label;
import org.compiere.model.MChart;
import org.compiere.model.MQuery;
import org.compiere.model.MSysConfig;
import org.compiere.util.Msg;
import org.idempiere.zk.billboard.Billboard;
import org.zkoss.json.JSONObject;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.CategoryModel;
import org.zkoss.zul.Div;
import org.zkoss.zul.PieModel;

/**
 * @author hengsin
 *
 */
@org.osgi.service.component.annotations.Component(name="org.idempiere.zk.billboard.chart.ChartRendererServiceImpl", immediate = true,
service = IChartRendererService.class, property = {"service.ranking:Integer=0"})
public class ChartRendererServiceImpl implements IChartRendererService {

	/**
	 * 
	 */
	public ChartRendererServiceImpl() {
	}

	/* (non-Javadoc)
	 */
	@Override
	public boolean renderPerformanceIndicator(Component parent, int chartWidth, int chartHeight, IndicatorModel model) {
		PerformanceGraphBuilder builder = new PerformanceGraphBuilder();
		Billboard billboard = builder.createIndicatorChart(model);
		billboard.setStyle("width: "+chartWidth+"px;height: "+chartHeight+"px;");
		parent.appendChild(billboard);
		
		return true;
	}

	@Override
	public boolean renderPerformanceGraph(Component parent, int chartWidth, int chartHeight,
			GoalModel goalModel) {
		PerformanceGraphBuilder builder = new PerformanceGraphBuilder();
		Billboard billboard = builder.createPerformanceChart(goalModel, chartWidth, chartHeight);
		parent.appendChild(billboard);
		
		return true;
	}

	@Override
	public boolean renderChart(Component parent, int width, int height,
			ChartModel chartModel, boolean showTitle) {
		ChartBuilder builder = new ChartBuilder(chartModel.chart);
		Billboard billboard = builder.createChart();
		billboard.setStyle("width: " + width + "px;" + " height: " + height + "px;");
		if (!showTitle)
			billboard.setTitle("");
		updateUI(parent, chartModel, builder, billboard, width, height);
		
		return true;
	}
	
	private void updateUI(Component parent, ChartModel chartModel, ChartBuilder builder, Billboard billboard, int width, int height)	 {		
		// set billboard time series properties
		Date minDate = builder.getMinDate();
		Date maxDate = builder.getMaxDate();
		if (chartModel.chart.isTimeSeries() && minDate != null && maxDate != null)
		{
			billboard.setTimeSeries(true);

			int noOfPeriod = 0;
			if (width < MSysConfig.getIntValue("CHART_MIN_WIDTH_3_PERIOD", 230, chartModel.chart.getAD_Client_ID()))
				noOfPeriod = 3;
			else if (width < MSysConfig.getIntValue("CHART_MIN_WIDTH_6_PERIOD", 320, chartModel.chart.getAD_Client_ID()))
				noOfPeriod = 6;
			
			Calendar c = Calendar.getInstance();
			c.setTime(maxDate);
						
			String timeUnit = chartModel.chart.getTimeUnit();
			if (chartModel.chart.getTimeScope() == 1)
			{
				if (timeUnit.equals(MChart.TIMEUNIT_Week))
					timeUnit = MChart.TIMEUNIT_Day;
				else if (timeUnit.equals(MChart.TIMEUNIT_Month))
					timeUnit = MChart.TIMEUNIT_Week;
				else if (timeUnit.equals(MChart.TIMEUNIT_Quarter))
					timeUnit = MChart.TIMEUNIT_Month;
				else if (timeUnit.equals(MChart.TIMEUNIT_Year))
					timeUnit = MChart.TIMEUNIT_Quarter;
			}
			
			if (timeUnit.equals(MChart.TIMEUNIT_Day)) 
			{
				billboard.setTimeSeriesInterval("1 days");
				billboard.setTimeSeriesFormat("%D"); // e.g. 03/26/08 %m/%d/%y
				if (noOfPeriod != 0)
					c.add(Calendar.DAY_OF_MONTH, -1 * (noOfPeriod - 1));
			}
			else if (timeUnit.equals(MChart.TIMEUNIT_Week)) 
			{
				billboard.setTimeSeriesInterval("1 weeks");
				billboard.setTimeSeriesFormat("%D"); // e.g. 03/26/08 %m/%d/%y
				if (noOfPeriod != 0)
					c.add(Calendar.WEEK_OF_YEAR, -1 * (noOfPeriod - 1));
			}
			else if (timeUnit.equals(MChart.TIMEUNIT_Month)) 
			{
				billboard.setTimeSeriesInterval("1 months");
				billboard.setTimeSeriesFormat("%Y-%m"); // e.g. 2008-09
				if (noOfPeriod != 0)
					c.add(Calendar.MONTH, -1 * (noOfPeriod - 1));
			}
			else if (timeUnit.equals(MChart.TIMEUNIT_Quarter)) 
			{
				billboard.setTimeSeriesInterval("3 months");
				billboard.setTimeSeriesFormat("%Y-%m"); // e.g. 2008-09
				if (noOfPeriod != 0)
					c.add(Calendar.MONTH, -1 * (noOfPeriod - 1) * 3);
			}
			else if (timeUnit.equals(MChart.TIMEUNIT_Year)) 
			{
				billboard.setTimeSeriesInterval("1 years");
				billboard.setTimeSeriesFormat("%Y"); // e.g. 2008
				if (noOfPeriod != 0)
					c.add(Calendar.YEAR, -1 * (noOfPeriod - 1));
			}
			
			if (noOfPeriod != 0)
			{
				Date startDate = c.getTime();
				if (minDate.before(startDate))
					minDate = startDate;
			}
			
		}
		
		parent.getChildren().clear();
		parent.appendChild(billboard);		
		
		Label label = new Label(Msg.translate(chartModel.chart.getCtx(), "NoDataAvailable"));
		Div labelDiv = new Div();
		labelDiv.setStyle("padding: 10px;");
		labelDiv.appendChild(label);
		Div div = new Div();
		div.appendChild(labelDiv);
		parent.appendChild(div);
		div.setVisible(false);
				
		if (Executions.getCurrent() != null)
		{
			String script = "var parent = jq('#" + parent.getUuid() + "');";
			script += "var billboard = parent.children().first(); ";
			script += "var div = parent.children().eq(1); ";
			script += "if (billboard.children().length == 0) {";
			script += "div.show(); ";
			script += "billboard.hide(); ";
			script += "parent.height(div.css('height')); }";
			script += "else {";
			script += "div.hide(); ";
			script += "billboard.show(); ";
			script += "}";			
			Clients.response(new AuScript(script));
		}
		
		ZoomListener listener = new ZoomListener(builder.getQueries(), billboard.getModel());
		billboard.addEventListener("onDataClick", listener);		
	}
	
	private static class ZoomListener implements EventListener<Event> {
		private Map<String, MQuery> queries;
		private org.zkoss.zul.ChartModel model;

		private ZoomListener(Map<String,MQuery> queries, org.zkoss.zul.ChartModel model) {
			this.queries = queries;
			this.model = model;
		}
		
		@Override
		public void onEvent(Event event) throws Exception {
			JSONObject json = (JSONObject) event.getData();
			Number seriesIndex = (Number) json.get("seriesIndex");
			Number pointIndex = (Number) json.get("pointIndex");
			if (pointIndex == null)
				pointIndex = Integer.valueOf(0);
			
			MQuery query = null;
			if (model instanceof PieModel) {
				PieModel pieModel = (PieModel) model;
				Object category = pieModel.getCategory(pointIndex.intValue());
				if (category != null)
					query = queries.get(category.toString());
			} else if (model instanceof CategoryModel) {
				CategoryModel categoryModel = (CategoryModel) model;
				Object series = categoryModel.getSeries(seriesIndex.intValue());
				Object category = categoryModel.getCategory(pointIndex.intValue());
				query = queries.get(series.toString()+"__"+category.toString());
			}
			if (query != null)
				AEnv.zoom(query);				
		}		
	}
}
