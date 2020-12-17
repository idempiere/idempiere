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
package org.compiere.apps;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.adempiere.util.IProcessUI;
import org.adempiere.util.ProcessUtil;
import org.compiere.model.MPInstance;
import org.compiere.model.MRule;
import org.compiere.print.ReportCtl;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.wf.MWFProcess;

/**
 *	Process Interface Controller.
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: ProcessCtl.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 *  @author Low Heng Sin
 *  - Added support for having description and parameter in one dialog
 *  - Added support to run db process remotely on server
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 				<li>BF [ 1757523 ] Server Processes are using Server's context
 * 				<li>FR [ 1807922 ] Pocess threads should have a better name
 * 				<li>BF [ 1960523 ] Server Process functionality not working
 */
public abstract class AbstractProcessCtl implements Runnable
{
	/**************************************************************************
	 *  Constructor
	 *  @param parent Container & ASyncProcess
	 *  @param pi Process info
	 *  @param trx Transaction
	 *  Created in process(), VInvoiceGen.generateInvoices
	 */
	public AbstractProcessCtl (IProcessUI aProcessUI, int WindowNo, ProcessInfo pi, Trx trx)
	{
		windowno = WindowNo;
		m_processUI = aProcessUI;
		m_pi = pi;
		m_trx = trx;	//	handeled correctly
	}   //  ProcessCtl

	/** Windowno */
	private int windowno;
	/** Parenr */
	private IProcessUI m_processUI;
	/** Process Info */
	private ProcessInfo m_pi;
	private Trx				m_trx;
	
	/**	Static Logger	*/
	private static final CLogger	log	= CLogger.getCLogger (AbstractProcessCtl.class);
	
	/**
	 * Run this process in a new thread
	 */
	public void start()
	{
		Thread thread = new Thread(this);
		// Set thread name - teo_sarca FR [ 1807922 ]
		if (m_pi != null)
			thread.setName(m_pi.getTitle()+"-"+m_pi.getAD_PInstance_ID());
		thread.start();
	}
	
