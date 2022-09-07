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
package org.idempiere.zk.billboard;

import java.io.Serializable;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.zkoss.json.JSONArray;
import org.zkoss.json.JSONObject;
import org.zkoss.zk.au.AuRequest;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.CategoryModel;
import org.zkoss.zul.ChartModel;
import org.zkoss.zul.DialModel;
import org.zkoss.zul.PieModel;
import org.zkoss.zul.event.ChartDataEvent;
import org.zkoss.zul.event.ChartDataListener;
import org.zkoss.zul.impl.XulElement;

/**
 * 
 * @author hengsin
 *
 */
public class Billboard extends XulElement {	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3888636406033151303L;

	// Must
	private ChartModel _model;
	
	private ChartDataListener _dataListener;

	// Optional
	private String _title = "";
	private String _type = "line";
	private String _orient = "vertical";
	private Map<String, Object> _rendererOptions;
	private Map<String, Object> _legend;
	private boolean timeSeries = false;
	private String timeSeriesInterval = "1 months"; //"1 days", "1 year", "1 weeks"
	private String timeSeriesFormat = "%b %Y"; //%Y - year, %m - month, %#d - day
	private String tickAxisLabel = null;
	private String valueAxisLabel = null;
	private String[] seriesColors = null;
	private int xAxisAngle = 0;
	
	public static final String ON_DATA_CLICK_EVENT = "onDataClick";
	
	public static final String VERTICAL_ORIENTATION = "vertical";
	public static final String HORIZONTAL_ORIENTATION = "horizontal";
	
	// Event Listener
	static {
        addClientEvent(Billboard.class, Events.ON_CLICK, CE_IMPORTANT);
        addClientEvent(Billboard.class, ON_DATA_CLICK_EVENT, CE_IMPORTANT);
    }	

	@Override
	protected void renderProperties(org.zkoss.zk.ui.sys.ContentRenderer renderer)
			throws java.io.IOException {
		super.renderProperties(renderer);
		
		render(renderer, "type", _type);
		render(renderer, "title", _title);
		render(renderer, "orient", _orient);
		render(renderer, "timeSeries", timeSeries);
		render(renderer, "xAxisAngle", xAxisAngle);
		if (timeSeries) {
			if (timeSeriesInterval != null)
				render(renderer, "timeSeriesInterval", timeSeriesInterval);
			if (timeSeriesFormat != null)
				render(renderer, "timeSeriesFormat", timeSeriesFormat);
		}
		
		String model = toJSONArray(transferToJSONObject(getModel()));
		render(renderer, "model", model);
		
		if (_rendererOptions != null && !_rendererOptions.isEmpty()) {
			JSONObject jData = mapToJSON(_rendererOptions);
			render(renderer, "rendererOptions", jData.toString());
		}
		
		if (_legend != null && !_legend.isEmpty()) {
			JSONObject jData = mapToJSON(_legend);
			render(renderer, "legend", jData.toString());
		}
		
		if (tickAxisLabel != null)
			render(renderer, "tickAxisLabel", tickAxisLabel);
		if (valueAxisLabel != null)
			render(renderer, "valueAxisLabel", valueAxisLabel);
		
		if (seriesColors != null && seriesColors.length > 0) {
			JSONArray jData = new JSONArray();
			for(String s : seriesColors) {
				jData.add(s);
			}
			render(renderer, "seriesColors", jData.toString());
		}
		/**
		 * JSON String Content
		 * "values": "X axis", "Line1":value1, "Line2": value2}
		 * [
		 * 	{"values":"Q1","'2001'":20,"'2002'":40},
		 * 	{"values":"Q2","'2001'":35,"'2002'":60},
		 * 	{"values":"Q3","'2001'":40,"'2002'":70},
		 * 	{"values":"Q4","'2001'":55,"'2002'":90}
		 * ]
		 */
	}

