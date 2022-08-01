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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.TimeZone;

import org.compiere.model.MClientInfo;
import org.compiere.model.MSchedule;
import org.compiere.model.MScheduler;
import org.compiere.model.PO;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class MSchedulerTest extends AbstractTestCase {

	/**
	 * 
	 */
	public MSchedulerTest() {
	}

	@Test
	public void testCronSchedulingPatternWithTimeZone() {
		MSchedule schedule = null;
		MClientInfo clientInfo = MClientInfo.getCopy(Env.getCtx(), getAD_Client_ID(), null);
		String currentTimeZone = clientInfo.getTimeZone();
		try {
			schedule = new MSchedule(Env.getCtx(), 0, null);
			schedule.setName("Every Day at 5 pm Test");
			schedule.setScheduleType(MSchedule.SCHEDULETYPE_CronSchedulingPattern);
			schedule.setIsSystemSchedule(false);
			schedule.setCronPattern("0 17 * * *");
			try {
				PO.setCrossTenantSafe();
				schedule.saveEx();
			} finally {
				PO.clearCrossTenantSafe();
			}
			
			//get jvm timezone
			//this test assume jvm and db server is using the same default time zone
			TimeZone tz1 = TimeZone.getDefault();
			Calendar cal1 = Calendar.getInstance();
			cal1.setTimeZone(tz1);
			cal1.setTimeInMillis(System.currentTimeMillis());
			int hour = cal1.get(Calendar.HOUR_OF_DAY);
			if (hour >= 17) {
				cal1.add(Calendar.DAY_OF_MONTH, 1);
			}
			cal1.set(Calendar.HOUR_OF_DAY, 17);
			cal1.set(Calendar.MINUTE, 0);
			cal1.set(Calendar.SECOND, 0);
			cal1.set(Calendar.MILLISECOND, 0);
			
			//get timezone with +2 hour offset
			String[] ids = TimeZone.getAvailableIDs(tz1.getRawOffset()+(2*60*60*1000));
			TimeZone tz2 = TimeZone.getTimeZone(ids[0]);
			Calendar cal2 = Calendar.getInstance();
			cal2.setTimeZone(tz2);
			cal2.setTimeInMillis(System.currentTimeMillis());
			hour = cal2.get(Calendar.HOUR_OF_DAY);
			if (hour >= 17) {
				cal2.add(Calendar.DAY_OF_MONTH, 1);
			}
			cal2.set(Calendar.HOUR_OF_DAY, 17);
			cal2.set(Calendar.MINUTE, 0);
			cal2.set(Calendar.SECOND, 0);
			cal2.set(Calendar.MILLISECOND, 0);
			
			//formatter for comparison
			DateTimeFormatter formatter1 = DateTimeFormatter.ISO_ZONED_DATE_TIME;
			formatter1 = formatter1.withZone(tz1.toZoneId());
			DateTimeFormatter formatter2 = DateTimeFormatter.ISO_ZONED_DATE_TIME;
			formatter2 = formatter2.withZone(tz2.toZoneId());
			
			//test with default time zone
			if (!Util.isEmpty(currentTimeZone, true)) {
				clientInfo.setTimeZone(null);
				clientInfo.saveEx();
				CacheMgt.get().reset();
			}			
			MScheduler scheduler1 = new MScheduler(Env.getCtx(), 0, getTrxName());
			scheduler1.setAD_Process_ID(121); //Open Orders Process Id
			scheduler1.setAD_Schedule_ID(schedule.get_ID());
			scheduler1.setName("Cron Scheduler Test 1");
			scheduler1.setSupervisor_ID(100);
			scheduler1.saveEx();
			
			Timestamp ts1 = scheduler1.getDateNextRun();
			assertEquals(formatter1.format(cal1.getTime().toInstant()), formatter1.format(ts1.toInstant()), "Un-expected date next run");
			assertFalse(cal2.getTimeInMillis() == ts1.getTime(), "Un-expected date next run");
			
			//test with default + 2hour time zone
			clientInfo.setTimeZone(tz2.toZoneId().getId());
			clientInfo.saveEx();
			CacheMgt.get().reset();
			
			MScheduler scheduler2 = new MScheduler(Env.getCtx(), 0, getTrxName());
			scheduler2.setAD_Process_ID(121);
			scheduler2.setAD_Schedule_ID(schedule.get_ID());
			scheduler2.setName("Cron Scheduler Test 2");
			scheduler2.setSupervisor_ID(100);
			scheduler2.saveEx();
			
			Timestamp ts2 = scheduler2.getDateNextRun();
			assertEquals(formatter2.format(cal2.getTime().toInstant()), formatter2.format(ts2.toInstant()), "Un-expected date next run");
			assertFalse(cal1.getTimeInMillis() == ts2.getTime(), "Un-expected date next run");
		} finally {
			rollback();
			if (schedule != null && schedule.get_ID() > 0)
				schedule.deleteEx(true);
			clientInfo.setTimeZone(currentTimeZone);
			if (clientInfo.is_Changed()) {
				clientInfo.saveEx();
				CacheMgt.get().reset();
			}
		}
	}
}
