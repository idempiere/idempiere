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
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.IEventManager;
import org.adempiere.base.event.IEventTopics;
import org.adempiere.model.MBroadcastMessage;
import org.adempiere.util.ServerContext;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialog;
import org.adempiere.webui.apps.ProcessDialog;
import org.adempiere.webui.apps.WReport;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.event.DrillEvent;
import org.adempiere.webui.event.MenuListener;
import org.adempiere.webui.event.ZKBroadCastManager;
import org.adempiere.webui.event.ZoomEvent;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.BroadcastMessageWindow;
import org.adempiere.webui.panel.HeaderPanel;
import org.adempiere.webui.panel.HelpController;
import org.adempiere.webui.panel.TimeoutPanel;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.IServerPushCallback;
import org.adempiere.webui.util.ServerPushTemplate;
import org.adempiere.webui.util.UserPreference;
import org.adempiere.webui.window.FDialog;
import org.compiere.Adempiere;
import org.compiere.model.GridField;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.WebUtil;
import org.idempiere.broadcast.BroadCastMsg;
import org.idempiere.broadcast.BroadCastUtil;
import org.idempiere.broadcast.BroadcastMsgUtil;
import org.osgi.service.event.EventHandler;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.EventQueue;
import org.zkoss.zk.ui.event.EventQueues;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.event.SwipeEvent;
import org.zkoss.zk.ui.metainfo.PageDefinition;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.DesktopCleanup;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.East;
import org.zkoss.zul.West;

/**
 *
 * Default desktop implementation.
 * @author <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 * @date Mar 2, 2007
 * @version $Revision: 0.10 $
 * @author Deepak Pansheriya/Vivek - Adding support for message broadcasting
 */
public class DefaultDesktop extends TabbedDesktop implements MenuListener, Serializable, EventListener<Event>, EventHandler, DesktopCleanup
{
	private static final String IMAGES_UPARROW_PNG = "images/collapse-header.png";

	private static final String IMAGES_DOWNARROW_PNG = "images/expand-header.png";

	/**
	 * generated serial version ID
	 */
	private static final long serialVersionUID = -8203958978173990301L;

	@SuppressWarnings("unused")
	private static final CLogger logger = CLogger.getCLogger(DefaultDesktop.class);

	private Borderlayout layout;

	private int noOfNotice;

	private int noOfRequest;

	private int noOfWorkflow;

	private int noOfUnprocessed;

	private Tabpanel homeTab;

	private DashboardController dashboardController, sideController;
	
	private HeaderPanel pnlHead;
	
	private Desktop m_desktop = null;
	
	private HelpController helpController;

	private ToolBarButton max;

    public DefaultDesktop()
    {
    	super();
    	dashboardController = new DashboardController();
    	sideController = new DashboardController();
    	helpController = new HelpController();
    	
    	m_desktop = AEnv.getDesktop();
    	m_desktop.addListener(this);
    	//subscribing to broadcast event
    	bindEventManager();
    	ZKBroadCastManager.getBroadCastMgr();
    	
    	EventQueue<Event> queue = EventQueues.lookup(ACTIVITIES_EVENT_QUEUE, true);
    	queue.subscribe(this);
    }

