/**********************************************************************
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
* - Norbert Bede, Cloudempiere                                        *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.idempiere.redis.service.message;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.idempiere.distributed.ITopic;
import org.idempiere.distributed.ITopicSubscriber;
import org.redisson.api.RTopic;

/**
 * Adapter mapping {@link ITopic} subscribe / unsubscribe / publish onto a Redisson
 * {@link RTopic}. Each subscriber's listener id is tracked locally so unsubscribe
 * can locate and remove the right Redisson registration.
 *
 * <p>Note: each call to {@link MessageServiceImpl#getTopic(String)} returns a new
 * {@code TopicImpl} wrapping the same underlying Redis topic. Subscribe / unsubscribe
 * pairs must therefore use the same {@code TopicImpl} instance (matches the contract
 * of {@code org.idempiere.hazelcast.service.TopicImpl}).</p>
 */
public class TopicImpl<E> implements ITopic<E> {

	private final RTopic topic;
	private final ConcurrentMap<ITopicSubscriber<E>, Integer> listenerIds = new ConcurrentHashMap<>();

	public TopicImpl(RTopic topic) {
		this.topic = topic;
	}

	@Override
	public String getName() {
		// Redisson stores the topic name with our deployment prefix already applied;
		// returning it as-is matches what callers wrote when calling getTopic(name).
		return topic.getChannelNames().isEmpty() ? "" : topic.getChannelNames().get(0);
	}

	@Override
	public void subscribe(ITopicSubscriber<E> subscriber) {
		// Use Object.class for the message type — the iDempiere ITopic API is parametric
		// and the type erasure prevents us from passing the real class. Redisson uses its
		// configured codec to serialize / deserialize; the listener casts at delivery time.
		@SuppressWarnings("unchecked")
		Class<E> type = (Class<E>) (Class<?>) Object.class;
		int id = topic.addListener(type, (channel, message) -> subscriber.onMessage(message));
		Integer oldId = listenerIds.put(subscriber, id);
		if (oldId != null) {
			topic.removeListener(oldId);
		}
	}

	@Override
	public void unsubscribe(ITopicSubscriber<E> subscriber) {
		Integer id = listenerIds.remove(subscriber);
		if (id != null) {
			topic.removeListener(id);
		}
	}

	@Override
	public void publish(E message) {
		topic.publish(message);
	}
}
