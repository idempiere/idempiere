/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
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
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.server;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.logging.Level;

import org.adempiere.impexp.ArrayExcelExporter;
import org.compiere.model.MAlert;
import org.compiere.model.MAlertProcessor;
import org.compiere.model.MAlertProcessorLog;
import org.compiere.model.MAlertRule;
import org.compiere.model.MAttachment;
import org.compiere.model.MClient;
import org.compiere.model.MNote;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;
import org.compiere.model.MUser;
import org.compiere.model.SystemIDs;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

/**
 *	Alert Processor
 *	
 *  @author Jorg Janke
 *  @version $Id: AlertProcessor.java,v 1.4 2006/07/30 00:53:33 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>FR [ 1894573 ] Alert Processor Improvements
 * 			<li>FR [ 2453882 ] Alert Processor : attached file name improvement
 * @author Kubotti
 * 			<li>BF [ 2785633 ] Adding a Notice in Alert Processor
 */
public class AlertProcessor extends AdempiereServer
{
	/**
	 * 	Alert Processor
	 *	@param model model
	 */
	public AlertProcessor (MAlertProcessor model)
	{
		super (model, 30);	//	30 seconds delay 
		m_model = model;
		m_client = MClient.get(model.getCtx(), model.getAD_Client_ID());
	}	//	AlertProcessor

	/**	The Concrete Model			*/
	protected MAlertProcessor		m_model = null;
	/**	Last Summary				*/
	protected StringBuffer 		m_summary = new StringBuffer();
	/**	Last Error Msg				*/
	protected StringBuffer 		m_errors = new StringBuffer();
	/** Client info					*/
	protected MClient 			m_client = null;

	/**
	 * 	Work
	 */
	protected void doWork ()
	{
		m_summary = new StringBuffer();
		m_errors = new StringBuffer();
		//
		int count = 0;
		int countError = 0;
		MAlert[] alerts = m_model.getAlerts(false);
		for (int i = 0; i < alerts.length; i++)
		{
			Language language = Env.getLanguage(getCtx());
			// Try to get the language of the client's alert
			MClient client = MClient.get(getCtx(), alerts[i].getAD_Client_ID());
			if (client.getLanguage() != null)
				language = client.getLanguage();

			if (!processAlert(alerts[i], language))
				countError++;
			count++;
		}
		//
		String summary = "Total=" + count;
		if (countError > 0)
			summary += ", Not processed=" + countError;
		summary += " - ";
		m_summary.insert(0, summary);
		//
		int no = m_model.deleteLog();
		m_summary.append("Logs deleted=").append(no);
		//
		MAlertProcessorLog pLog = new MAlertProcessorLog(m_model, m_summary.toString());
		pLog.setReference("#" + String.valueOf(p_runCount) 
			+ " - " + TimeUtil.formatElapsed(new Timestamp(p_startWork)));
		pLog.setTextMsg(m_errors.toString());
		pLog.saveEx();
	}	//	doWork

