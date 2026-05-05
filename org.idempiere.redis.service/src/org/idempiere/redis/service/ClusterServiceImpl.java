/******************************************************************************
 * Copyright (C) 2026 Norbert Bede                                            *
 * Copyright (C) 2026 CloudEmpiere                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * @contributor Norbert Bede                                                 *
 *****************************************************************************/
package org.idempiere.redis.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;

import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.redisson.api.RBucket;
import org.redisson.api.RKeys;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Redis-backed implementation of {@link IClusterService} membership.
 *
 * <p>Each running JVM writes a heartbeat key
 * <code>&lt;prefix&gt;cluster:members:&lt;uuid&gt;</code> with a 30-second TTL,
 * refreshed every 10 seconds by a daemon scheduler. {@link #getMembers()} scans
 * Redis for keys under the cluster-members namespace and returns the live members.
 * A node that crashes stops refreshing its key; the key expires within 30 s and
 * the node disappears from {@code getMembers()} naturally.</p>
 *
 * <p>Local address comes from {@link InetAddress#getLocalHost()}; in container
 * environments that returns the container's pod IP which is usually what is
 * wanted. Override via the {@code idempiere.cluster.address} system property if
 * needed. The port is informational for the Redis backend (Redisson does not
 * use peer-to-peer connections); default 0, override via
 * {@code idempiere.cluster.port}.</p>
 *
 * <p>The {@code execute(...)} overloads remain unimplemented in this commit;
 * topic-RPC machinery lands in a follow-up.</p>
 */
@Component(service = IClusterService.class, immediate = true)
public class ClusterServiceImpl implements IClusterService {

	private static final Logger log = LoggerFactory.getLogger(ClusterServiceImpl.class);

	private static final String MEMBERS_KEY_SUFFIX = "cluster:members:";
	private static final long HEARTBEAT_TTL_SECONDS = 30L;
	private static final long HEARTBEAT_PERIOD_SECONDS = 10L;

	private final AtomicReference<ClusterMember> localMember = new AtomicReference<>();
	private volatile ScheduledExecutorService heartbeatExecutor;

	@Activate
	void activate() {
		try {
			ClusterMember self = createLocalMember();
			localMember.set(self);
			heartbeatExecutor = Executors.newSingleThreadScheduledExecutor(r -> {
				Thread t = new Thread(r, "redis-cluster-heartbeat");
				t.setDaemon(true);
				return t;
			});
			heartbeatExecutor.scheduleAtFixedRate(this::heartbeat,
					0L, HEARTBEAT_PERIOD_SECONDS, TimeUnit.SECONDS);
			log.info("Redis cluster service activated; local member: {}", self);
		} catch (Exception e) {
			log.error("Failed to activate Redis cluster service — getMembers will return empty", e);
		}
	}

	@Deactivate
	void deactivate() {
		ScheduledExecutorService exec = heartbeatExecutor;
		heartbeatExecutor = null;
		if (exec != null) {
			exec.shutdownNow();
		}
		ClusterMember self = localMember.getAndSet(null);
		if (self != null) {
			try {
				RedissonClient client = Activator.getRedissonClient();
				client.getBucket(memberKey(self.getId())).delete();
				log.info("Redis cluster service deactivated; removed local member {}", self.getId());
			} catch (Exception e) {
				// best-effort cleanup; key will TTL-expire if delete fails
				log.warn("Failed to delete heartbeat key during deactivation; relying on TTL", e);
			}
		}
	}

	@Override
	public Collection<IClusterMember> getMembers() {
		ClusterMember self = localMember.get();
		if (self == null) {
			return Collections.emptyList();
		}
		try {
			RedissonClient client = Activator.getRedissonClient();
			RKeys keys = client.getKeys();
			String pattern = membersKeyPrefix() + "*";
			Collection<IClusterMember> members = new ArrayList<>();
			for (String key : keys.getKeysByPattern(pattern)) {
				RBucket<ClusterMember> bucket = client.getBucket(key);
				ClusterMember m = bucket.get();
				if (m != null) {
					members.add(m);
				}
			}
			return members;
		} catch (Exception e) {
			log.warn("getMembers failed; returning local member only", e);
			return Collections.singletonList(self);
		}
	}

	@Override
	public IClusterMember getLocalMember() {
		return localMember.get();
	}

	@Override
	public <V> Future<V> execute(Callable<V> task, IClusterMember member) {
		throw new UnsupportedOperationException("Targeted distributed compute not yet implemented");
	}

	@Override
	public <V> Map<IClusterMember, Future<V>> execute(Callable<V> task, Collection<IClusterMember> members) {
		throw new UnsupportedOperationException("Broadcast distributed compute not yet implemented");
	}

	private void heartbeat() {
		ClusterMember self = localMember.get();
		if (self == null) {
			return;
		}
		try {
			RedissonClient client = Activator.getRedissonClient();
			RBucket<ClusterMember> bucket = client.getBucket(memberKey(self.getId()));
			bucket.set(self, HEARTBEAT_TTL_SECONDS, TimeUnit.SECONDS);
		} catch (Exception e) {
			// Heartbeat misses are tolerated — TTL will eventually expire and the node
			// drops from getMembers() until Redis comes back. Log at warn so operators
			// notice, but do not crash the executor.
			log.warn("Heartbeat write failed; node may disappear from getMembers within {} s", HEARTBEAT_TTL_SECONDS, e);
		}
	}

	private static ClusterMember createLocalMember() throws UnknownHostException {
		String id = UUID.randomUUID().toString();
		InetAddress address = resolveLocalAddress();
		int port = resolveLocalPort();
		return new ClusterMember(id, address, port);
	}

	private static InetAddress resolveLocalAddress() throws UnknownHostException {
		String override = System.getProperty("idempiere.cluster.address");
		if (override != null && !override.isBlank()) {
			return InetAddress.getByName(override.trim());
		}
		return InetAddress.getLocalHost();
	}

	private static int resolveLocalPort() {
		String override = System.getProperty("idempiere.cluster.port");
		if (override != null && !override.isBlank()) {
			try {
				return Integer.parseInt(override.trim());
			} catch (NumberFormatException ignored) {
				log.warn("idempiere.cluster.port='{}' is not a valid integer; defaulting to 0", override);
			}
		}
		return 0;
	}

	private static String membersKeyPrefix() {
		return Activator.getKeyPrefix() + MEMBERS_KEY_SUFFIX;
	}

	private static String memberKey(String uuid) {
		return membersKeyPrefix() + uuid;
	}
}
