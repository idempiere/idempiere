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

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Window;
import org.compiere.process.ProcessInfoLog;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
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
	private static final long serialVersionUID = -3262889055635240201L;

    private Label infoLine;

	private Div west;
	
	private Div east;

	private ProcessInfoLog[] pInfoLogs;

	private String m_statusText;

	private boolean m_statusError;

	private Window msgPopup;

	private Div msgPopupCnt;

	private Hbox messageContainer;

	private Caption msgPopupCaption;
	
	public StatusBar()
	{
        super();
        init();
        
        createPopup();
    }

    private void init()
    {        
        infoLine = new Label();
        
        east = new Div();
        east.setSclass("adwindow-status-docinfo");
        east.appendChild(infoLine);
        
        west = new Div();
        west.setSclass("adwindow-status-docstatus");
        
        messageContainer = new Hbox();
        messageContainer.setAlign("center");
        messageContainer.setId("messages");
        west.appendChild(messageContainer);
        
        appendChild(west);
        appendChild(east);
    }

    /**
	 *	Set Info Line
	 *  @param text text
	 */
	public void setInfo (String text)
	{
		infoLine.setValue(text != null ? text : "");
		infoLine.setTooltiptext(text);
		infoLine.setStyle("font-weight: bold;");
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
		
		/*
		Image image = null;
    	if (error)
    		image = new Image(ThemeManager.getThemeResource(ERROR_INDICATOR_IMAGE));
    	else
			image = new Image(ThemeManager.getThemeResource(INFO_INDICATOR_IMAGE));    	
    	
		image.setAttribute("org.zkoss.zul.image.preload", Boolean.TRUE);
		*/
//    	messageContainer.appendChild(image);
    	String labelText = buildLabelText(m_statusText);
    	if (error) {
    		Clients.showNotification(buildNotificationText(m_statusText), "error", findTabpanel(this), "top_left", 3500, true);
    	}
    	Label label = new Label(labelText);
    	messageContainer.setSclass(error ? "docstatus-error" : "docstatus-normal");
    	messageContainer.appendChild(label);
		if (m_logs != null) {
			div = new Div();
			for (int i = 0; i < m_logs.length; i++) {
				if (m_logs[i].getP_Msg() != null) {
					if (m_logs[i].getAD_Table_ID() > 0
							&& m_logs[i].getRecord_ID() > 0) {
						RecordLink recordLink = new RecordLink(m_logs[i].getAD_Table_ID(), m_logs[i].getRecord_ID());
						recordLink.setLabel(m_logs[i].getP_Msg());
						recordLink.addEventListener(Events.ON_CLICK, this);
						if (!div.getChildren().isEmpty())
							div.appendChild(new Separator("horizontal"));
						div.appendChild(recordLink);						
					}
				}
			}
		}

		if (labelText.length() != m_statusText.length() || (div != null && div.getChildren().size() > 0)) {
			label.addEventListener(Events.ON_CLICK, this);
			label.setStyle("cursor: pointer");
		
			label = new Label(" ...");
			label.setStyle("cursor: pointer");
			messageContainer.appendChild(label);
			label.addEventListener(Events.ON_CLICK, this);
		}
    	
    	messageContainer.appendChild(new Space());
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
		Text t = new Text(m_statusText);
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
			
			parent = parent.getParent();
		}
		return null;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget() instanceof RecordLink){
			doZoom((RecordLink)event.getTarget());
 		}
	}
	
	private void doZoom(RecordLink link) {
		int Record_ID = 0;
		int AD_Table_ID = 0;
		Record_ID = link.recordId;
		AD_Table_ID = link.tableId;
		if (Record_ID > 0 && AD_Table_ID > 0) {
			AEnv.zoom(AD_Table_ID, Record_ID);
		}
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
		msgPopupCnt.setVflex("1");

		
		msgPopup = new Window();
		msgPopup.setBorder(true);
		msgPopup.setClosable(true);
		msgPopup.setSizable(true);
		msgPopup.setContentStyle("overflow: auto");
        msgPopup.setWidth("500px");
        msgPopup.appendChild(msgPopupCnt);
        msgPopup.setShadow(true);
        msgPopupCaption = new Caption();
        msgPopup.appendChild(msgPopupCaption);        
	}

	class RecordLink extends A {
		private static final long serialVersionUID = 3793489614175751401L;
		
		protected int recordId;
		protected int tableId;

		protected RecordLink(int AD_Table_ID, int Record_ID) {
			super();
			tableId = AD_Table_ID;
			recordId = Record_ID;
		}
	}
}
