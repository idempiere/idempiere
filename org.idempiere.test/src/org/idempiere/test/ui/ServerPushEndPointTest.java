/**********************************************************************
 * This file is part of iDempiere ERP Open Source                     *
 * http://www.idempiere.org                                           *
 *                                                                    *
 * Copyright (C) Contributors                                         *
 *                                                                    *
 * This program is free software; you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2     *
 * of the License, or (at your option) any later version.              *
 **********************************************************************/
package org.idempiere.test.ui;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;

import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;

import org.idempiere.ui.zk.websocket.ServerPushEndPoint;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.zkoss.json.JSONObject;
import org.zkoss.json.parser.JSONParser;

/**
 * Test for the WebSocket server push AU request handling.
 * Covers IDEMPIERE-7095: reject WebSocket messages without AU content instead of
 * failing inside the /zkau client with a NullPointerException.
 */
public class ServerPushEndPointTest {

	@Test
	void onMessageWithoutContentIsRejectedWithError() throws Exception {
		ServerPushEndPoint endpoint = new ServerPushEndPoint();
		RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
		Session session = mock(Session.class);
		when(session.getBasicRemote()).thenReturn(basic);
		setField(endpoint, "session", session);
		setField(endpoint, "dtid", "desktop1");

		assertDoesNotThrow(() -> endpoint.onMessage(session,
				"zkau;{\"sid\":\"1\",\"dt\":\"desktop1\",\"uri\":\"/zkau?dtid=desktop1\"}"));

		ArgumentCaptor<String> response = ArgumentCaptor.forClass(String.class);
		verify(basic).sendText(response.capture());

		JSONObject jsonResponse = (JSONObject) new JSONParser().parse(response.getValue());
		assertEquals(500, jsonResponse.get("status"));
		assertEquals("Error: Missing AU content", jsonResponse.get("statusText"));
	}

	private static void setField(Object target, String name, Object value) throws Exception {
		Field field = ServerPushEndPoint.class.getDeclaredField(name);
		field.setAccessible(true);
		field.set(target, value);
	}
}