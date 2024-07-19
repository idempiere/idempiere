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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.compiere.model.X_C_NonBusinessDay;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class TimeUtilTest extends AbstractTestCase {

	public TimeUtilTest() {
	}

	@Test
	public void testTrunc() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		
		try {
			GregorianCalendar cal = new GregorianCalendar(Language.getLoginLanguage().getLocale());
			Timestamp source = Timestamp.from(sdf.parse("2022-10-28 11:11:00.000").toInstant());
			
			Timestamp dayTarget = Timestamp.from(sdf.parse("2022-10-28 00:00:00.000").toInstant());
			Timestamp truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_DAY);
			assertEquals(dayTarget, truncated, "TRUNC_DAY not working as expected");			
			
			Timestamp weekTarget = null;
			if (cal.getFirstDayOfWeek() == Calendar.SUNDAY)
				weekTarget = Timestamp.from(sdf.parse("2022-10-23 00:00:00.000").toInstant());
			else
				weekTarget = Timestamp.from(sdf.parse("2022-10-24 00:00:00.000").toInstant());
			truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_WEEK);
			assertEquals(weekTarget, truncated, "TRUNC_WEEK not working as expected");
			
			Timestamp monthTarget = Timestamp.from(sdf.parse("2022-10-01 00:00:00.000").toInstant());
			truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_MONTH);
			assertEquals(monthTarget, truncated, "TRUNC_MONTH not working as expected");
			
			Timestamp yearTarget = Timestamp.from(sdf.parse("2022-01-01 00:00:00.000").toInstant());
			truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_YEAR);
			assertEquals(yearTarget, truncated, "TRUNC_YEAR not working as expected");
			
			Timestamp quarter4 = Timestamp.from(sdf.parse("2022-10-01 00:00:00.000").toInstant());
			truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_QUARTER);
			assertEquals(quarter4, truncated, "TRUNC_QUARTER not working as expected for October");
			
			source = Timestamp.from(sdf.parse("2022-09-28 11:11:00.000").toInstant());
			Timestamp quarter3 = Timestamp.from(sdf.parse("2022-07-01 00:00:00.000").toInstant());
			truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_QUARTER);
			assertEquals(quarter3, truncated, "TRUNC_QUARTER not working as expected for September");
			
			source = Timestamp.from(sdf.parse("2022-06-28 11:11:00.000").toInstant());
			Timestamp quarter2 = Timestamp.from(sdf.parse("2022-04-01 00:00:00.000").toInstant());
			truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_QUARTER);
			assertEquals(quarter2, truncated, "TRUNC_QUARTER not working as expected for June");
			
			source = Timestamp.from(sdf.parse("2022-03-28 11:11:00.000").toInstant());
			Timestamp quarter1 = Timestamp.from(sdf.parse("2022-01-01 00:00:00.000").toInstant());
			truncated = TimeUtil.trunc(source, TimeUtil.TRUNC_QUARTER);
			assertEquals(quarter1, truncated, "TRUNC_QUARTER not working as expected for March");
		} catch (ParseException e) {
			fail(e);
		}
	}
	
	@Test
	public void testGetDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		try {
			Timestamp source = Timestamp.from(sdf.parse("2022-10-28 11:11:00.000").toInstant());
			Timestamp dayTarget = Timestamp.from(sdf.parse("2022-10-28 00:00:00.000").toInstant());
			assertEquals(dayTarget, TimeUtil.getDay(source), "getDay not working as expected");
			
			Timestamp nextDayTarget = Timestamp.from(sdf.parse("2022-10-29 00:00:00.000").toInstant());
			assertEquals(nextDayTarget, TimeUtil.getNextDay(source), "getNextDay not working as expected");
			
			Timestamp previousDayTarget = Timestamp.from(sdf.parse("2022-10-27 00:00:00.000").toInstant());
			assertEquals(previousDayTarget, TimeUtil.getPreviousDay(source), "getPreviousDay not working as expected");
			
			Timestamp monthLastDayTarget = Timestamp.from(sdf.parse("2022-10-31 00:00:00.000").toInstant());
			assertEquals(monthLastDayTarget, TimeUtil.getMonthLastDay(source), "getMonthLastDay not working as expected");
			
			Timestamp monthFirstDayTarget = Timestamp.from(sdf.parse("2022-10-01 00:00:00.000").toInstant());
			assertEquals(monthFirstDayTarget, TimeUtil.getMonthFirstDay(source), "getMonthFirstDay not working as expected");
			
			Timestamp from = Timestamp.from(sdf.parse("2022-10-01 00:00:00.000").toInstant());;
			Timestamp to = source;
			assertEquals(27, TimeUtil.getDaysBetween(from, to), "getDaysBetween not working as expected for positive difference");
			assertEquals(-27, TimeUtil.getDaysBetween(to, from), "getDaysBetween not working as expected for negative difference");
			
			from = Timestamp.from(sdf.parse("2021-10-01 00:00:00.000").toInstant());
			assertEquals(392, TimeUtil.getDaysBetween(from, source), "getDaysBetween not working as expected for cross year positive difference");
			assertEquals(-392, TimeUtil.getDaysBetween(source, from), "getDaysBetween not working as expected for cross year negative difference");
			assertEquals(12, TimeUtil.getMonthsBetween(from, source), "getMonthsBetween not working as expected");
			
			Timestamp datePart = Timestamp.from(sdf.parse("2022-09-28 00:00:00.000").toInstant());
			Timestamp timePart = source;
			Timestamp combine = Timestamp.from(sdf.parse("2022-09-28 11:11:00.000").toInstant());
			assertEquals(combine, TimeUtil.getDayBorder(datePart, timePart, false), "getDayBorder doesn't combine date part and time part as expected");
			assertEquals(combine, TimeUtil.getDayTime(datePart, timePart), "getDayTime doesn't combine date part and time part as expected");
			assertEquals(datePart, TimeUtil.getDayBorder(combine, null, false), "getDayBorder doesn't return start of day date as expected");
			Timestamp endOfDay = Timestamp.from(sdf.parse("2022-09-28 23:59:59.999").toInstant());
			assertEquals(endOfDay, TimeUtil.getDayBorder(combine, null, true), "getDayBorder doesn't return end of day date as expected");
		} catch (ParseException e) {
			fail(e);
		}
	}
	
	@Test
	public void testValidation() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		
		try {
			//end1 in range2
			Timestamp from1 = Timestamp.from(sdf.parse("2022-10-20 00:00:00.000").toInstant());
			Timestamp to1 = Timestamp.from(sdf.parse("2022-10-25 00:00:00.000").toInstant());
			Timestamp from2 = Timestamp.from(sdf.parse("2022-10-24 00:00:00.000").toInstant());
			Timestamp to2 = Timestamp.from(sdf.parse("2022-10-28 00:00:00.000").toInstant());
			assertTrue(TimeUtil.inRange(from1, to1, from2, to2), "Wrong inRange validation");
			
			//range1 before range2
			to1 = Timestamp.from(sdf.parse("2022-10-23 00:00:00.000").toInstant());
			assertFalse(TimeUtil.inRange(from1, to1, from2, to2), "Wrong inRange validation");
			
			//start1 in range2
			from1 = Timestamp.from(sdf.parse("2022-10-26 00:00:00.000").toInstant());
			to1 = Timestamp.from(sdf.parse("2022-10-30 00:00:00.000").toInstant());
			assertTrue(TimeUtil.inRange(from1, to1, from2, to2), "Wrong inRange validation");
			
			//start1 = end of range2
			from1 = Timestamp.from(sdf.parse("2022-10-28 00:00:00.000").toInstant());
			assertFalse(TimeUtil.inRange(from1, to1, from2, to2), "Wrong inRange validation");
			
			//end1 = start of range2
			from1 = Timestamp.from(sdf.parse("2022-10-20 00:00:00.000").toInstant());
			to1 = Timestamp.from(sdf.parse("2022-10-24 00:00:00.000").toInstant());
			assertFalse(TimeUtil.inRange(from1, to1, from2, to2), "Wrong inRange validation");
			
			//range1 after range2
			from1 = Timestamp.from(sdf.parse("2022-10-25 00:00:00.000").toInstant());
			to1 = Timestamp.from(sdf.parse("2022-10-27 00:00:00.000").toInstant());
			assertTrue(TimeUtil.inRange(from1, to1, from2, to2), "Wrong inRange validation");
			
			//in range for test against day of week
			Calendar cal = TimeUtil.getToday(); 
			cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
			from1 = new Timestamp(cal.getTimeInMillis());
			cal.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
			to1 = new Timestamp(cal.getTimeInMillis());
			assertFalse(TimeUtil.inRange(from1, to1, false, false, false, false, true, true, true), "Invalid inRange validation");
			assertTrue(TimeUtil.inRange(from1, to1, false, true, false, false, false, false, false), "Invalid inRange validation");
			
			//same day and same hour check
			from1 = Timestamp.from(sdf.parse("2022-10-20 00:00:00.000").toInstant());
			to1 = Timestamp.from(sdf.parse("2022-10-24 00:00:00.000").toInstant());
			assertFalse(TimeUtil.isSameDay(from1, to1), "Invalid isSameDay validation");
			
			from1 = Timestamp.from(sdf.parse("2022-10-20 00:00:00.000").toInstant());
			to1 = Timestamp.from(sdf.parse("2022-10-20 00:00:00.000").toInstant());
			assertTrue(TimeUtil.isSameDay(from1, to1), "Invalid isSameDay validation");
			
			from1 = Timestamp.from(sdf.parse("2022-10-20 01:00:00.000").toInstant());
			to1 = Timestamp.from(sdf.parse("2022-10-24 01:00:00.000").toInstant());
			assertFalse(TimeUtil.isSameHour(from1, to1), "Invalid isSameHour validation");
			
			to1 = Timestamp.from(sdf.parse("2022-10-20 02:00:00.000").toInstant());
			assertFalse(TimeUtil.isSameHour(from1, to1), "Invalid isSameHour validation");
			
			to1 = Timestamp.from(sdf.parse("2022-10-20 01:00:00.000").toInstant());
			assertTrue(TimeUtil.isSameHour(from1, to1), "Invalid isSameHour validation");
			
			//is all day
			from1 = Timestamp.from(sdf.parse("2022-10-20 00:00:00.000").toInstant());
			to1 = Timestamp.from(sdf.parse("2022-10-20 00:00:00.000").toInstant());
			assertFalse(TimeUtil.isAllDay(from1, to1), "Invalid isAllDay validation");
			
			to1 = Timestamp.from(sdf.parse("2022-10-21 00:00:00.000").toInstant());
			assertTrue(TimeUtil.isAllDay(from1, to1), "Invalid isAllDay validation");
			
			//isvalid
			from1 = TimeUtil.getDay(System.currentTimeMillis());
			to1 = TimeUtil.addDays(from1, 1);
			assertTrue(TimeUtil.isValid(from1, to1), "Invalid isValid validation");
			
			from1 = TimeUtil.addDays(from1, -2);
			to1 = TimeUtil.addDays(from1, 1);
			assertFalse(TimeUtil.isValid(from1, to1), "Invalid isValid validation");
			
			Timestamp test1 = TimeUtil.addDays(to1, 1);
			assertFalse(TimeUtil.isValid(from1, to1, test1), "Invalid isValid validation");
			
			test1 = TimeUtil.addDays(from1, 1);
			to1 = TimeUtil.addDays(from1, 1);
			assertTrue(TimeUtil.isValid(from1, to1, test1), "Invalid isValid validation");
			
			to1 = TimeUtil.addDays(to1, 1);
			assertTrue(TimeUtil.isValid(from1, to1, test1), "Invalid isValid validation");
		} catch (ParseException e) {
			fail(e);
		}
	}
	
	@Test
	public void testNonBusinessDays() {
		Calendar cal = TimeUtil.getToday();
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		Timestamp from = new Timestamp(cal.getTimeInMillis());
		cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
		Timestamp to = new Timestamp(cal.getTimeInMillis());
		//make sure no non business days records
		DB.executeUpdateEx("DELETE FROM C_NonBusinessDay WHERE AD_Client_ID=? AND Date1 BETWEEN ? AND ?", new Object[] {getAD_Client_ID(), from, to}, getTrxName());
		
		//test add
		cal.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
		Timestamp expected = new Timestamp(cal.getTimeInMillis());
		assertEquals(expected, TimeUtil.addOnlyBusinessDays(from, 2, getAD_Client_ID(), getTrxName()));
		
		X_C_NonBusinessDay nbd = new X_C_NonBusinessDay(Env.getCtx(), 0, getTrxName());
		nbd.setName("testNonBusinessDays1");
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		nbd.setDate1(new Timestamp(cal.getTimeInMillis()));
		nbd.setC_Calendar_ID(DictionaryIDs.C_Calendar.GARDENWORLD_CALENDAR.id);
		nbd.saveEx();
		cal.set(Calendar.DAY_OF_WEEK, Calendar.THURSDAY);
		expected = new Timestamp(cal.getTimeInMillis());
		assertEquals(expected, TimeUtil.addOnlyBusinessDays(from, 2, getAD_Client_ID(), getTrxName()));
		
		//get business days
		to = expected;
		assertEquals(2, TimeUtil.getBusinessDaysBetween(from, to, getAD_Client_ID(), getTrxName()));
		assertEquals(3, TimeUtil.getBusinessDaysBetween(from, to, getAD_Client_ID(), true, getTrxName()));
		nbd.deleteEx(true);
		assertEquals(3, TimeUtil.getBusinessDaysBetween(from, to, getAD_Client_ID(), getTrxName()));
		assertEquals(4, TimeUtil.getBusinessDaysBetween(from, to, getAD_Client_ID(), true, getTrxName()));
	}
}

