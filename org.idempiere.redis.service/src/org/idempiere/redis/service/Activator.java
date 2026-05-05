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

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Activator implements BundleActivator {

	private static final Logger log = LoggerFactory.getLogger(Activator.class);

	private static volatile BundleContext context;
	private static volatile RedissonClient client;
	private static volatile String keyPrefix;

	public static BundleContext getContext() {
		return context;
	}

	/**
	 * @return the shared {@link RedissonClient} created at bundle start.
	 * @throws IllegalStateException if the bundle is not started or initialization failed.
	 */
	public static RedissonClient getRedissonClient() {
		RedissonClient c = client;
		if (c == null) {
			throw new IllegalStateException(
					"RedissonClient is not available — bundle org.idempiere.redis.service either failed to start "
							+ "or could not initialize against the configured Redis server. Check the bundle log.");
		}
		return c;
	}

	/** @return the deployment-level key prefix in the form <code>idempiere:&lt;name&gt;:</code>. */
	public static String getKeyPrefix() {
		String p = keyPrefix;
		return p != null ? p : "";
	}

	@Override
	public void start(BundleContext bundleContext) throws Exception {
		context = bundleContext;
		try {
			RedisConfig cfg = RedisConfig.load();
			client = Redisson.create(cfg.getRedissonConfig());
			keyPrefix = cfg.getKeyPrefix();
			log.info("org.idempiere.redis.service started — RedissonClient initialized; key prefix: {}", keyPrefix);
		} catch (Exception e) {
			log.error("org.idempiere.redis.service failed to initialize RedissonClient — services will throw on access", e);
			// Do not rethrow: leave the bundle ACTIVE so OSGi diag is clean and operators
			// can fix configuration without forcing a bundle reinstall. CacheServiceImpl
			// callers will see IllegalStateException from getRedissonClient().
		}
	}

	@Override
	public void stop(BundleContext bundleContext) throws Exception {
		RedissonClient c = client;
		client = null;
		keyPrefix = null;
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
}
