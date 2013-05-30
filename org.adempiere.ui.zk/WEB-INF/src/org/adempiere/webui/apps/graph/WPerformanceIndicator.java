/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
 * Copyright (C) 2008 Idalica Corporation                                     *
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

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.LinearGradientPaint;
import java.awt.geom.Point2D;
import java.awt.image.BufferedImage;
import java.text.DecimalFormat;
import java.util.Map;

import org.adempiere.webui.component.Panel;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.MColorSchema;
import org.compiere.model.MGoal;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.encoders.EncoderUtil;
import org.jfree.chart.encoders.ImageFormat;
import org.jfree.chart.plot.DialShape;
import org.jfree.chart.plot.MeterInterval;
import org.jfree.chart.plot.MeterPlot;
import org.jfree.data.Range;
import org.jfree.data.general.DefaultValueDataset;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Image;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;

/**
 * 	Performance Indicator
 *
 *  @author hengsin
 */
public class WPerformanceIndicator extends Panel implements EventListener<Event>
{
	public static final String TICK_COLOR = "tickColor";
	public static final String NEEDLE_COLOR = "needleColor";
	public static final String DIAL_BACKGROUND = "dialBackground";
	public static final String CHART_BACKGROUND = "chartBackground";
	/**
	 *
	 */
	private static final long serialVersionUID = 3580494126343850939L;

	public WPerformanceIndicator(MGoal goal)
	{
		this(goal, null);
	}
	
	/**
	 * 	Constructor
	 *	@param goal goal model
	 */
	public WPerformanceIndicator(MGoal goal, Options options)
	{
		if (options != null) {
			if (options.chartHeight > 0)
				chartHeight = options.chartHeight;
			if (options.chartWidth > 0)
				chartWidth = options.chartWidth;
			if (options.colorMap != null) {
				Color color = options.colorMap.get(CHART_BACKGROUND);
				if (color != null)
					chartBackground = color;
				color = options.colorMap.get(DIAL_BACKGROUND);
				if (color != null)
					dialBackground = color;
				color = options.colorMap.get(NEEDLE_COLOR);
				if (color != null)
					needleColor = color;
				color = options.colorMap.get(TICK_COLOR);
				if (color != null)
					dialBackground = color;
			}
		}

		setSclass("performance-indicator");
		
		m_goal = goal;

		init();
		mRefresh.addEventListener(Events.ON_CLICK, this);
		popupMenu.appendChild(mRefresh);

		addEventListener(Events.ON_DOUBLE_CLICK, this);
		addEventListener(Events.ON_CLICK, this);
	}	//	PerformanceIndicator

	private MGoal				m_goal = null;
	/**	The Performance Name		*/
	private String				m_text = null;
	/** Performance Line			*/

	/** Integer Number Format		*/
	private static DecimalFormat	s_format = DisplayType.getNumberFormat(DisplayType.Integer);

	Menupopup 					popupMenu = new Menupopup();
	private Menuitem 			mRefresh = new Menuitem(Msg.getMsg(Env.getCtx(), "Refresh"), ThemeManager.getThemeResource("images/Refresh16.png"));

	private Color chartBackground = new Color(0.0f, 0.0f, 0.0f, 0.0f);
	private int chartWidth = 120;
	private int chartHeight = 120;
	private Color dialBackground = Color.white;
	private Color needleColor = Color.darkGray;
	private Color tickColor = Color.darkGray;
	
	ChartPanel chartPanel;

	/**
	 * 	Get Goal
	 *	@return goal
	 */
	public MGoal getGoal()
	{
		return m_goal;
	}	//	getGoal

