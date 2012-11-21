package org.idempiere.distributed;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface ICacheService {

	public <K, V>Map<K, V> getMap(String name);
	
	public <K>List<K> getList(String name);
	
	public <K>Set<K> getSet(String name);
}
