/***********************************************************************
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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base;

import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Supplier;

/**
 * Provide simple name/class name mapping through register lambda supplier object
 * @author hengsin
 *
 * @param <T>
 */
public class MappedByNameFactory<T> implements IMappedByNameFactory<T> {

	private final ConcurrentHashMap<String, Supplier<T>> supplierMap = new ConcurrentHashMap<>();
	
	/**
	 * default constructor
	 */
	public MappedByNameFactory() {
	}

	@Override
	public void addMapping(String name, Supplier<T> Supplier) {
		supplierMap.put(name, Supplier);
	}

	@Override
	public void removeMapping(String name) {
		supplierMap.remove(name);
	}

	@Override
	public Supplier<T> getSupplier(String name) {
		return supplierMap.get(name);
	}
}
