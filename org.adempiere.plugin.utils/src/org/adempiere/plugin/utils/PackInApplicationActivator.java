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
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;

import org.adempiere.base.IDictionaryService;
import org.adempiere.util.ServerContext;
import org.compiere.Adempiere;
import org.compiere.model.MClient;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.Query;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

public class PackInApplicationActivator extends AbstractActivator {

	protected final static CLogger logger = CLogger.getCLogger(PackInApplicationActivator.class.getName());
	private List<File> filesToProcess = new ArrayList<>();
	private File currentFile;
	
	@Override
	public void start(BundleContext context) throws Exception {
		this.context = context;
		if (logger.isLoggable(Level.INFO)) logger.info(getName() + " starting...");
		serviceTracker = new ServiceTracker<IDictionaryService, IDictionaryService>(context, IDictionaryService.class.getName(), this);
		serviceTracker.open();
		start();
		if (logger.isLoggable(Level.INFO)) 
			logger.info(getName() + " ready.");		
	}
	
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

	@Override
	public void stop(BundleContext context) throws Exception {
		stop();
		serviceTracker.close();
		this.context = null;
		if (logger.isLoggable(Level.INFO)) logger.info(context.getBundle().getSymbolicName() + " "
				+ context.getBundle().getHeaders().get("Bundle-Version")
				+ " stopped.");		
	}

	@Override
	public IDictionaryService addingService(ServiceReference<IDictionaryService> reference) {
		service = context.getService(reference);
		if (Adempiere.getThreadPoolExecutor() != null) {
			Adempiere.getThreadPoolExecutor().execute(new Runnable() {			
				@Override
				public void run() {
					automaticPackin();
				}
			});
		} else {
			Adempiere.addServerStateChangeListener(new ServerStateChangeListener() {				
				@Override
				public void stateChange(ServerStateChangeEvent event) {
					if (event.getEventType() == ServerStateChangeEvent.SERVER_START && service != null) {
						automaticPackin();
					}					
				}
			});
		}
		return null;
	}
	
	private void automaticPackin() {
		//Initial delay
		Timer t = new Timer();
		t.schedule(new TimerTask() {
			@Override
			public void run() {
				ClassLoader cl = Thread.currentThread().getContextClassLoader();
				try {
					Thread.currentThread().setContextClassLoader(PackInApplicationActivator.class.getClassLoader());
					setupPackInContext();
					installPackages();
				} finally {
					ServerContext.dispose();
					service = null;
					Thread.currentThread().setContextClassLoader(cl);
				}
				t.cancel();
			}
		}, MSysConfig.getIntValue(MSysConfig.AUTOMATIC_PACKIN_INITIAL_DELAY, 120) * 1000);
	}
	
	private void installPackages() {
		
		String folders = MSysConfig.getValue(MSysConfig.AUTOMATIC_PACKIN_FOLDERS);
		
		if (Util.isEmpty(folders, true)) {
			logger.log(Level.INFO, "Not specified folders for automatic packin");
			return;
		}
		
		File[] fileArray = getFilesToProcess(folders);
		
		if (fileArray.length <= 0) {
			logger.info("No zip files to process");
			return;
		}

		try {
			if (getDBLock()) {
				//Create Session to be able to create records in AD_ChangeLog
				MSession.get(Env.getCtx(), true);
				for(File zipFile : fileArray) {
					currentFile = zipFile;
					if (!packIn(zipFile)) {
						// stop processing further packages if one fail
						break;
					}
					filesToProcess.remove(zipFile);
				}
				releaseLock();
			} else {
				logger.log(Level.SEVERE, "Could not acquire the DB lock to automatically install the packins");
			}
		} catch (AdempiereSystemError e) {
			e.printStackTrace();
		}
		
		if (filesToProcess.size() > 0) {
			logger.warning("The following packages were not applied: ");
			for (File file : filesToProcess) {
				logger.warning(file.getName());
			}
		}
	}
	
