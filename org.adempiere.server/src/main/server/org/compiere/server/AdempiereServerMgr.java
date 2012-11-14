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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

import org.adempiere.base.Service;
import org.adempiere.server.IServerFactory;
import org.compiere.Adempiere;
import org.compiere.model.MAcctProcessor;
import org.compiere.model.MAlertProcessor;
import org.compiere.model.MLdapProcessor;
import org.compiere.model.MRequestProcessor;
import org.compiere.model.MScheduler;
import org.compiere.model.MSession;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflowProcessor;

/**
 *	Adempiere Server Manager
 *	
 *  @author Jorg Janke
 *  @version $Id: AdempiereServerMgr.java,v 1.4 2006/10/09 00:23:26 jjanke Exp $
 */
public class AdempiereServerMgr
{
	/**
	 * 	Get Adempiere Server Manager
	 *	@return mgr
	 */
	public static AdempiereServerMgr get()
	{
		if (m_serverMgr == null)
		{
			//	for faster subsequent calls
			m_serverMgr = new AdempiereServerMgr();
			m_serverMgr.startServers();
			m_serverMgr.log.info(m_serverMgr.toString());
		}
		return m_serverMgr;
	}	//	get
	
	/**	Singleton					*/
	private static	AdempiereServerMgr	m_serverMgr = null;
	/**	Logger			*/
	protected CLogger	log = CLogger.getCLogger(getClass());
	
	/**************************************************************************
	 * 	Adempiere Server Manager
	 */
	private AdempiereServerMgr ()
	{
		super();
		startEnvironment();
	//	m_serverMgr.startServers();
	}	//	AdempiereServerMgr

	/**	The Servers				*/
	private ArrayList<ServerWrapper>	m_servers = new ArrayList<ServerWrapper>();
	/** Context					*/
	private Properties		m_ctx = Env.getCtx();
	/** Start					*/
	private Timestamp		m_start = new Timestamp(System.currentTimeMillis());

	/**
	 * 	Start Environment
	 *	@return true if started
	 */
	private boolean startEnvironment()
	{
		Adempiere.startup(false);
		log.info("");
		
		//	Set Session
		MSession session = MSession.get(getCtx(), true);
		session.setWebStoreSession(false);
		session.setWebSession("Server");
		session.saveEx();
		//
		return true;
	}	//	startEnvironment
	
	/**
	 * 	Start Environment
	 *	@return true if started
	 */
	public boolean startServers()
	{
		log.info("");
		int noServers = 0;
		m_servers=new ArrayList<ServerWrapper>();
		//	Accounting
		MAcctProcessor[] acctModels = MAcctProcessor.getActive(m_ctx);
		for (int i = 0; i < acctModels.length; i++)
		{
			MAcctProcessor pModel = acctModels[i];
			AdempiereServer server = AdempiereServer.create(pModel);
			if (server != null) {
//				server.start();
//				server.setPriority(Thread.NORM_PRIORITY-2);
				m_servers.add(new ServerWrapper(server));
			}
		}		
		//	Request
		MRequestProcessor[] requestModels = MRequestProcessor.getActive(m_ctx);
		for (int i = 0; i < requestModels.length; i++)
		{
			MRequestProcessor pModel = requestModels[i];
			AdempiereServer server = AdempiereServer.create(pModel);
			if (server != null) {
//				server.start();
//				server.setPriority(Thread.NORM_PRIORITY-2);
				m_servers.add(new ServerWrapper(server));
			}
		}
		//	Workflow
		MWorkflowProcessor[] workflowModels = MWorkflowProcessor.getActive(m_ctx);
		for (int i = 0; i < workflowModels.length; i++)
		{
			MWorkflowProcessor pModel = workflowModels[i];
			AdempiereServer server = AdempiereServer.create(pModel);
			if (server != null) {
//				server.start();
//				server.setPriority(Thread.NORM_PRIORITY-2);
				m_servers.add(new ServerWrapper(server));
			}
		}		
		//	Alert
		MAlertProcessor[] alertModels = MAlertProcessor.getActive(m_ctx);
		for (int i = 0; i < alertModels.length; i++)
		{
			MAlertProcessor pModel = alertModels[i];
			AdempiereServer server = AdempiereServer.create(pModel);
			if (server != null) {
//				server.start();
//				server.setPriority(Thread.NORM_PRIORITY-2);
				m_servers.add(new ServerWrapper(server));
			}
		}		
		//	Scheduler
		MScheduler[] schedulerModels = MScheduler.getActive(m_ctx);
		for (int i = 0; i < schedulerModels.length; i++)
		{
			MScheduler pModel = schedulerModels[i];
			AdempiereServer server = AdempiereServer.create(pModel);
			if (server != null) {
//				server.start();
//				server.setPriority(Thread.NORM_PRIORITY-2);
				m_servers.add(new ServerWrapper(server));
			}
		}		
		//	LDAP
		MLdapProcessor[] ldapModels = MLdapProcessor.getActive(m_ctx);
		for (int i = 0; i < ldapModels.length; i++)
		{
			MLdapProcessor lp = ldapModels[i];
			AdempiereServer server = AdempiereServer.create(lp);
			if (server != null) {
//				server.start();
//				server.setPriority(Thread.NORM_PRIORITY-1);
				m_servers.add(new ServerWrapper(server));
			}
		}
		
		//osgi server
		List<IServerFactory> serverFactoryList = Service.locator().list(IServerFactory.class).getServices();
		if (serverFactoryList != null && !serverFactoryList.isEmpty())
		{
			for(IServerFactory factory : serverFactoryList )
			{
				AdempiereServer[] servers = factory.create(m_ctx);
				if (servers != null && servers.length > 0)
				{
					for (AdempiereServer server : servers)
					{
//						server.start();
//						server.setPriority(Thread.NORM_PRIORITY-1);
						m_servers.add(new ServerWrapper(server));						
					}
				}				
			}
		}
		
		log.fine("#" + noServers);
		return startAll();
	}	//	startEnvironment

