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
package org.idempiere.redis.service.cluster;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;

import java.util.Set;
import java.util.logging.Level;

import org.junit.jupiter.api.Test;
import org.redisson.codec.Kryo5Codec;

import com.esotericsoftware.kryo.Kryo;
import com.esotericsoftware.kryo.KryoException;

import io.netty.buffer.ByteBuf;

/**
 * {@link AllowlistKryo5Codec} must carry {@link Level} (SystemInfo.logLevel travels in cluster RPC
 * replies) without changing the IDs of the classes registered before it.
 */
public class AllowlistKryo5CodecTest {

	private final AllowlistKryo5Codec codec =
			new AllowlistKryo5Codec(AllowlistKryo5CodecTest.class.getClassLoader(), Set.of("java.util.ArrayList"));

	private Object roundTrip(Object value) throws Exception {
		ByteBuf buf = codec.getValueEncoder().encode(value);
		try {
			return codec.getValueDecoder().decode(buf, null);
		} finally {
			buf.release();
		}
	}

	@Test
	public void testStandardLevelsRoundTripToTheSameInstance() throws Exception {
		for (Level level : new Level[] { Level.SEVERE, Level.WARNING, Level.INFO, Level.CONFIG, Level.FINE,
				Level.FINER, Level.FINEST, Level.ALL, Level.OFF }) {
			assertSame(level, roundTrip(level), level.getName());
		}
	}

	@Test
	public void testFixedIds() {
		Kryo kryo = codec.createKryo(AllowlistKryo5CodecTest.class.getClassLoader());

		assertEquals(AllowlistKryo5Codec.LEVEL_ID, kryo.getRegistration(Level.class).getId());
		assertEquals(AllowlistKryo5Codec.VALUE_TYPES_FIRST_ID + 2, kryo.getRegistration(java.util.ArrayList.class).getId(),
				"an allow-list entry that is already a value type keeps the value-type ID");
	}

	/** Hides one class, the way a node without a plugin cannot load it. */
	private static ClassLoader hiding(String hidden) {
		return new ClassLoader(AllowlistKryo5CodecTest.class.getClassLoader()) {
			@Override
			protected Class<?> loadClass(String name, boolean resolve) throws ClassNotFoundException {
				if (name.equals(hidden)) {
					throw new ClassNotFoundException(name);
				}
				return super.loadClass(name, resolve);
			}
		};
	}

	@Test
	public void testMissingClassOnOneNodeDoesNotShiftTheOthers() throws Exception {
		// Same allow-list on both nodes; NotListed sorts before WithLevel and is missing on node B.
		Set<String> list = Set.of(NotListed.class.getName(), WithLevel.class.getName());
		AllowlistKryo5Codec nodeA = new AllowlistKryo5Codec(AllowlistKryo5CodecTest.class.getClassLoader(), list);
		AllowlistKryo5Codec nodeB = new AllowlistKryo5Codec(hiding(NotListed.class.getName()), list);
		assertEquals(AllowlistKryo5Codec.ALLOWLIST_FIRST_ID + 1,
				nodeB.createKryo(hiding(NotListed.class.getName())).getRegistration(WithLevel.class).getId(),
				"a gap, not a shifted ID");

		WithLevel value = new WithLevel();
		value.level = Level.FINE;
		value.name = "from-a";
		ByteBuf buf = nodeA.getValueEncoder().encode(value);
		try {
			WithLevel copy = (WithLevel) nodeB.getValueDecoder().decode(buf, null);
			assertEquals("from-a", copy.name);
			assertSame(Level.FINE, copy.level);
		} finally {
			buf.release();
		}
	}

	/** An allow-listed class that carries an exception. */
	public static class WithError {
		Throwable error;
	}

	@Test
	public void testExceptionsAreNotEncoded() {
		AllowlistKryo5Codec open = new AllowlistKryo5Codec(null, Set.of());
		assertThrows(Exception.class, () -> open.getValueEncoder().encode(new IllegalStateException("x")));
		assertThrows(Exception.class, () -> codec.getValueEncoder().encode(new IOException("x")));
	}

