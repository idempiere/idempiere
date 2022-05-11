/**********************************************************************
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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/
package org.adempiere.webui.panel.action;

import java.io.File;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.adempiere.base.IGridTabImporter;
import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.adwindow.IADTabbox;
import org.adempiere.webui.adwindow.IADTabpanel;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.util.ReaderInputStream;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridTab;
import org.compiere.model.MImportTemplate;
import org.compiere.model.MQuery;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.UploadEvent;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;
import org.zkoss.zul.Vlayout;

/**
 *
 * @author Carlos Ruiz
 *
 */
public class CSVImportAction implements EventListener<Event>
{

	private AbstractADWindowContent panel;

	IGridTabImporter theCSVImporter = null;
	MImportTemplate theTemplate = null;

	private Window winImportFile = null;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Button bFile = new Button();
	private Listbox fTemplates = new Listbox();
	private Listbox fImportMode = new Listbox();
	private InputStream m_file_istream = null;

	/**
	 * @param panel
	 */
	public CSVImportAction(AbstractADWindowContent panel)
	{
		this.panel = panel;
	}

	/**
	 * execute import action
	 */
	public void fileImport()
	{
		List<IGridTabImporter> importerList = EquinoxExtensionLocator.instance().list(IGridTabImporter.class).getExtensions();
		for(IGridTabImporter importer : importerList) {
			String extension = importer.getFileExtension();
			if (extension.equals("csv")) {
				theCSVImporter = importer;
				break;
			}
		}
		if (theCSVImporter == null)
			throw new AdempiereException("No CSV importer");

		// templates allowed to this role
		int tabid = -1;
		if (panel != null && panel.getActiveGridTab() != null)
			tabid = panel.getActiveGridTab().getAD_Tab_ID();
		for (MImportTemplate it : MImportTemplate.getTemplates(Env.getAD_Role_ID(Env.getCtx()), tabid)) {
			if (theTemplate == null)
				theTemplate = it;
			fTemplates.appendItem(it.getName(), it);
		}
		fTemplates.addEventListener(Events.ON_SELECT, this);
		if (fTemplates.getItemCount() > 0) {
			fTemplates.setSelectedIndex(0);
			setTemplateList();
		} else {
			throw new AdempiereException("No templates for this tab");
		}

		if (winImportFile == null)
		{
			winImportFile = new Window();
			winImportFile.setTitle(Msg.getMsg(Env.getCtx(), "FileImport") + ": " + panel.getActiveGridTab().getName());
			ZKUpdateUtil.setWindowWidthX(winImportFile, 450);
			winImportFile.setClosable(true);
			winImportFile.setBorder("normal");
			winImportFile.setStyle("position:absolute");
			winImportFile.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "importAction");
			winImportFile.setSclass("popup-dialog");

			Vbox vb = new Vbox();
			ZKUpdateUtil.setWidth(vb, "100%");
			winImportFile.appendChild(vb);

			Vlayout vlayout = new Vlayout();
			vlayout.setSclass("dialog-content");
			vb.appendChild(vlayout);

			Grid grid = GridFactory.newGridLayout();
			vlayout.appendChild(grid);

			Columns columns = new Columns();
			Column column = new Column();
			ZKUpdateUtil.setHflex(column, "min");
			columns.appendChild(column);
			column = new Column();
			ZKUpdateUtil.setHflex(column, "1");
			columns.appendChild(column);
			grid.appendChild(columns);

			Rows rows = new Rows();
			grid.appendChild(rows);

			Row row = new Row();
			rows.appendChild(row);
			row.appendChild(new Label(Msg.getElement(Env.getCtx(), "AD_ImportTemplate_ID") + ": "));
			fTemplates.setMold("select");
			fTemplates.setRows(0);
			fTemplates.setTooltiptext(Msg.getElement(Env.getCtx(), "AD_ImportTemplate_ID"));
			row.appendChild(fTemplates);
			ZKUpdateUtil.setHflex(fTemplates, "1");

			row = new Row();
			rows.appendChild(row);
			row.appendChild(new Label(Msg.getMsg(Env.getCtx(), "import.mode", true)));
			fImportMode.setMold("select");
			fImportMode.setRows(0);
			fImportMode.setTooltiptext(Msg.getMsg(Env.getCtx(), "import.mode", false));
			row.appendChild(fImportMode);
			ZKUpdateUtil.setHflex(fImportMode, "1");

			row = new Row();
			rows.appendChild(row);
			row.appendChild(new Space());
			bFile.setLabel(Msg.getMsg(Env.getCtx(), "FileImportFile"));
			bFile.setTooltiptext(Msg.getMsg(Env.getCtx(), "FileImportFileInfo"));
			bFile.setUpload(AdempiereWebUI.getUploadSetting());
			LayoutUtils.addSclass("txt-btn", bFile);
			bFile.addEventListener(Events.ON_UPLOAD, this);
			row.appendChild(bFile);

			LayoutUtils.addSclass("dialog-footer", confirmPanel);
			vb.appendChild(confirmPanel);
			confirmPanel.addActionListener(this);
			winImportFile.addEventListener(Events.ON_CANCEL, e -> onCancel());
		}

