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
package org.adempiere.webui.util;

import java.util.List;
import java.util.concurrent.atomic.LongAdder;

import org.zkoss.zk.au.AuRequest;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.util.Monitor;

/**
 * Adapted from {@link org.zkoss.zk.ui.util.Statistic} 
 * @author hengsin
 *
 */
public class Statistic implements Monitor {
	private final long _startTime;
	private LongAdder _nsess = new LongAdder();
	private LongAdder _actsess = new LongAdder();
	private LongAdder _ndt = new LongAdder();
	private LongAdder _actdt = new LongAdder();
	private LongAdder _nupd = new LongAdder();
	private LongAdder _actupd = new LongAdder();;

	public Statistic() {
		_startTime = System.currentTimeMillis();
	}

	/** Returns when the server (actually, this monitor) started.
	 */
	public long getStartTime() {
		return _startTime;
	}

	/** Returns the total number of sessions that have been created
	 * since the server started.
	 */
	public long getTotalSessionCount() {
		return _nsess.longValue();
	}

	/** Returns the number of active sessions.
	 */
	public long getActiveSessionCount() {
		return _actsess.longValue();
	}

	/** Returns the average number of sessions being created in an hour.
	 */
	public double getAverageSessionCount() {
		return _nsess.longValue() / getEscapedHours();
	}

	/** Returns the total number of desktops that have been created
	 * since the server started.
	 */
	public long getTotalDesktopCount() {
		return _ndt.longValue();
	}

	/** Returns the number of active desktops.
	 */
	public long getActiveDesktopCount() {
		return _actdt.longValue();
	}

	/** Returns the average number of desktops being created in an hour.
	 */
	public double getAverageDesktopCount() {
		return _ndt.longValue() / getEscapedHours();
	}

	/** Returns the total number of asynchronous updates that have been received
	 * since the server started.
	 */
	public long getTotalUpdateCount() {
		return _nupd.longValue();
	}

	/** Returns the number of active asynchronous updates.
	 */
	public long getActiveUpdateCount() {
		return _actupd.longValue();
	}

	/** Returns the average number of asynchronous updates being created
	 * in an hour.
	 */
	public double getAverageUpdateCount() {
		return _nupd.longValue() / getEscapedHours();
	}

	/** Returns how many hours escaped since the server started.
	 */
	private double getEscapedHours() {
		long v = System.currentTimeMillis() - _startTime;
		return ((double) v) / 3600000;
	}

	//-- Monitor --//
	@Override
	public void sessionCreated(Session sess) {
		_nsess.increment();
		_actsess.increment();
	}

	@Override
	public void sessionDestroyed(Session sess) {
		_actsess.decrement();
	}

	@Override
	public void desktopCreated(Desktop desktop) {
		_ndt.increment();
		_actdt.increment();
		DesktopWatchDog.addDesktop(desktop);
	}

	@Override
	public void desktopDestroyed(Desktop desktop) {
		_actdt.decrement();
	}

	@Override
	public void beforeUpdate(Desktop desktop, List<AuRequest> requests) {
		_nupd.increment();
		_actupd.increment();
	}

	@Override
	public void afterUpdate(Desktop desktop) {
		_actupd.decrement();
	}
}
