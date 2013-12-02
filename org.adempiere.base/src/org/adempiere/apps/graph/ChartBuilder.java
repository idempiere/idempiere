/******************************************************************************
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
package org.adempiere.apps.graph;

import java.awt.Color;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MChart;
import org.compiere.model.MChartDatasource;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_Chart;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.chart.renderer.category.StandardBarPainter;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.Dataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.general.PieDataset;
import org.jfree.data.time.Day;
import org.jfree.data.time.Month;
import org.jfree.data.time.Quarter;
import org.jfree.data.time.RegularTimePeriod;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.data.time.Week;
import org.jfree.data.time.Year;
import org.jfree.data.xy.IntervalXYDataset;

/**
 * @author Paul Bowden, Adaxa Pty Ltd 
 * @author hengsin
 *
 */
public class ChartBuilder {

	private final static CLogger log = CLogger.getCLogger(ChartBuilder.class);
	
	private MChart chartModel;
	private HashMap<String,MQuery> queries;
	private Dataset dataset;
	
	public ChartBuilder(MChart chart) {
		this.chartModel = chart;
	}
	
	/**
	 *
	 * @param type
	 * @return JFreeChart
	 */
	public JFreeChart createChart() {
		
		String type = chartModel.getChartType();
		
		if(MChart.CHARTTYPE_BarChart.equals(type))
		{
			if ( chartModel.isTimeSeries())
			{
				return createXYBarChart();
			}
			return createBarChart();
		}
		else if (MChart.CHARTTYPE_3DBarChart.equals(type))
		{
			return create3DBarChart();
		}
		else if (MChart.CHARTTYPE_StackedBarChart.equals(type))
		{

			if ( chartModel.isTimeSeries())
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
			if ( chartModel.isTimeSeries() )
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
		for ( MChartDatasource ds : chartModel.getDatasources() )
		{
			addData(ds);
		}
	}

	private void addData(MChartDatasource ds) {
		
		String value = ds.getValueColumn();
		String category;
		String unit = "D";
		
		if ( !chartModel.isTimeSeries() )
			category = ds.getCategoryColumn();
		else 
		{
			if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Week))
			{
				unit = "W";
			}
			else if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Month))
			{
				unit = "MM";
			}
			else if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Quarter))
			{
					unit = "Q";
			}
			else if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Year))
			{
						unit = "Y";
			}
			
			category = " TRUNC(" + ds.getDateColumn() + ", '" + unit + "') ";
		}
		
		String series = DB.TO_STRING(ds.getName());
		boolean hasSeries = false;
		if (ds.getSeriesColumn() != null)
		{
			series = ds.getSeriesColumn();
			hasSeries = true;
		}
		
		String where = ds.getWhereClause();
		if ( !Util.isEmpty(where))
		{
			where = Env.parseContext(Env.getCtx(), chartModel.getWindowNo(), where, true);
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
		
		int scope = chartModel.getTimeScope();
		int offset = ds.getTimeOffset();
		
		if ( chartModel.isTimeSeries() && scope != 0 )
		{
			offset += -scope;
			startDate = increment(currentDate, chartModel.getTimeUnit(), offset);
			endDate = increment(startDate, chartModel.getTimeUnit(), scope);
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
		TimeSeries tseries = null;
		Dataset dataset = getDataset();

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

				if ( chartModel.isTimeSeries() && dataset instanceof TimeSeriesCollection )
				{

					if ( tseries == null || !tseries.getKey().equals(seriesName))
					{
						if (tseries != null)
							((TimeSeriesCollection) dataset).addSeries(tseries);

						tseries = new TimeSeries(seriesName);
					}

					Date date = rs.getDate(2);
					RegularTimePeriod period = null;

					if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Day))
						period = new Day(date);
					else if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Week))
						period = new Week(date);
					else if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Month))
						period = new Month(date);
					else if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Quarter))
						period = new Quarter(date);
					else if ( chartModel.getTimeUnit().equals(MChart.TIMEUNIT_Year))
						period = new Year(date);

					tseries.add(period, rs.getBigDecimal(1));
					key = period.toString();
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

				if ( dataset instanceof DefaultPieDataset) {
					((DefaultPieDataset) dataset).setValue(key, rs.getBigDecimal(1));
					map.put(key, query);
				}
				else if ( dataset instanceof DefaultCategoryDataset ) {
				((DefaultCategoryDataset) dataset).addValue(rs.getBigDecimal(1), seriesName, key);
					map.put(seriesName + "__" + key, query);
				}
				else if (dataset instanceof TimeSeriesCollection )
				{
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

		if (tseries != null)
			((TimeSeriesCollection) dataset).addSeries(tseries);

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

	public CategoryDataset getCategoryDataset() {
		dataset = new DefaultCategoryDataset();
		loadData();
		return (CategoryDataset) dataset;
	}
	
	public IntervalXYDataset getXYDataset() {
		dataset = new TimeSeriesCollection();
		loadData();
		return (IntervalXYDataset) dataset;
	}

	public PieDataset getPieDataset() {
		dataset = new DefaultPieDataset();
		loadData();
		return (PieDataset) dataset;
	}
	
	public Dataset getDataset() {
		return dataset;
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

	private JFreeChart createXYBarChart() {
		JFreeChart chart = ChartFactory.createXYBarChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				true,
				chartModel.getRangeLabel(),                  // range axis label
				getXYDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
						chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
		
		return chart;
	}
	
	private JFreeChart createTimeSeriesChart() {
		JFreeChart chart = ChartFactory.createTimeSeriesChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getXYDataset(),                  // data
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
		
		return chart;
	}
	
	private JFreeChart createWaterfallChart() {
		JFreeChart chart = ChartFactory.createWaterfallChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
					? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
					chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart createRingChart() {
		final JFreeChart chart = ChartFactory.createRingChart(chartModel.getName(),
				getPieDataset(), chartModel.isDisplayLegend(), true, true);
	
		return chart;
	}

	private JFreeChart createPieChart() {
		final JFreeChart chart = ChartFactory.createPieChart(chartModel.getName(),
				getPieDataset(), false, true, true);
	
		return chart;
	}

	private JFreeChart create3DPieChart() {
		final JFreeChart chart = ChartFactory.createPieChart3D(chartModel.getName(),
				getPieDataset(), false, true, true);
	
		return chart;
	}

	private JFreeChart createBarChart() {
		JFreeChart chart = ChartFactory.createBarChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
	    BarRenderer renderer = new BarRenderer();
	    renderer.setBarPainter(new StandardBarPainter());
	
		CategoryPlot plot = chart.getCategoryPlot();
		plot.setRenderer(renderer);
		
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart create3DBarChart() {
		JFreeChart chart = ChartFactory.createBarChart3D(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
		
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart createStackedBarChart() {
		JFreeChart chart = ChartFactory.createStackedBarChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
	
	    BarRenderer renderer = new BarRenderer();
	    renderer.setBarPainter(new StandardBarPainter());
	
		CategoryPlot plot = chart.getCategoryPlot();
		plot.setRenderer(renderer);
	    
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart create3DStackedBarChart() {
		JFreeChart chart = ChartFactory.createStackedBarChart3D(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart createAreaChart() {
		// create the chart...
		JFreeChart chart = ChartFactory.createAreaChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart createStackedAreaChart() {
		// create the chart...
		JFreeChart chart = ChartFactory.createStackedAreaChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
	
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart createLineChart() {
		// create the chart...
		JFreeChart chart = ChartFactory.createLineChart(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
		
	
		setupCategoryChart(chart);
		return chart;
	}

	private JFreeChart create3DLineChart() {
		// create the chart...
		JFreeChart chart = ChartFactory.createLineChart3D(
				chartModel.getName(),         // chart title
				chartModel.getDomainLabel(),               // domain axis label
				chartModel.getRangeLabel(),                  // range axis label
				getCategoryDataset(),                  // data
				X_AD_Chart.CHARTORIENTATION_Horizontal.equals(chartModel.getChartOrientation()) 
				? PlotOrientation.HORIZONTAL : PlotOrientation.VERTICAL, // orientation
				chartModel.isDisplayLegend(),                     // include legend
				true,                     // tooltips?
				true                     // URLs?
		);
		
	
		setupCategoryChart(chart);
		return chart;
	}

	private void setupCategoryChart(JFreeChart chart) {
		CategoryPlot plot = chart.getCategoryPlot();
		CategoryAxis xAxis = (CategoryAxis)plot.getDomainAxis();
	    xAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
	
	    CategoryItemRenderer renderer = plot.getRenderer();
	    renderer.setSeriesPaint(0, Color.RED);
		renderer.setSeriesPaint(1, Color.BLUE);
		renderer.setSeriesPaint(2, Color.YELLOW);
		renderer.setSeriesPaint(3, Color.GREEN);
		renderer.setSeriesPaint(4, Color.ORANGE);
		renderer.setSeriesPaint(5, Color.CYAN);
		renderer.setSeriesPaint(6, Color.MAGENTA);
		renderer.setSeriesPaint(7, Color.GRAY);
		renderer.setSeriesPaint(8, Color.PINK);
		
		plot.setRenderer(renderer);
	}
}
