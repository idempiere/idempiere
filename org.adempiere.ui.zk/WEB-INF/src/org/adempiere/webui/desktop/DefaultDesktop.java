/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.desktop;

import java.io.Serializable;
import java.util.Properties;

import org.adempiere.util.ServerContext;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialog;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.dashboard.DPActivities;
import org.adempiere.webui.event.MenuListener;
import org.adempiere.webui.panel.HeaderPanel;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.IServerPushCallback;
import org.adempiere.webui.util.ServerPushTemplate;
import org.adempiere.webui.util.UserPreference;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.West;

/**
 *
 * Default desktop implementation.
 * @author <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 * @date Mar 2, 2007
 * @version $Revision: 0.10 $
 */
public class DefaultDesktop extends TabbedDesktop implements MenuListener, Serializable, EventListener<Event>, IServerPushCallback
{
	/**
	 * generated serial version ID
	 */
	private static final long serialVersionUID = -8203958978173990301L;

	@SuppressWarnings("unused")
	private static final CLogger logger = CLogger.getCLogger(DefaultDesktop.class);

    private Center windowArea;

	private Borderlayout layout;

	private int noOfNotice;

	private int noOfRequest;

	private int noOfWorkflow;

	private int noOfUnprocessed;

	private Tabpanel homeTab;

	private DashboardController dashboardController, sideController;
		
    public DefaultDesktop()
    {
    	super();
    	dashboardController = new DashboardController();
    	sideController = new DashboardController();
    }

    protected Component doCreatePart(Component parent)
    {
    	HeaderPanel pnlHead = new HeaderPanel();

        layout = new Borderlayout();
        if (parent != null)
        {
        	layout.setParent(parent);
        	layout.setWidth("100%");
        	layout.setHeight("100%");
        	layout.setSclass("desktop-layout");
        }
        else
        	layout.setPage(page);

        North n = new North();
        layout.appendChild(n);
        n.setCollapsible(false);
        n.setSclass("desktop-north");
        pnlHead.setParent(n);

        West w = new West();
        w.setTitle(" ");
        w.setId("desktop-left-column");
        layout.appendChild(w);
        w.setSclass("desktop-left-column");
        w.setCollapsible(true);
        w.setSplittable(true);
        w.setFlex(false);
        w.setHflex("1");
        w.addEventListener(Events.ON_OPEN, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				OpenEvent oe = (OpenEvent) event;
				UserPreference pref = SessionManager.getSessionApplication().getUserPreference();
				pref.setProperty(UserPreference.P_MENU_COLLAPSED, !oe.isOpen());
				pref.savePreference();
			}
		});
        UserPreference pref = SessionManager.getSessionApplication().getUserPreference();
        boolean menuCollapsed= pref.isPropertyBool(UserPreference.P_MENU_COLLAPSED);
        w.setOpen(!menuCollapsed);
        
        sideController.render(w, this, false);

        windowArea = new Center();
        windowArea.setParent(layout);
        windowArea.setFlex(true);
        windowArea.setSclass("desktop-center");

        windowContainer.createPart(windowArea);

        homeTab = new Tabpanel();
        windowContainer.addWindow(homeTab, Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Home")), false);
        homeTab.getLinkedTab().setSclass("desktop-hometab");
        BusyDialog busyDialog = new BusyDialog();
        busyDialog.setShadow(false);
        homeTab.appendChild(busyDialog);

        if (!layout.getDesktop().isServerPushEnabled())
    	{
    		layout.getDesktop().enableServerPush(true);
    	}

        Runnable runnable = new Runnable() {
			public void run() {
				try {
					Thread.sleep(100);
				} catch (InterruptedException e) {}

				IServerPushCallback callback = new IServerPushCallback() {
					public void updateUI() {
						Properties ctx = (Properties)layout.getDesktop().getSession().getAttribute(SessionContextListener.SESSION_CTX);
						try {
							ServerContext.setCurrentInstance(ctx);
							renderHomeTab();
						} finally {
							ServerContext.dispose();
						}
					}
				};
				ServerPushTemplate template = new ServerPushTemplate(layout.getDesktop());
				template.executeAsync(callback);
			}
		};

		Thread thread = new Thread(runnable);
		thread.start();

        return layout;
    }

	private void renderHomeTab()
	{
		
		homeTab.getChildren().clear();		

		//register as 0
        registerWindow(homeTab);
        
		dashboardController.render(homeTab, this, true);
		
		if (AEnv.isTablet()) 
		{
			homeTab.addEventListener("onAddTabletScrolling", this);
			Events.echoEvent("onAddTabletScrolling", homeTab, null);
		}
	}

	public void onEvent(Event event)
    {
        Component comp = event.getTarget();
        String eventName = event.getName();

        if(eventName.equals(Events.ON_CLICK))
        {
            if(comp instanceof ToolBarButton)
            {
            	ToolBarButton btn = (ToolBarButton) comp;

            	if (btn.getAttribute("AD_Menu_ID") != null)
            	{
	            	int menuId = (Integer)btn.getAttribute("AD_Menu_ID");
	            	if(menuId > 0) onMenuSelected(menuId);
            	}
            }
        }
        else if (eventName.equals("onAddTabletScrolling"))
        {
        	LayoutUtils.addSclass("tablet-scrolling", homeTab);
        }
    }

    public void onServerPush(ServerPushTemplate template)
	{
    	noOfNotice = DPActivities.getNoticeCount();
    	noOfRequest = DPActivities.getRequestCount();
    	noOfWorkflow = DPActivities.getWorkflowCount();
    	noOfUnprocessed = DPActivities.getUnprocessedCount();

    	template.executeAsync(this);
	}

	/**
	 *
	 * @param page
	 */
	public void setPage(Page page) {
		if (this.page != page) {
			layout.setPage(page);
			this.page = page;
			
			if (dashboardController != null) {
				dashboardController.onSetPage(page, layout.getDesktop(), this);
			}
			
			if (sideController != null) {
				sideController.onSetPage(page, layout.getDesktop(), this);
			}
		}
	}

	/**
	 * Get the root component
	 * @return Component
	 */
	public Component getComponent() {
		return layout;
	}

	public void logout() {
		if (dashboardController != null) {
			dashboardController.onLogOut();
		}
		
		if (sideController != null) {
			sideController.onLogOut();
		}
	}

	public void updateUI() {
		int total = noOfNotice + noOfRequest + noOfWorkflow + noOfUnprocessed;
		windowContainer.setTabTitle(0, Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Home"))
				+ " (" + total + ")",
				Msg.translate(Env.getCtx(), "AD_Note_ID") + " : " + noOfNotice
				+ ", " + Msg.translate(Env.getCtx(), "R_Request_ID") + " : " + noOfRequest
				+ ", " + Util.cleanAmp(Msg.getMsg (Env.getCtx(), "WorkflowActivities")) + " : " + noOfWorkflow
				+ (noOfUnprocessed>0 ? ", " + Msg.getMsg (Env.getCtx(), "UnprocessedDocs") + " : " + noOfUnprocessed : "")
				);
	}

	private void autoHideMenu() {
		if (layout.getWest().isCollapsible() && !layout.getWest().isOpen())
		{
			String id = layout.getWest().getUuid();
			//$n('colled') is not documented api so this might break in release after 6.0.0
			String script = "jq(zk.Widget.$('"+id+"').$n('colled')).click();";
			AuScript aus = new AuScript(layout.getWest(), script);
			Clients.response("autoHideWest", aus);
		}
	}

	@Override
	protected void preOpenNewTab()
	{
		autoHideMenu();
	}
}
