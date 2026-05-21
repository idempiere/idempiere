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

import org.idempiere.redis.service.health.RedisHealth;
import org.idempiere.redis.service.health.StateListener;
import org.osgi.framework.BundleContext;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventAdmin;
import org.osgi.util.tracker.ServiceTracker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Republishes {@link RedisHealth} state transitions as OSGi {@link EventAdmin}
 * events so other bundles can react to backend availability changes
 * (e.g. surface a banner in the ZK web UI, gate scheduled jobs that depend on
 * a working distributed cache, log to an external observability sink).
 *
 * <h3>Event topics</h3>
 * <ul>
 *   <li>{@value #TOPIC_STATE_CHANGED} — fired on every transition; carries
 *       both previous and current semantic states as properties.</li>
 *   <li>{@value #TOPIC_CONNECTED} — fired when Redis becomes reachable
 *       (CLOSED reached after a successful probe).</li>
 *   <li>{@value #TOPIC_DEGRADED} — fired when the breaker trips OPEN after
 *       reaching the configured failure threshold.</li>
 * </ul>
 *
 * <p>Subscribers may filter by topic via the OSGi {@code event.topics} service
 * property — using one of the state-specific topics avoids string-comparison
 * boilerplate inside handlers.</p>
 *
 * <h3>EventAdmin availability</h3>
 *
 * <p>EventAdmin is treated as optional: the publisher uses a
 * {@link ServiceTracker} so events become a no-op when no EventAdmin is
 * registered (e.g. unit-test runs, minimal deployments). The bundle remains
 * fully functional without it; only the broadcast goes silent.</p>
 */
public final class HealthEventPublisher implements StateListener {

	private static final Logger log = LoggerFactory.getLogger(HealthEventPublisher.class);

	/** Generic topic — fired on every state transition. */
	public static final String TOPIC_STATE_CHANGED = "org/idempiere/redis/service/STATE_CHANGED";

	/** Fired when Redis becomes (or returns to) reachable. */
	public static final String TOPIC_CONNECTED = "org/idempiere/redis/service/CONNECTED";

	/** Fired when the breaker trips OPEN. */
	public static final String TOPIC_DEGRADED = "org/idempiere/redis/service/DEGRADED";

	/** Event property keys. */
	public static final String PROP_PREVIOUS = "previous";
	public static final String PROP_CURRENT = "current";
	public static final String PROP_TIMESTAMP = "timestamp";
	public static final String PROP_CONSECUTIVE_FAILURES = "consecutive_failures";

	private final RedisHealth health;
	private final ServiceTracker<EventAdmin, EventAdmin> tracker;

	public HealthEventPublisher(BundleContext ctx, RedisHealth health) {
		this.health = health;
		this.tracker = new ServiceTracker<>(ctx, EventAdmin.class, null);
		this.tracker.open();
	}

	/** Releases the EventAdmin ServiceTracker. Idempotent. */
	public void close() {
		tracker.close();
	}

	@Override
	public void onStateChange(RedisHealth.State previous, RedisHealth.State current) {
		EventAdmin admin = tracker.getService();
		if (admin == null) {
			return;
		}
		String previousLabel = label(previous);
		String currentLabel = label(current);
		Map<String, Object> props = new HashMap<>(4);
		props.put(PROP_PREVIOUS, previousLabel);
		props.put(PROP_CURRENT, currentLabel);
		props.put(PROP_TIMESTAMP, System.currentTimeMillis());
		// For CONNECTED (OPEN→CLOSED): report the pre-reset count so subscribers know outage severity.
		// For DEGRADED (CLOSED→OPEN): report the current count (= failureThreshold).
		int failureCount = (current == RedisHealth.State.CLOSED)
				? health.getLastTrippedCount()
				: health.getConsecutiveFailures();
		props.put(PROP_CONSECUTIVE_FAILURES, failureCount);
		// Subscribers can listen on the generic topic or the state-specific one.
		admin.postEvent(new Event(TOPIC_STATE_CHANGED, props));
		String specific = (current == RedisHealth.State.CLOSED) ? TOPIC_CONNECTED : TOPIC_DEGRADED;
		admin.postEvent(new Event(specific, props));
		log.info("Published Redis backend state event: {} -> {}", previousLabel, currentLabel);
	}

	/**
	 * Maps the internal breaker state to the semantic label exposed to event
	 * subscribers — keeps EventAdmin consumers insulated from any future
	 * refactoring of the {@link RedisHealth.State} enum.
	 */
	private static String label(RedisHealth.State s) {
		return s == RedisHealth.State.CLOSED ? "CONNECTED" : "DEGRADED";
	}
}
