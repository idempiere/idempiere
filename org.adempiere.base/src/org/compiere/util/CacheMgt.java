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
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.compiere.model.SystemProperties;
import org.idempiere.distributed.ICacheService;
import org.idempiere.distributed.IClusterMember;
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
	
	/** List of tables that have been temporary suspended for cache reset operations, usually for batch update/insert/delete */
	private final static Set<String> suspendedResetCacheTables = ConcurrentHashMap.newKeySet();
	
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
	 * @param tableName
	 * @param recordId record id for the cache entries to delete. pass -1 if you don't want to delete 
	 * cache entries by record id   
	 * @return number of deleted cache entries
	 */
	private int clusterReset(String tableName, int recordId) {
		IClusterService service = Core.getClusterService();
		if (service != null) {			
			ResetCacheCallable callable = new ResetCacheCallable(tableName, recordId);
			Map<IClusterMember, Future<Integer>> futureMap = service.execute(callable, service.getMembers());
			if (futureMap != null) {
				int total = 0;
				try {
					Collection<Future<Integer>> results = futureMap.values();
					for(Future<Integer> i : results) 
					{
						total += i.get();
					}
				} catch (InterruptedException e) {
					throw new RuntimeException(e);
				} catch (ExecutionException e) {
					if (e.getCause() != null)
						if (e.getCause() instanceof RuntimeException)
							throw (RuntimeException)e.getCause();
						else
							throw new RuntimeException(e.getCause());
					else
						throw new RuntimeException(e);
				}
				return total;
			} else {
				return resetLocalCache(tableName, recordId);
			}
		} else {
			return resetLocalCache(tableName, recordId);
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
		
		return clusterReset(tableName, Record_ID);
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
	 * 	Reset local Cache
	 * 	@param tableName table name
	 * 	@param Record_ID record if applicable or 0 for all
	 * 	@return number of deleted cache entries
	 */
	protected int resetLocalCache (String tableName, int Record_ID)
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
					total += stored.reset(Record_ID);
					counter++;
				}
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine(tableName + ": #" + counter + " (" + total + ")");

		CacheChangeListener[] listeners = m_listeners.toArray(new CacheChangeListener[0]);
		for(CacheChangeListener listener : listeners)
		{
			if (Record_ID == -1)
				listener.reset(tableName);
			else
				listener.reset(tableName, Record_ID);
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
}	//	CCache
