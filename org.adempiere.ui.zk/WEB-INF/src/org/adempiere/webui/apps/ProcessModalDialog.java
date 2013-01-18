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
package org.adempiere.webui.apps;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import org.adempiere.webui.component.VerticalBox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.MultiFileDownloadDialog;
import org.compiere.Adempiere;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Html;

/**
 *
 *	Modal Dialog to Start process.
 *	Displays information about the process
 *		and lets the user decide to start it
 *  	and displays results (optionally print them).
 *  Calls ProcessCtl to execute.
 *  @author 	Low Heng Sin
 *  @author     arboleda - globalqss
 *  - Implement ShowHelp option on processes and reports
 */
public class ProcessModalDialog extends Window implements EventListener<Event>, IProcessUI, DialogEvents
{
	private static final String ON_STATUS_UPDATE = "onStatusUpdate";
	private static final String ON_COMPLETE = "onComplete";
	
	/**
	 * generated serial version ID
	 */
	private static final long serialVersionUID = -7109707014309321369L;
	private boolean m_autoStart;
	private VerticalBox dialogBody;
	
	private List<File> downloadFiles;

	/**
	 * @param aProcess
	 * @param WindowNo
	 * @param pi
	 * @param autoStart
	 */
	public ProcessModalDialog(int WindowNo, ProcessInfo pi, boolean autoStart)
	{
		this(null, WindowNo, pi, autoStart);
	}
	
	/**
	 * @param aProcess
	 * @param WindowNo
	 * @param pi
	 * @param autoStart
	 */
	public ProcessModalDialog(EventListener<Event> listener, int WindowNo, ProcessInfo pi, boolean autoStart)
	{
		m_ctx = Env.getCtx();
		m_WindowNo = WindowNo;
		m_pi = pi;
		m_autoStart = autoStart;
		
		if (listener != null) 
		{
			addEventListener(ON_WINDOW_CLOSE, listener);
		}

		log.info("Process=" + pi.getAD_Process_ID());
		try
		{
			initComponents();
			init();
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
	}

	public ProcessModalDialog (int WindowNo, int AD_Process_ID, int tableId, int recordId, boolean autoStart)
	{
		this(null, WindowNo, AD_Process_ID, tableId, recordId, autoStart);
	}
	
	/**
	 * Dialog to start a process/report
	 * @param WindowNo
	 * @param AD_Process_ID
	 * @param tableId
	 * @param recordId
	 * @param autoStart
	 */
	public ProcessModalDialog (EventListener<Event> listener, int WindowNo, int AD_Process_ID, int tableId, int recordId, boolean autoStart)
	{
		this(listener, WindowNo, new ProcessInfo("", AD_Process_ID, tableId, recordId), autoStart);
	}

	/**
	 * Dialog to start a process/report
	 * @param ctx
	 * @param parent not used
	 * @param title not used
	 * @param WindowNo
	 * @param AD_Process_ID
	 * @param tableId
	 * @param recordId
	 * @param autoStart
	 * @deprecated
	 */
	public ProcessModalDialog (Window parent, String title,
			int WindowNo, int AD_Process_ID,
			int tableId, int recordId, boolean autoStart)
	{
		this(WindowNo, AD_Process_ID, tableId, recordId, autoStart);
	}	//	ProcessDialog

	private void initComponents() {
		this.setBorder("normal");
		dialogBody = new VerticalBox();
		dialogBody.setHflex("1");
		Div div = new Div();
		div.setId("message");
		message = new Html();
		div.appendChild(message);
		div.setStyle("max-height: 150pt; overflow: auto;");
		dialogBody.appendChild(div);
		centerPanel = new Panel();
		dialogBody.appendChild(centerPanel);
		Hbox hbox = new Hbox();
		hbox.setWidth("100%");
		hbox.setStyle("margin-top: 10px");
		Button btn = new Button("");
		btn.setImage("/images/Ok24.png");
		LayoutUtils.addSclass("action-button", btn);
		btn.setId("Ok");
		btn.addEventListener(Events.ON_CLICK, this);
		hbox.appendChild(btn);

		btn = new Button("");
		btn.setImage("/images/Cancel24.png");
		btn.setId("Cancel");
		LayoutUtils.addSclass("action-button", btn);
		btn.addEventListener(Events.ON_CLICK, this);

		hbox.appendChild(btn);
		hbox.setPack("end");
		dialogBody.appendChild(hbox);
		this.appendChild(dialogBody);

	}

	private int m_WindowNo;
	private Properties m_ctx;
	private String		    m_Name = null;
	private StringBuffer	m_messageText = new StringBuffer();
	private String          m_ShowHelp = null; // Determine if a Help Process Window is shown
	private boolean m_valid = true;
	private boolean m_cancel = false;

	private Panel centerPanel = null;
	private Html message = null;

	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ProcessModalDialog.class);
	//
	private ProcessParameterPanel parameterPanel = null;