		panel.getComponent().getParent().appendChild(winImportFile);
		panel.showBusyMask(winImportFile);
		LayoutUtils.openOverlappedWindow(panel.getComponent(), winImportFile, "middle_center");
		winImportFile.addEventListener(DialogEvents.ON_WINDOW_CLOSE, this);
		winImportFile.setFocus(true);
	}

	private void setTemplateList() {
		Charset charset = Charset.forName(theTemplate.getCharacterSet());
		Executions.getCurrent().getDesktop().getWebApp().getConfiguration().setUploadCharset(charset.name());
		bFile.setLabel(Msg.getMsg(Env.getCtx(), "FileImportFile"));
		fillImportMode();
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event instanceof UploadEvent) 
		{
			UploadEvent ue = (UploadEvent) event;
			processUploadMedia(ue.getMedia());
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL)) {
			onCancel();
		} else if (event.getTarget() == fTemplates) {
			if (m_file_istream != null) {
				m_file_istream.close();
				m_file_istream = null;
			}
			ListItem listitem = fTemplates.getSelectedItem();
			if (listitem == null)
				return;
			theTemplate = (MImportTemplate)listitem.getValue();
			setTemplateList();
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			if (m_file_istream == null || fTemplates.getSelectedItem() == null)
				return;
			importFile();
		} else if (event.getName().equals(DialogEvents.ON_WINDOW_CLOSE)) {
			panel.hideBusyMask();
			panel.focusToLastFocusEditor();
		}
	}

	private void onCancel() {
		winImportFile.onClose();
	}

	private void fillImportMode() {
		final String sql= ""
				+ "SELECT MAX(IsAllowInsert), "
				+ "       MAX(IsAllowUpdate), "
				+ "       MAX(IsAllowMerge) "
				+ "FROM   AD_ImportTemplateAccess "
				+ "WHERE  IsActive = 'Y' "
				+ "       AND AD_ImportTemplate_ID = ? "
				+ "       AND ( AD_Role_ID = ? "
				+ "              OR AD_Role_ID IN (SELECT Included_Role_ID "
				+ "                                FROM   AD_Role_Included "
				+ "                                WHERE  AD_Role_ID = ? "
				+ "                                       AND IsActive = 'Y') ) "
				+ "       AND ( IsAllowInsert = 'Y' "
				+ "              OR IsAllowMerge = 'Y' "
				+ "              OR IsAllowUpdate = 'Y' )";
		List<Object> flags = DB.getSQLValueObjectsEx(null, sql, theTemplate.getAD_ImportTemplate_ID(), Env.getAD_Role_ID(Env.getCtx()), Env.getAD_Role_ID(Env.getCtx()));
		fImportMode.removeAllItems();
		if (flags.get(0) != null && "Y".equals(flags.get(0).toString()))
			fImportMode.appendItem("Insert","I");
		if (flags.get(1) != null && "Y".equals(flags.get(1).toString()))
			fImportMode.appendItem("Update","U");
		if (flags.get(2) != null && "Y".equals(flags.get(2).toString()))
			fImportMode.appendItem("Merge","M");
		if (fImportMode.getItemCount() == 1)
			fImportMode.setSelectedIndex(0);
	}

	private void processUploadMedia(Media media) {
		if (media == null)
			return;

		if (media.isBinary()) {
			m_file_istream = media.getStreamData();
		}
		else {
			if (theTemplate == null) {
				m_file_istream = new ReaderInputStream(media.getReaderData());
			} else {
				Charset charset = Charset.forName(theTemplate.getCharacterSet());
				m_file_istream = new ReaderInputStream(media.getReaderData(), charset.name());
			}
		}

		bFile.setLabel(media.getName());
	}

	private void importFile() {
		try {
			MQuery query = panel.getActiveGridTab().getQuery();
			MQuery detailQuery = null;
			if (panel.getADTab() != null && panel.getADTab().getSelectedDetailADTabpanel() != null
					&& panel.getADTab().getSelectedDetailADTabpanel().getGridTab() != null)
				detailQuery = panel.getADTab().getSelectedDetailADTabpanel().getGridTab().getQuery();


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

			Charset charset = Charset.forName(theTemplate.getCharacterSet());
			Executions.getCurrent().getDesktop().getWebApp().getConfiguration().setUploadCharset(charset.name());
			ListItem importItem = fImportMode.getSelectedItem();
			if (importItem == null)
				return;

			String iMode = (String)importItem.getValue();
			m_file_istream = theTemplate.validateFile(m_file_istream);
			File outFile = theCSVImporter.fileImport(panel.getActiveGridTab(), childs, m_file_istream, charset,iMode);
			winImportFile.onClose();
			winImportFile = null;

			AMedia media = null;
			media = new AMedia(theCSVImporter.getSuggestedFileName(panel.getActiveGridTab()), null, theCSVImporter.getContentType(), outFile, true);
			Filedownload.save(media);

			if (query != null) {
	        	query.addRestriction("1=1");
	        	panel.getActiveGridTab().setQuery(query);
	        	panel.getADTab().getSelectedTabpanel().query(false, 0, panel.getActiveGridTab().getMaxQueryRecords());
	        }
	        panel.getActiveGridTab().dataRefresh(false);
	        
	        if (detailQuery != null){
	        	detailQuery.addRestriction("1=1");
	        	panel.getADTab().getSelectedDetailADTabpanel().getGridTab().setQuery(detailQuery);	        	
	        	panel.getADTab().getSelectedDetailADTabpanel().query(false, 0, panel.getActiveGridTab().getMaxQueryRecords());
		        panel.getADTab().getSelectedDetailADTabpanel().getGridTab().dataRefresh(false);
	        }
		} catch (Exception e) {
			throw new AdempiereException(e);
		} finally {
			if (winImportFile != null)
				winImportFile.onClose();
		}
	}

}
