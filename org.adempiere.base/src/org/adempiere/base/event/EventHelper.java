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
package org.adempiere.base.event;

import java.util.List;

import org.compiere.model.PO;
import org.compiere.process.ProcessInfo;
import org.osgi.service.event.Event;

/**
 * Helper methods for event handler
 * @author hengsin
 */
public final class EventHelper {

	/**
	 * private constructor
	 */
	private EventHelper() {
	}

	/**
	 * @param event
	 * @return PO
	 */
	public static PO getPO(Event event) {
		PO po = null;
		Object data = getEventData(event);
		if (data instanceof PO)
			po = (PO)data;
		else if (data instanceof POEventData)
			po = ((POEventData) data).getPo();
		return po;
	}

	/**
	 * @param event
	 * @return ProcessInfo
	 */
	public static ProcessInfo getProcessInfo(Event event) {
		return getEventProperty(event, IEventManager.EVENT_DATA);
	}

	/**
	 *
	 * @param <T>
	 * @param event
	 */
	public static <T> T getEventData(Event event) {
		return getEventProperty(event, IEventManager.EVENT_DATA);
	}

	/**
	 *
	 * @param <T>
	 * @param event
	 * @param property
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getEventProperty(Event event, String property) {
		return (T) event.getProperty(property);
	}

	/**
	 * @param event
	 * @param e
	 */
	public static void addError(Event event, Throwable e) {
		String msg = e.getLocalizedMessage();
		if (msg == null)
			msg = e.toString();
		addErrorMessage(event, msg);
	}

	/**
	 * @param event
	 * @param errorMessage
	 */
	public static void addErrorMessage(Event event, String errorMessage) {
		List<String> errors = getEventProperty(event, IEventManager.EVENT_ERROR_MESSAGES);
		if (errors != null)
			errors.add(errorMessage);
	}
}
