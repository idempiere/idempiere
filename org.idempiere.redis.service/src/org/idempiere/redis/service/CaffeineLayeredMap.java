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
import java.util.Collection;
import java.util.Map;
import java.util.Set;

import org.redisson.api.RMap;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

/**
 * {@link Map} adapter that puts a Caffeine in-memory cache in front of a
 * Redisson {@link RMap}. Used both as a near-cache (speed up hot reads) and
 * as a graceful-degradation layer (serve stale values when Redis is briefly
 * unreachable).
 *
 * <p>Behaviour:</p>
 * <ul>
 *   <li><b>get</b>: Caffeine first; on miss, ask Redis if {@link RedisHealth}
 *       reports healthy; on a Redis hit, populate Caffeine and return; on a
 *       Redis miss or failure, return whatever Caffeine has (typically
 *       {@code null}).</li>
 *   <li><b>put</b> / <b>remove</b> / <b>clear</b>: try the Redis side first.
 *       On success, mirror the change to Caffeine. On Redis failure, mirror
 *       the change locally anyway and report the failure to the breaker so
 *       subsequent calls can short-circuit.</li>
 *   <li>Size and iteration delegate straight to Redis — Caffeine is a partial
 *       window over Redis content, never authoritative for membership.</li>
 * </ul>
 *
 * <p>This wrapper is opt-in per {@code RedisConfig.isNearCacheEnabled()}.
 * When disabled, {@link CacheServiceImpl} returns the raw {@link RMap} and
 * Redis failures surface as exceptions to the caller.</p>
 */
public final class CaffeineLayeredMap<K, V> implements Map<K, V> {

	private final RMap<K, V> backing;
	private final Cache<K, V> nearCache;
	private final RedisHealth health;

	public CaffeineLayeredMap(RMap<K, V> backing, RedisHealth health, int maxSize, Duration expireAfterWrite) {
		this.backing = backing;
		this.health = health;
		this.nearCache = Caffeine.newBuilder()
				.maximumSize(maxSize)
				.expireAfterWrite(expireAfterWrite)
				.build();
	}

	/** @return the underlying Redis-backed map's name, including the deployment prefix. */
	public String getName() {
		return backing.getName();
	}

	@Override
	@SuppressWarnings("unchecked")
	public V get(Object key) {
		K typed = (K) key;
		V cached = nearCache.getIfPresent(typed);
		if (cached != null) {
			return cached;
		}
		if (!health.isHealthy()) {
			return null;
		}
		try {
			V remote = backing.get(typed);
			health.recordSuccess();
			if (remote != null) {
				nearCache.put(typed, remote);
			}
			return remote;
		} catch (Exception e) {
			health.recordFailure(e);
			return null;
		}
	}

	@Override
	public V put(K key, V value) {
		nearCache.put(key, value);
		if (!health.isHealthy()) {
			return null;
		}
		try {
			V previous = backing.put(key, value);
			health.recordSuccess();
			return previous;
		} catch (Exception e) {
			health.recordFailure(e);
			return null;
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public V remove(Object key) {
		K typed = (K) key;
		nearCache.invalidate(typed);
		if (!health.isHealthy()) {
			return null;
		}
		try {
			V previous = backing.remove(typed);
			health.recordSuccess();
			return previous;
		} catch (Exception e) {
			health.recordFailure(e);
			return null;
		}
	}

	@Override
	public void clear() {
		nearCache.invalidateAll();
		if (!health.isHealthy()) {
			return;
		}
		try {
			backing.clear();
			health.recordSuccess();
		} catch (Exception e) {
			health.recordFailure(e);
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public boolean containsKey(Object key) {
		K typed = (K) key;
		if (nearCache.getIfPresent(typed) != null) {
			return true;
		}
		if (!health.isHealthy()) {
			return false;
		}
		try {
			boolean present = backing.containsKey(typed);
			health.recordSuccess();
			return present;
		} catch (Exception e) {
			health.recordFailure(e);
			return false;
		}
	}

	@Override
	public boolean containsValue(Object value) {
		// Caffeine is a partial view; cannot answer membership questions accurately.
		return backing.containsValue(value);
	}

	@Override
	public int size() {
		return backing.size();
	}

	@Override
	public boolean isEmpty() {
		return backing.isEmpty();
	}

	@Override
	public void putAll(Map<? extends K, ? extends V> m) {
		// Eagerly mirror to near-cache; Redis write may partially fail.
		for (Map.Entry<? extends K, ? extends V> e : m.entrySet()) {
			nearCache.put(e.getKey(), e.getValue());
		}
		if (!health.isHealthy()) {
			return;
		}
		try {
			backing.putAll(m);
			health.recordSuccess();
		} catch (Exception e) {
			health.recordFailure(e);
		}
	}

	@Override
	public Set<K> keySet() {
		return backing.keySet();
	}

	@Override
	public Collection<V> values() {
		return backing.values();
	}

	@Override
	public Set<Map.Entry<K, V>> entrySet() {
		return backing.entrySet();
	}

	@Override
	public boolean equals(Object o) {
		return backing.equals(o);
	}

	@Override
	public int hashCode() {
		return backing.hashCode();
	}

	@Override
	public String toString() {
		return "CaffeineLayeredMap[" + backing.getName() + ", nearCacheSize=" + nearCache.estimatedSize() + "]";
	}
}
