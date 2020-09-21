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
package org.idempiere.cache;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.Properties;
import java.util.function.UnaryOperator;

import org.compiere.model.PO;
import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Thread safe PO cache using copy on read and copy on write strategy.
 * 
 * @author hengsin
 */
public class POCopyCache<K, V extends PO> extends CCache<K, V> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7463584909438958260L;

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 * @param maxSize
	 */
	public POCopyCache(String name, int initialCapacity, int expireMinutes, boolean distributed, int maxSize) {
		super(name, initialCapacity, expireMinutes, distributed, maxSize);
	}

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 */
	public POCopyCache(String name, int initialCapacity, int expireMinutes, boolean distributed) {
		super(name, initialCapacity, expireMinutes, distributed);
	}

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 */
	public POCopyCache(String name, int initialCapacity, int expireMinutes) {
		super(name, initialCapacity, expireMinutes);
	}

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 */
	public POCopyCache(String name, int initialCapacity) {
		super(name, initialCapacity);
	}

	/**
	 * 
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param distributed
	 */
	public POCopyCache(String tableName, String name, int initialCapacity, boolean distributed) {
		super(tableName, name, initialCapacity, distributed);
	}

	/**
	 * 
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 * @param maxSize
	 */
	public POCopyCache(String tableName, String name, int initialCapacity, int expireMinutes, boolean distributed,
			int maxSize) {
		super(tableName, name, initialCapacity, expireMinutes, distributed, maxSize);
	}

	/**
	 * 
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 */
	public POCopyCache(String tableName, String name, int initialCapacity, int expireMinutes, boolean distributed) {
		super(tableName, name, initialCapacity, expireMinutes, distributed);
	}

	/**
	 * 
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 */
	public POCopyCache(String tableName, String name, int initialCapacity) {
		super(tableName, name, initialCapacity);
	}
	
	@Override
	public V put(K key, V value) {
		return put(key, value, (UnaryOperator<V>)null);
	}

	/**
	 * A copy of the PO will be created and add to cache using copyOperator or through copy constructor (through reflection) 
	 * if copyOperator parameter is null (exception is throw if both copyOperator and copy constructor is not available).
	 * @param key
	 * @param po
	 * @param copyOperator operator to call copy constructor
	 * @return PO added to cache
	 */
	public V put(K key, V po, UnaryOperator<V> copyOperator) {
		if (po == null ) {
			super.put(key, po);
			return null;
		} 
		
		if (copyOperator == null) {
			try {
				try {
					V copy = copyOf(Env.getCtx(), po);
					if (copy != null) {
						super.put(key, copy);
						return copy;	
					}
				} catch (Exception e) {}
				
				V copy = copyOf(Env.getCtx(), po, (String)null);
				if (copy != null) {
					super.put(key, copy);
					return copy;	
				}
				throw new RuntimeException("No copy constructor for " + po.getClass().getName());
			} catch (NoSuchMethodException | SecurityException | InvocationTargetException | IllegalAccessException | InstantiationException e) {
				throw new RuntimeException("Error calling copy constructor for " + po.getClass().getName() + " : " + e.getMessage(), e);
			}
		} else {
			V copy = copyOperator.apply(po);
			super.put(key, copy);
			return copy;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public V get(Object key) {
		try {
			return get((Properties)null, (K)key);
		} catch (ClassCastException e) {
			return null;
		}
	}

	/**
	 * @param ctx context 
	 * @param key
	 * @return value for key
	 */
	public V get(Properties ctx, K key) {
		return get(ctx, key, (String)null);
	}
	
	/**
	 * @param ctx context 
	 * @param key
	 * @param trxName
	 * @return value for key
	 */
	public V get(Properties ctx, K key, String trxName) {
		V value = super.get(key);
		if (value == null)
			return null;
		
		if (ctx == null)
			ctx = Env.getCtx();
		
		//use reflection to find copy constructor
		try {
			if (Util.isEmpty(trxName, true)) {
				try {
					V copy = copyOf(ctx, value);
					if (copy != null)
						return copy;
				} catch (Exception e) {}
			}
			
			V copy = copyOf(ctx, value, trxName);
			if (copy != null)
				return copy;
			
			throw new RuntimeException("No copy constructor for " + value.getClass().getName());
		} catch (NoSuchMethodException | SecurityException | InvocationTargetException | IllegalAccessException | InstantiationException e) {
			throw new RuntimeException("Error calling copy constructor for " + value.getClass().getName() + " : " + e.getMessage(), e);
		}
	}
	
	/**
	 * Get PO from cache. A copy of the cached PO is return
	 * @param key
	 * @param copyOperator operator to call copy constructor
	 * @return PO from cache (if there's match for key)
	 */
	public V get(K key, UnaryOperator<V> copyOperator) {
		V value = super.get(key);
		if (value == null)
			return null;
		
		V copy = copyOperator.apply(value);
		return copy;
	}

	@SuppressWarnings("unchecked")
	private V copyOf(Properties ctx, V value, String trxName)
			throws NoSuchMethodException, InstantiationException, IllegalAccessException, InvocationTargetException {
		Constructor<? extends PO> copyConstructor;
		copyConstructor = value.getClass().getDeclaredConstructor(Properties.class, value.getClass(), String.class);
		if (copyConstructor != null) {
			V copy = (V) copyConstructor.newInstance(ctx, value, trxName);
			return copy;
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	private V copyOf(Properties ctx, V value)
			throws NoSuchMethodException, InstantiationException, IllegalAccessException, InvocationTargetException {
		Constructor<? extends PO> copyConstructor;
		copyConstructor = value.getClass().getDeclaredConstructor(Properties.class, value.getClass());
		if (copyConstructor != null) {
			V copy = (V) copyConstructor.newInstance(ctx, value);
			return copy;
		}
		return null;
	}
}
