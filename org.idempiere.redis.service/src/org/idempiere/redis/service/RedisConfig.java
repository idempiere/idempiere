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

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
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
 */
public final class RedisConfig {

	private static final Logger log = LoggerFactory.getLogger(RedisConfig.class);

	private static final String YAML_FILENAME = "redis.yaml";
	private static final String PROPERTIES_FILENAME = "redis.properties";
	private static final String INSTANCE_NAME_PROPERTY = "redis.instance.name";
	private static final String INSTANCE_NAME_ENV = "IDEMPIERE_INSTANCE_NAME";
	private static final String DEFAULT_REDIS_ADDRESS = "redis://localhost:6379";
	private static final String DEFAULT_INSTANCE_NAME = "default";

	private final Config redissonConfig;
	private final String keyPrefix;

	private RedisConfig(Config redissonConfig, String keyPrefix) {
		this.redissonConfig = redissonConfig;
		this.keyPrefix = keyPrefix;
	}

	public Config getRedissonConfig() {
		return redissonConfig;
	}

	/** Mandatory namespace prefix; format <code>idempiere:&lt;name&gt;:</code>. */
	public String getKeyPrefix() {
		return keyPrefix;
	}

	/** Loads configuration from {@code $IDEMPIERE_HOME}, applying defaults where files are absent. */
	public static RedisConfig load() throws IOException {
		File home = resolveIdempiereHome();
		Config redisson = loadRedissonConfig(home);
		String prefix = resolveKeyPrefix(home);
		return new RedisConfig(redisson, prefix);
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

	private static String resolveKeyPrefix(File home) {
		String name = readInstanceNameFromProperties(home);
		if (name == null) {
			name = System.getenv(INSTANCE_NAME_ENV);
		}
		if (name == null || name.isBlank()) {
			log.warn("No instance name configured (set {} property in {} or {} env var). "
					+ "Falling back to '{}'. Multiple unconfigured deployments sharing one Redis WILL collide.",
					INSTANCE_NAME_PROPERTY, PROPERTIES_FILENAME, INSTANCE_NAME_ENV, DEFAULT_INSTANCE_NAME);
			name = DEFAULT_INSTANCE_NAME;
		}
		return "idempiere:" + name + ":";
	}

	private static String readInstanceNameFromProperties(File home) {
		if (home == null) {
			return null;
		}
		File props = new File(home, PROPERTIES_FILENAME);
		if (!props.isFile()) {
			return null;
		}
		Properties p = new Properties();
		try (InputStream in = new FileInputStream(props)) {
			p.load(in);
		} catch (IOException e) {
			log.warn("Failed to read {} — ignoring: {}", props.getAbsolutePath(), e.getMessage());
			return null;
		}
		String value = p.getProperty(INSTANCE_NAME_PROPERTY);
		return (value == null || value.isBlank()) ? null : value.trim();
	}
}
