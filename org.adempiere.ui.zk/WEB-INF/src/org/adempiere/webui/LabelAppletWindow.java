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

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Applet;
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
		
		Div div = new Div();
		appendChild(div);
		
		Applet applet = new Applet();
		applet.setCode("PrintLabelApplet.class");
		applet.setArchive("labelapplet.jar");
		applet.setWidth("0");
		applet.setHeight("0");
		applet.setParam("size", list.size() + "");

		File tempFile = null;
		FileOutputStream fos = null;
		for(int i = 0; i < list.size(); i++)
		{
			try
			{
				tempFile = File.createTempFile("lblapp", Long.toString(System.nanoTime()));
				fos = new FileOutputStream(tempFile);
				applet.setParam("file_" + i, tempFile.getAbsolutePath());
				fos.write(list.get(i));
				fos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		div.appendChild(applet);
		
		ToolBarButton link = new ToolBarButton();
		link.setLabel("Click here to close this popup after printing is completed.");
		link.addEventListener(Events.ON_CLICK, this);
		appendChild(link);
		
		this.setBorder("normal");		
	}
	
	public void onEvent(Event event) throws Exception 
	{
		if (Events.ON_CLICK.equals(event.getName()))
			this.detach();
	}	
}