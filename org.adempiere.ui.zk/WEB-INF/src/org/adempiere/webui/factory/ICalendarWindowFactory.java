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
 **********************************************************************/

package org.adempiere.webui.factory;

import org.zkoss.calendar.impl.SimpleCalendarModel;

/**
 * Factory to open the calendar window of the calendar dashboard gadget.<br/>
 * Implement this interface and register it as an OSGi service with a {@code service.ranking}
 * higher than the default implementation to replace the calendar window.
 * @see DefaultCalendarWindowFactory
 */
public interface ICalendarWindowFactory
{
	/**
	 * Create the calendar window and show it (as a tab of the desktop).
	 * @param scm calendar model shared with the caller
	 */
	public void openCalendarWindow(SimpleCalendarModel scm);
}
