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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.model.GenericPO;
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
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WStringEditor;
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
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.ZkReportViewer;
import org.compiere.model.MRole;
import org.compiere.model.Query;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.ReportEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Foot;
import org.zkoss.zul.Footer;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Vbox;


@org.idempiere.ui.zk.annotation.Form
public class WReportCustomization  implements IFormController,EventListener<Event> {
	
	private CustomForm form = new CustomForm();	
	
	
	/** Window No					*/
	private int                 m_WindowNo = -1;
	
	int curStep = 0;
	/**	Print Context				*/
	private Properties			m_ctx;
	
	private boolean				m_isCanExport;
	
	private ReportEngine m_reportEngine=null;
	public ArrayList<MPrintFormatItem> pfi ; 
	
	private Hlayout headerPanel=new Hlayout();
	private WStringEditor name = new WStringEditor();
	private String tempName = "";
	private Button newPrintFormat;
	private Label selectAll;
	private Label deselectAll;
	private Label pipeSeparator;
	private Button bExport = new Button();
	private Button bnext ;
	private Button btnSave;
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
	private static final CLogger log = CLogger.getCLogger(WReportCustomization.class);

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
	    pfi = new ArrayList<MPrintFormatItem>() ;
		for (MPrintFormatItem item :  m_reportEngine.getPrintFormat().getAllItems("IsPrinted DESC, NULLIF(SeqNo,0), Name")) {
			pfi.add(item);	
		}
		
