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
package org.adempiere.base.event.annotations;

import java.util.function.Function;

import org.osgi.service.event.Event;

/**
 * 
 * Event handler that delegate to {@link EventDelegate} instance (create for each event call)
 * @author hengsin
 *
 */
public final class SimpleEventHandler extends BaseEventHandler {

	private Function<Event, ? extends EventDelegate> supplier;
	
	/**
	 * 
	 * @param delegateClass
	 * @param supplier
	 */
	public SimpleEventHandler(Class<? extends EventDelegate> delegateClass, Function<Event, ? extends EventDelegate> supplier) {
		super(delegateClass);
		this.supplier = supplier;
	}

	@Override
	protected EventDelegate newEventDelegate(Event event) {
		return supplier.apply(event);
	}	
}
