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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.event.EventManager;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.idempiere.distributed.IMessageService;
import org.idempiere.distributed.ITopic;
import org.osgi.service.event.Event;

/**
 *  Process Instance Model
 *
 *  @author Jorg Janke
 *  @version $Id: MPInstance.java,v 1.3 2006/07/30 00:58:36 jjanke Exp $
 * 
 * @author Teo Sarca, www.arhipac.ro
 * 		<li>FR [ 2818478 ] Introduce MPInstance.createParameter helper method
 * 			https://sourceforge.net/p/adempiere/feature-requests/756/
 */
public class MPInstance extends X_AD_PInstance
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3756494717528301224L;

	public static final String ON_RUNNING_JOB_CHANGED_TOPIC = "onRunningJobChanged";

	private static CLogger		s_log = CLogger.getCLogger (MPInstance.class);

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_PInstance_ID instance or 0
	 *	@param ignored no transaction support
	 */
	public MPInstance (Properties ctx, int AD_PInstance_ID, String ignored)
	{
		super (ctx, AD_PInstance_ID, null);
		//	New Process
		if (AD_PInstance_ID == 0)
		{
			setIsProcessing (false);
		}
	}	//	MPInstance

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param ignored no transaction support
	 */
	public MPInstance (Properties ctx, ResultSet rs, String ignored)
	{
		super(ctx, rs, null);
	}	//	MPInstance

	/**
	 * 	Create Process Instance from Process and create parameters
	 *	@param process process
	 *	@param Record_ID Record
	 */
	public MPInstance (MProcess process, int Record_ID)
	{
		this (process.getCtx(), 0, null);
		setAD_Process_ID (process.getAD_Process_ID());
		setRecord_ID (Record_ID);
		setAD_User_ID(Env.getAD_User_ID(process.getCtx()));
		if (!save())		//	need to save for parameters
			throw new IllegalArgumentException ("Cannot Save");
		//	Set Parameter Base Info
		MProcessPara[] para = process.getParameters();
		for (int i = 0; i < para.length; i++)
		{
			MPInstancePara pip = new MPInstancePara (this, para[i].getSeqNo());
			pip.setParameterName(para[i].getColumnName());
			pip.setInfo(para[i].getName());
			pip.saveEx();
		}
	}	//	MPInstance

	/**
	 * 	New Constructor
	 *	@param ctx context
	 *	@param AD_Process_ID Process ID
	 *	@param Record_ID record
	 */
	public MPInstance (Properties ctx, int AD_Process_ID, int Record_ID)
	{
		this(ctx, 0, null);
		setAD_Process_ID (AD_Process_ID);
		setRecord_ID (Record_ID);
		setAD_User_ID(Env.getAD_User_ID(ctx));
		setIsProcessing (false);
	}	//	MPInstance
	

	/**	Parameters						*/
	private MPInstancePara[]		m_parameters = null;

	/**
	 * 	Get Parameters
	 *	@return parameter array
	 */
	public MPInstancePara[] getParameters()
	{
		if (m_parameters != null)
			return m_parameters;
		//FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
		final String whereClause = "AD_PInstance_ID=?";
		List <MPInstancePara> list = new Query(getCtx(), I_AD_PInstance_Para.Table_Name, whereClause, null) // @TODO: Review implications of using transaction 
		.setParameters(getAD_PInstance_ID())
		.setOrderBy("SeqNo, ParameterName")
		.list();

		//
		m_parameters = new MPInstancePara[list.size()];
		list.toArray(m_parameters);
		return m_parameters;
	}	//	getParameters
	
	/**
	 * 	Get Process Parameters
	 *	@return processParameters array
	 */
	public MProcessPara[] getProcessParameters()
	{
		final String whereClause = "AD_Process_ID=?";
		List <MProcessPara> list = new Query(getCtx(), MProcessPara.Table_Name, whereClause, get_TrxName())
		.setParameters(getAD_Process_ID())
		.setOnlyActiveRecords(true)
		.setOrderBy("SeqNo")
		.list();

		//
		MProcessPara[] processParameters = new MProcessPara[list.size()];
		list.toArray(processParameters);
		return processParameters;
	}	//	getParameters
	
	/**
	 * Validate that a set of process instance parameters are equal or not
	 * to the current instance parameter
	 * @param params array of parameters to compare
	 * @return true if the process instance parameters are the same as the  array ones
	 */
	public boolean equalParameters(MPInstancePara[] params) {		
		
		//No parameters
		if ((getParameters() == null || getParameters().length == 0) && (params == null || params.length == 0))
				return true;
		
		//Different number of parameters
		if (getParameters().length != params.length)
			return false;
		
		int comparedParams = 0;
		for (MPInstancePara instanceParameter : getParameters()) {
			for (MPInstancePara para : params) {
				if (instanceParameter.getParameterName().equals(para.getParameterName())) {
					comparedParams++;
					 if (!instanceParameter.equalParameter(para)) {
						 return false;
					 }
					 break;
				}
			}
		}
		
		return comparedParams == getParameters().length; //all the compared parameters have the same name and value 
	}

	/**	Log Entries					*/
	private ArrayList<MPInstanceLog>	m_log	= new ArrayList<MPInstanceLog>();

	/**
	 *	Get Logs
	 *	@return array of logs
	 */
	public MPInstanceLog[] getLog()
	{
		//	load it from DB
		m_log.clear();
		String sql = "SELECT * FROM AD_PInstance_Log WHERE AD_PInstance_ID=? ORDER BY Log_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, getAD_PInstance_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				m_log.add(new MPInstanceLog(rs));
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		MPInstanceLog[] retValue = new MPInstanceLog[m_log.size()];
		m_log.toArray(retValue);
		return retValue;
	}	//	getLog

	/**
	 *	@param P_Date date
	 *	@param P_ID id
	 *	@param P_Number number
	 *	@param P_Msg msg
	 */
	public MPInstanceLog addLog (Timestamp P_Date, int P_ID, BigDecimal P_Number, String P_Msg)
	{
		return addLog(P_Date, P_ID, P_Number, P_Msg, 0, 0);
	}	//	addLog

	/**
	 * @param P_Date date
	 * @param P_ID id
	 * @param P_Number number
	 * @param P_Msg msg
	 * @param AD_Table_ID tableID
	 * @param Record_ID recordID
	 * @return
	 */
	public MPInstanceLog addLog (Timestamp P_Date, int P_ID, BigDecimal P_Number, String P_Msg, int AD_Table_ID, int Record_ID)
	{
		MPInstanceLog logEntry = new MPInstanceLog (getAD_PInstance_ID(), m_log.size()+1,
			P_Date, P_ID, P_Number, P_Msg, AD_Table_ID, Record_ID);
		m_log.add(logEntry);
		//	save it to DB ?
		return logEntry;
	}	//	addLog

	/**
	 * 	Set AD_Process_ID.
	 * 	Check Role if process can be performed
	 *	@param AD_Process_ID process
	 */
	public void setAD_Process_ID (int AD_Process_ID)
	{
		int AD_Role_ID = Env.getAD_Role_ID(getCtx());
		if (AD_Role_ID != 0)
		{
			MRole role = MRole.get(getCtx(), AD_Role_ID);
			Boolean access = role.getProcessAccess(AD_Process_ID);
			if (access == null || !access.booleanValue()) {
				MProcess proc = MProcess.get(getCtx(), AD_Process_ID);
				StringBuilder procMsg = new StringBuilder("[");
				if (! Language.isBaseLanguage (Env.getAD_Language(getCtx()))) {
					procMsg.append(proc.get_Translation("Name")).append(" / ");
				}
				procMsg.append(proc.getName()).append("]");
				throw new IllegalStateException(Msg.getMsg(getCtx(), "CannotAccessProcess", new Object[] {procMsg.toString(), role.getName()}));
			}
		}
		super.setAD_Process_ID (AD_Process_ID);
	}	//	setAD_Process_ID

	/**
	 * 	Set Record ID.
	 * 	direct internal record ID
	 * 	@param Record_ID record
	 **/
	public void setRecord_ID (int Record_ID)
	{
		if (Record_ID < 0)
		{
			if (log.isLoggable(Level.INFO)) log.info("Set to 0 from " + Record_ID);
			Record_ID = 0;
		}
		set_ValueNoCheck ("Record_ID", Integer.valueOf(Record_ID));
	}	//	setRecord_ID

	/**
	 * 	String Representation
	 *	@see java.lang.Object#toString()
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MPInstance[")
			.append (get_ID())
			.append(",OK=").append(isOK());
		String msg = getErrorMsg();
		if (msg != null && msg.length() > 0)
			sb.append(msg);
		sb.append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Dump Log
	 */
	public void log()
	{
		if (log.isLoggable(Level.INFO)) {
			log.info(toString());
			MPInstanceLog[] pil = getLog();
			for (int i = 0; i < pil.length; i++)
				log.info(i + "=" + pil[i]);
		}
	}	//	log

	/** Result OK = 1			*/
	public static final int		RESULT_OK = 1;
	/** Result FALSE = 0		*/
	public static final int		RESULT_ERROR = 0;

	/**
	 * 	Is it OK
	 *	@return Result == OK
	 */
	public boolean isOK()
	{
		return getResult() == RESULT_OK;
	}	//	isOK
	
	/**
	 * 	Set Result
	 *	@param ok 
	 */
	public void setResult (boolean ok)
	{
		super.setResult (ok ? RESULT_OK : RESULT_ERROR);
	}	//	setResult
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		//	Update Statistics
		if (!newRecord 
			&& !isProcessing()
			&& is_ValueChanged("IsProcessing"))
		{
			long ms = System.currentTimeMillis() - getCreated().getTime();
			int seconds = (int)(ms / 1000);
			if (seconds < 1)
				seconds = 1;
			String updsql = "UPDATE AD_Process SET Statistic_Count=Statistic_Count+1, Statistic_Seconds=Statistic_Seconds+? WHERE AD_Process_ID=?";
			int no = DB.executeUpdate(updsql, new Object[] {seconds, getAD_Process_ID()}, true, null); // out of trx
			if (no == 1) {
				if (log.isLoggable(Level.FINE)) log.fine("afterSave - Process Statistics updated Sec=" + seconds);
			} else {
				log.warning("afterSave - Process Statistics not updated");
			}
		}
		return success;
	}	//	afterSave
	
	/**
	 * Create Process Instance Parameter and save to database
	 * @param seqNo parameter sequence#
	 * @param parameterName parameter name
	 * @param value parameter value
	 * @return
	 */
	public MPInstancePara createParameter(int seqNo, String parameterName, Object value)
	{
		MPInstancePara ip = new MPInstancePara(this, seqNo);
		if (value == null)
		{
			ip.setParameter(parameterName, (String)null);
		}
		else if (value instanceof BigDecimal)
		{
			ip.setParameter(parameterName, (BigDecimal)value);
		}
		else if (value instanceof Integer)
		{
			ip.setParameter(parameterName, (Integer)value);
		}
		else if (value instanceof Timestamp)
		{
			ip.setParameter(parameterName, (Timestamp)value);
		}
		else if (value instanceof Boolean)
		{
			ip.setParameter(parameterName, (Boolean)value);
		}
		else
		{
			ip.setParameter(parameterName, value.toString());
		}
		//
		ip.saveEx();
		return ip;
	}
	
	
	@Override
	public I_AD_Process getAD_Process() throws RuntimeException {
		return MProcess.get(getAD_Process_ID());
	}

	public static void publishChangedEvent(int AD_User_ID) {
		IMessageService service = Core.getMessageService();
		if (service != null) {
			ITopic<Integer> topic = service.getTopic(ON_RUNNING_JOB_CHANGED_TOPIC);
			topic.publish(AD_User_ID);
		} else {
			postOnChangedEvent(AD_User_ID);
		}
	}

	public static void postOnChangedEvent(int AD_User_ID) {
		Map<String, Integer> properties = new HashMap<String, Integer>();
		properties.put("AD_User_ID", AD_User_ID);
		Event event = new Event(ON_RUNNING_JOB_CHANGED_TOPIC, properties);
		EventManager.getInstance().postEvent(event);
	}
	
	public static List<MPInstance> get(Properties ctx, int AD_Process_ID, int AD_User_ID) {
		List<MPInstance> list = new ArrayList<MPInstance>();
		List<String> paramsStrAdded = new ArrayList<String>();

		List<MPInstance> namedInstances = new Query(ctx, Table_Name, "AD_Process_ID=? AND AD_User_ID=? AND Name IS NOT NULL", null)
			.setClient_ID()
			.setOnlyActiveRecords(true)
			.setParameters(AD_Process_ID, AD_User_ID)
			.setOrderBy("Name")
			.list();
		for (MPInstance namedInstance : namedInstances) {
			list.add(namedInstance);
			paramsStrAdded.add(namedInstance.getParamsStr());
		}

		// unnamed instances
		int lastRunCount = MSysConfig.getIntValue(MSysConfig.LASTRUN_RECORD_COUNT, 5, Env.getAD_Client_ID(ctx));
		if (lastRunCount > 0) {
			int maxLoopCount = 10 * lastRunCount;
			// using JDBC instead of Query for performance reasons, AD_PInstance can be huge
			String sql = "SELECT * FROM AD_PInstance "
					+ " WHERE AD_Process_ID=? AND AD_User_ID=? AND IsActive='Y' AND AD_Client_ID=? AND Name IS NULL" 
					+ " ORDER BY Created DESC";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int runCount = 0;
			int loopCount = 0;
			try {
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setFetchSize(lastRunCount);
				pstmt.setInt(1, AD_Process_ID);
				pstmt.setInt(2, AD_User_ID);
				pstmt.setInt(3, Env.getAD_Client_ID(ctx));
				rs = pstmt.executeQuery();
				while (rs.next()) {
					loopCount++;
					MPInstance unnamedInstance = new MPInstance(ctx, rs, null);
					String paramsStr = unnamedInstance.getParamsStr();
					if (! paramsStrAdded.contains(paramsStr)) {
						unnamedInstance.setName(Msg.getMsg(ctx, "LastRun") + " " + unnamedInstance.getCreated());
						list.add(unnamedInstance);
						paramsStrAdded.add(paramsStr);
						runCount++;
						if (runCount == lastRunCount)
							break;
					}
					if (loopCount == maxLoopCount)
						break;
				}
			} catch (Exception e)
			{
				s_log.log(Level.SEVERE, "Error while Fetching last run records", e);
			} finally {
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}

		return list;
	}

	private String getParamsStr() {
		StringBuilder cksum = new StringBuilder();
		for (MPInstancePara ip : getParameters()) {
			cksum.append("(")
			.append(ip.getParameterName()).append("|")
			.append(ip.getP_String()).append("|")
			.append(ip.getP_String_To()).append("|")
			.append(ip.getP_Number()).append("|")
			.append(ip.getP_Number_To()).append("|")
			.append(ip.getP_Date()).append("|")
			.append(ip.getP_Date_To()).append("|")
			.append(ip.getInfo()).append("|")
			.append(ip.getInfo_To()).append("|")
			.append(")");
		}
		if (getAD_Process().isReport()){
			cksum.append(this.getAD_Language_ID()).append("|")
			.append(this.getAD_PrintFormat_ID())
			.append(this.getAD_Language_ID())
			.append(this.getReportType())
			.append(this.isSummary());
		}
		return cksum.toString();
	}

	/**
	 * 
	 * @param AD_PInstance_ID
	 * @return {@link PInstanceInfo}
	 * @throws SQLException
	 */
	public static PInstanceInfo getPInstanceInfo(int AD_PInstance_ID) throws SQLException {
		PInstanceInfo info = null;
		
		//	Get Process Information: Name, Procedure Name, ClassName, IsReport, IsDirectPrint
		String sql = "SELECT p.Name, p.ProcedureName,p.ClassName, p.AD_Process_ID,"		//	1..4
			+ " p.isReport,p.IsDirectPrint,p.AD_ReportView_ID,p.AD_Workflow_ID,"		//	5..8
			+ " CASE WHEN COALESCE(p.Statistic_Count,0)=0 THEN 0 ELSE p.Statistic_Seconds/p.Statistic_Count END," 	//	9
			+ " p.JasperReport, p.AD_Process_UU "  	//	10..11
			+ "FROM AD_Process p"
			+ " INNER JOIN AD_PInstance i ON (p.AD_Process_ID=i.AD_Process_ID) "
			+ "WHERE p.IsActive='Y'"
			+ " AND i.AD_PInstance_ID=?";
		if (!Env.isBaseLanguage(Env.getCtx(), "AD_Process"))
			sql = "SELECT t.Name, p.ProcedureName,p.ClassName, p.AD_Process_ID,"		//	1..4
				+ " p.isReport, p.IsDirectPrint,p.AD_ReportView_ID,p.AD_Workflow_ID,"	//	5..8
				+ " CASE WHEN COALESCE(p.Statistic_Count,0)=0 THEN 0 ELSE p.Statistic_Seconds/p.Statistic_Count END," 	//	9
				+ " p.JasperReport, p.AD_Process_UU " 	//	10..11
				+ "FROM AD_Process p"
				+ " INNER JOIN AD_PInstance i ON (p.AD_Process_ID=i.AD_Process_ID) "
				+ " INNER JOIN AD_Process_Trl t ON (p.AD_Process_ID=t.AD_Process_ID"
					+ " AND t.AD_Language='" + Env.getAD_Language(Env.getCtx()) + "') "
				+ "WHERE p.IsActive='Y'"
				+ " AND i.AD_PInstance_ID=?";
		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{			
			pstmt = DB.prepareStatement(sql, 
				ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY, null);
			pstmt.setInt(1, AD_PInstance_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				info = new PInstanceInfo();
				info.name = rs.getString(1);
				info.procedureName = rs.getString(2);
				info.className = rs.getString(3);
				info.AD_Process_ID = rs.getInt(4);
				info.AD_Process_UU = rs.getString(11);
				//	Report
				if ("Y".equals(rs.getString(5)))
				{
					info.isReport = true;
				}
				if ("Y".equals(rs.getString(6)))
				{
					info.isDirectPrint = true;
				}
				info.AD_ReportView_ID = rs.getInt(7);
				info.AD_Workflow_ID = rs.getInt(8);
				//
				info.estimate = rs.getInt(9);
				info.jasperReport = rs.getString(10);
			}
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		
		return info;
	}
	
	/**
	 * Record class with fields from AD_PInstance+AD_Process
	 * @author hengsin
	 *
	 */
	public static class PInstanceInfo {
		public int AD_Process_ID;
		public String AD_Process_UU;
		public int AD_ReportView_ID = 0;
		public int	AD_Workflow_ID = 0;	
		//translated name for current env context
		public String name;
		public String className;		
		public String procedureName = "";
		public String jasperReport = "";
		public boolean isReport = false;
		public boolean isDirectPrint = false;
		public int estimate;
	}
}	//	MPInstance