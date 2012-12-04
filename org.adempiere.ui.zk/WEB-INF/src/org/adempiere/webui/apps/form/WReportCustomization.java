/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Trek Global                                             *
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
package org.adempiere.webui.apps.form;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.StringWriter;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.panel.WRC1DisplayFieldsPanel;
import org.adempiere.webui.panel.WRC2FieldOrderPanel;
import org.adempiere.webui.panel.WRC3SortCriteriaPanel;
import org.adempiere.webui.panel.WRC4GroupingCriteriaPanel;
import org.adempiere.webui.panel.WRC5SummaryFieldsPanel;
import org.adempiere.webui.panel.WRCTabPanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.ZkReportViewer;
import org.adempiere.webui.window.ZkReportViewerProvider;
import org.compiere.model.MRole;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.ReportEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Auxhead;
import org.zkoss.zul.Auxheader;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Foot;
import org.zkoss.zul.Footer;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Vbox;


public class WReportCustomization  implements IFormController,EventListener<Event> {
	
	private CustomForm form = new CustomForm();	
	
	
	/** Window No					*/
	private int                 m_WindowNo = -1;
	
	int curStep = 0;
	/**	Print Context				*/
	private Properties			m_ctx;
	
	private boolean				m_isCanExport;
	
	private ReportEngine m_reportEngine=null;
	public MPrintFormatItem[] pfi ; 
	
	private Auxheader headerPanel=new Auxheader();
	private Listbox comboReport = new Listbox();
	private Button newPrintFormat;
	private Label selectAll;
	private Label deselectAll;
	private Label pipeSeparator;
	private ToolBarButton bExport = new ToolBarButton();
	private Button bnext ;
	private ToolBarButton btnSave;
	private Tabbox tabbox = new Tabbox();
	private Tabs tabs = new Tabs();
	private Tabpanels tabpanels = new Tabpanels(); 
	private Window winExportFile = null;
	private Listbox cboType = new Listbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private ConfirmPanel confirmPanelMain = new ConfirmPanel(true);
	public boolean isChange=false;
	public ZkReportViewer viewer;
	MPrintFormat fm;
	

	Tab tabdf1=new Tab(Msg.getMsg(Env.getCtx(), "DisplayFields"));
	Tab tabfo2=new Tab(Msg.getMsg(Env.getCtx(), "FieldOrder"));
	Tab tabsc3=new Tab(Msg.getMsg(Env.getCtx(), "SortCriteria"));
	Tab tabgc4=new Tab(Msg.getMsg(Env.getCtx(), "GroupingCriteria"));
	Tab tabsf5=new Tab(Msg.getMsg(Env.getCtx(), "SummaryFields"));

	WRC1DisplayFieldsPanel tpdf1 = new WRC1DisplayFieldsPanel();
	WRC2FieldOrderPanel tpfo2 =new WRC2FieldOrderPanel();
	WRC3SortCriteriaPanel tpsc3=new WRC3SortCriteriaPanel();
	WRC4GroupingCriteriaPanel tpgc4=new WRC4GroupingCriteriaPanel();
	WRC5SummaryFieldsPanel tpsf5=new WRC5SummaryFieldsPanel();

	private int oldtabidx = 0;
	
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(WReportCustomization.class);

	/**
	 * 	Static Layout
	 * 	@throws Exception
	 */
	public WReportCustomization() {
		super();

		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
	}
		
