/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or      *
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
 **********************************************************************/
package org.adempiere.webui.session;

import java.util.Set;
import java.util.logging.Level;

import javax.servlet.http.HttpSession;

import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.au.AuRequest;
import org.zkoss.zk.au.AuService;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.util.Clients;

/**
 * Idle session tracking for the session timeout warning (POC).
 * <p>
 * iDempiere keeps its own last user activity time stamp in the HTTP session. It is updated only by
 * user initiated AU requests, which are a subset of the requests ZK counts as activity
 * ({@code DHtmlUpdateServlet}: every command except onTimer and dummy). Therefore our deadline is
 * never later than the ZK or servlet container deadline, and enforcing it makes it the real end of
 * the session.
 */
public class SessionTimeoutMonitor implements AuService {

	/** POC: belongs in MSysConfig. Seconds before the idle timeout to show the warning, 0 = off */
	public static final String ZK_SESSION_TIMEOUT_WARNING_IN_SECONDS = "ZK_SESSION_TIMEOUT_WARNING_IN_SECONDS";
	/** HTTP session attribute holding the last user activity time in milliseconds */
	public static final String ATTR_LAST_USER_ACTIVITY = SessionTimeoutMonitor.class.getName() + ".LastUserActivity";
	/** Desktop attribute flag to register the AU service only once per desktop */
	private static final String ATTR_REGISTERED = SessionTimeoutMonitor.class.getName() + ".Registered";

	/** Client command: user input or Continue button */
	public static final String ON_SESSION_ACTIVE = "onSessionActive";
	/** Client command: Log out button */
	public static final String ON_SESSION_LOGOUT = "onSessionLogout";
	/** Client command: countdown reached zero */
	public static final String ON_SESSION_TIMEOUT = "onSessionTimeout";

	/** Returned by {@link #getSecondsLeft(HttpSession)} when the session is not tracked */
	public static final long NOT_TRACKED = -2;

	/** AU commands that are not user activity */
	private static final Set<String> NON_ACTIVITY_COMMANDS = Set.of(
			"onTimer", "dummy", "echo", "onPiggyback", "rmDesktop", "onClientInfo", "onUserToken");

	private static final CLogger log = CLogger.getCLogger(SessionTimeoutMonitor.class);

	/**
	 * Start tracking after login: stamp the session, register the AU service and start the client script.
	 * @param desktop
	 */
	public static void start(Desktop desktop) {
		HttpSession httpSession = (HttpSession) desktop.getSession().getNativeSession();
		int timeout = httpSession.getMaxInactiveInterval();
		int warning = getWarningSeconds(timeout);
		if (warning <= 0) {
			// feature off: no stamp, so the session is not tracked and nothing is enforced
			httpSession.removeAttribute(ATTR_LAST_USER_ACTIVITY);
			return;
		}
		httpSession.setAttribute(ATTR_LAST_USER_ACTIVITY, Long.valueOf(System.currentTimeMillis()));
		if (desktop.getAttribute(ATTR_REGISTERED) == null) {
			desktop.addListener(new SessionTimeoutMonitor());
			desktop.setAttribute(ATTR_REGISTERED, Boolean.TRUE);
		}
		// developer mode shows a countdown badge in the header to validate the timer
		Clients.evalJavaScript("zk.load('org.idempiere.session', function() {org.idempiere.session.start("
				+ timeout + "," + warning + "," + Util.isDeveloperMode() + ");});");
	}

	/**
	 * @param timeout effective session timeout in seconds
	 * @return seconds before timeout to show the warning, 0 for no warning
	 */
	public static int getWarningSeconds(int timeout) {
		if (timeout <= 0)
			return 0;
		int warning = MSysConfig.getIntValue(ZK_SESSION_TIMEOUT_WARNING_IN_SECONDS, 60,
				Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));
		if (warning <= 0)
			return 0;
		if (warning >= timeout)
			warning = timeout / 2;
		return warning;
	}

	/** Minimum interval between two writes of the activity stamp (limits session replication writes) */
	private static final long TOUCH_INTERVAL_MILLIS = 1000;

	/**
	 * Record user activity now. Only a tracked session is updated, and at most once per
	 * {@link #TOUCH_INTERVAL_MILLIS}.
	 * @param httpSession
	 */
	public static void touch(HttpSession httpSession) {
		try {
			Object last = httpSession.getAttribute(ATTR_LAST_USER_ACTIVITY);
			if (!(last instanceof Long))
				return;
			long now = System.currentTimeMillis();
			if (now - ((Long) last).longValue() >= TOUCH_INTERVAL_MILLIS)
				httpSession.setAttribute(ATTR_LAST_USER_ACTIVITY, Long.valueOf(now));
		} catch (IllegalStateException e) {
			// session already invalidated, nothing to record
		}
	}

	/**
	 * Does not count as activity and does not touch the session's last accessed time.
	 * @param httpSession
	 * @return seconds left before idle timeout (0 when the deadline has passed), or {@link #NOT_TRACKED}
	 */
	public static long getSecondsLeft(HttpSession httpSession) {
		Object last = httpSession.getAttribute(ATTR_LAST_USER_ACTIVITY);
		int timeout = httpSession.getMaxInactiveInterval();
		if (!(last instanceof Long) || timeout <= 0)
			return NOT_TRACKED;
		long idleMillis = System.currentTimeMillis() - ((Long) last).longValue();
		return Math.max(0, timeout - (idleMillis / 1000));
	}

	/** WebSocket message to query the idle session status */
	public static final String STATUS_MESSAGE = "__session__";

	/**
	 * Handle the {@link #STATUS_MESSAGE} WebSocket query.
	 * Does not count as activity and does not touch the ZK or servlet session clocks.
	 * It does not end the session: the WebSocket thread has no ZK execution, so the iDempiere logout
	 * cannot run here. At 0 the client sends {@link #ON_SESSION_TIMEOUT} and {@link #service} logs out.
	 * @param httpSession
	 * @return reply "__session__:secondsLeft" ({@link #NOT_TRACKED} when not tracked, 0 when expired)
	 */
	public static String getStatusReply(HttpSession httpSession) {
		long left;
		try {
			left = getSecondsLeft(httpSession);
		} catch (IllegalStateException e) {
			left = 0; // already invalidated
		}
		return STATUS_MESSAGE + ":" + left;
	}

	@Override
	public boolean service(AuRequest request, boolean everError) {
		String command = request.getCommand();
		HttpSession httpSession = (HttpSession) request.getDesktop().getSession().getNativeSession();
		long left;
		try {
			left = getSecondsLeft(httpSession);
		} catch (IllegalStateException e) {
			return false;
		}
		if (left == NOT_TRACKED)
			return false;

		if (left <= 0) {
			// our deadline has passed (countdown reached zero, or computer was asleep): full iDempiere
			// logout, the same as Kill Current Session (stops background threads, closes AD_Session)
			if (log.isLoggable(Level.INFO))
				log.info("Idle session timeout reached, logging out on command " + command);
			SessionManager.logoutSession();
			return true;
		}

		if (ON_SESSION_TIMEOUT.equals(command)) {
			// another tab was active meanwhile: let the client resynchronise
			Clients.evalJavaScript("org.idempiere.session.resume(" + left + ");");
			return true;
		}

		if (ON_SESSION_ACTIVE.equals(command)) {
			touch(httpSession);
			return true;
		}
		if (ON_SESSION_LOGOUT.equals(command)) {
			SessionManager.logoutSession();
			return true;
		}
		if (!NON_ACTIVITY_COMMANDS.contains(command))
			touch(httpSession);
		return false;
	}
}
