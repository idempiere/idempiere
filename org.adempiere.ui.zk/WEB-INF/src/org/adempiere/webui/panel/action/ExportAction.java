/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.webui.panel.action;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.base.Service;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.AbstractADWindowPanel;
import org.adempiere.webui.window.FDialog;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Vbox;

/**
 *
 * @author hengsin
 *
 */
public class ExportAction implements EventListener
{
	private AbstractADWindowPanel panel;

	private Map<String, IGridTabExporter> exporterMap = null;
	private Map<String, String> extensionMap = null;

	private Window winExportFile = null;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Listbox cboType = new Listbox();

	/**
	 * @param panel
	 */
	public ExportAction(AbstractADWindowPanel panel)
	{
		this.panel = panel;
	}

	/**
	 * execute export action
	 */
	public void export()
	{
		exporterMap = new HashMap<String, IGridTabExporter>();
		extensionMap = new HashMap<String, String>();
		List<IGridTabExporter> exporterList = Service.list(IGridTabExporter.class);
		for(IGridTabExporter exporter : exporterList)
		{
			String extension = exporter.getFileExtension();
			if (!extensionMap.containsKey(extension))
			{
				extensionMap.put(extension, exporter.getFileExtensionLabel());
				exporterMap.put(extension, exporter);
			}
		}

		if(winExportFile == null)
		{
			winExportFile = new Window();
			winExportFile.setTitle(Msg.getMsg(Env.getCtx(), "Export") + ": " + panel.getActiveGridTab().getName());
			winExportFile.setWidth("450px");
			winExportFile.setClosable(true);
			winExportFile.setBorder("normal");
			winExportFile.setStyle("position:absolute");

			cboType.setMold("select");

			cboType.getItems().clear();
			for(Map.Entry<String, String> entry : extensionMap.entrySet())
			{
				cboType.appendItem(entry.getKey() + " - " + entry.getValue(), entry.getKey());
			}

			cboType.setSelectedIndex(0);

			Hbox hb = new Hbox();
			Div div = new Div();
			div.setAlign("right");
			div.appendChild(new Label("Files of Type: "));
			hb.appendChild(div);
			hb.appendChild(cboType);
			cboType.setWidth("100%");

			Vbox vb = new Vbox();
			vb.setWidth("390px");
			winExportFile.appendChild(vb);
			vb.appendChild(hb);
			vb.appendChild(confirmPanel);
			confirmPanel.addActionListener(this);
		}

		AEnv.showCenterScreen(winExportFile);
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			winExportFile.onClose();
		else if(event.getTarget().getId().equals(ConfirmPanel.A_OK))
			exportFile();
	}

	private void exportFile() {
		try {
			ListItem li = cboType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				FDialog.error(0, winExportFile, "FileInvalidExtension");
				return;
			}

			String ext = li.getValue().toString();
			IGridTabExporter exporter = exporterMap.get(ext);
			if (exporter == null)
			{
				FDialog.error(0, winExportFile, "FileInvalidExtension");
				return;
			}

			File file = File.createTempFile("Export", "."+ext);
			exporter.export(panel.getActiveGridTab(), file);

			winExportFile.onClose();
			winExportFile = null;
			AMedia media = null;
			media = new AMedia(panel.getActiveGridTab().getName() + "." + ext, null, exporter.getContentType(), file, true);
			Filedownload.save(media, panel.getActiveGridTab().getName() + "." + ext);
		} catch (Exception e) {
			throw new AdempiereException(e);
		} finally {
			if (winExportFile != null)
				winExportFile.onClose();
		}
	}
}
