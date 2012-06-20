/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.webui.window;

import java.io.File;
import java.io.FileNotFoundException;

import javax.activation.MimetypesFileTypeMap;

import org.adempiere.webui.component.DynamicMediaLink;
import org.adempiere.webui.component.Window;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class MultiFileDownloadDialog extends Window {

	public static final String ON_SHOW = "onShow";
	/**
	 * generated serial dialog
	 */
	private static final long serialVersionUID = -6078788264410182680L;
	private File[] files;

	public MultiFileDownloadDialog(File[] files) {
		super();
		this.files = files;
		this.addEventListener(ON_SHOW, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				MultiFileDownloadDialog.this.show();
			}
		});
	}

	private void show() {
		Vlayout layout = new Vlayout();
		layout.setStyle("padding-top: 10px; padding-bottom: 10px;");
		appendChild(layout);
		MimetypesFileTypeMap mimeMap = new MimetypesFileTypeMap();
		for(File file : files) {
			try {
				AMedia media = new AMedia(file, mimeMap.getContentType(file), null);
				DynamicMediaLink link = new DynamicMediaLink();
				layout.appendChild(link);
				link.setMedia(media);
				link.setLabel(media.getName());				
				link.setStyle("margin: 5px;");
			} catch (FileNotFoundException e) {				
			}
		}
		
		this.setClosable(true);
		this.setSizable(true);
		this.setMaximizable(true);
		this.setBorder("normal");
		this.setContentStyle("min-height: 200px; min-width:300px");
		this.setPosition("center");
		if (this.getTitle() == null || this.getTitle().length() == 0) {
			this.setTitle("Downloads");
		}
		this.doHighlighted();
	}
}
