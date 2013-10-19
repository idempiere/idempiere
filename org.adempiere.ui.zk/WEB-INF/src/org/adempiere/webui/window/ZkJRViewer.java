package org.adempiere.webui.window;

import static org.compiere.model.MSysConfig.ZK_REPORT_JASPER_OUTPUT_TYPE;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Level;

import javax.activation.FileDataSource;
import javax.servlet.http.HttpServletRequest;

import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.util.LocalJasperReportsContext;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Toolbar;

public class ZkJRViewer extends Window implements EventListener<Event>, ITabOnCloseHandler {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8378226782387071338L;

	private JasperPrint jasperPrint;
	private Listbox previewType = new Listbox();
	private Iframe iframe;
	private AMedia media;
	private String defaultType;
	private ToolBarButton bSendMail = new ToolBarButton();  // Added by Martin Augustine - Ntier software Services 09/10/2013
	private File attachment = null;
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ZkJRViewer.class);
	
	/** Window No					*/
	private int                 m_WindowNo = -1;

	private String m_title; // local title - embedded windows clear the title
	
	public ZkJRViewer(JasperPrint jasperPrint, String title) {
		super();
		this.setTitle(title);
		m_title = title;
		this.jasperPrint = jasperPrint;
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		init();
	}
	
	private void init() {
		final boolean isCanExport=MRole.getDefault().isCanExport();
		defaultType = MSysConfig.getValue(ZK_REPORT_JASPER_OUTPUT_TYPE, "PDF",
				Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));//It gets default Jasper output type

		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; height: 99%; width: 99%");
		this.appendChild(layout);
		this.setStyle("width: 100%; height: 100%; position: absolute");

		Toolbar toolbar = new Toolbar();
		toolbar.setHeight("26px");

		previewType.setMold("select");
		attachment = null;  // Added by Martin Augustine - Ntier software Services 09/10/2013
		if (isCanExport) {
			previewType.appendItem("PDF", "PDF");
			previewType.appendItem("HTML", "HTML");
			previewType.appendItem("Excel", "XLS");
			previewType.appendItem("CSV", "CSV");	
			if ("PDF".equals(defaultType)) {
				previewType.setSelectedIndex(0);
			} else if ("HTML".equals(defaultType)) {
				previewType.setSelectedIndex(1);
			} else if ("XLS".equals(defaultType)) {
				previewType.setSelectedIndex(2);
			} else if ("CSV".equals(defaultType)) {
				previewType.setSelectedIndex(3);
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
		bSendMail.setImage(ThemeManager.getThemeResource("images/SendMail24.png"));
		bSendMail.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "SendMail")));
		toolbar.appendChild(bSendMail);
		bSendMail.addEventListener(Events.ON_CLICK, this);

		North north = new North();
		layout.appendChild(north);
		north.appendChild(toolbar);

		Center center = new Center();
		layout.appendChild(center);
		iframe = new Iframe();
		iframe.setHflex("true");
		iframe.setVflex("true");
		iframe.setId("reportFrame");
		iframe.setHeight("100%");
		iframe.setWidth("100%");

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
			from, to, subject, "", new FileDataSource(attachment));
		AEnv.showWindow(dialog);

	}	//	cmd_sendMail

	public void onEvent(Event event) throws Exception {	
		if(event.getName().equals(Events.ON_CLICK) || event.getName().equals(Events.ON_SELECT))
			actionPerformed(event);
		
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
				media = new AMedia(m_title, "pdf", "application/pdf", attachment, true);
				
			} else if ("HTML".equals(reportType)) {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = makePrefix(jasperPrint.getName());
				if (log.isLoggable(Level.FINE))
				{
					log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				}
				File file = File.createTempFile(prefix, ".html", new File(path));
				
				JRHtmlExporter exporter = new JRHtmlExporter();
		          exporter.setParameter(JRExporterParameter.JASPER_PRINT,jasperPrint);
		          exporter.setParameter(JRExporterParameter.OUTPUT_FILE, file);
		          // Make images available for the HTML output  
		         exporter.setParameter(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR, Boolean.TRUE);
		         exporter.setParameter(JRHtmlExporterParameter.IMAGES_DIR_NAME, Executions.getCurrent().getDesktop().getSession().getWebApp().getRealPath("/images/report/"));
		         HttpServletRequest request = (HttpServletRequest)Executions.getCurrent().getNativeRequest();
		         exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, request.getContextPath()+"/images/report/");
		 	     exporter.exportReport();			
				media = new AMedia(m_title, "html", "text/html", file, false);
			} else if ("XLS".equals(reportType)) {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = makePrefix(jasperPrint.getName());
				if (log.isLoggable(Level.FINE))
				{
					log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				}
				File file = File.createTempFile(prefix, ".xls", new File(path));		
		        FileOutputStream fos = new FileOutputStream(file);
	
				// coding For Excel:
				JRXlsExporter exporterXLS = new JRXlsExporter();
				exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
				exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, fos);
				exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
				exporterXLS.exportReport();			
				media = new AMedia(m_title, "xls", "application/vnd.ms-excel", file, true);						
				
			}else if ("CSV".equals(reportType)) {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = makePrefix(jasperPrint.getName());
				if (log.isLoggable(Level.FINE))
				{
					log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				}
				File file = File.createTempFile(prefix, ".csv", new File(path));
				FileOutputStream fos = new FileOutputStream(file);
				JRCsvExporter exporter= new JRCsvExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT,  jasperPrint);
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM,  fos);
				exporter.exportReport();
				
				media = new AMedia(m_title, "csv", "application/csv", file, true);	
			}
		} finally {
			Thread.currentThread().setContextClassLoader(cl);
		}

		iframe.setSrc(null);
		Events.echoEvent("onRenderReport", this, null);		
	}
	
	private File getPDF() throws IOException, JRException {
		String path = System.getProperty("java.io.tmpdir");
		String prefix = makePrefix(jasperPrint.getName());
		if (log.isLoggable(Level.FINE))
		{
			log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
		}
		File file = new File(FileUtil.getTempMailName(prefix, ".pdf"));
		LocalJasperReportsContext context = new LocalJasperReportsContext(DefaultJasperReportsContext.getInstance());
		context.setClassLoader(JRPdfExporter.class.getClassLoader());
		JRPdfExporter exporter = new JRPdfExporter(context);
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, file.getAbsolutePath());
		exporter.exportReport();
		return file;
	}

	public void onRenderReport() {
		iframe.setContent(media);
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

}
