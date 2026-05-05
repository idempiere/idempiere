/******************************************************************************
 * Copyright (C) 2026 Norbert Bede                                            *
 * Copyright (C) 2026 CloudEmpiere                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * @contributor Norbert Bede                                                 *
 *****************************************************************************/
package org.idempiere.redis.service;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.idempiere.distributed.ICacheService;
import org.osgi.service.component.annotations.Component;

@Component(service = ICacheService.class, immediate = true)
public class CacheServiceImpl implements ICacheService {

	@Override
	public <K, V> Map<K, V> getMap(String name) {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}

	@Override
	public <K> List<K> getList(String name) {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}

	@Override
	public <K> Set<K> getSet(String name) {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}

	@Override
	public <K, V> boolean tryLock(Map<K, V> map, K key, long timeout, TimeUnit timeunit) throws InterruptedException {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}

	@Override
	public <K, V> void unLock(Map<K, V> map, K key) {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}
}
