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
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.Properties;
import java.util.Set;

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
 *   <li><code>ADEMPIERE_DB_NAME</code> auto-derived from <code>idempiereEnv.properties</code></li>
 *   <li>literal <code>"default"</code> (with warning — risks collision in shared Redis)</li>
 * </ol>
 *
 * <p>The resulting prefix is <code>idempiere:&lt;name&gt;:</code> and is prepended to every
 * cache key by {@code CacheServiceImpl} to isolate distinct deployments sharing one Redis.</p>
 *
 * <p>Optional Caffeine near-cache + circuit-breaker tuning is read from the same
 * <code>redis.properties</code> file (all properties optional; sensible defaults apply):</p>
 * <ul>
 *   <li><code>near-cache.enabled</code> — wrap each {@code RMap} in a Caffeine front layer (default {@code false})</li>
 *   <li><code>near-cache.maxSize</code> — entries per cache (default 10000)</li>
 *   <li><code>near-cache.expireAfterWrite</code> — ISO-8601 duration (default {@code PT5M})</li>
 *   <li><code>fallback.enabled</code> — keep a separate longer-lived Caffeine
 *       layer that serves stale values when the breaker is OPEN; survives
 *       Redis-down windows that outlast the near-cache TTL (default {@code true}
 *       when {@code near-cache.enabled=true}, ignored otherwise)</li>
 *   <li><code>fallback.maxSize</code> — entries per cache (default 100000)</li>
 *   <li><code>fallback.expireAfterWrite</code> — ISO-8601 duration (default {@code PT30M})</li>
 *   <li><code>redis.circuit.failure-threshold</code> — consecutive failures to trip the breaker (default 5)</li>
 *   <li><code>redis.circuit.probe-interval</code> — ISO-8601 duration between recovery probes when OPEN (default {@code PT60S})</li>
 *   <li><code>messaging.reliable</code> — back {@code IMessageService} topics with
 *       Redis Streams instead of plain pub/sub so subscribers receive messages
 *       missed during transient disconnects (default {@code false})</li>
 *   <li><code>keyspace.notifications.enabled</code> — subscribe to Redis
 *       keyspace notifications under this deployment's prefix and republish
 *       each event via OSGi EventAdmin (default {@code false}; requires
 *       {@code notify-keyspace-events} configured server-side)</li>
 * </ul>
 */
public final class RedisConfig {

	private static final Logger log = LoggerFactory.getLogger(RedisConfig.class);

	private static final String YAML_FILENAME = "redis.yaml";
	private static final String PROPERTIES_FILENAME = "redis.properties";
	private static final String IDEMPIERE_ENV_FILENAME = "idempiereEnv.properties";
	private static final String IDEMPIERE_ENV_DB_NAME_KEY = "ADEMPIERE_DB_NAME";
	private static final String INSTANCE_NAME_PROPERTY = "redis.instance.name";
	private static final String INSTANCE_NAME_ENV = "IDEMPIERE_INSTANCE_NAME";
	private static final String DEFAULT_REDIS_ADDRESS = "redis://localhost:6379";
	private static final String DEFAULT_INSTANCE_NAME = "default";

	private static final String NEAR_CACHE_ENABLED = "near-cache.enabled";
	private static final String NEAR_CACHE_MAX_SIZE = "near-cache.maxSize";
	private static final String NEAR_CACHE_EXPIRE_AFTER_WRITE = "near-cache.expireAfterWrite";
	private static final String FALLBACK_ENABLED = "fallback.enabled";
	private static final String FALLBACK_MAX_SIZE = "fallback.maxSize";
	private static final String FALLBACK_EXPIRE_AFTER_WRITE = "fallback.expireAfterWrite";
	private static final String CIRCUIT_FAILURE_THRESHOLD = "redis.circuit.failure-threshold";
	private static final String CIRCUIT_PROBE_INTERVAL = "redis.circuit.probe-interval";
	private static final String MESSAGING_RELIABLE = "messaging.reliable";
	private static final String KEYSPACE_NOTIFICATIONS_ENABLED = "keyspace.notifications.enabled";
	private static final String RPC_CALLABLE_ALLOWLIST = "rpc.callable.allowlist";
	private static final String RPC_HMAC_SECRET = "rpc.hmac.secret";

