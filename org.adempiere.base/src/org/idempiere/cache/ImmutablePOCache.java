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
 * Thread safe PO cache. For thread safety, only PO with thread local context (po.getCtx() == Env.getCtx() and without trxName is keep in cache.
 * PO is mark immutable before being added to cache. If the pass in PO doesn't match the 2 condition, a copy of the PO is added to cache instead.
 * For get operation, if request is being make with non thread local context (ctx != Env.getCtx()) or with trxName, a copy of the PO from cache 
 * is return instead.
 * 
 * @author hengsin
 */
public class ImmutablePOCache<K, V extends PO & ImmutablePOSupport> extends CCache<K, V> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3342469152066078741L;

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 * @param maxSize
	 */
	public ImmutablePOCache(String name, int initialCapacity, int expireMinutes, boolean distributed, int maxSize) {
		super(name, initialCapacity, expireMinutes, distributed, maxSize);
	}

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 */
	public ImmutablePOCache(String name, int initialCapacity, int expireMinutes, boolean distributed) {
		super(name, initialCapacity, expireMinutes, distributed);
	}

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 */
	public ImmutablePOCache(String name, int initialCapacity, int expireMinutes) {
		super(name, initialCapacity, expireMinutes);
	}

	/**
	 * 
	 * @param name
	 * @param initialCapacity
	 */
	public ImmutablePOCache(String name, int initialCapacity) {
		super(name, initialCapacity);
	}

	/**
	 * 
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param distributed
	 */
	public ImmutablePOCache(String tableName, String name, int initialCapacity, boolean distributed) {
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
	public ImmutablePOCache(String tableName, String name, int initialCapacity, int expireMinutes, boolean distributed,
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
	public ImmutablePOCache(String tableName, String name, int initialCapacity, int expireMinutes, boolean distributed) {
		super(tableName, name, initialCapacity, expireMinutes, distributed);
	}

	/**
	 * 
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 */
	public ImmutablePOCache(String tableName, String name, int initialCapacity) {
		super(tableName, name, initialCapacity);
	}
	
	@Override
	public V put(K key, V value) {
		return put(key, value, (UnaryOperator<V>)null);
	}

	/**
	 * PO is mark immutable and add to cache if it is without trxName and with thread local context (i.e po.getCtx() == Env.getCtx()).
	 * If neither of the condition is not true, a copy of the PO will be created and add to cache using the pass copyOperator or 
	 * through copy constructor (through reflection) if copyOperator parameter is null (exception is throw if both copyOperator and
	 * copy constructor is not available).
	 * @param key
	 * @param po
	 * @param copyOperator operator to call copy constructor if po has transaction name or po.getCtx() != Env.getCtx()
	 * @return po or the copy of po that have been added to cache
	 */
	public V put(K key, V po, UnaryOperator<V> copyOperator) {
		if (po == null) {
			super.put(key, po);
			return null;
		} 
		
		po.markImmutable();
		if (Util.isEmpty(po.get_TrxName(), true) && po.getCtx() == Env.getCtx()) {			
			super.put(key, po);
			return po;
		} else if (copyOperator == null) {
			try {
				V copy = null;
				try {
					copy = copyOf(Env.getCtx(), po);
				} catch (Exception e) {}
				if (copy == null)
					copy = copyOf(Env.getCtx(), po, (String)null);
				
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
			copy.markImmutable();
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
		return get(ctx, key, (UnaryOperator<V>)null);
	}
	
	/**
	 * Get PO from cache. If ctx != Env.getCtx() or trxName is not empty, a copy of the PO is return instead
	 * @param ctx context
	 * @param key
	 * @param copyOperator operator to call copy constructor when ctx != po.getCtx() or transaction name is not empty
	 * @return PO from cache (if there's match for key)
	 */
	@SuppressWarnings("unchecked")
	public V get(Properties ctx, K key, UnaryOperator<V> copyOperator) {
		V value = super.get(key);
		if (value == null)
			return null;
		
		if (ctx == null)
			ctx = Env.getCtx();
		if (ctx != value.getCtx()) {
			if (copyOperator == null) {
				//use reflection to find copy constructor
				try {
					try {
						V copy = copyOf(ctx, value);
						if (copy != null)
							return copy;
					} catch (Exception e) {}
					
					V copy = copyOf(ctx, value, (String)null);
					if (copy != null)
						return copy;
					
					throw new RuntimeException("No copy constructor for " + value.getClass().getName());
				} catch (NoSuchMethodException | SecurityException | InvocationTargetException | IllegalAccessException | InstantiationException e) {
					throw new RuntimeException("Error calling copy constructor for " + value.getClass().getName() + " : " + e.getMessage(), e);
				}

			} else {
				V copy = copyOperator.apply(value);
				return (V) copy.markImmutable();
			}
		} else {
			return value;
		}
	}

	@SuppressWarnings("unchecked")
	private V copyOf(Properties ctx, V value, String trxName)
			throws NoSuchMethodException, InstantiationException, IllegalAccessException, InvocationTargetException {
		Constructor<? extends PO> copyConstructor;
		copyConstructor = value.getClass().getDeclaredConstructor(Properties.class, value.getClass(), String.class);
		if (copyConstructor != null) {
			V copy = (V) copyConstructor.newInstance(ctx, value, trxName);
			return (V) copy.markImmutable();
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
			return (V) copy.markImmutable();
		}
		return null;
	}
}
