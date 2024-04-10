/***********************************************************************
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
 **********************************************************************/
package org.idempiere.distributed;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Interface for distributed cache service
 */
public interface ICacheService {

	/**
	 * Get map for distributed cache
	 * @param <K>
	 * @param <V>
	 * @param name
	 * @return map for distributed cache
	 */
	public <K, V>Map<K, V> getMap(String name);
	
	/**
	 * Get list for distributed cache 
	 * @param <K>
	 * @param name
	 * @return list for distributed cache
	 */
	public <K>List<K> getList(String name);
	
	/**
	 * Get set for distributed cache
	 * @param <K>
	 * @param name
	 * @return set for distributed cache
	 */
	public <K>Set<K> getSet(String name);
	
	/**
	 * Tries to acquire the lock for a specified key.<br/>
	 * If the lock is not available, then the current thread becomes disabled for thread scheduling purposes and lies dormant 
	 * until one of two things happens - the lock is acquired by the current thread, or the specified waiting time elapses.
	 * 
	 * @param map
	 * @param key
	 * @param timeout
	 * @param timeunit
	 * @return true if lock is acquired, false otherwise
	 * @throws InterruptedException 
	 */
	public <K, V>boolean tryLock(Map<K, V> map, K key, long timeout, TimeUnit timeunit) throws InterruptedException;
	
	/**
	 * Releases the lock for the specified key. It never blocks and returns immediately.<br/>
	 * If the current thread is the holder of this lock, then the hold count is decremented.<br/>
	 * If the hold count is zero, then the lock is released.<br/> 
	 * If the current thread is not the holder of this lock, then IllegalMonitorStateException is thrown.
	 *  
	 * @param map
	 * @param key
	 */
	public <K, V>void unLock(Map<K, V> map, K key);
}
