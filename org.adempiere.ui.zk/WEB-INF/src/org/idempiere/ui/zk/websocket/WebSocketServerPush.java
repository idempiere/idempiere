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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.hc.client5.http.cookie.BasicCookieStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.zkoss.json.JSONValue;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.DesktopUnavailableException;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.impl.ExecutionCarryOver;
import org.zkoss.zk.ui.sys.Scheduler;
import org.zkoss.zk.ui.sys.ServerPush;
import org.zkoss.zk.ui.sys.SessionCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.ExecutionInit;

/**
 * Server push implementation using web socket
 * @author hengsin
 *
 */
public class WebSocketServerPush implements ServerPush {

    protected static final String WEBSOCKET_EVENT_COOKIE_STORE = "websocket.event.cookie.store";

	private static final String ON_ECHO = "onEcho";

	private static final String ON_SCHEDULE = "onSchedule";

	private static final String WEBSOCKET_SERVERPUSH_ECHO = "WebSocketServerPush.Echo";

	private static final String ON_ACTIVATE_DESKTOP = "onActivateDesktop";

    private final AtomicReference<Desktop> desktop = new AtomicReference<Desktop>();
    
    private final Logger log = LoggerFactory.getLogger(this.getClass());
    
    private volatile ThreadInfo _active;
    private volatile ThreadInfo _waiting;
    private volatile ExecutionCarryOver _carryOver;
    private final Object _mutex = new Object();
    private final Object _activateLock = new Object();
    
    private final static Set<String> activeDesktops = ConcurrentHashMap.newKeySet();
    private final static Map<String, ServerPushEndPoint> endPointMap = new ConcurrentHashMap<>();
    private final static Map<String, Boolean> unregisterMap = new ConcurrentHashMap<>();
    private final static ServerPushEndPoint STUB = new ServerPushEndPoint();
    private final List<Schedule<Event>> schedules = new ArrayList<>();
    private final AtomicBoolean echoPending = new AtomicBoolean(false);
    private final AtomicBoolean cookieHandlerRegistered = new AtomicBoolean(false);

    private AbstractComponent dummyTarget;
    
    protected static final String WS_CLIENT_IP = "ws-client-ip";

    protected static final String WS_LOCAL_BASE_URL = "ws-local-base-url";

    protected static final String WS_DESKTOP_OWNER = "ws-desktop-owner";

    protected static final String WS_LOOPBACK_HEADER = "X-iDempiere-WS-AU";

    private static final String SSL_CIPHER_SUITE_ATTRIBUTE = "javax.servlet.request.cipher_suite";

    static final class PendingBrowserCookie {
		final String name;
		final String value;
		final String path;
		final Integer maxAgeSeconds;
		final Date expiryDate;
		final boolean secure;
		final boolean httpOnly;

		PendingBrowserCookie(String name, String value, String path, Integer maxAgeSeconds,
				Date expiryDate, boolean secure, boolean httpOnly) {
			this.name = name;
			this.value = value;
			this.path = path;
			this.maxAgeSeconds = maxAgeSeconds;
			this.expiryDate = expiryDate;
			this.secure = secure;
			this.httpOnly = httpOnly;
		}
	}

    private static class OnScheduleEvent extends Event {
		private static final long serialVersionUID = 1L;
		
		private Schedule<Event>[] schedules;
		
		public OnScheduleEvent(Schedule<Event>[] schedules) {
			super(ON_SCHEDULE);
			this.schedules = schedules;
		}
		
		public Schedule<Event>[] getSchedules() {
			return schedules;
		}
	}
    
    public WebSocketServerPush() {
    	dummyTarget = new AbstractComponent();
    	dummyTarget.addEventListener(ON_SCHEDULE, (OnScheduleEvent e) -> {
    		Schedule<Event>[] pendings = e.getSchedules();
    		if (pendings != null && pendings.length > 0) {
				for (Schedule<Event> schedule : pendings) {
					try {
						schedule.task.onEvent(schedule.event);
					} catch (Exception ex) {
						log.error("Failed to execute scheduled task " + schedule.task, ex);
					}
				}
			}
    	});
    	dummyTarget.addEventListener(ON_ECHO, e -> {
    		String dtidJson = JSONValue.toJSONString(e.getData().toString());
    		StringBuilder script = new StringBuilder();
    		script.append("setTimeout(function() {");
    		script.append("if (org.idempiere.websocket && org.idempiere.websocket.echoServerPush) {");
    		script.append("  org.idempiere.websocket.echoServerPush(").append(dtidJson).append(");");
    		script.append("} else {");
    		script.append("  let dt = zk.Desktop.$(").append(dtidJson).append(");");
    		script.append("  if (dt && dt._serverpush && dt._serverpush.socket) {");
    		script.append("    dt._serverpush.socket.onmessage({data: 'echo'});");
    		script.append("  }");
    		script.append("}}, 0);");
    		Clients.response(new AuScript(null, script.toString()));
    	});
    }

