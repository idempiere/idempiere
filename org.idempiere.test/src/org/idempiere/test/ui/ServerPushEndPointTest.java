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
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import javax.servlet.ServletContext;
import javax.servlet.SessionCookieConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.HandshakeResponse;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

import org.idempiere.ui.zk.websocket.EndpointConfigurator;
import org.idempiere.ui.zk.websocket.ServerPushEndPoint;
import org.idempiere.ui.zk.websocket.WebSocketServerPush;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.zkoss.json.JSONObject;
import org.zkoss.json.parser.JSONParser;

/**
 * Tests for the WebSocket server push endpoint, configurator, and lifecycle.
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
		assertEquals("1", jsonResponse.get("sid"));
		@SuppressWarnings("unchecked")
		Map<String, String> errHeaders = (Map<String, String>) jsonResponse.get("headers");
		assertNotNull(errHeaders);
		assertEquals("1", errHeaders.get("ZK-SID"));
	}

	@Test
	void onMessagePingSetsMessageIndicatorAndRepliesPong() throws Exception {
		ServerPushEndPoint endpoint = new ServerPushEndPoint();
		RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
		Session session = mock(Session.class);
		when(session.getBasicRemote()).thenReturn(basic);
		setField(endpoint, "session", session);
		setField(endpoint, "dtid", "desktop-ping");

		assertFalse(endpoint.getAndResetMessageIndicator());
		endpoint.onMessage(session, "__ping__");

		verify(basic).sendText("__pong__");
		assertTrue(endpoint.getAndResetMessageIndicator(), "__ping__ must refresh the DesktopWatchDog activity indicator");
		assertFalse(endpoint.getAndResetMessageIndicator(), "getAndResetMessageIndicator must reset to false");
	}

	@Test
	void onMessageRejectsInvalidAndSsrfUris() throws Exception {
		String[] badUris = new String[] {
				"@attacker.example/zkau",
				"//attacker.example/webui/zkau",
				"http://attacker.example/webui/zkau",
				"/idempiereMonitor",
				"/webui/zkau/../../idempiereMonitor",
				"/webui/zkau/%2e%2e/idempiereMonitor",
				"/webui/zkau/..;foo=bar/..;foo=bar/idempiereMonitor",
				"/webui/zkau;foo=bar/../../idempiereMonitor",
				"/webui/zkau/%3b/idempiereMonitor",
				"/webui/zkau-evil",
				"/webui/zkau\r\nX-Injected: 1"
		};

		for (String badUri : badUris) {
			ServerPushEndPoint endpoint = new ServerPushEndPoint();
			RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
			Session session = mock(Session.class);
			when(session.getBasicRemote()).thenReturn(basic);
			setField(endpoint, "session", session);
			setField(endpoint, "dtid", "desktop1");
			setField(endpoint, "internalBaseUri", URI.create("http://127.0.0.1:8080"));
			setField(endpoint, "contextPath", "/webui");

			JSONObject req = new JSONObject();
			req.put("sid", "7");
			req.put("dt", "desktop1");
			req.put("uri", badUri);
			req.put("content", "dtid=desktop1&cmd_0=dummy");

			endpoint.onMessage(session, "zkau;" + req.toString());

			ArgumentCaptor<String> response = ArgumentCaptor.forClass(String.class);
			verify(basic).sendText(response.capture());
			JSONObject jsonResponse = (JSONObject) new JSONParser().parse(response.getValue());
			assertEquals(400, jsonResponse.get("status"), "Expected HTTP 400 rejection for URI: " + badUri);
			assertEquals("Error: Invalid AU URI", jsonResponse.get("statusText"), "Rejected URI: " + badUri);
			assertEquals("7", jsonResponse.get("sid"));
		}
	}

	@Test
	void resolveAuUriAcceptsMatrixSessionIdAndSubpaths() throws Exception {
		ServerPushEndPoint endpoint = new ServerPushEndPoint();
		setField(endpoint, "internalBaseUri", URI.create("https://127.0.0.1:8443"));
		setField(endpoint, "contextPath", "/webui");

		java.lang.reflect.Method resolveAuUri = ServerPushEndPoint.class.getDeclaredMethod("resolveAuUri", String.class);
		resolveAuUri.setAccessible(true);

		String[] validUris = new String[] {
				"/webui/zkau",
				"/webui/zkau;jsessionid=node0abc123.node0",
				"/webui/zkau;jsessionid=node0abc123.node0?dtid=z_123",
				"/webui/zkau/_/index.zul/tag;jsessionid=node0abc123.node0"
		};
		for (String validUri : validUris) {
			URI resolved = (URI) resolveAuUri.invoke(endpoint, validUri);
			assertNotNull(resolved, "Expected valid AU URI to be accepted: " + validUri);
			assertEquals("https", resolved.getScheme());
			assertEquals("127.0.0.1", resolved.getHost());
			assertEquals(8443, resolved.getPort());
		}
	}

	@Test
	void onMessageHandlesMalformedJsonSafely() throws Exception {
		ServerPushEndPoint endpoint = new ServerPushEndPoint();
		RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
		Session session = mock(Session.class);
		when(session.getBasicRemote()).thenReturn(basic);
		setField(endpoint, "session", session);
		setField(endpoint, "dtid", "desktop1");

		assertDoesNotThrow(() -> endpoint.onMessage(session, "zkau;{not-valid-json"));

		ArgumentCaptor<String> response = ArgumentCaptor.forClass(String.class);
		verify(basic).sendText(response.capture());
		JSONObject jsonResponse = (JSONObject) new JSONParser().parse(response.getValue());
		assertEquals(400, jsonResponse.get("status"));
	}

	@Test
	void onOpenRejectsMissingSessionWrongOwnerAndInvalidOrigin() throws Exception {
		String dtid = "dt-auth-test";
		ServerPushEndPoint stub = new ServerPushEndPoint();
		WebSocketServerPush.registerEndPoint(dtid, stub);
		try {
			// 1. Missing HttpSession
			Session sessNoHttp = mock(Session.class);
			EndpointConfig cfgNoHttp = mock(EndpointConfig.class);
			when(cfgNoHttp.getUserProperties()).thenReturn(new HashMap<>());
			new ServerPushEndPoint().onOpen(sessNoHttp, cfgNoHttp, dtid);
			ArgumentCaptor<CloseReason> reason1 = ArgumentCaptor.forClass(CloseReason.class);
			verify(sessNoHttp).close(reason1.capture());
			assertEquals(CloseReason.CloseCodes.VIOLATED_POLICY, reason1.getValue().getCloseCode());

			// 2. HttpSession that does not own dtid
			Session sessWrongOwner = mock(Session.class);
			HttpSession foreignSession = mock(HttpSession.class);
			Map<String, Object> propsWrongOwner = new HashMap<>();
			propsWrongOwner.put(HttpSession.class.getName(), foreignSession);
			propsWrongOwner.put("ws-origin-valid", Boolean.TRUE);
			EndpointConfig cfgWrongOwner = mock(EndpointConfig.class);
			when(cfgWrongOwner.getUserProperties()).thenReturn(propsWrongOwner);
			new ServerPushEndPoint().onOpen(sessWrongOwner, cfgWrongOwner, dtid);
			ArgumentCaptor<CloseReason> reason2 = ArgumentCaptor.forClass(CloseReason.class);
			verify(sessWrongOwner).close(reason2.capture());
			assertEquals(CloseReason.CloseCodes.VIOLATED_POLICY, reason2.getValue().getCloseCode());

			// 3. Owning HttpSession but cross-site Origin rejected by configurator
			Session sessBadOrigin = mock(Session.class);
			HttpSession owningSession = mock(HttpSession.class);
			when(owningSession.getAttribute("ws-desktop-owner." + dtid)).thenReturn(Boolean.TRUE);
			Map<String, Object> propsBadOrigin = new HashMap<>();
			propsBadOrigin.put(HttpSession.class.getName(), owningSession);
			propsBadOrigin.put("ws-origin-valid", Boolean.FALSE);
			EndpointConfig cfgBadOrigin = mock(EndpointConfig.class);
			when(cfgBadOrigin.getUserProperties()).thenReturn(propsBadOrigin);
			new ServerPushEndPoint().onOpen(sessBadOrigin, cfgBadOrigin, dtid);
			ArgumentCaptor<CloseReason> reason3 = ArgumentCaptor.forClass(CloseReason.class);
			verify(sessBadOrigin).close(reason3.capture());
			assertEquals(CloseReason.CloseCodes.VIOLATED_POLICY, reason3.getValue().getCloseCode());

			// 4. Owning HttpSession but missing ws-origin-valid property must fail closed
			Session sessMissingOriginFlag = mock(Session.class);
			Map<String, Object> propsMissingOrigin = new HashMap<>();
			propsMissingOrigin.put(HttpSession.class.getName(), owningSession);
			EndpointConfig cfgMissingOrigin = mock(EndpointConfig.class);
			when(cfgMissingOrigin.getUserProperties()).thenReturn(propsMissingOrigin);
			new ServerPushEndPoint().onOpen(sessMissingOriginFlag, cfgMissingOrigin, dtid);
			ArgumentCaptor<CloseReason> reason4 = ArgumentCaptor.forClass(CloseReason.class);
			verify(sessMissingOriginFlag).close(reason4.capture());
			assertEquals(CloseReason.CloseCodes.VIOLATED_POLICY, reason4.getValue().getCloseCode());
		} finally {
			WebSocketServerPush.unregisterEndPoint(dtid);
		}
	}

	@Test
	void configuratorValidatesOriginAndPreservesClientIpAcrossHandshakes() {
		EndpointConfigurator configurator = new EndpointConfigurator();
		HttpSession httpSession = mock(HttpSession.class);
		ServletContext servletContext = mock(ServletContext.class);
		when(httpSession.getServletContext()).thenReturn(servletContext);
		when(httpSession.getAttribute("ws-client-ip")).thenReturn("203.0.113.42");

		// Valid same-origin handshake
		ServerEndpointConfig secValid = mock(ServerEndpointConfig.class);
		Map<String, Object> validProps = new HashMap<>();
		when(secValid.getUserProperties()).thenReturn(validProps);
		HandshakeRequest validReq = mock(HandshakeRequest.class);
		when(validReq.getHttpSession()).thenReturn(httpSession);
		when(validReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com:8443/webui/serverpush/dt1"));
		when(validReq.getHeaders()).thenReturn(Map.of(
				"Origin", List.of("https://erp.example.com:8443"),
				"Host", List.of("erp.example.com:8443")));

		configurator.modifyHandshake(secValid, validReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.TRUE, validProps.get("ws-origin-valid"));
		assertEquals("203.0.113.42", validProps.get("ws-client-ip"));
		verify(httpSession, never()).removeAttribute("ws-client-ip");

		// Valid direct HTTPS default-port handshake (wss:// scheme)
		ServerEndpointConfig secDirectHttps = mock(ServerEndpointConfig.class);
		Map<String, Object> directHttpsProps = new HashMap<>();
		when(secDirectHttps.getUserProperties()).thenReturn(directHttpsProps);
		HandshakeRequest directHttpsReq = mock(HandshakeRequest.class);
		when(directHttpsReq.getHttpSession()).thenReturn(httpSession);
		when(directHttpsReq.getRequestURI()).thenReturn(URI.create("wss://erp.example.com/webui/serverpush/dt1"));
		when(directHttpsReq.getHeaders()).thenReturn(Map.of(
				"Origin", List.of("https://erp.example.com"),
				"Host", List.of("erp.example.com")));
		configurator.modifyHandshake(secDirectHttps, directHttpsReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.TRUE, directHttpsProps.get("ws-origin-valid"));

		// Valid trusted HTTPS reverse-proxy handshake (requestURI already resolved by Jetty ForwardedRequestCustomizer)
		ServerEndpointConfig secProxy = mock(ServerEndpointConfig.class);
		Map<String, Object> proxyProps = new HashMap<>();
		when(secProxy.getUserProperties()).thenReturn(proxyProps);
		HandshakeRequest proxyReq = mock(HandshakeRequest.class);
		when(proxyReq.getHttpSession()).thenReturn(httpSession);
		when(proxyReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com/webui/serverpush/dt1"));
		when(proxyReq.getHeaders()).thenReturn(Map.of(
				"origin", List.of("https://erp.example.com"),
				"host", List.of("127.0.0.1:8080"),
				"x-forwarded-host", List.of("erp.example.com"),
				"x-forwarded-proto", List.of("https")));
		configurator.modifyHandshake(secProxy, proxyReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.TRUE, proxyProps.get("ws-origin-valid"));

		// Spoofed X-Forwarded-Host without trusted proxy URI rewrite must be rejected
		ServerEndpointConfig secSpoofedProxy = mock(ServerEndpointConfig.class);
		Map<String, Object> spoofedProxyProps = new HashMap<>();
		when(secSpoofedProxy.getUserProperties()).thenReturn(spoofedProxyProps);
		HandshakeRequest spoofedProxyReq = mock(HandshakeRequest.class);
		when(spoofedProxyReq.getHttpSession()).thenReturn(httpSession);
		when(spoofedProxyReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com/webui/serverpush/dt1"));
		when(spoofedProxyReq.getHeaders()).thenReturn(Map.of(
				"origin", List.of("https://evil.example.net"),
				"host", List.of("erp.example.com"),
				"x-forwarded-host", List.of("evil.example.net")));
		configurator.modifyHandshake(secSpoofedProxy, spoofedProxyReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.FALSE, spoofedProxyProps.get("ws-origin-valid"));

		// Reverse-proxy handshake with cross-port Origin must be rejected even when X-Forwarded-Host omits port
		ServerEndpointConfig secProxyCrossPort = mock(ServerEndpointConfig.class);
		Map<String, Object> proxyCrossPortProps = new HashMap<>();
		when(secProxyCrossPort.getUserProperties()).thenReturn(proxyCrossPortProps);
		HandshakeRequest proxyCrossPortReq = mock(HandshakeRequest.class);
		when(proxyCrossPortReq.getHttpSession()).thenReturn(httpSession);
		when(proxyCrossPortReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com/webui/serverpush/dt1"));
		when(proxyCrossPortReq.getHeaders()).thenReturn(Map.of(
				"origin", List.of("https://erp.example.com:8443"),
				"host", List.of("127.0.0.1:8080"),
				"x-forwarded-host", List.of("erp.example.com"),
				"x-forwarded-proto", List.of("https")));
		configurator.modifyHandshake(secProxyCrossPort, proxyCrossPortReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.FALSE, proxyCrossPortProps.get("ws-origin-valid"));

		// HTTP Origin against HTTPS default-port endpoint on the same host must be rejected
		ServerEndpointConfig secSchemeMismatchDefaultPort = mock(ServerEndpointConfig.class);
		Map<String, Object> schemeMismatchDefaultProps = new HashMap<>();
		when(secSchemeMismatchDefaultPort.getUserProperties()).thenReturn(schemeMismatchDefaultProps);
		HandshakeRequest schemeMismatchDefaultReq = mock(HandshakeRequest.class);
		when(schemeMismatchDefaultReq.getHttpSession()).thenReturn(httpSession);
		when(schemeMismatchDefaultReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com/webui/serverpush/dt1"));
		when(schemeMismatchDefaultReq.getHeaders()).thenReturn(Map.of(
				"Origin", List.of("http://erp.example.com"),
				"Host", List.of("erp.example.com")));
		configurator.modifyHandshake(secSchemeMismatchDefaultPort, schemeMismatchDefaultReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.FALSE, schemeMismatchDefaultProps.get("ws-origin-valid"));

		// HTTP Origin against HTTPS explicit-port endpoint on the same host and port must be rejected
		ServerEndpointConfig secSchemeMismatchExplicitPort = mock(ServerEndpointConfig.class);
		Map<String, Object> schemeMismatchExplicitProps = new HashMap<>();
		when(secSchemeMismatchExplicitPort.getUserProperties()).thenReturn(schemeMismatchExplicitProps);
		HandshakeRequest schemeMismatchExplicitReq = mock(HandshakeRequest.class);
		when(schemeMismatchExplicitReq.getHttpSession()).thenReturn(httpSession);
		when(schemeMismatchExplicitReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com:8443/webui/serverpush/dt1"));
		when(schemeMismatchExplicitReq.getHeaders()).thenReturn(Map.of(
				"Origin", List.of("http://erp.example.com:8443"),
				"Host", List.of("erp.example.com:8443")));
		configurator.modifyHandshake(secSchemeMismatchExplicitPort, schemeMismatchExplicitReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.FALSE, schemeMismatchExplicitProps.get("ws-origin-valid"));

		// Cross-site Origin handshake must be marked invalid
		ServerEndpointConfig secEvil = mock(ServerEndpointConfig.class);
		Map<String, Object> evilProps = new HashMap<>();
		when(secEvil.getUserProperties()).thenReturn(evilProps);
		HandshakeRequest evilReq = mock(HandshakeRequest.class);
		when(evilReq.getHttpSession()).thenReturn(httpSession);
		when(evilReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com/webui/serverpush/dt1"));
		when(evilReq.getHeaders()).thenReturn(Map.of(
				"Origin", List.of("https://evil.example.net"),
				"Host", List.of("erp.example.com")));
		configurator.modifyHandshake(secEvil, evilReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.FALSE, evilProps.get("ws-origin-valid"));

		// Origin: null must be marked invalid
		ServerEndpointConfig secNullOrigin = mock(ServerEndpointConfig.class);
		Map<String, Object> nullProps = new HashMap<>();
		when(secNullOrigin.getUserProperties()).thenReturn(nullProps);
		HandshakeRequest nullReq = mock(HandshakeRequest.class);
		when(nullReq.getHttpSession()).thenReturn(httpSession);
		when(nullReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com/webui/serverpush/dt1"));
		when(nullReq.getHeaders()).thenReturn(Map.of(
				"Origin", List.of("null"),
				"Host", List.of("erp.example.com")));
		configurator.modifyHandshake(secNullOrigin, nullReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.FALSE, nullProps.get("ws-origin-valid"));

		// Cross-port same-host Origin against default-port Host must be marked invalid
		ServerEndpointConfig secCrossPort = mock(ServerEndpointConfig.class);
		Map<String, Object> crossPortProps = new HashMap<>();
		when(secCrossPort.getUserProperties()).thenReturn(crossPortProps);
		HandshakeRequest crossPortReq = mock(HandshakeRequest.class);
		when(crossPortReq.getHttpSession()).thenReturn(httpSession);
		when(crossPortReq.getRequestURI()).thenReturn(URI.create("https://erp.example.com/webui/serverpush/dt1"));
		when(crossPortReq.getHeaders()).thenReturn(Map.of(
				"Origin", List.of("https://erp.example.com:8443"),
				"Host", List.of("erp.example.com")));
		configurator.modifyHandshake(secCrossPort, crossPortReq, mock(HandshakeResponse.class));
		assertEquals(Boolean.FALSE, crossPortProps.get("ws-origin-valid"));
	}

	@Test
	void staleOnCloseDoesNotUnregisterNewerEndpoint() throws Exception {
		String dtid = "dt-reconnect-race";
		ServerPushEndPoint oldEndpoint = new ServerPushEndPoint();
		ServerPushEndPoint newEndpoint = new ServerPushEndPoint();
		Session oldSession = mock(Session.class);
		setField(oldEndpoint, "session", oldSession);
		setField(oldEndpoint, "dtid", dtid);

		try {
			WebSocketServerPush.registerEndPoint(dtid, oldEndpoint);
			WebSocketServerPush.registerEndPoint(dtid, newEndpoint);

			oldEndpoint.onClose(oldSession);

			assertSame(newEndpoint, WebSocketServerPush.getEndPoint(dtid),
					"Closing a superseded endpoint must not remove the newer active endpoint");
		} finally {
			WebSocketServerPush.unregisterEndPoint(dtid);
		}
	}

	@Test
	void loopbackAuRequestUsesConfiguredSessionCookieFiltersHeadersAndHidesSetCookie() throws Exception {
		String dtid = "dt-loopback-test";
		CountDownLatch firstResponseSent = new CountDownLatch(1);
		CountDownLatch secondResponseSent = new CountDownLatch(1);
		AtomicReference<String> firstPayload = new AtomicReference<>();
		AtomicReference<String> secondPayload = new AtomicReference<>();
		AtomicReference<Map<String, String>> firstHeaders = new AtomicReference<>();
		AtomicReference<Map<String, String>> secondHeaders = new AtomicReference<>();
		AtomicReference<String> capturedRequestLine = new AtomicReference<>();

		// Test server listens strictly on 127.0.0.1 loopback and handles two sequential requests.
		try (ServerSocket serverSocket = new ServerSocket(0, 5, InetAddress.getLoopbackAddress())) {
			int port = serverSocket.getLocalPort();
			Thread serverThread = new Thread(() -> {
				for (int reqNum = 0; reqNum < 2; reqNum++) {
					try (Socket client = serverSocket.accept()) {
						BufferedReader reader = new BufferedReader(new InputStreamReader(client.getInputStream(), StandardCharsets.UTF_8));
						String reqLine = reader.readLine();
						if (reqNum == 0) {
							capturedRequestLine.set(reqLine);
						}
						Map<String, String> reqHeaders = new HashMap<>();
						int contentLength = 0;
						String line;
						while ((line = reader.readLine()) != null && !line.isEmpty()) {
							int idx = line.indexOf(':');
							if (idx > 0) {
								String name = line.substring(0, idx).trim().toLowerCase(Locale.ROOT);
								String val = line.substring(idx + 1).trim();
								reqHeaders.merge(name, val, (a, b) -> a + "; " + b);
								if ("content-length".equals(name)) {
									contentLength = Integer.parseInt(val);
								}
							}
						}
						if (contentLength > 0) {
							char[] bodyBuf = new char[contentLength];
							int read = 0;
							while (read < contentLength) {
								int n = reader.read(bodyBuf, read, contentLength - read);
								if (n < 0) break;
								read += n;
							}
						}
						if (reqNum == 0) {
							firstHeaders.set(reqHeaders);
						} else {
							secondHeaders.set(reqHeaders);
						}

						String responseBody = "{\"rs\":[],\"rid\":" + (reqNum + 1) + "}";
						StringBuilder httpResp = new StringBuilder();
						httpResp.append("HTTP/1.1 200 OK\r\n")
								.append("Content-Type: application/json;charset=UTF-8\r\n")
								.append("ZK-SID: ").append(42 + reqNum).append("\r\n");
						if (reqNum == 0) {
							httpResp.append("Set-Cookie: secret_tok=abc123; Path=/webui; HttpOnly; Secure; Max-Age=3600\r\n")
									.append("Set-Cookie: existing_tok=v2; Path=/webui; Max-Age=3600\r\n")
									.append("Set-Cookie: old_cookie=; Path=/webui; Max-Age=0\r\n");
						}
						httpResp.append("Content-Length: ").append(responseBody.getBytes(StandardCharsets.UTF_8).length).append("\r\n")
								.append("Connection: close\r\n\r\n")
								.append(responseBody);
						OutputStream out = client.getOutputStream();
						out.write(httpResp.toString().getBytes(StandardCharsets.UTF_8));
						out.flush();
					} catch (Exception ignored) {
					}
				}
			}, "ws-test-loopback-server");
			serverThread.setDaemon(true);
			serverThread.start();

			ServerPushEndPoint stub = new ServerPushEndPoint();
			WebSocketServerPush.registerEndPoint(dtid, stub);
			try {
				Map<String, Object> sessionAttrs = new HashMap<>();
				sessionAttrs.put("ws-desktop-owner." + dtid, Boolean.TRUE);
				sessionAttrs.put("ws-client-ip", "198.51.100.7");
				sessionAttrs.put("ws-local-base-url." + dtid, "http://127.0.0.1:" + port);

				SessionCookieConfig cookieConfig = mock(SessionCookieConfig.class);
				when(cookieConfig.getName()).thenReturn("WEBUI_SESSIONID");
				ServletContext servletContext = mock(ServletContext.class);
				when(servletContext.getContextPath()).thenReturn("/webui");
				when(servletContext.getSessionCookieConfig()).thenReturn(cookieConfig);

				HttpSession httpSession = mock(HttpSession.class);
				when(httpSession.getId()).thenReturn("SESS-XYZ");
				when(httpSession.getServletContext()).thenReturn(servletContext);
				when(httpSession.getAttribute(any())).thenAnswer(inv -> sessionAttrs.get(inv.getArgument(0)));
				org.mockito.Mockito.doAnswer(inv -> {
					sessionAttrs.put(inv.getArgument(0), inv.getArgument(1));
					return null;
				}).when(httpSession).setAttribute(any(), any());

				HandshakeRequest handshakeReq = mock(HandshakeRequest.class);
				when(handshakeReq.getHttpSession()).thenReturn(httpSession);
				when(handshakeReq.getRequestURI()).thenReturn(URI.create("http://127.0.0.1:" + port + "/webui/serverpush/" + dtid));
				Map<String, List<String>> handshakeHeaders = new HashMap<>();
				handshakeHeaders.put("Host", List.of("127.0.0.1:" + port));
				handshakeHeaders.put("Origin", List.of("http://127.0.0.1:" + port));
				handshakeHeaders.put("User-Agent", List.of("TestAgent/1.0"));
				handshakeHeaders.put("Accept-Encoding", List.of("gzip, deflate, br, zstd"));
				handshakeHeaders.put("X-PING", List.of("1"));
				handshakeHeaders.put("Cookie", List.of("existing_tok=v1; old_cookie=stale_val"));
				when(handshakeReq.getHeaders()).thenReturn(handshakeHeaders);

				Map<String, Object> userProps = new HashMap<>();
				ServerEndpointConfig sec = mock(ServerEndpointConfig.class);
				when(sec.getUserProperties()).thenReturn(userProps);
				new EndpointConfigurator().modifyHandshake(sec, handshakeReq, mock(HandshakeResponse.class));

				RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
				org.mockito.Mockito.doAnswer(inv -> {
					String payload = inv.getArgument(0);
					if (firstPayload.compareAndSet(null, payload)) {
						firstResponseSent.countDown();
					} else {
						secondPayload.set(payload);
						secondResponseSent.countDown();
					}
					return null;
				}).when(basic).sendText(any());

				Session wsSession = mock(Session.class);
				when(wsSession.getBasicRemote()).thenReturn(basic);

				ServerPushEndPoint endpoint = new ServerPushEndPoint();
				endpoint.onOpen(wsSession, sec, dtid);

				JSONObject auReq1 = new JSONObject();
				auReq1.put("sid", "42");
				auReq1.put("dt", dtid);
				auReq1.put("uri", "/webui/zkau");
				auReq1.put("content", "dtid=" + dtid + "&cmd_0=onClick");
				endpoint.onMessage(wsSession, "zkau;" + auReq1.toString());

				assertTrue(firstResponseSent.await(5, TimeUnit.SECONDS), "Timed out waiting for first AU response");

				JSONObject auReq2 = new JSONObject();
				auReq2.put("sid", "43");
				auReq2.put("dt", dtid);
				auReq2.put("uri", "/webui/zkau");
				auReq2.put("content", "dtid=" + dtid + "&cmd_0=onClick");
				endpoint.onMessage(wsSession, "zkau;" + auReq2.toString());

				assertTrue(secondResponseSent.await(5, TimeUnit.SECONDS), "Timed out waiting for second AU response");
				serverThread.join(2000);

				assertEquals("POST /webui/zkau HTTP/1.1", capturedRequestLine.get());
				Map<String, String> forwarded = firstHeaders.get();
				assertNotNull(forwarded);
				assertEquals("TestAgent/1.0", forwarded.get("user-agent"));
				assertEquals("198.51.100.7", forwarded.get("x-forwarded-for"));
				assertEquals("true", forwarded.get("x-idempiere-ws-au"));
				assertNull(forwarded.get("accept-encoding"), "Accept-Encoding must not be forwarded to loopback");
				assertNull(forwarded.get("x-ping"), "Arbitrary X-* headers like X-PING must not be forwarded");
				assertNotNull(forwarded.get("cookie"));
				assertTrue(forwarded.get("cookie").contains("WEBUI_SESSIONID=SESS-XYZ"),
						"Expected WEBUI_SESSIONID cookie, got: " + forwarded.get("cookie"));
				assertFalse(forwarded.get("cookie").contains("JSESSIONID="),
						"Should not emit hardcoded JSESSIONID when WEBUI_SESSIONID is configured");

				// Verify second loopback request reflects Secure cookie over HTTP, Path=/webui update, and Max-Age=0 deletion
				Map<String, String> secondForwarded = secondHeaders.get();
				assertNotNull(secondForwarded);
				String secondCookie = secondForwarded.get("cookie");
				assertNotNull(secondCookie);
				assertTrue(secondCookie.contains("WEBUI_SESSIONID=SESS-XYZ"), "Expected session cookie on second request: " + secondCookie);
				assertTrue(secondCookie.contains("secret_tok=abc123"), "Secure cookie must still be sent on node-local HTTP loopback: " + secondCookie);
				assertTrue(secondCookie.contains("existing_tok=v2"), "Updated Path=/webui cookie must replace handshake cookie: " + secondCookie);
				assertFalse(secondCookie.contains("existing_tok=v1"), "Stale handshake cookie value must not remain: " + secondCookie);
				assertFalse(secondCookie.contains("old_cookie="), "Deleted Path=/webui Max-Age=0 cookie must be removed from loopback store: " + secondCookie);

				JSONObject jsonResponse = (JSONObject) new JSONParser().parse(firstPayload.get());
				assertEquals(200, jsonResponse.get("status"));
				assertEquals("42", jsonResponse.get("sid"));
				assertNull(jsonResponse.get("ajaxReqInf"), "Full request payload should not be echoed back");
				assertEquals(Boolean.TRUE, jsonResponse.get("syncCookies"));

				@SuppressWarnings("unchecked")
				Map<String, String> respHeaders = (Map<String, String>) jsonResponse.get("headers");
				assertFalse(respHeaders.containsKey("Set-Cookie"), "Set-Cookie must not be exposed to browser JS");
				assertFalse(respHeaders.containsKey("set-cookie"), "set-cookie must not be exposed to browser JS");

				Object storedCookies = sessionAttrs.get("websocket.event.cookie.store");
				assertTrue(storedCookies instanceof List<?> list && list.size() == 3,
						"All Set-Cookie updates (including Max-Age=0 deletion) should be queued for browser sync");
			} finally {
				WebSocketServerPush.unregisterEndPoint(dtid);
			}
		}
	}

	@Test
	void onMessageWithInvalidatedSessionClosesWebSocketWithViolatedPolicy() throws Exception {
		String dtid = "dt-invalidated-session";
		ServerPushEndPoint endpoint = new ServerPushEndPoint();
		RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
		Session wsSession = mock(Session.class);
		when(wsSession.getBasicRemote()).thenReturn(basic);
		when(wsSession.isOpen()).thenReturn(true);

		HttpSession invalidatedSession = mock(HttpSession.class);
		when(invalidatedSession.getId()).thenReturn("DEAD-SESSION-ID");
		when(invalidatedSession.getLastAccessedTime()).thenThrow(new IllegalStateException("Session invalidated"));

		setField(endpoint, "session", wsSession);
		setField(endpoint, "dtid", dtid);
		setField(endpoint, "httpSession", invalidatedSession);
		setField(endpoint, "internalBaseUri", URI.create("http://127.0.0.1:8080"));
		setField(endpoint, "contextPath", "/webui");
		WebSocketServerPush.registerEndPoint(dtid, endpoint);

		try {
			JSONObject auReq = new JSONObject();
			auReq.put("sid", "99");
			auReq.put("dt", dtid);
			auReq.put("uri", "/webui/zkau");
			auReq.put("content", "dtid=" + dtid + "&cmd_0=onClick");

			endpoint.onMessage(wsSession, "zkau;" + auReq.toString());

			ArgumentCaptor<CloseReason> closeReason = ArgumentCaptor.forClass(CloseReason.class);
			verify(wsSession).close(closeReason.capture());
			assertEquals(CloseReason.CloseCodes.VIOLATED_POLICY, closeReason.getValue().getCloseCode());
			verify(basic, never()).sendText(any());
		} finally {
			WebSocketServerPush.unregisterEndPoint(dtid);
		}
	}

	@Test
	void webSocketServerPushStopCleansUpEndpointAndSession() throws Exception {
		String dtid = "dt-stop-cleanup";
		org.zkoss.zk.ui.Desktop desktop = mock(org.zkoss.zk.ui.Desktop.class);
		when(desktop.getId()).thenReturn(dtid);
		when(desktop.getSession()).thenReturn(null);

		WebSocketServerPush spush = new WebSocketServerPush();
		Field desktopField = WebSocketServerPush.class.getDeclaredField("desktop");
		desktopField.setAccessible(true);
		@SuppressWarnings("unchecked")
		java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop> dtRef =
				(java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop>) desktopField.get(spush);
		dtRef.set(desktop);

		ServerPushEndPoint endpoint = new ServerPushEndPoint();
		Session wsSession = mock(Session.class);
		when(wsSession.isOpen()).thenReturn(true);
		setField(endpoint, "session", wsSession);
		setField(endpoint, "dtid", dtid);
		WebSocketServerPush.registerEndPoint(dtid, endpoint);

		assertTrue(WebSocketServerPush.isValidDesktopId(dtid));
		assertSame(endpoint, WebSocketServerPush.getEndPoint(dtid));

		spush.stop();

		assertFalse(WebSocketServerPush.isValidDesktopId(dtid), "stop() must remove dtid from endPointMap");
		assertNull(WebSocketServerPush.getEndPoint(dtid));
		verify(wsSession).close(any(CloseReason.class));
	}

	@Test
	void cookieHandlerSkipsLoopbackAndFlushesOnBrowserHttpRequest() throws Exception {
		Class<?> pendingCookieClass = Class.forName("org.idempiere.ui.zk.websocket.WebSocketServerPush$PendingBrowserCookie");
		java.lang.reflect.Constructor<?> ctor = pendingCookieClass.getDeclaredConstructor(
				String.class, String.class, String.class, Integer.class, java.util.Date.class, boolean.class, boolean.class);
		ctor.setAccessible(true);
		Object pendingCookie = ctor.newInstance("UD_100", "device-token", "/webui", 3600, null, true, true);

		org.zkoss.zk.ui.Session zkSession = mock(org.zkoss.zk.ui.Session.class);
		when(zkSession.getNativeSession()).thenReturn(new Object());
		when(zkSession.removeAttribute("websocket.event.cookie.store")).thenReturn(List.of(pendingCookie));

		org.zkoss.zk.ui.Desktop desktop = mock(org.zkoss.zk.ui.Desktop.class);
		when(desktop.getSession()).thenReturn(zkSession);

		java.lang.reflect.Method flushMethod = WebSocketServerPush.class.getDeclaredMethod(
				"flushPendingBrowserCookies", org.zkoss.zk.ui.Desktop.class, org.zkoss.zk.ui.Execution.class);
		flushMethod.setAccessible(true);

		// 1. Internal WebSocket loopback request must NOT drain pending browser cookies
		HttpServletRequest loopbackReq = mock(HttpServletRequest.class);
		when(loopbackReq.getHeader("X-iDempiere-WS-AU")).thenReturn("true");
		HttpServletResponse loopbackResp = mock(HttpServletResponse.class);
		org.zkoss.zk.ui.Execution loopbackExec = mock(org.zkoss.zk.ui.Execution.class);
		when(loopbackExec.getNativeRequest()).thenReturn(loopbackReq);
		when(loopbackExec.getNativeResponse()).thenReturn(loopbackResp);

		flushMethod.invoke(null, desktop, loopbackExec);

		verify(zkSession, never()).removeAttribute("websocket.event.cookie.store");
		verify(loopbackResp, never()).addCookie(any());

		// 2. Direct browser HTTP request MUST drain and add the browser cookie with Secure + HttpOnly
		HttpServletRequest browserReq = mock(HttpServletRequest.class);
		when(browserReq.isSecure()).thenReturn(true);
		HttpServletResponse browserResp = mock(HttpServletResponse.class);
		org.zkoss.zk.ui.Execution browserExec = mock(org.zkoss.zk.ui.Execution.class);
		when(browserExec.getNativeRequest()).thenReturn(browserReq);
		when(browserExec.getNativeResponse()).thenReturn(browserResp);

		flushMethod.invoke(null, desktop, browserExec);

		verify(zkSession).removeAttribute("websocket.event.cookie.store");
		ArgumentCaptor<Cookie> cookieCaptor = ArgumentCaptor.forClass(Cookie.class);
		verify(browserResp).addCookie(cookieCaptor.capture());
		Cookie added = cookieCaptor.getValue();
		assertEquals("UD_100", added.getName());
		assertEquals("device-token", added.getValue());
		assertEquals("/webui", added.getPath());
		assertEquals(3600, added.getMaxAge());
		assertTrue(added.getSecure());
		assertTrue(added.isHttpOnly());
	}

	@Test
	void closeDuringInFlightLogoutDeliversRedirectBeforeClosingWebSocket() throws Exception {
		String dtid = "dt-logout-inflight";
		CountDownLatch responseSent = new CountDownLatch(1);
		CountDownLatch sessionClosed = new CountDownLatch(1);
		AtomicReference<String> sentPayload = new AtomicReference<>();
		AtomicReference<Boolean> closedBeforeResponse = new AtomicReference<>(Boolean.FALSE);
		AtomicReference<ServerPushEndPoint> endpointRef = new AtomicReference<>();

		try (ServerSocket serverSocket = new ServerSocket(0, 5, InetAddress.getLoopbackAddress())) {
			int port = serverSocket.getLocalPort();
			Thread serverThread = new Thread(() -> {
				try (Socket client = serverSocket.accept()) {
					BufferedReader reader = new BufferedReader(new InputStreamReader(client.getInputStream(), StandardCharsets.UTF_8));
					reader.readLine();
					int contentLength = 0;
					String line;
					while ((line = reader.readLine()) != null && !line.isEmpty()) {
						int idx = line.indexOf(':');
						if (idx > 0 && "content-length".equalsIgnoreCase(line.substring(0, idx).trim())) {
							contentLength = Integer.parseInt(line.substring(idx + 1).trim());
						}
					}
					if (contentLength > 0) {
						char[] bodyBuf = new char[contentLength];
						int read = 0;
						while (read < contentLength) {
							int n = reader.read(bodyBuf, read, contentLength - read);
							if (n < 0) break;
							read += n;
						}
					}

					// Simulate AdempiereWebUI.logout() -> invalidateNow()/removeDesktop() -> WebSocketServerPush.stop() -> endpoint.close()
					// occurring synchronously while /webui/zkau is still processing the logout AU request.
					endpointRef.get().close();

					String responseBody = "{\"rs\":[[\"redirect\",[\"index.zul\",\"\"]]],\"rid\":1}";
					String httpResp = "HTTP/1.1 200 OK\r\n"
							+ "Content-Type: application/json;charset=UTF-8\r\n"
							+ "ZK-SID: 77\r\n"
							+ "Content-Length: " + responseBody.getBytes(StandardCharsets.UTF_8).length + "\r\n"
							+ "Connection: close\r\n\r\n"
							+ responseBody;
					OutputStream out = client.getOutputStream();
					out.write(httpResp.getBytes(StandardCharsets.UTF_8));
					out.flush();
				} catch (Exception ignored) {
				}
			}, "ws-test-logout-server");
			serverThread.setDaemon(true);
			serverThread.start();

			ServerPushEndPoint endpoint = new ServerPushEndPoint();
			endpointRef.set(endpoint);
			RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
			org.mockito.Mockito.doAnswer(inv -> {
				if (sessionClosed.getCount() == 0) {
					closedBeforeResponse.set(Boolean.TRUE);
				}
				sentPayload.set(inv.getArgument(0));
				responseSent.countDown();
				return null;
			}).when(basic).sendText(any());

			Session wsSession = mock(Session.class);
			when(wsSession.getBasicRemote()).thenReturn(basic);
			when(wsSession.isOpen()).thenReturn(true);
			org.mockito.Mockito.doAnswer(inv -> {
				sessionClosed.countDown();
				return null;
			}).when(wsSession).close(any(CloseReason.class));

			HttpSession httpSession = mock(HttpSession.class);
			when(httpSession.getId()).thenReturn("SESS-LOGOUT");

			setField(endpoint, "session", wsSession);
			setField(endpoint, "dtid", dtid);
			setField(endpoint, "httpSession", httpSession);
			setField(endpoint, "internalBaseUri", URI.create("http://127.0.0.1:" + port));
			setField(endpoint, "contextPath", "/webui");
			WebSocketServerPush.registerEndPoint(dtid, endpoint);

			try {
				JSONObject auReq = new JSONObject();
				auReq.put("sid", "77");
				auReq.put("dt", dtid);
				auReq.put("uri", "/webui/zkau");
				auReq.put("content", "dtid=" + dtid + "&cmd_0=onDeferLogout");
				endpoint.onMessage(wsSession, "zkau;" + auReq.toString());

				assertTrue(responseSent.await(5, TimeUnit.SECONDS), "Logout redirect response must be delivered over WebSocket");
				assertTrue(sessionClosed.await(5, TimeUnit.SECONDS), "WebSocket must close after in-flight logout response is sent");
				serverThread.join(2000);

				assertFalse(closedBeforeResponse.get(), "WebSocket must not close before delivering the in-flight logout response");
				JSONObject jsonResponse = (JSONObject) new JSONParser().parse(sentPayload.get());
				assertEquals(200, jsonResponse.get("status"));
				assertEquals("77", jsonResponse.get("sid"));
				assertTrue(String.valueOf(jsonResponse.get("responseText")).contains("index.zul"),
						"Expected redirect to index.zul in responseText, got: " + jsonResponse.get("responseText"));
			} finally {
				WebSocketServerPush.unregisterEndPoint(dtid);
			}
		}
	}

	@Test
	void defaultAuRequestConfigUsesFiniteResponseTimeout() throws Exception {
		Field configField = ServerPushEndPoint.class.getDeclaredField("AU_REQUEST_CONFIG");
		configField.setAccessible(true);
		Object config = configField.get(null);
		assertNotNull(config);

		Object timeout = config.getClass().getMethod("getResponseTimeout").invoke(config);
		assertNotNull(timeout, "AU_REQUEST_CONFIG must define a finite response timeout");
		long timeoutMs = (Long) timeout.getClass().getMethod("toMilliseconds").invoke(timeout);
		assertTrue(timeoutMs >= 10_000L, "Response timeout must be finite and positive, got: " + timeoutMs);
	}

	@Test
	void stalledAuRequestTimesOutWith504AndDoesNotRetry() throws Exception {
		String dtid = "dt-stalled-au";
		CountDownLatch requestReceived = new CountDownLatch(1);
		CountDownLatch releaseServer = new CountDownLatch(1);
		CountDownLatch responseSent = new CountDownLatch(1);
		AtomicInteger requestCount = new AtomicInteger(0);
		AtomicReference<String> sentPayload = new AtomicReference<>();

		try (ServerSocket serverSocket = new ServerSocket(0, 5, InetAddress.getLoopbackAddress())) {
			int port = serverSocket.getLocalPort();
			Thread serverThread = new Thread(() -> {
				while (!serverSocket.isClosed() && releaseServer.getCount() > 0) {
					try (Socket client = serverSocket.accept()) {
						requestCount.incrementAndGet();
						BufferedReader reader = new BufferedReader(
								new InputStreamReader(client.getInputStream(), StandardCharsets.UTF_8));
						reader.readLine();
						int contentLength = 0;
						String line;
						while ((line = reader.readLine()) != null && !line.isEmpty()) {
							int idx = line.indexOf(':');
							if (idx > 0 && "content-length".equalsIgnoreCase(line.substring(0, idx).trim())) {
								contentLength = Integer.parseInt(line.substring(idx + 1).trim());
							}
						}
						if (contentLength > 0) {
							char[] bodyBuf = new char[contentLength];
							int read = 0;
							while (read < contentLength) {
								int n = reader.read(bodyBuf, read, contentLength - read);
								if (n < 0) break;
								read += n;
							}
						}
						requestReceived.countDown();
						// Stall without writing a response until the test finishes.
						releaseServer.await(5, TimeUnit.SECONDS);
					} catch (Exception ignored) {
					}
				}
			}, "ws-test-stalled-server");
			serverThread.setDaemon(true);
			serverThread.start();

			ServerPushEndPoint endpoint = new ServerPushEndPoint();
			java.lang.reflect.Method createConfig = ServerPushEndPoint.class.getDeclaredMethod("createRequestConfig", long.class);
			createConfig.setAccessible(true);
			setField(endpoint, "auRequestConfig", createConfig.invoke(null, 300L));

			RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
			org.mockito.Mockito.doAnswer(inv -> {
				sentPayload.set(inv.getArgument(0));
				responseSent.countDown();
				return null;
			}).when(basic).sendText(any());

			Session wsSession = mock(Session.class);
			when(wsSession.getBasicRemote()).thenReturn(basic);

			HttpSession httpSession = mock(HttpSession.class);
			when(httpSession.getId()).thenReturn("SESS-STALL");

			setField(endpoint, "session", wsSession);
			setField(endpoint, "dtid", dtid);
			setField(endpoint, "httpSession", httpSession);
			setField(endpoint, "internalBaseUri", URI.create("http://127.0.0.1:" + port));
			setField(endpoint, "contextPath", "/webui");
			WebSocketServerPush.registerEndPoint(dtid, endpoint);

			try {
				JSONObject auReq = new JSONObject();
				auReq.put("sid", "88");
				auReq.put("dt", dtid);
				auReq.put("uri", "/webui/zkau");
				auReq.put("content", "dtid=" + dtid + "&cmd_0=onClick");
				endpoint.onMessage(wsSession, "zkau;" + auReq.toString());

				assertTrue(requestReceived.await(3, TimeUnit.SECONDS), "Stalled server must receive AU POST");
				assertTrue(responseSent.await(3, TimeUnit.SECONDS), "Stalled AU must time out instead of hanging indefinitely");

				JSONObject jsonResponse = (JSONObject) new JSONParser().parse(sentPayload.get());
				assertEquals(504, jsonResponse.get("status"), "Timed-out AU should return 504 (non-auto-retried) status");
				assertEquals("88", jsonResponse.get("sid"));
				assertTrue(String.valueOf(jsonResponse.get("statusText")).contains("unknown"),
						"Timeout status text should indicate unknown execution outcome: " + jsonResponse.get("statusText"));
				assertEquals(1, requestCount.get(), "Timed-out POST must not be automatically retried");

				Field pendingField = ServerPushEndPoint.class.getDeclaredField("pendingRequests");
				pendingField.setAccessible(true);
				AtomicInteger pending = (AtomicInteger) pendingField.get(endpoint);
				long deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(2);
				while (pending.get() != 0 && System.nanoTime() < deadline) {
					Thread.sleep(10);
				}
				assertEquals(0, pending.get(), "Pending request counter must be released after timeout");
			} finally {
				releaseServer.countDown();
				serverSocket.close();
				serverThread.join(2000);
				WebSocketServerPush.unregisterEndPoint(dtid);
			}
		}
	}

	@Test
	void executorScalesBeyondCoreThreadsWhenCoreWorkersAreBlocked() throws Exception {
		java.lang.reflect.Method createExec = ServerPushEndPoint.class.getDeclaredMethod("createExecutorService", int.class, int.class);
		createExec.setAccessible(true);
		ThreadPoolExecutor pool = (ThreadPoolExecutor) createExec.invoke(null, 2, 6);

		CountDownLatch coreWorkersStarted = new CountDownLatch(2);
		CountDownLatch releaseCoreWorkers = new CountDownLatch(1);
		CountDownLatch thirdTaskCompleted = new CountDownLatch(1);

		try {
			for (int i = 0; i < 2; i++) {
				pool.execute(() -> {
					coreWorkersStarted.countDown();
					try {
						releaseCoreWorkers.await(5, TimeUnit.SECONDS);
					} catch (InterruptedException e) {
						Thread.currentThread().interrupt();
					}
				});
			}
			assertTrue(coreWorkersStarted.await(3, TimeUnit.SECONDS), "Core workers should start immediately");

			pool.execute(thirdTaskCompleted::countDown);

			assertTrue(thirdTaskCompleted.await(2, TimeUnit.SECONDS),
					"Executor must spawn a worker above coreThreads instead of queueing behind blocked core workers");
			assertTrue(pool.getPoolSize() >= 3, "Pool should have scaled above coreThreads (2), got: " + pool.getPoolSize());
		} finally {
			releaseCoreWorkers.countDown();
			pool.shutdownNow();
		}
	}

	@Test
	void ownedDesktopCanReconnectAfterIdleDisconnectWithoutHttpPiggyback() throws Exception {
		String dtid = "dt-idle-reconnect";
		Map<String, Object> sessionAttrs = new HashMap<>();

		org.zkoss.zk.ui.Session zkSession = mock(org.zkoss.zk.ui.Session.class);
		org.mockito.Mockito.doAnswer(inv -> {
			sessionAttrs.put(inv.getArgument(0), inv.getArgument(1));
			return null;
		}).when(zkSession).setAttribute(any(), any());
		when(zkSession.getAttribute(any())).thenAnswer(inv -> sessionAttrs.get(inv.getArgument(0)));
		when(zkSession.removeAttribute(any())).thenAnswer(inv -> sessionAttrs.remove(inv.getArgument(0)));

		HttpSession httpSession = mock(HttpSession.class);
		when(httpSession.getAttribute(any())).thenAnswer(inv -> sessionAttrs.get(inv.getArgument(0)));

		org.zkoss.zk.ui.Desktop desktop = mock(org.zkoss.zk.ui.Desktop.class);
		when(desktop.getId()).thenReturn(dtid);
		when(desktop.getSession()).thenReturn(zkSession);

		WebSocketServerPush spush = new WebSocketServerPush();
		try {
			org.zkoss.zk.ui.Execution mockExec = mock(org.zkoss.zk.ui.Execution.class);
			try (org.mockito.MockedStatic<org.zkoss.zk.ui.Executions> executions =
					org.mockito.Mockito.mockStatic(org.zkoss.zk.ui.Executions.class)) {
				executions.when(org.zkoss.zk.ui.Executions::getCurrent).thenReturn(mockExec);
				spush.start(desktop);
			}
			assertEquals(Boolean.TRUE, sessionAttrs.get("ws-desktop-owner." + dtid),
					"start() must record desktop ownership on the session");
			assertTrue(WebSocketServerPush.isValidDesktopId(dtid, httpSession));

			Map<String, Object> userProps = new HashMap<>();
			userProps.put(HttpSession.class.getName(), httpSession);
			userProps.put("ws-origin-valid", Boolean.TRUE);
			EndpointConfig config = mock(EndpointConfig.class);
			when(config.getUserProperties()).thenReturn(userProps);

			// 1. Initial WebSocket connection opens and registers.
			Session wsSession1 = mock(Session.class);
			ServerPushEndPoint endpoint1 = new ServerPushEndPoint();
			endpoint1.onOpen(wsSession1, config, dtid);
			verify(wsSession1, never()).close(any(CloseReason.class));
			assertSame(endpoint1, WebSocketServerPush.getEndPoint(dtid));

			// 2. Idle socket disconnects and invokes onClose.
			endpoint1.onClose(wsSession1);
			assertNull(WebSocketServerPush.getEndPoint(dtid), "Disconnected socket must be removed from live endpoint map");
			assertEquals(Boolean.TRUE, sessionAttrs.get("ws-desktop-owner." + dtid),
					"Session ownership must be preserved across socket disconnects");
			assertTrue(WebSocketServerPush.isValidDesktopId(dtid, httpSession),
					"Active owned desktop must remain valid for reconnect after socket close");

			// 3. Browser reconnects directly without any intervening HTTP piggyback.
			Session wsSession2 = mock(Session.class);
			when(wsSession2.isOpen()).thenReturn(true);
			ServerPushEndPoint endpoint2 = new ServerPushEndPoint();
			endpoint2.onOpen(wsSession2, config, dtid);
			verify(wsSession2, never()).close(any(CloseReason.class));
			assertSame(endpoint2, WebSocketServerPush.getEndPoint(dtid),
					"Reconnected endpoint must be accepted and registered");

			// 4. Stopping server push revokes desktop registration and session ownership.
			spush.stop();
			assertNull(sessionAttrs.get("ws-desktop-owner." + dtid),
					"stop() must revoke desktop ownership from the session");
			assertFalse(WebSocketServerPush.isValidDesktopId(dtid));
			assertFalse(WebSocketServerPush.isValidDesktopId(dtid, httpSession));
			assertNull(WebSocketServerPush.getEndPoint(dtid));

			// 5. Reconnect after stop() must be rejected with VIOLATED_POLICY (1008).
			Session wsSession3 = mock(Session.class);
			new ServerPushEndPoint().onOpen(wsSession3, config, dtid);
			ArgumentCaptor<CloseReason> closeReason = ArgumentCaptor.forClass(CloseReason.class);
			verify(wsSession3).close(closeReason.capture());
			assertEquals(CloseReason.CloseCodes.VIOLATED_POLICY, closeReason.getValue().getCloseCode());
		} finally {
			spush.stop();
		}
	}

	@Test
	void onOpenRejectsRegistrationWhenStopRacesBetweenValidationAndRegister() throws Exception {
		String dtid = "dt-open-stop-race";
		Map<String, Object> sessionAttrs = new HashMap<>();

		org.zkoss.zk.ui.Session zkSession = mock(org.zkoss.zk.ui.Session.class);
		org.mockito.Mockito.doAnswer(inv -> {
			sessionAttrs.put(inv.getArgument(0), inv.getArgument(1));
			return null;
		}).when(zkSession).setAttribute(any(), any());
		when(zkSession.getAttribute(any())).thenAnswer(inv -> sessionAttrs.get(inv.getArgument(0)));
		when(zkSession.removeAttribute(any())).thenAnswer(inv -> sessionAttrs.remove(inv.getArgument(0)));

		HttpSession httpSession = mock(HttpSession.class);
		when(httpSession.getAttribute(any())).thenAnswer(inv -> sessionAttrs.get(inv.getArgument(0)));

		org.zkoss.zk.ui.Desktop desktop = mock(org.zkoss.zk.ui.Desktop.class);
		when(desktop.getId()).thenReturn(dtid);
		when(desktop.getSession()).thenReturn(zkSession);

		WebSocketServerPush spush = new WebSocketServerPush();
		try {
			org.zkoss.zk.ui.Execution mockExec = mock(org.zkoss.zk.ui.Execution.class);
			try (org.mockito.MockedStatic<org.zkoss.zk.ui.Executions> executions =
					org.mockito.Mockito.mockStatic(org.zkoss.zk.ui.Executions.class)) {
				executions.when(org.zkoss.zk.ui.Executions::getCurrent).thenReturn(mockExec);
				spush.start(desktop);
			}

			Map<String, Object> userProps = new HashMap<>();
			userProps.put(HttpSession.class.getName(), httpSession);
			userProps.put("ws-origin-valid", Boolean.TRUE);
			EndpointConfig config = mock(EndpointConfig.class);
			when(config.getUserProperties()).thenReturn(userProps);

			Session wsSession = mock(Session.class);
			// Trigger stop() right after onOpen's initial isValidDesktopId check and before registration.
			org.mockito.Mockito.doAnswer(inv -> {
				spush.stop();
				return null;
			}).when(wsSession).setMaxTextMessageBufferSize(org.mockito.ArgumentMatchers.anyInt());

			ServerPushEndPoint endpoint = new ServerPushEndPoint();
			endpoint.onOpen(wsSession, config, dtid);

			ArgumentCaptor<CloseReason> closeReason = ArgumentCaptor.forClass(CloseReason.class);
			verify(wsSession).close(closeReason.capture());
			assertEquals(CloseReason.CloseCodes.VIOLATED_POLICY, closeReason.getValue().getCloseCode());
			assertNull(WebSocketServerPush.getEndPoint(dtid), "Stopped desktop must not retain a registered endpoint");
			assertFalse(WebSocketServerPush.isValidDesktopId(dtid), "Stopped desktop must remain unregistered");

			Field sessionField = ServerPushEndPoint.class.getDeclaredField("session");
			sessionField.setAccessible(true);
			assertNull(sessionField.get(endpoint), "Rejected endpoint must clear its session reference");
		} finally {
			spush.stop();
		}
	}

	@Test
	void executorRejectionSends503ReleasesPendingSlotAndRecoversExecutionChain() throws Exception {
		String dtid = "dt-exec-reject";
		List<String> sentPayloads = java.util.Collections.synchronizedList(new java.util.ArrayList<>());
		CountDownLatch firstResponse = new CountDownLatch(1);
		CountDownLatch allFourResponses = new CountDownLatch(4);
		CountDownLatch req2EnteredServer = new CountDownLatch(1);
		CountDownLatch releaseReq2 = new CountDownLatch(1);
		AtomicInteger submitAttempt = new AtomicInteger(0);
		ExecutorService backingPool = Executors.newFixedThreadPool(2);

		try (ServerSocket serverSocket = new ServerSocket(0, 5, InetAddress.getLoopbackAddress())) {
			int port = serverSocket.getLocalPort();
			Thread serverThread = new Thread(() -> {
				for (int i = 0; i < 2; i++) {
					final int reqIdx = i;
					try (Socket client = serverSocket.accept()) {
						BufferedReader reader = new BufferedReader(
								new InputStreamReader(client.getInputStream(), StandardCharsets.UTF_8));
						reader.readLine();
						int contentLength = 0;
						String sidHeader = "0";
						String line;
						while ((line = reader.readLine()) != null && !line.isEmpty()) {
							int idx = line.indexOf(':');
							if (idx > 0) {
								String name = line.substring(0, idx).trim();
								String val = line.substring(idx + 1).trim();
								if ("content-length".equalsIgnoreCase(name)) {
									contentLength = Integer.parseInt(val);
								} else if ("zk-sid".equalsIgnoreCase(name)) {
									sidHeader = val;
								}
							}
						}
						if (contentLength > 0) {
							char[] bodyBuf = new char[contentLength];
							int read = 0;
							while (read < contentLength) {
								int n = reader.read(bodyBuf, read, contentLength - read);
								if (n < 0) break;
								read += n;
							}
						}
						if (reqIdx == 0) {
							req2EnteredServer.countDown();
							releaseReq2.await(5, TimeUnit.SECONDS);
						}
						String body = "{\"rs\":[],\"rid\":" + sidHeader + "}";
						String httpResp = "HTTP/1.1 200 OK\r\n"
								+ "Content-Type: application/json;charset=UTF-8\r\n"
								+ "ZK-SID: " + sidHeader + "\r\n"
								+ "Content-Length: " + body.getBytes(StandardCharsets.UTF_8).length + "\r\n"
								+ "Connection: close\r\n\r\n"
								+ body;
						OutputStream out = client.getOutputStream();
						out.write(httpResp.getBytes(StandardCharsets.UTF_8));
						out.flush();
					} catch (Exception ignored) {
					}
				}
			}, "ws-test-reject-recovery-server");
			serverThread.setDaemon(true);
			serverThread.start();

			// Reject attempt 1 (completed tail -> uniRunNow) and attempt 3 (in-flight tail -> UniRun.tryFire),
			// allow attempts 2 and 4 to run on the backing pool.
			Executor flakyExecutor = command -> {
				int attempt = submitAttempt.incrementAndGet();
				if (attempt == 1 || attempt == 3) {
					throw new RejectedExecutionException("Simulated pool saturation on attempt " + attempt);
				}
				backingPool.execute(command);
			};

			ServerPushEndPoint endpoint = new ServerPushEndPoint();
			setField(endpoint, "auExecutor", flakyExecutor);

			RemoteEndpoint.Basic basic = mock(RemoteEndpoint.Basic.class);
			org.mockito.Mockito.doAnswer(inv -> {
				sentPayloads.add(inv.getArgument(0));
				firstResponse.countDown();
				allFourResponses.countDown();
				return null;
			}).when(basic).sendText(any());

			Session wsSession = mock(Session.class);
			when(wsSession.getBasicRemote()).thenReturn(basic);

			HttpSession httpSession = mock(HttpSession.class);
			when(httpSession.getId()).thenReturn("SESS-REJECT");

			setField(endpoint, "session", wsSession);
			setField(endpoint, "dtid", dtid);
			setField(endpoint, "httpSession", httpSession);
			setField(endpoint, "internalBaseUri", URI.create("http://127.0.0.1:" + port));
			setField(endpoint, "contextPath", "/webui");
			WebSocketServerPush.registerEndPoint(dtid, endpoint);

			try {
				// Request 1: rejected immediately on completed tail (uniRunNow path).
				endpoint.onMessage(wsSession, "zkau;{\"sid\":\"1\",\"dt\":\"" + dtid + "\",\"uri\":\"/webui/zkau\",\"content\":\"cmd_0=a\"}");
				assertTrue(firstResponse.await(3, TimeUnit.SECONDS), "Rejected request must still send 503 response");

				// Request 2: must run after tail recovery; pause it in server so Requests 3 & 4 queue behind an in-flight tail.
				endpoint.onMessage(wsSession, "zkau;{\"sid\":\"2\",\"dt\":\"" + dtid + "\",\"uri\":\"/webui/zkau\",\"content\":\"cmd_0=b\"}");
				assertTrue(req2EnteredServer.await(3, TimeUnit.SECONDS), "Request 2 must execute after Request 1 rejection");

				// Request 3 (will be rejected via UniRun.tryFire when Request 2 completes) & Request 4 (must recover and succeed).
				endpoint.onMessage(wsSession, "zkau;{\"sid\":\"3\",\"dt\":\"" + dtid + "\",\"uri\":\"/webui/zkau\",\"content\":\"cmd_0=c\"}");
				endpoint.onMessage(wsSession, "zkau;{\"sid\":\"4\",\"dt\":\"" + dtid + "\",\"uri\":\"/webui/zkau\",\"content\":\"cmd_0=d\"}");
				releaseReq2.countDown();

				assertTrue(allFourResponses.await(5, TimeUnit.SECONDS), "All 4 requests must receive responses in order");
				serverThread.join(2000);

				assertEquals(4, sentPayloads.size());
				JSONParser parser = new JSONParser();
				JSONObject r1 = (JSONObject) parser.parse(sentPayloads.get(0));
				JSONObject r2 = (JSONObject) parser.parse(sentPayloads.get(1));
				JSONObject r3 = (JSONObject) parser.parse(sentPayloads.get(2));
				JSONObject r4 = (JSONObject) parser.parse(sentPayloads.get(3));

				assertEquals(503, r1.get("status"));
				assertEquals("1", r1.get("sid"));
				assertEquals(200, r2.get("status"));
				assertEquals("2", r2.get("sid"));
				assertEquals(503, r3.get("status"));
				assertEquals("3", r3.get("sid"));
				assertEquals(200, r4.get("status"));
				assertEquals("4", r4.get("sid"));

				Field pendingField = ServerPushEndPoint.class.getDeclaredField("pendingRequests");
				pendingField.setAccessible(true);
				AtomicInteger pending = (AtomicInteger) pendingField.get(endpoint);
				long deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(2);
				while (pending.get() != 0 && System.nanoTime() < deadline) {
					Thread.sleep(10);
				}
				assertEquals(0, pending.get(), "pendingRequests must return to exactly 0 after rejections and recovery");
			} finally {
				releaseReq2.countDown();
				backingPool.shutdownNow();
				WebSocketServerPush.unregisterEndPoint(dtid);
			}
		}
	}

	@Test
	void activateCountsLockWaitAgainstTimeoutAndPreservesInBudgetActivation() throws Exception {
		// Part 1: Second worker calling activate(120) must time out promptly instead of waiting behind first worker.
		org.zkoss.zk.ui.Desktop desktop1 = mock(org.zkoss.zk.ui.Desktop.class,
				org.mockito.Mockito.withSettings().extraInterfaces(org.zkoss.zk.ui.sys.DesktopCtrl.class));
		when(desktop1.getId()).thenReturn("dt-activate-timeout");
		when(desktop1.isAlive()).thenReturn(true);
		when(desktop1.getSession()).thenReturn(null);

		CountDownLatch firstWorkerWaiting = new CountDownLatch(1);
		org.mockito.Mockito.doAnswer(inv -> {
			firstWorkerWaiting.countDown();
			return null;
		}).when((org.zkoss.zk.ui.sys.DesktopCtrl) desktop1).scheduleServerPush(any(), any());

		WebSocketServerPush spush1 = new WebSocketServerPush();
		Field desktopField = WebSocketServerPush.class.getDeclaredField("desktop");
		desktopField.setAccessible(true);
		@SuppressWarnings("unchecked")
		java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop> dtRef1 =
				(java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop>) desktopField.get(spush1);
		dtRef1.set(desktop1);

		Thread firstWorker = new Thread(() -> {
			try {
				spush1.activate(5_000L);
			} catch (Exception ignored) {
			}
		}, "ws-test-activate-holder");
		firstWorker.setDaemon(true);
		firstWorker.start();

		try {
			assertTrue(firstWorkerWaiting.await(3, TimeUnit.SECONDS), "First worker should hold _activateLock and wait");

			long startNanos = System.nanoTime();
			boolean activated = spush1.activate(120L);
			long elapsedMs = TimeUnit.NANOSECONDS.toMillis(System.nanoTime() - startNanos);

			assertFalse(activated, "Second worker must time out when _activateLock is held longer than its budget");
			assertTrue(elapsedMs < 1_500L, "Second worker waited too long behind first worker: " + elapsedMs + "ms");
		} finally {
			spush1.stop();
			firstWorker.join(2000);
		}

		// Part 2: Worker that waits briefly for _activateLock and completes handoff within budget must succeed.
		org.zkoss.zk.ui.Desktop desktop2 = mock(org.zkoss.zk.ui.Desktop.class,
				org.mockito.Mockito.withSettings().extraInterfaces(org.zkoss.zk.ui.sys.DesktopCtrl.class));
		when(desktop2.getId()).thenReturn("dt-activate-success");
		when(desktop2.isAlive()).thenReturn(true);
		when(desktop2.getSession()).thenReturn(null);

		org.zkoss.zk.ui.Execution mockExec = mock(org.zkoss.zk.ui.Execution.class,
				org.mockito.Mockito.withSettings().extraInterfaces(org.zkoss.zk.ui.sys.ExecutionCtrl.class));
		when(mockExec.getDesktop()).thenReturn(desktop2);

		AtomicReference<Thread> piggybackThreadRef = new AtomicReference<>();
		org.mockito.Mockito.doAnswer(inv -> {
			@SuppressWarnings("unchecked")
			org.zkoss.zk.ui.event.EventListener<org.zkoss.zk.ui.event.Event> listener = inv.getArgument(0);
			org.zkoss.zk.ui.event.Event evt = inv.getArgument(1);
			Thread piggyback = new Thread(() -> {
				org.zkoss.zk.ui.sys.ExecutionsCtrl.setCurrent(mockExec);
				try {
					listener.onEvent(evt);
				} catch (Exception ignored) {
				} finally {
					org.zkoss.zk.ui.sys.ExecutionsCtrl.setCurrent(null);
				}
			}, "ws-test-activate-piggyback");
			piggyback.setDaemon(true);
			piggybackThreadRef.set(piggyback);
			piggyback.start();
			return null;
		}).when((org.zkoss.zk.ui.sys.DesktopCtrl) desktop2).scheduleServerPush(any(), any());

		WebSocketServerPush spush2 = new WebSocketServerPush();
		@SuppressWarnings("unchecked")
		java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop> dtRef2 =
				(java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop>) desktopField.get(spush2);
		dtRef2.set(desktop2);

		Field lockField = WebSocketServerPush.class.getDeclaredField("_activateLock");
		lockField.setAccessible(true);
		java.util.concurrent.locks.ReentrantLock activateLock =
				(java.util.concurrent.locks.ReentrantLock) lockField.get(spush2);

		CountDownLatch lockAcquiredByOther = new CountDownLatch(1);
		Thread briefHolder = new Thread(() -> {
			activateLock.lock();
			try {
				lockAcquiredByOther.countDown();
				Thread.sleep(60);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
			} finally {
				activateLock.unlock();
			}
		}, "ws-test-activate-brief-holder");
		briefHolder.setDaemon(true);
		briefHolder.start();

		try {
			assertTrue(lockAcquiredByOther.await(2, TimeUnit.SECONDS));
			boolean activated = spush2.activate(2_000L);
			assertTrue(activated, "Activation completing within remaining budget after lock wait must succeed");
			assertTrue(spush2.isActive());
		} finally {
			spush2.deactivate(false);
			spush2.stop();
			briefHolder.join(2000);
			Thread piggyback = piggybackThreadRef.get();
			if (piggyback != null) {
				piggyback.join(2000);
			}
		}
	}

	@Test
	void activateInterruptBeforeAndAfterGrantDoesNotBlockDesktopExecution() throws Exception {
		Field desktopField = WebSocketServerPush.class.getDeclaredField("desktop");
		desktopField.setAccessible(true);
		Field carryOverField = WebSocketServerPush.class.getDeclaredField("_carryOver");
		carryOverField.setAccessible(true);
		Field waitingField = WebSocketServerPush.class.getDeclaredField("_waiting");
		waitingField.setAccessible(true);

		// Part 1: Interrupt before callback runs cancels activation so later piggyback does not grant or block.
		org.zkoss.zk.ui.Desktop desktop1 = mock(org.zkoss.zk.ui.Desktop.class,
				org.mockito.Mockito.withSettings().extraInterfaces(org.zkoss.zk.ui.sys.DesktopCtrl.class));
		when(desktop1.getId()).thenReturn("dt-interrupt-pre-grant");
		when(desktop1.isAlive()).thenReturn(true);
		when(desktop1.getSession()).thenReturn(null);

		AtomicReference<org.zkoss.zk.ui.event.EventListener<org.zkoss.zk.ui.event.Event>> listener1Ref = new AtomicReference<>();
		AtomicReference<org.zkoss.zk.ui.event.Event> event1Ref = new AtomicReference<>();
		CountDownLatch scheduled1 = new CountDownLatch(1);
		org.mockito.Mockito.doAnswer(inv -> {
			listener1Ref.set(inv.getArgument(0));
			event1Ref.set(inv.getArgument(1));
			scheduled1.countDown();
			return null;
		}).when((org.zkoss.zk.ui.sys.DesktopCtrl) desktop1).scheduleServerPush(any(), any());

		WebSocketServerPush spush1 = new WebSocketServerPush();
		@SuppressWarnings("unchecked")
		java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop> dtRef1 =
				(java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop>) desktopField.get(spush1);
		dtRef1.set(desktop1);

		AtomicReference<Throwable> worker1Error = new AtomicReference<>();
		Thread worker1 = new Thread(() -> {
			try {
				spush1.activate(5_000L);
			} catch (Throwable t) {
				worker1Error.set(t);
			}
		}, "ws-test-interrupt-pre-grant");
		worker1.setDaemon(true);
		worker1.start();

		try {
			assertTrue(scheduled1.await(3, TimeUnit.SECONDS));
			Object info1 = waitingField.get(spush1);
			assertNotNull(info1);
			// Acquiring info1 guarantees worker1 has entered info.wait() and released the monitor.
			synchronized (info1) {
				worker1.interrupt();
			}
			worker1.join(3000);
			assertFalse(worker1.isAlive(), "Interrupted worker should exit activate()");
			assertTrue(worker1Error.get() instanceof InterruptedException, "Expected InterruptedException, got: " + worker1Error.get());

			// Now run the late piggyback callback; it must see info.cancelled == true and return immediately.
			org.zkoss.zk.ui.Execution mockExec1 = mock(org.zkoss.zk.ui.Execution.class,
					org.mockito.Mockito.withSettings().extraInterfaces(org.zkoss.zk.ui.sys.ExecutionCtrl.class));
			when(mockExec1.getDesktop()).thenReturn(desktop1);
			CountDownLatch callback1Done = new CountDownLatch(1);
			Thread piggyback1 = new Thread(() -> {
				org.zkoss.zk.ui.sys.ExecutionsCtrl.setCurrent(mockExec1);
				try {
					listener1Ref.get().onEvent(event1Ref.get());
				} catch (Exception ignored) {
				} finally {
					org.zkoss.zk.ui.sys.ExecutionsCtrl.setCurrent(null);
					callback1Done.countDown();
				}
			}, "ws-test-late-piggyback");
			piggyback1.setDaemon(true);
			piggyback1.start();

			assertTrue(callback1Done.await(2, TimeUnit.SECONDS), "Late piggyback must not block after pre-grant interrupt");
			assertNull(carryOverField.get(spush1), "Cancelled activation must not leave _carryOver set");
			assertFalse(spush1.isActive());
		} finally {
			spush1.stop();
			worker1.join(1000);
		}

		// Part 2: Interrupt concurrent with grant (before worker accepts it) must release handoff and wake desktop.
		org.zkoss.zk.ui.Desktop desktop2 = mock(org.zkoss.zk.ui.Desktop.class,
				org.mockito.Mockito.withSettings().extraInterfaces(org.zkoss.zk.ui.sys.DesktopCtrl.class));
		when(desktop2.getId()).thenReturn("dt-interrupt-post-grant");
		when(desktop2.isAlive()).thenReturn(true);
		when(desktop2.getSession()).thenReturn(null);

		AtomicReference<org.zkoss.zk.ui.event.EventListener<org.zkoss.zk.ui.event.Event>> listener2Ref = new AtomicReference<>();
		AtomicReference<org.zkoss.zk.ui.event.Event> event2Ref = new AtomicReference<>();
		CountDownLatch scheduled2 = new CountDownLatch(1);
		org.mockito.Mockito.doAnswer(inv -> {
			listener2Ref.set(inv.getArgument(0));
			event2Ref.set(inv.getArgument(1));
			scheduled2.countDown();
			return null;
		}).when((org.zkoss.zk.ui.sys.DesktopCtrl) desktop2).scheduleServerPush(any(), any());

		WebSocketServerPush spush2 = new WebSocketServerPush();
		@SuppressWarnings("unchecked")
		java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop> dtRef2 =
				(java.util.concurrent.atomic.AtomicReference<org.zkoss.zk.ui.Desktop>) desktopField.get(spush2);
		dtRef2.set(desktop2);

		AtomicReference<Throwable> worker2Error = new AtomicReference<>();
		Thread worker2 = new Thread(() -> {
			try {
				spush2.activate(5_000L);
			} catch (Throwable t) {
				worker2Error.set(t);
			}
		}, "ws-test-interrupt-post-grant");
		worker2.setDaemon(true);
		worker2.start();

		try {
			assertTrue(scheduled2.await(3, TimeUnit.SECONDS));
			Object info2 = waitingField.get(spush2);
			assertNotNull(info2);
			// Ensure worker2 is inside info.wait() before running the piggyback grant.
			synchronized (info2) {
				// Monitor acquired => worker2 is waiting in info.wait().
			}

			// Interrupt worker2 while piggyback is inside new ExecutionCarryOver(currentDesktop) under synchronized(info),
			// guaranteeing the grant completes while worker2 is interrupted before it can accept the handoff.
			org.zkoss.zk.ui.Execution mockExec2 = mock(org.zkoss.zk.ui.Execution.class,
					org.mockito.Mockito.withSettings().extraInterfaces(org.zkoss.zk.ui.sys.ExecutionCtrl.class));
			when(mockExec2.getDesktop()).thenAnswer(inv -> {
				worker2.interrupt();
				return desktop2;
			});

			CountDownLatch callback2Done = new CountDownLatch(1);
			Thread piggyback2 = new Thread(() -> {
				org.zkoss.zk.ui.sys.ExecutionsCtrl.setCurrent(mockExec2);
				try {
					listener2Ref.get().onEvent(event2Ref.get());
				} catch (Exception ignored) {
				} finally {
					org.zkoss.zk.ui.sys.ExecutionsCtrl.setCurrent(null);
					callback2Done.countDown();
				}
			}, "ws-test-post-grant-piggyback");
			piggyback2.setDaemon(true);
			piggyback2.start();

			worker2.join(3000);
			assertFalse(worker2.isAlive(), "Interrupted worker must exit activate()");
			assertTrue(worker2Error.get() instanceof InterruptedException, "Expected InterruptedException, got: " + worker2Error.get());
			assertTrue(callback2Done.await(2, TimeUnit.SECONDS),
					"Desktop piggyback execution must be woken when worker is interrupted before accepting grant");
			assertNull(carryOverField.get(spush2), "Abandoned grant must clear _carryOver");
			assertFalse(spush2.isActive(), "Worker must not own activation after throwing InterruptedException");
			verify((org.zkoss.zk.ui.sys.ExecutionCtrl) mockExec2, never()).onActivate();
		} finally {
			spush2.stop();
			worker2.join(1000);
		}
	}

	@Test
	void failedEchoClearsEchoPendingAndReconnectFlushesQueuedSchedules() throws Exception {
		String dtid = "dt-echo-failure-recovery";
		Map<String, Object> sessionAttrs = new HashMap<>();

		org.zkoss.zk.ui.Session zkSession = mock(org.zkoss.zk.ui.Session.class);
		org.mockito.Mockito.doAnswer(inv -> {
			sessionAttrs.put(inv.getArgument(0), inv.getArgument(1));
			return null;
		}).when(zkSession).setAttribute(any(), any());
		when(zkSession.getAttribute(any())).thenAnswer(inv -> sessionAttrs.get(inv.getArgument(0)));
		when(zkSession.removeAttribute(any())).thenAnswer(inv -> sessionAttrs.remove(inv.getArgument(0)));

		HttpSession httpSession = mock(HttpSession.class);
		when(httpSession.getAttribute(any())).thenAnswer(inv -> sessionAttrs.get(inv.getArgument(0)));

		org.zkoss.zk.ui.Desktop desktop = mock(org.zkoss.zk.ui.Desktop.class);
		when(desktop.getId()).thenReturn(dtid);
		when(desktop.getSession()).thenReturn(zkSession);
		when(desktop.isServerPushEnabled()).thenReturn(true);

		WebSocketServerPush spush = new WebSocketServerPush();
		Field echoPendingField = WebSocketServerPush.class.getDeclaredField("echoPending");
		echoPendingField.setAccessible(true);
		java.util.concurrent.atomic.AtomicBoolean echoPending =
				(java.util.concurrent.atomic.AtomicBoolean) echoPendingField.get(spush);

		try {
			org.zkoss.zk.ui.Execution mockExec = mock(org.zkoss.zk.ui.Execution.class);
			try (org.mockito.MockedStatic<org.zkoss.zk.ui.Executions> executions =
					org.mockito.Mockito.mockStatic(org.zkoss.zk.ui.Executions.class)) {
				executions.when(org.zkoss.zk.ui.Executions::getCurrent).thenReturn(mockExec);
				spush.start(desktop);
			}

			Map<String, Object> userProps = new HashMap<>();
			userProps.put(HttpSession.class.getName(), httpSession);
			userProps.put("ws-origin-valid", Boolean.TRUE);
			EndpointConfig config = mock(EndpointConfig.class);
			when(config.getUserProperties()).thenReturn(userProps);

			// 1. Open endpoint whose sendText("echo") fails with IOException.
			RemoteEndpoint.Basic failingBasic = mock(RemoteEndpoint.Basic.class);
			org.mockito.Mockito.doThrow(new java.io.IOException("Broken pipe")).when(failingBasic).sendText("echo");
			Session failingSession = mock(Session.class);
			when(failingSession.getBasicRemote()).thenReturn(failingBasic);

			ServerPushEndPoint failingEndpoint = new ServerPushEndPoint();
			failingEndpoint.onOpen(failingSession, config, dtid);

			// Schedule task while echo send fails: echoPending must NOT be retained.
			spush.schedule(evt -> {}, new org.zkoss.zk.ui.event.Event("onTest"), null);
			assertFalse(echoPending.get(), "echoPending must be cleared when echo send fails");

			// 2. When browser reconnects without any further schedule() call, queued task must trigger echo automatically.
			RemoteEndpoint.Basic healthyBasic = mock(RemoteEndpoint.Basic.class);
			Session healthySession = mock(Session.class);
			when(healthySession.getBasicRemote()).thenReturn(healthyBasic);

			ServerPushEndPoint healthyEndpoint = new ServerPushEndPoint();
			healthyEndpoint.onOpen(healthySession, config, dtid);

			verify(healthyBasic).sendText("echo");
			assertTrue(echoPending.get(), "echoPending must be retained after successful echo on reconnect");
		} finally {
			spush.stop();
		}
	}

	@Test
	void cookieFlushUsesRemainingExpiryForDelayedPositiveMaxAgeAndZeroForDeletions() throws Exception {
		Class<?> pendingCookieClass = Class.forName("org.idempiere.ui.zk.websocket.WebSocketServerPush$PendingBrowserCookie");
		java.lang.reflect.Constructor<?> ctor = pendingCookieClass.getDeclaredConstructor(
				String.class, String.class, String.class, Integer.class, java.util.Date.class, boolean.class, boolean.class);
		ctor.setAccessible(true);

		long now = System.currentTimeMillis();
		// Cookie originally had Max-Age=30, but flush is delayed 45s -> already expired 15s ago.
		Object expiredMaxAgeCookie = ctor.newInstance("SHORT_TOK", "stale", "/webui", 30, new java.util.Date(now - 15_000L), true, true);
		// Cookie originally had Max-Age=60, delayed 40s -> ~20s remaining (must not reset to 60).
		Object partiallyElapsedCookie = ctor.newInstance("PARTIAL_TOK", "val", "/webui", 60, new java.util.Date(now + 20_000L), true, true);
		// Explicit Max-Age=0 deletion must stay 0 regardless of expiryDate.
		Object explicitDeletionCookie = ctor.newInstance("DEL_TOK", "", "/webui", 0, new java.util.Date(now + 60_000L), true, true);

		org.zkoss.zk.ui.Session zkSession = mock(org.zkoss.zk.ui.Session.class);
		when(zkSession.getNativeSession()).thenReturn(new Object());
		when(zkSession.removeAttribute("websocket.event.cookie.store")).thenReturn(
				List.of(expiredMaxAgeCookie, partiallyElapsedCookie, explicitDeletionCookie));

		org.zkoss.zk.ui.Desktop desktop = mock(org.zkoss.zk.ui.Desktop.class);
		when(desktop.getSession()).thenReturn(zkSession);

		HttpServletRequest browserReq = mock(HttpServletRequest.class);
		when(browserReq.isSecure()).thenReturn(true);
		HttpServletResponse browserResp = mock(HttpServletResponse.class);
		org.zkoss.zk.ui.Execution browserExec = mock(org.zkoss.zk.ui.Execution.class);
		when(browserExec.getNativeRequest()).thenReturn(browserReq);
		when(browserExec.getNativeResponse()).thenReturn(browserResp);

		java.lang.reflect.Method flushMethod = WebSocketServerPush.class.getDeclaredMethod(
				"flushPendingBrowserCookies", org.zkoss.zk.ui.Desktop.class, org.zkoss.zk.ui.Execution.class);
		flushMethod.setAccessible(true);
		flushMethod.invoke(null, desktop, browserExec);

		ArgumentCaptor<Cookie> cookieCaptor = ArgumentCaptor.forClass(Cookie.class);
		verify(browserResp, org.mockito.Mockito.times(3)).addCookie(cookieCaptor.capture());
		List<Cookie> added = cookieCaptor.getAllValues();

		assertEquals("SHORT_TOK", added.get(0).getName());
		assertEquals(0, added.get(0).getMaxAge(), "Expired positive Max-Age cookie must flush with Max-Age=0");

		assertEquals("PARTIAL_TOK", added.get(1).getName());
		assertTrue(added.get(1).getMaxAge() >= 15 && added.get(1).getMaxAge() <= 21,
				"Delayed positive Max-Age cookie must flush remaining lifetime (~20s), got: " + added.get(1).getMaxAge());

		assertEquals("DEL_TOK", added.get(2).getName());
		assertEquals(0, added.get(2).getMaxAge(), "Explicit deletion must remain Max-Age=0");
	}

	@Test
	void startServerPushPassesConfiguredMaxTextMessageSizeToClient() throws Exception {
		String dtid = "dt-max-msg-size";
		org.zkoss.zk.ui.Desktop desktop = mock(org.zkoss.zk.ui.Desktop.class);
		when(desktop.getId()).thenReturn(dtid);
		when(desktop.getSession()).thenReturn(null);

		Field maxSizeField = ServerPushEndPoint.class.getDeclaredField("MAX_TEXT_MESSAGE_SIZE");
		maxSizeField.setAccessible(true);
		int expectedMaxSize = maxSizeField.getInt(null);

		org.zkoss.zk.ui.Execution mockExec = mock(org.zkoss.zk.ui.Execution.class);
		WebSocketServerPush spush = new WebSocketServerPush();
		try {
			try (org.mockito.MockedStatic<org.zkoss.zk.ui.Executions> executions =
					org.mockito.Mockito.mockStatic(org.zkoss.zk.ui.Executions.class)) {
				executions.when(org.zkoss.zk.ui.Executions::getCurrent).thenReturn(mockExec);
				spush.start(desktop);
			}

			ArgumentCaptor<org.zkoss.zk.au.AuResponse> responseCaptor =
					ArgumentCaptor.forClass(org.zkoss.zk.au.AuResponse.class);
			verify(mockExec).addAuResponse(
					org.mockito.ArgumentMatchers.eq("org.idempiere.websocket.serverpush.start"),
					responseCaptor.capture());
			Object[] rawData = responseCaptor.getValue().getRawData();
			assertNotNull(rawData);
			String script = String.valueOf(rawData[0]);
			assertTrue(script.contains("org.idempiere.websocket.startServerPush(\"" + dtid + "\", " + expectedMaxSize + ");"),
					"Start script must pass endpoint MAX_TEXT_MESSAGE_SIZE to browser, got: " + script);
		} finally {
			spush.stop();
		}
	}

	private static void setField(Object target, String name, Object value) throws Exception {
		Field field = ServerPushEndPoint.class.getDeclaredField(name);
		field.setAccessible(true);
		field.set(target, value);
	}
}