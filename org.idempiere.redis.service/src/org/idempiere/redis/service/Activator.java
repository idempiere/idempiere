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

import java.util.Set;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;

import org.eclipse.osgi.framework.console.CommandProvider;
import org.idempiere.model.IMappedModelFactory;
import org.idempiere.redis.service.config.RedisConfig;
import org.idempiere.redis.service.console.RedisConsoleProvider;
import org.idempiere.redis.service.events.HealthEventPublisher;
import org.idempiere.redis.service.events.KeyspaceNotificationSubscriber;
import org.idempiere.redis.service.health.RedisHealth;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;
import org.osgi.framework.ServiceReference;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.runtime.ServiceComponentRuntime;
import org.osgi.service.component.runtime.dto.ComponentDescriptionDTO;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
 * the Redisson client, then enables the three target DS components programmatically
 * via the OSGi {@link ServiceComponentRuntime}. Each component declares
 * <code>service.ranking=100</code>, which guarantees that
 * {@code Service.locator().locate(...)} returns the Redis implementation when
 * both bundles are present.</p>
 *
 * <h3>Activation ordering</h3>
 *
 * <p>The mandatory {@link IMappedModelFactory} reference exists purely to gate
 * activation on iDempiere core readiness — SCR will only activate this
 * component once that core service has registered, which guarantees
 * {@link RedisConfig} parsing, the console provider, and any code that
 * indirectly touches iDempiere context can run safely.</p>
 *
 * <h3>Synchronous init with bounded wait</h3>
 *
 * <p>{@link Redisson#create} opens a Netty-backed connection that needs to
 * load classes from this bundle's {@code lib/redisson-all.jar}. Because OSGi
 * may serialise class loads from a starting bundle, doing the connect on the
 * SCR activation thread risks contention. Init runs on a dedicated worker
 * thread; the activate method blocks on a {@link CountDownLatch} for up to
 * {@link #INIT_TIMEOUT_SECONDS} seconds. If init times out, the bundle stays
 * passive and Hazelcast continues to serve — the failure is logged and
 * exposed via {@link #isInitialisationFailed()} for the console.</p>
 */
@Component(service = {}, immediate = true)
public class Activator {

	private static final Logger log = LoggerFactory.getLogger(Activator.class);

	private static final String BACKEND_PROPERTY = "idempiere.distributed.backend";
	private static final String BACKEND_ENV = "IDEMPIERE_DISTRIBUTED_BACKEND";
	private static final String BACKEND_VALUE_REDIS = "redis";

	/** Hard upper bound on synchronous init time before we give up and stay passive. */
	private static final long INIT_TIMEOUT_SECONDS = 30L;

	/**
	 * The set of DS components in this bundle that should be activated when the
	 * Redis backend is selected. Listed by class name (== component name) so a
	 * future addition to OSGI-INF/ doesn't accidentally inherit "enabled on
	 * Redis activation".
	 */
	private static final Set<String> COMPONENTS_TO_ENABLE = Set.of(
			"org.idempiere.redis.service.CacheServiceImpl",
			"org.idempiere.redis.service.ClusterServiceImpl",
			"org.idempiere.redis.service.MessageServiceImpl");

	/**
	 * Threading model for the static state below — written by the init worker
	 * thread, read by application threads going through {@link CacheServiceImpl}
	 * etc. {@code volatile} on each field gives us the necessary
	 * happens-before for individual reads. The latch in
	 * {@link #activate(BundleContext)} fences {@link #componentsEnabled} so DS
	 * components are not enabled until {@link #client}, {@link #config}, and
	 * {@link #health} are all visible.
	 */
	private static volatile RedissonClient client;
	private static volatile RedisConfig config;
	private static volatile RedisHealth health;
	private static volatile HealthEventPublisher healthEventPublisher;
	private static volatile KeyspaceNotificationSubscriber keyspaceSubscriber;
	private static volatile ServiceRegistration<CommandProvider> consoleRegistration;
	private static volatile boolean componentsEnabled;
	private static volatile boolean initialisationFailed;

	private volatile ExecutorService initExecutor;

	@Reference(service = IMappedModelFactory.class, cardinality = ReferenceCardinality.MANDATORY)
	void setMappedModelFactory(IMappedModelFactory mappedModelFactory) {
		// Bind method intentionally ignores the value — the reference is a wait
		// gate so SCR delays activation until iDempiere core has registered
		// IMappedModelFactory. See class Javadoc.
	}

	/**
	 * @return the shared {@link RedissonClient} created at bundle start.
	 * @throws IllegalStateException if the bundle is not active or initialisation failed.
	 */
	public static RedissonClient getRedissonClient() {
		RedissonClient c = client;
		if (c == null) {
			throw new IllegalStateException(
					"RedissonClient is not available — bundle org.idempiere.redis.service is either passive "
							+ "(set -D" + BACKEND_PROPERTY + "=" + BACKEND_VALUE_REDIS + " to activate) or it failed "
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
		String backend = resolveBackendSelector();
		if (!BACKEND_VALUE_REDIS.equalsIgnoreCase(backend)) {
			log.info("org.idempiere.redis.service started in passive mode "
					+ "(backend selector '{}' != 'redis'). Set -D{}={} (or env {}={}) to activate; "
					+ "Hazelcast remains the default backend.",
					(backend == null ? "<unset>" : backend),
					BACKEND_PROPERTY, BACKEND_VALUE_REDIS,
					BACKEND_ENV, BACKEND_VALUE_REDIS);
			return;
		}
		warnIfHazelcastAlsoInstalled(bundleContext);
		// Synchronous init with bounded wait: the worker thread releases the
		// latch only after the three target DS components are enabled. If we
		// return before that, application code that does
		// Service.locator().locate(ICacheService.class) will hit Hazelcast for
		// the brief window in between — the exact race that motivated this
		// change.
		CountDownLatch ready = new CountDownLatch(1);
		initExecutor = Executors.newSingleThreadExecutor(daemonThreadFactory("redis-bundle-init"));
		initExecutor.execute(() -> initialiseAsync(bundleContext, ready));
		try {
			if (!ready.await(INIT_TIMEOUT_SECONDS, TimeUnit.SECONDS)) {
				initialisationFailed = true;
				log.error("org.idempiere.redis.service initialisation did not complete within {} s — "
						+ "bundle remains passive and Hazelcast continues to serve the distributed interfaces. "
						+ "Inspect the bundle log for Redisson connection errors.", INIT_TIMEOUT_SECONDS);
			}
		} catch (InterruptedException e) {
			Thread.currentThread().interrupt();
			initialisationFailed = true;
			log.error("Interrupted while waiting for Redis bundle initialisation; remaining passive", e);
		}
	}

	private void initialiseAsync(BundleContext bundleContext, CountDownLatch ready) {
		try {
			RedisConfig cfg = RedisConfig.load();
			RedissonClient c = Redisson.create(cfg.getRedissonConfig());
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
			enableDsComponents(bundleContext);
			componentsEnabled = true;
			log.info("org.idempiere.redis.service activated as the distributed backend — "
					+ "key prefix: {}; near-cache: {}; circuit failure-threshold: {}",
					cfg.getKeyPrefix(), cfg.isNearCacheEnabled(), cfg.getCircuitFailureThreshold());
		} catch (Exception e) {
			initialisationFailed = true;
			log.error("org.idempiere.redis.service failed to initialise — Hazelcast will continue serving "
					+ "the distributed interfaces. Use 'redisStatus' on the OSGi console for details.", e);
		} finally {
			ready.countDown();
		}
	}

	@Deactivate
	public void deactivate(BundleContext bundleContext) {
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
		if (componentsEnabled) {
			disableDsComponents(bundleContext);
			componentsEnabled = false;
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
				log.warn("Error closing RedisHealth", e);
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
				log.warn("Error shutting down RedissonClient", e);
			}
		} else {
			log.info("org.idempiere.redis.service stopped");
		}
	}

	private static String resolveBackendSelector() {
		String value = System.getProperty(BACKEND_PROPERTY);
		if (value == null || value.isBlank()) {
			value = System.getenv(BACKEND_ENV);
		}
		return value == null ? null : value.trim();
	}

	private static void warnIfHazelcastAlsoInstalled(BundleContext ctx) {
		for (Bundle b : ctx.getBundles()) {
			if ("org.idempiere.hazelcast.service".equals(b.getSymbolicName())) {
				log.warn("Both org.idempiere.redis.service AND org.idempiere.hazelcast.service are installed. "
						+ "Redis wins service-locate due to service.ranking=100, but Hazelcast will still spin "
						+ "up its peer cluster (consuming memory and ports) for no benefit. "
						+ "Uninstall the Hazelcast bundle for production deployments using Redis.");
				return;
			}
		}
	}

	/**
	 * Enables this bundle's target DS components after the {@link RedissonClient}
	 * is ready. Listed explicitly via {@link #COMPONENTS_TO_ENABLE} rather than
	 * iterating all components in the bundle so future additions don't inherit
	 * the activation behaviour by accident.
	 */
	private void enableDsComponents(BundleContext ctx) {
		ServiceReference<ServiceComponentRuntime> ref = ctx.getServiceReference(ServiceComponentRuntime.class);
		if (ref == null) {
			log.warn("ServiceComponentRuntime not available — DS components will not register; "
					+ "Hazelcast will continue to serve the distributed interfaces");
			return;
		}
		try {
			ServiceComponentRuntime scr = ctx.getService(ref);
			if (scr == null) {
				return;
			}
			for (ComponentDescriptionDTO dto : scr.getComponentDescriptionDTOs(ctx.getBundle())) {
				if (COMPONENTS_TO_ENABLE.contains(dto.name)) {
					scr.enableComponent(dto);
				}
			}
		} finally {
			ctx.ungetService(ref);
		}
	}

	private void disableDsComponents(BundleContext ctx) {
		ServiceReference<ServiceComponentRuntime> ref = ctx.getServiceReference(ServiceComponentRuntime.class);
		if (ref == null) {
			return;
		}
		try {
			ServiceComponentRuntime scr = ctx.getService(ref);
			if (scr == null) {
				return;
			}
			for (ComponentDescriptionDTO dto : scr.getComponentDescriptionDTOs(ctx.getBundle())) {
				if (COMPONENTS_TO_ENABLE.contains(dto.name)) {
					scr.disableComponent(dto);
				}
			}
		} finally {
			ctx.ungetService(ref);
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
