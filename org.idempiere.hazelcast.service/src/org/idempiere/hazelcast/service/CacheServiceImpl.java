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

import org.idempiere.distributed.ICacheService;

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
		if (Activator.hazelcastInstance != null)
			return Activator.hazelcastInstance.getMap(name);
		else
			return null;
	}

	@Override
	public <K> List<K> getList(String name) {
		if (Activator.hazelcastInstance != null)
			return Activator.hazelcastInstance.getList(name);
		else
			return null;
	}

	@Override
	public <K> Set<K> getSet(String name) {
		if (Activator.hazelcastInstance != null)
			return Activator.hazelcastInstance.getSet(name);
		else
			return null;
	}

}
