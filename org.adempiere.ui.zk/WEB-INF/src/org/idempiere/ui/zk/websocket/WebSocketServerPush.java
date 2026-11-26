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
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.concurrent.locks.ReentrantLock;

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
import org.zkoss.zk.ui.sys.ExecutionsCtrl;
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
    private final ReentrantLock _activateLock = new ReentrantLock();
    
    private final static Map<String, WebSocketServerPush> activeDesktops = new ConcurrentHashMap<>();
    private final static Map<String, ServerPushEndPoint> endPointMap = new ConcurrentHashMap<>();
    private final static Map<String, Boolean> unregisterMap = new ConcurrentHashMap<>();
    private final static ServerPushEndPoint STUB = new ServerPushEndPoint();
    private static final long ECHO_RETRY_DELAY_MS = 300L;
    private static final int MAX_ECHO_RETRIES = 2;
    private static final Object ECHO_SCHEDULER_LOCK = new Object();
    private static volatile ScheduledExecutorService echoRetryExecutor;
    private static volatile boolean echoSchedulerShutdown = false;
    private static final AtomicInteger ECHO_RETRY_THREAD_COUNTER = new AtomicInteger(0);

    private final List<Schedule<Event>> schedules = new ArrayList<>();
    private final AtomicReference<ServerPushEndPoint> echoPendingEndPoint = new AtomicReference<>();
    private final AtomicBoolean echoRetryScheduled = new AtomicBoolean(false);
    private final AtomicReference<ScheduledFuture<?>> pendingEchoRetryFuture = new AtomicReference<>();
    private volatile ServerPushEndPoint.TimedOutAu unresolvedTimedOutAu;
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

    	long waitMs = timeout <= 0 ? 10L * 60L * 1000L : timeout;
    	long deadlineNanos = System.nanoTime() + TimeUnit.MILLISECONDS.toNanos(waitMs);

    	long lockWaitNanos = deadlineNanos - System.nanoTime();
    	if (lockWaitNanos <= 0L || !_activateLock.tryLock(lockWaitNanos, TimeUnit.NANOSECONDS)) {
    		return false;
    	}
    	try {
	    	Desktop dt = desktop.get();
	    	if (dt == null || !dt.isAlive()) {
	    		throw new DesktopUnavailableException("Desktop is not available");
	    	}

	    	if (deadlineNanos - System.nanoTime() <= 0L) {
	    		return false;
	    	}

			final ThreadInfo info = new ThreadInfo(curr);

			EventListener<Event> task = new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					if (event.getName().equals(ON_ACTIVATE_DESKTOP)) {
						synchronized (_mutex) {
							ExecutionCarryOver granted;
							synchronized (info) {
								Desktop currentDesktop = desktop.get();
								if (info.timedOut || info.cancelled || currentDesktop == null || !currentDesktop.isAlive()) {
									return;
								}
								granted = new ExecutionCarryOver(currentDesktop);
								info.carryOver = granted;
								_carryOver = granted;
								info.nActive = 1; //granted
								info.notifyAll();
							}

							while (_carryOver == granted && desktop.get() != null) {
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

			_waiting = info;
			InterruptedException interrupted = null;
			try {
				synchronized (info) {
					if (desktop.get() == null) {
						throw new DesktopUnavailableException("Server push stopped while activating desktop");
					}
					Executions.schedule(dt, task, new Event(ON_ACTIVATE_DESKTOP));
					while (info.nActive == 0 && !info.cancelled) {
						long remainingNanos = deadlineNanos - System.nanoTime();
						if (remainingNanos <= 0L) {
							info.timedOut = true;
							return false;
						}
						long remainingMs = remainingNanos / 1_000_000L;
						int remainingNs = (int) (remainingNanos % 1_000_000L);
						try {
							info.wait(remainingMs, remainingNs);
						} catch (InterruptedException e) {
							info.cancelled = true;
							if (info.nActive == 0) {
								throw e;
							}
							interrupted = e;
							break;
						}
					}
					if (interrupted == null && info.nActive == 0) {
						throw new DesktopUnavailableException("Server push stopped while activating desktop");
					}
				}
			} finally {
				if (_waiting == info) {
					_waiting = null;
				}
			}

			if (interrupted != null) {
				releaseAbandonedGrant(info);
				throw interrupted;
			}
			if (info.cancelled || desktop.get() == null) {
				releaseAbandonedGrant(info);
				throw new DesktopUnavailableException("Server push stopped while activating desktop");
			}

			ExecutionCarryOver carryOver = info.carryOver;
			if (carryOver == null) {
				return false;
			}
			if (Thread.interrupted()) {
				releaseAbandonedGrant(info);
				throw new InterruptedException("Interrupted before accepting desktop activation");
			}
			try {
				carryOver.carryOver();
			} catch (RuntimeException | Error e) {
				try {
					carryOver.cleanup();
				} catch (RuntimeException | Error cleanupEx) {
					e.addSuppressed(cleanupEx);
					if (Executions.getCurrent() != null) {
						ExecutionsCtrl.setCurrent(null);
					}
				} finally {
					releaseAbandonedGrant(info);
				}
				throw e;
			}
			if (info.cancelled || desktop.get() == null) {
				try {
					carryOver.cleanup();
				} catch (RuntimeException | Error cleanupEx) {
					if (Executions.getCurrent() != null) {
						ExecutionsCtrl.setCurrent(null);
					}
				} finally {
					releaseAbandonedGrant(info);
				}
				throw new DesktopUnavailableException("Server push stopped while activating desktop");
			}
	    	_active = info;
	    	return true;
    	} finally {
    		_activateLock.unlock();
    	}
    }

    private void releaseAbandonedGrant(ThreadInfo info) {
    	synchronized (_mutex) {
    		synchronized (info) {
    			info.cancelled = true;
    			ExecutionCarryOver granted = info.carryOver;
    			if (granted != null && _carryOver == granted && _active != info) {
    				_carryOver = null;
    				info.carryOver = null;
    				info.nActive = 0;
    				_mutex.notifyAll();
    			}
    		}
    	}
    }

    /**
     * Reopen shared echo retry scheduler creation when the bundle starts.
     */
    public static void startup() {
    	synchronized (ECHO_SCHEDULER_LOCK) {
    		echoSchedulerShutdown = false;
    	}
    }

    /**
     * Shut down the shared echo retry scheduler when the bundle stops.
     */
    public static void shutdown() {
    	synchronized (ECHO_SCHEDULER_LOCK) {
    		echoSchedulerShutdown = true;
    		if (echoRetryExecutor != null) {
    			echoRetryExecutor.shutdownNow();
    			echoRetryExecutor = null;
    		}
    	}
    }

    private static ScheduledExecutorService getEchoRetryExecutor() {
    	if (echoSchedulerShutdown) {
    		return null;
    	}
    	ScheduledExecutorService current = echoRetryExecutor;
    	if (current == null || current.isShutdown()) {
    		synchronized (ECHO_SCHEDULER_LOCK) {
    			if (echoSchedulerShutdown) {
    				return null;
    			}
    			current = echoRetryExecutor;
    			if (current == null || current.isShutdown()) {
    				ScheduledThreadPoolExecutor pool = new ScheduledThreadPoolExecutor(2, r -> {
    					Thread t = new Thread(r, "ws-echo-retry-" + ECHO_RETRY_THREAD_COUNTER.incrementAndGet());
    					t.setDaemon(true);
    					return t;
    				});
    				pool.setKeepAliveTime(60L, TimeUnit.SECONDS);
    				pool.allowCoreThreadTimeOut(true);
    				pool.setRemoveOnCancelPolicy(true);
    				echoRetryExecutor = pool;
    				current = pool;
    			}
    		}
    	}
    	return current;
    }

    private boolean trySendEcho(ServerPushEndPoint endpoint) {
    	if (endpoint == null || desktop.get() == null) {
    		return false;
    	}
    	while (true) {
    		ServerPushEndPoint pending = echoPendingEndPoint.get();
    		if (pending == endpoint) {
    			return true;
    		}
    		if (echoPendingEndPoint.compareAndSet(pending, endpoint)) {
    			if (endpoint.sendEcho()) {
    				return true;
    			}
    			echoPendingEndPoint.compareAndSet(endpoint, null);
    			return false;
    		}
    	}
    }

    private void clearPendingEcho(ServerPushEndPoint endpoint) {
    	if (endpoint != null) {
    		echoPendingEndPoint.compareAndSet(endpoint, null);
    	}
    }

    private void cancelPendingEchoRetry() {
    	ScheduledFuture<?> future = pendingEchoRetryFuture.getAndSet(null);
    	if (future != null) {
    		future.cancel(false);
    	}
    	echoRetryScheduled.set(false);
    }

    private void triggerEcho() {
    	Desktop dt = desktop.get();
    	if (dt == null) {
    		return;
    	}

    	String dtid = dt.getId();
    	ServerPushEndPoint endPoint = getEndPoint(dtid);
    	if (endPoint != null && trySendEcho(endPoint)) {
    		return;
    	}

    	ServerPushEndPoint reconnected = getEndPoint(dtid);
    	if (reconnected != null && reconnected != endPoint && hasPendingSchedules() && trySendEcho(reconnected)) {
    		return;
    	}

    	if (dt.isServerPushEnabled() && hasPendingSchedules()) {
    		scheduleEchoRetry();
    	}
    }

    private void scheduleEchoRetry() {
    	if (echoRetryScheduled.compareAndSet(false, true)) {
    		scheduleEchoRetryAttempt(0);
    	}
    }

    private void scheduleEchoRetryAttempt(int attempt) {
    	Desktop dt = desktop.get();
    	if (dt == null || !dt.isServerPushEnabled() || !hasPendingSchedules()) {
    		pendingEchoRetryFuture.set(null);
    		echoRetryScheduled.set(false);
    		return;
    	}
    	ScheduledExecutorService scheduler = getEchoRetryExecutor();
    	if (scheduler == null) {
    		pendingEchoRetryFuture.set(null);
    		echoRetryScheduled.set(false);
    		return;
    	}
    	try {
    		ScheduledFuture<?> future = scheduler.schedule(
    				() -> runEchoRetryAttempt(attempt), ECHO_RETRY_DELAY_MS, TimeUnit.MILLISECONDS);
    		pendingEchoRetryFuture.set(future);
    		if (desktop.get() == null) {
    			cancelPendingEchoRetry();
    		}
    	} catch (RejectedExecutionException e) {
    		pendingEchoRetryFuture.set(null);
    		echoRetryScheduled.set(false);
    	}
    }

    private void runEchoRetryAttempt(int attempt) {
    	pendingEchoRetryFuture.set(null);
    	Desktop dt = desktop.get();
    	if (dt == null || !dt.isServerPushEnabled() || !hasPendingSchedules()) {
    		echoRetryScheduled.set(false);
    		return;
    	}
    	ServerPushEndPoint endPoint = getEndPoint(dt.getId());
    	if (endPoint != null && trySendEcho(endPoint)) {
    		echoRetryScheduled.set(false);
    		return;
    	}
    	if (attempt + 1 < MAX_ECHO_RETRIES) {
    		scheduleEchoRetryAttempt(attempt + 1);
    	} else {
    		echoRetryScheduled.set(false);
    	}
    }

    private boolean hasPendingSchedules() {
    	synchronized (schedules) {
    		return !schedules.isEmpty();
    	}
    }

    private void flushPendingEchoOnReconnect(ServerPushEndPoint endpoint) {
    	Desktop dt = desktop.get();
    	if (endpoint == null || dt == null || !hasPendingSchedules()) {
    		return;
    	}
    	if (trySendEcho(endpoint)) {
    		cancelPendingEchoRetry();
    	} else if (dt.isServerPushEnabled() && hasPendingSchedules()) {
    		scheduleEchoRetry();
    	}
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
					active.carryOver = null;
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
    	echoPendingEndPoint.set(null);
    	cancelPendingEchoRetry();

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
        				if (existing == null && activeDesktops.containsKey(dtid) && unregisterMap.remove(dtid, Boolean.TRUE)) {
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
    		triggerEcho();
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
        	activeDesktops.put(dtid, this);
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
		flushPendingBrowserCookies(desktop, exec, System.currentTimeMillis());
	}

	static void flushPendingBrowserCookies(Desktop desktop, Execution exec, long nowMillis) {
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
						if (cookie.maxAgeSeconds != null && cookie.maxAgeSeconds <= 0) {
							browserCookie.setMaxAge(0);
						} else if (cookie.expiryDate != null) {
							long remainingMs = cookie.expiryDate.getTime() - nowMillis;
							long remainingSeconds = remainingMs <= 0L ? 0L
									: (remainingMs / 1000L) + (remainingMs % 1000L != 0L ? 1L : 0L);
							browserCookie.setMaxAge((int) Math.min(Integer.MAX_VALUE, remainingSeconds));
						} else if (cookie.maxAgeSeconds != null) {
							browserCookie.setMaxAge(cookie.maxAgeSeconds);
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
								(cookie.getExpiryDate().getTime() - nowMillis) / 1000L);
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
				new AuScript(null, "org.idempiere.websocket.startServerPush("
						+ JSONValue.toJSONString(desktop.getId()) + ", "
						+ ServerPushEndPoint.getMaxTextMessageSize() + ");"));
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

        echoPendingEndPoint.set(null);
        cancelPendingEchoRetry();
        unresolvedTimedOutAu = null;
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
		private volatile boolean cancelled;
		private ExecutionCarryOver carryOver;
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

	static ServerPushEndPoint.TimedOutAu getUnresolvedTimedOutAu(String dtid) {
		if (dtid == null) {
			return null;
		}
		WebSocketServerPush active = activeDesktops.get(dtid);
		return active != null ? active.unresolvedTimedOutAu : null;
	}

	static void setUnresolvedTimedOutAu(String dtid, ServerPushEndPoint.TimedOutAu timedOutAu) {
		if (dtid == null) {
			return;
		}
		WebSocketServerPush active = activeDesktops.get(dtid);
		if (active != null) {
			active.unresolvedTimedOutAu = timedOutAu;
		}
	}

	static void clearUnresolvedTimedOutAu(String dtid, ServerPushEndPoint.TimedOutAu expected) {
		if (dtid == null) {
			return;
		}
		WebSocketServerPush active = activeDesktops.get(dtid);
		if (active != null && active.unresolvedTimedOutAu == expected) {
			active.unresolvedTimedOutAu = null;
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
		WebSocketServerPush[] owner = new WebSocketServerPush[1];
		ServerPushEndPoint[] superseded = new ServerPushEndPoint[1];
		endPointMap.compute(dtid, (k, existing) -> {
			WebSocketServerPush active = activeDesktops.get(dtid);
			if (active == null && existing == null) {
				return null;
			}
			unregisterMap.remove(dtid);
			registered[0] = true;
			owner[0] = active;
			if (existing != null && existing != STUB && existing != endpoint) {
				superseded[0] = existing;
			}
			return endpoint;
		});
		if (superseded[0] != null) {
			if (owner[0] != null) {
				owner[0].clearPendingEcho(superseded[0]);
			}
			superseded[0].close();
		}
		if (registered[0] && owner[0] != null) {
			owner[0].flushPendingEchoOnReconnect(endpoint);
		}
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
		WebSocketServerPush[] owner = new WebSocketServerPush[1];
		ServerPushEndPoint[] removedEndpoint = new ServerPushEndPoint[1];
		endPointMap.computeIfPresent(dtid, (k, existing) -> {
			removed[0] = true;
			removedEndpoint[0] = existing;
			owner[0] = activeDesktops.get(dtid);
			if (existing != STUB && owner[0] != null) {
				unregisterMap.put(dtid, Boolean.TRUE);
			}
			return null;
		});
		if (removed[0] && owner[0] != null && removedEndpoint[0] != null && removedEndpoint[0] != STUB) {
			owner[0].clearPendingEcho(removedEndpoint[0]);
		}
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
		WebSocketServerPush[] owner = new WebSocketServerPush[1];
		endPointMap.computeIfPresent(dtid, (k, existing) -> {
			if (existing != endpoint) {
				return existing;
			}
			removed[0] = true;
			owner[0] = activeDesktops.get(dtid);
			if (endpoint != STUB && owner[0] != null) {
				unregisterMap.put(dtid, Boolean.TRUE);
			}
			return null;
		});
		if (removed[0] && owner[0] != null) {
			owner[0].clearPendingEcho(endpoint);
		}
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
		return dtid != null && (activeDesktops.containsKey(dtid) || endPointMap.containsKey(dtid));
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