		try
		{
			m_ctx = m_reportEngine.getCtx();
			init();
		}
 		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
			Dialog.error(m_WindowNo, "LoadError", e.getLocalizedMessage());
		}
	}
	
	private void init() 
	{

		form.setStyle("width: 90%; height: 90%; position: absolute; border:none; padding:none; margin:none;");

		//ZKUpdateUtil.setHeight(headerPanel, "40px");
		//headerPanel.setWidth("100%"); 

		headerPanel.appendChild(new Separator("vertical"));

		fm = new MPrintFormat(m_ctx, m_reportEngine.getPrintFormat().getAD_PrintFormat_ID(), null);
		name.setValue(fm.getName());

		if (Env.isMultiLingualDocument(m_ctx))
			name.setValue(fm.get_Translation("Name"));
		else
			name.setValue(fm.getName());

		headerPanel.appendChild(name.getComponent());
		headerPanel.appendChild(new Separator("vertical"));
		ZKUpdateUtil.setHflex(name.getComponent(), "1");
		
		name.getComponent().addEventListener(Events.ON_FOCUS, this);	
		name.getComponent().addEventListener(Events.ON_BLUR, this);	
		name.getComponent().addEventListener(Events.ON_OK, this);

		newPrintFormat=new Button();
		newPrintFormat.setName("NewPrintFormat");
		newPrintFormat.setLabel(Msg.getMsg(Env.getCtx(), "CreatePrintFormat"));
		newPrintFormat.addActionListener(this);

		headerPanel.appendChild(newPrintFormat);
		headerPanel.setValign("middle");

		selectAll = new Label(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "SelectAll")));
		selectAll.setStyle("cursor:pointer;text-decoration: underline;");
		deselectAll= new Label(Msg.getMsg(Env.getCtx(), "DeSelectAll"));
		deselectAll.setStyle("cursor:pointer;text-decoration: underline;");
		pipeSeparator = new Label("|");
		selectAll.setAttribute("name", "SelectAll");
		deselectAll.setAttribute("name", "DeselectAll");
		selectAll.addEventListener(Events.ON_CLICK, this);
		deselectAll.addEventListener(Events.ON_CLICK, this);
		Separator sep = new Separator("vertical");
		sep.setHflex("1");
		headerPanel.appendChild(sep);
		headerPanel.appendChild(selectAll);
		headerPanel.appendChild(new Separator("vertical"));
		headerPanel.appendChild(pipeSeparator);
		headerPanel.appendChild(new Separator("vertical"));
		headerPanel.appendChild(deselectAll);
		headerPanel.appendChild(new Separator("vertical"));

		form.appendChild(headerPanel);
		headerPanel.setHflex("1");

		form.appendChild(new Separator("horizontal"));

		ZKUpdateUtil.setWidth(tabbox, "100%");		
		ZKUpdateUtil.setHeight(tabbox, "84%");//IDEMPIERE-2476, Pritesh Shah
		
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
		tpsc3.setListsColumns(); 
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
		btnSave = new Button();
		btnSave.setName("btnSave");
		btnSave.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Save")));
		//devCoffee #6142
		if (ThemeManager.isUseFontIconForImage())
			btnSave.setIconSclass("z-icon-Save");
		else
			btnSave.setImage(ThemeManager.getThemeResource("images/Save24.png"));
		if(fm.getAD_Client_ID()== 0 || !isChange)
		{	
			btnSave.setDisabled(true);
		}   
		
		foot.setSclass("report-wizard-footer");//IDEMPIERE-2476, Pritesh Shah
		
		confirmPanelMain.addComponentsLeft(btnSave);

		if (m_isCanExport)
		{
			//devCoffee #6142
			if (ThemeManager.isUseFontIconForImage())
				bExport.setIconSclass("z-icon-Export");
			else
				bExport.setImage(ThemeManager.getThemeResource("images/Export24.png"));
			bExport.setName("btnExport");
			bExport.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Export")));
			confirmPanelMain.addComponentsLeft(bExport);
		}

		bnext=new Button();
		bnext.setLabel(Msg.getMsg(Env.getCtx(), "NextPage"));
		bnext.setName("Next");
		confirmPanelMain.addComponentsLeft(bnext);
		
		foot.appendChild(confirmPanelMain);
		confirmPanelMain.addActionListener(this);
		ZKUpdateUtil.setVflex(confirmPanelMain, "0");
		
		f.appendChild(foot);
		grid.appendChild(f);
		form.appendChild(grid);
		form.setBorder("normal");
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CLICK.equals(event.getName())) {
			if (event.getTarget() instanceof Label) {
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
				else if ("btnSave".equals(bt.getName())) {
					((WRCTabPanel) tabbox.getSelectedTabpanel()).updatePFI();
					onSave();
				}
				else if ("btnExport".equals(bt.getName())) {
					((WRCTabPanel) tabbox.getSelectedTabpanel()).updatePFI();
					cmd_export();
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

		if (event.getTarget() == name.getComponent()) {
			if (event.getName().equals(Events.ON_FOCUS))
				tempName = (String) name.getValue();
			else if (event.getName().equals(Events.ON_BLUR) || event.getName().equals(Events.ON_OK)) {
				if (!tempName.equals(name.getValue()))
					setIsChanged(true);
			}
		}

		selectAll.setVisible(oldtabidx == 0);
		deselectAll.setVisible(oldtabidx == 0);
		pipeSeparator.setVisible(oldtabidx == 0);
	}

	private void onSave() {

		if (name.getValue() == null || Util.isEmpty((String) name.getValue()))
			throw new WrongValueException(name.getComponent(), Msg.getMsg(m_ctx, "FillMandatory"));

		if (Env.isMultiLingualDocument(m_ctx)) {
			if (Env.isBaseLanguage(m_ctx, "AD_PrintFormat")) {
				if (!fm.getName().equals(name.getValue())) {
					fm.setName((String) name.getValue());
					fm.saveEx();
					tempName = (String) name.getValue();
				}
			} else {
				if (!fm.get_Translation("Name").equals(name.getValue())) {
					updateTrl();
					tempName = (String) name.getValue();
				}
			}
		} else {
			if (!fm.getName().equals(name.getValue())) {
				fm.setName((String) name.getValue());
				fm.saveEx();
				updateTrl();
				tempName = (String) name.getValue();
			}
		}

		for (MPrintFormatItem item : pfi)
			if (item.is_Changed())
				item.saveEx();

		setIsChanged(false);
	}

	private void updateTrl()
	{
		List<GenericPO> list = new Query(m_ctx, "AD_PrintFormat_Trl", "AD_PrintFormat_ID = ?", null)
		.setParameters(fm.getAD_PrintFormat_ID())
		.list();
		for (GenericPO trl : list) {
			trl.set_ValueOfColumn("Name", (String) name.getValue());
			trl.saveEx();

			fm.get_Translation("Name", trl.get_ValueAsString("AD_Language"), true); // reload
		}
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
			Dialog.error(m_WindowNo, "AccessCannotExport","Export");
			return;
		}
		
		if (winExportFile == null)
		{
			winExportFile = new Window();
			winExportFile.setTitle(Msg.getMsg(Env.getCtx(), "Export"));
			ZKUpdateUtil.setWindowWidthX(winExportFile, 450);
			ZKUpdateUtil.setWindowHeightX(winExportFile, 300);
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
			cboType.appendItem("xlsx" + " - " + Msg.getMsg(Env.getCtx(), "FileXLSX"), "xlsx");
			cboType.setSelectedItem(li);
			
			Hbox hb = new Hbox();
			Div div = new Div();
			div.setStyle("text-align: right;");
			div.appendChild(new Label(Msg.getMsg(Env.getCtx(), "FilesOfType")));
			hb.appendChild(div);
			hb.appendChild(cboType);
			ZKUpdateUtil.setWidth(cboType, "100%");
			ZKUpdateUtil.setVflex(hb, "1");
			hb.setStyle("margin-top: 10px");

			Vbox vb = new Vbox();
			ZKUpdateUtil.setVflex(vb, "1");
			ZKUpdateUtil.setWidth(vb, "100%");
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
			ZKUpdateUtil.setVflex(confirmPanel, "0");
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
				Dialog.error(m_WindowNo, "FileInvalidExtension");
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
			else if (ext.equals("csv"))
			{
				StringWriter sw = new StringWriter();							
				m_reportEngine.createCSV(sw, ',', m_reportEngine.getPrintFormat().getLanguage());
				data = sw.getBuffer().toString().getBytes();
			}
			else if (ext.equals("ssv"))
			{
				StringWriter sw = new StringWriter();							
				m_reportEngine.createCSV(sw, ';', m_reportEngine.getPrintFormat().getLanguage());
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
			else if (ext.equals("xlsx"))
			{
				inputFile = File.createTempFile("Export", ".xlsx");							
				m_reportEngine.createXLSX(inputFile, m_reportEngine.getPrintFormat().getLanguage());
			}
			else
			{
				Dialog.error(m_WindowNo, "FileInvalidExtension");
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
		pfi.clear();
		MPrintFormat newpf=MPrintFormat.copyToClient(m_ctx, m_reportEngine.getPrintFormat().get_ID() ,Env.getAD_Client_ID(m_ctx));
			
		for (MPrintFormatItem item : newpf.getAllItems("IsPrinted DESC, NULLIF(SeqNo,0), Name"))
		     pfi.add(item);	
			
		tpdf1.setMPrintFormat(newpf);
		tpdf1.setPrintFormatItems(pfi);
		tpdf1.refresh();

		tpfo2.setMPrintFormat(newpf);
		tpfo2.setPrintFormatItems(pfi);
		tpfo2.setListColumns();		
		tpfo2.refresh();

		tpsc3.setMPrintFormat(newpf);
		tpsc3.setPrintFormatItems(pfi);
		tpfo2.setListColumns();	
		tpsc3.refresh();

		tpgc4.setMPrintFormat(newpf);
		tpgc4.setPrintFormatItems(pfi);		

		tpsf5.setMPrintFormat(newpf);
		tpsf5.setPrintFormatItems(pfi);		
		tpsf5.refresh();
		setIsChanged(false);

		name.setValue(newpf.getName());
		m_reportEngine.setPrintFormat(newpf);

		newpf.saveEx();
		fm = newpf;
	}

	 public void setIsChanged(boolean change){
		 isChange=change;
		 
		 btnSave.setDisabled(!isChange);
		 bExport.setDisabled(isChange);
		 newPrintFormat.setDisabled(isChange);
	 }
}
