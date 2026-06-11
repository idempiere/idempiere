/**********************************************************************
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
* - Norbert Bede, Cloudempiere                                        *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.idempiere.redis.service.health;

/**
 * Callback invoked by {@link RedisHealth} on circuit-breaker state transitions.
 *
 * <p>Kept as a plain interface (rather than a direct dependency on OSGi
 * {@code EventAdmin}) so {@link RedisHealth} stays unit-testable without an
 * OSGi runtime. The Activator wires an EventAdmin-publishing implementation at
 * bundle start; the listener is invoked synchronously from whichever thread
 * triggered the transition, so implementations must be cheap and non-blocking.
 */
@FunctionalInterface
public interface StateListener {

	/**
	 * Called once per actual state change (no-op transitions are filtered upstream).
	 *
	 * @param previous the state before the transition
	 * @param current  the state after the transition
	 */
	void onStateChange(RedisHealth.State previous, RedisHealth.State current);
}
