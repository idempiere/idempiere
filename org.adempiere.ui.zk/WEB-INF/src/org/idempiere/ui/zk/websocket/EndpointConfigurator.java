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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.ui.zk.websocket;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

import org.apache.hc.client5.http.cookie.BasicCookieStore;
import org.apache.hc.client5.http.impl.cookie.BasicClientCookie;

public class EndpointConfigurator extends ServerEndpointConfig.Configurator {

	protected static final String WS_ORIGIN_VALID = "ws-origin-valid";

	/**
	 * Find all header values matching {@code headerName} case-insensitively.
	 *
	 * @param headers HTTP header map
	 * @param headerName header name to look up
	 * @return matching header values, or {@code null} when absent
	 */
	static List<String> getHeaderValuesIgnoreCase(Map<String, List<String>> headers, String headerName) {
		if (headers == null || headerName == null)
			return null;
		List<String> exact = headers.get(headerName);
		if (exact != null)
			return exact;
		for (Map.Entry<String, List<String>> entry : headers.entrySet()) {
			if (entry.getKey() != null && entry.getKey().equalsIgnoreCase(headerName))
				return entry.getValue();
		}
		return null;
	}

	/**
	 * Get the first non-blank header value matching {@code headerName} case-insensitively.
	 *
	 * @param headers HTTP header map
	 * @param headerName header name to look up
	 * @return first non-blank value, or {@code null}
	 */
	static String getFirstHeaderIgnoreCase(Map<String, List<String>> headers, String headerName) {
		List<String> values = getHeaderValuesIgnoreCase(headers, headerName);
		if (values != null) {
			for (String value : values) {
				if (value != null && !value.isBlank())
					return value.trim();
			}
		}
		return null;
	}

	/**
	 * Validate the WebSocket handshake {@code Origin} header against the full public
	 * request origin (scheme, host, and effective port) to prevent Cross-Site WebSocket
	 * Hijacking (CSWSH).
	 * <p>
	 * The target origin is resolved from {@link HandshakeRequest#getRequestURI()}, which
	 * Jetty's {@code ForwardedRequestCustomizer} already normalizes for trusted reverse
	 * proxies. Unverified {@code X-Forwarded-*} headers are not trusted directly here.
	 *
	 * @param request WebSocket handshake request
	 * @return {@code true} if the origin is absent or matches the public request origin
	 */
	static boolean isValidOrigin(HandshakeRequest request) {
		if (request == null)
			return false;
		Map<String, List<String>> headers = request.getHeaders();
		String origin = getFirstHeaderIgnoreCase(headers, "Origin");
		if (origin == null)
			return true;
		if ("null".equalsIgnoreCase(origin))
			return false;

		URI originUri;
		try {
			originUri = URI.create(origin);
		} catch (IllegalArgumentException e) {
			return false;
		}
		String originScheme = normalizeHttpScheme(originUri.getScheme());
		String originHost = originUri.getHost();
		int rawOriginPort = originUri.getPort();
		if (originScheme == null || originHost == null || originHost.isBlank()
				|| !isValidPort(rawOriginPort)
				|| originUri.getUserInfo() != null
				|| (originUri.getRawPath() != null && !originUri.getRawPath().isEmpty())
				|| originUri.getRawQuery() != null
				|| originUri.getRawFragment() != null) {
			return false;
		}
		int originPort = effectivePort(originScheme, rawOriginPort);

		URI requestUri = request.getRequestURI();
		String targetScheme = normalizeRequestScheme(requestUri != null ? requestUri.getScheme() : null);
		if (targetScheme == null)
			return false;

		String targetHost = requestUri.getHost();
		int rawTargetPort = requestUri.getPort();
		if (targetHost == null || targetHost.isBlank()) {
			String hostHeader = getFirstHeaderIgnoreCase(headers, "Host");
			URI hostUri = parseAuthority(targetScheme, hostHeader);
			if (hostUri == null)
				return false;
			targetHost = hostUri.getHost();
			rawTargetPort = hostUri.getPort();
		}
		if (!isValidPort(rawTargetPort))
			return false;

		return originScheme.equals(targetScheme)
				&& originHost.equalsIgnoreCase(targetHost)
				&& originPort == effectivePort(targetScheme, rawTargetPort);
	}

	private static String normalizeHttpScheme(String scheme) {
		if ("http".equalsIgnoreCase(scheme))
			return "http";
		if ("https".equalsIgnoreCase(scheme))
			return "https";
		return null;
	}

	private static String normalizeRequestScheme(String scheme) {
		if ("http".equalsIgnoreCase(scheme) || "ws".equalsIgnoreCase(scheme))
			return "http";
		if ("https".equalsIgnoreCase(scheme) || "wss".equalsIgnoreCase(scheme))
			return "https";
		return null;
	}

