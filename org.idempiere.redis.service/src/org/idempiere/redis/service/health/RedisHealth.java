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
import java.util.function.IntSupplier;

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
	/**
	 * Absolute subscription count at which the breaker trips due to pool exhaustion.
	 * 0 means the pool-exhaustion check is disabled (default when not configured).
	 */
	private volatile int subscriptionPoolThreshold;
	/**
	 * Live active-subscription count, consulted by {@link #transitionToClosed()} so a probe
	 * success or an unrelated successful Redis call cannot close the breaker while the
	 * subscription pool is still saturated. A pushed snapshot (last value reported to
	 * {@link #recordSubscriptionPoolUsage}) would go stale the moment {@code execute()} stops
	 * calling it because the breaker is OPEN — pulling on demand avoids that.
	 */
	private volatile IntSupplier subscriptionUsageSupplier = () -> 0;

	private final AtomicInteger consecutiveFailures = new AtomicInteger(0);
	private final AtomicReference<State> state = new AtomicReference<>(State.CLOSED);
	/** Description of why the breaker last tripped, for console display. */
	private volatile String lastTripReason = "failure-threshold";
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
	 * Sets the absolute subscription-count threshold at which the breaker trips to OPEN.
	 * Call from Activator after reading the pool configuration.
	 * Pass 0 to disable the pool-exhaustion check.
	 */
	public void setSubscriptionPoolThreshold(int threshold) {
		this.subscriptionPoolThreshold = Math.max(0, threshold);
	}

	public int getSubscriptionPoolThreshold() {
		return subscriptionPoolThreshold;
	}

	/**
	 * Supplies the current active-subscription count on demand. Call once from whichever
	 * component owns the counter (e.g. {@code ClusterServiceImpl}) after it activates, so
	 * {@link #transitionToClosed()} can verify the pool has actually drained before letting
	 * the breaker close. Pass {@code null} to reset to "always 0" (no gating).
	 */
	public void setSubscriptionUsageSupplier(IntSupplier supplier) {
		this.subscriptionUsageSupplier = supplier != null ? supplier : () -> 0;
	}

	/** @return human-readable reason the breaker last tripped, for console display. */
	public String getLastTripReason() {
		return lastTripReason;
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
			lastTripReason = "failure-threshold " + n + "/" + failureThreshold;
			startProbing();
			log.warn("Redis circuit breaker tripped to OPEN after {} consecutive failures", n, cause);
			fire(State.CLOSED, State.OPEN);
		}
	}

	/**
	 * Checks whether the active subscription count has exceeded the configured threshold.
	 * If so, trips the breaker to OPEN immediately (pool-exhaustion fast-path).
	 *
	 * <p>Call this every time an RPC subscription is added or removed. No-op when
	 * {@link #setSubscriptionPoolThreshold(int)} was not configured (threshold == 0).</p>
	 *
	 * @param activeSubscriptions current number of open pub/sub subscriptions
	 * @param poolSize            configured Redisson subscriptionConnectionPoolSize
	 */
	public void recordSubscriptionPoolUsage(int activeSubscriptions, int poolSize) {
		int threshold = subscriptionPoolThreshold;
		if (threshold <= 0 || state.get() == State.OPEN) {
			return;
		}
		if (activeSubscriptions >= threshold && state.compareAndSet(State.CLOSED, State.OPEN)) {
			lastTrippedCount = activeSubscriptions;
			lastTripReason = "subscription-pool " + activeSubscriptions + "/" + poolSize;
			startProbing();
			log.warn("Redis circuit breaker tripped to OPEN: subscription pool usage {}/{} "
					+ "reached threshold {} ({}% of pool)",
					activeSubscriptions, poolSize, threshold,
					poolSize > 0 ? (threshold * 100 / poolSize) : 0);
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
			switch (transitionToClosed()) {
				case CLOSED:
					log.info("Redis circuit breaker recovered to CLOSED after probe");
					break;
				case BLOCKED_BY_POOL_USAGE:
					// Genuine saturation, distinct from a concurrent transition below — only this
					// case actually means the probe succeeded but closing was refused.
					log.warn("Redis circuit breaker probe succeeded but subscription pool usage ({}) "
							+ "is still at or above threshold ({}); remaining OPEN",
							subscriptionUsageSupplier.getAsInt(), subscriptionPoolThreshold);
					break;
				case ALREADY_TRANSITIONED:
					// Another thread (a concurrent recordSuccess()/probe()) already closed the
					// breaker, or raced our CAS — nothing to log, this isn't a saturation case.
					break;
			}
		} catch (Exception e) {
			log.warn("Redis circuit breaker probe failed; remaining OPEN", e);
		}
	}

	/** Outcome of an OPEN -&gt; CLOSED attempt; lets callers tell genuine pool saturation apart from a benign concurrent transition. */
	private enum CloseAttempt { CLOSED, BLOCKED_BY_POOL_USAGE, ALREADY_TRANSITIONED }

	/**
	 * Attempts OPEN -&gt; CLOSED. Refuses while subscription-pool usage is still at or above
	 * the configured threshold — closing on an unrelated success (a probe, or any other Redis
	 * call routed through {@link #recordSuccess()}) would just let {@code execute()} resume
	 * allocating subscriptions and immediately re-trip the pool-exhaustion fast-path.
	 */
	private CloseAttempt transitionToClosed() {
		if (state.get() != State.OPEN) {
			return CloseAttempt.ALREADY_TRANSITIONED;
		}
		int threshold = subscriptionPoolThreshold;
		if (threshold > 0 && subscriptionUsageSupplier.getAsInt() >= threshold) {
			return CloseAttempt.BLOCKED_BY_POOL_USAGE;
		}
		if (state.compareAndSet(State.OPEN, State.CLOSED)) {
			ScheduledFuture<?> f = probeFuture;
			probeFuture = null;
			if (f != null) {
				f.cancel(false);
			}
			lastTrippedCount = consecutiveFailures.getAndSet(0); // snapshot before reset so CONNECTED event carries outage severity
			fire(State.OPEN, State.CLOSED);
			return CloseAttempt.CLOSED;
		}
		return CloseAttempt.ALREADY_TRANSITIONED;
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