	private JSONObject mapToJSON(Map<String, Object> map) {
		JSONObject jData = new JSONObject();
		for(String key : map.keySet()) {
			Object value = map.get(key);
			jData.put(key, value);
		}
		return jData;
	}
	
	@Override
	public void service(AuRequest request, boolean everError) {
		if (Events.ON_CLICK.equals(request.getCommand())) {
			Events.postEvent(Events.ON_CLICK, this, request.getData());
		} else if (ON_DATA_CLICK_EVENT.equals(request.getCommand())) {
			Events.postEvent(ON_DATA_CLICK_EVENT, this, request.getData());
		} else {
			super.service(request, everError);
		}
	}
	
	private class DefaultChartDataListener implements ChartDataListener, Serializable {
		private static final long serialVersionUID = 20091125153002L;

		public void onChange(ChartDataEvent event) {
			invalidate(); // Force redraw
		}
	}

	/**
	 * 
	 * @return {@link ChartModel}
	 */
	public ChartModel getModel() {
		return _model;
	}

	/**
	 * 
	 * @param model
	 */
	public void setModel(ChartModel model) {
		if (_model != model) {
			if (_model != null)
				_model.removeChartDataListener(_dataListener);
			
			_model = model;
			
			if (_dataListener == null) {
				_dataListener = new DefaultChartDataListener();
				_model.addChartDataListener(_dataListener);
			}
			invalidate(); // Always redraw
		}
	}

	/**
	 * 
	 * @return chart title
	 */
	public String getTitle() {
		return _title;
	}

	/**
	 * set chart title
	 * @param title
	 */
	public void setTitle(String title) {
		if(!title.equals(this._title)) {
			this._title = title;
			smartUpdate("title", _title);
			invalidate();
		}
	}

	/**
	 * 
	 * @return chart type
	 */
	public String getType() {
		return _type;
	}

	/**
	 * set chart type
	 * @param type
	 */
	public void setType(String type) {
		if(!type.equals(this._type)) {
			if(isValid(type)) {
				this._type = type;
				smartUpdate("type", _type);
				invalidate(); // Always redraw
			}
		}
	}
	
	/**
	 * 
	 * @return chart orientation (horizontal or vertical)
	 */
	public String getOrient() {
		return _orient;
	}

	/**
	 * set chart orientation
	 * @param orient
	 */
	public void setOrient(String orient) {
		if(!orient.equals(this._orient)) {
			this._orient = orient;
			smartUpdate("orient", _orient);
			invalidate();
		}
	}

	/**
	 * 
	 * @param key
	 * @param value
	 */
	public void addRendererOptions(String key, Object value) {
		if (_rendererOptions == null)
			_rendererOptions = new HashMap<String, Object>();
		_rendererOptions.put(key, value);
	}
	
	/**
	 * 
	 * @param key
	 * @param value
	 */
	public void addLegendOptions(String key, Object value) {
		if (_legend == null)
			_legend = new HashMap<String, Object>();
		_legend.put(key, value);
	}
	
	@SuppressWarnings("rawtypes")
	private List<JSONObject> transferToJSONObject(ChartModel model) {
		LinkedList<JSONObject> list = new LinkedList<JSONObject>();
		
		if (model == null || _type == null)
			return list;
		
		if ("gauge".equals(_type)) {
			DialModel dialModel = (DialModel) model;
			JSONObject json = new JSONObject();
			json.put("value", new double[]{dialModel.getValue(0)});
			list.add(json);
		}
		else if ("pie".equals(_type) || "donut".equals(_type)) {
			PieModel tempModel = (PieModel) model;
			for (int i = 0; i < tempModel.getCategories().size(); i++) {
				Comparable category = tempModel.getCategory(i);
				JSONObject json = new JSONObject();
				json.put("category", category);
				json.put("value", tempModel.getValue(category));
				list.add(json);
			}
		
		} else {
			CategoryModel tempModel = (CategoryModel) model;
			int seriesLength = tempModel.getSeries().size();
			for (int j = 0; j < seriesLength; j++) {
				Comparable series = tempModel.getSeries(j);
				for (int i = 0; i < tempModel.getCategories().size(); i++) {
					Comparable category = tempModel.getCategory(i);
					Number value = tempModel.getValue(series, category);
					if (value != null) {
						JSONObject jData = new JSONObject();
						jData.put("category", category);
						jData.put("series", series);
						jData.put("value", value != null ? value : 0.00d);
						list.add(jData);
					}
				}
			}
		}
		
		return list;
	}
	
