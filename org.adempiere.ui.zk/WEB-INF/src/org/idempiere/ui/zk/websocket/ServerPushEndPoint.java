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
import java.net.SocketTimeoutException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Level;

import javax.net.ssl.SSLContext;
import javax.servlet.ServletContext;
import javax.servlet.SessionCookieConfig;
import javax.servlet.http.HttpSession;
import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.apache.hc.client5.http.ConnectTimeoutException;
import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.client5.http.cookie.BasicCookieStore;
import org.apache.hc.client5.http.cookie.Cookie;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.cookie.BasicClientCookie;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManager;
import org.apache.hc.client5.http.socket.ConnectionSocketFactory;
import org.apache.hc.client5.http.socket.PlainConnectionSocketFactory;
import org.apache.hc.client5.http.ssl.NoopHostnameVerifier;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactoryBuilder;
import org.apache.hc.client5.http.ssl.TrustAllStrategy;
import org.apache.hc.client5.http.utils.DateUtils;
import org.apache.hc.core5.http.ContentType;
import org.apache.hc.core5.http.Header;
import org.apache.hc.core5.http.HttpEntity;
import org.apache.hc.core5.http.config.RegistryBuilder;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.http.io.entity.StringEntity;
import org.apache.hc.core5.ssl.SSLContextBuilder;
import org.apache.hc.core5.util.TimeValue;
import org.apache.hc.core5.util.Timeout;
import org.compiere.util.CLogger;
import org.compiere.util.Util;
import org.idempiere.ui.zk.websocket.WebSocketServerPush.PendingBrowserCookie;
import org.zkoss.json.JSONObject;
import org.zkoss.json.parser.JSONParser;

/**
 * web socket end point for server push
 * @author hengsin
 */
@ServerEndpoint(value="/serverpush/{dtid}", configurator = EndpointConfigurator.class)
public class ServerPushEndPoint {

	private static final CLogger log = CLogger.getCLogger(ServerPushEndPoint.class);

	private static final int MAX_CONNECTIONS = Math.max(16,
			Integer.getInteger("org.idempiere.ui.zk.websocket.maxConnections", 200));
	private static final int MAX_THREADS = Math.max(16,
			Integer.getInteger("org.idempiere.ui.zk.websocket.maxThreads", 200));
	private static final int MAX_PENDING_REQUESTS = Math.max(5,
			Integer.getInteger("org.idempiere.ui.zk.websocket.maxPendingRequests", 50));
	private static final int MAX_TEXT_MESSAGE_SIZE = Math.max(64 * 1024,
			Integer.getInteger("org.idempiere.ui.zk.websocket.maxTextMessageSize", 4 * 1024 * 1024));
	private static final long MAX_IDLE_TIMEOUT_MS = Math.max(30_000L,
			Long.getLong("org.idempiere.ui.zk.websocket.maxIdleTimeout", 90_000L));
	private static final long RESPONSE_TIMEOUT_MS = Math.max(10_000L,
			Long.getLong("org.idempiere.ui.zk.websocket.responseTimeout", 600_000L));

	/** Allowlist of handshake headers safe to forward to the internal /zkau servlet. */
	private static final Set<String> ALLOWED_FORWARD_HEADERS = Set.of(
			"user-agent",
			"accept-language",
			"origin",
			"x-forwarded-for",
			"x-real-ip",
			"x-forwarded-proto",
			"x-forwarded-host"
	);

	private static final RequestConfig AU_REQUEST_CONFIG = createRequestConfig(RESPONSE_TIMEOUT_MS);

	private static RequestConfig createRequestConfig(long responseTimeoutMs) {
		return RequestConfig.custom()
				.setConnectTimeout(Timeout.ofSeconds(10))
				.setConnectionRequestTimeout(Timeout.ofSeconds(30))
				.setResponseTimeout(Timeout.ofMilliseconds(responseTimeoutMs))
				.build();
	}

	private static final Object SHARED_RESOURCE_LOCK = new Object();
	private static volatile ExecutorService executorService;
	private static volatile CloseableHttpClient sharedHttpClient;
	private static final AtomicInteger WORKER_THREAD_COUNTER = new AtomicInteger(0);

	private volatile Session session;
	private final Object sendLock = new Object();
	private String dtid;
	private HttpSession httpSession;
	private URI internalBaseUri;
	private String contextPath = "";
	private String sessionCookieName = "WEBUI_SESSIONID";
	private String requestHost;
	private Map<String, List<String>> forwardedHeaders = Collections.emptyMap();
	private BasicCookieStore cookieStore;
	private volatile String lastSessionId;
	private final AtomicInteger pendingRequests = new AtomicInteger(0);
	private volatile boolean closeRequested = false;
	private RequestConfig auRequestConfig = AU_REQUEST_CONFIG;
	private Executor auExecutor;

	/**
	 * default constructor
	 */
	public ServerPushEndPoint() {
	}

