/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.hazelcast.service;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.idempiere.distributed.ICacheService;

import com.hazelcast.map.IMap;

/**
 * @author hengsin
 *
 */
public class CacheServiceImpl implements ICacheService {

	/**
	 * default constructor
	 */
	public CacheServiceImpl() {
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.ICacheService#getCache(java.lang.String)
	 */
	@Override
	public <K, V> Map<K, V> getMap(String name) {
		if (Activator.getHazelcastInstance() != null)
			return Activator.getHazelcastInstance().getMap(name);
		else
			return null;
	}

	@Override
	public <K> List<K> getList(String name) {
		if (Activator.getHazelcastInstance() != null)
			return Activator.getHazelcastInstance().getList(name);
		else
			return null;
	}

	@Override
	public <K> Set<K> getSet(String name) {
		if (Activator.getHazelcastInstance() != null)
			return Activator.getHazelcastInstance().getSet(name);
		else
			return null;
	}

	@Override
	public <K, V> boolean tryLock(Map<K, V> map, K key, long timeout, TimeUnit timeunit) throws InterruptedException {
		if (map instanceof IMap<?, ?>) {
			IMap<K, V> imap = (IMap<K, V>) map;
			return imap.tryLock(key, timeout, timeunit);
		}
		return false;
	}

	@Override
	public <K, V> void unLock(Map<K, V> map, K key) {
		if (map instanceof IMap<?, ?>) {
			IMap<K, V> imap = (IMap<K, V>) map;
			imap.unlock(key);
		}
	}

}
