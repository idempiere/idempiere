package org.adempiere.webui.apps.graph;

import org.adempiere.webui.apps.graph.WPerformanceIndicator.Options;
import org.adempiere.webui.component.Panel;
import org.compiere.model.MGoal;
import org.compiere.util.CLogger;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;

public class WPAWidget extends Panel implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5684412399657327777L;
	
	/**************************************************************************
	 * 	Constructor
	 */
	public WPAWidget (MGoal goal, Options options)
	{
		super();
		init(goal, options);
	}
	
	/**	Logger	*/
	private static final CLogger log = CLogger.getCLogger (WPAPanel.class);
	
	/**
	 * 	Static/Dynamic Init
	 * @param goal
	 * @param options 
	 */
	private void init(MGoal goal, Options options)
	{
		Div div = new Div();
		appendChild(div);
		WPerformanceIndicator pi = new WPerformanceIndicator(goal, options);
		div.appendChild(pi);
		pi.addEventListener(Events.ON_CLICK, this);
		Div titleDiv = new Div();
		titleDiv.setSclass("widget-title");
		Label label = new Label(pi.getTitle());
		div.appendChild(titleDiv);
		titleDiv.appendChild(label);
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