	/**
	 * Queue that prefers scaling worker threads up to {@code maximumPoolSize} when all active
	 * workers are busy, falling back to bounded queueing once the maximum pool size is reached.
	 */
	private static final class ScalingTaskQueue extends LinkedBlockingQueue<Runnable> {
		private static final long serialVersionUID = 1L;
		private volatile ScalingThreadPoolExecutor executor;

		ScalingTaskQueue(int capacity) {
			super(capacity);
		}

		void setExecutor(ScalingThreadPoolExecutor executor) {
			this.executor = executor;
		}

		@Override
		public boolean offer(Runnable o) {
			ScalingThreadPoolExecutor exec = this.executor;
			if (exec == null) {
				return super.offer(o);
			}
			int currentPoolSize = exec.getPoolSize();
			if (currentPoolSize < exec.getMaximumPoolSize() && exec.getSubmittedCount() > currentPoolSize) {
				return false;
			}
			return super.offer(o);
		}

		boolean forceOffer(Runnable o) {
			return super.offer(o);
		}
	}

	private static final class ScalingThreadPoolExecutor extends ThreadPoolExecutor {
		private final AtomicInteger submittedCount = new AtomicInteger(0);

		ScalingThreadPoolExecutor(int corePoolSize, int maximumPoolSize, long keepAliveTime,
				TimeUnit unit, ScalingTaskQueue workQueue, ThreadFactory threadFactory) {
			super(corePoolSize, maximumPoolSize, keepAliveTime, unit, workQueue, threadFactory,
					(r, e) -> {
						if (!e.isShutdown() && workQueue.forceOffer(r)) {
							if (e.isShutdown() && workQueue.remove(r)) {
								throw new RejectedExecutionException("WebSocket AU executor is shut down");
							}
							if (e.getPoolSize() == 0) {
								e.prestartCoreThread();
							}
							return;
						}
						throw new RejectedExecutionException("WebSocket AU worker queue full");
					});
			workQueue.setExecutor(this);
		}

		int getSubmittedCount() {
			return submittedCount.get();
		}

		@Override
		public void execute(Runnable command) {
			Objects.requireNonNull(command);
			submittedCount.incrementAndGet();
			try {
				super.execute(command);
			} catch (RuntimeException | Error e) {
				submittedCount.decrementAndGet();
				throw e;
			}
		}

		@Override
		protected void afterExecute(Runnable r, Throwable t) {
			submittedCount.decrementAndGet();
			super.afterExecute(r, t);
		}
	}

	private static ThreadPoolExecutor createExecutorService(int coreThreads, int maxThreads) {
		ThreadFactory factory = r -> {
			Thread t = new Thread(r, "ws-au-worker-" + WORKER_THREAD_COUNTER.incrementAndGet());
			t.setDaemon(true);
			return t;
		};
		ScalingTaskQueue queue = new ScalingTaskQueue(1000);
		ScalingThreadPoolExecutor pool = new ScalingThreadPoolExecutor(
				coreThreads,
				maxThreads,
				60L,
				TimeUnit.SECONDS,
				queue,
				factory);
		pool.allowCoreThreadTimeOut(true);
		return pool;
	}

	private static ExecutorService getExecutorService() {
		ExecutorService current = executorService;
		if (current == null || current.isShutdown()) {
			synchronized (SHARED_RESOURCE_LOCK) {
				current = executorService;
				if (current == null || current.isShutdown()) {
					int coreThreads = Math.min(MAX_THREADS,
							Math.max(8, Runtime.getRuntime().availableProcessors() * 2));
					ThreadPoolExecutor pool = createExecutorService(coreThreads, MAX_THREADS);
					executorService = pool;
					current = pool;
				}
			}
		}
		return current;
	}

	private Executor getAuExecutor() {
		Executor override = this.auExecutor;
		return override != null ? override : getExecutorService();
	}

	private void releasePendingSlot(AtomicBoolean slotReleased) {
		if (slotReleased.compareAndSet(false, true)) {
			if (pendingRequests.decrementAndGet() == 0 && closeRequested) {
				closeNow();
			}
		}
	}

	private static CloseableHttpClient getHttpClient() {
		CloseableHttpClient current = sharedHttpClient;
		if (current == null) {
			synchronized (SHARED_RESOURCE_LOCK) {
				current = sharedHttpClient;
				if (current == null) {
					PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager(
							RegistryBuilder.<ConnectionSocketFactory>create()
									.register("http", PlainConnectionSocketFactory.getSocketFactory())
									.register("https", sslSocketFactory)
									.build());
					connectionManager.setMaxTotal(MAX_CONNECTIONS);
					connectionManager.setDefaultMaxPerRoute(MAX_CONNECTIONS);
					connectionManager.setValidateAfterInactivity(TimeValue.ofSeconds(5));

					current = HttpClients.custom()
							.setConnectionManager(connectionManager)
							.disableAutomaticRetries()
							.disableCookieManagement()
							.disableRedirectHandling()
							.disableContentCompression()
							.evictExpiredConnections()
							.evictIdleConnections(TimeValue.ofSeconds(30))
							.build();
					sharedHttpClient = current;
				}
			}
		}
		return current;
	}

