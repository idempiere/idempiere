/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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

package org.adempiere.webui.panel;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Anchorchildren;
import org.adempiere.webui.component.Anchorlayout;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.event.ZoomEvent;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WCtxHelpSuggestion;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_AD_CtxHelpMsg;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.I_AD_WF_Node;
import org.compiere.model.I_AD_Workflow;
import org.compiere.model.MCtxHelpMsg;
import org.compiere.model.MCtxHelpSuggestion;
import org.compiere.model.MForm;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTab;
import org.compiere.model.MTask;
import org.compiere.model.MUserDefInfo;
import org.compiere.model.PO;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWorkflow;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Html;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Style;
import org.zkoss.zul.Vlayout;

/**
 * Controller for context help, context tool tip and context quick info gadget.
 * @author Elaine
 */
public class HelpController
{	
	private Anchorlayout dashboardLayout;
	private Panel pnlToolTip, pnlContextHelp, pnlQuickInfo;
	private Html htmlToolTip, htmlContextHelp, htmlQuickInfo;
	
	/**
	 * Default constructor
	 */
	public HelpController()
    {
		dashboardLayout = new Anchorlayout();
        dashboardLayout.setSclass("dashboard-layout");
        ZKUpdateUtil.setVflex(dashboardLayout, "1");
        ZKUpdateUtil.setHflex(dashboardLayout, "1");
    }

	/**
	 * Render tooltips, context help and quick info.
	 * @param parent
	 * @param desktopImpl
	 */
	public void render(Component parent, IDesktop desktopImpl)
    {
    	Style style = new Style();
		style.setContent(".z-anchorlayout { overflow:auto } .z-anchorchildren { overflow:visible } ");
		style.setPage(parent.getPage());
		
		parent.appendChild(dashboardLayout);
        
        Vlayout dashboardColumnLayout = new Vlayout();
        ZKUpdateUtil.setHflex(dashboardColumnLayout, "1");

        Anchorchildren dashboardColumn = new Anchorchildren();
		dashboardColumn.setAnchor("95% 100%");
		dashboardColumn.appendChild(dashboardColumnLayout);
        dashboardLayout.appendChild(dashboardColumn);
        
        Panelchildren content = new Panelchildren();

        pnlQuickInfo = new Panel();
        pnlQuickInfo.setSclass("dashboard-widget");
        pnlQuickInfo.setTitle(Msg.getMsg(Env.getCtx(), "QuickInfo"));
        pnlQuickInfo.setMaximizable(false);
        pnlQuickInfo.setCollapsible(true);
        pnlQuickInfo.setOpen(true);
        pnlQuickInfo.setBorder("normal");
    	dashboardColumnLayout.appendChild(pnlQuickInfo);
    	content = new Panelchildren();
    	pnlQuickInfo.appendChild(content);
        content.appendChild(htmlQuickInfo = new Html());
		Env.setContext(Env.getCtx(), "#clientInfo_QuickInfoComponentId", htmlQuickInfo.getUuid());
    	htmlQuickInfo.addEventListener(ZoomEvent.EVENT_NAME, new EventListener<Event>() {
			public void onEvent(Event event) throws Exception {
				if (event instanceof ZoomEvent) {
					Clients.clearBusy();
					ZoomEvent ze = (ZoomEvent) event;
					if (ze.getData() != null && ze.getData() instanceof MQuery) {
						AEnv.zoom((MQuery) ze.getData());
					}
				}
				
			}
		});

        pnlToolTip = new Panel();
        pnlToolTip.setSclass("dashboard-widget");
        pnlToolTip.setTitle(Msg.getMsg(Env.getCtx(), "ToolTip"));
    	pnlToolTip.setMaximizable(false);
    	pnlToolTip.setCollapsible(true);
    	pnlToolTip.setOpen(true);
    	pnlToolTip.setBorder("normal");
    	dashboardColumnLayout.appendChild(pnlToolTip);
    	content = new Panelchildren();
        pnlToolTip.appendChild(content);
        content.appendChild(htmlToolTip = new Html());
        htmlToolTip.setWidgetOverride("defaultMessage", "'"+Msg.getMsg(Env.getCtx(), "PlaceCursorIntoField")+"'");
        htmlToolTip.setWidgetOverride("onFieldTooltip", "function(origin,opts,header,description,help,entityType)" +
        		"{let s='<html><body><div class=\"help-content\">';" +
        		"if (typeof header == 'undefined') {s=s+'<i>'+this.defaultMessage+'</i>';} " +
        		"else {s=s+'<b>'+header+'</b>';" +
        		"if (typeof description=='string' && description.length > 0) {s=s+'<br><br><i>'+description+'</i>';}" +
        		"if (typeof help=='string' && help.length > 0) {s=s+'<br><br>'+help;}" +
        		"if (typeof entityType=='string' && entityType.length > 0) {s=s+'<p class=\"help-entitytype\">[ '+entityType+' ]</p>';}}" +
        		"s=s+'</div></body></html>';this.setContent(s);}");
        setupFieldTooltip();
        
        pnlContextHelp = new Panel();
        pnlContextHelp.setSclass("dashboard-widget");
        pnlContextHelp.setTitle(Msg.getMsg(Env.getCtx(), "HowTo"));
        pnlContextHelp.setMaximizable(false);
        pnlContextHelp.setCollapsible(true);
    	pnlContextHelp.setOpen(true);
    	pnlContextHelp.setBorder("normal");
    	dashboardColumnLayout.appendChild(pnlContextHelp);
    	content = new Panelchildren();
    	pnlContextHelp.appendChild(content);
        content.appendChild(htmlContextHelp = new Html());         
        
        renderToolTip(null);
        renderCtxHelp(X_AD_CtxHelp.CTXTYPE_Home, 0);
        renderQuickInfo(null);
    }

