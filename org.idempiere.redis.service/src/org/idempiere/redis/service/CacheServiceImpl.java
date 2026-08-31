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

import java.net.InetSocketAddress;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;

import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.idempiere.distributed.ICacheService;
import org.idempiere.redis.service.cache.CacheResetMessage;
import org.idempiere.redis.service.cache.CaffeineLayeredMap;
import org.idempiere.redis.service.cache.TtlAwareMapCache;
import org.idempiere.redis.service.config.RedisConfig;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.condition.Condition;
import org.redisson.api.RLock;
import org.redisson.api.RMap;
import org.redisson.api.RMapCache;
import org.redisson.api.RTopic;
import org.redisson.codec.TypedJsonJacksonCodec;
import org.redisson.connection.ConnectionListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(
		service = ICacheService.class,
		immediate = true,
		enabled = true)
public class CacheServiceImpl implements ICacheService {

	private static final Logger log = LoggerFactory.getLogger(CacheServiceImpl.class);

	/** Suffix appended to the key prefix to form the durable invalidation channel name. */
	private static final String CACHE_INVALIDATION_TOPIC_SUFFIX = "cache:invalidation";

	/** Bounds on {@link #resetExecutor} so a burst of invalidations cannot spawn unbounded threads. */
	private static final int RESET_EXECUTOR_CORE_POOL_SIZE = 4;
	private static final int RESET_EXECUTOR_MAX_POOL_SIZE = 16;
	private static final int RESET_EXECUTOR_QUEUE_CAPACITY = 1000;
	private static final long RESET_EXECUTOR_KEEP_ALIVE_SECONDS = 60L;

	/** Minimum gap between reconnect-triggered full local resets, so a flapping link cannot repeatedly hammer the DB. */
	private static final long MIN_RECONCILE_INTERVAL_MS = 5_000L;

	@Reference(target = "(osgi.condition.id=distributed.provider.redis.initialized)")
    Condition distributedCondition;

	// Snapshot of RedisConfig values resolved at @Activate time. Resolving these
	// per getMap() call would mean dereferencing the Activator config singleton
	// (and re-evaluating branches) on every CCache constructor — a hot path.
	private boolean nearCacheEnabled;
	private int nearCacheMaxSize;
	private Duration nearCacheExpire;
	private int fallbackMaxSize;
	private Duration fallbackExpire;
	private String keyPrefix = "";
	private long distributedCacheMapTtlMs;
	private int distributedCacheMapMaxSize;
	private boolean clientPrefixMode;
	private int defaultClientId;

	/** Tracks map names that have already had setMaxSize applied. */
	private final Set<String> configuredMaps = ConcurrentHashMap.newKeySet();

	/** Durable topic shared by the whole lifetime of this component. */
	private volatile RTopic invalidationTopic;
	private volatile int invalidationListenerId = -1;

	/** Local node ID used to skip re-applying resets published by this node. */
	private String localNodeId;

	/** Executor for dispatching anti-stampede resets off the Redisson netty I/O thread. */
	private ExecutorService resetExecutor;

	/**
	 * Redis node addresses currently seen as disconnected. Plain pub/sub (the invalidation
	 * topic subscribed above) drops any message published while a subscriber is disconnected —
	 * Redisson resubscribes automatically once the link is back, but does not replay what was
	 * missed. This set (backing {@link #onNodeConnect}/{@link #onNodeDisconnect}) lets us detect
	 * "we just recovered from an outage" and fall back to a full local reset, bounding staleness
	 * instead of leaving it unbounded.
	 */
	private final Set<InetSocketAddress> downNodeAddresses = ConcurrentHashMap.newKeySet();
	private final AtomicLong lastReconcileAtMs = new AtomicLong(0L);
	private volatile int connectionListenerId = -1;

