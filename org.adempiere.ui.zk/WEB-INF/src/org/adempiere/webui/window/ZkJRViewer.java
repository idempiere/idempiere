package org.adempiere.webui.window;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.function.Supplier;
import java.util.logging.Level;

import javax.activation.FileDataSource;

import org.adempiere.base.upload.IUploadService;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.report.jasper.ReportStarter;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.Extensions;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MArchive;
import org.compiere.model.MAttachment;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MToolBarButtonRestrict;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.PrintInfo;
import org.compiere.model.X_AD_ToolBarButton;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.ui.zk.media.IMediaView;
import org.idempiere.ui.zk.media.WMediaOptions;
import org.zkoss.util.media.AMedia;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.ext.render.DynamicMedia;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.impl.Utils;
import org.zkoss.zul.impl.XulElement;

import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.SimpleJasperReportsContext;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleCsvExporterConfiguration;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleHtmlReportConfiguration;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleWriterExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;

public class ZkJRViewer extends Window implements EventListener<Event>, ITabOnCloseHandler, IReportViewerExportSource {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7204858572267608018L;

	private JasperPrint jasperPrint;
	private java.util.List<JasperPrint> jasperPrintList;
	private boolean isList;
	private Listbox previewType = new Listbox();
	private Iframe iframe;
	private AMedia media;
	private String defaultType;
	private ToolBarButton bSendMail = new ToolBarButton();  // Added by Martin Augustine - Ntier software Services 09/10/2013
	private File attachment = null;
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(ZkJRViewer.class);

	/** Window No					*/
	private int                 m_WindowNo = -1;
	private long prevKeyEventTime = 0;
	private KeyEvent prevKeyEvent;

	private String m_title; // local title - embedded windows clear the title
	Toolbar toolbar = new Toolbar();
	protected ToolBarButton		bArchive			= new ToolBarButton();
	protected ToolBarButton		bAttachment			= new ToolBarButton();
	protected ToolBarButton bExport = new ToolBarButton();
	protected ToolBarButton bCloudUpload = new ToolBarButton();
	private PrintInfo			m_printInfo;
	
	private int mediaVersion = 0;
	
	protected static final String CSV_OUTPUT_TYPE = "CSV";	
	protected static final String HTML_OUTPUT_TYPE = "HTML";	
	protected static final String PDF_OUTPUT_TYPE = "PDF";
	protected static final String XLS_OUTPUT_TYPE = "XLS";	
	protected static final String XLSX_OUTPUT_TYPE = "XLSX";
	
	protected final Map<String, Supplier<AMedia>> mediaSuppliers = new HashMap<String, Supplier<AMedia>>();
	protected Map<MAuthorizationAccount, IUploadService> uploadServicesMap = new HashMap<>();
	
