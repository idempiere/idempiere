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

import java.util.AbstractMap;
import java.util.AbstractSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.TimeUnit;

import org.redisson.api.RMapCache;

/**
 * Thin {@link Map} wrapper around Redisson's {@link RMapCache} that applies a
 * uniform TTL to every entry on {@link #put}.  Bounds Redis memory without
 * requiring the caller to know the Redisson API.
 *
 * <p>Exposes {@link #getName()} so {@link org.idempiere.redis.service.CacheServiceImpl#lockFor}
 * can derive a stable distributed-lock key even when this wrapper is in use.</p>
 *
 * <p>All reads and structural mutations delegate to the underlying {@link RMapCache}.
 * {@code put} and {@code putAll} additionally pass the configured TTL so Redis
 * assigns a per-entry expiry at write time.</p>
 *
 * <p>Implements {@link ConcurrentMap} — rather than {@code AbstractMap}'s inherited
 * {@code Map} default implementations of {@code putIfAbsent}/conditional {@code remove}/
 * {@code replace} (non-atomic check-then-act) — by forwarding directly to {@link RMapCache}'s
 * server-side-atomic equivalents, so concurrent cache fills cannot race and overwrite each other.
 * {@link #putIfAbsent(Object, Object)} uses the TTL-aware overload so a successful insert retains
 * the configured expiry, same as {@link #put}.</p>
 */
public final class TtlAwareMapCache<K, V> extends AbstractMap<K, V> implements ConcurrentMap<K, V> {

	private final RMapCache<K, V> backing;
	private final long ttlMs;

	public TtlAwareMapCache(RMapCache<K, V> backing, long ttlMs) {
		this.backing = backing;
		this.ttlMs = ttlMs;
	}

	public String getName() {
		return backing.getName();
	}

	public RMapCache<K, V> getBacking() {
		return backing;
	}

	// --- write operations with TTL ---

	@Override
	public V put(K key, V value) {
		return backing.put(key, value, ttlMs, TimeUnit.MILLISECONDS);
	}

	@Override
	public void putAll(Map<? extends K, ? extends V> m) {
		for (Map.Entry<? extends K, ? extends V> e : m.entrySet()) {
			backing.put(e.getKey(), e.getValue(), ttlMs, TimeUnit.MILLISECONDS);
		}
	}

	@Override
	public V remove(Object key) {
		return backing.remove(key);
	}

	@Override
	public void clear() {
		backing.clear();
	}

	// --- atomic ConcurrentMap operations, forwarded to RMapCache's server-side-atomic equivalents ---

	/** Atomic insert-if-absent that retains the configured TTL on success, unlike a plain {@link #put}-after-{@link #get} race. */
	@Override
	public V putIfAbsent(K key, V value) {
		return backing.putIfAbsent(key, value, ttlMs, TimeUnit.MILLISECONDS);
	}

	@Override
	public boolean remove(Object key, Object value) {
		return backing.remove(key, value);
	}

	@Override
	public boolean replace(K key, V oldValue, V newValue) {
		return backing.replace(key, oldValue, newValue);
	}

	@Override
	public V replace(K key, V value) {
		return backing.replace(key, value);
	}

	// --- read operations delegated to Redis ---

	@Override
	public V get(Object key) {
		return backing.get(key);
	}

	@Override
	public boolean containsKey(Object key) {
		return backing.containsKey(key);
	}

	@Override
	public boolean containsValue(Object value) {
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

	/** Routes setValue through the TTL-aware put so entries written via entrySet retain their expiry. */
	@Override
	public Set<Map.Entry<K, V>> entrySet() {
		return new AbstractSet<Map.Entry<K, V>>() {
			@Override
			public Iterator<Map.Entry<K, V>> iterator() {
				Iterator<Map.Entry<K, V>> it = backing.entrySet().iterator();
				return new Iterator<Map.Entry<K, V>>() {
					public boolean hasNext() { return it.hasNext(); }
					public Map.Entry<K, V> next() {
						Map.Entry<K, V> e = it.next();
						return new AbstractMap.SimpleEntry<K, V>(e.getKey(), e.getValue()) {
							@Override
							public V setValue(V value) {
								TtlAwareMapCache.this.put(e.getKey(), value);
								return super.setValue(value);
							}
						};
					}
					public void remove() { it.remove(); }
				};
			}
			@Override
			public int size() { return backing.size(); }
		};
	}
}
