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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;

import org.adempiere.util.ServerContext;
import org.compiere.Adempiere;
import org.compiere.model.MClient;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.Query;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;

public class PackInApplicationActivator extends AbstractActivator{

	protected final static CLogger logger = CLogger.getCLogger(PackInApplicationActivator.class.getName());
	private List<File> filesToProcess = new ArrayList<>();
	private File currentFile;

	public void automaticPackin(int timeout, String folders, boolean fromService) {
		if (fromService) {
			//Initial delay - starting from service
			Timer t = new Timer();
			t.schedule(new TimerTask() {
				@Override
				public void run() {
				  if (! "Y".equals(Env.getContext(Env.getCtx(), "org.adempiere.base.PackInFolderApplication"))) {
					ClassLoader cl = Thread.currentThread().getContextClassLoader();
					try {
						Thread.currentThread().setContextClassLoader(PackInApplicationActivator.class.getClassLoader());
						setupPackInContext();
						installPackages(folders);
					} finally {
						ServerContext.dispose();
						service = null;
						Thread.currentThread().setContextClassLoader(cl);
					}
				  }
				  t.cancel();
				}
			}, timeout);
		} else {
			// No delay - starting from process
			ClassLoader cl = Thread.currentThread().getContextClassLoader();
			try {
				Thread.currentThread().setContextClassLoader(PackInApplicationActivator.class.getClassLoader());
				setupPackInContext();
				installPackages(folders);
			} finally {
				ServerContext.dispose();
				Thread.currentThread().setContextClassLoader(cl);
			}
		}
	}
	
	private void installPackages(String folders) {
		if (Util.isEmpty(folders, true)) {
			setSummary(Level.INFO, "Not specified folders for automatic packin");
			return;
		}
		
		File[] fileArray = getFilesToProcess(folders);
		
		if (fileArray.length <= 0) {
			setSummary(Level.INFO, "No zip files to process");
			return;
		}

		try {
			if (getDBLock()) {
				//Create Session to be able to create records in AD_ChangeLog
				if (Env.getContextAsInt(Env.getCtx(), Env.AD_SESSION_ID) <= 0)
					MSession.get(Env.getCtx(), true);
				for(File zipFile : fileArray) {
					currentFile = zipFile;
					if (!packIn(zipFile)) {
						// stop processing further packages if one fail
						String msg = "Failed application of " + zipFile;
						addLog(Level.WARNING, msg);
						if (getProcessInfo() != null) {
							getProcessInfo().setError(true);
							getProcessInfo().setSummary("@Error@: " + msg);
						}
						break;
					}
					addLog(Level.INFO, "Successful application of " + zipFile);
					filesToProcess.remove(zipFile);
				}
			} else {
				addLog(Level.WARNING, "Could not acquire the DB lock to automatically install the packins");
				return;
			}
		} catch (AdempiereSystemError e) {
			e.printStackTrace();
			addLog(Level.WARNING, e.getLocalizedMessage());
		} finally {
			releaseLock();
		}
		
		if (filesToProcess.size() > 0) {
			StringBuilder pending = new StringBuilder("The following packages were not applied: ");
			for (File file : filesToProcess) {
				pending.append("\n").append(file.getName());
			}
			addLog(Level.WARNING, pending.toString());
		}
	}
	
