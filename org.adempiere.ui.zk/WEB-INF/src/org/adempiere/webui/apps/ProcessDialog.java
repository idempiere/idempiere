package org.adempiere.webui.apps;

import static org.compiere.model.SystemIDs.PROCESS_C_INVOICE_GENERATE;
import static org.compiere.model.SystemIDs.PROCESS_M_INOUT_GENERATE;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Future;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.util.ContextRunnable;
import org.adempiere.util.IProcessUI;
import org.adempiere.util.ServerContext;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.process.WProcessInfo;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.MultiFileDownloadDialog;
import org.adempiere.webui.window.SimplePDFViewer;
import org.compiere.Adempiere;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Text;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Html;
import org.zkoss.zul.Label;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

import com.lowagie.text.Document;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfWriter;

/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Low Heng Sin											  *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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



/**
 *	Dialog to Start process or report.
 *	Displays information about the process
 *		and lets the user decide to start it
 *  	and displays results (optionally print them).
 *  Calls ProcessCtl to execute.
 *  @author 	Low Heng Sin
 *  @author     arboleda - globalqss
 *  - Implement ShowHelp option on processes and reports
 */
public class ProcessDialog extends Window implements EventListener<Event>, IProcessUI
{
	/**
	 * generate serial version ID
	 */
	private static final long serialVersionUID = 5545731871518761455L;
	private static final String MESSAGE_DIV_STYLE = "max-height: 150pt; overflow: auto";	
	private Div messageDiv;
	private Center center;
	private Table logMessageTable;
	private North north;

	private List<File> downloadFiles;
	
	/**
	 * Dialog to start a process/report
	 * @param ctx
	 * @param parent
	 * @param title
	 * @param aProcess
	 * @param WindowNo
	 * @param AD_Process_ID
	 * @param tableId
	 * @param recordId
	 * @param autoStart
	 */
	public ProcessDialog (int AD_Process_ID, boolean isSOTrx)
	{
		log.info("Process=" + AD_Process_ID );
		m_ctx = Env.getCtx();
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		this.setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_WindowNo);
		m_AD_Process_ID = AD_Process_ID;
		Env.setContext(Env.getCtx(), m_WindowNo, "IsSOTrx", isSOTrx ? "Y" : "N");
		try
		{
			initComponents();
			init();
			addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
	}	//	ProcessDialog

	private void initComponents() {
		this.setStyle("position: absolute; width: 100%; height: 100%");
		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; width: 100%; height: 100%; border: none;");
		messageDiv = new Div();
		message = new Html();
		messageDiv.appendChild(message);
		messageDiv.setStyle(MESSAGE_DIV_STYLE);
		messageDiv.setId("message");
		
		north = new North();
		north.appendChild(messageDiv);
		layout.appendChild(north);
		north.setAutoscroll(true);
		north.setStyle("border: none;");
		
		centerPanel = new Panel();
		center = new Center();
		layout.appendChild(center);
		center.appendChild(centerPanel);
		centerPanel.setHflex("1");
		centerPanel.setVflex("1");
		center.setAutoscroll(true);
		center.setStyle("border: none");
		
		Div div = new Div();
		Hbox hbox = new Hbox();
		@SuppressWarnings("unused")
		String label = Msg.getMsg(Env.getCtx(), "Start");
		// Invert - Unify  OK/Cancel IDEMPIERE-77
		//bOK = new Button(label.replaceAll("&", ""));
		bOK = new Button();
		bOK.setImage("/images/Ok16.png");
		bOK.setId("Ok");
		bOK.addEventListener(Events.ON_CLICK, this);
		bOK.setSclass("action-image-text-button");
		hbox.appendChild(bOK);
		
		//label = Msg.getMsg(Env.getCtx(), "Cancel");
		Button btn = new Button();
		btn.setImage("/images/Cancel16.png");
		btn.setId("Cancel");
		btn.addEventListener(Events.ON_CLICK, this);
		btn.setSclass("action-image-text-button");
		hbox.appendChild(btn);		
		div.appendChild(hbox);
		div.setStyle("padding: 10px; text-align: center; text-align: -webkit-center; text-align: -moz-center; ");
		
		South south = new South();
		layout.appendChild(south);
		south.appendChild(div);		
		this.appendChild(layout);
	}

	private int m_WindowNo;
	private Properties m_ctx;
	private int 		    m_AD_Process_ID;
	private String		    m_Name = null;
	
	private int[]		    m_ids = null;
	private StringBuffer	m_messageText = new StringBuffer();
	private String          m_ShowHelp = null; // Determine if a Help Process Window is shown
	
