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

import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Map;
import java.util.logging.Level;
import java.util.stream.Collectors;

import javax.net.ssl.SSLContext;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManagerBuilder;
import org.apache.hc.client5.http.io.HttpClientConnectionManager;
import org.apache.hc.client5.http.ssl.NoopHostnameVerifier;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactoryBuilder;
import org.apache.hc.client5.http.ssl.TrustAllStrategy;
import org.apache.hc.core5.http.Header;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.ssl.SSLContextBuilder;
import org.apache.hc.core5.util.Timeout;
import org.compiere.util.CLogger;
import org.compiere.util.Util;
import org.zkoss.json.JSONObject;
import org.zkoss.json.parser.JSONParser;

/**
 * web socket end point for server push
 * @author hengsin
 */
@ServerEndpoint(value="/serverpush/{dtid}", configurator = EndpointConfigurator.class)
public class ServerPushEndPoint {

	private Session session;
	private String dtid;
	@SuppressWarnings("unused")
	private ServletContext servletContext;
	private HttpSession httpSession;
	private String baseUrl;

	/**
	 * default constructor
	 */
	public ServerPushEndPoint() {
	}
	
	@OnClose
	public void onClose(Session sess) throws IOException {
		if (this.session != null) {
			this.session = null;
			WebSocketServerPush.unregisterEndPoint(dtid);
		}
	}

	@OnOpen
	public void onOpen(Session sess, EndpointConfig config, @PathParam("dtid") String dtid) throws IOException {
		if (!Util.isEmpty(dtid, true) && WebSocketServerPush.isValidDesktopId(dtid)) {			
			session = sess;
			this.dtid = dtid;
			this.servletContext = (ServletContext) config.getUserProperties().get(ServletContext.class.getName());
			this.httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
			WebSocketServerPush.registerEndPoint(dtid, this);
			
			HandshakeRequest handshakeRequest = (HandshakeRequest) config.getUserProperties().get(HandshakeRequest.class.getName());

			// Build the Base URL dynamically
	        if (handshakeRequest != null) {
	            URI requestUri = handshakeRequest.getRequestURI();

	            // Map ws -> http and wss -> https
	            String scheme = "wss".equalsIgnoreCase(requestUri.getScheme()) || "https".equalsIgnoreCase(requestUri.getScheme()) ? "https" : "http";
	            String host = "localhost";
	            int port = requestUri.getPort();

	            // Construct the base URL, handling default ports
	            StringBuilder urlBuilder = new StringBuilder();
	            urlBuilder.append(scheme).append("://").append(host);
	            if (port != -1 && !((scheme.equals("http") && port == 80) || (scheme.equals("https") && port == 443))) {
	                urlBuilder.append(":").append(port);
	            }
	            this.baseUrl = urlBuilder.toString();	            
	        }
		}
	}

	@OnError
	public void onError(Session sess, Throwable throwable) {
		CLogger.getCLogger(getClass()).log(Level.WARNING, throwable.getMessage(), throwable);	
	}

	/**
	 * Handle ping from client
	 * @param session
	 * @param message
	 */
	@OnMessage
	public void onMessage(Session session, String message) { 
		if (session == this.session && !Util.isEmpty(message)) {
			if (message.equals("__ping__")) {
				try {
					session.getBasicRemote().sendText("__pong__");
				} catch (IllegalArgumentException | IOException e) {
					CLogger.getCLogger(getClass()).log(Level.WARNING, e.getMessage(), e);
				}
			} else if (message.startsWith("zkau;")) {
				String jsonMessage = message.substring(5);
				JSONParser parser = new JSONParser();
				JSONObject jsonRequest = (JSONObject) parser.parse(jsonMessage);
				String sid = jsonRequest.get("sid").toString();
				String uri = (String) jsonRequest.get("uri");
				String content = (String) jsonRequest.get("content");
				String dtid = jsonRequest.get("dt").toString();
				if (dtid == null || !dtid.equals(this.dtid)) {
					try {
						session.getBasicRemote().sendText("Error: Invalid desktop id");
					} catch (IOException e) {
						CLogger.getCLogger(getClass()).log(Level.WARNING, e.getMessage(), e);
					}
					return;
				}
				
				StringBuilder fullUrl = new StringBuilder(this.baseUrl)
		        		.append(uri)
		        		.append("?")
		        		.append(content);
		        String sessionId = httpSession.getId();
		        String jsessionidCookie = "JSESSIONID=" + sessionId;

		        try {
			        // Disable SSL verification and host name verification for internal request
			        SSLContext sslContext = SSLContextBuilder.create()
			            .loadTrustMaterial(TrustAllStrategy.INSTANCE)
			            .build();
	
			        HttpClientConnectionManager connectionManager = PoolingHttpClientConnectionManagerBuilder.create()
			            .setSSLSocketFactory(SSLConnectionSocketFactoryBuilder.create()
			                .setSslContext(sslContext)
			                .setHostnameVerifier(NoopHostnameVerifier.INSTANCE)
			                .build())
			            .build();
	
			        CloseableHttpClient client = HttpClients.custom()
			            .setConnectionManager(connectionManager)
			            .build();
	
			        // Create POST request
			        HttpPost httpPost = new HttpPost(fullUrl.toString());
			        httpPost.setHeader("Content-Type", "application/json");
			        httpPost.setHeader("ZK-SID", sid);
			        httpPost.setHeader("Cookie", jsessionidCookie);
			        httpPost.setConfig(org.apache.hc.client5.http.config.RequestConfig.custom()
			            .setResponseTimeout(Timeout.ofSeconds(30))
			            .build());
	
			        // Execute request
			        try (CloseableHttpResponse response = client.execute(httpPost)) {
			            String servletResponse = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);
			            
			            // Send servletResponse back to the client
						if (servletResponse != null && !servletResponse.isEmpty()) {
							Map<String, String> headersMap = Arrays.stream(response.getHeaders())
							        .collect(Collectors.toMap(
							            Header::getName,
							            Header::getValue,
							            (existing, replacement) -> existing + ", " + replacement // Handle duplicate headers
							        ));
							JSONObject jsonResponse = new JSONObject();
							jsonResponse.put("headers", headersMap);
							jsonResponse.put("status", response.getCode());
							jsonResponse.put("responseText", servletResponse);
							jsonResponse.put("ajaxReqInf", jsonRequest);
							session.getBasicRemote().sendText(jsonResponse.toString());
						} else {
							session.getBasicRemote().sendText("Error: No response from /zkau");
						}
					}
		        } catch (Exception e) {
		        	CLogger.getCLogger(getClass()).log(Level.WARNING, "Error processing /zkau request", e);
		        }
			}
		}
	}

	/**
	 * Message client to send echo event to server
	 */
	public void echo() {
		if (session != null) {
			try {				
				session.getBasicRemote().sendText("echo");
			} catch (IOException e) {
				CLogger.getCLogger(getClass()).log(Level.WARNING, e.getMessage(), e);
			}
		}
	}	
}
