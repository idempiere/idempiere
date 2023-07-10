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
package org.adempiere.webui.apps;

import static org.compiere.model.SystemIDs.PROCESS_C_INVOICE_GENERATE;
import static org.compiere.model.SystemIDs.PROCESS_M_INOUT_GENERATE;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.DocumentLink;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.panel.IHelpContext;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.process.WProcessInfo;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.SimplePDFViewer;
import org.compiere.model.MProcess;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Text;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.Label;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Vlayout;

import com.lowagie.text.Document;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfWriter;

/**
 *	Embedded Dialog to Start process or report.
 *	Displays information about the process
 *		and lets the user decide to start it
 *  	and displays results (optionally print them).
 *  Calls ProcessCtl to execute.
 *  @author 	Low Heng Sin
 *  @author     arboleda - globalqss
 *  - Implement ShowHelp option on processes and reports
 */
public class ProcessDialog extends AbstractProcessDialog implements EventListener<Event>, IHelpContext, ITabOnCloseHandler
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6728929130788829223L;

	public static final String ON_INITIAL_FOCUS_EVENT = "onInitialFocus";
	
	/** 
	 * Event echo form {@link #onOk()} to defer execution of {@link #onOk()}.
	 * Execution is defer to happens after the dismiss of modal dialog (usually info window) blocking parameter panel. 
	 */
	private static final String ON_OK_ECHO_EVENT = "onOkEcho";
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(ProcessDialog.class);
	//
	/** message from {@link ProcessInfoLog} **/
	private Table logMessageTable;
	/** record ids from {@link ProcessInfo} **/
	private int[] m_ids = null;	
	/** true if dialog is showing process parameters **/
	private boolean isParameterPage = true;	
	private Mask mask;
	/** layout for process execution result **/
	private HtmlBasedComponent resultPanelLayout;
	/** process message content of {@link #resultPanelLayout} **/
	private HtmlBasedComponent messageResultContent;
	/** process log content of {@link #resultPanelLayout}, host {@link #logMessageTable} **/
	private HtmlBasedComponent infoResultContent;

	/** Window No					*/
	private int m_WindowNo = -1;
	/**
	 * SysConfig USE_ESC_FOR_TAB_CLOSING
	 */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));

	/**
	 * Dialog to start a process/report
	 * @param AD_Process_ID
	 * @param isSOTrx
	 */
	public ProcessDialog (int AD_Process_ID, boolean isSOTrx)
	{
		this(AD_Process_ID, isSOTrx, null);
	}
	
	/**
	 * Dialog to start a process/report
	 * @param AD_Process_ID
	 * @param isSOTrx
	 * @param predefinedContextVariables
	 */
	public ProcessDialog (int AD_Process_ID, boolean isSOTrx, String predefinedContextVariables)
	{
		if (log.isLoggable(Level.INFO)) log.info("Process=" + AD_Process_ID );
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		this.setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, m_WindowNo);
		Env.setContext(Env.getCtx(), m_WindowNo, "IsSOTrx", isSOTrx ? "Y" : "N");
		Env.setPredefinedVariables(Env.getCtx(), m_WindowNo, predefinedContextVariables);
		try
		{
			init(Env.getCtx(), m_WindowNo, AD_Process_ID, null, false, false);
			querySaved();
			addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
			addEventListener(ON_INITIAL_FOCUS_EVENT, this);
			addEventListener(ON_OK_ECHO_EVENT, this);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
	}	//	ProcessDialog
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		try {
			SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
			
			Component parentTab = this.getParent();
			if (parentTab != null && parentTab instanceof Tabpanel) {
				((Tabpanel)parentTab).setOnCloseHandler(this);
			}
		} catch (Exception e) {}
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		try {
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
			SessionManager.getAppDesktop().unregisterWindow(m_WindowNo);
		} catch (Exception e) {}
	}

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
		super.dispose();
		SessionManager.getAppDesktop().closeWindow(getWindowNo());
	}//	dispose

	@Override
	public void onEvent(Event event) {
		Component component = event.getTarget(); 
		
		if(component instanceof A && event.getName().equals((Events.ON_CLICK))){
			doOnClick((A)component);
		} else if (bOK.equals(component)) {
			super.onEvent(event);
			
			onOk();
		} else if (event.getName().equals(ON_OK_ECHO_EVENT)) {
			onOk();
		}else if (bCancel.equals(component)){
			super.onEvent(event);
			cancelProcess();
		} else if (event.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT)) {
    		SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Process, getAD_Process_ID());
		} else if (event.getName().equals(ON_INITIAL_FOCUS_EVENT)) {
			if (!isUILocked())
			{
				if (!getParameterPanel().focusToFirstEditor()) 
				{
					bOK.focus();
				}
			}
        } else if (event.getName().equals(Events.ON_CTRL_KEY)) {
        	KeyEvent keyEvent = (KeyEvent) event;
		if (LayoutUtils.isReallyVisible(this))
	        	this.onCtrlKeyEvent(keyEvent);
		} else {
			super.onEvent(event);
		}
	}

	/**
	 * Handle ON_Click event from {@link #bOK}
	 */
	private void onOk() {
		if (isParameterPage)
		{
			if (getParameterPanel().isWaitingForDialog())
			{
				Events.echoEvent(ON_OK_ECHO_EVENT, this, null);
				return;
			}
			startProcess();
		}
		else
			restart();
	}
	
	/**
	 * Handle shortcut key event
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
	 * Handle on click event for record link.
	 * @param btn
	 */
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

	@Override
	public void showBusyDialog() {		
		BusyDialog progressWindow = createBusyDialog();
		progressWindow.setStyle("position: absolute;");
		showBusyMask(progressWindow);
		LayoutUtils.openOverlappedWindow(this, progressWindow, "middle_center");
	}

	/**
	 * @return in progress mask
	 */
	private Div getMask() {
		if (mask == null) {
			mask = new Mask();
		}
		return mask;
	}
	
	/**
	 * show in progress mask
	 * @param window
	 */
	private void showBusyMask(Window window) {
	  if (getParent() != null) {
		getParent().appendChild(getMask());
		//to prevent focus to components beneath the in progress mask (see canActivate in web/js/org/idempiere/commons/window.js)
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
	}
		
	/**
	 * close in progress mask
	 */
	private void hideBusyMask() 
	{
		if (mask != null && mask.getParent() != null) {
			mask.detach();
			if(getParent() != null) {
				StringBuilder script = new StringBuilder("(function(){let w=zk.Widget.$('#");
				script.append(getParent().getUuid()).append("');w.busy=false;");
				script.append("})()");
				Clients.response(new AuScript(script.toString()));
			}
		}
	}
	
	@Override
	public void hideBusyDialog() 
	{		
		hideBusyMask();
		closeBusyDialog();
	}

	@Override
	public void updateUI() {
		swithToFinishScreen();
	}
	
	/**
	 * Switch to process execution result panel.
	 */
	protected void swithToFinishScreen() {
		ProcessInfo pi = getProcessInfo();
		ProcessInfoUtil.setLogFromDB(pi);
		
		layoutResultPanel (topParameterLayout);
		
		StringBuilder buildMsg = new StringBuilder(getInitialMessage());
		buildMsg.append("<hr><p><font color=\"").append(pi.isError() ? "#FF0000" : "#0000FF").append("\">** ")
		.append(pi.getSummary())
		.append("</font></p>");
	
		((Html)messageResultContent).setContent (buildMsg.toString());
		
		// Add Log info with zoom on record id
		infoResultContent.getChildren().removeAll(infoResultContent.getChildren());
		appendRecordLogInfo(pi.getLogs(), infoResultContent);
		
		bOK.setLabel(Msg.getMsg(Env.getCtx(), "Parameter"));
		bOK.setDisabled(false);

		bCancel.setLabel(Msg.getMsg(Env.getCtx(), "Close"));
		bCancel.setDisabled(false);

    	if (ThemeManager.isUseFontIconForImage()) {
    		String iconSclass = "z-icon-Reset";
    		bOK.setIconSclass(iconSclass);
    		LayoutUtils.addSclass("font-icon-toolbar-button", bOK);
    	} else {
			bOK.setImage(ThemeManager.getThemeResource("images/Reset16.png"));
			bCancel.setImage(ThemeManager.getThemeResource("images/Cancel16.png"));
		}

		isParameterPage = false;

		m_ids = pi.getIDs();
		
		//move message div to center to give more space to display potentially very long log info
		replaceComponent (resultPanelLayout, topParameterLayout);
		invalidate();
		Clients.response(new AuEcho(this, "onAfterProcess", null));
	}
	
	/**
	 * layout process execution result panel
	 * @param topParameterLayout
	 */
	private void layoutResultPanel (HtmlBasedComponent topParameterLayout){
		if (resultPanelLayout == null){
			resultPanelLayout = new Vlayout();
			resultPanelLayout.setSclass("result-parameter-layout");
			ZKUpdateUtil.setVflex(resultPanelLayout, "true");
			// reference for update late
			messageResultContent = setHeadMessage(resultPanelLayout, null);
			
			infoResultContent = new Div();
			resultPanelLayout.appendChild(infoResultContent);
		}
	}
	
	/**
	 * replace oldComponent with newComponent
	 * @param newComponent
	 * @param oldComponent
	 */
	protected void replaceComponent(HtmlBasedComponent newComponent, HtmlBasedComponent oldComponent) {
		oldComponent.getParent().insertBefore(newComponent, oldComponent);
		oldComponent.detach();
	}	
	
	/**
	 * append m_logs content to {@link #logMessageTable}
	 * @param m_logs
	 * @param infoResultContent
	 */
	private void appendRecordLogInfo(ProcessInfoLog[] m_logs, HtmlBasedComponent infoResultContent) {
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

		infoResultContent.appendChild(logMessageTable);

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
						DocumentLink recordLink = new DocumentLink(log.getP_Msg(), log.getAD_Table_ID(), log.getRecord_ID());																								
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
	}

	/**
	 * Move back from process execution result panel to process parameter panel
	 */
	private void restart() {
		replaceComponent (topParameterLayout, resultPanelLayout);
		
		isParameterPage = true;

		bOK.setLabel(Msg.getMsg(Env.getCtx(), "Start"));
		
		bCancel.setLabel(Util.cleanAmp(Msg.translate(Env.getCtx(), ConfirmPanel.A_CANCEL)));

    	if (ThemeManager.isUseFontIconForImage()) {
    		String iconSclass = "z-icon-Ok";
    		bOK.setIconSclass(iconSclass);
    		LayoutUtils.addSclass("font-icon-toolbar-button", bOK);
    	} else {
			bOK.setImage(ThemeManager.getThemeResource("images/Ok16.png"));
			bCancel.setImage(ThemeManager.getThemeResource("images/Cancel16.png"));
		}

		//recreate process info
		ProcessInfo m_pi = new WProcessInfo(getName(), getAD_Process_ID());
		m_pi.setAD_User_ID (Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		setProcessInfo(m_pi);
		getParameterPanel().setProcessInfo(m_pi);

		m_ids = null;
		if (fSavedName != null)
			querySaved();
		invalidate();
	}

	/**
	 * Handle onAfterProcess event echo from {@link #swithToFinishScreen()}
	 */
	public void onAfterProcess() 
	{
		//
		if (!afterProcessTask()) {
			// If the process is a silent one and no errors occurred, close the dialog
			if(getShowHelp() != null && MProcess.SHOWHELP_RunSilently_TakeDefaults.equals(getShowHelp()))
				this.dispose();	
		}
	}
	
	/**
	 * Optional after/post process execution task
	 */
	private boolean afterProcessTask()
	{
		//  something to do?
		if (m_ids != null && m_ids.length > 0)
		{
			if (log.isLoggable(Level.CONFIG)) log.config("");
			//	Print invoices
			if (getAD_Process_ID() == PROCESS_C_INVOICE_GENERATE)
			{
				printInvoices();
				return true;
			}
			else if (getAD_Process_ID() == PROCESS_M_INOUT_GENERATE)
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
	
	/**
	 * Print Shipments
	 */
	private void printShipments()
	{		
		if (m_ids == null)
			return;
		Dialog.ask(getWindowNo(), "PrintShipments", new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					StringBuilder buildMsg = new StringBuilder(((Html)messageResultContent).getContent());
					buildMsg.append("<p>").append(Msg.getMsg(Env.getCtx(), "PrintShipments")).append("</p>");
					((Html)messageResultContent).setContent(buildMsg.toString());
					showBusyDialog();
					Clients.response(new AuEcho(ProcessDialog.this, "onPrintShipments", null));
				}
			}
		});						
	}
	
	/**
	 * Handle onPrintShipments event echo by {@link #printShipments()}
	 */
	public void onPrintShipments() 
	{		
		//	Loop through all items
		List<File> pdfList = new ArrayList<File>();
		for (int i = 0; i < m_ids.length; i++)
		{
			int M_InOut_ID = m_ids[i];
			ReportEngine re = ReportEngine.get (Env.getCtx(), ReportEngine.SHIPMENT, M_InOut_ID, getWindowNo());
			pdfList.add(re.getPDF());				
		}
		
		if (pdfList.size() > 1) {
			List<PdfReader> pdfReaders = new ArrayList<PdfReader>();
			try {
				File outFile = File.createTempFile("PrintShipments", ".pdf");					
				Document document = null;
				PdfWriter copy = null;					
				for (File f : pdfList) 
				{
					String fileName = f.getAbsolutePath();
					PdfReader reader = new PdfReader(fileName);
					pdfReaders.add(reader);
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
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(outFile));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			} finally {
				for (PdfReader reader : pdfReaders)
				{
					if (reader != null)
						reader.close();
				}
				//do no harm calling this twice
				hideBusyDialog();
			}
		} else if (pdfList.size() > 0) {
			hideBusyDialog();
			try {
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(pdfList.get(0)));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		
		// If the process is a silent one and no errors occurred, close the dialog
		if(getShowHelp() != null && MProcess.SHOWHELP_RunSilently_TakeDefaults.equals(getShowHelp()))
			this.dispose();	
	}

	/**
	 * Print Invoices
	 */
	private void printInvoices()
	{
		if (m_ids == null)
			return;
		Dialog.ask(getWindowNo(), "PrintInvoices", new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					StringBuilder buildMsg = new StringBuilder(((Html)messageResultContent).getContent());
					buildMsg.append("<p>").append(Msg.getMsg(Env.getCtx(), "PrintInvoices")).append("</p>");
					((Html)messageResultContent).setContent(buildMsg.toString());
					showBusyDialog();
					Clients.response(new AuEcho(ProcessDialog.this, "onPrintInvoices", null));
				}
			}
		});						
	}
	
	/**
	 * Handle onPrintInvoices event echo by {@link #printInvoices()}
	 */
	public void onPrintInvoices()
	{
		//	Loop through all items
		List<File> pdfList = new ArrayList<File>();
		for (int i = 0; i < m_ids.length; i++)
		{
			int C_Invoice_ID = m_ids[i];
			ReportEngine re = ReportEngine.get (Env.getCtx(), ReportEngine.INVOICE, C_Invoice_ID, getWindowNo());
			pdfList.add(re.getPDF());				
		}
		
		if (pdfList.size() > 1) {
			List<PdfReader> pdfReaders = new ArrayList<PdfReader>();
			try {
				File outFile = File.createTempFile("PrintInvoices", ".pdf");					
				Document document = null;
				PdfWriter copy = null;					
				for (File f : pdfList) 
				{
					PdfReader reader = new PdfReader(f.getAbsolutePath());
					pdfReaders.add(reader);
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
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(outFile));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			} finally {
				for (PdfReader reader : pdfReaders)
				{
					if (reader != null)
						reader.close();
				}
				//do no harm calling this twice
				hideBusyDialog();
			}
		} else if (pdfList.size() > 0) {
			hideBusyDialog();
			try {
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(pdfList.get(0)));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		
		// If the process is a silent one and no errors occurred, close the dialog
		if(getShowHelp() != null && MProcess.SHOWHELP_RunSilently_TakeDefaults.equals(getShowHelp()))
			this.dispose();	
	}

	@Override
	public void onClose(Tabpanel tabPanel) {
		if(!isUILocked()) {
			Tab tab = tabPanel.getLinkedTab();
			if (tab != null) {
				tab.close();
				cleanUp();
			}
		}
	}

	private void cleanUp() {
		if (m_WindowNo >= 0)
		{
			SessionManager.getAppDesktop().unregisterWindow(m_WindowNo);
			m_WindowNo = -1;
		}
	}
	
}	//	ProcessDialog
