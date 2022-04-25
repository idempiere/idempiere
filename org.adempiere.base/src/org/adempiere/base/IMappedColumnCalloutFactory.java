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

import org.osgi.framework.BundleContext;

/**
 * 
 * @author hengsin
 *
 */
public interface IMappedColumnCalloutFactory {

	/**
	 * add mapping for callout
	 * @param tableName case insensitive table name or * to match all table
	 * @param columnName case insensitive column name or * to match all column
	 * @param supplier supplier for {@link IColumnCallout} instance
	 */
	public void addMapping(String tableName, String columnName, Supplier<IColumnCallout> supplier);

	/**
	 * remove mapping for callout
	 * @param tableName case insensitive table name or * to match all table
	 * @param columnName case insensitive column name or * to match all column
	 * @param supplier supplier for {@link IColumnCallout} instance
	 */
	public void removeMapping(String tableName, String columnName, Supplier<IColumnCallout> supplier);

	/**
	 * scan, discover and register classes with Callout annotation
	 * @param context
	 * @param packages
	 */
	public void scan(BundleContext context, String... packages);
}