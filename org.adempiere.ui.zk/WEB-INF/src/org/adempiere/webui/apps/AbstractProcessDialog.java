/******************************************************************************
 * Copyright (C) 2014 Elaine Tan                                              *
 * Copyright (C) 2014 Trek Global
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

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.util.ContextRunnable;
import org.adempiere.util.IProcessUI;
import org.adempiere.util.ServerContext;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ComboItem;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.process.WProcessInfo;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.MultiFileDownloadDialog;
import org.compiere.Adempiere;
import org.compiere.model.MAttachment;
import org.compiere.model.MClient;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MNote;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.Space;

public abstract class AbstractProcessDialog extends Window implements IProcessUI, EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 761285757875594250L;

	private static final String ON_COMPLETE = "onComplete";
	private static final String ON_STATUS_UPDATE = "onStatusUpdate";
	
	private static CLogger log = CLogger.getCLogger(AbstractProcessDialog.class);

	private int m_WindowNo;
	private Properties m_ctx;
	private int m_AD_Process_ID;
	private ProcessInfo m_pi = null;
	private boolean m_disposeOnComplete;

	private Html message = null;
	private Panel centerPanel = null;

	private ProcessParameterPanel parameterPanel = null;
	private Checkbox runAsJobField = null;
	private WTableDirEditor notificationTypeField = null;

	private BusyDialog progressWindow;	
	
	private String		    m_Name = null;
	private StringBuffer	m_messageText = new StringBuffer();
	private String          m_ShowHelp = null; // Determine if a Help Process Window is shown
	private String initialMessage;
	
	private boolean m_valid = true;
	private boolean m_cancel = false;
		
	private Future<?> future;
	private List<File> downloadFiles;
	private boolean m_locked = false;
		
	protected AbstractProcessDialog()
	{
		super();		
		message = new Html();
		centerPanel = new Panel();
	}
	
	protected boolean init(Properties ctx, int WindowNo, int AD_Process_ID, ProcessInfo pi, String innerWidth, boolean autoStart, boolean isDisposeOnComplete)
	{
		m_ctx = ctx;
		m_WindowNo = WindowNo;
		m_AD_Process_ID = AD_Process_ID;
		setProcessInfo(pi);
		m_disposeOnComplete = isDisposeOnComplete;
		
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
			pstmt.setInt(1, AD_Process_ID);
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

		//	Move from APanel.actionButton
		if (m_pi == null)
			m_pi = new WProcessInfo(m_Name, AD_Process_ID);
		m_pi.setAD_User_ID (Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		m_pi.setTitle(m_Name);
		parameterPanel = new ProcessParameterPanel(m_WindowNo, m_pi, innerWidth);
		centerPanel.getChildren().clear();
		if ( parameterPanel.init() ) {
			centerPanel.appendChild(parameterPanel);
		} else {
			if (m_ShowHelp != null && m_ShowHelp.equals("N"))
				autoStart = true;
			
			if (autoStart)
			{
				autoStart();
				return true;
			}
		}

		// Check if the process is a silent one
		if (isValid() && m_ShowHelp != null && m_ShowHelp.equals("S"))
		{
			autoStart();
			return true;
		}
		
		if (MSysConfig.getBooleanValue(MSysConfig.BACKGROUND_JOB_ALLOWED, false))
		{
			Grid grid = GridFactory.newGridLayout();
			centerPanel.appendChild(grid);
			grid.setInnerWidth(innerWidth);

			Columns columns = new Columns();
			grid.appendChild(columns);
			Column col = new Column();
			col.setWidth("30%");
			columns.appendChild(col);
			col = new Column();
			col.setWidth("70%");
			columns.appendChild(col);
			
			Rows rows = new Rows();
			grid.appendChild(rows);
			
			Row row = new Row();
			rows.appendChild(row);
			
			row.appendChild(new Space());
			runAsJobField = new Checkbox();
			runAsJobField.setLabel(Msg.getElement(m_ctx, MPInstance.COLUMNNAME_IsRunAsJob));
			row.appendChild(runAsJobField);
			runAsJobField.addEventListener(Events.ON_CHECK, this);
			
			row = new Row();
			rows.appendChild(row);
			
			Div div = new Div();
	        div.setStyle("text-align: right;");
	        div.appendChild(new Label(Msg.getElement(m_ctx, MPInstance.COLUMNNAME_NotificationType)));
	        row.appendChild(div);	        
			
	        MLookupInfo info = MLookupFactory.getLookup_List(Env.getLanguage(m_ctx), MPInstance.NOTIFICATIONTYPE_AD_Reference_ID);
	        notificationTypeField = new WTableDirEditor(MPInstance.COLUMNNAME_NotificationType, true, false, true, new MLookup(info, 0));
	        Combobox combobox = notificationTypeField.getComponent();
			List<?> items = combobox.getItems();
			for (int i = 0; i < items.size(); i++) {
				ComboItem item = (ComboItem)items.get(i);
				if (MPInstance.NOTIFICATIONTYPE_None.equals(item.getValue()))
					combobox.removeItemAt(i);
			}
			
			MUser user = MUser.get(m_ctx);
			String notificationType = user.getNotificationType();
			if (!MPInstance.NOTIFICATIONTYPE_None.equals(notificationType))
				notificationTypeField.setValue(notificationType);
			
			row.appendChild(notificationTypeField.getComponent());
			runAsJobField.setChecked(MSysConfig.getBooleanValue(MSysConfig.BACKGROUND_JOB_BY_DEFAULT, false));
			notificationTypeField.getComponent().getParent().setVisible(runAsJobField.isChecked());			
		}

		return true;
	}
	
	protected void autoStart()
	{
		startProcess0();
	}
	
	public void onEvent(Event event) 
	{
		Component component = event.getTarget();
		if (component == runAsJobField && event.getName().equals(Events.ON_CHECK))
		{
			notificationTypeField.getComponent().getParent().setVisible(runAsJobField.isChecked());
			centerPanel.invalidate();
		}
		else if (event.getName().equals(ON_COMPLETE))
			onComplete();
		else if (event.getName().equals(ON_STATUS_UPDATE))
			onStatusUpdate(event);
	}
	
	protected void startProcess()
	{
		if (!parameterPanel.validateParameters())
			return;
		
		startProcess0();
	}
	
	protected void cancelProcess() 
	{
		m_cancel = true;
		this.dispose();
	}
	
	protected BusyDialog createBusyDialog() 
	{
		progressWindow = new BusyDialog();
		this.appendChild(progressWindow);
		return progressWindow;
	}
	
	protected void closeBusyDialog() 
	{
		if (progressWindow != null) {
			progressWindow.dispose();
			progressWindow = null;
		}
	}
	
	@Override
	public void dispose()
	{
		m_valid = false;
	}	//	dispose
	
	private void startProcess0()
	{		
		if (!isBackgroundJob())
			getProcessInfo().setPrintPreview(true);

		lockUI(getProcessInfo());
		
		downloadFiles = new ArrayList<File>();

		//use echo, otherwise lock ui wouldn't work
		Clients.response(new AuEcho(this, isBackgroundJob() ? "runBackgroundJob" : "runProcess", this));
	}
	
	public void runProcess() 
	{
		Events.sendEvent(DialogEvents.ON_BEFORE_RUN_PROCESS, this, null);
		future = Adempiere.getThreadPoolExecutor().submit(new DesktopRunnable(new ProcessDialogRunnable(null), getDesktop()));
	}

	public void runBackgroundJob() 
	{
		Properties m_ctx = getCtx();
		ProcessInfo m_pi = getProcessInfo();
		MPInstance instance = null;
		
		try 
		{
			int AD_Client_ID = Env.getAD_Client_ID(m_ctx);
			int AD_User_ID = Env.getAD_User_ID(m_ctx);
			
			int count = new Query(m_ctx, MPInstance.Table_Name, "Coalesce(AD_User_ID,0)=? AND IsProcessing='Y' AND IsRunAsJob='Y' ", null)
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.setParameters(AD_User_ID)
			.count();
			if (count >= MSysConfig.getIntValue(MSysConfig.BACKGROUND_JOB_MAX_PER_USER, 5, AD_Client_ID))
				throw new IllegalStateException(Msg.getMsg(m_ctx, "BackgroundJobExceedMaxPerUser"));
			
			count = new Query(m_ctx, MPInstance.Table_Name, "IsProcessing='Y' AND IsRunAsJob='Y' ", null)
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.count();
			if (count >= MSysConfig.getIntValue(MSysConfig.BACKGROUND_JOB_MAX_PER_CLIENT, 10, AD_Client_ID))
				throw new IllegalStateException(Msg.getMsg(m_ctx, "BackgroundJobExceedMaxPerClient"));
			
			count = new Query(m_ctx, MPInstance.Table_Name, "IsProcessing='Y' AND IsRunAsJob='Y' ", null)
			.setOnlyActiveRecords(true)
			.count();
			if (count >= MSysConfig.getIntValue(MSysConfig.BACKGROUND_JOB_MAX_IN_SYSTEM, 20))
				throw new IllegalStateException(Msg.getMsg(m_ctx, "BackgroundJobExceedMaxInSystem"));
			
			instance = new MPInstance(m_ctx, m_pi.getAD_Process_ID(), m_pi.getRecord_ID());
			instance.setIsRunAsJob(true);
			instance.setIsProcessing(true);
			instance.setNotificationType(getNotificationType());
			instance.saveEx();
			
			m_pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());
			getParameterPanel().saveParameters();
			
			MPInstance.publishChangedEvent(AD_User_ID);
			Adempiere.getThreadPoolExecutor().schedule(new BackgroundJobRunnable(getCtx()), 1000, TimeUnit.MILLISECONDS);
			
			m_pi.setSummary(Msg.getMsg(m_ctx, "BackgroundJobScheduled"));
		} catch (Exception e) {
			m_pi.setSummary(e.getLocalizedMessage());
			m_pi.setError(true);

			if (instance != null)
			{
				instance.setIsProcessing(false);
				instance.saveEx();
			}
		}
		finally {
			unlockUI(m_pi);
			
			if (m_disposeOnComplete)
				dispose();
		}
	}
	
	private void onComplete()
	{
		ProcessInfo m_pi = getProcessInfo();
		
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
		unlockUI(m_pi);
		if (downloadFiles.size() > 0) {
			MultiFileDownloadDialog downloadDialog = new MultiFileDownloadDialog(downloadFiles.toArray(new File[0]));
			downloadDialog.setPage(getPage());
			downloadDialog.setTitle(m_pi.getTitle());
			Events.postEvent(downloadDialog, new Event(MultiFileDownloadDialog.ON_SHOW));
		}
		
		if (m_disposeOnComplete)
			dispose();
	}
	
	private void onStatusUpdate(Event event) 
	{
		String message = (String) event.getData();
		if (progressWindow != null)
			progressWindow.statusUpdate(message);
	}

	@Override
	public void lockUI(ProcessInfo pi) {
		if (m_locked || Executions.getCurrent() == null) 
			return;
		m_locked = true;
		showBusyDialog();
	}
	
	public abstract void showBusyDialog();

	@Override
	public void unlockUI(ProcessInfo pi) {
		if (!m_locked) 
			return;
		m_locked = false;
		
		if (Executions.getCurrent() == null) 
		{
			Executions.schedule(getDesktop(), new EventListener<Event>() 
			{
				@Override
				public void onEvent(Event event) throws Exception {
					doUnlockUI();
				}
			}, new Event("onUnLockUI"));
		} else {
			doUnlockUI();
		}
	}
	
	private void doUnlockUI()
	{
		hideBusyDialog();
		updateUI();		
	}
	
	public abstract void hideBusyDialog();
	
	public abstract void updateUI();

	@Override
	public boolean isUILocked() {
		return m_locked;
	}

	@Override
	public void statusUpdate(String message) {
		Desktop desktop = getDesktop();
		if (desktop != null && desktop.isAlive())
			Executions.schedule(desktop, this, new Event(ON_STATUS_UPDATE, this, message));
	}

	@Override
	public void ask(final String message, final Callback<Boolean> callback) {
		Executions.schedule(getDesktop(), new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				FDialog.ask(getWindowNo(), null, message, callback);
			}
		}, new Event("onAsk"));
	}

	@Override
	public void download(File file) {
		downloadFiles.add(file);
	}

	/**
	 * 
	 * @return ProcessInfo
	 */
	public ProcessInfo getProcessInfo() {
		return m_pi;
	}
	
	public void setProcessInfo(ProcessInfo pi) {
		m_pi = pi;
	}

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
	
	public Properties getCtx()
	{
		return m_ctx;
	}

	public int getWindowNo()
	{
		return m_WindowNo;
	}
	
	public int getAD_Process_ID()
	{
		return m_AD_Process_ID;
	}

	public Html getMessage()
	{
		return message;
	}
	
	public Panel getCenterPanel()
	{
		return centerPanel;
	}
	
	public ProcessParameterPanel getParameterPanel()
	{
		return parameterPanel;
	}
	
	public String getName()
	{
		return m_Name;
	}
	
	public StringBuffer getMessageText()
	{
		return m_messageText;
	}
	
	public void setMessageText(StringBuffer messageText)
	{
		this.m_messageText = messageText;
	}

	public String getShowHelp()
	{
		return m_ShowHelp;
	}

	public String getInitialMessage()
	{
		return initialMessage;
	}
	
	public boolean isBackgroundJob()
	{
		return runAsJobField != null && runAsJobField.isChecked();
	}
	
	public String getNotificationType()
	{
		return (String) notificationTypeField.getValue();
	}
	
	public List<File> getDownloadFiles()
	{
		return downloadFiles;
	}
	
	private class ProcessDialogRunnable extends ContextRunnable
	{
		private Trx m_trx;
		
		private ProcessDialogRunnable(Trx trx) 
		{
			super();			
			m_trx = trx;
		}
		
		protected void doRun() 
		{
			ProcessInfo m_pi = getProcessInfo();
			try {
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, "Process Info=" + m_pi + " AD_Client_ID="+ Env.getAD_Client_ID(Env.getCtx()));
				WProcessCtl.process(AbstractProcessDialog.this, getWindowNo(), getParameterPanel(), m_pi, m_trx);
			} catch (Exception ex) {
				m_pi.setError(true);
				m_pi.setSummary(ex.getLocalizedMessage());
				log.log(Level.SEVERE, ex.getLocalizedMessage(), ex);
			} finally {
				Executions.schedule(getDesktop(), AbstractProcessDialog.this, new Event(ON_COMPLETE, AbstractProcessDialog.this, null));
			}		
		}
	}
	
	private class BackgroundJobRunnable implements Runnable
	{
		private Properties m_ctx;
		
		private BackgroundJobRunnable(Properties ctx) 
		{
			super();
			
			m_ctx = new Properties();
			Env.setContext(m_ctx, "#AD_Client_ID", ctx.getProperty("#AD_Client_ID"));
			Env.setContext(m_ctx, "#AD_Org_ID", ctx.getProperty("#AD_Org_ID"));
			Env.setContext(m_ctx, "#AD_Role_ID", ctx.getProperty("#AD_Role_ID"));
			Env.setContext(m_ctx, "#M_Warehouse_ID", ctx.getProperty("#M_Warehouse_ID"));
			Env.setContext(m_ctx, "#AD_Language", ctx.getProperty("#AD_Language"));
			Env.setContext(m_ctx, "#AD_User_ID", ctx.getProperty("#AD_User_ID"));
			Env.setContext(m_ctx, "#Date", ctx.getProperty("#Date"));
		}
		
		@Override
		public void run() {
			try {
				ServerContext.setCurrentInstance(m_ctx);
				doRun();
			} finally {
				ServerContext.dispose();
			}
		}
		
		private void doRun()
		{			
			ProcessInfo m_pi = getProcessInfo();
			m_pi.setIsBatch(true);
			m_pi.setPrintPreview(true);
			
			MPInstance instance = new MPInstance(m_ctx, m_pi.getAD_PInstance_ID(), null);
			String notificationType = instance.getNotificationType();
			boolean sendEmail = notificationType.equals(MPInstance.NOTIFICATIONTYPE_EMail) || notificationType.equals(MPInstance.NOTIFICATIONTYPE_EMailPlusNotice);
			boolean createNotice = notificationType.equals(MPInstance.NOTIFICATIONTYPE_Notice) || notificationType.equals(MPInstance.NOTIFICATIONTYPE_EMailPlusNotice);
			
			int AD_Client_ID = Env.getAD_Client_ID(m_ctx);
			int AD_User_ID = Env.getAD_User_ID(m_ctx);
			
			try {
				m_pi.setSummary(""); // reset summary
				
				MProcess process = new MProcess(m_ctx, m_pi.getAD_Process_ID(), null);	
				ServerProcessCtl.process(m_pi, null);
				ProcessInfoUtil.setLogFromDB(m_pi);
				if (!m_pi.isError())
				{					
					boolean isReport = (process.isReport() || process.getAD_ReportView_ID() > 0 || process.getJasperReport() != null || process.getAD_PrintFormat_ID() > 0);
					if (isReport)
					{
						download(m_pi.getPDFReport());
					}
					
					if (m_pi.isExport() && m_pi.getExportFile() != null)
						download(m_pi.getExportFile());										
				}
				
				if (sendEmail)
				{
					MClient client = MClient.get(m_ctx, AD_Client_ID);
					client.sendEMailAttachments(AD_User_ID, process.getName(), m_pi.getSummary() + " " + m_pi.getLogInfo(), getDownloadFiles());
				}
				
				if (createNotice)
				{
					MNote note = new MNote(m_ctx, "BackgroundJob", AD_User_ID, null);
					note.setTextMsg(process.getName() + "\n" + m_pi.getSummary());
					note.setRecord(MPInstance.Table_ID, m_pi.getAD_PInstance_ID());
					note.saveEx();
					
					MAttachment attachment = null;
					if (getDownloadFiles().size() > 0)
					{
						attachment = note.createAttachment();
						for (File downloadFile : getDownloadFiles())
							attachment.addEntry(downloadFile);						
					}
					String log = m_pi.getLogInfo(true);
					if (log != null && log.trim().length() > 0) {
						if (attachment == null)
							attachment = note.createAttachment();
						attachment.addEntry("ProcessLog.html", log.getBytes("UTF-8"));
					}
					if (attachment != null)
						attachment.saveEx();
				}
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage());				
			} finally {
				instance.setIsProcessing(false);
				instance.saveEx();
				
				MPInstance.publishChangedEvent(AD_User_ID);
			}
		}
	}

	@Override
	public void askForInput(final String message, final Callback<String> callback) {
		Executions.schedule(getDesktop(), new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				FDialog.askForInput(m_WindowNo, null, message, callback);
			}
		}, new Event("onAskForInput"));
	}

}