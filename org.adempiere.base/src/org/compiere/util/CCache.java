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

import java.beans.VetoableChangeListener;
import java.beans.VetoableChangeSupport;
import java.io.Serializable;
import java.util.Collection;
import java.util.ConcurrentModificationException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.LongAdder;

import org.adempiere.base.Core;
import org.compiere.model.SystemProperties;
import org.idempiere.distributed.ICacheService;

/**
 *  Default cache implementation, usually use for caching of table data.
 *	@param <K> Key 
 *	@param <V> Value
 *
 *  @author Jorg Janke
 *  @version $Id: CCache.java,v 1.2 2006/07/30 00:54:35 jjanke Exp $
 */
public class CCache<K,V> implements CacheInterface, Map<K, V>, Serializable
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 4960404895430292476L;

	/** Key:value map of cached items */
	protected Map<K, V> cache = null;
	
	/** Set of key that has null value */
	protected Set<K> nullList = null;

	private String m_tableName;

	private boolean m_distributed;
	
	private int m_maxSize = 0;
	
	/** Default cache expire time in minutes **/
	public static final int DEFAULT_EXPIRE_MINUTE = getDefaultExpireMinute();
	
	/**
	 * Get default expire minute from system property (fallback to 60)
	 * @return default expire time in minute
	 */
	private static int getDefaultExpireMinute() 
	{
		try 
		{
			String property = SystemProperties.getCacheExpireMinute();
			if (property != null && property.trim().length() > 0)
			{
				int expireMinute = 0;
				try
				{
					expireMinute = Integer.parseInt(property.trim());
				} catch (Throwable t) {}
				if (expireMinute > 0)
					return expireMinute;
			}
		} catch (Throwable t) {}
		return 60;
	}

	/**
	 * Get the max size for the cache based on a system property, 
	 * for example -DCache.MaxSize.AD_Column=15000 will set the max size for AD_Column.
	 * @param name
	 * @return max size for cache (-1 for no max size)
	 */
	private static int getCacheMaxSize(String name) 
	{
		try 
		{
			String property = SystemProperties.getCacheMaxSizeTable(name);
			if (property != null && property.trim().length() > 0)
			{
				int cacheMaxSize = 0;
				try
				{
					cacheMaxSize = Integer.parseInt(property.trim());
				} catch (Throwable t) {}
				if (cacheMaxSize > 0)
					return cacheMaxSize;
			}
		} catch (Throwable t) {}
		return -1;
	}
	
	/**
	 * Create new cache instance and register with {@link CacheMgt}
	 * @param name
	 * @param initialCapacity
	 */
	public CCache (String name, int initialCapacity)
	{
		this(name, name, initialCapacity);
	}
	
	/**
	 * Create new cache instance and register with {@link CacheMgt}
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 */
	public CCache (String name, int initialCapacity, int expireMinutes)
	{
		this(name, initialCapacity, expireMinutes, false);
	}
	
	/**
	 * Create new cache instance and register with {@link CacheMgt}
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 */
	public CCache (String name, int initialCapacity, int expireMinutes, boolean distributed)
	{
		this(name, name, initialCapacity, expireMinutes, distributed);
	}
	
	/**
	 * Create new cache instance and register with {@link CacheMgt}
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 * @param maxSize
	 */
	public CCache (String name, int initialCapacity, int expireMinutes, boolean distributed, int maxSize)
	{
		this(name, name, initialCapacity, expireMinutes, distributed, maxSize);
	}
	
	/**
	 *  Create new cache instance and register with {@link CacheMgt}
	 *  @param tableName
	 * 	@param name (table) name of the cache
	 * 	@param initialCapacity initial capacity // ignored
	 */
	public CCache (String tableName, String name, int initialCapacity)
	{
		this (tableName, name, initialCapacity, false);
	}	//	CCache

	/**
	 * Create new cache instance and register with {@link CacheMgt}
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param distributed
	 */
	public CCache (String tableName, String name, int initialCapacity, boolean distributed)
	{
		this (tableName, name, initialCapacity, DEFAULT_EXPIRE_MINUTE, distributed);
	}		
	
	/**
	 * Create new cache instance and register with {@link CacheMgt}
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 */
	public CCache (String tableName, String name, int initialCapacity, int expireMinutes, boolean distributed)
	{
		this(tableName, name, initialCapacity, expireMinutes, distributed, CacheMgt.MAX_SIZE);
	}
	
	/**
	 *  Create new cache instance and register with {@link CacheMgt}
	 *  @param tableName
	 * 	@param name (table) name of the cache
	 * 	@param initialCapacity initial capacity // ignored
	 * 	@param expireMinutes expire after minutes (0=no expire)
	 *  @param distributed true if cache should be distributed across server nodes
	 *  @param maxSize ignore if distributed=true (0=no max size)
	 *  @see {@link CacheMgt#register(CCache, boolean)}
	 *  @see {@link CacheMgt#unregister(CacheInterface)}
	 */
	public CCache (String tableName, String name, int initialCapacity, int expireMinutes, boolean distributed, int maxSize)
	{
		m_name = name;
		m_tableName = tableName;
		setExpireMinutes(expireMinutes);
		int propMaxSize = getCacheMaxSize(name);
		if (propMaxSize >= 0)
			m_maxSize = propMaxSize;
		else
			m_maxSize = maxSize; 
		cache = CacheMgt.get().register(this, distributed);
		m_distributed = distributed;
		if (distributed) {
			ICacheService provider = Core.getCacheService();
			if (provider != null) {
				nullList = provider.getSet(name);
			}
		} 
		
		if (nullList == null) {
			nullList = ConcurrentHashMap.newKeySet();
		}
	}	//	CCache

	/**	Name						*/
	private String				m_name = null;
	/** Expire after minutes		*/
	private int					m_expire = 0;
	/** Time						*/ 
	private volatile long		m_timeExp = 0;
	/**	Just reset - not used		*/
	private boolean				m_justReset = true;
	
	/** Vetoable Change Support			*/
	private VetoableChangeSupport	m_changeSupport = null;
	/** Vetoable Change Support	Name	*/
	private static String		PROPERTYNAME = "cache"; 
	
	private final LongAdder m_hit = new LongAdder();
	private final LongAdder m_miss = new LongAdder();
	
	/**
	 * 	Get (table) Name
	 *	@return name
	 */
	public String getName()
	{
		return m_name;
	}	//	getName

	/**
	 * Get table name
	 * @return table name
	 */
	public String getTableName()
	{
		return m_tableName;
	}
	
	/**
	 * 	Set Expire Minutes and start it
	 *	@param expireMinutes minutes or 0
	 */
	public void setExpireMinutes (int expireMinutes)
	{
		if (expireMinutes > 0)
		{
			m_expire = expireMinutes;
			long addMS = 60000L * m_expire;
			m_timeExp = System.currentTimeMillis() + addMS;
		}
		else
		{
			m_expire = 0;
			m_timeExp = 0;
		}
	}	//	setExpireMinutes

	/**
	 * 	Get Expire Minutes
	 *	@return expire minutes
	 */
	public int getExpireMinutes()
	{
		return m_expire;
	}	//	getExpireMinutes

	/**
	 * 	Cache was reset
	 *	@return true if reset
	 */
	public boolean isReset()
	{
		return m_justReset;
	}	//	isReset

	/**
	 * 	Resets the Reset flag
	 */
	public void setUsed()
	{
		m_justReset = false;
	}	//	setUsed
	
	/**
	 *	Reset Cache
	 * 	@return number of items cleared
	 *	@see org.compiere.util.CacheInterface#reset()
	 */
	@Override
	public int reset()
	{
		int no = cache.size()+nullList.size();
		clear();
		return no;
	}	//	reset

	/**
	 * 	String Representation
	 * 	@return info
	 */
	@Override
	public String toString()
	{
		return "CCache[" + m_name 
			+ ",Exp=" + getExpireMinutes()  
			+ ", #" + cache.size()
			+ ", Hit=" + getHit()
			+ ", Miss=" + getMiss()
			+ "]";
	}	//	toString

	/**
	 * 	Clear cache and calculate new expire time
	 *	@see java.util.Map#clear()
	 */
	@Override
	public void clear()
	{
		if (m_changeSupport != null)
		{
			try
			{
				m_changeSupport.fireVetoableChange(PROPERTYNAME, cache.size(), 0);
			}
			catch (Exception e)
			{
				System.out.println ("CCache.clear - " + e);
				return;
			}
		}
		//	Clear
		cache.clear();
		nullList.clear();
		if (m_expire != 0)
		{
			long addMS = 60000L * m_expire;
			m_timeExp = System.currentTimeMillis() + addMS;
		}
		m_justReset = true;
	}	//	clear
	
	/**
	 *	@see java.util.Map#containsKey(java.lang.Object)
	 */
	@Override
	public boolean containsKey(Object key)
	{
		if (key == null)
			return false;
		return cache.containsKey(key) || nullList.contains(key);
	}	//	containsKey

	/**
	 *	@see java.util.Map#containsValue(java.lang.Object)
	 */
	@Override
	public boolean containsValue(Object value)
	{
		if (value == null)
			return false;
		return cache.containsValue(value);
	}	//	containsValue

	/**
	 *  The return entry set exclude entries that contains null value
	 *	@see java.util.Map#entrySet()
	 */
	@Override
	public Set<Map.Entry<K,V>> entrySet()
	{
		return cache.entrySet();
	}	//	entrySet

	/**
	 *	@see java.util.Map#get(java.lang.Object)
	 */
	@Override
	public V get(Object key)
	{
		if (key == null)
			return null;
		V v = cache.get(key);
		if (v == null)
			if (nullList.contains(key))
				m_hit.add(1);
			else
				m_miss.add(1);
		else
			m_hit.add(1);
		return v;
	}	//	get

	/**
	 * 	Put value
	 *	@param key key
	 *	@param value value
	 *	@return previous value
	 */
	@Override
	public V put (K key, V value)
	{
		m_justReset = false;
		if (value == null) {
			cache.remove(key);
			nullList.add(key);
			return null;
		} else if (!nullList.isEmpty()) {
			nullList.remove(key);
		}
		return cache.put (key, value);
	}	// put

	/**
	 * 	Put All
	 *	@param m map
	 */
	@Override
	public void putAll (Map<? extends K, ? extends V> m)
	{
		m_justReset = false;
		cache.putAll (m);
	}	//	putAll
	
	/**
	 *	@see java.util.Map#isEmpty()
	 */
	@Override
	public boolean isEmpty()
	{
		return cache.isEmpty() && nullList.isEmpty();
	}	// isEmpty

	/**
	 * The return key set excludes key that map to null value
	 *	@see java.util.Map#keySet()
	 */
	@Override
	public Set<K> keySet()
	{
		return cache.keySet();
	}	//	keySet

	/**
	 *	@see java.util.Map#size()
	 */
	@Override
	public int size()
	{
		return cache.size()+nullList.size();
	}	//	size

	/**
	 * 	Get Size w/o Expire
	 *	@see java.util.Map#size()
	 *	@return size
	 */
	public int sizeNoExpire()
	{
		return cache.size()+nullList.size();
	}	//	size

	/**
	 *  The return values collection exclude null value entries
	 *	@see java.util.Map#values()
	 */
	@Override
	public Collection<V> values()
	{
		return cache.values();
	}	//	values

	
	/**
	 * 	Add Vetoable Change Listener
	 *	@param listener listner
	 */
	public void addVetoableChangeListener (VetoableChangeListener listener)
	{
		if (m_changeSupport == null)
			m_changeSupport = new VetoableChangeSupport (this);
		if (listener != null)
			m_changeSupport.addVetoableChangeListener(listener);
	}	//	addVetoableChangeListener

	/**
	 * 	Remove Vetoable Change Listener
	 *	@param listener listener
	 */
    public void removeVetoableChangeListener (VetoableChangeListener listener) 
    {
		if (m_changeSupport != null && listener != null)
			m_changeSupport.removeVetoableChangeListener(listener);
    }	//	removeVetoableChangeListener

	@Override
	public V remove(Object key) {
		if (!nullList.isEmpty()) {
			if (nullList.remove(key)) return null;
		}
		return cache.remove(key);
	}

	@Override
	public int reset(int recordId) {
		if (recordId <= 0)
			return reset();
		
		if (cache.isEmpty() && nullList.isEmpty())
			return 0;

		K firstKey = null;
		try {
			if (!cache.isEmpty())
				firstKey = cache.keySet().iterator().next();
			else if (!nullList.isEmpty())
				firstKey = nullList.iterator().next();
		} catch (ConcurrentModificationException e) {}
		if (firstKey != null && firstKey instanceof Integer) {
			if (!nullList.isEmpty()) {
				if (nullList.remove(recordId)) return 1;
			}
			V removed = cache.remove(recordId);
			return removed != null ? 1 : 0;
		} else {
			return reset();
		}
	}

	@Override
	public void newRecord(int record_ID) {
	}

	/**
	 * Get maximum size of cache
	 * @return max size of cache
	 */
	public int getMaxSize() {
		return m_maxSize;
	}
	
	/**
	 * Is cache distributed
	 * @return true if cache is distributed (using hazelcast)
	 */
	public boolean isDistributed() {
		return m_distributed;
	}
	
	/**
	 * Get cache hit count
	 * @return cache hit count
	 */
	public long getHit() {
		return m_hit.longValue();
	}
	
	/**
	 * Get cache miss count
	 * @return cache miss count
	 */
	public long getMiss() {
		return m_miss.longValue();
	}	
	
	/**
	 * @return true if cache has expire
	 */
	public boolean isExpire() {
		return m_expire > 0 && m_timeExp > 0 && m_timeExp < System.currentTimeMillis();
	}
}	//	CCache
