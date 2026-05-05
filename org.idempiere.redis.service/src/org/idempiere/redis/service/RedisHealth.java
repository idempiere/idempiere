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
package org.idempiere.redis.service;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Minimal two-state circuit breaker for Redis connectivity.
 *
 * <p>Starts in {@link State#CLOSED}; each call site that attempts a Redis operation
 * reports outcomes via {@link #recordSuccess()} / {@link #recordFailure(Throwable)}.
 * When {@code consecutiveFailures} reaches the configured threshold the breaker
 * trips to {@link State#OPEN}: subsequent {@link #isHealthy()} checks return
 * {@code false} so callers can short-circuit to a local fallback rather than
 * waiting for Redisson connection timeouts on every call.</p>
 *
 * <p>Recovery is probe-driven: {@link #isHealthy()} on an open breaker, once the
 * probe interval has elapsed, performs a lightweight Redis call (KEYS count) and
 * transitions back to {@code CLOSED} on success.</p>
 */
public final class RedisHealth {

	private static final Logger log = LoggerFactory.getLogger(RedisHealth.class);

	public enum State { CLOSED, OPEN }

	private final RedissonClient client;
	private final int failureThreshold;
	private final long probeIntervalMs;

	private final AtomicInteger consecutiveFailures = new AtomicInteger(0);
	private final AtomicLong openedAt = new AtomicLong(0L);
	private volatile State state = State.CLOSED;

	public RedisHealth(RedissonClient client, int failureThreshold, long probeIntervalMs) {
		this.client = client;
		this.failureThreshold = Math.max(1, failureThreshold);
		this.probeIntervalMs = Math.max(1000L, probeIntervalMs);
	}

	public State getState() {
		return state;
	}

	/**
	 * @return {@code true} if the breaker is closed (calls should proceed) or if
	 *         a recovery probe just succeeded; {@code false} if open and still
	 *         within the probe-cooldown window.
	 */
	public boolean isHealthy() {
		if (state == State.CLOSED) {
			return true;
		}
		long now = System.currentTimeMillis();
		long opened = openedAt.get();
		if (now - opened < probeIntervalMs) {
			return false;
		}
		// Try to claim the probe slot — only one thread runs the probe per interval.
		if (!openedAt.compareAndSet(opened, now)) {
			return false;
		}
		try {
			client.getKeys().count();
			close();
			log.info("Redis circuit breaker recovered to CLOSED after probe");
			return true;
		} catch (Exception e) {
			log.warn("Redis circuit breaker probe failed; remaining OPEN", e);
			return false;
		}
	}

	public void recordSuccess() {
		consecutiveFailures.set(0);
		if (state == State.OPEN) {
			close();
		}
	}

	public void recordFailure(Throwable cause) {
		int n = consecutiveFailures.incrementAndGet();
		if (n >= failureThreshold && state == State.CLOSED) {
			open();
			log.warn("Redis circuit breaker tripped to OPEN after {} consecutive failures", n, cause);
		}
	}

	private void open() {
		state = State.OPEN;
		openedAt.set(System.currentTimeMillis());
	}

	private void close() {
		state = State.CLOSED;
		consecutiveFailures.set(0);
	}
}
