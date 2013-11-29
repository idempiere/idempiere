package org.adempiere.webui.apps.graph;

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

public class WPAPanel extends Panel implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6491684272848160726L;

	public static WPAPanel get()
	{
		return get((WPerformanceIndicator.Options)null);
	}
	
	/**
	 * 	Get Panel if User has Performance Goals
	 *	@return panel pr null
	 */
	public static WPAPanel get(WPerformanceIndicator.Options options)
	{
		int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		MGoal[] goals = MGoal.getUserGoals(Env.getCtx(), AD_User_ID);
		if (goals.length == 0)
			return null;
		return new WPAPanel(goals, options);
	}
	
	/**************************************************************************
	 * 	Constructor
	 *	@param goals
	 * @param options 
	 */
	private WPAPanel (MGoal[] goals, Options options)
	{
		super ();
		m_goals = goals;		
		init(options);
	}
	
	/** Goals			*/
	private MGoal[] 	m_goals = null;
	
	/**	Logger	*/
	private static CLogger log = CLogger.getCLogger (WPAPanel.class);
	
	/**
	 * 	Static/Dynamic Init
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
	 * 	Action Listener for Drill Down
	 *	@param e event
	 */
	public void onEvent(Event e) throws Exception 
	{
		if (e.getTarget() instanceof WPerformanceIndicator)
		{
			WPerformanceIndicator pi = (WPerformanceIndicator) e.getTarget();
			log.info(pi.toString());
			MGoal goal = pi.getGoal();
			if (goal.getMeasure() != null)
				new WPerformanceDetail(goal);
		}
	}
}
