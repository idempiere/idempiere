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
 **********************************************************************/
package org.idempiere.test.ui;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

import org.junit.jupiter.api.Test;
import org.zkoss.calendar.api.CalendarItem;
import org.zkoss.calendar.event.CalendarsEvent;

/**
 * Pins the bundled ZK Calendar API surface that iDempiere's calendar UI
 * (DPCalendar, CalendarWindow, WSchedule, InfoSchedule) depends on.
 *
 * If a future ZK Calendar upgrade renames these constants or changes the
 * getCalendarItem() return type, this test fails at build time instead of at
 * runtime in the dashboard.
 *
 * Background: see IDEMPIERE-6984 (ZK Calendar 2.1.5 → 3.2.1 upgrade
 * renamed CalendarEvent → CalendarItem and ON_EVENT_* → ON_ITEM_*).
 */
public class CalendarApiCompatibilityTest {

	@Test
	public void testItemEventConstantsResolveToExpectedValues() {
		assertEquals("onItemCreate", CalendarsEvent.ON_ITEM_CREATE);
		assertEquals("onItemEdit",   CalendarsEvent.ON_ITEM_EDIT);
		assertEquals("onItemUpdate", CalendarsEvent.ON_ITEM_UPDATE);
	}

	@Test
	public void testItemEventConstantsAreDistinct() {
		assertNotEquals(CalendarsEvent.ON_ITEM_CREATE, CalendarsEvent.ON_ITEM_EDIT);
		assertNotEquals(CalendarsEvent.ON_ITEM_CREATE, CalendarsEvent.ON_ITEM_UPDATE);
		assertNotEquals(CalendarsEvent.ON_ITEM_EDIT,   CalendarsEvent.ON_ITEM_UPDATE);
	}

	@Test
	public void testGetCalendarItemReturnTypeIsCalendarItem() throws NoSuchMethodException {
		assertEquals(CalendarItem.class,
				CalendarsEvent.class.getMethod("getCalendarItem").getReturnType());
	}
}
