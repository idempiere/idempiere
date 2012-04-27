package org.adempiere.webui.window;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;

import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JExcelApiExporter;
import net.sf.jasperreports.engine.export.JExcelApiExporterParameter;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.session.SessionManager;
import org.compiere.util.CLogger;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zkex.zul.Borderlayout;
import org.zkoss.zkex.zul.Center;
import org.zkoss.zkex.zul.North;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Toolbar;

public class ZkJRViewer extends Window implements EventListener, ITabOnCloseHandler {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2776405512345445561L;
	private JasperPrint jasperPrint;
	private Listbox previewType = new Listbox();
	private Iframe iframe;
	private AMedia media;
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ZkJRViewer.class);
	
	/** Window No					*/
	private int                 m_WindowNo = -1;
	
	public ZkJRViewer(JasperPrint jasperPrint, String title) {
		super();
		this.setTitle(title);
		this.jasperPrint = jasperPrint;
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		init();
	}
	
	private void init() {
		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; height: 99%; width: 99%");
		this.appendChild(layout);
		this.setStyle("width: 100%; height: 100%; position: absolute");

		Toolbar toolbar = new Toolbar();
		toolbar.setHeight("26px");

		previewType.setMold("select");
		previewType.appendItem("PDF", "PDF");
		previewType.appendItem("HTML", "HTML");
		previewType.appendItem("Excel", "XLS");
		previewType.appendItem("CSV", "CSV");
		toolbar.appendChild(previewType);
		previewType.addEventListener(Events.ON_SELECT, this);
		
		North north = new North();
		layout.appendChild(north);
		north.appendChild(toolbar);

		Center center = new Center();
		center.setFlex(true);
		layout.appendChild(center);
		iframe = new Iframe();
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
		StringBuffer prefix = new StringBuffer();
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
	}	//	actionPerformed

	private void cmd_render() {
		try {
			renderReport();
		} catch (Exception e) {
			throw new AdempiereException("Failed to render report", e);
		}
	}
	public void onEvent(Event event) throws Exception {	
		if(event.getName().equals(Events.ON_CLICK) || event.getName().equals(Events.ON_SELECT))
			actionPerformed(event);
		
	}
	
	private void renderReport() throws Exception {
		Listitem selected = previewType.getSelectedItem();
		if (selected == null || "PDF".equals(selected.getValue())) {
			String path = System.getProperty("java.io.tmpdir");
			String prefix = makePrefix(jasperPrint.getName());
			if (log.isLoggable(Level.FINE))
			{
				log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
			}
			File file = File.createTempFile(prefix, ".pdf", new File(path));
			JasperExportManager.exportReportToPdfFile(jasperPrint, file.getAbsolutePath());
			media = new AMedia(getTitle(), "pdf", "application/pdf", file, true);
						
			
		} else if ("HTML".equals(previewType.getSelectedItem().getValue())) {
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
			media = new AMedia(getTitle(), "html", "text/html", file, false);
		} else if ("XLS".equals(previewType.getSelectedItem().getValue())) {
			String path = System.getProperty("java.io.tmpdir");
			String prefix = makePrefix(jasperPrint.getName());
			if (log.isLoggable(Level.FINE))
			{
				log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
			}
			File file = File.createTempFile(prefix, ".xls", new File(path));		
	        FileOutputStream fos = new FileOutputStream(file);

			// coding For Excel:
			// JRXlsExporter exporterXLS = new JRXlsExporter();
			// exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, );
			// exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, fos);
			// exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
        	JExcelApiExporter exporterXLS = new JExcelApiExporter();
        	exporterXLS.setParameter(JExcelApiExporterParameter.OUTPUT_FILE_NAME, file.getAbsolutePath());
        	exporterXLS.setParameter(JExcelApiExporterParameter.JASPER_PRINT, jasperPrint);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, Boolean.TRUE);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_DETECT_CELL_TYPE , Boolean.TRUE);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_IGNORE_CELL_BACKGROUND, Boolean.TRUE);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_IGNORE_GRAPHICS, Boolean.TRUE);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_COLLAPSE_ROW_SPAN, Boolean.TRUE);
        	exporterXLS.setParameter(JExcelApiExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
			exporterXLS.exportReport();			
			media = new AMedia(getTitle(), "xls", "application/vnd.ms-excel", file, true);						
			
		}else if ("CSV".equals(previewType.getSelectedItem().getValue())) {
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
			
			media = new AMedia(getTitle(), "csv", "application/csv", file, true);	
		}

		iframe.setSrc(null);
		Events.echoEvent("onRenderReport", this, null);		
	}
	
	public void onRenderReport() {
		iframe.setContent(media);
	}

	@Override
	public void onClose(Tabpanel tabPanel) {
		Tab tab = tabPanel.getLinkedTab();
		Tabbox tabbox = (Tabbox) tab.getTabbox();
		if (tabbox.getSelectedTab() == tab) {
			Tabs tabs = (Tabs) tabbox.getTabs();
			List<?> childs = tabs.getChildren();
			for(int i = 0; i < childs.size(); i++) {
				if (childs.get(i) == tab) {
					if (i > 0)
						tabbox.setSelectedIndex((i-1));
					break;
				}
			}
		}
		tabPanel.detach();
		tab.detach();
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