	/**
	 * 	Static Layout
	 * 	@throws Exception
	 */
	public void setReportEngine(ReportEngine re) {

		m_reportEngine = re;
		m_isCanExport=MRole.getDefault().isCanExport();
		pfi= m_reportEngine.getPrintFormat().getAllItems("IsPrinted DESC, NULLIF(SeqNo,0), Name");
		try
		{
			m_ctx = m_reportEngine.getCtx();
			init();
		}
 		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
			FDialog.error(m_WindowNo, "LoadError", e.getLocalizedMessage());
		}
	}
	
	private void init() 
	{

		form.setStyle("width: 90%; height: 90%; position: absolute; border:none; padding:none; margin:none;");

		headerPanel.setHeight("40px");
		headerPanel.setWidth("100%");

		headerPanel.appendChild(new Separator("vertical"));

		comboReport.setMold("select");
		fm =m_reportEngine.getPrintFormat();
		comboReport.setTooltiptext(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID"));
		comboReport.appendItem(fm.getName(), fm.get_ID());
		headerPanel.appendChild(comboReport);
		headerPanel.appendChild(new Separator("vertical"));

		newPrintFormat=new Button();
		newPrintFormat.setName("NewPrintFormat");
		newPrintFormat.setLabel(Msg.getMsg(Env.getCtx(), "CreatePrintFormat"));
		newPrintFormat.addActionListener(this);

		headerPanel.appendChild(newPrintFormat);
		Separator tor =new Separator("vertical");
		tor.setSpacing("23%");
		headerPanel.appendChild(tor);

		selectAll = new Label(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "SelectAll")));
		deselectAll= new Label(Msg.getMsg(Env.getCtx(), "DeSelectAll"));
		pipeSeparator = new Label("|");
		selectAll.setAttribute("name", "SelectAll");
		deselectAll.setAttribute("name", "DeselectAll");
		selectAll.addEventListener(Events.ON_CLICK, this);
		deselectAll.addEventListener(Events.ON_CLICK, this);
		headerPanel.appendChild(new Separator("vertical"));
		headerPanel.appendChild(selectAll);
		headerPanel.appendChild(new Separator("vertical"));
		headerPanel.appendChild(pipeSeparator);
		headerPanel.appendChild(new Separator("vertical"));
		headerPanel.appendChild(deselectAll);
		headerPanel.appendChild(new Separator("vertical"));

		Auxhead head=new Auxhead();
		head.appendChild(headerPanel);
		form.appendChild(head);

		headerPanel.appendChild(new Separator("horizontal"));

		tabbox.setWidth("100%");
		tabbox.setHeight("87%");
		tabfo2.addEventListener(Events.ON_CLICK, this);
		tabsc3.addEventListener(Events.ON_CLICK, this);
		tabgc4.addEventListener(Events.ON_CLICK, this);
		tabsf5.addEventListener(Events.ON_CLICK, this);
		tabs.appendChild(tabdf1);
		tabs.appendChild(tabfo2);
		tabs.appendChild(tabsc3);
		tabs.appendChild(tabgc4);
		tabs.appendChild(tabsf5);

		tpdf1.setMPrintFormat(fm);
		tpdf1.setPrintFormatItems(pfi);
		tpdf1.setWReportCustomization(this);
		tpdf1.init();
		tabpanels.appendChild(tpdf1);

		tpfo2.setMPrintFormat(fm);
		tpfo2.setPrintFormatItems(pfi);
		tpfo2.setListColumns();		
		tpfo2.init();
		tpfo2.refresh();
		tpfo2.setWReportCustomization(this);
		tabpanels.appendChild(tpfo2);

		tpsc3.setMPrintFormat(fm);
		tpsc3.setPrintFormatItems(pfi);
		tpsc3.init();	
		tpsc3.refresh();
		tpsc3.setWReportCustomization(this);
		tabpanels.appendChild(tpsc3);

		tpgc4.setMPrintFormat(fm);
		tpgc4.setPrintFormatItems(pfi);		
		tpgc4.init();
		tpgc4.refresh();
		tpgc4.setWReportCustomization(this);
		tabpanels.appendChild(tpgc4);

		tpsf5.setMPrintFormat(fm);
		tpsf5.setPrintFormatItems(pfi);		
		tpsf5.init();
		tpsf5.refresh();
		tpsf5.setWReportCustomization(this);
		tabpanels.appendChild(tpsf5);

		tabbox.appendChild(tabs);
		tabbox.appendChild(tabpanels);
		tabbox.addEventListener(Events.ON_SELECT, this);

		form.appendChild(tabbox);

		Footer foot =new Footer();
		Foot f=new Foot();

		Grid grid=new Grid();
		btnSave = new ToolBarButton();
		btnSave.setAttribute("name","btnSave");
		btnSave.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Save")));
		btnSave.setImage("/images/Save24.png");
		if(fm.getAD_Client_ID()== 0 || !isChange)
		{	
			btnSave.setDisabled(true);
		}   
		btnSave.addEventListener(Events.ON_CLICK, this);

		foot.appendChild(btnSave);
		foot.appendChild(new Separator("vertical"));

		if (m_isCanExport)
		{
			bExport.setImage("/images/ExportX24.png");
			bExport.setAttribute("name","btnExport");
			bExport.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Export")));
			bExport.addEventListener(Events.ON_CLICK, this);

			foot.appendChild(bExport);
			foot.appendChild(new Separator("vertical"));
		}

		bnext=new Button();
		bnext.setLabel(Msg.getMsg(Env.getCtx(), "NextPage"));
		bnext.setName("Next");
		bnext.addEventListener(Events.ON_CLICK, this);
		foot.appendChild(bnext);
		Vbox vb = new Vbox();
		vb.setWidth("50%");
		foot.appendChild(vb);
		vb.appendChild(confirmPanelMain);
		confirmPanelMain.addActionListener(this);
		confirmPanelMain.setVflex("0");
		
		f.appendChild(foot);
		grid.appendChild(f);
		form.appendChild(grid);
		form.setBorder("normal");
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CLICK.equals(event.getName())) {
			if (event.getTarget() instanceof ToolBarButton) {
				((WRCTabPanel) tabbox.getSelectedTabpanel()).updatePFI();
				ToolBarButton button = (ToolBarButton)event.getTarget();
				if ("btnSave".equals(button.getAttribute("name").toString())) {
					onSave();
				}
				if ("btnExport".equals(button.getAttribute("name").toString())) {
					cmd_export();
				}
			} else if (event.getTarget() instanceof Label) {
				if (tabbox.getSelectedIndex() == 0) {
					Label lb = (Label)event.getTarget();
					if ("SelectAll".equals(lb.getAttribute("name").toString())) {
						tpdf1.updatePrinted(true);
					} else if ("DeselectAll".equals(lb.getAttribute("name").toString())) {
						tpdf1.updatePrinted(false);
					}
				}
			} else if (event.getTarget() instanceof Button) {
				Button bt = (Button)event.getTarget();
				if ("Next".equals(bt.getName())) {
					((WRCTabPanel) tabbox.getTabpanel(oldtabidx)).updatePFI();
					oldtabidx++;
					if (oldtabidx > 4)
						oldtabidx = 0;
					((WRCTabPanel) tabbox.getTabpanel(oldtabidx)).refresh();
					tabbox.setSelectedIndex(oldtabidx);
				}
				else{
					if("NewPrintFormat".equals(bt.getName())){
						copyFormat();
					}
				}
			}
		} else {
			if (Events.ON_SELECT.equals(event.getName())) {
				// Save previous tab and refresh the new
				((WRCTabPanel) tabbox.getTabpanel(oldtabidx)).updatePFI();
				int tabidx = tabbox.getSelectedIndex();
				((WRCTabPanel) tabbox.getTabpanel(tabidx )).refresh();
				oldtabidx = tabidx;
			}
		}
		if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL)){
			close();
		}else if (event.getTarget().getId().equals(ConfirmPanel.A_OK)){			
			((WRCTabPanel) tabbox.getSelectedTabpanel()).updatePFI();
			onSave();
			close();
	    } 
		selectAll.setVisible(oldtabidx == 0);
		deselectAll.setVisible(oldtabidx == 0);
		pipeSeparator.setVisible(oldtabidx == 0);
	}

	private void onSave() {
		for (int i=0; i < pfi.length ;i++){
			pfi[i].saveEx();
		}
		setIsChanged(false);
	}
	
	@Override
	public ADForm getForm() {
		return form;
	}

	/**
	 * 	Export
	 */
	private void cmd_export()
	{		
		log.config("");
		if (!m_isCanExport)
		{
			FDialog.error(m_WindowNo, "AccessCannotExport","Export");
			return;
		}
		
		if (winExportFile == null)
		{
			winExportFile = new Window();
			winExportFile.setTitle(Msg.getMsg(Env.getCtx(), "Export"));
			winExportFile.setWidth("450px");
			winExportFile.setHeight("300px");
			winExportFile.setClosable(true);
			winExportFile.setBorder("normal");
			winExportFile.setStyle("position:absolute");

			cboType.setMold("select");
			
			cboType.getItems().clear();			
			cboType.appendItem("ps" + " - " + Msg.getMsg(Env.getCtx(), "FilePS"), "ps");
			cboType.appendItem("xml" + " - " + Msg.getMsg(Env.getCtx(), "FileXML"), "xml");
			ListItem li = cboType.appendItem("pdf" + " - " + Msg.getMsg(Env.getCtx(), "FilePDF"), "pdf");
			cboType.appendItem("html" + " - " + Msg.getMsg(Env.getCtx(), "FileHTML"), "html");
			cboType.appendItem("txt" + " - " + Msg.getMsg(Env.getCtx(), "FileTXT"), "txt");
			cboType.appendItem("ssv" + " - " + Msg.getMsg(Env.getCtx(), "FileSSV"), "ssv");
			cboType.appendItem("csv" + " - " + Msg.getMsg(Env.getCtx(), "FileCSV"), "csv");
			cboType.appendItem("xls" + " - " + Msg.getMsg(Env.getCtx(), "FileXLS"), "xls");
			cboType.setSelectedItem(li);
			
			Hbox hb = new Hbox();
			Div div = new Div();
			div.setAlign("right");
			div.appendChild(new Label(Msg.getMsg(Env.getCtx(), "FilesOfType")));
			hb.appendChild(div);
			hb.appendChild(cboType);
			cboType.setWidth("100%");
			hb.setVflex("1");
			hb.setStyle("margin-top: 10px");

			Vbox vb = new Vbox();
			vb.setVflex("1");
			vb.setWidth("100%");
			winExportFile.appendChild(vb);
			vb.appendChild(hb);
			vb.appendChild(confirmPanel);
			EventListener<Event> exportListener= new EventListener<Event>()
			{
				public void onEvent(Event event) throws Exception {
					if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
						winExportFile.onClose();
					else if (event.getTarget().getId().equals(ConfirmPanel.A_OK))			
						exportFile();
				}
			};
			confirmPanel.addActionListener(exportListener);
			confirmPanel.setVflex("0");
		}
		winExportFile.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showWindow(winExportFile);
	}	//	cmd_export

	private void exportFile()
	{
		try
		{
			ListItem li = cboType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				FDialog.error(m_WindowNo, winExportFile, "FileInvalidExtension");
				return;
			}
			
			String ext = li.getValue().toString();
			
			byte[] data = null;
			File inputFile = null;
									
			if (ext.equals("pdf"))
			{
				data = m_reportEngine.createPDFData();
			}
			else if (ext.equals("ps"))
			{
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				m_reportEngine.createPS(baos);
				data = baos.toByteArray();
			}
			else if (ext.equals("xml"))
			{
				StringWriter sw = new StringWriter();							
				m_reportEngine.createXML(sw);
				data = sw.getBuffer().toString().getBytes();
			}
			else if (ext.equals("csv") || ext.equals("ssv"))
			{
				StringWriter sw = new StringWriter();							
				m_reportEngine.createCSV(sw, ',', m_reportEngine.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();
			}
			else if (ext.equals("txt"))
			{
				StringWriter sw = new StringWriter();							
				m_reportEngine.createCSV(sw, '\t', m_reportEngine.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();							
			}
			else if (ext.equals("html") || ext.equals("htm"))
			{
				StringWriter sw = new StringWriter();							
				m_reportEngine.createHTML(sw, false, m_reportEngine.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();	
			}
			else if (ext.equals("xls"))
			{
				inputFile = File.createTempFile("Export", ".xls");							
				m_reportEngine.createXLS(inputFile, m_reportEngine.getPrintFormat().getLanguage());
			}
			else
			{
				FDialog.error(m_WindowNo, winExportFile, "FileInvalidExtension");
				return;
			}

			winExportFile.onClose();
			AMedia media = null;
			if (data != null)
				media = new AMedia(m_reportEngine.getPrintFormat().getName() + "." + ext, null, "application/octet-stream", data);
			else
				media = new AMedia(m_reportEngine.getPrintFormat().getName() + "." + ext, null, "application/octet-stream", inputFile, true);
			Filedownload.save(media, m_reportEngine.getPrintFormat().getName() + "." + ext);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Failed to export content.", e);
		}
	}

	public void close()
	{	
		form.detach();
	}

	public void copyFormat(){
		MPrintFormat newpf=MPrintFormat.copyToClient(m_ctx, m_reportEngine.getPrintFormat().get_ID() ,Env.getAD_Client_ID(m_ctx));
		pfi = newpf.getAllItems("IsPrinted DESC, NULLIF(SeqNo,0), Name");

		tpdf1.setMPrintFormat(newpf);
		tpdf1.setPrintFormatItems(pfi);
		tpdf1.refresh();

		tpfo2.setMPrintFormat(newpf);
		tpfo2.setPrintFormatItems(pfi);
		tpfo2.setListColumns();		
		tpfo2.refresh();

		tpsc3.setMPrintFormat(newpf);
		tpsc3.setPrintFormatItems(pfi);
		tpsc3.refresh();

		tpgc4.setMPrintFormat(newpf);
		tpgc4.setPrintFormatItems(pfi);		

		tpsf5.setMPrintFormat(newpf);
		tpsf5.setPrintFormatItems(pfi);		
		tpsf5.refresh();
		setIsChanged(false);

		comboReport.removeAllItems();
		comboReport.appendItem(newpf.getName(), newpf.get_ID());
		m_reportEngine.setPrintFormat(newpf);
	}

	 public void setIsChanged(boolean change){
		 isChange=change;
		 
		 btnSave.setDisabled(!isChange);
		 bExport.setDisabled(isChange);
		 newPrintFormat.setDisabled(isChange);
	 }
}
