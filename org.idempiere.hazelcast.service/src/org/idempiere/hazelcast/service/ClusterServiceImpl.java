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
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;

import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;

import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.core.IExecutorService;
import com.hazelcast.core.Member;
import com.hazelcast.instance.HazelcastInstanceImpl;
import com.hazelcast.instance.HazelcastInstanceProxy;

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
		HazelcastInstance instance = Activator.getHazelcastInstance();		
		Set<IClusterMember> clusterMembers = new HashSet<IClusterMember>();
		if (instance != null) {
			Set<Member> members = instance.getCluster().getMembers();
			for(Member member : members) {
				clusterMembers.add(new ClusterMember(member));
			}
		}
		return clusterMembers;
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterService#getLocalMember()
	 */
	@Override
	public IClusterMember getLocalMember() {
		HazelcastInstance instance = Activator.getHazelcastInstance();
		if (instance != null) {
			Member member = instance.getCluster().getLocalMember();
			return new ClusterMember(member);
		} else {
			return null;
		}
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterService#execute(java.util.concurrent.Callable, org.idempiere.distributed.IClusterMember)
	 */
	@Override
	public <V> Future<V> execute(Callable<V> task, IClusterMember clusterMember) {
		HazelcastInstance instance = Activator.getHazelcastInstance();
		if (instance != null) {
			Set<Member> members = instance.getCluster().getMembers();
			for(Member member : members) {
				if (member.getUuid().equals(clusterMember.getId())) {
					IExecutorService service = Activator.getHazelcastInstance().getExecutorService("default");
					return service.submitToMember(task, member);
				}
			}
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterService#execute(java.util.concurrent.Callable, java.util.Collection)
	 */
	@Override
	public <V> Map<IClusterMember, Future<V>> execute(Callable<V> task,
			Collection<IClusterMember> clusterMembers) {
		Set<String> selectedIds = new HashSet<String>();
		for(IClusterMember clusterMember : clusterMembers) {
			selectedIds.add(clusterMember.getId());
		}
		HazelcastInstance instance = Activator.getHazelcastInstance();
		if (instance != null) {
			Set<Member> members = instance.getCluster().getMembers();
			Set<Member> selectedMembers = new HashSet<Member>();
			for(Member member : members) {
				if (selectedIds.contains(member.getUuid())) {
					selectedMembers.add(member);
				}
			}
			if (selectedMembers.size() > 0) {
				IExecutorService service = Activator.getHazelcastInstance().getExecutorService("default");
				Map<Member, Future<V>> map = service.submitToMembers(task, selectedMembers);
				Map<IClusterMember, Future<V>> futureMap = new LinkedHashMap<>();
				for(Member member : map.keySet()) {
					futureMap.put(new ClusterMember(member), map.get(member));
				}
				return futureMap;
			}
		}
		return null;
	}

	@Override
	public boolean isStandAlone() {
		HazelcastInstance instance = Activator.getHazelcastInstance();
		if (instance != null) {
			if (instance instanceof HazelcastInstanceImpl) {
				HazelcastInstanceImpl impl = (HazelcastInstanceImpl) instance;
				return impl.node.getJoiner() == null;
			} else if (instance instanceof HazelcastInstanceProxy) {
				HazelcastInstanceProxy proxy = (HazelcastInstanceProxy) instance;
				HazelcastInstanceImpl impl = proxy.getOriginal();
				return impl.node.getJoiner() == null;
			} else {
				return false;
			}
		} else {
			return true;
		}
	}

}
