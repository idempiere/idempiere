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

import java.util.function.Supplier;

/**
 * Generic base interface for factory service that provide name/classname to instance mapping service 
 * @author hengsin
 *
 * @param <T>
 */
public interface IMappedByNameFactory<T> {
	/**
	 * add name to class mapping
	 * @param name
	 * @param supplier
	 */
	public void addMapping(String name, Supplier<T> supplier);

	/**
	 * remove name to class mapping
	 * @param name
	 */
	public void removeMapping(String name);
	
	/**
	 * 
	 * @param name
	 * @return {@link Supplier}
	 */
	public Supplier<T> getSupplier(String name);
	
	/**
	 * 
	 * @param name
	 * @return new instance of T (if there are register supplier for name)
	 */
	public default T newInstance(String name) {
		var supplier = getSupplier(name);
		return supplier != null ? supplier.get() : null;
	}
}
