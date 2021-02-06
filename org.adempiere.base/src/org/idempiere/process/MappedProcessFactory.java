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
package org.idempiere.process;

import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Supplier;

import org.adempiere.base.IProcessFactory;
import org.compiere.process.ProcessCall;
import org.osgi.service.component.annotations.Component;

/**
 * @author hengsin
 *
 */
@Component(name = "org.idempiere.process.MappedProcessFactory", 
	immediate = true, 
	service = {IProcessFactory.class, IMappedProcessFactory.class}, 
	property = {"service.ranking:Integer=1"})
public class MappedProcessFactory implements IProcessFactory, IMappedProcessFactory {

	private final ConcurrentHashMap<String, Supplier<ProcessCall>> processMap = new ConcurrentHashMap<>();
	
	/**
	 * default constructor
	 */
	public MappedProcessFactory() {
	}

	@Override
	public ProcessCall newProcessInstance(String className) {
		var supplier = processMap.get(className);
		return supplier != null ? supplier.get() : null;
	}

	@Override
	public void addMapping(String name, Supplier<ProcessCall> processSupplier) {
		processMap.put(name, processSupplier);
	}
	
	@Override
	public void removeMapping(String name) {
		processMap.remove(name);
	}
}