	/**
	 * Setup client side script for field tooltip
	 */
	public void setupFieldTooltip() {
		Clients.response("helpControllerFieldTooltip", 
				new AuScript(htmlToolTip, "(function(){let w=zk.Widget.$('#"+htmlToolTip.getUuid()
				+"');zWatch.listen({onFieldTooltip: w});})()"));
	}
    
	/**
	 * Render tooltip content for a field 
	 * @param field
	 */
    public void renderToolTip(GridField field)
    {    	
    	String hdr = null;
    	String desc = null;
    	String help = null;
    	String otherContent = null;
    	String entityType = null;
    	
    	if (field != null)
    	{
    		hdr = field.getHeader();
			if (hdr != null && hdr.length() > 0)
			{	
				if (field.getDescription().length() != 0)
					desc = field.getDescription();
				
				if (field.getHelp().length() != 0)
					help = field.getHelp();
				
				if (Env.IsShowTechnicalInfOnHelp(Env.getCtx())
						&& field.getEntityType().length() != 0)
					entityType = field.getEntityType();
			}
    	}
    	else
    	{
    		otherContent = Msg.getMsg(Env.getCtx(), "PlaceCursorIntoField");
    	}
    	
    	renderToolTip(hdr, desc, help, otherContent, entityType);
    }
    