    @Override
    public boolean activate(long timeout) throws InterruptedException, DesktopUnavailableException {
    	final Thread curr = Thread.currentThread();
    	ThreadInfo active = _active;
    	if (active != null && active.thread.equals(curr)) { //re-activate
			++active.nActive;
			return true;
		}

    	synchronized (_activateLock) {
	    	Desktop dt = desktop.get();
	    	if (dt == null || !dt.isAlive()) {
	    		throw new DesktopUnavailableException("Desktop is not available");
	    	}

			final ThreadInfo info = new ThreadInfo(curr);

			EventListener<Event> task = new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					if (event.getName().equals(ON_ACTIVATE_DESKTOP)) {
						synchronized (_mutex) {
							synchronized (info) {
								Desktop currentDesktop = desktop.get();
								if (info.timedOut || info.cancelled || currentDesktop == null || !currentDesktop.isAlive()) {
									return;
								}
								_carryOver = new ExecutionCarryOver(currentDesktop);
								info.nActive = 1; //granted
								info.notifyAll();
							}

							while (_carryOver != null && desktop.get() != null) {
								try {
									_mutex.wait(); //wait until the server push is done
								} catch (InterruptedException ex) {
									Thread.currentThread().interrupt();
									throw UiException.Aide.wrap(ex);
								}
							}
						}
					}
				}
			};

			long waitMs = timeout <= 0 ? 10L * 60L * 1000L : timeout;
			long deadlineNanos = System.nanoTime() + TimeUnit.MILLISECONDS.toNanos(waitMs);
			_waiting = info;
			try {
				synchronized (info) {
					Executions.schedule(dt, task, new Event(ON_ACTIVATE_DESKTOP));
					while (info.nActive == 0 && !info.cancelled) {
						long remainingNanos = deadlineNanos - System.nanoTime();
						if (remainingNanos <= 0L) {
							info.timedOut = true;
							return false;
						}
						long remainingMs = remainingNanos / 1_000_000L;
						int remainingNs = (int) (remainingNanos % 1_000_000L);
						info.wait(remainingMs, remainingNs);
					}
					if (info.nActive == 0) {
						throw new DesktopUnavailableException("Server push stopped while activating desktop");
					}
				}
			} finally {
				if (_waiting == info) {
					_waiting = null;
				}
			}

