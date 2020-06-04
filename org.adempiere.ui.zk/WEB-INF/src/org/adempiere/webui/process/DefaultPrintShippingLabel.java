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
package org.adempiere.webui.process;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.process.IPrintShippingLabel;
import org.adempiere.webui.FedexLabelWindow;
import org.adempiere.webui.UPSHtmlLabelWindow;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MShipperLabels;

/**
 * 
 * @author Elaine
 *
 */
public class DefaultPrintShippingLabel implements IPrintShippingLabel
{
	public String printToLabelPrinter(MAttachment attachment, MShipperLabels labelType) throws Exception
	{
		throw new UnsupportedOperationException();
	}

	public String printImageLabel(MAttachment attachment, MShipperLabels labelType, String title) throws Exception
	{
		MAttachmentEntry[] entries = attachment.getEntries();
		List<MAttachmentEntry> htmls = new ArrayList<MAttachmentEntry>();
		List<MAttachmentEntry> images = new ArrayList<MAttachmentEntry>();
		if (entries != null && entries.length > 0) 
		{
			for (MAttachmentEntry entry : entries) 
			{
				if (entry.getName().endsWith(".html"))
					htmls.add(entry);					
				else if (entry.isGraphic())
					images.add(entry);
			}
			if (htmls.size() > 0) 
			{
				final List<MAttachmentEntry> htmlList = htmls;
				final List<MAttachmentEntry> imageList = images;
				AEnv.executeAsyncDesktopTask(new Runnable() {
					@Override
					public void run() {
						Window labelWindow = new UPSHtmlLabelWindow(htmlList, imageList);
						labelWindow.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
						SessionManager.getAppDesktop().showWindow(labelWindow);
					}
				});
			}
			else if(images.size() > 0) 
			{
				final List<MAttachmentEntry> imageList = images;
				AEnv.executeAsyncDesktopTask(new Runnable() {
					@Override
					public void run() {
						Window labelWindow = new FedexLabelWindow(imageList);
						labelWindow.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
						SessionManager.getAppDesktop().showWindow(labelWindow);
					}
				});				
			}
		}
		return htmls.size() + " labels loaded.";
	}
}