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
package org.idempiere.redis.service.cluster;

import java.io.Serializable;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Objects;

import org.idempiere.distributed.IClusterMember;

/**
 * Value object identifying one cluster member. Stored in Redis under a
 * heartbeat key so other nodes can discover live members.
 *
 * <p>The address is persisted as a {@code String} (numeric IP via
 * {@link InetAddress#getHostAddress()}) rather than the {@link InetAddress}
 * itself: codecs such as Kryo5 use reflection on JDK classes to serialise
 * {@code InetAddress}, and JDK 17 closes off {@code java.net} from reflection
 * by default ({@code module java.base does not "opens java.net" to unnamed
 * module}). Storing a String avoids that constraint without requiring callers
 * to pass {@code --add-opens} JVM flags. The {@link #getAddress()} accessor
 * lazily reconstructs the {@link InetAddress} from the String on first call.</p>
 *
 * <p>Mutable fields and a no-arg constructor are kept on purpose so that
 * codecs which require POJO-style hydration (Kryo, Fury, Jackson) can
 * deserialize without reflection-into-final-fields contortions.</p>
 */
public class ClusterMember implements IClusterMember, Serializable {

	private static final long serialVersionUID = 2L;

	private String id;
	/** Numeric IP address as a String — what we actually serialise. */
	private String host;
	private int port;
	/** Cached {@link InetAddress} reconstructed lazily from {@link #host}; never serialised. */
	private transient InetAddress addressCache;

	/** Required by serialization codecs. Do not call directly. */
	public ClusterMember() {
	}

	public ClusterMember(String id, InetAddress address, int port) {
		this.id = id;
		this.host = (address == null) ? null : address.getHostAddress();
		this.port = port;
		this.addressCache = address;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public InetAddress getAddress() {
		InetAddress cached = addressCache;
		if (cached != null || host == null) {
			return cached;
		}
		try {
			cached = InetAddress.getByName(host);
			addressCache = cached;
			return cached;
		} catch (UnknownHostException e) {
			return null;
		}
	}

	@Override
	public int getPort() {
		return port;
	}

	@Override
	public String toString() {
		return "ClusterMember[id=" + id + ", host=" + host + ", port=" + port + "]";
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (!(o instanceof ClusterMember other)) {
			return false;
		}
		return Objects.equals(id, other.id);
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(id);
	}
}
