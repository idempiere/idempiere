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
import java.sql.Timestamp;

import org.compiere.model.AdempiereProcessor;
import org.idempiere.distributed.IClusterMember;

/**
 * 
 * @author hengsin
 *
 */
public class ServerInstance implements Serializable {
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -6332080326921128215L;
	
	private String serverId;
	private AdempiereProcessor model;
	private boolean started = false;
	private boolean interrupted = false;
	private boolean sleeping = false;
	private Timestamp startTime;
	private String statistics;
	private String serverInfo;
	private IClusterMember clusterMember;
	
	/**
	 * @param serverId
	 * @param model
	 * @param started
	 * @param interrupted
	 * @param sleeping
	 * @param startTime
	 * @param statistics
	 * @param serverInfo
	 */
	public ServerInstance(String serverId, AdempiereProcessor model, boolean started, boolean interrupted, 
			boolean sleeping, Timestamp startTime, String statistics, String serverInfo) {
		this.serverId = serverId;
		this.model = model;
		this.started = started;
		this.sleeping = sleeping;
		this.startTime = startTime;
		this.statistics = statistics;
		this.serverInfo = serverInfo;
	}
	
	/**
	 * @return is instance started
	 */
	public boolean isStarted() {
		return started;
	}
	
	/**
	 * @return is instance interrupted/stopped
	 */
	public boolean isInterrupted() {
		return interrupted;
	}
	
	/**
	 * is instance idle waiting for next run (at the time of getting this ServerInstance reference)
	 * @return true if instance is idle, false otherwise
	 */
	public boolean isSleeping() {
		return sleeping;
	}
	
	/**
	 * @return latest start time
	 */
	public Timestamp getStartTime() {
		return startTime;	
	}
	
	/**
	 * 	Get Run Statistics
	 *	@return Statistic info
	 */
	public String getStatistics() {
		return statistics;
	}
	
	/**
	 * 	Get Server Info
	 *	@return info
	 */
	public String getServerInfo() {
		return serverInfo;
	}
	
	/**
	 * @return server id
	 */
	public String getServerId() {
		return serverId;
	}

	/**
	 * 
	 * @return {@link AdempiereProcessor}
	 */
	public AdempiereProcessor getModel() {
		return model;
	}
	
	/**
	 * 
	 * @param clusterMember
	 */
	public void setClusterMember(IClusterMember clusterMember) {
		this.clusterMember = clusterMember;
	}
	
	/**
	 * @return {@link IClusterMember}
	 */
	public IClusterMember getClusterMember() {
		return clusterMember;
	}
}