/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.idempiere.hazelcast.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.idempiere.distributed.ITopic;
import org.idempiere.distributed.ITopicSubscriber;

import com.hazelcast.core.Message;
import com.hazelcast.core.MessageListener;

/**
 * @author hengsin
 *
 */
public class TopicImpl<E> implements ITopic<E> {

	private com.hazelcast.core.ITopic<E> topic;
	
	private List<TopicSubscriberAdapter<E>> adapters;
	private Map<TopicSubscriberAdapter<E>, String> registrationMap;

	/**
	 * 
	 */
	public TopicImpl(com.hazelcast.core.ITopic<E> topic) {
		this.topic = topic;
		adapters = new ArrayList<TopicSubscriberAdapter<E>>();
		registrationMap = new HashMap<>();
	}

	@Override
	public String getName() {
		return topic.getName();
	}

	@Override
	public void subscribe(final ITopicSubscriber<E> subscriber) {
		TopicSubscriberAdapter<E> adapter = new TopicSubscriberAdapter<E>(subscriber);
		String registrationId = topic.addMessageListener(adapter);
		adapters.add(adapter);
		registrationMap.put(adapter, registrationId);
	}

	@Override
	public void unsubscribe(ITopicSubscriber<E> subscriber) {
		TopicSubscriberAdapter<E> found = null;
		for(TopicSubscriberAdapter<E> adapter : adapters) {
			if (adapter.subscriber == subscriber) {
				found = adapter;
				String registrationId = registrationMap.get(adapter);
				if (topic.removeMessageListener(registrationId))
					registrationMap.remove(adapter);
				break;
			}
		}
		if (found != null)
			adapters.remove(found);
	}

	@Override
	public void publish(E message) {
		topic.publish(message); 
	}

	class TopicSubscriberAdapter<T> implements MessageListener<T> {
		protected ITopicSubscriber<T> subscriber;

		protected TopicSubscriberAdapter(ITopicSubscriber<T> subscriber) {
			this.subscriber = subscriber;
		}

		@Override
		public void onMessage(Message<T> message) {
			subscriber.onMessage(message.getMessageObject());
		}
	}
}