    /**
     * Render tooltip content, when hdr == null, show otherContent
     * @param hdr
     * @param desc
     * @param help
     * @param otherContent
     */
    public void renderToolTip(String hdr, String  desc, String help, String otherContent,String entityType)
    {
    	if (Util.isEmpty(hdr) && Util.isEmpty(otherContent))
    		pnlToolTip.setVisible(false);
    	else if (!pnlToolTip.isVisible())
    		pnlToolTip.setVisible(true);

    	StringBuilder sb = new StringBuilder();
    	sb.append("<html>\n<body>\n<div class=\"help-content\">\n");
    	
    	if (hdr == null || hdr.trim().length() == 0){
    		if (otherContent == null){
    			otherContent = Msg.getMsg(Env.getCtx(), "PlaceCursorIntoField");
    		}
    		
			sb.append("<i>(");
			sb.append (otherContent);
			sb.append (")</i>");
    	}else{
    		sb.append("<b>");
    		sb.append(hdr);
    		sb.append("</b>");
    		
    		if (desc != null && desc.trim().length() > 0){
    			sb.append("<br><br>\n<i>");
    			sb.append(desc);
    			sb.append("</i>");
    		}
    		
    		if (help != null && help.trim().length() > 0){
    			sb.append("<br><br>\n");
    			sb.append(help);
    		}
    		
    		if (Env.IsShowTechnicalInfOnHelp(Env.getCtx()))
    		{
	    		if (entityType != null && entityType.trim().length() > 0){
	    			sb.append("<p class=\"help-entitytype\">[ ");
	    			sb.append(entityType);
	    			sb.append(" ]</p>");

	    		}
    		}
    		
    	}    	
    	
    	sb.append("</div>\n</body>\n</html>");
    	htmlToolTip.setContent(sb.toString());
    }
    
    /**
     * Render context help (AD_CtxHelpMsg)
     * @param ctxType
     * @param recordId
     */
    public void renderCtxHelp(String ctxType, int recordId)
    {
    	if (ctxType != X_AD_CtxHelp.CTXTYPE_Home && ctxType != X_AD_CtxHelp.CTXTYPE_Tab && 
    			ctxType != X_AD_CtxHelp.CTXTYPE_Process && ctxType != X_AD_CtxHelp.CTXTYPE_Form && 
    			ctxType != X_AD_CtxHelp.CTXTYPE_Info && ctxType != X_AD_CtxHelp.CTXTYPE_Workflow && 
    			ctxType != X_AD_CtxHelp.CTXTYPE_Task && ctxType != X_AD_CtxHelp.CTXTYPE_Node)
    		ctxType = X_AD_CtxHelp.CTXTYPE_Home;
    			
    	if (recordId == 0)
    		ctxType = X_AD_CtxHelp.CTXTYPE_Home;
    	
    	pnlToolTip.setVisible(ctxType.equals(X_AD_CtxHelp.CTXTYPE_Tab) || 
    			ctxType.equals(X_AD_CtxHelp.CTXTYPE_Process) || 
    			ctxType.equals(X_AD_CtxHelp.CTXTYPE_Info));
    	pnlContextHelp.setTitle(ctxType.equals(X_AD_CtxHelp.CTXTYPE_Home) ? Msg.getMsg(Env.getCtx(), "GettingStarted") : Msg.getMsg(Env.getCtx(), "HowTo"));
    		
    	StringBuilder sb = new StringBuilder();
    	sb.append("<div class=\"help-content\">\n");
    	    	
    	MCtxHelpMsg ctxHelpMsg = getCtxHelpMsg(ctxType, recordId);
    	String helpMsg, nameMsg, descMsg;
    	Component previousPopup = (Component) pnlContextHelp.removeAttribute("contextMenu");
		if (previousPopup != null)
			previousPopup.detach();
		pnlContextHelp.setContext((Popup)null);
    	if (ctxHelpMsg != null)
    	{
	    	sb.append(stripHtml(ctxHelpMsg.get_Translation(I_AD_CtxHelpMsg.COLUMNNAME_MsgText), false) + "<br>\n");

	    	if (!MRole.getDefault().isTableAccessExcluded(MCtxHelpSuggestion.Table_ID)) {
	    		ContextHelpMenupopup popup = new ContextHelpMenupopup(ctxHelpMsg);
	    		pnlContextHelp.setAttribute("contextMenu", popup);
	    		pnlContextHelp.setContext(popup);
	    		popup.setPage(pnlContextHelp.getPage());
	    	}
    	}
    	else
    	{
    		StringBuilder baseContent = new StringBuilder();
    		StringBuilder translatedContent = new StringBuilder();

    		if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Tab))
        	{
        		MTab tab = MTab.get(recordId);
        		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Tab")) {

					nameMsg = tab.get_Translation("Name", false);
					if (tab != null && nameMsg != null && nameMsg.length() != 0)
						translatedContent.append("<p><strong>" + nameMsg + "</strong></p>\n");

					descMsg = tab.get_Translation("Description", false);
					if (descMsg != null && descMsg.length() != 0)
						translatedContent.append("<p><em>" + descMsg + "</em></p>\n");

					helpMsg = tab.get_Translation("Help", false);
					if (helpMsg != null && helpMsg.length() != 0)
						translatedContent.append("<p>" + helpMsg + "</p>\n");
					
					if (translatedContent.length() > 0)
					{
						appendEntityType(translatedContent, tab.getEntityType());
						
						translatedContent.insert(0, "<p>\n");
						translatedContent.append("</p>");
					}

				}