	@Activate
	// getNodesGroup()/ConnectionListener's InetSocketAddress-only overloads are deprecated in
	// Redisson 3.27.2 in favor of getRedisNodes(...), but that newer API (BaseRedisNodes) exposes
	// no connection-event hook at all — getNodesGroup() remains the only way to observe node
	// connect/disconnect, and ConnectionListener's single-arg methods are abstract (must be
	// implemented) regardless of the NodeType-aware default overloads also being available.
	@SuppressWarnings("deprecation")
	void activate() {
		RedisConfig cfg = Activator.getConfig();
		this.nearCacheEnabled = cfg.isNearCacheEnabled();
		this.nearCacheMaxSize = cfg.getNearCacheMaxSize();
		this.nearCacheExpire = cfg.getNearCacheExpireAfterWrite();
		// fallbackMaxSize=0 disables the second tier when fallback is off,
		// keeping behaviour identical to the pre-split single-tier wrapper.
		this.fallbackMaxSize = cfg.isFallbackEnabled() ? cfg.getFallbackMaxSize() : 0;
		this.fallbackExpire = cfg.getFallbackExpireAfterWrite();
		this.keyPrefix = cfg.getKeyPrefix();
		this.distributedCacheMapTtlMs = cfg.getDistributedCacheMapTtl().toMillis();
		this.distributedCacheMapMaxSize = cfg.getDistributedCacheMapMaxSize();
		this.clientPrefixMode = cfg.isClientPrefixMode();
		this.defaultClientId = cfg.getDefaultClientId();

		this.localNodeId = Activator.getRedissonClient().getId();

		resetExecutor = new ThreadPoolExecutor(
				RESET_EXECUTOR_CORE_POOL_SIZE, RESET_EXECUTOR_MAX_POOL_SIZE,
				RESET_EXECUTOR_KEEP_ALIVE_SECONDS, TimeUnit.SECONDS,
				new LinkedBlockingQueue<>(RESET_EXECUTOR_QUEUE_CAPACITY),
				r -> {
					Thread t = new Thread(r, "cache-reset");
					t.setDaemon(true);
					return t;
				},
				// Bounded queue is full under a sustained invalidation burst: drop the task
				// rather than blocking the Redisson listener (netty I/O) thread. Anti-stampede
				// dedup means a dropped reset is only lost work, not lost correctness for
				// concurrent duplicate resets, but a genuinely distinct reset can be dropped too —
				// logged so operators can see when this bound is being hit.
				(task, executor) -> log.warn("Cache reset executor saturated (queue capacity {}); "
						+ "dropping a pending local cache-invalidation task", RESET_EXECUTOR_QUEUE_CAPACITY));

		// Subscribe once to the durable invalidation topic using JSON codec to prevent
		// Java deserialization attacks. All cache-reset broadcasts arrive here.
		String topicName = keyPrefix + CACHE_INVALIDATION_TOPIC_SUFFIX;
		RTopic topic = Activator.getRedissonClient().getTopic(
				topicName,
				new TypedJsonJacksonCodec(CacheResetMessage.class));
		int listenerId = topic.addListener(CacheResetMessage.class, (channel, msg) -> {
			ExecutorService exec = resetExecutor;
			if (exec == null) return;
			exec.submit(() -> {
				try {
					if (msg == null) {
						log.warn("Received invalid cache invalidation message; ignoring: {}", msg);
						return;
					}
					String msgTableName = msg.getTableName();
					// tableName == null (with recordId == -1) is the table-wide/whole-cache reset
					// sentinel published by CacheMgt.reset(); only reject blank/oversized non-null names.
					if (msgTableName != null && (msgTableName.isBlank() || msgTableName.length() > 200)) {
						log.warn("Received invalid cache invalidation message; ignoring: {}", msg);
						return;
					}
					// Skip: publishing node already reset synchronously before publish.
					if (localNodeId != null && localNodeId.equals(msg.getOriginatorNodeId())) {
						return;
					}
					if (msg.isStringKeyReset()) {
						CacheMgt.get().resetLocalCacheWithAntiStampede(msg.getTableName(), msg.getStringKey());
					} else {
						CacheMgt.get().resetLocalCacheWithAntiStampede(msg.getTableName(), msg.getRecordId());
					}
				} catch (Exception e) {
					log.warn("Error applying received cache invalidation for {}", msg, e);
				}
			});
		});
		this.invalidationTopic = topic;
		this.invalidationListenerId = listenerId;
		log.info("Cache invalidation topic subscribed: {}", topicName);

		this.connectionListenerId = Activator.getRedissonClient().getNodesGroup().addConnectionListener(
				new ConnectionListener() {
					@Override
					public void onConnect(InetSocketAddress addr) {
						onNodeConnect(addr);
					}

					@Override
					public void onDisconnect(InetSocketAddress addr) {
						downNodeAddresses.add(addr);
					}
				});
	}

