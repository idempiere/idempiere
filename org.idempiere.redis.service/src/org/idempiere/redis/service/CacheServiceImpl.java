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
import java.util.concurrent.TimeUnit;

import org.idempiere.distributed.ICacheService;
import org.idempiere.redis.service.cache.CaffeineLayeredMap;
import org.idempiere.redis.service.config.RedisConfig;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.condition.Condition;
import org.redisson.api.RLock;
import org.redisson.api.RMap;

@Component(
		service = ICacheService.class,
		immediate = true,
		enabled = true)
public class CacheServiceImpl implements ICacheService {

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
	}

	@Override
	public <K, V> Map<K, V> getMap(String name) {
		RMap<K, V> rmap = Activator.getRedissonClient().getMap(prefixed(name));
		if (nearCacheEnabled) {
			return new CaffeineLayeredMap<>(rmap, Activator.getHealth(),
					nearCacheMaxSize, nearCacheExpire,
					fallbackMaxSize, fallbackExpire);
		}
		return rmap;
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
		} else if (map instanceof RMap<?, ?> rmap) {
			mapName = rmap.getName();
		} else {
			return null;
		}
		String lockName = mapName + ":lock:" + String.valueOf(key);
		return Activator.getRedissonClient().getLock(lockName);
	}

	private String prefixed(String name) {
		return keyPrefix + name;
	}
}