	private static final boolean DEFAULT_NEAR_CACHE_ENABLED = false;
	private static final int DEFAULT_NEAR_CACHE_MAX_SIZE = 10_000;
	private static final Duration DEFAULT_NEAR_CACHE_EXPIRE = Duration.ofMinutes(5);
	private static final boolean DEFAULT_FALLBACK_ENABLED = true;
	private static final int DEFAULT_FALLBACK_MAX_SIZE = 100_000;
	private static final Duration DEFAULT_FALLBACK_EXPIRE = Duration.ofMinutes(30);
	private static final int DEFAULT_CIRCUIT_FAILURE_THRESHOLD = 5;
	private static final Duration DEFAULT_CIRCUIT_PROBE_INTERVAL = Duration.ofSeconds(60);
	private static final boolean DEFAULT_MESSAGING_RELIABLE = false;
	private static final boolean DEFAULT_KEYSPACE_NOTIFICATIONS_ENABLED = false;
	private static final Set<String> DEFAULT_RPC_CALLABLE_ALLOWLIST = Collections.emptySet();
	private static final String DEFAULT_RPC_HMAC_SECRET = null;

	private final Config redissonConfig;
	private final String keyPrefix;
	private final boolean nearCacheEnabled;
	private final int nearCacheMaxSize;
	private final Duration nearCacheExpireAfterWrite;
	private final boolean fallbackEnabled;
	private final int fallbackMaxSize;
	private final Duration fallbackExpireAfterWrite;
	private final int circuitFailureThreshold;
	private final Duration circuitProbeInterval;
	private final boolean messagingReliable;
	private final boolean keyspaceNotificationsEnabled;
	private final Set<String> rpcCallableAllowlist;
	private final String rpcHmacSecret;

