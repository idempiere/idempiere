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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.adempiere.base.BaseActivator;
import org.compiere.util.CLogger;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventAdmin;
import org.osgi.service.event.EventConstants;
import org.osgi.service.event.EventHandler;

/**
 * Simple wrapper for the osgi event admin service.
 * Usage: EventManager.getInstance().sendEvent/postEvent
 * @author hengsin
 *
 */
public class EventManager implements IEventManager {

	private EventAdmin eventAdmin;
	private static IEventManager instance = null;
	private final static CLogger log = CLogger.getCLogger(EventManager.class);

	private final static Object mutex = new Object();

	private Map<EventHandler, List<ServiceRegistration>> registrations = new HashMap<EventHandler, List<ServiceRegistration>>();

	/**
	 * @param eventAdmin
	 */
	public void bindEventAdmin(EventAdmin eventAdmin) {
		synchronized (mutex) {
			if (instance == null) {
				instance  = this;
				mutex.notifyAll();
			}
		}
		this.eventAdmin = eventAdmin;
	}

	/**
	 * @param eventAdmin
	 */
	public void unbindEventAdmin(EventAdmin eventAdmin) {
		this.eventAdmin = null;
	}

	/**
	 * Get the singleton instance created by the osgi service framework
	 * @return EventManager
	 */
	public static IEventManager getInstance() {
		synchronized (mutex) {
			if (instance == null) {
				try {
					mutex.wait(10000);
				} catch (InterruptedException e) {
				}
			}
		}
		return instance;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.IEventManager#postEvent(org.osgi.service.event.Event)
	 */
	@Override
	public boolean postEvent(Event event) {
		if (eventAdmin != null) {
			eventAdmin.postEvent(event);
			return true;
		}
		return false;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.IEventManager#sendEvent(org.osgi.service.event.Event)
	 */
	@Override
	public boolean sendEvent(Event event) {
		if (eventAdmin != null) {
			eventAdmin.sendEvent(event);
			return true;
		}
		return false;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.IEventManager#register(java.lang.String, org.osgi.service.event.EventHandler)
	 */
	@Override
	public boolean register(String topic, EventHandler eventHandler) {
		return register(topic, null, eventHandler);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.IEventManager#register(java.lang.String[], org.osgi.service.event.EventHandler)
	 */
	@Override
	public boolean register(String[] topics, EventHandler eventHandler) {
		return register(topics, null, eventHandler);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.IEventManager#register(java.lang.String, java.lang.String, org.osgi.service.event.EventHandler)
	 */
	@Override
	public boolean register(String topic, String filter, EventHandler eventHandler) {
		String[] topics = new String[] {topic};
		return register(topics, filter, eventHandler);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.IEventManager#register(java.lang.String[], java.lang.String, org.osgi.service.event.EventHandler)
	 */
	@Override
	public boolean register(String[] topics, String filter, EventHandler eventHandler) {
		BundleContext bundleContext = BaseActivator.getBundleContext();
		if (bundleContext == null) {
			log.severe("No bundle context. Topic="+Arrays.toString(topics));
			return false;
		}
		Dictionary<String, Object> d = new Hashtable<String, Object>();
		d.put(EventConstants.EVENT_TOPIC, topics);
		if (filter != null)
			d.put(EventConstants.EVENT_FILTER, filter);
		ServiceRegistration registration = bundleContext.registerService(EventHandler.class.getName(), eventHandler, d);
		synchronized(registrations) {
			List<ServiceRegistration> list = registrations.get(eventHandler);
			if (list == null) {
				list = new ArrayList<ServiceRegistration>();
				registrations.put(eventHandler, list);
			}
			list.add(registration);
		}
		return true;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.IEventManager#unregister(org.osgi.service.event.EventHandler)
	 */
	@Override
	public boolean unregister(EventHandler eventHandler) {
		List<ServiceRegistration> serviceRegistrations = null;
		synchronized(registrations) {
			serviceRegistrations = registrations.remove(eventHandler);
		}
		if (serviceRegistrations == null)
			return false;
		for (ServiceRegistration registration : serviceRegistrations)
			registration.unregister();
		return true;
	}

	/**
	 * @param topic
	 * @param parameter
	 */
	@SuppressWarnings("unchecked")
	public static Event newEvent(String topic, Object data) {
		Event event = null;
		if (data instanceof Dictionary<?,?>) {
			Dictionary<String,Object>dict = (Dictionary<String,Object>)data;
			if (dict.get(EVENT_ERROR_MESSAGES) == null)
				dict.put(EVENT_ERROR_MESSAGES, new ArrayList<String>());
			event = new Event(topic, dict);
		} else if (data instanceof Map<?, ?>) {
			Map<String, Object> map = (Map<String, Object>)data;
			if (!map.containsKey(EVENT_ERROR_MESSAGES))
				map.put(EVENT_ERROR_MESSAGES, new ArrayList<String>());
			event = new Event(topic, map);
		} else {
			Map<String, Object> map = new HashMap<String, Object>(3);
			map.put(EventConstants.EVENT_TOPIC, topic);
			if (data != null)
				map.put(EVENT_DATA, data);
			map.put(EVENT_ERROR_MESSAGES, new ArrayList<String>());
			event = new Event(topic, map);
		}
		return event;
	}

	/**
	 *
	 * @param topic
	 * @param properties
	 * @return event object
	 */
	public static Event newEvent(String topic, EventProperty ...properties) {
		Event event = null;
		Map<String, Object> map = new HashMap<String, Object>(3);
		if (properties != null) {
			for(int i = 0; i < properties.length; i++) {
				map.put(properties[i].name, properties[i].value);
			}
			if (!map.containsKey(EventConstants.EVENT_TOPIC))
				map.put(EventConstants.EVENT_TOPIC, topic);
			if (!map.containsKey(EVENT_ERROR_MESSAGES))
				map.put(EVENT_ERROR_MESSAGES, new ArrayList<String>());
		}
		event = new Event(topic, map);
		return event;
	}
}
