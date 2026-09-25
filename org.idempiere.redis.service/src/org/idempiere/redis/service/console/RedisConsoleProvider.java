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
package org.idempiere.redis.service.console;

import org.eclipse.osgi.framework.console.CommandInterpreter;
import org.eclipse.osgi.framework.console.CommandProvider;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.redis.service.Activator;
import org.idempiere.redis.service.config.RedisConfig;
import org.idempiere.redis.service.events.KeyspaceNotificationSubscriber;
import org.idempiere.redis.service.health.RedisHealth;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.redisson.api.RedissonClient;

/**
 * Equinox console commands for inspecting the Redis distributed backend at
 * runtime. Mirrors the {@code _hazelcastStatus} / {@code _hazelcastObjects}
 * style of {@code org.idempiere.hazelcast.service.CacheConsoleProvider} so
 * operators familiar with the existing tooling have a directly comparable
 * surface.
 *
 * <p><b>Commands:</b></p>
 * <ul>
 *   <li>{@code redisStatus} — bundle activation state, backend selector,
 *       key prefix, near-cache config.</li>
 *   <li>{@code redisHealth} — circuit-breaker state and counters.</li>
 *   <li>{@code redisMembers} — live cluster members (live heartbeat keys).</li>
 *   <li>{@code redisKeys [pattern]} — count keys matching a glob pattern,
 *       defaulting to the deployment prefix.</li>
 *   <li>{@code redisBound} — which OSGi service implementation is currently
 *       bound for {@code ICacheService} / {@code IMessageService} /
 *       {@code IClusterService} (i.e. is Redis or Hazelcast winning?).</li>
 * </ul>
 *
 * <p>All commands are read-only and safe to run in production. Each command
 * tolerates the bundle being in passive mode (no {@link RedissonClient}) and
 * prints a clear "not active" message rather than throwing.</p>
 */
public final class RedisConsoleProvider implements CommandProvider {

	private final BundleContext context;

	public RedisConsoleProvider(BundleContext context) {
		this.context = context;
	}

	@Override
	public String getHelp() {
		StringBuilder b = new StringBuilder();
		b.append("---- Redis distributed backend ----\n");
		b.append("\tredisStatus  - bundle activation state, key prefix, near-cache config\n");
		b.append("\tredisHealth  - circuit-breaker state and consecutive failures\n");
		b.append("\tredisMembers - live cluster members from heartbeat keys\n");
		b.append("\tredisKeys [pattern] - count Redis keys matching pattern (defaults to '<prefix>*')\n");
		b.append("\tredisBound   - which backend (Redis vs Hazelcast) is currently bound for distributed services\n");
		b.append("\tredisKeyspace - keyspace notification subscriber state and event count\n");
		return b.toString();
	}

	public Object _redisStatus(CommandInterpreter ci) {
		StringBuilder sb = new StringBuilder();
		RedissonClient client = tryClient();
		if (client == null) {
			if (Activator.isInitialisationFailed()) {
				sb.append("Redis bundle is in FAILED state — initialisation was attempted but did not complete.\n");
				sb.append("Hazelcast is currently serving the distributed interfaces.\n");
				sb.append("Inspect the bundle log for Redisson connection errors.\n");
			} else {
				sb.append("Redis bundle is in PASSIVE mode (RedissonClient not initialised).\n");
				sb.append("Set -Didempiere.distributed.backend=redis (or env IDEMPIERE_DISTRIBUTED_BACKEND=redis) to activate.\n");
			}
			ci.println(sb);
			return null;
		}
		RedisConfig cfg = Activator.getConfig();
		sb.append("Redis bundle: ACTIVE\n");
		sb.append("  key prefix:           ").append(cfg.getKeyPrefix()).append('\n');
		sb.append("  near-cache enabled:   ").append(cfg.isNearCacheEnabled()).append('\n');
		if (cfg.isNearCacheEnabled()) {
			sb.append("  near-cache max size:  ").append(cfg.getNearCacheMaxSize()).append('\n');
			sb.append("  near-cache TTL:       ").append(cfg.getNearCacheExpireAfterWrite()).append('\n');
		}
		sb.append("  fallback enabled:     ").append(cfg.isFallbackEnabled()).append('\n');
		if (cfg.isFallbackEnabled()) {
			sb.append("  fallback max size:    ").append(cfg.getFallbackMaxSize()).append('\n');
			sb.append("  fallback TTL:         ").append(cfg.getFallbackExpireAfterWrite()).append('\n');
		}
		sb.append("  circuit threshold:    ").append(cfg.getCircuitFailureThreshold()).append(" failures\n");
		sb.append("  circuit probe period: ").append(cfg.getCircuitProbeInterval()).append('\n');
		sb.append("  messaging:            ").append(cfg.isMessagingReliable() ? "RReliableTopic (Redis Streams)" : "RTopic (pub/sub)").append('\n');
		sb.append("  keyspace events:      ").append(cfg.isKeyspaceNotificationsEnabled() ? "subscribed" : "off").append('\n');
		ci.println(sb);
		return null;
	}

