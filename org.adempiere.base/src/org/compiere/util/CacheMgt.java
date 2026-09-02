/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicLong;
import java.util.function.IntSupplier;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.compiere.Adempiere;
import org.compiere.model.SystemProperties;
import org.idempiere.distributed.ICacheService;
import org.idempiere.distributed.IClusterService;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.Scheduler;

/**
 *  iDempiere global Cache Manager
 *
 *  @author Jorg Janke
 *  @version $Id: CacheMgt.java,v 1.2 2006/07/30 00:54:35 jjanke Exp $
 */
public class CacheMgt
{
	/**
	 * 	Get global Cache Manager
	 * 	@return Cache Manager
	 */
	public static synchronized CacheMgt get()
	{
		if (s_cache == null)
		{
			s_cache = new CacheMgt();
		}
		return s_cache;
	}	//	get

	/**	Singleton					*/
	private static CacheMgt		s_cache = null;

	/**
	 *	Private Constructor
	 */
	private CacheMgt()
	{
	}	//	CacheMgt

	/**	List of Instances				*/
	private ArrayList<CacheInterface>	m_instances = new ArrayList<CacheInterface>();
	/** List of Table Names				*/
	private ArrayList<String>	m_tableNames = new ArrayList<String>();
	/** Logger							*/
	private static CLogger		log = CLogger.getCLogger(CacheMgt.class);
	/** Cache change listeners **/
	private List<CacheChangeListener> m_listeners = new ArrayList<CacheChangeListener>();
	/** Default maximum cache size **/
	public static int MAX_SIZE = 1000;
	static 
	{
		try 
		{
			String maxSize = SystemProperties.getCacheMaxSize();
			if (maxSize != null && maxSize.trim().length() > 0)
			{
				int max = 0;
				try
				{
					max = Integer.parseInt(maxSize.trim());
				} catch (Throwable t) {}
				if (max > 0)
					MAX_SIZE = max;
			}
		} catch (Throwable t) {}
	}

	/**
	 * Per-table (or per-record) in-flight guard for broadcast-triggered local resets.
	 * If a local reset for the same guard key is already running on this node, the duplicate is
	 * skipped. Key = {@link #resetInFlightGuardKey(String, String)}; value = AtomicBoolean flag
	 * (true = in-flight). Bounded to 2000 entries via Caffeine's size-based eviction to prevent
	 * unbounded growth from per-record guard keys.
	 */
	private static final Cache<String, AtomicBoolean> resetInFlight =
			Caffeine.newBuilder()
				.maximumSize(2000)
				.build();

	/**
	 * Maximum random jitter (ms) applied before a broadcast-triggered local cache reset
	 * so nodes on the same cluster don't all reload from the DB at the same millisecond.
	 * Override via {@code Cache.ResetJitterMaxMs} (default: 500).
	 */
	private static final long RESET_JITTER_MAX_MS;
	static {
		long jitter = 500L;
		try {
			String prop = System.getProperty("Cache.ResetJitterMaxMs");
			if (prop != null && !prop.trim().isEmpty()) {
				long parsed = Long.parseLong(prop.trim());
				if (parsed >= 0) jitter = parsed;
			}
		} catch (Throwable t) {}
		RESET_JITTER_MAX_MS = jitter;
	}

	/** Fired once to avoid spamming the log when the cluster service is unavailable at startup. */
	private static final AtomicBoolean degradedStartupLogged = new AtomicBoolean(false);

	/** List of tables that have been temporary suspended for cache reset operations, usually for batch update/insert/delete */
	private final static Set<String> suspendedResetCacheTables = ConcurrentHashMap.newKeySet();

