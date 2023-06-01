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

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.util.ServerContext;
import org.compiere.model.AdempiereProcessor;
import org.compiere.model.AdempiereProcessor2;
import org.compiere.model.AdempiereProcessorLog;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MOrgInfo;
import org.compiere.model.MRole;
import org.compiere.model.MSchedule;
import org.compiere.model.MSystem;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;

/**
 *	Adempiere Server Base
 *
 *  @author Jorg Janke
 *  @version $Id: AdempiereServer.java,v 1.3 2006/10/09 00:23:26 jjanke Exp $
 */
public abstract class AdempiereServer implements Runnable 
{

	/**************************************************************************
	 * 	Server Base Class
	 * 	@param model model
	 *	@param initialNap delay time running in sec
	 */
	protected AdempiereServer (AdempiereProcessor model, int initialNap)
	{
		p_model = model;		
		if (p_system == null)
			p_system = MSystem.get(model.getCtx());
		p_client = MClient.get(model.getCtx(), model.getAD_Client_ID());
		m_initialNap = initialNap;
	
		Timestamp dateNextRun = getDateNextRun(true);
		if (dateNextRun != null)
			m_nextWork = dateNextRun.getTime();
		
		long now = System.currentTimeMillis();
		if (m_nextWork > now) 
		{
			m_sleepMS = m_nextWork - now;
		}
	}	//	ServerBase

	/**	The Processor Model						*/
	protected	volatile AdempiereProcessor 	p_model;
	/** Initial nap is seconds		*/
	private int					m_initialNap = 0;

	/**	Milliseconds to sleep - 0 Sec default	*/
	protected long				m_sleepMS = 0;
	/** Sleeping					*/
	private volatile boolean	m_sleeping = true;
	/** Server start time					*/
	protected long				m_start = 0;
	/** Number of Work executions	*/
	protected int 				p_runCount = 0;
	/** Tine start of work				*/
	protected long				p_startWork = 0;
	/** Number MS of last Run		*/
	private long 				m_runLastMS = 0;
	/** Number of MS total			*/
	private long 				m_runTotalMS = 0;
	/** When to run next			*/
	private long 				m_nextWork = 0;

	/**	Logger						*/
	protected transient CLogger	log = CLogger.getCLogger(getClass());
	/** System						*/
	protected volatile static MSystem p_system = null;
	/** Client						*/
	protected MClient	p_client = null;

	/**
	 * 	Get Server Context
	 *	@return context
	 */
	public Properties getCtx()
	{
		return Env.getCtx();
	}	//	getCtx

	public void recalculateSleepMS()
	{
		if (p_model instanceof PO) 
		{
			PO po = (PO) p_model;
			po.load(null);
		}
		m_sleepMS = 0;
		m_nextWork = 0;
		Timestamp dateNextRun = getDateNextRun(true);
		Timestamp now = new Timestamp(System.currentTimeMillis());
		if (dateNextRun != null)
		{
			m_nextWork = dateNextRun.getTime();
		}
		else
		{			
			m_nextWork = MSchedule.getNextRunMS(now.getTime(),
					p_model.getScheduleType(), p_model.getFrequencyType(),
					p_model.getFrequency(), p_model.getCronPattern(), MClientInfo.get(getCtx(), p_model.getAD_Client_ID()).getTimeZone());
		}

		if (m_nextWork > now.getTime())
			m_sleepMS = m_nextWork - now.getTime();
		if (log.isLoggable(Level.INFO)) log.info(" Next run: " + new Timestamp(m_nextWork) + " sleep " + m_sleepMS);
		//
		p_model.setDateNextRun(new Timestamp(m_nextWork));
		p_model.saveEx();		
	}
	
	/**
	 * @return Returns the sleepMS.
	 */
	public long getSleepMS ()
	{
		return m_sleepMS;
	}	//	getSleepMS

	public long getInitialNap()
	{
		return m_initialNap;
	}

