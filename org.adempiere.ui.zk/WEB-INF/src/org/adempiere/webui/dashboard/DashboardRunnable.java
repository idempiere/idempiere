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
package org.adempiere.webui.dashboard;

import java.io.Serializable;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import org.adempiere.util.ServerContext;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.util.ServerPushTemplate;
import org.compiere.util.CLogger;
import org.zkoss.util.Locales;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.DesktopCleanup;

/**
 *
 * @author hengsin
 * @author Cristina Ghita, www.arhipac.ro BF [2871741] Error at start
 * @see https://sourceforge.net/tracker/?func=detail&atid=955896&aid=2871741&group_id=176962
 */
public class DashboardRunnable implements Runnable, Serializable
{

	private static final long serialVersionUID = 5995227773511788894L;

	private WeakReference<Desktop> desktop;
	private List<DashboardPanel> dashboardPanels;
	private Locale locale;

	private DesktopCleanup listener;

	@SuppressWarnings("unused")
	private static final CLogger logger = CLogger.getCLogger(DashboardRunnable.class);

	/**
	 *
	 * @param desktop zk desktop interface
	 * @param appDesktop adempiere desktop interface
	 */
	public DashboardRunnable(Desktop desktop) {
		this.desktop = new WeakReference<Desktop>(desktop);

		dashboardPanels = new ArrayList<DashboardPanel>();
		locale = Locales.getCurrent();
		
		listener = new DesktopCleanup() {			
			@Override
			public void cleanup(Desktop desktop) throws Exception {
				DashboardRunnable.this.cleanup();
			}
		};
		this.desktop.get().addListener(listener);
	}

	protected void cleanup() {
		dashboardPanels = null;
		if (desktop != null && desktop.get() != null)
			desktop.get().removeListener(listener);
		desktop = null;
	}

	public DashboardRunnable(DashboardRunnable tmp, Desktop desktop) {
		this(desktop);
		this.dashboardPanels = tmp.dashboardPanels;
		tmp.cleanup();
	}

	public void run()
	{
		if (dashboardPanels != null && desktop != null && desktop.get() != null
				&& desktop.get().isAlive() && desktop.get().isServerPushEnabled())
		{
			Locales.setThreadLocal(locale);
			try {
				refreshDashboard(true);
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

	/**
	 * Refresh dashboard content
	 */
	public void refreshDashboard(boolean pooling)
	{

		ServerPushTemplate template = new ServerPushTemplate(desktop.get());
		//set thread local context if not in event thread
		Properties ctx = null;
		boolean isEventThread = Events.inEventListener();
		if (!isEventThread)
		{
			try {
				ctx = (Properties)template.getDesktop().getSession().getAttribute(SessionContextListener.SESSION_CTX);
			} catch (Exception e) {
				ctx = null;
			}
			if (ctx == null)
				return;
		}
		try
		{
			if (!isEventThread)
			{
				ServerContext.setCurrentInstance(ctx);
			}
			
	    	for(int i = 0; i < dashboardPanels.size(); i++)
	    	{
	    		if (pooling && !dashboardPanels.get(i).isPooling())
	    			continue;
	    		
	    		dashboardPanels.get(i).refresh(template);
	    	}
		}
		finally
		{
			if (!isEventThread)
			{
				ServerContext.dispose();
			}
		}
	}

	/**
	 * Add DashboardPanel to the auto refresh list
	 * @param dashboardPanel
	 */
	public void add(DashboardPanel dashboardPanel) {
		if (dashboardPanels != null)
			dashboardPanels.add(dashboardPanel);
	}
	
	/**
	 * @return boolean
	 */
	public boolean isEmpty() {
		return dashboardPanels == null || dashboardPanels.isEmpty() ? true : false;
	}
}