	/**
	 * Shut down shared worker threads and HTTP connection pool when the bundle stops.
	 */
	public static void shutdown() {
		synchronized (SHARED_RESOURCE_LOCK) {
			if (executorService != null) {
				executorService.shutdown();
				executorService = null;
			}
			if (sharedHttpClient != null) {
				try {
					sharedHttpClient.close();
				} catch (IOException e) {
					log.log(Level.WARNING, "Error closing shared WebSocket HttpClient", e);
				}
				sharedHttpClient = null;
			}
		}
	}

	/**
	 * Send a text frame on the WebSocket session using a per-endpoint lock so concurrent
	 * sends from I/O, AU worker, and server-push threads never violate JSR-356 threading rules.
	 *
	 * @param targetSession expected WebSocket session
	 * @param text payload to send
	 * @return {@code true} if the message was sent
	 */
	private boolean sendText(Session targetSession, String text) {
		if (targetSession == null || text == null)
			return false;
		synchronized (sendLock) {
			if (targetSession != this.session)
				return false;
			try {
				targetSession.getBasicRemote().sendText(text);
				return true;
			} catch (IOException | IllegalStateException | IllegalArgumentException e) {
				log.log(Level.WARNING, "Error sending response to client", e);
				return false;
			}
		}
	}

	/**
	 * Close the underlying WebSocket session once any in-flight AU requests finish
	 * delivering their responses (for example, a logout redirect response). Closes
	 * immediately when no AU requests are in flight.
	 */
	public void close() {
		closeRequested = true;
		if (pendingRequests.get() == 0) {
			closeNow();
		}
	}

	private void closeNow() {
		Session current;
		synchronized (sendLock) {
			current = this.session;
			this.session = null;
		}
		if (current != null) {
			try {
				if (current.isOpen()) {
					current.close(new CloseReason(CloseReason.CloseCodes.NORMAL_CLOSURE, "Server push stopped"));
				}
			} catch (IOException | IllegalStateException e) {
				log.log(Level.FINE, "Error closing WebSocket session", e);
			}
		}
	}

	private void closeWithReason(Session targetSession, CloseReason.CloseCode code, String reason) {
		Session current;
		synchronized (sendLock) {
			if (targetSession != this.session)
				return;
			current = this.session;
			this.session = null;
		}
		if (current != null) {
			WebSocketServerPush.unregisterEndPoint(dtid, this);
			try {
				if (current.isOpen()) {
					current.close(new CloseReason(code, reason));
				}
			} catch (IOException | IllegalStateException e) {
				log.log(Level.FINE, "Error closing WebSocket session", e);
			}
		}
	}
	
	/**
	 * Unregister this endpoint when its WebSocket session closes.
	 *
	 * @param sess WebSocket session
	 * @throws IOException if closing the endpoint fails
	 */
	@OnClose
	public void onClose(Session sess) throws IOException {
		boolean shouldUnregister = false;
		synchronized (sendLock) {
			if (this.session != null && (sess == null || this.session == sess)) {
				this.session = null;
				shouldUnregister = true;
			}
		}
		if (shouldUnregister) {
			WebSocketServerPush.unregisterEndPoint(dtid, this);
		}
	}