	private static URI parseAuthority(String scheme, String authority) {
		if (scheme == null || authority == null || authority.isBlank())
			return null;
		try {
			URI uri = URI.create(scheme + "://" + authority);
			if (uri.getHost() == null || uri.getHost().isBlank()
					|| !isValidPort(uri.getPort())
					|| uri.getUserInfo() != null
					|| (uri.getRawPath() != null && !uri.getRawPath().isEmpty())
					|| uri.getRawQuery() != null
					|| uri.getRawFragment() != null) {
				return null;
			}
			return uri;
		} catch (IllegalArgumentException e) {
			return null;
		}
	}

	private static boolean isValidPort(int port) {
		return port == -1 || (port > 0 && port <= 65535);
	}

	private static int effectivePort(String scheme, int port) {
		if (port > 0)
			return port;
		return ("https".equalsIgnoreCase(scheme) || "wss".equalsIgnoreCase(scheme)) ? 443 : 80;
	}

	/**
	 * Resolve the node-local HTTP base URI used to forward WebSocket events.
	 *
	 * @param httpSession HTTP session containing the per-desktop connector URI
	 * @param request WebSocket handshake request
	 * @return node-local base URI, or a localhost compatibility URI
	 */
	static URI getInternalBaseUri(HttpSession httpSession, HandshakeRequest request) {
		URI requestUri = request != null ? request.getRequestURI() : null;
		if (httpSession != null && requestUri != null) {
			String path = requestUri.getPath();
			int separator = path != null ? path.lastIndexOf('/') : -1;
			if (separator >= 0 && separator + 1 < path.length()) {
				String desktopId = path.substring(separator + 1);
				try {
					Object value = httpSession.getAttribute(WebSocketServerPush.getLocalBaseUrlAttribute(desktopId));
					if (value instanceof String localBaseUrl) {
						URI uri = URI.create(localBaseUrl);
						int port = uri.getPort();
						if (("http".equals(uri.getScheme()) || "https".equals(uri.getScheme()))
								&& uri.getHost() != null && (port == -1 || port > 0))
							return uri;
					}
				} catch (IllegalArgumentException | IllegalStateException e) {
					// Ignore invalid or expired session data and use the compatibility fallback below.
				}
			}
		}

		// Compatibility fallback for desktops created before this code was deployed.
		String scheme = requestUri != null && ("wss".equalsIgnoreCase(requestUri.getScheme())
				|| "https".equalsIgnoreCase(requestUri.getScheme())) ? "https" : "http";
		int port = requestUri != null ? requestUri.getPort() : -1;
		try {
			return new URI(scheme, null, "localhost", port, null, null, null);
		} catch (URISyntaxException e) {
			throw new IllegalArgumentException("Unable to build the internal server push URL", e);
		}
	}

	/** {@inheritDoc} */
	@Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        sec.getUserProperties().put(WS_ORIGIN_VALID, Boolean.valueOf(isValidOrigin(request)));

        // Store the ServletContext, HttpSession and remote address in user properties for the ServerPushEndPoint to access
        HttpSession httpSession = (HttpSession) request.getHttpSession();
        if (httpSession != null) {
        	try {
	        	Object ipAttr = httpSession.getAttribute(WebSocketServerPush.WS_CLIENT_IP);
	        	if (ipAttr != null) {
	        		// Keep WS_CLIENT_IP on the session so reconnects and additional tabs can also read it.
	        		sec.getUserProperties().put(WebSocketServerPush.WS_CLIENT_IP, ipAttr.toString());
	        	}
	            sec.getUserProperties().put(HttpSession.class.getName(), httpSession);
	            sec.getUserProperties().put(ServletContext.class.getName(), httpSession.getServletContext());
	            sec.getUserProperties().put(HandshakeRequest.class.getName(), request);
				URI internalBaseUri = getInternalBaseUri(httpSession, request);
				sec.getUserProperties().put(WebSocketServerPush.WS_LOCAL_BASE_URL, internalBaseUri);

	            //create BasicCookieStore from request
	            Map<String, List<String>> headers = request.getHeaders();
	            List<String> cookieHeaders = getHeaderValuesIgnoreCase(headers, "Cookie");
	            if (cookieHeaders != null && !cookieHeaders.isEmpty()) {
	            	BasicCookieStore cookieStore = new BasicCookieStore();
		            String requestHost = internalBaseUri.getHost();
	            	for (String cookieHeader : cookieHeaders) {
	            		if (cookieHeader == null || cookieHeader.isBlank())
	            			continue;
	            		String[] cookies = cookieHeader.split(";");
	                    for (String cookie : cookies) {
	                        String[] pair = cookie.split("=", 2);
	                        if (pair.length == 2) {
	                        	String name = pair[0].trim();
	                        	String value = pair[1].trim();
	                        	if (!name.isEmpty()) {
		                        	BasicClientCookie c = new BasicClientCookie(name, value);
			                        c.setDomain(requestHost);
			                        c.setPath("/");
		                        	cookieStore.addCookie(c);
	                        	}
	                        }
	                    }
	            	}
	            	sec.getUserProperties().put(BasicCookieStore.class.getName(), cookieStore);
	            }
        	} catch (IllegalStateException e) {
        		// Session invalidated concurrently during handshake; onOpen will reject the connection.
        	}
        }
    }
}