	public void runNow()
	{
		Properties context = new Properties();
		MClient schedclient = MClient.get(getCtx(), p_model.getAD_Client_ID());
		Env.setContext(context, Env.AD_CLIENT_ID, schedclient.getAD_Client_ID());
		Env.setContext(context, Env.LANGUAGE, schedclient.getAD_Language());
		if (p_model instanceof PO) {
			PO po = (PO) p_model;
			if (po.get_ColumnIndex("AD_Org_ID") >= 0) {
				Env.setContext(context, Env.AD_ORG_ID, po.get_ValueAsInt("AD_Org_ID"));
				MOrgInfo schedorg = new Query(context, MOrgInfo.Table_Name, "AD_Org_ID=?", null)
						.setParameters(po.get_ValueAsInt("AD_Org_ID")).first();
				if (schedorg != null && schedorg.getM_Warehouse_ID() > 0)
					Env.setContext(context, Env.M_WAREHOUSE_ID, schedorg.getM_Warehouse_ID());
			}
			int AD_User_ID = getAD_User_ID(po);
			if (AD_User_ID > 0) {
				Env.setContext(context, Env.AD_USER_ID, AD_User_ID);
				Env.setContext(context, Env.SALESREP_ID, AD_User_ID);
				MUser scheduser = new MUser(context, AD_User_ID, null);
				MRole[] schedroles = scheduser.getRoles(po.get_ValueAsInt("AD_Org_ID"));
				if (schedroles != null && schedroles.length > 0)
					Env.setContext(context, Env.AD_ROLE_ID, schedroles[0].getAD_Role_ID()); // first role, ordered by AD_Role_ID				
			}
		}
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat dateFormat4Timestamp = new SimpleDateFormat("yyyy-MM-dd"); 
		Env.setContext(context, Env.DATE, dateFormat4Timestamp.format(ts)+" 00:00:00" );    //  JDBC format
		
		Properties prevContext = ServerContext.getCurrentInstance();
		try {
			ServerContext.setCurrentInstance(context);						
			m_sleeping = false;
			doRunNow();
		} finally {
			ServerContext.dispose();
			ServerContext.setCurrentInstance(prevContext);
			m_sleeping = true;
		}
	}
		
	private int getAD_User_ID(PO po) {
		int AD_User_ID = -1;
		if (po.get_ValueAsInt("Supervisor_ID") > 0)
			AD_User_ID = po.get_ValueAsInt("Supervisor_ID");
		else if (po.get_ValueAsInt("CreatedBy") > 0)
			AD_User_ID = po.get_ValueAsInt("CreatedBy");
		else if (po.get_ValueAsInt("UpdatedBy") > 0)
			AD_User_ID = po.get_ValueAsInt("UpdatedBy");
		else
			AD_User_ID = SystemIDs.USER_SUPERUSER; //fall back to SuperUser
		return AD_User_ID;
	}
	
	/**
	 * 	Run Now
	 */
	public void doRunNow()
	{
		p_startWork = System.currentTimeMillis();
		doWork();
		long now = System.currentTimeMillis();
		//	---------------

		p_runCount++;
		m_runLastMS = now - p_startWork;
		m_runTotalMS += m_runLastMS;
		//
		p_model.setDateLastRun(new Timestamp(now));
		p_model.saveEx();
		//
		if (log.isLoggable(Level.FINE))
			log.fine(getStatistics());		
	}	//	runNow

	public void run() 
	{
		final Thread currentThread = Thread.currentThread();
		final String oldThreadName = currentThread.getName();
		String newThreadName = getName();
		boolean renamed = false;
		if (!oldThreadName.equals(newThreadName)) {
			try {
				currentThread.setName(newThreadName);
				renamed = true;
			} catch (SecurityException e) {}
		}

		Properties context = new Properties();
		Env.setContext(context, Env.AD_CLIENT_ID, p_model.getAD_Client_ID());
		if (p_model instanceof PO) {
			PO po = (PO) p_model;
			if (po.get_ColumnIndex("AD_Org_ID") >= 0)
				Env.setContext(context, Env.AD_ORG_ID, po.get_ValueAsInt("AD_Org_ID"));
			if (po.get_ColumnIndex("AD_User_ID") >= 0)
				Env.setContext(context, Env.AD_USER_ID, po.get_ValueAsInt("AD_User_ID"));
		}
		
		try {
			ServerContext.setCurrentInstance(context);					
			m_sleeping = false;
			doRun();
		} finally {
			m_sleeping = true;
			ServerContext.dispose(); 
			if (renamed) {
				// Revert the name back if the current thread was renamed.
				// We do not check the exception here because we know it works.
				currentThread.setName(oldThreadName);
			}	
		}
	}
	/**************************************************************************
	 * 	Run async
	 */
	protected void doRun()
	{		
		if (m_start == 0)
			m_start = System.currentTimeMillis();
		
		//	---------------
		p_startWork = System.currentTimeMillis();
		doWork();
		long now = System.currentTimeMillis();
		//	---------------

		p_runCount++;
		m_runLastMS = now - p_startWork;
		m_runTotalMS += m_runLastMS;

		// Finished work - calculate datetime for next run
		Timestamp lastRun = new Timestamp(now);
		if (p_model instanceof AdempiereProcessor2)
		{
			AdempiereProcessor2 ap = (AdempiereProcessor2) p_model;
			if (ap.isIgnoreProcessingTime())
			{
				lastRun = new Timestamp(p_startWork);
			}
		}

		m_nextWork = MSchedule.getNextRunMS(lastRun.getTime(),
				p_model.getScheduleType(), p_model.getFrequencyType(),
				p_model.getFrequency(), p_model.getCronPattern(), MClientInfo.get(getCtx(), p_model.getAD_Client_ID()).getTimeZone());

		m_sleepMS = m_nextWork - now;
		if (m_nextWork == 0) {
			m_sleepMS = 0;
		}
		if (log.isLoggable(Level.INFO)) log.info(" Next run: " + new Timestamp(m_nextWork) + " sleep " + m_sleepMS);
		//
		p_model.setDateLastRun(lastRun);
		if (m_nextWork == 0) {
			p_model.setDateNextRun(null);
		} else {
			p_model.setDateNextRun(new Timestamp(m_nextWork));
		}
		p_model.saveEx();			
	}	//	run