	private RedisConfig(Config redissonConfig, String keyPrefix, boolean nearCacheEnabled,
			int nearCacheMaxSize, Duration nearCacheExpireAfterWrite,
			boolean fallbackEnabled, int fallbackMaxSize, Duration fallbackExpireAfterWrite,
			int circuitFailureThreshold, Duration circuitProbeInterval,
			boolean messagingReliable, boolean keyspaceNotificationsEnabled,
			Set<String> rpcCallableAllowlist, String rpcHmacSecret) {
		this.redissonConfig = redissonConfig;
		this.keyPrefix = keyPrefix;
		this.nearCacheEnabled = nearCacheEnabled;
		this.nearCacheMaxSize = nearCacheMaxSize;
		this.nearCacheExpireAfterWrite = nearCacheExpireAfterWrite;
		this.fallbackEnabled = fallbackEnabled;
		this.fallbackMaxSize = fallbackMaxSize;
		this.fallbackExpireAfterWrite = fallbackExpireAfterWrite;
		this.circuitFailureThreshold = circuitFailureThreshold;
		this.circuitProbeInterval = circuitProbeInterval;
		this.messagingReliable = messagingReliable;
		this.keyspaceNotificationsEnabled = keyspaceNotificationsEnabled;
		this.rpcCallableAllowlist = rpcCallableAllowlist;
		this.rpcHmacSecret = rpcHmacSecret;
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

	/**
	 * @return {@code true} if a separate Redis-down fallback cache should be
	 *         maintained alongside the near-cache. Always {@code false} when
	 *         the near-cache itself is disabled (no wrapper, no fallback).
	 */
	public boolean isFallbackEnabled() {
		return fallbackEnabled;
	}

	public int getFallbackMaxSize() {
		return fallbackMaxSize;
	}

	public Duration getFallbackExpireAfterWrite() {
		return fallbackExpireAfterWrite;
	}

	public int getCircuitFailureThreshold() {
		return circuitFailureThreshold;
	}

	public Duration getCircuitProbeInterval() {
		return circuitProbeInterval;
	}

	/**
	 * @return {@code true} when {@code IMessageService} should hand out
	 *         {@code RReliableTopic} (Redis-Streams-backed, durable across
	 *         subscriber disconnects) instead of plain {@code RTopic}.
	 */
	public boolean isMessagingReliable() {
		return messagingReliable;
	}

	/**
	 * @return {@code true} when the Activator should start a
	 *         {@code KeyspaceNotificationSubscriber} that republishes Redis
	 *         keyspace events for keys under {@link #getKeyPrefix()} via
	 *         OSGi EventAdmin. Requires server-side
	 *         {@code notify-keyspace-events} to be configured.
	 */
	public boolean isKeyspaceNotificationsEnabled() {
		return keyspaceNotificationsEnabled;
	}

	/**
	 * Returns the set of fully-qualified class names that may appear as
	 * {@code Callable} implementations in RPC requests. When non-empty, the
	 * bundle uses a Kryo codec with {@code registrationRequired=true} for both
	 * RPC topics, rejecting deserialization of any class not in this set.
	 * Empty set (default) = unrestricted (development only; see security note
	 * on {@code RpcRequest}).
	 */
	public Set<String> getRpcCallableAllowlist() {
		return rpcCallableAllowlist;
	}

	/**
	 * Returns the shared HMAC-SHA256 secret used to authenticate RPC envelopes,
	 * or {@code null} when HMAC is disabled. All cluster nodes must share the
	 * same secret.
	 */
	public String getRpcHmacSecret() {
		return rpcHmacSecret;
	}

	/** Loads configuration from {@code $IDEMPIERE_HOME}, applying defaults where files are absent. */
	public static RedisConfig load() {
		File home = resolveIdempiereHome();
		Config redisson = loadRedissonConfig(home);
		Properties props = loadProperties(home);
		String prefix = resolveKeyPrefix(props, home);
		boolean nearCacheEnabled = ConfigParser.boolProp(props, NEAR_CACHE_ENABLED, DEFAULT_NEAR_CACHE_ENABLED);
		int nearCacheMax = ConfigParser.intProp(props, NEAR_CACHE_MAX_SIZE, DEFAULT_NEAR_CACHE_MAX_SIZE);
		Duration nearCacheExpire = ConfigParser.durationProp(props, NEAR_CACHE_EXPIRE_AFTER_WRITE, DEFAULT_NEAR_CACHE_EXPIRE);
		// Fallback only makes sense when there's a near-cache wrapper to attach it to.
		// When near-cache is off the bundle returns the raw RMap and Redis failures
		// surface to callers - there's no wrapper layer to host a fallback cache.
		boolean fallbackRequested = ConfigParser.boolProp(props, FALLBACK_ENABLED, DEFAULT_FALLBACK_ENABLED);
		boolean fallbackEnabled = nearCacheEnabled && fallbackRequested;
		if (fallbackRequested && !nearCacheEnabled) {
			log.info("{}=true was requested but {}=false — fallback layer is hosted by the "
					+ "near-cache wrapper, so it is implicitly off. Enable {} to opt in to fallback.",
					FALLBACK_ENABLED, NEAR_CACHE_ENABLED, NEAR_CACHE_ENABLED);
		}
		int fallbackMax = ConfigParser.intProp(props, FALLBACK_MAX_SIZE, DEFAULT_FALLBACK_MAX_SIZE);
		Duration fallbackExpire = ConfigParser.durationProp(props, FALLBACK_EXPIRE_AFTER_WRITE, DEFAULT_FALLBACK_EXPIRE);
		int circuitFailures = ConfigParser.intProp(props, CIRCUIT_FAILURE_THRESHOLD, DEFAULT_CIRCUIT_FAILURE_THRESHOLD);
		Duration circuitProbe = ConfigParser.durationProp(props, CIRCUIT_PROBE_INTERVAL, DEFAULT_CIRCUIT_PROBE_INTERVAL);
		boolean messagingReliable = ConfigParser.boolProp(props, MESSAGING_RELIABLE, DEFAULT_MESSAGING_RELIABLE);
		boolean keyspaceNotifications = ConfigParser.boolProp(props, KEYSPACE_NOTIFICATIONS_ENABLED,
				DEFAULT_KEYSPACE_NOTIFICATIONS_ENABLED);
		Set<String> rpcAllowlist = parseRpcAllowlist(props);
		String rpcHmacSecret = props.getProperty(RPC_HMAC_SECRET);
		if (rpcHmacSecret != null && rpcHmacSecret.isBlank()) {
			rpcHmacSecret = DEFAULT_RPC_HMAC_SECRET;
		}
		return new RedisConfig(redisson, prefix, nearCacheEnabled, nearCacheMax, nearCacheExpire,
				fallbackEnabled, fallbackMax, fallbackExpire,
				circuitFailures, circuitProbe, messagingReliable, keyspaceNotifications,
				rpcAllowlist, rpcHmacSecret);
	}

	private static Set<String> parseRpcAllowlist(Properties props) {
		String raw = props.getProperty(RPC_CALLABLE_ALLOWLIST);
		if (raw == null || raw.isBlank()) {
			return DEFAULT_RPC_CALLABLE_ALLOWLIST;
		}
		Set<String> result = new LinkedHashSet<>();
		for (String entry : raw.split(",")) {
			String trimmed = entry.trim();
			if (!trimmed.isEmpty()) {
				result.add(trimmed);
			}
		}
		return Collections.unmodifiableSet(result);
	}

	private static File resolveIdempiereHome() {
		String path = System.getProperty("IDEMPIERE_HOME");
		if (path == null || path.isBlank()) {
			path = System.getenv("IDEMPIERE_HOME");
		}
		return (path == null || path.isBlank()) ? null : new File(path);
	}

	private static Config loadRedissonConfig(File home) {
		if (home != null) {
			File yaml = new File(home, YAML_FILENAME);
			if (yaml.isFile()) {
				log.info("Loading Redisson configuration from {}", yaml.getAbsolutePath());
				try {
					return Config.fromYAML(yaml);
				} catch (IOException e) {
					throw new IllegalStateException("Failed to parse " + yaml.getAbsolutePath()
							+ " — fix the YAML or remove the file to fall back to the development default", e);
				}
			}
			// IDEMPIERE_HOME is set but the YAML file is absent. That's a deployment
			// misconfiguration: an operator who actually wanted localhost would not
			// have set IDEMPIERE_HOME in the first place. Fail fast so the mistake
			// is loud at boot rather than silent.
			throw new IllegalStateException("IDEMPIERE_HOME=" + home.getAbsolutePath()
					+ " is set but " + YAML_FILENAME + " is missing. Drop a redis.yaml in IDEMPIERE_HOME "
					+ "(see redis-template.yaml) or unset IDEMPIERE_HOME to use the development default ("
					+ DEFAULT_REDIS_ADDRESS + ").");
		}
		log.warn("No IDEMPIERE_HOME set; using single-server development default ({}). "
				+ "Configure {} in IDEMPIERE_HOME for any non-development deployment.",
				DEFAULT_REDIS_ADDRESS, YAML_FILENAME);
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

	/**
	 * Resolves the deployment instance name, which becomes the namespace
	 * segment in every Redis key (final form: {@code idempiere:<name>:...}).
	 *
	 * <p>Precedence (highest first):</p>
	 * <ol>
	 *   <li>{@link #INSTANCE_NAME_PROPERTY} in {@code redis.properties} —
	 *       explicit operator override.</li>
	 *   <li>{@link #INSTANCE_NAME_ENV} environment variable — deployment-time
	 *       injection (containers, ECS task env, ...).</li>
	 *   <li>{@code ADEMPIERE_DB_NAME} from {@code idempiereEnv.properties} —
	 *       auto-derived from the database iDempiere is already pointed at,
	 *       so most operators don't have to set anything explicit.</li>
	 *   <li>{@link #DEFAULT_INSTANCE_NAME} — last resort, with a WARN log
	 *       so collision risk is visible.</li>
	 * </ol>
	 *
	 * <p>The auto-derive step is keyed off the DB name because two iDempiere
	 * deployments pointing at the same database are functionally one logical
	 * cluster from the cache's perspective — sharing the namespace is the
	 * correct default. Override via {@code redis.properties} if a deployment
	 * intentionally needs a different namespace despite the shared DB
	 * (e.g. a sandbox copy-of-prod that must not invalidate prod's cache).</p>
	 */
	private static String resolveKeyPrefix(Properties props, File home) {
		String name = props.getProperty(INSTANCE_NAME_PROPERTY);
		if (name != null && name.isBlank()) {
			name = null;
		}
		if (name == null) {
			name = System.getenv(INSTANCE_NAME_ENV);
		}
		if (name != null && !name.isBlank()) {
			return "idempiere:" + name.trim() + ":";
		}
		String derived = deriveFromIdempiereEnv(home);
		if (derived != null) {
			log.info("Derived Redis instance name '{}' from {} ({}). Override with {} in {} "
					+ "or {} env var if a different namespace is needed.",
					derived, IDEMPIERE_ENV_FILENAME, IDEMPIERE_ENV_DB_NAME_KEY,
					INSTANCE_NAME_PROPERTY, PROPERTIES_FILENAME, INSTANCE_NAME_ENV);
			return "idempiere:" + derived + ":";
		}
		log.warn("No instance name configured (set {} property in {}, {} env var, or "
				+ "{} in {}). Falling back to '{}'. Multiple unconfigured deployments "
				+ "sharing one Redis WILL collide.",
				INSTANCE_NAME_PROPERTY, PROPERTIES_FILENAME, INSTANCE_NAME_ENV,
				IDEMPIERE_ENV_DB_NAME_KEY, IDEMPIERE_ENV_FILENAME, DEFAULT_INSTANCE_NAME);
		return "idempiere:" + DEFAULT_INSTANCE_NAME + ":";
	}

	/**
	 * Returns the trimmed value of {@code ADEMPIERE_DB_NAME} from
	 * {@code $IDEMPIERE_HOME/idempiereEnv.properties}, or {@code null} when
	 * the file is missing, unreadable, or the key is absent / blank.
	 */
	private static String deriveFromIdempiereEnv(File home) {
		if (home == null) {
			return null;
		}
		File envFile = new File(home, IDEMPIERE_ENV_FILENAME);
		if (!envFile.isFile()) {
			return null;
		}
		Properties p = new Properties();
		try (InputStream in = new FileInputStream(envFile)) {
			p.load(in);
		} catch (IOException e) {
			log.warn("Failed to read {} for instance-name derivation — ignoring: {}",
					envFile.getAbsolutePath(), e.getMessage());
			return null;
		}
		String dbName = p.getProperty(IDEMPIERE_ENV_DB_NAME_KEY);
		if (dbName == null || dbName.isBlank()) {
			return null;
		}
		return dbName.trim();
	}

}
