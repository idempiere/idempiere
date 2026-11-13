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

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Arrays;

import org.idempiere.redis.service.cluster.RpcFrame.RejectedFrameException;
import org.junit.jupiter.api.Test;

/** Signed RPC frames: round trip, and every kind of tampering refused before the payload is read. */
public class RpcFrameTest {

	private static final String SECRET = "a-test-secret-of-at-least-32-characters";
	private static final String CONTEXT = "idempiere:";
	private static final byte[] PAYLOAD = { 1, 2, 3, 4, 5 };

	private static RpcFrame request() {
		return RpcFrame.request(1_000L, "task-1", "node-a", new String[] { "node-b", "node-c" }, true, PAYLOAD);
	}

	@Test
	public void testSignedRequestRoundTrip() throws Exception {
		RpcFrame frame = RpcFrame.decode(request().encode(SECRET, CONTEXT), SECRET, CONTEXT);

		assertEquals(RpcFrame.KIND_REQUEST, frame.getKind());
		assertEquals(1_000L, frame.getTimestamp());
		assertEquals("task-1", frame.getTaskId());
		assertEquals("node-a", frame.getSenderUuid());
		assertArrayEquals(new String[] { "node-b", "node-c" }, frame.getTargetUuids());
		assertTrue(frame.isReplyExpected());
		assertTrue(frame.isSigned());
		assertArrayEquals(PAYLOAD, frame.getPayload());
	}

	@Test
	public void testResultAndErrorRoundTrip() throws Exception {
		RpcFrame result = RpcFrame.decode(RpcFrame.result(2L, "t", "node-b", PAYLOAD).encode(SECRET, CONTEXT),
				SECRET, CONTEXT);
		assertEquals(RpcFrame.KIND_RESPONSE, result.getKind());
		assertFalse(result.isError());
		assertNull(result.getTargetUuids());
		assertArrayEquals(PAYLOAD, result.getPayload());

		RpcFrame error = RpcFrame.decode(
				RpcFrame.error(2L, "t", "node-b", "java.lang.IllegalStateException", "boom").encode(SECRET, CONTEXT),
				SECRET, CONTEXT);
		assertTrue(error.isError());
		assertEquals("java.lang.IllegalStateException", error.getErrorClass());
		assertEquals("boom", error.getErrorMessage());
		assertEquals(0, error.getPayload().length);
	}

	@Test
	public void testUnsignedRoundTripWithoutSecret() throws Exception {
		RpcFrame frame = RpcFrame.decode(request().encode(null, CONTEXT), null, CONTEXT);
		assertFalse(frame.isSigned());
		assertArrayEquals(PAYLOAD, frame.getPayload());
	}

	@Test
	public void testSignedFrameIsReadByNodeWithoutSecret() throws Exception {
		RpcFrame frame = RpcFrame.decode(request().encode(SECRET, CONTEXT), null, CONTEXT);
		assertArrayEquals(PAYLOAD, frame.getPayload());
	}

	@Test
	public void testUnsignedFrameRefusedWhenSecretSet() {
		byte[] unsigned = request().encode(null, CONTEXT);
		assertThrows(RejectedFrameException.class, () -> RpcFrame.decode(unsigned, SECRET, CONTEXT));
	}

	@Test
	public void testWrongSecretRefused() {
		byte[] bytes = request().encode("another-secret-another-secret-12345", CONTEXT);
		assertThrows(RejectedFrameException.class, () -> RpcFrame.decode(bytes, SECRET, CONTEXT));
	}

	@Test
	public void testOtherKeyPrefixRefused() {
		byte[] bytes = request().encode(SECRET, "other-cluster:");
		assertThrows(RejectedFrameException.class, () -> RpcFrame.decode(bytes, SECRET, CONTEXT));
	}

	@Test
	public void testEveryChangedByteRefused() {
		byte[] bytes = request().encode(SECRET, CONTEXT);
		for (int i = 0; i < bytes.length; i++) {
			byte[] tampered = bytes.clone();
			tampered[i] ^= 0x01;
			int at = i;
			assertThrows(RejectedFrameException.class, () -> RpcFrame.decode(tampered, SECRET, CONTEXT),
					"changed byte " + at);
		}
	}

	@Test
	public void testTruncatedAndGarbageRefused() {
		byte[] bytes = request().encode(null, CONTEXT);
		for (int length = 0; length < bytes.length; length++) {
			byte[] cut = Arrays.copyOf(bytes, length);
			assertThrows(RejectedFrameException.class, () -> RpcFrame.decode(cut, null, CONTEXT),
					"length " + length);
		}
		assertThrows(RejectedFrameException.class, () -> RpcFrame.decode(new byte[64], null, CONTEXT));
		assertThrows(RejectedFrameException.class, () -> RpcFrame.decode(null, SECRET, CONTEXT));
	}

	@Test
	public void testLongErrorMessageIsCut() throws Exception {
		String longMessage = "x".repeat(RpcFrame.MAX_ERROR_TEXT * 3);
		RpcFrame error = RpcFrame.decode(RpcFrame.error(1L, "t", "n", "E", longMessage).encode(null, CONTEXT),
				null, CONTEXT);
		assertEquals(RpcFrame.MAX_ERROR_TEXT, error.getErrorMessage().length());
	}
}
