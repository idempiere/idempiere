package org.adempiere.webui.window;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;

import javax.activation.FileDataSource;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.ClientInfo;
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
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.PrintInfo;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
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

public class ZkJRViewer extends Window implements EventListener<Event>, ITabOnCloseHandler {
	/**
	 * 
	 */
	private static final long serialVersionUID = -812700088629098149L;

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
	protected ToolBarButton		bArchive			= new ToolBarButton();
	private PrintInfo			m_printInfo;
	
	private int mediaVersion = 0;
	
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
		defaultType = jasperPrint == null ? null : jasperPrint.getProperty("IDEMPIERE_REPORT_TYPE");
		if (Util.isEmpty(defaultType)) {
			defaultType = MSysConfig.getValue(MSysConfig.ZK_REPORT_JASPER_OUTPUT_TYPE, "PDF",
					Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));//It gets default Jasper output type
		}

		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; height: 99%; width: 99%");
		this.appendChild(layout);
		this.setStyle("width: 100%; height: 100%; position: absolute");

		Toolbar toolbar = new Toolbar();
		ZKUpdateUtil.setHeight(toolbar, "32px");

		previewType.setMold("select");
		attachment = null;  // Added by Martin Augustine - Ntier software Services 09/10/2013
		if (isCanExport) {
			previewType.appendItem("PDF", "PDF");
			previewType.appendItem("HTML", "HTML");
			previewType.appendItem("XLS", "XLS");
			previewType.appendItem("CSV", "CSV");
			previewType.appendItem("SSV", "SSV");
			previewType.appendItem("XLSX", "XLSX");
			if ("PDF".equals(defaultType)) {
				previewType.setSelectedIndex(0);
			} else if ("HTML".equals(defaultType)) {
				previewType.setSelectedIndex(1);
			} else if ("XLS".equals(defaultType)) {
				previewType.setSelectedIndex(2);
			} else if ("CSV".equals(defaultType)) {
				previewType.setSelectedIndex(3);
			} else if ("SSV".equals(defaultType)) {
				previewType.setSelectedIndex(4);
			} else if ("XLSX".equals(defaultType)) {
				previewType.setSelectedIndex(5);
			} else {
				previewType.setSelectedIndex(0);
				log.info("Format not Valid: "+defaultType);
			}
		} else {
			previewType.appendItem("PDF", "PDF");
			previewType.appendItem("HTML", "HTML");
			if ("PDF".equals(defaultType)) {
				previewType.setSelectedIndex(0);
			} else if ("HTML".equals(defaultType)) {
				previewType.setSelectedIndex(1);
			} else if ("XLS".equals(defaultType)) {
				previewType.setSelectedIndex(0); // default to PDF if cannot export
			} else if ("CSV".equals(defaultType)) {
				previewType.setSelectedIndex(0); // default to PDF if cannot export
			} else if ("SSV".equals(defaultType)) {
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

		North north = new North();
		layout.appendChild(north);
		north.appendChild(toolbar);
		ZKUpdateUtil.setVflex(north, "min");

		Center center = new Center();
		layout.appendChild(center);
		iframe = new Iframe();
		ZKUpdateUtil.setHflex(iframe, "true");
		ZKUpdateUtil.setVflex(iframe, "true");
		iframe.setId("reportFrame");
		ZKUpdateUtil.setHeight(iframe, "100%");
		ZKUpdateUtil.setWidth(iframe, "100%");

		try {
			renderReport();
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			throw new AdempiereException("Failed to render report.", e);
		}
		center.appendChild(iframe);

		this.setBorder("normal");
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
				FDialog.error(m_WindowNo, this, e.getLocalizedMessage(), m_title);
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
			if ( "PDF".equals( reportType ) )
			{
				attachment = getPDF();
				media = new AMedia(m_title + ".pdf", "pdf", "application/pdf", attachment, true);

			} else if ("HTML".equals(reportType)) {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, ".html", new File(path));

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
				media = new AMedia(m_title, "html", "text/html", file, false);
			} else if ("XLS".equals(reportType)) {
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
				media = new AMedia(m_title + ".xls", "xls", "application/vnd.ms-excel", file, true);

			} else if ("XLSX".equals(reportType)) {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, ".xlsx", new File(path));
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
				media = new AMedia(m_title + ".xlsx", "xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", file, true);

			}else if ("CSV".equals(reportType)) {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, ".csv", new File(path));
				FileOutputStream fos = new FileOutputStream(file);
				JRCsvExporter exporter= new JRCsvExporter();
				if (!isList){
					jasperPrintList = new ArrayList<>();
					jasperPrintList.add(jasperPrint);
				}
				exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
				exporter.setExporterOutput(new SimpleWriterExporterOutput(fos));
				exporter.exportReport();

				media = new AMedia(m_title + ".csv", "csv", "application/csv", file, true);

			}else if ("SSV".equals(reportType)) {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, ".ssv", new File(path));
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

				media = new AMedia(m_title, "ssv", "application/ssv", file, true);
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
		File file = new File(FileUtil.getTempMailName(prefix, ".pdf"));
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
		if (ClientInfo.isMobile()) {
			Listitem selected = previewType.getSelectedItem();
			String reportType=selected.getValue();
			if ( "PDF".equals( reportType ) ) {
				openWithPdfJsViewer();				
				return;
			}
		} else {
			Listitem selected = previewType.getSelectedItem();
			String reportType=selected.getValue();
			if (MSysConfig.getBooleanValue(MSysConfig.ZK_USE_PDF_JS_VIEWER, false, Env.getAD_Client_ID(Env.getCtx())) && "PDF".equals( reportType ) ) {
				openWithPdfJsViewer();
			} else {
				iframe.setSrc(null);
				iframe.setContent(media);
			}
		}
	}

	protected void openWithPdfJsViewer() {
		mediaVersion++;
		String url = Utils.getDynamicMediaURI(this, mediaVersion, media.getName(), media.getFormat());
		String pdfJsUrl = "pdf.js/web/viewer.html?file="+url;
		iframe.setContent(null);
		iframe.setSrc(pdfJsUrl);
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
				FDialog.info(m_WindowNo, this, "Archived");
			else
				FDialog.error(m_WindowNo, this, "ArchiveError");
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

}
