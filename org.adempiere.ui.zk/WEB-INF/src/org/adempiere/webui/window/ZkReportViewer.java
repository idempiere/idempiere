/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2007 Low Heng Sin hengsin@avantz.com
 * _____________________________________________
 *****************************************************************************/
package org.adempiere.webui.window;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;
import java.util.TreeMap;
import java.util.logging.Level;

import javax.activation.FileDataSource;
import javax.servlet.http.HttpServletRequest;

import org.adempiere.base.Core;
import org.adempiere.base.upload.IUploadService;
import org.adempiere.exceptions.DBException;
import org.adempiere.pdf.Document;
import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.Extensions;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialog;
import org.adempiere.webui.apps.ProcessDialog;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.apps.WReport;
import org.adempiere.webui.apps.form.WReportCustomization;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.ProcessInfoDialog;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.DrillEvent;
import org.adempiere.webui.event.DrillEvent.DrillData;
import org.adempiere.webui.event.ZoomEvent;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.StatusBarPanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.IServerPushCallback;
import org.adempiere.webui.util.ServerPushTemplate;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.util.ZkContextRunnable;
import org.compiere.model.GridField;
import org.compiere.model.MArchive;
import org.compiere.model.MAttachment;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.model.MClient;
import org.compiere.model.MLanguage;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MToolBarButtonRestrict;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.PrintInfo;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_AD_ToolBarButton;
import org.compiere.print.ArchiveEngine;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.print.ServerReportCtl;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.print.renderer.CSVReportRendererConfiguration;
import org.idempiere.print.renderer.HTMLReportRendererConfiguration;
import org.idempiere.print.renderer.PDFReportRendererConfiguration;
import org.idempiere.print.renderer.XLSReportRendererConfiguration;
import org.idempiere.print.renderer.XLSXReportRendererConfiguration;
import org.idempiere.ui.zk.media.IMediaView;
import org.idempiere.ui.zk.media.WMediaOptions;
import org.idempiere.ui.zk.report.IReportViewerRenderer;
import org.zkoss.util.media.AMedia;
import org.zkoss.util.media.Media;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.ext.render.DynamicMedia;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.North;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.impl.Utils;
import org.zkoss.zul.impl.XulElement;

import net.sf.jasperreports.engine.JasperPrint;

/**
 *	Report Viewer.
 *
 * 	@author 	Jorg Janke
 * globalqss: integrate phib contribution from 
 *   https://sourceforge.net/p/adempiere/patches/4/
 * globalqss: integrate Teo Sarca bug fixing
 * Colin Rooney 2007/03/20 RFE#1670185 and BUG#1684142
 *                         Extend security to Info queries
 *
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 				<li>FR [ 1762466 ] Add "Window" menu to report viewer.
 * 				<li>FR [ 1894640 ] Report Engine: Excel Export support
 *
 * @author Low Heng Sin
 */
public class ZkReportViewer extends Window implements EventListener<Event>, IReportViewerExportSource {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3732290698059632847L;

	protected static final String CSV_OUTPUT_TYPE = CSVReportRendererConfiguration.ID;
	protected static final String HTML_OUTPUT_TYPE = HTMLReportRendererConfiguration.ID;	
	protected static final String PDF_OUTPUT_TYPE = PDFReportRendererConfiguration.ID;
	protected static final String XLS_OUTPUT_TYPE = XLSReportRendererConfiguration.ID;	
	protected static final String XLSX_OUTPUT_TYPE = XLSXReportRendererConfiguration.ID;

	/** Window No					*/
	protected int                 m_WindowNo = -1;
	/**	Print Context				*/
	private Properties			m_ctx;
	/**	Setting Values				*/
	private boolean				m_setting = false;
	/**	Report Engine				*/
	protected ReportEngine 		m_reportEngine;
	/** Table ID					*/
	private int					m_AD_Table_ID = 0;
	private boolean				m_isCanExport;
	/** Process ID					*/
	private int 				m_AD_Process_ID = 0;

	private MQuery 		m_ddQ = null;
	private MQuery 		m_daQ = null;
	private Menuitem 	m_ddM = null;
	private Menuitem 	m_daM = null;

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(ZkReportViewer.class);

	//
	private StatusBarPanel statusBar = new StatusBarPanel();
	private Toolbar toolBar = new Toolbar();
	private ToolBarButton bSendMail = new ToolBarButton();
	private ToolBarButton bArchive = new ToolBarButton();
	private ToolBarButton bAttachment = new ToolBarButton();
	private ToolBarButton bCustomize = new ToolBarButton();
	private ToolBarButton bFind = new ToolBarButton();
	private ToolBarButton bExport = new ToolBarButton();
	private ToolBarButton bWizard = new ToolBarButton();
	private Listbox comboReport = new Listbox();
	private Listitem previousSelected = new Listitem();
	private WTableDirEditor wLanguage;
	/** List box for preview type (pdf, html, etc) */
	protected Listbox previewType = new Listbox();
	
	private ToolBarButton bRefresh = new ToolBarButton();
	private ToolBarButton bReRun = new ToolBarButton();
	private Iframe iframe;
	
	private Checkbox summary = new Checkbox();

	protected AMedia media;
	private int mediaVersion = 0;

	private A reportLink;

	private boolean init;
	
	private BusyDialog progressWindow;
	private Mask mask;

	private final static String ON_RENDER_REPORT_EVENT = "onRenderReport";
	
	private Popup toolbarPopup;
	
	private ToolBarButton bCloudUpload = new ToolBarButton();
	protected Map<MAuthorizationAccount, IUploadService> uploadServicesMap = new HashMap<>();
	/** Row count label */
	private Label rowCount; 
	
	private final Map<ExportFormat, String> exportMap = new LinkedHashMap<>();
	private final Map<String, IReportViewerRenderer> rendererMap = new TreeMap<>();

	private Center center;

