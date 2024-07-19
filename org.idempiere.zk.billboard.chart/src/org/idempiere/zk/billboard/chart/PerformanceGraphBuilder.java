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

import java.awt.Font;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.adempiere.apps.graph.GraphColumn;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.graph.model.GoalModel;
import org.adempiere.webui.apps.graph.model.IndicatorModel;
import org.adempiere.webui.component.ZkCssHelper;
import org.compiere.model.MColorSchema;
import org.compiere.model.MGoal;
import org.compiere.model.MQuery;
import org.compiere.model.X_PA_Goal;
import org.idempiere.zk.billboard.Billboard;
import org.zkoss.json.JSONObject;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.CategoryModel;
import org.zkoss.zul.DialModel;
import org.zkoss.zul.DialModelRange;
import org.zkoss.zul.DialModelScale;
import org.zkoss.zul.PieModel;
import org.zkoss.zul.SimpleCategoryModel;
import org.zkoss.zul.SimplePieModel;

/**
 * 
 * @author hengsin
 *
 */
public class PerformanceGraphBuilder {

	public Billboard createIndicatorChart(IndicatorModel model) {
		Billboard billboard = new Billboard();
		billboard.setType("gauge");
		DialModel dialModel = createDialModel(model);
		buildDialRendererOptions(billboard, dialModel);
		billboard.setModel(dialModel);
		return billboard;
	}
	
	private void buildDialRendererOptions(Billboard billboard, DialModel dialModel) {
		DialModelScale dialScale = dialModel.getScale(0);
		billboard.addRendererOptions("min", 0);
		billboard.addRendererOptions("max", dialScale.getScaleUpperBound());
		List<Double> intervals = new ArrayList<Double>();
		List<String> intervalColors = new ArrayList<String>();
		for(int i = 0; i < dialScale.rangeSize(); i++) {
			DialModelRange dialRange = dialScale.getRange(i);
			double upperBound = dialRange.getUpperBound();
			intervals.add(upperBound);
			intervalColors.add(dialRange.getRangeColor());
		}
		List<Double> ticks = new ArrayList<Double>(intervals);
		ticks.add(0, 0d);
		billboard.addRendererOptions("ticks", ticks.toArray(new Double[0]));
		billboard.addRendererOptions("intervals", intervals.toArray(new Double[0]));		
		billboard.addRendererOptions("intervalColors", intervalColors.toArray(new String[0]));
		billboard.addRendererOptions("tickColor", dialScale.getTickColor());
		billboard.addRendererOptions("background", dialModel.getFrameBgColor());
	}
	
	private  DialModel createDialModel(IndicatorModel model)
	{
		DialModel dialModel = new DialModel();
		
        MColorSchema colorSchema = model.goalModel.getColorSchema();
        int upperBound = 0;
        int [] rangeBounds = new int[]{colorSchema.getMark1Percent(), colorSchema.getMark2Percent(), colorSchema.getMark3Percent(), colorSchema.getMark4Percent()};
        for (int rangeBound : rangeBounds)
        {
        	if (rangeBound > upperBound) 
        	{
        		if (rangeBound == 9999)
        		{
        			upperBound = (int) Math.floor(upperBound*1.5);
        			break;
        		}
        		else
        		{
        			upperBound = rangeBound;
        		}
        	}
        }
        DialModelScale dialScale = dialModel.newScale(0, upperBound, 180, -180, colorSchema.getMark2Percent() - colorSchema.getMark1Percent(), 5);
        int rangeLo = 0;
        for (int rangeHi : rangeBounds){
            if (rangeHi==9999)
            	rangeHi = (int) Math.floor(rangeLo*1.5);
            if (rangeLo < rangeHi) {            	
                dialScale.newRange(rangeLo, rangeHi, "#"+ZkCssHelper.createHexColorString(colorSchema.getColor(rangeHi)), 0.5, 0.5);
            	rangeLo = rangeHi;
            }
        }

        dialModel.setFrameBgColor("#"+ZkCssHelper.createHexColorString(model.dialBackground));        
        dialScale.setTickFont(new Font("SansSerif", Font.BOLD, 8));
        dialScale.setValueFont(new Font("SansSerif", Font.BOLD, 8));
        dialModel.setFrameFgColor("#000000");
        dialScale.setTickColor("#"+ZkCssHelper.createHexColorString(model.tickColor));        
        //
        dialScale.setValue(model.goalModel.getPercent());
        return dialModel;
	}
	
