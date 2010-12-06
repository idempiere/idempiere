/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base.event;

import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;

/**
 *
 * @author hengsin
 *
 */
public interface IEventManager {

	public static final String EVENT_DATA = "event.data";
	public static final String EVENT_ERROR_MESSAGES = "event.errorMessages";

	/**
	 * Initiate asynchronous delivery of an event. This method returns to the
	 * caller before delivery of the event is completed.
	 *
	 * @param event The event to send to all listeners which subscribe to the
	 *        topic of the event.
	 *
	 * @throws SecurityException If the caller does not have
	 *         <code>TopicPermission[topic,PUBLISH]</code> for the topic
	 *         specified in the event.
	 */
	public abstract boolean postEvent(Event event);

	/**
	 * Initiate synchronous delivery of an event. This method does not return to
	 * the caller until delivery of the event is completed.
	 *
	 * @param event The event to send to all listeners which subscribe to the
	 *        topic of the event.
	 *
	 * @throws SecurityException If the caller does not have
	 *         <code>TopicPermission[topic,PUBLISH]</code> for the topic
	 *         specified in the event.
	 */
	public abstract boolean sendEvent(Event event);

	/**
	 * register a new event handler
	 * @param topic
	 * @param eventHandler
	 * @return true if registration is successful, false otherwise
	 */
	public abstract boolean register(String topic, EventHandler eventHandler);

	/**
	 * register a new event handler
	 * @param topics
	 * @param eventHandler
	 * @return true if registration is successful, false otherwise
	 */
	public abstract boolean register(String[] topics, EventHandler eventHandler);

	/**
	 * register a new event handler
	 * @param topic
	 * @param filter
	 * @param eventHandler
	 * @return true if registration is successful, false otherwise
	 */
	public abstract boolean register(String topic, String filter,
			EventHandler eventHandler);

	/**
	 * register a new event handler
	 * @param topics
	 * @param filter
	 * @param eventHandler
	 * @return true if registration is successful, false otherwise
	 */
	public abstract boolean register(String[] topics, String filter,
			EventHandler eventHandler);

	/**
	 * un-register an event handler
	 * @param eventHandler
	 * @return true if unregistration is done, false otherwise
	 */
	public abstract boolean unregister(EventHandler eventHandler);

}