	/**
	 * Tables whose cache invalidation broadcast to the cluster is rate-limited (debounced) rather
	 * than sent on every local reset/new-record notification. Loaded once from system property
	 * {@code Cache.ClusterResetDebounceTables} (comma-separated table names). High-write
	 * transactional tables (e.g. a message queue table) should be listed here to prevent per-insert
	 * cluster RPC fan-out from exhausting the distributed cache's pub/sub subscription pool.
	 * <p>Unlike a hard opt-out, this bounds cross-node staleness to at most
	 * {@link #CLUSTER_RESET_DEBOUNCE_MS} instead of leaving it unbounded: the local node always
	 * resets immediately, and the cluster-wide broadcast fires at most once per debounce window
	 * (leading edge), with a single trailing broadcast scheduled to catch up any writes suppressed
	 * during that window.
	 */
	private static final Set<String> debouncedResetTables;
	static {
		Set<String> tables = ConcurrentHashMap.newKeySet();
		try {
			String prop = System.getProperty("Cache.ClusterResetDebounceTables");
			if (prop != null && !prop.trim().isEmpty()) {
				Arrays.stream(prop.split(","))
					.map(String::trim)
					.filter(s -> !s.isEmpty())
					.forEach(tables::add);
			}
		} catch (Throwable t) {}
		debouncedResetTables = tables;
	}

	/** Default value of {@link #CLUSTER_RESET_DEBOUNCE_MS} when {@code Cache.ClusterResetDebounceMs} is not set. */
	private static final long DEFAULT_CLUSTER_RESET_DEBOUNCE_MS = 1000L;

	/**
	 * Minimum interval between cluster-wide broadcasts for a table listed in
	 * {@link #debouncedResetTables}. Override via {@code Cache.ClusterResetDebounceMs}
	 * (default {@link #DEFAULT_CLUSTER_RESET_DEBOUNCE_MS}).
	 */
	private static final long CLUSTER_RESET_DEBOUNCE_MS;
	static {
		long debounce = DEFAULT_CLUSTER_RESET_DEBOUNCE_MS;
		try {
			String prop = System.getProperty("Cache.ClusterResetDebounceMs");
			if (prop != null && !prop.trim().isEmpty()) {
				long parsed = Long.parseLong(prop.trim());
				if (parsed >= 0) debounce = parsed;
			}
		} catch (Throwable t) {}
		CLUSTER_RESET_DEBOUNCE_MS = debounce;
	}

	/** Per-table debounce bookkeeping for {@link #debouncedResetTables}. */
	private static final class DebounceState {
		final AtomicLong lastBroadcastAtMs = new AtomicLong(0);
		final AtomicBoolean trailingScheduled = new AtomicBoolean(false);
	}
	private static final Map<String, DebounceState> debounceStateByTable = new ConcurrentHashMap<>();

	/**
	 * Returns {@code true} if cluster-wide broadcast for this table is debounced rather than sent
	 * on every local reset.
	 * @param tableName table name to check; {@code null} is never debounced
	 */
	private static boolean isDebouncedResetTable(String tableName) {
		return tableName != null && debouncedResetTables.contains(tableName);
	}

	/**
	 * Broadcasts a cluster-wide whole-table reset for a {@link #debouncedResetTables} table,
	 * rate-limited to at most one broadcast per {@link #CLUSTER_RESET_DEBOUNCE_MS}. The caller is
	 * expected to have already applied the local reset/new-record notification synchronously
	 * before calling this — only the cross-node broadcast is throttled, so this node itself is
	 * never stale for its own writes.
	 *
	 * <p>If the debounce window has elapsed, broadcasts immediately (leading edge). Otherwise the
	 * broadcast is suppressed for now, but exactly one trailing broadcast is scheduled to run when
	 * the window closes, so remote nodes still catch up even if writes to this table stop mid-burst.
	 * A single whole-table reset (record id -1) is used for both edges since multiple distinct
	 * records may have been coalesced into one broadcast.
	 *
	 * @param tableName table to broadcast a debounced reset for; must be non-null
	 */
	private static void broadcastDebouncedReset(String tableName) {
		DebounceState state = debounceStateByTable.computeIfAbsent(tableName, k -> new DebounceState());
		long now = System.currentTimeMillis();
		long last = state.lastBroadcastAtMs.get();
		if (now - last >= CLUSTER_RESET_DEBOUNCE_MS && state.lastBroadcastAtMs.compareAndSet(last, now)) {
			doBroadcastTableReset(tableName);
			return;
		}
		if (state.trailingScheduled.compareAndSet(false, true)) {
			long delay = Math.max(0, CLUSTER_RESET_DEBOUNCE_MS - (now - last));
			Adempiere.getThreadPoolExecutor().schedule(() -> {
				state.trailingScheduled.set(false);
				state.lastBroadcastAtMs.set(System.currentTimeMillis());
				doBroadcastTableReset(tableName);
			}, delay, TimeUnit.MILLISECONDS);
		}
	}

