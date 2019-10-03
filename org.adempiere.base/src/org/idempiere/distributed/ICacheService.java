package org.idempiere.distributed;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

public interface ICacheService {

	public <K, V>Map<K, V> getMap(String name);
	
	public <K>List<K> getList(String name);
	
	public <K>Set<K> getSet(String name);
	
	/**
	 * Tries to acquire the lock for the specified key.
	 * If the lock is not available, then the current thread becomes disabled for thread scheduling purposes and lies dormant 
	 * until one of two things happens - the lock is acquired by the current thread, or the specified waiting time elapses.
	 * 
	 * @param map
	 * @param key
	 * @param timeout
	 * @param timeunit
	 * @return true if lock is acquired, false otherwise
	 * @throws InterruptedException 
	 */
	public <K, V>boolean tryLock(Map<K, V> map, K key, long timeout, TimeUnit timeunit) throws InterruptedException;
	
	/**
	 * Releases the lock for the specified key. It never blocks and returns immediately. If the current thread is the holder 
	 * of this lock, then the hold count is decremented. If the hold count is zero, then the lock is released. 
	 * If the current thread is not the holder of this lock, then IllegalMonitorStateException is thrown.
	 *  
	 * @param map
	 * @param key
	 */
	public <K, V>void unLock(Map<K, V> map, K key);
}
