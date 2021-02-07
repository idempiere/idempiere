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

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.adempiere.base.event.EventHelper;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;

/**
 * 
 * Base class for event handler that works with annotation driven event delegate.
 * The implementation of event delegate doesn't have to be thread safe as a new instance of delegate is created for each event call.
 * @author hengsin
 *
 */
public abstract class BaseEventHandler implements EventHandler {

	//event topic to method mapping
	protected final Map<String, Method> eventTopicMap = new HashMap<String, Method>();
	private String filter;

	/**
	 * 
	 * @param delegateClass
	 */
	public BaseEventHandler(Class<? extends EventDelegate> delegateClass) {
		filter = null;
		createTopicMap(delegateClass);
	}

	/**
	 * create event to topic to method mapping from annotations
	 * @param delegateClass
	 */
	protected void createTopicMap(Class<?> delegateClass) {
		Method[] methods = delegateClass.getMethods();
		for(Method method : methods) {
			if (method.isBridge())
				continue;
			Annotation[] annotations = method.getAnnotations();
			for (Annotation annotation : annotations) {
				if (annotation.annotationType().isAnnotationPresent(EventTopic.class)) {
					String topic = annotation.annotationType().getAnnotation(EventTopic.class).topic();
					if (!eventTopicMap.containsKey(topic)) {
						method.setAccessible(true);
						eventTopicMap.put(topic, method);
					}
				}
			}
		}		
	}

	/**
	 * 
	 * @return arrays of event topic
	 */
	public String[] getTopics() {
		String[] topics = null;
		if (!eventTopicMap.isEmpty())
			topics = eventTopicMap.keySet().toArray(new String[0]);
		return topics;
	}

	/**
	 * 
	 * @return event filter
	 */
	public String getFilter() {
		return filter;
	}
	
	/**
	 * set event filter
	 * @param filter
	 */
	public void setFilter(String filter) {
		this.filter = filter;
	}

	/**
	 * 
	 * @param propertyName
	 * @param value
	 */
	public void setEventPropertyFilter(String propertyName, String value) {
		StringBuilder builder = new StringBuilder();
		builder.append("(")
			.append(propertyName)
			.append("=")
			.append(value)
			.append(")");
		setFilter(builder.toString());
	}
	
	@Override
	public void handleEvent(Event event) {
		Method method = eventTopicMap.get(event.getTopic());
		if (method != null) {
			try {
				EventDelegate delegate = newEventDelegate(event);
				method.invoke(delegate);
			} catch (RuntimeException e) {
				EventHelper.addError(event, e);
				throw e;
			} catch (Exception e) {
				Throwable t = e;
				if (e.getCause() != null)
					t = e.getCause();
				EventHelper.addError(event, t);
				if (t instanceof RuntimeException)
					throw (RuntimeException)t;
				else
					throw new RuntimeException(t);
			} catch (Error e) {
				EventHelper.addError(event, e);
				throw e;
			} catch (Throwable e) {
				EventHelper.addError(event, e);
				throw new Error(e);
			}
		}
	}

	/**
	 * create new instance of event delegate
	 * @param event
	 * @return {@link EventDelegate}
	 */
	protected abstract EventDelegate newEventDelegate(Event event);
}