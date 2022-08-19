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
 * - trekglobal														   *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.window;

import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.base.upload.IUploadHandler;
import org.adempiere.base.upload.IUploadService;
import org.adempiere.base.upload.UploadMedia;
import org.adempiere.base.upload.UploadResponse;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.report.LinkWindow;
import org.adempiere.webui.util.ReaderInputStream;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class WReportUploadDialog extends Window implements EventListener<Event> {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8580712975224551032L;
	private Listbox cboType = new Listbox();
	private Listbox cboActions = new Listbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private IReportViewerExportSource viewer;
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WReportUploadDialog.class);
	
	/**
	 * 
	 * @param viewer
	 */
	public WReportUploadDialog(IReportViewerExportSource viewer) {
		this.viewer = viewer;
		ZKUpdateUtil.setWindowWidthX(this, 500);
		setClosable(true);
		setBorder("normal");
		setSclass("popup-dialog");
		
		cboType.setMold("select");
		
		cboType.getItems().clear();			
		cboType.appendItem(IReportViewerExportSource.POSTSCRIPT_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FilePS"), IReportViewerExportSource.POSTSCRIPT_FILE_EXT);
		cboType.appendItem(IReportViewerExportSource.XML_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileXML"), IReportViewerExportSource.XML_FILE_EXT);
		cboType.appendItem(IReportViewerExportSource.PDF_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FilePDF"), IReportViewerExportSource.PDF_FILE_EXT);
		cboType.appendItem(IReportViewerExportSource.HTML_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileHTML"), IReportViewerExportSource.HTML_FILE_EXT);
		cboType.appendItem(IReportViewerExportSource.TEXT_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileTXT"), IReportViewerExportSource.TEXT_FILE_EXT);
		cboType.appendItem(IReportViewerExportSource.CSV_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileCSV"), IReportViewerExportSource.CSV_FILE_EXT);
		cboType.appendItem(IReportViewerExportSource.SSV_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileSSV"), IReportViewerExportSource.SSV_FILE_EXT);		
		cboType.appendItem(IReportViewerExportSource.EXCEL_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileXLS"), IReportViewerExportSource.EXCEL_FILE_EXT);
		cboType.appendItem(IReportViewerExportSource.EXCEL_XML_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileXLSX"), IReportViewerExportSource.EXCEL_XML_FILE_EXT);
		
		String contentType = viewer.getContentType();
		if (IReportViewerExportSource.PDF_MIME_TYPE.equals(contentType)) {
			cboType.setSelectedIndex(2);
		} else if (IReportViewerExportSource.HTML_MIME_TYPE.equals(contentType)) {
			cboType.setSelectedIndex(3);
		} else if (IReportViewerExportSource.CSV_MIME_TYPE.equals(contentType)) {
			if (IReportViewerExportSource.CSV_FILE_EXT.equals(viewer.getFileExtension())) {
				cboType.setSelectedIndex(5);
			} else {
				cboType.setSelectedIndex(6);
			}
		} else if (IReportViewerExportSource.EXCEL_MIME_TYPE.equals(contentType)) {			
			cboType.setSelectedIndex(7);
		} else if (IReportViewerExportSource.EXCEL_XML_MIME_TYPE.equals(contentType)) {			
			cboType.setSelectedIndex(8);
		}
		cboType.addActionListener(this);
		
		Div hb = new Div();
		hb.setSclass("dialog-content");			
		hb.setWidth("100%");
		Div div = new Div();
		div.setStyle("text-align: right;display:inline-block;padding-right:5px;");
		div.setWidth("30%");
		div.appendChild(new Label(Msg.getMsg(Env.getCtx(), "FilesOfType")));
		hb.appendChild(div);
		hb.appendChild(cboType);
		cboType.setWidth("70%");
		cboType.setStyle("border-width:1px !important;");

		Vlayout vb = new Vlayout();
		ZKUpdateUtil.setWidth(vb, "100%");
		vb.setVflex("1");
		appendChild(vb);
		vb.appendChild(hb);
		
		cboActions.setMold("select");
		hb = new Div();
		hb.setSclass("dialog-content");			
		hb.setWidth("100%");
		div = new Div();
		div.setStyle("text-align: right;display:inline-block;padding-right:5px;");
		div.setWidth("30%");
		div.appendChild(new Label(Msg.getMsg(Env.getCtx(), "UploadAction")));
		hb.appendChild(div);
		hb.appendChild(cboActions);
		cboActions.setWidth("70%");
		cboActions.setStyle("border-width:1px !important;");
		vb.appendChild(hb);
		onOutputTypeSelectionChanged();				
		
		vb.appendChild(confirmPanel);
		LayoutUtils.addSclass("dialog-footer", confirmPanel);						
		confirmPanel.addActionListener(this);
		
		addEventListener(Events.ON_CANCEL, e -> onCancel());
		this.setVflex("min");
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL)) {
			onCancel();
		} else if(event.getTarget().getId().equals(ConfirmPanel.A_OK)) {			
			uploadFile();
		} else if (event.getTarget() == cboType) {
			onOutputTypeSelectionChanged();
		}
	}

	private void onCancel() {
		onClose();
	}

	private void onOutputTypeSelectionChanged() {
		Listitem li = cboType.getSelectedItem();
		String ext = li.getValue().toString();
		String mime = toContentType(ext);
		
		cboActions.getItems().clear();
		Map<MAuthorizationAccount, IUploadService> map = viewer.getUploadServiceMap();
		for(MAuthorizationAccount account : map.keySet()) {
			IUploadService service = map.get(account);
			IUploadHandler[] handlers = service.getUploadHandlers(mime);
			for (IUploadHandler handler : handlers) {
				cboActions.appendItem(handler.getLabel(), new UploadHandler(account, handler));
			}
		}
	}

	private class UploadHandler {
		private MAuthorizationAccount account;
		private IUploadHandler handler;

		private UploadHandler(MAuthorizationAccount account, IUploadHandler handler) {
			this.account = account;
			this.handler = handler;
		}
	}
	
	private String toContentType(String ext) {
		if (ext.equals(IReportViewerExportSource.PDF_FILE_EXT))
		{
			return IReportViewerExportSource.PDF_MIME_TYPE;
		}
		else if (ext.equals(IReportViewerExportSource.POSTSCRIPT_FILE_EXT))
		{
			return IReportViewerExportSource.POSTSCRIPT_MIME_TYPE;
		}
		else if (ext.equals(IReportViewerExportSource.XML_FILE_EXT))
		{
			return IReportViewerExportSource.XML_MIME_TYPE;
		}
		else if (ext.equals(IReportViewerExportSource.CSV_FILE_EXT))
		{
			return IReportViewerExportSource.CSV_MIME_TYPE;
		}
		else if (ext.equals(IReportViewerExportSource.SSV_FILE_EXT))
		{
			return IReportViewerExportSource.CSV_MIME_TYPE;
		}
		else if (ext.equals(IReportViewerExportSource.TEXT_FILE_EXT))
		{
			return IReportViewerExportSource.TEXT_MIME_TYPE;							
		}
		else if (ext.equals(IReportViewerExportSource.HTML_FILE_EXT) || ext.equals("htm"))
		{
			return IReportViewerExportSource.HTML_MIME_TYPE;
		}
		else if (ext.equals(IReportViewerExportSource.EXCEL_XML_FILE_EXT))
		{
			return IReportViewerExportSource.EXCEL_XML_MIME_TYPE;
		}
		else if (ext.equals(IReportViewerExportSource.EXCEL_FILE_EXT))
		{
			return IReportViewerExportSource.EXCEL_MIME_TYPE;
		}
		
		return null;
	}

	private void uploadFile()
	{
		try
		{
			AMedia media = null;
			ListItem li = cboType.getSelectedItem();
			String ext = li.getValue().toString();
			
			if (ext.equals(IReportViewerExportSource.PDF_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.PDF_MIME_TYPE, IReportViewerExportSource.PDF_FILE_EXT);
			}
			else if (ext.equals(IReportViewerExportSource.POSTSCRIPT_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.POSTSCRIPT_MIME_TYPE, IReportViewerExportSource.POSTSCRIPT_FILE_EXT);
			}
			else if (ext.equals(IReportViewerExportSource.XML_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.XML_MIME_TYPE, IReportViewerExportSource.XML_FILE_EXT);
			}
			else if (ext.equals(IReportViewerExportSource.CSV_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.CSV_MIME_TYPE, IReportViewerExportSource.CSV_FILE_EXT);
			}
			else if (ext.equals(IReportViewerExportSource.SSV_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.CSV_MIME_TYPE, IReportViewerExportSource.SSV_FILE_EXT);
			}
			else if (ext.equals(IReportViewerExportSource.TEXT_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.TEXT_MIME_TYPE, IReportViewerExportSource.TEXT_FILE_EXT);					
			}
			else if (ext.equals(IReportViewerExportSource.HTML_FILE_EXT) || ext.equals("htm"))
			{
				media = viewer.getMedia(IReportViewerExportSource.HTML_MIME_TYPE, IReportViewerExportSource.HTML_FILE_EXT);
			}
			else if (ext.equals(IReportViewerExportSource.EXCEL_XML_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.EXCEL_XML_MIME_TYPE, IReportViewerExportSource.EXCEL_XML_FILE_EXT);
			}
			else if (ext.equals(IReportViewerExportSource.EXCEL_FILE_EXT))
			{
				media = viewer.getMedia(IReportViewerExportSource.EXCEL_MIME_TYPE, IReportViewerExportSource.EXCEL_FILE_EXT);
			}
			else
			{
				Dialog.error(-1, "FileInvalidExtension", ext, this.getTitle());
				return;
			}

			Page page = this.getPage();
			onClose();					
			UploadHandler uh = cboActions.getSelectedItem().getValue();
			UploadResponse response = uh.handler.uploadMedia(new UploadMedia(media.getName(), media.getContentType(),
					media.isBinary() ? media.getStreamData() : new ReaderInputStream(media.getReaderData(), StandardCharsets.UTF_8.name()), 
					media.isBinary() ? media.getByteData().length : 0), uh.account);
			if (response != null && response.getLink() != null) {
				LinkWindow linkWindow = new LinkWindow(response.getLink(), response.getLinkLabel());
				linkWindow.setPage(page);
				linkWindow.doHighlighted();
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Failed to upload content.", e);
			Dialog.error(-1, "Error", e.getMessage(), this.getTitle());
		}
	}

	@Override
	public void focus() {
		super.focus();
		if (cboType != null)
			cboType.focus();
	}
	
	
}
