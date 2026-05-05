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

import java.util.Collection;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;

import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.osgi.service.component.annotations.Component;

@Component(service = IClusterService.class)
public class ClusterServiceImpl implements IClusterService {

	@Override
	public Collection<IClusterMember> getMembers() {
		throw new UnsupportedOperationException("Cluster membership not yet implemented");
	}

	@Override
	public IClusterMember getLocalMember() {
		throw new UnsupportedOperationException("Cluster membership not yet implemented");
	}

	@Override
	public <V> Future<V> execute(Callable<V> task, IClusterMember member) {
		throw new UnsupportedOperationException("Targeted distributed compute not yet implemented");
	}

	@Override
	public <V> Map<IClusterMember, Future<V>> execute(Callable<V> task, Collection<IClusterMember> members) {
		throw new UnsupportedOperationException("Broadcast distributed compute not yet implemented");
	}
}
