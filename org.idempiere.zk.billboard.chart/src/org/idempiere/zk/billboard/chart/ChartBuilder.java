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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MChart;
import org.compiere.model.MChartDatasource;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.zk.billboard.Billboard;
import org.zkoss.zul.CategoryModel;
import org.zkoss.zul.ChartModel;
import org.zkoss.zul.PieModel;
import org.zkoss.zul.SimpleCategoryModel;
import org.zkoss.zul.SimplePieModel;
import org.zkoss.zul.SimpleXYModel;
import org.zkoss.zul.XYModel;

/**
 * Render AD_Chart using zk-billboard.
 * Note: 3d chart not supported by zk-billboard
 * @author hengsin
 *
 */
public class ChartBuilder {

	private final static CLogger log = CLogger.getCLogger(ChartBuilder.class);
	protected final SimpleDateFormat tsDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	private MChart mChart;
	private HashMap<String,MQuery> queries;
	private ChartModel chartModel;
	private Date minDate;
	private Date maxDate;
	
	public ChartBuilder(MChart chart) {
		this.mChart = chart;
	}
	
	/**
	 *
	 * @param type
	 * @return Billboard
	 */
	public Billboard createChart() {		
		String type = mChart.getChartType();
		
		if (MChart.CHARTTYPE_BarChart.equals(type))
		{
			if (mChart.isTimeSeries())
				return createXYBarChart();
			return createBarChart();
		}
		else if (MChart.CHARTTYPE_3DBarChart.equals(type))
		{
			return create3DBarChart();
		}
		else if (MChart.CHARTTYPE_StackedBarChart.equals(type))
		{
			if (mChart.isTimeSeries())
				return createXYBarChart();
			return createStackedBarChart();
		}
		else if (MChart.CHARTTYPE_3DStackedBarChart.equals(type))
		{
			return create3DStackedBarChart();
		}
		else if (MChart.CHARTTYPE_3DPieChart.equals(type))
		{
			return create3DPieChart();
		}
		else if (MChart.CHARTTYPE_PieChart.equals(type))
		{
			return createPieChart();
		}
		else if (MChart.CHARTTYPE_3DLineChart.equals(type))
		{
			return create3DLineChart();
		}
		else if (MChart.CHARTTYPE_AreaChart.equals(type))
		{
			return createAreaChart();
		}
		else if (MChart.CHARTTYPE_StackedAreaChart.equals(type))
		{
			return createStackedAreaChart();
		}
		else if (MChart.CHARTTYPE_LineChart.equals(type))
		{
			if (mChart.isTimeSeries())
				return createTimeSeriesChart();
			return createLineChart();
		}
		else if (MChart.CHARTTYPE_RingChart.equals(type))
		{
			return createRingChart();
		}
		else if (MChart.CHARTTYPE_WaterfallChart.equals(type))
		{
			return createWaterfallChart();
		}
		else
		{
			throw new IllegalArgumentException("unknown chart type=" + type);
		}
	}

	public void loadData() {
		queries = new HashMap<String,MQuery>();
		for ( MChartDatasource ds : mChart.getDatasources() )
		{
			addData(ds);
		}
	}

