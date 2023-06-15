/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.compiere.server;

import java.io.Serializable;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.OperatingSystemMXBean;
import java.lang.management.RuntimeMXBean;
import java.lang.management.ThreadMXBean;
import java.net.InetAddress;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.db.AdempiereDatabase;
import org.compiere.db.CConnection;
import org.compiere.model.MSession;
import org.compiere.util.CLogMgt;
import org.compiere.util.CMemoryUsage;
import org.compiere.util.Ini;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.server.cluster.ClusterServerMgr;
import org.idempiere.server.cluster.callable.GetSystemInfoCallable;

/**
 * @author hengsin
 *
 */
public class SystemInfo implements Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4451616690416295597L;
	
	private String propertyFileName;
	private String idempereHome;
	private String operatingSystem;
	private String javaVM;
	private String databaseDescription;
	private String databaseConnectionURL;
	private String databaseStatus;
	private String memoryUsage;
	private String heapMemoryUsage;
	private String runtimeName;
	private long runtimeUpTime;
	private int threadCount;
	private int peakThreadCount;
	private int daemonThreadCount;
	private long totalStartedThreadCount;
	private TrxInfo[] trxInfos;
	private Level logLevel;
	private String currentLogFile;
	private LogFileInfo[] logFileInfos;
	private long garbageCollectionTime;
	private long garbageCollectionCount;
	private int availableProcessors;
	private double averageSystemLoad;

	private int sessionCount;

	private InetAddress address;

	/**
	 * 
	 */
	private SystemInfo() {
	}

	/**
	 * 
	 * @return idempiere property filename
	 */
	public String getPropertyFileName() {
		return propertyFileName;
	}
	
	/**
	 * 
	 * @return idempiere home
	 */
	public String getIDempiereHome() {
		return idempereHome;
	}
	
	/**
	 * @return the operatingSystem
	 */
	public String getOperatingSystem() {
		return operatingSystem;
	}

	/**
	 * @return the javaVM
	 */
	public String getJavaVM() {
		return javaVM;
	}

	/**
	 * @return the databaseDescription
	 */
	public String getDatabaseDescription() {
		return databaseDescription;
	}

	/**
	 * @return the databaseConnectionURL
	 */
	public String getDatabaseConnectionURL() {
		return databaseConnectionURL;
	}

	/**
	 * @return the databaseStatus
	 */
	public String getDatabaseStatus() {
		return databaseStatus;
	}

	/**
	 * @return the memoryUsage
	 */
	public String getMemoryUsage() {
		return memoryUsage;
	}

	/**
	 * @return the heapMemoryUsage
	 */
	public String getHeapMemoryUsage() {
		return heapMemoryUsage;
	}

	/**
	 * @return the runtimeName
	 */
	public String getRuntimeName() {
		return runtimeName;
	}

	/**
	 * @return the runtimeUpTime
	 */
	public long getRuntimeUpTime() {
		return runtimeUpTime;
	}

	/**
	 * @return the threadCount
	 */
	public int getThreadCount() {
		return threadCount;
	}

	/**
	 * @return the peakThreadCount
	 */
	public int getPeakThreadCount() {
		return peakThreadCount;
	}

	/**
	 * @return the daemonThreadCount
	 */
	public int getDaemonThreadCount() {
		return daemonThreadCount;
	}

	/**
	 * @return the totalStartedThreadCount
	 */
	public long getTotalStartedThreadCount() {
		return totalStartedThreadCount;
	}

	/**
	 * @return the trxInfos
	 */
	public TrxInfo[] getTrxInfos() {
		return trxInfos;
	}

	/**
	 * @return the logLevel
	 */
	public Level getLogLevel() {
		return logLevel;
	}

	/**
	 * @return the currentLogFile
	 */
	public String getCurrentLogFile() {
		return currentLogFile;
	}

	/**
	 * @return the logFileInfos
	 */
	public LogFileInfo[] getLogFileInfos() {
		return logFileInfos;
	}

	/**
	 * @return the garbageCollectionTime
	 */
	public long getGarbageCollectionTime() {
		return garbageCollectionTime;
	}
	
	public static SystemInfo getLocalSystemInfo() {
		SystemInfo si = new SystemInfo();
		si.propertyFileName = Ini.getPropertyFileName();
		si.idempereHome = Adempiere.getAdempiereHome();
		OperatingSystemMXBean os = ManagementFactory.getOperatingSystemMXBean();
		String osInfo = os.getName() + " " + os.getVersion();
		osInfo += " (" + os.getArch() + ")";
		si.operatingSystem = osInfo;
		si.availableProcessors = os.getAvailableProcessors();
		if (os instanceof com.sun.management.OperatingSystemMXBean) {
			com.sun.management.OperatingSystemMXBean extInfo = (com.sun.management.OperatingSystemMXBean) os;
			si.averageSystemLoad = extInfo.getSystemCpuLoad() * 100;			
		} else {
			si.averageSystemLoad = (os.getSystemLoadAverage() / si.availableProcessors) * 100;
		}
		
		String vm = System.getProperty("java.vm.name") + " " + System.getProperty("java.vm.version");
		si.javaVM = vm;
		CConnection cc = CConnection.get();
		AdempiereDatabase db = cc.getDatabase();
		si.databaseDescription = db.getDescription();
		si.databaseConnectionURL = cc.getConnectionURL();
		si.databaseStatus = cc.getDatabase().getStatus();
		MemoryMXBean memory = ManagementFactory.getMemoryMXBean();
		si.memoryUsage = new CMemoryUsage(memory.getNonHeapMemoryUsage()).toString();
		si.heapMemoryUsage = new CMemoryUsage(memory.getHeapMemoryUsage()).toString();
		RuntimeMXBean rt = ManagementFactory.getRuntimeMXBean();
		si.runtimeName = rt.getName();
		si.runtimeUpTime = rt.getUptime();
		ThreadMXBean th = ManagementFactory.getThreadMXBean();
		si.threadCount = th.getThreadCount();
		si.peakThreadCount = th.getPeakThreadCount();
		si.daemonThreadCount = th.getDaemonThreadCount();
		si.totalStartedThreadCount = th.getTotalStartedThreadCount();
		si.trxInfos = TrxInfo.getOpenTransactions();
		si.logLevel = CLogMgt.getLevel();
		si.currentLogFile = LogFileInfo.getCurrentLogFile();
		si.logFileInfos = LogFileInfo.getLogFileInfos();
		si.garbageCollectionTime = ManagementFactory.getGarbageCollectorMXBeans().stream().mapToLong(mxBean -> mxBean.getCollectionTime()).sum();
		si.garbageCollectionCount = ManagementFactory.getGarbageCollectorMXBeans().stream().mapToLong(mxBean -> mxBean.getCollectionCount()).sum();
		si.sessionCount = MSession.getCachedSessionCount();
		
		return si;
	}
	
	/**
	 * @return the garbageCollectionCount
	 */
	public long getGarbageCollectionCount() {
		return garbageCollectionCount;
	}

	
	/**
	 * @return the availableProcessors
	 */
	public int getAvailableProcessors() {
		return availableProcessors;
	}

	/**
	 * @return the averageSystemLoad
	 */
	public double getAverageSystemLoad() {
		return averageSystemLoad;
	}
	
	
	/**
	 * @return the sessionCount
	 */
	public int getSessionCount() {
		return sessionCount;
	}

	/**
	 * @return the address
	 */
	public InetAddress getAddress() {
		return address;
	}

	/**
	 * 
	 * @param nodeId
	 * @return systeminfo for cluster node
	 */
	public static SystemInfo getClusterNodeInfo(String nodeId) {
		SystemInfo si = null;
		
		IClusterMember member = ClusterServerMgr.getClusterMember(nodeId);
		if (member != null) {
			GetSystemInfoCallable callable = new GetSystemInfoCallable();
			Future<SystemInfo> future = ClusterServerMgr.getClusterService().execute(callable, member);
			if (future != null) {
				try {
					si = future.get();
					si.address = member.getAddress();
				} catch (InterruptedException | ExecutionException e) {
					throw new RuntimeException(e);
				}
			}
		}
		
		return si;
	}
	
	/**
	 * 
	 * @param member
	 * @return session count for cluster node
	 */
	public static int getClusterSessionCount(IClusterMember member) {
		IClusterService service = ClusterServerMgr.getClusterService();
		if (service != null) {
			GetSessionCountCallable callable = new GetSessionCountCallable();
			Future<Integer> future = service.execute(callable, member);
			if (future != null) {
				try {
					return future.get();
				} catch (InterruptedException | ExecutionException e) {
				}
			}
		}
		return 0;
	}
	
	private static class GetSessionCountCallable implements Callable<Integer>, Serializable {
		private static final long serialVersionUID = -7793108679625240698L;

		@Override
		public Integer call() throws Exception {
			return MSession.getCachedSessionCount();
		}
		
	}
}
