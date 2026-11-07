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
**********************************************************************/
package org.idempiere.redis.service;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import org.idempiere.redis.service.cluster.AllowlistKryo5Codec;
import org.idempiere.redis.service.cluster.ClusterMember;
import org.idempiere.redis.service.cluster.RpcFrame;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.redisson.client.codec.Codec;

/**
 * The receiving side of cluster RPC: with a secret, only frames signed with it, recent and not
 * seen before, and addressed to this node, get their callable decoded and run. Runs without Redis:
 * frames are handed to the request listener directly.
 */
public class ClusterServiceRequestSecurityTest {

	private static final String SELF = "node-self";
	private static final String OTHER = "node-other";
	private static final String SECRET = "a-test-secret-of-at-least-32-characters";

	/** Counts how often it ran on this JVM. */
	public static class Counting implements Callable<Integer>, Serializable {
		private static final long serialVersionUID = 1L;
		static final AtomicInteger RUNS = new AtomicInteger();

		@Override
		public Integer call() {
			return RUNS.incrementAndGet();
		}
	}

	private final Codec codec = new AllowlistKryo5Codec(null, Set.of());
	private ClusterServiceImpl service;
	private ThreadPoolExecutor workers;

	@BeforeEach
	public void setUp() throws Exception {
		Counting.RUNS.set(0);
		service = new ClusterServiceImpl();
		@SuppressWarnings("unchecked")
		AtomicReference<ClusterMember> localMember = (AtomicReference<ClusterMember>) field("localMember").get(service);
		localMember.set(new ClusterMember(SELF, null, 0));
		field("rpcCodec").set(service, codec);
		field("rpcHmacSecret").set(service, SECRET);
		workers = new ThreadPoolExecutor(1, 1, 0L, TimeUnit.SECONDS, new ArrayBlockingQueue<>(10));
		field("rpcWorkers").set(service, workers);
	}

	private byte[] notification(long timestamp, String taskId, String target, Object payload, String secret)
			throws IOException {
		return RpcFrame.request(timestamp, taskId, OTHER, new String[] { target }, false,
				ClusterServiceImpl.encodePayload(codec, payload)).encode(secret, "");
	}

	private int deliver(byte[]... frames) throws Exception {
		Method handle = ClusterServiceImpl.class.getDeclaredMethod("handleRequest", byte[].class);
		handle.setAccessible(true);
		for (byte[] frame : frames) {
			handle.invoke(service, (Object) frame);
		}
		workers.shutdown();
		workers.awaitTermination(10, TimeUnit.SECONDS);
		return Counting.RUNS.get();
	}

	@Test
	public void testSignedFrameRunsOnce() throws Exception {
		byte[] frame = notification(System.currentTimeMillis(), "t1", SELF, new Counting(), SECRET);
		assertEquals(1, deliver(frame, frame), "the second copy is a replay");
	}

	@Test
	public void testForgedFramesDoNotRun() throws Exception {
		long now = System.currentTimeMillis();
		assertEquals(0, deliver(
				notification(now, "unsigned", SELF, new Counting(), null),
				notification(now, "wrong-secret", SELF, new Counting(), "another-secret-another-secret-12345")));
	}

	@Test
	public void testStaleFrameDoesNotRun() throws Exception {
		long old = System.currentTimeMillis() - 10 * 60_000L;
		assertEquals(0, deliver(notification(old, "old", SELF, new Counting(), SECRET)));
	}

	@Test
	public void testFrameForAnotherNodeDoesNotRun() throws Exception {
		assertEquals(0, deliver(notification(System.currentTimeMillis(), "t", "node-x", new Counting(), SECRET)));
	}

	@Test
	public void testWithoutSecretUnsignedFrameRuns() throws Exception {
		// Documents the default: without rpc.hmac.secret any publisher is trusted (a warning is logged at startup).
		field("rpcHmacSecret").set(service, null);
		assertEquals(1, deliver(notification(System.currentTimeMillis(), "t", SELF, new Counting(), null)));
	}

	private static Field field(String name) throws Exception {
		Field f = ClusterServiceImpl.class.getDeclaredField(name);
		f.setAccessible(true);
		return f;
	}
}
