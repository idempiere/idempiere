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

import java.sql.Timestamp;

/**
 * 
 * @author hengsin
 *
 */
public interface IServerManager {

	public static int SERVER_STATE_NOT_SCHEDULE = 0;
	public static int SERVER_STATE_STARTED = 1;
	public static int SERVER_STATE_STOPPED = 2;

	/**
	 * Get server instance by id
	 * @param serverId
	 * @return ServerInstance or null if not found
	 */
	public ServerInstance getServerInstance(String serverId);
	
	/**
	 * 
	 * @param serverId
	 * @return server status
	 */
	public default int getServerStatus(String serverId) {
		ServerInstance instance = getServerInstance(serverId);
		if (instance == null || instance.getServerId() == null) {
			return SERVER_STATE_NOT_SCHEDULE;
		} else if (instance.isStarted()) {
			return SERVER_STATE_STARTED;
		} else {
			return SERVER_STATE_STOPPED;
		}
	}

	/**
	 * 
	 * @param serverId
	 * @return error
	 */
	public String runNow(String serverId);

	/**
	 * 
	 * @param serverId
	 * @return error
	 */
	public String start(String serverId);

	/**
	 * 
	 * @param serverId
	 * @return error
	 */
	public String stop(String serverId);
	
	/**
	 * @return error
	 */
	public String startAll();
	
	/**
	 * @return error
	 */
	public String stopAll();

	/**
	 * @return error
	 */
	public String reload();

	/**
	 * @return start time stamp
	 */
	public Timestamp getStartTime();

	/**
	 * 
	 * @return ServerCount
	 */
	public ServerCount getServerCount();

	/**
	 * @return all server instances
	 */
	public ServerInstance[] getServerInstances();

	/**
	 * @return description
	 */
	public String getDescription();

}