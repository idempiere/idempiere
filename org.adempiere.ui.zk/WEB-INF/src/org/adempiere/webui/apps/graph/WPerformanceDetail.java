package org.adempiere.webui.apps.graph;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MGoal;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;

/**
 * 	Window with Chart and Details for {@link MGoal}
 *	
 *  @author Jorg Janke
 */
public class WPerformanceDetail extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3460594735973451874L;
	
	/* Window No. */
	private int m_windowNo;
	/* SysConfig USE_ESC_FOR_TAB_CLOSING */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));

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
		m_windowNo = SessionManager.getAppDesktop().registerWindow(this);
		setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_windowNo);	// for closing the window with shortcut
    	SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
		SessionManager.getAppDesktop().showWindow(this);
	}	//	PerformanceDetail

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(Events.ON_CTRL_KEY)) {
        	KeyEvent keyEvent = (KeyEvent) event;
		if (LayoutUtils.isReallyVisible(this))
			this.onCtrlKeyEvent(keyEvent);
		}
	}
	
	/**
	 * Handle shortcut key event
	 * @param keyEvent
	 */
	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		if ((keyEvent.isAltKey() && keyEvent.getKeyCode() == 0x58)	// Alt-X
				|| (keyEvent.getKeyCode() == 0x1B && isUseEscForTabClosing)) { 	// ESC
			if (m_windowNo > 0) {
				keyEvent.stopPropagation();
				SessionManager.getAppDesktop().closeWindow(m_windowNo);
			}
		}
	}
}
