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

import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.compiere.util.CacheMgt;
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

	/** Tracks map names that have already had setMaxSize applied. */
	private final Set<String> configuredMaps = ConcurrentHashMap.newKeySet();

	/** Durable topic shared by the whole lifetime of this component. */
	private volatile RTopic invalidationTopic;
	private volatile int invalidationListenerId = -1;

	/** Local node ID used to skip re-applying resets published by this node. */
	private String localNodeId;

	/** Executor for dispatching anti-stampede resets off the Redisson netty I/O thread. */
	private ExecutorService resetExecutor;

	@Activate
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

		this.localNodeId = Activator.getRedissonClient().getId();

		resetExecutor = Executors.newCachedThreadPool(r -> {
			Thread t = new Thread(r, "cache-reset");
			t.setDaemon(true);
			return t;
		});

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
					if (msg == null || msg.getTableName() == null || msg.getTableName().isBlank()
							|| msg.getTableName().length() > 200) {
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
	}

	@Deactivate
	void deactivate() {
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
		Map<K, V> base = (distributedCacheMapTtlMs > 0)
				? new TtlAwareMapCache<>(rmap, distributedCacheMapTtlMs)
				: rmap;
		if (nearCacheEnabled) {
			RMap<K, V> backingRMap = (base instanceof TtlAwareMapCache)
					? ((TtlAwareMapCache<K, V>) base).getBacking()
					: rmap;
			return new CaffeineLayeredMap<>(backingRMap, Activator.getHealth(),
					nearCacheMaxSize, nearCacheExpire,
					fallbackMaxSize, fallbackExpire);
		}
		return base;
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

	private String prefixed(String name) {
		return keyPrefix + name;
	}
}
