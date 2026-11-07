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

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.atomic.AtomicReference;

import org.compiere.util.CacheMgt;
import org.compiere.util.CacheNewRecordCallable;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.redis.service.cluster.AllowlistKryo5Codec;
import org.idempiere.redis.service.cluster.ClusterMember;
import org.idempiere.redis.service.cluster.RemoteExecutionException;
import org.idempiere.redis.service.cluster.RpcFrame;
import org.idempiere.redis.service.cluster.RpcFrame.RejectedFrameException;
import org.idempiere.redis.service.cluster.RpcReplayGuard;
import org.idempiere.redis.service.cluster.RpcRequest;
import org.idempiere.redis.service.config.ConfigParser;
import org.idempiere.redis.service.config.RedisConfig;
import org.idempiere.redis.service.health.RedisHealth;
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
import org.redisson.client.codec.ByteArrayCodec;
import org.redisson.client.codec.Codec;
import org.redisson.client.handler.State;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufUtil;
import io.netty.buffer.Unpooled;

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
 * Originators publish an {@link RpcFrame} request on a global request topic, target
 * members execute it on a bounded worker pool and publish a response frame on the
 * response topic of the originator, and each {@link Future} resolves as its node
 * responds. Every node subscribes to its own response topic once, at activation,
 * so a call opens no subscription of its own. A configurable
 * timeout (default 60 s, override via {@code idempiere.cluster.rpc.timeout})
 * fails any unfilled futures. RPC to self is short-circuited to a direct local
 * Callable invocation rather than a Redis round trip.</p>
 *
 * <p><b>Callable serialization</b>: Callables passed to {@code execute} must be
 * {@link java.io.Serializable}. The bundle's {@code DynamicImport-Package} entry
 * provides classloader access to whichever bundle defines the Callable's class
 * so deserialization on receiving nodes succeeds.</p>
 *
 * <p><b>Security</b>: with {@code rpc.hmac.secret} set, every frame is signed and a receiver
 * checks the signature, the timestamp and that it has not seen the frame before, all before
 * the callable or result is decoded. Without it, any client that can publish to Redis can run
 * callables on every node; a warning is logged at startup.</p>
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
	// v2: signed RpcFrame bytes. Nodes of an older version use other topics and do not read these.
	private static final String RPC_REQUEST_TOPIC_SUFFIX = "cluster:rpc:v2:request";
	private static final String RPC_RESPONSE_TOPIC_PREFIX = "cluster:rpc:v2:response:";

	private static final long HEARTBEAT_TTL_SECONDS = 30L;
	private static final long HEARTBEAT_PERIOD_SECONDS = 10L;
	private static final long DEFAULT_RPC_TIMEOUT_SECONDS = 60L;
	/** Largest accepted difference between the timestamp of a signed frame and the local clock. */
	private static final long DEFAULT_RPC_MAX_CLOCK_SKEW_SECONDS = 120L;
	/** Worker threads and queue length for incoming requests; a full queue refuses the request. */
	private static final int RPC_WORKER_THREADS = 4;
	private static final int RPC_WORKER_QUEUE = 1_000;
	/** At most one warning per this period about refused frames; the others are counted. */
	private static final long REFUSED_WARN_PERIOD_MILLIS = 60_000L;

	private final AtomicReference<ClusterMember> localMember = new AtomicReference<>();
	private final ConcurrentMap<String, PendingRequest> pending = new ConcurrentHashMap<>();

	private volatile ScheduledExecutorService heartbeatExecutor;
	private volatile ScheduledExecutorService timeoutExecutor;
	private volatile RTopic requestTopic;
	private volatile int requestListenerId = -1;
	/** This node's response topic, subscribed once at activation. */
	private volatile RTopic responseTopic;
	private volatile int responseListenerId = -1;
	private volatile long rpcTimeoutSeconds = DEFAULT_RPC_TIMEOUT_SECONDS;
	private volatile Codec rpcCodec;
	private volatile String rpcHmacSecret;
	/** Key prefix, bound into every frame HMAC so a frame is only valid in its own namespace. */
	private volatile String rpcContext = "";
	private volatile RpcReplayGuard replayGuard = new RpcReplayGuard(DEFAULT_RPC_MAX_CLOCK_SKEW_SECONDS * 1000L);
	private volatile ThreadPoolExecutor rpcWorkers;
	private final AtomicLong lastRefusedWarn = new AtomicLong(0L);
	private final AtomicInteger refusedSinceWarn = new AtomicInteger(0);

	/** How often {@link #retryFailedNotifications()} re-publishes notifications that could not be published. */
	private static final long NOTIFICATION_RETRY_SECONDS = 30L;
	/** Upper bound of {@link #failedNotifications}; beyond it one cluster-wide cache reset is owed instead. */
	private static final int MAX_FAILED_NOTIFICATIONS = 10_000;

	/**
	 * Fire-and-forget notifications ({@link #isNotification(Callable)}) whose publish failed, so the other
	 * nodes never received them. Re-published by {@link #retryFailedNotifications()}.
	 */
	private final ConcurrentLinkedQueue<RpcRequest> failedNotifications = new ConcurrentLinkedQueue<>();
	private final AtomicInteger failedNotificationCount = new AtomicInteger(0);
	/** Set when {@link #failedNotifications} overflowed: one cluster-wide cache reset replaces the dropped ones. */
	private final AtomicBoolean fullResetOwed = new AtomicBoolean(false);

	@Activate
	void activate() {
		try {
			ClusterMember self = createLocalMember();
			localMember.set(self);
			rpcTimeoutSeconds = resolveRpcTimeout();
			rpcCodec = buildRpcCodec(Activator.getConfig());
			rpcHmacSecret = Activator.getConfig().getRpcHmacSecret();
			rpcContext = Activator.getKeyPrefix();
			replayGuard = new RpcReplayGuard(resolveMaxClockSkewSeconds() * 1000L);
			if (rpcHmacSecret == null) {
				log.warn("rpc.hmac.secret is not set: any client that can publish to this Redis server can run "
						+ "cluster commands on every node. Set the same random rpc.hmac.secret on all nodes.");
			}
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

		// Cache notifications nobody reads a result of: send them without a reply topic. No
		// response subscription is opened and nothing waits, so a burst of new records cannot
		// exhaust the subscription pool, trip the breaker and get the notices dropped. Not gated by
		// the breaker: it guards the subscription pool, which this path does not use.
		if (isNotification(task)) {
			publishNotification(new RpcRequest(taskId, self.getId(), remoteUuids.toArray(new String[0]), false, task));
			for (Map.Entry<IClusterMember, CompletableFuture<V>> e : futures.entrySet()) {
				if (!self.getId().equals(e.getKey().getId())) {
					e.getValue().complete(null);
				}
			}
			@SuppressWarnings({"rawtypes", "unchecked"})
			Map<IClusterMember, Future<V>> result = (Map) futures;
			return result;
		}

		// Check the breaker BEFORE allocating another response-topic subscription: once OPEN
		// (typically because the subscription pool is already at/near threshold), every further
		// call must stop adding listeners too, or the fast-path never actually gates anything —
		// it would just keep tripping later without ever preventing pool exhaustion. Self-targeted
		// futures were already completed above and are unaffected; only remote targets fail here.
		RedisHealth h = Activator.getHealthOrNull();
		if (h != null && !h.isHealthy()) {
			IllegalStateException unavailable = new IllegalStateException(
					"Redis circuit breaker is OPEN (" + h.getLastTripReason()
							+ "); cluster RPC to remote members is unavailable");
			for (Map.Entry<IClusterMember, CompletableFuture<V>> e : futures.entrySet()) {
				if (!self.getId().equals(e.getKey().getId())) {
					e.getValue().completeExceptionally(unavailable);
				}
			}
			@SuppressWarnings({"rawtypes", "unchecked"})
			Map<IClusterMember, Future<V>> result = (Map) futures;
			return result;
		}

		Map<IClusterMember, CompletableFuture<V>> remoteFutures = new LinkedHashMap<>();
		for (Map.Entry<IClusterMember, CompletableFuture<V>> e : futures.entrySet()) {
			if (!self.getId().equals(e.getKey().getId())) {
				remoteFutures.put(e.getKey(), e.getValue());
			}
		}

		@SuppressWarnings({"rawtypes", "unchecked"})
		PendingRequest pr = new PendingRequest((Map) remoteFutures);
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
					remoteUuids.toArray(new String[0]), true, task);
			requestTopic.publish(encodeRequest(request));
		} catch (Exception e) {
			pending.remove(taskId);
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

	/**
	 * A callable whose result no caller reads, sent fire-and-forget: the new record notification of
	 * {@code CacheMgt}, which ignores the futures of {@code execute}.
	 */
	private static boolean isNotification(Callable<?> task) {
		return task instanceof CacheNewRecordCallable;
	}

	/** Publishes a notification without a reply topic; a failed publish is kept for {@link #retryFailedNotifications()}. */
	private void publishNotification(RpcRequest request) {
		byte[] frame;
		try {
			frame = encodeRequest(request);
		} catch (RuntimeException e) {
			// Retrying cannot help and would block the notifications queued behind it.
			fullResetOwed.set(true);
			log.warn("Cannot encode cache notification {}; a cluster-wide cache reset is sent instead",
					request.getTaskId(), e);
			return;
		}
		RTopic topic = requestTopic;
		try {
			if (topic == null) {
				throw new IllegalStateException("RPC request topic not subscribed");
			}
			topic.publish(frame);
		} catch (Exception e) {
			keepFailedNotification(request);
			log.warn("Failed to publish cache notification {}; retried within {}s",
					request.getTaskId(), NOTIFICATION_RETRY_SECONDS, e);
		}
	}

	private void keepFailedNotification(RpcRequest request) {
		if (failedNotificationCount.incrementAndGet() > MAX_FAILED_NOTIFICATIONS) {
			failedNotificationCount.decrementAndGet();
			fullResetOwed.set(true);
			return;
		}
		failedNotifications.add(request);
	}

	/**
	 * Re-publishes the notifications that could not be published, oldest first; stops at the first
	 * failure and keeps the rest. After an overflow, one cluster-wide cache reset is sent once all
	 * kept notifications are out. Runs on {@link #timeoutExecutor}; catches everything so the task
	 * keeps its schedule.
	 */
	private void retryFailedNotifications() {
		try {
			RTopic topic = requestTopic;
			if (topic == null) {
				return;
			}
			RpcRequest request;
			while ((request = failedNotifications.peek()) != null) {
				// Encoded again: a fresh timestamp, so receivers do not refuse it as too old.
				byte[] frame;
				try {
					frame = encodeRequest(request);
				} catch (RuntimeException e) {
					// Dropped, not retried, so it cannot block the rest; the reset below covers it.
					failedNotifications.poll();
					failedNotificationCount.decrementAndGet();
					fullResetOwed.set(true);
					log.warn("Cannot encode cache notification {}; dropped, a cluster-wide cache reset is sent instead",
							request.getTaskId(), e);
					continue;
				}
				topic.publish(frame);
				failedNotifications.poll();
				failedNotificationCount.decrementAndGet();
			}
			if (fullResetOwed.compareAndSet(true, false)) {
				try {
					CacheMgt.get().reset();
				} catch (RuntimeException | Error e) {
					// Still owed: the next run retries it.
					fullResetOwed.set(true);
					throw e;
				}
				log.warn("Cluster-wide cache reset sent: more than {} cache notifications could not be published",
						MAX_FAILED_NOTIFICATIONS);
			}
			replayGuard.purge(System.currentTimeMillis());
		} catch (Throwable t) {
			log.warn("Re-publishing failed cache notifications failed; will retry in {}s", NOTIFICATION_RETRY_SECONDS, t);
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
		timeoutExecutor.scheduleWithFixedDelay(this::retryFailedNotifications,
				NOTIFICATION_RETRY_SECONDS, NOTIFICATION_RETRY_SECONDS, TimeUnit.SECONDS);
		// Callables run here, not on the Redisson listener thread, so a slow one does not hold up
		// every other topic listener. A full queue refuses further requests.
		rpcWorkers = new ThreadPoolExecutor(RPC_WORKER_THREADS, RPC_WORKER_THREADS, 60L, TimeUnit.SECONDS,
				new ArrayBlockingQueue<>(RPC_WORKER_QUEUE), daemonThreadFactory("redis-cluster-rpc-worker"),
				new ThreadPoolExecutor.AbortPolicy());
		rpcWorkers.allowCoreThreadTimeOut(true);
		RedissonClient client = Activator.getRedissonClient();
		// Response topic first, so no reply to an early request of this node is missed.
		responseTopic = client.getTopic(rpcResponseTopicName(localMember.get().getId()), ByteArrayCodec.INSTANCE);
		responseListenerId = responseTopic.addListener(byte[].class,
				(channel, frame) -> handleResponse(frame));
		requestTopic = client.getTopic(rpcRequestTopicName(), ByteArrayCodec.INSTANCE);
		requestListenerId = requestTopic.addListener(byte[].class,
				(channel, frame) -> handleRequest(frame));
	}

	private void unsubscribeFromRequestTopic() {
		RTopic topic = requestTopic;
		int id = requestListenerId;
		requestTopic = null;
		requestListenerId = -1;
		removeListener(topic, id);
		RTopic responses = responseTopic;
		int responsesId = responseListenerId;
		responseTopic = null;
		responseListenerId = -1;
		removeListener(responses, responsesId);
		ScheduledExecutorService te = timeoutExecutor;
		timeoutExecutor = null;
		if (te != null) {
			te.shutdownNow();
		}
		ThreadPoolExecutor workers = rpcWorkers;
		rpcWorkers = null;
		if (workers != null) {
			workers.shutdownNow();
		}
	}

	private static void removeListener(RTopic topic, int id) {
		if (topic != null && id != -1) {
			try {
				topic.removeListener(id);
			} catch (Exception ignored) {
				// best effort
			}
		}
	}

	/**
	 * Runs on the Redisson listener thread: checks the frame (HMAC, kind, target, timestamp, replay)
	 * without decoding the callable, then hands it to {@link #rpcWorkers}.
	 */
	private void handleRequest(byte[] bytes) {
		ClusterMember self = localMember.get();
		if (self == null) {
			return;
		}
		String secret = rpcHmacSecret;
		RpcFrame frame;
		try {
			frame = RpcFrame.decode(bytes, secret, rpcContext);
		} catch (RejectedFrameException e) {
			refused("request", e.getMessage());
			return;
		}
		if (frame.getKind() != RpcFrame.KIND_REQUEST) {
			refused("request", "not a request frame");
			return;
		}
		if (!isTargeted(frame, self)) {
			return;
		}
		if (secret != null) {
			String reason = replayGuard.check(frame, System.currentTimeMillis());
			if (reason != null) {
				refused("request " + frame.getTaskId(), reason);
				return;
			}
		}
		ThreadPoolExecutor workers = rpcWorkers;
		try {
			if (workers == null) {
				throw new RejectedExecutionException("cluster service is stopping");
			}
			workers.execute(() -> runRequest(frame, self));
		} catch (RejectedExecutionException e) {
			log.warn("RPC request {} from {} refused: worker queue full or stopping", frame.getTaskId(),
					frame.getSenderUuid());
			if (frame.isReplyExpected()) {
				publishResponse(frame, RpcFrame.error(System.currentTimeMillis(), frame.getTaskId(), self.getId(),
						RejectedExecutionException.class.getName(), "cluster member busy"));
			}
		}
	}

	/** Runs on {@link #rpcWorkers}: decodes the callable, runs it and sends the response, if one is expected. */
	private void runRequest(RpcFrame frame, ClusterMember self) {
		Object result = null;
		Throwable error = null;
		try {
			Object decoded = decodePayload(rpcCodec, frame.getPayload());
			if (!(decoded instanceof Callable)) {
				throw new IllegalArgumentException("RPC payload is not a Callable: "
						+ (decoded == null ? "null" : decoded.getClass().getName()));
			}
			result = ((Callable<?>) decoded).call();
		} catch (Throwable t) {
			error = t;
		}
		if (!frame.isReplyExpected()) {
			// Fire-and-forget notification: nobody waits for a reply.
			if (error != null) {
				log.warn("Cache notification {} failed on {}", frame.getTaskId(), self.getId(), error);
			}
			return;
		}
		long now = System.currentTimeMillis();
		RpcFrame response;
		if (error != null) {
			response = RpcFrame.error(now, frame.getTaskId(), self.getId(), error.getClass().getName(),
					error.getMessage());
		} else {
			try {
				response = RpcFrame.result(now, frame.getTaskId(), self.getId(), encodePayload(rpcCodec, result));
			} catch (Exception e) {
				log.warn("Failed to encode RPC response for task {} from {}", frame.getTaskId(), self.getId(), e);
				response = RpcFrame.error(now, frame.getTaskId(), self.getId(), e.getClass().getName(),
						"Response serialization failed: " + e.getMessage());
			}
		}
		publishResponse(frame, response);
	}

	/** Publishes on the response topic of the originator of {@code request}; the topic name never comes from the sender. */
	private void publishResponse(RpcFrame request, RpcFrame response) {
		try {
			RTopic topic = Activator.getRedissonClient().getTopic(
					rpcResponseTopicName(request.getSenderUuid()), ByteArrayCodec.INSTANCE);
			topic.publish(response.encode(rpcHmacSecret, rpcContext));
		} catch (Exception e) {
			log.warn("Failed to publish RPC response for task {}", request.getTaskId(), e);
		}
	}

	private static boolean isTargeted(RpcFrame frame, ClusterMember self) {
		String[] uuids = frame.getTargetUuids();
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

	private void handleResponse(byte[] bytes) {
		String secret = rpcHmacSecret;
		RpcFrame frame;
		try {
			frame = RpcFrame.decode(bytes, secret, rpcContext);
		} catch (RejectedFrameException e) {
			refused("response", e.getMessage());
			return;
		}
		if (frame.getKind() != RpcFrame.KIND_RESPONSE) {
			refused("response", "not a response frame");
			return;
		}
		String taskId = frame.getTaskId();
		PendingRequest pr = pending.get(taskId);
		if (pr == null || !pr.isWaitingFor(frame.getSenderUuid())) {
			// Late response after timeout, already handled, or from a member that was not asked.
			return;
		}
		if (secret != null) {
			String reason = replayGuard.check(frame, System.currentTimeMillis());
			if (reason != null) {
				refused("response to " + taskId, reason);
				return;
			}
		}
		boolean done;
		if (frame.isError()) {
			done = pr.deliver(frame.getSenderUuid(), null, new RemoteExecutionException(frame.getSenderUuid(),
					frame.getErrorClass(), frame.getErrorMessage()));
		} else {
			Object result;
			try {
				result = decodePayload(rpcCodec, frame.getPayload());
			} catch (Exception e) {
				done = pr.deliver(frame.getSenderUuid(), null,
						new IllegalStateException("Failed to decode RPC response for task " + taskId, e));
				finishIfDone(taskId, pr, done);
				return;
			}
			done = pr.deliver(frame.getSenderUuid(), result, null);
		}
		finishIfDone(taskId, pr, done);
	}

	private void finishIfDone(String taskId, PendingRequest pr, boolean done) {
		if (done) {
			// Atomic remove(key,value) gate prevents failAllPending double-calling
			// unsubscribe on the same PendingRequest in a race; an unconditional
			// remove(key) here would not guard against that.
			if (pending.remove(taskId, pr)) {
				pr.cancelTimeout();
			}
		}
	}

	/** Logs a refused frame, at most once per {@link #REFUSED_WARN_PERIOD_MILLIS}, with the number refused since. */
	private void refused(String what, String reason) {
		int count = refusedSinceWarn.incrementAndGet();
		long now = System.currentTimeMillis();
		long last = lastRefusedWarn.get();
		if (now - last >= REFUSED_WARN_PERIOD_MILLIS && lastRefusedWarn.compareAndSet(last, now)) {
			refusedSinceWarn.addAndGet(-count);
			log.warn("Cluster RPC {} refused: {} ({} refused in the last period)", what, reason, count);
		} else if (log.isDebugEnabled()) {
			log.debug("Cluster RPC {} refused: {}", what, reason);
		}
	}

	private void failPendingByTimeout(String taskId) {
		PendingRequest pr = pending.remove(taskId);
		if (pr != null) {
			pr.failRemaining(new TimeoutException("RPC timed out after " + rpcTimeoutSeconds + " s"));
		}
	}

	private void failAllPending(Throwable cause) {
		// Drain using remove(key,value) so only the thread that removes completes the
		// request when handleResponse races here.
		pending.forEach((id, pr) -> {
			if (pending.remove(id, pr)) {
				pr.failRemaining(cause);
				pr.cancelTimeout();
			}
		});
	}

	// ---------------------------------------------------------- Security helpers

	/**
	 * The codec of frame payloads. Always {@link AllowlistKryo5Codec}, whatever codec the Redisson
	 * client uses: it never decodes exceptions, and it applies {@code rpc.callable.allowlist} when set.
	 */
	private static Codec buildRpcCodec(RedisConfig cfg) {
		Set<String> allowlist = cfg.getRpcCallableAllowlist();
		if (allowlist.isEmpty()) {
			return new AllowlistKryo5Codec(null, Set.of());
		}
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		log.info("RPC codec: allow-list active ({} class(es))", allowlist.size());
		return new AllowlistKryo5Codec(cl, allowlist);
	}

	/** Encodes {@code request} into a frame with the current time, signed when a secret is set. */
	private byte[] encodeRequest(RpcRequest request) {
		try {
			byte[] payload = encodePayload(rpcCodec, request.getCallable());
			return RpcFrame.request(System.currentTimeMillis(), request.getTaskId(), request.getOriginatorUuid(),
					request.getTargetUuids(), request.isReplyExpected(), payload).encode(rpcHmacSecret, rpcContext);
		} catch (IOException e) {
			throw new IllegalStateException("Failed to encode RPC request " + request.getTaskId(), e);
		}
	}

	static byte[] encodePayload(Codec codec, Object value) throws IOException {
		ByteBuf buf = codec.getValueEncoder().encode(value);
		try {
			return ByteBufUtil.getBytes(buf);
		} finally {
			buf.release();
		}
	}

	static Object decodePayload(Codec codec, byte[] bytes) throws IOException {
		ByteBuf buf = Unpooled.wrappedBuffer(bytes);
		try {
			return codec.getValueDecoder().decode(buf, new State());
		} finally {
			buf.release();
		}
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

	private static long resolveMaxClockSkewSeconds() {
		long parsed = ConfigParser.systemProp("idempiere.cluster.rpc.maxClockSkew",
				DEFAULT_RPC_MAX_CLOCK_SKEW_SECONDS, Long::parseLong);
		if (parsed <= 0) {
			log.warn("idempiere.cluster.rpc.maxClockSkew must be positive; defaulting to {} s",
					DEFAULT_RPC_MAX_CLOCK_SKEW_SECONDS);
			return DEFAULT_RPC_MAX_CLOCK_SKEW_SECONDS;
		}
		return parsed;
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

	/** One per node: the receiver derives it from the originator, which is covered by the frame HMAC. */
	private static String rpcResponseTopicName(String originatorUuid) {
		return Activator.getKeyPrefix() + RPC_RESPONSE_TOPIC_PREFIX + originatorUuid;
	}

	// ------------------------------------------------------------ Inner state

	/**
	 * Per-request state: pending Future per target member, plus the scheduled
	 * timeout handle so an early completion can cancel the wakeup.
	 */
	private static final class PendingRequest {
		private final ConcurrentMap<String, CompletableFuture<Object>> futuresByUuid;
		private volatile ScheduledFuture<?> timeoutHandle;

		PendingRequest(Map<IClusterMember, CompletableFuture<Object>> futures) {
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

		boolean isWaitingFor(String memberUuid) {
			return memberUuid != null && futuresByUuid.containsKey(memberUuid);
		}

		/** @return true if all expected responses have arrived. */
		boolean deliver(String memberUuid, Object result, Throwable error) {
			CompletableFuture<Object> f = futuresByUuid.remove(memberUuid);
			if (f == null) {
				return futuresByUuid.isEmpty();
			}
			if (error != null) {
				f.completeExceptionally(error);
			} else {
				f.complete(result);
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
	}
}
