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
package org.idempiere.model;

import java.sql.ResultSet;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiFunction;
import java.util.function.Supplier;

import org.adempiere.base.IModelFactory;
import org.compiere.model.PO;
import org.osgi.service.component.annotations.Component;

/**
 * @author hengsin
 *
 */
@Component(name = "org.idempiere.model.MappedModelFactory", 
	immediate = true, 
	service = {IModelFactory.class, IMappedModelFactory.class}, 
	property = {"service.ranking:Integer=1"})
public class MappedModelFactory implements IModelFactory, IMappedModelFactory {

	private final ConcurrentHashMap<String, Supplier<Class<?>>> classMap = new ConcurrentHashMap<>();
	private final ConcurrentHashMap<String, BiFunction<Integer, String, ? extends PO>> recordIdMap = new ConcurrentHashMap<>();
	private final ConcurrentHashMap<String, BiFunction<ResultSet, String, ? extends PO>> resultSetMap = new ConcurrentHashMap<>();
	
	/**
	 * default constructor
	 */
	public MappedModelFactory() {
	}

	@Override
	public Class<?> getClass(String tableName) {
		var supplier = classMap.get(tableName);
		return supplier != null ? supplier.get() : null;
	}

	@Override
	public PO getPO(String tableName, int Record_ID, String trxName) {
		var function = recordIdMap.get(tableName);
		return function != null ? function.apply(Record_ID, trxName) : null;
	}

	@Override
	public PO getPO(String tableName, ResultSet rs, String trxName) {
		var function = resultSetMap.get(tableName);
		return function != null ? function.apply(rs, trxName) : null;
	}

	@Override
	public void addMapping(String tableName, Supplier<Class<?>> classSupplier, BiFunction<Integer, String, ? extends PO> recordIdFunction, 
			BiFunction<ResultSet, String, ? extends PO> resultSetFunction) {
		classMap.put(tableName, classSupplier);
		recordIdMap.put(tableName, recordIdFunction);
		resultSetMap.put(tableName, resultSetFunction);
	}
	
	@Override
	public void removeMapping(String tableName) {
		classMap.remove(tableName);
		recordIdMap.remove(tableName);
		resultSetMap.remove(tableName);
	}
}
