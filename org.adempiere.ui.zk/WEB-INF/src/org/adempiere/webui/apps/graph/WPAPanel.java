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
 * - carlos                                                            *
 * - elaine                                                            *
 * - hieplq                                                            *
 **********************************************************************/
package org.adempiere.webui.apps.graph;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.webui.apps.graph.WPerformanceIndicator.Options;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.compiere.model.MGoal;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;

/**
 * Panel with one or more {@link WPerformanceIndicator}
 */
public class WPAPanel extends Panel implements EventListener<Event>
{	
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -6367672112341229048L;

	/**
	 * 	Load Performance Goals for current login user.<br/>
	 *  For asynchronous use case, load MGoal[] through this method in non event listener thread
	 *  and call {@link #setGoals(MGoal[], Options)} in event listener thread to update UI. To
	 *  keep UI responsive, we need to avoid running long operation in event listener thread.
	 *	@return MGoal[]
	 */
	public static MGoal[] loadGoal()
	{
		int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		MGoal[] goals = MGoal.getUserGoals(Env.getCtx(), AD_User_ID);
		return goals;
	}
	
	/**
	 * Default Constructor
	 */
	public WPAPanel ()
	{
		super ();
	}
	
	/**
	 * Set performance goals and render charts
	 * @param goals
	 * @param options color map options
	 */
	public void setGoals (MGoal[] goals, Options options){
		m_goals = goals;
		if (getChildren().size() > 0)
			getChildren().clear();
		init(options);
	}
	
	/** Goals			*/
	private MGoal[] 	m_goals = null;
	
	/**	Logger	*/
	private static final CLogger log = CLogger.getCLogger (WPAPanel.class);
	
	/**
	 * Layout panel and render charts
	 * @param options 
	 */
	private void init(Options options)
	{
		setSclass("performance-panel");
		Grid grid = new Grid();
		appendChild(grid);
		grid.makeNoStrip();

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = null;
		List<WPerformanceIndicator> list = new ArrayList<>();
		for (int i = 0; i < m_goals.length; i++)
		{
			if (row == null || i % 2 == 0)
			{
				row = new Row();
				rows.appendChild(row);
			}
			
			Div div = new Div();
			row.appendChild(div);
			div.setSclass("performance-indicator-box");
			WPerformanceIndicator pi = new WPerformanceIndicator(m_goals[i], options);
			list.add(pi);
			pi.addEventListener(WPerformanceIndicator.ON_AFTER_RENDER_CHART_EVENT, e -> {
				boolean removed = list.remove(e.getTarget());
				if (removed && list.isEmpty()) {
					//notify all chart have been rendered
					Events.sendEvent(WPAPanel.this, new Event(WPerformanceIndicator.ON_AFTER_RENDER_CHART_EVENT));
				}
			});
			div.appendChild(pi);
			pi.addEventListener(Events.ON_CLICK, this);
			Div titleDiv = new Div();
			titleDiv.setSclass("performance-indicator-title");
			Label label = new Label(pi.getTitle());
			div.appendChild(titleDiv);
			titleDiv.appendChild(label);
		}
	}	//	init

	/**
	 * 	Open {@link WPerformanceDetail}
	 *	@param e event
	 */
	@Override
	public void onEvent(Event e) throws Exception 
	{
		if (e.getTarget() instanceof WPerformanceIndicator)
		{
			WPerformanceIndicator pi = (WPerformanceIndicator) e.getTarget();
			if (log.isLoggable(Level.INFO))
				log.info(pi.toString());
			MGoal goal = pi.getGoal();
			if (goal.getMeasure() != null)
				new WPerformanceDetail(goal);
		}
	}
}
