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
 * - Peter Takacs, Cloudempiere                                       *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Locale;

import org.compiere.model.MChart;
import org.compiere.model.MDateRange;
import org.junit.jupiter.api.Test;

/**
 * Test cases for the resolution of relative date ranges, {@link MDateRange#getInterval(String, int, int, LocalDate, Locale)}
 */
public class MDateRangeTest {

	private static final Locale US = Locale.US; // week starts on Sunday
	private static final Locale GERMANY = Locale.GERMANY; // week starts on Monday

	private static void assertInterval(String from, String to, Timestamp[] interval) {
		assertEquals(Timestamp.valueOf(from + " 00:00:00.000"), interval[0], "date from");
		assertEquals(Timestamp.valueOf(to + " 23:59:59.999"), interval[1], "date to");
	}

	@Test
	public void testToday() {
		assertInterval("2026-10-09", "2026-10-09",
				MDateRange.getInterval(MChart.TIMEUNIT_Day, 0, 1, LocalDate.of(2026, 10, 9), US));
	}

	@Test
	public void testYesterdayAcrossMonthBoundary() {
		assertInterval("2026-02-28", "2026-02-28",
				MDateRange.getInterval(MChart.TIMEUNIT_Day, -1, 1, LocalDate.of(2026, 3, 1), US));
	}

	@Test
	public void testLastThirtyDaysIncludesReferenceDay() {
		assertInterval("2026-09-10", "2026-10-09",
				MDateRange.getInterval(MChart.TIMEUNIT_Day, -29, 30, LocalDate.of(2026, 10, 9), US));
	}

	@Test
	public void testWeekStartDependsOnLocale() {
		LocalDate friday = LocalDate.of(2026, 10, 9);
		assertInterval("2026-10-04", "2026-10-10", MDateRange.getInterval(MChart.TIMEUNIT_Week, 0, 1, friday, US));
		assertInterval("2026-10-05", "2026-10-11", MDateRange.getInterval(MChart.TIMEUNIT_Week, 0, 1, friday, GERMANY));
		assertInterval("2026-09-28", "2026-10-04", MDateRange.getInterval(MChart.TIMEUNIT_Week, -1, 1, friday, GERMANY));
	}

	@Test
	public void testLastMonthAcrossYearBoundary() {
		assertInterval("2025-12-01", "2025-12-31",
				MDateRange.getInterval(MChart.TIMEUNIT_Month, -1, 1, LocalDate.of(2026, 1, 15), US));
	}

	@Test
	public void testLeapDay() {
		assertInterval("2028-02-01", "2028-02-29",
				MDateRange.getInterval(MChart.TIMEUNIT_Month, -1, 1, LocalDate.of(2028, 3, 15), US));
		assertInterval("2028-02-29", "2028-02-29",
				MDateRange.getInterval(MChart.TIMEUNIT_Day, 0, 1, LocalDate.of(2028, 2, 29), US));
	}

	@Test
	public void testQuarters() {
		assertInterval("2026-10-01", "2026-12-31",
				MDateRange.getInterval(MChart.TIMEUNIT_Quarter, 0, 1, LocalDate.of(2026, 11, 3), US));
		// last quarter of January is the fourth quarter of the previous year
		assertInterval("2025-10-01", "2025-12-31",
				MDateRange.getInterval(MChart.TIMEUNIT_Quarter, -1, 1, LocalDate.of(2026, 1, 20), US));
		assertInterval("2026-01-01", "2026-06-30",
				MDateRange.getInterval(MChart.TIMEUNIT_Quarter, 0, 2, LocalDate.of(2026, 2, 10), US));
	}

	@Test
	public void testYears() {
		assertInterval("2025-01-01", "2025-12-31",
				MDateRange.getInterval(MChart.TIMEUNIT_Year, -1, 1, LocalDate.of(2026, 6, 15), US));
		assertInterval("2024-01-01", "2026-12-31",
				MDateRange.getInterval(MChart.TIMEUNIT_Year, -2, 3, LocalDate.of(2026, 6, 15), US));
	}

	@Test
	public void testScopeBelowOneIsOneUnit() {
		assertInterval("2026-10-01", "2026-10-31",
				MDateRange.getInterval(MChart.TIMEUNIT_Month, 0, 0, LocalDate.of(2026, 10, 9), US));
	}

	@Test
	public void testUnknownTimeUnit() {
		assertNull(MDateRange.getInterval("X", 0, 1, LocalDate.of(2026, 10, 9), US));
	}
}
