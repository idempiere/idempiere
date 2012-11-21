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

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import org.adempiere.base.IServiceHolder;
import org.adempiere.base.Service;
import org.idempiere.distributed.ICacheService;
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
			s_cache = new CacheMgt();
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
		Map<K, V> map = null;
		if (distributed) 
		{
			ICacheService provider = Service.locator().locate(ICacheService.class).getService();
			if (provider != null)
				map = provider.getMap(name);
		}
		
		if (map == null)
		{
			map = new HashMap<K, V>();
		}		
		return map;
	}	//	register

	/**
	 * 	Un-Register Cache Instance
	 *	@param instance Cache
	 *	@return true if removed
	 */
	public boolean unregister (CacheInterface instance)
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
		IServiceHolder<IClusterService> holder = Service.locator().locate(IClusterService.class);
		IClusterService service = holder.getService();
		if (service != null) {			
			ResetCacheCallable callable = new ResetCacheCallable(tableName, recordId);
			Future<Collection<Integer>> future = service.execute(callable, service.getMembers());
			int total = 0;
			try {
				Collection<Integer> results = future.get();
				for(Integer i : results) 
				{
					total += i.intValue();
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
			return total;
		} else {
			return resetLocalCache(tableName, recordId);
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
		for (int i = 0; i < m_instances.size(); i++)
		{
			CacheInterface stored = (CacheInterface)m_instances.get(i);
			if (stored != null && stored.size() > 0)
			{
				log.fine(stored.toString());
				total += stored.reset();
				counter++;
			}
		}
		log.fine("#" + counter + " (" + total + ")");
		return total;
	}
	
	/**
	 * 	Reset local Cache
	 * 	@param tableName table name
	 * 	@param Record_ID record if applicable or 0 for all
	 * 	@return number of deleted cache entries
	 */
	@SuppressWarnings("unchecked")
	protected int resetLocalCache (String tableName, int Record_ID)
	{
		if (tableName == null)
			return resetLocalCache();
		if (!m_tableNames.contains(tableName))
			return 0;
		//
		int counter = 0;
		int total = 0;
		for (int i = 0; i < m_instances.size(); i++)
		{
			CacheInterface stored = (CacheInterface)m_instances.get(i);
			if (stored != null && stored instanceof CCache)
			{
				CCache cc = (CCache)stored;
				if (cc.getTableName() != null && cc.getTableName().startsWith(tableName))		//	reset lines/dependent too
				{
					{
						log.fine("(all) - " + stored);
						total += stored.reset(Record_ID);
						counter++;
					}
				}
			}
		}
		log.fine(tableName + ": #" + counter + " (" + total + ")");

		return total;
	}
	
	/**
	 * 	Total Cached Elements
	 *	@return count
	 */
	@SuppressWarnings("unchecked")
	public int getElementCount()
	{
		int total = 0;
		for (int i = 0; i < m_instances.size(); i++)
		{
			CacheInterface stored = (CacheInterface)m_instances.get(i);
			if (stored != null && stored.size() > 0)
			{
				log.fine(stored.toString());
				if (stored instanceof CCache)
					total += ((CCache)stored).sizeNoExpire();
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
		StringBuffer sb = new StringBuffer ("CacheMgt[");
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
		StringBuffer sb = new StringBuffer ("CacheMgt[");
		sb.append("Instances=")
			.append(m_instances.size())
			.append(", Elements=")
			.append(getElementCount())
			.append("]");
		return sb.toString ();
	}	//	toString	
}	//	CCache
