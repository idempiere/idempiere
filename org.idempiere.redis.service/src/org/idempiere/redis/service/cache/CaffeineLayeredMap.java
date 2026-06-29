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
package org.idempiere.redis.service.cache;

import java.time.Duration;
import java.util.Collection;
import java.util.Map;
import java.util.Set;

import org.idempiere.redis.service.health.RedisHealth;
import org.redisson.api.RMap;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

/**
 * {@link Map} adapter that puts one or two Caffeine in-memory caches in front
 * of a Redisson {@link RMap}, separating two concerns that were previously
 * mixed in a single Caffeine instance:
 *
 * <ul>
 *   <li><b>near-cache</b>: small, short-TTL, sized to fit a memory budget.
 *       Speeds up hot reads when Redis is healthy. Always consulted first.</li>
 *   <li><b>fallback cache</b>: larger, longer-TTL, populated as a side-effect
 *       of every successful Redis read. Only consulted when the breaker is
 *       OPEN — its purpose is to serve a possibly-stale answer through
 *       Redis-down windows that outlast the near-cache TTL.</li>
 * </ul>
 *
 * <p>Splitting the two layers means each can be sized for its job without
 * compromise: a small near-cache to keep memory pressure low under steady
 * state, plus a generous fallback to bridge multi-minute outages without
 * eviction churn.</p>
 *
 * <p><b>Behaviour:</b></p>
 * <ul>
 *   <li><b>get</b>: near-cache first; on miss, if {@link RedisHealth} is
 *       healthy, ask Redis — on hit, populate <i>both</i> caches and return;
 *       on a Redis miss or failure, fall through. When the breaker is OPEN,
 *       return whatever the fallback cache has (or {@code null}).</li>
 *   <li><b>put</b> / <b>remove</b> / <b>clear</b>: mirror the change to both
 *       caches first, then try Redis. On Redis failure, the local mirrors
 *       still hold the new value so callers see consistent reads through the
 *       outage.</li>
 *   <li>Size and iteration delegate straight to Redis — Caffeine is a partial
 *       window over Redis content, never authoritative for membership.</li>
 * </ul>
 *
 * <p>This wrapper is opt-in per {@code RedisConfig.isNearCacheEnabled()}.
 * When disabled, {@link CacheServiceImpl} returns the raw {@link RMap} and
 * Redis failures surface as exceptions to the caller. The fallback layer is
 * additionally gated by {@code RedisConfig.isFallbackEnabled()}; when that is
 * off, only the near-cache is created and behaviour matches the single-tier
 * implementation that preceded the split.</p>
 *
 * <h3>Why not Redisson's {@code RLocalCachedMap}?</h3>
 *
 * <p>Redisson ships an {@code RLocalCachedMap} that bundles an in-memory
 * cache with cross-node auto-invalidation via internal pub/sub. It was
 * evaluated as a drop-in replacement and rejected for this bundle:</p>
 *
 * <ul>
 *   <li><b>Single-tier only.</b> {@code RLocalCachedMap} can be sized for
 *       fast reads <i>or</i> for outage bridging, not both — there is no
 *       built-in equivalent of the near-cache / fallback split that
 *       {@link #fallbackCache} provides here.</li>
 *   <li><b>Cross-node invalidation is redundant.</b> iDempiere's {@code CCache}
 *       layer already broadcasts cache-invalidation messages through
 *       {@code IMessageService} (which this bundle implements via
 *       {@code MessageServiceImpl}). Adding a second invalidation channel on
 *       top would duplicate work and double the topic load on Redis.</li>
 *   <li><b>Caffeine has richer eviction.</b> Window TinyLFU gives a measurably
 *       better hit rate on iDempiere's mixed-traffic workload than the
 *       LRU/LFU options Redisson exposes.</li>
 *   <li><b>Circuit-breaker coupling.</b> {@link RedisHealth} short-circuits
 *       reads to the local layer the moment Redis becomes unreachable.
 *       Reproducing the same behaviour on top of {@code RLocalCachedMap}
 *       would mean wrapping it anyway, which negates the simplification
 *       argument for switching.</li>
 * </ul>
 *
 * <p>Revisit this decision only if iDempiere ever drops {@code CCache}'s
 * message-based invalidation, or if the near-cache/fallback split proves
 * unnecessary in production telemetry.</p>
 */
