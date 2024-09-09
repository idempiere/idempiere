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
package org.adempiere.webui.util;

import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.util.EventInterceptor;

/**
 * Zk event interceptor for event tracing/debugging use.<br/>
 * To use this, follow the instruction in WEB-INF/zk.xml
 * @author hengsin
 *
 */
public class LogEventInterceptor implements EventInterceptor {

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#beforeSendEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public Event beforeSendEvent(Event event) {		
//		System.out.println("beforeSendEvent, event="+event.getName()+",target="+event.getTarget());
		return event;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#beforePostEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public Event beforePostEvent(Event event) {
//		System.out.println("beforePostEvent, event="+event.getName()+",target="+event.getTarget());
		return event;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#beforeProcessEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public Event beforeProcessEvent(Event event) {		
		if (event.getTarget() != null) {
			Execution execution = Executions.getCurrent();
			String uuid = event.getTarget().getUuid();
			String key = uuid + event.getName();
			if (execution.getAttribute(key) != null) {
				System.out.println("Duplicate Event., event="+event.getName()+",target="+event.getTarget());
			} else {
				execution.setAttribute(key, Boolean.TRUE);
				String locator = event.getTarget() != null ? event.getTarget().getClientAttribute("_zk_locator") : "";
				System.out.println("beforeProcessEvent, event="+event.getName()+",target="+event.getTarget()+",locator="+locator);
			}
		}
		return event;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#afterProcessEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void afterProcessEvent(Event event) {
//		System.out.println("afterProcessEvent, event="+event.getName()+",target="+event.getTarget());
	}
}
