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

import java.io.Serializable;

/**
 * Envelope published on a per-request response topic. Carries either a
 * successful {@code result} or a propagated {@code error}; never both.
 */
public class RpcResponse implements Serializable {

	private static final long serialVersionUID = 1L;

	/** Matches {@link RpcRequest#getTaskId()} on the originator side. */
	private String taskId;

	/** UUID of the node that produced this response. */
	private String memberUuid;

	/** Successful result, or {@code null} if the Callable returned null or threw. */
	private Object result;

	/** Exception thrown by the Callable, or {@code null} on success. */
	private Throwable error;

	/** Required by serialization codecs. Do not call directly. */
	public RpcResponse() {
	}

	public RpcResponse(String taskId, String memberUuid, Object result, Throwable error) {
		if (result != null && error != null) {
			throw new IllegalArgumentException("RpcResponse cannot carry both result and error");
		}
		this.taskId = taskId;
		this.memberUuid = memberUuid;
		this.result = result;
		this.error = error;
	}

	public String getTaskId() {
		return taskId;
	}

	public String getMemberUuid() {
		return memberUuid;
	}

	public Object getResult() {
		return result;
	}

	public Throwable getError() {
		return error;
	}
}
