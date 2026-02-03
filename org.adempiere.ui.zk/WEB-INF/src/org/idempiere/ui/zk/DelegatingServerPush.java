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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/
package org.idempiere.ui.zk;

import java.util.logging.Level;

import org.compiere.model.SystemProperties;
import org.compiere.util.CLogger;
import org.idempiere.ui.zk.websocket.WebSocketServerPush;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.DesktopUnavailableException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.sys.Scheduler;
import org.zkoss.zk.ui.sys.ServerPush;

import fi.jawsy.jawwa.zk.atmosphere.AtmosphereServerPush;

/**
 * Delegating ServerPush implementation that switches between
 * WebSocketServerPush and AtmosphereServerPush based on JVM parameter.
 * <p>
 * Usage: Set the JVM parameter {@code -Dorg.idempiere.ui.zk.serverpush=atmosphere}
 * to use AtmosphereServerPush, or {@code -Dorg.idempiere.ui.zk.serverpush=websocket}
 * (or leave unset) to use WebSocketServerPush (default).
 * </p>
 * 
 * @author Carlos Ruiz - globalqss
 */
public class DelegatingServerPush implements ServerPush {

    private final CLogger log = CLogger.getCLogger(getClass());

	/** Value for WebSocket server push */
	public static final String WEBSOCKET = "websocket";

	/** Value for Atmosphere server push */
	public static final String ATMOSPHERE = "atmosphere";

	private final ServerPush delegate;

	/**
	 * Default constructor - creates the delegate based on JVM parameter
	 */
	public DelegatingServerPush() {
		this.delegate = createDelegate();
	}

	/**
	 * Creates the appropriate ServerPush implementation based on JVM parameter.
	 * @return ServerPush implementation (WebSocketServerPush by default)
	 */
	private ServerPush createDelegate() {
		String pushType = SystemProperties.getZKServerPush();

		if (ATMOSPHERE.equalsIgnoreCase(pushType)) {
			if (log.isLoggable(Level.INFO)) log.info("Using AtmosphereServerPush");
			return new AtmosphereServerPush();
		}

		// Default to WebSocket
		if (log.isLoggable(Level.INFO)) log.info("Using WebSocketServerPush");
		return new WebSocketServerPush();
	}

	/**
	 * @return the delegate ServerPush implementation
	 */
	public ServerPush getDelegate() {
		return delegate;
	}

	@Override
	public boolean isActive() {
		return delegate.isActive();
	}

	@Override
	public void start(Desktop desktop) {
		delegate.start(desktop);
	}

	@Override
	public void stop() {
		delegate.stop();
	}

	@Override
	public <T extends Event> void schedule(EventListener<T> task, T event, Scheduler<T> scheduler) {
		delegate.schedule(task, event, scheduler);
	}

	@Override
	public void onPiggyback() {
		delegate.onPiggyback();
	}

	@Override
	public void resume() {
		delegate.resume();
	}

	@Override
	public boolean activate(long timeout) throws InterruptedException, DesktopUnavailableException {
		return delegate.activate(timeout);
	}

	@Override
	public boolean deactivate(boolean stop) {
		return delegate.deactivate(stop);
	}
}
