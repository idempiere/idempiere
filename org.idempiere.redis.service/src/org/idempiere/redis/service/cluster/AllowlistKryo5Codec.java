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

import java.util.List;
import java.util.Set;
import java.util.logging.Level;

import org.objenesis.strategy.StdInstantiatorStrategy;
import org.redisson.codec.Kryo5Codec;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.esotericsoftware.kryo.Kryo;
import com.esotericsoftware.kryo.KryoException;
import com.esotericsoftware.kryo.Serializer;
import com.esotericsoftware.kryo.io.Input;
import com.esotericsoftware.kryo.io.Output;
import com.esotericsoftware.kryo.serializers.DefaultSerializers;
import com.esotericsoftware.kryo.util.DefaultInstantiatorStrategy;

/**
 * Kryo codec for the payloads of cluster RPC frames (the callable of a request, the result of a
 * response), with an optional class allow-list.
 *
 * <p>Built like Redisson's {@link Kryo5Codec} (same instantiator strategy, no references, UUID,
 * URI and Pattern serializers), with two differences:</p>
 * <ol>
 *   <li>Exceptions are never decoded. Redisson's codec decodes every {@link Throwable} with Java
 *       serialization ({@code ObjectInputStream}); here any {@code Throwable} is refused in both
 *       directions. A failed callable travels as class name and message in the frame header, see
 *       {@link RpcFrame#error}.</li>
 *   <li>With a non-empty {@code allowedClassNames}, {@code setRegistrationRequired(true)} is set
 *       and only these classes, a few JDK value types and {@link Level} can be decoded
 *       (CVE-2023-42809 is the same class of bug). With an empty set any class can be decoded,
 *       as with Redisson's codec.</li>
 * </ol>
 *
 * <p>The allow-list does not replace {@code rpc.hmac.secret}: the frame HMAC, checked before the
 * payload is decoded, is what keeps clients without the secret out. All nodes of a cluster must
 * share the same allow-list: each entry gets a fixed Kryo ID from its position in the sorted list,
 * so a class that is missing on one node leaves a gap and does not shift the IDs of the others.</p>
 */
public class AllowlistKryo5Codec extends Kryo5Codec {

	private static final Logger log = LoggerFactory.getLogger(AllowlistKryo5Codec.class);

	/** Fixed Kryo IDs, well above Kryo's own default registrations (0 to 9). */
	static final int LEVEL_ID = 100;
	static final int VALUE_TYPES_FIRST_ID = 101;
	static final int ALLOWLIST_FIRST_ID = 200;
	private static final List<Class<?>> VALUE_TYPES = List.of(byte[].class, String[].class,
			java.util.ArrayList.class, java.sql.Timestamp.class, java.util.Date.class);

	private final Set<String> allowedClassNames;

	public AllowlistKryo5Codec(ClassLoader classLoader, Set<String> allowedClassNames) {
		super(classLoader);
		this.allowedClassNames = allowedClassNames;
	}

	@Override
	protected Kryo createKryo(ClassLoader classLoader) {
		// Not super.createKryo: it registers Java serialization as the default serializer for
		// Throwable, and Kryo uses the first matching default serializer.
		Kryo kryo = new Kryo();
		if (classLoader != null) {
			kryo.setClassLoader(classLoader);
		}
		kryo.setInstantiatorStrategy(new DefaultInstantiatorStrategy(new StdInstantiatorStrategy()));
		// Kryo 5 requires registration by default; Redisson's codec turns it off, and so does this one
		// unless an allow-list is configured (set at the end).
		kryo.setRegistrationRequired(false);
		kryo.setReferences(false);
		kryo.addDefaultSerializer(Throwable.class, new RefusedThrowableSerializer());
		kryo.addDefaultSerializer(java.util.UUID.class, new DefaultSerializers.UUIDSerializer());
		kryo.addDefaultSerializer(java.net.URI.class, new DefaultSerializers.URISerializer());
		kryo.addDefaultSerializer(java.util.regex.Pattern.class, new DefaultSerializers.PatternSerializer());

		if (!allowedClassNames.isEmpty()) {
			// Value types returned by the core callables (log blocks, cache info lists, start times).
			int id = VALUE_TYPES_FIRST_ID;
			for (Class<?> type : VALUE_TYPES) {
				kryo.register(type, id++);
			}

			// Operator-configured Callable (and result) types, sorted. Each gets a fixed ID from its
			// position, so a class missing on one node leaves a gap instead of shifting later IDs.
			List<String> sorted = allowedClassNames.stream().sorted().toList();
			ClassLoader loader = classLoader != null ? classLoader : getClass().getClassLoader();
			for (int i = 0; i < sorted.size(); i++) {
				String name = sorted.get(i);
				try {
					Class<?> type = Class.forName(name, false, loader);
					if (kryo.getClassResolver().getRegistration(type) != null) {
						continue; // already registered above (a value type or a Kryo default)
					}
					kryo.register(type, ALLOWLIST_FIRST_ID + i);
				} catch (ClassNotFoundException e) {
					log.warn("rpc.callable.allowlist: class '{}' not found; skipping registration", name);
				}
			}
		}

		// java.util.logging.Level travels inside SystemInfo (its logLevel field). Level has no no-arg
		// constructor and is resolved by name, so it needs its own serializer.
		kryo.register(Level.class, new LevelSerializer(), LEVEL_ID);

		if (!allowedClassNames.isEmpty()) {
			kryo.setRegistrationRequired(true);
		}
		return kryo;
	}

	/** Refuses to write or read any {@link Throwable}. */
	static final class RefusedThrowableSerializer extends Serializer<Throwable> {

		@Override
		public void write(Kryo kryo, Output output, Throwable object) {
			throw new KryoException("Exceptions are not sent over cluster RPC: " + object.getClass().getName());
		}

		@Override
		public Throwable read(Kryo kryo, Input input, Class<? extends Throwable> type) {
			throw new KryoException("Exceptions are not accepted over cluster RPC: " + type.getName());
		}
	}

	/**
	 * Writes a {@link Level} as its name and value and reads it back with {@link Level#parse(String)},
	 * by name, or by value when the receiving node does not know the name.
	 */
	static final class LevelSerializer extends Serializer<Level> {

		LevelSerializer() {
			setImmutable(true);
		}

		@Override
		public void write(Kryo kryo, Output output, Level level) {
			output.writeString(level.getName());
			output.writeInt(level.intValue());
		}

		@Override
		public Level read(Kryo kryo, Input input, Class<? extends Level> type) {
			String name = input.readString();
			int value = input.readInt();
			if (name == null) {
				return Level.parse(Integer.toString(value));
			}
			try {
				return Level.parse(name);
			} catch (IllegalArgumentException e) {
				return Level.parse(Integer.toString(value));
			}
		}
	}
}
