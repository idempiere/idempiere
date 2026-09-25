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

import java.util.Hashtable;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.logging.Level;

import org.compiere.model.SystemProperties;
import org.compiere.util.CLogger;
import org.eclipse.osgi.framework.console.CommandProvider;
import org.idempiere.redis.service.config.RedisConfig;
import org.idempiere.redis.service.console.RedisConsoleProvider;
import org.idempiere.redis.service.events.HealthEventPublisher;
import org.idempiere.redis.service.events.KeyspaceNotificationSubscriber;
import org.idempiere.redis.service.health.RedisHealth;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.condition.Condition;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;

/**
 * Bundle lifecycle owner.
 *
 * <p>The bundle is <b>opt-in</b>. To activate it, set the JVM system property
 * <code>idempiere.distributed.backend=redis</code> (or the environment variable
 * <code>IDEMPIERE_DISTRIBUTED_BACKEND=redis</code>). With any other value (or
 * unset) the bundle stays passive: no {@link RedissonClient} is created and the
 * three Declarative Services components ({@link CacheServiceImpl},
 * {@link MessageServiceImpl}, {@link ClusterServiceImpl}) remain disabled, so
 * the existing Hazelcast bundle continues to serve
 * {@code org.idempiere.distributed} interfaces unchanged.</p>
 *
 * <p>When the property is set to {@code redis}, this DS component initialises
 * the Redisson client</p>
 *
 * <h3>Activation ordering</h3>
 *
 * <h3>Synchronous init with bounded wait</h3>
 *
 * <p>{@link Redisson#create} opens a Netty-backed connection that needs to
 * load classes from this bundle's {@code lib/redisson-all.jar}. Because OSGi
 * may serialise class loads from a starting bundle, doing the connect on the
 * SCR activation thread risks contention. Init runs on a dedicated worker
 * thread; the activate method blocks on a {@link CountDownLatch} for up to
 * {@link #INIT_TIMEOUT_SECONDS} seconds. If init times out, the bundle stays
 * passive — the failure is logged and
 * exposed via {@link #isInitialisationFailed()} for the console.</p>
 */
@Component(service = {}, immediate = true)
public class Activator {

	@Reference(target = "(osgi.condition.id=distributed.provider.redis)")
    Condition distributedCondition;

	private static final CLogger log = CLogger.getCLogger(Activator.class);

	private static final String BACKEND_VALUE_REDIS = "redis";

	/** Hard upper bound on synchronous init time before we give up and stay passive. */
	private static final long INIT_TIMEOUT_SECONDS = 30L;

	private static volatile RedissonClient client;
	private static volatile RedisConfig config;
	private static volatile RedisHealth health;
	private static volatile HealthEventPublisher healthEventPublisher;
	private static volatile KeyspaceNotificationSubscriber keyspaceSubscriber;
	private static volatile ServiceRegistration<CommandProvider> consoleRegistration;
	private static volatile boolean initialisationFailed;

	private volatile ExecutorService initExecutor;
	private final AtomicBoolean stopping = new AtomicBoolean(false);

	/**
	 * @return the shared {@link RedissonClient} created at bundle start.
	 * @throws IllegalStateException if the bundle is not active or initialisation failed.
	 */
	public static RedissonClient getRedissonClient() {
		RedissonClient c = client;
		if (c == null) {
			throw new IllegalStateException(
					"RedissonClient is not available — bundle org.idempiere.redis.service is either passive "
							+ "(set -D" + SystemProperties.IDEMPIERE_DISTRIBUTED_BACKEND_PROPERTY + "=" + BACKEND_VALUE_REDIS + " to activate) or it failed "
							+ "to initialise against the configured Redis server. Check the bundle log.");
		}
		return c;
	}

	public static RedisConfig getConfig() {
		RedisConfig c = config;
		if (c == null) {
			throw new IllegalStateException("RedisConfig not available — bundle is passive or not started");
		}
		return c;
	}

	public static RedisHealth getHealth() {
		RedisHealth h = health;
		if (h == null) {
			throw new IllegalStateException("RedisHealth not available — bundle is passive or not started");
		}
		return h;
	}

	/**
	 * @return the active keyspace notification subscriber, or {@code null} if
	 *         the bundle is passive or {@code keyspace.notifications.enabled}
	 *         is off.
	 */
	public static KeyspaceNotificationSubscriber getKeyspaceSubscriber() {
		return keyspaceSubscriber;
	}

	/** @return the deployment-level key prefix in the form <code>idempiere:&lt;name&gt;:</code>. */
	public static String getKeyPrefix() {
		RedisConfig c = config;
		return c != null ? c.getKeyPrefix() : "";
	}

	/**
	 * @return {@code true} if Redis was selected as the backend but the bundle
	 *         failed to initialise — used by the console to surface the
	 *         partial-startup state that {@link #getRedissonClient()} can't
	 *         distinguish from "bundle is passive".
	 */
	public static boolean isInitialisationFailed() {
		return initialisationFailed;
	}

