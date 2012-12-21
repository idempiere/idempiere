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
import java.net.URLEncoder;
import java.util.List;
import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;

import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.VerticalBox;
import org.adempiere.webui.component.Window;
import org.compiere.model.MAttachmentEntry;
import org.compiere.util.CLogger;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Separator;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class UPSHtmlLabelWindow extends Window implements EventListener<Event> 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3700882367300286247L;
	private List<MAttachmentEntry> images;
	private List<MAttachmentEntry> htmls;
	private Listbox html;
	private Iframe content;
	
	private final static CLogger log = CLogger.getCLogger(UPSHtmlLabelWindow.class);

	public UPSHtmlLabelWindow(List<MAttachmentEntry> htmls, List<MAttachmentEntry> images)
	{
		super();
		this.htmls = htmls;
		this.images = images;
		
		init();
	}
	
	private void init()
	{
		this.setBorder("normal");
		this.setWidth("730px");
		VerticalBox box = new VerticalBox();
		this.appendChild(box);
		html = ListboxFactory.newDropdownListbox();
		for (MAttachmentEntry entry : htmls)
			html.appendItem(entry.getName(), entry);
		html.setSelectedIndex(0);
		html.addEventListener(Events.ON_SELECT, this);
		
		box.appendChild(html);
		box.appendChild(new Separator());
		content = new Iframe();
		content.setHeight("500px");
		content.setWidth("700px");
		content.setId("content");
		content.setName(content.getUuid());
		box.appendChild(content);
		
		ConfirmPanel panel = new ConfirmPanel(false);		
		panel.addActionListener(this);
		Button btn = panel.createButton(ConfirmPanel.A_PRINT);
		panel.addButton(btn);
		btn.addEventListener(Events.ON_CLICK, this);
		box.appendChild(new Separator());
		box.appendChild(panel);
		
		try 
		{
			loadContent();
		} 
		catch (Exception e) 
		{
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
	}

	private void loadContent() throws Exception 
	{
		MAttachmentEntry entry = (MAttachmentEntry) html.getSelectedItem().getValue();
		String htmlData = new String(entry.getData());
		String name = entry.getName();
		name = name.substring(0, name.length() - 5);
		String imageName = name + ".gif";
		MAttachmentEntry imageEntry = null;
		for (MAttachmentEntry i : images) 
		{
			if (i.getName().equals(imageName)) 
			{
				imageEntry = i;
				break;
			}
		}
		if (imageEntry != null) 
		{
			File tmp = File.createTempFile(name, ".gif");
			FileOutputStream os = new FileOutputStream(tmp);
			os.write(imageEntry.getData());
			os.flush();
			os.close();
			
			if (Executions.getCurrent() != null)
			{
				HttpServletRequest request = (HttpServletRequest) Executions.getCurrent().getNativeRequest();
				String url = request.getContextPath() + "/gif.jsp?f=" + URLEncoder.encode(tmp.getAbsolutePath(),"UTF-8");
				htmlData = htmlData.replace("./" + imageName, url);
			}
		}
		AMedia media = new AMedia(entry.getName(), null, entry.getContentType(), htmlData);
		content.setContent(media);
	}
	
	public void onPageAttached(Page newpage, Page oldpage) 
	{
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) 
		{
			if (Executions.getCurrent() != null)
			{
				try 
				{
					loadContent();
				} 
				catch (Exception e) 
				{
					log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				}
			}
		}
	}

	public void onEvent(Event event) throws Exception 
	{
		if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
			this.detach();
		else if (event.getTarget() == html)
			loadContent();
		else if (event.getTarget().getId().equals(ConfirmPanel.A_PRINT))
		{
			content.focus();
			String script = "frames['" + content.getUuid() + "'].contentWindow.print()";
			if (Executions.getCurrent() != null)
				Clients.response(new AuScript(script));
		}
	}
}