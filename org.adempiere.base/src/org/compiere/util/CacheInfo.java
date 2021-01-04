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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.compiere.util;

import java.io.Serializable;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import org.adempiere.base.Core;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;

/**
 * @author hengsin
 *
 */
public class CacheInfo implements Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -9069013908523249394L;
	
	private String name;
	private String tableName;
	private int size;
	private int expireMinutes;
	private int maxSize;
	private boolean distributed;
	private InetAddress nodeAddress;
	private String nodeId;
	private long hit;
	private long miss;

	/**
	 * 
	 */
	public CacheInfo(CCache<?, ?> cache) {
		name = cache.getName();
		tableName = cache.getTableName();
		size = cache.size();
		expireMinutes = cache.getExpireMinutes();
		maxSize = cache.getMaxSize();
		distributed = cache.isDistributed();
		hit = cache.getHit();
		miss = cache.getMiss();
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return the tableName
	 */
	public String getTableName() {
		return tableName;
	}

	/**
	 * @return the size
	 */
	public int getSize() {
		return size;
	}

	/**
	 * @return the expireMinutes
	 */
	public int getExpireMinutes() {
		return expireMinutes;
	}

	/**
	 * @return the maxSize
	 */
	public int getMaxSize() {
		return maxSize;
	}

	/**
	 * @return the distributed
	 */
	public boolean isDistributed() {
		return distributed;
	}

	
	/**
	 * @return the nodeAddress
	 */
	public InetAddress getNodeAddress() {
		return nodeAddress;
	}

	/**
	 * @return the nodeId
	 */
	public String getNodeId() {
		return nodeId;
	}

	/**
	 * 
	 * @return hit count
	 */
	public long getHit() {
		return hit;
	}
	
	/**
	 * 
	 * @return miss count
	 */
	public long getMiss() {
		return miss;
	}
	
	/**
	 * 
	 * @param sortByName
	 * @return cache infos
	 */
	public static List<CacheInfo> getCacheInfos(boolean sortByName) {
		IClusterService service = Core.getClusterService();
		if (service != null && service.getMembers().size() > 1) {
			List<CacheInfo> instances = new ArrayList<>();
			GetCacheInfoCallable callable = new GetCacheInfoCallable();
			Map<IClusterMember, Future<List<CacheInfo>>> futureMap = service.execute(callable, service.getMembers());
			if (futureMap != null) {
				try {
					Set<Entry<IClusterMember, Future<List<CacheInfo>>>> results = futureMap.entrySet();
					for(Entry<IClusterMember, Future<List<CacheInfo>>> f : results) {
						List<CacheInfo> response = f.getValue().get();
						if (response != null && response.size() > 0) {
							response.forEach(e -> {
								e.setNodeId(f.getKey().getId());
								e.setNodeAddress(f.getKey().getAddress());
								instances.add(e);
							});
						}
					}
				} catch (InterruptedException e) {
					throw new RuntimeException(e.getMessage(), e);
				} catch (ExecutionException e) {
					throw new RuntimeException(e.getMessage(), e);
				}
			}
			if (sortByName) {
				Collections.sort(instances, new Comparator<CacheInfo>() {
					@Override
					public int compare(CacheInfo o1, CacheInfo o2) {
						return o1.getName().compareTo(o2.getName());
					}
				});
			}
			return instances;
		} else {
			List<CacheInfo> instances = CacheMgt.get().getCacheInfos();
			if (sortByName) {
				Collections.sort(instances, new Comparator<CacheInfo>() {
					@Override
					public int compare(CacheInfo o1, CacheInfo o2) {
						return o1.getName().compareTo(o2.getName());
					}
				});
			}
			return instances;
		}		
	}

	private void setNodeAddress(InetAddress address) {
		nodeAddress = address;
	}

	private void setNodeId(String id) {
		nodeId = id;
	}
	
}