	private void addData(MChartDatasource ds) {
		
		String value = ds.getValueColumn();
		String category;
		String unit = "D";
		
		if ( !mChart.isTimeSeries() )
			category = ds.getCategoryColumn();
		else 
		{
			if ( mChart.getTimeUnit().equals(MChart.TIMEUNIT_Week))
			{
				unit = "W";
			}
			else if ( mChart.getTimeUnit().equals(MChart.TIMEUNIT_Month))
			{
				unit = "MM";
			}
			else if ( mChart.getTimeUnit().equals(MChart.TIMEUNIT_Quarter))
			{
				unit = "Q";
			}
			else if ( mChart.getTimeUnit().equals(MChart.TIMEUNIT_Year))
			{
				unit = "Y";
			}
			
			category = " TRUNC(" + ds.getDateColumn() + ", '" + unit + "') ";
		}
		
		String series = DB.TO_STRING(ds.get_Translation(MChartDatasource.COLUMNNAME_Name));
		boolean hasSeries = false;
		if (ds.getSeriesColumn() != null)
		{
			series = ds.getSeriesColumn();
			hasSeries = true;
		}
		
		String where = ds.getWhereClause();
		if ( !Util.isEmpty(where))
		{
			where = Env.parseContext(Env.getCtx(), mChart.getWindowNo(), where, true);
		}
		
		boolean hasWhere = false;
		
		String sql = "SELECT " + value + ", " + category  + ", " + series
		+ " FROM " + ds.getFromClause();
		if ( !Util.isEmpty(where))
		{
			sql += " WHERE " + where;
			hasWhere = true;
		}
		
		Date currentDate = Env.getContextAsDate(Env.getCtx(), "#Date");
		Date startDate = null;
		Date endDate = null;
		
		int scope = mChart.getTimeScope();
		int offset = ds.getTimeOffset();
		
		if ( mChart.isTimeSeries() && scope != 0 )
		{
			offset += -scope;
			startDate = increment(currentDate, mChart.getTimeUnit(), offset);
			endDate = increment(startDate, mChart.getTimeUnit(), scope);
		}
		
		if ( startDate != null && endDate != null )
		{
			sql += hasWhere ? " AND " : " WHERE ";
			sql += category + ">=TRUNC(" + DB.TO_DATE(new Timestamp(startDate.getTime())) + ", '" + unit + "') AND ";
			sql += category + "<=TRUNC(" + DB.TO_DATE(new Timestamp(endDate.getTime())) + ", '" + unit + "') ";
		}

		if (sql.indexOf('@') >= 0) {
			sql = Env.parseContext(Env.getCtx(), 0, sql, false, true);
		}

		MRole role = MRole.getDefault(Env.getCtx(), false);
		sql = role.addAccessSQL(sql, null, true, false);
		
		if (hasSeries)
			sql += " GROUP BY " + series + ", " + category + " ORDER BY " + series + ", "  + category;
		else
			sql += " GROUP BY " + category + " ORDER BY " + category;
		
		log.log(Level.FINE, sql);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChartModel dataset = getChartModel();
		minDate = null;
		maxDate = null;

		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				String key = rs.getString(2);
				String seriesName = rs.getString(3);
				if (seriesName == null)
					seriesName = ds.getName();
				String queryWhere = "";
				if ( hasWhere )
					queryWhere += where + " AND ";

				queryWhere += series + " = " + DB.TO_STRING(seriesName) + " AND " + category + " = " ;
				
				if (mChart.isTimeSeries())
				{
					Date date = rs.getDate(2);
					if (minDate == null || minDate.compareTo(date) > 0)
						minDate = date;
					if (maxDate == null || maxDate.compareTo(date) < 0)
						maxDate = date;
				}

				if ( mChart.isTimeSeries() && dataset instanceof XYModel )
				{
					XYModel xy = (XYModel) dataset;

					Date date = rs.getDate(2);
					BigDecimal tsvalue = rs.getBigDecimal(1);
					xy.addValue(seriesName, date.getTime(), tsvalue);
					key = tsDateFormat.format(date);
					queryWhere += DB.TO_DATE(new Timestamp(date.getTime()));
				}
				else {
					queryWhere += DB.TO_STRING(key);
				}

				MQuery query = new MQuery(ds.getAD_Table_ID());
				String keyCol = MTable.get(Env.getCtx(), ds.getAD_Table_ID()).getKeyColumns()[0];
				String whereClause = keyCol  + " IN (SELECT " + ds.getKeyColumn() + " FROM " 
						+ ds.getFromClause() + " WHERE " + queryWhere + " )";
				query.addRestriction(whereClause.toString());
				query.setRecordCount(1);

				HashMap<String, MQuery> map = getQueries();

				if (dataset instanceof PieModel) {
					((PieModel) dataset).setValue(key, rs.getBigDecimal(1));
					map.put(key, query);
				}
				else if ( dataset instanceof CategoryModel ) {
					((CategoryModel) dataset).setValue(seriesName, key, rs.getBigDecimal(1));
					map.put(seriesName + "__" + key, query);
				}
				else if (dataset instanceof XYModel ) {
					map.put(seriesName + "__" + key, query);
				}
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}

