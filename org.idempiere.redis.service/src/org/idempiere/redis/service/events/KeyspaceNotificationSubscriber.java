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
package org.idempiere.redis.service.events;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

import org.osgi.framework.BundleContext;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventAdmin;
import org.osgi.util.tracker.ServiceTracker;
import org.redisson.api.RPatternTopic;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Subscribes to Redis keyspace notifications for keys under this deployment's
 * prefix and republishes each event through OSGi {@link EventAdmin} so other
 * bundles can observe Redis-side mutations without polling.
 *
 * <h3>What gets published</h3>
 * <p>Each Redis keyspace event becomes one EventAdmin event on the
 * {@value #TOPIC_KEY_CHANGED} topic with these properties:</p>
 * <ul>
 *   <li>{@value #PROP_KEY} — the full Redis key (including the deployment prefix)</li>
 *   <li>{@value #PROP_OP} — the operation ({@code set}, {@code del}, {@code expired},
 *       {@code rename_from}, {@code rename_to}, ...)</li>
 *   <li>{@value #PROP_DATABASE} — the Redis database number where the change happened</li>
 *   <li>{@value #PROP_TIMESTAMP} — receipt time at the subscriber, in milliseconds</li>
 * </ul>
 *
 * <h3>Server-side requirement</h3>
 * <p>Redis only publishes keyspace notifications when {@code notify-keyspace-events}
 * is configured server-side; with the default empty value Redis is silent and
 * this subscriber receives nothing. Recommended setting for cache use:</p>
 *
 * <pre>
 *   redis-cli CONFIG SET notify-keyspace-events KEA
 *   # K - keyspace events  E - keyevent events  A - all g$lshzxe
 * </pre>
 *
 * <p>The startup log emits an informational hint when this subscriber is
 * enabled, so operators see the requirement without having to read source.</p>
 *
 * <h3>Why pattern-subscribe rather than per-key?</h3>
 * <p>iDempiere creates {@code RMap}s lazily and the set is open-ended; a
 * pattern subscription on {@code __keyspace@*__:&lt;prefix&gt;*} catches every
 * mutation under our namespace without needing to register / unregister as
 * caches come and go. Cross-database is intentional (we don't pin a database
 * in {@link org.idempiere.redis.service.config.RedisConfig}).</p>
 *
 * <h3>Goal vs scope</h3>
 * <p>The longer-term aspiration is to replace iDempiere's explicit
 * cache-invalidation broadcasts with keyspace-driven invalidation, but that
 * requires {@code CCache} changes which sit outside the contract this bundle
 * is allowed to touch. This commit scopes to passive observation: the events
 * are emitted; consumers (whether future {@code CCache} integration, ZK UI
 * banners, or external observability sinks) opt in by registering an
 * EventAdmin handler.</p>
 */
public final class KeyspaceNotificationSubscriber {

	private static final Logger log = LoggerFactory.getLogger(KeyspaceNotificationSubscriber.class);

	public static final String TOPIC_KEY_CHANGED = "org/idempiere/redis/service/KEY_CHANGED";
	public static final String PROP_KEY = "key";
	public static final String PROP_OP = "op";
	public static final String PROP_DATABASE = "database";
	public static final String PROP_TIMESTAMP = "timestamp";

	private static final String CHANNEL_PATTERN_FORMAT = "__keyspace@*__:%s*";
	private static final String CHANNEL_PREFIX = "__keyspace@";

	private final RedissonClient client;
	private final String keyPrefix;
	private final ServiceTracker<EventAdmin, EventAdmin> tracker;
	private final AtomicLong eventCount = new AtomicLong(0L);

	private volatile RPatternTopic patternTopic;
	private volatile int listenerId = -1;

	public KeyspaceNotificationSubscriber(BundleContext ctx, RedissonClient client, String keyPrefix) {
		this.client = client;
		this.keyPrefix = keyPrefix;
		this.tracker = new ServiceTracker<>(ctx, EventAdmin.class, null);
	}

	/**
	 * Opens the EventAdmin tracker and registers the pattern listener.
	 * Idempotent — repeated calls beyond the first are no-ops.
	 */
	public synchronized void start() {
		if (patternTopic != null) {
			return;
		}
		tracker.open();
		String pattern = String.format(CHANNEL_PATTERN_FORMAT, keyPrefix);
		patternTopic = client.getPatternTopic(pattern);
		listenerId = patternTopic.addListener(String.class, (channelPattern, channel, message) -> {
			handleEvent(channel.toString(), message);
		});
		log.info("Keyspace notification subscriber listening on '{}' — ensure Redis CONFIG "
				+ "'notify-keyspace-events' is set (KEA recommended), otherwise no events will fire",
				pattern);
	}

	/**
	 * Removes the pattern listener and closes the EventAdmin tracker. Safe to
	 * call before {@link #start()} or after a previous {@link #close()}.
	 */
	public synchronized void close() {
		if (patternTopic != null && listenerId != -1) {
			try {
				patternTopic.removeListener(listenerId);
			} catch (Exception e) {
				log.warn("Failed to remove keyspace pattern listener cleanly", e);
			}
		}
		patternTopic = null;
		listenerId = -1;
		tracker.close();
	}

	/** @return the running count of keyspace events forwarded since {@link #start()}. */
	public long getEventCount() {
		return eventCount.get();
	}

	private void handleEvent(String channel, String op) {
		eventCount.incrementAndGet();
		EventAdmin admin = tracker.getService();
		if (admin == null) {
			// EventAdmin not registered (e.g. unit-test runtime) - count it but skip publish.
			return;
		}
		// Channel format: __keyspace@<db>__:<key>. Reject anything else so this code
		// can't silently misparse a __keyevent@N__ channel if the subscriber pattern
		// is ever broadened.
		if (!channel.startsWith(CHANNEL_PREFIX)) {
			return;
		}
		int at = CHANNEL_PREFIX.length() - 1;
		int closeBrace = channel.indexOf("__:", at);
		if (closeBrace < 0) {
			return;
		}
		int database;
		try {
			database = Integer.parseInt(channel.substring(at + 1, closeBrace));
		} catch (NumberFormatException e) {
			database = -1;
		}
		String key = channel.substring(closeBrace + 3);
		Map<String, Object> props = new HashMap<>(4);
		props.put(PROP_KEY, key);
		props.put(PROP_OP, op);
		props.put(PROP_DATABASE, database);
		props.put(PROP_TIMESTAMP, System.currentTimeMillis());
		admin.postEvent(new Event(TOPIC_KEY_CHANGED, props));
	}
}