	/** Fire-and-forget cluster-wide whole-table reset broadcast; no-op if no distributed cache service is available. */
	private static void doBroadcastTableReset(String tableName) {
		ICacheService cacheService = Core.getCacheService();
		if (cacheService != null) {
			cacheService.broadcastReset(tableName, -1);
		}
	}

	/**
	 * 	Register new CCache Instance.<br/>
	 *  This is use by {@link CCache} and developer usually shouldn't call this directly.
	 *	@param instance Cache
	 *  @param distributed
	 *	@return map for CCache
	 */
	public synchronized <K,V>Map<K, V> register (CCache<K, V> instance, boolean distributed)
	{
		if (instance == null)
			return null;
		
		String name = instance.getName();
		String tableName = instance.getTableName();
		if (tableName != null)
			m_tableNames.add(tableName);
		
		m_instances.add (instance);
		
		if (tableName == null && instance instanceof CacheChangeListener)
		{
			m_listeners.add((CacheChangeListener) instance);
		}
		
		Map<K, V> map = null;
		if (distributed) 
		{
			ICacheService provider = Core.getCacheService();
			if (provider != null)
			{
				// for better performance, do not use distributed cache if this is a stand alone instance
				IClusterService clusterService = Core.getClusterService();
				if (clusterService != null && !clusterService.isStandAlone())
					map = provider.getMap(name);
			}
		}
		
		// not distributed cache or distributed cache service is not available
		if (map == null)
		{
			int maxSize = instance.getMaxSize();
			if (maxSize > 0 || instance.getExpireMinutes() > 0)
			{
				// cache with max size and/or expire minutes
				Caffeine<Object, Object> builder = Caffeine.newBuilder();
				if (maxSize > 0)
					builder.maximumSize(maxSize);
				if (instance.getExpireMinutes() > 0)					
					builder.scheduler(Scheduler.systemScheduler())
					 	   .expireAfterAccess(instance.getExpireMinutes(), TimeUnit.MINUTES);
				Cache<K, V> cache = builder.build();
				map = cache.asMap();
			}
			else
			{
				// no max size, no expire minutes, use simple concurrent hash map for best performance
				map = new ConcurrentHashMap<K, V>();
			}
		}		
		return map;
	}	//	register

	/**
	 * 	Un-Register Cache Instance
	 *	@param instance Cache
	 *	@return true if removed
	 */
	public synchronized boolean unregister (CacheInterface instance)
	{
		if (instance == null)
			return false;
		boolean found = false;
		//	Could be included multiple times
		for (int i = m_instances.size()-1; i >= 0; i--)
		{
			CacheInterface stored = (CacheInterface)m_instances.get(i);
			if (instance.equals(stored))
			{
				m_instances.remove(i);
				found = true;
			}
		}
		return found;
	}	//	unregister

	/**
	 * Do a cluster wide cache reset 
	 * @return number of deleted cache entries
	 */
	private int  clusterReset() {
		return clusterReset(null, -1);
	}
	
	/**
	 * Do a cluster wide cache reset for tableName with recordId key
	 * @param tableName name of cache
	 * @param recordId cache key. -1 to reset all cache entries for this table
	 * @return number of deleted cache entries
	 */
	private int clusterReset(String tableName, int recordId) {
		return clusterResetInternal(tableName, recordId);
	}
	
	/**
	 * Do a cluster wide cache reset for tableName with string key
	 * @param tableName name of cache
	 * @param key cache key
	 * @return number of deleted cache entries
	 */
	private int clusterReset(String tableName, String key) {
		return clusterResetInternal(tableName, key);
	}
	