	/**
	 * Initialize the endpoint with the node-local connector URI captured for the desktop.
	 *
	 * @param sess WebSocket session
	 * @param config endpoint configuration populated during the handshake
	 * @param dtid ZK desktop identifier
	 * @throws IOException if endpoint initialization fails
	 */
	@OnOpen
	public void onOpen(Session sess, EndpointConfig config, @PathParam("dtid") String dtid) throws IOException {
		Map<String, Object> userProps = config != null ? config.getUserProperties() : Collections.emptyMap();
		Object originValid = userProps.get(EndpointConfigurator.WS_ORIGIN_VALID);
		HttpSession handshakeHttpSession = (HttpSession) userProps.get(HttpSession.class.getName());

		if (Util.isEmpty(dtid, true)
				|| !Boolean.TRUE.equals(originValid)
				|| !WebSocketServerPush.isValidDesktopId(dtid, handshakeHttpSession)) {
			log.warning("Rejecting unauthorized WebSocket server push connection");
			if (sess != null) {
				try {
					sess.close(new CloseReason(CloseReason.CloseCodes.VIOLATED_POLICY, "Unauthorized WebSocket connection"));
				} catch (IOException | IllegalStateException e) {
					log.log(Level.FINE, "Error closing rejected WebSocket session", e);
				}
			}
			return;
		}

		sess.setMaxTextMessageBufferSize(MAX_TEXT_MESSAGE_SIZE);
		sess.setMaxIdleTimeout(MAX_IDLE_TIMEOUT_MS);

		this.dtid = dtid;
		this.httpSession = handshakeHttpSession;
		this.cookieStore = (BasicCookieStore) userProps.get(BasicCookieStore.class.getName());
		if (this.cookieStore == null) {
			this.cookieStore = new BasicCookieStore();
		}

		ServletContext servletContext = (ServletContext) userProps.get(ServletContext.class.getName());
		if (servletContext != null) {
			String ctxPath = servletContext.getContextPath();
			this.contextPath = ctxPath != null ? ctxPath : "";
			this.sessionCookieName = resolveSessionCookieName(servletContext);
		}

		HandshakeRequest handshakeRequest = (HandshakeRequest) userProps.get(HandshakeRequest.class.getName());
		if (Util.isEmpty(this.contextPath, true) && handshakeRequest != null && handshakeRequest.getRequestURI() != null) {
			String reqPath = handshakeRequest.getRequestURI().getPath();
			int spIdx = reqPath != null ? reqPath.indexOf("/serverpush/") : -1;
			if (spIdx > 0) {
				this.contextPath = reqPath.substring(0, spIdx);
			}
		}
		URI resolvedBaseUri = (URI) userProps.get(WebSocketServerPush.WS_LOCAL_BASE_URL);
		if (resolvedBaseUri == null && handshakeRequest != null) {
			resolvedBaseUri = EndpointConfigurator.getInternalBaseUri(httpSession, handshakeRequest);
		}
		if (resolvedBaseUri != null) {
			this.internalBaseUri = resolvedBaseUri;
			this.requestHost = resolvedBaseUri.getHost();
		}

		if (handshakeRequest != null) {
			Map<String, List<String>> filtered = new LinkedHashMap<>();
			Map<String, List<String>> rawHeaders = handshakeRequest.getHeaders();
			boolean hasForwardedFor = false;
			if (rawHeaders != null) {
				for (Map.Entry<String, List<String>> entry : rawHeaders.entrySet()) {
					String key = entry.getKey();
					List<String> values = entry.getValue();
					if (key == null || values == null || values.isEmpty())
						continue;
					String lower = key.toLowerCase(Locale.ROOT);
					if (ALLOWED_FORWARD_HEADERS.contains(lower)) {
						filtered.put(key, List.copyOf(values));
						if ("x-forwarded-for".equals(lower)) {
							hasForwardedFor = true;
						}
					}
				}
			}
			if (!hasForwardedFor) {
				Object ipAttr = userProps.get(WebSocketServerPush.WS_CLIENT_IP);
				if (ipAttr != null && !ipAttr.toString().isBlank()) {
					filtered.put("X-Forwarded-For", List.of(ipAttr.toString()));
				}
			}
			this.forwardedHeaders = Collections.unmodifiableMap(filtered);
		}

		this.session = sess;
		if (!WebSocketServerPush.registerEndPointIfValid(dtid, handshakeHttpSession, this)) {
			this.session = null;
			log.warning("Rejecting WebSocket server push connection for stopped desktop");
			try {
				sess.close(new CloseReason(CloseReason.CloseCodes.VIOLATED_POLICY, "Unauthorized WebSocket connection"));
			} catch (IOException | IllegalStateException e) {
				log.log(Level.FINE, "Error closing rejected WebSocket session", e);
			}
		}
	}

	private static String resolveSessionCookieName(ServletContext servletContext) {
		SessionCookieConfig cookieConfig = servletContext.getSessionCookieConfig();
		if (cookieConfig != null && !Util.isEmpty(cookieConfig.getName(), true))
			return cookieConfig.getName().trim();
		String jetty12Cookie = servletContext.getInitParameter("org.eclipse.jetty.session.SessionCookie");
		if (!Util.isEmpty(jetty12Cookie, true))
			return jetty12Cookie.trim();
		String jettyLegacyCookie = servletContext.getInitParameter("org.eclipse.jetty.servlet.SessionCookie");
		if (!Util.isEmpty(jettyLegacyCookie, true))
			return jettyLegacyCookie.trim();
		return "WEBUI_SESSIONID";
	}

