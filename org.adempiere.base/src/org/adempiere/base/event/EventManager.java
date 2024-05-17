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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.stream.Collectors;

import org.adempiere.base.BaseActivator;
import org.adempiere.base.event.annotations.BaseEventHandler;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Util;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventAdmin;
import org.osgi.service.event.EventConstants;
import org.osgi.service.event.EventHandler;

/**
 * Simple wrapper for the osgi event admin service.<br/>
 * Usage: EventManager.getInstance().sendEvent/postEvent
 * @author hengsin
 *
 */
public class EventManager implements IEventManager {

	private EventAdmin eventAdmin;
	private static IEventManager instance = null;
	private final static CLogger log = CLogger.getCLogger(EventManager.class);

	private final static Object mutex = new Object();

	private Map<EventHandler, List<ServiceRegistration<?>>> registrations = new HashMap<EventHandler, List<ServiceRegistration<?>>>();

	private List<String> blackListEventHandlers = null;
	private Map<String, List<String>> blackListTopicMap = null;
	
	/**
	 * @param eventAdmin
	 */
	public void bindEventAdmin(EventAdmin eventAdmin) {
		synchronized (mutex) {
			if (instance == null) {
				instance  = this;
				retrieveBlacklistHandlers();
				mutex.notifyAll();
			}
		}
		this.eventAdmin = eventAdmin;
	}

