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
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.compiere.Adempiere;
import org.idempiere.distributed.ICacheService;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;

/**
 *  Adempiere Cache Management
 *
 *  @author Jorg Janke
 *  @version $Id: CacheMgt.java,v 1.2 2006/07/30 00:54:35 jjanke Exp $
 */
public class CacheMgt
{
	/**
	 * 	Get Cache Management
	 * 	@return Cache Manager
	 */
	public static synchronized CacheMgt get()
	{
		if (s_cache == null)
		{
			s_cache = new CacheMgt();
			startCacheMonitor();
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
	/** Background monitor to clear expire cache */
	private static final CacheMgt.CacheMonitor s_monitor = new CacheMgt.CacheMonitor();
	/** Default maximum cache size **/
	public static int MAX_SIZE = 1000;
	static 
	{
		try 
		{
			String maxSize = System.getProperty("Cache.MaxSize");
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
	
	/**************************************************************************
	 * 	Create Cache Instance
	 *	@param instance Cache
	 *  @param distributed
	 *	@return true if added
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
				IClusterService clusterService = Core.getClusterService();
				if (clusterService != null && !clusterService.isStandAlone())
					map = provider.getMap(name);
			}
		}
		
		if (map == null)
		{
			map = Collections.synchronizedMap(new MaxSizeHashMap<K, V>(instance.getMaxSize()));
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
	 * do a cluster wide cache reset 
	 * @return number of deleted cache entries
	 */
	private int  clusterReset() {
		return clusterReset(null, -1);
	}
	
	/**
	 * do a cluster wide cache reset for tableName with recordId key
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
	 * do a cluster wide cache reset for tableName with recordId key
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
	 * do a cluster wide cache reset 
	 * @return number of deleted cache entries
	 */
	public int reset() 
	{
		return clusterReset();
	}
	
	/**
	 * 	do a cluster wide cache reset for tableName
	 * 	@param tableName table name
	 * 	@return number of deleted cache entries
	 */
	public int reset (String tableName)
	{
		return reset(tableName, -1);
	}
	
	/**
	 * do a cluster wide cache reset for tableName with recordId key
	 * @param tableName
	 * @param Record_ID record id for the cache entries to delete. pass -1 if you don't want to delete 
	 * cache entries by record id
	 * @return number of deleted cache entries
	 */
	public int reset (String tableName, int Record_ID)
	{
		return clusterReset(tableName, Record_ID);
	}
	
	/**************************************************************************
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
			if (stored != null && stored instanceof CCache)
			{
				CCache<?, ?> cc = (CCache<?, ?>)stored;
				if (cc.getTableName() != null && cc.getTableName().startsWith(tableName))		//	reset lines/dependent too
				{
					{
						if (log.isLoggable(Level.FINE)) log.fine("(all) - " + stored);
						total += stored.reset(Record_ID);
						counter++;
					}
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
	 * 	Reset local Cache
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
				if (cc.getTableName() != null && cc.getTableName().startsWith(tableName))		//	reset lines/dependent too
				{
					{
						stored.newRecord(Record_ID);
					}
				}
			}
		}		
	}
	
	/**
	 * 	Total Cached Elements
	 *	@return count
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

	public void newRecord(String tableName, int recordId) {
		clusterNewRecord(tableName, recordId);
	}
	
	/**
	 * 
	 * @return cache infos
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
	
	private static class MaxSizeHashMap<K, V> extends LinkedHashMap<K, V> {
	    /**
		 * generated serial id
		 */
		private static final long serialVersionUID = 5532596165440544235L;
		private final int maxSize;

	    public MaxSizeHashMap(int maxSize) {
	        this.maxSize = maxSize;
	    }

	    @Override
	    protected boolean removeEldestEntry(Map.Entry<K, V> eldest) {
	        return maxSize <= 0 ? false : size() > maxSize;
	    }
	}
	
	private static synchronized void startCacheMonitor()
	{
		Adempiere.getThreadPoolExecutor().scheduleWithFixedDelay(s_monitor, 5, 5, TimeUnit.MINUTES);
	}

	private static class CacheMonitor implements Runnable
	{

		public void run()
		{
			CacheMgt instance = CacheMgt.get();
			if (!instance.m_instances.isEmpty())
			{
				CacheInterface[] caches = instance.m_instances.toArray(new CacheInterface[0]);
				for(int i = 0; i < caches.length; i++)
				{
					if (!(caches[i] instanceof CCache<?, ?>))
						continue;
					CCache<?, ?> cache = (CCache<?, ?>) caches[i];
					if (cache.isDistributed() || cache.getExpireMinutes() <= 0)
						continue;

					if (cache.isExpire())
					{
						cache.reset();
					}
				}
			}
		}
	}

	/**
	 * Is there a cache for this table name?
	 * @param tableName
	 * @return boolean
	 */
	public boolean hasCache(String tableName) {
		return m_tableNames.contains(tableName);
	}

}	//	CCache
