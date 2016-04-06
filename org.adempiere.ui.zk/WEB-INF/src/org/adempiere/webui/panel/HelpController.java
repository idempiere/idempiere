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

import java.util.Properties;

import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MCtxHelpMsg;
import org.compiere.model.MForm;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MProcess;
import org.compiere.model.MTab;
import org.compiere.model.MTask;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWorkflow;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Anchorchildren;
import org.zkoss.zul.Anchorlayout;
import org.zkoss.zul.Html;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Style;
import org.zkoss.zul.Vlayout;

/**
 * 
 * @author Elaine
 *
 */
public class HelpController
{	
	private Anchorlayout dashboardLayout;
	private Panel pnlToolTip, pnlContextHelp, pnlQuickInfo;
	private Html htmlToolTip, htmlContextHelp, htmlQuickInfo;
	
	public HelpController()
    {
		dashboardLayout = new Anchorlayout();
        dashboardLayout.setSclass("dashboard-layout");
        ZKUpdateUtil.setVflex(dashboardLayout, "1");
        ZKUpdateUtil.setHflex(dashboardLayout, "1");
    }

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
        htmlToolTip.setWidgetOverride("onFieldTooltip", "function(origin,opts,header,description,help)" +
        		"{var s='<html><body><div class=\"help-content\">';" +
        		"if (typeof header == 'undefined') {s=s+'<i>'+this.defaultMessage+'</i>';} " +
        		"else {s=s+'<b>'+header+'</b>';" +
        		"if (typeof description=='string' && description.length > 0) {s=s+'<br><br><i>'+description+'</i>';}" +
        		"if (typeof help=='string' && help.length > 0) {s=s+'<br><br>'+help;}}" +
        		"s=s+'</div></body></html>';this.setContent(s);}");
        Clients.response(new AuScript(htmlToolTip, "var w=zk.Widget.$('#"+htmlToolTip.getUuid()+"');zWatch.listen({onFieldTooltip: w});"));
        
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
	 * Make tooltip content for a field 
	 * @param field
	 */
    public void renderToolTip(GridField field)
    {    	
    	String hdr = null;
    	String desc = null;
    	String help = null;
    	String otherContent = null;
    	
    	if (field != null)
    	{
    		hdr = field.getHeader();
			if (hdr != null && hdr.length() > 0)
			{	
				if (field.getDescription().length() != 0)
					desc = field.getDescription();
				
				if (field.getHelp().length() != 0)
					help = field.getHelp();
			}
    	}
    	else
    	{
    		otherContent = Msg.getMsg(Env.getCtx(), "PlaceCursorIntoField");
    	}
    	
    	renderToolTip(hdr, desc, help, otherContent);
    }
    
    /**
     * Make tooltip content, when  hdr == null, show otherContent
     * @param hdr
     * @param desc
     * @param help
     * @param otherContent
     */
    public void renderToolTip(String hdr, String  desc, String help, String otherContent)
    {
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
    		
    	}    	
    	