	private FindWindow find;
	/**
	 * SysConfig USE_ESC_FOR_TAB_CLOSING
	 */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));

	private JasperPrintRenderer jasperPrintRenderer = null;
	
	/**
	 * @param re
	 * @param title
	 */
	public ZkReportViewer(ReportEngine re, String title) {		
		super();

		init = false;
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_WindowNo);
		Env.setContext(re.getCtx(), m_WindowNo, "_WinInfo_IsReportViewer", "Y");
		m_reportEngine = re;
		m_AD_Table_ID = re.getPrintFormat().getAD_Table_ID();
		setTitle(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Report") + ": " +
				m_reportEngine.getPrintFormat().get_Translation(MPrintFormat.COLUMNNAME_Name)));
		if (!MRole.getDefault().isCanReport(m_AD_Table_ID))
		{
			Dialog.error(m_WindowNo, "AccessCannotReport", m_reportEngine.getName());
			this.onClose();
			return;
		}
		m_isCanExport = MRole.getDefault().isCanExport(m_AD_Table_ID);

		addEventListener(ON_RENDER_REPORT_EVENT, this);
		addEventListener("onPostInit", e -> {
			postRenderReportEvent();
		});
		
		initMediaSuppliers();
	}

	/**
	 * @param contentType
	 * @param fileExtension
	 * @return renderer id
	 */
	private String toRendererId(String contentType, String fileExtension) {
		for(Map.Entry<ExportFormat, String> entry : exportMap.entrySet()) {
			if (entry.getKey().contentType.equals(contentType) && entry.getKey().extension.equals(fileExtension))
				return entry.getValue();
		}
		return null;
	}
	
	/**
	 * Create media supplier for supported format (pdf, html, etc)
	 */
	private void initMediaSuppliers() {
		List<IReportViewerRenderer> renderers = Extensions.getReportViewerRenderers();
		Collections.sort(renderers, new Comparator<IReportViewerRenderer>() {
			@Override
			public int compare(IReportViewerRenderer r1, IReportViewerRenderer r2) {
				return r1.getExportLabel().compareTo(r2.getExportLabel());
			}
		});
		for(IReportViewerRenderer renderer : renderers) {
			if (renderer.isExport()) { 
				ExportFormat exportFormat = new ExportFormat(renderer.getExportLabel(), renderer.getFileExtension(), renderer.getContentType());
				exportMap.put(exportFormat, renderer.getId());
			}
			rendererMap.put(renderer.getId(), renderer);
		}
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null && !init && m_reportEngine != null) {
			try
			{
				m_ctx = m_reportEngine.getCtx();
				init();
				dynInit();
				SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
				addEventListener(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this);
			}
			catch(Exception e)
			{
				log.log(Level.SEVERE, "", e);
				Dialog.error(m_WindowNo, "LoadError", e.getLocalizedMessage());
				this.onClose();
			}
		}
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		try {
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
			removeEventListener(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this);
		} catch (Exception e) {}
		cleanUp();
	}

	/**
	 * Layout viewer
	 */
	private void init() {
		Borderlayout layout = new Borderlayout();
		layout.setWidth("100%");
		layout.setHeight("100%");
		this.appendChild(layout);
		this.setWidth("100%");
		this.setHeight("100%");
		
		ZKUpdateUtil.setHeight(toolBar, "32px");
		
		ZKUpdateUtil.setWidth(toolBar, "100%");
		
		previewType.setMold("select");
		setupPreviewType();
		
		toolBar.appendChild(previewType);		
		previewType.addEventListener(Events.ON_SELECT, this);
		
		toolBar.appendChild(new Separator("vertical"));
		
		String type = null;
		if (m_reportEngine.getReportType() != null)
		{
			type = m_reportEngine.getReportType();
		}
		else
		{
    		//set default type
    		type = m_reportEngine.getPrintFormat().isForm() || m_reportEngine.getPrintFormat().getJasperProcess_ID() > 0
    				? MSysConfig.getValue(MSysConfig.ZK_REPORT_FORM_OUTPUT_TYPE,PDF_OUTPUT_TYPE,Env.getAD_Client_ID(m_ctx),Env.getAD_Org_ID(m_ctx))
    				: MSysConfig.getValue(MSysConfig.ZK_REPORT_TABLE_OUTPUT_TYPE,PDF_OUTPUT_TYPE,Env.getAD_Client_ID(m_ctx),Env.getAD_Org_ID(m_ctx));    
		}

		int defaultIndex = -1;
		for(int i = 0; i < previewType.getItemCount(); i++) {
			ListItem item = previewType.getItemAtIndex(i);
			if (item.getValue().equals(type)) {
				previewType.setSelectedIndex(i);
				break;
			} else if (item.getValue().equals("PDF")) {
				defaultIndex = i;
			}
		}
		if (previewType.getSelectedIndex() < 0) {
			previewType.setSelectedIndex(defaultIndex >= 0 ? defaultIndex : 0);
		}
		
		Vlayout toolbarPopupLayout = null;
		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
		{
			toolbarPopup = new Popup();
			appendChild(toolbarPopup);	
			toolbarPopupLayout = new Vlayout();
			toolbarPopup.appendChild(toolbarPopupLayout);
		}
		
		if (toolbarPopup == null)
			toolBar.appendChild(new Separator("vertical"));
		
		comboReport.setMold("select");
		comboReport.setTooltiptext(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID"));
		
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(comboReport);
		}
		else
		{
			toolBar.appendChild(comboReport);		
			toolBar.appendChild(new Separator("vertical"));
		}
		
		MClient client = MClient.get(m_ctx);
		if (client.isMultiLingualDocument()){
			try {
				wLanguage = AEnv.getListDocumentLanguage(client);
				wLanguage.getComponent().setTooltiptext(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID"));
				if (toolbarPopup != null)
				{
					toolbarPopupLayout.appendChild(wLanguage.getComponent());
				}
				else
				{
					toolBar.appendChild(wLanguage.getComponent());
				}
				// Init Language from Printformat
				int languageID = 0;
				if(m_reportEngine.getPrintFormat() != null && m_reportEngine.getPrintFormat().getLanguage() != null) {
					MLanguage language = MLanguage.get(m_ctx, m_reportEngine.getPrintFormat().getLanguage());
					if(language != null)
						languageID = language.getAD_Language_ID();
				}
				if(m_reportEngine.getLanguageID() > 0)
					languageID = m_reportEngine.getLanguageID();
				wLanguage.setValue(languageID);
				wLanguage.getComponent().addEventListener(Events.ON_SELECT, this);
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage());
			}
		}
		
		if (toolbarPopup == null && client.isMultiLingualDocument())
			toolBar.appendChild(new Separator("vertical"));
		
		summary.setText(Msg.getMsg(Env.getCtx(), "Summary"));		
		summary.setChecked(m_reportEngine.isSummary());
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(summary);
		}
		else
		{
			toolBar.appendChild(summary);
			toolBar.appendChild(new Separator("vertical"));
		}
		
		bCustomize.setName("Customize");
		if (ThemeManager.isUseFontIconForImage())
			bCustomize.setIconSclass("z-icon-Preference");
		else
			bCustomize.setImage(ThemeManager.getThemeResource("images/Preference24.png"));
		bCustomize.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "PrintCustomize")));
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(bCustomize);
			bCustomize.setLabel(bCustomize.getTooltiptext());
		}
		else
			toolBar.appendChild(bCustomize);
		bCustomize.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			LayoutUtils.addSclass("medium-toolbarbutton", bCustomize);		
		
		bFind.setName("Find");
		if (ThemeManager.isUseFontIconForImage())
			bFind.setIconSclass("z-icon-Find");
		else
			bFind.setImage(ThemeManager.getThemeResource("images/Find24.png"));
		bFind.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Find")));		
		bFind.addEventListener(Events.ON_CLICK, this);
		if (getAD_Tab_ID(m_reportEngine.getPrintFormat().getAD_Table_ID()) <= 0) {
			bFind.setVisible(false); // IDEMPIERE-1185
		}
		
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(bFind);
			bFind.setLabel(bFind.getTooltiptext());
		}
		else
		{
			toolBar.appendChild(bFind);
			toolBar.appendChild(new Separator("vertical"));
		}
		if (ThemeManager.isUseFontIconForImage())
			LayoutUtils.addSclass("medium-toolbarbutton", bFind);
		
		bSendMail.setName("SendMail");
		if (ThemeManager.isUseFontIconForImage())
			bSendMail.setIconSclass("z-icon-SendMail");
		else
			bSendMail.setImage(ThemeManager.getThemeResource("images/SendMail24.png"));
		bSendMail.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "SendMail")));
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(bSendMail);
			bSendMail.setLabel(bSendMail.getTooltiptext());
		}
		else
			toolBar.appendChild(bSendMail);
		bSendMail.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			LayoutUtils.addSclass("medium-toolbarbutton", bSendMail);
		
		bArchive.setName("Archive");
		if (ThemeManager.isUseFontIconForImage())
			bArchive.setIconSclass("z-icon-Archive");
		else
			bArchive.setImage(ThemeManager.getThemeResource("images/Archive24.png"));
		bArchive.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Archive")));
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(bArchive);
			bArchive.setLabel(bArchive.getTooltiptext());
		}
		else
			toolBar.appendChild(bArchive);
		bArchive.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			LayoutUtils.addSclass("medium-toolbarbutton", bArchive);

		int tableId = m_reportEngine.getPrintInfo().getAD_Table_ID();
		int recordId = m_reportEngine.getPrintInfo().getRecord_ID();
		if (tableId > 0 && recordId > 0) {
			bAttachment.setName("Attachment");
			if (ThemeManager.isUseFontIconForImage())
				bAttachment.setIconSclass("z-icon-Attachment");
			else
				bAttachment.setImage(ThemeManager.getThemeResource("images/Attachment24.png"));
			bAttachment.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Attachment")));
			if (toolbarPopup != null)
			{
				toolbarPopupLayout.appendChild(bAttachment);
				bAttachment.setLabel(bAttachment.getTooltiptext());
			}
			else
				toolBar.appendChild(bAttachment);
			bAttachment.addEventListener(Events.ON_CLICK, this);
			if (ThemeManager.isUseFontIconForImage())
				LayoutUtils.addSclass("medium-toolbarbutton", bAttachment);
		}

		if ( m_isCanExport )
		{
			bExport.setName("Export");
			if (ThemeManager.isUseFontIconForImage())
				bExport.setIconSclass("z-icon-Export");
			else
				bExport.setImage(ThemeManager.getThemeResource("images/Export24.png"));
			bExport.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Export")));
			if (toolbarPopup != null)
			{
				toolbarPopupLayout.appendChild(bExport);
				bExport.setLabel(bExport.getTooltiptext());
			}
			else
				toolBar.appendChild(bExport);
			bExport.addEventListener(Events.ON_CLICK, this);
			if (ThemeManager.isUseFontIconForImage())
				LayoutUtils.addSclass("medium-toolbarbutton", bExport);
		}
		
		if (toolbarPopup == null)
			toolBar.appendChild(new Separator("vertical"));
		
		bRefresh.setName("Refresh");
		if (ThemeManager.isUseFontIconForImage())
			bRefresh.setIconSclass("z-icon-Refresh");
		else
			bRefresh.setImage(ThemeManager.getThemeResource("images/Refresh24.png"));
		bRefresh.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(bRefresh);
			bRefresh.setLabel(bRefresh.getTooltiptext());
		}
		else
			toolBar.appendChild(bRefresh);
		bRefresh.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			LayoutUtils.addSclass("medium-toolbarbutton", bRefresh);
		
		MPrintFormat pf = m_reportEngine.getPrintFormat();
		if (pf != null) {
			if((!pf.isForm()) && (pf.getAD_ReportView_ID() > 0)) {
				bReRun.setName("ReRun");
				if (ThemeManager.isUseFontIconForImage())
					bReRun.setIconSclass("z-icon-ReRun");
				else
					bReRun.setImage(ThemeManager.getThemeResource("images/ReRun24.png"));
				bReRun.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ReRun")));
				if (toolbarPopup != null)
				{
					toolbarPopupLayout.appendChild(bReRun);
					bReRun.setLabel(bReRun.getTooltiptext());
				}
				else
					toolBar.appendChild(bReRun);
				bReRun.addEventListener(Events.ON_CLICK, this);
				if (ThemeManager.isUseFontIconForImage())
					LayoutUtils.addSclass("medium-toolbarbutton", bReRun);
			}
		}
					
		bWizard.setName("Wizard");
		if (ThemeManager.isUseFontIconForImage())
			bWizard.setIconSclass("z-icon-Wizard");
		else
			bWizard.setImage(ThemeManager.getThemeResource("images/Wizard24.png"));
		bWizard.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "PrintWizard")));
		if (toolbarPopup != null)
		{
			toolbarPopupLayout.appendChild(bWizard);
			bWizard.setLabel(bWizard.getTooltiptext());
		}
		else
			toolBar.appendChild(bWizard);
		bWizard.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			LayoutUtils.addSclass("medium-toolbarbutton", bWizard);

		if (toolbarPopup != null)
		{
			ToolBarButton more = new ToolBarButton();
			if (ThemeManager.isUseFontIconForImage())
				more.setIconSclass("z-icon-Expand");
			else
				more.setImage(ThemeManager.getThemeResource("images/expand-header.png"));

			toolBar.appendChild(more);
			LayoutUtils.addSclass("space-between-content", toolBar);
			more.addEventListener(Events.ON_CLICK, evt -> {
				toolbarPopup.open(more, "before_end");
			});
		}
		
		if (m_isCanExport)
		{
			uploadServicesMap = MAuthorizationAccount.getUserUploadServices();
			if (uploadServicesMap.size() > 0) {
				bCloudUpload.setName("CloudUpload");
				if (ThemeManager.isUseFontIconForImage())
					bCloudUpload.setIconSclass("z-icon-FileImport");
				else
					bCloudUpload.setImage(ThemeManager.getThemeResource("images/FileImport24.png"));
				bCloudUpload.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "CloudUpload")));
				if (toolbarPopup != null)
				{
					toolbarPopupLayout.appendChild(bCloudUpload);
					bCloudUpload.setLabel(bCloudUpload.getTooltiptext());
				}
				else
					toolBar.appendChild(bCloudUpload);
				bCloudUpload.addEventListener(Events.ON_CLICK, this);
			}
		}
		
		North north = new North();
		layout.appendChild(north);
		north.appendChild(toolBar);
		ZKUpdateUtil.setVflex(north, "min");
		
		center = new Center();
		layout.appendChild(center);
		iframe = new Iframe();
		ZKUpdateUtil.setWidth(iframe, "100%");
		ZKUpdateUtil.setHeight(iframe, "100%");
		iframe.setId("reportFrame");
		center.appendChild(iframe);
		
		South south = new South();
		ZKUpdateUtil.setHeight(south, "50px");
		layout.appendChild(south);
		reportLink = new A();
		reportLink.setTarget("_blank");
		Div linkDiv = new Div();
		linkDiv.setStyle("width:100%; height: 40px; padding: 4px;");
		linkDiv.appendChild(reportLink);

		rowCount = new Label();
		rowCount.setStyle("float: right;");		
		linkDiv.appendChild(rowCount);
		if (m_reportEngine.getPrintData() != null)
			rowCount.setText(Msg.getMsg(m_ctx, "RowCount", new Object[] {m_reportEngine.getPrintData().getRowCount(false)}));
		
		south.appendChild(linkDiv);		
		
		//m_WindowNo
		int AD_Window_ID = Env.getContextAsInt(Env.getCtx(), m_reportEngine.getWindowNo(), "_WinInfo_AD_Window_ID", true);
		if (AD_Window_ID == 0)
			AD_Window_ID = Env.getZoomWindowID(m_reportEngine.getQuery());
		m_AD_Process_ID = m_reportEngine.getPrintInfo() != null ? m_reportEngine.getPrintInfo().getAD_Process_ID() : 0;
		updateToolbarAccess(AD_Window_ID, m_AD_Process_ID);

		this.setBorder("normal");

		this.addEventListener("onZoom", new EventListener<Event>() {
			
			public void onEvent(Event event) throws Exception {
				if (event instanceof ZoomEvent) {
					Clients.clearBusy();
					ZoomEvent ze = (ZoomEvent) event;
					if (ze.getData() != null && ze.getData() instanceof MQuery) {
						AEnv.zoom((MQuery) ze.getData());
					}
				}
				
			}
		});
		
		this.addEventListener(DrillEvent.ON_DRILL_ACROSS, new EventListener<Event>() {
			
			public void onEvent(Event event) throws Exception {
				if (event instanceof DrillEvent) {
					Clients.clearBusy();
					DrillEvent de = (DrillEvent) event;
					if (de.getData() != null && de.getData() instanceof DrillData) {
						DrillData data = (DrillData) de.getData();
						AEnv.actionDrill(data, m_WindowNo, m_AD_Process_ID);
					}
				}
				
			}
		});
		
		this.addEventListener(DrillEvent.ON_DRILL_DOWN, new EventListener<Event>() {
			
			public void onEvent(Event event) throws Exception {
				if (event instanceof DrillEvent) {
					Clients.clearBusy();
					DrillEvent de = (DrillEvent) event;
					if (de.getData() != null && de.getData() instanceof DrillData) {
						DrillData data = (DrillData) de.getData();
						executeDrillDown(data, event.getTarget());
					}
				}
				
			}
		});
		
		init = true;

		Events.echoEvent("onPostInit", this, null);

		setTabOnCloseHandler();
	}

	private void setupPreviewType() {
		String selectedValue = null;
		if (previewType.getItemCount() > 0) {
			if (previewType.getSelectedIndex() >= 0) {
				selectedValue = previewType.getSelectedItem().getValue();
			}
			previewType.getChildren().clear();
		}
		if (m_reportEngine.getPrintFormat().getJasperProcess_ID() > 0) {
			for (ValueNamePair vnp : JasperPrintRenderer.getPreviewType(m_isCanExport)) {
				ListItem li = previewType.appendItem(vnp.getName(), vnp.getValue());
				if (selectedValue != null && selectedValue.equals(li.getValue()))
					previewType.setSelectedItem(li);
			}
			if (summary != null)
				summary.setVisible(false);
		} else {
			for(String id : rendererMap.keySet()) {
				IReportViewerRenderer renderer = rendererMap.get(id);
				if (!renderer.isPreview(m_isCanExport))
					continue;
				ListItem li = previewType.appendItem(renderer.getPreviewLabel(), renderer.getId());
				if (selectedValue != null && selectedValue.equals(li.getValue()))
					previewType.setSelectedItem(li);
			}
			if (summary != null)
				summary.setVisible(true);
		}		
	}

	/**
	 * Set dummy onCloseHandler for parent tab
	 */
	private void setTabOnCloseHandler() {
		Component parent = this.getParent();
		while (parent != null) {
			if (parent instanceof Tabpanel) {
				Tabpanel parentTabPanel = (Tabpanel) parent;
				parentTabPanel.setOnCloseHandler(t -> {
				});
				break;
			}
			parent = parent.getParent();
		}
	}

	/**
	 * Get the maintenance tab of the table associated to the report engine
	 * @return AD_Tab_ID or -1 if not found
	 */
	private int getAD_Tab_ID(int AD_Table_ID) {
		// Get Find Tab Info
		final String sql = "SELECT t.AD_Tab_ID "
				+ "FROM AD_Tab t"
				+ " INNER JOIN AD_Window w ON (t.AD_Window_ID=w.AD_Window_ID)"
				+ " INNER JOIN AD_Table tt ON (t.AD_Table_ID=tt.AD_Table_ID) "
				+ "WHERE tt.AD_Table_ID=? "
				+ "ORDER BY w.IsDefault DESC, t.SeqNo, ABS (tt.AD_Window_ID-t.AD_Window_ID)";
		int AD_Tab_ID = DB.getSQLValueEx(null, sql, AD_Table_ID);
		return AD_Tab_ID;
	}

	/**
	 * Render report
	 */
	private void renderReport() {
		media = null;
		Listitem selected = previewType.getSelectedItem();
		new RendererRunnable(this, selected.getValue()).run();
	}
	
	/**
	 * Call from renderer runnable to show report output
	 */
	private void onPreviewReport() {		
		try {
			if(media == null) {
				iframe.setSrc(null);
				iframe.setContent(null);
				reportLink.setHref("");
				reportLink.setLabel("");
				if (rowCount != null)
					rowCount.setText("");
				return;
			}
			
			mediaVersion++;
			String url = Utils.getDynamicMediaURI(this, mediaVersion, media.getName(), media.getFormat());	
			String pdfJsUrl = AEnv.toPdfJsUrl(url);
			HttpServletRequest request = (HttpServletRequest) Executions.getCurrent().getNativeRequest();
			if (url.startsWith(request.getContextPath() + "/"))
				url = url.substring((request.getContextPath() + "/").length());
			reportLink.setHref(url);
			reportLink.setLabel(media.getName());			
			
			Listitem selected = previewType.getSelectedItem();
			String outputType = previewType.getSelectedItem().getValue();
			if (ClientInfo.isMobile()) {				
				if (selected == null || PDF_OUTPUT_TYPE.equals(selected.getValue())) {
					attachIFrame();
					iframe.setSrc(pdfJsUrl);
				} else if (HTML_OUTPUT_TYPE.equals(outputType)) {
					attachIFrame();
					iframe.setSrc(null);
					iframe.setContent(media);
				} else {
					IMediaView view = null;
					boolean showOptions = false;
					if (XLS_OUTPUT_TYPE.equals(outputType) || XLSX_OUTPUT_TYPE.equals(outputType)) {						
						if (XLS_OUTPUT_TYPE.equals(outputType))
							view = Extensions.getMediaView(EXCEL_MIME_TYPE, EXCEL_FILE_EXT, true);
						else
							view = Extensions.getMediaView(EXCEL_XML_MIME_TYPE, EXCEL_XML_FILE_EXT, true);
						showOptions = true;
					} else if (CSV_OUTPUT_TYPE.equals(outputType)) {
						view = Extensions.getMediaView(CSV_MIME_TYPE, CSV_FILE_EXT, true);
						showOptions = true;
					}
					
					if (showOptions && (view != null || uploadServicesMap.size() > 0)) {
						detachIFrame();
						final IMediaView fview = view;
						WMediaOptions options = new WMediaOptions(media, fview != null ? () -> fview.renderMediaView(center, media, true) : null, uploadServicesMap);
						options.setPage(getPage());
						options.doHighlighted();
					} else {
						attachIFrame();
						iframe.setSrc(null);
						iframe.setContent(null);
						String script = "zk.Widget.$('#" + reportLink.getUuid()+"').$n().click();";
						Clients.evalJavaScript(script);
					}
				}
			} else {
				if (MSysConfig.getBooleanValue(MSysConfig.ZK_USE_PDF_JS_VIEWER, false, Env.getAD_Client_ID(Env.getCtx())) 
						&& (selected == null || PDF_OUTPUT_TYPE.equals(selected.getValue()))) {
					attachIFrame();
					iframe.setSrc(pdfJsUrl);
				} else {
					IMediaView view = null;
					boolean showOptions = false;
					if (XLS_OUTPUT_TYPE.equals(outputType) || XLSX_OUTPUT_TYPE.equals(outputType)) {						
						if (XLS_OUTPUT_TYPE.equals(outputType))
							view = Extensions.getMediaView(EXCEL_MIME_TYPE, EXCEL_FILE_EXT, false);
						else
							view = Extensions.getMediaView(EXCEL_XML_MIME_TYPE, EXCEL_XML_FILE_EXT, false);
						showOptions = true;
					} else if (CSV_OUTPUT_TYPE.equals(outputType)) {
						view = Extensions.getMediaView(CSV_MIME_TYPE, CSV_FILE_EXT, false);
						showOptions = true;
					}
					
					if (showOptions && (view != null || uploadServicesMap.size() > 0)) {
						detachIFrame();
						final IMediaView fview = view;
						WMediaOptions options = new WMediaOptions(media, fview != null ? () -> fview.renderMediaView(center, media, true) : null, uploadServicesMap);
						options.setPage(getPage());
						options.doHighlighted();
					} else {
						attachIFrame();
						iframe.setSrc(null);
						iframe.setContent(media);
					}
				}
			}
			
			revalidate();
		} finally {
			hideBusyDialog();
		}
	}

	/**
	 * Remove iframe
	 */
	private void detachIFrame() {
		center.getChildren().clear();
	}

	/**
	 * Add iframe to center
	 */
	private void attachIFrame() {
		if (iframe != null && iframe.getPage() == null) {
			center.getChildren().clear();
			center.appendChild(iframe);
		}
	}

	/**
	 * 	Dynamic Init
	 */
	private void dynInit()
	{
		summary.addActionListener(this);
		
		fillComboReport(m_reportEngine.getPrintFormat().get_ID());

		revalidate();
		
		if (Window.REPLACE.equals(getAttribute(Window.INSERT_POSITION_KEY))) {
			if (m_reportEngine != null && m_reportEngine.getProcessInfo() != null) {
				ProcessInfo pi = m_reportEngine.getProcessInfo();
				checkProcessInfo(pi);
			}
		}
	}	//	dynInit

	/**
	 * Open {@link ProcessInfoDialog} if pi has error or logs
	 * @param pi
	 */
	private void checkProcessInfo(ProcessInfo pi) {
		ProcessInfoUtil.setLogFromDB(pi);
		if (pi.isError() || (pi.getLogs() != null && pi.getLogs().length > 0)) {
			ProcessInfoDialog dialog = new ProcessInfoDialog(pi, false);
			dialog.setAutoCloseAfterZoom(false);
			dialog.setPage(this.getPage());
			dialog.doHighlighted();
		}
	}
	
	/**
	 * 	Fill ComboBox comboReport with print formats available and option to create new print format.
	 *  @param AD_PrintFormat_ID item to be selected
	 */
	private void fillComboReport(int AD_PrintFormat_ID)
	{
		comboReport.removeEventListener(Events.ON_SELECT, this);
		comboReport.getItems().clear();
		KeyNamePair selectValue = null;
		
		int AD_Window_ID = Env.getContextAsInt(Env.getCtx(), m_reportEngine.getWindowNo(), "_WinInfo_AD_Window_ID", true);
		if (AD_Window_ID == 0)
			AD_Window_ID = Env.getZoomWindowID(m_reportEngine.getQuery());

		int reportViewID = m_reportEngine.getPrintFormat().getAD_ReportView_ID();

		//	fill Report Options
		String sql = MRole.getDefault().addAccessSQL(
			"SELECT * "
				+ "FROM AD_PrintFormat "
				+ "WHERE AD_Table_ID=? "
				//Added Lines by Armen
				+ "AND IsActive='Y' "
				//End of Added Lines
				+ (AD_Window_ID > 0 ? "AND (AD_Window_ID=? OR AD_Window_ID IS NULL) " : "")
				+ (reportViewID > 0 ? "AND AD_ReportView_ID=? " : "")
				+ "ORDER BY Name",
			"AD_PrintFormat", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		int AD_Table_ID = m_reportEngine.getPrintFormat().getAD_Table_ID();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			int idx = 1;
			pstmt.setInt(idx++, AD_Table_ID);
			if (AD_Window_ID > 0)
				pstmt.setInt(idx++, AD_Window_ID);
			if (reportViewID > 0)
				pstmt.setInt(idx++, reportViewID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MPrintFormat printFormat = new MPrintFormat (Env.getCtx(), rs, null);
				
				KeyNamePair pp = new KeyNamePair(printFormat.get_ID(), printFormat.get_Translation(MPrintFormat.COLUMNNAME_Name, Env.getAD_Language(Env.getCtx()), true));
				Listitem li = comboReport.appendItem(pp.getName(), pp.getKey());
				if (rs.getInt(1) == AD_PrintFormat_ID)
				{
					selectValue = pp;
					if(selectValue != null)
						previousSelected = comboReport.getSelectedItem();
						comboReport.setSelectedItem(li);
				}
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		// IDEMPIERE-297 - Check for Table Access and Window Access for New Report
		int pfAD_Window_ID = MPrintFormat.getZoomWindowID(AD_PrintFormat_ID);
		if (   MRole.getDefault().isTableAccess(MPrintFormat.Table_ID, false) 
			&& Boolean.TRUE.equals(MRole.getDefault().getWindowAccess(pfAD_Window_ID)))
		{
			StringBuffer sb = new StringBuffer("** ").append(Msg.getMsg(Env.getCtx(), "NewReport")).append(" **");
			KeyNamePair pp = new KeyNamePair(-1, sb.toString());
			comboReport.appendItem(pp.getName(), pp.getKey());
			sb = new StringBuffer("** ").append(Msg.getMsg(m_ctx, "CopyReport")).append(" **");
			pp = new KeyNamePair(-2, sb.toString());
			comboReport.addItem(pp);
		}
		comboReport.addEventListener(Events.ON_SELECT, this);
	}	//	fillComboReport

	/**
	 * Update title, status text and state of {@link #bWizard}
	 */
	private void revalidate()
	{
		//	Report Info
		setTitle(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Report") + ": " + m_reportEngine.getName()));
		StringBuilder sb = new StringBuilder ();
		sb.append(Msg.getMsg(Env.getCtx(), "DataCols")).append("=")
			.append(m_reportEngine.getColumnCount())
			.append(", ").append(Msg.getMsg(Env.getCtx(), "DataRows")).append("=")
			.append(m_reportEngine.getRowCount());
		statusBar.setStatusLine(sb.toString());
		//
		bWizard.setDisabled(
				(   m_reportEngine.getPrintFormat() == null
				 || (m_reportEngine.getPrintFormat().getAD_Client_ID() == 0 && Env.getAD_Client_ID(Env.getCtx()) != 0)
				 || m_reportEngine.getPrintFormat().isForm()));
		
		updateRowCount();
		
		this.invalidate();
	}	//	revalidate

	/**
	 * Close viewer
	 */
	public void onClose()
	{
		cleanUp();
		super.onClose();
	}	//	dispose

	private void cleanUp() {
		if (m_reportEngine != null || m_WindowNo >= 0)
		{
			SessionManager.getAppDesktop().unregisterWindow(m_WindowNo);
			m_reportEngine = null;
			m_ctx = null;
			m_WindowNo = -1;
		}
	}
	
	@Override
	public void onEvent(Event event) throws Exception {				
		if(event.getName().equals(Events.ON_CLICK) || event.getName().equals(Events.ON_SELECT)) 
			actionPerformed(event);
		else if (event.getTarget() == summary) 
		{
			m_reportEngine.setSummary(summary.isSelected());
			cmd_report();
		}		
		else if (event.getName().equals(ON_RENDER_REPORT_EVENT))
		{
			onRenderReportEvent();
        } else if (event.getName().equals(Events.ON_CTRL_KEY)) {
        	KeyEvent keyEvent = (KeyEvent) event;
        	if (LayoutUtils.isReallyVisible(this))
	        	this.onCtrlKeyEvent(keyEvent);
		}
        else if (event.getTarget() instanceof ProcessModalDialog)
        {
			if(DialogEvents.ON_WINDOW_CLOSE.equals(event.getName()))
			{
				hideBusyMask();
				ProcessModalDialog dialog = (ProcessModalDialog) event.getTarget();
				if (dialog.isCancel())
				{
					if (getDesktop() != null)
						clearTabOnCloseHandler();
				}
				ProcessInfo pi = dialog.getProcessInfo();
				if (pi != null) 
					checkProcessInfo(pi);
			}
        }
        else if(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT.equals(event.getName())) {
        	IDesktop desktop = SessionManager.getAppDesktop();
        	if (m_WindowNo > 0 && desktop.isCloseTabWithShortcut())
        		desktop.closeWindow(m_WindowNo);
        	else
        		desktop.setCloseTabWithShortcut(true);
        }
	}

	/**
	 * Open {@link WReportUploadDialog} to upload report to external destination
	 */
	private void cmd_upload() {
		if (media == null)
			return;
		
		WReportUploadDialog winUploadFile = new WReportUploadDialog(this);
		winUploadFile.setTitle(Msg.getMsg(Env.getCtx(), "CloudUpload") + ": " + getTitle());
		winUploadFile.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showWindow(winUploadFile);
	}

	/**
	 * Handle key event
	 * @param keyEvent
	 */
	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		if ((keyEvent.isAltKey() && keyEvent.getKeyCode() == 0x58)	// Alt-X
				|| (keyEvent.getKeyCode() == 0x1B && isUseEscForTabClosing)) {	// ESC
			if (m_WindowNo > 0) {
				keyEvent.stopPropagation();
				SessionManager.getAppDesktop().closeWindow(m_WindowNo);
			}
		}
	}

	/**
	 * Handle onRenderReportEvent
	 */
	private void onRenderReportEvent() {
    	renderReport();
	}

	/**
	 * 	Handle event
	 * 	@param e event
	 */
	public void actionPerformed (Event e)
	{
		if (m_setting)
			return;
		if (e.getTarget() == comboReport)
			cmd_report();
		else if (MClient.get(m_ctx).isMultiLingualDocument() && e.getTarget() == wLanguage.getComponent()){
			cmd_report();
		}else if (e.getTarget() == bFind)
			cmd_find();
		else if (e.getTarget() == bExport)
			cmd_export();
		else if (e.getTarget() == previewType)
			cmd_render();
		else if (e.getTarget() == bSendMail)
			cmd_sendMail();
		else if (e.getTarget() == bArchive)
			cmd_archive();
		else if (e.getTarget() == bAttachment)
			cmd_attachment();
		else if (e.getTarget() == bCustomize)
			cmd_customize();
		else if (e.getTarget() == bWizard)
			cmd_Wizard();
		else if (e.getTarget() == bRefresh)
			cmd_refresh();
		else if (e.getTarget() == bReRun)
			cmd_reRun();
		//
		else if (e.getTarget() == m_ddM)
			cmd_window(m_ddQ);
		else if (e.getTarget() == m_daM)
			cmd_window(m_daQ);
		else if (e.getTarget() == bCloudUpload)
			cmd_upload();
	}	//	actionPerformed
	
	/**
	 * Handle onSelect event from {@link #previewType}
	 */
	private void cmd_render() {
		postRenderReportEvent();		
	}
	
	/**
	 * 	Execute Drill to Query
	 * 	@param data query
	 *  @param component
	 */
	private void executeDrillDown (DrillData data, Component component)
	{
		int AD_Table_ID = MTable.getTable_ID(data.getQuery().getTableName());
		if (!MRole.getDefault().isCanReport(AD_Table_ID))
		{
			Dialog.error(m_WindowNo, "AccessCannotReport", data.getQuery().getTableName());
			return;
		}
		if (AD_Table_ID != 0) {
			new WReport (AD_Table_ID, data.getQuery(), component, m_WindowNo);
		}
		else
			log.warning("No Table found for " + data.getQuery().getWhereClause(true));
	}	//	executeDrill

	/**
	 * 	Zoom to window
	 *	@param query query
	 */
	private void cmd_window (MQuery query)
	{
		if (query == null)
			return;
		AEnv.zoom(query);
	}	//	cmd_window
	
	/**
	 * 	Send Mail
	 */
	private void cmd_sendMail()
	{
		String to = "";
		MUser from = MUser.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()));
		String subject = m_reportEngine.getName();
		String message = "";
		File attachment = null;
		
		try
		{
			attachment = new File(FileUtil.getTempMailName(subject, ".pdf"));
			m_reportEngine.getPDF(attachment);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}

		WEMailDialog dialog = new WEMailDialog (Msg.getMsg(Env.getCtx(), "SendMail"),
			from, to, subject, message, new FileDataSource(attachment),
			m_WindowNo, m_reportEngine.getPrintInfo().getAD_Table_ID(),
			m_reportEngine.getPrintInfo().getRecord_ID(),
			m_reportEngine.getPrintInfo().getRecord_UU(),
			m_reportEngine.getPrintInfo());

		AEnv.showWindow(dialog);
	}	//	cmd_sendMail

	/**
	 * 	Archive Report directly
	 */
	private void cmd_archive ()
	{
		boolean success = false;
		byte[] data = Document.getPDFAsArray(m_reportEngine.getLayout().getPageable(false));	//	No Copy
		if (data != null)
		{
			MArchive archive = new MArchive (Env.getCtx(), m_reportEngine.getPrintInfo(), null);
			archive.setBinaryData(data);
			success = archive.save();
		}
		if (success)
			Dialog.info(m_WindowNo, "Archived");
		else
			Dialog.error(m_WindowNo, "ArchiveError");
	}	//	cmd_archive

	/**
	 * 	Add Report to Attachment directly
	 */
	private void cmd_attachment()
	{
		int tableId = m_reportEngine.getPrintInfo().getAD_Table_ID();
		int recordId = m_reportEngine.getPrintInfo().getRecord_ID();
		if (tableId == 0 || recordId == 0)
			return;
		boolean success = false;
		MTable table = MTable.get(tableId);
		PO po = table.getPO(recordId, null);
		MAttachment attachment = po.createAttachment();
		byte[] data = media.isBinary() ? media.getByteData() : media.getStringData().getBytes();
		String fileName = m_reportEngine.getName().replace(" ", "_") + "." + media.getFormat();
		attachment.addEntry(fileName, data);
		success = attachment.save();
		if (success)
			Dialog.info(m_WindowNo, "DocumentAttached", fileName);
		else
			Dialog.error(m_WindowNo, "AttachError");
	}	//	cmd_attachment

	/**
	 * Open {@link WReportExportDialog} to export report
	 */
	private void cmd_export()
	{		
		if (!m_isCanExport)
		{
			Dialog.error(m_WindowNo, "AccessCannotExport", getTitle());
			return;
		}
		
		WReportExportDialog winExportFile = new WReportExportDialog(this);
		winExportFile.setTitle(Msg.getMsg(Env.getCtx(), "Export") + ": " + getTitle());
		winExportFile.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showWindow(winExportFile);
	}	//	cmd_export
	
	/**
	 * Sets AD_PrintFormat_Trl Name to AD_PrintFormat Name
	 * @param pf
	 */
	private void resetPrintFormatTrl(MPrintFormat pf) {
		String sql = "UPDATE AD_PrintFormat_Trl pf "
				+ " SET Name = '" + pf.getName() + "' "
				+ " WHERE pf.AD_PrintFormat_ID = " + pf.getAD_PrintFormat_ID();
		DB.executeUpdate(sql, null);
	}
	
	/**
	 * 	Report Combo - Start other Report or create new one
	 */
	private void cmd_report()
	{
		ListItem li = comboReport.getSelectedItem();
		if(li == null || li.getValue() == null) return;
		
		Object pp = li.getValue();
		if (pp == null)
			return;
		
		jasperPrintRenderer = null;
		setTabOnCloseHandler();
		//
		MPrintFormat pf = null;
		int AD_PrintFormat_ID = Integer.valueOf(pp.toString());

		//	create new
		if (AD_PrintFormat_ID == -1)
		{
			WEditor editor = new WStringEditor();
			ZKUpdateUtil.setWidth((HtmlBasedComponent)editor.getComponent(), "98%");
			Dialog.askForInputWithCancel(m_WindowNo, editor, "CreateNewPrintFormat",  Msg.getMsg(m_ctx, "CreateNewPrintFormatTitle"), new Callback<Map.Entry<Boolean, Object>>() {
				public void onCallback(Map.Entry<Boolean, Object> result) {
					if((result == null) || (!(result.getValue() instanceof String)) || (!result.getKey())) {
						comboReport.setSelectedItem(previousSelected);
						return;
					}
					MPrintFormat pf = null;
					if (!Util.isEmpty((String)result.getValue())) {
						int AD_ReportView_ID = m_reportEngine.getPrintFormat().getAD_ReportView_ID();
						if (AD_ReportView_ID != 0)
						{
							String name = (String)result.getValue();
							pf = MPrintFormat.createFromReportView(m_ctx, AD_ReportView_ID, name);
						}
						else
						{
							int AD_Table_ID = m_reportEngine.getPrintFormat().getAD_Table_ID();
							pf = MPrintFormat.createFromTable(m_ctx, AD_Table_ID);
						}
						if (pf != null) {
							pf.setName((String)result.getValue());
							if(!pf.save()) {
								Calendar cal = Calendar.getInstance();
								SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
								String dt = sdf.format(cal.getTime());
								pf.setName(pf.getName() + "_" + dt);
								pf.saveEx();
							}
							resetPrintFormatTrl(pf);
							fillComboReport(pf.get_ID());
						}
						else
							return;
						//	Get Language from previous - thanks Gunther Hoppe 
						if (m_reportEngine.getPrintFormat() != null)
						{
							setLanguage();
							pf.setLanguage(m_reportEngine.getPrintFormat().getLanguage());		//	needs to be re-set - otherwise viewer will be blank
							pf.setTranslationLanguage(m_reportEngine.getPrintFormat().getLanguage());
						}
						
						if (m_reportEngine.getPrintFormat().getJasperProcess_ID() != pf.getJasperProcess_ID()) {
							m_reportEngine.setPrintFormat(pf);
							setupPreviewType();
							if (m_reportEngine.getPrintFormat().getJasperProcess_ID() == 0) {
								m_reportEngine.setQuery(m_reportEngine.getQuery());
								m_reportEngine.getLayout();
							}
						} else {
							m_reportEngine.setPrintFormat(pf);
						}
						m_reportEngine.initName();
						postRenderReportEvent();
					}
					else {
						comboReport.setSelectedItem(previousSelected);
					}
				}
			});
		} else if (AD_PrintFormat_ID == -2) {
			WEditor editor = new WStringEditor();
			ZKUpdateUtil.setWidth((HtmlBasedComponent)editor.getComponent(), "90%");
			Dialog.askForInputWithCancel(m_WindowNo, editor, "CreatePrintFormatCopy", Msg.getMsg(m_ctx, "CreatePrintFormatCopyTitle"), new Callback<Map.Entry<Boolean, Object>>() {
				public void onCallback(Map.Entry<Boolean, Object> result) {
					if((result == null) || (!(result.getValue() instanceof String)) || (!result.getKey())) {
						comboReport.setSelectedItem(previousSelected);
						return;
					}
					MPrintFormat pf = null;
					if (!Util.isEmpty((String)result.getValue())) {
						MPrintFormat current = m_reportEngine.getPrintFormat();
						if (current != null) {
							pf = MPrintFormat.copyToClient(m_ctx,
									current.getAD_PrintFormat_ID(),
									Env.getAD_Client_ID(m_ctx));

							if (pf != null) {
								pf.setName((String)result.getValue());
								if(!pf.save()) {
									Calendar cal = Calendar.getInstance();
									SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
									String dt = sdf.format(cal.getTime());
									pf.setName(pf.getName() + "_" + dt);
									pf.saveEx();
								}
								resetPrintFormatTrl(pf);
								fillComboReport(pf.get_ID());
							}
							else
								return;
						} else
							return;
						//	Get Language from previous - thanks Gunther Hoppe 
						if (m_reportEngine.getPrintFormat() != null)
						{
							setLanguage();
							pf.setLanguage(m_reportEngine.getPrintFormat().getLanguage());		//	needs to be re-set - otherwise viewer will be blank
							pf.setTranslationLanguage(m_reportEngine.getPrintFormat().getLanguage());
						}
						m_reportEngine.initName();
						if (m_reportEngine.getPrintFormat().getJasperProcess_ID() != pf.getJasperProcess_ID()) {
							m_reportEngine.setPrintFormat(pf);
							setupPreviewType();
							if (m_reportEngine.getPrintFormat().getJasperProcess_ID() == 0) {
								m_reportEngine.setQuery(m_reportEngine.getQuery());
								m_reportEngine.getLayout();
							}
						} else {
							m_reportEngine.setPrintFormat(pf);
						}
						postRenderReportEvent();
					}
					else {
						comboReport.setSelectedItem(previousSelected);
					}
				}
			});
		}
		else {
			//	Get Language from previous - thanks Gunther Hoppe 
			pf = MPrintFormat.get (Env.getCtx(), AD_PrintFormat_ID, true);
			if (m_reportEngine.getPrintFormat() != null)
			{
				setLanguage();
				pf.setLanguage(m_reportEngine.getPrintFormat().getLanguage());		//	needs to be re-set - otherwise viewer will be blank
				pf.setTranslationLanguage(m_reportEngine.getPrintFormat().getLanguage());
			}
			if (m_reportEngine.getPrintFormat().getJasperProcess_ID() != pf.getJasperProcess_ID()) {
				m_reportEngine.setPrintFormat(pf);
				setupPreviewType();
				if (m_reportEngine.getPrintFormat().getJasperProcess_ID() == 0) {
					m_reportEngine.setQuery(m_reportEngine.getQuery());
					m_reportEngine.getLayout();
				}
			} else {
				m_reportEngine.setPrintFormat(pf);
			}
			m_reportEngine.initName();
			postRenderReportEvent();
		}
		setTitle(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Report") + ": " + m_reportEngine.getName()));
	}	//	cmd_report

	/**
	 * Refresh with same parameters
	 */
	private void cmd_refresh() {
		int AD_Process_ID = m_reportEngine.getPrintInfo() != null ? m_reportEngine.getPrintInfo().getAD_Process_ID() : 0;
		if(AD_Process_ID <= 0 || m_reportEngine.getPrintInfo().getRecord_ID() > 0)
			this.cmd_report();
		else
			this.cmd_reRun(MProcess.SHOWHELP_RunSilently_TakeDefaults);
	}
	
	/**
	 * Rerun report
	 */
	private void cmd_reRun() {
		this.cmd_reRun(null);
	}
	
	/**
	 * Rerun report
	 * @param showHelp if SHOWHELP_RunSilently_TakeDefaults, re-run with same parameter (i.e just refresh)
	 */
	private void cmd_reRun(String showHelp) {
		int AD_Process_ID = m_reportEngine.getPrintInfo() != null ? m_reportEngine.getPrintInfo().getAD_Process_ID() : 0;
		if(AD_Process_ID <= 0)
			return;
		ProcessInfo pi = new ProcessInfo("RefreshWithParameters", AD_Process_ID);
		pi.setLanguageID(m_reportEngine.getLanguageID());
		pi.setReportType(m_reportEngine.getReportType());
		pi.setSerializableObject(m_reportEngine.getPrintFormat());
		pi.setReplaceTabContent();
		if(!Util.isEmpty(showHelp))
			pi.setShowHelp(showHelp);
		setTabOnCloseHandler();	
		String predefined = (String) getAttribute(ProcessDialog.SAVED_PREDEFINED_CONTEXT_VARIABLES);
		if (!Util.isEmpty(predefined, true)) {
			Env.setContext(Env.getCtx(), m_WindowNo, ProcessDialog.SAVED_PREDEFINED_CONTEXT_VARIABLES, predefined);
			Env.setPredefinedVariables(Env.getCtx(), m_WindowNo, predefined);
		}
		if (getAttribute("IsSOTrx") != null) {
			Env.setContext(Env.getCtx(), m_WindowNo, "IsSOTrx", getAttribute("IsSOTrx").toString());
		}
		ProcessModalDialog processModalDialog = new ProcessModalDialog(this, m_WindowNo, pi);
		ZKUpdateUtil.setWindowWidthX(processModalDialog, 850);
		this.getParent().appendChild(processModalDialog);
		if (ClientInfo.isMobile())
		{
			processModalDialog.doHighlighted();
		}
		else
		{
			showBusyMask(processModalDialog);
			LayoutUtils.openOverlappedWindow(this, processModalDialog, "middle_center");
		}
		processModalDialog.focus();
	}	// cmd_reRun
	
	/**
	 * Set language to {@link #m_reportEngine}
	 */
	protected void setLanguage (){
		if (MClient.get(m_ctx).isMultiLingualDocument() && wLanguage != null && wLanguage.getValue() != null){
			MLanguage language = new MLanguage (m_ctx, (int)wLanguage.getValue(), null);
			Language lang = new Language(language.getName(), language.getAD_Language(), language.getLocale());
			m_reportEngine.setLanguageID(language.getAD_Language_ID());
			m_reportEngine.getPrintFormat().setLanguage(lang);
			m_reportEngine.getPrintFormat().setTranslationLanguage(lang);
		}
	}
	
	/**
	 * Set preview type to {@link #m_reportEngine}
	 */
	protected void setPreviewType() {
		String type = Objects.toString(previewType.getValue());
		
		// get default from SysConfig
		if(type == null) {
			type = m_reportEngine.getPrintFormat().isForm()
				? MSysConfig.getValue(MSysConfig.ZK_REPORT_FORM_OUTPUT_TYPE,PDF_OUTPUT_TYPE,Env.getAD_Client_ID(m_ctx),Env.getAD_Org_ID(m_ctx))
				: MSysConfig.getValue(MSysConfig.ZK_REPORT_TABLE_OUTPUT_TYPE,PDF_OUTPUT_TYPE,Env.getAD_Client_ID(m_ctx),Env.getAD_Org_ID(m_ctx));
		}
		m_reportEngine.setReportType(type);
	}

	/**
	 * Echo {@link #ON_RENDER_REPORT_EVENT} event
	 */
	private void postRenderReportEvent() {
		showBusyDialog();
		setLanguage();
		setPreviewType();
		Events.echoEvent(ON_RENDER_REPORT_EVENT, this, null);		
	}

	/**
	 * 	Query Report
	 */
	private void cmd_find()
	{
		String title = null; 
		String tableName = null;

		int AD_Table_ID = m_reportEngine.getPrintFormat().getAD_Table_ID();
		int AD_Tab_ID = getAD_Tab_ID(AD_Table_ID);
		// ASP
		MClient client = MClient.get(Env.getCtx());
		String ASPFilter = "";
		if (client.isUseASP())
			ASPFilter =
				"     AND (   AD_Tab_ID IN ( "
				// Just ASP subscribed tabs for client "
				+ "              SELECT t.AD_Tab_ID "
				+ "                FROM ASP_Tab t, ASP_Window w, ASP_Level l, ASP_ClientLevel cl "
				+ "               WHERE w.ASP_Level_ID = l.ASP_Level_ID "
				+ "                 AND cl.AD_Client_ID = " + client.getAD_Client_ID()
				+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
				+ "                 AND t.ASP_Window_ID = w.ASP_Window_ID "
				+ "                 AND t.IsActive = 'Y' "
				+ "                 AND w.IsActive = 'Y' "
				+ "                 AND l.IsActive = 'Y' "
				+ "                 AND cl.IsActive = 'Y' "
				+ "                 AND t.ASP_Status = 'S') " // Show
				+ "        OR AD_Tab_ID IN ( "
				// + show ASP exceptions for client
				+ "              SELECT AD_Tab_ID "
				+ "                FROM ASP_ClientException ce "
				+ "               WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
				+ "                 AND ce.IsActive = 'Y' "
				+ "                 AND ce.AD_Tab_ID IS NOT NULL "
				+ "                 AND ce.AD_Field_ID IS NULL "
				+ "                 AND ce.ASP_Status = 'S') " // Show
				+ "       ) "
				+ "   AND AD_Tab_ID NOT IN ( "
				// minus hide ASP exceptions for client
				+ "          SELECT AD_Tab_ID "
				+ "            FROM ASP_ClientException ce "
				+ "           WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
				+ "             AND ce.IsActive = 'Y' "
				+ "             AND ce.AD_Tab_ID IS NOT NULL "
				+ "             AND ce.AD_Field_ID IS NULL "
				+ "             AND ce.ASP_Status = 'H')"; // Hide
		//
		String sql = null;
		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Tab")) {
			sql = "SELECT Name, TableName FROM AD_Tab_vt WHERE AD_Tab_ID=?"
					+ " AND AD_Language='" + Env.getAD_Language(Env.getCtx()) + "' " + ASPFilter;
		} else {
			sql = "SELECT Name, TableName FROM AD_Tab_v WHERE AD_Tab_ID=? " + ASPFilter;
		}
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Tab_ID);
			rs = pstmt.executeQuery();
			//
			if (rs.next())
			{
				title = rs.getString(1);				
				tableName = rs.getString(2);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		GridField[] findFields = null;
		if (tableName != null)
			findFields = GridField.createFields(m_ctx, m_WindowNo, 0, AD_Tab_ID);
		
		if (findFields == null)		//	No Tab for Table exists
			bFind.setVisible(false);
		else
		{
			if (find == null) 
			{

				find = Extensions.getFindWindow(m_WindowNo, 0, title, AD_Table_ID, tableName,m_reportEngine.getWhereExtended(), findFields, 1, AD_Tab_ID, null);
	            
				if (!find.initialize()) 
	            {
	            	find = null;
	            	return;
	            }
            
	            find.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						if (!find.isCancel())
			            {
			            	m_reportEngine.setQuery(find.getQuery());
			            	postRenderReportEvent();
			            }
					}
				});
	            setupFindwindow(find);	            
			}
			getParent().appendChild(find);			
            LayoutUtils.openHighlightedWindow(toolBar, find, "after_start");
            LayoutUtils.sameWidth(find, this);
		}
	}	//	cmd_find

	/**
	 * Open print format window
	 */
	private void cmd_customize()
	{
		int AD_PrintFormat_ID = m_reportEngine.getPrintFormat().get_ID();
		int pfAD_Window_ID = MPrintFormat.getZoomWindowID(AD_PrintFormat_ID);
		AEnv.zoom(pfAD_Window_ID, MQuery.getEqualQuery("AD_PrintFormat_ID", AD_PrintFormat_ID));
	}	//	cmd_customize
	
	/**
	 * IDEMPIERE-379 Report customization wizard
	 */
	private void cmd_Wizard()
	{
	    ADForm form = ADForm.openForm(SystemIDs.FORM_REPORT_WIZARD);
		WReportCustomization av = (WReportCustomization) form.getICustomForm();
		av.setReportEngine(m_reportEngine);
		form.setClosable(true);
		ZKUpdateUtil.setWidth(form, "70%");
		ZKUpdateUtil.setHeight(form, "85%");
		form.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (DialogEvents.ON_WINDOW_CLOSE.equals(event.getName())) {
					fillComboReport (m_reportEngine.getPrintFormat().get_ID());	
					cmd_report();		
				}
			}
		});
		form.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		SessionManager.getAppDesktop().showWindow(form);
	}	//	cmd_Wizard

	//-- ComponentCtrl --//
	public Object getExtraCtrl() {
		return new ExtraCtrl();
	}
	/** A utility class to implement {@link #getExtraCtrl}.
	 * It is used only by component developers.
	 */
	protected class ExtraCtrl extends XulElement.ExtraCtrl
	implements DynamicMedia {
		//-- DynamicMedia --//
		public Media getMedia(String pathInfo) {
			return media;
		}
	}
	
	private boolean ToolBarMenuRestictionLoaded = false;

	/**
	 * Hide not accessible toolbar
	 * @param AD_Window_ID
	 * @param AD_Process_ID
	 */
	public void updateToolbarAccess(int AD_Window_ID, int AD_Process_ID) {
		if (ToolBarMenuRestictionLoaded)
			return;
		Properties m_ctx = Env.getCtx();
		int ToolBarButton_ID = 0;

		int[] restrictionList = AD_Window_ID > 0 
				? MToolBarButtonRestrict.getOfWindow(m_ctx, MRole.getDefault().getAD_Role_ID(), AD_Window_ID, true, null)
				: MToolBarButtonRestrict.getOfReport(m_ctx, MRole.getDefault().getAD_Role_ID(), AD_Process_ID, null);
		if (log.isLoggable(Level.INFO))
			log.info("restrictionList="+restrictionList.toString());

		for (int i = 0; i < restrictionList.length; i++)
		{
			ToolBarButton_ID= restrictionList[i];
			X_AD_ToolBarButton tbt = new X_AD_ToolBarButton(m_ctx, ToolBarButton_ID, null);
			if (!"R".equals(tbt.getAction()))
				continue;
			
			String restrictName = tbt.getComponentName();
			if (log.isLoggable(Level.CONFIG)) log.config("tbt="+tbt.getAD_ToolBarButton_ID() + " / " + restrictName);

			for (Component p = this.toolBar.getFirstChild(); p != null; p = p.getNextSibling()) {
				if (p instanceof Toolbarbutton) {
					if ( restrictName.equals(((ToolBarButton)p).getName()) ) {
						this.toolBar.removeChild(p);
						break;
					}
				}
			}
		}	// All restrictions

		ToolBarMenuRestictionLoaded = true;
	}//updateToolbarAccess

	private void showBusyDialog() {		
		progressWindow = new BusyDialog();
		progressWindow.setStyle("position: absolute;");
		this.appendChild(progressWindow);
		showBusyMask(progressWindow);
		LayoutUtils.openOverlappedWindow(this, progressWindow, "middle_center");
	}
	
	private Div getMask() {
		if (mask == null) {
			mask = new Mask();
		}
		return mask;
	}
	
	private void showBusyMask(Window window) {
		getParent().appendChild(getMask());
		StringBuilder script = new StringBuilder("(function(){let w=zk.Widget.$('#");
		script.append(getParent().getUuid()).append("');");
		if (window != null) {
			script.append("let d=zk.Widget.$('#").append(window.getUuid()).append("');w.busy=d;");
		} else {
			script.append("w.busy=true;");
		}
		script.append("})()");
		Clients.response(new AuScript(script.toString()));
	}
	
	public void hideBusyMask() {
		if (mask != null && mask.getParent() != null) {
			mask.detach();
			StringBuilder script = new StringBuilder("(function(){let w=zk.Widget.$('#");
			script.append(getParent().getUuid()).append("');if(w){w.busy=false;}");
			script.append("})()");
			Clients.response(new AuScript(script.toString()));
		}
	}
	
	private void hideBusyDialog() {
		hideBusyMask();
		if (progressWindow != null) {
			progressWindow.dispose();
			progressWindow = null;
		}

		if (getDesktop() != null)
			clearTabOnCloseHandler();
	}

	private void clearTabOnCloseHandler() {
		Executions.schedule(getDesktop(), e -> {
			Component parent = this.getParent();
			while (parent != null) {
				if (parent instanceof Tabpanel) {
					Tabpanel parentTabPanel = (Tabpanel) parent;
					parentTabPanel.setOnCloseHandler(null);
					break;
				}
				parent = parent.getParent();
			}
		}, new Event("onClearTabOnCloseHandler"));
	}

	private static class RendererRunnable extends ZkContextRunnable implements IServerPushCallback {

		private ZkReportViewer viewer;
		private String rendererId;

		public RendererRunnable(ZkReportViewer viewer, String rendererId) {
			this.viewer = viewer;
			this.rendererId = rendererId;
		}
		
		@Override
		public void updateUI() {
			viewer.onPreviewReport();
		}

		@Override
		protected void doRun() {
			try {
				if (viewer.m_reportEngine.getPrintFormat().getJasperProcess_ID() > 0) {
					if (viewer.jasperPrintRenderer == null) {
						MPrintFormat format = viewer.m_reportEngine.getPrintFormat();
						PrintInfo printInfo = viewer.m_reportEngine.getPrintInfo();
						ProcessInfo jasperProcessInfo = new ProcessInfo (viewer.getTitle(), format.getJasperProcess_ID());
						jasperProcessInfo.setRecord_ID (printInfo.getRecord_ID());
						jasperProcessInfo.setTable_ID(printInfo.getAD_Table_ID());
						jasperProcessInfo.setSerializableObject(format);
						ArrayList<ProcessInfoParameter> jasperPrintParams = new ArrayList<ProcessInfoParameter>();
						ProcessInfoParameter pip = new ProcessInfoParameter(ServerReportCtl.PARAM_PRINT_FORMAT, format, null, null, null);
						jasperPrintParams.add(pip);
						pip = new ProcessInfoParameter(ServerReportCtl.PARAM_PRINT_INFO, printInfo, null, null, null);
						jasperPrintParams.add(pip);						
						jasperProcessInfo.setParameter(jasperPrintParams.toArray(new ProcessInfoParameter[]{}));
						jasperProcessInfo.setExport(true);
						jasperProcessInfo.setExportFileExtension("JasperPrint");
						ProcessCall pc = Core.getProcess("org.adempiere.report.jasper.ReportStarter");
						pc.startProcess(Env.getCtx(), jasperProcessInfo, null);						
						JasperPrint jasperPrint = (JasperPrint) jasperProcessInfo.getInternalReportObject();
						viewer.jasperPrintRenderer = new JasperPrintRenderer(jasperPrint, viewer.getTitle());
						viewer.jasperPrintRenderer.setRowCount(jasperProcessInfo.getRowCount());
					}
				} else {
					viewer.m_reportEngine.initName();
					List<String> archiveList = Arrays.asList(PDF_OUTPUT_TYPE, HTML_OUTPUT_TYPE, XLS_OUTPUT_TYPE, XLSX_OUTPUT_TYPE);
					if (archiveList.contains(rendererId)) {
						if (!ArchiveEngine.isValid(viewer.m_reportEngine.getLayout()))
							log.warning("Cannot archive Document");
					}
				}
				viewer.createNewMedia(rendererId);
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			} finally {		
				Desktop desktop = AEnv.getDesktop();
				if (desktop != null && desktop.isAlive()) {
					new ServerPushTemplate(desktop).executeAsync(this);
				}
			}
		}
		
	}
	
	private void createNewMedia(String rendererId) {
		media = null;
		media = getMedia(rendererId);
	}
	
	@Override
	public AMedia getMedia(String contentType, String fileExtension) {
		if (jasperPrintRenderer != null) {
			return jasperPrintRenderer.getMedia(contentType, fileExtension);
		}
		
		IReportViewerRenderer renderer = rendererMap.get(toRendererId(contentType, fileExtension));
		
		if (renderer.isSameContentForExportAndPreview() && media != null 
				&& media.getContentType().equals(contentType) && media.getFormat().equals(fileExtension))
			return media;
				
		return renderer != null ? renderer.renderMedia(this, true) : null;
	}

	public AMedia getMedia(String rendererId) {
		if (jasperPrintRenderer != null) {
			return jasperPrintRenderer.getMedia(JasperPrintRenderer.getMIMEType(rendererId), JasperPrintRenderer.getFileExtension(rendererId));
		}
		IReportViewerRenderer renderer = rendererMap.get(rendererId);
		return renderer != null ? renderer.renderMedia(this, false) : null;
	}
	
	@Override
	public ExportFormat[] getExportFormats() {
		if (jasperPrintRenderer != null) {
			return jasperPrintRenderer.getExportFormats();
		}
		return exportMap.keySet().toArray(new ExportFormat[0]);
	}

	@Override
	public String getContentType() {
		return media != null ? media.getContentType() : null;
	}

	@Override
	public String getFileExtension() {
		return media != null ? media.getFormat() : null;
	}

	@Override
	public Map<MAuthorizationAccount, IUploadService> getUploadServiceMap() {
		return Collections.unmodifiableMap(uploadServicesMap);
	}

	@Override
	public String getReportName() {
		return m_reportEngine.getName();
	}

	/**
	 * Get report engine
	 * @return report engine
	 */
	public ReportEngine getReportEngine() {
		return m_reportEngine;
	}
	
	private void setupFindwindow(FindWindow findWindow) {
		findWindow.setTitle(null);
		findWindow.setBorder("none");	
		if (ClientInfo.maxHeight(ClientInfo.MEDIUM_HEIGHT-1))
			ZKUpdateUtil.setHeight(findWindow, "100%");
		else
			ZKUpdateUtil.setHeight(findWindow, "60%");
		findWindow.setSizable(false);
		findWindow.setContentStyle("background-color: #fff; width: 99%; margin: auto;");
	}
	
	/**
	 * Update Row Count label
	 */
	private void updateRowCount() {
		if(rowCount != null) {
			if (jasperPrintRenderer != null) {
				rowCount.setValue("");
			} else if (m_reportEngine.getPrintData() != null) {
				rowCount.setValue(Msg.getMsg(Env.getCtx(), "RowCount", new Object[] {m_reportEngine.getPrintData().getRowCount(false)}));
			} else {
				rowCount.setValue("");
			}
		}
	}
}