	private void retrieveBlacklistHandlers() {
		blackListEventHandlers = new ArrayList<String>();
		blackListTopicMap = new HashMap<String, List<String>>();
		String path = Ini.getAdempiereHome();
		File file = new File(path, "event.handlers.blacklist");
		if (file.exists()) {
			BufferedReader br = null;
			try {
				FileReader reader = new FileReader(file);
				br = new BufferedReader(reader);
				String s = null;
				do {
					s = br.readLine();
					if (!Util.isEmpty(s)) {
						s = s.trim();
						s = s.replaceAll(" ", "");
						if (s.endsWith("[*]")) {
							blackListEventHandlers.add(s.substring(0, s.length()-3));
						} else {
							int topicStart = s.indexOf("[");
							if (topicStart <= 0)
								continue;
							int topicEnd = s.indexOf("]", topicStart);
							if (topicEnd <= 0)
								continue;
							String topicValue = s.substring(topicStart+1, topicEnd);
							String className = s.substring(0, topicStart);
							if (blackListEventHandlers.contains(className))
								continue;
							List<String> topicList = blackListTopicMap.get(className);
							if (topicList == null) {
								topicList = new ArrayList<String>();
								blackListTopicMap.put(className, topicList);
							}
							String[] topics = topicValue.split("[,]");
							for(String topic : topics) {
								if (!topicList.contains(topic)) {
									topicList.add(topic);
								}
							}
						}
					}
				} while (s != null);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (br != null) {
					try {
						br.close();
					} catch (IOException e) {}
				}
			}
		}
		
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
			while (instance == null) {
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
			//copy current session context for restoration in asynchronous event thread
			if (!event.containsProperty(EVENT_CONTEXT)) {
				Map<String, Object> properties = new HashMap<>();
				for (String key : event.getPropertyNames()) {
					properties.put(key, event.getProperty(key));
				}
				properties.put(EVENT_CONTEXT, getCurrentSessionContext());
				event = newEvent(event.getTopic(), properties, true);
			}
			
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

	/**
	 * @param topics List of event topic. If only some of the event topic is black listed,
	 * the method will return false and remove the black listed event topic from topics list.  
	 * @param eventHandler
	 * @return true if eventhandler is black listed (i.e don't register the service) for topics
	 */
	private boolean isBlackListed(List<String> topics, EventHandler eventHandler) {
		String className = eventHandler.getClass().getName();
		if (eventHandler instanceof BaseEventHandler beh) {
			if (beh.getDelegateClass() != null)
				className = beh.getDelegateClass().getName();
		}
		if (blackListEventHandlers != null && blackListEventHandlers.contains(className))
			return true;
		if (blackListTopicMap != null && !blackListTopicMap.isEmpty()) {
			List<String> blackListed = blackListTopicMap.get(className);
			if (blackListed != null && !blackListed.isEmpty()) {
				Iterator<String> iterator = topics.iterator();
				while(iterator.hasNext()) {
					String topic = iterator.next();
					if (blackListed.contains(topic))
						iterator.remove();
				}
			}
		}
		
		return false;
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
		
		//check black listed event topics
		List<String> topicList = Arrays.stream(topics).collect(Collectors.toCollection(ArrayList::new));
		if (isBlackListed(topicList, eventHandler))
			return false;
		if (topicList.isEmpty())
			return false;		
		if (topicList.size() != topics.length)
			topics = topicList.toArray(new String[0]);
		
		Dictionary<String, Object> d = new Hashtable<String, Object>();
		d.put(EventConstants.EVENT_TOPIC, topics);
		if (filter != null)
			d.put(EventConstants.EVENT_FILTER, filter);
		ServiceRegistration<?> registration = bundleContext.registerService(EventHandler.class.getName(), eventHandler, d);
		synchronized(registrations) {
			List<ServiceRegistration<?>> list = registrations.get(eventHandler);
			if (list == null) {
				list = new ArrayList<ServiceRegistration<?>>();
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
		List<ServiceRegistration<?>> serviceRegistrations = null;
		synchronized(registrations) {
			serviceRegistrations = registrations.remove(eventHandler);
		}
		if (serviceRegistrations == null)
			return false;
		for (ServiceRegistration<?> registration : serviceRegistrations)
			registration.unregister();
		return true;
	}

	/**
	 * @param topic
	 * @param data
	 * @return new Event instance
	 */
	public static Event newEvent(String topic, Object data) {
		return newEvent(topic, data, false);
	}
	
	/**
	 * Create new event instance. If copySessionContext is true, a copy of current session context is added as EVENT_CONTEXT property to event data.
	 * @param topic
	 * @param data
	 * @param copySessionContext true to copy current session context (usually for postEvent).
	 * @return new Event instance
	 */
	@SuppressWarnings("unchecked")
	public static Event newEvent(String topic, Object data, boolean copySessionContext) {
		Event event = null;
		if (data instanceof Dictionary<?,?>) {
			Dictionary<String,Object>dict = (Dictionary<String,Object>)data;
			if (dict.get(EVENT_ERROR_MESSAGES) == null)
				dict.put(EVENT_ERROR_MESSAGES, new ArrayList<String>());
			if (copySessionContext)
				dict.put(EVENT_CONTEXT, getCurrentSessionContext());
			event = new Event(topic, dict);
		} else if (data instanceof Map<?, ?>) {
			Map<String, Object> map = (Map<String, Object>)data;
			if (!map.containsKey(EVENT_ERROR_MESSAGES))
				map.put(EVENT_ERROR_MESSAGES, new ArrayList<String>());
			if (copySessionContext)
				map.put(EVENT_CONTEXT, getCurrentSessionContext());
			event = new Event(topic, map);
		} else {
			Map<String, Object> map = new HashMap<String, Object>(3);
			map.put(EventConstants.EVENT_TOPIC, topic);
			if (data != null) {
				map.put(EVENT_DATA, data);
				if (data instanceof PO po)
					map.put(TABLE_NAME_PROPERTY, po.get_TableName());
			}
			map.put(EVENT_ERROR_MESSAGES, new ArrayList<String>());
			if (copySessionContext)
				map.put(EVENT_CONTEXT, getCurrentSessionContext());
			event = new Event(topic, map);
		}
		return event;
	}

	/**
	 * @return copy of current session context
	 */
	private static Properties getCurrentSessionContext() {
		Properties context = new Properties();
		Env.setContext(context, Env.AD_CLIENT_ID, Env.getAD_Client_ID(Env.getCtx()));
		Env.setContext(context, Env.AD_ORG_ID, Env.getAD_Org_ID(Env.getCtx()));
		Env.setContext(context, Env.AD_USER_ID, Env.getAD_User_ID(Env.getCtx()));
		Env.setContext(context, Env.AD_ROLE_ID, Env.getAD_Role_ID(Env.getCtx()));
		Env.setContext(context, Env.M_WAREHOUSE_ID, Env.getContext(Env.getCtx(), Env.M_WAREHOUSE_ID));
		Env.setContext(context, Env.LANGUAGE, Env.getContext(Env.getCtx(), Env.LANGUAGE));
		return context;
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