			ExecutionCarryOver carryOver = _carryOver;
			if (carryOver == null) {
				return false;
			}
	    	carryOver.carryOver();
	    	_active = info;
	    	return true;
    	}
    }

    private boolean echo() {
    	Desktop dt = desktop.get();
        if (dt != null) {
        	ServerPushEndPoint endPoint = getEndPoint(dt.getId());
        	if (endPoint == null) {
        		if (dt.isServerPushEnabled()) {
        			try {
						Thread.sleep(300);
					} catch (InterruptedException e) {
						Thread.currentThread().interrupt();
						return false;
					}
        			endPoint = getEndPoint(dt.getId());
        		}
        	}
        	if (endPoint != null) {
        		endPoint.echo();
        		return true;
        	}
        } 
        return false;
    }

    @Override
    public boolean deactivate(boolean stop) {
    	boolean stopped = false;
    	ThreadInfo active = _active;
		if (active != null && Thread.currentThread().equals(active.thread)) {
			if (--active.nActive <= 0) {
				if (stop) {
					stop();
					stopped = true;
				}

				synchronized (_mutex) {
					ExecutionCarryOver carryOver = _carryOver;
					if (carryOver != null) {
						carryOver.cleanup();
						_carryOver = null;
					}
					active.nActive = 0; //just in case
					_active = null;
					_mutex.notifyAll();
				}
			}
		}
		return stopped;
    }

    @Override
    public boolean isActive() {
    	ThreadInfo active = _active;
    	return active != null && active.nActive > 0;
    }

    @SuppressWarnings("unchecked")
	@Override
    public void onPiggyback() {
    	// Clear before draining so concurrent schedule() calls after drain starts will still trigger an echo.
    	echoPending.set(false);

    	//Process pending schedule event
    	Schedule<Event>[] pendings = null;
    	synchronized (schedules) {
    		if (!schedules.isEmpty()) {
    			pendings = schedules.toArray(new Schedule[0]);
    			schedules.clear();
    		}
    	}
    	if (pendings != null && pendings.length > 0) {
    		Events.sendEvent(dummyTarget, new OnScheduleEvent(pendings));
    	}
    	
    	//check web socket end point 
    	Desktop dt = desktop.get(); 
    	if (dt != null) {
        	ServerPushEndPoint endPoint = getEndPoint(dt.getId());
        	if (endPoint == null) {
        		if (dt.isServerPushEnabled()) {
        			String dtid = dt.getId();
        			boolean[] shouldStart = new boolean[1];
        			endPointMap.compute(dtid, (k, existing) -> {
        				if (existing == null && activeDesktops.contains(dtid) && unregisterMap.remove(dtid, Boolean.TRUE)) {
        					shouldStart[0] = true;
        					return STUB;
        				}
        				return existing;
        			});
        			if (shouldStart[0]) {
        				startServerPushAtClient(dt);
        			}
        		}
        	}
    	}    	
    }

    private static class EventListenerWrapper<T extends Event> implements EventListener<T> {
    	private EventListener<T> wrappedListener;
    	private AtomicBoolean runOnce;

    	private EventListenerWrapper(EventListener<T> wrappedListener) {
    		this.wrappedListener=wrappedListener;
    		this.runOnce = new AtomicBoolean(false);
    	}

    	@Override
    	public void onEvent(T event) throws Exception {
    		//if the wrapped event listener throws exception, the scheduled listener is not clean up
    		//this atomic boolean help prevent repeated call when that happens
    		if (!runOnce.compareAndSet(false, true))
    			return;

    		wrappedListener.onEvent(event);
    	}

    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public <T extends Event> void schedule(EventListener<T> task, T event,
			Scheduler<T> scheduler) {
    	if (desktop.get() == null)
    		return;
    	EventListenerWrapper<T> wrapper = new EventListenerWrapper<T>(task);
    	if (Executions.getCurrent() == null) {
    		//schedule and execute in onPiggyBack
    		synchronized (schedules) {
				schedules.add(new Schedule(wrapper, event));
			}
    		if (echoPending.compareAndSet(false, true)) {
    			if (!echo()) {
    				echoPending.set(false);
    			}
    		}
    	} else {
    		// in event listener thread, process this asynchronously in onPiggyback
    		synchronized (schedules) {
				schedules.add(new Schedule(wrapper, event));
			}
    		if (Executions.getCurrent().getAttribute(WEBSOCKET_SERVERPUSH_ECHO) == null) {
    			Executions.getCurrent().setAttribute(WEBSOCKET_SERVERPUSH_ECHO, Boolean.TRUE);
    			Events.postEvent(-9999, ON_ECHO, dummyTarget, Executions.getCurrent().getDesktop().getId());
    		}
    	}
    }

    private class Schedule<T extends Event> {
    	private EventListener<T> task;
		private T event;

		private Schedule(EventListener<T> task, T event) {
    		this.task = task;
    		this.event = event;
    	}
    }
    
	/** {@inheritDoc} */
    @Override
    public void start(Desktop desktop) {
        Desktop oldDesktop = this.desktop.getAndSet(desktop);
        if (oldDesktop != null) {
            log.warn("Server push already started for desktop " + desktop.getId());
            return;
        }

        if (log.isDebugEnabled())
        	log.debug("Starting server push for " + desktop);
        String dtid = desktop.getId();
        endPointMap.compute(dtid, (k, existing) -> {
        	activeDesktops.add(dtid);
        	unregisterMap.remove(dtid);
        	return STUB;
        });

        // Store connection details in session attributes for later use in EndpointConfigurator
        var session = desktop.getSession();
        if (session != null) {
        	session.setAttribute(getDesktopOwnerAttribute(desktop.getId()), Boolean.TRUE);
        }
        var execution = Executions.getCurrent();
        if (execution != null) {
        	var request = execution.getNativeRequest();
        	if (request instanceof HttpServletRequest httpRequest) {
				if (session != null) {
					var clientIp = httpRequest.getRemoteAddr();
					if (clientIp != null)
						session.setAttribute(WS_CLIENT_IP, clientIp);

					String localBaseUrl = getLocalBaseUrl(httpRequest);
					if (localBaseUrl != null) {
						session.setAttribute(getLocalBaseUrlAttribute(desktop.getId()), localBaseUrl);
					}
				}
			}
        }
        startServerPushAtClient(desktop);

        if (cookieHandlerRegistered.compareAndSet(false, true)) {
			ExecutionInit cookieHandler = (Execution exec, Execution parent) -> flushPendingBrowserCookies(desktop, exec);
			desktop.addListener(cookieHandler);
        }
    }

	static void flushPendingBrowserCookies(Desktop desktop, Execution exec) {
		var requestObject = exec.getNativeRequest();
		if (requestObject instanceof HttpServletRequest req
				&& "true".equals(req.getHeader(WS_LOOPBACK_HEADER))) {
			// Do not drain pending browser cookies on internal WebSocket loopback /zkau requests.
			return;
		}
		var responseObject = exec.getNativeResponse();
		if (responseObject instanceof HttpServletResponse servletResponse) {
			var currentSession = desktop.getSession();
			if (currentSession == null)
				return;
			Object pendingCookies;
			Object nativeSession = currentSession.getNativeSession();
			if (nativeSession != null) {
				synchronized (nativeSession) {
					pendingCookies = currentSession.removeAttribute(WEBSOCKET_EVENT_COOKIE_STORE);
				}
			} else {
				pendingCookies = currentSession.removeAttribute(WEBSOCKET_EVENT_COOKIE_STORE);
			}

			boolean requestSecure = requestObject instanceof HttpServletRequest req && req.isSecure();
			if (pendingCookies instanceof List<?> list) {
				for (Object item : list) {
					if (item instanceof PendingBrowserCookie cookie) {
						Cookie browserCookie = new Cookie(cookie.name, cookie.value);
						if (cookie.path != null && !cookie.path.isBlank()) {
							browserCookie.setPath(cookie.path);
						}
						browserCookie.setSecure(cookie.secure || requestSecure);
						browserCookie.setHttpOnly(cookie.httpOnly);
						if (cookie.maxAgeSeconds != null) {
							browserCookie.setMaxAge(Math.max(0, cookie.maxAgeSeconds));
						} else if (cookie.expiryDate != null) {
							long maxAgeSeconds = Math.max(0L,
									(cookie.expiryDate.getTime() - System.currentTimeMillis()) / 1000L);
							browserCookie.setMaxAge((int) Math.min(Integer.MAX_VALUE, maxAgeSeconds));
						}
						servletResponse.addCookie(browserCookie);
					}
				}
			} else if (pendingCookies instanceof BasicCookieStore basicCookieStore) {
				// Backward compatibility if a BasicCookieStore was stored directly.
				basicCookieStore.getCookies().forEach(cookie -> {
					Cookie browserCookie = new Cookie(cookie.getName(), cookie.getValue());
					if (cookie.getPath() != null && !cookie.getPath().isBlank()) {
						browserCookie.setPath(cookie.getPath());
					}
					browserCookie.setSecure(cookie.isSecure() || requestSecure);
					browserCookie.setHttpOnly(true);
					if (cookie.getExpiryDate() != null) {
						long maxAgeSeconds = Math.max(0L,
								(cookie.getExpiryDate().getTime() - System.currentTimeMillis()) / 1000L);
						browserCookie.setMaxAge((int) Math.min(Integer.MAX_VALUE, maxAgeSeconds));
					}
					servletResponse.addCookie(browserCookie);
				});
			}
		}
	}

	/**
	 * Build the base URL of the local servlet connector that accepted the request.
	 *
	 * @param request current servlet request
	 * @return node-local base URL, or {@code null} when connector data is unavailable
	 */
	private String getLocalBaseUrl(HttpServletRequest request) {
		String localAddress = request.getLocalAddr();
		int localPort = request.getLocalPort();
		if (localAddress == null || localAddress.isBlank() || localPort <= 0)
			return null;

		// Do not use request.getScheme(): a reverse proxy can replace it with the
		// browser-facing scheme. The standard TLS attribute reflects the local connector.
		String scheme = request.getAttribute(SSL_CIPHER_SUITE_ATTRIBUTE) != null ? "https" : "http";
		try {
			return new URI(scheme, null, localAddress, localPort, null, null, null).toASCIIString();
		} catch (URISyntaxException e) {
			log.warn("Unable to build the node-local server push URL", e);
			return null;
		}
	}

	/**
	 * Build the session attribute name for a desktop's node-local connector URL.
	 *
	 * @param desktopId ZK desktop identifier
	 * @return session attribute name
	 */
	protected static String getLocalBaseUrlAttribute(String desktopId) {
		return WS_LOCAL_BASE_URL + "." + desktopId;
	}

	/**
	 * Build the session attribute name recording ownership of a desktop by its HTTP session.
	 *
	 * @param desktopId ZK desktop identifier
	 * @return session attribute name
	 */
	protected static String getDesktopOwnerAttribute(String desktopId) {
		return WS_DESKTOP_OWNER + "." + desktopId;
	}

	/**
	 * Notify the browser to open the WebSocket server-push connection.
	 *
	 * @param desktop ZK desktop to connect
	 */
	private void startServerPushAtClient(Desktop desktop) {
		Clients.response("org.idempiere.websocket.serverpush.start",
				new AuScript(null, "org.idempiere.websocket.startServerPush(" + JSONValue.toJSONString(desktop.getId()) + ");"));
	}

	/** {@inheritDoc} */
    @Override
    public void stop() {
        Desktop desktop = this.desktop.getAndSet(null);
        if (desktop == null) {
            log.warn("Server push hasn't been started or has already stopped");
            return;
        }

        if (log.isDebugEnabled())
        	log.debug("Stopping server push for " + desktop);

        echoPending.set(false);
        synchronized (schedules) {
        	schedules.clear();
        }

        // Remove from static registries so closed/abandoned desktops never leak entries.
        String dtid = desktop.getId();
        ServerPushEndPoint[] removedEndpoint = new ServerPushEndPoint[1];
        endPointMap.compute(dtid, (k, existing) -> {
        	activeDesktops.remove(dtid);
        	unregisterMap.remove(dtid);
        	removedEndpoint[0] = existing;
        	return null;
        });
        ServerPushEndPoint endpoint = removedEndpoint[0];
        if (endpoint != null && endpoint != STUB) {
        	endpoint.close();
        }

        // Unblock any threads waiting in activate() or holding _mutex.
        ThreadInfo waiting = _waiting;
        if (waiting != null) {
        	synchronized (waiting) {
        		waiting.cancelled = true;
        		waiting.notifyAll();
        	}
        }
        synchronized (_mutex) {
        	_mutex.notifyAll();
        }

		var session = desktop.getSession();
		if (session != null && (!(session instanceof SessionCtrl sessionCtrl) || !sessionCtrl.isInvalidated())) {
			try {
				session.removeAttribute(getLocalBaseUrlAttribute(dtid));
				session.removeAttribute(getDesktopOwnerAttribute(dtid));
			} catch (IllegalStateException e) {
				// Session invalidated concurrently
			}
		}
        if (Executions.getCurrent() != null) {
        	Clients.response("org.idempiere.websocket.serverpush.stop",
        			new AuScript(null, "org.idempiere.websocket.stopServerPush(" + JSONValue.toJSONString(dtid) + ");"));
        }
    }

	private static class ThreadInfo {
		private final Thread thread;
		/** # of activate() was called. */
		private int nActive;
		private boolean timedOut;
		private boolean cancelled;
		private ThreadInfo(Thread thread) {
			this.thread = thread;
		}
		public String toString() {
			return "[" + thread + ',' + nActive + ']';
		}
	}

	@Override
	public void resume() {
		Desktop current = this.desktop.getAndSet(null);
		if (current != null) {
			start(current);
		}
	}
	
	/**
	 * Register web socket end point for desktop
	 * @param dtid Desktop id
	 * @param endpoint Connected web socket end point
	 */
	public static void registerEndPoint(String dtid, ServerPushEndPoint endpoint) {
		if (dtid != null && endpoint != null) {
			endPointMap.put(dtid, endpoint);
			if (endpoint != STUB) {
				unregisterMap.remove(dtid);
			}
		}
	}

	/**
	 * Atomically register a newly opened endpoint only if {@code dtid} is still an active
	 * server-push desktop owned by {@code httpSession}. Prevents a concurrent {@link #stop()}
	 * from racing with {@code onOpen} and leaking a stale endpoint entry.
	 *
	 * @param dtid Desktop id
	 * @param httpSession HTTP session from the WebSocket handshake
	 * @param endpoint Connected web socket end point
	 * @return true if the endpoint was registered, false if the desktop is no longer valid
	 */
	static boolean registerEndPointIfValid(String dtid, HttpSession httpSession, ServerPushEndPoint endpoint) {
		if (dtid == null || httpSession == null || endpoint == null || !isValidDesktopId(dtid, httpSession))
			return false;
		boolean[] registered = new boolean[1];
		endPointMap.compute(dtid, (k, existing) -> {
			if (!activeDesktops.contains(dtid) && existing == null) {
				return null;
			}
			unregisterMap.remove(dtid);
			registered[0] = true;
			return endpoint;
		});
		return registered[0];
	}
	
	/**
	 * Remove web socket end point for desktop
	 * @param dtid Desktop id
	 * @return true if there's end point register previously for desktop, false otherwise
	 */
	public static boolean unregisterEndPoint(String dtid) {
		if (dtid == null)
			return false;
		boolean[] removed = new boolean[1];
		endPointMap.computeIfPresent(dtid, (k, existing) -> {
			removed[0] = true;
			if (existing != STUB && activeDesktops.contains(dtid)) {
				unregisterMap.put(dtid, Boolean.TRUE);
			}
			return null;
		});
		return removed[0];
	}

	/**
	 * Remove web socket end point for desktop only if it matches the given endpoint instance.
	 * Prevents a stale socket's {@code onClose} from removing a newer reconnected endpoint.
	 *
	 * @param dtid Desktop id
	 * @param endpoint Endpoint instance closing
	 * @return true if the matching endpoint was removed, false otherwise
	 */
	public static boolean unregisterEndPoint(String dtid, ServerPushEndPoint endpoint) {
		if (dtid == null || endpoint == null)
			return false;
		boolean[] removed = new boolean[1];
		endPointMap.computeIfPresent(dtid, (k, existing) -> {
			if (existing != endpoint) {
				return existing;
			}
			removed[0] = true;
			if (endpoint != STUB && activeDesktops.contains(dtid)) {
				unregisterMap.put(dtid, Boolean.TRUE);
			}
			return null;
		});
		return removed[0];
	}
	
	/**
	 * Get web socket end point for desktop
	 * @param dtid Desktop id
	 * @return Web socket end point
	 */
	public static ServerPushEndPoint getEndPoint(String dtid) {
		if (dtid == null)
			return null;
		ServerPushEndPoint endpoint = endPointMap.get(dtid);
		if (endpoint == STUB)
			return null;
		else
			return endpoint;
	}
	
	/**
	 * @param dtid desktop id
	 * @return true if serverpush started for dtid, false otherwise
	 */
	public static boolean isValidDesktopId(String dtid) {
		return dtid != null && (activeDesktops.contains(dtid) || endPointMap.containsKey(dtid));
	}

	/**
	 * Validate that {@code dtid} is an active server-push desktop owned by {@code httpSession}.
	 *
	 * @param dtid desktop id
	 * @param httpSession HTTP session from the WebSocket handshake
	 * @return true if serverpush is active for {@code dtid} and owned by {@code httpSession}
	 */
	public static boolean isValidDesktopId(String dtid, HttpSession httpSession) {
		if (httpSession == null || !isValidDesktopId(dtid))
			return false;
		try {
			return Boolean.TRUE.equals(httpSession.getAttribute(getDesktopOwnerAttribute(dtid)));
		} catch (IllegalStateException e) {
			return false;
		}
	}
}
