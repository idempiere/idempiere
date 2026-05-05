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

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.Callable;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicReference;

import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.redis.service.cluster.ClusterMember;
import org.idempiere.redis.service.cluster.RpcRequest;
import org.idempiere.redis.service.cluster.RpcResponse;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.redisson.api.RBucket;
import org.redisson.api.RKeys;
import org.redisson.api.RTopic;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Redis-backed implementation of {@link IClusterService}.
 *
 * <p><b>Membership</b> uses heartbeat keys: each running JVM writes
 * <code>&lt;prefix&gt;cluster:members:&lt;uuid&gt;</code> with a 30-second TTL,
 * refreshed every 10 seconds by a daemon scheduler. {@link #getMembers()} scans
 * Redis for keys under that namespace and returns the live members. A node that
 * crashes stops refreshing; the key TTL-expires and the node naturally drops
 * from {@code getMembers()}.</p>
 *
 * <p><b>Distributed compute</b> ({@link #execute}) uses topic-RPC on Redis pub/sub.
 * Originators publish an {@link RpcRequest} on a global request topic, target
 * members execute and publish an {@link RpcResponse} on a per-request response
 * topic, and each {@link Future} resolves as its node responds. A configurable
 * timeout (default 60 s, override via {@code idempiere.cluster.rpc.timeout})
 * fails any unfilled futures.</p>
 *
 * <p><b>Callable serialization</b>: Callables passed to {@code execute} must be
 * {@link java.io.Serializable}. The bundle's {@code DynamicImport-Package} entry
 * provides classloader access to whichever bundle defines the Callable's class
 * so deserialization on receiving nodes succeeds.</p>
 */
@Component(
		service = IClusterService.class,
		immediate = true,
		enabled = false,
		property = "service.ranking:Integer=100")
public class ClusterServiceImpl implements IClusterService {

	private static final Logger log = LoggerFactory.getLogger(ClusterServiceImpl.class);

	private static final String MEMBERS_KEY_SUFFIX = "cluster:members:";
	private static final String RPC_REQUEST_TOPIC_SUFFIX = "cluster:rpc:request";
	private static final String RPC_RESPONSE_TOPIC_PREFIX = "cluster:rpc:response:";

	private static final long HEARTBEAT_TTL_SECONDS = 30L;
	private static final long HEARTBEAT_PERIOD_SECONDS = 10L;
	private static final long DEFAULT_RPC_TIMEOUT_SECONDS = 60L;

	private final AtomicReference<ClusterMember> localMember = new AtomicReference<>();
	private final ConcurrentMap<String, PendingRequest> pending = new ConcurrentHashMap<>();

	private volatile ScheduledExecutorService heartbeatExecutor;
	private volatile ScheduledExecutorService timeoutExecutor;
	private volatile RTopic requestTopic;
	private volatile int requestListenerId = -1;
	private volatile long rpcTimeoutSeconds = DEFAULT_RPC_TIMEOUT_SECONDS;

	@Activate
	void activate() {
		try {
			ClusterMember self = createLocalMember();
			localMember.set(self);
			rpcTimeoutSeconds = resolveRpcTimeout();
			startHeartbeat();
			subscribeToRequestTopic();
			log.info("Redis cluster service activated; local member: {}", self);
		} catch (Exception e) {
			log.error("Failed to activate Redis cluster service — cluster operations will fail", e);
		}
	}

	@Deactivate
	void deactivate() {
		stopHeartbeat();
		unsubscribeFromRequestTopic();
		failAllPending(new IllegalStateException("Bundle deactivating"));
		ClusterMember self = localMember.getAndSet(null);
		if (self != null) {
			try {
				Activator.getRedissonClient().getBucket(memberKey(self.getId())).delete();
				log.info("Redis cluster service deactivated; removed local member {}", self.getId());
			} catch (Exception e) {
				log.warn("Failed to delete heartbeat key during deactivation; relying on TTL", e);
			}
		}
	}

	// --------------------------------------------------------------- Membership

	@Override
	public Collection<IClusterMember> getMembers() {
		ClusterMember self = localMember.get();
		if (self == null) {
			return Collections.emptyList();
		}
		try {
			RedissonClient client = Activator.getRedissonClient();
			RKeys keys = client.getKeys();
			String pattern = membersKeyPrefix() + "*";
			Collection<IClusterMember> members = new ArrayList<>();
			for (String key : keys.getKeysByPattern(pattern)) {
				RBucket<ClusterMember> bucket = client.getBucket(key);
				ClusterMember m = bucket.get();
				if (m != null) {
					members.add(m);
				}
			}
			return members;
		} catch (Exception e) {
			log.warn("getMembers failed; returning local member only", e);
			return Collections.singletonList(self);
		}
	}

	@Override
	public IClusterMember getLocalMember() {
		return localMember.get();
	}

	// ------------------------------------------------------- Distributed compute

	@Override
	public <V> Future<V> execute(Callable<V> task, IClusterMember member) {
		Objects.requireNonNull(member, "member must not be null");
		Map<IClusterMember, Future<V>> map = execute(task, Collections.singletonList(member));
		return map.values().iterator().next();
	}

	@Override
	public <V> Map<IClusterMember, Future<V>> execute(Callable<V> task, Collection<IClusterMember> members) {
		Objects.requireNonNull(task, "task must not be null");
		Objects.requireNonNull(members, "members must not be null");
		if (members.isEmpty()) {
			return Collections.emptyMap();
		}
		ClusterMember self = localMember.get();
		if (self == null) {
			throw new IllegalStateException("Cluster service is not activated");
		}

		String taskId = UUID.randomUUID().toString();
		String responseTopicName = rpcResponseTopicName(taskId);

		Map<IClusterMember, CompletableFuture<V>> futures = new LinkedHashMap<>();
		String[] targetUuids = new String[members.size()];
		int idx = 0;
		for (IClusterMember m : members) {
			futures.put(m, new CompletableFuture<>());
			targetUuids[idx++] = m.getId();
		}

		RedissonClient client = Activator.getRedissonClient();
		RTopic responseTopic = client.getTopic(responseTopicName);
		int listenerId = responseTopic.addListener(RpcResponse.class,
				(channel, response) -> handleResponse(response));

		@SuppressWarnings({"rawtypes", "unchecked"})
		PendingRequest pr = new PendingRequest((Map) futures, responseTopic, listenerId);
		pending.put(taskId, pr);

		ScheduledExecutorService te = timeoutExecutor;
		if (te != null) {
			te.schedule(() -> failPendingByTimeout(taskId), rpcTimeoutSeconds, TimeUnit.SECONDS);
		}

		try {
			RpcRequest request = new RpcRequest(taskId, self.getId(), targetUuids, responseTopicName, task);
			requestTopic.publish(request);
		} catch (Exception e) {
			pending.remove(taskId);
			pr.unsubscribe();
			IllegalStateException wrap = new IllegalStateException(
					"Failed to publish RPC request — Callable may not be Serializable, or Redis is unavailable", e);
			for (CompletableFuture<V> f : futures.values()) {
				f.completeExceptionally(wrap);
			}
		}

		@SuppressWarnings({"rawtypes", "unchecked"})
		Map<IClusterMember, Future<V>> result = (Map) futures;
		return result;
	}

	// ---------------------------------------------------------------- Internals

	private void startHeartbeat() {
		heartbeatExecutor = Executors.newSingleThreadScheduledExecutor(daemonThreadFactory("redis-cluster-heartbeat"));
		heartbeatExecutor.scheduleAtFixedRate(this::heartbeat,
				0L, HEARTBEAT_PERIOD_SECONDS, TimeUnit.SECONDS);
	}

	private void stopHeartbeat() {
		ScheduledExecutorService exec = heartbeatExecutor;
		heartbeatExecutor = null;
		if (exec != null) {
			exec.shutdownNow();
		}
	}

	private void heartbeat() {
		ClusterMember self = localMember.get();
		if (self == null) {
			return;
		}
		try {
			RBucket<ClusterMember> bucket = Activator.getRedissonClient().getBucket(memberKey(self.getId()));
			bucket.set(self, Duration.ofSeconds(HEARTBEAT_TTL_SECONDS));
		} catch (Exception e) {
			log.warn("Heartbeat write failed; node may disappear from getMembers within {} s", HEARTBEAT_TTL_SECONDS, e);
		}
	}

	private void subscribeToRequestTopic() {
		try {
			timeoutExecutor = Executors.newSingleThreadScheduledExecutor(daemonThreadFactory("redis-cluster-rpc-timeout"));
			requestTopic = Activator.getRedissonClient().getTopic(rpcRequestTopicName());
			requestListenerId = requestTopic.addListener(RpcRequest.class,
					(channel, request) -> handleRequest(request));
		} catch (Exception e) {
			log.error("Failed to subscribe to RPC request topic — execute() will not work", e);
		}
	}

	private void unsubscribeFromRequestTopic() {
		RTopic topic = requestTopic;
		int id = requestListenerId;
		requestTopic = null;
		requestListenerId = -1;
		if (topic != null && id != -1) {
			try {
				topic.removeListener(id);
			} catch (Exception ignored) {
				// best effort
			}
		}
		ScheduledExecutorService te = timeoutExecutor;
		timeoutExecutor = null;
		if (te != null) {
			te.shutdownNow();
		}
	}

	private void handleRequest(RpcRequest request) {
		ClusterMember self = localMember.get();
		if (self == null) {
			return;
		}
		if (!isTargeted(request, self)) {
			return;
		}
		Object result = null;
		Throwable error = null;
		try {
			result = request.getCallable().call();
		} catch (Throwable t) {
			error = t;
		}
		try {
			RpcResponse response = new RpcResponse(request.getTaskId(), self.getId(), result, error);
			Activator.getRedissonClient().getTopic(request.getResponseTopic()).publish(response);
		} catch (Exception e) {
			log.warn("Failed to publish RPC response for task {} from {}", request.getTaskId(), self.getId(), e);
		}
	}

	private static boolean isTargeted(RpcRequest request, ClusterMember self) {
		String[] uuids = request.getTargetUuids();
		if (uuids == null) {
			return false;
		}
		for (String uuid : uuids) {
			if (self.getId().equals(uuid)) {
				return true;
			}
		}
		return false;
	}

	private void handleResponse(RpcResponse response) {
		PendingRequest pr = pending.get(response.getTaskId());
		if (pr == null) {
			// Late response after timeout — drop silently.
			return;
		}
		boolean done = pr.deliver(response);
		if (done) {
			pending.remove(response.getTaskId());
			pr.unsubscribe();
		}
	}

	private void failPendingByTimeout(String taskId) {
		PendingRequest pr = pending.remove(taskId);
		if (pr != null) {
			pr.failRemaining(new TimeoutException("RPC timed out after " + rpcTimeoutSeconds + " s"));
			pr.unsubscribe();
		}
	}

	private void failAllPending(Throwable cause) {
		for (PendingRequest pr : pending.values()) {
			pr.failRemaining(cause);
			pr.unsubscribe();
		}
		pending.clear();
	}

	// ----------------------------------------------------- Local member helpers

	private static ClusterMember createLocalMember() throws UnknownHostException {
		String id = UUID.randomUUID().toString();
		InetAddress address = resolveLocalAddress();
		int port = resolveLocalPort();
		return new ClusterMember(id, address, port);
	}

	private static InetAddress resolveLocalAddress() throws UnknownHostException {
		String override = System.getProperty("idempiere.cluster.address");
		if (override != null && !override.isBlank()) {
			return InetAddress.getByName(override.trim());
		}
		return InetAddress.getLocalHost();
	}

	private static int resolveLocalPort() {
		String override = System.getProperty("idempiere.cluster.port");
		if (override != null && !override.isBlank()) {
			try {
				return Integer.parseInt(override.trim());
			} catch (NumberFormatException ignored) {
				log.warn("idempiere.cluster.port='{}' is not a valid integer; defaulting to 0", override);
			}
		}
		return 0;
	}

	private static long resolveRpcTimeout() {
		String override = System.getProperty("idempiere.cluster.rpc.timeout");
		if (override != null && !override.isBlank()) {
			try {
				long v = Long.parseLong(override.trim());
				if (v > 0) {
					return v;
				}
				log.warn("idempiere.cluster.rpc.timeout='{}' must be positive; defaulting to {} s", override, DEFAULT_RPC_TIMEOUT_SECONDS);
			} catch (NumberFormatException ignored) {
				log.warn("idempiere.cluster.rpc.timeout='{}' is not a valid number; defaulting to {} s", override, DEFAULT_RPC_TIMEOUT_SECONDS);
			}
		}
		return DEFAULT_RPC_TIMEOUT_SECONDS;
	}

	private static java.util.concurrent.ThreadFactory daemonThreadFactory(String name) {
		return r -> {
			Thread t = new Thread(r, name);
			t.setDaemon(true);
			return t;
		};
	}

	// ------------------------------------------------------------- Redis names

	private static String membersKeyPrefix() {
		return Activator.getKeyPrefix() + MEMBERS_KEY_SUFFIX;
	}

	private static String memberKey(String uuid) {
		return membersKeyPrefix() + uuid;
	}

	private static String rpcRequestTopicName() {
		return Activator.getKeyPrefix() + RPC_REQUEST_TOPIC_SUFFIX;
	}

	private static String rpcResponseTopicName(String taskId) {
		return Activator.getKeyPrefix() + RPC_RESPONSE_TOPIC_PREFIX + taskId;
	}

	// ------------------------------------------------------------ Inner state

	/**
	 * Per-request state: pending Future per target member + the response topic
	 * subscription that needs to be torn down on completion or timeout.
	 */
	private static final class PendingRequest {
		private final ConcurrentMap<String, CompletableFuture<Object>> futuresByUuid;
		private final RTopic responseTopic;
		private final int listenerId;

		PendingRequest(Map<IClusterMember, CompletableFuture<Object>> futures,
				RTopic responseTopic, int listenerId) {
			this.responseTopic = responseTopic;
			this.listenerId = listenerId;
			this.futuresByUuid = new ConcurrentHashMap<>();
			for (Map.Entry<IClusterMember, CompletableFuture<Object>> e : futures.entrySet()) {
				futuresByUuid.put(e.getKey().getId(), e.getValue());
			}
		}

		/** @return true if all expected responses have arrived. */
		boolean deliver(RpcResponse response) {
			CompletableFuture<Object> f = futuresByUuid.remove(response.getMemberUuid());
			if (f == null) {
				return futuresByUuid.isEmpty();
			}
			if (response.getError() != null) {
				f.completeExceptionally(response.getError());
			} else {
				f.complete(response.getResult());
			}
			return futuresByUuid.isEmpty();
		}

		/** Complete remaining (still-pending) futures exceptionally with {@code cause}. */
		void failRemaining(Throwable cause) {
			for (CompletableFuture<Object> f : futuresByUuid.values()) {
				if (!f.isDone()) {
					f.completeExceptionally(cause);
				}
			}
			futuresByUuid.clear();
		}

		void unsubscribe() {
			try {
				responseTopic.removeListener(listenerId);
			} catch (Exception ignored) {
				// best effort
			}
		}
	}
}