    protected Component doCreatePart(Component parent)
    {
    	PageDefinition pagedef = Executions.getCurrent().getPageDefinition(ThemeManager.getThemeResource("zul/desktop/desktop.zul"));
    	Component page = Executions.createComponents(pagedef, parent, null);
    	layout = (Borderlayout) page.getFellow("layout");
    	pnlHead = (HeaderPanel) page.getFellow("northBody").getFellow("header");
        
        layout.addEventListener("onZoom", this);
        layout.addEventListener(DrillEvent.ON_DRILL_DOWN, this);

        West w = layout.getWest();
        w.addEventListener(Events.ON_OPEN, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				OpenEvent oe = (OpenEvent) event;
				updateMenuCollapsedPreference(!oe.isOpen());				
			}			
		});
        w.addEventListener(Events.ON_SWIPE, new EventListener<SwipeEvent>() {

			@Override
			public void onEvent(SwipeEvent event) throws Exception {
				if ("left".equals(event.getSwipeDirection())) {
					West w = (West) event.getTarget();
					if (w.isOpen()) {
						w.setOpen(false);
						updateMenuCollapsedPreference(true);
					}
				}
			}
		});
        UserPreference pref = SessionManager.getSessionApplication().getUserPreference();
        boolean menuCollapsed= pref.isPropertyBool(UserPreference.P_MENU_COLLAPSED);
        w.setOpen(!menuCollapsed);
        
        sideController.render(w, this, false);
        
        East e = layout.getEast();
        e.addEventListener(Events.ON_OPEN, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				OpenEvent oe = (OpenEvent) event;
				updateHelpCollapsedPreference(!oe.isOpen());
				HtmlBasedComponent comp = windowContainer.getComponent();
				if (comp != null) {
					if (oe.isOpen()) {
						LayoutUtils.removeSclass("with-right-icon", comp);
					} else {
						LayoutUtils.addSclass("with-right-icon", comp);
					}
				}
			}
		});

        e.addEventListener(Events.ON_SWIPE, new EventListener<SwipeEvent>() {

			@Override
			public void onEvent(SwipeEvent event) throws Exception {
				if ("right".equals(event.getSwipeDirection())) {
					East e = (East) event.getTarget();
					if (e.isOpen()) {
						e.setOpen(false);
						updateHelpCollapsedPreference(true);
					}
				}
			}
		});
        
        boolean helpCollapsed= pref.isPropertyBool(UserPreference.P_HELP_COLLAPSED);
        e.setOpen(!helpCollapsed);        
        Clients.evalJavaScript("$('.desktop-layout > div > .z-east-colpsd > .z-borderlayout-icon').attr('title', '" +
        		Msg.getElement(Env.getCtx(), "AD_CtxHelp_ID") + "');");
        
        
        helpController.render(e, this);

        Center windowArea = layout.getCenter();

        windowContainer.createPart(windowArea);

        homeTab = new Tabpanel();
        windowContainer.addWindow(homeTab, Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Home")), false);
        homeTab.getLinkedTab().setSclass("desktop-hometab");
        homeTab.setSclass("desktop-home-tabpanel");
        BusyDialog busyDialog = new BusyDialog();
        busyDialog.setShadow(false);
        homeTab.appendChild(busyDialog);
        
        BroadcastMessageWindow messageWindow = new BroadcastMessageWindow(pnlHead);
        BroadcastMsgUtil.showPendingMessage(Env.getAD_User_ID(Env.getCtx()), messageWindow);
        
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

		Adempiere.getThreadPoolExecutor().submit(runnable);

		ToolBar toolbar = new ToolBar();
        windowContainer.getComponent().appendChild(toolbar);
        max = new ToolBarButton();
        toolbar.appendChild(max);
        max.setImage(ThemeManager.getThemeResource(IMAGES_UPARROW_PNG));
        max.addEventListener(Events.ON_CLICK, this);
        max.setSclass("window-container-toolbar-btn");
        max.setStyle("cursor: pointer; border: 1px solid transparent; padding: 2px;");
        
        if (!e.isOpen()) {
        	LayoutUtils.addSclass("with-right-icon", windowContainer.getComponent());
        }
        
        return layout;
    }

    private void updateMenuCollapsedPreference(boolean collapsed) {
		UserPreference pref = SessionManager.getSessionApplication().getUserPreference();
		pref.setProperty(UserPreference.P_MENU_COLLAPSED, collapsed);
		pref.savePreference();
	}
    
	private void updateHelpCollapsedPreference(boolean collapsed) {
		UserPreference pref = SessionManager.getSessionApplication().getUserPreference();
		pref.setProperty(UserPreference.P_HELP_COLLAPSED, collapsed);
		pref.savePreference();
	}

	private void renderHomeTab()
	{
		homeTab.getChildren().clear();		

		//register as 0
        registerWindow(homeTab);
        
		dashboardController.render(homeTab, this, true);
		
		Clients.response(new AuScript("$('.slimScroll .z-anchorlayout-body').slimScroll({height: '100%',railVisible: true, alwaysVisible: false});"));				
	}

	public void onEvent(Event event)
    {
        Component comp = event.getTarget();
        String eventName = event.getName();

        if(eventName.equals(Events.ON_CLICK))
        {
        	if (comp == max)
        	{
        		if (layout.getNorth().isVisible())
        		{
        			layout.getNorth().setVisible(false);
        			max.setImage(ThemeManager.getThemeResource(IMAGES_DOWNARROW_PNG));
        		}
        		else
        		{
        			layout.getNorth().setVisible(true);
        			max.setImage(ThemeManager.getThemeResource(IMAGES_UPARROW_PNG));
        		}
        	}
        	else if(comp instanceof ToolBarButton)
            {
            	ToolBarButton btn = (ToolBarButton) comp;

            	if (btn.getAttribute("AD_Menu_ID") != null)
            	{
	            	int menuId = (Integer)btn.getAttribute("AD_Menu_ID");
	            	if(menuId > 0) onMenuSelected(menuId);
            	}
            }
        }
        else if (eventName.equals(ON_ACTIVITIES_CHANGED_EVENT))
        {
        	@SuppressWarnings("unchecked")
			Map<String, Object> map = (Map<String, Object>) event.getData();
        	Integer notice = (Integer) map.get("notice");
        	Integer request = (Integer) map.get("request");
        	Integer workflow = (Integer) map.get("workflow");
        	Integer unprocessed = (Integer) map.get("unprocessed");
        	boolean change = false;
        	if (notice != null && notice.intValue() != noOfNotice) 
        	{
        		noOfNotice = notice.intValue(); change = true;
        	}
        	if (request != null && request.intValue() != noOfRequest) 
        	{
        		noOfRequest = request.intValue(); change = true;
        	}		
        	if (workflow != null && workflow.intValue() != noOfWorkflow) 
        	{
        		noOfWorkflow = workflow.intValue(); change = true;
        	}
        	if (unprocessed != null && unprocessed.intValue() != noOfUnprocessed) 
        	{
        		noOfUnprocessed = unprocessed.intValue(); change = true;
        	}
        	if (change)
        		updateUI();
        }
        else if (event instanceof ZoomEvent) 
		{
        	Clients.clearBusy();
			ZoomEvent ze = (ZoomEvent) event;
			if (ze.getData() != null && ze.getData() instanceof MQuery) {
				AEnv.zoom((MQuery) ze.getData());
			}
		}
		
        else if (event instanceof DrillEvent)
		{
        	Clients.clearBusy();
			DrillEvent de = (DrillEvent) event;
			if (de.getData() != null && de.getData() instanceof MQuery) {
				MQuery query = (MQuery) de.getData();
				executeDrill(query);
			}
		}
    }

	/**
	 * 	Execute Drill to Query
	 * 	@param query query
	 */
   	private void executeDrill (MQuery query)
	{
		int AD_Table_ID = MTable.getTable_ID(query.getTableName());
		if (!MRole.getDefault().isCanReport(AD_Table_ID))
		{
			FDialog.error(0, null, "AccessCannotReport", query.getTableName());
			return;
		}
		if (AD_Table_ID != 0)
			new WReport(AD_Table_ID, query);		
	}	//	executeDrill
   	
	/**
	 *
	 * @param page
	 */
	public void setPage(Page page) {
		if (this.page != page) {
			layout.setPage(page);
			this.page = page;
			
			if (dashboardController != null) {
				dashboardController.onSetPage(page, layout.getDesktop());
			}
			
			if (sideController != null) {
				sideController.onSetPage(page, layout.getDesktop());
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
		unbindEventManager();
		if (dashboardController != null) {
			dashboardController.onLogOut();
			dashboardController = null;
		}
		
		if (sideController != null) {
			sideController.onLogOut();
			sideController = null;
		}
		layout.detach();
		layout = null;
		pnlHead = null;
		max = null;
		m_desktop = null;
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

	//use _docClick undocumented api. need verification after major zk release update
	private final static String autoHideMenuScript = "try{var w=zk.Widget.$('#{0}');var t=zk.Widget.$('#{1}');" +
			"var e=new Object;e.target=t;w._docClick(e);}catch(error){}";
	
	private void autoHideMenu() {
		if (layout.getWest().isCollapsible() && !layout.getWest().isOpen())
		{
			String id = layout.getWest().getUuid();
			Tab tab = windowContainer.getSelectedTab();
			if (tab != null) {
				String tabId = tab.getUuid();
				String script = autoHideMenuScript.replace("{0}", id);
				script = script.replace("{1}", tabId);
				AuScript aus = new AuScript(layout.getWest(), script);
				Clients.response("autoHideWest", aus);
			}			
		}
	}

	@Override
	protected void preOpenNewTab()
	{
		autoHideMenu();
	}

	//Implementation for Broadcast message
	/**
	 * @param eventManager
	 */
	public void bindEventManager() {
		EventManager.getInstance().register(IEventTopics.BROADCAST_MESSAGE, this);
	}

	/**
	 * @param eventManager
	 */
	public void unbindEventManager() {
		EventManager.getInstance().unregister(this);
	}
	
	@Override
	public void handleEvent(final org.osgi.service.event.Event event) {
		String eventName = event.getTopic();
		if (eventName.equals(IEventTopics.BROADCAST_MESSAGE)) {
			EventListener<Event> listner = new EventListener<Event>() {

				@Override
				public void onEvent(Event event) throws Exception {
					BroadCastMsg msg = (BroadCastMsg) event.getData();
					

					switch (msg.getEventId()) {
					case BroadCastUtil.EVENT_TEST_BROADCAST_MESSAGE:
						MBroadcastMessage mbMessage = MBroadcastMessage.get(
								Env.getCtx(), msg.getIntData());
						String currSession = Integer
								.toString(Env.getContextAsInt(Env.getCtx(),
										"AD_Session_ID"));
						if (currSession.equals(msg.getTarget())) {
							BroadcastMessageWindow testMessageWindow = new BroadcastMessageWindow(
										pnlHead);
							testMessageWindow.appendMessage(mbMessage, true);
							testMessageWindow = null;

						}
						break;
					case BroadCastUtil.EVENT_BROADCAST_MESSAGE:
						mbMessage = MBroadcastMessage.get(
								Env.getCtx(), msg.getIntData());
						if (mbMessage.isValidUserforMessage()) {
							
							BroadcastMessageWindow messageWindow = new BroadcastMessageWindow(
										pnlHead);
							messageWindow.appendMessage(mbMessage, false);
						}
						break;
					case BroadCastUtil.EVENT_SESSION_TIMEOUT:

						currSession = Integer.toString(Env.getContextAsInt(
								Env.getCtx(), "AD_Session_ID"));
						if (currSession.equalsIgnoreCase(msg.getTarget())) {
							new TimeoutPanel(pnlHead, msg.getIntData());
						}

						break;
					case BroadCastUtil.EVENT_SESSION_ONNODE_TIMEOUT:

						currSession = WebUtil.getServerName();

						if (currSession.equalsIgnoreCase(msg.getTarget())) {
							new TimeoutPanel(pnlHead, msg.getIntData());
						}

					}

				}

			};

			Executions.schedule(m_desktop, listner, new Event("OnBroadcast",
					null, event.getProperty(IEventManager.EVENT_DATA)));

		}
	}

	@Override
	public void cleanup(Desktop desktop) throws Exception {
		unbindEventManager();
	}

	@Override
	public void updateHelpContext(String ctxType, int recordId) {
		helpController.renderCtxHelp(ctxType, recordId);
	}

	@Override
	public void updateHelpTooltip(GridField gridField) {
		helpController.renderToolTip(gridField);
	}

	@Override
	public ProcessDialog openProcessDialog(int processId, boolean soTrx) {
		ProcessDialog pd = super.openProcessDialog(processId, soTrx);
		updateHelpContext(X_AD_CtxHelp.CTXTYPE_Process, processId);
		return pd;
	}

	@Override
	public ADForm openForm(int formId) {
		ADForm form = super.openForm(formId);
		updateHelpContext(X_AD_CtxHelp.CTXTYPE_Form, formId);
		return form;
	}

	@Override
	public void openInfo(int infoId) {
		super.openInfo(infoId);
		updateHelpContext(X_AD_CtxHelp.CTXTYPE_Info, infoId);
	}

	@Override
	public void openWorkflow(int workflow_ID) {
		super.openWorkflow(workflow_ID);
		updateHelpContext(X_AD_CtxHelp.CTXTYPE_Workflow, workflow_ID);
	}

	@Override
	public void openTask(int taskId) {
		super.openTask(taskId);
		updateHelpContext(X_AD_CtxHelp.CTXTYPE_Task, taskId);
	}

    public boolean isPendingWindow() {
        List<Object> windows = getWindows();
        if (windows != null) {
        	for (int idx = 0; idx < windows.size(); idx++) {
                Object ad = windows.get(idx);
                if (ad != null && ad instanceof ADWindow && ((ADWindow)ad).getADWindowContent() != null) {
                	if ( ((ADWindow)ad).getADWindowContent().isPendingChanges()) {
                		return true;
                	}
                }
        	}
        }
        return false;
    }
}