	/**
	 * 	Process Alert
	 *	@param alert alert
	 *	@return true if processed
	 */
	protected boolean processAlert (MAlert alert, Language language)
	{
		if (!alert.isValid())
			return false;
		if (log.isLoggable(Level.INFO)) log.info("" + alert);

		MSystem system = MSystem.get(Env.getCtx());
		MClient client = MClient.get(Env.getCtx(), alert.getAD_Client_ID());
		// parse variables from Client, then from System
		String alertMessage = Env.parseVariable(alert.getAlertMessage(), client, null, true);
		alertMessage = Env.parseVariable(alertMessage, system, null, true);
		StringBuilder message = new StringBuilder(alertMessage).append(Env.NL);
		//
		boolean valid = true;
		boolean processed = false;
		ArrayList<File> attachments = new ArrayList<File>();
		MAlertRule[] rules = alert.getRules(false);
		for (int i = 0; i < rules.length; i++)
		{
			if (i > 0)
				message.append(Env.NL);
			
			MAlertRule rule = rules[i];
			if (!rule.isValid())
				continue;
			if (log.isLoggable(Level.FINE)) log.fine("" + rule);
			
			//	Pre
			String sql = rule.getPreProcessing();
			if (sql != null && sql.length() > 0)
			{
				int no = DB.executeUpdate(sql, false, null);
				if (no == -1)
				{
					ValueNamePair error = CLogger.retrieveError();
					rule.setErrorMsg("Pre=" + error.getName());
					m_errors.append("Pre=" + error.getName());
					rule.setIsValid(false);
					rule.saveEx();
					valid = false;
					break;
				}
			}	//	Pre
			
			//	The processing
			sql = rule.getSql(true);
			try
			{
				String text = null;
				if (MSysConfig.getBooleanValue(MSysConfig.ALERT_SEND_ATTACHMENT_AS_XLS, true, alert.getAD_Client_ID()))
					text = getExcelReport(rule, sql, language, null, attachments);
				else
					text = getPlainTextReport(rule, sql, null, attachments);
				if (text != null && text.length() > 0)
				{
					message.append(text);
					processed = true;
				}
			}
			catch (Exception e)
			{
				rule.setErrorMsg("Select=" + e.getLocalizedMessage());
				m_errors.append("Select=" + e.getLocalizedMessage());
				rule.setIsValid(false);
				rule.saveEx();
				valid = false;
				break;
			}

			//	Post
			sql = rule.getPostProcessing();
			if (sql != null && sql.length() > 0)
			{
				int no = DB.executeUpdate(sql, false, null);
				if (no == -1)
				{
					ValueNamePair error = CLogger.retrieveError();
					rule.setErrorMsg("Post=" + error.getName());
					m_errors.append("Post=" + error.getName());
					rule.setIsValid(false);
					rule.saveEx();
					valid = false;
					break;
				}
			}	//	Post

		}	//	 for all rules
		
		//	Update header if error
		if (!valid)
		{
			alert.setIsValid(false);
			alert.saveEx();
			return false;
		}
		
		//	Nothing to report
		if (!processed)
		{
			m_summary.append(alert.getName()).append("=No Result - ");
			return true;
		}
		
		//
		// Report footer - Date Generated
		DateFormat df = DisplayType.getDateFormat(DisplayType.DateTime, language);
		message.append(Env.NL).append(Env.NL);
		message.append(Msg.translate(language, "Date")).append(" : ")
				.append(df.format(new Timestamp(System.currentTimeMillis())));
		
		Collection<Integer> users = alert.getRecipientUsers();
		// parse variables from Client, then from System
		String alertSubject = Env.parseVariable(alert.getAlertSubject(), client, null, true);
		alertSubject = Env.parseVariable(alertSubject, system, null, true);
		int countMail = notifyUsers(users, alertSubject, message.toString(), attachments, alert);
		
		// IDEMPIERE-2864
		for(File attachment : attachments)
		{
			if(attachment.exists() && !attachment.delete())
				attachment.deleteOnExit();
		}
		
		m_summary.append(alert.getName()).append(" (EMails+Notes=").append(countMail).append(") - ");
		return valid;
	}	//	processAlert
	
	/**
	 * Notify users
	 * @param users AD_User_ID list
	 * @param subject email subject
	 * @param message email message
	 * @param attachments 
	 * @param alert 
	 * @return how many email were sent
	 */
	protected int notifyUsers(Collection<Integer> users, String subject, String message, Collection<File> attachments, MAlert alert)
	{
		int countMail = 0;
		for (int user_id : users) {
			MUser user = MUser.get(getCtx(), user_id);
			if (user.isNotificationEMail()) {
				String messageHTML = message.replaceAll(Env.NL, "<br>");
				MClient client = MClient.get(Env.getCtx(), alert.getAD_Client_ID());
				if (client.sendEMailAttachments (user_id, subject, messageHTML, attachments, true))
				{
					countMail++;
				}
			}

			if (user.isNotificationNote()) {
				Trx trx = null;
				try {
					trx = Trx.get(Trx.createTrxName("AP_NU"), true);
					trx.setDisplayName(getClass().getName()+"_"+m_model.getName()+"_notifyUsers");
					// Notice
					int AD_Message_ID = SystemIDs.MESSAGE_NOTES;  /* TODO - Hardcoded message=notes */
					MNote note = new MNote(getCtx(), AD_Message_ID, user_id, trx.getTrxName());
					note.setClientOrg(alert.getAD_Client_ID(), alert.getAD_Org_ID());
					note.setTextMsg(message);
					note.setDescription(subject);
					note.saveEx();
					if (attachments.size() > 0) {
						// Attachment
						MAttachment attachment = new MAttachment (getCtx(), MNote.Table_ID, note.getAD_Note_ID(), trx.getTrxName());
						attachment.setClientOrg(alert.getAD_Client_ID(), alert.getAD_Org_ID());
						for (File f : attachments) {
							attachment.addEntry(f);
						}
						attachment.saveEx();
					}
					countMail++;
					trx.commit();
				} catch (Throwable e) {
					if (trx != null) trx.rollback();
				} finally {
					if (trx != null) trx.close();
				}
			}

		}
		return countMail;
	}
	
