/******************************************************************************
 * Copyright (C) 2012 Low Heng Sin                                            *
 * Copyright (C) 2012 Trek Global
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
package org.adempiere.webui;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.apache.commons.codec.binary.Base64;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class LabelAppletWindow extends Window implements EventListener<Event> 
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8980224912104404397L;

	public LabelAppletWindow(List<byte[]> list) 
	{
		super();
		String uuid = UUID.randomUUID().toString();
		HttpSession session = (HttpSession) Executions.getCurrent().getDesktop().getSession().getNativeSession();
		session.setAttribute(uuid, list);
		Div div = new Div();
		appendChild(div);
		
		ToolBarButton link = new ToolBarButton();
		link.setLabel("Click here to close this popup after printing is completed.");
		link.addEventListener(Events.ON_CLICK, this);
		appendChild(link);
		
		this.setBorder("normal");
		
		StringBuffer appletTag = new StringBuffer();
		appletTag.append("<applet code='PrintLabelApplet.class' archive='labelapplet.jar' width=0 height=0>");
		appletTag.append("<param name='key' value='" + uuid + "'>");
		appletTag.append("<param name='size' value='" + list.size() + "'>");
		
		for(int i = 0; i < list.size(); i++)
			appletTag.append("<param name='data_" + i + "' value='" + Base64.encodeBase64(list.get(i)) + "'>");
		
		appletTag.append("</applet>");
		
		String script = "document.getElementById('" + div.getUuid() + "').innerHTML=\"" + appletTag.toString() + "\";";
		Clients.response(new AuScript(div, script));		
	}

	public void onEvent(Event event) throws Exception 
	{
		if (Events.ON_CLICK.equals(event.getName()))
			this.detach();
	}	
}