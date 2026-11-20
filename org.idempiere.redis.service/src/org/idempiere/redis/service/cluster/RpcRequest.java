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
package org.idempiere.redis.service.cluster;

import java.util.concurrent.Callable;

/**
 * A cluster RPC request on the sending node, before it is put into an {@link RpcFrame}.
 *
 * <p>On the wire the routing data (task id, originator, targets, reply flag) is in the frame
 * header and the callable is the frame payload. When {@code rpc.hmac.secret} is set, the HMAC
 * covers all of it and is checked before the callable is decoded; see {@link RpcFrame}.</p>
 *
 * @since iDempiere 11 / IDEMPIERE-6989
 */
public class RpcRequest {

	/** Random UUID identifying this request; used to route responses back. */
	private final String taskId;

	/** UUID of the node that issued the request; responses go to a topic derived from it. */
	private final String originatorUuid;

	/** Target node UUIDs. Receivers execute only if their own UUID is in this set. */
	private final String[] targetUuids;

	/** {@code false} for a fire-and-forget notification: the receivers send no response. */
	private final boolean replyExpected;

	/** The unit of work to execute on each target node. */
	private final Callable<?> callable;

	public RpcRequest(String taskId, String originatorUuid, String[] targetUuids, boolean replyExpected,
			Callable<?> callable) {
		this.taskId = taskId;
		this.originatorUuid = originatorUuid;
		this.targetUuids = targetUuids.clone();
		this.replyExpected = replyExpected;
		this.callable = callable;
	}

	public String getTaskId() {
		return taskId;
	}

	public String getOriginatorUuid() {
		return originatorUuid;
	}

	public String[] getTargetUuids() {
		return targetUuids.clone();
	}

	public boolean isReplyExpected() {
		return replyExpected;
	}

	public Callable<?> getCallable() {
		return callable;
	}
}
