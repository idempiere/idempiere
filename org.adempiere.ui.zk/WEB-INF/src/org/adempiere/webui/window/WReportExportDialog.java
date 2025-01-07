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

import java.util.Arrays;
import java.util.Comparator;
import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.IReportViewerExportSource.ExportFormat;
import org.compiere.model.MSysConfig;
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
 * Dialog to export and download report
 * @author hengsin
 */
public class WReportExportDialog extends Window implements EventListener<Event> {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8580712975224551032L;
	private Listbox cboType = new Listbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private IReportViewerExportSource viewer;
	/* SysConfig USE_ESC_FOR_TAB_CLOSING */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WReportExportDialog.class);
	
	/**
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
		ExportFormat[] exportFormats = viewer.getExportFormats();
		Arrays.sort(exportFormats, new Comparator<ExportFormat>() {
			@Override
			public int compare(ExportFormat ef0, ExportFormat ef1) {
				return ef0.label.compareTo(ef1.label);
			}
		});
		for(ExportFormat exportFormat : exportFormats) {
			ListItem item = cboType.appendItem(exportFormat.label, exportFormat);
			if (viewer.getContentType().equals(exportFormat.contentType) && viewer.getFileExtension().equals(exportFormat.extension)) {
				item.setSelected(true);
			}
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

	/**
	 * Handle onCancel event
	 */
	private void onCancel() {
		// do not allow to close tab for Events.ON_CTRL_KEY event
		if(isUseEscForTabClosing)
			SessionManager.getAppDesktop().setCloseTabWithShortcut(false);

		onClose();
	}

	/**
	 * Export report as file for download by user
	 */
	private void exportFile()
	{
		try
		{
			AMedia media = null;
			
			ListItem li = cboType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				Dialog.error(-1, "FileInvalidExtension");
				return;
			}
			
			ExportFormat exportFormat = li.getValue();
			media = viewer.getMedia(exportFormat.contentType, exportFormat.extension);

			onClose();		
			Filedownload.save(media, viewer.getReportName() + "." + exportFormat.extension);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Failed to export content.", e);
		}
	}
}
