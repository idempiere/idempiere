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
package org.adempiere.webui.apps;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Callable;
import java.util.logging.Level;

import org.adempiere.util.IProcessUI;
import org.adempiere.util.ServerContext;
import org.compiere.model.MAttachment;
import org.compiere.model.MClient;
import org.compiere.model.MNote;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstanceLog;
import org.compiere.model.MProcess;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * Callable to run process as background job.<br/>
 * Send email or notice notification to user upon completion of job. 
 */
public class BackgroundJobCallable implements Callable<ProcessInfo>
{
	private final ProcessInfo processInfo;	
	private Properties m_ctx;
	private IProcessUI processUI;
	
	private static final CLogger log = CLogger.getCLogger(BackgroundJobCallable.class);
			
	/**
	 * @param ctx
	 * @param processInfo
	 */
	public BackgroundJobCallable(Properties ctx, ProcessInfo processInfo)
	{
		this(ctx, processInfo, null);
	}
	
	/**
	 * @param ctx
	 * @param processInfo
	 * @param processUI
	 */
	public BackgroundJobCallable(Properties ctx, ProcessInfo processInfo, IProcessUI processUI) 
	{
		super();
		this.processInfo = processInfo;
		this.processUI = processUI;
		
		m_ctx = new Properties();
		Env.setContext(m_ctx, Env.AD_CLIENT_ID, ctx.getProperty(Env.AD_CLIENT_ID));
		Env.setContext(m_ctx, Env.AD_ORG_ID, ctx.getProperty(Env.AD_ORG_ID));
		Env.setContext(m_ctx, Env.AD_ROLE_ID, ctx.getProperty(Env.AD_ROLE_ID));
		Env.setContext(m_ctx, Env.M_WAREHOUSE_ID, ctx.getProperty(Env.M_WAREHOUSE_ID));
		Env.setContext(m_ctx, Env.LANGUAGE, ctx.getProperty(Env.LANGUAGE));
		Env.setContext(m_ctx, Env.AD_USER_ID, ctx.getProperty(Env.AD_USER_ID));
		Env.setContext(m_ctx, Env.DATE, ctx.getProperty(Env.DATE));
		Env.setContext(m_ctx, Env.AD_SESSION_ID, ctx.getProperty(Env.AD_SESSION_ID));
	}
	
	@Override
	public ProcessInfo call() {
		try {
			ServerContext.setCurrentInstance(m_ctx);
			return doRun();
		} finally {
			ServerContext.dispose();
		}
	}
	
	/**
	 * Run job
	 * @return 
	 */
	private ProcessInfo doRun()
	{			
		processInfo.setIsBatch(true);
		processInfo.setPrintPreview(true);
		
		MPInstance instance = new MPInstance(m_ctx, processInfo.getAD_PInstance_ID(), null);
		String notificationType = instance.getNotificationType();
		if (notificationType == null)
			notificationType = MPInstance.NOTIFICATIONTYPE_Notice;
		boolean sendEmail = notificationType.equals(MPInstance.NOTIFICATIONTYPE_EMail) || notificationType.equals(MPInstance.NOTIFICATIONTYPE_EMailPlusNotice);
		boolean createNotice = notificationType.equals(MPInstance.NOTIFICATIONTYPE_Notice) || notificationType.equals(MPInstance.NOTIFICATIONTYPE_EMailPlusNotice);
		
		int AD_Client_ID = Env.getAD_Client_ID(m_ctx);
		int AD_User_ID = Env.getAD_User_ID(m_ctx);
		
		try {
			MProcess process = new MProcess(m_ctx, processInfo.getAD_Process_ID(), null);	
			if (process.isReport() && process.getJasperReport() != null) {
				if (!Util.isEmpty(process.getJasperReport())) 
				{
					processInfo.setExport(true);
					if ("HTML".equals(processInfo.getReportType())) 
						processInfo.setExportFileExtension("html");
					else if ("CSV".equals(processInfo.getReportType()))
						processInfo.setExportFileExtension("csv");
					else if ("XLS".equals(processInfo.getReportType()))
						processInfo.setExportFileExtension("xls");
					else if ("XLSX".equals(processInfo.getReportType()))
						processInfo.setExportFileExtension("xlsx");
					else
						processInfo.setExportFileExtension("pdf");
				}
			}
			
			List<File> downloadFiles = new ArrayList<File>();
			ServerProcessCtl.process(processInfo, null);
			ProcessInfoUtil.setLogFromDB(processInfo);
			if (!processInfo.isError())
			{					
				boolean isReport = (process.isReport() || process.getAD_ReportView_ID() > 0 || process.getJasperReport() != null || process.getAD_PrintFormat_ID() > 0);
				if (isReport && processInfo.getPDFReport() != null)
				{
					downloadFiles.add(processInfo.getPDFReport());
					if (processUI != null)
						processUI.download(processInfo.getPDFReport());
				}
				
				if (processInfo.isExport() && processInfo.getExportFile() != null) 
				{
					downloadFiles.add(processInfo.getExportFile());
					if (processUI != null)
						processUI.download(processInfo.getExportFile());
				}
			}
			
			if (sendEmail)
			{
				MClient client = MClient.get(m_ctx, AD_Client_ID);
				client.sendEMailAttachments(AD_User_ID, process.get_Translation("Name", Env.getAD_Language(Env.getCtx())), processInfo.getSummary() + " " + processInfo.getLogInfo(), 
						downloadFiles);
			}
			
			if (createNotice)
			{
				MNote note = new MNote(m_ctx, "BackgroundJob", AD_User_ID, null);
				note.setTextMsg(process.get_Translation("Name", Env.getAD_Language(Env.getCtx())) + "\n" + processInfo.getSummary());
				note.setRecord(MPInstance.Table_ID, processInfo.getAD_PInstance_ID());
				note.saveEx();
				
				MAttachment attachment = null;
				if (downloadFiles.size() > 0)
				{
					attachment = note.createAttachment();
					for (File downloadFile : downloadFiles)
						attachment.addEntry(downloadFile);						
				}
				String log = processInfo.getLogInfo(true);
				if (log != null && log.trim().length() > 0) {
					if (attachment == null)
						attachment = note.createAttachment();
					attachment.addEntry("ProcessLog.html", log.getBytes("UTF-8"));
				}
				if (attachment != null)
					attachment.saveEx();
				MPInstanceLog il = instance.addLog(null, 0, null, Msg.parseTranslation(m_ctx, "@Created@ @AD_Note_ID@ " + note.getAD_Note_ID()),
						MNote.Table_ID, note.getAD_Note_ID());
				il.saveEx();
			}
		} catch (Throwable e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			if (instance.getAD_PInstance_ID() > 0) {
				MPInstanceLog il = instance.addLog(null, 0, null, e.getLocalizedMessage());
				il.save();
			}
		} finally {
			instance.setIsProcessing(false);
			instance.saveEx();
			
			MPInstance.publishChangedEvent(AD_User_ID);
		}
		return processInfo;
	}
}
