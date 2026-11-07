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

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Refuses signed RPC frames that are too old, too far in the future, or already accepted once.
 *
 * <p>A frame is identified by its kind, sender and task id, all covered by the HMAC. An accepted
 * frame is remembered until its timestamp is older than the allowed clock skew; after that the
 * timestamp check alone refuses it.</p>
 */
public final class RpcReplayGuard {

	/** Above this many remembered frames, expired entries are removed at once instead of on the next purge. */
	static final int PURGE_THRESHOLD = 100_000;

	private final long maxSkewMillis;
	private final ConcurrentMap<String, Long> seen = new ConcurrentHashMap<>();

	public RpcReplayGuard(long maxSkewMillis) {
		this.maxSkewMillis = maxSkewMillis;
	}

	/**
	 * @return {@code null} when the frame is accepted (and is now remembered), otherwise the reason it is refused
	 */
	public String check(RpcFrame frame, long now) {
		long age = now - frame.getTimestamp();
		if (age > maxSkewMillis) {
			return "frame is " + age + " ms old";
		}
		if (-age > maxSkewMillis) {
			return "frame is " + (-age) + " ms in the future";
		}
		String id = frame.getKind() + ":" + frame.getSenderUuid() + ":" + frame.getTaskId();
		if (seen.putIfAbsent(id, frame.getTimestamp()) != null) {
			return "frame already received";
		}
		if (seen.size() > PURGE_THRESHOLD) {
			purge(now);
		}
		return null;
	}

	/** Forgets frames that the timestamp check refuses anyway. */
	public void purge(long now) {
		seen.values().removeIf(timestamp -> now - timestamp > maxSkewMillis);
	}

	int size() {
		return seen.size();
	}
}
