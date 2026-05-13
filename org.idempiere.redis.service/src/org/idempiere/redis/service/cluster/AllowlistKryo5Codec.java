/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.             *
*                                                                     *
* This program is distributed in the hope that it will be useful,    *
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

import java.util.Set;

import org.redisson.codec.Kryo5Codec;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.esotericsoftware.kryo.Kryo;

/**
 * Kryo5Codec variant that enforces a class allow-list on the RPC topics.
 *
 * <p>Extends {@link Kryo5Codec} and overrides {@link #createKryo} to:
 * <ol>
 *   <li>Register the RPC envelope types ({@link RpcRequest}, {@link RpcResponse},
 *       {@code String[]}) and a small set of common exception types.</li>
 *   <li>Register each class name from {@code allowedClassNames}.</li>
 *   <li>Call {@code setRegistrationRequired(true)} so Kryo rejects any class
 *       not in the combined set — preventing gadget-chain deserialization attacks
 *       (CVE-2023-42809) even when an attacker can publish to the Redis topic.</li>
 * </ol>
 *
 * <p>All nodes in a cluster <b>must</b> share the same allow-list and the same
 * ordering (entries are registered alphabetically) so that Kryo class IDs are
 * consistent across JVMs. Add every class that can appear as a Callable
 * implementation or as a Callable return / exception type to
 * {@code rpc.callable.allowlist} in {@code redis.properties}.</p>
 */
public class AllowlistKryo5Codec extends Kryo5Codec {

	private static final Logger log = LoggerFactory.getLogger(AllowlistKryo5Codec.class);

	private final Set<String> allowedClassNames;

	public AllowlistKryo5Codec(ClassLoader classLoader, Set<String> allowedClassNames) {
		super(classLoader);
		this.allowedClassNames = allowedClassNames;
	}

	@Override
	protected Kryo createKryo(ClassLoader classLoader) {
		Kryo kryo = super.createKryo(classLoader);

		// Always register RPC envelope types and the common types they need.
		kryo.register(RpcRequest.class);
		kryo.register(RpcResponse.class);
		kryo.register(String[].class);
		kryo.register(Throwable.class);
		kryo.register(Exception.class);
		kryo.register(RuntimeException.class);
		kryo.register(IllegalStateException.class);
		kryo.register(IllegalArgumentException.class);
		kryo.register(java.util.concurrent.TimeoutException.class);
		kryo.register(java.io.IOException.class);

		// Register operator-configured Callable (and result/error) types.
		// Sort for deterministic Kryo ID assignment across nodes.
		allowedClassNames.stream().sorted().forEach(name -> {
			try {
				kryo.register(Class.forName(name, true, classLoader));
			} catch (ClassNotFoundException e) {
				log.warn("rpc.callable.allowlist: class '{}' not found; skipping registration", name);
			}
		});

		kryo.setRegistrationRequired(true);
		return kryo;
	}
}
