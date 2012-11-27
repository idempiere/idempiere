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

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;

import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;

import com.hazelcast.core.DistributedTask;
import com.hazelcast.core.Member;
import com.hazelcast.core.MultiTask;

/**
 * @author hengsin
 *
 */
public class ClusterServiceImpl implements IClusterService {

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterService#getMembers()
	 */
	@Override
	public Collection<IClusterMember> getMembers() {
		Set<Member> members = Activator.getHazelcastInstance().getCluster().getMembers();
		Set<IClusterMember> clusterMembers = new HashSet<IClusterMember>();
		for(Member member : members) {
			clusterMembers.add(new ClusterMember(member.getUuid(), member.getInetSocketAddress().getAddress()));
		}
		return clusterMembers;
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterService#getLocalMember()
	 */
	@Override
	public IClusterMember getLocalMember() {
		Member member = Activator.getHazelcastInstance().getCluster().getLocalMember();
		return new ClusterMember(member.getUuid(), member.getInetSocketAddress().getAddress());
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterService#execute(java.util.concurrent.Callable, org.idempiere.distributed.IClusterMember)
	 */
	@Override
	public <V> Future<V> execute(Callable<V> task, IClusterMember clusterMember) {
		Set<Member> members = Activator.getHazelcastInstance().getCluster().getMembers();
		for(Member member : members) {
			if (member.getUuid().equals(clusterMember.getId())) {
				DistributedTask<V> distributedTask = new DistributedTask<V>(task, member);
				Activator.getHazelcastInstance().getExecutorService().execute(distributedTask);
				return distributedTask;
			}
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterService#execute(java.util.concurrent.Callable, java.util.Collection)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public <V> Future<Collection<V>> execute(Callable<V> task,
			Collection<IClusterMember> clusterMembers) {
		Set<String> selectedIds = new HashSet<String>();
		for(IClusterMember clusterMember : clusterMembers) {
			selectedIds.add(clusterMember.getId());
		}
		Set<Member> members = Activator.getHazelcastInstance().getCluster().getMembers();
		Set<Member> selectedMembers = new HashSet<Member>();
		for(Member member : members) {
			if (selectedIds.contains(member.getUuid())) {
				selectedMembers.add(member);
			}
		}
		if (selectedMembers.size() > 0) {
			MultiTask<V> multiTask = new MultiTask<V>(task, selectedMembers);
			Activator.getHazelcastInstance().getExecutorService().execute(multiTask);
			return multiTask;
		}
		return null;
	}

}