	/**
	 * A node address just (re)connected. If it was previously down and no other node address is
	 * still down, the cluster link just recovered from an outage during which this node's
	 * invalidation-topic subscription could have silently dropped messages (plain Redis pub/sub
	 * is at-most-once and does not replay history). Fall back to one full local reset — debounced —
	 * to bound the staleness window instead of leaving it unbounded until an unrelated reset
	 * happens to touch the same table again.
	 */
	private void onNodeConnect(InetSocketAddress addr) {
		if (!downNodeAddresses.remove(addr) || !downNodeAddresses.isEmpty()) {
			return;
		}
		long now = System.currentTimeMillis();
		long prev = lastReconcileAtMs.get();
		if (now - prev < MIN_RECONCILE_INTERVAL_MS || !lastReconcileAtMs.compareAndSet(prev, now)) {
			return;
		}
		ExecutorService exec = resetExecutor;
		if (exec == null) return;
		log.warn("Redis connectivity recovered after an outage ({}); resetting local cache to "
				+ "recover any invalidations that may have been missed while disconnected", addr);
		exec.submit(() -> {
			try {
				CacheMgt.get().resetLocalCache();
			} catch (Exception e) {
				log.warn("Reconnect-triggered local cache reset failed", e);
			}
		});
	}

	@Deactivate
	@SuppressWarnings("deprecation") // see activate() — getNodesGroup() has no non-deprecated replacement
	void deactivate() {
		int connListenerId = connectionListenerId;
		connectionListenerId = -1;
		if (connListenerId != -1) {
			try {
				Activator.getRedissonClient().getNodesGroup().removeConnectionListener(connListenerId);
			} catch (Exception ignored) {}
		}
		downNodeAddresses.clear();
		RTopic topic = invalidationTopic;
		int listenerId = invalidationListenerId;
		invalidationTopic = null;
		invalidationListenerId = -1;
		if (topic != null && listenerId != -1) {
			try {
				topic.removeListener(listenerId);
			} catch (Exception ignored) {}
		}
		ExecutorService exec = resetExecutor;
		resetExecutor = null;
		if (exec != null) exec.shutdownNow();
	}

	@Override
	public <K, V> Map<K, V> getMap(String name) {
		RMapCache<K, V> rmap = Activator.getRedissonClient().getMapCache(prefixed(name));
		// Fire setMaxSize exactly once per map name regardless of concurrent callers.
		if (distributedCacheMapMaxSize > 0 && configuredMaps.add(prefixed(name))) {
			rmap.setMaxSize(distributedCacheMapMaxSize);
		}
		if (nearCacheEnabled) {
			// CaffeineLayeredMap writes straight to rmap (bypassing TtlAwareMapCache), so it is
			// given the TTL directly and applies it itself via the RMapCache TTL-aware put overload.
			return new CaffeineLayeredMap<>(rmap, Activator.getHealth(),
					nearCacheMaxSize, nearCacheExpire,
					fallbackMaxSize, fallbackExpire, distributedCacheMapTtlMs);
		}
		return (distributedCacheMapTtlMs > 0)
				? new TtlAwareMapCache<>(rmap, distributedCacheMapTtlMs)
				: rmap;
	}

	@Override
	public <K> List<K> getList(String name) {
		return Activator.getRedissonClient().getList(prefixed(name));
	}

	@Override
	public <K> Set<K> getSet(String name) {
		return Activator.getRedissonClient().getSet(prefixed(name));
	}

