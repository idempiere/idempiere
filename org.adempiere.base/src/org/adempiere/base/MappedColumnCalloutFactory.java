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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.function.Supplier;

import org.osgi.service.component.annotations.Component;

/**
 * 
 * @author hengsin
 *
 */
@Component(name = "org.adempiere.base.MappedColumnCalloutFactory", 
	immediate = true, 
	service = {IColumnCalloutFactory.class, IMappedColumnCalloutFactory.class}, 
	property = {"service.ranking:Integer=1"})
public class MappedColumnCalloutFactory implements IColumnCalloutFactory, IMappedColumnCalloutFactory {

	private final HashMap<String, List<Supplier<IColumnCallout>>> calloutMap = new HashMap<>();
	
	/**
	 * default constructor
	 */
	public MappedColumnCalloutFactory() {
	}

	@Override
	public IColumnCallout[] getColumnCallouts(String tableName, String columnName) {
		List<IColumnCallout> calloutList = new ArrayList<IColumnCallout>();
		StringBuilder key = new StringBuilder();
		key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());
		StringBuilder key1 = new StringBuilder();
		key1.append("*|").append(columnName.toLowerCase());
		StringBuilder key2 = new StringBuilder();
		key2.append(tableName.toLowerCase()).append("|*");
		synchronized (calloutMap) {
			List<Supplier<IColumnCallout>> list = calloutMap.get(key.toString());
			if (list != null && list.size() > 0) {
				list.forEach(e -> calloutList.add(e.get()));
			}
			list = calloutMap.get(key1.toString());
			if (list != null && list.size() > 0) {
				list.forEach(e -> calloutList.add(e.get()));
			}
			list = calloutMap.get(key2.toString());
			if (list != null && list.size() > 0) {
				list.forEach(e -> calloutList.add(e.get()));
			}
		}
		return calloutList.isEmpty() ? null : calloutList.toArray(new IColumnCallout[0]);
	}

	@Override
	public void addMapping(String tableName, String columnName, Supplier<IColumnCallout> supplier) {
		StringBuilder key = new StringBuilder();
		key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());
		synchronized (calloutMap) {
			List<Supplier<IColumnCallout>> list = calloutMap.get(key.toString());
			if (list == null) {
				list = new ArrayList<Supplier<IColumnCallout>>();
				calloutMap.put(key.toString(), list);
			}
			list.add(supplier);
		}		
	}
	
	@Override
	public void removeMapping(String tableName, String columnName, Supplier<IColumnCallout> supplier) {
		StringBuilder key = new StringBuilder();
		key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());
		synchronized (calloutMap) {
			List<Supplier<IColumnCallout>> list = calloutMap.get(key.toString());
			if (list != null) {
				list.remove(supplier);
			}
		}		
	}
}