	private ProcessInfo m_pi = null;
	private BusyDialog progressWindow;
	private boolean isLocked = false;
	private org.adempiere.webui.apps.ProcessModalDialog.ProcessDialogRunnable processDialogRunnable;
	private Future<?> future;

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
		parameterPanel.restoreContext();
		m_valid = false;
		this.detach();
	}	//	dispose

	/**
	 * is dialog still valid
	 * @return boolean
	 */
	public boolean isValid()
	{
		return m_valid;
	}

	/**
	 * @return true if user have press the cancel button to close the dialog
	 */
	public boolean isCancel()
	{
		return m_cancel;
	}
	
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
			pstmt.setInt(1, m_pi.getAD_Process_ID());
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
		message.setContent(m_messageText.toString());

		//	Move from APanel.actionButton
		m_pi.setAD_User_ID (Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		m_pi.setTitle(m_Name);
		parameterPanel = new ProcessParameterPanel(m_WindowNo, m_pi);
		centerPanel.getChildren().clear();
		if ( parameterPanel.init() ) {
			centerPanel.appendChild(parameterPanel);
		} else {
			if (m_ShowHelp != null && m_ShowHelp.equals("N")) {
				m_autoStart = true;
			}
			if (m_autoStart) {
				this.getFirstChild().setVisible(false);
				startProcess();
				return true;
			}
		}

		// Check if the process is a silent one
		if(isValid() && m_ShowHelp != null && m_ShowHelp.equals("S"))
		{
			this.getFirstChild().setVisible(false);
			startProcess();
		}
		return true;
	}	//	init

	/**
	 * launch process
	 */
	private void startProcess()
	{		
		m_pi.setPrintPreview(true);

		lockUI(m_pi);
		
		downloadFiles = new ArrayList<File>();

		//use echo, otherwise lock ui wouldn't work
		Clients.response(new AuEcho(this, "runProcess", null));
	}

	private void showBusyDialog() {
		this.setBorder("none");
		this.setTitle(null);
		dialogBody.setVisible(false);

		progressWindow = new BusyDialog();
		this.appendChild(progressWindow);
		if (this.getParent() != null)
			LayoutUtils.openOverlappedWindow(this.getParent(), progressWindow, "middle_center");
	}

	/**
	 * internal use, don't call this directly
	 */
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
	
	private void hideBusyDialog() {
		if (progressWindow != null) {
			progressWindow.dispose();
			progressWindow = null;
		}
	}

	/**
	 * handle events
	 */
	public void onEvent(Event event) {		
		Component component = event.getTarget();
		if (component instanceof Button) {
			Button element = (Button)component;
			if ("Ok".equalsIgnoreCase(element.getId())) {
				onOK();
			} else if ("Cancel".equalsIgnoreCase(element.getId())) {
				onCancel();
			}
		} else if (event.getName().equals(ON_STATUS_UPDATE)) {
			onStatusUpdate(event);
		} else if (event.getName().equals(ON_COMPLETE)) {
			onComplete();
		}
	}

	private void onOK() {
		this.startProcess();
	}

	private void onCancel() {
		m_cancel = true;
		this.dispose();
	}

	private void onStatusUpdate(Event event) {
		String message = (String) event.getData();
		if (progressWindow != null)
			progressWindow.statusUpdate(message);
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
		dispose();		
	}

	@Override
	public void lockUI(ProcessInfo pi) {
		if (isLocked || Executions.getCurrent() == null)
			return;
		
		showBusyDialog();
		isLocked  = true;
	}

	@Override
	public void unlockUI(ProcessInfo pi) {
		if (!isLocked)
			return;
		
		if (Executions.getCurrent() == null) {
			Executions.schedule(getDesktop(), new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					doUnlockUI();
				}
			}, new Event("onUnLockUI"));
		} else {		
			doUnlockUI();
		}
	}
	
	private void doUnlockUI() {
		hideBusyDialog();
		isLocked = false;
	}

	@Override
	public boolean isUILocked() {
		return isLocked;
	}

	@Override
	public void statusUpdate(String message) {
		Executions.schedule(getDesktop(), this, new Event(ON_STATUS_UPDATE, this, message));
	}

	/**
	 * 
	 * @return ProcessInfo
	 */
	public ProcessInfo getProcessInfo() {
		return m_pi;
	}
	
	class ProcessDialogRunnable extends ContextRunnable{		
		ProcessDialogRunnable() {
			super();
		}
		
		protected void doRun() {
			try {
				log.log(Level.INFO, "Process Info="+m_pi+" AD_Client_ID="+Env.getAD_Client_ID(Env.getCtx()));
				WProcessCtl.process(ProcessModalDialog.this, m_WindowNo, parameterPanel, m_pi, null);
			} finally {
				Executions.schedule(getDesktop(), ProcessModalDialog.this, new Event(ON_COMPLETE, ProcessModalDialog.this, null));
			}
		}		
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