	/**
	 * Acquires a distributed lock keyed on (map, key) using Redisson's {@code RLock}.
	 *
	 * <p>Lock identity is derived from the underlying map's name plus the key value:
	 * <code>&lt;map-name&gt;:lock:&lt;key&gt;</code>. Behaviour mirrors Hazelcast's
	 * {@code IMap.tryLock(key, timeout, unit)} semantics: the lock is held until
	 * {@link #unLock(Map, Object)} is invoked, with Redisson's lock watchdog auto-renewing
	 * the lease so a crashed JVM eventually releases it instead of holding it forever.</p>
	 *
	 * <p>Accepts either a raw {@code RMap} or a {@link CaffeineLayeredMap} returned from
	 * {@link #getMap(String)}; both expose the same Redis map name. Returns {@code false}
	 * for any other {@link Map} subtype because the bundle cannot derive a stable
	 * distributed lock identity from a non-Redis map.</p>
	 */
	@Override
	public <K, V> boolean tryLock(Map<K, V> map, K key, long timeout, TimeUnit timeunit) throws InterruptedException {
		RLock lock = lockFor(map, key);
		if (lock == null) {
			return false;
		}
		return lock.tryLock(timeout, timeunit);
	}

	@Override
	public <K, V> void unLock(Map<K, V> map, K key) {
		RLock lock = lockFor(map, key);
		if (lock != null) {
			lock.unlock();
		}
	}

	private static <K, V> RLock lockFor(Map<K, V> map, K key) {
		String mapName;
		if (map instanceof CaffeineLayeredMap<?, ?> wrapped) {
			mapName = wrapped.getName();
		} else if (map instanceof TtlAwareMapCache<?, ?> ttlWrapped) {
			mapName = ttlWrapped.getName();
		} else if (map instanceof RMap<?, ?> rmap) {
			mapName = rmap.getName();
		} else {
			return null;
		}
		String lockName = mapName + ":lock:" + String.valueOf(key);
		return Activator.getRedissonClient().getLock(lockName);
	}

	/**
	 * Resets the local cache on this node synchronously first (no jitter — this is the saving node),
	 * then publishes a fire-and-forget invalidation to all other cluster nodes.
	 * The topic listener skips this node since the local reset is already applied.
	 */
	@Override
	public void broadcastReset(String tableName, int recordId) {
		// Always reset local cache synchronously first (no jitter — this is the saving node).
		CacheMgt.get().resetLocalCache(tableName, recordId);
		RTopic topic = invalidationTopic;
		if (topic == null) return;
		try {
			topic.publish(new CacheResetMessage(tableName, recordId, localNodeId));
		} catch (Exception e) {
			log.warn("broadcastReset publish failed for table {}; local reset already applied", tableName, e);
		}
	}

	/**
	 * Resets the local cache on this node synchronously first, then publishes to other nodes.
	 */
	@Override
	public void broadcastReset(String tableName, String key) {
		// Always reset local cache synchronously first (no jitter — this is the saving node).
		CacheMgt.get().resetLocalCache(tableName, key);
		RTopic topic = invalidationTopic;
		if (topic == null) return;
		try {
			topic.publish(new CacheResetMessage(tableName, key, localNodeId));
		} catch (Exception e) {
			log.warn("broadcastReset publish failed for table {}; local reset already applied", tableName, e);
		}
	}

	/**
	 * Prefixes {@code name} with the deployment instance prefix and, in
	 * {@code redis.tenant.prefix.mode=client}, the AD_Client_ID active on the calling thread —
	 * resolved fresh on every call rather than baked in at {@code @Activate} time, so a single JVM
	 * that serves more than one client does not have every client's cache data collapse into one
	 * shared Redis namespace. Falls back to the startup-configured {@link RedisConfig#getDefaultClientId()}
	 * when the calling thread has no session context (e.g. a background/system thread).
	 */
	private String prefixed(String name) {
		if (!clientPrefixMode) {
			return keyPrefix + name;
		}
		int clientId = Env.getAD_Client_ID(Env.getCtx());
		if (clientId <= 0) {
			clientId = defaultClientId;
		}
		return keyPrefix + "client-" + clientId + ":" + name;
	}
}
