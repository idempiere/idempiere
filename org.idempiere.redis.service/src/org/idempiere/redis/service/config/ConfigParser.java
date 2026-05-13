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

import java.time.Duration;
import java.time.format.DateTimeParseException;
import java.util.Properties;
import java.util.function.Function;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Parse-with-fallback helpers shared by {@link RedisConfig} and the
 * cluster-service system-property reads, so all "read a config knob, log and
 * fall back if it's malformed" paths produce identical operator output.
 */
public final class ConfigParser {

	private static final Logger log = LoggerFactory.getLogger(ConfigParser.class);

	private ConfigParser() {
	}

	public static boolean boolProp(Properties p, String key, boolean defaultValue) {
		String v = p.getProperty(key);
		if (v == null || v.isBlank()) {
			return defaultValue;
		}
		String t = v.trim();
		if (t.equalsIgnoreCase("true")) {
			return true;
		}
		if (t.equalsIgnoreCase("false")) {
			return false;
		}
		log.warn("{}='{}' is not a valid boolean (true/false); defaulting to {}", key, v, defaultValue);
		return defaultValue;
	}

	public static int intProp(Properties p, String key, int defaultValue) {
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

	public static Duration durationProp(Properties p, String key, Duration defaultValue) {
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

	/**
	 * Reads a JVM system property and parses it through {@code parser}, returning
	 * {@code defaultValue} if the property is unset, blank, or fails parsing.
	 * Used for {@code idempiere.cluster.*} and similar overrides where there's
	 * no backing properties file.
	 */
	public static <T> T systemProp(String key, T defaultValue, Function<String, T> parser) {
		String v = System.getProperty(key);
		if (v == null || v.isBlank()) {
			return defaultValue;
		}
		try {
			return parser.apply(v.trim());
		} catch (RuntimeException e) {
			log.warn("System property {}='{}' is invalid ({}); defaulting to {}",
					key, v, e.getMessage(), defaultValue);
			return defaultValue;
		}
	}
}