	@Test
	public void testExceptionsAreNotDecodedEvenWithoutAllowList() throws Exception {
		// Redisson's Kryo5Codec writes any Throwable with Java serialization; reading such bytes would
		// run ObjectInputStream. Both codecs here must refuse them.
		ByteBuf buf = new Kryo5Codec().getValueEncoder().encode(new IOException("from a plain codec"));
		byte[] bytes = io.netty.buffer.ByteBufUtil.getBytes(buf);
		buf.release();

		for (AllowlistKryo5Codec c : new AllowlistKryo5Codec[] { new AllowlistKryo5Codec(null, Set.of()), codec }) {
			ByteBuf in = io.netty.buffer.Unpooled.wrappedBuffer(bytes);
			try {
				assertThrows(Exception.class, () -> c.getValueDecoder().decode(in, null));
			} finally {
				in.release();
			}
		}
	}

	@Test
	public void testExceptionFieldInsideAllowListedClassIsRefused() {
		AllowlistKryo5Codec listed = new AllowlistKryo5Codec(AllowlistKryo5CodecTest.class.getClassLoader(),
				Set.of(WithError.class.getName(), IOException.class.getName()));
		Kryo kryo = listed.createKryo(AllowlistKryo5CodecTest.class.getClassLoader());
		WithError value = new WithError();
		value.error = new IOException("x");

		com.esotericsoftware.kryo.io.Output out = new com.esotericsoftware.kryo.io.Output(256, -1);
		assertThrows(KryoException.class, () -> kryo.writeClassAndObject(out, value),
				"even an allow-listed exception class is not serialized");
	}

	@Test
	public void testClassOutsideTheAllowListIsRefused() {
		Kryo kryo = codec.createKryo(AllowlistKryo5CodecTest.class.getClassLoader());
		com.esotericsoftware.kryo.io.Output out = new com.esotericsoftware.kryo.io.Output(256, -1);
		assertThrows(IllegalArgumentException.class, () -> kryo.writeClassAndObject(out, new NotListed()));
	}

	/** An allow-listed class with a Level field, the way SystemInfo carries logLevel. */
	public static class WithLevel {
		Level level;
		String name;
	}

	@Test
	public void testLevelInsideAnAllowListedClass() throws Exception {
		// SystemInfo case: the allow-listed class is registered before Level, and its field must
		// still use the Level serializer, not reflection on java.util.logging.Level's private fields.
		AllowlistKryo5Codec codec = new AllowlistKryo5Codec(AllowlistKryo5CodecTest.class.getClassLoader(),
				Set.of(WithLevel.class.getName()));
		WithLevel value = new WithLevel();
		value.level = Level.WARNING;
		value.name = "node-a";

		Kryo kryo = codec.createKryo(AllowlistKryo5CodecTest.class.getClassLoader());
		com.esotericsoftware.kryo.io.Output out = new com.esotericsoftware.kryo.io.Output(256, -1);
		kryo.writeClassAndObject(out, value);
		WithLevel copy = (WithLevel) kryo.readClassAndObject(new com.esotericsoftware.kryo.io.Input(out.toBytes()));

		assertSame(Level.WARNING, copy.level);
		assertEquals("node-a", copy.name);
	}

	/** A class nobody allow-listed, the way an unrestricted cluster sends SystemInfo. */
	public static class NotListed {
		Level level;
	}

	@Test
	public void testEmptyAllowListIsUnrestrictedAndStillSendsLevel() {
		// No rpc.callable.allowlist (staging today): any class may travel, as with Redisson's default
		// Kryo5Codec, but Level must use its serializer instead of reflection on java.logging.
		AllowlistKryo5Codec open = new AllowlistKryo5Codec(null, Set.of());
		Kryo kryo = open.createKryo(null);
		NotListed value = new NotListed();
		value.level = Level.INFO;

		com.esotericsoftware.kryo.io.Output out = new com.esotericsoftware.kryo.io.Output(256, -1);
		kryo.writeClassAndObject(out, value);
		NotListed copy = (NotListed) kryo.readClassAndObject(new com.esotericsoftware.kryo.io.Input(out.toBytes()));

		assertSame(Level.INFO, copy.level);
	}

	@Test
	public void testUnknownLevelNameFallsBackToValue() {
		Level level = new AllowlistKryo5Codec.LevelSerializer().read(null, input("NO_SUCH_LEVEL", 900), Level.class);

		assertEquals(Level.WARNING.intValue(), level.intValue());
	}

	private static com.esotericsoftware.kryo.io.Input input(String name, int value) {
		com.esotericsoftware.kryo.io.Output out = new com.esotericsoftware.kryo.io.Output(64);
		out.writeString(name);
		out.writeInt(value);
		return new com.esotericsoftware.kryo.io.Input(out.toBytes());
	}
}