	@Activate
	public void activate(BundleContext bundleContext) {
		// Synchronous init with bounded wait
		CountDownLatch ready = new CountDownLatch(1);
		initExecutor = Executors.newSingleThreadExecutor(daemonThreadFactory("redis-bundle-init"));
		initExecutor.execute(() -> initialiseAsync(bundleContext, ready));
		try {
			if (!ready.await(INIT_TIMEOUT_SECONDS, TimeUnit.SECONDS)) {
				stopping.set(true);
				initialisationFailed = true;
				log.severe("org.idempiere.redis.service initialisation did not complete within %s s — "
						+ "bundle remains passive. "
						+ "Inspect the bundle log for Redisson connection errors.".formatted(INIT_TIMEOUT_SECONDS));
			}
		} catch (InterruptedException e) {
			Thread.currentThread().interrupt();
			stopping.set(true);
			initialisationFailed = true;
			log.log(Level.SEVERE, "Interrupted while waiting for Redis bundle initialisation; remaining passive", e);
		}
	}

	private void initialiseAsync(BundleContext bundleContext, CountDownLatch ready) {
		try {
			RedisConfig cfg = RedisConfig.load();
			RedissonClient c = Redisson.create(cfg.getRedissonConfig());
			// Redisson.create() is the slow/blocking call. Check whether activate() timed
			// out or deactivate() already ran before we publish any shared state.
			if (stopping.get()) {
				try { c.shutdown(); } catch (Exception ignore) {}
				log.log(Level.WARNING, "Redis init completed after timeout/deactivate; discarding client");
				return;
			}
			RedisHealth h = new RedisHealth(c, cfg.getCircuitFailureThreshold(),
					cfg.getCircuitProbeInterval().toMillis());
			HealthEventPublisher publisher = new HealthEventPublisher(bundleContext, h);
			h.setStateListener(publisher);
			config = cfg;
			client = c;
			health = h;
			healthEventPublisher = publisher;
			consoleRegistration = bundleContext.registerService(
					CommandProvider.class, new RedisConsoleProvider(bundleContext), null);
			if (cfg.isKeyspaceNotificationsEnabled()) {
				KeyspaceNotificationSubscriber subscriber =
						new KeyspaceNotificationSubscriber(bundleContext, c, cfg.getKeyPrefix());
				subscriber.start();
				keyspaceSubscriber = subscriber;
			}
			// Second stopping check: do not enable DS components if we are already shutting down.
			if (stopping.get()) {
				log.log(Level.WARNING, "Redis bundle deactivated before DS components could be enabled; staying passive");
				return;
			}
			// Register the Condition service to enable the three target DS components.
	        Hashtable<String, Object> props = new Hashtable<>();
	        props.put("osgi.condition.id", "distributed.provider.redis.initialized");
	        bundleContext.registerService(Condition.class, Condition.INSTANCE, props);
			log.log(Level.INFO, "org.idempiere.redis.service activated as the distributed backend — "
					+ "key prefix: %s; near-cache: %s; circuit failure-threshold: %s".formatted(
					cfg.getKeyPrefix(), cfg.isNearCacheEnabled(), cfg.getCircuitFailureThreshold()));
		} catch (Exception e) {
			initialisationFailed = true;
			log.log(Level.SEVERE, "org.idempiere.redis.service failed to initialise."
					+ " Use 'redisStatus' on the OSGi console for details.", e);
		} finally {
			ready.countDown();
		}
	}

	@Deactivate
	public void deactivate(BundleContext bundleContext) {
		stopping.set(true);
		ExecutorService exec = initExecutor;
		initExecutor = null;
		if (exec != null) {
			exec.shutdownNow();
			try {
				exec.awaitTermination(5, TimeUnit.SECONDS);
			} catch (InterruptedException ie) {
				Thread.currentThread().interrupt();
			}
		}
		ServiceRegistration<CommandProvider> reg = consoleRegistration;
		consoleRegistration = null;
		if (reg != null) {
			try {
				reg.unregister();
			} catch (IllegalStateException ignored) {
				// already unregistered during framework shutdown — fine
			}
		}
		KeyspaceNotificationSubscriber subscriber = keyspaceSubscriber;
		keyspaceSubscriber = null;
		if (subscriber != null) {
			subscriber.close();
		}
		HealthEventPublisher publisher = healthEventPublisher;
		healthEventPublisher = null;
		if (publisher != null) {
			publisher.close();
		}
		RedisHealth h = health;
		health = null;
		if (h != null) {
			try {
				h.close();
			} catch (Exception e) {
				log.log(Level.WARNING, "Error closing RedisHealth", e);
			}
		}
		RedissonClient c = client;
		client = null;
		config = null;
		initialisationFailed = false;
		if (c != null) {
			try {
				c.shutdown();
				log.info("org.idempiere.redis.service stopped — RedissonClient shut down");
			} catch (Exception e) {
				log.log(Level.WARNING, "Error shutting down RedissonClient", e);
			}
		} else {
			log.info("org.idempiere.redis.service stopped");
		}
	}

	private static ThreadFactory daemonThreadFactory(String name) {
		return r -> {
			Thread t = new Thread(r, name);
			t.setDaemon(true);
			return t;
		};
	}
}