	/**
	 * Get Alert Data
	 * @param sql
	 * @param trxName
	 * @return data
	 * @throws Exception
	 */
	protected ArrayList<ArrayList<Object>> getData (String sql, String trxName) throws Exception
	{
		ArrayList<ArrayList<Object>> data = new ArrayList<ArrayList<Object>>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Exception error = null;
		try
		{
			pstmt = DB.prepareNormalReadReplicaStatement(sql, trxName);
			rs = pstmt.executeQuery ();
			ResultSetMetaData meta = rs.getMetaData();
			boolean isFirstRow = true;
			while (rs.next ())
			{
				ArrayList<Object> header = (isFirstRow ? new ArrayList<Object>() : null);
				ArrayList<Object> row = new ArrayList<Object>();
				for (int col = 1; col <= meta.getColumnCount(); col++)
				{
					if (isFirstRow) {
						String columnName = meta.getColumnLabel(col);
						header.add(columnName);
					}
					Object o = rs.getObject(col);
					row.add(o);
				}	//	for all columns
				if (isFirstRow)
					data.add(header);
				data.add(row);
				isFirstRow = false;
			}
		}
		catch (Throwable e)
		{
			log.log(Level.SEVERE, sql, e);
			if (e instanceof Exception)
				error = (Exception)e;
			else
				error = new Exception(e.getMessage(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		//	Error occurred
		if (error != null)
			throw new Exception ("(" + sql + ") " + Env.NL 
				+ error.getLocalizedMessage());
		
		return data;
	}	//	getData
	
	/**
	 * Get Plain Text Report (old functionality) 
	 * @param rule (ignored)
	 * @param sql sql select
	 * @param trxName transaction
	 * @param attachments (ignored)
	 * @return list of rows & values
	 * @throws Exception
	 */
	protected String getPlainTextReport(MAlertRule rule, String sql, String trxName, Collection<File> attachments)
	throws Exception
	{
		StringBuilder result = new StringBuilder();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Exception error = null;
		try
		{
			pstmt = DB.prepareNormalReadReplicaStatement(sql, trxName);
			rs = pstmt.executeQuery ();
			ResultSetMetaData meta = rs.getMetaData();
			while (rs.next ())
			{
				result.append("------------------").append(Env.NL);
				for (int col = 1; col <= meta.getColumnCount(); col++)
				{
					result.append(meta.getColumnLabel(col)).append(" = ");
					result.append(rs.getString(col));
					result.append(Env.NL);
				}	//	for all columns
			}
			if (result.length() == 0)
				log.fine("No rows selected");
		}
		catch (Throwable e)
		{
			log.log(Level.SEVERE, sql, e);
			if (e instanceof Exception)
				error = (Exception)e;
			else
				error = new Exception(e.getMessage(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		//	Error occurred
		if (error != null)
			throw new Exception ("(" + sql + ") " + Env.NL 
				+ error.getLocalizedMessage());
		
		return result.toString();
	}

	/**
	 * Get Excel Report
	 * @param rule
	 * @param sql
	 * @param trxName
	 * @param attachments
	 * @return summary message to be added into mail content
	 * @throws Exception
	 */
	protected String getExcelReport(MAlertRule rule, String sql, Language language, String trxName, Collection<File> attachments)
	throws Exception
	{
		ArrayList<ArrayList<Object>> data = getData(sql, trxName);
		if (data.size() <= 1)
			return null;
		// File
		File file = rule.createReportFile("xlsx");
		//
		ArrayExcelExporter exporter = new ArrayExcelExporter(getCtx(), data);
		exporter.export(file, language, false);
		attachments.add(file);
		String msg = rule.getName() + " (" + Msg.translate(language, "SeeAttachment") + " " + file.getName() + ")" + Env.NL;
		return msg;
	}
	
	/**
	 * 	Get Server Info
	 *	@return info
	 */
	public String getServerInfo()
	{
		return "#" + p_runCount + " - Last=" + m_summary.toString();
	}	//	getServerInfo	
}