	/**
	 * Do a cluster wide cache reset for tableName with key.
	 * Uses fire-and-forget broadcast via {@link ICacheService#broadcastReset} so the
	 * calling thread is never blocked waiting for remote node acknowledgements.
	 * Falls back to local-only reset when no distributed cache service is available.
	 *
	 * @param tableName name of cache
	 * @param key integer or string cache key
	 * @return number of deleted local cache entries (remote resets happen asynchronously)
	 */
	private <K> int clusterResetInternal(String tableName, K key) {
		ICacheService cacheService = Core.getCacheService();
		if (cacheService != null) {
			// Fire-and-forget: publishes to a durable topic; all nodes (including this one)
			// apply the reset asynchronously upon receipt. No reply is awaited.
			if (key instanceof Integer) {
				cacheService.broadcastReset(tableName, (Integer) key);
			} else {
				cacheService.broadcastReset(tableName, key.toString());
			}
			return 0;
		} else {
			// Cache service unavailable — log once so boot-time degradation is visible
			// rather than silently falling back on every cache reset.
			if (degradedStartupLogged.compareAndSet(false, true)) {
				log.warning("Distributed cache service unavailable at cache reset time "
						+ "(Redis/Hazelcast not yet started or failed to init)"
						+ " — falling back to local-only cache resets. Further fallbacks will be silent.");
			}
			if (key instanceof Integer) {
				return resetLocalCache(tableName, (Integer) key);
			} else {
				return resetLocalCache(tableName, key.toString());
			}
		}
	}
	
	/**
	 * Do a cluster wide cache reset for tableName with recordId key
	 * @param tableName
	 * @param recordId record id for the cache entries to delete. pass -1 if you don't want to delete 
	 * cache entries by record id   
	 * @return number of deleted cache entries
	 */
	private void clusterNewRecord(String tableName, int recordId) {
		if (isDebouncedResetTable(tableName)) {
			localNewRecord(tableName, recordId);
			broadcastDebouncedReset(tableName);
			return;
		}
		IClusterService service = Core.getClusterService();
		if (service != null) {			
			CacheNewRecordCallable callable = new CacheNewRecordCallable(tableName, recordId);
			if (service.execute(callable, service.getMembers()) == null) {
				localNewRecord(tableName, recordId);
			}
		} else {
			localNewRecord(tableName, recordId);
		}
	}
	
	/**
	 * Do a cluster wide cache reset 
	 * @return number of deleted cache entries
	 */
	public int reset() 
	{
		return clusterReset();
	}
	
	/**
	 * 	Do a cluster wide cache reset for tableName
	 * 	@param tableName table name
	 * 	@return number of deleted cache entries
	 */
	public int reset (String tableName)
	{
		return reset(tableName, -1);
	}
	
	/**
	 * Do a cluster wide cache reset for tableName with recordId key
	 * @param tableName
	 * @param Record_ID record id for the cache entries to delete. pass -1 if you don't want to delete 
	 * cache entries by record id
	 * @return number of deleted cache entries
	 */
	public int reset (String tableName, int Record_ID)
	{
		if (suspendedResetCacheTables.contains(tableName))
			return 0;
		if (isDebouncedResetTable(tableName)) {
			int count = resetLocalCache(tableName, Record_ID);
			broadcastDebouncedReset(tableName);
			return count;
		}
		return clusterReset(tableName, Record_ID);
	}
	
	/**
	 * Do a cluster wide cache reset for tableName with key
	 * @param tableName cache name
	 * @param key cache key
	 * @return number of deleted cache entries
	 */
	public int reset(String tableName, String key)
	{
		if (suspendedResetCacheTables.contains(tableName))
			return 0;
		if (isDebouncedResetTable(tableName)) {
			int count = resetLocalCache(tableName, key);
			broadcastDebouncedReset(tableName);
			return count;
		}
		return clusterReset(tableName, key);
	}
	
