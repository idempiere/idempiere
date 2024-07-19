package org.adempiere.webui.apps.graph;

import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MGoal;

/**
 * 	Window with Chart and Details for {@link MGoal}
 *	
 *  @author Jorg Janke
 *  @version $Id: PerformanceDetail.java,v 1.2 2006/07/30 00:51:28 jjanke Exp $
 */
public class WPerformanceDetail extends Window
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3460594735973451874L;

	/**
	 * 	Constructor.
	 * 	Called from {@link WPAPanel} and {@link WPAWidget}
	 *	@param goal goal
	 */
	public WPerformanceDetail (MGoal goal)
	{
		super();
		setTitle(goal.getName());

		WGraph graph = new WGraph(goal, 0, true, false, true, true);
		appendChild(graph);
				
		this.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
		this.setStyle("height: 100%; width: 100%; position: absolute; overflow: auto");
		graph.setStyle("height: 100%; width: 100%; position: absolute; overflow: visible");
		SessionManager.getAppDesktop().showWindow(this);
	}	//	PerformanceDetail
}
