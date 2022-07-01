/******************************************************************************
. * Product: Posterita Ajax UI 												  *
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

package org.adempiere.webui.adwindow;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.form.WQuickForm;
import org.adempiere.webui.component.DocumentLink;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WTextEditorDialog;
import org.compiere.model.MSysConfig;
import org.compiere.process.ProcessInfoLog;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Notification;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Html;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;

/**
 * This class is based on org.compiere.apps.StatusBar written by Jorg Janke.
 * @author Jorg Janke
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 12, 2007
 * @version $Revision: 0.10 $
 */
public class StatusBar extends Panel implements EventListener<Event> 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7091641684809092888L;

	private Panel infoPanel;

	private Html infoLine;

	private Div west;
	
	private Div east;

	private ProcessInfoLog[] pInfoLogs;

	private String m_statusText;

	private boolean m_statusError;

	private Window msgPopup;

	private Div msgPopupCnt;

	private Hlayout messageContainer;

	private Caption msgPopupCaption;
	
	public StatusBar()
	{
        super();
        init();
        
        createPopup();
    }

    private void init()
    {        
    	infoPanel = new Panel();
    	infoLine = new Html();
    	infoPanel.appendChild(infoLine);
    	
        east = new Div();
        east.setSclass("adwindow-status-docinfo");
        east.appendChild(infoLine);
        
        west = new Div();
        west.setSclass("adwindow-status-docstatus");
        
        messageContainer = new Hlayout();
        messageContainer.setId("messages");
        west.appendChild(messageContainer);
        
        appendChild(west);
        appendChild(east);
        
        if (ClientInfo.isMobile())
        	ClientInfo.onClientInfo(this, this::onClientInfo);
    }

    /**
	 *	Set Info Line
	 *  @param text text
	 */
	public void setInfo (String text)
	{
    	StringBuilder inflcnt = new StringBuilder();
    	inflcnt.append("<html>\n<body>\n<div class=\"help-content\">\n");
    	inflcnt.append(text != null ? text : "");
    	inflcnt.append("</div>\n</body>\n</html>");
    	infoLine.setContent(inflcnt.toString());

	}	//	setInfo

	/**
     * @param text
     */
    public void setStatusLine (String text)
    {
        setStatusLine(text, false,null);
    }

    /**
     * @param text
     * @param error
     */
    public void setStatusLine (String text, boolean error)
    {
    	setStatusLine(text, error, null);
    }
    
    /**
     * @param text
     * @param error
     * @param m_logs
     */
    public void setStatusLine (String text, boolean error, ProcessInfoLog[] m_logs)
    {
    	pInfoLogs = m_logs;
    	Div div = null;
    	
       	Execution execution = Executions.getCurrent();
    	if (execution != null) {
    		String key = this.getClass().getName()+"."+getUuid();
    		Object o = execution.getAttribute(key);
    		if (o != null) {
    			if (text == null || text.trim().length() == 0)
    				return;
    		} else {
    			execution.setAttribute(key, Boolean.TRUE);
    		}
    	}
    	
    	m_statusText = text;
    	m_statusError = error;
    	
		messageContainer.getChildren().clear();
		
		if (text == null || text.trim().length() == 0 )
			return;
		
    	String labelText = buildLabelText(m_statusText);
    	int duration = MSysConfig.getIntValue(MSysConfig.ZK_ERROR_MSG_LIFETIME_MILLISECONDS, 3500, Env.getAD_Client_ID(Env.getCtx()));
    	if (error) {
    		Notification.show(buildNotificationText(m_statusText), "error", findTabpanel(this), "top_left", duration, true);
    	} else if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH)) {
    		Notification.show(buildNotificationText(m_statusText), "info", findTabpanel(this), "top_left", 2000, true);
    	}
    	
    	messageContainer.setSclass(error ? "docstatus-error" : "docstatus-normal");
    	if (!ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH))
    	{
	    	Label label = new Label(labelText);	    	
	    	messageContainer.appendChild(label);	
			if (labelText.length() != m_statusText.length() || (div != null && div.getChildren().size() > 0)) {
				label.addEventListener(Events.ON_CLICK, this);
				label.setStyle("cursor: pointer");
			
				label = new Label(" ...");
				label.setStyle("cursor: pointer");
				messageContainer.appendChild(label);
				label.addEventListener(Events.ON_CLICK, this);
			}	    	
	    	messageContainer.appendChild(new Space());	  
    	}
    	else
    	{
    		Label label = new Label("...");
			label.setSclass("mobile-overflow-link");
			messageContainer.appendChild(label);
			label.addEventListener(Events.ON_CLICK, this);
    	}
    	
    	if (m_logs != null) {
			div = new Div();
			for (int i = 0; i < m_logs.length; i++) {
				if (m_logs[i].getP_Msg() != null) {
					if (m_logs[i].getAD_Table_ID() > 0
							&& m_logs[i].getRecord_ID() > 0) {
						DocumentLink recordLink = new DocumentLink(m_logs[i].getP_Msg(), m_logs[i].getAD_Table_ID(), m_logs[i].getRecord_ID());												
						if (!div.getChildren().isEmpty())
							div.appendChild(new Separator("horizontal"));
						div.appendChild(recordLink);						
					}
				}
			}
		}
    	
    	createPopupContent();
    	if(div!=null)
    	{
    		msgPopupCnt.appendChild(div);
    	}
    }

    private String buildLabelText(String statusText) {
		if (statusText == null)
			return "";
		if (statusText.length() <= 80)
			return statusText;
		
		int index = statusText.indexOf(" - java.lang.Exception");
		if (index > 0)
			return statusText.substring(0, index);
		return statusText.substring(0, 80);
	}
    
	protected void createPopupContent() {
		Html t = new Html(WTextEditorDialog.sanitize(m_statusText));
		msgPopupCnt.getChildren().clear();
		msgPopupCnt.appendChild(t);
	}
	
	private String buildNotificationText(String statusText) {
		if (statusText == null)
			return "";
		if (statusText.length() <= 140)
			return statusText;
		
		int index = statusText.indexOf(" - java.lang.Exception");
		if (index > 0)
			return statusText.substring(0, index);
		return statusText.substring(0, 136) + " ...";
	}
	
	private Component findTabpanel(Component comp) {
		Component parent = comp.getParent();
		while (parent != null) {
			if (parent instanceof Tabpanel)
				return parent;
			else if (parent instanceof WQuickForm)
				return parent;

			parent = parent.getParent();
		}
		return null;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() instanceof Label) {
 			showPopup();
 		}
	}
	
	private void showPopup() {
		appendChild(msgPopup);
		LayoutUtils.openOverlappedWindow(messageContainer, msgPopup, "overlap_end");
	}
	
	/**
	 * 
	 * @return process logs
	 */
	public ProcessInfoLog[] getPLogs() {
		return pInfoLogs;
	}

	/**
    *
    * @return current status line text
    */
    public String getStatusLine() {
  		return m_statusText;
  	}
   
    public boolean getStatusError() {
    	return m_statusError;
    }

    private void createPopup() {
		msgPopupCnt = new Div();
		ZKUpdateUtil.setVflex(msgPopupCnt, "1");
		msgPopupCnt.setStyle("flex-basis: auto");

		
		msgPopup = new Window();
		msgPopup.setBorder(true);
		msgPopup.setClosable(true);
		msgPopup.setSizable(true);
		msgPopup.setContentStyle("overflow: auto");
		ZKUpdateUtil.setWindowWidthX(msgPopup, 500);
        msgPopup.appendChild(msgPopupCnt);
        msgPopup.setShadow(true);
        msgPopupCaption = new Caption();
        msgPopup.appendChild(msgPopupCaption);        
	}

    protected void onClientInfo() {
    	ZKUpdateUtil.setWindowWidthX(msgPopup, 500);
    }
}
