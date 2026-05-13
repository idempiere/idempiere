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
import org.redisson.api.RReliableTopic;

/**
 * Adapter mapping {@link ITopic} onto a Redisson {@link RReliableTopic}, the
 * Redis-Streams-backed counterpart of {@link TopicImpl}'s plain {@code RTopic}.
 *
 * <p>The semantic difference matters for cache-invalidation traffic: with
 * plain pub/sub a node that is briefly disconnected misses every invalidation
 * published in that window and resumes serving stale values. {@code
 * RReliableTopic} stores messages in a Redis Stream with per-subscriber
 * consumer groups, so on reconnect each subscriber drains the messages it
 * missed before going back to live delivery.</p>
 *
 * <p>Costs: a Stream is heavier than a pub/sub channel (Redis must persist
 * messages and track consumer offsets), and consumer-group state survives
 * subscriber crashes — so a node that disappears permanently will leave
 * orphan groups that need eventual cleanup. For most iDempiere deployments
 * the durability win for cache invalidation is worth the overhead, but
 * because the trade-off varies by workload this is opt-in via the
 * {@code messaging.reliable} config flag.</p>
 *
 * <p>Listener IDs are tracked locally so {@link #unsubscribe(ITopicSubscriber)}
 * can locate the right Redisson registration; the subscribe/unsubscribe pair
 * must use the same {@code ReliableTopicImpl} instance, matching the
 * existing {@link TopicImpl} contract.</p>
 */
public class ReliableTopicImpl<E> implements ITopic<E> {

	private final RReliableTopic topic;
	private final ConcurrentMap<ITopicSubscriber<E>, String> listenerIds = new ConcurrentHashMap<>();

	public ReliableTopicImpl(RReliableTopic topic) {
		this.topic = topic;
	}

	@Override
	public String getName() {
		return topic.getName();
	}

	@Override
	public void subscribe(ITopicSubscriber<E> subscriber) {
		// Same erasure caveat as TopicImpl - the iDempiere ITopic API is parametric
		// so we hand Redisson Object.class and rely on the configured codec for
		// (de)serialization; the listener casts at delivery time.
		@SuppressWarnings("unchecked")
		Class<E> type = (Class<E>) (Class<?>) Object.class;
		String id = topic.addListener(type, (channel, message) -> subscriber.onMessage(message));
		String previous = listenerIds.putIfAbsent(subscriber, id);
		if (previous != null) {
			topic.removeListener(id); // drop the just-registered duplicate to avoid leak
		}
	}

	@Override
	public void unsubscribe(ITopicSubscriber<E> subscriber) {
		String id = listenerIds.remove(subscriber);
		if (id != null) {
			topic.removeListener(id);
		}
	}

	@Override
	public void publish(E message) {
		topic.publish(message);
	}
}