	private boolean packIn(File packinFile) {
		if (packinFile != null && service != null) {
			String fileName = packinFile.getName();
			logger.warning("Installing " + fileName + " ...");

			// The convention for package names is: yyyymmddHHMM_ClientValue_InformationalDescription.zip
			String [] parts = fileName.split("_");
			String clientValue = parts[1];
			
			MClient client = getClient(clientValue);
			if (client == null) {
				logger.log(Level.SEVERE, "Client does not exist: " + clientValue);
				return false;
			}

			Env.setContext(Env.getCtx(), "#AD_Client_ID", client.getAD_Client_ID());
			
			try {
			    // call 2pack
				if (!merge(packinFile, null))
					return false;
			} catch (Throwable e) {
				logger.log(Level.SEVERE, "Pack in failed.", e);
				return false;
			}
			logger.warning(packinFile.getPath() + " installed");
		}

		return true;
	}
	
	private File[] getFilesToProcess(String folders) {
		String filePaths[] = null;
		if (folders.indexOf(";") > 0) {
			filePaths = folders.split("[;]");
		} else {
			filePaths = new String[]{folders};
		}
		
		//Add files to the array
		for (String filePath : filePaths) {
			File toProcess = new File(filePath.trim());
			if (!toProcess.exists()) {
				logger.log(Level.SEVERE, filePath + " does not exist");
				continue;
			}
			
			processFilePath(toProcess);
		}
		
		//Verify installed packages and remove those that were installed previously
		verifyInstalledPackages();
		
		File[] fileArray = filesToProcess.toArray(new File[filesToProcess.size()]);
		// Sort files by name
		Arrays.sort(fileArray, new Comparator<File>() {
			@Override
			public int compare(File f1, File f2) {
				return f1.getName().compareTo(f2.getName());
			}
		});

		return fileArray;
	}
	
	private void processFilePath(File toProcess) {
		if (toProcess.isFile()) {
			if (toProcess.getName().toLowerCase().endsWith(".zip"))
				filesToProcess.add(toProcess);
			else {
				logger.log(Level.SEVERE, toProcess.getName() + " is not a valid .zip file");
				return;
			}
		} else if (toProcess.isDirectory()) {
			FileFilter filter = new FileFilter() {
				public boolean accept(File file) {
					if (file.getName().toUpperCase().endsWith(".ZIP") || file.isDirectory())
						return true;
					else
						return false;
				}
			};
			boolean found = false;
			for (File fileToProcess : toProcess.listFiles(filter)) {
				if (!found) {
					logger.info("*** Creating list from folder " + toProcess.toString());
					found = true;
				}
				if (fileToProcess.isDirectory())
					processFilePath(fileToProcess);
				else
					filesToProcess.add(fileToProcess);
			}
			if (!found) {
				logger.log(Level.FINE, toProcess.getName() + " does not have .zip files or subfolders");
				return;
			}
		} else {
			logger.log(Level.SEVERE, toProcess.getName() + " not a file or folder");
		}
	}
	
	private void verifyInstalledPackages() {
		Iterator<File> iterator = filesToProcess.iterator();
		while(iterator.hasNext()){
			currentFile = iterator.next();
			if (installedPackage(null)) {
				logger.log(Level.INFO, currentFile.getName() + " already installed. Removing it from the list...");
				iterator.remove();
			}
		}
	}
	
	private MClient getClient(String clientValue) {
		String where = "Value = ?";
		Query q = new Query(Env.getCtx(), MClient.Table_Name,
				where, null)
				.setParameters(new Object[] {clientValue})
				.setOnlyActiveRecords(true);
		
		return q.first();
	}
	
	@Override
	public void modifiedService(ServiceReference<IDictionaryService> reference, IDictionaryService service) {
	}

	@Override
	public void removedService(ServiceReference<IDictionaryService> reference, IDictionaryService service) {
	}

	@Override
	public String getName() {
		if (currentFile != null)
			return currentFile.getName();
		else
			return "";
	}
	
	protected void setupPackInContext() {
		Properties serverContext = new Properties();
		serverContext.setProperty("#AD_Client_ID", "0");
		ServerContext.setCurrentInstance(serverContext);
	};

}
