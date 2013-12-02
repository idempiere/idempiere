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

import java.awt.Color;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.adempiere.base.Service;
import org.adempiere.webui.apps.graph.model.IndicatorModel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.MGoal;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.jfree.chart.ChartPanel;
import org.zkoss.zk.ui.event.AfterSizeEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
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

     /**
	 * 	Init Graph Display
	 *  Kinamo (pelgrim)
	 */
	private void init()
	{								
		// Set Text
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
			
		addEventListener(Events.ON_AFTER_SIZE, this);
	}

	public void onEvent(Event event) throws Exception
	{
		if (Events.ON_AFTER_SIZE.equals(event.getName())) 
		{
			onAfterSize((AfterSizeEvent) event);
		}
		else if (event.getTarget() == this.getFirstChild())
		{
			event.stopPropagation();
			Events.sendEvent(Events.ON_CLICK, this, event.getData());
		}
	}
	
	private void onAfterSize(AfterSizeEvent event) {
		int width = event.getWidth();
		int height = event.getHeight();
		//set normal height
		if (height == 0) {
			height = width > 300 ? width * 40 / 100 : width * 85 / 100;
			this.setHeight(height+"px");
		} else {
			int ratio = (height * 100) / width;
			if (ratio > 85 || ratio < 50) {
				height = width > 300 ? width * 40 / 100 : width * 85 / 100;
				this.setHeight(height+"px");
			} 
		}
		this.getChildren().clear();
		renderChart(width, height);		
	}

	public String getTitle() 
	{
		return m_text;
	}
	
	private void renderChart(int chartWidth, int chartHeight) 
	{
		IndicatorModel model = new IndicatorModel();
		model.goalModel = m_goal;
		model.chartBackground = chartBackground;
		model.dialBackground = dialBackground;
		model.needleColor = needleColor;
		model.tickColor = tickColor;
		List<IChartRendererService> list = Service.locator().list(IChartRendererService.class).getServices();
		for (IChartRendererService renderer : list) { 
			if (renderer.renderPerformanceIndicator(this, chartWidth, chartHeight, model))
				break;
		}
		this.getFirstChild().addEventListener(Events.ON_CLICK, this);
	}
	
	public static class Options {
		public Map<String, Color> colorMap;
	}	
}