    	sb.append("</div>\n</body>\n</html>");
    	htmlToolTip.setContent(sb.toString());
    }
    
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
    	sb.append("<html>\n<body>\n<div class=\"help-content\">\n");
    	    	
    	String ctxHelpMsg = getCtxHelpMsgList(ctxType, recordId);
    	String helpMsg, nameMsg, descMsg;
    	
    	if (ctxHelpMsg.length() > 0)
	    	sb.append(stripHtml(ctxHelpMsg, false) + "<br>\n");
    	else
    	{
        	sb.append("<i>(" + Msg.getMsg(Env.getCtx(), "NotAvailable") + ")</i>");

    		if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Tab))
        	{
        		MTab tab = new MTab(Env.getCtx(), recordId, null);
        		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Tab")) {

					nameMsg = tab.get_Translation("Name");
					if (tab != null && nameMsg != null && nameMsg.length() != 0)
						sb.append("<br><br>\n<b>" + nameMsg + "</b>");

					descMsg = tab.get_Translation("Description");
					if (descMsg != null && descMsg.length() != 0)
						sb.append("<br><br>\n<i>" + descMsg + "</i>");

					helpMsg = tab.get_Translation("Help");
					if (helpMsg != null && helpMsg.length() != 0)
						sb.append("<br><br>\n" + helpMsg);

				}

				else {
					if (tab != null && tab.getName() != null
							&& tab.getName().length() != 0) {
						sb.append("<br><br>\n<b>" + tab.getName() + "</b>");

						if (tab.getDescription() != null
								&& tab.getDescription().length() != 0)
							sb.append("<br><br>\n<i>" + tab.getDescription()
									+ "</i>");

						if (tab.getHelp() != null
								&& tab.getHelp().length() != 0)
							sb.append("<br><br>\n" + tab.getHelp());
					}
				}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Process))
        	{
        		MProcess process = MProcess.get(Env.getCtx(), recordId);
        		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Process")) {

					nameMsg = process.get_Translation("Name");
					if (process != null && nameMsg != null
							&& nameMsg.length() != 0)
						sb.append("<br><br>\n<b>" + nameMsg + "</b>");

					descMsg = process.get_Translation("Description");
					if (descMsg != null && descMsg.length() != 0)
						sb.append("<br><br>\n<i>" + descMsg + "</i>");

					helpMsg = process.get_Translation("Help");
					if (helpMsg != null && helpMsg.length() != 0)
						sb.append("<br><br>\n" + helpMsg);

				} else {

					if (process != null && process.getName() != null
							&& process.getName().length() != 0)
						sb.append("<br><br>\n<b>" + process.getName() + "</b>");

					if (process.getDescription() != null
							&& process.getDescription().length() != 0)
						sb.append("<br><br>\n<i>" + process.getDescription()
								+ "</i>");

					if (process.getHelp() != null
							&& process.getHelp().length() != 0)
						sb.append("<br><br>\n" + process.getHelp());

				}

        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Form))
        	{
        		MForm form = new MForm(Env.getCtx(), recordId, null);
        		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Form")) {

					nameMsg = form.get_Translation("Name");

					if (form != null && nameMsg != null
							&& nameMsg.length() != 0)
						sb.append("<br><br>\n<b>" + nameMsg + "</b>");

					descMsg = form.get_Translation("Description");
					if (descMsg != null && descMsg.length() != 0)
						sb.append("<br><br>\n<i>" + descMsg + "</i>");

					helpMsg = form.get_Translation("Help");
					if (helpMsg != null && helpMsg.length() != 0)
						sb.append("<br><br>\n" + helpMsg);

				} else {

					if (form != null && form.getName() != null
							&& form.getName().length() != 0) {
						sb.append("<br><br>\n<b>" + form.getName() + "</b>");

						if (form.getDescription() != null
								&& form.getDescription().length() != 0)
							sb.append("<br><br>\n<i>" + form.getDescription()
									+ "</i>");

						if (form.getHelp() != null
								&& form.getHelp().length() != 0)
							sb.append("<br><br>\n" + form.getHelp());
					}

				}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Info))
        	{
        		MInfoWindow info = new MInfoWindow(Env.getCtx(), recordId, null);
        		if (!Env.getLoginLanguage(Env.getCtx()).isBaseLanguage()) {

					nameMsg = info.get_Translation("Name");
					if (info != null && nameMsg != null
							&& nameMsg.length() != 0) {
						sb.append("<br><br>\n<b>" + nameMsg + "</b>");

						descMsg = info.get_Translation("Description");
						if (descMsg != null && descMsg.length() != 0)
							sb.append("<br><br>\n<i>" + descMsg + "</i>");

						helpMsg = info.get_Translation("Help");
						if (helpMsg != null && helpMsg.length() != 0)
							sb.append("<br><br>\n" + helpMsg);

					} else {
						if (info != null && info.getName() != null
								&& info.getName().length() != 0)
							sb.append("<br><br>\n<b>" + info.getName() + "</b>");

						if (info.getDescription() != null
								&& info.getDescription().length() != 0)
							sb.append("<br><br>\n<i>" + info.getDescription()
									+ "</i>");

						if (info.getHelp() != null
								&& info.getHelp().length() != 0)
							sb.append("<br><br>\n" + info.getHelp());

					}
				}
        	}
    	 else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Workflow)) {
    		 MWorkflow workflow = MWorkflow.get(Env.getCtx(), recordId);

    		 boolean trl = !Env.getLoginLanguage(Env.getCtx()).isBaseLanguage();

    		 nameMsg = workflow.getName(trl);

    		 if (workflow != null && nameMsg != null
    				 && nameMsg.length() != 0) {
    			 sb.append("<br><br>\n<b>" + nameMsg + "</b>");

    			 descMsg = workflow.getDescription(trl);
    			 if (descMsg != null && descMsg.length() != 0)
    				 sb.append("<br><br>\n<i>" + descMsg + "</i>");

    			 helpMsg = workflow.getHelp(trl);
    			 if (helpMsg != null && helpMsg.length() != 0)
    				 sb.append("<br><br>\n" + helpMsg);
    		 }

		} else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Task)) {
			MTask task = new MTask(Env.getCtx(), recordId, null);

			if (!Env.getLoginLanguage(Env.getCtx()).isBaseLanguage()) {

				nameMsg = task.get_Translation("Name");

				if (task != null && nameMsg != null
						&& nameMsg.length() != 0) {
					sb.append("<br><br>\n<b>" + nameMsg + "</b>");

					descMsg = task.get_Translation("Description");
					if (descMsg != null && descMsg.length() != 0)
						sb.append("<br><br>\n<i>" + descMsg + "</i>");

					helpMsg = task.get_Translation("Help");
					if (helpMsg != null && helpMsg.length() != 0)
						sb.append("<br><br>\n" + helpMsg);
				}
			} else {

				if (task != null && task.getName() != null
						&& task.getName().length() != 0) {
					sb.append("<br><br>\n<b>" + task.getName() + "</b>");

					if (task.getDescription() != null
							&& task.getDescription().length() != 0)
						sb.append("<br><br>\n<i>" + task.getDescription()
								+ "</i>");

					if (task.getHelp() != null
							&& task.getHelp().length() != 0)
						sb.append("<br><br>\n" + task.getHelp());
				}
			}
		} else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Node)) {
			MWFNode node = MWFNode.get(Env.getCtx(), recordId);

			boolean trl = !Env.getLoginLanguage(Env.getCtx()).isBaseLanguage();

			nameMsg = node.getName(trl);

			if (node != null && nameMsg != null
					&& nameMsg.length() != 0) {
				sb.append("<br><br>\n<b>" + nameMsg + "</b>");

				descMsg = node.getDescription(trl);
				if (descMsg != null && descMsg.length() != 0)
					sb.append("<br><br>\n<i>" + descMsg + "</i>");

				helpMsg = node.getHelp(trl);
				if (helpMsg != null && helpMsg.length() != 0)
					sb.append("<br><br>\n" + helpMsg);
			}

		  }
    	}
	
    	sb.append("</div>\n</body>\n</html>");
    	
    	htmlContextHelp.setContent(sb.toString());
    }
    
    public void renderQuickInfo(GridTab gridTab) {
    	if (gridTab == null) {
        	pnlQuickInfo.setVisible(false);
    	} else {
    		String widget = gridTab.getStatusLinesWidget();
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

    private String getCtxHelpMsgList(String ctxType, int recordId)
    {
    	Properties ctx = Env.getCtx();
    	String retValue = MCtxHelpMsg.get(ctx, ctxType, recordId);
    	return retValue;
    }

    /**
	 * @param content content
	 * @return masked content or empty string if the <code>content</code> is null
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
}