	private final ExportFormat[] exportFormats = new ExportFormat[] {
			new ExportFormat(PDF_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FilePDF"), PDF_FILE_EXT, PDF_MIME_TYPE),
			new ExportFormat(HTML_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileHTML"), HTML_FILE_EXT, HTML_MIME_TYPE),			
			new ExportFormat(CSV_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileCSV"), CSV_FILE_EXT, CSV_MIME_TYPE),
			new ExportFormat(EXCEL_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileXLS"), EXCEL_FILE_EXT, EXCEL_MIME_TYPE),
			new ExportFormat(EXCEL_XML_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileXLSX"), EXCEL_XML_FILE_EXT, EXCEL_XML_MIME_TYPE),
			new ExportFormat(SSV_FILE_EXT + " - " + Msg.getMsg(Env.getCtx(), "FileSSV"), SSV_FILE_EXT, CSV_MIME_TYPE)
	};

	private Center center;
	
	public ZkJRViewer(JasperPrint jasperPrint, String title, PrintInfo printInfo) {
		super();
		this.setTitle(title);
		m_title = title;
		this.jasperPrint = jasperPrint;
		this.isList = false;
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_WindowNo);
		m_printInfo = printInfo;
		init();
	}

	public ZkJRViewer(java.util.List<JasperPrint> jasperPrintList, String title, PrintInfo printInfo) {
		super();
		this.setTitle(title);
		m_title = title;
		this.jasperPrintList = jasperPrintList;
		this.isList = true;
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_WindowNo);
		m_printInfo = printInfo;
		init();
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		try {
			SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
		} catch (Exception e) {}
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		try {
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
		} catch (Exception e) {}
	}

	private void init() {
		final boolean isCanExport=MRole.getDefault().isCanExport();
		defaultType = jasperPrint == null ? null : jasperPrint.getProperty(ReportStarter.IDEMPIERE_REPORT_TYPE);
		if (Util.isEmpty(defaultType)) {
			defaultType = MSysConfig.getValue(MSysConfig.ZK_REPORT_JASPER_OUTPUT_TYPE, "PDF",
					Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));//It gets default Jasper output type
		}

		if (Util.isEmpty(defaultType)) {
			defaultType = PDF_OUTPUT_TYPE;
		}
		
		initMediaSuppliers();
		
		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; height: 99%; width: 99%");
		this.appendChild(layout);
		this.setStyle("width: 100%; height: 100%; position: absolute");

		ZKUpdateUtil.setHeight(toolbar, "32px");

		previewType.setMold("select");
		attachment = null;  // Added by Martin Augustine - Ntier software Services 09/10/2013
		if (isCanExport) {
			previewType.appendItem(PDF_OUTPUT_TYPE, PDF_OUTPUT_TYPE);
			previewType.appendItem(HTML_OUTPUT_TYPE, HTML_OUTPUT_TYPE);
			previewType.appendItem(XLS_OUTPUT_TYPE, XLS_OUTPUT_TYPE);
			previewType.appendItem(CSV_OUTPUT_TYPE, CSV_OUTPUT_TYPE);
			previewType.appendItem(XLSX_OUTPUT_TYPE, XLSX_OUTPUT_TYPE);
			if (PDF_OUTPUT_TYPE.equals(defaultType)) {
				previewType.setSelectedIndex(0);
			} else if (HTML_OUTPUT_TYPE.equals(defaultType)) {
				previewType.setSelectedIndex(1);
			} else if (XLS_OUTPUT_TYPE.equals(defaultType)) {
				previewType.setSelectedIndex(2);
			} else if (CSV_OUTPUT_TYPE.equals(defaultType)) {
				previewType.setSelectedIndex(3);
			} else if (XLSX_OUTPUT_TYPE.equals(defaultType)) {
				previewType.setSelectedIndex(4);
			} else {
				previewType.setSelectedIndex(0);
				log.info("Format not Valid: "+defaultType);
			}
		} else {
			previewType.appendItem(PDF_OUTPUT_TYPE, PDF_OUTPUT_TYPE);
			previewType.appendItem(HTML_OUTPUT_TYPE, HTML_OUTPUT_TYPE);
			if ("PDF".equals(defaultType)) {
				previewType.setSelectedIndex(0);
			} else if ("HTML".equals(defaultType)) {
				previewType.setSelectedIndex(1);
			} else if ("XLS".equals(defaultType)) {
				previewType.setSelectedIndex(0); // default to PDF if cannot export
			} else if ("CSV".equals(defaultType)) {
				previewType.setSelectedIndex(0); // default to PDF if cannot export
			} else if ("XLSX".equals(defaultType)) {
				previewType.setSelectedIndex(0); // default to PDF if cannot export
			} else {
				previewType.setSelectedIndex(0);
				log.info("Format not Valid: "+defaultType);
			}
		}

		toolbar.appendChild(previewType);
		previewType.addEventListener(Events.ON_SELECT, this);

		// Added BY Martin - Ntier Software Services 09/10/2013
		toolbar.appendChild(new Separator("vertical"));
		bSendMail.setName("SendMail");  // ?? Msg
		if (ThemeManager.isUseFontIconForImage())
			bSendMail.setIconSclass("z-icon-SendMail");
		else
			bSendMail.setImage(ThemeManager.getThemeResource("images/SendMail24.png"));
		bSendMail.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "SendMail")));
		toolbar.appendChild(bSendMail);
		bSendMail.addEventListener(Events.ON_CLICK, this);
		
