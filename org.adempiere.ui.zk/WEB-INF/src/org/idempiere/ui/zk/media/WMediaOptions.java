/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.ui.zk.media;

import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.adempiere.base.upload.IUploadHandler;
import org.adempiere.base.upload.IUploadService;
import org.adempiere.base.upload.UploadMedia;
import org.adempiere.base.upload.UploadResponse;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.report.LinkWindow;
import org.adempiere.webui.util.ReaderInputStream;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class WMediaOptions extends Window {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1642315087176748005L;

	/**
	 * 
	 * @param media
	 * @param preview
	 * @param uploadServicesMap
	 */
	public WMediaOptions(AMedia media, Runnable preview, Map<MAuthorizationAccount, IUploadService> uploadServicesMap) {
		setClosable(true);
		setTitle(media.getName());
		ZKUpdateUtil.setWindowWidthX(this, 400);
		setPosition("center,center");
		Vlayout vlayout = new Vlayout();
		vlayout.setHflex("1");
		appendChild(vlayout);
		Button btn = new Button(Msg.getMsg(Env.getCtx(), "SaveFile"));
		btn.setHflex("1");
		btn.setStyle("padding: 4px 8px");
		btn.addEventListener(Events.ON_CLICK, evt -> {
			detach();
			Filedownload.save(media);
		});
		vlayout.appendChild(btn);
		
		this.setSclass("popup-dialog");
		vlayout.setSclass("dialog-content");
		
		if (preview != null) {
			btn = new Button(Msg.getMsg(Env.getCtx(), "Preview"));
			btn.setHflex("1");
			btn.setStyle("padding: 4px 8px");
			btn.addEventListener(Events.ON_CLICK, evt -> {
				detach();
				preview.run();
			});
			vlayout.appendChild(btn);
		}
		
		if (uploadServicesMap != null && !uploadServicesMap.isEmpty()) {
			for(MAuthorizationAccount account : uploadServicesMap.keySet()) {
				IUploadService uploadService = uploadServicesMap.get(account);
				IUploadHandler[] handlers = uploadService.getUploadHandlers(media.getContentType());
				if (handlers != null && handlers.length > 0) {
					for(IUploadHandler handler : handlers) {
						btn = new Button(handler.getLabel());
						btn.setHflex("1");
						btn.setStyle("padding: 4px 8px");
						btn.addEventListener(Events.ON_CLICK, evt -> {
							Page page = WMediaOptions.this.getPage();
							Clients.showBusy(this, Msg.getMsg(Env.getCtx(), "Processing"));
							Executions.schedule(getDesktop(), e -> {
								uploadMedia(media, account, handler, page);
								Clients.clearBusy(WMediaOptions.this);
								WMediaOptions.this.detach();
							}, new Event("onUploadMedia"));																					
						});
						vlayout.appendChild(btn);
					}
				}
			}
		}
	}
	
	private void uploadMedia(AMedia media, MAuthorizationAccount account, IUploadHandler handler, Page page) {
		UploadResponse response = handler.uploadMedia(new UploadMedia(media.getName(), media.getContentType(),
				media.isBinary() ? media.getStreamData() : new ReaderInputStream(media.getReaderData(), StandardCharsets.UTF_8.name()), 
				media.isBinary() ? media.getByteData().length : 0), account);
		if (response != null && response.getLink() != null) {
			LinkWindow linkWindow = new LinkWindow(response.getLink(), response.getLinkLabel());
			linkWindow.setPage(page);
			linkWindow.doHighlighted();
		}
	}
}
