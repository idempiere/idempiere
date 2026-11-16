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
package org.idempiere.redis.service.cache;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Payload published on the durable {@code cache:invalidation} topic.
 * Received by every cluster node which then calls its local cache reset.
 *
 * <p>Serialized as JSON via {@code TypedJsonJacksonCodec}. Redis must be protected
 * with {@code requirepass} and TLS — those are the real trust boundaries.</p>
 */
public final class CacheResetMessage {

	private final String tableName;
	/** -1 means "reset all entries for this table"; otherwise reset by this integer record key. */
	private final int recordId;
	/** Non-null when the reset is keyed by a string rather than an integer record ID. */
	private final String stringKey;
	/** Node ID of the publishing node; receivers skip the reset if they are the originator. */
	private final String originatorNodeId;

	@JsonCreator
	public CacheResetMessage(
			@JsonProperty("tableName") String tableName,
			@JsonProperty("recordId") int recordId,
			@JsonProperty("stringKey") String stringKey,
			@JsonProperty("originatorNodeId") String originatorNodeId) {
		this.tableName = tableName;
		this.recordId = recordId;
		this.stringKey = stringKey;
		this.originatorNodeId = originatorNodeId;
	}

	public CacheResetMessage(String tableName, int recordId, String originatorNodeId) {
		this(tableName, recordId, null, originatorNodeId);
	}

	public CacheResetMessage(String tableName, String stringKey, String originatorNodeId) {
		this(tableName, -1, stringKey, originatorNodeId);
	}

	public String getTableName() {
		return tableName;
	}

	public int getRecordId() {
		return recordId;
	}

	public String getStringKey() {
		return stringKey;
	}

	public boolean isStringKeyReset() {
		return stringKey != null;
	}

	public String getOriginatorNodeId() {
		return originatorNodeId;
	}

	@Override
	public String toString() {
		return "CacheResetMessage{table=" + tableName
				+ (isStringKeyReset() ? ", key=" + stringKey : ", recordId=" + recordId)
				+ ", originator=" + originatorNodeId + "}";
	}
}
