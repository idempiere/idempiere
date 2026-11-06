/***********************************************************************
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
 **********************************************************************/
package org.idempiere.redis.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.Future;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import org.compiere.util.CacheNewRecordCallable;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.redis.service.cluster.ClusterMember;
import org.idempiere.redis.service.cluster.RpcRequest;
import org.junit.jupiter.api.Test;
import org.redisson.api.RTopic;

/**
 * Cache new record notifications go out fire-and-forget: one request without a reply topic, no
 * response subscription, futures completed at once; a failed publish is kept and re-published.
 * Runs without Redis: the request topic is a stand-in that records what is published.
 */
public class ClusterServiceNotificationTest {

	private static final String SELF = "node-self";
	private static final String OTHER = "node-other";

	/** Subclass only to reach the protected constructor; behaves like the core class. */
	private static class NewRecord extends CacheNewRecordCallable {
		private static final long serialVersionUID = 1L;

		NewRecord(String tableName, int recordId) {
			super(tableName, recordId);
		}
	}

	private final List<Object> published = new CopyOnWriteArrayList<>();
	private final AtomicBoolean failPublish = new AtomicBoolean(false);

	private RTopic recordingTopic() {
		return (RTopic) Proxy.newProxyInstance(getClass().getClassLoader(), new Class<?>[] { RTopic.class },
				(proxy, method, args) -> {
					if ("publish".equals(method.getName())) {
						if (failPublish.get()) {
							throw new IllegalStateException("Redis unavailable (test)");
						}
						published.add(args[0]);
						return 1L;
					}
					throw new UnsupportedOperationException(method.getName());
				});
	}

	private ClusterServiceImpl service() throws Exception {
		ClusterServiceImpl service = new ClusterServiceImpl();
		@SuppressWarnings("unchecked")
		AtomicReference<ClusterMember> localMember = (AtomicReference<ClusterMember>) field(service, "localMember");
		localMember.set(new ClusterMember(SELF, null, 0));
		set(service, "requestTopic", recordingTopic());
		return service;
	}

	@Test
	public void testNewRecordIsPublishedWithoutReplyTopic() throws Exception {
		ClusterServiceImpl service = service();
		IClusterMember other = new ClusterMember(OTHER, null, 0);

		Map<IClusterMember, Future<Integer>> futures =
				service.execute(new NewRecord("CacheNotificationTest", 4711), List.of(other));

		assertEquals(1, published.size(), "one request on the request topic");
		RpcRequest request = (RpcRequest) published.get(0);
		assertNull(request.getResponseTopic(), "no reply topic");
		assertEquals(List.of(OTHER), List.of(request.getTargetUuids()));
		assertTrue(futures.get(other).isDone(), "future completed without waiting");
		assertEquals(0, ((AtomicInteger) field(service, "activeResponseSubscriptions")).get(),
				"no response subscription opened");
	}

	@Test
	public void testFailedPublishIsKeptAndRepublished() throws Exception {
		ClusterServiceImpl service = service();
		IClusterMember other = new ClusterMember(OTHER, null, 0);

		failPublish.set(true);
		service.execute(new NewRecord("CacheNotificationTest", 1), List.of(other));
		service.execute(new NewRecord("CacheNotificationTest", 2), List.of(other));
		assertEquals(0, published.size());

		failPublish.set(false);
		invoke(service, "retryFailedNotifications");

		assertEquals(2, published.size(), "both kept notifications re-published");
		assertEquals(0, ((AtomicInteger) field(service, "failedNotificationCount")).get());
	}

	@Test
	public void testRetryStopsAtFirstFailureAndKeepsTheRest() throws Exception {
		ClusterServiceImpl service = service();
		IClusterMember other = new ClusterMember(OTHER, null, 0);

		failPublish.set(true);
		service.execute(new NewRecord("CacheNotificationTest", 1), List.of(other));
		invoke(service, "retryFailedNotifications");

		assertEquals(0, published.size());
		assertEquals(1, ((AtomicInteger) field(service, "failedNotificationCount")).get(), "still kept");
	}

	private static Object field(Object target, String name) throws Exception {
		Field f = ClusterServiceImpl.class.getDeclaredField(name);
		f.setAccessible(true);
		return f.get(target);
	}

	private static void set(Object target, String name, Object value) throws Exception {
		Field f = ClusterServiceImpl.class.getDeclaredField(name);
		f.setAccessible(true);
		f.set(target, value);
	}

	private static void invoke(Object target, String name) throws Exception {
		Method m = ClusterServiceImpl.class.getDeclaredMethod(name);
		m.setAccessible(true);
		m.invoke(target);
	}
}
