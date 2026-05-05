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
package org.idempiere.redis.service;

import java.io.Serializable;
import java.net.InetAddress;

import org.idempiere.distributed.IClusterMember;

/**
 * Value object identifying one cluster member. Stored in Redis under a
 * heartbeat key so other nodes can discover live members.
 *
 * <p>Mutable fields and a no-arg constructor are kept on purpose so that
 * codecs which require POJO-style hydration (Kryo, Fury, Jackson) can
 * deserialize without reflection-into-final-fields contortions.</p>
 */
public class ClusterMember implements IClusterMember, Serializable {

	private static final long serialVersionUID = 1L;

	private String id;
	private InetAddress address;
	private int port;

	/** Required by serialization codecs. Do not call directly. */
	public ClusterMember() {
	}

	public ClusterMember(String id, InetAddress address, int port) {
		this.id = id;
		this.address = address;
		this.port = port;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public InetAddress getAddress() {
		return address;
	}

	@Override
	public int getPort() {
		return port;
	}

	@Override
	public String toString() {
		return "ClusterMember[id=" + id + ", address=" + address + ", port=" + port + "]";
	}
}