	private Date increment(Date lastDate, String timeUnit, int qty) {
		
		if ( lastDate == null )
			return null;
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(lastDate);
		
		if ( timeUnit.equals(MChart.TIMEUNIT_Day))
			cal.add(Calendar.DAY_OF_YEAR, qty);
		else if ( timeUnit.equals(MChart.TIMEUNIT_Week))
			cal.add(Calendar.WEEK_OF_YEAR, qty);
		else if ( timeUnit.equals(MChart.TIMEUNIT_Month))
			cal.add(Calendar.MONTH, qty);
		else if ( timeUnit.equals(MChart.TIMEUNIT_Quarter))
			cal.add(Calendar.MONTH, 3*qty);
		else if ( timeUnit.equals(MChart.TIMEUNIT_Year))
			cal.add(Calendar.YEAR, qty);
		
		return cal.getTime();
	}

	public CategoryModel getCategoryModel() {
		chartModel = new SimpleCategoryModel();
		loadData();
		return (CategoryModel) chartModel;
	}
	
	public XYModel getXYModel() {
		chartModel = new SimpleXYModel();
		loadData();
		return (XYModel) chartModel;
	}

	public PieModel getPieModel() {
		chartModel = new SimplePieModel();
		loadData();
		return (PieModel) chartModel;
	}
	
	public ChartModel getChartModel() {
		return chartModel;
	}
	
	public HashMap<String, MQuery> getQueries() {
		return queries;
	}
	
	public MQuery getQuery(String key) {
		

		if ( queries.containsKey(key) )
		{
			return queries.get(key);
		}
		
		return null;
	}

	private Billboard createXYBarChart() {
		Billboard billboard = newBillboard("bar");
		XYModel xymodel = getXYModel();
		CategoryModel model = new SimpleCategoryModel();
		Collection<Comparable<?>> seriesList = xymodel.getSeries();
		for(Comparable<?> series : seriesList) {
			int count = xymodel.getDataCount(series);
			for(int i = 0; i < count; i++) {
				Number value = xymodel.getY(series, i);
				Number category = xymodel.getX(series, i);
				Date date = new Date(category.longValue());
				String categoryLabel = null;
				categoryLabel = tsDateFormat.format(date);
				Number oldValue = model.getValue(series, categoryLabel);
				if (oldValue != null)
					value = oldValue.doubleValue() + value.doubleValue();
				model.setValue(series, categoryLabel, value);
			}
		}
		billboard.setModel(model);
		return billboard;
	}
	
	private Billboard createTimeSeriesChart() {
		Billboard billboard = newBillboard("line");
		XYModel xymodel = getXYModel();
		CategoryModel model = new SimpleCategoryModel();
		Collection<Comparable<?>> seriesList = xymodel.getSeries();
		for(Comparable<?> series : seriesList) {
			int count = xymodel.getDataCount(series);
			for(int i = 0; i < count; i++) {
				Number value = xymodel.getY(series, i);
				Number category = xymodel.getX(series, i);
				Date date = new Date(category.longValue());
				String categoryLabel = null;
				categoryLabel = tsDateFormat.format(date);
				Number oldValue = model.getValue(series, categoryLabel);
				if (oldValue != null)
					value = oldValue.doubleValue() + value.doubleValue();
				model.setValue(series, categoryLabel, value);
			}
		}
		billboard.setModel(model);
		return billboard;
	}
	
