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
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.panel.IHelpContext;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.process.WProcessInfo;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.SimplePDFViewer;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.AdempiereSystemError;
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
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Label;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

import com.lowagie.text.Document;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfWriter;

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
public class ProcessDialog extends AbstractProcessDialog implements EventListener<Event>, IHelpContext
{
	public static final String ON_INITIAL_FOCUS_EVENT = "onInitialFocus";

	/**
	 * generate serial version ID
	 */
	private static final long serialVersionUID = 3329046204196602797L;
	
	private static final String MESSAGE_DIV_STYLE = "max-height: 150pt; overflow: auto; margin: 10px;";	
	
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ProcessDialog.class);
	//

	private Div messageDiv;
	private Center center;
	private Table logMessageTable;
	private North north;
	
	private int[]		    m_ids = null;	
	private Button bOK = null;
	
	private boolean isParameterPage = true;	
	private Mask mask;

	private boolean showLastRun = false;

	private Grid southRowPanel = GridFactory.newGridLayout();

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
		int WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		this.setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, WindowNo);
		Env.setContext(Env.getCtx(), WindowNo, "IsSOTrx", isSOTrx ? "Y" : "N");
		try
		{
			MProcess process = MProcess.get(Env.getCtx(), AD_Process_ID);
		    int count = process.getParameters().length;
		    if (count > 0)
		    	showLastRun = true;

			initComponents();
			init(Env.getCtx(), WindowNo, AD_Process_ID, null, "70%", false, false);
			querySaved();
			addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
			addEventListener(ON_INITIAL_FOCUS_EVENT, this);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
	}	//	ProcessDialog

	private void querySaved() 
	{
		//user query
		savedParams = MPInstance.get(Env.getCtx(), getAD_Process_ID(), Env.getContextAsInt(Env.getCtx(), "#AD_User_ID"));
		fSavedName.removeAllItems();
		for (MPInstance instance : savedParams)
		{
			String queries = instance.get_ValueAsString("Name");
			fSavedName.appendItem(queries);
		}

		fSavedName.setValue("");
	}

	private void initComponents() {
		this.setStyle("position: absolute; width: 100%; height: 100%");
		Borderlayout layout = new Borderlayout();
		layout.setStyle("position: absolute; width: 100%; height: 100%; border: none;");
		messageDiv = new Div();
		messageDiv.appendChild(getMessage());
		messageDiv.setStyle(MESSAGE_DIV_STYLE);
		messageDiv.setId("message");
		
		north = new North();
		north.appendChild(messageDiv);
		layout.appendChild(north);
		north.setAutoscroll(true);
		north.setStyle("border: none;");
		
		center = new Center();
		layout.appendChild(center);
		center.appendChild(getCenterPanel());
		getCenterPanel().setHflex("1");
		getCenterPanel().setVflex("1");
		center.setAutoscroll(true);
		center.setStyle("border: none");
		
		Rows rows = southRowPanel.newRows();
		Row row = rows.newRow();

		Hbox hBox = new Hbox();

		lSaved = new Label(Msg.getMsg(Env.getCtx(), "SavedParameter"));
		hBox.appendChild(lSaved);
		fSavedName.addEventListener(Events.ON_CHANGE, this);
		hBox.appendChild(fSavedName);

		bSave.setEnabled(false);
		bSave.addActionListener(this);
		hBox.appendChild(bSave);

		bDelete.setEnabled(false);
		bDelete.addActionListener(this);
		hBox.appendChild(bDelete);

		row.appendChild(hBox);

		if(!showLastRun)	
			hBox.setVisible(false);

		Panel confParaPanel =new Panel();
		confParaPanel.setAlign("right");
		// Invert - Unify  OK/Cancel IDEMPIERE-77
		bOK = ButtonFactory.createNamedButton(ConfirmPanel.A_OK, true, true);
		bOK.setId("Ok");
		bOK.addEventListener(Events.ON_CLICK, this);
		confParaPanel.appendChild(bOK);
		
		bCancel = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL, true, true);
		bCancel.setId("Cancel");
		bCancel.addEventListener(Events.ON_CLICK, this);
		confParaPanel.appendChild(bCancel);
		row.appendChild(confParaPanel);
		
		South south = new South();
		south.setSclass("dialog-footer");
		layout.appendChild(south);
		south.appendChild(southRowPanel);		
		this.appendChild(layout);
	}

	private Button bCancel = null;

	//saved parameters
	private Combobox fSavedName=new Combobox();
	private Button bSave=ButtonFactory.createNamedButton("Save");
	private Button bDelete=ButtonFactory.createNamedButton("Delete");
	private List<MPInstance> savedParams;
	private Label lSaved;

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
	
	public void onEvent(Event event) {
		Component component = event.getTarget(); 

		String saveName = null;
		boolean lastRun = false;
		if (fSavedName.getRawText() != null) {
			saveName = fSavedName.getRawText();
			lastRun = ("** " + Msg.getMsg(Env.getCtx(), "LastRun") + " **")
					.equals(saveName);
		}
		if(component instanceof A && event.getName().equals((Events.ON_CLICK))){
			doOnClick((A)component);
		} else if (component instanceof Button) {
			Button element = (Button)component;
			if ("Ok".equalsIgnoreCase(element.getId())) {
				if (isParameterPage)
					startProcess();
				else
					restart();
			} else if ("Cancel".equalsIgnoreCase(element.getId())) {
				cancelProcess();

			} else if (event.getTarget().equals(bSave) && fSavedName != null
					&& !lastRun) {

				// Update existing
				if (fSavedName.getSelectedIndex() > -1 && savedParams != null) {
					for (int i = 0; i < savedParams.size(); i++) {
						if (savedParams.get(i).getName().equals(saveName)) {
							getProcessInfo().setAD_PInstance_ID(savedParams.get(i)
									.getAD_PInstance_ID());
							for (MPInstancePara para : savedParams.get(i)
									.getParameters()) {
								para.deleteEx(true);
							}
							getParameterPanel().saveParameters();
						}
					}
				}
				// create new
				else {
					MPInstance instance = null;
					try {
						instance = new MPInstance(Env.getCtx(),
								getProcessInfo().getAD_Process_ID(), getProcessInfo().getRecord_ID());
						instance.setName(saveName);
						instance.saveEx();
						getProcessInfo().setAD_PInstance_ID(instance.getAD_PInstance_ID());
						// Get Parameters
						if (getParameterPanel() != null) {
							if (!getParameterPanel().saveParameters()) {
								throw new AdempiereSystemError(Msg.getMsg(
										Env.getCtx(), "SaveParameterError"));
							}
						}
					} catch (Exception ex) {
						log.log(Level.SEVERE, ex.getLocalizedMessage(), ex);
					}
				}
				querySaved();
				fSavedName.setSelectedItem(getComboItem(saveName));
			}

			else if (event.getTarget().equals(bDelete) && fSavedName != null
					&& !lastRun) {
				Object o = fSavedName.getSelectedItem();
				if (savedParams != null && o != null) {
					String selected = fSavedName.getSelectedItem().getLabel();
					for (int i = 0; i < savedParams.size(); i++) {
						if (savedParams.get(i).getName().equals(selected)) {
							savedParams.get(i).deleteEx(true);
						}
					}
				}
				querySaved();
			}
		} else if (event.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT)) {
    		SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Process, getAD_Process_ID());
		} else if (event.getTarget().equals(fSavedName)) {
			if (savedParams != null && saveName != null) {
				for (int i = 0; i < savedParams.size(); i++) {
					if (savedParams.get(i).getName().equals(saveName)) {
						loadSavedParams(savedParams.get(i));
					}
				}
			}
			boolean enabled = !Util.isEmpty(saveName);
			bSave.setEnabled(enabled && !lastRun);
			bDelete.setEnabled(enabled && fSavedName.getSelectedIndex() > -1
					&& !lastRun);
		} else if (event.getName().equals(ON_INITIAL_FOCUS_EVENT)) {
			if (!isUILocked())
			{
				if (!getParameterPanel().focusToFirstEditor()) 
				{
					bOK.focus();
				}
			}
		} else {
			super.onEvent(event);
		}
	}

	public  Comboitem getComboItem( String value) {
		Comboitem item = null;
		for (int i = 0; i < fSavedName.getItems().size(); i++) {
			if (fSavedName.getItems().get(i) != null) {
				item = (Comboitem)fSavedName.getItems().get(i);
				if (value.equals(item.getLabel().toString())) {
					break;
				}
			}
		}
		return item;
	}

	private void loadSavedParams(MPInstance instance) {
		getParameterPanel().loadParameters(instance);
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

	@Override
	public void showBusyDialog() {		
		BusyDialog progressWindow = createBusyDialog();
		progressWindow.setStyle("position: absolute;");
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
		StringBuilder script = new StringBuilder("var w=zk.Widget.$('#");
		script.append(getParent().getUuid()).append("');");
		if (window != null) {
			script.append("var d=zk.Widget.$('#").append(window.getUuid()).append("');w.busy=d;");
		} else {
			script.append("w.busy=true;");
		}
		Clients.response(new AuScript(script.toString()));
	}
		
	private void hideBusyMask() 
	{
		if (mask != null && mask.getParent() != null) {
			mask.detach();
			StringBuilder script = new StringBuilder("var w=zk.Widget.$('#");
			script.append(getParent().getUuid()).append("');w.busy=false;");
			Clients.response(new AuScript(script.toString()));
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
		ProcessInfo pi = getProcessInfo();
		ProcessInfoUtil.setLogFromDB(pi);
		getMessageText().append("<p><font color=\"").append(pi.isError() ? "#FF0000" : "#0000FF").append("\">** ")
			.append(pi.getSummary())
			.append("</font></p>");
		getMessage().setContent(getMessageText().toString());
		// Add Log info with zoom on record id
		appendRecordLogInfo(pi.getLogs());
		
		bOK.setLabel(Msg.getMsg(Env.getCtx(), "Parameter"));
		bOK.setImage(ThemeManager.getThemeResource("images/Reset16.png"));
		isParameterPage = false;

		m_ids = pi.getIDs();
		
		//move message div to center to give more space to display potentially very long log info
		getCenterPanel().detach();
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
		setMessageText(new StringBuffer(getInitialMessage()));
		getMessage().setContent(getInitialMessage());

		north.setVisible(true);
		messageDiv.detach();
		if(logMessageTable!=null){
			messageDiv.removeChild(logMessageTable);
		}
		messageDiv.setStyle(MESSAGE_DIV_STYLE);
		north.appendChild(messageDiv);

		center.appendChild(getCenterPanel());

		isParameterPage = true;

		bOK.setLabel(Msg.getMsg(Env.getCtx(), "Start"));
		bOK.setImage(ThemeManager.getThemeResource("images/Ok16.png"));

		//recreate process info
		ProcessInfo m_pi = new WProcessInfo(getName(), getAD_Process_ID());
		m_pi.setAD_User_ID (Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		setProcessInfo(m_pi);
		getParameterPanel().setProcessInfo(m_pi);

		m_ids = null;

		invalidate();
	}

	public void onAfterProcess() 
	{
		//
		if (!afterProcessTask()) {
			// If the process is a silent one and no errors occured, close the dialog
			if(getShowHelp() != null && getShowHelp().equals("S"))
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
	
	/**************************************************************************
	 *	Print Shipments
	 */
	private void printShipments()
	{		
		if (m_ids == null)
			return;
		FDialog.ask(getWindowNo(), this, "PrintShipments", new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					getMessageText().append("<p>").append(Msg.getMsg(Env.getCtx(), "PrintShipments")).append("</p>");
					getMessage().setContent(getMessageText().toString());
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
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(outFile));
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
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(pdfList.get(0)));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		
		// If the process is a silent one and no errors occured, close the dialog
		if(getShowHelp() != null && getShowHelp().equals("S"))
			this.dispose();	
	}

	/**
	 *	Print Invoices
	 */
	private void printInvoices()
	{
		if (m_ids == null)
			return;
		FDialog.ask(getWindowNo(), this, "PrintInvoices", new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					getMessageText().append("<p>").append(Msg.getMsg(Env.getCtx(), "PrintInvoices")).append("</p>");
					getMessage().setContent(getMessageText().toString());
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
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(outFile));
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
				Window win = new SimplePDFViewer(getProcessInfo().getTitle(), new FileInputStream(pdfList.get(0)));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		
		// If the process is a silent one and no errors occured, close the dialog
		if(getShowHelp() != null && getShowHelp().equals("S"))
			this.dispose();	
	}
	
}	//	ProcessDialog