	public Billboard createPerformanceChart(GoalModel goalModel, int chartWidth, int chartHeight) {
		if(X_PA_Goal.CHARTTYPE_BarChart.equals(goalModel.chartType))
		{
			return createBarChart(goalModel, chartWidth, chartHeight);
		}
		else if (X_PA_Goal.CHARTTYPE_PieChart.equals(goalModel.chartType))
		{
			return createPieChart(goalModel, chartWidth, chartHeight);
		}
		else if (X_PA_Goal.CHARTTYPE_AreaChart.equals(goalModel.chartType))
		{
			return createAreaChart(goalModel, chartWidth, chartHeight);
		}
		else if (X_PA_Goal.CHARTTYPE_LineChart.equals(goalModel.chartType))
		{
			return createLineChart(goalModel, chartWidth, chartHeight);
		}
		else if (X_PA_Goal.CHARTTYPE_RingChart.equals(goalModel.chartType))
		{
			return createDonutChart(goalModel, chartWidth, chartHeight);
		}
		else if (X_PA_Goal.CHARTTYPE_WaterfallChart.equals(goalModel.chartType))
		{
			return createWaterfallChart(goalModel, chartWidth, chartHeight);
		}
		else
		{
			throw new IllegalArgumentException("unknown chart type=" + goalModel.chartType);
		}
	}
	
	private Billboard createWaterfallChart(GoalModel goalModel, int chartWidth,
			int chartHeight) {
		Billboard billboard = new Billboard();
		billboard.setType("waterfall");
		CategoryModel chartModel = createWaterfallModel(goalModel);
		billboard.setModel(chartModel);
		billboard.setStyle("width: " + chartWidth + "px" +
				"; height: "+chartHeight+"px");
		billboard.addEventListener("onDataClick", new ZoomListener(goalModel, chartModel.getCategories().toArray(new Comparable<?>[0])));
		if (goalModel.showTitle)
			billboard.setTitle(goalModel.goal.getMeasure().getName());
		billboard.setTickAxisLabel(goalModel.xAxisLabel);
		billboard.setValueAxisLabel(goalModel.yAxisLabel);
		billboard.setLegend(false, false);
		buildRendererOptions(billboard, goalModel);
		return billboard;
	}

	private Billboard createDonutChart(GoalModel goalModel, int chartWidth,
			int chartHeight) {
		Billboard billboard = new Billboard();
		billboard.setType("donut");
		PieModel chartModel = new SimplePieModel();
		List<GraphColumn> list = goalModel.columnList;
		for (int i = 0; i < list.size(); i++){
			chartModel.setValue(list.get(i).getLabel(), list.get(i).getValue());
		}
		billboard.setModel(chartModel);
		billboard.setStyle("width: " + chartWidth + "px" +
				"; height: "+chartHeight+"px");
		billboard.setLegend(true, true);
		billboard.addEventListener("onDataClick", new ZoomListener(goalModel, chartModel.getCategories().toArray(new Comparable<?>[0])));
		if (goalModel.showTitle)
			billboard.setTitle(goalModel.goal.getMeasure().getName());
		return billboard;
	}

	private Billboard createLineChart(GoalModel goalModel, int chartWidth,
			int chartHeight) {
		Billboard billboard = new Billboard();
		billboard.setType("line");
		CategoryModel chartModel = createCategoryModel(goalModel, true);
		billboard.setModel(chartModel);
		billboard.setStyle("width: " + chartWidth + "px" +
				"; height: "+chartHeight+"px");
		billboard.addEventListener("onDataClick", new ZoomListener(goalModel, chartModel.getCategories().toArray(new Comparable<?>[0])));
		if (goalModel.showTitle)
			billboard.setTitle(goalModel.goal.getMeasure().getName());
		billboard.setTickAxisLabel(goalModel.xAxisLabel);
		billboard.setValueAxisLabel(goalModel.yAxisLabel);
		billboard.setLegend(false, false);
		buildRendererOptions(billboard, goalModel);
		return billboard;
	}

	private Billboard createAreaChart(GoalModel goalModel, int chartWidth,
			int chartHeight) {
		Billboard billboard = new Billboard();
		billboard.setType("area");
		CategoryModel chartModel = createCategoryModel(goalModel, true);
		billboard.setModel(chartModel);
		billboard.setStyle("width: " + chartWidth + "px" +
				"; height: "+chartHeight+"px");
		billboard.addEventListener("onDataClick", new ZoomListener(goalModel, chartModel.getCategories().toArray(new Comparable<?>[0])));
		billboard.setLegend(false, false);
		if (goalModel.showTitle)
			billboard.setTitle(goalModel.goal.getMeasure().getName());
		billboard.setTickAxisLabel(goalModel.xAxisLabel);
		billboard.setValueAxisLabel(goalModel.yAxisLabel);
		buildRendererOptions(billboard, goalModel);
		return billboard;
	}

