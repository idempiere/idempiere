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

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.util.Arrays;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 * One message on the cluster RPC topics, as raw bytes.
 *
 * <p>The header (kind, timestamp, task id, sender, targets, reply flag, error text) is plain data.
 * The callable or the result travels as an opaque payload, encoded with the RPC codec. When a
 * secret is configured, an HMAC-SHA256 over the key prefix and every byte before it closes the
 * frame, and {@link #decode} checks it before reading anything else. The payload is only decoded
 * by the caller, after the frame was accepted.</p>
 *
 * <p>Layout: magic (int), version (byte), kind (byte), signed (boolean), timestamp (long, epoch
 * millis), task id, sender (UTF), then for a request the targets (int count, UTF each) and the
 * reply flag (boolean), for a response the status (byte) and, on error, the error class and
 * message (UTF); then the payload (int length, bytes) and, when signed, the 32-byte HMAC.</p>
 */
public final class RpcFrame {

	public static final byte KIND_REQUEST = 1;
	public static final byte KIND_RESPONSE = 2;

	static final int MAGIC = 0x49445250; // "IDRP"
	static final byte VERSION = 1;
	static final int HMAC_LENGTH = 32;
	static final int MAX_TARGETS = 10_000;
	/** writeUTF takes at most 65,535 bytes; error text is cut well below that. */
	static final int MAX_ERROR_TEXT = 8_000;

	private static final byte STATUS_OK = 0;
	private static final byte STATUS_ERROR = 1;

	private final byte kind;
	private final long timestamp;
	private final String taskId;
	private final String senderUuid;
	private final String[] targetUuids;
	private final boolean replyExpected;
	private final String errorClass;
	private final String errorMessage;
	private final byte[] payload;
	private final boolean signed;

	private RpcFrame(byte kind, long timestamp, String taskId, String senderUuid, String[] targetUuids,
			boolean replyExpected, String errorClass, String errorMessage, byte[] payload, boolean signed) {
		this.kind = kind;
		this.timestamp = timestamp;
		this.taskId = taskId;
		this.senderUuid = senderUuid;
		this.targetUuids = targetUuids;
		this.replyExpected = replyExpected;
		this.errorClass = errorClass;
		this.errorMessage = errorMessage;
		this.payload = payload;
		this.signed = signed;
	}

	/** A request; {@code payload} is the encoded callable. */
	public static RpcFrame request(long timestamp, String taskId, String senderUuid, String[] targetUuids,
			boolean replyExpected, byte[] payload) {
		return new RpcFrame(KIND_REQUEST, timestamp, taskId, senderUuid, targetUuids.clone(), replyExpected,
				null, null, payload, false);
	}

	/** A successful response; {@code payload} is the encoded result. */
	public static RpcFrame result(long timestamp, String taskId, String senderUuid, byte[] payload) {
		return new RpcFrame(KIND_RESPONSE, timestamp, taskId, senderUuid, null, false, null, null, payload, false);
	}

	/** A failed response: only the class name and message of the error travel, never the exception object. */
	public static RpcFrame error(long timestamp, String taskId, String senderUuid, String errorClass,
			String errorMessage) {
		return new RpcFrame(KIND_RESPONSE, timestamp, taskId, senderUuid, null, false,
				cut(errorClass == null ? "" : errorClass), cut(errorMessage == null ? "" : errorMessage),
				new byte[0], false);
	}

	/**
	 * @param secret  HMAC secret, or {@code null} to send the frame unsigned
	 * @param context bound into the HMAC (the key prefix), so a frame is only valid in its own namespace
	 */
	public byte[] encode(String secret, String context) {
		try {
			ByteArrayOutputStream bytes = new ByteArrayOutputStream(payload.length + 256);
			DataOutputStream out = new DataOutputStream(bytes);
			out.writeInt(MAGIC);
			out.writeByte(VERSION);
			out.writeByte(kind);
			out.writeBoolean(secret != null);
			out.writeLong(timestamp);
			out.writeUTF(taskId);
			out.writeUTF(senderUuid);
			if (kind == KIND_REQUEST) {
				out.writeInt(targetUuids.length);
				for (String target : targetUuids) {
					out.writeUTF(target);
				}
				out.writeBoolean(replyExpected);
			} else if (errorClass != null) {
				out.writeByte(STATUS_ERROR);
				out.writeUTF(errorClass);
				out.writeUTF(errorMessage);
			} else {
				out.writeByte(STATUS_OK);
			}
			out.writeInt(payload.length);
			out.write(payload);
			out.flush();
			if (secret != null) {
				byte[] body = bytes.toByteArray();
				out.write(hmac(secret, context, body, body.length));
				out.flush();
			}
			return bytes.toByteArray();
		} catch (IOException e) {
			throw new IllegalStateException("RPC frame encoding failed", e);
		}
	}

	/**
	 * Reads a frame. With a secret, a frame that is unsigned or whose HMAC does not match is refused
	 * before any field is read. Without one, the HMAC of a signed frame is not checked.
	 *
	 * @throws RejectedFrameException when the frame is malformed, unsigned or forged
	 */
	public static RpcFrame decode(byte[] frame, String secret, String context) throws RejectedFrameException {
		if (frame == null || frame.length < 7) {
			throw new RejectedFrameException("frame too short");
		}
		boolean signed = frame[6] != 0;
		int bodyLength = frame.length;
		if (secret != null) {
			if (!signed) {
				throw new RejectedFrameException("unsigned frame, but rpc.hmac.secret is set");
			}
			bodyLength = frame.length - HMAC_LENGTH;
			if (bodyLength < 7) {
				throw new RejectedFrameException("frame too short");
			}
			byte[] expected = hmac(secret, context, frame, bodyLength);
			byte[] provided = Arrays.copyOfRange(frame, bodyLength, frame.length);
			if (!MessageDigest.isEqual(expected, provided)) {
				throw new RejectedFrameException("HMAC mismatch");
			}
		} else if (signed) {
			bodyLength = frame.length - HMAC_LENGTH;
		}
		try {
			DataInputStream in = new DataInputStream(new ByteArrayInputStream(frame, 0, bodyLength));
			if (in.readInt() != MAGIC) {
				throw new RejectedFrameException("not an RPC frame");
			}
			byte version = in.readByte();
			if (version != VERSION) {
				throw new RejectedFrameException("unsupported frame version " + version);
			}
			byte kind = in.readByte();
			in.readBoolean(); // signed flag, read above
			long timestamp = in.readLong();
			String taskId = in.readUTF();
			String senderUuid = in.readUTF();
			String[] targets = null;
			boolean replyExpected = false;
			String errorClass = null;
			String errorMessage = null;
			if (kind == KIND_REQUEST) {
				int count = in.readInt();
				if (count < 0 || count > MAX_TARGETS) {
					throw new RejectedFrameException("bad target count " + count);
				}
				targets = new String[count];
				for (int i = 0; i < count; i++) {
					targets[i] = in.readUTF();
				}
				replyExpected = in.readBoolean();
			} else if (kind == KIND_RESPONSE) {
				byte status = in.readByte();
				if (status == STATUS_ERROR) {
					errorClass = in.readUTF();
					errorMessage = in.readUTF();
				} else if (status != STATUS_OK) {
					throw new RejectedFrameException("bad response status " + status);
				}
			} else {
				throw new RejectedFrameException("bad frame kind " + kind);
			}
			int length = in.readInt();
			if (length < 0 || length != in.available()) {
				throw new RejectedFrameException("bad payload length " + length);
			}
			byte[] payload = new byte[length];
			in.readFully(payload);
			return new RpcFrame(kind, timestamp, taskId, senderUuid, targets, replyExpected, errorClass,
					errorMessage, payload, signed);
		} catch (IOException e) {
			throw new RejectedFrameException("truncated frame");
		}
	}

	private static byte[] hmac(String secret, String context, byte[] data, int length) {
		try {
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
			byte[] ctx = (context == null ? "" : context).getBytes(StandardCharsets.UTF_8);
			mac.update(ctx);
			mac.update((byte) 0);
			mac.update(data, 0, length);
			return mac.doFinal();
		} catch (GeneralSecurityException e) {
			throw new IllegalStateException("HMAC computation failed", e);
		}
	}

	private static String cut(String text) {
		return text.length() <= MAX_ERROR_TEXT ? text : text.substring(0, MAX_ERROR_TEXT);
	}

	public byte getKind() {
		return kind;
	}

	public long getTimestamp() {
		return timestamp;
	}

	public String getTaskId() {
		return taskId;
	}

	public String getSenderUuid() {
		return senderUuid;
	}

	/** Targets of a request; {@code null} for a response. */
	public String[] getTargetUuids() {
		return targetUuids == null ? null : targetUuids.clone();
	}

	public boolean isReplyExpected() {
		return replyExpected;
	}

	public boolean isError() {
		return errorClass != null;
	}

	public String getErrorClass() {
		return errorClass;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public byte[] getPayload() {
		return payload;
	}

	public boolean isSigned() {
		return signed;
	}

	/** A frame that was refused: malformed, unsigned while a secret is set, or with a wrong HMAC. */
	public static final class RejectedFrameException extends Exception {
		private static final long serialVersionUID = 1L;

		public RejectedFrameException(String message) {
			super(message);
		}
	}
}
