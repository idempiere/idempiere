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
package org.idempiere.test.print;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import org.compiere.print.DrillReportCtl;
import org.compiere.util.DisplayType;
import org.junit.jupiter.api.Test;

/**
 * Tests the conversion of drill rule parameter defaults to timestamps in {@link DrillReportCtl}.
 * Needs no database: the protected constructor builds the controller without a record.
 */
public class DrillReportCtlTest {

	/** Gives the test access to the protected conversion methods */
	private static class TestDrillReportCtl extends DrillReportCtl {
		TestDrillReportCtl() {
			super();
		}

		@Override
		public Timestamp toTimestamp(int displayType, Object value) {
			return super.toTimestamp(displayType, value);
		}

		@Override
		public Timestamp getDateTimeParsed(int displayType, String value) {
			return super.getDateTimeParsed(displayType, value);
		}
	}

	private final TestDrillReportCtl ctl = new TestDrillReportCtl();

	@Test
	public void testDateOnlyValueForDateParameter() {
		Timestamp ts = ctl.toTimestamp(DisplayType.Date, "2026-01-01");
		assertEquals(LocalDateTime.of(2026, 1, 1, 0, 0, 0), ts.toLocalDateTime());
	}

	@Test
	public void testTimeOnlyValueForTimeParameter() {
		Timestamp ts = ctl.toTimestamp(DisplayType.Time, "10:30:15");
		assertEquals(10, ts.toLocalDateTime().getHour());
		assertEquals(30, ts.toLocalDateTime().getMinute());
		assertEquals(15, ts.toLocalDateTime().getSecond());
	}

	@Test
	public void testFullTimestampValueForDateTimeParameter() {
		Timestamp ts = ctl.toTimestamp(DisplayType.DateTime, "2026-01-01 10:30:15");
		assertEquals(LocalDateTime.of(2026, 1, 1, 10, 30, 15), ts.toLocalDateTime());
	}

	@Test
	public void testFullTimestampValueForDateParameterKeepsTheDay() {
		// the "#Date" context value is a full timestamp
		Timestamp ts = ctl.toTimestamp(DisplayType.Date, "2026-01-01 10:30:15");
		assertEquals(LocalDateTime.of(2026, 1, 1, 0, 0, 0), ts.toLocalDateTime());
	}

	@Test
	public void testDateOnlyValueForDateTimeParameterFallsBackToDate() {
		Timestamp ts = ctl.toTimestamp(DisplayType.DateTime, "2026-01-01");
		assertEquals(LocalDateTime.of(2026, 1, 1, 0, 0, 0), ts.toLocalDateTime());
	}

	@Test
	public void testTimestampValueIsReturnedUnchanged() {
		Timestamp value = Timestamp.valueOf("2026-03-04 05:06:07");
		assertSame(value, ctl.toTimestamp(DisplayType.Date, value));
	}

	@Test
	public void testEmptyValueGivesNull() {
		assertNull(ctl.getDateTimeParsed(DisplayType.Date, null));
		assertNull(ctl.getDateTimeParsed(DisplayType.Date, ""));
		assertNull(ctl.getDateTimeParsed(DisplayType.Date, "  "));
	}

	@Test
	public void testUnparseableValueThrows() {
		assertThrows(IllegalArgumentException.class, () -> ctl.toTimestamp(DisplayType.Date, "not a date"));
		assertThrows(IllegalArgumentException.class, () -> ctl.toTimestamp(DisplayType.Time, "not a time"));
	}
}