		toolbar.appendChild(new Separator("vertical"));
		bArchive.setName("Archive");
		if (ThemeManager.isUseFontIconForImage())
			bArchive.setIconSclass("z-icon-Archive");
		else
			bArchive.setImage(ThemeManager.getThemeResource("images/Archive24.png"));
		bArchive.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Archive")));
		toolbar.appendChild(bArchive);
		bArchive.addEventListener(Events.ON_CLICK, this);

		int tableId = m_printInfo.getAD_Table_ID();
		int recordId = m_printInfo.getRecord_ID();
		if (tableId > 0 && recordId > 0) {
			toolbar.appendChild(new Separator("vertical"));
			bAttachment.setName("Attachment");
			if (ThemeManager.isUseFontIconForImage())
				bAttachment.setIconSclass("z-icon-Attachment");
			else
				bAttachment.setImage(ThemeManager.getThemeResource("images/Attachment24.png"));
			bAttachment.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Attachment")));
			toolbar.appendChild(bAttachment);
			bAttachment.addEventListener(Events.ON_CLICK, this);
		}

		if ( isCanExport )
		{
			bExport.setName("Export");
			if (ThemeManager.isUseFontIconForImage())
				bExport.setIconSclass("z-icon-Export");
			else
				bExport.setImage(ThemeManager.getThemeResource("images/Export24.png"));
			bExport.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Export")));
			toolbar.appendChild(bExport);
			bExport.addEventListener(Events.ON_CLICK, this);
			if (ThemeManager.isUseFontIconForImage())
				LayoutUtils.addSclass("medium-toolbarbutton", bExport);
			
			uploadServicesMap = MAuthorizationAccount.getUserUploadServices();
			if (uploadServicesMap.size() > 0) {
				bCloudUpload.setName("CloudUpload");
				if (ThemeManager.isUseFontIconForImage())
					bCloudUpload.setIconSclass("z-icon-FileImport");
				else
					bCloudUpload.setImage(ThemeManager.getThemeResource("images/FileImport24.png"));
				bCloudUpload.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "CloudUpload")));
				toolbar.appendChild(bCloudUpload);
				bCloudUpload.addEventListener(Events.ON_CLICK, this);
			}
		}
		
		North north = new North();
		layout.appendChild(north);
		north.appendChild(toolbar);
		ZKUpdateUtil.setVflex(north, "min");

		center = new Center();
		layout.appendChild(center);
		iframe = new Iframe();
		ZKUpdateUtil.setHflex(iframe, "true");
		ZKUpdateUtil.setVflex(iframe, "true");
		iframe.setId("reportFrame");
		ZKUpdateUtil.setHeight(iframe, "100%");
		ZKUpdateUtil.setWidth(iframe, "100%");

		int AD_Window_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNo, "_WinInfo_AD_Window_ID", true);
		int AD_Process_ID = m_printInfo.getAD_Process_ID();
		updateToolbarAccess(AD_Window_ID, AD_Process_ID);

		try {
			renderReport();
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			throw new AdempiereException("Failed to render report.", e);
		}
		center.appendChild(iframe);

		this.setBorder("normal");				
	}

	private boolean ToolBarMenuRestictionLoaded = false;
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

			for (Component p = this.toolbar.getFirstChild(); p != null; p = p.getNextSibling()) {
				if (p instanceof Toolbarbutton) {
					if ( restrictName.equals(((ToolBarButton)p).getName()) ) {
						this.toolbar.removeChild(p);
						break;
					}
				}
			}
		}	// All restrictions

		ToolBarMenuRestictionLoaded = true;
	}//updateToolbarAccess

	private void initMediaSuppliers() {
		mediaSuppliers.put(toMediaType(PDF_MIME_TYPE, PDF_FILE_EXT), () -> {
			try {
				attachment = getPDF();
				return new AMedia(m_title+"."+PDF_FILE_EXT, PDF_FILE_EXT, PDF_MIME_TYPE, attachment, true);			
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(HTML_MIME_TYPE, HTML_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+HTML_FILE_EXT, new File(path));
	
				HtmlExporter exporter = new HtmlExporter();
				SimpleHtmlReportConfiguration htmlConfig = new SimpleHtmlReportConfiguration();
				htmlConfig.setEmbedImage(true);
				htmlConfig.setAccessibleHtml(true);
				if (!isList){
					jasperPrintList = new ArrayList<>();
					jasperPrintList.add(jasperPrint);
				}
				exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
				exporter.setExporterOutput(new SimpleHtmlExporterOutput(file));
				exporter.setConfiguration(htmlConfig);
		 	    exporter.exportReport();
				return new AMedia(m_title+"."+HTML_FILE_EXT, HTML_FILE_EXT, HTML_MIME_TYPE, file, false);
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(EXCEL_MIME_TYPE, EXCEL_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, ".xls", new File(path));
		        FileOutputStream fos = new FileOutputStream(file);
	
				// coding For Excel:
				JRXlsExporter exporterXLS = new JRXlsExporter();
				SimpleXlsReportConfiguration xlsConfig = new SimpleXlsReportConfiguration();
				xlsConfig.setOnePagePerSheet(false);
	
				if (!isList){
					jasperPrintList = new ArrayList<>();
					jasperPrintList.add(jasperPrint);
				}
				exporterXLS.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
				exporterXLS.setExporterOutput(new SimpleOutputStreamExporterOutput(fos));
				exporterXLS.setConfiguration(xlsConfig);
				exporterXLS.exportReport();
				return new AMedia(m_title+"."+EXCEL_FILE_EXT, EXCEL_FILE_EXT, EXCEL_MIME_TYPE, file, true);
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(EXCEL_XML_MIME_TYPE, EXCEL_XML_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+EXCEL_XML_FILE_EXT, new File(path));
		        FileOutputStream fos = new FileOutputStream(file);
	
				// coding For Excel:
				JRXlsxExporter exporterXLSX = new JRXlsxExporter();
				SimpleXlsxReportConfiguration xlsxConfig = new SimpleXlsxReportConfiguration();
				xlsxConfig.setOnePagePerSheet(false);
	
				if (!isList){
					jasperPrintList = new ArrayList<>();
					jasperPrintList.add(jasperPrint);
				}
				exporterXLSX.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
				exporterXLSX.setExporterOutput(new SimpleOutputStreamExporterOutput(fos));
				exporterXLSX.setConfiguration(xlsxConfig);
				exporterXLSX.exportReport();
				return new AMedia(m_title+"."+EXCEL_XML_FILE_EXT, EXCEL_XML_FILE_EXT, EXCEL_XML_MIME_TYPE, file, true);
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(CSV_MIME_TYPE, CSV_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+CSV_FILE_EXT, new File(path));
				FileOutputStream fos = new FileOutputStream(file);
				JRCsvExporter exporter= new JRCsvExporter();
				if (!isList){
					jasperPrintList = new ArrayList<>();
					jasperPrintList.add(jasperPrint);
				}
				exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
				exporter.setExporterOutput(new SimpleWriterExporterOutput(fos));
				exporter.exportReport();
	
				return new AMedia(m_title+"."+CSV_FILE_EXT, CSV_FILE_EXT, CSV_MIME_TYPE, file, false);
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(CSV_MIME_TYPE, SSV_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+SSV_FILE_EXT, new File(path));
				FileOutputStream fos = new FileOutputStream(file);
				JRCsvExporter exporter= new JRCsvExporter();
				SimpleCsvExporterConfiguration csvConfig = new SimpleCsvExporterConfiguration();
				csvConfig.setFieldDelimiter(";");
				if (!isList){
					jasperPrintList = new ArrayList<>();
					jasperPrintList.add(jasperPrint);
				}
				exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
				exporter.setExporterOutput(new SimpleWriterExporterOutput(fos));
				exporter.setConfiguration(csvConfig);
				exporter.exportReport();
	
				return new AMedia(m_title+"."+SSV_FILE_EXT, SSV_FILE_EXT, CSV_MIME_TYPE, file, false);
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
	}
	
	private String toMediaType(String contentType, String fileExtension) {
		return contentType + ";" + fileExtension;
	}
	
	private String makePrefix(String name) {
		StringBuilder prefix = new StringBuilder();
		char[] nameArray = name.toCharArray();
		for (char ch : nameArray) {
			if (Character.isLetterOrDigit(ch)) {
				prefix.append(ch);
			} else {
				prefix.append("_");
			}
		}
		return prefix.toString();
	}
	/**************************************************************************
	 * 	Action Listener
	 * 	@param e event
	 */
	public void actionPerformed (Event e)
	{

		if (e.getTarget() == previewType)
			cmd_render();
		else if (e.getTarget() == bSendMail)  // Added by Martin Augustine - Ntier software services 09/10/2013
			cmd_sendMail();
		else if (e.getTarget() == bArchive)
			cmd_archive();
		else if (e.getTarget() == bAttachment)
			cmd_attachment();
		else if (e.getTarget() == bExport)
			cmd_export();
		else if (e.getTarget() == bCloudUpload)
			cmd_upload();
	}	//	actionPerformed

	private void cmd_render() {
		try {
			renderReport();
		} catch (Exception e) {
			throw new AdempiereException("Failed to render report", e);
		}
	}

	// Added by Martin Augustine - Ntier Software Services 09/10/2013
	private void cmd_sendMail()
	{

		if (attachment == null) {
			try {
				attachment = getPDF();
			} catch (Exception e) {
				Dialog.error(m_WindowNo, e.getLocalizedMessage(), m_title);
				return;
			}
		}
		String to = "";
		MUser from = MUser.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()));
		String subject = m_title;

		WEMailDialog dialog = new WEMailDialog (Msg.getMsg(Env.getCtx(), "SendMail"),
			from, to, subject, "", new FileDataSource(attachment),
			m_WindowNo, m_printInfo.getAD_Table_ID(), m_printInfo.getRecord_ID(), m_printInfo);

		AEnv.showWindow(dialog);
	}	//	cmd_sendMail

	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(Events.ON_CLICK) || event.getName().equals(Events.ON_SELECT)) {
			actionPerformed(event);
		} else if (event.getName().equals(Events.ON_CTRL_KEY)) {
			KeyEvent keyEvent = (KeyEvent) event;
			if (LayoutUtils.isReallyVisible(this)) {
				//filter same key event that is too close
				//firefox fire key event twice when grid is visible
				long time = System.currentTimeMillis();
				if (prevKeyEvent != null && prevKeyEventTime > 0 &&
						prevKeyEvent.getKeyCode() == keyEvent.getKeyCode() &&
						prevKeyEvent.getTarget() == keyEvent.getTarget() &&
						prevKeyEvent.isAltKey() == keyEvent.isAltKey() &&
						prevKeyEvent.isCtrlKey() == keyEvent.isCtrlKey() &&
						prevKeyEvent.isShiftKey() == keyEvent.isShiftKey()) {
					if ((time - prevKeyEventTime) <= 300) {
						return;
					}
				}
				this.onCtrlKeyEvent(keyEvent);
			}
		}
	}

	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		if (keyEvent.isAltKey() && keyEvent.getKeyCode() == 0x58) { // Alt-X
			if (m_WindowNo > 0) {
				prevKeyEventTime = System.currentTimeMillis();
				prevKeyEvent = keyEvent;
				keyEvent.stopPropagation();
				SessionManager.getAppDesktop().closeWindow(m_WindowNo);
			}
		}
	}

	private void renderReport() throws Exception {
		String reportType;
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(JasperReport.class.getClassLoader());
			Listitem selected = previewType.getSelectedItem();
			reportType=selected.getValue();
			if (PDF_OUTPUT_TYPE.equals(reportType)) {
				createNewMedia(PDF_MIME_TYPE, PDF_FILE_EXT);
			} else if (HTML_OUTPUT_TYPE.equals(reportType)) {
				createNewMedia(HTML_MIME_TYPE, HTML_FILE_EXT);
			} else if (XLS_OUTPUT_TYPE.equals(reportType)) {
				createNewMedia(EXCEL_MIME_TYPE, EXCEL_FILE_EXT);
			} else if (XLSX_OUTPUT_TYPE.equals(reportType)) {
				createNewMedia(EXCEL_XML_MIME_TYPE, EXCEL_XML_FILE_EXT);
			} else if (CSV_OUTPUT_TYPE.equals(reportType)) {
				createNewMedia(CSV_MIME_TYPE, CSV_FILE_EXT);
			}
		} finally {
			Thread.currentThread().setContextClassLoader(cl);
		}

		iframe.setSrc(null);
		Events.echoEvent("onRenderReport", this, null);
	}

	private File getPDF() throws IOException, JRException {
		String path = System.getProperty("java.io.tmpdir");

		String prefix = null;
		if (isList)
			prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
		else
			prefix = makePrefix(jasperPrint.getName());

		if (log.isLoggable(Level.FINE))
		{
			log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
		}
		File file = new File(FileUtil.getTempMailName(prefix, "."+PDF_FILE_EXT));
		JasperReportsContext context = new SimpleJasperReportsContext(DefaultJasperReportsContext.getInstance());
		JRPdfExporter exporter = new JRPdfExporter(context);
		if (!isList){
			jasperPrintList = new ArrayList<>();
			jasperPrintList.add(jasperPrint);
		}
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(file));
		exporter.exportReport();
		return file;
	}

	public void onRenderReport() {
		Listitem selected = previewType.getSelectedItem();
		String reportType=selected.getValue();
		if (ClientInfo.isMobile()) {			
			if ( PDF_OUTPUT_TYPE.equals( reportType ) ) {
				openWithPdfJsViewer();				
			} else if (HTML_OUTPUT_TYPE.equals(reportType)) {
				attachIFrame();
				iframe.setSrc(null);
				iframe.setContent(media);
			} else {
				IMediaView view = null;
				boolean showOptions = false;
				if (XLS_OUTPUT_TYPE.equals(reportType) || XLSX_OUTPUT_TYPE.equals(reportType)) {						
					if (XLS_OUTPUT_TYPE.equals(reportType))
						view = Extensions.getMediaView(EXCEL_MIME_TYPE, EXCEL_FILE_EXT, true);
					else
						view = Extensions.getMediaView(EXCEL_XML_MIME_TYPE, EXCEL_XML_FILE_EXT, true);
					showOptions = true;
				} else if (CSV_OUTPUT_TYPE.equals(reportType)) {
					view = Extensions.getMediaView(CSV_MIME_TYPE, CSV_FILE_EXT, true);
					showOptions = true;
				}
				
				if (showOptions && (view != null || uploadServicesMap.size() > 0)) {
					clearPreviewContainer();
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
		} else {
			if (MSysConfig.getBooleanValue(MSysConfig.ZK_USE_PDF_JS_VIEWER, false, Env.getAD_Client_ID(Env.getCtx())) && "PDF".equals( reportType ) ) {
				openWithPdfJsViewer();
			} else {
				IMediaView view = null;
				boolean showOptions = false;
				if (XLS_OUTPUT_TYPE.equals(reportType) || XLSX_OUTPUT_TYPE.equals(reportType)) {						
					if (XLS_OUTPUT_TYPE.equals(reportType))
						view = Extensions.getMediaView(EXCEL_MIME_TYPE, EXCEL_FILE_EXT, false);
					else
						view = Extensions.getMediaView(EXCEL_XML_MIME_TYPE, EXCEL_XML_FILE_EXT, false);
					showOptions = true;
				} else if (CSV_OUTPUT_TYPE.equals(reportType)) {
					view = Extensions.getMediaView(CSV_MIME_TYPE, CSV_FILE_EXT, false);
					showOptions = true;
				}
				
				if (showOptions && (view != null || uploadServicesMap.size() > 0)) {
					clearPreviewContainer();
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
	}

	protected void openWithPdfJsViewer() {
		attachIFrame();
		mediaVersion++;
		String url = Utils.getDynamicMediaURI(this, mediaVersion, media.getName(), media.getFormat());
		String pdfJsUrl = "pdf.js/web/viewer.html?file="+url;
		iframe.setContent(null);
		iframe.setSrc(pdfJsUrl);
	}

	private void clearPreviewContainer() {
		center.getChildren().clear();
	}

	private void attachIFrame() {
		if (iframe != null && iframe.getPage() == null) {
			center.getChildren().clear();
			center.appendChild(iframe);
		}
	}
	
	@Override
	public void onClose(Tabpanel tabPanel) {
		Tab tab = tabPanel.getLinkedTab();
		tab.close();
		cleanUp();
	}

	@Override
	public void setParent(Component parent) {
		super.setParent(parent);
		if (parent != null) {
			if (parent instanceof Tabpanel) {
				Tabpanel tabPanel = (Tabpanel) parent;
				tabPanel.setOnCloseHandler(this);
			}
		}
	}

	private void cleanUp() {
		if (jasperPrint != null || m_WindowNo >= 0)
		{
			SessionManager.getAppDesktop().unregisterWindow(m_WindowNo);
			jasperPrint = null;
			m_WindowNo = -1;
		}
	}
	
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
  	
	/**
	 * Create archive for jasper report
	 */
	protected void cmd_archive()
	{
		boolean success = false;
		try
		{
			byte[] data = getFileByteData(getPDF());
			if (data != null && m_printInfo != null)
			{
				MArchive archive = new MArchive(Env.getCtx(), m_printInfo, null);
				archive.setBinaryData(data);
				success = archive.save();
			}

			if (success)
				Dialog.info(m_WindowNo, "Archived");
			else
				Dialog.error(m_WindowNo, "ArchiveError");
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "Exception while reading file " + e);
		}
		catch (JRException e)
		{
			log.log(Level.SEVERE, "Error loading object from InputStream" + e);
		}
	} // cmd_archive

	/**
	 * Create archive for jasper report
	 */
	protected void cmd_attachment()
	{
		int tableId = m_printInfo.getAD_Table_ID();
		int recordId = m_printInfo.getRecord_ID();
		if (tableId == 0 || recordId == 0)
			return;
		boolean success = false;
		MTable table = MTable.get(tableId);
		PO po = table.getPO(recordId, null);
		MAttachment attachment = po.createAttachment();
		String fileName = m_title.replace(" ", "_") + "." + media.getFormat();
		byte[] data = media.isBinary() ? media.getByteData() : media.getStringData().getBytes();
		attachment.addEntry(fileName, data);
		success = attachment.save();
		if (success)
			Dialog.info(m_WindowNo, "Attached", fileName);
		else
			Dialog.error(m_WindowNo, "AttachError");
	} // cmd_archive

	/** 
	 * convert File data into Byte Data
	 * @param tempFile
	 * @return file in ByteData 
	 */
	private byte[] getFileByteData(File tempFile)
	{
		byte fileContent[] = new byte[(int) tempFile.length()];

		try
		{
			FileInputStream fis = new FileInputStream(tempFile);
			fis.read(fileContent);
			fis.close();
		}
		catch (FileNotFoundException e)
		{
			log.log(Level.SEVERE, "File not found  " + e);
		}
		catch (IOException ioe)
		{
			log.log(Level.SEVERE, "Exception while reading file " + ioe);
		}
		return fileContent;
	} // getFileByteData

	/**
	 * 	Export
	 */
	private void cmd_export()
	{		
		WReportExportDialog winExportFile = new WReportExportDialog(this);
		winExportFile.setTitle(Msg.getMsg(Env.getCtx(), "Export") + ": " + getTitle());
		winExportFile.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showWindow(winExportFile);
	}	//	cmd_export
	
	private void cmd_upload() {
		if (media == null)
			return;
		
		WReportUploadDialog winUploadFile = new WReportUploadDialog(this);
		winUploadFile.setTitle(Msg.getMsg(Env.getCtx(), "CloudUpload") + ": " + getTitle());
		winUploadFile.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showWindow(winUploadFile);
	}
	
	private void createNewMedia(String contentType, String fileExtension) {
		media = null;
		media = getMedia(contentType, fileExtension);
	}
		
	@Override
	public AMedia getMedia(String contentType, String fileExtension) {
		if (media != null && media.getContentType().equals(contentType) && media.getFormat().equals(fileExtension))
			return media;
		
		Supplier<AMedia> supplier = mediaSuppliers.get(toMediaType(contentType, fileExtension));
		return supplier != null ? supplier.get() : null;
	}

	@Override
	public ExportFormat[] getExportFormats() {
		return exportFormats;
	}

	@Override
	public String getContentType() {
		return media.getContentType();
	}

	@Override
	public String getFileExtension() {
		return media.getFormat();
	}

	@Override
	public Map<MAuthorizationAccount, IUploadService> getUploadServiceMap() {
		return uploadServicesMap;
	}

	@Override
	public String getReportName() {
		return m_title;
	}

}
