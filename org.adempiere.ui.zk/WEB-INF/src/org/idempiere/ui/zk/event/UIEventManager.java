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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
package org.idempiere.ui.zk.event;

import java.util.List;
import java.util.Properties;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.EventProperty;
import org.adempiere.base.event.IEventManager;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MQuery;
import org.osgi.service.event.Event;

public class UIEventManager {

	/**
	 * Fires an event when opening a window
	 * @param ctx
	 * @param window
	 * @param windowId
	 * @param query
	 */
	public static void fireOpenWindowEvent(Properties ctx, int windowId, int windowNo, MQuery query) {
		Event event = EventManager.newEvent(IUIEventTopics.UI_OPEN_WINDOW,
				new EventProperty("windowId", windowId),
				new EventProperty("windowNo", windowNo),
				new EventProperty("query", query)
				);
		sendEvent(event);
	}

	/**
	 * Fires an event when opening a process/report
	 * @param ctx
	 * @param processId
	 * @param windowNo
	 */
	public static void fireOpenProcessEvent(Properties ctx, int processId, int windowNo) {
		Event event = EventManager.newEvent(IUIEventTopics.UI_OPEN_PROCESS,
				new EventProperty("processId", processId),
				new EventProperty("windowNo", windowNo)
				);
		sendEvent(event);
	}

	/**
	 * Fires an event when opening an info window
	 * @param ctx
	 * @param infoWindowId
	 * @param windowNo
	 */
	public static void fireOpenInfoEvent(Properties ctx, int infoWindowId, int windowNo) {
		Event event = EventManager.newEvent(IUIEventTopics.UI_OPEN_INFO,
				new EventProperty("infoWindowId", infoWindowId),
				new EventProperty("windowNo", windowNo)
				);
		sendEvent(event);
	}

	/**
	 * Fires an event when opening a form
	 * @param ctx
	 * @param formId
	 * @param windowNo
	 */
	public static void fireOpenFormEvent(Properties ctx, int formId, int windowNo) {
		Event event = EventManager.newEvent(IUIEventTopics.UI_OPEN_FORM,
				new EventProperty("formId", formId),
				new EventProperty("windowNo", windowNo)
				);
		sendEvent(event);
	}

	private static void sendEvent(Event event) {
		EventManager.getInstance().sendEvent(event);
		@SuppressWarnings("unchecked")
		List<String> errors = (List<String>) event.getProperty(IEventManager.EVENT_ERROR_MESSAGES);
		if (errors != null && !errors.isEmpty())
			throw new AdempiereException(errors.get(0));
	}

}
