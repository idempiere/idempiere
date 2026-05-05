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
package org.idempiere.redis.service.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.Duration;
import java.time.format.DateTimeParseException;
import java.util.Properties;

import org.redisson.config.Config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Loads Redisson connection config and iDempiere-specific knobs from
 * <code>$IDEMPIERE_HOME/redis.yaml</code> and <code>$IDEMPIERE_HOME/redis.properties</code>.
 *
 * <p>If <code>redis.yaml</code> is absent the bundle falls back to a single-server
 * configuration pointing at <code>redis://localhost:6379</code> (development default,
 * logged as a warning).</p>
 *
 * <p>Key prefix resolution order (first wins):</p>
 * <ol>
 *   <li><code>redis.instance.name</code> property in <code>redis.properties</code></li>
 *   <li><code>IDEMPIERE_INSTANCE_NAME</code> environment variable</li>
 *   <li>literal <code>"default"</code> (with warning — risks collision in shared Redis)</li>
 * </ol>
 *
 * <p>The resulting prefix is <code>idempiere:&lt;name&gt;:</code> and is prepended to every
 * cache key by {@link CacheServiceImpl} to isolate distinct deployments sharing one Redis.</p>
 *
 * <p>Optional Caffeine near-cache + circuit-breaker tuning is read from the same
 * <code>redis.properties</code> file (all properties optional; sensible defaults apply):</p>
 * <ul>
 *   <li><code>near-cache.enabled</code> — wrap each {@code RMap} in a Caffeine front layer (default {@code false})</li>
 *   <li><code>near-cache.maxSize</code> — entries per cache (default 10000)</li>
 *   <li><code>near-cache.expireAfterWrite</code> — ISO-8601 duration (default {@code PT5M})</li>
 *   <li><code>redis.circuit.failure-threshold</code> — consecutive failures to trip the breaker (default 5)</li>
 *   <li><code>redis.circuit.probe-interval</code> — ISO-8601 duration between recovery probes when OPEN (default {@code PT60S})</li>
 * </ul>
 */
public final class RedisConfig {

	private static final Logger log = LoggerFactory.getLogger(RedisConfig.class);

	private static final String YAML_FILENAME = "redis.yaml";
	private static final String PROPERTIES_FILENAME = "redis.properties";
	private static final String INSTANCE_NAME_PROPERTY = "redis.instance.name";
	private static final String INSTANCE_NAME_ENV = "IDEMPIERE_INSTANCE_NAME";
	private static final String DEFAULT_REDIS_ADDRESS = "redis://localhost:6379";
	private static final String DEFAULT_INSTANCE_NAME = "default";

	private static final String NEAR_CACHE_ENABLED = "near-cache.enabled";
	private static final String NEAR_CACHE_MAX_SIZE = "near-cache.maxSize";
	private static final String NEAR_CACHE_EXPIRE_AFTER_WRITE = "near-cache.expireAfterWrite";
	private static final String CIRCUIT_FAILURE_THRESHOLD = "redis.circuit.failure-threshold";
	private static final String CIRCUIT_PROBE_INTERVAL = "redis.circuit.probe-interval";

	private static final boolean DEFAULT_NEAR_CACHE_ENABLED = false;
	private static final int DEFAULT_NEAR_CACHE_MAX_SIZE = 10_000;
	private static final Duration DEFAULT_NEAR_CACHE_EXPIRE = Duration.ofMinutes(5);
	private static final int DEFAULT_CIRCUIT_FAILURE_THRESHOLD = 5;
	private static final Duration DEFAULT_CIRCUIT_PROBE_INTERVAL = Duration.ofSeconds(60);

	private final Config redissonConfig;
	private final String keyPrefix;
	private final boolean nearCacheEnabled;
	private final int nearCacheMaxSize;
	private final Duration nearCacheExpireAfterWrite;
	private final int circuitFailureThreshold;
	private final Duration circuitProbeInterval;

	private RedisConfig(Config redissonConfig, String keyPrefix, boolean nearCacheEnabled,
			int nearCacheMaxSize, Duration nearCacheExpireAfterWrite,
			int circuitFailureThreshold, Duration circuitProbeInterval) {
		this.redissonConfig = redissonConfig;
		this.keyPrefix = keyPrefix;
		this.nearCacheEnabled = nearCacheEnabled;
		this.nearCacheMaxSize = nearCacheMaxSize;
		this.nearCacheExpireAfterWrite = nearCacheExpireAfterWrite;
		this.circuitFailureThreshold = circuitFailureThreshold;
		this.circuitProbeInterval = circuitProbeInterval;
	}

	public Config getRedissonConfig() {
		return redissonConfig;
	}

	/** Mandatory namespace prefix; format <code>idempiere:&lt;name&gt;:</code>. */
	public String getKeyPrefix() {
		return keyPrefix;
	}

	public boolean isNearCacheEnabled() {
		return nearCacheEnabled;
	}

	public int getNearCacheMaxSize() {
		return nearCacheMaxSize;
	}

