/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.webui.desktop;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.Extensions;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.graph.IChartRendererService;
import org.adempiere.webui.apps.graph.WGraph;
import org.adempiere.webui.apps.graph.WPerformanceDetail;
import org.adempiere.webui.apps.graph.model.ChartModel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.dashboard.DashboardPanel;
import org.adempiere.webui.dashboard.DashboardRunnable;
import org.adempiere.webui.report.HTMLExtension;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.ZkReportViewerProvider;
import org.compiere.model.I_AD_Menu;
import org.compiere.model.MChart;
import org.compiere.model.MDashboardContent;
import org.compiere.model.MDashboardContentAccess;
import org.compiere.model.MDashboardPreference;
import org.compiere.model.MGoal;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MMenu;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MSysConfig;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.AfterSizeEvent;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MaximizeEvent;
import org.zkoss.zul.Anchorchildren;
import org.zkoss.zul.Anchorlayout;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Include;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Timer;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class DashboardController implements EventListener<Event> {

	private static final String PANEL_EMPTY_ATTR = "panel.empty";
	private final static CLogger logger = CLogger.getCLogger(DashboardController.class);
	private Component prevParent;
	private Component prevNext;

	private List<Panel> panelList = new ArrayList<Panel>();
	private List<Anchorchildren> columnList;
	private Anchorlayout dashboardLayout;
	private Anchorchildren maximizedHolder;	
	private DashboardRunnable dashboardRunnable;
	private Timer dashboardTimer;
	private boolean isShowInDashboard;
	private int noOfCols;
	
	private final static int DEFAULT_DASHBOARD_WIDTH = 95;
	
	public DashboardController() {
		dashboardLayout = new Anchorlayout();
		dashboardLayout.setSclass("dashboard-layout");
        ZKUpdateUtil.setVflex(dashboardLayout, "1");
        ZKUpdateUtil.setHflex(dashboardLayout, "1");
        
        maximizedHolder = new Anchorchildren();                
        maximizedHolder.setAnchor("100% 100%");
        maximizedHolder.setStyle("overflow: hidden; border: none; margin: 0; padding: 0;");
	}
	
	public void render(Component parent, IDesktop desktopImpl, boolean isShowInDashboard) {
		render(parent, desktopImpl, isShowInDashboard, false);
	}
	
	protected void render(Component parent, IDesktop desktopImpl, boolean isShowInDashboard, boolean update) {
		this.isShowInDashboard = isShowInDashboard;
		if (!update)
			parent.appendChild(dashboardLayout);
		if (!update && isShowInDashboard)
			((HtmlBasedComponent)parent).setStyle("overflow-x: auto;");
		dashboardLayout.getChildren().clear();
        
        if (!dashboardLayout.getDesktop().isServerPushEnabled())
        	dashboardLayout.getDesktop().enableServerPush(true);
        
        if (!update)
        	dashboardRunnable = new DashboardRunnable(parent.getDesktop());
        
        columnList = new ArrayList<Anchorchildren>();
        
        // Dashboard content
        Vlayout dashboardColumnLayout = null;
        int currentColumnNo = 0;

        int noOfCols = 0;
        int width = 0;

        try
		{
        	int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
        	int AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());
        	
        	MDashboardPreference[] dps = MDashboardPreference.getForSession(AD_User_ID, AD_Role_ID);
        	MDashboardContent [] dcs =  MDashboardContentAccess.get(Env.getCtx(), AD_Role_ID, AD_User_ID, null);
        	
        	if(dps.length == 0){
        	    createDashboardPreference(AD_User_ID, AD_Role_ID);
        	    dps = MDashboardPreference.getForSession(AD_User_ID, AD_Role_ID);
        	}else{
        		if(updatePreferences(dps, dcs,Env.getCtx())){        			
        			dps = MDashboardPreference.getForSession(AD_User_ID, AD_Role_ID);
        		}
        	}
        	               
        	noOfCols = MDashboardPreference.getForSessionColumnCount(isShowInDashboard, AD_User_ID, AD_Role_ID);        	
        	if (ClientInfo.isMobile() && isShowInDashboard) {
	        	if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1)) {
	        		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1)) {
	        			noOfCols = 1;
	        		} else if (noOfCols > 2) {
	        			noOfCols = 2;
	        		}
	        	}
        	}
        	this.noOfCols = noOfCols;
            
        	int dashboardWidth = isShowInDashboard ? DEFAULT_DASHBOARD_WIDTH : 100;
            width = noOfCols <= 0 ? dashboardWidth : dashboardWidth / noOfCols;
            int extraWidth = 100 - (noOfCols <= 0 ? dashboardWidth : width * noOfCols) - (100 - dashboardWidth - 1);
            for (final MDashboardPreference dp : dps)            	
			{            	            	            	
            	if(!dp.isActive())
            		continue;
            	
            	if (dp.isShowInDashboard() != isShowInDashboard)
            		continue;
            	
            	MDashboardContent dc = new MDashboardContent(dp.getCtx(), dp.getPA_DashboardContent_ID(), dp.get_TrxName());
            	
	        	int columnNo = dp.getColumnNo();
	        	int effColumn = columnNo;
	        	if (effColumn+1 > noOfCols)
	        		effColumn = noOfCols-1;
	        	if(dashboardColumnLayout == null || currentColumnNo != effColumn)
	        	{
	        		dashboardColumnLayout = new Vlayout();
	        		dashboardColumnLayout.setSclass("dashboard-column");
	        		dashboardColumnLayout.setAttribute("ColumnNo", columnNo);
	        		dashboardColumnLayout.setAttribute("IsShowInDashboard", isShowInDashboard);
	        		dashboardColumnLayout.setAttribute("IsAdditionalColumn", false);
	        		Anchorchildren dashboardColumn = new Anchorchildren();
	        		dashboardColumn.setAnchor(width + "%" + " 100%");
	        		if (!ClientInfo.isMobile())
	        		{
		        		dashboardColumn.setDroppable("true");
		        		dashboardColumn.addEventListener(Events.ON_DROP, this);
	        		}
	        		dashboardColumn.appendChild(dashboardColumnLayout);
	        		columnList.add(dashboardColumn);
	                dashboardLayout.appendChild(dashboardColumn);
	                ZKUpdateUtil.setHflex(dashboardColumnLayout, "1");

	                currentColumnNo = effColumn;
	        	}

	        	Panel panel = null;
	        	if (update) {
	        		panel = findPanel(dp.getPA_DashboardContent_ID(), dp.getPA_DashboardPreference_ID());
	        	} else {
		        	panel = new Panel();
		        	Caption caption = new Caption(dc.get_Translation(MDashboardContent.COLUMNNAME_Name));
		        	panel.appendChild(caption);
		        	panel.setAttribute("PA_DashboardContent_ID", dp.getPA_DashboardContent_ID());
		        	panel.setAttribute("PA_DashboardPreference_ID", dp.getPA_DashboardPreference_ID());
		        	panelList.add(panel);
		        	panel.addEventListener(Events.ON_MAXIMIZE, this);
		        	panel.setSclass("dashboard-widget");
		        	panel.setMaximizable(true);	        	
	        	
		        	String description = dc.get_Translation(MDashboardContent.COLUMNNAME_Description);
	            	if(description != null)
	            		panel.setTooltiptext(description);
	
	            	panel.setCollapsible(dc.isCollapsible());
	            	panel.setOpen(!dp.isCollapsedByDefault());
	            	panel.addEventListener(Events.ON_OPEN, this);
	            	
	            	if (!ClientInfo.isMobile()) {
	            		panel.setDroppable("true");
	            		panel.getCaption().setDraggable("true");	            	
	            		panel.addEventListener(Events.ON_DROP, this);
	            	}
		        	panel.setBorder("normal");
	        	}
	        	if (panel != null && panel.getAttribute(PANEL_EMPTY_ATTR) == null)
	        		dashboardColumnLayout.appendChild(panel);
	        	if (!update) {
		            Panelchildren content = new Panelchildren();
		            panel.appendChild(content);
	
		            boolean panelEmpty = true;
	
		            panelEmpty = !render(content, dc, dashboardRunnable);	            		
		        	
		        	if (panelEmpty) {
		        		panel.detach();
		        		panel.setAttribute(PANEL_EMPTY_ATTR, Boolean.TRUE);
		        	}
	        	}
	        }
            
            if (dps.length == 0)
            {
            	dashboardColumnLayout = new Vlayout();
        		dashboardColumnLayout.setAttribute("ColumnNo", "0");
        		dashboardColumnLayout.setAttribute("IsShowInDashboard", isShowInDashboard);
        		dashboardColumnLayout.setAttribute("IsAdditionalColumn", true);
        		Anchorchildren dashboardColumn = new Anchorchildren();
        		dashboardColumn.setAnchor((width-5) + "%" + " 100%");
        		if (!ClientInfo.isMobile())
        		{
        			dashboardColumn.setDroppable("true");
        			dashboardColumn.addEventListener(Events.ON_DROP, this);
        		}
        		dashboardColumn.appendChild(dashboardColumnLayout);
        		columnList.add(dashboardColumn);
                dashboardLayout.appendChild(dashboardColumn);
                ZKUpdateUtil.setWidth(dashboardColumnLayout, "100%");
            }
            else if (isShowInDashboard)
            {
            	// additional column
            	dashboardColumnLayout = new Vlayout();
            	ZKUpdateUtil.setWidth(dashboardColumnLayout, "100%");
        		dashboardColumnLayout.setAttribute("ColumnNo", currentColumnNo + 1);
        		dashboardColumnLayout.setAttribute("IsShowInDashboard", isShowInDashboard);
        		dashboardColumnLayout.setAttribute("IsAdditionalColumn", true);
        		Anchorchildren dashboardColumn = new Anchorchildren();
        		dashboardColumn.setAnchor(extraWidth + "% 100%");
        		if (!ClientInfo.isMobile())
        		{
        			dashboardColumn.setDroppable("true");
        			dashboardColumn.addEventListener(Events.ON_DROP, this);
        		}
        		dashboardColumn.appendChild(dashboardColumnLayout);
        		columnList.add(dashboardColumn);
                dashboardLayout.appendChild(dashboardColumn);
                ZKUpdateUtil.setWidth(dashboardColumnLayout, "100%");
            }
		}
        catch (Exception e)
        {
			logger.log(Level.WARNING, "Failed to create dashboard content", e);
		}
        //
                
        if (!update && !dashboardRunnable.isEmpty())
        {
        	dashboardRunnable.refreshDashboard(false);

			// default Update every one minutes
			int interval = MSysConfig.getIntValue(MSysConfig.ZK_DASHBOARD_REFRESH_INTERVAL, 60000);
			dashboardTimer = new Timer();
			dashboardTimer.setDelay(interval);
			dashboardTimer.setRepeats(true);
			dashboardTimer.addEventListener(Events.ON_TIMER, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					if (dashboardRunnable != null && !dashboardRunnable.isEmpty()) {
						dashboardRunnable.run();
					}
				}
			});
			dashboardTimer.setPage(parent.getPage());
		}
	}

	private Panel findPanel(int PA_DashboardContent_ID, int PA_DashboardPreference_ID) {
		for(Panel panel : panelList) {
			Object value1 = panel.getAttribute("PA_DashboardContent_ID");
			Object value2 = panel.getAttribute("PA_DashboardPreference_ID");
			if (value1 != null && value1 instanceof Number && value2 != null && value2 instanceof Number) {
				int id1 = ((Number)value1).intValue();
				int id2 = ((Number)value2).intValue();
				if (id1 == PA_DashboardContent_ID && id2 == PA_DashboardPreference_ID)
					return panel;
			}
		}
		return null;
	}

	public  boolean render(Component content, MDashboardContent dc, DashboardRunnable dashboardRunnable) throws Exception {
		boolean empty = true;
		
		// HTML content
        String htmlContent = dc.get_ID() > 0 ? dc.get_Translation(MDashboardContent.COLUMNNAME_HTML) : null;
        if(htmlContent != null)
        {
            StringBuilder result = new StringBuilder("<html><head>");

    		URL url = getClass().getClassLoader().getResource("org/compiere/css/PAPanel.css");
			InputStreamReader ins;
			BufferedReader bufferedReader = null;
			try {
				ins = new InputStreamReader(url.openStream());
				bufferedReader = new BufferedReader( ins );
				String cssLine;
				result.append("<style type=\"text/css\">");
				while ((cssLine = bufferedReader.readLine()) != null)
					result.append(cssLine + "\n");
				result.append("</style>");
			} catch (Exception e1) {
				logger.log(Level.SEVERE, e1.getLocalizedMessage(), e1);
			}
			finally{
				if (bufferedReader != null) {
					try {
						bufferedReader.close();
					} catch (Exception e) {}
					bufferedReader = null;
				}
			}
			result.append("</head><body><div class=\"content\">\n");

//        	if(description != null)
//        		result.append("<h2>" + description + "</h2>\n");
        	result.append(stripHtml(htmlContent, false) + "<br>\n");
        	result.append("</div>\n</body>\n</html>");

            Html html = new Html();
            html.setContent(result.toString());
            content.appendChild(html);
            empty = false;
        }

    	// Window
    	int AD_Window_ID = dc.getAD_Window_ID();
    	if(AD_Window_ID > 0)
    	{
        	int AD_Menu_ID = dc.getAD_Menu_ID();
        	Div div = new Div();
			ToolBarButton btn = new ToolBarButton(String.valueOf(AD_Menu_ID));
			I_AD_Menu menu = dc.getAD_Menu();
			btn.setLabel(menu.getName());
			btn.setAttribute("AD_Menu_ID", AD_Menu_ID);
			btn.addEventListener(Events.ON_CLICK, this);
			div.appendChild(btn);
			content.appendChild(div);
			empty = false;
    	}
    	
    	//Report & Process
    	int AD_Process_ID = dc.getAD_Process_ID();
    	if(AD_Process_ID > 0)
    	{
        	String sql = "SELECT AD_MENU_ID FROM AD_MENU WHERE AD_Process_ID=?";
        	int AD_Menu_ID = DB.getSQLValue(null, sql, AD_Process_ID);
			ToolBarButton btn = new ToolBarButton();
			MMenu menu = new MMenu(Env.getCtx(), AD_Menu_ID, null);					
			btn.setAttribute("AD_Menu_ID", AD_Menu_ID);
			btn.addEventListener(Events.ON_CLICK, this);					
			empty = false;
			
			if (dc.isEmbedReportContent()) 
			{
				String processParameters = dc.getProcessParameters();

				Iframe iframe = new Iframe();
				iframe.setSclass("dashboard-report-iframe");
				content.appendChild(iframe);
				iframe.setContent(generateReport(AD_Process_ID, processParameters));

				Toolbar toolbar = new Toolbar();
				content.appendChild(toolbar);
				btn.setLabel(Msg.getMsg(Env.getCtx(), "OpenRunDialog"));
				toolbar.appendChild(btn);
				
				btn = new ToolBarButton();
				btn.setAttribute("AD_Process_ID", AD_Process_ID);
				btn.setAttribute("ProcessParameters", processParameters);
				btn.addEventListener(Events.ON_CLICK, this);
				btn.setLabel(Msg.getMsg(Env.getCtx(), "ViewReportInNewTab"));
				toolbar.appendChild(new Separator("vertical"));
				toolbar.appendChild(btn);

				btn = new ToolBarButton();
				if (ThemeManager.isUseFontIconForImage()) {
					btn.setIconSclass("z-icon-Refresh");
					btn.setSclass("trash-toolbarbutton");
				}
				else
					btn.setImage(ThemeManager.getThemeResource("images/Refresh16.png"));

				btn.addEventListener(Events.ON_CLICK, e -> iframe.setContent(generateReport(AD_Process_ID, processParameters)));
				toolbar.appendChild(btn);
			}
			else
			{
				btn.setLabel(menu.getName());
				content.appendChild(btn);
			}
    	}

    	// Goal
    	int PA_Goal_ID = dc.getPA_Goal_ID();
    	if(PA_Goal_ID > 0)
    	{
    		//link to open performance detail
    		Div div = new Div();
    		Toolbarbutton link = new Toolbarbutton();
            link.setImage(ThemeManager.getThemeResource("images/Zoom16.png"));
            link.setAttribute("PA_Goal_ID", PA_Goal_ID);
            link.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					int PA_Goal_ID = (Integer)event.getTarget().getAttribute("PA_Goal_ID");
					MGoal goal = new MGoal(Env.getCtx(), PA_Goal_ID, null);
					new WPerformanceDetail(goal);
				}
            });
            div.appendChild(link);
            content.appendChild(div);

            String goalDisplay = dc.getGoalDisplay();
            MGoal goal = new MGoal(Env.getCtx(), PA_Goal_ID, null);
            WGraph graph = new WGraph(goal, 55, false, true,
            		!(MDashboardContent.GOALDISPLAY_Chart.equals(goalDisplay)),
            		MDashboardContent.GOALDISPLAY_Chart.equals(goalDisplay));
            content.appendChild(graph);
            empty = false;
    	}

        // ZUL file url
    	String url = dc.getZulFilePath();
    	if(url != null)
    	{
        	try {
        		
                Component component = Extensions.getDashboardGadget(url, content, dc);
                if(component != null)
                {
                	if (component instanceof Include)
                		component = component.getFirstChild();
                	
                	if (component instanceof DashboardPanel)
                	{
	                	DashboardPanel dashboardPanel = (DashboardPanel) component;
	                	if (!dashboardPanel.getChildren().isEmpty()) {
	                		content.appendChild(dashboardPanel);
	                		if (dashboardRunnable != null)
	                			dashboardRunnable.add(dashboardPanel);
	                		empty = false;
	                	}
                	}
                	else
                	{
                		content.appendChild(component);
                		empty = false;
                	}
                }
			} catch (Exception e) {
				logger.log(Level.WARNING, "Failed to create components. zul="+url, e);
				throw new AdempiereException(e);
			}
    	}

    	//chart
    	final int AD_Chart_ID = dc.getAD_Chart_ID();
    	if (AD_Chart_ID > 0) {
    		final Div chartPanel = new Div();	        	
    		chartPanel.setSclass("chart-gadget");
    		final MChart chartModel = new MChart(Env.getCtx(), AD_Chart_ID, null);
    		content.appendChild(chartPanel);
    		empty = false;	        		
    		chartPanel.addEventListener(Events.ON_AFTER_SIZE, new EventListener<AfterSizeEvent>() {
				@Override
				public void onEvent(AfterSizeEvent event) throws Exception {
	        		int width = event.getWidth()*90/100;
	        		int height = event.getHeight();
	        		//set normal height
	        		if (height == 0) {
	        			height = width * 85 / 100;
	        			chartPanel.setHeight(height+"px");
	        		}
	        		chartPanel.getChildren().clear();
	        		ChartModel model = new ChartModel();
	        		model.chart = chartModel;
	        		renderChart(chartPanel, width, height, model);
				}
			});
    	}
    	
    	return !empty;
	}
	
	public void onEvent(Event event) throws Exception {
		Component comp = event.getTarget();
        String eventName = event.getName();
        
		if (event instanceof MaximizeEvent)
		{
			MaximizeEvent me = (MaximizeEvent) event;
			Panel panel = (Panel) event.getTarget();
	    	if (me.isMaximized()) {
	    		prevParent = panel.getParent();
	    		prevNext = panel.getNextSibling();
	    		panel.detach();
	    		for (Anchorchildren anchorChildren : columnList) {
	    			anchorChildren.detach();
	    		}
	    		dashboardLayout.appendChild(maximizedHolder);
	    		maximizedHolder.appendChild(panel);
	    		panel.setSclass("dashboard-widget dashboard-widget-max");
	    	} else {
	    		maximizedHolder.detach();
	    		panel.detach();
	    		prevParent.insertBefore(panel, prevNext);
	    		for (Anchorchildren anchorChildren : columnList) {
	    			dashboardLayout.appendChild(anchorChildren);
	    		}
	    		panel.setSclass("dashboard-widget");
	    		//following 2 line needed for restore to size the panel correctly
	    		ZKUpdateUtil.setWidth(panel, null);
	    		ZKUpdateUtil.setHeight(panel, null);
	    	}
		}
		else if(eventName.equals(Events.ON_CLICK))
        {
            if(comp instanceof ToolBarButton)
            {
            	ToolBarButton btn = (ToolBarButton) comp;
            	
            	if (btn.getAttribute("AD_Menu_ID") != null)
            	{
	            	int menuId = (Integer)btn.getAttribute("AD_Menu_ID");
	            	if(menuId > 0) SessionManager.getAppDesktop().onMenuSelected(menuId);
            	}
            	else if (btn.getAttribute("AD_Process_ID") != null)
            	{
            		int processId = (Integer)btn.getAttribute("AD_Process_ID");
            		String parameters = (String)btn.getAttribute("ProcessParameters");
            		if (processId > 0)
            			openReportInViewer(processId, parameters);
            	}
            }
        }
		else if (eventName.equals(Events.ON_DROP))
		{
			DropEvent de = (DropEvent) event;
    		Component dragged = de.getDragged();
        	
    		if(dragged instanceof Caption)
    		{
    			Caption caption = (Caption) dragged;
       			Panel panel = null;
       			if (caption.getParent() instanceof Panel)
       				panel = (Panel) caption.getParent();

       			if (panel == null)
    				;
       			else if(comp instanceof Panel)
	        	{
	        		Panel target = (Panel) comp;
	
        			if (target.getParent() != null && target.getParent() instanceof Vlayout)
        			{
        				Vlayout dashboardColumnLayout = (Vlayout) target.getParent();
        				dashboardColumnLayout.insertBefore(panel, target);        				
        				saveDashboardPreference(dashboardColumnLayout);
        			}        			
	        	}
	        	else if (comp instanceof Anchorchildren)
	        	{
	        		Anchorchildren target = (Anchorchildren) comp;
	        		
        			if (target.getFirstChild() != null && target.getFirstChild() instanceof Vlayout)
        			{
        				Vlayout dashboardColumnLayout = (Vlayout) target.getFirstChild();
        				dashboardColumnLayout.appendChild(panel);
        				saveDashboardPreference(dashboardColumnLayout);
        			}
	        	}
    		}
		}
		else if (eventName.equals(Events.ON_OPEN))
		{
			if(comp instanceof Panel)
    		{
    			Panel panel = (Panel) comp;
    			Object value = panel.getAttribute("PA_DashboardPreference_ID");
    			if (value != null)
    			{
    				int PA_DashboardPreference_ID = Integer.parseInt(value.toString());
    				MDashboardPreference preference = new MDashboardPreference(Env.getCtx(), PA_DashboardPreference_ID, null);
    				preference.setIsCollapsedByDefault(!panel.isOpen());
    				if (!preference.save())
    					logger.log(Level.SEVERE, "Failed to save dashboard preference " + preference.toString());
    			}
    		}
		}
	}
	
	private void createDashboardPreference(int AD_User_ID, int AD_Role_ID)
	{
		MDashboardContent[] dcs = MDashboardContentAccess.get(Env.getCtx(),AD_Role_ID, AD_User_ID, null);
		for (MDashboardContent dc : dcs)
		{
			MDashboardPreference preference = new MDashboardPreference(Env.getCtx(), 0, null);
			preference.setAD_Org_ID(0);
			preference.setAD_Role_ID(AD_Role_ID);
			preference.setAD_User_ID(AD_User_ID); // allow System
			preference.setColumnNo(dc.getColumnNo());
			preference.setIsCollapsedByDefault(dc.isCollapsedByDefault());
			preference.setIsShowInDashboard(dc.isShowInDashboard());
			preference.setLine(dc.getLine());
			preference.setPA_DashboardContent_ID(dc.getPA_DashboardContent_ID());
			
			if (!preference.save())
				logger.log(Level.SEVERE, "Failed to create dashboard preference " + preference.toString());
		}
	}
	
	
	private boolean updatePreferences(MDashboardPreference[] dps,MDashboardContent[] dcs, Properties ctx) {
		boolean change = false;
		for (int i = 0; i < dcs.length; i++) {
			
			boolean isNew = true;
			for (int j = 0; j < dps.length; j++) {
				if (dps[j].getPA_DashboardContent_ID() == dcs[i].getPA_DashboardContent_ID()) {
					isNew = false;
				}
			}
			if (isNew) {
				MDashboardPreference preference = new MDashboardPreference(ctx,0, null);
				preference.setAD_Org_ID(0);
				preference.setAD_Role_ID(Env.getAD_Role_ID(ctx));
				preference.setAD_User_ID(Env.getAD_User_ID(ctx));  // allow System
				preference.setColumnNo(dcs[i].getColumnNo());
				preference.setIsCollapsedByDefault(dcs[i].isCollapsedByDefault());
				preference.setIsShowInDashboard(dcs[i].isShowInDashboard());
				preference.setLine(dcs[i].getLine());
				preference.setPA_DashboardContent_ID(dcs[i].getPA_DashboardContent_ID());

				preference.saveEx();
				if (!change) change = true;
			}
		}
		for (int i = 0; i < dps.length; i++) {
			boolean found = false;
			for (int j = 0; j < dcs.length; j++) {
				if (dcs[j].getPA_DashboardContent_ID() == dps[i].getPA_DashboardContent_ID()) {
					found = true;
				}
			}
			if (!found) {
				dps[i].deleteEx(true);
				if (!change) change = true;
			}
		}
		return change;
	}
	
	private void saveDashboardPreference(Vlayout layout)
	{
		Object value = layout.getAttribute("ColumnNo");
		if (value != null)
		{
			int columnNo = Integer.parseInt(value.toString());
			
			value = layout.getAttribute("IsShowInDashboard");
			if (value != null)
			{
				boolean isShowInDashboard = Boolean.parseBoolean(value.toString());
						
				List<Component> children = layout.getChildren();
				int counter = 0;
				for (Component child : children)
				{
					if (child instanceof Panel)
					{
						Panel panel = (Panel) child;
		    			value = panel.getAttribute("PA_DashboardPreference_ID");
		    			if (value != null)
		    			{
		    				++counter;
		    				
		    				int PA_DashboardPreference_ID = Integer.parseInt(value.toString());
		    				MDashboardPreference preference = new MDashboardPreference(Env.getCtx(), PA_DashboardPreference_ID, null);
		    				preference.setColumnNo(columnNo);
		    				preference.setLine(new BigDecimal(counter * 10));
		    				preference.setIsShowInDashboard(isShowInDashboard);
		    				if (!preference.save())
		    					logger.log(Level.SEVERE, "Failed to save dashboard preference " + preference.toString());
		    			}
					}
				}
				
				if (isShowInDashboard)
				{
					value = layout.getAttribute("IsAdditionalColumn");
					if (value != null)
					{
						boolean isAdditionalColumn = Boolean.parseBoolean(value.toString());
						if (isAdditionalColumn)
						{
							layout.setAttribute("IsAdditionalColumn", false);
							
							int noOfCols = columnList.size(); 
				        	int dashboardWidth = DEFAULT_DASHBOARD_WIDTH;
				            int width = noOfCols <= 0 ? dashboardWidth : dashboardWidth / noOfCols;
				            int extraWidth = 100 - (noOfCols <= 0 ? dashboardWidth : width * noOfCols) - (100 - dashboardWidth - 1);
							
							for (Anchorchildren column : columnList)
								column.setAnchor(width + "%" + " 100%");

							// additional column
							Vlayout dashboardColumnLayout = new Vlayout();
			        		dashboardColumnLayout.setAttribute("ColumnNo", columnNo + 1);
			        		dashboardColumnLayout.setAttribute("IsShowInDashboard", isShowInDashboard);
			        		dashboardColumnLayout.setAttribute("IsAdditionalColumn", true);
			        		Anchorchildren dashboardColumn = new Anchorchildren();
			        		dashboardColumn.setAnchor(extraWidth + "% 100%");
			        		if (!ClientInfo.isMobile()) {
			        			dashboardColumn.setDroppable("true");
			        			dashboardColumn.addEventListener(Events.ON_DROP, this);
			        		}
			        		dashboardColumn.appendChild(dashboardColumnLayout);
			        		columnList.add(dashboardColumn);
			                dashboardLayout.appendChild(dashboardColumn);
			                ZKUpdateUtil.setWidth(dashboardColumnLayout, "100%");
			                
			                dashboardLayout.invalidate();			                
						}
					}
				}
				
                if (!dashboardRunnable.isEmpty())
                	dashboardRunnable.refreshDashboard(false);
			}
		}
	}
	
	/**
	 * 
	 * @param page
	 * @param desktop
	 */
	public void onSetPage(Page page, Desktop desktop) {
		if (dashboardTimer != null) {
			
			DashboardRunnable tmp = dashboardRunnable;			
			dashboardRunnable = new DashboardRunnable(tmp, desktop);
			dashboardTimer.setPage(page);
		}
	}
	
	/**
	 * clean up for logout
	 */
	public void onLogOut() {
		if (dashboardTimer != null) {
			dashboardTimer.detach();
			dashboardTimer = null;
		}
		if (dashboardRunnable != null) {			
			dashboardRunnable = null;
		}
		dashboardLayout.detach();
		dashboardLayout = null;
	}

	public void addDashboardPanel(DashboardPanel dashboardPanel) {
		if (dashboardRunnable != null) {
			dashboardRunnable.add(dashboardPanel);
		}
	}
	
	private String stripHtml(String htmlString, boolean all) {
		htmlString = htmlString
		.replace("<html>", "")
		.replace("</html>", "")
		.replace("<body>", "")
		.replace("</body>", "")
		.replace("<head>", "")
		.replace("</head>", "");
		
		if (all)
			htmlString = htmlString
			.replace(">", "&gt;")
			.replace("<", "&lt;");
		return htmlString;
	}
	
	private ReportEngine runReport(int AD_Process_ID, String parameters) {
   		MProcess process = MProcess.get(Env.getCtx(), AD_Process_ID);
		if (!process.isReport() || process.getAD_ReportView_ID() == 0)
			 throw new IllegalArgumentException("Not a Report AD_Process_ID=" + process.getAD_Process_ID()
				+ " - " + process.getName());
		//	Process
		int AD_Table_ID = 0;
		int Record_ID = 0;
		//
		MPInstance pInstance = new MPInstance(process, Record_ID);
		fillParameter(pInstance, parameters);
		//
		ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID(),
			AD_Table_ID, Record_ID);
		pi.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
		pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());		
		if (!process.processIt(pi, null) && pi.getClassName() != null) 
			throw new IllegalStateException("Process failed: (" + pi.getClassName() + ") " + pi.getSummary());
	
		//	Report
		ReportEngine re = ReportEngine.get(Env.getCtx(), pi);
		if (re == null)
			throw new IllegalStateException("Cannot create Report AD_Process_ID=" + process.getAD_Process_ID()
				+ " - " + process.getName());
		
		return re;
	}

	public AMedia generateReport(int AD_Process_ID, String parameters) throws Exception {
		ReportEngine re = runReport(AD_Process_ID, parameters);

		File file = File.createTempFile(re.getName(), ".html");		
		re.createHTML(file, false, AEnv.getLanguage(Env.getCtx()), new HTMLExtension(Executions.getCurrent().getContextPath(), "rp", 
				SessionManager.getAppDesktop().getComponent().getUuid()));
		return new AMedia(re.getName(), "html", "text/html", file, false);
	}

   	protected void openReportInViewer(int AD_Process_ID, String parameters) {
   		ReportEngine re = runReport(AD_Process_ID, parameters);
   		new ZkReportViewerProvider().openViewer(re);
   	}

	private void fillParameter(MPInstance pInstance, String parameters) {		
		if (parameters != null && parameters.trim().length() > 0) {
			Map<String, String> paramMap = new HashMap<String, String>();
			String[] params = parameters.split("[,]");
			for (String s : params)
			{
				int pos = s.indexOf("=");
				String key = s.substring(0, pos);
				String value = s.substring(pos + 1);
				paramMap.put(key, value);
			}
			MPInstancePara[] iParams = pInstance.getParameters();
			for (MPInstancePara iPara : iParams)
			{
				String variable = paramMap.get(iPara.getParameterName());

				if (Util.isEmpty(variable))
					continue;

				boolean isTo = false;

				for (String paramValue : variable.split(";")) {

					 //				Value - Constant/Variable
					 Object value = paramValue;
					 if (paramValue == null
							 || (paramValue != null && paramValue.length() == 0))
						 value = null;
					 else if (paramValue.startsWith("@SQL=")) {
						 String sql = paramValue.substring(5);
						 sql = Env.parseContext(Env.getCtx(), 0, sql, false, false);	//	replace variables
						 if (!Util.isEmpty(sql)) {
							 PreparedStatement stmt = null;
							 ResultSet rs = null;
							 try {
								 stmt = DB.prepareStatement(sql, null);
								 rs = stmt.executeQuery();
								 if (rs.next()) {
									 if (   DisplayType.isNumeric(iPara.getDisplayType()) 
										 || DisplayType.isID(iPara.getDisplayType()))
										 value = rs.getBigDecimal(1);
									 else if (DisplayType.isDate(iPara.getDisplayType()))
										 value = rs.getTimestamp(1);
									 else
										 value = rs.getString(1);
								 } else {
									 if (logger.isLoggable(Level.INFO))
										 logger.log(Level.INFO, "(" + iPara.getParameterName() + ") - no Result: " + sql);
								 }
							 }
							 catch (SQLException e) {
								 logger.log(Level.WARNING, "(" + iPara.getParameterName() + ") " + sql, e);
							 }
							 finally{
								 DB.close(rs, stmt);
								 rs = null;
								 stmt = null;
							 }
						 }
					 }	//	SQL Statement
					 else if (paramValue.indexOf('@') != -1)	//	we have a variable
					 {
						 value = Env.parseContext(Env.getCtx(), 0, paramValue, false, false);
					 }	//	@variable@

					 //	No Value
					 if (value == null)
					 {
						 continue;
					 }

					 //	Convert to Type				
					 if (DisplayType.isNumeric(iPara.getDisplayType()))
					 {
						 BigDecimal bd = null;
						 if (value instanceof BigDecimal)
							 bd = (BigDecimal)value;
						 else if (value instanceof Integer)
							 bd = new BigDecimal (((Integer)value).intValue());
						 else
							 bd = new BigDecimal (value.toString());
						DecimalFormat decimalFormat = DisplayType.getNumberFormat(iPara.getDisplayType());
						String info = decimalFormat.format(iPara.getP_Number());
						 if (isTo) {
							 iPara.setP_Number_To(bd);
							 iPara.setInfo_To(info);
						 }
						 else {
							 iPara.setP_Number(bd);
							 iPara.setInfo(info);
						 }
					 }
					 else if (iPara.getDisplayType() == DisplayType.Search || iPara.getDisplayType() == DisplayType.Table || iPara.getDisplayType() == DisplayType.TableDir) {
						 int id = new BigDecimal (value.toString()).intValue();
						 if (isTo) {
							 iPara.setP_Number_To(new BigDecimal (value.toString()));
							 iPara.setInfo_To(getDisplay(pInstance, iPara, id));
						 }
						 else {
							 iPara.setP_Number(new BigDecimal (value.toString()));
							 iPara.setInfo(getDisplay(pInstance, iPara, id));
						 }
					 }
					 else if (DisplayType.isDate(iPara.getDisplayType()))
					 {
						 Timestamp ts = null;
						 if (value instanceof Timestamp)
							 ts = (Timestamp)value;
						 else
							 ts = Timestamp.valueOf(value.toString());
						SimpleDateFormat dateFormat = DisplayType.getDateFormat(iPara.getDisplayType());
						String info = dateFormat.format(ts);
						 if (isTo) {
							 iPara.setP_Date_To(ts);
							 iPara.setInfo_To(info);
						 }
						 else {
							 iPara.setP_Date(ts);
							 iPara.setInfo(info);
						 }
					 }
					 else
					 {
						 if (isTo) {
							 iPara.setP_String_To(value.toString());
							 iPara.setInfo_To(value.toString());
						 }
						 else {
							 iPara.setP_String(value.toString());
							 iPara.setInfo(value.toString());
						 }
					 }
					 iPara.saveEx();

					 isTo = true;
				 }
			}
		}				
	}

	private String getDisplay(MPInstance i, MPInstancePara ip, int id) {
		try {
			MProcessPara pp = MProcess.get(i.getAD_Process_ID()).getParameter(ip.getParameterName());

			if (pp != null) {

				MLookupInfo mli = MLookupFactory.getLookupInfo(Env.getCtx(), 0, 0, pp.getAD_Reference_ID(), Env.getLanguage(Env.getCtx()), "", pp.getAD_Reference_Value_ID(), false, "");

				PreparedStatement pstmt = null;
				ResultSet rs = null;
				StringBuilder name = new StringBuilder("");
				try
				{
					pstmt = DB.prepareStatement(mli.QueryDirect, null);
					pstmt.setInt(1, id);

					rs = pstmt.executeQuery();
					if (rs.next()) {
						name.append(rs.getString(3));
						boolean isActive = rs.getString(4).equals("Y");
						if (!isActive)
							name.insert(0, MLookup.INACTIVE_S).append(MLookup.INACTIVE_E);

						if (rs.next())
							logger.log(Level.SEVERE, "Error while displaying parameter for embedded report - Not unique (first returned) for SQL=" + mli.QueryDirect);
					}
				}
				catch (Exception e) {
					logger.log(Level.SEVERE, "Error while displaying parameter for embedded report - " + mli.KeyColumn + ": SQL=" + mli.QueryDirect + " : " + e);
				}
				finally {
					DB.close(rs, pstmt);
					rs = null;
					pstmt = null;
				}

				return name.toString();
			}
		}
		catch (Exception e) {
			logger.log(Level.WARNING, "Failed to retrieve data to display for embedded report " + MProcess.get(i.getAD_Process_ID()).getName() + " : " + ip.getParameterName(), e);
		}

		return Integer.toString(id);
	}

	public void updateLayout(ClientInfo clientInfo) {
		if (isShowInDashboard) {
			if (ClientInfo.isMobile()) {
				int n = 0;
	        	if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1)) {	        		
	        		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1)) {
	        			n = 1;
	        		} else {
	        			n = 2;
	        		}
	        	}
	        	if (noOfCols > 0 && n > 0 && noOfCols != n) {
	        		render(null, null, true, true);
	        		dashboardLayout.invalidate();
	        	}
        	}
		}			
	}

	private void renderChart(final Div chartPanel, int width, int height, ChartModel model) {
		List<IChartRendererService> list = Extensions.getChartRendererServices();
		for (IChartRendererService renderer : list) {
			if (renderer.renderChart(chartPanel, width, height, model))
				break;
		}
	}
}
