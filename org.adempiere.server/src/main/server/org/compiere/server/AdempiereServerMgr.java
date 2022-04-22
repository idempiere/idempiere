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
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.Service;
import org.adempiere.server.AdempiereServerActivator;
import org.adempiere.server.IServerFactory;
import org.adempiere.util.ServerContext;
import org.compiere.Adempiere;
import org.compiere.model.AdempiereProcessor;
import org.compiere.model.MScheduler;
import org.compiere.model.MSession;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.distributed.ICacheService;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.server.cluster.ClusterServerMgr;
import org.osgi.framework.BundleEvent;
import org.osgi.framework.BundleListener;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;
import org.osgi.util.tracker.ServiceTrackerCustomizer;

/**
 *	Adempiere Server Manager
 *	
 *  @author Jorg Janke
 *  @version $Id: AdempiereServerMgr.java,v 1.4 2006/10/09 00:23:26 jjanke Exp $
 */
public class AdempiereServerMgr implements ServiceTrackerCustomizer<IServerFactory<AdempiereServer, AdempiereProcessor>, IServerFactory<AdempiereServer, AdempiereProcessor>>, BundleListener, IServerManager
{
	private static ServiceTracker<IServerFactory<AdempiereServer, AdempiereProcessor>, IServerFactory<AdempiereServer, AdempiereProcessor>> serviceTracker;

	/**
	 * 	Get Adempiere Server Manager
	 *	@return mgr
	 */
	public synchronized static AdempiereServerMgr get()
	{
		return get(true);
	}
	
	/**
	 * 	Get Adempiere Server Manager
	 *	@return mgr
	 */
	public synchronized static AdempiereServerMgr get(boolean createNew)
	{
		if (m_serverMgr == null && createNew)
		{
			m_serverMgr = new AdempiereServerMgr();
			serviceTracker = new ServiceTracker<IServerFactory<AdempiereServer, AdempiereProcessor>, IServerFactory<AdempiereServer, AdempiereProcessor>>(AdempiereServerActivator.getBundleContext(), 
					IServerFactory.class.getName(), m_serverMgr);
			serviceTracker.open();
			AdempiereServerActivator.getBundleContext().addBundleListener(m_serverMgr);
		}
		return m_serverMgr;
	}	//	get
	
	/**	Singleton					*/
	private static AdempiereServerMgr	m_serverMgr = null;
	/**	Logger			*/
	protected static final CLogger	log = CLogger.getCLogger(AdempiereServerMgr.class);
	
	/**************************************************************************
	 * 	Adempiere Server Manager
	 */
	private AdempiereServerMgr ()
	{
		super();
		startEnvironment();
		m_servers=new ArrayList<LocalServerController>();
		processorClass = new HashSet<String>();
	}	//	AdempiereServerMgr

	/**	The Servers				*/
	private ArrayList<LocalServerController>	m_servers = new ArrayList<LocalServerController>();
	/** Context					*/
	private Properties		m_ctx = Env.getCtx();
	/** Start					*/
	private Timestamp		m_start = new Timestamp(System.currentTimeMillis());
	
	private Set<String> processorClass;

