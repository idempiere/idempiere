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
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.GridTab;
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
	private int indxDetailSelected = 0;
	private List<GridTab> childs;
	private Row selectionTabRow = null;
	private List<Checkbox> chkSelectionTabForExport = null;
	private IGridTabExporter exporter;
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
			ZKUpdateUtil.setWindowWidthX(winExportFile, 450);
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

			selectionTabRow = new Row();
			rows.appendChild(selectionTabRow);
			
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
	 * Show list tab can export for user selection
	 */
	protected void displayExportTabSelection() {
		initTabInfo ();
		
		exporter = getExporter ();
		if (exporter == null){
			Events.echoEvent("onExporterException", winExportFile, null);	
		}
		
		// clear list checkbox selection to recreate with new reporter
		selectionTabRow.getChildren().clear();
		Vlayout vlayout = new Vlayout();
		selectionTabRow.appendChild(new Space());
		selectionTabRow.appendChild(vlayout);
		vlayout.appendChild(new Label(Msg.getMsg(Env.getCtx(), "SelectTabToExport")));
		
		chkSelectionTabForExport = new ArrayList<Checkbox> ();
		boolean isHasSelectionTab = false;
		boolean isSelectTabDefault = false;
		// with 2Pack, default is export all child tab
		if (exporter.getClass().getName().equals("org.adempiere.pipo2.GridTab2PackExporter")){
			isSelectTabDefault = true;
		}
		// for to make each export tab with one checkbox
		for (GridTab child : childs){
			Checkbox chkSelectionTab = new Checkbox();
			chkSelectionTab.setLabel(child.getName());
			// just allow selection tab can export
			if (!exporter.isExportableTab(child)){
				continue;
			}
			if (child.getTabNo() == indxDetailSelected || isSelectTabDefault){
				chkSelectionTab.setSelected(true);
			}
			chkSelectionTab.setAttribute("tabBinding", child);
			vlayout.appendChild(chkSelectionTab);
			chkSelectionTabForExport.add(chkSelectionTab);
			chkSelectionTab.addEventListener(Events.ON_CHECK, this);
			isHasSelectionTab = true;
		}
		
		// in case no child tab can export. clear selection area
		if (isHasSelectionTab == false){
			selectionTabRow.getChildren().clear();
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
		}else if (event.getTarget() instanceof Checkbox) {
			// A child is not exportable without its parent
			Checkbox cbSel = (Checkbox) event.getTarget();
			GridTab gtSel = (GridTab)cbSel.getAttribute("tabBinding");
			boolean found = false;
			for (Checkbox cb : chkSelectionTabForExport) {
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
		}else if (event.getName().equals("onExporterException")){
			Dialog.error(0, "FileInvalidExtension");
			winExportFile.onClose();
		}
	}

	private void onCancel() {
		winExportFile.onClose();
	}
	
	/**
	 * get info of window export,
	 * index of active tab, list child tab 
	 */
	protected void initTabInfo() {
		IADTabbox adTab = panel.getADTab();
		int selected = adTab.getSelectedIndex();
		int tabLevel = panel.getActiveGridTab().getTabLevel();
		Set<String> tables = new HashSet<String>();
		childs = new ArrayList<GridTab>();
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
		
		indxDetailSelected = 0;
		if( adTab.getSelectedDetailADTabpanel()!=null )
			indxDetailSelected = adTab.getSelectedDetailADTabpanel().getGridTab().getTabNo();
		
	}

	/**
	 * Get selected exporter
	 * @return
	 */
	protected IGridTabExporter getExporter() {
		ListItem li = cboType.getSelectedItem();
		if(li == null || li.getValue() == null)
		{
			return null;
		}

		String ext = li.getValue().toString();
		IGridTabExporter exporter = exporterMap.get(ext);
		return exporter;
	} 
	
	private void exportFile() {
		try {
			boolean currentRowOnly = chkCurrentRow.isSelected();
			File file = File.createTempFile("Export", "."+cboType.getSelectedItem().getValue().toString());
			childs.clear();
			for (Checkbox chkSeletionTab : chkSelectionTabForExport){
				if (chkSeletionTab.isChecked()){
					childs.add((GridTab)chkSeletionTab.getAttribute("tabBinding"));
				}
			}
			
			exporter.export(panel.getActiveGridTab(), childs, currentRowOnly,file,indxDetailSelected);

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
