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
import java.util.concurrent.Callable;

/**
 * Envelope published on the cluster-wide RPC request topic. Carries the serialized
 * Callable along with target identification so receiving nodes can decide whether
 * to execute it.
 *
 * <h3>Security considerations — read before extending or deploying</h3>
 *
 * <p>This class carries an arbitrary {@link Callable} that every targeted cluster
 * node will deserialize and execute. The attack surface is therefore:
 * <ul>
 *   <li><b>Deserialization RCE</b> — Kryo gadget-chain attacks (see CVE-2023-42809):
 *       any principal that can publish to the Redis RPC topic can inject a Callable
 *       that executes arbitrary code on every node. Mitigate by:
 *       <ol>
 *         <li>Setting {@code rpc.callable.allowlist} in {@code redis.properties} to the
 *             fully-qualified class names of every legitimate Callable implementation.
 *             The bundle then uses {@link AllowlistKryo5Codec} with
 *             {@code setRegistrationRequired(true)}, rejecting all other types.</li>
 *         <li>Locking Redis network access with TLS and Redis ACLs so only iDempiere
 *             cluster nodes can connect and publish to the topic.</li>
 *       </ol>
 *   </li>
 *   <li><b>Message forgery</b> — without authentication, any node with Redis credentials
 *       can impersonate the originator. Mitigate by setting {@code rpc.hmac.secret} in
 *       {@code redis.properties}. All nodes sharing the secret will reject envelopes
 *       with a missing or invalid {@link #hmac} field before deserializing the Callable.</li>
 * </ul>
 *
 * <p><b>Production checklist:</b> set {@code rpc.callable.allowlist},
 * {@code rpc.hmac.secret}, enforce Redis TLS + ACLs, and do not expose Redis
 * ports on a flat network. Omitting any of these in a multi-tenant or internet-adjacent
 * deployment is a critical risk.</p>
 *
 * @since iDempiere 11 / IDEMPIERE-6989
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

	/**
	 * HMAC-SHA256 of {@code taskId + "|" + originatorUuid}, base64-encoded.
	 * {@code null} when HMAC is not configured ({@code rpc.hmac.secret} unset).
	 */
	private String hmac;

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

	public String getHmac() {
		return hmac;
	}

	public void setHmac(String hmac) {
		this.hmac = hmac;
	}
}
