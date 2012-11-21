package org.idempiere.distributed;

import java.util.Collection;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;

public interface IClusterService {

	public Collection<IClusterMember> getMembers();
	public IClusterMember getLocalMember();
	
	public <V>Future<V> execute(Callable<V> task, IClusterMember member);
	public <V>Future<Collection<V>> execute(Callable<V> task, Collection<IClusterMember> members);
}