	public Object _redisHealth(CommandInterpreter ci) {
		StringBuilder sb = new StringBuilder();
		RedisHealth h = tryHealth();
		if (h == null) {
			ci.println("Redis bundle is in PASSIVE mode — no health to report.");
			return null;
		}
		sb.append("Circuit breaker state:    ").append(h.getState()).append('\n');
		sb.append("Consecutive failures:     ").append(h.getConsecutiveFailures()).append('\n');
		sb.append("Currently 'isHealthy()':  ").append(h.isHealthy()).append('\n');
		ci.println(sb);
		return null;
	}

	public Object _redisMembers(CommandInterpreter ci) {
		RedissonClient client = tryClient();
		if (client == null) {
			ci.println("Redis bundle is in PASSIVE mode — no cluster membership available.");
			return null;
		}
		ServiceReference<IClusterService> ref = context.getServiceReference(IClusterService.class);
		if (ref == null) {
			ci.println("IClusterService not registered (cluster component disabled or not yet activated).");
			return null;
		}
		try {
			IClusterService svc = context.getService(ref);
			if (svc == null) {
				ci.println("IClusterService reference unbound.");
				return null;
			}
			StringBuilder sb = new StringBuilder("Live cluster members:\n");
			int count = 0;
			for (IClusterMember member : svc.getMembers()) {
				sb.append("  ").append(member.getId());
				sb.append(" @ ").append(member.getAddress()).append(":").append(member.getPort());
				sb.append('\n');
				count++;
			}
			sb.append("Total: ").append(count);
			ci.println(sb);
		} finally {
			context.ungetService(ref);
		}
		return null;
	}

	public Object _redisKeys(CommandInterpreter ci) {
		RedissonClient client = tryClient();
		if (client == null) {
			ci.println("Redis bundle is in PASSIVE mode.");
			return null;
		}
		String pattern = ci.nextArgument();
		if (pattern == null || pattern.isBlank()) {
			pattern = Activator.getKeyPrefix() + "*";
		}
		try {
			long count = 0L;
			for (@SuppressWarnings("unused") String k : client.getKeys().getKeysByPattern(pattern)) {
				count++;
			}
			ci.println("Keys matching '" + pattern + "': " + count);
		} catch (Exception e) {
			ci.println("Failed to scan keys: " + e.getMessage());
		}
		return null;
	}

	public Object _redisBound(CommandInterpreter ci) {
		printBoundService(ci, "org.idempiere.distributed.ICacheService");
		printBoundService(ci, "org.idempiere.distributed.IMessageService");
		printBoundService(ci, "org.idempiere.distributed.IClusterService");
		return null;
	}

	public Object _redisKeyspace(CommandInterpreter ci) {
		KeyspaceNotificationSubscriber sub = Activator.getKeyspaceSubscriber();
		if (sub == null) {
			ci.println("Keyspace notification subscriber: NOT RUNNING");
			ci.println("Set keyspace.notifications.enabled=true in redis.properties to start it.");
			ci.println("Also requires server-side: redis-cli CONFIG SET notify-keyspace-events KEA");
			return null;
		}
		ci.println("Keyspace notification subscriber: ACTIVE");
		ci.println("  events forwarded:   " + sub.getEventCount());
		ci.println("  EventAdmin topic:   " + KeyspaceNotificationSubscriber.TOPIC_KEY_CHANGED);
		ci.println("Reminder: events fire only if Redis 'notify-keyspace-events' is configured.");
		return null;
	}

	private void printBoundService(CommandInterpreter ci, String className) {
		ServiceReference<?> ref = context.getServiceReference(className);
		if (ref == null) {
			ci.println(className + ": <no service registered>");
			return;
		}
		try {
			Object svc = context.getService(ref);
			Bundle providing = ref.getBundle();
			Object ranking = ref.getProperty("service.ranking");
			ci.println(className + ":");
			ci.println("  impl class:    " + (svc != null ? svc.getClass().getName() : "<unbound>"));
			ci.println("  provided by:   " + (providing != null ? providing.getSymbolicName() : "<unknown>"));
			ci.println("  service.ranking: " + (ranking != null ? ranking : "<unset>"));
		} finally {
			context.ungetService(ref);
		}
	}

	private static RedissonClient tryClient() {
		try {
			return Activator.getRedissonClient();
		} catch (IllegalStateException e) {
			return null;
		}
	}

	private static RedisHealth tryHealth() {
		try {
			return Activator.getHealth();
		} catch (IllegalStateException e) {
			return null;
		}
	}
}