	/**
	 * 	Get Server Context
	 *	@return ctx
	 */
	public Properties getCtx()
	{
		return m_ctx;
	}	//	getCtx
	
	/**
	 * 	Start all servers
	 *	@return true if started
	 */
	public boolean startAll()
	{
		log.info ("");
		ServerWrapper[] servers = getInActive();
		for (int i = 0; i < servers.length; i++)
		{
			ServerWrapper server = servers[i];
			try
			{
				if (server.scheduleFuture != null || !server.scheduleFuture.isDone())
					continue;
				//	Do start
				//	replace
				server.start();
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "Server: " + server, e);
			}
		}	//	for all servers
		
		//	Final Check
		int noRunning = 0;
		int noStopped = 0;
		for (int i = 0; i < servers.length; i++)
		{
			ServerWrapper server = servers[i];
			try
			{
				if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				{
					log.info("Alive: " + server);
					noRunning++;
				}
				else
				{
					log.warning("Dead: " + server);
					noStopped++;
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "(checking) - " + server, e);
				noStopped++;
			}
		}
		log.fine("Running=" + noRunning + ", Stopped=" + noStopped);
		return noStopped == 0;
	}	//	startAll

	/**
	 * 	Start Server if not started yet
	 * 	@param serverID server ID
	 *	@return true if started
	 */
	public boolean start (String serverID)
	{
		ServerWrapper server = getServer(serverID);
		if (server == null)
			return false;
		if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
			return true;
		
		try
		{
			//	replace
			server.start();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Server=" + serverID, e);
			return false;
		}
		log.info(server.toString());
		return (server.scheduleFuture != null && !server.scheduleFuture.isDone());
	}	//	startIt
	
	/**
	 * 	Stop all Servers
	 *	@return true if stopped
	 */
	public boolean stopAll()
	{
		log.info ("");
		ServerWrapper[] servers = getActive();
		//	Interrupt
		for (int i = 0; i < servers.length; i++)
		{
			ServerWrapper server = servers[i];
			try
			{
				if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				{
					server.scheduleFuture.cancel(true);
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "(interrupting) - " + server, e);
			}
		}	//	for all servers
		Thread.yield();
		
		//	Wait for death
		for (int i = 0; i < servers.length; i++)
		{
			ServerWrapper server = servers[i];
			try
			{
				int maxWait = 10;	//	10 iterations = 1 sec
				while (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				{
					if (maxWait-- == 0)
					{
						log.severe ("Wait timeout for interruped " + server);
						break;
					}
					Thread.sleep(100);		//	1/10
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "(waiting) - " + server, e);
			}
		}	//	for all servers
		
		//	Final Check
		int noRunning = 0;
		int noStopped = 0;
		for (int i = 0; i < servers.length; i++)
		{
			ServerWrapper server = servers[i];
			try
			{
				if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				{
					log.warning ("Alive: " + server);
					noRunning++;
				}
				else
				{
					log.info ("Stopped: " + server);
					noStopped++;
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "(checking) - " + server, e);
				noRunning++;
			}
		}
		log.fine("Running=" + noRunning + ", Stopped=" + noStopped);
		AdempiereServerGroup.get().dump();
		return noRunning == 0;
	}	//	stopAll

	/**
	 * 	Stop Server if not stopped
	 * 	@param serverID server ID
	 *	@return true if interrupted
	 */
	public boolean stop (String serverID)
	{
		ServerWrapper server = getServer(serverID);
		if (server == null)
			return false;
		if (server.scheduleFuture == null || server.scheduleFuture.isDone())
			return true;

		try
		{
			server.scheduleFuture.cancel(true);
			Thread.sleep(10);	//	1/100 sec
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "stop", e);
			return false;
		}
		log.info(server.toString());
		return (server.scheduleFuture == null || server.scheduleFuture.isDone());
	}	//	stop

	
	/**
	 * 	Destroy
	 */
	public void destroy ()
	{
		log.info ("");
		stopAll();
		m_servers.clear();
	}	//	destroy

	/**
	 * 	Get Active Servers
	 *	@return array of active servers
	 */
	protected ServerWrapper[] getActive()
	{
		ArrayList<ServerWrapper> list = new ArrayList<ServerWrapper>();
		for (int i = 0; i < m_servers.size(); i++)
		{
			ServerWrapper server = (ServerWrapper)m_servers.get(i);
			if (server != null && server.scheduleFuture != null && !server.scheduleFuture.isDone())
				list.add (server);
		}
		ServerWrapper[] retValue = new ServerWrapper[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getActive
	
	/**
	 * 	Get InActive Servers
	 *	@return array of inactive servers
	 */
	protected ServerWrapper[] getInActive()
	{
		ArrayList<ServerWrapper> list = new ArrayList<ServerWrapper>();
		for (int i = 0; i < m_servers.size(); i++)
		{
			ServerWrapper server = m_servers.get(i);
			if (server != null && (server.scheduleFuture == null || server.scheduleFuture.isDone()))
				list.add (server);
		}
		ServerWrapper[] retValue = new ServerWrapper[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	getInActive

	/**
	 * 	Get all Servers
	 *	@return array of servers
	 */
	public ServerWrapper[] getAll()
	{
		ServerWrapper[] retValue = new ServerWrapper[m_servers.size()];
		m_servers.toArray (retValue);
		return retValue;
	}	//	getAll
	
	/**
	 * 	Get Server with ID
	 *	@param serverID server id
	 *	@return server or null
	 */
	public ServerWrapper getServer (String serverID)
	{
		if (serverID == null)
			return null;
		for (int i = 0; i < m_servers.size(); i++)
		{
			ServerWrapper server = m_servers.get(i);
			if (serverID.equals(server.server.getServerID()))
				return server;
		}
		return null;
	}	//	getServer
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuffer sb = new StringBuffer ("AdempiereServerMgr[");
		sb.append("Servers=").append(m_servers.size())
			.append(",ContextSize=").append(m_ctx.size())
			.append(",Started=").append(m_start)
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Get Description
	 *	@return description
	 */
	public String getDescription()
	{
		return "$Revision: 1.4 $";
	}	//	getDescription
	
	/**
	 * 	Get Number Servers
	 *	@return no of servers
	 */
	public String getServerCount()
	{
		int noRunning = 0;
		int noStopped = 0;
		for (int i = 0; i < m_servers.size(); i++)
		{
			ServerWrapper server = m_servers.get(i);
			if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				noRunning++;
			else
				noStopped++;
		}
		String info = String.valueOf(m_servers.size())
			+ " - Running=" + noRunning
			+ " - Stopped=" + noStopped;
		return info;
	}	//	getServerCount
	
	/**
	 * 	Get start date
	 *	@return start date
	 */
	public Timestamp getStartTime()
	{
		return m_start;
	}	//	getStartTime

	public static class ServerWrapper implements Runnable
	{

		protected AdempiereServer server;
		protected volatile ScheduledFuture<?> scheduleFuture;

		public ServerWrapper(AdempiereServer server) {
			this.server = server;
			start();
		}
		
		public void start() {
			scheduleFuture = Adempiere.getThreadPoolExecutor().schedule(this, server.getInitialNap() * 1000 + server.getSleepMS(), TimeUnit.MILLISECONDS);
		}

		@Override
		public void run() {
			server.run();
			scheduleFuture = Adempiere.getThreadPoolExecutor().schedule(this, server.getSleepMS(), TimeUnit.MILLISECONDS);
		}
		
		public AdempiereServer getServer() {
			return server;
		}

		public boolean isAlive() {
			return scheduleFuture != null && !scheduleFuture.isDone();
		}

		public boolean isInterrupted() {
			return scheduleFuture != null && scheduleFuture.isCancelled();
		}
		
	}
}	//	AdempiereServerMgr
