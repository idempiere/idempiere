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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.adwindow.IADTabbox;
import org.adempiere.webui.adwindow.IADTabpanel;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Vbox;
import org.zkoss.zul.Vlayout;

/**
 *
 * @author hengsin
 *
 */
public class ExportAction implements EventListener<Event>
{
	private AbstractADWindowContent panel;

	private Map<String, IGridTabExporter> exporterMap = null;
	private Map<String, String> extensionMap = null;

	private Window winExportFile = null;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Listbox cboType = new Listbox();
	private Checkbox chkCurrentRow = new Checkbox();

	/**
	 * @param panel
	 */
	public ExportAction(AbstractADWindowContent panel)
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
		List<IGridTabExporter> exporterList = EquinoxExtensionLocator.instance().list(IGridTabExporter.class).getExtensions();
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
			winExportFile.setSclass("popup-dialog");
			winExportFile.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "exportAction");

			cboType.setMold("select");

			cboType.getItems().clear();
			for(Map.Entry<String, String> entry : extensionMap.entrySet())
			{
				cboType.appendItem(entry.getKey() + " - " + entry.getValue(), entry.getKey());
			}

			cboType.setSelectedIndex(0);

			Vbox vb = new Vbox();
			vb.setWidth("100%");
			winExportFile.appendChild(vb);

			Vlayout vlayout = new Vlayout();
			vlayout.setSclass("dialog-content");
			vb.appendChild(vlayout);
			
			Hbox hb = new Hbox();
			Div div = new Div();
			div.setStyle("text-align: right;");
			div.appendChild(new Label(Msg.getMsg(Env.getCtx(), "FilesOfType")));
			hb.appendChild(div);
			hb.appendChild(cboType);
			cboType.setWidth("100%");
			vlayout.appendChild(hb);

			hb = new Hbox();
			chkCurrentRow.setLabel(Msg.getMsg(Env.getCtx(), "ExportCurrentRowOnly"));
			chkCurrentRow.setSelected(true);
			hb.appendChild(chkCurrentRow);
			vlayout.appendChild(hb);

			LayoutUtils.addSclass("dialog-footer", confirmPanel);
			vb.appendChild(confirmPanel);
			confirmPanel.addActionListener(this);
		}
		
		panel.getComponent().getParent().appendChild(winExportFile);
		panel.showBusyMask(winExportFile);
		LayoutUtils.openOverlappedWindow(panel.getComponent(), winExportFile, "middle_center");
		winExportFile.addEventListener(DialogEvents.ON_WINDOW_CLOSE, this);
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			winExportFile.onClose();
		else if(event.getTarget().getId().equals(ConfirmPanel.A_OK))
			exportFile();
		else if (event.getName().equals(DialogEvents.ON_WINDOW_CLOSE)) {
			panel.hideBusyMask();			
			panel.getComponent().invalidate();
		}
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

			boolean currentRowOnly = chkCurrentRow.isSelected();
			File file = File.createTempFile("Export", "."+ext);
			IADTabbox adTab = panel.getADTab();
			int selected = adTab.getSelectedIndex();
			int tabLevel = panel.getActiveGridTab().getTabLevel();
			Set<String> tables = new HashSet<String>();
			List<GridTab> childs = new ArrayList<GridTab>();
			List<GridTab> includedList = panel.getActiveGridTab().getIncludedTabs();
			for(GridTab included : includedList)
			{
				String tableName = included.getTableName();
				if (tables.contains(tableName))
					continue;
				tables.add(tableName);
				childs.add(included);
			}
			for(int i = selected+1; i < adTab.getTabCount(); i++)
			{
				IADTabpanel adTabPanel = adTab.getADTabpanel(i);
				if (adTabPanel.getGridTab().isSortTab())
					continue;
				if (adTabPanel.getGridTab().getTabLevel() <= tabLevel)
					break;
				String tableName = adTabPanel.getGridTab().getTableName();
				if (tables.contains(tableName))
					continue;
				tables.add(tableName);
				childs.add(adTabPanel.getGridTab());
			}

			exporter.export(panel.getActiveGridTab(), childs, currentRowOnly, file);

			winExportFile.onClose();
			winExportFile = null;
			AMedia media = null;
			media = new AMedia(exporter.getSuggestedFileName(panel.getActiveGridTab()), null, exporter.getContentType(), file, true);
			Filedownload.save(media);
		} catch (Exception e) {
			throw new AdempiereException(e);
		} finally {
			if (winExportFile != null)
				winExportFile.onClose();
		}
	}
}