	/**
	 * 	Get Run Statistics
	 *	@return Statistic info
	 */
	public String getStatistics()
	{
		return "Run #" + p_runCount
			+ " - Last=" + TimeUtil.formatElapsed(m_runLastMS)
			+ " - Total=" + TimeUtil.formatElapsed(m_runTotalMS)
			+ " - Next " + TimeUtil.formatElapsed(m_nextWork - System.currentTimeMillis());
	}	//	getStatistics

	/**
	 * 	Do the actual Work
	 */
	protected abstract void doWork();

	/**
	 * 	Get Server Info
	 *	@return info
	 */
	public abstract String getServerInfo();

	/**
	 * 	Get Unique ID
	 *	@return Unique ID
	 */
	public String getServerID()
	{
		return p_model.getServerID();
	}	//	getServerID

	/**
	 * 	Get the date Next run
	 * 	@param requery requery database
	 * 	@return date next run
	 */
	public Timestamp getDateNextRun (boolean requery)
	{
		return p_model.getDateNextRun(requery);
	}	//	getDateNextRun

	/**
	 * 	Get the date Last run
	 * 	@return date lext run
	 */
	public Timestamp getDateLastRun ()
	{
		return p_model.getDateLastRun();
	}	//	getDateLastRun

	/**
	 * 	Get Description
	 *	@return Description
	 */
	public String getDescription()
	{
		return p_model.getDescription();
	}	//	getDescription

	/**
	 * 	Get Model
	 *	@return Model
	 */
	public AdempiereProcessor getModel()
	{
		return p_model;
	}	//	getModel

	/**
	 * 	Is Sleeping
	 *	@return sleeping
	 */
	public boolean isSleeping()
	{
		return m_sleeping;
	}	//	isSleeping

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ()
			.append ("Sleeping=").append(m_sleeping)
			.append (",Last=").append(getDateLastRun());
		if (m_sleeping)
			sb.append (",Next=").append(getDateNextRun(false));
		return sb.toString ();
	}	//	toString

	/**
	 * 	Get Seconds Alive
	 *	@return seconds alive
	 */
	public int getSecondsAlive()
	{
		if (m_start == 0)
			return 0;
		long now = System.currentTimeMillis();
		long ms = (now-m_start) / 1000;
		return (int)ms;
	}	//	getSecondsAlive

	/**
	 * 	Get Start Time
	 *	@return start time
	 */
	public Timestamp getStartTime()
	{
		if (m_start == 0)
			return null;
		return new Timestamp (m_start);
	}	//	getStartTime

	/**
	 * 	Get Processor Logs
	 *	@return logs
	 */
	public AdempiereProcessorLog[] getLogs()
	{
		return p_model.getLogs();
	}	//	getLogs


	protected boolean isInterrupted() {
		return Thread.currentThread().isInterrupted();
	}


	public String getName() {
		return p_model.getName();
	}


	public static boolean isOKtoRunOnIP(AdempiereProcessor model) {
		if (model instanceof AdempiereProcessor2) {
			int AD_Schedule_ID = ((AdempiereProcessor2)model).getAD_Schedule_ID();
			MSchedule schedule = MSchedule.get(Env.getCtx(), AD_Schedule_ID);
			if (!schedule.isOKtoRunOnIP())
			{
				return false;		//	done
			}
		}
		return true;
	}

}	//	AdempiereServer
