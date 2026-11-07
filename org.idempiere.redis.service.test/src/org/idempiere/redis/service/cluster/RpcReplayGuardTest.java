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
package org.idempiere.redis.service.cluster;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

public class RpcReplayGuardTest {

	private static final long SKEW = 120_000L;
	private static final long NOW = 10_000_000L;

	private static RpcFrame frame(long timestamp, String taskId) {
		return RpcFrame.request(timestamp, taskId, "node-a", new String[] { "node-b" }, false, new byte[0]);
	}

	@Test
	public void testSecondCopyRefused() {
		RpcReplayGuard guard = new RpcReplayGuard(SKEW);
		assertNull(guard.check(frame(NOW, "t1"), NOW));
		assertNotNull(guard.check(frame(NOW, "t1"), NOW + 5), "same frame again");
		assertNull(guard.check(frame(NOW, "t2"), NOW + 5), "another task");
	}

	@Test
	public void testResentWithNewTimestampStillRefused() {
		// A notification re-published by the retry carries a new timestamp but the same task id.
		RpcReplayGuard guard = new RpcReplayGuard(SKEW);
		assertNull(guard.check(frame(NOW, "t1"), NOW));
		assertNotNull(guard.check(frame(NOW + 30_000, "t1"), NOW + 30_000));
	}

	@Test
	public void testOldAndFutureFramesRefused() {
		RpcReplayGuard guard = new RpcReplayGuard(SKEW);
		assertNotNull(guard.check(frame(NOW - SKEW - 1, "old"), NOW));
		assertNotNull(guard.check(frame(NOW + SKEW + 1, "future"), NOW));
		assertNull(guard.check(frame(NOW - SKEW, "edge"), NOW));
		assertEquals(1, guard.size(), "refused frames are not remembered");
	}

	@Test
	public void testPurgeForgetsOnlyExpiredFrames() {
		RpcReplayGuard guard = new RpcReplayGuard(SKEW);
		guard.check(frame(NOW, "a"), NOW);
		guard.check(frame(NOW + 60_000, "b"), NOW + 60_000);

		guard.purge(NOW + SKEW + 1);

		assertEquals(1, guard.size());
		assertNotNull(guard.check(frame(NOW + 60_000, "b"), NOW + SKEW + 1), "b still remembered");
	}
}
