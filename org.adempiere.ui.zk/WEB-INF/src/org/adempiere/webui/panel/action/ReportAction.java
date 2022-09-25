/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.apps.WProcessCtl;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.GridTab;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportCtl;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tabpanel;
import org.zkoss.zul.impl.LabelImageElement;

/**
 * @author Elaine
 * @date September 6, 2012
 */
public class ReportAction implements EventListener<Event>
{
	private static final CLogger log = CLogger.getCLogger(ReportAction.class);
	
	private AbstractADWindowContent panel;
	
	private Window winReport = null;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Listbox cboPrintFormat = new Listbox();
	private Listbox cboExportType = new Listbox();
	private Checkbox chkCurrentRowOnly = new Checkbox();
	private Checkbox chkExport = new Checkbox();
	private Checkbox chkAllColumns = new Checkbox();
	
	private List<KeyNamePair>	printFormatList = new ArrayList<KeyNamePair>();

	public ReportAction(AbstractADWindowContent panel)
	{
		this.panel = panel;		
		getPrintFormats(panel.getActiveGridTab().getAD_Table_ID(), panel.getActiveGridTab().getAD_Window_ID());
	}
	
	public void show() 
	{
		int AD_Table_ID=panel.getActiveGridTab().getAD_Table_ID();
		final boolean isCanExport=MRole.getDefault().isCanExport(AD_Table_ID);
		if(winReport == null)
		{
			winReport = new Window();
			ZKUpdateUtil.setWindowWidthX(winReport, 450);
			winReport.setClosable(true);
			winReport.setBorder("normal");
			winReport.setStyle("position:absolute");
			winReport.addEventListener("onValidate", this);
			winReport.addCallback(Window.AFTER_PAGE_DETACHED, t -> panel.focusToLastFocusEditor());
			
			cboPrintFormat.setMold("select");
			cboPrintFormat.getItems().clear();
			for (KeyNamePair printFormat : printFormatList)
				cboPrintFormat.appendItem(printFormat.getName(), printFormat.getKey());
			if (cboPrintFormat.getItemCount() > 0)
				cboPrintFormat.setSelectedIndex(0);
			
			cboExportType.setMold("select");
			cboExportType.getItems().clear();			
			cboExportType.appendItem("ps" + " - " + Msg.getMsg(Env.getCtx(), "FilePS"), "ps");
			cboExportType.appendItem("xml" + " - " + Msg.getMsg(Env.getCtx(), "FileXML"), "xml");
			cboExportType.appendItem("pdf" + " - " + Msg.getMsg(Env.getCtx(), "FilePDF"), "pdf");
			cboExportType.appendItem("html" + " - " + Msg.getMsg(Env.getCtx(), "FileHTML"), "html");
			cboExportType.appendItem("txt" + " - " + Msg.getMsg(Env.getCtx(), "FileTXT"), "txt");
			cboExportType.appendItem("ssv" + " - " + Msg.getMsg(Env.getCtx(), "FileSSV"), "ssv");
			cboExportType.appendItem("csv" + " - " + Msg.getMsg(Env.getCtx(), "FileCSV"), "csv");
			cboExportType.appendItem("xlsx" + " - " + Msg.getMsg(Env.getCtx(), "FileXLSX"), "xlsx");
			ListItem li = cboExportType.appendItem("xls" + " - " + Msg.getMsg(Env.getCtx(), "FileXLS"), "xls");
			cboExportType.setSelectedItem(li);
			cboExportType.setVisible(false);
			
			chkCurrentRowOnly.setLabel(Msg.getMsg(Env.getCtx(), "CurrentRowOnly"));
			chkCurrentRowOnly.setSelected(false);
			
			if( isCanExport )
			{
				chkExport.setLabel(Msg.getMsg(Env.getCtx(), "Export"));
				chkExport.setSelected(false);
		    }
			
			chkAllColumns.setLabel(Msg.getMsg(Env.getCtx(), "AllColumns"));
			chkAllColumns.setSelected(false);
			li = cboPrintFormat.getSelectedItem();
			if (li != null && li.getValue() != null)
			{
				int AD_PrintFormat_ID = Integer.valueOf(li.getValue().toString());
				chkAllColumns.setVisible(AD_PrintFormat_ID == -1);
			}

			Div vb = new Div();
			ZkCssHelper.appendStyle(vb, "display: flex; flex-direction: column;");
			ZKUpdateUtil.setWidth(vb, "100%");
			ZKUpdateUtil.setHeight(vb, "200px");
			winReport.appendChild(vb);
			winReport.setSclass("toolbar-popup-window");
			vb.setSclass("toolbar-popup-window-cnt");
			
			Grid grid = GridFactory.newGridLayout();
			ZkCssHelper.appendStyle(grid, "flex-grow: 1;");
			vb.appendChild(grid);
	        
	        Columns columns = new Columns();
	        Column column = new Column();
	        column.setWidth("25%");
	        columns.appendChild(column);
	        column = new Column();
	        column.setWidth("75%");
	        columns.appendChild(column);
	        grid.appendChild(columns);
	        
	        Rows rows = new Rows();
			grid.appendChild(rows);
			
			Row row = new Row();
			rows.appendChild(row);
			row.appendChild(new Label(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID")));
			row.appendChild(cboPrintFormat);
			cboPrintFormat.setWidth("100%");
			cboPrintFormat.addEventListener(Events.ON_SELECT, this);
			
			row = new Row();
			rows.appendChild(row);
			row.appendChild(new Space());
			row.appendChild(chkCurrentRowOnly);

			if (isCanExport)
			{
				Panel panel = new Panel();
				panel.appendChild(chkExport);
				ZKUpdateUtil.setHflex(chkExport, "min");
				panel.appendChild(new Space());
				chkExport.addEventListener(Events.ON_CHECK, this);
				panel.appendChild(cboExportType);
				ZKUpdateUtil.setHflex(cboExportType, "1");
				ZKUpdateUtil.setHflex(panel, "1");
				
				row = new Row();
				rows.appendChild(row);
				row.appendChild(new Space());
				row.appendChild(panel);
			}
			
			row = new Row();
			rows.appendChild(row);
			row.appendChild(new Space());
			row.appendChild(chkAllColumns);

			vb.appendChild(confirmPanel);
			LayoutUtils.addSclass("dialog-footer", confirmPanel);
			confirmPanel.addActionListener(this);
			ZkCssHelper.appendStyle(confirmPanel, "flex-grow: 0;");
		}

		LabelImageElement toolbarItem = panel.getToolbar().getToolbarItem("Report");
		Popup popup = LayoutUtils.findPopup(toolbarItem);
		if (popup != null)
			popup.appendChild(winReport);
		LayoutUtils.openPopupWindow(toolbarItem, winReport, "after_start");
		winReport.setFocus(true);
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			winReport.onClose();
		else if(event.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			winReport.setVisible(false);
			Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
			Events.echoEvent("onValidate", winReport, null);
		}
		else if(event.getTarget() == cboPrintFormat)
		{
			ListItem li = cboPrintFormat.getSelectedItem();
			if (li != null && li.getValue() != null)
			{
				int AD_PrintFormat_ID = Integer.valueOf(li.getValue().toString());
				chkAllColumns.setVisible(AD_PrintFormat_ID == -1);
			}
		}
		else if(event.getTarget() == chkExport)
			cboExportType.setVisible(chkExport.isChecked());
		else if (event.getName().equals("onValidate")) {
			try {
				validate();
			} finally {
				Clients.clearBusy();
				panel.getComponent().invalidate();
			}
		}
	}
	
	private void validate()
	{
		ListItem li = cboPrintFormat.getSelectedItem();
		if(li == null || li.getValue() == null)
		{
			Dialog.error(0, "PrintFormatMandatory");
			return;
		}
		
		int AD_PrintFormat_ID = Integer.valueOf(li.getValue().toString());
		
		boolean export = chkExport.isChecked();		
		if (export)
		{
			li = cboExportType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				Dialog.error(0, "ExportFileTypeMandatory");
				return;
			}
		}		

		GridTab gridTab = panel.getActiveGridTab();

		//	Print Format
		boolean allColumns = chkAllColumns.isChecked();
		MPrintFormat pf = null;
		if (AD_PrintFormat_ID == -1)
			pf = MPrintFormat.createFromGridLayout(Env.getCtx(), gridTab, allColumns);
		else
			pf = MPrintFormat.get (Env.getCtx(), AD_PrintFormat_ID, true);
		
		//	Query
		boolean currentRowOnly = chkCurrentRowOnly.isChecked();
		int Record_ID = 0;
		List <Integer> RecordIDs = null;
		MQuery query = new MQuery(gridTab.getTableName());
		StringBuilder whereClause = new StringBuilder("");

		if (currentRowOnly)
		{
			Record_ID = gridTab.getRecord_ID();
			whereClause.append(gridTab.getTableModel().getWhereClause(gridTab.getCurrentRow()));
			if (whereClause.length() == 0)
				whereClause.append(gridTab.getTableModel().getSelectWhereClause());

		}
		else
		{
			whereClause.append(gridTab.getTableModel().getSelectWhereClause());
			RecordIDs = new ArrayList<Integer>();
			for(int i = 0; i < gridTab.getRowCount(); i++)
			{
				RecordIDs.add(gridTab.getKeyID(i));
			}
		}

		if (whereClause.length() > 0)
		{
			if (whereClause.indexOf("@") != -1) //replace variables in context
			{
				String context = Env.parseContext(Env.getCtx(), panel.getWindowNo(), whereClause.toString(), false);
				if(context != null && context.trim().length() > 0)
				{
					whereClause = new StringBuilder(context);
				}
				else
				{
					log.log(Level.WARNING, "Failed to parse where clause. whereClause= "+whereClause);
					whereClause = new StringBuilder("1 = 2");
				}
			}
		}

		if (!currentRowOnly && gridTab.isOnlyCurrentRows() && gridTab.getTabNo() == 0)
		{
			if (whereClause.length() > 0)
				whereClause.append(" AND ");
			//	Show only unprocessed or the one updated within x days
			whereClause.append("(").append(gridTab.getTableName()).append(".Processed='N' OR ").append(gridTab.getTableName()).append(".Updated>");
			whereClause.append("getDate()-1");
			whereClause.append(")");
		}

		query.addRestriction(whereClause.toString());

		PrintInfo info = new PrintInfo(pf.getName(), pf.getAD_Table_ID(), Record_ID);
		info.setDescription(query.getInfo());
		
		if(pf != null && pf.getJasperProcess_ID() > 0)
		{			
			// It's a report using the JasperReports engine
			ProcessInfo pi = new ProcessInfo ("", pf.getJasperProcess_ID(), pf.getAD_Table_ID(), Record_ID);
			pi.setRecord_IDs(RecordIDs);
			//pi.setIsBatch(true);
			
			if (export)
			{
				li = cboExportType.getSelectedItem();
				String ext = li.getValue().toString();
				pi.setExportFileExtension(ext);				
				pi.setExport(true);
				
				winReport.onClose();
				ServerProcessCtl.process(pi, null);
				
				try
				{
					File exportFile = pi.getExportFile();
					AMedia media = new AMedia(exportFile.getName() + "." + ext, null, "application/octet-stream", exportFile, true);
					Filedownload.save(media, exportFile.getName() + "." + ext);
				}
				catch (Exception e)
				{
					log.log(Level.SEVERE, "Failed to export content.", e);
				}
			}
			else
			{
				winReport.onClose();
				WProcessCtl.process(gridTab.getWindowNo(), pi, null);
			}
		}
		else
		{
			// It's a default report using the standard printing engine
			ReportEngine re = new ReportEngine (Env.getCtx(), pf, query, info, null, gridTab.getWindowNo());
			re.setWhereExtended(gridTab.getWhereExtended());
			
			if (export)
				export(re);
			else
				print(re);	
		}
	}
	
	private void print(ReportEngine re)
	{
		winReport.onClose();		
		ReportCtl.preview(re);
		Tabpanel tabPanel = (Tabpanel) panel.getComponent().getParent();
		tabPanel.getLinkedTab().setSelected(true);
	}
	
	private void export(ReportEngine re) 
	{
		try
		{
			ListItem li = cboExportType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				Dialog.error(0, "FileInvalidExtension");
				return;
			}
			
			String ext = li.getValue().toString();
			
			byte[] data = null;
			File inputFile = null;
									
			if (ext.equals("pdf"))
			{
				data = re.createPDFData();
			}
			else if (ext.equals("ps"))
			{
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				re.createPS(baos);
				data = baos.toByteArray();
			}
			else if (ext.equals("xml"))
			{
				StringWriter sw = new StringWriter();							
				re.createXML(sw);
				data = sw.getBuffer().toString().getBytes();
			}
			else if (ext.equals("csv"))
			{
				StringWriter sw = new StringWriter();							
				re.createCSV(sw, ',', re.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();
			}
			else if (ext.equals("ssv"))
			{
				StringWriter sw = new StringWriter();							
				re.createCSV(sw, ';', re.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();
			}
			else if (ext.equals("txt"))
			{
				StringWriter sw = new StringWriter();							
				re.createCSV(sw, '\t', re.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();							
			}
			else if (ext.equals("html") || ext.equals("htm"))
			{
				StringWriter sw = new StringWriter();							
				re.createHTML(sw, false, re.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();	
			}
			else if (ext.equals("xls"))
			{
				inputFile = File.createTempFile("Export", ".xls");							
				re.createXLS(inputFile, re.getPrintFormat().getLanguage());
			}
			else if (ext.equals("xlsx"))
			{
				inputFile = File.createTempFile("Export", ".xlsx");							
				re.createXLSX(inputFile, re.getPrintFormat().getLanguage());
			}
			else
			{
				Dialog.error(0, "FileInvalidExtension");
				return;
			}

			winReport.onClose();
			AMedia media = null;
			if (data != null)
				media = new AMedia(re.getPrintFormat().getName() + "." + ext, null, "application/octet-stream", data);
			else
				media = new AMedia(re.getPrintFormat().getName() + "." + ext, null, "application/octet-stream", inputFile, true);
			Filedownload.save(media, re.getPrintFormat().getName() + "." + ext);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Failed to export content.", e);
		}
	}
	
	private void getPrintFormats(int AD_Table_ID, int AD_Window_ID)
	{
		printFormatList.clear();
		
		printFormatList = MPrintFormat.getAccessiblePrintFormats(AD_Table_ID, AD_Window_ID, null, false);		

		int pfAD_Window_ID = MPrintFormat.getZoomWindowID(-1);
		if (MRole.getDefault().isTableAccess(MPrintFormat.Table_ID, false) && Boolean.TRUE.equals(MRole.getDefault().getWindowAccess(pfAD_Window_ID)))
		{
			StringBuffer sb = new StringBuffer("** ").append(Msg.getMsg(Env.getCtx(), "NewReport")).append(" **");
			KeyNamePair pp = new KeyNamePair(-1, sb.toString());
			printFormatList.add(pp);
		}
	}
}