				if (tab != null && tab.getName() != null
						&& tab.getName().length() != 0) 
					baseContent.append("<p><strong>" + tab.getName() + "</strong></p>\n");

				if (tab.getDescription() != null
						&& tab.getDescription().length() != 0)
					baseContent.append("<p><em>" + tab.getDescription() + "</em></p>\n");

				if (tab.getHelp() != null
						&& tab.getHelp().length() != 0)
					baseContent.append("<p>" + tab.getHelp() + "</p>\n");				
				
				if (baseContent.length() > 0)
				{
					appendEntityType(baseContent, tab.getEntityType());
					
					baseContent.insert(0, "<p>\n");
					baseContent.append("</p>");
				}
				
        		sb.append(Util.isEmpty(translatedContent.toString()) ? baseContent.toString() : translatedContent.toString());

        		addContextHelpMenupopup(tab, baseContent, translatedContent);
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Process))
        	{
        		MProcess process = MProcess.get(Env.getCtx(), recordId);
        		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Process")) {

					nameMsg = process.get_Translation("Name", false);
					if (process != null && nameMsg != null
							&& nameMsg.length() != 0)
						translatedContent.append("<p><strong>" + nameMsg + "</strong></p>\n");

					descMsg = process.get_Translation("Description", false);
					if (descMsg != null && descMsg.length() != 0)
						translatedContent.append("<p><em>" + descMsg + "</em></p>\n");

					helpMsg = process.get_Translation("Help", false);
					if (helpMsg != null && helpMsg.length() != 0)
						translatedContent.append("<p>" + helpMsg + "</p>\n");
					
					if (translatedContent.length() > 0)
					{
						appendEntityType(translatedContent, process.getEntityType());
						
						translatedContent.insert(0, "<p>\n");
						translatedContent.append("</p>");
					}

				} 

				if (process != null && process.getName() != null
						&& process.getName().length() != 0)
					baseContent.append("<p><strong>" + process.getName() + "</strong></p>\n");

				if (process.getDescription() != null
						&& process.getDescription().length() != 0)
					baseContent.append("<p><em>" + process.getDescription() + "</em></p>\n");

				if (process.getHelp() != null
						&& process.getHelp().length() != 0)
					baseContent.append("<p>" + process.getHelp() + "</p>\n");
				
				if (baseContent.length() > 0)
				{
					appendEntityType(baseContent, process.getEntityType());
					
					baseContent.insert(0, "<p>\n");
					baseContent.append("</p>");
				}
				
        		sb.append(Util.isEmpty(translatedContent.toString()) ? baseContent.toString() : translatedContent.toString());

        		addContextHelpMenupopup(process, baseContent, translatedContent);
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Form))
        	{
        		MForm form = MForm.get(recordId);
        		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Form")) {

					nameMsg = form.get_Translation("Name",false);
					if (form != null && nameMsg != null
							&& nameMsg.length() != 0)
						translatedContent.append("<p><strong>" + nameMsg + "</strong></p>\n");

					descMsg = form.get_Translation("Description",false);
					if (descMsg != null && descMsg.length() != 0)
						translatedContent.append("<p><em>" + descMsg + "</em></p>\n");

					helpMsg = form.get_Translation("Help",false);
					if (helpMsg != null && helpMsg.length() != 0)
						translatedContent.append("<p>" + helpMsg + "</p>\n");

					if (translatedContent.length() > 0)
					{
						appendEntityType(translatedContent, form.getEntityType());
						
						translatedContent.insert(0, "<p>\n");
						translatedContent.append("</p>");
					}
				} 

				if (form != null && form.getName() != null
						&& form.getName().length() != 0) 
					baseContent.append("<p><strong>" + form.getName() + "</strong></p>\n");

				if (form.getDescription() != null
						&& form.getDescription().length() != 0)
					baseContent.append("<p><em>" + form.getDescription() + "</em></p>\n");

				if (form.getHelp() != null
						&& form.getHelp().length() != 0)
					baseContent.append("<p>" + form.getHelp() + "</p>\n");
				
				if (baseContent.length() > 0)
				{
					appendEntityType(baseContent, form.getEntityType());
					
					baseContent.insert(0, "<p>\n");
					baseContent.append("</p>");
				}
				
        		sb.append(Util.isEmpty(translatedContent.toString()) ? baseContent.toString() : translatedContent.toString());

        		addContextHelpMenupopup(form, baseContent, translatedContent);
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Info))
        	{
        		MInfoWindow info = MInfoWindow.getInfoWindow(recordId);
        		// Load User Def
    			MUserDefInfo userDef = MUserDefInfo.getBestMatch(Env.getCtx(), info.getAD_InfoWindow_ID());

    			if (!Env.isBaseLanguage(Env.getCtx(), I_AD_InfoWindow.Table_Name)) {
					nameMsg = info.get_Translation("Name",false);
	    			if(userDef != null && !Util.isEmpty(userDef.getName())) {
	    				nameMsg = userDef.getName();
	    			} 
					if (nameMsg != null
							&& nameMsg.length() != 0) 
						translatedContent.append("<p><strong>" + nameMsg + "</strong></p>\n");

					descMsg = info.get_Translation("Description",false);
	    			if(userDef != null && !Util.isEmpty(userDef.getDescription())) {
	    				descMsg = userDef.getDescription();
	    			} 
					if (descMsg != null && descMsg.length() != 0)
						translatedContent.append("<p><em>" + descMsg + "</em></p>\n");

					helpMsg = info.get_Translation("Help",false);
	    			if(userDef != null && !Util.isEmpty(userDef.getHelp())) {
	    				helpMsg = userDef.getHelp();
	    			} 
					if (helpMsg != null && helpMsg.length() != 0)
						translatedContent.append("<p>" + helpMsg + "</p>\n");
					
					if (translatedContent.length() > 0)
					{
						appendEntityType(translatedContent, info.getEntityType());
						
						translatedContent.insert(0, "<p>\n");
						translatedContent.append("</p>");
					}
				}
        		
    			String name = info.getName();
    			if(userDef != null && !Util.isEmpty(userDef.getName())) {
    				name = userDef.getName();
    			} 
        		if ( name != null
						&& name.length() != 0)
					baseContent.append("<p><strong>" + name + "</strong></p>\n");

    			String description = info.getDescription();
    			if(userDef != null && !Util.isEmpty(userDef.getDescription())) {
    				description = userDef.getDescription();
    			} 
				if (description != null
						&& description.length() != 0)
					baseContent.append("<p><em>" + description + "</em></p>\n");

    			String help = info.getHelp();
    			if(userDef != null && !Util.isEmpty(userDef.getHelp())) {
    				help = userDef.getHelp();
    			} 
				if (help != null
						&& help.length() != 0)
					baseContent.append("<p>" + help + "</p>\n");
				
				if (baseContent.length() > 0)
				{
					appendEntityType(baseContent, info.getEntityType());
					
					baseContent.insert(0, "<p>\n");
					baseContent.append("</p>");
				}
				
				sb.append(Util.isEmpty(translatedContent.toString()) ? baseContent.toString() : translatedContent.toString());

				addContextHelpMenupopup(info, baseContent, translatedContent);
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Workflow)) 
        	{
        		MWorkflow workflow = MWorkflow.get(Env.getCtx(), recordId);
        		if (!Env.isBaseLanguage(Env.getCtx(), I_AD_Workflow.Table_Name)) {
					nameMsg = workflow.get_Translation("Name", false);
					if (workflow != null && nameMsg != null
							&& nameMsg.length() != 0) 
						translatedContent.append("<p><strong>" + nameMsg + "</strong></p>\n");

					descMsg = workflow.get_Translation("Description",false);
					if (descMsg != null && descMsg.length() != 0)
						translatedContent.append("<p><em>" + descMsg + "</em></p>\n");

					helpMsg = workflow.get_Translation("Help", false);
					if (helpMsg != null && helpMsg.length() != 0)
						translatedContent.append("<p>" + helpMsg + "</p>\n");
					
					if (translatedContent.length() > 0)
					{
						appendEntityType(translatedContent, workflow.getEntityType());
						
						translatedContent.insert(0, "<p>\n");
						translatedContent.append("</p>");
					}
				}
        		
        		if (workflow != null && workflow.getName() != null
						&& workflow.getName().length() != 0)
					baseContent.append("<p><strong>" + workflow.getName() + "</strong></p>\n");

				if (workflow.getDescription() != null
						&& workflow.getDescription().length() != 0)
					baseContent.append("<p><em>" + workflow.getDescription() + "</em></p>\n");

				if (workflow.getHelp() != null
						&& workflow.getHelp().length() != 0)
					baseContent.append("<p>" + workflow.getHelp() + "</p>\n");
				
				if (baseContent.length() > 0)
				{
					appendEntityType(baseContent, workflow.getEntityType());
					
					baseContent.insert(0, "<p>\n");
					baseContent.append("</p>");
				}
				
				sb.append(Util.isEmpty(translatedContent.toString()) ? baseContent.toString() : translatedContent.toString());

				addContextHelpMenupopup(workflow, baseContent, translatedContent);
        	} 
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Task)) 
        	{
				MTask task = new MTask(Env.getCtx(), recordId, null);
	
				if (!Env.getLoginLanguage(Env.getCtx()).isBaseLanguage()) {
	
					nameMsg = task.get_Translation("Name",false);
					if (task != null && nameMsg != null
							&& nameMsg.length() != 0) 
						translatedContent.append("<p><strong>" + nameMsg + "</strong></p>\n");
	
					descMsg = task.get_Translation("Description",false);
					if (descMsg != null && descMsg.length() != 0)
						translatedContent.append("<p><em>" + descMsg + "</em></p>\n");
	
					helpMsg = task.get_Translation("Help",false);
					if (helpMsg != null && helpMsg.length() != 0)
						translatedContent.append("<p>" + helpMsg + "</p>\n");
					
					if (translatedContent.length() > 0)
					{
						appendEntityType(translatedContent, task.getEntityType());
						
						translatedContent.insert(0, "<p>\n");
						translatedContent.append("</p>");
					}					
				} 
	
				if (task != null && task.getName() != null
						&& task.getName().length() != 0)
					baseContent.append("<p><strong>" + task.getName() + "</strong></p>\n");
	
				if (task.getDescription() != null
						&& task.getDescription().length() != 0)
					baseContent.append("<p><em>" + task.getDescription() + "</em></p>\n");
	
				if (task.getHelp() != null
						&& task.getHelp().length() != 0)
					baseContent.append("<p>" + task.getHelp() + "</p>\n");
				
				if (baseContent.length() > 0)
				{
					appendEntityType(baseContent, task.getEntityType());
					
					baseContent.insert(0, "<p>\n");
					baseContent.append("</p>");
				}
				
				sb.append(Util.isEmpty(translatedContent.toString()) ? baseContent.toString() : translatedContent.toString());

				addContextHelpMenupopup(task, baseContent, translatedContent);
			} 
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Node)) 
        	{
				MWFNode node = MWFNode.get(Env.getCtx(), recordId);
	
				if (!Env.isBaseLanguage(Env.getCtx(), I_AD_WF_Node.Table_Name)) {
					nameMsg = node.get_Translation("Name", false);
					if (node != null && nameMsg != null
							&& nameMsg.length() != 0) 
						translatedContent.append("<p><strong>" + nameMsg + "</strong></p>\n");
	
					descMsg = node.get_Translation("Description",false);
					if (descMsg != null && descMsg.length() != 0)
						translatedContent.append("<p><em>" + descMsg + "</em></p>\n");
	
					helpMsg = node.get_Translation("Help", false);
					if (helpMsg != null && helpMsg.length() != 0)
						translatedContent.append("<p>" + helpMsg + "</p>\n");
					
					if (translatedContent.length() > 0)
					{
						appendEntityType(translatedContent, node.getEntityType());
						
						translatedContent.insert(0, "<p>\n");
						translatedContent.append("</p>");
					}
				}
	    		
	    		if (node != null && node.getName() != null
						&& node.getName().length() != 0)
					baseContent.append("<p><strong>" + node.getName() + "</strong></p>\n");
	
				if (node.getDescription() != null
						&& node.getDescription().length() != 0)
					baseContent.append("<p><em>" + node.getDescription() + "</em></p>\n");
	
				if (node.getHelp() != null
						&& node.getHelp().length() != 0)
					baseContent.append("<p>" + node.getHelp() + "</p>\n");
				
				if (baseContent.length() > 0)
				{
					appendEntityType(baseContent, node.getEntityType());
					
					baseContent.insert(0, "<p>\n");
					baseContent.append("</p>");
				}
				
				sb.append(Util.isEmpty(translatedContent.toString()) ? baseContent.toString() : translatedContent.toString());

				addContextHelpMenupopup(node, baseContent, translatedContent);
			}
        	else
        	{
        		translatedContent.append("<p><em>(" + Msg.getMsg(Env.getCtx(), "NotAvailable") + ")</em></p>");
        		baseContent.append("<p><em>(" + Msg.getMsg(Language.getBaseAD_Language(), "NotAvailable") + ")</em></p>");
        		sb.append(translatedContent.toString());

        		addContextHelpMenupopup(null, baseContent, translatedContent);
        	}
    	}
	
    	sb.append("</div>");
    	
    	htmlContextHelp.setContent(sb.toString());
    }

    /**
     * Add context help suggestion popup menu
     * @param po
     * @param baseContent
     * @param translatedContent
     */
    private void addContextHelpMenupopup(PO po, StringBuilder baseContent, StringBuilder translatedContent) {
    	if (!MRole.getDefault().isTableAccessExcluded(MCtxHelpSuggestion.Table_ID)) {
    		ContextHelpMenupopup popup = new ContextHelpMenupopup(po, baseContent.toString(), translatedContent.toString());
    		pnlContextHelp.setAttribute("contextMenu", popup);
    		pnlContextHelp.setContext(popup);
    		popup.setPage(pnlContextHelp.getPage());
    	}
    }
    
    /**
	 * Append Entity Type information on a given string
	 *
	 * @param string
	 * @param entityType
	 */
	private void appendEntityType(StringBuilder string, String entityType) {

		if (!Env.IsShowTechnicalInfOnHelp(Env.getCtx()))
				return;

		if (string == null)
			string = new StringBuilder();

		string.append("<p class=\"help-entitytype\">[ ").append(entityType).append(" ]</p>");
	}

    /**
     * Render quick info (AD_StatusLine)
     * @param obj
     */
    public void renderQuickInfo(Object obj) {
    	if (obj == null) {
        	pnlQuickInfo.setVisible(false);
    	} else {
    		String widget = "";
    		if(obj instanceof GridTab) {
    			widget = ((GridTab)obj).getStatusLinesWidget();
    		}
    		else if(obj instanceof InfoPanel) {
    			widget = ((InfoPanel)obj).getStatusLinesWidget();
    		}
    		else {
    			pnlQuickInfo.setVisible(false);
    			return;
    		}
    		
    		if (widget == null) {
            	pnlQuickInfo.setVisible(false);
    		} else {
            	pnlQuickInfo.setVisible(true);
            	StringBuilder sb = new StringBuilder();
            	sb.append("<html>\n<body>\n<div class=\"help-content\">\n");
       			sb.append(widget);
            	sb.append("</div>\n</body>\n</html>");
            	htmlQuickInfo.setContent(sb.toString());
    		}
    	}
	}

    /**
     * @param htmlString
     * @param all
     * @return text after strip of html tag
     */
    private String stripHtml(String htmlString, boolean all) 
    {
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

    /**
     * @param ctxType
     * @param recordId
     * @return MCtxHelpMsg
     */
    private MCtxHelpMsg getCtxHelpMsg(String ctxType, int recordId)
    {
    	MCtxHelpMsg retValue = MCtxHelpMsg.get(ctxType, recordId);
    	return retValue;
    }

    /**
	 * @param content content
	 * @return masked content or empty string if <code>content</code> is null
	 */
	public static String escapeJavascriptContent(String content)
	{
		// If the content is null, then return ''
		if (content == null)
			return "function(){return '';}";
		//
		StringBuilder out = new StringBuilder("function(){return '");
		char[] chars = content.toCharArray();
		for (int i = 0; i < chars.length; i++)
		{
			char c = chars[i];
			switch (c)
			{
				case '\r':
					out.append ("");
					break;
				case '\'':
					out.append ("\\'");
					break;
				case '\n':
					out.append ("<br>");
					break;
				//
				default:
					out.append(c);
					break;
			}
		}
		out.append("';}");
		return out.toString();
	}	//	maskHTML
	
	private class ContextHelpMenupopup extends Menupopup implements EventListener<Event> {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = 5430991475805225567L;

		private MCtxHelpMsg ctxHelpMsg;
		private PO po;
		private String baseContent, translatedContent;
		
		private ContextHelpMenupopup(MCtxHelpMsg ctxHelpMsg) {
			super();
			this.ctxHelpMsg = ctxHelpMsg;
			init();
		}

		private ContextHelpMenupopup(PO po, String baseContent, String translatedContent) {
			this.po = po;
			this.baseContent = baseContent;
			this.translatedContent = translatedContent;
			init();
		}
		
		private void init() {
			Menuitem item = new Menuitem();
			if (ctxHelpMsg != null && ctxHelpMsg.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
				item.setLabel(Msg.getMsg(Env.getCtx(), "edit"));
			} else {
				item.setLabel(Msg.getElement(Env.getCtx(), "AD_CtxHelpSuggestion_ID"));
			}
			appendChild(item);
			item.addEventListener(Events.ON_CLICK, this);
		}
		
		@Override
		public void onEvent(Event event) throws Exception {
			WCtxHelpSuggestion suggestion = null;
			if (ctxHelpMsg != null)
				suggestion = new WCtxHelpSuggestion(ctxHelpMsg);
			else
				suggestion = new WCtxHelpSuggestion(po, baseContent, translatedContent);
			suggestion.setPage(this.getPage());
			suggestion.doHighlighted();
		}
	}
}