	public Duration getNearCacheExpireAfterWrite() {
		return nearCacheExpireAfterWrite;
	}

	public int getCircuitFailureThreshold() {
		return circuitFailureThreshold;
	}

	public Duration getCircuitProbeInterval() {
		return circuitProbeInterval;
	}

	/** Loads configuration from {@code $IDEMPIERE_HOME}, applying defaults where files are absent. */
	public static RedisConfig load() throws IOException {
		File home = resolveIdempiereHome();
		Config redisson = loadRedissonConfig(home);
		Properties props = loadProperties(home);
		String prefix = resolveKeyPrefix(props);
		boolean nearCacheEnabled = boolProp(props, NEAR_CACHE_ENABLED, DEFAULT_NEAR_CACHE_ENABLED);
		int nearCacheMax = intProp(props, NEAR_CACHE_MAX_SIZE, DEFAULT_NEAR_CACHE_MAX_SIZE);
		Duration nearCacheExpire = durationProp(props, NEAR_CACHE_EXPIRE_AFTER_WRITE, DEFAULT_NEAR_CACHE_EXPIRE);
		int circuitFailures = intProp(props, CIRCUIT_FAILURE_THRESHOLD, DEFAULT_CIRCUIT_FAILURE_THRESHOLD);
		Duration circuitProbe = durationProp(props, CIRCUIT_PROBE_INTERVAL, DEFAULT_CIRCUIT_PROBE_INTERVAL);
		return new RedisConfig(redisson, prefix, nearCacheEnabled, nearCacheMax, nearCacheExpire,
				circuitFailures, circuitProbe);
	}

	private static File resolveIdempiereHome() {
		String path = System.getProperty("IDEMPIERE_HOME");
		if (path == null || path.isBlank()) {
			path = System.getenv("IDEMPIERE_HOME");
		}
		return (path == null || path.isBlank()) ? null : new File(path);
	}

	private static Config loadRedissonConfig(File home) throws IOException {
		if (home != null) {
			File yaml = new File(home, YAML_FILENAME);
			if (yaml.isFile()) {
				log.info("Loading Redisson configuration from {}", yaml.getAbsolutePath());
				return Config.fromYAML(yaml);
			}
		}
		log.warn("No {} found in IDEMPIERE_HOME — falling back to single-server default ({}). "
				+ "This is suitable for development only; configure {} for production deployments.",
				YAML_FILENAME, DEFAULT_REDIS_ADDRESS, YAML_FILENAME);
		Config cfg = new Config();
		cfg.useSingleServer().setAddress(DEFAULT_REDIS_ADDRESS);
		return cfg;
	}

	private static Properties loadProperties(File home) {
		Properties p = new Properties();
		if (home == null) {
			return p;
		}
		File props = new File(home, PROPERTIES_FILENAME);
		if (!props.isFile()) {
			return p;
		}
		try (InputStream in = new FileInputStream(props)) {
			p.load(in);
		} catch (IOException e) {
			log.warn("Failed to read {} — ignoring: {}", props.getAbsolutePath(), e.getMessage());
		}
		return p;
	}

	private static String resolveKeyPrefix(Properties props) {
		String name = props.getProperty(INSTANCE_NAME_PROPERTY);
		if (name != null && name.isBlank()) {
			name = null;
		}
		if (name == null) {
			name = System.getenv(INSTANCE_NAME_ENV);
		}
		if (name == null || name.isBlank()) {
			log.warn("No instance name configured (set {} property in {} or {} env var). "
					+ "Falling back to '{}'. Multiple unconfigured deployments sharing one Redis WILL collide.",
					INSTANCE_NAME_PROPERTY, PROPERTIES_FILENAME, INSTANCE_NAME_ENV, DEFAULT_INSTANCE_NAME);
			name = DEFAULT_INSTANCE_NAME;
		}
		return "idempiere:" + name.trim() + ":";
	}

	private static boolean boolProp(Properties p, String key, boolean defaultValue) {
		String v = p.getProperty(key);
		return (v == null || v.isBlank()) ? defaultValue : Boolean.parseBoolean(v.trim());
	}

	private static int intProp(Properties p, String key, int defaultValue) {
		String v = p.getProperty(key);
		if (v == null || v.isBlank()) {
			return defaultValue;
		}
		try {
			return Integer.parseInt(v.trim());
		} catch (NumberFormatException e) {
			log.warn("{}='{}' is not a valid integer; defaulting to {}", key, v, defaultValue);
			return defaultValue;
		}
	}

	private static Duration durationProp(Properties p, String key, Duration defaultValue) {
		String v = p.getProperty(key);
		if (v == null || v.isBlank()) {
			return defaultValue;
		}
		try {
			return Duration.parse(v.trim());
		} catch (DateTimeParseException e) {
			log.warn("{}='{}' is not a valid ISO-8601 duration (e.g. PT5M); defaulting to {}",
					key, v, defaultValue);
			return defaultValue;
		}
	}
}
