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

import org.compiere.model.PO;

/**
 * ImmutableIntPOCache key by Integer record id
 * @author hengsin
 *
 */
public class ImmutableIntPOCache<K, V extends PO & ImmutablePOSupport> extends ImmutablePOCache<Integer, V> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6605758049101851103L;

	/**
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 * @param maxSize
	 */
	public ImmutableIntPOCache(String name, int initialCapacity, int expireMinutes, boolean distributed, int maxSize) {
		super(name, initialCapacity, expireMinutes, distributed, maxSize);
	}

	/**
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 */
	public ImmutableIntPOCache(String name, int initialCapacity, int expireMinutes, boolean distributed) {
		super(name, initialCapacity, expireMinutes, distributed);
	}

	/**
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 */
	public ImmutableIntPOCache(String name, int initialCapacity, int expireMinutes) {
		super(name, initialCapacity, expireMinutes);
	}

	/**
	 * @param name
	 * @param initialCapacity
	 */
	public ImmutableIntPOCache(String name, int initialCapacity) {
		super(name, initialCapacity);
	}

	/**
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param distributed
	 */
	public ImmutableIntPOCache(String tableName, String name, int initialCapacity, boolean distributed) {
		super(tableName, name, initialCapacity, distributed);
	}

	/**
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 * @param maxSize
	 */
	public ImmutableIntPOCache(String tableName, String name, int initialCapacity, int expireMinutes,
			boolean distributed, int maxSize) {
		super(tableName, name, initialCapacity, expireMinutes, distributed, maxSize);
	}

	/**
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 * @param expireMinutes
	 * @param distributed
	 */
	public ImmutableIntPOCache(String tableName, String name, int initialCapacity, int expireMinutes,
			boolean distributed) {
		super(tableName, name, initialCapacity, expireMinutes, distributed);
	}

	/**
	 * @param tableName
	 * @param name
	 * @param initialCapacity
	 */
	public ImmutableIntPOCache(String tableName, String name, int initialCapacity) {
		super(tableName, name, initialCapacity);
	}

	@Override
	public int reset(int recordId) {
		if (recordId <= 0)
			return reset();
		
		if (cache.isEmpty() && nullList.isEmpty())
			return 0;

		if (!nullList.isEmpty()) {
			if (nullList.remove(recordId)) return 1;
		}
		V removed = cache.remove(recordId);
		return removed != null ? 1 : 0;
	}
	
}
