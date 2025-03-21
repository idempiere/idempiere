/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.adempiere.webui.window;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
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
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
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

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

/**
 * Viewer for jasper report
 */
public class ZkJRViewer extends Window implements EventListener<Event>, ITabOnCloseHandler, IReportViewerExportSource {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8782402996207677811L;

	private Listbox previewType = new Listbox();
	private Iframe iframe;
	private AMedia media;
	private String defaultType;
	private ToolBarButton bSendMail = new ToolBarButton();  // Added by Martin Augustine - Ntier software Services 09/10/2013
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(ZkJRViewer.class);

	/** Window No					*/
	private int                 m_WindowNo = -1;

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
	
	protected Map<MAuthorizationAccount, IUploadService> uploadServicesMap = new HashMap<>();
	/**
	 * SysConfig USE_ESC_FOR_TAB_CLOSING
	 */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));
	
	private Center center;
	
	private JasperPrintRenderer jasperRenderer;
	
	/**
	 * @param jasperPrint
	 * @param title
	 * @param printInfo
	 */
	public ZkJRViewer(JasperPrint jasperPrint, String title, PrintInfo printInfo) {
		super();
		this.setTitle(title);
		m_title = title;
		jasperRenderer = new JasperPrintRenderer(jasperPrint, title);
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_WindowNo);
		m_printInfo = printInfo;
		init();
	}

	/**
	 * @param jasperPrintList
	 * @param title
	 * @param printInfo
	 */
	public ZkJRViewer(java.util.List<JasperPrint> jasperPrintList, String title, PrintInfo printInfo) {
		super();
		this.setTitle(title);
		m_title = title;
		jasperRenderer = new JasperPrintRenderer(jasperPrintList, title);
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
			addEventListener(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this);
		} catch (Exception e) {}
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		try {
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
			removeEventListener(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this);
		} catch (Exception e) {}
	}

	/**
	 * Layout viewer
	 */
	private void init() {
		final boolean isCanExport=MRole.getDefault().isCanExport();
		defaultType = jasperRenderer.jasperPrint == null ? null : jasperRenderer.jasperPrint.getProperty(ReportStarter.IDEMPIERE_REPORT_TYPE);
		if (Util.isEmpty(defaultType)) {
			defaultType = MSysConfig.getValue(MSysConfig.ZK_REPORT_JASPER_OUTPUT_TYPE, "PDF",
					Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));//It gets default Jasper output type
		}

		if (Util.isEmpty(defaultType)) {
			defaultType = PDF_OUTPUT_TYPE;
		}
		
		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; height: 99%; width: 99%");
		this.appendChild(layout);
		this.setStyle("width: 100%; height: 100%; position: absolute");

		ZKUpdateUtil.setHeight(toolbar, "32px");

		previewType.setMold("select");
		ValueNamePair[] previewTypes = JasperPrintRenderer.getPreviewType(isCanExport);
		for(int i = 0; i < previewTypes.length; i++) {
			previewType.appendItem(previewTypes[i].getName(), previewTypes[i].getValue());
			if (previewTypes[i].getValue().equals(defaultType))
				previewType.setSelectedIndex(i);
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
	
	/**
	 * Hide not accessible toolbar button
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

	/**
	 * 	Handle event
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

	/**
	 * Render report
	 */
	private void cmd_render() {
		try {
			renderReport();
		} catch (Exception e) {
			throw new AdempiereException("Failed to render report", e);
		}
	}

	/**
	 * Email report as pdf attachment
	 */
	private void cmd_sendMail()
	{
		File attachment = jasperRenderer.getPDF();
		if (attachment == null) {
			try {
				attachment = createPDF();
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
			m_WindowNo, m_printInfo.getAD_Table_ID(), m_printInfo.getRecord_ID(),
			m_printInfo.getRecord_UU(), m_printInfo);

		AEnv.showWindow(dialog);
	}	//	cmd_sendMail

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(Events.ON_CLICK) || event.getName().equals(Events.ON_SELECT)) {
			actionPerformed(event);
		} else if (event.getName().equals(Events.ON_CTRL_KEY)) {
			KeyEvent keyEvent = (KeyEvent) event;
			if (LayoutUtils.isReallyVisible(this))
				this.onCtrlKeyEvent(keyEvent);
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
	 * Handle key event
	 * @param keyEvent
	 */
	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		if ((keyEvent.isAltKey() && keyEvent.getKeyCode() == 0x58)	// Alt-X
				|| (keyEvent.getKeyCode() == 0x1B && isUseEscForTabClosing)) {	// ESC
			keyEvent.stopPropagation();
			Events.echoEvent(new Event(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this));
		}
	}

	/**
	 * Render report
	 * @throws Exception
	 */
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

	/**
	 * Create PDF output
	 * @return PDF file
	 * @throws IOException
	 * @throws JRException
	 */
	private File createPDF() throws IOException, JRException {
		return jasperRenderer.createPDF();
	}

	/**
	 * Handle onRenderReport event
	 */
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

	/**
	 * Open report using javascript pdf viewer (pdf.js from Mozilla)
	 */
	protected void openWithPdfJsViewer() {
		attachIFrame();
		mediaVersion++;
		String url = Utils.getDynamicMediaURI(this, mediaVersion, media.getName(), media.getFormat());
		String pdfJsUrl = AEnv.toPdfJsUrl(url);
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
		if (jasperRenderer != null || m_WindowNo >= 0)
		{
			SessionManager.getAppDesktop().unregisterWindow(m_WindowNo);
			jasperRenderer = null;
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
			File file = jasperRenderer.getPDF();
			if (file == null)
				file = createPDF();
			byte[] data = getFileByteData(file);
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
	 * Save jasper report as attachment of a record (AD_Table_ID and Record_ID from {@link #m_printInfo})
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
	 * convert File data into byte[]
	 * @param tempFile
	 * @return content of file in byte[]
	 */
	private byte[] getFileByteData(File tempFile)
	{
		byte fileContent[] = new byte[(int) tempFile.length()];

		try (FileInputStream fis = new FileInputStream(tempFile))
		{
			fis.read(fileContent);
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
	
	/**
	 * Upload to external destination
	 */
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
		
		return jasperRenderer.getMedia(contentType, fileExtension);
	}

	@Override
	public ExportFormat[] getExportFormats() {
		return jasperRenderer.getExportFormats();
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
