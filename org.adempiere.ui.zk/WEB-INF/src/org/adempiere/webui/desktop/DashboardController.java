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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.WReport;
import org.adempiere.webui.apps.graph.WGraph;
import org.adempiere.webui.apps.graph.WPerformanceDetail;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.dashboard.DashboardPanel;
import org.adempiere.webui.dashboard.DashboardRunnable;
import org.adempiere.webui.event.DrillEvent;
import org.adempiere.webui.event.ZoomEvent;
import org.adempiere.webui.report.HTMLExtension;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.ZkReportViewerProvider;
import org.compiere.model.I_AD_Menu;
import org.compiere.model.MDashboardContent;
import org.compiere.model.MGoal;
import org.compiere.model.MMenu;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.X_PA_DashboardContent;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MaximizeEvent;
import org.zkoss.zul.Anchorchildren;
import org.zkoss.zul.Anchorlayout;
import org.zkoss.zul.Html;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Style;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class DashboardController implements EventListener<Event> {

	private final static CLogger logger = CLogger.getCLogger(DashboardController.class);
	private Component prevParent;
	private Component prevNext;

	private List<Panel> panelList = new ArrayList<Panel>();
	private List<Anchorchildren> columnList = new ArrayList<Anchorchildren>();
	private Anchorlayout dashboardLayout;
	private Anchorchildren maximizedHolder;	
	private Thread dashboardThread;
	private DashboardRunnable dashboardRunnable;

	public DashboardController() {
		dashboardLayout = new Anchorlayout();
        dashboardLayout.setWidth("99%");
        dashboardLayout.setHeight("99%");
        dashboardLayout.setStyle("position: absolute;");
        dashboardLayout.setVflex("true");
        
        maximizedHolder = new Anchorchildren();                
        maximizedHolder.setAnchor("99% 99%");
	}
	
	public void render(Component parent, IDesktop desktopImpl, boolean isShowInDashboard) {
		Style style = new Style();
		//, .z-anchorchildren
		style.setContent(".z-anchorlayout-body { overflow:auto } .z-anchorchildren { overflow:visible } ");
		style.setPage(parent.getPage());
				
        parent.appendChild(dashboardLayout);

        if (!dashboardLayout.getDesktop().isServerPushEnabled())
        	dashboardLayout.getDesktop().enableServerPush(true);
        
        dashboardRunnable = new DashboardRunnable(parent.getDesktop(), desktopImpl);
        
        // Dashboard content
        Vlayout dashboardColumnLayout = null;
        int currentColumnNo = 0;

        int noOfCols = 0;
        int width = 0;

        try
		{
        	int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
        	MDashboardContent[] dps = MDashboardContent.getForSession(AD_User_ID);
        	if (dps.length == 0)
        		createUserPreference();
        	
        	dps = MDashboardContent.getForSession(isShowInDashboard, AD_User_ID); // based on user        	
        	noOfCols = MDashboardContent.getForSessionColumnCount(isShowInDashboard, AD_User_ID);
            
            width = noOfCols <= 0 ? 100 : 100 / noOfCols;
            for (final MDashboardContent dp : dps)
			{
	        	int columnNo = dp.getColumnNo();
	        	if(dashboardColumnLayout == null || currentColumnNo != columnNo)
	        	{
	        		dashboardColumnLayout = new Vlayout();
	        		dashboardColumnLayout.setAttribute("ColumnNo", columnNo);
	        		dashboardColumnLayout.setAttribute("IsShowInDashboard", isShowInDashboard);
	        		Anchorchildren dashboardColumn = new Anchorchildren();
	        		dashboardColumn.setAnchor((width-2) + "%" + " 100%");
	        		dashboardColumn.setDroppable("true");
	        		dashboardColumn.addEventListener(Events.ON_DROP, this);
	        		dashboardColumn.appendChild(dashboardColumnLayout);
	        		columnList.add(dashboardColumn);
	                dashboardLayout.appendChild(dashboardColumn);
	                dashboardColumnLayout.setWidth("100%");

	                currentColumnNo = columnNo;
	        	}

	        	Panel panel = new Panel();
	        	panel.setAttribute("PA_DashboardContent_ID", dp.getPA_DashboardContent_ID());
	        	panelList.add(panel);
	        	panel.addEventListener(Events.ON_MAXIMIZE, this);
	        	panel.setStyle("margin: 2px; position: relative;");
	        	panel.setTitle(dp.get_Translation(MDashboardContent.COLUMNNAME_Name));
	        	panel.setMaximizable(true);
	        	
	        	String description = dp.get_Translation(MDashboardContent.COLUMNNAME_Description);
            	if(description != null)
            		panel.setTooltiptext(description);

            	panel.setCollapsible(dp.isCollapsible());
            	panel.setOpen(!dp.isCollapsedByDefault());
            	panel.addEventListener(Events.ON_OPEN, this);
            	
            	panel.setDroppable("true");
            	panel.setDraggable("true");
            	panel.addEventListener(Events.ON_DROP, this);

	        	panel.setBorder("normal");
	        	dashboardColumnLayout.appendChild(panel);
	            Panelchildren content = new Panelchildren();
	            panel.appendChild(content);

	            boolean panelEmpty = true;

	            // HTML content
	            String htmlContent = dp.getHTML();
	            if(htmlContent != null)
	            {
		            StringBuilder result = new StringBuilder("<html><head>");

		    		URL url = getClass().getClassLoader().getResource("org/compiere/css/PAPanel.css");
					InputStreamReader ins;
					try {
						ins = new InputStreamReader(url.openStream());
						BufferedReader bufferedReader = new BufferedReader( ins );
						String cssLine;
						result.append("<style type=\"text/css\">");
						while ((cssLine = bufferedReader.readLine()) != null)
							result.append(cssLine + "\n");
						result.append("</style>");
					} catch (Exception e1) {
						logger.log(Level.SEVERE, e1.getLocalizedMessage(), e1);
					}

					result.append("</head><body><div class=\"content\">\n");

//	            	if(description != null)
//	            		result.append("<h2>" + description + "</h2>\n");
	            	result.append(stripHtml(htmlContent, false) + "<br>\n");
	            	result.append("</div>\n</body>\n</html>");

		            Html html = new Html();
		            html.setContent(result.toString());
		            content.appendChild(html);
		            panelEmpty = false;
	            }

	        	// Window
	        	int AD_Window_ID = dp.getAD_Window_ID();
	        	if(AD_Window_ID > 0)
	        	{
		        	int AD_Menu_ID = dp.getAD_Menu_ID();
					ToolBarButton btn = new ToolBarButton(String.valueOf(AD_Menu_ID));
					I_AD_Menu menu = dp.getAD_Menu();
					btn.setLabel(menu.getName());
					btn.setAttribute("AD_Menu_ID", AD_Menu_ID);
					btn.addEventListener(Events.ON_CLICK, this);
					content.appendChild(btn);
					panelEmpty = false;
	        	}
	        	
	        	//Report & Process
	        	int AD_Process_ID = dp.getAD_Process_ID();
	        	if(AD_Process_ID > 0)
	        	{
		        	String sql = "SELECT AD_MENU_ID FROM AD_MENU WHERE AD_Process_ID=?";
		        	int AD_Menu_ID = DB.getSQLValue(null, sql, AD_Process_ID);
					ToolBarButton btn = new ToolBarButton();
					MMenu menu = new MMenu(Env.getCtx(), AD_Menu_ID, null);					
					btn.setAttribute("AD_Menu_ID", AD_Menu_ID);
					btn.addEventListener(Events.ON_CLICK, this);					
					panelEmpty = false;
					
					if (dp.isEmbedReportContent()) 
					{
						String processParameters = dp.getProcessParameters();
						embedReport(content, AD_Process_ID, processParameters);
						content.addEventListener("onZoom", new EventListener<Event>() {
							public void onEvent(Event event) throws Exception {
								if (event instanceof ZoomEvent) 
								{
									ZoomEvent ze = (ZoomEvent) event;
									if (ze.getData() != null && ze.getData() instanceof MQuery) {
										AEnv.zoom((MQuery) ze.getData());
									}
								}
							}
			            });
						
						content.addEventListener(DrillEvent.ON_DRILL_DOWN, new EventListener<Event>() {
							public void onEvent(Event event) throws Exception {
								if (event instanceof DrillEvent)
								{
									DrillEvent de = (DrillEvent) event;
									if (de.getData() != null && de.getData() instanceof MQuery) {
										MQuery query = (MQuery) de.getData();
										executeDrill(query);
									}
								}
							}
			            });
						
						Toolbar toolbar = new Toolbar();
						content.appendChild(toolbar);
						btn.setLabel("Open run dialog");						
						toolbar.appendChild(btn);
						
						btn = new ToolBarButton();
						btn.setAttribute("AD_Process_ID", AD_Process_ID);
						btn.setAttribute("ProcessParameters", processParameters);
						btn.addEventListener(Events.ON_CLICK, this);
						btn.setLabel("View report in new tab");
						toolbar.appendChild(new Separator("vertical"));
						toolbar.appendChild(btn);
					}
					else
					{
						btn.setLabel(menu.getName());
						content.appendChild(btn);
					}
	        	}

	        	// Goal
	        	int PA_Goal_ID = dp.getPA_Goal_ID();
	        	if(PA_Goal_ID > 0)
	        	{
	        		//link to open performance detail
	        		Toolbarbutton link = new Toolbarbutton();
		            link.setImage("/images/Zoom16.png");
		            link.setAttribute("PA_Goal_ID", PA_Goal_ID);
		            link.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
						public void onEvent(Event event) throws Exception {
							int PA_Goal_ID = (Integer)event.getTarget().getAttribute("PA_Goal_ID");
							MGoal goal = new MGoal(Env.getCtx(), PA_Goal_ID, null);
							new WPerformanceDetail(goal);
						}
		            });
		            content.appendChild(link);

		            String goalDisplay = dp.getGoalDisplay();
		            MGoal goal = new MGoal(Env.getCtx(), PA_Goal_ID, null);
		            WGraph graph = new WGraph(goal, 55, false, true,
		            		!(X_PA_DashboardContent.GOALDISPLAY_Chart.equals(goalDisplay)),
		            		X_PA_DashboardContent.GOALDISPLAY_Chart.equals(goalDisplay));
		            content.appendChild(graph);
		            panelEmpty = false;
	        	}

	            // ZUL file url
	        	String url = dp.getZulFilePath();
	        	if(url != null)
	        	{
		        	try {
		                Component component = Executions.createComponents(url, content, null);
		                if(component != null)
		                {
		                	if (component instanceof DashboardPanel)
		                	{
			                	DashboardPanel dashboardPanel = (DashboardPanel) component;
			                	if (!dashboardPanel.getChildren().isEmpty()) {
			                		content.appendChild(dashboardPanel);
			                		dashboardRunnable.add(dashboardPanel);
			                		panelEmpty = false;
			                	}
		                	}
		                	else
		                	{
		                		content.appendChild(component);
		                		panelEmpty = false;
		                	}
		                }
					} catch (Exception e) {
						logger.log(Level.WARNING, "Failed to create components. zul="+url, e);
					}
	        	}

	        	if (panelEmpty)
	        		panel.detach();
	        }
            
            if (dps.length == 0)
            {
            	dashboardColumnLayout = new Vlayout();
        		dashboardColumnLayout.setAttribute("ColumnNo", "0");
        		dashboardColumnLayout.setAttribute("IsShowInDashboard", isShowInDashboard);
        		Anchorchildren dashboardColumn = new Anchorchildren();
        		dashboardColumn.setAnchor((width-2) + "%" + " 100%");
        		dashboardColumn.setDroppable("true");
        		dashboardColumn.addEventListener(Events.ON_DROP, this);
        		dashboardColumn.appendChild(dashboardColumnLayout);
        		columnList.add(dashboardColumn);
                dashboardLayout.appendChild(dashboardColumn);
                dashboardColumnLayout.setWidth("100%");
            }
		}
        catch (Exception e)
        {
			logger.log(Level.WARNING, "Failed to create dashboard content", e);
		}
        //
                
        if (!dashboardRunnable.isEmpty())
        {
        	dashboardRunnable.refreshDashboard();

	        dashboardThread = new Thread(dashboardRunnable, "UpdateInfo");
        	dashboardThread.setDaemon(true);
        	dashboardThread.start();
		}       
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
	    	} else {
	    		maximizedHolder.detach();
	    		panel.detach();
	    		prevParent.insertBefore(panel, prevNext);
	    		for (Anchorchildren anchorChildren : columnList) {
	    			dashboardLayout.appendChild(anchorChildren);
	    		}
	    		//following 2 line needed for restore to size the panel correctly
	    		panel.setWidth(null);
	    		panel.setHeight(null);
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
        	
    		if(dragged instanceof Panel)
    		{
    			Panel panel = (Panel) dragged;
    			
	        	if(comp instanceof Panel)
	        	{
	        		Panel target = (Panel) comp;
	
        			if (target.getParent() != null && target.getParent() instanceof Vlayout)
        			{
        				Vlayout dashboardColumnLayout = (Vlayout) target.getParent();
        				dashboardColumnLayout.insertBefore(panel, target);        				
        				saveUserPreference(dashboardColumnLayout);
        			}        			
	        	}
	        	else if (comp instanceof Anchorchildren)
	        	{
	        		Anchorchildren target = (Anchorchildren) comp;
	        		
        			if (target.getFirstChild() != null && target.getFirstChild() instanceof Vlayout)
        			{
        				Vlayout dashboardColumnLayout = (Vlayout) target.getFirstChild();
        				dashboardColumnLayout.appendChild(panel);
        				saveUserPreference(dashboardColumnLayout);
        			}
	        	}
    		}
		}
		else if (eventName.equals(Events.ON_OPEN))
		{
			if(comp instanceof Panel)
    		{
    			Panel panel = (Panel) comp;
    			Object value = panel.getAttribute("PA_DashboardContent_ID");
    			if (value != null)
    			{
    				int PA_DashboardContent_ID = Integer.parseInt(value.toString());
    				MDashboardContent dashboardContent = new MDashboardContent(Env.getCtx(), PA_DashboardContent_ID, null);
    				dashboardContent.setIsCollapsedByDefault(!panel.isOpen());
    				if (!dashboardContent.save())
    					logger.log(Level.SEVERE, "Failed to save dashboard content edit " + dashboardContent.toString());
    			}
    		}
		}
	}
	
	private void createUserPreference()
	{
		if (Env.getAD_User_ID(Env.getCtx()) == 0)
			return;
		
		MDashboardContent[] dps = MDashboardContent.getForSession(0);
		for (MDashboardContent dp : dps)
		{
			MDashboardContent dashboardContent = new MDashboardContent(Env.getCtx(), 0, null);
			dashboardContent.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
			dashboardContent.setAD_Role_ID(Env.getAD_Role_ID(Env.getCtx()));
			dashboardContent.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));

			dashboardContent.setAD_Process_ID(dp.getAD_Process_ID());
			dashboardContent.setAD_Window_ID(dp.getAD_Window_ID());
			dashboardContent.setColumnNo(dp.getColumnNo());
			dashboardContent.setDescription(dp.getDescription());
			dashboardContent.setGoalDisplay(dp.getGoalDisplay());
			dashboardContent.setHTML(dp.getHTML());
			dashboardContent.setIsCollapsedByDefault(dp.isCollapsedByDefault());
			dashboardContent.setIsCollapsible(dp.isCollapsible());
			dashboardContent.setIsEmbedReportContent(dp.isEmbedReportContent());
			dashboardContent.setIsShowInDashboard(dp.isShowInDashboard());
			dashboardContent.setLine(dp.getLine());
			dashboardContent.setName(dp.getName());
			dashboardContent.setPA_Goal_ID(dp.getPA_Goal_ID());
			dashboardContent.setZulFilePath(dp.getZulFilePath());
			
			if (!dashboardContent.save())
				logger.log(Level.SEVERE, "Failed to create dashboard content edit " + dashboardContent.toString());
		}
	}
	
	private void saveUserPreference(Vlayout layout)
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
		    			value = panel.getAttribute("PA_DashboardContent_ID");
		    			if (value != null)
		    			{
		    				++counter;
		    				
		    				int PA_DashboardContent_ID = Integer.parseInt(value.toString());
		    				MDashboardContent dashboardContent = new MDashboardContent(Env.getCtx(), PA_DashboardContent_ID, null);
		    				dashboardContent.setColumnNo(columnNo);
		    				dashboardContent.setLine(new BigDecimal(counter * 10));
		    				dashboardContent.setIsShowInDashboard(isShowInDashboard);
		    				if (!dashboardContent.save())
		    					logger.log(Level.SEVERE, "Failed to save dashboard content edit " + dashboardContent.toString());
		    			}
					}
				}
			}
		}
	}
	
	/**
	 * 
	 * @param page
	 * @param desktop
	 * @param appDesktop
	 */
	public void onSetPage(Page page, Desktop desktop, IDesktop appDesktop) {
		if (dashboardThread != null && dashboardThread.isAlive()) {
			dashboardRunnable.stop();
			dashboardThread.interrupt();

			DashboardRunnable tmp = dashboardRunnable;
			dashboardRunnable = new DashboardRunnable(tmp, desktop, appDesktop);
			dashboardThread = new Thread(dashboardRunnable, "UpdateInfo");
	        dashboardThread.setDaemon(true);
	        dashboardThread.start();
		}
	}
	
	/**
	 * clean up for logout
	 */
	public void onLogOut() {
		if (dashboardThread != null && dashboardThread.isAlive()) {
			dashboardRunnable.stop();
			dashboardThread.interrupt();
		}
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
			new IllegalArgumentException("Not a Report AD_Process_ID=" + process.getAD_Process_ID()
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
			new IllegalStateException("Process failed: (" + pi.getClassName() + ") " + pi.getSummary());
	
		//	Report
		ReportEngine re = ReportEngine.get(Env.getCtx(), pi);
		if (re == null)
			new IllegalStateException("Cannot create Report AD_Process_ID=" + process.getAD_Process_ID()
				+ " - " + process.getName());
		
		return re;
   	}
   	
   	public void embedReport(Component parent, int AD_Process_ID, String parameters) throws Exception {
		ReportEngine re = runReport(AD_Process_ID, parameters);
		
		Iframe iframe = new Iframe();
		iframe.setWidth("99%");
		iframe.setHeight("90%");
		iframe.setStyle("min-height:300px; border: 1px solid lightgray; margin:auto");
		File file = File.createTempFile(re.getName(), ".html");		
		re.createHTML(file, false, AEnv.getLanguage(Env.getCtx()), new HTMLExtension(Executions.getCurrent().getContextPath(), "rp", parent.getUuid()));
		AMedia media = new AMedia(re.getName(), "html", "text/html", file, false);
		iframe.setContent(media);
		parent.appendChild(iframe);
	}
   	
   	protected void openReportInViewer(int AD_Process_ID, String parameters) {
   		ReportEngine re = runReport(AD_Process_ID, parameters);
   		new ZkReportViewerProvider().openViewer(re);
   	}

   	/**
	 * 	Execute Drill to Query
	 * 	@param query query
	 */
   	public void executeDrill (MQuery query)
	{
		int AD_Table_ID = MTable.getTable_ID(query.getTableName());
		if (!MRole.getDefault().isCanReport(AD_Table_ID))
		{
			FDialog.error(0, dashboardLayout.getParent(), "AccessCannotReport", query.getTableName());
			return;
		}
		if (AD_Table_ID != 0)
			new WReport(AD_Table_ID, query);		
	}	//	executeDrill
	
	private void fillParameter(MPInstance pInstance, String parameters) {		
		if (parameters != null && parameters.trim().length() > 0) {
			Map<String, String> paramMap = new HashMap<String, String>();
			String[] params = parameters.split("[,]");
			for (String s : params)
			{
				String[] elements = s.split("[=]");
				String key = elements[0];
				String value = elements[1];
				paramMap.put(key, value);
			}
			MPInstancePara[] iParams = pInstance.getParameters();
			for (MPInstancePara iPara : iParams)
			{
				 String variable = paramMap.get(iPara.getParameterName());
	//				Value - Constant/Variable
				Object value = variable;
				if (variable == null
					|| (variable != null && variable.length() == 0))
					value = null;
				else if (variable.indexOf('@') != -1)	//	we have a variable
				{
					value = Env.parseContext(Env.getCtx(), 0, variable, false, false);
				}	//	@variable@
				
				//	No Value
				if (value == null)
				{
					continue;
				}
				
				//	Convert to Type				
				if (DisplayType.isNumeric(iPara.getDisplayType()) 
					|| DisplayType.isID(iPara.getDisplayType()))
				{
					BigDecimal bd = null;
					if (value instanceof BigDecimal)
						bd = (BigDecimal)value;
					else if (value instanceof Integer)
						bd = new BigDecimal (((Integer)value).intValue());
					else
						bd = new BigDecimal (value.toString());
					iPara.setP_Number(bd);
				}
				else if (DisplayType.isDate(iPara.getDisplayType()))
				{
					Timestamp ts = null;
					if (value instanceof Timestamp)
						ts = (Timestamp)value;
					else
						ts = Timestamp.valueOf(value.toString());
					iPara.setP_Date(ts);
				}
				else
				{
					iPara.setP_String(value.toString());
				}
				iPara.saveEx();
				
			}
		}				
	}
}
