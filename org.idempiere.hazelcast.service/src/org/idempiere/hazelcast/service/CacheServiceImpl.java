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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;

import org.adempiere.base.Core;
import org.compiere.util.CacheMgt;
import org.compiere.util.ResetCacheCallable;
import org.idempiere.distributed.ICacheService;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.condition.Condition;

import com.hazelcast.map.IMap;

/**
 * @author hengsin
 *
 */
@Component(
		service = ICacheService.class,
		immediate = true,
		enabled = true)
public class CacheServiceImpl implements ICacheService {

	@Reference(target = "(osgi.condition.id=distributed.provider.hazelcast)")
    Condition distributedCondition;

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

	/**
	 * Resets the local cache on this node synchronously first, then dispatches the same reset
	 * to every other cluster member via {@link IClusterService#execute(Callable, java.util.Collection)}.
	 * Without this override, {@code ICacheService.broadcastReset}'s default no-op would mean
	 * {@code CacheMgt}'s cluster-wide reset path (which now only calls this method) never actually
	 * resets any node's local cache for the Hazelcast backend.
	 */
	@Override
	public void broadcastReset(String tableName, int recordId) {
		CacheMgt.get().resetLocalCache(tableName, recordId);
		executeOnOtherMembers(new ResetCacheCallable(tableName, recordId));
	}

	/** @see #broadcastReset(String, int) */
	@Override
	public void broadcastReset(String tableName, String key) {
		CacheMgt.get().resetLocalCache(tableName, key);
		executeOnOtherMembers(new ResetCacheCallable(tableName, key));
	}

	/**
	 * Dispatches {@code resetCallable} (which itself invokes {@code CacheMgt.get().resetLocalCache(...)})
	 * to every cluster member other than the local node. The local node's reset is already applied
	 * synchronously by the caller, so it is excluded here to avoid resetting it twice.
	 */
	private void executeOnOtherMembers(Callable<Integer> resetCallable) {
		IClusterService service = Core.getClusterService();
		if (service == null)
			return;
		IClusterMember local = service.getLocalMember();
		String localId = local != null ? local.getId() : null;
		List<IClusterMember> remoteMembers = new ArrayList<>();
		for (IClusterMember member : service.getMembers()) {
			if (localId == null || !localId.equals(member.getId()))
				remoteMembers.add(member);
		}
		if (!remoteMembers.isEmpty())
			service.execute(resetCallable, remoteMembers);
	}

}
