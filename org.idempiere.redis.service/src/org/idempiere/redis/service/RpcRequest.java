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
* - Norbert Bede, Cloudempiere                                        *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.idempiere.redis.service;

import java.io.Serializable;
import java.util.concurrent.Callable;

/**
 * Envelope published on the cluster-wide RPC request topic. Carries the serialized
 * Callable along with target identification so receiving nodes can decide whether
 * to execute it.
 */
public class RpcRequest implements Serializable {

	private static final long serialVersionUID = 1L;

	/** Random UUID identifying this request; used to route responses back. */
	private String taskId;

	/** UUID of the node that issued the request — informational, useful for logging. */
	private String originatorUuid;

	/** Target node UUIDs. Receivers execute only if their own UUID is in this set. */
	private String[] targetUuids;

	/** Per-request response topic name; receivers publish their {@link RpcResponse} here. */
	private String responseTopic;

	/** The unit of work to execute on each target node. Must be Serializable. */
	private Callable<?> callable;

	/** Required by serialization codecs. Do not call directly. */
	public RpcRequest() {
	}

	public RpcRequest(String taskId, String originatorUuid, String[] targetUuids,
			String responseTopic, Callable<?> callable) {
		this.taskId = taskId;
		this.originatorUuid = originatorUuid;
		this.targetUuids = targetUuids;
		this.responseTopic = responseTopic;
		this.callable = callable;
	}

	public String getTaskId() {
		return taskId;
	}

	public String getOriginatorUuid() {
		return originatorUuid;
	}

	public String[] getTargetUuids() {
		return targetUuids;
	}

	public String getResponseTopic() {
		return responseTopic;
	}

	public Callable<?> getCallable() {
		return callable;
	}
}