	private boolean packIn(File packinFile) {
		if (packinFile != null) {
			String fileName = packinFile.getName();
			logger.warning("Installing " + fileName + " ...");

			// The convention for package names is: yyyymmddHHMM_ClientValue_InformationalDescription.zip
			String [] parts = fileName.split("_");
			String clientValue = parts[1];
			
			boolean allClients = clientValue.startsWith("ALL-CLIENTS");
			
			int[] clientIDs;
			if (allClients) {
				int[] seedClientIDs = new int[0];
				String seedClientValue = "";
				if (clientValue.startsWith("ALL-CLIENTS-")) {
					seedClientValue = clientValue.split("-")[2];
					seedClientIDs = getClientIDs(seedClientValue);				
					if (seedClientIDs.length == 0) {
						logger.log(Level.WARNING, "Seed client does not exist: " + seedClientValue);
						return false;
					}
				}
				int[] allClientIDs = new Query(Env.getCtx(), MClient.Table_Name, "AD_Client_ID>0 AND Value!=?", null)
						.setOnlyActiveRecords(true)
						.setParameters(seedClientValue)
						.setOrderBy("AD_Client_ID")
						.getIDs();
				// Process first the seed client, put seed in front of the array
				int shift = 0;
				if (seedClientIDs.length > 0)
					shift = 1;
				clientIDs = new int[allClientIDs.length + shift];
				if (seedClientIDs.length > 0)
					clientIDs[0] = seedClientIDs[0];
				for (int i = 0; i < allClientIDs.length; i++) {
					clientIDs[i+shift] = allClientIDs[i];
				}
			} else {
				clientIDs = getClientIDs(clientValue);
				if (clientIDs.length == 0) {
					logger.log(Level.WARNING, "Client does not exist: " + clientValue);
					return false;
				}
			}

			for (int clientID : clientIDs) {
				MClient client = MClient.get(Env.getCtx(), clientID);
				if  (allClients) {
					String message = "Installing " + fileName + " in client " + client.getValue() + "/" + client.getName();
					statusUpdate(message);
				}
				Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, client.getAD_Client_ID());
				try {
				    // call 2pack
					if (service != null) {
						if (!merge(packinFile, null)) {
							return false;
						}
					} else {
						if (!directMerge(packinFile, null)) {
							return false;
						}
					}
				} catch (Throwable e) {
					logger.log(Level.WARNING, "Pack in failed.", e);
					return false;
				} finally {
					Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, 0);
				}
				logger.warning(packinFile.getPath() + " installed");
			}
			if (allClients ) {
				// when arriving here it means an ALL-CLIENTS 2pack was processed successfully
				// register a record on System to avoid future reprocesses of the same file
				X_AD_Package_Imp_Proc pimpr = new X_AD_Package_Imp_Proc(Env.getCtx(), 0, null);
				pimpr.setName(fileName);
				pimpr.setDateProcessed(new Timestamp(System.currentTimeMillis()));
				pimpr.setP_Msg("This ALL-CLIENT 2Pack was applied successfully in all tenants");
				pimpr.setAD_Package_Source_Type(X_AD_Package_Imp_Proc.AD_PACKAGE_SOURCE_TYPE_File);
				pimpr.saveEx();
				X_AD_Package_Imp pimp = new X_AD_Package_Imp(Env.getCtx(), 0, null);
				pimp.setAD_Package_Imp_Proc_ID(pimpr.getAD_Package_Imp_Proc_ID());
				pimp.setName(fileName);
				pimp.setPK_Status("Completed successfully");
				pimp.setDescription("This ALL-CLIENT 2Pack was applied successfully in all tenants");
				pimp.setProcessed(true);
				pimp.saveEx();
			}
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
				addLog(Level.WARNING, filePath + " does not exist");
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
		if (toProcess.isFile() && toProcess.canRead()) {
			if (toProcess.getName().toLowerCase().endsWith(".zip"))
				filesToProcess.add(toProcess);
			else {
				logger.log(Level.WARNING, toProcess.getName() + " is not a valid .zip file");
				return;
			}
		} else if (toProcess.isDirectory() && toProcess.canRead()) {
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
				if (fileToProcess.isDirectory()) {
					processFilePath(fileToProcess);
				} else {
					if (fileToProcess.canRead()) {
						filesToProcess.add(fileToProcess);
					} else {
						addLog(Level.WARNING, fileToProcess.getName() + " not readable");
					}
				}
			}
			if (!found) {
				logger.log(Level.FINE, toProcess.getName() + " does not have .zip files or subfolders");
				return;
			}
		} else {
			addLog(Level.WARNING, toProcess.getName() + " not a file or folder or not readable");
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
	
	private int[] getClientIDs(String clientValue) {
		String where = "Value = ?";
		Query q = new Query(Env.getCtx(), MClient.Table_Name, where, null)
				.setParameters(clientValue)
				.setOnlyActiveRecords(true);
		return q.getIDs();
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
		serverContext.setProperty(Env.AD_CLIENT_ID, "0");
		ServerContext.setCurrentInstance(serverContext);
	}

	@Override
	protected void frameworkStarted() {
		if (service != null) {
			if (Adempiere.getThreadPoolExecutor() != null) {
				Adempiere.getThreadPoolExecutor().execute(new Runnable() {			
					@Override
					public void run() {
						int timeout = MSysConfig.getIntValue(MSysConfig.AUTOMATIC_PACKIN_INITIAL_DELAY, 120) * 1000;
						String folders = MSysConfig.getValue(MSysConfig.AUTOMATIC_PACKIN_FOLDERS);
						automaticPackin(timeout, folders, true);
					}
				});
			} else {
				Adempiere.addServerStateChangeListener(new ServerStateChangeListener() {				
					@Override
					public void stateChange(ServerStateChangeEvent event) {
						if (event.getEventType() == ServerStateChangeEvent.SERVER_START && service != null) {
							int timeout = MSysConfig.getIntValue(MSysConfig.AUTOMATIC_PACKIN_INITIAL_DELAY, 120) * 1000;
							String folders = MSysConfig.getValue(MSysConfig.AUTOMATIC_PACKIN_FOLDERS);
							automaticPackin(timeout, folders, true);
						}					
					}
				});
			}
		}
	};

}
