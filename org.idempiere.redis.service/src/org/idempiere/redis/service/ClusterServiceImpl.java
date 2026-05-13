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
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.Callable;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicReference;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.redis.service.cluster.AllowlistKryo5Codec;
import org.idempiere.redis.service.cluster.ClusterMember;
import org.idempiere.redis.service.cluster.RpcRequest;
import org.idempiere.redis.service.cluster.RpcResponse;
import org.idempiere.redis.service.config.ConfigParser;
import org.idempiere.redis.service.config.RedisConfig;
import org.redisson.client.codec.Codec;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.condition.Condition;
import org.redisson.api.RBucket;
import org.redisson.api.RBuckets;
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
 * Redis for keys under that namespace and pulls every value in one MGET round
 * trip.</p>
 *
 * <p><b>Distributed compute</b> ({@link #execute}) uses topic-RPC on Redis pub/sub.
 * Originators publish an {@link RpcRequest} on a global request topic, target
 * members execute and publish an {@link RpcResponse} on a per-request response
 * topic, and each {@link Future} resolves as its node responds. A configurable
 * timeout (default 60 s, override via {@code idempiere.cluster.rpc.timeout})
 * fails any unfilled futures. RPC to self is short-circuited to a direct local
 * Callable invocation rather than a Redis round trip.</p>
 *
 * <p><b>Callable serialization</b>: Callables passed to {@code execute} must be
 * {@link java.io.Serializable}. The bundle's {@code DynamicImport-Package} entry
 * provides classloader access to whichever bundle defines the Callable's class
 * so deserialization on receiving nodes succeeds.</p>
 */
@Component(
		service = IClusterService.class,
		immediate = true,
		enabled = true)
public class ClusterServiceImpl implements IClusterService {

	@Reference(target = "(osgi.condition.id=distributed.provider.redis.initialized)")
    Condition distributedCondition;

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
	private volatile Codec rpcCodec;
	private volatile String rpcHmacSecret;

	@Activate
	void activate() {
		try {
			ClusterMember self = createLocalMember();
			localMember.set(self);
			rpcTimeoutSeconds = resolveRpcTimeout();
			rpcCodec = buildRpcCodec(Activator.getConfig());
			rpcHmacSecret = Activator.getConfig().getRpcHmacSecret();
			startHeartbeat();
			subscribeToRequestTopic();
			log.info("Redis cluster service activated; local member: {}", self);
		} catch (RuntimeException re) {
			throw re;
		} catch (Exception e) {
			throw new IllegalStateException("Failed to activate Redis cluster service", e);
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
			List<String> keyList = new ArrayList<>();
			for (String key : keys.getKeysByPattern(pattern)) {
				keyList.add(key);
			}
			if (keyList.isEmpty()) {
				return Collections.singletonList(self);
			}
			RBuckets buckets = client.getBuckets();
			// One MGET round trip — a 50-node cluster used to mean 50 RTTs.
			Map<String, ClusterMember> bulk = buckets.get(keyList.toArray(new String[0]));
			Collection<IClusterMember> members = new ArrayList<>(bulk.size());
			for (ClusterMember m : bulk.values()) {
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
		if (requestTopic == null) {
			throw new IllegalStateException("RPC request topic not subscribed; cluster execute is unavailable");
		}

		String taskId = UUID.randomUUID().toString();
		String responseTopicName = rpcResponseTopicName(taskId);

		Map<IClusterMember, CompletableFuture<V>> futures = new LinkedHashMap<>();
		List<String> remoteUuids = new ArrayList<>(members.size());
		IClusterMember selfTarget = null;
		for (IClusterMember m : members) {
			CompletableFuture<V> f = new CompletableFuture<>();
			futures.put(m, f);
			if (self.getId().equals(m.getId())) {
				selfTarget = m;
			} else {
				remoteUuids.add(m.getId());
			}
		}

		// Self-targeted execution: run the Callable directly instead of round-tripping
		// through Redis pub/sub. Delivery semantics match: same future-completion
		// timing relative to remote responses, plus saved network latency.
		if (selfTarget != null) {
			completeLocally(futures.get(selfTarget), task);
		}

		if (remoteUuids.isEmpty()) {
			@SuppressWarnings({"rawtypes", "unchecked"})
			Map<IClusterMember, Future<V>> result = (Map) futures;
			return result;
		}

		RedissonClient client = Activator.getRedissonClient();
		Codec codec = rpcCodec;
		RTopic responseTopic = (codec != null)
				? client.getTopic(responseTopicName, codec)
				: client.getTopic(responseTopicName);
		int listenerId = responseTopic.addListener(RpcResponse.class,
				(channel, response) -> handleResponse(response));

		Map<IClusterMember, CompletableFuture<V>> remoteFutures = new LinkedHashMap<>();
		for (Map.Entry<IClusterMember, CompletableFuture<V>> e : futures.entrySet()) {
			if (!self.getId().equals(e.getKey().getId())) {
				remoteFutures.put(e.getKey(), e.getValue());
			}
		}

		@SuppressWarnings({"rawtypes", "unchecked"})
		PendingRequest pr = new PendingRequest((Map) remoteFutures, responseTopic, listenerId);
		pending.put(taskId, pr);

		ScheduledExecutorService te = timeoutExecutor;
		if (te != null) {
			try {
				pr.setTimeoutHandle(te.schedule(() -> failPendingByTimeout(taskId),
						rpcTimeoutSeconds, TimeUnit.SECONDS));
			} catch (RejectedExecutionException ignored) {
				// Bundle is deactivating; failAllPending will complete this request.
			}
		}

		try {
			RpcRequest request = new RpcRequest(taskId, self.getId(),
					remoteUuids.toArray(new String[0]), responseTopicName, task);
			String secret = rpcHmacSecret;
			if (secret != null) {
				request.setHmac(computeHmac(secret, taskId, self.getId()));
			}
			requestTopic.publish(request);
		} catch (Exception e) {
			pending.remove(taskId);
			pr.unsubscribe();
			pr.cancelTimeout();
			IllegalStateException wrap = new IllegalStateException(
					"Failed to publish RPC request — Callable may not be Serializable, or Redis is unavailable", e);
			for (CompletableFuture<V> f : remoteFutures.values()) {
				f.completeExceptionally(wrap);
			}
		}

		@SuppressWarnings({"rawtypes", "unchecked"})
		Map<IClusterMember, Future<V>> result = (Map) futures;
		return result;
	}

	private static <V> void completeLocally(CompletableFuture<V> future, Callable<V> task) {
		try {
			future.complete(task.call());
		} catch (Throwable t) {
			future.completeExceptionally(t);
		}
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
		// Caller wraps in try/catch in activate() and converts to ISE, which marks
		// the DS component as failed. Better that than swallowing here and letting
		// execute() NPE later with a misleading "Callable may not be Serializable".
		timeoutExecutor = Executors.newSingleThreadScheduledExecutor(daemonThreadFactory("redis-cluster-rpc-timeout"));
		Codec codec = rpcCodec;
		String topicName = rpcRequestTopicName();
		requestTopic = (codec != null)
				? Activator.getRedissonClient().getTopic(topicName, codec)
				: Activator.getRedissonClient().getTopic(topicName);
		requestListenerId = requestTopic.addListener(RpcRequest.class,
				(channel, request) -> handleRequest(request));
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
		String secret = rpcHmacSecret;
		if (secret != null && !verifyHmac(secret, request)) {
			return;
		}
		Object result = null;
		Throwable error = null;
		try {
			result = request.getCallable().call();
		} catch (Throwable t) {
			error = t;
		}
		Throwable safeError = toSerializable(error);
		Codec codec = rpcCodec;
		RTopic responseTopic = (codec != null)
				? Activator.getRedissonClient().getTopic(request.getResponseTopic(), codec)
				: Activator.getRedissonClient().getTopic(request.getResponseTopic());
		try {
			RpcResponse response = new RpcResponse(request.getTaskId(), self.getId(), result, safeError);
			responseTopic.publish(response);
		} catch (Exception e) {
			log.warn("Failed to publish RPC response for task {} from {}; retrying with sanitised error",
					request.getTaskId(), self.getId(), e);
			try {
				RpcResponse fallback = new RpcResponse(request.getTaskId(), self.getId(), null,
						new RuntimeException("Response serialization failed: " + e));
				responseTopic.publish(fallback);
			} catch (Exception ee) {
				log.error("Sanitised RPC response also failed for task {}", request.getTaskId(), ee);
			}
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
			pr.cancelTimeout();
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
			pr.cancelTimeout();
		}
		pending.clear();
	}

	// ---------------------------------------------------------- Security helpers

	private static Codec buildRpcCodec(RedisConfig cfg) {
		Set<String> allowlist = cfg.getRpcCallableAllowlist();
		if (allowlist.isEmpty()) {
			return null; // no restriction — existing Redisson default codec
		}
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		log.info("RPC codec: allow-list active ({} class(es))", allowlist.size());
		return new AllowlistKryo5Codec(cl, allowlist);
	}

	private static String computeHmac(String secret, String taskId, String originatorUuid) {
		try {
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
			mac.update(taskId.getBytes(StandardCharsets.UTF_8));
			mac.update((byte) '|');
			mac.update(originatorUuid.getBytes(StandardCharsets.UTF_8));
			return Base64.getEncoder().encodeToString(mac.doFinal());
		} catch (Exception e) {
			throw new IllegalStateException("HMAC computation failed", e);
		}
	}

	private boolean verifyHmac(String secret, RpcRequest request) {
		String provided = request.getHmac();
		if (provided == null || provided.isEmpty()) {
			log.warn("RPC request {} rejected: HMAC required but missing", request.getTaskId());
			return false;
		}
		String expected = computeHmac(secret, request.getTaskId(), request.getOriginatorUuid());
		if (!MessageDigest.isEqual(
				expected.getBytes(StandardCharsets.UTF_8),
				provided.getBytes(StandardCharsets.UTF_8))) {
			log.warn("RPC request {} rejected: HMAC mismatch (possible forgery)", request.getTaskId());
			return false;
		}
		return true;
	}

	/**
	 * Returns {@code error} if it is {@link java.io.Serializable}; otherwise wraps
	 * it in a plain {@link RuntimeException} so the response can always be published.
	 */
	private static Throwable toSerializable(Throwable error) {
		if (error == null || error instanceof java.io.Serializable) {
			return error;
		}
		return new RuntimeException(error.getClass().getName() + ": " + error.getMessage());
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
		return ConfigParser.systemProp("idempiere.cluster.port", 0, Integer::parseInt);
	}

	private static long resolveRpcTimeout() {
		long parsed = ConfigParser.systemProp("idempiere.cluster.rpc.timeout",
				DEFAULT_RPC_TIMEOUT_SECONDS, Long::parseLong);
		if (parsed <= 0) {
			log.warn("idempiere.cluster.rpc.timeout must be positive; defaulting to {} s", DEFAULT_RPC_TIMEOUT_SECONDS);
			return DEFAULT_RPC_TIMEOUT_SECONDS;
		}
		return parsed;
	}

	private static ThreadFactory daemonThreadFactory(String name) {
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
	 * subscription that needs to be torn down on completion or timeout, plus the
	 * scheduled timeout handle so an early completion can cancel the wakeup.
	 */
	private static final class PendingRequest {
		private final ConcurrentMap<String, CompletableFuture<Object>> futuresByUuid;
		private final RTopic responseTopic;
		private final int listenerId;
		private volatile ScheduledFuture<?> timeoutHandle;

		PendingRequest(Map<IClusterMember, CompletableFuture<Object>> futures,
				RTopic responseTopic, int listenerId) {
			this.responseTopic = responseTopic;
			this.listenerId = listenerId;
			this.futuresByUuid = new ConcurrentHashMap<>();
			for (Map.Entry<IClusterMember, CompletableFuture<Object>> e : futures.entrySet()) {
				futuresByUuid.put(e.getKey().getId(), e.getValue());
			}
		}

		void setTimeoutHandle(ScheduledFuture<?> handle) {
			this.timeoutHandle = handle;
		}

		void cancelTimeout() {
			ScheduledFuture<?> h = timeoutHandle;
			timeoutHandle = null;
			if (h != null) {
				h.cancel(false);
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
