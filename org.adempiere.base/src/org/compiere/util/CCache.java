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
import java.util.Map;
import java.util.Set;

import org.adempiere.base.Service;
import org.idempiere.distributed.ICacheService;

/**
 *  Cache for table.
 *	@param <K> Key 
 *	@param <V> Value
 *
 *  @author Jorg Janke
 *  @version $Id: CCache.java,v 1.2 2006/07/30 00:54:35 jjanke Exp $
 */
public class CCache<K,V> implements CacheInterface, Map<K, V>, Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2268565219001179841L;

	private Map<K, V> cache = null;
	
	private Set<K> nullList = null;

	private String m_tableName;

	private boolean m_distributed;
	
	public CCache (String name, int initialCapacity)
	{
		this(name, name, initialCapacity);
	}
	
	public CCache (String name, int initialCapacity, int expireMinutes)
	{
		this(name, initialCapacity, expireMinutes, false);
	}
	
	public CCache (String name, int initialCapacity, int expireMinutes, boolean distributed)
	{
		this(name, name, initialCapacity, expireMinutes, distributed);
	}
	
	/**
	 * 	Adempiere Cache - expires after 2 hours
	 * 	@param name (table) name of the cache
	 * 	@param initialCapacity initial capacity
	 */
	public CCache (String tableName, String name, int initialCapacity)
	{
		this (tableName, name, initialCapacity, false);
	}	//	CCache

	public CCache (String tableName, String name, int initialCapacity, boolean distributed)
	{
		this (tableName, name, initialCapacity, 120, distributed);
	}		
	
	/**
	 * 	Adempiere Cache
	 * 	@param name (table) name of the cache
	 * 	@param initialCapacity initial capacity
	 * 	@param expireMinutes expire after minutes (0=no expire)
	 */
	public CCache (String tableName, String name, int initialCapacity, int expireMinutes, boolean distributed)
	{
//		super(initialCapacity);
		m_name = name;
		m_tableName = tableName;
		setExpireMinutes(expireMinutes);
		cache = CacheMgt.get().register(this, distributed);
		m_distributed = distributed;
		if (distributed) {
			ICacheService provider = Service.locator().locate(ICacheService.class).getService();
			if (provider != null) {
				nullList = provider.getSet(name);
			}
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
	
	/**
	 * 	Get (table) Name
	 *	@return name
	 */
	public String getName()
	{
		return m_name;
	}	//	getName

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
	public int reset()
	{
		int no = cache.size();
		clear();
		return no;
	}	//	reset

	/**
	 * 	Expire Cache if enabled
	 */	
	private void expire()
	{
		if (m_expire != 0 && m_timeExp < System.currentTimeMillis())
		{
		//	System.out.println ("------------ Expired: " + getName() + " --------------------");
			reset();
		}
	}	//	expire

	/**
	 * 	String Representation
	 * 	@return info
	 */
	public String toString()
	{
		return "CCache[" + m_name 
			+ ",Exp=" + getExpireMinutes()  
			+ ", #" + cache.size() + "]";
	}	//	toString

	/**
	 * 	Clear cache and calculate new expiry time
	 *	@see java.util.Map#clear()
	 */
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
	public boolean containsKey(Object key)
	{
		expire();
		if (nullList != null)
		{
			return cache.containsKey(key) || nullList.contains(key);
		}
		else
		{
			return cache.containsKey(key);
		}
	}	//	containsKey

	/**
	 *	@see java.util.Map#containsValue(java.lang.Object)
	 */
	public boolean containsValue(Object value)
	{
		expire();
		return cache.containsValue(value);
	}	//	containsValue

	/**
	 *	@see java.util.Map#entrySet()
	 */
	public Set<Map.Entry<K,V>> entrySet()
	{
		expire();
		return cache.entrySet();
	}	//	entrySet

	/**
	 *	@see java.util.Map#get(java.lang.Object)
	 */
	public V get(Object key)
	{
		expire();
		return cache.get(key);
	}	//	get

	/**
	 * 	Put value
	 *	@param key key
	 *	@param value value
	 *	@return previous value
	 */
	public V put (K key, V value)
	{
		expire();
		m_justReset = false;
		if (value == null && m_distributed && nullList != null) {
			cache.remove(key);
			if (!nullList.contains(key))
				nullList.add(key);
			return null;
		}
		return cache.put (key, value);
	}	// put

	/**
	 * 	Put All
	 *	@param m map
	 */
	public void putAll (Map<? extends K, ? extends V> m)
	{
		expire();
		m_justReset = false;
		cache.putAll (m);
	}	//	putAll
	
	/**
	 *	@see java.util.Map#isEmpty()
	 */
	public boolean isEmpty()
	{
		expire();
		return cache.isEmpty();
	}	// isEmpty

	/**
	 *	@see java.util.Map#keySet()
	 */
	public Set<K> keySet()
	{
		expire();
		return cache.keySet();
	}	//	keySet

	/**
	 *	@see java.util.Map#size()
	 */
	public int size()
	{
		expire();
		return cache.size();
	}	//	size

	/**
	 * 	Get Size w/o Expire
	 *	@see java.util.Map#size()
	 *	@return size
	 */
	public int sizeNoExpire()
	{
		return cache.size();
	}	//	size

	/**
	 *	@see java.util.Map#values()
	 */
	public Collection<V> values()
	{
		expire();
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
		return cache.remove(key);
	}

	@Override
	public int reset(int recordId) {
		if (recordId <= 0)
			return reset();
				
		V removed = cache.remove(recordId);
		return removed != null ? 1 : 0;
	}

	@Override
	public void newRecord(int record_ID) {
	}
}	//	CCache