	private  JFreeChart createChart()
	{
		JFreeChart chart = null;

		//	Set Text
		StringBuilder text = new StringBuilder(m_goal.getName());
		if (m_goal.isTarget())
			text.append(": ").append(m_goal.getPercent()).append("%");
		else
			text.append(": ").append(s_format.format(m_goal.getMeasureActual()));

		m_text = text.toString();

		//	ToolTip
		text = new StringBuilder();
		if (m_goal.getDescription() != null)
			text.append(m_goal.getDescription()).append(": ");
		text.append(s_format.format(m_goal.getMeasureActual()));
		if (m_goal.isTarget())
			text.append(" ").append(Msg.getMsg(Env.getCtx(), "of")).append(" ")
				.append(s_format.format(m_goal.getMeasureTarget()));
		setTooltiptext(text.toString());
		//
        DefaultValueDataset data = new DefaultValueDataset((float)m_goal.getPercent());
        MeterPlot plot = new MeterPlot(data);

        MColorSchema colorSchema = m_goal.getColorSchema();
        int rangeLo = 0; int rangeHi=0;
        Point2D start = new Point2D.Float(0, 0);
        Point2D end = new Point2D.Float(50, 50);
        float[] dist = {0.0f, 0.2f, 0.45f, 0.75f, 1.0f};
        for (int i=1; i<=4; i++){
            switch (i) {
             case 1: rangeHi = colorSchema.getMark1Percent(); break;
             case 2: rangeHi = colorSchema.getMark2Percent(); break;
             case 3: rangeHi = colorSchema.getMark3Percent(); break;
             case 4: rangeHi = colorSchema.getMark4Percent(); break;
            }
            if (rangeHi==9999)
            	rangeHi = (int) Math.floor(rangeLo*1.5);
            if (rangeLo < rangeHi) {            	
                Color[] colors = {colorSchema.getColor(rangeHi).brighter().brighter(), 
                		colorSchema.getColor(rangeHi).brighter(), colorSchema.getColor(rangeHi), 
                		colorSchema.getColor(rangeHi).darker(), colorSchema.getColor(rangeHi).darker().darker()};
                LinearGradientPaint p =
                    new LinearGradientPaint(start, end, dist, colors);
                
            	plot.addInterval(new MeterInterval("Normal", //label
                 	  new Range(rangeLo, rangeHi), //range
                 	  p,
                 	  new BasicStroke(7.0f),
                 	  dialBackground
                ));
            	rangeLo = rangeHi;
            }
        }
        plot.setRange(new Range(0,rangeLo));
        plot.setDialBackgroundPaint(dialBackground);
        plot.setUnits("");
        plot.setDialShape(DialShape.CHORD);
        plot.setNeedlePaint(needleColor);
        plot.setTickSize(2000);
        plot.setTickLabelFont(new Font("SansSerif", Font.BOLD, 8));
        plot.setValueFont(new Font("SansSerif", Font.BOLD, 8));
        plot.setNoDataMessageFont(new Font("SansSerif", Font.BOLD, 8));
        plot.setTickLabelPaint(tickColor);
        plot.setValuePaint(new Color(0.0f, 0.0f, 0.0f, 0.0f));
        plot.setTickPaint(tickColor);
        //
        chart = new JFreeChart( "", new Font("SansSerif", Font.BOLD, 9), plot,false);

		return chart;
	}

     /**
	 * 	Init Graph Display
	 *  Kinamo (pelgrim)
	 */
	private void init()
	{
		JFreeChart chart = createChart();
		chart.setBackgroundPaint(chartBackground);
		chart.setAntiAlias(true);
		BufferedImage bi = chart.createBufferedImage(chartWidth, chartHeight, BufferedImage.TRANSLUCENT , null);
		try {
		    byte[] bytes = EncoderUtil.encode(bi, ImageFormat.PNG, true);

		    AImage image = new AImage("", bytes);
		    Image myImage = new Image();
		    myImage.setContent(image);
		    appendChild(myImage);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	    invalidate();
	}


	/**
	 * 	Update Display Data
	 */
	protected void updateDisplay()
	{
		chartPanel.setChart(createChart());
	    invalidate();
	}	//	updateData

	public void onEvent(Event event) throws Exception
	{
	}
	
	public String getTitle() 
	{
		return m_text;
	}
	
	public static class Options {
		public Map<String, Color> colorMap;
		public int chartWidth;
		public int chartHeight;
	}
}
