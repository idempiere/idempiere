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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.logging.Level;
import java.util.stream.Collectors;

import javax.net.ssl.SSLContext;
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
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
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
	private HttpSession httpSession;
	private String baseUrl;
	private Map<String, List<String>> requestHeaders;

	private static final ExecutorService executorService = Executors.newCachedThreadPool();

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
	            this.requestHeaders = handshakeRequest.getHeaders();
	            if (!this.requestHeaders.containsKey("X-Forwarded-For")) {
	            	Object ipAttr = config.getUserProperties().get(WebSocketServerPush.WS_CLIENT_IP);
	            	if (ipAttr != null) {
	            		String clientIp = ipAttr.toString();
	            		// handshakeRequest.getHeaders() might return unmodifiable map
	            		this.requestHeaders = new HashMap<>(this.requestHeaders);
	            		this.requestHeaders.put("X-Forwarded-For", List.of(clientIp));
	            	}
	            }
	        }
		}
	}

	@OnError
	public void onError(Session sess, Throwable throwable) {
		CLogger.getCLogger(getClass()).log(Level.WARNING, throwable.getMessage(), throwable);	
	}

	// Track the "tail" of the execution chain. Start with a completed future.
	private CompletableFuture<Void> executionChain = CompletableFuture.completedFuture(null);
	// Lock to protect the chain update (very short duration)
	private final Object chainLock = new Object();
		
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
				setMessageIndicator();
				
				StringBuilder fullUrl = new StringBuilder(this.baseUrl)
		        		.append(uri)
		        		.append("?")
		        		.append(content);

				String sessionId = null;
		        try {
					sessionId = httpSession.getId();
				} catch (IllegalStateException e) {
					CLogger.getCLogger(getClass()).log(Level.WARNING, "HTTP Session already invalidated", e);
					try {
						session.getBasicRemote().sendText("Error: Session invalidated");
					} catch (IOException ioe) {
						CLogger.getCLogger(getClass()).log(Level.WARNING, "Error sending response to client", ioe);
					}
					return;
				}
	
		        String jsessionidCookie = "JSESSIONID=" + sessionId;
	
		        synchronized (chainLock) {
			        try {
				        // Create POST request
				        HttpPost httpPost = new HttpPost(fullUrl.toString());
				        httpPost.setHeader("Content-Type", "application/json");
				        httpPost.setHeader("ZK-SID", sid);
				        httpPost.setHeader("Pragma", "no-cache");
				        httpPost.setHeader("Cache-Control", "no-cache");
				        httpPost.setHeader("Cookie", jsessionidCookie);
				        requestHeaders.forEach((key, values) -> {
				        	// Forward selected headers
				        	if ("User-Agent".equalsIgnoreCase(key) || "Accept-Language".equalsIgnoreCase(key) 
				        		|| "Accept-Encoding".equalsIgnoreCase(key)
				        		|| key.startsWith("X-")
				        		|| "Origin".equalsIgnoreCase(key)) {
				        		for (String value : values) {
				        			httpPost.addHeader(key, value);
				        		}
				        	}
				        });
				        httpPost.setConfig(org.apache.hc.client5.http.config.RequestConfig.custom()
				            .setResponseTimeout(Timeout.ofSeconds(30))
				            .build());
		
				        // Execute request asynchronously
				        executionChain = executionChain.thenRunAsync(() -> {
				        	try (var httpClient = createHttpClient(); CloseableHttpResponse response = httpClient.execute(httpPost)) {
					            String servletResponse = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);
					            
					            // Send servletResponse back to the client
								if (servletResponse != null && !servletResponse.isEmpty()) {
									if (response.getCode() >= 400) {
										CLogger.getCLogger(getClass()).log(Level.WARNING, "Bad Request to /zkau: " + servletResponse);
									}
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
									try {
										session.getBasicRemote().sendText(jsonResponse.toString());
									} catch (IOException e) {
										CLogger.getCLogger(getClass()).log(Level.WARNING, "Error sending response to client", e);
									}
								} else {
									try {
										session.getBasicRemote().sendText("Error: No response from /zkau");
									} catch (IOException e) {
										CLogger.getCLogger(getClass()).log(Level.WARNING, "Error sending response to client", e);
									}
								}
					        } catch (Throwable e) {
					        	CLogger.getCLogger(getClass()).log(Level.WARNING, "Error processing /zkau request", e);
					        }
				        }, executorService);
			        } catch (Throwable e) {
			        	CLogger.getCLogger(getClass()).log(Level.WARNING, "Error processing /zkau request", e);
			        }
		        }
			}
		}
	}

	// Disable SSL verification and host name verification for internal request
	private static final SSLContext sslContext = createSSLContext();

	private static SSLContext createSSLContext() {
		try {
			return SSLContextBuilder.create()
					.loadTrustMaterial(TrustAllStrategy.INSTANCE)
					.build();
		} catch (Exception e) {
			CLogger.getCLogger(ServerPushEndPoint.class).log(Level.SEVERE, "Failed to create SSLContext", e);
			return null;
		}
	}
	
	private static final SSLConnectionSocketFactory sslSocketFactory = createSSLSocketFactory();
	private static SSLConnectionSocketFactory createSSLSocketFactory() {
		return SSLConnectionSocketFactoryBuilder.create()
				.setSslContext(sslContext)
				.setHostnameVerifier(NoopHostnameVerifier.INSTANCE)
				.build();
	}
	
	private CloseableHttpClient createHttpClient() {
		try {
			HttpClientConnectionManager connectionManager = PoolingHttpClientConnectionManagerBuilder.create()
					.setSSLSocketFactory(sslSocketFactory)
					.build();

			return HttpClients.custom()
					.setConnectionManager(connectionManager)
					.build();
		} catch (Exception e) {
			throw new RuntimeException("Failed to initialize ServerPushEndPoint HttpClient", e);
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

    private final AtomicBoolean messageIndicator = new AtomicBoolean(false);

    private void setMessageIndicator() {
		messageIndicator.set(true);
	}

	public boolean getAndResetMessageIndicator() {
		return messageIndicator.getAndSet(false);
	}
}