	// Helper
	private static String toJSONArray(List<JSONObject> list) {
		// list may be null.
		if (list == null || list.isEmpty())
			return "";
		
	    final StringBuffer sb = new StringBuffer().append('[');
	    for (Iterator<JSONObject> it = list.iterator(); it.hasNext();) {
	    	String s = String.valueOf(it.next());
            sb.append(s).append(',');
	    }
	    sb.deleteCharAt(sb.length() - 1);
	    sb.append(']');
	    return sb.toString().replaceAll("\\\\", "");
	}
	
	//supported chart type
	private static final List<Object> _VALID_TYPES = Arrays.asList(new Object[] {
		"pie", "line", "bar", "area", "stacked_bar", "stacked_area", "gauge", "donut", "waterfall"
	});
	
	private static boolean isValid(String type) {
		return _VALID_TYPES.contains(type);
	}
	
	/**
	 * The default zclass is "z-billboard"
	 */
	public String getZclass() {
		return (this._zclass != null ? this._zclass : "z-billboard");
	}

	/**
	 * 
	 * @param show
	 * @param insideGrid
	 */
	public void setLegend(boolean show, boolean insideGrid) {
		if (show) {
			addLegendOptions("show", Boolean.TRUE);
			if (insideGrid) {
				addLegendOptions("placement", "insideGrid");
			} else {
				addLegendOptions("placement", "outsideGrid");
			}
		}
	}

	/**
	 * 
	 * @return x axis label
	 */
	public String getTickAxisLabel() {
		return tickAxisLabel;
	}

	/**
	 * set x axis label
	 * @param tickAxisLabel
	 */
	public void setTickAxisLabel(String tickAxisLabel) {
		this.tickAxisLabel = tickAxisLabel;
	}

	/**
	 * 
	 * @return y axis label
	 */
	public String getValueAxisLabel() {
		return valueAxisLabel;
	}

	/**
	 * set y axis label
	 * @param valueAxisLabel
	 */
	public void setValueAxisLabel(String valueAxisLabel) {
		this.valueAxisLabel = valueAxisLabel;
	}

	/**
	 * 
	 * @return true if it is time series chart
	 */
	public boolean isTimeSeries() {
		return timeSeries;
	}
	
	/**
	 * 
	 * @param _timeSeries
	 */
	public void setTimeSeries(boolean _timeSeries) {
		this.timeSeries = _timeSeries;
	}

	/**
	 * 
	 * @return time series interval
	 */
	public String getTimeSeriesInterval() {
		return timeSeriesInterval;
	}

	/**
	 * 
	 * @param _timeSeriesInterval
	 */
	public void setTimeSeriesInterval(String _timeSeriesInterval) {
		this.timeSeriesInterval = _timeSeriesInterval;
	}

	/**
	 * 
	 * @return time series format
	 */
	public String getTimeSeriesFormat() {
		return timeSeriesFormat;
	}

	/**
	 * set time series format
	 * @param timeSeriesFormat
	 */
	public void setTimeSeriesFormat(String timeSeriesFormat) {
		this.timeSeriesFormat = timeSeriesFormat;
	}

	public String[] getSeriesColors() {
		return seriesColors;
	}

	public void setSeriesColors(String[] seriesColors) {
		this.seriesColors = seriesColors;
	}

	public int getXAxisAngle() {
		return xAxisAngle;
	}

	public void setXAxisAngle(int xAxisAngle) {
		this.xAxisAngle = xAxisAngle;
	}
}
