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
package org.idempiere.redis.service.health;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

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
 * <p>Recovery is probe-driven on a background scheduler — never on the caller's
 * thread. While the breaker is OPEN a single-threaded executor runs a lightweight
 * Redis call (DBSIZE) every {@code probeIntervalMs}; a successful probe transitions
 * back to {@link State#CLOSED}. Call sites pay only an atomic read on {@link
 * #isHealthy()}.</p>
 *
 * <h3>Thread safety</h3>
 * <p>State transitions use {@link AtomicReference#compareAndSet} so a flood of
 * failing call sites never fires more than one {@link StateListener} event per
 * actual transition.</p>
 */
public final class RedisHealth implements AutoCloseable {

	private static final Logger log = LoggerFactory.getLogger(RedisHealth.class);

	public enum State { CLOSED, OPEN }

	private final RedissonClient client;
	private final int failureThreshold;
	private final long probeIntervalMs;

	private final AtomicInteger consecutiveFailures = new AtomicInteger(0);
	private final AtomicReference<State> state = new AtomicReference<>(State.CLOSED);
	private final ScheduledExecutorService prober;
	private volatile ScheduledFuture<?> probeFuture;
	private volatile StateListener listener = (p, c) -> { /* no-op default */ };
	/** Count of consecutive failures at the moment the breaker last tripped OPEN. */
	private volatile int lastTrippedCount = 0;

	public RedisHealth(RedissonClient client, int failureThreshold, long probeIntervalMs) {
		this.client = client;
		this.failureThreshold = Math.max(1, failureThreshold);
		this.probeIntervalMs = Math.max(1000L, probeIntervalMs);
		this.prober = Executors.newSingleThreadScheduledExecutor(r -> {
			Thread t = new Thread(r, "redis-health-probe");
			t.setDaemon(true);
			return t;
		});
	}

	/**
	 * Sets the (single) listener notified on actual state transitions. Pass
	 * {@code null} to clear. The Activator uses this to attach the
	 * EventAdmin-publishing listener once the bundle is fully wired.
	 */
	public void setStateListener(StateListener listener) {
		this.listener = listener != null ? listener : (p, c) -> { /* no-op */ };
	}

	public int getConsecutiveFailures() {
		return consecutiveFailures.get();
	}

	/** @return consecutive failures recorded when the breaker last tripped to OPEN. */
	public int getLastTrippedCount() {
		return lastTrippedCount;
	}

	public State getState() {
		return state.get();
	}

	/**
	 * Pure read of the current breaker state — no Redis I/O on the caller's
	 * thread. Probing happens on a background scheduler; see {@link #recordFailure}.
	 *
	 * @return {@code true} when the breaker is closed (calls should proceed),
	 *         {@code false} when open.
	 */
	public boolean isHealthy() {
		return state.get() == State.CLOSED;
	}

	public void recordSuccess() {
		consecutiveFailures.set(0);
		transitionToClosed();
	}

	public void recordFailure(Throwable cause) {
		if (state.get() == State.OPEN) {
			return; // already tripped — nothing more to count
		}
		int n = consecutiveFailures.incrementAndGet();
		if (n >= failureThreshold && state.compareAndSet(State.CLOSED, State.OPEN)) {
			lastTrippedCount = n;
			startProbing();
			log.warn("Redis circuit breaker tripped to OPEN after {} consecutive failures", n, cause);
			fire(State.CLOSED, State.OPEN);
		}
	}

	@Override
	public void close() {
		ScheduledFuture<?> f = probeFuture;
		probeFuture = null;
		if (f != null) {
			f.cancel(false);
		}
		prober.shutdownNow();
	}

	// ---- internals

	private void startProbing() {
		probeFuture = prober.scheduleWithFixedDelay(this::probe,
				probeIntervalMs, probeIntervalMs, TimeUnit.MILLISECONDS);
	}

	private void probe() {
		if (state.get() != State.OPEN) {
			return;
		}
		try {
			client.getKeys().count();
			transitionToClosed();
			log.info("Redis circuit breaker recovered to CLOSED after probe");
		} catch (Exception e) {
			log.warn("Redis circuit breaker probe failed; remaining OPEN", e);
		}
	}

	private void transitionToClosed() {
		if (state.compareAndSet(State.OPEN, State.CLOSED)) {
			ScheduledFuture<?> f = probeFuture;
			probeFuture = null;
			if (f != null) {
				f.cancel(false);
			}
			lastTrippedCount = consecutiveFailures.getAndSet(0); // snapshot before reset so CONNECTED event carries outage severity
			fire(State.OPEN, State.CLOSED);
		}
	}

	private void fire(State previous, State current) {
		try {
			listener.onStateChange(previous, current);
		} catch (Exception e) {
			// Listener exceptions must never destabilise the breaker — they would
			// otherwise propagate back to the call site that triggered the
			// transition and mask the underlying Redis fault.
			log.warn("RedisHealth state listener threw on {} -> {}", previous, current, e);
		}
	}
}
