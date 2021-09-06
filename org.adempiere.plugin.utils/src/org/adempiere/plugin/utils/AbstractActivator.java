/******************************************************************************
 * Copyright (C) 2017 Diego Ruiz                                              *
 * Copyright (C) 2017 Trek Global                 							  *
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
package org.adempiere.plugin.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.IDictionaryService;
import org.adempiere.util.IProcessUI;
import org.compiere.Adempiere;
import org.compiere.model.MClient;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.process.ProcessInfo;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkEvent;
import org.osgi.framework.FrameworkListener;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;
import org.osgi.util.tracker.ServiceTrackerCustomizer;

public abstract class AbstractActivator implements BundleActivator, ServiceTrackerCustomizer<IDictionaryService, IDictionaryService>, FrameworkListener{

	protected final static CLogger logger = CLogger.getCLogger(AbstractActivator.class.getName());
	protected BundleContext context;
	protected ServiceTracker<IDictionaryService, IDictionaryService> serviceTracker;
	protected IDictionaryService service;
	private String trxName = null;
	private ProcessInfo m_processInfo = null;
	private IProcessUI m_processUI = null;
	private final static Object mutex = new Object();
	private static boolean isFrameworkStarted = false;
	

	@Override
	public void start(BundleContext context) throws Exception {
		this.context = context;
		if (logger.isLoggable(Level.INFO)) logger.info(getName() + " " + getVersion() + " starting...");
		serviceTracker = new ServiceTracker<IDictionaryService, IDictionaryService>(context, IDictionaryService.class.getName(), this);
		serviceTracker.open();
		if (!isFrameworkStarted())
			context.addFrameworkListener(this);
		start();
		if (logger.isLoggable(Level.INFO)) logger.info(getName() + " " + getVersion() + " ready.");
	}
	
	@Override
	public void stop(BundleContext context) throws Exception {
		stop();
		serviceTracker.close();
		context.removeFrameworkListener(this);
		this.context = null;
		if (logger.isLoggable(Level.INFO)) logger.info(context.getBundle().getSymbolicName() + " "
				+ context.getBundle().getHeaders().get("Bundle-Version")
				+ " stopped.");
	}
	
	protected boolean merge(File zipfile, String version) throws Exception {
		boolean success = false;

		if (!installedPackage(version)) {
			service.merge(context, zipfile);
			success = true;
		} else {
			logger.log(Level.WARNING, "The file was previously installed: " + zipfile.getName());
		}

		return success;
	}

	protected boolean directMerge(File zipfile, String version) throws Exception {
		boolean success = false;

		if (!installedPackage(version)) {
			IDictionaryService ids = Core.getDictionaryService();
			if (ids != null) {
				ids.merge(null, zipfile);
				success = true;
				if (ids.getAD_Package_Imp_Proc() != null) {
					MClient client = MClient.get(Env.getCtx());
					addLog(Level.INFO, getName() + " in " + client.getValue() + " -> "+ ids.getAD_Package_Imp_Proc().getP_Msg());
				}
			} else {
				addLog(Level.SEVERE, "Could not find an IDictionaryService to process the zip files");
			}
		} else {
			addLog(Level.WARNING, "The file was previously installed: " + zipfile.getName());
			success = true;
		}

		return success;
	}

	protected boolean installedPackage(String version) {
		StringBuilder where = new StringBuilder("AD_Client_ID=? AND Name=? AND PK_Status='Completed successfully'");
		List<Object> params = new ArrayList<Object>();
		String fileName = getName();
		int clientId = Env.getAD_Client_ID(Env.getCtx());
		if (version == null) {
			String [] parts = fileName.split("_");
			String clientValue = parts[1];
			clientId = DB.getSQLValueEx(null, "SELECT AD_Client_ID FROM AD_Client WHERE Value=?", clientValue);
			if (clientId < 0)
				clientId = 0;
		}
		params.add(clientId);
		params.add(fileName);
		if (version != null) {
			where.append(" AND PK_Version LIKE ?");
			params.add(version +  "%");
		}
		Query q = new Query(Env.getCtx(), X_AD_Package_Imp.Table_Name, where.toString(), null)
				.setParameters(params);
		return q.match();
	}

	public abstract String getName();

	public boolean getDBLock() throws AdempiereSystemError {
		int timeout = MSysConfig.getIntValue(MSysConfig.AUTOMATIC_PACKIN_TIMEOUT, 120);
		int maxAttempts = MSysConfig.getIntValue(MSysConfig.AUTOMATIC_PACKIN_RETRIES, 5);
		boolean lockAcquired = false;

		while(maxAttempts > 0 && !lockAcquired) {
			maxAttempts --;
			if (logger.isLoggable(Level.INFO)) logger.log(Level.INFO, "Acquiring lock with timeout " + timeout + " for " + getName() + " / remaining attempts " + maxAttempts);
			try {
				if (getDBLock(timeout))
					lockAcquired = true;
			} catch (Exception e) {
				// Timeout throws DBException, ignore and try again
				releaseLock();
			}
		}

		return lockAcquired;
	}

	public void releaseLock() {
		if (trxName != null) {
			Trx.get(trxName, false).close();
			trxName = null;
		}
	}

	private boolean getDBLock(int timeout) throws AdempiereSystemError {
		return DB.getDatabase().forUpdate(getLockPO(), timeout);
	}

	private PO getLockPO() throws AdempiereSystemError {
		MSysConfig sysconfig = new Query(Env.getCtx(), MSysConfig.Table_Name, 
				"Name=? AND AD_Client_ID=0", null)
				.setParameters(MSysConfig.AUTOMATIC_PACKIN_PROCESSING)
				.firstOnly();
		if (sysconfig == null) {
			 throw new AdempiereSystemError(MSysConfig.AUTOMATIC_PACKIN_PROCESSING + " SysConfig does not exist");
		}
		
		trxName = Trx.createTrxName("ActSysTrx");
		Trx.get(trxName, true).setDisplayName(getClass().getName()+"_getLockPO");
		sysconfig.set_TrxName(trxName);
		return sysconfig;
	}

	public void setProcessInfo(ProcessInfo processInfo) {
		m_processInfo  = processInfo;
	}

	public ProcessInfo getProcessInfo() {
		return m_processInfo;
	}

	public void setProcessUI(IProcessUI processUI) {
		m_processUI  = processUI;
	};

	protected void statusUpdate(String message) {
		logger.warning(message);
		if (m_processUI != null)
			m_processUI.statusUpdate(message);
	}

	public void addLog(Level level, String msg) {
		logger.log(level, msg);
		if (m_processInfo != null)
			m_processInfo.addLog(0, null, null, msg.replaceAll("\\n", "<br>"));
	}

	public void setSummary(Level level, String msg) {
		logger.log(level, msg);
		if (m_processInfo != null)
			m_processInfo.setSummary(msg);
	}
	
	@Override
	public void frameworkEvent(FrameworkEvent event) {
		if (event.getType() == FrameworkEvent.STARTLEVEL_CHANGED) {
			synchronized(mutex) {
				isFrameworkStarted = true;
				frameworkStarted();
			}
		}
	}
	
	public static Boolean isFrameworkStarted() {
		synchronized(mutex) {
	        return isFrameworkStarted;
	    }
	}
	
	protected abstract void frameworkStarted();

	/**
	 * call when bundle have been started ( after this.context have been set )
	 */
	protected void start() {
	};

	/**
	 * call when bundle is stop ( before this.context is set to null )
	 */
	protected void stop() {
	}
	
	public String getVersion() {
		return "";
	}
	
	@Override
	public IDictionaryService addingService(
			ServiceReference<IDictionaryService> reference) {
		Runnable runnable = () -> {
			service = context.getService(reference);
			if (isFrameworkStarted())
				frameworkStarted ();
		};
		if (Adempiere.getThreadPoolExecutor() != null) {
			Adempiere.getThreadPoolExecutor().submit(runnable);
		} else {
			MyServerStateChangeListener l = new MyServerStateChangeListener(runnable);
			Adempiere.addServerStateChangeListener(l);
		}
		return null;
	}

	@Override
	public void modifiedService(ServiceReference<IDictionaryService> reference,
			IDictionaryService service) {
	}

	@Override
	public void removedService(ServiceReference<IDictionaryService> reference,
			IDictionaryService service) {
	}
	
	private class MyServerStateChangeListener implements ServerStateChangeListener {
		private Runnable runnable;
		private MyServerStateChangeListener(Runnable r) {
			this.runnable = r;
		}
		@Override
		public void stateChange(ServerStateChangeEvent e) {
			if (e.getEventType() == ServerStateChangeEvent.SERVER_START) {
				Adempiere.getThreadPoolExecutor().submit(runnable);
				Adempiere.removeServerStateChangeListener(this);
			}			
		}		
	}
}