	private Panel centerPanel = null;
	private Html message = null;
	private Button bOK = null;
	
	private boolean valid = true;
	
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ProcessDialog.class);
	//
	private ProcessParameterPanel parameterPanel = null;
	
	private ProcessInfo m_pi = null;
	private boolean m_isLocked = false;
	private boolean isParameterPage = true;
	private String initialMessage;
	private BusyDialog progressWindow;
	private Future<?> future;
	private ProcessDialogRunnable processDialogRunnable;

	private static final String ON_STATUS_UPDATE = "onStatusUpdate";
	private static final String ON_COMPLETE = "onComplete";
	
	/**
	 * 	Set Visible 
	 * 	(set focus to OK if visible)
	 * 	@param visible true if visible
	 */
	public boolean setVisible (boolean visible)
	{
		return super.setVisible(visible);
	}	//	setVisible

	/**
	 *	Dispose
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeWindow(m_WindowNo);
		valid = false;
	}//	dispose

	/**
	 *	Dynamic Init
	 *  @return true, if there is something to process (start from menu)
	 */
	public boolean init()
	{
		log.config("");
		//
		boolean trl = !Env.isBaseLanguage(m_ctx, "AD_Process");
		String sql = "SELECT Name, Description, Help, IsReport, ShowHelp "
				+ "FROM AD_Process "
				+ "WHERE AD_Process_ID=?";
		if (trl)
			sql = "SELECT t.Name, t.Description, t.Help, p.IsReport, p.ShowHelp "
				+ "FROM AD_Process p, AD_Process_Trl t "
				+ "WHERE p.AD_Process_ID=t.AD_Process_ID"
				+ " AND p.AD_Process_ID=? AND t.AD_Language=?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_AD_Process_ID);
			if (trl)
				pstmt.setString(2, Env.getAD_Language(m_ctx));
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				m_Name = rs.getString(1);
				m_ShowHelp = rs.getString(5);
				//
				m_messageText.append("<b>");
				String s = rs.getString(2);		//	Description
				if (rs.wasNull())
					m_messageText.append(Msg.getMsg(m_ctx, "StartProcess?"));
				else
					m_messageText.append(s);
				m_messageText.append("</b>");
				
				s = rs.getString(3);			//	Help
				if (!rs.wasNull())
					m_messageText.append("<p>").append(s).append("</p>");
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return false;
		}
		finally
		{
			DB.close(rs, pstmt);
		}

		if (m_Name == null)
			return false;
		//
		this.setTitle(m_Name);
		initialMessage = m_messageText.toString();
		message.setContent(initialMessage);
		bOK.setLabel(Msg.getMsg(Env.getCtx(), "Start"));

		//	Move from APanel.actionButton
		m_pi = new WProcessInfo(m_Name, m_AD_Process_ID);
		m_pi.setAD_User_ID (Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		parameterPanel = new ProcessParameterPanel(m_WindowNo, m_pi, "70%");
		centerPanel.getChildren().clear();
		if ( parameterPanel.init() ) {
			centerPanel.appendChild(parameterPanel);
		} else {
			if (m_ShowHelp != null && m_ShowHelp.equals("N")) {
				startProcess();
			}
		}
		
		// Check if the process is a silent one
		if(m_ShowHelp != null && m_ShowHelp.equals("S"))
		{
			startProcess();
		}
		return true;
	}	//	init

	public void startProcess()
	{
		m_pi.setPrintPreview(true);

		this.lockUI(m_pi);
		
		downloadFiles = new ArrayList<File>();
		
		Clients.response(new AuEcho(this, "runProcess", null));
	}

	public void runProcess() {
		//prepare context for background thread
		Properties context = ServerContext.getCurrentInstance();
		if (context.get(AdempiereWebUI.ZK_DESKTOP_SESSION_KEY) == null) {
			Desktop desktop = this.getDesktop();
			context.put(AdempiereWebUI.ZK_DESKTOP_SESSION_KEY, desktop);
		}		
		
		processDialogRunnable = new ProcessDialogRunnable();
		future = Adempiere.getThreadPoolExecutor().submit(processDialogRunnable);
	}
	
	private void onComplete() {
		if (future != null) {
			try {
				future.get();
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				if (!m_pi.isError()) {
					m_pi.setSummary(e.getLocalizedMessage(), true);
				}
			}
		}
		future = null;			
		processDialogRunnable = null;
		unlockUI(m_pi);
		if (downloadFiles.size() > 0) {
			MultiFileDownloadDialog downloadDialog = new MultiFileDownloadDialog(downloadFiles.toArray(new File[0]));
			downloadDialog.setPage(this.getPage());
			downloadDialog.setTitle(m_pi.getTitle());
			Events.postEvent(downloadDialog, new Event(MultiFileDownloadDialog.ON_SHOW));
		}
	}
	
	private void onStatusUpdate(Event event) {
		String message = (String) event.getData();
		if (progressWindow != null)
			progressWindow.statusUpdate(message);
	}
	
	public void onEvent(Event event) {
		Component component = event.getTarget(); 
		if(component instanceof A && event.getName().equals((Events.ON_CLICK))){
			doOnClick((A)component);
		} else if (component instanceof Button) {
			Button element = (Button)component;
			if ("Ok".equalsIgnoreCase(element.getId())) {
				if (isParameterPage) {
					if (!parameterPanel.validateParameters())
						return;
					this.startProcess();
				}
				else
					restart();
			} else if ("Cancel".equalsIgnoreCase(element.getId())) {
				this.dispose();
			}
		} else if (event.getName().equals(ON_STATUS_UPDATE)) {
			onStatusUpdate(event);
		} else if (event.getName().equals(ON_COMPLETE)) {
			onComplete();			
		} else if (event.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT)) {
    		SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Process, m_AD_Process_ID);
		}
		
	}

	private void doOnClick(A btn) {
		int Record_ID = 0;
		int AD_Table_ID =0;
		try
		{
			Record_ID = Integer.valueOf((String)btn.getAttribute("Record_ID"));            		
			AD_Table_ID= Integer.valueOf((String)btn.getAttribute("AD_Table_ID"));            		
		}
		catch (Exception e) {
		}

		if (Record_ID > 0 && AD_Table_ID > 0) {
			
			AEnv.zoom(AD_Table_ID, Record_ID);
		}		
	}


	public void lockUI(ProcessInfo pi) {
		if (m_isLocked || Executions.getCurrent() == null) return;
		
		m_isLocked = true;
		
		showBusyDialog();
	}

	private void showBusyDialog() {
		Clients.showBusy(this, " ");
		progressWindow = new BusyDialog();
		progressWindow.setStyle("position: absolute;");
		LayoutUtils.openOverlappedWindow(this, progressWindow, "middle_center");
	}

	public void unlockUI(ProcessInfo pi) {
		if (!m_isLocked || Executions.getCurrent() == null) return;
		
		m_isLocked = false;
		hideBusyDialog();
		updateUI(pi);
	}

	private void hideBusyDialog() {
		Clients.clearBusy(this);
		if (progressWindow != null) {
			progressWindow.dispose();
			progressWindow = null;
		}
	}

	private void updateUI(ProcessInfo pi) {
		ProcessInfoUtil.setLogFromDB(pi);
		m_messageText.append("<p><font color=\"").append(pi.isError() ? "#FF0000" : "#0000FF").append("\">** ")
			.append(pi.getSummary())
			.append("</font></p>");
		message.setContent(m_messageText.toString());
		// Add Log info with zoom on record id
		appendRecordLogInfo(pi.getLogs());
		
		bOK.setLabel(Msg.getMsg(Env.getCtx(), "Parameter"));
		bOK.setImage("/images/Reset16.png");
		isParameterPage = false;

		m_ids = pi.getIDs();
		
		//move message div to center to give more space to display potentially very long log info
		centerPanel.detach();
		messageDiv.detach();
		messageDiv.setStyle("");
		north.setVisible(false);
		center.appendChild(messageDiv);
		messageDiv.setVflex("1");
		messageDiv.setHflex("1");
		invalidate();
		
		Clients.response(new AuEcho(this, "onAfterProcess", null));
	}
	
	private void appendRecordLogInfo(ProcessInfoLog[] m_logs) {
		if (m_logs == null)
			return;

		SimpleDateFormat dateFormat = DisplayType
				.getDateFormat(DisplayType.Date);

		logMessageTable = new Table();
		logMessageTable.setId("logrecords");
		logMessageTable.setDynamicProperty("border", "1");
		logMessageTable.setDynamicProperty("cellpadding", "0");
		logMessageTable.setDynamicProperty("cellspacing", "0");
		logMessageTable.setDynamicProperty("width", "100%");

		this.appendChild(logMessageTable);

		boolean datePresents = false;
		boolean numberPresents = false;
		boolean msgPresents = false;

		for (ProcessInfoLog log : m_logs) {
			if (log.getP_Date() != null)
				datePresents = true;
			if (log.getP_Number() != null)
				numberPresents = true;
			if (log.getP_Msg() != null)
				msgPresents = true;
		}

		for (int i = 0; i < m_logs.length; i++) {

			Tr tr = new Tr();
			logMessageTable.appendChild(tr);

			ProcessInfoLog log = m_logs[i];

			if (datePresents) {
				Td td = new Td();
				if (log.getP_Date() != null) {
					Label label = new Label(dateFormat.format(log.getP_Date()));
					td.appendChild(label);
					// label.setStyle("padding-right:100px");
				}
				tr.appendChild(td);

			}

			if (numberPresents) {

				Td td = new Td();
				if (log.getP_Number() != null) {
					Label labelPno = new Label("" + log.getP_Number());
					td.appendChild(labelPno);
				}
				tr.appendChild(td);
			}

			if (msgPresents) {
				Td td = new Td();
				if (log.getP_Msg() != null) {
					if (log.getAD_Table_ID() > 0 && log.getRecord_ID() > 0) {
						A recordLink = new A();
						recordLink.setLabel(log.getP_Msg());
						recordLink.setAttribute("Record_ID",
								String.valueOf(log.getRecord_ID()));
						recordLink.setAttribute("AD_Table_ID",
								String.valueOf(log.getAD_Table_ID()));
						recordLink.addEventListener(Events.ON_CLICK, this);
						td.appendChild(recordLink);
					} else {
						Text t = new Text();
						t.setEncode(false);
						t.setValue(log.getP_Msg());
						td.appendChild(t);
					}
				}
				tr.appendChild(td);
			}
		}
		messageDiv.appendChild(logMessageTable);
	}

	private void restart() {
		m_messageText = new StringBuffer(initialMessage);
		message.setContent(initialMessage);

		north.setVisible(true);
		messageDiv.detach();
		if(logMessageTable!=null){
			messageDiv.removeChild(logMessageTable);
		}
		messageDiv.setStyle(MESSAGE_DIV_STYLE);
		north.appendChild(messageDiv);

		center.appendChild(centerPanel);

		isParameterPage = true;

		bOK.setLabel(Msg.getMsg(Env.getCtx(), "Start"));
		bOK.setImage("/images/Ok16.png");

		//recreate process info
		m_pi = new WProcessInfo(m_Name, m_AD_Process_ID);
		m_pi.setAD_User_ID (Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		parameterPanel.setProcessInfo(m_pi);

		m_ids = null;

		invalidate();
	}

	public void onAfterProcess() 
	{
		//
		if (!afterProcessTask()) {
			// If the process is a silent one and no errors occured, close the dialog
			if(m_ShowHelp != null && m_ShowHelp.equals("S"))
				this.dispose();	
		}
	}
	
	/**************************************************************************
	 *	Optional Processing Task
	 */
	private boolean afterProcessTask()
	{
		//  something to do?
		if (m_ids != null && m_ids.length > 0)
		{
			log.config("");
			//	Print invoices
			if (m_AD_Process_ID == PROCESS_C_INVOICE_GENERATE)
			{
				printInvoices();
				return true;
			}
			else if (m_AD_Process_ID == PROCESS_M_INOUT_GENERATE)
			{
				printShipments();
				return true;
			}
			else
			{
				return false;
			}
		}
		return false;
	}	//	afterProcessTask
	
	/**************************************************************************
	 *	Print Shipments
	 */
	private void printShipments()
	{		
		if (m_ids == null)
			return;
		FDialog.ask(m_WindowNo, this, "PrintShipments", new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					m_messageText.append("<p>").append(Msg.getMsg(Env.getCtx(), "PrintShipments")).append("</p>");
					message.setContent(m_messageText.toString());
					showBusyDialog();
					Clients.response(new AuEcho(ProcessDialog.this, "onPrintShipments", null));
				}
			}
		});						
	}	//	printInvoices
	
	public void onPrintShipments() 
	{		
		//	Loop through all items
		List<File> pdfList = new ArrayList<File>();
		for (int i = 0; i < m_ids.length; i++)
		{
			int M_InOut_ID = m_ids[i];
			ReportEngine re = ReportEngine.get (Env.getCtx(), ReportEngine.SHIPMENT, M_InOut_ID);
			pdfList.add(re.getPDF());				
		}
		
		if (pdfList.size() > 1) {
			try {
				File outFile = File.createTempFile("PrintShipments", ".pdf");					
				Document document = null;
				PdfWriter copy = null;					
				for (File f : pdfList) 
				{
					String fileName = f.getAbsolutePath();
					PdfReader reader = new PdfReader(fileName);
					reader.consolidateNamedDestinations();
					if (document == null)
					{
						document = new Document(reader.getPageSizeWithRotation(1));
						copy = PdfWriter.getInstance(document, new FileOutputStream(outFile));
						document.open();
					}
					int pages = reader.getNumberOfPages();
					PdfContentByte cb = copy.getDirectContent();
					for (int i = 1; i <= pages; i++) {
						document.newPage();
						PdfImportedPage page = copy.getImportedPage(reader, i);
						cb.addTemplate(page, 0, 0);
					}
				}
				document.close();

				hideBusyDialog();
				Window win = new SimplePDFViewer(m_pi.getTitle(), new FileInputStream(outFile));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			} finally {
				//do no harm calling this twice
				hideBusyDialog();
			}
		} else if (pdfList.size() > 0) {
			hideBusyDialog();
			try {
				Window win = new SimplePDFViewer(m_pi.getTitle(), new FileInputStream(pdfList.get(0)));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		
		// If the process is a silent one and no errors occured, close the dialog
		if(m_ShowHelp != null && m_ShowHelp.equals("S"))
			this.dispose();	
	}

	/**
	 *	Print Invoices
	 */
	private void printInvoices()
	{
		if (m_ids == null)
			return;
		FDialog.ask(m_WindowNo, this, "PrintInvoices", new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					m_messageText.append("<p>").append(Msg.getMsg(Env.getCtx(), "PrintInvoices")).append("</p>");
					message.setContent(m_messageText.toString());
					showBusyDialog();
					Clients.response(new AuEcho(ProcessDialog.this, "onPrintInvoices", null));
				}
			}
		});						
	}	//	printInvoices
	
	public void onPrintInvoices()
	{
		//	Loop through all items
		List<File> pdfList = new ArrayList<File>();
		for (int i = 0; i < m_ids.length; i++)
		{
			int C_Invoice_ID = m_ids[i];
			ReportEngine re = ReportEngine.get (Env.getCtx(), ReportEngine.INVOICE, C_Invoice_ID);
			pdfList.add(re.getPDF());				
		}
		
		if (pdfList.size() > 1) {
			try {
				File outFile = File.createTempFile("PrintInvoices", ".pdf");					
				Document document = null;
				PdfWriter copy = null;					
				for (File f : pdfList) 
				{
					PdfReader reader = new PdfReader(f.getAbsolutePath());
					if (document == null)
					{
						document = new Document(reader.getPageSizeWithRotation(1));
						copy = PdfWriter.getInstance(document, new FileOutputStream(outFile));
						document.open();						
					}
					PdfContentByte cb = copy.getDirectContent(); // Holds the PDF
					int pages = reader.getNumberOfPages();
					for (int i = 1; i <= pages; i++) {
						document.newPage();
						PdfImportedPage page = copy.getImportedPage(reader, i);
						cb.addTemplate(page, 0, 0);
					}
				}
				document.close();

				hideBusyDialog();
				Window win = new SimplePDFViewer(m_pi.getTitle(), new FileInputStream(outFile));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			} finally {
				//do no harm calling this twice
				hideBusyDialog();
			}
		} else if (pdfList.size() > 0) {
			hideBusyDialog();
			try {
				Window win = new SimplePDFViewer(m_pi.getTitle(), new FileInputStream(pdfList.get(0)));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		
		// If the process is a silent one and no errors occured, close the dialog
		if(m_ShowHelp != null && m_ShowHelp.equals("S"))
			this.dispose();	
	}

	public boolean isValid() {
		return valid;
	}

	public boolean isUILocked() {
		return m_isLocked;
	}
	
	class ProcessDialogRunnable extends ContextRunnable {
		ProcessDialogRunnable() {
			super();
		}
		
		protected void doRun() {
			try {
				log.log(Level.INFO, "Process Info="+m_pi+" AD_Client_ID="+Env.getAD_Client_ID(Env.getCtx()));
				WProcessCtl.process(ProcessDialog.this, m_WindowNo, parameterPanel, m_pi, null);
			} finally {
				Executions.schedule(getDesktop(), ProcessDialog.this, new Event(ON_COMPLETE, ProcessDialog.this, null));
			}
		}		
	}

	@Override
	public void statusUpdate(String message) {
		Executions.schedule(getDesktop(), this, new Event(ON_STATUS_UPDATE, this, message));
	}

	@Override
	public void ask(final String message, final Callback<Boolean> callback) {
		Executions.schedule(getDesktop(), new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				FDialog.ask(m_WindowNo, null, message, callback);
			}
		}, new Event("onAsk"));
	}

	@Override
	public void download(File file) {
		downloadFiles.add(file);
	}
}	//	ProcessDialog