	/**
	 * Validate and resolve the client-supplied AU URI against {@link #internalBaseUri}
	 * and the web application's {@code /zkau} servlet path to prevent SSRF and internal
	 * path traversal.
	 *
	 * @param uri client-supplied URI string
	 * @return validated absolute target URI on the node-local connector, or {@code null} if invalid
	 */
	URI resolveAuUri(String uri) {
		if (internalBaseUri == null || Util.isEmpty(uri, true))
			return null;
		if (uri.indexOf('\r') >= 0 || uri.indexOf('\n') >= 0)
			return null;
		if (!uri.startsWith("/") || uri.startsWith("//"))
			return null;

		URI parsed;
		try {
			parsed = new URI(uri);
		} catch (URISyntaxException e) {
			return null;
		}
		if (parsed.getScheme() != null || parsed.getRawAuthority() != null
				|| parsed.getHost() != null || parsed.getRawUserInfo() != null) {
			return null;
		}
		String rawPath = parsed.getRawPath();
		if (rawPath == null)
			return null;
		String lowerRawPath = rawPath.toLowerCase(Locale.ROOT);
		if (lowerRawPath.contains("%2e") || lowerRawPath.contains("%2f") || lowerRawPath.contains("%5c")
				|| lowerRawPath.contains("%3b") || rawPath.indexOf('\\') >= 0) {
			return null;
		}

		// Validate every path segment after stripping servlet matrix parameters (e.g. ;jsessionid=...)
		// so container-level traversal tricks like /..;foo=/ are rejected while allowing standard
		// URL-encoded session parameters such as /webui/zkau;jsessionid=...
		String[] segments = rawPath.split("/", -1);
		StringBuilder canonicalPathBuilder = new StringBuilder();
		for (int i = 1; i < segments.length; i++) {
			String segment = segments[i];
			int semicolon = segment.indexOf(';');
			if (semicolon >= 0 && i < segments.length - 1) {
				// Matrix parameters are only expected on the final path segment.
				return null;
			}
			String segmentName = semicolon >= 0 ? segment.substring(0, semicolon) : segment;
			if (".".equals(segmentName) || "..".equals(segmentName)) {
				return null;
			}
			canonicalPathBuilder.append('/').append(segmentName);
		}
		String canonicalPath = canonicalPathBuilder.toString();

		URI resolved = internalBaseUri.resolve(parsed).normalize();
		if (!Objects.equals(internalBaseUri.getScheme(), resolved.getScheme())
				|| !Objects.equals(internalBaseUri.getHost(), resolved.getHost())
				|| internalBaseUri.getPort() != resolved.getPort()
				|| resolved.getRawUserInfo() != null) {
			return null;
		}

		String baseCtx = contextPath != null ? contextPath.trim() : "";
		if (!baseCtx.isEmpty() && !baseCtx.startsWith("/")) {
			baseCtx = "/" + baseCtx;
		}
		while (baseCtx.endsWith("/")) {
			baseCtx = baseCtx.substring(0, baseCtx.length() - 1);
		}
		String expectedAuPath = baseCtx + "/zkau";
		if (!canonicalPath.equals(expectedAuPath) && !canonicalPath.startsWith(expectedAuPath + "/"))
			return null;

		return resolved;
	}

	/**
	 * Log an error raised by the WebSocket container.
	 *
	 * @param sess WebSocket session
	 * @param throwable reported error
	 */
	@OnError
	public void onError(Session sess, Throwable throwable) {
		log.log(Level.WARNING, throwable.getMessage(), throwable);	
	}

	// Track the "tail" of the execution chain. Start with a completed future.
	private CompletableFuture<Void> executionChain = CompletableFuture.completedFuture(null);
	// Lock to protect the chain update (very short duration)
	private final Object chainLock = new Object();
		
