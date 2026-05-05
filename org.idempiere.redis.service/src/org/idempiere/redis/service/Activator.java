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

import org.idempiere.redis.service.config.RedisConfig;
import org.idempiere.redis.service.events.HealthEventPublisher;
import org.idempiere.redis.service.health.RedisHealth;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
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
 * <p>When the property is set to {@code redis}, this Activator initialises the
 * Redisson client, then enables the three DS components programmatically via
 * the OSGi {@link ServiceComponentRuntime}. Each component declares
 * <code>service.ranking=100</code>, which guarantees that
 * {@code Service.locator().locate(...)} returns the Redis implementation when
 * both bundles are present.</p>
 */
public class Activator implements BundleActivator {

	private static final Logger log = LoggerFactory.getLogger(Activator.class);

	private static final String BACKEND_PROPERTY = "idempiere.distributed.backend";
	private static final String BACKEND_ENV = "IDEMPIERE_DISTRIBUTED_BACKEND";
	private static final String BACKEND_VALUE_REDIS = "redis";

	private static volatile BundleContext context;
	private static volatile RedissonClient client;
	private static volatile RedisConfig config;
	private static volatile RedisHealth health;
	private static volatile HealthEventPublisher healthEventPublisher;
	private static volatile boolean componentsEnabled;
	private volatile Thread initThread;

	public static BundleContext getContext() {
		return context;
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

	/** @return the deployment-level key prefix in the form <code>idempiere:&lt;name&gt;:</code>. */
	public static String getKeyPrefix() {
		RedisConfig c = config;
		return c != null ? c.getKeyPrefix() : "";
	}

	@Override
	public void start(BundleContext bundleContext) throws Exception {
		context = bundleContext;
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
		// Spin up Redisson + DS components on a background thread so this
		// Activator.start() returns promptly. Redisson.create() opens a Netty-backed
		// connection that needs to load classes from THIS bundle's lib/redisson-all.jar;
		// OSGi serialises class loads from a STARTING bundle until its activator
		// returns, so doing the connect synchronously here would deadlock (Netty thread
		// waits for Activator → Activator waits for Netty).
		initThread = new Thread(() -> initialiseAsync(bundleContext), "redis-bundle-init");
		initThread.setDaemon(true);
		initThread.start();
	}

	private void initialiseAsync(BundleContext bundleContext) {
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
			enableDsComponents(bundleContext);
			log.info("org.idempiere.redis.service activated as the distributed backend — "
					+ "key prefix: {}; near-cache: {}; circuit failure-threshold: {}",
					cfg.getKeyPrefix(), cfg.isNearCacheEnabled(), cfg.getCircuitFailureThreshold());
		} catch (Exception e) {
			log.error("org.idempiere.redis.service failed to initialise — Hazelcast will continue serving "
					+ "the distributed interfaces", e);
		}
	}

	@Override
	public void stop(BundleContext bundleContext) throws Exception {
		// If background init is still running, give it a chance to finish so we don't
		// race a half-initialised RedissonClient that needs proper shutdown.
		Thread t = initThread;
		initThread = null;
		if (t != null && t.isAlive()) {
			t.interrupt();
			try {
				t.join(5000);
			} catch (InterruptedException ie) {
				Thread.currentThread().interrupt();
			}
		}
		if (componentsEnabled) {
			disableDsComponents(bundleContext);
			componentsEnabled = false;
		}
		HealthEventPublisher publisher = healthEventPublisher;
		healthEventPublisher = null;
		if (publisher != null) {
			publisher.close();
		}
		RedissonClient c = client;
		client = null;
		config = null;
		health = null;
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
		context = null;
	}

	private static String resolveBackendSelector() {
		String value = System.getProperty(BACKEND_PROPERTY);
		if (value == null || value.isBlank()) {
			value = System.getenv(BACKEND_ENV);
		}
		return value == null ? null : value.trim();
	}

	/**
	 * Programmatically enables this bundle's DS components after the
	 * {@link RedissonClient} is ready. The components ship with
	 * <code>enabled = false</code> so they do not auto-activate when the bundle
	 * starts in passive mode.
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
				scr.enableComponent(dto);
			}
			componentsEnabled = true;
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
				scr.disableComponent(dto);
			}
		} finally {
			ctx.ungetService(ref);
		}
	}
}
