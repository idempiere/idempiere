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
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.webui.apps.graph.WGraph;
import org.adempiere.webui.apps.graph.WPerformanceDetail;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.dashboard.DashboardPanel;
import org.adempiere.webui.dashboard.DashboardRunnable;
import org.compiere.model.I_AD_Menu;
import org.compiere.model.MDashboardContent;
import org.compiere.model.MGoal;
import org.compiere.model.X_PA_DashboardContent;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MaximizeEvent;
import org.zkoss.zul.Anchorchildren;
import org.zkoss.zul.Anchorlayout;
import org.zkoss.zul.Html;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Style;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class DashboardController implements EventListener<MaximizeEvent> {

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
	
	public void render(Component parent, IDesktop desktopImpl) {
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
            noOfCols = MDashboardContent.getForSessionColumnCount();
            width = noOfCols <= 0 ? 100 : 100 / noOfCols;
            for (final MDashboardContent dp : MDashboardContent.getForSession())
			{
	        	int columnNo = dp.getColumnNo();
	        	if(dashboardColumnLayout == null || currentColumnNo != columnNo)
	        	{
	        		dashboardColumnLayout = new Vlayout();
	        		Anchorchildren dashboardColumn = new Anchorchildren();
	        		dashboardColumn.setAnchor((width-2) + "%" + " 100%");
	        		dashboardColumn.appendChild(dashboardColumnLayout);
	        		columnList.add(dashboardColumn);
	                dashboardLayout.appendChild(dashboardColumn);
	                dashboardColumnLayout.setWidth("100%");

	                currentColumnNo = columnNo;
	        	}

	        	Panel panel = new Panel();
	        	panelList.add(panel);
	        	panel.addEventListener(Events.ON_MAXIMIZE, this);
	        	panel.setStyle("margin: 2px; position: relative;");
	        	panel.setTitle(dp.get_Translation(MDashboardContent.COLUMNNAME_Name));
	        	panel.setMaximizable(true);
	        	
	        	String description = dp.get_Translation(MDashboardContent.COLUMNNAME_Description);
            	if(description != null)
            		panel.setTooltiptext(description);

            	panel.setCollapsible(dp.isCollapsible());

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

		    		URL url = getClass().getClassLoader().getResource("org/compiere/images/PAPanel.css");
					InputStreamReader ins;
					try {
						ins = new InputStreamReader(url.openStream());
						BufferedReader bufferedReader = new BufferedReader( ins );
						String cssLine;
						while ((cssLine = bufferedReader.readLine()) != null)
							result.append(cssLine + "\n");
					} catch (IOException e1) {
						logger.log(Level.SEVERE, e1.getLocalizedMessage(), e1);
					}

					result.append("</head><body><div class=\"content\">\n");

//	            	if(description != null)
//	            		result.append("<h2>" + description + "</h2>\n");
	            	result.append(stripHtml(htmlContent, false) + "<br>\n");
	            	result.append("</div>\n</body>\n</html>\n</html>");

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
	
	@Override
	public void onEvent(MaximizeEvent event) throws Exception {
		Panel panel = (Panel) event.getTarget();
    	if (event.isMaximized()) {
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
}
