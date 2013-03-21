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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.desktop.IDesktop;
import org.compiere.model.GridField;
import org.compiere.model.MForm;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MProcess;
import org.compiere.model.MTab;
import org.compiere.model.MTask;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.model.X_AD_CtxHelpMsg;
import org.compiere.model.X_AD_Form;
import org.compiere.model.X_AD_InfoWindow;
import org.compiere.model.X_AD_Process;
import org.compiere.model.X_AD_Tab;
import org.compiere.model.X_AD_Task;
import org.compiere.model.X_AD_WF_Node;
import org.compiere.model.X_AD_Workflow;
import org.compiere.util.DB;
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
	private Panel pnlToolTip, pnlContextHelp;
	private Html htmlToolTip, htmlContextHelp;
	
	public HelpController()
    {
		dashboardLayout = new Anchorlayout();
        dashboardLayout.setSclass("dashboard-layout slimScroll");
        dashboardLayout.setVflex("1");
        dashboardLayout.setHflex("1");
    }

	public void render(Component parent, IDesktop desktopImpl)
    {
    	Style style = new Style();
		style.setContent(".z-anchorlayout-body { overflow:auto } .z-anchorchildren { overflow:visible } ");
		style.setPage(parent.getPage());
		
		parent.appendChild(dashboardLayout);
        
        Vlayout dashboardColumnLayout = new Vlayout();
        dashboardColumnLayout.setHflex("1");

        Anchorchildren dashboardColumn = new Anchorchildren();
		dashboardColumn.setAnchor("95% 100%");
		dashboardColumn.appendChild(dashboardColumnLayout);
        dashboardLayout.appendChild(dashboardColumn);
        
        pnlToolTip = new Panel();
        pnlToolTip.setSclass("dashboard-widget");
        pnlToolTip.setTitle(Msg.getMsg(Env.getCtx(), "ToolTip"));
    	pnlToolTip.setMaximizable(false);
    	pnlToolTip.setCollapsible(true);
    	pnlToolTip.setOpen(true);
    	pnlToolTip.setBorder("normal");
    	dashboardColumnLayout.appendChild(pnlToolTip);
    	Panelchildren content = new Panelchildren();
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
    }
    
    public void renderToolTip(GridField field)
    {
    	StringBuilder sb = new StringBuilder();
    	sb.append("<html>\n<body>\n<div class=\"help-content\">\n");
    	
    	if (field != null)
    	{
    		String hdr = field.getHeader();
			if (hdr != null && hdr.length() > 0)
			{
				sb.append("<b>" + hdr + "</b>");
				
				if (field.getDescription().length() != 0)
					sb.append("<br><br>\n<i>" + field.getDescription() + "</i>");
				
				if (field.getHelp().length() != 0)
					sb.append("<br><br>\n" + field.getHelp());
			}
    	}
    	else
    	{
    		sb.append("<i>(" + Msg.getMsg(Env.getCtx(), "PlaceCursorIntoField") + ")</i>");
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
    	if (ctxHelpMsg.length() > 0)
	    	sb.append(stripHtml(ctxHelpMsg, false) + "<br>\n");
    	else
    	{
        	sb.append("<i>(" + Msg.getMsg(Env.getCtx(), "NotAvailable") + ")</i>");

    		if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Tab))
        	{
        		MTab tab = new MTab(Env.getCtx(), recordId, null);
    			if (tab != null && tab.getName() != null && tab.getName().length() != 0)
    			{
    				sb.append("<br><br>\n<b>" + tab.getName() + "</b>");
    				
    				if (tab.getDescription() != null && tab.getDescription().length() != 0)
    					sb.append("<br><br>\n<i>" + tab.getDescription() + "</i>");
    				
    				if (tab.getHelp() != null && tab.getHelp().length() != 0)
    					sb.append("<br><br>\n" + tab.getHelp());
    			}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Process))
        	{
        		MProcess process = new MProcess(Env.getCtx(), recordId, null);
    			if (process != null && process.getName() != null && process.getName().length() != 0)
    			{
    				sb.append("<br><br>\n<b>" + process.getName() + "</b>");
    				
    				if (process.getDescription() != null && process.getDescription().length() != 0)
    					sb.append("<br><br>\n<i>" + process.getDescription() + "</i>");
    				
    				if (process.getHelp() != null && process.getHelp().length() != 0)
    					sb.append("<br><br>\n" + process.getHelp());
    			}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Form))
        	{
        		MForm form = new MForm(Env.getCtx(), recordId, null);
    			if (form != null && form.getName() != null && form.getName().length() != 0)
    			{
    				sb.append("<br><br>\n<b>" + form.getName() + "</b>");
    				
    				if (form.getDescription() != null && form.getDescription().length() != 0)
    					sb.append("<br><br>\n<i>" + form.getDescription() + "</i>");
    				
    				if (form.getHelp() != null && form.getHelp().length() != 0)
    					sb.append("<br><br>\n" + form.getHelp());
    			}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Info))
        	{
        		MInfoWindow info = new MInfoWindow(Env.getCtx(), recordId, null);
    			if (info != null && info.getName() != null && info.getName().length() != 0)
    			{
    				sb.append("<br><br>\n<b>" + info.getName() + "</b>");
    				
    				if (info.getDescription() != null && info.getDescription().length() != 0)
    					sb.append("<br><br>\n<i>" + info.getDescription() + "</i>");
    				
    				if (info.getHelp() != null && info.getHelp().length() != 0)
    					sb.append("<br><br>\n" + info.getHelp());
    			}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Workflow))
        	{
        		MWorkflow workflow = new MWorkflow(Env.getCtx(), recordId, null);
    			if (workflow != null && workflow.getName() != null && workflow.getName().length() != 0)
    			{
    				sb.append("<br><br>\n<b>" + workflow.getName() + "</b>");
    				
    				if (workflow.getDescription() != null && workflow.getDescription().length() != 0)
    					sb.append("<br><br>\n<i>" + workflow.getDescription() + "</i>");
    				
    				if (workflow.getHelp() != null && workflow.getHelp().length() != 0)
    					sb.append("<br><br>\n" + workflow.getHelp());
    			}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Task))
        	{
        		MTask task = new MTask(Env.getCtx(), recordId, null);
    			if (task != null && task.getName() != null && task.getName().length() != 0)
    			{
    				sb.append("<br><br>\n<b>" + task.getName() + "</b>");
    				
    				if (task.getDescription() != null && task.getDescription().length() != 0)
    					sb.append("<br><br>\n<i>" + task.getDescription() + "</i>");
    				
    				if (task.getHelp() != null && task.getHelp().length() != 0)
    					sb.append("<br><br>\n" + task.getHelp());
    			}
        	}
        	else if (ctxType.equals(X_AD_CtxHelp.CTXTYPE_Node))
        	{
        		MWFNode node = new MWFNode(Env.getCtx(), recordId, null);
    			if (node != null && node.getName() != null && node.getName().length() != 0)
    			{
    				sb.append("<br><br>\n<b>" + node.getName() + "</b>");
    				
    				if (node.getDescription() != null && node.getDescription().length() != 0)
    					sb.append("<br><br>\n<i>" + node.getDescription() + "</i>");
    				
    				if (node.getHelp() != null && node.getHelp().length() != 0)
    					sb.append("<br><br>\n" + node.getHelp());
    			}
        	}
    	}

    	sb.append("</div>\n</body>\n</html>");
    	
    	htmlContextHelp.setContent(sb.toString());
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
    
    private int getCtxHelpID(String ctxType, int recordId)
    {
    	Properties ctx = Env.getCtx();
    	
    	StringBuilder sql = new StringBuilder();
    	sql.append("SELECT t.");
    	if (ctxType == X_AD_CtxHelp.CTXTYPE_Tab)
    		sql.append(X_AD_Tab.COLUMNNAME_AD_CtxHelp_ID);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Process)
    		sql.append(X_AD_Process.COLUMNNAME_AD_CtxHelp_ID);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Form)
    		sql.append(X_AD_Form.COLUMNNAME_AD_CtxHelp_ID);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Info)
    		sql.append(X_AD_InfoWindow.COLUMNNAME_AD_CtxHelp_ID);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Workflow)
    		sql.append(X_AD_Workflow.COLUMNNAME_AD_CtxHelp_ID);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Task)
    		sql.append(X_AD_Task.COLUMNNAME_AD_CtxHelp_ID);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Node)
    		sql.append(X_AD_WF_Node.COLUMNNAME_AD_CtxHelp_ID);
    	else
    		sql.append(X_AD_CtxHelp.COLUMNNAME_AD_CtxHelp_ID);
    	
    	sql.append(" FROM ");
    	if (ctxType == X_AD_CtxHelp.CTXTYPE_Tab)
    		sql.append(X_AD_Tab.Table_Name);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Process)
    		sql.append(X_AD_Process.Table_Name);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Form)
    		sql.append(X_AD_Form.Table_Name);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Info)
    		sql.append(X_AD_InfoWindow.Table_Name);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Workflow)
    		sql.append(X_AD_Workflow.Table_Name);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Task)
    		sql.append(X_AD_Task.Table_Name);
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Node)
    		sql.append(X_AD_WF_Node.Table_Name);
    	else
    		sql.append(X_AD_CtxHelp.Table_Name);
    	sql.append(" t, AD_CtxHelp h ");
    	
    	sql.append("WHERE t.AD_CtxHelp_ID = h.AD_CtxHelp_ID ");
    	sql.append("AND t.IsActive = 'Y' ");
    	sql.append("AND h.IsActive = 'Y' ");
    	sql.append("AND h.AD_Client_ID IN (0, ?) ");
    	sql.append("AND h.AD_Org_ID IN (0, ?) ");
    	
    	if (ctxType == X_AD_CtxHelp.CTXTYPE_Home)
    		sql.append("AND h." + X_AD_CtxHelp.COLUMNNAME_CtxType);    		
    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Tab || ctxType == X_AD_CtxHelp.CTXTYPE_Process ||
    			ctxType == X_AD_CtxHelp.CTXTYPE_Form || ctxType == X_AD_CtxHelp.CTXTYPE_Info ||
    			ctxType == X_AD_CtxHelp.CTXTYPE_Workflow || ctxType == X_AD_CtxHelp.CTXTYPE_Task ||
    			ctxType == X_AD_CtxHelp.CTXTYPE_Node)
    	{
	    	sql.append("AND t.");
	    	if (ctxType == X_AD_CtxHelp.CTXTYPE_Tab)
	    		sql.append(X_AD_Tab.COLUMNNAME_AD_Tab_ID);
	    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Process)
	    		sql.append(X_AD_Process.COLUMNNAME_AD_Process_ID);
	    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Form)
	    		sql.append(X_AD_Form.COLUMNNAME_AD_Form_ID);
	    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Info)
	    		sql.append(X_AD_InfoWindow.COLUMNNAME_AD_InfoWindow_ID);
	    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Workflow)
	    		sql.append(X_AD_Workflow.COLUMNNAME_AD_Workflow_ID);
	    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Task)
	    		sql.append(X_AD_Task.COLUMNNAME_AD_Task_ID);
	    	else if (ctxType == X_AD_CtxHelp.CTXTYPE_Node)
	    		sql.append(X_AD_WF_Node.COLUMNNAME_AD_WF_Node_ID);
    	}
    	else
    		sql.append("1");
    	sql.append(" = ? ");
    	sql.append("ORDER BY h.AD_Client_ID DESC, h.AD_Org_ID DESC, h.AD_CtxHelp_ID DESC");    	
    	return DB.getSQLValue(null, sql.toString(), Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), ctxType == X_AD_CtxHelp.CTXTYPE_Home ? ctxType : recordId);
    }
    
    private String getCtxHelpMsgList(String ctxType, int recordId)
	{
    	Properties ctx = Env.getCtx();
    	
    	int AD_CtxHelp_ID = getCtxHelpID(ctxType, recordId);
    	if (AD_CtxHelp_ID > 0)
    	{
    		StringBuilder sql = new StringBuilder();
        	if (Env.isBaseLanguage(Env.getCtx(), X_AD_CtxHelpMsg.Table_Name))
        	{
        		sql.append("SELECT MsgText ");    		
            	sql.append("FROM AD_CtxHelpMsg ");
            	sql.append("WHERE IsActive = 'Y' ");
            	sql.append("AND AD_Client_ID IN (0, ?) ");
            	sql.append("AND AD_Org_ID IN (0, ?) ");
            	sql.append("AND AD_CtxHelp_ID = ? ");
            	sql.append("ORDER BY AD_Client_ID DESC, AD_Org_ID DESC, AD_CtxHelpMsg_ID DESC");
        	}
        	else
        	{
        		sql.append("SELECT mt.MsgText ");    		
            	sql.append("FROM AD_CtxHelpMsg m ");
            	sql.append("LEFT JOIN AD_CtxHelpMsg_Trl mt ON (mt.AD_CtxHelpMsg_ID = m.AD_CtxHelpMsg_ID AND mt.AD_Language = ?) ");
            	sql.append("WHERE mt.IsActive = 'Y' ");
            	sql.append("AND m.AD_Client_ID IN (0, ?) ");
            	sql.append("AND m.AD_Org_ID IN (0, ?) ");
            	sql.append("AND m.AD_CtxHelp_ID = ? ");
            	sql.append("ORDER BY m.AD_Client_ID DESC, m.AD_Org_ID DESC, m.AD_CtxHelpMsg_ID DESC");
        	}
        	
        	PreparedStatement pstmt = null;
        	ResultSet rs = null;
        	
        	try
    		{
    			pstmt = DB.prepareStatement(sql.toString(), null);
    			int count = 1;
            	if (!Env.isBaseLanguage(Env.getCtx(), X_AD_CtxHelpMsg.Table_Name))
            		pstmt.setString(count++, Env.getAD_Language(Env.getCtx()));
            	pstmt.setInt(count++, Env.getAD_Client_ID(ctx));
            	pstmt.setInt(count++, Env.getAD_Org_ID(ctx));
    			pstmt.setInt(count++, AD_CtxHelp_ID);
    			rs = pstmt.executeQuery();
    			if (rs.next())
    				return rs.getString(X_AD_CtxHelpMsg.COLUMNNAME_MsgText);
    		}
    		catch (Exception e)
    		{
    			throw new AdempiereException(e);
    		} 
        	finally 
        	{
    			DB.close(rs, pstmt);
    		}
    	}
    	
    	return "";
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