	/**
	 * Handle ping and AU messages from client
	 * @param session WebSocket session
	 * @param message text message payload
	 */
	@OnMessage
	public void onMessage(Session session, String message) { 
		if (session == this.session && !Util.isEmpty(message)) {
			if (message.equals("__ping__")) {
				setMessageIndicator();
				sendText(session, "__pong__");
			} else if (message.startsWith("zkau;")) {
				String jsonMessage = message.substring(5);
				JSONObject jsonRequest;
				try {
					Object parsed = new JSONParser().parse(jsonMessage);
					if (!(parsed instanceof JSONObject obj)) {
						sendText(session, errorResponse(400, "Error: Invalid AU message", null));
						return;
					}
					jsonRequest = obj;
				} catch (RuntimeException e) {
					log.log(Level.WARNING, "Invalid JSON in WebSocket AU message", e);
					sendText(session, errorResponse(400, "Error: Invalid AU message", null));
					return;
				}

				Object sidObj = jsonRequest.get("sid");
				String sid = sidObj != null ? sidObj.toString() : null;
				Object uriObj = jsonRequest.get("uri");
				String uri = uriObj instanceof String s ? s : null;
				Object contentObj = jsonRequest.get("content");
				String content = contentObj instanceof String s ? s : null;
				Object dtObj = jsonRequest.get("dt");
				String dtid = dtObj != null ? dtObj.toString() : null;

				if (dtid == null || !dtid.equals(this.dtid)) {
					sendText(session, errorResponse(500, "Error: Invalid desktop id", sid));
					return;
				}
				if (content == null) {
					sendText(session, errorResponse(500, "Error: Missing AU content", sid));
					return;
				}
				if (sid == null || sid.isBlank()) {
					sendText(session, errorResponse(400, "Error: Missing AU sid", null));
					return;
				}

				URI targetUri = resolveAuUri(uri);
				if (targetUri == null) {
					String safePath = uri != null ? uri.split("[;?]", 2)[0] : "null";
					log.warning("Rejected WebSocket AU request with invalid URI path: " + safePath
							+ " (contextPath=" + contextPath + ")");
					sendText(session, errorResponse(400, "Error: Invalid AU URI", sid));
					return;
				}

				setMessageIndicator();

				if (httpSession == null) {
					closeWithReason(session, CloseReason.CloseCodes.VIOLATED_POLICY, "Session invalidated");
					return;
				}
				String sessionId;
		        try {
					httpSession.getLastAccessedTime(); // throws IllegalStateException when the session is invalidated
					sessionId = httpSession.getId();
				} catch (IllegalStateException e) {
					log.log(Level.WARNING, "HTTP Session already invalidated", e);
					closeWithReason(session, CloseReason.CloseCodes.VIOLATED_POLICY, "Session invalidated");
					return;
				}

		        if (closeRequested) {
		        	return;
		        }

		        if (pendingRequests.incrementAndGet() > MAX_PENDING_REQUESTS) {
		        	if (pendingRequests.decrementAndGet() == 0 && closeRequested) {
		        		closeNow();
		        	}
		        	log.warning("Too many pending WebSocket AU requests for desktop " + this.dtid);
		        	sendText(session, errorResponse(503, "Error: Too many pending requests", sid));
		        	return;
		        }

		        if (closeRequested) {
		        	if (pendingRequests.decrementAndGet() == 0) {
		        		closeNow();
		        	}
		        	return;
		        }

		        final AtomicBoolean slotReleased = new AtomicBoolean(false);
		        synchronized (chainLock) {
			        try {
				        // Create POST request with the AU content in the body instead of the URL.
				        // Putting the content into the query string caused the Jetty 8192-byte request
				        // line limit to be exceeded for large AU payloads (e.g. previewing a large CSV
				        // spreadsheet), resulting in "URI is too large >8192" (HTTP 414).
				        HttpPost httpPost = new HttpPost(targetUri);
				        httpPost.setEntity(new StringEntity(content, ContentType.APPLICATION_FORM_URLENCODED.withCharset(StandardCharsets.UTF_8)));
				        httpPost.setHeader("ZK-SID", sid);
				        httpPost.setHeader("Pragma", "no-cache");
				        httpPost.setHeader("Cache-Control", "no-cache");
				        httpPost.setHeader(WebSocketServerPush.WS_LOOPBACK_HEADER, "true");
				        forwardedHeaders.forEach((key, values) -> {
				        	for (String value : values) {
				        		httpPost.addHeader(key, value);
				        	}
				        });
				        httpPost.setConfig(auRequestConfig);
		
				        // Execute request asynchronously in order
				        executionChain = executionChain.thenRunAsync(() -> {
				        	try {
				        		if (session != this.session || closeRequested) {
				        			return;
				        		}
				        		if (cookieStore != null) {
				        			if (sessionId != null && !sessionId.equals(lastSessionId)) {
				        				BasicClientCookie cookie = new BasicClientCookie(sessionCookieName, sessionId);
				        				cookie.setDomain(requestHost);
				        				cookie.setPath("/");
				        				cookieStore.addCookie(cookie);
				        				lastSessionId = sessionId;
				        			}
				        			cookieStore.clearExpired(new Date());
				        			String cookieHeader = buildCookieHeader(cookieStore);
				        			if (!cookieHeader.isEmpty()) {
				        				httpPost.setHeader("Cookie", cookieHeader);
				        			}
				        		}
				        		try (CloseableHttpResponse response = getHttpClient().execute(httpPost)) {
				        			HttpEntity entity = response.getEntity();
				        			String servletResponse = entity != null
				        					? EntityUtils.toString(entity, StandardCharsets.UTF_8)
				        					: "";

				        			if (servletResponse != null && !servletResponse.isEmpty()) {
				        				if (response.getCode() >= 400) {
				        					log.log(Level.WARNING, "Bad Request to /zkau (status=" + response.getCode() + ")");
				        				}
				        				List<PendingBrowserCookie> pendingCookies = null;
				        				Map<String, String> headersMap = new HashMap<>();
				        				String targetPath = targetUri.getRawPath();
				        				for (Header header : response.getHeaders()) {
				        					String name = header.getName();
				        					String value = header.getValue();
				        					if ("Set-Cookie".equalsIgnoreCase(name)) {
				        						PendingBrowserCookie parsedCookie = parseAndStoreSetCookie(value, targetPath);
				        						if (parsedCookie != null) {
				        							if (pendingCookies == null) {
				        								pendingCookies = new ArrayList<>();
				        							}
				        							pendingCookies.add(parsedCookie);
				        						}
				        						// Do not expose raw Set-Cookie values (including HttpOnly cookies) to JS.
				        						continue;
				        					}
				        					headersMap.merge(name, value, (existing, replacement) -> existing + ", " + replacement);
				        				}
				        				if (pendingCookies != null && httpSession != null) {
				        					storePendingBrowserCookies(pendingCookies);
				        				}
				        				JSONObject jsonResponse = new JSONObject();
				        				jsonResponse.put("headers", headersMap);
				        				jsonResponse.put("status", response.getCode());
				        				jsonResponse.put("responseText", servletResponse);
				        				jsonResponse.put("sid", sid);
				        				if (pendingCookies != null && !pendingCookies.isEmpty()) {
				        					jsonResponse.put("syncCookies", Boolean.TRUE);
				        				}
				        				sendText(session, jsonResponse.toString());
				        			} else {
				        				sendText(session, errorResponse(500, "Error: No response from /zkau", sid));
				        			}
				        		}
				        	} catch (SocketTimeoutException e) {
				        		if (e instanceof ConnectTimeoutException) {
				        			log.log(Level.WARNING, "Timed out connecting to /zkau for desktop " + this.dtid + " (sid=" + sid + ")", e);
				        			sendText(session, errorResponse(504, "Error: Timed out connecting to /zkau", sid));
				        		} else {
				        			log.log(Level.WARNING, "Timed out waiting for /zkau response for desktop " + this.dtid
				        					+ " (sid=" + sid + "); server-side execution outcome is unknown", e);
				        			sendText(session, errorResponse(504,
				        					"Error: Timed out waiting for /zkau response (execution outcome unknown)", sid));
				        		}
				        	} catch (Throwable e) {
				        		log.log(Level.WARNING, "Error processing /zkau request", e);
				        		sendText(session, errorResponse(500, "Error processing /zkau request", sid));
				        	} finally {
				        		releasePendingSlot(slotReleased);
				        	}
				        }, getAuExecutor()).handle((ignored, ex) -> {
				        	if (ex != null && slotReleased.compareAndSet(false, true)) {
				        		try {
				        			Throwable cause = (ex instanceof CompletionException && ex.getCause() != null)
				        					? ex.getCause() : ex;
				        			if (cause instanceof RejectedExecutionException) {
				        				log.log(Level.WARNING, "WebSocket AU worker pool saturated", cause);
				        				if (session == this.session && !closeRequested) {
				        					sendText(session, errorResponse(503, "Error: Server busy", sid));
				        				}
				        			} else {
				        				log.log(Level.WARNING, "Error processing /zkau request", cause);
				        				if (session == this.session && !closeRequested) {
				        					sendText(session, errorResponse(500, "Error processing /zkau request", sid));
				        				}
				        			}
				        		} catch (Throwable t) {
				        			log.log(Level.WARNING, "Error handling WebSocket AU failure", t);
				        		} finally {
				        			if (pendingRequests.decrementAndGet() == 0 && closeRequested) {
				        				closeNow();
				        			}
				        		}
				        	}
				        	return null;
				        });
			        } catch (RejectedExecutionException e) {
			        	if (slotReleased.compareAndSet(false, true)) {
			        		if (pendingRequests.decrementAndGet() == 0 && closeRequested) {
			        			closeNow();
			        		}
			        		log.log(Level.WARNING, "WebSocket AU worker pool saturated", e);
			        		if (session == this.session && !closeRequested) {
			        			sendText(session, errorResponse(503, "Error: Server busy", sid));
			        		}
			        	}
			        } catch (Throwable e) {
			        	if (slotReleased.compareAndSet(false, true)) {
			        		if (pendingRequests.decrementAndGet() == 0 && closeRequested) {
			        			closeNow();
			        		}
			        		log.log(Level.WARNING, "Error processing /zkau request", e);
			        		if (session == this.session && !closeRequested) {
			        			sendText(session, errorResponse(500, "Error processing /zkau request", sid));
			        		}
			        	}
			        }
		        }
			}
		}
	}