	/**
	 * 	Reset local Cache
	 * 	@return number of deleted cache entries
	 */
	public int resetLocalCache()
	{
		int counter = 0;
		int total = 0;
		CacheInterface[] instances = getInstancesAsArray();
		for (CacheInterface stored : instances)
		{
			if (stored != null && stored.size() > 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine(stored.toString());
				total += stored.reset();
				counter++;
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine("#" + counter + " (" + total + ")");
		return total;
	}

	/**
	 * Get cache instances
	 * @return cache instances
	 */
	public synchronized CacheInterface[] getInstancesAsArray() {
		return m_instances.toArray(new CacheInterface[0]);
	}
	
	/**
	 * Reset local Cache
	 * @param tableName cache name
	 * @param recordId cache key
	 * @return number of deleted cache entries
	 */
	public int resetLocalCache (String tableName, Integer recordId)
	{
		return resetLocalCacheInternal(tableName, recordId);
	}

	/**
	 * Reset the local cache for {@code tableName} with anti-stampede protection.
	 * Called by the broadcast invalidation subscriber so nodes don't all hammer the DB simultaneously:
	 * <ul>
	 *   <li>When {@code Cache.ResetJitterMaxMs} is &gt; 0, the actual reset is deferred onto
	 *       {@link Adempiere#getThreadPoolExecutor()}'s delay queue by a random 0–{@code
	 *       Cache.ResetJitterMaxMs} ms so cluster members don't all reload from the DB at the same
	 *       millisecond — the queued delay costs no worker thread while pending, unlike blocking the
	 *       caller with {@code Thread.sleep}. In that case this method returns {@code 0} immediately;
	 *       the real reset count is only known once the queued task runs.</li>
	 *   <li>Uses a per-{@link #resetInFlightGuardKey(String, String) guard key} {@link AtomicBoolean}
	 *       in-flight guard: if a reset is already in progress (or queued) on this node for the same
	 *       guard key, the duplicate is skipped.</li>
	 * </ul>
	 *
	 * @param tableName table to reset; when {@code null} resets all caches
	 * @param recordId  integer key; -1 resets all entries for the table
	 */
	// guard scope: whole-table resets (recordId == -1, or tableName == null) share one in-flight
	// slot per table since they clear every record; a specific recordId gets its own slot so a
	// reset for one record is never skipped in favor of an unrelated record's in-flight reset.
	public int resetLocalCacheWithAntiStampede(String tableName, int recordId) {
		String guardKey = resetInFlightGuardKey(tableName, recordId == -1 ? null : String.valueOf(recordId));
		return applyWithAntiStampede(guardKey, () -> resetLocalCache(tableName, recordId));
	}

	/**
	 * Builds the {@link #resetInFlight} guard key for an anti-stampede local reset.
	 * @param tableName table to reset; {@code null} means "reset all caches"
	 * @param scopeKey  the specific record id / string key being reset, or {@code null} for a
	 *                  whole-table (or whole-cache) reset
	 * @return {@code "__all__"} for a whole-cache reset, {@code tableName} for a whole-table
	 *         reset, or {@code tableName + "#" + scopeKey} for a key-specific reset
	 */
	private static String resetInFlightGuardKey(String tableName, String scopeKey) {
		if (tableName == null)
			return "__all__";
		return scopeKey == null ? tableName : tableName + "#" + scopeKey;
	}

	/**
	 * Shared anti-stampede logic for {@link #resetLocalCacheWithAntiStampede(String, int)} and
	 * {@link #resetLocalCacheWithAntiStampede(String, String)}: acquires the per-{@code guardKey}
	 * in-flight flag, then either runs {@code resetAction} immediately (no jitter configured) or
	 * schedules it on {@link Adempiere#getThreadPoolExecutor()}'s delay queue after a random 0–
	 * {@link #RESET_JITTER_MAX_MS} ms stagger. The flag is released once {@code resetAction}
	 * actually completes, whichever path ran it.
	 *
	 * @return the reset count when run synchronously; {@code 0} when the caller lost the guard race
	 *         or the reset was queued for deferred execution
	 */
	private int applyWithAntiStampede(String guardKey, IntSupplier resetAction) {
		AtomicBoolean flag = resetInFlight.get(guardKey, k -> new AtomicBoolean(false));
		if (!flag.compareAndSet(false, true)) {
			if (log.isLoggable(Level.FINE))
				log.fine("Anti-stampede: skipping duplicate local cache reset for " + guardKey);
			return 0;
		}
		if (RESET_JITTER_MAX_MS <= 0) {
			try {
				return resetAction.getAsInt();
			} finally {
				flag.set(false);
			}
		}
		long jitter = ThreadLocalRandom.current().nextLong(0, RESET_JITTER_MAX_MS + 1);
		Adempiere.getThreadPoolExecutor().schedule(() -> {
			try {
				resetAction.getAsInt();
			} catch (Throwable t) {
				log.log(Level.WARNING, "Anti-stampede queued local cache reset failed for " + guardKey, t);
			} finally {
				flag.set(false);
			}
		}, jitter, TimeUnit.MILLISECONDS);
		return 0;
	}

	/**
	 * Reset local Cache
	 * @param tableName cache name
	 * @param key cache key
	 * @return number of deleted cache entries
	 */
	public int resetLocalCache (String tableName, String key)
	{
		return resetLocalCacheInternal(tableName, key);
	}

	/**
	 * Reset the local cache for {@code tableName} with anti-stampede protection.
	 * See {@link #resetLocalCacheWithAntiStampede(String, int)} for the jitter/queueing and
	 * in-flight guard semantics.
	 * @param tableName table to reset
	 * @param key       string key; empty string resets all entries for the table
	 */
	// guard scope: whole-table resets (key blank, or tableName == null) share one in-flight slot
	// per table since they clear every record; a specific key gets its own slot so a reset for
	// one key is never skipped in favor of an unrelated key's in-flight reset.
	public int resetLocalCacheWithAntiStampede(String tableName, String key) {
		String guardKey = resetInFlightGuardKey(tableName, (key == null || key.isEmpty()) ? null : key);
		return applyWithAntiStampede(guardKey, () -> resetLocalCache(tableName, key));
	}


	/**
	 * 	Reset local Cache
	 * 	@param tableName table name
	 * 	@param key integer or string cache key
	 * 	@return number of deleted cache entries
	 */
	private <K> int resetLocalCacheInternal (String tableName, K key)
	{
		if (tableName == null)
			return resetLocalCache();
		if (!m_tableNames.contains(tableName))
			return 0;
		//
		int counter = 0;
		int total = 0;
		CacheInterface[] instances = getInstancesAsArray();
		for (CacheInterface stored : instances)
		{
			if (stored != null && stored instanceof CCache && stored.size() > 0)
			{
				CCache<?, ?> cc = (CCache<?, ?>)stored;
				if (cc.getTableName() != null && cc.getTableName().equalsIgnoreCase(tableName))
				{
					if (log.isLoggable(Level.FINE)) log.fine("(all) - " + stored);
					total += key instanceof Integer id ? stored.reset(id) : stored.resetByStringKey(key.toString());
					counter++;
				}
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine(tableName + ": #" + counter + " (" + total + ")");

		CacheChangeListener[] listeners = m_listeners.toArray(new CacheChangeListener[0]);
		for(CacheChangeListener listener : listeners)
		{
			if ((key instanceof Integer id && id == -1) || (key.toString().length() == 0))
				listener.reset(tableName);
			else
				listener.reset(tableName, key.toString());
		}
		
		return total;
	}
	
	/**
	 * 	New record notification for local cache instances
	 * 	@param tableName table name
	 * 	@param Record_ID record if applicable or 0 for all
	 */
	protected void localNewRecord (String tableName, int Record_ID)
	{
		if (tableName == null)
			return;
		
		if (!m_tableNames.contains(tableName))
			return;
		//
		CacheInterface[] instances = getInstancesAsArray();
		for (CacheInterface stored : instances)
		{
			if (stored != null && stored instanceof CCache)
			{
				CCache<?, ?> cc = (CCache<?, ?>)stored;
				if (cc.getTableName() != null && cc.getTableName().equalsIgnoreCase(tableName))
				{
					stored.newRecord(Record_ID);
				}
			}
		}		
	}
	
	/**
	 * 	Get Total Cached Elements
	 *	@return total cache element count
	 */
	public int getElementCount()
	{		
		int total = 0;
		CacheInterface[] instances = getInstancesAsArray();
		for (CacheInterface stored : instances)
		{
			if (stored != null && stored.size() > 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine(stored.toString());
				if (stored instanceof CCache)
					total += ((CCache<?, ?>)stored).sizeNoExpire();
				else
					total += stored.size();
			}
		}
		return total;
	}	//	getElementCount
	
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("CacheMgt[");
		sb.append("Instances=")
			.append(m_instances.size())
			.append("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Extended String Representation
	 *	@return info
	 */
	public String toStringX ()
	{
		StringBuilder sb = new StringBuilder ("CacheMgt[");
		sb.append("Instances=")
			.append(m_instances.size())
			.append(", Elements=")
			.append(getElementCount())
			.append("]");
		return sb.toString ();
	}	//	toString	

	/**
	 * New record notification
	 * @param tableName
	 * @param recordId
	 */
	public void newRecord(String tableName, int recordId) {
		if (suspendedResetCacheTables.contains(tableName))
			return;
		
		clusterNewRecord(tableName, recordId);
	}
	
	/**
	 * Get info for cache instances
	 * @return info for cache instances
	 */
	public List<CacheInfo> getCacheInfos() {
		List<CacheInfo> infos = new ArrayList<>();
		CacheInterface[] instances = getInstancesAsArray();
		for(CacheInterface ci : instances) {
			if (ci instanceof CCache<?, ?>) {
				infos.add(new CacheInfo((CCache<?, ?>) ci));
			}
		}
		return infos;
	}
	
	/**
	 * Is there a cache instance for this table name?
	 * @param tableName
	 * @return boolean
	 */
	public boolean hasCache(String tableName) {
		return m_tableNames.contains(tableName);
	}

	/**
	 * Suspend cache reset operations for tableName (usually to improve performance for batch operations).<br/>
	 * Caller must call {@link #resumeTableCacheReset(String)} later to clear the suspend cache reset flag.
	 * @param tableName
	 */
	public void suspendTableCacheReset(String tableName) {
		suspendedResetCacheTables.add(tableName);
	}
	
	/**
	 * Clear suspend cache reset flag for tableName
	 * @param tableName
	 */
	public void resumeTableCacheReset(String tableName) {
		suspendedResetCacheTables.remove(tableName);
	}

	/**
	 * Schedule cache reset after transaction commit. If trxName is null or transaction cannot be found, the cache reset will be scheduled immediately
	 *   exceptions are logged and ignored
	 * @param cacheName
	 * @param key - can be an Integer ID or String key, if key is -1, the whole cache will be reset
	 * @param newRecord
	 * @param trxName
	 */
	public static void scheduleCacheReset(String cacheName, Object key, boolean newRecord, String trxName) {
		if (!CacheMgt.get().hasCache(cacheName))
			return;
		if (key instanceof Integer && (Integer)key == 0)
			return;
		try {
			boolean cacheResetScheduled = false;
			if (trxName != null) {
				Trx trx = Trx.get(trxName, false);
				if (trx != null) {
					trx.addTrxEventListener(new TrxEventListener() {
						@Override
						public void afterRollback(Trx trx, boolean success) {
							trx.removeTrxEventListener(this);
						}
						@Override
						public void afterCommit(Trx sav, boolean success) {
							if (success) {
								if (!newRecord) {
									if (key instanceof Integer)
										Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(cacheName, (Integer) key));
									else
										Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(cacheName, String.valueOf(key)));
								} else if (key instanceof Integer && (Integer)key > 0) {
									Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().newRecord(cacheName, (Integer) key));
								}
							}
							trx.removeTrxEventListener(this);
						}
						@Override
						public void afterClose(Trx trx) {
						}
					});
					cacheResetScheduled = true;
				}
			}
			if (!cacheResetScheduled) {
				if (!newRecord) {
					if (key instanceof Integer)
						Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(cacheName, (Integer) key));
					else
						Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(cacheName, String.valueOf(key)));
				} else if (key instanceof Integer && (Integer)key > 0) {
					Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().newRecord(cacheName, (Integer) key));
				}
			}
		} catch (RuntimeException ex) {
			log.log(Level.WARNING, "Failed to enqueue cache reset for " + cacheName + ", key=" + String.valueOf(key) + ", newRecord=" + newRecord + ", trxName=" + trxName, ex);
		}
	}

}	//	CacheMgt
