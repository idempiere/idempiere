package org.adempiere.webui.panel.action;

import static org.compiere.model.SystemIDs.WINDOW_PRINTFORMAT;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.StringWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import javax.sql.RowSet;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.WProcessCtl;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.AbstractADWindowPanel;
import org.adempiere.webui.window.FDialog;
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
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Vbox;

public class ReportAction implements EventListener<Event>
{
	private static CLogger log = CLogger.getCLogger(ReportAction.class);
	
	private AbstractADWindowPanel panel;
	
	private Window winReport = null;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Listbox cboPrintFormat = new Listbox();
	private Listbox cboExportType = new Listbox();
	private Checkbox chkCurrentRowOnly = new Checkbox();
	private Checkbox chkExport = new Checkbox();
	private Checkbox chkAllColumns = new Checkbox();
	
	private ArrayList<KeyNamePair>	printFormatList = new ArrayList<KeyNamePair>();

	public ReportAction(AbstractADWindowPanel panel)
	{
		this.panel = panel;		
		getPrintFormats(panel.getActiveGridTab().getAD_Table_ID());
	}
	
	public void show() 
	{
		if(winReport == null)
		{
			winReport = new Window();
			winReport.setTitle(Msg.getMsg(Env.getCtx(), "Export") + ": " + panel.getActiveGridTab().getName());
			winReport.setWidth("450px");
			winReport.setClosable(true);
			winReport.setBorder("normal");
			winReport.setStyle("position:absolute");
			
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
			ListItem li = cboExportType.appendItem("xls" + " - " + Msg.getMsg(Env.getCtx(), "FileXLS"), "xls");
			cboExportType.setSelectedItem(li);
			cboExportType.setVisible(false);
			
			chkCurrentRowOnly.setLabel(Msg.getMsg(Env.getCtx(), "CurrentRowOnly"));
			chkCurrentRowOnly.setSelected(false);

			chkExport.setLabel(Msg.getMsg(Env.getCtx(), "Export"));
			chkExport.setSelected(false);

			chkAllColumns.setLabel(Msg.getMsg(Env.getCtx(), "AllColumns"));
			chkAllColumns.setSelected(false);
			chkAllColumns.setVisible(false);

			Vbox vb = new Vbox();
			vb.setWidth("100%");
			winReport.appendChild(vb);

			Hbox hb = new Hbox();
			hb.setAlign("center");
			Div div = new Div();
			div.appendChild(new Label(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID")));
			hb.appendChild(div);
			hb.appendChild(cboPrintFormat);
			cboPrintFormat.setWidth("100%");
			cboPrintFormat.addEventListener(Events.ON_SELECT, this);
			vb.appendChild(hb);

			vb.appendChild(chkCurrentRowOnly);
			
			hb = new Hbox();
			hb.setAlign("center");
			hb.appendChild(chkExport);
			chkExport.addEventListener(Events.ON_CHECK, this);
			hb.appendChild(cboExportType);
			cboExportType.setWidth("100%");
			vb.appendChild(hb);
			
			vb.appendChild(chkAllColumns);

			vb.appendChild(confirmPanel);
			confirmPanel.addActionListener(this);
		}

		winReport.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showWindow(winReport);
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			winReport.onClose();
		else if(event.getTarget().getId().equals(ConfirmPanel.A_OK))
			validate();
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
	}
	
	private void validate()
	{
		ListItem li = cboPrintFormat.getSelectedItem();
		if(li == null || li.getValue() == null)
		{
			FDialog.error(0, winReport, "PrintFormatMandatory");
			return;
		}
		
		int AD_PrintFormat_ID = Integer.valueOf(li.getValue().toString());
		
		boolean export = chkExport.isChecked();		
		if (export)
		{
			li = cboExportType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				FDialog.error(0, winReport, "ExportFileTypeMandatory");
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
		int[] RecordIDs = null;
		MQuery query = new MQuery(gridTab.getTableName());
		if (currentRowOnly)
		{
			Record_ID = gridTab.getRecord_ID();
			query.addRestriction(query.getTableName() + "_ID", MQuery.EQUAL, Record_ID);
		}
		else
		{
			RecordIDs = new int[gridTab.getRowCount()];
			for(int i = 0; i < gridTab.getRowCount(); i++)
			{
				RecordIDs[i] = gridTab.getKeyID(i);
				query.addRestriction(query.getTableName() + "." + query.getTableName() + "_ID" + MQuery.EQUAL + RecordIDs[i], false, 0);
			}
		}
				
		PrintInfo info = new PrintInfo(pf.getName(), pf.getAD_Table_ID(), Record_ID);
		info.setDescription(query.getInfo());
		
		if(pf != null && pf.getJasperProcess_ID() > 0)
		{			
			// It's a report using the JasperReports engine
			ProcessInfo pi = new ProcessInfo ("", pf.getJasperProcess_ID(), pf.getAD_Table_ID(), Record_ID);
			pi.setRecord_IDs(RecordIDs);
			pi.setIsBatch(true);
			
			if (export)
			{
				li = cboExportType.getSelectedItem();
				String ext = li.getValue().toString();
				pi.setExportFileExtension(ext);				
				pi.setExport(true);
				
				winReport.onClose();
				ServerProcessCtl.process(null, pi, null);
				
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
			ReportEngine re = new ReportEngine (Env.getCtx(), pf, query, info);
			re.setWhereExtended(gridTab.getWhereExtended());
			re.setWindowNo(gridTab.getWindowNo());
			
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
	}
	
	private void export(ReportEngine re) 
	{
		try
		{
			ListItem li = cboExportType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				FDialog.error(0, winReport, "FileInvalidExtension");
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
			else if (ext.equals("csv") || ext.equals("ssv"))
			{
				StringWriter sw = new StringWriter();							
				re.createCSV(sw, ',', re.getPrintFormat().getLanguage());
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
			else
			{
				FDialog.error(0, winReport, "FileInvalidExtension");
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
	
	private void getPrintFormats(int AD_Table_ID)
	{
		printFormatList.clear();
		
		int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		RowSet rowSet = MPrintFormat.getAccessiblePrintFormats(AD_Table_ID, -1, null);
		KeyNamePair pp = null;
		try
		{
			while (rowSet.next())
			{
				pp = new KeyNamePair (rowSet.getInt(1), rowSet.getString(2));
				if (rowSet.getInt(3) == AD_Client_ID)
				{
					printFormatList.add(pp);
				}
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
		
		if (MRole.getDefault().isTableAccess(MPrintFormat.Table_ID, false) && MRole.getDefault().getWindowAccess(WINDOW_PRINTFORMAT))
		{
			StringBuffer sb = new StringBuffer("** ").append(Msg.getMsg(Env.getCtx(), "NewReport")).append(" **");
			pp = new KeyNamePair(-1, sb.toString());
			printFormatList.add(pp);
		}
	}
}
