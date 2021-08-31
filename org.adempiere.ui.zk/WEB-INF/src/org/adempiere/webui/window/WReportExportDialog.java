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

import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Vbox;

/**
 * @author hengsin
 *
 */
public class WReportExportDialog extends Window implements EventListener<Event> {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8580712975224551032L;
	private Listbox cboType = new Listbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private IReportViewerExportSource viewer;
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WReportExportDialog.class);
	
	/**
	 * 
	 * @param viewer
	 */
	public WReportExportDialog(IReportViewerExportSource viewer) {
		this.viewer = viewer;
		ZKUpdateUtil.setWindowWidthX(this, 450);
		ZKUpdateUtil.setWindowHeightX(this, 150);
		setClosable(true);
		setBorder("normal");
		setSclass("popup-dialog");
		setStyle("position:absolute");
		
		cboType.setMold("select");
		
		cboType.getItems().clear();			
		cboType.appendItem("ps" + " - " + Msg.getMsg(Env.getCtx(), "FilePS"), "ps");
		cboType.appendItem("xml" + " - " + Msg.getMsg(Env.getCtx(), "FileXML"), "xml");
		cboType.appendItem("pdf" + " - " + Msg.getMsg(Env.getCtx(), "FilePDF"), "pdf");
		cboType.appendItem("html" + " - " + Msg.getMsg(Env.getCtx(), "FileHTML"), "html");
		cboType.appendItem("txt" + " - " + Msg.getMsg(Env.getCtx(), "FileTXT"), "txt");
		cboType.appendItem("ssv" + " - " + Msg.getMsg(Env.getCtx(), "FileSSV"), "ssv");
		cboType.appendItem("csv" + " - " + Msg.getMsg(Env.getCtx(), "FileCSV"), "csv");
		cboType.appendItem("xls" + " - " + Msg.getMsg(Env.getCtx(), "FileXLS"), "xls");
		cboType.appendItem("xlsx" + " - " + Msg.getMsg(Env.getCtx(), "FileXLSX"), "xlsx");
		
		String contentType = viewer.getContentType();
		if (IReportViewerExportSource.PDF_MIME_TYPE.equals(contentType)) {
			cboType.setSelectedIndex(2);
		} else if (IReportViewerExportSource.HTML_MIME_TYPE.equals(contentType)) {
			cboType.setSelectedIndex(3);
		} else if (IReportViewerExportSource.EXCEL_MIME_TYPE.equals(contentType)) {			
			cboType.setSelectedIndex(7);
		} else if (IReportViewerExportSource.CSV_MIME_TYPE.equals(contentType)) {
			cboType.setSelectedIndex(6);
		} else if (IReportViewerExportSource.EXCEL_XML_MIME_TYPE.equals(contentType)) {			
			cboType.setSelectedIndex(8);
		}
		
		Hbox hb = new Hbox();
		hb.setSclass("dialog-content");			
		hb.setAlign("center");
		hb.setPack("start");
		Div div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(new Label(Msg.getMsg(Env.getCtx(), "FilesOfType")));
		hb.appendChild(div);
		hb.appendChild(cboType);
		ZKUpdateUtil.setWidth(cboType, "100%");

		Vbox vb = new Vbox();
		ZKUpdateUtil.setWidth(vb, "100%");
		appendChild(vb);
		vb.appendChild(hb);
		vb.appendChild(confirmPanel);
		LayoutUtils.addSclass("dialog-footer", confirmPanel);
		confirmPanel.addActionListener(this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			onCancel();
		else if(event.getTarget().getId().equals(ConfirmPanel.A_OK))			
			exportFile();
	}

	private void onCancel() {
		onClose();
	}

	private void exportFile()
	{
		try
		{
			AMedia media = null;
			
			ListItem li = cboType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				FDialog.error(-1, this, "FileInvalidExtension");
				return;
			}
			
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
				FDialog.error(-1, this, "FileInvalidExtension");
				return;
			}

			onClose();		
			Filedownload.save(media, viewer.getReportName() + "." + ext);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Failed to export content.", e);
		}
	}
}