	private Billboard createWaterfallChart() {
		Billboard billboard = newBillboard("waterfall");
		CategoryModel model = getCategoryModel();
		CategoryModel waterfallModel = new SimpleCategoryModel();
		Collection<Comparable<?>> seriesList = model.getSeries();
		Map<Comparable<?>, BigDecimal> valueMap = new HashMap<Comparable<?>, BigDecimal>();
		Collection<Comparable<?>> categories = model.getCategories();
		for(Comparable<?> series : seriesList) {
			for(Comparable<?> category : categories) {
				BigDecimal value = (BigDecimal) model.getValue(series, category);
				BigDecimal diff = value;
				BigDecimal oldValue = valueMap.get(series);		
				if (oldValue != null) {
					diff = diff.subtract(oldValue);
				}
				valueMap.put(series, value);
				waterfallModel.setValue(series, category, diff);
			}
		}
		billboard.setModel(waterfallModel);		
		return billboard;
	}

	private Billboard newBillboard(String type) {
		Billboard billboard = new Billboard();
		if (mChart.isDisplayLegend()) {
			billboard.setLegend(true, false);
			billboard.addLegendOptions("location", "bottom"); //bottom, right
		}
		billboard.setTickAxisLabel(mChart.get_Translation(MChart.COLUMNNAME_DomainLabel));
		billboard.setValueAxisLabel(mChart.get_Translation(MChart.COLUMNNAME_RangeLabel));
		billboard.setTitle(mChart.get_Translation(MChart.COLUMNNAME_Name));
		billboard.setType(type);
		return billboard;
	}

	private Billboard createRingChart() {
		Billboard billboard = newBillboard("donut");
		billboard.setModel(getPieModel());
		return billboard;
	}

	private Billboard createPieChart() {
		Billboard billboard = newBillboard("pie");
		billboard.setModel(getPieModel());
		return billboard;
	}

	private Billboard create3DPieChart() {
		return createPieChart();
	}

	private Billboard createBarChart() {
		Billboard billboard = newBillboard("bar");
		billboard.setModel(getCategoryModel());
		if (MChart.CHARTORIENTATION_Vertical.equals(mChart.getChartOrientation()))
			billboard.setOrient(Billboard.VERTICAL_ORIENTATION);
		else if (MChart.CHARTORIENTATION_Horizontal.equals(mChart.getChartOrientation()))
			billboard.setOrient(Billboard.HORIZONTAL_ORIENTATION);
		return billboard;
	}

	private Billboard create3DBarChart() {
		return createBarChart();
	}

	private Billboard createStackedBarChart() {
		Billboard billboard = newBillboard("stacked_bar");
		billboard.setModel(getCategoryModel());
		if (MChart.CHARTORIENTATION_Vertical.equals(mChart.getChartOrientation()))
			billboard.setOrient(Billboard.VERTICAL_ORIENTATION);
		else if (MChart.CHARTORIENTATION_Horizontal.equals(mChart.getChartOrientation()))
			billboard.setOrient(Billboard.HORIZONTAL_ORIENTATION);
		return billboard;
	}

	private Billboard create3DStackedBarChart() {
		return createStackedBarChart();
	}

	private Billboard createAreaChart() {
		Billboard billboard = newBillboard("area");
		billboard.setModel(getCategoryModel());
		return billboard;
	}

	private Billboard createStackedAreaChart() {
		Billboard billboard = newBillboard("stacked_area");
		billboard.setModel(getCategoryModel());
		return billboard;
	}

	private Billboard createLineChart() {
		Billboard billboard = newBillboard("line");
		billboard.setModel(getCategoryModel());
		return billboard;
	}

	private Billboard create3DLineChart() {
		return createLineChart();
	}

	public Date getMinDate() {
		return minDate;
	}

	public void setMinDate(Date minDate) {
		this.minDate = minDate;
	}

	public Date getMaxDate() {
		return maxDate;
	}

	public void setMaxDate(Date maxDate) {
		this.maxDate = maxDate;
	}
}
