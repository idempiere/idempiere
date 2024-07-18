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
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.adwindow.IADTabbox;
import org.adempiere.webui.adwindow.IADTabpanel;
import org.adempiere.webui.component.Checkbox;
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
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.GridTab;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;
import org.zkoss.zul.Vlayout;

/**
 * Action to export data from {@link GridTab}
 * @author hengsin
 */
public class ExportAction implements EventListener<Event>
{
	private AbstractADWindowContent panel;

	/** Exporter Label:IGridTabExporter */
	private Map<String, IGridTabExporter> exporterMap = null;
	/** Exporter Label:Exporter File Extension */
	private Map<String, String> extensionMap = null;
	
	/** Export file dialog */
	private Window winExportFile = null;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	/** List of exporters */
	private Listbox cboType = new Listbox();
	private Checkbox chkCurrentRow = new Checkbox();
	private int selectedChildTabIndex = 0;
	private List<GridTab> childTabs;
	private Row childTabSelectionRow = null;
	private List<Checkbox> chkSelectChildTabs = null;
	private IGridTabExporter exporter;
	/* SysConfig USE_ESC_FOR_TAB_CLOSING */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));
	
	/**
	 * @param panel
	 */
	public ExportAction(AbstractADWindowContent panel)
	{
		this.panel = panel;
	}

	/**
	 * Execute export action
	 */
	public void export()
	{
		exporterMap = new TreeMap<String, IGridTabExporter>();
		extensionMap = new TreeMap<String, String>();
		List<IGridTabExporter> exporterList = EquinoxExtensionLocator.instance().list(IGridTabExporter.class).getExtensions();
		MRole role = MRole.getDefault();
		for(IGridTabExporter exporter : exporterList)
		{
			if (exporter.isAdvanced() && !role.isAccessAdvanced())
				continue;
			
			String extension = exporter.getFileExtension();
			if (!extensionMap.containsKey(exporter.getFileExtensionLabel()))
			{
				extensionMap.put(exporter.getFileExtensionLabel(), extension);
				exporterMap.put(exporter.getFileExtensionLabel(), exporter);
			}
		}

		if(winExportFile == null)
		{
			winExportFile = new Window();
			winExportFile.setTitle(Msg.getMsg(Env.getCtx(), "Export") + ": " + panel.getActiveGridTab().getName());
			ZKUpdateUtil.setWindowWidthX(winExportFile, 450);
			winExportFile.setClosable(true);
			winExportFile.setBorder("normal");
			winExportFile.setStyle("position:absolute");
			winExportFile.setSclass("popup-dialog");
			winExportFile.setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "exportAction");

			cboType.setMold("select");

			cboType.getItems().clear();
			for (Entry<String, String> extension : extensionMap.entrySet()) {
				cboType.appendItem(extension.getKey(), extension.getValue());
			}

			cboType.setSelectedIndex(0);
			cboType.addActionListener(this);

			Vbox vb = new Vbox();
			ZKUpdateUtil.setWidth(vb, "100%");
			winExportFile.appendChild(vb);

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
			row.appendChild(new Label(Msg.getMsg(Env.getCtx(), "FilesOfType")));
			row.appendChild(cboType);
			ZKUpdateUtil.setHflex(cboType, "1");
			
			row = new Row();
			rows.appendChild(row);
			row.appendChild(new Space());
			chkCurrentRow.setLabel(Msg.getMsg(Env.getCtx(), "ExportCurrentRowOnly"));
			chkCurrentRow.setSelected(true);
			row.appendChild(chkCurrentRow);
			chkCurrentRow.addActionListener(this);

			childTabSelectionRow = new Row();
			rows.appendChild(childTabSelectionRow);
			
			LayoutUtils.addSclass("dialog-footer", confirmPanel);
			vb.appendChild(confirmPanel);
			confirmPanel.addActionListener(this);
			winExportFile.addEventListener(Events.ON_CANCEL, e -> onCancel());
		}
		displayExportTabSelection();
		panel.getComponent().getParent().appendChild(winExportFile);
		panel.showBusyMask(winExportFile);
		LayoutUtils.openOverlappedWindow(panel.getComponent(), winExportFile, "middle_center");
		winExportFile.addEventListener(DialogEvents.ON_WINDOW_CLOSE, this);
		winExportFile.addEventListener("onExporterException", this);
		winExportFile.focus();

	}
	
	/**
	 * Show child tabs for user selection
	 */
	protected void displayExportTabSelection() {
		initTabInfo ();
		
		int tabLevel = panel.getActiveGridTab().getTabLevel();
		
		exporter = getExporter ();
		if (exporter == null){
			Events.echoEvent("onExporterException", winExportFile, null);	
		}
		
		// clear list checkbox selection to recreate with new reporter
		childTabSelectionRow.getChildren().clear();
		if (exporter.isExportChildTabsForCurrentRowOnly() && !chkCurrentRow.isChecked())
			return;
		
		Vlayout vlayout = new Vlayout();
		childTabSelectionRow.appendChild(new Space());
		childTabSelectionRow.appendChild(vlayout);
		vlayout.appendChild(new Label(Msg.getMsg(Env.getCtx(), "SelectTabToExport")));
		
		chkSelectChildTabs = new ArrayList<Checkbox> ();
		boolean isHasSelectionTab = false;
		boolean selectAllChildTabs = false;
		// with 2Pack, default is export all child tab
		if (exporter.getClass().getName().equals("org.adempiere.pipo2.GridTab2PackExporter")){
			selectAllChildTabs = true;
		}
		// for to make each export tab with one checkbox
		for (GridTab child : childTabs){
			Checkbox chkSelectionTab = new Checkbox();
			chkSelectionTab.setLabel(child.getName());
			// check with exporter
			if (!exporter.isExportableTab(child)){
				continue;
			}
			if (exporter.maxDeepOfChildTab() > 0) {
				int deep = child.getTabLevel() - tabLevel;
				if (deep > exporter.maxDeepOfChildTab())
					continue;
			}
			if (child.getTabNo() == selectedChildTabIndex || selectAllChildTabs){
				chkSelectionTab.setSelected(true);
			}
			chkSelectionTab.setAttribute("tabBinding", child);
			vlayout.appendChild(chkSelectionTab);
			chkSelectChildTabs.add(chkSelectionTab);
			chkSelectionTab.addEventListener(Events.ON_CHECK, this);
			isHasSelectionTab = true;
		}
		
		// in case no child tab can export. clear selection area
		if (isHasSelectionTab == false){
			childTabSelectionRow.getChildren().clear();
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			onCancel();
		else if(event.getTarget().getId().equals(ConfirmPanel.A_OK))
			exportFile();
		else if (event.getName().equals(DialogEvents.ON_WINDOW_CLOSE)) {
			panel.hideBusyMask();	
			panel.focusToLastFocusEditor();
		} else if (event.getTarget().equals(cboType) && event.getName().equals(Events.ON_SELECT)) {
			displayExportTabSelection();
		} else if (event.getTarget() == chkCurrentRow) {
			exporter = getExporter();
			if (exporter != null && exporter.isExportChildTabsForCurrentRowOnly()) {
				displayExportTabSelection();
			}
		} else if (event.getTarget() instanceof Checkbox) {
			// A child is not exportable without its parent
			Checkbox cbSel = (Checkbox) event.getTarget();
			GridTab gtSel = (GridTab)cbSel.getAttribute("tabBinding");
			boolean found = false;
			for (Checkbox cb : chkSelectChildTabs) {
				if (cb == cbSel) {
					found = true;
					continue;
				}
				GridTab gt = (GridTab)cb.getAttribute("tabBinding");
				if (found) {
					if (gt.getTabLevel() > gtSel.getTabLevel()) {
						cb.setChecked(cbSel.isChecked());
						cb.setEnabled(cbSel.isChecked());
					} else {
						break;
					}
				}
			}
		} else if (event.getName().equals("onExporterException")){
			Dialog.error(0, "FileInvalidExtension");
			winExportFile.onClose();
		}
	}

	/**
	 * Close export file dialog
	 */
	private void onCancel() {
		// do not allow to close tab for Events.ON_CTRL_KEY event
		if(isUseEscForTabClosing)
			SessionManager.getAppDesktop().setCloseTabWithShortcut(false);
		
		winExportFile.onClose();
	}
	
	/**
	 * Get GridTabs info from calling AD window,
	 * index of active detail tab, child tabs 
	 */
	protected void initTabInfo() {
		IADTabbox adTab = panel.getADTab();
		int selected = adTab.getSelectedIndex();
		int tabLevel = panel.getActiveGridTab().getTabLevel();
		Set<String> tables = new HashSet<String>();
		childTabs = new ArrayList<GridTab>();
		List<GridTab> includedList = panel.getActiveGridTab().getIncludedTabs();
		for(GridTab included : includedList)
		{
			String tableName = included.getTableName();
			if (tables.contains(tableName))
				continue;
			tables.add(tableName);
			childTabs.add(included);
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
			childTabs.add(adTabPanel.getGridTab());
		}
		
		selectedChildTabIndex = 0;
		if( adTab.getSelectedDetailADTabpanel()!=null )
			selectedChildTabIndex = adTab.getSelectedDetailADTabpanel().getGridTab().getTabNo();
		
	}

	/**
	 * Get selected exporter
	 * @return IGridTabExporter
	 */
	protected IGridTabExporter getExporter() {
		ListItem li = cboType.getSelectedItem();
		if(li == null || li.getLabel() == null)
		{
			return null;
		}

		String ext = li.getLabel().toString();
		IGridTabExporter exporter = exporterMap.get(ext);
		return exporter;
	} 
	
	/**
	 * Invoke exporter and prompt user to download exported data file
	 */
	private void exportFile() {
		try {
			boolean currentRowOnly = chkCurrentRow.isSelected();
			File file = File.createTempFile("Export", "."+cboType.getSelectedItem().getValue().toString());
			List<GridTab> selectedChildTabs = new ArrayList<>();
			for (Checkbox chkSeletionTab : chkSelectChildTabs){
				if (chkSeletionTab.isChecked()){
					selectedChildTabs.add((GridTab)chkSeletionTab.getAttribute("tabBinding"));
				}
			}
			
			exporter.export(panel.getActiveGridTab(), selectedChildTabs, currentRowOnly, file, selectedChildTabIndex);

			winExportFile.onClose();
			winExportFile = null;
			AMedia media = null;
			media = new AMedia(exporter.getSuggestedFileName(panel.getActiveGridTab()), null, exporter.getContentType(), file, true);
			Filedownload.save(media);
		} catch (Exception e) {
			Dialog.error(0, e.getLocalizedMessage());
		} finally {
			if (winExportFile != null)
				winExportFile.onClose();
		}
	}
}