	/**
	 *	Execute Process Instance and Lock UI.
	 *  Calls lockUI and unlockUI if parent is a ASyncProcess
	 *  <pre>
	 *		- Get Process Information
	 *      - Call Class
	 *		- Submit SQL Procedure
	 *		- Run SQL Procedure
	 *	</pre>
	 */
	public void run ()
	{
		if (log.isLoggable(Level.FINE)) log.fine("AD_PInstance_ID=" + m_pi.getAD_PInstance_ID()
			+ ", Record_ID=" + m_pi.getRecord_ID());

		//  Lock
		lock();
	//	try {System.out.println(">> sleeping ..");sleep(20000);System.out.println(".. sleeping <<");} catch (Exception e) {}

		//	Get Process Information: Name, Procedure Name, ClassName, IsReport, IsDirectPrint
		String 	ProcedureName = "";
		String  JasperReport = "";
		int     AD_ReportView_ID = 0;
		int		AD_Workflow_ID = 0;
		boolean IsReport = false;
		boolean	IsDirectPrint = false;
		boolean isPrintPreview = m_pi.isPrintPreview();

		//
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
			pstmt.setInt(1, m_pi.getAD_PInstance_ID());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				m_pi.setTitle (rs.getString(1));
				updateProgressWindowTitle(m_pi.getTitle());
				ProcedureName = rs.getString(2);
				m_pi.setClassName (rs.getString(3));
				m_pi.setAD_Process_ID (rs.getInt(4));
				m_pi.setAD_Process_UU(rs.getString(11));
				//	Report
				if ("Y".equals(rs.getString(5)))
				{
					IsReport = true;
					if ("Y".equals(rs.getString(6)) && !Ini.isPropertyBool(Ini.P_PRINTPREVIEW)
							&& !isPrintPreview )
						IsDirectPrint = true;
				}
				AD_ReportView_ID = rs.getInt(7);
				AD_Workflow_ID = rs.getInt(8);
				//
				int estimate = rs.getInt(9);
				if (estimate != 0)
				{
					m_pi.setEstSeconds (estimate + 1);     //  admin overhead
					updateProgressWindowTimerEstimate(m_pi.getEstSeconds());
				}
				JasperReport = rs.getString(10);
			}
			else
				log.log(Level.SEVERE, "No AD_PInstance_ID=" + m_pi.getAD_PInstance_ID());
		}
		catch (Throwable e)
		{
			m_pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessNoProcedure") + " " + e.getLocalizedMessage(), true);
			unlock();
			log.log(Level.SEVERE, "run", e);
			return;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//  No PL/SQL Procedure
		if (ProcedureName == null)
			ProcedureName = "";

		
		/**********************************************************************
		 *	Workflow
		 */
		if (AD_Workflow_ID > 0)	
		{
			startWorkflow (AD_Workflow_ID);
			MPInstance pinstance = new MPInstance(Env.getCtx(), m_pi.getAD_PInstance_ID(), null);
			String errmsg = m_pi.getSummary();
			pinstance.setResult(!m_pi.isError());
			pinstance.setErrorMsg(errmsg);
			pinstance.saveEx();
			unlock();
			return;
		}

		// Clear Jasper Report class if default - to be executed later
		boolean isJasper = false;
		if (JasperReport != null && JasperReport.trim().length() > 0) {
			isJasper = true;
			if (ProcessUtil.JASPER_STARTER_CLASS.equals(m_pi.getClassName())) {
				m_pi.setClassName(null);
			}
		}
		
		/**********************************************************************
		 *	Start Optional Class
		 */
		if (m_pi.getClassName() != null)
		{
			if (isJasper)
			{
				m_pi.setReportingProcess(true);
			}
			
			//	Run Class
			if (!startProcess())
			{
				unlock();
				return;
			}

			//  No Optional SQL procedure ... done
			if (!IsReport && ProcedureName.length() == 0)
			{
				unlock ();
				return;
			}
			//  No Optional Report ... done
			if (IsReport && AD_ReportView_ID == 0 && ! isJasper)
			{
				unlock ();
				return;
			}
		}

		/**********************************************************************
		 *	Report submission
		 */
		//	Optional Pre-Report Process
		if (IsReport && ProcedureName.length() > 0)
		{
			m_pi.setReportingProcess(true);
			if (!startDBProcess(ProcedureName))
			{
				unlock();
				return;
			}
		}	//	Pre-Report

		if (isJasper)
		{
			m_pi.setReportingProcess(true);
			m_pi.setClassName(ProcessUtil.JASPER_STARTER_CLASS);
			startProcess();
			MPInstance pinstance = new MPInstance(Env.getCtx(), m_pi.getAD_PInstance_ID(), null);
			if (m_pi.getReportType() != null)
				pinstance.setReportType(m_pi.getReportType());
			String errmsg = pinstance.getErrorMsg();
			if (Util.isEmpty(errmsg, true))
				errmsg = "Rows=" + String.valueOf(m_pi.getRowCount());
			else
				errmsg += " Rows=" + m_pi.getRowCount();
			pinstance.setErrorMsg(errmsg);
			pinstance.saveEx();
			unlock();
			return;
		}
		
		if (IsReport)
		{
			m_pi.setReportingProcess(true);
			//	Start Report	-----------------------------------------------
			boolean ok = ReportCtl.start(m_processUI, windowno, m_pi, IsDirectPrint);
			m_pi.setSummary(Msg.getCleanMsg(Env.getCtx(), "Report"), !ok);
			MPInstance pinstance = new MPInstance(Env.getCtx(), m_pi.getAD_PInstance_ID(), null);
			String errmsg = pinstance.getErrorMsg();
			if (Util.isEmpty(errmsg, true))
				errmsg = "Rows=" + String.valueOf(m_pi.getRowCount());
			else
				errmsg += " Rows=" + m_pi.getRowCount();
			pinstance.setErrorMsg(errmsg);
			pinstance.saveEx();
			unlock ();
		}
		/**********************************************************************
		 * 	Process submission
		 */
		else
		{
			if (!startDBProcess (ProcedureName))
			{
				unlock();
				return;
			}
			//	Success - getResult
			ProcessInfoUtil.setSummaryFromDB(m_pi);
			unlock();
		}			//	*** Process submission ***
	//	if (log.isLoggable(Level.FINE)) log.fine(Log.l3_Util, "ProcessCtl.run - done");
	}   //  run

	protected abstract void updateProgressWindowTimerEstimate(int estSeconds);

	protected abstract void updateProgressWindowTitle(String title);

	/**
	 *  Lock UI & show Waiting
	 */
	protected abstract void lock ();

	/**
	 *  Unlock UI & dispose Waiting.
	 * 	Called from run()
	 */
	protected abstract void unlock ();
	
	protected int getWindowNo() 
	{
		return windowno;
	}
	
	protected ProcessInfo getProcessInfo()
	{
		return m_pi;
	}
	
	protected IProcessUI getProcessMonitor()
	{
		return m_processUI;
	}
	
	protected IProcessUI getParent()
	{
		return getProcessMonitor();
	}
	
	@Deprecated
	protected boolean isServerProcess()
	{
		return false;
	}
	
	/**************************************************************************
	 *  Start Workflow.
	 *
	 *  @param AD_Workflow_ID workflow
	 *  @return     true if started
	 */
	private boolean startWorkflow (int AD_Workflow_ID)
	{
		if (log.isLoggable(Level.FINE)) log.fine(AD_Workflow_ID + " - " + m_pi);
		boolean started = false;
		if (m_trx != null)
			m_pi.setTransactionName(m_trx.getTrxName());
		MWFProcess wfProcess = ProcessUtil.startWorkFlow(Env.getCtx(), m_pi, AD_Workflow_ID);
		started = wfProcess != null;
		return started;
	}   //  startWorkflow

	/**************************************************************************
	 *  Start Java Process Class.
	 *      instanciate the class implementing the interface ProcessCall.
	 *  The class can be a Server/Client class (when in Package
	 *  org adempiere.process or org.compiere.model) or a client only class
	 *  (e.g. in org.compiere.report)
	 *
	 *  @return     true if success
	 */
	private boolean startProcess ()
	{
		if (log.isLoggable(Level.FINE)) log.fine(m_pi.toString());
		if (m_pi.getClassName().toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {
			m_pi.setProcessUI(m_processUI);
			return ProcessUtil.startScriptProcess(Env.getCtx(), m_pi, m_trx);
		} else {
			return ProcessUtil.startJavaProcess(Env.getCtx(), m_pi, m_trx, true, m_processUI);
		}
	}   //  startProcess


	/**************************************************************************
	 *  Start Database Process
	 *  @param ProcedureName PL/SQL procedure name
	 *  @return true if success
	 */
	private boolean startDBProcess (String ProcedureName)
	{
		//  execute on this thread/connection
		if (log.isLoggable(Level.FINE)) log.fine(ProcedureName + "(" + m_pi.getAD_PInstance_ID() + ")");
		return ProcessUtil.startDatabaseProcedure(m_pi, ProcedureName, m_trx);
	}   //  startDBProcess

	
}	//	ProcessCtl