public final class CaffeineLayeredMap<K, V> implements Map<K, V> {

	private final RMap<K, V> backing;
	private final Cache<K, V> nearCache;
	private final Cache<K, V> fallbackCache;
	private final RedisHealth health;

	public CaffeineLayeredMap(RMap<K, V> backing, RedisHealth health,
			int nearMaxSize, Duration nearExpireAfterWrite,
			int fallbackMaxSize, Duration fallbackExpireAfterWrite) {
		this.backing = backing;
		this.health = health;
		this.nearCache = Caffeine.newBuilder()
				.maximumSize(nearMaxSize)
				.expireAfterWrite(nearExpireAfterWrite)
				.build();
		// fallbackMaxSize <= 0 disables the fallback layer (single-tier mode).
		this.fallbackCache = (fallbackMaxSize > 0) ? Caffeine.newBuilder()
				.maximumSize(fallbackMaxSize)
				.expireAfterWrite(fallbackExpireAfterWrite)
				.build() : null;
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
			return fallbackGet(typed);
		}
		try {
			V remote = backing.get(typed);
			health.recordSuccess();
			if (remote != null) {
				nearCache.put(typed, remote);
				if (fallbackCache != null) {
					fallbackCache.put(typed, remote);
				}
			}
			return remote;
		} catch (Exception e) {
			health.recordFailure(e);
			return fallbackGet(typed);
		}
	}

	private V fallbackGet(K typed) {
		return fallbackCache != null ? fallbackCache.getIfPresent(typed) : null;
	}

	@Override
	public V put(K key, V value) {
		nearCache.put(key, value);
		if (fallbackCache != null) {
			fallbackCache.put(key, value);
		}
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
		if (fallbackCache != null) {
			fallbackCache.invalidate(typed);
		}
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
		if (fallbackCache != null) {
			fallbackCache.invalidateAll();
		}
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
			return fallbackCache != null && fallbackCache.getIfPresent(typed) != null;
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
		try {
			boolean r = backing.containsValue(value);
			health.recordSuccess();
			return r;
		} catch (Exception e) {
			health.recordFailure(e);
			throw e;
		}
	}

	@Override
	public int size() {
		try {
			int s = backing.size();
			health.recordSuccess();
			return s;
		} catch (Exception e) {
			health.recordFailure(e);
			throw e;
		}
	}

	@Override
	public boolean isEmpty() {
		try {
			boolean r = backing.isEmpty();
			health.recordSuccess();
			return r;
		} catch (Exception e) {
			health.recordFailure(e);
			throw e;
		}
	}

	@Override
	public void putAll(Map<? extends K, ? extends V> m) {
		// Eagerly mirror to both local layers; Redis write may partially fail.
		for (Map.Entry<? extends K, ? extends V> e : m.entrySet()) {
			nearCache.put(e.getKey(), e.getValue());
			if (fallbackCache != null) {
				fallbackCache.put(e.getKey(), e.getValue());
			}
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
		try {
			Set<K> r = backing.keySet();
			health.recordSuccess();
			return r;
		} catch (Exception e) {
			health.recordFailure(e);
			throw e;
		}
	}

	@Override
	public Collection<V> values() {
		try {
			Collection<V> r = backing.values();
			health.recordSuccess();
			return r;
		} catch (Exception e) {
			health.recordFailure(e);
			throw e;
		}
	}

	@Override
	public Set<Map.Entry<K, V>> entrySet() {
		try {
			Set<Map.Entry<K, V>> r = backing.entrySet();
			health.recordSuccess();
			return r;
		} catch (Exception e) {
			health.recordFailure(e);
			throw e;
		}
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
		StringBuilder sb = new StringBuilder("CaffeineLayeredMap[")
				.append(backing.getName())
				.append(", nearCacheSize=").append(nearCache.estimatedSize());
		if (fallbackCache != null) {
			sb.append(", fallbackSize=").append(fallbackCache.estimatedSize());
		}
		return sb.append(']').toString();
	}
}