	private Billboard createPieChart(GoalModel goalModel, int chartWidth,
			int chartHeight) {
		Billboard billboard = new Billboard();
		billboard.setType("pie");
		PieModel chartModel = new SimplePieModel();
		List<GraphColumn> list = goalModel.columnList;
		for (int i = 0; i < list.size(); i++){
			chartModel.setValue(list.get(i).getLabel(), list.get(i).getValue());
		}
		billboard.setModel(chartModel);
		billboard.setStyle("width: " + chartWidth + "px" +
				"; height: "+chartHeight+"px");
		billboard.addEventListener("onDataClick", new ZoomListener(goalModel, chartModel.getCategories().toArray(new Comparable<?>[0])));
		billboard.setLegend(true, true);
		if (goalModel.showTitle)
			billboard.setTitle(goalModel.goal.getMeasure().getName());
		return billboard;
	}

	private Billboard createBarChart(final GoalModel goalModel, int chartWidth, int chartHeight) {
				
		Billboard billboard = new Billboard();
		billboard.setRenderdefer(500);
		billboard.setType("bar");
		CategoryModel chartModel = createCategoryModel(goalModel, true);
		billboard.setModel(chartModel);
		billboard.setStyle("width: " + chartWidth + "px" +
				"; height: "+chartHeight+"px");
		billboard.addEventListener("onDataClick", new ZoomListener(goalModel, chartModel.getCategories().toArray(new Comparable<?>[0])));
		if (goalModel.showTitle)
			billboard.setTitle(goalModel.goal.getMeasure().getName());
		billboard.setTickAxisLabel(goalModel.xAxisLabel);
		billboard.setValueAxisLabel(goalModel.yAxisLabel);
		billboard.setLegend(false, false);
		buildRendererOptions(billboard, goalModel);
		return billboard;
	}

	private CategoryModel createCategoryModel(GoalModel goalModel, boolean linear) {
		CategoryModel chartModel = new SimpleCategoryModel();
		List<GraphColumn> list = goalModel.columnList;
		for (int i = 0; i < list.size(); i++){
			String series = goalModel.xAxisLabel;
			if (!linear) {
				if (list.get(i).getDate() != null) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(list.get(i).getDate());
					series = Integer.toString(cal.get(Calendar.YEAR));
				}
			}
			chartModel.setValue(series, list.get(i).getLabel(), list.get(i).getValue());
		}
		return chartModel;
	}

	private CategoryModel createWaterfallModel(GoalModel goalModel) {
		return createCategoryModel(goalModel, true);
	}
	
	private void buildRendererOptions(Billboard billboard, GoalModel goalModel) {
		List<Double> intervals = new ArrayList<Double>();
		List<String> intervalColors = new ArrayList<String>();
		MColorSchema colorSchema = goalModel.goal.getColorSchema();
		int upperBound = 0;
		int [] rangeBounds = new int[]{colorSchema.getMark1Percent(), colorSchema.getMark2Percent(), colorSchema.getMark3Percent(), colorSchema.getMark4Percent()};
		for (int rangeBound : rangeBounds)
		{
			if (rangeBound > upperBound) 
			{
				if (rangeBound == 9999)
				{
					upperBound = (int) Math.floor(upperBound*1.5);
					break;
				}
				else
				{
					upperBound = rangeBound;
				}
			}
		}
		int rangeLo = 0;
		for (int rangeHi : rangeBounds){
		    if (rangeHi==9999)
		    	rangeHi = (int) Math.floor(rangeLo*1.5);
		    if (rangeLo < rangeHi) {         
		    	intervals.add(Double.valueOf(rangeHi));
				intervalColors.add("#"+ZkCssHelper.createHexColorString(colorSchema.getColor(rangeHi)));
		    	rangeLo = rangeHi;
		    }
		}
		billboard.addRendererOptions("intervals", intervals.toArray(new Double[0]));		
		billboard.addRendererOptions("intervalColors", intervalColors.toArray(new String[0]));
	}
	
	private static class ZoomListener implements EventListener<Event> {
		private GoalModel goalModel;
		private Comparable<?>[] categories;

		private ZoomListener(GoalModel goalModel, Comparable<?>[] comparables) {
			this.goalModel = goalModel;
			this.categories = comparables;
		}
		
		@Override
		public void onEvent(Event event) throws Exception {
			JSONObject json = (JSONObject) event.getData();
			Number pointIndex = (Number) json.get("pointIndex");
			if (pointIndex == null)
				pointIndex = Integer.valueOf(0);
			Comparable<?> categoryLabel = categories[pointIndex.intValue()];
			List<GraphColumn> list = goalModel.columnList;
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getLabel().equals(categoryLabel)) {
					zoom(goalModel.goal, list.get(i));
					return;
				}
			}				
		}
		
		private void zoom(MGoal goal, GraphColumn graphColumn) {
			MQuery query = graphColumn.getMQuery(goal);
			if (query != null)
				AEnv.zoom(query);
		}

	}
}
