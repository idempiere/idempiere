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
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.atomic.AtomicReference;

import org.idempiere.distributed.IClusterMember;
import org.idempiere.redis.service.cluster.AllowlistKryo5Codec;
import org.idempiere.redis.service.cluster.ClusterMember;
import org.idempiere.redis.service.cluster.RemoteExecutionException;
import org.idempiere.redis.service.cluster.RpcFrame;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.redisson.api.RTopic;
import org.redisson.client.codec.Codec;

/**
 * The calling side of cluster RPC: a request opens no subscription of its own, and only a signed
 * response from a member that was asked completes its future. Runs without Redis.
 */
public class ClusterServiceResponseTest {

	private static final String SELF = "node-self";
	private static final String OTHER = "node-other";
	private static final String SECRET = "a-test-secret-of-at-least-32-characters";

	/** A callable whose result the caller reads, so it goes request/response. */
	public static class Answer implements Callable<Integer>, Serializable {
		private static final long serialVersionUID = 1L;

		@Override
		public Integer call() {
			return 42;
		}
	}

	private final Codec codec = new AllowlistKryo5Codec(null, Set.of());
	private final List<Object> published = new CopyOnWriteArrayList<>();
	private ClusterServiceImpl service;

	@BeforeEach
	public void setUp() throws Exception {
		service = new ClusterServiceImpl();
		@SuppressWarnings("unchecked")
		AtomicReference<ClusterMember> localMember = (AtomicReference<ClusterMember>) field("localMember").get(service);
		localMember.set(new ClusterMember(SELF, null, 0));
		field("rpcCodec").set(service, codec);
		field("rpcHmacSecret").set(service, SECRET);
		field("requestTopic").set(service, Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] { RTopic.class }, (proxy, method, args) -> {
					if ("publish".equals(method.getName())) {
						published.add(args[0]);
						return 1L;
					}
					throw new UnsupportedOperationException(method.getName());
				}));
	}

	private Future<Integer> call() throws Exception {
		IClusterMember other = new ClusterMember(OTHER, null, 0);
		Map<IClusterMember, Future<Integer>> futures = service.execute(new Answer(), List.of(other));
		return futures.get(other);
	}

	private String publishedTaskId() throws Exception {
		RpcFrame request = RpcFrame.decode((byte[]) published.get(0), SECRET, "");
		assertTrue(request.isReplyExpected());
		return request.getTaskId();
	}

	private void respond(byte[] frame) throws Exception {
		Method m = ClusterServiceImpl.class.getDeclaredMethod("handleResponse", byte[].class);
		m.setAccessible(true);
		m.invoke(service, (Object) frame);
	}

	@Test
	public void testSignedResultCompletesTheFuture() throws Exception {
		Future<Integer> future = call();
		String taskId = publishedTaskId();
		assertFalse(future.isDone());

		respond(RpcFrame.result(System.currentTimeMillis(), taskId, OTHER,
				ClusterServiceImpl.encodePayload(codec, 42)).encode(SECRET, ""));

		assertEquals(42, future.get());
		assertTrue(((Map<?, ?>) field("pending").get(service)).isEmpty());
	}

	@Test
	public void testRemoteErrorFailsTheFuture() throws Exception {
		Future<Integer> future = call();
		respond(RpcFrame.error(System.currentTimeMillis(), publishedTaskId(), OTHER,
				"java.lang.IllegalStateException", "boom").encode(SECRET, ""));

		ExecutionException e = assertThrows(ExecutionException.class, future::get);
		assertInstanceOf(RemoteExecutionException.class, e.getCause());
		assertTrue(e.getCause().getMessage().contains("boom"));
	}

	@Test
	public void testResponsesThatDoNotBelongAreIgnored() throws Exception {
		Future<Integer> future = call();
		String taskId = publishedTaskId();
		long now = System.currentTimeMillis();
		byte[] payload = ClusterServiceImpl.encodePayload(codec, 7);

		respond(RpcFrame.result(now, taskId, "node-not-asked", payload).encode(SECRET, ""));
		respond(RpcFrame.result(now, taskId, OTHER, payload).encode(null, ""));
		respond(RpcFrame.result(now, taskId, OTHER, payload).encode("another-secret-another-secret-12345", ""));
		respond(RpcFrame.result(now, "another-task", OTHER, payload).encode(SECRET, ""));

		assertFalse(future.isDone(), "member not asked, unsigned, wrong secret and wrong task are all ignored");
	}

	private static Field field(String name) throws Exception {
		Field f = ClusterServiceImpl.class.getDeclaredField(name);
		f.setAccessible(true);
		return f;
	}
}