	private static String buildCookieHeader(BasicCookieStore store) {
		List<Cookie> cookies = store.getCookies();
		if (cookies == null || cookies.isEmpty())
			return "";
		StringBuilder sb = new StringBuilder();
		for (Cookie cookie : cookies) {
			String name = cookie.getName();
			if (name == null || name.isEmpty())
				continue;
			if (sb.length() > 0)
				sb.append("; ");
			sb.append(name).append('=').append(cookie.getValue() != null ? cookie.getValue() : "");
		}
		return sb.toString();
	}

	private static boolean matchesCookiePath(String cookiePath, String targetPath) {
		if (cookiePath == null || cookiePath.isEmpty() || "/".equals(cookiePath))
			return true;
		if (targetPath == null || targetPath.isEmpty())
			return false;
		if (targetPath.equals(cookiePath))
			return true;
		return targetPath.startsWith(cookiePath)
				&& (cookiePath.endsWith("/") || targetPath.charAt(cookiePath.length()) == '/');
	}

	private PendingBrowserCookie parseAndStoreSetCookie(String setCookieHeader, String targetPath) {
		if (setCookieHeader == null || setCookieHeader.isBlank())
			return null;
		String[] cookieElements = setCookieHeader.split(";");
		String[] pair = cookieElements[0].split("=", 2);
		if (pair.length != 2)
			return null;
		String cookieName = pair[0].trim();
		String cookieValue = pair[1].trim();
		if (cookieName.isEmpty())
			return null;

		String path = null;
		Integer maxAgeSeconds = null;
		Date expiryDate = null;
		boolean secure = false;
		boolean httpOnly = false;

		for (int i = 1; i < cookieElements.length; i++) {
			String attr = cookieElements[i].trim();
			String lowerAttr = attr.toLowerCase(Locale.ROOT);
			if (lowerAttr.startsWith("max-age=")) {
				try {
					long parsedMaxAge = Long.parseLong(attr.substring(8).trim());
					if (parsedMaxAge <= 0L) {
						maxAgeSeconds = 0;
						expiryDate = new Date(0L);
					} else {
						maxAgeSeconds = (int) Math.min(Integer.MAX_VALUE, parsedMaxAge);
						expiryDate = new Date(System.currentTimeMillis() + parsedMaxAge * 1000L);
					}
				} catch (NumberFormatException e) {
					// Ignore invalid max-age attribute
				}
			} else if (lowerAttr.startsWith("expires=") && maxAgeSeconds == null) {
				try {
					expiryDate = DateUtils.parseDate(attr.substring(8).trim());
				} catch (Exception e) {
					// Ignore invalid expires attribute
				}
			} else if (lowerAttr.startsWith("path=")) {
				path = attr.substring(5).trim();
			} else if (lowerAttr.equals("secure")) {
				secure = true;
			} else if (lowerAttr.equals("httponly")) {
				httpOnly = true;
			}
		}

		// Update internal loopback cookie store using normalized "/" path so updates and Max-Age=0
		// deletions replace handshake cookies, and do not mark internal loopback cookies Secure
		// (the local connector may be plain HTTP behind a TLS-terminating reverse proxy).
		if (cookieStore != null && matchesCookiePath(path, targetPath)) {
			BasicClientCookie internalCookie = new BasicClientCookie(cookieName, cookieValue);
			internalCookie.setDomain(requestHost);
			internalCookie.setPath("/");
			if (expiryDate != null) {
				internalCookie.setExpiryDate(expiryDate);
			}
			cookieStore.addCookie(internalCookie);
		}

		return new PendingBrowserCookie(cookieName, cookieValue, path, maxAgeSeconds, expiryDate, secure, httpOnly);
	}

