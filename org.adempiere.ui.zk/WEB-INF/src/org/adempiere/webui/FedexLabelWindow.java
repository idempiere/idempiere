/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
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
import java.util.logging.Level;

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
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Separator;

/**
 * 
 * @author Elaine
 *
 */
public class FedexLabelWindow extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8850485069628076246L;
	private List<MAttachmentEntry> images;
	private Listbox lbx;
	private Iframe content;
	
	private final static CLogger log = CLogger.getCLogger(FedexLabelWindow.class);

	public FedexLabelWindow(List<MAttachmentEntry> images)
	{
		super();
		this.images = images;
		
		init();
	}
	
	private void init()
	{
		this.setBorder("normal");
		this.setWidth("730px");
		VerticalBox box = new VerticalBox();
		this.appendChild(box);
		lbx = ListboxFactory.newDropdownListbox();
		for (MAttachmentEntry entry : images)
			lbx.appendItem(entry.getName(), entry);
		lbx.setSelectedIndex(0);
		lbx.addEventListener(Events.ON_SELECT, this);
		
		box.appendChild(lbx);
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
		MAttachmentEntry entry = (MAttachmentEntry) lbx.getSelectedItem().getValue();
		String name = entry.getName();
		name = name.substring(0, name.length() - 4);
		String imageName = name + ".png";
		MAttachmentEntry imageEntry = null;
		for (MAttachmentEntry i : images) 
		{
			if (i.getName().equals(imageName)) 
			{
				imageEntry = i;
				break;
			}
		}

		AMedia media = new AMedia(entry.getName(), null, imageEntry.getContentType(), imageEntry.getData());
		content.setContent(media);
	}

	public void onEvent(Event event) throws Exception 
	{
		if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
			this.detach();
		else if (event.getTarget() == lbx)
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