	/**
	 * 	Start Environment
	 *	@return true if started
	 */
	private boolean startEnvironment()
	{
		Adempiere.startup(false);
		log.info("");
		
		//	Set Session
		MSession session = MSession.get(getCtx());
		if(session == null) {
			session = MSession.create(getCtx());
		} else {
			session = new MSession(getCtx(), session.getAD_Session_ID(), null);
		}
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
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public synchronized String reload()
	{
		log.info("");
		if (stopAll() != null)
			return "Failed to stop all servers";
		
		String clusterId = getClusterMemberId();
		if (clusterId != null) {
			Map<String, String> map = getServerOwnerMap();
			if (map != null) {
				ICacheService cacheService = Core.getCacheService();
				try {
					String reloadLockKey = "cluster.server.owner.map.reload";
					if (cacheService.tryLock(map, reloadLockKey, 30, TimeUnit.SECONDS)) {
						try {
							List<String> toRemove = new ArrayList<>();
							for(Map.Entry<String, String> entry : map.entrySet()) {
								if (entry.getValue().equals(clusterId)) {
									toRemove.add(entry.getKey());
								}
							}
							for(String key : toRemove) {
								map.remove(key);
							}
						} finally {
							cacheService.unLock(map, reloadLockKey);
						}
					}					
				} catch (Exception e) {
					return "Failed to lock cluster server owner map";
				}
			}
		}
				
		int noServers = 0;		
		m_servers=new ArrayList<LocalServerController>();
		processorClass = new HashSet<String>();
		
		//osgi server
		List<IServerFactory> serverFactoryList = Service.locator().list(IServerFactory.class).getServices();
		if (serverFactoryList != null && !serverFactoryList.isEmpty())
		{
			for(IServerFactory factory : serverFactoryList )
			{
				createServers(factory);
			}
		}
		
		if (log.isLoggable(Level.FINE)) log.fine("#" + noServers);
		return startAll() == null ? null : "Failed to restart all servers"; 
	}	//	startEnvironment

	private void createServers(IServerFactory<AdempiereServer, AdempiereProcessor> factory) {
		String name = factory.getProcessorClass().getName();
		if (!processorClass.contains(name))
		{
			processorClass.add(name);
			AdempiereServer[] servers = factory.create(m_ctx);
			if (servers != null && servers.length > 0)
			{
				for (AdempiereServer server : servers)
				{
					AdempiereProcessor model = server.getModel();
					if (canRunHere(server, model)) {
						String clusterId = getClusterMemberId();
						if (clusterId != null) {
							Map<String, String> map = getServerOwnerMap();
							if (map != null) {
								ICacheService cacheService = Core.getCacheService();
								try {
									if (cacheService.tryLock(map, server.getServerID(), 30, TimeUnit.SECONDS)) {
										try {
											String memberId = map.get(server.getServerID());
											if (memberId != null && !memberId.equals(clusterId)) {
												continue;
											} else if (memberId == null) {
												map.put(server.getServerID(), clusterId);
											}
										} finally {
											cacheService.unLock(map, server.getServerID());
										}
									} else {
										continue;
									}
								} catch (Exception e) {
									continue;
								}
							}
						}
						m_servers.add(new LocalServerController(server));
					}
				}
			}				
		}
	}

	private boolean canRunHere(AdempiereServer server, AdempiereProcessor model) {
		return AdempiereServer.isOKtoRunOnIP(model);
	}
	
	/**
	 * @param scheduler
	 * @return error
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String addScheduler(MScheduler scheduler) {
		String serverId = scheduler.getServerID();
		if (getServerInstance(serverId) != null)
			return null;
		
		//osgi server
		List<IServerFactory> serverFactoryList = Service.locator().list(IServerFactory.class).getServices();
		if (serverFactoryList != null && !serverFactoryList.isEmpty())
		{		
			for(IServerFactory factory : serverFactoryList )
			{
				if (factory.getProcessorClass().getName().equals(scheduler.getClass().getName())) {
					AdempiereServer server = factory.create(m_ctx, scheduler);
					if (server != null && canRunHere(server, scheduler)) {
						if (getServerInstance(scheduler.getServerID()) == null) {
							String clusterId = getClusterMemberId();
							if (clusterId != null) {
								Map<String, String> map = getServerOwnerMap();
								if (map != null) {
									ICacheService cacheService = Core.getCacheService();
									try {
										if (cacheService.tryLock(map, server.getServerID(), 30, TimeUnit.SECONDS)) {
											try {
												String memberId = map.get(server.getServerID());
												if (memberId != null && !memberId.equals(clusterId)) {
													continue;
												} else if (memberId == null) {
													map.put(server.getServerID(), clusterId);
												}
											} finally {
												cacheService.unLock(map, server.getServerID());
											}
										} else {
											continue;
										}
									} catch (Exception e) {
										continue;
									}
								}
							}
							m_servers.add(new LocalServerController(server, false));
							return start(serverId);
						}
					}
				}
			}
		}
		
		return null;		
	}

	@Override
	public synchronized String removeScheduler(MScheduler scheduler) {
		String serverId = scheduler.getServerID();
		LocalServerController serverController = getLocalServerController(serverId);
		if (serverController == null)
			return null;
		
		if (serverController.isAlive()) {
			String error = stop(serverId);
			if (error != null) {
				return error;
			}
		}
		
		for (int i = 0; i < m_servers.size(); i++) {
			serverController = m_servers.get(i);
			if (serverId.equals(serverController.server.getServerID())) {
				m_servers.remove(i);
				
				String clusterId = getClusterMemberId();
				if (clusterId != null) {
					Map<String, String> map = getServerOwnerMap();
					if (map != null) {
						String ownerId = map.get(serverId);
						if (ownerId != null && ownerId.equals(clusterId)) {
							map.remove(serverId);
						}
					}
				}
				return null;
			}
		}
		
		return null;
		
	}
	
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
	@Override
	public synchronized String startAll()
	{
		log.info ("");
		LocalServerController[] servers = getInActive();
		Properties currentContext = ServerContext.getCurrentInstance();
		for (int i = 0; i < servers.length; i++)
		{
			LocalServerController server = servers[i];
			Properties temp = null;
			try
			{
				if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
					continue;
				//	Do start
				//	replace
				if (Env.getAD_Client_ID(currentContext) != server.getServer().getModel().getAD_Client_ID())
				{
					temp = new Properties(currentContext);
					Env.setContext(temp, Env.AD_CLIENT_ID, server.getServer().getModel().getAD_Client_ID());
					ServerContext.setCurrentInstance(temp);
				}
				server.getServer().recalculateSleepMS();
				server.start();
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "Server: " + server, e);
			}
			finally
			{
				if (temp != null)
					ServerContext.setCurrentInstance(currentContext);
			}
		}	//	for all servers		
		
		//	Final Check
		int noRunning = 0;
		int noStopped = 0;
		for (int i = 0; i < servers.length; i++)
		{
			LocalServerController server = servers[i];
			try
			{
				if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				{
					if (log.isLoggable(Level.INFO)) log.info("Alive: " + server);
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
		if (log.isLoggable(Level.FINE)) log.fine("Running=" + noRunning + ", Stopped=" + noStopped);
		return noStopped == 0 ? null : "Failed to start all servers";
	}	//	startAll

	/**
	 * 	Start Server if not started yet
	 * 	@param serverID server ID
	 *	@return true if started
	 */
	@Override
	public synchronized String start (String serverID)
	{
		LocalServerController server = getLocalServerController(serverID);
		if (server == null)
			return "Server not found";
		if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
			return "Server is already running";
		
		Properties currentContext = ServerContext.getCurrentInstance();
		Properties temp = null;
		try
		{
			//	replace
			if (Env.getAD_Client_ID(currentContext) != server.getServer().getModel().getAD_Client_ID())
			{
				temp = new Properties(currentContext);
				Env.setContext(temp, Env.AD_CLIENT_ID, server.getServer().getModel().getAD_Client_ID());
				ServerContext.setCurrentInstance(temp);
			}
			server.getServer().recalculateSleepMS();
			server.start();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Server=" + serverID, e);
			return e.getMessage();
		}
		finally
		{
			if (temp != null)
				ServerContext.setCurrentInstance(currentContext);
		}
		if (log.isLoggable(Level.INFO)) log.info(server.toString());
		return (server.scheduleFuture != null && !server.scheduleFuture.isDone()) ? null : "Failed to start server"; 
	}	//	startIt
	
	/**
	 * 	Stop all Servers
	 *	@return true if stopped
	 */
	@Override
	public synchronized String stopAll()
	{
		log.info ("");
		LocalServerController[] servers = getActive();
		//	Interrupt
		for (int i = 0; i < servers.length; i++)
		{
			LocalServerController server = servers[i];
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
			LocalServerController server = servers[i];
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
			LocalServerController server = servers[i];
			try
			{
				if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				{
					log.warning ("Alive: " + server);
					noRunning++;
				}
				else
				{
					if (log.isLoggable(Level.INFO)) log.info ("Stopped: " + server);
					noStopped++;
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "(checking) - " + server, e);
				noRunning++;
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine("Running=" + noRunning + ", Stopped=" + noStopped);
		AdempiereServerGroup.get().dump();
		return noRunning == 0 ? null : "Failed to stop all servers";
	}	//	stopAll

	/**
	 * 	Stop Server if not stopped
	 * 	@param serverID server ID
	 *	@return true if interrupted
	 */
	@Override
	public synchronized String stop (String serverID)
	{
		LocalServerController server = getLocalServerController(serverID);
		if (server == null)
			return "Server not found";
		if (server.scheduleFuture == null || server.scheduleFuture.isDone())
			return "Server is already stop";

		try
		{
			server.scheduleFuture.cancel(true);
			Thread.sleep(10);	//	1/100 sec
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "stop", e);
			return e.getMessage();
		}
		if (log.isLoggable(Level.INFO)) log.info(server.toString());
		return (server.scheduleFuture == null || server.scheduleFuture.isDone()) ? null : "Failed to stop server";
	}	//	stop

	
	/**
	 * 	Destroy
	 */
	public synchronized void destroy ()
	{
		log.info ("");
		stopAll();
		m_servers.clear();
	}	//	destroy

	/**
	 * 	Get Active Servers
	 *	@return array of active servers
	 */
	protected synchronized LocalServerController[] getActive()
	{
		ArrayList<LocalServerController> list = new ArrayList<LocalServerController>();
		for (int i = 0; i < m_servers.size(); i++)
		{
			LocalServerController server = (LocalServerController)m_servers.get(i);
			if (server != null && server.scheduleFuture != null && !server.scheduleFuture.isDone())
				list.add (server);
		}
		LocalServerController[] retValue = new LocalServerController[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getActive
	
	/**
	 * 	Get InActive Servers
	 *	@return array of inactive servers
	 */
	protected synchronized LocalServerController[] getInActive()
	{
		ArrayList<LocalServerController> list = new ArrayList<LocalServerController>();
		for (int i = 0; i < m_servers.size(); i++)
		{
			LocalServerController server = m_servers.get(i);
			if (server != null && (server.scheduleFuture == null || server.scheduleFuture.isDone()))
				list.add (server);
		}
		LocalServerController[] retValue = new LocalServerController[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	getInActive

	/**
	 * 	Get all Servers
	 *	@return array of servers
	 */
	private synchronized LocalServerController[] getLocalServerControllers()
	{
		LocalServerController[] retValue = new LocalServerController[m_servers.size()];
		m_servers.toArray (retValue);
		return retValue;
	}	//	getAll
	
	
	@Override
	public synchronized ServerInstance[] getServerInstances() {
		List<ServerInstance> responses = new ArrayList<>();
		LocalServerController[] controllers = getLocalServerControllers();
		for (LocalServerController controller : controllers) {
			if (controller.getServer() != null) {
				ServerInstance response = new ServerInstance(controller.getServer().getServerID(), controller.getServer().getModel(), 
						controller.isAlive(), controller.isInterrupted(), controller.getServer().isSleeping(), 
						controller.getServer().getStartTime(), controller.getServer().getStatistics(), controller.getServer().getServerInfo());
				responses.add(response);
			}
		}
		return responses.toArray(new ServerInstance[0]);
	}

	public synchronized int getStatus(AdempiereProcessor processor)
	{
		return getServerStatus(processor.getServerID());
	}
	
	/**
	 * 	Get Server with ID
	 *	@param serverID server id
	 *	@return server or null
	 */
	@Override
	public synchronized ServerInstance getServerInstance(String serverID)
	{
		if (serverID == null)
			return null;
		for (int i = 0; i < m_servers.size(); i++)
		{
			LocalServerController server = m_servers.get(i);
			if (serverID.equals(server.server.getServerID()))
				return new ServerInstance(server.getServer().getServerID(), server.getServer().getModel(), 
						server.isAlive(), server.isInterrupted(), server.getServer().isSleeping(),
						server.getServer().getStartTime(), server.getServer().getStatistics(), server.getServer().getServerInfo());
		}
		return null;
	}	//	getServer
	
	/**
	 * 	Get Server with ID
	 *	@param serverID server id
	 *	@return server or null
	 */
	private synchronized LocalServerController getLocalServerController (String serverID)
	{
		if (serverID == null)
			return null;
		for (int i = 0; i < m_servers.size(); i++)
		{
			LocalServerController server = m_servers.get(i);
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
		StringBuilder sb = new StringBuilder ("AdempiereServerMgr[");
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
	@Override
	public String getDescription()
	{
		return Adempiere.getVersion();
	}	//	getDescription
	
	/**
	 * 	Get Number Servers
	 *	@return no of servers
	 */
	@Override
	public synchronized ServerCount getServerCount()
	{
		ServerCount serverCount = new ServerCount();
		for (int i = 0; i < m_servers.size(); i++)
		{
			LocalServerController server = m_servers.get(i);
			if (server.scheduleFuture != null && !server.scheduleFuture.isDone())
				serverCount.addStarted(1);
			else
				serverCount.addStopped(1);
		}
		return serverCount;
	}	//	getServerCount
	
	/**
	 * 	Get start date
	 *	@return start date
	 */
	@Override
	public Timestamp getStartTime()
	{
		return m_start;
	}	//	getStartTime

	private class LocalServerController implements Runnable
	{

		protected AdempiereServer server;
		protected volatile ScheduledFuture<?> scheduleFuture;

		private LocalServerController(AdempiereServer server) {
			this(server, true);
		}
		
		private LocalServerController(AdempiereServer server, boolean start) {
			this.server = server;
			if (start)
				start();
		}
		
		public void start() {
			scheduleFuture = Adempiere.getThreadPoolExecutor().schedule(this, server.getInitialNap() * 1000 + server.getSleepMS(), TimeUnit.MILLISECONDS);
		}

		@Override
		public void run() {
			if (server.isSleeping()) {
				server.run();
				if (!isInterrupted()) {
					if (server.getSleepMS() != 0) {
						scheduleFuture = Adempiere.getThreadPoolExecutor().schedule(this, server.getSleepMS(), TimeUnit.MILLISECONDS);
					}
				}
			}  else {
				//server busy, try again after one minute
				scheduleFuture = Adempiere.getThreadPoolExecutor().schedule(this, 60 * 1000, TimeUnit.MILLISECONDS);
			}
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

	@Override
	public synchronized IServerFactory<AdempiereServer, AdempiereProcessor> addingService(
			ServiceReference<IServerFactory<AdempiereServer, AdempiereProcessor>> reference) {
		IServerFactory<AdempiereServer, AdempiereProcessor> factory = AdempiereServerActivator.getBundleContext().getService(reference);
		createServers(factory);
		startAll();
		return factory;
	}

	@Override
	public void modifiedService(
			ServiceReference<IServerFactory<AdempiereServer, AdempiereProcessor>> reference,
			IServerFactory<AdempiereServer, AdempiereProcessor> service) {
	}

	@Override
	public void removedService(
			ServiceReference<IServerFactory<AdempiereServer, AdempiereProcessor>> reference,
			IServerFactory<AdempiereServer, AdempiereProcessor> service) {
	}

	@Override
	public void bundleChanged(BundleEvent event) {
		if (event.getType() == BundleEvent.STOPPED) {
			if (serviceTracker != null)
				serviceTracker.close();
		} else if (event.getType() == BundleEvent.STARTED) {
			if (serviceTracker != null)
				serviceTracker.open();
		}
	}

	public Boolean remove(String serverID) {
		LocalServerController server = getLocalServerController(serverID);
		if (server == null)
			return false;
		
		if (server.scheduleFuture != null && !server.scheduleFuture.isDone()) {
			if (stop(serverID) != null) {
				return false;
			}
		}
		
		for (int i = 0; i < m_servers.size(); i++) {
			server = m_servers.get(i);
			if (serverID.equals(server.server.getServerID())) {
				m_servers.remove(i);
				return true;
			}
		}
		
		return false;
	}

	@Override
	public String runNow(String serverId) {
		LocalServerController serverInstance = getLocalServerController(serverId);
		if (serverInstance == null || serverInstance.getServer() == null) {
			return "Server " + serverId + " not found";
		}
		
		if (serverInstance.getServer().isSleeping())
		{
			serverInstance.getServer().runNow();
		}
		else
		{
			int count = 0;
			while(!serverInstance.getServer().isSleeping() && count < 5)
			{
				count++;
				try {
					Thread.sleep(60000);
				} catch (InterruptedException e) {
					Thread.interrupted();
				}				
			}
			if (serverInstance.getServer().isSleeping())
				serverInstance.getServer().runNow();
			else
			{
				return "Timeout waiting for server process to be available for execution.";
			}
		}
		
		return null;
	}
	
	private String getClusterMemberId() {
		IClusterService service = ClusterServerMgr.getClusterService();
		if (service != null) {
			IClusterMember local = service.getLocalMember();
			if (local != null)
				return local.getId();
		}
		return null;
	}
	
	private Map<String, String> getServerOwnerMap() {
		ICacheService service = Core.getCacheService();
		if (service != null) {
			return service.getMap("cluster.server.owner.map");
		}
		return null;
	}
}	//	AdempiereServerMgr
