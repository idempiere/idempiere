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
package org.compiere.process;

import java.io.File;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.adempiere.util.IProcessUI;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstanceLog;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_PInstance_Log;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *  Process Information (Value Object)
 *
 *  @author     Jorg Janke
 *  @version    $Id: ProcessInfo.java,v 1.2 2006/07/30 00:54:44 jjanke Exp $
 *  @author victor.perez@e-evolution.com 
 *  see FR 1906632 https://sourceforge.net/p/adempiere/feature-requests/382/
 */
public class ProcessInfo implements Serializable
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8134286335553869253L;

	private static final CLogger logger = CLogger.getCLogger(ProcessInfo.class);

	/**
	 *  Constructor
	 *  @param Title Title
	 *  @param AD_Process_ID AD_Process_ID
	 *  @param Table_ID AD_Table_ID
	 *  @param Record_ID Record_ID
	 */
	public ProcessInfo(String Title, int AD_Process_ID, int Table_ID, int Record_ID)
	{
		this (Title, AD_Process_ID, Table_ID, Record_ID, null);
	}

	/**
	 *  Constructor
	 *  @param Title Title
	 *  @param AD_Process_ID AD_Process_ID
	 *  @param Table_ID AD_Table_ID
	 *  @param Record_ID Record ID
	 *  @param Record_UU Record UUID
	 */
	public ProcessInfo(String Title, int AD_Process_ID, int Table_ID, int Record_ID, String Record_UU)
	{
		setTitle (Title);
		setAD_Process_ID(AD_Process_ID);
		setTable_ID (Table_ID);
		setRecord_ID (Record_ID);
		setRecord_UU (Record_UU);
		if (Ini.isPropertyBool(Ini.P_PRINTPREVIEW))
			m_printPreview = true;
		else
			m_printPreview = false;
	}   //  ProcessInfo

	/** Process UUID			*/
	private String				m_AD_Process_UU;

	/**
	 *  Constructor
	 *  @param Title Title
	 *  @param AD_Process_ID AD_Process_ID
	 *   */
	public ProcessInfo (String Title, int AD_Process_ID)
	{
		this (Title, AD_Process_ID, 0, 0);
	}   //  ProcessInfo

	/** Title of the Process/Report */
	private String				m_Title;
	/** Process ID                  */
	private int					m_AD_Process_ID;
	/** Table ID if the Process	    */
	private int					m_Table_ID;
	/** Record ID if the Process    */
	private int					m_Record_ID;
	/** Record UUID if the Process    */
	private String				m_Record_UU;
	/** User_ID        					*/
	private Integer	 			m_AD_User_ID;
	/** Client_ID        				*/
	private Integer 			m_AD_Client_ID;
	/** Class Name 						*/
	private String				m_ClassName = null;

	//  -- Optional --

	/** Process Instance ID         */
	private int					m_AD_PInstance_ID = 0;

	private int					m_InfoWindowID = 0;
	/** Summary of Execution        */
	private String    			m_Summary = "";
	/** JsonData of Execution **/
	private String				m_jsonData;
	/** Execution had an error      */
	private boolean     		m_Error = false;

	/**	General Data Object			*/
	private Serializable		m_SerializableObject = null;
	/**	General Data Object			*/
	private transient Object	m_TransientObject = null;
	/** Estimated Runtime           */
	private int          		m_EstSeconds = 5;
	/** Batch						*/
	private boolean				m_batch = false;
	/** Process timed out				*/
	private boolean				m_timeout = false;

	/**	Log Info					*/
	private ArrayList<ProcessInfoLog> m_logs = null;

	/**	Log Info					*/
	private ProcessInfoParameter[]	m_parameter = null;
	
	/** Transaction Name 			*/
	private String				m_transactionName = null;
	
	private boolean				m_printPreview = false;

	private boolean				m_reportingProcess = false;
	//FR 1906632
	private File 			    m_pdf_report = null;
	
	/**	Record IDs				*/
	private List <Integer>		m_Record_IDs = null;

	/**	Record UUs				*/
	private List <String>		m_Record_UUs = null;

	/** Export					*/
	private boolean				m_export = false;
	
	/** Export File Extension	*/
	private String				m_exportFileExtension = null;
	
	/**	Export File				*/
	private File				m_exportFile = null;
	
	/** Report Override Tab */
	private boolean				m_IsReplaceTabContent = false;
	
	/** Row count */
	private int m_rowCount;

	private transient PO m_po = null;
	
	private String reportType = null;
	
	private boolean isSummary = false;
	
	private int languageID = 0;
	
	private String showHelp = null;

	private int m_AD_Scheduler_ID = 0;
	
	private Serializable internalReportObject = null;
	
	/** For scheduler: true to notify scheduler recipients with process execution result using AD_Scheduler.R_MailTexT_ID mail template (if define). Default is true. **/
	private boolean isNotifyRecipients = true;
	
	/**
	 * Get language id
	 * @return AD_Language_ID
	 */
	public int getLanguageID() {
		return languageID;
	}

	/**
	 * Set language id
	 * @param languageID AD_Language_ID
	 */
	public void setLanguageID(int languageID) {
		this.languageID = languageID;
	}

	/**
	 * Get report output type
	 * @return report output type
	 */
	public String getReportType() {
		return reportType;
	}

	/**
	 * Set report output type
	 * @param reportType
	 */
	public void setReportType(String reportType) {
		if (!Util.isEmpty(reportType))
			this.reportType = reportType;
	}
	
	/**
	 * Set is summary (for report)
	 * @param isSummary
	 */
	public void setIsSummary(boolean isSummary) {
		this.isSummary = isSummary;
	}
	
	/**
	 * Is summary report
	 * @return true if it is summary report
	 */
	public boolean isSummary() {
		return this.isSummary;
	}

	/**
	 * Set Show Help (parameter dialog)
	 * @param showHelp
	 */
	public void setShowHelp(String showHelp) {
		this.showHelp = showHelp;
	}

	/**
	 * Get Show Help (parameter dialog)
	 * @return String
	 */
	public String getShowHelp() {
		return this.showHelp;
	}

	/**
	 *  String representation
	 *  @return String representation
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("ProcessInfo[");
		sb.append(m_Title)
			.append(",Process_ID=").append(m_AD_Process_ID);
		if (m_AD_PInstance_ID != 0)
			sb.append(",AD_PInstance_ID=").append(m_AD_PInstance_ID);
		if (m_Record_ID != 0)
			sb.append(",Record_ID=").append(m_Record_ID);
		if (!Util.isEmpty(m_Record_UU))
			sb.append(",Record_UU=").append(m_Record_UU);
		if (m_ClassName != null)
			sb.append(",ClassName=").append(m_ClassName);
		sb.append(",Error=").append(isError());
		if (m_TransientObject != null)
			sb.append(",Transient=").append(m_TransientObject);
		if (m_SerializableObject != null)
			sb.append(",Serializable=").append(m_SerializableObject);
		if (m_transactionName != null)
			sb.append(",Trx=").append(m_transactionName);
		sb.append(",Summary=").append(getSummary())
			.append(",JsonData=").append(getJsonData())
			.append(",Log=").append(m_logs == null ? 0 : m_logs.size());
		//	.append(getLogInfo(false));
		sb.append("]");
		return sb.toString();
	}   //  toString
	

	/**************************************************************************
	 * 	Set JsonData
	 * 	@param jsonData jsonData (valid json string)
	 */
	public void setJsonData (String jsonData)
	{
		if (jsonData != null && !Util.isEmpty(jsonData))
			m_jsonData = Util.prettifyJSONString(jsonData);
	}	//	setJsonData
	/**
	 * Method getJsonData
	 * @return String
	 */
	public String getJsonData ()
	{
		return m_jsonData;
	}	//	getJsonData

	/**************************************************************************
	 * 	Set Summary
	 * 	@param summary summary (will be translated)
	 */
	public void setSummary (String summary)
	{
		m_Summary = summary;
	}	//	setSummary
	
	/**
	 * Get summary text
	 * @return summary text
	 */
	public String getSummary ()
	{
		return Util.cleanAmp(m_Summary);
	}	//	getSummary

	/**
	 * Set summary text
	 * @param translatedSummary translated summary text
	 * @param error true if this is error
	 */
	public void setSummary (String translatedSummary, boolean error)
	{
		setSummary (translatedSummary);
		setError(error);
	}	//	setSummary
	
	/**
	 * Append text to summary
	 * @param additionalSummary text to append to summary
	 */
	public void addSummary (String additionalSummary)
	{
		m_Summary += additionalSummary;
	}	//	addSummary

	/**
	 * Set is error flag
	 * @param error is error flag
	 */
	public void setError (boolean error)
	{
		m_Error = error;
	}	//	setError
	
	/**
	 * Is process has error
	 * @return true if process has error
	 */
	public boolean isError ()
	{
		return m_Error;
	}	//	isError

	/**
	 *	Batch
	 * 	@param batch true if batch processing
	 */
	public void setIsBatch (boolean batch)
	{
		m_batch = batch;
	}	//	setTimeout
	
	/**
	 *	Batch - i.e. started from server instead of from UI
	 *	@return true if it is batch processing
	 */
	public boolean isBatch()
	{
		return m_batch;
	}	//	isBatch

	/**
	 *	Set is Timeout
	 * 	@param timeout true if timeout
	 */
	public void setIsTimeout (boolean timeout)
	{
		m_timeout = timeout;
	}	//	setTimeout
	
	/**
	 *	Is Timeout - i.e process did not complete
	 *	@return true if process terminated due to transaction timeout
	 */
	public boolean isTimeout()
	{
		return m_timeout;
	}	//	isTimeout

	/**
	 *	Get Log of Process.
	 *  <pre>
	 *  - Translated Process Message
	 *  - List of log entries
	 *      Date - Number - Msg
	 *  </pre>
	 *	@param html if true with HTML markup
	 *	@return Log Info
	 */
	public String getLogInfo (boolean html)
	{
		if (m_logs == null)
			return "";
		//
		StringBuilder sb = new StringBuilder ();
		SimpleDateFormat dateFormat = DisplayType.getDateFormat(DisplayType.Date);
		if (html)
			sb.append("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\">");
		//
		for (int i = 0; i < m_logs.size(); i++)
		{
			if (html)
				sb.append("<tr>");
			else if (i > 0)
				sb.append("\n");
			//
			ProcessInfoLog log = m_logs.get(i);
			/**
			if (log.getP_ID() != 0)
				sb.append(html ? "<td>" : "")
					.append(log.getP_ID())
					.append(html ? "</td>" : " \t");	**/
			//
			if (log.getP_Date() != null)
				sb.append(html ? "<td>" : "")
					.append(dateFormat.format(log.getP_Date()))
					.append(html ? "</td>" : " \t");
			//
			if (log.getP_Number() != null)
				sb.append(html ? "<td>" : "")
					.append(log.getP_Number())
					.append(html ? "</td>" : " \t");
			//
			if (log.getP_Msg() != null)
				sb.append(html ? "<td>" : "")
					.append(Msg.parseTranslation(Env.getCtx(), log.getP_Msg()))
					.append(html ? "</td>" : "");
			//
			if (html)
				sb.append("</tr>");
		}
		if (html)
			sb.append("</table>");
		return sb.toString();
	 }	//	getLogInfo

	/**
	 * 	Get ASCII Log Info
	 *	@return Log Info
	 */
	public String getLogInfo ()
	{
		return getLogInfo(false);
	}	//	getLogInfo

	/**
	 * Get AD_PInstance_ID
	 * @return AD_PInstance_ID
	 */
	public int getAD_PInstance_ID()
	{
		return m_AD_PInstance_ID;
	}
	
	/**
	 * Set AD_PInstance_ID
	 * @param AD_PInstance_ID
	 */
	public void setAD_PInstance_ID(int AD_PInstance_ID)
	{
		m_AD_PInstance_ID = AD_PInstance_ID;
	}

	/**
	 * Get AD_InfoWindow_ID
	 * @return AD_InfoWindow_ID
	 */
	public int getAD_InfoWindow_ID()
	{
		return m_InfoWindowID;
	}
	
	/**
	 * Set AD_InfoWindow_ID 
	 * @param infoWindowID AD_InfoWindow_ID
	 */
	public void setAD_InfoWindow_ID(int infoWindowID)
	{
		m_InfoWindowID = infoWindowID;
	}
	
	/**
	 * Get AD_Process_ID
	 * @return AD_Process_ID
	 */
	public int getAD_Process_ID()
	{
		return m_AD_Process_ID;
	}
	
	/**
	 * Set AD_Process_ID
	 * @param AD_Process_ID
	 */
	public void setAD_Process_ID(int AD_Process_ID)
	{
		m_AD_Process_ID = AD_Process_ID;
	}

	/**
	 * Get process class name
	 * @return process class name or null
	 */
	public String getClassName()
	{
		return m_ClassName;
	}
	
	/**
	 * Set process class name
	 * @param ClassName process class name
	 */
	public void setClassName(String ClassName)
	{
		m_ClassName = ClassName;
		if (m_ClassName != null && m_ClassName.length() == 0)
			m_ClassName = null;
	}	//	setClassName

	/**
	 * Get TransientObject for process
	 * @return Object
	 */
	public Object getTransientObject()
	{
		return m_TransientObject;
	}
	
	/**
	 * Set Transient Object for process
	 * @param TransientObject
	 */
	public void setTransientObject (Object TransientObject)
	{
		m_TransientObject = TransientObject;
	}

	/**
	 * Get Serializable Object for process
	 * @return Serializable
	 */
	public Serializable getSerializableObject()
	{
		return m_SerializableObject;
	}
	
	/**
	 * Set Serializable Object for process
	 * @param SerializableObject
	 */
	public void setSerializableObject (Serializable SerializableObject)
	{
		m_SerializableObject = SerializableObject;
	}

	/**
	 * Get estimated process duration in seconds
	 * @return int
	 */
	public int getEstSeconds()
	{
		return m_EstSeconds;
	}
	
	/**
	 * Set estimated process duration in seconds
	 * @param EstSeconds int
	 */
	public void setEstSeconds (int EstSeconds)
	{
		m_EstSeconds = EstSeconds;
	}

	/**
	 * Get AD_Table_ID
	 * @return AD_Table_ID
	 */
	public int getTable_ID()
	{
		return m_Table_ID;
	}
	
	/**
	 * Set AD_Table_ID
	 * @param AD_Table_ID
	 */
	public void setTable_ID(int AD_Table_ID)
	{
		m_Table_ID = AD_Table_ID;
	}

	/**
	 * Get Record_ID
	 * @return Record_ID
	 */
	public int getRecord_ID()
	{
		return m_Record_ID;
	}
	
	/**
	 * Set Record_ID
	 * @param Record_ID
	 */
	public void setRecord_ID(int Record_ID)
	{
		m_Record_ID = Record_ID;
	}

	/**
	 * Get Record_UU
	 * @return Record_UU
	 */
	public String getRecord_UU()
	{
		return m_Record_UU;
	}
	
	/**
	 * Set Record_UU
	 * @param Record_UU
	 */
	public void setRecord_UU(String Record_UU)
	{
		m_Record_UU = Record_UU;
	}

	/**
	 * Get Process Title
	 * @return process title
	 */
	public String getTitle()
	{
		return m_Title;
	}
	
	/**
	 * Set process title
	 * @param Title
	 */
	public void setTitle (String Title)
	{
		m_Title = Title;
	}	//	setTitle

	/**
	 * Set AD_Client_ID
	 * @param AD_Client_ID int
	 */
	public void setAD_Client_ID (int AD_Client_ID)
	{
		m_AD_Client_ID = Integer.valueOf(AD_Client_ID);
	}
	
	/**
	 * Get AD_Client_ID
	 * @return AD_Client_ID
	 */
	public Integer getAD_Client_ID()
	{
		return m_AD_Client_ID;
	}

	/**
	 * Set AD_User_ID
	 * @param AD_User_ID
	 */
	public void setAD_User_ID (int AD_User_ID)
	{
		m_AD_User_ID = Integer.valueOf(AD_User_ID);
	}
	
	/**
	 * Get AD_User_ID
	 * @return AD_User_ID
	 */
	public Integer getAD_User_ID()
	{
		return m_AD_User_ID;
	}

	/**
	 * 	Get Process Info Parameter
	 *	@return Process Info Parameter Array
	 */
	public ProcessInfoParameter[] getParameter()
	{
		return m_parameter;
	}	//	getParameter

	/**
	 * 	Set Process Info Parameter
	 *	@param parameter Parameter Array
	 */
	public void setParameter (ProcessInfoParameter[] parameter)
	{
		m_parameter = parameter;
	}	//	setParameter

	/**
	 * Add log
	 * @param Log_ID
	 * @param P_ID
	 * @param P_Date
	 * @param P_Number
	 * @param P_Msg
	 * @param tableId
	 * @param recordId
	 */
	public void addLog (int Log_ID, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg,int tableId,int recordId)
	{
		addLog (new ProcessInfoLog (Log_ID, P_ID, P_Date, P_Number, P_Msg,tableId,recordId));
	}
	
	/**
	 * Add log
	 * @param P_ID
	 * @param P_Date
	 * @param P_Number
	 * @param P_Msg
	 * @param tableId
	 * @param recordId
	 */
	public void addLog (int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg ,int tableId,int recordId)
	{
		addLog (new ProcessInfoLog (P_ID, P_Date, P_Number, P_Msg,tableId, recordId));
	}
	
	/**
	 * 	Add Log
	 *	@param Log_ID Log ID
	 *	@param P_ID Process ID
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 */
	public void addLog (int Log_ID, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		addLog (new ProcessInfoLog (Log_ID, P_ID, P_Date, P_Number, P_Msg));
	}	//	addLog

	/**
	 * 	Add Log
	 *	@param P_ID Process ID
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 */
	public void addLog (int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		addLog (new ProcessInfoLog (P_ID, P_Date, P_Number, P_Msg));
	}	//	addLog

	/**
	 * 	Add Log
	 *	@param logEntry log entry
	 */
	public void addLog (ProcessInfoLog logEntry)
	{
		if (logEntry == null)
			return;
		if (m_logs == null)
			m_logs = new ArrayList<ProcessInfoLog>();
		m_logs.add (logEntry);
	}	//	addLog

	/**
	 * Get Logs
	 * @return ProcessInfoLog[]
	 */
	public ProcessInfoLog[] getLogs()
	{
		if (m_logs == null)
			return null;
		ProcessInfoLog[] logs = new ProcessInfoLog[m_logs.size()];
		m_logs.toArray (logs);
		return logs;
	}	//	getLogs

	/**
	 * 	Save Status Log to DB immediately
	 *	@param P_ID Process ID
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@return String AD_PInstance_Log_UU
	 */
	public String saveStatus (int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		return saveLog (new ProcessInfoLog (P_ID, P_Date, P_Number, P_Msg, 0, 0, X_AD_PInstance_Log.PINSTANCELOGTYPE_Status));
	}	//	saveLog
	
	/**
	 * 	Save Progress Log to DB immediately
	 *	@param P_ID Process ID
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@return String AD_PInstance_Log_UU
	 */
	public String saveProgress (int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		return saveLog (new ProcessInfoLog (P_ID, P_Date, P_Number, P_Msg, 0, 0, X_AD_PInstance_Log.PINSTANCELOGTYPE_Progress));
	}	//	saveLog

	/**
	 * 	Save Log to DB immediately
	 *	@param logEntry log entry
	 *	@return String AD_PInstance_Log_UU
	 */
	public String saveLog (ProcessInfoLog logEntry)
	{
		if (logEntry == null)
			return "";
		MPInstanceLog il = new MPInstanceLog(getAD_PInstance_ID(), 
				logEntry.getLog_ID(), 
				logEntry.getP_Date(),
				logEntry.getP_ID(), 
				logEntry.getP_Number(), 
				logEntry.getP_Msg(),
				logEntry.getAD_Table_ID(), 
				logEntry.getRecord_ID(),
				logEntry.getJsonData(),
				logEntry.getPInstanceLogType());
		il.saveEx();
		return il.getAD_PInstance_Log_UU();
	}	//	saveLog
	
	/**
	 * 	Update Progress Log to DB immediately
	 *	@param pInstanceLogUU AD_PInstance_Log_UU
	 *	@param P_ID Process ID
	 *	@param P_Date Process Date
	 *	@param P_Number Process Number
	 *	@param P_Msg Process Message
	 *	@return true if log is successfully updated
	 */
	public boolean updateProgress (String pInstanceLogUU, int P_ID, Timestamp P_Date, BigDecimal P_Number, String P_Msg)
	{
		return updateLog (new ProcessInfoLog (pInstanceLogUU, P_ID, P_Date, P_Number, P_Msg, X_AD_PInstance_Log.PINSTANCELOGTYPE_Progress));
	}	//	updateLog
	
	/**
	 * 	Update existing Log immediately
	 *	@param logEntry log entry
	 *	@return true if log is successfully updated
	 */
	public boolean updateLog (ProcessInfoLog logEntry)
	{
		if (logEntry == null)
			return false;
		MPInstanceLog il = new MPInstanceLog(logEntry.getAD_PInstance_Log_UU(),
				getAD_PInstance_ID(), 
				logEntry.getLog_ID(), 
				logEntry.getP_Date(),
				logEntry.getP_ID(), 
				logEntry.getP_Number(), 
				logEntry.getP_Msg(),
				logEntry.getAD_Table_ID(), 
				logEntry.getRecord_ID(),
				logEntry.getJsonData(),
				logEntry.getPInstanceLogType());
		return il.update();
	}	//	saveLog
	
	/**
	 * Get ids from process log
	 * @return ids from process log
	 */
	public int[] getIDs()
	{
		if (m_logs == null)
			return null;
		ArrayList<Integer> idsarray = new ArrayList<Integer>();
		for (int i = 0; i < m_logs.size(); i++) {
			if (m_logs.get(i).getP_ID() > 0)
				idsarray.add(m_logs.get(i).getP_ID());
		}
		int[] ids = new int[idsarray.size()];
		for (int i = 0; i < idsarray.size(); i++)
			ids[i] = idsarray.get(i);
		return ids;
	}	//	getIDs

	/**
	 * Get process logs
	 * @return process logs
	 */
	public ArrayList<ProcessInfoLog> getLogList()
	{
		return m_logs;
	}
	
	/**
	 * Set process logs
	 * @param logs
	 */
	public void setLogList (ArrayList<ProcessInfoLog> logs)
	{
		m_logs = logs;
	}
	
	/**
	 * Get transaction name for this process
	 * @return String
	 */
	public String getTransactionName()
	{
		return m_transactionName;
	}

	/**
	 * Get AD_Process_UU
	 * @return AD_Process_UU
	 */
	public String getAD_Process_UU()
	{
		return m_AD_Process_UU;
	}

	/**
	 * Set AD_Process_UU
	 * @param AD_Process_UU
	 */
	public void setAD_Process_UU(String AD_Process_UU)
	{
		m_AD_Process_UU = AD_Process_UU;
	}
	
	/**
	 * Set transaction name for this process
	 * @param trxName transaction name
	 */
	public void setTransactionName(String trxName)
	{
		m_transactionName = trxName;
	}
	
	/**
	 * Set print preview flag, only relevant if this is a reporting process
	 * @param b
	 */
	public void setPrintPreview(boolean b)
	{
		m_printPreview = b;
	}
	
	/**
	 * Is print preview instead of direct print ? Only relevant if this is a reporting process 
	 * @return true if is print preview
	 */
	public boolean isPrintPreview()
	{
		return m_printPreview;
	}
	
	/**
	 * Is this a reporting process ?
	 * @return true if this is reporting process
	 */
	public boolean isReportingProcess() 
	{
		return m_reportingProcess;
	}
	
	/**
	 * Set is this a reporting process
	 * @param f
	 */
	public void setReportingProcess(boolean f)
	{
		m_reportingProcess = f;
	}
	
	/**
	 * Set PDF report file generated
	 * @param f PDF File 
	 */
	public void setPDFReport(File f)
	{
		m_pdf_report = f;
	}	
	
	/**
	 * Get generated PDF report file
	 * @return PDF report file
	 */
	public File getPDFReport()
	{
		return m_pdf_report;
	}
	
	/**
	 * Is this a export or print process?
	 * @return
	 */
	public boolean isExport() 
	{
		return m_export;
	}
	
	/**
	 * Set Export flag
	 * @param export
	 */
	public void setExport(boolean export) 
	{
		this.m_export = export;
	}
	
	/**
	 * Get Export File Extension
	 * @return export file extension 
	 */
	public String getExportFileExtension()
	{
		return m_exportFileExtension;
	}
	
	/**
	 * Set Export File Extension
	 * @param exportFileExtension
	 */
	public void setExportFileExtension(String exportFileExtension)
	{
		m_exportFileExtension = exportFileExtension;
	}
	
	/**
	 * Get Export File
	 * @return
	 */
	public File getExportFile()
	{
		return m_exportFile;
	}
	
	/**
	 * Set Export File
	 * @param exportFile
	 */
	public void setExportFile(File exportFile)
	{
		m_exportFile = exportFile;
	}
	
	/**
	 * Get record ids
	 * @return record ids
	 */
	public List<Integer> getRecord_IDs()
	{
		return m_Record_IDs;
	}
	
	/**
	 * Set record ids
	 * @param Record_IDs
	 */
	public void setRecord_IDs(List<Integer> Record_IDs)
	{
		m_Record_IDs = Record_IDs;
	}

	/**
	 * Get record uuids
	 * @return record uuids
	 */
	public List<String> getRecord_UUs()
	{
		return m_Record_UUs;
	}

	/**
	 * Set record uuids
	 * @param Record_UUs
	 */
	public void setRecord_UUs(List<String> Record_UUs)
	{
		m_Record_UUs = Record_UUs;
	}

	/**
	 * Set row count
	 * @param rowCount
	 */
	public void setRowCount(int rowCount) {
		m_rowCount = rowCount;
	}

	/**
	 * Get row count
	 * @return row count
	 */
	public int getRowCount() {
		return m_rowCount;
	}

	/**
	 * Set PO
	 * @param po
	 */
	public void setPO(PO po) {
		m_po = po;
	}
	
	/**
	 * Get PO
	 * @return PO
	 */
	public PO getPO() {
		return m_po;
	}

	/** FileName to be used */
	private String m_PDFfileName;

	/**
	 * Get PDF file name
	 * @return PDF file name
	 */
	public String getPDFFileName() {
		return m_PDFfileName;
	}

	/**
	 * Set PDF file name
	 * @param fileName
	 */
	public void setPDFFileName(String fileName) {
		this.m_PDFfileName = fileName;
	}
	
	/**
	 * Validates to inform a user running again a process that is already in execution.
	 * @return true if the same process is already running
	 */
	public boolean isProcessRunning(MPInstancePara[] params) {
		MProcess process = MProcess.get(Env.getCtx(), getAD_Process_ID());
		
		String multipleExecutions = process.getAllowMultipleExecution();
		if (multipleExecutions == null || multipleExecutions.isEmpty())
			return false;
		
		Timestamp lastRebootDate = getLastServerRebootDate();
		if (lastRebootDate == null)
			return false;
		
		StringBuilder whereClause = new StringBuilder(
				"AD_Process_ID=? AND IsProcessing='Y' AND Record_ID = ? AND Created > ?");
		List<Object> queryParams = new ArrayList<>(Arrays.asList(getAD_Process_ID(), getRecord_ID(), lastRebootDate));

		if (   MProcess.ALLOWMULTIPLEEXECUTION_NotFromSameUser.equals(multipleExecutions)
			|| MProcess.ALLOWMULTIPLEEXECUTION_NotFromSameUserAndParameters.equals(multipleExecutions)) {
			whereClause.append(" AND AD_User_ID = ? ");
			queryParams.add(getAD_User_ID());
		}

		List<MPInstance> processInstanceList = new Query(Env.getCtx(), MPInstance.Table_Name, whereClause.toString(), null)
				.setParameters(queryParams)
				.setClient_ID()
				.setOnlyActiveRecords(true).list();

		if (processInstanceList == null || processInstanceList.isEmpty())
			return false;

		// Do not allow concurrent executions
		if (   MProcess.ALLOWMULTIPLEEXECUTION_NotFromSameUser.equals(multipleExecutions)
			|| MProcess.ALLOWMULTIPLEEXECUTION_NotFromAnyUser.equals(multipleExecutions))
			return true;

		// Do not allow concurrent executions with the same params
		if (   MProcess.ALLOWMULTIPLEEXECUTION_NotFromAnyUserAndSameParameters.equals(multipleExecutions)
			|| MProcess.ALLOWMULTIPLEEXECUTION_NotFromSameUserAndParameters.equals(multipleExecutions)) {
			for (MPInstance instance : processInstanceList) {
				if (instance.equalParameters(params))
					return true;
			}
		}
		
		return false;
	}
	
	/**
	 * Get last server reboot timestamp from server session
	 * @return last server reboot timestamp or null 
	 */
	private Timestamp getLastServerRebootDate() {
		MSession currentSession = MSession.get(Env.getCtx());
		if (currentSession == null)
			return null;
		
		MSession lastServerSession = new Query(Env.getCtx(), MSession.Table_Name, " serverName=? AND websession=?", null)
				.setParameters(currentSession.getServerName(), "Server")
				.setOrderBy("AD_Session_ID desc")
				.setOnlyActiveRecords(true)
				.first();

		if (lastServerSession == null) {
			logger.severe("There is no 'Server' record in AD_Session, this can indicate that the server plugin didn't start correctly.  Please verify, this can affect scheduled processes, idempiereMonitor, etc.");
			return null;
		}
		return lastServerSession.getCreated();
	}

	private IProcessUI processUI;

	/**
	 * Set UI interface for process
	 * @param processUI
	 */
	public void setProcessUI(IProcessUI processUI) {
		this.processUI = processUI;
	}
	
	/**
	 * Get UI interface for process
	 * @return UI interface for process or null
	 */
	public IProcessUI getProcessUI() {
		return processUI;
	}

	/**
	 * Determines, if current tab content should be replaced, or a new tab should be opened (for report)
	 * @return true, if current tab content should be replaced
	 */
	public boolean isReplaceTabContent() {
		return m_IsReplaceTabContent;
	}

	/**
	 * Sets, if current tab content should be replaced, or a new tab should be opened (from AD_SysConfig)
	 */
	public void setReplaceTabContent() {
		this.m_IsReplaceTabContent = !(MSysConfig.getBooleanValue(MSysConfig.ZK_REPORT_TABLE_OPEN_IN_NEW_TAB, false, Env.getAD_Client_ID(Env.getCtx())));
	}

	/**
	 * Get AD_Scheduler_ID
	 * @return AD_Scheduler_ID or 0 if not running from scheduler
	 */
	public int getAD_Scheduler_ID() {
		return m_AD_Scheduler_ID;
	}

	/**
	 * Set AD_Scheduler_ID
	 * @param AD_Scheduler_ID
	 */
	public void setAD_Scheduler_ID(int AD_Scheduler_ID) {
		this.m_AD_Scheduler_ID = AD_Scheduler_ID;
	}
	
	/**
	 * @return true if scheduler should notify scheduler recipients with process execution result
	 */
	public boolean isNotifyRecipients() {
		return isNotifyRecipients;
	}

	/**
	 * @param isNotifyRecipients if true, scheduler should notify scheduler recipients with process execution result
	 */
	public void setNotifyRecipients(boolean isNotifyRecipients) {
		this.isNotifyRecipients = isNotifyRecipients;
	}
	
	/**
	 * Get internal report object.<br/>
	 * For Jasper Report, to get JasperPrint, set export to true and ExportFileExtension to "JasperPrint".
	 * @return internal report object (for e.g JasperPrint)
	 */
	public Serializable getInternalReportObject() {
		return internalReportObject;
	}
	
	/**
	 * Set internal report object (for e.g JasperPrint)
	 * @param reportObject
	 */
	public void setInternalReportObject(Serializable reportObject) {
		internalReportObject = reportObject;
	}
}   //  ProcessInfo