	@SuppressWarnings("unchecked")
	private void storePendingBrowserCookies(List<PendingBrowserCookie> newCookies) {
		try {
			synchronized (httpSession) {
				Object existing = httpSession.getAttribute(WebSocketServerPush.WEBSOCKET_EVENT_COOKIE_STORE);
				List<PendingBrowserCookie> target;
				if (existing instanceof List<?>) {
					target = (List<PendingBrowserCookie>) existing;
				} else {
					target = new ArrayList<>();
					httpSession.setAttribute(WebSocketServerPush.WEBSOCKET_EVENT_COOKIE_STORE, target);
				}
				target.addAll(newCookies);
			}
		} catch (IllegalStateException e) {
			log.log(Level.FINE, "HTTP session invalidated while storing response cookies", e);
		}
	}

	private String errorResponse(int status, String text, String sid) {
		JSONObject jsonResponse = new JSONObject();
		jsonResponse.put("status", status);
		jsonResponse.put("statusText", text);
		if (sid != null) {
			jsonResponse.put("sid", sid);
			Map<String, String> headers = new HashMap<>();
			headers.put("ZK-SID", sid);
			jsonResponse.put("headers", headers);
		}
		return jsonResponse.toString();
	}

	// Disable SSL verification and host name verification for node-local loopback requests
	// (self-signed certs or IP-based local connectors). Target URI is strictly validated to internalBaseUri.
	private static final SSLContext sslContext = createSSLContext();

	private static SSLContext createSSLContext() {
		try {
			return SSLContextBuilder.create()
					.loadTrustMaterial(TrustAllStrategy.INSTANCE)
					.build();
		} catch (Exception e) {
			log.log(Level.SEVERE, "Failed to create SSLContext", e);
			return null;
		}
	}
	
	private static final SSLConnectionSocketFactory sslSocketFactory = createSSLSocketFactory();
	private static SSLConnectionSocketFactory createSSLSocketFactory() {
		if (sslContext == null) {
			return SSLConnectionSocketFactory.getSocketFactory();
		}
		return SSLConnectionSocketFactoryBuilder.create()
				.setSslContext(sslContext)
				.setHostnameVerifier(NoopHostnameVerifier.INSTANCE)
				.build();
	}

	/**
	 * Message client to send echo event to server
	 */
	public void echo() {
		Session current = this.session;
		if (!closeRequested && current != null) {
			sendText(current, "echo");
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
